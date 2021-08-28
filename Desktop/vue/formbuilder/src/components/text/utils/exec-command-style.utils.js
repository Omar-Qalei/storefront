import getAnchorNode from './node.utils';
import findStyleNode from './node.utils';
import { InlineEditorUtils } from './inline-editor.utils';

export async function execCommandStyle(selection, action, containers) {
    debugger
    const container = getAnchorNode(selection);

    if (!container) {
        return;
    }

    const sameSelection = container && container.innerText === selection.toString();

    if (sameSelection && !InlineEditorUtils.isContainer(containers, container) && container.style[action.style] !== undefined) {
        await updateSelection(container, action, containers);

        return;
    }

    await replaceSelection(container, action, selection, containers);
}

async function updateSelection(container, action, containers) {
    container.style[action.style] = await getStyleValue(container, action, containers);

    await cleanChildren(action, container);
}

async function replaceSelection(container, action, selection, containers) {
    const range = selection.getRangeAt(0);

    // User selected a all list?
    if (range.commonAncestorContainer && ['ol', 'ul', 'dl'].some((listType) => listType === range.commonAncestorContainer.nodeName.toLowerCase())) {
        await updateSelection(range.commonAncestorContainer, action, containers);
        return;
    }

    const fragment = range.extractContents();

    const span = await createSpan(container, action, containers);
    span.appendChild(fragment);

    await cleanChildren(action, span);
    await flattenChildren(action, span);

    range.insertNode(span);
    selection.selectAllChildren(span);
}

async function cleanChildren(action, span) {
    if (!span.hasChildNodes()) {
        return;
    }

    // Clean direct (> *) children with same style
    const children = Array.from(span.children).filter((element) => {
        return element.style[action.style] !== undefined && element.style[action.style] !== '';
    });

    if (children && children.length > 0) {
        children.forEach((element) => {
            element.style[action.style] = '';

            if (element.getAttribute('style') === '' || element.style === null) {
                element.removeAttribute('style');
            }
        });
    }

    // Direct children (> *) may have children (*) which need to be cleaned too
    const cleanChildrenChildren = Array.from(span.children).map((element) => {
        return cleanChildren(action, element);
    });

    if (!cleanChildrenChildren || cleanChildrenChildren.length <= 0) {
        return;
    }

    await Promise.all(cleanChildrenChildren);
}

async function createSpan(container, action, containers) {
    const span = document.createElement('span');
    span.style[action.style] = await getStyleValue(container, action, containers);

    return span;
}

// We assume that if the same style is applied, user want actually to remove it (same behavior as in MS Word)
// Note: initial may have no effect on the background-color
async function getStyleValue(container, action, containers) {
    if (!container) {
        return action.value;
    }

    if (await action.initial(container)) {
        return 'initial';
    }

    const style = await findStyleNode(container, action.style, containers);

    if (await action.initial(style)) {
        return 'initial';
    }

    return action.value;
}

// We try to not keep <span/> in the tree if we can use text
async function flattenChildren(action, span) {
    if (!span.hasChildNodes()) {
        return;
    }

    // Flatten direct (> *) children with no style
    const children = Array.from(span.children).filter((element) => {
        const style = element.getAttribute('style');
        return !style || style === '';
    });

    if (children && children.length > 0) {
        children.forEach((element) => {
            // Can only be flattened if there is no other style applied to a children, like a color to part of a text with a background
            const styledChildren = element.querySelectorAll('[style]');
            if (!styledChildren || styledChildren.length === 0) {
                const text = document.createTextNode(element.textContent);
                element.parentElement.replaceChild(text, element);
            }
        });

        return;
    }

    // Direct children (> *) may have children (*) which need to be flattened too
    const flattenChildrenChildren = Array.from(span.children).map((element) => {
        return flattenChildren(action, element);
    });

    if (!flattenChildrenChildren || flattenChildrenChildren.length <= 0) {
        return;
    }

    await Promise.all(flattenChildrenChildren);
}