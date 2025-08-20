Return-Path: <dmaengine+bounces-6082-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767C0B2E408
	for <lists+dmaengine@lfdr.de>; Wed, 20 Aug 2025 19:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514923A7017
	for <lists+dmaengine@lfdr.de>; Wed, 20 Aug 2025 17:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F7723E358;
	Wed, 20 Aug 2025 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qB3404rn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040051FE471;
	Wed, 20 Aug 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711231; cv=none; b=AMtXrbAeea9zsXRgVVMD1QRSLApKDg/UoDY1H3vrcm80Dg7+qTsFEYmp/UCeG8/FiT+FGn+oKMYRHuFmW3KFJ92wdofzZq2Ha9nJt9ezbm4oxzN3oR0DvxCm70m1wXj57SdqdpKYDNdooTXMM0JT1sKNKeLwws1oqvU2tyoTXDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711231; c=relaxed/simple;
	bh=IZLhfWlR8l29O/Rs+y/vbyQIxjgqFr1RK3zhxpfWq9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qkxle7CKRHy6W6DYnL1wSJPPy9mWRyyzJNXWY1lq8XfX5pX1XtXo+7yiFu2gvDsKd4t3d9I3OQKY9fjttDni8JAAcfoGvSxT3CmVFXmLCnVzsA/FxOzvqjiCRobWm4P5iZVYLpequp9UyVthgDWf4NRijaP1JdW7qrRXtkCZ+tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qB3404rn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8DBC4CEE7;
	Wed, 20 Aug 2025 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755711230;
	bh=IZLhfWlR8l29O/Rs+y/vbyQIxjgqFr1RK3zhxpfWq9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qB3404rnN0wFbDUiVHboYVAJPfSJyh0mlizGnsPAKDEQrliwNVkpMrdOir+7wq9sM
	 NQBZTujNSdd6t94u4k7Zi9u4/O8cMIN31yWoHhw1RcG4gTPiuotcSoPZjjQsU4Njvj
	 IenBRIZFhOAYv71dBbWYGT059/71eYmLHhAKIlxnQK7D4EHvKH6tx1e+f7tJtixwS3
	 xdmCZo9v+cDpbbWdVCij+PlYYxV7eI7YiHeSa0PRLpbxmGUHaAN6bETGM1vtVm9w2+
	 UDPN7J3qFeEQkTAMyYerfRIp/Mu+qi2uye7orz+gRGa86cT0u7Z7nwcKr1v5GRpaHc
	 moLSENnPxdyZw==
Date: Wed, 20 Aug 2025 23:03:46 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: dma: rz-dmac: Document RZ/G3E family of
 SoCs
Message-ID: <aKYG-ph43pjgiHF_@vaman>
References: <20250801084825.471011-1-tommaso.merciai.xr@bp.renesas.com>
 <20250801084825.471011-3-tommaso.merciai.xr@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801084825.471011-3-tommaso.merciai.xr@bp.renesas.com>

On 01-08-25, 10:48, Tommaso Merciai wrote:
> The DMAC block on the RZ/G3E SoC is identical to the one found on the
> RZ/V2H(P) SoC.
> 
> No driver changes are required, as `renesas,r9a09g057-dmac` will be used
> as a fallback compatible string on the RZ/G3E SoC.

I seem to have only 2/3 w.o cover, nothing in pw too...?

> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> index 92b12762c472..f891cfcc48c7 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> @@ -21,6 +21,11 @@ properties:
>                - renesas,r9a08g045-dmac # RZ/G3S
>            - const: renesas,rz-dmac
>  
> +      - items:
> +          - enum:
> +              - renesas,r9a09g047-dmac # RZ/G3E
> +          - const: renesas,r9a09g057-dmac
> +
>        - const: renesas,r9a09g057-dmac # RZ/V2H(P)
>  
>    reg:
> -- 
> 2.43.0

-- 
~Vinod

