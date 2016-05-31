using System;
using System.Data;
using System.Data.Entity;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;
using Project.MSH.BEL.Entity;
using System.Linq;
using Project.MSH.DAL.Context;

namespace Project.MSH.Test
{
    [TestClass]
    public class UnitTest1
    {
        private string strConnection = "User Id=postgres;Server=localhost;Password=admin123;Database=db_mhs;";
        [TestMethod, Ignore]
        public void deveria_conectar_no_banco_de_dados()
        {
            try
            {
                // arrange:
                var conexao = false;
                var query = new List<Empresa>();
                using (var ctx = new DAL.Context.DbContextModel())
                //using (var ctx = new Npgsql.NpgsqlConnection(strConnection))
                {
                    //var l = ctx.Database;
                    conexao = ctx.Database.Exists();
                    query = (
                        from t in ctx.Empresa
                        select t
                    ).ToList();
                }
                // act:

                // asset:
                Assert.AreEqual(0, query.Count, "Não existe registro na tabela empresa");
                Assert.IsTrue(conexao, "Não existe o banco de dados");
            }
            catch (Exception e)
            {
                Assert.Fail(e.Message);
                throw e;
            }
            
        }

        [TestMethod]
        public void deveria_trazer_pessoas()
        {
            try
            {
                // arrange:
                var conexao = false;
                var query = new List<Pessoa>();
                using (var ctx = new DbContextModel())
                {
                    //var l = ctx.Database;
                    conexao = ctx.Database.Exists();
                    query = (
                        from t in ctx.Pessoas
                        select t
                    ).ToList();
                }
                // act:

                // asset:
                Assert.AreNotEqual(0, query.Count, "Não existe registro na tabela pessoa");
            }
            catch (Exception e)
            {
                Assert.Fail(e.Message);
                throw e;
            }
        }
    }
}
