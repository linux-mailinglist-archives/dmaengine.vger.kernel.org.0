Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D505D2F7424
	for <lists+dmaengine@lfdr.de>; Fri, 15 Jan 2021 09:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbhAOIQE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Jan 2021 03:16:04 -0500
Received: from mga03.intel.com ([134.134.136.65]:36044 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbhAOIQE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 Jan 2021 03:16:04 -0500
IronPort-SDR: 2bJuAKcR0JQK5BuL7bSmuYGEJ7JfBQRGTw5WctheSAbp/JPxRRIBs8B0LfoiKTlR5k4nxan+kM
 PwOx+h3JHIbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="178603215"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="178603215"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 00:14:17 -0800
IronPort-SDR: IcW7Q/7dF5CWg7RPFXT79PGarzBvNvxUTslQbt8aH2GHM+sOzKOij2MOIFsCHdD+aPh+vzpQEo
 f8tRWZA8oahw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="349422131"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2021 00:14:17 -0800
Received: from [10.214.162.122] (mreddy3x-MOBL.gar.corp.intel.com [10.214.162.122])
        by linux.intel.com (Postfix) with ESMTP id B450B580908;
        Fri, 15 Jan 2021 00:14:14 -0800 (PST)
Subject: Re: [RESEND PATCH v10 1/2] dt-bindings: dma: Add bindings for Intel
 LGM SoC
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, Vinod <vkoul@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        chuanhua.lei@linux.intel.com,
        "Kim, Cheol Yong" <cheol.yong.kim@intel.com>,
        "Wu, Qiming" <qi-ming.wu@intel.com>, malliamireddy009@gmail.com,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <cover.1608090736.git.mallikarjunax.reddy@linux.intel.com>
 <dee2d43dff26f7d5b6eaa0006659da254f1093d3.1608090736.git.mallikarjunax.reddy@linux.intel.com>
 <CAL_JsqJE59nA_Bvt1rL95WfeXjQkOSPiTZk8zAbdHSkujmS3gQ@mail.gmail.com>
From:   "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Message-ID: <b78a503b-2dca-3f5c-050e-b7c92a215842@linux.intel.com>
Date:   Fri, 15 Jan 2021 16:14:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJE59nA_Bvt1rL95WfeXjQkOSPiTZk8zAbdHSkujmS3gQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Sure Rob.

Thanks,
Mallikarjuna reddy A

On 1/15/2021 4:25 AM, Rob Herring wrote:
> On Tue, Dec 15, 2020 at 10:08 PM Amireddy Mallikarjuna reddy
> <mallikarjunax.reddy@linux.intel.com> wrote:
>> Add DT bindings YAML schema for DMA controller driver
>> of Lightning Mountain (LGM) SoC.
>>
>> Signed-off-by: Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
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
>> - No change.
>>
>> v8:
>> - rebased to 5.10-rc3
>> - Fixing the bot issues (wrong indentation)
>>
>> v9:
>> - Use 'enum' instead of oneOf+const
>> - Drop '#dma-cells' in required:, already covered in dma-common.yaml
>> - Drop nodename Already covered by dma-controller.yaml
>>
>> v10:
>> - rebased to 5.10-rc6
>> - Add Reviewed-by: Rob Herring <robh@kernel.org>
>> - Fixed typo.
>> - moved property dma-desc-in-sram to driver side.
>> - Moved property dma-orrc to driver side.
>>
>> v10-resend:
>> - rebased to 5.10
>> - No change
>> ---
>>   .../devicetree/bindings/dma/intel,ldma.yaml   | 116 ++++++++++++++++++
>>   1 file changed, 116 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/dma/intel,ldma.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
>> new file mode 100644
>> index 000000000000..866d4c758a7a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
>> @@ -0,0 +1,116 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dma/intel,ldma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Lightning Mountain centralized DMA controllers.
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
> Since this was sent, there have been some fixes for JSON pointers and
> this is missing a '/'. The tools now check:
>
> /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/dma/intel,ldma.yaml:
> properties:intel,dma-poll-cnt: 'oneOf' conditional failed, one must be
> fixed:
>   'enum' is a required property
>   'const' is a required property
>   '/schemas/types.yaml#definitions/uint32' does not match
> 'types.yaml#/definitions/'
>
> Please send a fix for this.
>
> Thanks,
> Rob
