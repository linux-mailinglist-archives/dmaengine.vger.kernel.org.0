Return-Path: <dmaengine+bounces-6612-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB470B82DDC
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 06:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70CC416C3DE
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 04:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B78241CB2;
	Thu, 18 Sep 2025 04:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ShVjJBDQ";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="yG/LBgVK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8D334BA4C;
	Thu, 18 Sep 2025 04:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758168987; cv=none; b=mg9ORFruJRQzuiEq0NbNbEA0yJXjZfFX8EzmLHjWa3nYuZYyU1FTbk7l9ba6WSvuT6GMJmTNMpYKIAHAdL/DoTKBuXpZohg/NfHv2DLA/IeKXY/SF0Vbj9GiO6rSxtc8XHl8OGngnc9UnWJJNWKNpN/4mVFZiU9FVxc/YBNSR5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758168987; c=relaxed/simple;
	bh=BVY8Xj4e6MAs5x7hg6qQchNUfdSkglsNbtbLEad+y00=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=sYB70M0zifBu51S+ZR0NwSgPahL1BhDbP/XrT8MpzAZME4Lsz8eQeNmNc9kcJDdAP+Aivo5TqZLQFhQKzAZZ7Lsu9z/75P5q3Vyjk9QBygIvbywVPdCjsekU3CQrW8H6eJym4iNPbGPxbuxoIuJZ+5qR1pKt0mvYjvqPAFD3jv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ShVjJBDQ; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=yG/LBgVK; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1758168671; bh=NJjbSSj5jhMk0HRinPCbRwY
	9CFU4h6QcLpjE9fG/CGw=; b=ShVjJBDQtkoHl4zZviJw22Cn95HrMuMYoejLcf0xJzeQA7qKuJ
	D5qGCh0b0urde73kHsIhQh0EsyeFnt6xLrCS4Wai/5YtjmNkkyeT1cTVXMvpBVRGs6RPCbRYT5d
	KTQGQJbCq0HAA7aFbdsJbn+LX9CWR3mBsbAH5qHi+tbZeV4TPnjuZF1/f7ExusA6J2edVGY2bxx
	XVh5ikQM3M4YuTAjivkFueiiTHxKhDNx0/PTewZ1HIP9kvQNpLjdZXXG4rVFwOslOgHB/JYldjK
	OrVBQcOpVrOBMP7JPbckmUd1ygtraryn8HSnmM5jtXDJK4g7dnltryNpoL/GlzGe03Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1758168671; bh=NJjbSSj5jhMk0HRinPCbRwY
	9CFU4h6QcLpjE9fG/CGw=; b=yG/LBgVK91WyVeVJYLDzq2LIwSsiLwpyegB0yLgC8ixqUZuUMP
	oEKedmOlTd3bIbX2/d7CiHNj6juQ1b/PrEAQ==;
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 18 Sep 2025 11:11:10 +0700
From: Dang Huynh <dang.huynh@mainlining.org>
To: Conor Dooley <conor@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Sebastian Reichel <sre@kernel.org>, Vinod Koul
 <vkoul@kernel.org>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-mmc@vger.kernel.org
Subject: Re: [PATCH 05/25] dt-bindings: rtc: Add RDA Micro RDA8810PL RTC
In-Reply-To: <20250917-contort-sassy-df07fd7515a0@spud>
References: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org>
 <20250917-rda8810pl-drivers-v1-5-74866def1fe3@mainlining.org>
 <20250917-contort-sassy-df07fd7515a0@spud>
Message-ID: <c905fb3ace281280f1ac11c7fbe8e0aa@mainlining.org>
X-Sender: dang.huynh@mainlining.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-18 03:46, Conor Dooley wrote:
> On Wed, Sep 17, 2025 at 03:07:22AM +0700, Dang Huynh wrote:
>> Add documentation describing the RTC found in RDA8810PL SoC.
>> 
>> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
>> ---
>>  .../devicetree/bindings/rtc/rda,8810pl-rtc.yaml    | 30 
>> ++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/rtc/rda,8810pl-rtc.yaml 
>> b/Documentation/devicetree/bindings/rtc/rda,8810pl-rtc.yaml
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..3ceae294921cc3211cd775d9b3890393196faf82
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rtc/rda,8810pl-rtc.yaml
>> @@ -0,0 +1,30 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/rtc/rda,8810pl-rtc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: RDA Micro RDA8810PL Real Time Clock
>> +
>> +maintainers:
>> +  - Dang Huynh <dang.huynh@mainlining.org>
>> +
>> +properties:
>> +  compatible:
>> +    const: rda,8810pl-rtc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
> 
> Your driver implements functions that turn on an alarm irq, but there 
> is
> none mentioned here. What's going on there?
The RTC doesn't seem to have an AP IRQ associated. I can't find any
reference to it on downstream kernel and the docs.

> 
> Additionally, there's no clocks property? For an onboard RTC I'd have
> expected there to be a clock sourced outside of the block.
> 
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    rtc@1a06000 {
>> +      compatible = "rda,8810pl-rtc";
>> +      reg = <0x1a06000 0x1000>;
>> +    };
>> 
>> --
>> 2.51.0

