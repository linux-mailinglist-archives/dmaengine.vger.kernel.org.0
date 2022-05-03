Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8EE5184B7
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 15:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbiECNFV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 09:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbiECNFU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 09:05:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04701928C
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 06:01:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d6so19754854ede.8
        for <dmaengine@vger.kernel.org>; Tue, 03 May 2022 06:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7Ds4LsGaaSrzpA9k9avFD90e+PqgmFVGpadAexhLvgE=;
        b=TdQOH2zo//QPttTudYGt81Z/yDrk3BSGIIjNieyYejqrMODsRAdwkCkxG18RvmueY6
         iHFaaqU2/gYGDutjRihcCZFaaai0E01p24AIiaL8R/CQ4n112uUATO3kkkVoKcptUI1o
         Sn+gCjKas+iRbrUB+31MZeSCs6QnEqo5T0yo0DWpz1TNP0IGP9LTJd26Fg74q/sFQWvX
         uIyzYpKYZZYkVDdC3nuHpXYj/+ApiO3w9x/b+9HpuFzGQOU0z9hI90Ah15PrgqYMaDbq
         BUwq10cb9/Nn050mB+f3Zn8of/wNnGLWFGnXKAgfBOQa17weFRGlsp2Fbxwgy7bU7bDU
         +yWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7Ds4LsGaaSrzpA9k9avFD90e+PqgmFVGpadAexhLvgE=;
        b=nj/76T2PonmBoBdmZORzTOZ0bGRQTAkljWIyGAulGnO/tgUS5EZALGiWjkizkHQDIo
         61tyzf0iAh9W9HjvlmOFRpVZ1C4mza2wtV7ut/z5A3Vc3bnr22Heuln5huxHB8x5a2Nd
         rPIch1Czch67HobDDHB2TBs0RtvtsSJiareZnUcr4ivibqODEa1tVmYCCv1ZuCEi3Us3
         s1vbDuOi1fYtM61NdXL24PngC9MOY7RSgYJFd+ZWhgr8elIxD8Jl47w7inCLGpIDuuwk
         JS871qsw+PEiXfmkOvYKAxFyV/gLBkV82iyJAhMKpGQxboOzzWYhE4maa6ufegVTfh/Z
         AHNQ==
X-Gm-Message-State: AOAM533VZufLXLnAQa5cSy+Zx7CVvXiF7QulIFL4Y0+rZm9Gka38fhy+
        mWKZzCKbyFAWlThKumHbqxNeciTWc5WJiA==
X-Google-Smtp-Source: ABdhPJzXf9VagfCKbioCX60kpRy8+OaEk9krJsm0GbbDF+wR9UXDeBuW7D0hkkgWHFhOjR95J6X9Hg==
X-Received: by 2002:a05:6402:e99:b0:41d:11f2:85e0 with SMTP id h25-20020a0564020e9900b0041d11f285e0mr17473687eda.339.1651582906512;
        Tue, 03 May 2022 06:01:46 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e12-20020a170906844c00b006f3ef214e3esm4573792ejy.164.2022.05.03.06.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 06:01:45 -0700 (PDT)
Message-ID: <8adbf80b-f057-c915-954a-12bd07ee7cc8@linaro.org>
Date:   Tue, 3 May 2022 15:01:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/7] dt-bindings: i2c: renesas,rcar-i2c: R-Car V3U is
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
 <a0402ff46027196953fe9c13f60576d40c5aea4c.1651497024.git.geert+renesas@glider.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a0402ff46027196953fe9c13f60576d40c5aea4c.1651497024.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02/05/2022 15:34, Geert Uytterhoeven wrote:
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family.  I2C on R-Car V3U also supports some extra features (e.g. Slave
> Clock Stretch Select), which are supported by other R-Car Gen4 SoCs, but
> not by any other R-Car Gen3 SoC.
> 
> Hence move its compatible value to the R-Car Gen4 section.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
