Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3194038BBD2
	for <lists+dmaengine@lfdr.de>; Fri, 21 May 2021 03:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbhEUBpb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 May 2021 21:45:31 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:33700 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbhEUBpa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 May 2021 21:45:30 -0400
Received: by mail-oi1-f179.google.com with SMTP id b25so18320533oic.0;
        Thu, 20 May 2021 18:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uWv/y/6B46LorCNYV0hE5LMinY0ygx1XUs5LDxlnAQk=;
        b=tEXJedJIWeU2OwWg+Ip0vzY8EPiMPczxthcFlnXAEfK+ZZyuteSML0SBL+itPLGunA
         vVJDucPD3xklPu7K4iSi5+zdR+m2rHjYSJdv5fKBMM+XpWml2A/4DGDw4KNdKM8O9ksF
         SylKOVppLkOsx8SOAv9DCJW+41epnO/NopU7uYcbnwY0BGgZZR9yFDkgcqNNYXzzsmaB
         66minbXlpByzhGPdg5A9YXlasKWvgd2Ur/DcR99q4Ds8kv39zQuXtZlOdgTmvFuRPNSV
         XH1IUWPig69uqcZJaZwoKMCR5v/A/q+h2cDZTE6saNWUSctdizLjNfS5hPlcIPhtDXDF
         KRhQ==
X-Gm-Message-State: AOAM531apfan8fqhwXL/Cfj18mFhQzooXQTe759NIXP0WLJxaBIrb6Uv
        JMQgzu2rrEshZ8+zwbaZeQ==
X-Google-Smtp-Source: ABdhPJz4ctRS5Awbs1IUTuXU9ol00Ggpwo/0gRoUsrLFvrbnGmgip2ndmKTlc2B1u6EdlZgyQnvAZA==
X-Received: by 2002:aca:7501:: with SMTP id q1mr277202oic.9.1621561447833;
        Thu, 20 May 2021 18:44:07 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k7sm950086ood.36.2021.05.20.18.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 18:44:06 -0700 (PDT)
Received: (nullmailer pid 2468680 invoked by uid 1000);
        Fri, 21 May 2021 01:44:05 -0000
Date:   Thu, 20 May 2021 20:44:05 -0500
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
Subject: Re: [PATCH v3 03/17] dt-bindings: qcom-bam: Add 'iommus' to required
 properties
Message-ID: <20210521014405.GB2462277@robh.at.kernel.org>
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
 <20210519143700.27392-4-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519143700.27392-4-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 19, 2021 at 08:06:46PM +0530, Bhupesh Sharma wrote:
> Add the missing required property - 'iommus' to the
> device-tree binding documentation for qcom-bam DMA IP.
> 
> This property describes the phandle(s) to apps_smmu node with sid mask.
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
>  .../devicetree/bindings/dma/qcom_bam_dma.yaml         | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> index d2900616006c..2479862a3654 100644
> --- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> @@ -55,6 +55,12 @@ properties:
>    interconnect-names:
>      const: memory
>  
> +  iommus:
> +    minItems: 1
> +    maxItems: 8
> +    description: |
> +      phandle to apps_smmu node with sid mask.

And what are the other 7 entries?

> +
>    qcom,ee:
>      $ref: /schemas/types.yaml#/definitions/uint8
>      description:
> @@ -81,6 +87,7 @@ required:
>    - clocks
>    - clock-names
>    - "#dma-cells"
> +  - iommus
>    - qcom,ee
>  
>  additionalProperties: false
> @@ -96,4 +103,8 @@ examples:
>          clock-names = "bam_clk";
>          #dma-cells = <1>;
>          qcom,ee = /bits/ 8 <0>;
> +        iommus = <&apps_smmu 0x584 0x0011>,
> +                 <&apps_smmu 0x586 0x0011>,
> +                 <&apps_smmu 0x594 0x0011>,
> +                 <&apps_smmu 0x596 0x0011>;
>      };
> -- 
> 2.31.1
> 
