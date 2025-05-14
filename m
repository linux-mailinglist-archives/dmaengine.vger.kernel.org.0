Return-Path: <dmaengine+bounces-5171-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C628AB6ED5
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 17:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36FEC7ACF6D
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 15:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8B51CAA98;
	Wed, 14 May 2025 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoaE+ovG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E022E27E7C0;
	Wed, 14 May 2025 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234996; cv=none; b=gvV1t5BYCXh/UJTyJFHtG+A4tnSha18/Z0lBnQbtceuSk+zcvA/F7gLbXEBG6bEYAyGvMC+VPsZBhvg+9XZZN+AR4qKBs1hOFPBpTYuQ/DZU0gTGy+j933erSzhVR/lDDKlAmTWXgdMwCQ1NCPJbVXzpq9oYDgz73vWYzlos/6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234996; c=relaxed/simple;
	bh=m5xFf1VaS/qFqzTFJku5dhlZM/YKpT/P+Ikykc9C8I0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l7hV1+ZCe/ypLrc1eVuZSEjgAeRbewbZsei48QpMr+LWrNL3Fo9LK1k99dYqpgEqELegT87PJPeLFVWoipHdVrjvp93pr+UKly+cfb0U6ATCbnJPH8U87DRI6gCvK1QBOoZaDj7rjagtvsStjL3uvodCM5Ci4xeZgkyWYzLTLYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoaE+ovG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEBCC4CEED;
	Wed, 14 May 2025 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747234995;
	bh=m5xFf1VaS/qFqzTFJku5dhlZM/YKpT/P+Ikykc9C8I0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VoaE+ovGzsNijwqfZdX/jEeuQYTcJWGDbvwMZTzRxfWxS7z8d5dsaOSPaDJAbbKor
	 HO94fV94Om2HGf8M3lRa7io9q2u26fyQMXdt98M4ApaUb5CPNfp3EKCdb5x0XlcGtk
	 L2QQW01m82XMLzlzKIlhtwW2T+D8TEBzNXs/gbMs90yAB8a1DnCPkDFOZAx3ZKubba
	 4xrJoor/ORRk7IXm8z80yyWsdqtS0NokgHeEw3JGYDRalut3A/kaB140S/cAWegCWJ
	 dObCqFVpky1l8gsFkU3NsfsuiMb+GytkWYan7CLZNS7F2P2B2JgnMENT1SK0IFv8p/
	 63WdZoFWDyNKw==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <20250423143422.3747702-1-fabrizio.castro.jz@renesas.com>
References: <20250423143422.3747702-1-fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH v7 0/6] Add DMAC support to the RZ/V2H(P)
Message-Id: <174723499195.115803.16616657624244333565.b4-ty@kernel.org>
Date: Wed, 14 May 2025 16:03:11 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 23 Apr 2025 15:34:16 +0100, Fabrizio Castro wrote:
> This series adds DMAC support for the Renesas RZ/V2H(P) SoC.
> 
> Cheers,
> Fab
> 
> v6->v7:
> * Final touches to the RZ/V2H specific dt-bindings patch as per
>   Geert's comments.
> * Collected tags.
> v5->v6:
> * Reworked the RZ/V2H specific dt-bindings patch as per Geert's
>   comments.
> * Collected tags throughout.
> v4->v5:
> * Clock patch queued up for v6.15, therefore dropped from this
>   version of the series
> * Adjusted the dmac cell specification according to Geert's
>   comments
> * Removed registration of ACK No. throughout
> * Reworked DMAC driver as per Geert's comments
> v3->v4:
> * Fixed an issue with mid_rid/req_no/ack_no initialization
> v2->v3:
> * Replaced rzv2h_icu_register_dma_req_ack with
>   rzv2h_icu_register_dma_req_ack() in ICU patch changelog
> * Added dummy for rzv2h_icu_register_dma_req_ack()
> * Reworked DMAC driver as per Geert's suggestions.
> v1->v2:
> * Improved macros in ICU driver
> * Shared new macros between ICU driver and DMAC driver
> * Improved dt-bindings
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: dma: rz-dmac: Restrict properties for RZ/A1H
      commit: ec52f10a31dc69c1ded30812bd17335ac23b1c60
[2/6] dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family of SoCs
      commit: 22228b933ce2639d67168fd35423c1be196edab0
[3/6] irqchip/renesas-rzv2h: Add rzv2h_icu_register_dma_req()
      commit: 9002b75aa8e6f034ffbd1c1ccac46927a1cf0f12
[4/6] dmaengine: sh: rz-dmac: Allow for multiple DMACs
      commit: 056a8aac1fce52da9ad0b6488eb074e3846f37c0
[5/6] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
      commit: 7de873201c44bff5b42f2e560098d463843b8a4c
[6/6] arm64: dts: renesas: r9a09g057: Add DMAC nodes
      commit: 7d33e0ee5f98b3fc74566fa00d0926bc5deb8174

Best regards,
-- 
~Vinod



