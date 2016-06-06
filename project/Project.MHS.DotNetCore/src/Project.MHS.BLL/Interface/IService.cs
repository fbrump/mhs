using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Project.MHS.BLL.Interface
{
    /// <summary>
    /// Interface generica do serivico.
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public interface IService<T>
    {
        /// <summary>
        /// Obtem o registro pelo identificador.
        /// </summary>
        /// <param name="filter">Identificador</param>
        /// <returns>Registro.</returns>
        T Get(T filter);

        /// <summary>
        /// Obtem todos os registros.
        /// </summary>
        /// <returns>Lista de registros.</returns>
        IEnumerable<T> GetAll();

        /// <summary>
        /// Obtem todos os registros com base no filto.
        /// </summary>
        /// <param name="filter">Filtro que deseja aplicar.</param>
        /// <returns>Lista de registros.</returns>
        IEnumerable<T> GetAll(T filter);

        /// <summary>
        /// Inseri um registro.
        /// </summary>
        /// <param name="entity">Registro que deseja inserir.</param>
        void Insert(T entity);

        /// <summary>
        /// Atualiza as informações do registro.
        /// </summary>
        /// <param name="id">Identificador do registro que deseja atualizar.</param>
        /// <param name="entity">Registro atualizado.</param>
        void Update(int id, T entity);

    }
}
