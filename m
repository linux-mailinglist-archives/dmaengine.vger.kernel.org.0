Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9C478E10E
	for <lists+dmaengine@lfdr.de>; Wed, 30 Aug 2023 22:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjH3U5Z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Aug 2023 16:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240578AbjH3U5Y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Aug 2023 16:57:24 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B73ECC5
        for <dmaengine@vger.kernel.org>; Wed, 30 Aug 2023 13:56:50 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-52713d2c606so64084a12.2
        for <dmaengine@vger.kernel.org>; Wed, 30 Aug 2023 13:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693428619; x=1694033419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sqhS2buf3q5lKZs0QgnHq/NuMUrTYmV//7wpqK/hL6c=;
        b=sBla34O/FIaDr04NXeH+7qsXGJrCqHhftz84XhLYl4PpLsPtZvK0hwnhHghVeGygSX
         rIFucot1DivHDMycCDiUR+ja5aRDzml88ivXgwt8zr7rmMzyA8EiAiiDlURuFnlnelEq
         Qe43rgH8SOVgonxlqvZOsdcEQTSPrqN1GklSWAU4k9Lb3u09FFbP6ekvoHvcCa3mUiEt
         0+EePymv7tDnA35WBNEYrPlECPfTGawxxsBolD4GIk7+HzBlpwxwzgyx3LcnRvTqT0FA
         rwSoKLFUm75lhXRKZC+7NEmg3bpaXwK7YmPp33GshEeuqqXBJammXwmqyDd46H1Gp/9H
         Zvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693428619; x=1694033419;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sqhS2buf3q5lKZs0QgnHq/NuMUrTYmV//7wpqK/hL6c=;
        b=BG6YuNQDVUTjakyj/Mf+j7Unl9pzwQjXOUBcKKS591VnjXgHTb58CBTLokSADXkUqC
         9fxjSXFuih4CI6nibC6QcQXao0d4vaXioCVOkV9Qh84ifadbIz1GJerzvGW/sDFx71sB
         xVLU/MsdllZdOegrm2OMV3PFnpCuqU49aU//HUlUqXl7X2+7i+y0/MEg4hJyWSauSY9s
         EWKawrPwX2pn20xkzOdgPfdgu4JiMrmb8D0oumibvShRsMCpiuj8MDC188DbG9qr4zlQ
         aExdH30lysM0XvpnFYHs4lDikCcjTqY9Jcn3aUYuxc9lwC/Vl+lQB+z7DNDxVQHKMd6Y
         jCOg==
X-Gm-Message-State: AOJu0YxFkg/236BcdT5cDpBwOVbn8vWH+VqZdod8TT+qL9vuDIbo5GDg
        gi1lOoz6nJ1mMskGoPLflr/1U5o3Hk6NKDgdvQ5jew==
X-Google-Smtp-Source: AGHT+IFYtYpox7ihArAxMld7ZB3Yd1sKfUj50x1GV1gb0SRJFFM1XHVFrLZ2pomZaP6+3hhHlGaWiQ==
X-Received: by 2002:a2e:9990:0:b0:2bc:dab2:c7dc with SMTP id w16-20020a2e9990000000b002bcdab2c7dcmr2411638lji.47.1693427732218;
        Wed, 30 Aug 2023 13:35:32 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id w8-20020a2e9988000000b002b9f4841913sm2742873lji.1.2023.08.30.13.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 13:35:31 -0700 (PDT)
Message-ID: <6bcb460b-6deb-4918-9058-67536e0af0ad@linaro.org>
Date:   Wed, 30 Aug 2023 22:35:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] arm64: dts: qcom: sm8550: Fix up CPU idle states
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
References: <20230830-topic-8550_dmac2-v1-0-49bb25239fb1@linaro.org>
 <20230830-topic-8550_dmac2-v1-3-49bb25239fb1@linaro.org>
 <CAA8EJpp7bxq4=i1CMPYvz99ZuKLz+th6zSFhhRhFMjDwGB5Z8Q@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAA8EJpp7bxq4=i1CMPYvz99ZuKLz+th6zSFhhRhFMjDwGB5Z8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30.08.2023 22:13, Dmitry Baryshkov wrote:
> On Wed, 30 Aug 2023 at 22:04, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> The idle residency times are largely too low according to the vendor
>> kernel (maybe they came from an earlier release or something), especially
>> for the prime X2 core. Fix them.
>>
>> Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 32 +++++++++++++++++++++-----------
>>  1 file changed, 21 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> index d115960bdeec..c21ba6afa752 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> @@ -283,9 +283,9 @@ LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
>>                                 compatible = "arm,idle-state";
>>                                 idle-state-name = "silver-rail-power-collapse";
>>                                 arm,psci-suspend-param = <0x40000004>;
>> -                               entry-latency-us = <800>;
>> +                               entry-latency-us = <550>;
>>                                 exit-latency-us = <750>;
>> -                               min-residency-us = <4090>;
>> +                               min-residency-us = <6700>;
>>                                 local-timer-stop;
>>                         };
>>
>> @@ -294,8 +294,18 @@ BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
>>                                 idle-state-name = "gold-rail-power-collapse";
>>                                 arm,psci-suspend-param = <0x40000004>;
>>                                 entry-latency-us = <600>;
>> -                               exit-latency-us = <1550>;
>> -                               min-residency-us = <4791>;
>> +                               exit-latency-us = <1300>;
>> +                               min-residency-us = <8136>;
>> +                               local-timer-stop;
>> +                       };
>> +
>> +                       PRIME_CPU_SLEEP_0: cpu-sleep-2-0 {
>> +                               compatible = "arm,idle-state";
>> +                               idle-state-name = "gold-plus-rail-power-collapse";
>> +                               arm,psci-suspend-param = <0x40000004>;
>> +                               entry-latency-us = <500>;
>> +                               exit-latency-us = <1350>;
>> +                               min-residency-us = <7480>;
>>                                 local-timer-stop;
> 
> This isn't only fixing the time properties, but also adds the whole
> new sleep state!
It does add a "new" sleep state with the exact same parameters,
the only thing being that it's exclusive to the prime core and
the only thing that differs is the residencies.

Konrad
