Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB92D372BD4
	for <lists+dmaengine@lfdr.de>; Tue,  4 May 2021 16:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhEDOSi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 May 2021 10:18:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45556 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhEDOSi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 May 2021 10:18:38 -0400
Received: from mail-qt1-f197.google.com ([209.85.160.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1ldvrq-0003qn-55
        for dmaengine@vger.kernel.org; Tue, 04 May 2021 14:17:42 +0000
Received: by mail-qt1-f197.google.com with SMTP id d16-20020ac811900000b02901bbebf64663so3629096qtj.14
        for <dmaengine@vger.kernel.org>; Tue, 04 May 2021 07:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Mdj10uq8YyfvX11RWMMGRr3/VZzdY5+rc9TfTZ6UC8=;
        b=oW06OfSUN6JGLpbs7neSbbqkqBbCZJT5KYer4Ixi0/3j8+5DH5lYKa4F0rxJeuKJ5S
         Zyxz/jLxDcR2/b0ONlvQS4FjmTrZKg0IQVowiidKSIqwgsU5jqjMu/rVKpErbFQMqYnb
         //x6Mso6Mf3cChIOvVWw3zRgHU6SJFB72ITHYLe200ojXRWSrwRgegzoYOYd+m2in5Hf
         cYRekvkvvzUUAlJntgcfyfNPg0n00hfqhLmBTnkhv21L/Uv9OydFpsQlqGqxQjEZjDwl
         6nGiIkshpiNVNFKEb0t95vSRjw6iaJzgpZ62Qw3t0owAMbQfLlC9p+oK1RuNBRfHGmq1
         VMbw==
X-Gm-Message-State: AOAM530ly7Bde2X2+DqCaZWVbN6M011eHC0UW2Lac8tYxbmonvzfHzOG
        EZf4O3BUs02LHA5IhAjU8+Bh6AC75PK4bpUzp4X+aNdBL4oj282ZhP9Yfww4eCuuXIyG//sJC1w
        zaSS+1SgdYIvKGOUlZZLjkmEP+NVEZ/L3ERbGOw==
X-Received: by 2002:ac8:60c8:: with SMTP id i8mr22133286qtm.63.1620137861282;
        Tue, 04 May 2021 07:17:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBXSkZplOQFMqdOcrYIdibKIXwCDSIkqvwhTWqybS/PTYVBzFw35eerGZalnS6j+Q4dZ10Fg==
X-Received: by 2002:ac8:60c8:: with SMTP id i8mr22133258qtm.63.1620137861031;
        Tue, 04 May 2021 07:17:41 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.49.3])
        by smtp.gmail.com with ESMTPSA id y13sm1047947qkj.84.2021.05.04.07.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 07:17:40 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] memory: Add support for MediaTek External Memory
 Interface driver
To:     EastL Lee <EastL.Lee@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        matthias.bgg@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com, cc.hwang@mediatek.com,
        joane.wang@mediatek.com, adrian-cj.hung@mediatek.com
References: <1611746924-12287-1-git-send-email-EastL.Lee@mediatek.com>
 <1611746924-12287-2-git-send-email-EastL.Lee@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <2cf92fc2-ccac-312f-f4a6-9a4dfd9aee9c@canonical.com>
Date:   Tue, 4 May 2021 10:15:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1611746924-12287-2-git-send-email-EastL.Lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27/01/2021 07:28, EastL Lee wrote:
> MediaTek External Memory Interface(emi) on MT6779 SoC controls all the
> transitions from master to dram, there are emi-cen & emi-mpu drivers.
> 
> emi-cen driver provides phy addr to dram rank, bank, column and other
> information, as well as the currently used dram channel number, rank
> number, rank size.
> 
> emi-mpu (memory protect unit) driver provides an interface to set emi
> regions, need to enter the secure world setting and the violation irq
> isr will collect mpu violation information, after all regions have
> protected their respective regions, emi-mpu will set the ap region to
> protect all the remaining dram.
> 
> Signed-off-by: EastL Lee <EastL.Lee@mediatek.com>
> ---
>  drivers/memory/Kconfig                   |    1 +
>  drivers/memory/Makefile                  |    1 +
>  drivers/memory/mediatek/Kconfig          |   23 +
>  drivers/memory/mediatek/Makefile         |    4 +
>  drivers/memory/mediatek/emi-cen.c        | 1305 ++++++++++++++++++++++++++++++
>  drivers/memory/mediatek/emi-mpu.c        |  908 +++++++++++++++++++++
>  include/linux/soc/mediatek/mtk_sip_svc.h |    3 +
>  include/soc/mediatek/emi.h               |  101 +++
>  8 files changed, 2346 insertions(+)
>  create mode 100644 drivers/memory/mediatek/Kconfig
>  create mode 100644 drivers/memory/mediatek/Makefile
>  create mode 100644 drivers/memory/mediatek/emi-cen.c
>  create mode 100644 drivers/memory/mediatek/emi-mpu.c
>  create mode 100644 include/soc/mediatek/emi.h
> 

Use scripts/get_maintainers.pl to get list of people you need to Cc.

Run checkpatch, smatch, sparse and coccinelle on your new driver. I can
easily see that some of these steps were missing (e.g. OWNER field...).

Best regards,
Krzysztof
