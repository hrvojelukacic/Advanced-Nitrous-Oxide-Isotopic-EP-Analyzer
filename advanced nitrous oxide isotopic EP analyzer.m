% Putanja na folder s ulaznim podacima (txt fajlovi) 
input_folder = 'C:\Users\hlukacic\Desktop\PB\input'; % Ovdje kopirati putanju 

% Putanja na folder gdje će se spremati izlazni csv fajlovi  
output_folder = 'C:\Users\hlukacic\Desktop\PB\output'; % Ovdje kopirati putanju 

% Ispusuje sve fajlove koji se nalaze u input folderu
file_list = dir(fullfile(input_folder, '*.txt'));

% For petlja koja prolazi kroz svaki fajl i na njemu radi operacije
% izračuna srednje vrijenosti po stupcima
for file_idx = 1:numel(file_list)
    % Ispisi ime fajla
    current_file = fullfile(input_folder, file_list(file_idx).name);
    
    % Učitaj fajl kao matricu
    laser_measurements = readmatrix(current_file);
    
    %Zamjeni NaN sa 0
     laser_measurements(isnan(laser_measurements))= 0
    
    % Izracunaj srednje vrijednsoti
H2O_ppm_average = mean(nonzeros(laser_measurements(:, 2)));
d15NA = mean(nonzeros(laser_measurements(:, 28)));
d16NB = mean(nonzeros(laser_measurements(:, 30)));
d15N = mean(nonzeros(laser_measurements(:, 32)));
d18O = mean(nonzeros(laser_measurements(:, 34)));
d17O = mean(nonzeros(laser_measurements(:, 36)));
SP = mean(nonzeros(laser_measurements(:, 38)));
N2O_ppm = mean(nonzeros(laser_measurements(:, 40)));
GasP_torr = mean(nonzeros(laser_measurements(:, 42)));
    
    % Kreiraj matricu rezultata
    export_matrix = [H2O_ppm_average, d15NA, d16NB, d15N, d18O, d17O, SP, N2O_ppm, GasP_torr];
    
    % Stvori novi csv fajl koji ce imati sve izračune
    [~, file_name, ~] = fileparts(file_list(file_idx).name);
    output_file = fullfile(output_folder, [file_name, '_average.xlsx']);
    
    % Export stvorenog csv fajla
    xlswrite(output_file, export_matrix);
end
