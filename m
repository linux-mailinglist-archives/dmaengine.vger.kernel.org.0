Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E2E7A4310
	for <lists+dmaengine@lfdr.de>; Mon, 18 Sep 2023 09:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbjIRHmr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Sep 2023 03:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240339AbjIRHmc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Sep 2023 03:42:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035FB1AE;
        Mon, 18 Sep 2023 00:39:39 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="382333083"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="382333083"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 00:39:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="811259953"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="811259953"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 00:39:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andy@kernel.org>)
        id 1qi8qk-0000000EvwK-3qGW;
        Mon, 18 Sep 2023 10:39:18 +0300
Date:   Mon, 18 Sep 2023 10:39:18 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     nikita.shubin@maquefel.me
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        netdev@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v4 00/42] ep93xx device tree conversion
Message-ID: <ZQf+pps0Ffsak+BA@smile.fi.intel.com>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Sep 15, 2023 at 11:10:42AM +0300, Nikita Shubin via B4 Relay wrote:
> This series aims to convert ep93xx from platform to full device tree support.
> 
> The main goal is to receive ACK's to take it via Arnd's arm-soc branch.
> 
> Major changes:
> - drop newline at the end from each YAML files
> - rename dma and clk bindings headers to match first compatible
> - shrink SoC exported functions number to only 2
> - dropped some ep93xx_pata fixes from these series
> - dropped m48t86 stuff from these series
> 
> Bit thanks to Andy Shevchenko for thorough review.

You are welcome!

Dunno if you have used --patience when formatted the patches, but I think
you should, if hadn't, for the next version. It will help a lot in reviewing
and understanding the changes.

-- 
With Best Regards,
Andy Shevchenko


