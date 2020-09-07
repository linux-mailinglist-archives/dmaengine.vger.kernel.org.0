Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30DB25F3E9
	for <lists+dmaengine@lfdr.de>; Mon,  7 Sep 2020 09:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgIGHZ4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Sep 2020 03:25:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:30922 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgIGHZ4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 7 Sep 2020 03:25:56 -0400
IronPort-SDR: lgOO3hWUxi/1H93nBNgTxabjuscYQ0QwLnwio3b6fEtqELkiPoFBmwcV5NKT0MjTfAVugkhffR
 g24/5H6qVwgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="157230084"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="157230084"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 00:25:55 -0700
IronPort-SDR: gMnuKmvulw1ma0Oz55zxirLkE65wgpB6LgqRu06Lc08ddIDw9pROLgYUgyrLtzgtuJlETwozlP
 Vd9T307B6qoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="340736982"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Sep 2020 00:25:55 -0700
Received: from [10.214.170.27] (mreddy3x-MOBL.gar.corp.intel.com [10.214.170.27])
        by linux.intel.com (Postfix) with ESMTP id 1D30E58077A;
        Mon,  7 Sep 2020 00:25:51 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh@kernel.org>
Cc:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, chuanhua.lei@linux.intel.com,
        malliamireddy009@gmail.com
References: <cover.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <68c77fd2ffb477aa4a52a58f8a26bfb191d3c5d1.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <20200814203222.GA2674896@bogus>
 <7cdc0587-8b4f-4360-a303-1541c9ad57b2@linux.intel.com>
 <354cc7a4-de2f-1ed4-882d-3a285f565a26@ti.com>
From:   "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Message-ID: <327e291d-7a49-ae1e-d5a3-55953e312ce5@linux.intel.com>
Date:   Mon, 7 Sep 2020 15:25:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <354cc7a4-de2f-1ed4-882d-3a285f565a26@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 9/4/2020 2:31 PM, Peter Ujfalusi wrote:
>
> On 18/08/2020 10.00, Reddy, MallikarjunaX wrote:
>> Hi Rob,
>> Thanks for your valuable comments. Please see my comments inline..
>>
>> On 8/15/2020 4:32 AM, Rob Herring wrote:
>>> On Fri, Aug 14, 2020 at 01:26:09PM +0800, Amireddy Mallikarjuna reddy
>>> wrote:
>>>> Add DT bindings YAML schema for DMA controller driver
>>>> of Lightning Mountain(LGM) SoC.
>>>>
>>>> Signed-off-by: Amireddy Mallikarjuna reddy
>>>> <mallikarjunax.reddy@linux.intel.com>
>>>> ---
>>>> v1:
>>>> - Initial version.
>>>>
>>>> v2:
>>>> - Fix bot errors.
>>>>
>>>> v3:
>>>> - No change.
>>>>
>>>> v4:
>>>> - Address Thomas langer comments
>>>>     - use node name pattern as dma-controller as in common binding.
>>>>     - Remove "_" (underscore) in instance name.
>>>>     - Remove "port-" and "chan-" in attribute name for both
>>>> 'dma-ports' & 'dma-channels' child nodes.
>>>>
>>>> v5:
>>>> - Moved some of the attributes in 'dma-ports' & 'dma-channels' child
>>>> nodes to dma client/consumer side as cells in 'dmas' properties.
>>>> ---
>>>>    .../devicetree/bindings/dma/intel,ldma.yaml        | 319
>>>> +++++++++++++++++++++
>>>>    1 file changed, 319 insertions(+)
>>>>    create mode 100644
>>>> Documentation/devicetree/bindings/dma/intel,ldma.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml
>>>> b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
>>>> new file mode 100644
>>>> index 000000000000..9beaf191a6de
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
>>>> @@ -0,0 +1,319 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/dma/intel,ldma.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Lightning Mountain centralized low speed DMA and high speed
>>>> DMA controllers.
>>>> +
>>>> +maintainers:
>>>> +  - chuanhua.lei@intel.com
>>>> +  - mallikarjunax.reddy@intel.com
>>>> +
>>>> +allOf:
>>>> +  - $ref: "dma-controller.yaml#"
>>>> +
>>>> +properties:
>>>> + $nodename:
>>>> +   pattern: "^dma-controller(@.*)?$"
>>>> +
>>>> + "#dma-cells":
>>>> +   const: 1
>>> Example says 3.
>> OK, i will fix it.
> It would help if you would add description of what is the meaning of the
> individual cell.
I am already prepared the patch by addressing previous comments and just 
before sending i received your review comment. :-)

Let me Edit , include the description and prepare the patch again.
>
> - Péter
>
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>
