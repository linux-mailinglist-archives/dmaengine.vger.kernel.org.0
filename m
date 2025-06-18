Return-Path: <dmaengine+bounces-5533-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A633FADED17
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jun 2025 14:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF10A16BAC5
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jun 2025 12:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F1D274FC2;
	Wed, 18 Jun 2025 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vooGQp+c"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18BF2E54C7
	for <dmaengine@vger.kernel.org>; Wed, 18 Jun 2025 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750251429; cv=none; b=oZ6eAxulBDN5qWthW5H6vTr8QmBcUzoP72ymbHwEcPBh2pXFdQqrpHf8VVo+kbS2Xbo2jcgQ40ECOyrCoZUnUB3Dm03g0oO4GRaF+BTcPb2e8zpWsI8MxgJ2jkEYzN+Og+t4Sswi8ChHLy10b1WfkgEbO3r3bYG99+QE3i2Qlso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750251429; c=relaxed/simple;
	bh=chU3ZzgX8ixQ80XuNsDpy9w595hkOFK6g+6/L8GwJwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJ/FoaeaEdgrqAV4+vU5mV76D4fB79D05Fe90z81zJXnSjIeUG6oQc07ucFsqIKwU/om0dfTeOz0vqkoR8FD0zCKOyvadFI0gXZAPF7oFSRQOeEcDwuBIXKFR3GjH3rJZLQ4CbC4AoXXY8iBtw8gjeKsxNNUzK2OZNrcm/BK2m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vooGQp+c; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e7d9d480e6cso5201259276.2
        for <dmaengine@vger.kernel.org>; Wed, 18 Jun 2025 05:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750251427; x=1750856227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2X2h53UoNZQhDXBsMhRcUUHtA/t5wbotkmy7UVTkX7E=;
        b=vooGQp+cXA7Bl9EdDFb5l+L/SbQXuI4V5FZ0RzgjuAXNy2/KAcAyg2o0IWDzripkkE
         tBcO61mGf6On7hilM9Kk8BA7p/r54kdadUGCT7+RjJWLFtKtD49Ey3xovothllGuoj/4
         cxXsMsagUqhtNDY9xe3IgmmjXPfqYXJqlV92vCEkihxdk3DWBzTR13Wc9w9peHStJI3V
         2RGg4jkTHOtGpN/1nexrUJ0QdBXUzSHI/I18yISa6Mx4qaxv6QSZzxrY1VkWUzOfo/r6
         IL7vbyCJIta0JWgxjWOjrHPMkACNqcs8A1MbsIp1o40U5q2UIjPOipsV3G9Vi/CcrE/r
         7Gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750251427; x=1750856227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2X2h53UoNZQhDXBsMhRcUUHtA/t5wbotkmy7UVTkX7E=;
        b=VNKRLTtZ/Oi9E5uw/RGdJ6mCzr6pJxQ+5gKjwJh4/PsKVvb692Xiw+ORoCfsBP9twL
         3S47dGkpgyU+nWEGmerCELYB8S7GgVdnm0nrJfKhRtK6BZJ1WDMy9dhRu3/Z7OyZKfko
         d2C2AxB2gEcEHsNxBMyRxNzY51A2PG1dJuLblrM8ArioeHiX3tM83K0ECNIY2sBBat/E
         dgfN2d+TmDY38MOo+ue8cj0N7Mf7SSTu/xjy2H5UEJPImdMiLAeFVa81z5hdvzrHitpZ
         qByaOQJbSFIFiLaEMGLJOmAgDwLqs+Mc8ZODOiJ0aMFfzZeqAOJekOxl10qs5sG1Xv3p
         DJyg==
X-Forwarded-Encrypted: i=1; AJvYcCUdbHM5bvh873+xyKREswchp9PsMf8Kyt2qRUoZNgRG5htl6DwLnNGVVCiEQwj3yQYXR3NM4ukuSN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFsU9Y3y+skLUBnM0WV3cwuKWhnTacgymCMikatHDhfcmL5tOV
	MPt11T+Mg4PY8ySgurtzxfjgpjA0o1/coJpCOcRb1+oAZnv9WDyPVD3ZHgDk20O93SBqUZzLxqC
	h0EZ7WXKOeWfyJRFKO6ap2ooFLxgsftLgg0zDDm8YCQ==
X-Gm-Gg: ASbGnctEENcU8PNC+rXL6H7PnRFCKqNdrUfpGNekySLoF1uyDFdaq6K0CKxztTNGEay
	7bylVl5ZlRpE9DaqxuaXOH4xywUjzMLi18WR3tcBHvvPxRYHvAtsrqjFDm2e1evkAE7XwuxD6jI
	gsTb2Isl9UtAJbZkOSpuzLzD9E9d3/a//pSbXEVqVAxRQ=
X-Google-Smtp-Source: AGHT+IEZlf2SkQ6pDtcOhhdvV3LmUw3iR0H22QpguHg1V4liWBddtmQy97+4HMMAxIbIevgaVnIrB0SHGsEYRyBVYzQ=
X-Received: by 2002:a05:6902:6303:b0:e82:2b85:ea3a with SMTP id
 3f1490d57ef6-e822b85ee43mr16723424276.32.1750251426746; Wed, 18 Jun 2025
 05:57:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612-apple-kconfig-defconfig-v1-0-0e6f9cb512c1@kernel.org> <20250612-apple-kconfig-defconfig-v1-1-0e6f9cb512c1@kernel.org>
In-Reply-To: <20250612-apple-kconfig-defconfig-v1-1-0e6f9cb512c1@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 18 Jun 2025 14:56:30 +0200
X-Gm-Features: AX0GCFsnEI_9cu3U9fY7I_D0EnrNerJPcmhYfg39LAqv66uN774UfRLbAU6VCkM
Message-ID: <CAPDyKFrQ3Uj+coa0WCG00_pyaxu-yEnH26qmS6tevZ_772oZVg@mail.gmail.com>
Subject: Re: [PATCH 01/11] pmdomain: apple: Drop default ARCH_APPLE in Kconfig
To: Sven Peter <sven@kernel.org>
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
	=?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-i2c@vger.kernel.org, iommu@lists.linux.dev, linux-input@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Jun 2025 at 23:12, Sven Peter <sven@kernel.org> wrote:
>
> When the first driver for Apple Silicon was upstreamed we accidentally
> included `default ARCH_APPLE` in its Kconfig which then spread to almost
> every subsequent driver. As soon as ARCH_APPLE is set to y this will
> pull in many drivers as built-ins which is not what we want.
> Thus, drop `default ARCH_APPLE` from Kconfig.
>
> Signed-off-by: Sven Peter <sven@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/apple/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pmdomain/apple/Kconfig b/drivers/pmdomain/apple/Kconfig
> index 12237cbcfaa983083367bad70b1b54ded9ac9824..a8973f8057fba74cd3e8c7d15cd2972081c6697d 100644
> --- a/drivers/pmdomain/apple/Kconfig
> +++ b/drivers/pmdomain/apple/Kconfig
> @@ -9,7 +9,6 @@ config APPLE_PMGR_PWRSTATE
>         select MFD_SYSCON
>         select PM_GENERIC_DOMAINS
>         select RESET_CONTROLLER
> -       default ARCH_APPLE
>         help
>           The PMGR block in Apple SoCs provides high-level power state
>           controls for SoC devices. This driver manages them through the
>
> --
> 2.34.1
>
>

