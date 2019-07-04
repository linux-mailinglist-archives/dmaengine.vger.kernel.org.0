Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4475F83E
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jul 2019 14:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfGDMfx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 Jul 2019 08:35:53 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43123 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbfGDMfx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 Jul 2019 08:35:53 -0400
Received: by mail-qt1-f195.google.com with SMTP id w17so4655061qto.10;
        Thu, 04 Jul 2019 05:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dyG6lnQJBuGgcUgdBBZasR0dEHoA5Vkd6xguvT62Y8E=;
        b=rdSaiyJd4pph7e/asvh04N0pjusnG2lH08SdKP98o+TEVQNVurvPbaFUu2RiVuZyCt
         Nq78SEzxLLYa4Xonv74uc/ufeTGZJmpVjJog5SLVAPQ3PNGc5+VQOyOC7ncB2FNjHtAo
         4S3X9Is4h5fvaBx7ipbSa3YY8jDFiqiR8JJLwnrA0T8qt3bMC8afAIxtYFfEZuU+3kqt
         v1Q5+Bjnisw7XaJ7EPituDfRWQ5PNTysBGA4HZrCAgGHFNZK4phheTQo+SPwDghSiAzv
         TKj3TSMZVqsH0ZzGOFFqoX86Sl359IyunG4S2DXcMJNWUnMbQegABdmT9WvWHaCV5Nod
         vTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dyG6lnQJBuGgcUgdBBZasR0dEHoA5Vkd6xguvT62Y8E=;
        b=aaBtwLbg6gWAh6feIUxJBLQRekjYt5fi59zP4rncIOkpVesikOblbH8VGyOQC4gbUG
         9s/Mzj0bNUWNTUI8XSzvaOvnX8k9HEZxNTKU2OVA3tHEdnDgGR2Xv57mlG2We76qwG9B
         eE/7+DnfsfK+C0fXIDNE5gDOLDWkijgdyV+q0oVDaeSs8k3rhfcP59eUhKnybCMMuV8+
         h5LVBRa4E87Pi0kJUjeTLNCO6qvJUKQP9KbRDGbg1hkbm5p3ksAFM5VgRDYWOQp+2coH
         K8LQ+H4pjN3FgTpR2uhCwSa8I9dB1TUfvIZyv2aYoWKCN7mpvefX45dhUaY0luMveDLb
         0cvw==
X-Gm-Message-State: APjAAAVYRA45re9boQduuMJiyt+FT/V0Yngo+DJU10IlNW1F+/G6xzUi
        lkpmCHOyL4U16s5AtlMZs/w9mlT0
X-Google-Smtp-Source: APXvYqy3DfOqU7VCY9/aQ+nm2sfjaPh/FKoAh5IG422xREK1YzUpeSbnntUdmPUIL0d1amYWl2Ag/Q==
X-Received: by 2002:a0c:d0b6:: with SMTP id z51mr37061024qvg.3.1562243752105;
        Thu, 04 Jul 2019 05:35:52 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id y9sm1942160qki.116.2019.07.04.05.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 05:35:51 -0700 (PDT)
Subject: Re: [PATCH v4] dmaengine: tegra-apb: Support per-burst residue
 granularity
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190703012836.16568-1-digetx@gmail.com>
 <b0a0b110-61c8-ae8b-22a0-3311f70b428a@nvidia.com>
 <b1f4d7c3-636e-947f-ac76-fc639ac7fee4@gmail.com>
 <55d402ad-6cb9-9e91-a8a4-b89d37674f4d@nvidia.com>
 <a0168814-09e2-6dfe-5c5c-e053911cede6@gmail.com>
 <940563c4-e2e9-c1d8-ac74-e6871e086746@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <00b5d649-df97-455f-6e2a-a1adb44e431d@gmail.com>
Date:   Thu, 4 Jul 2019 15:35:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <940563c4-e2e9-c1d8-ac74-e6871e086746@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

04.07.2019 15:08, Jon Hunter пишет:
> 
> On 04/07/2019 11:49, Dmitry Osipenko wrote:
>> 04.07.2019 10:10, Jon Hunter пишет:
>>>
>>> On 03/07/2019 18:00, Dmitry Osipenko wrote:
>>>> 03.07.2019 19:37, Jon Hunter пишет:
>>>>>
>>>>> On 03/07/2019 02:28, Dmitry Osipenko wrote:
>>>>>> Tegra's APB DMA engine updates words counter after each transferred burst
>>>>>> of data, hence it can report transfer's residual with more fidelity which
>>>>>> may be required in cases like audio playback. In particular this fixes
>>>>>> audio stuttering during playback in a chromium web browser. The patch is
>>>>>> based on the original work that was made by Ben Dooks and a patch from
>>>>>> downstream kernel. It was tested on Tegra20 and Tegra30 devices.
>>>>>>
>>>>>> Link: https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@codethink.co.uk/
>>>>>> Link: https://nv-tegra.nvidia.com/gitweb/?p=linux-4.4.git;a=commit;h=c7bba40c6846fbf3eaad35c4472dcc7d8bbc02e5
>>>>>> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>>>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>> ---
>>>>>>
>>>>>> Changelog:
>>>>>>
>>>>>> v4: The words_xferred is now also reset on a new iteration of a cyclic
>>>>>>     transfer by ISR, so that dmaengine_tx_status() won't produce a
>>>>>>     misleading warning splat on TX status re-checking after a cycle
>>>>>>     completion when cyclic transfer consists of a single SG.
>>>>>>
>>>>>> v3: Added workaround for a hardware design shortcoming that results
>>>>>>     in a words counter wraparound before end-of-transfer bit is set
>>>>>>     in a cyclic mode.
>>>>>>
>>>>>> v2: Addressed review comments made by Jon Hunter to v1. We won't try
>>>>>>     to get words count if dma_desc is on free list as it will result
>>>>>>     in a NULL dereference because this case wasn't handled properly.
>>>>>>
>>>>>>     The residual value is now updated properly, avoiding potential
>>>>>>     integer overflow by adding the "bytes" to the "bytes_transferred"
>>>>>>     instead of the subtraction.
>>>>>>
>>>>>>  drivers/dma/tegra20-apb-dma.c | 72 +++++++++++++++++++++++++++++++----
>>>>>>  1 file changed, 65 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>>>>>> index 79e9593815f1..148d136191d7 100644
>>>>>> --- a/drivers/dma/tegra20-apb-dma.c
>>>>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>>>>> @@ -152,6 +152,7 @@ struct tegra_dma_sg_req {
>>>>>>  	bool				last_sg;
>>>>>>  	struct list_head		node;
>>>>>>  	struct tegra_dma_desc		*dma_desc;
>>>>>> +	unsigned int			words_xferred;
>>>>>>  };
>>>>>>  
>>>>>>  /*
>>>>>> @@ -496,6 +497,7 @@ static void tegra_dma_configure_for_next(struct tegra_dma_channel *tdc,
>>>>>>  	tdc_write(tdc, TEGRA_APBDMA_CHAN_CSR,
>>>>>>  				nsg_req->ch_regs.csr | TEGRA_APBDMA_CSR_ENB);
>>>>>>  	nsg_req->configured = true;
>>>>>> +	nsg_req->words_xferred = 0;
>>>>>>  
>>>>>>  	tegra_dma_resume(tdc);
>>>>>>  }
>>>>>> @@ -511,6 +513,7 @@ static void tdc_start_head_req(struct tegra_dma_channel *tdc)
>>>>>>  					typeof(*sg_req), node);
>>>>>>  	tegra_dma_start(tdc, sg_req);
>>>>>>  	sg_req->configured = true;
>>>>>> +	sg_req->words_xferred = 0;
>>>>>>  	tdc->busy = true;
>>>>>>  }
>>>>>>  
>>>>>> @@ -638,6 +641,8 @@ static void handle_cont_sngl_cycle_dma_done(struct tegra_dma_channel *tdc,
>>>>>>  		list_add_tail(&dma_desc->cb_node, &tdc->cb_desc);
>>>>>>  	dma_desc->cb_count++;
>>>>>>  
>>>>>> +	sgreq->words_xferred = 0;
>>>>>> +
>>>>>>  	/* If not last req then put at end of pending list */
>>>>>>  	if (!list_is_last(&sgreq->node, &tdc->pending_sg_req)) {
>>>>>>  		list_move_tail(&sgreq->node, &tdc->pending_sg_req);
>>>>>> @@ -797,6 +802,62 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>>>>>>  	return 0;
>>>>>>  }
>>>>>>  
>>>>>> +static unsigned int tegra_dma_sg_bytes_xferred(struct tegra_dma_channel *tdc,
>>>>>> +					       struct tegra_dma_sg_req *sg_req)
>>>>>> +{
>>>>>> +	unsigned long status, wcount = 0;
>>>>>> +
>>>>>> +	if (!list_is_first(&sg_req->node, &tdc->pending_sg_req))
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	if (tdc->tdma->chip_data->support_separate_wcount_reg)
>>>>>> +		wcount = tdc_read(tdc, TEGRA_APBDMA_CHAN_WORD_TRANSFER);
>>>>>> +
>>>>>> +	status = tdc_read(tdc, TEGRA_APBDMA_CHAN_STATUS);
>>>>>> +
>>>>>> +	if (!tdc->tdma->chip_data->support_separate_wcount_reg)
>>>>>> +		wcount = status;
>>>>>> +
>>>>>> +	if (status & TEGRA_APBDMA_STATUS_ISE_EOC)
>>>>>> +		return sg_req->req_len;
>>>>>> +
>>>>>> +	wcount = get_current_xferred_count(tdc, sg_req, wcount);
>>>>>> +
>>>>>> +	if (!wcount) {
>>>>>> +		/*
>>>>>> +		 * If wcount wasn't ever polled for this SG before, then
>>>>>> +		 * simply assume that transfer hasn't started yet.
>>>>>> +		 *
>>>>>> +		 * Otherwise it's the end of the transfer.
>>>>>> +		 *
>>>>>> +		 * The alternative would be to poll the status register
>>>>>> +		 * until EOC bit is set or wcount goes UP. That's so
>>>>>> +		 * because EOC bit is getting set only after the last
>>>>>> +		 * burst's completion and counter is less than the actual
>>>>>> +		 * transfer size by 4 bytes. The counter value wraps around
>>>>>> +		 * in a cyclic mode before EOC is set(!), so we can't easily
>>>>>> +		 * distinguish start of transfer from its end.
>>>>>> +		 */
>>>>>> +		if (sg_req->words_xferred)
>>>>>> +			wcount = sg_req->req_len - 4;
>>>>>> +
>>>>>> +	} else if (wcount < sg_req->words_xferred) {
>>>>>> +		/*
>>>>>> +		 * This case shall not ever happen because EOC bit
>>>>>> +		 * must be set once next cyclic transfer is started.
>>>>>
>>>>> Should this still be cyclic here?
>>>>
>>>> Do you mean the "comment" by "here"?
>>>>
>>>> It will be absolutely terrible if this case happens for oneshot transfer, assume
>>>> kernel/hardware is on fire.
>>>
>>> Or more likely a SW bug :-)
>>>
>>> Yes should never happen for either sg or cyclic, but there is no mention
>>> of sg transfers. Maybe the sg case is more obvious but in general this
>>> case should never happen for any transfer.
>>
>> Alright, so what the change you are proposing? Or is it fine now?
>>
>> I can certainly change the comment's wording, just please tell me what you want it to be.
>>
>> /*
>>  * This case shall not ever happen because EOC bit
>>  * must be set once transfer is actually finished.
>>
>> Does this sound better?
> 
> If I think it would be good to say ...
> 
> This case will never happen for a non-cyclic transfer. For a cyclic
> transfer, although it is possible for the next transfer to have already
> started (resetting the word count), this case should still not happen
> because we should have detected that the EOC bit is set and hence the
> transfer was completed.
> 
> At least that should remind me of what we are doing here in the future :-)

Okay, good to me. Will make a v5!
