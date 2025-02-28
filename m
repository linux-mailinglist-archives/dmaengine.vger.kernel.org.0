Return-Path: <dmaengine+bounces-4624-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A28A4A5C7
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 23:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8543B8D7F
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 22:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C54A1DE3BC;
	Fri, 28 Feb 2025 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8y2kzuV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAEE1C54AF;
	Fri, 28 Feb 2025 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781195; cv=none; b=XuwxWTfZV/CpoZPdhbaOIlFvGAhnVoBaStnm8YJp9THGf6lnLlLH8qg7qJWS9mWVHts02IbdZaj7NcjaWrgdEVBNGrCKRVmzkUgTWp32VQVjztsol2uhXr+wDH2NBBq2NW24RoqQ+HTLHuPDSuE3M163DTAf2TdpmksjkbHX9WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781195; c=relaxed/simple;
	bh=Is6EeypzsIr/GF6ox/TafGl7L+nMb7erAmt/bL5FM1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n42+xrUIAWmArdxRDRwfBRE8Hp6d//PSZSPAoFiSyWpwPRqbHUYE+81knM7hBeyKkaFWGjbW4tJzn1fVYcG13UEFJ8GowfR4wJpDuUWknb5yGx/oxBHXr/hu3U25N6HcXSuhHLcovfGfDY/ftDT2hWlcNBpkmgpYBE76h6698Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8y2kzuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2E6C4CED6;
	Fri, 28 Feb 2025 22:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740781194;
	bh=Is6EeypzsIr/GF6ox/TafGl7L+nMb7erAmt/bL5FM1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B8y2kzuV8D87XwUZ2YJvDIXbHwWYckrI5sK8ggl9au6Qxm2XDhTSaG9J8IkqkcEnI
	 h1UycieE7vZL+YLs3Fz2sejd5HMdPjZfAojQ/NyCHI4Muow8bB6wM9kTWGZNfTReMO
	 Ts8T66ca5cNjzs4dnZ8snorkdwPytsSSEj/7klyt9X9bO+Kd7JxSGfwPxDPzU+yHvV
	 1qeJB178Xxub7nCmXQvz5FG/ETLZMhemUl/WI9NJwUcVRk54vTnnNuPCS5LwNY5Y5T
	 BoKd3E/l7MgcQl7nQFiehQBHSoIhtX/W+LDcTHadE1d8TIBtM7WRbDP8D9S6basBXq
	 JDXP8EA59ocQg==
Date: Fri, 28 Feb 2025 16:19:51 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: dma: fsl-edma: increase maxItems of
 interrupts and interrupt-names
Message-ID: <174078119105.3778835.11301085997308334922.robh@kernel.org>
References: <20250228-edma_err-v1-0-d1869fe4163e@nxp.com>
 <20250228-edma_err-v1-1-d1869fe4163e@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-edma_err-v1-1-d1869fe4163e@nxp.com>


On Fri, 28 Feb 2025 12:42:03 -0500, Frank Li wrote:
> From: Joy Zou <joy.zou@nxp.com>
> 
> The edma controller support optional error interrupt, so update interrupts
> and interrupt-names's maxItems.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/dma/fsl,edma.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


