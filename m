Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502E0650923
	for <lists+dmaengine@lfdr.de>; Mon, 19 Dec 2022 10:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiLSJKl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Dec 2022 04:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiLSJKE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Dec 2022 04:10:04 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921FCDF52
        for <dmaengine@vger.kernel.org>; Mon, 19 Dec 2022 01:09:59 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id f16so8368726ljc.8
        for <dmaengine@vger.kernel.org>; Mon, 19 Dec 2022 01:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7RQVjAZpZEDfwrYD/tTcNOhnjobio08prwVai5/P43Q=;
        b=XMfMbUzc79O4B0RFzinDgiHm1AWfTPbT1Rhto7td/0djjFOt/lAJ8CiPyhiZefSjZU
         +WMKJb40ReNclaeb43gzWdWWCV12cMHy6GoXNfVP0Sdr4aEpSQoJo4B4GbU0vmGNy7z9
         /gmcZjIXFaAQVhD2T2MCwDUPDk1HLAu5SWwp3uK+MIsL+IQPW0DSn66FfiSfFwl99ULA
         aj9kVaBhs1uIdrPHEOJOV+uidx2HNQjoUETAluE7kJbMujxdgoprJb2vEEgQjfN+zIGB
         f1/ya6cCosOukeVSzxPhwwdLKWj4/M9UgU+5lenbqL6PSvGHO8xm5UsjTzZhM8NqnfGl
         g6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RQVjAZpZEDfwrYD/tTcNOhnjobio08prwVai5/P43Q=;
        b=pnHChB8kqPp6HBbP9WfALWMqveZPvvKqMR/1xE+ysn9FAqITbFK6KrjR5yVGPXhxdI
         3kOoIW1btypGHOVwozqAd9HyzC/RROhNl9HCqg/NKoX7WKgGEAXHJuYMcqlpJhIdgwII
         rhUAx7BkQH5VM5pYmZFwq0goUAKVkKmbfd3Nm2yUoNxUVPMR2KwVwBLGujGiFJSOyO7J
         174lqY3AjvD/IDQJnCzPp4fqA1+Fjycb5cDESR3+15XXmKCkoQZnom+/AXFLz0PDu/PR
         C1y8gy/N4D2J/WU+JL4BJbU5qBt8vOuW11wHHXhkIjJtaiSk3ahPSo0cjCyMYXe/c/Lq
         GFkg==
X-Gm-Message-State: ANoB5plGXAFEBq3HQ7I/8w4MWi1wQTX2jZ8uJKx6NHrakRo9Dz/mOSHH
        It38ZTJN1c57biN7tOmgAPI/4Q==
X-Google-Smtp-Source: AA0mqf5EfXZCBaoylRSUyW/qa+q3eZHaBg8V/AaT00MAiNx7UkipD11GvL22iOVI8CSwoieS4Uy00A==
X-Received: by 2002:a2e:9209:0:b0:279:d624:7fba with SMTP id k9-20020a2e9209000000b00279d6247fbamr10227858ljg.23.1671440997860;
        Mon, 19 Dec 2022 01:09:57 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p8-20020a2eb7c8000000b0027997d00fc2sm700409ljo.21.2022.12.19.01.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 01:09:57 -0800 (PST)
Message-ID: <aab465d2-3305-c51f-2c00-08d5df1a333e@linaro.org>
Date:   Mon, 19 Dec 2022 10:09:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: gpi: Document SM6125 compatible
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221216231528.1268447-1-marijn.suijten@somainline.org>
 <20221216231528.1268447-2-marijn.suijten@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221216231528.1268447-2-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
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

On 17/12/2022 00:15, Marijn Suijten wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> Document compatibility for this GPI DMA controller on SM6125.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

