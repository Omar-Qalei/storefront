
export class FontSize {
    static X_SMALL = '1';
    static SMALL = '2';
    static MEDIUM = '3';
    static LARGE = '4';
    static X_LARGE = '5';
    static XX_LARGE = '6';
    static XXX_LARGE = '7';
}


export class ContentAlign {
    static LEFT = 'left';
    static CENTER = 'center';
    static RIGHT = 'right';
}

export const execCommandNative = (action) => {
    // if (action.cmd === 'style') {
    //     execCommandNativeStyle(action);
    // } else if (action.cmd === 'list') {
    //     execCommandNativeList(action);
    // }

    execCommandNativeStyle(action);
}

const execCommandNativeStyle = (action) => {
    const detail = action.detail;

    // @ts-ignore
    document.execCommand("styleWithCSS", false, true);

    switch (detail.style) {
        case 'color':
            document.execCommand('foreColor', false, detail.value);
            break;
        case 'background-color':
            document.execCommand('backColor', false, detail.value);
            break;
        case 'font-size':
            document.execCommand('fontSize', false, FontSize[detail.value.replace('-', '_').toUpperCase()]);
            break;
        case 'font-weight':
            document.execCommand('bold', false, null);
            break;
        case 'font-style':
            document.execCommand('italic', false, null);
            break;
        case 'text-decoration':
            document.execCommand(detail.value === 'line-through' ? 'strikeThrough' : 'underline', false, null);
            break;
    }
}

// const execCommandNativeList = (action) => {
//     const detail = action.detail;

//     switch (detail.type) {
//         case 'ol':
//             document.execCommand('insertOrderedList', false, null);
//             break;
//         case 'ul':
//             document.execCommand('insertUnorderedList', false, null);
//             break;
//     }
// }

export const execCommandNativeAlign = (align) => {
    switch (align) {
        case ContentAlign.CENTER:
            document.execCommand('justifyCenter', false, null);
            break;
        case ContentAlign.RIGHT:
            document.execCommand('justifyRight', false, null);
            break;
        default:
            document.execCommand('justifyLeft', false, null);
    }
}
