import layout from './states/layout'
import section from './states/section'
import settings from './states/settings'
import auth from './states/auth'
import preview from './states/preview'

export default {
    ...layout, ...section, ...settings, ...auth, ...preview
}