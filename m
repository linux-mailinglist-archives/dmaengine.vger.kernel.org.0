Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E758164026
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2020 10:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgBSJUo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Feb 2020 04:20:44 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35233 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgBSJUo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Feb 2020 04:20:44 -0500
Received: by mail-oi1-f193.google.com with SMTP id b18so23160469oie.2;
        Wed, 19 Feb 2020 01:20:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dhXLvpZBSYA8Zj0oUPmUXLIuO8kszqVuuW2fgCmPK/A=;
        b=nLHPQ5w4zoZw5p5KK1WNmIN6KMYcjWOS+5sBJNy9rXXdvJa2Pm/oTp19dZJcM2u260
         r5d+npp0BCvslWORtgPWTqtDU6gr20jFtc8go+karTJ6c50bYB9lj7RTrk6KlEnUzh9I
         cybaUZ7H43sZIf8a4eiIysxhZ/fopCeKVF6xjp7kwyfJSn7M+hjSt5uBpThTxTdpub8E
         UCHiGZcTyJ8sElgoSvM0lV3ijCRyMFIRBK0KdKMKYlAOrHqWzdx0j4boiWP5lr4wyJ4d
         oN9Q4hljyntdtrlLh36r3ZkkbhPWKszBbLkv7BabSgNVmgYKTjnWVmvhzsxmT07hTD0a
         YNjg==
X-Gm-Message-State: APjAAAVGA96W9uDUenn40H/IWhGnK0uQt4+ar98u39XDeyUc6+zbHiVS
        YyjylXuarmAx/NK+blWziu63C+qVgl8rbq24abY=
X-Google-Smtp-Source: APXvYqyKBBPkhMO1S5ZQuoDusKNb5/RLLdPSI8J1vi9UYoroAgoP/6a3l+iAOfRhw8mhL5C3qfBiINLoVXMMGWov78Y=
X-Received: by 2002:aca:b4c3:: with SMTP id d186mr3878584oif.131.1582104043587;
 Wed, 19 Feb 2020 01:20:43 -0800 (PST)
MIME-Version: 1.0
References: <20200217144050.3i4ymbytogod4ijn@kili.mountain>
 <CAMuHMdWaCqZ_zcHuBetAQu4kmoffNw5jvHM5ciTi29MAxL70bg@mail.gmail.com> <20200219091754.GE2618@vkoul-mobl>
In-Reply-To: <20200219091754.GE2618@vkoul-mobl>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Feb 2020 10:20:22 +0100
Message-ID: <CAMuHMdVC_=V6z+8GubgDvWR37zZdr8f3Fqs-KYUYdZ+e=wYCyg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: coh901318: Fix a double lock bug in dma_tc_handle()
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
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

Hi Vinod,

On Wed, Feb 19, 2020 at 10:18 AM Vinod Koul <vkoul@kernel.org> wrote:
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

Why? Because spinlocks are no-ops on SMP=n, and spinlock bugs thus don't
affect the single platform using the driver?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
