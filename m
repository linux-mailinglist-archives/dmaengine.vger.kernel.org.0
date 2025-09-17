Return-Path: <dmaengine+bounces-6595-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A763B7DCB7
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 14:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B4C1BC7337
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 00:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91EB1DF99A;
	Wed, 17 Sep 2025 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0t/livV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988613C38;
	Wed, 17 Sep 2025 00:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758070095; cv=none; b=eHp75BNQ0ZlRrN5eg2HnLjSZd+DTb/2LJpC2lFk5Npk0PhwRK/+DavIrhlXHIAeAc3kBlsV6xedJZKFIfjcRQ9oisgAHMjfN/yC76WxUW8NPxwqHr18iReo55Aw6J0lBc8cGIPNz1ZqYuCsqrOrk9qZu4InSAt3Tpaz1XF3z1PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758070095; c=relaxed/simple;
	bh=vRAIdXOKpdVJ8Lf99sSrDe0C/XqGhJEXcMlToVAczkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHWwqjYjYeSJcqCkcsAlhMtNTUxt2peMaCxtZn3AmG07jgw8/HogOM0GP8nanbNbk0N289IsvHDy1bj41YsmdYr8KvD0GoyH1Bk8gLYACQwKB/wdb3bxJP12cf6MGIkRXtKdsx2jmoyzCd5S83P0UDNG1EranWb/Twc3gPAe7b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0t/livV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2B4C4CEEB;
	Wed, 17 Sep 2025 00:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758070093;
	bh=vRAIdXOKpdVJ8Lf99sSrDe0C/XqGhJEXcMlToVAczkw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K0t/livV7JVeClOD327d/qqH+7bPLmtwCtUAJNyAbwUbdBxrXnNKuIqZ+AwNdd2BV
	 cQA3K4NJbV7X8PX/wvADs8uoeeOhoZE7q9OazCNkWER+VCC1//CMSVaZxONa2lXbpR
	 pX428vSOZrA9aUEjFRQmxrfYu0a90uAtjUQYNQhyalHdhpbjxPMeRmZWbydFr6qMlp
	 v5nfn4927S1ISQ7YbXS7oRU3TSJ0MbdgFYdMqnzG9owOAt/yFvPQgmt8J+EIz6DkY+
	 Biz2db5mCyl/NN16pk+LfwEsDc4qrnnNfcInhj9lZxmItZjv7gDRjn57U/aCdjrOtM
	 1uxvsDOVHOLoA==
Message-ID: <d2f4d539-ebd2-4871-ba76-74b38dd41395@kernel.org>
Date: Wed, 17 Sep 2025 09:48:06 +0900
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/25] mmc: host: Add RDA Micro SD/MMC driver
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
 <20250917-rda8810pl-drivers-v1-22-9ca9184ca977@mainlining.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250917-rda8810pl-drivers-v1-22-9ca9184ca977@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/09/2025 22:25, Dang Huynh via B4 Relay wrote:
> From: Dang Huynh <dang.huynh@mainlining.org>
> 
> RDA Micro RDA8810PL includes an SD/MMC controller. This controller
> supports SD/SDIO/MMC interface.
> 
> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> ---
>  MAINTAINERS                |   6 +
>  drivers/mmc/host/Kconfig   |  12 +
>  drivers/mmc/host/Makefile  |   1 +
>  drivers/mmc/host/rda-mmc.c | 853 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 872 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 91be43782f4ba8aacb629002d357a66704f10b2b..33e04ce35dcc4cbadd715ec9199f2453237b8002 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21417,6 +21417,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/rtc/rda,8810pl-rtc.yaml
>  F:	drivers/rtc/rtc-rda.c
>  
> +RDA MICRO SECURE DIGITAL AND MULTIMEDIA CARD DRIVER
> +M:	Dang Huynh <dang.huynh@mainlining.org>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/mmc/rda,mmc.yaml
> +F:	drivers/mmc/host/rda-mmc.c
> +
>  RDACM20 Camera Sensor
>  M:	Jacopo Mondi <jacopo+renesas@jmondi.org>
>  M:	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 4afa0130779d97ca9d1c0ed2102b0babdedcaeeb..352a6eb4e30793b7311c7877c238a7fe31121123 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1040,6 +1040,18 @@ config MMC_MTK
>  	  This is needed if support for any SD/SDIO/MMC devices is required.
>  	  If unsure, say N.
>  
> +config MMC_RDA
> +	tristate "RDA Micro SD/MMC Card Interface support"
> +	depends on ARCH_RDA

Missing compile test

> +	depends on COMMON_CLK
> +	depends on HAS_DMA
> +	help
> +	  This selects the RDA Micro Secure digital and Multimedia card interface. The
> +	  controller supports SD/SDIO/MMC interface.
> +	  If you have a board with RDA SoC and it uses this interface, say Y or M here.
> +
> +	  If unsure, say N.


...

> +};
> +MODULE_DEVICE_TABLE(of, rda_mmc_dt_ids);
> +
> +static struct platform_driver rda_mmc_driver = {
> +	.probe		= rda_mmc_probe,
> +	.remove		= rda_mmc_remove,
> +	.driver		= {
> +		.name	= "rda-mmc",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +		.of_match_table = rda_mmc_dt_ids,
> +	},
> +};
> +module_platform_driver(rda_mmc_driver);
> +
> +MODULE_AUTHOR("Dang Huynh <dang.huynh@mainlining.org>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("MMC/SD driver for RDA platform");
> +MODULE_ALIAS("platform:rda-mmc");

You should not need MODULE_ALIAS() in normal cases. If you need it,
usually it means your device ID table is wrong (e.g. misses either
entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute
for incomplete ID table.


> 


Best regards,
Krzysztof

