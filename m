Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ED452B313
	for <lists+dmaengine@lfdr.de>; Wed, 18 May 2022 09:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiERHKs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 May 2022 03:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiERHKn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 May 2022 03:10:43 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DE413E
        for <dmaengine@vger.kernel.org>; Wed, 18 May 2022 00:10:40 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l19so1415483ljb.7
        for <dmaengine@vger.kernel.org>; Wed, 18 May 2022 00:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=3Y8OJ4m37PdLh73LbFGI/TuzXq1G8Ucqe1McDv0L7Qw=;
        b=JlRL3HITVZDBdmopILmaqrXqcydYXnTFfA0RbaXJbD2R6mI4kpyWHi65gSQko9aprB
         P9nxJK3bJt+ZO8+d4WtIfXXIvuo4d7cWHXS7ZUi/Rn0pSKMQm/z49nWk2Z1p2kpDWzeb
         eY6Rt7EVpZNbMZMl1UWOZY4k5Fdck5a9n+YZLC/hj39z9iA6iFsnWAgP0Mn0KI2uyBH0
         HFeAnEI3f5QaXorFlyvUUbGWWeuJFgoNVWPl+YQr2P1ANzlOfIWnXpLpXO7JiT+lmDMW
         i7e0reIrs4BWnUZgPOdTN/uRTK+JG6M0PcTz0DGkyfyByHp17nbfFEFUdRrjlmFdwwHW
         Gmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3Y8OJ4m37PdLh73LbFGI/TuzXq1G8Ucqe1McDv0L7Qw=;
        b=BC+3bf6f690eO4h7WT7dJ1OdmKakgXRI9vL1DjP9hYqqlNYNx1gvB4nutbqMFh7IF3
         K1yADhIv7M4GDO8ZlaYOAAHI1DPAizU/jhqzroYqt6heGYRyGKg+xrYru12040jsmCOJ
         xVpDOlsV8gcaipu02kv2xG5uL25hLPmKoKCLzcdtv373sl1s56/mRkH6R95mO4/SvF+c
         ITMORsZBVPjhD4qWipk1A+UlKWSUJSneTjRt6muUzWgLnBXtK7wfKSrOX8R+8ai5T/nq
         YXrTiRr49Mw4USwe51RFjd1PqKnH7Oij9T9bGLFbYPb4VkfdiguQR/za4IUfhT3oyK9j
         v69A==
X-Gm-Message-State: AOAM533YBCsU5hhQrw0QvK5X+FcNG6rITGML0V4+VFBF3PWKxMToeHsy
        3fIE/z6P+7Id/Uc0vSu0Q4RQYA==
X-Google-Smtp-Source: ABdhPJzj42Ts+E0zWJxIYpaHRi4UHdNOsl6Cqe1/VeyvP4ZMGYSeJJ1PRrAkfVQTPLuuDvkN9oZcOQ==
X-Received: by 2002:a05:651c:a11:b0:250:5da4:e7b1 with SMTP id k17-20020a05651c0a1100b002505da4e7b1mr16453099ljq.268.1652857838821;
        Wed, 18 May 2022 00:10:38 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a12-20020a056512020c00b0047255d2115asm118471lfo.137.2022.05.18.00.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 00:10:38 -0700 (PDT)
Message-ID: <47f84a32-18e1-5612-b95c-607e2f19f9d8@linaro.org>
Date:   Wed, 18 May 2022 09:10:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/4] dmaengine: sprd-dma: Remove unneeded ERROR check
 before clk_disable_unprepare
Content-Language: en-US
To:     Jiabing Wan <wanjiabing@vivo.com>, Vinod Koul <vkoul@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220516084139.8864-1-wanjiabing@vivo.com>
 <20220516084139.8864-3-wanjiabing@vivo.com>
 <214de163-d576-d9be-76f2-3b70eefd6e68@linaro.org>
 <b0438374-ff82-e74f-0b83-e0f2b4a99e36@vivo.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b0438374-ff82-e74f-0b83-e0f2b4a99e36@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18/05/2022 04:44, Jiabing Wan wrote:
> Hi,
> 
> On 2022/5/17 23:13, Krzysztof Kozlowski wrote:
>> On 16/05/2022 10:41, Wan Jiabing wrote:
>>> clk_disable_unprepare() already checks ERROR by using IS_ERR_OR_NULL.
>> Hmm, maybe I am looking at different sources, but which commit
>> introduced IS_ERR_OR_NULL() check? Where is it in the sources?
>>
> In commit 4dff95dc9477a, IS_ERR_OR_NULL check is added in clk_disable() 
> and clk_unprepare().
> And clk_disable_unprepare() just calls clk_disable() and clk_unprepare():

Thank you, indeed, I was mislead a bit by clk_prepare() which is not
symmetric.



Best regards,
Krzysztof
