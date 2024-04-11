Return-Path: <dmaengine+bounces-1812-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E20D8A0614
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 04:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616251C22C0A
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 02:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51BB13B597;
	Thu, 11 Apr 2024 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LsNTlKrD"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2126.outbound.protection.outlook.com [40.107.6.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD94B13B2B6;
	Thu, 11 Apr 2024 02:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803260; cv=fail; b=II9LFbkWpbLqfNPD2qYMRorDiDF0Q6XLOrCNs9iOxUxUj/MWDVmzpaedTqgxJISGdW9DfS9gUH11y7xseMMU8CFKGHXNceDIMID1mdXTAiVCV0xjglas0omySz+ai2viWKPpZiVDrtQXMzO7xiztUY883ZDcK3k/CQHuVFS3RCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803260; c=relaxed/simple;
	bh=s+nQ6CqXSZyvOcLEt3Fh6bbuSIYl1O8SQ+zXgowlLUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Itq0lyXHOWFWNfd/rg2OxD2sO+z9cW2jrwMu+Nvj8rHy7BsnYCcMnuZjESabQPI8txfmkXaH33UX1FGBKu1kN30BCpDIRWJgaOmugRx1XGsoT5OrA+rqCk0/mlXbDj53D8DPr6AR6f4CicW30UvZnwJEvzlWJQbuSw/qu9FkGJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LsNTlKrD; arc=fail smtp.client-ip=40.107.6.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OO9ZEJ10ud/KkIXSc2h7zpxCZnBVKv0KewkNtby7e2tG1CTwDA3TPyPix1Ekc70Zfxl0ueMCRM52GcMquDq0sigP7FBiQ17elEvhZ+7cIM0cSOtLa2nxNC93kHnGG8qBbe2sjOBv1RHV6Z9mJRFayHEfLTkFQwNisE7OcLZsLwy69zwBA9r+nx9/bURU+ur6PVtCig6ZjbEz7MA8o23hbQ4TrOpM5cL7zzHo1+M6bJouSMcIyEWvxR89Hbq83Cr/TjxyuXId5NprHAuRckxfq2TPlhbl5HojUTg1xlDKnzJDIx/c1Dh+nRJ5PJyicJWze7mBzONQu3QcuMYXT8z+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GieE5eHaUijkQ8f0/CZ+PXHgebpiuik/hn79LcYmU6k=;
 b=BbACeCkvvxeE29VsmmaZpKo+FbLr0Fx4higE2cwbIjoyWIJB31OafS8rc6dlcdwSIDeIky7z0zMX4IIPAO42weuFfuZTZ1D1BcwwEGrSZ9d2LYNcEIJJXaQDhDUBU45L8eUoJrDF//9LPJp5cv59o5x4tHIL2XEt8vDRt/NJhVAjJu8LkllfXO7enQPd/OxtwCVgOxHayXxN0wV59aBslWp5VVNpWZztwHPKh37ngCYDwdSIUkyQD+qWQNkzfpqeyPuAc/5SsiIP19C9r9/66ldUme78+HgF/A0BMsiDJlKu+7S+22Bz0bOwAuflmewttbhb+kXhbIqmoBm2LpnZrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GieE5eHaUijkQ8f0/CZ+PXHgebpiuik/hn79LcYmU6k=;
 b=LsNTlKrD+RtK4f54PhoZ7tLgHrSd3djEiswa/GEyH2NFZqpCWFOZha5qvVbF8KaCSTB6O+borQ2diCO2Ga0JdA1eodf2zImAo1BNfovdlix+yI1v4SPjt26Aa7gzsem4J4QcXRJ8DV/Ihv0x2ddRfEDr1noIc8dmZyVM7nXnHHI=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8566.eurprd04.prod.outlook.com (2603:10a6:10:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 02:40:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 02:40:56 +0000
Date: Wed, 10 Apr 2024 22:40:49 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: peng.fan@nxp.com, vkoul@kernel.org, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] dmaengine: fsl-edma: optimize edma driver for
 imx8QM
Message-ID: <ZhdNsRyMxm0m83P0@lizhi-Precision-Tower-5810>
References: <20240411024417.2170609-1-joy.zou@nxp.com>
 <20240411024417.2170609-2-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411024417.2170609-2-joy.zou@nxp.com>
X-ClientProxiedBy: BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8566:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ODUCL+1ZNv4z6IJQ/c+GIV7ZMkhmbsv7A4LZa6FpYw8mi9xX9GkPywPVkb2JgkA9FU62h6tbZLiwi1Y6Ab3zywYJfhFM0ZQnsGXPYw6tLVgLRcBrvPM9jMoFz1LZoKRp8cm9HkPUjpNk1SgpCc9BrBNyqJ0ViUEY07IMKrRT2YNs79d4Gdd2ZRZ3beBsxjjT8czOz1OSphj5Wlpmk8/1aeCADdCMo3K76fDD0z4K/TZDdjmVoh8z6tujNiCOyzkhJDCyB0mTuhztxgblpejZspyTikKGz5WXV1Wbg7Ipis06k4fqiFTXC8TK90osFBqJxCJwp51LJl7CgFur8rhd+r7dxWrtd5rMC6uOZ7RN/jhW1nPVX8rni7M/5IPXBPvEtScO0jcdh56pVQfSuD4+pjelhYEWfP4/vIyaASbNLbHFO9GFDFGUGtA6PZ1QE5AVMDrvZ06y4OKx/W4PJMX3dpS/1Qn36L7YGa10LZwT36fb98SoSTkwJ8sZbHOTJLe0GH6STk3z9fYIShOL0/vI5p+Kh0UJ3+0QL1gipM1DpxvYlqLMsrK6yJkxW9jxt3lISldhZ6ZA8+QP7nw+auMUHfiG9Q1cDz40DYOharib33T7XYiuOHqHUrqjPxVBCMfpOX4X/WwAvbQCjrzQ0cXbKQZZ6yhzfAVlSCAWLPB6fTi9cJwRlkC/QlbkxIP+5cNzLwQIlLGwvkQS78V0ryO9fg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(366007)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PehnSGMwQGy7/CFLuzufQxpbEfvYRSo/gSivuthZ0tiPbMMfqRLKof0Mt8f9?=
 =?us-ascii?Q?wRn2KH4UCnNLG9p8W1rCKcOWAIcNwkqJmCYtmXc/4g0PB3Wc6mwR7O7TXey/?=
 =?us-ascii?Q?zIAdPXR/qiLYi9NauL1m2gsYBDdir5TIwLkgAZb+lmG4kH4yzx5qiCGeeKbD?=
 =?us-ascii?Q?FvuHRdHbVvYnNkS/PiHsY3FG0jwNSjnwmMcrijsRa7hh3efxh9JmD3340E3A?=
 =?us-ascii?Q?8jh9lTTzZV+qvcpwbTDTwrEYwETFSSlQOvdVUKhrM9mjUR7j6Eq1uiQ7Gj/O?=
 =?us-ascii?Q?eJA4URceV8y1xlcdWIkIXh2CCuaBSFAtQiWYZWJsodm/kTC/hq8FuVQEb7Eq?=
 =?us-ascii?Q?dXcVUacSzsAkM5X9XiKUYzosZqL0NrOniUFlivqwkCgpespe9iUP9WmSjuwF?=
 =?us-ascii?Q?/7dyGdP8QrlAA20MmMEdMAq2g6Xl4NPai8mJ7YMHgwy6T/xThjd7eUMGejz9?=
 =?us-ascii?Q?Uo8ltSmdzn6C7Ssbcgm95abtBdNuS4yio8zSuuKzglnlZLAZwt4LtLGIRjuK?=
 =?us-ascii?Q?vSxmjQUMKsmdVfdeKTwOsDJr5xZ8H4QqOnhsjYPdU2h8rhfi8LYLBLO+uPvr?=
 =?us-ascii?Q?DB9i77y310RapQO/xWfdDgNAEqVUrXLg14v07fv5KL7SYWjUKwjyiSVi9K3N?=
 =?us-ascii?Q?g/zYHVBov9xdtdZIapiH3abCYVQyGJQV9ZaTQKOMYwbfvxcKHudVpv9hJR0j?=
 =?us-ascii?Q?xA5fbVwexSufLu8iENL/Ma4Y4NE3z1X1OZMI+SErqiMAbTNdLu7InEfvMaiK?=
 =?us-ascii?Q?wZmOLcmfsjxP0RBh9cJyR3/ZCf01B31+sHKJooweRip6LIga6+PMH/Wo5UF9?=
 =?us-ascii?Q?LDMLzLLdq5CaYjV0AZmf6rR/lZFOWfJih6CsTkwsVjr2I1/fOikw5Cioczna?=
 =?us-ascii?Q?/BqLN+gx3w5+iTCKQR9FiuxmW9ecwhhts/Ygja2R9rEPXV0aWLrNrrEaVDMV?=
 =?us-ascii?Q?IJAkKyC4dL+YLKpLhjzFUH3kGlMDJvUCVkjF5uwCIgKYLHODHTo/VbgblcxR?=
 =?us-ascii?Q?7Q1Sl+5/SsC5INcyfAwSrpNUMGH0MihVwOXxsdVPgRAkzCAG9SgVD9SZmDSt?=
 =?us-ascii?Q?82HcWd0FxFdwcRGeq2rRqwRp4o8MIyUuUW6UeOpZg6wQHK938adkzIYcxvyH?=
 =?us-ascii?Q?H5u8pQQ7DCVvA+MVBmMne8E9qUe+RMI3oPdioFSSOJBYAZ3Aq4mLbst1XRjJ?=
 =?us-ascii?Q?6mz/SjB80EUt8i0NsqVbsLgAo9Sj1C08iClRgnEb3aqw2Q3OxJiDO7epCV6s?=
 =?us-ascii?Q?hCvya1ita2mdc/D8jVJbI2LMzedDrOC9BmWYi4trfVBjKGHc9XfaRlpXKLUB?=
 =?us-ascii?Q?CCl8X3Cp9ZUG/6Bx0zciCyYovPt1preEvbF80QGZOCoSIY/icukPjZEZy+GV?=
 =?us-ascii?Q?iDkqZHrSXnjBGvxuLuDTAb+l3JwGX0X5RUdUcgd2WVkpceb+//z/zj5JgNHR?=
 =?us-ascii?Q?uP1uoSExkDqaF6zBQHeoT9CjiFbg+U6UPxBac3JoYEIfyf5OFOMwyc3wrV4f?=
 =?us-ascii?Q?rWYCoww1usDT1VCMllWbpnGiJ4xquTEQJL6aV6X/zjMAhEowjIuDhx4BGQ6S?=
 =?us-ascii?Q?qEQg7Wt13l2fnAhomxTTK3Ydp/Lowvl6urutZBl5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def32ce7-f00c-491a-b51a-08dc59d0d01e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 02:40:56.0776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gmTqjNxfHDzqLJ6b70Hpk02DBJEkqYNvDNpPooHu8Cs8i1UyzsWsNBtLEZ7P1Xu0q46UfvNkyEZb8V/MykBGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8566

On Thu, Apr 11, 2024 at 10:44:17AM +0800, Joy Zou wrote:
> The eDMA hardware issue only exist imx8QM A0. A0 never mass production.
> So remove the workaround safely.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
>  drivers/dma/fsl-edma-common.c | 16 ++++------------
>  drivers/dma/fsl-edma-main.c   |  8 --------
>  2 files changed, 4 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index f9144b015439..ed93e01282d5 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -75,18 +75,10 @@ static void fsl_edma3_enable_request(struct fsl_edma_chan *fsl_chan)
>  
>  	flags = fsl_edma_drvflags(fsl_chan);
>  	val = edma_readl_chreg(fsl_chan, ch_sbr);
> -	/* Remote/local swapped wrongly on iMX8 QM Audio edma */
> -	if (flags & FSL_EDMA_DRV_QUIRK_SWAPPED) {
> -		if (!fsl_chan->is_rxchan)
> -			val |= EDMA_V3_CH_SBR_RD;
> -		else
> -			val |= EDMA_V3_CH_SBR_WR;
> -	} else {
> -		if (fsl_chan->is_rxchan)
> -			val |= EDMA_V3_CH_SBR_RD;
> -		else
> -			val |= EDMA_V3_CH_SBR_WR;
> -	}
> +	if (fsl_chan->is_rxchan)
> +		val |= EDMA_V3_CH_SBR_RD;
> +	else
> +		val |= EDMA_V3_CH_SBR_WR;
>  
>  	if (fsl_chan->is_remote)
>  		val &= ~(EDMA_V3_CH_SBR_RD | EDMA_V3_CH_SBR_WR);
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 755a3dc3b0a7..b06fa147d6ba 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -349,13 +349,6 @@ static struct fsl_edma_drvdata imx8qm_data = {
>  	.setup_irq = fsl_edma3_irq_init,
>  };
>  
> -static struct fsl_edma_drvdata imx8qm_audio_data = {
> -	.flags = FSL_EDMA_DRV_QUIRK_SWAPPED | FSL_EDMA_DRV_HAS_PD | FSL_EDMA_DRV_EDMA3,
> -	.chreg_space_sz = 0x10000,
> -	.chreg_off = 0x10000,
> -	.setup_irq = fsl_edma3_irq_init,
> -};
> -
>  static struct fsl_edma_drvdata imx8ulp_data = {
>  	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_CHCLK | FSL_EDMA_DRV_HAS_DMACLK |
>  		 FSL_EDMA_DRV_EDMA3,
> @@ -397,7 +390,6 @@ static const struct of_device_id fsl_edma_dt_ids[] = {
>  	{ .compatible = "fsl,ls1028a-edma", .data = &ls1028a_data},
>  	{ .compatible = "fsl,imx7ulp-edma", .data = &imx7ulp_data},
>  	{ .compatible = "fsl,imx8qm-edma", .data = &imx8qm_data},
> -	{ .compatible = "fsl,imx8qm-adma", .data = &imx8qm_audio_data},

Please update binding doc also.

Frank Li

>  	{ .compatible = "fsl,imx8ulp-edma", .data = &imx8ulp_data},
>  	{ .compatible = "fsl,imx93-edma3", .data = &imx93_data3},
>  	{ .compatible = "fsl,imx93-edma4", .data = &imx93_data4},
> -- 
> 2.37.1
> 

