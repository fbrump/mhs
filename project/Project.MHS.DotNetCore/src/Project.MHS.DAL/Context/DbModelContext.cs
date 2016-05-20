using Microsoft.Data.Entity;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Configuration.Memory;
using Project.MHS.BE.Entity;
using System.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
//using Microsoft.AspNet.Builder;
//using Microsoft.AspNet.Hosting;
//using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;


namespace Project.MHS.DAL.Context
{
    /// <summary>
    /// Contexto com a conexão com o banco de dados PostgreSQL
    /// </summary>
    public class DbModelContext : DbContext
    {
        public IConfigurationRoot Configuration { get; set; }


        #region [ Propreidades Entity]

        /// <summary>
        /// Tabela tb_empresa
        /// </summary>
        public DbSet<Empresa> Empresa { get; set; }

        #endregion

        public DbModelContext()
            : base()
        {

        }

        #region [ Métodos ]

        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.Entity<Empresa>();//.ToTable("tb_empresa", "public");
            builder.Entity<Empresa>().HasKey(t => t.id);
            builder.Entity<Empresa>().Property(t => t.nm_empresa).HasMaxLength(300).IsRequired();//.HasColumnName("nm_empresa").HasMaxLength(300).IsRequired();
            builder.Entity<Empresa>().Property(t => t.nm_fantasia);//.HasMaxLength(500).IsRequired(false);//.HasColumnName("nm_fantasia").HasMaxLength(500).IsRequired(false);

            base.OnModelCreating(builder);
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionBuilder)
        {
            var builder = new ConfigurationBuilder()
                .AddJsonFile("../appsettings.json")
                .AddEnvironmentVariables();
            var configuration = builder.Build();

            var sqlConnectionString =
               configuration["DefaultConnection:ConnectionString"];

            //optionBuilder.UseNpgsql(sqlConnectionString);

            //optionBuilder.UseNpgsql("User Id=postgres;Host=192.168.0.2;Database=db_mhs;Persist Security Info=False");

            //var connString = Configuration["Data:DbModelContext:ConnectionString"];

            //services.AddEntityFramework()
            //    .AddSqlServer()
            //    .AddDbContext<ApplicationDbContext>(options => options.UseSqlServer(Configuration["Data:DefaultConnection:ConnectionString"]));

            //// assumes using Microsoft.Framework.ConfigurationModel is specified
            //var builder = new ConfigurationBuilder();
            //builder.Add(new MemoryConfigurationProvider());
            //var config = builder.Build();
            ////config.Set("somekey", "somevalue");

            //// do some other work

            //string setting2 = config["Data.DbModelContext.ConnectionString"]; // also returns "somevalue"

            //optionBuilder.UseNpgsql(Configuration["Data:DbModelContext:ConnectionString"]);
        }

        public override int SaveChanges()
        {
            ChangeTracker.DetectChanges();
            
            return base.SaveChanges();
        }

        #endregion

        #region [ Métodos Privados ]

        //private void updateUpdatedProperty<T>() where T : class
        //{
        //    var modifiedSourceInfo =
        //        ChangeTracker.Entries<T>()
        //            .Where(t => t.State == EntityState.Added || t.State == EntityState.Modified);

        //    foreach (var item in modifiedSourceInfo)
        //    {
        //        item.Property()
        //    }
        //}

        #endregion

    }
}
