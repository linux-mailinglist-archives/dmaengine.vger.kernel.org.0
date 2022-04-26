Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C9A50ED71
	for <lists+dmaengine@lfdr.de>; Tue, 26 Apr 2022 02:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238532AbiDZATR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Apr 2022 20:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbiDZATQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Apr 2022 20:19:16 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D531240E8;
        Mon, 25 Apr 2022 17:16:11 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso11972071otj.5;
        Mon, 25 Apr 2022 17:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qmG4FxwAvEz6wBFjUNLNkTR69mJKypGUFaKOVY8t/50=;
        b=BQNvLLGulyDaBGec6TBCnfYowmHDhFaj0TNwZBKIK8MoJ/9Gmf01TQSHRBPFwvSCPZ
         X8NvRZLeLVVHDBEKxfrZRyYeLJ2pPpQpxHgDbk6tMuUXDPPG6DglNETziO6a+07Xhja2
         Bdwj6P7Bcbo1joNKlVesTfQVW7ih8QtmKcBPRqWmduhxMyJWNvm9Lz65KU96r1PajC7N
         h9tN5BgzK88d4tIetM0Kek6r8Acv76uop22EPftuvtHV5wGNOK6vX+iKzK3Qxm6Uawrg
         cHWoSf5xThtC5ex92OvYxEjD2XTWw3yIQpFLvNQNZHw+zxR4orTR7VeQO4bI0XFdal8F
         Ve+g==
X-Gm-Message-State: AOAM533jjwtVsVHH638nNSAFGpp6TJkhEK7S4GI2ucS2soLbSQIZG2lD
        ajwYAU4UqB+/RI7coHl+5w==
X-Google-Smtp-Source: ABdhPJwZJBlSu2ov0ZfnkPoBaHssVod/BdbYD8pT8ArIst24XfnFgr8LQUVbTgJTFbTQRwyaRorpDQ==
X-Received: by 2002:a05:6830:4128:b0:605:6729:1ff8 with SMTP id w40-20020a056830412800b0060567291ff8mr7306670ott.143.1650932170611;
        Mon, 25 Apr 2022 17:16:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o3-20020a056870a50300b000e686d13891sm264071oal.43.2022.04.25.17.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 17:16:09 -0700 (PDT)
Received: (nullmailer pid 592755 invoked by uid 1000);
        Tue, 26 Apr 2022 00:16:09 -0000
Date:   Mon, 25 Apr 2022 19:16:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 6/6] dt-bindings: dma: Convert Qualcomm BAM DMA
 binding to json format
Message-ID: <Ymc5yUq0/YDcFd1w@robh.at.kernel.org>
References: <20220417210436.6203-1-singh.kuldeep87k@gmail.com>
 <20220417210436.6203-7-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220417210436.6203-7-singh.kuldeep87k@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Apr 18, 2022 at 02:34:36AM +0530, Kuldeep Singh wrote:
> Convert Qualcomm BAM DMA controller binding to DT schema format using
> json schema.
> 
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---
> v3:
> - Address Krzysztof Comments
> - qcom,ee as required property
> - Use boolean type instead of flag
> - Add min/max to qcom,ee
> - skip clocks, as it's users are not fixed
> ---
> v2:
> - Use dma-cells
> - Set additionalProperties to false
> ---
>  .../devicetree/bindings/dma/qcom,bam-dma.yaml | 97 +++++++++++++++++++
>  .../devicetree/bindings/dma/qcom_bam_dma.txt  | 52 ----------
>  2 files changed, 97 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> new file mode 100644
> index 000000000000..02393ec2eedd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/qcom,bam-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies Inc BAM DMA controller
> +
> +maintainers:
> +  - Andy Gross <agross@kernel.org>
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,bam-v1.3.0
> +      - qcom,bam-v1.4.0
> +      - qcom,bam-v1.7.0

We've lost the mapping to SoCs. Please add as comments.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: bam_clk
> +
> +  "#dma-cells":
> +    const: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  iommus:
> +    minItems: 1
> +    maxItems: 4
> +
> +  num-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Indicates supported number of DMA channels in a remotely controlled bam.
> +
> +  qcom,controlled-remotely:
> +    type: boolean
> +    description:
> +      Indicates that the bam is controlled by remote proccessor i.e. execution
> +      environment.
> +
> +  qcom,ee:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 7
> +    description:
> +      Indicates the active Execution Environment identifier (0-7) used in the
> +      secure world.
> +
> +  qcom,num-ees:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Indicates supported number of Execution Environments in a remotely
> +      controlled bam.
> +
> +  qcom,powered-remotely:
> +    type: boolean
> +    description:
> +      Indicates that the bam is powered up by a remote processor but must be
> +      initialized by the local processor.
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - "#dma-cells"
> +  - interrupts
> +  - qcom,ee
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/qcom,gcc-msm8974.h>
> +
> +    dma-controller@f9944000 {
> +        compatible = "qcom,bam-v1.4.0";
> +        reg = <0xf9944000 0x15000>;
> +        interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&gcc GCC_BLSP2_AHB_CLK>;
> +        clock-names = "bam_clk";
> +        #dma-cells = <1>;
> +        qcom,ee = <0>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> deleted file mode 100644
> index 6e9a5497b3f2..000000000000
> --- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> +++ /dev/null
> @@ -1,52 +0,0 @@
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
> -- qcom,powered-remotely : optional, indicates that the bam is powered up by
> -  a remote processor but must be initialized by the local processor.
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
> -- 
> 2.25.1
> 
> 
