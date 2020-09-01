Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BC9259220
	for <lists+dmaengine@lfdr.de>; Tue,  1 Sep 2020 17:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgIAPDb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Sep 2020 11:03:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:8666 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgIAPD2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 1 Sep 2020 11:03:28 -0400
IronPort-SDR: 32ERPcARan7kfUuzk7XhINayhrcZe/iDU0pUXTYNgqbH0L9EYqmtD9b3L/RaGb7rPkna8M+NJb
 WmZRIIXASWoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="175228547"
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="175228547"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 08:03:26 -0700
IronPort-SDR: tq2ofberLy/TtBiy1TXtfKoNDJCWHtd/CgWV3yrDjhKJhi/RhfjSgsQmUe1g3/r0AjKslti7ZU
 KAaRi4wbJgzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="314756852"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 01 Sep 2020 08:03:25 -0700
Received: from [10.214.152.83] (mreddy3x-MOBL.gar.corp.intel.com [10.214.152.83])
        by linux.intel.com (Postfix) with ESMTP id 4A7D5580679;
        Tue,  1 Sep 2020 08:03:23 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, chuanhua.lei@linux.intel.com,
        malliamireddy009@gmail.com
References: <cover.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <68c77fd2ffb477aa4a52a58f8a26bfb191d3c5d1.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <20200814203222.GA2674896@bogus>
 <7cdc0587-8b4f-4360-a303-1541c9ad57b2@linux.intel.com>
 <20200825112107.GN2639@vkoul-mobl>
 <ffa5ba4d-f1b2-6a30-f2f1-f4578a77bce2@linux.intel.com>
 <20200828104530.GT2639@vkoul-mobl>
 <09547b0e-1c2e-d916-d4c0-f66b0110e173@linux.intel.com>
 <20200831110032.GN2639@vkoul-mobl>
From:   "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Message-ID: <b2f3df54-40b2-b90b-8696-48de2abadd34@linux.intel.com>
Date:   Tue, 1 Sep 2020 23:03:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200831110032.GN2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,
Thanks for the review, please see my comments inline.

On 8/31/2020 7:00 PM, Vinod Koul wrote:
> On 31-08-20, 16:06, Reddy, MallikarjunaX wrote:
>> Hi Vinod,
>>
>> Thanks for the review. Please see my comment inline.
>>
>> On 8/28/2020 6:45 PM, Vinod Koul wrote:
>>> On 27-08-20, 17:54, Reddy, MallikarjunaX wrote:
>>>> Hi Vinod,
>>>> Thanks for the review comments.
>>>>
>>>> On 8/25/2020 7:21 PM, Vinod Koul wrote:
>>>>> On 18-08-20, 15:00, Reddy, MallikarjunaX wrote:
>>>>>
>>>>>>>> +
>>>>>>>> +            intel,chans:
>>>>>>>> +              $ref: /schemas/types.yaml#/definitions/uint32-array
>>>>>>>> +              description:
>>>>>>>> +                 The channels included on this port. Format is channel start
>>>>>>>> +                 number and how many channels on this port.
>>>>>>> Why does this need to be in DT? This all seems like it can be in the dma
>>>>>>> cells for each client.
>>>>>> (*ABC)
>>>>>> Yes. We need this.
>>>>>> for dma0(lgm-cdma) old SOC supports 16 channels and the new SOC supports 22
>>>>>> channels. and the logical channel mapping for the peripherals also differ
>>>>>> b/w old and new SOCs.
>>>>>>
>>>>>> Because of this hardware limitation we are trying to configure the total
>>>>>> channels and port-channel mapping dynamically from device tree.
>>>>>>
>>>>>> based on port name we are trying to configure the default values for
>>>>>> different peripherals(ports).
>>>>>> Example: burst length is not same for all ports, so using port name to do
>>>>>> default configurations.
>>>>> Sorry that does not make sense to me, why not specify the values to be
>>>>> used here instead of defining your own name scheme!
>>>> OK. Agreed. I will remove port name from DT and only use intel,chans
>>> what is intel,chans, why not use dma-channels?
>>   The intel,chans says about the channels included on the correspondng port.
> What do you mean by a port here?
Here Port is nothing but Peripheral(SPI, HSNAND...)
>
>> Format is channel start number and how many channels on this port.
> It is perfectly reasonable to have 16 channels but linux not use use all, lets
> say from 5th channel channel onwards
>
> So you need to use standard dma-channels also with dma-channel-mask to
> specify which channels linux can use
Ok, let me verify and use the standard dma-channels also dma-channel-mask.
>
>>   The reasong behind using this attribute instead of standrad dma-channels
>> is...
>>
>>
>> DMA_VER22 HW supports 22 channels. But there is a hole in HW, total it can
>> use only 16.
>>
>> Old soc supports 4ports and 16 channels.
>> New soc supports 6ports and 22 channels.
>> (old and new soc carry the same version VER22)
>>
>> port channel mapping for the old and new soc also not the same.
>> old soc: logical channels:(Rx, Tx)
>> 0, 1 - SPI0
>> 2, 3 - SPI1
>> 4, 5 - HSNAND
>> 12, 14, 13, 15 - Memcopy
>>
>> New soc: Logical channels(Rx, Tx)
>> 0, 1 - SPI0
>> 2, 3 - SPI1
>> 4, 5 - SPI2
>> 6, 7 - SPI3
>> 8, 9 - HSNAND
>> 10 to 21 - Mcopy
> Mapping is different, client can set that channel required in dmas
> property and use a specific required channel.
OK.
>
>> Because of these reasons we are trying to use "intel,chans" attribute, and
>> reading then number of channels from the dt.
>> Advantaage:
>> 1. we can map the channels correspondign to port
>> 2. Dynamically configure the channels (due to hw limitation)
>>
>> If this is not ok, please suggest us the better way to handle this.
