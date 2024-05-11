function [E] = constitutive_relation(Y,nu, theory)

if(theory == "plane_stress")
    E = Y/(1-nu*nu)*[1 nu 0; 
                    nu 1 0; 
                    0 0 (1-nu)/2];
end

if(theory == "plane_strain")
    E = Y/((1+nu)*(1-2*nu))*[1-nu nu 0;
                            nu 1-nu 0;
                            0 0 (1-2*nu)/2];
end

end
