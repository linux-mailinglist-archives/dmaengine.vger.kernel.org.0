Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91DA54FBE4
	for <lists+dmaengine@lfdr.de>; Sun, 23 Jun 2019 15:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfFWN3e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 23 Jun 2019 09:29:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39770 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfFWN3d (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 23 Jun 2019 09:29:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so10036070ljh.6
        for <dmaengine@vger.kernel.org>; Sun, 23 Jun 2019 06:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iMugYLM0TSOEeMqLodsERtuvP9u+O/W19OcUNx2qqKE=;
        b=Nh82cgbCfdV3W9T0ZBzgKCen4UA43UBWLl8zNTUvlTbg62Y/vtLA+46MWCaMkhYfcB
         QoRsH+Kz3+V8IKyJ4dXfPjY1JYaxljjg7CZV+Jpg54/PyN/bRZQyiZ+smKKGJjV3/p4q
         VON83vTm7uZTYuGd9YVXOUylqlNpHzM9HOW+gGocuWXTRhALAo29VmkDh5l4lo1uxacz
         JOPO+5vd5ApDAC00Ibq7BfB/GIDSMaBFunF6ua+CHmVVXhTIbVdbKRd/aAwL52M+rBtA
         GnJqa/p9VsICM8jbMKWgDwDrqu0Ej8wWueg0HLx/ymewi7d0x9NjoxNYyCMqajrG6qZD
         lX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMugYLM0TSOEeMqLodsERtuvP9u+O/W19OcUNx2qqKE=;
        b=SnY2TwpEIj+frvP9dQ4KLkf90WBvHsGMkar2i0/UDgAZqXo8S21YtJ+RARVpdknoZM
         2/74tEZqz+A3O8LgqUMpgjL18gcowTRBV0jpUJItRJC/tXLSCs/UAfwxLi659Nt+hGvi
         c9Ri6oQSK5KAjtHA+9wPwO078MZlnazRpyauBk1arQMo8YU520JKhwwbCb4F1I0B2rY7
         ln5LlcWDCcwTH57EZG91Doogln4s1yOQvy3crQx/+XBsW8qz/3z325v09Xnq13w3tiRs
         AoEXEBMEWGUJkcaecRP9/M3IQwFqz1YXtuugFdlHY9C9jPTFUI/iFpxJu94K2lr0xxY1
         CXfg==
X-Gm-Message-State: APjAAAVq+58QKeN8cz4234/EteeMcRjE+YSaeUhwU8q2VC6i0+od1Wh7
        uP2cZZhggoxAvsohASu7w5HUAHi7yugszhqIcOM=
X-Google-Smtp-Source: APXvYqyFgGq3y585l8TEj8J6rLVJh4Dg4GMJOjYNsFKOYXQ+e4N/qbOsEinXobwd5zUm8asmKUGq+283TfBTN6yr91w=
X-Received: by 2002:a2e:7d03:: with SMTP id y3mr31940463ljc.240.1561296571399;
 Sun, 23 Jun 2019 06:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190622165318.bgyun52hssqmdv4n@shell.armlinux.org.uk>
 <E1helB3-0005d6-7m@rmk-PC.armlinux.org.uk> <20190622192653.puxds354sx5v3jg7@shell.armlinux.org.uk>
 <20190622202655.lwj43wpvw2ylzmcf@shell.armlinux.org.uk>
In-Reply-To: <20190622202655.lwj43wpvw2ylzmcf@shell.armlinux.org.uk>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 23 Jun 2019 10:29:50 -0300
Message-ID: <CAOMZO5CdHXXP1X_71SVL4nrV=009xNugPFjbjP8s7NZ3byyP2w@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: imx-sdma: fix incorrect conversion to readl_relaxed_poll_timeout_atomic()
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Robin Gong <yibin.gong@nxp.com>
Cc:     Michael Olbrich <m.olbrich@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Russell,

On Sat, Jun 22, 2019 at 5:27 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Sat, Jun 22, 2019 at 08:26:53PM +0100, Russell King - ARM Linux admin wrote:
> > Well, this doesn't appear to completely solve the problem either -
> > one out of four of my platforms still spat out the error (because
> > the SDMA initialisation can run on a different CPU to that which
> > receives the interrupt.)
> >
> > I've thought about using a completion, but that doesn't work either,
> > because in the case of a single CPU, the interrupts will be masked,
> > so we can't wait for completion.  I think we need to eliminate that
> > spinlock around this code.
>
> It looks like iMX6 Dual does not initialise DMA properly using the 1.1
> firmware - md5sum is:
>
> 5d4584134cc4cba62e1be2f382cd6f3a  /lib/firmware/imx/sdma/sdma-imx6q.bin
>
> I've tried extending the timeout to 5ms, checking HI[0] (both from the
> interrupt handler and from sdma_run_channel0() to cover the case of a
> single-core setup).
>
> After boot:
>
>  60:          0          0       GPC   2 Level     sdma
>
> So no interrupt was received.  Looking at the registers:
>
> # /shared/bin32/devmem2 0x20ec02c
> Value at address 0x020ec02c: 0x00000000  <= H_INTRMASK
> # /shared/bin32/devmem2 0x20ec004
> Value at address 0x020ec004: 0x00000000  <= H_INTR
> # /shared/bin32/devmem2 0x20ec00c
> Value at address 0x020ec00c: 0x00000000  <= H_START
> # /shared/bin32/devmem2 0x20ec008
> Value at address 0x020ec008: 0x00000001  <= H_STATSTOP
>
> Any ideas?

Could you please try this patch from Robin?
http://lists.infradead.org/pipermail/linux-arm-kernel/2019-June/661914.html

Thanks
