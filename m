Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E778E67552
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jul 2019 21:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfGLTRA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Jul 2019 15:17:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41997 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfGLTRA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 Jul 2019 15:17:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id t132so4937038pgb.9
        for <dmaengine@vger.kernel.org>; Fri, 12 Jul 2019 12:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TGOVEHDU6QMUFnbiD3BIRdKN9VyfrJPwBpHe3FSGpAg=;
        b=nkfZJQ9hgpCFW9iLzk8dwSkTH64i+H8vplqfGtPUXVaPwkuTMXUePKH3TZhzsr16GZ
         iK/X2lGuNteW8E8zt7aFgTv7ZFzXEowyDNMR3Zog3auXdALc+1iFvL+n92N73zf5bKmX
         94w5wBa0MVPIT9oZiQNGEAMvFEihECIB3xXXcSMQn2+aCqc/Vw5jyk2H3SKMGLZrLkoE
         ZcpGmxI0DhyWJ8BhMmYQl5+P97OCjSRK4jFpYCnXyOdCCKykftQFNs6LlCnaETQZ6vve
         +h2s08OhbxURKhZGLRmXAyUKgdn26GpPoV6PuOGJI7F39yWyAIKijSFQtvTCzwN2jKhX
         gjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TGOVEHDU6QMUFnbiD3BIRdKN9VyfrJPwBpHe3FSGpAg=;
        b=NaShvIBTpIZa9irhLxpAg+RU7UrVxB4PJ4XoXV7Qbk7CDGXAeyp8n0rDKUTz5V0J1N
         RTFXd7smKYmmZ/2+47VeyvHBQ+wiGQ8U+ZsOP/fKl0Qq8anDp2DVtF4qkQllkWGiUbic
         zLGckVyluyM3cbhgXRgTum8wCGcVQiPSWqNY6MSyTSxPg1E1E+aTvuicz6gvs8/+Qjfc
         jl/eyVOZhRDERQWhO6ObjR1D3avLksHQd/NCZw0vp11PjtWsjuvIpwvzc9TJhctss3FC
         UFIBz9W7tS8weIEXJn2WUQrmjnsEL+6k51LBD5TKtYp1Cj8C90caUp0HyqCnzQaWtRSU
         p72Q==
X-Gm-Message-State: APjAAAWG7ClZhIJT4UstrtarAwJuuQkxR9xIg4qhJX+6gQQTPFgqzk2e
        t+sIgjDOAm/kge71LAdNJs5e+qa9BEjvWnenoAQ+pg==
X-Google-Smtp-Source: APXvYqz8DDKKFfyMeq2XmFAEGFvXUc8cj/j6Ydq12GQbSzvXJXTqXhAodhBP4TFp0ZC2Q6obcPiqC40y7BHQPC/izYE=
X-Received: by 2002:a17:90a:bf02:: with SMTP id c2mr14074581pjs.73.1562959019386;
 Fri, 12 Jul 2019 12:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190712091357.744515-1-arnd@arndb.de> <20190712173912.GA127917@archlinux-threadripper>
In-Reply-To: <20190712173912.GA127917@archlinux-threadripper>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 12 Jul 2019 12:16:48 -0700
Message-ID: <CAKwvOd=-OE=uHCurw7VsHPUVHz9XWW7U_8vJEerGaYPii+f8RQ@mail.gmail.com>
Subject: Re: [PATCH] dma: ste_dma40: fix unneeded variable warning
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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

On Fri, Jul 12, 2019 at 10:39 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Fri, Jul 12, 2019 at 11:13:30AM +0200, Arnd Bergmann wrote:
> > clang-9 points out that there are two variables that depending on the
> > configuration may only be used in an ARRAY_SIZE() expression but not
> > referenced:
> >
> > drivers/dma/ste_dma40.c:145:12: error: variable 'd40_backup_regs' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> > static u32 d40_backup_regs[] = {
> >            ^
> > drivers/dma/ste_dma40.c:214:12: error: variable 'd40_backup_regs_chan' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> > static u32 d40_backup_regs_chan[] = {
> >
> > Mark these __maybe_unused to shut up the warning.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch!

>
> Might be worth mentioning that this warning will only appear when
> CONFIG_PM is unset (they are both used in d40_save_restore_registers).

So would moving the definition into a
#ifdef CONFIG_PM
#endif
block be better than __maybe_unused?

-- 
Thanks,
~Nick Desaulniers
