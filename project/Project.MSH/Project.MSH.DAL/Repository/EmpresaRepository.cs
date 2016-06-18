using Project.MSH.BEL.Entity;
using Project.MSH.DAL.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Project.MSH.DAL.Repository
{
    internal class EmpresaRepository : BaseRepository<Empresa>, IEmpresaRepository
    {
        #region [ Constructor ]
        public EmpresaRepository() : base() { }
        public EmpresaRepository(Context.DbContextModel pContext) : base(pContext) { }
        #endregion

        #region [ Public Methods Repository ]

        #endregion
    }
}
