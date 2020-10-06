Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE1E285266
	for <lists+dmaengine@lfdr.de>; Tue,  6 Oct 2020 21:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgJFT3O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Oct 2020 15:29:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33981 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgJFT3N (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Oct 2020 15:29:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id d28so7116350ote.1;
        Tue, 06 Oct 2020 12:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1XFxPruWwKJTlwaZYxVkA0YAtY/aY5Lm02Tmq9V8o9g=;
        b=SIhKj1NZrPw2t9gPuVbZPPeLyDip1H71BNroRV07NQb6arwViAibrIHnKye40xnbx9
         u7ljKDARX3/uSVZcUMl/JxB+5t0pwGBmDlZxXRzFISVm4tq5MHtTQTwHxxmhRioToP8A
         ocMvkP01AiASz5t0ywBRzxF9PPFUy9OwbdJdG+qzyzLT2mTbGVtFWdENqV5MO8cnNj6I
         LXHOobNEBXiSYbV4VDOQR2D2XTkzAbW9CHVIkNgHjE1cl081yl88tnnS/2n5FvL8MYQN
         HZtmfFAiov2yiDTKm9AYdmziEd6Ic3QpK6KkfPWuoqIBJb/q9m3HhKY0Ce+l7zgTpka1
         OPbQ==
X-Gm-Message-State: AOAM530HbvzYHnDFmqg/SxpV58qJ2BqYuyk96yvXt2nTReV1NCWh3X7/
        AwDnpYuUa5KvVCypoMDGAQ==
X-Google-Smtp-Source: ABdhPJzN70sKNq6AWYw5I/4l2/htND8DBMBQd6RK7AYtdHUnC8ift9ywySUFzD8ao+7o/oEAElsc2w==
X-Received: by 2002:a9d:5a0b:: with SMTP id v11mr3874682oth.347.1602012550950;
        Tue, 06 Oct 2020 12:29:10 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u125sm1625491oif.21.2020.10.06.12.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 12:29:10 -0700 (PDT)
Received: (nullmailer pid 2687025 invoked by uid 1000);
        Tue, 06 Oct 2020 19:29:09 -0000
Date:   Tue, 6 Oct 2020 14:29:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, nm@ti.com, ssantosh@kernel.org, vigneshr@ti.com,
        dan.j.williams@intel.com, t-kristo@ti.com, lokeshvutla@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 09/18] dt-bindings: dma: ti: Add document for K3 BCDMA
Message-ID: <20201006192909.GA2679155@bogus>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
 <20200930091412.8020-10-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930091412.8020-10-peter.ujfalusi@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Sep 30, 2020 at 12:14:03PM +0300, Peter Ujfalusi wrote:
> New binding document for
> Texas Instruments K3 Block Copy DMA (BCDMA).
> 
> BCDMA is introduced as part of AM64.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 183 ++++++++++++++++++
>  1 file changed, 183 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> new file mode 100644
> index 000000000000..c84fb641738f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> @@ -0,0 +1,183 @@
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
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +  reg:
> +    maxItems: 5
> +
> +  reg-names:
> +   items:
> +     - const: gcfg
> +     - const: bchanrt
> +     - const: rchanrt
> +     - const: tchanrt
> +     - const: ringrt
> +
> +  msi-parent: true
> +

> +  ti,sci:
> +    description: phandle to TI-SCI compatible System controller node
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  ti,sci-dev-id:
> +    description: TI-SCI device id of BCDMA
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32

We have a common definition for these.

> +
> +  ti,asel:
> +    description: ASEL value for non slave channels
> +    allOf:

You no longer need 'allOf' here.

> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  ti,sci-rm-range-bchan:
> +    description: |
> +      Array of BCDMA block-copy channel resource subtypes for resource
> +      allocation for this host
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    # Should be enough
> +    maxItems: 255

Are there constraints for the individual elements?

> +
> +  ti,sci-rm-range-tchan:
> +    description: |
> +      Array of BCDMA split tx channel resource subtypes for resource allocation
> +      for this host
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    # Should be enough
> +    maxItems: 255
> +
> +  ti,sci-rm-range-rchan:
> +    description: |
> +      Array of BCDMA split rx channel resource subtypes for resource allocation
> +      for this host
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    # Should be enough
> +    maxItems: 255
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
> +additionalProperties: false
> +
> +examples:
> +  - |+
> +    cbass_main {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        main_dmss {
> +            compatible = "simple-mfd";

IMO, if it is memory-mapped, then you should be using 'simple-bus'.

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
