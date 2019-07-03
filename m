Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B381F5E9D9
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jul 2019 19:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfGCRBD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jul 2019 13:01:03 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35778 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCRBC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Jul 2019 13:01:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id p197so2310857lfa.2;
        Wed, 03 Jul 2019 10:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FlM2YzHaNPTqJi+wQYt2NdwGERRTDmC89+MIDEmzPDs=;
        b=kRxIxu4CyZVnot9qBhxzQSBOfTljxrVVbsW02J+fqHrQoRo/RNvWxCiT34M1W3FHiC
         tAP+msmZ1OvdVE1velAKHCsCB9lNU2MGpRn4xUc/NwQzbnyLur4qj0F/UxpaBmaLWcIr
         BJwvTp9vosP7C3AE8ZVuez4O2vL/qowN9nzwhxeWmHL5X3zuab14ow7N27lOAyauEtO1
         9uzOlsJ7gg1DYa2Aie/dWwivIkK2DjY3n91ElxAZk4vNapNIW5OwSmZR5eAjcd/jsWQG
         jDLcmU0Wp/Fd3vMJI5BITbT3b4GYlo9EreRP3tpgQz9jdm6/c30O+BdnaUSYxUW7shM/
         Qdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FlM2YzHaNPTqJi+wQYt2NdwGERRTDmC89+MIDEmzPDs=;
        b=B4X9CNTUcIhu9yJ/x552GIxZTWBlvuATjN13O2e34eIDPOns2e/ARzCgr+aOUnVTej
         Pw35y+Sju9J2+xAgYJyT67jGCVLj4rwyKeb0DKHg/ZLlx8OEkVHkfQdBoQlQkkfeymEP
         NOuUaxKUoL2IQqIUqLLuZO8e5hAKZLXjsk0J82r7xGbWpQux76+dBihiWn/HXf/QXxfN
         qHc1S7vxnUciVje5fP2HJRedW3kkStnC1h7gw5cJqS6Ee6Wn+tstzFvln7N52a7i3qCx
         SiQy6miI9PdMvNtpt64/d9OolqFh9Of3GlyR1xGkvS0kovqgoUI/zi+h+/Ytlx4jwwLW
         Ds2g==
X-Gm-Message-State: APjAAAUCqluk63w1qrDJQ1JE8InRRq9zvy4YogtHX0cp+l++PzwTR8c9
        gPidX7qkn7o/99jPorKZr/3o7OBq
X-Google-Smtp-Source: APXvYqyGP0Y2FNSGLwGHA33+ejtRbqezTCFtpj6D5R0yQr8ddxjBdTpXTsBdiGCZBvd28kW8/P1Hug==
X-Received: by 2002:ac2:5324:: with SMTP id f4mr2476147lfh.156.1562173259432;
        Wed, 03 Jul 2019 10:00:59 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id v12sm582732ljk.22.2019.07.03.10.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 10:00:58 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b1f4d7c3-636e-947f-ac76-fc639ac7fee4@gmail.com>
Date:   Wed, 3 Jul 2019 20:00:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b0a0b110-61c8-ae8b-22a0-3311f70b428a@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

03.07.2019 19:37, Jon Hunter пишет:
> 
> On 03/07/2019 02:28, Dmitry Osipenko wrote:
>> Tegra's APB DMA engine updates words counter after each transferred burst
>> of data, hence it can report transfer's residual with more fidelity which
>> may be required in cases like audio playback. In particular this fixes
>> audio stuttering during playback in a chromium web browser. The patch is
>> based on the original work that was made by Ben Dooks and a patch from
>> downstream kernel. It was tested on Tegra20 and Tegra30 devices.
>>
>> Link: https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@codethink.co.uk/
>> Link: https://nv-tegra.nvidia.com/gitweb/?p=linux-4.4.git;a=commit;h=c7bba40c6846fbf3eaad35c4472dcc7d8bbc02e5
>> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>
>> Changelog:
>>
>> v4: The words_xferred is now also reset on a new iteration of a cyclic
>>     transfer by ISR, so that dmaengine_tx_status() won't produce a
>>     misleading warning splat on TX status re-checking after a cycle
>>     completion when cyclic transfer consists of a single SG.
>>
>> v3: Added workaround for a hardware design shortcoming that results
>>     in a words counter wraparound before end-of-transfer bit is set
>>     in a cyclic mode.
>>
>> v2: Addressed review comments made by Jon Hunter to v1. We won't try
>>     to get words count if dma_desc is on free list as it will result
>>     in a NULL dereference because this case wasn't handled properly.
>>
>>     The residual value is now updated properly, avoiding potential
>>     integer overflow by adding the "bytes" to the "bytes_transferred"
>>     instead of the subtraction.
>>
>>  drivers/dma/tegra20-apb-dma.c | 72 +++++++++++++++++++++++++++++++----
>>  1 file changed, 65 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>> index 79e9593815f1..148d136191d7 100644
>> --- a/drivers/dma/tegra20-apb-dma.c
>> +++ b/drivers/dma/tegra20-apb-dma.c
>> @@ -152,6 +152,7 @@ struct tegra_dma_sg_req {
>>  	bool				last_sg;
>>  	struct list_head		node;
>>  	struct tegra_dma_desc		*dma_desc;
>> +	unsigned int			words_xferred;
>>  };
>>  
>>  /*
>> @@ -496,6 +497,7 @@ static void tegra_dma_configure_for_next(struct tegra_dma_channel *tdc,
>>  	tdc_write(tdc, TEGRA_APBDMA_CHAN_CSR,
>>  				nsg_req->ch_regs.csr | TEGRA_APBDMA_CSR_ENB);
>>  	nsg_req->configured = true;
>> +	nsg_req->words_xferred = 0;
>>  
>>  	tegra_dma_resume(tdc);
>>  }
>> @@ -511,6 +513,7 @@ static void tdc_start_head_req(struct tegra_dma_channel *tdc)
>>  					typeof(*sg_req), node);
>>  	tegra_dma_start(tdc, sg_req);
>>  	sg_req->configured = true;
>> +	sg_req->words_xferred = 0;
>>  	tdc->busy = true;
>>  }
>>  
>> @@ -638,6 +641,8 @@ static void handle_cont_sngl_cycle_dma_done(struct tegra_dma_channel *tdc,
>>  		list_add_tail(&dma_desc->cb_node, &tdc->cb_desc);
>>  	dma_desc->cb_count++;
>>  
>> +	sgreq->words_xferred = 0;
>> +
>>  	/* If not last req then put at end of pending list */
>>  	if (!list_is_last(&sgreq->node, &tdc->pending_sg_req)) {
>>  		list_move_tail(&sgreq->node, &tdc->pending_sg_req);
>> @@ -797,6 +802,62 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>>  	return 0;
>>  }
>>  
>> +static unsigned int tegra_dma_sg_bytes_xferred(struct tegra_dma_channel *tdc,
>> +					       struct tegra_dma_sg_req *sg_req)
>> +{
>> +	unsigned long status, wcount = 0;
>> +
>> +	if (!list_is_first(&sg_req->node, &tdc->pending_sg_req))
>> +		return 0;
>> +
>> +	if (tdc->tdma->chip_data->support_separate_wcount_reg)
>> +		wcount = tdc_read(tdc, TEGRA_APBDMA_CHAN_WORD_TRANSFER);
>> +
>> +	status = tdc_read(tdc, TEGRA_APBDMA_CHAN_STATUS);
>> +
>> +	if (!tdc->tdma->chip_data->support_separate_wcount_reg)
>> +		wcount = status;
>> +
>> +	if (status & TEGRA_APBDMA_STATUS_ISE_EOC)
>> +		return sg_req->req_len;
>> +
>> +	wcount = get_current_xferred_count(tdc, sg_req, wcount);
>> +
>> +	if (!wcount) {
>> +		/*
>> +		 * If wcount wasn't ever polled for this SG before, then
>> +		 * simply assume that transfer hasn't started yet.
>> +		 *
>> +		 * Otherwise it's the end of the transfer.
>> +		 *
>> +		 * The alternative would be to poll the status register
>> +		 * until EOC bit is set or wcount goes UP. That's so
>> +		 * because EOC bit is getting set only after the last
>> +		 * burst's completion and counter is less than the actual
>> +		 * transfer size by 4 bytes. The counter value wraps around
>> +		 * in a cyclic mode before EOC is set(!), so we can't easily
>> +		 * distinguish start of transfer from its end.
>> +		 */
>> +		if (sg_req->words_xferred)
>> +			wcount = sg_req->req_len - 4;
>> +
>> +	} else if (wcount < sg_req->words_xferred) {
>> +		/*
>> +		 * This case shall not ever happen because EOC bit
>> +		 * must be set once next cyclic transfer is started.
> 
> Should this still be cyclic here?

Do you mean the "comment" by "here"?

It will be absolutely terrible if this case happens for oneshot transfer, assume
kernel/hardware is on fire.
