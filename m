Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F122204D0
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2020 08:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgGOGOv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jul 2020 02:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbgGOGOv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jul 2020 02:14:51 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 712EB2065D;
        Wed, 15 Jul 2020 06:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594793690;
        bh=TQU61uWOA+EBG/S09fcmS3R64SKGaWstkiTqWtL9BqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0b7/m5UuymlLUtRIO5VQpFYLZ/RHDkkRpBuQ/rHV4z7Uusl/cb36ktYmmQgRBYhjO
         iIUfM2Fmwj6XY633TB7dj/hm0z1IEXrggt6mKr1tmeTD0INtLzNTRvvDmOeHrGAPAd
         6nUwi3vzWxOLmTYKFHaGbL4cIs0qD+8ZnxNph+S4=
Date:   Wed, 15 Jul 2020 11:44:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Koehrer Mathias (ETAS/EES-SL)" <mathias.koehrer@etas.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH v3] dmaengine: Extend NXP QDMA driver to check
 transmission errors
Message-ID: <20200715061446.GZ34333@vkoul-mobl>
References: <bf1a0d5294d06c7c83533997eec25b0b6b536c85.camel@bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf1a0d5294d06c7c83533997eec25b0b6b536c85.camel@bosch.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-07-20, 05:45, Koehrer Mathias (ETAS/EES-SL) wrote:
> Extend NXP QDMA driver to check transmission errors
> 
> The NXP QDMA driver (fsl-qdma.c) does not check the status bits
> that indicate if a DMA transfer has been completed successfully.
> This patch extends the driver to do exactly this.

This is v3, pls do mention what changes b/w each revision in cover
letter or the after the marker after s-o-b line

> 
> Signed-off-by: Mathias Koehrer <mathias.koehrer@etas.com>
> ---
> Index: linux-5.4/drivers/dma/fsl-qdma.c
> ===================================================================
> --- linux-5.4.orig/drivers/dma/fsl-qdma.c
> +++ linux-5.4/drivers/dma/fsl-qdma.c
> @@ -56,7 +56,7 @@
>  
>  /* Registers for bit and genmask */
>  #define FSL_QDMA_CQIDR_SQT		BIT(15)
> -#define QDMA_CCDF_FOTMAT		BIT(29)
> +#define QDMA_CCDF_FORMAT		BIT(29)
>  #define QDMA_CCDF_SER			BIT(30)
>  #define QDMA_SG_FIN			BIT(30)
>  #define QDMA_SG_LEN_MASK		GENMASK(29, 0)
> @@ -110,11 +110,23 @@
>  #define FSL_QDMA_CMD_DSEN_OFFSET	19
>  #define FSL_QDMA_CMD_LWC_OFFSET		16
>  
> +/* Field definition for Descriptor status */
> +#define QDMA_CCDF_STATUS_RTE		BIT(5)
> +#define QDMA_CCDF_STATUS_WTE		BIT(4)
> +#define QDMA_CCDF_STATUS_CDE		BIT(2)
> +#define QDMA_CCDF_STATUS_SDE		BIT(1)
> +#define QDMA_CCDF_STATUS_DDE		BIT(0)
> +#define QDMA_CCDF_STATUS_MASK		(QDMA_CCDF_STATUS_RTE | \
> +					QDMA_CCDF_STATUS_WTE | \
> +					QDMA_CCDF_STATUS_CDE | \
> +					QDMA_CCDF_STATUS_SDE | \
> +					QDMA_CCDF_STATUS_DDE)
> +
>  /* Field definition for Descriptor offset */
> -#define QDMA_CCDF_STATUS		20
>  #define QDMA_CCDF_OFFSET		20
>  #define QDMA_SDDF_CMD(x)		(((u64)(x)) << 32)
>  
> +

redundant empty line

>  /* Field definition for safe loop count*/
>  #define FSL_QDMA_HALT_COUNT		1500
>  #define FSL_QDMA_MAX_SIZE		16385
> @@ -243,13 +255,13 @@ qdma_ccdf_get_offset(const struct fsl_qd
>  static inline void
>  qdma_ccdf_set_format(struct fsl_qdma_format *ccdf, int offset)
>  {
> -	ccdf->cfg = cpu_to_le32(QDMA_CCDF_FOTMAT | offset);
> +	ccdf->cfg = cpu_to_le32(QDMA_CCDF_FORMAT | (offset << QDMA_CCDF_OFFSET));
>  }
>  
>  static inline int
>  qdma_ccdf_get_status(const struct fsl_qdma_format *ccdf)
>  {
> -	return (le32_to_cpu(ccdf->status) & QDMA_CCDF_MASK) >> QDMA_CCDF_STATUS;
> +	return (le32_to_cpu(ccdf->status) & QDMA_CCDF_STATUS_MASK);
>  }
>  
>  static inline void
> @@ -618,6 +630,7 @@ fsl_qdma_queue_transfer_complete(struct
>  {
>  	bool duplicate;
>  	u32 reg, i, count;
> +	u8 completion_status;
>  	struct fsl_qdma_queue *temp_queue;
>  	struct fsl_qdma_format *status_addr;
>  	struct fsl_qdma_comp *fsl_comp = NULL;
> @@ -677,6 +690,8 @@ fsl_qdma_queue_transfer_complete(struct
>  		}
>  		list_del(&fsl_comp->list);
>  
> +		completion_status = qdma_ccdf_get_status(status_addr);
> +
>  		reg = qdma_readl(fsl_qdma, block + FSL_QDMA_BSQMR);
>  		reg |= FSL_QDMA_BSQMR_DI;
>  		qdma_desc_addr_set64(status_addr, 0x0);
> @@ -686,6 +701,24 @@ fsl_qdma_queue_transfer_complete(struct
>  		qdma_writel(fsl_qdma, reg, block + FSL_QDMA_BSQMR);
>  		spin_unlock(&temp_queue->queue_lock);
>  
> +		/* The completion_status is evaluated here (outside of spin lock) */
> +		if (completion_status) {
> +			if (completion_status & QDMA_CCDF_STATUS_WTE) {
> +				/* Write transaction error */
> +				fsl_comp->vdesc.tx_result.result = DMA_TRANS_WRITE_FAILED;
> +			}

this brace should be with else if line. See
Documentation/process/coding-style.rst and do run
./scripts/checkpatch.pl --strict for this patch (i see few other style
issues)

> +			else if (completion_status & QDMA_CCDF_STATUS_RTE) {
> +				/* Read transaction error */
> +				fsl_comp->vdesc.tx_result.result = DMA_TRANS_READ_FAILED;
> +			}
> +			else {
> +				/* Command/source/destination description error */
> +				fsl_comp->vdesc.tx_result.result = DMA_TRANS_ABORTED;
> +				dev_err(fsl_qdma->dma_dev.dev, "DMA status descriptor error %x\n",
> +						completion_status);
> +			}

So completion status always mean error? when does it indicate success,
when not set?

> +		}
> +
>  		spin_lock(&fsl_comp->qchan->vchan.lock);
>  		vchan_cookie_complete(&fsl_comp->vdesc);
>  		fsl_comp->qchan->status = DMA_COMPLETE;
> @@ -704,7 +737,14 @@ static irqreturn_t fsl_qdma_error_handle
>  	intr = qdma_readl(fsl_qdma, status + FSL_QDMA_DEDR);
>  
>  	if (intr)
> -		dev_err(fsl_qdma->dma_dev.dev, "DMA transaction error!\n");
> +	{

style error!

> +		unsigned int decfdw0r = qdma_readl(fsl_qdma, status + FSL_QDMA_DECFDW0R);
> +		unsigned int decfdw1r = qdma_readl(fsl_qdma, status + FSL_QDMA_DECFDW1R);
> +		unsigned int decfdw2r = qdma_readl(fsl_qdma, status + FSL_QDMA_DECFDW2R);
> +		unsigned int decfdw3r = qdma_readl(fsl_qdma, status + FSL_QDMA_DECFDW3R);
> +		dev_err(fsl_qdma->dma_dev.dev, "DMA transaction error! (%x: %x-%x-%x-%x)\n",
> +				intr, decfdw0r, decfdw1r, decfdw2r, decfdw3r);
> +	}
>  
>  	qdma_writel(fsl_qdma, FSL_QDMA_DEDR_CLEAR, status + FSL_QDMA_DEDR);
>  	return IRQ_HANDLED;

-- 
~Vinod
