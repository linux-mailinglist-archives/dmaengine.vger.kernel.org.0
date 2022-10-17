Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B4C601B75
	for <lists+dmaengine@lfdr.de>; Mon, 17 Oct 2022 23:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJQVpA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 17:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJQVoj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 17:44:39 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E35804AA
        for <dmaengine@vger.kernel.org>; Mon, 17 Oct 2022 14:36:49 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id df9so8203488qvb.9
        for <dmaengine@vger.kernel.org>; Mon, 17 Oct 2022 14:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUAbd7PmeJKBiJfQ07eVu5bQpKJMvb43G13KF7OIkwo=;
        b=HeL05hhHMdsOAK+qg566sPPBkN6kgIt7z+lVILK03xEGxC67ABaOs2Lh1pMpFZV/YA
         91FAEGaiA2/ksquylfiEnw4m4AmpxG4viyyFwEnP63sF6HK0lZRuTUUwTQmKCncQYLlR
         4SZjtioDWUKjirZPCk+DeiRzVUL4RHn5l0Pb8TBFxCUbV7/lEvlo8t2y6rg+pQa1w609
         0i8yVd7H7oQCQDgYAJP6tm3C0PEaI6ciH6cx6LvTckrGfxzC5RtFfG4G4w0096fN9Gv4
         ZZOwsnMRovkUyd3v9szJB+bS0xfLY7KiK3EOh0wVZEUg2kraxs/WtglCixV1gtBsHGBg
         Po4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUAbd7PmeJKBiJfQ07eVu5bQpKJMvb43G13KF7OIkwo=;
        b=GtayxNlE76mNqkWUVWSTBfTDIEcTIuU4eXkbrBC4+EGnEl3ES5v0QTVD6bviOIKhh0
         2+JhVggNh/h8S/bigfqk66Vk8B8R9imhisjwUGqkZDhJw959wR1suXoOFCVpfksj2N7r
         rRJszO/f14linu/Io0w4uK0R5rFnaQCJtTxx2lZ0PlSJh9DT4jlMy95t3r+JOXfJI1sI
         x+OqaeyBCiul8p8liqg+mmDD/AxICL/xtgFc79lxEFJu7Jh4oAcrrSlBnyB8yjOoiOIA
         UBo9Mo4fIALUjAgMFBcg1jyOXPI5d8bSu36xITul5EZ9EBS+AYQ+iVXXhYAMyIendH+U
         yGQA==
X-Gm-Message-State: ACrzQf352NLtp4M8+1k1jQJMR76yZyuT5buNlNoZhvGKAmbRfA7ff4Kh
        EQYApHbX19O8sXLJ/fKbRbUDSw==
X-Google-Smtp-Source: AMsMyM7Hq8eHA8t8F9sJIwUeFLpaRZKfzg8HsGEaKLND4kBmFRrQQqTzpfWNlEDdv4nF9gO3bweJxg==
X-Received: by 2002:ad4:574c:0:b0:4b1:87b5:c0dd with SMTP id q12-20020ad4574c000000b004b187b5c0ddmr10242320qvx.68.1666042608973;
        Mon, 17 Oct 2022 14:36:48 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id y8-20020ac81288000000b00398a7c860c2sm639937qti.4.2022.10.17.14.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 14:36:48 -0700 (PDT)
Message-ID: <801c902d-4e1a-6ddc-e050-afdc2514e687@linaro.org>
Date:   Mon, 17 Oct 2022 17:36:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 2/5] dmaengine: qcom: gpi: document preferred SM6350
 binding
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
 <20221015140447.55221-3-krzysztof.kozlowski@linaro.org>
 <20221017212320.4960-1-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221017212320.4960-1-mailingradian@gmail.com>
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

On 17/10/2022 17:23, Richard Acayan wrote:
>> Devices with ee offset of 0x10000 should rather bind with SM6350
>> compatible, so the list will not unnecessarily grow for compatible
>> devices.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/dma/qcom/gpi.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
>> index f8e19e6e6117..061add832295 100644
>> --- a/drivers/dma/qcom/gpi.c
>> +++ b/drivers/dma/qcom/gpi.c
>> @@ -2286,13 +2286,14 @@ static int gpi_probe(struct platform_device *pdev)
>>  }
>>  
>>  static const struct of_device_id gpi_of_match[] = {
>> -	{ .compatible = "qcom,sc7280-gpi-dma", .data = (void *)0x10000 },
>>  	{ .compatible = "qcom,sdm845-gpi-dma", .data = (void *)0x0 },
>>  	{ .compatible = "qcom,sm6350-gpi-dma", .data = (void *)0x10000 },
>>  	/*
>> -	 * Deprecated, devices with ee_offset = 0 should use sdm845-gpi-dma as
>> -	 * fallback and not need their own entries here.
> 
> This comment is from the dependency series [1]. Why would we need to add it just
> to remove it here? I was not notified that the dependency was applied anywhere
> (except as a base for other series) so it's not set in stone. Let's just drop
> the original patch that this comment originates from to prevent needlessly
> adding and removing the same lines at once.

I don't remove the comment, I re-phrase it to be better suited for final
code.

Best regards,
Krzysztof

