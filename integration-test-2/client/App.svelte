<script>
	import uniq from 'lodash/uniq';
	
	const numbers = [1, 5, 5, 5, 1, 1, 15, 15, 15];

  const uniqNumbers = uniq(numbers);
</script>

<h4>Unique Numbers from lodash</h4>
<ul class="unique-numbers">
	{#each uniqNumbers as num}
		<li>{ num }</li>
	{/each}
</ul>