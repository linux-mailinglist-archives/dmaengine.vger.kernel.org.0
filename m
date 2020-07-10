Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3678821BA91
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2020 18:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgGJQO5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jul 2020 12:14:57 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:51130 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgGJQO4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Jul 2020 12:14:56 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 098748040A69;
        Fri, 10 Jul 2020 16:14:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P55LJbe8nxTn; Fri, 10 Jul 2020 19:14:47 +0300 (MSK)
Date:   Fri, 10 Jul 2020 19:14:45 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
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
Message-ID: <20200710161445.t6eradkgt4terdr3@mobilestation>
References: <20200709224550.15539-1-Sergey.Semin@baikalelectronics.ru>
 <20200709224550.15539-5-Sergey.Semin@baikalelectronics.ru>
 <d667adda-6576-623d-6976-30f60ab3c3dc@ti.com>
 <20200710092738.z7zyywe46mp7uuf3@mobilestation>
 <427bc5c8-0325-bc25-8637-a7627bcac26f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <427bc5c8-0325-bc25-8637-a7627bcac26f@ti.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jul 10, 2020 at 02:51:33PM +0300, Peter Ujfalusi wrote:
> Hi Sergey,
> 
> On 10/07/2020 12.27, Serge Semin wrote:
> > Hello Peter
> > 
> > On Fri, Jul 10, 2020 at 11:31:47AM +0300, Peter Ujfalusi wrote:
> >>
> >>
> >> On 10/07/2020 1.45, Serge Semin wrote:
> >>> Some devices may lack the support of the hardware accelerated SG list
> >>> entries automatic walking through and execution. In this case a burden of
> >>> the SG list traversal and DMA engine re-initialization lies on the
> >>> DMA engine driver (normally implemented by using a DMA transfer completion
> >>> IRQ to recharge the DMA device with a next SG list entry). But such
> >>> solution may not be suitable for some DMA consumers. In particular SPI
> >>> devices need both Tx and Rx DMA channels work synchronously in order
> >>> to avoid the Rx FIFO overflow. In case if Rx DMA channel is paused for
> >>> some time while the Tx DMA channel works implicitly pulling data into the
> >>> Rx FIFO, the later will be eventually overflown, which will cause the data
> >>> loss. So if SG list entries aren't automatically fetched by the DMA
> >>> engine, but are one-by-one manually selected for execution in the
> >>> ISRs/deferred work/etc., such problem will eventually happen due to the
> >>> non-deterministic latencies of the service execution.
> >>
> > 
> >> It is not really the number of sg nents which is the problem, but the
> >> combination of total number of bytes _and_ the number of nents used to
> >> map them.
> > 
> > No, in the case described above the latency only matters.
> 

> Sure, the latency comes in (at least for EDMA) when moving from one
> sub-sg_list to the next one when needing to break the long list into
> smaller chunks. In the sub-completion we need to move to the next chunk.

Right. It's crucial. In our case "sub-sg_list" is just a single SG-list entry
because hardware-accelerated Linked-list traversal is unsupported. AFAIU in your
case the sub-sg_list might contain several entries.

> 
> > The length of the SG
> > entries doesn't (at most of extents). The same is with the nents. If there are
> > more than one SG entries in the Rx SG-list handled with the non-deterministic
> > latency, the problem may happen at the moment of any Rx SG entry reload.
> 

> You have latency in the hardware when progressing between the sg entries?

Since there is no support of hardware accelerated SG-list traversal in our
DMA engine, then I can't give you an answer to that question. My message was
that due to the lack of the automatic SG-list entries reloading, each SG-list
entry is re-submitted one-by-one by the DW DMAC driver by means of the
IRQ/tasklet service routines (AFAIU in your case the re-submission is done
for each sub-sg_list). IRQs/tasklet handling may cause the non-deterministic
latency in case if the system is heavy loaded with some other activity. That
latency is dangerous in case if the Tx and Rx data flows are inter-dependent.
In case of SPI If an Rx DMA channel doesn't start fetching data from an SPI Rx
FIFO on time, the later one might get to be overflown eventually.

On the other hand theoretically some latency may still persist even for DMA
engines with hardware accelerated SG-list traversal. That latency can be caused
by an intensive high-priority traffic on the memory-bus generated by CPUs, other
devices or DMAs. But since we haven't got any reports about problems concerning
it so far, then most likely that latency is negligible small. So I assume
that if hardware accelerated SG-list traversal is supported, then the
DMAengine-based operations are working well for any case.

> 
> > (In fact the DW DMAC driver is working with so called Linked-List entries,
> > which are used to map the SG-list entries into the list of items with length
> > less than or equal to the max block size the engine supports. But for
> > simplicity I call them the SG-list entries, since if dma_set_max_seg_size()
> > is specified the mapping will be uniform.)
> 

> Right, I'll come back to the dma_set_max_seq_size() later for my cases ;)

For reference see the patch "[PATCH v7 07/11] dmaengine: dw: Set DMA device max
segment size parameter" in this series. Please also note, that in order to have
the uniform mapping, the DMA client must take into account the max segment size
when creating the SG-list entries.

> 
> >> The EDMA from TI have similar limitation (we set the limit to 20 nents).
> >> Longer lists will be broken up to maximum of 20 segment transfers.
> >> This setup has bigger impact on audio (cyclic) as we need to limit the
> >> number of periods to not exceed this limit of 20.
> > 
> > As I said the problem described above isn't about the number of entries, but
> > about how they are handled. If there is a latency, then the problem may and most
> > like will eventually happen.
> > 
> > The complexity of the situation is that the DW DMAC driver may split a SG-list
> > entry up if its length exceeds max block size the engine supports. That's
> > why in order to fix the problem described in the patch log the DMA client driver
> > developed needs to take into account the next two points:
> > 1) Detect the maximum number of SG entries the DMA engine can handle without the
> > non-deterministic latency (you called it max_sg_nents_burst). So the client
> > drivers would know, that the DMA-channels responsible for Tx and Rx transfers
> > may be executed with latencies.
> 

> This is really useful information for the clients. But in some cases
> they just don't care how the list is going to be processed, given if
> they have large enough internal FIFO to hold on while the DMA moves from
> one chunk to another.

Well, I'd say, not in some but in most of the cases they don't care. The problem
may happen if the DMA-engine is relatively slow to handle in incoming data at
required pace or a slave-device is relatively slow or the slave-device FIFO is
too small. Alas in our case all of those factors exist. The DMA-engine is
clocked with 50MHz, the SPI-bus is clocked with up to 25MHz. That's the
combination when the problem happens very often. The less the SPI-bus speed the
less often the Rx FIFO overflow happens.

> 
> > 2) Make sure the length of each SG-list entry doesn't exceed the max block size
> > the DW DMAC supports. If some of them does, then the DW DMAC code will break
> > these SG-entries up into the smaller DMA Linked-list entries, which will get us
> > back to the re-submission latency problem described in the patch log. This
> > peculiarity is covered by calling dma_set_max_seg_size() method in the DW DMAC
> > driver (at least for SPI subsystem it works out-of-box).
> 

> This is what does not work for me for neither EDMA or sDMA... The
> max_seq_size depends on the src/dst_addr_width the peripheral is
> configured. It is different for each DMA_SLAVE_BUSWIDTH_*_BYTES _and_
> also for the burst used.

Firstly noone prevents a DMA client from creating SG-list entries with length
greater than the max_seg_size value and the DMA-engine driver shall correctly
handle such SG-lists. In our case the max segment size in <bytes> also depends
on the addr-width parameter (MAX SG-list entry length in fact is (add_width *
max_block_size) bytes), but setting max_seg_size for smallest resolution
(addr_width = 1 byte) will keep us on a safe side for any case. No matter with
what address-width the DMA-engine channel is configured If a DMA client submits
a buffer with length less the max_seg_size it will always be handled as a
single Linked-List entry.

> 
> It is on my to-do list to clean up and send this:
> https://github.com/omap-audio/linux-audio/commit/dd81de1a343810468b6e7a601e90a9161f46cab1
> 
> For EDMA the implementation is:
> https://github.com/omap-audio/linux-audio/commit/ee93c45667d0f250baa1e224e5d1266fae2e7c80
> 
> along the same lines for sDMA:
> https://github.com/omap-audio/linux-audio/commit/d6ac68692efcdac8ec233c70b802d37f594d6d4d
> 
> What is obviously missing is that if the driver does not implement the
> device_get_max_len, then dma_get_max_seg_size() of the device should be
> returned.
> 
> Other option would be:
> https://github.com/omap-audio/linux-audio/commit/95dda19c92a38437741850309374a2ca4ef1e361
> 
> I'm still hesitating which would be more generic to be acceptable.
> 
> And to make things a bit more interesting the UDMA have also different
> dma_sg_len() supported depending on what mode the channel is used (TR or
> packet mode), but that's another story in itself.
> 
> >> The sDMA on the other hand has different limits. Earlier versions
> >> without linking support can execute one SG chunk at the time and needs
> >> to reconfigure for the next one -> max_sg_nents is 1 for the older sDMAs...
> > 
> > Yes, this is our case.
> 

> Interesting. So you prefer that your clients will use
> dmaengine_prep_slave_single() if possible?

Yes. I just don't see another way to solve the problem. (Please see the history of
this patchset review, links to the biggest part of which I've collected in the
cover-letter. We pretty much thoroughly discussed it with Andy, Vinod and Viresh).
The DW APB SSI driver (DW DMAC engine client) will synchronously walk over the
SG-lists passed for Tx and Rx transfers and re-charge the DMA-engine channels with
each entry. (The solution will be a bit more complicated since the Tx and Rx SG-lists
might have different number of entries, but in particular case it will look as I
described).

> 
> >>> In order to let the DMA consumer know about the DMA device capabilities
> >>> regarding the hardware accelerated SG list traversal we introduce the
> >>> max_sg_list capability. It is supposed to be initialized by the DMA engine
> >>> driver with 0 if there is no limitation for the number of SG entries
> >>> atomically executed and with non-zero value if there is such constraints,
> >>> so the upper limit is determined by the number set to the property.
> >>>
> >>> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> >>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >>> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> >>> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> >>> Cc: Arnd Bergmann <arnd@arndb.de>
> >>> Cc: Rob Herring <robh+dt@kernel.org>
> >>> Cc: linux-mips@vger.kernel.org
> >>> Cc: devicetree@vger.kernel.org
> >>>
> >>> ---
> >>>
> >>> Changelog v3:
> >>> - This is a new patch created as a result of the discussion with Vinud and
> >>>   Andy in the framework of DW DMA burst and LLP capabilities.
> >>>
> >>> Changelog v4:
> >>> - Fix of->if typo. It should be definitely of.
> >>> ---
> >>>  drivers/dma/dmaengine.c   | 1 +
> >>>  include/linux/dmaengine.h | 8 ++++++++
> >>>  2 files changed, 9 insertions(+)
> >>>
> >>> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> >>> index b332ffe52780..ad56ad58932c 100644
> >>> --- a/drivers/dma/dmaengine.c
> >>> +++ b/drivers/dma/dmaengine.c
> >>> @@ -592,6 +592,7 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
> >>>  	caps->directions = device->directions;
> >>>  	caps->min_burst = device->min_burst;
> >>>  	caps->max_burst = device->max_burst;
> >>> +	caps->max_sg_nents = device->max_sg_nents;
> >>>  	caps->residue_granularity = device->residue_granularity;
> >>>  	caps->descriptor_reuse = device->descriptor_reuse;
> >>>  	caps->cmd_pause = !!device->device_pause;
> >>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> >>> index 0c7403b27133..a7e4d8dfdd19 100644
> >>> --- a/include/linux/dmaengine.h
> >>> +++ b/include/linux/dmaengine.h
> >>> @@ -467,6 +467,9 @@ enum dma_residue_granularity {
> >>>   *	should be checked by controller as well
> >>>   * @min_burst: min burst capability per-transfer
> >>>   * @max_burst: max burst capability per-transfer
> >>> + * @max_sg_nents: max number of SG list entries executed in a single atomic
> >>> + *	DMA tansaction with no intermediate IRQ for reinitialization. Zero
> >>> + *	value means unlimited number of entries.
> >>
> > 
> >> Without looking at the comment the name max_sg_nents implies that the
> >> DMA can not handle longer lists, but it is not really true.
> >> max_sg_nents_burst might be a bit cleaner for the first look?
> > 
> > Seems reasonable. I also thought of a better naming so there wouldn't be need to
> > read a comment in order get a notion what exactly the parameter is responsible
> > for. Although at the moment of the patchset preparation nothing better got in my
> > mind.
> > 
> > I like what you suggest, but I'd better make it "max_sg_burst" or "max_sg_chain".
> > What do you think?
> 

> Since we should be able to handle longer lists and this is kind of a
> hint for clients that above this number of nents the list will be broken
> up to smaller 'bursts', which when traversing could cause latency.
> 
> sg_chunk_len might be another candidate.

Ok. We've got four candidates:
- max_sg_nents_burst
- max_sg_burst
- max_sg_chain
- sg_chunk_len

@Vinod, @Andy, what do you think?

-Sergey

> 
> > Vinod?
> > Andy (since you've already acked the patch)?
> > 
> > -Sergey
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
