Return-Path: <dmaengine+bounces-3061-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD809681DE
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2024 10:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE891C22043
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2024 08:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BA5187344;
	Mon,  2 Sep 2024 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmkWohgZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDCB187340;
	Mon,  2 Sep 2024 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265760; cv=none; b=Smu+V6vY6LIE/BXLrANR5+fDBfsKVtfJsndHIPM1B5Kh7c3wbPue6I1dHxayZl+2/Xyk9MAkKDm1KBVURW0dgzvluG0wfcZW1FOFKIAb4G49C9bFgUyGvAX+5pSNknCF7S9h+SCEWbSmQIvaoI22g24o8iTTWm9kBLvW6g/1AnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265760; c=relaxed/simple;
	bh=idgLCuVdhmHHzXwIetQpOe0aAfVss/MkcQ74PTCPa38=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MDbIgBThohbmthFpV2x4pAmsv/DYe+dvHYymI8/VM/PHVJpeLCskuxphyW13eoxv4kJt+rMymjVLIRNvKe88jUw5B1jJzh/sROfBN1fNMFTdgmcQASqtsQAW7Zn90JGix3OxNfyz7m9ylqqxbhi+kfxqr1g5echVNttfPLCAxbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmkWohgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0BDC4CEC6;
	Mon,  2 Sep 2024 08:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725265759;
	bh=idgLCuVdhmHHzXwIetQpOe0aAfVss/MkcQ74PTCPa38=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lmkWohgZUOm0ITd3t65SVPnkFnbs/CImUv9SzV5KvXoJRRHSYmVksUqP+38XhSKTQ
	 qEbBPls/pCnQdXlWtXTNwU8cEwBXHLUnU/GGRU33DU4oytzZhtT7iEWSxg7BVwblBK
	 ky+PbK4kipMWu2yNg8e4mfYHPnQ3akD/eqljNwTD8RtRCPl4JIlswQeyma/jSk6vcH
	 TbxAVSlVkIc5TsP9LLv7w//33vGDR/Bk4JF7z0FwaoGUTJIf6ubKWo8i3E4AQhCqdu
	 JXWM2IAm6dsdeskC+O/IU8JLlAoc1HC/YYG5vJiBxy2iDXDxpdDagzO09qEhWHwSMm
	 UE7oFaoRn6h4A==
From: Vinod Koul <vkoul@kernel.org>
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20240831-fix-loongson1-dma-v1-1-91376d87695c@gmail.com>
References: <20240831-fix-loongson1-dma-v1-1-91376d87695c@gmail.com>
Subject: Re: [PATCH] dmaengine: loongson1-apb-dma: Fix the build warning
 caused by the size of pdev_irqname
Message-Id: <172526575764.510261.15886768991015863081.b4-ty@kernel.org>
Date: Mon, 02 Sep 2024 13:59:17 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sat, 31 Aug 2024 17:41:09 +0800, Keguang Zhang wrote:
> drivers/dma/loongson1-apb-dma.c: In function 'ls1x_dma_probe':
> drivers/dma/loongson1-apb-dma.c:531:42: warning: '%d' directive writing between 1 and 8 bytes into a region of size 2 [-Wformat-overflow=]
>   531 |                 sprintf(pdev_irqname, "ch%d", id);
>       |                                          ^~
> In function 'ls1x_dma_chan_probe',
>     inlined from 'ls1x_dma_probe' at drivers/dma/loongson1-apb-dma.c:605:8:
> drivers/dma/loongson1-apb-dma.c:531:39: note: directive argument in the range [0, 19522579]
>   531 |                 sprintf(pdev_irqname, "ch%d", id);
>       |                                       ^~~~~~
> drivers/dma/loongson1-apb-dma.c:531:17: note: 'sprintf' output between 4 and 11 bytes into a destination of size 4
>   531 |                 sprintf(pdev_irqname, "ch%d", id);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] dmaengine: loongson1-apb-dma: Fix the build warning caused by the size of pdev_irqname
      commit: e0bee4bcdc3238ebcae6e5960544b9e3d0a62abf

Best regards,
-- 
~Vinod



