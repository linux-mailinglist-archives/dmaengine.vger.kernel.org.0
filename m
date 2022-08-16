Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F4559564E
	for <lists+dmaengine@lfdr.de>; Tue, 16 Aug 2022 11:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiHPJaR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Aug 2022 05:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiHPJ3r (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Aug 2022 05:29:47 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ACF108F80
        for <dmaengine@vger.kernel.org>; Tue, 16 Aug 2022 00:49:38 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bx38so9823847ljb.10
        for <dmaengine@vger.kernel.org>; Tue, 16 Aug 2022 00:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=9Cr9AYG8AdsKwmXI4Qiz3tAwEHTOmPCZfY7GjgrZfEs=;
        b=oQyawWMFN77LukqlOAKyMex0kW4mXtBVf4SIAf6rAB7V0xmXWtCZOfHXXlLgWFsAVR
         YDkC+KEIwnN9q9+bzpoq3V21fN2gdvKcuDy6aAjGPlmQ2i4QKzFoq05wDBx+5UqPzPrE
         VPuwCGTck8vD3ttKoVixcVbeB8BSzv4pkNP/ip95kqcCaH/jDWsFFPjCvKYwGZyI1xF0
         geLMrXjBaK4DVrx+1qc8aeR5uVtUGjT5BmV6OwdBgVLlrGiUysGSi69Sn1A7nnHvYGrG
         C3ptSZdyGeQ7QguT21ObbkLZKWzhhgTUOCI7/RZVK7mnINn6hPj4ufnZBZdgonpnaPjF
         WY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=9Cr9AYG8AdsKwmXI4Qiz3tAwEHTOmPCZfY7GjgrZfEs=;
        b=ZVBu1VcuMIlREoz8bYU5WAn7wvE+/C/vf4infUTjvGU5uItBzDkdDPuoXcKxVekptU
         tl5rNQ4rGKJ3Q20NBO8g0UbyDO5/EhX5jSi9eiiF6s+SXoSOt2N64IU0b21CUInX0bI0
         fiWB1o2qs/WZXYcTSbT4NrTRwrF4b5YciAKemXJfhV3i7DKW2l/X89oGxWBXzR+Wjadp
         tOW3VVvWH4+7HhSVHNqB1+qxNwcjWeKErwP0HHPWfCghmbdoW4GEpdK7FkL/+gdyORWM
         RS+6dM9iiU+RZWe1jr4lWPg4HTURuiYism8qG+tM6gOydRCZa4zmhEXSLim1n6eP3NMr
         90Yw==
X-Gm-Message-State: ACgBeo2S7Ti5BCjVtd/t42zeH8lCiNHR2ItLpiVQ7sSYSNLJ/NqPPmof
        FGtN16/fQLEtMgsqnd3vsZx0QA==
X-Google-Smtp-Source: AA6agR4ZuIL6YhljvhwjG1WDPl7O3ub8LcT4CuceR2nnMLcn4XRci7/OmpyrLVADMM9r7D/ehodRsA==
X-Received: by 2002:a2e:b010:0:b0:25e:65b3:b24d with SMTP id y16-20020a2eb010000000b0025e65b3b24dmr6269239ljk.292.1660636176946;
        Tue, 16 Aug 2022 00:49:36 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id l6-20020a19c206000000b0048a9f1933f2sm1301493lfc.247.2022.08.16.00.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 00:49:36 -0700 (PDT)
Message-ID: <41fd15ba-b261-c3cb-2762-076aa5e984b2@linaro.org>
Date:   Tue, 16 Aug 2022 10:49:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/7] dt-bindings: mmc: sdhci-msm: Document the SM6115
 compatible
Content-Language: en-US
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
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Emma Anholt <emma@anholt.net>,
        Rob Clark <robdclark@chromium.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>
References: <20220815100952.23795-1-a39.skl@gmail.com>
 <20220815100952.23795-4-a39.skl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220815100952.23795-4-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15/08/2022 13:09, Adam Skladowski wrote:
> Document the compatible for SDHCI on SM6115.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
