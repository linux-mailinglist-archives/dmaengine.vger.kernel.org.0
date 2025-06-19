Return-Path: <dmaengine+bounces-5536-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19366ADFB3C
	for <lists+dmaengine@lfdr.de>; Thu, 19 Jun 2025 04:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38DD172ED4
	for <lists+dmaengine@lfdr.de>; Thu, 19 Jun 2025 02:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F67C220F28;
	Thu, 19 Jun 2025 02:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="HyPCgF1R"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7869A1FF1B5
	for <dmaengine@vger.kernel.org>; Thu, 19 Jun 2025 02:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750300169; cv=none; b=Tsk+EJtXyrivF/sXxpEGbrQ1cJPuuf3CZ5efM2GTsTwwOQb5SeeenJ+pq/lkRykJGZjs/Jvsb+/fz1ccVq5SEwclNmw2XJ5XNWZykWDVnHIjoZIlJkAflgoWlBeMzmXj/rQxPSttmj6ZfN7Ll9pVCeGs4ZSxDk4JQ3BiEYC0Wng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750300169; c=relaxed/simple;
	bh=L2w4QtkDjTcxS3Jiw42nicI67aVG96GPyXoun25RMB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QF7VN1vTM5KtEvnQFUATfjjkAsJgb9x4GNxzt/Z0fkCRwUpptq4Oi8uoxQ/n7SbqRViDTTBRg9KhE+rQIsJdkMM33fhq1USB44LBJ8o3T2dCC60zhwVRNxovtCDoqjzLRWppgqNdCp6TnC+DT+E5UATRJIDlCsBYjP+3TBopDgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=HyPCgF1R; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71173646662so3491447b3.2
        for <dmaengine@vger.kernel.org>; Wed, 18 Jun 2025 19:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1750300166; x=1750904966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDeHL9d8vuK42id4GVmvojG1LbxVd4OxULlS/3TaFoo=;
        b=HyPCgF1RyBNpndkOPPsNC8GhgjEKKSrkzQREGgxvK2MOjk/8YVnE+Lu8kZHhnuQAMF
         /7g0JoZjbl5FLQNiraieYZxQlBfABokjIHlH4C4QNAxTIY4xgP4xOwFpul1o+CtiOL9H
         mAnbJj/kSIPvuadDEiAfpd3P16N810BiZHqX14taSWi58YCR7JaiisLCxodghYl9OpNH
         LRnSGWBo+CmhcSVA7Fw7O1ooZpgPEP/DDJezDZtaZleODYOVEAS5j1jQqa0NOCXxGrK0
         1K75F1v/ngHtUJ2IdGXlA4mbV9LjkTSvPEpr/1x+dnGEIGh4ANf9mrIlxP5UTmmD+xnN
         HeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750300166; x=1750904966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDeHL9d8vuK42id4GVmvojG1LbxVd4OxULlS/3TaFoo=;
        b=X95HSoTnnx9vvLR5ljILf8TaTxrSBPOwBeKnMyp/PYFFeZuBz+joZHShdlDMfJuVHh
         V11HpkyzyaIksBkbUnl+bgWKZrXiy6mdalo2BnaW7Fky4yPklkTfQfJVNioksmJzwIlW
         n2wOJbpqdbxRV+3hGWcOPj1/HIme9vSaX17cBxGncAj0/ZLRmJbW85Z692KcIpeRd9Qo
         Nz5VLV1rJURip96p5rSQISvoE8S3adxRO0CF2V8xBs5IEkHrENPjNvsJmKRvn6AbX2I9
         jzYMFELlbiLaRf7LY5G68rDZRKjJVL1EDME56eakY9nmB4LUAQGVdbRRmN85nwt8GDW5
         6MTA==
X-Forwarded-Encrypted: i=1; AJvYcCVR5DwyCJsPBZ7HNxHl7+VWw19Yo/Z6DyDOQ12RVOGJHN/qki8G2//gb8U+p+QS8jeaeDTov7jUom0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRQ4sk6v6ZU3osz3oJvsEBHzdDXlPyNBuY6/F65hP6FPYi7zMW
	47GNzCDnJcnjMdUGC3w43ISZdr1AeHIJ7YrCnzOuC88y4HkrSsBCPZCH7wFW2UHsBKqGKeyYBaO
	YOQ8klBK0ArsdaP45XPNCu7hgYfp355tTOyaGfUPkKQ==
X-Gm-Gg: ASbGncvxHyTLbxzMnunPMMvEHVjdKyyTfPy7UmqmOUqVR/qhrwGTGQ00ROJVr/M8mK3
	hlCVOxLGU63+yfIuisaBewz9oewAUqSBJ6i30fPZbqKN6bifWAa4qftfz+56IWBTfCZPco5QA0R
	W5QEROP+GwaWDzqQkyyPFxOaW4o7QeQ/ydVVfvHpgMyg==
X-Google-Smtp-Source: AGHT+IGTWcMJ9e18SuuZAjhMb+1RhUC5KbFMVpAzHRzN1h0rYVrbKTgujtHTi15citzRIXK4WE/50371Bg3VPce6S3o=
X-Received: by 2002:a05:690c:4442:b0:70e:29af:844a with SMTP id
 00721157ae682-711755076b4mr289656047b3.18.1750300166249; Wed, 18 Jun 2025
 19:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611125723.181711-1-guodong@riscstar.com> <20250611125723.181711-3-guodong@riscstar.com>
 <aFEEhik8x2k5_myN@vaman>
In-Reply-To: <aFEEhik8x2k5_myN@vaman>
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 19 Jun 2025 10:29:14 +0800
X-Gm-Features: AX0GCFsoo3SDAFCWa_VQKJiemtWkvUSERAjA5vBX4NjZ4H9AqhsVRRlcUwFSJ3A
Message-ID: <CAH1PCMaD1muAQWRUfDJNKZL+-y31MBbw=aeD8VgEGxJE3eATbA@mail.gmail.com>
Subject: Re: [PATCH 2/8] dma: mmp_pdma: Add optional clock support
To: Vinod Koul <vkoul@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, dlan@gentoo.org, 
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

On Tue, Jun 17, 2025 at 2:00=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wrote=
:
>
> On 11-06-25, 20:57, Guodong Xu wrote:
> > Add support for retrieving and enabling an optional clock using
> > devm_clk_get_optional_enabled() during mmp_pdma_probe().
>
> Its dmaengine, please tag them as such

Got it. I will do.

Thank you, Vinod.


>
> >
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > ---
> >  drivers/dma/mmp_pdma.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
> > index a95d31103d30..4a6dbf558237 100644
> > --- a/drivers/dma/mmp_pdma.c
> > +++ b/drivers/dma/mmp_pdma.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/device.h>
> >  #include <linux/platform_data/mmp_dma.h>
> >  #include <linux/dmapool.h>
> > +#include <linux/clk.h>
> >  #include <linux/of_dma.h>
> >  #include <linux/of.h>
> >
> > @@ -1019,6 +1020,7 @@ static int mmp_pdma_probe(struct platform_device =
*op)
> >  {
> >       struct mmp_pdma_device *pdev;
> >       struct mmp_dma_platdata *pdata =3D dev_get_platdata(&op->dev);
> > +     struct clk *clk;
> >       int i, ret, irq =3D 0;
> >       int dma_channels =3D 0, irq_num =3D 0;
> >       const enum dma_slave_buswidth widths =3D
> > @@ -1037,6 +1039,10 @@ static int mmp_pdma_probe(struct platform_device=
 *op)
> >       if (IS_ERR(pdev->base))
> >               return PTR_ERR(pdev->base);
> >
> > +     clk =3D devm_clk_get_optional_enabled(pdev->dev, NULL);
> > +     if (IS_ERR(clk))
> > +             return PTR_ERR(clk);
> > +
> >       if (pdev->dev->of_node) {
> >               /* Parse new and deprecated dma-channels properties */
> >               if (of_property_read_u32(pdev->dev->of_node, "dma-channel=
s",
> > --
> > 2.43.0
>
> --
> ~Vinod

