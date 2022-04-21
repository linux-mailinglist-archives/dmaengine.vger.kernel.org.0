Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0C950A0E4
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 15:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386668AbiDUNhm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 09:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiDUNhb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 09:37:31 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFD12ED69;
        Thu, 21 Apr 2022 06:34:41 -0700 (PDT)
Received: from darkstar.musicnaut.iki.fi (85-76-47-192-nat.elisa-mobile.fi [85.76.47.192])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 047811B00252;
        Thu, 21 Apr 2022 16:34:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1650548074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oVFIWam2OH5Kq5QzsfblzUEMIMiatzAi7D5irCcCglk=;
        b=Xk3qyrppSMBB4y+4boXcQF3oQ0tJICSyEousvelDBkd8/PVx55tQbJieAi/Q0KQa0aNG+G
        Gh88Z+pM8E36JmzxlWSVvjXm3PFhBwLXYL2LZOWOsctt2/ybfngzEzXevKqVRqqsk+dHOX
        5L1WRR3RN0Tc57TLDGaoxQzs/vTRLS73kqV8NQ7Pr+rYaKPhEVw6YpbHAi1CUcgHmT/iJb
        sSsFTNRKlLJoxWjnYPJUSCoDtMuNfYAqp6Y4933cAcgTAbeGBst/0aU+ZHi8x118KnYG/L
        TTEMpWSI21eBdlKccjScwxNSRB5ywON2ldVT1bI/+m9vyrFPnxxWxtiiOfNC6w==
Date:   Thu, 21 Apr 2022 16:34:31 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Arnd Bergmann <arnd@kernel.org>
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
Subject: Re: [PATCH 00/41] OMAP1 full multiplatform conversion
Message-ID: <20220421133431.GE1947@darkstar.musicnaut.iki.fi>
References: <20220419133723.1394715-1-arnd@kernel.org>
 <20220420170836.GB1947@darkstar.musicnaut.iki.fi>
 <CAK8P3a1+sOrn8BWPVc7f+QFZ5=7fE6=MLsMYV9t+HJcG2aRCXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1+sOrn8BWPVc7f+QFZ5=7fE6=MLsMYV9t+HJcG2aRCXA@mail.gmail.com>
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1650548074; a=rsa-sha256;
        cv=none;
        b=ENXGTtwbaVogGy0K8rD23cjHmjO1KDBpZYPSWyAXiJ0/g3DluUJMMqXizYyXV1sh/1O56S
        hChw4SwQwbKFg4HYlY2SOiU8koj4G0UA6uGgTWSMxSwgySv+tbXfSR2Tt70pNgc6FN/vqj
        fDExRVdSPenGd/ZTQhfjmyvSX3P7pooRbwh0WQDjEhItMOJyG5yZgN9teFQT3NBHXEEZkO
        lTJHNaVgxdVFvqiak5FfjdiYOvwW5qr/IFspdks2sOUviaT7JpvKaacUapRAwuXFYtOguN
        JXEZ3bM5xviSbbt9Tw3xErBDkB9cnwUXXzqGZHNp79d0+eb+sY0cVMOQI8ss7A==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1650548074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oVFIWam2OH5Kq5QzsfblzUEMIMiatzAi7D5irCcCglk=;
        b=Eu1uUO0EKvbhrdQZfCpIhRELzJA5jQZA+tye8R+aaTvgG9DkVEsXKYWX2Sby3kmhYmBCFx
        570Cbs63dCqUFZqQdnWOK5t2vzZfwXPpwZynEikAKA3hi3QfuIi/BoBmae0xNSLey+fMmB
        6AN1xF39YRJln008whjTgBohIBALbd/JXyh+rxwe1mx9rmT55Z+64rbOepQpAj7WZ0ttFr
        jnTgxti7i7/9Pg4jNgskYWOOvKpXwrgTWzEQwA6H3TD1Jh0kJTMK2AunGS+FmvtC90A9Rp
        r/9gYERVC+5BvSqEpSaGtYy+3htyiKaREqUWXaB7dxpxJqJYBA33p4txWzgVSw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On Wed, Apr 20, 2022 at 10:00:13PM +0200, Arnd Bergmann wrote:
> On Wed, Apr 20, 2022 at 7:08 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > On Tue, Apr 19, 2022 at 03:36:42PM +0200, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > This is the full series for converting OMAP1 to multiplatform, rebased
> > > from my 2019 attempt to do the same thing. The soc tree contains simpler
> > > patches to do the same for iop32x, ixp4xx, ep93xx and s3c24xx, which
> > > means we are getting closer to completing this for all ARMv5 platforms
> > > (I have patches for PXA, which is the last one remaining).
> > >
> > > Janusz already tested the branch separately and did the missing work
> > > for the common-clk conversion after my previous approach was broken.
> >
> > I tested the full series on the following OMAP1 boards: ams-delta,
> > nokia770, osk, palmte and sx1 (QEMU only).
> >
> > Apart from the earlyprintk breakage, everything seemed to work OK.
> 
> Nice, thanks a lot for testing!

With the updated patch 26 also earlyprintk now works, so if you still
update the patches, feel free to add for the whole series:

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Thanks,

A.
