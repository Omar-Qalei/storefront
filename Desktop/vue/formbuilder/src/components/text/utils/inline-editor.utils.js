/* eslint-disable no-async-promise-executor */
export class ContentAlign {
    static LEFT = 'left';
    static CENTER = 'center';
    static RIGHT = 'right';
}

export function isRTL() {
    return false;
}

export class InlineEditorUtils {
    static isContainer(containers, element) {
        const containerTypes = containers.toLowerCase().split(',');
        return element && element.nodeName && containerTypes.indexOf(element.nodeName.toLowerCase()) > -1;
    }
    static findContainer(containers, element) {
        return new Promise < HTMLElement > (async (resolve) => {
            if (!element) {
                resolve(undefined);
                return;
            }

            if (element.nodeName.toUpperCase() === 'HTML' || element.nodeName.toUpperCase() === 'BODY' || !element.parentElement) {
                resolve(undefined);
                return;
            }

            if (InlineEditorUtils.isContainer(containers, element)) {
                resolve(element);
            } else {
                const container = await this.findContainer(containers, element.parentElement);

                resolve(container);
            }
        });
    }
    static async getContentAlignment(element) {
        const style = window.getComputedStyle(element);

        if (style.textAlign === 'center') {
            return ContentAlign.CENTER;
        } else if (style.textAlign === 'right') {
            return ContentAlign.RIGHT;
        } else if (style.textAlign === 'left') {
            return ContentAlign.LEFT;
        }

        return isRTL() ? ContentAlign.RIGHT : ContentAlign.LEFT;
    }

    static async getBold(element) {
        if (await this.isTag(element, 'b')) {
            return 'bold';
        }

        if (await this.isTag(element, 'strong')) {
            return 'bold';
        }

        return element.style.fontWeight === 'bold' ? 'bold' : element.style.fontWeight === 'initial' ? 'initial' : undefined;
    }

    static async getItalic(element) {
        if (await this.isTag(element, 'i')) {
            return 'italic';
        }

        if (await this.isTag(element, 'em')) {
            return 'italic';
        }

        if (element.style.fontStyle === 'italic') {
            return 'italic';
        }

        if (element.style.fontStyle === 'initial') {
            return 'initial';
        }

        if (!element.hasChildNodes()) {
            return undefined;
        }

        const children = element.children;
        if (children && children.length > 0) {
            const selectedChild = Array.from(children).find((child) => {
                return child.style.fontStyle === 'italic' || child.style.fontStyle === 'initial';
            });

            if (selectedChild) {
                return selectedChild.style.fontStyle === 'italic' ? 'italic' : 'initial';
            }
        }

        return undefined;
    }

    static async getUnderline(element) {
        if (await this.isTag(element, 'u')) {
            return 'underline';
        }

        if (element.style.textDecoration?.indexOf('underline') > -1 || element.style.textDecorationLine?.indexOf('underline') > -1) {
            return 'underline';
        }

        if (element.style.textDecoration?.indexOf('initial') > -1 || element.style.textDecorationLine?.indexOf('initial') > -1) {
            return 'initial';
        }

        if (!element.hasChildNodes()) {
            return undefined;
        }

        const children = element.children;
        if (children && children.length > 0) {
            const selectedChild = Array.from(children).find((child) => {
                return (
                    child.style.textDecoration?.indexOf('underline') > -1 ||
                    child.style.textDecorationLine?.indexOf('underline') > -1 ||
                    child.style.textDecorationLine?.indexOf('initial') > -1
                );
            });

            if (selectedChild) {
                return selectedChild.style.fontStyle?.indexOf('underline') > -1 ? 'underline' : 'initial';
            }
        }

        return undefined;
    }

    static async getStrikeThrough(element) {
        if (await this.isTag(element, 'strike')) {
            return 'strikethrough';
        }

        if (element.style.textDecoration?.indexOf('line-through') > -1 || element.style.textDecorationLine?.indexOf('line-through') > -1) {
            return 'strikethrough';
        }

        if (element.style.textDecoration?.indexOf('initial') > -1 || element.style.textDecorationLine?.indexOf('initial') > -1) {
            return 'initial';
        }

        if (!element.hasChildNodes()) {
            return undefined;
        }

        const children = element.children;
        if (children && children.length > 0) {
            const selectedChild = Array.from(children).find((child) => {
                return (
                    child.style.textDecoration?.indexOf('line-through') > -1 ||
                    child.style.textDecorationLine?.indexOf('line-through') > -1 ||
                    child.style.textDecorationLine?.indexOf('initial') > -1
                );
            });

            if (selectedChild) {
                return selectedChild.style.fontStyle?.indexOf('line-through') > -1 ? 'strikethrough' : 'initial';
            }
        }

        return undefined;
    }

    static async isTag(element, tagName) {
        if (!element) {
            return false;
        }

        if (element.nodeName.toLowerCase() === tagName) {
            return true;
        }

        if (element.hasChildNodes()) {
            const children = element.getElementsByTagName(tagName);
            return children && children.length > 0;
        }

        return false;
    }

    static async getFontSize(element) {
        if (!element || !element.hasAttribute('size')) {
            return undefined;
        }

        return element.getAttribute('size');
    }
}