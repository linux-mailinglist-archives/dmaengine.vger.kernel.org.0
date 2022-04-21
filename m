Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC43509695
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 07:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384402AbiDUFWp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 01:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384344AbiDUFWg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 01:22:36 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B83CBC7C;
        Wed, 20 Apr 2022 22:19:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2EAAD811B;
        Thu, 21 Apr 2022 05:16:56 +0000 (UTC)
Date:   Thu, 21 Apr 2022 08:19:45 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap <linux-omap@vger.kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Walmsley <paul@pwsan.com>,
        Kevin Hilman <khilman@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        dmaengine@vger.kernel.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 26/41] ARM: omap1: relocate static I/O mapping
Message-ID: <YmDpcXoafouaDL7s@atomide.com>
References: <20220419133723.1394715-1-arnd@kernel.org>
 <20220419133723.1394715-27-arnd@kernel.org>
 <20220420134615.GA1947@darkstar.musicnaut.iki.fi>
 <CAK8P3a00DgKYdzTZFiBfKDF_zwaJjL6Duw8aOOJ-gVkz4L1ZwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a00DgKYdzTZFiBfKDF_zwaJjL6Duw8aOOJ-gVkz4L1ZwQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

* Arnd Bergmann <arnd@kernel.org> [220420 19:18]:
> On Wed, Apr 20, 2022 at 3:46 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> >
> > Hi,
> >
> > On Tue, Apr 19, 2022 at 03:37:08PM +0200, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > The address range 0xfee00000-0xfeffffff is used for PCI and
> > > PCMCIA I/O port mappings, but OMAP1 has its static mappings
> > > there as well.
> > >
> > > Move the OMAP1 addresses a little higher to avoid crashing
> > > at boot.
> >
> > This has the same problem I reported in 2019, with earlyprintk the
> > system no longer boots:
> >
> >         https://marc.info/?t=156530014200005&r=1&w=2
> >
> > Tested on OSK and SX1/qemu.
> 
> Thanks a lot for testing!
> 
> I managed to get to the bottom of this after just a few hours, and
> it turned out to be a simple math error on my end, as I got
> the alignment wrong, the offset has to be 0x00f00000
> instead of 0x00fb0000 be section aligned. I made sure the
> kernel boots up (to the point of missing a rootfs) and uploaded
> the fixed branch.

Good to hear this got sorted out :)

Regards,

Tony
