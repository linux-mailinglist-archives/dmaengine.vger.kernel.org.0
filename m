Return-Path: <dmaengine+bounces-1596-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A6F88F850
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 08:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07EA61C230F9
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 07:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9DA23768;
	Thu, 28 Mar 2024 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCe9NFQN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A45E50251;
	Thu, 28 Mar 2024 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711609224; cv=none; b=CznBaNFoNbSI4a3ht+eGbMFKPmw9OcZ11JbSboFagk2lj0kag8vv0VG8Wpu8ieJQ4at4WjuqU50jaYJ0NFq61YZFgWTmrdRX3+pqgfG7CrGDMRlBxkN1l93mwao8RpVdj3kaFhOpGWr4ChoXImzRt4QYC4BaGVudng0NHiJDOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711609224; c=relaxed/simple;
	bh=JUFqRAD4Y2HWZLAlM9lU2rge6kJwcXiTTkRldpJIG9I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qiv+RaTbZmMcG9fZDFS33MFZuCCSoMSjp9Dqkd95ZKCQNAc0vRfkz831f52yCJPTMLb6AEFOYIGARx18VmOk6xWQtTae2O3SE85QHIXpJrgQ55He5YDylQXhaIqFNCSEi7foc9PyQLVgq1Jx8J3ap7F2inrZnOINyQ0VheIdiLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCe9NFQN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-341730bfc46so348046f8f.3;
        Thu, 28 Mar 2024 00:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711609211; x=1712214011; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Gw/CxA2/id4s/PnjiC7GhbbN/6K62gqnl0/ttHTZWc=;
        b=aCe9NFQNElX2oQpdVu9+0z8UTKmIXWYrXSFYi1/75vG99end4gziHJYjR+jCe2BpqA
         dBmk/1hvy43XPuRt6ZYzz0Q/LYv8M2LrmOst5/RUiAfr/JwY0LNovz7VbYtsY9kXt41M
         6sxP2TIruw965N9UMFivbjWx/CFhQX0fSRm5UK0ulmqZj8p2HTn4kiPrrGK1z8GVtkXJ
         InuIStDsFiCCjCxGaUMuxbvbIEaRJiM0dbteLzi4lEioXzQGTGpF6BfXa/l2L9CCD1Q2
         QzoN05oiO3GzNDDS6dt6mZbgtF+nqXn8ICPvSsf0yXQBWuhInfLF93yTIWlnp5d1kw4s
         xhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711609211; x=1712214011;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Gw/CxA2/id4s/PnjiC7GhbbN/6K62gqnl0/ttHTZWc=;
        b=bZqNrJu9Ut5x8tfcHC16HicUCfhtIvtdavdfR1JfS5lHg95uRB3IujGA1e1cu2hyFz
         baKz4s00hxuKOnZjWZT0vePB1xM/EZaa80vcjy2KAXJoO2iW5fHb3CRfZXQ5JcbSdtEZ
         TLoq/5Fek5cMVDCnGjtOMera057qrTXF8FCyDoL1rTl4FMPgm5wHW5em7JmeKxpE3o99
         nCL1SU9aYw0llaSYEWh0eFBk279umbOWezSx6Tj8+KhZ225nGd6CIMBAz22Q8rr4KY5x
         Thv1BcF8IXVKQLOTqbtWYb+Vzr2yNGqwMBmSj3PtX3aaQchqkEU7VSVn3rhLMuY6KR4N
         Tkkw==
X-Forwarded-Encrypted: i=1; AJvYcCVNfai18kVgXbnwlV/GHMr/dOtVbSdSI5oC7zb+8RcNYqKhTjgsTNm7nQ0HGml3stZK6a3aCGhQu+PzcF9EGZW/fz8bQ7ZMhxz6
X-Gm-Message-State: AOJu0YyZV9RC/SaDrQ+T0jnLHR37SsHD7o+SE1pbVTfBA8c3R5NhjhhC
	jSVHDZpNUd2uNVCGg/eLiabzjGjoOpwdz0PoZQDZtkktlrsSGMgA
X-Google-Smtp-Source: AGHT+IGCpi2MxgALpE/di2jgiASiBabzio11iyYpmXBqg8v1fRkTiC+ImMu8FL16Tc95h2pmedvdjA==
X-Received: by 2002:a5d:5746:0:b0:342:40c6:a15e with SMTP id q6-20020a5d5746000000b0034240c6a15emr1073404wrw.1.1711609211297;
        Thu, 28 Mar 2024 00:00:11 -0700 (PDT)
Received: from giga-mm-1.home ([2a02:1210:8690:9300:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id l2-20020a5d4bc2000000b0033e7e9c8657sm904757wrt.45.2024.03.28.00.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 00:00:10 -0700 (PDT)
Message-ID: <ce28c856695f895a1fba8d28c656647eb3f67d2d.camel@gmail.com>
Subject: Re: [PATCH v9 38/38] dma: cirrus: remove platform code
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, nikita.shubin@maquefel.me
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Arnd Bergmann
	 <arnd@arndb.de>
Date: Thu, 28 Mar 2024 07:59:46 +0100
In-Reply-To: <ZgT1lkJYP-beY_i0@matsya>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
	 <20240326-ep93xx-v9-38-156e2ae5dfc8@maquefel.me> <ZgT1lkJYP-beY_i0@matsya>
Autocrypt: addr=alexander.sverdlin@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Vinod!

On Thu, 2024-03-28 at 10:14 +0530, Vinod Koul wrote:
> > From: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> s/dma/dmaengine is subject line
>=20
> >=20
> > Remove DMA platform header, from now on we use device tree for DMA
> > clients.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> > =C2=A0 drivers/dma/ep93xx_dma.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 48 ++++++=
++++++++-
> > =C2=A0 include/linux/platform_data/dma-ep93xx.h | 100 -----------------=
--------------
> > =C2=A0 2 files changed, 46 insertions(+), 102 deletions(-)
> >=20
> > diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
> > index 17c8e2badee2..43c4241af7f5 100644
> > --- a/drivers/dma/ep93xx_dma.c
> > +++ b/drivers/dma/ep93xx_dma.c

[...]

> > +/*
> > + * ep93xx_dma_chan_direction - returns direction the channel can be us=
ed
> > + *
> > + * This function can be used in filter functions to find out whether t=
he
> > + * channel supports given DMA direction. Only M2P channels have such
> > + * limitation, for M2M channels the direction is configurable.
> > + */
> > +static inline enum dma_transfer_direction
> > +ep93xx_dma_chan_direction(struct dma_chan *chan)
> > +{
> > +	if (!ep93xx_dma_chan_is_m2p(chan))
> > +		return DMA_TRANS_NONE;
> > +
> > +	/* even channels are for TX, odd for RX */
>=20
> Is this a SW limitation and HW one?

The numbering scheme is defined in HW:
https://cdn.embeddedts.com/resource-attachments/ts-7000_ep9301-ug.pdf

"7.2.2 Internal M2P/P2M Channel Register Map" -> "PPALLOC"

"NOTE: The naming convention used for channels and
ports is as follows - even numbers correspond to transmit
channels/ports and odd numbers correspond to receive
channels/ports."


> > +	return (chan->chan_id % 2 =3D=3D 0) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM=
;
> > +}

--=20
Alexander Sverdlin.


