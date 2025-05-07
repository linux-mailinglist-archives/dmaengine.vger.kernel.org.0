Return-Path: <dmaengine+bounces-5098-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9BCAAD6D7
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 09:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4A64E77D6
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 07:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8FE214A7D;
	Wed,  7 May 2025 07:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR2EZXUC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8B20C02E;
	Wed,  7 May 2025 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746601683; cv=none; b=mXYhi+O6ndoouLG5s2x1lGBs8zRoaPnhfQ42AIX2gBHmxjQeCPl3ra+uBLNP3hTSg22Ji848YLDkommzx61rfqPVPDzNFJ4GqL1HuT4TIWplyZs3merX0NU3Fm4rK1ysR2qcdaswCJ2czEKs4uPVrP74oiP9GmvRxTUJ+ToXYw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746601683; c=relaxed/simple;
	bh=yOFbH434Zg5rDi8e1kT9YhyjSm0ENvujCs9yLE99ktA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uj4sOuPpsAaY8xSrd+Z6WFgP0t4iP/jIgZrhQrF13N19pgwHYHulaoFjSgn43CQFNcQC5DCgvlLcnIqJwjErWrBjwL5mqRA8NrC8MuSJ8mIFpT46RJuF3bpCqbh3bEePHydr3YwPZ28Ju1Hngq7l4r1MP0lxEiNhlDQHs7MLuMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hR2EZXUC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so60439425e9.2;
        Wed, 07 May 2025 00:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746601680; x=1747206480; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yOFbH434Zg5rDi8e1kT9YhyjSm0ENvujCs9yLE99ktA=;
        b=hR2EZXUCI2jZcG3Skqx1VLOYTBnGlwfTWXzOxsAj4BLCL8CNEu4Xm9fPVNxT19dSOL
         9dBSeLAsKEEc2VsTU6kqAvU5i95M2kQadFDuGcW+DLWsaHGHHd9RMNpicy8x+2/Ehfp5
         RZjCc9D80MHtO13PPY7qH0FOpz+Nj73IgLEptsyokEGphijD9Fp+Wr9jpOXPZQwK7VNM
         YAhnmjpSGXAgEo5uxfQQsHvOn5eF8E8R1c6kb5NGWo7RpXMqGL9aXFg14EagFT8X4TiT
         wVpRkfi5jW3ZvwGR4ZptO/NoV62Y5UD39Mf5J5DzbIgjwwA6hpHDxade+ZdU9aZm49sk
         G/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746601680; x=1747206480;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yOFbH434Zg5rDi8e1kT9YhyjSm0ENvujCs9yLE99ktA=;
        b=sUXuYp2s+rvis+8Pmhc9fUP7IblXYIe26DwPlTaCk9k8xehoDD/ZLaI8xrf/KBAkP7
         RQewgwBI0D1BjRK5q5UhOVRNV077QARhEoc15vRQegk2JS52MkF4y5W45upuve72853T
         TAsOoBcDrakR2WmjUgvHh01n6/tyjwLhMeq6HZg2j8nE0+Iu/Gvv8q7875sDmvBbaYBm
         +SbC7PJ+Utl7p9Cm25ju66fIxBTC5ohnNctbJq3zJTpxnjK8nOh1lKn7TXZ7TIvjODk8
         cyEp5w/SIILLsmRRsyxHggi2baAXtjklDmIvB9LPO4Nt74YNCs72OFk3BRJl7l/m2nhn
         EQDg==
X-Forwarded-Encrypted: i=1; AJvYcCU+VUFKpp5D32Dv9zn8DTXZRW/4SXAqJlv/Y53o5kU/zLaFPrmULhgzQpadZIt+b/7UTYP7ZFwFaF7yeHU=@vger.kernel.org, AJvYcCUDnuTD/kvxpuhE0dEhRg32Zawu1w4kaGh8KguB2lAavivye8IygdgQDUca/vwpmyanroLqfWnnQzbl@vger.kernel.org, AJvYcCVFIZNDptWVnui5QsqOsSMMpof60ZI3vVwLB8GJjTAD7qNvs5GoscIrb3RIpwzt80iQ+AOxKzjQIiF/@vger.kernel.org, AJvYcCVNiARqhBe/pjr7+yeBsZ5KMXsYp0hK+DLxlBc701ggQwfaFkaWhNqYUQs0gsnizw9KN9PBv4P90Xbv@vger.kernel.org, AJvYcCVr7qqAm78KJE/6tHDJzFPwdovuxHo7crg42DNNOD7+RNhC61vvgzQv9N+Ax62jJJm5bIh6VhNHOLzxWg==@vger.kernel.org, AJvYcCVtmBLG+0r2DWFzdK8un0svH3Ux/ksZPIq2hBaIFodRxU0Hia35uiKUvD637wE7OhVApgTJFYqMr+M=@vger.kernel.org, AJvYcCXjcDZdxTVZPfv6cgQ5z1fxMfOVagM7+siGKfxEXf2sAxA/hMmgVWmg/yyEbhfNgOE4i5qmMuaMqx/d@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs1ytfyUYkX51S5T0sgSt4mOlzzH88cGzju6T0sB3RP6qw/C9M
	QsxRyEwpic+pNG/X6zQXuMJ/le5l5gXgswZvDOEf4cvpdhh9/Va8
X-Gm-Gg: ASbGncsne0uqz2oJmPzSsiyrKCy4TzBFgtgaH0aZu4u2Wi5Ruk229K0leXUtjTqkO1D
	2SeOhmgZU4LwLX7uP8EO7UCvzRzIVhVYv+pFlSpgB2aUmJgaqOsA8li6VAD3tBvRZsgLR5eRZ2U
	VR30s5SPLtltHyVqXBH0vE2mwvi7soPDshHmmFRry6Jiy1HmlOT3SpNmDizoQ2kZQSirCIDpGlO
	8NRGDaTj8QEA8pcmM1yJ6lt4DXfYiItq1GOzLdFRsCO1qRnqJgjgW1JzseEfgB4oCODDorvg0fb
	Ew6R55OVNnlG5p3JW4Kzftd7whAWqysGii79aYEG/y96TKgQXBF1o+cjPbmH/9L9OagHIIpiU/N
	p/aExdMCIADtTCTOGfKrhWZgsfw==
X-Google-Smtp-Source: AGHT+IEVv9agzvTVDs5bbJ+MnVYrw4KNEaYxq9uzAgvReyxVwN3XJILLyTgLOKv4Mx4+2K0lZOywtA==
X-Received: by 2002:a05:6000:188c:b0:38b:d7d2:12f6 with SMTP id ffacd0b85a97d-3a0b499c154mr1514674f8f.2.1746601679606;
        Wed, 07 May 2025 00:07:59 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae8377sm16222335f8f.59.2025.05.07.00.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 00:07:59 -0700 (PDT)
Message-ID: <ea70735157f47ea096e09f8a03d8151095a04c03.camel@gmail.com>
Subject: Re: [PATCH v4 7/7] clk: clk-axi-clkgen: fix coding style issues
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, 
 linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
 dmaengine@vger.kernel.org,  linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org,  linux-pwm@vger.kernel.org,
 linux-spi@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>,  Moritz Fischer <mdf@kernel.org>, Wu Hao
 <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,  Tom Rix
 <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare
 <jdelvare@suse.com>,  Guenter Roeck <linux@roeck-us.net>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Trevor
 Gamblin <tgamblin@baylibre.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>, Mark Brown <broonie@kernel.org>, Mike Turquette
 <mturquette@linaro.org>
Date: Wed, 07 May 2025 07:08:23 +0100
In-Reply-To: <b5a5a8a6-bb8a-44f0-ba94-7657aba83311@baylibre.com>
References: <20250505-dev-axi-clkgen-limits-v4-0-3ad5124e19e1@analog.com>
	 <20250505-dev-axi-clkgen-limits-v4-7-3ad5124e19e1@analog.com>
	 <b5a5a8a6-bb8a-44f0-ba94-7657aba83311@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-05 at 12:21 -0500, David Lechner wrote:
> On 5/5/25 11:41 AM, Nuno S=C3=A1 via B4 Relay wrote:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > This is just cosmetics and so no functional changes intended.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/clk/clk-axi-clkgen.c | 74 +++++++++++++++++++++++--------=
-------------
> > =C2=A01 file changed, 38 insertions(+), 36 deletions(-)
> >=20
> > diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.=
c
> > index
> > d8634d1cb401fff2186702354ecda7b4fcda006f..63b7b7e48f8fa00842ce4cf2112ce=
7a89fa25da
> > e 100644
> > --- a/drivers/clk/clk-axi-clkgen.c
> > +++ b/drivers/clk/clk-axi-clkgen.c
> > @@ -15,6 +15,7 @@
> > =C2=A0#include <linux/module.h>
> > =C2=A0#include <linux/mod_devicetable.h>
> > =C2=A0#include <linux/err.h>
> > +#include <linux/types.h>
> > =C2=A0
> Might as well sort the rest alphabetically while we are cleaning things u=
p.
>=20

Alright, it looks like a v5 might be needed. I can do that

- Nuno S=C3=A1

