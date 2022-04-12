Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD9B4FEAC7
	for <lists+dmaengine@lfdr.de>; Wed, 13 Apr 2022 01:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiDLXSp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 19:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiDLXSg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 19:18:36 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBF913CCE
        for <dmaengine@vger.kernel.org>; Tue, 12 Apr 2022 15:06:19 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id q129so183728oif.4
        for <dmaengine@vger.kernel.org>; Tue, 12 Apr 2022 15:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jD+82WbEufy2X8i5Y0RTwJaeb0VsOpJSpK4/ctGdy1w=;
        b=pTQjcsxviay2afn3gp0HiWqJ107Q+sJEeHW/DRFziwwMZsQcnJtz5ZCBEqEkPgicnJ
         ypGM22GlrwrYGIqGSrQ6cUdDYapdCrcKJhVJWXtruFmxiPkAYV9CVWxcbE3J9G3erUCE
         dMeBMKU576Dh3M1i5QmA0TJuKgVoBSCOjff8m8k9OIQvrrHmQjSqA8Jr3f3xf+u+lU3j
         Ej2bYFxkiiRTozHF4qesVFmnfoYiAKI/ZGM1GrCn8HEjLIzCHxhyCAAvjy7Ldl1v5uI7
         O1zzajBiB4/OBmstfB4m6ZKIE5BkufKE3quCgfYEg7al3Tp8sR1wuRL86nJT0DDphzOK
         pJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jD+82WbEufy2X8i5Y0RTwJaeb0VsOpJSpK4/ctGdy1w=;
        b=FDN0VqbzAfAlfpTbeoWUnNh5j7fzysCjjKhf7cl3Hj/fUiyZt5A00cXq9UZ4/xy0XB
         JYaZuHS2+OwR1q/ROyQ5QNwX1PNP0xOmr2Pp9x/StfXoPMyWgUbk9Ie6yA5wxMe7ftcF
         0BLU0Dj5HwyyHEcCpnMbsuR8Css4E7iqatnn2kbPuHa1wSAmo2NE0Ohpc3uwjQDyhleR
         ksVqyljVNRTPbH3bjzZ8JACGEQ66UgpaEdxaoYduXrh1B8mTKg3+zZFXqeABVxfFmci+
         X8SjvWhLQWHPk4/wTwhQZF5m8J2wvd0QtikNhdQfkHjk6RCsDn6drR7r6zoUYAMJxPJv
         3OOQ==
X-Gm-Message-State: AOAM532JDC4yMHP8dvPag+SoyeFWTKNlGG76swSQceyuqU7N6B3C/i4/
        cLB5MsVQZ1rD8hlQzodEXjpEOQyL4kF6SWCo
X-Google-Smtp-Source: ABdhPJwz0V9sKmC9Pmd2YQ7iBDYhDj7EjLvAhBCgQwdGm8KXnbHnH7n+K0TP4vTkyN+i6c7cGCxQMA==
X-Received: by 2002:a05:6870:d62c:b0:e2:d756:e7c8 with SMTP id a44-20020a056870d62c00b000e2d756e7c8mr2867301oaq.156.1649798924907;
        Tue, 12 Apr 2022 14:28:44 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id u7-20020a05687036c700b000da4bcdae42sm13362331oak.13.2022.04.12.14.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 14:28:43 -0700 (PDT)
Date:   Tue, 12 Apr 2022 14:30:58 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: dmaengine: qcom: gpi: add compatible
 for sm8350/sm8350
Message-ID: <YlXvkv8c56+Pv3c0@ripper>
References: <20220406132508.1029348-1-vkoul@kernel.org>
 <20220406132508.1029348-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406132508.1029348-2-vkoul@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed 06 Apr 06:25 PDT 2022, Vinod Koul wrote:

> Add the compatible for newer qcom socs with gpi dma i.e qcom sm8350 and
> sm8450.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> index e614fe3187bb..67f046a4a442 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> @@ -22,6 +22,8 @@ properties:
>        - qcom,sdm845-gpi-dma
>        - qcom,sm8150-gpi-dma
>        - qcom,sm8250-gpi-dma
> +      - qcom,sm8350-gpi-dma
> +      - qcom,sm8450-gpi-dma
>  
>    reg:
>      maxItems: 1
> -- 
> 2.34.1
> 
