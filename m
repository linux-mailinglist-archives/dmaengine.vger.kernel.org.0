Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD9FC5D2FD
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jul 2019 17:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfGBPhf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Jul 2019 11:37:35 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37476 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfGBPhe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Jul 2019 11:37:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id 131so17355233ljf.4;
        Tue, 02 Jul 2019 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vPxCwGeVq/zHXVFtfpmaoTyHGqj3SfIhA16kWBtFXdk=;
        b=T3K1fX/yOe4ogEnGTYE54QAkNxmyMe9DBQ0qUq6VeokpfiOuivblul/AGD/D+GXyMI
         w1a8w460IJPI5L6JaFm1ojJyB+BWhxwQFSk+mTpSM9f5gn6qyqjlvvQHlLELv83HSojf
         bS/Oifp5TNN8shV5RnfvAZjTYtpliWPb2Klm0IxXcyzdmbvRfXj63niGE7bx0ol63V/1
         I7fu3zAyn4iU5hsjl8x8OYN3J5tjxNLHTH9bQmL7wog/Zpm3CsUdNsXidKZUMcTTPadm
         ceogCsbR9msotds9x4t4p0G4CNUXKDgL6+8vYXpSntiV0oeOw1A/S1Q/jqgNiapagpIC
         kvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vPxCwGeVq/zHXVFtfpmaoTyHGqj3SfIhA16kWBtFXdk=;
        b=D71kdbq61/JeHoGtB8WXo+k6rKz/NB0ReywU3pYoiBKuECIHFVAIH4XHOO9oWKvdHf
         kqmsGLVTJdzn5kKimgcFwI4k0ZNe0/sWROolrN1gbHjHmD3UXeKy7XVQ69JW6k8Ggv+f
         wCO0QXJxzIy6tpjPM4t/rF6o5E8IYLnLm4wx5wwTNBQ7lxyOMbMcTTqtKEoNiwLpUHYU
         kAaqn1zLY6qtxrLFCXDtZSUQK8+nn3L9YgDNCwzOCKbwGo5DfWjxzuSy9PUkac/5grb8
         gb8B2sGhA0Tb+JhcdXyjuYu5j1b8BQzvnj9vVPCQf/2DrdnFqjPmNc03thFHO4L0U5FK
         a8Fg==
X-Gm-Message-State: APjAAAUkz0/e+hxjVjFCyxqRsppjISwIwJeOcuuRCck2+LyakdVEsIgp
        Ht1A7Isvoay3i6eDFJ/MwjD21MS9
X-Google-Smtp-Source: APXvYqyavnYUtp3Ei6T8TFgub1cqyT8l44AQa04IYoJsGjNzjHKqpfDu8kKq9WP8mHHwcYuqjD16hA==
X-Received: by 2002:a2e:3604:: with SMTP id d4mr17844540lja.85.1562081851473;
        Tue, 02 Jul 2019 08:37:31 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id p12sm3859925lja.23.2019.07.02.08.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 08:37:30 -0700 (PDT)
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
 <f60059ec-c9ed-7294-f975-25e71a273f69@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1ef44832-a263-a27a-30bf-16433c3fdb74@gmail.com>
Date:   Tue, 2 Jul 2019 18:37:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <f60059ec-c9ed-7294-f975-25e71a273f69@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

02.07.2019 18:29, Jon Hunter пишет:
> 
> On 27/06/2019 20:47, Dmitry Osipenko wrote:
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
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>
>> Changelog:
>>
>> v3:  Added workaround for a hardware design shortcoming that results
>>      in a words counter wraparound before end-of-transfer bit is set
>>      in a cyclic mode.
>>
>> v2:  Addressed review comments made by Jon Hunter to v1. We won't try
>>      to get words count if dma_desc is on free list as it will result
>>      in a NULL dereference because this case wasn't handled properly.
>>
>>      The residual value is now updated properly, avoiding potential
>>      integer overflow by adding the "bytes" to the "bytes_transferred"
>>      instead of the subtraction.
>>
>>  drivers/dma/tegra20-apb-dma.c | 69 +++++++++++++++++++++++++++++++----
>>  1 file changed, 62 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>> index 79e9593815f1..71473eda28ee 100644
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
>> @@ -797,6 +800,61 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
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
> 
> Minor comment, why not ...
> 
> 	} else if WARN_ON_ONCE(wcount < sg_req->words_xferred) {

Because there should be parens around WARN_ON_ONCE() and that makes it to look not very
nice, IMHO.

> 
> Otherwise ...
> 
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks! I'll probably make a v4 later today with words_xferred reset made after end of a
transfer's cycle, similar to what I suggested in the other email.
