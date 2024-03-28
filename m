Return-Path: <dmaengine+bounces-1604-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7953688F8EA
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 08:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1550E1F222D0
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 07:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB72F5380F;
	Thu, 28 Mar 2024 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uf55Rnm8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB0B537F5;
	Thu, 28 Mar 2024 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611584; cv=none; b=sfXLrdO4JiExPLUehUP5LA1mTTi7KbNEit1cZr8t8RqYZsMyabH5IEfDYuPiIqbypyqdAhSpmbZAF08oRXHnRpKwhUfXxdAe8bqcjSLMqo/Sn1Tk+CcjjyTARk3Omx8W6XOTE0ms33EDImJk5120cvxHJ3qx3QxqHUqT56z3D3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611584; c=relaxed/simple;
	bh=2vs+I5zolHQk2E65dIw1dzi8eAJzKw/knO9AxisL02M=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jIQGLOgNcw7B7PPq5P5im9qO3SZ8lOiTpQX91uvmaVRNF/iwHZ49Bw97paSfrwLJDcVXERWd+uSyMq9qTGZI6M3wNAWnQBLbWvbMSwtKic3FB4QU/TteiOwFe/xel1RnM6DCucFxLXg2GOob4vojV/XvUwp5C21BCJja1ncxlqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uf55Rnm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03F3C43394;
	Thu, 28 Mar 2024 07:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711611584;
	bh=2vs+I5zolHQk2E65dIw1dzi8eAJzKw/knO9AxisL02M=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=uf55Rnm8wGPtceZfWeWPCB+WbsTZt7q6UNBtTfnDTT4UFHHms3dpCQCr4ZG1hAlJk
	 WZYhT669LivtVWNVLbqXT2Zt7dfPrfOieZKiTtDLhxYFXJ3wgvcBFGbLvyVcZj5jTw
	 bAsFzlkY56al1n1qwZz3bFefAXwbqOIgaZ1YgY4umbOQXROhZIWgVas2HXtoxchwwc
	 PXD/Nry7Tysbo1DSr8SHwk+R5P9jqqeyVmFCmrG57DGBN5rMjUj/yWY9fSlKl4cI+d
	 h/R+HI+Y050Z3BrphRRxdKb+rHyTHVaF5na48FjC1ALD1rNTcWdUPrq/m00mI8ZewQ
	 aijVEpOzHy6yQ==
From: Vinod Koul <vkoul@kernel.org>
To: ldewangan@nvidia.com, jonathanh@nvidia.com, thierry.reding@gmail.com, 
 dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Akhil R <akhilrajeev@nvidia.com>
In-Reply-To: <20240315124411.17582-1-akhilrajeev@nvidia.com>
References: <20240315124411.17582-1-akhilrajeev@nvidia.com>
Subject: Re: [PATCH v2 RESEND] dmaengine: tegra186: Fix residual
 calculation
Message-Id: <171161158127.113367.3353184486729352623.b4-ty@kernel.org>
Date: Thu, 28 Mar 2024 13:09:41 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 15 Mar 2024 18:14:11 +0530, Akhil R wrote:
> The existing residual calculation returns an incorrect value when
> bytes_xfer == bytes_req. This scenario occurs particularly with drivers
> like UART where DMA is scheduled for maximum number of bytes and is
> terminated when the bytes inflow stops. At higher baud rates, it could
> request the tx_status while there is no bytes left to transfer. This will
> lead to incorrect residual being set. Hence return residual as '0' when
> bytes transferred equals to the bytes requested.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: tegra186: Fix residual calculation
      commit: 30f0ced9971b2d8c8c24ae75786f9079489a012d

Best regards,
-- 
~Vinod



