Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C0850A318
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 16:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389659AbiDUOti (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 10:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350611AbiDUOth (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 10:49:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141B6427D7;
        Thu, 21 Apr 2022 07:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A049B61A36;
        Thu, 21 Apr 2022 14:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F2FC385A5;
        Thu, 21 Apr 2022 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650552395;
        bh=i0HMWq1JRa0F0CeO2hnG9SF3TuKwCFJPlYUxv+11vSY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KYNnxH1/6h4JHSpiitspdSKkTEwWa1tJBCwmto9ZMzu31V+JKmKgI743LDv+s34bq
         QmSRKC+hHoCyn8rQMCoQYbCY9I4u1HRgIOm+Pz2OmA5gNIE7rXJyrAZQqUv9oA3TUQ
         CVuRa/VFqB7epVLHtpWWZFuEw4IysfFmBo/cCYj+4wtcdzx74jW2LjnvsN+imBPGkx
         NUHT9J1SbF8LbbqYNTV0fbd7NyddYgpQP9JQyBAmIQiZB0mHJDNoZgZMT3gNF6FO91
         4nSd3Odf/kHuZoRH+pZi1kgbPYDKmWC6TMUEyESfHfKmh/QjbWYzrE2aZ/dN2sYGsU
         NUgA5p8ikcvFQ==
Received: by mail-wr1-f53.google.com with SMTP id p18so7030851wru.5;
        Thu, 21 Apr 2022 07:46:34 -0700 (PDT)
X-Gm-Message-State: AOAM532BY6WQ1dd6NyA20bzG0oGGSF6u3tYHeSPdcCHhlRa2PoQP/9tt
        ZPLKxgM81JEfLwIb76smpKGFlV78Vct8FjsHnuI=
X-Google-Smtp-Source: ABdhPJwYkraliZNB9aswBiexBZv/yC4YtGe2R9rvi1KW9m/P8YE/IbH0HzS9xhCUm+8mp8SN41/aSdFZNG1cTJqd71I=
X-Received: by 2002:a5d:6da5:0:b0:20a:8805:6988 with SMTP id
 u5-20020a5d6da5000000b0020a88056988mr48774wrs.317.1650552393282; Thu, 21 Apr
 2022 07:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220419133723.1394715-1-arnd@kernel.org> <20220420170836.GB1947@darkstar.musicnaut.iki.fi>
 <CAK8P3a1+sOrn8BWPVc7f+QFZ5=7fE6=MLsMYV9t+HJcG2aRCXA@mail.gmail.com> <20220421133431.GE1947@darkstar.musicnaut.iki.fi>
In-Reply-To: <20220421133431.GE1947@darkstar.musicnaut.iki.fi>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 21 Apr 2022 16:46:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0LkJ5EvJ13xtAhWzCKnnvYhYgKpPsphr1T-FGg6bzDuw@mail.gmail.com>
Message-ID: <CAK8P3a0LkJ5EvJ13xtAhWzCKnnvYhYgKpPsphr1T-FGg6bzDuw@mail.gmail.com>
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

On Thu, Apr 21, 2022 at 3:34 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>
> Hi,
>
> On Wed, Apr 20, 2022 at 10:00:13PM +0200, Arnd Bergmann wrote:
> > On Wed, Apr 20, 2022 at 7:08 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > > On Tue, Apr 19, 2022 at 03:36:42PM +0200, Arnd Bergmann wrote:
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > This is the full series for converting OMAP1 to multiplatform, rebased
> > > > from my 2019 attempt to do the same thing. The soc tree contains simpler
> > > > patches to do the same for iop32x, ixp4xx, ep93xx and s3c24xx, which
> > > > means we are getting closer to completing this for all ARMv5 platforms
> > > > (I have patches for PXA, which is the last one remaining).
> > > >
> > > > Janusz already tested the branch separately and did the missing work
> > > > for the common-clk conversion after my previous approach was broken.
> > >
> > > I tested the full series on the following OMAP1 boards: ams-delta,
> > > nokia770, osk, palmte and sx1 (QEMU only).
> > >
> > > Apart from the earlyprintk breakage, everything seemed to work OK.
> >
> > Nice, thanks a lot for testing!
>
> With the updated patch 26 also earlyprintk now works, so if you still
> update the patches, feel free to add for the whole series:
>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

I was just doing the merge, so I added the tag to the commit now.

There is now an "omap1/multiplatform-prep" branch that is part of
arm/multiplatform, and I hope to not have to rebase that. I also
have an arm/multiplatform-late branch with the remaining contents.

       Arnd
