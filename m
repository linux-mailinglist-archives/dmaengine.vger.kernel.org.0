Return-Path: <dmaengine+bounces-3271-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF17992018
	for <lists+dmaengine@lfdr.de>; Sun,  6 Oct 2024 19:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A036AB2168D
	for <lists+dmaengine@lfdr.de>; Sun,  6 Oct 2024 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229BD188731;
	Sun,  6 Oct 2024 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hoiy7ZDo"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DC6A2D;
	Sun,  6 Oct 2024 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728236759; cv=none; b=M9dHGWDouYnicsddPNxUxMxGi9+O1vp2L4sc3C8bIZi2KRXJUqmI2r2pjRoF2LBYBXUPByKfp4PH//klPu1mLbkH3oNXnWNJJRFD/9c3h4trS+tHR0/9IfbNDL2IDNRBVSwp1+L12IxHHPV4B7mjyK388hB0l6EXAoQOWCT4FIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728236759; c=relaxed/simple;
	bh=vLA7OwEgRexwtwQqY4A+Kcl2cwPaR5Yhb0YID61kPzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8kmJedxrhRJVTVs5TTtw+/PGqGXqUv1g1y8IcaAxu7Yyn4RwtevCRtSz68hCyGWPfbAbjJVH8YrSfh4vGXuWxWMC9i9ZD2qavTlX/ITiFbo/CRoZhUvAryLPzXfYXGW34rRFcUV/SGreWPOS8lIVy0Xe0nITUFAmrH/2fqzo9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hoiy7ZDo; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fac187eef2so43073221fa.3;
        Sun, 06 Oct 2024 10:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728236755; x=1728841555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QtkVAhWObzYD17h0yeTdaPTBSYXwKABgGKk7AeS9LIw=;
        b=Hoiy7ZDoJZXobpEQtiycS64qpAKBAnuj6Xqo1H3SdFrVHA4P5MGHc3zAgbNXzm9Aqy
         sQOfGE5Nkx9XxBKb1U1RxxbS35Xhvknq1YNNJbKSOHYVyfOuBScYK/vqkHitCZ3ynBHe
         UxMjjE/TG+RV+RqX764LgUsf6u2MUN5Gh+H92g1p99wuN0SmITPpDHLLX8RZG7KkJNRZ
         8YRJwD0t8xE9T8sgfHa/P2bvDmPToMW5mq6T8DCUgisM9tfz4abuSq5SZv0RyvwDSTiQ
         uZ8sijivpsrH0JUOIWtAvemv/YBikQTQv29z1nOrLRlLjSmAbkkNVC79VjoQB9JOpb2i
         +4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728236755; x=1728841555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtkVAhWObzYD17h0yeTdaPTBSYXwKABgGKk7AeS9LIw=;
        b=pTLHvWru9bXDXEZw5xbWvgZuRF9RJkb7JZ+P+ajtYIlg+w8KhTZmc0iDkTxe5vQ0pM
         gGNQabbaHfak3fXi+5+CKb6jfsgfgcL7KvFl5pLf5tG6LFZDQI1Inv0UQ/60phUCGX8t
         tlSZmhPbskh2l8GMCvoTmltZNvzcSfegH3N8d3KXx4Mq3yUrHQ96DCD6D2q8MDGfqYO4
         dyRddvIq05eGsqr7el/sfbwCbYLJdgopk5+UWCFmSimdD+DnvxQBfTjepE17yGrSP5DL
         OWAjtYc1RrRcGU3a/IpQOMGrdDigtCuvPUNw2P+MSf7ba1UUiNiRpLlk3VaCLLzSmKLM
         riQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+BKB+1gTe+iCWa/jmJ3QR/uyshuJ7KxwH3xK3Q+MTm1FZPcy/vOVdheq+WOr/FjxrY5L9DXIrHgvp0LQj@vger.kernel.org, AJvYcCWkzxoSFqvOvjtuXNm7Ky2YnjfJL3TTCkB9WyvnFA1lQsh/ygxEHGQKSQieZiBrQNTaOcdp71e4T9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhTqonAfbmih6eq0j3VpgK5+CvaBxb0vJxss1H7Yd60CyxlcRI
	VOGquYL9rGvYSXmhzoCAXkEx+EZj/XUX6k0o8MzhkkJmpADHUOaLmeErlYit
X-Google-Smtp-Source: AGHT+IF5UYWhsz4kgh+37Q2uxTmaI/tA8w4Fl+hYOV3yTX6I2fnrlFE9I8Q66f8ZBBa1mylLwY9mCw==
X-Received: by 2002:a05:651c:2129:b0:2fa:c9ad:3d36 with SMTP id 38308e7fff4ca-2faf3c2fff0mr42793601fa.7.1728236755029;
        Sun, 06 Oct 2024 10:45:55 -0700 (PDT)
Received: from [10.0.0.42] (host-85-29-124-88.kaisa-laajakaista.fi. [85.29.124.88])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9ac43efsm5666251fa.45.2024.10.06.10.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 10:45:54 -0700 (PDT)
Message-ID: <7bc5091b-fb60-454d-8fd1-805d63b6d818@gmail.com>
Date: Sun, 6 Oct 2024 20:50:54 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmaengine: ti: k3-udma: Set EOP for all TRs in cyclic
 BCDMA transfer
To: Jai Luthra <jai.luthra@linux.dev>, Vinod Koul <vkoul@kernel.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Devarsh Thakkar <devarsht@ti.com>, Rishikesh Donadkar <r-donadkar@ti.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240930-z_cnt-v2-1-9d38aba149a2@linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20240930-z_cnt-v2-1-9d38aba149a2@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/30/24 8:02 PM, Jai Luthra wrote:
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
> 
> Similarly when transmitting data in cyclic mode to PDMA peripherals, the
> EOP flag needs to be set to get the teardown completion signal
> correctly.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Fixes: 017794739702 ("dmaengine: ti: k3-udma: Initial support for K3 BCDMA")
> Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Toradex Verdin AM62
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> Signed-off-by: Jai Luthra <jai.luthra@linux.dev>
> ---
> Changes in v2:
> - Fix commit message and comments to make it clear that this change is
>   only needed for BCDMA
> - Drop the redundant pkt_mode check
> - Link to v1: https://lore.kernel.org/r/20240918-z_cnt-v1-1-2c58fbfb07d6@linux.dev
> ---
>  drivers/dma/ti/k3-udma.c | 62 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 47 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 406ee199c2ac1cffc29edb475df574cf9f0cf222..b3f27b3f92098a65afe9656ca31f9b8027294c16 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -3185,27 +3185,40 @@ static int udma_configure_statictr(struct udma_chan *uc, struct udma_desc *d,
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
> +		   uc->config.dir == DMA_DEV_TO_MEM &&
> +		   uc->cyclic) {
> +		/*
> +		 * For cyclic mode with BCDMA we have to set EOP in each TR to
> +		 * prevent short packet errors seen on channel teardown. So the
> +		 * PDMA must close the packet after every TR transfer by setting
> +		 * burst count equal to the number of bytes transferred.
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
> @@ -3450,8 +3463,9 @@ udma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
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
> @@ -3476,6 +3490,7 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
>  	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
>  	unsigned int i;
>  	int num_tr;
> +	u32 period_csf = 0;
>  
>  	num_tr = udma_get_tr_counters(period_len, __ffs(buf_addr), &tr0_cnt0,
>  				      &tr0_cnt1, &tr1_cnt0);
> @@ -3498,6 +3513,20 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
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
> @@ -3525,8 +3554,10 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
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
> @@ -3655,8 +3686,9 @@ udma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
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


