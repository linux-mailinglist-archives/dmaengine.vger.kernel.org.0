Return-Path: <dmaengine+bounces-800-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E73837E1F
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 02:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67011C23D01
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 01:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA405579B;
	Tue, 23 Jan 2024 00:39:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10AA50A75;
	Tue, 23 Jan 2024 00:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970392; cv=none; b=nW/1Chat5ysNXFeNvk+egfUHqv2zqbsPJVMl9bHheD+9z+nYW0l8ymA3lsQpr8/mVU41gTMatXUiQEEY6+EBJd7bRRvcmfL5dSfDVc5Qsio4GrvGnRlsiJh85GWBGfburiqPdQUbJpYr//DRF74ONPkY2SC+wAF/xcISi0RvoSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970392; c=relaxed/simple;
	bh=/c8wDG5UxtxoAwAuatiMUYKoX68PJuZG3V53bYgLges=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzdR2nZhzwYDaP5df9moU6W1A0DVEz8Hr+aLED6YVTzJrj+i71jG3JNyWco8/eGUqhIMrTvIq7tifAtPA4sDwwufFq/dib7oL/cJjx4Npmyqj8s1oWM8b34GPd8zKO3L5WOJZ+/JKwwu6FYqT8Z598dUouDLfQWizdvEf5QYQ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C93DE1FB;
	Mon, 22 Jan 2024 16:40:34 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C62203F73F;
	Mon, 22 Jan 2024 16:39:46 -0800 (PST)
Date: Tue, 23 Jan 2024 00:38:53 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-sound@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] ASoC: sunxi: sun4i-spdif: Add support for Allwinner
 H616
Message-ID: <20240123003853.3da2ff57@minigeek.lan>
In-Reply-To: <20240122170518.3090814-4-wens@kernel.org>
References: <20240122170518.3090814-1-wens@kernel.org>
	<20240122170518.3090814-4-wens@kernel.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 01:05:14 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

Hi Chen-Yu,

thanks for posting this!

> From: Chen-Yu Tsai <wens@csie.org>
> 
> The SPDIF hardware block found in the H616 SoC has the same layout as
> the one found in the H6 SoC, except that it is missing the receiver
> side.
> 
> Since the driver currently only supports the transmit function, support
> for the H616 is identical to what is currently done for the H6.

I compared the OWA manual sections of the H6 and the H616 manuals, and
can confirm that indeed the H616 is the same as the H6, minus the RX
part:

> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  sound/soc/sunxi/sun4i-spdif.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
> index 702386823d17..f41c30955857 100644
> --- a/sound/soc/sunxi/sun4i-spdif.c
> +++ b/sound/soc/sunxi/sun4i-spdif.c
> @@ -577,6 +577,11 @@ static const struct of_device_id sun4i_spdif_of_match[] = {
>  		.compatible = "allwinner,sun50i-h6-spdif",
>  		.data = &sun50i_h6_spdif_quirks,
>  	},
> +	{
> +		.compatible = "allwinner,sun50i-h616-spdif",
> +		/* Essentially the same as the H6, but without RX */
> +		.data = &sun50i_h6_spdif_quirks,
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sun4i_spdif_of_match);


