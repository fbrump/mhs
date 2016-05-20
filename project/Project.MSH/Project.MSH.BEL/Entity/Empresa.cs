using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Project.MSH.BEL.Entity
{
    [Table("tb_empresa")]
    public class Empresa
    {
        [Key]
        /// <summary>
        /// id integer NOT NULL DEFAULT nextval('tb_empresa_id_seq'::regclass), -- Identificador da empresa
        /// </summary>
        public int id { get; set; }
        
        /// <summary>
        /// nm_empresa character varying(300) NOT NULL, -- Nome registrado da empresa
        /// </summary>
        public string nm_empresa { get; set; }

        /// <summary>
        /// nm_fantasia character varying(500), -- Nome fantasia da empresa
        /// </summary>
        public string nm_fantasia { get; set; }
        
        //CONSTRAINT pk_empresa PRIMARY KEY(id)
    }
}
