Return-Path: <dmaengine+bounces-4588-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9A3A47D0C
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 13:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A3DE7A885C
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 12:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070C622DFA5;
	Thu, 27 Feb 2025 12:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqycOa0p"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB47922DF9C;
	Thu, 27 Feb 2025 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658076; cv=none; b=rZYzs2Jne0NmQXvQ7BIdTfbk8AF5FkyOLSlSbkiQHDUsCGCxgibmLVCv0RUFE4vtCSGMxQ3T5lByBFuR9A4fxQfgoKDsrFpiCEJQDGJYot+7Ws6+8j6LUlXjw2QWpP7X6aCnOZSo32KVxB7OyNqbPETicvNzCNYNoNJaA7A8mFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658076; c=relaxed/simple;
	bh=QZ7uyDt7FFYNwCiAJyDRERDGCfQwMZ43xoPoHsEClRo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u3tSjvlvknAfs8NeZv7I1JGa2A8LNVdBdj/0/KV4UwUzT3TYmZsUokjV2rVVl2+RNvmzomj45IG6mj924xbe3aRyqYtbfBepq0LR348qr8Jctj4NqEzLrz6e4zUHG8PhW2g9kSJOPHeP5GYgOcs3lk5s5XRKZN0iU63DOL/J9v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqycOa0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83690C4CEDD;
	Thu, 27 Feb 2025 12:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740658076;
	bh=QZ7uyDt7FFYNwCiAJyDRERDGCfQwMZ43xoPoHsEClRo=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=VqycOa0pw5e5NnBE49RDN9rqu4NFQF6bYVnANL9BMmew2PhzHXjo4lKtKHs+aImL1
	 MulGrvCCwCTKuOvnetFS7dWbti+jD02DX4CH5dI2Ev6t8dCz5+N+AHRQcUVXgNsIHB
	 BAtK0/gbLffIVqaCCddD3f7kFpTLdRU2ILY0YAPJmoQ25xRFY0MYJn7+I2lxwo8KjO
	 hDeQh4/etfQlDfNM5atgJeMXELw6c8o9CFZjk82+bfF+vg18OlB1XqEixFMXvSnSGB
	 pPOpBBUm/p1qLi/jiuv1jrnhEkVwyv1G6lmOU+rzDwaVL3A3vPTuHLA0rmcUjVhEwT
	 s6RhPBoLqKLpA==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 imx@lists.linux.dev, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20250221222153.405285-1-Frank.Li@nxp.com>
References: <20250221222153.405285-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] dt-bindings: dma: fsl,edma: Add i.MX94 support
Message-Id: <174065807313.367410.5471708868415737706.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 17:37:53 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 21 Feb 2025 17:21:53 -0500, Frank Li wrote:
> Add support for the i.MX94 DMA controllers. The SoC includes two DMA
> controllers: one compatible with i.MX93 eDMA3 and another compatible with
> i.MX95 eDMA5.
> 
> Add compatible string "fsl,imx94-edma3" with fallback to "fsl,imx93-edma3".
> Add compatible string "fsl,imx94-edma5" with fallback to "fsl,imx95-edma5".
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: dma: fsl,edma: Add i.MX94 support
      commit: 34436106af3d00b9cf94dbf7200b8162937f9943

Best regards,
-- 
~Vinod



