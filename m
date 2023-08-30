Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4245778E0A2
	for <lists+dmaengine@lfdr.de>; Wed, 30 Aug 2023 22:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbjH3U2O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Aug 2023 16:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239369AbjH3U2B (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Aug 2023 16:28:01 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6255699
        for <dmaengine@vger.kernel.org>; Wed, 30 Aug 2023 13:26:18 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf6ea270b2so563855ad.0
        for <dmaengine@vger.kernel.org>; Wed, 30 Aug 2023 13:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693427111; x=1694031911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uXbqOlh8r0k+tg/OMYYC/pnzYsMBRXOUkdntBwOPi+I=;
        b=UfclEdRU5aHcRASygBDXKbb/+X1bsaxYjU5oTKTAYLEmNbwDuGXAYMLcAqmi8Uvv1A
         ynv/UHmRxN4hPYoKyubUzpAWNzWTfyLfA75eVs4BXJEagYQnlGI8RfBoXx+RyGrhi9UU
         wmAaRAfHYTSy2oGoZV5NhnqN4iefU7R4fGcP8CNYnry0ZRaSVH2H7kCyFZbz5VSzIVHs
         aM4MFmoNq2T1hr1EJUloJe48uDFFSMQwEcXR/dGELdUU3yw4zFFqdEou6vXibfcg3W9P
         5opI1r33DQxebVt1I+sQP0dXR5/ZJqxAEBF7FN6w8dXxPbsjqTWyt98NcYI8UBwYXTWp
         3JBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693427111; x=1694031911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXbqOlh8r0k+tg/OMYYC/pnzYsMBRXOUkdntBwOPi+I=;
        b=WJ0Cl+DY5e2zfS2oxi6LA/GqS4SShLPL3K6yJH7Khj23MaocKlRguOcK26rkSx51rn
         nhLPLfGr2u9fM7yjB26walJdjfPAitOSQzEgjISLgNcTX0o7w6I9oFTqAE4o4L1gs4OO
         1JPpwaXR7Mw9HJ2+GzgRwnCOwhs/SXsDl8c/iH97VvEvtuicgAdrXDsd1jUz4qLV/v0E
         YIqg+VnO0UEqPzx212tf8xHN0Vu/ieAy5smKZBOX+lYVQwbBAZibv93aPq1B9t0Q0bzK
         Cm8YO+rtApdzImHk/13UWYbGxLyWTCCqnr4ClPbfjYN87sHP2LdYT6R2QZ5fyl++LIW5
         B+dQ==
X-Gm-Message-State: AOJu0Yx/WOj+1/fzUhXxC57gRlneFBgIfY1O5CTNzHoo20L7L15HCVra
        p6Squk45O2eaOStfPlBDERgje/f62P270Vdy7ET6PVcvK8ZwIi3V
X-Google-Smtp-Source: AGHT+IG1yr729IfyggfMaOGuobww8IAVL5gyF4x4lEuRUAz8feYviF2R4vEKFUgp2ZVYBHxBGUymjHngjSlEj9VOTDM=
X-Received: by 2002:a25:6a88:0:b0:d7b:1f20:293c with SMTP id
 f130-20020a256a88000000b00d7b1f20293cmr3255375ybc.1.1693426431915; Wed, 30
 Aug 2023 13:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230830-topic-8550_dmac2-v1-0-49bb25239fb1@linaro.org> <20230830-topic-8550_dmac2-v1-3-49bb25239fb1@linaro.org>
In-Reply-To: <20230830-topic-8550_dmac2-v1-3-49bb25239fb1@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 30 Aug 2023 23:13:40 +0300
Message-ID: <CAA8EJpp7bxq4=i1CMPYvz99ZuKLz+th6zSFhhRhFMjDwGB5Z8Q@mail.gmail.com>
Subject: Re: [PATCH 3/7] arm64: dts: qcom: sm8550: Fix up CPU idle states
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 30 Aug 2023 at 22:04, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> The idle residency times are largely too low according to the vendor
> kernel (maybe they came from an earlier release or something), especially
> for the prime X2 core. Fix them.
>
> Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index d115960bdeec..c21ba6afa752 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -283,9 +283,9 @@ LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
>                                 compatible = "arm,idle-state";
>                                 idle-state-name = "silver-rail-power-collapse";
>                                 arm,psci-suspend-param = <0x40000004>;
> -                               entry-latency-us = <800>;
> +                               entry-latency-us = <550>;
>                                 exit-latency-us = <750>;
> -                               min-residency-us = <4090>;
> +                               min-residency-us = <6700>;
>                                 local-timer-stop;
>                         };
>
> @@ -294,8 +294,18 @@ BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
>                                 idle-state-name = "gold-rail-power-collapse";
>                                 arm,psci-suspend-param = <0x40000004>;
>                                 entry-latency-us = <600>;
> -                               exit-latency-us = <1550>;
> -                               min-residency-us = <4791>;
> +                               exit-latency-us = <1300>;
> +                               min-residency-us = <8136>;
> +                               local-timer-stop;
> +                       };
> +
> +                       PRIME_CPU_SLEEP_0: cpu-sleep-2-0 {
> +                               compatible = "arm,idle-state";
> +                               idle-state-name = "gold-plus-rail-power-collapse";
> +                               arm,psci-suspend-param = <0x40000004>;
> +                               entry-latency-us = <500>;
> +                               exit-latency-us = <1350>;
> +                               min-residency-us = <7480>;
>                                 local-timer-stop;

This isn't only fixing the time properties, but also adds the whole
new sleep state!

>                         };
>                 };
> @@ -304,17 +314,17 @@ domain-idle-states {
>                         CLUSTER_SLEEP_0: cluster-sleep-0 {
>                                 compatible = "domain-idle-state";
>                                 arm,psci-suspend-param = <0x41000044>;
> -                               entry-latency-us = <1050>;
> -                               exit-latency-us = <2500>;
> -                               min-residency-us = <5309>;
> +                               entry-latency-us = <750>;
> +                               exit-latency-us = <2350>;
> +                               min-residency-us = <9144>;
>                         };
>
>                         CLUSTER_SLEEP_1: cluster-sleep-1 {
>                                 compatible = "domain-idle-state";
>                                 arm,psci-suspend-param = <0x4100c344>;
> -                               entry-latency-us = <2700>;
> -                               exit-latency-us = <3500>;
> -                               min-residency-us = <13959>;
> +                               entry-latency-us = <2800>;
> +                               exit-latency-us = <4400>;
> +                               min-residency-us = <10150>;
>                         };
>                 };
>         };
> @@ -398,7 +408,7 @@ CPU_PD6: power-domain-cpu6 {
>                 CPU_PD7: power-domain-cpu7 {
>                         #power-domain-cells = <0>;
>                         power-domains = <&CLUSTER_PD>;
> -                       domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +                       domain-idle-states = <&PRIME_CPU_SLEEP_0>;
>                 };
>
>                 CLUSTER_PD: power-domain-cluster {
>
> --
> 2.42.0
>


-- 
With best wishes
Dmitry
