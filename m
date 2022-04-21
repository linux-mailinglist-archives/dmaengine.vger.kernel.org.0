Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01CB509791
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 08:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384836AbiDUGav (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 02:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384828AbiDUGar (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 02:30:47 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0938913F10;
        Wed, 20 Apr 2022 23:27:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 592E7811B;
        Thu, 21 Apr 2022 06:25:07 +0000 (UTC)
Date:   Thu, 21 Apr 2022 09:27:57 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-omap@vger.kernel.org,
        aaro.koskinen@iki.fi, jmkrzyszt@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Walmsley <paul@pwsan.com>,
        Kevin Hilman <khilman@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 00/41] OMAP1 full multiplatform conversion
Message-ID: <YmD5bZ8yVhRdZjdd@atomide.com>
References: <20220419133723.1394715-1-arnd@kernel.org>
 <CAPDyKFpNx9xt1xwO-EKAx_qYtfcM5RUC6=Kh9NZ5o+A=H5ut6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpNx9xt1xwO-EKAx_qYtfcM5RUC6=Kh9NZ5o+A=H5ut6A@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [220419 14:12]:
> On Tue, 19 Apr 2022 at 15:37, Arnd Bergmann <arnd@kernel.org> wrote:
> >
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
> >
> > The fbdev, mmc and ASoC portion of Janusz' work already went into the
> > corresponding maintainer tree, but I include them here for reference.
> > Unless there are any objections, I would add the entire series to the
> > for-next branch of the soc tree, but only send the first 36 patches early
> > in the merge window. After everything else has made it in, I would rebase
> > the last two patches and send them separately, which may or may not make
> > it in the merge window.
> 
> Sounds like a good plan to me. I usually send the MMC pull-request on
> Mondays, the first day of the merge window.

Sounds good to me. I tested the current omap1-multiplatform-5.18 branch
from mach-omap2 point of view, and things seem to work just fine for me.
I don't currently have any omap1 hardware online to test with.

For the patches, please feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>
