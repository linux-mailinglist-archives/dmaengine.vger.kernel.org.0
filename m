Return-Path: <dmaengine+bounces-1216-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBE086E772
	for <lists+dmaengine@lfdr.de>; Fri,  1 Mar 2024 18:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C11BCB24FD1
	for <lists+dmaengine@lfdr.de>; Fri,  1 Mar 2024 17:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464855C9C;
	Fri,  1 Mar 2024 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JTIy+vS7"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEA079C2;
	Fri,  1 Mar 2024 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314659; cv=fail; b=h47sMjeYxCCgVkh/26xOR6XVObq8rH7P3pQWNzWKa+mFGdd/ajpQTFXd+MrzTIFEigfYLDxWRIwjDnVOZ35qEgtrjDAsseUUSg/jN4TAb+3O3j31bgaOXQs+SJ+Tn0aT82IbS7xt0dWApJoIcGuJQkBqTpiHz2r1Ih5/dKkulc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314659; c=relaxed/simple;
	bh=gYkZ2dCh8nsyKQGAoy9SMzA2JOMsqUSbKsXTgL/4ZqQ=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=THdD/9u1+xT2tuRd32IyKi348au4p5XdkyNNyfPaQJ2gKC+9qddGc1iQ5E/BogI4kzk9VTtTj7uYr9q0+UzCrF/hkAQgOh5mzQ7ovIbnYmAPQJj2Od9QcVMwWHn3jv3q3YoPkUS7U0nsbzg86a0nAbSklaZ2ycBxPlTiEE6HXSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JTIy+vS7; arc=fail smtp.client-ip=40.107.22.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuUlnjdl+Sh2UTmxTRExWBB1R6UqldgllcsK2Kaqfzon8ntBCBqOcHlFX+lGc2XLE3CdK8v/DRKA0i4X9ajLNA/vZRigREVMbOjSyUVWK1Wr8FRuEeIEVZkFB5ojsv1skyid+5NvqtoMh7/wpagLlVBPDWuNYNsmAqyWVKpY+vPtNPIDI2p4ZqQ4oFIrX8bLzOnmcAwS55Wyk39xRe5cyW6VSUz9suXe6UStkryT4y0msUIvY+jdCFjo0/7wxMhxdEqeLNBagUjXHFGf7gqTf8mdc8lpAdS0ZdLtuRrsklAB7SIyFXicVOSukdM5iPWplK1FDybYkrrZiBNgRQ1NJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+HIv/gI8m2D7/b5fH6bpzVsKusJse13n43vTKoMVu8=;
 b=ZTjSHYIwcNgDvVaoLd4xeXEuTHsMC6PeSKXNnb5lk8WvEe6NFOHFKfD5v0tQpt4A7+jtwOBy9x4f07ru57n4Jef1fbdUNUKmq2UTNHgMy+V+4fy14ONbkFLOoRUFVZZ4Uc1xOaIAXpRZsC2f5binE4Fg1txON2iTXRVagKpi0Uat8thuX3rO/xGZex8mw3HPDWxP55GAtBzh8umzkiU3r2Jeea8/ZNNyWwzSwAzdLRDCkZ1UvLlVxD2ytb+umRrG32DH37wWxdQqEs9pRyrPTNhtq1eEV93hGdPWxl6+9IUXhcbuQlqrKhtlrNyHMyoRCNH3oaUonSrGdnGcSPyk5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+HIv/gI8m2D7/b5fH6bpzVsKusJse13n43vTKoMVu8=;
 b=JTIy+vS7Czk0kXZ4f7mgMjYgoB+/dyB7/S9Gd0eqWJhQTqgxakJxcQTzBxZnv+CxhIsq7o1SDa1oVRmEFQoNmPQFJd8SEybwvjaG0wjSdD2rJo4N875F31AVeUgofIYhpcwtCmFslKWz2hy/rCgGJxL5GXasQSZM2CMORbm38eA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9560.eurprd04.prod.outlook.com (2603:10a6:20b:470::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.40; Fri, 1 Mar
 2024 17:37:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 17:37:34 +0000
Date: Fri, 1 Mar 2024 12:37:28 -0500
From: Frank Li <Frank.li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, open list <linux-kernel@vger.kernel.org>,
	"open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
	"open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>
Subject: Re: [PATCH v2 1/2] dmaengine: fsl-edma: add trace event support
Message-ID: <20240301173728.usw5rja3bzn7zbwk@lizhi-Precision-Tower-5810>
References: <20240209213606.367025-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209213606.367025-1-Frank.Li@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0162.namprd05.prod.outlook.com
 (2603:10b6:a03:339::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9560:EE_
X-MS-Office365-Filtering-Correlation-Id: d4679a0d-4014-4675-b1ac-08dc3a164749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aoMIynzcMnhQmVRGCPuqHBNcjqrBuxBv2nJpr2/Lq2HA47HvjD9xOD4M058jMyogzBLHVzUUbgdSL9rmXz6waiN+OdzslIpV3fv7MxtHt2TidY32Az3mVJLD2zNVdCpNk6zTq9pdPGHLNymUvAm/CbblFf7QPOZgt1idEM3cvxQ1kTX+B4aCT5+bbSzMIJpCt7OZofMstZ+lvRZAyDfSb9+/ogwt5O2qWR6ViZkS7yHLGoLVmWMScGw8ACT7NoWbXYXthvqHjmezXVhcSRdJjOwEcnqSorFaazLFK+xYhw9kfTdlc36lLnoGeDnqxnHgsgBV7OxlDAtk4c08HgK7MZhP29ubtbsZf08NentEJc2FwN56sqDum83y2SPU0qyV4SvKbEUKsGm1XfZ0y/xT+lGFs7Q5JMakIr7M41xegAebwSeBT9/JHBFmRQ0Fe+lVtRG4Gffmpd9Nj8bL1DjK1ZLHH6Ub3INlgq7uof6VRfbs1TEZxSQc1yoT96jeNv2UQ3DHHk/BsicetOWCyt65D0a+B6QVjSYdD4pAkE6TZ7hpM2HbHm6FcgCQmE71B5GWNvFPoxU77dI2/93EoWs3lpqFNCSm/e6xWltp1Eu9Gh2PPBp+uNteg9qHEniLi7P0s+jvUXwZOpPYJlEJcplHwCNdJPqCL1Q63TPc75IK1C77G/rW+/PYn7pzEvlWuHSstXGid81xhSD++G/1c1Q6aZkq6V0EsI9onMsW2Gh2xaM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ra2nmY+KKQB1fGaW9eyjl79jY5qeXkCPsRmcDTeWCJigEQZfarqjP5iIc9XW?=
 =?us-ascii?Q?xHes6BO3VImhqY/O076m2pUysr/AzKtL6odrUmftFu7vamXboNMck7AoJ9sw?=
 =?us-ascii?Q?1NfmuYqvdP8vT+D0NP0wgBxqTjDnh+Nd9dJ5Htk8aGnhN4yXgwf6foEPtN8M?=
 =?us-ascii?Q?q/B8c6ot0XNHY25ENTFrFi1AbAQyTJsWIYtJgy5H2gluplEzdIuOuZn2PYbu?=
 =?us-ascii?Q?961rhDttoJzzOSLw44zvSb1/pzr+cFiI4bhuZYdtgpjczeTCNny8MTSrgGOH?=
 =?us-ascii?Q?RJe5qPxec83w+GqDmzJ84w5TY7hMSKbvv6KG3nKxrB71X1oXdZjozlPsTNST?=
 =?us-ascii?Q?Am9t7lNffmg2PBjLP6WGozoSnEp4oRYqRM9zFs8WGf5hyT0qle4z4JCTg5gq?=
 =?us-ascii?Q?b68SZiYYVofUoAATmqzVPPgRgX/6YOvKbIdPp0y7eA6B+3xCn79s7wT7jaBE?=
 =?us-ascii?Q?22BSAJbtkcHoQO7Hqttaa9If/yG3ss0r8p5o3yBDnAj/uGe73B3uRCT/KMN5?=
 =?us-ascii?Q?t+kv/RIM/r4O3M843sgX6SWlnxtro/L+0Vz0mAe7Hwx5q9j/OjCB/uN9Cofn?=
 =?us-ascii?Q?gNt1JPaVjY+npgFsEerZnmD9Mkaa2g37QgGiRGn+LprAK7BJPIJrVQwIExR4?=
 =?us-ascii?Q?9uiAurLWB1LhyXUe1hDgPClM6VABwOgvb4ypBxaK8/pPXuEvPGB6rJjmA7Bi?=
 =?us-ascii?Q?6gc5cgb+MCmNLmxKuc4fFQcqgLhIaiiXj4rtxgOA+1od87TBvx9yNWOBxMQM?=
 =?us-ascii?Q?tNSIp3tfdbwq0jZRHnfSCFbt7qGvH3rONJH5UQdgL7FCCijpKY8ZyaG0dfCC?=
 =?us-ascii?Q?zB47dcATPi461ArMUpNKl7XAjudqquTtkzs1x9r54ZYatibMa9Qqot4KpS8E?=
 =?us-ascii?Q?MsDUA5heR8FYnERQY+txVt7axubzsPDeILk38ZqxMdONetwUYfhj5y7xV0Es?=
 =?us-ascii?Q?61ruPhDhHekQ/Ikc/U/3nGlYt4FpzY211ZNYAc8OUVptOzu+hvMu/oYMLlyr?=
 =?us-ascii?Q?bXmV7g7sbMKr3lhCMfgv/k9PQBjgrBWY23QKrLAXAaINTa6ccv+c2V+c4zGp?=
 =?us-ascii?Q?SgeKU14akkC/zYiMVZNakkplFacaWvei8V8jQQIoLmJB7+WZzRbO3omGwWS4?=
 =?us-ascii?Q?/iwrZr+9C1g3RPOI8ShXyiTISwhHh2Qz25Xox+Pz1F3ZtQq3OkT9mCVI73pJ?=
 =?us-ascii?Q?14JQl6ET2OMD8bmgPy9YUDqbBx+0vH/pdlDL6x43BNK/EF03YTHJPD7tpyVW?=
 =?us-ascii?Q?LBEYqKV6GYp7kQCiYwzVoHROimcdqUryFl+tDR6iXeTzm7qNXXKr7d2sf4ff?=
 =?us-ascii?Q?HXoyBsTG96Fuw3yu6ktRqKJXbwMDL1KqAMvNYp4G1Coi52fzu3m3fuxzOE8Q?=
 =?us-ascii?Q?CTc119+Xr5pwif6mQ92/ciTq4A5AfAFsLHw1g914sB0nRZ+nm0gc2Z5d0fIw?=
 =?us-ascii?Q?Z1MHQMQ9K1MpUGIG3mPvnO9RojpZNMYQfvL0Sgjce2MlTOz2oXOaBJ7ODApk?=
 =?us-ascii?Q?35uT7qrUR9oNTRHaIoxs7rKV6K4U2kd1KrFjltBbUQpVGru7/fUcKNiDwZZd?=
 =?us-ascii?Q?84u8rYLwivYeCj3aYidte2l2Sa/Rga5YzhIknkK9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4679a0d-4014-4675-b1ac-08dc3a164749
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 17:37:34.0499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfKYthHqHyxQ674kvEZIz7rll8fNI0xBBmaSVW3E85fWeYc1tU3wI0fnP+vtTGeCVYr1tQQK97HV3kZLosq0dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9560

On Fri, Feb 09, 2024 at 04:36:03PM -0500, Frank Li wrote:
> Implement trace event support to enhance logging functionality for
> register access and the transfer control descriptor (TCD) context.
> This will enable more comprehensive monitoring and analysis of system
> activities
> 

@Vinod:
    Do you have chance to check these two patches?

Frank

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/Makefile          |   6 +-
>  drivers/dma/fsl-edma-common.c |   2 +
>  drivers/dma/fsl-edma-common.h |  45 +++++++++---
>  drivers/dma/fsl-edma-trace.c  |   4 ++
>  drivers/dma/fsl-edma-trace.h  | 132 ++++++++++++++++++++++++++++++++++
>  5 files changed, 178 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/dma/fsl-edma-trace.c
>  create mode 100644 drivers/dma/fsl-edma-trace.h
> 
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index dfd40d14e4089..802ca916f05f5 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -31,10 +31,12 @@ obj-$(CONFIG_DW_AXI_DMAC) += dw-axi-dmac/
>  obj-$(CONFIG_DW_DMAC_CORE) += dw/
>  obj-$(CONFIG_DW_EDMA) += dw-edma/
>  obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
> +fsl-edma-trace-$(CONFIG_TRACING) := fsl-edma-trace.o
> +CFLAGS_fsl-edma-trace.o := -I$(src)
>  obj-$(CONFIG_FSL_DMA) += fsldma.o
> -fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o
> +fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y}
>  obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
> -mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o
> +mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y}
>  obj-$(CONFIG_MCF_EDMA) += mcf-edma.o
>  obj-$(CONFIG_FSL_QDMA) += fsl-qdma.o
>  obj-$(CONFIG_FSL_RAID) += fsl_raid.o
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index b18faa7cfedb9..ebd9647671c9f 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -546,6 +546,8 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
>  		csr |= EDMA_TCD_CSR_START;
>  
>  	fsl_edma_set_tcd_to_le(fsl_chan, tcd, csr, csr);
> +
> +	trace_edma_fill_tcd(fsl_chan, tcd);
>  }
>  
>  static struct fsl_edma_desc *fsl_edma_alloc_desc(struct fsl_edma_chan *fsl_chan,
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index a05a1f283ece2..365affd5b0764 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -249,6 +249,11 @@ struct fsl_edma_engine {
>  	struct fsl_edma_chan	chans[] __counted_by(n_chans);
>  };
>  
> +static inline u32 fsl_edma_drvflags(struct fsl_edma_chan *fsl_chan)
> +{
> +	return fsl_chan->edma->drvdata->flags;
> +}
> +
>  #define edma_read_tcdreg_c(chan, _tcd,  __name)				\
>  (sizeof((_tcd)->__name) == sizeof(u64) ?				\
>  	edma_readq(chan->edma, &(_tcd)->__name) :			\
> @@ -352,6 +357,9 @@ do {								\
>  		fsl_edma_set_tcd_to_le_c((struct fsl_edma_hw_tcd *)_tcd, _val, _field);		\
>  } while (0)
>  
> +/* Need after struct defination */
> +#include "fsl-edma-trace.h"
> +
>  /*
>   * R/W functions for big- or little-endian registers:
>   * The eDMA controller's endian is independent of the CPU core's endian.
> @@ -370,23 +378,38 @@ static inline u64 edma_readq(struct fsl_edma_engine *edma, void __iomem *addr)
>  		h = ioread32(addr + 4);
>  	}
>  
> +	trace_edma_readl(edma, addr, l);
> +	trace_edma_readl(edma, addr + 4, h);
> +
>  	return (h << 32) | l;
>  }
>  
>  static inline u32 edma_readl(struct fsl_edma_engine *edma, void __iomem *addr)
>  {
> +	u32 val;
> +
>  	if (edma->big_endian)
> -		return ioread32be(addr);
> +		val = ioread32be(addr);
>  	else
> -		return ioread32(addr);
> +		val = ioread32(addr);
> +
> +	trace_edma_readl(edma, addr, val);
> +
> +	return val;
>  }
>  
>  static inline u16 edma_readw(struct fsl_edma_engine *edma, void __iomem *addr)
>  {
> +	u16 val;
> +
>  	if (edma->big_endian)
> -		return ioread16be(addr);
> +		val = ioread16be(addr);
>  	else
> -		return ioread16(addr);
> +		val = ioread16(addr);
> +
> +	trace_edma_readw(edma, addr, val);
> +
> +	return val;
>  }
>  
>  static inline void edma_writeb(struct fsl_edma_engine *edma,
> @@ -397,6 +420,8 @@ static inline void edma_writeb(struct fsl_edma_engine *edma,
>  		iowrite8(val, (void __iomem *)((unsigned long)addr ^ 0x3));
>  	else
>  		iowrite8(val, addr);
> +
> +	trace_edma_writeb(edma, addr, val);
>  }
>  
>  static inline void edma_writew(struct fsl_edma_engine *edma,
> @@ -407,6 +432,8 @@ static inline void edma_writew(struct fsl_edma_engine *edma,
>  		iowrite16be(val, (void __iomem *)((unsigned long)addr ^ 0x2));
>  	else
>  		iowrite16(val, addr);
> +
> +	trace_edma_writew(edma, addr, val);
>  }
>  
>  static inline void edma_writel(struct fsl_edma_engine *edma,
> @@ -416,6 +443,8 @@ static inline void edma_writel(struct fsl_edma_engine *edma,
>  		iowrite32be(val, addr);
>  	else
>  		iowrite32(val, addr);
> +
> +	trace_edma_writel(edma, addr, val);
>  }
>  
>  static inline void edma_writeq(struct fsl_edma_engine *edma,
> @@ -428,6 +457,9 @@ static inline void edma_writeq(struct fsl_edma_engine *edma,
>  		iowrite32(val & 0xFFFFFFFF, addr);
>  		iowrite32(val >> 32, addr + 4);
>  	}
> +
> +	trace_edma_writel(edma, addr, val & 0xFFFFFFFF);
> +	trace_edma_writel(edma, addr + 4, val >> 32);
>  }
>  
>  static inline struct fsl_edma_chan *to_fsl_edma_chan(struct dma_chan *chan)
> @@ -435,11 +467,6 @@ static inline struct fsl_edma_chan *to_fsl_edma_chan(struct dma_chan *chan)
>  	return container_of(chan, struct fsl_edma_chan, vchan.chan);
>  }
>  
> -static inline u32 fsl_edma_drvflags(struct fsl_edma_chan *fsl_chan)
> -{
> -	return fsl_chan->edma->drvdata->flags;
> -}
> -
>  static inline struct fsl_edma_desc *to_fsl_edma_desc(struct virt_dma_desc *vd)
>  {
>  	return container_of(vd, struct fsl_edma_desc, vdesc);
> diff --git a/drivers/dma/fsl-edma-trace.c b/drivers/dma/fsl-edma-trace.c
> new file mode 100644
> index 0000000000000..28300ad80bb75
> --- /dev/null
> +++ b/drivers/dma/fsl-edma-trace.c
> @@ -0,0 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define CREATE_TRACE_POINTS
> +#include "fsl-edma-common.h"
> diff --git a/drivers/dma/fsl-edma-trace.h b/drivers/dma/fsl-edma-trace.h
> new file mode 100644
> index 0000000000000..d3541301a2470
> --- /dev/null
> +++ b/drivers/dma/fsl-edma-trace.h
> @@ -0,0 +1,132 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2023 NXP.
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM fsl_edma
> +
> +#if !defined(__LINUX_FSL_EDMA_TRACE) || defined(TRACE_HEADER_MULTI_READ)
> +#define __LINUX_FSL_EDMA_TRACE
> +
> +#include <linux/types.h>
> +#include <linux/tracepoint.h>
> +
> +DECLARE_EVENT_CLASS(edma_log_io,
> +	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr, u32 value),
> +	TP_ARGS(edma, addr, value),
> +	TP_STRUCT__entry(
> +		__field(struct fsl_edma_engine *, edma)
> +		__field(void __iomem *, addr)
> +		__field(u32, value)
> +	),
> +	TP_fast_assign(
> +		__entry->edma = edma;
> +		__entry->addr = addr;
> +		__entry->value = value;
> +	),
> +	TP_printk("offset %08x: value %08x",
> +		(u32)(__entry->addr - __entry->edma->membase), __entry->value)
> +);
> +
> +DEFINE_EVENT(edma_log_io, edma_readl,
> +	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr, u32 value),
> +	TP_ARGS(edma, addr, value)
> +);
> +
> +DEFINE_EVENT(edma_log_io, edma_writel,
> +	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr,  u32 value),
> +	TP_ARGS(edma, addr, value)
> +);
> +
> +DEFINE_EVENT(edma_log_io, edma_readw,
> +	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr, u32 value),
> +	TP_ARGS(edma, addr, value)
> +);
> +
> +DEFINE_EVENT(edma_log_io, edma_writew,
> +	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr,  u32 value),
> +	TP_ARGS(edma, addr, value)
> +);
> +
> +DEFINE_EVENT(edma_log_io, edma_readb,
> +	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr, u32 value),
> +	TP_ARGS(edma, addr, value)
> +);
> +
> +DEFINE_EVENT(edma_log_io, edma_writeb,
> +	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr,  u32 value),
> +	TP_ARGS(edma, addr, value)
> +);
> +
> +DECLARE_EVENT_CLASS(edma_log_tcd,
> +	TP_PROTO(struct fsl_edma_chan *chan, void *tcd),
> +	TP_ARGS(chan, tcd),
> +	TP_STRUCT__entry(
> +		__field(u64, saddr)
> +		__field(u16, soff)
> +		__field(u16, attr)
> +		__field(u32, nbytes)
> +		__field(u64, slast)
> +		__field(u64, daddr)
> +		__field(u16, doff)
> +		__field(u16, citer)
> +		__field(u64, dlast_sga)
> +		__field(u16, csr)
> +		__field(u16, biter)
> +
> +	),
> +	TP_fast_assign(
> +		__entry->saddr = fsl_edma_get_tcd_to_cpu(chan, tcd, saddr),
> +		__entry->soff = fsl_edma_get_tcd_to_cpu(chan, tcd, soff),
> +		__entry->attr = fsl_edma_get_tcd_to_cpu(chan, tcd, attr),
> +		__entry->nbytes = fsl_edma_get_tcd_to_cpu(chan, tcd, nbytes),
> +		__entry->slast = fsl_edma_get_tcd_to_cpu(chan, tcd, slast),
> +		__entry->daddr = fsl_edma_get_tcd_to_cpu(chan, tcd, daddr),
> +		__entry->doff = fsl_edma_get_tcd_to_cpu(chan, tcd, doff),
> +		__entry->citer = fsl_edma_get_tcd_to_cpu(chan, tcd, citer),
> +		__entry->dlast_sga = fsl_edma_get_tcd_to_cpu(chan, tcd, dlast_sga),
> +		__entry->csr = fsl_edma_get_tcd_to_cpu(chan, tcd, csr),
> +		__entry->biter = fsl_edma_get_tcd_to_cpu(chan, tcd, biter);
> +	),
> +	TP_printk("\n==== TCD =====\n"
> +		  "  saddr:  0x%016llx\n"
> +		  "  soff:               0x%04x\n"
> +		  "  attr:               0x%04x\n"
> +		  "  nbytes:         0x%08x\n"
> +		  "  slast:  0x%016llx\n"
> +		  "  daddr:  0x%016llx\n"
> +		  "  doff:               0x%04x\n"
> +		  "  citer:              0x%04x\n"
> +		  "  dlast:  0x%016llx\n"
> +		  "  csr:                0x%04x\n"
> +		  "  biter:              0x%04x\n",
> +		__entry->saddr,
> +		__entry->soff,
> +		__entry->attr,
> +		__entry->nbytes,
> +		__entry->slast,
> +		__entry->daddr,
> +		__entry->doff,
> +		__entry->citer,
> +		__entry->dlast_sga,
> +		__entry->csr,
> +		__entry->biter)
> +);
> +
> +DEFINE_EVENT(edma_log_tcd, edma_fill_tcd,
> +	TP_PROTO(struct fsl_edma_chan *chan, void *tcd),
> +	TP_ARGS(chan, tcd)
> +);
> +
> +#endif
> +
> +/* this part must be outside header guard */
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE fsl-edma-trace
> +
> +#include <trace/define_trace.h>
> -- 
> 2.34.1
> 

