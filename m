Return-Path: <dmaengine+bounces-392-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 369B1806ABD
	for <lists+dmaengine@lfdr.de>; Wed,  6 Dec 2023 10:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D961F21194
	for <lists+dmaengine@lfdr.de>; Wed,  6 Dec 2023 09:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50071A5BF;
	Wed,  6 Dec 2023 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrRc5h8B"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632ABA4;
	Wed,  6 Dec 2023 01:32:24 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-6ce6d926f76so508024b3a.1;
        Wed, 06 Dec 2023 01:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701855144; x=1702459944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLmPofgWOpu3C4jj3H2nG/YpvFLIZNIe7xgeFG2pVlQ=;
        b=nrRc5h8BzyP24yAiq/bNluHSMe3Kv8VdUTj1dusGF6F3vcgXujY5NYmhhVPruA8HRu
         GfNU9PTm6QObEYvDVrmMgp8AWWUB2To2EYucaHJSKnvZga5v2kRpcsqUU/rwFPqDMyaq
         FUOw4k/SO+8UOVsvQNvzbqYgA6b5su2Bdz6T/Hdr0VJSpWZzulUayxzSYYv9PgPafH+H
         hiavbm30yp2TUosqMPWdqaJtQY8W1pj9Ssvs8vd/1lf4ibPQ7+ssoX9IQQ1KZeq3eIkE
         oqg0Qkd0DlYJjZ+VhxF4Dy6oXBc7JfmYST6ODP9xf5Y5p3vF/aCw/5KmGHEOKJUaxz2h
         R9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701855144; x=1702459944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLmPofgWOpu3C4jj3H2nG/YpvFLIZNIe7xgeFG2pVlQ=;
        b=vIzcpWs0tjE8M6bOdHZqzcdZAG+orbwWEGM8345O9i78jUq1y0N1jqCrTW4c6mn8aO
         M3EnLFPcE5ckJqgtz3U9g+HLFnXbRdPW37GXvrY8jlyhaZuN+se37UH05Y/IQXKKOgIM
         aG/D6JqA3pd0KFR2dq3dCeN6issfPqeX/5ntWXpqPDauaUmlzrb41NVbwwsHTj3jzIAN
         YMtJdfgJULOoZkLHf2bjSnmZKwSYtcet1+Z45lcBsdtrZGx6sSzs3diEEc/PGj4IN+wB
         40cuPdCyX6dynYvEV1ExD+pe6YHTfmB+lwLiMxuyn83SpLcHzj3HCYqAoc6BwnLn+np9
         PdUA==
X-Gm-Message-State: AOJu0YxpcdfQ1IU3F+JsbybXVZ/W7/Gdzln5oreyw7qZ/pfjzyN5dKgu
	obTTQY+EzoPr8NWQ6v3G85mL86K7cdV21/1PNak=
X-Google-Smtp-Source: AGHT+IEPQ3KFPasE8HpV5QWHJngXsaB3BoK3YhCzFQvPWEbqrOJpVeDej+DuCiWVYV6j3tET406Fag/SJZwJSzFve/M=
X-Received: by 2002:a05:6a20:261d:b0:187:29f9:e12e with SMTP id
 i29-20020a056a20261d00b0018729f9e12emr729597pze.29.1701855143759; Wed, 06 Dec
 2023 01:32:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102121623.31924-1-kaiwei.liu@unisoc.com> <ZWCg9hmfvexyn7xK@matsya>
In-Reply-To: <ZWCg9hmfvexyn7xK@matsya>
From: liu kaiwei <liukaiwei086@gmail.com>
Date: Wed, 6 Dec 2023 17:32:12 +0800
Message-ID: <CAOgAA6FzZ4q=rdmh8ySJRhojkGCgyV4PVjT6JAOUix+CF9PFtw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dmaengine: sprd: delete enable opreation in probe
To: Vinod Koul <vkoul@kernel.org>
Cc: Kaiwei Liu <kaiwei.liu@unisoc.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wenming Wu <wenming.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 9:11=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wrote=
:
>
> On 02-11-23, 20:16, Kaiwei Liu wrote:
> > From: "kaiwei.liu" <kaiwei.liu@unisoc.com>
>
> Typo is subject line
>
> >
> > In the probe of dma, it will allocate device memory and do some
> > initalization settings. All operations are only at the software
> > level and don't need the DMA hardware power on. It doesn't need
> > to resume the device and set the device active as well. here
> > delete unnecessary operation.
>
> Don't you need to read or write to the device? Without enable that wont
> work right?
>

Yes, it doesn't need to read or write to the device in the probe of DMA.
We will enable the DMA when allocating the DMA channel.

> Lastly patches appear disjoint, pls thread them properly
>
> >
> > Signed-off-by: kaiwei.liu <kaiwei.liu@unisoc.com>
> > ---
> >  drivers/dma/sprd-dma.c | 19 ++-----------------
> >  1 file changed, 2 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> > index 08fcf1ec368c..8ab5a9082fc5 100644
> > --- a/drivers/dma/sprd-dma.c
> > +++ b/drivers/dma/sprd-dma.c
> > @@ -1203,21 +1203,11 @@ static int sprd_dma_probe(struct platform_devic=
e *pdev)
> >       }
> >
> >       platform_set_drvdata(pdev, sdev);
> > -     ret =3D sprd_dma_enable(sdev);
> > -     if (ret)
> > -             return ret;
> > -
> > -     pm_runtime_set_active(&pdev->dev);
> > -     pm_runtime_enable(&pdev->dev);
> > -
> > -     ret =3D pm_runtime_get_sync(&pdev->dev);
> > -     if (ret < 0)
> > -             goto err_rpm;
> >
> >       ret =3D dma_async_device_register(&sdev->dma_dev);
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "register dma device failed:%d\n", re=
t);
> > -             goto err_register;
> > +             return ret;
> >       }
> >
> >       sprd_dma_info.dma_cap =3D sdev->dma_dev.cap_mask;
> > @@ -1226,16 +1216,11 @@ static int sprd_dma_probe(struct platform_devic=
e *pdev)
> >       if (ret)
> >               goto err_of_register;
> >
> > -     pm_runtime_put(&pdev->dev);
> > +     pm_runtime_enable(&pdev->dev);
> >       return 0;
> >
> >  err_of_register:
> >       dma_async_device_unregister(&sdev->dma_dev);
> > -err_register:
> > -     pm_runtime_put_noidle(&pdev->dev);
> > -     pm_runtime_disable(&pdev->dev);
> > -err_rpm:
> > -     sprd_dma_disable(sdev);
> >       return ret;
> >  }
> >
> > --
> > 2.17.1
>
> --
> ~Vinod

