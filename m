Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA799601B0A
	for <lists+dmaengine@lfdr.de>; Mon, 17 Oct 2022 23:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiJQVLC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 17:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJQVKf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 17:10:35 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502BB39137;
        Mon, 17 Oct 2022 14:10:34 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id a17so6519257ilq.1;
        Mon, 17 Oct 2022 14:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqI6v39E0/nnkeIJkHdGLoh5pC6PUwMc1oV4kUG5Ni8=;
        b=DAm/ZR/PcZwd0oz9By3LjEPO17Bq0Kqsgud/zqT/FgOsD1lMQRYsB5Z6CyjtbBfBMP
         WSghdLZI4qxheqp+eeLT+gG3ASIqVqdF6V2qvl9dkEfd5CqOTwHVsOMbUIUx3sR2zkeX
         J9+CgFgapWW0I/TvlN7VIzhSrKI8orC+Y4adF1sQ5XMV/bzG4l0/gOE+5TxwbmG8JZu+
         BxCumthjK9QZRhpsuzK6VjWMQ3pp3T0j5opyrdUr+nSCujXDti0K8kkbcbOnMWjLA5k8
         ICl7vXfqA/uSuwrS06oEd/j7s5nBnkeJPacX24Ai61Xphd1zOUZ1GxNPBVfr9dg/MeIN
         EPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqI6v39E0/nnkeIJkHdGLoh5pC6PUwMc1oV4kUG5Ni8=;
        b=6+tIRKvWqFYWpCJrBN2JrEdpDyl28Cj6g/ouOHgghdnKImqk+2EqG8kagimCDd80Zp
         N6oWTmwqX+Nz3VxK94gFadh9Y7XBNR29ehEFANwbBoFYrIXKw3Q4KWcfTR8NFUy7KtFJ
         VyXRC6jYuPzgCuJ26xMt+zbzBvlf04z73baR0oaqf3ebf1QBVHVymWC8ybyAZKDzvIpZ
         OHEt87MJzj77b0yFykxo2SHW53Xqr0B4Wo3GIaZ7Q3TD4Cw8qU5Klmv1kGDZekxoQReN
         os6UYFpNhXwAakxNRDWdcEstap3ak9kUkI9BJs75kB8a8akXeat9Y+hR7cdkH1fja6gX
         aDog==
X-Gm-Message-State: ACrzQf3myR96jZ3Vu8bAtTQ1LyaHYgMuAcM9AEUPiPaTWaGkJodwQ4TY
        OApokqF/p2gdGbsTueqKHDU=
X-Google-Smtp-Source: AMsMyM7Wqf3VhPjozsXxU9PuIZ+rQ91BqYKYnE81tGeFHPehCzNzv2YIZuWgVDZmjoMbU3x8zWhWLw==
X-Received: by 2002:a05:6e02:1a4f:b0:2fa:bd75:55a4 with SMTP id u15-20020a056e021a4f00b002fabd7555a4mr5688217ilv.5.1666041033354;
        Mon, 17 Oct 2022 14:10:33 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::4a89])
        by smtp.gmail.com with UTF8SMTPSA id q11-20020a056e020c2b00b002f9f7d24d78sm281164ilg.76.2022.10.17.14.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 14:10:32 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>,
        Melody Olvera <quic_molvera@quicinc.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/5] dt-bindings: dma: qcom: gpi: use sm6350 fallback
Date:   Mon, 17 Oct 2022 17:10:29 -0400
Message-Id: <20221017211029.3987-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221015140447.55221-2-krzysztof.kozlowski@linaro.org>
References: <20221015140447.55221-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> Several devices like SM6350, SM8150 and SC7280 are actually compatible,
> so use one compatible fallback for all of them.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> index 750b40c32213..0c2894498845 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> @@ -20,12 +20,14 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> -          - qcom,sc7280-gpi-dma
>            - qcom,sdm845-gpi-dma
>            - qcom,sm6350-gpi-dma
> -          - qcom,sm8350-gpi-dma
> -          - qcom,sm8450-gpi-dma
> -

If you don't want this empty line here, you can still ask for it to be removed
in the original patch. It doesn't look like it was applied yet.

> +      - items:
> +          - enum:
> +              - qcom,sc7280-gpi-dma
> +              - qcom,sm8350-gpi-dma
> +              - qcom,sm8450-gpi-dma
> +          - const: qcom,sm6350-gpi-dma
>        - items:
>            - enum:
>                - qcom,sdm670-gpi-dma
> -- 
> 2.34.1
> 
