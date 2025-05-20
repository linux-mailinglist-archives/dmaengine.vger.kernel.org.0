Return-Path: <dmaengine+bounces-5214-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DA4ABD96F
	for <lists+dmaengine@lfdr.de>; Tue, 20 May 2025 15:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D79618870B1
	for <lists+dmaengine@lfdr.de>; Tue, 20 May 2025 13:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90C824290C;
	Tue, 20 May 2025 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJIK8Uva"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5B822DA16
	for <dmaengine@vger.kernel.org>; Tue, 20 May 2025 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747747910; cv=none; b=mSZXzLE3es7ny8X0DkpvtX+Q/mWhsMnCb8xAPbL0ZzcqZz51VULtAWamZiht4WMkpymDlTIeWJ+GRJx612CTmREZZC/tSSLhxBdtdUNj1KkehNPCJhH7TdFzA52e/mm8nTaMFlqfFTDFwNtcXLR89vMTChMzvmtUd6Ry806VlYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747747910; c=relaxed/simple;
	bh=kiMLD24nbhQ2c7z1BH8VGCJ87iZfdGhW+mxk6hvCkcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GxgZKDGkjgd0tASgJ3ts5ZaIx1Cq/YH6/1KFxDp8JA1jR+rA8pudQV4S9V9I7OY45/0WCNYyZiAdWHE1Pt6aJcwghZfERz9CvjkTv0d41+9cIEgnlp6a8v84d1DMrvpTP+k/z8DIU5Uk2TAKpsgMjtBUaAtw/S9KJfK0OlxpA4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJIK8Uva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3976CC4CEF4;
	Tue, 20 May 2025 13:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747747910;
	bh=kiMLD24nbhQ2c7z1BH8VGCJ87iZfdGhW+mxk6hvCkcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PJIK8Uva/sWwr6li39H0w4+XLeuT+C2hEw4djXvEhwtROJI2ZEo6Kk7l2MnEd3D19
	 kmfkoXPXOSibbg9Irp+CVEG3FpgPTdvvh9BO/q5iUrgwAM6HLu0hw+umyVl11Sp7dx
	 CWVcV/ezXx50sb3KBQZGRTs4m9paa0qOTGonn1A3z+YdQYHvPHYLi+UxtBUhCYz7YI
	 IuUy/9T2ne5wfg36++aE4NmTTUZ3JT5dMz2EvtKJ3vsL5x13WMESfyXjgWa7LyFZ61
	 iRu/q81SyosxdutT624UYUlhjf71Y+tbmAG9RjjVFpDXv6CI2FNQU/2NSU3VrLS9ps
	 hq/1jYnjhh4XQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA26C54E65;
	Tue, 20 May 2025 13:31:50 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 20 May 2025 14:31:54 +0100
Subject: [PATCH 4/4] dma: dma-axi-dmac: simplify axi_dmac_parse_dt()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250520-dev-axi-dmac-fixes-v1-4-b849ea23f80b@analog.com>
References: <20250520-dev-axi-dmac-fixes-v1-0-b849ea23f80b@analog.com>
In-Reply-To: <20250520-dev-axi-dmac-fixes-v1-0-b849ea23f80b@analog.com>
To: dmaengine@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, 
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747747912; l=1521;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=dIUKoGAAnK7SSnlSFeEcmY/rlMpKq1hPjDfYUQ18lCk=;
 b=JImf+ejkMEneGDWAfGWIPgYvyRR3xTYBmucLT64Gglk9jMFpLLXA0hVzVHmvN768XDSYg5pt4
 lk7RvNRek4TC/CKxXwZqecKVEgPG36JKyEI+mp3ZC4oyQoO0VKAK9R3
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Simplify axi_dmac_parse_dt() by using the cleanup device_node class for
automatically releasing the of_node reference when going out of scope.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 25717a6ea9848b6c591a3ab6adb27c6f21f002b9..035fc703506977ad59fd0b6ee8a8e5858d2c120e 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
@@ -927,22 +928,18 @@ static int axi_dmac_parse_chan_dt(struct device_node *of_chan,
 
 static int axi_dmac_parse_dt(struct device *dev, struct axi_dmac *dmac)
 {
-	struct device_node *of_channels, *of_chan;
 	int ret;
 
-	of_channels = of_get_child_by_name(dev->of_node, "adi,channels");
+	struct device_node *of_channels __free(device_node) = of_get_child_by_name(dev->of_node,
+										   "adi,channels");
 	if (of_channels == NULL)
 		return -ENODEV;
 
-	for_each_child_of_node(of_channels, of_chan) {
+	for_each_child_of_node_scoped(of_channels, of_chan) {
 		ret = axi_dmac_parse_chan_dt(of_chan, &dmac->chan);
-		if (ret) {
-			of_node_put(of_chan);
-			of_node_put(of_channels);
+		if (ret)
 			return -EINVAL;
-		}
 	}
-	of_node_put(of_channels);
 
 	return 0;
 }

-- 
2.49.0



