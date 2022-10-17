Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02742601B6F
	for <lists+dmaengine@lfdr.de>; Mon, 17 Oct 2022 23:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiJQVox (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 17:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiJQVog (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 17:44:36 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9481720987
        for <dmaengine@vger.kernel.org>; Mon, 17 Oct 2022 14:34:36 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id m6so7548882qkm.4
        for <dmaengine@vger.kernel.org>; Mon, 17 Oct 2022 14:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S6YbIjlMMjhoQF4j3ABjW9xhIQLIEnOYpTpLN/i2Gy0=;
        b=YcVK505nUxJVfJB93mXwT7JxiihqZOcpCDR49nUXAKM96aw1lpOQYCjLQ0uBdvu7lA
         cLxpaqMLDHZxEiSr+V5ZktuSKap79vNBZq8NTc1szVIsz6X9rCiwVK/CWieeLds1+dt/
         0YIoxme2siGq8sHOptIotomGGuz+enLtMEFsbtlywp9Fi4WpmPyA6/cXwAPPW+X/Q6hz
         l69ToJA8lXgPgUOCv/Fz+Xa1R4i43tGzkTnOJd3aGze8n2L1MJ4hxcRrHMroLj/SH5of
         iAKuA3ddbh2Kv4x2r+HurOJpOsMcTEwxW/QDHwvorxTgaNrjJ/tt6ozgEj06FaJoK513
         oUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6YbIjlMMjhoQF4j3ABjW9xhIQLIEnOYpTpLN/i2Gy0=;
        b=8InsQoFID7YQW9VaM8GnkXotw9rENyMAo+O1tCl3HcF8sYtyihKZjnrL1XHuxVp6py
         dGsKXo3+HWfk74z8UoaWjRJazNer/BCW591TcsL0D+CHNCAhWiB0zR/B3nPFV7K5l97R
         GaH+jLMB7jh3TZMY2jeSnCpr6Zg6XsEBSA/0MgvQbrMMpEfeYpKfcQHxeDaIi9gJDCgP
         0x6TQKcEU29F/g0zCM9tVdFDMGW6gYBgcUhZTpMvUikn1nYoVS/AGR4Bi05iXWvafmzx
         U8ZwbHmJBYJnqjp0uaKeLZJyxRlCUPoSQfF+r0J/w0w4fgWdUrl/nu/4aQ7pvaw0C4l0
         0x3A==
X-Gm-Message-State: ACrzQf24n20nibTiiJKCTG1xntjM0i+6osTiR3vZLxs//vk4nNR+fXW4
        jYvmEmJi6UZpdOgCdci5nIsN1Q==
X-Google-Smtp-Source: AMsMyM4XAa8u6LYrUiaRXiEDur8QhpnNq0ECnpYWcfcPMgAQzxC7f7N8xn4jMSy5j+fdycVdQZh9yA==
X-Received: by 2002:a05:620a:13c5:b0:6ed:58b6:6c3e with SMTP id g5-20020a05620a13c500b006ed58b66c3emr9249815qkl.385.1666042475589;
        Mon, 17 Oct 2022 14:34:35 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id x5-20020a05620a258500b006bb366779a4sm692268qko.6.2022.10.17.14.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 14:34:34 -0700 (PDT)
Message-ID: <67782169-b734-1edc-6d74-bdcfd907efc8@linaro.org>
Date:   Mon, 17 Oct 2022 17:34:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 1/5] dt-bindings: dma: qcom: gpi: use sm6350 fallback
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Melody Olvera <quic_molvera@quicinc.org>
References: <20221015140447.55221-1-krzysztof.kozlowski@linaro.org>
 <20221017211029.3987-1-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221017211029.3987-1-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17/10/2022 17:10, Richard Acayan wrote:
>> Several devices like SM6350, SM8150 and SC7280 are actually compatible,
>> so use one compatible fallback for all of them.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
>> index 750b40c32213..0c2894498845 100644
>> --- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
>> +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
>> @@ -20,12 +20,14 @@ properties:
>>    compatible:
>>      oneOf:
>>        - enum:
>> -          - qcom,sc7280-gpi-dma
>>            - qcom,sdm845-gpi-dma
>>            - qcom,sm6350-gpi-dma
>> -          - qcom,sm8350-gpi-dma
>> -          - qcom,sm8450-gpi-dma
>> -
> 
> If you don't want this empty line here, you can still ask for it to be removed
> in the original patch. It doesn't look like it was applied yet.
> 

Sure.

Best regards,
Krzysztof

