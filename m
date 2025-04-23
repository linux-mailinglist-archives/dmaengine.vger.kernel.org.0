Return-Path: <dmaengine+bounces-4992-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED25A98957
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 14:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A7317999F
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 12:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42963215056;
	Wed, 23 Apr 2025 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3x145LH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100231D90DF;
	Wed, 23 Apr 2025 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410417; cv=none; b=gdfwXe+WPmTVZO991fw//hlBZOBi5F2havtTcu08uK5xpsd3Um2z/a2LJI/xVS3OWgpc2vBh54C53iGl5dd+k8fhezMZE+qHWm/nB8zBYaoYmMkY/TBhkukDcDHlGTvf/tWwl4i5mko9Afr9QjX/rr8n3FyfrCsMo+cDJjEuPX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410417; c=relaxed/simple;
	bh=HMgH1+9XyIkutzq+xKi6DmcGLLwEOVIX2ELaW0OhH3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXrZ9gXmLNufCpldhZaNMR0W3EsZ42TpgJ/WsrsQwvVTFgrPJGNjChd1Di/pyXMTV8XtmpCBGyOEYwNWrXcAijItfJduL2uwI9oPLfyDeevFske+TpC+eqhgNqWIJkwhDwoqO1ppDfJ4kZd7USfmFY2lSBA91fmUXGRmtcfGouQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3x145LH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441D2C4CEE2;
	Wed, 23 Apr 2025 12:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410416;
	bh=HMgH1+9XyIkutzq+xKi6DmcGLLwEOVIX2ELaW0OhH3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V3x145LHTniTXMJzsrhUROlGFjM16I5YzmcBHE3FXBZD97LaHKfJ5597d40HpIwdJ
	 /n/usmDjUzkGsUtgdvzvF0T5SaAAXYmTGsVOqRUIcNJuSSyMbEtob9hLbuDV5BBIdY
	 3hy4PG64YyZGByTm5rT46yY2AfgkBTqkvCZdr4LApMON9caYe1HsGQum5kDYUPVCQt
	 ToKJORV7i+Cz+YMBo/olR8utRITpy63q12syC98PBE4SJbJ/aIF5Y0l+U0Et/hU9uq
	 0vy3esOBXvQeAwXNtUAG7+M5pAy9mRv/t3t4zngXI40pvd8o+YDu8MgQVypiG4Nevk
	 JwSfYjs3MlZMA==
Date: Wed, 23 Apr 2025 07:13:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v6 2/6] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
Message-ID: <174541041414.56228.14869219817347630764.robh@kernel.org>
References: <20250422173937.3722875-1-fabrizio.castro.jz@renesas.com>
 <20250422173937.3722875-3-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422173937.3722875-3-fabrizio.castro.jz@renesas.com>


On Tue, 22 Apr 2025 18:39:33 +0100, Fabrizio Castro wrote:
> Document the Renesas RZ/V2H(P) family of SoCs DMAC block.
> The Renesas RZ/V2H(P) DMAC is very similar to the one found on the
> Renesas RZ/G2L family of SoCs, but there are some differences:
> * It only uses one register area
> * It only uses one clock
> * It only uses one reset
> * Instead of using MID/IRD it uses REQ No
> * It is connected to the Interrupt Control Unit (ICU)
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v5->v6:
> * Reworked the description of `#dma-cells`.
> * Reworked `renesas,icu` related descriptions.
> * Added `reg:`->`minItems: 2` for `renesas,r7s72100-dmac`.
> * Since the structure of the document remains the same, I have kept
>   the tags I have received. Please let me know if that's not okay.
> v4->v5:
> * Removed ACK No from the specification of the dma cell.
> * I have kept the tags received as this is a minor change and the
>   structure remains the same as v4. Please let me know if this is
>   not okay.
> v3->v4:
> * No change.
> v2->v3:
> * No change.
> v1->v2:
> * Removed RZ/V2H DMAC example.
> * Improved the readability of the `if` statement.
> ---
>  .../bindings/dma/renesas,rz-dmac.yaml         | 101 ++++++++++++++----
>  1 file changed, 82 insertions(+), 19 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


