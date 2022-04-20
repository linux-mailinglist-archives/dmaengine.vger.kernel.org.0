Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C18E508714
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 13:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378157AbiDTLfV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 07:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378151AbiDTLfU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 07:35:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA4F419A3;
        Wed, 20 Apr 2022 04:32:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D8E4FCE1D78;
        Wed, 20 Apr 2022 11:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAF9C385AC;
        Wed, 20 Apr 2022 11:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650454351;
        bh=SVJ1k2v3tWdUGg+iydyQsi4Bq8zjjEYtWiKbWgwFaLw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sQ6L9Sz7HsTeFplAqNVVqZ6QvDLXO7taCfdy4bCI083iKPBu4Tu1W3tAjRXjBMJP+
         vEnLCGH51YORxEsFGOcZi/zoMsoYQoogO656Bx3dJCN3iokeUHMcZ/sRdJXG/FEfPy
         OVbCsNPPUvMBA4ygYO3ABwIPljbcDkM69w6wy8bq4hi0dZRIAMv8YMoKSdGB49RoPV
         7T06gmGwLx2hqcDTbF36X1GFj0Gux2+ukzAt7yv7JaGdNy5Qv43jNDhgQacW6a+5lC
         7ziU5CwWVIqq9dL54xJaRWmMjZZOJMF8J98DaHAPKZKsUB+PqhqrA4wPmQhlfKvBIW
         qSWfkWYIEhJww==
Received: by mail-wr1-f42.google.com with SMTP id x18so1882237wrc.0;
        Wed, 20 Apr 2022 04:32:31 -0700 (PDT)
X-Gm-Message-State: AOAM530NWB0Xph9prkK8MhpzZZvtjev6lzNibywcjlBDFqkXONBxzEmC
        BAB2nVGC+z7kHjbSFQYnKjVNHwqTkjcmslDX/Zg=
X-Google-Smtp-Source: ABdhPJyiDPtmjdTUE7gVl98mXVlPUP43tSlAHIUMCCxTRsYmEILlWV1BOcaVw3t9k0Uq80bvmC166gAUNNWM192dlCo=
X-Received: by 2002:a5d:64a3:0:b0:20a:7931:5b84 with SMTP id
 m3-20020a5d64a3000000b0020a79315b84mr15873027wrp.407.1650454349319; Wed, 20
 Apr 2022 04:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220419133723.1394715-1-arnd@kernel.org> <20220419133723.1394715-2-arnd@kernel.org>
 <ddaf112d-f997-84b7-2c57-bab3d0cca382@gmail.com>
In-Reply-To: <ddaf112d-f997-84b7-2c57-bab3d0cca382@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 20 Apr 2022 13:32:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3+5p5i2Nxy6AxH5qDsVqqxwSR_5ufjoYCALProSLNspg@mail.gmail.com>
Message-ID: <CAK8P3a3+5p5i2Nxy6AxH5qDsVqqxwSR_5ufjoYCALProSLNspg@mail.gmail.com>
Subject: Re: [PATCH 01/41] video: fbdev: omapfb: lcd_ams_delta: fix unused
 variable warning
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     linux-omap <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
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

On Wed, Apr 20, 2022 at 11:24 AM Sergei Shtylyov
<sergei.shtylyov@gmail.com> wrote:
> On 4/19/22 4:36 PM, Arnd Bergmann wrote:
>
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > A recent cleanup patch removed the only reference to a local variable
> > in some configurations.
> >
> > Move the variable into the one block it is still used in, inside
> > of an #ifdef, to avoid this warning.
> >
> > Fixes: 9d773f103b89 ("video: fbdev: omapfb: lcd_ams_delta: Make use of the helper function dev_err_probe()")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/video/fbdev/omap/lcd_ams_delta.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/omap/lcd_ams_delta.c b/drivers/video/fbdev/omap/lcd_ams_delta.c
> > index bbf871f9d862..01944ce46aa1 100644
> > --- a/drivers/video/fbdev/omap/lcd_ams_delta.c
> > +++ b/drivers/video/fbdev/omap/lcd_ams_delta.c
> [...]
> > @@ -145,7 +144,7 @@ static int ams_delta_panel_probe(struct platform_device *pdev)
> >                                               &ams_delta_lcd_ops);
> >
> >       if (IS_ERR(lcd_device)) {
> > -             ret = PTR_ERR(lcd_device);
> > +             int ret = PTR_ERR(lcd_device);
>
>    How about inserting an empty line after declaration?

Ok, done.

        Arnd
