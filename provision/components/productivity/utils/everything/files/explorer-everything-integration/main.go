package main

import (
	"os/exec"
	"runtime"
	"syscall"

	"github.com/go-ole/go-ole"
	"github.com/go-ole/go-ole/oleutil"
)

var (
	user32               = syscall.NewLazyDLL("user32.dll")
	procGetForegroundWin = user32.NewProc("GetForegroundWindow")
)

const everythingPath = `C:\Program Files\Everything 1.5a\Everything.exe`

func main() {
	runtime.LockOSThread()
	defer runtime.UnlockOSThread()

	if err := ole.CoInitializeEx(0, ole.COINIT_APARTMENTTHREADED); err != nil {
		launchEverything("")
		return
	}
	defer ole.CoUninitialize()

	hwnd, _, _ := procGetForegroundWin.Call()
	if hwnd == 0 {
		launchEverything("")
		return
	}

	path := getExplorerPath(hwnd)
	launchEverything(path)
}

func launchEverything(path string) {
	if path != "" {
		_ = exec.Command(everythingPath, "-path", path).Start()
	} else {
		_ = exec.Command(everythingPath).Start()
	}
}

func getExplorerPath(targetHwnd uintptr) string {
	unknown, err := oleutil.CreateObject("Shell.Application")
	if err != nil {
		return ""
	}
	shell, _ := unknown.QueryInterface(ole.IID_IDispatch)
	defer shell.Release()
	defer unknown.Release()

	windowsVar, err := oleutil.CallMethod(shell, "Windows")
	if err != nil {
		return ""
	}
	windows := windowsVar.ToIDispatch()
	defer windows.Release()

	countVar, _ := oleutil.GetProperty(windows, "Count")
	count := int(countVar.Val)

	for i := 0; i < count; i++ {
		itemVar, err := oleutil.CallMethod(windows, "Item", i)
		if err != nil {
			continue
		}
		item := itemVar.ToIDispatch()
		
		itemHwndVar, _ := oleutil.GetProperty(item, "HWND")
		if uintptr(itemHwndVar.Val) == targetHwnd {
			path := getPathFromWindow(item)
			item.Release()
			return path
		}
		item.Release()
	}
	return ""
}

func getPathFromWindow(item *ole.IDispatch) string {
	docVar, err := oleutil.GetProperty(item, "Document")
	if err != nil {
		return ""
	}
	doc := docVar.ToIDispatch()
	defer doc.Release()

	folderVar, err := oleutil.GetProperty(doc, "Folder")
	if err != nil {
		return ""
	}
	folder := folderVar.ToIDispatch()
	defer folder.Release()

	selfVar, err := oleutil.GetProperty(folder, "Self")
	if err != nil {
		return ""
	}
	self := selfVar.ToIDispatch()
	defer self.Release()

	pathVar, _ := oleutil.GetProperty(self, "Path")
	return pathVar.ToString()
}