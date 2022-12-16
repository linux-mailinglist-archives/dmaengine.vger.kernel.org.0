Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EAB64EC83
	for <lists+dmaengine@lfdr.de>; Fri, 16 Dec 2022 15:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiLPOBd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Dec 2022 09:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiLPOBb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Dec 2022 09:01:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0280A14012;
        Fri, 16 Dec 2022 06:01:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D59411042;
        Fri, 16 Dec 2022 06:02:08 -0800 (PST)
Received: from [10.57.88.234] (unknown [10.57.88.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2ABC83F5A1;
        Fri, 16 Dec 2022 06:01:25 -0800 (PST)
Message-ID: <22bae859-58ee-80cd-f31b-2313c2e47531@arm.com>
Date:   Fri, 16 Dec 2022 14:01:20 +0000
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
 <07ec7610-f1be-9b5c-416d-17781a22427d@arm.com>
 <20221215235218.wsuwy5uckqfxjnb6@mobilestation>
 <Y5wgvdnMWQDxkUd+@infradead.org>
 <20221216093423.4bettdxisserdzsh@mobilestation>
 <Y5w/MkA4N857+AWQ@infradead.org>
 <20221216101827.owq7qpakjduf3rit@mobilestation>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221216101827.owq7qpakjduf3rit@mobilestation>
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

On 2022-12-16 10:18, Serge Semin wrote:
> On Fri, Dec 16, 2022 at 01:49:38AM -0800, Christoph Hellwig wrote:
>> On Fri, Dec 16, 2022 at 12:34:23PM +0300, Serge Semin wrote:
>>> What about instead of save/restore pattern I'll just change the
>>> dma_set_mask_and_coherent() method with the dma_set_coherent_mask()
>>> function call? It seems cleaner. Like this:
>>
>>> Thus the platform-specific streaming DMA mask would be preserved.
>>> Since it's PCIe then having the streaming DMA-mask less than 32-bits
>>> wide is very much improbable. Moreover DW PCIe AXI-interface can be
>>> synthesize only with one out of two address bus widths: 32 and 64.
>>
> 
>> Where platform-specific means the dwc subdriver?
> 
> Right. I meant the streaming DMA-mask set by the low-level DWC PCIe drivers
> (like pcie-qcom(-ep)?.c, pcie-bt1.c, etc). It's very much important to
> have the real DMA-mask (at least the streaming one) set for the eDMA-capable
> controllers so the DMA-engine clients would work with the best performance.
> 
>> Yes, that seems to work.
> 
> Ok. I'll just use the direct dma_set_coherent_mask() method here then.
> 
>> Alternatively have a flag that says which streaming mask
>> to set.
> 
> I'd prefer to have more flexibility here relying on the low-level
> drivers to set the mask(s) instead of adding the new flag, just in case
> if there is vendor-specific IP-core/platform changes in the address
> bus width.

Presumably the low-level glue drivers could pass a bus size or mask 
value in struct dw_pcie_rp/dw_pcie, so the actual dma_set_mask() call 
itself could be centralised? I guess there's also an argument that only 
glue drivers which care about eDMA need to care about setting a mask at 
all, so I don't have a string preference either way. If you'd rather 
stick with that approach then it might be worth a brief comment at each 
site to clarify why the other mask is being set from an entirely 
different place, just in case anyone comes along and tries to "fix" it.

Cheers,
Robin.
