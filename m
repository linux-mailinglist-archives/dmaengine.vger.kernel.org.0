Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0B42A86B3
	for <lists+dmaengine@lfdr.de>; Thu,  5 Nov 2020 20:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgKETFL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Nov 2020 14:05:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41446 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKETFL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Nov 2020 14:05:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id n15so2428635otl.8;
        Thu, 05 Nov 2020 11:05:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/WFroUes3tjerQV/gKFC+1DAOPOUpnvK3ZLq++FNM3w=;
        b=NlAnd1OcilWytOZaOIqFiYBNbxdkxqVudqLyC+y9097NwmodgqxFxp75NtIm8qfRXu
         0AIWZfFi6AtngN5VHF5yMwzk1/bVI6zbGTckW9Uc3il8kWG8Syb0pcXyi+3Gb7bzZhM/
         cZjUuC5y7bafhNZQvq1RdxMlAYr0ahO75sXeKKSYHTvnhZzSbUzI8JV/5tbDHPBqNGpX
         FXSGqPWw2cn9YzzlumR5LIVQ0RhsJCiLSh/LLfNZdV2WqagYXX9Kb1c6O9okd0tlqAdF
         jmHxXjp8RgqyJKoin9T4enxfrd/GBRq/17uHDsoCVr+/4Bzsjl8SLXpY8XcDqpYn64UH
         BX5A==
X-Gm-Message-State: AOAM532AvIDmGKz9Rx1Haf0EpOH+oF1R6Qq+/hjgU9z30/WQ+8D508Fc
        sOMl5ewgOWRPTbzJi48ILVTJC5pHQPIl
X-Google-Smtp-Source: ABdhPJwpy4tfomKY6Z2z/7HBnD+rPj33bvLMcz2xrOVfXt0mLWPR4WNSApume0HdnQM4c/fUmqmgpQ==
X-Received: by 2002:a9d:3b4:: with SMTP id f49mr2851240otf.188.1604603109677;
        Thu, 05 Nov 2020 11:05:09 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r24sm504639otq.77.2020.11.05.11.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 11:05:09 -0800 (PST)
Received: (nullmailer pid 1642440 invoked by uid 1000);
        Thu, 05 Nov 2020 19:05:08 -0000
Date:   Thu, 5 Nov 2020 13:05:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     devicetree@vger.kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, vkoul@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: bus: Convert ACONNECT doc to json-schema
Message-ID: <20201105190508.GB1633758@bogus>
References: <1604571846-14037-1-git-send-email-spujar@nvidia.com>
 <1604571846-14037-5-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604571846-14037-5-git-send-email-spujar@nvidia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Nov 05, 2020 at 03:54:06PM +0530, Sameer Pujar wrote:
> Move ACONNECT documentation to YAML format.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  .../bindings/bus/nvidia,tegra210-aconnect.txt      | 44 -----------
>  .../bindings/bus/nvidia,tegra210-aconnect.yaml     | 86 ++++++++++++++++++++++
>  2 files changed, 86 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.txt
>  create mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.txt b/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.txt
> deleted file mode 100644
> index 3108d03..0000000
> --- a/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.txt
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -NVIDIA Tegra ACONNECT Bus
> -
> -The Tegra ACONNECT bus is an AXI switch which is used to connnect various
> -components inside the Audio Processing Engine (APE). All CPU accesses to
> -the APE subsystem go through the ACONNECT via an APB to AXI wrapper.
> -
> -Required properties:
> -- compatible: Must be "nvidia,tegra210-aconnect".
> -- clocks: Must contain the entries for the APE clock (TEGRA210_CLK_APE),
> -  and APE interface clock (TEGRA210_CLK_APB2APE).
> -- clock-names: Must contain the names "ape" and "apb2ape" for the corresponding
> -  'clocks' entries.
> -- power-domains: Must contain a phandle that points to the audio powergate
> -  (namely 'aud') for Tegra210.
> -- #address-cells: The number of cells used to represent physical base addresses
> -  in the aconnect address space. Should be 1.
> -- #size-cells: The number of cells used to represent the size of an address
> -  range in the aconnect address space. Should be 1.
> -- ranges: Mapping of the aconnect address space to the CPU address space.
> -
> -All devices accessed via the ACONNNECT are described by child-nodes.
> -
> -Example:
> -
> -	aconnect@702c0000 {
> -		compatible = "nvidia,tegra210-aconnect";
> -		clocks = <&tegra_car TEGRA210_CLK_APE>,
> -			 <&tegra_car TEGRA210_CLK_APB2APE>;
> -		clock-names = "ape", "apb2ape";
> -		power-domains = <&pd_audio>;
> -
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges = <0x702c0000 0x0 0x702c0000 0x00040000>;
> -
> -
> -		child1 {
> -			...
> -		};
> -
> -		child2 {
> -			...
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml b/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml
> new file mode 100644
> index 0000000..f0161bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/nvidia,tegra210-aconnect.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra ACONNECT Bus
> +
> +description: |
> +  The Tegra ACONNECT bus is an AXI switch which is used to connnect various
> +  components inside the Audio Processing Engine (APE). All CPU accesses to
> +  the APE subsystem go through the ACONNECT via an APB to AXI wrapper. All
> +  devices accessed via the ACONNNECT are described by child-nodes.
> +
> +maintainers:
> +  - Jon Hunter <jonathanh@nvidia.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: nvidia,tegra210-aconnect
> +      - items:
> +          - enum:
> +              - nvidia,tegra186-aconnect
> +              - nvidia,tegra194-aconnect
> +          - const: nvidia,tegra210-aconnect
> +
> +  clocks:
> +    items:
> +      - description: Must contain the entry for APE clock
> +      - description: Must contain the entry for APE interface clock
> +
> +  clock-names:
> +    items:
> +      - const: ape
> +      - const: apb2ape
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^dma-controller(@[0-9a-f]+)?$":
> +    $ref: /schemas/dma/nvidia,tegra210-adma.yaml#
> +  "^interrupt-controller(@[0-9a-f]+)?$":
> +    $ref: /schemas/interrupt-controller/arm,gic.yaml#
> +  "^ahub(@[0-9a-f]+)?$":
> +    $ref: /schemas/sound/nvidia,tegra210-ahub.yaml#

These all get applied already since they match on compatible strings. So 
having them here means the schema is applied twice. There's maybe some 
value to this if it's always going to be these 3 nodes.

Also, the unit-addresses shouldn't be optional.

I'd just do:

"@[0-9a-f]+$":
  type: object

> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include<dt-bindings/clock/tegra210-car.h>
> +
> +    aconnect@702c0000 {
> +        compatible = "nvidia,tegra210-aconnect";
> +        clocks = <&tegra_car TEGRA210_CLK_APE>,
> +                 <&tegra_car TEGRA210_CLK_APB2APE>;
> +        clock-names = "ape", "apb2ape";
> +        power-domains = <&pd_audio>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0x702c0000 0x702c0000 0x00040000>;
> +
> +        // Child device nodes follow ...
> +    };
> +
> +...
> -- 
> 2.7.4
> 
