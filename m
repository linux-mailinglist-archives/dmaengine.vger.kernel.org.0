Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95051734BAB
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jun 2023 08:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjFSGUJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Jun 2023 02:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjFSGUI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Jun 2023 02:20:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E05CF9
        for <dmaengine@vger.kernel.org>; Sun, 18 Jun 2023 23:20:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9875c2d949eso352680166b.0
        for <dmaengine@vger.kernel.org>; Sun, 18 Jun 2023 23:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687155605; x=1689747605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tafC9rtGrSbEBkVw2li93WM31ICKV4+FzfLVdlGKanI=;
        b=dPEJ0tP8ft0H1Y6IrgmhNyLHFA1WvqVZZG2hYBY7kuva657ir8JkP6vqC/C9nwAVCr
         2BJcmm2GievWjQTyduZNEQyQZvatFFvbf4OkaDsQsZncjQHYYLWLP1lgEZ3i6UyTR+Qz
         1+utCCTUDG5bmyerBPsygBCq8rmhpPSUz3eS5mD+6G8KDzT9SLjcp/38qq4QICgXJi0s
         8o+rISB6M3mb94t3/KNO2RhguHp6fhm4tC8xy2H1rIQe1IvpSU19WGuXGYCQWfmQr1Yg
         WbvHrJfAgH/LYasW+hiBJcdPhcUd1O7CQjPxpUg63AAJvaF478FC5Omeje4yFDXs7kUT
         jkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687155605; x=1689747605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tafC9rtGrSbEBkVw2li93WM31ICKV4+FzfLVdlGKanI=;
        b=DYHoFerUPPnREUhWI8WyY+iVtvdfq8d90Z5w513xZHzZ05JKCB9emou9knTOKMsKZz
         bSsUTz7wfdt0ZGjiMz5QBdQdkzqmh0m3rrZgxKNIySGbDbFq0Dgjamu2gwCoS8v2X3wL
         AllUbyiYROyInhuCPgONfc6ZO1wsKAVW/YCbHXzAp3lGe/3BlkpsJkicAEe9v2sjlLra
         9OZIJZqXXV/uDpTaYCZsTSFWlYX0g+nRgdHRPY8rCOoNiC+lp0UraaFwsM6TXs0xcKxz
         89IeGmQdXyMHRnWEQBgmMyMH45jQJLJWoXYe3zJZwx4Ob3bzoSFGKZ6MiXZwGldWY2Y5
         6stA==
X-Gm-Message-State: AC+VfDyfQh26nYPa5wqcovZCQF3cYr2iuQIcDKtoaKFvDi7NFWsG7H1u
        F/begEdE+5MZp2yLKNFMAtsztQ==
X-Google-Smtp-Source: ACHHUZ6KehvgKkuQMI/k2qKPJ3Tw3gEZpAtv5I2vo/yLXgO7Ks+E178QWppZ+XoZnpUgK2+2/GnRCA==
X-Received: by 2002:a17:907:9810:b0:96f:bcea:df87 with SMTP id ji16-20020a170907981000b0096fbceadf87mr9153893ejc.42.1687155605700;
        Sun, 18 Jun 2023 23:20:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k9-20020a170906128900b00965ffb8407asm14088745ejb.87.2023.06.18.23.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 23:20:05 -0700 (PDT)
Message-ID: <9463188f-b176-c41c-8512-b0255eab27a6@linaro.org>
Date:   Mon, 19 Jun 2023 08:20:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v8 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3
 compatible string
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com,
        vkoul@kernel.org
References: <20230618180925.2350169-1-Frank.Li@nxp.com>
 <20230618180925.2350169-13-Frank.Li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230618180925.2350169-13-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18/06/2023 20:09, Frank Li wrote:
> Extend Freescale eDMA driver bindings to support eDMA3 IP blocks in
> i.MX8QM and i.MX8QXP SoCs. In i.MX93, both eDMA3 and eDMA4 are now.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

