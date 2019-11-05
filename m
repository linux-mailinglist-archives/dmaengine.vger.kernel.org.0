Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25A2BEF352
	for <lists+dmaengine@lfdr.de>; Tue,  5 Nov 2019 03:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfKECTC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 Nov 2019 21:19:02 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43825 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbfKECTC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 Nov 2019 21:19:02 -0500
Received: by mail-ot1-f67.google.com with SMTP id l14so1972428oti.10;
        Mon, 04 Nov 2019 18:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xpHWafQQ8dI08rbQ+csbAfrsm6DaLdK2l/xsLmtgqEM=;
        b=g3jT3yM13zRmH5Fg/JZf6UEIpNK58JQnvIBiBVvVnRAOQGRMrgcXIGv1klZUtkmpXS
         k0po+7TUi1RCuCs3EyMl6nS8wg7PSCN2X1t7ISEliOmvliQ/3xN1rjH0ly1oZ8uGLtcU
         hVC7Tvk/kqHE/dDoZL6Ffid0xAzc0TzO7hITALypwAi85wAS7FVNBnXeE8Rt+6QOadjN
         nU+vMKSHcXeHoVfngj+gaExwUfSCXQBUNSDkV1oU/qcGGS6f171IMZJ9booobyxgaj+X
         rJnRcQ0+XQUmPt56PV4lfDR0rqsNW2Y6kJgYHO1U5o4kv7z/lkYFdJNp1PaPmiF5oMEf
         el5Q==
X-Gm-Message-State: APjAAAWbtyebFjV4pJgv2kDOOajCcJouFpgIoXfonuS5YIoSpCecB79o
        Abc2wu3+SRkjexmrsrFuMQ==
X-Google-Smtp-Source: APXvYqxjgIhKwvw6TzbgkV0UAa/2Lgn4y90+jE+Z2W2nEZpwbNtzA+asUedyRyOxujtz/ybQyi8Pew==
X-Received: by 2002:a9d:2dc1:: with SMTP id g59mr20082320otb.59.1572920341419;
        Mon, 04 Nov 2019 18:19:01 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x65sm5698877ota.16.2019.11.04.18.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 18:19:00 -0800 (PST)
Date:   Mon, 4 Nov 2019 20:19:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com
Subject: Re: [PATCH v4 08/15] dt-bindings: dma: ti: Add document for K3 UDMA
Message-ID: <20191105021900.GA17829@bogus>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-9-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191101084135.14811-9-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Nov 01, 2019 at 10:41:28AM +0200, Peter Ujfalusi wrote:
> New binding document for
> Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P).
> 
> UDMA-P is introduced as part of the K3 architecture and can be found in
> AM654 and j721e.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Rob,
> 
> can you give me some hint on how to fix these two warnings from dt_binding_check:
> 
>   DTC     Documentation/devicetree/bindings/dma/ti/k3-udma.example.dt.yaml
> Documentation/devicetree/bindings/dma/ti/k3-udma.example.dts:23.13-72: Warning (ranges_format): /example-0/interconnect@30800000:ranges: "ranges" property has invalid length (24 bytes) (parent #address-cells == 1, child #address-cells == 2, #size-cells == 2)
>   CHECK   Documentation/devicetree/bindings/dma/ti/k3-udma.example.dt.yaml

The default #address-cells is 1 for examples. So you need to 
either override it or change ranges parent address size.
> 
> Documentation/devicetree/bindings/dma/ti/k3-udma.example.dt.yaml: interconnect@30800000: $nodename:0: 'interconnect@30800000' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

Use 'bus' for the node name of 'simple-bus'.

> 
> Thanks,
> Peter
> 
>  .../devicetree/bindings/dma/ti/k3-udma.yaml   | 190 ++++++++++++++++++
>  1 file changed, 190 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
> new file mode 100644
> index 000000000000..e00fe3b2364e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
> @@ -0,0 +1,190 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings:

# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/ti/k3-udma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments K3 NAVSS Unified DMA Device Tree Bindings
> +
> +maintainers:
> +  - Peter Ujfalusi <peter.ujfalusi@ti.com>
> +
> +description: |
> +  The UDMA-P is intended to perform similar (but significantly upgraded)
> +  functions as the packet-oriented DMA used on previous SoC devices. The UDMA-P
> +  module supports the transmission and reception of various packet types.
> +  The UDMA-P is architected to facilitate the segmentation and reassembly of
> +  SoC DMA data structure compliant packets to/from smaller data blocks that are
> +  natively compatible with the specific requirements of each connected
> +  peripheral.
> +  Multiple Tx and Rx channels are provided within the DMA which allow multiple
> +  segmentation or reassembly operations to be ongoing. The DMA controller
> +  maintains state information for each of the channels which allows packet
> +  segmentation and reassembly operations to be time division multiplexed between
> +  channels in order to share the underlying DMA hardware. An external DMA
> +  scheduler is used to control the ordering and rate at which this multiplexing
> +  occurs for Transmit operations. The ordering and rate of Receive operations
> +  is indirectly controlled by the order in which blocks are pushed into the DMA
> +  on the Rx PSI-L interface.
> +
> +  The UDMA-P also supports acting as both a UTC and UDMA-C for its internal
> +  channels. Channels in the UDMA-P can be configured to be either Packet-Based
> +  or Third-Party channels on a channel by channel basis.
> +
> +  All transfers within NAVSS is done between PSI-L source and destination
> +  threads.
> +  The peripherals serviced by UDMA can be PSI-L native (sa2ul, cpsw, etc) or
> +  legacy, non PSI-L native peripherals. In the later case a special, small PDMA
> +  is tasked to act as a bridge between the PSI-L fabric and the legacy
> +  peripheral.
> +
> +  PDMAs can be configured via UDMAP peer registers to match with the
> +  configuration of the legacy peripheral.
> +
> +allOf:
> +  - $ref: "../dma-controller.yaml#"
> +
> +properties:
> +  "#dma-cells":
> +    const: 1
> +    description: |
> +      The cell is the PSI-L  thread ID of the remote (to UDMAP) end.
> +      Valid ranges for thread ID depends on the data movement direction:
> +      for source thread IDs (rx): 0 - 0x7fff
> +      for destination thread IDs (tx): 0x8000 - 0xffff
> +
> +      PLease refer to the device documentation for the PSI-L thread map and also
> +      the PSI-L peripheral chapter for the correct thread ID.
> +
> +  compatible:
> +    oneOf:
> +      - const: ti,am654-navss-main-udmap
> +      - const: ti,am654-navss-mcu-udmap
> +      - const: ti,j721e-navss-main-udmap
> +      - const: ti,j721e-navss-mcu-udmap

enum works better than oneOf+const. Better error messages.

> +
> +  reg:
> +    maxItems: 3
> +
> +  reg-names:
> +   items:
> +     - const: gcfg
> +     - const: rchanrt
> +     - const: tchanrt
> +
> +  msi-parent: true
> +
> +  ti,sci:
> +    description: |

Doesn't need to be a literal block (can drop the '|').

> +      phandle to TI-SCI compatible System controller node
> +    maxItems: 1

Drop this, not an array.

> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  ti,sci-dev-id:
> +    description: |
> +      TI-SCI device id of UDMAP
> +    maxItems: 1

Drop this.

> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  ti,ringacc:
> +    description: |
> +      phandle to the ring accelerator node
> +    maxItems: 1

Drop this.

> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  ti,sci-rm-range-tchan:
> +    description: |
> +      Array of UDMA tchan resource subtypes for resource allocation for this
> +      host
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +    items:
> +      minItems: 1
> +      # Should be enough
> +      maxItems: 255

These should not be under 'items'. Drop 'items'.

Any constraints on the values of the array elements? 

> +
> +  ti,sci-rm-range-rchan:
> +    description: |
> +      Array of UDMA rchan resource subtypes for resource allocation for this
> +      host
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +    items:
> +      minItems: 1
> +      # Should be enough
> +      maxItems: 255

Same here.

> +
> +  ti,sci-rm-range-rflow:
> +    description: |
> +      Array of UDMA rflow resource subtypes for resource allocation for this
> +      host
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +    items:
> +      minItems: 1
> +      # Should be enough
> +      maxItems: 255

And here.

> +
> +required:
> +  - compatible
> +  - "#dma-cells"
> +  - reg
> +  - reg-names
> +  - msi-parent
> +  - ti,sci
> +  - ti,sci-dev-id
> +  - ti,ringacc
> +  - ti,sci-rm-range-tchan
> +  - ti,sci-rm-range-rchan
> +  - ti,sci-rm-range-rflow
> +
> +examples:
> +  - |+
> +    cbass_main_navss: interconnect@30800000 {
> +        compatible = "simple-bus";
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        dma-coherent;
> +        dma-ranges;
> +        ranges = <0x00 0x30800000 0x00 0x30800000 0x00 0x0bc00000>;
> +
> +        ti,sci-dev-id = <118>;
> +
> +        main_udmap: dma-controller@31150000 {
> +            compatible = "ti,am654-navss-main-udmap";
> +            reg = <0x0 0x31150000 0x0 0x100>,
> +                  <0x0 0x34000000 0x0 0x100000>,
> +                  <0x0 0x35000000 0x0 0x100000>;
> +            reg-names = "gcfg", "rchanrt", "tchanrt";
> +            #dma-cells = <1>;
> +            
> +            ti,ringacc = <&ringacc>;
> +            
> +            msi-parent = <&inta_main_udmass>;
> +            
> +            ti,sci = <&dmsc>;
> +            ti,sci-dev-id = <188>;
> +            
> +            ti,sci-rm-range-tchan = <0x1>, /* TX_HCHAN */
> +                                    <0x2>; /* TX_CHAN */
> +            ti,sci-rm-range-rchan = <0x4>, /* RX_HCHAN */
> +                                    <0x5>; /* RX_CHAN */
> +            ti,sci-rm-range-rflow = <0x6>; /* GP RFLOW */
> +        };
> +    };
> +
> +    mcasp0: mcasp@02B00000 {
> +        dmas = <&main_udmap 0xc400>, <&main_udmap 0x4400>;
> +        dma-names = "tx", "rx";
> +    };
> +
> +    crypto: crypto@4E00000 {
> +        compatible = "ti,sa2ul-crypto";
> +
> +        dmas = <&main_udmap 0xc000>, <&main_udmap 0x4000>, <&main_udmap 0x4001>;
> +        dma-names = "tx", "rx1", "rx2";
> +    };
> +
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
