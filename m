Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26E6351D32
	for <lists+dmaengine@lfdr.de>; Thu,  1 Apr 2021 20:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbhDAS13 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Apr 2021 14:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238697AbhDASO4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Apr 2021 14:14:56 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB11C0613BA
        for <dmaengine@vger.kernel.org>; Thu,  1 Apr 2021 05:18:43 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c17so1351302pfn.6
        for <dmaengine@vger.kernel.org>; Thu, 01 Apr 2021 05:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=P569iaTbs6O5c4QvqrT8hmFqAirjxm+5X5n/nLel8Hk=;
        b=SdIzob6Rg9lJgd20DviDj66kT6JWmI8l4nn81KpJ8eJKbOQf+fMz0mfbQBEglYad8f
         fq3HjSdtdzSWIN/p0S0HS9WjsO+GP+vRSFNpbm0EgHYOaThKtaXgvbwUTismZa4jJmO4
         OA9p5NKzddeSnnSaadxllyht67NmLCYi7x6ftUNvwU1gdwwPkt2Q0Oa7lQDT0GzLWUIm
         fAlGhXcWinDInv8lB6TeuVoZQwxnVbV/VyQ45oMgv7VcDShjxBXA/QDRyX7igOYD+0I3
         Dq1LcTaVEbC1fuzOBZjTYCKB5jd3SR+8cmazJ/+qigcVNEo3ZZqZeOLaxHhKobsLMApJ
         npTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=P569iaTbs6O5c4QvqrT8hmFqAirjxm+5X5n/nLel8Hk=;
        b=TbDPqPh3+vCxLXK/Oo8Lxqme/xEvGL4QJkq2ImetlaoS53uAEJuUfzmls+ntztXwQd
         Lc+5uUuL0veLZsDF8F5OnVv/qYY9oCdYtm4UjeQZf/NQB7MwsmpQ8SgJV245tTSf3UNm
         iD1eEQNU10iK4KXSaL6wHM8WlUoEsuv3e9v/2TLoasyvzVsKMo1VYVj/UKhypRJ5IWKW
         OizwP4co7QEWJuUqb5enEYTBn2kNzy728irw+YBlH8gRZkXg/D7CfUzhNs/lCnEBSyl7
         dN3HCim0ctXeeN4NtkuG8KXUKje4q44nbu7AkhjinCZaRvHDxcesP1Kn+OMhHzBZU0Tx
         CTWg==
X-Gm-Message-State: AOAM531nnoM4faI4jqBYLm05m/wyJRyug1hWDt7ifl1QOjWS/MQGmaIT
        VnZBp6Yg+41TkRe3u31glkXVcg==
X-Google-Smtp-Source: ABdhPJz8KUHW7fvncKxqlaOv7HvQQN55BF4qVQIjaxSsBq1uiESyP2+Jik4zX8CZhRuMK5Ox7skF+g==
X-Received: by 2002:a65:4887:: with SMTP id n7mr7267201pgs.14.1617279522544;
        Thu, 01 Apr 2021 05:18:42 -0700 (PDT)
Received: from [192.168.11.133] (li1566-229.members.linode.com. [139.162.86.229])
        by smtp.gmail.com with ESMTPSA id i22sm5413134pgj.90.2021.04.01.05.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 05:18:41 -0700 (PDT)
Subject: Re: [PATCH v2] dmaengine: k3dma: use the correct HiSilicon copyright
To:     Hao Fang <fanghao11@huawei.com>, vkoul@kernel.org,
        mchehab@kernel.org, dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, prime.zeng@hisilicon.com
References: <1617277820-26971-1-git-send-email-fanghao11@huawei.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <8091f42c-755d-c412-bb1d-b723d887bf43@linaro.org>
Date:   Thu, 1 Apr 2021 20:18:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617277820-26971-1-git-send-email-fanghao11@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2021/4/1 下午7:50, Hao Fang wrote:
> s/Hisilicon/HiSilicon/g.
> It should use capital S, according to the official website.
>
> Signed-off-by: Hao Fang <fanghao11@huawei.com>

Thanks for the patch.

Acked-by:  Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
> V2:
>   -remove the terms of use link.
> ---
>   drivers/dma/k3dma.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
> index d0b2e60..ecdaada9 100644
> --- a/drivers/dma/k3dma.c
> +++ b/drivers/dma/k3dma.c
> @@ -1,7 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Copyright (c) 2013 - 2015 Linaro Ltd.
> - * Copyright (c) 2013 Hisilicon Limited.
> + * Copyright (c) 2013 HiSilicon Limited.
>    */
>   #include <linux/sched.h>
>   #include <linux/device.h>
> @@ -1039,6 +1039,6 @@ static struct platform_driver k3_pdma_driver = {
>   
>   module_platform_driver(k3_pdma_driver);
>   
> -MODULE_DESCRIPTION("Hisilicon k3 DMA Driver");
> +MODULE_DESCRIPTION("HiSilicon k3 DMA Driver");
>   MODULE_ALIAS("platform:k3dma");
>   MODULE_LICENSE("GPL v2");

