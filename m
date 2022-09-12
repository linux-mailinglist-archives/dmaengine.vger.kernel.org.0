Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC945B5268
	for <lists+dmaengine@lfdr.de>; Mon, 12 Sep 2022 03:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiILBYf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 11 Sep 2022 21:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiILBYe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 11 Sep 2022 21:24:34 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33626E0B;
        Sun, 11 Sep 2022 18:24:32 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id p5so8815935ljc.13;
        Sun, 11 Sep 2022 18:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=L5Fh/joIDcg5b/gOBOrGumLyR4iznWiysgnN0ur4ZW4=;
        b=OhwiIHp3Pj4CBhTeepPdzWcnpYVUE9VwYka9xsxcd6UQFOec9/LVRHpU/VwK+ysElf
         cp793Cqb+zS2QlSSitB5ypMCrps0VlxmNjxI9GYYXLEPBY5s2jNXgHluT2LExQx909mQ
         mFn1FyzutjLxGwDBTtQ+spMTdZsXSzoPcWVzi1rOThK7jHqPrFyrI6lWmj0F2K1nRPHK
         jvoGe0PJi71svLXKXFMAfzK57QzinJ4K0S+kvXH/Pq3A0PqoSARtI8ffpn7iK5U6PVWV
         WSKFy7p3bNaW6hwJm38ibg+lVlSpjQfY0mAskWgeXr2jk6AOdWjXZCfJ19PlP2vF/BK5
         Jo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=L5Fh/joIDcg5b/gOBOrGumLyR4iznWiysgnN0ur4ZW4=;
        b=jszOcQ3ey1kw4lTxFn9sAQ6AZ2SrRcz+yHUykngHbb2k9rFGPmbHtQS7yAqzvIozL0
         FmsUYKfGjBDgX1y94wo61JoSvPRsikrbUFSf9TmJijFvtSv2tSTzSjrv3GTImrHnwrmW
         10Lw0JQw6aOKKyoXuk4s8ox81sL0mVnDe7FpuDgZErC+phtCJ7NOHrIhW0XtyHt2eqw7
         bAtgXVi2ry+h3bKSsgkn/+XryupObTo1LI0i5qJywY3fP+iPBvIEucSxPVsfmo6/MC1V
         uxq2qhKQ9JRIn7E6RHEh4wrT4oxxhCliIRn95uZXJiRCohgvsc+X9tDDIejLcgAhxMtj
         5icw==
X-Gm-Message-State: ACgBeo18Ps1BUtWBqt2mMTcbaByvj+Ztn2+W50tfjDE4CVBv2xkvsddG
        6uE6+i1njpFxYZRXS0YcLaQ=
X-Google-Smtp-Source: AA6agR7WYKXi5FrvrZwo9YjKCKKzszbzfSMrE9s+S7hamuNKbPSroMGiE23ADZ01XN7Sk92JaLfYwQ==
X-Received: by 2002:a2e:808f:0:b0:26a:b498:2c87 with SMTP id i15-20020a2e808f000000b0026ab4982c87mr7265597ljg.279.1662945870385;
        Sun, 11 Sep 2022 18:24:30 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id t2-20020ac243a2000000b00497a8f04905sm780384lfl.251.2022.09.11.18.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 18:24:29 -0700 (PDT)
Date:   Mon, 12 Sep 2022 04:24:26 +0300
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
Message-ID: <20220912012426.xcg4tu6wzogbirp6@mobilestation>
References: <20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru>
 <20220822185332.26149-23-Sergey.Semin@baikalelectronics.ru>
 <7a035b29-fca6-2650-c3c1-eedb3904c32d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a035b29-fca6-2650-c3c1-eedb3904c32d@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Aug 31, 2022 at 10:17:30AM +0100, Robin Murphy wrote:
> On 2022-08-22 19:53, Serge Semin wrote:
> > DW eDMA doesn't perform any translation of the traffic generated on the
> > CPU/Application side. It just generates read/write AXI-bus requests with
> > the specified addresses. But in case if the dma-ranges DT-property is
> > specified for a platform device node, Linux will use it to map the CPU
> > memory regions into the DMAable bus ranges. This isn't what we want for
> > the eDMA embedded into the locally accessed DW PCIe Root Port and
> > End-point. In order to work that around let's set the chan_dma_dev flag
> > for each DW eDMA channel thus forcing the client drivers to getting a
> > custom dma-ranges-less parental device for the mappings.
> > 
> > Note it will only work for the client drivers using the
> > dmaengine_get_dma_device() method to get the parental DMA device.
> 

> No, this is nonsense. If the DMA engine is on the host side of the bridge
> then it should not have anything to do with the PCI device at all, it should
> be associated with the platform device,

Well. The DMA-engine is embedded into the PCIe Root Port bus, is associated
with the platform device it's embedded to, and it doesn't have
anything to do with any particular PCI device.

> and thus any range mapping on the bridge itself would be irrelevant anyway.

Really? I find it otherwise. Please see the way the "dma-ranges"
property is parsed and works during the device-specific memory ranges
mapping when it's applicable for the PCIe Root Ports.

> 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Acked-By: Vinod Koul <vkoul@kernel.org>
> > 
> > ---
> > 
> > Changelog v2:
> > - Fix the comment a bit to being clearer. (@Manivannan)
> > 
> > Changelog v3:
> > - Conditionally set dchan->dev->device.dma_coherent field since it can
> >    be missing on some platforms. (@Manivannan)
> > - Remove Manivannan' rb and tb tags since the patch content has been
> >    changed.
> > ---
> >   drivers/dma/dw-edma/dw-edma-core.c | 20 ++++++++++++++++++++
> >   1 file changed, 20 insertions(+)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 6a8282eaebaf..4f56149dc8d8 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -716,6 +716,26 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
> >   	if (chan->status != EDMA_ST_IDLE)
> >   		return -EBUSY;
> > +	/* Bypass the dma-ranges based memory regions mapping for the eDMA
> > +	 * controlled from the CPU/Application side since in that case
> > +	 * the local memory address is left untranslated.
> > +	 */
> > +	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
> > +		dchan->dev->chan_dma_dev = true;
> > +
> > +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> > +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> > +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
> > +		dchan->dev->device.dma_coherent = chan->dw->chip->dev->dma_coherent;
> > +#endif
> > +
> > +		dma_coerce_mask_and_coherent(&dchan->dev->device,
> > +					     dma_get_mask(chan->dw->chip->dev));
> > +		dchan->dev->device.dma_parms = chan->dw->chip->dev->dma_parms;
> > +	} else {
> > +		dchan->dev->chan_dma_dev = false;
> > +	}
> 

> NAK. Don't try to poke into DMA API internals and copy random partial pieces
> between devices, it doesn't work properly (I can guess that your system
> doesn't have an IOMMU...) and having to deal with ugly mess like this in
> drivers just makes it harder for us to maintain the DMA API itself.

Hold on with that angry tone. First of all I don't really see you
fixing the drivers/dma/ti/k3-udma.c driver then. Second read more
carefully the patch log. Judging by your comments you don't fully
understand the problem.

> 
> Fair enough if you have good reason to create logical child devices to
> represent individual DMA channels, but the correct way to handle that is to
> keep the real parent device pointer around and use that for DMA API calls.

That's what is in my patches. The problem is that the "dma-ranges"
property specified for the parental PCIe Root Port device isn't
applicable for the DMA-engine embedded into it. The "dma-ranges" is
supposed to be used for the PCIe-bus peripheral devices since their
MRw/MRd TLPs are translated by means of the Inbound iATU engine. The
IO accesses generated by the PCIe controller itself aren't affected by
iATU. So any mapping performed for the PCIe Root Port controller
platform device mustn't take these DMA-ranges into account. That's why
I need to enable the "chan_dma_dev" DMA-engine capability and just
copy the main DMA-parts of the parental device except the
"dma_range_map" data. If you have any better suggestion in mind
please share, but what you've said so far definitely won't give us any
explicit solution.

-Sergey

> 
> Robin.
> 
> > +
> >   	pm_runtime_get(chan->dw->chip->dev);
> >   	return 0;
