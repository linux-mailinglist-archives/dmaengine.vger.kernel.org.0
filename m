Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA98100035
	for <lists+dmaengine@lfdr.de>; Mon, 18 Nov 2019 09:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfKRIQo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Nov 2019 03:16:44 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43149 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfKRIQo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Nov 2019 03:16:44 -0500
Received: by mail-io1-f65.google.com with SMTP id r2so12560274iot.10
        for <dmaengine@vger.kernel.org>; Mon, 18 Nov 2019 00:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R2xR2tsBSsIZb2odfJ9MONAz/KSfRM2nj9b/Mqqeo+Q=;
        b=aOVtNIaaEXzYQ4K7+NWJaJjsaPdRvw/QYXTYLk1BGl2UiqKNaUiyTwqhwaxF+sjrnw
         ih0bxdVEXRV3eMgNHMtSc5DWBwnOJ8sFDbCj6vgFdlpXQrpTbcT411pROkpaBY0WqEoi
         r07PtncOxhHwfZzb+70vISRhWCVX3JIJSKmeP0fKGvbQtpWtzkIfw6WMviKY1KF028bY
         nxtnV++suoZrKyKBksNsr8G7A3RVvscYf/gp5TktqAEEx9RS8xEfXoRp8anLLpR41P93
         qvCk3uFD8usERnrnYEeOe+MUtvQfuKDH8UuiY69nWedO8lFcQL6sUFkq6VhKFQFA9MoC
         ZX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R2xR2tsBSsIZb2odfJ9MONAz/KSfRM2nj9b/Mqqeo+Q=;
        b=PLVnmQYRmGzJYV4krcWOktl3Wz/KR7Dh2NeX47ZwY5mL+MKHU9A6WCVx2I4sFZSYaw
         KkBXBnjrHqojhBB99IBXomV/rVnVVPlgi0hPwBg4O+xWiRbSVDB2kZ/qVirIkuXKjTuF
         4EmNfJDcUk0hxvLv4JWAGrFRi8ueheu8N42ZwPgW7B4IEt2d8Qi+MaAIc8H0n+tDMh+X
         SwG8F1M6irFIrI6/opeDIArhgKdCef+fLyBvXSXUzwS3ktrO57VoYEuIfuRGJ3df2onv
         9MMfyKglO3WIeyo481MZ/8mdkDFYXaiB8MQE8QhnS00/qLpv8BenbiWN6glQNIktuGtk
         vQ+Q==
X-Gm-Message-State: APjAAAXiubUPkWC1CPNHWNWBx8CNP2oGB9GADvr2wQUuUrC5fb9nKyj/
        RvNBcr90PQQpRfn+KCKiQU1nwpoTui4EUvW+uOBNeU+b
X-Google-Smtp-Source: APXvYqzKrAIRFfCJaFOXDDEkQfAUB2cv6gOV2Ix8PBmnWBpjtkEEQW+lXEi/KIMrv8RS90Qi+8nA5vr9OBAhYzBBWoM=
X-Received: by 2002:a02:7fca:: with SMTP id r193mr12325142jac.34.1574065003549;
 Mon, 18 Nov 2019 00:16:43 -0800 (PST)
MIME-Version: 1.0
References: <20191115031013.30448-1-green.wan@sifive.com> <20191118075821.GA82508@vkoul-mobl>
In-Reply-To: <20191118075821.GA82508@vkoul-mobl>
From:   Green Wan <green.wan@sifive.com>
Date:   Mon, 18 Nov 2019 16:16:33 +0800
Message-ID: <CAJivOr4aHScXcvaHUJW0yj9Q6K73034_JxbWQQ2COd_mFBr8Cg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sf-pdma: fix kernel-doc W=1 warning
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

will fix the subject and split the patch. Thanks.

--
Green

On Mon, Nov 18, 2019 at 3:58 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 15-11-19, 11:10, Green Wan wrote:
> > Fix kernel-doc W=1 warning. There are several comments starting from "/**"
> > but not for function comment purpose. Remove them to fix the warning.
> > Another definition in front of function causes warning. Move definition
> > to header file.
>
> We do not do these kind of titles for a patch, a patch should have
> subject which describes the changes and we do not mix multiple changes
> into a patch , so..
> >
> > kernel-doc warning:
> >
> > drivers/dma/sf-pdma/sf-pdma.c:28: warning: Function parameter or member
> >       'addr' not described in 'readq'
>
> 'describe redq parameter' can be good subject and a patch
>
> > drivers/dma/sf-pdma/sf-pdma.c:438: warning: Function parameter or member
> >       'ch' not described in 'SF_PDMA_REG_BASE'
> > drivers/dma/sf-pdma/sf-pdma.c:438: warning: Excess function parameter
> >       'pdma' description in 'SF_PDMA_REG_BASE'
>
> 'remove pdma description' can be second patch and subject
>
> >
> > Changes:
> >  - Replace string '/**' with '/*' not for comment purpose
> >  - Move definition, "SF_PDMA_REG_BASE", fomr sf-pdma.c to sf-pdma.h
> >
> > Signed-off-by: Green Wan <green.wan@sifive.com>
> > ---
> >  drivers/dma/sf-pdma/sf-pdma.c | 3 +--
> >  drivers/dma/sf-pdma/sf-pdma.h | 4 +++-
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> > index 16fe00553496..465256fe8b1f 100644
> > --- a/drivers/dma/sf-pdma/sf-pdma.c
> > +++ b/drivers/dma/sf-pdma/sf-pdma.c
> > @@ -1,5 +1,5 @@
> >  // SPDX-License-Identifier: GPL-2.0-or-later
> > -/**
> > +/*
> >   * SiFive FU540 Platform DMA driver
> >   * Copyright (C) 2019 SiFive
> >   *
> > @@ -435,7 +435,6 @@ static int sf_pdma_irq_init(struct platform_device *pdev, struct sf_pdma *pdma)
> >   *
> >   * Return: none
> >   */
> > -#define SF_PDMA_REG_BASE(ch) (pdma->membase + (PDMA_CHAN_OFFSET * (ch)))
> >  static void sf_pdma_setup_chans(struct sf_pdma *pdma)
> >  {
> >       int i;
> > diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
> > index 55816c9e0249..0c20167b097d 100644
> > --- a/drivers/dma/sf-pdma/sf-pdma.h
> > +++ b/drivers/dma/sf-pdma/sf-pdma.h
> > @@ -1,5 +1,5 @@
> >  /* SPDX-License-Identifier: GPL-2.0-or-later */
> > -/**
> > +/*
> >   * SiFive FU540 Platform DMA driver
> >   * Copyright (C) 2019 SiFive
> >   *
> > @@ -57,6 +57,8 @@
> >  /* Error Recovery */
> >  #define MAX_RETRY                                    1
> >
> > +#define SF_PDMA_REG_BASE(ch) (pdma->membase + (PDMA_CHAN_OFFSET * (ch)))
> > +
> >  struct pdma_regs {
> >       /* read-write regs */
> >       void __iomem *ctrl;             /* 4 bytes */
> >
> > base-commit: a7e335deed174a37fc6f84f69caaeff8a08f8ff8
> > --
> > 2.17.1
>
> --
> ~Vinod
