Return-Path: <dmaengine+bounces-7091-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A8DC3DA62
	for <lists+dmaengine@lfdr.de>; Thu, 06 Nov 2025 23:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B15F634F891
	for <lists+dmaengine@lfdr.de>; Thu,  6 Nov 2025 22:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F33C34BA20;
	Thu,  6 Nov 2025 22:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CiwjBa7F"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A359F324B3B;
	Thu,  6 Nov 2025 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468985; cv=none; b=fXSIaXFRFVh8wXA3XUvzN/4NKc80Fhx0xweQqvcThk1Yo5lIRX6WOHlDxLISj+a69v5MBn3vViRZAm55CKIpQeCY1GgEKm+72Qm9xy4HY2WJCzeDtf6bSo5f2aJ6soXJvwYtkY2umqUhGnUUMQ2E8AyJD4ax8T3dz9EOvR9/JA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468985; c=relaxed/simple;
	bh=Cyb/Wpl2VIvq9QnGtsyMGGiPiB5c1CYdt3l9h2o2hPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfvUnllN09ScQowYJ4cRjs6KruWroCOIHqdpPsqrQhjwqZeXBBv1rIGBYBW6qKs0LDZda6VPxZxiifrwKBehKWUZgxyuimC5EUGPnocBQE4PImA24WlgbvIzmq1TS75FewmcKCjAnG5Au4wZ/Yb6dAoW6Zier9C7OUV2O1MJtMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CiwjBa7F; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C9FCD1A190A;
	Thu,  6 Nov 2025 22:42:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9223E606EE;
	Thu,  6 Nov 2025 22:42:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99DC3118517A8;
	Thu,  6 Nov 2025 23:42:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762468978; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=opBUZp1Hke891i+7bOcpvqv+rOF+PwTKZzF4gjBM21s=;
	b=CiwjBa7FmHTYZDw7RAtDd7oLPZ9Eke07nw0njoggA2Ozz+5Tyu9j6piJEW13eq1PLpeA8f
	1XbisMNqRDvzFpS1FqM/KVHsjY/bFlasC7ect+j8R6zKNH3HegCS1zMV4yoyjPfTbMw4x2
	7eixkfFez+DsK7i91OqaxxpnzhqBlYPyW7EP68Pi+aUl2fp/9ydsie7WfpMGxN8EfkeQ8B
	eIWO8AqRC9i20QtTD3qh+iHy5lrVcwiZdWuzZd3Ah+Mt2CDClkY25/OfrxIOMajtHP5H+5
	L5m+YpvuOP/A/BfmFs0+0YOzIQo2p4s/3hr/cCSh74g+rKYwi1U7bHFKb2GQow==
Date: Thu, 6 Nov 2025 23:42:52 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: dang.huynh@mainlining.org
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-unisoc@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 06/25] rtc: Add driver for RDA Micro SoC
Message-ID: <2025110622425227de2cac@mail.local>
References: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
 <20250917-rda8810pl-drivers-v1-6-9ca9184ca977@mainlining.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-rda8810pl-drivers-v1-6-9ca9184ca977@mainlining.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

There are checkpatch --strict issues, please fix them.


On 17/09/2025 03:25:03+0700, Dang Huynh via B4 Relay wrote:
>  MAINTAINERS           |   6 +
>  drivers/rtc/Kconfig   |  11 ++
>  drivers/rtc/Makefile  |   1 +
>  drivers/rtc/rtc-rda.c | 356 ++++++++++++++++++++++++++++++++++++++++++++++++++

Unless you can guarantee this driver will support all the future RDA
SoC RTCs, the filename needs to be SoC specific.

> +config RTC_DRV_RDA
> +	tristate "RDA Micro RTC"
> +	depends on ARCH_RDA || COMPILE_TEST
> +	select REGMAP_MMIO
> +	help
> +	  If you say yes here you get support for the built-in RTC on
> +	  RDA Micro SoC.

You probably also need to list which ones are supported.

> +static int rda_rtc_settime(struct device *dev, struct rtc_time *tm)
> +{
> +	struct rda_rtc *rtc = dev_get_drvdata(dev);
> +	u32 high, low;
> +	int ret;
> +
> +	ret = rtc_valid_tm(tm);
> +	if (ret < 0)
> +		return ret;

The RTC core will never pass an invalid rtc_tm, this check is useless.

> +
> +	/*
> +	 * The number of years since 1900 in kernel,
> +	 * but it is defined since 2000 by HW.
> +	 * The number of mons' range is from 0 to 11 in kernel,
> +	 * but it is defined from 1 to 12 by HW.

This comment is not super useful as this is super common in the RTC
drivers,. If you want to keep it, please fix it.

> +	 */
> +	low = FIELD_PREP(RDA_SEC_MASK, tm->tm_sec) |
> +		FIELD_PREP(RDA_MIN_MASK, tm->tm_min) |
> +		FIELD_PREP(RDA_HRS_MASK, tm->tm_hour);
> +
> +	high = FIELD_PREP(RDA_MDAY_MASK, tm->tm_mday) |
> +		FIELD_PREP(RDA_MON_MASK, tm->tm_mon + 1) |
> +		FIELD_PREP(RDA_YEAR_MASK, tm->tm_year - 100) |
> +		FIELD_PREP(RDA_WDAY_MASK, tm->tm_wday);
> +
> +	ret = regmap_write(rtc->regmap, RDA_RTC_CAL_LOAD_LOW_REG, low);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to update RTC low register: %d\n", ret);

This needs to be a dev_dbg or removed.

> +		return ret;
> +	}
> +
> +	ret = regmap_write(rtc->regmap, RDA_RTC_CAL_LOAD_HIGH_REG, high);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to update RTC low register: %d\n", ret);

Ditto

> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(rtc->regmap, RDA_RTC_CMD_REG, RDA_RTC_CMD_CAL_LOAD, 1);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to update RTC cal load register: %d\n", ret);

Ditto

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rda_rtc_readtime(struct device *dev, struct rtc_time *tm)
> +{
> +	struct rda_rtc *rtc = dev_get_drvdata(dev);
> +	unsigned int high, low;
> +	int ret;
> +
> +	/*
> +	 * Check if RTC data is valid.
> +	 *
> +	 * When this bit is set, it means the data in the RTC is invalid
> +	 * or not configured.
> +	 */
> +	ret = regmap_test_bits(rtc->regmap, RDA_RTC_STA_REG, RDA_RTC_STA_NOT_PROG);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to read RTC status: %d\n", ret);

dev_dbg

> +		return ret;
> +	} else if (ret > 0)
> +		return -EINVAL;
> +
> +	ret = regmap_read(rtc->regmap, RDA_RTC_CUR_LOAD_HIGH_REG, &high);
> +	if (ret) {
> +		dev_err(dev, "Failed to read RTC high reg: %d\n", ret);

Ditto

> +		return ret;
> +	}
> +
> +	ret = regmap_read(rtc->regmap, RDA_RTC_CUR_LOAD_LOW_REG, &low);
> +	if (ret) {
> +		dev_err(dev, "Failed to read RTC low reg: %d\n", ret);

Ditto

> +		return ret;
> +	}
> +
> +	tm->tm_sec = FIELD_GET(RDA_SEC_MASK, low);
> +	tm->tm_min = FIELD_GET(RDA_MIN_MASK, low);
> +	tm->tm_hour = FIELD_GET(RDA_HRS_MASK, low);
> +	tm->tm_mday = FIELD_GET(RDA_MDAY_MASK, high);
> +	tm->tm_mon = FIELD_GET(RDA_MON_MASK, high);
> +	tm->tm_year = FIELD_GET(RDA_YEAR_MASK, high);
> +	tm->tm_wday = FIELD_GET(RDA_WDAY_MASK, high);
> +
> +	/*
> +	 * The number of years since 1900 in kernel,
> +	 * but it is defined since 2000 by HW.
> +	 */
> +	tm->tm_year += 100;
> +	/*
> +	 * The number of mons' range is from 0 to 11 in kernel,
> +	 * but it is defined from 1 to 12 by HW.
> +	 */

You can probably drop both comments.

> +	tm->tm_mon -= 1;
> +
> +	return 0;
> +}
> +
> +static int rda_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct rda_rtc *rtc = dev_get_drvdata(dev);
> +	struct rtc_time *tm = &alrm->time;
> +	unsigned int high, low;
> +	int ret;
> +
> +	ret = regmap_read(rtc->regmap, RDA_RTC_ALARM_HIGH_REG, &high);
> +	if (ret) {
> +		dev_err(dev, "Failed to read alarm low reg: %d\n", ret);

Just to be clear, the driver is super verbose with all those dev_err.
Strings are bloating the kernel and those string will probably never be
seen by any user and event if they are seen, the user doesn't have any
other action to do other than retrying. Please remove them of move them
to dev_dbg

> +		return ret;
> +	}
> +
> +	ret = regmap_read(rtc->regmap, RDA_RTC_ALARM_LOW_REG, &low);
> +	if (ret) {
> +		dev_err(dev, "Failed to read alarm low reg: %d\n", ret);
> +		return ret;
> +	}
> +
> +	tm->tm_sec = FIELD_GET(RDA_SEC_MASK, low);
> +	tm->tm_min = FIELD_GET(RDA_MIN_MASK, low);
> +	tm->tm_hour = FIELD_GET(RDA_HRS_MASK, low);
> +	tm->tm_mday = FIELD_GET(RDA_MDAY_MASK, high);
> +	tm->tm_mon = FIELD_GET(RDA_MON_MASK, high);
> +	tm->tm_year = FIELD_GET(RDA_YEAR_MASK, high);
> +	tm->tm_wday = FIELD_GET(RDA_WDAY_MASK, high);
> +
> +	/*
> +	 * The number of years since 1900 in kernel,
> +	 * but it is defined since 2000 by HW.
> +	 */
> +	tm->tm_year += 100;
> +	/*
> +	 * The number of mons' range is from 0 to 11 in kernel,
> +	 * but it is defined from 1 to 12 by HW.
> +	 */
> +	tm->tm_mon -= 1;
> +
> +	return 0;
> +}
> +
> +static int rda_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
> +{
> +	struct rda_rtc *rtc = dev_get_drvdata(dev);
> +
> +	if (enabled)
> +		return regmap_update_bits(rtc->regmap, RDA_RTC_CMD_REG,
> +				RDA_RTC_CMD_ALARM_ENABLE, 1);
> +
> +	return regmap_update_bits(rtc->regmap, RDA_RTC_CMD_REG,
> +			RDA_RTC_CMD_ALARM_DISABLE, 1);

Wow, this is super weird, so you have one bit to enable and one to
disable the alarm. Is RDA_RTC_CMD_REG write only?

> +}
> +
> +static int rda_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct rda_rtc *rtc = dev_get_drvdata(dev);
> +	struct rtc_time *tm = &alrm->time;
> +	u32 high, low;
> +	int ret;
> +
> +	ret = rtc_valid_tm(tm);
> +	if (ret < 0)
> +		return ret;
> +

tm will never be invalid

> +	/* TODO: Check if it's necessary to disable IRQ first */

I'd say probably not ;)

> +	rda_rtc_alarm_irq_enable(dev, 0);
> +
> +	/*
> +	 * The number of years since 1900 in kernel,
> +	 * but it is defined since 2000 by HW.
> +	 * The number of mons' range is from 0 to 11 in kernel,
> +	 * but it is defined from 1 to 12 by HW.
> +	 */

This is still the same comment...

> +	low = FIELD_PREP(RDA_SEC_MASK, tm->tm_sec) |
> +		FIELD_PREP(RDA_MIN_MASK, tm->tm_min) |
> +		FIELD_PREP(RDA_HRS_MASK, tm->tm_hour);
> +
> +	high = FIELD_PREP(RDA_MDAY_MASK, tm->tm_mday) |
> +		FIELD_PREP(RDA_MON_MASK, tm->tm_mon + 1) |
> +		FIELD_PREP(RDA_YEAR_MASK, tm->tm_year - 100) |
> +		FIELD_PREP(RDA_WDAY_MASK, tm->tm_wday);
> +
> +
> +	ret = regmap_write(rtc->regmap, RDA_RTC_ALARM_LOW_REG, low);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set low alarm register: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_write(rtc->regmap, RDA_RTC_ALARM_HIGH_REG, high);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set low alarm register: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(rtc->regmap, RDA_RTC_CMD_REG, RDA_RTC_CMD_ALARM_LOAD, 1);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set alarm register: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_dbg(dev, "Alarm set: %4d-%02d-%02d %02d:%02d:%02d\n",
> +			2000 + (tm->tm_year - 100), tm->tm_mon + 1, tm->tm_mday,
> +			tm->tm_hour, tm->tm_min, tm->tm_sec);

You probably want to use %ptR or drop this as we have a tracepoint just
after.

> +
> +	return 0;
> +}
> +
> +static int rda_rtc_proc(struct device *dev, struct seq_file *seq)
> +{
> +	struct rda_rtc *rtc = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regmap_test_bits(rtc->regmap, RDA_RTC_STA_REG, RDA_RTC_STA_ALARM_ENABLE);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to read alarm status: %d\n", ret);
> +		return ret;
> +	}
> +
> +	seq_printf(seq, "alarm enable\t: %s\n", (ret > 0) ? "yes" : "no");
> +
> +	return 0;
> +}

Drop this function, this interface is obsolete

> +
> +static const struct rtc_class_ops rda_rtc_ops = {
> +	.read_time = rda_rtc_readtime,
> +	.set_time = rda_rtc_settime,
> +	.read_alarm = rda_rtc_readalarm,
> +	.set_alarm = rda_rtc_setalarm,
> +	.proc = rda_rtc_proc,
> +	.alarm_irq_enable = rda_rtc_alarm_irq_enable,
> +};
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int rda_rtc_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	/* TODO: Check if it's okay to turn on alarm IRQ when it's not set */
> +	return rda_rtc_alarm_irq_enable(&pdev->dev, 1);
> +}
> +
> +static int rda_rtc_resume(struct platform_device *pdev)
> +{
> +	/* If alarms were left, we turn them off. */
> +	return rda_rtc_alarm_irq_enable(&pdev->dev, 0);
> +}

Let userspace enabling/disabling alarm, the kernel must not decide to
enable or disable them which fixes your TODO

> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(rda_rtc_pm_ops, rda_rtc_suspend, rda_rtc_resume);
> +
> +static const struct regmap_config regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +};
> +
> +static int rda_rtc_probe(struct platform_device *pdev)
> +{
> +	struct rda_rtc *rda_rtc;
> +	void __iomem *base;
> +
> +	rda_rtc = devm_kzalloc(&pdev->dev, sizeof(*rda_rtc), GFP_KERNEL);
> +	if (!rda_rtc)
> +		return -ENOMEM;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(base),
> +				"failed to remap resource\n");
> +
> +	rda_rtc->regmap = devm_regmap_init_mmio(&pdev->dev, base, &regmap_config);
> +	if (!rda_rtc->regmap)
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rda_rtc->regmap),
> +				"can't find regmap\n");
> +
> +	rda_rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
> +	if (IS_ERR(rda_rtc->rtc_dev))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rda_rtc->rtc_dev),
> +				"failed to allocate rtc device\n");
> +
> +	rda_rtc->rtc_dev->ops = &rda_rtc_ops;
> +	rda_rtc->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_2000;
> +	rda_rtc->rtc_dev->range_max = RTC_TIMESTAMP_END_2127;
> +
> +	platform_set_drvdata(pdev, rda_rtc);
> +
> +	return devm_rtc_register_device(rda_rtc->rtc_dev);
> +}
> +
> +static const struct of_device_id rda_rtc_id_table[] = {
> +	{ .compatible = "rda,8810pl-rtc", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, rda_rtc_id_table);
> +
> +static struct platform_driver rda_rtc_driver = {
> +	.probe = rda_rtc_probe,
> +	.driver = {
> +		.name = "rtc-rda",
> +		.pm = &rda_rtc_pm_ops,
> +		.of_match_table = rda_rtc_id_table,
> +	},
> +};
> +module_platform_driver(rda_rtc_driver);
> +
> +MODULE_AUTHOR("Dang Huynh <dang.huynh@mainlining.org>");
> +MODULE_DESCRIPTION("RDA Micro RTC driver");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.51.0
> 
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

