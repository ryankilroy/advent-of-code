import Rating from "@mui/material/Rating";
import { Box } from "@mui/system";
import React from "react";
import ReactDOM from "react-dom/client";

type StarCompletionProps = {
  value?: number
  readonly?: boolean
  fieldId?: string
}

function updateField(fieldId: string, value: (number)) {
  const field = document.getElementById(fieldId)
  if (field && field instanceof HTMLInputElement)
    field.value = value.toString()
  else
    console.log("Unable to find a form field with ID ${fieldId}");
}

export default function StarCompletion({ value = 0, readonly = false, fieldId }: StarCompletionProps): JSX.Element {
  const [completion, setCompletion] = React.useState<number | null>(value || 0)

  const handleChange = (event: React.ChangeEvent<{}>, newValue: number | null) => {
    if (newValue == completion)
      newValue = 0
    setCompletion(newValue)
    if (fieldId && newValue) {
      updateField(fieldId, newValue)
    }
  };

  return (
    <Box>
      <Rating
        value={completion}
        readOnly={readonly}
        max={2}
        onChange={(event, newValue) => {
          if (completion == newValue)
            setCompletion(0)
          else
            setCompletion(newValue)
        }}
      />
    </Box>
  )
}

document.addEventListener("DOMContentLoaded", () => {
  const node = document.getElementById("star-completion");
  if (node) {
    const value = JSON.parse(node.getAttribute("data-value") || "0");
    const readonly = JSON.parse(node.getAttribute("data-readonly") || "true");
    const fieldId = node.getAttribute("data-field-id") || "";
    ReactDOM.createRoot(node).render(<StarCompletion value={value} readonly={readonly} fieldId={fieldId} />);
  }
});