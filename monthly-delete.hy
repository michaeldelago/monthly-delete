#!/usr/bin/env hy
(import argparse
        logging
        os 
        sys 
        datetime [datetime timedelta])


(setv today (datetime.today))
(logging.basicConfig :level logging.INFO)

(defn check-delete-file [file-path]
  (logging.info f"Checking if {file-path} needs to be deleted")
  (let [mtime (datetime.fromtimestamp (. (os.stat file-path) st_mtime))
      expiry (+ mtime (timedelta :days 30))]
  (cond
    [(not (.path.isfile os file-path)) False] 
    [(> expiry today) False]
    [(= (. mtime day) 14) False]
    [(= (. mtime day) 28) False]
    [True True])))

(defn do-delete-file [file-path delete]
  (logging.info f"Removing file at {file-path}")
  (if delete
    (.remove os file-path)    
    (logging.info f"Skip remove {file-path}")))


(defn main []
  (let [parser (argparse.ArgumentParser)]
    (.add-argument parser "-d" "--delete" :action "store_true" :help "Confirm deletion of files")
    (.add-argument parser "directory")
    (setv args (parser.parse_args))
    (setv files (.listdir os args.directory))
    (setv file-paths (map (fn [file] f"{args.directory}/{file}") files))
    (setv deletes (list (filter check-delete-file file-paths)))
    (list (map (fn [path] (do-delete-file path args.delete)) deletes))))

(main)