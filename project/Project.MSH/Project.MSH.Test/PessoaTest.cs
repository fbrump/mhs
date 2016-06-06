using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Project.MSH.BEL.Entity;
using System.Collections.Generic;
using Project.MSH.DAL.Context;
using System.Linq;

namespace Project.MSH.Test
{
    [TestClass]
    public class PessoaTest
    {
        [TestMethod]
        public void should_select_all_people()
        {
            try
            {
                // arrange:
                var conexao = false;
                var query = Enumerable.Empty<Pessoa>();
                DAL.Interface.IPessoaRepository rep = new DAL.Repository.PessoaRepository();
                //using (var ctx = new DbContextModel())
                //{
                //    //var l = ctx.Database;
                //    conexao = ctx.Database.Exists();
                //    query = (
                //        from t in ctx.Pessoas
                //        select t
                //    ).ToList();
                //}
                // act:
                query = rep.GetAll();

                // asset:
                Assert.AreNotEqual(0, query.Count(), "Not exists register on the database");
            }
            catch (Exception e)
            {
                Assert.Fail(e.Message);
                throw e;
            }
        }

        [TestMethod]
        public void shold_get_person_by_id()
        {
            try
            {
                // arrange:
                var item = new Pessoa();
                DAL.Interface.IPessoaRepository rep = new DAL.Repository.PessoaRepository();
                item.id = 3;
                item.nome = "Rafael";
                // act:
                var countOld = rep.GetAll().Count();
                var result = rep.GetById(t => t.id == item.id);

                // asset:
                Assert.IsNotNull(result, "Not existe item with this ID");
                Assert.AreEqual(result.nome, result.nome, "The register not is " + item.nome);
            }
            catch (Exception e)
            {
                Assert.Fail(e.Message);
                throw e;
            }
        }

        [TestMethod]
        public void should_select_all_people_with_birth_date_above()
        {
            try
            {
                // arrange:
                var filter = new Pessoa();
                var query = Enumerable.Empty<Pessoa>();
                DAL.Interface.IPessoaRepository rep = new DAL.Repository.PessoaRepository();
                filter.dataNascimento = new DateTime(1990, 1, 1);

                // act:
                query = rep.GetAll(t => t.dataNascimento.Year >= filter.dataNascimento.Year);

                // asset:
                Assert.AreNotEqual(0, query.Count(), "Not exists register on the database");
                Assert.AreEqual(2, query.Count(), "Not exists register on the database with date of birth above " + filter.dataNascimento.Year.ToString());
            }
            catch (Exception e)
            {
                Assert.Fail(e.Message);
                throw e;
            }
        }

        [TestMethod, Ignore]
        public void shold_insert_new_person() {
            try
            {
                // arrange:
                var item = new Pessoa();
                DAL.Interface.IPessoaRepository rep = new DAL.Repository.PessoaRepository();

                // act:
                rep.Insert(item);

                // asset:
                //Assert.AreEqual(countOld + 1, countOld, "Not inserted new item on database.");
            }
            catch (Exception e)
            {
                Assert.Fail(e.Message);
                throw e;
            }
        }
    }
}
