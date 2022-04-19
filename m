Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835C4506920
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 12:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbiDSKxQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 06:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiDSKxP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 06:53:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710F31DA58
        for <dmaengine@vger.kernel.org>; Tue, 19 Apr 2022 03:50:33 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ks6so32076695ejb.1
        for <dmaengine@vger.kernel.org>; Tue, 19 Apr 2022 03:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=w+d5k9uYrV/mLnQrr6AQlftFm+YXx1KXlurBj9TWsts=;
        b=l2hY6zRJYTlYzxQWJVxq8tyk+CtJ8aaMIXKFXpdSPTDUIOH05e0Nf5Iq853sKcV5Bw
         r6DI/mZJLjGwRSVt+YD0tGXRaCRdHfCkwp/hARmTAFFhF8AqWbrVQkt0wPk8YyZvLShO
         Ehk3b6TNNdeddHWmW4ayzjleA6AyGe072e6zm81kZD5u0K5A11AV4GeLiskEFvWK6fe7
         CAnVqPbmDSMdynb0NRJhV30+sNviLUky7bsJK7RR66p2XQoEUYwhXgqNFl8jQiELgBnr
         8baoYZJfVzwFcpXqJZkUeg1WjwGlKvzUkivpaDzh04t+9BxsoYLWm1XA3Hfp5uPufK9n
         k0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w+d5k9uYrV/mLnQrr6AQlftFm+YXx1KXlurBj9TWsts=;
        b=mp9cHvyHf4cD2IiYDaOArGguFw+pn3Xlg86qnKFjUP9DFS/hvME6F+yL+XQRLR7ilF
         Lplt+R30DKMYSquGbHeWix1QJFWCwXbWgb+KmDZIpuudCLZxsFMbEucTQihfgZOONcMr
         7INY1/c7E5Wox/kLFz5WUoWrcLLNpVuvJYK+XYZfICZobtYKNFO3UMYat76G9/BbSbCU
         2ymLTnUUyM6lrciQ0zck96Ln9ugPFe68mZ/9RSYk6xvl6bM/VWZvzQXa8I/plPrnG0Es
         F3Nr1X6pgot5o1Ra+AjD6rMgbuuLpg/vHPGHvAZCujVrUsCNMEQ0AOeJV34E2IXCKvYo
         airA==
X-Gm-Message-State: AOAM531oa6596xZhXpQCuK7XmZ3PevXKZBFJpOxMisxpfv3McbuOhp3v
        4vAuVUXPdSgj7R7+MvCz+xx4pw==
X-Google-Smtp-Source: ABdhPJx//g0J1c/q+Rwp9k4kcLsrxd0rEpwj7RyG/molhBtmMVF+qc+kBDToiG5Ykgh3IIj4H+2Saw==
X-Received: by 2002:a17:907:3f25:b0:6b0:5e9a:83 with SMTP id hq37-20020a1709073f2500b006b05e9a0083mr13264223ejc.659.1650365431989;
        Tue, 19 Apr 2022 03:50:31 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p2-20020a056402154200b0042323822e15sm5735925edx.74.2022.04.19.03.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 03:50:31 -0700 (PDT)
Message-ID: <61923e45-6594-6dfc-5e2f-e808af99e7c1@linaro.org>
Date:   Tue, 19 Apr 2022 12:50:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] riscv: dts: sifive: fu540-c000: align dma node name
 with dtschema
Content-Language: en-US
To:     Conor.Dooley@microchip.com, green.wan@sifive.com, vkoul@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, geert@linux-m68k.org,
        alexandre.ghiti@canonical.com, palmer@sifive.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220318162044.169350-1-krzysztof.kozlowski@canonical.com>
 <20220318162044.169350-2-krzysztof.kozlowski@canonical.com>
 <a8c5d574-c050-bbc3-efa6-9b45f5f27524@linaro.org>
 <03e28a55-d3bd-f3e1-f418-557306d65505@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <03e28a55-d3bd-f3e1-f418-557306d65505@microchip.com>
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

On 19/04/2022 12:45, Conor.Dooley@microchip.com wrote:
> On 19/04/2022 10:09, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 18/03/2022 17:20, Krzysztof Kozlowski wrote:
>>> Fixes dtbs_check warnings like:
>>>
>>>    dma@3000000: $nodename:0: 'dma@3000000' does not match '^dma-controller(@.*)?$'
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>> ---
>>>   arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Any comments here?
> 
> Not sure that this one is actually needed Krzysztof, Zong Li has a fix
> for this in his series of fixes for the sifive pdma:
> https://lore.kernel.org/linux-riscv/edd72c0cca1ebceddc032ff6ec2284e3f48c5ad3.1648461096.git.zong.li@sifive.com/
> 
> Maybe you could add your review to his version?

Zong's Li patch was sent 10 days after my patch... [1] Why riscv DTS
patches take so much time to pick up?

[1]
https://lore.kernel.org/linux-devicetree/20220318162044.169350-2-krzysztof.kozlowski@canonical.com/


Best regards,
Krzysztof
