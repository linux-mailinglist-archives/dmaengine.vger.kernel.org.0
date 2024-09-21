Return-Path: <dmaengine+bounces-3201-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CFB97DEB8
	for <lists+dmaengine@lfdr.de>; Sat, 21 Sep 2024 22:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361AF1C20A7B
	for <lists+dmaengine@lfdr.de>; Sat, 21 Sep 2024 20:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07D73D556;
	Sat, 21 Sep 2024 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7m/cTuc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D321345;
	Sat, 21 Sep 2024 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726949581; cv=none; b=tas88V47A6IpR2yMD52uAtzAjhCldrvFyg/zCyjYngN6UCZbAo68JOlkpbQQMlMW4kWGyuVMyTa2qFUfpr00a+JQepM/pAZ6s/RtuYtQdBo4T5O0/BrR5N0h/8qd93c0a+4Y265Sk+xjExzT17YsQFNkwIxjgUx5R6HzzluZ4vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726949581; c=relaxed/simple;
	bh=5js/bALrxSh0YpF9WmcJ9AJcsjQ9CI745MwF9u5Zh8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2UCO6nVDH1aCCudk40DJC5z2MpS0l8fA7ADnfBE3QfIt3v2o76mQO1+PUKc2SOMnEO1MGieCIOYMcfGIhanYyo6X4deTGWycfC03Jq3YxV8Nt9oMFscR0ZftMOVQUA4rrypLuxc7QDS27SmU/r7ds0GjTTglrKELh6hZIe/O6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7m/cTuc; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53661ac5ba1so3256455e87.2;
        Sat, 21 Sep 2024 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726949578; x=1727554378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Bj8muE25OTXvwpLML8EXalQtJOhNwhGoVHFPEFrTzY=;
        b=H7m/cTuclmjLhJk6GjEFO9SAA1CDAHeM0/nxXhRXgnck5nhWPAFW6OiADt9NEm0S3g
         WNkhZuYqHgh1NWC7D48SVzmF9RdsfS8qxQ1cPzSoAo78pojt1MULFa88cmqvZke8bzHX
         CcdtrRISJyFWcK/tYYPqkqyWuYupowQcbw3aTpt5LMdkOD5ChM1RYfaPBQYBs54/3Xy/
         An617IA4zn3K/cOt53gMgjxJtgSkZvYvJzt6yeIs+ND9bXmxBCEPwK97zP9KpUCLw76C
         qOwewqdEg/LP60W5QEWvoEIAb+6Xl1F8GTxTV9DQ2f5kLp/G7oDZarADfuBCdNqVCCRQ
         WWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726949578; x=1727554378;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Bj8muE25OTXvwpLML8EXalQtJOhNwhGoVHFPEFrTzY=;
        b=tk8SkroGfcur1aGElugo4TekNZzKazVYDhtWzvvkkOIaWgRJ/1cI4xVAi/t2ioVloF
         /uwzACvR0wfLS4aIJjn9SQjUE0cDU3UjqZwx8BG2pdaEeO45eUzewtW670ESDItYu39p
         2zDmBqwp9zmisJqVnjgcEwTmXLZLqNL+BHGnQNh7QtCr3kQao161x88wv3Ise4EvzECp
         y5C4RuNwah2tBZPEH386JwurpVzTdrWIU3wiEVPs4kQL93kHU4xCY2XmtWkCA3CHN+Bp
         qRHjFPBsOJbs4a0cjG3wENsOXeAZ4aJYdikKwKqgttaD2I+s30LG8b8XUZzj/e3qu8Mn
         QV0w==
X-Forwarded-Encrypted: i=1; AJvYcCUeFvSBloQPVmh9zwDyoNQZUpoD1a1xyBuD4d/JH83Xjy9Ht7xzlcTwPtdE6pHnOto9fDhfsZyHbXMBsW7Z@vger.kernel.org, AJvYcCXYk61f0Ib3rZII4tW13LSAdMOlxlhn5n7C/1LbaapffC4m7PEdGB8HFX813h6ld9Ufb0UZko0f/iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlD2t/lwLv3WR6jOFm1obildcc43uLp2F3SgsuQOgb/zTe4Uw1
	rT5CuV7Hxfvo8DYWXmyW5I2buJKkABXEHFssvQAv8T+1iJaWmTJidmz43+v5
X-Google-Smtp-Source: AGHT+IGf6SyoGi6wftBjr0SjSSuusqwoVRRwbwBdYjUfDLiNxO/VScrpOB7xf1d+lyH+iGEcaN39iA==
X-Received: by 2002:a05:6512:10d5:b0:536:53f0:2f8e with SMTP id 2adb3069b0e04-536ac31efe7mr3996189e87.37.1726949577367;
        Sat, 21 Sep 2024 13:12:57 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-124-88.kaisa-laajakaista.fi. [85.29.124.88])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704defcsm2689586e87.97.2024.09.21.13.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2024 13:12:56 -0700 (PDT)
Message-ID: <39190cdd-46e8-4c8f-a2e4-608e9ea19ac4@gmail.com>
Date: Sat, 21 Sep 2024 23:13:31 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix teardown for cyclic PDMA
 transfers
To: Jai Luthra <jai.luthra@linux.dev>, Vinod Koul <vkoul@kernel.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Devarsh Thakkar <devarsht@ti.com>, Rishikesh Donadkar <r-donadkar@ti.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jai Luthra <j-luthra@ti.com>
References: <20240918-z_cnt-v1-1-2c58fbfb07d6@linux.dev>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Content-Language: en-US
In-Reply-To: <20240918-z_cnt-v1-1-2c58fbfb07d6@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jai,

I only have couple of suggestions, mainly for the comments and commit
message, otherwise looks good.

On 18/09/2024 16:16, Jai Luthra wrote:
> From: Jai Luthra <j-luthra@ti.com>
> 
> When receiving data in cyclic mode from PDMA peripherals, where reload
> count is set to infinite, any TR in the set can potentially be the last
> one of the overall transfer. In such cases, the EOP flag needs to be set
> in each TR and PDMA's Static TR "Z" parameter should be set, matching
> the size of the TR.
> 
> This is required for the teardown to function properly and cleanup the
> internal state memory. This only affects platforms using BCDMA and not
> those using UDMA-P, which could set EOP flag in the teardown TR
> automatically.

Since this only affects BCDMA, I would clarify the commit title to
something:
dmaengine: ti: k3-udma: Set EOP flag for all TRs in cyclic BCDMA transfer

And adjust the commit message accordingly.

Basically we kind of emulate PacketMode with this on BCDMA, right?

> Similarly when transmitting data in cyclic mode to PDMA peripherals, the
> EOP flag needs to be set to get the teardown completion signal
> correctly.
> 
> Fixes: 017794739702 ("dmaengine: ti: k3-udma: Initial support for K3 BCDMA")
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> Signed-off-by: Jai Luthra <jai.luthra@linux.dev>
> ---
>  drivers/dma/ti/k3-udma.c | 61 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 46 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 406ee199c2ac..5a900b63dae5 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -3185,27 +3185,39 @@ static int udma_configure_statictr(struct udma_chan *uc, struct udma_desc *d,
>  
>  	d->static_tr.elcnt = elcnt;
>  
> -	/*
> -	 * PDMA must to close the packet when the channel is in packet mode.
> -	 * For TR mode when the channel is not cyclic we also need PDMA to close
> -	 * the packet otherwise the transfer will stall because PDMA holds on
> -	 * the data it has received from the peripheral.
> -	 */
>  	if (uc->config.pkt_mode || !uc->cyclic) {
> +		/*
> +		 * PDMA must close the packet when the channel is in packet mode.
> +		 * For TR mode when the channel is not cyclic we also need PDMA
> +		 * to close the packet otherwise the transfer will stall because
> +		 * PDMA holds on the data it has received from the peripheral.
> +		 */
>  		unsigned int div = dev_width * elcnt;
>  
>  		if (uc->cyclic)
>  			d->static_tr.bstcnt = d->residue / d->sglen / div;
>  		else
>  			d->static_tr.bstcnt = d->residue / div;
> +	} else if (uc->ud->match_data->type == DMA_TYPE_BCDMA &&
> +		   uc->config.dir == DMA_DEV_TO_MEM && !uc->config.pkt_mode &&
> +		   uc->cyclic) {

BCDMA and pkt_mode cannot be true at the same time, the check for
!uc->config.pkt_mode can be dropped.

> +		/*
> +		 * For cyclic TR mode PDMA must close the packet after every TR

This is only valid for BCDMA, the comment should mention this.

> +		 * transfer, as we have to set EOP in each TR to prevent short
> +		 * packet errors seen on channel teardown.
> +		 */
> +		struct cppi5_tr_type1_t *tr_req = d->hwdesc[0].tr_req_base;
>  
> -		if (uc->config.dir == DMA_DEV_TO_MEM &&
> -		    d->static_tr.bstcnt > uc->ud->match_data->statictr_z_mask)
> -			return -EINVAL;
> +		d->static_tr.bstcnt =
> +			(tr_req->icnt0 * tr_req->icnt1) / dev_width;
>  	} else {
>  		d->static_tr.bstcnt = 0;
>  	}
>  
> +	if (uc->config.dir == DMA_DEV_TO_MEM &&
> +	    d->static_tr.bstcnt > uc->ud->match_data->statictr_z_mask)
> +		return -EINVAL;
> +
>  	return 0;
>  }
>  
> @@ -3450,8 +3462,9 @@ udma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  	/* static TR for remote PDMA */
>  	if (udma_configure_statictr(uc, d, dev_width, burst)) {
>  		dev_err(uc->ud->dev,
> -			"%s: StaticTR Z is limited to maximum 4095 (%u)\n",
> -			__func__, d->static_tr.bstcnt);
> +			"%s: StaticTR Z is limited to maximum %u (%u)\n",
> +			__func__, uc->ud->match_data->statictr_z_mask,
> +			d->static_tr.bstcnt);
>  
>  		udma_free_hwdesc(uc, d);
>  		kfree(d);
> @@ -3476,6 +3489,7 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
>  	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
>  	unsigned int i;
>  	int num_tr;
> +	u32 period_csf = 0;
>  
>  	num_tr = udma_get_tr_counters(period_len, __ffs(buf_addr), &tr0_cnt0,
>  				      &tr0_cnt1, &tr1_cnt0);
> @@ -3498,6 +3512,20 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
>  		period_addr = buf_addr |
>  			((u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT);
>  
> +	/*
> +	 * For BCDMA <-> PDMA transfers, the EOP flag needs to be set on the
> +	 * last TR of a descriptor, to mark the packet as complete.
> +	 * This is required for getting the teardown completion message in case
> +	 * of TX, and to avoid short-packet error in case of RX.
> +	 *
> +	 * As we are in cyclic mode, we do not know which period might be the
> +	 * last one, so set the flag for each period.
> +	 */
> +	if (uc->config.ep_type == PSIL_EP_PDMA_XY &&
> +	    uc->ud->match_data->type == DMA_TYPE_BCDMA) {
> +		period_csf = CPPI5_TR_CSF_EOP;
> +	}
> +
>  	for (i = 0; i < periods; i++) {
>  		int tr_idx = i * num_tr;
>  
> @@ -3525,8 +3553,10 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
>  		}
>  
>  		if (!(flags & DMA_PREP_INTERRUPT))
> -			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
> -					 CPPI5_TR_CSF_SUPR_EVT);
> +			period_csf |= CPPI5_TR_CSF_SUPR_EVT;
> +
> +		if (period_csf)
> +			cppi5_tr_csf_set(&tr_req[tr_idx].flags, period_csf);
>  
>  		period_addr += period_len;
>  	}
> @@ -3655,8 +3685,9 @@ udma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
>  	/* static TR for remote PDMA */
>  	if (udma_configure_statictr(uc, d, dev_width, burst)) {
>  		dev_err(uc->ud->dev,
> -			"%s: StaticTR Z is limited to maximum 4095 (%u)\n",
> -			__func__, d->static_tr.bstcnt);
> +			"%s: StaticTR Z is limited to maximum %u (%u)\n",
> +			__func__, uc->ud->match_data->statictr_z_mask,
> +			d->static_tr.bstcnt);
>  
>  		udma_free_hwdesc(uc, d);
>  		kfree(d);
> 
> ---
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
> change-id: 20240918-z_cnt-3ca5daec76bf
> 
> Best regards,

-- 
Péter


