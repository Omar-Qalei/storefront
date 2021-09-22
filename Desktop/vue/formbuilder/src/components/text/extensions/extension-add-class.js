'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var core = require('@tiptap/core');
require('@tiptap/extension-text-style');

const AddClass = core.Extension.create({
    name: 'addClass',
    defaultOptions: {
        types: ['textStyle'],
    },
    addGlobalAttributes() {
        return [
            {
                types: this.options.types,
                attributes: {
                    addClass: {
                        default: null,
                        parseHTML: element => element.style.addClass.replace(/['"]+/g, ''),
                        renderHTML: attributes => {
                            if (!attributes.addClass) {
                                return {};
                            }
                            return {
                                class: `${attributes.addClass}`,
                            };
                        },
                    },
                },
            },
        ];
    },
    addCommands() {
        return {
            setAddClass: addClass => ({ chain }) => {
                return chain()
                    .setMark('textStyle', { addClass })
                    .run();
            },
            unsetAddClass: () => ({ chain }) => {
                return chain()
                    .setMark('textStyle', { addClass: null })
                    .removeEmptyTextStyle()
                    .run();
            },
        };
    },
});

exports.AddClass = AddClass;
exports['default'] = AddClass;