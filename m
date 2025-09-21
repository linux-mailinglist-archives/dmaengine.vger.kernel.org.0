Return-Path: <dmaengine+bounces-6671-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1371B8E1B8
	for <lists+dmaengine@lfdr.de>; Sun, 21 Sep 2025 19:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8713A3AE8E4
	for <lists+dmaengine@lfdr.de>; Sun, 21 Sep 2025 17:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951CA26B2CE;
	Sun, 21 Sep 2025 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOYQNGMq"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5834E18EB0;
	Sun, 21 Sep 2025 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758475705; cv=none; b=soiyGGZIUrhEfJC16kLHapW3e5N62fiUiReq5oG13YRh6afjMWikWGxGYfUVDpiLp0oXtzz58M9xoy5LhcuT60ThCOU+Z7X77rRBWw+wg+9rdkmFQodHlK8/nOu6E1cr/Nq5deqjNvmRg/4u6lO2RVS0nGWcVIdeN9ZumiqGcUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758475705; c=relaxed/simple;
	bh=Y6OyRC8OGepucwPmVPz8/FQHQQPr31PG9hXtFpeOmaw=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=Tpix3gWOJBbv8GLdwYcngHoYQ1hkG9p2BoyxrFeWEAzec3BoGTaPruOhnMNQs+psrdWRGuTqi23hEKQBIvwf//zLdZZGgoob70hvjy+SnKXzOP3bKSj6/n+1D8J3NIPfI1C5dQ0N0jOSMWaLNA/dmydy5tOSE6TJr2iFfRK6FZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOYQNGMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4779C4CEE7;
	Sun, 21 Sep 2025 17:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758475704;
	bh=Y6OyRC8OGepucwPmVPz8/FQHQQPr31PG9hXtFpeOmaw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=rOYQNGMquh9OWSN3UTmPtZ+0v9OeRM33ySEUj3+3H51CcaaVxyhzTUntAK1g4gGQH
	 ZS7hCzCrCoQY0pC9TxVc5cFNWASi7ZByo+3UATC6fUebH635fNI13yjaed4MhY3Ogb
	 Xi7O4rvMLZbzBLaYss6nQ0CL4aGg8soSI7499vnSGby+INaT4k1mZZapzy1jPlmaeg
	 LkRTab9X3Eb1AsRD3HKd6iLIYktg1uv+qzFpmLRt+c3eXBboKiFc6pWcRP4siw425T
	 HuWTRBzU8ddPAgukP6FH1qiRXNZGK5BShMFBbSeI5kmXCE22BYPcpfrjL3pAFavfPz
	 2NB0GEV8pJOFw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250627-dev-axi-clkgen-limits-v7-0-e4f3b1f76189@analog.com>
References: <20250627-dev-axi-clkgen-limits-v7-0-e4f3b1f76189@analog.com>
Subject: Re: [PATCH RESEND v7 0/7] clk: clk-axi-clkgen: improvements and some fixes
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>, Xu Yilun <yilun.xu@linux.intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Nuno =?utf-8?q?S=C3=A1?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>, dmaengine@vger.kernel.org, linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, nuno.sa@analog.com
Date: Sun, 21 Sep 2025 10:28:23 -0700
Message-ID: <175847570323.4354.7019519707280531872@lazor>
User-Agent: alot/0.11

Quoting Nuno S=C3=A1 via B4 Relay (2025-06-27 07:59:09)
> This series starts with a small fix and then a bunch of small
> improvements. The main change though is to allow detecting of
> struct axi_clkgen_limits during probe().
> ---
> Changes in v7:
>  - Just include new tags.
>=20
> - Link to v6: https://lore.kernel.org/r/20250519-dev-axi-clkgen-limits-v6=
-0-bc4b3b61d1d4@analog.com
> - Link to v5: https://lore.kernel.org/r/20250512-dev-axi-clkgen-limits-v5=
-0-a86b9a368e05@analog.com
> - Link to v4: https://lore.kernel.org/r/20250505-dev-axi-clkgen-limits-v4=
-0-3ad5124e19e1@analog.com
> - Link to v3: https://lore.kernel.org/r/20250421-dev-axi-clkgen-limits-v3=
-0-4203b4fed2c9@analog.com
> - Link to v2: https://lore.kernel.org/r/20250313-dev-axi-clkgen-limits-v2=
-0-173ae2ad6311@analog.com
> - Link to v1: https://lore.kernel.org/r/20250219-dev-axi-clkgen-limits-v1=
-0-26f7ef14cd9c@analog.com
>=20
> ---
> Nuno S=C3=A1 (7):
>       clk: clk-axi-clkgen: fix fpfd_max frequency for zynq
>       clk: clk-axi-clkgen: make sure to include mod_devicetable.h
>       include: linux: move adi-axi-common.h out of fpga
>       include: adi-axi-common: add new helper macros
>       clk: clk-axi-clkgen: detect axi_clkgen_limits at runtime
>       clk: clk-axi-clkgen move to min/max()
>       clk: clk-axi-clkgen: fix coding style issues

What is the merge strategy for this series?

>=20
>=20
>  drivers/clk/clk-axi-clkgen.c        | 159 +++++++++++++++++++++++++-----=
------
>  drivers/dma/dma-axi-dmac.c          |   2 +-
>  drivers/hwmon/axi-fan-control.c     |   2 +-
>  drivers/iio/adc/adi-axi-adc.c       |   3 +-
>  drivers/iio/dac/adi-axi-dac.c       |   2 +-
>  drivers/pwm/pwm-axi-pwmgen.c        |   2 +-
>  drivers/spi/spi-axi-spi-engine.c    |   2 +-
>  include/linux/adi-axi-common.h      |  56 +++++++++++++
>  include/linux/fpga/adi-axi-common.h |  23 ------
>  9 files changed, 174 insertions(+), 77 deletions(-)
> ---
> base-commit: 82f69876ef45ad66c0b114b786c7c6ac0f6a4580
> change-id: 20250218-dev-axi-clkgen-limits-63fb0c5ec38b

