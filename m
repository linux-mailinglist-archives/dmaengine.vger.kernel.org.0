Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CB8595460
	for <lists+dmaengine@lfdr.de>; Tue, 16 Aug 2022 10:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiHPICB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Aug 2022 04:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiHPIBl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Aug 2022 04:01:41 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A167765249
        for <dmaengine@vger.kernel.org>; Mon, 15 Aug 2022 22:21:05 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id jl18so426364plb.1
        for <dmaengine@vger.kernel.org>; Mon, 15 Aug 2022 22:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=0p+K0qLqxOzyQ3M+oE6bJ773iu7oRhxO3HE/oVHQgeI=;
        b=Q84XFhLhci9sMypF2Qq1P+Ztgp7ErAQco5AR0ZLZ1SEHo124YaVRL+lvNOVVysf9P/
         ZGF/F5dvUD2T0R9cWO2XGG+02LCY2H7kF8FIzLRGPbSlG9R2C505ZbCwcn5DzkLOWjRL
         3p1X5J1tWUwurowbXOZLG3WRTdUFHeZfr8rkV2xAa+bMYYpcETYi2cC+WhxeuOXxew5G
         baoTzvF5eOCA5H7vq/9nWJ9QOHqw7sAisXUVflIRBcW8FLd/SXkDdnfT4QxoNueaj7NU
         VFVpGTw8IzYb2C+1KFeKd4zgF08vW3uA4pb/QYznp9Wbo13qfYrlhpzdMr7wkwq8wOHt
         fAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=0p+K0qLqxOzyQ3M+oE6bJ773iu7oRhxO3HE/oVHQgeI=;
        b=G0M5cAn1VusdOjUTulzvLXYy4KZGUSJauZavUodvTQL3TIPv/Bi7t5rpCepI7JzKa3
         9UMsZWVxb5XJtMFTxgda7jNoyjknStN+QptC5Iu3gMB5YoEXvVZU3K38z5+anABewRaZ
         QAEU6XcYMRw0YjCK035fiSwk/ZwPN0OqDo1BMQiRaYJZGXuQS3wJ7tPoM1PImnpJzQOA
         vsQ6pHgBKL5shVW784GDgkL5enniVBT4bCYCYz34Ywe1WfpjEocPjXNP4hPnK6JdC8qH
         j2SMTvEZlOFZLHUsz56WzYjleI1IXwMAZ/lnlqX1WXPXcIO54MhsyKhcynDHA+V0OkM8
         3gJw==
X-Gm-Message-State: ACgBeo1791wasUF1QeFWzNayJiwfiDoAVcLl9AsRLnJek/iJc8awI1eM
        SLYBE4Fvn6GG/Up+H0Tlmasy0A==
X-Google-Smtp-Source: AA6agR6chfmdgtWHQp2MitjNlKme1+yXKlKet9gzMaudy3FfMj/Cbfy8IiOC63TSrhs1532tAhnnBQ==
X-Received: by 2002:a17:90b:1b49:b0:1f5:4203:2e4e with SMTP id nv9-20020a17090b1b4900b001f542032e4emr31106602pjb.143.1660627265141;
        Mon, 15 Aug 2022 22:21:05 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b0016eecdf8978sm8012796plg.106.2022.08.15.22.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 22:21:04 -0700 (PDT)
Date:   Tue, 16 Aug 2022 10:51:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Emma Anholt <emma@anholt.net>,
        Rob Clark <robdclark@chromium.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Adam Skladowski <a_skl39@protonmail.com>
Subject: Re: [PATCH 4/7] cpufreq: Add SM6115 to cpufreq-dt-platdev blocklist
Message-ID: <20220816052102.jdonvyxkix5n34u5@vireshk-i7>
References: <20220815100952.23795-1-a39.skl@gmail.com>
 <20220815100952.23795-5-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815100952.23795-5-a39.skl@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-08-22, 12:09, Adam Skladowski wrote:
> The Qualcomm SM6115 platform uses the
> qcom-cpufreq-hw driver, so add it to the cpufreq-dt-platdev driver's
> blocklist.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 2c96de3f2d83..6ac3800db450 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -146,6 +146,7 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "qcom,sc8180x", },
>  	{ .compatible = "qcom,sc8280xp", },
>  	{ .compatible = "qcom,sdm845", },
> +	{ .compatible = "qcom,sm6115", },
>  	{ .compatible = "qcom,sm6350", },
>  	{ .compatible = "qcom,sm8150", },
>  	{ .compatible = "qcom,sm8250", },

Applied. Thanks.

-- 
viresh
