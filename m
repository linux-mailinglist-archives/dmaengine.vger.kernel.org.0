Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA78B59A12
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2019 14:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfF1MKP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jun 2019 08:10:15 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41368 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfF1MKO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Jun 2019 08:10:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id o101so5408874ota.8;
        Fri, 28 Jun 2019 05:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=inxAe6SbWa/+RmnCND7/C8+GZ6y+VHqo9LIxxdbUoME=;
        b=tpf5cRqmU7ZBABjuKixaQc12K6vbIwoxWwk6KUbY1dqvU7NWNaB6j9lflH3KaJ0xyq
         eQwniQQPUbGLuq+QXt6sgSimed54+b4yHDU4xTerZsa/37jvPhoEG3VaJ7C6E8wPo1BI
         xFW/vGCpIegjK3NcXiERqZGORkSarxdc18lJwTwwV3oSvDfcj6qNnVbqsAsyNb5gGFA2
         izS8w+/RrQ41q/TleTvr71s/6SlItgu984oIE3YQM3ZNArqsSar9VHp4lJ8Bhtcu6TSx
         hSluUjMkS+Ey8S7HkP9oT++Yex/jNNdTXcLWry2Z3N2KBkyscPKk+7PbUuND9voU0E/8
         Fvrg==
X-Gm-Message-State: APjAAAUKbCv69fqF7JMLA2bT9LJDLdna9MywUz4qSgIQ1rd+gWCjOY7l
        ay5miu08m8Um0OJilVQAn99z+KmtbSKoLLl8BUU=
X-Google-Smtp-Source: APXvYqzeDMCw2GT1LfP0zffPcDxCF1ou2N+APCAbWLKnK1ivvfEQjzKho0R50iBDkfMOcaBX+W3HaDSWIWY12xAiDZA=
X-Received: by 2002:a9d:2f03:: with SMTP id h3mr7560127otb.107.1561723813108;
 Fri, 28 Jun 2019 05:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190624123818.20919-1-geert+renesas@glider.be> <20190626181459.GA31913@x230>
In-Reply-To: <20190626181459.GA31913@x230>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Jun 2019 14:10:01 +0200
Message-ID: <CAMuHMdUpPEdz3aDXo90XQ7b-jP2ErxwqLKgmEFUhhuB-oBzrDA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: rcar-dmac: Reject zero-length slave DMA requests
To:     Eugeniu Rosca <roscaeugeniu@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        dmaengine@vger.kernel.org, Eugeniu Rosca <erosca@de.adit-jv.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Eugeniu,

On Wed, Jun 26, 2019 at 8:15 PM Eugeniu Rosca <roscaeugeniu@gmail.com> wrote:
> On Mon, Jun 24, 2019 at 02:38:18PM +0200, Geert Uytterhoeven wrote:
> [..]
> > -     if (rchan->mid_rid < 0 || !sg_len) {
> > +     if (rchan->mid_rid < 0 || !sg_len || !sg_dma_len(sgl)) {
> >               dev_warn(chan->device->dev,
> >                        "%s: bad parameter: len=%d, id=%d\n",
> >                        __func__, sg_len, rchan->mid_rid);
>
> Just wanted to share the WARN output proposed by Wolfram in
> https://patchwork.kernel.org/patch/11012991/#22721733
> in case the issue discussed in [1] is reproduced with this patch:

I'm not such a big fan of WARN()...

> [    2.065337] ------------[ cut here ]------------
> [    2.065346] rcar_dmac_prep_slave_sg: <here-comes-the-warning-message>
> [    2.065394] WARNING: CPU: 2 PID: 252 at drivers/dma/sh/rcar-dmac.c:1169 rcar_dmac_prep_slave_sg+0x50/0xc4
> [    2.065397] Modules linked in:
> [    2.065407] CPU: 2 PID: 252 Comm: kworker/2:1 Not tainted 5.2.0-rc6-00016-g2bfb85ba1481-dirty #26
> [    2.065410] Hardware name: Renesas H3ULCB Kingfisher board based on r8a7795 ES2.0+ (DT)
> [    2.065420] Workqueue: events sci_dma_tx_work_fn
> [    2.065425] pstate: 40000005 (nZcv daif -PAN -UAO)
> [    2.065430] pc : rcar_dmac_prep_slave_sg+0x50/0xc4
> [    2.065434] lr : rcar_dmac_prep_slave_sg+0x50/0xc4
> [    2.065436] sp : ffff0000112ebd00
> [    2.065438] x29: ffff0000112ebd00 x28: 0000000000000000
> [    2.065443] x27: ffff8006fa367138 x26: ffff000010c5bce8
> [    2.065447] x25: 0000000738b1d000 x24: 0000000000000000
> [    2.065451] x23: ffff000010b76e00 x22: ffff000010a18000
> [    2.065455] x21: 0000000000000001 x20: ffff8006f9b5a080
> [    2.065459] x19: ffff0000107adc86 x18: 0000000000000000
> [    2.065462] x17: 0000000000000000 x16: 0000000000000000
> [    2.065466] x15: 0000000000000000 x14: 0000000000000000
> [    2.065469] x13: 0000000000040000 x12: ffff000010a35000
> [    2.065473] x11: ffff000010b12981 x10: 0000000000000040
> [    2.065477] x9 : 000000000000013e x8 : ffff000010b1b73b
> [    2.065481] x7 : 0000000000000000 x6 : 0000000000000001
> [    2.065484] x5 : ffff8006ff72f7c0 x4 : 0000000000000001
> [    2.065488] x3 : 0000000000000007 x2 : 0000000000000007
> [    2.065491] x1 : 878c73041cedc400 x0 : 0000000000000000
> [    2.065495] Call trace:
> [    2.065500]  rcar_dmac_prep_slave_sg+0x50/0xc4
> [    2.065504]  sci_dma_tx_work_fn+0xd8/0x1d4
> [    2.065511]  process_one_work+0x1dc/0x394
> [    2.065515]  worker_thread+0x21c/0x308
> [    2.065520]  kthread+0x118/0x128
> [    2.065527]  ret_from_fork+0x10/0x18
> [    2.065530] ---[ end trace 75fc17d9000f1224 ]---
>
> At first glance, it seems to give more details compared to:
> rcar-dmac e7300000.dma-controller: rcar_dmac_prep_slave_sg: bad parameter: len=1, id=19

Which would be followed by

    sh-sci e6e88000.serial: Failed preparing Tx DMA descriptor

pointing to the sh-sci driver, right?

The id=19 points to channel 0x13, i.e. SCIF2, according to
arch/arm64/boot/dts/renesas/r8a7795.dtsi.

> [1] https://patchwork.kernel.org/cover/11012981/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
