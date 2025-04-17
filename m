Return-Path: <dmaengine+bounces-4919-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BEEA9213A
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 17:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67CF67A6799
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 15:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AA5254AE0;
	Thu, 17 Apr 2025 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CU3zRACL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382CC25485A;
	Thu, 17 Apr 2025 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903140; cv=none; b=h6HDgfIOmkqvuLD84E9WwlxZ51eMdechjZxJ5x/NE8XmCftWED1YDHnLhwJkmMsHBPaorrLrOY+ZPEk+iVYRV8G5VBfqkQLgv1p3D1IpY9bOx/QVHwb9sB6PJnR9ZwV5QfVky4kbZhQqukBZnE1KjPDAOGWsUrTF0WpzdvGzhoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903140; c=relaxed/simple;
	bh=EDgRhn4uq3BXCb/NPNsZh7wuapV4L3ZwX8ojwWpuUh8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GW0VlgGFOaj357czt6BmcT40ukRLMGZGy8wqmL7Pm+Ct9tZkyaiwajkxbJtVeuVKaxdLYL1E3FmhvxTw5NcVUG5Ir3awfM4LfJ8O7cLkQcOfzY2E9azjLwEP+JGA6j+kH6o6ESQ7MsLl1ci0wbRGNONtAE0OlrGQLWn8rXa+mSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CU3zRACL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C879C4CEED;
	Thu, 17 Apr 2025 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744903139;
	bh=EDgRhn4uq3BXCb/NPNsZh7wuapV4L3ZwX8ojwWpuUh8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CU3zRACL4lCZJBMj3+cSxxFkoKz71ExLVlHPocIHlYJ8LjaywWRloGw2GvF9PQsmW
	 LXBM4i11AHkMAx9MK8MnR+YYv8H+vZgeu0b/LKWi4xvEYhPxN1JFP/oAe7MkWnRVSo
	 xjcWZ9R5k2cCRO4++3CPs6dloe4SsqSQvxKSEuywErao23E3XVOtXfOEXbXw6HADsA
	 4byJ/G9xSvUCc/uKR9QxKtmo8OcAks68iWJiRKR8c1pfifzxvcxyl++yVSDOb3FDcZ
	 YcSkFSFLgmmohHUMHEtucF/Qr1WQRmykWB+bOdqSIEjTQ/U3x6znqQo7LxrIy+K+/L
	 0CfmQ9ocFa7Ig==
From: Vinod Koul <vkoul@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: devicetree@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <cover.1741780808.git.robin.murphy@arm.com>
References: <cover.1741780808.git.robin.murphy@arm.com>
Subject: Re: [PATCH v2 0/2] dmaengine: Add Arm DMA-350 driver
Message-Id: <174490313819.238725.2166558038975296351.b4-ty@kernel.org>
Date: Thu, 17 Apr 2025 20:48:58 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 12 Mar 2025 12:05:08 +0000, Robin Murphy wrote:
> v1: https://lore.kernel.org/dmaengine/cover.1740762136.git.robin.murphy@arm.com/
> 
> Just a few minor tweaks for the issues flagged on v1.
> 
> Robin Murphy (2):
>   dt-bindings: dma: Add Arm DMA-350
>   dmaengine: Add Arm DMA-350 driver
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: dma: Add Arm DMA-350
      commit: c4771efa841666f5a202d1d651e2f0fcb315ee7e
[2/2] dmaengine: Add Arm DMA-350 driver
      commit: 5d099706449d54b4693a1c6bb7c2251072234508

Best regards,
-- 
~Vinod



