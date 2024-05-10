Return-Path: <dmaengine+bounces-2023-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA488C2B6F
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 23:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF2A1C2399C
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 21:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D02813BAD0;
	Fri, 10 May 2024 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGBSap0V"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8DD495E5;
	Fri, 10 May 2024 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375126; cv=none; b=JSAIwS2E5CRR577Wlv0npgpvzHfdlhoujS60fiSiMxFeCxN8wh6tLHFX/HcEKxE0Rc5xDrcXoE/XnVPFEndxEuHJJDCyyEYT+eKMHl1Y1Gjx9d0CLATrfILMOLvdxXakONZUwW2N+vHIXJRVfkZ4W2gYM507Sky2HbZQKws0hNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375126; c=relaxed/simple;
	bh=BitthJdeNEWLyjLdoWk+CVPiQS+IdhQPs0TUb/umdg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYxMF8x2+VP1+cUlO2QfZDteSOROYyv6gmF95qwhNtc7B9zGSpcMCFwwICsQ95wM0tqMTvQ4QX9oqg8U8KuTls+5CuqOjtHc/PFjvKIif1lL3BvFR6Fh31QQKXfLeAYaS2tyM/eDtm5NDUny3Nbh3EhmxTAUThN4wNzWJXgbnJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGBSap0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDCEC113CC;
	Fri, 10 May 2024 21:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715375125;
	bh=BitthJdeNEWLyjLdoWk+CVPiQS+IdhQPs0TUb/umdg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGBSap0VQrmuROvPRv9pJ69IYN3kVpuj2whM7oS9PaeGp78FJDU/uRWTIJErE84aA
	 6M9/x/GLlPS6qDmwNVhZaA26lOkk698s8nzlpZX8gP0rCySV7b1QBo8MWJMo/nNxfj
	 PJD2T8h+5EAY/kmWXpHXaZXXMJMDaqJHiztEQbkfg08vYj3kdX/p4Zp65RkB3F67IV
	 uHGvYHiaA0MjlKwoV+jAllLZa4jWcdYCYas4eBveGK3gf7+Fizrn/RX8e5LWea5gaH
	 YCGZZsX3oxNw7wdDLmktOpHcPtLhY5kjw6rFCYWV/85I2y61wvGQAJwQ0B/fBb4vDW
	 rR1zLwAOLQSXw==
Date: Fri, 10 May 2024 16:05:24 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Vinod Koul <vkoul@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-hardening@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v2 01/12] dt-bindings: dma: New directory for STM32 DMA
 controllers bindings
Message-ID: <171537512146.746524.12713792362843036670.robh@kernel.org>
References: <20240507125442.3989284-1-amelie.delaunay@foss.st.com>
 <20240507125442.3989284-2-amelie.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507125442.3989284-2-amelie.delaunay@foss.st.com>


On Tue, 07 May 2024 14:54:31 +0200, Amelie Delaunay wrote:
> Gather the STM32 DMA controllers bindings under ./dma/stm32/.
> Then fix reference to old path in spi/st,stm32-spi.yaml: update the dmas
> property description by referring to all STM32 DMA controllers bindings.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
> v2:
> - fix reference in spi/st,stm32-spi.yaml with an updated description of the
>   dmas property to reflect the new path of STM32 DMA controllers bindings.
> ---
>  .../devicetree/bindings/dma/{ => stm32}/st,stm32-dma.yaml     | 4 ++--
>  .../devicetree/bindings/dma/{ => stm32}/st,stm32-dmamux.yaml  | 4 ++--
>  .../devicetree/bindings/dma/{ => stm32}/st,stm32-mdma.yaml    | 4 ++--
>  Documentation/devicetree/bindings/spi/st,stm32-spi.yaml       | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
>  rename Documentation/devicetree/bindings/dma/{ => stm32}/st,stm32-dma.yaml (97%)
>  rename Documentation/devicetree/bindings/dma/{ => stm32}/st,stm32-dmamux.yaml (89%)
>  rename Documentation/devicetree/bindings/dma/{ => stm32}/st,stm32-mdma.yaml (96%)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


