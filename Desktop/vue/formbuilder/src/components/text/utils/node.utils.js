import { InlineEditorUtils } from './inline-editor.utils'

export const findStyleNode = async (node, style, containers) => {
    // Just in case
    if (node.nodeName.toUpperCase() === 'HTML' || node.nodeName.toUpperCase() === 'BODY') {
        return null;
    }

    if (!node.parentNode) {
        return null;
    }

    if (InlineEditorUtils.isContainer(containers, node)) {
        return null;
    }

    const hasStyle =
        (node).style[style] !== null && (node).style[style] !== undefined && (node).style[style] !== '';

    if (hasStyle) {
        return node;
    }

    return await findStyleNode(node.parentNode, style, containers);
};

export const getAnchorNode = (selection) => {
    const anchorNode = selection.anchorNode;
    if (!anchorNode) {
        return undefined;
    }
    return anchorNode.nodeType !== Node.TEXT_NODE && anchorNode.nodeType !== Node.COMMENT_NODE ? anchorNode : anchorNode.parentElement
}