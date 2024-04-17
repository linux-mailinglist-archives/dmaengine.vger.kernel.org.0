Return-Path: <dmaengine+bounces-1861-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A4C8A862C
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 16:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D501F2156F
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 14:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC4E1420A6;
	Wed, 17 Apr 2024 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NwrMCbNI"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F3D1411FF;
	Wed, 17 Apr 2024 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364813; cv=fail; b=TVcdS+vf9aRjg1NqRrmLHG1cgo43X3vuyJks7cofA5/HqS5V2uI9D3L4jp0cLpvbIQy0wIa9nd+pl4sLQfbDYb+XPOnl/an7SuSiNnk0eoT4460QKDm6cO9nYmUAXA7++B0UW6EvSXdl6N9Jfs87C7sSCsWiIjiBo9Cs89v5qUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364813; c=relaxed/simple;
	bh=zW9ULleo6DXTv8a5ky/KzX1CEhS0eEOfF4+jkCEVguQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EgPsrqPSf7v0tD0oN2fQEEZgnUiUdyRVYyfGBg3LUGmhPu+W/upFzJmj+XpS4cdSb4rx3Aeq+BRwua6H2EPmT/8Q+0Lyfcb5kzg4b2WtsXyfxsFD/DEnb864iv+l0qwAzMa7d5CPJZwBs0A3oy8f1bR9T7OSqfMD9zUgIgj6Lvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NwrMCbNI; arc=fail smtp.client-ip=40.107.8.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erTPriM6D1FCwLP3JoNllf/MHDNJyRxyqZVbVTqVZyNDcX3QZ+tTiFEKLl/66TorDTS3MK2zQhRlnRGDAzykzJ089xmfUCqsh0rLVq8wC2z3QS65BNT1eMOiuY6CDP4m6kS1ey5ZxntBgc+IrUgkSnGhhNPU5JbIgARizWLRJkW22BIfnBMGdNEaAXgjbhfAzrtXPQaYe004AuKfki+z7GPA8q5BK3D8Y7k5WVAEP59H6DXVOANlchqJbAG/9rEOviD5+U77vsWVHGX8bOKSzLPLCwgtyvnl0clBvus+ES01x1OzmhZNq1YFJ0/8Io30+N9LiVGvzEkOyhb5YQrzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRr9riG+SZ2CsG6J8U0wY/bRJHOcE2BBP9oAhitbFXc=;
 b=Y1EHyk/tlfmswDeTeGNq8NzTHzAqA9mLcnjCYofBu/RzCxwndyW4by9ueWVrswR4J4Wc6FO+919MoA9M8+zwkW7KvKmaA/bivNAHg2X0QpL4twz/4Toyn3hSgc6VcBV2Zjn/VdGO63X0yWB5mOin3HFOQ6lcqeDn8HR4xqXB8jw1iAJwZLOaShAlo9UeM65n4buw0CIapNTfheKtPFsd83ioNmZD6WLSBKznezhbodzC94pz83UqRpZ47QdwrGtdxcIRTJMC2QjRHxqJU/4f9UkrtYdduRT9GbvPq4jEpU0ZKREnhlWyloZ5XOFMJoBhwDpg9E4sf/mUO61p9o/WAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRr9riG+SZ2CsG6J8U0wY/bRJHOcE2BBP9oAhitbFXc=;
 b=NwrMCbNIXR9KaD4rNP5L51M9v4fl1rfha6QGBAXpkzlQVZAi0FsGg6fLb1oMNprKUPyC0TWb7sMfPWqxbPy5IEWmy3WYWTPvS4B9G9Qt33wAMWAgrEYW3YSyZ9WL9AsklgnDGLxAyW7st22ODqmVL8NBP83kG+nePpFUWlbPUkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 14:40:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 14:40:08 +0000
Date: Wed, 17 Apr 2024 10:40:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: peng.fan@nxp.com, vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dmaengine: fsl-edma: clean up unused
 "fsl,imx8qm-adma" compatible string
Message-ID: <Zh/fQFdxHHxC5iXF@lizhi-Precision-Tower-5810>
References: <20240417032642.3178669-1-joy.zou@nxp.com>
 <20240417032642.3178669-2-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417032642.3178669-2-joy.zou@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: aef69817-66f0-4d22-42b8-08dc5eec4771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y5t8RBh6118n2y/mqOO50H3fb3zIuj3LCo5h8VSlTBoF84mvCTcI06y2OcJRV8uHB1gD9JmJOkQirOCW7d5RnoK3ZYYR+g7FcLFJ9Qj4EJUrzW53Ivim04HjXXBEeEVrOViiWpPmJqEg/efv6qb9lNYpzEi0k3vx6AKnryq1FjNferImVQwU1zxNKgZS1D64o/77rw/0mHbw9P6pL7jNtCn7aG92Za7eTlpxtiDxTQQ7hFBsTJadfUUKMoggKckbwKdtKG1u+o9pHFH9DksoN6BxEuioos78rQM3I6QwUU2Ml9YS3UvVTb7+c5XoDBA/OPJTy+7sFZTebsxZrLXavCUdR/0pig5axtWDO4zd/mIVoullKTNU3jr3Y4LVr6MMzf2TW+do90/hMOKCfGibQP5ty2IKZrxiGzzAcguSPCCcv7CSlw6tmlrA4r5e188qRYZ3tot/noiDyau/vlJanlG1eofHucJhxDzfS3PevEAf0iraHdvTvjneMleiZp5he/2SnM0oXhfqgV6KsQJJSTVh4Sg/Fe5uclbiejlEBhuRnHtZzCIFb8wpOSVx2OpQbcPmohAK+57ukiWE/hPVD8bfZe4MuJ3D93mfTdHBQr3dasO9oqAqZ6fQImbbXkzNvk79xkiC61EcfP0CmJeuDCJS7mmLzH/fOAL35hucMe0W/EoGe6625fnrSu+e2x30d0Yq1+7yZlGr8D0QDSBPXswdSWZfPIfJ9iUTePra3/A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IcowwsSUcM+VULdgiOobRwaZt/BKbJdkA2N7clUb+rHjNJr/KQb/O9rBj+r6?=
 =?us-ascii?Q?IJZ03pa38qBPiKcLxhLgwGHEdwUELKXt/96ttqQP9Khu8ZQdnM3kgco3qOhz?=
 =?us-ascii?Q?InAb7e+lR7MkeBMYxwOrtzCZ7vHNpwkDDOJoBuS+pBZrru30Ya4VDO/TSIBs?=
 =?us-ascii?Q?Dy9JoRv6CbwxHtGCfin0QxcUZx2FNsW1YpHTPdpRi7s++LiZ554R/kMAwrt3?=
 =?us-ascii?Q?Jh8kpElqxzIuj9R5D/rZ9rMkj5uz4nQd1MpBMmV5twNFDaakJWtRjnloQ39J?=
 =?us-ascii?Q?qLuiXZp5CdmrFBWfHfwsqYTgX2YQz7y/6oeZ7wYZMse6VXNxXcSz1rgCjOSi?=
 =?us-ascii?Q?WwfRyc3dbthK+tAcXE73OQHrcubGIUvi+X0oiuqjoWNKXpTCBu7e689jxge0?=
 =?us-ascii?Q?nQ4oe9kHbDkcciLmHwvgsUpTZEr5SrAzljZVyYNfOaLsmN+lSWlsAFw/zzne?=
 =?us-ascii?Q?Kd9Rzp9ida0Y/GixUXPSO5y3vLFiHl/J4645mRahqZbZBqqGgiDxh2veEMMJ?=
 =?us-ascii?Q?bktzsIHXS21kAJ7qb0ZGwdtJn+f/U8t+zfzFooAalrgvKaAY7ZgWiKiQVCSg?=
 =?us-ascii?Q?5+1rM3eHbSBv05txSdpWjPgpb/BvZaWSFS25IrR5vCv+v1be+Q3DzYcqmHpH?=
 =?us-ascii?Q?yMrmAgy6i5fWFZZCAPRIRIAmNh2m/pd6WM+sF/cz/mW5KvoD8CtpOx1ODNV2?=
 =?us-ascii?Q?zi3+VMbE+MJq/hWaQHtR45I53H5P/ifvrFiAcYaFefGbYV93oLNtDJlFwDsA?=
 =?us-ascii?Q?QACHIv77kDmKQfTIJ8stuOTIy5hZ4M5Jq6CYcXySDNziqK5qwq2Y7f3GxCjD?=
 =?us-ascii?Q?+5bQLWXPuTxDCWed5QKU5G5vHUz5DQRKakQRp7+yQ1xli9/vEbW5OygZPZ1e?=
 =?us-ascii?Q?rTnQfYSs5IolSlRMXbW4yWgASZCJQcCSMUQcOMwvvvO2meSkz/6J3C9MLnnO?=
 =?us-ascii?Q?UG1gU9TjB6spG1ACEf7ofTB1LJl8G4wivxCVKBNgBt/Pm7PpxG3y3hyodAU6?=
 =?us-ascii?Q?UfzaEpIawdGoFHxGkBODbAwp+aEfWkMifKSPAxWRiYYTWRGKLaM9+dX4FV8x?=
 =?us-ascii?Q?ul7omwtIXx2/BWZDsS8rH3rKs1sMW+WwCkhU4ukPbpi4ZQ993B16zxg5uxfy?=
 =?us-ascii?Q?+3nPfLoq66Flyjpf0JdEKPJ/RL2/9dZeLPRCFBCeF8+QKbINadh9wy+FxG6h?=
 =?us-ascii?Q?tOhWHf6ILpG/6rgRiKv1n4Os+8jz3EvQasySxqjHwdJ0Q3BYnn3inalTJUDu?=
 =?us-ascii?Q?tpboWkbscHw51olsUkBnCRLtZQ/T8z0K0c5kkzS8DWQpYIgZucEmAK0RtipG?=
 =?us-ascii?Q?zW2cATeR7zpJJIiMivyTtZqr1s1YQz+q7ditUbcastIYYYi5bppvZxU6CVVf?=
 =?us-ascii?Q?Yh1CfVKvbE+7PYnSbjRM8NWSOjwAto21bn1npneTW13mTIaYdFAGrZ1uIno+?=
 =?us-ascii?Q?YFHcnfzZkazi9mZrWrGnL6XT57XHW5mOnpFzMmh4VzoYpjgsceCMFRUKoeQm?=
 =?us-ascii?Q?jtjcIdtgXXcNqzqLfSiFpq+nvNCSm2zOa7XNC+ZzKjPGHhUIsxYuLms5LnPW?=
 =?us-ascii?Q?wCGy/X2Fq0tmsMbgk+t8MP99gm75zHrPgB4ZBnsO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef69817-66f0-4d22-42b8-08dc5eec4771
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 14:40:08.5170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THCmRw7y9BjabcSxHU/Tbf07CDrxBZikVxTiG9VbrvoFMfos/zWGuDtXKtkQdTrJhEMlMtt9eQp064X4Lvsi1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7374

On Wed, Apr 17, 2024 at 11:26:41AM +0800, Joy Zou wrote:
> The eDMA hardware issue only exist imx8QM A0. A0 never mass production.
> So remove the workaround safely.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes for v4:
> 1.change the subject to keep consistent with the patchset.
> 
> Changes for v2:
> 1. Change the subject.
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

You forget remove FSL_EDMA_DRV_QUIRK_SWAPPED in fsl-edma-common.h

Frank

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
>  	{ .compatible = "fsl,imx8ulp-edma", .data = &imx8ulp_data},
>  	{ .compatible = "fsl,imx93-edma3", .data = &imx93_data3},
>  	{ .compatible = "fsl,imx93-edma4", .data = &imx93_data4},
> -- 
> 2.37.1
> 

