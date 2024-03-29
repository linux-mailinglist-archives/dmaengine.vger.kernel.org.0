Return-Path: <dmaengine+bounces-1651-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 195AB89125C
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 05:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E18A1F225BD
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 04:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B603BB22;
	Fri, 29 Mar 2024 04:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s5N5K6DX"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2124.outbound.protection.outlook.com [40.107.247.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBA33B785;
	Fri, 29 Mar 2024 04:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711685935; cv=fail; b=Gnr4/wjF3m1w6Kp8aNfzI9nB+1i3SDUyozxVbBG84CPc5XBcSgU+bTw39FlSHCucpiYDFsyghpN5PNTQd4E8TcOfICujX3vxCux/cZWpyhR4WotaKPQteo82mhpH8C0zEFlkxGed8XWnm1XR5l83xACIaSxXCam1sqNN1RyYs8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711685935; c=relaxed/simple;
	bh=DHKQnaVz44PNXnF91EIZmDmHPnNsBdKCYEmnh4Tm2yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J5b9cTAAxY9r+wwNK19SU0/0DFaKxN09Rv5bz16nGCCZmJjjJuTCroM5KzAYgZoTaqCyIqRKKDxSDVqb7hfnz1kDwg4YpQhMf+n4uHs0vhGgP4piEaasutQ7v6H38TMGFNywf33VVcDERXO/Ev0tE3eQTRpA4my2Nq9rwsnp3jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=s5N5K6DX; arc=fail smtp.client-ip=40.107.247.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRIdjhoPZolnyr7nfwNWxBzftNL0hbVAle6wt7cEceMlbeOcwUhZPC+KsShg65CQXkb6gditA20zbUL1N2s5e8HETmF+VarWo2tCJNUmWm534iMvx38J3bS34jhDqa8nSDYs14UPK9rOM0XMSnMlTHeiFVNOMkSFBeIdMnu9+xLv7OpZBvlru4gDpJWi6Jk90AsWWAMVvl+ZlxiXumm4Zg8YMk9kTHe0ZotneOkmSds+tY0bT8JDFkI9Krzu4GfKRCQtkP5vXHeo+DNBK6vzJ2v5i3tSTe2hobtGZuHrrTW0+/xklNLS61jBhH0SmrWs3ppG+II174DDmIyQpVoa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VV0C+5iYrlOGpucgyorNVQJofVEO24xlUl4WCOqGDSQ=;
 b=JoWcRGURRnhmcBGLiw22gV3Tpis9emq90oogm6DOmXvlfPUTOJhhmTk07R6US9Qwo/19bku/JzEPN2w1dSXH1EiiUgK4govTduusUCKx3VxPlgHsdZvthdbPVLaeLyunPfiW8JzDO0ZplYdgWNmw63atUo1/COLdmmIc40hpd2dNf/chGf3F+8o0mnOnYSmexVtpB0JeSKuPWF8gugSS+1HUjV4fgxoh12Sg3xg9JhaFGjQPDm17ylYDkEIKI6dD0ffA12ZabBOphwTpVUVXOh8U8YVY6E+2Ut2vFc7BUpOGi7QK08NaK635/13NyEKw9Bs4hwU/N5HfzkJwQSGMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV0C+5iYrlOGpucgyorNVQJofVEO24xlUl4WCOqGDSQ=;
 b=s5N5K6DXheYV7IWpbuKP6b8MLGvkOZPRN310SKAN7vpezgUsGEVbOzOyJhaxoM7fT9bHlhV0kDTqG0053syNAkKwb+2aRYRAnYgNFG6lWKWBNKwu2XuxMuviLHhaX+PXt3ipPV5ZYoTTrSuYrH+sP1jBjgy15kHLnVV5TKY27OM=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7813.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.38; Fri, 29 Mar
 2024 04:18:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 04:18:49 +0000
Date: Fri, 29 Mar 2024 00:18:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: vkoul@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, shengjiu.wang@gmail.com,
	linux-imx@nxp.com, dmaengine@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] dmaengine: imx-sdma: support dual fifo for
 DEV_TO_DEV
Message-ID: <ZgZBH/HsO8YmgFZx@lizhi-Precision-Tower-5810>
References: <1711682887-15676-1-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711682887-15676-1-git-send-email-shengjiu.wang@nxp.com>
X-ClientProxiedBy: BYAPR08CA0049.namprd08.prod.outlook.com
 (2603:10b6:a03:117::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7813:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CS+ZqEVH2udwKPtSiBlbLxw9Jf9+i1hjaVHcpZDXZW6iyqk5Q35Y4BZmrKbL1cMu9LwXgNoXPOoBKADBJDCpeF8xudvp5+uvHShRHSzsJi9ffjVS+EBFfvyKH0xy6Z6ucsn+iVhZe7rkFQ1PuONg10Hny/FOyBrfVIde4r18Yj/z7NZM5evxuSkKqWy5O2/pEPOvzNopBVIStwgMDWYAZXfstWGEAR/NLnXwQ07gEj+hygOeEuOnk8OD67zIvmz3TZYuRuohuK3YYvxcoUXxILRmiKA06Y08xFbDmzFyMZ3szt0hnLwpXaYXJ9YIL/CXRtrpAilzMFbziS5gNVn2ptA/uQHlUQPFN4S+0uvpu29fykP7etAsq1pg3/eAQvQc19H6HwmsPpbVJLtzWrAiVZW9fXDCKqlu3c3jB2yc/M2Z10e/JKMsfzIV1qSbKR71nmROa3l5hEL/fMoFHOCOZP9bWwXnrEVcEjrVfAykZ3wiQ0025ufY+V9BJQIUx66QCNGaEKDivU5Xg3cJI2MHNnJslQtMdf100xX7o0tdM7iFlBtiA1c3lvNKxWzgHsncTOCVOKjdMxPGanNeWJolhiem1vHjv5NheceAwI4+EyMkHcMlioz79lR9mzYysgJMPWc0rqdq+I4vGZw5eOQ4Grx3byGgvnwEXWxw1jV2slA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(7416005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RypH2/UfRlD/dpMgkdP9lYd/wj6YZx17R0ZZu5/eCzUtagsdkC2v4h5eUj+a?=
 =?us-ascii?Q?DL1Cg7cNQeNMxGNkwG4azoj9oXdg6Lw0MVCAbWEGKJmItDP9g9Hv0TCtY0hs?=
 =?us-ascii?Q?JO630DFRBTt9+KAbf8h8e4aiDi57EPKSP2BIg+8t1Wz0cNmvCBu/4epIDSab?=
 =?us-ascii?Q?nCNNaO+lE0AOh+7xWnaC0+m/CkZK6Mb1fdpBaVpwpRASmY8njNlGNBQcsEed?=
 =?us-ascii?Q?KEn72l9maFkgk5Yx0MJ4zsD6dbvziesxyhLGT0K82Ulc9QlT+xWIQDmtmvgV?=
 =?us-ascii?Q?TJW4JNbDz/YOA3A8ryPRIeLbruR4BcpIg1i0SyZi6FXr+HN4sw1yF3gz1Jzl?=
 =?us-ascii?Q?PIIbZLdCHifIxbeZFoPrSzapKUNUB5qefKyat3SEMethB0pbcmrUnB0Zdloi?=
 =?us-ascii?Q?FCGlpCBGzfJafPHzYOHOfYEACE0/2g+5PH8NqcimEzY9Kcml0t+dtijzJ/hL?=
 =?us-ascii?Q?EfHPmd9b0iV3+Y9gh08jm+oqxgGBSpfavFtbKZMEtmX1rm0lBzp2vw5IYvn/?=
 =?us-ascii?Q?e8QsYkDNFFlJiNUwR4z7jftlG913flVRxi4LnocGrHSXmY62UkQmc1EzZuRR?=
 =?us-ascii?Q?qgTPJrwjb/bexN6iPIdUSJoJ9TxMhW/kyMmwimSD9XNYqTHNq9vDXseQ5SVG?=
 =?us-ascii?Q?nlQyZImYLPzfkG06lDbR+96bAnnku9X/+zEb/0S2z6c1EzRb7Vb+QAzt3MF8?=
 =?us-ascii?Q?vio+TS3/VwVkI7o85bxkSqajhYqH8IQyOIUCUJsEWbbAMONUx1Wnm7rjnAzT?=
 =?us-ascii?Q?QeO6cRfYJW/wp3wZ6G2HIm+Edrv1CwUBKXPPyY56YBm+gqub55qqpWig/NqB?=
 =?us-ascii?Q?vwVnos+YFHjDrGuPhFCgNDLVAg4QZVSFJC4xtw2rmqV8/EHQFdq7RJQ9dxMx?=
 =?us-ascii?Q?KqW5r6hvz7myQI94F4xkiX1DwWhDp2u0K1dHdrGruO+hvfNXJIeztqopWyjq?=
 =?us-ascii?Q?XKaFQhrtmJ8HiWWjjoHN45Toh8XYgt3oFyemGoQ7kHwPIj4becnJt4XFjM/j?=
 =?us-ascii?Q?jxkY+klqCY6Q3ne9vpD2kEwO3zVsCBgWMVDoVADMSyjihwBDkCejAuPUFQG1?=
 =?us-ascii?Q?zAMxPmhBnP9KUo6HHaoDW8i7sAvAZQSr1RYJEPk15uSfmV03jhDz+83U3DGA?=
 =?us-ascii?Q?9rwIj4M7f6EYDZn/bIwHfuQEWI6bHeMA2O4CDEtdkkP2R4TEGbpZeM1SYOFQ?=
 =?us-ascii?Q?LaC0j+wXAqG2wSBjnh8SlPvgjMiGqyIOXUc41WH0kUJ0KuI59AfDoK1NrD9Z?=
 =?us-ascii?Q?p13ZfBtH4WBMOIay6q1cDqMiNAR0OHbmaff/mIgODwUuR1tD6Pf9SavJlPt2?=
 =?us-ascii?Q?wgJiaZRjrB/L7gcBYduzv11kR6wfncu5VQWio85wp5Kdi7HPuChWR/u6nqQo?=
 =?us-ascii?Q?z8hkw+tkWp42vqQQxcLZJ6ZSlc01Hcp84PKSqzBhzhxT4OM5QoT7WQfAwosL?=
 =?us-ascii?Q?lgyZSHjTcauDZTmcpQw3ft1SABaqYMw7NIa+SIE1/tYQm18BWXurBdyOaUFg?=
 =?us-ascii?Q?mcMTarrgpcMQv7DJMWU6Vi7jguu8nbv8fAWpXjiU96iw3JbR/EWirImrD6i9?=
 =?us-ascii?Q?wtPQ6kjfO1hgzAqDkm8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dc0d47-baba-42ed-6ef2-08dc4fa7555e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 04:18:49.1423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3ObqK+bS7N1wDPgHwklvqy3ATCewL40EXwXG0icLzgOgPMw/CDz1of0Yb2sVe03FBiXoDLJme/AT+zDz70rig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7813

On Fri, Mar 29, 2024 at 11:28:07AM +0800, Shengjiu Wang wrote:
> SSI and SPDIF are dual fifo interface, when support ASRC P2P
> with SSI and SPDIF, the src fifo or dst fifo number can be
> two.
> 
> The p2p watermark level bit 13 and 14 are designed for
> these use case. This patch is to complete this function
> in driver.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Acked-by: Iuliana Prodan <iuliana.prodan@nxp.com>

This already in my sdma improvement patch list.

https://lore.kernel.org/imx/20240318-sdma_upstream-v3-0-da37ddd44d49@nxp.com/T/#m59e4e03a527103de7bf1a7fe86e8fbc570454970

This have more nice commit message. Can I take one into my patch series to
avoid conflict. 

Frank

> ---
>  drivers/dma/imx-sdma.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 9b42f5e96b1e..079e6e8f4f59 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -137,7 +137,11 @@
>   *						0: Source on AIPS
>   *	12		Destination Bit(DP)	1: Destination on SPBA
>   *						0: Destination on AIPS
> - *	13-15		---------		MUST BE 0
> + *	13		Source FIFO		1: Source is dual FIFO
> + *						0: Source is single FIFO
> + *	14		Destination FIFO	1: Destination is dual FIFO
> + *						0: Destination is single FIFO
> + *	15		---------		MUST BE 0
>   *	16-23		Higher WML		HWML
>   *	24-27		N			Total number of samples after
>   *						which Pad adding/Swallowing
> @@ -168,6 +172,8 @@
>  #define SDMA_WATERMARK_LEVEL_SPDIF	BIT(10)
>  #define SDMA_WATERMARK_LEVEL_SP		BIT(11)
>  #define SDMA_WATERMARK_LEVEL_DP		BIT(12)
> +#define SDMA_WATERMARK_LEVEL_SD		BIT(13)
> +#define SDMA_WATERMARK_LEVEL_DD		BIT(14)
>  #define SDMA_WATERMARK_LEVEL_HWML	(0xFF << 16)
>  #define SDMA_WATERMARK_LEVEL_LWE	BIT(28)
>  #define SDMA_WATERMARK_LEVEL_HWE	BIT(29)
> @@ -1255,6 +1261,16 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
>  		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_DP;
>  
>  	sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_CONT;
> +
> +	/*
> +	 * Limitation: The p2p script support dual fifos in maximum,
> +	 * So when fifo number is larger than 1, force enable dual
> +	 * fifos.
> +	 */
> +	if (sdmac->n_fifos_src > 1)
> +		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_SD;
> +	if (sdmac->n_fifos_dst > 1)
> +		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_DD;
>  }
>  
>  static void sdma_set_watermarklevel_for_sais(struct sdma_channel *sdmac)
> -- 
> 2.34.1
> 

