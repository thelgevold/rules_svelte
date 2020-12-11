import Friends from './Route2.svelte.js';

import mountComponent from '../utils/mount-util';

export const COMPONENT_LOADER = {load: () => {mountComponent(Friends)}};

window['route2'] = COMPONENT_LOADER.load;