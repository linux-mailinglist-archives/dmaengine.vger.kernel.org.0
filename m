Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B3350AA56
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 22:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392566AbiDUUyd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 16:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392565AbiDUUyd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 16:54:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B8CF4D26F;
        Thu, 21 Apr 2022 13:51:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDBE31477;
        Thu, 21 Apr 2022 13:51:41 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B30B3F5A1;
        Thu, 21 Apr 2022 13:51:38 -0700 (PDT)
Message-ID: <f238af77-be5e-43cc-6a8c-338408c1667e@arm.com>
Date:   Thu, 21 Apr 2022 21:51:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 03/25] dma-direct: take dma-ranges/offsets into account in
 resource mapping
Content-Language: en-GB
To:     Serge Semin <fancer.lancer@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Rob Herring <robh@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
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
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru>
 <0baff803-b0ea-529f-095a-897398b4f63f@arm.com>
 <20220417224427.drwy3rchwplthelh@mobilestation>
 <20220420071217.GA5152@lst.de>
 <20220420083207.pd3hxbwezrm2ud6x@mobilestation>
 <20220420084746.GA11606@lst.de>
 <20220420085538.imgibqcyupvvjpaj@mobilestation>
 <20220421144536.GA23289@lst.de>
 <20220421173523.ig62jtvj7qbno6q7@mobilestation>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220421173523.ig62jtvj7qbno6q7@mobilestation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2022-04-21 18:35, Serge Semin wrote:
> On Thu, Apr 21, 2022 at 04:45:36PM +0200, Christoph Hellwig wrote:
>> On Wed, Apr 20, 2022 at 11:55:38AM +0300, Serge Semin wrote:
>>> On Wed, Apr 20, 2022 at 10:47:46AM +0200, Christoph Hellwig wrote:
>>>> I can't really comment on the dma-ranges exlcusion for P2P mappings,
>>>> as that predates my involvedment, however:
>>>
>>> My example wasn't specific to the PCIe P2P transfers, but about PCIe
>>> devices reaching some platform devices over the system interconnect
>>> bus.
>>
>> So strike PCIe, but this our definition of Peer to Peer accesses.
>>
>>> What if I get to have a physical address of a platform device and want
>>> have that device being accessed by a PCIe peripheral device? The
>>> dma_map_resource() seemed very much suitable for that. But considering
>>> what you say it isn't.
>>
> 
>> dma_map_resource is the right thing for that.  But the physical address
>> of MMIO ranges in the platform device should not have struct pages
>> allocated for it, and thus the other dma_map_* APIs should not work on
>> it to start with.
> 
> The problem is that the dma_map_resource() won't work for that, but
> presumably the dma_map_sg()-like methods will (after some hacking with
> the phys address, but anyway). Consider the system diagram in my
> previous email. Here is what I would do to initialize a DMA
> transaction between a platform device and a PCIe peripheral device:
> 
> 1) struct resource *rsc = platform_get_resource(plat_dev, IORESOURCE_MEM, 0);
> 
> 2) dma_addr_t dar = dma_map_resource(&pci_dev->dev, rsc->start, rsc->end - rsc->start + 1,
>                                        DMA_FROM_DEVICE, 0);
> 
> 3) dma_addr_t sar;
>     void *tmp = dma_alloc_coherent(&pci_dev->dev, PAGE_SIZE, &sar, GFP_KERNEL);
>     memset(tmp, 0xaa, PAGE_SIZE);
> 
> 4) PCIe device: DMA.DAR=dar, DMA.SAR=sar. RUN.
> 
> If there is no dma-ranges specified in the PCIe Host controller
> DT-node, the PCIe peripheral devices will see the rest of the system
> memory as is (no offsets and remappings). But if there is dma-ranges
> with some specific system settings it may affect the PCIe MRd/MWr TLPs
> address translation including the addresses targeted to the MMIO
> space. In that case the mapping performed on step 2) will return a
> wrong DMA-address since the corresponding dma_direct_map_resource()
> just returns the passed physical address missing the
> 'pci_dev->dma_range_map'-based mapping performed in
> translate_phys_to_dma().
> 
> Note the mapping on step 3) works correctly because it calls the
> translate_phys_to_dma() of the direct DMA interface thus taking the
> PCie dma-ranges into account.
> 
> To sum up as I see it either restricting dma_map_resource() to map
> just the intra-bus addresses was wrong or there must be some
> additional mapping infrastructure for the denoted systems. Though I
> don't see a way the dma_map_resource() could be fixed to be suitable
> for each considered cases.

FWIW the current semantics of dma_map_resource() are basically just to 
insert IOMMU awareness where dmaengine drivers were previously just 
casting phys_addr_t to dma_addr_t (or u32, or whatever else they put 
into their descriptor/register/etc.) IIRC there was a bit of a question 
whether it really belonged in the DMA API at all, since it's not really 
a "DMA" operation in the conventional sense, and convenience was the 
only real deciding argument. The relevant drivers at the time were not 
taking dma_pfn_offset into account when consuming physical addresses 
directly, so the new API didn't either.

That's just how things got to where they are today. Once again, I'm not 
saying that what we have now is necessarily right, or that your change 
is necessarily wrong, I just really want to understand specifically 
*why* you need to make it, so we can evaluate the risk of possible 
breakage either way. Theoretical "if"s aren't really enough.

Robin.
