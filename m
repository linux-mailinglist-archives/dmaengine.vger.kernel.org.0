Return-Path: <dmaengine+bounces-2803-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE1794806D
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 19:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E321F23A7A
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 17:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4250215EFA6;
	Mon,  5 Aug 2024 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIGmDgCi"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1122D15ECFB;
	Mon,  5 Aug 2024 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879485; cv=none; b=tCfPiYXzPohHgtKUGAY6koUEZRnrU77ZfJba7hCq70taU6lfUtu3MftFcQzs9gKFwuD3zSVQu58GeBqKKm+zjk1RwudvtjDncK3xbr/pt24OEpzn7/ijXE4i6uE2s3yIS4Q16BR4liS4Pmp4FZfUfSwcKAZYTlV0o7i1sNWRId8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879485; c=relaxed/simple;
	bh=KFH4+hoD9XuYSQpXUgYBPFSN1NDPjp3nh1R+qPccr9w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qdpTp+rrvKb81mQXriAtOgdyFJfoWV3g9pNyJDCyvYGDh6ioJF2LetAHZPygj78gp+vx7X22OX4Wpt3B/XmM95+LlM3FSUX1fKASssVKeYA2V5sb6/PWNxPzRp3G7HbofgXjjCO8T4sI1TvTyW9GTlHUQgPs/XAcUwiv01g0BfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIGmDgCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B01C32782;
	Mon,  5 Aug 2024 17:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722879484;
	bh=KFH4+hoD9XuYSQpXUgYBPFSN1NDPjp3nh1R+qPccr9w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jIGmDgCifmHgJgnRpBfH4w9R5n0wDfJF2iHBQXhKzD/NUckY7Ug9GOTEjeStfHqmo
	 pPMS8TQ5S7vxijcva8OVzRZuDQ6TAeOufjhjOscnESj8lgi3nTmPo2GJUlqFF9ao7z
	 IEEvixYAR/tJ/AH+FmwlPcMSa9xVfchG3hloDGBVtKVZn1VBbFxNDEkyXgI8BhGUQb
	 j+ZnwIoO3YxcJMwEJpo48Mg0qZoyodsKwEvr3tEKN7XxLfulLpclUR4/dhdq7T+y+S
	 F6PL2mmjLLrBc/CyRItE/eu6gIXaah3bDXl1QrOzGPmQrhzLlu5SL2I+5fv3MmqfBY
	 08rLiKCkvUQYw==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20240704020802.3371203-1-Frank.Li@nxp.com>
References: <20240704020802.3371203-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v3 1/1] dt-bindings: fsl-qdma: allow compatible string
 fallback to fsl,ls1021a-qdma
Message-Id: <172287948210.489137.3448026012813865082.b4-ty@kernel.org>
Date: Mon, 05 Aug 2024 23:08:02 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 03 Jul 2024 22:08:02 -0400, Frank Li wrote:
> The IP of QDMA ls1028/ls1043/ls1046/ is same as ls1021. So allow compatible
> string fallback to fsl,ls1021a-qdma.
> 
> The difference is that ls1021a-qdma have 3 irqs, and other have 5 irqs.
> 
> Fix below CHECK_DTB warning.
> arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: dma-controller@8380000: compatible: ['fsl,ls1046a-qdma', 'fsl,ls1021a-qdma'] is too long
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: fsl-qdma: allow compatible string fallback to fsl,ls1021a-qdma
      commit: 0204485c5a1e2de00acfd83c3931bd9dc6493c64

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


