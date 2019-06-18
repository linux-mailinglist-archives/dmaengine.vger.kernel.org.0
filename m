Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B784449DAD
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2019 11:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfFRJp0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jun 2019 05:45:26 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43287 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbfFRJpZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jun 2019 05:45:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id j29so8738431lfk.10;
        Tue, 18 Jun 2019 02:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3qfnEcP7spmKcXBjGoV/MSfMy8bpQgF8xb+RRvaokWY=;
        b=LbgR6szItH3+L/+j0swAZicCIBXbGEezKhgRZsIcbD3BqTtana90AAz2VbkYWimOoy
         6UCqAZFHCo8LBcwtXmpCmQoD4I0FTGqg8s730A0yPs3Czywylm82tYvlQDdh5weEDsUh
         m2Sg+2bsi0zz44ps+MW/elejMt4wCwlhsu74rf/A8sN/v60L8AT+cmVIJWHUDQSBUsp1
         ain/Gr/Q4ZPHt7KVxJ8IH/D+fM6K1cROMpdD1rVELdQg2fXOOQDL5RzOQTnHofqQWXgT
         iqxPD9hYmr8jJBWlJ/t29xDSYNQb108La78juH/KVMAxbVPUErtuAjRJ2zLEyQQCdHwx
         SEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3qfnEcP7spmKcXBjGoV/MSfMy8bpQgF8xb+RRvaokWY=;
        b=OSpRP7oj4Wvyq0RtJ2fgvqOJJARHzvTe7N0bCo4uvex5uyVnNOa1Xs6GuD9pVxl16/
         lRRj1E8O0n9hfm2VMRWvBIizrToBXx67BleuAQuRx4CyhD66CpR4YQ8bHUJob3gQ6e3T
         D3aI0blvh9/DH6Qna/2IdOS+VRwgT6XJABvY8o1RFCrbEHRQ8oYtjYyYg3kYFwpzGmVu
         L7a2nH8cJCXwhJLaYhltBnm7O88FxacDba36a+6auyk+deXKUQaqhzVhhfCmp1mLsSMT
         TOGSK5C9ZETCC2GpiyZDS1bfnH2ueGeUmvm4D6a5kDZIyB7D4UU1IteDYPhSv/J0dcrm
         rA9A==
X-Gm-Message-State: APjAAAW7+utkhiUM+CSL9ip/uSnV+VunkN53yzR+6ugDaxDhMhUzxYb7
        yli40s1aOjZkRGxbDeS28+MDQwLy
X-Google-Smtp-Source: APXvYqwUF/vvc55rv/eIOk9NJ17YGA3PysCsnAaoBAB1gS70rpNJLe2VKJsn/ctYZSE8FsUYkvW2gg==
X-Received: by 2002:ac2:5922:: with SMTP id v2mr57535446lfi.180.1560851122071;
        Tue, 18 Jun 2019 02:45:22 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id d2sm2075090lfh.1.2019.06.18.02.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 02:45:21 -0700 (PDT)
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Support per-burst residue
 granularity
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190613210849.10382-1-digetx@gmail.com>
 <5fbe4374-cc9a-8212-017e-05f4dee64443@nvidia.com>
 <7ab96aa5-0be2-dc01-d187-eb718093eb99@nvidia.com>
 <840fcf60-8e24-ff44-a816-ef63a5f18652@gmail.com>
 <d34c100d-e82a-bb00-22c6-c5f2f6cdb03a@nvidia.com>
 <b47b7b89-e830-0b3e-026d-c6c7d67d3324@gmail.com>
 <255f92e8-df61-5e9c-ba4f-e52a0bd11451@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <69cb064c-2a8e-9421-35b0-4a2273f62365@gmail.com>
Date:   Tue, 18 Jun 2019 12:45:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <255f92e8-df61-5e9c-ba4f-e52a0bd11451@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

18.06.2019 11:47, Jon Hunter пишет:
> 
> On 17/06/2019 13:41, Dmitry Osipenko wrote:
>> 17.06.2019 13:57, Jon Hunter пишет:
>>>
>>> On 14/06/2019 17:44, Dmitry Osipenko wrote:
>>>> 14.06.2019 18:24, Jon Hunter пишет:
>>>>>
>>>>> On 14/06/2019 16:21, Jon Hunter wrote:
>>>>>>
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
>>>>>>>  drivers/dma/tegra20-apb-dma.c | 35 ++++++++++++++++++++++++++++-------
>>>>>>>  1 file changed, 28 insertions(+), 7 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>>>>>>> index 79e9593815f1..c5af8f703548 100644
>>>>>>> --- a/drivers/dma/tegra20-apb-dma.c
>>>>>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>>>>>> @@ -797,12 +797,36 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>>>>>>>  	return 0;
>>>>>>>  }
>>>>>>>  
>>>>>>> +static unsigned int tegra_dma_update_residual(struct tegra_dma_channel *tdc,
>>>>>>> +					      struct tegra_dma_sg_req *sg_req,
>>>>>>> +					      struct tegra_dma_desc *dma_desc,
>>>>>>> +					      unsigned int residual)
>>>>>>> +{
>>>>>>> +	unsigned long status, wcount = 0;
>>>>>>> +
>>>>>>> +	if (!list_is_first(&sg_req->node, &tdc->pending_sg_req))
>>>>>>> +		return residual;
>>>>>>> +
>>>>>>> +	if (tdc->tdma->chip_data->support_separate_wcount_reg)
>>>>>>> +		wcount = tdc_read(tdc, TEGRA_APBDMA_CHAN_WORD_TRANSFER);
>>>>>>> +
>>>>>>> +	status = tdc_read(tdc, TEGRA_APBDMA_CHAN_STATUS);
>>>>>>> +
>>>>>>> +	if (!tdc->tdma->chip_data->support_separate_wcount_reg)
>>>>>>> +		wcount = status;
>>>>>>> +
>>>>>>> +	if (status & TEGRA_APBDMA_STATUS_ISE_EOC)
>>>>>>> +		return residual - sg_req->req_len;
>>>>>>> +
>>>>>>> +	return residual - get_current_xferred_count(tdc, sg_req, wcount);
>>>>>>> +}
>>>>>>> +
>>>>>>>  static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>>>>>>>  	dma_cookie_t cookie, struct dma_tx_state *txstate)
>>>>>>>  {
>>>>>>>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>>>>>>> +	struct tegra_dma_sg_req *sg_req = NULL;
>>>>>>>  	struct tegra_dma_desc *dma_desc;
>>>>>>> -	struct tegra_dma_sg_req *sg_req;
>>>>>>>  	enum dma_status ret;
>>>>>>>  	unsigned long flags;
>>>>>>>  	unsigned int residual;
>>>>>>> @@ -838,6 +862,8 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>>>>>>>  		residual = dma_desc->bytes_requested -
>>>>>>>  			   (dma_desc->bytes_transferred %
>>>>>>>  			    dma_desc->bytes_requested);
>>>>>>> +		residual = tegra_dma_update_residual(tdc, sg_req, dma_desc,
>>>>>>> +						     residual);
>>>>>>
>>>>>> I had a quick look at this, I am not sure that we want to call
>>>>>> tegra_dma_update_residual() here for cases where the dma_desc is on the
>>>>>> free_dma_desc list. In fact, couldn't this be simplified a bit for case
>>>>>> where the dma_desc is on the free list? In that case I believe that the
>>>>>> residual should always be 0.
>>>>>
>>>>> Actually, no, it could be non-zero in the case the transfer is aborted.
>>>>
>>>> Looks like everything should be fine as-is.
>>>
>>> I am still not sure we want to call this for the case where dma_desc is
>>> on the free list.
>>
>> You're right! It's a bug there! The sg_req=NULL if dma_desc is on the free list, hence
>> it will result in a NULL dereference. I'll fix it in v2 and will avoid the offending
>> call, like you're suggesting.
>>
>>>> BTW, it's a bit hard to believe that there is any real benefit from the
>>>> free_dma_desc list at all, maybe worth to just remove it?
>>>
>>> I think you need to elaborate a bit more here. I am not a massive fan of
>>> this driver, but I am also not in the mood for changing unless there is
>>> a good reason.
>>
>> It looks like the whole point of the free list is to have a cache of preallocated
>> dma_desc's, but dma_desc allocation and initialization doesn't cost anything in
>> comparison to the free list because memory is allocated from a SLAB cache and then the
>> initialization will happen on CPU's cache.
>>
>> So the free list is quite pointless in terms of optimization. Moreover what if driver
>> allocates a lot of dma_desc's and uses them just once? Looks like it will be quite a
>> lot of wasted memory on the free list.
> 
> Yes indeed and for the ADMA we allocate and free on-demand as you are
> suggesting. I don't know why it was done like this, but to make the
> change it would be good to get some data about how much memory it is
> consuming to see if it is actually worth it.

Yeah, that's something to check in the future.
