Return-Path: <dmaengine+bounces-6368-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6067DB42425
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 16:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45B3189056B
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CE32F658E;
	Wed,  3 Sep 2025 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D9RmjCmx"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143ED2F60A7;
	Wed,  3 Sep 2025 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911361; cv=fail; b=DL+KVskMVG+5X8kSM7chx0YYqbjRTKlGasIYzFWqeYeod+rBMHjJpnIEdui+tQsyjgg61dXwn+pkXRbnA76l7I3lav8wgEffjPu2BaA28D4q4r5MetMM/uuP8Ik43XdoZB306KTn77+4SQG+4XJf7xMvkUyXzwjx8aK/a/41PFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911361; c=relaxed/simple;
	bh=LEylzJwxebI0hyKDr1uoUREA71hZmI60omZl1ikjM4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ACpwmVCkx7yFAO7jStUiobDQXUKWeB29rWLPr+TyE3c9/i0ebj/QANPvh9Q/wKYKqD1p0gqIJZg5KxPO44LRxR3BFkk6bez43Lgec9YiQbEy8l2eIqtVChoF7t75jcicMABUIjA3TgljUyOVlwHj/yq5tijTj1e3niUjhkcExUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D9RmjCmx; arc=fail smtp.client-ip=52.101.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZSjGVT+UW2SnoZ/be8jZ+973WHKFO+i1pa/u02OPpcOwMN9Rcm0d2k408jylsIxtocSK4kIEEXXS0b6n6Qs7YcjqJlFLVnp4XNmlVk6bGbQeNh8y/tsXf+u7qOXa9Z+xh5qCAGtP3DbKj0lFtkvzh2sy0zGG1GORW6231ECTtUYvofQhBikWSkH56UA0JxComFFTp3bF32S0jwpLfH3GWFv8PmF5KrwsxToxFKi5tMYKbYPu+7HnaqbJFXkJh+W1X4LhXK4WJFeuVgtuwx844K1ZItnYwxOxCN/fB888+IYPmVS0xYLkF5avNewgXsx8DoEXrtsO8J44ldl5O1AUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W18pVm0xKISXgoLnbsgEyTuJbkKff+G5hzJ+STp3dcc=;
 b=Zo1SMIp/sIoAeOb5Ogg96ar6Bz0BtNbtFpnJqWb6E37qgADQrH40a/46AdneUJunKNzfyVvYvnM0vHS1RGjJSX/JygbEDFdU6310NsiQxYVsoLgdZfKelUvarOuTaV2BCH8esswfsD2KyARhSoqpKAplvqqb9Yd3gUUY7rPz9QBpGBQfCO6DjecoWjF/SOauocIPel5+GCcRmxy0FTLEwpd/PBkY5+h+uNqCQvsKeCiUcMshkeo0x9hvn0XeKM7mMW3ytwRJ6bcx/N20NrQw9ILrYMOf9wY9ETfZ0m2FxBO05BJGNGASyu5g3+6txDADFJitPDSZlekbPcbpZiAzyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W18pVm0xKISXgoLnbsgEyTuJbkKff+G5hzJ+STp3dcc=;
 b=D9RmjCmxe2aLCtUjQ6uwLV9FkKgJfKuuQZWPNPu9xCqLIDgebuGn8W0NUQeu6r7MybsFLfjiBd7u8z8dJbCRtnsb8y5IQ345GubcakI6tbj9oWQ/Lhkdy/61Vcv9RJKwVcngceT8iNtLkTQjALLFkV+Zo8o10sAkbHbsmnHty82ubeD2qg2l3PvUEq+X1F9cb6Rzc254x+kB5cQqicO55L3FGSf0CQW5aB9qTRLpIcVo6iMBDJnfk2A+MS2vf2oUMmHNUDTVWjJCbePIsDWXbDvMAy5HUCe2wc8FXTnBycuOkESoJyp3dGmePTzcSqJiV5JlAT0Bo7CFNIufZ70HkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 14:55:55 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 14:55:54 +0000
Date: Wed, 3 Sep 2025 10:55:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] dmaengine: imx-sdma: cosmetic cleanup
Message-ID: <aLhW8XQV/PSqCZrx@lizhi-Precision-Tower-5810>
References: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
 <20250903-v6-16-topic-sdma-v1-3-ac7bab629e8b@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-v6-16-topic-sdma-v1-3-ac7bab629e8b@pengutronix.de>
X-ClientProxiedBy: BYAPR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:a03:114::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB9PR04MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 360f325f-b548-48d1-4f1a-08ddeaf9fb1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5D2hw2uJPLZp08WG7Orx05sE0RYKtM0CCFlEZ+8dWMa5J2z9aD/7dXNE4xDV?=
 =?us-ascii?Q?YKYuUPgBpVadHeM2rhjNmihANdN0cd93beWMR+dSEOXN/8lFer4zk27BNQd5?=
 =?us-ascii?Q?jIEh8O9c/IWTcNJ7Af4GsnkfjulAf5ihb1DNjTgZmT/1PulHdQa2MWz+p5pW?=
 =?us-ascii?Q?N/DUgtqgXOoz0YmkkDRBW9J6R2NNxmewWRCvHKkzYIKMervfy5Q1j4G1rvcC?=
 =?us-ascii?Q?YPiPaiteP0xJvOvea1FPImtNaQcqL33k85f+qIvkqrb8wXKkwqQXk9S59QVe?=
 =?us-ascii?Q?WFS84JSp40EV21weraj2d4J81UxENkhg/9TIIJuaufvSJpZL1q9plKjvwbQt?=
 =?us-ascii?Q?tWJkXSjy7XtIn9mQnyYFWhZpCMyisaiTCVGZMHs2YE3ZiQY1Q95Ih60WE/96?=
 =?us-ascii?Q?kZ3D02eK8Gm4kQHPyTxmZT8uJdEeHWIUJGUpDOzfff3wqkYMHziqhkda35d4?=
 =?us-ascii?Q?KhERTOfRsqJWSAKvgoKzMBLvWCsEIpFhe4EliiuD8TSuA/L8+s6MTJeSc3gV?=
 =?us-ascii?Q?8GkhCfx2gR7a7gcD7qQl16nEMieLWeE2wsI3RTsl7M//cOYi8HJ/sAxae/vh?=
 =?us-ascii?Q?QJwvOHh3qTj8lFl6LycSZBxUFbJZkTUS9/jXDHMBvC9hOM8PzX9UVcxOwd9P?=
 =?us-ascii?Q?B4D7NFiuw1AaXQbaq4zFlRb40ofnobVisyIGogZXeA5x7vn2rJ2L3TW1YgOG?=
 =?us-ascii?Q?KlYGD1rDg4WIhVPeeolPnE1dCOc3mX5SnZ2AiayAu88NITMqg1x5DveTW3n6?=
 =?us-ascii?Q?pG7b0Yp3uJNxO6JJ+iwbnr06QP0cDiWpTU64JTPngrlvA3u7ZvVbCFc8cZ/K?=
 =?us-ascii?Q?jLqqrm2etzae4MLcbu10xGtOuHd0PvrPp1w7CNqKfMVR0DgMFsGmoSejJL4l?=
 =?us-ascii?Q?2vrqOBnI0rPS6038//UIOEGQbAFS3sXtg0N5fhTilht1NJfGnw38IUFuSlkI?=
 =?us-ascii?Q?blNxwCdE5NDTK6bU7JmpgFZdU5qEhXsdzqIFyWfH+VWWX6e6l8Hr0Fm+LXE/?=
 =?us-ascii?Q?UzWf+yro8ntoLhNFhFziETgDQETG2a1q01fpeKWeoVpKGXcWvQXLF/WLrdaf?=
 =?us-ascii?Q?f4xY9vqr472MqBuwZeCh/BbLvVrQr57QL73Xz8+iRWQ7997kHm9LV1QzxMW5?=
 =?us-ascii?Q?58F0yinWV8DkDcEbzyGaCzo5bKmqD+75pZtOvvGVXNWcdFReUY4WpC5K4peN?=
 =?us-ascii?Q?yiGEU9UPj+7BlTLZEeM3VDPuizLOGiuiHDTcZsjYKzXbfJjGkUKo0qU84SiZ?=
 =?us-ascii?Q?syG8C2Tm5bdwe94DQXQKkbWD8UBZ0ACg69Sw/YDuShfcKgFWxo4znWpAhm0U?=
 =?us-ascii?Q?zaGTUd1RzCa3/XP5ott2vBPsMd0ek47hKvMjCMJV0uS8ciYzQuwtBFCtHwM5?=
 =?us-ascii?Q?8JylyfG16cF0uWlEfK5825oTm1O/H+Qz92z3Qya0cVgWod++dlHZakNfQd6H?=
 =?us-ascii?Q?q3TDncJbowTIsfmJi0CK3fkT8qYRjTYek8ClKbeyQBcZIO79rmApDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Xsh6iz412epglYGvYAuuiGDKiw1y9LTAwCUEhYeaPmWeWL9PziSdqeYffqW?=
 =?us-ascii?Q?5TsDDziuO3hFf7+GgraH6hcqZd2K7GlwOP2BFDJgZyjn+tXoBosBPhZ6Pw7x?=
 =?us-ascii?Q?Tc21ktbQRI/Bwj03dPrq8K9xtdXvC3bfPdr15IkoPmu2ak10NGgzk94Riwi8?=
 =?us-ascii?Q?oqYfOxriElCOnfNB/hkCXOcKbnGB66085ZaT2If9bmT31E/mG3l/Jrm4EAr2?=
 =?us-ascii?Q?IChOWNFunuVC1lrqdNvptF/Lxyw7z6obCDN0vtXUHQUACHtq7NKdHvGDs6L/?=
 =?us-ascii?Q?R0HW6w3vHgO4r4QM8PsypVZnf/T7udD9srCz8tC9clbhiQblZKC5inbJxNuz?=
 =?us-ascii?Q?EfNtH8HrK79o46PeuwG4sx1v9mB1nmqKpwaItEVzSuUy8Zekk1aUyF3UfP1f?=
 =?us-ascii?Q?HBtZK1XAw7eNTeLnSvYmfe74/7WDBVl3P/e7NSAjUFwLVi0m3SEVnwiNBL2e?=
 =?us-ascii?Q?Q1zxCStIGThB/4xr6SNccIVLgFoNhw2djri8VBVLLRZXPgUn2LOc340hfM1T?=
 =?us-ascii?Q?KaeKO/zV1/7WLTAwkMIR1LtcPdEvh1Eu0ql9L9n/yBkL6jm0t9r3b+isynrS?=
 =?us-ascii?Q?Pz7gRGtmhsBAYnHvvdWuaoUrl7wUQwF+QiFBo2HxMrAXuq71L372FeOWnSBD?=
 =?us-ascii?Q?eWoTZX00qkJVJiXl+icPINLDhiqPgFf+++Q1SlWS1MKWRSnBhS2jTQw2QBH9?=
 =?us-ascii?Q?mZOFiEoRfXSybrpeUXx2vcyW0e41by63V6JRbo0QPQM4CYSW1k85CcXZq4zz?=
 =?us-ascii?Q?+6Ac4PL03xt+nWlibTVSkm9njYC1j8loNdORrqDJhxHjz02r/2RCjlyJ6TPa?=
 =?us-ascii?Q?JsYqS6im+XBj+6sNkOc/9W0KqGycWHGOZSIFdDj4VwvgoeWi2myjbJGvfLvq?=
 =?us-ascii?Q?laywSKtzS1ZyCIwFqNc0Bz++PNhKSDiwRFr+8welCoBdfbBJfG1IcB7o0b9F?=
 =?us-ascii?Q?uELxvWWyGsmJiTg8wI47e+gu0dsXIPkzj9COmiLwWLxa5qKyWf5vE1R2NLBj?=
 =?us-ascii?Q?vtxH2XHsqoRbjqbvUxoUKneeYG5uykl/DnBYGRLscArEFeHFwVIsT5tV9Sqp?=
 =?us-ascii?Q?p44ytHAGeEg8KSOy2sPulf71WJXSWeX/+8TPBgqlyZcDufsSG4PA16heVjcW?=
 =?us-ascii?Q?sy5aDYDjxXyXd7cbaQQnWOMBRR1zX5BWpdTRxfP3Ry2IioOGDmdKFEgj+9Iy?=
 =?us-ascii?Q?WU1JIn2GekWAmNdsIj61+Nz7o7UeuzFJfdPF0fi++eAtslXk0u6AYHFfYdWp?=
 =?us-ascii?Q?3LuPYh/8IDoiUv0jHtHuxCF7M0Jf5XwUm24Yb8UZ9qZ6nB0zSpkZvTL6Zpni?=
 =?us-ascii?Q?w9irRBD3nex0tw2tGAOL8FWsnQDKVuaUXa8+9Yiz3HDWCjADZ5v4QxSHTHwk?=
 =?us-ascii?Q?DcvcClZmbpT+y+A47yV1hql7G4T2aB4xvf7P3nCcbUKfVRhWQDjTS0ImUX7x?=
 =?us-ascii?Q?ZgkkdtfWRkHQfFgURLzJJkvYdBQXhp89M6cYzbcMGKtrMqi/1c8CAPMjEKTK?=
 =?us-ascii?Q?BPfjaK+cokZLqKg3dgRzSwX2CQ8zCl18JASn3P+I5hDahUSwEvjQCul4Mf3S?=
 =?us-ascii?Q?2ZC8NkRRaYkabTAm/ObqEqRFOaS+cWTYehMtYflu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360f325f-b548-48d1-4f1a-08ddeaf9fb1d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 14:55:54.1322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfdCwM3EYLqmGay7HFJZD5pYfR6IdkTrr+sYNmHnZv57NMAY+3u2WczMoS2p9mkPuMfNhpjxQXqfbyOBfbAHjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233

On Wed, Sep 03, 2025 at 03:06:11PM +0200, Marco Felsch wrote:
> Make use of local struct device pointer to not dereference the
> platform_device pointer everytime.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/dma/imx-sdma.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 422086632d3445b2ce3f2e5df9b2130174a311e8..a85739d279f51fdb517fce90b3dc67673cf2b56c 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2234,7 +2234,8 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
>
>  static int sdma_probe(struct platform_device *pdev)
>  {
> -	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
>  	struct device_node *spba_bus;
>  	const char *fw_name;
>  	int ret;
> @@ -2244,18 +2245,18 @@ static int sdma_probe(struct platform_device *pdev)
>  	struct sdma_engine *sdma;
>  	s32 *saddr_arr;
>
> -	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret)
>  		return ret;

Not related this patch, you can remove this check later because
dma_coerce_mask_and_coherent() never return failure when >= 32bit.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> -	sdma = devm_kzalloc(&pdev->dev, sizeof(*sdma), GFP_KERNEL);
> +	sdma = devm_kzalloc(dev, sizeof(*sdma), GFP_KERNEL);
>  	if (!sdma)
>  		return -ENOMEM;
>
>  	spin_lock_init(&sdma->channel_0_lock);
>
> -	sdma->dev = &pdev->dev;
> -	sdma->drvdata = of_device_get_match_data(sdma->dev);
> +	sdma->dev = dev;
> +	sdma->drvdata = of_device_get_match_data(dev);
>
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
> @@ -2265,11 +2266,11 @@ static int sdma_probe(struct platform_device *pdev)
>  	if (IS_ERR(sdma->regs))
>  		return PTR_ERR(sdma->regs);
>
> -	sdma->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> +	sdma->clk_ipg = devm_clk_get(dev, "ipg");
>  	if (IS_ERR(sdma->clk_ipg))
>  		return PTR_ERR(sdma->clk_ipg);
>
> -	sdma->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
> +	sdma->clk_ahb = devm_clk_get(dev, "ahb");
>  	if (IS_ERR(sdma->clk_ahb))
>  		return PTR_ERR(sdma->clk_ahb);
>
> @@ -2281,8 +2282,8 @@ static int sdma_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_clk;
>
> -	ret = devm_request_irq(&pdev->dev, irq, sdma_int_handler, 0,
> -				dev_name(&pdev->dev), sdma);
> +	ret = devm_request_irq(dev, irq, sdma_int_handler, 0,
> +			       dev_name(dev), sdma);
>  	if (ret)
>  		goto err_irq;
>
> @@ -2327,7 +2328,7 @@ static int sdma_probe(struct platform_device *pdev)
>
>  	sdma->iram_pool = of_gen_pool_get(np, "iram", 0);
>  	if (sdma->iram_pool)
> -		dev_info(&pdev->dev, "alloc bd from iram.\n");
> +		dev_info(dev, "alloc bd from iram.\n");
>
>  	ret = sdma_init(sdma);
>  	if (ret)
> @@ -2340,7 +2341,7 @@ static int sdma_probe(struct platform_device *pdev)
>  	if (sdma->drvdata->script_addrs)
>  		sdma_add_scripts(sdma, sdma->drvdata->script_addrs);
>
> -	sdma->dma_device.dev = &pdev->dev;
> +	sdma->dma_device.dev = dev;
>
>  	sdma->dma_device.device_alloc_chan_resources = sdma_alloc_chan_resources;
>  	sdma->dma_device.device_free_chan_resources = sdma_free_chan_resources;
> @@ -2363,13 +2364,13 @@ static int sdma_probe(struct platform_device *pdev)
>
>  	ret = dma_async_device_register(&sdma->dma_device);
>  	if (ret) {
> -		dev_err(&pdev->dev, "unable to register\n");
> +		dev_err(dev, "unable to register\n");
>  		goto err_init;
>  	}
>
>  	ret = of_dma_controller_register(np, sdma_xlate, sdma);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failed to register controller\n");
> +		dev_err(dev, "failed to register controller\n");
>  		goto err_register;
>  	}
>
> @@ -2389,11 +2390,11 @@ static int sdma_probe(struct platform_device *pdev)
>  	ret = of_property_read_string(np, "fsl,sdma-ram-script-name",
>  				      &fw_name);
>  	if (ret) {
> -		dev_warn(&pdev->dev, "failed to get firmware name\n");
> +		dev_warn(dev, "failed to get firmware name\n");
>  	} else {
>  		ret = sdma_get_firmware(sdma, fw_name);
>  		if (ret)
> -			dev_warn(&pdev->dev, "failed to get firmware from device tree\n");
> +			dev_warn(dev, "failed to get firmware from device tree\n");
>  	}
>
>  	return 0;
>
> --
> 2.47.2
>

