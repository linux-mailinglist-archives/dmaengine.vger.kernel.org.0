Return-Path: <dmaengine+bounces-10583-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCQqAdMvDmoK7wUAu9opvQ
	(envelope-from <dmaengine+bounces-10583-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:04:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D75C359BADB
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A007B3069AFF
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 22:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DAA3BC69C;
	Wed, 20 May 2026 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ADZX3hva"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7B23BB9F8;
	Wed, 20 May 2026 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314486; cv=fail; b=OV9QmXh0HfOlDV5MRKoRv7K122eWOO/2g6tBy5SOOA3kcfgeamaEF2Hii+YNhnV5nD3n3UnmRMdaIQAM1pc/uvlFiSTmRgUvvIGK15T4ylpuqPKpaCmrqGDpEEarsnn9+UUmdYnvl1ETVMO+tUd6wpF4T2H0O+IMw44dJSjWpF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314486; c=relaxed/simple;
	bh=+M2lx82T/SFuJPnO4V/KQr48tQ06j51TU6I9+la9R0o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Y5HqYxdvg6WBzFHGCFCvILAlIol55BHokBisFfdX1VjZYS6iQKk1DC2uCNgbAEZS8SkvAfoU22oJQXUEYYFtKF1NVeda1YS+qATortNlAImWXN+08cIjJGd2zHvR44z8Dh/eULlxaYHCAuAKFT9JK4zybyQbsF8Y3iex0iB0iJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ADZX3hva; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qv/g4w1IOTINYG31DfdzhB5tPDab0AvCFDui8RoyDT6o6Fe1ctugwMvUA/B1Vu0QViBPySk5Fy9viRxUP23COjLTb1Urq7To+x+1fYwraoDJEkuXCpr8y0dk4U2iQkz5yOGtsf4HKAiH/jThtEbwzGDJhss4/RnOlK9k2pSyjKfq30+iyCfdqfPred8tOxKo8ojzjKd3tBiglHAxSxm81VJtj3ahkwKP3YHksLVO69qQb9jC6to3uNVdYEVExYoPis38AFEHrRVpTVA3MBT8/bLVVoniW4FJIn9i7byRAqlaSa/JohqQtqh4ASCt9x0rdWC7DzhPcoQtXUoTonB9Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXPk88HSDVKkbLLpzVW6jKOO4Jd50ksHFKn8+jGBYZw=;
 b=ex8Bfx7ypMlAdNxKD2JLsMzVvqwQVFOZRCNwFQND6kcpRRlJsOXNQhj21fKXXXr9NZJYP0UJIiwqv5zxJnHf6CGzjn5XphBHcyru6DdQjSK31J0CGTu0iikD/FdOulm7Yu1tFep45xq661Pon9rAaZrZPObk3ML7oYiuhxp4eLitxdJ3DyHIfxfJHV8Fkk0AfkVz3niO3y3d78WjtbDoLeHVtNg9rpIcvphlsMCXqDQw8rNmFZ4lNVwZn383jWx/SbFvgTahCHM/zxpY5++vhIP4Jc/CSDegUXy5Xaas7rR5Qbvv312pSOyrXiJiw8pyoK26WOC818o1Crky5HEJZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXPk88HSDVKkbLLpzVW6jKOO4Jd50ksHFKn8+jGBYZw=;
 b=ADZX3hvadGnGCMw9ybawv8eJ4XXR+Htp47WikVmJyyoYwYrumu7jp1gBkDNg73Atsn9jaWMBgrMFPvK+A3pz2rRY323wssN0FvPB+PhJDdGvNDa3j8vahbc3qT7WF1Uz6lBoDIn4ARbGeJJy7RL3Uhb2May9BdHOxaE0RN0YrrJgeUhYLM32l0BNnJm6zEUBT2YlEIaGXxr0OWS5hGK9Ot44FZKCpfWV7COdNSbyDh/Une2YwKKOxcOZ1AdLmOVJW3hzG6Wpv0nsaQplHbrlGAKUl+Ns1t4rdBgTVd3YBVxyq/jZQISKCZ4h8fsl55rbuja8m0AMtv5E1tH9mE+RRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB8029.eurprd04.prod.outlook.com (2603:10a6:102:c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 22:01:16 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 22:01:16 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 20 May 2026 18:00:47 -0400
Subject: [PATCH v6 6/9] nvmet: pci-epf: Remove unnecessary
 dmaengine_terminate_sync() on each DMA transfer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-dma_prep_config-v6-6-06e49b7acb38@nxp.com>
References: <20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com>
In-Reply-To: <20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Damien Le Moal <dlemoal@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779314446; l=1294;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=MtVHghBbP5ur9sdbIo7YfLXlw6DWbAENd28zNpiPwC0=;
 b=nl90l1r7TIZktCwHJsT87Xr9TyzS2aDjt1Ng+xZbvp7P/EXILbYAuPRpWdlPnoEBdtzy3AM27
 PP0DLuHq/xnDPPPG31CtI6P/aCCBzTwuWXdbTPCJVwxpGR3Z6+G682Q
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P220CA0058.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a030a4c-5038-42f8-7d55-08deb6bb50bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|921020|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	IHj2L1657XKZR7ccgEDReenP2zWkbwROt/vOq+Y0iFlP/yYBPse5hlR4rRwVzQF5cZ9tcypsACkM7hmeGazc6zWl1/tR95pku5i1gLE5ZI25lov/rx10gcHlmIqp9+lzf/DHUz4ZfyPi0luocbtOZyB1mpCxcRgvIxy4OEEBu6jnN1Fu9mCXyWUYARQmZtPENA/aAPCWgaP9mk5U9N4Ky1jxvIEcLA3PIg7tgAwe0aILDYdCy1bsTrokkfqGSi+9CDbLLoSryCndq6+xyUQuk1Mpw445fvAuvThZMa1/81xTKKniuoWZr4k0SrBuDknwJdF/cxkZCtny9gzkX1QMG9QfVz4adlta9VZ/VJ+4EgTkJQYS2DlGUMDB453emxRXa4DLCoZ5Wu5y8PDqqHWw/TC7OCn/LCtqDDvx8GsFXJZDMP71dUbaxXhCIbeyeUdaOtxif2l6JT4Ejxylap67A8x6CBIRPJ0/cwNDtpOgzFP4CBXlCZITEId6llAul2u43lbI+dxXv8qYK2evbLtZc19+89YiuQor0IRgorLWmEZgNPW+JAP3dvigOG3aUoJzEXbCuffITtrDPP36z+s09flnwfIyxNtjyO2EASasfET8HQYpPg/YKd+zwiVjG2Z68R1UHPu/FHVr69jw93Z4x94Pm1ehDlK8COmKIJqMds6C+lBqbUuqpLEKy/1yNFBaQOPLg3EO+UrcVLkpt5hjnqUoj8jZKTC1eiYfyHqEdXk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(921020)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3BvaHdzYXNTVndOekt2RDc2b2dlbFlYSXBNZ203UGU0VWlZSDFrdzBxdkw0?=
 =?utf-8?B?UjBYU2NOdXRoL21YaWpEYWxHMXk4TGVERUFMaGpUUWFKVzVVK0UzZzVaUjMx?=
 =?utf-8?B?c1p3VmlxRmVQYkRBcGhzRlBkZTRvTWdYTTZwY0kvbUtGd0ZiMFRyUFJtU2s3?=
 =?utf-8?B?ZUl0MHg4QzNIdXI4Y2tJMHliUEJ0ZEhYd0E0ZjZQMG0vbThXcU1FZmQ1Ymh5?=
 =?utf-8?B?UWplMEx2N29RNnhpVFgzekFpYWx0Z0l4Uk1vTG5oU3duMm1IcjdUYlFSV2RV?=
 =?utf-8?B?bjhqTXY5dVcrdjBWQkRxbFhBNDFTaDJyRG9GTjNwNDFwQWJMVjBoRzZYL3g5?=
 =?utf-8?B?U3N2Q0FFZ01UaTN1T2JPUWtBdmNBUFZhamd1UnVtcFFtS0huNVZrcjJYR0Za?=
 =?utf-8?B?Qk5CTEdNQzhhUTF6cDhYTTlyQmdBUm8vUUdjL2pXUHRzOVJuL0RQVEV5Nnd5?=
 =?utf-8?B?S0UrY2Q1L2ZVSXFjWWptcFd2bjJxTXdjVVFSSktqYW16eXhhcWtzeWlZcEti?=
 =?utf-8?B?MVNOYWQvMmRyUFppSVdQOFMrK1ZXYVljRVJhR1pjMW5KWGVmZ29BQWEzT2lT?=
 =?utf-8?B?bmJlVkVMK0ZmT0gxUGpuYjNUY2VQYUNJdVZiRmVVWDlLN3hEZE8vTFlueEJr?=
 =?utf-8?B?eC9zcFMvUXo4blpLOFVRUWU4WVBqQksyS0xURWc2Q21KMWI5c2lYVkJwY1Ji?=
 =?utf-8?B?YmZKK0c5WmRteUlFZnl0b1JtVWRNd2RXQ2E5QVRXMEg4aUczV3hkby92TWZU?=
 =?utf-8?B?MkF3UlIrNW5rYnlLNzNVNG0yT3dVRUYyYS9nL3I2ZldkUGFPeW4yb2lJdzBn?=
 =?utf-8?B?WjFwd0drOW9iVFgvODlqQnhCTFdsbWo5Tmg2clRBMitSSjFnZEJvczkvTldq?=
 =?utf-8?B?dVJiaFpvSC9hV3IrZXJRQ21maU5RbmFTb2pEdzl4TWZqd0pqc2Z3Y0pnWHpi?=
 =?utf-8?B?ZDRyOVByYzA5cEwvbnZxV1J5dEZEWXpaQ2ZxSzAyL1RGN3dlRy9UNDRkb3JE?=
 =?utf-8?B?SC9HVXp1aXVBQUdJR1RyWUgwNmVnbG5kNE1sUkNxTzhzOVBTYWZqbDBsWm05?=
 =?utf-8?B?ZjRISWdNaDhpMU82MEpGOGlaTGszZUd5TUhldExNbzE1Rk1mYnByRHpUVTBZ?=
 =?utf-8?B?cUYyQXNoMlk1bk1RcElaUXVJRWxpcng5OFdnNlp6ZW9vcEc4dWdjR2VEbU1p?=
 =?utf-8?B?YjQreGlFUjFnTUhPc1hOalhLZGNLL2gwVjVoRm1jVVhueXhHdEhiZDZ6N1RB?=
 =?utf-8?B?S1IwM0JlREtxRER5SmZJNTdPNGlPK21rbzN6SzkvcTFnWVdTM0xETFppWjk4?=
 =?utf-8?B?WVhNbExVOG9uT1Jpc1hESi9mcmlPSkhnaFFBN044UGNwb3EyQXhGcTFtV1Q0?=
 =?utf-8?B?MHRKZ0MrcnNMSEFoOFAvNHcrMHhpays4T2pRZkIxWW9VeUQ0eW9HQlhwUVEv?=
 =?utf-8?B?eGcyUURHNEhobi81YkJWaFRUZUx0WHQwWFNiTFpuVStrZHFTbCtEdG1NL3Ri?=
 =?utf-8?B?N3lHOVhmckV5VXB0SHhhSFJQZnpWQ3BDTXYyNGwrZGxZaUsyMWNYL3c2RHhm?=
 =?utf-8?B?R0t6czJkcXczbTVlWDJLQnZYUmZ6dG8rUkVGZThwcUl2MG9LQUdzUEw4TFJl?=
 =?utf-8?B?NW0reUR6clhGOCtwNEpwNGdnYlF4V1FGY1d6eHBPdXkxbkxhOW1KWkpCVkNu?=
 =?utf-8?B?ekNkeU0ydHBmSUQ0NWN2UFcvdXR3cUpDdmhuOVl3cWRGR1E1UW5IWmI0VlVF?=
 =?utf-8?B?d2VMODlhczJIcmNlV0tid0praHkrc3N2cjNDbllPTGkzSFl3MlRxQUgxN0Fs?=
 =?utf-8?B?cm41WWVsYTZodFg4R2M4Zm5ZUUFLM2RJMEVEbzNNQkp1NjhtK0JhN0ZIRlVk?=
 =?utf-8?B?dkJCN2d5M2VJTGhYY1NNRmtrZ0xiZWg5ZUdDUGxLUFVwbHc5dk9HbXRLMUNK?=
 =?utf-8?B?ZWpHRDhEeUFPdTBHaWorNjJpZGtEajlOdm4yaXVYenFkUHM5eXVObmxhaG95?=
 =?utf-8?B?R0hKOUVkTzY2VWh4YXBJTkIzUHVSRWZkeVQ4cTVwNkpDNE41ZHlrdTcyLzVM?=
 =?utf-8?B?YVVmMGc3L2xhUUx2YlIyU1pkRWZEczFKYVBhNmg2TWpONnhWRVkzS2FFR3l0?=
 =?utf-8?B?czNXOXlVUEVQeVVPd1A4WjdFQ3NubDRyZW10UXNlaU0wSWQ2OG9mY1Y2dUgy?=
 =?utf-8?B?c3dDc3JTVFFuRGFxYUhsTStxdUVlbXVBN21jQ0twYTZrYnRBMzBuR25MWmY1?=
 =?utf-8?B?bFBsenFUZlJBWHpLb0xJZ3lheXUzclUxSldFRGovaU43MTQzd1dWZTlJeG03?=
 =?utf-8?B?TGx0VjJCK013SDlSNzJ3ZnNJb2dGTzJCVXNZSmh2anA1dUJjaHc2eHY4eTR2?=
 =?utf-8?Q?jBTTlCEbCbtq9eKI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a030a4c-5038-42f8-7d55-08deb6bb50bc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 22:01:16.4556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxWGOMJxSlLGKAlTA4NV1vJ0lOMJZd4+5q94Pj7r10+1Zu4AuD1mG9kOEYRjUhwZVseCvzk3FSDXgrz4IeUGrVRWlc8ocePgqoonbkKVKJYpHoTd6A6F3pC/C6HILy/e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8029
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10583-lists,dmaengine=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: D75C359BADB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Li <Frank.Li@nxp.com>

dmaengine_terminate_sync() cancels all pending requests. Calling it for
every DMA transfer is unnecessary and counterproductive. This function is
generally intended for cleanup paths such as module removal, device close,
or unbind operations.

Remove the redundant calls for success path and keep it only at error path.

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
This one also fix stress test failure after remove mutex and use new API
dmaengine_prep_slave_sg_config().
---
 drivers/nvme/target/pci-epf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 4e9db96ebfecd..2afe8f4d0e461 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -420,10 +420,9 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 	if (dma_sync_wait(chan, cookie) != DMA_COMPLETE) {
 		dev_err(dev, "DMA transfer failed\n");
 		ret = -EIO;
+		dmaengine_terminate_sync(chan);
 	}
 
-	dmaengine_terminate_sync(chan);
-
 unmap:
 	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
 

-- 
2.43.0


