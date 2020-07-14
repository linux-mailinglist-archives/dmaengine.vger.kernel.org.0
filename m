Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A5721F713
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 18:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgGNQSS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 12:18:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:55862 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgGNQSS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Jul 2020 12:18:18 -0400
IronPort-SDR: qUaFIV6Ek4VO4F7jEEhBqUESBD1o+iItkVztJPDxdKUcyu5RrtBvgiISvltaqHUefzZQY5wys9
 zLs2xqSzJbsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="233813989"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="233813989"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 09:18:18 -0700
IronPort-SDR: HN+vpBCYu9KmC3INIgKGNBMsFh/JR6Q0OcGv5RbozxfE74tRKkf9WfaIPnZmBleoc/bK7AUnqY
 E86DQqdVbCDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="307928997"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.140.223]) ([10.209.140.223])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jul 2020 09:18:17 -0700
Subject: Re: [PATCH v7 05/11] dmaengine: Introduce DMA-device device_caps
 callback
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
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
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <f746fafd-851e-f402-3755-03ef94a65988@intel.com>
Date:   Tue, 14 Jul 2020 09:18:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714160830.GL34333@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/14/2020 9:08 AM, Vinod Koul wrote:
> On 13-07-20, 13:55, Dave Jiang wrote:
>>
>>
>> On 7/10/2020 2:38 AM, Serge Semin wrote:
>>> On Fri, Jul 10, 2020 at 11:45:03AM +0300, Andy Shevchenko wrote:
>>>> On Fri, Jul 10, 2020 at 01:45:44AM +0300, Serge Semin wrote:
>>>>> There are DMA devices (like ours version of Synopsys DW DMAC) which have
>>>>> DMA capabilities non-uniformly redistributed between the device channels.
>>>>> In order to provide a way of exposing the channel-specific parameters to
>>>>> the DMA engine consumers, we introduce a new DMA-device callback. In case
>>>>> if provided it gets called from the dma_get_slave_caps() method and is
>>>>> able to override the generic DMA-device capabilities.
>>>>
>>>
>>>> In light of recent developments consider not to add 'slave' and a such words to the kernel.
>>>
>>> As long as the 'slave' word is used in the name of the dma_slave_caps
>>> structure and in the rest of the DMA-engine subsystem, it will be ambiguous
>>> to use some else terminology. If renaming needs to be done, then it should be
>>> done synchronously for the whole subsystem.
>>
>> What about just calling it dma_device_caps? Consider this is a useful
>> function not only slave DMA will utilize this. I can see this being useful
>> for some of my future code with idxd driver.
> 
> Some of the caps may make sense to generic dmaengine but few of them do
> not :) While at it, am planning to make it dmaengine_periph_caps to
> denote that these are dmaengine peripheral capabilities.
> 

If the function only passes in periph_caps, how do we allow the non periph DMA 
utilize this function?
