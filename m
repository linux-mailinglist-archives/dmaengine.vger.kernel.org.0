Return-Path: <dmaengine+bounces-1776-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 097D389B312
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 18:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8591C21F72
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 16:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017EA3C6AB;
	Sun,  7 Apr 2024 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENfS9PPn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD76D3FB80;
	Sun,  7 Apr 2024 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507955; cv=none; b=hfC5qUaS5apxmDf+X9Nd74PoYVSgpvkwoCcjX74qA0QDR5pe4jKeXNJ4/L5cyCY3WDtffHuesGEJiLMXxqK+/rAbRqj+o3ueZcIRTg/AaZ3Fzjb3MmmPue1/FmDkc3r/QlfF6CSeABgX4ZOEciwGQudl8S00Y2hw+7Pto7NBm+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507955; c=relaxed/simple;
	bh=XaBryDkvhvrJ0iAr0vu8h9+rnsoJrJYQ6BI3wRhu9YI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jPMd9iXfZ365F+uEe/V0eOV25wEowx3xfhR3GIY2rQ3oK0dHLSmBfHoif551185X/B2gdPUtKRkP7tkqYtqig7xSyvTBNIL8XvLXoew0GmxoKD0gOuROAytEGtdxG5DePcHfgQgruCv//6QZ3Ld5WSE/Uxwajq9I2VVNtyWtaXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENfS9PPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4600DC43601;
	Sun,  7 Apr 2024 16:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712507955;
	bh=XaBryDkvhvrJ0iAr0vu8h9+rnsoJrJYQ6BI3wRhu9YI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ENfS9PPnl5prd1sxrSGaPpwJkCJ4e9ckw/e4XdH7A3odErO1vFhrZ+KSIl3oyu4Kg
	 j6rtmrnRjJRnPh/0O7CbyCVWUFGljVD4jQyyd54dyali9plSmsSoGnF+eKG2DGK66T
	 4jxPfSA0q6f3FesfePHOpKWYv1HdnmElsYjjU4k3cwNKk1pckJV4T+hVMDEnlY4McN
	 3iOdI7n/Scc4FbIUC8Q+UA3ssJrYrTCJ+rTJ/cqmVbkJUD/zmKXbf69iiih7cLtfqC
	 Vg3E7lWM1TJNT2aEYmBb13iFAbUsPIMnrYN4Kb/c+7vRGH2dWlUX4mMLn4l/VIuIRH
	 EGRub5LxYLjeA==
From: Vinod Koul <vkoul@kernel.org>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tan Chun Hau <chunhau.tan@starfivetech.com>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>, 
 Jee Heng Sia <jeeheng.sia@starfivetech.com>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240327025126.229475-1-chunhau.tan@starfivetech.com>
References: <20240327025126.229475-1-chunhau.tan@starfivetech.com>
Subject: Re: [PATCH v2 0/2] Add JH8100 support for snps,dw-axi-dmac
Message-Id: <171250795189.435322.14096618223992641771.b4-ty@kernel.org>
Date: Sun, 07 Apr 2024 22:09:11 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 26 Mar 2024 19:51:24 -0700, Tan Chun Hau wrote:
> Add StarFive JH8100 DMA support.
> 
> Changes in v2:
> - Amended commit message according to feedback.
> 
> Tan Chun Hau (2):
>   dt-bindings: dma: snps,dw-axi-dmac: Add JH8100 support
>   dmaengine: dw-axi-dmac: Add support for StarFive JH8100 DMA
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: dma: snps,dw-axi-dmac: Add JH8100 support
      commit: 9bcf929ba1879887e0464d06cbf9b33839572af7
[2/2] dmaengine: dw-axi-dmac: Add support for StarFive JH8100 DMA
      commit: 559a6690187ee0ab7875f7c560d3d19e35423fb3

Best regards,
-- 
~Vinod



