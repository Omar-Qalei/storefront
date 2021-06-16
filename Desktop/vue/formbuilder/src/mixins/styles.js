export default {
    methods: {
        convertPxToNumber: function (value) {
            return +value.split("px")[0];
        },
        findIndex({ list, value }, currentValue) {
            return list.findIndex(element => element[value] === currentValue);
        }
    }
}