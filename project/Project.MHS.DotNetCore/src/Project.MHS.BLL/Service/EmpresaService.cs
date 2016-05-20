using Project.MHS.BLL.Interface;
using Project.MHS.DAL.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Project.MHS.BE.Entity;

namespace Project.MHS.BLL.Service
{
    /// <summary>
    /// Implementação do serviço de empresa.
    /// </summary>
    public class EmpresaService : IEmpresaService
    {
        #region [ Propriedades de Apoio ]

        public IEmpresaRepository _repository
        {
            get
            {
                return new DAL.Repository.EmpresaRepository();
            }
        }

        #endregion

        #region [ Services ]

        public Empresa Get(Empresa filter)
        {
            return _repository.FindById(filter.id);
        }

        public IEnumerable<Empresa> GetAll()
        {
            return _repository.List();
        }

        public IEnumerable<Empresa> GetAll(Empresa filter)
        {
            return _repository.List(filter);
        }

        public void Insert(Empresa entity)
        {
            throw new NotImplementedException();
        }

        public void Update(int id, Empresa entity)
        {
            throw new NotImplementedException();
        }

        #endregion

    }
}
