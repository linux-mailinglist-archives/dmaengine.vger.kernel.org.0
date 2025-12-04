Return-Path: <dmaengine+bounces-7505-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F45CA5736
	for <lists+dmaengine@lfdr.de>; Thu, 04 Dec 2025 22:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C241302E6E9
	for <lists+dmaengine@lfdr.de>; Thu,  4 Dec 2025 21:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A132C2D592A;
	Thu,  4 Dec 2025 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTVr3MVc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE811B78F3;
	Thu,  4 Dec 2025 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764883469; cv=none; b=aWUceH20AFHj4Mm29LIhLzslYTd7JCe9JwXEb4krq9ADq6yVU3Pk8mrKZSR7MNBHtlyxtHd+5TO31A+AhwRPsUbZB6CG3J3XypKS2wwmfUlOggVDxEPjPUopcU7RNkEBNqeIuk/a0NWrEjvUROJTuPwpMs6SsSUL9n7aNYYlX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764883469; c=relaxed/simple;
	bh=mG4cWT7g0k2xbtIAMF2X40RZzY6ecYZXM0QgoBf6MUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOWDRJS6DywIKaFURPsKYVKYzCXms/YJfNezS7enYEX1u+hg0A2hlCQLY7wDyH9uZ9Pfaux3Jb79G0diWnU3D0JJJ3YZf9G+/Bj7r3OWq6/36ZlVR7sWW3ltM8AoZc8/wgsGwaOoY56AUsnHAp0Kopy7bs4gc0tQs9isc5EA4bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTVr3MVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CEBC113D0;
	Thu,  4 Dec 2025 21:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764883469;
	bh=mG4cWT7g0k2xbtIAMF2X40RZzY6ecYZXM0QgoBf6MUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TTVr3MVcwdLGhDbNvXrYXJU51ltldsg1AksmORA/Z5XEpxURNc2FwG/GOj/junQUC
	 yXvNl0R597ZEpmgw+dND9hWK3HMvMKm9jGNC/4xucd/so/he3KcE/mhw7U/e/rtZ9Z
	 tixknNcmHYaiKc491I05ccBTOyLz5jKrVwTK2US0nhKTLmFMITWrFv4kUGINcKLwRi
	 Hh4PoMMm1FP3SaS6gj7KWVCfZRxe4WT5vGoZo7qks8gdBmJgFh3eZWld5VIjQoHQ/l
	 VcacYrap6jWzwA+SvNI0y6+slMJSKsLfRxSgzIFCZHoZqMS8nRhuClWKGe634ZNUUF
	 9rZJolsLRZdYg==
Date: Thu, 4 Dec 2025 15:24:25 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 3/6] dt-bindings: dma: renesas,rz-dmac: document
 RZ/{T2H,N2H}
Message-ID: <176488346527.2191639.14421077722931377350.robh@kernel.org>
References: <20251201124911.572395-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251201124911.572395-4-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201124911.572395-4-cosmin-gabriel.tanislav.xa@renesas.com>


On Mon, 01 Dec 2025 14:49:08 +0200, Cosmin Tanislav wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have three
> DMAC instances. Compared to the previously supported RZ/V2H, these SoCs
> are missing the error interrupt line and the reset lines, and they use
> a different ICU IP.
> 
> Document them, and use RZ/T2H as a fallback for RZ/N2H as the DMACs are
> entirely compatible.
> 
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
> 
> V2:
>  * remove notes
> 
>  .../bindings/dma/renesas,rz-dmac.yaml         | 100 ++++++++++++++----
>  1 file changed, 82 insertions(+), 18 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


