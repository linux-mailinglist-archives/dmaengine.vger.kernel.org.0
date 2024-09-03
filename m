Return-Path: <dmaengine+bounces-3064-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2077B96989B
	for <lists+dmaengine@lfdr.de>; Tue,  3 Sep 2024 11:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980801F2147B
	for <lists+dmaengine@lfdr.de>; Tue,  3 Sep 2024 09:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963AA19F430;
	Tue,  3 Sep 2024 09:21:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B934819F429;
	Tue,  3 Sep 2024 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355269; cv=none; b=Y/qrrHq/UH0HmuLsJq2IwkBKIdqW21gmm8MrA+dSywMJBayG16mXVxhZ6FXkxhi20bQTi/Lj3o1Blt5sd9Zl3t+0i/6m1iQAx0P1kkr001pj4c7J39gocT1O2EPgRP8D+wJ+e3+iNvjXojf7RHq4ZNnNoFfeDVuugd1oYwb3Uu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355269; c=relaxed/simple;
	bh=95OJRdgGkxpG/kpI8H1rBLLHQYLxy8lN4jR3bauFAms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hI/OgW+wzCY5RUXWanhXD6Fa5gsCy0hPGBuuK0/HERL829odeT/KuB8eLQYNLbssewTyij8t2o86SqZYCQsYyRQYKOGPWHV+HAIvGu0sc9WqnUsFlPOPoBhn0A0q6WUhGyyXF0VP17Q0XL34ReYcxsGFUHcPprODNowe5mbpbeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e1a74ee4c0cso4088896276.2;
        Tue, 03 Sep 2024 02:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725355265; x=1725960065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1o4UVL51KWMPLYRjAmBfM1iKAm27OF/YUdxHeM19pY=;
        b=jM4pVZqh10LtCSv6ZgqFUBP53Y+TkIhF9fOxh8n+ZNMxDxI/UdKNAe5fif3nlmASja
         CG7ao5FK5Ysc1gm4SniQYc83q48oGDYf4aVBXxAcNPYXBTxltAyMXo3p/EAY+1zzd+9b
         ZgrukaPKliW0mj69rCBf7fMVRrZbY77V+yMXGalDvZZbxnBS2BQsEN28NCJa6jhnes2J
         N5qP93fs3Y08kj6rZ9GBWOJA89z9sLWcu314IOxsvyDhLaAJUQXNuM9GLcaBimFhkZob
         PZZchP+o9R1eqrLYlNoXcv33IbOfCY7g4FhvUrBKC4qIkIvNPXMXs7TxIUN+YX3BTOXt
         jyOg==
X-Forwarded-Encrypted: i=1; AJvYcCUVu9dCD6W/y1cRb6OqVSdbcfHSQgI3evr341Javm4S9FspEp1n718oDpQ4MOjE3GJtCdwc5Sfxf3Y=@vger.kernel.org, AJvYcCUw820BUZBWy7NlEzDdD+Z3KHYm8GJfwmUZ5sixLxRXymgcb5qbhqub33OHYjVhHR/1jzhmMbiitGHzUnCO@vger.kernel.org
X-Gm-Message-State: AOJu0YzIPLrL1NxUgGWvoDF/z668DgwxhD94mnlopn2PRD6zrIMT0qPn
	PUgINxxCYcxHQq3Rb31mQLmpHa2Gci9Kz54fD5gE9lFdD+R2HVUaVsYUXTKx
X-Google-Smtp-Source: AGHT+IH9ok+Bd0tIxy3bG3fRrNqF7USnA/rcCpSt9SOT0k9qdiIcCRTUfb+Bf1buZ5FCf3g+8N18QQ==
X-Received: by 2002:a05:690c:6382:b0:6af:fd49:67e0 with SMTP id 00721157ae682-6d4102f89f0mr137997637b3.46.1725355265370;
        Tue, 03 Sep 2024 02:21:05 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d57a426c19sm11308347b3.83.2024.09.03.02.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 02:21:05 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6c130ffa0adso48265577b3.3;
        Tue, 03 Sep 2024 02:21:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVD1UmU/2gqFpRzDPLKYB8AH4u5WWmGi+j/b8Oh1XmKb1b5isJ9MVGysLAUuiscDQciB8/SyfwJ53w=@vger.kernel.org, AJvYcCXzsE98MIU2GDvHkgzR07JYzR7cPkxQhL/3dQ99S1NOuXsQznwhnggedrHRbHhXkTjJcGOsE8Jm+p76qkDj@vger.kernel.org
X-Received: by 2002:a05:690c:3386:b0:6ad:91df:8fad with SMTP id
 00721157ae682-6d40e689319mr155308177b3.26.1725355264992; Tue, 03 Sep 2024
 02:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1713462643-11781-1-git-send-email-lizhi.hou@amd.com> <1713462643-11781-2-git-send-email-lizhi.hou@amd.com>
In-Reply-To: <1713462643-11781-2-git-send-email-lizhi.hou@amd.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 3 Sep 2024 11:20:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXVoTx8K+Vppt07s06OE6R=4BxoBbgtp1WWkCi8DwqgSA@mail.gmail.com>
Message-ID: <CAMuHMdXVoTx8K+Vppt07s06OE6R=4BxoBbgtp1WWkCi8DwqgSA@mail.gmail.com>
Subject: Re: [PATCH V12 1/1] dmaengine: amd: qdma: Add AMD QDMA driver
To: Lizhi Hou <lizhi.hou@amd.com>, nishad.saraf@amd.com
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nishad Saraf <nishads@amd.com>, sonal.santan@amd.com, max.zhen@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lizhi, Nishad,

On Thu, Apr 18, 2024 at 7:51=E2=80=AFPM Lizhi Hou <lizhi.hou@amd.com> wrote=
:
> From: Nishad Saraf <nishads@amd.com>
>
> Adds driver to enable PCIe board which uses AMD QDMA (the Queue-based
> Direct Memory Access) subsystem. For example, Xilinx Alveo V70 AI
> Accelerator devices.
>     https://www.xilinx.com/applications/data-center/v70.html
>
> The QDMA subsystem is used in conjunction with the PCI Express IP block
> to provide high performance data transfer between host memory and the
> card's DMA subsystem.
>
>             +-------+       +-------+       +-----------+
>    PCIe     |       |       |       |       |           |
>    Tx/Rx    |       |       |       |  AXI  |           |
>  <=3D=3D=3D=3D=3D=3D=3D>  | PCIE  | <=3D=3D=3D> | QDMA  | <=3D=3D=3D=3D>|=
 User Logic|
>             |       |       |       |       |           |
>             +-------+       +-------+       +-----------+
>
> The primary mechanism to transfer data using the QDMA is for the QDMA
> engine to operate on instructions (descriptors) provided by the host
> operating system. Using the descriptors, the QDMA can move data in both
> the Host to Card (H2C) direction, or the Card to Host (C2H) direction.
> The QDMA provides a per-queue basis option whether DMA traffic goes
> to an AXI4 memory map (MM) interface or to an AXI4-Stream interface.
>
> The hardware detail is provided by
>     https://docs.xilinx.com/r/en-US/pg302-qdma
>
> Implements dmaengine APIs to support MM DMA transfers.
> - probe the available DMA channels
> - use dma_slave_map for channel lookup
> - use virtual channel to manage dmaengine tx descriptors
> - implement device_prep_slave_sg callback to handle host scatter gather
>   list
>
> Signed-off-by: Nishad Saraf <nishads@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Thanks for your patch, which is now commit 73d5fc92a11cacb7
("dmaengine: amd: qdma: Add AMD QDMA driver") in dmaengine/next.

> --- /dev/null
> +++ b/drivers/dma/amd/Kconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config AMD_QDMA
> +       tristate "AMD Queue-based DMA"
> +       depends on HAS_IOMEM

Any other subsystem or platform dependencies, to prevent asking the
user about this driver when configuring a kernel for a system which
cannot possibly have this hardware?
E.g. depends on PCI, or can this be used with other transports than PCIe?

> --- /dev/null
> +++ b/drivers/dma/amd/qdma/qdma-comm-regs.c

> +static struct platform_driver amd_qdma_driver =3D {
> +       .driver         =3D {
> +               .name =3D "amd-qdma",

Which code is responsible for creating "amd-qdma" platform devices?

> +       },
> +       .probe          =3D amd_qdma_probe,
> +       .remove_new     =3D amd_qdma_remove,
> +};
> +
> +module_platform_driver(amd_qdma_driver);

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

