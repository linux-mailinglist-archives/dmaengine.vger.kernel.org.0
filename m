Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 278D71517CF
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2020 10:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgBDJ1v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Feb 2020 04:27:51 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39145 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgBDJ1v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Feb 2020 04:27:51 -0500
Received: by mail-oi1-f193.google.com with SMTP id z2so17756230oih.6;
        Tue, 04 Feb 2020 01:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8T5fw9gOqicQppobj9BJvC4APp3/qzGMetKFD287xWQ=;
        b=ccGwVEiQB10vkjNV6CKlE0U/+xHZBsuDMuO5D6RbAWMiNK0W48AxTIUsEPfEx0ZK8r
         WnG6TX2XQhg9MLjMKKHXC5aR2Lh8geX7wMWrLQh2qvzwRKk2jWCq1OdLzYH1XbeG9DWm
         voZd9B+MWOhAr0ySHeY3m6oht2z5XJExdemzjCpqDCPyfyJmRXq2ZK1RoD4MgoBtJYDM
         WzDPZzMKa5SPsIAgGWXt4Xd28ZE7iozyFNM9UD4nckOgKe/P9v8F62p27bwqiBhVnUHM
         vmGVcymMP8yvT3+vyx7i7D2zlR1v0mfJP/juIa9ISZD4VXZRTpvTtSsl8m0Z2FLhW1dL
         dZZw==
X-Gm-Message-State: APjAAAVD8WbiSUMvrWRrW2Ld5lz8t++KaHIB4L9qPw4138tQbz/LK1Gj
        D2TKqJB+ZazcgkMT1SJ2HnpcT8PkIdsE8dE7j0c=
X-Google-Smtp-Source: APXvYqzmkfJGFae+HBndS734aj6PhSlmVR2Jqfp8fQKldQAUeizqJ3a92Ns/NfbKC1toqf1ZEP0claVaB5qgY5YjcSk=
X-Received: by 2002:aca:48cd:: with SMTP id v196mr2958150oia.102.1580808470541;
 Tue, 04 Feb 2020 01:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20200203101806.2441-1-peter.ujfalusi@ti.com> <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <e47927aa-8d40-aa71-aef4-5f9c4cbbc03a@ti.com> <CAHp75Vd1A+8N_RPq3oeoXS19XeFtv7YK69H5XfzLMxWyCHbzBQ@mail.gmail.com>
 <701ab186-c240-3c37-2c0b-8ac195f8073f@ti.com> <CAMuHMdUYRvjR5qe5RVzggN+BaHw8ObEtnm8Kdn25XUiv2sJpPg@mail.gmail.com>
 <38f686ae-66fa-0e3a-ec2e-a09fc4054ac4@physik.fu-berlin.de>
 <CAMuHMdXahPt4q7Dd-mQ9RNr7JiCt8PhXeT5U2D+n-ngJmEQMgw@mail.gmail.com>
 <b09ad222-f5b8-af5a-6c2b-2dd6b30f1c73@ti.com> <CAMuHMdUYcSPoK8NOSdMzU_Jtg84aPMNKeGnacnF7=aidV4eqvw@mail.gmail.com>
 <64cffbfe-a639-c09d-8aa2-fdda8fad2cf7@landley.net>
In-Reply-To: <64cffbfe-a639-c09d-8aa2-fdda8fad2cf7@landley.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Feb 2020 10:27:38 +0100
Message-ID: <CAMuHMdVeCaRu=D9stdEuWKpnVm1YBibwuVrxogVx+2RBvOb1tA@mail.gmail.com>
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards dma_request_slave_chan()
To:     Rob Landley <rob@landley.net>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,

On Tue, Feb 4, 2020 at 10:12 AM Rob Landley <rob@landley.net> wrote:
> On 2/4/20 2:01 AM, Geert Uytterhoeven wrote:
> > On Tue, Feb 4, 2020 at 7:52 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> >> On 03/02/2020 22.34, Geert Uytterhoeven wrote:
> >>> On Mon, Feb 3, 2020 at 9:21 PM John Paul Adrian Glaubitz
> >>> <glaubitz@physik.fu-berlin.de> wrote:
> >>>> On 2/3/20 2:32 PM, Geert Uytterhoeven wrote:
> >>>>> Both rspi and sh-msiof have users on legacy SH (i.e. without DT):
> >>>>
> >>>> FWIW, there is a patch set by Yoshinori Sato to add device tree support
> >>>> for classical SuperH hardware. It was never merged, unfortunately :(.
> >>>
> >>> True.
> >>>
> >>>>> Anyone who cares for DMA on SuperH?
> >>>>
> >>>> What is DMA used for on SuperH? Wouldn't dropping it cut support for
> >>>> essential hardware features?
> >>>
> >>> It may make a few things slower.
>
> The j-core stuff has DMA but we haven't hooked it up to dmaengine yet. (It's on
> the todo list but pretty far down.)

And would use DT.  Hence the issue is not applicable to j-core.

> The turtle boards need it USB, ethernet, and sdcard, but Rich Felker hasn't
> finished the j32 port yet (we just got him the updated docs last month) and the
> existing implementation is nommu so the things that are using it are reaching
> around behind the OS's back...

Is j32 the (rebranded) j4?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
