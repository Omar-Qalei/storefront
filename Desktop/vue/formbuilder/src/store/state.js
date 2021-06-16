import layout from './states/layout'
import section from './states/section'
import settings from './states/settings'
import auth from './states/auth'

export default {
    ...layout, ...section, ...settings, ...auth
}