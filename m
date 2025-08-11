Return-Path: <dmaengine+bounces-5989-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C31B21128
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 18:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D18A6869C2
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 16:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9032D47F4;
	Mon, 11 Aug 2025 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhewGO+Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AA32D47F0
	for <dmaengine@vger.kernel.org>; Mon, 11 Aug 2025 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927797; cv=none; b=HvR/KShW8RXa0WHQdANY1KM/p9hiRIWIAMypt7UDw81SEs4/J5PzprSZw3kcWPG+h3V2WQB9sEWA9krGgmYntwZw87B+agxPBT6M2YUtELWkuhYKM46bDZ711QLVbGsny0IkFQstMVjuPMpgH5B4wDGWZcqC00hvL8fSy7NPre0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927797; c=relaxed/simple;
	bh=Rd6o8pDXikzAlTDUKP6ZQpoh+QmeJDOhnSsyi/IwSbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JF2VjsKkFK+McDcKIbo9UtgnXD3c6D0fVotTMyfU1c0ekyGCg14sneQLezEdRYjNHB0SX87/p02d9StaT4qqT7vNxE0wxqLHBRJj4q0qrd5gLuHva/FD5on/NlFHYg2P2wf06vMoQp2joOadqtsAk4S9fv93T1vpg3Liogffo5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhewGO+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D28E8C4CEFB;
	Mon, 11 Aug 2025 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754927796;
	bh=Rd6o8pDXikzAlTDUKP6ZQpoh+QmeJDOhnSsyi/IwSbs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IhewGO+ZdE0Uy1NDmo5ACiL+A+c7h48IZUO+iEUocH7+pHSWYcnrZrJGhAzF3vtAg
	 eY3JFZrcZHw6PfbeXUCwTgwHddXGoeoxIEOmaw7MwkD4NLFGS1XkEAqorgCDSfWxdZ
	 oB670AW26fGfxNebrO5wI2GHdenjwae33h3qg2+C/r1w6fP3AgJ9OdXvG97cD64/1B
	 kH93OP3CPkA5OyvM0rFEYaRq3Sk7a7LLv65rWQgqW6l5zS8wVdr+llCPQOVhm0UXLq
	 FNizng4fJyBuwa2ie+WIR6kFtEPl0ELhPgbSguKZHNhfAENs3Qyt1EplFkiz3ksba0
	 RK3HdV5ieWU5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C523BCA0EDC;
	Mon, 11 Aug 2025 15:56:36 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 11 Aug 2025 16:56:39 +0100
Subject: [PATCH RESEND 4/4] dma: dma-axi-dmac: simplify axi_dmac_parse_dt()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250811-dev-axi-dmac-fixes-v1-4-8d9895f6003f@analog.com>
References: <20250811-dev-axi-dmac-fixes-v1-0-8d9895f6003f@analog.com>
In-Reply-To: <20250811-dev-axi-dmac-fixes-v1-0-8d9895f6003f@analog.com>
To: dmaengine@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, 
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754927814; l=1521;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=zr8s3sNnjY22gMwbOqfgSaxAAz3Ulgnov71IpuImhaU=;
 b=/9zIhg97WgRvx1wq+Sk32F8dUuDuY3Gsx18g6z+PVDtavfmOjMTV/Pj8Rytf4EuvcNvxK43/h
 hEpn5lOsKXmClLoY4I8xmBu1t4bwFggcnzCi+/IN2/IErrjg2nzJOzI
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
2.50.1



