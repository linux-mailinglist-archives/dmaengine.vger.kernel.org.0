Return-Path: <dmaengine+bounces-7250-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2187DC709E4
	for <lists+dmaengine@lfdr.de>; Wed, 19 Nov 2025 19:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id DF63D28A95
	for <lists+dmaengine@lfdr.de>; Wed, 19 Nov 2025 18:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBF0302166;
	Wed, 19 Nov 2025 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ksuwlWFe"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013053.outbound.protection.outlook.com [52.101.72.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C22130F7EB;
	Wed, 19 Nov 2025 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763576384; cv=fail; b=cfMxVJon06dmFoExaP//G5mYFyK2H0FOgyJJotRBU9OenQOXlgXf4FE7hCTpo/KUE2T9AXm9zVsSdeuAY4mHo6FB1Sjw0RmUhVImuIxjNp6RL1yEjur8lHeHucguvU6sU/F2f8B2jXrJXM9V+aAfriGrRrdF/VhTUHzMCtNEbgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763576384; c=relaxed/simple;
	bh=sT4+Nk1x7w5jtFaBl5rurL8G5HVDSq5as6wRG57LbhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S3x94gxtxIIuO0L/y78JlYeLl8TftSjKfDYlfjyMeMsW2jnhg03SyI1BNvWvD3OZ6o1SNSHH9UHXLHaJwfEZIuNnr0HmCfIJzdNF2OEj6a4EXdDOLlmDos0E7N/sCrpqr6M6SqKegpJNAli0T4+vTrcXFe15iyM/sTfEau6Q9jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ksuwlWFe; arc=fail smtp.client-ip=52.101.72.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBQiOy1/pQ90b347WkBT/XCuBdNE4TEN900A6QuOdkYrUNVvmSTKC1fMmjUiocQohq3WHfNIz3imckuZF3kFecwMcQ5spagqM4+8gvHw69/gWyIikFpUrts7wuDqt8+VjoJTeWWaAih7DA60HGrGExKvvqwDoO6WYqMWAvTzwPhTKZcmsQPCxLUwZiH0Xhm1yqykQ1igKPgUzkZo+GgJNZl+z4VTQ1SxBu+f4V0/AYvtcETncRsCyj0ziXypiItBcAIRcsV3X1XW5DCh5iBQzaznk8/OkBQ3UCq/UoXoomtrzaVgpgs6awrK3MfuGLGdFjhooaO9hqr6Rm4/tdTzOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+9zyJVIqeuY4IJPRUvU5Hv0NahnfjU5nmBYOF4mwXc=;
 b=jBWNvVT0U6fIisIVfBpXCAa09m7QeHCRod9EOVmQpAt87rIunvVYSvgeIuXviJWsK4t57+vrYhkV4s7CwKKfQfcpAC8yKzdIvkF/xa89X6dNbQgMPUi+u04WTGg8uY/g2sBFwgu8eBhVeRRM6imBEGpZRKzdqrA6iaWWchsyz8EEsktUXWrb4bLoHlnFmfPNSuSe14H3mrqzjCSsir8mk3bD9ywIBiDUrMveu9v0PLo7H2Bvbl/oUGOvQohaDnEEkI1Af6W5igY/CrHTQaVxCXjl9c7RjOb+IV2wy8FK8U6ndPl81LcYwUtHBMKpp0NkB4d7Dt4kl6Xxwq3HcKSWIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+9zyJVIqeuY4IJPRUvU5Hv0NahnfjU5nmBYOF4mwXc=;
 b=ksuwlWFenJiLrvKf/Y5g7oWy2uXcqvH4G+nCY57+8WoP7e6ti25ZIdcXzXRncjrs43kfXdGysI3AIl9CMOHcVpwVYgOudmBhSoNGLT3nn3wR8fh8/oAF5M39t7NEdjiDq5uzVehsreA0QJe8fYxmZbRnFf3tTERavO8mP+f4lijsYVIuvbke/d5jJpT927cDy4nEvKglXHu4Mze0tPagTlu9MePHTvfcInjWf8EwJ+S2fozs9TIwGOD6JKZr7MFS+HwpBM2M7FMOPxJz1lvb829omLKVOldOug6W3sFyPXldqIKwKvUat3FH9OG3ote4m6E2GjXj3xEcbZyUi/7Myg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS1PR04MB9560.eurprd04.prod.outlook.com (2603:10a6:20b:470::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.23; Wed, 19 Nov
 2025 18:19:29 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 18:19:28 +0000
Date: Wed, 19 Nov 2025 13:19:21 -0500
From: Frank Li <Frank.li@nxp.com>
To: Han Xu <han.xu@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-edma: configure tcd attr with separate
 src and dst settings
Message-ID: <aR4KKajzkP4hUx+0@lizhi-Precision-Tower-5810>
References: <20251119163255.502070-1-han.xu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119163255.502070-1-han.xu@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::20) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS1PR04MB9560:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e5519f-e805-4b45-22e5-08de27982d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lCo2YpoUQIDaJFzwCix/5exR2bYTyuouDJbQP90tTPilhyS8whj76G/LPHys?=
 =?us-ascii?Q?+oysXoj1B4FZjxlTYYj7VdMCvxxWBHuStDFFqVJHxxnzgnwYc9qMG5fjKEb3?=
 =?us-ascii?Q?yRKqsJtjyqD0QfPh8nvyByZEpBQ9cIIF6H6qkYpg/wW4kuhdNNxOKG2yOi60?=
 =?us-ascii?Q?HexOVgNiWfLioY5eCJxDoDvKfFYvPOGesx/uW7xNOm4R+LXVh5t1EYHqf5Fn?=
 =?us-ascii?Q?DZyzR5xtMghurFtw6gzS8dNR3o/lYVbNx1SVzJjjM9v9IZCCrBxEnxUjMBwO?=
 =?us-ascii?Q?HeRjlUCmF9CtbBTLNEyiYK8/l+zfcAeOmRSwQhWpJ5qKh14lJwD/XhhRNjNk?=
 =?us-ascii?Q?IM9bLLuu3sFw+lQNnFlBkkb8Xskl8QbHcAFdzuF7OopUFi1oIBRbzvBXFjKQ?=
 =?us-ascii?Q?I+EdmDFwDzKjZGVR8ayeWY0ZBJn1I7vyI3XE2bIKrl/psBWBZFtqyFDK0lwg?=
 =?us-ascii?Q?azaK/x8Ngp3tJ/7flYkqEaThE43MfUwkMsSEnJYFYwUO9MZ4UBAWtCsQ0Xso?=
 =?us-ascii?Q?jLLmgh+DwRc+j0QcPJjObIo9Oh+ezpblpijrdtMLGj1/xSEleprjcI8N2dYc?=
 =?us-ascii?Q?ck/ldZHej350Aou5Ui79Eu9XYowIZl4x/3R2c/NHYv955UXfHibKE6oLLlUU?=
 =?us-ascii?Q?PrhEQUB4ZOuu4gsOmXvFZMQYgCacxi/taz2MzsVoGX+Mc+PXr19mX0menrsi?=
 =?us-ascii?Q?oGBjyh5OobJE56R1zLMRthjPn/r016eRjAoQGl8/kjw4DKKU72IGfSbUcuSy?=
 =?us-ascii?Q?5qxJnZDkhb4bSbxPVnKUPMowP7MRgC4JHEXRLnvfDbVsHJanU5fxyo31RX3P?=
 =?us-ascii?Q?QFKxwdeplIV15QtAJ2maO8Gxg2+653/kAjx9jf+cMMaJ5zct83IZlwBU7ctE?=
 =?us-ascii?Q?fb+L/u/pX0+R1Vbd1GY40dm2B7hlKTFuHUWarA3d27lclJYUXcSWkvzXDDJL?=
 =?us-ascii?Q?F1U/5ZknTbXfHRuKPLrord5UYoUgyvVKS/4ekjUf6IqZtlvfv89d3/Ztc0n0?=
 =?us-ascii?Q?1EGhYqd5QU+jsXci/S+n5o5U0/Oiupdgkcve2pgeG9VA4SSXYL2wo/wQRIsG?=
 =?us-ascii?Q?CBIKpb4J8F5fefLemE0RfMn9oubFJrMW+8nztmq3r8rYWaQqOYqnFWLwgNSw?=
 =?us-ascii?Q?fzAbKxhIUPsOieiIjQGfV13JW+OU8HJsKK3TryHd8NMYe/qLVFDalN2lRiNc?=
 =?us-ascii?Q?JD9t0nXYmqpydccsj6Arywrn2Z3WtN+hJiOz7YiRJQz+CIqWoJnd5V7WjlIN?=
 =?us-ascii?Q?IqYL9Z814iEmj8I8oNFqQZshpG3B+3BciHZaD+KnFmvXwiAEfrKX7JkX9A8h?=
 =?us-ascii?Q?LqIVJbQ0DtOgEAz3o0bkf9k7fRFm5Dq+AfH9PS8jfbsVKRENSGREX7+KvWT0?=
 =?us-ascii?Q?ZI32jIugRRvZUkfm2aHgQp0Dp7Nwv0Sf/Xjl+HSpK1dFpC0x51Y5pDwygbJj?=
 =?us-ascii?Q?/ZHT/jU90rlkhjLLp+4ReR5SaEL8/+DJOP1YpK0o1dtfyTBW3B2Y+wVeE4gJ?=
 =?us-ascii?Q?QpVjPfCY9KOejLXtrCfYq684hrudYPMWk/8i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ajOXm2EBudaftybYykZudlpkDWmibo/hgsnYhG1FXeZ2mC/teiI2j8NFspB1?=
 =?us-ascii?Q?VRhDXdbyGQcrxTcE4B5Bx/srvchirPrDa/ZYe0Ej+F6SAI1NSPg1XbiWazLs?=
 =?us-ascii?Q?j5i2hNvQdNbE32Kvo3jR4hpNyonFiXv4fX4+5+WVnXsalzTymm1I+uuExY6F?=
 =?us-ascii?Q?i6rzjb6TI9ft6t41tjK41wvcXT13Re4RrsDntdywvQFBYgrI7vyNaplk3dYb?=
 =?us-ascii?Q?PQES7RDJzxpUpm4/U/ssNzykP7sHM5zkIUQqlsZH7Jv/ujib3N0HbxirbaX9?=
 =?us-ascii?Q?W7BBjiIT5ZCJ9bMV1KgI97fMXcgDr9Fbz76skQOAhAQDfvci958ML+3ZF79A?=
 =?us-ascii?Q?xYL/ic86jfJ22P7aRuCag419lo1qAVomoajT4AyTjYeAJtjG7sI6oKI7L0DD?=
 =?us-ascii?Q?+6rPQzaQfIXWaD+zhobP8KrAAKsS1hlSL2jH2LbCWP9RetL4MihRk3hlnqLU?=
 =?us-ascii?Q?7Fo9yo2RCBt3ndeaYd8IDIJjrL0MP8J5jF8e3KqwgrLiQ2BhJklgXc5SIW+4?=
 =?us-ascii?Q?KcR8ISVujU4K7ixRVkvAJOm4lc2BJXKXnZm0qjILwYQeRlJvjMt24/GXfcDl?=
 =?us-ascii?Q?48jwExHFUISuUrp7sQ73P81vhCSN+Ef2YW1gxofRcZJxWA1qAp/rFOAYaLr1?=
 =?us-ascii?Q?Ywchour58/WQQxJfu17MUcOouDhIKMdDN69Pnz6s1LlCkr+bAbnBZpN8VH1u?=
 =?us-ascii?Q?kxeysNJkrZtUKZg9JqGrHZYYS+uWyxXZQMb3RryPKNPZijBz1E/oQCwHInu7?=
 =?us-ascii?Q?Ws+y1EcJHvpzdqiToER01eYOJNoqLYEvHcO/9Hs9qf1I8RLliH+6GjsxKhh3?=
 =?us-ascii?Q?hrReCIcy3Uw1/qup8aHJZcrn/+O7RQmgx1dftt3878mEJKNDOy970js4fsie?=
 =?us-ascii?Q?x7v1m+QPo5ufIxyOiA6hSMIoaDD6szOpwDWXUTBl2E/TOh+Q+yVT3ba9DwSw?=
 =?us-ascii?Q?QXOakegbKztz0xkOtXQw6UGBPJiq00GAJTj4Sfz4eekCLyRB/H81olVMC6AS?=
 =?us-ascii?Q?pXrA0zBJiCwgBx56lxCBsJfwBHZ/+Yqvhupw6rtQykc2DmdnL8qEPIGvNxo/?=
 =?us-ascii?Q?Rkiq1WAzTFDPbe6tqZrGB5ITGjytO5A+HjYMHfRLRmdUNmAdx/Es8Wug4fpB?=
 =?us-ascii?Q?dgs/CJrzBmtJ3pJIvXmIvIhQVK/IZ1R3EdD3/6ZggPv3WHS+ig6TdFrCVFWW?=
 =?us-ascii?Q?uzSG2C4oV2zsxPUjf52KdyD6xLod7MjbP/D5gE1P4x4jnd/mpieCWxWjvx44?=
 =?us-ascii?Q?vdnJPk39/8+Umlrmr7CNHQOH8GWAYF1Q+SSCIwovzS002jEBEIIqzD2NGwK0?=
 =?us-ascii?Q?iDLX790yyYa+LaPr18O/zFNFN6KEkMDZsOuaMA7qRBFPq5ClofY/Arj/JkEP?=
 =?us-ascii?Q?NaYBUMqKL7EHenFMRIU+5yDqXpuozmk3UFBbO6c+cME1+HiFaJDq1zu3kSz1?=
 =?us-ascii?Q?H0IonofFegAdzZbKMK1hUEiayO52NxDxFk16I0fQSUaU/JBymJfkGxxqSaeH?=
 =?us-ascii?Q?1fujID34ZtItdw3nhSetrDMGIFN27EQbdK8NpktGaBjPFyiydu7YZKay1XIM?=
 =?us-ascii?Q?7bB6Uo74D3c0FGZa60s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e5519f-e805-4b45-22e5-08de27982d9a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 18:19:28.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bG0fB2Wf0DBHo9DzX2/PYfyMQgxMkz4y6ru9gnGpOX+ahPXoM4w+78iGiFLJeyesbt4Nj8pfokOtTXpYlialKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9560

On Wed, Nov 19, 2025 at 10:32:55AM -0600, Han Xu wrote:
> Set the edma tcd transfer attribution settings for the src and dst based
> on their respective dma_addr values, to remove the previous 32-byte
> alignment limitation in the EDMA memcpy function.
>
> Fixes: e067485394328 ("dmaengine: fsl-edma: support edma memcpy")
>
> Signed-off-by: Han Xu <han.xu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-edma-common.c | 45 +++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index 4976d7dde0809..a592127580299 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -206,15 +206,19 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
>  		mux_configure8(fsl_chan, muxaddr, ch_off, slot, enable);
>  }
>
> -static unsigned int fsl_edma_get_tcd_attr(enum dma_slave_buswidth addr_width)
> +static unsigned int fsl_edma_get_tcd_attr(enum dma_slave_buswidth src_addr_width,
> +					  enum dma_slave_buswidth dst_addr_width)
>  {
> -	u32 val;
> +	u32 src_val, dst_val;
>
> -	if (addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
> -		addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	if (src_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
> +		src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	if (dst_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
> +		dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>
> -	val = ffs(addr_width) - 1;
> -	return val | (val << 8);
> +	src_val = ffs(src_addr_width) - 1;
> +	dst_val = ffs(dst_addr_width) - 1;
> +	return dst_val | (src_val << 8);
>  }
>
>  void fsl_edma_free_desc(struct virt_dma_desc *vdesc)
> @@ -612,13 +616,19 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
>
>  	dma_buf_next = dma_addr;
>  	if (direction == DMA_MEM_TO_DEV) {
> +		if (!fsl_chan->cfg.src_addr_width)
> +			fsl_chan->cfg.src_addr_width = fsl_chan->cfg.dst_addr_width;
>  		fsl_chan->attr =
> -			fsl_edma_get_tcd_attr(fsl_chan->cfg.dst_addr_width);
> +			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
> +					      fsl_chan->cfg.dst_addr_width);
>  		nbytes = fsl_chan->cfg.dst_addr_width *
>  			fsl_chan->cfg.dst_maxburst;
>  	} else {
> +		if (!fsl_chan->cfg.dst_addr_width)
> +			fsl_chan->cfg.dst_addr_width = fsl_chan->cfg.src_addr_width;
>  		fsl_chan->attr =
> -			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width);
> +			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
> +					      fsl_chan->cfg.dst_addr_width);
>  		nbytes = fsl_chan->cfg.src_addr_width *
>  			fsl_chan->cfg.src_maxburst;
>  	}
> @@ -689,13 +699,19 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
>  	fsl_desc->dirn = direction;
>
>  	if (direction == DMA_MEM_TO_DEV) {
> +		if (!fsl_chan->cfg.src_addr_width)
> +			fsl_chan->cfg.src_addr_width = fsl_chan->cfg.dst_addr_width;
>  		fsl_chan->attr =
> -			fsl_edma_get_tcd_attr(fsl_chan->cfg.dst_addr_width);
> +			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
> +					      fsl_chan->cfg.dst_addr_width);
>  		nbytes = fsl_chan->cfg.dst_addr_width *
>  			fsl_chan->cfg.dst_maxburst;
>  	} else {
> +		if (!fsl_chan->cfg.dst_addr_width)
> +			fsl_chan->cfg.dst_addr_width = fsl_chan->cfg.src_addr_width;
>  		fsl_chan->attr =
> -			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width);
> +			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
> +					      fsl_chan->cfg.dst_addr_width);
>  		nbytes = fsl_chan->cfg.src_addr_width *
>  			fsl_chan->cfg.src_maxburst;
>  	}
> @@ -766,6 +782,10 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
>  {
>  	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
>  	struct fsl_edma_desc *fsl_desc;
> +	u32 src_bus_width, dst_bus_width;
> +
> +	src_bus_width = min_t(u32, DMA_SLAVE_BUSWIDTH_32_BYTES, 1 << (ffs(dma_src) - 1));
> +	dst_bus_width = min_t(u32, DMA_SLAVE_BUSWIDTH_32_BYTES, 1 << (ffs(dma_dst) - 1));
>
>  	fsl_desc = fsl_edma_alloc_desc(fsl_chan, 1);
>  	if (!fsl_desc)
> @@ -778,8 +798,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
>
>  	/* To match with copy_align and max_seg_size so 1 tcd is enough */
>  	fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[0].vtcd, dma_src, dma_dst,
> -			fsl_edma_get_tcd_attr(DMA_SLAVE_BUSWIDTH_32_BYTES),
> -			32, len, 0, 1, 1, 32, 0, true, true, false);
> +			fsl_edma_get_tcd_attr(src_bus_width, dst_bus_width),
> +			src_bus_width, len, 0, 1, 1, dst_bus_width, 0, true,
> +			true, false);
>
>  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
>  }
> --
> 2.34.1
>

