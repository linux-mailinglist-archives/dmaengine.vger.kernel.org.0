Return-Path: <dmaengine+bounces-7883-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4650ACD91DF
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 12:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76191308209F
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 11:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09804331A65;
	Tue, 23 Dec 2025 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzkSYThX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB232BF2F;
	Tue, 23 Dec 2025 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766489312; cv=none; b=GMgplwPM8F5KNl+ryi5KzhRmcuDGYGwrkWTC72d27UzTC4IUwMDjSOtnqd1CpvajsHdpQG1WLqlIUnkoDAjwXERX/Wi2a7Q6QJTsEvYaAk0e+iG/N8iOvRDou9jOmzfnQtzcyAcXgAcWkYjj4Z15nHFK8x8wZvl/F8EaAi9zXsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766489312; c=relaxed/simple;
	bh=DrFdDG6IvSD40UbQviAe9Hu1ENooMM/4w95t2G/Z3ag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KCF0QJ61jE91iW9GzVsyGYXRlVuJQG1TgSJPqITPgHPzo/bYGYgwuZoqCv0SNLRy9Sz6Oe6ckSoD1qgc2GzXRh+Ae9Qgxnvpy0oVYzd/og5pf/Lwx6klaRFRj0pdOdQH0DgKtBlHvB2Nch8axIYqK5TDuW13mO0P9o5IiaAdNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzkSYThX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035D6C19424;
	Tue, 23 Dec 2025 11:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766489312;
	bh=DrFdDG6IvSD40UbQviAe9Hu1ENooMM/4w95t2G/Z3ag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AzkSYThXqZHzQOmrf/zMBBKv4KhWOl0FiqdRWP7lPm49CsiCIK4qTWEpKmF+TBqQ3
	 GkBpGVTce/skOn3alymq8zP7KyNT1JdBa3H9iOOppgZw4Ng/TaSLxzSXR9peqY19Xj
	 76SFoEMldM2QxK75XRGE8EDePqmG0V7+pIHPAVKaNUy4SdYY073vQpWK3divFjojrJ
	 0yU6TeMIxzJBs3pT7hJ65bVrQvR7XYGSKtbWlZ9yJMYWxYv/nO8FGne8Btbb3q6syI
	 02xTZ6++14YRGtgpzB7pPWDYajptWCZ5fUFFswGTxvIFZWHGpKGFYy+F29Oo2PfZxr
	 C4DVDowPfK8qQ==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sean.wang@mediatek.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, matthias.bgg@gmail.com, long.cheng@mediatek.com, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com
In-Reply-To: <20251113122229.23998-1-angelogioacchino.delregno@collabora.com>
References: <20251113122229.23998-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 0/8] MediaTek UART DMA: Fixes, improvements and new
 SoCs
Message-Id: <176648930864.697163.15382813689450810341.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 16:58:28 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 13 Nov 2025 13:22:21 +0100, AngeloGioacchino Del Regno wrote:
> This series performs fixes the MediaTek UART DMA driver to be able
> to correctly program AP_DMA controllers that support extended
> addressing, performs some cleanups to improve code readability
> and adds support for *all* of the SoCs generations that are upstream.
> 
> This includes MT6795, MT7988, MT8173, MT8183, MT8186, MT8188, MT8195,
> other than all of their Genio variants (where applicable), all of
> their Smartphone variants (where applicable), and also some newer
> generation SoCs that are in the process of being upstreamed, like
> MT8196 and MT8189.
> 
> [...]

Applied, thanks!

[1/8] dt-bindings: dma: mediatek,uart-dma: Allow MT6795 single compatible
      commit: 4b9ce35ca5924c195df1a6bbccdc9aae4f5cb422
[2/8] dt-bindings: dma: mediatek,uart-dma: Deprecate mediatek,dma-33bits
      commit: ebc5e9176e0f9b7effc259b58a7387019ac8811d
[3/8] dt-bindings: dma: mediatek,uart-dma: Support all SoC generations
      commit: fd7843f0da58b37072c1dafa779d128bb36912bf
[4/8] dmaengine: mediatek: uart-apdma: Get addressing bits from match data
      commit: ff81a68a87b1dbf5c1b819f240f83715c701ef0d
[5/8] dmaengine: mediatek: uart-apdma: Fix above 4G addressing TX/RX
      commit: 58ab9d7b6651d21e1cff1777529f2d3dd0b4e851
[6/8] dmaengine: mediatek: mtk-uart-apdma: Rename support_33bits to support_ext_addr
      commit: 7cb173936858f2278d9cf8b2f5d7d52fd000e54e
[7/8] dmaengine: mediatek: mtk-uart-apdma: Add support for Dimensity 6300
      commit: 391e20f21cfdee2f55f2274e83b37c03199062ea
[8/8] dmaengine: mediatek: mtk-uart-apdma: Add support for Dimensity 9200
      commit: 3587b2b6bf7681835c7c366c6083e2cd9e4b519d

Best regards,
-- 
~Vinod



