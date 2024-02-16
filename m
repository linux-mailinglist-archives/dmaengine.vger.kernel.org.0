Return-Path: <dmaengine+bounces-1027-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E95C6857CA2
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 13:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA521F2234E
	for <lists+dmaengine@lfdr.de>; Fri, 16 Feb 2024 12:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83101128818;
	Fri, 16 Feb 2024 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAqFH557"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D6D54F92;
	Fri, 16 Feb 2024 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086814; cv=none; b=LwCyZwmKOqUhOcKCunSU5YDzGYkYPr27gbHudcU44qmF2GdbOZhzeZYZ/19iiwm1jgHXpL1OTTPmRdRoMi9uKvxJbQpc93v0ETJ55hTxKBDVtwUVgFMFw44NC1S7b6iO1re3l5F3CRli6R3VVf9KoP7+961JigLsqgMMhnXH2eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086814; c=relaxed/simple;
	bh=dPfIXbK2bl5QXTBDm0NRlLIuHvXs2+FUzY8LfdPcXc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccPfZHTfWyN/hJ6rQWIM8PMdJtePJrWum9nqZfB2NabZLY5/Q4UfP8ZoVpxMINxKT1f5P0Q/YV8dSebq2NDZL76Rw+RjSWiTVK2LpSpzOAqbAHk1bnRJmuXIE0QP6bTX0lcBWXr2GUS4NGRsOB3RHpSSd846Id1EmG2IMt+kYvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAqFH557; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A37C433F1;
	Fri, 16 Feb 2024 12:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708086813;
	bh=dPfIXbK2bl5QXTBDm0NRlLIuHvXs2+FUzY8LfdPcXc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hAqFH557sFNRc6FHmSaChE4gQQDNMmeEz4tc8OJOdWSfaZp/4Ix7IMDPMM668/wSG
	 PZqP96ZiQf6bV69FoGpYyVzgEZLzlmnBjkUH5+i8niar8EVy8vu/xNKEEtUvjyq+vm
	 PNA4ufr8zQmWGtc3jg5LfpRK4Ua815sXj5vrw5RqZ0GKMrqeJzT6m546ygzMGfvi8o
	 PAfyukeJV4JuJZeOhNeiS2EByoB94yrwn7RBQ6gRk0L45INp6el+0hWfnZrArEGFFx
	 IUn3yhCvteqFUYYEO4yNYwi0+XQLTXhisjNHZnvdIbdECUxrqOgCGFoseq7mkulsY+
	 zUz31kQo5DyaQ==
Date: Fri, 16 Feb 2024 18:03:29 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dmaengine: fsl-qdma: add __iomem and struct in union
 to fix sparse warning
Message-ID: <Zc9WGbgscNeqmuvk@matsya>
References: <20240209210837.304873-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209210837.304873-1-Frank.Li@nxp.com>

On 09-02-24, 16:08, Frank Li wrote:
> Fix below sparse warnings.
> 
> drivers/dma/fsl-qdma.c:645:50: sparse: warning: incorrect type in argument 2 (different address spaces)
> drivers/dma/fsl-qdma.c:645:50: sparse:    expected void [noderef] __iomem *addr
> drivers/dma/fsl-qdma.c:645:50: sparse:    got void
> 
> drivers/dma/fsl-qdma.c:387:15: sparse: sparse: restricted __le32 degrades to integer
> drivers/dma/fsl-qdma.c:390:19: sparse:     expected restricted __le64 [usertype] data
> drivers/dma/fsl-qdma.c:392:13: sparse:     expected unsigned int [assigned] [usertype] cmd

Please document why you are adding the annotations

Also I see this after the patch:

dmaengine/drivers/dma/fsl-edma-main.c:56:16: warning: cast removes address space '__iomem' of expression
dmaengine/drivers/dma/fsl-edma-main.c:60:9: warning: cast removes address space '__iomem' of expression
dmaengine/drivers/dma/fsl-edma-common.c:76:15: warning: cast removes address space '__iomem' of expression
dmaengine/drivers/dma/fsl-edma-common.c:93:9: warning: cast removes address space '__iomem' of expression
dmaengine/drivers/dma/fsl-edma-common.c:100:22: warning: cast removes address space '__iomem' of expression
dmaengine/drivers/dma/fsl-edma-common.c:101:25: warning: cast removes address space '__iomem' of expression
dmaengine/drivers/dma/fsl-edma-common.c:104:15: warning: cast removes address space '__iomem' of expression
dmaengine/drivers/dma/fsl-edma-common.c:106:9: warning: cast removes address space '__iomem' of expression
dmaengine/drivers/dma/fsl-edma-common.c:131:19: warning: cast removes address space '__iomem' of expression
dmaengine/drivers/dma/fsl-edma-common.c:137:17: warning: cast removes address space '__iomem' of expression
dmaengine/drivers/dma/fsl-edma-common.c:140:9: warning: cast removes address space '__iomem' of expression
  CC [M]  drivers/dma/idma64.o
dmaengine/drivers/dma/fsl-edma-common.c:473:17: warning: cast removes address space '__iomem' of expression
dmaengine/drivers/dma/fsl-edma-common.c:473:17: warning: cast removes address space '__iomem' of expression

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402081929.mggOTHaZ-lkp@intel.com/
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/fsl-qdma.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
> index 1e3bf6f30f784..5005e138fc239 100644
> --- a/drivers/dma/fsl-qdma.c
> +++ b/drivers/dma/fsl-qdma.c
> @@ -161,6 +161,10 @@ struct fsl_qdma_format {
>  			u8 __reserved1[2];
>  			u8 cfg8b_w1;
>  		} __packed;
> +		struct {
> +			__le32 __reserved2;
> +			__le32 cmd;
> +		} __packed;
>  		__le64 data;
>  	};
>  } __packed;
> @@ -355,7 +359,6 @@ static void fsl_qdma_free_chan_resources(struct dma_chan *chan)
>  static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
>  				      dma_addr_t dst, dma_addr_t src, u32 len)
>  {
> -	u32 cmd;
>  	struct fsl_qdma_format *sdf, *ddf;
>  	struct fsl_qdma_format *ccdf, *csgf_desc, *csgf_src, *csgf_dest;
>  
> @@ -384,15 +387,11 @@ static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
>  	/* This entry is the last entry. */
>  	qdma_csgf_set_f(csgf_dest, len);
>  	/* Descriptor Buffer */
> -	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
> -			  FSL_QDMA_CMD_RWTTYPE_OFFSET) |
> -			  FSL_QDMA_CMD_PF;
> -	sdf->data = QDMA_SDDF_CMD(cmd);
> -
> -	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
> -			  FSL_QDMA_CMD_RWTTYPE_OFFSET);
> -	cmd |= cpu_to_le32(FSL_QDMA_CMD_LWC << FSL_QDMA_CMD_LWC_OFFSET);
> -	ddf->data = QDMA_SDDF_CMD(cmd);
> +	sdf->cmd = cpu_to_le32((FSL_QDMA_CMD_RWTTYPE << FSL_QDMA_CMD_RWTTYPE_OFFSET) |
> +			       FSL_QDMA_CMD_PF);
> +
> +	ddf->cmd = cpu_to_le32((FSL_QDMA_CMD_RWTTYPE << FSL_QDMA_CMD_RWTTYPE_OFFSET) |
> +			       (FSL_QDMA_CMD_LWC << FSL_QDMA_CMD_LWC_OFFSET));
>  }
>  
>  /*
> @@ -626,7 +625,7 @@ static int fsl_qdma_halt(struct fsl_qdma_engine *fsl_qdma)
>  
>  static int
>  fsl_qdma_queue_transfer_complete(struct fsl_qdma_engine *fsl_qdma,
> -				 void *block,
> +				 __iomem void *block,
>  				 int id)
>  {
>  	bool duplicate;
> -- 
> 2.34.1

-- 
~Vinod

