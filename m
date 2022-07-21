Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A31857CAA4
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 14:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiGUMal (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 08:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiGUMal (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 08:30:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC3C14D22;
        Thu, 21 Jul 2022 05:30:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB15261D98;
        Thu, 21 Jul 2022 12:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4191C3411E;
        Thu, 21 Jul 2022 12:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658406639;
        bh=dFRiU4koNQsq+vUuGsVDzGLGakrGxvr8LNada/b39kA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9ofnqip/ahIlM7ZD1DavDXskZosh/aXVOyYZ82hU+XBsSL/zNoEtU4YxwY6Dkw8J
         63aSghHs5Wz0TdWmVk0pPSH1VS105AUTZ6JVQnl9RqZdyOrOSvQ2pJiF09VJF4iuI6
         /xqQue8XXLLBP6X2zRZ5MrMug8pKUAbQi/coUDhIJN387MmX7JbfDdiU+neoLShZ16
         4/Cdy+NJsO/INqvy8q3ACgKkBzgj8nczyBeNqNVdWWUxKxwjgK2a3r6GRnNC9ERQve
         K82KLY/b+qtGHl6qMNFQ+4CepaDBHUrgQqrUVbkFTs/2fAiGM4cJcMoiweY9fgPzg/
         dJYTpH9nln+SQ==
Date:   Thu, 21 Jul 2022 18:00:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     dmaengine@vger.kernel.org, Eugeniy.Paltsev@synopsys.com,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: Re: [PATCH 1/3] dmaengine: dw-axi-dmac: dump channel registers on
 error
Message-ID: <YtlG6hdTJPIDBk9Y@matsya>
References: <20220708170153.269991-1-ben.dooks@sifive.com>
 <20220708170153.269991-2-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708170153.269991-2-ben.dooks@sifive.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-07-22, 18:01, Ben Dooks wrote:
> On channel error, dump the channel register state before
> the channel's LLI entries to see what the controller was
> actually doing when the error happend.
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index e9c9bcb1f5c2..75c537153e92 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -79,6 +79,20 @@ axi_chan_iowrite64(struct axi_dma_chan *chan, u32 reg, u64 val)
>  	iowrite32(upper_32_bits(val), chan->chan_regs + reg + 4);
>  }
>  
> +static inline u64
> +axi_chan_ioread64(struct axi_dma_chan *chan, u32 reg)
> +{
> +	u32 high, low;
> +	u64 result;
> +
> +	low = ioread32(chan->chan_regs + reg);
> +	high = ioread32(chan->chan_regs + reg + 4);
> +
> +	result = low;
> +	result |= (u64)high << 32;
> +	return result;
> +}

Better to use helpers like lo_hi_readq()?

> +
>  static inline void axi_chan_config_write(struct axi_dma_chan *chan,
>  					 struct axi_dma_chan_config *config)
>  {
> @@ -979,6 +993,18 @@ static int dw_axi_dma_chan_slave_config(struct dma_chan *dchan,
>  	return 0;
>  }
>  
> +static void axi_chan_dump_regs(struct axi_dma_chan *chan)
> +{
> +	dev_err(dchan2dev(&chan->vc.chan),
> +		"R: SAR: 0x%llx DAR: 0x%llx LLP: 0x%llx BTS 0x%x CTL: 0x%x:%08x\n",
> +		axi_chan_ioread64(chan, CH_SAR),
> +		axi_chan_ioread64(chan, CH_DAR),
> +		axi_chan_ioread64(chan, CH_LLP),
> +		axi_chan_ioread32(chan, CH_BLOCK_TS),
> +		axi_chan_ioread32(chan, CH_CTL_H),
> +		axi_chan_ioread32(chan, CH_CTL_L));
> +}
> +
>  static void axi_chan_dump_lli(struct axi_dma_chan *chan,
>  			      struct axi_dma_hw_desc *desc)
>  {
> @@ -1020,6 +1046,8 @@ static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
>  	dev_err(chan2dev(chan),
>  		"Bad descriptor submitted for %s, cookie: %d, irq: 0x%08x\n",
>  		axi_chan_name(chan), vd->tx.cookie, status);
> +
> +	axi_chan_dump_regs(chan);
>  	axi_chan_list_dump_lli(chan, vd_to_axi_desc(vd));
>  
>  	vchan_cookie_complete(vd);
> -- 
> 2.35.1

-- 
~Vinod
