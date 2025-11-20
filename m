Return-Path: <dmaengine+bounces-7258-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2035FC73CDA
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 12:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BCDA4E44DA
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 11:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69102FBDE1;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oawEqk97"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED6B283CA3;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639159; cv=none; b=fmhiE7SUsZLgf1C1dQMRzVcBh5tPF7dOs1fJtxwK9lQ+CsCz5E5xW8ltB0OXs7LuxxD8SPoeJOVM7cgMbQsaVnTbw22vNsstb0+aiwKGqHDqGxfRuqXJrtY3vEG+f4OF5vHJdmhhgT7jvqtcJqWjLlHR2mjmhNILuWmJMYUa/mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639159; c=relaxed/simple;
	bh=fGsqmoURd6zag1129NAAZ9UDo+qN/BdNT5ORw9tm1l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oth8G7g2dltDe7JAtfDELDrcOw2VuSHO6AX6WTV/rddzq+7vfFdXNNwvC52Ue5kzbWQ7qFK+KnjV8il2nSly5gLiOwfaOQWSSMIh2p5Xt+xr3ZG+sqeSKx5TkezNrVlEuAohhLQKllsmkQcRexHa6DIcdmXWZg+NSxUhc8zywOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oawEqk97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EC2C116D0;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763639159;
	bh=fGsqmoURd6zag1129NAAZ9UDo+qN/BdNT5ORw9tm1l0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oawEqk97tRqj+WWPAqFiqFPYCFLDWuzzmzwj4AKwW/Etgj4Qyu/3DOirScJCfdM0+
	 vf/+CfCqfsdJw8a325Ax5uR6mRtzhhxQ6j10UBmWuPr2+3o7RUa7GIyPsF/w7CPXiv
	 Pj6s/7/P7N6QyLXPcaR/FbIojZmW2IER2R8A/qYTB5/VgssYkJ78QN9JLM/eDY00Xl
	 gHTRVSR9k8WCb+nFoTlpu5WFyWHj4V7RlVqbQ+n0QrrOi0u87RybE4KkF7euBrdobe
	 TXOBfFYw59liqbb9hPe3OEpsCHhPpYIuApjNqNCSeRP9FeadqzFaPW0JoJGbXGYvg9
	 WfpPDYjyoZwAg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vM36t-000000002D3-2jzj;
	Thu, 20 Nov 2025 12:45:59 +0100
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
Subject: [PATCH 4/9] dmaengine: fsl-qdma: drop unused module alias
Date: Thu, 20 Nov 2025 12:45:19 +0100
Message-ID: <20251120114524.8431-5-johan@kernel.org>
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
 drivers/dma/fsl-qdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 21e13f1207cb..6ace5bf80c40 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -1296,6 +1296,5 @@ static struct platform_driver fsl_qdma_driver = {
 
 module_platform_driver(fsl_qdma_driver);
 
-MODULE_ALIAS("platform:fsl-qdma");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("NXP Layerscape qDMA engine driver");
-- 
2.51.2


