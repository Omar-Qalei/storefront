import * as layout from './getters/layout'
import * as section from './getters/section'
import * as settings from './getters/settings'
import * as auth from './getters/auth'

export default {
    ...layout, ...section, ...settings, ...auth
}