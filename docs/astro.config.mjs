import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

export default defineConfig({
	site: process.env.CI ? 'https://gabInteli.github.io' : 'http://localhost:4321',
  	base: '/M10-Inteli-Eng-Comp_Gabriela_Matias/',
	integrations: [
		starlight({
			title: 'M10 - Gabriela',
			social: {
				github: 'https://github.com/withastro/starlight',
			},
			sidebar: [
				{
					label: 'Ponderada 1',
					items: [
						// Each item here is one entry in the navigation menu.
						{ label: 'Ponderada 1', link: '/ponderada1/solution/' },
					],
				},
				{
					label: 'Ponderada 2',
					items: [
						// Each item here is one entry in the navigation menu.
						{ label: 'Ponderada 2', link: '/ponderada2/solution/' },
					],
				},
				{
					label: 'Ponderada 3',
					items: [
						// Each item here is one entry in the navigation menu.
						{ label: 'Ponderada 3', link: '/ponderada3/solution/' },
					],
				},
				{
					label: 'Ponderada 4',
					items: [
						// Each item here is one entry in the navigation menu.
						{ label: 'Ponderada 4', link: '/ponderada4/solution/' },
					],
				},
			],
		}),
	],
});
