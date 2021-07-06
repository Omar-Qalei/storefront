export const onDrawer = ({ commit }) => {
    commit('setDrawer')
}

export const onDrawerPages = ({ commit }, payload) => {
    commit('setDrawerPages', payload)
}

export const fetchPages = ({ commit }, payload) => {
    commit('setPages', payload)
}

export const onSelectedPage = ({ commit }, payload) => {
    commit('setSelectedPage', payload)
}

export const onLoadingPage = ({ commit }, payload) => {
    commit('setLoadingPage', payload)
}
export const onBuildProduct = () => {
    var exec = require("child_process").exec;
    exec("npm build", function (err, stdout, stderr) {
        if (err) {
            console.log(err);
            // handle error
        }
        console.log(stdout, stderr);
    });
}