Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063DE38C18A
	for <lists+dmaengine@lfdr.de>; Fri, 21 May 2021 10:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhEUIUN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 04:20:13 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:19236 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhEUIUG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 May 2021 04:20:06 -0400
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 May 2021 04:20:04 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1621584692; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=px0a8MPK74qUXfzV5oznTizuZ6wSYWw1PnTyWPCWdSDm/VNlPpcX9mJnG6EcNy9+al
    IrLqSd+SHTUy+MUh4/hS/NujOZyXCwe5HSxvwd14I4cIgw7AXjiqrNMEjfoNtHxIys+M
    a14YcQqlLi/YEf8/g4X4ZGU/AalgcmEhdVB1NzRcUZHOqu2GPZZa5cXxBMD4g12p5vTr
    1ZuiaGzrocf8qKnkp/grY2j8Mk/T8asPYHcGr9U72ssFsDrf0PwyrMIcLvz2THFrDc1E
    Q0RN+6nMx63661R9AByJ0js93R8df2y6lfNya9k+aTx+RhVCKBFHq6sggs8ml9fW/Mm+
    GM3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621584692;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=P7QD5eRHBuT1lh8i7wzUly3dzKODxjJ0OhwZcPAUEZs=;
    b=qOvPJEGTxcu4ftC0OhXI8oXRU/fO3ZYD1+OJWQuXaRw0/0pVx5jb5rJU6Tdvzny/1t
    q9kdVB/kSfoQheuv6mQ2ldYRUjTTQWfloUKYv3uVD0uaGqjs/fn7oRNK+GbfNjfg7Xvc
    oUwGQB8uW6oqv/0EjOr4ISA5eEP8c1nv/XkFEjtEDjcj6fHN0WqmL1pno8Ifjy2Nd4K3
    NdgKAgA3gzct4XSyv4PdgbwS4wJseRljsozSAgx2sM2h8w9XhYASEBzMbh0TPkqJ1at7
    r35/EciNY0gCLtIMeKlIFzHsRjCNrgxe50OG6ghPv/pdNOM+7tuATln42+LmxkY73GCk
    MHaA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621584692;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=P7QD5eRHBuT1lh8i7wzUly3dzKODxjJ0OhwZcPAUEZs=;
    b=DqIzGoyybqPjiuFKLTxGZ6dWr/44ExmlF0FdJwNkGyMj6i0q4h4RS5yv5ONtvUEhMS
    UB0osp8RELueRhSHyAG5nZgDxXvuGtfICJE1uWislHsnMqjyaoixsw9e0L2IB7+Z3uIW
    RQtga13/EQTxsVG5KS78sR+Kfez1hbP5UGPbr7omd2Z31kDFcdrTBCDtWtX2TPhwj/eh
    0XHq1pF8QHpkCFwA9SryKT0kGu9MW/fI/sqNvv1N+EVOA2jnEP92M667faGDxbN8Y4Pz
    PyaZDAzCgW4Hd4v8hXWa0dly72EjDd9Fi45Fze1iyvh4hrfANIvuems9VscDkHxCxDia
    JaFQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j8IcvEBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.26.1 DYNA|AUTH)
    with ESMTPSA id 2037acx4L8BW0Pp
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 21 May 2021 10:11:32 +0200 (CEST)
Date:   Fri, 21 May 2021 10:11:30 +0200
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
Subject: Re: [PATCH v3 03/17] dt-bindings: qcom-bam: Add 'iommus' to required
 properties
Message-ID: <YKdrMoSFAh1bR3xT@gerhold.net>
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
 <20210519143700.27392-4-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519143700.27392-4-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

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
> +
>    qcom,ee:
>      $ref: /schemas/types.yaml#/definitions/uint8
>      description:
> @@ -81,6 +87,7 @@ required:
>    - clocks
>    - clock-names
>    - "#dma-cells"
> +  - iommus

I don't think we can make this required, older SoCs don't use "iommus"
for bam_dma.

arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml: dma-controller@7884000: 'iommus' is a required property
        From schema: Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml

Stephan
