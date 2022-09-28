Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A779C5ED6C6
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 09:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbiI1HvC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Sep 2022 03:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiI1Hu2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Sep 2022 03:50:28 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E711C13D
        for <dmaengine@vger.kernel.org>; Wed, 28 Sep 2022 00:48:42 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id t16so9415697ljh.3
        for <dmaengine@vger.kernel.org>; Wed, 28 Sep 2022 00:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=D6L490iDHj2njK4ypcZeseNDy21C7dvSyWTdsQEPxBQ=;
        b=wJw3d0GjcogEXixN+p9g1OfsN0pawh+fBXRh1TuDcYnls6cSo1vIS0Eoh0O/7ZueMb
         2Mdb7ZQfKpNgVpvbaeqUX/D6C1WoQDRxxheQOiY3GR8ME7sr4/+UoZVolBSpYsOVFlG5
         X3i2UgLzpbG+ELmwNhMhZrKGhmqGXi1RM3WlCgtKkm2Bh95J17LZoxvJ0Akdc35sE3c+
         sz/KooOi1BNfuhWfdPvZQCN8zLV9YTwEcSr/XTfl6bTW/pufQMdrpfeEQyM6gaSdY0kx
         aSBcX4pYjbn2YtKJwTSl9lFJPDYeuEox++mMHZ1JaWeFHVXKbg5bNymD0Hd38QtfeQ/B
         SUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=D6L490iDHj2njK4ypcZeseNDy21C7dvSyWTdsQEPxBQ=;
        b=A75EyFiEQGHSTyZ1uzGbpBoU9WL+XENJJogL+vSJv4Ptucm8yOCrZ1RZryT9D+rrZC
         U8H2P+iEQ6HrQIP/uM4TZJp2Hoyi1nIm4FTIsH8HAagc6dPyaNCpSCpzkQlFdM2OhOJ4
         CwO3IajZBAaZK6cItZ3m1Nf9dPDLIIHPAj0tqluI3adSuuoR0+fJ38weL8DVr7aoowNr
         WMMmEaAgX+8hmMsqFMQGVVa75MrnpXQ5hbvk5vhq5MpLjkaHoG2HffWagldO/umDE0Ug
         1U9CfgyRbZ/cqdMPxXe7AqoXio3sTVTa4hOiJQ1x8lQumxSashCcVgaLIvZZPDfwlcZH
         Vg0g==
X-Gm-Message-State: ACrzQf0xNVgDavzLc5DE+3sBtnKILdo6DyGpnTAdq5dbOQ+Zzd1tpTxQ
        Hl2YYDSuP3bBgMfhEUwSunx8VQ==
X-Google-Smtp-Source: AMsMyM6OU/EUX4mgVAAvlIdRSEs/5jIx1jMPGIGP2LYwtowiy6zTx1NmtUKgRlq6L3D/HCK6OIqKrQ==
X-Received: by 2002:a2e:81d1:0:b0:26c:3a94:e169 with SMTP id s17-20020a2e81d1000000b0026c3a94e169mr11862324ljg.299.1664351321212;
        Wed, 28 Sep 2022 00:48:41 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bj37-20020a2eaaa5000000b0026be23f24efsm370040ljb.18.2022.09.28.00.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 00:48:40 -0700 (PDT)
Message-ID: <e35be256-047a-4bf3-2f7c-6a2b37357cb0@linaro.org>
Date:   Wed, 28 Sep 2022 09:48:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 1/4] dt-bindings: dma: qcom: gpi: add fallback
 compatible
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
References: <20220927014846.32892-1-mailingradian@gmail.com>
 <20220927014846.32892-2-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220927014846.32892-2-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27/09/2022 03:48, Richard Acayan wrote:
> The drivers are transitioning from matching against lists of specific
> compatible strings to matching against smaller lists of more generic
> compatible strings. Use the SDM845 compatible string as a fallback in
> the schema to support this change.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

