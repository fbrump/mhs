using Project.MHS.BE.Entity;
using Project.MHS.DAL.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Project.MHS.DAL.Repository
{
    /// <summary>
    /// Implementação do Repositório da Empresa.
    /// </summary>
    public class EmpresaRepository : IEmpresaRepository
    {
        #region [ Propriedades ]

        public Context.DbModelContext _context { get; private set; }

        #endregion

        #region [ Construtor ]

        public EmpresaRepository()
        {
            _context = new Context.DbModelContext();
        }

        #endregion

        #region [ Repository Method ]

        public void Add(Empresa entity)
        {
            try
            {
                _context.Empresa.Add(entity);
                _context.SaveChanges();
            }
            catch (Exception e)
            {

                throw e;
            }
        }

        public void Delete(Empresa entity)
        {
            try
            {
                _context.Remove(entity);
                _context.SaveChanges();
            }
            catch (Exception e)
            {

                throw e;
            }
        }

        public Empresa FindById(int Id)
        {
            try
            {
                var result = (
                from t in _context.Empresa
                where t.id == Id
                select t
                ).FirstOrDefault();

                return result;
            }
            catch (Exception e)
            {

                throw e;
            }
        }

        public void Update(Empresa entity)
        {
            try
            {
                _context.Entry(entity).State = Microsoft.Data.Entity.EntityState.Modified;
                _context.SaveChanges();
            }
            catch (Exception e)
            {

                throw e;
            }
        }

        IEnumerable<Empresa> IRepository<Empresa>.List()
        {
            try
            {
                using (_context)
                {
                    return _context.Empresa.ToList();
                }
            }
            catch (Exception e)
            {

                throw e;
            }
        }

        IEnumerable<Empresa> IRepository<Empresa>.List(Empresa filter)
        {
            try
            {
                return (
                    from
                        t in _context.Empresa
                    where
                        t.nm_empresa.Contains(filter.nm_empresa) ||
                        t.nm_fantasia.Contains(filter.nm_fantasia)
                    select
                        t
                ).ToList();
            }
            catch (Exception e)
            {

                throw e;
            }
        }

        #endregion
    }
}
