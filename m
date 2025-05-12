Return-Path: <dmaengine+bounces-5141-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2C3AB3BC4
	for <lists+dmaengine@lfdr.de>; Mon, 12 May 2025 17:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4021A7A9C7C
	for <lists+dmaengine@lfdr.de>; Mon, 12 May 2025 15:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA8481720;
	Mon, 12 May 2025 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NPkMYGdq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C0B1DE8A8
	for <dmaengine@vger.kernel.org>; Mon, 12 May 2025 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747062945; cv=none; b=AXzmrdxgquGNZpFSPi7TLlpHMky2KusPKPcSHJ7nbKKpEkMX/eK/uZRPhdAnYf7ReJ9T/WcJadIM1OWtiqu0JUPU9HVeACmfGJwl8o8Uw6OTt5d3fX6TISO+qOHXlDbVdaeifNisqzqkzWHZU9vyZh2b5IUAGynkkVfCYzz6Oaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747062945; c=relaxed/simple;
	bh=zF4PQS8RQFM30N3ao4kEuN2RsoQHNBfVK/8QGFaitO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IF4ELBE2mvZrtT5yXXBAESklrYqAW4kMbtvXtme9Oj16G6LbpDXfmxSU8OYoUElVelf2UkENucl55qRroRP0QR5HcvH7a+QEyuNeM9miKmD42fLxBPtV91wtNW06odr5zofh8Ug9CsFNp5YdquwlzbXTEVEmUF0FMMD75iuKIF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NPkMYGdq; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-30a8cbddca4so5229661a91.3
        for <dmaengine@vger.kernel.org>; Mon, 12 May 2025 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747062943; x=1747667743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d0n+Mfncf1dF7UbdvMh/Y3Vkt6ppEmOAhKQI7/Xctfs=;
        b=NPkMYGdqygEadNa9LBxCCsLaDWqp4GRfS8Ph/xx/qGxOGPd6hDtfGyacyAIcTs026J
         XJSoBBNAt5MhW+Ef40nJeLNLyYIq0IPafG8V/XqKhS7RAQUdxaQ7ZDj29uzdzT8esr4Y
         QfdsgqR63ugM64JgjPrM/r0nO3DgiRIhFkE6OcwINl9E10F2f+9iN9bN9dz2axCXfs7t
         Rgd9WAV1o/WeEORfTBRaCAMoC1DOhD+cZUcSGhwXhg5izye20HxjlROwGjLgGYOkAlCy
         C5S2GJWp/HDi0W5vvyT+FAAjmnOPikPwo+VfsbGnWY73IoV43GXQVQqNaNDRWSumS2Ff
         Bxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747062943; x=1747667743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0n+Mfncf1dF7UbdvMh/Y3Vkt6ppEmOAhKQI7/Xctfs=;
        b=jVQR/nnb1tZVarApDRTV5Ya2j4SIciO3NvjM9Md7Ki5NIvfjYT4VtHXXSOFeN+3wcX
         aevGAkHCiSUC/QIRf/ieB/DW9MtIupEVNtJWYSDCV0xLuv6Posmo/AyZ3Cw1XJAu8hxH
         EHTTqMmGRCMxlxtmlkifv/ACgYLBuUnQ6G3wZEn8ULXllDN4TGQIpRdZ6jc0VSHvcWha
         nJqfwINoMBU1I7PORpPpn7ZEw+9J/w3OznIGxR5Sguh9U9y29MzF6StpLoVyVjekibM/
         iqj9F2RN39tz4wMq4PeFUHBjW7DvVdmT0Ly5Lw3/E1aN0MJomTYZJn1iym1QkBthR8fG
         ed3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZzt1aAjlKYbbVzAxziVw+Pg5FUAFq53S4cECzm4KqcyJbFKZuqnH2BJQFhRMkWkcOAMynbxTqrFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXLngrGTVYGvu2oV0MImFjvykhciB2Ua/o+cgjegoMNCOQoaTY
	lXBXdSalSOtWgti/u+P3QOFLuPY8PwD32lnw377Wcbxfh7le4Xkz2wuXR8V7VO9hawjhuT7mNdU
	A
X-Gm-Gg: ASbGncti36seixRwwfcdhgjLBwWciqE1MCDWyyZXwS3TUGOnc1UDyywe+cKkNwrofbx
	fpcKxj5HEwC8IY7d2VgzUT0E8J9n9wSFy/0PucBeXiatuAkBGkKDLs9dwyaKnuXK+MDIXrLC3T0
	8Ngex5ei2Y/ziDVhHjmBLq+X7Z2KQjpjTpVZv/w1KczuEyhSXpU9HzBDRGh9SNSAjpkmECl0H2a
	OPexw/JzxJWTCPyDbIHhjOptjTeA1xAnExUtmsyPVU0ji6vEak2vRi2xBAxH9d4t7yQDSVDdCtT
	DL22gXCubU1O+NFNx0Xob5YUX6CYxkOcPVbBAXUzhauJlKK+XLk8W0tQe2/8WT0u0pyn+evgATY
	18hUd8yzB19wrfi5SZy1rJTKsgVQh
X-Google-Smtp-Source: AGHT+IHZGDRNs+8vOMkC0p04fQzG/ssmfSh7XZKqv3ixjm0TN3TuT3LuzzKvBaCQb7HZ2b2RSV9r0w==
X-Received: by 2002:a05:6808:1582:b0:400:fa6b:dc93 with SMTP id 5614622812f47-4037fec216emr8370575b6e.39.1747062932740;
        Mon, 12 May 2025 08:15:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314? ([2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-403802d369fsm1565218b6e.17.2025.05.12.08.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 08:15:31 -0700 (PDT)
Message-ID: <44929bd2-4abf-4c7b-b3c0-382bd030800f@baylibre.com>
Date: Mon, 12 May 2025 10:15:29 -0500
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] include: linux: move adi-axi-common.h out of fpga
To: nuno.sa@analog.com, linux-clk@vger.kernel.org,
 linux-fpga@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Moritz Fischer
 <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250512-dev-axi-clkgen-limits-v5-0-a86b9a368e05@analog.com>
 <20250512-dev-axi-clkgen-limits-v5-3-a86b9a368e05@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250512-dev-axi-clkgen-limits-v5-3-a86b9a368e05@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/12/25 9:46 AM, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> The adi-axi-common.h header has some common defines used in various ADI
> IPs. However they are not specific for any fpga manager so it's
> questionable for the header to live under include/linux/fpga. Hence
> let's just move one directory up and update all users.
> 
> Suggested-by: Xu Yilun <yilun.xu@linux.intel.com>
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # for IIO
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/clk/clk-axi-clkgen.c              | 2 ++
>  drivers/dma/dma-axi-dmac.c                | 2 +-
>  drivers/hwmon/axi-fan-control.c           | 2 +-
>  drivers/iio/adc/adi-axi-adc.c             | 3 +--
>  drivers/iio/dac/adi-axi-dac.c             | 2 +-
>  drivers/pwm/pwm-axi-pwmgen.c              | 2 +-
>  drivers/spi/spi-axi-spi-engine.c          | 2 +-
>  include/linux/{fpga => }/adi-axi-common.h | 0
>  8 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> index 2a95f9b220234a1245024a821c50e1eb9c104ac9..31915f8f5565f2ef5d17c0b4a0c91a648005b3e6 100644
> --- a/drivers/clk/clk-axi-clkgen.c
> +++ b/drivers/clk/clk-axi-clkgen.c
> @@ -16,6 +16,8 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/err.h>
>  
> +#include <linux/adi-axi-common.h>
> +

This one is adding, not changing. Was it supposed to be in a later patch?

>  #define AXI_CLKGEN_V2_REG_RESET		0x40
>  #define AXI_CLKGEN_V2_REG_CLKSEL	0x44
>  #define AXI_CLKGEN_V2_REG_DRP_CNTRL	0x70

