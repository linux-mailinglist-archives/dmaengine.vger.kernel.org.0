Return-Path: <dmaengine+bounces-1779-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE7489B319
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 18:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526D128311F
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 16:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FF03A29C;
	Sun,  7 Apr 2024 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pc0h3DDU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF124086E;
	Sun,  7 Apr 2024 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507964; cv=none; b=YvcEs4LywwDL2Gh49Ez2ItKD5ZNZnrD4wSWjNxjurxRuYqet+JCLFmrw6i0osClakuWNQA1Tm33qIM1pYx69F7bfrI14zO5XMamXSA8qL7Xr3szDjGbkd5oDkyELj7F4ftvtZcea+uffVADATzLNr3Dn/ryK6+3eCaLoyhgy+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507964; c=relaxed/simple;
	bh=9xep51DmsRdSIQSIA9rfjVwSUOIqYSdBSyWLWEAtevI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NOEMMszj3+iqU98/K8i4LVELipRUHwDQybMvuzlmjo6Tf7T567oP/78DX2dzZJKggtXOFMkrHPAM0F1YBu+oqhN6zwXmbm7IoPGgbr5ty2WhKNgPbjumRbuEFjI200r6Lu2VJrGihZji708wVTA+Q1UQkyLrdrAQQYfgbbyBKk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pc0h3DDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C81C433F1;
	Sun,  7 Apr 2024 16:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712507963;
	bh=9xep51DmsRdSIQSIA9rfjVwSUOIqYSdBSyWLWEAtevI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pc0h3DDU63ApNDaOWqArA4ze7HHimOZj6FJOxLek2t9D3YDajnqzeHiAnWWglMLI8
	 j+/XhSV3p+YQBAI7mvpMczE/KSrRTa11rYcxrk3XqsXU/avVi3W5/NeAq61HvhdDXu
	 GcxZbPBELPyU/Y0kEUZhHIqYNHhNQxuNrIsD5h9cNbFKNGtpea7DjSUsZD/PY7Hmmm
	 nEH2+QQR69WAu5AOMfkoBeFPaEyvepBsdc6EzjBTeqyoyNmAPlaqclmV3ce5um+tw0
	 F4OzpLv5vWW8P9Fc4APp8AH6Mdg1qwuCbuxVYdy6JqlQGjWtS8wJi3zvwha54JHIG8
	 5FUm602L3zYiA==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Joy Zou <joy.zou@nxp.com>
In-Reply-To: <20240323-8ulp_edma-v3-0-c0e981027c05@nxp.com>
References: <20240323-8ulp_edma-v3-0-c0e981027c05@nxp.com>
Subject: Re: [PATCH v3 0/5] dmaengine: fsl-edma: add 8ulp support
Message-Id: <171250796008.435322.12483737095962036790.b4-ty@kernel.org>
Date: Sun, 07 Apr 2024 22:09:20 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Sat, 23 Mar 2024 11:34:49 -0400, Frank Li wrote:
> Do some small clean up.
> 
> 0c562876972ee dmaengine: fsl-edma: remove 'slave_id' from fsl_edma_chan
> d9b66cb5fdf62 dmaengine: fsl-edma: add safety check for 'srcid'
> aae21b7528311 dmaengine: fsl-edma: clean up chclk and FSL_EDMA_DRV_HAS_CHCLK
> 
> Update binding doc.
> 23a1d1a6609fa dt-bindings: fsl-dma: fsl-edma: add fsl,imx8ulp-edma compatible string
> 
> [...]

Applied, thanks!

[1/5] dmaengine: fsl-edma: remove 'slave_id' from fsl_edma_chan
      commit: cee8cbfc7be8ff9f3ccf258134f9ab2c273abb75
[2/5] dmaengine: fsl-edma: add safety check for 'srcid'
      commit: 6aa60f79e6794bbbc571ea4e0501b9fcc26026e2
[3/5] dmaengine: fsl-edma: clean up chclk and FSL_EDMA_DRV_HAS_CHCLK
      commit: 9a5000cf70bcfcb5dd4e5b4bae0a01fb9bdf9fa1
[4/5] dt-bindings: dma: fsl-edma: add fsl,imx8ulp-edma compatible string
      commit: b14f56beb289ff67fe484d720bf09092163f90c8
[5/5] dmaengine: fsl-edma: add i.MX8ULP edma support
      commit: d8d4355861d874cbd1395ec0edcbe4e0f6940738

Best regards,
-- 
~Vinod



