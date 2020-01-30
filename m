Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A31614D76E
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 09:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgA3IV3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 03:21:29 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44372 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgA3IV3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 03:21:29 -0500
Received: by mail-oi1-f195.google.com with SMTP id d62so2638947oia.11;
        Thu, 30 Jan 2020 00:21:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0CMrbfOTHcIlX3pLVmWEtIOvCOJB8+9FkEBbskQwuI=;
        b=ewvL2KIDsyQ/9tatqGx4AL2iBRL4gddPBnR6N1iagkO7q9cU5cf5g3UdWS398T19jA
         LpQdwQxOWiwM8j0Z6mvXcKCagsg9qOP3Z8xvHgI51KRD57zasbc4v0Zoo60qM68U2mIy
         S0nH+ubJ/X8RKomKiwxOF1NFyDq9Yjxntxv5w5qEFmi7fxY6wM2pIanESnK0RL4V9J4q
         m0dM9XB6ClCAqFg61XJ9onwgs+q8XoVjT/TC41sWLa1Fbhow1fM+kNjNMBu3lxwh++U4
         7sHX9cgW3bjBfQDj2tWwbWKms1QslRJx7uJz/b9Pd/Gff9e6vnRMy0joMOy39yUrFPaf
         G2fQ==
X-Gm-Message-State: APjAAAWIpN3eqjclEsrS/LTWU6X55Wn/BFLjAC2xfFJBHbPQrV7i6mrr
        Mca2s4xsc8otDduFKNTm3ye2jtevGmoN5KbRYQAC4sce
X-Google-Smtp-Source: APXvYqyqd7AXCMzlIJtBE2MuMQ8G/It9kiRThIbbMfcPRXWnXQFAGVSIA9aFAmPiwTIFEZG61scdB0mvEYwYHmaLlB4=
X-Received: by 2002:aca:b4c3:: with SMTP id d186mr2015275oif.131.1580372488319;
 Thu, 30 Jan 2020 00:21:28 -0800 (PST)
MIME-Version: 1.0
References: <5e320e71.1c69fb81.e97dd.2bf5@mx.google.com> <71ae1017-2077-87c9-d140-cac181017fb7@collabora.com>
In-Reply-To: <71ae1017-2077-87c9-d140-cac181017fb7@collabora.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Jan 2020 09:21:17 +0100
Message-ID: <CAMuHMdW1DRCHqb+YQToTCF6r_-uZy+NAO9qRigdJL6ec1atNRQ@mail.gmail.com>
Subject: Re: mainline/master bisection: baseline.login on odroid-xu3
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        dmaengine@vger.kernel.org, mgalka@collabora.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Guillaume,

On Thu, Jan 30, 2020 at 12:13 AM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
> On 29/01/2020 23:00, kernelci.org bot wrote:
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > * This automated bisection report was sent to you on the basis  *
> > * that you may be involved with the breaking commit it has      *
> > * found.  No manual investigation has been done to verify it,   *
> > * and the root cause of the problem may be somewhere else.      *
> > *                                                               *
> > * If you do send a fix, please include this trailer:            *
> > *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> > *                                                               *
> > * Hope this helps!                                              *
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> >
> > mainline/master bisection: baseline.login on odroid-xu3
> >
> > Summary:
> >   Start:      b3a608222336 Merge branch 'for-v5.6' of git://git.kernel.org:/pub/scm/linux/kernel/git/jmorris/linux-security
> >   Plain log:  https://storage.kernelci.org//mainline/master/v5.5-3996-gb3a608222336/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-8/lab-collabora/baseline-exynos5422-odroidxu3.txt
> >   HTML log:   https://storage.kernelci.org//mainline/master/v5.5-3996-gb3a608222336/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-8/lab-collabora/baseline-exynos5422-odroidxu3.html
> >   Result:     71723a96b8b1 dmaengine: Create symlinks between DMA channels and slaves

Sorry for the breakage. Please try Marek's fix:
https://lore.kernel.org/lkml/20200130070834.17537-1-m.szyprowski@samsung.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
