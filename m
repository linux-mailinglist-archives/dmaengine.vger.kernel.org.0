Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22206649566
	for <lists+dmaengine@lfdr.de>; Sun, 11 Dec 2022 18:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiLKRdp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 11 Dec 2022 12:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiLKRdp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 11 Dec 2022 12:33:45 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31361DEAB;
        Sun, 11 Dec 2022 09:33:43 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id z4so10203121ljq.6;
        Sun, 11 Dec 2022 09:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eCA+ESw2O4jwFU+4PiuKyyj+p2JGfKrFRUlGANlskWk=;
        b=BpG3MHUS0oiWb2nLBw/YM90o7Gt/LHngXjWirgfjItBrOLw6xFfQvij7LmACaYjIUM
         IvdU0ts9VA/T4BFaky85C9W3dvScOydI8jExJm3PTsT0vz/tykiajdopHYscUlvbDFWP
         7xLtfD4HzYyprNGr2SsYJRkXZvsLqRrU52/Jp2lAXjf49nXCUDIjZYlBavhRbjnw/OXN
         OpIRkEK9pouXD4gVNbm4aNr3OXbzyB78rhyJArGPcxnMphSginKiLjYg4NGuko9lyBkI
         Xzm+GL+iXsqtShqb6j3nVJsvVfJOJLtySUYi1EFtCuBjwtrvnnzQTBKsU6HsqVBJNBh4
         Hyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCA+ESw2O4jwFU+4PiuKyyj+p2JGfKrFRUlGANlskWk=;
        b=qbJtN3tae2MLh+xHMo4g9gDRe7HK+9jnINXiOa8QxlekADD2SBwMPsMcjHzNJz2eTD
         FES+Y2Xkbzo5tjCH0dKeZ8s4vIKk/+LWCl9nMcjflrUxcjbpHTS9dg3cmVkt79i0gw3m
         9Ll3Nj5oPryUlIuWgjXwglHqSYzlISZgCB7mDcUpOaOh6lmeW8fwPlSPpm9n8y8zHn8h
         uF3OggSi14xBBkr6TdJBC1gDbpEWeZJkTwYKqyHLSlBi4r+F36eX4d8s0ZUnqZw2tSqN
         9Ke4W8xM+zAu2FosmfEWfkZYYKPE2M5D1V3Ak4ISEEruIhFjUfkArePoicKepO8d2j6b
         C25A==
X-Gm-Message-State: ANoB5pmAg8fglM9Kf7ZWfp79etnkS6XCg7dir/69YsiQ90/nsrLElhwV
        4rGwjJLaPimkIbOG+trprTs=
X-Google-Smtp-Source: AA0mqf5ZTZ7Tqam4vP6jFXMn1RCZFD/CgBoi+rAahGysvjNAvMtNDqeNpadq7U+ZGA4slPKqq3Acjg==
X-Received: by 2002:a2e:7819:0:b0:279:d3ba:81c1 with SMTP id t25-20020a2e7819000000b00279d3ba81c1mr3255854ljc.31.1670780021477;
        Sun, 11 Dec 2022 09:33:41 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id a15-20020a05651c030f00b0027a081bfee9sm971108ljp.43.2022.12.11.09.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 09:33:40 -0800 (PST)
Date:   Sun, 11 Dec 2022 20:33:38 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 22/24] dmaengine: dw-edma: Bypass dma-ranges mapping
 for the local setup
Message-ID: <20221211173338.a57dhnw5ik6arcof@mobilestation>
References: <20221107210438.1515-1-Sergey.Semin@baikalelectronics.ru>
 <20221107210438.1515-23-Sergey.Semin@baikalelectronics.ru>
 <20221107211134.wxaqi2sew6aejxne@mobilestation>
 <8b7ce195-27b7-a27f-bf4e-fd5f20f2a83b@arm.com>
 <20221126234509.ezn6vuefnj2f7pyk@mobilestation>
 <136b735e-43b0-59bd-c85b-291730cd6371@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <136b735e-43b0-59bd-c85b-291730cd6371@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Dec 01, 2022 at 11:52:19AM +0000, Robin Murphy wrote:
> On 2022-11-26 23:45, Serge Semin wrote:
> > On Fri, Nov 25, 2022 at 03:32:23PM +0000, Robin Murphy wrote:
> > > On 2022-11-07 21:11, Serge Semin wrote:
> > > > On Tue, Nov 08, 2022 at 12:04:36AM +0300, Serge Semin wrote:
> > > > > DW eDMA doesn't perform any translation of the traffic generated on the
> > > > > CPU/Application side. It just generates read/write AXI-bus requests with
> > > > > the specified addresses. But in case if the dma-ranges DT-property is
> > > > > specified for a platform device node, Linux will use it to create a
> > > > > mapping the PCIe-bus regions into the CPU memory ranges. This isn't what
> > > > > we want for the eDMA embedded into the locally accessed DW PCIe Root Port
> > > > > and End-point. In order to work that around let's set the chan_dma_dev
> > > > > flag for each DW eDMA channel thus forcing the client drivers to getting a
> > > > > custom dma-ranges-less parental device for the mappings.
> > > > > 
> > > > > Note it will only work for the client drivers using the
> > > > > dmaengine_get_dma_device() method to get the parental DMA device.
> > > > 
> > > > @Robin, we particularly need you opinion on this patch. I did as you
> > > > said: call *_dma_configure() method to initialize the child device and
> > > > set the DMA-mask here instead of the platform driver.
> > > 
> > 
> > > Apologies, I've been busy and this series got buried in my inbox before I'd
> > > clocked it as something I was supposed to be looking at.
> > 
> > No worries. I'm glad you responded.
> > 
> > > 
> > > > @Vinoud, @Manivannan I had to drop your tags from this patch since its
> > > > content had been significantly changed.
> > > > 
> > > > -Sergey
> > > > 
> > > > > 
> > > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > > 
> > > > > ---
> > > > > 
> > > > > Changelog v2:
> > > > > - Fix the comment a bit to being clearer. (@Manivannan)
> > > > > 
> > > > > Changelog v3:
> > > > > - Conditionally set dchan->dev->device.dma_coherent field since it can
> > > > >     be missing on some platforms. (@Manivannan)
> > > > > - Remove Manivannan' rb and tb tags since the patch content has been
> > > > >     changed.
> > > > > 
> > > > > Changelog v6:
> > > > > - Directly call *_dma_configure() method on the child device used for
> > > > >     the DMA buffers mapping. (@Robin)
> > > > > - Explicitly set the DMA-mask of the child device in the channel
> > > > >     allocation proecedure. (@Robin)
> > > > > - Drop @Manivannan and @Vinod rb- and ab-tags due to significant patch
> > > > >     content change.
> > > > > ---
> > > > >    drivers/dma/dw-edma/dw-edma-core.c | 44 ++++++++++++++++++++++++++++++
> > > > >    1 file changed, 44 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > index e3671bfbe186..846518509753 100644
> > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > @@ -6,9 +6,11 @@
> > > > >     * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > > >     */
> > > > > +#include <linux/acpi.h>
> > > > >    #include <linux/module.h>
> > > > >    #include <linux/device.h>
> > > > >    #include <linux/kernel.h>
> > > > > +#include <linux/of_device.h>
> > > > >    #include <linux/dmaengine.h>
> > > > >    #include <linux/err.h>
> > > > >    #include <linux/interrupt.h>
> > > > > @@ -711,10 +713,52 @@ static irqreturn_t dw_edma_interrupt_common(int irq, void *data)
> > > > >    static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
> > > > >    {
> > > > >    	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > > > > +	struct device *dev = chan->dw->chip->dev;
> > > > > +	int ret;
> > > > >    	if (chan->status != EDMA_ST_IDLE)
> > > > >    		return -EBUSY;
> > > > > +	/* Bypass the dma-ranges based memory regions mapping for the eDMA
> > > > > +	 * controlled from the CPU/Application side since in that case
> > > > > +	 * the local memory address is left untranslated.
> > > > > +	 */
> > > > > +	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
> > 
> > 
> > > > > +		ret = dma_coerce_mask_and_coherent(&dchan->dev->device,
> > > > > +						   DMA_BIT_MASK(64));
> > > > > +		if (ret) {
> > > 
> > > Setting a 64-bit mask should never fail, especially on any platform that
> > > will actually run this code.
> > > 
> > > > > +			ret = dma_coerce_mask_and_coherent(&dchan->dev->device,
> > > > > +							   DMA_BIT_MASK(32));
> > 
> > Indeed. I can just drop the 32-bit mask test then. (But I'd retain the
> > error check anyway.)
> > 
> > The problem is that actual device DMA-addressing capability is
> > determined by the MASTER_BUS_ADDR_WIDTH IP-core synthesize parameter.
> > I can't predict its value from this generic code since it isn't
> > auto-detectable and is platform-specific. That's why back then in
> > our discussion I was insisting on setting the mask in the low-level
> > device drivers. But after the commit 423511ec23e2 ("PCI: dwc: Drop
> > dependency on ZONE_DMA32") it turned to be pointless now since the
> > DMA-mask would be overwritten by the generic DW PCIe driver code anyway.
> > What do you suggest then in this regard? Just keep setting the 64-bit
> > mask only? This will work for my platform, but will fail for the
> > devices with AXI-bus address of only 32-bits width.
> 
> OK, but you already have that problem either way. The point of
> dma_set_mask() et al is to inform the DMA API of your device's capability -
> setting a 64-bit mask is saying "I can use 64-bit addresses if you can" to
> the DMA layer, and as I say the DMA layer is almost always going to respond
> "indeed I can, let's do that". If the real DMA mask is platform-specific
> then you need to pass a platform-specific value here.
> 
> > > > > +			if (ret)
> > > > > +				return ret;
> > > > > +		}
> > > > > +
> > > > > +		if (dev_of_node(dev)) {
> > > > > +			struct device_node *node = dev_of_node(dev);
> > > > > +
> > > > > +			ret = of_dma_configure(&dchan->dev->device, node, true);
> > > > > +		} else if (has_acpi_companion(dev)) {
> > > 
> > 
> > > Can this can ever happen? AFAICS there's no ACPI binding to match and probe
> > > the DWC driver, at best it could only probe as a standard PNP0A08 host
> > > bridge which wouldn't know anything about eDMA anyway.
> > 
> > There are several ACPI-based platforms with DW PCIe controllers:
> > pcie-tegra194-acpi.c, pcie-al.c, pcie-hisi.c. All of them are fully
> > ECAM-based so no DW eDMA probing from the Linux kernel implied. But
> > these are still DW PCIe controllers and they or some other ones can
> > have eDMA embedded. Do you think it won't be ever possible to either
> > directly handle these controllers (bypassing the ECAM interface) or
> > have a DW PCIe device accessed via the ACPI bindings?
> 
> It's not entirely impossible, but would require new ACPI bindings and code
> changes to the dw-pci driver, so if somebody ever did do that work they
> should be responsible for any required changes at this end as well. There's
> no point adding untested dead code now, to maintain indefinitely just for
> the theoretical possibility that someone might ever make it reachable.
> 
> > Note basically what I've implemented here was based on the
> > platform_dma_configure() DMA-configuration code pattern. I thought it
> > was a reasonable choice since this code path is executed for the
> > platform devices only (implied by the DW_EDMA_CHIP_LOCAL flag
> > semantic).
> > 
> > On the second thought if the problem in subject is only specific to
> > the DT-based platforms, then I could just skip channel device
> > initialization here for the platform devices with no OF-node detected.
> > So the question is is it specific to the DT-based platforms only?
> 
> I think you still want the DW_EDMA_CHIP_LOCAL flag, since the PCI endpoint
> device in the dw-edma-pcie case may have an of_node on some platforms, and
> in that case overriding the chan_dma_dev setup would be wrong. When the flag
> is set, though, we can simply assume dev_of_node() is valid since it's the
> only possible way for that to happen (and if someone does ever break that
> assumption in future, it will likely make itself noticed).
> 
> > (Before answering to the question above please read the last comment
> > in this message.)
> > 
> > > 
> > > > > +			struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
> > > > > +
> > > > > +			ret = acpi_dma_configure(&dchan->dev->device,
> > > > > +						 acpi_get_dma_attr(adev));
> > > > > +		} else {
> > > > > +			ret = -EINVAL;
> > > > > +		}
> > > > > +
> > > > > +		if (ret)
> > > > > +			return ret;
> > > > > +
> > > > > +		if (dchan->dev->device.dma_range_map) {
> > > > > +			kfree(dchan->dev->device.dma_range_map);
> > > > > +			dchan->dev->device.dma_range_map = NULL;
> > > > > +		}
> > > 
> > 
> > > Ugh, I guess this is still here because now you're passing the channel
> > > device to of_dma_configure() such that it looks like a PCI child :(
> > 
> > No. It's still here because I successfully missed your email in my
> > work inbox so I thought you didn't fix that dma-ranges peculiarity of
> > the PCIe-host nodes.(
> > 
> > > 
> > > Can we just set "chan->dev->device.of_node = dev->of_node;" beforehand so it
> > > works as expected (with f1ad5338a4d5 in place) and we don't need to be
> > > messing with the dma_range_map details at all? Note that that isn't as hacky
> > > as it might sound - it's a relatively well-established practice in places
> > > like I2C and SPI, and in this case it seems perfectly appropriate
> > > semantically as well.
> > 
> > Of course we can. But now, thanks to your commit f1ad5338a4d5 ("of:
> > Fix "dma-ranges" handling for bus controllers"), there is no point in
> > any dma-ranges hack here because the dma-ranges property is no longer
> > parsed for the PCIe-host platform device. I can and will just drop the
> > custom DMA-channel device initialization from the patch. The only
> > issue left to solve is about setting the DMA-mask. Please see my notes
> > above regarding that problem.
> 

> Ah, I assumed you'd still want to keep the chan_dma_dev setup for the sake
> of independent DMA masks, at least until we get a better solution for the
> MSI stuff. If you're happy with the compromise of going back to using the
> real host device to keep things simple, that's fine by me.

My biggest concern was connected with the 'dma-ranges' problem. The
DMA-mask thing was another issue, but since the eDMA setup is executed
after the MSI setup we can just override the mask specified by the
later procedure. Though I'll have to add some loud comment regarding
that implicit order requirement.

In anyway thanks for your fix. I'll resubmit the series with the
DMA-mask overridden in the dw_edma_probe() method. The mask will be
calculated based on an additional flag specified in the
dw_edma_chip.flags field. It seems like the best solution at this
stage.

-Serge(y)

> 
> Thanks,
> Robin.
