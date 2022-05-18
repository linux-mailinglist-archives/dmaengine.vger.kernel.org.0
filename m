Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7134352B341
	for <lists+dmaengine@lfdr.de>; Wed, 18 May 2022 09:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiERHM5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 May 2022 03:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiERHM4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 May 2022 03:12:56 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C655FD37F
        for <dmaengine@vger.kernel.org>; Wed, 18 May 2022 00:12:54 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h8so1424756ljb.6
        for <dmaengine@vger.kernel.org>; Wed, 18 May 2022 00:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=NveFr5oBdZT2Fkapk4waWiUJsOPRpM4f+u8efBiPzeQ=;
        b=jHCADS67u2w6WRnpiH2hmQWcjZWcwTMZZjEIbjk41nZTH8+Nsr+9N5zM9OcExsaL+Y
         BeAm9bdsVUFE+6qQ1MmIXg1TDc8CxdE8TTYWo70EgZNbJJTqrqKRK43IyaB3tH3U7NF5
         EenS5AdVoX4/m8uzW93oDsVkWRU8MLEvKkOoyjBjtrlGTU3og1dQRnHqJvZPxNDIdUWq
         A30VNj/6Q0WDYvh72IEPo70Hgod0q3+8Ho3/f0wuK2zm8lwq5vT0eQFo4VQ2TXTfPXUz
         5pWI0ooLijSbS3Gi4r5Z4ymhjnRFe8kyfFqwmrkLv9INIhu1f/W15DZ9hZalW3rsuWqM
         AVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NveFr5oBdZT2Fkapk4waWiUJsOPRpM4f+u8efBiPzeQ=;
        b=SBEeOdmkcCdcOwA4EhTdWoKYB6I9Wt67VyKca45eBhx1G3UUD3okoinQ3ZMebgNMOg
         BOu6RhgrcsbDvH4Z5GsbimGwIQCShGKiLHbWLBOaymUXiQv3VVhe3IYfkqNaaltqKBXU
         AxkGwjLLsKLH8MhwxnpNYAOKso2stnSyKCDGIJVHBtm0ovruRGVdACZ30xOk1HKTYj/G
         x8N+ouKzh9kESSdHXpzb59UGH0zUvxdOzO5X1tpgwjy6br/ew+DSO9+kEOcpgDc9eRnS
         h2EMl29skZhsVdf+yJ22SJMak3+QDBXmnd7exFTEYIFffZ9dPMC7E0/X9GbOs3smnH3T
         7gdg==
X-Gm-Message-State: AOAM5328lMbaUkSFEqp6HqS/9MJAVlYW1q6pCse8hL+/IHSUWBFgo2gu
        vS3KGZFTIB5KWCW2p/8jVwficw==
X-Google-Smtp-Source: ABdhPJyoK2bfuMo1CXXcarmkwOAqt7fwbBO3No8og5UbwTMiGQcp9fvBYCPobo/etj3vprsEM4qU5Q==
X-Received: by 2002:a05:651c:23b:b0:24f:1286:c321 with SMTP id z27-20020a05651c023b00b0024f1286c321mr16139121ljn.521.1652857972902;
        Wed, 18 May 2022 00:12:52 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a7-20020ac25207000000b0047255d2110esm122512lfl.61.2022.05.18.00.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 00:12:52 -0700 (PDT)
Message-ID: <a4666047-4c07-a9ca-440f-1735da76c5fa@linaro.org>
Date:   Wed, 18 May 2022 09:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/4] dmaengine: sprd-dma: Remove unneeded ERROR check
 before clk_disable_unprepare
Content-Language: en-US
To:     Wan Jiabing <wanjiabing@vivo.com>, Vinod Koul <vkoul@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220516084139.8864-1-wanjiabing@vivo.com>
 <20220516084139.8864-3-wanjiabing@vivo.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220516084139.8864-3-wanjiabing@vivo.com>
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

On 16/05/2022 10:41, Wan Jiabing wrote:
> clk_disable_unprepare() already checks ERROR by using IS_ERR_OR_NULL.
> Remove unneeded ERROR check for sdev->ashb_clk.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
