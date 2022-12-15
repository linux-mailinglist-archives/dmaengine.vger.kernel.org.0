Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B249264D97E
	for <lists+dmaengine@lfdr.de>; Thu, 15 Dec 2022 11:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiLOK0Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Dec 2022 05:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLOK0X (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Dec 2022 05:26:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 358B8F17;
        Thu, 15 Dec 2022 02:26:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2207F1063;
        Thu, 15 Dec 2022 02:27:01 -0800 (PST)
Received: from [10.57.88.90] (unknown [10.57.88.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6ED333F5A1;
        Thu, 15 Dec 2022 02:26:17 -0800 (PST)
Message-ID: <07ec7610-f1be-9b5c-416d-17781a22427d@arm.com>
Date:   Thu, 15 Dec 2022 10:26:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v7 23/25] PCI: dwc: Restore DMA-mask after MSI-data
 allocation
Content-Language: en-GB
To:     Serge Semin <fancer.lancer@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
 <20221214235305.31744-24-Sergey.Semin@baikalelectronics.ru>
 <Y5rJJfZeVqliA5Rg@infradead.org>
 <20221215092721.tvz3hpaql3kotgnu@mobilestation>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221215092721.tvz3hpaql3kotgnu@mobilestation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2022-12-15 09:27, Serge Semin wrote:
> Hi Christoph
> 
> On Wed, Dec 14, 2022 at 11:13:41PM -0800, Christoph Hellwig wrote:
>> On Thu, Dec 15, 2022 at 02:53:03AM +0300, Serge Semin wrote:
>>> DW PCIe Root Ports and End-points can be equipped with the DW eDMA engine.
>>> In that case it is critical to have the platform device pre-initialized
>>> with a valid DMA-mask so the drivers using the eDMA-engine would be able
>>> to allocate the DMA-able buffers. The MSI-capable data requires to be
>>> allocated from the lowest 4GB region. Since that procedure implies the
>>> DMA-mask change we need to restore the mask set by the low-level drivers
>>> after the MSI-data allocation is done.
>>
>> You can't change the DMA mask when there are existing allocations.
> 
> Em, what do you guys suggest for the DW PCIe devices with the embedded
> DMA-engine then? To live forever with the SWIOTLBs? I can't drop the
> DMA-mask update due to this commit 423511ec23e2 ("PCI: dwc: Drop
> dependency on ZONE_DMA32") and I can't change the mask after it's
> updated. Note it's updated for the memory allocation to which actually
> no DMA will be performed, see
> https://lore.kernel.org/linux-pci/20220825185026.3816331-2-willmcvicker@google.com/.
> My patches imply adding the real DMA operations support.
> 
> We've discussed this a lot with Robin in various threads and I thought
> a workable solution was found. I was going to update the mask in
> another place, but basically it would still mean to have first setting
> the 32-bit mask here, and then change it to 64-bit one in the
> framework of the DW eDMA driver.
> 
> So to speak I don't see a proper way out from the situation. Nothing I
> suggested was accepted and now we'll have to live with the SWIOTLBs
> used for the memory above 4GB. So please suggest a workable solution
> then. We need the next things:
> 1. Somehow preserve a single DWORD of the PCIe bus memory for the
> iMSI-RX engine. (That's what is currently done the
> dw_pcie_msi_host_init() method by allocating the coherent memory.)
> 2. Set the actual DMA-mask to the DW PCIe platform device so the
> DMA-engine clients would be able to allocate actually DMA-able memory.
> 
> @Robin, please join the discussion.

Basically just don't touch the coherent mask. The eDMA drivers can still 
set the streaming mask to something larger, and that's the one that's 
going to matter for most dmaengine clients anyway. Even if someone does 
call dma_alloc_coherent() for their eDMA channel, it's not going to make 
much practical difference if that has to come from a DMA zone, unless 
the system is under severe memory pressure anyway.

Thanks,
Robin.
