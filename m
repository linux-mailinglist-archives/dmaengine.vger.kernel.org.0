Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6FAF4DD20
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2019 23:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfFTV65 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Jun 2019 17:58:57 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40885 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFTV64 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Jun 2019 17:58:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id a9so3514288lff.7;
        Thu, 20 Jun 2019 14:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3tZ6jSobmeKstvDrC/5wSUoU07pdLAq0kJd9K5p6OFI=;
        b=P9e4Z53i+Taehgm9nNjEgg/55PGVNIWtTGKNi9FpytEXpz3DO+uJodtPWS7+Jc7/Lw
         VGhMOGEg7PDJt4aIQ+epaMbcaGzkbhe5mtEcN/AWjw6DlHHrnrcOKi/CewS+0nnSY+Gd
         D8YuCUUr7nIlJzUD6gZPvdEYRBZ/2Sh/1JZOoGC8Xig+q9KPN5jn4XUOZjmKiqHiz8LA
         WD5ouA44/d3SUQNaLK/lx7GuLpBLh3OpZ5wfvyE/TuLpsFkTus462LVJqj9Qekguy9RW
         8HDKL3fFPk9SvJeE/oImGjotd2jUJv5mg395cbBMEff5inqvzCNFm+MzbH/WA0JoxL6D
         VXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3tZ6jSobmeKstvDrC/5wSUoU07pdLAq0kJd9K5p6OFI=;
        b=dkLUGAbLtgJsML6GWlNL/9wjVVX2Nki+14VdH7gA4sK/olXb6rHQISUt5T6T7qj7V3
         +jnlWydZ8/VIqif3XUJICfOLGFpfmBz9zkaTr0Ua/AdRJy6y2gvYSv4RZOdPqyuDSB9m
         C6GQvJSv1qTi8x7Rc2Um9MxsahzCXO9cEJOgEIAENW69+3Gh3tO0UPj5ULee3pTe2IA5
         o+1Q8bOv4Q18xXIA/OYrTU/DrieEV/W4JqmlW8JxFahuXybwQhVxfO44UyjA2PGfRXTg
         D1ZD4nF0p3UvMfQy+TLq4iAqRNGUvbQxVxJ3/bSqduQONwpFMpOvKJJznwvm9kL8u7+I
         2eaQ==
X-Gm-Message-State: APjAAAVIponi1cI0wnTR2kqLkhn5bghQ6NdL5FJ1hpZteILcJZtSm4sg
        wKgwfE0dOHxunA5V65bzGCw+Vhrl
X-Google-Smtp-Source: APXvYqxnrQZPAhoVpiLJUK5yfK71YVqgPEDYxPQxr17rxxx5N7OulqQJjUL95mdT4dzCDbjO9WX2rA==
X-Received: by 2002:ac2:597c:: with SMTP id h28mr27403407lfp.90.1561067933580;
        Thu, 20 Jun 2019 14:58:53 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id h10sm119519lfj.10.2019.06.20.14.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 14:58:52 -0700 (PDT)
Subject: Re: [PATCH v2] dmaengine: tegra-apb: Support per-burst residue
 granularity
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190618115035.29250-1-digetx@gmail.com>
 <8f48fcba-df7c-a313-2f84-0fa896e4ccec@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8470f28f-b903-c6ed-23bd-0cbd130f0798@gmail.com>
Date:   Fri, 21 Jun 2019 00:58:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <8f48fcba-df7c-a313-2f84-0fa896e4ccec@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

20.06.2019 11:38, Jon Hunter пишет:
> 
> On 18/06/2019 12:50, Dmitry Osipenko wrote:
>> Tegra's APB DMA engine updates words counter after each transferred burst
>> of data, hence it can report transfer's residual with more fidelity which
>> may be required in cases like audio playback. In particular this fixes
>> audio stuttering during playback in a chromiuim web browser. The patch is
>> based on the original work that was made by Ben Dooks. It was tested on
>> Tegra20 and Tegra30 devices.
>>
>> Link: https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@codethink.co.uk/
>> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>
>> Changelog:
>>
>> v2:  Addressed review comments made by Jon Hunter to v1. We won't try
>>      to get words count if dma_desc is on free list as it will result
>>      in a NULL dereference because this case wasn't handled properly.
>>
>>      The residual value is now updated properly, avoiding potential
>>      integer overflow by adding the "bytes" to the "bytes_transferred"
>>      instead of the subtraction.
>>
>>  drivers/dma/tegra20-apb-dma.c | 33 ++++++++++++++++++++++++++-------
>>  1 file changed, 26 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>> index 79e9593815f1..fed18bc46479 100644
>> --- a/drivers/dma/tegra20-apb-dma.c
>> +++ b/drivers/dma/tegra20-apb-dma.c
>> @@ -797,6 +797,28 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
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
>> +	return get_current_xferred_count(tdc, sg_req, wcount);
>> +}
>> +
>>  static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>>  	dma_cookie_t cookie, struct dma_tx_state *txstate)
>>  {
>> @@ -806,6 +828,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>>  	enum dma_status ret;
>>  	unsigned long flags;
>>  	unsigned int residual;
>> +	unsigned int bytes = 0;
>>  
>>  	ret = dma_cookie_status(dc, cookie, txstate);
>>  	if (ret == DMA_COMPLETE)
>> @@ -825,6 +848,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>>  	list_for_each_entry(sg_req, &tdc->pending_sg_req, node) {
>>  		dma_desc = sg_req->dma_desc;
>>  		if (dma_desc->txd.cookie == cookie) {
>> +			bytes = tegra_dma_sg_bytes_xferred(tdc, sg_req);
>>  			ret = dma_desc->dma_status;
>>  			goto found;
>>  		}
>> @@ -836,7 +860,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>>  found:
>>  	if (dma_desc && txstate) {
>>  		residual = dma_desc->bytes_requested -
>> -			   (dma_desc->bytes_transferred %
>> +			   ((dma_desc->bytes_transferred + bytes) %
>>  			    dma_desc->bytes_requested);
>>  		dma_set_residue(txstate, residual);
>>  	}
>> @@ -1441,12 +1465,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>  		BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
>>  		BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
>>  	tdma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>> -	/*
>> -	 * XXX The hardware appears to support
>> -	 * DMA_RESIDUE_GRANULARITY_BURST-level reporting, but it's
>> -	 * only used by this driver during tegra_dma_terminate_all()
>> -	 */
>> -	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
>> +	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>>  	tdma->dma_dev.device_config = tegra_dma_slave_config;
>>  	tdma->dma_dev.device_terminate_all = tegra_dma_terminate_all;
>>  	tdma->dma_dev.device_tx_status = tegra_dma_tx_status;
>>
> 
> Looks good to me. Thanks for fixing!
> 
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks to you too for the review :)
