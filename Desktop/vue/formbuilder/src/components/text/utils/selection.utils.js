export const clearTheSelection = async () => {
    if (window && window.getSelection) {
        if (window.getSelection().empty) {
            window.getSelection().empty();
        } else if (window.getSelection().removeAllRanges) {
            window.getSelection().removeAllRanges();
        }
    } else if (document && (document).selection) {
        (document).selection.empty();
    }
};

export const getSelection = async () => {
    if (window && window.getSelection) {
        return window.getSelection();
    } else if (document && document.getSelection) {
        return document.getSelection();
    } else if (document && (document).selection) {
        return (document).selection.createRange().text;
    }

    return undefined;
}
