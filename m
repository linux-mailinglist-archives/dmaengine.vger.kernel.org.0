Return-Path: <dmaengine+bounces-4541-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF223A3CCDD
	for <lists+dmaengine@lfdr.de>; Thu, 20 Feb 2025 00:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506663A9EF5
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 22:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D7B25B693;
	Wed, 19 Feb 2025 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueb9zaXD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784A824F5A0;
	Wed, 19 Feb 2025 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005998; cv=none; b=tbJcnKKqdU0+DdY3xhKbHOHm/03mu3So8VCILS4/Isa4VnCo3I2V5ByAmwgnNyd2nlXTA4y5uUs12JmnqjHa95VUbru3dzuh9pUF8663PL4uyE3lwbGkAYoqkch5BYsc06O1QmVFQjyBkuG87GOUaF1UXtxOBvuUOzGo9Ntq5MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005998; c=relaxed/simple;
	bh=GAeIj8FmQR0knadcmGgigmXGl4izDzATSQxm6mP/rGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+JBeVkO2f3wT3jwZRivCq1cEJmXnrtmP2Rdt3tl18gSQ1mSughBhksF1N0yflKNZ5UAyk2CyIdsBut/QZNV+XWi58QafetLlb9ryZVlhgqYuWOzSsvXSfzBnBqhzf7Z6bzAMwH7gNEuNCVUGd1W0W9xGTt5Fdjud+VCmdymTck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueb9zaXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF696C4CED1;
	Wed, 19 Feb 2025 22:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740005997;
	bh=GAeIj8FmQR0knadcmGgigmXGl4izDzATSQxm6mP/rGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ueb9zaXDZ361ZoSo0F5ov30MAW/Gn3Qi85zXJUHST/CtziaiTrmS2WRscB7H/dTpv
	 zN7OuwNn4UhOf824Ob3fWzYzGLbUwtaX53JOOROaj3q7mcQoSUQklfyApzM0WM+UaV
	 QQlQXX7qlRC/EGBugvPt8AE2iFOp7lXv8yjrIC7Cq4GLwwxtdm1S4aB6R8m6Tv+LkL
	 PE9h81sZ5pCZfixa5Qpz296zbBiXUAaltYLRr0J5q6k+QV6YioeqZVkzYZYVEc5RIu
	 xm1uV1mt+2Z9Ih9k7d7zqQ9r+oDozYtz1ipfiF5Ubqs278IQpAICflrNM1j60EQj/p
	 2HZcdpEbjq9OQ==
Date: Wed, 19 Feb 2025 16:59:56 -0600
From: Rob Herring <robh@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Ryan.Wanner@microchip.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	vkoul@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: watchdog: sama5d4-wdt: Add sama7d65-wdt
Message-ID: <20250219225956.GA3127467-robh@kernel.org>
References: <cover.1739555984.git.Ryan.Wanner@microchip.com>
 <3c55e634f2993ac5a49e1b8bfceb2333e175d376.1739555984.git.Ryan.Wanner@microchip.com>
 <a1ebb518-ff69-4dff-a8b4-7c3b716450a5@tuxon.dev>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1ebb518-ff69-4dff-a8b4-7c3b716450a5@tuxon.dev>

On Tue, Feb 18, 2025 at 10:42:36AM +0200, Claudiu Beznea wrote:
> 
> 
> On 14.02.2025 20:08, Ryan.Wanner@microchip.com wrote:
> > From: Ryan Wanner <Ryan.Wanner@microchip.com>
> > 
> > Add microchip,sama7d65-wdt compatible string to the dt-binding documentation.
> > 
> > Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> > ---
> >  .../devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml        | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> > index cdf87db361837..e9c026194d403 100644
> > --- a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> > +++ b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> > @@ -23,6 +23,9 @@ properties:
> >            - const: microchip,sam9x7-wdt
> >            - const: microchip,sam9x60-wdt
> >
> 
> You could have keep this new line after the items section that you've added.
> 
> > +      - items:
> > +          - const: microchip,sama7d65-wdt
> > +          - const: microchip,sama7g5-wdt
> 
> here.

Please do.

> 
> >    reg:
> >      maxItems: 1
> >  
> 

