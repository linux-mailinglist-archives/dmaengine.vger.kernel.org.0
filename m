Return-Path: <dmaengine+bounces-5062-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4137BAA9A4B
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 19:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D083A61C3
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 17:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC9526A0E2;
	Mon,  5 May 2025 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Xt3gdcLq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376E4269AF9
	for <dmaengine@vger.kernel.org>; Mon,  5 May 2025 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746465677; cv=none; b=hJdS5whYr6HvzLxm4ABVTwHRuQcnQnJH1YJBW63oF4E+vaKSjApZUVKr0cTYgCGdSb+PBkMYnOdF2Me7rzkrulntyxj2WM1TY0Dr5f999n4buyeKEz2iaV+aHgce4hhVLo7eP27u6TAojohd2IMk+pmLT8N6Tx8d3B4yIiCIKDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746465677; c=relaxed/simple;
	bh=ED0YEr0axl5zx/4gKF6UrVnXHUt5MRwQZrtasEJIvN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fs9SRyGotop5jzj8B5hXMGLeB5N7V4XChczq8zNsx+PfT8CC3HNFyc8FAd6vFk8uQHy17qKtJZLWTdfcvXOnFsKylUMVyf9Aoj+qrCWocPrVR5raWVANCAD1qvqeJ7NEiX9RWezN5V5iFbGbbnftAj878hXXWvuYuMi2qAbWrn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Xt3gdcLq; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-606330df903so1251506eaf.0
        for <dmaengine@vger.kernel.org>; Mon, 05 May 2025 10:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746465674; x=1747070474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/G+nBnNesW1TDGe9R775N3Td+u+vfQ6F72XRRWzOa0=;
        b=Xt3gdcLqIK0AP5dFYU2TLbBxeDa/TAnxULksakBJHQNQFLs3qzLgDwi8F+1XGo3NxX
         R0PV/p6yYWyZLddHxP5m/SA0kHOK4njge0WD981pdkho2Lx1jKGOpoL73cm+lbtj82Gm
         3Rusl09vLPBvdnkb6WzchcQoBtbMspHPINYFjoKxuP8WXqC7bPrJnT510vTYUXtrqXNv
         upgoncQerKPOWiMuZoGcpBEoEOImYdL5SVR3kLLl8hOv2VBQPhzazRnzSA6YvNo6EK88
         1ouyu0UxgmMH3ghd27VsZ+qMZJVqHgM/FnL4zhBEIpQRQmkm4tg39aouYyGNNpAdNE9q
         2KFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746465674; x=1747070474;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/G+nBnNesW1TDGe9R775N3Td+u+vfQ6F72XRRWzOa0=;
        b=WhdTgl3/6AO9M8l/TfFzV6E2+4HjSZjftWBND7HmPFVJtU00xwg+zdIXtvyhG5VYJb
         jnurCJzUszh+rynflGBqCGT5rnRw0XaFSeXVF+XB5dP7ogGiAXKhChKboUw7JT4yax4K
         1ZRUDuXlpndIBYy3XOhkRexT6Gi+ikoNvvbmWBQIYW7q6/4xTo9USenooC/tT4HEv/1q
         uf81nRCSlGj55yzCU65iL9WZHKAIHayQBWLXWmOWQtNT2kXxGzrAN2FPwrQdypWjWhZB
         QEiVbh7yEZAif1NdtCOUZm3kh3P87jQB6+JlYLDYnArdqnfogvl148GsAMzmmhehDnzN
         w2Tw==
X-Forwarded-Encrypted: i=1; AJvYcCW+0ANRuHqjcqA6Ruz509GtAY9CpO7GR+dpT6EHK/dPfTmxu6/kdnJUx4vA68yzmN0WR3pSkJUUq5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIdGShitfefWody8dG3kPc0/yix2Pnx0r3Pba0qgHDsbgUHbhm
	BaOz7YmvJdW4p0Qi057AUUfqI95w7JQ0nc+qAhzfayCDleR079pFm861+/ut8qw=
X-Gm-Gg: ASbGnctbSRzqg5bemsQKR22zBlgdDEiN4Kf75GVn2bMRi4xZET15JeO64y+lwPG87dt
	VI8y5HfjO+dHC9Aolm1ByTAMeYle8sOuE+A5HHLPTew/UHIiG6sX1a3EfAmeEug04p6pBy8WaP/
	yfgsvNEw+FSH4AI2DOlPl2phf2WOU6GN/E0pLjLxZLO2PJipvuFfqOP6su5cha/z1KOiVXUAV39
	sKl9JlmNmUzBLlEVq1rGmCvE6XPCXM/7ElB8tXKrW613AiiP406Gs3TLVSgUdWO+9gkRKr9euib
	mDGcu7CoG436WBDWPY8rjy+AeTawlLUwbLZ49G0Xobma1dmmLgMEoWCpEYx4PeISrwbEstFzUus
	+WeeIsuclOeM5fOM=
X-Google-Smtp-Source: AGHT+IE/IoVpJPAJ8LqGJDHQZ7X4gmy2K04E7oj2S0s4rKeDTv7fvaB2eoCocspZ2xh2Gh0s5XTIOQ==
X-Received: by 2002:a05:6870:91d3:b0:2d5:cb5:2193 with SMTP id 586e51a60fabf-2db391b23b2mr162206fac.35.1746465674086;
        Mon, 05 May 2025 10:21:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:2151:6806:9b7:545d? ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-731d31a23c5sm1590259a34.8.2025.05.05.10.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 10:21:13 -0700 (PDT)
Message-ID: <79c256ab-3d21-481c-ab9d-eca643d3d998@baylibre.com>
Date: Mon, 5 May 2025 12:21:12 -0500
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] include: fpga: adi-axi-common: add new helper
 macros
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
 Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>
References: <20250505-dev-axi-clkgen-limits-v4-0-3ad5124e19e1@analog.com>
 <20250505-dev-axi-clkgen-limits-v4-4-3ad5124e19e1@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250505-dev-axi-clkgen-limits-v4-4-3ad5124e19e1@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/5/25 11:41 AM, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> Add new helper macros and enums to help identifying the platform and some
> characteristics of it at runtime.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  include/linux/adi-axi-common.h | 35 +++++++++++++++++++++++++++++++++++

Since this file was moved in the previous patch, should we drop "fpga:" from the
subject of this patch?

>  1 file changed, 35 insertions(+)
> 
> diff --git a/include/linux/adi-axi-common.h b/include/linux/adi-axi-common.h
> index 141ac3f251e6f256526812b9d55cd440a2a46e76..a832ef9b37473ca339a2a2ff8a4a5716d428fd29 100644
> --- a/include/linux/adi-axi-common.h
> +++ b/include/linux/adi-axi-common.h
> @@ -12,6 +12,8 @@
>  #define ADI_AXI_COMMON_H_
>  
>  #define ADI_AXI_REG_VERSION			0x0000
> +#define ADI_AXI_REG_FPGA_INFO			0x001C
> +#define ADI_AXI_REG_FPGA_VOLTAGE		0x0140

Doesn't the voltage register only apply to AXI CLKGEN and therefore would
belong in the clock driver rather than here? 0x1C seems to be the last of the
defined "common to all IP cores" address before we possibly get into
core-specific register definitions starting at 0x40.

I guess there are 1 or 2 other cores that define it at the same place, but it
still seems not-global.

>  
>  #define ADI_AXI_PCORE_VER(major, minor, patch)	\
>  	(((major) << 16) | ((minor) << 8) | (patch))
> @@ -20,4 +22,37 @@
>  #define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
>  #define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
>  
> +#define ADI_AXI_INFO_FPGA_TECH(info)            (((info) >> 24) & 0xff)
> +#define ADI_AXI_INFO_FPGA_FAMILY(info)          (((info) >> 16) & 0xff)
> +#define ADI_AXI_INFO_FPGA_SPEED_GRADE(info)     (((info) >> 8) & 0xff)

I guess we don't care about the DEV_PACKAGE field?

> +#define ADI_AXI_INFO_FPGA_VOLTAGE(val)          ((val) & 0xffff)

This VOLTAGE also goes applies to the first comment.


