using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Npgsql;
using Project.MSH.BEL.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;

namespace Project.MSH.DAL.Context
{
    public class DbContextModel : DbContext
    {
        #region [ Construtor ]

        public DbContextModel()
            : base("DbContextModel")
        { }

        public DbContextModel(string pStringConnection)
            : base(pStringConnection)
        { }

        #endregion


        #region [ Propriedades ]

        public IDbSet<Empresa> Empresa { get; set; }

        #endregion

        #region [ Métodos ]
        
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Conventions.Remove<PluralizingTableNameConvention>();
            //modelBuilder.HasDefaultSchema("public");

            modelBuilder.Entity<Empresa>();//.ToTable("tb_empresa", "public");
            modelBuilder.Entity<Empresa>().HasKey(t => t.id);
            modelBuilder.Entity<Empresa>().Property(t => t.nm_empresa).HasMaxLength(300).IsRequired();//.HasColumnName("nm_empresa").HasMaxLength(300).IsRequired();
            modelBuilder.Entity<Empresa>().Property(t => t.nm_fantasia);//.HasMaxLength(500).IsRequired(false);//.HasColumnName("nm_fantasia").HasMaxLength(500).IsRequired(false);


            base.OnModelCreating(modelBuilder);
        }

        #endregion
    }
}
