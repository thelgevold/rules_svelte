import Friends from './Route1.svelte.js';

import mountComponent from '../utils/mount-util';

export const COMPONENT_LOADER = {load: () => {mountComponent(Friends)}};

window['route1'] = COMPONENT_LOADER.load;