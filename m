Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752E75BBD58
	for <lists+dmaengine@lfdr.de>; Sun, 18 Sep 2022 12:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiIRKBN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Sep 2022 06:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiIRKAg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Sep 2022 06:00:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9A711C30
        for <dmaengine@vger.kernel.org>; Sun, 18 Sep 2022 03:00:03 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id w8so42299645lft.12
        for <dmaengine@vger.kernel.org>; Sun, 18 Sep 2022 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=D49UgMj+t87LgS/4bcGKgpE48pEQHg+Cu+6eMlqeAA8=;
        b=RAZ3vj7xukzV9r44PtwBleffFDhf3EFi6dmCkiQQBnfWjv/mE3J7Vz7zJY4DzijppX
         WkuKm9E45919XlsWPbMKbHoDxNY/euUiBUI+lcb2QPAUJMXZKbzWTMMPKe+f3OOrs2tS
         5ONDxtLznbxGn+DC/2FAI7XfbO5YjTCHX7ahVeyseXxsXj9Ydn9h1k4L8oWv6x0Ym5VS
         iTYLA38gLA5P9LNl0ee6WlOPCh3sr11qek8UmQmB1o7+6OHsj/LN4cAy3CfM0bCkKxeO
         mNpIabD9rFQbUWWLtp8qsGWCZUxntWNiqnc13cxUzVsPoOKLG8xN86GdIQVrdEKiSjWq
         Pfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=D49UgMj+t87LgS/4bcGKgpE48pEQHg+Cu+6eMlqeAA8=;
        b=3EZ5n5TpgvkT2My3osUXzoNP4edfNOdCwtigL+wpJBx+s5H7/DKE3+Y+EcykwXF7rW
         LGC/0prSxW/EFH0UZQdi4q0Rqc4O7M7yUoeXeg3fGS/oMirhY8FgldGOwXL87cZjk6bX
         yjp7uwyNYbazMnnUcvCv28PyuUE0TxpFoayusmgnB36cBU0tAbMbudg20TsRaU4Iq1c1
         wxP5q7c2/gYRqJ6FUgythMWRN5Fb6yB0tMPwEBOPpAz5wE73KwEBxGwg218PH10JeZmS
         bmybNUtZpEop9eX/zPQ//pSJy3Yj+sePX4zuKLl20wsW7PbT6qmgisxaHKzZfvg9brq1
         vxNQ==
X-Gm-Message-State: ACrzQf34ToSEd1cHqBrL9fLmHqnLY4r1i2xMx5ZvzcQsjfCBNi7gJ79U
        /F156tji/enJTUf7CXv7OVzEJg==
X-Google-Smtp-Source: AMsMyM7dUaica1z2s7VHjcYy5p7JpDnUrAku3pntnLE2RZEmAA9KsuzBdrQp7naZ7/zhHi9Kpyh0kg==
X-Received: by 2002:a05:6512:2521:b0:497:a6e4:4e1 with SMTP id be33-20020a056512252100b00497a6e404e1mr4497708lfb.320.1663495202223;
        Sun, 18 Sep 2022 03:00:02 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h1-20020a2ea481000000b00261cc85c32fsm1006240lji.31.2022.09.18.03.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 03:00:01 -0700 (PDT)
Message-ID: <750fe07f-aeb7-32ca-3ac2-15758a4d40f0@linaro.org>
Date:   Sun, 18 Sep 2022 11:00:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/4] dt-bindings: dma: apple,admac: Add reset
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220918095845.68860-1-povik+lin@cutebit.org>
 <20220918095845.68860-2-povik+lin@cutebit.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220918095845.68860-2-povik+lin@cutebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18/09/2022 10:58, Martin Povišer wrote:
> On the SoCs there is usually a shared audio reset line, so add
> a property for that.
> 
> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> ---
>  Documentation/devicetree/bindings/dma/apple,admac.yaml | 3 +++


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
