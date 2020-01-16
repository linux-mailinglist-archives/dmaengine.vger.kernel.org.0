Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D227613FA30
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2020 21:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgAPUKn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jan 2020 15:10:43 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35814 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgAPUKm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jan 2020 15:10:42 -0500
Received: by mail-lj1-f195.google.com with SMTP id j1so23976247lja.2;
        Thu, 16 Jan 2020 12:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pEuLrU2BpUSNmu4UveCDpaLLg5RgdT00zU5cu7LGBZo=;
        b=OYiDI3E0+941verm/XyKBDtUuzeBmpC3dQzWzBwkMV2XnCoxs9/fS31Xq2a5jOFxDA
         mwjTXSWEZobvhxVEv3+0tVLKNfr1lxKE2EqtAaX6aEuPBQmo6I0VBDBaX57DO9wlCaVz
         stwqvbzL5dgy4028sWtq3otIOcS0c7kZk20DKMt1NfwtOeqa5fXQsHz/oI27TwA13kwJ
         sGsPkvHxLT/lhqb7dFxhjCb7v97VpMY0QRxCwgaAUULyzr8jWqXUVV8QAVgs46hWN6Fz
         ItqurV4kXbTK7i33pOaRgKoVIH2R2ikVDn7kRNm5til8ggpVUyquEutNY9IRcGTnSCkA
         NPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pEuLrU2BpUSNmu4UveCDpaLLg5RgdT00zU5cu7LGBZo=;
        b=SUsmQpwJ31a2rZXpeGlYc9TMqSSCh9bFNb70IMXVHhiNS1bcdnxURBwJiyDSPjfAHN
         bJr6yuLDJ8tNyomnQIeU+ijL6bmAN6wUf7ZtBO4OpVG8xjV4pkymUC1AWXVGrLHEpvPh
         /B0nEDWDegYqN2SyoXEARV6L3uJ7rkli8XYLu2kBLX2nv22dp6cPjPQrtpmDDbMr4epa
         SlOUTjDxsbZvYx81fi6or2wb4tS+wK09/gSrsCXyEb+hVtZd8eLtL922lw8OAMNTNDNk
         gjoTkqWeyRFMpBk/kN2WgYzqRmuyFyGRFQdOV8JYz9ehYlFzuFyjFjP6G72c6f4COjC5
         28lg==
X-Gm-Message-State: APjAAAVCUnMB0f95rn/1b/Vpnk9vyCTCrWplpmw4sBI6bgSIF6Z2p6aL
        EN2my0Z1dbLr9Cvz9G7B69mIy7ko
X-Google-Smtp-Source: APXvYqzZnQfQ2a6Vct+CFJCYllwIuR6cpEoraA9CzIxdzJ0PID4MK+W4sOeq/jKjZ6+IkmeYOPDneA==
X-Received: by 2002:a05:651c:2046:: with SMTP id t6mr3367132ljo.180.1579205439902;
        Thu, 16 Jan 2020 12:10:39 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id r125sm11049150lff.70.2020.01.16.12.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 12:10:39 -0800 (PST)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b0c85ca7-d8ac-5f9d-2c57-79543c1f9b5d@gmail.com>
Date:   Thu, 16 Jan 2020 23:10:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <e39ef31d-4cff-838a-0fc1-73a39a8d6120@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

15.01.2020 12:00, Jon Hunter пишет:
> 
> On 14/01/2020 20:33, Dmitry Osipenko wrote:
>> 14.01.2020 18:09, Jon Hunter пишет:
>>>
>>> On 12/01/2020 17:29, Dmitry Osipenko wrote:
>>>> I was doing some experiments with I2C and noticed that Tegra APB DMA
>>>> driver crashes sometime after I2C DMA transfer termination. The crash
>>>> happens because tegra_dma_terminate_all() bails out immediately if pending
>>>> list is empty, thus it doesn't release the half-completed descriptors
>>>> which are getting re-used before ISR tasklet kicks-in.
>>>
>>> Can you elaborate a bit more on how these are getting re-used? What is
>>> the sequence of events which results in the panic? I believe that this
>>> was also reported in the past [0] and so I don't doubt there is an issue
>>> here, but would like to completely understand this.
>>>
>>> Thanks!
>>> Jon
>>>
>>> [0] https://lore.kernel.org/patchwork/patch/675349/
>>>
>>
>> In my case it happens in the touchscreen driver during of the
>> touchscreen's interrupt handling (in a threaded IRQ handler) + CPU is
>> under load and there is other interrupts activity. So what happens here
>> is that the TS driver issues one I2C transfer, which fails with
>> (apparently bogus) timeout (because DMA descriptor is completed and
>> removed from the pending list, but tasklet not executed yet), and then
>> TS immediately issues another I2C transfer that re-uses the
>> yet-incompleted descriptor. That's my understanding.
> 
> OK, but what is the exact sequence that it allowing it to re-use the
> incompleted descriptor?

   TDMA driver                      DMA Client

1.
                                    dmaengine_prep()

2.
   tegra_dma_desc_get()
   dma_desc = kzalloc()
   ...
   tegra_dma_prep_slave_sg()
   INIT_LIST_HEAD(&dma_desc->tx_list);
   INIT_LIST_HEAD(&dma_desc->cb_node);
   list_add_tail(sgreq->node,
                 dma_desc->tx_list)

3.
                                    dma_async_issue_pending()

4.
   tegra_dma_tx_submit()
   list_splice_tail_init(dma_desc->tx_list,
                         tdc->pending_sg_req)

5.
   tegra_dma_isr()
   ...
   handle_once_dma_done()
   ...
   sgreq = list_first_entry(tdc->pending_sg_req)
   list_del(sgreq->node);
   ...
   list_add_tail(dma_desc->cb_node,
                 tdc->cb_desc);
   list_add_tail(dma_desc->node,
                 tdc->free_dma_desc);
   ...
   tasklet_schedule(&tdc->tasklet);
   ...

6.
                                    timeout
                                    dmaengine_terminate_async()

7.
   tegra_dma_terminate_all()
   if (list_empty(tdc->pending_sg_req))
       return 0;

8.
                                    dmaengine_prep()

9.
   tegra_dma_desc_get()
   list_for_each_entry(dma_desc,
                       tdc->free_dma_desc) {
       list_del(dma_desc->node);
       return dma_desc;
   }
   ...
   tegra_dma_prep_slave_sg()
   INIT_LIST_HEAD(&dma_desc->tx_list);
   INIT_LIST_HEAD(&dma_desc->cb_node);

   *** tdc->cb_desc list is wrecked now! ***

   list_add_tail(sgreq->node,
                 dma_desc->tx_list)
   ...

10.
   same actions as in #4 #5 ...

11.
   tegra_dma_tasklet()
   dma_desc = list_first_entry(tdc->cb_desc)
   list_del(dma_desc->cb_node);

   eventual woopsie
