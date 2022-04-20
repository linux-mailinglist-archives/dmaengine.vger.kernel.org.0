Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF5B5090FF
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 22:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381981AbiDTUDX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 16:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381982AbiDTUDW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 16:03:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEF73DDEC;
        Wed, 20 Apr 2022 13:00:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47C1EB82171;
        Wed, 20 Apr 2022 20:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCB3C385A0;
        Wed, 20 Apr 2022 20:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650484831;
        bh=6LaU3F/jCQfZw6zxuK9X0ySvN6qUfHqEJ6lGydnop44=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tTTSInI8F99rxgu1B0qJWLeIul55SHmcfk2XoOQ90GefTf3tYCCewlSGv0XDMfDh7
         Z0gfO8BUWwpRe7vFNr0stA2fvpU+veeqGj8X4dtAAMP+71o6mJUg/sPSqUxlu+ULuo
         oT0S6xjq4cbwogY8eYCb+x8No/lm+/RcuSLbCGjk19uugO+JINpbLTFeEWyaEopW/x
         lweTuMOOUBVuFVg4/k2kXIP8mpZn+WouT6CWBwWGzqmjZqAjIfMK2WcT4xN9+P5OGu
         53fTbKDiRNLPpY+ZJg9cT17Ibl1y8hQ/1xJAqK44EW7UAoTFJbIP4klfgcYI29A7th
         eAbyB39usRP9w==
Received: by mail-wr1-f51.google.com with SMTP id b19so3690567wrh.11;
        Wed, 20 Apr 2022 13:00:30 -0700 (PDT)
X-Gm-Message-State: AOAM5317GF9EwsnxWtm6HV5fMbJTWScVhoabz9V7AIKLLwMfVJLU/Wrj
        o60vR0Z1yucWuBWUQOyIfDbtVdkGrmXb4+/wQmc=
X-Google-Smtp-Source: ABdhPJwLyvz/ceR9rvvT4XHyqR02gbMMBhrAsRpzGtmhlle4bD/ec4+YXpGg4bc2rqdxlPo8PGopdbH+2zzsbpztAUk=
X-Received: by 2002:a5d:6da5:0:b0:20a:8805:6988 with SMTP id
 u5-20020a5d6da5000000b0020a88056988mr15481338wrs.317.1650484829308; Wed, 20
 Apr 2022 13:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220419133723.1394715-1-arnd@kernel.org> <20220420170836.GB1947@darkstar.musicnaut.iki.fi>
In-Reply-To: <20220420170836.GB1947@darkstar.musicnaut.iki.fi>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 20 Apr 2022 22:00:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1+sOrn8BWPVc7f+QFZ5=7fE6=MLsMYV9t+HJcG2aRCXA@mail.gmail.com>
Message-ID: <CAK8P3a1+sOrn8BWPVc7f+QFZ5=7fE6=MLsMYV9t+HJcG2aRCXA@mail.gmail.com>
Subject: Re: [PATCH 00/41] OMAP1 full multiplatform conversion
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

On Wed, Apr 20, 2022 at 7:08 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> On Tue, Apr 19, 2022 at 03:36:42PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > This is the full series for converting OMAP1 to multiplatform, rebased
> > from my 2019 attempt to do the same thing. The soc tree contains simpler
> > patches to do the same for iop32x, ixp4xx, ep93xx and s3c24xx, which
> > means we are getting closer to completing this for all ARMv5 platforms
> > (I have patches for PXA, which is the last one remaining).
> >
> > Janusz already tested the branch separately and did the missing work
> > for the common-clk conversion after my previous approach was broken.
>
> I tested the full series on the following OMAP1 boards: ams-delta,
> nokia770, osk, palmte and sx1 (QEMU only).
>
> Apart from the earlyprintk breakage, everything seemed to work OK.

Nice, thanks a lot for testing!

> A minor note, zImage grows about 50 KB with a minimal kernel config. This
> is not yet critical, there's still about 7% headroom on 770 to the 2 MB
> bootloader limit on my setup. Also the decompression time is approaching
> the hardcoded watchdog timeout...

I suspect that most of this is for the added devicetree code, and some
more for the common-clk layer. For the omap1_defconfig, there is some
hope to get part of the overhead back eventually by replacing board files
with dts descriptions that are not part of the zImage itself, but it's unlikely
to ever get smaller than it was.

       Arnd
