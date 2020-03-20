Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE3F18D0A0
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2020 15:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgCTOZJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Mar 2020 10:25:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41639 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgCTOZJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Mar 2020 10:25:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id o10so6585467ljc.8;
        Fri, 20 Mar 2020 07:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T5wfsqz6NA4nBgSyE/y834Ip5hf7e671S0Q1nH1Qsz4=;
        b=JmJ7iATzKnqammFAuQ9z796W5nzypoWTbGhkE/TubpvYzYTS4aVWgssszGYtYq0jv6
         ljRG56Ujk4JgnOYdUrbxf3tmTGTUA4hiIONYi/SLmnRb8dnt7Pjtffz3H+CBw59XSJaL
         JAACc2yqJ21Gwhf9NYjWbNVS6BvKadFjwMneOwk0YlqC05GkOfSuCt9DbLX0kTDB8Moz
         oh8tKrgmN9OTzk3P9oF2wbXJDTYWZ20Ao8nfuS4Sf74tsPzj5gGi8KJUgpysyYuJSXk6
         XT1lwOI81as1r78dEBNYq0p3ZcLky42f4FYn9ic1n91Rjbd1XXH6tRpPFO0Gy/SifOQX
         xFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T5wfsqz6NA4nBgSyE/y834Ip5hf7e671S0Q1nH1Qsz4=;
        b=IyFreTd82NYz7zwsY61xXQCBSTUepyn9QZPyRH5neqBXtMEX4MYAlShx6GSziKqv5Q
         0AZd/7EQ/5GPJdeO44f+sxKzLgODTDmdp4O/5DEqyBtEpy1qt5m6A6oxFUMlNvHpkp9r
         B7+RCaa7S0Z+SXsNGb5NapZTnI19T5tbxMSFpxK9disGJKXspeGBZTgpZiJMDvhlvSL9
         k59QwOe2yfSQgE+IJvDoOcVk6Y6jpeYUURWThM5MNsO7ySBPKkUuxKhN3GXyOaMJRJG2
         qIozkUmx5eulRanpwHJW2qoCz4Y5dGfoSG+o47yymS6HvWR17RxNDxNwCwHAhnYtodsY
         3d1g==
X-Gm-Message-State: ANhLgQ0KES9hoLQWDpnAHylJJs82MkqAn2yXkDfJg0igtPJZ34pm2k0l
        C68kNF1MCcYNtKLlMU/rUh8b9/lK
X-Google-Smtp-Source: ADFU+vugH/QD6QmdOmcFHW6Fzz2Le5mDW7RVs1mxnFOgC0mXoPuKWf4SNE2O75XiwQ0sx6lmjSZftg==
X-Received: by 2002:a2e:99ca:: with SMTP id l10mr5410105ljj.13.1584714306182;
        Fri, 20 Mar 2020 07:25:06 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id t23sm3102570lfq.90.2020.03.20.07.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 07:25:05 -0700 (PDT)
Subject: Re: [PATCH -next] dmaengine: tegra-apb: mark PM functions as
 __maybe_unused
To:     YueHaibing <yuehaibing@huawei.com>, ldewangan@nvidia.com,
        jonathanh@nvidia.com, dan.j.williams@intel.com, vkoul@kernel.org,
        thierry.reding@gmail.com, swarren@wwwdotorg.org
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200320071337.59756-1-yuehaibing@huawei.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8d60faa5-2749-0581-7ee5-252f15b0e9cf@gmail.com>
Date:   Fri, 20 Mar 2020 17:25:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320071337.59756-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

20.03.2020 10:13, YueHaibing пишет:
> When CONFIG_PM is disabled, gcc warning this:
> 
> drivers/dma/tegra20-apb-dma.c:1587:12: warning: 'tegra_dma_runtime_resume' defined but not used [-Wunused-function]
> drivers/dma/tegra20-apb-dma.c:1578:12: warning: 'tegra_dma_runtime_suspend' defined but not used [-Wunused-function]
> 
> Make it as __maybe_unused to fix the warnings,
> also remove unneeded function declarations.
> 
> Fixes: ec8a1586780c ("dma: tegra: add dmaengine based dma driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
...

Looks good, thank you:

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
