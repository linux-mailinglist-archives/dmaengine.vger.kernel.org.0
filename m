Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A312F50904F
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 21:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbiDTTXx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 15:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiDTTXw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 15:23:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1ED13FBB;
        Wed, 20 Apr 2022 12:21:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64F6161647;
        Wed, 20 Apr 2022 19:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C350EC385A8;
        Wed, 20 Apr 2022 19:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650482464;
        bh=+PgOfT87QXZRKpM2v9ZNowWskAsreLZEe6RAZERVuxs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LWkg8+P3Xly8sjIxoqjEgUnQ8BqoLngtqGiQEPZggl4dkK1DiOpgHHwSwn56ifoYf
         0jYMBC2y9oudEQNk98zILpE9CQilgE7tkJqFfirwGiPaSzGz60rXyG7LagSrWPhQem
         gbXXIArHrbaEUbVwFKFsMGfZw+kiVhQTkNWJBmFatyWcBtF+i4qgINtXXuldo7Vx0G
         RpToCuYAP6mrwt+aiH/IjOOBsTv71f5Oi3+i5AJ3tiOTaMEh/815Em+H9EnYveGtMX
         wgIyjIS3nQS3pxspnrQ1f27FpB7+Y6rOGSmBE7zDDiBd809M2ZhAxpsXP8A+8SQw2R
         w9+fnlrAhUS+g==
Received: by mail-wr1-f47.google.com with SMTP id m14so3602817wrb.6;
        Wed, 20 Apr 2022 12:21:04 -0700 (PDT)
X-Gm-Message-State: AOAM531HBf5PvIpNJOJDMxIoRo2xda1qDyp1WenSvo6XtyrM6cHHhQeu
        u4iC9XS8SJYNsKkRkMm7dhmZ0zBzHXaHtBvuABs=
X-Google-Smtp-Source: ABdhPJznf39uJYDI3N62QzlkS6buptTPqwk86KhjNzbLbHyB/jaRCmYyra2UZ9f1wUtI0joZyTmyxGE4xOIYt2PeYqA=
X-Received: by 2002:a5d:64a3:0:b0:20a:7931:5b84 with SMTP id
 m3-20020a5d64a3000000b0020a79315b84mr17397786wrp.407.1650482462896; Wed, 20
 Apr 2022 12:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220419133723.1394715-1-arnd@kernel.org> <20220419133723.1394715-27-arnd@kernel.org>
 <20220420134615.GA1947@darkstar.musicnaut.iki.fi>
In-Reply-To: <20220420134615.GA1947@darkstar.musicnaut.iki.fi>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 20 Apr 2022 21:20:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a00DgKYdzTZFiBfKDF_zwaJjL6Duw8aOOJ-gVkz4L1ZwQ@mail.gmail.com>
Message-ID: <CAK8P3a00DgKYdzTZFiBfKDF_zwaJjL6Duw8aOOJ-gVkz4L1ZwQ@mail.gmail.com>
Subject: Re: [PATCH 26/41] ARM: omap1: relocate static I/O mapping
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     linux-omap <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 20, 2022 at 3:46 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>
> Hi,
>
> On Tue, Apr 19, 2022 at 03:37:08PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The address range 0xfee00000-0xfeffffff is used for PCI and
> > PCMCIA I/O port mappings, but OMAP1 has its static mappings
> > there as well.
> >
> > Move the OMAP1 addresses a little higher to avoid crashing
> > at boot.
>
> This has the same problem I reported in 2019, with earlyprintk the
> system no longer boots:
>
>         https://marc.info/?t=156530014200005&r=1&w=2
>
> Tested on OSK and SX1/qemu.

Thanks a lot for testing!

I managed to get to the bottom of this after just a few hours, and
it turned out to be a simple math error on my end, as I got
the alignment wrong, the offset has to be 0x00f00000
instead of 0x00fb0000 be section aligned. I made sure the
kernel boots up (to the point of missing a rootfs) and uploaded
the fixed branch.

      Arnd
