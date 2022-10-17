Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BC8600C8C
	for <lists+dmaengine@lfdr.de>; Mon, 17 Oct 2022 12:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiJQKh0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 06:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiJQKhX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 06:37:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE935A153;
        Mon, 17 Oct 2022 03:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A5646103E;
        Mon, 17 Oct 2022 10:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013F0C433D6;
        Mon, 17 Oct 2022 10:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666003038;
        bh=FBKf1CEFw8tgRd9w+dSok9gUwWvLjYtA3njAcXxZBVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ml9KqCi8fveMR9333IA+KjaXZMJrZ9dkMz0cpbeqCMp2tVSU+3ciBrONCI0thkTMh
         0+ys9sSBWhZgSJULrYdNPa+pXkgIu9vG/D1LUS6TvYi6ehnt58P0vyN/sD4WCImR/x
         C1m0YX6C8Vs6mGZF+pXSZuqbpUd0NoO+cO7GAX+HzqspbKYXonixIMFKEdqDiygRb4
         5ipLfK0aadDJKqqnuhV37te8KAUAEZCSy3JYa+SOhnFtvU5c58cmfV60kxVdisI/lr
         h0bLc6VKouGUkPmX9JTmuAf1U+PXYWGiT3D7hTzVRhE/F/GMMXX7zh0vDEefeFbN3K
         K1y7JHlofuU7w==
Date:   Mon, 17 Oct 2022 16:07:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: Re: [PATCH 1/5] dt-bindings: dma: qcom: gpi: use sm6350 fallback
Message-ID: <Y00wWnkcLKaticjl@matsya>
References: <20221015140447.55221-1-krzysztof.kozlowski@linaro.org>
 <20221015140447.55221-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221015140447.55221-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-10-22, 10:04, Krzysztof Kozlowski wrote:
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
> +      - items:
> +          - enum:
> +              - qcom,sc7280-gpi-dma
> +              - qcom,sm8350-gpi-dma
> +              - qcom,sm8450-gpi-dma
> +          - const: qcom,sm6350-gpi-dma

I think it makes sense but can we document this in binding as well that
why people should use these two compatibles. I am fine with this being
comments here..

>        - items:
>            - enum:
>                - qcom,sdm670-gpi-dma
> -- 
> 2.34.1

-- 
~Vinod
