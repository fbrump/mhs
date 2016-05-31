using Project.MSH.BEL.Entity;
using Project.MSH.DAL.Mapping;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Project.MSH.DAL.Context
{
    [DbConfigurationType(typeof(MySql.Data.Entity.MySqlEFConfiguration))]
    public class DbContextModel : DbContext
    {
        #region [ CONSTURCTOR ]
        public DbContextModel() : this("DbContextModel") { }
        public DbContextModel(string connStringName) : base(connStringName) { }
        static DbContextModel()
        {
            // static constructors are guaranteed to only fire once per application.
            // I do this here instead of App_Start so I can avoid including EF
            // in my MVC project (I use UnitOfWork/Repository pattern instead)
            DbConfiguration.SetConfiguration(new MySql.Data.Entity.MySqlEFConfiguration());
        }

        #endregion

        #region [ TABLES]
        public DbSet<Pessoa> Pessoas { get; set; }
        public IDbSet<Empresa> Empresa { get; set; }
        #endregion

        #region [ METHODS ]
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            // I have an abstract base EntityMap class that maps Ids for my entities.
            // It is used as the base for all my class mappings

            // MAPPING
            modelBuilder.Configurations.Add(new PessoaMap());
            modelBuilder.Configurations.Add(new EmpresaMap());

            //modelBuilder.Configurations.AddFromAssembly(typeof(EntityMap<>).Assembly);
            base.OnModelCreating(modelBuilder);
        }
        #endregion
    }
}
