Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80E4B4B5EA
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2019 12:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfFSKIW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Jun 2019 06:08:22 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:37137 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfFSKIW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Jun 2019 06:08:22 -0400
Received: from 94.197.121.33.threembb.co.uk ([94.197.121.33] helo=[192.168.43.158])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hdXVq-00022U-Mu; Wed, 19 Jun 2019 11:08:18 +0100
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Support per-burst residue
 granularity
To:     Jon Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190613210849.10382-1-digetx@gmail.com>
 <f2290604-12f4-019b-47e7-4e4e29a433d4@codethink.co.uk>
 <7354d471-95e1-ffcd-db65-578e9aa425ac@gmail.com>
 <1db9bac2-957d-3c0a-948a-429bc59f1b72@nvidia.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <0f797be6-9b80-7c31-44ef-0df68d36252e@codethink.co.uk>
Date:   Wed, 19 Jun 2019 11:08:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1db9bac2-957d-3c0a-948a-429bc59f1b72@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19/06/2019 11:04, Jon Hunter wrote:
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
>>>>    drivers/dma/tegra20-apb-dma.c | 35 ++++++++++++++++++++++++++++-------
>>>>    1 file changed, 28 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>>>> index 79e9593815f1..c5af8f703548 100644
>>>> --- a/drivers/dma/tegra20-apb-dma.c
>>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>>> @@ -797,12 +797,36 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>>>>        return 0;
>>>>    }
>>>>    +static unsigned int tegra_dma_update_residual(struct tegra_dma_channel *tdc,
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

That might be the same thing we saw. IIRC it looks like the DMA has
moved on, but the count gets re-set before the EOC? I can't see that
git site so can't comment.

The only way to prove this would be to spend time running this up
with tracing (which is how we found the issue) and analysing the
output (it's also why we adding the kernel tracing in earlier
patches)

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
