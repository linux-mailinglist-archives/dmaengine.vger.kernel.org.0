Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1542E38BBCD
	for <lists+dmaengine@lfdr.de>; Fri, 21 May 2021 03:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbhEUBop (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 May 2021 21:44:45 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:44824 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbhEUBoo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 May 2021 21:44:44 -0400
Received: by mail-ot1-f44.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so16636342otp.11;
        Thu, 20 May 2021 18:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9S9XS3Yg9GWaFqOj2PYCXeBhYEX4PcdUFzpuE9sqB4g=;
        b=GjOKCVe3XUpMHF7f59Q8JC2KCyNmACD3u614tR1/qgY7b9rAVRl1fEO/HzAyepKJiN
         YXvZ4MnLiu4WS3DyZ2KGaKbGC+s4wFLxgMV9XXt5Zf8t2gfXfZpyD3W1uAJNq1kZGj29
         7XPGIof4v0xDYcULx051rIG8vQVzIotrTvYiI1QtZYWAr5jKXwQE/60nNj0jI9o8d/Tu
         imVNd6oJ4lsuGzYQXunGfSs97vZzsLAZYoOZSsmMPxlscQgY16bn+T186t9xju1gf7Jf
         rDGO1gxCOdSLNgGGHW9a4l95oDpB57jQYYyE9p4uofTRUhMUERMWXVCTMN7X+OFlaBzU
         Y3GA==
X-Gm-Message-State: AOAM5336UlGxQAp70TnHE6rQZkl0IlDOuiC2J1nXPuVxBqMHl4OdgVTD
        fwpOPJrOeB3Br62VE9wwqQ==
X-Google-Smtp-Source: ABdhPJzEANfqFxE4Om5iMLjsSLwh6xktkUCyClwjVw7r/DNw3lOe3BzOKAJKqe6s95hkV2bCtuDbDQ==
X-Received: by 2002:a05:6830:1bed:: with SMTP id k13mr3959289otb.194.1621561398402;
        Thu, 20 May 2021 18:43:18 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y7sm999499oto.60.2021.05.20.18.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 18:43:17 -0700 (PDT)
Received: (nullmailer pid 2467209 invoked by uid 1000);
        Fri, 21 May 2021 01:43:16 -0000
Date:   Thu, 20 May 2021 20:43:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Subject: Re: [PATCH v3 01/17] dt-bindings: qcom-bam: Convert binding to YAML
Message-ID: <20210521014316.GA2462277@robh.at.kernel.org>
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
 <20210519143700.27392-2-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519143700.27392-2-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 19, 2021 at 08:06:44PM +0530, Bhupesh Sharma wrote:
> Convert Qualcomm BAM DMA devicetree binding to YAML.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: bhupesh.linux@gmail.com
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../devicetree/bindings/dma/qcom_bam_dma.txt  | 50 ----------
>  .../devicetree/bindings/dma/qcom_bam_dma.yaml | 91 +++++++++++++++++++
>  2 files changed, 91 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> deleted file mode 100644
> index cf5b9e44432c..000000000000
> --- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -QCOM BAM DMA controller
> -
> -Required properties:
> -- compatible: must be one of the following:
> - * "qcom,bam-v1.4.0" for MSM8974, APQ8074 and APQ8084
> - * "qcom,bam-v1.3.0" for APQ8064, IPQ8064 and MSM8960
> - * "qcom,bam-v1.7.0" for MSM8916
> -- reg: Address range for DMA registers
> -- interrupts: Should contain the one interrupt shared by all channels
> -- #dma-cells: must be <1>, the cell in the dmas property of the client device
> -  represents the channel number
> -- clocks: required clock
> -- clock-names: must contain "bam_clk" entry
> -- qcom,ee : indicates the active Execution Environment identifier (0-7) used in
> -  the secure world.
> -- qcom,controlled-remotely : optional, indicates that the bam is controlled by
> -  remote proccessor i.e. execution environment.
> -- num-channels : optional, indicates supported number of DMA channels in a
> -  remotely controlled bam.
> -- qcom,num-ees : optional, indicates supported number of Execution Environments
> -  in a remotely controlled bam.
> -
> -Example:
> -
> -	uart-bam: dma@f9984000 = {
> -		compatible = "qcom,bam-v1.4.0";
> -		reg = <0xf9984000 0x15000>;
> -		interrupts = <0 94 0>;
> -		clocks = <&gcc GCC_BAM_DMA_AHB_CLK>;
> -		clock-names = "bam_clk";
> -		#dma-cells = <1>;
> -		qcom,ee = <0>;
> -	};
> -
> -DMA clients must use the format described in the dma.txt file, using a two cell
> -specifier for each channel.
> -
> -Example:
> -	serial@f991e000 {
> -		compatible = "qcom,msm-uart";
> -		reg = <0xf991e000 0x1000>
> -			<0xf9944000 0x19000>;
> -		interrupts = <0 108 0>;
> -		clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
> -			<&gcc GCC_BLSP1_AHB_CLK>;
> -		clock-names = "core", "iface";
> -
> -		dmas = <&uart-bam 0>, <&uart-bam 1>;
> -		dma-names = "rx", "tx";
> -	};
> diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> new file mode 100644
> index 000000000000..173e4d7508a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/qcom_bam_dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QCOM BAM DMA controller binding
> +
> +maintainers:
> +  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
> +
> +description: |
> +  This document defines the binding for the BAM DMA controller
> +  found on Qualcomm parts.
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,bam-v1.4.0
> +      - qcom,bam-v1.3.0
> +      - qcom,bam-v1.7.0

Can we keep the SoC association please.

> +
> +  reg:
> +    maxItems: 1
> +    description: Address range of the DMA registers.

Drop description.

> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 8
> +
> +  clock-names:
> +    const: bam_clk

This is going to fail if you try more than 1 clock.

> +
> +  interrupts:
> +    maxItems: 1
> +    description: Single interrupt line shared by all channels.

Drop description

> +
> +  num-channels:
> +    maxItems: 31
> +    description: |
> +      Indicates supported number of DMA channels in a remotely controlled bam.
> +
> +  "#dma-cells":
> +    const: 1
> +    description: The single cell represents the channel index.
> +
> +  qcom,ee:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description:
> +      Indicates the active Execution Environment identifier (0-7)
> +      used in the secure world.
> +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
> +
> +  qcom,controlled-remotely:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Indicates that the bam is controlled by remote proccessor i.e.
> +      execution environment.
> +
> +  qcom,num-ees:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Indicates supported number of Execution Environments in a
> +      remotely controlled bam.

0-2^32 is valid?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - "#dma-cells"
> +  - qcom,ee
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-msm8974.h>
> +    dma-controller@f9984000 {
> +        compatible = "qcom,bam-v1.4.0";
> +        reg = <0xf9984000 0x15000>;
> +        interrupts = <0 94 0>;
> +        clocks = <&gcc GCC_BAM_DMA_AHB_CLK>;
> +        clock-names = "bam_clk";
> +        #dma-cells = <1>;
> +        qcom,ee = /bits/ 8 <0>;
> +    };
> -- 
> 2.31.1
> 
