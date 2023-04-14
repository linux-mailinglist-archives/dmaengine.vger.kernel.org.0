Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54766E1C16
	for <lists+dmaengine@lfdr.de>; Fri, 14 Apr 2023 07:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjDNF5b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Apr 2023 01:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNF5a (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Apr 2023 01:57:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DBF4EEA;
        Thu, 13 Apr 2023 22:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=vDEmKAwqsAzYhB9mA/dekTjtCBjY4b15AmaH++f9BvY=; b=Csiz/MdqOxesMZcuF5yeFmGPKm
        gVLN/72UmzB8H04ZwM8m4Hf5XOEYh+wmaVS10wkiDAgeWG8XDIbkkTrRTAWpVo6G9QevEDEmLEFOM
        K724Te9jy0zacsuaIOLmI5/D4Kxx4yqbFx9jG8+MOleS+9GMDdVoivmSvY6ZJpT/tu0o9URKHQBdT
        eYk4ZfvpQPo6kY2F9ks+EQ2ear3gBHMC7uu384IsedKe6a2nH7owoo7Air5lp8acC0gFtG7+CMySI
        VUeZMJcIqhWEc1HfAswU1Vi8oqFZWSVIXNezgjlibnf0o0i9XykYMCLKxXtoxbW1RnQ2IvPT6aBSa
        JTI/tgsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnCR7-008Pvy-0p;
        Fri, 14 Apr 2023 05:57:29 +0000
Date:   Thu, 13 Apr 2023 22:57:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kelvin.Cao@microchip.com
Cc:     hch@infradead.org, dmaengine@vger.kernel.org, vkoul@kernel.org,
        George.Ge@microchip.com, linux-kernel@vger.kernel.org,
        logang@deltatee.com
Subject: Re: [PATCH v2 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Message-ID: <ZDjrSVVv8LZDEfQY@infradead.org>
References: <20230403180630.4186061-1-kelvin.cao@microchip.com>
 <20230403180630.4186061-2-kelvin.cao@microchip.com>
 <ZDQ8geSEauTsd2ME@infradead.org>
 <c86fe78f384295d5694b1534efa1f5b070c8123c.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c86fe78f384295d5694b1534efa1f5b070c8123c.camel@microchip.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 13, 2023 at 11:22:14PM +0000, Kelvin.Cao@microchip.com wrote:
> On Mon, 2023-04-10 at 18:42 +0200, Christoph Hellwig wrote:
> > 
> > > +     writew((__force u16)cpu_to_le16(SWITCHTEC_DMA_SQ_SIZE),
> > > +            &swdma_chan->mmio_chan_fw->sq_size);
> > > +     writew((__force u16)cpu_to_le16(SWITCHTEC_DMA_CQ_SIZE),
> > > +            &swdma_chan->mmio_chan_fw->cq_size);
> > 
> > This looks broken to me, writew always expects cpu endian arguments
> > and byte swaps on big endian systems.
> 
> Do you mean writew assumes the peripherals be little-endian, and will
> do the swap when host is bit-endian?

Yes.  All the standard mmio accessors ({read,write}{b,w,l,q}) do that.

> > But I find the whole pcim_iomap_table concept very confusing to the
> > reader of the driver, and given that it doesn't really use many
> > devm or pcim routines I'd suggest removing them all and sticking to
> > one well understood way of manging resource lifetimes.
> 
> I didn't get it. Do you have specific suggestion?


 - instead of pcim_enable_device call pci_enable_device, and then
   just call pci_disable_device in ->remove and on error
 - instead of pcim_iomap_regions, call pci_request_mem_regions on
   probe, and pci_release_mem_regions on release / fail, and then
   do an ioremap(pci_resource_start(pdev, 1) for the actual bar
   (and iounmap on release/fail) instead of pcim_iomap_table.

> > dma_set_mask_and_coherent for a smaller mask will never succeed when
> > trying to set it to a larger one failed.  So you can remove the
> > second
> > call here.
> 
> By default the kernel assumes the device can address 32-bit address
> space,

Yes.

> I wonder why it wouldn't allow 32-bit mask when it failes 64-
> bit?

The kernel never fails setting a 64-bit DMA mask, it only fails setting
too small masks.
