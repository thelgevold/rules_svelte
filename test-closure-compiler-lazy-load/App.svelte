<script>
  import page from 'page';
  import { onMount } from 'svelte';
  let activeRoute = {friends: 'active', form: 'inactive'};
  
  onMount(async () => {
    page('/', async () => navigate('route1').then(() => {resetNav(); activeRoute.friends = 'active'}));
    page('/route2', async () => navigate('route2').then(() => {resetNav(); activeRoute.form = 'active'}));
    page.start();
  });
  function resetNav() {
    for(let k in activeRoute) {
      activeRoute[k] = 'inactive';
    }
  }
  </script>
  
  <nav>
    <a class="{activeRoute.friends}" href="/">Friends</a>
    <a class="{activeRoute.form}" href="/route2">Form</a>
  </nav>
  
  <div id="router-outlet">
    <div></div>
  </div>
  