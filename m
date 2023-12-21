Return-Path: <dmaengine+bounces-618-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A0981BC08
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 17:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1DED1C23E55
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344BF627F2;
	Thu, 21 Dec 2023 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5UzFxa/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1BE627E8;
	Thu, 21 Dec 2023 16:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504DCC433C8;
	Thu, 21 Dec 2023 16:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703176212;
	bh=gtLAiPWmTcmBpZUErU+NQrKyPiLwkxWEzUE6UTKHEsQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=m5UzFxa/cFVYk8a0gwpGJQwQ38VGYJGhiCwe/+JjKcJ8TK1TE47zLspSyAjE8dtcL
	 0ghvBqV8ABiYuY9nMPz90fxgwB6nU7Uw9c+IBR1Nkd3cE9+2VE8+gQxZpssnJuCbCz
	 qIXmGQSiiJ7zVuPNDvHHYCxSbYtvuWPbTwN1hMOhyArpvX8piqpDVPCR7Mz/lH7boL
	 YrrJ2VCtlwRwXkmAxhFHtbB8t9Syrf+MevmUu/Lg7Js15WLoX/6BFOTWd6ohs3I+pg
	 fRTOdblUFyj9HbdUfSG1+doqmngBdCL/i5oMDC7uW9iR/3pGk1FkJjsWNyKXrK9eDe
	 aUeWKOwvd6evA==
From: Vinod Koul <vkoul@kernel.org>
To: krzysztof.kozlowski@linaro.org, shawnguo@kernel.org, festevam@denx.de, 
 Frank Li <Frank.Li@nxp.com>
Cc: Frank.li@nxp.com, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, krzysztof.kozlowski+dt@linaro.org, 
 linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org, 
 shenwei.wang@nxp.com
In-Reply-To: <20231114154824.3617255-1-Frank.Li@nxp.com>
References: <20231114154824.3617255-1-Frank.Li@nxp.com>
Subject: Re: (subset) [PATCH 0/4] dmaengine: fsl-edma: fix eDMAv4 uart dma
 loop test failure
Message-Id: <170317620790.683420.15838999632725867289.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 22:00:07 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 14 Nov 2023 10:48:20 -0500, Frank Li wrote:
> The commit a725990557e7d ("arm64: dts: imx93: Fix the dmas entries order")
> trigger a hidden eDMAv4 hardware limitation.
> 
> Some channel require stick to odd number, some require stick to even
> number.
> 
> This fixes include 3 part.
> 1. add limitation at eDMA driver.
> 2. create dt-binding header file to share define between driver and dts
> 3. add ODD and EVEN requirement for uart driver at dts file.
> 
> [...]

Applied, thanks!

[1/4] dmaengine: fsl-edma: fix eDMAv4 channel allocation issue
      commit: dc51b4442dd94ab12c146c1897bbdb40e16d5636
[2/4] dt-bindings: dma: fsl-edma: Add fsl-edma.h to prevent hardcoding in dts
      commit: 1e9b05258271b76ccc04a4b535009d2cb596506a
[3/4] dmaengine: fsl-edma: utilize common dt-binding header file
      commit: d0e217b72f9f5c5ef35e3423d393ea8093ce98ec

Best regards,
-- 
~Vinod



