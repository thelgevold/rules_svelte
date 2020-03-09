<script>
  import { onMount } from 'svelte';
  import {PersonService} from './person-service';

  let personService = new PersonService();
  let rows = personService.getPeople();
  let columns = personService.getColumns();
  let title = '';

  onMount(async () => {
	  title = 'Grid';
	});

</script>

<div class="row grid">
  { title }
  <div class="col-md-6">
    <table class="table table-striped">
       <thead> 
          <tr>
              {#each columns as col}
                <td>{col.descr}</td>
              {/each}
          </tr>
       </thead>
       
       <tbody>
          {#each rows as row} 
          <tr>
              <td>{row.firstName}</td>
              <td>{row.lastName}</td>
              <td>{row.age}</td>
          </tr>
          {/each}
       </tbody>
    </table>
  </div>
</div>

<style>
  thead {
    background: blue;
    color: white;
  }
</style>

