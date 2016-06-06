using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Project.MHS.DAL.Interface
{
    public interface IRepository<T> where T : class
    {
        IEnumerable<T> List();
        IEnumerable<T> List(T filter);
        void Add(T entity);
        void Delete(T entity);
        void Update(T entity);
        T FindById(int Id);
    }
}
