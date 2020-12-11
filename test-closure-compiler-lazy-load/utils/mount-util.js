const replaceContainer = function ( Component, options ) {
  const frag = document.createDocumentFragment();
  const component = new Component( Object.assign( {}, options, { target: frag } ));

  options.target.innerHTML = '';
  options.target.appendChild(frag);

  return component;
}

function mountComponent(component) {
  replaceContainer(component, {target: document.querySelector('#router-outlet')});
}

export default mountComponent;