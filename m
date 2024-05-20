Return-Path: <dmaengine+bounces-2111-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D602F8CA36A
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 22:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7500F1F21B09
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 20:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F71E139CE5;
	Mon, 20 May 2024 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7ZqlrZN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD43139599;
	Mon, 20 May 2024 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237627; cv=none; b=pOwjrZgzX3ihx2FU9b8cwh8wiWJtos3rEmUGulu1RID5W34c68V8Jrkgpx3PmF6vuHeRTUij95vIhykU+STfJEeLUYW9uOx4T6EFje00z2RvlYOKcKNJ/qIFTXmr5VQLOv5B5A06QMGzVVlLUngzyJuUtQhqfpw+pxirlqv9a78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237627; c=relaxed/simple;
	bh=0GeM9ZvpwWeEcyEm1SbQY2gkxS/JHF/8kq6OsWB3c64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWfEH/God4R7BVBkPFMYEVH7rXBOaNIfwx0MitCPGCQ/bQn+QxnRrzhwWJkOHuE2VDK/C6wal7U8wKqXHuj07IlTxF4R9i6wGKshVkQHLnioVucXGe7HujWU9w95qByqelSKtZQshfHTpvvFznuCpKkZoQnmsm6GYAsj3m4JQuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7ZqlrZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B507C4AF07;
	Mon, 20 May 2024 20:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716237626;
	bh=0GeM9ZvpwWeEcyEm1SbQY2gkxS/JHF/8kq6OsWB3c64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7ZqlrZNs9lHt+YgugJjQRXeBEDuR0Vitej683otqqmp7+RMvFnGITHwvABnm2rFq
	 yMpYc2h39snU/KS7pZ/9kKDAp6A5KLeaU/iAMaQN3TVxjVFLIsHnQeaHpmJiD/LdkQ
	 crnfWwF5HJZRGtk5DaZqMAsepEoJYlRNRiaIkYXaUlWsCCSc0PTV+2eYYF9SVJziqL
	 AHlr24bQPpMhN3GO7XSdPt/ZnH9QtR5x0BRKmrqpea5EQ7SbNxuXFELInc2W+c9ShH
	 Byj5aLi+tuzYz7uFCPQ/y1Uv+xE+u6QQLPgq4e65/uuHzOKnAqWR+COCFY3TphD3wF
	 vwfg79vx+vbsg==
Date: Mon, 20 May 2024 15:40:25 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Han Xu <han.xu@nxp.com>,
	Richard Weinberger <richard@nod.at>,
	Fabio Estevam <festevam@gmail.com>, linux-mtd@lists.infradead.org,
	Marek Vasut <marex@denx.de>, Vignesh Raghavendra <vigneshr@ti.com>,
	Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	dmaengine@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	imx@lists.linux.dev, Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: dma: fsl-mxs-dma: Add compatible string
 "fsl,imx8qxp-dma-apbh"
Message-ID: <171623762348.1441545.15424610075709594477.robh@kernel.org>
References: <20240517-gpmi_nand-v1-0-73bb8d2cd441@nxp.com>
 <20240517-gpmi_nand-v1-2-73bb8d2cd441@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517-gpmi_nand-v1-2-73bb8d2cd441@nxp.com>


On Fri, 17 May 2024 14:09:49 -0400, Frank Li wrote:
> Add compatible string "fsl,imx8qxp-dma-apbh". It requires power-domains
> compared with "fsl,imx28-dma-apbh".
> 
> Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
> it.
> 
> Keep the same restriction about 'power-domains' for other compatible
> strings.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


