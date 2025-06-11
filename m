Return-Path: <dmaengine+bounces-5369-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2857AAD5916
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 16:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8ABC7A3A40
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 14:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763DF2BDC21;
	Wed, 11 Jun 2025 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ymlLGxnM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D342BD5B1
	for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652843; cv=none; b=ICZAWUOS1v8bzXwd3ComJjcjnli4HT1rVGreZ/T7k8G4lH0m4UeS7HCHfigKiPAu1/BYMHLPtP1B3k2Gu8KMJ7H+PQzJbag4rTTbvDjJT7uSG0oSsg7iQYWdRMZR0as0uXtZvj9Ya01A97qqxkSjHE+5AQ7NHr6I55nM5jbM1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652843; c=relaxed/simple;
	bh=Ves9IAlDOG6rT2wK3GTXUgHQbJsl7xwyic6gvh9n1D8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlfmF1SU2dnBcibc77OxuceeYMDbXtLlkAPWj0k3K90M7iPF/2BpUbeKe3bv0boO4lk10VWmdTehvXVgmWSDxYHUMfAVvod/yD9DV1mzHzJ+Bzej/RmGoP4sa+Ef5m0jPDKFK3V87sQ9XYSyobwZGfzdmPICCTH//nqSsb85r0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ymlLGxnM; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-addda47ebeaso1294713266b.1
        for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 07:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1749652839; x=1750257639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VanCGAV853jeZl/piu55b8cOeQ1lh3SiVReRL2SvGyU=;
        b=ymlLGxnMsVfiy/aok9AEqGYJFidNS+mNhQrefas1XlXonhcN7fIoSVeXXSYu4Ggi/6
         u1bedUuR9OXXmTBMrxtLE5IAqMZlo7ZsLjcm5ewCbfGGthkDcATGwEFuKRAlccvrEMFo
         yM1iKcqmFlwZLovjnbb1k2pIELqp9nwM1H3jyTuGwcbX2ZvCJoIbZ23yPMhn6VXIY8ja
         y+XI5/WAd5QSserPAWxtNaylQ/VZwNUljHQbAtXo8kpVfQOM9iNQeDKdvHlWQIYvtjRR
         EtZTGiPExK5QgjbQrIxpSyFmMLRn5bsoUvoA8YtJ2jlcFqCQoDRyJmaAW57HCnZLJUy4
         TSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749652839; x=1750257639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VanCGAV853jeZl/piu55b8cOeQ1lh3SiVReRL2SvGyU=;
        b=SVQRppXR9hGxTuDvMBJ1o9049teVU3skm9M5OQqC4mk/MhJG/c9Rf/gddbwWFqwMGY
         eIhQ1wq84FG76dacd8iXmZ2Kd5fKv2wThYsQbhVTpZ2QM7jps5DofRse4odVC/R81VY2
         VMyb30L8whWi4UPTPm0PE6GuJaNYHvGMvJ/Il0Oy2u9n8uTeaPzW1cOX1kLM2nRRkuNJ
         HAS0wVHKthG3u0Bp2IQVeZcElCYkusCGGQXUHewiRVgwLOgva5m88ATGKEWZzCLnIJzq
         AQ1w80iRyGZ1PN0S9bPulD2QBCxVc7jVHxYM9bSr5hFhM+FlSe5BXT29KV5BtByoEPhH
         yR+A==
X-Forwarded-Encrypted: i=1; AJvYcCX5yHDKW0iGVx2zIbxmJxouRup/dEIu8s6XFcbktze4fN5ZZw1KlKUfDMngRAUDdH3uECU8HSN6Gkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw++we2U9pr12beslAYZEdpcK+hueacu4JaZchH4B/3/eGNyZRl
	xXg0DtSnCV0CWDN+X9VL5p4U/lcTUtP358HHpHlYZ6eDZJFCjFsQUwZpgX9vf7kjKgVxmfZpUJi
	retny2s/G08OmX1XFYiim7eEoO4GgsNlpHGmI2mJPdg==
X-Gm-Gg: ASbGncvh6J5Zh03OqqF1ZQv8W7avntfhSCGfEc+fvsPOGLSOle7bZPJyXgC0BatuM/V
	2lqdKVyj/aPJYm6dgY3u1oSb5HDzcWtMBpRIkhQIJsPIBwMvcGWbEw+/CEqKlXnnrNFuiXZgrfe
	HDqTH+CDyNbagIPkzooYMRlRqPPk87Rd6B9BrdEWxABOSJ
X-Google-Smtp-Source: AGHT+IHDSmTZDyiDRZOD1n1VEoO2BN/q5+1t3d32dZUsxmTdSpg0xwKQkFHQYBpUpsmp4CIhNRKBUUObLCw4k1Y89D8=
X-Received: by 2002:a17:907:968a:b0:adb:1804:db93 with SMTP id
 a640c23a62f3a-ade8c8eff15mr309077666b.49.1749652839519; Wed, 11 Jun 2025
 07:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611125723.181711-1-guodong@riscstar.com> <20250611125723.181711-8-guodong@riscstar.com>
 <20250611135116-GYB125008@gentoo>
In-Reply-To: <20250611135116-GYB125008@gentoo>
From: Guodong Xu <guodong@riscstar.com>
Date: Wed, 11 Jun 2025 22:40:28 +0800
X-Gm-Features: AX0GCFtLP8n8AGHV29EjK0zTceQ99c8B_7Z1bY9fkoSHAd2Q1BdFWQkZ6Pv-a54
Message-ID: <CAH1PCMbP54PRq27p7Ss+cdvB86M8k3CQepzxJwfpwfJPPnrMag@mail.gmail.com>
Subject: Re: [PATCH 7/8] dma: Kconfig: MMP_PDMA: Add support for ARCH_SPACEMIT
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

On Wed, Jun 11, 2025 at 9:51=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:
>
> Hi Guodong,
>   I'd suggest moving this patch after 4/8, as both of them should go
> via DMA susbystem tree, or simply squash them?
>

Thanks for your advice. Agree. It makes sense.
I will arrange them.

-Guodong

> On 20:57 Wed 11 Jun     , Guodong Xu wrote:
> > Extend the MMP_PDMA driver to support the SpacemiT architecture
> > by adding ARCH_SPACEMIT as a dependency in Kconfig.
> >
> > This allows the driver to be built for SpacemiT-based platforms
> > alongside existing ARCH_MMP and ARCH_PXA architectures.
> >
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > ---
> >  drivers/dma/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > index db87dd2a07f7..fff70f66c773 100644
> > --- a/drivers/dma/Kconfig
> > +++ b/drivers/dma/Kconfig
> > @@ -451,7 +451,7 @@ config MILBEAUT_XDMAC
> >
> >  config MMP_PDMA
> >       tristate "MMP PDMA support"
> > -     depends on ARCH_MMP || ARCH_PXA || COMPILE_TEST
> > +     depends on ARCH_MMP || ARCH_PXA || ARCH_SPACEMIT || COMPILE_TEST
> >       select DMA_ENGINE
> >       help
> >         Support the MMP PDMA engine for PXA and MMP platform.
> > --
> > 2.43.0
> >
> >
>
> --
> Yixun Lan (dlan)

