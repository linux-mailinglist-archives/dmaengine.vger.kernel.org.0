Return-Path: <dmaengine+bounces-2343-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1751F904387
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 20:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9158BB263B6
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 18:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C4C79B7E;
	Tue, 11 Jun 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9MVZZky"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D8B74BE8;
	Tue, 11 Jun 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130479; cv=none; b=vC8dzE2trl1+QGfemGvsngPgOw0z1Z6QKi7MTDF//tyWzwpmrTZua/dcKal+WbQrAkNN1ubv4HRK4iAETJSd+qqvfz3lXT8BmYUPXu9easXnXZfvLR9CW+4pbPNbFvEWLnx905oqoELocGEwhaKKnhcfGRhMNIaDOohpiPy/iPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130479; c=relaxed/simple;
	bh=6CSNMxxBSxOg2wytumtFbB+a4+h3V2IFBw3MlO5EU3Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PtlSJjaj2Q7znIqn+aCfETQ5vjkBEg1kP8RP7X3KDUAaNL+j2qcIjbaRqqJXsxndvb6lDYymjn/US78cZfnZ9QKFZgu7oBBSeaVZRt0Pbz19mNQZweSGsndkSRKPky3qFT4QUeP1J34aEUQRaS4UZuo6xQnsCdLjcIA1MLoaLgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9MVZZky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35CDC32786;
	Tue, 11 Jun 2024 18:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718130479;
	bh=6CSNMxxBSxOg2wytumtFbB+a4+h3V2IFBw3MlO5EU3Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=M9MVZZkyp9REtuItIrCF3J+xoeWLhhKnsmYGD5Op+QZmTQC0RuiSCIHHuEmxbc1Rl
	 vx02zqODkzr9ZKY8gS9trDMn+PpGm18pY1x57HsJQhJCxPaPkDsQMdZ9zsGi2lCXUZ
	 9PShElK12B2XcEm1iFDTDUnkj6FiAYIw2aaoy+5Gmix08zqSUVy2kGAqB8IfkkDONg
	 l58RMbc4VyW60alqO2FVa/z3+7db/uM0MOrCRNESwUiSPWsJ4/YPTJqgvUBdJWZSXq
	 wpzyFhVzLdXNXLILCVhUWPsWPEImJcgDeL3H9HwwkAUeggPjYziIwU8SYOLJaqo40Y
	 i9RziCFpL/E2A==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 imx@lists.linux.dev, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: stable@vger.kernel.org
In-Reply-To: <20240521083002.23262-1-krzysztof.kozlowski@linaro.org>
References: <20240521083002.23262-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: dma: fsl-edma: fix dma-channels
 constraints
Message-Id: <171813047547.475489.5206693494651133919.b4-ty@kernel.org>
Date: Tue, 11 Jun 2024 23:57:55 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 21 May 2024 10:30:02 +0200, Krzysztof Kozlowski wrote:
> dma-channels is a number, not a list.  Apply proper constraints on the
> actual number.
> 
> 

Applied, thanks!

[1/1] dt-bindings: dma: fsl-edma: fix dma-channels constraints
      commit: 1345a13f18370ad9e5bc98995959a27f9bd71464

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


