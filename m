Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7686BA9E6
	for <lists+dmaengine@lfdr.de>; Wed, 15 Mar 2023 08:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjCOHuR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Mar 2023 03:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjCOHth (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Mar 2023 03:49:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C5610259
        for <dmaengine@vger.kernel.org>; Wed, 15 Mar 2023 00:49:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o12so71899809edb.9
        for <dmaengine@vger.kernel.org>; Wed, 15 Mar 2023 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678866553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4jTWKZT/WqK/PAs/34gwzyyEXZKpB6B+ZKyGmn/bWSw=;
        b=zvSL1dmtje9KlvoS18mXITCAtA8dBTg1/qyaofpxO3gfhJEP4Icdb2yW6MrsUj2fQX
         cgKc/vbBujVjOgS6Ke7OrPWaZC0zv1Ozgp46CbAeRg9y7GtCx/983snoyv3m1NaGFlOE
         3piJsSfdR2Huw7I2vnSiVUlOV6VYZmcDe6c4ww0CZenr3q3xbhVAbDG4MP3acbeXMKiF
         0Mll6kucBj6d+wNq/rN1AeXvu/t3h+yznLTfwzjvYPbLcaVimGHQhF3J0YXmq1nL6HaV
         c8tKjY3cIKMuq6uMR5RFL7vWpqoqwZ2jOwVU8DaXCTBKKs/Nzq7wqFkRNnMlSU9N5uep
         UHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678866553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jTWKZT/WqK/PAs/34gwzyyEXZKpB6B+ZKyGmn/bWSw=;
        b=unlTPnHabEt5EfR0o7qc+OPjbtPfPjxH8yT5gCNOa9ZrSH8vJK79mdfnEp34usX25l
         L0Czi1elv2gN1DKTxgTtIm5pQrN7B6OqPbUXMo4oAfouLWACD8F/hu/94JYGzJ1E1hPE
         JsIF/EMUOwv6t26JVlflntSL9E2QRXOdnrqf6nI2ZTXsUBf8JzolAotsUkWSb8weFz0+
         dIheNlMg/ARptlGO4pw5v9SgOISwQnvSBHXnL/BKG/iZq9CUVg7krOSzIFGeCPHWA1DC
         aB+fI+mST/IzdBUFQQGp39sKyISYl4JrfFNwv5qRgBJDEnazNDoY989SIdVuZXlUvTJc
         QZVQ==
X-Gm-Message-State: AO0yUKUX+io/6lZB99zMA61oqCiLuuGsKcvr/qcW22C6YfcK/asNGr4U
        Ysz0zInYCOoDlCB2BlGR7MkwQg==
X-Google-Smtp-Source: AK7set/DufcKRoaW3Yr1mrSAa8vL1Txs9RfHYAyniHtkwEHOoaVXzllk/DIHe3ZZckGfl7GwJ+U5kw==
X-Received: by 2002:a17:906:b2d3:b0:926:320c:cd98 with SMTP id cf19-20020a170906b2d300b00926320ccd98mr5198999ejb.36.1678866553616;
        Wed, 15 Mar 2023 00:49:13 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id hp38-20020a1709073e2600b0092d16623eeasm1693786ejc.138.2023.03.15.00.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:49:13 -0700 (PDT)
Message-ID: <d3e20d58-3448-3f70-eba1-f4c126e85a83@linaro.org>
Date:   Wed, 15 Mar 2023 08:49:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5/6] dt-bindings: usb: dwc3: Add QCM2290 compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
 <20230314-topic-2290_compats-v1-5-47e26c3c0365@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314-topic-2290_compats-v1-5-47e26c3c0365@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14/03/2023 13:53, Konrad Dybcio wrote:
> Document the QCM2290 DWC3 controller.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

