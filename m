Return-Path: <dmaengine+bounces-699-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2271C8268F8
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jan 2024 08:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46371F21E09
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jan 2024 07:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8C914287;
	Mon,  8 Jan 2024 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp8Cbrc2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091A614291;
	Mon,  8 Jan 2024 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so1678607e87.3;
        Sun, 07 Jan 2024 23:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704700469; x=1705305269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PGbmqWC/KzPKcYaESUuYlyd0RnrSGyhu219OoaqIaLU=;
        b=Vp8Cbrc2BU8pKSPNarvRgC9kaycA6FOtY+rPEpCTLsD2WaTR0TTWP6WvdOTsCt6ToR
         01+H0ynelhtIQ48pM03NgDHnyg5b2Yftt8huJMx9Ekezwun4cx56fA/wtlWlI5RyhQmm
         Gtem5L5Y0m9ptEIq6jqli9Kzpl6/+erjSkxVuTlPp6kkq4JvYtKGu2rUcU6ygNbqeQRX
         e+SxXLqTwwbYDXnwlUu+Dil9eakIho8I6xoZLxC4OSLEkH9q501Cgjd22bH3W9o0p++I
         xmAmCy7S/JfPs1LCQMA73BLjcYutEZliIV6oxogWAdtN2e6qTbn67MxXjAkkTaJGkATI
         69YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704700469; x=1705305269;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGbmqWC/KzPKcYaESUuYlyd0RnrSGyhu219OoaqIaLU=;
        b=RwTec7WqsLTVoQqJz3CkbVc0y6DsLH8koZDyJU1ttt/X8Ag0wZYQq1DbOV+/ppdc/y
         dN51SgvVUblcD3flLkrilgtaw1tHkm9NHhVm0rtiM2xxYPgvNPdZoCvVne1FxxzkV3CA
         XWi7JI8yxQmR+csUlPrz7sU/ILnNEViax1hY/+FOEHU3ee7rPeYcfiDJi/oY7jHrwaJo
         f389I/flP8EPqlNRI3gcQAlDjLO6jm1mm/oJnUApSRw/u4L9UBQ7GjWNZ2Fq7FjkA9wl
         uU5iwFzZDm5xKVp3cq+emQQmI9Wy5Iyl4ioPEYiZzOcjtoSIlxzD/RNdFicurlm+syUi
         mnQg==
X-Gm-Message-State: AOJu0YwXaqsXcLZwlG9s09MJQp3U+QcAI55xtO73Ugx66gwM5fKuCUOO
	+YWVeXwBULBWyE4W4yG7amY=
X-Google-Smtp-Source: AGHT+IFmchzpqUSycpA9C6A/V4GWrH3Howr6WhLlclctBL3Vc4ihTxOp29WvvA5z1dgYBb/46CMRsg==
X-Received: by 2002:a05:6512:e9a:b0:50e:aa8c:e558 with SMTP id bi26-20020a0565120e9a00b0050eaa8ce558mr1382076lfb.2.1704700468703;
        Sun, 07 Jan 2024 23:54:28 -0800 (PST)
Received: from [10.0.0.100] (host-213-145-197-219.kaisa-laajakaista.fi. [213.145.197.219])
        by smtp.gmail.com with ESMTPSA id bp33-20020a05651215a100b0050e7e2d0f1csm1076347lfb.211.2024.01.07.23.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 23:54:28 -0800 (PST)
Message-ID: <3e8ffbce-e894-4130-b9a2-f267ba54ee12@gmail.com>
Date: Mon, 8 Jan 2024 09:55:03 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Report short packet errors
Content-Language: en-US
To: Jai Luthra <j-luthra@ti.com>, Vinod Koul <vkoul@kernel.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240103-tr_resp_err-v1-1-2fdf6d48ab92@ti.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20240103-tr_resp_err-v1-1-2fdf6d48ab92@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 03/01/2024 11:07, Jai Luthra wrote:
> Propagate the TR response status to the device using BCDMA
> split-channels. For example CSI-RX driver should be able to check if a
> frame was not transferred completely (short packet) and needs to be
> discarded.

Make sense,

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 30fd2f386f36..037f1408e798 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -3968,6 +3968,7 @@ static void udma_desc_pre_callback(struct virt_dma_chan *vc,
>  {
>  	struct udma_chan *uc = to_udma_chan(&vc->chan);
>  	struct udma_desc *d;
> +	u8 status;
>  
>  	if (!vd)
>  		return;
> @@ -3977,12 +3978,12 @@ static void udma_desc_pre_callback(struct virt_dma_chan *vc,
>  	if (d->metadata_size)
>  		udma_fetch_epib(uc, d);
>  
> -	/* Provide residue information for the client */
>  	if (result) {
>  		void *desc_vaddr = udma_curr_cppi5_desc_vaddr(d, d->desc_idx);
>  
>  		if (cppi5_desc_get_type(desc_vaddr) ==
>  		    CPPI5_INFO0_DESC_TYPE_VAL_HOST) {
> +			/* Provide residue information for the client */
>  			result->residue = d->residue -
>  					  cppi5_hdesc_get_pktlen(desc_vaddr);
>  			if (result->residue)
> @@ -3991,7 +3992,12 @@ static void udma_desc_pre_callback(struct virt_dma_chan *vc,
>  				result->result = DMA_TRANS_NOERROR;
>  		} else {
>  			result->residue = 0;
> -			result->result = DMA_TRANS_NOERROR;
> +			/* Propagate TR Response errors to the client */
> +			status = d->hwdesc[0].tr_resp_base->status;
> +			if (status)
> +				result->result = DMA_TRANS_ABORTED;
> +			else
> +				result->result = DMA_TRANS_NOERROR;
>  		}
>  	}
>  }
> 
> ---
> base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
> change-id: 20240103-tr_resp_err-9f4eebbdcd3b
> 
> Best regards,

-- 
Péter

