Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB594246E9
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 06:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbfEUEeo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 00:34:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfEUEeo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 00:34:44 -0400
Received: from localhost (unknown [106.201.107.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A5712173E;
        Tue, 21 May 2019 04:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558413283;
        bh=FyMfJVTBNMLoW1/4K1izPZGoiFCIGoNjbcj57tYlg70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dj4bvWTjTtgdEulQyjYthsUxg86jGVS5KBLTR1djqTJeXjMErVUynDKx+fLhWR5qA
         CO/d8w7o57Z82DXG/fBqmSk8QB33FY23HSMkJUq79JhvADaJttpqov+P39AolOj1Rf
         H4/TZEjvSJSihncHn742uoitLWZ0kumcdU7K1a0M=
Date:   Tue, 21 May 2019 10:04:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     dan.j.williams@intel.com, leoyang.li@nxp.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [V2 1/2] dmaengine: fsl-qdma: fixed the source/destination
 descriptor format
Message-ID: <20190521043438.GL15118@vkoul-mobl>
References: <20190506022111.31751-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506022111.31751-1-peng.ma@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-05-19, 10:21, Peng Ma wrote:
> CMD of Source/Destination descriptor format should be lower of
> struct fsl_qdma_engine number data address.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> changed for V2:
> 	- Fix descriptor spelling
> 
>  drivers/dma/fsl-qdma.c |   25 +++++++++++++++++--------
>  1 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
> index aa1d0ae..2e8b46b 100644
> --- a/drivers/dma/fsl-qdma.c
> +++ b/drivers/dma/fsl-qdma.c
> @@ -113,6 +113,7 @@
>  /* Field definition for Descriptor offset */
>  #define QDMA_CCDF_STATUS		20
>  #define QDMA_CCDF_OFFSET		20
> +#define QDMA_SDDF_CMD(x)		(((u64)(x)) << 32)
>  
>  /* Field definition for safe loop count*/
>  #define FSL_QDMA_HALT_COUNT		1500
> @@ -214,6 +215,12 @@ struct fsl_qdma_engine {
>  
>  };
>  
> +static inline void
> +qdma_sddf_set_cmd(struct fsl_qdma_format *sddf, u32 val)
> +{
> +	sddf->data = QDMA_SDDF_CMD(val);
> +}

Do you really need this helper which calls another macro!

> +
>  static inline u64
>  qdma_ccdf_addr_get64(const struct fsl_qdma_format *ccdf)
>  {
> @@ -341,6 +348,7 @@ static void fsl_qdma_free_chan_resources(struct dma_chan *chan)
>  static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
>  				      dma_addr_t dst, dma_addr_t src, u32 len)
>  {
> +	u32 cmd;
>  	struct fsl_qdma_format *sdf, *ddf;
>  	struct fsl_qdma_format *ccdf, *csgf_desc, *csgf_src, *csgf_dest;
>  
> @@ -353,6 +361,7 @@ static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
>  
>  	memset(fsl_comp->virt_addr, 0, FSL_QDMA_COMMAND_BUFFER_SIZE);
>  	memset(fsl_comp->desc_virt_addr, 0, FSL_QDMA_DESCRIPTOR_BUFFER_SIZE);
> +

why did you add a blank line in this 'fix', it does not belong here!

>  	/* Head Command Descriptor(Frame Descriptor) */
>  	qdma_desc_addr_set64(ccdf, fsl_comp->bus_addr + 16);
>  	qdma_ccdf_set_format(ccdf, qdma_ccdf_get_offset(ccdf));
> @@ -369,14 +378,14 @@ static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
>  	/* This entry is the last entry. */
>  	qdma_csgf_set_f(csgf_dest, len);
>  	/* Descriptor Buffer */
> -	sdf->data =
> -		cpu_to_le64(FSL_QDMA_CMD_RWTTYPE <<
> -			    FSL_QDMA_CMD_RWTTYPE_OFFSET);
> -	ddf->data =
> -		cpu_to_le64(FSL_QDMA_CMD_RWTTYPE <<
> -			    FSL_QDMA_CMD_RWTTYPE_OFFSET);
> -	ddf->data |=
> -		cpu_to_le64(FSL_QDMA_CMD_LWC << FSL_QDMA_CMD_LWC_OFFSET);
> +	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
> +			  FSL_QDMA_CMD_RWTTYPE_OFFSET);
> +	qdma_sddf_set_cmd(sdf, cmd);

why not do sddf->data = QDMA_SDDF_CMD(cmd);

> +
> +	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
> +			  FSL_QDMA_CMD_RWTTYPE_OFFSET);
> +	cmd |= cpu_to_le32(FSL_QDMA_CMD_LWC << FSL_QDMA_CMD_LWC_OFFSET);
> +	qdma_sddf_set_cmd(ddf, cmd);
>  }
>  
>  /*
> -- 
> 1.7.1

-- 
~Vinod
