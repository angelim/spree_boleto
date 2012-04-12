Deface::Override.new(:virtual_path => "spree/admin/shared/_order_tabs",
                    :name => "add_boletos_to_order_tab",
                    :insert_bottom => "[data-hook='admin_order_tabs']",
                    :partial => "spree/admin/boletos/tab",
                    :disabled => true)