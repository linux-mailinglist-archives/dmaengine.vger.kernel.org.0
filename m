Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AF753A071
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jun 2022 11:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351051AbiFAJcO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jun 2022 05:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351079AbiFAJcL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jun 2022 05:32:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975A987201
        for <dmaengine@vger.kernel.org>; Wed,  1 Jun 2022 02:32:09 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z7so1321870edm.13
        for <dmaengine@vger.kernel.org>; Wed, 01 Jun 2022 02:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9rLHj//9k/15fypiFbMELs3ChxXWRGpeQMJrEmUMxUs=;
        b=QIpbmzzYJ0HAltV9KIinq7hcn1/hnXtpRXtMmZG9J7qu9J+yvPLSDMoa7T1mF07mXK
         H0apr2OZxGQd0U1WCKeMv8lb+Fm0H/mDYSMtRdWizypZAKluo8iAZmIxB1zzo1cgkxVD
         8FqROBoannHWns4ltnEoaFMetuFzZVnMg34x8TBZHDiL1S+h+agEWmJXOJBPr45zEleE
         wIN4pLzhGLnCkSJ6swE6lcLnjUX895KzSJg8xs9oTGRBgvcXRQgxWZs0dfq2tVdBw1lA
         e+iovxTxiCiSptWs6zjF6xpsc90sU1LjwN9TwlBSRUrniu3cN+/+/2A8nwrc4UNO1Pv1
         qyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9rLHj//9k/15fypiFbMELs3ChxXWRGpeQMJrEmUMxUs=;
        b=aTkiMar2H4J1L4AQHVdkmhCIDn/J+uNg3t8NOK5Cd2iZwxBVMNLmkQ/3UqBZarjG4B
         1t/OjFAxgI1bM8CuBplrRRCpu+EFtLdAlfrPooDQtpkMnGiRpz9FWCelqJgavrARDRKk
         cY8jOZxXo6nzAoyYyg2rnaeLVFbn+jiNgbXWlTGkeOjTsmOFkxtmj1Ub9hZ9s7zIryVS
         60Y1TlTlDOy/v0hA0bLOqm4Jei50UY9lNDqAa2nY3llq3T9xPQYFFHy7Em4zySZI1Hg+
         Z7eDeMx3PxX8x/twnS7vDI+m5u4tTxGwLrTV9UgcjClP1/QiuEyn6l7/HyZ7lSOWSrJG
         9FPw==
X-Gm-Message-State: AOAM530symR99q5V8yZWngzaYlQoaHV0CDf9Cv0mHCtRlcS7CoyQpMHV
        gO4avnY/XbZoa+WMsX+2cSJMFw==
X-Google-Smtp-Source: ABdhPJxIaNQdmdCizYbGGHKjK+me0jgNnS5X6cMWDDf2h3DFwSO74zQhHh65gXy+skv8i/8hh9yGoQ==
X-Received: by 2002:a05:6402:e9f:b0:41c:df21:b113 with SMTP id h31-20020a0564020e9f00b0041cdf21b113mr69039921eda.217.1654075928172;
        Wed, 01 Jun 2022 02:32:08 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i23-20020a1709061e5700b00708a2ae7620sm102525ejj.67.2022.06.01.02.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 02:32:07 -0700 (PDT)
Message-ID: <efdbb151-8213-d1e7-a935-0e857947d450@linaro.org>
Date:   Wed, 1 Jun 2022 11:32:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 00/17] Add support for MT8365 EVK board
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        qii.wang@mediatek.com, matthias.bgg@gmail.com, jic23@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, chunfeng.yun@mediatek.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20220531135026.238475-1-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531135026.238475-1-fparent@baylibre.com>
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
> This patch series adds support for the MT8365 EVK board.
> 
> This series has dependencies on the following series:
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=646256
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=646091
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=646083
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=646081
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=646076
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=646068
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=646020
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=646052
> https://lore.kernel.org/r/20220504091923.2219-2-rex-bc.chen@mediatek.com 
> https://lore.kernel.org/r/20220512062622.31484-2-chunfeng.yun@mediatek.com 
> https://lore.kernel.org/r/20220512062622.31484-1-chunfeng.yun@mediatek.com
> https://lore.kernel.org/r/20220524115019.97246-1-angelogioacchino.delregno@collabora.com
> https://lore.kernel.org/all/20220127015857.9868-1-biao.huang@mediatek.com/

Eh... and how we are supposed to test or apply this? Such dependencies
could mean none of automated tools will pick it up, so your patchset has
to wait till dependencies got merged.


Best regards,
Krzysztof
