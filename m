Return-Path: <dmaengine+bounces-7259-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC60C73CB6
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 12:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 9BA9129718
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 11:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0511832ABFE;
	Thu, 20 Nov 2025 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYG4KgPa"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23192D7801;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639159; cv=none; b=tSktuDOz9gI80m9E3cjUMr5RL/YslBf7fzC4kGmKjpXkZqYiEqR2hWgaivXMEzYRuqm5wNn/Oz2YN1XNvdsS869NCxeaxlLK6qtwKTTootC1syKIIAitlVWS+A8CzENBR377A5Hp/7OzIXLCD8byNMX8BGwtdJgLXpX70/3ru4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639159; c=relaxed/simple;
	bh=roy6QMFG4gIr2L0cLNBHKmM/5UNtL9RNtGIVdBDMmdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JByc5E3ghZpUxduG1eLcp3CuC0r8A9gYCid4IkZ0tZyVc2TepEKM8gHGDHG3T98BLaZ4GpeXdUuWXpJAONPdCq1mUzlALUQBaqFLUv38K3bNf1mjKgyNBnu1HOcOw7F69GJv0c9wCcEzofqtJbdFagLSzTQw8XLfAzUPWY4RIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYG4KgPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A687BC19421;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763639159;
	bh=roy6QMFG4gIr2L0cLNBHKmM/5UNtL9RNtGIVdBDMmdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sYG4KgPa4dTcm4uDe1CpbjbYT3Qepi0yndwc+g/VfEHFNKmMRQad/fHnnM3YpabRe
	 oemw0FBkxKIgd1XFtU5At+0eLYvPg65wRWvbEt5Xy+8JWQbOXW1r1f7sBiLex4dVrV
	 l86DfkFVOTmuuTT4/kbD9aMhq13qELFTQiBA1zwvoDRKDJp9jAF1f460V5EFQjNbqh
	 /gercdiDynj7tnOawDhOe/iJ4uO92Z/w19DT1sAdJ7GA3U9dYwsBYET5enVUOXCUxg
	 3b19/aoJoMyliUezPM1IHzoIhE+vNpCFVQQwYPzTimvRpU3MZoJTELXekHHNB5yCd9
	 jIN+ApqVVpE3g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vM36t-000000002D9-3UWD;
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
Subject: [PATCH 6/9] dmaengine: mmp_tdma: drop unused module alias
Date: Thu, 20 Nov 2025 12:45:21 +0100
Message-ID: <20251120114524.8431-7-johan@kernel.org>
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

The driver does not support anything but OF probe since commit
3b0f4a54f247 ("dma:mmp_tdma: get sram pool through device tree") so drop
the unused platform module alias.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/mmp_tdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index b7fb843c67a6..6186b9dc5457 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -743,6 +743,5 @@ module_platform_driver(mmp_tdma_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("MMP Two-Channel DMA Driver");
-MODULE_ALIAS("platform:mmp-tdma");
 MODULE_AUTHOR("Leo Yan <leoy@marvell.com>");
 MODULE_AUTHOR("Zhangfei Gao <zhangfei.gao@marvell.com>");
-- 
2.51.2


