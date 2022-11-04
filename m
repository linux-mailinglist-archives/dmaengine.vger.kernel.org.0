Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412D361963B
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 13:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiKDM35 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 08:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiKDM3z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 08:29:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E3F29362;
        Fri,  4 Nov 2022 05:29:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ED286216F;
        Fri,  4 Nov 2022 12:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E674C433C1;
        Fri,  4 Nov 2022 12:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667564990;
        bh=dRXXq1WtmtcofcC4LTzQfmWTAewk8R7MhRb3YRAQETg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JAhkp7ssChjDv9VUrE/ZQH8dUrKIDApMAcZT/aWq2t+eim5M8GnbEWnm46NqmYv76
         r2oXS7iOympLpU2fvUAR0kE0DwPsuDjQhmT2aDvSoyiDHqHQBy+kt3mlpB457bZOE+
         glSbMF6AXqU4h1B+yqOuR7dn+llKG3ag5kMyFLGIqKDW31u5gTyKisBFoUOGCofhQY
         BEIOHeelIe/w0cPmDgZ+Y+SHt3cLx8aIpeJChPN/NOp7k3IspH1cLh6HBY2Zm/XJOT
         NVDc9H3PWmoQuXY67a+73K0TdV92emufEINYsI9Q7Vuj7pxpHZyiArpNuLoNLZWslu
         NYaXfoEn3B9EA==
Date:   Fri, 4 Nov 2022 17:59:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sireesh Kodali <sireeshkodali1@gmail.com>
Cc:     andersson@kernel.org, agross@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] dmaengine: qcom: bam_dma: Add support for metadata
Message-ID: <Y2UFuvg5sq9tLf83@matsya>
References: <20221027052007.47403-1-sireeshkodali1@gmail.com>
 <20221027052007.47403-2-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027052007.47403-2-sireeshkodali1@gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-10-22, 10:50, Sireesh Kodali wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> Add client metadata support for receiving information about transfers.
> Only type of metadata implemented is amount of transferred bytes. This
> can be used to know how much data is actually received if information
> transferred doesn't contain header with size or is aggregated.
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> ---
>  drivers/dma/qcom/bam_dma.c       | 57 ++++++++++++++++++++++++++++++++
>  include/linux/dma/qcom_bam_dma.h |  8 +++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 3135a3e4a167..264a9a2e199f 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -30,6 +30,7 @@
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dma/qcom_bam_dma.h>
>  #include <linux/scatterlist.h>
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
> @@ -70,6 +71,7 @@ struct bam_async_desc {
>  	u16 flags;
>  
>  	struct bam_desc_hw *curr_desc;
> +	struct bam_dma_metadata *metadata;
>  
>  	/* list node for the desc in the bam_chan list of descriptors */
>  	struct list_head desc_node;
> @@ -418,6 +420,52 @@ static inline void __iomem *bam_addr(struct bam_device *bdev, u32 pipe,
>  		r.ee_mult * bdev->ee;
>  }
>  
> +/**
> + * bam_update_metadata - update metadata buffer
> + * @bchan: BAM channel to read metadata from
> + * @async_desc: BAM async descriptior
> + *
> + * Updates metadata buffer (transfer size) based on values
> + * read from FIFO descriptors at bchan->head
> + */
> +
> +static inline void bam_update_metadata(struct bam_chan *bchan,
> +				       struct bam_async_desc *async_desc)
> +{
> +	unsigned int i, e, len = 0;
> +	struct bam_desc_hw *fifo;
> +
> +	if (!async_desc->metadata)
> +		return;
> +
> +	fifo = PTR_ALIGN(bchan->fifo_virt, sizeof(struct bam_desc_hw));
> +	for (i = bchan->head, e = i + async_desc->xfer_len; i < e; i++)
> +		len += fifo[i % MAX_DESCRIPTORS].size;
> +
> +	async_desc->metadata->xfer_len_bytes += len;
> +}
> +
> +/**
> + * bam_attach_metadata - attach metadata buffer to the async descriptor
> + * @desc: async descriptor
> + * @data: buffer pointer
> + * @len: length of passed buffer
> + */
> +static int bam_attach_metadata(struct dma_async_tx_descriptor *desc, void *data,
> +			       size_t len)
> +{
> +	struct bam_async_desc *async_desc;
> +
> +	if (!data || len != sizeof(struct bam_dma_metadata))
> +		return -EINVAL;
> +
> +	async_desc = container_of(desc, struct bam_async_desc, vd.tx);
> +	async_desc->metadata = data;
> +	async_desc->metadata->xfer_len_bytes = 0;
> +
> +	return 0;
> +}
> +
>  /**
>   * bam_reset() - reset and initialize BAM registers
>   * @bdev: bam device
> @@ -456,6 +504,10 @@ static void bam_reset(struct bam_device *bdev)
>  	writel_relaxed(BAM_IRQ_MSK, bam_addr(bdev, 0, BAM_IRQ_SRCS_MSK_EE));
>  }
>  
> +static struct dma_descriptor_metadata_ops metadata_ops = {
> +	.attach = bam_attach_metadata,
> +};
> +
>  /**
>   * bam_reset_channel - Reset individual BAM DMA channel
>   * @bchan: bam channel
> @@ -714,6 +766,8 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
>  		} while (remainder > 0);
>  	}
>  
> +	async_desc->vd.tx.metadata_ops = &metadata_ops;
> +
>  	return vchan_tx_prep(&bchan->vc, &async_desc->vd, flags);
>  }
>  
> @@ -867,6 +921,8 @@ static u32 process_channel_irqs(struct bam_device *bdev)
>  			if (avail < async_desc->xfer_len)
>  				break;
>  
> +			bam_update_metadata(bchan, async_desc);
> +
>  			/* manage FIFO */
>  			bchan->head += async_desc->xfer_len;
>  			bchan->head %= MAX_DESCRIPTORS;
> @@ -1347,6 +1403,7 @@ static int bam_dma_probe(struct platform_device *pdev)
>  	bdev->common.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
>  	bdev->common.src_addr_widths = DMA_SLAVE_BUSWIDTH_4_BYTES;
>  	bdev->common.dst_addr_widths = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	bdev->common.desc_metadata_modes = DESC_METADATA_CLIENT;
>  	bdev->common.device_alloc_chan_resources = bam_alloc_chan;
>  	bdev->common.device_free_chan_resources = bam_free_chan;
>  	bdev->common.device_prep_slave_sg = bam_prep_slave_sg;
> diff --git a/include/linux/dma/qcom_bam_dma.h b/include/linux/dma/qcom_bam_dma.h
> index 68fc0e643b1b..8168b0573f45 100644
> --- a/include/linux/dma/qcom_bam_dma.h
> +++ b/include/linux/dma/qcom_bam_dma.h
> @@ -8,6 +8,14 @@
>  
>  #include <asm/byteorder.h>
>  
> +/*
> + * This data type is used as client metadata buffer in bam driver.
> + */
> +struct bam_dma_metadata {
> +	/* Actual number of bytes transferred by hardware */
> +	size_t xfer_len_bytes;

Pls implement dmaengine_result() and report that with proper residue
set...

Thanks

-- 
~Vinod
