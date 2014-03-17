using System;
using System.IO;
using System.Reflection;
using System.Data.Linq;


namespace MegaSample
{
	class MegaSample
	{
		public static void Main(string[] args) {
			try {
				string path = AppDomain.CurrentDomain.BaseDirectory;
				string tempPath = Path.Combine(path, "Temp");
				
				string dbPath = Path.Combine(tempPath, "PeopleDb.mdf");
				Database db = new Database();
				db.CreateDatabase(dbPath);
				
				db.ImportDataFromZipFile("gnutt.zip");
				
			}
			catch (Exception e)
			{
				Console.WriteLine(e.Message);
			}
		}
	}
}