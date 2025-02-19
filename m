Return-Path: <dmaengine+bounces-4537-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD858A3C39B
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 16:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5343B9E39
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FB01F4169;
	Wed, 19 Feb 2025 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gmw2avS/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0AB1EFFAB;
	Wed, 19 Feb 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978655; cv=none; b=MfqkJWW4cKhFuSHkoD2Hp8+sMakOWNB+TBdrgHCO8iZSCn30z5Hdc+J7sGtEBUY/9/eCCagl4K5oUYtQ0Z+SkVZBwTFoMLyo8qVZnHa7Y+3BXIavsw5WcSrY4WH1V20bIT4vVMw8C2ofggAVnyuzRl7r8Khli9oLEVodHGzzdmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978655; c=relaxed/simple;
	bh=bjJrKjvDqDhaKoqZkL+p49M4QInQE7vBLemU0lNm5M4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rY+hwMFjbVr0og9KKem9EhZpapyMv50aYz6/syw7Wo6lVsoYCc6rBB2gJfc+ig56x3BeSyikY0qVrvcFc43hsQF6I9rjt00FcnpIURlHDIaJ3wGOFWACRYgSoM8spURcb7OLhGx1eMC5iMXD/atfbQE1zc2fuzcBlTtJJNLzmtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gmw2avS/; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30a29f4bd43so37249601fa.0;
        Wed, 19 Feb 2025 07:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739978652; x=1740583452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lrnqLVDBWW+mF9ezkN3CjkgFYa7vo/xRQjq0L2epDyA=;
        b=Gmw2avS/e0sDRA7u15LXqMmpP+u19KNSIUS295Gd4c9tUR+/VUBfJ6oHkUz3SZPFfT
         YHDkGpoCercHycBtknpeZSnFVfvH26M6jZEtMCQg4gGkfmq2cObLjCl0PGycJGuGSU7Q
         M5HeVWEewImSrmsIOkEQtt2FGs7T7mjyjc4Ky45bzEC+ELpZS26lU+5kPIR3Ts1RD9HM
         QZK1hOwmX56PmJ+AOywkPluOkDe08NupbWoYH7Ao2qnMjGREBdYfYYZTz6NPGmqvr16f
         l0hytTmR3CKfONYoalNkpiBf77BaT7tgiYKSGaXXpBMaKhoEPouVDfDjMvz9hzNqqj6L
         12aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739978652; x=1740583452;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lrnqLVDBWW+mF9ezkN3CjkgFYa7vo/xRQjq0L2epDyA=;
        b=T0f9SZu3tRrZLF7CyhSAmtM2YfaYSx8BInN8AHoauMlMYCB1YOwCiLZK0P4N70dYG8
         kVMP2cT4C5d3orj7lU4MjhsgPBTgxQzQAm0Ia+Fl+HqCzkvO72uIG0rR+R4u7aD+NqS8
         AbDiGibQsR/3Qh8f9+hjHP8CbcJqfC9j+8tT9Shj8T8fE06OKcVH4j1os8qys6TUSmzg
         attmo1wRvWuO32rWPVzqDRzD987Ehc0ttPTXUvfpQAHqGthNZNPYD4Xr8pppEcoelwul
         O+NY9mvNhVlWaBWS2ZTnU1ymZu+waBrZ0wPghVSBlZ/sIWTfkAKkjIrjcgRZT3K1q6UF
         V6Ng==
X-Forwarded-Encrypted: i=1; AJvYcCX7vtAMGo6+QTyprUxXGaaYuBktzFJL1r/3I3Fuhmy0A+/zX1Pcke6bRdKib4KsQ6bdj7Xk5DBRXfUEfWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCdhLFhyfKz0GNWzuuh/cDKawFJbKVLpp0AoQvAkeBx3hOtwrp
	vzygyXWL3GwO74PEG2scUaMgJEg9Vcmz2XXL1d/MvjCZR69sKtlY
X-Gm-Gg: ASbGnct3x7BYILK0EJaabvgebi+Vci56pZI6hRiOkY5uQvwTDl4kZW2KP81177xKwbj
	21qddS2nujRfD85T1isnYQ7KmMXrEIO8VEsQhIYolf1gnds6k3ydAfJahSG3LAD9phEqFB2QCrD
	Vayb1wodDw65nGREvmilEN/MnnHIjyvNgJP1PfAKD8MdWuvJko9qhpDpbBUQ7AjMjO8srJ8eQsJ
	tmnZ6hn4ijKTvvW/gyApiK7iylLK6VKdn4PoFZj28mXwnrNJe4mPA4JASOr6i4MobSLdnn1nrfc
	K9/r5hLD2iWFfIm568yXalrHkawrposMAXc+HHTYWPe35mfsTRBGT77n/3kj0GDlI58tRGigZdO
	xEPN3qopLqQFmOkp1LxJfKhdbHcF0kpLdNme0
X-Google-Smtp-Source: AGHT+IH58UK3s7ffFDj3Gx60vr62hzm6v5h4jV30DbH78mNEHe20BtyvIiamX1TulZDRBvnCevPTXg==
X-Received: by 2002:a2e:b6c7:0:b0:308:e9ae:b5b3 with SMTP id 38308e7fff4ca-30a44dac868mr11254411fa.1.1739978651498;
        Wed, 19 Feb 2025 07:24:11 -0800 (PST)
Received: from ?IPV6:2001:999:400:2a04:e774:ddfe:347f:bb68? (n4bkk9yqra8wbkrzgx4-1.v6.elisa-mobile.fi. [2001:999:400:2a04:e774:ddfe:347f:bb68])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3092fb236cbsm15172441fa.69.2025.02.19.07.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 07:24:10 -0800 (PST)
Message-ID: <bab71a0a-bc4c-4ec1-9db8-0d9153da505c@gmail.com>
Date: Wed, 19 Feb 2025 17:24:10 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Enable second resource range for
 BCDMA and PKTDMA
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, srk@ti.com
References: <20250205121805.316792-1-s-vadapalli@ti.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Content-Language: en-US
In-Reply-To: <20250205121805.316792-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/02/2025 14:18, Siddharth Vadapalli wrote:
> The SoC DMA resources for UDMA, BCDMA and PKTDMA can be described via a
> combination of up to two resource ranges. The first resource range handles
> the default partitioning wherein all resources belonging to that range are
> allocated to a single entity and form a continuous range. For use-cases
> where the resources are shared across multiple entities and require to be
> described via discontinuous ranges, a second resource range is required.
> 
> Currently, udma_setup_resources() supports handling resources that belong
> to the second range. Extend bcdma_setup_resources() and
> pktdma_setup_resources() to support the same.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 7ed1956b4642..b223a7aacb0c 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -4886,6 +4886,12 @@ static int bcdma_setup_resources(struct udma_dev *ud)
>  				irq_res.desc[i].start = rm_res->desc[i].start +
>  							oes->bcdma_bchan_ring;
>  				irq_res.desc[i].num = rm_res->desc[i].num;
> +
> +				if (rm_res->desc[i].num_sec) {
> +					irq_res.desc[i].start_sec = rm_res->desc[i].start_sec +
> +									oes->bcdma_bchan_ring;
> +					irq_res.desc[i].num_sec = rm_res->desc[i].num_sec;
> +				}
>  			}
>  		}
>  	} else {
> @@ -4909,6 +4915,15 @@ static int bcdma_setup_resources(struct udma_dev *ud)
>  				irq_res.desc[i + 1].start = rm_res->desc[j].start +
>  							oes->bcdma_tchan_ring;
>  				irq_res.desc[i + 1].num = rm_res->desc[j].num;
> +
> +				if (rm_res->desc[j].num_sec) {
> +					irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
> +									oes->bcdma_tchan_data;
> +					irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
> +					irq_res.desc[i + 1].start_sec = rm_res->desc[j].start_sec +
> +									oes->bcdma_tchan_ring;
> +					irq_res.desc[i + 1].num_sec = rm_res->desc[j].num_sec;
> +				}
>  			}
>  		}
>  	}
> @@ -4929,6 +4944,15 @@ static int bcdma_setup_resources(struct udma_dev *ud)
>  				irq_res.desc[i + 1].start = rm_res->desc[j].start +
>  							oes->bcdma_rchan_ring;
>  				irq_res.desc[i + 1].num = rm_res->desc[j].num;
> +
> +				if (rm_res->desc[j].num_sec) {
> +					irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
> +									oes->bcdma_rchan_data;
> +					irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
> +					irq_res.desc[i + 1].start_sec = rm_res->desc[j].start_sec +
> +									oes->bcdma_rchan_ring;
> +					irq_res.desc[i + 1].num_sec = rm_res->desc[j].num_sec;
> +				}
>  			}
>  		}
>  	}
> @@ -5063,6 +5087,12 @@ static int pktdma_setup_resources(struct udma_dev *ud)
>  			irq_res.desc[i].start = rm_res->desc[i].start +
>  						oes->pktdma_tchan_flow;
>  			irq_res.desc[i].num = rm_res->desc[i].num;
> +
> +			if (rm_res->desc[i].num_sec) {
> +				irq_res.desc[i].start_sec = rm_res->desc[i].start_sec +
> +								oes->pktdma_tchan_flow;
> +				irq_res.desc[i].num_sec = rm_res->desc[i].num_sec;
> +			}
>  		}
>  	}
>  	rm_res = tisci_rm->rm_ranges[RM_RANGE_RFLOW];
> @@ -5074,6 +5104,12 @@ static int pktdma_setup_resources(struct udma_dev *ud)
>  			irq_res.desc[i].start = rm_res->desc[j].start +
>  						oes->pktdma_rchan_flow;
>  			irq_res.desc[i].num = rm_res->desc[j].num;
> +
> +			if (rm_res->desc[j].num_sec) {
> +				irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
> +								oes->pktdma_rchan_flow;
> +				irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
> +			}
>  		}
>  	}
>  	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);

-- 
Péter


