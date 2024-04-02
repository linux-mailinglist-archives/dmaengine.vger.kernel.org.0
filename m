Return-Path: <dmaengine+bounces-1702-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 304818952CD
	for <lists+dmaengine@lfdr.de>; Tue,  2 Apr 2024 14:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E5E1F241F5
	for <lists+dmaengine@lfdr.de>; Tue,  2 Apr 2024 12:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250957F7FA;
	Tue,  2 Apr 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Puzb/DBV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E305078685;
	Tue,  2 Apr 2024 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060433; cv=none; b=Iw5H2nwXMiGRLW61eIJLQpmXWBbSh7PNmE0NH/qrfWntfbpkK3ER6+qiB7U2ufFbBNC/KtkDN3EKtV1eSBx69JuGr/TYxsfrxT7rehOfAunzuInoc7dedxPkRxhFUMzZWu/hryUkvBtwKrjqZlZ2NsUoCmHDDzc78BCLsWmRvbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060433; c=relaxed/simple;
	bh=VlEbApYYlrQNKemDzsGDoCHVIiP3qoDoNZFKa3I+DAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjYSuCvcmXsa3zisl3sB4DDqKotN+opnOdqB1T+7lKj15e7vwLTK8KuZlv8s91Tht12/EsP1cDjBp+s4+bmdio+t5kVdL34DVkrYV9FhwSNUmpF7T5AIEgkNTKDvnp7yKZF0Fp/HaD6mYTilwXgo+Pvrefngi8fW9pIWTb+5+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Puzb/DBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396DAC433F1;
	Tue,  2 Apr 2024 12:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712060432;
	bh=VlEbApYYlrQNKemDzsGDoCHVIiP3qoDoNZFKa3I+DAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Puzb/DBV2W8DWmDy/Buo+DRI3mCqYkdrerzy7zNfBqNA9+r9Iowuq4doqAgtNALOP
	 4VP5OMkKE8POrhf9lbY4pCCJqfkzfPP1ytZRLV0TBrFgl05JoCQyjgPARTZbRZFYoz
	 tiCwPR/Ve9d/eZLtxX6aDHOr6NkoYolkBBzUiHLcusMptLmtMzEMlgL2UOvusnwx6n
	 4GYoiAbSPf9z02eTmxp3yKVgbNVUDxnNd6FFEfcXkSDSHWMFRBTaeEd9ROYnMbg89c
	 9+9zPzrF/tlUhCwaOdx8VWXYrPWtil1GRhIAN+TrX+/fzuWtnFOTiGgdrcnfMrtsLl
	 gIsvTxdkqeBOw==
Date: Tue, 2 Apr 2024 07:20:30 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: NXP Linux Team <linux-imx@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: fsl-imx-sdma: Add I2C peripheral
 types ID
Message-ID: <171206040997.3718172.5303876695049483513.robh@kernel.org>
References: <20240329-sdma_upstream-v4-0-daeb3067dea7@nxp.com>
 <20240329-sdma_upstream-v4-4-daeb3067dea7@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329-sdma_upstream-v4-4-daeb3067dea7@nxp.com>


On Fri, 29 Mar 2024 10:34:44 -0400, Frank Li wrote:
> Add peripheral types ID 26 for I2C because sdma firmware (sdma-6q: v3.6,
> sdma-7d: v4.6) support I2C DMA transfer.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>




