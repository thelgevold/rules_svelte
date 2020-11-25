<script>
	import { interval } from "rxjs";
	import { map, tap, take } from "rxjs/operators";

	import Component1 from './component1/Component1.svelte';
	import Component2 from './component2/Component2.svelte';
	import Component3 from './component3/Component3.svelte';
	import Component4 from './component4/Component4.svelte';
	import Component5 from './component5/Component5.svelte';
	import Component6 from './component6/Component6.svelte';
	import Component7 from './component7/Component7.svelte';
	import Component8 from './component8/Component8.svelte';
	import Component9 from './component9/Component9.svelte';
	import Component10 from './component10/Component10.svelte';
	import Component11 from './component11/Component11.svelte';
	import Component12 from './component12/Component12.svelte';
	import Component13 from './component12/Component13.svelte';
	import Component14 from './component12/Component14.svelte';
	import Component15 from './component12/Component15.svelte';
	import Component16 from './component12/Component16.svelte';
	import Component17 from './component12/Component17.svelte';
	import Component18 from './component12/Component18.svelte';
	import Component19 from './component12/Component19.svelte';
	import Component20 from './component12/Component20.svelte';
	import Component21 from './component12/Component21.svelte';
	import Component22 from './component12/Component22.svelte';
	import Component23 from './component12/Component23.svelte';
	import Component24 from './component12/Component24.svelte';
	import Component25 from './component12/Component25.svelte';
	import Component26 from './component12/Component26.svelte';
	import Component27 from './component12/Component27.svelte';
	import Component28 from './component12/Component28.svelte';
	import Component29 from './component12/Component29.svelte';
	import Component30 from './component12/Component30.svelte';
	import Component31 from './component12/Component31.svelte';
	import Component32 from './component12/Component32.svelte';
	import Component33 from './component12/Component33.svelte';
	import Component34 from './component12/Component34.svelte';
	import Component35 from './component12/Component35.svelte';
	import Component36 from './component12/Component36.svelte';
	import Component37 from './component12/Component37.svelte';
	import Component38 from './component12/Component38.svelte';
	import Component39 from './component12/Component39.svelte';
	import Component40 from './component12/Component40.svelte';
	import Component41 from './component12/Component41.svelte';
	import Component42 from './component12/Component42.svelte';
	import Component43 from './component12/Component43.svelte';
	import Component44 from './component12/Component44.svelte';
	import Component45 from './component12/Component45.svelte';
	import Component46 from './component12/Component46.svelte';
	import Component47 from './component12/Component47.svelte';
	import Component48 from './component12/Component48.svelte';
	import Component49 from './component12/Component49.svelte';
	import Component50 from './component12/Component50.svelte';

	let current = 0;

	interval(1000)
		.pipe(
			map((v) => v * 100),
			tap((v) => (current = v)),
			take(100)
		)
		.subscribe();
</script>

<h4>RxJs Interval</h4>
{current}

<Component1></Component1>
<Component2></Component2>
<Component3></Component3>
<Component4></Component4>
<Component5></Component5>
<Component6></Component6>
<Component7></Component7>
<Component8></Component8>
<Component9></Component9>
<Component10></Component10>
<Component11></Component11>
<Component12></Component12>
<Component13 />
<Component14 />
<Component15 />
<Component16 />
<Component17 />
<Component18 />
<Component19 />
<Component20 />
<Component21 />
<Component22 />
<Component23 />
<Component24 />
<Component25 />
<Component26 />
<Component27 />
<Component28 />
<Component29 />
<Component30 />
<Component31 />
<Component32 />
<Component33 />
<Component34 />
<Component35 />
<Component36 />
<Component37 />
<Component38 />
<Component39 />
<Component40 />
<Component41 />
<Component42 />
<Component43 />
<Component44 />
<Component45 />
<Component46 />
<Component47 />
<Component48 />
<Component49 />
<Component50 />

