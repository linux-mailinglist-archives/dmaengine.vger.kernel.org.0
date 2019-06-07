Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57B7C39717
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2019 22:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbfFGUxr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jun 2019 16:53:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42698 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbfFGUxr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jun 2019 16:53:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id t28so2860359lje.9;
        Fri, 07 Jun 2019 13:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4IsnnAN6cEbNwBdTyu43WYRxzd5DcvJoa0HAPXMpHzI=;
        b=Rte0JchyxvWRlDuOg1Db50viRdL+kmb0+mf+wgXGNXejxlkwDGfIUpu0kEibC6KiQ/
         FgTK3wSVvCQ2wWuOEwicK0P51XeTxq2j+ytoCRFaeBTevqq0xqKa0M3CWRx1SMeLf0Is
         g46pA19b89N9e+uHOM4x+Fw7OE/J43ds0S9VRF16nPISYgwyzzo29DwJvxrWRL5SHGEd
         0eFK7dYkywpuawxManbXIUKgUts1O78i/cViAAt9+7qmItouCYPBdDV5n0IaD97hOljZ
         rTbcYCc7pGJEVdjS11METMeSlSq2iCc9csZgWhXhuROhfhLy2J3/Kvw6ZMYjbDDj8xlk
         Uh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4IsnnAN6cEbNwBdTyu43WYRxzd5DcvJoa0HAPXMpHzI=;
        b=tAZYW5ye26q1cPs/M+87vXCF+JIDLWcRA2EU/cXuZTjOsudMlPDmVzyQjb9vQFbbz+
         gp0U1bn5y9KPHZEr76BOL0IkpVVANB1IfGjvIzZX57zMd08UOTZyYb7RrvJxzuww1ckP
         Uo0UnzNQPYr3lD51nnUT6UMTzFdoj98zVK54n1v6/wGFS5oTHjhfJvvStI1JsluOgBSS
         sDMg33s2xhNWXro/N9P6xPOipWtKYoFG4Rs7DQUx3EQDb12VBydunImwDC5OaeYGAW+Y
         NaNZlnIPnyWNuaUMfEkAv/vltJ7OdtzVXjvoCoMp+2m9Lttiot8VdMYiYikaU0N2oTYD
         BQTQ==
X-Gm-Message-State: APjAAAWwMH7IrsRNwsCP1MKMuxJtOqYeOQHN8uZ7upo+UYqd/3dz6LVW
        OXVt52Gxa8M1qSFF+x9U+0h04DkU
X-Google-Smtp-Source: APXvYqwXN3wwyfhMzL9IHpPezoCpCCowQVd97OmX8RufhXxmw0ly5ersteMTeFB9syX6eET7D7ZXKA==
X-Received: by 2002:a2e:2f12:: with SMTP id v18mr28240698ljv.196.1559940824833;
        Fri, 07 Jun 2019 13:53:44 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-76-170-54.pppoe.mtu-net.ru. [91.76.170.54])
        by smtp.googlemail.com with ESMTPSA id e26sm544534ljl.33.2019.06.07.13.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 13:53:43 -0700 (PDT)
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>, Vinod Koul <vkoul@kernel.org>
Cc:     dan.j.williams@intel.com, tiwai@suse.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        sharadg@nvidia.com, rlokhande@nvidia.com, dramesh@nvidia.com,
        mkumard@nvidia.com, linux-tegra <linux-tegra@vger.kernel.org>
References: <1556623828-21577-1-git-send-email-spujar@nvidia.com>
 <20190502122506.GP3845@vkoul-mobl.Dlink>
 <3368d1e1-0d7f-f602-5b96-a978fcf4d91b@nvidia.com>
 <20190504102304.GZ3845@vkoul-mobl.Dlink>
 <ce0e9c0b-b909-54ae-9086-a1f0f6be903c@nvidia.com>
 <20190506155046.GH3845@vkoul-mobl.Dlink>
 <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
 <ed95f03a-bbe7-ad62-f2e1-9bfe22ec733a@ti.com>
 <4cab47d0-41c3-5a87-48e1-d7f085c2e091@nvidia.com>
 <8a5b84db-c00b-fff4-543f-69d90c245660@nvidia.com>
 <3f836a10-eaf3-f59b-7170-6fe937cf2e43@ti.com>
 <a36302fc-3173-070b-5c97-7d2c55d5e2cc@nvidia.com>
 <a08bec36-b375-6520-eff4-3d847ddfe07d@ti.com>
 <4593f37c-5e89-8559-4e80-99dbfe4235de@nvidia.com>
 <d0db90e3-3d05-dfba-8768-28511d9ee3ac@ti.com>
 <5208a50a-9ca0-8f24-9ad0-d7503ec53f1c@nvidia.com>
 <ba845a19-5dfb-a891-719f-43821b2dd412@nvidia.com>
 <e67a2d7c-5bd1-93ad-fe75-afcab38bc17c@ti.com>
 <a65f2b07-4a3a-7f83-e21f-8b374844a4b9@nvidia.com>
 <56aa6f45-cfd8-7f1e-9392-628ceb58093f@ti.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <68e72598-8d53-115c-14a2-9d3042165aff@gmail.com>
Date:   Fri, 7 Jun 2019 23:53:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <56aa6f45-cfd8-7f1e-9392-628ceb58093f@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

07.06.2019 16:35, Peter Ujfalusi пишет:
> 
> 
> On 07/06/2019 15.58, Jon Hunter wrote:
>>> Imho if you can explain it without using 'HACK' in the sentences it
>>> might be OK, but it does not feel right.
>>
>> I don't perceive this as a hack. Although from looking at the
>> description of the src/dst_maxburst these are burst size with regard to
>> the device, so maybe it is a stretch.
>>
>>> However since your ADMA and ADMIF is highly coupled and it does needs
>>> special maxburst information (burst and allocated FIFO depth) I would
>>> rather use src_maxburst/dst_maxburst alone for DEV_TO_MEM/MEM_TO_DEV:
>>>
>>> ADMA_BURST_SIZE(maxburst)	((maxburst) & 0xff)
>>> ADMA_FIFO_SIZE(maxburst)	(((maxburst) >> 8) & 0xffffff)
>>>
>>> So lower 1 byte is the burst value you want from ADMA
>>> the other 3 bytes are the allocated FIFO size for the given ADMAIF channel.
>>>
>>> Sure, you need a header for this to make sure there is no
>>> misunderstanding between the two sides.
>>
>> I don't like this because as I mentioned to Dmitry, the ADMA can perform
>> memory-to-memory transfers where such encoding would not be applicable.
> 
> mem2mem does not really use dma_slave_config, it is for used by
> is_slave_direction() == true type of transfers.
> 
> But true, if you use ADMA against anything other than ADMAIF then this
> might be not right for non cyclic transfers.
> 
>> That does not align with the description in the
>> include/linux/dmaengine.h either.
> 
> True.
> 
>>> Or pass the allocated FIFO size via maxburst and then the ADMA driver
>>> will pick a 'good/safe' burst value for it.
>>>
>>> Or new member, but do you need two of them for src/dst? Probably
>>> fifo_depth is better word for it, or allocated_fifo_depth.
>>
>> Right, so looking at the struct dma_slave_config we have ...
>>
>> u32 src_maxburst;
>> u32 dst_maxburst;
>> u32 src_port_window_size;
>> u32 dst_port_window_size;
>>
>> Now if we could make these window sizes a union like the following this
>> could work ...
>>
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index 8fcdee1c0cf9..851251263527 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -360,8 +360,14 @@ struct dma_slave_config {
>>         enum dma_slave_buswidth dst_addr_width;
>>         u32 src_maxburst;
>>         u32 dst_maxburst;
>> -       u32 src_port_window_size;
>> -       u32 dst_port_window_size;
>> +       union {
>> +               u32 port_window_size;
>> +               u32 port_fifo_size;
>> +       } src;
>> +       union {
>> +               u32 port_window_size;
>> +               u32 port_fifo_size;
>> +       } dst;
> 
> What if in the future someone will have a setup where they would need both?
> 
> So not sure. Your problems are coming from a split DMA setup where the
> two are highly coupled, but sits in a different place and need to be
> configured as one device.
> 
> I think xilinx_dma is facing with similar issues and they have a custom
> API to set parameters which does not fit or is peripheral specific:
> include/linux/dma/xilinx_dma.h
> 
> Not sure if that is an acceptable solution.

If there are no other drivers with the exactly same requirement, then
the custom API is an a good variant given that there is a precedent
already. It is always possible to convert to a common thing later on
since that's all internal to kernel.

Jon / Sameer, you should check all the other drivers thoroughly to find
anyone who is doing the same thing as you need in order to achieve
something that is really common. I'm also wondering if it will be
possible to make dma_slave_config more flexible in order to start
accepting vendor specific properties in a somewhat common fashion, maybe
Vinod and Dan already have some thoughts on it? Apparently there is
already a need for the customization and people are just starting to
invent their own thing, but maybe that's fine too. That's really up to
subsys maintainer to decide in what direction to steer.
