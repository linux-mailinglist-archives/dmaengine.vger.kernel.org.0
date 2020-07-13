Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9035621E1B2
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2020 22:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgGMUzR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Jul 2020 16:55:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:49219 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgGMUzR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 13 Jul 2020 16:55:17 -0400
IronPort-SDR: EbeLArq4HkKuXrlRxYpB/WS2qvAXL+eK3WEI4G9/favHK5tDRXMs139ILa9JUq6sYcrvGIBs++
 dPhiTZl6KmIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="213545772"
X-IronPort-AV: E=Sophos;i="5.75,348,1589266800"; 
   d="scan'208";a="213545772"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 13:55:16 -0700
IronPort-SDR: 7szJfcXPONfImWsDE0U1Og3oR6gRPzY9NXu27bBlEUhLsXyTzhLMHYMpnGwjaJkpOUSxedhjvm
 WmmYlkewsJUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,348,1589266800"; 
   d="scan'208";a="390288665"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.172.11]) ([10.212.172.11])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jul 2020 13:55:15 -0700
Subject: Re: [PATCH v7 05/11] dmaengine: Introduce DMA-device device_caps
 callback
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
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
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <07d4a977-1de6-b611-3d4f-7c7d6cd7fe5f@intel.com>
Date:   Mon, 13 Jul 2020 13:55:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710093834.su3nsjesnhntpd6d@mobilestation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/10/2020 2:38 AM, Serge Semin wrote:
> On Fri, Jul 10, 2020 at 11:45:03AM +0300, Andy Shevchenko wrote:
>> On Fri, Jul 10, 2020 at 01:45:44AM +0300, Serge Semin wrote:
>>> There are DMA devices (like ours version of Synopsys DW DMAC) which have
>>> DMA capabilities non-uniformly redistributed between the device channels.
>>> In order to provide a way of exposing the channel-specific parameters to
>>> the DMA engine consumers, we introduce a new DMA-device callback. In case
>>> if provided it gets called from the dma_get_slave_caps() method and is
>>> able to override the generic DMA-device capabilities.
>>
> 
>> In light of recent developments consider not to add 'slave' and a such words to the kernel.
> 
> As long as the 'slave' word is used in the name of the dma_slave_caps
> structure and in the rest of the DMA-engine subsystem, it will be ambiguous
> to use some else terminology. If renaming needs to be done, then it should be
> done synchronously for the whole subsystem.

What about just calling it dma_device_caps? Consider this is a useful function 
not only slave DMA will utilize this. I can see this being useful for some of my 
future code with idxd driver.

> 
> -Sergey
> 
>>
>>
>> -- 
>> With Best Regards,
>> Andy Shevchenko
>>
>>
