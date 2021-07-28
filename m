Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912A63D88C4
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 09:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhG1HXB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 03:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231949AbhG1HXB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 03:23:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CD6D60F00;
        Wed, 28 Jul 2021 07:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627456980;
        bh=EDBmXlbmP6Xd5Bp59xQuv5zXXYXGXlS1g1brWU8FTTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TrZ0IW2GT9SzRYSMOfUn3GaQhDLFTZIYW84Skg5CIRcudI80iuq0OCvBSdbtrPJ89
         mRMkxMf87yHT4TaHr3X2IaffVX4zQHvkjJcH4PNT+LwAu/v4OGSaSmBF66L92f1lvD
         CSe/vmbHiZ8n/yO3LZv8hfczRgqofNwvpOhuuIeHZFSFzcMx/WUV3cuYKdg/KFipio
         TK3DZzUmnYQN2W+dXyKjvgat/sr2THgD+kjlKC+bMgKJTcc8JEhVxFMlQM8KkwfQh5
         ESt+CwVjbqkwRf84YKhPEp0aZwoPrc7vX5yPreIiQNwzFBuqyKdutkQ8hYwWWLYzrb
         pWwt5ut8Q1XNg==
Date:   Wed, 28 Jul 2021 12:52:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     pandith.n@intel.com
Cc:     Eugeniy.Paltsev@synopsys.com, dmaengine@vger.kernel.org,
        lakshmi.bai.raja.subramanian@intel.com, kris.pan@intel.com,
        mallikarjunappa.sangannavar@intel.com, Srikanth.Thokala@intel.com
Subject: Re: [PATCH V4 1/3] dmaengine: dw-axi-dmac: Remove free slot check
 algorithm in dw_axi_dma_set_hw_channel
Message-ID: <YQEFzyJnXvQg/uh9@matsya>
References: <20210720174713.13282-1-pandith.n@intel.com>
 <20210720174713.13282-2-pandith.n@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720174713.13282-2-pandith.n@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-07-21, 23:17, pandith.n@intel.com wrote:
> From: Pandith N <pandith.n@intel.com>
> 
> Removed free slot check algorithm in dw_axi_dma_set_hw_channel. For 8
> DMA channels, use respective handshake slot in DMA_HS_SEL APB register.
> 
> For every channel, an dedicated slot is provided in  hardware handshake
> register AXIDMA_CTRL_DMA_HS_SEL_n. Peripheral source number is
> programmed in respective channel slots.
> 
> Signed-off-by: Pandith N <pandith.n@intel.com>
> Tested-by: Pan Kris <kris.pan@intel.com>
> ---
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 49 +++++++------------
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  2 +
>  2 files changed, 21 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index d9e4ac3edb4e..6b871e20ae27 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -470,19 +470,14 @@ static void dma_chan_free_chan_resources(struct dma_chan *dchan)
>  	pm_runtime_put(chan->chip->dev);
>  }
>  
> -static void dw_axi_dma_set_hw_channel(struct axi_dma_chip *chip,
> -				      u32 handshake_num, bool set)
> +static int dw_axi_dma_set_hw_channel(struct axi_dma_chan *chan, bool set)

what is point of returning error if that is not checked and action taken
in caller?

>  {
> -	unsigned long start = 0;
> -	unsigned long reg_value;
> -	unsigned long reg_mask;
> -	unsigned long reg_set;
> -	unsigned long mask;
> -	unsigned long val;
> +	struct axi_dma_chip *chip = chan->chip;
> +	unsigned long reg_value, val;
>  
>  	if (!chip->apb_regs) {
>  		dev_dbg(chip->dev, "apb_regs not initialized\n");
> -		return;
> +		return -EINVAL;

should the above log not be error now?
-- 
~Vinod
