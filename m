Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C1975AB4A
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jul 2023 11:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjGTJs2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Jul 2023 05:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjGTJsC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Jul 2023 05:48:02 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1252122;
        Thu, 20 Jul 2023 02:46:06 -0700 (PDT)
Received: from [192.168.1.103] (178.176.74.113) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Thu, 20 Jul
 2023 12:45:57 +0300
Subject: Re: [PATCH v3 26/42] ata: pata_ep93xx: add device tree support
To:     <nikita.shubin@maquefel.me>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
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
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <soc@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-ide@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-26-3d63a5f1103e@maquefel.me>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <e7350d62-8dc2-8bae-e514-3b99c3abaf74@omp.ru>
Date:   Thu, 20 Jul 2023 12:45:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230605-ep93xx-v3-26-3d63a5f1103e@maquefel.me>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.74.113]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 07/20/2023 09:27:01
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 178742 [Jul 20 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 524 524 9753033d6953787301affc41bead8ed49c47b39d
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.113 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1;178.176.74.113:7.7.3,7.4.1,7.1.2
X-KSE-AntiSpam-Info: {iprep_blacklist}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.74.113
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/20/2023 09:32:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/20/2023 4:32:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 7/20/23 2:29 PM, Nikita Shubin via B4 Relay wrote:

> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> - Add OF ID match table
> - Drop ep93xx_chip_revision and use soc_device_match instead
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  drivers/ata/pata_ep93xx.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> index c6e043e05d43..a88824dfc5fa 100644
> --- a/drivers/ata/pata_ep93xx.c
> +++ b/drivers/ata/pata_ep93xx.c
[...]
> @@ -910,6 +912,12 @@ static struct ata_port_operations ep93xx_pata_port_ops = {
>  	.port_start		= ep93xx_pata_port_start,
>  };
>  
> +static const struct soc_device_attribute ep93xx_soc_table[] = {
> +	{ .revision = "E1", .data = (void *)ATA_UDMA3 },
> +	{ .revision = "E2", .data = (void *)ATA_UDMA4 },
> +	{ /* sentinel */ }
> +};
> +
>  static int ep93xx_pata_probe(struct platform_device *pdev)
>  {
>  	struct ep93xx_pata_data *drv_data;
> @@ -939,7 +947,7 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
>  
>  	drv_data = devm_kzalloc(&pdev->dev, sizeof(*drv_data), GFP_KERNEL);
>  	if (!drv_data) {
> -		err = -ENXIO;
> +		err = -ENOMEM;
>  		goto err_rel_gpio;
>  	}
>  

   Hm, deserves its own patch. And even for this one, you should've documented it
in the patch secription...

> @@ -976,12 +984,11 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
>  	 * so this driver supports only UDMA modes.
>  	 */
>  	if (drv_data->dma_rx_channel && drv_data->dma_tx_channel) {
> -		int chip_rev = ep93xx_chip_revision();
> +		const struct soc_device_attribute *match;
>  
> -		if (chip_rev == EP93XX_CHIP_REV_E1)
> -			ap->udma_mask = ATA_UDMA3;
> -		else if (chip_rev == EP93XX_CHIP_REV_E2)
> -			ap->udma_mask = ATA_UDMA4;
> +		match = soc_device_match(ep93xx_soc_table);
> +		if (match)
> +			ap->udma_mask = (unsigned int) match->data;
>  		else
>  			ap->udma_mask = ATA_UDMA2;
>  	}

   This one also looks as it could have been done separately -- before the DT
conversion?

[...]

MBR, Sergey
