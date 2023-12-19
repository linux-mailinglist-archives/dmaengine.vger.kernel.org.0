Return-Path: <dmaengine+bounces-573-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B258180F6
	for <lists+dmaengine@lfdr.de>; Tue, 19 Dec 2023 06:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165D32843A8
	for <lists+dmaengine@lfdr.de>; Tue, 19 Dec 2023 05:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFB2C144;
	Tue, 19 Dec 2023 05:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgRza+71"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0D3C135;
	Tue, 19 Dec 2023 05:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-3bb53e20a43so1118644b6e.1;
        Mon, 18 Dec 2023 21:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702963289; x=1703568089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXTjzEkw8OFrAh4CNOzzIVMOXEqR1EzYUmovt7erKHQ=;
        b=MgRza+71i2NeRIu/XOvCGjjz9jjfDDfOch4D7r2+u0/GoL1A/sq3hyJoqN2jxy0fDK
         CJSkATY/BoIBhQrLp7u88U0FljSyGkFGTHgWdeI4mUqJAzWUEuhMx6dgUFOJgidzKf3C
         sENU86tZPgeKDFnGAC6NAbLlUATwpm0vd9A+ABi4oJo46zbPeA8HG3vQhxmkqy797+a4
         IKPiP0K6I82RaF8EmQIaRr2PlSSCcH7AKPSoWrOzTfebZvusVLVDqtnokRXDno4WlNUl
         cWiO4HDxYpXBKUA6LiUJ15l/icdiq9exvTg3iQIy1k/6DBT2Q/6rxGVYRYFRW8dL6BYT
         Y53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702963289; x=1703568089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXTjzEkw8OFrAh4CNOzzIVMOXEqR1EzYUmovt7erKHQ=;
        b=ObdD+uGSfY17zJm9wz+HBaNez+Nt3x/mzzN2s6LUepARmmDGpMfqHc5TwUsLqPuEO0
         njC1u9KbVW3zJaZWH02aJrCN9NkH1rTRtEDT/ZMRVft2EKUQGZSyM1e8X3AopokLaOL4
         WwADa0zfwprJs3yOBV3EPeTcgmpgxGD1DQUuDC1uXH0+LajExfWbamh4/KvMmOXp4h+1
         usmF5055s9GFi6Uf3McFlDZiuhTShhKIGVmyKNaMID4epw6U6S9SC0rD/JKnztoICPjk
         VmnKzFihCgeDrt6Jq2uJaONSWVr65uqUabNjt/dEOAPm0h5uwgEtP/fwYYJGMK1u97+m
         cE/Q==
X-Gm-Message-State: AOJu0YwsVUXlhdWf1i6Ugiwub3Jq/GU/JuQFnUR2iaYEwLTw7B5d8J3g
	8ivJk7JkbI35mn4boB24ZoNqduKp8wwizFUbmLM=
X-Google-Smtp-Source: AGHT+IExu2UUTVW55XpIzN8CyfhNwIo39L53hSrC8lX1idTempJVLK4Fnu6r1i9cmpAA7/JCYHskXE+IMc6lmh0ds7I=
X-Received: by 2002:a05:6808:3021:b0:3b8:5e9a:b2bd with SMTP id
 ay33-20020a056808302100b003b85e9ab2bdmr22236711oib.15.1702963289456; Mon, 18
 Dec 2023 21:21:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102121623.31924-1-kaiwei.liu@unisoc.com> <ZWCg9hmfvexyn7xK@matsya>
 <CAOgAA6FzZ4q=rdmh8ySJRhojkGCgyV4PVjT6JAOUix+CF9PFtw@mail.gmail.com> <ZXb1RWaFWHVDx1wV@matsya>
In-Reply-To: <ZXb1RWaFWHVDx1wV@matsya>
From: liu kaiwei <liukaiwei086@gmail.com>
Date: Tue, 19 Dec 2023 13:21:18 +0800
Message-ID: <CAOgAA6FJrJ2kVg4hg3sAE_VAG8SyQ4UzKikU+Ofa=N2w0Q4Ghg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dmaengine: sprd: delete enable opreation in probe
To: Vinod Koul <vkoul@kernel.org>
Cc: Kaiwei Liu <kaiwei.liu@unisoc.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wenming Wu <wenming.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 7:41=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wrote=
:
>
> On 06-12-23, 17:32, liu kaiwei wrote:
> > On Fri, Nov 24, 2023 at 9:11=E2=80=AFPM Vinod Koul <vkoul@kernel.org> w=
rote:
> > >
> > > On 02-11-23, 20:16, Kaiwei Liu wrote:
> > > > From: "kaiwei.liu" <kaiwei.liu@unisoc.com>
> > >
> > > Typo is subject line
> > >
> > > >
> > > > In the probe of dma, it will allocate device memory and do some
> > > > initalization settings. All operations are only at the software
> > > > level and don't need the DMA hardware power on. It doesn't need
> > > > to resume the device and set the device active as well. here
> > > > delete unnecessary operation.
> > >
> > > Don't you need to read or write to the device? Without enable that wo=
nt
> > > work right?
> > >
> >
> > Yes, it doesn't need to read or write to the device in the probe of DMA=
.
> > We will enable the DMA when allocating the DMA channel.
>
> So you will probe even if device is not present! I think it makes sense
> to access device registers in probe!

There is another reason why we delete enable/disable and not to access
device in probe. The current driver is applicable to two DMA devices
in different
power domain. For some scenes, one of the domain is power off and when you
probe,  enable the dma with the domain power off may cause crash.

For example, one case is for audio co-processor and DMA serves for it,
DMA's power domain is off during initialization since audio is not used
at that time, so we cannot read/write DMA's register for this kind of cases=
.

@Baolin Wang
Hi baolin=EF=BC=8Cwhat's your opinion?

> --
> ~Vinod

