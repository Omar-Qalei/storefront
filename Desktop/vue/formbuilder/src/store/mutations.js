import * as layout from './mutations/layout'
import * as section from './mutations/section'
import * as settings from './mutations/settings'
import * as auth from './mutations/auth'
import * as preview from './mutations/preview'

export default {
   ...layout, ...section, ...settings, ...auth, ...preview
}