import * as layout from './getters/layout'
import * as section from './getters/section'
import * as settings from './getters/settings'

export default {
    ...layout, ...section, ...settings
}