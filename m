Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA9B53A23D
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jun 2022 12:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351945AbiFAKNx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jun 2022 06:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351898AbiFAKNt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jun 2022 06:13:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEFD4C790
        for <dmaengine@vger.kernel.org>; Wed,  1 Jun 2022 03:13:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w27so1483870edl.7
        for <dmaengine@vger.kernel.org>; Wed, 01 Jun 2022 03:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AlvALx0zMnGDVnEapBQ7KHJlm9HnZCeBAZQY2Z7YIfQ=;
        b=MyCjNSjG2AHbNB2hBMdKLs7JyeIE2MU21L7NxYzqYkgJshTjTAEE3mD+wxlpLMSZa1
         6kCgUApP3XMk/l0RKFbqTKkRmn+B8M5eZoQ9wj6leLnRPShsmt0NiHxg5OAui/Wjj4iJ
         i4vfSEUecvq6/DBHNM7UiaodK0JQQ7g3UoEYaWKtumlj0/PvIpngsENEmCTNfzM89Tb9
         QkF+JF2c2z/S4FXGch+hlLzAcJGTiwGowPWEiaeRIqEt7wYuCN7+DXZTH5/EvCioiExI
         p4j/Ly9/9+f7IV1cf8EFCHLLNIAVtSW+2Z8+zxv26svn+bQyu09y+iFILQTj/RvG+YQl
         /OJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AlvALx0zMnGDVnEapBQ7KHJlm9HnZCeBAZQY2Z7YIfQ=;
        b=BM9/JEFUyUZsOfx/O9j2cJ6GfMSdEKAW2DYSLhyGpoCFxGfDZ5u/l9vH6kTRObn/01
         vsOHR5O1g/vfaQeCrWgdsVuplb59Rr64IwLEAziGDcaaW8ggExD2jp4QlppXGTGu6u4r
         t/w7gehXOjL1TPUoKCBpldcLB4Af8fD3or098VPaV+fo22JovKuxowO+taevPiA73uuj
         btOMXl3mmp5cTr3a3+FhisvuON033ms63rdyglfA+GUF5K90FTVxnjXHYVWUM6YKTJMa
         eXGSMg+q7t+Ap0U21Qk79wmrHXu5uhUnqqC6C8u4iXh+q/PHeMuz4XGZUBwNHWpyRptD
         jw3g==
X-Gm-Message-State: AOAM531szXfk7YU4laWzgWY7Y2CGE3X2j6up/16NJRVVwzKBpoxiQp4h
        KFEF2ip4Ed9Z6r2ypqrcv9gOaQ==
X-Google-Smtp-Source: ABdhPJx/6T0uvLJqvrWkeIA6nNBw+V6b78iDiCeD1eckOus4w0IQXWKCNYVm2nBgb3y+6PpRaLcMOw==
X-Received: by 2002:a05:6402:51c9:b0:42b:63c2:6657 with SMTP id r9-20020a05640251c900b0042b63c26657mr51960414edd.255.1654078425689;
        Wed, 01 Jun 2022 03:13:45 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p5-20020aa7cc85000000b0042bb1e2e2f7sm716587edt.8.2022.06.01.03.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 03:13:44 -0700 (PDT)
Message-ID: <44798b51-1410-d1db-3c53-0a90beb714ea@linaro.org>
Date:   Wed, 1 Jun 2022 12:13:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 12/17] dt-bindings: phy: mediatek,tphy: add MT8365 SoC
 bindings
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        qii.wang@mediatek.com, matthias.bgg@gmail.com, jic23@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, chunfeng.yun@mediatek.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20220531135026.238475-1-fparent@baylibre.com>
 <20220531135026.238475-13-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531135026.238475-13-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31/05/2022 15:50, Fabien Parent wrote:
> Add binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
