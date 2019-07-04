Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE1B5F6D2
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jul 2019 12:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfGDKuB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 Jul 2019 06:50:01 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33375 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfGDKuB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 Jul 2019 06:50:01 -0400
Received: by mail-qk1-f193.google.com with SMTP id r6so5236482qkc.0;
        Thu, 04 Jul 2019 03:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZpEm0qbYV2AOo6mYpK2DWfLknfBvYxL9zIA4zwMNziY=;
        b=r3HGrjnE9Q9FvvzzC0UPykUCtL1UGrm9Knuvsvy5V0elmtwtxUTD3hH6yFZOWmBPCV
         g5cRQzrE+fs+zfS7nh/0GXJgfQI0gqesPfrObWslpWMFKP2LjZ9BO8leWvM0uFdToWs/
         4u7m/5otx9KLmBPcJS5GQHdHBi8SdExi868QPEHnEo9COGdtHFOtwfrbqmHYLsw99B1+
         nO05Jov0TRsn7rEQ/E3HJVc0+YWXscX4du995SpBNGTZx/O1VXGReqkbNEpc4YSi/1v6
         +2qghIRbN0fLXKgvqX1itMOmax85xbz7pN3HeINX3qdg7ZWEPoHc6d30xMj8itvX53nq
         lLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZpEm0qbYV2AOo6mYpK2DWfLknfBvYxL9zIA4zwMNziY=;
        b=T+LxYRlmwjUBDZ2iYixtolSBXH0UfibF0qHmt74l+6fl9Na9a7gqjtaa8KQtpfX5aU
         2H0FVVrKa8IrBAAEMwgsSvSMe9YKpaB3MI2MSxA4xktUbIzX4/0zK/o86yWl+ONXsQz0
         566Mxu0ayhwso17OTBQHLFibRR+gzGfc3aVhFiHLP9CHM/9Nv9HnN/n6JHVf/jcBhzx8
         8X/os6E7Z8apJmtR3kpeDhfDdSwhC50aoBoeBgRhiXoaHaghP65+yxMSnTka4TfWKrOk
         Su1AMFZyUFqaegC7hEjVKSymdS6zUnp4wMJ05NMF4rXeodNR63l7PL2JaRX+uoXINuKt
         gTEA==
X-Gm-Message-State: APjAAAUe0bIqPdAd+cXYgpx9KxqHP309LBg3UgqcoxNGRHDc2SFfnLS6
        Vp5ZJAD7ABXv2UTwJznxkmIbi+6H
X-Google-Smtp-Source: APXvYqxBROn75GpAf/0WcDoaJ/874C8/GHpcSFFhkDXK6dT5Zh72jGJ3MJiNQSruJE1iHqCmPEqs+A==
X-Received: by 2002:a37:2c46:: with SMTP id s67mr35667468qkh.396.1562237399657;
        Thu, 04 Jul 2019 03:49:59 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id y9sm1837259qki.116.2019.07.04.03.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 03:49:58 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a0168814-09e2-6dfe-5c5c-e053911cede6@gmail.com>
Date:   Thu, 4 Jul 2019 13:49:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <55d402ad-6cb9-9e91-a8a4-b89d37674f4d@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

04.07.2019 10:10, Jon Hunter пишет:
> 
> On 03/07/2019 18:00, Dmitry Osipenko wrote:
>> 03.07.2019 19:37, Jon Hunter пишет:
>>>
>>> On 03/07/2019 02:28, Dmitry Osipenko wrote:
>>>> Tegra's APB DMA engine updates words counter after each transferred burst
>>>> of data, hence it can report transfer's residual with more fidelity which
>>>> may be required in cases like audio playback. In particular this fixes
>>>> audio stuttering during playback in a chromium web browser. The patch is
>>>> based on the original work that was made by Ben Dooks and a patch from
>>>> downstream kernel. It was tested on Tegra20 and Tegra30 devices.
>>>>
>>>> Link: https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@codethink.co.uk/
>>>> Link: https://nv-tegra.nvidia.com/gitweb/?p=linux-4.4.git;a=commit;h=c7bba40c6846fbf3eaad35c4472dcc7d8bbc02e5
>>>> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>
>>>> Changelog:
>>>>
>>>> v4: The words_xferred is now also reset on a new iteration of a cyclic
>>>>     transfer by ISR, so that dmaengine_tx_status() won't produce a
>>>>     misleading warning splat on TX status re-checking after a cycle
>>>>     completion when cyclic transfer consists of a single SG.
>>>>
>>>> v3: Added workaround for a hardware design shortcoming that results
>>>>     in a words counter wraparound before end-of-transfer bit is set
>>>>     in a cyclic mode.
>>>>
>>>> v2: Addressed review comments made by Jon Hunter to v1. We won't try
>>>>     to get words count if dma_desc is on free list as it will result
>>>>     in a NULL dereference because this case wasn't handled properly.
>>>>
>>>>     The residual value is now updated properly, avoiding potential
>>>>     integer overflow by adding the "bytes" to the "bytes_transferred"
>>>>     instead of the subtraction.
>>>>
>>>>  drivers/dma/tegra20-apb-dma.c | 72 +++++++++++++++++++++++++++++++----
>>>>  1 file changed, 65 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>>>> index 79e9593815f1..148d136191d7 100644
>>>> --- a/drivers/dma/tegra20-apb-dma.c
>>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>>> @@ -152,6 +152,7 @@ struct tegra_dma_sg_req {
>>>>  	bool				last_sg;
>>>>  	struct list_head		node;
>>>>  	struct tegra_dma_desc		*dma_desc;
>>>> +	unsigned int			words_xferred;
>>>>  };
>>>>  
>>>>  /*
>>>> @@ -496,6 +497,7 @@ static void tegra_dma_configure_for_next(struct tegra_dma_channel *tdc,
>>>>  	tdc_write(tdc, TEGRA_APBDMA_CHAN_CSR,
>>>>  				nsg_req->ch_regs.csr | TEGRA_APBDMA_CSR_ENB);
>>>>  	nsg_req->configured = true;
>>>> +	nsg_req->words_xferred = 0;
>>>>  
>>>>  	tegra_dma_resume(tdc);
>>>>  }
>>>> @@ -511,6 +513,7 @@ static void tdc_start_head_req(struct tegra_dma_channel *tdc)
>>>>  					typeof(*sg_req), node);
>>>>  	tegra_dma_start(tdc, sg_req);
>>>>  	sg_req->configured = true;
>>>> +	sg_req->words_xferred = 0;
>>>>  	tdc->busy = true;
>>>>  }
>>>>  
>>>> @@ -638,6 +641,8 @@ static void handle_cont_sngl_cycle_dma_done(struct tegra_dma_channel *tdc,
>>>>  		list_add_tail(&dma_desc->cb_node, &tdc->cb_desc);
>>>>  	dma_desc->cb_count++;
>>>>  
>>>> +	sgreq->words_xferred = 0;
>>>> +
>>>>  	/* If not last req then put at end of pending list */
>>>>  	if (!list_is_last(&sgreq->node, &tdc->pending_sg_req)) {
>>>>  		list_move_tail(&sgreq->node, &tdc->pending_sg_req);
>>>> @@ -797,6 +802,62 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +static unsigned int tegra_dma_sg_bytes_xferred(struct tegra_dma_channel *tdc,
>>>> +					       struct tegra_dma_sg_req *sg_req)
>>>> +{
>>>> +	unsigned long status, wcount = 0;
>>>> +
>>>> +	if (!list_is_first(&sg_req->node, &tdc->pending_sg_req))
>>>> +		return 0;
>>>> +
>>>> +	if (tdc->tdma->chip_data->support_separate_wcount_reg)
>>>> +		wcount = tdc_read(tdc, TEGRA_APBDMA_CHAN_WORD_TRANSFER);
>>>> +
>>>> +	status = tdc_read(tdc, TEGRA_APBDMA_CHAN_STATUS);
>>>> +
>>>> +	if (!tdc->tdma->chip_data->support_separate_wcount_reg)
>>>> +		wcount = status;
>>>> +
>>>> +	if (status & TEGRA_APBDMA_STATUS_ISE_EOC)
>>>> +		return sg_req->req_len;
>>>> +
>>>> +	wcount = get_current_xferred_count(tdc, sg_req, wcount);
>>>> +
>>>> +	if (!wcount) {
>>>> +		/*
>>>> +		 * If wcount wasn't ever polled for this SG before, then
>>>> +		 * simply assume that transfer hasn't started yet.
>>>> +		 *
>>>> +		 * Otherwise it's the end of the transfer.
>>>> +		 *
>>>> +		 * The alternative would be to poll the status register
>>>> +		 * until EOC bit is set or wcount goes UP. That's so
>>>> +		 * because EOC bit is getting set only after the last
>>>> +		 * burst's completion and counter is less than the actual
>>>> +		 * transfer size by 4 bytes. The counter value wraps around
>>>> +		 * in a cyclic mode before EOC is set(!), so we can't easily
>>>> +		 * distinguish start of transfer from its end.
>>>> +		 */
>>>> +		if (sg_req->words_xferred)
>>>> +			wcount = sg_req->req_len - 4;
>>>> +
>>>> +	} else if (wcount < sg_req->words_xferred) {
>>>> +		/*
>>>> +		 * This case shall not ever happen because EOC bit
>>>> +		 * must be set once next cyclic transfer is started.
>>>
>>> Should this still be cyclic here?
>>
>> Do you mean the "comment" by "here"?
>>
>> It will be absolutely terrible if this case happens for oneshot transfer, assume
>> kernel/hardware is on fire.
> 
> Or more likely a SW bug :-)
> 
> Yes should never happen for either sg or cyclic, but there is no mention
> of sg transfers. Maybe the sg case is more obvious but in general this
> case should never happen for any transfer.

Alright, so what the change you are proposing? Or is it fine now?

I can certainly change the comment's wording, just please tell me what you want it to be.

/*
 * This case shall not ever happen because EOC bit
 * must be set once transfer is actually finished.

Does this sound better?
