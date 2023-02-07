Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092CE68D44B
	for <lists+dmaengine@lfdr.de>; Tue,  7 Feb 2023 11:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjBGKcz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Feb 2023 05:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjBGKcx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Feb 2023 05:32:53 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82892E0D7
        for <dmaengine@vger.kernel.org>; Tue,  7 Feb 2023 02:32:21 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p26so41861970ejx.13
        for <dmaengine@vger.kernel.org>; Tue, 07 Feb 2023 02:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8BZxDuCycAd1fCc9k9fhvujofozc+ta9issSCRUI9Nk=;
        b=R2VkFDKf+iPdD2a3k8s04obMG9YVHq4XpfTfoVL+MRo5+b+33XFGdLi5IKztv2eqg0
         I/kLxjmxwdFpt8Nnoum2CKtVvYNkGnkKrbdZW3nZB0c4pS5ECCVhzaZmSeRx9aCgqQ2V
         P4IVgkPiF3SX9eg4i3w74Tz62CYpOfxFWgzVt7+JmMbo2jWgs1AWW5gWFFafboSL8l3D
         CL51gQMiwKQZNL8FmjqIPQws09xuHoPWj6u4mS8yWWRinAtDLyPAl6XYMaifeSRQJGZs
         MzvysHbzoR4vNsD1gBHZF79MkZbIeI9pZndp1VyL53ycU5Sv/bWV5O4I13peCdrJU67R
         owig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8BZxDuCycAd1fCc9k9fhvujofozc+ta9issSCRUI9Nk=;
        b=0W+17GL249UJxiBAqMtaBRS3N/Uky1r2f79R7VHcGcvznxYlVyvIceeJagv8X26CPe
         B6IvtBzpSgkuseKpqTKvJwbiZXMZfesrGFqZhp8aeWucFkUviX7IE3xejuPvDakuL7nS
         DsmyQ4jkWOzXMTIfGQ8zHBdPgiKnGExf8LGuSzH92zeN8t+N0PFMmGggAZgx/WeZJfwj
         bFIk748JMh9s0XqfFDqGIU68x90QaN61j928Gxju2ObQaIEhziOuHCA2y4Fu0fygTbA5
         ++5cx5eJb8NRZVlWzw1zAu6QzXTXrbvXtna4dyMX/buNlPxI66j54rLzWzeRf9MZL2l4
         mnPg==
X-Gm-Message-State: AO0yUKVVXk5kUuF91MgTw+DeWyh5Q2dV9V+jm7Bb7tRqUDTx3u9PWBBf
        Id2MYJ/oCQVCZL6k+8IfS0ZsBw==
X-Google-Smtp-Source: AK7set+zqELopfv5DfjJbwt7pGlepRUBW5GRyGFrz1XjTSvVxUt1b5ryX1CAAkT2EMi2kjV6BowxMw==
X-Received: by 2002:a17:906:228b:b0:888:a06f:104b with SMTP id p11-20020a170906228b00b00888a06f104bmr3127945eja.36.1675765930386;
        Tue, 07 Feb 2023 02:32:10 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id v9-20020a1709064e8900b0088e7fe75736sm6687491eju.1.2023.02.07.02.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 02:32:10 -0800 (PST)
Message-ID: <a188a52e-6327-f0ea-a54e-a23b88bca82f@linaro.org>
Date:   Tue, 7 Feb 2023 12:32:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: dma: qcom,bam-dma: add optional memory
 interconnect properties
Content-Language: en-GB
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230207-topic-sm8550-upstream-bam-dma-bindings-fix-v1-1-57dba71e8727@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230207-topic-sm8550-upstream-bam-dma-bindings-fix-v1-1-57dba71e8727@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07/02/2023 12:03, Neil Armstrong wrote:
> Recents SoCs like the SM8450 or SM8550 requires memory interconnect
> in order to have functional DMA.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 6 ++++++
>   1 file changed, 6 insertions(+)

I suspect this will not work without a change for a driver.

-- 
With best wishes
Dmitry

