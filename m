Return-Path: <dmaengine+bounces-7263-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4174BC73CBF
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 12:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 7CA122AC4F
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 11:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCF632F741;
	Thu, 20 Nov 2025 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujcB4IA6"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03142326921;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639160; cv=none; b=GzKqTtWJlVuBXHCrg3V21CZ4IW1B6n55tkQDWlByn40t90SCzgcW5h/OyxCgx9LbAtM8WGzVAkBNeolYV3A4867FY4TcZSPqFBTFJvqruJYI1vMebm+WGN7Yc7hgfOcnetmsYf5rRwX02GartufqnLzC6BKeTCEQSYct/vADbTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639160; c=relaxed/simple;
	bh=kU+WADkV2y2yNK4d4L0JrDTb7z9c0e+c6t9PGw3bHL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFyxiOwnVdzlP2rehl1SEHJ41kBVi57apUehnFm4NE5ENY5xj/9yMbBYN0WmFFEheEpaKrOZJn2jrs2Q74cIT2GbBB9jacdOV5Hy8J0mey3bNP+OkO2xP1sKY2+BYS0IjPXAtKg6NbumGYN9bMxI1l4bkNKLfTuwMLd8s4iY4+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujcB4IA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D669DC4CEF1;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763639159;
	bh=kU+WADkV2y2yNK4d4L0JrDTb7z9c0e+c6t9PGw3bHL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ujcB4IA6GJoOSkd2Bim/+6oOKv8idVUAfNbfN38Ee26xyMfyjhaaoiPAKOrou+wf4
	 QhY6Zsf7VwEK3h8cPB8ggtegcH/DgY7t3BpUXd1DoWQtwVikmqb9nvSWei78Dxol5S
	 F7a57OJ6UJUCOnIh10eikzKkvep5snXsAyZ5kD4Qfx+QmvxZYHWkHEt3j6hu4jCYqY
	 0InV7lsFfHDgB7OAA2esQwtJIQZ/y+wzab1Sl4rO1SfFBh8R/0AE1vasRxZkNGghJX
	 AsnxaUDexqoVTgqELXQa/XIaW21pBYEwFw+Lv1KfY+BOpqHOEYV2bnS0T9q01btwp8
	 7X0FagxtxrfMg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vM36u-000000002DI-0MeZ;
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
Subject: [PATCH 9/9] dmaengine: tegra210-adma: drop unused module alias
Date: Thu, 20 Nov 2025 12:45:24 +0100
Message-ID: <20251120114524.8431-10-johan@kernel.org>
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
 drivers/dma/tegra210-adma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index fad896ff29a2..d0e8bb27a03b 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -1230,7 +1230,6 @@ static struct platform_driver tegra_admac_driver = {
 
 module_platform_driver(tegra_admac_driver);
 
-MODULE_ALIAS("platform:tegra210-adma");
 MODULE_DESCRIPTION("NVIDIA Tegra ADMA driver");
 MODULE_AUTHOR("Dara Ramesh <dramesh@nvidia.com>");
 MODULE_AUTHOR("Jon Hunter <jonathanh@nvidia.com>");
-- 
2.51.2


