Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1DF602D45
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 15:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiJRNqC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Oct 2022 09:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiJRNqA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Oct 2022 09:46:00 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4B4CC83B
        for <dmaengine@vger.kernel.org>; Tue, 18 Oct 2022 06:45:54 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so3065904wmb.2
        for <dmaengine@vger.kernel.org>; Tue, 18 Oct 2022 06:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=girWpLhnDH5Eg8WtTtJ/aUyRj+2HWi7KI4BYRoNMPhQ=;
        b=r4Y64aJBlBk5I0Au6mcBaQSfZgJ1Ez5H+koz2S2xwZTS2iCc0NZHuRJT8QMtfSJ5ld
         1eceXLRnfbgGBNp/t7UkJamChtxzg/RPZ0UkZlVAuoUYkoktsOLAbqrxEeQF1Zw4+A0L
         94ljn6DIOvg00MuWmbwPDR+Xf3Df8GQilc5+m5tgxl5dfbS/8pogmGj3F/TcQLxseCBv
         7RmKM6PChv+sKDzzFLwE1up/3st+jYfQePHy397Bg/IHM0htZd1AyKd+h+YHOo3BdFJ2
         HEiBiJSwcJvTPd9BArw0FF1FZVU0Xd83AfK+Rem1vDtu4B1BheHQukIikR8qxNNpDbZj
         JZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=girWpLhnDH5Eg8WtTtJ/aUyRj+2HWi7KI4BYRoNMPhQ=;
        b=eVBD0tDAOXXQmTFBt10n0J02v/EJDQ6mMV5UG1LDzHMfuIuUrZtblCcKF9dOdNv4/j
         BxdSMambLNaHkNf1aGabd2P3nCeuzTSFMA4KO7Ij9MQK96lY/YStdrmirrjmyHyfZFUu
         AtIyieJ7OhLY/ja8Bmg7fFWRuy0lTTyKe5JuCZNcO8j7aIXJUdR8lLUSW8NEAI8sZL8d
         9ATDM1GF79WJmUz7VWxHS0LIpUwDIhkx0VM6QqOZ6E0dK01IWpW19ssMRQo7T/2RPUw7
         7uWfOpjMitln7NlljLMkrG7mxwCeSSctqV3aqlc6GMltn/nLbwB7znG5YnYMLq+Zonvv
         433Q==
X-Gm-Message-State: ACrzQf2sGUVx4kZiACUnV4dRLiLYZn3JfMrAhLeb22dWFyz8gKIhSgFu
        LXE5aXr2tXSh+AA0BXpnpIHg6Q==
X-Google-Smtp-Source: AMsMyM5j7eKRMx5R+MXqbWOtYfWnV/RtRCX2h9J/CBUag4EHQYMCqLNg4JaDPmsvuUukwu5We0HtcA==
X-Received: by 2002:a05:600c:2c4c:b0:3c6:e230:f18a with SMTP id r12-20020a05600c2c4c00b003c6e230f18amr17963029wmg.24.1666100753018;
        Tue, 18 Oct 2022 06:45:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7fad:ace8:cda6:d900? ([2a01:e0a:982:cbb0:7fad:ace8:cda6:d900])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d5009000000b0022e3d7c9887sm11087369wrt.101.2022.10.18.06.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 06:45:52 -0700 (PDT)
Message-ID: <941584f9-80c8-041f-8414-c6f3b2c36ed4@linaro.org>
Date:   Tue, 18 Oct 2022 15:45:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sm8450: Add GPI DMA compatible
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
 <20221015140447.55221-6-krzysztof.kozlowski@linaro.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20221015140447.55221-6-krzysztof.kozlowski@linaro.org>
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
>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
