Return-Path: <dmaengine+bounces-4855-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3460AA7F17D
	for <lists+dmaengine@lfdr.de>; Tue,  8 Apr 2025 01:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC66B1899B82
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 23:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C8D228C9D;
	Mon,  7 Apr 2025 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdTVhS5Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95736225419;
	Mon,  7 Apr 2025 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069834; cv=none; b=QjXenET8smcAVcueH9VvKLOGXwSPrnT/EXWoiUj9XyAFJ2cwGHvyRFsFXI3WCHOpBlVg0tDGeCpxR/cfAtODw25Vugj7ueT7dIR+vvAfLFeFXeqLgp/2SYRMv9CzsNsIK18zczvzs1KvBmBvUEWGjwS3RxH9Z7sDR0Ec8v3DB9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069834; c=relaxed/simple;
	bh=C91TU6EiUXUNu4pLkJLVbWTW2q/Tk5LKELt/9k63UA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHfSN6OMtFIRt8i95aSKWUm8fPnzE0zZsH8LsQ5mMsdTFjdrD17WEssRPBYpWGDgRQkb0q0oMw76qgXqLaEhj4VsacPnIgJIW5jHR01NN+cTk0oJMXfX1rYaJU+zHS1p0JMmzkzj0/Gifu+A40sZE0m44ca4sG5cYOrp2iG/IXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdTVhS5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1E8C4CEDD;
	Mon,  7 Apr 2025 23:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744069834;
	bh=C91TU6EiUXUNu4pLkJLVbWTW2q/Tk5LKELt/9k63UA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rdTVhS5ZF/q6VWszeFbbLbHPed6Ap/IcFPv6CxsDSjmCGcUNsMcss9fMKz35lKM4r
	 gUYc8CUOwsFMhpig1Pib33mNQ489qn1dxjZxElN87LCE/M0k5SjHwWevgNGtIN08kW
	 OL/s1N7bZNiBZaI4T83DibO+THYU/FHWHoOc1avJ7EOcqBnLTxjmTgNDc0DF414qP5
	 aFU3+h2P05ujvoagU9cgbYofsebjs52hkmGYDvS6QBgeDY2MfuU2RAfZbcIFwm+b5O
	 CgHcrdXvHIKYSNGrotA7bG7FGZbgln3w7Rxlo7f3ZI+PaojoncZyjuihh/dTYfqSJX
	 wDRsljzjVTS4g==
Date: Mon, 7 Apr 2025 18:50:32 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Joy Zou <joy.zou@nxp.com>, dmaengine@vger.kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: dma: fsl-edma: increase maxItems of
 interrupts and interrupt-names
Message-ID: <174406980425.184285.7437048033861841180.robh@kernel.org>
References: <20250407-edma_err-v2-0-9d7e5b77fcc4@nxp.com>
 <20250407-edma_err-v2-1-9d7e5b77fcc4@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-edma_err-v2-1-9d7e5b77fcc4@nxp.com>


On Mon, 07 Apr 2025 12:46:35 -0400, Frank Li wrote:
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


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>




