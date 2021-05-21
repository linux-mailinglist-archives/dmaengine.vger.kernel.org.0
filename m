Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FA638C19B
	for <lists+dmaengine@lfdr.de>; Fri, 21 May 2021 10:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhEUIV4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 04:21:56 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:24501 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhEUIV4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 May 2021 04:21:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621584509; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WnStYCS0s6bErnovsJDk1gugRQyu9VwuOWhwjPZb2ay5EuIVqpteFehdFfnBTDa3lt
    LRpWeL1NzTZ+J3k3LjW0Yo3Ad6lF9reSSArRA9g7EGJbt+OERjnhsEQY3+6rDzBAIBIq
    Erjc47MEQxKvtFTqUWiiIwbamNaJKW0EPyb7yyAUSyg4SlsPy6aQ8DFsx/vR/J39Txe1
    sxYPuTYNBDXaMRXSaT8ECoS6UjxtRuYdQVXj/JjHo/dE460nqe+0ZHy3cJ0qBeMf3kUD
    yYlsgP8lJNZ6jx0cnl042aLG9QaFnTJn3SVhB/vZLkL55oFGDl1InSb+2rOsCB3omLfC
    8MJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621584509;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MwwA+IfVWfIO/BBfDy71s/uZxMJCnYrLsxZz67Xo1pk=;
    b=rI0QN8RN9CGnqzt7aw5VqajcOJT5g6pkrz5Lt1aJ5T9vO0XEcd4adkQz9cO10odCj4
    GuSfGrHr1kIQ3+IH6TQLi8or67aP/Rb3anWTXtmvhrC9znWAvz4SY7VWhCTbIfHrL4Es
    XRF/Xic7h6KfNaX4Z0zNtJxKVBvKjX7fHz9dAfAfeVZQSZCipS+Wz9epefVGhpL9NWMH
    3nmUVldz51LwELTRruBSQlrKMRAONsnTwSJJ7VbUKAob+E/hdi56xXS9wnH0LS3WZWWw
    6Hf6IXnsdn3aqp3ZkFHLBJx861UMwekI5FbFHo+LrTTzpIs/spEjnxQmUtM7kBHYVPiA
    wbtA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621584509;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MwwA+IfVWfIO/BBfDy71s/uZxMJCnYrLsxZz67Xo1pk=;
    b=Vpv5DAGhIr6m1ehEr/6ramNSVMl3B+sCLfIlj8hPcuOhDZ9SzTPmE5bikFMl8Kt7O5
    f0vLUwC7NHnNJVQCBwzHvNGmoq/rq/sc53MsSthyvl2ihynTgza/bhgHRfJzFw2yadAu
    2H40DN4nMCv65hpA7HyoTATKkwrFm8lYj8VX0Jnp9IrHIdjjl/cxbw0eRzRH58p372nK
    hndVO9DgU1SneOaJH92rR5sWyhGRCGa70AcIenvlaWeCvO0vxTyFDf9XRyjfu/huMYjj
    lJHR6DdhEogPIzDI32iwTetXDpLKEE0WNxqPoNQOvQcKqTaKjXx0Y0dD5GMuvupaaD2S
    xzZQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j8IcvEBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.26.1 DYNA|AUTH)
    with ESMTPSA id 2037acx4L88R0Oi
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 21 May 2021 10:08:27 +0200 (CEST)
Date:   Fri, 21 May 2021 10:08:23 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <YKdqd6nreHwCV3te@gerhold.net>
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
 <20210519143700.27392-2-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519143700.27392-2-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

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
> +
> +  reg:
> +    maxItems: 1
> +    description: Address range of the DMA registers.
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 8
> +
> +  clock-names:
> +    const: bam_clk
> +
> +  interrupts:
> +    maxItems: 1
> +    description: Single interrupt line shared by all channels.
> +
> +  num-channels:
> +    maxItems: 31

maxItems doesn't seem right here, since num-channels isn't an array.
Perhaps you meant maximum: 31?

Can you check your bindings on the existing device trees with
"make dtbs_check" and make sure that only reasonable errors remain?

This fails on pretty much every device tree:

arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: dma-controller@9184000: num-channels: [[31]] is too short
        From schema: Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml

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

bam_dma.c reads this as uint32 and all existing device tree specify it
as uint32. I don't think adding the /bits/ 8 to all existing device
trees is really worth it.

arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: dma-controller@9184000: qcom,ee: missing size tag in [[1]]
        From schema: Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml


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
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names

clocks is often missing if qcom,controlled-remotely is set, e.g.

		slimbam: dma-controller@9184000 {
			compatible = "qcom,bam-v1.7.0";
			qcom,controlled-remotely;
			reg = <0x09184000 0x32000>;
			num-channels  = <31>;
			interrupts = <0 164 IRQ_TYPE_LEVEL_HIGH>;
			#dma-cells = <1>;
			qcom,ee = <1>;
			qcom,num-ees = <2>;
		};

arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: dma-controller@9184000: 'clocks' is a required property
        From schema: Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml: dma-controller@9184000: 'clock-names' is a required property
        From schema: Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml

You might be able to encode this with an if: statement (clocks required
if qcom,controlled-remotely not specified), not sure.

Stephan
