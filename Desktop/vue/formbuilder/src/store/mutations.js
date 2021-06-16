import * as layout from './mutations/layout'
import * as section from './mutations/section'
import * as settings from './mutations/settings'
import * as auth from './mutations/auth'

export default {
   ...layout, ...section, ...settings, ...auth
}