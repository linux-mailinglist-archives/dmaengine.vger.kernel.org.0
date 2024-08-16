Return-Path: <dmaengine+bounces-2880-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3826695512F
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2024 21:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28FF1F2304B
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2024 19:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652101C0DE1;
	Fri, 16 Aug 2024 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxFWzbqI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975F3824BB;
	Fri, 16 Aug 2024 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723835103; cv=none; b=gPvsxvGusN9SkWfzasz+9tt7cE5QI/5wHyZYuKkfp6hsr6++RvvfxiLtKb23QCDRoadFik5dZoWjzInxVvOc42Pqa2tB9coRBEwGHbkgfANdiWi9nml7h/OhJ5SbcPt6JqE4AbGmpVgkYfXGyeVgVK3v4twnic3IfSkhedDYITI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723835103; c=relaxed/simple;
	bh=U3bFOsb86tX1INchCfns3wQ//3TtYTMM8Cd5pNlux1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+vW+TDJJA7A/GPISyTQ2ECnNSAn18fvQZL7qMh2Bfzt0rF2C35yjFdnTC7ZlwSeF03moYOH862wZGEV+P1HVHSll3Ie8vWTrNmydBu1Iv3hP+6oc7GBlTV9pGwuxa4wj40NyXh9ER0Jp3C8dFQ+ObUj1d0v3IEVcbpo9k/1PvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxFWzbqI; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f149845d81so22874181fa.0;
        Fri, 16 Aug 2024 12:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723835100; x=1724439900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0BiaYWGKCbYOSrA4O/Mp9//Ct813gtEjKVKXKN3IFtw=;
        b=gxFWzbqI86eAHmWVPQuiXi/sJIuKl7QeVsGaCRYqf8ex24xvl4tqtti7FyWycRfgyG
         hFGl9kAI0N1hbOiuaAuG6PHZKpFzWFUSH0tEswTxgmnTt0HIg9fB7IJV3NHkwS5J7KeA
         NlbBFxxi5DBcz+qFtvmrQiaggIID3BV5wEiSZ9bkX0TmxfcAdXoamSAq4yFtGN10vL4v
         zIfgbPGCdHJgCBLOsjwc6cM2G7lBoo8OY68m+RjQ6qNyIM6CXG2AvWe+lmP1hUUCDAuz
         XgQbjkPczD6zQT2bGzAGFm6BGCdUne+CFUUESB5JjJR2ACz0FGKd7y01/NPa+oETCO8U
         ucHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723835100; x=1724439900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BiaYWGKCbYOSrA4O/Mp9//Ct813gtEjKVKXKN3IFtw=;
        b=qoF6x/0OJ+K2RiZ1J5GV9MGJc2B2LjBA778WnIW9MdVOCfNz8lSGZqXuwgWbFBqnm3
         ybKyWO0X0aqIdBj9LHLSvHlwr6FCrGwSUGju0Yf8Yj+s8GHLzvwCUZiPJyCr8AYq2lUU
         Y1Opn/V9yROZx5sQWoc0a1d9L8BpaeVsErytPdd9I4DPVOTSwJthbVotNWS0tBmfmj8a
         wtvuK2pTWH6SAsBYtew64IUqjU1dcaZxgsrn/KExbNnSEn+R/E07Ahc4v9zbk5ZYSmEo
         CvOfUzns3saBShFB5817OoOZwRKVhB5+I4n3jg1MjJ4kS2iP0nCk33otF3PcTEOTGnws
         WjOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtFdxlPCu+lDnot4g9dyHjzSzjAu65pSArZ8fiQNJD59GK5H3JuMU2HB8ldtsrhzXumPPn97IZFOi9TYb1ofS7wFo1ufVQDSmD6eS9WCiJQkkpNBf+qJ/MjiQKQJRdQ9U5cs4osqudnZhwwTCMqOHlnOIp++O18TdPlv4dS9UO
X-Gm-Message-State: AOJu0Ywo4moGIS8HDTNgirn0pJr4SbOewGinjl1SYoad1UvivU+0XNw1
	L2XikGmOtpcAez2jcdRkSquQv97CqMhFqozZpjJnZX9XeAAVbVkzXC2CCA==
X-Google-Smtp-Source: AGHT+IFhelxmEPpQ2yAPk4N6UzSc/vAmHOdcCm144whUB788vgz8OCGV+VCxJhTkegxp1jzRJzVN3w==
X-Received: by 2002:a05:651c:1506:b0:2ef:265e:bb93 with SMTP id 38308e7fff4ca-2f3be578483mr29616821fa.3.1723835099056;
        Fri, 16 Aug 2024 12:04:59 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f3b74b28b3sm6264011fa.66.2024.08.16.12.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 12:04:58 -0700 (PDT)
Date: Fri, 16 Aug 2024 22:04:55 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, 
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com, 
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com, quic_vbadigan@quicinc.com, 
	stable@vger.kernel.org, Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dmaengine: dw-edma: Fix unmasking STOP and ABORT
 interrupts for HDMA
Message-ID: <k4kies4zeeda3nqse7ok5nxlg6nymznkktpalf2bx6wvegvhjo@s7breuqvbnq6>
References: <1723554938-23852-1-git-send-email-quic_msarkar@quicinc.com>
 <1723554938-23852-2-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1723554938-23852-2-git-send-email-quic_msarkar@quicinc.com>

Hi Mrinmay

On Tue, Aug 13, 2024 at 06:45:37PM +0530, Mrinmay Sarkar wrote:
> The current logic is enabling both STOP_INT_MASK and ABORT_INT_MASK
> bit. This is apparently masking those particular interrupts rather than
> unmasking the same. If the interrupts are masked, they would never get
> triggered.
> 
> So fix the issue by unmasking the STOP and ABORT interrupts properly.
> 
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> cc: stable@vger.kernel.org
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 10e8f07..a0aabdd 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -247,10 +247,11 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  	if (first) {
>  		/* Enable engine */
>  		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
> -		/* Interrupt enable&unmask - done, abort */
> -		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
> -		      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
> -		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
> +		/* Interrupt unmask - stop, abort */

> +		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) &
> +		      ~HDMA_V0_STOP_INT_MASK & ~HDMA_V0_ABORT_INT_MASK;

The gist of my v2 comment was to convert the chunk above to:
		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
		tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);

This is a clearer representation of the IRQs _unmasking_. Moreover the
code will turn to looking a bit more like what is implemented in the
similar part of the dw-edma-v0-core.c driver.

-Serge(y)


> +		/* Interrupt enable - stop, abort */
> +		tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
>  		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
>  			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
>  		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
> -- 
> 2.7.4
> 

