Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29C7213EEC2
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2020 19:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405388AbgAPRhb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jan 2020 12:37:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42199 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405332AbgAPRhb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jan 2020 12:37:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id y4so23601087ljj.9;
        Thu, 16 Jan 2020 09:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=suZU8pKiTx0kVLzvrdfAKUboMnJzI6jejrwEJFaOhgo=;
        b=QSl3ac0kH3tQptaRPYSJBi23DOf/HEN7MsCIq7hJ56/U3BquCENmm5wgCJTbCmJYCV
         Cap70k8IV2TcDFZ89riu6fmj8VEg1F1l6qFBiD05YaaDmaNNPU0n7VxejGgsHjjvXbcp
         L+R8jBRuCDlzUA7oh6ne4IC8b6WTP+1A7+1H5X4v+j+QvMiXPfl1CmqL2OveSiLTnA9k
         xfHbasSx+A/eL0gVA8W8H+RwkKphERordECc+/ug+8mfy2Bs2MQ3MTVdQGLLXVZP4xTV
         bpgdMSk7EsxHH/sULrPa/sNkUfWoutvc71lvYupsoeFgbDMYkCxN0YJM0nYWHy5HXgFL
         Rl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=suZU8pKiTx0kVLzvrdfAKUboMnJzI6jejrwEJFaOhgo=;
        b=R0aF43rO4nixsYyYXLlFLNSLZUtnPpTEucFNsxMYUxqzmLMdX6rwxXi4BGG68U6qn/
         X+wLXZldGwPxdoMO9mpF460bUrN5BM+iH8Z6LhCc2IkEVsEMmOdvZGZVFSY8t/7/EjGC
         vS6tbYrviD3Ba/tmZmof0COsRBXwHYQoC5QnZH1nLuKD6tTqXV7JlgExzLwMcPTornlQ
         NCgWKcC8HBjqhnZAEe//eVdrhk0/NqDUl/ApUfwvwRpk/C97taCL8LPMKIwzf2Pax3bJ
         J09cxa6UB//BQKnM5UXUJrPQTahjR4upmract3xUBPOhdDWt9k3RLxYZocky/48N+JHZ
         PQ9Q==
X-Gm-Message-State: APjAAAVpqvwFZbpCI00Olvfrrtrvv28MzafY6cppp7puqzDucdeAjodC
        3gjGopbrrrOFLsX+ZGZY7huJroSf
X-Google-Smtp-Source: APXvYqx6JhZ2lTCM6y/kPnmCTL7amKRUaFNa9X+BN6e6g88XO6jI8mGsCFQst0153VbjUCm0r0MMvw==
X-Received: by 2002:a2e:808a:: with SMTP id i10mr3054036ljg.151.1579196248890;
        Thu, 16 Jan 2020 09:37:28 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id t29sm10858436lfg.84.2020.01.16.09.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 09:37:28 -0800 (PST)
Subject: Re: [PATCH v4 08/14] dmaengine: tegra-apb: Fix coding style problems
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-9-digetx@gmail.com>
 <844c4ace-d043-a908-823d-545b5b753008@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <134adcfb-83fb-4bb7-986e-65217bc4f821@gmail.com>
Date:   Thu, 16 Jan 2020 20:37:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <844c4ace-d043-a908-823d-545b5b753008@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

15.01.2020 12:49, Jon Hunter пишет:
> 
> 
> On 12/01/2020 17:30, Dmitry Osipenko wrote:
>> This patch fixes few dozens of coding style problems reported by
>> checkpatch and prettifies code where makes sense.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/dma/tegra20-apb-dma.c | 276 ++++++++++++++++++----------------
>>  1 file changed, 144 insertions(+), 132 deletions(-)
>>
>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>> index dff21e80ffa4..7158bd3145c4 100644
>> --- a/drivers/dma/tegra20-apb-dma.c
>> +++ b/drivers/dma/tegra20-apb-dma.c
> 
> ...
> 
>> @@ -1003,20 +1014,23 @@ static void tegra_dma_prep_wcount(struct tegra_dma_channel *tdc,
>>  		ch_regs->csr |= len_field;
>>  }
>>  
>> -static struct dma_async_tx_descriptor *tegra_dma_prep_slave_sg(
>> -	struct dma_chan *dc, struct scatterlist *sgl, unsigned int sg_len,
>> -	enum dma_transfer_direction direction, unsigned long flags,
>> -	void *context)
>> +static struct dma_async_tx_descriptor *
>> +tegra_dma_prep_slave_sg(struct dma_chan *dc,
>> +			struct scatterlist *sgl,
>> +			unsigned int sg_len,
>> +			enum dma_transfer_direction direction,
>> +			unsigned long flags,
>> +			void *context)
>>  {
>>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>> +	struct tegra_dma_sg_req *sg_req = NULL;
>> +	u32 csr, ahb_seq, apb_ptr, apb_seq;
>> +	enum dma_slave_buswidth slave_bw;
>>  	struct tegra_dma_desc *dma_desc;
>> -	unsigned int i;
>> -	struct scatterlist *sg;
>> -	unsigned long csr, ahb_seq, apb_ptr, apb_seq;
>>  	struct list_head req_list;
>> -	struct tegra_dma_sg_req  *sg_req = NULL;
>> -	u32 burst_size;
>> -	enum dma_slave_buswidth slave_bw;
>> +	struct scatterlist *sg;
>> +	unsigned int burst_size;
>> +	unsigned int i;
> 
> This is not really consistent with the rest of the changes by having 'i'
> and 'burst_size' on separate lines.

The goal wasn't to squash everything into a single line, but to make
code more readable. In this particular case the separated lines look
better to me.

>>  
>>  	if (!tdc->config_init) {
>>  		dev_err(tdc2dev(tdc), "DMA channel is not configured\n");
>> @@ -1028,7 +1042,7 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_slave_sg(
>>  	}
>>  
>>  	if (get_transfer_param(tdc, direction, &apb_ptr, &apb_seq, &csr,
>> -				&burst_size, &slave_bw) < 0)
>> +			       &burst_size, &slave_bw) < 0)
>>  		return NULL;
>>  
>>  	INIT_LIST_HEAD(&req_list);
>> @@ -1074,7 +1088,7 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_slave_sg(
>>  		len = sg_dma_len(sg);
>>  
>>  		if ((len & 3) || (mem & 3) ||
>> -				(len > tdc->tdma->chip_data->max_dma_count)) {
>> +		    len > tdc->tdma->chip_data->max_dma_count) {
>>  			dev_err(tdc2dev(tdc),
>>  				"DMA length/memory address is not supported\n");
>>  			tegra_dma_desc_put(tdc, dma_desc);
>> @@ -1126,20 +1140,21 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_slave_sg(
>>  	return &dma_desc->txd;
>>  }
>>  
>> -static struct dma_async_tx_descriptor *tegra_dma_prep_dma_cyclic(
>> -	struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_len,
>> -	size_t period_len, enum dma_transfer_direction direction,
>> -	unsigned long flags)
>> +static struct dma_async_tx_descriptor *
>> +tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr,
>> +			  size_t buf_len,
>> +			  size_t period_len,
>> +			  enum dma_transfer_direction direction,
>> +			  unsigned long flags)
>>  {
>>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>> -	struct tegra_dma_desc *dma_desc = NULL;
>>  	struct tegra_dma_sg_req *sg_req = NULL;
>> -	unsigned long csr, ahb_seq, apb_ptr, apb_seq;
>> -	int len;
>> -	size_t remain_len;
>> -	dma_addr_t mem = buf_addr;
>> -	u32 burst_size;
>> +	u32 csr, ahb_seq, apb_ptr, apb_seq;
>>  	enum dma_slave_buswidth slave_bw;
>> +	struct tegra_dma_desc *dma_desc;
>> +	dma_addr_t mem = buf_addr;
>> +	unsigned int burst_size;
>> +	size_t len, remain_len;
>>  
>>  	if (!buf_len || !period_len) {
>>  		dev_err(tdc2dev(tdc), "Invalid buffer/period len\n");
>> @@ -1173,13 +1188,13 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_dma_cyclic(
>>  
>>  	len = period_len;
>>  	if ((len & 3) || (buf_addr & 3) ||
>> -			(len > tdc->tdma->chip_data->max_dma_count)) {
>> +	    len > tdc->tdma->chip_data->max_dma_count) {
>>  		dev_err(tdc2dev(tdc), "Req len/mem address is not correct\n");
>>  		return NULL;
>>  	}
>>  
>>  	if (get_transfer_param(tdc, direction, &apb_ptr, &apb_seq, &csr,
>> -				&burst_size, &slave_bw) < 0)
>> +			       &burst_size, &slave_bw) < 0)
>>  		return NULL;
>>  
>>  	ahb_seq = TEGRA_APBDMA_AHBSEQ_INTR_ENB;
>> @@ -1269,7 +1284,6 @@ static int tegra_dma_alloc_chan_resources(struct dma_chan *dc)
>>  	int ret;
>>  
>>  	dma_cookie_init(&tdc->dma_chan);
>> -	tdc->config_init = false;
> 
> Why is this removed? Does not seem to belong in this patch.

Because initially, on driver's probe, the tdc->config_init is false for
all channels and then tegra_dma_free_chan_resources() also sets it to
false. Thus there is no need to re-initilize the already initialized
variable. It's not a very good coding style if variables are
unnecessarily initialized, you probably noticed that there are few other
cases of removing the unneeded initializations of local variables in
this patch.
