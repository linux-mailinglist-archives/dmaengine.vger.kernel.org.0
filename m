Return-Path: <dmaengine+bounces-6662-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEF2B8C11E
	for <lists+dmaengine@lfdr.de>; Sat, 20 Sep 2025 08:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118615A09AD
	for <lists+dmaengine@lfdr.de>; Sat, 20 Sep 2025 06:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA0C2EAB79;
	Sat, 20 Sep 2025 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Mu0WT1kU";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="sb2pc5UT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBE03D6F;
	Sat, 20 Sep 2025 06:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758351034; cv=none; b=etyPG6bG7utYNA6Gp/GMq49/ExhFATKLIx3agLJSh+fc9Wb14YMejPd0ybbZz+m0cn+pdG5qJTSk4y7U3zQikqCxxsnEr603c1Myz2Qw9yX6TnjnFy5mnoIUwycoGVp9llesglZ3UesgKdqIFI2NMbsu9fdd+v3Ufxyh2BQjklo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758351034; c=relaxed/simple;
	bh=MjWkIR76I1fTlnqtv2BmHI0tJUeHTaAgBYhO8/TTe4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BR2yb3zRAs8aMWgaedoVL5pIWVZFMpbJcRWo7Xu3+uPaYQnQPoNrczp32qT6avArTLgOnfHJ/aYLwztZYkO94AuZcrKHLk95WbvAT3zygOPPzf8gVMLYhN+SzdF2SKyE0VRU/g0QcbFsnJoDjlPqa68GoPxOWWrEhamq0uvKYSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Mu0WT1kU; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=sb2pc5UT; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1758350983; bh=AW17lv89eSJE61jE0VgMo7I
	K1f6MgMq0qzbJdrYGhAU=; b=Mu0WT1kUgl5cQlQ5PX2jRN2PMPq/dDr7fRG/j6P0q/F6ULS3KE
	xoivzs0uuNLw4YbnCqJ/RpZ/PfDofasRt6XK59LmkyQwhHfrYQs5bo3vCn4BfUfSMZCWKBpoxJV
	vMP/Z2Sr8hc2GauwgD00WGBgzerVfzWAzFlX2DTdBLXVaGuNIxQ6AhMRvo9an2gF8HJZ+IlipSj
	ZFbt0CEcr+vfPWQLXzlDP1a7ZwX8LCwXd9Zavc+fRk0VUvcp2Vr1vhIGSK2ElWRDGPsIfvXrcrb
	5MpdxFv/SmLCVSnaS9Ly+kcSIAagZt63ASSYPlG0/PYmKuYDp+HZCucRJi734fkCYdQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1758350983; bh=AW17lv89eSJE61jE0VgMo7I
	K1f6MgMq0qzbJdrYGhAU=; b=sb2pc5UTtihwQjvou4NnnaSmANU2soJblZAj9CMKygiR43FHTi
	g56bTIeDIQPJ5/5lGPQJtPn7nlgAN0FmJpBw==;
Date: Sat, 20 Sep 2025 13:49:34 +0700
From: Dang Huynh <dang.huynh@mainlining.org>
To: Conor Dooley <conor@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 05/25] dt-bindings: rtc: Add RDA Micro RDA8810PL RTC
Message-ID: <cr5gkkckxan2b2x23knfwb35a4ulngsp6gguqhcku3z6ghzkcn@cq4krj5qxy3r>
References: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org>
 <20250917-rda8810pl-drivers-v1-5-74866def1fe3@mainlining.org>
 <20250917-contort-sassy-df07fd7515a0@spud>
 <c905fb3ace281280f1ac11c7fbe8e0aa@mainlining.org>
 <20250918-unharmed-bloating-8b573513fce6@spud>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-unharmed-bloating-8b573513fce6@spud>

On Thu, Sep 18, 2025 at 04:18:25PM +0100, Conor Dooley wrote:
> On Thu, Sep 18, 2025 at 11:11:10AM +0700, Dang Huynh wrote:
> > On 2025-09-18 03:46, Conor Dooley wrote:
> > > On Wed, Sep 17, 2025 at 03:07:22AM +0700, Dang Huynh wrote:
> > > > Add documentation describing the RTC found in RDA8810PL SoC.
> > > > 
> > > > Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> > > > ---
> > > >  .../devicetree/bindings/rtc/rda,8810pl-rtc.yaml    | 30
> > > > ++++++++++++++++++++++
> > > >  1 file changed, 30 insertions(+)
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/rtc/rda,8810pl-rtc.yaml
> > > > b/Documentation/devicetree/bindings/rtc/rda,8810pl-rtc.yaml
> > > > new file mode 100644
> > > > index 0000000000000000000000000000000000000000..3ceae294921cc3211cd775d9b3890393196faf82
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/rtc/rda,8810pl-rtc.yaml
> > > > @@ -0,0 +1,30 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/rtc/rda,8810pl-rtc.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: RDA Micro RDA8810PL Real Time Clock
> > > > +
> > > > +maintainers:
> > > > +  - Dang Huynh <dang.huynh@mainlining.org>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: rda,8810pl-rtc
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > 
> > > Your driver implements functions that turn on an alarm irq, but there is
> > > none mentioned here. What's going on there?
> > The RTC doesn't seem to have an AP IRQ associated. I can't find any
> > reference to it on downstream kernel and the docs.
> > 
> > > 
> > > Additionally, there's no clocks property? For an onboard RTC I'd have
> > > expected there to be a clock sourced outside of the block.
> 
> What about the clock?
I'll fix this in v2.

> 
> > > 
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    rtc@1a06000 {
> > > > +      compatible = "rda,8810pl-rtc";
> > > > +      reg = <0x1a06000 0x1000>;
> > > > +    };
> > > > 
> > > > --
> > > > 2.51.0



