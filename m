Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B77256A54
	for <lists+dmaengine@lfdr.de>; Sat, 29 Aug 2020 23:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgH2VUi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 29 Aug 2020 17:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgH2VUg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 29 Aug 2020 17:20:36 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E17CC061575
        for <dmaengine@vger.kernel.org>; Sat, 29 Aug 2020 14:20:34 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y2so2647144ljc.1
        for <dmaengine@vger.kernel.org>; Sat, 29 Aug 2020 14:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tZQqP/9kQfBYLXOwwY2/9XmqjIYfArF6oBpsrKgPoWk=;
        b=AbmLqUhkivcRKLvSZehoY6HsfcHP75SHwBbGTVYqRQmORnoNriFSmxObwU2VmHmy63
         E4Vz99EJMsmm7F9WygW1iy4/YZzTwxsfG/d5H+d6vMGaF7dADK4foWIt+zXy2W9YpTq+
         RCbxEzNzwxpfl9Mn69NXw7mfFaxWWWF27/u6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZQqP/9kQfBYLXOwwY2/9XmqjIYfArF6oBpsrKgPoWk=;
        b=bLe2PqOw99Mh3eNvZfE/Rr/xB12dqTKl29XYHRfZrQhtIXO6XB44KysjBSjjiHKKMk
         LYk4FwWkL/huyOAt8PLUi0tgYJP2MTpKNZyQDd0Wzkf+DazrmUBL3/+xaNRqWXsxraWx
         865uW4TWvSwSTldt8Mew+A5JzoHGchekwqFRRH0QbGGmdI0zKvZnLGrp0s/uW1WZ6gVo
         XKbeYX3myIW3gFJpxFLXOugxnmxGgtfXC00OAgSFvUnFjJKXUxyWNu9ATmGaANmoJVYC
         4j0tX498H+WDSYSMkUk5/et+G6uaS2ZRCiDdDvNr17kBsnkNdNDkfRBBKOw8B25g8B44
         9d+g==
X-Gm-Message-State: AOAM533DzjW+2DIJiQVr2D/6H5AbYKwiq/OJjIW4cLy/8LzGa7EnovsZ
        5Bk5q+bSTOnaol5bjLE1BnSJZdhvmvtPew==
X-Google-Smtp-Source: ABdhPJyUJjbfb4//2watZtynnSQqUWdKAxK7x3gSwetamHuEGv/vW1j8e2n57z6iqJSvBxIbLJ6eGQ==
X-Received: by 2002:a2e:970a:: with SMTP id r10mr2062705lji.453.1598736032452;
        Sat, 29 Aug 2020 14:20:32 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id t16sm689079ljo.27.2020.08.29.14.20.30
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 14:20:31 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id g6so2585301ljn.11
        for <dmaengine@vger.kernel.org>; Sat, 29 Aug 2020 14:20:30 -0700 (PDT)
X-Received: by 2002:a2e:b5a3:: with SMTP id f3mr1027329ljn.70.1598736030159;
 Sat, 29 Aug 2020 14:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200829105116.GA246533@roeck-us.net> <20200829124538.7475-1-luc.vanoostenryck@gmail.com>
 <CAHk-=whH0ApHy0evN0q6AwQ+-a5RK56oMkYkkCJtTMnaq4FrNQ@mail.gmail.com> <59cc6c99-9894-08b3-1075-2156e39bfc8e@roeck-us.net>
In-Reply-To: <59cc6c99-9894-08b3-1075-2156e39bfc8e@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 29 Aug 2020 14:20:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDEiWF_DsCVFPFqNa+JCS5SkOygbqeq8_=ZNOrFt7-rg@mail.gmail.com>
Message-ID: <CAHk-=wjDEiWF_DsCVFPFqNa+JCS5SkOygbqeq8_=ZNOrFt7-rg@mail.gmail.com>
Subject: Re: [PATCH] fsldma: fsl_ioread64*() do not need lower_32_bits()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joerg.roedel@amd.com>,
        Li Yang <leoyang.li@nxp.com>, Zhang Wei <zw@zh-kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        dma <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Aug 29, 2020 at 1:40 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Except for
>
> CHECK: spaces preferred around that '+' (ctx:VxV)
> #29: FILE: drivers/dma/fsldma.h:223:
> +       u32 val_lo = in_be32((u32 __iomem *)addr+1);

Added spaces.

> I don't see anything wrong with it either, so
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> Since I didn't see the real problem with the original code,
> I'd take that with a grain of salt, though.

Well, honestly, the old code was so confused that just making it build
is clearly already an improvement even if everything else were to be
wrong.

So I committed my "fix". If it turns out there's more wrong in there
and somebody tests it, we can fix it again. But now it hopefully
compiles, at least.

My bet is that if that driver ever worked on ppc32, it will continue
to work whatever we do to that function.

I _think_ the old code happened to - completely by mistake - get the
value right for the case of "little endian access, with dma_addr_t
being 32-bit". Because then it would still read the upper bits wrong,
but the cast to dma_addr_t would then throw those bits away. And the
lower bits would be right.

But for big-endian accesses or for ARCH_DMA_ADDR_T_64BIT it really
looks like it always returned a completely incorrect value.

And again - the driver may have worked even with that completely
incorrect value, since the use of it seems to be very incidental.

In either case ("it didn't work before" or "it worked because the
value doesn't really matter"), I don't think I could possibly have
made things worse.

Famous last words.

                Linus
