allsignal_file = 'signal_scale';
if exist(allsignal_file,'file')==2
    delete(allsignal_file);
end
fid = fopen(allsignal_file,'wt+');
FileInfo = dir('LABELS');
for i=1:length(FileInfo)
    fn = FileInfo(i).name;
    if strstartswith(fn, 'svmsignal_scale')
        fileID = fopen(fn);
        tline = fgets(fileID);
        while ischar(tline)
            fprintf(fid,tline);
            tline = fgets(fileID);
        end
        fclose(fileID);
    end
end