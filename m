Return-Path: <dmaengine+bounces-5163-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED9FAB6EBB
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 17:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4086C4C3D73
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 15:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285BE1B424A;
	Wed, 14 May 2025 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6x5PZt/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE90D194A44;
	Wed, 14 May 2025 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234976; cv=none; b=MhV2uG8h1hmmk4WnCms06IcamCqayX7UM5Of0Je+jtYnGMXLg216QhHDinUeJdoxivCDo4czbjbUG9k8Yu+tFNw9Evknm22wa0O/Zgn/tW1g5A4+eDcdCUM/VhSut8h/s9H7Vo3R/Q/DkEL+E4zJP9TxWofYcOsWvkDjo/raYcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234976; c=relaxed/simple;
	bh=iR7Lb9hQDeqA8HuTsx6n4WKA1nTEaMPSviN3JG5WKI4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jq7Kg1USDeT+OYb5yZbIFjxlaJT074yLuA3x+FA9fSOClmu5SMwlhUz/e17SdPkEK2z4WAOBijvxdlTc74pYM6h1SIwXEB6Mz2HtoKwRafVh1/p1EbSRQOEnBDt/GXGia03iwDJJ3XQKQVrQ9HLYru+2QRVEh0rrfkjmdDogCDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6x5PZt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06454C4CEE3;
	Wed, 14 May 2025 15:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747234975;
	bh=iR7Lb9hQDeqA8HuTsx6n4WKA1nTEaMPSviN3JG5WKI4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=L6x5PZt/CXC8i+BJp0BTxgk3XeVkVMhc8o9i0VqsGL0B6aZU8J2EPcqAgSbA7ugVD
	 3wO9NM9+cUePYzw6AD7FhkMEWSjbBzzBb2KSTAgpzqYwxQslPLYmgWJ3pNx8M6QDRE
	 GzuucBQuEGkUMzpd/hTdPsO9yrQhVKYRKjG/itOUkfNRimm5OYjWsk0+JOF3V8UU8A
	 T2LpIcUIO8uOyPX+wCD6A78+827qgw71gp6SylN/2ApFg2G6LwI51v4jnR5kl8tqJy
	 JpsncNFeKsGjh34Mbv+G48dGRyWsE+GWhrH2K5xVkzenwY95aWFNHKgCzecWYJ3yYN
	 tdF73HzawBzhw==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <20250422173937.3722875-1-fabrizio.castro.jz@renesas.com>
References: <20250422173937.3722875-1-fabrizio.castro.jz@renesas.com>
Subject: Re: (subset) [PATCH v6 0/6] Add DMAC support to the RZ/V2H(P)
Message-Id: <174723497166.115803.2774078282550893427.b4-ty@kernel.org>
Date: Wed, 14 May 2025 16:02:51 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 22 Apr 2025 18:39:31 +0100, Fabrizio Castro wrote:
> This series adds DMAC support for the Renesas RZ/V2H(P) SoC.
> 
> Cheers,
> Fab
> 
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

[2/6] dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family of SoCs
      commit: 22228b933ce2639d67168fd35423c1be196edab0

Best regards,
-- 
~Vinod



