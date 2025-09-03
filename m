Return-Path: <dmaengine+bounces-6369-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FFFB42444
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 17:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9B0E7B21A9
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 14:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4E930C341;
	Wed,  3 Sep 2025 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YHkXlrUm"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010007.outbound.protection.outlook.com [52.101.69.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9795A1EDA3C;
	Wed,  3 Sep 2025 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911646; cv=fail; b=Cx08aiZRYqCyEUSqKxx97OInsWJOZmk5nmGud7U+rLFZo2eQl9rmSV5EWs9a4a3da5mGi4V3tIsTwy+byZ+ud86QidLUpNETBVBAwKEbHCUj1QaN2xd6Vhpsw6YBi1ThYxpZr+nC7M4bz+TWYtpsW64TJNlADacY6VD0kQ8KXJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911646; c=relaxed/simple;
	bh=Qi6qIaIR/lmJ8Nb6OJjXYP6x6KlMSGxD1iqS/T7yJuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YONzBFj4CvuuuwePOIHyUOJ6WW/kUM4uClWWaTa1fWbVQAAfOeHEMzN5e9fajAnDBL393NIe++DUpl+IxiFuX1WP7kpMckWwGkE7qwTlyvnsuxtd5inJfWdLan5hkmV/wGVicEVJ1YTffE6RK6/C8hB1AZUyocIaFzt/oC5rSsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YHkXlrUm; arc=fail smtp.client-ip=52.101.69.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZT3pHOkNiZn4/2mcLytGUkpQoGh3/Iag2luG2gHTxYjHsNPx9rnPOs1atLxPXMsVd7ggG8PY/bt/y5lxDMkDP7O8hBix0r8msITkNfjJLyZQWqseCBcBXRg2cYAduBSPkpstE+/IdlkKQTSLhDs+6WEx+jCmEjhpiZb8j+A7LbPPZj6qTCVzIucbOdJN9ZpRBQ4ALRyK64Q5RYosLaclah4SrIWGytwHkAOo3dboe/ifS+b2kKRVVKGwYqfa5L9ZQne8ZURClVxBXS3DjCSMOgwzkFK7GqEENKMNeWtkrD+aT/h1P5rhGcX9WoCvxi7Ue+5QfkOCaEG+4QDJGOP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDEQO40adDSMD8q+tu9TI04+C0QjRv8MiiZRHO5baY4=;
 b=nG4DPvfMQWUInsV5zrB/b63kmzGrXyeGHVc7iERK2wGyMhUoC72yr/fgkzrM5D0jQJQF2HLBIhpC7FKr6qNC+QgVpd5Rh+lw2A7EWJt/dBj5o+473BZcw/CM6hl4R0VxhpXjjkk/w/r/pfOJSmxStfyliFR4lw9/tbRapG+NbdwmrrSOljst0iuWPquJn0O9TQ5aXn2IGazN/z31OgrHxI3hcurnnKalCGr2B7+aBuzI2ufO0hxS6TpFeHc6zHbV2I/g+eYwCqJHLgld0Z2+jwtPibsAMs688NR1mypXBgLl6sopdMGkUTD/rXGlNure5WFbkUQj/fKjWITO0AyHWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDEQO40adDSMD8q+tu9TI04+C0QjRv8MiiZRHO5baY4=;
 b=YHkXlrUmYhhBTgMxtHYajGfKQCEgPCGVE/ko7qtiskpq6x4IkSNqYa16FGljMbsHkqQjszPEIGObLSORTlpygnJ/Cn0v7/Z6KBdM/3QedMNmtOBxyV6RGe0xfdiByV94S7ouIDm0u35g6cnoR9YL5unmjw68CHBidvXgyS/MHCK+kv8CshoflxbjIlZsbwe3EYVrI55pUO7ldmqItXWI8bQGqe+E6At2Vg46nglb7y8qUhXCdOlpa0I/VuG4T0bPX0wsHvH0fESz6ia1Wv54uGBrxPY3fYJcM74gUi8IZtLgq/Fp1eu43raMF9Uw8sf0EXD82/PCpu67aex7VMvSZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8342.eurprd04.prod.outlook.com (2603:10a6:20b:3fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 15:00:42 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 15:00:42 +0000
Date: Wed, 3 Sep 2025 11:00:31 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] dmaengine: imx-sdma: make use of devm_kzalloc for
 script_addrs
Message-ID: <aLhYDxSUnEUwPV91@lizhi-Precision-Tower-5810>
References: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
 <20250903-v6-16-topic-sdma-v1-4-ac7bab629e8b@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-v6-16-topic-sdma-v1-4-ac7bab629e8b@pengutronix.de>
X-ClientProxiedBy: SJ0PR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::18) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 673f4602-64a1-45ed-b40b-08ddeafaa6c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|376014|10070799003|366016|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HDaaMPuP0ymT+Qj07Cx6CPOt5hF0IdXXGYi3jP3TEe1pu0kf4cRTty0vKDbr?=
 =?us-ascii?Q?9tvC1fZiE9eJk1tLs8WvdHYdFANpcbYCgEYYrS1r2UJUAXJD0FMxPS2Q07hy?=
 =?us-ascii?Q?1naJ1T5zYPgLp4jY4Ml34rKJ0APz7ULvpxayTCq9E39985nAsBUmc2An9P8Y?=
 =?us-ascii?Q?35oWjrB+rMHjg+JPZWuoKh9VhfKq8+P4pnKXy4c+lkKXB4FQ1Y7q+vCFhm8A?=
 =?us-ascii?Q?q5NTK0CD738lRPO8VK1mA+L5KmSPYWKtAmVeGyOiRCuSb1If7bdlB21OGBLS?=
 =?us-ascii?Q?lIShErTDwndcsSvW3Sd/e9vs/WE1oSxXlYS9QVg2PeU7jRCkwU6DZTxWWEYv?=
 =?us-ascii?Q?f7m4WopBjfdmeM5MTSldiD0AssMUI89W0dQuXl91+KoVSeDGs3xptUxbw3nR?=
 =?us-ascii?Q?SIzMW/KNAg9b/IOvvFcGpgKMB7+KrxjU/CrRnFe/uK3wj06zRNbRAX298KqK?=
 =?us-ascii?Q?2v/FvNQ0eQDGmLulnv+6C1GDUA+G2dKNWqzt9mRorINv+17tYN73DaRwXyua?=
 =?us-ascii?Q?b30tqql2XSD2xpCbvBHaMSh5kl38wmjr7URj1+SAffPIL+504gknoLF+JrkA?=
 =?us-ascii?Q?CJXf1gw6ucVXZ7Sh8OxhIwoQICKqMhWtmiKhIBwO7nkSd2XU7ABfIY9jh24c?=
 =?us-ascii?Q?78Vkqv2IvzbgCWo2MAg1hSTsykRVMsSlMIgftsjplfg5A7izryB0HVYpMIyE?=
 =?us-ascii?Q?bQvkqC8jShsY+dpKOYPrgHyPrOjZdPOs1/FVqHahsCtyGgRodXSuHpvr4cxz?=
 =?us-ascii?Q?vH2VjDIYzB+HwWU02Xpz9zDFHrte2+a91vJZSLykQ8gp69h+iipV0kl6biuU?=
 =?us-ascii?Q?GWUc9lzI4dy3XuXhBeb1AoJaJmjkSdwCH+J07RL5h8lnNxuoi+09q9R9cyzQ?=
 =?us-ascii?Q?XSaJmIT9ZIIEoSBXFqMPIAo7EAp9AszlzBNVyU4Qtf07nmJz3j+bg/mtE83V?=
 =?us-ascii?Q?yr17JZkRTNVpDebc8reZ97vG8ggUt082XZo7FLL54QdRel6+I3JGPvXKMKWP?=
 =?us-ascii?Q?Ayhc0JrsU2xGLew5VwKP/Xe96PK0Hs/Cd+Bsn4lNB4k/MRsEPHWrTy1kXoXV?=
 =?us-ascii?Q?5kUfSzHqi3R7rKvlFc6aGg6k6pesXnFoVlerguXvLTAyQleMeU9t3Vf+igc6?=
 =?us-ascii?Q?xTBoCPMXojIdekLKqyZMCbRP9vx6UeV8dVVfJ2Xm1hkRP5JjFfkqoqHSiAmO?=
 =?us-ascii?Q?mRWSCIeQTSV6C6UoHkchwBm+yDXmt8Bdt6f8RZE9X16L28tcXP6E8GOmhXOl?=
 =?us-ascii?Q?OdLt61LbySERNh7TR+bmG6fgm+YKgmb43dtbVCot3xPP+UqW8c12xs/gDVF5?=
 =?us-ascii?Q?7yKazDAQLIVkSGHKZdQPChfPyXOm0fJYE5FtQVklrzpYGtFjkcf5kRsTsmTL?=
 =?us-ascii?Q?LO63cp8O0wFM62ECkk5TKU4e13uah19pLt/MbqtNAv1yaceXT+K207AJ898n?=
 =?us-ascii?Q?oQEO22y8fYQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(10070799003)(366016)(19092799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QKrfVuKYHfHhD6cOyj0Kxoo77C+WovvWKGcBKD+ZfvtfXQQlEzeoDqsWzv/y?=
 =?us-ascii?Q?w9q/Z1nX2EDQaZdLB+okko+66tR2j+/O4FC/KrteCupkyfJ0bVMe/diNyFhO?=
 =?us-ascii?Q?eAJROYTQhZsyEtg1LU/6SgtDodgZWxbqXIzs3RmocdY+T89DTgZv8brfxWYT?=
 =?us-ascii?Q?c44e+TcyJnBSGN49P1cKkWytOSJjYEqYra4S0LzRs7zcUDbP7g1sMWEZcntF?=
 =?us-ascii?Q?sAdP/qiT3Hz23l86iEapS1vw4281UlMTDHWf17XaHa7WofllobmQnDHylb+P?=
 =?us-ascii?Q?jt2JU98wvWuG0ypbDM/Bx1c3ujih061givBNj8t606W+F7Q9C3f51s+poUz9?=
 =?us-ascii?Q?hGktCA/tl6vJI70wGtdjJD4QZahRUfmXvaBSh0T/X3TDXm7jeH/oZTqqwQ5c?=
 =?us-ascii?Q?b5jtsLy/r8/9ikXpUJBMocZ6pcrauY5c61U4iMAAcxiDkgTQzgNwLKdEwLhK?=
 =?us-ascii?Q?g7zrxmCvr2+5INcFpJrIrbB4qx594fi4LxwHrRFi6rBkRWwZP9jCoZ/dcwwG?=
 =?us-ascii?Q?fkjx3YpogTxeplijGA5ZcZvb78f0Y4+JGCnT2kY4Esib1qz/Yn6lu7mgaB4r?=
 =?us-ascii?Q?0MfQ62tFinx7pQUUBl0OBYeMtgqACIXTVHdadsXHDMIrriCZppO1HW3hjX+K?=
 =?us-ascii?Q?M0wXFhdF6k0NMsnrDdE3+cVdhIc/76QylwBaGDYqVE5q6aDueJ8hMYGT29p/?=
 =?us-ascii?Q?F0iUG7hs/+bIRb79SA+bhsSvOQzLZbjkz9CORdAbb2xWudEc6W+TJpNcdsf4?=
 =?us-ascii?Q?DIy4hhJIZm6c1HdiKgC0cvK6uI9qvlNolqWLXIew0GmqsG6FLEU43jSLjMPz?=
 =?us-ascii?Q?5lZ4Db929sjTr47oC58FOGjl4X5kDAv/FEbpzNZWzpBiuV510JmU94aFJ+8c?=
 =?us-ascii?Q?dS/89O8r3wsCoOnVT27BUVHOz7OHE8Y6si5M850/7pv+Tc8mRvivJ7+J3gU5?=
 =?us-ascii?Q?ZyOTiUW6uv3wNS2mRpGPpY4Uquik0xp1lBBebDUJM7RdYCsf3a051s9y+Ljm?=
 =?us-ascii?Q?vx7v1MlCe7ojWjOIGe2HTRWlH2/fFs2XNBmx71i7c6z66w9eEjvj9WYqsKjy?=
 =?us-ascii?Q?fz7WTxS9e2S68VX0yyyqCx9g+xl1JWu7JZrXU44hxHuRWs/NFTF0g9Z+OISw?=
 =?us-ascii?Q?s0Bo6cWhw+zvbd0kXxvzGiSssRIHHYmVbudyCrlqi31EET6D4ckzRJ44zlzg?=
 =?us-ascii?Q?JnAl1aBmXirQ8aU5Sj9XcSd8RDzFqFFa+Rhp5tSjeCxigWJkglQQAo04DB4U?=
 =?us-ascii?Q?M/pb8X9X+yXfpkNXiyFCnPZIIURBNVoSkT9APuMJwrr/Y5H6j1l7O/CSpodS?=
 =?us-ascii?Q?zrgykmVeFT7Dd2NrpkuENYshjyYMMN+rt5IRLRcQRcA/B/1s2Btl3O4feTo6?=
 =?us-ascii?Q?0VfAs7NVPsyBgBQS8S3gLQYbAPfpb93zkWLqVuNa8gVno1mJ46k2gyQkpMEv?=
 =?us-ascii?Q?G8yIvefCq2+nb+R/kPO4LdDcp15qmQgZebGt5fUKFSWO/RNtrHPySW0D87Bs?=
 =?us-ascii?Q?syDpqEYuUoa/Dp7zp+OMTcaMbed5DStmGHX4UiaHa6JOzhOPZZtrDUSQK7AY?=
 =?us-ascii?Q?AVBMdCtInAvbzOj3LFtWdAP16P59EYhC0qDjx0sBxwQ5TeKAZv7am8BTVIZP?=
 =?us-ascii?Q?MtsbHUSBJQPf7hPqL/QAUImHk85vAtqznhZHMbdEoQk5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673f4602-64a1-45ed-b40b-08ddeafaa6c2
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 15:00:41.9011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4on2bFUZiHSeY404VHbXfyWXtv3urNFzonep5G7CN6v5Lgf60gkSaQJ5BAti0OVCQHE8aOCbe66JZ52MYv18Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8342

On Wed, Sep 03, 2025 at 03:06:12PM +0200, Marco Felsch wrote:
> Shuffle the allocation of script_addrs and make use of devm_kzalloc() to
> drop the local error handling as well as the kfree() during the remove.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/imx-sdma.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index a85739d279f51fdb517fce90b3dc67673cf2b56c..b6e649fda71dbce12a2106c94887f90d0aaaf600 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2253,6 +2253,10 @@ static int sdma_probe(struct platform_device *pdev)
>  	if (!sdma)
>  		return -ENOMEM;
>
> +	sdma->script_addrs = devm_kzalloc(dev, sizeof(*sdma->script_addrs), GFP_KERNEL);
> +	if (!sdma->script_addrs)
> +		return -ENOMEM;
> +
>  	spin_lock_init(&sdma->channel_0_lock);
>
>  	sdma->dev = dev;
> @@ -2289,12 +2293,6 @@ static int sdma_probe(struct platform_device *pdev)
>
>  	sdma->irq = irq;
>
> -	sdma->script_addrs = kzalloc(sizeof(*sdma->script_addrs), GFP_KERNEL);
> -	if (!sdma->script_addrs) {
> -		ret = -ENOMEM;
> -		goto err_irq;
> -	}
> -
>  	/* initially no scripts available */
>  	saddr_arr = (s32 *)sdma->script_addrs;
>  	for (i = 0; i < sizeof(*sdma->script_addrs) / sizeof(s32); i++)
> @@ -2332,11 +2330,11 @@ static int sdma_probe(struct platform_device *pdev)
>
>  	ret = sdma_init(sdma);
>  	if (ret)
> -		goto err_init;
> +		goto err_irq;
>
>  	ret = sdma_event_remap(sdma);
>  	if (ret)
> -		goto err_init;
> +		goto err_irq;
>
>  	if (sdma->drvdata->script_addrs)
>  		sdma_add_scripts(sdma, sdma->drvdata->script_addrs);
> @@ -2365,7 +2363,7 @@ static int sdma_probe(struct platform_device *pdev)
>  	ret = dma_async_device_register(&sdma->dma_device);
>  	if (ret) {
>  		dev_err(dev, "unable to register\n");
> -		goto err_init;
> +		goto err_irq;
>  	}
>
>  	ret = of_dma_controller_register(np, sdma_xlate, sdma);
> @@ -2401,8 +2399,6 @@ static int sdma_probe(struct platform_device *pdev)
>
>  err_register:
>  	dma_async_device_unregister(&sdma->dma_device);
> -err_init:
> -	kfree(sdma->script_addrs);
>  err_irq:
>  	clk_unprepare(sdma->clk_ahb);
>  err_clk:
> @@ -2417,7 +2413,6 @@ static void sdma_remove(struct platform_device *pdev)
>
>  	devm_free_irq(&pdev->dev, sdma->irq, sdma);
>  	dma_async_device_unregister(&sdma->dma_device);
> -	kfree(sdma->script_addrs);
>  	clk_unprepare(sdma->clk_ahb);
>  	clk_unprepare(sdma->clk_ipg);
>  	/* Kill the tasklet */
>
> --
> 2.47.2
>

