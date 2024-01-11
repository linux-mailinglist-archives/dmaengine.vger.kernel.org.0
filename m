Return-Path: <dmaengine+bounces-718-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E566682A522
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jan 2024 01:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E0E284C26
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jan 2024 00:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD9815AC3;
	Thu, 11 Jan 2024 00:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tpzpmn73"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2049.outbound.protection.outlook.com [40.107.6.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ADB15AC0;
	Thu, 11 Jan 2024 00:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O11osMPGzuPB2xyFvn05tXLw7PN3WbDSMSnU/RRC+CW2L9hRNMFmmnsSVv9nxDXEAo768wl++9/4S5odNksIAe5IZ/Z/RBY48lOOVmSn5oIwmA5vJQnHjXEhpLbA2QG83jBL8lSPHzTj/rqsyzAfJ/WHDK+JSuTUrKE4OnlNXPjX++CplmZwKdEK/UZP1luXGpXy+5nsYSRLBQQq6vGW9n2XV/JTzz/S1Uh01vw1y/BZlaYxJR7hTNFWWk0Um//PLBu4/Ks2+YSHGFguIcqNKTgrIRtVT9YEImaytKGY94gFyIiLrz4wReI7XKIusYLMVnAvFzJzH5/mzR05Rj7lQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UndHGHMJJKk+cQrVKywzlHwQSUqQ98+wb9WLEAB+GvM=;
 b=B/eo3SwqFddmRK/tcYdSHAYredpqnjUhGKVD1LBGED7OYCC/k16478dToeX0DNXIJqlKJK2sFRN8LzM3WHO/OlFmpcThOokOsoy3+8hapa6XWeNJjmsomss54cuuaHlV8WAPIK1HGIfGMLOyoh2IE8lMTBwevoSOBbfTV4blu1xqhN6HGlb7fhAsHuk1FUYEp1L6/DXNTVge+Qnhjw+a+sJxBYSpY98hZQGIdVsSLSje6qGUCM9P3ldV3O4GzzsNJWcUqFGAqd6hXvBgKDB5cJs1qn8aDj9Fqcp1saFLPx7YW8CAXVZN4h6KXucW0+5Q8eMj1Jto+O+9tVfbHplSOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UndHGHMJJKk+cQrVKywzlHwQSUqQ98+wb9WLEAB+GvM=;
 b=Tpzpmn73vX/t9OnoB/XbdQDrvoX+mKTqCud+vpXI3mQz5s4U82Z8MKgi3m4v14D0NI/lSzwI62RFrj+s7Tpe50kQHCbxibeVtg2Uw7DwN+DKEinj+a9lgUt03SBRVDp3wnPa9dbSpmpWBnJuimQ7hfDqK7NHB0/Qq0OLv83uZjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by PAXPR04MB8895.eurprd04.prod.outlook.com (2603:10a6:102:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Thu, 11 Jan
 2024 00:03:04 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 00:03:04 +0000
Date: Wed, 10 Jan 2024 19:02:57 -0500
From: Frank Li <Frank.li@nxp.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@denx.de>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH] dmaengine: fsl-edma: fix Makefile logic
Message-ID: <ZZ8wMWQMo4eGnSuG@lizhi-Precision-Tower-5810>
References: <20240110232255.1099757-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110232255.1099757-1-arnd@kernel.org>
X-ClientProxiedBy: BYAPR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::44) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|PAXPR04MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: ecbdd8cb-b65c-45ad-53f4-08dc1238aed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tby7Nr1IIPE43++pkzxVNAWy++00v4JsZC2MD5ibSGflY/7kFTx6LSOr0wrGLtuqVxPvW+r7yir7KAJg2iv+XaxKzi2LQIwUhFu9Jp9NaSJzSvETWbHR2TJ4h7b8AD48d4K4wUD3G2DBoXI8Cw9ljC2Baysz1AkJz8DeZHSVdp0wzgdrilQ3lYe7rYr4GlNW3jQiVf3N+Yx2L0usu2v40JTbvciM7SNznOGktI6Qt9DdZ3v6F1hXCy0Z0T+kzw/FB8dTenD8/8UijKn3J3Nl4klq8ILVp9LIvATFKw5afVHDRA0vmTlsblrliOtyfIo6jRF93go0ahNJpyjMtOzx9Ep1p5WsoPqO08zxroBydeW74CByiaJdEyDFb4XCh6+lcR+gKtRoP+IOuYRZSZRBbaDd9L5Pc6gIfVJ31favX4Or2AU/UFdu8/4Mc0+D/W4cX3jcvYx3jlAru5i3BkyMjxrmG0VE5doWJ8ZbYhakzl2XODBeYtM3krs6MW/rJQCDU/022h9xo5PlxMytotgqZufPoDg4GyOtBf7YyL8LNxuOdlus8aX/KIAczqHT+BtNPf6m/en/o9ItEsz3wZPqFKtds7ujLrv8JsC/GTHlDZAAoltQiHGAWfq1Pmqyaf0z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66476007)(66946007)(66556008)(316002)(8676002)(8936002)(26005)(66899024)(478600001)(83380400001)(2906002)(52116002)(4326008)(5660300002)(38350700005)(41300700001)(38100700002)(33716001)(86362001)(54906003)(6666004)(6506007)(6916009)(6512007)(9686003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r5QL8wNJEC54C2i6osmJW92fOLBYt5w7JPGl8+HrZFtE5Sp0XpuoMgZTKcIb?=
 =?us-ascii?Q?JZS7HdPG2MLcQ7jeZI1j36dEz5BLLh2N14lQuGDvIUL8DObFu6Z5o1qm3oAG?=
 =?us-ascii?Q?B+OZra0vo1UfmkwQ8GbCwWTR7lLNfF1uFGHPb0uOFblU4LTK8ZHkSf+tkE4G?=
 =?us-ascii?Q?yV5mmgQKcXbEfw67d6axVwZT6r84fHV9spHZoy+wAiOWPpc71CAY2FIU8w59?=
 =?us-ascii?Q?iHCD9JO4KMiwbIpoohV53UoBc1BrTRGcMYGTyYn3vET7Afd7q36qqbuFr0Ic?=
 =?us-ascii?Q?F5seOuQtYVYD/5bUMdMQxw7KR6itTE6B9xEJ/ZtP6N20jXJf+tG18jQLNlgo?=
 =?us-ascii?Q?LC520aAHspYvjvf2ouGwBYoIwi4plUHTozegxWlnyADKA78Gu9kCV0WgmtaU?=
 =?us-ascii?Q?YTqwoG9pCrS3Zbk/GBoQWDGkajhRsL4ksjd6L64jMEMP3Vru+isZoZ8Kllo1?=
 =?us-ascii?Q?FXuhLIKM0CJIG2utPoWeXe7kUIfy1rlm66zrzcapJWtLO91wCXjvYqtkOPzA?=
 =?us-ascii?Q?xFni1kjsomn7QsDZCi3c0yIamcE1EzNG/904PE2ZV7b3cQXflmhCnoKIH1V3?=
 =?us-ascii?Q?caRFjHFHBupWf/g0OgO4CVtFsb7g7i8L3jUS9tWdJOMvzHu4KaDrCDwWNAaa?=
 =?us-ascii?Q?9+IK+GG4/GEV6aZPa6EHWC/zDvI8TkmcJozD9wbe+gwvN4i/Jff4Mmb87YjX?=
 =?us-ascii?Q?j+L3IjOHoLHTEY1sM8Ao9LdOVOhXfE/K2/vZWC0Lnv6YCgH6xRGMBAVL1evu?=
 =?us-ascii?Q?gJ3X5u7yrbqz1XREO7d1FjUmnfobD0TPwN9zU1f6u5tfi93/xChhlKhlagyz?=
 =?us-ascii?Q?tHQPASPXu+K5lipuJvhwcqnzz8GOZXP/p/ZNHYw8yXvmdLzaXTMpZNNhtCJd?=
 =?us-ascii?Q?Nu7osGRbxYL8QDBvU5cLeZCXRH3yEBwNEcr++tkJAiyehTBkdJ0/vItvjele?=
 =?us-ascii?Q?ak/MmWkm3dUFa4iTP7n8L899hbFXbpHJ3jHceSQcjXPz/F7n90uJpVh6u0FM?=
 =?us-ascii?Q?/ZpbtFn4nUcZ1cAsNe/5IFbhSlE3JOeatnghwKXg7IQkNTq+RCEfe/Ms3tn1?=
 =?us-ascii?Q?kM3isHXmE4iPc75F++th+KFwtujk1KDWI4UCaO9whX/GLpCJzbBtgixfx3ne?=
 =?us-ascii?Q?BxDzvFsSo0bREMGHT+UXa0VUAvh03ku3OfG5xqM5GbbvPi6lZWODPeorp3bQ?=
 =?us-ascii?Q?BjWgzJzFdXUivwaeeWvjLwTZ3I33ufun+vWXvbfm8rjvzLf39RaaotRPlRV0?=
 =?us-ascii?Q?cGrezVuHyx411LLaP6hiyxwuIVMGFpfel9w47YRMpYlCbbMtqQgCEWMLcVKf?=
 =?us-ascii?Q?roB9xQzgrwcHjQWoShGTE5Nh6XLBdLF08En5Kfvo8xP095HFY8dOwBhQYtX6?=
 =?us-ascii?Q?ub5UxFS6fb524+efzWFaW5xyqnevs5EV4VcBZxBTQ1iE23HwU+UBl/6oAea3?=
 =?us-ascii?Q?FY77ob2/oncVAyynEv1k5DTLGlF2jZwbLEOL3WTN/LqP37DB57b+2rYhFWu4?=
 =?us-ascii?Q?zN6ibH9uIL4BuEEQTDIYrIgkOTKUN3T6/ZeGqwgEsZCvpVqvHN7AY5x4ASkV?=
 =?us-ascii?Q?Dj1tMhmQQZTegG/iaTM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbdd8cb-b65c-45ad-53f4-08dc1238aed8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 00:03:04.2408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBj8a0TP9Dm/wMw1BF5VXlPb6m2WkmzfMSAGHxomKx1H6vVxsMCa/7Xpm71B1/JZPIAgnEgDMBW73bB9CNTshg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8895

On Thu, Jan 11, 2024 at 12:03:42AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A change to remove some unnecessary exports ended up removing some
> necessary ones as well, and caused a build regression by trying to
> link a single source file into two separate modules:

You should fix Kconfig to provent fsl-edma and mcf-edma build at the same
time.

EXPORT_SYMBOL_GPL is not necesary at all.

mcf-edma is quit old. ideally, it should be merged into fsl-edma.

Frank Li
> 
> scripts/Makefile.build:243: drivers/dma/Makefile: fsl-edma-common.o is added to multiple modules: fsl-edma mcf-edma
> 
> While the two drivers cannot be used on the same CPU architecture,
> building both is still possible for compile testing.
> 
> Fixes: 66aac8ea0a6c ("dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/Makefile          |  8 ++++----
>  drivers/dma/fsl-edma-common.c | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index dfd40d14e408..302b7b0fbb8e 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -31,10 +31,10 @@ obj-$(CONFIG_DW_AXI_DMAC) += dw-axi-dmac/
>  obj-$(CONFIG_DW_DMAC_CORE) += dw/
>  obj-$(CONFIG_DW_EDMA) += dw-edma/
>  obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
> -obj-$(CONFIG_FSL_DMA) += fsldma.o
> -fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o
> -obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
> -mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o
> +obj-$(CONFIG_FSL_DMA) += fsldma.o fsl-edma-common.o
> +fsl-edma-objs := fsl-edma-main.o
> +obj-$(CONFIG_FSL_EDMA) += fsl-edma.o fsl-edma-common.o
> +mcf-edma-objs := mcf-edma-main.o
>  obj-$(CONFIG_MCF_EDMA) += mcf-edma.o
>  obj-$(CONFIG_FSL_QDMA) += fsl-qdma.o
>  obj-$(CONFIG_FSL_RAID) += fsl_raid.o
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index b53f46245c37..05b31985a93b 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -67,6 +67,7 @@ void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
>  
>  	spin_unlock(&fsl_chan->vchan.lock);
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_tx_chan_handler);
>  
>  static void fsl_edma3_enable_request(struct fsl_edma_chan *fsl_chan)
>  {
> @@ -159,6 +160,7 @@ void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan)
>  		iowrite8(EDMA_CEEI_CEEI(ch), regs->ceei);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_disable_request);
>  
>  static void mux_configure8(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
>  			   u32 off, u32 slot, bool enable)
> @@ -212,6 +214,7 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
>  	else
>  		mux_configure8(fsl_chan, muxaddr, ch_off, slot, enable);
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_chan_mux);
>  
>  static unsigned int fsl_edma_get_tcd_attr(enum dma_slave_buswidth addr_width)
>  {
> @@ -235,6 +238,7 @@ void fsl_edma_free_desc(struct virt_dma_desc *vdesc)
>  			      fsl_desc->tcd[i].ptcd);
>  	kfree(fsl_desc);
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_free_desc);
>  
>  int fsl_edma_terminate_all(struct dma_chan *chan)
>  {
> @@ -255,6 +259,7 @@ int fsl_edma_terminate_all(struct dma_chan *chan)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_terminate_all);
>  
>  int fsl_edma_pause(struct dma_chan *chan)
>  {
> @@ -270,6 +275,7 @@ int fsl_edma_pause(struct dma_chan *chan)
>  	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_pause);
>  
>  int fsl_edma_resume(struct dma_chan *chan)
>  {
> @@ -285,6 +291,7 @@ int fsl_edma_resume(struct dma_chan *chan)
>  	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_resume);
>  
>  static void fsl_edma_unprep_slave_dma(struct fsl_edma_chan *fsl_chan)
>  {
> @@ -345,6 +352,7 @@ int fsl_edma_slave_config(struct dma_chan *chan,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_slave_config);
>  
>  static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
>  		struct virt_dma_desc *vdesc, bool in_progress)
> @@ -425,6 +433,7 @@ enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
>  
>  	return fsl_chan->status;
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_tx_status);
>  
>  static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
>  				  struct fsl_edma_hw_tcd *tcd)
> @@ -644,6 +653,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
>  
>  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_prep_dma_cyclic);
>  
>  struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
>  		struct dma_chan *chan, struct scatterlist *sgl,
> @@ -740,6 +750,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
>  
>  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_prep_slave_sg);
>  
>  struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
>  						     dma_addr_t dma_dst, dma_addr_t dma_src,
> @@ -762,6 +773,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
>  
>  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_prep_memcpy);
>  
>  void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
>  {
> @@ -797,6 +809,7 @@ void fsl_edma_issue_pending(struct dma_chan *chan)
>  
>  	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_issue_pending);
>  
>  int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
>  {
> @@ -807,6 +820,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
>  				32, 0);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_alloc_chan_resources);
>  
>  void fsl_edma_free_chan_resources(struct dma_chan *chan)
>  {
> @@ -830,6 +844,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
>  	fsl_chan->is_sw = false;
>  	fsl_chan->srcid = 0;
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_free_chan_resources);
>  
>  void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
>  {
> @@ -841,6 +856,7 @@ void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
>  		tasklet_kill(&chan->vchan.task);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_cleanup_vchan);
>  
>  /*
>   * On the 32 channels Vybrid/mpc577x edma version, register offsets are
> @@ -877,5 +893,6 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
>  		edma->regs.inth = edma->membase + EDMA64_INTH;
>  	}
>  }
> +EXPORT_SYMBOL_GPL(fsl_edma_setup_regs);
>  
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.39.2
> 

