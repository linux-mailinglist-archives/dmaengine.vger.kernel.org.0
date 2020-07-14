Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7A721F7A5
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 18:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgGNQtO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 12:49:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:24475 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgGNQtO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Jul 2020 12:49:14 -0400
IronPort-SDR: sG6FR9LDdBAh9OFAZbydWojuVPv7uSudemPznpiYhU/zXx/PO4KyYptqLgrE2rHEnP2mgLwH33
 uDmIjofcdWuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="213748140"
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="213748140"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 09:49:13 -0700
IronPort-SDR: 43WJZfLT0kjZUqlt8ocOMEylSo7SumVMqMI+Ur3jhEQ0x0Y3UBB1QpGj1WRuq+4bxI2fLMDprb
 Ztv5v9RASv+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="307939488"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.140.223]) ([10.209.140.223])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jul 2020 09:49:12 -0700
Subject: Re: [PATCH v7 05/11] dmaengine: Introduce DMA-device device_caps
 callback
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200709224550.15539-1-Sergey.Semin@baikalelectronics.ru>
 <20200709224550.15539-6-Sergey.Semin@baikalelectronics.ru>
 <20200710084503.GE3703480@smile.fi.intel.com>
 <20200710093834.su3nsjesnhntpd6d@mobilestation>
 <07d4a977-1de6-b611-3d4f-7c7d6cd7fe5f@intel.com>
 <20200714160830.GL34333@vkoul-mobl>
 <f746fafd-851e-f402-3755-03ef94a65988@intel.com>
 <20200714162953.2333hke6pfvovjuk@mobilestation>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <7d1a9ae9-0a95-cba5-be62-4493501039e7@intel.com>
Date:   Tue, 14 Jul 2020 09:49:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714162953.2333hke6pfvovjuk@mobilestation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/14/2020 9:29 AM, Serge Semin wrote:
> On Tue, Jul 14, 2020 at 09:18:16AM -0700, Dave Jiang wrote:
>>
>>
>> On 7/14/2020 9:08 AM, Vinod Koul wrote:
>>> On 13-07-20, 13:55, Dave Jiang wrote:
>>>>
>>>>
>>>> On 7/10/2020 2:38 AM, Serge Semin wrote:
>>>>> On Fri, Jul 10, 2020 at 11:45:03AM +0300, Andy Shevchenko wrote:
>>>>>> On Fri, Jul 10, 2020 at 01:45:44AM +0300, Serge Semin wrote:
>>>>>>> There are DMA devices (like ours version of Synopsys DW DMAC) which have
>>>>>>> DMA capabilities non-uniformly redistributed between the device channels.
>>>>>>> In order to provide a way of exposing the channel-specific parameters to
>>>>>>> the DMA engine consumers, we introduce a new DMA-device callback. In case
>>>>>>> if provided it gets called from the dma_get_slave_caps() method and is
>>>>>>> able to override the generic DMA-device capabilities.
>>>>>>
>>>>>
>>>>>> In light of recent developments consider not to add 'slave' and a such words to the kernel.
>>>>>
>>>>> As long as the 'slave' word is used in the name of the dma_slave_caps
>>>>> structure and in the rest of the DMA-engine subsystem, it will be ambiguous
>>>>> to use some else terminology. If renaming needs to be done, then it should be
>>>>> done synchronously for the whole subsystem.
>>>>
>>>> What about just calling it dma_device_caps? Consider this is a useful
>>>> function not only slave DMA will utilize this. I can see this being useful
>>>> for some of my future code with idxd driver.
>>>
>>> Some of the caps may make sense to generic dmaengine but few of them do
>>> not :) While at it, am planning to make it dmaengine_periph_caps to
>>> denote that these are dmaengine peripheral capabilities.
>>>
>>
> 
>> If the function only passes in periph_caps, how do we allow the non periph
>> DMA utilize this function?
> 
> Hello Dave. That seems reasonable. "dma_device_caps" or even "dma_chan_caps"
> might be more suitable seeing after this patchset merged in the "dma_slave_caps"
> may really provide the DMA channel-specific configs. Moreover that structure is
> accessible only by means of the dma_chan descriptor:
> 
> int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
> 
> which makes those caps being the channel-specific even without this patchset.
> 
> So as I see it "dma_chan_caps" might be the better choice.

Hi Sergey. Yes I think that sounds pretty good. Especially seeing there are DMA 
engines that have channels with different/asymmetric capabilities now.

> 
> -Sergey
> 
