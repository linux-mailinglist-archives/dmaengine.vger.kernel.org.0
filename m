Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53CC337593
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2019 15:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfFFNpY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jun 2019 09:45:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37837 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfFFNpX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jun 2019 09:45:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id m15so210380lfh.4;
        Thu, 06 Jun 2019 06:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N9FXYf9GpqwRa74VNnvDOcwiC8SgM19NN51vAX+BRDA=;
        b=Ac0gkbVkOaiQ9tZEyyDw6LZzO6TBmb8BeKt1LP+lGBDc0htpS47qYQ5RpXOaFveNkU
         6RWqvvsNAls3Lk4SbAG6doDO+Nm4qiFYHpW1q9XOrOcZkymblw3Ceq6nchMGhZQEJ6Gb
         ONiL7doYbWY/O1C3OQxg23Okyo5ikgyivpLRUtbYpXnX++dpmA8oKizcdxffi+c9tOBY
         FNOsKFv3O+FKh+T5mk4odCdfHOrnFVUqp4DpRZJ1RlCmEAfikZLlGxmkpVaHcfDNYMQX
         cNQqM7QkZiEROKVEXDM5JC+xdBUsrtOnGi8YK4HVeNJehvuQ+/tqDS08xtYJuxkWNmXM
         u7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N9FXYf9GpqwRa74VNnvDOcwiC8SgM19NN51vAX+BRDA=;
        b=WM8wjuhPFLpKG5Bz//24yQGH4fiJYnU/EmUM1QXshrnlf0xDZ3zPDHEq21O51Q9eQy
         ydHGgRlH2veXGtzA2Ge6JHdo/1/baH65luby6foD4bVUNwWvRB2xzLYHEtiGexnNQcmi
         tgWbjm54t7xOAGYz3Ud0pci0NtLct38YaK19SdJlEzt5O+mvK65m2FYTGf+2/4Qh8POs
         F5FjAgCJhbx4zRs0whvi9Xu8CybGreMFCuZUu9gnJ5aVjBQ4FGixiQGo1rBk23ibCmWA
         /1WluezNUNniKgjQhamsWS0hmJJfXfJKZ31+rmMLNabIwdG480xmUSTV0hCUcaI+7XRY
         iQhQ==
X-Gm-Message-State: APjAAAX10tw/t8BwdpbcMB9ECcSPEjkAeu6GCmWN/q+1LA0OSb9okBLP
        ZHjZo0R50bZufBq3a4Qwy5oX50Wg
X-Google-Smtp-Source: APXvYqwr/W5dtZzxKDImfntzoLRb7IZrxMdCWG+eVkjYSkuH443erGdlxsXYyfIYVaqp3vWF/L7XhQ==
X-Received: by 2002:ac2:48a5:: with SMTP id u5mr17688706lfg.62.1559828720120;
        Thu, 06 Jun 2019 06:45:20 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id c5sm307714lfm.7.2019.06.06.06.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 06:45:18 -0700 (PDT)
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Jon Hunter <jonathanh@nvidia.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sameer Pujar <spujar@nvidia.com>, Vinod Koul <vkoul@kernel.org>
Cc:     dan.j.williams@intel.com, tiwai@suse.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        sharadg@nvidia.com, rlokhande@nvidia.com, dramesh@nvidia.com,
        mkumard@nvidia.com, linux-tegra <linux-tegra@vger.kernel.org>
References: <1556623828-21577-1-git-send-email-spujar@nvidia.com>
 <20190502060446.GI3845@vkoul-mobl.Dlink>
 <e852d576-9cc2-ed42-1a1a-d696112c88bf@nvidia.com>
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <deae510a-f6ae-6a51-2875-a7463cac9169@gmail.com>
Date:   Thu, 6 Jun 2019 16:45:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4593f37c-5e89-8559-4e80-99dbfe4235de@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

06.06.2019 15:37, Jon Hunter пишет:
> 
> On 06/06/2019 12:54, Peter Ujfalusi wrote:
>>
>>
>> On 06/06/2019 13.49, Jon Hunter wrote:
>>>
>>> On 06/06/2019 11:22, Peter Ujfalusi wrote:
>>>
>>> ...
>>>
>>>>>>> It does sounds like that FIFO_SIZE == src/dst_maxburst in your case as
>>>>>>> well.
>>>>>> Not exactly equal.
>>>>>> ADMA burst_size can range from 1(WORD) to 16(WORDS)
>>>>>> FIFO_SIZE can be adjusted from 16(WORDS) to 1024(WORDS) [can vary in
>>>>>> multiples of 16]
>>>>>
>>>>> So I think that the key thing to highlight here, is that the as Sameer
>>>>> highlighted above for the Tegra ADMA there are two values that need to
>>>>> be programmed; the DMA client FIFO size and the max burst size. The ADMA
>>>>> has register fields for both of these.
>>>>
>>>> How does the ADMA uses the 'client FIFO size' and 'max burst size'
>>>> values and what is the relation of these values to the peripheral side
>>>> (ADMAIF)?
>>>
>>> Per Sameer's previous comment, the FIFO size is used by the ADMA to
>>> determine how much space is available in the FIFO. I assume the burst
>>> size just limits how much data is transferred per transaction.
>>>
>>>>> As you can see from the above the FIFO size can be much greater than the
>>>>> burst size and so ideally both of these values would be passed to the DMA.
>>>>>
>>>>> We could get by with just passing the FIFO size (as the max burst size)
>>>>> and then have the DMA driver set the max burst size depending on this,
>>>>> but this does feel quite correct for this DMA. Hence, ideally, we would
>>>>> like to pass both.
>>>>>
>>>>> We are also open to other ideas.
>>>>
>>>> I can not find public documentation (I think they are walled off by
>>>> registration), but correct me if I'm wrong:
>>>
>>> No unfortunately, you are not wrong here :-(
>>>
>>>> ADMAIF - peripheral side
>>>>  - kind of a small DMA for audio preipheral(s)?
>>>
>>> Yes this is the interface to the APE (audio processing engine) and data
>>> sent to the ADMAIF is then sent across a crossbar to one of many
>>> devices/interfaces (I2S, DMIC, etc). Basically a large mux that is user
>>> configurable depending on the use-case.
>>>
>>>>  - Variable FIFO size
>>>
>>> Yes.
>>>
>>>>  - sends DMA request to ADMA per words
>>>
>>> From Sameer's notes it says the ADMAIF send a signal to the ADMA per
>>> word, yes.
>>>
>>>> ADMA - system DMA
>>>>  - receives the DMA requests from ADMAIF
>>>>  - counts the requests
>>>>  - based on some threshold of the counter it will send/read from ADMAIF?
>>>>   - maxburst number of words probably?
>>>
>>> Sounds about right to me.
>>>
>>>> ADMA needs to know the ADMAIF's FIFO size because, it is the one who is
>>>> managing that FIFO from the outside, making sure that it does not over
>>>> or underrun?
>>>
>>> Yes.
>>>
>>>> And it is the one who sets the pace (in effect the DMA burst size - how
>>>> many bytes the DMA jumps between refills) of refills to the ADMAIF's FIFO?
>>>
>>> Yes.
>>>
>>> So currently, if you look at the ADMA driver
>>> (drivers/dma/tegra210-adma.c) you will see we use the src/dst_maxburst
>>> for the burst, but the FIFO size is hard-coded (see the
>>> TEGRA210_FIFO_CTRL_DEFAULT and TEGRA186_FIFO_CTRL_DEFAULT definitions).
>>> Ideally, we should not hard-code this but pass it.
>>
>> Sure, hardcoding is never good ;)
>>
>>> Given that there are no current users of the ADMA upstream, we could
>>> change the usage of the src/dst_maxburst, but being able to set the FIFO
>>> size as well would be ideal.
>>
>> Looking at the drivers/dma/tegra210-adma.c for the
>> TEGRA*_FIFO_CTRL_DEFAULT definition it is still not clear where the
>> remote FIFO size would fit.
>> There are fields for overflow and starvation(?) thresholds and TX/RX
>> size (assuming word length, 3 == 32bits?).
> 
> The TX/RX size are the FIFO size. So 3 equates to a FIFO size of 3 * 64
> bytes.
> 
>> Both threshold is set to one, so I assume currently ADMA is
>> pushing/pulling data word by word.
> 
> That's different. That indicates thresholds when transfers start.
> 
>> Not sure what the burst size is used for, my guess would be that it is
>> used on the memory (DDR) side for optimized, more efficient accesses?
> 
> That is the actual burst size.
> 
>> My guess is that the threshold values are the counter limits, if the DMA
>> request counter reaches it then ADMA would do a threshold limit worth of
>> push/pull to ADMAIF.
>> Or there is another register where the remote FIFO size can be written
>> and ADMA is counting back from there until it reaches the threshold (and
>> pushes/pulling again threshold amount of data) so it keeps the FIFO
>> filled with at least threshold amount of data?
>>
>> I think in both cases the threshold would be the maxburst.
>>
>> I suppose you have the patch for adma on how to use the fifo_size
>> parameter? That would help understand what you are trying to achieve better.
> 
> Its quite simple, we would just use the FIFO size to set the fields
> TEGRAXXX_ADMA_CH_FIFO_CTRL_TXSIZE/RXSIZE in the
> TEGRAXXX_ADMA_CH_FIFO_CTRL register. That's all.
> 
> Jon
> 

Hi,

If I understood everything correctly, the FIFO buffer is shared among
all of the ADMA clients and hence it should be up to the ADMA driver to
manage the quotas of the clients. So if there is only one client that
uses ADMA at a time, then this client will get a whole FIFO buffer, but
once another client starts to use ADMA, then the ADMA driver will have
to reconfigure hardware to split the quotas.

-- 
Dmitry
