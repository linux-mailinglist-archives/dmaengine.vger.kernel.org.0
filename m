Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7BB26306A
	for <lists+dmaengine@lfdr.de>; Wed,  9 Sep 2020 17:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgIIPVd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Sep 2020 11:21:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgIIL2b (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 9 Sep 2020 07:28:31 -0400
Received: from localhost (unknown [122.179.21.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C456521D7E;
        Wed,  9 Sep 2020 11:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599650835;
        bh=tM5snS//h/e7EQ06jlx7lfN6U8tLMdLL8+JPpa90vnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MfvK1PCU8BLI1AE1/u7ohhZn/IMHaar4w1qShyo0aWQTqwSBcMFoFXdirCMRKlEP+
         /JXuTCxLgkj7o/Mk6YvUMORmqXwtAE1xCEjrkXYgAUx/HiRHYVavEwZ1saCuIOk6DU
         DgZ+7gMRrei821PqE8fc73P0MOgUFiMNc8Ivae0g=
Date:   Wed, 9 Sep 2020 16:57:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, chuanhua.lei@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        malliamireddy009@gmail.com, peter.ujfalusi@ti.com
Subject: Re: [PATCH v6 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
Message-ID: <20200909112708.GN77521@vkoul-mobl>
References: <cover.1599605765.git.mallikarjunax.reddy@linux.intel.com>
 <ff2de5b0e4cd414420d48377c7c97c45d71f6197.1599605765.git.mallikarjunax.reddy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff2de5b0e4cd414420d48377c7c97c45d71f6197.1599605765.git.mallikarjunax.reddy@linux.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Amireddy,

On 09-09-20, 07:07, Amireddy Mallikarjuna reddy wrote:
> Add DT bindings YAML schema for DMA controller driver
> of Lightning Mountain(LGM) SoC.
> 
> Signed-off-by: Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
> ---
> v1:
> - Initial version.
> 
> v2:
> - Fix bot errors.
> 
> v3:
> - No change.
> 
> v4:
> - Address Thomas langer comments
>   - use node name pattern as dma-controller as in common binding.
>   - Remove "_" (underscore) in instance name.
>   - Remove "port-" and "chan-" in attribute name for both 'dma-ports' & 'dma-channels' child nodes.
> 
> v5:
> - Moved some of the attributes in 'dma-ports' & 'dma-channels' child nodes to dma client/consumer side as cells in 'dmas' properties.
> 
> v6:
> - Add additionalProperties: false
> - completely removed 'dma-ports' and 'dma-channels' child nodes.
> - Moved channel dt properties to client side dmas.
> - Use standard dma-channels and dma-channel-mask properties.
> - Documented reset-names
> - Add description for dma-cells
> ---
>  .../devicetree/bindings/dma/intel,ldma.yaml        | 154 +++++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/intel,ldma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
> new file mode 100644
> index 000000000000..4a2a12b829eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/intel,ldma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lightning Mountain centralized low speed DMA and high speed DMA controllers.
> +
> +maintainers:
> +  - chuanhua.lei@intel.com
> +  - mallikarjunax.reddy@intel.com
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> + $nodename:
> +   pattern: "^dma-controller(@.*)?$"
> +
> + compatible:
> +  enum:
> +   - intel,lgm-cdma
> +   - intel,lgm-dma2tx
> +   - intel,lgm-dma1rx
> +   - intel,lgm-dma1tx
> +   - intel,lgm-dma0tx
> +   - intel,lgm-dma3
> +   - intel,lgm-toe-dma30
> +   - intel,lgm-toe-dma31

Should this not say oneOf?

> +
> + reg:
> +  maxItems: 1
> +
> + "#dma-cells":
> +  const: 11

wow that is a big one

> +  description:
> +    The first & second cell is channel and port id's respectievly.

What does port id mean?

Can you please describe each parameter

> +    Third & fourth cells is Per channel data & descriptor endianness configuration respectievly according to SoC requirement.

What does per channel data refer? Isnt this all little endian?

> +    Fifth cell is Per channel byte offset(0~128)

Offset of?

> +    Sixth cell is per channel Write non-posted type for DMA RX last data beat of every descriptor.

Am not sure what this means?

> +    Seventh cell is per channel packet drop enabled or disabled.

Same here

> +    Eighth and nighth cells, The first is header mode size, the second is checksum enable or disable.
> +       If enabled, header mode size is ignored. If disabled, header mode size must be provided.
> +    Last two cells is Per channel dma hardware descriptor configuration.
> +       The first parameter is descriptor physical address and the second parameter hardware descriptor number

Do you really use all these parameters, or most of them are filled with
defaults?

> +
> + dma-channels:
> +  minimum: 1
> +  maximum: 16
> +
> + dma-channel-mask:
> +  $ref: /schemas/types.yaml#/definitions/uint32-array

This is already defined in
Documentation/devicetree/bindings/dma/dma-common.yaml, no need to define
this here

> +  items:
> +    minItems: 1
> +    # Should be enough

> +
> + clocks:
> +  maxItems: 1
> +
> + resets:
> +  maxItems: 1
> +
> + reset-names:
> +  items:
> +    - const: ctrl
> +
> + interrupts:
> +  maxItems: 1
> +
> + intel,dma-poll-cnt:
> +   $ref: /schemas/types.yaml#definitions/uint32
> +   description:
> +     DMA descriptor polling counter. It may need fine tune according
> +     to the system application scenario.

What does this mean? How will system application fine tune?

> +
> + intel,dma-byte-en:
> +   type: boolean
> +   description:
> +     DMA byte enable is only valid for DMA write(RX).
> +     Byte enable(1) means DMA write will be based on the number of dwords
> +     instead of the whole burst.

You already have this in #dma-cells, so why here. If here then why in
dma-cells

> +
> + intel,dma-drb:
> +    type: boolean
> +    description:
> +      DMA descriptor read back to make sure data and desc synchronization.

I think this is also in #dma-cells?

> +
> + intel,dma-burst:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +       Specifiy the DMA burst size(in dwords), the valid value will be 8, 16, 32.
> +       Default is 16 for data path dma, 32 is for memcopy DMA.

Burst should come from client, why is this here?

> +
> + intel,dma-polling-cnt:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +       DMA descriptor polling counter. It may need fine tune according to
> +       the system application scenario.

What does this counter do?

> +
> + intel,dma-desc-in-sram:
> +    type: boolean
> +    description:
> +       DMA descritpors in SRAM or not. Some old controllers descriptors
> +       can be in DRAM or SRAM. The new ones are all in SRAM.

What does this do?

> +
> + intel,dma-orrc:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +       DMA outstanding read counter. The maximum value is 16, and it may
> +       need fine tune according to the system application scenarios.

What does this do?

> +
> + intel,dma-dburst-wr:
> +    type: boolean
> +    description:
> +       Enable RX dynamic burst write. It only applies to RX DMA and memcopy DMA.

What does this do?

> +
> +required:
> + - compatible
> + - reg
> + - '#dma-cells'
> +
> +additionalProperties: false
> +
> +examples:
> + - |
> +   dma0: dma-controller@e0e00000 {
> +     compatible = "intel,lgm-cdma";
> +     reg = <0xe0e00000 0x1000>;
> +     #dma-cells = <11>;
> +     dma-channels = <16>;
> +     dma-channel-mask = <0xFFFF>;
> +     interrupt-parent = <&ioapic1>;
> +     interrupts = <82 1>;
> +     resets = <&rcu0 0x30 0>;
> +     reset-names = "ctrl";
> +     clocks = <&cgu0 80>;
> +     intel,dma-poll-cnt = <4>;
> +     intel,dma-byte-en;
> +     intel,dma-drb;
> +   };
> + - |
> +   dma3: dma-controller@ec800000 {
> +     compatible = "intel,lgm-dma3";
> +     reg = <0xec800000 0x1000>;
> +     clocks = <&cgu0 71>;
> +     resets = <&rcu0 0x10 9>;
> +     #dma-cells = <11>;
> +     intel,dma-burst = <32>;
> +     intel,dma-polling-cnt = <16>;
> +     intel,dma-desc-in-sram;
> +     intel,dma-orrc = <16>;
> +     intel,dma-byte-en;
> +     intel,dma-dburst-wr;
> +   };
> -- 
> 2.11.0

-- 
~Vinod
