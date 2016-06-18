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
    [TestClass]
    public class EmpresaTest
    {
        #region [ Propety ]

        private IEmpresaRepository RepositoryPerson
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
                lst = this.RepositoryPerson.GetAll();
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

        #endregion

        #region [ Methods ]

        #endregion
    }
}
