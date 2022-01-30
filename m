Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EA84A3AF9
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jan 2022 00:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356803AbiA3XXd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 30 Jan 2022 18:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiA3XXd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 30 Jan 2022 18:23:33 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B682C061714;
        Sun, 30 Jan 2022 15:23:32 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id z4so23274132lft.3;
        Sun, 30 Jan 2022 15:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hjWnQjTh+Jhn+MkeRugfJqa0o+1S0rAaZn892MQUIPc=;
        b=ncu+RIgVZT2ZhXx6LsrAITVCvtQyLlPtl/DoIsaPqKtr+f5m6hxambvja5Wwx9i8qm
         wyzfivyprc+E19acVfLISr1lAtAB3qxCx+FknpMcF0UsxRXh693fUnOOMN7DPLMMhptd
         jQra0sBN2OWtu3tabkqTMOgPrAMByvIRYPMKbXJQbDNft8RHYOLOQW2ZwYTdLGaTTB8p
         CLiC+Qt+dLt7I4LX0e0+humxArxiaSMg9IQbNlgJXpX8ol0W2bILE3wbL9R/jWZSm6Du
         5f2SUpz2f65xe5pC5s2MXdgUMQ8HRCwSVA/WW914mEyhoDX7lmdCrzgWYjoYd4NlcjpV
         NLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hjWnQjTh+Jhn+MkeRugfJqa0o+1S0rAaZn892MQUIPc=;
        b=i6+E3Wd/uZsnuu381uSUhbH1zuyNFYFktgUrK0C9HTBOTWqJHBVyk6ktq23dJHTjZo
         FRUgS8kdlCMhJAz8bsfiI0+RCciZtNV+kHG+tgPS8eWq5mLUJf5muzEj3f1XZPHf7/Ta
         TE4ajStklqP/8uQw7Lcxan8oStvmUk1N5uXW06oW4K8gRMFLGvl/cC6RA3Zyy9HkJ0SE
         RligYzLDP0F6tymR33qkPIUFwjbDqYgdu78VkAkR9pPqMmyh+JsR1Q7Wzx75GFjH8yBG
         PXO7Kv/+qBaJ7vRki+6KEVKAeM9KyfIcLHJiecBCIRidP1J5BwPQLCaz5ea2nE6dQf2b
         ZQ5A==
X-Gm-Message-State: AOAM531XSYkZoLzujn5hucewyv7QVAFVi41wcCPTOgXnopkxGwWqyGgE
        Hn0ShfHiY/CEw2ESoXbTTHt9NFiJUjE=
X-Google-Smtp-Source: ABdhPJxLCye+nMEmvg/p3mBLmZKVLrjX9D/8KNbNof1jTll5aN0TEIbRPBHe4zv8TZxs9Nez564RrQ==
X-Received: by 2002:a19:f014:: with SMTP id p20mr13780076lfc.68.1643585010268;
        Sun, 30 Jan 2022 15:23:30 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.googlemail.com with ESMTPSA id u14sm577043lfo.58.2022.01.30.15.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jan 2022 15:23:29 -0800 (PST)
Message-ID: <f3ffb863-7a78-414c-bee2-09293b28a9da@gmail.com>
Date:   Mon, 31 Jan 2022 02:23:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v17 2/4] dmaengine: tegra: Add tegra gpcdma driver
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
Cc:     Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
 <1643474453-32619-3-git-send-email-akhilrajeev@nvidia.com>
 <ba109465-d7ee-09cb-775b-9b702a3910b0@gmail.com>
 <dcd4e4db-2999-15c9-0c82-42dd8ca1e61d@gmail.com>
 <f32e119a-1d08-d1f9-a264-fe004960e8bf@gmail.com>
 <DM5PR12MB1850C29D41F50FA6850C89DDC0249@DM5PR12MB1850.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <DM5PR12MB1850C29D41F50FA6850C89DDC0249@DM5PR12MB1850.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

30.01.2022 19:43, Akhil R пишет:
>> 30.01.2022 13:26, Dmitry Osipenko пишет:
>>> 30.01.2022 13:05, Dmitry Osipenko пишет:
>>>> Still nothing prevents interrupt handler to fire during the pause.
>>>>
>>>> What you actually need to do is to disable/enable interrupt. This
>>>> will prevent the interrupt racing and then pause/resume may look like this:
>>>
>>> Although, seems this won't work, unfortunately. I see now that
>>> device_pause() doesn't have might_sleep().
>>>
>>
>> Ah, I see now that the pause/unpause is actually a separate control and doesn't
>> conflict with "start next transfer".
>>
>> So you just need to set/unset the pause under lock. And don't touch
>> tdc->dma_desc. That's it.
>>
>> static int tegra_dma_device_pause(struct dma_chan *dc) {
>>         struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>>         unsigned long flags;
>>         u32 val;
>>
>>         if (!tdc->tdma->chip_data->hw_support_pause)
>>                 return -ENOSYS;
>>
>>         spin_lock_irqsave(&tdc->vc.lock, flags);
>>
>>         val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
>>         val |= TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
>>         tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
>>
>>         spin_unlock_irqrestore(&tdc->vc.lock, flags);
>>
>>         return 0;
>> }
>>
>> static int tegra_dma_device_resume(struct dma_chan *dc) {
>>         struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>>         unsigned long flags;
>>         u32 val;
>>
>>         if (!tdc->tdma->chip_data->hw_support_pause)
>>                 return -ENOSYS;
>>
>>         spin_lock_irqsave(&tdc->vc.lock, flags);
>>
>>         val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
>>         val &= ~TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
>>         tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
>>
>>         spin_unlock_irqrestore(&tdc->vc.lock, flags);
>>
>>         return 0;
>> }
> 
> The reason I separated out register writes was to conveniently call those
> in dma_start() and terminate_all(). Do you see any issue there?
> The recommended way of terminating a transfer in between is to pause
> it before disabling the channel.

This is a sample code, feel free to adjust it as needed.

> dma_desc could be NULL while these functions are called. pause() or
> resume() is unneeded if there isn't any transfer going on. Moreover,
> if we are to calculate the xfer_size, the check would be mandatory.

For now looks like it should be better to move the xfer_size updating to
other places, like terminate_all() and tx_status().

I also see now that you have
residue_granularity=DMA_RESIDUE_GRANULARITY_BURST, while tx_status()  in
fact uses segment granularity. This needs to be corrected.

You also must add locking to tx_status(), to protect tdc->dma_desc
pointer updates.
