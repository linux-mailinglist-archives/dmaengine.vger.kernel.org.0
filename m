Return-Path: <dmaengine+bounces-4881-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8AAA87AE4
	for <lists+dmaengine@lfdr.de>; Mon, 14 Apr 2025 10:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0C03AD6E9
	for <lists+dmaengine@lfdr.de>; Mon, 14 Apr 2025 08:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F91625D54A;
	Mon, 14 Apr 2025 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="s8+Piv/1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE79E25A626;
	Mon, 14 Apr 2025 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620344; cv=none; b=jU2vC+20Pp3/0HLJhFJ2RczAyh3c1hDJ+sTq9WTKRWyF6SFsyq/IPGmYK5iwD492sblqShGUmvFAdHK4zcZCtw6yybxbo0c4/JAJVFED0qzsImfPC3U3JV7gNrOotWbSvwhQTrRdZR2Iw1L7nPX8xfdDBFwvDVk03tBSICcCBig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620344; c=relaxed/simple;
	bh=1DneHrOh2P4wCCvAFwmXK/TSoA3m02FScStaifEQ4nU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qCuNlPKaYR7xK0/owZi7sR9Up6lTWT3/kVwPoRMZfPzNqfiUPYY8Ycit4271wXzMhqBAje/lbjSXB7uR1g5GC28JjxJe7OAQb7S5B6WRUI/LM91GpxKEkKKXYrHZDaNv3wvBlVqEiOBrIOOnnvCyBjO+4eNPmrpkcky9YMCtF58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=s8+Piv/1; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E8Dgqr002903;
	Mon, 14 Apr 2025 10:45:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	iMxypOAW8Oa6O6QVpYmX6cdYifOLRH3rTIKzTjQ0LoE=; b=s8+Piv/1ysUJCi+t
	7UIfFhgwwEsmNuzbYPLELMy2rag14Nn81fUecOECARc7pji3gWZCvYKM23HALKXg
	T8EHjYHUWpMlmmHc8k4k+AW324xnojdYfhII8eyQKqUz7gT6DeMrzhxHDh1O/dMD
	20GKksyHX3CbcIzlu8Utbhmkz5I41Uzra7jNxmgaaIlg7Jyteoww92pcPdIAXEka
	8cpKC0BaEI5U9GZVmQaqWJVeQN8cM+wneLJb27Hun9vPGvfrsyiSxylPsO+1HjZf
	P7G8WcMRM/bOr6kh6bY3VvJNiED2zFfYHtCmBtA+qiJiyhos9xob46iGKsmttuWy
	fnRGaA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45yfh1pveg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 10:45:04 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8132B400B0;
	Mon, 14 Apr 2025 10:43:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A5BF59EA15F;
	Mon, 14 Apr 2025 10:40:18 +0200 (CEST)
Received: from [10.48.86.196] (10.48.86.196) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:40:18 +0200
Message-ID: <b8140b9d-b5d9-48dc-b652-9eebc3e1ee01@foss.st.com>
Date: Mon, 14 Apr 2025 10:40:17 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: stm32: Don't use %pK through printk
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Vinod
 Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250407-restricted-pointers-dma-v1-1-b617dd0e293a@linutronix.de>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20250407-restricted-pointers-dma-v1-1-b617dd0e293a@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_02,2025-04-10_01,2024-11-22_01



On 4/7/25 10:26, Thomas Weißschuh wrote:
> In the past %pK was preferable to %p as it would not leak raw pointer
> values into the kernel log.
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> the regular %p has been improved to avoid this issue.
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through printk(). They can still unintentionally leak raw pointers or
> acquire sleeping looks in atomic contexts.
> 
> Switch to the regular pointer formatting which is safer and
> easier to reason about.
> There are still a few users of %pK left, but these use it through seq_file,
> for which its usage is safe.
>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Thank you for your patch,

Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

> ---
>   drivers/dma/stm32/stm32-dma.c  | 10 +++++-----
>   drivers/dma/stm32/stm32-dma3.c | 10 +++++-----
>   drivers/dma/stm32/stm32-mdma.c |  8 ++++----
>   3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/dma/stm32/stm32-dma.c b/drivers/dma/stm32/stm32-dma.c
> index 917f8e9223739af853e492d97cecac0e95e0aea3..ee9246c6888ffde2d416270f25890c04c72daff7 100644
> --- a/drivers/dma/stm32/stm32-dma.c
> +++ b/drivers/dma/stm32/stm32-dma.c
> @@ -613,7 +613,7 @@ static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
>   	reg->dma_scr |= STM32_DMA_SCR_EN;
>   	stm32_dma_write(dmadev, STM32_DMA_SCR(chan->id), reg->dma_scr);
>   
> -	dev_dbg(chan2dev(chan), "vchan %pK: started\n", &chan->vchan);
> +	dev_dbg(chan2dev(chan), "vchan %p: started\n", &chan->vchan);
>   }
>   
>   static void stm32_dma_configure_next_sg(struct stm32_dma_chan *chan)
> @@ -676,7 +676,7 @@ static void stm32_dma_handle_chan_paused(struct stm32_dma_chan *chan)
>   
>   	chan->status = DMA_PAUSED;
>   
> -	dev_dbg(chan2dev(chan), "vchan %pK: paused\n", &chan->vchan);
> +	dev_dbg(chan2dev(chan), "vchan %p: paused\n", &chan->vchan);
>   }
>   
>   static void stm32_dma_post_resume_reconfigure(struct stm32_dma_chan *chan)
> @@ -728,7 +728,7 @@ static void stm32_dma_post_resume_reconfigure(struct stm32_dma_chan *chan)
>   	dma_scr |= STM32_DMA_SCR_EN;
>   	stm32_dma_write(dmadev, STM32_DMA_SCR(chan->id), dma_scr);
>   
> -	dev_dbg(chan2dev(chan), "vchan %pK: reconfigured after pause/resume\n", &chan->vchan);
> +	dev_dbg(chan2dev(chan), "vchan %p: reconfigured after pause/resume\n", &chan->vchan);
>   }
>   
>   static void stm32_dma_handle_chan_done(struct stm32_dma_chan *chan, u32 scr)
> @@ -820,7 +820,7 @@ static void stm32_dma_issue_pending(struct dma_chan *c)
>   
>   	spin_lock_irqsave(&chan->vchan.lock, flags);
>   	if (vchan_issue_pending(&chan->vchan) && !chan->desc && !chan->busy) {
> -		dev_dbg(chan2dev(chan), "vchan %pK: issued\n", &chan->vchan);
> +		dev_dbg(chan2dev(chan), "vchan %p: issued\n", &chan->vchan);
>   		stm32_dma_start_transfer(chan);
>   
>   	}
> @@ -922,7 +922,7 @@ static int stm32_dma_resume(struct dma_chan *c)
>   
>   	spin_unlock_irqrestore(&chan->vchan.lock, flags);
>   
> -	dev_dbg(chan2dev(chan), "vchan %pK: resumed\n", &chan->vchan);
> +	dev_dbg(chan2dev(chan), "vchan %p: resumed\n", &chan->vchan);
>   
>   	return 0;
>   }
> diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
> index 0c6c4258b19561c94f1c68f26ade16b82660ebe6..50e7106c5cb73394c1de52ad5f571f6db63750e6 100644
> --- a/drivers/dma/stm32/stm32-dma3.c
> +++ b/drivers/dma/stm32/stm32-dma3.c
> @@ -801,7 +801,7 @@ static void stm32_dma3_chan_start(struct stm32_dma3_chan *chan)
>   
>   	chan->dma_status = DMA_IN_PROGRESS;
>   
> -	dev_dbg(chan2dev(chan), "vchan %pK: started\n", &chan->vchan);
> +	dev_dbg(chan2dev(chan), "vchan %p: started\n", &chan->vchan);
>   }
>   
>   static int stm32_dma3_chan_suspend(struct stm32_dma3_chan *chan, bool susp)
> @@ -1452,7 +1452,7 @@ static int stm32_dma3_pause(struct dma_chan *c)
>   
>   	chan->dma_status = DMA_PAUSED;
>   
> -	dev_dbg(chan2dev(chan), "vchan %pK: paused\n", &chan->vchan);
> +	dev_dbg(chan2dev(chan), "vchan %p: paused\n", &chan->vchan);
>   
>   	return 0;
>   }
> @@ -1465,7 +1465,7 @@ static int stm32_dma3_resume(struct dma_chan *c)
>   
>   	chan->dma_status = DMA_IN_PROGRESS;
>   
> -	dev_dbg(chan2dev(chan), "vchan %pK: resumed\n", &chan->vchan);
> +	dev_dbg(chan2dev(chan), "vchan %p: resumed\n", &chan->vchan);
>   
>   	return 0;
>   }
> @@ -1490,7 +1490,7 @@ static int stm32_dma3_terminate_all(struct dma_chan *c)
>   	spin_unlock_irqrestore(&chan->vchan.lock, flags);
>   	vchan_dma_desc_free_list(&chan->vchan, &head);
>   
> -	dev_dbg(chan2dev(chan), "vchan %pK: terminated\n", &chan->vchan);
> +	dev_dbg(chan2dev(chan), "vchan %p: terminated\n", &chan->vchan);
>   
>   	return 0;
>   }
> @@ -1543,7 +1543,7 @@ static void stm32_dma3_issue_pending(struct dma_chan *c)
>   	spin_lock_irqsave(&chan->vchan.lock, flags);
>   
>   	if (vchan_issue_pending(&chan->vchan) && !chan->swdesc) {
> -		dev_dbg(chan2dev(chan), "vchan %pK: issued\n", &chan->vchan);
> +		dev_dbg(chan2dev(chan), "vchan %p: issued\n", &chan->vchan);
>   		stm32_dma3_chan_start(chan);
>   	}
>   
> diff --git a/drivers/dma/stm32/stm32-mdma.c b/drivers/dma/stm32/stm32-mdma.c
> index e6d525901de7ecf822d218b87b95aba6bbf0a3ef..080c1c725216cb627675c372591b4c0c227c3cea 100644
> --- a/drivers/dma/stm32/stm32-mdma.c
> +++ b/drivers/dma/stm32/stm32-mdma.c
> @@ -1187,7 +1187,7 @@ static void stm32_mdma_start_transfer(struct stm32_mdma_chan *chan)
>   
>   	chan->busy = true;
>   
> -	dev_dbg(chan2dev(chan), "vchan %pK: started\n", &chan->vchan);
> +	dev_dbg(chan2dev(chan), "vchan %p: started\n", &chan->vchan);
>   }
>   
>   static void stm32_mdma_issue_pending(struct dma_chan *c)
> @@ -1200,7 +1200,7 @@ static void stm32_mdma_issue_pending(struct dma_chan *c)
>   	if (!vchan_issue_pending(&chan->vchan))
>   		goto end;
>   
> -	dev_dbg(chan2dev(chan), "vchan %pK: issued\n", &chan->vchan);
> +	dev_dbg(chan2dev(chan), "vchan %p: issued\n", &chan->vchan);
>   
>   	if (!chan->desc && !chan->busy)
>   		stm32_mdma_start_transfer(chan);
> @@ -1220,7 +1220,7 @@ static int stm32_mdma_pause(struct dma_chan *c)
>   	spin_unlock_irqrestore(&chan->vchan.lock, flags);
>   
>   	if (!ret)
> -		dev_dbg(chan2dev(chan), "vchan %pK: pause\n", &chan->vchan);
> +		dev_dbg(chan2dev(chan), "vchan %p: pause\n", &chan->vchan);
>   
>   	return ret;
>   }
> @@ -1261,7 +1261,7 @@ static int stm32_mdma_resume(struct dma_chan *c)
>   
>   	spin_unlock_irqrestore(&chan->vchan.lock, flags);
>   
> -	dev_dbg(chan2dev(chan), "vchan %pK: resume\n", &chan->vchan);
> +	dev_dbg(chan2dev(chan), "vchan %p: resume\n", &chan->vchan);
>   
>   	return 0;
>   }
> 
> ---
> base-commit: e48e99b6edf41c69c5528aa7ffb2daf3c59ee105
> change-id: 20250404-restricted-pointers-dma-29cf839a1a0b
> 
> Best regards,

