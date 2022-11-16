Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CA262BC1B
	for <lists+dmaengine@lfdr.de>; Wed, 16 Nov 2022 12:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiKPLhO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Nov 2022 06:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbiKPLgj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Nov 2022 06:36:39 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8884FFA9
        for <dmaengine@vger.kernel.org>; Wed, 16 Nov 2022 03:25:52 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id r12so29005328lfp.1
        for <dmaengine@vger.kernel.org>; Wed, 16 Nov 2022 03:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L2rlqB9dtWxMHvWlubEptAwyw8MkkCffrMyTQ3/iTRw=;
        b=suzZJZsBAEPH0Zk6zqO6pp+Ffdyxk3lABz1rUxjYxu4b5owYiKL2mOnHHQFFyNjk0v
         A8ElvNP8E/VABpNVNHT/x1JZ82azjTIdcqXaccdtDapUvWfqoS4D2aDeSDVGQiK9OElH
         YQN6ulLLs/aaWl6F7I0RFLhC1+ETxGqeEwN8Dw4rKfi7OKO2TN4JRsff2Wwhohn0rzcn
         4vYqU3Eix6DULtEU2gcIEQkSduXXdlwEaE2zH0J5jrhuQ4C/FVY83MUmgPmUi1hBtIV3
         df8WokBwliCmXuPjLr9cHaTuOLdAcB4hkkIqWsIJBoB/MMjprceIs/R9lM+TogETQ7gh
         r2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2rlqB9dtWxMHvWlubEptAwyw8MkkCffrMyTQ3/iTRw=;
        b=E7ztVeCoXrAl7lyagOpuRS2+BhjnTfn6rLgXTCAFjE3tOLyshzvAvm5HiaeFbGRYBD
         /ZTW3fvY4U4ZitudUvSM+hD+kL74QvrpAvPdDpXL2hQJxe8/rAfiBi1IKmT1z55pqjK8
         9o9lvO6ZVh4FlV6whfE2AyLh4Lnig7Us8LdRZm0xGsXJqCxwp3csOWwqHsWSme3jfxBn
         /hn07ISLSw7s0E0O4qDjwEBNeXTp1ZbaD3dtr6cjKDZq64emovJziyEIiY8AVCxCXJNI
         /S8DGmG+bIzSDETopYUZGgSuFBDKvXjtZqxRlH7bHbpZ/Ghex0r+KV6iZGOTQskNS3xi
         upVg==
X-Gm-Message-State: ANoB5pkZFfeB8aONIjVmCQXrLj5Y1+2SaBcMHJDAQy3SkhLcU0KQtWcT
        x5wPl5PWyXaypDy6L+m00IcTjQ==
X-Google-Smtp-Source: AA0mqf6d8upCA6YJlUptNdCFQ/tAl7Q1bgWx3Hrd49SBpOkqVTaJaLhVbGMDAjxyP20jh8Y4hLCdcw==
X-Received: by 2002:a19:6505:0:b0:4ac:d6e4:41cf with SMTP id z5-20020a196505000000b004acd6e441cfmr6608962lfb.102.1668597951283;
        Wed, 16 Nov 2022 03:25:51 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t21-20020a2e8e75000000b0027711dbd000sm2862385ljk.69.2022.11.16.03.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:25:50 -0800 (PST)
Message-ID: <eb716ced-668f-4255-93ad-05f6bad8b83f@linaro.org>
Date:   Wed, 16 Nov 2022 12:25:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: dma: qcom: gpi: add compatible for sm8550
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-gpi-v1-0-33b28a227c5d@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-gpi-v1-0-33b28a227c5d@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 16/11/2022 11:13, Neil Armstrong wrote:
> The Qualcomm SM8550 uses GPI DMA for its GENI interface. Add a compatible
> string for it in the documentation by using the SM6350 as fallback.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

