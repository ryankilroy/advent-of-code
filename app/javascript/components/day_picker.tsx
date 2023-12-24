// app/javascript/components/App.tsx
import { DatePicker, LocalizationProvider } from '@mui/x-date-pickers';
import { AdapterDayjs } from '@mui/x-date-pickers/AdapterDayjs';
import dayjs from 'dayjs';
import React from 'react';
import ReactDOM from 'react-dom/client';

const defaultDate = () => {
	const today = dayjs(Date.now());
	if (today.month() < 11) {
		return dayjs(new Date(today.year() - 1, 11, 1));
	} else {
		return today
	}
}

function DayPicker() {
	const [date, setDate] = React.useState(defaultDate());

	const handleMonthChange = (newDate: dayjs.Dayjs) => {
		const month = newDate.month();
		const year = newDate.year();
		if (month === 10) {
			// Switch calendar to December of previous year
			setDate(dayjs(new Date(year - 1, 11, date.date())));
		} else if (month === 0) {
			// Switch calendar to December of year
			setDate(dayjs(new Date(year, 11, date.date())));
		}
	}

	return (
		<LocalizationProvider dateAdapter={AdapterDayjs}>
			<DatePicker value={date}
				onChange={(value) => setDate(value || dayjs())}
				views={['year', 'day']}
				minDate={dayjs('2015-12-01')}
				maxDate={dayjs('2023-12-31')}
				shouldDisableDate={(day) => { return day.date() > 25 }}
				shouldDisableMonth={(day) => { return day.month() != 11 }}
				onMonthChange={handleMonthChange}
			/>
		</LocalizationProvider>
	)
}

document.addEventListener("DOMContentLoaded", () => {
	const node = document.getElementById('day-picker');
	if (node) {
		ReactDOM.createRoot(node).render(<DayPicker />)
	}
})

export default DayPicker;