Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548BC2DFA68
	for <lists+dmaengine@lfdr.de>; Mon, 21 Dec 2020 10:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgLUJs6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Dec 2020 04:48:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:37294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbgLUJr5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 21 Dec 2020 04:47:57 -0500
Date:   Mon, 21 Dec 2020 14:53:55 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608542640;
        bh=JO4ab5ou5wn2IYemAu40S3kxk97Cbr2moLnttUGZi3k=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=OliryD7qqLmTqyoCTX6dzKbEVI2tjG+ledbsd0RWvXKG8A/KHGORZlnpNDKWkv0Wg
         9ECU3LxcuWvxzrUcVc7REh/qTu1UGETQSsCOa8Ii2YUXE8Xez/WK/nw7esWPl9Vq7j
         VVPm4txLNd/Xn/u+tT+WUE6Y3ByL4N+a3JhJBrNGs2yROsTuhaBFGu/XfzJMWvok7i
         sc0qmk+08Asn6kgIJ4wudG9n2URG9y/tDJKJgFZK6mUD5RRuJP2xGLZYWNFTWnzi77
         pSUgqMmMJZ36iRCOfqfusv7qq+21JEJTvchTilRnH8iAn8yhE3xHEX7XafyKloTPCq
         uwkgSKJRNoHsQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     corbet@lwn.net, agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Add LOCK and UNLOCK flag bit
 support
Message-ID: <20201221092355.GA3323@vkoul-mobl>
References: <1608215842-15381-1-git-send-email-mdalam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608215842-15381-1-git-send-email-mdalam@codeaurora.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

On 17-12-20, 20:07, Md Sadre Alam wrote:
> This change will add support for LOCK & UNLOCK flag bit support
> on CMD descriptor.
> 
> If DMA_PREP_LOCK flag passed in prep_slave_sg then requester of this
> transaction wanted to lock the DMA controller for this transaction so
> BAM driver should set LOCK bit for the HW descriptor.
> 
> If DMA_PREP_UNLOCK flag passed in prep_slave_sg then requester of this
> transaction wanted to unlock the DMA controller.so BAM driver should set
> UNLOCK bit for the HW descriptor.

Can you explain why would we need to first lock and then unlock..? How
would this be used in real world.

I have read a bit of documentation but is unclear to me. Also should
this be exposed as an API to users, sounds like internal to driver..?


> 
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> ---
>  Documentation/driver-api/dmaengine/provider.rst | 9 +++++++++
>  drivers/dma/qcom/bam_dma.c                      | 9 +++++++++
>  include/linux/dmaengine.h                       | 5 +++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
> index ddb0a81..d7516e2 100644
> --- a/Documentation/driver-api/dmaengine/provider.rst
> +++ b/Documentation/driver-api/dmaengine/provider.rst
> @@ -599,6 +599,15 @@ DMA_CTRL_REUSE
>    - This flag is only supported if the channel reports the DMA_LOAD_EOT
>      capability.
>  
> +- DMA_PREP_LOCK
> +
> +  - If set , the client driver tells DMA controller I am locking you for
> +    this transcation.
> +
> +- DMA_PREP_UNLOCK
> +
> +  - If set, the client driver will tells DMA controller I am releasing the lock
> +
>  General Design Notes
>  ====================
>  
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 4eeb8bb..cdbe395 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -58,6 +58,8 @@ struct bam_desc_hw {
>  #define DESC_FLAG_EOB BIT(13)
>  #define DESC_FLAG_NWD BIT(12)
>  #define DESC_FLAG_CMD BIT(11)
> +#define DESC_FLAG_LOCK BIT(10)
> +#define DESC_FLAG_UNLOCK BIT(9)
>  
>  struct bam_async_desc {
>  	struct virt_dma_desc vd;
> @@ -644,6 +646,13 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
>  
>  	/* fill in temporary descriptors */
>  	desc = async_desc->desc;
> +	if (flags & DMA_PREP_CMD) {
> +		if (flags & DMA_PREP_LOCK)
> +			desc->flags |= cpu_to_le16(DESC_FLAG_LOCK);
> +		if (flags & DMA_PREP_UNLOCK)
> +			desc->flags |= cpu_to_le16(DESC_FLAG_UNLOCK);
> +	}
> +
>  	for_each_sg(sgl, sg, sg_len, i) {
>  		unsigned int remainder = sg_dma_len(sg);
>  		unsigned int curr_offset = 0;
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index dd357a7..79ccadb4 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -190,6 +190,9 @@ struct dma_interleaved_template {
>   *  transaction is marked with DMA_PREP_REPEAT will cause the new transaction
>   *  to never be processed and stay in the issued queue forever. The flag is
>   *  ignored if the previous transaction is not a repeated transaction.
> + * @DMA_PREP_LOCK: tell the driver that DMA HW engine going to be locked for this
> + *  transaction , until not seen DMA_PREP_UNLOCK flag set.
> + * @DMA_PREP_UNLOCK: tell the driver to unlock the DMA HW engine.
>   */
>  enum dma_ctrl_flags {
>  	DMA_PREP_INTERRUPT = (1 << 0),
> @@ -202,6 +205,8 @@ enum dma_ctrl_flags {
>  	DMA_PREP_CMD = (1 << 7),
>  	DMA_PREP_REPEAT = (1 << 8),
>  	DMA_PREP_LOAD_EOT = (1 << 9),
> +	DMA_PREP_LOCK = (1 << 10),
> +	DMA_PREP_UNLOCK = (1 << 11),
>  };
>  
>  /**
> -- 
> 2.7.4

-- 
~Vinod
