Return-Path: <dmaengine+bounces-7264-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCBAC73CCE
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 12:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72F02347039
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 11:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4495033121C;
	Thu, 20 Nov 2025 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOurhnwf"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A7A331203;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639161; cv=none; b=dqQP28L+JCAGg6/AntqOO/FIlu3fcVVBiYdvm75JJ926GqCEvcnnLG/ZN1PRpkpz+mLNZNzJ+mn1sRrnm/z8Z2ttF4fBeQRoXXwuhbgIFzl5CkZzz+GwmzALfd7yjDEBI1glc+pDhR90qCwwtsy9BGr/wXQWEWjDpItMerXIxlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639161; c=relaxed/simple;
	bh=v5HtxW3ky1lHVbjlzpylRqpq8KOcLif8Q/vMkgK5c00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dx7Bhe07TUmBgB5CaTCK+MVnyqere8OXH4zgZPHAtw42tzKS6CQOl+JCvrwvcHnRUQLZW+jscDv+gbUpqan50zHBP/oCW3qLCVZgJ5U8Mk7qVJ88877T1Q2Ufj4528sBW+GvfXeu4uuYjUeA7w0BKUqMKQCqvxFWO/vaD36r0D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOurhnwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F41C4AF10;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763639159;
	bh=v5HtxW3ky1lHVbjlzpylRqpq8KOcLif8Q/vMkgK5c00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QOurhnwfZVvgOcKh0NTj/eLiEER/zbC+B5kIi6UzFenDn15S/GlBsVqGeNVYB6YRA
	 EvYFA/ozBMcg9Vx7HzuinOVYVelNyLbYAdg9VAl9Nycjn5VReKUogq7fTtjYjnEbJa
	 WQIW+uAnMq772GCp/oBgqHcf/3naZgZ912fqbncOq5lJBU1g3IEl9g3BOorUMlOzOH
	 FmYwqgrxUYN9221uMK1wVn3Cn7urbyRHUhys1iiY9RxsbSn/QE6tiLBaWVt9mQpLMM
	 FJTxI4zl/94N4dyoFNt+2aLsiXqKw4AOE7dHzue8CC47him27J88qkbcQQG22Z+35u
	 oNnvBoFqGd2zQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vM36u-000000002DF-030f;
	Thu, 20 Nov 2025 12:46:00 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 8/9] dmaengine: sprd: drop unused module alias
Date: Thu, 20 Nov 2025 12:45:23 +0100
Message-ID: <20251120114524.8431-9-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251120114524.8431-1-johan@kernel.org>
References: <20251120114524.8431-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver has never supported anything but OF probe so drop the unused
platform module alias.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/sprd-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 187a090463ce..6207e0b185e1 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1311,4 +1311,3 @@ MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("DMA driver for Spreadtrum");
 MODULE_AUTHOR("Baolin Wang <baolin.wang@spreadtrum.com>");
 MODULE_AUTHOR("Eric Long <eric.long@spreadtrum.com>");
-MODULE_ALIAS("platform:sprd-dma");
-- 
2.51.2


