Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB50E5F1B51
	for <lists+dmaengine@lfdr.de>; Sat,  1 Oct 2022 11:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJAJan (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Oct 2022 05:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJAJak (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Oct 2022 05:30:40 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC1D286D4
        for <dmaengine@vger.kernel.org>; Sat,  1 Oct 2022 02:30:36 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a2so10219473lfb.6
        for <dmaengine@vger.kernel.org>; Sat, 01 Oct 2022 02:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=h0yRBGEhuIvxHifng9wyTAJnBUl46RgW+IEQ7dYxhYA=;
        b=faW5SFuGMg1/jnQ8GQNq0I4KKHgq0ZlFzICbLVsHIZF7xyY+aoCeqqUkED70mKIWAx
         7Fp28gfCzWZmkG19/PyiktLOloDs7/VY/g1CKbtDEaMJdhe10T1dTMXJSrmbH/ikZFhz
         ZuCPFa45nzVtplBJap6D4s3ic9OBjgIFHbJX67AvIDbD4EwT7reH1w/Qo9rIdtIsyKFk
         ooJREllzvIerUsgiKi7lm3NkZVDaMvmqFFnx9Ohro6tXGcFnc4bb9BJP98L+LSDPh2dF
         Y+hG9/Fdjdur3CuujGJeXefEw9ajhtuFaLK9XkHecXR14k45bQSDCtSo0gO9qJ+6D8rH
         2WUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=h0yRBGEhuIvxHifng9wyTAJnBUl46RgW+IEQ7dYxhYA=;
        b=G7B15ojovXpt2LKjpQNw6w80OBvdA5dgzyS508EZEk+ySPAWV3fiMkhu0VRgDadrR+
         6+BeYfEwzy1p7FEwDLkk5W3MC/c5A7yQlaRvUo0QCuDvK9A54gPaBdvzU/XS/VW2/z6/
         hGy4kcRmDHYVOGYdU88FIq58pHXkpshBvbM3i71Wgu+U5LQddEcw+2rsyqMjn63iSb7b
         8iQXdIVZt8V8QD7QrRjmnFnB9OpwEVfdxkzOUVnTE+dNwAVNzd8iuuD5oYCiqVU7D+oS
         cauqU80qktscHaUzu+ssysCCrbSinLUEkL3fh2Kgjs682Xefb4IMUyrwr9pUqzUdHEBh
         JrwQ==
X-Gm-Message-State: ACrzQf04es5DryVyA93JgIrkl35cSIO6eYlxHEigDYFFZw465lk4qN7P
        ocwuilxbHIubBGnm0Jk87TjiFw==
X-Google-Smtp-Source: AMsMyM5pGZCxlgPwCBkR3TPkFEb6OY/9uTQ3Xkq2E3c5fxoW9sCPX6up/Cho4CdvD9rACoUhZ+gpJA==
X-Received: by 2002:ac2:520b:0:b0:4a2:26d2:be31 with SMTP id a11-20020ac2520b000000b004a226d2be31mr592000lfl.473.1664616634840;
        Sat, 01 Oct 2022 02:30:34 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t12-20020a056512068c00b00497a123d8b7sm703500lfe.172.2022.10.01.02.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 02:30:34 -0700 (PDT)
Message-ID: <55b209c4-4fbb-8b09-a5cc-385ff3e5b771@linaro.org>
Date:   Sat, 1 Oct 2022 11:30:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/2] dmaengine: qcom: gpi: Add compatible for QDU1000 and
 QRU1000
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221001030627.29147-1-quic_molvera@quicinc.com>
 <20221001030627.29147-3-quic_molvera@quicinc.com>
 <CAA8EJppLd6dti=gbR0hbEAQyj5PHA7xWR3w+DESx1qcKcyf3YA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJppLd6dti=gbR0hbEAQyj5PHA7xWR3w+DESx1qcKcyf3YA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01/10/2022 09:14, Dmitry Baryshkov wrote:
> On Sat, 1 Oct 2022 at 06:08, Melody Olvera <quic_molvera@quicinc.com> wrote:
>>
>> Add compatible fields for the Qualcomm QDU1000 and QRU1000 SoCs.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  drivers/dma/qcom/gpi.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
>> index 8f0c9c4e2efd..94f92317979c 100644
>> --- a/drivers/dma/qcom/gpi.c
>> +++ b/drivers/dma/qcom/gpi.c
>> @@ -2292,6 +2292,8 @@ static const struct of_device_id gpi_of_match[] = {
>>         { .compatible = "qcom,sm8250-gpi-dma", .data = (void *)0x0 },
>>         { .compatible = "qcom,sm8350-gpi-dma", .data = (void *)0x10000 },
>>         { .compatible = "qcom,sm8450-gpi-dma", .data = (void *)0x10000 },
>> +       { .compatible = "qcom,qdu1000-gpi-dma", .data = (void *)0x10000 },
>> +       { .compatible = "qcom,qru1000-gpi-dma", .data = (void *)0x10000 },
> 
> As usual

I would say - drop entire patch and rebase patchset on:

https://patchwork.kernel.org/project/linux-arm-msm/list/?series=680815&state=*

Best regards,
Krzysztof

