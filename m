Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54293244F2B
	for <lists+dmaengine@lfdr.de>; Fri, 14 Aug 2020 22:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHNUc1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Aug 2020 16:32:27 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36908 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgHNUc0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Aug 2020 16:32:26 -0400
Received: by mail-io1-f66.google.com with SMTP id b16so12047252ioj.4;
        Fri, 14 Aug 2020 13:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q+Lrps6+cqpjI37gNuUGrPmnoQLPGbrIP2y111SCp4M=;
        b=LSTvKpe3J2bwaxlXEh4A3jQOzVopZPMj0ixHiPHomessnV438FSVwyIAY4268py4D+
         7bIOigo1h/E+nXBz+188Mtuyo7H6UQOK+HeWPlg1CXtCDGD8XPdLSLdlyNcYoDvPfQNi
         0nZ4L17BirIZMRGuynwz8sbFqLTDEXv3t3JnWyf/EqWTGnQi0jGTCkD+uZLZaxB9OscE
         vQFg24K+v7e4xLch3iHksJmWo4ua83AQMOiijzrzNNpmKTbuvF0PJJ/UfmtVODXPZA1Y
         EuuGeIhjv2FMgzN+oqbvRQOpEMGwbkJQFu27Vpz3ivYsMZ5FgiOx18/Ia/++9tNuuCh4
         cneg==
X-Gm-Message-State: AOAM532FfpjCU/5jXnaPDuXoxD2XJ8gb9Usr5maWTZ3ZBsuksdxAwbau
        4g/0LMGKbhFd+ZVbxdPpfg==
X-Google-Smtp-Source: ABdhPJxJIh5WYkpL/IUsiBN/MqsWtrVRDcs8qOhwRqqhQC8U98ZO+ylrjjEbFpM0P0wHb5Apjkd5Kw==
X-Received: by 2002:a02:c842:: with SMTP id r2mr4163133jao.87.1597437144872;
        Fri, 14 Aug 2020 13:32:24 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id a8sm1060216ilq.21.2020.08.14.13.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 13:32:24 -0700 (PDT)
Received: (nullmailer pid 2722962 invoked by uid 1000);
        Fri, 14 Aug 2020 20:32:22 -0000
Date:   Fri, 14 Aug 2020 14:32:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, chuanhua.lei@linux.intel.com,
        malliamireddy009@gmail.com
Subject: Re: [PATCH v5 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
Message-ID: <20200814203222.GA2674896@bogus>
References: <cover.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <68c77fd2ffb477aa4a52a58f8a26bfb191d3c5d1.1597381889.git.mallikarjunax.reddy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c77fd2ffb477aa4a52a58f8a26bfb191d3c5d1.1597381889.git.mallikarjunax.reddy@linux.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Aug 14, 2020 at 01:26:09PM +0800, Amireddy Mallikarjuna reddy wrote:
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
> ---
>  .../devicetree/bindings/dma/intel,ldma.yaml        | 319 +++++++++++++++++++++
>  1 file changed, 319 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/intel,ldma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
> new file mode 100644
> index 000000000000..9beaf191a6de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
> @@ -0,0 +1,319 @@
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
> + "#dma-cells":
> +   const: 1

Example says 3.

> +
> + compatible:
> +  anyOf:
> +   - const: intel,lgm-cdma
> +   - const: intel,lgm-dma2tx
> +   - const: intel,lgm-dma1rx
> +   - const: intel,lgm-dma1tx
> +   - const: intel,lgm-dma0tx
> +   - const: intel,lgm-dma3
> +   - const: intel,lgm-toe-dma30
> +   - const: intel,lgm-toe-dma31

'anyOf' doesn't make sense here. This should be a single 'enum'.

> +
> + reg:
> +  maxItems: 1
> +
> + clocks:
> +  maxItems: 1
> +
> + resets:
> +  maxItems: 1
> +
> + interrupts:
> +  maxItems: 1
> +
> + intel,dma-poll-cnt:
> +   $ref: /schemas/types.yaml#definitions/uint32
> +   description:
> +     DMA descriptor polling counter. It may need fine tune according
> +     to the system application scenario.
> +
> + intel,dma-byte-en:
> +   type: boolean
> +   description:
> +     DMA byte enable is only valid for DMA write(RX).
> +     Byte enable(1) means DMA write will be based on the number of dwords
> +     instead of the whole burst.
> +
> + intel,dma-drb:
> +    type: boolean
> +    description:
> +      DMA descriptor read back to make sure data and desc synchronization.
> +
> + intel,dma-burst:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +       Specifiy the DMA burst size(in dwords), the valid value will be 8, 16, 32.
> +       Default is 16 for data path dma, 32 is for memcopy DMA.
> +
> + intel,dma-polling-cnt:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +       DMA descriptor polling counter. It may need fine tune according to
> +       the system application scenario.
> +
> + intel,dma-desc-in-sram:
> +    type: boolean
> +    description:
> +       DMA descritpors in SRAM or not. Some old controllers descriptors
> +       can be in DRAM or SRAM. The new ones are all in SRAM.
> +
> + intel,dma-orrc:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +       DMA outstanding read counter. The maximum value is 16, and it may
> +       need fine tune according to the system application scenarios.
> +
> + intel,dma-dburst-wr:
> +    type: boolean
> +    description:
> +       Enable RX dynamic burst write. It only applies to RX DMA and memcopy DMA.
> +
> +
> + dma-ports:
> +    type: object
> +    description:
> +       This sub-node must contain a sub-node for each DMA port.
> +    properties:
> +      '#address-cells':
> +        const: 1
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      "^dma-ports@[0-9]+$":
> +          type: object
> +
> +          properties:
> +            reg:
> +              items:
> +                - enum: [0, 1, 2, 3, 4, 5]
> +              description:
> +                 Which port this node refers to.
> +
> +            intel,name:
> +              $ref: /schemas/types.yaml#definitions/string-array
> +              description:
> +                 Port name of each DMA port.

No other DMA controller needs this, why do you?

> +
> +            intel,chans:
> +              $ref: /schemas/types.yaml#/definitions/uint32-array
> +              description:
> +                 The channels included on this port. Format is channel start
> +                 number and how many channels on this port.

Why does this need to be in DT? This all seems like it can be in the dma 
cells for each client.

> +
> +          required:
> +            - reg
> +            - intel,name
> +            - intel,chans
> +
> +
> + ldma-channels:
> +    type: object
> +    description:
> +       This sub-node must contain a sub-node for each DMA channel.
> +    properties:
> +      '#address-cells':
> +        const: 1
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      "^ldma-channels@[0-15]+$":
> +          type: object
> +
> +          properties:
> +            reg:
> +              items:
> +                - enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
> +              description:
> +                 Which channel this node refers to.
> +
> +            intel,desc_num:
> +              $ref: /schemas/types.yaml#/definitions/uint32
> +              description:
> +                 Per channel maximum descriptor number. The max value is 255.
> +
> +            intel,hdr-mode:
> +              $ref: /schemas/types.yaml#/definitions/uint32-array
> +              description:
> +                 The first parameter is header mode size, the second
> +                 parameter is checksum enable or disable. If enabled,
> +                 header mode size is ignored. If disabled, header mode
> +                 size must be provided.
> +
> +            intel,hw-desc:
> +              $ref: /schemas/types.yaml#/definitions/uint32-array
> +              description:
> +                 Per channel dma hardware descriptor configuration.
> +                 The first parameter is descriptor physical address and the
> +                 second parameter hardware descriptor number.

Again, this all seems like per client information for dma cells.

> +
> +          required:
> +            - reg
> +
> +required:
> + - compatible
> + - reg
> + - '#dma-cells'

Add:

additionalProperties: false

> +
> +examples:
> + - |
> +   dma0: dma-controller@e0e00000 {
> +     compatible = "intel,lgm-cdma";
> +     reg = <0xe0e00000 0x1000>;
> +     #dma-cells = <3>;
> +     interrupt-parent = <&ioapic1>;
> +     interrupts = <82 1>;
> +     resets = <&rcu0 0x30 0>;
> +     reset-names = "ctrl";

Not documented.

> +     clocks = <&cgu0 80>;
> +     intel,dma-poll-cnt = <4>;
> +     intel,dma-byte-en;
> +     intel,dma-drb;
> +     dma-ports {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
> +       dma-ports@0 {
> +           reg = <0>;
> +           intel,name = "SPI0";
> +           intel,chans = <0 2>;
> +       };
> +       dma-ports@1 {
> +           reg = <1>;
> +           intel,name = "SPI1";
> +           intel,chans = <2 2>;
> +       };
> +       dma-ports@2 {
> +           reg = <2>;
> +           intel,name = "SPI2";
> +           intel,chans = <4 2>;
> +       };
> +       dma-ports@3 {
> +           reg = <3>;
> +           intel,name = "SPI3";
> +           intel,chans = <6 2>;
> +       };
> +       dma-ports@4 {
> +           reg = <4>;
> +           intel,name = "HSNAND";
> +           intel,chans = <8 2>;
> +       };
> +       dma-ports@5 {
> +           reg = <5>;
> +           intel,name = "PCM";
> +           intel,chans = <10 6>;
> +       };
> +     };
> +     ldma-channels {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
> +       ldma-channels@0 {
> +           reg = <0>;
> +           intel,desc_num = <1>;
> +       };
> +       ldma-channels@1 {
> +           reg = <1>;
> +           intel,desc_num = <1>;
> +       };
> +       ldma-channels@2 {
> +           reg = <2>;
> +           intel,desc_num = <1>;
> +       };
> +       ldma-channels@3 {
> +           reg = <3>;
> +           intel,desc_num = <1>;
> +       };
> +       ldma-channels@4 {
> +           reg = <4>;
> +           intel,desc_num = <1>;
> +       };
> +       ldma-channels@5 {
> +           reg = <5>;
> +           intel,desc_num = <1>;
> +       };
> +       ldma-channels@6 {
> +           reg = <6>;
> +           intel,desc_num = <1>;
> +       };
> +       ldma-channels@7 {
> +           reg = <7>;
> +           intel,desc_num = <1>;
> +       };
> +       ldma-channels@8 {
> +           reg = <8>;
> +       };
> +       ldma-channels@9 {
> +           reg = <9>;
> +       };
> +       ldma-channels@10 {
> +           reg = <10>;
> +       };
> +       ldma-channels@11 {
> +           reg = <11>;
> +       };
> +       ldma-channels@12 {
> +           reg = <12>;
> +       };
> +       ldma-channels@13 {
> +           reg = <13>;
> +       };
> +       ldma-channels@14 {
> +           reg = <14>;
> +       };
> +       ldma-channels@15 {
> +           reg = <15>;
> +       };
> +     };
> +   };
> + - |
> +   dma3: dma-controller@ec800000 {
> +     compatible = "intel,lgm-dma3";
> +     reg = <0xec800000 0x1000>;
> +     clocks = <&cgu0 71>;
> +     resets = <&rcu0 0x10 9>;
> +     #dma-cells = <7>;
> +     intel,dma-burst = <32>;
> +     intel,dma-polling-cnt = <16>;
> +     intel,dma-desc-in-sram;
> +     intel,dma-orrc = <16>;
> +     intel,dma-byte-en;
> +     intel,dma-dburst-wr;
> +     ldma-channels {
> +         #address-cells = <1>;
> +         #size-cells = <0>;
> +
> +         ldma-channels@12 {
> +             reg = <12>;
> +             intel,hdr-mode = <128 0>;
> +             intel,hw-desc = <0x20000000 8>;
> +         };
> +         ldma-channels@13 {
> +             reg = <13>;
> +             intel,hdr-mode = <128 0>;
> +         };
> +     };
> +   };
> -- 
> 2.11.0
> 
