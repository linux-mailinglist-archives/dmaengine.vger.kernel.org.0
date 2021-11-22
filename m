Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95A3459480
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 19:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239879AbhKVSK5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 13:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbhKVSK5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Nov 2021 13:10:57 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52950C061574;
        Mon, 22 Nov 2021 10:07:50 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 13so5661409ljj.11;
        Mon, 22 Nov 2021 10:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=TlT7QEDEVoVqR1uMHZtQsjoaJXJhc4T6ceWBzoyGtaM=;
        b=E2TvTy0wDE6xxBX7mcXCZgcuFXiH+2qi2tV9v+38NAg4inwKz9wmjC33+P3d9gmjLz
         BFNvNzzcE2+JEdoO9ikT1oLAFvwzipONkTTI8qVQfVMSX5h8YB5a1oLUofO9G9R5Z2fr
         kj/4/msvz5Y9lOpl357iUXe6K56/XHLxMriRS6gxzlbm8OBmXq//T0V6N5wep06EpsDd
         gPtQmEXlm8k9mCxlEjauBGeYS47aIw5r1yN5Q+51DxWG5O3njWpqfK+IocT4Rer3rxNw
         e8XM1L5m9nn4xIo5P7KKIML2rRRKguVOhJPx70ndNyAiDu7CKIVS3goGMHoKVIqmnvPx
         AScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=TlT7QEDEVoVqR1uMHZtQsjoaJXJhc4T6ceWBzoyGtaM=;
        b=AfcumeSiycatYZu2zihboYfWdNFzpLFOSnGt+52Du1vePEolvegleeXQ3t1fYWRWPF
         R6wemlhau2L98kbioLUgfBS0hP8KsR+NVwr6Rn469pGcxcpgirBKIWqnr5YopoGxLNSc
         ZYPZifu8g3V9Wn9lfhgTI6gPj+nN6SE7rfdtoI05pVXcBjcTpWYwuI/Dxg6aU9Hpp1ec
         TI5+zkQGzGpkJyK9vIofzqS/B0WItpaB5dQ/vJ5qKRnUxnQeG3kfgRURuqA/IJM9qCvc
         D2KIj/2moIeFHWBp+pAUtvYMllwtBwAHLM/TpI43C3gXjT3r9nG5RHtEO+VnCTSzYqrr
         eqSw==
X-Gm-Message-State: AOAM532JdE2eoNO/bH5zjPRfk2VtrPO7MLd6PkhiPyU1BlxwM2LGJV81
        iXVDHbByo/Xa90YuloHDJPE=
X-Google-Smtp-Source: ABdhPJxD88nkyfyUBOYDBOuN5m4/4EHB+MEbMzubFqP9/JqlfgQWQulOh4gMVeRh2HksgIexK/N7jA==
X-Received: by 2002:a2e:7216:: with SMTP id n22mr53702276ljc.44.1637604468358;
        Mon, 22 Nov 2021 10:07:48 -0800 (PST)
Received: from [10.0.0.115] (91-153-170-164.elisa-laajakaista.fi. [91.153.170.164])
        by smtp.gmail.com with ESMTPSA id m18sm1029044lfj.265.2021.11.22.10.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 10:07:47 -0800 (PST)
Message-ID: <4e11d837-1534-adb7-d902-1d171c3bc0cb@gmail.com>
Date:   Mon, 22 Nov 2021 20:08:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <20211119132315.15901-1-a-govindraju@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH 0/2] J721S2: Add initial support
In-Reply-To: <20211119132315.15901-1-a-govindraju@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Aswath,

On 19/11/2021 15:23, Aswath Govindraju wrote:
> The following series of patches add support for J721S2 SoC.
> 
> Currently, the PSIL source and destination thread IDs for only a few of the
> IPs have been added. The remaning ones will be added as and when they are
> tested.

I would have added the complete map as the hardware is not going to
change (likely), but fine this way as well.

> The following series of patches are dependent on,
> - http://lists.infradead.org/pipermail/linux-arm-kernel/2021-November/697574.html

It is runtime dependency, so not an issue.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Aswath Govindraju (2):
>   dmaengine: ti: k3-udma: Add SoC dependent data for J721S2 SoC
>   drivers: dma: ti: k3-psil: Add support for J721S2
> 
>  drivers/dma/ti/Makefile         |   3 +-
>  drivers/dma/ti/k3-psil-j721s2.c | 167 ++++++++++++++++++++++++++++++++
>  drivers/dma/ti/k3-psil-priv.h   |   1 +
>  drivers/dma/ti/k3-psil.c        |   1 +
>  drivers/dma/ti/k3-udma.c        |   1 +
>  5 files changed, 172 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/dma/ti/k3-psil-j721s2.c
> 

-- 
Péter
