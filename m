Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717682AFA46
	for <lists+dmaengine@lfdr.de>; Wed, 11 Nov 2020 22:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgKKVT5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Nov 2020 16:19:57 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46541 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgKKVT5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Nov 2020 16:19:57 -0500
Received: by mail-oi1-f196.google.com with SMTP id q206so3782711oif.13;
        Wed, 11 Nov 2020 13:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FR5cUQGJAwRsW5S/9IdaTkMTExIGPjgXJ35YYt9MG4U=;
        b=T1DMAqJ9Xa28++mG6GQjMrCA1e3AWfW4MlDzwHFwpTDLkJxdzfXxe/gLFE8Tt181+h
         BQoD/ty31XDltXfE2dvBj4lp/wFZmfK/rm75Rc4BPKkWzWlVN664O++ZKf+oIjWTSydj
         tKtsmd4HA1SGdAVYWpp3/tbmS3MJmrbMP2m4X4c/RQs9H06cqbgRbR9KwhJ3E5RLGGDJ
         FRYLltBEOkuNLM6JnuQ+sbPnGwJp4roWIjSk9WVY/iNkuaAIUXN89/mARDf8CP4ixm85
         FH0ewSzq5wYCAvjmyg528qalI9jP3qJSfg8tLz4b/RTJY1XSGQKcjQQlI3QXZthJHeWK
         SWmQ==
X-Gm-Message-State: AOAM5326csuRbLaUIU8jFN9O5AeqI6C+w9INMV2HgqR+NgOZ4CkPLtBV
        lvS5kaYWWk1aVTq5FfKVkA==
X-Google-Smtp-Source: ABdhPJwpRBbPDJ6smqnxt6TMUzeazfYK267dHNHhpZzHmKtFqODWHYkFybaR7Xv6unoVQln9enMslQ==
X-Received: by 2002:aca:90c:: with SMTP id 12mr3471342oij.15.1605129596483;
        Wed, 11 Nov 2020 13:19:56 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d62sm674805oia.6.2020.11.11.13.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 13:19:55 -0800 (PST)
Received: (nullmailer pid 2053382 invoked by uid 1000);
        Wed, 11 Nov 2020 21:19:54 -0000
Date:   Wed, 11 Nov 2020 15:19:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, chuanhua.lei@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        malliamireddy009@gmail.com, peter.ujfalusi@ti.com
Subject: Re: [PATCH v8 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
Message-ID: <20201111211954.GA2039514@bogus>
References: <cover.1604930089.git.mallikarjunax.reddy@linux.intel.com>
 <b06793aa409d05ac7e0729bcd2002c43ff25d48b.1604930089.git.mallikarjunax.reddy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b06793aa409d05ac7e0729bcd2002c43ff25d48b.1604930089.git.mallikarjunax.reddy@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Nov 09, 2020 at 10:14:24PM +0800, Amireddy Mallikarjuna reddy wrote:
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
> 
> v7:
> - modified compatible to oneof
> - Reduced number of dma-cells to 3
> - Fine tune the description of some properties.
> 
> v7-resend:
> - rebase to 5.10-rc1
> 
> v8:
> - rebased to 5.10-rc3
> - Fixing the bot issues (wrong indentation)
> ---
>  .../devicetree/bindings/dma/intel,ldma.yaml        | 134 +++++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/intel,ldma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
> new file mode 100644
> index 000000000000..7cf0eab1a703
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
> @@ -0,0 +1,134 @@
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
> +  $nodename:
> +    pattern: "^dma-controller(@.*)?$"

Drop. Already covered by dma-controller.yaml.

> +
> +  compatible:
> +    oneOf:
> +      - const: intel,lgm-cdma
> +      - const: intel,lgm-dma2tx
> +      - const: intel,lgm-dma1rx
> +      - const: intel,lgm-dma1tx
> +      - const: intel,lgm-dma0tx
> +      - const: intel,lgm-dma3
> +      - const: intel,lgm-toe-dma30
> +      - const: intel,lgm-toe-dma31

Use 'enum' instead of oneOf+const.

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#dma-cells":
> +    const: 3
> +    description:
> +      The first cell is the peripheral's DMA request line.
> +      The second cell is the peripheral's (port) number corresponding to the channel.
> +      The third cell is the burst length of the channel.
> +
> +  dma-channels:
> +    minimum: 1
> +    maximum: 16
> +
> +  dma-channel-mask:
> +    items:
> +      minItems: 1

It should be maxItems you define. And 'items' should be dropped. 

> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: ctrl
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  intel,dma-poll-cnt:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +      DMA descriptor polling counter is used to control the poling mechanism
> +      for the descriptor fetching for all channels.
> +
> +  intel,dma-byte-en:
> +    type: boolean
> +    description:
> +      DMA byte enable is only valid for DMA write(RX).
> +      Byte enable(1) means DMA write will be based on the number of dwords
> +      instead of the whole burst.
> +
> +  intel,dma-drb:
> +    type: boolean
> +    description:
> +      DMA descriptor read back to make sure data and desc synchronization.
> +
> +  intel,dma-desc-in-sram:
> +    type: boolean
> +    description:
> +      DMA descritpors in SRAM or not. Some old controllers descriptors
> +      can be in DRAM or SRAM. The new ones are all in SRAM.
> +
> +  intel,dma-orrc:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +      DMA outstanding read counter value determine the number of
> +      ORR-Outstanding Read Request. The maximum value is 16.

blank line

> +  intel,dma-dburst-wr:
> +    type: boolean
> +    description:
> +      Enable RX dynamic burst write. When it is enabled, the DMA does RX dynamic burst;
> +      if it is disabled, the DMA RX will still support programmable fixed burst size of 2,4,8,16.
> +      It only applies to RX DMA and memcopy DMA.
> +
> +required:
> +  - compatible
> +  - reg

> +  - '#dma-cells'

dma-common.yaml covers this, you can drop it here.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dma0: dma-controller@e0e00000 {
> +      compatible = "intel,lgm-cdma";
> +      reg = <0xe0e00000 0x1000>;
> +      #dma-cells = <3>;
> +      dma-channels = <16>;
> +      dma-channel-mask = <0xFFFF>;
> +      interrupt-parent = <&ioapic1>;
> +      interrupts = <82 1>;
> +      resets = <&rcu0 0x30 0>;
> +      reset-names = "ctrl";
> +      clocks = <&cgu0 80>;
> +      intel,dma-poll-cnt = <4>;
> +      intel,dma-byte-en;
> +      intel,dma-drb;
> +    };
> +  - |
> +    dma3: dma-controller@ec800000 {
> +      compatible = "intel,lgm-dma3";
> +      reg = <0xec800000 0x1000>;
> +      clocks = <&cgu0 71>;
> +      resets = <&rcu0 0x10 9>;
> +      #dma-cells = <3>;
> +      intel,dma-poll-cnt = <16>;
> +      intel,dma-desc-in-sram;
> +      intel,dma-orrc = <16>;
> +      intel,dma-byte-en;
> +      intel,dma-dburst-wr;
> +    };
> -- 
> 2.11.0
> 
