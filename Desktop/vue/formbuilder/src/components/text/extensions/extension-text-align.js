'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var core = require('@tiptap/core');
require('@tiptap/extension-text-style');

const TextAlign = core.Extension.create({
    name: 'TextAlign',
    defaultOptions: {
        types: ['textStyle'],
    },
    addGlobalAttributes() {
        return [
            {
                types: this.options.types,
                attributes: {
                    textAlign: {
                        default: null,
                        parseHTML: element => element.style.textAlign.replace(/['"]+/g, ''),
                        renderHTML: attributes => {
                            if (!attributes.textAlign) {
                                return {};
                            }
                            return {
                                style: `text-align:${attributes.textAlign};`,
                            };
                        },
                    },
                },
            },
        ];
    },
    addCommands() {
        return {
            setTextAlign: textAlign => ({ chain }) => {
                return chain()
                    .setMark('textStyle', { textAlign })
                    .run();
            },
            unsetTextAlign: () => ({ chain }) => {
                return chain()
                    .setMark('textStyle', { textAlign: null })
                    .removeEmptyTextStyle()
                    .run();
            },
        };
    },
});

exports.TextAlign = TextAlign;
exports['default'] = TextAlign;