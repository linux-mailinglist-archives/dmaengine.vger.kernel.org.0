Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E474714E083
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 19:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgA3SHA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 13:07:00 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42107 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgA3SG7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 13:06:59 -0500
Received: by mail-ed1-f68.google.com with SMTP id e10so4784797edv.9;
        Thu, 30 Jan 2020 10:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PURvTDGkSUrDj2LTVpV8Pg+XWaCpz3NX1Q3N4hEZo/g=;
        b=PfrMRVU88Ynk9ecNRVarMgND4d2dO9ve3f3J1jIFfGfkAdOh9jpqZXLQccHJvT/nuv
         HuPKXtSXx9pGanGx5ip8p2iIbc6yBKUR8Qz7S5++RZJYpLzi05KjN3ZCfmHHZLrOFkX5
         DCfTHG2a/F2EaXD2nO+2LhL3oE7F17KRagiA8anNWVB/q16ug7ACi4zgBEkM3Nsxu1fb
         C19si/PjDmhp0rpZQ2uFflFCbcp6n2ThIECJsze6U3NY6/nMUEVg/oGnFarRymIe29I3
         zrrq4Q9rnwrmB3KRHYRHLsNotnYRQZgHCNrVzqk184agbgs4N+4Dxeuprnjm8txnLXCT
         xevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PURvTDGkSUrDj2LTVpV8Pg+XWaCpz3NX1Q3N4hEZo/g=;
        b=CehDIzxQtDaBL5wlE6DeeBt2I3xxwJJT4CTu/D7ozZYytA+J+xFEJBh2TTeDHKH+3E
         HuAMSaf0HpBynir9vj/uBqV1VusT5OG+grQAXmu4PQBnW/aKka52xP4NVHLlOtq5PYcd
         w+yW6CDxHeQt/1qh17jPghQawcF0Jqb/vWe6+bvk0w+yQevFwxt3NvECX3+rz3kHorzD
         Vos2Sm7V3KSLd3oKGb/ptN766ppvtgYAbSgxGoytZbATLHb6S9SeLABgvg/wUPkM4NyD
         BqF9XqJOaPJpxZb9mma2gZ30Lt1792Uk5vwTPm18jETe2vG4YOfq1BmVLUV108/2nfHT
         7qNA==
X-Gm-Message-State: APjAAAXaxrdzpjdC78IJO45bBDnOEQJoTqfrKlkoqWy6P2T2h/67yfOY
        VuAEfUMKfDGFYYvxobiz/g09kSqV
X-Google-Smtp-Source: APXvYqzQtdMHNoz9NGUXQgCFiYz6koywyqCcsEXonvw+WVWbRJ4sIcU921NBiEhESaCve9uzS1sMZA==
X-Received: by 2002:aa7:d856:: with SMTP id f22mr4739788eds.61.1580407617256;
        Thu, 30 Jan 2020 10:06:57 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id e24sm458269edy.93.2020.01.30.10.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 10:06:56 -0800 (PST)
Subject: Re: [PATCH v6 12/16] dmaengine: tegra-apb: Clean up suspend-resume
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200130043804.32243-1-digetx@gmail.com>
 <20200130043804.32243-13-digetx@gmail.com>
 <e787bee2-4b52-1643-b3a5-8c4e70f6fdca@nvidia.com>
 <394014f3-011a-d6b6-b5f2-f8c86834ec70@gmail.com>
Message-ID: <ffd9dbd0-be74-7bb4-9ca9-a97ee8023fc2@gmail.com>
Date:   Thu, 30 Jan 2020 21:06:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <394014f3-011a-d6b6-b5f2-f8c86834ec70@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

30.01.2020 19:08, Dmitry Osipenko пишет:
> 30.01.2020 17:09, Jon Hunter пишет:
>>
>> On 30/01/2020 04:38, Dmitry Osipenko wrote:
>>> It is enough to check whether hardware is busy on suspend and to reset
>>> it across of suspend-resume because channel's configuration is fully
>>> re-programmed on each DMA transaction anyways and because save-restore
>>> of an active channel won't end up well without pausing transfer prior to
>>> saving of the state (note that all channels shall be idling at the time of
>>> suspend, so save-restore is not needed at all).
>>
>> I guess if we ever wanted to support SNDRV_PCM_INFO_PAUSE for audio and
>> support the pause callback, then saving and restoring the channels could
>> be needed. Right now I believe that it will just terminate_all transfers
>> for audio on entering suspend. Any value in keeping this?
> 
> Indeed, looks like [1] pauses DMA during suspend if SNDRV_PCM_INFO_PAUSE
> is supported.
> 
> [1]
> https://elixir.bootlin.com/linux/v5.5/source/sound/core/pcm_dmaengine.c#L199
> 
> So we'll need to save-restore context only if DMA is in a paused state
> during suspend, I'll adjust this patch to do that and will see if
> enabling SNDRV_PCM_INFO_PAUSE works.

I started to look at it and found that the .device_pause() hook isn't
implemented by the driver. So, it's fine to remove the context's
save-restore for now.

Jon, what about to keep this patch as-is? Later on I'll take a look at
implementing the proper pausing functionality and try to cleanup code a
bit further (remove the free list usage, etc).
