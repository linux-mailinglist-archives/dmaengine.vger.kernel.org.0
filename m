Return-Path: <dmaengine+bounces-4528-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBB5A3AD56
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 01:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0936E175E3D
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 00:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA8C19DF6A;
	Wed, 19 Feb 2025 00:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7DXt187"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC3A19D882;
	Wed, 19 Feb 2025 00:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739925748; cv=none; b=dDaxdQxcn1jBJKn1CyDvFE5asQOWZOMbMOIZ8eidpjnfSYvbXsk2Hqpvi6KsmxkLlJiDDhCE9712d0GkGXrJMWVf4nPIPmjGy+Mc216Q09NhlYUGjBRQNlO/9MZhdO+QZI5iRLgwEjHz2/AlTXwHh8HhY6vT7pgwg/P6OP71I+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739925748; c=relaxed/simple;
	bh=MCUZvMnjI+St/xxB98n3RdGdbJTQ9UD808hd20KqjPs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=RY+mGwwkPWVq8uXjZ7EysOEaCyGEGRgNQu8i7mQiL/LC216DN8bWikePvMl3qBxqshJfwKaFz/00BGniTFKYgSWLC4AzNwEwyOESJy6SaYC0eMleJoO/P6SOD0VI8eEKNywoMusJzFV7R8NvhuU57WR0Ws9T15XHdRC6/90Bvwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7DXt187; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AD0C4CEE2;
	Wed, 19 Feb 2025 00:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739925747;
	bh=MCUZvMnjI+St/xxB98n3RdGdbJTQ9UD808hd20KqjPs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=g7DXt187wHzs6lpJOBkSrmxvJy6EAno2kUlthlhPsgMhUKij1NDLsEfj8cya5mDQY
	 xfC1EOHc+knjSm5CH8o6khCn3rDz2NHfnSE1uk2Qhc0hgf/ydW3G8jOlCJqaoDh/DE
	 bc0jKanWKe7hYDToKMjh65tWXzRmnzM8mDRiG4lFQSpbSLOYX3R3wmn9HaeIzD+mTg
	 oyMiTZcjyshGu2hKWv44TdS1ze0xfKxFxZ9MmE1s4ru/Cbm6PDzEmVvzm0XHx3eEP2
	 O+Ti7sW763NoQQ1FeaEFJD+QH9Cae6SX5W/BN13rUrJaVeSUbodBzH2kJ1IjtMwMj8
	 Hni1nopfxMlfg==
Date: Tue, 18 Feb 2025 18:42:26 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, dmaengine@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux@roeck-us.net, vkoul@kernel.org, 
 wim@linux-watchdog.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com, 
 claudiu.beznea@tuxon.dev, alexandre.belloni@bootlin.com, 
 devicetree@vger.kernel.org
To: Ryan.Wanner@microchip.com
In-Reply-To: <cover.1739555984.git.Ryan.Wanner@microchip.com>
References: <cover.1739555984.git.Ryan.Wanner@microchip.com>
Message-Id: <173992516786.2065578.832520865805552342.robh@kernel.org>
Subject: Re: [PATCH 0/8]  Add System Components for Microchip SAMA7D65 SoC


On Fri, 14 Feb 2025 11:08:13 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> This patch set adds support for the following systems in the SAMA7D65
> SoC:
> - DMAs
> - Chip ID
> - Dual watchdog timer.
> 
> Ryan Wanner (8):
>   dt-bindings: atmel-sysreg: Add SAMA7D65 Chip ID
>   dt-bindings: watchdog: sama5d4-wdt: Add sama7d65-wdt
>   dt-bindings: dma: atmel: add microchip,sama7d65-dma
>   ARM: at91: Add Support in SoC driver for SAMA7D65
>   ARM: dts: microchip: sama7d65: Add chipID for sama7d65
>   ARM: dts: microchip: sama7d65: Add watchdog for sama7d65
>   ARM: dts: microchip: sama7d65: Add DMAs to sama7d65 SoC
>   ARM: dts: microchip: sama7d65: Enable DMAs
> 
>  .../devicetree/bindings/arm/atmel-sysregs.txt |  1 +
>  .../bindings/dma/atmel,sama5d4-dma.yaml       |  3 ++
>  .../bindings/watchdog/atmel,sama5d4-wdt.yaml  |  3 ++
>  .../dts/microchip/at91-sama7d65_curiosity.dts | 12 +++++
>  arch/arm/boot/dts/microchip/sama7d65.dtsi     | 44 +++++++++++++++++++
>  drivers/soc/atmel/soc.c                       |  5 +++
>  drivers/soc/atmel/soc.h                       |  3 ++
>  7 files changed, 71 insertions(+)
> 
> --
> 2.43.0
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/microchip/' for cover.1739555984.git.Ryan.Wanner@microchip.com:

arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: watchdog@e001d180: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/watchdog/atmel,sama5d4-wdt.yaml#
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/chipid@e0020000: failed to match any schema with compatible: ['microchip,sama7d65-chipid']






