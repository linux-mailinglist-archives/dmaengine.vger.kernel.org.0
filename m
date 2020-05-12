Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D921CF3B4
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2020 13:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgELLt6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 May 2020 07:49:58 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:53002 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbgELLt4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 May 2020 07:49:56 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 8E42E803080B;
        Tue, 12 May 2020 11:49:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id X9U0mGSQWcVy; Tue, 12 May 2020 14:49:47 +0300 (MSK)
Date:   Tue, 12 May 2020 14:49:46 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-mips@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: dma: dw: Add max burst transaction
 length property
Message-ID: <20200512114946.x777yb6bhe22ccn5@mobilestation>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-3-Sergey.Semin@baikalelectronics.ru>
 <20200508111242.GH185537@smile.fi.intel.com>
 <20200511200528.nfkc2zkh3bvupn7l@mobilestation>
 <20200511210138.GN185537@smile.fi.intel.com>
 <20200511213531.wnywlljiulvndx6s@mobilestation>
 <20200512090804.GR185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200512090804.GR185537@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 12, 2020 at 12:08:04PM +0300, Andy Shevchenko wrote:
> On Tue, May 12, 2020 at 12:35:31AM +0300, Serge Semin wrote:
> > On Tue, May 12, 2020 at 12:01:38AM +0300, Andy Shevchenko wrote:
> > > On Mon, May 11, 2020 at 11:05:28PM +0300, Serge Semin wrote:
> > > > On Fri, May 08, 2020 at 02:12:42PM +0300, Andy Shevchenko wrote:
> > > > > On Fri, May 08, 2020 at 01:53:00PM +0300, Serge Semin wrote:
> > > > > > This array property is used to indicate the maximum burst transaction
> > > > > > length supported by each DMA channel.
> > > > > 
> > > > > > +  snps,max-burst-len:
> > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > > > +    description: |
> > > > > > +      Maximum length of burst transactions supported by hardware.
> > > > > > +      It's an array property with one cell per channel in units of
> > > > > > +      CTLx register SRC_TR_WIDTH/DST_TR_WIDTH (data-width) field.
> > > > > > +    items:
> > > > > > +      maxItems: 8
> > > > > > +      items:
> > > > > 
> > > > > > +        enum: [4, 8, 16, 32, 64, 128, 256]
> > > > > 
> > > > > Isn't 1 allowed?
> > > > 
> > > > Burst length of 1 unit is supported, but in accordance with Data Book the MAX
> > > > burst length is limited to be equal to a value from the set I submitted. So the
> > > > max value can be either 4, or 8, or 16 and so on.
> > > 
> > > Hmm... It seems you mistakenly took here DMAH_CHx_MAX_MULT_SIZE pre-silicon
> > > configuration parameter instead of runtime as described in Table 26:
> > > CTLx.SRC_MSIZE and DEST_MSIZE Decoding.
> > 
> > No. You misunderstood what I meant. We shouldn't use a runtime parameters values
> > here. Why would we?
> 
> Because what we describe in the DTS is what user may do to the hardware. In
> some cases user might want to limit this to 1, how to achieve that?

No, dts isn't about hardware configuration, it's about hardware description. It's not
what user want, it's about what hardware can and can't. If a developer wants to limit
it to 1, one need to do this in software. The IP-core just can't be synthesized
with such limitation. No matter what, it must be no less than 4 as I described
in the enum setting.

> 
> Rob, is there any clarification that schema describes only synthesized values?
> Or i.o.w. shall we allow user to setup whatever hardware supports at run time?

One more time. max-burst-len set to 1 wouldn't describe the real hardware capability
because the Dw DMAC IP-core simply can't be synthesized with such max-burst-len.
In this patch I submitted the "max-burst-len" property, not just "burst-len"
setting.

> 
> > Property "snps,max-burst-len" matches DMAH_CHx_MAX_MULT_SIZE
> > config parameter.
> 
> Why? User should have a possibility to ask whatever hardware supports at run time.

Because the run time parameter is limited with DMAH_CHx_MAX_MULT_SIZE value, you agreed
with that further and "snps,max-burst-len" is about hardware limitation. For the
same reason the dma-channels property is limited to belong the segment 1 - 8, dma-masters
number must be limited with 1 - 4, block_size should be one of the set [3, 7, 15, 31, 63,
127, 255, 511, 1023, 2047, 4095] and so on. For instance, the block-size can be
set any but not greater than a value of the "block-size" property found in the
dt node or retrieved from the corresponding IP param register. It's not what user want,
but what hardware can support.

-Sergey

> 
> > See a comment to the "SRC_MSIZE" and "DEST_MSIZE" fields of the
> > registers. You'll find out that their maximum value is determined by the
> > DMAH_CHx_MAX_MULT_SIZE parameter, which must belong to the set [4, 8, 16, 32, 64,
> > 128, 256]. So no matter how you synthesize the DW DMAC block you'll have at least
> > 4x max burst length supported.
> 
> That's true.
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
