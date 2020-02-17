Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A788A161D48
	for <lists+dmaengine@lfdr.de>; Mon, 17 Feb 2020 23:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgBQWYW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Feb 2020 17:24:22 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36204 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgBQWYW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Feb 2020 17:24:22 -0500
Received: by mail-oi1-f195.google.com with SMTP id c16so18208822oic.3;
        Mon, 17 Feb 2020 14:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PbYZrxbxhBBKk5C91qZpoXk9cEvY6aisFfocm2j3KvA=;
        b=DigCYk7AL10R2xyGSD56LmG9N8s2UW5xKw+F5q0AM1/5as56CSwFP+X1LI2ptbmogS
         o78N9DjE2IzbZx57qharu+EdTI9jYnNGD7lO4bNMZr05CTVz3atkS0dm91UatMIVsK1n
         bbTRw78KiETgV6B4ZqDI8ImZc2JDV8YfXLmnCIZdrI7u6WF1HQBozZuO0jECKoc9B5dQ
         /G7vEV26sbkdww5D8tPPPUsUJoLG4e7cfVq8/o54Z/KBLVM2PwkCiMkEn5KLkOSxew/+
         ARTXz3itkeTwyupcv8AFJ0hMEROQH9JEWK7AosTQvSSrRP94mEjnx4vQRLSkVYjDg10H
         RAbg==
X-Gm-Message-State: APjAAAU3Z0nbcVMb5IZrd27tFBB822aL/ezEnTxYbi4V7lNsUMAZ6DQp
        KUJCV5OUga6NFsVQLhsPFriq501VtE8cSRDb5ePULJjs
X-Google-Smtp-Source: APXvYqz3Xxu6MK5IoxY+z+kFQJuuEELpdbhj84fkAG33NBqiXYnC9I/rrXr/6fP1+IugvUqR7fDBJ8pHyvEZfsIXAtc=
X-Received: by 2002:aca:c4d2:: with SMTP id u201mr802861oif.54.1581978262056;
 Mon, 17 Feb 2020 14:24:22 -0800 (PST)
MIME-Version: 1.0
References: <20200217144050.3i4ymbytogod4ijn@kili.mountain>
In-Reply-To: <20200217144050.3i4ymbytogod4ijn@kili.mountain>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Feb 2020 23:24:10 +0100
Message-ID: <CAMuHMdWaCqZ_zcHuBetAQu4kmoffNw5jvHM5ciTi29MAxL70bg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: coh901318: Fix a double lock bug in dma_tc_handle()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Linus Walleij <linus.walleij@stericsson.com>,
        kernel-janitors@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Dan,

On Mon, Feb 17, 2020 at 3:41 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> The caller is already holding the lock so this will deadlock.
>
> Fixes: 0b58828c923e ("DMAENGINE: COH 901 318 remove irq counting")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> This is the second double lock bug found using static analysis.  The
> previous one was commit 627469e4445b ("dmaengine: coh901318: Fix a
> double-lock bug").
>
> The fact that this has been broken for ten years suggests that no one
> has the hardware.

Or this only runs CONFIG_SMP=n kernels?
This seems to be used in arch/arm/boot/dts/ste-u300.dts only, and
CONFIG_ARCH_U300 is a ARCH_MULTI_V5 platform, which looks like
it doesn't support SMP?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
