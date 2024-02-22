Return-Path: <dmaengine+bounces-1070-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5FA85FA99
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 15:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6730B257B5
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 14:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2EB135410;
	Thu, 22 Feb 2024 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0XnSrP1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7D8130AD2;
	Thu, 22 Feb 2024 14:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610464; cv=none; b=JX5XWo03PcoJyAYBTyPtMu5XXQj3DQUhfqqnYYs6Iapx8S7OGHOk/Oe3Fqa9e47ZxJYIp29v8/6pDiIjpLeayLuiao9Gun1ODfhm7EzCvN6FdVob7aKTVeb4lrxOe0LUuS57QlL8BFdbBNf6CQTnjci+BgVs3DrZHN/67sZDVLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610464; c=relaxed/simple;
	bh=fSetG6elC4kpGUF26Sm8cvkGBwCQN75G2SfsKotHPXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJr2VaIkHGDOAtsEMxtIS3NPHRJe4NWXUS6EBRGxOKz5ocbb+ZfOixAdsAkYCnZxTwYUYhuZazfthP9gTTiS5uVwINYwNcJnpCRhmwn/nxB60xMYWGpd0rl4x3Zzw6oQ8uU6hFe8CszGX9TnKOGSZrFr9/avvQlWzJB5tOccFto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0XnSrP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F08C43394;
	Thu, 22 Feb 2024 14:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708610463;
	bh=fSetG6elC4kpGUF26Sm8cvkGBwCQN75G2SfsKotHPXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0XnSrP1p41eJvsTuLVLWF3U172Yn44+9AWCLJyshiGIzDu3f4HbenetnbJ9qYlqN
	 Cm8k3vM3W2zpUaYdkwanrZxskr5cHCpBN+RRNIfRfv4M3+qML31eu7lbTcS7YM3TIV
	 gcza/0AMDg+C2B4c6Sj0LbPgxE8BQBrpLWwkcX5Ay6V96c4HDuOAhLVxwrYo7blybV
	 uG+JT2ikmgzsqAMxA5Gq8YkDg7+0LJOC3CrE1aSD/yhQqzaZ527s/WyvjZavgn19Jh
	 Pgn0eiyk1shaGPFGtubF841FexMLoSA8rrkGCK7e8yzEP9/eeVDpPetN49erR/5QxS
	 tI2Og5OfRrI9w==
Date: Thu, 22 Feb 2024 19:30:59 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dmaengine: fsl-qdma: add __iomem and struct in
 union to fix sparse warning
Message-ID: <ZddTmwh82K6biJSx@matsya>
References: <20240219155939.611237-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219155939.611237-1-Frank.Li@nxp.com>

On 19-02-24, 10:59, Frank Li wrote:
> Fix below sparse warnings.

This does not apply for me, can you rebase

> 
> drivers/dma/fsl-qdma.c:645:50: sparse: warning: incorrect type in argument 2 (different address spaces)
> drivers/dma/fsl-qdma.c:645:50: sparse:    expected void [noderef] __iomem *addr
> drivers/dma/fsl-qdma.c:645:50: sparse:    got void
> 
> drivers/dma/fsl-qdma.c:387:15: sparse: sparse: restricted __le32 degrades to integer
> drivers/dma/fsl-qdma.c:390:19: sparse:     expected restricted __le64 [usertype] data
> drivers/dma/fsl-qdma.c:392:13: sparse:     expected unsigned int [assigned] [usertype] cmd
> 
> QDMA decriptor have below 3 kind formats. (little endian)
> 
> Compound Command Descriptor Format
>   ┌──────┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┐
>   │Offset│3│3│2│2│2│2│2│2│2│2│2│2│1│1│1│1│1│1│1│1│1│1│ │ │ │ │ │ │ │ │ │ │
>   │      │1│0│9│8│7│6│5│4│3│2│1│0│9│8│7│6│5│4│3│2│1│0│9│8│7│6│5│4│3│2│1│0│
>   ├──────┼─┴─┼─┴─┴─┼─┴─┴─┼─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴─┴─┴─┴─┴─┤
>   │ 0x0C │DD │  -  │QUEUE│             -                 │      ADDR     │
>   ├──────┼───┴─────┴─────┴───────────────────────────────┴───────────────┤
>   │ 0x08 │                       ADDR                                    │
>   ├──────┼─────┬─────────────────┬───────────────────────────────────────┤
>   │ 0x04 │ FMT │    OFFSET       │                   -                   │
>   ├──────┼─┬─┬─┴─────────────────┴───────────────────────┬───────────────┤
>   │      │ │S│                                           │               │
>   │ 0x00 │-│E│                   -                       │    STATUS     │
>   │      │ │R│                                           │               │
>   └──────┴─┴─┴───────────────────────────────────────────┴───────────────┘
> 
> Compound S/G Table Entry Format
>  ┌──────┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┐
>  │Offset│3│3│2│2│2│2│2│2│2│2│2│2│1│1│1│1│1│1│1│1│1│1│ │ │ │ │ │ │ │ │ │ │
>  │      │1│0│9│8│7│6│5│4│3│2│1│0│9│8│7│6│5│4│3│2│1│0│9│8│7│6│5│4│3│2│1│0│
>  ├──────┼─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴─┴─┴─┴─┴─┤
>  │ 0x0C │                      -                        │    ADDR       │
>  ├──────┼───────────────────────────────────────────────┴───────────────┤
>  │ 0x08 │                          ADDR                                 │
>  ├──────┼─┬─┬───────────────────────────────────────────────────────────┤
>  │ 0x04 │E│F│                    LENGTH                                 │
>  ├──────┼─┴─┴─────────────────────────────────┬─────────────────────────┤
>  │ 0x00 │              -                      │        OFFSET           │
>  └──────┴─────────────────────────────────────┴─────────────────────────┘
> 
> Source/Destination Descriptor Format
>   ┌──────┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┐
>   │Offset│3│3│2│2│2│2│2│2│2│2│2│2│1│1│1│1│1│1│1│1│1│1│ │ │ │ │ │ │ │ │ │ │
>   │      │1│0│9│8│7│6│5│4│3│2│1│0│9│8│7│6│5│4│3│2│1│0│9│8│7│6│5│4│3│2│1│0│
>   ├──────┼─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┤
>   │ 0x0C │                            CMD                                │
>   ├──────┼───────────────────────────────────────────────────────────────┤
>   │ 0x08 │                             -                                 │
>   ├──────┼───────────────┬───────────────────────┬───────────────────────┤
>   │ 0x04 │       -       │         S[D]SS        │        S[D]SD         │
>   ├──────┼───────────────┴───────────────────────┴───────────────────────┤
>   │ 0x00 │                             -                                 │
>   └──────┴───────────────────────────────────────────────────────────────┘
> 
> Previous code use 64bit 'data' map to 0x8 and 0xC. In little endian system
> CMD is high part of 64bit 'data'. It is correct by left shift 32. But in
> big endian system, shift left 32 will write to 0x8 position. Sparse detect
> this problem.
> 
> Add below field ot match 'Source/Destination Descriptor Format'.
> struct {
> 	__le32 __reserved2;
> 	__le32 cmd;
> } __packed;
> 
> Using ddf(sdf)->cmd save to correct posistion regardless endian.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402081929.mggOTHaZ-lkp@intel.com/
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v1 to v2
>     - update commit message to show why add 'cmd'
>     
>     fsl-edma-common.c's build warning should not cause by this driver. which is
>     difference drivers. This driver will not use any code related with
>     fsl-edma-common.c.
> 
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

