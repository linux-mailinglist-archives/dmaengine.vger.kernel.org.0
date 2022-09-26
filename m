Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6675EAA82
	for <lists+dmaengine@lfdr.de>; Mon, 26 Sep 2022 17:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbiIZPWN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 11:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbiIZPVD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 11:21:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 744E45D12C;
        Mon, 26 Sep 2022 07:08:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB1BE1042;
        Mon, 26 Sep 2022 07:08:15 -0700 (PDT)
Received: from [10.57.65.170] (unknown [10.57.65.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5E4B3F73B;
        Mon, 26 Sep 2022 07:08:06 -0700 (PDT)
Message-ID: <5569ad73-9699-e326-c1fb-e0753bbdde78@arm.com>
Date:   Mon, 26 Sep 2022 15:08:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH RESEND v5 22/24] dmaengine: dw-edma: Bypass dma-ranges
 mapping for the local setup
Content-Language: en-GB
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru>
 <20220822185332.26149-23-Sergey.Semin@baikalelectronics.ru>
 <7a035b29-fca6-2650-c3c1-eedb3904c32d@arm.com>
 <20220912012426.xcg4tu6wzogbirp6@mobilestation>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220912012426.xcg4tu6wzogbirp6@mobilestation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2022-09-12 02:24, Serge Semin wrote:
> On Wed, Aug 31, 2022 at 10:17:30AM +0100, Robin Murphy wrote:
>> On 2022-08-22 19:53, Serge Semin wrote:
>>> DW eDMA doesn't perform any translation of the traffic generated on the
>>> CPU/Application side. It just generates read/write AXI-bus requests with
>>> the specified addresses. But in case if the dma-ranges DT-property is
>>> specified for a platform device node, Linux will use it to map the CPU
>>> memory regions into the DMAable bus ranges. This isn't what we want for
>>> the eDMA embedded into the locally accessed DW PCIe Root Port and
>>> End-point. In order to work that around let's set the chan_dma_dev flag
>>> for each DW eDMA channel thus forcing the client drivers to getting a
>>> custom dma-ranges-less parental device for the mappings.
>>>
>>> Note it will only work for the client drivers using the
>>> dmaengine_get_dma_device() method to get the parental DMA device.
>>
> 
>> No, this is nonsense. If the DMA engine is on the host side of the bridge
>> then it should not have anything to do with the PCI device at all, it should
>> be associated with the platform device,
> 
> Well. The DMA-engine is embedded into the PCIe Root Port bus, is associated
> with the platform device it's embedded to, and it doesn't have
> anything to do with any particular PCI device.
> 
>> and thus any range mapping on the bridge itself would be irrelevant anyway.
> 
> Really? I find it otherwise. Please see the way the "dma-ranges"
> property is parsed and works during the device-specific memory ranges
> mapping when it's applicable for the PCIe Root Ports.

Sigh, that's a bug. Now I see where the confusion is coming from.

Annoyingly it's basically the exact thing I called out in 951d48855d86 
when making dma-ranges work for non-OF PCI devices in the first place, 
but apparently neither I nor anyone else thought of this particular edge 
case at the time. Sorry about that. I'll have a look at how best to fix it.

Everything else still stands, though. If you can't use the original 
platform device for DMA API calls, at least configure the child device 
properly by calling of_dma_configure() with the parent's DT node in the 
expected manner (and manually remove its dma_range_map if you need an 
immediate workaround).

Thanks,
Robin.
