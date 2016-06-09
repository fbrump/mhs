using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Project.MSH.BEL.Entity;
using System.Collections.Generic;
using Project.MSH.DAL.Context;
using System.Linq;
using Project.MSH.DAL.Interface;
using Moq;
using System.Net.Http;
using System.Net;
using System.Runtime.Serialization;
using Newtonsoft.Json;
using System.Threading.Tasks;
using System.Globalization;

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
        public void should_get_person_by_id()
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
                //Assert.AreEqual(2, query.Count(), "Not exists register on the database with date of birth above " + filter.dataNascimento.Year.ToString());
            }
            catch (Exception e)
            {
                Assert.Fail(e.Message);
                throw e;
            }
        }

        [TestMethod]
        public void should_insert_new_person()
        {
            try
            {
                // arrange:
                Mock<IPessoaRepository> rep = new Mock<IPessoaRepository>();// DAL.Repository.PessoaRepository();
                rep.Setup(t => t.Insert(new Pessoa()));
                var item = new Pessoa();

                item.nome = "Carol";
                item.sobrenome = "Crews";
                item.dataNascimento = new DateTime(1977, 05, 24);

                // act:
                rep.Object.Insert(item);

                // asset:
                //Assert.AreNotEqual(item.id, 0, "The item note generate new id.");
            }
            catch (Exception e)
            {
                Assert.Fail(e.Message);
                throw e;
            }
        }

        [TestMethod]
        public void should_delete_person_by_id()
        {
            try
            {
                // arrange:
                Mock<IPessoaRepository> rep = new Mock<IPessoaRepository>();// DAL.Repository.PessoaRepository();
                rep.Setup(t => t.GetById(It.Is<System.Func<Pessoa, bool>>(p => p.Invoke(new Pessoa() { id = 7 }))))
                    .Returns(new Pessoa() { id = 7, nome = "Antonio", sobrenome = "da Silva", dataNascimento = new DateTime(1987, 11, 04) });
                var item = new Pessoa();

                item.id = 7;

                // act:
                item = rep.Object.GetById(t => t.id == item.id);
                rep.Object.Delete(item);
                //var result = rep.Object.GetById(t => t.id == item.id);
                // asset:
                //Assert.IsNotNull(result, "The item does note removed.");
            }
            catch (Exception e)
            {
                Assert.Fail(e.Message);
                throw e;
            }
        }

        [TestMethod]
        public void should_update_person_surname()
        {
            try
            {
                // arrange:
                var pessoaFake = new Pessoa() { id = 7, nome = "Antonio", sobrenome = "da Silva", dataNascimento = new DateTime(1987, 11, 04) };
                Mock<IPessoaRepository> rep = new Mock<IPessoaRepository>(); //DAL.Repository.PessoaRepository();
                rep.Setup(t => t.GetById(It.Is<System.Func<Pessoa, bool>>(p => p.Invoke(new Pessoa() { id = 7 }))))
                    .Returns(pessoaFake);
                rep.Setup(t => t.Update(pessoaFake)).Returns(new Pessoa() { id = 7, nome = "Antonio", sobrenome = "Crews Billson Jr." });
                var item = new Pessoa();

                item.id = 7;
                item.sobrenome = "Crews Billson Jr.";

                // act:
                var person = rep.Object.GetById(t => t.id == item.id);
                person.sobrenome = item.sobrenome;
                rep.Object.Update(person);

                // asset:
                Assert.AreEqual(item.sobrenome, person.sobrenome, "The person's surname not changed.");
            }
            catch (Exception e)
            {
                Assert.Fail(e.Message);
                throw e;
            }
        }

        [TestMethod, Ignore]
        public void should_inserts_generic_name_on_database()
        {
            try
            {
                System.Net.Http.HttpClient client = new System.Net.Http.HttpClient();
                Uri usuarioURI;
                client.BaseAddress = new Uri(@"http://api.randomuser.me/"); // new Uri(@"http://uinames.com/api/");
                client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));
                //client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.NameValueWithParametersHeaderValue("results", "50"));

                //
                System.Net.Http.HttpResponseMessage response = client.GetAsync("?results=50").Result;
                if (response.IsSuccessStatusCode)
                {
                    usuarioURI = response.Headers.Location;

                    var u = response.Content.ReadAsStreamAsync();

                }
            }
            catch (System.Net.Http.HttpRequestException eHttpReq)
            {
                throw eHttpReq;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        [TestMethod, Ignore]
        public void should_inserts_generic_name_on_database_others()
        {
            try
            {
                var lstPessoa = new List<Pessoa>();
                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(@"http://api.randomuser.me/");
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));

                    HttpResponseMessage response = client.GetAsync("?nat=BR&results=5000", HttpCompletionOption.ResponseContentRead).Result;
                    if (response.IsSuccessStatusCode)
                    {
                        var objsStream = response.Content.ReadAsStringAsync().Result;//.ReadAsStringAsync();//ReadAsAsunc<IEnumerable<Object>>().Result;
                        var arrString = objsStream.Split('[').ToArray()[1].Split(',');
                        var lst = new List<PessoaFake>();
                        PessoaFake item = null;
                        foreach (var itemJson in arrString)
                        {
                            var spl = itemJson.Split(':');
                            var key1 = spl[0].ToString().Replace("{", "").Replace("\"", "");
                            var val2 = spl[1].ToString().Replace("}", "").Replace("\"", "");

                            if (key1 == "gender")
                            {
                                if (item == null)
                                {
                                    item = new PessoaFake();
                                }
                                if (item != null)
                                    item.gender = val2;
                            }
                            if (key1 == "first")
                                if (item != null)
                                    item.name.first = val2;
                            if (key1 == "last")
                            {
                                if (item != null)
                                    item.name.last = val2;
                                lst.Add(item);
                                item = null;
                            }
                        }

                        
                        var _pessoa = new Pessoa();
                        var dateStart = new DateTime(1970, 01, 01);
                        var dateEnd = new DateTime(2000, 01, 01);
                        foreach (var pessoa in lst)
                        {
                            _pessoa = new Pessoa();

                            _pessoa.nome = pessoa.name.first;
                            _pessoa.sobrenome = pessoa.name.last;
                            _pessoa.dataNascimento = GetRandomDate(dateStart, dateEnd);
                            lstPessoa.Add(_pessoa);
                        }

                        //var m = Task.Factory.StartNew(() => JsonConvert.DeserializeObjectAsync<PessoaFake>(objsStream.ToString()));
                    }
                }

                IPessoaRepository rep = new DAL.Repository.PessoaRepository();

                foreach (var itemPessoa in lstPessoa)
                {
                    rep.Insert(itemPessoa);
                }
            }
            catch (HttpRequestException eHttpReq)
            {
                throw eHttpReq;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        private static readonly Random rnd = new Random();
        private static DateTime GetRandomDate(DateTime from, DateTime to)
        {
            var range = to - from;
            var randTimeSpan = new TimeSpan((long)(rnd.NextDouble() * range.Ticks));
            return from + randTimeSpan;
        }

        private int randBetween(int v1, int v2)
        {
            var r = new Random();
            return v1 + (int)Math.Round((decimal)(r.Next() * (v2 - v1)));
        }
    }
}
