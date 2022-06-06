module.exports = {
	future: {
		// removeDeprecatedGapUtilities: true,
		// purgeLayersByDefault: true,
	},
	purge: [],
	theme: {
		maxHeight: {
			"0": "0",
			"1/4": "25%",
			"1/2": "50%",
			"3/4": "75%",
			"3/4v": "75vh",
			full: "100%"
		},

		extend: {
			colors: {
				primary: {
					100: "#c5e6f5",
					200: "#a3d9f0",
					300: "#81cbeb",
					400: "#5dbee8",
					500: "#3ab0e4",
					600: "#1ba1dc",
					700: "#1589bb",
					800: "#107099",
					900: "#0b5677"
				},
				secondary: {
					100: "#FFFDF8",
					200: "#FFF8E6",
					300: "#FFF0CC",
					400: "#FFE4A5",
					500: "#FDD77E",
					600: "#DAB04F",
					700: "#B98E2B",
					800: "#976E12",
					900: "#6D4B00"
				}
			}
		}
	},
	variants: {},
	plugins: []
};
