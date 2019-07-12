Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74027675EF
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jul 2019 22:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfGLUcW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Jul 2019 16:32:22 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46862 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfGLUcW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 Jul 2019 16:32:22 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so9452238qtn.13;
        Fri, 12 Jul 2019 13:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXfiBSTFyabmGjKMPsBABh99TWn/O7kY2xAYWykOPE8=;
        b=SPTwUeyzHepXvnh1LumHhK8ZnPkDYBThJ658gEvEj7qDZbCoafNHHgY5qIzERxuLFd
         cMdXlJUWUUzVrFbUI+34GYudB043j9UX2PptIYXB+MV9s2ovtKIkZMavwltMZONiQNPD
         YMnbJg2YNaizvUWsgYxUkk6+EXZzPSZgMN7sBABm8HfNlpsDBWMuxXna9ur4dY8f/WqE
         3t7Psi3Oq8E+2w9u9QZdP1p5n97HRwTTkdGt9RIsDc3PdABPgJLQsbycHbpYYwbBJXaR
         U+U1IYVF5cyE9z7qc5K4fct31NFZ4GK+qUH4H+SxngQBSoK6/84I4GQo4gOV+BhYn86A
         kljQ==
X-Gm-Message-State: APjAAAVgeuWnXDwKnGvxNDZiey1bYyGgkgtLH5dWV1V68aJGROjlQ6PB
        JbklP4cxdotBiwwt4lV1Jzy4aHrbKb9eskGRKjo=
X-Google-Smtp-Source: APXvYqwP7oaInE5SLjdLNdQozkvQJxIDjpYPZdC9jFiJOoGRL1tCCAtlmFUHahShBB5MOnXi5zlDIKX7BGRcTHffAm0=
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr8086459qtf.204.1562963541466;
 Fri, 12 Jul 2019 13:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190712091357.744515-1-arnd@arndb.de> <20190712173912.GA127917@archlinux-threadripper>
 <CAKwvOd=-OE=uHCurw7VsHPUVHz9XWW7U_8vJEerGaYPii+f8RQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=-OE=uHCurw7VsHPUVHz9XWW7U_8vJEerGaYPii+f8RQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Jul 2019 22:32:05 +0200
Message-ID: <CAK8P3a25CdaJiaPNrYf3rZ85vptZvkN3Z88t=MX6NeOnTs_V3A@mail.gmail.com>
Subject: Re: [PATCH] dma: ste_dma40: fix unneeded variable warning
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jul 12, 2019 at 9:17 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Fri, Jul 12, 2019 at 10:39 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Fri, Jul 12, 2019 at 11:13:30AM +0200, Arnd Bergmann wrote:
> > > clang-9 points out that there are two variables that depending on the
> > > configuration may only be used in an ARRAY_SIZE() expression but not
> > > referenced:
> > >
> > > drivers/dma/ste_dma40.c:145:12: error: variable 'd40_backup_regs' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> > > static u32 d40_backup_regs[] = {
> > >            ^
> > > drivers/dma/ste_dma40.c:214:12: error: variable 'd40_backup_regs_chan' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> > > static u32 d40_backup_regs_chan[] = {
> > >
> > > Mark these __maybe_unused to shut up the warning.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks for the patch!
>
> >
> > Might be worth mentioning that this warning will only appear when
> > CONFIG_PM is unset (they are both used in d40_save_restore_registers).
>
> So would moving the definition into a
> #ifdef CONFIG_PM
> #endif
> block be better than __maybe_unused?
>

That would not work here, since the driver still uses ARRAY_SIZE() on
the variable.
Even more #ifdefs could solve that as well, but I don't want to spend too much
effort on this driver since it has almost no users.

      Arnd
