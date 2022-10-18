Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2140602D3D
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 15:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiJRNp1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Oct 2022 09:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJRNpY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Oct 2022 09:45:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30920ABF14
        for <dmaengine@vger.kernel.org>; Tue, 18 Oct 2022 06:45:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bv10so23556119wrb.4
        for <dmaengine@vger.kernel.org>; Tue, 18 Oct 2022 06:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MJnaw4Nz/0LgJzP7kyxNcgi29Swk3/5rr37ifIz0ztw=;
        b=qm28la7HKa0mTC4IqnER+pSavQF5rf2U/g2TYDSqEzerpd8hRn5ew7DHga2eqk/vhe
         gcsBlX7jhzY/Zhtgmwb+/mWJ7Rez6bPb5eJ9kkIGplP1GerC400+HBKr1osapVzBgk3K
         XGcQ6qEXROnauyzLo6R1pvcjhZZ82x31JNWtQbNpj18Dbb1nPW26otcrzBommLmr4QqN
         XsmkMTaXm2HG1qDP2mLsmt9rzRy/rGPLFq76jKScxqvomPFxVBx4ASdA9IzYFPfwlWfl
         8U70j+JxFPPWf7WD6hSJWFp8AnKHKZpH+wSUWYb/RKetq36jEWSZ268Kpmu0eo0D1HG3
         4wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJnaw4Nz/0LgJzP7kyxNcgi29Swk3/5rr37ifIz0ztw=;
        b=BAnsLGhH8N4wfRwpZCflXA3xPdQUKaV5GOG9EphnGi1cDTGUcv01kEQkX8Wmr2jLnu
         uxG4pMSiSPrytd7pvh87EGSUi8oK+u7DPpJAvpDY3dmYVMQV480eeFkHygnugVZQ24l0
         qbXnA4v/Togr89MF0HWMrPAjIxGiOSsRisizCChthEHe12cliNrWbXYuK9zg9zWumnxZ
         lrQaOtNFwxFKe2EIiutsrVLTi8CXszFu5B7z61q5da6f2GVgTk7KVkbw0otsanbUD39Y
         VL686z3YC9Fpd55/Pp34X/zW3A3ICXreMW6V7E9tMuvbmKeugkyU6tFoTknT+U+0jhmo
         Isxg==
X-Gm-Message-State: ACrzQf1q+9jxU+N+jRwR+aNhaKlzDer46Xlw7zvSjXz/5Fgrt+feDJQb
        9hLGK3XRQwOfU7VavafzdejxzQ==
X-Google-Smtp-Source: AMsMyM4FyNB+hm27xiZNu6OR6bDUk9kxUANipNOmcBaInA9C+QLskKPhKGLV0gHR7zsYn59wtiebyg==
X-Received: by 2002:a05:6000:1842:b0:22e:7bbf:c75 with SMTP id c2-20020a056000184200b0022e7bbf0c75mr1976315wri.547.1666100720778;
        Tue, 18 Oct 2022 06:45:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7fad:ace8:cda6:d900? ([2a01:e0a:982:cbb0:7fad:ace8:cda6:d900])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d6508000000b00228dff8d975sm11176515wru.109.2022.10.18.06.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 06:45:20 -0700 (PDT)
Message-ID: <37b4c6e6-ff16-184a-08b7-b6d1ee225c6a@linaro.org>
Date:   Tue, 18 Oct 2022 15:45:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 3/5] arm64: dts: qcom: sc7280: Add GPI DMA compatible
 fallback
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>,
        Melody Olvera <quic_molvera@quicinc.com>
References: <20221015140447.55221-1-krzysztof.kozlowski@linaro.org>
 <20221015140447.55221-4-krzysztof.kozlowski@linaro.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20221015140447.55221-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15/10/2022 16:04, Krzysztof Kozlowski wrote:
> Use SM6350 as fallback for GPI DMA, to indicate devices are compatible
> and that drivers can bind with only one compatible.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
