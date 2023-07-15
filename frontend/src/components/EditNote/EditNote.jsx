import { ToastContainer } from "react-toastify";
import PropTypes from "prop-types";
import { useEffect, useState } from "react";
import { PencilSquare } from "react-bootstrap-icons";
import APIService from "../../services/APIService";
import notifySuccess, {
  notifyError,
} from "../../services/ToastNotificationService";
import s from "./EditNote.module.css";

export default function EditNote({ setOpenModal, selectedNote, fetchNotes }) {
  if (!setOpenModal) return null;
  const [note, setNote] = useState({
    title: "",
    content: "",
    user_id: null,
    color_id: null,
    types_id: null,
    category_id: null,
  });

  useEffect(() => {
    APIService.get(`/notes/${selectedNote}`)
      .then((response) => {
        setNote(response.data);
      })
      .catch((error) => notifyError(`${error}"La requête a échoué"`));
  }, []);

  const handleEdit = async (e) => {
    e.preventDefault();
    if (selectedNote !== "") {
      try {
        const res = await APIService.put(`/notes/${selectedNote}`, note);

        if (res) {
          notifySuccess("La note a été modifiée");
          fetchNotes();
        } else {
          throw new Error();
        }
      } catch (err) {
        if (err.request?.status === 500) {
          notifyError(`${err.request.status} : La requete a échouée.`);
        }
      }
    }
  };

  const handleChange = async (e) => {
    setNote({
      ...note,
      [e.target.name]: e.target.value,
    });
  };

  const handleClose = () => {
    setOpenModal(false);
  };

  return (
    <div className={s.overlay}>
      <div className={s.container}>
        <form action="note" className={s.container}>
          <button type="button" onClick={handleClose}>
            X
          </button>
          <input
            type="text"
            name="title"
            className={s.input}
            defaultValue={note.title}
            onChange={handleChange}
            id="title"
          />
          <textarea
            type="text"
            name="content"
            rows="18"
            className={s.textarea}
            defaultValue={note.content}
            onChange={handleChange}
            required="required"
            id="content"
          />
          <button type="button" className={s.button} onClick={handleEdit}>
            Enregister
          </button>
          <ToastContainer limit={1} />
        </form>
      </div>
    </div>
  );
}

EditNote.propTypes = {
  fetchNotes: PropTypes.func.isRequired,
  selectedNote: PropTypes.number.isRequired,
  setOpenModal: PropTypes.string.isRequired,
};
