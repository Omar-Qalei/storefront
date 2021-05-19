import * as layout from './mutations/layout'
import * as section from './mutations/section'
import * as settings from './mutations/settings'

export default {
   ...layout, ...section, ...settings
}