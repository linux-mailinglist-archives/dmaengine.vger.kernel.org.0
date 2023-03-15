Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC216BA9D2
	for <lists+dmaengine@lfdr.de>; Wed, 15 Mar 2023 08:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjCOHtV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Mar 2023 03:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjCOHtJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Mar 2023 03:49:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8D95F229
        for <dmaengine@vger.kernel.org>; Wed, 15 Mar 2023 00:48:49 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id cy23so71786273edb.12
        for <dmaengine@vger.kernel.org>; Wed, 15 Mar 2023 00:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678866529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6iMt5vfS6366Di3F0rCHYJhoOUmHVMakcsWS0XE4JoQ=;
        b=wSb6oL+W8DvC08twM/z9kHWm1iVmnvV8NM2y5B3g0YgmaS1cFb+p07CXvHeL3sWgVz
         2iyfEf13uJESqat34LJDKuTq4eJ/8W2dccXUHUTb2d1LeJ3ZHbVNk0T9NwgEKNQNf+9v
         /ajsqjQ950dDvl+PD5cgnmF72U8H5nO7APZ6nTRGegAg+GMf/Xd7g9+YR7rs1ByCIGxa
         8hLFsd9PNrJXxSJnCjltx7ltscRt/1KPMBn6ymtyOFk2xVNIXu3QMG9wgnVZjdS7tG+d
         z+B0UnSGebT25wn8zrZLZwYoxW1WFp5uyey6ayH/dA02QR1KwQHhzISOgH7ar0y8WsJp
         VkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678866529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6iMt5vfS6366Di3F0rCHYJhoOUmHVMakcsWS0XE4JoQ=;
        b=usVDnNvxPhxGcKRd17MGJBASXjf8q/fN0ICiL017RgABsZTTltYg0oG59n3vyoQtjV
         2/T2P8ZqfNBI5TSVl1pdILSvQEFnJBa7bIMYj0nSGHkA0vq79A6yuf1aex785WE2uR3X
         m7wHUNMD5Sz234+pcwzLp4EkeElT/1SVYuugXczMB/KPw1o+y1jGMGNUOLIyhkZ0nGX9
         bR8vTCIQ2D7SWBMhlvtJV93qzTq83PKdz3LDiZC0C0K4qcBvtjvkmvEbRHKUziOrjjxe
         jZYJiTviGytNKNSoftIYRE6GgRbmuknPcftBjH+qMRlq29OkasmVUMJDw2F/65xqMbDg
         l0SQ==
X-Gm-Message-State: AO0yUKUYs7FbMMvAwypJQYc+kcgcJY7GGa6UDJa31RzEqy982+vEyphY
        aMtXAmVQ7+i2xl2hzB8UnexR0A==
X-Google-Smtp-Source: AK7set9pfGPhjrzpxbYlbNLONtnNwMYkwnxBuIRCdPpg7Gr/DFUMd3ygMUOjHlJeoSzhhNT3o3CLVQ==
X-Received: by 2002:a17:907:76b5:b0:8f9:ed75:f962 with SMTP id jw21-20020a17090776b500b008f9ed75f962mr5383507ejc.18.1678866528996;
        Wed, 15 Mar 2023 00:48:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id v20-20020a170906565400b008d427df3245sm2129172ejr.58.2023.03.15.00.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:48:48 -0700 (PDT)
Message-ID: <56f907f7-79c4-94fe-b29f-ff71390615b1@linaro.org>
Date:   Wed, 15 Mar 2023 08:48:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/6] dt-bindings: nvmem: Add compatible for QCM2290
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
 <20230314-topic-2290_compats-v1-3-47e26c3c0365@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314-topic-2290_compats-v1-3-47e26c3c0365@linaro.org>
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

On 14/03/2023 13:52, Konrad Dybcio wrote:
> Docuemnt the QFPROM on QCM2290.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

