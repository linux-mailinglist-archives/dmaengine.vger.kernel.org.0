Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3159C4C35D
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2019 23:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfFSV4Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Jun 2019 17:56:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39465 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSV4Q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Jun 2019 17:56:16 -0400
Received: by mail-lf1-f67.google.com with SMTP id p24so806461lfo.6;
        Wed, 19 Jun 2019 14:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5O1FV8+B+L9riSW3t9VErhl/8bqt/6TXw2Ym602mYSk=;
        b=vWL/b9BR5zOoXg+nqsahUsG03rYnF4V3nE/7CEYXMnvBdP21voEPeSp4WUbR+ZFW/E
         317YFl7wg8HQ3etGO7QzVL4x1u8+TY8SZeYxFXM7Kd7xiTrZTyyaz7GPv1MxFf1LqGRZ
         VKS/dI+R0RzgXG2WCEYtDhcwC+GEgEbf5YwQi7OgMeOjgVXh+DDheB4fdeRLPVG8vldP
         dkjO24iiSYZCRrhfHylgLUkDBK6Lr7MobiNmSUD3psNGuzX82VJ93ZoGzvwPzTNznA7b
         Gyl5P67EmmQHOZTnDNiL8Z2x4s8W1sY8si9l9Z6cvqlIA4JXHB5a06zzufZepGNgOYEL
         U2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5O1FV8+B+L9riSW3t9VErhl/8bqt/6TXw2Ym602mYSk=;
        b=P6yNpJAQFAadIG2hxgDicNaWr6HeWBekuajSHNpY507Bn/3+uX52OxRHT70xPuk+4a
         QUPEd9YM2PH6jXhkY67Et1Xt1KE+x0SFJuTLwQi/mocKE5DLAPR1bR6feNUn/imtjWJM
         1UhYna6d23rR5OSjB8oAtskSv5fEN0Y7WVc3JbP/CPLj6I7K/BT/Gh9Gi+np80yf09Qg
         tQG7IV5TYcPoQ0ZCDUDew9KVgn/cmc6bqTKk6mViIiOUsYIOL3bmSLq8xL3DgH+DbuM6
         aP979ed7fO18a2PmpvH0je+3ACh3GkrNHYbBJCkjk3++naZ7uurIHkoPTzEuJXBcPGGd
         rhMw==
X-Gm-Message-State: APjAAAVI43hqE4AY6SSZdFCv4t9IxuIKjte5/2uFdKilrV0AKGDe1e9u
        h5KJTmNdkPNns/OmYSrkhRrxmH+B
X-Google-Smtp-Source: APXvYqymyOzhDCHB5bLsTkfZz6UY7m4PQGBq0/wwPbz8qJXJcL0bZKMZWdM46xUx69PgP9W/gZsuog==
X-Received: by 2002:a19:6703:: with SMTP id b3mr64158134lfc.153.1560981372050;
        Wed, 19 Jun 2019 14:56:12 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id f16sm3188232lfc.81.2019.06.19.14.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:56:10 -0700 (PDT)
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Support per-burst residue
 granularity
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190613210849.10382-1-digetx@gmail.com>
 <f2290604-12f4-019b-47e7-4e4e29a433d4@codethink.co.uk>
 <7354d471-95e1-ffcd-db65-578e9aa425ac@gmail.com>
 <1db9bac2-957d-3c0a-948a-429bc59f1b72@nvidia.com>
 <c8bccb6e-27f8-d6c8-cfdb-10ab5ae98b26@gmail.com>
 <49d087fe-a634-4a53-1caa-58a0e52ef1ba@nvidia.com>
 <73d5cdb7-0462-944a-1f9a-3dc02f179385@gmail.com>
 <c7e4d99a-f02f-e7a2-a4c2-81496ee54d24@nvidia.com>
 <1de7d185-54c3-be83-cb37-4f2fd009253f@gmail.com>
Message-ID: <c2e2e476-2bae-9661-6445-56390b58b3bb@gmail.com>
Date:   Thu, 20 Jun 2019 00:56:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1de7d185-54c3-be83-cb37-4f2fd009253f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

19.06.2019 16:52, Dmitry Osipenko пишет:
> 19.06.2019 15:22, Jon Hunter пишет:
>>
>> On 19/06/2019 12:10, Dmitry Osipenko wrote:
>>> 19.06.2019 13:55, Jon Hunter пишет:
>>>>
>>>> On 19/06/2019 11:27, Dmitry Osipenko wrote:
>>>>> 19.06.2019 13:04, Jon Hunter пишет:
>>>>>>
>>>>>> On 19/06/2019 00:27, Dmitry Osipenko wrote:
>>>>>>> 19.06.2019 1:22, Ben Dooks пишет:
>>>>>>>> On 13/06/2019 22:08, Dmitry Osipenko wrote:
>>>>>>>>> Tegra's APB DMA engine updates words counter after each transferred burst
>>>>>>>>> of data, hence it can report transfer's residual with more fidelity which
>>>>>>>>> may be required in cases like audio playback. In particular this fixes
>>>>>>>>> audio stuttering during playback in a chromiuim web browser. The patch is
>>>>>>>>> based on the original work that was made by Ben Dooks [1]. It was tested
>>>>>>>>> on Tegra20 and Tegra30 devices.
>>>>>>>>>
>>>>>>>>> [1] https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@codethink.co.uk/
>>>>>>>>>
>>>>>>>>> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>>>> ---
>>>>>>>>>   drivers/dma/tegra20-apb-dma.c | 35 ++++++++++++++++++++++++++++-------
>>>>>>>>>   1 file changed, 28 insertions(+), 7 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>>>>>>>>> index 79e9593815f1..c5af8f703548 100644
>>>>>>>>> --- a/drivers/dma/tegra20-apb-dma.c
>>>>>>>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>>>>>>>> @@ -797,12 +797,36 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>>>>>>>>>       return 0;
>>>>>>>>>   }
>>>>>>>>>   +static unsigned int tegra_dma_update_residual(struct tegra_dma_channel *tdc,
>>>>>>>>> +                          struct tegra_dma_sg_req *sg_req,
>>>>>>>>> +                          struct tegra_dma_desc *dma_desc,
>>>>>>>>> +                          unsigned int residual)
>>>>>>>>> +{
>>>>>>>>> +    unsigned long status, wcount = 0;
>>>>>>>>> +
>>>>>>>>> +    if (!list_is_first(&sg_req->node, &tdc->pending_sg_req))
>>>>>>>>> +        return residual;
>>>>>>>>> +
>>>>>>>>> +    if (tdc->tdma->chip_data->support_separate_wcount_reg)
>>>>>>>>> +        wcount = tdc_read(tdc, TEGRA_APBDMA_CHAN_WORD_TRANSFER);
>>>>>>>>> +
>>>>>>>>> +    status = tdc_read(tdc, TEGRA_APBDMA_CHAN_STATUS);
>>>>>>>>> +
>>>>>>>>> +    if (!tdc->tdma->chip_data->support_separate_wcount_reg)
>>>>>>>>> +        wcount = status;
>>>>>>>>> +
>>>>>>>>> +    if (status & TEGRA_APBDMA_STATUS_ISE_EOC)
>>>>>>>>> +        return residual - sg_req->req_len;
>>>>>>>>> +
>>>>>>>>> +    return residual - get_current_xferred_count(tdc, sg_req, wcount);
>>>>>>>>> +}
>>>>>>>>
>>>>>>>> I am unfortunately nowhere near my notes, so can't completely
>>>>>>>> review this. I think the complexity of my patch series is due
>>>>>>>> to an issue with the count being updated before the EOC IRQ
>>>>>>>> is actually flagged (and most definetly before it gets to the
>>>>>>>> CPU IRQ handler).
>>>>>>>>
>>>>>>>> The test system I was using, which i've not really got any
>>>>>>>> access to at the moment would show these internal inconsistent
>>>>>>>> states every few hours, however it was moving 48kHz 8ch 16bit
>>>>>>>> TDM data.
>>>>>>>>
>>>>>>>> Thanks for looking into this, I am not sure if I am going to
>>>>>>>> get any time to look into this within the next couple of
>>>>>>>> months.
>>>>>>>
>>>>>>> I'll try to add some debug checks to try to catch the case where count is updated before EOC
>>>>>>> is set. Thank you very much for the clarification of the problem. So far I haven't spotted
>>>>>>> anything going wrong.
>>>>>>>
>>>>>>> Jon / Laxman, are you aware about the possibility to get such inconsistency of words count
>>>>>>> vs EOC? Assuming the cyclic transfer mode.
>>>>>>
>>>>>> I can't say that I am. However, for the case of cyclic transfer, given
>>>>>> that the next transfer is always programmed into the registers before
>>>>>> the last one completes, I could see that by the time the interrupt is
>>>>>> serviced that the DMA has moved on to the next transfer (which I assume
>>>>>> would reset the count).
>>>>>>
>>>>>> Interestingly, our downstream kernel implemented a change to avoid the
>>>>>> count appearing to move backwards. I am curious if this also works,
>>>>>> which would be a lot simpler that what Ben has implemented and may
>>>>>> mitigate that race condition that Ben is describing.
>>>>>>
>>>>>> Cheers
>>>>>> Jon
>>>>>>
>>>>>> [0]
>>>>>> https://nv-tegra.nvidia.com/gitweb/?p=linux-4.4.git;a=commit;h=c7bba40c6846fbf3eaad35c4472dcc7d8bbc02e5
>>>>>>
>>>>>
>>>>> The downstream patch doesn't check for EOC and has no comments about it, so it's hard to
>>>>> tell if it's intentional. Secondly, looks like the downstream patch is mucked up because it
>>>>> doesn't check whether the dma_desc is *the active* transfer and not a pending!
>>>>
>>>> I agree that it should check to see if it is active. I assume that what
>>>> this patch is doing is not updating the dma position if it appears to
>>>> have gone backwards, implying we have moved on to the next buffer. Yes
>>>> this is still probably not as accurate as Ben's implementation because
>>>> most likely we have finished that transfer and this patch would report
>>>> that it is not quite finished.
>>>>
>>>> If Ben's patch works for you then why not go with this?
>>>
>>> Because I'm doubtful that it is really the case and not something else. It will be very odd
>>> if hardware updates words count and sets EOC asynchronously, I'd call it as a faulty design
>>> and thus a bug that need to worked around in software if that's really happening.
>>
>> I don't see it that way. Probably as soon as the EOC happens, if there
>> is another transfer queued up, the next transfer will start and count
>> gets reset. So if you happen to asynchronously read the count at the
>> very end of the transfer, then it is possible you are doing so at the
>> same time that the EOC occurs but before the ISR has been triggered.
> 
> In our case we can't read out EOC status and words count asynchronously because the
> interrupt status and words count are within the same hardware register on pre-T114 and on
> T114+ we're reading words count register and only then the status register. ISR has nothing
> to do with it, if you're taking about tegra_dma_isr.
> 
> Ben claims that the words count may get updated in hardware before EOC bit is set in the
> status register.
> 

I made a test setup where several millions test-runs were made, checking
the EOC vs words count wraparound in a cyclic transfer mode (polling
words count until EOC is set) with different buffer sizes (buffer size =
period, single SG nent) and different burst configurations. Result is
good, the case Ben describes never happens on T30 nor on T20. So I'm
confident now that hardware is fine and likely that Ben was experiencing
some other problem.

Jon, please take a look at the v2. It should be good to go!
