require 'csv'

class ProdutosController < ApplicationController
    before_action :authenticate_usuario!

    def index
        @produtos = Produto.order(id: :asc).page(params[ :page ]).per(5)
    end

    def create
        produto = params.require(:produto).permit(:nome, :descricao, :preco, :qnt)
        Produto.create produto
        redirect_to produtos_path
    end

    def edit
        id =  params[:id]
        @produto = Produto.find(id)
    end

    def update
        id =  params[:id]
        @produto = Produto.find(id)

        valores = params.require(:produto).permit(:nome, :descricao, :preco, :qnt)
        if @produto.update valores
            flash[:notice] = "Produto atualizado com sucesso!"
            redirect_to produtos_path
        else
        end
    end

    def destroy
        id =  params[:id]
        Produto.destroy id
        redirect_to produtos_path
    end

    def export
        @produtos = Produto.order(id: :asc)

        respond_to do |format|
            format.csv do
                response.headers['Content-Type'] = 'text/csv'
                response.headers['Content-Disposition'] = "attachment; filename=listagem.csv"
            end
        end
    end
end
