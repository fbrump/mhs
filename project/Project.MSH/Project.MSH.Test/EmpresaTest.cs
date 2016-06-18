using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Project.MSH.DAL.Interface;
using Project.MSH.DAL.Factory;
using Project.MSH.BEL.Entity;
using System.Collections.Generic;
using System.Collections;
using System.Linq;

namespace Project.MSH.Test
{
    // https://www.mockaroo.com/
    [TestClass]
    public class EmpresaTest
    {
        #region [ Propety ]

        private IEmpresaRepository RepositoryCompany
        {
            get
            {
                return new FactoryRepository<IEmpresaRepository>().Get();
            }
        }

        #endregion

        #region [ Test ]

        [TestMethod]
        public void Should_select_all_companys()
        {
            try
            {
                // arrange
                var lst = Enumerable.Empty<Empresa>();
                // act
                lst = this.RepositoryCompany.GetAll();
                // asset
                Assert.IsInstanceOfType(lst, typeof(IEnumerable<Empresa>));
                Assert.AreNotEqual(lst.Count(), 0, "Not exist some company in this project.");
            }
            catch (Exception e)
            {
                Assert.Fail(e.Message);
                throw e;
            }
        }

        [TestMethod]
        public void Should_select_all_companys_by_name()
        {
            try
            {
                // arrange
                var filter = new Empresa() {
                    nm_empresa = "Tech"
                };
                var lst = Enumerable.Empty<Empresa>();
                // act
                lst = this.RepositoryCompany.GetAll(t => t.nm_empresa.Contains(filter.nm_empresa));
                // asset
                Assert.IsInstanceOfType(lst, typeof(IEnumerable<Empresa>));
                Assert.AreNotEqual(lst.Count(), 0, "Not exist some company in this project.");
            }
            catch (Exception e)
            {
                Assert.Fail(e.Message);
                throw e;
            }
        }

        [TestMethod, Ignore]
        public void Should_insert_company()
        {
            try
            {
                // arrange
                var company = new Empresa() { nm_empresa="Glamour Store", nm_fantasia="GS - GlamourStore" };
                var lst = Enumerable.Empty<Empresa>();
                // act
                this.RepositoryCompany.Insert(company);

                // asset
                Assert.IsInstanceOfType(company, typeof(Empresa), "This object not a correct type fo insert");
                Assert.AreNotEqual(company.id, 0, "Sorry, not generated new ID or Insert.");
            }
            catch (Exception e)
            {
                Assert.Fail(e.Message);
                throw e;
            }
        }

        [TestMethod, Ignore]
        public void Should_update_company_name()
        {
            try
            {
                // arrange
                var companyUpdate = new Empresa() { nm_fantasia = "GS - GlamourStore" };
                var lst = Enumerable.Empty<Empresa>();
                // act
                var result = this.RepositoryCompany.GetById(t => t.id == 5);
                result.nm_fantasia = companyUpdate.nm_fantasia;
                this.RepositoryCompany.Update(result);

                // asset
                Assert.IsInstanceOfType(companyUpdate, typeof(Empresa), "This object not a correct type fo insert");
                Assert.AreEqual(companyUpdate.nm_fantasia, result.nm_fantasia, "Not updated.");
            }
            catch (Exception e)
            {
                Assert.Fail(e.Message);
                throw e;
            }
        }

        [TestMethod, Ignore]
        public void Should_delete_company()
        {
            try
            {
                // arrange
                var company = new Empresa() { id = 6 };
                var lst = Enumerable.Empty<Empresa>();
                // act
                var result = this.RepositoryCompany.GetById(t => t.id == company.id);
                this.RepositoryCompany.Delete(result);
                var resultDeleted = this.RepositoryCompany.GetById(t => t.id == company.id);
                // asset
                Assert.IsInstanceOfType(company, typeof(Empresa), "This object not a correct type fo insert");
                Assert.IsNull(resultDeleted, "Not deleted the company.");
            }
            catch (Exception e)
            {
                Assert.Fail(e.Message);
                throw e;
            }
        }

        #endregion

        #region [ Methods ]

        #endregion
    }
}
