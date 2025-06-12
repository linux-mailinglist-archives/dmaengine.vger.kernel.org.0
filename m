Return-Path: <dmaengine+bounces-5387-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0507AAD6541
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 03:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DEAA3AC345
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 01:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4BF183CA6;
	Thu, 12 Jun 2025 01:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="BhMijZCI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8D6101DE
	for <dmaengine@vger.kernel.org>; Thu, 12 Jun 2025 01:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749692953; cv=none; b=lIgjDx8lcmv+es4WVCkBaQu/Xku0MSIAqf+68FKQBgItddAoidr/+Tj5hRCJGFoJYK5huZUM1hqifHxYzozwd0GxicYi7xI+EC52fwEhnMX1unWQfEZiXfah7LG8jLEowSCACz4j1+DflRoFZgOwHKuH65lyldyfl4YP9B3J3wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749692953; c=relaxed/simple;
	bh=5kLQjd6AzdXVJDSfbwMG/b2U5PBjG3cD+vDIQsbcSVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQ4rqq4VXlUGrdbTP/z/qoebE3I7AsndYDD5y62yZNPuN8+fDDkm7KgYcO4U8qQoU9jAVC4JUcrA6CkI8mxr6PuafMtZlFRnnwp/qa/z3poFgMMtkMEI9FB8n/zqYh8KnkxKi2vaEwNTy/Zo822FdS94S5aXo2LLcXMhpviUpbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=BhMijZCI; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so1050021a12.3
        for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 18:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1749692949; x=1750297749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeRmmiJk7dyHe2xsIaa6eDpe9k71PqYl6SPvF++88pc=;
        b=BhMijZCIFsjYlP2XfI9qeRSoH2IRv9YsOO5d/GWi+T5JivdH1k63GlbB7MVlJwRMwE
         /lvjLqYnL7FuGKhq5D4XtvANXd19ZunmqLq25AjcT4gysaF20MDkzQyEJmgqySCLYzAj
         iMiwSQR+YclDCAix6rW2d0W43Gze2KG0Cjg3/nbI+Fxq8tbS/VQRiDNYwfDWpGZMAJC1
         FUCQtnwnJ7DdPKhw4CMIT6NOpVyzE83/QZLuyE93zrwATvu7NGWXNC1yKqHY+9uzMt6I
         NtMWE5j5lu+UkPtudTvm6JBwPTEdaBimg3Khun3dLhdzFquHZOIcQGvyZGI5ICg6o9kC
         nphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749692949; x=1750297749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeRmmiJk7dyHe2xsIaa6eDpe9k71PqYl6SPvF++88pc=;
        b=d/YjVtkRUTg6N6ajaqF+K2eQr2+mv6i0XuE0pBcAg23vCaoIJi9fNHray0bpiKxFjZ
         ZZ2eqKaJN7ACJ6QlFON6P8Z7536aRLThVbvUTHjqV+ebWrm5Gvj58l6/bc/JfsCIK24v
         KAsraZtJX3ZEvBl/MzNE86fFfy0EEWZESzBmEnwVqT8Fr1hfcNGPuWVfBnNRXPdzN8Co
         RRk5WUjWARgjI3GYNn5TWoefuIvfTnFLwplPvI0eui6hZgbWz5EIO9iIWqQ4H4JpjUiM
         B3HQoj/fps//T45TtvjKrEMVt54bJhlYaRvHcTR6clm21E7rhHbBBt2wsxZ6tyJmMPnP
         0prQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZvFFIZQBmD53HTwG+Eeiys7CLf6YacIgnBr9xQv46MFi4THHC8RAqGBQT1NXIxGqCVzdtGULeHaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoMASSAsO43VS1QeOwOkASynYjz8D4UEAwALGNOGnQbWoAy8TW
	nkKRwK+V17D8Wxmu6xRHAOkMKZBPqA5XpUYdN3AeWllkMEB1uqoLhFLAwH8Bv9KlBJ6XAytZ+pp
	vBKWShG1i985AVJKZomRZ4SAucLBY/jltBaoamM6HvQ==
X-Gm-Gg: ASbGncsOt1LqRKuX7AfdymD+bgNxCXJaDKtnWmCm4SbHmGLmOCCWakaeCY/CmGjMMg1
	Tn3FfrlncoKyLYV/HiYwccmixlrCAEyFqG8KG3ri/AkwA4pIqlBvHbXjhOJ2ViTpvjuAUzGYALj
	G35iD0bY4JuAE6bRy+F8VHwBNB15yw+cE8Rq93QK131sexfVVbT5ZS9Cc=
X-Google-Smtp-Source: AGHT+IFqEcHJsmVoMqXHHPFn7yHeR1oDGdJeaYWXWqBT/PegqYwsZ5z0ffozW4eWFgBnqvaTPT/vq7D0XhuX7E2hMC8=
X-Received: by 2002:a17:907:1c19:b0:ade:2c48:1ba7 with SMTP id
 a640c23a62f3a-adea9a57710mr122939966b.55.1749692949426; Wed, 11 Jun 2025
 18:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611125723.181711-1-guodong@riscstar.com> <20250611125723.181711-2-guodong@riscstar.com>
 <20250611-kabob-unmindful-3b1e9728e77d@spud> <20250612000354-GYA127864@gentoo>
In-Reply-To: <20250612000354-GYA127864@gentoo>
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 12 Jun 2025 09:48:55 +0800
X-Gm-Features: AX0GCFvb3rY5RbOdj--6bI5I0CRQw5-xjkK6pB9t5n94l_np5ZJaDhu5M4gwDF4
Message-ID: <CAH1PCMbZRhrrKy0TV7D9_nOKkPNuX7gXyyxtzhf_q7vcfhBB_Q@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: dma: marvell,mmp-dma: Add SpacemiT PDMA compatibility
To: Yixun Lan <dlan@gentoo.org>
Cc: Conor Dooley <conor@kernel.org>, vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de, drew@pdp7.com, 
	emil.renner.berthing@canonical.com, inochiama@gmail.com, 
	geert+renesas@glider.be, tglx@linutronix.de, hal.feng@starfivetech.com, 
	joel@jms.id.au, duje.mihanovic@skole.hr, elder@riscstar.com, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 8:03=E2=80=AFAM Yixun Lan <dlan@gentoo.org> wrote:
>
> On 17:27 Wed 11 Jun     , Conor Dooley wrote:
> > On Wed, Jun 11, 2025 at 08:57:16PM +0800, Guodong Xu wrote:
> > > Add "spacemit,pdma-1.0" compatible string to support SpacemiT PDMA
> > > controller in the Marvell MMP DMA device tree bindings. This enables:
> > >
> > > - Support for SpacemiT PDMA controller configuration
> > > - New optional properties for platform-specific integration:
> > >   * clocks: Clock controller for the DMA
> > >   * resets: Reset controller for the DMA
> > >
> > > Also, add explicit #dma-cells property definition to avoid
> > > "make dtbs_check W=3D3" warnings about unevaluated properties.
> > >
> > > The #dma-cells property is defined as 2 cells to maintain compatibili=
ty
> > > with existing ARM device trees. The first cell specifies the DMA requ=
est
> > > line number, while the second cell is currently unused by the driver =
but
> > > required for backward compatibility with PXA device tree files.
> > >
> > > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > > ---
> > >  .../bindings/dma/marvell,mmp-dma.yaml           | 17 +++++++++++++++=
++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/dma/marvell,mmp-dma.ya=
ml b/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml
> > > index d447d5207be0..e117a81414bd 100644
> > > --- a/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml
> > > +++ b/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml
> > > @@ -18,6 +18,7 @@ properties:
> > >        - marvell,pdma-1.0
> > >        - marvell,adma-1.0
> > >        - marvell,pxa910-squ
> > > +      - spacemit,pdma-1.0
> >
> > You need a soc-specific compatible here.
> >
> is the version number (1.0 here) actually documented anywhere?
>
> otherwise I'd suggest using "spacemit,k1-pdma" which follow the conventio=
n
> which already done for spacemit in other components..
>

Thanks Conor and Yixun. I will take this compatible string
"spacemit,k1-pdma".

-Guodong

> --
> Yixun Lan (dlan)

