Return-Path: <dmaengine+bounces-5065-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 124F9AA9B8A
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 20:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1714D1895CF0
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 18:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744671624EA;
	Mon,  5 May 2025 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8cBZH+2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3834522087;
	Mon,  5 May 2025 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746469814; cv=none; b=Uly7CJCAhSxEH1vILS4IaYwrOvKhndnXdIELOaGTq2Wu0BnXTPIa2R+iAWCZ+yUH8+bTIPGSpAQmcu0Lmw6n/Qpnv33/Kga3/smnfwL6LWrjbq2NkYpFumza5X+oCpVk0UTFXSUjaV2xJbivQsWhUBCeanigI8d7YV7LYn/AkpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746469814; c=relaxed/simple;
	bh=OiLVPZCoeejwWN1jL9K41mNLLGiUljL3GcilhESEOU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J06nCWURo1MN6MeMvd0NbCOuXj1TYXhVjlttsCBuPT9dkmJ+jx+TtdffIQ6hy5qpdn+STi7chiwDjvsMpLdUPhcgAL050rBVdmJmxMhE1grlnFnivfPy7ClpJePswZikkwRBKSsvPnawyfvNqmUjGBTNwmZwcZ7suYpYi3ygzNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8cBZH+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED726C4CEE4;
	Mon,  5 May 2025 18:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746469813;
	bh=OiLVPZCoeejwWN1jL9K41mNLLGiUljL3GcilhESEOU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N8cBZH+27ciqDvOHNblhwoCAWao1ZtIMNm0D8rWXJkodPwlOYpF66dJztLWqctY9m
	 HjJRoBjLOJ+GbJOruJm+JdPwapHfm/6yBhH/F3wwxa1WJ5PuA1qKZDuh5iiXkPy48u
	 14N+ZCQywaERZvxzvGFpEOuB63MsswOWj5dt7Lf50xuoMmXRR3z6dlbi6yZmQLHLMK
	 xEnhOj2/IBeOy/+5YIvhX3eHlHw0rpXAum0o+jEmiNN9ESgyox2GcDSAAvfT/zxMXF
	 wsA1lGxTIlVeQ8p8hCofM2ciAGCF6oVohad9JKCLQ6nJPGYWxkwBPKEbQeVicerTut
	 WbAaZQ33NoxIg==
Date: Mon, 5 May 2025 19:30:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-clk@vger.kernel.org,
 linux-fpga@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, Stephen Boyd
 <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Moritz
 Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun
 <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, Vinod Koul
 <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck
 <linux@roeck-us.net>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?=
 =?UTF-8?B?Zw==?= <ukleinek@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, Mike Turquette
 <mturquette@linaro.org>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v4 3/7] include: linux: move adi-axi-common.h out of
 fpga
Message-ID: <20250505193001.1183e7cc@jic23-huawei>
In-Reply-To: <20250505-dev-axi-clkgen-limits-v4-3-3ad5124e19e1@analog.com>
References: <20250505-dev-axi-clkgen-limits-v4-0-3ad5124e19e1@analog.com>
	<20250505-dev-axi-clkgen-limits-v4-3-3ad5124e19e1@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 05 May 2025 17:41:34 +0100
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> The adi-axi-common.h header has some common defines used in various ADI
> IPs. However they are not specific for any fpga manager so it's
> questionable for the header to live under include/linux/fpga. Hence
> let's just move one directory up and update all users.
>=20
> Suggested-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # for IIO

> ---
>  drivers/clk/clk-axi-clkgen.c              | 2 ++
>  drivers/dma/dma-axi-dmac.c                | 2 +-
>  drivers/hwmon/axi-fan-control.c           | 2 +-
>  drivers/iio/adc/adi-axi-adc.c             | 3 +--
>  drivers/iio/dac/adi-axi-dac.c             | 2 +-
>  drivers/pwm/pwm-axi-pwmgen.c              | 2 +-
>  drivers/spi/spi-axi-spi-engine.c          | 2 +-
>  include/linux/{fpga =3D> }/adi-axi-common.h | 0
>  8 files changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> index 2a95f9b220234a1245024a821c50e1eb9c104ac9..31915f8f5565f2ef5d17c0b4a=
0c91a648005b3e6 100644
> --- a/drivers/clk/clk-axi-clkgen.c
> +++ b/drivers/clk/clk-axi-clkgen.c
> @@ -16,6 +16,8 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/err.h>
> =20
> +#include <linux/adi-axi-common.h>
> +
>  #define AXI_CLKGEN_V2_REG_RESET		0x40
>  #define AXI_CLKGEN_V2_REG_CLKSEL	0x44
>  #define AXI_CLKGEN_V2_REG_DRP_CNTRL	0x70
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 36943b0c6d603cbe38606b0d7bde02535f529a9a..5b06b0dc67ee12017c165bf81=
5fb7c0e1bf5abd8 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -6,6 +6,7 @@
>   *  Author: Lars-Peter Clausen <lars@metafoo.de>
>   */
> =20
> +#include <linux/adi-axi-common.h>
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/device.h>
> @@ -22,7 +23,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> -#include <linux/fpga/adi-axi-common.h>
> =20
>  #include <dt-bindings/dma/axi-dmac.h>
> =20
> diff --git a/drivers/hwmon/axi-fan-control.c b/drivers/hwmon/axi-fan-cont=
rol.c
> index 35c862eb158b0909dac64c2e9f51f0f9f0e8bf72..b7bb325c3ad966ed2a93be4df=
bf4e20661568509 100644
> --- a/drivers/hwmon/axi-fan-control.c
> +++ b/drivers/hwmon/axi-fan-control.c
> @@ -4,9 +4,9 @@
>   *
>   * Copyright 2019 Analog Devices Inc.
>   */
> +#include <linux/adi-axi-common.h>
>  #include <linux/bits.h>
>  #include <linux/clk.h>
> -#include <linux/fpga/adi-axi-common.h>
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/interrupt.h>
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index c7357601f0f869e57636f00bb1e26c059c3ab15c..87fa18f1ec96782556bdfad08=
bedb5e7549fb93d 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -6,6 +6,7 @@
>   * Copyright 2012-2020 Analog Devices Inc.
>   */
> =20
> +#include <linux/adi-axi-common.h>
>  #include <linux/bitfield.h>
>  #include <linux/cleanup.h>
>  #include <linux/clk.h>
> @@ -20,8 +21,6 @@
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> =20
> -#include <linux/fpga/adi-axi-common.h>
> -
>  #include <linux/iio/backend.h>
>  #include <linux/iio/buffer-dmaengine.h>
>  #include <linux/iio/buffer.h>
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> index b143f7ed6847277aeb49094627d90e5d95eed71c..581a2fe55a7fb35f1a03f96f3=
a0e95421d1583e7 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -5,6 +5,7 @@
>   *
>   * Copyright 2016-2024 Analog Devices Inc.
>   */
> +#include <linux/adi-axi-common.h>
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
>  #include <linux/cleanup.h>
> @@ -23,7 +24,6 @@
>  #include <linux/regmap.h>
>  #include <linux/units.h>
> =20
> -#include <linux/fpga/adi-axi-common.h>
>  #include <linux/iio/backend.h>
>  #include <linux/iio/buffer-dmaengine.h>
>  #include <linux/iio/buffer.h>
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> index 4259a0db9ff45808eecae28680473292d165d1f6..e720191e74558d15f1b04fa18=
cf2984299f88809 100644
> --- a/drivers/pwm/pwm-axi-pwmgen.c
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -18,10 +18,10 @@
>   * - Supports normal polarity. Does not support changing polarity.
>   * - On disable, the PWM output becomes low (inactive).
>   */
> +#include <linux/adi-axi-common.h>
>  #include <linux/bits.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> -#include <linux/fpga/adi-axi-common.h>
>  #include <linux/io.h>
>  #include <linux/minmax.h>
>  #include <linux/module.h>
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-e=
ngine.c
> index 7c252126b33ea83fe6a6e80c6cb87499243069f5..d498132f1ff6adf20639bf4a2=
1f1687903934bec 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -5,9 +5,9 @@
>   *  Author: Lars-Peter Clausen <lars@metafoo.de>
>   */
> =20
> +#include <linux/adi-axi-common.h>
>  #include <linux/clk.h>
>  #include <linux/completion.h>
> -#include <linux/fpga/adi-axi-common.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/adi-axi-=
common.h
> similarity index 100%
> rename from include/linux/fpga/adi-axi-common.h
> rename to include/linux/adi-axi-common.h
>=20


