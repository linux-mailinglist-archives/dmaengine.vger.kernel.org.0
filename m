Return-Path: <dmaengine+bounces-7260-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A4AC73CBC
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 12:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 6D1932AB71
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 11:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C0532C92E;
	Thu, 20 Nov 2025 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnVsGqsF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EC72D7817;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639159; cv=none; b=RShi3KAuF5hxXhN4HV4GQu0zQPRay/FJ4/3og6/GK2W3V2hGdvin4oXsTx2py5lvVHCDysYzqQ9VNDrocbMKi/XE76a9PpKdO8vKhJ8nBqdlvnZReQ1QCS4/P3aUHpBp0nDg4O+ou3b98G8V4Tt6ljfdcnbJNK5kz3s9mlotUEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639159; c=relaxed/simple;
	bh=t6TPp1lxnWu+MEOV8HYOzH4dC/oirYCfuWItPIUKI8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMQ7TFx3kZfqdtkHfOhfxWcWH45eMkh5hW1BO5lYV6Lhf6Atc3rnpEw1GrbsTsg51diZv/VucqMgOS/Qfvdz2zWRoZQSmzHN3M2C9qeAqxNxD8wbv1hJqtfCEJspBS/n4vJxeQMCUjRAJ9Ic76geU0f1/iU48LR5gx/RWSB5Ykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnVsGqsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A703C16AAE;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763639159;
	bh=t6TPp1lxnWu+MEOV8HYOzH4dC/oirYCfuWItPIUKI8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nnVsGqsF5QoPPjUrRyjbsf2iw3xhcIHprC2IabWRrR8iSycCNdEK3275AfaodqgBq
	 UGyZk5WteHrko4a7vOFuGhwgi4o309kM05cLtZ3VUMW4w5KPgIaf/G4M3x0ew0uw/O
	 CHWs2gRaCVAhqmeOTCMd9MjEjtWSpzw/KK53CL6fsnlC8E0tPTEf04CkP6aePd7Kox
	 oa7nqAZTevLdssFIdgyv/4DRvHsP4ckjeOJD+Gka/tgg9zeEOgqO3Os0TorD4U0fzs
	 OBRpgpsrsWUooueNaXSjWx5Riffd7xDz1H4kz1oa8KDRIMMqtTliSt5IGt90Wr7n9R
	 66IM7lEVx4dvg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vM36t-000000002D0-2PH5;
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
Subject: [PATCH 3/9] dmaengine: fsl-edma: drop unused module alias
Date: Thu, 20 Nov 2025 12:45:18 +0100
Message-ID: <20251120114524.8431-4-johan@kernel.org>
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
 drivers/dma/fsl-edma-main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 97583c7d51a2..a753b7cbfa7a 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -999,6 +999,5 @@ static void __exit fsl_edma_exit(void)
 }
 module_exit(fsl_edma_exit);
 
-MODULE_ALIAS("platform:fsl-edma");
 MODULE_DESCRIPTION("Freescale eDMA engine driver");
 MODULE_LICENSE("GPL v2");
-- 
2.51.2


