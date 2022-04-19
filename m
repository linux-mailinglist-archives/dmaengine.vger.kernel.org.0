Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB41506864
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 12:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiDSKOX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 06:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350519AbiDSKM2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 06:12:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8938BD3
        for <dmaengine@vger.kernel.org>; Tue, 19 Apr 2022 03:09:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bv19so31862844ejb.6
        for <dmaengine@vger.kernel.org>; Tue, 19 Apr 2022 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=YFDNhide2XsUmvM8LDTWVfeOwV1KO1o2ZUWzKE5/SFk=;
        b=G7EcWbpYoSAE1Lcg+xSOON5dxTvgUD2Cvatu5KLZxziEhw8eZ7euCX8hhBvjFbPwhK
         4se+dIuQNzJefYfAaLJhnTR34wRRUZjdVjUMMFhJsspcddrm3uTXTJUH0DYrfVSurYYW
         detDS7NDqTpiI4zcm/9kgSqk7kbchNED0Lw1OiiKdWDK/y+rqTrs6WwjGFnJHabOOxl3
         mCr4WOEmAgcsQ1/RyRGcEa6wO9wNbfX/pCw7xlNuo1JgmXDEtdrOgfUo6ULqlojWG0i4
         +VX/24ZNb3W5Qw1LMRt1nbx0j8bKlIRx2SX+/LgiQcTs+juP3b+rktTC6oJ34rGGPBEH
         f2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YFDNhide2XsUmvM8LDTWVfeOwV1KO1o2ZUWzKE5/SFk=;
        b=hjbaYSXCml4jwnglt2Q0TGqGlbei+AAzHU999OXcCnzdoj+3a17Neqv335TnhjfyKJ
         7j2c4dsiZ6AFu0UAjmWE7oDNQPOa6oQS9VqgDp3Yp9I7xO9mInua9tjN6+t/YhAd9CEL
         Rpr5hOdvhywIWITLCBuBEaBYKQ9sqH3E4Ir6PlmgKUGLqQA+z9KugjHbadn3BhwPqkzd
         ZjiF04KdMs3V5bogJyzMi5PXvh1mxJdplqgKiVf94bjF2PiXVgirCYV0S/yYVD+9/vCN
         L+uT0ggjM91Jdj0KPc8qQctlUTNJdbpEr5tFG81RAfsr/UJfkAJ9JEtPuyL/4fsx0F0p
         q8ow==
X-Gm-Message-State: AOAM532MMwWkubxnVYQNOyR/LYeQTQiuuAfUBmtpx/qguQNaLR2f0d25
        mVZ1PGgXx7LLEdNjXSDAI8dCuQ==
X-Google-Smtp-Source: ABdhPJwMaBWKax5gcTKNS0foupA/Zto/4d9xR3glykA1o5QTs+rB8WGba9q/yqz8HLsoqqCfAt3N6w==
X-Received: by 2002:a17:906:4cd8:b0:6db:372:c4ba with SMTP id q24-20020a1709064cd800b006db0372c4bamr12385934ejt.57.1650362984517;
        Tue, 19 Apr 2022 03:09:44 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i22-20020a1709063c5600b006e8a8a48baesm5569260ejg.99.2022.04.19.03.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 03:09:42 -0700 (PDT)
Message-ID: <a8c5d574-c050-bbc3-efa6-9b45f5f27524@linaro.org>
Date:   Tue, 19 Apr 2022 12:09:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] riscv: dts: sifive: fu540-c000: align dma node name
 with dtschema
Content-Language: en-US
To:     Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Palmer Debbelt <palmer@sifive.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220318162044.169350-1-krzysztof.kozlowski@canonical.com>
 <20220318162044.169350-2-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220318162044.169350-2-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18/03/2022 17:20, Krzysztof Kozlowski wrote:
> Fixes dtbs_check warnings like:
> 
>   dma@3000000: $nodename:0: 'dma@3000000' does not match '^dma-controller(@.*)?$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Any comments here?

Best regards,
Krzysztof
