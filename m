Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7BA7BD2D5
	for <lists+dmaengine@lfdr.de>; Mon,  9 Oct 2023 07:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345108AbjJIFiW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Oct 2023 01:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345049AbjJIFiV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Oct 2023 01:38:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4619E;
        Sun,  8 Oct 2023 22:38:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01C4C433C7;
        Mon,  9 Oct 2023 05:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696829899;
        bh=94byP8ietls/5mIzLClS8+CihfeMV58zSREKNeczpCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l0MfWOxvfEWDZMsbSHJPSNf+ElS6wVx6szorg9qy2Caanj7yuXak6mouFETE+dME7
         EVkNVlzLvvv1lWyDy7Z6FYOzeY4DvJs7M++8eV0EAMLbFbmTr4PKhaxKLiviCaD8ud
         tESRKgAnwSlq8hOIKVdhwANTXTBxfuT0e9Bf3KwKGQH2aCsAo9ZCOqi4E9HoT7abdt
         JoL8inff9KRGrCBnFQS3s9EhWdaEbzBFovwvQP4AL7K4Rb7777wHVf5yNrUMIhQsP1
         52T6OANvn7qe6WcbV/1u+37oi0YxAu+yXRrAHy0XiAzNt+u8v1q+8B0IZGNpOn6KRg
         n8ea3NDQOc6Jw==
Date:   Mon, 9 Oct 2023 11:08:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kelvin.Cao@microchip.com
Cc:     dmaengine@vger.kernel.org, George.Ge@microchip.com,
        logang@deltatee.com, christophe.jaillet@wanadoo.fr,
        hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Message-ID: <ZSORx0SwTerzlasY@matsya>
References: <20230728200327.96496-1-kelvin.cao@microchip.com>
 <20230728200327.96496-2-kelvin.cao@microchip.com>
 <ZMlSLXaYaMry7ioA@matsya>
 <fd597a2a71f1c5146c804bb9fce3495864212d69.camel@microchip.com>
 <b0dc3da623dee479386e7cb75841b8b7913c9890.camel@microchip.com>
 <ZR/htuZSKGJP1wgU@matsya>
 <f72b924b8c51a7768b0748848555e395ecbb32eb.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f72b924b8c51a7768b0748848555e395ecbb32eb.camel@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-10-23, 22:34, Kelvin.Cao@microchip.com wrote:
> On Fri, 2023-10-06 at 16:00 +0530, Vinod Koul wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > On 05-10-23, 18:35, Kelvin.Cao@microchip.com wrote:
> > 
> > > > > > +static struct dma_async_tx_descriptor *
> > > > > > +switchtec_dma_prep_wimm_data(struct dma_chan *c, dma_addr_t
> > > > > > dma_dst, u64 data,
> > > > > > +                          unsigned long flags)
> > > > > 
> > > > > can you please explain what this wimm data refers to...
> > > > > 
> > > > > I think adding imm callback was a mistake, we need a better
> > > > > justification for another user for this, who programs this,
> > > > > what
> > > > > gets
> > > > > programmed here
> > > > 
> > > > Sure. I think it's an alternative method to prep_mem and would be
> > > > more
> > > > convenient to use when the write is 8-byte and the data to be
> > > > moved
> > > > is
> > > > not in a DMA mapped memory location. For example, we write to a
> > > > doorbell register with the value from a local variable which is
> > > > not
> > > > associated with a DMA address to notify the receiver to consume
> > > > the
> > > > data, after confirming that the previously initiated DMA
> > > > transactions
> > > > of the data have completed. I agree that the use scenario would
> > > > be
> > > > very
> > > > limited.
> > 
> > Can you please explain more about this 'value' where is it derived
> > from?
> > Who programs it and how...
> 
> Sure. Think of a producer/consumer use case where the producer is a
> host DMA client driver and the consumer is a PCIe EP. On the EP, there

What are the examples of DMA clients here?

> is a memory-mapped data buffer for data receiving and a memory-mapped
> doorbell buffer for triggering data consuming. Each time for a bulk
> data transfer, the DMA client driver first DMA the data of size X to
> the memory-mapped data buffer, then it DMA the value X to the doorbell
> buffer to trigger data consumption on device. On receiving a doorbell
> writing, the device starts to consume the data of size X from the data
> buffer.  
> 
> For the first DMA operation, the DMA client would use dma_prep_memory()
> like what most DMA clients do. However, for the second transfer, value
> X is held in a local variable like below.
> 
> u64 size_to_transfer;

Why cant the client driver write to doorbell, is there anything which
prevents us from doing so?

> 
> In this case, the client would use dma_prep_wimm_data() to DMA value X
> to the doorbell buffer, like below.
> 
> dma_prep_wimm_data(chan, dst_for_db_buffer, size_to_transfer, flag); 
> 
> Hope this example explains the thing. People would argue that the
> client could use the same dma_prep_memory() for the doorbell ringing. I
> would agree, this API just adds an alternative way to do so when the
> data is as little as 64 bit and it also saves a call site to
> dma_alloc_coherent() to allocate a source DMA buffer just for holding
> the 8-byte value, which is required by dma_prep_memcpy().

I would prefer that, (after the option of mmio write from client), there
is nothing special about this, another txn. You can queue up both and
have dmaengine write to doorbell immediately after the buffer completes

>  
> 
> > > > > > +     /* set sq/cq */
> > > > > > +     writel(lower_32_bits(swdma_chan->dma_addr_sq),
> > > > > > &chan_fw-
> > > > > > > sq_base_lo);
> > > > > > +     writel(upper_32_bits(swdma_chan->dma_addr_sq),
> > > > > > &chan_fw-
> > > > > > > sq_base_hi);
> > > > > > +     writel(lower_32_bits(swdma_chan->dma_addr_cq),
> > > > > > &chan_fw-
> > > > > > > cq_base_lo);
> > > > > > +     writel(upper_32_bits(swdma_chan->dma_addr_cq),
> > > > > > &chan_fw-
> > > > > > > cq_base_hi);
> > > > > > +
> > > > > > +     writew(SWITCHTEC_DMA_SQ_SIZE, &swdma_chan-
> > > > > > >mmio_chan_fw-
> > > > > > > sq_size);
> > > > > > +     writew(SWITCHTEC_DMA_CQ_SIZE, &swdma_chan-
> > > > > > >mmio_chan_fw-
> > > > > > > cq_size);
> > > > > 
> > > > > what is write happening in the descriptor alloc callback, that
> > > > > does
> > > > > not
> > > > > sound correct to me
> > > > 
> > > > All the queue descriptors of a channel are pre-allocated, so I
> > > > think
> > > > it's proper to convey the queue address/size to hardware at this
> > > > point.
> > > > After this initialization, we only need to assign cookie in
> > > > submit
> > > > and
> > > > update queue head to hardware in issue_pending.
> > 
> > Sorry that is not right, you can prepare multiple descriptors and
> > then
> > submit. Only at submit is the cookie assigned which is in order, so
> > this
> > should be moved to when we start the txn and not in this call
> > 
> The hardware assumes the SQ/CQ is a contiguous circular buffer of fix
> sized element. And the above code passes the address and size of SQ/CQ
> to the hardware. At this point hardware will do nothing but take note
> of the SQ/CQ location/size. 
> 
> When do dma_issue_pending(), the actual SQ head write will occur to
> update hardware with the current SQ head, as below:
> 
> writew(swdma_chan->head, &swdma_chan->mmio_chan_hw->sq_tail);

But if the order of txn submission is changed you will issue dma txn in
wrong order, so it should be written only when desc is submitted not in
the prep invocation!

-- 
~Vinod
