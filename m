Return-Path: <dmaengine+bounces-3329-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B393998F8D
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 20:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8121F25F93
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 18:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C891D1C9EA4;
	Thu, 10 Oct 2024 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5pltNnm"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9663419D880;
	Thu, 10 Oct 2024 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584068; cv=none; b=F6EYHdmkQ1+ACs2519ns9m2M4AxsbHEA6bgfo6UQviWGeypoaXIDsSdfjSxIfCM1ulM4zhZRRNt1JcwzWqC+xEuVM//12ef0yGT9hrOyiUuXL7Q9UJowF2VWdUqgQcdJMqGaOzMHBiGKD1NCodZTycA6br2G0UClbO63B5YR7Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584068; c=relaxed/simple;
	bh=O2rfQPpIZwjz0HkgGVQfisi/l8/F1UC2p3XQEvowOoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWLjhcGI03xzRTbuqDLypL0njUYYp3Buz70LjC8WvUoRbbBClVaylgj7+OGoWxCCSCQHT7AigDut6hmbsZnMoBQkeWSv91BadqYMpy8/u4W05YibrIsZinIk+BYHmSx20/A44A+oFE7YSO4DhSGP98iMTFCGnGOmokyDto2DlxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5pltNnm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8794C4CEC5;
	Thu, 10 Oct 2024 18:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728584068;
	bh=O2rfQPpIZwjz0HkgGVQfisi/l8/F1UC2p3XQEvowOoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5pltNnm0sgSnfDqpzVrTGsr7RbNS/fwjOl+4d7QLvPd1uzH2cYRXtb5weHAmpxlQ
	 jKwf2Ob67DFCCoY5VGVwoci4fl3ghfVrvutEAFLTnnaJJW4HkwwDvRSnBA6M6jYKcq
	 8zescVdSDG+INd2sj7yoS/ht2JwdkiRMP4FsDfK/ex/uEzQku7ORWp+39kDHvxbHnk
	 ykJ1Tdm18j0zADby2zO9gi02UCi3ML65ZQjXTxl7QTtPJl5j+Q9QP9aR+RAxcKzrGP
	 pB4S9f5I11S052Vv2ZOu2B0ItEZJixnh7eOlH0FzKmofnPTtx2ePok0yDiXxGueCL8
	 Kk9IBB8323Nfg==
Date: Thu, 10 Oct 2024 13:14:26 -0500
From: Rob Herring <robh@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dmaengine@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] dt-bindings: dma: stm32-dma3: prevent linked-list
 refactoring
Message-ID: <20241010181426.GA2107926-robh@kernel.org>
References: <20241010-dma3-mp25-updates-v1-0-adf0633981ea@foss.st.com>
 <20241010-dma3-mp25-updates-v1-4-adf0633981ea@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010-dma3-mp25-updates-v1-4-adf0633981ea@foss.st.com>

On Thu, Oct 10, 2024 at 04:27:54PM +0200, Amelie Delaunay wrote:
> stm32-dma3 driver refactors the linked-list in order to address the memory
> with the highest possible data width.
> It means that it can introduce up to 2 linked-list items. One with a
> transfer length multiple of channel maximum burst length and so with the
> highest possible data width. And an extra one with the latest bytes, with
> lower data width.
> Some devices (e.g. FMC ECC) don't support having several transfers instead
> of only one.
> So add the possibility to prevent linked-list refactoring, by setting bit
> 17 of the 'DMA transfer requirements' bit mask.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
> index 5484848735f8ac3d2050104bbab1d986e82ba6a7..38c30271f732e0c8da48199a224a88bb647eeca7 100644
> --- a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
> +++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
> @@ -99,6 +99,9 @@ properties:
>          -bit 16: Prevent packing/unpacking mode
>            0x0: pack/unpack enabled when source data width/burst != destination data width/burst
>            0x1: memory data width/burst forced to peripheral data width/burst to prevent pack/unpack
> +        -bit 17: Prevent linked-list refactoring
> +          0x0: don't prevent driver to refactor the linked-list for optimal performance
> +          0x1: prevent driver to refactor the linked-list, despite not optimal performance

Driver settings don't belong in DT. Perhaps reword it in terms of h/w 
constraints (i.e. single transfer limitation).

>  
>  required:
>    - compatible
> 
> -- 
> 2.25.1
> 

