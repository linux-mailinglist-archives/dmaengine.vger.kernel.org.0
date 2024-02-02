Return-Path: <dmaengine+bounces-936-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F70F847A3F
	for <lists+dmaengine@lfdr.de>; Fri,  2 Feb 2024 21:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDA4288619
	for <lists+dmaengine@lfdr.de>; Fri,  2 Feb 2024 20:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187158172C;
	Fri,  2 Feb 2024 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9VXw181"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD88A81723;
	Fri,  2 Feb 2024 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706904432; cv=none; b=nrFQQ3A10lOCPmd/uBgcMZBgmlWZXtcydw3m4iUCVvOIiJtgPEMXQ5/DxV3JT7BzDGu4BKZBKy0bC+feCFWwsODq1/R/ggm9LxBJb1YLbeStDKh01AbFYMD8ZMg7ZjVJdZtNV9ZDAWpO0E66iBLRqvhIOA/MbQzULd5xnYlFa9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706904432; c=relaxed/simple;
	bh=epRb1MXVvtkeSkxaalwuj7pybwm+/tm5dEiJdFjbC5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoBI8sm+OLGVFAipAGwFW2wO40rjhDCMOA99kvwCxfTlyymDSZ9vg03Gdtr6jT5Iv+Trpr+qIXkbrIAgOWV8y9JwTyKaOqiHOKjJDuwFw3iLHsOC50qxkl3+uW6O/xfFBamM5HUjFs5eD1Zn68+gelJc74cg5UiLlDNalhc8S9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9VXw181; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDA9C43399;
	Fri,  2 Feb 2024 20:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706904431;
	bh=epRb1MXVvtkeSkxaalwuj7pybwm+/tm5dEiJdFjbC5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R9VXw181nWECi+yklbcny4r++cmzpBqLtH3m+T+iThwJnV0rLEyAjjcxDHUzPMdw3
	 kKvoG9YI87XUFDZSPt6XkssCLwffqmY+k5YahvkW1UVq6gOBOAVx6do6yisSp2uYcN
	 t8ZsL4dMMngIHXi8JRTGwjGK7cuobjlEIVl/JxrTNjwcBHbefUJPKfHC5KUTg0otFi
	 hKfY0Cja8PY+V7Y9nMcUzMIxnsSWxR4yb44q8E6ikuvXuJ9Wp6Ti88TUpi7NOWUZzl
	 dJ/U79BXe2h6jSMPWrCUrWm0rPfwn7I5YGQFBhdyd+jPI02m7hXX0POLknmQzYjx00
	 MHaPXwq+8aBtA==
Date: Fri, 2 Feb 2024 14:07:08 -0600
From: Rob Herring <robh@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Lubomir Rintel <lkundrak@v3.sk>, Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: mmp-dma: convert to YAML
Message-ID: <170690442812.903220.16045094080463776332.robh@kernel.org>
References: <20240131-pxa-dma-yaml-v2-0-9611d0af0edc@skole.hr>
 <20240131-pxa-dma-yaml-v2-2-9611d0af0edc@skole.hr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240131-pxa-dma-yaml-v2-2-9611d0af0edc@skole.hr>


On Wed, 31 Jan 2024 22:26:03 +0100, Duje Mihanović wrote:
> Convert the Marvell MMP DMA binding to YAML.
> 
> The TXT binding mentions that the controller may have one IRQ per DMA
> channel. Examples of this were dropped in the YAML binding because of
> dt_binding_check complaints (either too many interrupt cells or
> interrupts) and the fact that this is not used in any of the in-tree
> device trees.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---
>  .../devicetree/bindings/dma/marvell,mmp-dma.yaml   | 72 +++++++++++++++++++
>  Documentation/devicetree/bindings/dma/mmp-dma.txt  | 81 ----------------------
>  2 files changed, 72 insertions(+), 81 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


