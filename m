Return-Path: <dmaengine+bounces-4187-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 886B7A1B274
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2025 10:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D360816537A
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2025 09:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1BE1DB137;
	Fri, 24 Jan 2025 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="VFQJCpZK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7752F320B;
	Fri, 24 Jan 2025 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737710276; cv=none; b=clix2xhAVhfR2yIslf2LNhV0jKmcOypHciHyRjlMMREZA/JOVnoV6RoZp9FygYE4lrHbc1bs5Ua6+izNJUCcDnbZNMWBl2CYu5GmJpBxyTGp3EoN0ebs07V1rbOcZkAiFcvI6IsFHHxx99KI3tg5kAxe8kbrqgcGT3yo0RWOtPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737710276; c=relaxed/simple;
	bh=5iaD945UFs16M0VLUKCVVeiefXEYpCmIw2bvVfwkn5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKiHO5LUuQdySR6xHWD+jcT4cpPfIckkCNZ+vmwCdBM1S3b3QiKChaTxvgb0Pr5/Ua0qzGlE/2UF4sg2tiW0EH7Vp2XoOUzhSDi+tvJtp4ianKxqnhldDULAKi276c3mjnW91NSwrggzGA6cTjaa4D5WXqJQX1Xr1Dt+DUuM8Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=VFQJCpZK; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87EBB148468B;
	Fri, 24 Jan 2025 10:08:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1737709705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TDGL1Yo9WUa7EYaDeq6rKMNtM8TcEfBcdKsVKLdb84=;
	b=VFQJCpZKT4v2bWICHiuu78a9CGYgUp1sr7cnCedBloWdD6GWPAXnghsRSedlkPBeZ7gcDX
	3wMP5P5oZWvn1VZHiyIumpvTQulgLLDXlJ3kIxxBomhPYNKkAqeHZek3r0NUFmZzoUcidw
	c3ghwwguuC8kmP9MsfzNUBzQ4GF1gDmzEbtjGTAzt0ymipFgDK2eGzhXE/CKbuBj/hWCXZ
	aeukNE8V+gGxqOO9gEpk2vRFFdWop9cagbY3oiqnaImpqy06e9aD2J9EW0/a+oOcZ43uxb
	8sUG8VcCvNUD7W+sCamjNgpw9iX29qjLnafEEteCBlXQBO8VJ7WxXt0QFbHJgQ==
Date: Fri, 24 Jan 2025 10:08:21 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Varshini Rajendran <varshini.rajendran@microchip.com>,
	Alexander Dahl <ada@thorsis.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Add more devm_ functions to simplify probe path
 in drivers/spi/atmel-quadspi.c
Message-ID: <20250124-stumble-unpeeled-165f2211dcfb@thorsis.com>
Mail-Followup-To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>,
	Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Varshini Rajendran <varshini.rajendran@microchip.com>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250124085221.766303-4-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250124085221.766303-4-csokas.bence@prolan.hu>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello,

Am Fri, Jan 24, 2025 at 09:52:16AM +0100 schrieb Bence Csókás:
> The probe function of the atmel-quadspi driver got quite convoluted,
> especially since the addition of SAMA7G5 support, that was forward-ported
> from an older vendor kernel. To alleivate this - and similar problems in
> the future - an effort was made to migrate as many functions as possible,
> to their devm_ managed counterparts. The few functions, which did not yet
> have a devm_ variant, are added in patch 1 and 2 of this series. Patch 3
> and 4 then use these APIs to simplify and fix the probe() function.
> 
> Change in v2: rebased onto Linus' master, which is:
> commit bc8198dc7ebc ("Merge tag 'sched_ext-for-6.14' of
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext")

You can pass '--base master' or '--base=auto' to `git format-patch`
which adds a machine readable line to your patch or cover letter like
this:

base-commit: bc8198dc7ebc492ec3e9fa1617dcdfbe98e73b17

This way tools can find out which commit your series was based on.
See for reasoning:

https://people.kernel.org/monsieuricon/all-patches-must-include-base-commit-info

I'll look into your patch series in February, after my holidays.

Greets
Alex

