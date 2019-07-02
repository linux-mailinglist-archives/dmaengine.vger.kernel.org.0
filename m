Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED2415CF0D
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jul 2019 14:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfGBMEK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Jul 2019 08:04:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39678 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfGBMEK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Jul 2019 08:04:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id p24so11182460lfo.6;
        Tue, 02 Jul 2019 05:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/p+rlSf9FXbaeW1xE/+vovGguSelzqpJmft2l4qChXA=;
        b=abTw89ks/jj8Xmgm1LlyaK7LofGKQwNfHRaYTX8JCDWqclESWWuH+fG1YgTEBhO2p5
         5L99ZIHZ5/zmNnF7G3rLvfWA3r1EoSFYAtdMiAIT2VTTQ0wFUyOWnL5pPKh5iXvg3edq
         FYbJvFoBc9NYpwRz2vQNHmP0VXRKF1/SprOVoM094gsncWEphic4ptt3VEgOxbY7DPmy
         QJocNv5hMoeaE+EKSZt/OjOU5AP+4KobUqrZ5h/x2g6+PYuAnfJHl6H1XWIhvJVGrtRN
         qzRVX+oV/TeJYG8+5BN2G3M3+i00bpLiGEGD/uxsZwvf4UdR/PMXKiDLUSJDI93+FG2E
         87ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/p+rlSf9FXbaeW1xE/+vovGguSelzqpJmft2l4qChXA=;
        b=nGCt+suBwFTNcJjv3FIPHvE83nvqVaFBXLV3u5nBXwnykdQeKXm0nKdT5ji4gemFPM
         LTXHHk/9rpQDdKPNslScEEUHkmRB0gu5WrXdAq6l83M+jkbL17q2hiyjk6hQzT6JKHxR
         JMW862QCdkVZUbbEfxHsxNq4JFGNenDh8Lv8bIL1IUybAIN+MB2ORc9LmU5B+GC2FvHQ
         WdheWVFwJZfI4lEOcuNsywP6H/P7Sl4ZPt67Zn9WZGks0hbIkScTj671C77aW8vatS1l
         WMwb7JfIACYAOwuE7wnZE7fCOf9UEf95Dbaxow5U5LQ7XyAo3ktSLsgcMIMtkuz72/sJ
         QOjA==
X-Gm-Message-State: APjAAAUL1ocxrFGoSmNyW79JZoEowgGncGW7xXZDL8Nrq4nHmeLJ4gKg
        farDV16JMhcS3pNQHxE2L+KkYbkx
X-Google-Smtp-Source: APXvYqxpQFUxiSZlMUu+WQE6ijmJ1Sq3nihJswgH90gDx7u790gyjOnu+5ztUE9va3exY38KX12dKw==
X-Received: by 2002:ac2:4466:: with SMTP id y6mr8501198lfl.0.1562069047019;
        Tue, 02 Jul 2019 05:04:07 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id t4sm4306504ljh.9.2019.07.02.05.04.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 05:04:06 -0700 (PDT)
Subject: Re: [PATCH v3] dmaengine: tegra-apb: Support per-burst residue
 granularity
From:   Dmitry Osipenko <digetx@gmail.com>
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
 <39df67ea-d707-7181-3050-3d215f4487f6@gmail.com>
Message-ID: <108982bc-1741-8fee-d2dd-4f4d45178ba0@gmail.com>
Date:   Tue, 2 Jul 2019 15:04:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <39df67ea-d707-7181-3050-3d215f4487f6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

02.07.2019 14:56, Dmitry Osipenko пишет:
> 02.07.2019 14:37, Dmitry Osipenko пишет:
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
>>
>> For a non-cyclic transfers it doesn't matter.. because they are not cyclic and thus
>> counter will be stopped by itself. It will be a disaster if all of sudden a
>> non-cyclic transfer becomes cyclic, don't you think so? :)
>>
> 
> Ah, probably I was too focused on audio playback use-case. If it's a free-running
> transfer, then that case of a wraparound seems should be legit.. hmm.
> 

Looks like that will work:

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 71473eda28ee..201c693b11f5 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -648,6 +648,8 @@ static void handle_cont_sngl_cycle_dma_done(struct tegra_dma_channel *tdc,
 		st = handle_continuous_head_request(tdc, sgreq, to_terminate);
 		if (!st)
 			dma_desc->dma_status = DMA_ERROR;
+	} else {
+		sg_req->words_xferred = 0;
 	}
 }

