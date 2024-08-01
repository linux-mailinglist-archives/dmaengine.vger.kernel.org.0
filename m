Return-Path: <dmaengine+bounces-2769-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E289454F7
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 01:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F00F1F215A2
	for <lists+dmaengine@lfdr.de>; Thu,  1 Aug 2024 23:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC1F14D283;
	Thu,  1 Aug 2024 23:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mrj/CgkY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7055825757;
	Thu,  1 Aug 2024 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722555736; cv=none; b=QFNcRGvRTwr+182qZc9QhSqPdLUDmh/anK7KnT0DEWb6OeTDoUHFOuIqSMoEJGUnNIH0EAimslyYFAqISdsmiTtNzDabCKUPrkFhj0AzE20DFzV9dDvbxpDtU2XxUNcDWFgNZyro7qycL4EgFRM050R/+uzqNl2dymPGsgvBsN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722555736; c=relaxed/simple;
	bh=jAHe/uwCjYKfbL19ycIENwnpp6QugdkiUW9zQVo064Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WclvQZf+g4D3m2tqKnDwXoHVhzgfafJZQXm+xeH3/HII0W8VqL5tkjNJEQnn5WDo+GSzrfHvLtSm0smG+rzbaSbdHkdajddqSSmebXEMbtNLBP2i91B5D5WqoLxkyp93y+PvL4PHA1M+/86Kpgdrn4D2aeh/kRK5HdC+JQJDMgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mrj/CgkY; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52fc4388a64so12527562e87.1;
        Thu, 01 Aug 2024 16:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722555732; x=1723160532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XLOii1TDPm+tsxmeJnsWBkjIQ+yNFrbZu6tQ0QHcAQI=;
        b=Mrj/CgkYUBMx+wOG1VHXrR4zH8xKZfQ5NefakU9CG7hY26vparc+OzboxPTzcSmNce
         qKZFtqHrPRcw/JimPMZ5W8OMj/8ckz0iUIUtAGEg3UanstAZoP2nd1oGTmVcPG1eyRHJ
         DEf6V1SaM5MjenQOOulE5Na91+HX9Yfoe0oTGuP8gdVb9SaYwPW8wZdhooMSONtKvZY/
         SGqlI04WaY+rnwDtcS3mpYfHh88pDTqadiLH1117Xqu55tQ0UjnWPXJACOMwN+VXHaL9
         z1X+FNXD+DhJuqrejutMG/3HodhZTr4jzHWtHP3yeJY549LumUeq+t1TDDVMuJj+c5iN
         KY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722555732; x=1723160532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLOii1TDPm+tsxmeJnsWBkjIQ+yNFrbZu6tQ0QHcAQI=;
        b=o5+E6FSTACpaBOCxjR+SeBrFzXqkwkH7rMJjIMPzS6LoDj3fo4Y5fzzqKe6r06xKGd
         /n92sg6wm2tZFDyKQ+xLEQiOBP18+RSIjcwQnNVoThZZwq2f+Qf09O6RlZFCFqco92x4
         v/Gn4ogt7gOQ+q5s5hWT7vKxG2wj0+Zi6mnW63VwZlUf9Qrggvp/LrgyCs2IzfKf+7UL
         HLzNblitXtGF7E/gnnL7rBRq+VqzeBlWw0ifnNGXGT51mvknl3SwJZXGEXkBVdS5Ft0d
         6jl50GpNOhpatrFAOXpBbd5tMDQxXD4QREk2E9oBtRSytSzp8PHJQlD83/b2WmwUTBfd
         HSlw==
X-Forwarded-Encrypted: i=1; AJvYcCWMy6QbAkXoXpnWRhfP1ZWPngxXXYoWeMAcPzwrE7aFAgK1PT7smxWv3LZyvvEM83zGeaXS4ju+q2Hj/fHc6lJysKOPPdzjModrJBdzR/j2EZv3z1SvSsrEgUDZ/HmwV5a6i84ZcnqM3HQOe6lJvuSlWRlU4S4+30ntNWE0+Vvw
X-Gm-Message-State: AOJu0YyzL1M9GTgxkwR7wW+jCpcnuohoDR4QotbioZBV6u6cttDoa4Of
	z/Kb3O75T2kL5en7cN+TvQ2Sl8EDSWYqq6deHKFm41ubOtfQY9AA
X-Google-Smtp-Source: AGHT+IGazWTXbM4aLzliRklPWbEK3RpCC4nA1b/s5K0pwJ/DSb5bm5ocrGqyPlnWLxRS2wzUiH7agQ==
X-Received: by 2002:a05:6512:33c9:b0:52f:c10d:21f0 with SMTP id 2adb3069b0e04-530bb3b0f98mr1032222e87.54.1722555731890;
        Thu, 01 Aug 2024 16:42:11 -0700 (PDT)
Received: from mobilestation ([176.213.10.205])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba3c86esm76040e87.238.2024.08.01.16.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 16:42:11 -0700 (PDT)
Date: Fri, 2 Aug 2024 02:42:09 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, 
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com, 
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com, quic_vbadigan@quicinc.com, 
	stable@vger.kernel.org, Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: dw-edma: Fix unmasking STOP and ABORT
 interrupts for HDMA
Message-ID: <dnvoktjxx2m5oy2m5ocrgyd4veypnjbjnth364hl32ou4gm3t2@tjxrsowsabgr>
References: <1721740773-23181-1-git-send-email-quic_msarkar@quicinc.com>
 <1721740773-23181-2-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721740773-23181-2-git-send-email-quic_msarkar@quicinc.com>

On Tue, Jul 23, 2024 at 06:49:31PM +0530, Mrinmay Sarkar wrote:
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
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 10e8f07..fa89b3a 100644
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

Just curious, if all the interrupts were actually masked, how has this
been even working?.. In other words if it affected both local and
remote interrupts, then the HDMA driver has never actually worked,
right?

> +		/* Interrupt unmask - STOP, ABORT */

> +		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) &
> +		      ~HDMA_V0_STOP_INT_MASK & ~HDMA_V0_ABORT_INT_MASK;

Please convert this to:
+		/* Interrupt unmask - stop, abort */
+		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
+		tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);

-Serge(y)

> +		/* Interrupt enable - STOP, ABORT */
> +		tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
>  		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
>  			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
>  		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
> -- 
> 2.7.4
> 

