Return-Path: <dmaengine+bounces-7507-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F18CA57F6
	for <lists+dmaengine@lfdr.de>; Thu, 04 Dec 2025 22:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 010AE3075A16
	for <lists+dmaengine@lfdr.de>; Thu,  4 Dec 2025 21:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D67272E56;
	Thu,  4 Dec 2025 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cab9U9dZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779C9398FB5;
	Thu,  4 Dec 2025 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764884213; cv=none; b=dt6NS+bzHYPd5if2HdmccrbccGbSHB4yt2X2YM3vF4ey409nRU5d63OhpORsnx6p6TsILzvsJeXEwNl/Bcz+VjeZAiCfWu1nltflqBh/FwkSTMr1wAXDQ4F6YwGL3f2zO9jXDSwEUB5DozLJoAc4PpG4vqw5MWI/2FL8IeniNOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764884213; c=relaxed/simple;
	bh=+4kEbHTDl/a+jM3AYdv1IGNG5rDWJIRvBYh0wo1LCrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WM0m/2ko7uuiKElMqejI6L+fMsphCbkA5kU4R0PtrcLXww6nxIU3dxn8g2t+2ipCrg9qGBtAxpLi2SLk96o/mJXN1k3888A9kYCAurTXc3s37Y9rbO62y8LOyn/h/F4IRT3ZFR1xFNK3zofjhDy/ohHyAF7K1bgXPhLf5FTbCaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cab9U9dZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACB7C4CEFB;
	Thu,  4 Dec 2025 21:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764884213;
	bh=+4kEbHTDl/a+jM3AYdv1IGNG5rDWJIRvBYh0wo1LCrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cab9U9dZqYBpk8WQf9DBBGQkLmo65iDOOtsc9lCNtaiUDMaB+Z8T0HHUcCfXLw+cL
	 B3w3PwdS8wHo9UiiA02/zZBMbN+3+PoTfTczCigy/j2iik1W0XPr9WbWh2TWdtbpMA
	 MnoZvlrgNBgiNgmgumKfBwbcrwpsQ4cLpp0rOc8ZmFVQvbOpentpdiBiPJsRewWwdx
	 pQKvD3BSQn3eivZklZRo2M7F2fO/apZXGpreM6f3LBwTYMNjcG7xpaNGOdxJYO4uy/
	 y/5joaeb57tT63X83cBP+tuizLz2JTkot+D9FXL2aANaBnvOmKjA23LeYwiI3QBy/K
	 p0MasW8FSVTmg==
Date: Thu, 4 Dec 2025 15:36:50 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	dmaengine@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: dma: snps,dw-axi-dmac: add
 dma-coherent property
Message-ID: <176488420978.2206697.11201292177123636920.robh@kernel.org>
References: <cover.1764717960.git.khairul.anuar.romli@altera.com>
 <025381792a014844a1e7121f11836ab1010cba89.1764717960.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <025381792a014844a1e7121f11836ab1010cba89.1764717960.git.khairul.anuar.romli@altera.com>


On Wed, 03 Dec 2025 07:47:34 +0800, Khairul Anuar Romli wrote:
> The Synopsys DesignWare AXI DMA Controller on Agilex5, the controller
> operates on a cache-coherent AXI interface, where DMA transactions are
> automatically kept coherent with the CPU caches. In previous generations
> SoC (Stratix10 and Agilex) the interconnect was non-coherent, hence there
> is no need for dma-coherent property to be presence. In Agilex 5, the
> architecture has changed. It  introduced a coherent interconnect that
> supports cache-coherent DMA.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
> Changes in v2:
>         - Rephrase commit message to describe why the property is needed now
>           and was not needed previously.
>         - Remove redundant statement.
> ---
>  Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


