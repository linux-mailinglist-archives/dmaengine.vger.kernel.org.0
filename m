Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7295184DE
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 15:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbiECNGU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 09:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235702AbiECNGQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 09:06:16 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F041EEED
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 06:02:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kq17so33310611ejb.4
        for <dmaengine@vger.kernel.org>; Tue, 03 May 2022 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wjuyFMi3EftK+wExgb79hTBMB0k+0b/v8BwPvQxw7y4=;
        b=ewo04wJHjJ26IyHukQuan08cFZWOZ7IDAC+rphPmISbWSJd0i7v3ydWkWRbJ4mr7Ir
         oZY274wqWX45dwJ5aPdkSSK8pPqMMQo4ZOGhI9o5qQ2aDJ5qP0hdW/BlyBUw8jZwPs3d
         SOFA6kOq+ru/zHs/BJjJT1nJpDCVqg8mRMSB1EYvyPpQQDymST5pAkIAzQLfhTv+fAwu
         eThs6VpM6H8m0MkjAdQvsUEzXZa9ss9qkrkJz5tUBqMhJpEx63XHJZ9Z+9xgIwfijEuZ
         /Fvtj3PsqngNq8kFBbxK0YvvreqgxpWJ5oRc82770+h+mdqefxw4D9hk4YSmX8vYz0fl
         chIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wjuyFMi3EftK+wExgb79hTBMB0k+0b/v8BwPvQxw7y4=;
        b=s+I4VYhcEVfNAkxyHVAli5MX//lH/fY0os/2mSYReHEJ+DGUZoORJU3QoouEHZCyWL
         Z017guQvu4hMwM7Db/bdZWMneFfyLglbIPiuoleHWWL4Zc8+M/e8vFQNJGKvkV7PZXVO
         xHuDDMCJ2Xhh8B1S9dCHxRwGqWorx9urIsOOaMp+c4ujjNNaKfKleW8ywmL1LM1IhYOa
         MCrfcmuVPwZ1NqIuwYAYys8kWK9UybJcCfPTIExje8bYuZVMkm71oqpFK8cb548yjtWo
         4Ohk1sTMuX21BqGwSv/uA/zPVwzFLfW2zjrteXeg3VunoKcC9Ve+So7jfK7N44OXC8MJ
         8s0Q==
X-Gm-Message-State: AOAM532Fqrkxp+3LFMwRuywqZMrFBD7M6IhozWBCiuglSbOTm1r7kxIx
        +MWgGlEtYrtIy3DxjyGGbBrIow==
X-Google-Smtp-Source: ABdhPJxWgTe6ERgukBkZ++ex9vxpB+SWDPBIHrtqfv1/46KOzrlx42JkXeG5wZwA4KLrDpdY8UXEeA==
X-Received: by 2002:a17:907:c0d:b0:6f3:ed89:d9c with SMTP id ga13-20020a1709070c0d00b006f3ed890d9cmr15463845ejc.502.1651582962080;
        Tue, 03 May 2022 06:02:42 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id hz22-20020a1709072cf600b006f3ef214df2sm4600317ejc.88.2022.05.03.06.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 06:02:41 -0700 (PDT)
Message-ID: <5ca8b4d2-5edc-0962-9b26-6701515a26cc@linaro.org>
Date:   Tue, 3 May 2022 15:02:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/7] dt-bindings: serial: renesas,hscif: R-Car V3U is
 R-Car Gen4
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-i2c@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1651497024.git.geert+renesas@glider.be>
 <dd734aaa4e5e0b32864b038b79eafe72907fb99f.1651497024.git.geert+renesas@glider.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <dd734aaa4e5e0b32864b038b79eafe72907fb99f.1651497024.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02/05/2022 15:34, Geert Uytterhoeven wrote:
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family.  Hence move its compatible value to the R-Car Gen4 section.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
