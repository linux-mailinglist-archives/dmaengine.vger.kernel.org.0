Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E99C51516D9
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2020 09:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgBDINk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Feb 2020 03:13:40 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38961 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgBDINk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Feb 2020 03:13:40 -0500
Received: by mail-ot1-f68.google.com with SMTP id 77so16297201oty.6;
        Tue, 04 Feb 2020 00:13:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOzfGH3X0V7ecKmEp3BZzWw2D7F64fbWXNLsPHZv3Qk=;
        b=I06b4qcYw2a+YqKHfHovDGMw9nYIicHHhZBgjaSpaAZUiUZwdqvUM58O9u8NL8qg7T
         HllGG6chJ04qBQ4nkKwxFIndOVlBpHtqMc6Y6ao4xDCcpcoyHYiX3kV6mt6ZgQWYmplB
         Q5LvqC92WgM+60BE8GqxSFG7/xl17joJJ5YaoCipYcAEwwk3LvgVL/ceoe2gCuyfkCgy
         u5r4moENdkaDIY1YZ+gzl3Tia+1tY7yMAUzL2gfMn4kcCp5yQfVXflGG782HUPkayzmh
         NPCHs7wkehjaRc2pa42qB7wKKxgjZZOi3Bt13hz1wfwYw9eYgzyGHOSBcnefw7ClmV6f
         BnAg==
X-Gm-Message-State: APjAAAWDkcH/khYA1HjPF/PZPGHxypp9nmHo9ZbJsAufkuaeTAteRdw3
        12YmDLGpHqPl7BTIoPE6bJr9ZwUxYGRaxWloPSTabCHs
X-Google-Smtp-Source: APXvYqzBBbfQ012lpgP2RMvqRgR8Gp2+vA99nmHPTZXVWc6+0iUKHnH6KWrk+z3SoV9h6r6W7AXNIMmHDCOpoG3WrKM=
X-Received: by 2002:a05:6830:1d55:: with SMTP id p21mr21313411oth.145.1580804018956;
 Tue, 04 Feb 2020 00:13:38 -0800 (PST)
MIME-Version: 1.0
References: <20200203101806.2441-1-peter.ujfalusi@ti.com> <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <e47927aa-8d40-aa71-aef4-5f9c4cbbc03a@ti.com> <CAHp75Vd1A+8N_RPq3oeoXS19XeFtv7YK69H5XfzLMxWyCHbzBQ@mail.gmail.com>
 <701ab186-c240-3c37-2c0b-8ac195f8073f@ti.com> <CAMuHMdUYRvjR5qe5RVzggN+BaHw8ObEtnm8Kdn25XUiv2sJpPg@mail.gmail.com>
 <38f686ae-66fa-0e3a-ec2e-a09fc4054ac4@physik.fu-berlin.de>
 <CAMuHMdXahPt4q7Dd-mQ9RNr7JiCt8PhXeT5U2D+n-ngJmEQMgw@mail.gmail.com> <00734e40-da0b-9d7f-20bc-ce1f9658dcd3@physik.fu-berlin.de>
In-Reply-To: <00734e40-da0b-9d7f-20bc-ce1f9658dcd3@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Feb 2020 09:13:27 +0100
Message-ID: <CAMuHMdWKHOm8WjMx3Lm-MwZ_VZVaFz_otGe0V3pKp01v81mqZA@mail.gmail.com>
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards dma_request_slave_chan()
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Adrian,

On Mon, Feb 3, 2020 at 10:26 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 2/3/20 9:34 PM, Geert Uytterhoeven wrote:
> > On Mon, Feb 3, 2020 at 9:21 PM John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> >> On 2/3/20 2:32 PM, Geert Uytterhoeven wrote:
> >>> Both rspi and sh-msiof have users on legacy SH (i.e. without DT):
> >>
> >> FWIW, there is a patch set by Yoshinori Sato to add device tree support
> >> for classical SuperH hardware. It was never merged, unfortunately :(.
> >
> > True.
>
> Would it be possible to keep DMA support if device tree support was
> added for SuperH? I think Rich eventually wanted to merge the patches,
> there were just some minor issues with them.

Adding DT support would definitely make things easier, but would be a lot
of work.
However, using dma_slave_map would be an alternative.

> >>> Anyone who cares for DMA on SuperH?
> >>
> >> What is DMA used for on SuperH? Wouldn't dropping it cut support for
> >> essential hardware features?
> >
> > It may make a few things slower.
> >
> > Does any of your SuperH boards use DMA?
> > Anything interesting in /proc or /sys w.r.t. DMA?
>
> I have:
>
> root@tirpitz:/sys> find . -iname "*dma*"
> ./bus/dma
> ./bus/dma/devices/dma0
> ./bus/dma/devices/dma1
> ./bus/dma/devices/dma2
> ./bus/dma/devices/dma3
> ./bus/dma/devices/dma4
> ./bus/dma/devices/dma5
> ./bus/dma/devices/dma6
> ./bus/dma/devices/dma7
> ./bus/dma/devices/dma8
> ./bus/dma/devices/dma9
> ./bus/dma/devices/dma10
> ./bus/dma/devices/dma11
> ./bus/platform/devices/sh_dmac
> ./bus/platform/devices/sh-dma-engine.0
> ./bus/platform/devices/sh-dma-engine.1

So you do have the two dmaengines...

> On my SH-7785LCR.

... but are they actually used?

git grep -E "(SHDMA|sh_dmae_slave_config)" -- "arch/sh/*7785*"
doesn't come up with any matches, so I don't think any sh7785 platform
is wired to use DMA (yet), only sh7757 and sh772[234].

To double-check:
With current upstream, you can look for "slave" symlinks in sysfs.
With older kernels, you can look at the interrupt counts for the DMACs
in /proc/interrupts.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
