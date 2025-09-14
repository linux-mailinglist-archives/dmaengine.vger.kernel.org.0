Return-Path: <dmaengine+bounces-6504-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D057B56A42
	for <lists+dmaengine@lfdr.de>; Sun, 14 Sep 2025 17:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E5D17C1FD
	for <lists+dmaengine@lfdr.de>; Sun, 14 Sep 2025 15:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55102D0C95;
	Sun, 14 Sep 2025 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGrCk1KX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46C819DF8D;
	Sun, 14 Sep 2025 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757864317; cv=none; b=nYGAkomMr6EHoVHA9Qs4FBJB68d+ggNAV/OPqoXmytJB6O5/yEx7/yv5X0SueU2d0JE136luv0ThxeoRcK2LKj3zwJG+LHO9Xt618Mv7GQ85/q2lXl85D+vNdoG6Lggx/sWoxS7wR1xTbmZhOAAEWeqK1bTdBt2toZG44DiYUUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757864317; c=relaxed/simple;
	bh=ihW47HHuEW0kivT0LtQDfndFpj4gQlPyOZ8ChekheGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcnklD3PtabUIE05b8UDdmZINdY3xrjsPI+kLq/7n4SNU7/Hkhvn33rOCUs0odoJ9kB9iCgOcHlwWO3JKCSMMtrTyolSrV+l4xoPZLM52dAqKArDrFTxsYTky+Bv2bcEVUGebNdUIMLnRQdPqoEG5IP8MvU1fxQf4vQIBuVD+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGrCk1KX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D7FC4CEF0;
	Sun, 14 Sep 2025 15:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757864317;
	bh=ihW47HHuEW0kivT0LtQDfndFpj4gQlPyOZ8ChekheGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UGrCk1KXR+kac/5OvXpvMS9DC7fpHqSkremvp3fzsvyb6prDigqDylpNSPElqidS8
	 2otZXTknq+IJzTf5PFAMGbUSxGzxhWpaKhkmOQrn+AgAeY7zJtG5GJBBx5b2ZgfLA4
	 KHWVBm/EMps/giN+yPji/JWLF5ESMN0zLZgjtT8uX25haYBS7eQRy2q0QTZeuR1AgC
	 U0QhhxpiJ0NovZt8fUsZNnErPb477tzXnicb3fCOaGxLE/DO7Y4OBBMQ82TvQyR7yW
	 /xsM67WgIOTtNXCzlJNRFq7IXj7X4QlJmgiq7XSOq4oXJtHlf94QGVuz1QHRwydKOM
	 D0pF/zMF4y4QQ==
From: Conor Dooley <conor@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	duje@dujemihanovic.xyz,
	Guodong Xu <guodong@riscstar.com>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Alex Elder <elder@riscstar.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: (subset) [PATCH v5 0/8] dmaengine: mmp_pdma: Add SpacemiT K1 SoC support with 64-bit addressing
Date: Sun, 14 Sep 2025 16:38:27 +0100
Message-ID: <20250914-crushed-blinker-9827464897d2@spud>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
References: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=682; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=W90YfP75Cf8fElnrlN+vBYi5av5KHOKCWFABavcr0+U=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBnHHpaICZuwn2a+79lfyGly/JXfDkGVa9m7o3VK/p+2c DvWUc/WUcrCIMbFICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgIlMtWT4Z5bI8PIWX4pvgvcz yYkPbJi33Tc82/TjbO4tBf0I34nNcxkZXvoc+cP8oOHAIyPPU222uyv9jMTe6ik9fPelq8PqQ7E ECwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Fri, 22 Aug 2025 11:06:26 +0800, Guodong Xu wrote:
> This patchset adds support for SpacemiT K1 PDMA controller to the existing
> mmp_pdma driver. The K1 PDMA controller is compatible with Marvell MMP PDMA
> but extends it with 64-bit addressing capabilities through LPAE (Long
> Physical Address Extension) bit and higher 32-bit address registers (DDADRH,
> DSADRH and DTADRH).
> 
> In v5, two smatch warnings reported by kernel test bot and Dan Carpenter were
> fixed.
> 
> [...]

Applied to riscv-config-for-next, thanks!

[8/8] riscv: defconfig: Enable MMP_PDMA support for SpacemiT K1 SoC
      https://git.kernel.org/conor/c/3df7ce0e43ad

Thanks,
Conor.

