Return-Path: <dmaengine+bounces-2709-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE079338F5
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 10:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9BEC1F2393B
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 08:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD8B2C694;
	Wed, 17 Jul 2024 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u4O+tZbE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE6D288BD
	for <dmaengine@vger.kernel.org>; Wed, 17 Jul 2024 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721204871; cv=none; b=jzimth//ez4eP/TdwbvMXzLSjXbnvaLuCMiK7p7RzvtKH/JjsqxwgpeSYorlHxMWuwMF3c7PbtZ4KmU2oDL35seADaqCEcRAyyGHMwcZ4zzlX6GfLTuXfLqr4EsXX0pzxdmWSjrOWZ2RGvJLov3Imw5Zw/DIrD8g3xzw9E6gwMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721204871; c=relaxed/simple;
	bh=qDQ4FEVPF7vcFgu1Y6uKkJpnYCBh9uffPV51ueGJ6+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Icc5hfi7KP8w41kmX5eb/OsVhn18n1hF4f0MOaExvb9H012VZ7gM+wJnXcwkKvRA2vLeRkxtJWAhjyW56EuZPF3J0gGEKoZisHFOoIhcAddFOWV9RgngJgk3mXNKbmJNdQLZR54UDkL2fOaPLR/5crUlbDHWllMkW5/UKu/i9hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u4O+tZbE; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70af8062039so4490275b3a.0
        for <dmaengine@vger.kernel.org>; Wed, 17 Jul 2024 01:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721204869; x=1721809669; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6T1xNwM9hIsYKRdvOkLIyfbvJlh9uTBuXsM8E9jKuOc=;
        b=u4O+tZbEufTMDov1t1yICCzs1YQLfuiZVev7hsEwLbpodssusSOJXhDtHS1wwlaic6
         5HB4Gmxl3lOkv9SaaE4gcDCI6V6uKuL0LW1cl3+m1+cXchkUImj/gZik0E7BCAvjgFi0
         K9/qzLlA/3SCXyxGUgWVswZA3QskjRRf0EexpmwHNXeXSpCk6G1oepLEQT4T7+7FiyWW
         e47N2hiRsLUanSAfJcsX6zRaR8JPEdBZz0jAz9sjyhtbg3AmImyfLWUYzuwfHGN95rYU
         7P4xoA4Z8eYNC6U7werwHn2cdUVhXp4lUt566Lhkhr4H6oXd9Vds+nszzR/j6sOkZLEM
         n3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721204869; x=1721809669;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6T1xNwM9hIsYKRdvOkLIyfbvJlh9uTBuXsM8E9jKuOc=;
        b=Z54kmPDgOG+RHGapa7V0r0cpK55kc53TwCDOfayNAH3YNKso1wcCnAtCJbn3lT4aPn
         pT2l9cDTLZVijV7kle04UAqYxBO5w8nmVyqb6IKyuyRxicH5TMTDYHGZs4Qxmh0jXxOY
         frc1UW0fqmhff+B9PMe2xNzbuw3RdVuwutUHObYNLrou8r0olMa+f7qq05Ds05SayELS
         KwZexSDnrEklLtJNV9Z8QSQWSN7IJ5UZIFqwfKwuOMBxv3uNoyKtfJxrocxQ4ruR2rCT
         PBib2N3VMbEUleFpWiYdBMlRRgFLUyxwv24Fo+ayIkBvvb73Ceanzlee7bmEOfywGx1v
         6sHw==
X-Forwarded-Encrypted: i=1; AJvYcCULk/vBxolkJ1c/uuQNpGa0gfAJ8iqwBEEx35X0bspJK/7aiTM24uXsheb+JuaU+aCf4GeKk9DIfbxeeTXyV/b6vhonnd1Uf88P
X-Gm-Message-State: AOJu0YwjhCFOCTh9BDYVTpZsVuLc89G3geekHMabAFg7JNBZyBYxCcy6
	SW9TXQ21xpB0Z8JcC4pFNiakXkdAa76w2x6vLX0+AdufLdycLj5udW0S6mHBZQ==
X-Google-Smtp-Source: AGHT+IFZMM/FiXimF5vI+0WtXUuOelgUJVNM5hkL9Myp0C9LDeDktLrxLZeuvuLQxdjLoo9D3K2J6Q==
X-Received: by 2002:a05:6a00:1a88:b0:70b:1d77:7310 with SMTP id d2e1a72fcca58-70ce50ab2cbmr781505b3a.30.1721204868757;
        Wed, 17 Jul 2024 01:27:48 -0700 (PDT)
Received: from thinkpad ([220.158.156.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ebc437asm7584384b3a.53.2024.07.17.01.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 01:27:47 -0700 (PDT)
Date: Wed, 17 Jul 2024 13:57:41 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: fancer.lancer@gmail.com, vkoul@kernel.org, quic_shazhuss@quicinc.com,
	quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dmaengine: dw-edma: Add fix to unmask the
 interrupt bit for HDMA
Message-ID: <20240717082741.GB2574@thinkpad>
References: <1720187733-5380-1-git-send-email-quic_msarkar@quicinc.com>
 <1720187733-5380-2-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1720187733-5380-2-git-send-email-quic_msarkar@quicinc.com>

On Fri, Jul 05, 2024 at 07:25:32PM +0530, Mrinmay Sarkar wrote:

Subject should be,

dmaengine: dw-edma: Fix unmasking STOP and ABORT interrupts for HDMA

> The current logic is enabling both STOP_INT_MASK and ABORT_INT_MASK
> bit. This is apparently masking those particular interrupt rather than

s/interrupt/interrupts

> unmasking the same.
> 

Please add the implications of this issue. I guess if the interrupts are masked,
they would never get triggered.

> This change will reset STOP_INT_MASK and ABORT_INT_MASK bit and unmask
> these interrupts.
> 

How about,

So fix the issue by unmasking the STOP and ABORT interrupts properly.

> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>

Please add fixes tag and CC stable as this is a potential bug fix.

> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 10e8f07..88bd652f 100644
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
> +		/* Interrupt unmask - done, abort */

There is no done interrupt in HDMA, only STOP. So use STOP, ABORT here and
below.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

