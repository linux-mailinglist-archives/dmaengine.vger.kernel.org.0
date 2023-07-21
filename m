Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E18D75CCDD
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jul 2023 17:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjGUP7P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jul 2023 11:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjGUP7O (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jul 2023 11:59:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014492D47;
        Fri, 21 Jul 2023 08:59:12 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="397947175"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="397947175"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 08:59:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="1055599368"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="1055599368"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2023 08:58:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qMsWt-00BQxg-0w;
        Fri, 21 Jul 2023 18:58:55 +0300
Date:   Fri, 21 Jul 2023 18:58:55 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     nikita.shubin@maquefel.me
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
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
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        netdev@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 09/42] clocksource: ep93xx: Add driver for Cirrus
 Logic EP93xx
Message-ID: <ZLqrPw933NOv1J8v@smile.fi.intel.com>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-9-3d63a5f1103e@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605-ep93xx-v3-9-3d63a5f1103e@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 20, 2023 at 02:29:09PM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> This us a rewrite of EP93xx timer driver in
> arch/arm/mach-ep93xx/timer-ep93xx.c trying to do everything
> the device tree way:
> 
> - Make every IO-access relative to a base address and dynamic
>   so we can do a dynamic ioremap and get going.
> - Find register range and interrupt from the device tree.

...

+ bits.h

> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/sched_clock.h>

...

> +/*************************************************************************

Won't you marc it as a DOC: section?

> + * Timer handling for EP93xx
> + *************************************************************************
> + * The ep93xx has four internal timers.  Timers 1, 2 (both 16 bit) and
> + * 3 (32 bit) count down at 508 kHz, are self-reloading, and can generate
> + * an interrupt on underflow.  Timer 4 (40 bit) counts down at 983.04 kHz,
> + * is free-running, and can't generate interrupts.
> + *
> + * The 508 kHz timers are ideal for use for the timer interrupt, as the
> + * most common values of HZ divide 508 kHz nicely.  We pick the 32 bit
> + * timer (timer 3) to get as long sleep intervals as possible when using
> + * CONFIG_NO_HZ.
> + *
> + * The higher clock rate of timer 4 makes it a better choice than the
> + * other timers for use as clock source and for sched_clock(), providing
> + * a stable 40 bit time base.
> + *************************************************************************
> + */

...

> +/*
> + * This read-only register contains the low word of the time stamp debug timer
> + * ( Timer4). When this register is read, the high byte of the Timer4 counter is

One too many spaces.

> + * saved in the Timer4ValueHigh register.
> + */

...

> +static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct ep93xx_tcu *tcu = ep93xx_tcu;
> +	struct clock_event_device *evt = dev_id;
> +
> +	/* Writing any value clears the timer interrupt */
> +	writel(1, tcu->base + EP93XX_TIMER3_CLEAR);

Would 0 suffice?

> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}

...

> +static int __init ep93xx_timer_of_init(struct device_node *np)
> +{
> +	int irq;
> +	unsigned long flags = IRQF_TIMER | IRQF_IRQPOLL;
> +	struct ep93xx_tcu *tcu;
> +	int ret;
> +
> +	tcu = kzalloc(sizeof(*tcu), GFP_KERNEL);
> +	if (!tcu)
> +		return -ENOMEM;
> +
> +	tcu->base = of_iomap(np, 0);

fwnode_iomap()?
See below why it might make sense.

> +	if (!tcu->base) {

> +		pr_err("Can't remap registers\n");

First of all, you may utilize pr_fmt().
Second, you may add %pOF for better user experience.

> +		ret = -ENXIO;
> +		goto out_free;
> +	}

> +	irq = irq_of_parse_and_map(np, 0);

fwnode_irq_get() which is better in terms of error handling.

> +	if (irq == 0)
> +		irq = -EINVAL;
> +	if (irq < 0) {

> +		pr_err("EP93XX Timer Can't parse IRQ %d", irq);

As per above.

> +		goto out_free;
> +	}

...

> +}

-- 
With Best Regards,
Andy Shevchenko


