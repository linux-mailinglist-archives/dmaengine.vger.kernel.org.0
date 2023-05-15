Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C6C70313D
	for <lists+dmaengine@lfdr.de>; Mon, 15 May 2023 17:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbjEOPNt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 May 2023 11:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjEOPNs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 May 2023 11:13:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA14A8E;
        Mon, 15 May 2023 08:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=j4FIp2hqSzB7YKizCVfFKv2y9wufpVhksAFO7Qv4a7o=; b=ykCbnADqgm70QNQnTnrkklvLSH
        /jai0i1bbiF+XMegvmmf87cayl0mig9YXVOLSgM1nglFNmO3E13UuYYD4GAFPIdw82IRwEIWmahTM
        HmG7Q8zcMXWPDsygFWXDtPOf1VoopK6soltN+Tw16HUg3XCMewm0+2QXu7tI8yCeMd+0hC7F393N0
        r6GnZU/bn8e0Hoh0Y/lakkYC9pKE4WsH3oqAz6D47P1NKRGV2IcpgYi3VyiBMfDdCvf/lkCDOd2+v
        Spz4KfN2Mwr4jxl8Y0BwHICiXixU8+0lRxMzatFLxkmLfr1LOqU7One2BJNxAlYEcgWddficn5G+X
        EL3eokcw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pyZtQ-002WtH-2V;
        Mon, 15 May 2023 15:13:44 +0000
Date:   Mon, 15 May 2023 08:13:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kelvin.Cao@microchip.com
Cc:     hch@infradead.org, dmaengine@vger.kernel.org, vkoul@kernel.org,
        George.Ge@microchip.com, linux-kernel@vger.kernel.org,
        logang@deltatee.com, tglx@linutronix.de,
        christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v4 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Message-ID: <ZGJMKFrLfU2zc/2P@infradead.org>
References: <20230423213717.318655-1-kelvin.cao@microchip.com>
 <20230423213717.318655-2-kelvin.cao@microchip.com>
 <ZFH/xhyjm9VTZolE@infradead.org>
 <50e111a3cfecd0f232508d1b03e02d1e25d9d4a9.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50e111a3cfecd0f232508d1b03e02d1e25d9d4a9.camel@microchip.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 05, 2023 at 12:31:11AM +0000, Kelvin.Cao@microchip.com wrote:
> Hi Christoph,
> 
> Thanks for the comments. For the tasklet stuff, I guess your opinion is
> that by default the driver should go with threaded irq instead of
> tasklet as the former is more efficient, unless there's a good reason
> of using tasklet. 
> 
> Tasklet is widely used in DMA drivers, not sure if there's a rational
> reason or people just follow the code structure of the current ones. 

Given that neither nor anyone else from the RT community chimed
in I'm going to throw the towel on the tasklet use.  It looks fairly
suboptimal, but I don't want to block the driver on that.

> > > +     union {
> > > +             __le32 saddr_lo;
> > > +             __le32 widata_lo;
> > > +     };
> > > +     union {
> > > +             __le32 saddr_hi;
> > > +             __le32 widata_hi;
> > > +     };
> > 
> > What is the point for unions of identical data types?
> 
> The same offset could hold either source address or write immediate
> data in different transactions. Unions used here is to give different
> names for the same offset. I guess it improves readability when
> referring to them with proper names.

I find this rather confusing, especially as some code literally
switches on the op to fill in either set.

> The CE is little-endian and is filled by hardware. As an error message,
> I'd like to dump the whole structure. Would the following code look
> better?
> 
> __le32 *p;
> ...
> p = (__le32 *)ce;
> for (i = 0; i < sizeof(*ce)/4; i++) {
>  dev_err(chan_dev, "CE DW%d: 0x%08x\n", i,
>  le32_to_cpu(*p));
>  p++;
> }

Fine with me.

> > > +#define SWITCHTEC_DMA_DEVICE(device_id) \
> > > +     { \
> > > +             .vendor     = PCI_VENDOR_ID_MICROSEMI, \
> > > +             .device     = device_id, \
> > > +             .subvendor  = PCI_ANY_ID, \
> > > +             .subdevice  = PCI_ANY_ID, \
> > > +             .class      = PCI_CLASS_SYSTEM_OTHER << 8, \
> > > +             .class_mask = 0xFFFFFFFF, \
> > > +     }
> > > +
> > > +static const struct pci_device_id switchtec_dma_pci_tbl[] = {
> > > +     SWITCHTEC_DMA_DEVICE(0x4000), /* PFX 100XG4 */
> > 
> > This should use the common PCI_DEVICE() macro instead, i.e.
> > 
> >         PCI_DEVICE(PCI_VENDOR_ID_MICROSEMI, 0x4000), /* PFX 100XG4 */
> >         ...
> 
> We also need to distinguish the .class as we have devices of other
> .class with the same vendor/device ID.

Ok, that's roetty weird and probably worth a little comment.
