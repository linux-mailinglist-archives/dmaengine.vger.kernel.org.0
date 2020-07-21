Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE9E227642
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jul 2020 04:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgGUCyD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jul 2020 22:54:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:14656 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgGUCyD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 20 Jul 2020 22:54:03 -0400
IronPort-SDR: Y+j1A2DsjOVs4WQmLp2xV+1mio2FYYs12AJDuIyuhrNK/rlhp300brV2wDYrymNsLgWgTPLuO1
 l6KUraCby7UA==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="137539898"
X-IronPort-AV: E=Sophos;i="5.75,377,1589266800"; 
   d="scan'208";a="137539898"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 19:54:02 -0700
IronPort-SDR: 2MB0E2yHAoVO8AXeiUZ8EA5mJUE+3+A1JwDCgJ/C+cRCPZoJwOrrsVlC4lBx7uaSoUXm21aCM5
 Kjak0wt2jUWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,377,1589266800"; 
   d="scan'208";a="310072117"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jul 2020 19:54:01 -0700
Received: from [10.213.40.164] (mreddy3x-MOBL.gar.corp.intel.com [10.213.40.164])
        by linux.intel.com (Postfix) with ESMTP id 370EB580824;
        Mon, 20 Jul 2020 19:53:58 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
To:     Rob Herring <robh@kernel.org>
Cc:     "Langer, Thomas" <thomas.langer@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "Kim, Cheol Yong" <cheol.yong.kim@intel.com>,
        "Wu, Qiming" <qi-ming.wu@intel.com>,
        "malliamireddy009@gmail.com" <malliamireddy009@gmail.com>,
        mallikarjunax.reddy@intel.com
References: <cover.1594273437.git.mallikarjunax.reddy@linux.intel.com>
 <ad6c511dc027b7989acebbce77ca739e22e2123e.1594273437.git.mallikarjunax.reddy@linux.intel.com>
 <DM6PR11MB3227DE41730A08B57B9C14DCFE640@DM6PR11MB3227.namprd11.prod.outlook.com>
 <1f90d37c-d029-ae80-40f5-7d99b486dbd3@linux.intel.com>
 <20200713172211.GA391669@bogus>
From:   "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Message-ID: <f428ad6c-ef69-a473-40bd-bc286661dcfd@linux.intel.com>
Date:   Tue, 21 Jul 2020 10:53:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713172211.GA391669@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Thanks Rob for the review. Please see my comments inline.

On 7/14/2020 1:22 AM, Rob Herring wrote:
> On Mon, Jul 13, 2020 at 11:39:49AM +0800, Reddy, MallikarjunaX wrote:
>> Hi Thomas,
>>
>> Thanks for the review. My comments inline.
>>
>> On 7/9/2020 3:54 PM, Langer, Thomas wrote:
>>>> -----Original Message-----
>>>> From: devicetree-owner@vger.kernel.org <devicetree-
>>>> owner@vger.kernel.org> On Behalf Of Amireddy Mallikarjuna reddy
>>>> Sent: Donnerstag, 9. Juli 2020 08:01
>>>> To: dmaengine@vger.kernel.org; vkoul@kernel.org;
>>>> devicetree@vger.kernel.org; robh+dt@kernel.org
>>>> Cc: linux-kernel@vger.kernel.org; Shevchenko, Andriy
>>>> <andriy.shevchenko@intel.com>; chuanhua.lei@linux.intel.com; Kim, Cheol
>>>> Yong <cheol.yong.kim@intel.com>; Wu, Qiming <qi-ming.wu@intel.com>;
>>>> malliamireddy009@gmail.com; Amireddy Mallikarjuna reddy
>>>> <mallikarjunax.reddy@linux.intel.com>
>>>> Subject: [PATCH v4 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
>>>>
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
>>> Please read my comments again and then respond about the topics you ignored.
>>> I added some hints below again.
>>>
>>> Thanks.
>>>
>>>> ---
>>>>    .../devicetree/bindings/dma/intel,ldma.yaml        | 416
>>>> +++++++++++++++++++++
>>>>    1 file changed, 416 insertions(+)
>>>>    create mode 100644
>>>> Documentation/devicetree/bindings/dma/intel,ldma.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml
>>>> b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
>>>> new file mode 100644
>>>> index 000000000000..7f666b9812e4
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
>>>> @@ -0,0 +1,416 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/dma/intel,ldma.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Lightning Mountain centralized low speed DMA and high speed DMA
>>>> controllers.
>>>> +
>>>> +maintainers:
>>>> +  - chuanhua.lei@intel.com
>>>> +  - mallikarjunax.reddy@intel.com
>>>> +
>>>> +properties:
>>>> + $nodename:
>>>> +   pattern: "^dma(@.*)?$"
>>> Please explain the difference to the common dma binding.
>> No difference. we can use "^dma-controller(@.*)?$" as in the common binding.
>> Its My bad. I missed the changes to include in this patch. Surely update in
>> the upcoming patch.
>>>> +
>>>> + "#dma-cells":
>>>> +   const: 1
>>>> +
>>>> + compatible:
>>>> +  anyOf:
>>>> +   - const: intel,lgm-cdma
>>>> +   - const: intel,lgm-dma2tx
>>>> +   - const: intel,lgm-dma1rx
>>>> +   - const: intel,lgm-dma1tx
>>>> +   - const: intel,lgm-dma0tx
>>>> +   - const: intel,lgm-dma3
>>>> +   - const: intel,lgm-toe-dma30
>>>> +   - const: intel,lgm-toe-dma31
>>> Please explain why you need so many different compatible strings.
>> This hw dma has 7 DMA instances.
>> Some for datapath, some for memcpy  and some for TOE.
>> Some for TX only, some for RX only, and some for TX/RX(memcpy and ToE).
>>
>> dma TX/RX type we considered as driver specific data of each instance and
>> used different compatible strings for each instance.
>> And also idea is in future if any driver specific data of any particular
>> instance we can handle.
>>
>> Here if dma name and type(tx or rx) will be accepted as devicetree
>> attributes then we can move .name = "toe_dma31", & .type = DMA_TYPE_MCPY
>> to devicetree. So that the compatible strings can be limited to two.
>> intel,lgm-cdma & intel,lgm-hdma .
> Different compatibles are okay if the instances are different and we
> don't have properties to describe the differences.
>
> For some of what you have in this binding, I think it should be part of
> the consumer cells.
>
>> please suggest us the better proposal.
>>>> +
>>>> + reg:
>>>> +  maxItems: 1
>>>> +
>>>> + clocks:
>>>> +  maxItems: 1
>>>> +
>>>> + resets:
>>>> +  maxItems: 1
>>>> +
>>>> + interrupts:
>>>> +  maxItems: 1
>>>> +
>>>> + intel,dma-poll-cnt:
>>>> +   $ref: /schemas/types.yaml#definitions/uint32
>>>> +   description:
>>>> +     DMA descriptor polling counter. It may need fine tune according
>>>> +     to the system application scenario.
>>>> +
>>>> + intel,dma-byte-en:
>>>> +   type: boolean
>>>> +   description:
>>>> +     DMA byte enable is only valid for DMA write(RX).
>>>> +     Byte enable(1) means DMA write will be based on the number of
>>>> dwords
>>>> +     instead of the whole burst.
>>>> +
>>>> + intel,dma-drb:
>>>> +    type: boolean
>>>> +    description:
>>>> +      DMA descriptor read back to make sure data and desc
>>>> synchronization.
>>>> +
>>>> + intel,dma-burst:
>>>> +    $ref: /schemas/types.yaml#definitions/uint32
>>>> +    description:
>>>> +       Specifiy the DMA burst size(in dwords), the valid value will be
>>>> 8, 16, 32.
>>>> +       Default is 16 for data path dma, 32 is for memcopy DMA.
>>>> +
>>>> + intel,dma-polling-cnt:
> What's the difference with intel,dma-poll-cnt?
This is redundant. I will remove it.
>
>>>> +    $ref: /schemas/types.yaml#definitions/uint32
>>>> +    description:
>>>> +       DMA descriptor polling counter. It may need fine tune according
>>>> to
>>>> +       the system application scenario.
>>>> +
>>>> + intel,dma-desc-in-sram:
>>>> +    type: boolean
>>>> +    description:
>>>> +       DMA descritpors in SRAM or not. Some old controllers descriptors
>>>> +       can be in DRAM or SRAM. The new ones are all in SRAM.
>>>> +
>>>> + intel,dma-orrc:
>>>> +    $ref: /schemas/types.yaml#definitions/uint32
>>>> +    description:
>>>> +       DMA outstanding read counter. The maximum value is 16, and it
>>>> may
>>>> +       need fine tune according to the system application scenarios.
>>>> +
>>>> + intel,dma-dburst-wr:
>>>> +    type: boolean
>>>> +    description:
>>>> +       Enable RX dynamic burst write. It only applies to RX DMA and
>>>> memcopy DMA.
>>>> +
>>>> +
>>>> + dma-ports:
>>>> +    type: object
>>>> +    description:
>>>> +       This sub-node must contain a sub-node for each DMA port.
> What's a DMA port?
DMA port represent the peripheral.
>
>>>> +    properties:
>>>> +      '#address-cells':
>>>> +        const: 1
>>>> +      '#size-cells':
>>>> +        const: 0
>>>> +
>>>> +    patternProperties:
>>>> +      "^dma-ports@[0-9]+$":
>>>> +          type: object
>>>> +
>>>> +          properties:
>>>> +            reg:
>>>> +              items:
>>>> +                - enum: [0, 1, 2, 3, 4, 5]
>>>> +              description:
>>>> +                 Which port this node refers to.
>>>> +
>>>> +            intel,name:
>>>> +              $ref: /schemas/types.yaml#definitions/string-array
>>>> +              description:
>>>> +                 Port name of each DMA port.
> Why do you need this?
we are using port name for
1. compare with name and and enable port configurations dynamically when 
it is enabled from devicetree.
2. for debug purpose.
>
>>>> +
>>>> +            intel,chans:
>>>> +              $ref: /schemas/types.yaml#/definitions/uint32-array
>>>> +              description:
>>>> +                 The channels included on this port. Format is channel
>>>> start
>>>> +                 number and how many channels on this port.
> We already have standard properties for defining channels.
I think you are reffering to 'dma-channels' property. This represents 
Number of DMA channels supported by the controller.

intel,chans attribute represents channels starting number and number of 
channels in this port.
intel,chans = <channel starting number, number of channels in this port>
>
>>>> +
>>>> +            intel,burst:
>>>> +              $ref: /schemas/types.yaml#/definitions/uint32
>>>> +              description:
>>>> +                 Specify the DMA port burst size, the valid value will
>>>> be
>>>> +                 2, 4, 8. Default is 2 for data path dma.
> This would normally be in the consumer cells.
>
>>>> +
>>>> +            intel,txwgt:
>>>> +              $ref: /schemas/types.yaml#/definitions/uint32
>>>> +              description:
>>>> +                 Specify the port transmit weight for QoS purpose. The
>>>> valid
>>>> +                 value is 1~7. Default value is 1.
>>>> +
>>>> +            intel,endian:
>>>> +              $ref: /schemas/types.yaml#/definitions/uint32
>>>> +              description:
>>>> +                 Specify the DMA port endiannes conversion due to SoC
>>>> endianness difference.
>>>> +
>>>> +          required:
>>>> +            - reg
>>>> +            - intel,name
>>>> +            - intel,chans
>>>> +
>>>> +
>>>> + dma-channels:
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
>>>> +      "^dma-channels@[0-9]+$":
>>>> +          type: object
>>>> +
>>>> +          properties:
>>>> +            reg:
>>>> +              items:
>>>> +                - enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
>>>> 14, 15]
>>>> +              description:
>>>> +                 Which channel this node refers to.
>>>> +
>>>> +            intel,desc_num:
>>>> +              $ref: /schemas/types.yaml#/definitions/uint32
>>>> +              description:
>>>> +                 Per channel maximum descriptor number. The max value
>>>> is 255.
>>>> +
>>>> +            intel,pkt_sz:
>>>> +              $ref: /schemas/types.yaml#/definitions/uint32
>>>> +              description:
>>>> +                 Channel buffer packet size. It must be power of 2.
>>>> +                 The maximum size is 4096.
>>>> +
>>>> +            intel,desc-rx-nonpost:
>>>> +              type: boolean
>>>> +              description:
>>>> +                 Write non-posted type for DMA RX last data beat of
>>>> every descriptor.
>>>> +
>>>> +            intel,data-endian:
>>>> +              $ref: /schemas/types.yaml#/definitions/uint32
>>>> +              description:
>>>> +                 Per channel data endianness configuration according to
>>>> SoC requirement.
>>>> +
>>>> +            intel,desc-endian:
>>>> +              $ref: /schemas/types.yaml#/definitions/uint32
>>>> +              description:
>>>> +                 Per channel descriptor endianness configuration
>>>> according to SoC requirement.
>>>> +
>>>> +            intel,data-endian-en:
>>>> +              type: boolean
>>>> +              description:
>>>> +                 Per channel data endianness enabled.
>>>> +
>>>> +            intel,desc-endian-en:
>>>> +              type: boolean
>>>> +              description:
>>>> +                 Per channel descriptor endianness enabled.
>>>> +
>>>> +            intel,byte-offset:
>>>> +              $ref: /schemas/types.yaml#/definitions/uint32
>>>> +              description:
>>>> +                 Per channel byte offset(0~128).
>>>> +
>>>> +            intel,hdr-mode:
>>>> +              $ref: /schemas/types.yaml#/definitions/uint32-array
>>>> +              description:
>>>> +                 The first parameter is header mode size, the second
>>>> +                 parameter is checksum enable or disable. If enabled,
>>>> +                 header mode size is ignored. If disabled, header mode
>>>> +                 size must be provided.
>>>> +
>>>> +            intel,non-arb-cnt:
>>>> +              $ref: /schemas/types.yaml#/definitions/uint32
>>>> +              description:
>>>> +                 Per channel non arbitration counter while polling
>>>> +
>>>> +            intel,arb-cnt:
>>>> +              $ref: /schemas/types.yaml#/definitions/uint32
>>>> +              description:
>>>> +                 Per channel arbitration counter while polling.
>>>> +                 arb_cnt must be greater than non_arb_cnt
>>>> +
>>>> +            intel,pkt-drop:
>>>> +              type: boolean
>>>> +              description:
>>>> +                 Channel packet drop enabled or disabled.
>>>> +
>>>> +            intel,hw-desc:
>>>> +              $ref: /schemas/types.yaml#/definitions/uint32-array
>>>> +              description:
>>>> +                 Per channel dma hardware descriptor configuration.
>>>> +                 The first parameter is descriptor physical address and
>>>> the
>>>> +                 second parameter hardware descriptor number.
> All/most of these seem like client/consumer settings.
>
>>>> +
>>>> +          required:
>>>> +            - reg
>>>> +
>>>> +required:
>>>> + - compatible
>>>> + - reg
>>>> + - '#dma-cells'
>>>> +
>>>> +examples:
>>>> + - |
>>>> +   dma0: dma@e0e00000 {
>>>> +     compatible = "intel,lgm-cdma";
>>>> +     reg = <0xe0e00000 0x1000>;
>>>> +     #dma-cells = <1>;
>>>> +     interrupt-parent = <&ioapic1>;
>>>> +     interrupts = <82 1>;
>>>> +     resets = <&rcu0 0x30 0>;
>>>> +     reset-names = "ctrl";
>>>> +     clocks = <&cgu0 80>;
>>>> +     intel,dma-poll-cnt = <4>;
>>>> +     intel,dma-byte-en;
>>>> +     intel,dma-drb;
>>>> +     dma-ports {
>>>> +       #address-cells = <1>;
>>>> +       #size-cells = <0>;
>>>> +
>>>> +       dma-ports@0 {
>>>> +           reg = <0>;
>>>> +           intel,name = "SPI0";
>>>> +           intel,chans = <0 2>;
>>>> +           intel,burst = <2>;
>>>> +           intel,txwgt = <1>;
> Yeah, based on the names, it definitely seems like these belong as cells
> in 'dmas' properties.

ok.
If we move these attributes to dmas, we need to configure these 
dynamically from driver side when client request for channel.

Both port and channel mapping is needed for dma slave configuration and 
also the available channels reading from device-tree dynamically instead 
of reading from registers.
So port & channel id's and descriptor information will keep in the child 
nodes and other attributes like burst, txwgt will move to 'dmas'.

>>>> +       };
>>>> +       dma-ports@1 {
>>>> +           reg = <1>;
>>>> +           intel,name = "SPI1";
>>>> +           intel,chans = <2 2>;
>>>> +           intel,burst = <2>;
>>>> +           intel,txwgt = <1>;
>>>> +       };
>>>> +       dma-ports@2 {
>>>> +           reg = <2>;
>>>> +           intel,name = "SPI2";
>>>> +           intel,chans = <4 2>;
>>>> +           intel,burst = <2>;
>>>> +           intel,txwgt = <1>;
>>>> +       };
>>>> +       dma-ports@3 {
>>>> +           reg = <3>;
>>>> +           intel,name = "SPI3";
>>>> +           intel,chans = <6 2>;
>>>> +           intel,burst = <2>;
>>>> +           intel,endian = <0>;
>>>> +           intel,txwgt = <1>;
>>>> +       };
>>>> +       dma-ports@4 {
>>>> +           reg = <4>;
>>>> +           intel,name = "HSNAND";
>>>> +           intel,chans = <8 2>;
>>>> +           intel,burst = <8>;
>>>> +           intel,txwgt = <1>;
>>>> +       };
>>>> +       dma-ports@5 {
>>>> +           reg = <5>;
>>>> +           intel,name = "PCM";
>>>> +           intel,chans = <10 6>;
>>>> +           intel,burst = <8>;
>>>> +           intel,txwgt = <1>;
>>>> +       };
>>>> +     };
>>>> +     dma-channels {
>>>> +       #address-cells = <1>;
>>>> +       #size-cells = <0>;
>>>> +
>>>> +       dma-channels@0 {
>>>> +           reg = <0>;
>>>> +           intel,desc_num = <1>;
>>>> +       };
>>>> +       dma-channels@1 {
>>>> +           reg = <1>;
>>>> +           intel,desc_num = <1>;
>>>> +       };
>>>> +       dma-channels@2 {
>>>> +           reg = <2>;
>>>> +           intel,desc_num = <1>;
>>>> +       };
>>>> +       dma-channels@3 {
>>>> +           reg = <3>;
>>>> +           intel,desc_num = <1>;
>>>> +       };
>>>> +       dma-channels@4 {
>>>> +           reg = <4>;
>>>> +           intel,desc_num = <1>;
>>>> +       };
>>>> +       dma-channels@5 {
>>>> +           reg = <5>;
>>>> +           intel,desc_num = <1>;
>>>> +       };
>>>> +       dma-channels@6 {
>>>> +           reg = <6>;
>>>> +           intel,desc_num = <1>;
>>>> +       };
>>>> +       dma-channels@7 {
>>>> +           reg = <7>;
>>>> +           intel,desc_num = <1>;
>>>> +       };
>>>> +       dma-channels@8 {
>>>> +           reg = <8>;
>>>> +       };
>>>> +       dma-channels@9 {
>>>> +           reg = <9>;
>>>> +       };
>>>> +       dma-channels@10 {
>>>> +           reg = <10>;
>>>> +       };
>>>> +       dma-channels@11 {
>>>> +           reg = <11>;
>>>> +       };
>>>> +       dma-channels@12 {
>>>> +           reg = <12>;
>>>> +       };
>>>> +       dma-channels@13 {
>>>> +           reg = <13>;
>>>> +       };
>>>> +       dma-channels@14 {
>>>> +           reg = <14>;
>>>> +       };
>>>> +       dma-channels@15 {
>>>> +           reg = <15>;
>>>> +       };
>>>> +     };
>>>> +   };
>>>> + - |
>>>> +   dma3: dma@ec800000 {
>>>> +     compatible = "intel,lgm-dma3";
>>>> +     reg = <0xec800000 0x1000>;
>>>> +     clocks = <&cgu0 71>;
>>>> +     resets = <&rcu0 0x10 9>;
>>>> +     #dma-cells = <1>;
>>>> +     intel,dma-burst = <32>;
>>>> +     intel,dma-polling-cnt = <16>;
>>>> +     intel,dma-desc-in-sram;
>>>> +     intel,dma-orrc = <16>;
>>>> +     intel,dma-byte-en;
>>>> +     intel,dma-dburst-wr;
>>>> +     dma-channels {
>>>> +         #address-cells = <1>;
>>>> +         #size-cells = <0>;
>>>> +
>>>> +         dma-channels@12 {
>>>> +             reg = <12>;
>>>> +             intel,pkt_sz = <4096>;
>>>> +             intel,desc-rx-nonpost;
>>>> +             intel,data-endian = <0>;
>>>> +             intel,desc-endian = <0>;
>>>> +             intel,data-endian-en;
>>>> +             intel,desc-endian-en;
>>>> +             intel,byte-offset = <0>;
>>>> +             intel,hdr-mode = <128 0>;
>>>> +             intel,non-arb-cnt = <0>;
>>>> +             intel,arb-cnt = <0>;
>>>> +             intel,hw-desc = <0x20000000 8>;
>>>> +         };
>>>> +         dma-channels@13 {
>>>> +             reg = <13>;
>>>> +             intel,pkt-drop;
>>>> +             intel,pkt_sz = <4096>;
>>>> +             intel,data-endian = <0>;
>>>> +             intel,desc-endian = <0>;
>>>> +             intel,data-endian-en;
>>>> +             intel,desc-endian-en;
>>>> +             intel,byte-offset = <0>;
>>>> +             intel,hdr-mode = <128 0>;
>>>> +             intel,non-arb-cnt = <0>;
>>>> +             intel,arb-cnt = <0>;
>>>> +         };
>>>> +     };
>>>> +   };
>>>> --
>>>> 2.11.0
