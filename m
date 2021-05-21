Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD3638BBDD
	for <lists+dmaengine@lfdr.de>; Fri, 21 May 2021 03:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbhEUBrM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 May 2021 21:47:12 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:46697 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbhEUBrM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 May 2021 21:47:12 -0400
Received: by mail-oi1-f177.google.com with SMTP id x15so18214876oic.13;
        Thu, 20 May 2021 18:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=alZNH/z7vA0owx0cU+FQ3WOyGtXWxhw0OtCMtwTbEGc=;
        b=UFmWSpdN7pf5C+YXxNfFVLdpnDpDWQLKjud/SaDN+WJE2nekpL1CHd+CkQa3evG4+Y
         I2JhXwCXKL3LN5ecljER5dhfB/9VGiyGHk6LSbRRJpklWEXWclN8HWNu1WfOs1cKAKxk
         B4HaLeN/8dbjL0WGOPj0OW0zrVBixz+gB2JofS02H7p80QUInX1Gdhwyro1OgSn5S9kj
         +6iM8ebhj6CJkokX7GwYMdkuDdT3Wz8fPPo04Wx4aMfX3QNlJZspcjoCBP6qmdVP2LS5
         s4zXyZDq3KGHbzfOXcShr0l8kbZkirXl1SHkufCWHVcPy/h/HTJYyEyjZRK5xv55WhMF
         5qrA==
X-Gm-Message-State: AOAM530pEdkXUmB8CP/TPgxoa7dYi5+iDCR9r5gAPg0VTcZLQK+QaPD2
        hzQFjhJ/jhNWOXG21YjbTw==
X-Google-Smtp-Source: ABdhPJy/CHPCz6jlx/4x1zJEDwwe2EHm3EPMeSN2bimBQMpy+qzNOu7JHKeB/4vKowmcHi914qQFqw==
X-Received: by 2002:aca:bac5:: with SMTP id k188mr295601oif.99.1621561549593;
        Thu, 20 May 2021 18:45:49 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y14sm969378otq.4.2021.05.20.18.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 18:45:48 -0700 (PDT)
Received: (nullmailer pid 2471986 invoked by uid 1000);
        Fri, 21 May 2021 01:45:47 -0000
Date:   Thu, 20 May 2021 20:45:47 -0500
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
Subject: Re: [PATCH v3 04/17] dt-bindings: qcom-qce: Convert bindings to yaml
Message-ID: <20210521014547.GA2469643@robh.at.kernel.org>
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
 <20210519143700.27392-5-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519143700.27392-5-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 19, 2021 at 08:06:47PM +0530, Bhupesh Sharma wrote:
> Convert Qualcomm QCE crypto devicetree binding to YAML.
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
>  .../devicetree/bindings/crypto/qcom-qce.txt   | 25 -------
>  .../devicetree/bindings/crypto/qcom-qce.yaml  | 69 +++++++++++++++++++
>  2 files changed, 69 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/crypto/qcom-qce.txt
>  create mode 100644 Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> 
> diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.txt b/Documentation/devicetree/bindings/crypto/qcom-qce.txt
> deleted file mode 100644
> index fdd53b184ba8..000000000000
> --- a/Documentation/devicetree/bindings/crypto/qcom-qce.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -Qualcomm crypto engine driver
> -
> -Required properties:
> -
> -- compatible  : should be "qcom,crypto-v5.1"
> -- reg         : specifies base physical address and size of the registers map
> -- clocks      : phandle to clock-controller plus clock-specifier pair
> -- clock-names : "iface" clocks register interface
> -                "bus" clocks data transfer interface
> -                "core" clocks rest of the crypto block
> -- dmas        : DMA specifiers for tx and rx dma channels. For more see
> -                Documentation/devicetree/bindings/dma/dma.txt
> -- dma-names   : DMA request names should be "rx" and "tx"
> -
> -Example:
> -	crypto@fd45a000 {
> -		compatible = "qcom,crypto-v5.1";
> -		reg = <0xfd45a000 0x6000>;
> -		clocks = <&gcc GCC_CE2_AHB_CLK>,
> -			 <&gcc GCC_CE2_AXI_CLK>,
> -			 <&gcc GCC_CE2_CLK>;
> -		clock-names = "iface", "bus", "core";
> -		dmas = <&cryptobam 2>, <&cryptobam 3>;
> -		dma-names = "rx", "tx";
> -	};
> diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> new file mode 100644
> index 000000000000..a691cd08f372
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/qcom-qce.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm crypto engine driver
> +
> +maintainers:
> +  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
> +
> +description: |
> +  This document defines the binding for the QCE crypto
> +  controller found on Qualcomm parts.
> +
> +properties:
> +  compatible:
> +    const: qcom,crypto-v5.1
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +      Specifies base physical address and size of the registers map.

Yep, that's every 'reg'. Drop.

With that dropped,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +  clocks:
> +    items:
> +      - description: iface clocks register interface.
> +      - description: bus clocks data transfer interface.
> +      - description: core clocks rest of the crypto block.
> +
> +  clock-names:
> +    items:
> +      - const: iface
> +      - const: bus
> +      - const: core
> +
> +  dmas:
> +    items:
> +      - description: DMA specifiers for tx dma channel.
> +      - description: DMA specifiers for rx dma channel.
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - dmas
> +  - dma-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-apq8084.h>
> +    crypto-engine@fd45a000 {
> +        compatible = "qcom,crypto-v5.1";
> +        reg = <0xfd45a000 0x6000>;
> +        clocks = <&gcc GCC_CE2_AHB_CLK>,
> +                 <&gcc GCC_CE2_AXI_CLK>,
> +                 <&gcc GCC_CE2_CLK>;
> +        clock-names = "iface", "bus", "core";
> +        dmas = <&cryptobam 2>, <&cryptobam 3>;
> +        dma-names = "rx", "tx";
> +    };
> -- 
> 2.31.1
> 
