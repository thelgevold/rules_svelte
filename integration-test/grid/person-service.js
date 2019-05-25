export class Column {
  constructor(name, descr) {
    this.name = name;
    this.descr = descr;
  }
}

export class PersonService {
  getPeople() {
    return [
      { firstName: "Joe", lastName: "Jackson", age: 20 },
      { firstName: "Peter", lastName: "Smith", age: 30 },
      { firstName: "Jane", lastName: "Doe", age: 50 },
      { firstName: "Tim", lastName: "Smith", age: 80 }
    ];
  }
  getColumns() {
    return [
      new Column("firstName", "First Name"),
      new Column("lastName", "Last Name"),
      new Column("age", "Age")
    ];
  }
}
