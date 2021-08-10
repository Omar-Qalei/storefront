// export async function execCommandStyle(action, containers) {
//     const selection = await getSelection();
//     if (!selection) {
//         return;
//     }
//     const anchorNode = selection.anchorNode;

//     if (!anchorNode) {
//         return;
//     }
//     const containert =
//         anchorNode.nodeType !== Node.TEXT_NODE
//             && anchorNode.nodeType !== Node.COMMENT_NODE ?
//             (anchorNode) : anchorNode.parentElement;
//     // TODO: next chapter
// }
// async function getSelection() {
//     if (window && window.getSelection) {
//         return window.getSelection();
//     } else if (document && document.getSelection) {
//         return document.getSelection();
//     } else if (document && (document).selection) {
//         return (document).selection.createRange().text;
//     }

//     return null;
// }
// const sameSelection = 
//       container && container.innerText === selection.toString();

// if (sameSelection && 
//   !isContainer(containers, container) 
//   && container.style[action.style] !== undefined) {

//     await updateSelection(container, action, containers);

//     return;
// }

// await replaceSelection(container, action, selection, containers);

// async function getStyleValue(container, action, containers) {
//     if (!container) {
//         return action.value;
//     }

//     if (await action.initial(container)) {
//         return 'initial';
//     }

//     const style =
//         await findStyleNode(container, action.style, containers);

//     if (await action.initial(style)) {
//         return 'initial';
//     }

//     return action.value;
// }
// async function cleanChildren(action, span) {
//     if (!span.hasChildNodes()) {
//         return;
//     }

//     // Clean direct (> *) children with same style
//     const children =
//         Array.from(span.children)
//             .filter((element) => {
//                 return element.style[action.style] !== undefined &&
//                     element.style[action.style] !== '';
//             });

//     if (children && children.length > 0) {
//         children.forEach((element) => {
//             element.style[action.style] = '';

//             if (element.getAttribute('style') === '' ||
//                 element.style === null) {
//                 element.removeAttribute('style');
//             }
//         });
//     }

//     // Direct children (> *) may have children (*) to be clean too
//     const cleanChildrenChildren =
//         Array.from(span.children).map((element) => {
//             return cleanChildren(action, element);
//         });

//     if (!cleanChildrenChildren || cleanChildrenChildren.length <= 0) {
//         return;
//     }

//     await Promise.all(cleanChildrenChildren);
// }

// async function replaceSelection(container,
//     action,
//     selection,
//     containers) {
//     const range = selection.getRangeAt(0);

//     const fragment = range.extractContents();

//     const span =
//         await createSpan(container, action, containers);
//     span.appendChild(fragment);

//     await cleanChildren(action, span);
//     await flattenChildren(action, span);

//     range.insertNode(span);
//     selection.selectAllChildren(span);
// }

// async function createSpan(container,
//     action,
//     containers) {
//     const span = document.createElement('span');
//     span.style[action.style] =
//         await getStyleValue(container, action, containers);

//     return span;
// }

// async function flattenChildren(action,
//     span) {
//     if (!span.hasChildNodes()) {
//         return;
//     }

//     // Flatten direct (> *) children with no style
//     const children =
//         Array.from(span.children).filter((element) => {
//             const style = element.getAttribute('style');
//             return !style || style === '';
//         });

//     if (children && children.length > 0) {
//         children.forEach((element) => {
//             const styledChildren =
//                 element.querySelectorAll('[style]');
//             if (!styledChildren || styledChildren.length === 0) {
//                 const text =
//                     document.createTextNode(element.textContent);
//                 element.parentElement.replaceChild(text, element);
//             }
//         });

//         return;
//     }

//     // Direct children (> *) may have children (*) to flatten too
//     const flattenChildrenChildren =
//         Array.from(span.children).map((element) => {
//             return flattenChildren(action, element);
//         });

//     if (!flattenChildrenChildren ||
//         flattenChildrenChildren.length <= 0) {
//         return;
//     }

//     await Promise.all(flattenChildrenChildren);
// }
