Return-Path: <dmaengine+bounces-3416-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EA09ABE66
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 08:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CCA284FB8
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 06:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DDE145323;
	Wed, 23 Oct 2024 06:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X82Z5W4g"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4F51BC4E;
	Wed, 23 Oct 2024 06:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729663696; cv=none; b=C1N71S7oaLv5rs6N0Q2boA2eh3s21jX+/N+1ylei1ESJMgX46jXjbpF7ED+AI+qNUC3ihEp7dRYuHHFfvh6yq4JrhTOiQJb8g1ZDCCRPjj31cm6FEP57ZPMCBarLPEfclPSYvGAQUVCkSABuovcxm7Ogr66EzHh1BxrqPIVVwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729663696; c=relaxed/simple;
	bh=j4XMlJCKKl/NCp8f3DD3ZgpEl3aj4KSw7rw+sv4iyB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaT2rMPkUejWVJYSGZwq3X13RPz6J8U9wA9v6tRMdcZZVCXWAtp/wpPYngYpzG9mQ9MWZK2rxwR6XWF2PDS7D/CtML6RZr3yJ7wXxp5VsBKODu6bCraXkQ4HtPoqt/2RIdCMRiy0tfdiDfwVNRjeytNwnbt4JHck8Wl5wYJ+Vfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X82Z5W4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29111C4CEC6;
	Wed, 23 Oct 2024 06:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729663695;
	bh=j4XMlJCKKl/NCp8f3DD3ZgpEl3aj4KSw7rw+sv4iyB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X82Z5W4gyo0iAwJOPV2j9Pr7vNlIie3ww7Npft8tTl1O06r02076tsqUUPxILhjpd
	 j4qTPGr2XpszinTEn8nOC2QWiJ1hVJ5IOyYYoa5VOxoMIAJPXrc6NQUeaZ+XC9k4rt
	 aYyGModaYkn6PKKAsg0lTiHEBMGjTwka/l+ggL17d66f8wE9xyR8HagCXjHxvNTvCj
	 KexLmt5m7h8ehk9nIYQGWqOzSWwXHrDEzpdObd374g/uE5nHMCA+2A9GzM22ywY3J7
	 9oznCHM1t8xg898ahtONtwrqq0T0D8Gd0ugZrrDp4dIrlWjgeH5yA6fbuYE4ZwbBX2
	 ttdfRjUa0cVCw==
Date: Wed, 23 Oct 2024 11:38:11 +0530
From: Vinod Koul <vkoul@kernel.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: Mesih Kilinc <mesihkilinc@gmail.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: Re: [RFC PATCH 00/10] Add support for DMA and audio codec of F1C100s
Message-ID: <ZxiSywkxggKboVRF@vaman>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
 <13ab5cec-25e5-4e82-b956-5c154641d7ab@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13ab5cec-25e5-4e82-b956-5c154641d7ab@prolan.hu>

On 23-10-24, 00:52, Csókás Bence wrote:
> Hi,
> I was trying to get audio on the F1C200s, but so far had no luck, and I came
> across this series.
> 
> On 2018. 12. 02. 22:23, Mesih Kilinc wrote:
> > This is RFC patchset for Allwinner suniv F1C100s to support DMA and
> > audio codec.
> > 
> > Allwinner F1C100s has a audio codec that has necessary digital and
> > analog parts. It has r-l headphone output and microphone, line, r-l
> > FM inputs. ADC can capture any inputs and also output channels via mux.
> > Any input channels or DAC samples can feed output channels.
> > 
> > Add support for this audio codec.
> > 
> > F1C100s utilizes DMA channels to send and receive ADC-DAC samples. So
> > DMA support needed. Patch 1~5 adds support for DMA. Suniv F1C100s has
> > very similar DMA to sun4i. But there is some dissimilarities also.
> > Suniv features a DMA reset bit in clock  control unit. It has smaller
> > number of DMA channels. Several registers has different addresses.
> > It's max burst size is 4 instead of 8. Also DMA endpoint numbers are
> > different.
> > 
> > Patch 6 adds DMA max burst option to sun4i-codec.
> > 
> > Patch 7~8 Add support for suniv F1C100s audio codec.
> > 
> > Patch 9 adds audio codec to suniv-f1c100s.dtsi
> > 
> > Patch 10 adds audio codec support to Lichee Pi Nano board.
> > Thanks!
> > 
> > Mesih Kilinc (10):
> >    dma-engine: sun4i: Add a quirk to support different chips
> >    dma-engine: sun4i: Add has_reset option to quirk
> >    dt-bindings: dmaengine: Add Allwinner suniv F1C100s DMA
> >    dma-engine: sun4i: Add support for Allwinner suniv F1C100s
> >    ARM: dts: suniv: f1c100s: Add support for DMA
> >    ASoC: sun4i-codec: Add DMA Max Burst field
> >    dt-bindigs: sound: Add Allwinner suniv F1C100s Audio Codec
> >    ASoC: sun4i-codec: Add support for Allwinner suniv F1C100s
> >    ARM: dts: suniv: f1c100s: Add support for Audio Codec
> >    ARM: dts: suniv: f1c100s: Activate Audio Codec for Lichee Pi Nano
> > 
> >   .../devicetree/bindings/dma/sun4i-dma.txt          |   4 +-
> >   .../devicetree/bindings/sound/sun4i-codec.txt      |   5 +
> >   arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts  |   8 +
> >   arch/arm/boot/dts/suniv-f1c100s.dtsi               |  25 ++
> >   drivers/dma/Kconfig                                |   4 +-
> >   drivers/dma/sun4i-dma.c                            | 221 ++++++++++--
> >   sound/soc/sunxi/sun4i-codec.c                      | 371 ++++++++++++++++++++-
> >   7 files changed, 601 insertions(+), 37 deletions(-)
> 
> What's the status of this series? I see that it was not merged, despite
> getting a few ACKs and only a few minor comments. Ripard's comments make me
> believe that the sun4i DMA driver should be able to handle the suniv family
> with minimal adjustments, have those not been added? Or is it that the DMA
> support is ready but the ALSA/ASoC support is missing?

Maybe split the series and post dma and audio parts separately for review

-- 
~Vinod

