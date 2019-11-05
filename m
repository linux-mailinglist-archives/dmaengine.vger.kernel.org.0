Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27BDDF0452
	for <lists+dmaengine@lfdr.de>; Tue,  5 Nov 2019 18:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390510AbfKERs3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Nov 2019 12:48:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390344AbfKERs3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 5 Nov 2019 12:48:29 -0500
Received: from localhost (unknown [106.51.111.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA43217F5;
        Tue,  5 Nov 2019 17:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572976107;
        bh=rqSz4Ho15VHI287QiYSiRFPVKKVZZLoCGHIbRvCiBlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S41kQmvjld7nCfq9WET/5YTWrj36zgoRns3WYyXz/7XZZr00Ju4fGSAn30gpIoInN
         MJuxjyMCiV6ZMlyx7RAgtgM45Ye/uJtmuTKSxMVKVIoGtaGQf3Kpl5c23xr6QOoC0X
         13r6IMu7pFy06qapwaXk5Ht1OfE+xgZFyUTBO1XA=
Date:   Tue, 5 Nov 2019 23:18:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Green Wan <green.wan@sifive.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Yash Shah <yash.shah@sifive.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] dmaengine: sf-pdma: add platform DMA support for
 HiFive Unleashed A00
Message-ID: <20191105174823.GF952516@vkoul-mobl>
References: <20191028075658.12143-1-green.wan@sifive.com>
 <20191028075658.12143-4-green.wan@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028075658.12143-4-green.wan@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-10-19, 15:56, Green Wan wrote:
> Add PDMA driver, sf-pdma, to enable DMA engine on HiFive Unleashed
> Rev A00 board.
> 
>  - Implement dmaengine APIs, support MEM_TO_MEM async copy.
>  - Tested by DMA Test client
>  - Supports 4 channels DMA, each channel has 1 done and 1 err
>    interrupt connected to platform-level interrupt controller (PLIC).
>  - Depends on DMA_ENGINE and DMA_VIRTUAL_CHANNELS
> 
> The datasheet is here:
> 
>   https://static.dev.sifive.com/FU540-C000-v1.0.pdf
> 
> Follow the DMAengine controller doc,
> "./Documentation/driver-api/dmaengine/provider.rst" to implement DMA
> engine. And use the dma test client in doc,
> "./Documentation/driver-api/dmaengine/dmatest.rst", to test.
> 
> Each DMA channel has separate HW regs and support done and error ISRs.
> 4 channels share 1 done and 1 err ISRs. There's no expander/arbitrator
> in DMA HW.
> 
>    ------               ------
>    |    |--< done 23 >--|ch 0|
>    |    |--< err  24 >--|    |     (dma0chan0)
>    |    |               ------
>    |    |               ------
>    |    |--< done 25 >--|ch 1|
>    |    |--< err  26 >--|    |     (dma0chan1)
>    |PLIC|               ------
>    |    |               ------
>    |    |--< done 27 >--|ch 2|
>    |    |--< err  28 >--|    |     (dma0chan2)
>    |    |               ------
>    |    |               ------
>    |    |--< done 29 >--|ch 3|
>    |    |--< err  30 >--|    |     (dma0chan3)
>    ------               ------
> 
> Reviewed-by: Vinod Koul <vkoul@kernel.org>

when did i provide this?

> Signed-off-by: Green Wan <green.wan@sifive.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 31c3b98b5a01 ("dmaengine: sf-pdma: add platform DMA support for HiFive Unleashed A00")

Fixes what... this is not a upstream commit?

> Signed-off-by: kbuild test robot <lkp@intel.com>
> ---

Please list the changes done from prev version, here or in cover letter

> +static struct sf_pdma_desc *sf_pdma_alloc_desc(struct sf_pdma_chan *chan)
> +{
> +	struct sf_pdma_desc *desc;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&chan->lock, flags);
> +
> +	if (chan->desc && !chan->desc->in_use) {
> +		spin_unlock_irqrestore(&chan->lock, flags);
> +		return chan->desc;
> +	}
> +
> +	spin_unlock_irqrestore(&chan->lock, flags);
> +
> +	desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
> +

this empty line in not required

> +static struct dma_async_tx_descriptor *
> +	sf_pdma_prep_dma_memcpy(struct dma_chan *dchan,
> +				dma_addr_t dest,

please make it left justified

> +static int sf_pdma_slave_config(struct dma_chan *dchan,
> +				struct dma_slave_config *cfg)
> +{
> +	struct sf_pdma_chan *chan = to_sf_pdma_chan(dchan);
> +
> +	memcpy(&chan->cfg, cfg, sizeof(*cfg));
> +	chan->dma_dir = DMA_MEM_TO_MEM;

?? looking at changelog we have only memcpy support, so this should not
be here, pls remove this.

> +static enum dma_status
> +sf_pdma_tx_status(struct dma_chan *dchan,
> +		  dma_cookie_t cookie,
> +		  struct dma_tx_state *txstate)
> +{
> +	struct sf_pdma_chan *chan = to_sf_pdma_chan(dchan);
> +	enum dma_status status;
> +
> +	status = dma_cookie_status(dchan, cookie, txstate);
> +
> +	if (txstate && status != DMA_ERROR)
> +		dma_set_residue(txstate, sf_pdma_desc_residue(chan));

which residue? the query can be for a cookie which is still in pending
list! you need to check the cookie and only read register for cookie if
submitted

> +static int sf_pdma_remove(struct platform_device *pdev)
> +{
> +	struct sf_pdma *pdma = platform_get_drvdata(pdev);
> +	struct sf_pdma_chan *ch;
> +	int i;
> +
> +	for (i = 0; i < PDMA_NR_CH; i++) {
> +		ch = &pdma->chans[i];
> +
> +		list_del(&ch->vchan.chan.device_node);
> +		tasklet_kill(&ch->vchan.task);
> +		tasklet_kill(&ch->done_tasklet);
> +		tasklet_kill(&ch->err_tasklet);

you have an isr registered which can fire and schedule tasklets..
-- 
~Vinod
