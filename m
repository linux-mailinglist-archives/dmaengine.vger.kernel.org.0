Return-Path: <dmaengine+bounces-6593-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD3EB7DCC6
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 14:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C861BC66D0
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 00:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B23225397;
	Wed, 17 Sep 2025 00:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxEIAE7s"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7EB21B19D;
	Wed, 17 Sep 2025 00:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758069925; cv=none; b=aM6v7PCgep2334qP5m3jHXQMZERZNpkVBWJXBiCjOSnPFsscZLlwaqBWBFOScUmnfdytzCmnYwSqFrGGYaEITIZv9DrRj0eSbaN/xzgwAUXQgK1sRl4lVCHlXdP7FKFvLFTlht5BXA89XnWD1ijvQjAez8Rs0W2iFubrL/4tUAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758069925; c=relaxed/simple;
	bh=eig1Nc4T6kQm+qPLepNb0d+UGF7Pmx+Hs1Ul9DTNrJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTiLaBB+JCMEIDwQO/+KmxxkwsjbJ8HHFdljcxJi5XLk24OZk3JBdDSro7wy/yBiUkfIaXbvD4cUlntIubNqvsMfe4bFYNXpiR32juMUrDoXIdvoSzNrL6dhHbd3Cf+Ww0/LrnbMphxAc1q83ZavJYLkwjd/5XGvjkE73ivSm0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxEIAE7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECEAC4CEEB;
	Wed, 17 Sep 2025 00:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758069925;
	bh=eig1Nc4T6kQm+qPLepNb0d+UGF7Pmx+Hs1Ul9DTNrJQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HxEIAE7sXFAKuioPdHlpoIfXJrZqxUGvEfrTl6TB/NN1/JNzvmpit3Um/N0LpY18z
	 fFYro3Hgji8YtlIJjo5KUfXj4WIe/9mv2R+cyeEuffqgZX6huIkZs5TExE/zSX8WQB
	 0V/Iy/iYoRjM017ZYVOGKO4hJ7ohS3sP0TxJxM8DVBCubSoX+sK5aZmQXHly7bZqui
	 xelPz/7bmxzALt3jVklQYU4jxRo1Y/ZRoRb3lwZdKG/c4jzqXXLet34iy31L6UEFJk
	 aEjoZHpUNvSl5PSO/UfphVerBQb0TUiJNJgHwu37ujZGqwY9n5Df+t11sKjOAF+fne
	 rmKamQyDcXgeg==
Message-ID: <8e2a796d-0c7e-44de-990b-572479bf1e89@kernel.org>
Date: Wed, 17 Sep 2025 09:45:19 +0900
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/25] power: reset: Add basic power reset driver for
 RDA8810PL
To: dang.huynh@mainlining.org, Manivannan Sadhasivam <mani@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
 <20250917-rda8810pl-drivers-v1-15-9ca9184ca977@mainlining.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250917-rda8810pl-drivers-v1-15-9ca9184ca977@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/09/2025 22:25, Dang Huynh via B4 Relay wrote:
> From: Dang Huynh <dang.huynh@mainlining.org>
> 
> This basic driver can only reboot, powering off requires the modem
> firmware which we don't have yet.
> 
> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> ---
>  MAINTAINERS                      |  6 +++++
>  drivers/power/reset/Kconfig      |  9 +++++++
>  drivers/power/reset/Makefile     |  1 +
>  drivers/power/reset/rda-reboot.c | 58 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 74 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cbe2ab8af6dcd40dd1456d9df55673dace3c87b2..5ec24d8657bffb55c160947a930980e428c6a6b7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21399,6 +21399,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/clock/rda,8810pl-apsyscon.yaml
>  F:	drivers/clk/rda/clk-rda8810.c
>  
> +RDA MICRO MODEM RESET DRIVER
> +M:	Dang Huynh <dang.huynh@mainlining.org>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/power/reset/rda,md-reset.yaml
> +F:	drivers/power/reset/rda-reboot.c
> +
>  RDA MICRO REAL TIME CLOCK DRIVER
>  M:	Dang Huynh <dang.huynh@mainlining.org>
>  S:	Maintained
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 77ea3129c70806929f3c248667db42f05f5f1d27..de9b1afb94d14a5d23286ddb302af4107d649c12 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -205,6 +205,15 @@ config POWER_RESET_QNAP
>  
>  	  Say Y if you have a QNAP NAS.
>  
> +config POWER_RESET_RDA
> +	bool "RDA Micro Reset Driver"
> +	depends on ARCH_RDA

|| COMPILE_TEST
everywhere, for all your drivers.

> +	help
> +	  This driver supports soft resetting RDA Micro boards by writing
> +	  magic values to the modem register.
> +
> +	  Say Y if you have a board with RDA Micro SoC.
> +
>  config POWER_RESET_REGULATOR
>  	bool "Regulator subsystem power-off driver"
>  	depends on OF && REGULATOR
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index b7c2b5940be9971548a5527384d1931abff11c4c..14371230410dad2852489160f4fc23d8fd087d6e 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_POWER_RESET_ODROID_GO_ULTRA_POWEROFF) += odroid-go-ultra-poweroff.o
>  obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) += piix4-poweroff.o
>  obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
>  obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
> +obj-$(CONFIG_POWER_RESET_RDA) += rda-reboot.o
>  obj-$(CONFIG_POWER_RESET_REGULATOR) += regulator-poweroff.o
>  obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
>  obj-$(CONFIG_POWER_RESET_ST) += st-poweroff.o
> diff --git a/drivers/power/reset/rda-reboot.c b/drivers/power/reset/rda-reboot.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..d87b063ba67d847f8e869e50a6c01427b2866889
> --- /dev/null
> +++ b/drivers/power/reset/rda-reboot.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025, Dang Huynh <dang.huynh@mainlining.org>
> + *
> + * Based on drivers/power/reset/msm-poweroff.c:
> + * Copyright (c) 2013, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/reboot.h>
> +#include <linux/pm.h>
> +#include <linux/mfd/syscon.h>
> +
> +static void __iomem *rda_md_sysctrl;

No, no singletons.

> +
> +static int do_rda_reboot(struct sys_off_data *data)
> +{
> +	/* unprotect md registers */
> +	writel(0x00A50001, rda_md_sysctrl);
> +
> +	/* reset all */
> +	writel(0x80000000, rda_md_sysctrl + 4);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int rda_reboot_probe(struct platform_device *pdev)
> +{
> +	rda_md_sysctrl = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rda_md_sysctrl))
> +		return PTR_ERR(rda_md_sysctrl);
> +
> +	devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART,
> +				      128, do_rda_reboot, NULL);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_rda_reboot_match[] = {
> +	{ .compatible = "rda,md-reset", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_rda_reboot_match);
> +
> +static struct platform_driver rda_reboot_driver = {
> +	.probe = rda_reboot_probe,
> +	.driver = {
> +		.name = "rda-reboot",
> +		.of_match_table = of_match_ptr(of_rda_reboot_match),


Drop of_match_ptr, you have warnings here.

> +	},
> +};
> +builtin_platform_driver(rda_reboot_driver);
> 


Best regards,
Krzysztof

