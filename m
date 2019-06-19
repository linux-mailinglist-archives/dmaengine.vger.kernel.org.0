Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B790D4B932
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2019 14:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731739AbfFSMzu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Jun 2019 08:55:50 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:41584 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfFSMzu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Jun 2019 08:55:50 -0400
Received: from 92.40.248.88.threembb.co.uk ([92.40.248.88] helo=[192.168.43.158])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hda7t-0005rZ-UF; Wed, 19 Jun 2019 13:55:46 +0100
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Support per-burst residue
 granularity
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
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
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <2e355ba0-2a77-3b39-7cec-cf580cd609b4@codethink.co.uk>
Date:   Wed, 19 Jun 2019 13:55:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <73d5cdb7-0462-944a-1f9a-3dc02f179385@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19/06/2019 12:10, Dmitry Osipenko wrote:
> 19.06.2019 13:55, Jon Hunter пишет:
>>
>> On 19/06/2019 11:27, Dmitry Osipenko wrote:
>>> 19.06.2019 13:04, Jon Hunter пишет:
>>>>
>>>> On 19/06/2019 00:27, Dmitry Osipenko wrote:
>>>>> 19.06.2019 1:22, Ben Dooks пишет:
>>>>>> On 13/06/2019 22:08, Dmitry Osipenko wrote:
>>>>>>> Tegra's APB DMA engine updates words counter after each transferred burst
>>>>>>> of data, hence it can report transfer's residual with more fidelity which
>>>>>>> may be required in cases like audio playback. In particular this fixes
>>>>>>> audio stuttering during playback in a chromiuim web browser. The patch is
>>>>>>> based on the original work that was made by Ben Dooks [1]. It was tested
>>>>>>> on Tegra20 and Tegra30 devices.
>>>>>>>
>>>>>>> [1] https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@codethink.co.uk/
>>>>>>>
>>>>>>> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>> ---
>>>>>>>    drivers/dma/tegra20-apb-dma.c | 35 ++++++++++++++++++++++++++++-------
>>>>>>>    1 file changed, 28 insertions(+), 7 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>>>>>>> index 79e9593815f1..c5af8f703548 100644
>>>>>>> --- a/drivers/dma/tegra20-apb-dma.c
>>>>>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>>>>>> @@ -797,12 +797,36 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>>>>>>>        return 0;
>>>>>>>    }
>>>>>>>    +static unsigned int tegra_dma_update_residual(struct tegra_dma_channel *tdc,
>>>>>>> +                          struct tegra_dma_sg_req *sg_req,
>>>>>>> +                          struct tegra_dma_desc *dma_desc,
>>>>>>> +                          unsigned int residual)
>>>>>>> +{
>>>>>>> +    unsigned long status, wcount = 0;
>>>>>>> +
>>>>>>> +    if (!list_is_first(&sg_req->node, &tdc->pending_sg_req))
>>>>>>> +        return residual;
>>>>>>> +
>>>>>>> +    if (tdc->tdma->chip_data->support_separate_wcount_reg)
>>>>>>> +        wcount = tdc_read(tdc, TEGRA_APBDMA_CHAN_WORD_TRANSFER);
>>>>>>> +
>>>>>>> +    status = tdc_read(tdc, TEGRA_APBDMA_CHAN_STATUS);
>>>>>>> +
>>>>>>> +    if (!tdc->tdma->chip_data->support_separate_wcount_reg)
>>>>>>> +        wcount = status;
>>>>>>> +
>>>>>>> +    if (status & TEGRA_APBDMA_STATUS_ISE_EOC)
>>>>>>> +        return residual - sg_req->req_len;
>>>>>>> +
>>>>>>> +    return residual - get_current_xferred_count(tdc, sg_req, wcount);
>>>>>>> +}
>>>>>>
>>>>>> I am unfortunately nowhere near my notes, so can't completely
>>>>>> review this. I think the complexity of my patch series is due
>>>>>> to an issue with the count being updated before the EOC IRQ
>>>>>> is actually flagged (and most definetly before it gets to the
>>>>>> CPU IRQ handler).
>>>>>>
>>>>>> The test system I was using, which i've not really got any
>>>>>> access to at the moment would show these internal inconsistent
>>>>>> states every few hours, however it was moving 48kHz 8ch 16bit
>>>>>> TDM data.
>>>>>>
>>>>>> Thanks for looking into this, I am not sure if I am going to
>>>>>> get any time to look into this within the next couple of
>>>>>> months.
>>>>>
>>>>> I'll try to add some debug checks to try to catch the case where count is updated before EOC
>>>>> is set. Thank you very much for the clarification of the problem. So far I haven't spotted
>>>>> anything going wrong.
>>>>>
>>>>> Jon / Laxman, are you aware about the possibility to get such inconsistency of words count
>>>>> vs EOC? Assuming the cyclic transfer mode.
>>>>
>>>> I can't say that I am. However, for the case of cyclic transfer, given
>>>> that the next transfer is always programmed into the registers before
>>>> the last one completes, I could see that by the time the interrupt is
>>>> serviced that the DMA has moved on to the next transfer (which I assume
>>>> would reset the count).
>>>>
>>>> Interestingly, our downstream kernel implemented a change to avoid the
>>>> count appearing to move backwards. I am curious if this also works,
>>>> which would be a lot simpler that what Ben has implemented and may
>>>> mitigate that race condition that Ben is describing.
>>>>
>>>> Cheers
>>>> Jon
>>>>
>>>> [0]
>>>> https://nv-tegra.nvidia.com/gitweb/?p=linux-4.4.git;a=commit;h=c7bba40c6846fbf3eaad35c4472dcc7d8bbc02e5
>>>>
>>>
>>> The downstream patch doesn't check for EOC and has no comments about it, so it's hard to
>>> tell if it's intentional. Secondly, looks like the downstream patch is mucked up because it
>>> doesn't check whether the dma_desc is *the active* transfer and not a pending!
>>
>> I agree that it should check to see if it is active. I assume that what
>> this patch is doing is not updating the dma position if it appears to
>> have gone backwards, implying we have moved on to the next buffer. Yes
>> this is still probably not as accurate as Ben's implementation because
>> most likely we have finished that transfer and this patch would report
>> that it is not quite finished.
>>
>> If Ben's patch works for you then why not go with this?
> 
> Because I'm doubtful that it is really the case and not something else. It will be very odd
> if hardware updates words count and sets EOC asynchronously, I'd call it as a faulty design
> and thus a bug that need to worked around in software if that's really happening.

Unfortunately someone designed hardware which does not update all the
state in one go. Find the designer and make them explain why they did
this.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
