Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C081680C3
	for <lists+dmaengine@lfdr.de>; Fri, 21 Feb 2020 15:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgBUOvF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Feb 2020 09:51:05 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36319 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbgBUOvE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Feb 2020 09:51:04 -0500
Received: by mail-lf1-f68.google.com with SMTP id f24so1696443lfh.3
        for <dmaengine@vger.kernel.org>; Fri, 21 Feb 2020 06:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKqmcZOBwxiEAbBJOHWncpbYAIXiIAogkuJKwmYUhEY=;
        b=tCMstupyfCqlZhYVCygX4hPFog/myrUm3gRLohSV71o7UYXSx/R3guaTKMrl4p+JID
         ngi05ngbeIbeW3O+dOx6JMMjEynwS9v9/HlUZTf8qmGuHkUyIAQLNuceAW7wZlvnPGce
         gA+iQPAMEbAeddw3aC6Qb+jJ+uLLdi7gvRSJ7hqI/VhLqnceykQv2vRMilxL4yuXEjl3
         bpXPYoGeZo2MMMnnFdBMorCyJXJ6X4SLuCkDoDGD8tMAnQa5en3FAeYyfhNVUC/7GdQS
         5wAr+Azwq5ryL3FG+Oo6c8J1OSQxJ/5M7bRRFAn6+ztMpvBW4cPVbabzH2bw//HtYIwM
         ++7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKqmcZOBwxiEAbBJOHWncpbYAIXiIAogkuJKwmYUhEY=;
        b=TZSq57VcvoqpeEmvA/O7//O1QSB2iL2YbmF3Wd5Nb/ZNtKcadZTY4EXIADPty7ODa7
         3GOlMuRnt2Tau2Pu6pV6r7zXgTUgA/bMNrFPihjHKnvaevroBJ/wPn1z0hfj9N0ykFXw
         9kE/24csJXl52W8/PuCdGcO/hCr6VUVDvO6bVNnucgddpgSf+5dQ9U7++jlJkTThwqJY
         Yf9XYKWfVG58MO75VzyY9Onnk3A1C4tJ61guthuiVOXCQK1wBcP+jIhxKuXCaC+WkzsI
         MXVLRsIk4v345q21bMbD0G299qU21J9klr/TdxQGGpamS4ALbCqkaZIVL1Q5Vhh2Q+Af
         NGwA==
X-Gm-Message-State: APjAAAWwATzmfwBIPOjNnU3O4/rD3o8rhaXiINF1g6z04SS7J98oYVjS
        7O5MK5qaAYk2VdSZkmNziiMMBbh3hIQJ5GwiR96URg==
X-Google-Smtp-Source: APXvYqzWFuIhBhU7rksYnB4UoqU/fxy/g8S3+M1vXFr85vf43QcoeKUFnva1cAl5yphXzmBkSOGnUkKRz3OG0X6DpQA=
X-Received: by 2002:ac2:44a5:: with SMTP id c5mr8193005lfm.4.1582296662570;
 Fri, 21 Feb 2020 06:51:02 -0800 (PST)
MIME-Version: 1.0
References: <20200217144050.3i4ymbytogod4ijn@kili.mountain>
 <CAMuHMdWaCqZ_zcHuBetAQu4kmoffNw5jvHM5ciTi29MAxL70bg@mail.gmail.com> <20200219091754.GE2618@vkoul-mobl>
In-Reply-To: <20200219091754.GE2618@vkoul-mobl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 15:50:51 +0100
Message-ID: <CACRpkdZ94VYtADCP9VXbNPsRkCacGFOYedd9dwXQw0Jve1HRjw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: coh901318: Fix a double lock bug in dma_tc_handle()
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Feb 19, 2020 at 10:17 AM Vinod Koul <vkoul@kernel.org> wrote:
> On 17-02-20, 23:24, Geert Uytterhoeven wrote:
> > On Mon, Feb 17, 2020 at 3:41 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > The caller is already holding the lock so this will deadlock.
> > >
> > > Fixes: 0b58828c923e ("DMAENGINE: COH 901 318 remove irq counting")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > > This is the second double lock bug found using static analysis.  The
> > > previous one was commit 627469e4445b ("dmaengine: coh901318: Fix a
> > > double-lock bug").
> > >
> > > The fact that this has been broken for ten years suggests that no one
> > > has the hardware.
> >
> > Or this only runs CONFIG_SMP=n kernels?
> > This seems to be used in arch/arm/boot/dts/ste-u300.dts only, and
> > CONFIG_ARCH_U300 is a ARCH_MULTI_V5 platform, which looks like
> > it doesn't support SMP?
>
> Should we drop the driver then..?

I still have the hardware and it still works if that is the question :D

And yeah it only has one CPU, but still has a DMA engine.

The patch is fine to apply because it fixes a bug, should the same
hardware block be used on SMP.

Yours,
Linus Walleij
