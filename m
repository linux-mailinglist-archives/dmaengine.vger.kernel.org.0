Return-Path: <dmaengine+bounces-3223-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5169A988101
	for <lists+dmaengine@lfdr.de>; Fri, 27 Sep 2024 11:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729501C208A5
	for <lists+dmaengine@lfdr.de>; Fri, 27 Sep 2024 09:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A646A183CB4;
	Fri, 27 Sep 2024 09:02:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A45178CD9;
	Fri, 27 Sep 2024 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727427720; cv=none; b=QQNL8JbP9guJmr63s0eNNuFNcTDe6JHdhq+3qsrya8gjWaD9JiQzDCAG3xugzns9e4JffWF1cvq0eM/bUX36RzOAG9nHe0t3lQiLXWUb64Eennv2BvvqaNtBxxS1uvJF5Lbd+xchNL8YdMPbiwc4fEt3KGPoTRJjvpFCoVVnaSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727427720; c=relaxed/simple;
	bh=IqkBHRxr7d1fBDVzmvw2gdcNOT/C68E7RcyAI5Sqa7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwf5Yt/kXERbyCy1UjGMvuQ1qBOqSYsa4NYWd0I7uEtawR40OpeCA/4Git0cxxJUB25wBVPrkiJJ0fcaeZDFWVfsVD7CKFka67WhhczhXOo0DVuLoI2bWsbgrwHA7wKjWAdG9rAS/M+8CQL+BUyQtf7/futI0oE/p10n+C0IRC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6dbbe7e51bbso16076267b3.3;
        Fri, 27 Sep 2024 02:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727427716; x=1728032516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYpGlPebM2Nqa2sukOeuZlgj4MxBo1H7Y96fl9yBVfE=;
        b=lJLvVuEVGyPkPMvBt2z/QfIqyhqcICKV/ezG5VQyksZoSSNT9KPHpyju8xULswTiIT
         jqJPO0yPNMx5z0/PchKbmEux6TVM5xfD25Bi+Megajdbln6B4F9gN5bp7bG5bJB6cjtS
         m/WENyllmlWfwSSTIaZpqHBez6LpK5ugPW6KodbM490Msqwz3mxUAnqfDblnPKcI9EmF
         2UQV4UXamqYj1XgSBhN+hcAXPgv6jb7tYTjjurhSgCVxdhzQBBTw2dvx0L0QVZefsmjC
         lOQgVNrTFG/8lFysnyfjL+Kf5G4bVDnG+DynTtyDpIasC7+gW5XMJURPXIW2gcJVpkSK
         h3qg==
X-Forwarded-Encrypted: i=1; AJvYcCU84HI49b4HfIkTRU758j+yTWrkM3ZICtsoIUchkAhIcWR2LkfLsIfWiDIfo4jCFVwppwo3G4mOnMfj+lhH@vger.kernel.org, AJvYcCUbDhg0NJ9xgNYFB2F2ApOxWe3AqbNyrom6xK3TGzOVHoxwfrt6ZerwSYu5q3WRU36dvaqEMTVgxbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvz412U7dd18NbWAJXC1NY4e4LP89fBwZErpAF9pVliQvZfqgG
	E5oOhsFKsDDpLfuoeZBV99limxn3UDQzkoc3h6tnQGV2y9osBLmen9dbz+Ki
X-Google-Smtp-Source: AGHT+IFZ+5aPs8sH2R+9V8w8GVDpa1UFFcbtEEy7SkaF14w1Od5x4dq+ixTnuHQFY7qdZcpkvGARGg==
X-Received: by 2002:a05:690c:fd1:b0:6db:e52f:69f4 with SMTP id 00721157ae682-6e24757f28bmr16389447b3.20.1727427716464;
        Fri, 27 Sep 2024 02:01:56 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e24548f81fsm2465387b3.129.2024.09.27.02.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 02:01:56 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6de15eefdd3so17058197b3.0;
        Fri, 27 Sep 2024 02:01:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNi6vP/wfx502fY6EU1UOhLhGMhEk+sWz+e01Kav7O+H+ty5bms2/o480aFXMVVAnbDRxF0FsSN/s=@vger.kernel.org, AJvYcCWNYmDJW+WSHE1rWv2BRnjmsQsDOZAGW4r/SOfaRjv4Yh8lCMF05mTjpvLFfrbo84U4LgLsyxrYstTXhl/H@vger.kernel.org
X-Received: by 2002:a05:690c:638a:b0:6b1:3bf8:c161 with SMTP id
 00721157ae682-6e247544fa8mr19544927b3.13.1727427715792; Fri, 27 Sep 2024
 02:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1713462643-11781-1-git-send-email-lizhi.hou@amd.com>
 <1713462643-11781-2-git-send-email-lizhi.hou@amd.com> <CAMuHMdXVoTx8K+Vppt07s06OE6R=4BxoBbgtp1WWkCi8DwqgSA@mail.gmail.com>
 <e2a37bb6-3353-1c2f-3841-d63748756df1@amd.com>
In-Reply-To: <e2a37bb6-3353-1c2f-3841-d63748756df1@amd.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 27 Sep 2024 11:01:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVChqbMLN2vdc4iZ7iZ8+dz07k4pVOM_SfZarHWV93JqQ@mail.gmail.com>
Message-ID: <CAMuHMdVChqbMLN2vdc4iZ7iZ8+dz07k4pVOM_SfZarHWV93JqQ@mail.gmail.com>
Subject: Re: [PATCH V12 1/1] dmaengine: amd: qdma: Add AMD QDMA driver
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: nishad.saraf@amd.com, vkoul@kernel.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nishad Saraf <nishads@amd.com>, sonal.santan@amd.com, 
	max.zhen@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lizhi,

On Tue, Sep 3, 2024 at 6:50=E2=80=AFPM Lizhi Hou <lizhi.hou@amd.com> wrote:
> On 9/3/24 02:20, Geert Uytterhoeven wrote:
> > On Thu, Apr 18, 2024 at 7:51=E2=80=AFPM Lizhi Hou <lizhi.hou@amd.com> w=
rote:
> >> From: Nishad Saraf <nishads@amd.com>
> >>
> >> Adds driver to enable PCIe board which uses AMD QDMA (the Queue-based
> >> Direct Memory Access) subsystem. For example, Xilinx Alveo V70 AI
> >> Accelerator devices.
> >>      https://www.xilinx.com/applications/data-center/v70.html
> >>
> >> The QDMA subsystem is used in conjunction with the PCI Express IP bloc=
k
> >> to provide high performance data transfer between host memory and the
> >> card's DMA subsystem.
> >>
> >>              +-------+       +-------+       +-----------+
> >>     PCIe     |       |       |       |       |           |
> >>     Tx/Rx    |       |       |       |  AXI  |           |
> >>   <=3D=3D=3D=3D=3D=3D=3D>  | PCIE  | <=3D=3D=3D> | QDMA  | <=3D=3D=3D=
=3D>| User Logic|
> >>              |       |       |       |       |           |
> >>              +-------+       +-------+       +-----------+
> >>
> >> The primary mechanism to transfer data using the QDMA is for the QDMA
> >> engine to operate on instructions (descriptors) provided by the host
> >> operating system. Using the descriptors, the QDMA can move data in bot=
h
> >> the Host to Card (H2C) direction, or the Card to Host (C2H) direction.
> >> The QDMA provides a per-queue basis option whether DMA traffic goes
> >> to an AXI4 memory map (MM) interface or to an AXI4-Stream interface.
> >>
> >> The hardware detail is provided by
> >>      https://docs.xilinx.com/r/en-US/pg302-qdma
> >>
> >> Implements dmaengine APIs to support MM DMA transfers.
> >> - probe the available DMA channels
> >> - use dma_slave_map for channel lookup
> >> - use virtual channel to manage dmaengine tx descriptors
> >> - implement device_prep_slave_sg callback to handle host scatter gathe=
r
> >>    list
> >>
> >> Signed-off-by: Nishad Saraf <nishads@amd.com>
> >> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> > Thanks for your patch, which is now commit 73d5fc92a11cacb7
> > ("dmaengine: amd: qdma: Add AMD QDMA driver") in dmaengine/next.
> >
> >> --- /dev/null
> >> +++ b/drivers/dma/amd/Kconfig
> >> @@ -0,0 +1,14 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only
> >> +
> >> +config AMD_QDMA
> >> +       tristate "AMD Queue-based DMA"
> >> +       depends on HAS_IOMEM
> > Any other subsystem or platform dependencies, to prevent asking the
> > user about this driver when configuring a kernel for a system which
> > cannot possibly have this hardware?
> > E.g. depends on PCI, or can this be used with other transports than PCI=
e?
>
> No, this driver does not have other dependencies. It can be used with
> other transports.
>
> It is similar with dmaengine/xilinx/xdma

OK.

> >> --- /dev/null
> >> +++ b/drivers/dma/amd/qdma/qdma-comm-regs.c
> >> +static struct platform_driver amd_qdma_driver =3D {
> >> +       .driver         =3D {
> >> +               .name =3D "amd-qdma",
> > Which code is responsible for creating "amd-qdma" platform devices?

I still would like to receive an answer to this question?
Thanks!


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

