Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D622BA93C
	for <lists+dmaengine@lfdr.de>; Fri, 20 Nov 2020 12:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgKTLau (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Nov 2020 06:30:50 -0500
Received: from mga03.intel.com ([134.134.136.65]:26990 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgKTLau (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 20 Nov 2020 06:30:50 -0500
IronPort-SDR: 6TLanbbYOxng2xSm1TH18AB/lnlsS/99nG6frdNDHA3tI/gxoUmTvRQIDWuE6yT4Mh8nFYE2AO
 54HJwVUJdpAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="171555409"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="171555409"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 03:30:48 -0800
IronPort-SDR: TeKYm0yw7vmRnD5pABbfMtIiaSNSFYey/5glR73060/rWhhQ3KRBNiNDcvM0Hj0BNTnJC1V1BU
 A16s8ny2unng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="477198269"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 20 Nov 2020 03:30:48 -0800
Received: from [10.255.161.204] (mreddy3x-MOBL.gar.corp.intel.com [10.255.161.204])
        by linux.intel.com (Postfix) with ESMTP id 87F7E58082E;
        Fri, 20 Nov 2020 03:30:45 -0800 (PST)
Subject: Re: [PATCH v9 1/2] dt-bindings: dma: Add bindings for Intel LGM SoC
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, chuanhua.lei@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        malliamireddy009@gmail.com, peter.ujfalusi@ti.com
References: <cover.1605158930.git.mallikarjunax.reddy@linux.intel.com>
 <bfe586ac62080d14759bda22ebf1de1a1fa9c09d.1605158930.git.mallikarjunax.reddy@linux.intel.com>
 <20201118155552.GV50232@vkoul-mobl>
From:   "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Message-ID: <44fba7c3-37a9-7168-3c19-eeb5068b7063@linux.intel.com>
Date:   Fri, 20 Nov 2020 19:30:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201118155552.GV50232@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,
Thanks for the review. My comments inline.

On 11/18/2020 11:55 PM, Vinod Koul wrote:
> On 12-11-20, 13:38, Amireddy Mallikarjuna reddy wrote:
>> Add DT bindings YAML schema for DMA controller driver
>> of Lightning Mountain (LGM) SoC.
>>
>> Signed-off-by: Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
>> ---
>> v1:
>> - Initial version.
>>
>> v2:
>> - Fix bot errors.
>>
>> v3:
>> - No change.
>>
>> v4:
>> - Address Thomas langer comments
>>    - use node name pattern as dma-controller as in common binding.
>>    - Remove "_" (underscore) in instance name.
>>    - Remove "port-" and "chan-" in attribute name for both 'dma-ports' & 'dma-channels' child nodes.
>>
>> v5:
>> - Moved some of the attributes in 'dma-ports' & 'dma-channels' child nodes to dma client/consumer side as cells in 'dmas' properties.
>>
>> v6:
>> - Add additionalProperties: false
>> - completely removed 'dma-ports' and 'dma-channels' child nodes.
>> - Moved channel dt properties to client side dmas.
>> - Use standard dma-channels and dma-channel-mask properties.
>> - Documented reset-names
>> - Add description for dma-cells
>>
>> v7:
>> - modified compatible to oneof
>> - Reduced number of dma-cells to 3
>> - Fine tune the description of some properties.
>>
>> v7-resend:
>> - rebase to 5.10-rc1
>>
>> v8:
>> - rebased to 5.10-rc3
>> - Fixing the bot issues (wrong indentation)
>>
>> v9:
>> - rebased to 5.10-rc3
>> - Use 'enum' instead of oneOf+const
>> - Drop '#dma-cells' in required:, already covered in dma-common.yaml
>> - Drop nodename Already covered by dma-controller.yaml
>> ---
>>   .../devicetree/bindings/dma/intel,ldma.yaml        | 130 +++++++++++++++++++++
>>   1 file changed, 130 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/dma/intel,ldma.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
>> new file mode 100644
>> index 000000000000..c06281a10178
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
>> @@ -0,0 +1,130 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dma/intel,ldma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Lightning Mountain centralized low speed DMA and high speed DMA controllers.
>> +
>> +maintainers:
>> +  - chuanhua.lei@intel.com
>> +  - mallikarjunax.reddy@intel.com
>> +
>> +allOf:
>> +  - $ref: "dma-controller.yaml#"
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - intel,lgm-cdma
>> +      - intel,lgm-dma2tx
>> +      - intel,lgm-dma1rx
>> +      - intel,lgm-dma1tx
>> +      - intel,lgm-dma0tx
>> +      - intel,lgm-dma3
>> +      - intel,lgm-toe-dma30
>> +      - intel,lgm-toe-dma31
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#dma-cells":
>> +    const: 3
>> +    description:
>> +      The first cell is the peripheral's DMA request line.
>> +      The second cell is the peripheral's (port) number corresponding to the channel.
>> +      The third cell is the burst length of the channel.
>> +
>> +  dma-channels:
>> +    minimum: 1
>> +    maximum: 16
>> +
>> +  dma-channel-mask:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  reset-names:
>> +    items:
>> +      - const: ctrl
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  intel,dma-poll-cnt:
>> +    $ref: /schemas/types.yaml#definitions/uint32
>> +    description:
>> +      DMA descriptor polling counter is used to control the poling mechanism
> s/poling/polling
Ok, Thanks.
>
>> +      for the descriptor fetching for all channels.
>> +
>> +  intel,dma-byte-en:
>> +    type: boolean
>> +    description:
>> +      DMA byte enable is only valid for DMA write(RX).
>> +      Byte enable(1) means DMA write will be based on the number of dwords
>> +      instead of the whole burst.
> Can you explain this, also sounds you could use _maxburst values..?
when dma-byte-en = 0 (disabled) DMA write will be in terms of burst 
length, dma-byte-en = 1 (enabled) write will be in terms of Dwords.

Byte enable = 0 (Disabled) means that DMA write will be based on the 
burst length, even if it only transmits one byte.
Byte enable = 1(enabled) means that DMA write will be based on the 
number of Dwords, instead of the whole burst.

>
>> +
>> +  intel,dma-drb:
>> +    type: boolean
>> +    description:
>> +      DMA descriptor read back to make sure data and desc synchronization.
>> +
>> +  intel,dma-desc-in-sram:
>> +    type: boolean
>> +    description:
>> +      DMA descritpors in SRAM or not. Some old controllers descriptors
>> +      can be in DRAM or SRAM. The new ones are all in SRAM.
> should that not be decided by driver..? Or is this a hw property?
This is DMA controller capability. It can be decided from driver also. i 
will change accordingly.
>
>> +
>> +  intel,dma-orrc:
>> +    $ref: /schemas/types.yaml#definitions/uint32
>> +    description:
>> +      DMA outstanding read counter value determine the number of
>> +      ORR-Outstanding Read Request. The maximum value is 16.
> How would this be used by folks..?
A register bit will be used to enable/disable the ORR feature.

Outstanding Read Capability introduce CMD FIFO to support up to 16 
outstanding reads for different packet in same channel.

For large packets up to 16 OR can be issued, the number of OR is 
configurable.
>
>> +
>> +  intel,dma-dburst-wr:
>> +    type: boolean
>> +    description:
>> +      Enable RX dynamic burst write. When it is enabled, the DMA does RX dynamic burst;
>> +      if it is disabled, the DMA RX will still support programmable fixed burst size of 2,4,8,16.
>> +      It only applies to RX DMA and memcopy DMA.
>> +
>> +required:
>> +  - compatible
>> +  - reg
> So only two are mandatory, what about the bunch of intel properties you
> added above..?
Some of the properties are DMA capabilities, Enabling from device tree.
other properties will use default values from driver if we dont pass it 
from device tree.
>
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    dma0: dma-controller@e0e00000 {
>> +      compatible = "intel,lgm-cdma";
>> +      reg = <0xe0e00000 0x1000>;
>> +      #dma-cells = <3>;
>> +      dma-channels = <16>;
>> +      dma-channel-mask = <0xFFFF>;
>> +      interrupt-parent = <&ioapic1>;
>> +      interrupts = <82 1>;
>> +      resets = <&rcu0 0x30 0>;
>> +      reset-names = "ctrl";
>> +      clocks = <&cgu0 80>;
>> +      intel,dma-poll-cnt = <4>;
>> +      intel,dma-byte-en;
>> +      intel,dma-drb;
>> +    };
>> +  - |
>> +    dma3: dma-controller@ec800000 {
>> +      compatible = "intel,lgm-dma3";
>> +      reg = <0xec800000 0x1000>;
>> +      clocks = <&cgu0 71>;
>> +      resets = <&rcu0 0x10 9>;
>> +      #dma-cells = <3>;
>> +      intel,dma-poll-cnt = <16>;
>> +      intel,dma-desc-in-sram;
>> +      intel,dma-orrc = <16>;
>> +      intel,dma-byte-en;
>> +      intel,dma-dburst-wr;
>> +    };
>> -- 
>> 2.11.0
