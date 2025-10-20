Return-Path: <dmaengine+bounces-6911-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27335BF2E97
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 20:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B73518A58CB
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 18:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07370331A72;
	Mon, 20 Oct 2025 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kI0XrO/E"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD8328DB3
	for <dmaengine@vger.kernel.org>; Mon, 20 Oct 2025 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984582; cv=none; b=rAXNn5VwjwSCpXzx28L547qazhDV5Uza8Ylud3UunLEGbIClnqislgFGJAbQ9lW7NAyMLRxK+6d5RQLlg+UgmyMNQDd69yK+/v/++3ENJ/IJ9hpFoXxq2SkIxvYscTNZIjfWOI78djcK8Ix6UvP32iYMOo4GqF4f/0RweW2Em8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984582; c=relaxed/simple;
	bh=nJnS4KEn5GPnGDMDu5zhj3c6qjfMfV3vNNzdaEccvcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDqXDS+zicfk+CBSPXMSaPQCkmEE2DJhaRzXAvv0kJDzsrHBDLBtZvJgwUuOfD/90i04oriqm2V1nxDqvIAYix3uoFE+vPLXEhRxYlpwACzDCJzDJFtGzGYYlO1SFwpiZUQ35alFV0o92vGQRRp9h9Pr8POVHYZ1kOrb2j5cxd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kI0XrO/E; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so44210495e9.1
        for <dmaengine@vger.kernel.org>; Mon, 20 Oct 2025 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760984578; x=1761589378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LobheSjDQzmXm5jTVKxbVYkJzFJNe2SiM69pvM7Dmgo=;
        b=kI0XrO/Eddmg4iy8kHI9kFY0uunHeZe/8YUmW4Yy1oHG5zCrjgO26N9vgZ8zwA6pyd
         SI8I/2hI9VGSosWyftCwpYriaBlih632R23bZ5MTZoCe/ocL+qX2+FE9/OfRE5q7Sj1g
         XXnKu9CpTXUbELKW36QTkPlhwMOaJb8FnPcM26TqC+ZVGTDIAgJ9PcLYwKQE7gUZkvh/
         q3dQ7sQQV/QPUjxRI30RKjEHtwViJmxsqKnqcxxqJMQgDbtMvY5W1DEGX/CB4UrDn5kg
         h5s0N7fFP1fqvMAdEO7JXzaX+FrPUPkzbWoLpqA+uK1zQJ8xocmmqNuRjHLHjpkaTdzy
         A4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760984578; x=1761589378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LobheSjDQzmXm5jTVKxbVYkJzFJNe2SiM69pvM7Dmgo=;
        b=rPgx5xqNt6JPbtLghLYRKCJgIlO/DrZTEV+rHhFmyMyMfYqJbNo7gs3pgp7e0fYCAg
         baNi9T7vlT7wlr/PhbABYPCW6/iY0FZyiJKDiyQboe1gtvMFUjjEsZd5WHvm7k2Yhnb5
         QhBD+KxhHboohONgbZxCVuuzplCz/xuuM5V7FXtRPVMf3Z9arkQM9YoNuAviuyKg3d8q
         5xz6cJJ713E/x3SDgZJGImr6UZR31vsRGyoz0NI19hypsoGyI4ozrfOZmxZpci3ESW5p
         uiLwLXPakMpukP8MxOHK3OMmWYuC9FHn6w/fBtLEcKhkjOmTGDoZc3hHipNwHU/mpxn6
         Jjdg==
X-Forwarded-Encrypted: i=1; AJvYcCUxRw8Cv+yjhmx5zzkY+eRPWZvkYptJmg8vuOwkOVAtZP1KQmM4zSo6Q5IIzcOgxQVVc+nJpZE1MHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG1Pvk5YiONqKENM1I1N5Pc80ZNoWrzluP2eXwuGfEE1900nfr
	8KJEGP4PUpjh63EaLsRbbZU7PbdoCEkXeRscQHhQODGakqhtsXSbgIrX
X-Gm-Gg: ASbGncvhqSjPlFbSvfzyhk753he2GMoQfnMTG9kfJBOlxcQIZa3I/x3hxJvmDeWRrBb
	H0ZncRRfTyB2I4XJZCg+Vgs1pA/Xi0+LEVYtuD4sY0kVviEn5ioAs6/do13x+U6xJV2z//82Bxf
	bgxkKU27pQxpbgzbEKGg7pfO54ICKG58mwMwXTgwi2U4PhTXEP71WIs3LRFgNe4B6g9lZRGKe/A
	RzGdLs5+8GO6HQIz68dzl4bNrW/491V0PVtrZD+8dqwmhI3aamt4i3JcQWUFQpJ6y1vUoTNCFxZ
	Q8mqoFNwa50yBYUYNOBXGrYl3lHVkHjobNngHUos8aOEjqJ/yXpRqaIXu/dj2rZXsBCj/iAFRZ6
	wQinSkf45TJRgRW0gI2xGpUrIjw1GwjNYkdKwK5hpRdE4DoKJZctLe5VAvPVi0U51AXmIeJE2mM
	VfTgc55Pv8qOjSwghB64dWEMDWWSmm2+UzBfSPKnsyMiAfTCbCcCJsyPCHBg==
X-Google-Smtp-Source: AGHT+IH8xdImUVWc08yxtV5+NexJ4U7oKJ1he449w6/L8td0W1j3sEp5QRRipKGJLDowyWmFeCZmFw==
X-Received: by 2002:a05:600c:1f93:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-4711791c66fmr116218965e9.28.1760984577798;
        Mon, 20 Oct 2025 11:22:57 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a96asm16569602f8f.31.2025.10.20.11.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 11:22:57 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: wens@kernel.org
Cc: Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 linux-sunxi@lists.linux.dev, linux-sound@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 06/11] clk: sunxi-ng: sun55i-a523-ccu: Lower audio0 pll minimum
 rate
Date: Mon, 20 Oct 2025 20:22:55 +0200
Message-ID: <1837721.VLH7GnMWUR@jernej-laptop>
In-Reply-To:
 <CAGb2v66osdLJa=_nTxz9wppUkxvu2fuS=NgYN8fKOUOLHw6-Ag@mail.gmail.com>
References:
 <20251020171059.2786070-1-wens@kernel.org> <8591609.T7Z3S40VBb@jernej-laptop>
 <CAGb2v66osdLJa=_nTxz9wppUkxvu2fuS=NgYN8fKOUOLHw6-Ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 20. oktober 2025 ob 20:09:18 Srednjeevropski poletni =C4=8D=
as je Chen-Yu Tsai napisal(a):
> On Tue, Oct 21, 2025 at 1:52=E2=80=AFAM Jernej =C5=A0krabec <jernej.skrab=
ec@gmail.com> wrote:
> >
> > Dne ponedeljek, 20. oktober 2025 ob 19:10:52 Srednjeevropski poletni =
=C4=8Das je Chen-Yu Tsai napisal(a):
> > > While the user manual states that the PLL's rate should be between 180
> > > MHz and 3 GHz in the register defninition section, it also says the
> > > actual operating frequency is 22.5792*4 MHz in the PLL features table.
> > >
> > > 22.5792*4 MHz is one of the actual clock rates that we want and is
> > > is available in the SDM table. Lower the minimum clock rate to 90 MHz
> > > so that both rates in the SDM table can be used.
> >
> > So factor of 2 could be missed somewhere?
>=20
> Not sure what you mean? This PLL only gives *4 and *1 outputs.

Right. Nevermind then.

Best regards,
Jernej

>=20
> > >
> > > Fixes: 7cae1e2b5544 ("clk: sunxi-ng: Add support for the A523/T527 CC=
U PLLs")
> > > Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
> >
> > Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> >
> > Best regards,
> > Jernej
> >
> > > ---
> > >  drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sun=
xi-ng/ccu-sun55i-a523.c
> > > index acb532f8361b..20dad06b37ca 100644
> > > --- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> > > +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> > > @@ -300,7 +300,7 @@ static struct ccu_nm pll_audio0_4x_clk =3D {
> > >       .m              =3D _SUNXI_CCU_DIV(16, 6),
> > >       .sdm            =3D _SUNXI_CCU_SDM(pll_audio0_sdm_table, BIT(24=
),
> > >                                        0x178, BIT(31)),
> > > -     .min_rate       =3D 180000000U,
> > > +     .min_rate       =3D 90000000U,
> > >       .max_rate       =3D 3000000000U,
> > >       .common         =3D {
> > >               .reg            =3D 0x078,
> > >
> >
> >
> >
> >
>=20





