using System;
using System.Data.Linq;
using System.Data.Linq.Mapping;

namespace MegaSample
{
	public class Database
	{
		public void CreateDatabase(string path)
		{
				PeopleDb db = new PeopleDb(path);
				if(!db.DatabaseExists())
				{
					db.CreateDatabase();
				}
		}

		public void ImportDataFromZipFile(string zipFileName)
		{
			Console.WriteLine("zipFileName: " + zipFileName);
		}

		public void QueryData()
		{

		}
	}	

	public class PeopleDb : DataContext
	{
	    public Table<Person> People;
	    public PeopleDb(string connection) : base(connection) { }
	}

	[Table(Name = "Person")]
	public class Person
	{
	    [Column(IsPrimaryKey = true)]
	    public int Id;
	    [Column]
	    public string Name;
	}

}