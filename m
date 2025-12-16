Return-Path: <dmaengine+bounces-7672-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 78155CC3DD3
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FB65300A571
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 15:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DEC34E273;
	Tue, 16 Dec 2025 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hBjZdeaH"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013035.outbound.protection.outlook.com [52.101.83.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0488234E263;
	Tue, 16 Dec 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897820; cv=fail; b=JLeG6x8eE6x77iZYdqYPKvbA5sZInjAqjTdzEtgPfSMkW5YxcCbAtfNLmte6BbAFfjpmM7xsnkIT95xKfjf/7iBnalJNPz8ZJ38To0UYsnCclCbaB8ZYcbmJfXEMtolYuamys1Z+aYnF7RoYrYlN7PACuytpwaU1x4kW3sfceQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897820; c=relaxed/simple;
	bh=LEaMn41USI3x+OHHK1tG+yExfVsPyncuc6NyMQ7P+z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iuFp9BrgPOxMdii/WhMzzYniNGlaXUSJ/vh5/+G9a0/Suho7gjiX578bIPJeYbVWqLB4KU8xqbsExKLXxpL1/rrhbUWVYtUYCERn7r4ew0lTEJYBGjeyM4jxs+27DtquwfP4G3QEmJNXiu20hbCQeeGTJss8aKmaDzZGu8Xrbik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hBjZdeaH; arc=fail smtp.client-ip=52.101.83.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoCC+RWM9lmFhV1uybYEdtfqEAY8JGdT/9FSkRJT+pCQE5I5gvvJAtNyjMadKBWpF/mRtTJGlORTTdklprFBN28ix07qbbiD5o8PnhDA5pelA+AzTt6Hq0TG7qMMLYcS+QZD8Yf94A7UeMmrThS6Ru1uw4DiTx2PdeRISmwp6OyopE+7xSqv0QivnbsRrcs1cxV01J1ohT/QdbOd5PwlLUz8X2G4C6FjILAI0UanMqwXZDpxJECpZ4pskYAt6CnFqwwkKy/B6WqMgxxZo5epIKE6YDbce7WwHpPj2qox3NNpXybeL41ayxh6DDS8mu6mU8dhKPmq81ILTQynREhKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKGr7WdPEWXABnKqkOSBYH3Okb9OT+K/Fy/JpoNPO5c=;
 b=VenX5yZunlrsPp6NjmclQ65YOpINM8ptnpGzZU8MiRCHlGwzSsKHKONmBLCFdfV/pN0WoUvg+pw0/Xw32driHqiAM3SfzlUIboRES1Xm0mH1fP8Y1Rr2KkVt4EJ00iZJU+62sI31FhjfvVCk9T4qAH3Dmbk1U0xQvzWztvyoJmEOxTvdrIpdlVl42evqguP1PqkpkqraoVibpEcNVXdlHMHaWSfoKeRIbg9ICtG2QoAaHso7iv2LSKDln1ByO0lAsZ3kRQHEd1pMzj9j8/593CcIs313jnG7zTbBfUmP2vrhxGITDwHSAqqokUciu71KrCRBKxetUaIki+3Ep5xGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKGr7WdPEWXABnKqkOSBYH3Okb9OT+K/Fy/JpoNPO5c=;
 b=hBjZdeaH16z68aWgJb+1OHn9aUx+iFcTFfG5R5Ir2MMRG8Es0PNIuyMuZ1CZET12QCejaurGAN2kExEhHbdtlY8QsUFKx0BRAcU4VgVtUM23rOc94W/FpntGxpPGUvTrwZjM8aY4ltVbvMJYZPmtVVDM9oeCdG5AeMsQ8SAhtoB5I5YxpqO6WTFxHYzaSAwGWwnwa5VP54jGIqdrHgtnQxlNeBOEnzeTQf6ecN4LKO35KpOaH3ebkgPkbHW9d5982y4OXltLNBHfG0b1SxzXPAsbhrTGgRTWKIJjBGPnRNeEolpjBYOg4J0f0Q1RLVqlvHu+QtlCd/IP0iQ1ImK4+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV1PR04MB11516.eurprd04.prod.outlook.com (2603:10a6:150:284::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 15:10:12 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 15:10:12 +0000
Date: Tue, 16 Dec 2025 10:10:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 0/8] dmaengine: Add new API to combine onfiguration and
 descriptor preparation
Message-ID: <aUF2SX/6bV2lHtF0@lizhi-Precision-Tower-5810>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
 <aUFUX0e_h7RGAecz@vaman>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUFUX0e_h7RGAecz@vaman>
X-ClientProxiedBy: BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::6) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV1PR04MB11516:EE_
X-MS-Office365-Filtering-Correlation-Id: 93707ad2-31f6-4b8a-9680-08de3cb535a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hp2J0XNitOzsxF0SsSV406gnI+wbvIuIibWVazSAELs7KFuSm7MmtOsDfFOF?=
 =?us-ascii?Q?VUc99MktdjW0+cM38j6LXoa7SkjJN0Km8JiEN9/ExhfuaHWuQhgdqpht+nfu?=
 =?us-ascii?Q?tfVkI0NDoHRFn5VPsC/SvKtcGk16ZSU/MWF9g5wrMW5m/gHvAP8M0y3GuFJy?=
 =?us-ascii?Q?ae5Mr6+vSaA4XaPCU44wko5go81jCQE18KEKYDTL8RRXwtuMe4DyWm5MRbAM?=
 =?us-ascii?Q?g0CmvpNpc3LfqXkw1TXesFFXmK//tPvyI869vUFnVf8C4ffQXm7HWkJX5S7K?=
 =?us-ascii?Q?DxeoTJxaTgQ3cQiWqOxMzWliyIjzp/kBxNgk8Pdx37zJ4Mx0FHmoavnnS207?=
 =?us-ascii?Q?TifbHN+Ubf/5bsNmpC20iLVrxCgfs660ijgfd700j9+7wcqPRIp/U7r6cfJA?=
 =?us-ascii?Q?0Z4x9y+vQP2DZRI39UZysq3QhD9/fgwYgZkPeJvBFQ2zTlgGgu5nV2rDeE+H?=
 =?us-ascii?Q?+f2jjG25GneN419UfRJZw9I5zngLKjvJHE036+Q1Ab6ANR1KSTcPFYc1uVY3?=
 =?us-ascii?Q?ORXBqCmFKAmvXhc/IOECuzxv1wOpLV+ED7K9lpJYSmYxpUWN2zRrfR+SjS99?=
 =?us-ascii?Q?CyOjn/QRiCu+aI1dzuGwhJO0ejEdvM2R/ESPjauT7lOhAonyz2Dl1hK51iIF?=
 =?us-ascii?Q?TxTtEKJ7caUG3ZSNzZXXXs9oLaBiEU7ElhSe7g4gNtFUEvTBFLfBJjqdE1P3?=
 =?us-ascii?Q?S3C5hhLWCMwtm6mqg2Q+DZgL79EtOP0gZ0RW0gm2lUUpgC7n3I+BJ+mEYJ2H?=
 =?us-ascii?Q?IO6uUrXIXgNnW0WcyfhXp4Zw/CP0UdCUFrEDGGrIVywKw/j//XaugEIs4m13?=
 =?us-ascii?Q?hi+YosnJiK+o3l0eqTah5CoGXZePzKZxkW3whrDPvbkCigdsQ0V38jP6OaA9?=
 =?us-ascii?Q?MX5WPVvj7EtI2dCt7wbQq7Bv/fKi6mvZtVpxS4wXmnyF1Kw1U2jKqbwnLNE9?=
 =?us-ascii?Q?wXRQZJ87oTIat5N2KZfsSOspk+t68IJibhzYYAIy4BJUHrRBtp6CWf6wR0Pv?=
 =?us-ascii?Q?1aKeN7AxgRh2GpkAnkQ1Qp94vBE0BIbZg5wD5ZJGs4Sqb6viht0smno/tz5H?=
 =?us-ascii?Q?OhvGou8deAAmj2z0/LKrY5dF6eh72B9OtvT2Mu8qlmKdgFl+ez0jiw/Kx+Jl?=
 =?us-ascii?Q?DV/wEj/IBFADKGaw42EUOXA6zIKAcgmw9zxtLAb5rKEalUxFtRVHZzDwNNdS?=
 =?us-ascii?Q?LJEeYR4SM2dZDxvA/fLPWSVHhLak56UJfHdu+3w1FMak9NejbIS3Fr3NHfYp?=
 =?us-ascii?Q?NEAecIXh4mrsnAM73PY1cVzMe5wDGzN5jAgwBtKwWQcviFDIGy3Hn3Lwdmpx?=
 =?us-ascii?Q?RlgUlStoDdlh72+2CHsipzHytRiYG8TRzuRNbvu4fRnvVhFBJ8C1s59PSRYq?=
 =?us-ascii?Q?6RBBpmev9D+cQ0letFuID6H2Q0OXj6wGp2T2IZv4mSLx7gALdLAcIMOasM3y?=
 =?us-ascii?Q?u9gjpAmcEUHDQSinTqslADAHWNTpiKgCIhtsXmljrXP8rRrbQFF0RbHx8xO7?=
 =?us-ascii?Q?QoLRql9qQvxbHaEnoUO+wcCVeUKc016m20t5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2+BIrgwOGqOxfHrInobfDfXk8OUM6IqDJ+l2QNInscL3u+v/Dd/c4NWImd5E?=
 =?us-ascii?Q?H2VEmwT/JfWcqFXEInNs65kF1GH8IfSl93KJ3ol80FapuW4+0Cc9nRVezZ10?=
 =?us-ascii?Q?mRJyGzNaqjlAisd9wMV7szgaamAcOKFx/VAWLImdkA7nToH4mGloGvk50+Fs?=
 =?us-ascii?Q?xdVXfsyXa+S3QDKQ8Rwz7dg+4shgf7LOp1RuPSj5XNQx6ZPcqa5LeWpbx/qT?=
 =?us-ascii?Q?BiATR077ljI6hInUFSkQPQgvIbSTNtrYJed70zHH+DUF+QXrYVjsvRYFWUg/?=
 =?us-ascii?Q?1W8dH1haWEejTMgYqxE4N+OFifdpgcDiB2nMtH7v21d8XunHJTnyhw8peW47?=
 =?us-ascii?Q?+okARPBVDZ9oZECpvmQS17+7t0dXcgO2jhlr9Ip7OA8+P+wU339Dg3RY5pSy?=
 =?us-ascii?Q?g971Ro5Tv7Q4IYis5EnM0nxN1nWRyw6BJBKUSEdgRGuc/j9L7Ni0yf42huT3?=
 =?us-ascii?Q?7mE8/EXZRNUc5DAuvXOeJzmENFT/Bj9CIlRd+BotHyX1hp7Sf1yepUWQOhqf?=
 =?us-ascii?Q?svrP71cYWiRpvh/6zLDbJLhGsLI9AG6WyOdBuf1kQhyEEJ2H05BCbrbFtL4d?=
 =?us-ascii?Q?Yurm234VNlfXys7/vT0ja6M4OSqveGf8XTST6cS4HgmT4aQVyMdkciBGYA9M?=
 =?us-ascii?Q?lCVrPx6ddvrMILCB6zfzodaDyG2MqoMjuaKOWTl6FdtI2imSnEwgSne34Tnz?=
 =?us-ascii?Q?eNgfEM/JTkYAlwrB8Jica8fu40OTaiseTN1ZvawJSni6/mxDilYHoIbZuU3Y?=
 =?us-ascii?Q?inMdgKm2HjbaZqFjGrBMWIXh6BJKoxcTRSalvjJo370psEgm/r3soVnWhgQm?=
 =?us-ascii?Q?VjPAWdcHtLCrktihtPhJK2Q+3NzMnr6HWKPcuP1dMI2YPH8lNEH94r9+RLsG?=
 =?us-ascii?Q?p+cb7YXZExnIJbwL5gh47ftTiWBpzhdRX7WGtrcq/AYZ2D8BI5poBhf/jgHX?=
 =?us-ascii?Q?q/4gVQ+bhCbt80QrmoNxmaWHfiK2KtYHsMHpz3YHMebYCNrZli9YlWJRH2XL?=
 =?us-ascii?Q?LHJtWc/2k0Bvifl/n7VUI6yiinTOug0lmYFLmkoB+yX8d6i3eEGRy/WDWR9J?=
 =?us-ascii?Q?Qg/P7PAiG/5iCoDN5ydufL1HDF0H+TG1/g3d7eyIoqiRdqENAYvU7Q+FVvxQ?=
 =?us-ascii?Q?vof/2Tsx6AC9n77uOs9EiIeBlec5r1YH/K1ULZf+oQok1IrQYY8SHyFrTV01?=
 =?us-ascii?Q?nit2TYQZ/y2304cfpBInS9tiXP2wPmA7UuCPPuH9aBhADxSZAucAsOVaIpkD?=
 =?us-ascii?Q?Ve3IIuvuUtnmTh20UB3fCr0xPCqx+eEBFGtK9kzFQOu4ySchEqjWwoCfeEK/?=
 =?us-ascii?Q?Dw3oT2Zr5MTzFG8SJLrZZTNCc8v0d8C6bT3kcpmSB8NjiAa5qLE6HJsXw34C?=
 =?us-ascii?Q?YObww3N8zYA9elAITaNoMeES6RUUYaBEKc6wRcbYsB1S19d3M2fT8V+KAlpW?=
 =?us-ascii?Q?Y4JuOXsUTMyeKRsIVmqF4dWbvJOl3aywihs3hgi4vbsfbOlkeUIz0VyngExj?=
 =?us-ascii?Q?j9aoLJVYn8+sWUm3BvHvg618Nq8PFlZM4fsksTyh0WmFzBMKqDqOLJxc0+qX?=
 =?us-ascii?Q?dLr7736vVruoDLCXcV4eL3/DPbkh62bY0APc3I4A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93707ad2-31f6-4b8a-9680-08de3cb535a8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 15:10:12.1898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7U2BvgqZfnD6TOjyFC/mC8ZKehhAl1Q1tDRTWS+BpAbDY+nojHLyyfi7dZe3qtqIpCeHuBnmYvqj8QyXOq9cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11516

On Tue, Dec 16, 2025 at 06:15:19PM +0530, Vinod Koul wrote:
> On 08-12-25, 12:09, Frank Li wrote:
>
> Spell check on subject please :-)
>
> > Previously, configuration and preparation required two separate calls. This
> > works well when configuration is done only once during initialization.
> >
> > However, in cases where the burst length or source/destination address must
> > be adjusted for each transfer, calling two functions is verbose.
> >
> > 	if (dmaengine_slave_config(chan, &sconf)) {
> > 		dev_err(dev, "DMA slave config fail\n");
> > 		return -EIO;
> > 	}
> >
> > 	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);
> >
> > After new API added
> >
> > 	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags, &sconf);
>
> Nak, we cant change the API like this.

Sorry, it is typo here. in patch
	dmaengine_prep_slave_single_config(chan, dma_local, len, dir, flags, &sconf);

> I agree that you can add a new way to call dmaengine_slave_config() and
> dmaengine_prep_slave_single() together.
> maybe dmaengine_prep_config_perip_single() (yes we can go away with slave, but
> cant drop it, as absence means something else entire).

how about dmaengine_prep_peripheral_single() and dmaengine_prep_peripheral_sg()
to align recent added "dmaengine_prep_peripheral_dma_vec()"

I think "peripheral" also is reduntant. dmaengine_prep_single() and
dmaengine_prep_sg() should be enough because
- dmaengine_prep_dma_cyclic() is actually work with prepiperial FIFO
- some prepierial FIFO work like memory, by use shared memory method, like
PCIe map windows.
- argument: config and dir already passdown information to indicate if it
is device preiperial. So needn't indicate at function name.
- maybe later extend to support mem to mem by config becuase adjust burst
size for difference alignment or difference bus fabric port to optimaze
performance.

Frank

>
> I would like to retain the dmaengine_prep_slave_single() as an API for
> users to call and invoke. There are users who configure channel once as
> well
>
> >
> > Additional, prevous two calls requires additional locking to ensure both
> > steps complete atomically.
> >
> >     mutex_lock()
> >     dmaengine_slave_config()
> >     dmaengine_prep_slave_single()
> >     mutex_unlock()
> >
> > after new API added, mutex lock can be moved. See patch
> >      nvmet: pci-epf: Use dmaengine_prep_slave_single_config() API
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Frank Li (8):
> >       dmaengine: Add API to combine configuration and preparation (sg and single)
> >       PCI: endpoint: pci-epf-test: use new DMA API to simple code
> >       dmaengine: dw-edma: Use new .device_prep_slave_sg_config() callback
> >       dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()
> >       nvmet: pci-epf: Remove unnecessary dmaengine_terminate_sync() on each DMA transfer
> >       nvmet: pci-epf: Use dmaengine_prep_slave_single_config() API
> >       PCI: epf-mhi:Using new API dmaengine_prep_slave_single_config() to simple code.
> >       crypto: atmel: Use dmaengine_prep_slave_single_config() API
> >
> >  drivers/crypto/atmel-aes.c                    | 10 ++---
> >  drivers/dma/dw-edma/dw-edma-core.c            | 38 +++++++++++-----
> >  drivers/nvme/target/pci-epf.c                 | 21 +++------
> >  drivers/pci/endpoint/functions/pci-epf-mhi.c  | 52 +++++++---------------
> >  drivers/pci/endpoint/functions/pci-epf-test.c |  8 +---
> >  include/linux/dmaengine.h                     | 64 ++++++++++++++++++++++++---
> >  6 files changed, 111 insertions(+), 82 deletions(-)
> > ---
> > base-commit: bc04acf4aeca588496124a6cf54bfce3db327039
> > change-id: 20251204-dma_prep_config-654170d245a2
> >
> > Best regards,
> > --
> > Frank Li <Frank.Li@nxp.com>
>
> --
> ~Vinod

