using Project.MSH.DAL.Context;
using Project.MSH.DAL.Interface;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Reflection;

namespace Project.MSH.DAL.Repository
{
    public class BaseRepository<T> : IDisposable, IRepository<T> where T : class
    {
        #region [ Proprety ]

        protected DbContextModel Context;
        private IDbSet<T> _dbSet;
        protected IDbSet<T> DbSet { get { return _dbSet; } }

        #endregion

        #region [ Constructor]

        public BaseRepository() : this(new DbContextModel()) {
        }

        public BaseRepository(DbContextModel pContext)
        {
            this.Context = pContext;
            _dbSet =Context.Set<T>();
        }

        #endregion

        #region [ Generic Repository ]

        public void Delete(T pEntity)
        {
            try
            {
                using (var ctx = this.Context)
                {
                    ctx.Set<T>().Remove(pEntity);
                    ctx.SaveChanges();
                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public IEnumerable<T> GetAll()
        {
            try
            {
                return Context.Set<T>();
            }
            catch (Exception e)
            {

                throw e;
            }
        }

        public IEnumerable<T> GetAll(Func<T, bool> pFilter)
        {
            return GetAll().Where(pFilter).ToList();
        }

        public T GetById(Func<T, bool> pId)
        {
            try
            {
                return Context.Set<T>().SingleOrDefault(pId);
            }
            catch (Exception e)
            {

                throw e;
            }
        }

        public void Insert(T pEntity)
        {
            try
            {
                DbSet.Add(pEntity);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public T Update(T pEntity)
        {
            try
            {
                Context.Entry(pEntity).State = EntityState.Modified;

                return pEntity;
            }
            catch (Exception e)
            {

                throw e;
            }
        }

        public void Dispose() {
            if (Context != null) Context.Dispose();
        }

        #endregion
    }
}
