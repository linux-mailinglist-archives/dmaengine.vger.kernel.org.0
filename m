Return-Path: <dmaengine+bounces-4575-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD9DA42D31
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2025 20:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3115817A390
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2025 19:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239371FCCE0;
	Mon, 24 Feb 2025 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCR59lQV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67AE136327;
	Mon, 24 Feb 2025 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427130; cv=none; b=kO1AFkpsZHaRlOH28YPlBfX6sKru2V+X+3XUBzh7aKdwP0+SyDeNx4sw16pOYbYfgzml+kn88+cHyLyXt55kGrTupVT7tQkID+fnF4TEjE9OhDvU8cM8mTCfMSz6EepkyLY1R7xw/4H1gLFK10qDZLa5wELR09CawSIuymgLVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427130; c=relaxed/simple;
	bh=8X/gNirLOboLavp4kF2SCReSSJxA99Vn4gihqi5QWuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BefCbSZ14FxWApcf+sRVuhLTTJh33iBomPPGbguIepJjTLb0f0ALrD9LopSAOiplW1GyjeeM7leZ7yP4m/EGCpKtvFH+NJd9zLTnThPul4G7HY2K3n0d5XYxTcGL11J+mUNEFKM7QvFQ/Ss8G9NAABrnYNFijBXWWG5I5W/iidk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCR59lQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C62FC4CED6;
	Mon, 24 Feb 2025 19:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740427129;
	bh=8X/gNirLOboLavp4kF2SCReSSJxA99Vn4gihqi5QWuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fCR59lQVIUTC6wG9kvFT2+frCR09SzZspLMsYwxUnWdUC3Rtz4DsDAC3GbC6UMBu3
	 N1DLFtq9xmGRzl6VbR2hRuQjZ+QSemdYP3KRK3p1KjicMn7IMKpzAiSeW0+aLMji28
	 c7vz3UuLd+5UshxkK2k2Hoa+KaOOpxuGEt8IYq50OvxxBMMsiJzPfoLDN2G8X/Ht8X
	 97hmn5CdFs8X+ipYpSo4q+t+McuFrWairX2HY10UXGBrABfEp61jSqgphC0OEBa2nr
	 bkyMdVQi9g8XalIbSDaAL94jxEeGWPnAfkR4jn7y/aJ8Dp+U/648Ok6cmNMMKdG41N
	 ivHmJqfb/NRSw==
Date: Mon, 24 Feb 2025 13:58:47 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: dma: fsl,edma: Add i.MX94 support
Message-ID: <174042712695.4008810.10732802711661241566.robh@kernel.org>
References: <20250221222153.405285-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221222153.405285-1-Frank.Li@nxp.com>


On Fri, 21 Feb 2025 17:21:53 -0500, Frank Li wrote:
> Add support for the i.MX94 DMA controllers. The SoC includes two DMA
> controllers: one compatible with i.MX93 eDMA3 and another compatible with
> i.MX95 eDMA5.
> 
> Add compatible string "fsl,imx94-edma3" with fallback to "fsl,imx93-edma3".
> Add compatible string "fsl,imx94-edma5" with fallback to "fsl,imx95-edma5".
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> dts patch first try at
> https://lore.kernel.org/imx/AS8PR04MB8642049B19BC7A5C8833FEB487042@AS8PR04MB8642.eurprd04.prod.outlook.com/
> ---
>  Documentation/devicetree/bindings/dma/fsl,edma.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


