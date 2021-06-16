import * as layout from './actions/layout'
import * as section from './actions/section'
import * as settings from './actions/settings'
import * as auth from './actions/auth'

export default {
    ...layout, ...section, ...settings, ...auth
}