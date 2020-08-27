Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394692542C7
	for <lists+dmaengine@lfdr.de>; Thu, 27 Aug 2020 11:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgH0Jye (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Aug 2020 05:54:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:16855 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgH0Jyd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 27 Aug 2020 05:54:33 -0400
IronPort-SDR: 6EwFLcfDa5CTaAAAoeSmLGZM+7jAd3C26xcXhdrNTckPT3UkVvFRCjpqc5SdFA3a00UkencRMv
 O8aQQsooodjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="144131056"
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="144131056"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 02:54:32 -0700
IronPort-SDR: zzFZZKfiIYitmUmayPFZKycyu6m5slei8hD8mOAqFMwUJjwnmBW+VS3KvVoctozMoVYE2ERCii
 5ywYwjjnQX8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="295672250"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 27 Aug 2020 02:54:32 -0700
Received: from [10.255.146.64] (mreddy3x-MOBL.gar.corp.intel.com [10.255.146.64])
        by linux.intel.com (Postfix) with ESMTP id ABFFA5806C6;
        Thu, 27 Aug 2020 02:54:29 -0700 (PDT)
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
From:   "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Message-ID: <ffa5ba4d-f1b2-6a30-f2f1-f4578a77bce2@linux.intel.com>
Date:   Thu, 27 Aug 2020 17:54:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825112107.GN2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,
Thanks for the review comments.

On 8/25/2020 7:21 PM, Vinod Koul wrote:
> On 18-08-20, 15:00, Reddy, MallikarjunaX wrote:
>
>>>> +
>>>> +            intel,chans:
>>>> +              $ref: /schemas/types.yaml#/definitions/uint32-array
>>>> +              description:
>>>> +                 The channels included on this port. Format is channel start
>>>> +                 number and how many channels on this port.
>>> Why does this need to be in DT? This all seems like it can be in the dma
>>> cells for each client.
>> (*ABC)
>> Yes. We need this.
>> for dma0(lgm-cdma) old SOC supports 16 channels and the new SOC supports 22
>> channels. and the logical channel mapping for the peripherals also differ
>> b/w old and new SOCs.
>>
>> Because of this hardware limitation we are trying to configure the total
>> channels and port-channel mapping dynamically from device tree.
>>
>> based on port name we are trying to configure the default values for
>> different peripherals(ports).
>> Example: burst length is not same for all ports, so using port name to do
>> default configurations.
> Sorry that does not make sense to me, why not specify the values to be
> used here instead of defining your own name scheme!
OK. Agreed. I will remove port name from DT and only use intel,chans
>
> Only older soc it should create 16 channels and new 22 (hint this is hw
> description so perfectly okay to specify in DT or in using driver_data
> and compatible for each version
>
>>>> +
>>>> +          required:
>>>> +            - reg
>>>> +            - intel,name
>>>> +            - intel,chans
>>>> +
>>>> +
>>>> + ldma-channels:
>>>> +    type: object
>>>> +    description:
>>>> +       This sub-node must contain a sub-node for each DMA channel.
>>>> +    properties:
>>>> +      '#address-cells':
>>>> +        const: 1
>>>> +      '#size-cells':
>>>> +        const: 0
>>>> +
>>>> +    patternProperties:
>>>> +      "^ldma-channels@[0-15]+$":
>>>> +          type: object
>>>> +
>>>> +          properties:
>>>> +            reg:
>>>> +              items:
>>>> +                - enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
>>>> +              description:
>>>> +                 Which channel this node refers to.
>>>> +
>>>> +            intel,desc_num:
>>>> +              $ref: /schemas/types.yaml#/definitions/uint32
>>>> +              description:
>>>> +                 Per channel maximum descriptor number. The max value is 255.
>>>> +
>>>> +            intel,hdr-mode:
>>>> +              $ref: /schemas/types.yaml#/definitions/uint32-array
>>>> +              description:
>>>> +                 The first parameter is header mode size, the second
>>>> +                 parameter is checksum enable or disable. If enabled,
>>>> +                 header mode size is ignored. If disabled, header mode
>>>> +                 size must be provided.
>>>> +
>>>> +            intel,hw-desc:
>>>> +              $ref: /schemas/types.yaml#/definitions/uint32-array
>>>> +              description:
>>>> +                 Per channel dma hardware descriptor configuration.
>>>> +                 The first parameter is descriptor physical address and the
>>>> +                 second parameter hardware descriptor number.
>>> Again, this all seems like per client information for dma cells.
>>   Ok, if we move all these attributes to 'dmas' then 'dma-channels' child
>> node is not needed in dtsi.
>> #dma-cells number i am already using 7. If we move all these attributes to
>> 'dmas' then integer cells will increase.
>>
>> Is there any limitation in using a number of integer cells & as determined
>> by the #dma-cells property?
> No I dont think there is but it needs to make sense :-)
OK.
>
