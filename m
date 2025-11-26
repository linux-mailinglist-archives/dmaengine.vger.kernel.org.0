Return-Path: <dmaengine+bounces-7359-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD93C891DE
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 10:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BA07356529
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 09:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B5131D389;
	Wed, 26 Nov 2025 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4yV+1gs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DE22FD1DC;
	Wed, 26 Nov 2025 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764150594; cv=none; b=irezw/yixXRN6i05xo3A3g0bYuX2iU7bb4tKNJe8G0KzMLuC7duVDsO27qxNmOMAsXdJoCDliAKqMpdN7YehGHqYB8fUzGusXolztY3IEO389Dzw05w8GrEhGpi3LKnEdtwshFvnF5/SuP2GLPRayh/O4BaXxiNpzd6Agp9I39g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764150594; c=relaxed/simple;
	bh=2VBNoZWHjBUiC+MXXkKX6rZM6nYUKb3iGPgNiGg8uWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qeycz5Vg9flPUJpVSe24Z6lWdUgcihGpxqHN/aSN7cvYl+OeyxX4JtXBJgGZcyHxpUmHjHMyGzL4EpNujZdIj4aMIPg465n3FIEbxvkvyf/OwMK7vtN1ZiplKGRazM6sFsuDuwI+HDk9QdRCw8SZQiirmf4/CdKKY/YRHIR7r7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4yV+1gs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9A7C113D0;
	Wed, 26 Nov 2025 09:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764150593;
	bh=2VBNoZWHjBUiC+MXXkKX6rZM6nYUKb3iGPgNiGg8uWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y4yV+1gsogmrLcxg2aKldZgYV9/oF6rR7FNxVs9g33BePTwTkp4zVlXvR+J5S7mCB
	 V2epqRNc66jbLX48N6OjclpOL+dIaB3D84PCR5yh52c2vOZ1Fg0NGPBxAOCL2cLFYG
	 pzNNoCGTFtOmGCKiDK6tGOs8Q3rQfReI4U8XiQ7lvs0g5PyWW4L3UtT1tX8tcHy0sT
	 REUlUlXw0wk8mS9bOaVGzLMI3fsh5zP3K9O2YqNa7aGYA8jc5RVLCeeZ0UgLbS6/dq
	 gW8cM3jmmQIQYw1UvY2wj3/FymahnqF+6rCqErMNqk2iBj7cNiC06hjeWXz+/5vO9v
	 Ri1VhJkOfFKTQ==
Date: Wed, 26 Nov 2025 10:49:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: dma: rz-dmac: Document RZ/V2N SoC support
Message-ID: <20251126-quixotic-gecko-from-avalon-3d7617@kuoka>
References: <20251125212621.267397-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251125212621.267397-1-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Tue, Nov 25, 2025 at 09:26:21PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Document the DMA controller on the Renesas RZ/V2N SoC, which is
> architecturally identical to the DMAC found on the RZ/V2H(P) SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


