Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7147D50D555
	for <lists+dmaengine@lfdr.de>; Sun, 24 Apr 2022 23:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239362AbiDXVuE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 Apr 2022 17:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiDXVuC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 24 Apr 2022 17:50:02 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A00644DF;
        Sun, 24 Apr 2022 14:46:59 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bu29so23195746lfb.0;
        Sun, 24 Apr 2022 14:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O4TlWAQTGna1HLPkbwNGfYip8R7dhlaXVZwPwiVBy7I=;
        b=UlSSti4Gm4qX+QRhOj+j+pgM3p+/451e5FFrO24ItSZzGf09wrm+Q7aExA773zXOex
         tJVHSLYUKeagNc5STZSmtACkjhwgUK2vd4Pkv5YtEsnPfyRDMnUDHOwx5eY6VfkwQ9Dj
         aqDdPK3ys/rf3e7FbqpWvSrlBqB+2WfT+i3xAZ+LD3W1Ke2jDCWt185vFyVMtGDhbtsd
         tEQsrEnUusJI1p1MW5sg/DFInDAPJXTeZNMK7RGEJA/8FPo8EcMlIzfR5i1YRz1MztDz
         Xy1owQqn/r5E+JLMNOQo2DAChV9RWNo/H7Suagq+YDxfBRgbbVvt9wFkpRHOE070RDW0
         URsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O4TlWAQTGna1HLPkbwNGfYip8R7dhlaXVZwPwiVBy7I=;
        b=hmEM6W0u8dmBJUakBgW8FVaDU7vFvIZw/vi5k4L+R6D6vfSqQMuEIJRPVOczyIVB3+
         eGY6Sq0oRvDBNP3pXN8Jdk8rVKnIfbTgnIpykui2TTsVIe53oiutWbjal9UWypkGjmJl
         zg0dmo9v/GeuVU0rRNQbTt/+fG4EjhNe+tgAVoDH9y3GZnbWMDhGSHgQFSLcxoF/U28f
         heXv9jE09rkmbfvZ8YBjUgw8mKDT7NgN8vMsSVxln+7q4lKyhdZh+BwrASZdHRKezdUe
         9YDo6jx8D+DFcB5mXYFxpa52wBzeiOBzy/l7rkkNlDcYkd7nirZZ1oxZeZybn91g4HsI
         IdbQ==
X-Gm-Message-State: AOAM533ne+/sq108ANGFgqGsOS2Ex7NO2fD/UMaOW/hN9veRKDV5GRZB
        CYHJ0riHZBkPgj58fI4tvY/THdIlwvxYow==
X-Google-Smtp-Source: ABdhPJzXdDxrhX4Vc85ccNr29jeZJ973N9zfir+519pEyy1H/jYBWoVgnoUIbo6sVuzS8PxTClQuEQ==
X-Received: by 2002:ac2:5581:0:b0:471:6c00:ba6e with SMTP id v1-20020ac25581000000b004716c00ba6emr11353806lfg.482.1650836817827;
        Sun, 24 Apr 2022 14:46:57 -0700 (PDT)
Received: from mobilestation ([95.79.183.147])
        by smtp.gmail.com with ESMTPSA id t27-20020a192d5b000000b00470880c1abcsm1150711lft.217.2022.04.24.14.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 14:46:57 -0700 (PDT)
Date:   Mon, 25 Apr 2022 00:46:54 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Rob Herring <robh@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 03/25] dma-direct: take dma-ranges/offsets into account
 in resource mapping
Message-ID: <20220424214654.d53jbthts53g755p@mobilestation>
References: <20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru>
 <0baff803-b0ea-529f-095a-897398b4f63f@arm.com>
 <20220417224427.drwy3rchwplthelh@mobilestation>
 <20220420071217.GA5152@lst.de>
 <20220420083207.pd3hxbwezrm2ud6x@mobilestation>
 <20220420084746.GA11606@lst.de>
 <20220420085538.imgibqcyupvvjpaj@mobilestation>
 <20220421144536.GA23289@lst.de>
 <20220421173523.ig62jtvj7qbno6q7@mobilestation>
 <f238af77-be5e-43cc-6a8c-338408c1667e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f238af77-be5e-43cc-6a8c-338408c1667e@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 21, 2022 at 09:51:31PM +0100, Robin Murphy wrote:
> On 2022-04-21 18:35, Serge Semin wrote:
> > On Thu, Apr 21, 2022 at 04:45:36PM +0200, Christoph Hellwig wrote:
> > > On Wed, Apr 20, 2022 at 11:55:38AM +0300, Serge Semin wrote:
> > > > On Wed, Apr 20, 2022 at 10:47:46AM +0200, Christoph Hellwig wrote:
> > > > > I can't really comment on the dma-ranges exlcusion for P2P mappings,
> > > > > as that predates my involvedment, however:
> > > > 
> > > > My example wasn't specific to the PCIe P2P transfers, but about PCIe
> > > > devices reaching some platform devices over the system interconnect
> > > > bus.
> > > 
> > > So strike PCIe, but this our definition of Peer to Peer accesses.
> > > 
> > > > What if I get to have a physical address of a platform device and want
> > > > have that device being accessed by a PCIe peripheral device? The
> > > > dma_map_resource() seemed very much suitable for that. But considering
> > > > what you say it isn't.
> > > 
> > 
> > > dma_map_resource is the right thing for that.  But the physical address
> > > of MMIO ranges in the platform device should not have struct pages
> > > allocated for it, and thus the other dma_map_* APIs should not work on
> > > it to start with.
> > 
> > The problem is that the dma_map_resource() won't work for that, but
> > presumably the dma_map_sg()-like methods will (after some hacking with
> > the phys address, but anyway). Consider the system diagram in my
> > previous email. Here is what I would do to initialize a DMA
> > transaction between a platform device and a PCIe peripheral device:
> > 
> > 1) struct resource *rsc = platform_get_resource(plat_dev, IORESOURCE_MEM, 0);
> > 
> > 2) dma_addr_t dar = dma_map_resource(&pci_dev->dev, rsc->start, rsc->end - rsc->start + 1,
> >                                        DMA_FROM_DEVICE, 0);
> > 
> > 3) dma_addr_t sar;
> >     void *tmp = dma_alloc_coherent(&pci_dev->dev, PAGE_SIZE, &sar, GFP_KERNEL);
> >     memset(tmp, 0xaa, PAGE_SIZE);
> > 
> > 4) PCIe device: DMA.DAR=dar, DMA.SAR=sar. RUN.
> > 
> > If there is no dma-ranges specified in the PCIe Host controller
> > DT-node, the PCIe peripheral devices will see the rest of the system
> > memory as is (no offsets and remappings). But if there is dma-ranges
> > with some specific system settings it may affect the PCIe MRd/MWr TLPs
> > address translation including the addresses targeted to the MMIO
> > space. In that case the mapping performed on step 2) will return a
> > wrong DMA-address since the corresponding dma_direct_map_resource()
> > just returns the passed physical address missing the
> > 'pci_dev->dma_range_map'-based mapping performed in
> > translate_phys_to_dma().
> > 
> > Note the mapping on step 3) works correctly because it calls the
> > translate_phys_to_dma() of the direct DMA interface thus taking the
> > PCie dma-ranges into account.
> > 
> > To sum up as I see it either restricting dma_map_resource() to map
> > just the intra-bus addresses was wrong or there must be some
> > additional mapping infrastructure for the denoted systems. Though I
> > don't see a way the dma_map_resource() could be fixed to be suitable
> > for each considered cases.
> 

> FWIW the current semantics of dma_map_resource() are basically just to
> insert IOMMU awareness where dmaengine drivers were previously just casting
> phys_addr_t to dma_addr_t (or u32, or whatever else they put into their
> descriptor/register/etc.) IIRC there was a bit of a question whether it
> really belonged in the DMA API at all, since it's not really a "DMA"
> operation in the conventional sense, and convenience was the only real
> deciding argument. The relevant drivers at the time were not taking
> dma_pfn_offset into account when consuming physical addresses directly, so
> the new API didn't either.
> 
> That's just how things got to where they are today. 

I see. Thanks for the clarification. Right, IOMMU is the only reason
to have the current dma_map_resource() implementation.

> Once again, I'm not
> saying that what we have now is necessarily right, or that your change is
> necessarily wrong, I just really want to understand specifically *why* you
> need to make it, so we can evaluate the risk of possible breakage either
> way. Theoretical "if"s aren't really enough.

As I already said our SoC has the next structure (obviously the
diagram is very simplified, but the gist is the same):
              +-----+
              | DDR |
              +--+--+
                 |
  +-----+ +------+-------+ +---------+
  | CPU +-+ Interconnect +-+ DEVs... |
  +-----+ +-----^-+------+ +---------+
     dma-ranges-| |-ranges
              +-+-v-+
              | PCI |
              +-----+
The PCIe peripheral devices are connected to the rest of the system
via the DW PCIe Host controller. If the controller has the inbound
iATU configured to re-map the system memory (RAM, IOMEM) in a
non-one-to-one way (using the dma-ranges DT property of the PCIe host
controller), then all the PCIe bus MRd/MWr TLP addresses will be
accordingly translated on a way to all the connected to the
interconnect slave devices including the MMIO devices. The kernel DMA
API at this moment provides the only methods to get the PCIe-bus
visible RAM addresses, while the physical addresses (for instance of
the MMIO devices) can't be correctly translated for such case. I
thought that dma_map_resource() could do the trick, but it turned out
it didn't get the dma-ranges mapping into account.

To be fully honest currently we don't really have any platform which
would have had the strong requirement of doing DMA from the PCIe
peripheral devices to the platform devices. But since the PCIe bus is
the extendable bus (cold and hot pluggable) then such requirement may
arise in the practice for instance on a platform with the PCIe NTB
device attached to the PCIe bus and configured to access the system
MMIO devices via the bridge. That part I find potentially problematic
seeing the practical usecase is unsupported just due to the incomplete
API. Moreover the dma_direct_map_resource() method semantic being
different from the rest of the direct DMA mapping methods doesn't seem
right from the usability point of view. Finally as you can see having
the dma_direct_map_resource() defined as MMIO-specific doesn't
mean that the dma_pfn_offset-based mapping isn't supposed to be taken
into account.

-Sergey

> 
> Robin.
