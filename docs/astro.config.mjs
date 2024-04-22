import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://astro.build/config
export default defineConfig({
	site: 'https://gabInteli.github.io/M10-Inteli-Eng-Comp_Gabriela_Matias/',
  	base: '/docs',
  
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
			],
		}),
	],
});
