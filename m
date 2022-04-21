Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E0750A738
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 19:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244756AbiDURiU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 13:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241579AbiDURiT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 13:38:19 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D854738C;
        Thu, 21 Apr 2022 10:35:28 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id n17so6620672ljc.11;
        Thu, 21 Apr 2022 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CDk3a6VgKrZuT8ZcRh1/xIe6Q0/s0tC/sVKTkENgNak=;
        b=HeelgZvGa0y6CTancPNWQ6vJjNAi4x3ORh1p9cTFIepZtsgDrk5Ua6dZiycoOCMVcL
         c4GF4hlUa93OAG6fjFG70QF72SD6PrFkoHV1ild6F5WtUNjX56+ZucwjS8QgIhLBMVk9
         QpsHGI+ifnv0PcHajHaqLWcLbi6w0wTAcWOpYB3zsIgeoZ9PZxnuYeAEHKN8PiPUvTkW
         tk4m8PijCv/+ZhESRdi9DypwJQb5g+NPDE9hd2T+FtJN+xX+UabFM0JJlhzrTcsSEnaq
         LMZDZ1VM7onPn8PAGmVO+bscs7PfEfZGf9HRPC7G23BkqZwfoFO6cQHTQ2CHu1k4T6RK
         OdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CDk3a6VgKrZuT8ZcRh1/xIe6Q0/s0tC/sVKTkENgNak=;
        b=6ja9LK+yBwBamsMfnmvQA32ZpfV8YWmYBoEr827m7A59WbHTJ3MoalQ7b1RBrLNpW/
         3XssaFL/anituinIjFP8oAXqAEztaEZS0lNx9PG/TnnghxVndIlOsfwlkX4qZ3BICj8g
         He3UZ0F6znyGCRsdV21s/hzUUrJ7qHGYYa2cfQUXueVFwqF4bwgg7hUWp1VEd3StN0FV
         JghjVc8Cs8kE6W0/rAoM/ER0XYOJrtZXgP3dt3d5dn1KEpXyYMauv0W0sc+t2VVRmNCm
         yqL8FqMWIMxfw+inY3je2a8hC4Y5aSf6Rx1BzcN8W6G2f2Nm5+S5mnil/++h+W2MNu3y
         4gBg==
X-Gm-Message-State: AOAM533HBIXfvEHK6NHMv/RsopXlGf4V2VqEuK8CNPfmywjR3hansVE8
        YUPjQG/hyx+Ty6myThRHe28=
X-Google-Smtp-Source: ABdhPJymumgPppR/Yl89vnqcwNccCGJXbwHpQ2AQqL54zDGwa3jfofsqs/k5W5r/iygpYJQNVkNePw==
X-Received: by 2002:a2e:9e10:0:b0:24b:5cb5:867c with SMTP id e16-20020a2e9e10000000b0024b5cb5867cmr458277ljk.401.1650562526246;
        Thu, 21 Apr 2022 10:35:26 -0700 (PDT)
Received: from mobilestation ([95.79.183.147])
        by smtp.gmail.com with ESMTPSA id m20-20020a194354000000b0046f8c68f965sm2004975lfj.166.2022.04.21.10.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:35:25 -0700 (PDT)
Date:   Thu, 21 Apr 2022 20:35:23 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 03/25] dma-direct: take dma-ranges/offsets into account
 in resource mapping
Message-ID: <20220421173523.ig62jtvj7qbno6q7@mobilestation>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru>
 <0baff803-b0ea-529f-095a-897398b4f63f@arm.com>
 <20220417224427.drwy3rchwplthelh@mobilestation>
 <20220420071217.GA5152@lst.de>
 <20220420083207.pd3hxbwezrm2ud6x@mobilestation>
 <20220420084746.GA11606@lst.de>
 <20220420085538.imgibqcyupvvjpaj@mobilestation>
 <20220421144536.GA23289@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421144536.GA23289@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 21, 2022 at 04:45:36PM +0200, Christoph Hellwig wrote:
> On Wed, Apr 20, 2022 at 11:55:38AM +0300, Serge Semin wrote:
> > On Wed, Apr 20, 2022 at 10:47:46AM +0200, Christoph Hellwig wrote:
> > > I can't really comment on the dma-ranges exlcusion for P2P mappings,
> > > as that predates my involvedment, however:
> > 
> > My example wasn't specific to the PCIe P2P transfers, but about PCIe
> > devices reaching some platform devices over the system interconnect
> > bus.
> 
> So strike PCIe, but this our definition of Peer to Peer accesses.
> 
> > What if I get to have a physical address of a platform device and want
> > have that device being accessed by a PCIe peripheral device? The
> > dma_map_resource() seemed very much suitable for that. But considering
> > what you say it isn't.
> 

> dma_map_resource is the right thing for that.  But the physical address
> of MMIO ranges in the platform device should not have struct pages
> allocated for it, and thus the other dma_map_* APIs should not work on
> it to start with.

The problem is that the dma_map_resource() won't work for that, but
presumably the dma_map_sg()-like methods will (after some hacking with
the phys address, but anyway). Consider the system diagram in my
previous email. Here is what I would do to initialize a DMA
transaction between a platform device and a PCIe peripheral device:

1) struct resource *rsc = platform_get_resource(plat_dev, IORESOURCE_MEM, 0);

2) dma_addr_t dar = dma_map_resource(&pci_dev->dev, rsc->start, rsc->end - rsc->start + 1,
                                      DMA_FROM_DEVICE, 0);

3) dma_addr_t sar;
   void *tmp = dma_alloc_coherent(&pci_dev->dev, PAGE_SIZE, &sar, GFP_KERNEL);
   memset(tmp, 0xaa, PAGE_SIZE);

4) PCIe device: DMA.DAR=dar, DMA.SAR=sar. RUN.

If there is no dma-ranges specified in the PCIe Host controller
DT-node, the PCIe peripheral devices will see the rest of the system
memory as is (no offsets and remappings). But if there is dma-ranges
with some specific system settings it may affect the PCIe MRd/MWr TLPs
address translation including the addresses targeted to the MMIO
space. In that case the mapping performed on step 2) will return a
wrong DMA-address since the corresponding dma_direct_map_resource()
just returns the passed physical address missing the
'pci_dev->dma_range_map'-based mapping performed in
translate_phys_to_dma().

Note the mapping on step 3) works correctly because it calls the
translate_phys_to_dma() of the direct DMA interface thus taking the
PCie dma-ranges into account.

To sum up as I see it either restricting dma_map_resource() to map
just the intra-bus addresses was wrong or there must be some
additional mapping infrastructure for the denoted systems. Though I
don't see a way the dma_map_resource() could be fixed to be suitable
for each considered cases.

-Sergey
   
map the platforms

