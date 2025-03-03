Return-Path: <dmaengine+bounces-4632-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57984A4C173
	for <lists+dmaengine@lfdr.de>; Mon,  3 Mar 2025 14:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73B03A763B
	for <lists+dmaengine@lfdr.de>; Mon,  3 Mar 2025 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64356212B15;
	Mon,  3 Mar 2025 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGmDv4Qy"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395BB212B0A;
	Mon,  3 Mar 2025 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007666; cv=none; b=UwHZNnuuZe6vt7V45C8137vf4uxCWM/Tcu4n3W5Vu8C3aKZ2yfjsUbGVFccoCWJYIf2HzNlkgNCrFMV6iMM6qsjA8XfvTBjPivr3IhWTgPzkSBnXkoNMLaklXYpKul13ro9xFEnLV60sUJL7u94fA7yHr7xIVNh268uMT909ku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007666; c=relaxed/simple;
	bh=FiWSvzkRIMYnufn/6j3BHnlJOVYfPeryI4S3GXt0vAc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=KgK2w1FEydzIwL04wsvM0N4lmt2qa0Zua2a/wUiRTgcWWoRXFLwOv//BRE3GNLa/wBc54ooG+FDVT7rm0sDoExzJb6Ss7EMhZDQal4eV4Y/NYfvW7E+4H6FHcvjb6KUHWsOccbyk4CvNHudC7dBMDH7pGGscEOGRZbvpDJNSS48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGmDv4Qy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98BBC4CEE9;
	Mon,  3 Mar 2025 13:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741007666;
	bh=FiWSvzkRIMYnufn/6j3BHnlJOVYfPeryI4S3GXt0vAc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=TGmDv4Qy0cdXTql42zoM9MZxyD+mzsNU84Gh2a9Bf7K6p/0qDRxKws68ZDFYHyWON
	 334fbrKihCSvqDRJGspPw/djb7ne82q3xjesrA1HfHtPYKLh+uHq4AUBa+U1W21glj
	 e5TM4yUFaV3LSXJYgJLVnlCHzktDkF5R2x2eLbVIgBHr6vJ8UMs4V2N3i/ZxSByZCr
	 +LHt2BQ6LdRwXX+N7gEsTHfI4yVgFToA8SUQwczwR7qXqArTYC98YLw1nU+ks3qvP/
	 KzNygSvESuVw7PKUv07+kfDwmhA+N5UwLVHM3xplqdt0imjVpHsVd3t2xOkMMa5xna
	 hBrhbq/qTUfLA==
Date: Mon, 03 Mar 2025 07:14:24 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: wim@linux-watchdog.org, krzk+dt@kernel.org, linux@roeck-us.net, 
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, claudiu.beznea@tuxon.dev, vkoul@kernel.org, 
 linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 conor+dt@kernel.org
To: Ryan.Wanner@microchip.com
In-Reply-To: <cover.1740675317.git.Ryan.Wanner@microchip.com>
References: <cover.1740675317.git.Ryan.Wanner@microchip.com>
Message-Id: <174100756391.1496568.10334189756404294750.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] Add System Components for Microchip SAMA7D65
 SoC


On Fri, 28 Feb 2025 08:24:09 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> This patch set adds support for the following systems in the SAMA7D65
> SoC:
> - DMAs
> - Chip ID
> - Dual watchdog timer.
> 
> Changes v1 -> v2:
> - Removed pathes that have been accepted and applied from v1 [1].
> - Corrected missing newline in dt-binding.
> - Corrected mismatch in watchdog dt node.
> 
> 1) https://lore.kernel.org/linux-arm-kernel/09eafe54-c262-4db4-b11d-0644a1f90a14@tuxon.dev/
> 
> Ryan Wanner (2):
>   dt-bindings: watchdog: sama5d4-wdt: Add sama7d65-wdt
>   ARM: dts: microchip: sama7d65: Add watchdog for sama7d65
> 
>  .../devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml    | 4 ++++
>  arch/arm/boot/dts/microchip/sama7d65.dtsi                  | 7 +++++++
>  2 files changed, 11 insertions(+)
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


New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/microchip/' for cover.1740675317.git.Ryan.Wanner@microchip.com:

arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: watchdog@e001d000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/watchdog/atmel,sama5d4-wdt.yaml#
arch/arm/boot/dts/microchip/at91-dvk_som60.dtb: /ahb/apb/adc@f8018000: failed to match any schema with compatible: ['atmel,sama5d3-adc']
arch/arm/boot/dts/microchip/at91sam9g25-gardena-smart-gateway.dtb: nand-controller: #address-cells: 1 was expected
	from schema $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#






