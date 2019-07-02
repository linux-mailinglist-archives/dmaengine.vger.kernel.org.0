Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10395D06C
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jul 2019 15:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfGBNWb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Jul 2019 09:22:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33828 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfGBNWb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Jul 2019 09:22:31 -0400
Received: by mail-lf1-f67.google.com with SMTP id b29so1411091lfq.1;
        Tue, 02 Jul 2019 06:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kScy655FaxblGBpfh0Uok/2Mnz85hgBEuDaQ+H2GHsw=;
        b=rmwG9LBishOyqQyDXNpnXFOwqQHDhzhCCcdUAZqvTyEFNB6GUUSKBkyxZxUKl/Ex5T
         egRA5wamueLWkFJWCVoC1QZ9xPz3eejU9FXHi1A+d/fsfmCZRUCfKu4kMPtc7Mu2F5Cd
         z/UReTffIrK61JLsUQ0SjTGFbcoM2beuk1fOG2YV59t4ZOIaphApUepBBgCKx/aYoLoa
         9UwPk13zOouPwf7Jf0Kr2kyv9p1a7u1A2ul4IY84VdU7aYCmYfoUPN/or5crq4PK9Oxe
         MCMDJnX5pSSqI60ZxSdOC7PraN7UUPB5ykwvr6E6WT9kFt2biN67lSU/wF/fpgwbrlcj
         lYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kScy655FaxblGBpfh0Uok/2Mnz85hgBEuDaQ+H2GHsw=;
        b=OKtLhmj5lghGVux50OM/lkEJ1fUTvq7EIAeqmgxw9kb1Z8ydaylewDRfEezgJH3fS0
         adxlxa4mNrkVwLyBm8NOLusO2Ouiqe92Pxoj2x/UBh1MAed+2ny48hSPNYxsNkwJzXL1
         ZXoe5dg+SaMZRFx9ekOwiBip1KebUyMtONVis6qkGabKh5y64Er7Oz7l2z1eVXORgFsT
         6WzwhO6zq1Qu7M+HDhq0Vqb14KF0HUnXIbBPW80ye60V6EMscgpGbzFWby+EOpQOBcyS
         /btMstH1kvXsmfYIoPEepcDlLUog8HJP3mBwa/OkyCNKHgUrwGgo2IxdkLZfE8TSpkIZ
         kAUg==
X-Gm-Message-State: APjAAAWxK/TC9TtFvWru0id+VnwngPX6hItyEjQgzWgJmVbUMZRNWLDT
        Ls/ktoIHmtcnxm5+dhpQXlN/UvGV
X-Google-Smtp-Source: APXvYqztmoFFBVjBIhqN/9ufBrzmEXB0Mu1f3NAf2wKy15Z3EjqY6+VAlR7M96Kau90ejhvEhH0IJA==
X-Received: by 2002:a19:230e:: with SMTP id j14mr14254427lfj.13.1562073747042;
        Tue, 02 Jul 2019 06:22:27 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id o8sm682430ljh.100.2019.07.02.06.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 06:22:26 -0700 (PDT)
Subject: Re: [PATCH v3] dmaengine: tegra-apb: Support per-burst residue
 granularity
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190627194728.8948-1-digetx@gmail.com>
 <dab25158-272c-a18f-a858-433f7f9000e0@nvidia.com>
 <3a5403fe-b81f-993c-e7c0-407387e001d9@gmail.com>
 <b50045f9-7d8f-d91a-8629-625bcd7057bc@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ed84cc7d-08de-dbd7-40e2-bc84c5debe1a@gmail.com>
Date:   Tue, 2 Jul 2019 16:22:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b50045f9-7d8f-d91a-8629-625bcd7057bc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

02.07.2019 15:54, Jon Hunter пишет:
> 
> On 02/07/2019 12:37, Dmitry Osipenko wrote:
>> 02.07.2019 14:20, Jon Hunter пишет:
>>>
>>> On 27/06/2019 20:47, Dmitry Osipenko wrote:
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
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>
>>>> Changelog:
>>>>
>>>> v3:  Added workaround for a hardware design shortcoming that results
>>>>      in a words counter wraparound before end-of-transfer bit is set
>>>>      in a cyclic mode.
>>>>
>>>> v2:  Addressed review comments made by Jon Hunter to v1. We won't try
>>>>      to get words count if dma_desc is on free list as it will result
>>>>      in a NULL dereference because this case wasn't handled properly.
>>>>
>>>>      The residual value is now updated properly, avoiding potential
>>>>      integer overflow by adding the "bytes" to the "bytes_transferred"
>>>>      instead of the subtraction.
>>>>
>>>>  drivers/dma/tegra20-apb-dma.c | 69 +++++++++++++++++++++++++++++++----
>>>>  1 file changed, 62 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>>>> index 79e9593815f1..71473eda28ee 100644
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
>>>> @@ -797,6 +800,61 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
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
>>> I am not sure I follow this and why this condition cannot happen for
>>> cyclic transfers. What about non-cyclic transfers?
>>
>> It cannot happen because the EOC bit will be set in that case. The counter wraps
>> around when the transfer of a last burst happens, EOC bit is guaranteed to be set
>> after completion of the last burst. That's my observation after a thorough testing,
>> it will be very odd if EOC setting happened completely asynchronously.
> 
> I see how you know that the EOC is set. Anyway, you check if the EOC is
> set before and if so return sg_req->req_len prior to this test.
> 
> Maybe I am missing something, but what happens if we are mid block when
> dmaengine_tx_status() is called? That happen asynchronously right?


Do you mean asynchronously in regards to the ISR? Or something else?

tegra_dma_tx_status() takes the channels spinlock, hence IRQ handling can't happen
simultaneously.
