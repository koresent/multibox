settings
{
    showdelay=0
}

theme {
    view=view.small
    separator.size=0
    image.enabled=true
    name="modern"
    border.radius=2
    shadow.enabled=false
    background.effect=3
}

import 'imports/images.nss'

modify(where=this.id==id.open image = \uE0F0)

modify(find="PeaZip" image="C:\\Program Files\\Nilesoft Shell\\imports\\peazip.ico")
modify(find="WinMerge" image="C:\\Program Files\\Nilesoft Shell\\imports\\winmerge.ico")

menu(type='*' where=sel.count mode=mode.multiple title=title.go_to image=\uE14A)
{
    item(image='shell32.dll,-151' title='Program Files' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(sys.prog), sys.prog))
    item(image='shell32.dll,-151' title='Program Files x86' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(sys.prog32), sys.prog32))
    item(image='shell32.dll,-151' title='ProgramData' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(sys.programdata), sys.programdata))
    item(image='imageres.dll,-25' title='Hosts' admin cmd='zed "C:\Windows\System32\drivers\etc\hosts"')
    item(image='imageres.dll,-79' title='Users' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(sys.users), sys.users))
    item(image='imageres.dll,-183' title='Desktop' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(user.desktop), user.desktop))
    item(image='imageres.dll,-184' title='Downloads' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(user.downloads), user.downloads))
    item(image='imageres.dll,-113' title='Pictures' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(user.pictures), user.pictures))
    item(image='imageres.dll,-112' title='Documents' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(user.documents), user.documents))
    item(image='imageres.dll,-5308' title='Start Menu' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(user.startmenu), user.startmenu))
    item(image='shell32.dll,-279' title='Profile' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(user.dir), user.dir))
    item(image='shell32.dll,-40' title='AppData' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(user.appdata), user.appdata))
    item(image='shell32.dll,-16752' title='Temp' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(user.temp), user.temp))
}

menu(type="taskbar" vis=key.shift() or key.lbutton() pos=0 title=app.name image=\uE249)
{
	item(title="manager" image=\uE0F3 admin cmd='"@app.exe"')
}

menu(where=@(this.count == 0) type='taskbar' image=icon.settings expanded=true)
{
	item(title=title.task_manager image=icon.task_manager cmd='taskmgr.exe')
}

item(
    type='file'
    mode='single'
    title='VT Scan'
    image='<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64"><path d="M29.06 32L0 61.257h64V2.743H0zm29.09 23.406H13.53l23.94-23.552-23.296-23.26H58.15z" fill="#3b61ff"/></svg>'
    cmd='powershell'
    args='-NoProfile -WindowStyle Hidden -Command "$p=\"@sel.path\"; Start-Process (\"https://www.virustotal.com/gui/file/\" + (Get-FileHash -LiteralPath $p).Hash)"'
)