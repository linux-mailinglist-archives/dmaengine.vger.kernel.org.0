Return-Path: <dmaengine+bounces-6797-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B98BCD680
	for <lists+dmaengine@lfdr.de>; Fri, 10 Oct 2025 16:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B370819A1676
	for <lists+dmaengine@lfdr.de>; Fri, 10 Oct 2025 14:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CCA2F3C12;
	Fri, 10 Oct 2025 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nBW9VtQ1"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011061.outbound.protection.outlook.com [40.107.130.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E14028466A;
	Fri, 10 Oct 2025 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105419; cv=fail; b=hciaGmgYEBNSmbsCM6FpyiJR9qFjMSNTfhAtGybgY8Xgwn1fzUA7S0CNX85vgGUd7krDufERjCtPO0XWrpPGkdeaiMAZHvWyTtFEpSaypt/GpjPRFSeHtyFB3n4MfY4ffrBBXNUbueu5L4nijiYHgHJ25cC0MN+aRGd0J0Z6PgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105419; c=relaxed/simple;
	bh=Ao1JWBrBIO2Thkxp3Yh0oLmsthDuVDUMCUvWZEMsiEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EeE1SNkE7LeD6QSY29ricbXpz1R/ktPCj3eV+vMEQlSyrMYq2aHFBMwNRiJR/peevHGY7Mh5CweCoOpHO4EPtjMf6zW7QER7MbF96oJeFpp8+Q+BVkeOsDnlsM4sNv2hfQRGgNOd3Imy0GCfYjclWZUm7CLfhd8qbHd1WmmFr8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nBW9VtQ1; arc=fail smtp.client-ip=40.107.130.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlxzFMUPjA1KOcJCBhhMDrae1ZATd/PgZiNO6DVOeZDrq1PeIMceiHDs7pnt7YmrbPLuhioP4YTW0tUDYczNZ7w4TcnHbeaovVhvOK9cglAvPFBjnuc3n9XBiplFwpBaIlAgSg2wgObhscsLw0D3GCP5kBNYrUJp1cFbuk8bthLkoJPrzYJMWy5XsbnRJKxtN2Oxnu18FlXOtkqtc8qgMwoyZUiv7mbaxE7ujEJ+rTR2hWwUxia2mM72V5eUgEq7rplLiGLGPtzb85KZWaFdwdc1h6QLlU8xDAMkWWHaJawi3sJmue/bOcRyxc7NNSs9NhfSJzJnEgdJ0EbxyJIhzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5fwsTxj/eiyJJDNNN6YdGThI8Hv0PoEjcAfKn3nC00=;
 b=D9FUL/2bQKwl/mtdWA5rHMvhTNo1IZcpa+CIB6sLok0mCtzkOD0+L/DUSf/E+pDotfel1Ot+a8NPwKszo8EQGaCOKJ+6New9h/kCvIhSZEam+7cmPAfUc5zb+dKF/eUhy6d7h/KePWsb5CcaunKy03lgrAwM3I68Opo63E+MQ2HepDnhCDJeFJL0QIv+Sn8QJYZ1MFgQTM1DYZwW1yZEippeN2WgXasYCBv7oqXKX72a14b1CTmgrLkoFUHf38H68ah7qUOju5QT32pz5h7o/M5BTQRKmRgoSLW+oD3uHTlYeB7fy8wBUapZl8dW1AIV2FItAqJY2Nvxp8sNyHJpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5fwsTxj/eiyJJDNNN6YdGThI8Hv0PoEjcAfKn3nC00=;
 b=nBW9VtQ1r2kBNHnXSWeZM2TfxuvcvD/jwgYGubhfFfpwcMiQLNUQdV0DHrN2Y7Q+7zQ36a9OQ8+Tv7HY4ukprJ6KBQguVD3ATh5X2nmLrDOL5q57PNK6A+8RI38eSWGytGwp2tq75rTVeMwN0BuMqAjgONzxmmsPBsMwA/BGKdiG9JYQ1x6cKOXcN90Zg72juaoXaVONqmEDmQtF2BmHKYM3vjtxFfKYaPqQpZSEw/opIN9jSjMqOeKaIrsNSf6H1pv1rLExmnpFiNzn64vmyEyKze5DuhxNiIlZtx/C2F9qFLl54qP+bs0dt5zSmbr2uvLvz+3ezfz2ccvMNKbFTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB7671.eurprd04.prod.outlook.com (2603:10a6:20b:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 14:10:14 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 14:10:14 +0000
Date: Fri, 10 Oct 2025 10:10:07 -0400
From: Frank Li <Frank.li@nxp.com>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-edma: Fix clk leak on
 alloc_chan_resources failure
Message-ID: <aOkTv4Q2bwbOazwH@lizhi-Precision-Tower-5810>
References: <20251010090257.212694-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010090257.212694-1-zhen.ni@easystack.cn>
X-ClientProxiedBy: PH5P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::13) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 5463f3f5-f97f-4787-30af-08de0806bb38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qk/AuM5BEeqyXiAYW6tC8NlYUV97YaNyezqLqJ9nDTrTT/2wAVQhsNrPWhMg?=
 =?us-ascii?Q?OXhhKCHjGcM2O+RNK4/CH+hR24/BlAbBaXdheGrRmx/gv2Ul3e7uaD1OyJBq?=
 =?us-ascii?Q?fPHmnb0lkDcumN5RzNbCXIUg1bS3y/2G/6xjQSC1HqnPM5ZRsahoAEESDuZP?=
 =?us-ascii?Q?hAwZ5doDDd+xihFVXG19vJD+Qn9wBL3hHVrOvdTqKtIrvkvVCV29EqRkhgYX?=
 =?us-ascii?Q?3kQuSWjH4cNV6Stx+JnZyQ05quwDRoz7TilIX3/z9VWVjZ8Ca/hFz4niUKFe?=
 =?us-ascii?Q?d4EFXJweD6xH0Yr8RPUETq1mAbsX/IAo45fz12k+8taoexCPmA60gHRUwvrW?=
 =?us-ascii?Q?ZLUHd1BAPOR2jvCOzm86vdIpRCcwbS0c49u0JpxRC79e7WZr/jLx5t4x5LSF?=
 =?us-ascii?Q?nX4WhtPTUrN/H2afqaI6EiJYrV7a+v/YL8bexCO1h3p1r52I6JYAwYO8GvyZ?=
 =?us-ascii?Q?UgYiEtxs1JmfMo/jZh3iuOxenuWVSDYzJeEAmWB5nd6RyMlV6niPs1SJsq73?=
 =?us-ascii?Q?QmC/GEGaqwbk6f3GSeIocpNxSCab306WMpaGw0nG84irgT14Aku4sasmx1El?=
 =?us-ascii?Q?m6BY9CsYRcUFbFJktam1dFCIXmWP172PCp91Grijda/Zu5ZGQaw+P7Gvh1RL?=
 =?us-ascii?Q?jm/WgLGhjBoM7wmGUTd7TLjzcRDOPVTScx9zmc9TW+lfS4ysWy7stXd/F9uA?=
 =?us-ascii?Q?tstMjVTblghLazs/oZnw6dTIVa1ymV1d7L4xmvuKSiT11xYOJuU4n6LZ/4fs?=
 =?us-ascii?Q?bgM2NbpXe0LX1KnQJV5xGvpZ1BEUpfLtPyyI0rz0YiHDDRDGOgz/R7D4cMPO?=
 =?us-ascii?Q?S00WNYxiuQb/uIH9zcI0RWt60nExSnGYGYtPPJ+E56qbTca6RQq8CQzu7YgY?=
 =?us-ascii?Q?uuEKzalzuZwPlJJyj1qDSt/H4gQa2LgRrB2Qx9GNmnllsGUK2mPhJEuS5Lit?=
 =?us-ascii?Q?LBNAc/BOgHMw+U01d1MOxeWT9zeizOejs+WFr8sLj3fCcpYh7QpVmsyPoe2/?=
 =?us-ascii?Q?Quh9qOhtEbUmXagrFlgkQou3xaao4KyaDld1Mnrpint7U0IgE3KqspNpXJxQ?=
 =?us-ascii?Q?kH8IsJ50rXAYcKJYFtiQrxJHK8lLcUIC+XKHRMR2qCYJIsYtXkkIyiMKMjQN?=
 =?us-ascii?Q?paKp6Ct91oNDaP3SRVbOyJoq1BqNw94WXk5D3isyGFfwBqgUCa/aMd9LHgAQ?=
 =?us-ascii?Q?wz/BxEbxN5+fV5IZ6oc2r5itbRBPJRGg+PDvpdBJlZCBHS1uCOSo5PKbn5wJ?=
 =?us-ascii?Q?BCcxIieacRdNHzfqB2Q8HSucDa+T6mRIYswcxGS2wJPSBQtnkZP1WeNFhaef?=
 =?us-ascii?Q?tcl2gyI4Xu2IhsEg8UgvL8Qq1bYsC9al1XWHEAkQ45uqZJ2Z8FVbF2GMF456?=
 =?us-ascii?Q?SgFg/RMtjkfoGPVhstEmWID04H+vnEKKGo6RumhPv+NiN49WMuRv8CVv74Ov?=
 =?us-ascii?Q?YFAlttIf4grtfsmsplpBShFzkhMo0aAEsVI0eObrbTQGFmk2oDuR1trATlto?=
 =?us-ascii?Q?dldvlN94t1s59qnoehL/kXdOieVERUO20fo7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t/fDe9NMu9GmxS1TT6/L07iRthw9fCcne48v0qNQwInIR25RYVJdL11bNOvL?=
 =?us-ascii?Q?F0o7s7yqxf058vXHMlYWModcrZLO1r1y+puOz/K9QsRbXYFqZcq8kTAr8a8A?=
 =?us-ascii?Q?S705TXXrVGiU0nAU1utkH8Jr8rm5KDj0760yUZDa2tRi2Q/KT6KXcHvDiZNt?=
 =?us-ascii?Q?0vY/7/o+xUPE+kwsXHOfxOW21ddvCOP04MDkZkwJ2SL+Q2RyBsLNsl9hm315?=
 =?us-ascii?Q?iQm6o6VlFPWTrQalgKKBPUrOUyBFrVKN5vU9dTQbuVD+KFGFNL5sUKgsx1fE?=
 =?us-ascii?Q?AWAOM8IPSQh3KW2p6uePceYgkT5kQjGMq9jUQQuxSa2fir4Prksui4Z3pod7?=
 =?us-ascii?Q?4NE1ZWGqgs57ddHU23JVaFzVvBlFhbFbTNCJZTxLgZxEpZPot9wsUBZ4olc0?=
 =?us-ascii?Q?/RcYeoXVRi+VoN6nzMeCt25c5TZWCBSkYF1WJ0djy7WSdD2KVUlc49q9CWHq?=
 =?us-ascii?Q?+xoWpAa80k62+Rv4zqgHvmbj/rDUGcjjx0Kdkjxv4qBZ0O61fn1T8VuuvBS2?=
 =?us-ascii?Q?opTR37lGmtUs0YpZlzfVN2yA9cSG9jUYewauPmRoPdpIqTZulCdfX4OBIOy/?=
 =?us-ascii?Q?UvgropIlWjSiUXP7kMgXQsG9GpYWFF9qryRc2eSMQ+knOWkEWKqDPag7u9bg?=
 =?us-ascii?Q?tlXlR3IIlJlspb7BDbrwmbT7q39oNeEd56UFl1M6NsmqtTk3pXN6I0OgWlH3?=
 =?us-ascii?Q?q5hnEOCI7oD0rMNTZPk29r/Z90cji9IW/MuI1GUzsj3fgz6Zs/6fSqMDb5nX?=
 =?us-ascii?Q?QyrqVOFG0OXkCoOIWFzijQ2gK0FumLINcq2MJ9A9biBtQxAvQq115mB39ax4?=
 =?us-ascii?Q?7zuV0d1HpwSMmkdaiiS5r4a4GAcwo3PGVsInbeqYu0twNnzejWgjXQwHnf9X?=
 =?us-ascii?Q?Ky/ubbma8d+ecRPm1Qrc31VNV/ru6IAabg2vmR7MvutBw+7IKC+gDWDaQLLO?=
 =?us-ascii?Q?Bl0MG4C2K9nHGZOoULSua368qVvySsgLau0nIYC3Eb0q37C/S9lBFwpPnyFZ?=
 =?us-ascii?Q?CbfBs2FKqQWHRh5KrZyp0P57ufQ98SQMGyPhR/CSlU7+tX4+wKUubHVMVvV1?=
 =?us-ascii?Q?dgDSA02hxlXL/GhXrRsLo5HQzAY1C6Dg4BCN58+HYLoh7Dyfe+PZBnWqINlm?=
 =?us-ascii?Q?2Et3ysIVv7VAWkQVrljK19XOo9R36g0ri8SoNoIfqNok3/57ib1foxQDyB48?=
 =?us-ascii?Q?ettAb6q4rDyiZ2d6TMgMptJVHasaNllF4FGOmRwAzL6yqnltoZnRFZ2G8Eyv?=
 =?us-ascii?Q?5xxY7Z8FMoRuKYHixj6qY4Fib+afsh9XojDFdWWsRTWRPZmqI18QyUYQC8EY?=
 =?us-ascii?Q?SnNq4E45tBV3l0PRt+S2wXMv/eCTMC5uD0MMrBp2tHtwuZxcwDFtflsaLkcN?=
 =?us-ascii?Q?FElk3tGl/QNPza3WMEEiVj2F1xJXFVe9MRyL2Bj39K8MUQ+Y0dGF9MHsJfsg?=
 =?us-ascii?Q?GLxmSxcBNA4V+ocTrs35jRltlJ6yV8re5ZRoz5k3Bkt9SljTUol1yeJN0ztD?=
 =?us-ascii?Q?Gx/Bz0pyBpIHaFZONgxD6IwwvN4Aisd+ipZ0LrJm+E/2WQihdQw552fxzThf?=
 =?us-ascii?Q?rCqmAZfoAHSuXk74MCD/MS+SpmdUyJFGZ2M1l8tg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5463f3f5-f97f-4787-30af-08de0806bb38
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 14:10:14.0473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QG71FPXQ9J14Ou2x6O2aDtUooLTunfZpXgqZ+fBCEA2mX7x8osGo+g8lvQ1ghNUl0U3vbIEg5CzNHKPTSSQSxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7671

On Fri, Oct 10, 2025 at 05:02:57PM +0800, Zhen Ni wrote:
> When fsl_edma_alloc_chan_resources() fails after clk_prepare_enable(),
> the error paths only free IRQs and destroy the TCD pool, but forget to
> call clk_disable_unprepare(). This causes the channel clock to remain
> enabled, leaking power and resources.
>
> Fix it by disabling the channel clock in the error unwind path.
>
> Fixes: d8d4355861d8 ("dmaengine: fsl-edma: add i.MX8ULP edma support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---
>  drivers/dma/fsl-edma-common.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index 4976d7dde080..bd673f08f610 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -852,6 +852,8 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
>  		free_irq(fsl_chan->txirq, fsl_chan);
>  err_txirq:
>  	dma_pool_destroy(fsl_chan->tcd_pool);
> +	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
> +		clk_disable_unprepare(fsl_chan->clk);

Thank you for your fix. clk API do nothing when input is NULL.

So check if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK) is
reduntante.

I saw existed code have such check. You can clean up it.

Only need keep check at probe()
 fsl_chan->clk = devm_clk_get_enabled()

Frank
>
>  	return ret;
>  }
> --
> 2.20.1
>

