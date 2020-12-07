Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1CF2D19E9
	for <lists+dmaengine@lfdr.de>; Mon,  7 Dec 2020 20:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgLGTmq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Dec 2020 14:42:46 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43309 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgLGTmp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Dec 2020 14:42:45 -0500
Received: by mail-ot1-f68.google.com with SMTP id q25so1837597otn.10;
        Mon, 07 Dec 2020 11:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=84+J237t/hnJOzYX4kbUkVLlgPgC59cjHTRFGZBkpb8=;
        b=CMRI52G2KDubxiS1GmyLiXRKtY/ht57zEBeYBjJ6wxgQdF/ytWe9Z1P067OOI06ddo
         k0/m3H5bb5maOPIP6oele+/h7WrtU4CkX7a4acK54F2EullmKNJMQsiewC9go84fF3eq
         TRoQ1ZQVJpbU176Z7hT/N4bGMOdyVRspQ/jsO+J85qe8vPYeU8r+TY/rKbolIi37+Ml4
         eqwKXVb89blDd6ZfaHjhaKgc5Ennv2hwERlRL126y7gignKO7YaBhdODReChuFvd3BO0
         0P9kKbe9MDI/YGt97b1OiMDwk2UsnSkL5+AQFNyheK2gGTygt2ZYd517Q6pqqlsKixHM
         2sBQ==
X-Gm-Message-State: AOAM533Ss70qUk3zjg/Y15bqEovZjgDx9equihOzS7/ZksSgzFWgpmLQ
        E8eyr2CDP8ZnINTCm0+ebQ==
X-Google-Smtp-Source: ABdhPJzzJtRHoo1SQLEodnLKivdWQElYR/nCd4dx/2FhhE/Pbb8LDCCmWUB6c9OK+OCfe//5VeG77Q==
X-Received: by 2002:a9d:3d08:: with SMTP id a8mr14096750otc.126.1607370124083;
        Mon, 07 Dec 2020 11:42:04 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t13sm3143430oic.4.2020.12.07.11.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:42:02 -0800 (PST)
Received: (nullmailer pid 690584 invoked by uid 1000);
        Mon, 07 Dec 2020 19:42:01 -0000
Date:   Mon, 7 Dec 2020 13:42:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, t-kristo@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        vigneshr@ti.com, grygorii.strashko@ti.com
Subject: Re: [PATCH v2 10/19] dt-bindings: dma: ti: Add document for K3 BCDMA
Message-ID: <20201207194201.GA680126@robh.at.kernel.org>
References: <20201117105656.5236-1-peter.ujfalusi@ti.com>
 <20201117105656.5236-11-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117105656.5236-11-peter.ujfalusi@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Nov 17, 2020 at 12:56:47PM +0200, Peter Ujfalusi wrote:
> New binding document for
> Texas Instruments K3 Block Copy DMA (BCDMA).
> 
> BCDMA is introduced as part of AM64.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 175 ++++++++++++++++++
>  1 file changed, 175 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> new file mode 100644
> index 000000000000..c6d76641ebec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> @@ -0,0 +1,175 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/ti/k3-bcdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments K3 DMSS BCDMA Device Tree Bindings
> +
> +maintainers:
> +  - Peter Ujfalusi <peter.ujfalusi@ti.com>
> +
> +description: |
> +  The Block Copy DMA (BCDMA) is intended to perform similar functions as the TR
> +  mode channels of K3 UDMA-P.
> +  BCDMA includes block copy channels and Split channels.
> +
> +  Block copy channels mainly used for memory to memory transfers, but with
> +  optional triggers a block copy channel can service peripherals by accessing
> +  directly to memory mapped registers or area.
> +
> +  Split channels can be used to service PSI-L based peripherals.
> +  The peripherals can be PSI-L native or legacy, non PSI-L native peripherals
> +  with PDMAs. PDMA is tasked to act as a bridge between the PSI-L fabric and the
> +  legacy peripheral.
> +
> +  PDMAs can be configured via BCDMA split channel's peer registers to match with
> +  the configuration of the legacy peripheral.
> +
> +allOf:
> +  - $ref: /schemas/dma/dma-controller.yaml#
> +
> +properties:
> +  "#dma-cells":
> +    const: 3
> +    description: |
> +      cell 1: type of the BCDMA channel to be used to service the peripheral:
> +        0 - split channel
> +        1 - block copy channel using global trigger 1
> +        2 - block copy channel using global trigger 2
> +        3 - block copy channel using local trigger
> +
> +      cell 2: parameter for the channel:
> +        if cell 1 is 0 (split channel):
> +          PSI-L thread ID of the remote (to BCDMA) end.
> +          Valid ranges for thread ID depends on the data movement direction:
> +          for source thread IDs (rx): 0 - 0x7fff
> +          for destination thread IDs (tx): 0x8000 - 0xffff
> +
> +          Please refer to the device documentation for the PSI-L thread map and
> +          also the PSI-L peripheral chapter for the correct thread ID.
> +        if cell 1 is 1 or 2 (block copy channel using global trigger):
> +          Unused, ignored
> +
> +          The trigger must be configured for the channel externally to BCDMA,
> +          channels using global triggers should not be requested directly, but
> +          via DMA event router.
> +        if cell 1 is 3 (block copy channel using local trigger):
> +          bchan number of the locally triggered channel
> +
> +      cell 3: ASEL value for the channel
> +
> +  compatible:
> +    enum:
> +      - ti,am64-dmss-bcdma

Typically, we put 'compatible' first.

> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2

These apply to child nodes, but you don't have any.

> +
> +  reg:
> +    maxItems: 5
> +
> +  reg-names:
> +    items:
> +      - const: gcfg
> +      - const: bchanrt
> +      - const: rchanrt
> +      - const: tchanrt
> +      - const: ringrt
> +
> +  msi-parent: true
> +
> +  ti,asel:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: ASEL value for non slave channels
> +
> +  ti,sci-rm-range-bchan:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      Array of BCDMA block-copy channel resource subtypes for resource
> +      allocation for this host
> +    minItems: 1
> +    # Should be enough
> +    maxItems: 255
> +    items:
> +      maximum: 0x3f
> +
> +  ti,sci-rm-range-tchan:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      Array of BCDMA split tx channel resource subtypes for resource allocation
> +      for this host
> +    minItems: 1
> +    # Should be enough
> +    maxItems: 255
> +    items:
> +      maximum: 0x3f
> +
> +  ti,sci-rm-range-rchan:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      Array of BCDMA split rx channel resource subtypes for resource allocation
> +      for this host
> +    minItems: 1
> +    # Should be enough
> +    maxItems: 255
> +    items:
> +      maximum: 0x3f
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - "#dma-cells"
> +  - reg
> +  - reg-names
> +  - msi-parent
> +  - ti,sci
> +  - ti,sci-dev-id
> +  - ti,sci-rm-range-bchan
> +  - ti,sci-rm-range-tchan
> +  - ti,sci-rm-range-rchan
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |+
> +    cbass_main {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        main_dmss {
> +            compatible = "simple-mfd";
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            dma-ranges;
> +            ranges;
> +
> +            ti,sci-dev-id = <25>;
> +
> +            main_bcdma: dma-controller@485c0100 {
> +                compatible = "ti,am64-dmss-bcdma";
> +                #address-cells = <2>;
> +                #size-cells = <2>;
> +
> +                reg = <0x0 0x485c0100 0x0 0x100>,
> +                      <0x0 0x4c000000 0x0 0x20000>,
> +                      <0x0 0x4a820000 0x0 0x20000>,
> +                      <0x0 0x4aa40000 0x0 0x20000>,
> +                      <0x0 0x4bc00000 0x0 0x100000>;
> +                reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt";
> +                msi-parent = <&inta_main_dmss>;
> +                #dma-cells = <3>;
> +
> +                ti,sci = <&dmsc>;
> +                ti,sci-dev-id = <26>;
> +
> +                ti,sci-rm-range-bchan = <0x20>; /* BLOCK_COPY_CHAN */
> +                ti,sci-rm-range-rchan = <0x21>; /* SPLIT_TR_RX_CHAN */
> +                ti,sci-rm-range-tchan = <0x22>; /* SPLIT_TR_TX_CHAN */
> +            };
> +        };
> +    };
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
