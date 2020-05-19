Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955E81D9D69
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2020 19:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgESRCw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 May 2020 13:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgESRCw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 19 May 2020 13:02:52 -0400
Received: from localhost (unknown [122.182.207.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D029720708;
        Tue, 19 May 2020 17:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589907771;
        bh=dojKH/YymNvZhhrFdOuFiYo2JQyFdH5ZcVVx9Js1vek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xLOn2sSiWHeYkRj0PX0FYJIIMRsM5bS0psa/DzwJ4PWotpGqqYw1ASYHJNuHW8Lik
         VNAlbnqJeznxA0R6qr9ix9IzxlfOEpKWRPYJzTg2WojYYOfQctJRM+XpZkEXPOfBl7
         41HhouWeKDjyQsHMedfuXr6E2PNkNZwDow/wFkh0=
Date:   Tue, 19 May 2020 22:32:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] dmaengine: dw: Print warning if multi-block is
 unsupported
Message-ID: <20200519170246.GS374218@vkoul-mobl.Dlink>
References: <20200511021016.wptcgnc3iq3kadgz@mobilestation>
 <20200511115813.GG8216@sirena.org.uk>
 <20200511134502.hjbu5evkiuh75chr@mobilestation>
 <CAHp75VdOi1rwaKjzowhj0KA-eNNL4NxpiCeqfELFgO_RcnZ-xw@mail.gmail.com>
 <20200511193255.t6orpcdz5ukmwmqo@mobilestation>
 <20200511210714.GO185537@smile.fi.intel.com>
 <20200511210800.GP185537@smile.fi.intel.com>
 <20200512124206.l3uv5hg2zimi24dq@mobilestation>
 <20200515063039.GH333670@vkoul-mobl>
 <20200517192347.h3hiibsifwfyyr7z@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517192347.h3hiibsifwfyyr7z@mobilestation>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-05-20, 22:23, Serge Semin wrote:
> On Fri, May 15, 2020 at 12:00:39PM +0530, Vinod Koul wrote:
> > Hi Serge,
> > 
> > On 12-05-20, 15:42, Serge Semin wrote:
> > > Vinod,
> > > 
> > > Could you join the discussion for a little bit?
> > > 
> > > In order to properly fix the problem discussed in this topic, we need to
> > > introduce an additional capability exported by DMA channel handlers on per-channel
> > > basis. It must be a number, which would indicate an upper limitation of the SG list
> > > entries amount.
> > > Something like this would do it:
> > > struct dma_slave_caps {
> > > ...
> > > 	unsigned int max_sg_nents;
> > > ...
> > 
> > Looking at the discussion, I agree we should can this up in the
> > interface. The max_dma_len suggests the length of a descriptor allowed,
> > it does not convey the sg_nents supported which in the case of nollp is
> > one.
> > 
> > Btw is this is a real hardware issue, I have found that value of such
> > hardware is very less and people did fix it up in subsequent revs to add
> > llp support.
> 
> Yes, it is. My DW DMAC doesn't support LLP and there isn't going to be new SoC
> version produced.(

Ouch

> > Also, another question is why this cannot be handled in driver, I agree
> > your hardware does not support llp but that does not stop you from
> > breaking a multi_sg list into N hardware descriptors and keep submitting
> > them (for this to work submission should be done in isr and not in bh,
> > unfortunately very few driver take that route).
> 
> Current DW DMA driver does that, but this isn't enough. The problem is that
> in order to fix the issue in the DMA hardware driver we need to introduce
> an inter-dependent channels abstraction and synchronously feed both Tx and
> Rx DMA channels with hardware descriptors (LLP entries) one-by-one. This hardly
> needed by any slave device driver rather than SPI, which Tx and Rx buffers are
> inter-dependent. So Andy's idea was to move the fix to the SPI driver (feed
> the DMA engine channels with Tx and Rx data buffers synchronously), but DMA
> engine would provide an info whether such fix is required. This can be
> determined by the maximum SG entries capability.

Okay but having the sw limitation removed would also be a good idea, you
can handle any user, I will leave it upto you, either way is okay

> 
> (Note max_sg_ents isn't a limitation on the number of SG entries supported by
> the DMA driver, but the number of SG entries handled by the DMA engine in a
> single DMA transaction.)
> 
> > TBH the max_sg_nents or
> > max_dma_len are HW restrictions and SW *can* deal with then :-)
> 
> Yes, it can, but it only works for the cases when individual DMA channels are
> utilized. DMA hardware driver doesn't know that the target and source slave
> device buffers (SPI Tx and Rx FIFOs) are inter-dependent, that writing to one
> you will implicitly push data to another. So due to the interrupts handling
> latency Tx DMA channel is restarted faster than Rx DMA channel is reinitialized.
> This causes the SPI Rx FIFO overflow and data loss.
> 
> > 
> > In an idea world, you should break the sw descriptor submitted into N hw
> > descriptors and submit to hardware and let user know when the sw
> > descriptor is completed. Of course we do not do that :(
> 
> Well, the current Dw DMA driver does that. But due to the two slave device
> buffers inter-dependency this isn't enough to perform safe DMA transactions.
> Due to the interrupts handling latency Tx DMA channel pushes data to the slave
> device buffer faster than Rx DMA channel starts to handle incoming data. This
> causes the SPI Rx FIFO overflow.
> 
> > 
> > > };
> > > As Andy suggested it's value should be interpreted as:
> > > 0          - unlimited number of entries,
> > > 1:MAX_UINT - actual limit to the number of entries.
> > 
> 
> > Hmm why 0, why not MAX_UINT for unlimited?
> 
> 0 is much better for many reasons. First of all MAX_UINT is a lot, but it's
> still a number. On x64 platform this might be actual limit if for instance
> the block-size register is 32-bits wide. Secondly interpreting 0 as unlimited
> number of entries would be more suitable since most of the drivers support
> LLP functionality and we wouldn't need to update their code to set MAX_UINT.
> Thirdly DMA engines, which don't support LLPs would need to set this parameter
> as 1. So if we do as you say and interpret unlimited number of LLPs as MAX_UINT,
> then 0 would left unused.
> 
> To sum up I also think that using 0 as unlimited number SG entries supported is
> much better.

ok

> > > In addition to that seeing the dma_get_slave_caps() method provide the caps only
> > > by getting them from the DMA device descriptor, while we need to have an info on
> > > per-channel basis, it would be good to introduce a new DMA-device callback like:
> > > struct dma_device {
> > > ...
> > > 	int (*device_caps)(struct dma_chan *chan,
> > > 			   struct dma_slave_caps *caps);
> > 
> 
> > Do you have a controller where channel caps are on per-channel basis?
> 
> Yes, I do. Our DW DMA controller has got the maximum burst length non-uniformly
> distributed per DMA channels. There are eight channels our controller supports,
> among which first two channels can burst up to 32 transfer words, but the rest
> of the channels support bursting up to 4 transfer words.
> 
> So having such device_caps() callback to customize the device capabilities on
> per-DMA-channel basis would be very useful! What do you think?

Okay looks like per-ch basis is the way forward!

-- 
~Vinod
