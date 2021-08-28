import execCommandStyle from './exec-command-style.utils';
export async function execCommand(selection, action, containers) {
    console.log('selection: ', selection, 'action: ', action, 'containers: ', containers)
    if (!document || !selection) {
        return;
    }

    if (action.cmd === 'style') await execCommandStyle(selection, action.detail, containers)
}