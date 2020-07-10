Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52FB21B234
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2020 11:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgGJJ1o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jul 2020 05:27:44 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:49876 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgGJJ1o (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Jul 2020 05:27:44 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 3115F8040A6A;
        Fri, 10 Jul 2020 09:27:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qrqlMbEsGWHK; Fri, 10 Jul 2020 12:27:39 +0300 (MSK)
Date:   Fri, 10 Jul 2020 12:27:38 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 04/11] dmaengine: Introduce max SG list entries
 capability
Message-ID: <20200710092738.z7zyywe46mp7uuf3@mobilestation>
References: <20200709224550.15539-1-Sergey.Semin@baikalelectronics.ru>
 <20200709224550.15539-5-Sergey.Semin@baikalelectronics.ru>
 <d667adda-6576-623d-6976-30f60ab3c3dc@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d667adda-6576-623d-6976-30f60ab3c3dc@ti.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Peter

On Fri, Jul 10, 2020 at 11:31:47AM +0300, Peter Ujfalusi wrote:
> 
> 
> On 10/07/2020 1.45, Serge Semin wrote:
> > Some devices may lack the support of the hardware accelerated SG list
> > entries automatic walking through and execution. In this case a burden of
> > the SG list traversal and DMA engine re-initialization lies on the
> > DMA engine driver (normally implemented by using a DMA transfer completion
> > IRQ to recharge the DMA device with a next SG list entry). But such
> > solution may not be suitable for some DMA consumers. In particular SPI
> > devices need both Tx and Rx DMA channels work synchronously in order
> > to avoid the Rx FIFO overflow. In case if Rx DMA channel is paused for
> > some time while the Tx DMA channel works implicitly pulling data into the
> > Rx FIFO, the later will be eventually overflown, which will cause the data
> > loss. So if SG list entries aren't automatically fetched by the DMA
> > engine, but are one-by-one manually selected for execution in the
> > ISRs/deferred work/etc., such problem will eventually happen due to the
> > non-deterministic latencies of the service execution.
> 

> It is not really the number of sg nents which is the problem, but the
> combination of total number of bytes _and_ the number of nents used to
> map them.

No, in the case described above the latency only matters. The length of the SG
entries doesn't (at most of extents). The same is with the nents. If there are
more than one SG entries in the Rx SG-list handled with the non-deterministic
latency, the problem may happen at the moment of any Rx SG entry reload.

(In fact the DW DMAC driver is working with so called Linked-List entries,
which are used to map the SG-list entries into the list of items with length
less than or equal to the max block size the engine supports. But for
simplicity I call them the SG-list entries, since if dma_set_max_seg_size()
is specified the mapping will be uniform.)

> Obviously the TX and RX number of bytes must match in duplex case and at
> the same time neither nents should be over the number of SGs the DMA
> device can handle without interruption (linking, chaining, or whatever
> means).

Right.

> 
> The EDMA from TI have similar limitation (we set the limit to 20 nents).
> Longer lists will be broken up to maximum of 20 segment transfers.
> This setup has bigger impact on audio (cyclic) as we need to limit the
> number of periods to not exceed this limit of 20.

As I said the problem described above isn't about the number of entries, but
about how they are handled. If there is a latency, then the problem may and most
like will eventually happen.

The complexity of the situation is that the DW DMAC driver may split a SG-list
entry up if its length exceeds max block size the engine supports. That's
why in order to fix the problem described in the patch log the DMA client driver
developed needs to take into account the next two points:
1) Detect the maximum number of SG entries the DMA engine can handle without the
non-deterministic latency (you called it max_sg_nents_burst). So the client
drivers would know, that the DMA-channels responsible for Tx and Rx transfers
may be executed with latencies.
2) Make sure the length of each SG-list entry doesn't exceed the max block size
the DW DMAC supports. If some of them does, then the DW DMAC code will break
these SG-entries up into the smaller DMA Linked-list entries, which will get us
back to the re-submission latency problem described in the patch log. This
peculiarity is covered by calling dma_set_max_seg_size() method in the DW DMAC
driver (at least for SPI subsystem it works out-of-box).

> 
> The sDMA on the other hand has different limits. Earlier versions
> without linking support can execute one SG chunk at the time and needs
> to reconfigure for the next one -> max_sg_nents is 1 for the older sDMAs...

Yes, this is our case.

> 
> > In order to let the DMA consumer know about the DMA device capabilities
> > regarding the hardware accelerated SG list traversal we introduce the
> > max_sg_list capability. It is supposed to be initialized by the DMA engine
> > driver with 0 if there is no limitation for the number of SG entries
> > atomically executed and with non-zero value if there is such constraints,
> > so the upper limit is determined by the number set to the property.
> > 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: linux-mips@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > 
> > ---
> > 
> > Changelog v3:
> > - This is a new patch created as a result of the discussion with Vinud and
> >   Andy in the framework of DW DMA burst and LLP capabilities.
> > 
> > Changelog v4:
> > - Fix of->if typo. It should be definitely of.
> > ---
> >  drivers/dma/dmaengine.c   | 1 +
> >  include/linux/dmaengine.h | 8 ++++++++
> >  2 files changed, 9 insertions(+)
> > 
> > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > index b332ffe52780..ad56ad58932c 100644
> > --- a/drivers/dma/dmaengine.c
> > +++ b/drivers/dma/dmaengine.c
> > @@ -592,6 +592,7 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
> >  	caps->directions = device->directions;
> >  	caps->min_burst = device->min_burst;
> >  	caps->max_burst = device->max_burst;
> > +	caps->max_sg_nents = device->max_sg_nents;
> >  	caps->residue_granularity = device->residue_granularity;
> >  	caps->descriptor_reuse = device->descriptor_reuse;
> >  	caps->cmd_pause = !!device->device_pause;
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index 0c7403b27133..a7e4d8dfdd19 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -467,6 +467,9 @@ enum dma_residue_granularity {
> >   *	should be checked by controller as well
> >   * @min_burst: min burst capability per-transfer
> >   * @max_burst: max burst capability per-transfer
> > + * @max_sg_nents: max number of SG list entries executed in a single atomic
> > + *	DMA tansaction with no intermediate IRQ for reinitialization. Zero
> > + *	value means unlimited number of entries.
> 

> Without looking at the comment the name max_sg_nents implies that the
> DMA can not handle longer lists, but it is not really true.
> max_sg_nents_burst might be a bit cleaner for the first look?

Seems reasonable. I also thought of a better naming so there wouldn't be need to
read a comment in order get a notion what exactly the parameter is responsible
for. Although at the moment of the patchset preparation nothing better got in my
mind.

I like what you suggest, but I'd better make it "max_sg_burst" or "max_sg_chain".
What do you think?

Vinod?
Andy (since you've already acked the patch)?

-Sergey

> 
> >   * @cmd_pause: true, if pause is supported (i.e. for reading residue or
> >   *	       for resume later)
> >   * @cmd_resume: true, if resume is supported
> > @@ -481,6 +484,7 @@ struct dma_slave_caps {
> >  	u32 directions;
> >  	u32 min_burst;
> >  	u32 max_burst;
> > +	u32 max_sg_nents;
> >  	bool cmd_pause;
> >  	bool cmd_resume;
> >  	bool cmd_terminate;
> > @@ -773,6 +777,9 @@ struct dma_filter {
> >   *	should be checked by controller as well
> >   * @min_burst: min burst capability per-transfer
> >   * @max_burst: max burst capability per-transfer
> > + * @max_sg_nents: max number of SG list entries executed in a single atomic
> > + *	DMA tansaction with no intermediate IRQ for reinitialization. Zero
> > + *	value means unlimited number of entries.
> >   * @residue_granularity: granularity of the transfer residue reported
> >   *	by tx_status
> >   * @device_alloc_chan_resources: allocate resources and return the
> > @@ -844,6 +851,7 @@ struct dma_device {
> >  	u32 directions;
> >  	u32 min_burst;
> >  	u32 max_burst;
> > +	u32 max_sg_nents;
> >  	bool descriptor_reuse;
> >  	enum dma_residue_granularity residue_granularity;
> >  
> > 
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
