Return-Path: <dmaengine+bounces-8128-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3C5D03312
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 14:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86D13318851C
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 13:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7144DA558;
	Thu,  8 Jan 2026 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhKmOXNz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368554DA52A
	for <dmaengine@vger.kernel.org>; Thu,  8 Jan 2026 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879591; cv=none; b=ulj9RQmrDLsgy0rotxoUoMs6dGOg1uyNBQAhUIKmV8XoRL781mloD3sDxvLfJcEyhKwLb2XlkdUqSBLuwJJI8r+48oDK0z+uqMpSmV2f85V7I5vkQWl8IjWyosj1AZaPrR/xR2+p1KDEHtWycSiEkvwRxfNDjMxtmK5rbV+USAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879591; c=relaxed/simple;
	bh=hCI9wYQ6uI2Nplbg3MyIHVUziIeFUo1oeGPbCby+ShA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HCrlVITKkRWK4/+JWdII4/SNfpZHh0eAqD46u32BCKNv1XvY+FnXI66QyPSnnBrLAHcsXBgi4aDejncNuU+jrffe+tyiqpc8qKRlL4RzG2xF9O3LVcT9I8h5NCsSg0nJli8ZtjGADc8vZ1uIrlzOdNlR3YFlx9MVuPVHZP31Ph0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhKmOXNz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477632d9326so19846895e9.1
        for <dmaengine@vger.kernel.org>; Thu, 08 Jan 2026 05:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767879586; x=1768484386; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qXQz2rsVUCTFDHKFBQRt202TfAKpQJw5L1CIs2YJR+k=;
        b=XhKmOXNznOtU1WXC1csfJXc/hW5CRcW2iWnX5SfGUF3S0KPBxZ8x1MtU1c9r/t5F75
         I2gbsvI8HGTh8CCYeZELE6lSDe1V/QbKQ2Fh5REqkJsotP6+ci7FrgYb/+ItFW/qrM3n
         xtp3qyLFNI/8oaH1zy5WgpnmNAxSTzJ36tg992qVJu+aPWHZPaX0NOurpujcQv1r78xs
         2d+DpOMOFUAa8xIcWhG4n+PdhxDxdxtHJJA9Z/6/GCqDTezUx/7ROfqmmlJ+L9FU2bkV
         bnlsMUhf0YIEr0yOretICigXS26dRWwwBaMSlYGODN/OD798LUZ10SGuIcVTJyibZe2z
         Pg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767879586; x=1768484386;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXQz2rsVUCTFDHKFBQRt202TfAKpQJw5L1CIs2YJR+k=;
        b=nHz4yoHSw1KhOek7oXJvPIg99rve6oKoBIOp3N2OLr16wGqS118Nd2fgBp5nW0uQ59
         44Pz4Dkxrof7H4rh39fTeWJ6V7uGtFwH2O5Sp2zsbG16Vh78wCyozvQLZtJpHYtYACi+
         6qQDbpgwIFvnRZd7neFKvcFmUyqhu7yHRn/HiU6ZwUShjmjkTAps+YyVDPKrbaTvwdKk
         vkyfrmK76XafbZv3O9ZTJZEixTHs4iinyHMJwzwCf7Q7b2jrv47XcVRd5z8Px2uYT5bv
         4MYRBMlzFh7+iHmQmd7COA6JRa5XXpW5aQKNji81hUssz+BgBDlt3G7q0f9ehKeH3ISq
         qCog==
X-Forwarded-Encrypted: i=1; AJvYcCW++0BM7G8rFVSprlPCEUxC8+7qmUfZ2DpVQzL4/THk1caYVP05sY/ifxwGkw2QhvC/ZIEK5vJ9js8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2OP4zLwpQAD6LXqNqP38gxGhVk1Tt0R+MjE8yNRWUsVvjuEiJ
	WErvOawRcDWzOCxiefOaWoNAPMelXQ4BxWx1COkRdDOUJROrxQA7eDsV
X-Gm-Gg: AY/fxX7rDofuSNrRoCb8UDj5v8T+lq3K7fj63SUGXAsMxI2lI9+EJkl4IypOR3W21gH
	4zHGM7lDm17fRT7knGZQemiFpCiWQeU9L9f3UOnD0T50pXmAEloOr5fNNG4/Z8NHbFadbUXMSZR
	oxXtihoIFl9ENwLrGLuyQf9Mjlu+7vFIUfpGvfghl502oWF6P+AZUfEGZcegdug+wlifS8ac7Hd
	E/yzAZGaTSH0cGk5D54xtQD2hgf1KoJunydIjgtPJfxmuADpgs4Z7+qOIwRJRWYnqr4+1TXnoD8
	WqynyCVBb8rQMTnguPPKov3djkbM/0iVK6LEHDLTrxK2BYTtjATgTGA6hi+vYRhHblyzdYhwbpW
	6HzJcg0/pweZtkVDsXf5Pg1jjKjE2fdhEjuOiW3Bf342XxztsDUdQE8sK/4LplLeq0t6TcQWT/+
	6JBD3/T0inrg/rRQg2RmQ=
X-Google-Smtp-Source: AGHT+IEX9m28A1mhHxExSBVLDLm4HTtI1a7RzBU+5k4F+/tjYzMhXRZ6k4rk+t6E+by8bAuxtzTq+g==
X-Received: by 2002:a05:600c:8b58:b0:477:af07:dd1c with SMTP id 5b1f17b1804b1-47d84b4079fmr79676385e9.35.1767879582169;
        Thu, 08 Jan 2026 05:39:42 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f620ac8sm148629245e9.0.2026.01.08.05.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 05:39:41 -0800 (PST)
Message-ID: <b2713df7f8cb520f3ffbc783a9166499db13bb15.camel@gmail.com>
Subject: Re: [PATCH v5 03/13] dmaengine: axi-dmac: use sg_nents_for_dma()
 helper
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bjorn Andersson	
 <andersson@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, 
 Vinod Koul <vkoul@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Thomas Andreatta	 <thomasandreatta2000@gmail.com>, Caleb Sander Mateos
 <csander@purestorage.com>, 	dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, 	linux-arm-msm@vger.kernel.org
Cc: Olivier Dautricourt <olivierdautricourt@gmail.com>, Stefan Roese	
 <sr@denx.de>, Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray
 Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,  Lars-Peter
 Clausen	 <lars@metafoo.de>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Daniel Mack	 <daniel@zonque.org>, Haojian Zhuang
 <haojian.zhuang@gmail.com>, Robert Jarzmik	 <robert.jarzmik@free.fr>, Lizhi
 Hou <lizhi.hou@amd.com>, Brian Xu	 <brian.xu@amd.com>, Raj Kumar Rampelli
 <raj.kumar.rampelli@amd.com>, Michal Simek <michal.simek@amd.com>, Andrew
 Morton <akpm@linux-foundation.org>
Date: Thu, 08 Jan 2026 13:40:18 +0000
In-Reply-To: <20260108105619.3513561-4-andriy.shevchenko@linux.intel.com>
References: <20260108105619.3513561-1-andriy.shevchenko@linux.intel.com>
	 <20260108105619.3513561-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-01-08 at 11:50 +0100, Andy Shevchenko wrote:
> Instead of open coded variant let's use recently introduced helper.
>=20
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/dma/dma-axi-dmac.c | 5 +----
> =C2=A01 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 045e9b9a90df..f5caf75dc0e7 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -677,10 +677,7 @@ static struct dma_async_tx_descriptor *axi_dmac_prep=
_slave_sg(
> =C2=A0	if (direction !=3D chan->direction)
> =C2=A0		return NULL;
> =C2=A0
> -	num_sgs =3D 0;
> -	for_each_sg(sgl, sg, sg_len, i)
> -		num_sgs +=3D DIV_ROUND_UP(sg_dma_len(sg), chan->max_length);
> -
> +	num_sgs =3D sg_nents_for_dma(sgl, sg_len, chan->max_length);
> =C2=A0	desc =3D axi_dmac_alloc_desc(chan, num_sgs);
> =C2=A0	if (!desc)
> =C2=A0		return NULL;

