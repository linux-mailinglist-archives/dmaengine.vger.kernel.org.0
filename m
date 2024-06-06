Return-Path: <dmaengine+bounces-2297-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89AE8FF3E5
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2024 19:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B877B29B35
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2024 17:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A2B1991AD;
	Thu,  6 Jun 2024 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAgW+57G"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82811990C0;
	Thu,  6 Jun 2024 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695396; cv=none; b=K/hmjgcQ0fQRRHvkVkJF1GM1953Lf55NRPp5UDC+mMQK1NfFaOJkDFPgGetkw5oCgRW7mmPdUcCJj6bvXTaZHzcDRi4MQXDhwevvrTKII+5j41HvKj17h02jCOtgscl66xvU6DM1fiEF+/pVsPrYkEwB/jfHfAcft2Yiakw8PHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695396; c=relaxed/simple;
	bh=7DsFrLZ1A0aXabiplzYPnYE/moNjQGYz9wk06ZU1JVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KiILqKCrKUKw+a30RVeH5VEhC+G3kZvzy3AJ0aAchLJX0iPkg37x8KTB9qZj9dVFPYPBuo9e5zgJk5ydI5GZCbEhuZm7gPbuddw4WQTHDiYShW7q3EMou6UifS+FIJMiTq08TDPWn9sSg/EtGn3THHsMyZ544Pxi8sFz4Mntntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAgW+57G; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b919d214cso1250587e87.2;
        Thu, 06 Jun 2024 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717695393; x=1718300193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+AhFjx7oZyl4h/X/TIV0j2lLchguX/BQrq+sZk9X17o=;
        b=XAgW+57GH5Fvn1hr+8E7R6S0LjMKC3ynQSjnqWXcfk6bLKdXFUTJONZ5Q2pxZu0HuR
         3NnlenVKN2Jxom+ce89fYeQp1Nk//lDzWpeDP43dfrw16btQMSklY4cDvj7afGXu/bMF
         rNiEcuFVFKZ2qT5DbAY8le0tgPuU3s4SQfKh0/LtshWzyVm/3bHBor0+AAvPRsj0zh72
         Nv4oJHp9fRCo1laZOc81MA+GM6AdMwhFgYIIh/B6an5YWfVCHsNaN3Qy8bj3th4hTJsm
         MtWRfm8Mlcd/IRI+zE5GzsVQ2xtQGe/b/g2IiO6T3+zhXBdd8t30nOwYD1IhaYzUyCQs
         CEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717695393; x=1718300193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+AhFjx7oZyl4h/X/TIV0j2lLchguX/BQrq+sZk9X17o=;
        b=F+Xr2xQMwEh500nHKloTW1lvBPIicuHJrSTuBydWPokOqbcHfKwSTSacGExSD5/iRv
         T4AbktdTJEpgXXl9ZsRog8Cxvr61bdqw5L2ph1RfBAWFUv4vNLKtQM9cHORBp7/je/xg
         3v+fBTlnAmC7cJ5HaHBEui3ZgkBBzWhmBfPxlmELrAsHsNT1tJZ0WZOnLYx3xBjY+Vgs
         JLy/bXstlbjqBg/pFAqD5Tneqiqm2mRM/EbTnBqrYJ6NLDkvy9O/XeJH4UzmQEqv6C2Z
         nWZCgZSGxsrcJxNumvwOkSuQ1bMAI+sEY16zcnOkgiY9XOBrgIxD2INpXZLVfWZFIiAq
         s94w==
X-Forwarded-Encrypted: i=1; AJvYcCX+xHNelYBIKSwg5kOKrGitBHXLZhQjnrSYF4HlUWA0reXJWIt3y8UvALcL0mw/1E6yDMpBDl5sOPYD0J0t9tVrxQOKLAaWf1Dwvgfc
X-Gm-Message-State: AOJu0YxdSggh/MyCDgFIYg0nI3W4hT+5ri4HXiUev43fWhy0U532IN0M
	hYOKmH/wDAyg2XdxUyuusF4CrPbXw48id5HgfzgqNvyFryy/Xtexvf585rZC/z4QdQ==
X-Google-Smtp-Source: AGHT+IF3pzbeHhYLAJrDKTLTpaFuP26mSfHAEVGD16RvvvIUapR1YxJAXb2kHOn3KBNWUOhXRX7Jdw==
X-Received: by 2002:a05:6512:4024:b0:52b:ab25:a4d with SMTP id 2adb3069b0e04-52bb9fc9561mr210491e87.48.1717695392386;
        Thu, 06 Jun 2024 10:36:32 -0700 (PDT)
Received: from [10.0.0.42] (host-85-29-124-88.kaisa-laajakaista.fi. [85.29.124.88])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb421642bsm253702e87.136.2024.06.06.10.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 10:36:32 -0700 (PDT)
Message-ID: <30b7e588-d20c-4906-a954-48be72ed5199@gmail.com>
Date: Thu, 6 Jun 2024 20:40:05 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix BCHAN count with UHC and HC
 channels
To: Jai Luthra <j-luthra@ti.com>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Devarsh Thakkar <devarsht@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240604-bcdma_chan_cnt-v1-1-1e8932f68dca@ti.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20240604-bcdma_chan_cnt-v1-1-1e8932f68dca@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/4/24 12:51 PM, Jai Luthra wrote:
> From: Vignesh Raghavendra <vigneshr@ti.com>
> 
> Unlike other channel counts in CAPx registers, BCDMA BCHAN CNT doesn't
> include UHC and HC BC channels.

Oh, it does not?
Back at the time of 017794739702 there were no devices with H/U BCHAN...

> So include them explicitly to arrive at
> total BC channel in the instance.
> 
> Fixes: 017794739702 ("dmaengine: ti: k3-udma: Initial support for K3 BCDMA")
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 6400d06588a2..710296dfd0ae 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -4473,6 +4473,7 @@ static int udma_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
>  		break;
>  	case DMA_TYPE_BCDMA:
>  		ud->bchan_cnt = BCDMA_CAP2_BCHAN_CNT(cap2);
> +		ud->bchan_cnt += BCDMA_CAP3_HBCHAN_CNT(cap3) + BCDMA_CAP3_UBCHAN_CNT(cap3);

I would add them in a single operation. Easier for the eye:
ud->bchan_cnt = BCDMA_CAP2_BCHAN_CNT(cap2) + BCDMA_CAP3_HBCHAN_CNT(cap3) +
		BCDMA_CAP3_UBCHAN_CNT(cap3);

>  		ud->tchan_cnt = BCDMA_CAP2_TCHAN_CNT(cap2);
>  		ud->rchan_cnt = BCDMA_CAP2_RCHAN_CNT(cap2);
>  		ud->rflow_cnt = ud->rchan_cnt;
> 
> ---
> base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
> change-id: 20240604-bcdma_chan_cnt-bbc6c0c95259
> 
> Best regards,

-- 
Péter

