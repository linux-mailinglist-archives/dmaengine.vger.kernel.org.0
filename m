Return-Path: <dmaengine+bounces-6371-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0E6B42460
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 17:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5D65813D4
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 15:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F873101AA;
	Wed,  3 Sep 2025 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XadII2kM"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39142FD1C2;
	Wed,  3 Sep 2025 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911910; cv=fail; b=erxtWz+3sGxkfSaKH+rwixq4NAX/bP2iaLx1Dd7jXDTD5f0/1RM7nNcGeAkeyS38ZQw/jis0OOXOpsq8xo5Xj3JEUxRoKZ0cA2wHYjLtklzl/Rfo6T+W6fhcNQHBouPagpFiDVOoXRN7jyjsZHtErI/EsKpMkZ19kT+2fPzm1Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911910; c=relaxed/simple;
	bh=75JAVdrlWXLjiU5b5hV26u8dKaVOir8tnshqI+dsIV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uc8E9N5Uy6r4u6KP+wyGMbLGPGLW8UVP0U4XMia+m76SJB/v0W9/kj70NcIPbowH420uACy6dVhXlXD1WZUtF112YAyyZWlZ5oDVrznCRD6xI0330AWeR/+P1GkNmWF+oElnYROjMUXxowLWVhs5oni0Q6QnfF+wDxsQzLFgLdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XadII2kM; arc=fail smtp.client-ip=40.107.130.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiKk3eED0a5GqAoL+HlWtiA/2iRQIAbrid4aYse6RE46lEC+GZjWuqTP8nLksG8nMVw9aRvPzfwIaHIHWFXXa7EPE9BzrCR8xO5y689p3S0XmG59yx2VI1mbY2c+d+/tpcPjMFMj5DATwulr1d5s0eWOvOrgluIaSsFlxiIS2yfEgR1m4gUQ9p6j7gSFpAS10CJxZvHbqht8rNWsyiYihko8fr1be/JaiNyTi+IXOwhL0kkIgsvJITyv/OsxccDhphGSJ/tj1JYNaooNfLAI2ZTTZrftp8BJGHrrojlg6Y7UDmc5QN9Q1lPcuz+kv+zJ+Ph2OqVjj3I9uL6CL8jVfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jw6yqxc3dkKVnexXmsXFKRIfzcJNUPiHyeINH3yxy80=;
 b=n6p558iiyTirP9T2t2bJnVGDAMki/xwEG7Jvc3PU9XwnCDtsiQT4GhEEeI/xrZDhIJLi01EbS4kZ0/ZyUFCs6xgWyK8lYOYTIpuBnCIYM+v6iNjJyN16F/u6GaTTyOevjrGEgy4p1IEXl8VRJmyk7fJLaq0Oz6iDOayjby5MBezX8T2AVEL6KQYdC2+2Nlvu+A29EhVjmaDHn31cGKBkiL7LUWGqz1R32ZmSLcZ7XAZWF3tnKfB0K2YU8VFi5+kB9P9YFYpQqqtcaDA5HEdEwzN2tE6DCaWLHpG6WLzXI/lo4Bk/SeT0D0Et5QpVHNRucYlDXDjBrGwHtm1B9ydynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jw6yqxc3dkKVnexXmsXFKRIfzcJNUPiHyeINH3yxy80=;
 b=XadII2kMqgt/ApmUh/xBjHhpZZp7+LQxkG/703k+/MShcdb1F0RMmxcvuy2oR69EzCC2VLevqr1iS79B6c3pBHohOeCv6UqJ3XhvGjrfi5lQQ1Fw98Ny/YBbVA/iJGMq/FIbDBleqlCMgLwiAiFFpV64Jr79H97yVNF2M1N6NpfLqbatvQwvBlKyUzqHJcwtGZOD6XimcFYRXEaAziT2t376JVbE1GbbIjGG99cZuf/QHIKgamgLRyChKPFLGYWM20YwVphnlRgsuUwFQoaqNtBO/3iZkB3LZ8SX29qd8BYDfQJwHe3jdLO5jnD53Sv+Nr4XJB/XsMxl/xcQ/QEA4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB7989.eurprd04.prod.outlook.com (2603:10a6:20b:28b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 15:05:03 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 15:05:03 +0000
Date: Wed, 3 Sep 2025 11:04:54 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] dmaengine: imx-sdma: make use of dev_err_probe()
Message-ID: <aLhZFv27bFh64MrD@lizhi-Precision-Tower-5810>
References: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
 <20250903-v6-16-topic-sdma-v1-7-ac7bab629e8b@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-v6-16-topic-sdma-v1-7-ac7bab629e8b@pengutronix.de>
X-ClientProxiedBy: BYAPR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:a03:100::21) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 6efe3c95-4ad4-4a30-839d-08ddeafb42ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|10070799003|19092799006|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d6GEXyRqp2Q3xEqs6Yjy79oTU4uB0NSyMYhoQRHYunMZ/u/657Lw+VJ7GExL?=
 =?us-ascii?Q?1s5yt7uWM7pzGIYECKhBy/upBIDA5NZSCv0pD0LkIZS3AQToQG6AywOp3A9q?=
 =?us-ascii?Q?XZY0OjSH+lJLyDcVqf3qXgm5tBzoLcF0Tt2PZd0J3ccoo41omnfQvCkhRQLf?=
 =?us-ascii?Q?aWH3R6PPWDDfBrACBWUetKabGI+ChQh/WXA1TSqQBQIhEqkp4kJTvocDcXPJ?=
 =?us-ascii?Q?49i318FGZOZnS7mdJo0pDtHsf5IF/sPw8iG/BAJ8Y7+/c81xJjqqSMmCjmG4?=
 =?us-ascii?Q?NjludfhqRIRRXjjPIHfub51TTIDnYKXLtHNYvEpMCThryVbaRc+V2TAp5+kv?=
 =?us-ascii?Q?KgMmbWCGQJAHckrR9WcvdjjkjDGNAZ9RS1K04Co6+f4AuWHyNJ2oBdeCmpVf?=
 =?us-ascii?Q?aRDxyLpgdI9kL9nTLtcGN+09hp9cWJTL4Kr329hmv3Dq1HlPr5U++e8nKw/j?=
 =?us-ascii?Q?zuDtXLy8joA9U9oDpPVBhUcdRn36Ort5HBgl9blqeDrWdY4214IS4FLO5Ptg?=
 =?us-ascii?Q?ycAW8uP+nt8TNsXo2m8DYrcG3TY6rWJCupsVPPkGBI+G1AoWJzmSim4mTxuX?=
 =?us-ascii?Q?5jCQxveBwTwncRkl4TTzWNL79BATUj13FTlRRT3dSz/wajO+2aKrIqDbLKId?=
 =?us-ascii?Q?2r8G7edKFW/PP8TiXPzzwzUyZxK3NHAJAj2fWLH10nhtEVTndzWuEAgRB0wC?=
 =?us-ascii?Q?eTaTcY6NcoKQdi6x7skyTtK31TZRBVMm6zs3nAzgr8gszEx4xdpQq2qc8ynJ?=
 =?us-ascii?Q?nk/zByzm4cvbNw7hwsjNjfavT+J9VhOE6FShzb9/slHUySQqn9yr07pR5ill?=
 =?us-ascii?Q?Epvn8SZuHFgCjPDzTcR7x8q2p0Zrqgpr8jMr/TRaAyCIVAdt9UVR5VkGZAg0?=
 =?us-ascii?Q?jQ8Zj4n4O+0LOX94gOaZwX+vdPCOHsUis827HVc1i0ap4VfVKoTg5Wie210B?=
 =?us-ascii?Q?iO9kDLc8V2MMkwv74ZBQb2lKS8B4MWaRGRiPONubbXf3AnuYAsw+np0xl49O?=
 =?us-ascii?Q?+clyKbGjpaUVV+BmiutxMv9F7lJCLpVm7RpbDr9gkpcWLpTng4Rqumwwl0pE?=
 =?us-ascii?Q?ZML+TAg5Ls7V/6J+TpVeA97prdU58/e9fPaAiGV/I559jvf98MLjpDrx472a?=
 =?us-ascii?Q?Jbqav8WiNXIusZejKzklM1z9wmPeiiIjeolhDPm0cgdE7HsoY9FR+urfTyIv?=
 =?us-ascii?Q?8NQuGVe5cp83zsMX7x7RY76U40q18fvDRcgVkzb8XYfb/kFwtvJYbYG1MykU?=
 =?us-ascii?Q?Udz4CXY0VvOCCcvOJXh22aWI5OhZTosGdDHNplH20lgM3xFljvkowau7Lrkh?=
 =?us-ascii?Q?UB5BuRaZtgEni3MqUELQhhLHZMt6ebsjcVtyPCmYYWh6ZDPiD0qsMeri/H5w?=
 =?us-ascii?Q?vxjUCpLc/bg+UAHGLhvgE6aQaXZdWP/zLDGRz34g/YFaRzoQFa1r4Gl5wvJX?=
 =?us-ascii?Q?POFYTLVMCyg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(10070799003)(19092799006)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0bCNzOSlc5nflpmK6kW9IN804QqL4u+IMrzKoPGdSImalciufxtVjY1Usnv2?=
 =?us-ascii?Q?66gmrqJ4gMQ+gqmFmTodkRmKSB5ciR1rEAp6kJ/d518aNv9wreY4dEihcVTS?=
 =?us-ascii?Q?9AsqY5Epic+TWRDpRu8Dax+l7V1NP+FPw9PCEZWsaETdOD20O9WKpltUccmO?=
 =?us-ascii?Q?yvMCDQ3AdYQGt9eGtaxlDMkbwTmN5v0GpEObbuwWzqY2NcdhRd5EgWR1ROSw?=
 =?us-ascii?Q?k2rYSPNOkkQI39b/QgqEeZgxymBK4/ZWUCSY+WtMz+ryFhsYy+jg0c3215BP?=
 =?us-ascii?Q?uNstRwxWZQAfXSLGzQz507UHW+U278VM++QgZC2lmYEWa95rhB/oyeTUVRFM?=
 =?us-ascii?Q?fLIhcxq8ZYt0XBclBz2+qGRtzX+xWjpo3qTmC3wp4Qob/DWvjcskv8jT6/uE?=
 =?us-ascii?Q?dG/8cILVqijfsLySwkbQj7a4DrxbtG/hDQg3TqZuUArsLO7KKeQySr3PB4B4?=
 =?us-ascii?Q?WBJkRcP2z6cmTIhkMTO02gscwBFaDEp3nYW6Ju1ILHOyScoXHkAQbukeISCx?=
 =?us-ascii?Q?7YQrb7zB4dm7XjlU6587JZbY+KKIsJHBZLllglajfJwDRn9jw8IlkmkSiMz0?=
 =?us-ascii?Q?uaIpCngWwHcz0HXsr6CUr32f5cJOUPT7Wx8kPCDqgGykn0hnKOiWs2duvVLM?=
 =?us-ascii?Q?8ygHYbgVTZW7AJz7yeXVCB8k4ECkxZIJTWxJXaokljSD1t5onQlwEi9DhCwj?=
 =?us-ascii?Q?1DlBQ3ZnejaSSG/A24ioOjHZqm7mFnURWZoc84GXGxxhAAnYEC64p+MZQlfV?=
 =?us-ascii?Q?oZJ+GACjtfzGSiUY9tMVkuTVMvyHfW2BSvLpNTXDWwzAZpkM8WloDcNS7yzP?=
 =?us-ascii?Q?PwX8iC5VYVNOneGEmlvHUgjdGgRhG1O6tVnqmSSDlEpFPQVb4k7DJR1+KAxB?=
 =?us-ascii?Q?0fOeGYBd/ovR5Vk8i+E+bQjpVR9r0I+Sdh5yu+OBqMCF1entydgjePhsgfGv?=
 =?us-ascii?Q?ERW1s61tE0jemiQgso0lx/a76p5p8gbwvvLdeqS4n60AGKeRpztlfteo+7l2?=
 =?us-ascii?Q?3eU+8zCH4kBN9/R0rJeF3JR5KpUyI3YSE6TP55/CWNIGhsI44c5WtkhyOVOq?=
 =?us-ascii?Q?0fXYP5D4GwfJhpDSltGt2wp05lGKOiRBR23B5S3Iye7wxXeS+yYicG9wl8gs?=
 =?us-ascii?Q?+cHPXVbOGaVNWsUZDcyV3sgAUiDg+6nxpyMjLjlnb42j4NY6IXv+yjpp1nzL?=
 =?us-ascii?Q?fuDBl3urmxPkLJ0IN5xZ+6/eUmadKxAvarn54bfPKh2eU4waxd80UagRx4Tw?=
 =?us-ascii?Q?IIF8S+dKCt7UTYAWI6ubxY8PJ5EPlV7rCMRPsxLkuesm78XkCjpsxEL99sHz?=
 =?us-ascii?Q?TFlr+fOOWO1XX6ywPaMGJDKVHUjhmUR5680leoqSaAOEyoOmKALl9NQziT1T?=
 =?us-ascii?Q?SlofRaXo/hioibIKqkEuV6AN9Jm7dZYRYNBPKTg05kf7j0wsGf6nakoluM7T?=
 =?us-ascii?Q?+DCmbCqVU0tHE6LuM/68xwjnYBzXm4E2p88vh6EMKxgiiUZKSEzZz5vuFU6v?=
 =?us-ascii?Q?tUqX52kmd6dPu03SL4UkezCsg0xKtYlNMmA9TMFHROlBbebi0/3ulcT+MAJ7?=
 =?us-ascii?Q?o7mLIdQqoa9I7tWrnjgrPIsoOKJuR13ZCVfTJP4+KQLKTPA9l9zflGNdUCh2?=
 =?us-ascii?Q?ljoniFDfCqbi7mneo1hqnj/MQWL2zNzy3GfH/OUIy5zP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efe3c95-4ad4-4a30-839d-08ddeafb42ac
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 15:05:03.7708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7tn7dJu8eZHGd1lhKI3h2vRFlWQl31CM16XGt6GMU7rxpPtO0ndx0Q74d92uRXCKhH/qYVvOkW3Qx5nq2gKKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7989

On Wed, Sep 03, 2025 at 03:06:15PM +0200, Marco Felsch wrote:
> Convert the probe function to dev_err_probe() which helps users to
> identify issues better.

I think it is not "convert"

Add dev_err_probe() at return path of probe to help user to ...

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/dma/imx-sdma.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index f6bb2f88a62781c0431336c365fa30c46f1401ad..e30dd46cf6522ee2aa4d3aca9868a01afbd29615 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2255,7 +2255,7 @@ static int sdma_probe(struct platform_device *pdev)
>
>  	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret)
> -		return ret;
> +		return dev_err_probe(dev, ret, "Failed to set DMA mask\n");
>
>  	sdma = devm_kzalloc(dev, sizeof(*sdma), GFP_KERNEL);
>  	if (!sdma)
> @@ -2272,24 +2272,24 @@ static int sdma_probe(struct platform_device *pdev)
>
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
> -		return irq;
> +		return dev_err_probe(dev, irq, "Failed to get IRQ\n");
>
>  	sdma->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(sdma->regs))
> -		return PTR_ERR(sdma->regs);
> +		return dev_err_probe(dev, PTR_ERR(sdma->regs), "ioremap failed\n");
>
>  	sdma->clk_ipg = devm_clk_get_prepared(dev, "ipg");
>  	if (IS_ERR(sdma->clk_ipg))
> -		return PTR_ERR(sdma->clk_ipg);
> +		return dev_err_probe(dev, PTR_ERR(sdma->clk_ipg), "IPG clk_get_prepared failed\n");
>
>  	sdma->clk_ahb = devm_clk_get_prepared(dev, "ahb");
>  	if (IS_ERR(sdma->clk_ahb))
> -		return PTR_ERR(sdma->clk_ahb);
> +		return dev_err_probe(dev, PTR_ERR(sdma->clk_ahb), "AHB clk_get_prepared failed\n");
>
>  	ret = devm_request_irq(dev, irq, sdma_int_handler, 0,
>  			       dev_name(dev), sdma);
>  	if (ret)
> -		return ret;
> +		return dev_err_probe(dev, ret, "Failed to request IRQ\n");
>
>  	sdma->irq = irq;
>
> @@ -2330,11 +2330,11 @@ static int sdma_probe(struct platform_device *pdev)
>
>  	ret = sdma_init(sdma);
>  	if (ret)
> -		return ret;
> +		return dev_err_probe(dev, ret, "sdma_init failed\n");
>
>  	ret = sdma_event_remap(sdma);
>  	if (ret)
> -		return ret;
> +		return dev_err_probe(dev, ret, "sdma_event_remap failed\n");
>
>  	if (sdma->drvdata->script_addrs)
>  		sdma_add_scripts(sdma, sdma->drvdata->script_addrs);
> @@ -2361,18 +2361,14 @@ static int sdma_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, sdma);
>
>  	ret = dma_async_device_register(&sdma->dma_device);
> -	if (ret) {
> -		dev_err(dev, "unable to register\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "unable to register\n");
>
>  	devm_add_action_or_reset(dev, sdma_dma_device_unregister_action, sdma);
>
>  	ret = of_dma_controller_register(np, sdma_xlate, sdma);
> -	if (ret) {
> -		dev_err(dev, "failed to register controller\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register controller\n");
>
>  	spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
>  	ret = of_address_to_resource(spba_bus, 0, &spba_res);
>
> --
> 2.47.2
>

