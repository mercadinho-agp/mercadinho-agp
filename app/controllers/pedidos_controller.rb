class PedidosController < ApplicationController
    before_action :authenticate_usuario!, except: %i[new create]

    def index
        if current_usuario.email == "admin@admin.com"
            @pedidos = Pedido.order(created_at: :asc)
        else
            @pedidos = Pedido.order(created_at: :asc).where(usuario_id: current_usuario.id)
        end
        puts @pedidos[0].inspect
        compras = @pedidos[6].compras
        puts compras.inspect
    end

    def new
        @produtos = Produto.order(id: :asc)
    end

    def create
        total = params.require(:total)
        produtos = params.require(:produtos)
        pedido = Pedido.create status: false, total: total, usuario_id: current_usuario.id

        produtos.each do |id,qnt|
            produto = Produto.find(id)
            sub_total = qnt.to_i * produto.preco.to_f
            compra = Compra.create qnt: qnt, sub_total: sub_total, pedido_id: pedido.id, produto_id: produto.id
            produto.qnt -= qnt.to_i
            produto.save
        end

        pedido.status = true
        if pedido.save
            flash[:notice] = "Pedido cadastrado com sucesso!"
            redirect_to pedidos_path
        end
    end

    def edit
        pedido_id = params[:id]
        @pedido = Pedido.find(pedido_id)
        @produtos_comprados = []

        @pedido.compras.each do | compra |
            @produtos_comprados.append([compra.produto_id, compra.qnt])
        end
        
        @produtos = Produto.order(id: :asc)
    end

    def update
        pedido_id = params[:id]
        total = params.require(:total)
        produtos = params.require(:produtos)
        pedido = Pedido.find(pedido_id)
        
        produtos.each do |id,qnt|
            compra = Compra.find_or_create_by(pedido_id: pedido.id, produto_id: id)
            produto = Produto.find(id)
            produto.qnt += compra.qnt - qnt.to_i
            sub_total = qnt.to_i * produto.preco.to_f
            compra.qnt = qnt
            compra.sub_total = sub_total
            if !compra.save or !produto.save
                flash[:alert] = "Erro ao alterar o pedido!"
                redirect_to pedidos_path
            end
        end

        total.sub! ',', '.'
        pedido.total = total.to_f
        puts pedido.total
        pedido.status = true
        if pedido.save
            flash[:notice] = "Pedido alterado com sucesso!"
            redirect_to pedidos_path
        else
            flash[:alert] = "Erro ao alterar o pedido!"
            redirect_to pedidos_path
        end
    end

    def destroy
        id =  params[:id]
        Pedido.destroy id
        redirect_to pedidos_path
    end
end
