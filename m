Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEA914E0C2
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 19:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgA3S0W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 13:26:22 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39897 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbgA3S0W (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 13:26:22 -0500
Received: by mail-qv1-f65.google.com with SMTP id y8so1971025qvk.6;
        Thu, 30 Jan 2020 10:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nhcuvaw1Zldg0lwcAuSflEHiBspbMw+3+HFO4FIoUvk=;
        b=M8Se7ErtY87XGzfxTMnzblsi5Bqg2dhEdKIrF2ExoIaGVrIdsczTKDEs2cFVpuNiVr
         jFkPlq67SchvC9mnSuTpRwf5iHZoWoVng+mk9YnKfNCLo+qfBFDCfszRt4PegprGKzHx
         LExLLEfeGoxtT/b4T+uf98FMHL0ZF3LyTTJpn0ZQDwI9WcpCLM0TOMw5L4s777gtjnBp
         Cp/tHZlV9cwc2J2TA5PlnF5jkNrlu0kWhWY9Smqg5bfrwK/oty6MClPuzO1Zx8Tn2BiE
         Kp2XaDZTvM48n6kUI2JRXenE0ZJLpuPfZlSJoFrk2fGeNU5me8fPSBYYyZ09KeGcsXX9
         t7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nhcuvaw1Zldg0lwcAuSflEHiBspbMw+3+HFO4FIoUvk=;
        b=VpYB4zm4TReYz1Gebw15P8cVV4WZB5j/JDUTLsbOEwM1LdFuXNJ0KramiiYdeahy7H
         ap3t4k/vGNxMf/WRuxf3Q+UeMWexGEnRJ7kKSdFu2+I3RlYCSmBB1Pjb1appAVUr334z
         y6HB6ZGTwUA00yQb3hOo37+tB3jzb2TL0uhEVWGjDQCl7xhI9Wx9fxHI9Lq/0ByuIlvG
         N0Bn7MiHBs/4noVpUI2ibdQG3jqUA2BXqGoX8zA8GS7BrCydVYzV06KOs4YtynzQxYuL
         UI9oG/TtYtoQDg0vfx3NXg6JuOvESNj1VD8oyOVn53q89QIIz1ultzZSZltY2+i+CsTc
         KAKQ==
X-Gm-Message-State: APjAAAWyVtl6BLmPgznMmIByHXrs8NgvvCPvYcgAAt5cB8jLeB/Rdd/3
        YrlyiIyMV+ci/EQ0XA1YICOCMweF
X-Google-Smtp-Source: APXvYqzMVteYHhPF6VaM0ZSCUgi5fNUuFCq1z+7giHsN3Vz6TphvDGakka/A4attfEuN15N/8vRzOQ==
X-Received: by 2002:a05:6214:907:: with SMTP id dj7mr5874893qvb.245.1580408781153;
        Thu, 30 Jan 2020 10:26:21 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id g53sm3535498qtk.76.2020.01.30.10.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 10:26:20 -0800 (PST)
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
 <ffd9dbd0-be74-7bb4-9ca9-a97ee8023fc2@gmail.com>
Message-ID: <3d8f599d-a46f-a7e5-8816-e0c44e2aceff@gmail.com>
Date:   Thu, 30 Jan 2020 21:26:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <ffd9dbd0-be74-7bb4-9ca9-a97ee8023fc2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

30.01.2020 21:06, Dmitry Osipenko пишет:
> 30.01.2020 19:08, Dmitry Osipenko пишет:
>> 30.01.2020 17:09, Jon Hunter пишет:
>>>
>>> On 30/01/2020 04:38, Dmitry Osipenko wrote:
>>>> It is enough to check whether hardware is busy on suspend and to reset
>>>> it across of suspend-resume because channel's configuration is fully
>>>> re-programmed on each DMA transaction anyways and because save-restore
>>>> of an active channel won't end up well without pausing transfer prior to
>>>> saving of the state (note that all channels shall be idling at the time of
>>>> suspend, so save-restore is not needed at all).
>>>
>>> I guess if we ever wanted to support SNDRV_PCM_INFO_PAUSE for audio and
>>> support the pause callback, then saving and restoring the channels could
>>> be needed. Right now I believe that it will just terminate_all transfers
>>> for audio on entering suspend. Any value in keeping this?
>>
>> Indeed, looks like [1] pauses DMA during suspend if SNDRV_PCM_INFO_PAUSE
>> is supported.
>>
>> [1]
>> https://elixir.bootlin.com/linux/v5.5/source/sound/core/pcm_dmaengine.c#L199
>>
>> So we'll need to save-restore context only if DMA is in a paused state
>> during suspend, I'll adjust this patch to do that and will see if
>> enabling SNDRV_PCM_INFO_PAUSE works.
> 
> I started to look at it and found that the .device_pause() hook isn't
> implemented by the driver. So, it's fine to remove the context's
> save-restore for now.
> 
> Jon, what about to keep this patch as-is? Later on I'll take a look at
> implementing the proper pausing functionality and try to cleanup code a
> bit further (remove the free list usage, etc).

Ah, only T114+ supports the per-channel pausing. So, I won't care about
implementing the device_pause(), let's leave it to somebody else :)
