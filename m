Return-Path: <dmaengine+bounces-2662-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5E292BF1F
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jul 2024 18:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A481F23C4E
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jul 2024 16:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0394419EEB5;
	Tue,  9 Jul 2024 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG+1jYQX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8B019DF5C;
	Tue,  9 Jul 2024 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541210; cv=none; b=bZOkMPAW3/KM0a6dUr1kiukv9xxTFwr0g4bgcHIRjXNNrkukNHwazEqqKHGAyLLWmqW696GR8VGOWywNMbP0MXxzAYv+DfE+p5PmGHEl5ORm2QKJkXcKYno6TmYJzAUx1xlomt0a6eNdhH+ZWsNX0ZiNRSE7tgWpW4IllwCX8Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541210; c=relaxed/simple;
	bh=Jfw7AB0x2Li0p033aSufIjIbOrl8bWdhfVIn01BaZK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyHbEExozfElXTOtWZLUQrhMhnMYMbbgVolXmT7vKLy4TEJ2rZ/S35VU8QuKRkUO/O3EVuFEXlhvYXmv/F5lGlClLJ7FXDgfSh8/+Cl++p+1jiQ1w+tJtFi0tY6gcawbJTeEuEwblLjQU3SDIqy7mpLPaP2osBeVsFWEkuUAsjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG+1jYQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D50EC3277B;
	Tue,  9 Jul 2024 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720541210;
	bh=Jfw7AB0x2Li0p033aSufIjIbOrl8bWdhfVIn01BaZK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XG+1jYQX2CS/iqNKI9HCV0Ytlu4LctlW+l/5jCqxNxyEsPx4DeN6u/tSdzYr8Ilod
	 fjXLBjjUdv+rrfPfF26xVvgyE0zVhCldwRgV5hPSan7NkWVUWI06GXybOPh95DLpjP
	 6A86onFi3wZFmc3dMjeSUKuN/BTX71byJxnV6yIWVViVC8ApIho8KPzMCngP7fAY9s
	 xoU33eAhIE0d05ZDXRO+K7Ks378THIGFgOCm6+htvppfohRtgr1alsUxkA1HMdPBcc
	 zDu88oN5hOwpGGRhxVydXaJhKUP5cL9BuMkRvtA5b4q5Ri1849VpMcnjZ24i5Fx8dn
	 X1oyhA501M30A==
Date: Tue, 9 Jul 2024 10:06:48 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: dma: sprd,sc9860-dma: convert to YAML
Message-ID: <172054120726.3617655.15402302724766255692.robh@kernel.org>
References: <Zob1+kGW1xeBKehA@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zob1+kGW1xeBKehA@standask-GA-A55M-S2HP>


On Thu, 04 Jul 2024 21:20:26 +0200, Stanislav Jakubek wrote:
> Convert the Spreadtrum SC9860 DMA bindings to DT schema.
> 
> Changes during conversion:
>   - rename file to match compatible
>   - make interrupts optional, the AGCP DMA controller doesn't need it
>   - describe the optional ashb_eb clock for the AGCP DMA controller
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
> Changes in V2:
>   - rework clocks, clock-names (Conor)
> 
>  .../bindings/dma/sprd,sc9860-dma.yaml         | 92 +++++++++++++++++++
>  .../devicetree/bindings/dma/sprd-dma.txt      | 44 ---------
>  2 files changed, 92 insertions(+), 44 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/sprd,sc9860-dma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/sprd-dma.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


