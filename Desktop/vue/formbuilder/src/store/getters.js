import * as layout from './getters/layout'
import * as section from './getters/section'
import * as settings from './getters/settings'
import * as auth from './getters/auth'
import * as preview from './getters/preview'

export default {
    ...layout, ...section, ...settings, ...auth, ...preview
}