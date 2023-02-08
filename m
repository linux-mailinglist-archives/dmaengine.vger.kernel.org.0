Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10A868EA83
	for <lists+dmaengine@lfdr.de>; Wed,  8 Feb 2023 10:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjBHJI0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Feb 2023 04:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBHJIZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Feb 2023 04:08:25 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4878298E3
        for <dmaengine@vger.kernel.org>; Wed,  8 Feb 2023 01:08:23 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso944533wms.0
        for <dmaengine@vger.kernel.org>; Wed, 08 Feb 2023 01:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kg1370fRBchS4WrEOTujrg8ris+XQj/VhMGMuCTcwW8=;
        b=pPQG+jDQYHZ95sDMn/BcNeoc1ETpv/ZRHt41VzKrZwWvI7hBAjuNkrDzXiVbLRKKbs
         QXM8f4KBh/HZ3ORPNHXykrU7c/Jo3l6294t/5no1dy8N03B4KT/IS2HbstiPnx8fQbco
         cT+KPaRIVbz1963QZz+ySyXNwiS2edQnbDe4WrL7RU5ryGTlYMVrzTt8qKOwnSOIOiJS
         2Ui68DXdPUxstsPIxnvbMRq9vWJAA7cg66/tbuRs2qpQ0mJma5FCCtaD1gM8YvxyH1uX
         k/hsjyeYowvvXbX613hBICmfcCU5ChtGkwOUV6ZaArv7AWzDBFpGMIL1W8ASg6MEuWdF
         b+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kg1370fRBchS4WrEOTujrg8ris+XQj/VhMGMuCTcwW8=;
        b=pMmUzK2bUoB/ptAJToaRSDIOR7H9OoGgoBaD5qDhvNQXOWfdrHAz5jZ/bS0+u+6Vzs
         40zu2Obutbq5jyDHsDdCG6gYe6r6ottNb+Rge63CVcyOUnMW87O4Kd4gS9JCHLnTPK/V
         HisVEvKaZlNFwD20r+14buRlfTbiknBze5gsqJe/9E8jlaBe8cJP1xhKqLZ87WTYXgXz
         cWtaR34QFs61X3cvCGIaBXXycUjl9EVuzBuMy6U9LzBQuuNlK9vECfMVgzoBvgAHS/3f
         /4aUO0e80qykX90o0Lfh52VfT6wuifAzFwVqmZYSorXE0yIyZGRZxl/rtHOBBAPCkxlJ
         MPCQ==
X-Gm-Message-State: AO0yUKX2iO5vjmWZnwor4Fyh6nr//JlcuG1aDI+EF2LWTdDRov5hSNGi
        iwJe3SavEdTQokWc0PmiiExCVg==
X-Google-Smtp-Source: AK7set+AYnvRmL1dv14cgDGjUaKdaMYNStm6sTBm7TRXSEltSyQkAfWzIzwnarIGtooSsIpK3r9j1w==
X-Received: by 2002:a05:600c:601a:b0:3dc:42e7:f626 with SMTP id az26-20020a05600c601a00b003dc42e7f626mr5851274wmb.26.1675847302371;
        Wed, 08 Feb 2023 01:08:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:fea4:bc29:4ea9:97a? ([2a01:e0a:982:cbb0:fea4:bc29:4ea9:97a])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c190e00b003dcc82ce53fsm1317774wmq.38.2023.02.08.01.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 01:08:21 -0800 (PST)
Message-ID: <0f16d63f-3bb0-54aa-bcb4-4c666d4b2846@linaro.org>
Date:   Wed, 8 Feb 2023 10:08:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: dma: qcom,bam-dma: add optional memory
 interconnect properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230207-topic-sm8550-upstream-bam-dma-bindings-fix-v1-1-57dba71e8727@linaro.org>
 <a188a52e-6327-f0ea-a54e-a23b88bca82f@linaro.org>
 <a8112f61-f8d3-c1e0-9549-a9036a7e7894@linaro.org>
 <88c31e71-55b6-a20d-1fcf-07804eace54b@linaro.org>
 <eda179e1-4cd1-0d1b-4e27-2fe92e959cf2@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <eda179e1-4cd1-0d1b-4e27-2fe92e959cf2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08/02/2023 10:03, Krzysztof Kozlowski wrote:
> On 07/02/2023 16:27, Dmitry Baryshkov wrote:
>> On 07/02/2023 15:35, Neil Armstrong wrote:
>>> On 07/02/2023 11:32, Dmitry Baryshkov wrote:
>>>> On 07/02/2023 12:03, Neil Armstrong wrote:
>>>>> Recents SoCs like the SM8450 or SM8550 requires memory interconnect
>>>>> in order to have functional DMA.
>>>>>
>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>> ---
>>>>>    Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 6 ++++++
>>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> I suspect this will not work without a change for a driver.
>>>>
>>>
>>> I had the impression single interconnect entries would be taken in account
>>> by the platform core, but it doesn't seem to be the case, anyway I can;t
>>> find
>>> any code doing that.
>>
>> Probably you mixed interconnects and power-domains here.
>>
> 
> The driver change was submitted some time ago:
> https://lore.kernel.org/all/20210505213731.538612-10-bhupesh.sharma@linaro.org/
> 
> There is already DTS user of it and we expect driver to be resubmitted
> at some point.
> 
> What I don't really get is that crypto driver sets bandwidth for
> interconnects, not the BAM. Why BAM needs interconnect? Usually you do
> not need to initialize some middle paths. Getting the final interconnect
> path (e.g. crypto-memory) is enough, because it includes everything in
> between.

Indeed the interconnect on BAM may be redundant since QCE sets the BW,
I'll investigate to understand if it's also necessary on BAM.

Neil

> 
> Maybe my review tag was a bit premature...
> 
> Best regards,
> Krzysztof
> 

