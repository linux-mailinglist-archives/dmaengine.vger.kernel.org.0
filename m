Return-Path: <dmaengine+bounces-6678-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E885BB926E9
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 19:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5E22A6D9D
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 17:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24F4313E3B;
	Mon, 22 Sep 2025 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir755y/U"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F168126F0A;
	Mon, 22 Sep 2025 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562182; cv=none; b=IHply4sGMNH1x3RTvB1XPad4BjTdMQnwAckc0G/YvB4Sd1cPvXO2JOvY1z3vndDdMYIksDyIbCnMjizkydu4xn2DAsVKrKiAF8Tqyh4UwbE7yhyBaWWO4SpPjfKSiaq7pJA+zEiHIONXAfJ/H2f6EjsCVcmQSbr2y8Pi2gVUjco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562182; c=relaxed/simple;
	bh=K/Qpa2ZzUrfkH4XTwu0ZRDbtZ4B/GhvgJeY/9kLT1io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knDAZPLXKbAsgN3Ln4Lyl7yk5zaRIcBdOMLg7MMJoUSlDbQjNwaLDOE3sMIBJpb1fKC+vdNfxa3vb63jFFjljN2DuzGlY1Vwo2XW2d55BU7kXSkFOlpoWLgY33OIkLVvag5sqPnhgOsGUW4DTG59ZEgC9ttmmKpKpb7T+G4D1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir755y/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136EEC4CEF0;
	Mon, 22 Sep 2025 17:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758562182;
	bh=K/Qpa2ZzUrfkH4XTwu0ZRDbtZ4B/GhvgJeY/9kLT1io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ir755y/U6mFPdgo1dcGviCBDhxs4h7quyB+H5YAsO7sCRJyB9+TMKNiyouRj0u1Hu
	 OKPi4ybjXRSh1gvHvZ8uz7YvqjjIBruIOFfF7oLkzl12ZWxCTu3R6JArrnKSvQPYKI
	 U/7d/6UWmY7VehDcHKozqwHRL3Sjb90C2BLcoNtXofpZ6VRIyIGy//oKoFIDve1LW3
	 mnGkqLLi/oY7iCBTxQYw8E68TRTIqXIYqP0JFckZQB9uZAbsVlsSg53kHHeRkQWP7k
	 +w/kVgoEeaKEwvSwOJOUrUMlPXRxR7Gnyx/VJJOHjKZq4T/JKU8bIBM7sglBjdJG0U
	 zbVm2cYnWOwvw==
Date: Mon, 22 Sep 2025 12:29:41 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Sheetal ." <sheetal@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>, linux-tegra@vger.kernel.org,
	linux-sound@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Sameer Pujar <spujar@nvidia.com>, dmaengine@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: dma: Update ADMA bindings for tegra264
Message-ID: <175856218049.506615.12343384310941956562.robh@kernel.org>
References: <20250918102009.1519588-1-sheetal@nvidia.com>
 <20250918102009.1519588-2-sheetal@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918102009.1519588-2-sheetal@nvidia.com>


On Thu, 18 Sep 2025 15:50:06 +0530, Sheetal . wrote:
> From: sheetal <sheetal@nvidia.com>
> 
> - Update ADMA device tree bindings for tegra264 to support up to 64
>   interrupt channels by setting 'interrupts' property maxItems to 64.
> - Also, update the 'allOf' conditional schema to ensure correct maxItems
>   for 'interrupts' based on compatible string, including tegra210 (22)
>   and tegra186 (32) ADMA controllers.
> 
> Signed-off-by: sheetal <sheetal@nvidia.com>
> ---
>  .../bindings/dma/nvidia,tegra210-adma.yaml        | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


