Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A7F14DE77
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 17:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgA3QJF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 11:09:05 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42502 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbgA3QJE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 11:09:04 -0500
Received: by mail-lf1-f68.google.com with SMTP id y19so2649369lfl.9;
        Thu, 30 Jan 2020 08:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7MdnDJQMyIsHDWYb9nyXQwRWUc6t+KNfP7tasqGJFIE=;
        b=oV/b1VIn7SIHE9G5ozfRIT4kiJ43JzyXCQmSs6tmc7tYdOIJFR3f5fYxGKJ/CvSR6N
         sHEe1esb+eOEKd8xdKhZl32RARm3yMAr6mQs9cyUlpf/RuCJUuKAJ6eYn31/k4UD/N5O
         UnzoVPYzKmSOe5guwQGl7CTH9+Lo/jzHouhxvVigcoKTx5X50gWlPjVhJ6raXpVc13Tw
         w/jg3RRPzdHs+CMo2Zx1gXX2qdOIGzdT2CauoNS33uvQOyODYkjwwj35rGC3460Rm0sE
         UBhKmpT/zafd3U8FvHQDQf0C1BVTa3Gbl0tn2B63io4brq1DihJWC2POKfQhpN+e+YX7
         pJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7MdnDJQMyIsHDWYb9nyXQwRWUc6t+KNfP7tasqGJFIE=;
        b=a45v/2Qc4fO6r76nDlPbA0baaBA1vZ4+RXPQpx+AzELIP2lDvJjSxDUauhHo5rdQvK
         IZLBL9/J9i5BBgGcxK6MqaczRPUyICVEEwxn/xwgLMGPt1RWKYBfIPXXz/5ntDst1VBz
         uAajtWhjOgK6fAlp0RdcHLKEilGR2zswOixjSCZJ9KWaWoUmGJGDHCMrMpcTnQa+IqoQ
         5FUW1XDtigu3nSWHqS9GlxihQ0YV6+i33uzRSxPcma/osQEVtk3WPqJszCgOR1Lcmw2C
         TYqFPFSXDDloRcwALHLwljtVggfIvQun54CjscGTp8uHn52nNE6ycJvnWTGQoamkLEh8
         0IDQ==
X-Gm-Message-State: APjAAAXBe/gLPKXmAR8IMMiA4ppbQaHWAWv6Z2TSjOKmNsj4o5QyYy5x
        qUEQyxEBYX7bXYNT/Nbqv7cnBItr
X-Google-Smtp-Source: APXvYqxUBSd0RcpEkIjAEyoRlD0SIYfgU0fFAhg0TfF0dchf8BlJEn3ktGm3VGjUfOXGZ7bPQQc7ZA==
X-Received: by 2002:ac2:597b:: with SMTP id h27mr2961704lfp.12.1580400540753;
        Thu, 30 Jan 2020 08:09:00 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id b20sm3120846ljp.20.2020.01.30.08.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 08:09:00 -0800 (PST)
Subject: Re: [PATCH v6 12/16] dmaengine: tegra-apb: Clean up suspend-resume
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <394014f3-011a-d6b6-b5f2-f8c86834ec70@gmail.com>
Date:   Thu, 30 Jan 2020 19:08:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <e787bee2-4b52-1643-b3a5-8c4e70f6fdca@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

30.01.2020 17:09, Jon Hunter пишет:
> 
> On 30/01/2020 04:38, Dmitry Osipenko wrote:
>> It is enough to check whether hardware is busy on suspend and to reset
>> it across of suspend-resume because channel's configuration is fully
>> re-programmed on each DMA transaction anyways and because save-restore
>> of an active channel won't end up well without pausing transfer prior to
>> saving of the state (note that all channels shall be idling at the time of
>> suspend, so save-restore is not needed at all).
> 
> I guess if we ever wanted to support SNDRV_PCM_INFO_PAUSE for audio and
> support the pause callback, then saving and restoring the channels could
> be needed. Right now I believe that it will just terminate_all transfers
> for audio on entering suspend. Any value in keeping this?

Indeed, looks like [1] pauses DMA during suspend if SNDRV_PCM_INFO_PAUSE
is supported.

[1]
https://elixir.bootlin.com/linux/v5.5/source/sound/core/pcm_dmaengine.c#L199

So we'll need to save-restore context only if DMA is in a paused state
during suspend, I'll adjust this patch to do that and will see if
enabling SNDRV_PCM_INFO_PAUSE works.
