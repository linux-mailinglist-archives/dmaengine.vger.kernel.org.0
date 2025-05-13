Return-Path: <dmaengine+bounces-5154-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 917E4AB4D75
	for <lists+dmaengine@lfdr.de>; Tue, 13 May 2025 09:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074151888B83
	for <lists+dmaengine@lfdr.de>; Tue, 13 May 2025 07:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C871F180E;
	Tue, 13 May 2025 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF35bCi+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8F71DED6D;
	Tue, 13 May 2025 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747123176; cv=none; b=tG48c/K5b++rlLu1dwBbp1G4qwM81rdlWZQYU3u4boTtkaV5jOXY1ZNvGPBIiXNK+0+8ZC1Xtu+3FCmujLKNgFmpcAUCATmbNdvJwn26/1seAx6mYRGtKwJA0dc9iu1EQJ6XocCpUGOF6ksVheLPWd9FSIXLH1+lqbUGtTwVZiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747123176; c=relaxed/simple;
	bh=zVQDiOX9CGuUmhYtJQXVsD42iRaEY3++AII5n41vnDE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cdGImiR7/lyZOJXQbfWxHtxT01XyItypUJKYbuDare7S2XsgQGwPfjZvtDTK06aaMeU0ZOvFDbZgOk++uWOHALot95qMIkmgNKnI+3WtqcnS+ulF7dk0c0RCa2R5RnB4qMakNQzCjOyLbt0fKXrspEQqfQ5hkd4FiPE0Gd/2bPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DF35bCi+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a1fa0d8884so2363728f8f.3;
        Tue, 13 May 2025 00:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747123173; x=1747727973; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o2Ki80ZABGEJg4AxOlmxgap7pzHGqhGsMpYaN6EjGbw=;
        b=DF35bCi+JZI2oiQzfDJmDpLeuSJmomrbBNJDAX8bHacY+bMJcGKQZDhWbCeN4/4iKW
         m/Dp2UkPlL8wGAzeFwAFg4/t08AQCq/mwJHi4O7N0CQl5PNy/1PQFhyhdResgi0xCVFx
         PeHcZA1R1H3nYZDoHTP1BOVxyLBpwHQgenaD6EcwY0dEx1/f4t7kXG98QJEKV9/hPp+n
         wvkbHzXEG+zWqvqepisl0sl/PIgg4zhSPvJcdz77oLtLNB7ScD+2Fj4WB6p+XcEzpj4m
         x+rGGjy1T+MtoHZ4IZ8icGDRWcLeVFG5LR3ws6yITnm1EYOYsDWMk9SQV5pKoAwh8yCM
         o2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747123173; x=1747727973;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o2Ki80ZABGEJg4AxOlmxgap7pzHGqhGsMpYaN6EjGbw=;
        b=o+7Pc7N/QkVRQRtuiOzDtuhfuq82n39TuqowGzUSFnR7IVQr+xQYNBWV4sTZnZPdNn
         dzyXgWQRKqgUyRth+OVfficnihR5QLIo/uURHn3qjAZ6vSKiPAJS7RtRDFAYYEmGJ00G
         NzURV/tEIZR1apL6kgOsALMJ8Oytbn5/8FCB/tB39hflOf8tgN1YZJ4GX5UZmNVxc0gB
         /3yC4cXziHw5m+FiQ+hipzDUdeFAdSrEvWGO04Dgclg0vgBzca7F4agXvvAfEp6dr+WH
         J8YxUA0fkmgk4Bp0707DRZnj4ZO3TFZNUvY63+Ug8ZQ7U+LkI6HK9e+DCDBXO77v6lJF
         3uRw==
X-Forwarded-Encrypted: i=1; AJvYcCUp0MyCJAhUBGDpYO2aq5cRXe4WbTWJLTY0hcoFOVM5Hx1WUnA6IuWbggaXsTzgIfXGcIhccltGAQb5@vger.kernel.org, AJvYcCVS/RzJ6EmrpG5eHHq8oGkTO1u0uRAExjltbqP8YTMFUoBQp6kvpQo+QH5vg12QUbJWEgBi8Z2PHJ1XMaQ=@vger.kernel.org, AJvYcCVsTBYEydLNKOBkCIvQaohm1ojajC32uJuyctIbvz1IG6bFz2jJztKpMr3FqKTwmmj1787AQ9D5JdFoJw==@vger.kernel.org, AJvYcCWIfd2fYPKKfG2rRJE95R9PVMAGME92PCjDvO6eVjzVI7i/eT/2KsTELFIi3q7t1pXqDR8YorOBr2qQ@vger.kernel.org, AJvYcCWOHFRk8W9L2YtsOUx8zszIehLGeFfyz8HwESIN+0GONJuYonW09Qk5wHiwUaKZ17d8BEByw4Fwa0Ra@vger.kernel.org, AJvYcCWqf1Ura1cAVfYokY16klMKy3SvRAIO5VLKZlGVgEQx9mGXyOCcq2dXuVTuD8AfPYBbsZq1p2GslrE=@vger.kernel.org, AJvYcCX7EyftZl8q4uGXAX0aAqVP2qqQqOAByx2UaKjWfDTGXUdPvgTUMwlGdhyHX1bX0AWmoAppNGpMu4L8@vger.kernel.org
X-Gm-Message-State: AOJu0YwpJKsLRpp7bHymeiKBeaf6lRCdGvYiG5ZY1W2xM37eKyy91L5h
	dugy1yYtoXHJSFnqfMXHFJIPI7nqJNf2AYbwBLiyAIy0/Q86ZDqO
X-Gm-Gg: ASbGncvZM6NaVi7BoQcfmQRhpBqhi12pKGEDKq2GkEjF/uLdAE/+w0qhQgWy8rbDrlU
	hhD3p2u2fxm/MUVDbSG3vnayxoO0hKrfyFxO4dK9nDF6QG/uHhjS1pA2+xEvpJNOgAwhKUXNqpV
	y1JKB2TBCX6ktRf7LNV/lH4rme4dw9ReZw1alyv9T/BJWq5b148LKmPF6Ds74TNDZvgDR1a3FVh
	eZodoDrSpBl7XaKU5gM9zOQ1VBxvWir24nNJg3/vJgCKaVTygnfhBni6HJlzT2VGQtrV5Usw+GY
	LAHelZBQQyuuIB8Pq9XJmzMKxM0q9RmAiRZyRrMG9TtkoaaDIWOMKlbrrB/q3Q2sCCbo+GkbM7N
	MGzDfABHQMALcyufoEQLXZpOj0Q==
X-Google-Smtp-Source: AGHT+IHVSjFApFWecKfyKzV3L2zKQlG2ldSYHxNj4NtNCLFuSKyvtc3joGoU0hu6Hbf4lfBZu9pEvg==
X-Received: by 2002:a05:6000:4008:b0:3a0:9fe1:c298 with SMTP id ffacd0b85a97d-3a1f6438efdmr13156979f8f.18.1747123173091;
        Tue, 13 May 2025 00:59:33 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd34bd84sm198145575e9.22.2025.05.13.00.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 00:59:32 -0700 (PDT)
Message-ID: <874de9179208e2724769cbba515b188e82962d62.camel@gmail.com>
Subject: Re: [PATCH v5 3/7] include: linux: move adi-axi-common.h out of fpga
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, 
 linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
 dmaengine@vger.kernel.org,  linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org,  linux-pwm@vger.kernel.org,
 linux-spi@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>,  Moritz Fischer <mdf@kernel.org>, Wu Hao
 <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,  Tom Rix
 <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare
 <jdelvare@suse.com>,  Guenter Roeck <linux@roeck-us.net>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Trevor
 Gamblin <tgamblin@baylibre.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>, Mark Brown <broonie@kernel.org>, Mike Turquette
 <mturquette@linaro.org>, Xu Yilun <yilun.xu@linux.intel.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>
Date: Tue, 13 May 2025 07:59:56 +0100
In-Reply-To: <44929bd2-4abf-4c7b-b3c0-382bd030800f@baylibre.com>
References: <20250512-dev-axi-clkgen-limits-v5-0-a86b9a368e05@analog.com>
	 <20250512-dev-axi-clkgen-limits-v5-3-a86b9a368e05@analog.com>
	 <44929bd2-4abf-4c7b-b3c0-382bd030800f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-12 at 10:15 -0500, David Lechner wrote:
> On 5/12/25 9:46 AM, Nuno S=C3=A1 via B4 Relay wrote:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > The adi-axi-common.h header has some common defines used in various ADI
> > IPs. However they are not specific for any fpga manager so it's
> > questionable for the header to live under include/linux/fpga. Hence
> > let's just move one directory up and update all users.
> >=20
> > Suggested-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Acked-by: Xu Yilun <yilun.xu@intel.com>
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # for IIO
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/clk/clk-axi-clkgen.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
> > =C2=A0drivers/dma/dma-axi-dmac.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > =C2=A0drivers/hwmon/axi-fan-control.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > =C2=A0drivers/iio/adc/adi-axi-adc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +--
> > =C2=A0drivers/iio/dac/adi-axi-dac.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > =C2=A0drivers/pwm/pwm-axi-pwmgen.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > =C2=A0drivers/spi/spi-axi-spi-engine.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > =C2=A0include/linux/{fpga =3D> }/adi-axi-common.h | 0
> > =C2=A08 files changed, 8 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.=
c
> > index
> > 2a95f9b220234a1245024a821c50e1eb9c104ac9..31915f8f5565f2ef5d17c0b4a0c91=
a648005b3e
> > 6 100644
> > --- a/drivers/clk/clk-axi-clkgen.c
> > +++ b/drivers/clk/clk-axi-clkgen.c
> > @@ -16,6 +16,8 @@
> > =C2=A0#include <linux/mod_devicetable.h>
> > =C2=A0#include <linux/err.h>
> > =C2=A0
> > +#include <linux/adi-axi-common.h>
> > +
>=20
> This one is adding, not changing. Was it supposed to be in a later patch?

Oh, indeed... This was "bot mode"...

- Nuno S=C3=A1
>=20
> > =C2=A0#define AXI_CLKGEN_V2_REG_RESET		0x40
> > =C2=A0#define AXI_CLKGEN_V2_REG_CLKSEL	0x44
> > =C2=A0#define AXI_CLKGEN_V2_REG_DRP_CNTRL	0x70


