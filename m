Return-Path: <dmaengine+bounces-6375-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC3AB42E67
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 02:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082DA5E860E
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 00:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12E454739;
	Thu,  4 Sep 2025 00:49:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EBA29D0E;
	Thu,  4 Sep 2025 00:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756946949; cv=none; b=j7AlEnLsaPfH3cIvNQrCWh0Ry0TX/3iq+utr6nuIO3fUnl/YDjlByj4zOwqn42AWGAggkgZ40IUPE9822/XB85G0KOtCefbFzKTI9npFKO213MI50eQFHHafwlvb41WHMzMmmd5BfILLGGMfFktJAgK7PJNPlx4txiC3nxi6YhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756946949; c=relaxed/simple;
	bh=28y1zIQyJiGZzQIxWbG5Hf7wSqA8bRW9Snz8MewVNoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAIYoC3qcS9brMUbvayl8N0E1mu9T/ty5WDqvLLDPDvlgYv1eNKrvkmpgANA/3j4TkH1dklL7nzx4aI/Uj+Bp55zPDW0+qjhm3hEjmzVgNe7c3a/PWW4OWazab7HYwHcdkZcIV0UXT74cIK485o6gd6pFYaQPro59X7ys0YnP/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from ofsar (unknown [116.232.18.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 62C68340D9E;
	Thu, 04 Sep 2025 00:49:01 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	duje@dujemihanovic.xyz,
	Guodong Xu <guodong@riscstar.com>
Cc: Yixun Lan <dlan@gentoo.org>,
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
Date: Thu,  4 Sep 2025 08:48:45 +0800
Message-ID: <175681694608.479569.7465779228756094615.b4-ty@gentoo.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
References: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


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

Applied, thanks!

[6/8] riscv: dts: spacemit: Add PDMA node for K1 SoC
      https://github.com/spacemit-com/linux/commit/81d79ad0ddcaeaf6136abe870b2386bde31b7ed4
[7/8] riscv: dts: spacemit: Enable PDMA on Banana Pi F3 and Milkv Jupiter
      https://github.com/spacemit-com/linux/commit/0e28eab0ca51282e3d14f3e2dba9fc92e3fddbe6

Best regards,
-- 
Yixun Lan


