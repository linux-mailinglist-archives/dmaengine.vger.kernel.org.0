Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68CB44B62E
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2019 12:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfFSK1e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Jun 2019 06:27:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39018 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfFSK1c (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Jun 2019 06:27:32 -0400
Received: by mail-lf1-f68.google.com with SMTP id p24so11696175lfo.6;
        Wed, 19 Jun 2019 03:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wy23WVAFMNzzYY79+Ss7U5VUGCY1fAwe+Ks92MNYJcA=;
        b=JY8aSeEXXwnaubHzeAGt4qebktJ0cmPLFPzARE+Xle/C/sUzJ0zJHpuWALRO/CVo6T
         mRfJI2UxQfLXsgvAaElJNTAr05q04d+pIdT5okiByUrb7pql3XIbK/GkEki7ZlP2xNSe
         22CmcKvFcV9nqetBeu2NC2Iod8kkt6SKdFejVhMBYITNEKBo2kP3tSNxLd35ZERw3ncC
         o10OeU7j8Kr1u6gb5GFoBpKHfFHhPPR0JNKtMdlgYo+z7o3B7rI3/Ziofj6JkYY5VEdr
         hxxOpqpZzI4L8WGZSLseI0HL0VR1UbZIwVnxmuN9FpbghD7ENf8sZUDDqvffBdBJEWG4
         m8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wy23WVAFMNzzYY79+Ss7U5VUGCY1fAwe+Ks92MNYJcA=;
        b=F1w3XR+9Wa4qAneYokf9mhWYBJIziK8xDltI6KlQYcQi2ddJjMt8zU9jYewJ9lUDSP
         46STGa5xO0WF446FkqAzcwmLrJtOxizYA3UIWLcKflkX0EQivpSLr0H5vmsVh8vE/K+L
         jUzQ2lN55OoSYaX9D+IGa1MgJFYxzvsEcYPSndtwbkCaUqKSPgiIhJCRpDjxIcnf80jq
         Mxbgey28OQfSmHf+Pz9GL1gDiIHu8GnZPwg2d13mcBOOTgbi/zx+Z3ySW26VGOgYg9Oi
         DE/H10w/u0RFm7lMwvc3HUCX5OrPNHjXi6bBzXoXHwxMmvFydU+ZlvC6r61mQTF/F2jH
         f0Dw==
X-Gm-Message-State: APjAAAWKevBog/jst+kqOkDU3+gB6zdhIvujjpOjk9gV3ohUzOQqYIGT
        tcscJjAeBg+ZNnhDXyHKSsnARK3X
X-Google-Smtp-Source: APXvYqxlbjExaeGdlE6PVLq80Nomu52hXD4OgLr0wrQ/P9LFDDrVlz6eBFZaXHC4lbT9DqcirmxewA==
X-Received: by 2002:a19:bec1:: with SMTP id o184mr31363372lff.86.1560940049495;
        Wed, 19 Jun 2019 03:27:29 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id q2sm2594636lfj.25.2019.06.19.03.27.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 03:27:28 -0700 (PDT)
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Support per-burst residue
 granularity
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c8bccb6e-27f8-d6c8-cfdb-10ab5ae98b26@gmail.com>
Date:   Wed, 19 Jun 2019 13:27:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1db9bac2-957d-3c0a-948a-429bc59f1b72@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

19.06.2019 13:04, Jon Hunter пишет:
> 
> On 19/06/2019 00:27, Dmitry Osipenko wrote:
>> 19.06.2019 1:22, Ben Dooks пишет:
>>> On 13/06/2019 22:08, Dmitry Osipenko wrote:
>>>> Tegra's APB DMA engine updates words counter after each transferred burst
>>>> of data, hence it can report transfer's residual with more fidelity which
>>>> may be required in cases like audio playback. In particular this fixes
>>>> audio stuttering during playback in a chromiuim web browser. The patch is
>>>> based on the original work that was made by Ben Dooks [1]. It was tested
>>>> on Tegra20 and Tegra30 devices.
>>>>
>>>> [1] https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@codethink.co.uk/
>>>>
>>>> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>   drivers/dma/tegra20-apb-dma.c | 35 ++++++++++++++++++++++++++++-------
>>>>   1 file changed, 28 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>>>> index 79e9593815f1..c5af8f703548 100644
>>>> --- a/drivers/dma/tegra20-apb-dma.c
>>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>>> @@ -797,12 +797,36 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>>>>       return 0;
>>>>   }
>>>>   +static unsigned int tegra_dma_update_residual(struct tegra_dma_channel *tdc,
>>>> +                          struct tegra_dma_sg_req *sg_req,
>>>> +                          struct tegra_dma_desc *dma_desc,
>>>> +                          unsigned int residual)
>>>> +{
>>>> +    unsigned long status, wcount = 0;
>>>> +
>>>> +    if (!list_is_first(&sg_req->node, &tdc->pending_sg_req))
>>>> +        return residual;
>>>> +
>>>> +    if (tdc->tdma->chip_data->support_separate_wcount_reg)
>>>> +        wcount = tdc_read(tdc, TEGRA_APBDMA_CHAN_WORD_TRANSFER);
>>>> +
>>>> +    status = tdc_read(tdc, TEGRA_APBDMA_CHAN_STATUS);
>>>> +
>>>> +    if (!tdc->tdma->chip_data->support_separate_wcount_reg)
>>>> +        wcount = status;
>>>> +
>>>> +    if (status & TEGRA_APBDMA_STATUS_ISE_EOC)
>>>> +        return residual - sg_req->req_len;
>>>> +
>>>> +    return residual - get_current_xferred_count(tdc, sg_req, wcount);
>>>> +}
>>>
>>> I am unfortunately nowhere near my notes, so can't completely
>>> review this. I think the complexity of my patch series is due
>>> to an issue with the count being updated before the EOC IRQ
>>> is actually flagged (and most definetly before it gets to the
>>> CPU IRQ handler).
>>>
>>> The test system I was using, which i've not really got any
>>> access to at the moment would show these internal inconsistent
>>> states every few hours, however it was moving 48kHz 8ch 16bit
>>> TDM data.
>>>
>>> Thanks for looking into this, I am not sure if I am going to
>>> get any time to look into this within the next couple of
>>> months.
>>
>> I'll try to add some debug checks to try to catch the case where count is updated before EOC
>> is set. Thank you very much for the clarification of the problem. So far I haven't spotted
>> anything going wrong.
>>
>> Jon / Laxman, are you aware about the possibility to get such inconsistency of words count
>> vs EOC? Assuming the cyclic transfer mode.
> 
> I can't say that I am. However, for the case of cyclic transfer, given
> that the next transfer is always programmed into the registers before
> the last one completes, I could see that by the time the interrupt is
> serviced that the DMA has moved on to the next transfer (which I assume
> would reset the count).
> 
> Interestingly, our downstream kernel implemented a change to avoid the
> count appearing to move backwards. I am curious if this also works,
> which would be a lot simpler that what Ben has implemented and may
> mitigate that race condition that Ben is describing.
> 
> Cheers
> Jon
> 
> [0]
> https://nv-tegra.nvidia.com/gitweb/?p=linux-4.4.git;a=commit;h=c7bba40c6846fbf3eaad35c4472dcc7d8bbc02e5
> 

The downstream patch doesn't check for EOC and has no comments about it, so it's hard to
tell if it's intentional. Secondly, looks like the downstream patch is mucked up because it
doesn't check whether the dma_desc is *the active* transfer and not a pending!

Jon, thanks for the pointer anyway! I'll try to catch the case that Ben is describing by
adding some extra debug checks, will come back with a report after thorough testing.
