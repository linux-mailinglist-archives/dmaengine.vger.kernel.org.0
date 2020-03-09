Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E38817EBB3
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2020 23:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgCIWI4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Mar 2020 18:08:56 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:43922 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgCIWI4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Mar 2020 18:08:56 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id E3E7880307C8;
        Mon,  9 Mar 2020 22:08:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Mhon-ZlolZyP; Tue, 10 Mar 2020 01:08:53 +0300 (MSK)
Date:   Tue, 10 Mar 2020 01:08:02 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] dmaengine: dw: Take Baikal-T1 SoC DW DMAC
 peculiarities into account
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200306132912.GA1748204@smile.fi.intel.com>
 <20200306133756.0F74C8030793@mail.baikalelectronics.ru>
 <20200306134829.342F4803087C@mail.baikalelectronics.ru>
 <20200306141135.9C4F380307C2@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200306141135.9C4F380307C2@mail.baikalelectronics.ru>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200309220853.E3E7880307C8@mail.baikalelectronics.ru>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 06, 2020 at 04:11:28PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 06, 2020 at 04:47:20PM +0300, Sergey Semin wrote:
> > On Fri, Mar 06, 2020 at 03:30:35PM +0200, Andy Shevchenko wrote:
> > > On Fri, Mar 06, 2020 at 03:29:12PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Mar 06, 2020 at 04:10:29PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > > > > From: Serge Semin <fancer.lancer@gmail.com>
> > > > > 
> > > > > Baikal-T1 SoC has an DW DMAC on-board to provide a Mem-to-Mem, low-speed
> > > > > peripherals Dev-to-Mem and Mem-to-Dev functionality. Mostly it's compatible
> > > > > with currently implemented in the kernel DW DMAC driver, but there are some
> > > > > peculiarities which must be taken into account in order to have the device
> > > > > fully supported.
> > > > > 
> > > > > First of all traditionally we replaced the legacy plain text-based dt-binding
> > > > > file with yaml-based one. Secondly Baikal-T1 DW DMA Controller provides eight
> > > > > channels, which alas have different max burst length configuration.
> > > > > In particular first two channels may burst up to 128 bits (16 bytes) at a time
> > > > > while the rest of them just up to 32 bits. We must make sure that the DMA
> > > > > subsystem doesn't set values exceeding these limitations otherwise the
> > > > > controller will hang up. In third currently we discovered the problem in using
> > > > > the DW APB SPI driver together with DW DMAC. The problem happens if there is no
> > > > > natively implemented multi-block LLP transfers support and the SPI-transfer
> > > > > length exceeds the max lock size. In this case due to asynchronous handling of
> > > > > Tx- and Rx- SPI transfers interrupt we might end up with Dw APB SSI Rx FIFO
> > > > > overflow. So if DW APB SSI (or any other DMAC service consumer) intends to use
> > > > > the DMAC to asynchronously execute the transfers we'd have to at least warn
> > > > > the user of the possible errors.
> > > > > 
> > > > > Finally there is a bug in the algorithm of the nollp flag detection.
> > > > > In particular even if DW DMAC parameters state the multi-block transfers
> > > > > support there is still HC_LLP (hardcode LLP) flag, which if set makes expected
> > > > > by the driver true multi-block LLP functionality unusable. This happens cause'
> > > > > if HC_LLP flag is set the LLP registers will be hardcoded to zero so the
> > > > > contiguous multi-block transfers will be only supported. We must take the
> > > > > flag into account when detecting the LLP support otherwise the driver just
> > > > > won't work correctly.
> > > > > 
> > > > > This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
> > > > > commit 98d54f81e36b ("Linux 5.6-rc4").
> > > > 
> > > > Thank you for your series!
> > > > 
> > > > I'll definitely review it, but it will take time. So, I think due to late
> > > > submission this is material at least for v5.8.
> > > 
> > 
> > Hello Andy,
> > Thanks for the quick response. Looking forward to get the patches
> > reviewed and move on with the next patchset I'll send after this. It concerns
> > DW APB SSI driver, which uses the changes introduced by this one.
> 
> > So the
> > sooner we finished with this patchset the better.
> 
> Everybody will win, but review will take as long as it take. And for sure it
> will miss v5.7 release cycle. Because too many patch sets sent at once
> followed by schedule, we almost at v5.6-rc5.
> 

Yeah. 13 patchsets is a lot of work to review. I was just saying, that
even though there are many patches sent, there are even more being
scheduled for submission after that, which rely on the alterations
provided by these patches. Though the pacthes dependency may change
seeing you have issues regarding some of them.)

> > Although I understand
> > that it may take some time. I've just sent over 12 patchset, which have a lot
> > of fixups and new drivers.)
> > 
> > > One thing that I can tell immediately is the broken email thread in this series.
> > > Whenever you do a series, use `git format-patch --cover-letter --thread ...`,
> > > so, it will link the mail properly.
> > > 
> > 
> > I've got thread=true in my gitconfig file, so each email should have
> > the proper reference and in-reply-to to the cover-letter (I see it from
> > the log). The problem popped up from a different place. For some reason the
> > automatic CC/To list extraction command didn't do the job right, so we ended
> > up with lacking of mailing lists in Cc's in this patchset. The command look like
> > this:
> > 
> > git send-email --cc-cmd "scripts/get_maintainer.pl --separator , --nokeywords --nogit --nogit-fallback --norolestats --nom" \
> >                    --to-cmd "scripts/get_maintainer.pl --separator , --nokeywords --nogit --nogit-fallback --norolestats --nol" \
> >                    --from "Serge Semin <Sergey.Semin at baikalelectronics.ru>" \
> >                    --smtp-server-option="-abaikal" --cover-letter -5
> 
> I'm talking about one which makes your Message-Id/Reference headers broken
> between cover letter and the rest of the series. It might be because of missed
> patches in the chain.
> 

Ok. Now I see what you meant. First I had a thought there was some
misunderstanding on your or my side, because my neomutt client didn't
show any Ids confusion. But after another maintainer complained about
the same problem I realized that the issue must be at someplace I
couldn't have noticed. Then I thought that the outgoing email server
could have changed the order of the sent emails. But it turned out the
problem was in the message Ids replacement performed by our corporate
exchange server. Please see the email I've sent in reply to the Vinod
comment regarding the emailing list Ccing. It describes what was really
wrong with the threading config.

Regards,
-Segey

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
