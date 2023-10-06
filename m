Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5D07BB534
	for <lists+dmaengine@lfdr.de>; Fri,  6 Oct 2023 12:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjJFKaW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Oct 2023 06:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjJFKaV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Oct 2023 06:30:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEC783;
        Fri,  6 Oct 2023 03:30:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1287C433C7;
        Fri,  6 Oct 2023 10:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696588218;
        bh=+mvqaTG4RUdvegWzAzQB4Km4EgJ3oHRf9PT0mYVLsRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dtvkELudcMaOFfelR/3Ox3pum0NvWYQp26iwod064iJ4LtzK46ucZRC1v1NdHxoPP
         h8UbymfRUuLWVkfnDCpvGPXsD2k0dcL8ANcR951bsdiKUGzIN+nNgci8mTkHNu8XZo
         TyWSloZk71IEsC88JwZBTtFKuU88e3z+pKFw38oGOylqBoY5KH5nbLPQRgkD7lHlLi
         3f8msQO4QXgJHBsgwNGsMB+KGaxau8Nl9P9iPqz7AjWp3Ql0NnmVm1NlxGeAn2KV7r
         qIqkbiySckJv3eyTfJnTYGnHH2CR5N0hpfOcOJKsEqFXeuVdkWDTDeMcOV7cTWIZBG
         DH99zA3gEvRmA==
Date:   Fri, 6 Oct 2023 16:00:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kelvin.Cao@microchip.com
Cc:     dmaengine@vger.kernel.org, George.Ge@microchip.com,
        christophe.jaillet@wanadoo.fr, hch@infradead.org,
        linux-kernel@vger.kernel.org, logang@deltatee.com
Subject: Re: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Message-ID: <ZR/htuZSKGJP1wgU@matsya>
References: <20230728200327.96496-1-kelvin.cao@microchip.com>
 <20230728200327.96496-2-kelvin.cao@microchip.com>
 <ZMlSLXaYaMry7ioA@matsya>
 <fd597a2a71f1c5146c804bb9fce3495864212d69.camel@microchip.com>
 <b0dc3da623dee479386e7cb75841b8b7913c9890.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0dc3da623dee479386e7cb75841b8b7913c9890.camel@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-10-23, 18:35, Kelvin.Cao@microchip.com wrote:

> > > > +static struct dma_async_tx_descriptor *
> > > > +switchtec_dma_prep_wimm_data(struct dma_chan *c, dma_addr_t
> > > > dma_dst, u64 data,
> > > > +                          unsigned long flags)
> > > 
> > > can you please explain what this wimm data refers to...
> > > 
> > > I think adding imm callback was a mistake, we need a better
> > > justification for another user for this, who programs this, what
> > > gets
> > > programmed here
> > 
> > Sure. I think it's an alternative method to prep_mem and would be
> > more
> > convenient to use when the write is 8-byte and the data to be moved
> > is
> > not in a DMA mapped memory location. For example, we write to a
> > doorbell register with the value from a local variable which is not
> > associated with a DMA address to notify the receiver to consume the
> > data, after confirming that the previously initiated DMA transactions
> > of the data have completed. I agree that the use scenario would be
> > very
> > limited.

Can you please explain more about this 'value' where is it derived from?
Who programs it and how...

> > > > +     /* set sq/cq */
> > > > +     writel(lower_32_bits(swdma_chan->dma_addr_sq), &chan_fw-
> > > > > sq_base_lo);
> > > > +     writel(upper_32_bits(swdma_chan->dma_addr_sq), &chan_fw-
> > > > > sq_base_hi);
> > > > +     writel(lower_32_bits(swdma_chan->dma_addr_cq), &chan_fw-
> > > > > cq_base_lo);
> > > > +     writel(upper_32_bits(swdma_chan->dma_addr_cq), &chan_fw-
> > > > > cq_base_hi);
> > > > +
> > > > +     writew(SWITCHTEC_DMA_SQ_SIZE, &swdma_chan->mmio_chan_fw-
> > > > > sq_size);
> > > > +     writew(SWITCHTEC_DMA_CQ_SIZE, &swdma_chan->mmio_chan_fw-
> > > > > cq_size);
> > > 
> > > what is write happening in the descriptor alloc callback, that does
> > > not
> > > sound correct to me
> > 
> > All the queue descriptors of a channel are pre-allocated, so I think
> > it's proper to convey the queue address/size to hardware at this
> > point.
> > After this initialization, we only need to assign cookie in submit
> > and
> > update queue head to hardware in issue_pending.

Sorry that is not right, you can prepare multiple descriptors and then
submit. Only at submit is the cookie assigned which is in order, so this
should be moved to when we start the txn and not in this call

-- 
~Vinod
