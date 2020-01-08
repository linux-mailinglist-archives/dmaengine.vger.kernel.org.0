Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66DD11345D7
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jan 2020 16:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgAHPKe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Jan 2020 10:10:34 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37269 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgAHPKe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Jan 2020 10:10:34 -0500
Received: by mail-lj1-f194.google.com with SMTP id o13so3687920ljg.4;
        Wed, 08 Jan 2020 07:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8N6auOkOUI9EBQePB/gLYAhFAr4sHXqpFT+qTfELYHM=;
        b=biuLjm7aMHQWJyjiDU1z8tHxoz2PkBpj3EllPwynYOXp3U1b25Y37N3fL9m7uYZBYJ
         wJpmwVJne4XkIWn42w+2OG0Of24f3SMqDKrqnwRsXzkZAHWc8WWb2+MDv+E+vrb0zg07
         Cz02hrb27HfQxgHSFsmPGfhRIQTZ1xOKgl5wAyQXEyTT2qK+IZVCHyHLefop8tfRJR3v
         6uybFPww8NPheKBFGyGvMD9jmxfFxDX+kh5R7bomsX+oWTiD2lZF2eDYSDOWCpdkIAxe
         io9hazK7DVZGv3sT7COO7Zr0nVDeLo4VrgFN8IHWwcOvqb0efqHNe7W3FHx3xiqNdzgO
         fxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8N6auOkOUI9EBQePB/gLYAhFAr4sHXqpFT+qTfELYHM=;
        b=sIjdA926Gyk9YmhZa1uyxRipN8Qr0qGSHhfmIJkN+oYYfntZg4x9n53FFBHYvaKjTb
         rbSxa7q0cuAaNlzzgjFuqb3MDRRojM/woJGOvjUg28O9jKyapTzk2rsdRX47/QS29ey1
         2TspNE4TaNxXR11oI5lGxksqj2LuMdrXpurBoUeC8+2B9Dq/v55oMrNm0smHqGTOU0Ot
         4M+d734LcZvdAns30KodVxnRCCdgO3L2VdkwXGx4MZkaunu3s1GA75J6U4nnPj7dWh/O
         Wc8kbG7EDUHi9QwsVE2lt+W6+9cPdtpnrHVf3qomEXxJD4k07k91+Q0agj0sgE84Nvk+
         b/Uw==
X-Gm-Message-State: APjAAAXwsv/dwhsRmaKNg5dm2aCILuBmW3hRyEYGuuPvSU90P1Vk8CYy
        gTOCXOw/8erqAs+703Bx2X8YVjE1
X-Google-Smtp-Source: APXvYqxxccz+shxx6y4OUo6Cf2u0jOQFiHInlXXrdSYyWuxBoQ7/f9jW62bqg8Lu1WdVGt+EXIU3sg==
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr3162824ljo.41.1578496231767;
        Wed, 08 Jan 2020 07:10:31 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id r26sm1512029lfm.82.2020.01.08.07.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 07:10:31 -0800 (PST)
Subject: Re: [PATCH v3 09/13] dmaengine: tegra-apb: Remove runtime PM usage
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200106011708.7463-1-digetx@gmail.com>
 <20200106011708.7463-10-digetx@gmail.com>
 <f63a68cf-bb9d-0e79-23f3-233fc97ca6f9@nvidia.com>
 <fd6215ac-a646-4e13-ee22-e815a69cd099@gmail.com>
 <01660250-0489-870a-6f0e-d74c5041e8e3@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c077c687-57dc-c33f-f434-57918492c789@gmail.com>
Date:   Wed, 8 Jan 2020 18:10:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <01660250-0489-870a-6f0e-d74c5041e8e3@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

07.01.2020 21:38, Jon Hunter пишет:
> 
> On 07/01/2020 17:12, Dmitry Osipenko wrote:
>> 07.01.2020 18:13, Jon Hunter пишет:
>>>
>>> On 06/01/2020 01:17, Dmitry Osipenko wrote:
>>>> There is no benefit from runtime PM usage for the APB DMA driver because
>>>> it enables clock at the time of channel's allocation and thus clock stays
>>>> enabled all the time in practice, secondly there is benefit from manually
>>>> disabled clock because hardware auto-gates it during idle by itself.
>>>
>>> This assumes that the channel is allocated during a driver
>>> initialisation. That may not always be the case. I believe audio is one
>>> case where channels are requested at the start of audio playback.
>>
>> At least serial, I2C, SPI and T20 FUSE are permanently keeping channels
>> allocated, thus audio is an exception here. I don't think that it's
>> practical to assume that there is a real-world use-case where audio
>> driver is the only active DMA client.
>>
>> The benefits of gating the DMA clock are also dim, do you have any
>> power-consumption numbers that show that it's really worth to care about
>> the clock-gating?
> 
> No, but at the same time, I really don't see the point in this. In fact,
> I think it is a step backwards. If we wanted to only enable clocks while
> DMA channels are active we could. So I request you drop this.

I'll take a look at making RPM active only during the time of DMA
activity, otherwise it's pretty much a dead code as it is now.
