Return-Path: <dmaengine+bounces-3670-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D89D9B9783
	for <lists+dmaengine@lfdr.de>; Fri,  1 Nov 2024 19:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211161F228CF
	for <lists+dmaengine@lfdr.de>; Fri,  1 Nov 2024 18:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58A11CEAD7;
	Fri,  1 Nov 2024 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QYVYcjZk"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013002.outbound.protection.outlook.com [52.101.67.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED9196D80;
	Fri,  1 Nov 2024 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485772; cv=fail; b=Ti/CMcwI9wWOIaZay67/ZnjAa0Qj/nhQ+dE4OVJihOCeGAvHgWbQOgNkCLSibKVi0YTnZJGVHlTQgQCVsqMgFmFoZj9ypj7Uv15Uwurp3qC/HeTcPtMamjrYcyLLfeEtTMvcHLB5uyLIBrdcsdo32lgUySEGQqOxb94PCAUu0rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485772; c=relaxed/simple;
	bh=fAiBAlr3y0fxB3yR7pbwLcFAQcVlP7uHkWuBSxNEzYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S6uUbRdzsBrq2dIJvuG4/b1+MxLZ8wPDSX8kl1aHVVrltPSLyUdQcAzBelzwV0kuJyoOyNXoxluRKLEwSY41jG8psYv2db9otDSiNY34gFjkDTCf0/QO2QzIthYHy0DT2LDLWFwyS+B2tSx7H4HDsfbVUdiVljdI4d0VxTGkJNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QYVYcjZk; arc=fail smtp.client-ip=52.101.67.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjjtK25O6p/PyBfwJ9SW8tQHRy5xg2z8gxeLg6z/8CsInKI/eIIcbC88gMnLv0O6FByYVngx6c5/sCc5CEgCLeH+frtB7dzACL9iGWeweTlZCPH6qBVypLzzc7Zi+IpGCLqN9+UyLmgP+9wZodwptDH+Ty7V086SrLnxevjabRL4/SZz4/YR+mEEtSGovqIZTWZP1CkoD2F4ENKy4kkKY8ZmMeLEo4b85gLG7nH48f5B3lsPwEOcwOoYOrkcvxzzXcv/OmdOgthv/Jj/g7g41Sgb1HsVHz/rv+Ei4jHyn2mUDpj+tsav2XqP1E6k89DUuNCmNSJRQeJqxcpDpEiWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cA2gvNALlbNTXbczxqL7FMYz+TeqH3Xc25P5+9oGQE=;
 b=F+Ikgh5M2dr+/DSJiQZWAjNTtQIn2yYYoJxrEk4j8nvBPL3xngAGsSgE6bfPmRzqd5KXm4XJ+ViTD9suXc2Fk6rDX5piOOEb99iP1UKO16PPWFTUC8X2IdL5/RWEMrDp2XHNckfVRyCOA09xzQbBp+3HtWw4Lj5luX0R12EpWZB18aRUu3QAkCluGwY9aE0ibybghPyrBYZPKNkbb+6pHEB5k8DsDpdcCylHAsInLqkNIEibgJesDPZh/pqd3YapsbrOSVtR08zwu6zbCxE5jWlSWjUMMp+6TCB8HXO0ueRvNvfuIi/iqnPfjbirKKtFu/pwY+zSh1JNNNYUFNI0zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cA2gvNALlbNTXbczxqL7FMYz+TeqH3Xc25P5+9oGQE=;
 b=QYVYcjZkPO6Vl9l4/09OMT7LBgRNMhdXuaImzpPCVvAGY0BcguK70pJNC5LeOvTZFdcv+qSce/MKVY0vgWxaow0HrNaQLFAdLjsfwU7qfRt69OIppv+howaxFvJ9qw2aliC1if12tF4D1faI+02FMKb/Wi3CwICBlBBYmfW9Os4t3e8GZWdHEXQlH/pw+h7KpGg3g2bqpljiPLqtBkhKKWNBzWOD6dfZ+58AA9XIPXhSLwqtdGZLn5vnyJid+mKEx59zwwRkMl7/JdeN8BgNQoC6SVTtO5Ulo6+QI7ononl4r5DxJ1ryq5/VxqifMd34wwRwjTOXlPpGQscyFFdurA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 18:29:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 18:29:28 +0000
Date: Fri, 1 Nov 2024 14:29:21 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	"open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
	"open list:FREESCALE eDMA DRIVER" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] dmaengine: fsl-edma: free irq correctly in remove
 pathy
Message-ID: <ZyUeAc6rNbGDLKfO@lizhi-Precision-Tower-5810>
References: <20241101101410.1449891-1-peng.fan@oss.nxp.com>
 <20241101101410.1449891-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101101410.1449891-2-peng.fan@oss.nxp.com>
X-ClientProxiedBy: SJ0PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:a03:331::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d5b381-21da-4315-9b8e-08dcfaa31e9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mcGkJZJEV9XD8Rjs9thJH/kLtZrcZer0nC7jK5mm2UFmFxO1ybfK+nAF5okR?=
 =?us-ascii?Q?ZqWEoRBaJewHgW2vLeZ5lL7qQZT2x04cSwIBfcbyjXwLZQfXhzcpPsd3fPZP?=
 =?us-ascii?Q?v3A7nR0TzoVX8iVIvukwwiHhgLl0GhU6RfBJ7rAzL62BypXZD9kzqS/HPtH0?=
 =?us-ascii?Q?EGSagsWyTsqjnO+wGU9X4rslEUnbTWfF0cHm9xugw6B+KSAviiYpj7mM0lAd?=
 =?us-ascii?Q?l11UNIIy/wTHdQLF5qaM2SlhNyGAGrlrDbZiW5TvYIIwWbgj/vv7dJT+dNRw?=
 =?us-ascii?Q?uBVqNchWUMD5k0X62Ep4Mt76vOouvj41ZsW835Q5ARABs5R0lz8Isz5/RMF7?=
 =?us-ascii?Q?S3EHmrqOwBzy5YO2MAOvckKfqAbODX5/4MP1aV+j8Vr1Gs5IsjtqbPbSemqd?=
 =?us-ascii?Q?GrNdea6MOfc4g9hnoDghYMSYBRadt/dNbZJehXid0qgM5kV5brRefurUIHEu?=
 =?us-ascii?Q?hfYmrfahp83iNMvZrTo4laEI0X25B1lBkA5iU2G5GbGLDxdEfmQe+0CU/CnZ?=
 =?us-ascii?Q?037eIe0EWYs1aQnfipozCRBUO6WhzTv0wQrBrrac8MLdEsRGm4KLwjfyJKLO?=
 =?us-ascii?Q?1hOQxd2cbvhzGxAwrAMi3nw/dywLT5IxJbKAODEiduhSCt/AcJqnELbjdtQi?=
 =?us-ascii?Q?lYUxP7QlpTi9UkwHckImFvHY5I0+5vz5O65uRY5pDSB4aSsC8fzOgoif5QEa?=
 =?us-ascii?Q?1VZmkszD77RQzCFnBrL/VJbUEzjXP927JdcFlqdu66Sl/slK3NFp7sznG0kp?=
 =?us-ascii?Q?vOiPA+DxcjSUqrcKKCALee+PkYwlCgMVbxxKNeuC5OzNhqqTGZ+hsnSE3oxl?=
 =?us-ascii?Q?HGqNx7Y991b44Mx4TLKPA5xOfRf6/v77gOVgNrjFAe4UiuPJujAo/t0WzHrF?=
 =?us-ascii?Q?kN6PtZfGuSW097A3j71LxkfVLIePIvwfBIiMLZwIgxVU+ii7WhqihWdOxfUx?=
 =?us-ascii?Q?mGipCnNf+vWBK5Swk/Q2fPlc2VaSZxaAEstSeQfZ4oqKTIT5+wr/X874+17J?=
 =?us-ascii?Q?bklDk2DJ0LyH/cC8QP1fEMPFKoRn1LbJdFMwXuLkZ5KnEo4FQJfU58JcOrWN?=
 =?us-ascii?Q?7yj04gUSduSIccPGNradxJJVthM3RB+CLe1fQN0vfHK6DLLXsQgv/Rf7VrmV?=
 =?us-ascii?Q?XvGy0X1Q1mqZnYcjZVTYznfY1DGQb09eBFdon7shUWYOUTl2xou+xXANnoQ9?=
 =?us-ascii?Q?6Faiv5LXR75E9pmKcdHPhWeqLpZeY5s4j8pClblOcJphByq3D/SgECS1fH6Y?=
 =?us-ascii?Q?p8iOHAjvGNZcZGOCkDObuR8hBQDRf1UZYLShovARDSdvrR7dnITfJJLknY/c?=
 =?us-ascii?Q?N5K0HSvDvEbRO7JRMH9tOtZVTlW+KSyx/Pj5ZMHlxLOBaMf5SxfTE4t1xa/S?=
 =?us-ascii?Q?CptBAXk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2YKwmrGExhqMipGPLthvlN3vnpqifub3lxymcB5/KOLUrGiUVPdsHwHf4Mwf?=
 =?us-ascii?Q?4QtACjlRfRGVX6DacUJVCR0VkslOPkP0j7JDmTbGvu7jzpBQf8UjUxujKnoy?=
 =?us-ascii?Q?UXnXqtI0L7+4lj+7o9doUJdRmzNFB2yuyTVf8UO8X7T5dlcicUhiaZz1JCDn?=
 =?us-ascii?Q?Zt8EPWPG/g2wY9TNPomRXw9gxaDFXxjiwPao1IqDkiKYKZN+5V5TAk68n6VL?=
 =?us-ascii?Q?in6x/0KbM4pVaIebaHc9qtwPYD499mCthsScPSAgZr3DMy+yox/8C6Gi6Wbt?=
 =?us-ascii?Q?XZeD2jrHixk80uKPo0fifaaSM/19QUSdiWBP9fOGcgBaFnKPKCkgjn5LAOSz?=
 =?us-ascii?Q?T642+XDldgQ4RcJTITJ2jZaFlq4WLhAE2jlVyBek/VRIgeqofUEFJcI/069d?=
 =?us-ascii?Q?7Msfhfsj9lI86gMTYgS6j2a5+MEs7TQ6agxA/3D1yDD2xcxcPmY/HI/0Ogxg?=
 =?us-ascii?Q?m5dLDgh/wv8EuZ5ZP8AVO/vsg5+PVLcMzlzyqN2ZI0Gb3eB5jMNIVXPAoMv1?=
 =?us-ascii?Q?CpFnhHaBDyBzd3mu4ydHayZMybgodb8tQ1N5spNbqelxO5EYA7DZ9wxT2I35?=
 =?us-ascii?Q?zdVInuYgZrwOoKFp3MUKaRahc6Mz1eySWQAIFwQq7e4vdvAk0vtpPnhBPuL5?=
 =?us-ascii?Q?lpZC218HnO8xdUNGDyV0G3NB6+fxd37azT4YohTNjKcn7bqRt7fj4zjVoPke?=
 =?us-ascii?Q?9DmQyrrpdEfpiRGFrL9FAHpmhpOqhFKf9fxwVIou3NAOCHGicfGP/wdMDEwt?=
 =?us-ascii?Q?2zTW0BtpSYLVxseXAJmxyX7zHfcrvJ4XumzNs+wmKlXZ9k2wh7Y+Erylzw44?=
 =?us-ascii?Q?bBeAKM7qlIbRD+esrHeKhA4eC3jGLVX1tn/AU2chsa8iWYwawDEwr56WKf0Q?=
 =?us-ascii?Q?g8kHSbE6t1PC8Fyv73+1ZSsdMljlcRZ2DgytqHjBsx+oy+xG8/vR+P2CGArp?=
 =?us-ascii?Q?xxsNCYAJA4rBdnMMJYrRiGqmBlwPdV0XNhjlJ/c+mIkIw5Ln7yQz4PDJwJOX?=
 =?us-ascii?Q?oJcdOwEPZQngGi82iNRqfL8izsgd8ugZ8WVf64qGqo4sINenkPX+KLUql6JH?=
 =?us-ascii?Q?HuWc/5yZ/lEAXmBA1IfEnM4xo1lS3MEljG0iTMJ63n+p3o9DKQkwBX9yjsGJ?=
 =?us-ascii?Q?YN/ofOJR7UnH1mlX2fJhK2ilYpsosDCffOqdtOy3yH3SK/RQyMW2zfmzz7S8?=
 =?us-ascii?Q?s66Y74nnXC95Q/RfKiE3c8xUHdk4zOrGL6OWYPcE32m64jR6X5gm9uanB8DU?=
 =?us-ascii?Q?mStdL9ldw1eLMr9H+qwhB2VOP8+V2f3Oah03iettgpN2VJzc0d+de1CwC4g9?=
 =?us-ascii?Q?m8xH6RlrbDc6fQV9RUw+9cvnUzHWgepeWIAJlmubg19xvhtxmUEHYYlh8ZxU?=
 =?us-ascii?Q?/4OgVYnZIuQzP5zQmiI5mFT1bns+BrjN2CbwU8E2UJySj3+xja4i32cunMVN?=
 =?us-ascii?Q?SZbEwTFVMKaG4tN5yVWweAjZcNbG62TY+RpMOjcr/+H1PtNyyhK3Aw7E+4nL?=
 =?us-ascii?Q?0qo4HfH7IvURqnO3lterWozzO/RZGcAnafFVBBQ1zWyiITI572nvkO7mO0uj?=
 =?us-ascii?Q?u47rMfpnYcfKdph5wAhR58l84lgI42fDYfsgLvbx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d5b381-21da-4315-9b8e-08dcfaa31e9c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 18:29:28.2284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwx9ITdNUDlSKxzfHJZphIb3bVqfXDZh9Hv3RzLeoUrDcSq/YTpfwFeOL03AddFSBpMptLgj8Gf9HMfnl2gi9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6821

On Fri, Nov 01, 2024 at 06:14:10PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> To i.MX9, there is no valid fsl_edma->txirq/errirq, so add a check in
> fsl_edma_irq_exit to avoid issues.
>
> Fixes: 44eb827264de ("dmaengine: fsl-edma: request per-channel IRQ only when channel is allocated")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/dma/fsl-edma-main.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 01bd5cb24a49..89c54eeb4925 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -303,6 +303,7 @@ fsl_edma2_irq_init(struct platform_device *pdev,
>
>  		/* The last IRQ is for eDMA err */
>  		if (i == count - 1) {
> +			fsl_edma->errirq = irq;
>  			ret = devm_request_irq(&pdev->dev, irq,
>  						fsl_edma_err_handler,
>  						0, "eDMA2-ERR", fsl_edma);
> @@ -322,10 +323,13 @@ static void fsl_edma_irq_exit(
>  		struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
>  {
>  	if (fsl_edma->txirq == fsl_edma->errirq) {
> -		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
> +		if (fsl_edma->txirq >= 0)
> +			devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
>  	} else {
> -		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
> -		devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
> +		if (fsl_edma->txirq >= 0)
> +			devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
> +		if (fsl_edma->errirq >= 0)
> +			devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
>  	}
>  }
>
> @@ -485,6 +489,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  	if (!fsl_edma)
>  		return -ENOMEM;
>
> +	fsl_edma->errirq = -EINVAL;
> +	fsl_edma->txirq = -EINVAL;

why not use 0 as invalidate?

Frank

>  	fsl_edma->drvdata = drvdata;
>  	fsl_edma->n_chans = chans;
>  	mutex_init(&fsl_edma->fsl_edma_mutex);
> --
> 2.37.1
>

