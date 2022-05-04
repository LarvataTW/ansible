# Example Inventory

此處為一個配合本專案而使用的 Inventory 架構範例，
hosts 內的資源使用內網地址 (Private Networks / LAN) 作為產製範例。

## 使用說明

generator.py 利用 hosts.j2 作為樣板，引入 hosts.yaml 的設定內容，產出 hosts 檔案。

```
pip3 install pyyaml jinja2
python3 generator.py
```

## 目錄結構

```
├── generator.py
├── hosts
├── hosts.j2
├── hosts.yaml
├── group_vars
├── host_vars
├── playbooks
└── roles
```

* generator.py
產製 hosts 的 Python 腳本，其功能只是讀取 Jinja2 樣板與 YAML 檔案內的設定值，產出 hosts。

* hosts
藉由 generator.py + hosts.j2 + hosts.yaml 產製的最終的、被需要的 Inventory 檔案。

* hosts.j2
Python Jinja2 樣板檔案，利用 Jinja2 樣板語言設計的內容結構，影響 hosts 的產出樣式。

* hosts.yaml
Inventory 資源的值，其資料結構將決定 hosts.j2 如何編寫，好的資料結構可以導引出漂亮的樣板檔案。

* group_vars
群組變數檔案，此處一般為私有的、不公開的、不應放到公共的 Git Repository。

* host_vars
主機變數檔案，此處一般為私有的、不公開的、不應放到公共的 Git Repository。

* playbooks
存放私有的、非通用性質的 playbook，例如某個 playbook 只適用於重啟某個內部的 X 系統。

* roles
存放私有的、非通用性質的 role，例如某個 role 只適用於配置某個內部的 Y 系統。
