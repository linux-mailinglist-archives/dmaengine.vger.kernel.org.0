Return-Path: <dmaengine+bounces-5368-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9AEAD58D4
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 16:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC6816A4D7
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 14:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4112874EB;
	Wed, 11 Jun 2025 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="tUgAHisK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB9028313A
	for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652363; cv=none; b=Ip6OOhuo675RVQRrHG/lNto1soTwjmX4A90bSGirDZDRcCky/LXcyjUv8b281cxST7ugQ8prj6OsVvpEksZiDfgY4oJmBS7Vh+rqUm6oKjWdO1ADTpANETdqZPTyxcuZoxvRTU7Pv2NxDU9yTZOiM78d5aT5EKZpFnx41nOopNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652363; c=relaxed/simple;
	bh=LIJKwYSQIfaGc2pHLi1K+zxTkENHkvAhCuTT19zf1Cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipD9u+36mFzk5PmI7AEpKbhHr70S47JXkvEC7khVN0kbD7hUN8+5HyJ+7r+9NQexY+AXEn7c43uIujr5LKkllQCYob9zkC+eMzsKib1cKxNCC+ZgiAuK2VhVqWlYtJ/xpe08cAsM32qoN2aAxSwbXG4dFwPDSHYGCyx1oM/a8NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=tUgAHisK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ade48b24c97so656698366b.2
        for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 07:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1749652360; x=1750257160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60kjyrVoPLH2Ifa+97Mi20o2GvNQ5P+ZX0EZmjkoYqM=;
        b=tUgAHisKiRkEnrM13+qfPjcfwWKF7MghM4GgRFvbWUnqysEyk6XZcs0AkDABqKPpGU
         V/Ccpsi99HacuKGKeBGHEs6VaeKhX0+jDSyJ2MhSVa6hJLbssEXsbOXSaPYgu4tQijWT
         NXzbTPWPoeEoYTY62p7dvsWuGvI3VJuZLkgngKii8zR2Y8Qbb0qvI6Bb6+vtR+ePQdjl
         BNmhPAuaKoxbm8/ceJ0tWiYD6T6J6xrMyoz/iR5w08zEjyjrD6bivZshFmzxuvREYIOQ
         PJWbrID9ZnZtCSIV/wleNEufIvaeWaSUEKENLopO/UDUj7hZjgxCuqvGkiyICgnUCSv9
         XmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749652360; x=1750257160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60kjyrVoPLH2Ifa+97Mi20o2GvNQ5P+ZX0EZmjkoYqM=;
        b=nLTNj9GaqB7A95V7I1oqo4sNV7NX1lN5JlETJG832eTNUIWQkLD3/usTmzlHfokWQ4
         IYowurCWdgAQCV3nLGgBUmbfAIe1dp63rr1gVuMfGoNmWpFREBrfkWi5gKLx7INPNsTn
         FwPFhRwPoBLcB5fMRSaBEMs0Oa1OpVBW+NDogsXIJSkACRoBQ9QRDfWi55uDl0+oCEIG
         M9lwxyF9ZY3CcNmhWYb3wP9jAHDF6dhaxkJFbhQ+YHUbbVtadrUA8OeXmWWYPH6gnA3m
         2K8f4QHAH4q8lMONTfcs6xS71RSUow8V4+yRkx4pnrLcYIHMys5ezo68k0EHfVevkcOe
         Ritw==
X-Forwarded-Encrypted: i=1; AJvYcCW57LrtLgH5dc529SwmsFmOTUCA1TKjjNY2hn/jmmXwa63w3KVK5lgMLrYB0fNExvb7ikHWTWq27cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/CGaphp3Q2oX2bzXxUjr1vkpY6w2nLcMiqo4vjzCECPKM+sbc
	N+14FJukweSg+lThb7bJsneJWQT/JPvGLv96dtXqA8BF3A2toy4yueNxBf7462NjpMd0Rn3ZN4W
	fAbPLyAbx4CDNLvGdVowrsB+AFZkMrnHBenaOkuvOHw==
X-Gm-Gg: ASbGncvwNW7NDJhRtQAA059nUinJajHv7djRqswwjmgfytZfW/n9KF0C5axDRRv4gfI
	vVnY+zf38u8KXTj96umQJijp2pAd7HVr3yv6tXzzOoevR3yoGX8YM51hTiL2JI1ofACbHPp+gA9
	dBPEWBREzhBNoswN5P1U/RqB5cwmhHTGKpARdISsuCwanU
X-Google-Smtp-Source: AGHT+IEzETwYHx0nLbiFdWUeLmV4KrW57JrGro1I3zlSg5jafQBDwMDY2f+YekL/HJyWs+OOnv2PB4JAvv0sXW+xiFM=
X-Received: by 2002:a17:907:3e1b:b0:ad2:4fa0:88cd with SMTP id
 a640c23a62f3a-ade893e3192mr285970566b.9.1749652359722; Wed, 11 Jun 2025
 07:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611125723.181711-1-guodong@riscstar.com> <20250611125723.181711-7-guodong@riscstar.com>
 <20250611135757-GYC125008@gentoo>
In-Reply-To: <20250611135757-GYC125008@gentoo>
From: Guodong Xu <guodong@riscstar.com>
Date: Wed, 11 Jun 2025 22:32:27 +0800
X-Gm-Features: AX0GCFsCOSkDRyqL6Nxt48HaUVxbrrOp5EdO9-GyXjMkq6GZqJ07_JcYpuCfhG4
Message-ID: <CAH1PCMbt3wLbeomQ+kgR6yZZ18TZ=_LF-kCcnLqad55FSHBhDA@mail.gmail.com>
Subject: Re: [PATCH 6/8] riscv: dts: spacemit: Enable PDMA0 controller on
 Banana Pi F3
To: Yixun Lan <dlan@gentoo.org>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, p.zabel@pengutronix.de, drew@pdp7.com, 
	emil.renner.berthing@canonical.com, inochiama@gmail.com, 
	geert+renesas@glider.be, tglx@linutronix.de, hal.feng@starfivetech.com, 
	joel@jms.id.au, duje.mihanovic@skole.hr, elder@riscstar.com, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 9:58=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:
>
> Hi Guodong,
>
> On 20:57 Wed 11 Jun     , Guodong Xu wrote:
> > Enable the Peripheral DMA controller (PDMA0) on the SpacemiT K1-based
> > Banana Pi F3 board by setting its status to "okay". This board-specific
> > configuration activates the PDMA controller defined in the SoC's base
> > device tree.
> >
>   Although this series is actively developed under Bananapi-f3 board
> but it should work fine with jupiter board, so I'd suggest to enable
> it too, thanks
>

I'd be glad to include the Jupiter board as well. Since I don't have Jupite=
r
hardware for testing, could someone with access verify it works before I
add it to the series?

-Guodong

> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > ---
> >  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/ris=
cv/boot/dts/spacemit/k1-bananapi-f3.dts
> > index 2363f0e65724..115222c065ab 100644
> > --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > @@ -45,3 +45,7 @@ &uart0 {
> >       pinctrl-0 =3D <&uart0_2_cfg>;
> >       status =3D "okay";
> >  };
> > +
> > +&pdma0 {
> > +     status =3D "okay";
> > +};
> > --
> > 2.43.0
> >
> >
>
> --
> Yixun Lan (dlan)

