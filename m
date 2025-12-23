Return-Path: <dmaengine+bounces-7881-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6543CD91D0
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 12:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3945306340D
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 11:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0451D3314D4;
	Tue, 23 Dec 2025 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjAtNB1h"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4973331231;
	Tue, 23 Dec 2025 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766489305; cv=none; b=D9bk/GK7qSs58JaEhF3I18+4DaCSNXsKHCxlbiMt2+T2sAMz04C/4v22RI2TeK4kMxBBCZqS7C2yR2RGwGZjl4KnEz7N0ubjLsoW/BxtLSuQ+g9a/e3UImYU6B836c8w3l8XZs4lVGG9g/lzWRbIZWANPN1lSXr6tqFsbJsr/bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766489305; c=relaxed/simple;
	bh=2zqAY6YhuR6aovqd+4F5iZK5voCCVx81r3xUyWfFGqA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E2rzpKnhZ5e//WJj/yL8d0FHJaW+OutmJ8rVLjzeFcKUNqJPo6ma6U/vrgxFr9t1BfFN2ZPHus92flFZw/6Lr5QQ8S2rJpEf1n0cutrxEmUf8GSMagxseimyaG8pUPG/h+7I2wq/KW8P0/YpdTTSIn6Yq+WsiQmVoV8lcEr1Tzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjAtNB1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C92C116D0;
	Tue, 23 Dec 2025 11:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766489305;
	bh=2zqAY6YhuR6aovqd+4F5iZK5voCCVx81r3xUyWfFGqA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FjAtNB1hNYlZ83eLUN/5mzx4g9vRuQeHTSrwoYycM5RoLPOhA4+xreuL2TwbQ7FlE
	 3qEBJvF5zgY3PJhbOwF7gGchnlljOnkfxiP6GHxtJ++h4SVq3m7AxXlLcmQK4n6kEv
	 avSeMVWoHbpap1+sflJk5SExcknRQ4sCW5W8ZTj6kw2CDr+jPEj9TfTGbV21uJ3szE
	 IMHuSa4h+liC+As7T2W56n2LJYFGH4VKVE+YrqExFhJuTstqcTyiLLM6ycOWv1ZGTR
	 iaC/V46GCGOvRluV9ggH/S7IHNrkcvIHGInUuYclsGTnGSfBKR0VSYcFs0wNZOY63D
	 ykjHDrY2qVCPw==
From: Vinod Koul <vkoul@kernel.org>
To: Michal Simek <michal.simek@amd.com>, 
 Vishal Sagar <vishal.sagar@amd.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
In-Reply-To: <20251218-xilinx-dma-residue-fix-v1-1-7cd221d69d6b@ideasonboard.com>
References: <20251218-xilinx-dma-residue-fix-v1-1-7cd221d69d6b@ideasonboard.com>
Subject: Re: [PATCH] dmaengine: xilinx_dma: Add support for residue on
 direct AXIDMA S2MM
Message-Id: <176648930316.697163.15880064963614554229.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 16:58:23 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 18 Dec 2025 10:39:37 +0200, Tomi Valkeinen wrote:
> AXIDMA IP supports reporting the amount of bytes transferred on the S2MM
> channel in direct mode (i.e. non-SG), but the driver does not. Thus the
> driver always reports that all of the buffer was filled.
> 
> Add xilinx_dma_get_residue_axidma_direct_s2mm() which gets the residue
> amount for direct AXIDMA for S2MM direction.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: xilinx_dma: Add support for residue on direct AXIDMA S2MM
      commit: 5c9142a8063f71233b25d94ae0d73e7dcf9d2a1d

Best regards,
-- 
~Vinod



