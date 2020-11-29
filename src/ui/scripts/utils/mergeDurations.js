// import selectDurationsValue from '../selectors/selectDurationsValue'
import enhanceDurations from '../enhancers/enhanceDurations'

// Turns the durations of multiple widgets into one array of durations
export default (widgets) => {

	// Enhance durations for all widgets
	const enhancedDurations = widgets.map((widget) => {

		return enhanceDurations(widget.value, 14)

	})

	// Merge all durations to one array of durations
	const mergedDurations = enhancedDurations.reduce((acc, durations) => {

		// Durations is an array. Each item represents the average duration of one day.
		durations.forEach((duration, index) => {

			// The current day might be new as should be initialised first
			const initial = acc[index] == null ? 0 : acc[index]

			// Add the current day to the global array of days
			acc[index] = initial + duration

		})

		return acc

	}, [])

	const totalDomains = enhancedDurations.length

	// Convert merged, total durations into average durations
	return mergedDurations.map((duration) => {

		return duration / totalDomains

	})

}