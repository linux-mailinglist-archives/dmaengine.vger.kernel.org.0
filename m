Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A969E75CF51
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jul 2023 18:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjGUQbL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jul 2023 12:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjGUQav (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jul 2023 12:30:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF1D4697;
        Fri, 21 Jul 2023 09:28:58 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="346665433"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="346665433"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 09:27:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="1055606811"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="1055606811"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2023 09:27:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qMsyf-00CQg1-0P;
        Fri, 21 Jul 2023 19:27:37 +0300
Date:   Fri, 21 Jul 2023 19:27:36 +0300
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
Subject: Re: [PATCH v3 24/42] mtd: nand: add support for ts72xx
Message-ID: <ZLqx+Osn3gcHjUph@smile.fi.intel.com>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-24-3d63a5f1103e@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605-ep93xx-v3-24-3d63a5f1103e@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 20, 2023 at 02:29:24PM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Technologic Systems has it's own nand controller implementation in CPLD.

...

+ bits.h

> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>

...

> +static int ts72xx_nand_attach_chip(struct nand_chip *chip)
> +{
> +	switch (chip->ecc.engine_type) {
> +	case NAND_ECC_ENGINE_TYPE_SOFT:
> +		if (chip->ecc.algo == NAND_ECC_ALGO_UNKNOWN)
> +			chip->ecc.algo = NAND_ECC_ALGO_HAMMING;
> +		break;
> +	case NAND_ECC_ENGINE_TYPE_ON_HOST:
> +		return -EINVAL;
> +	default:

> +		break;

Here it will return 0, is it a problem?

> +	}
> +
> +	return 0;
> +}

...

> +static int ts72xx_nand_probe(struct platform_device *pdev)
> +{
> +	struct ts72xx_nand_data *data;
> +	struct device_node *child;
> +	struct mtd_info *mtd;
> +	int err;

> +	/* Allocate memory for the device structure (and zero it) */

Useless comment.

> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->controller.ops = &ts72xx_nand_ops;
> +	nand_controller_init(&data->controller);
> +	data->chip.controller = &data->controller;
> +
> +	data->io_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(data->io_base))
> +		return PTR_ERR(data->io_base);
> +
> +	child = of_get_next_child(pdev->dev.of_node, NULL);

Why not using device property API from day 1?

	fwnode_get_next_child_node()

> +	if (!child)
> +		return dev_err_probe(&pdev->dev, -ENXIO,
> +				"ts72xx controller node should have exactly one child\n");

From now on you leak the reference count in error path.

> +	nand_set_flash_node(&data->chip, child);
> +	mtd = nand_to_mtd(&data->chip);
> +	mtd->dev.parent = &pdev->dev;
> +
> +	data->chip.legacy.IO_ADDR_R = data->io_base;
> +	data->chip.legacy.IO_ADDR_W = data->io_base;
> +	data->chip.legacy.cmd_ctrl = ts72xx_nand_hwcontrol;
> +	data->chip.legacy.dev_ready = ts72xx_nand_device_ready;
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	/*
> +	 * This driver assumes that the default ECC engine should be TYPE_SOFT.
> +	 * Set ->engine_type before registering the NAND devices in order to
> +	 * provide a driver specific default value.
> +	 */
> +	data->chip.ecc.engine_type = NAND_ECC_ENGINE_TYPE_SOFT;
> +
> +	/* Scan to find existence of the device */
> +	err = nand_scan(&data->chip, 1);
> +	if (err)
> +		return err;
> +
> +	err = mtd_device_parse_register(mtd, NULL, NULL, NULL, 0);
> +	if (err) {
> +		nand_cleanup(&data->chip);

> +		return err;
> +	}
> +
> +	return 0;


These 4 lines can be simply

	return err;

but see above.

> +}

...

> +static void ts72xx_nand_remove(struct platform_device *pdev)
> +{
> +	struct ts72xx_nand_data *data = platform_get_drvdata(pdev);
> +	struct nand_chip *chip = &data->chip;
> +	int ret;
> +
> +	ret = mtd_device_unregister(nand_to_mtd(chip));

> +	WARN_ON(ret);

Why?!  Is it like this in other MTD drivers?

> +	nand_cleanup(chip);
> +}

-- 
With Best Regards,
Andy Shevchenko


