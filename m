Return-Path: <dmaengine+bounces-4642-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4811A4E2F3
	for <lists+dmaengine@lfdr.de>; Tue,  4 Mar 2025 16:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02553177161
	for <lists+dmaengine@lfdr.de>; Tue,  4 Mar 2025 15:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA07286294;
	Tue,  4 Mar 2025 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGmDv4Qy"
X-Original-To: dmaengine@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9717C27F4D9
	for <dmaengine@vger.kernel.org>; Tue,  4 Mar 2025 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100958; cv=fail; b=Hq9KE22Be/wGOlYPSfZsOuqOIuLNqekRPoaWpF8zwiKZhjj5VjoVjtTNM+n7lvc8i5c34569s94+H3KhIu1JiOw8IrImnURE/ACu5kvKTgmsUHkHvfneKmyICZhwPeQzTpECa99gAr1b3yG8w3T3rPXD8Qoa6i0L6Bh7Z5T8gIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100958; c=relaxed/simple;
	bh=4Rr8+O3wDPGZk2pARDgzHZT5OsxtADYeUZjSZlkVi/4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=e1IyaMb4ZZ4PHjy9DuhS+3n7DnNhuTjZmO+de80otNL5zEfZ/dWWYM8HGGN5YMeRirrcTXy2VrYm+2qCsQSEPMWOdGNXEpG6nq1pCQdMI7gwLYhCexmLp8jPDhAZU45mLgDNOqjVrmd0U5z1fktaMKLvM9f33J960vDoA2SQ4l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGmDv4Qy reason="signature verification failed"; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id F100D40D5719
	for <dmaengine@vger.kernel.org>; Tue,  4 Mar 2025 18:09:14 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TGmDv4Qy
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fDj0Q9GzFyYx
	for <dmaengine@vger.kernel.org>; Tue,  4 Mar 2025 18:07:33 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 84CDC42720; Tue,  4 Mar 2025 18:07:21 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGmDv4Qy
X-Envelope-From: <linux-kernel+bounces-541779-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGmDv4Qy
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 5332A41B74
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:15:12 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 2C5F92DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:15:12 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0FB188E279
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8FF212FBE;
	Mon,  3 Mar 2025 13:14:28 +0000 (UTC)
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
Precedence: bulk
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
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fDj0Q9GzFyYx
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741705666.38621@IgOQFcyHkrKukG/kKAK9yQ
X-ITU-MailScanner-SpamCheck: not spam


On Fri, 28 Feb 2025 08:24:09 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
>=20
> This patch set adds support for the following systems in the SAMA7D65
> SoC:
> - DMAs
> - Chip ID
> - Dual watchdog timer.
>=20
> Changes v1 -> v2:
> - Removed pathes that have been accepted and applied from v1 [1].
> - Corrected missing newline in dt-binding.
> - Corrected mismatch in watchdog dt node.
>=20
> 1) https://lore.kernel.org/linux-arm-kernel/09eafe54-c262-4db4-b11d-064=
4a1f90a14@tuxon.dev/
>=20
> Ryan Wanner (2):
>   dt-bindings: watchdog: sama5d4-wdt: Add sama7d65-wdt
>   ARM: dts: microchip: sama7d65: Add watchdog for sama7d65
>=20
>  .../devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml    | 4 ++++
>  arch/arm/boot/dts/microchip/sama7d65.dtsi                  | 7 +++++++
>  2 files changed, 11 insertions(+)
>=20
> --
> 2.43.0
>=20
>=20
>=20


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=3Dy for arch/arm/boot/dts/microchip=
/' for cover.1740675317.git.Ryan.Wanner@microchip.com:

arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: watchdog@e001d00=
0: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/watchdog/atmel,sama5d4-wd=
t.yaml#
arch/arm/boot/dts/microchip/at91-dvk_som60.dtb: /ahb/apb/adc@f8018000: fa=
iled to match any schema with compatible: ['atmel,sama5d3-adc']
arch/arm/boot/dts/microchip/at91sam9g25-gardena-smart-gateway.dtb: nand-c=
ontroller: #address-cells: 1 was expected
	from schema $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#







