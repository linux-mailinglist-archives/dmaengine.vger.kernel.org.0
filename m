Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0D4614BC42
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jan 2020 15:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgA1Ovp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jan 2020 09:51:45 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33952 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgA1Ove (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jan 2020 09:51:34 -0500
Received: by mail-lf1-f65.google.com with SMTP id l18so9322587lfc.1;
        Tue, 28 Jan 2020 06:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eFQApFkHfSijVKTUUrUwJVn0wlaUnmghVVpOTatZBc0=;
        b=i1eWOouQAS7TnZdny1CCxPmzkOsNL514kyDso/tgHDC9ht6uZ4x5lkco1i1S/K04gd
         qRThOaBSQ2DgIkOGQ1UHav+qKuX2xP0eSCk9bCFrXG9yt33qrW1iDm0XTvdi/wChIWX1
         ErAIZZ3pzbztHsEeSfSnGSX/1WJbTICOcTN0Suln1Ce7TYawxIZY7AhiJV1CYm+ztNMV
         9vl9lNzxf0/w1AABEVWAnMlNviFSr/oOZ512zLn3dPXrIweLVqajI2wANbEBG9m1Xpk6
         ntCF9xDgpavJHRCBBNsvJRnCWZBlNTdKo8aBnIa2Rg4tUZS+C9phUNST5D+NsHp14v7j
         Xejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eFQApFkHfSijVKTUUrUwJVn0wlaUnmghVVpOTatZBc0=;
        b=lRcAcN0NjvVW4ajUTKCy4rfFB3N1QT7OQuvGfcGNhVgrGtTSODdJ2QtYeX/28C6zbz
         VSmJEvfUr06XnGbOXD3U7NCaBz+SKN+TJpS6lC+ajVawaXFWgxVuCUiCgvFCB/Lh5n7C
         Xu0gWkMVLa2svNbiV1jO9hoLvcXtZEhv4aFsNcfHkpGhAzcZYQboU1oZvFOzaWOWSCju
         NA+cJzraTVxVewD8fHuhJfmR82p1Fd4buAQ9sr/RH+bXaQGISiX2ThNo1ofuE9Wdj3Uz
         PQyx3D/t0fgJpL2VSMdUDD1o+g9RPI0cAkRBYl8Vbg+05/kZV2bmarEA3z1dlsDtmLMo
         QFWg==
X-Gm-Message-State: APjAAAUksn5nHzyKmf/ioZluIme/6p0kH3ek7s6zFqIsOXK4j9MVxoJK
        ZaGwdJ/az70mD96nM+s9Q7keHik+
X-Google-Smtp-Source: APXvYqzutaBEYTWQbmXBikAIIpfSDGxe+iBkX/mtL9YJnlopi80AjM/us3OPXhD3Q2kkipwoNJ0hkw==
X-Received: by 2002:ac2:5e2e:: with SMTP id o14mr2662509lfg.198.1580223090891;
        Tue, 28 Jan 2020 06:51:30 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id u9sm9737575lji.49.2020.01.28.06.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 06:51:30 -0800 (PST)
Subject: Re: [PATCH v4 01/14] dmaengine: tegra-apb: Fix use-after-free
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-2-digetx@gmail.com>
 <4c1b9e48-5468-0c03-2108-158ee814eea8@nvidia.com>
 <1327bb21-0364-da26-e6ed-ff6c19df03e6@gmail.com>
 <e39ef31d-4cff-838a-0fc1-73a39a8d6120@nvidia.com>
 <b0c85ca7-d8ac-5f9d-2c57-79543c1f9b5d@gmail.com>
 <5bbe9e3e-a64f-53be-e7f6-63e36cbae77d@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <be7addff-9f5c-e40a-923f-db895ce89fa2@gmail.com>
Date:   Tue, 28 Jan 2020 17:51:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <5bbe9e3e-a64f-53be-e7f6-63e36cbae77d@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

28.01.2020 17:02, Jon Hunter пишет:
> 
> On 16/01/2020 20:10, Dmitry Osipenko wrote:
>> 15.01.2020 12:00, Jon Hunter пишет:
>>>
>>> On 14/01/2020 20:33, Dmitry Osipenko wrote:
>>>> 14.01.2020 18:09, Jon Hunter пишет:
>>>>>
>>>>> On 12/01/2020 17:29, Dmitry Osipenko wrote:
>>>>>> I was doing some experiments with I2C and noticed that Tegra APB DMA
>>>>>> driver crashes sometime after I2C DMA transfer termination. The crash
>>>>>> happens because tegra_dma_terminate_all() bails out immediately if pending
>>>>>> list is empty, thus it doesn't release the half-completed descriptors
>>>>>> which are getting re-used before ISR tasklet kicks-in.
>>>>>
>>>>> Can you elaborate a bit more on how these are getting re-used? What is
>>>>> the sequence of events which results in the panic? I believe that this
>>>>> was also reported in the past [0] and so I don't doubt there is an issue
>>>>> here, but would like to completely understand this.
>>>>>
>>>>> Thanks!
>>>>> Jon
>>>>>
>>>>> [0] https://lore.kernel.org/patchwork/patch/675349/
>>>>>
>>>>
>>>> In my case it happens in the touchscreen driver during of the
>>>> touchscreen's interrupt handling (in a threaded IRQ handler) + CPU is
>>>> under load and there is other interrupts activity. So what happens here
>>>> is that the TS driver issues one I2C transfer, which fails with
>>>> (apparently bogus) timeout (because DMA descriptor is completed and
>>>> removed from the pending list, but tasklet not executed yet), and then
>>>> TS immediately issues another I2C transfer that re-uses the
>>>> yet-incompleted descriptor. That's my understanding.
>>>
>>> OK, but what is the exact sequence that it allowing it to re-use the
>>> incompleted descriptor?
>>
>>    TDMA driver                      DMA Client
>>
>> 1.
>>                                     dmaengine_prep()
>>
>> 2.
>>    tegra_dma_desc_get()
>>    dma_desc = kzalloc()
>>    ...
>>    tegra_dma_prep_slave_sg()
>>    INIT_LIST_HEAD(&dma_desc->tx_list);
>>    INIT_LIST_HEAD(&dma_desc->cb_node);
>>    list_add_tail(sgreq->node,
>>                  dma_desc->tx_list)
>>
>> 3.
>>                                     dma_async_issue_pending()
>>
>> 4.
>>    tegra_dma_tx_submit()
>>    list_splice_tail_init(dma_desc->tx_list,
>>                          tdc->pending_sg_req)
>>
>> 5.
>>    tegra_dma_isr()
>>    ...
>>    handle_once_dma_done()
>>    ...
>>    sgreq = list_first_entry(tdc->pending_sg_req)
>>    list_del(sgreq->node);
>>    ...
>>    list_add_tail(dma_desc->cb_node,
>>                  tdc->cb_desc);
>>    list_add_tail(dma_desc->node,
>>                  tdc->free_dma_desc);
> 
> Isn't this the problem here, that we have placed this on the free list
> before we are actually done?
> 
> It seems to me that there could still be a potential race condition
> between the ISR and the tasklet running.

Yes, this should be addressed by the patch #3 "dmaengine: tegra-apb:
Prevent race conditions of tasklet vs free list".
