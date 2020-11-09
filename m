Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36AD2AB3FC
	for <lists+dmaengine@lfdr.de>; Mon,  9 Nov 2020 10:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgKIJvV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 04:51:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgKIJvU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Nov 2020 04:51:20 -0500
Received: from localhost (unknown [122.171.147.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09E3C2067B;
        Mon,  9 Nov 2020 09:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604915480;
        bh=J8ZtzV9PxdarTa9B5TSlOWHmWZ3DYcHZro6XdfuNMJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XSQ6GxkYgGbtHuTMgdVMGjgyQKFh8eVQKB+YqoxbdnukYjNYSBEB89ng4O77vuMFD
         dEs02/3wJ2IcImaB/cT4v99ehGdtmxsHk7LvWoyBm85fAyuC5J4BkGqd0aW5VfxCWl
         CP5a6A0geGYDBoJI9jataDrWX+axYbHiKxAOR5dY=
Date:   Mon, 9 Nov 2020 15:21:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sia Jee Heng <jee.heng.sia@intel.com>
Cc:     Eugeniy.Paltsev@synopsys.com, andriy.shevchenko@linux.intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/15] dmaengine: dw-axi-dmac: Support burst residue
 granularity
Message-ID: <20201109095115.GD3171@vkoul-mobl>
References: <20201027063858.4877-1-jee.heng.sia@intel.com>
 <20201027063858.4877-10-jee.heng.sia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027063858.4877-10-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-10-20, 14:38, Sia Jee Heng wrote:
> Add support for DMA_RESIDUE_GRANULARITY_BURST so that AxiDMA can report
> DMA residue.
> 
> Existing AxiDMA driver only support data transfer between
> memory to memory operation, therefore reporting DMA residue
> to the DMA clients is not supported.
> 
> Reporting DMA residue to the DMA clients is important as DMA clients
> shall invoke dmaengine_tx_status() to understand the number of bytes
> been transferred so that the buffer pointer can be updated accordingly.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> ---
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 44 ++++++++++++++++---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  2 +
>  2 files changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 011cf7134f25..cd99557a716c 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -265,14 +265,36 @@ dma_chan_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
>  		  struct dma_tx_state *txstate)
>  {
>  	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
> -	enum dma_status ret;
> +	struct virt_dma_desc *vdesc;
> +	enum dma_status status;
> +	u32 completed_length;
> +	unsigned long flags;
> +	u32 completed_blocks;
> +	size_t bytes = 0;
> +	u32 length;
> +	u32 len;
>  
> -	ret = dma_cookie_status(dchan, cookie, txstate);
> +	status = dma_cookie_status(dchan, cookie, txstate);

txstate can be null, so please check that as well in the below condition
and return if that is the case

-- 
~Vinod
