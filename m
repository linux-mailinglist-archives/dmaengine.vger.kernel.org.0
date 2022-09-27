Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456035EC017
	for <lists+dmaengine@lfdr.de>; Tue, 27 Sep 2022 12:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiI0Kss (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Sep 2022 06:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiI0Ksh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Sep 2022 06:48:37 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D761A1023B8;
        Tue, 27 Sep 2022 03:48:35 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id l12so10428988ljg.9;
        Tue, 27 Sep 2022 03:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=tD6fFmYeJzTuuK2jdpy00amrlyqkgZ5Un8L3kfeEcF8=;
        b=QJ5JaSFgxh4n89b6RIh5iJvHUsstk9b2AEeT63AnQ3oBbP61Caap6pEYPWyLOJbIrj
         7tMenbSWo4DlDZwNgaeExjDzlCfFC6j/u4HncM7VvZPIQ1wVudYJ4wjxDy+1UAoPRHS+
         RurA8rqqxXTI05eq7Rigpfzd9qee+fM7RTibyDO8kvxvhui2bAT5hrJ4r0OKmj83TOG+
         GJ3rJtXI3chTUgaFAu7+HuvE21zr1dDR0+kp00ity0rx7AC+PdYa8tY+DEyxDdXqXwsV
         6bO6ZhFCsaWb/YSunJ0JTKkHRF+bAFva+d6KSfcFFykbl/ZK/ZWV/UFRhcmQwoIk0VXb
         62Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=tD6fFmYeJzTuuK2jdpy00amrlyqkgZ5Un8L3kfeEcF8=;
        b=LL2tmjkKHtzF6UIPlFp73AScIAGXeirBtOOF+BAgyEizKtwgFOLig2aaU+rcAPJHCl
         ZBE+4QS5ZVbOt8cg+Vn6tWze0zwK32NH2Mje8IfcGWw/vvLuBeVs6bkiZiKx6NynLkd5
         tu/YvKEliokLk7CZE/xOLBAZU7/wl2qjvIOJn7x3agaBC7oWw50xVx+5EfeHorrKUhpp
         fl6mTePeDhQ9dQEYXnFFK904FXLI390sW8MuiNUOv+nhORSUOI/x386qiphim3mFBuUx
         dtSbMpMHz0N2PaoLmjpWKlSaa9gH0TU4vGhwu0z5Itc/Q+uakab5QR7oEb8/UtFnteNk
         +BAQ==
X-Gm-Message-State: ACrzQf29a62Z7/v8hHJI/A3ZaaSDScWUo8jkFGImdwPUWqIWimUCn3Zg
        Sgp4sFTu7KDGEYSBvyAhMrU=
X-Google-Smtp-Source: AMsMyM52lU3IpY51FkG3e8rm+8k9oJZqPUCZ6uvKv8ZTNPIHL7Y4SAbYANUYG8R7y/okhsrSXUXuUA==
X-Received: by 2002:a2e:9650:0:b0:26b:ef42:7168 with SMTP id z16-20020a2e9650000000b0026bef427168mr8903544ljh.346.1664275713981;
        Tue, 27 Sep 2022 03:48:33 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id o6-20020a05651238a600b004a100c21eaesm128071lft.97.2022.09.27.03.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 03:48:33 -0700 (PDT)
Date:   Tue, 27 Sep 2022 13:48:31 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH RESEND v5 22/24] dmaengine: dw-edma: Bypass dma-ranges
 mapping for the local setup
Message-ID: <20220927104831.bovlzl74osb4t5d3@mobilestation>
References: <20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru>
 <20220822185332.26149-23-Sergey.Semin@baikalelectronics.ru>
 <7a035b29-fca6-2650-c3c1-eedb3904c32d@arm.com>
 <20220912012426.xcg4tu6wzogbirp6@mobilestation>
 <5569ad73-9699-e326-c1fb-e0753bbdde78@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5569ad73-9699-e326-c1fb-e0753bbdde78@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Sep 26, 2022 at 03:08:01PM +0100, Robin Murphy wrote:
> On 2022-09-12 02:24, Serge Semin wrote:
> > On Wed, Aug 31, 2022 at 10:17:30AM +0100, Robin Murphy wrote:
> > > On 2022-08-22 19:53, Serge Semin wrote:
> > > > DW eDMA doesn't perform any translation of the traffic generated on the
> > > > CPU/Application side. It just generates read/write AXI-bus requests with
> > > > the specified addresses. But in case if the dma-ranges DT-property is
> > > > specified for a platform device node, Linux will use it to map the CPU
> > > > memory regions into the DMAable bus ranges. This isn't what we want for
> > > > the eDMA embedded into the locally accessed DW PCIe Root Port and
> > > > End-point. In order to work that around let's set the chan_dma_dev flag
> > > > for each DW eDMA channel thus forcing the client drivers to getting a
> > > > custom dma-ranges-less parental device for the mappings.
> > > > 
> > > > Note it will only work for the client drivers using the
> > > > dmaengine_get_dma_device() method to get the parental DMA device.
> > > 
> > 
> > > No, this is nonsense. If the DMA engine is on the host side of the bridge
> > > then it should not have anything to do with the PCI device at all, it should
> > > be associated with the platform device,
> > 
> > Well. The DMA-engine is embedded into the PCIe Root Port bus, is associated
> > with the platform device it's embedded to, and it doesn't have
> > anything to do with any particular PCI device.
> > 
> > > and thus any range mapping on the bridge itself would be irrelevant anyway.
> > 
> > Really? I find it otherwise. Please see the way the "dma-ranges"
> > property is parsed and works during the device-specific memory ranges
> > mapping when it's applicable for the PCIe Root Ports.
> 

> Sigh, that's a bug. Now I see where the confusion is coming from.

Finally we are on the same page.) I didn't thought it was a bug
though. Some details of the problem I described in another thread
earlier today:
Link: https://lore.kernel.org/linux-pci/20220926205333.qlhb5ojmx4sktzt5@mobilestation/
(See my note regarding the "dma-ranges" usage, which I accidentally
addressed to William instead of you.)

> 
> Annoyingly it's basically the exact thing I called out in 951d48855d86 when
> making dma-ranges work for non-OF PCI devices in the first place, but
> apparently neither I nor anyone else thought of this particular edge case at
> the time. Sorry about that. I'll have a look at how best to fix it.

You are right. The PCI-specific dma-ranges semantic hasn't been well
thought through in the first place. The child devices should have had
a dedicated method to set their own way of the memory ranges mapping.

Just a thought. As a possible solution for the dma-ranges property
being dedicated for the child devices we could introduce a new "space
code" of the dma-ranges property with a flag which would indicate the
actual bridge/host-controller memory range. If the dma-ranges property
doesn't have an entry with such code the mapping could be considered
as direct (in accordance with the parental dma-ranges properties).
IOMMU-part is applicable for all PCIe-related hierarchy - bridge itself
and peripheral devices.

> 
> Everything else still stands, though. If you can't use the original platform
> device for DMA API calls, at least configure the child device properly by
> calling of_dma_configure() with the parent's DT node in the expected manner
> (and manually remove its dma_range_map if you need an immediate workaround).

Do you mean something like this?

< 	struct dma_chan *dchan = ...;
< 	struct dw_edma_chan *chan = ...;
< 	struct device *parent = chan->dw->chip->dev;
<
< 	if (dev_of_node(parent)) {
< 		struct device_node *node = dev_of_node(parent);
< 
< 		ret = of_dma_configure(&chan->dev->device, node, true);
< 	} else if (has_acpi_companion(parent)) {
< 		struct acpi_device *adev = to_acpi_device_node(parent->fwnode);
<
< 		ret = acpi_dma_configure(&chan->dev->device, acpi_get_dma_attr(adev));
< 	} else {
<		ret = -EINVAL;
<	}
<
< 	if (ret)
< 		return ret;
<
<	/* Drop the detected dma-ranges mapping since it isn't applicable for
< 	 * the PCIe RP/EP bridge itself but to the peripheral devices only.
<	 */
<	dchan->dev->device.dma_range_map = NULL;
< 	dchan->dev->chan_dma_dev = true;
< 
< 	return 0;

What about the DMA-mask? Will it be ok if I copy it from the parental device?
Like this:

<	dma_coerce_mask_and_coherent(&dchan->dev->device, dma_get_mask(parent));

Judging by the of_dma_configure_id() method implementation the mask
upper bound is calculated based on the dma-ranges entries. Since the
DT-property isn't applicable for the PCIe host platform device itself
then it' upper bound most like will be invalid for the bridge too.

Regards,
-Sergey

> 
> Thanks,
> Robin.
