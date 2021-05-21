Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5209E38BBE4
	for <lists+dmaengine@lfdr.de>; Fri, 21 May 2021 03:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbhEUBsL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 May 2021 21:48:11 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54]:36499 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbhEUBsL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 May 2021 21:48:11 -0400
Received: by mail-oo1-f54.google.com with SMTP id v13-20020a4aa40d0000b02902052145a469so4241075ool.3;
        Thu, 20 May 2021 18:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GtztF3c1qqVGZkzFB+8cupahdlXXA70EgUWrBsQrJAs=;
        b=aG7NKENhXZWshycyUH9zIMj8j1EQ4bJCSTIXEErkER1ocPLmxvZmfzq+BdpXNQHFWp
         hVojDezTQ6GKF8jvpPn2YgGvuF+GGdVzlowpn4wbSNg1UJpU16Rk/oo5bZ48C3WOFL0G
         1FREGgON+14bxuXh+bIy0OPKDV8ao/tTZjMjNBMhLibso70y7ssTx8N2ufabieP3xL7B
         c7/VepQHLhH4QLZS2OXx5oxpb+y7wTf+n9+soMb1HOreTdB3wlpiviEC/jT4sGTMr+tb
         uU6Zr0EwS7NSL0vNtkOYKwwGAdx6mJTki/n9Y4BvGxwDrvtWrFCaUrPPgUjy5Ze7gNrK
         1Qow==
X-Gm-Message-State: AOAM533btEKZOOvrBLVudaHrG4y6D5aBAo+tj5IzU/1wIgkD1TXniBsa
        TkdVWRMrrCYCTHGcn0gCxw==
X-Google-Smtp-Source: ABdhPJx5u6/YeP9dJCCVFdmbsRUVsvdTYDniOYupLyMZeHLq50c5RkUfSjbIJ83S9cQs1zm51tf5SA==
X-Received: by 2002:a4a:a5c2:: with SMTP id k2mr6006122oom.5.1621561608721;
        Thu, 20 May 2021 18:46:48 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e21sm912280oie.32.2021.05.20.18.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 18:46:48 -0700 (PDT)
Received: (nullmailer pid 2473942 invoked by uid 1000);
        Fri, 21 May 2021 01:46:46 -0000
Date:   Thu, 20 May 2021 20:46:46 -0500
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
Subject: Re: [PATCH v3 08/17] dt-bindings: crypto : Add new compatible
 strings for qcom-qce
Message-ID: <20210521014646.GA2472971@robh.at.kernel.org>
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
 <20210519143700.27392-9-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519143700.27392-9-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 19, 2021 at 08:06:51PM +0530, Bhupesh Sharma wrote:
> Newer qcom chips support newer versions of the qce crypto IP, so add
> soc specific compatible strings for qcom-qce instead of using crypto
> IP version specific ones.
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
>  Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> index 4be9ce697123..7722ac9529bf 100644
> --- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> +++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> @@ -15,7 +15,12 @@ description: |
>  
>  properties:
>    compatible:
> -    const: qcom,crypto-v5.1

You can't get rid of the old one.

> +    enum:
> +      - qcom,ipq6018-qce
> +      - qcom,sdm845-qce
> +      - qcom,sm8150-qce
> +      - qcom,sm8250-qce
> +      - qcom,sm8350-qce
>  
>    reg:
>      maxItems: 1
> @@ -71,7 +76,7 @@ examples:
>    - |
>      #include <dt-bindings/clock/qcom,gcc-apq8084.h>
>      crypto-engine@fd45a000 {
> -        compatible = "qcom,crypto-v5.1";
> +        compatible = "qcom,ipq6018-qce";
>          reg = <0xfd45a000 0x6000>;
>          clocks = <&gcc GCC_CE2_AHB_CLK>,
>                   <&gcc GCC_CE2_AXI_CLK>,
> -- 
> 2.31.1
> 
