Return-Path: <dmaengine+bounces-7056-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D56FC32074
	for <lists+dmaengine@lfdr.de>; Tue, 04 Nov 2025 17:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02F894F5EBE
	for <lists+dmaengine@lfdr.de>; Tue,  4 Nov 2025 16:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF3D331A61;
	Tue,  4 Nov 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZAAWyVm"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71723330B29;
	Tue,  4 Nov 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273311; cv=none; b=e/n018yvlY4KVN8Q87RG2JpaHIJfKVivFf3Hau9JWTq/h7f7SWfAq4C17q9M0enrjyjyALi5Wf48swa6ZfkDGq1ANHEdyDn81H8H2FRDAkN8WoPc5HNLhK/uZ6adNyXMwX6CVj1jzCLdJYzKtIl/QO6ioLfzM3SbhLg/A0/njQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273311; c=relaxed/simple;
	bh=l28S+FPnMgtFknid2QsJQuXpj757STkW61cE7MLf4jE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WVrM2blhFI+WsE9m/VixidMBBd1PpzkXDaCPFJswBGyNlF0h8eH6H5bbDOsarH+McI3tRzn9SjmO1j7qkEOMLXNx3yHXxTLsOpzzgyv+4gfrVbACoNrfvJJpXSRhTUeO2wvSHfT9G0OiUS2JUXYFlt4rZ1VTVLGboEM9T0tJ2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZAAWyVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16E45C19425;
	Tue,  4 Nov 2025 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762273311;
	bh=l28S+FPnMgtFknid2QsJQuXpj757STkW61cE7MLf4jE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pZAAWyVm8yyj+z4LS3J7UwRoCPQVaPWfLNnBHViphbF8xJvkZE/fKVjc41pqiiBtS
	 UcivH+I35i5Ce9Cq3vJX/OjMZWD29NbcEiriBygt0yZrPz3o5ySMYhs2t1zHQjVcOr
	 ROGS0So1u4kGPjwCTU8tyq4Vcgp16rh8Ud5DEGCQHJ9ZXaxbkZeSniWpEWzfVsflis
	 z4HZIOqXutNxdPteUD+Cz7Luv+hB6Sd1NhGap/9QQNdQVIoFjIbPEMyLvomjkYi66V
	 Xb99cQzDh9+75iem5PYOIOsMb4EVzoGuljSLa974oIqn36cI1UQIPuRnIzuD07Fnug
	 GwDsSfhI0eWVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5B9CCFA0C;
	Tue,  4 Nov 2025 16:21:51 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 04 Nov 2025 16:22:28 +0000
Subject: [PATCH RESEND 4/4] dma: dma-axi-dmac: simplify axi_dmac_parse_dt()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251104-axi-dmac-fixes-and-improvs-v1-4-3e6fd9328f72@analog.com>
References: <20251104-axi-dmac-fixes-and-improvs-v1-0-3e6fd9328f72@analog.com>
In-Reply-To: <20251104-axi-dmac-fixes-and-improvs-v1-0-3e6fd9328f72@analog.com>
To: Vinod Koul <vkoul@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Paul Cercueil <paul@crapouillou.net>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762273346; l=1495;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=VqRuROAKB/H4ixEVTu/qisNNBJ8vSqHNecImOOy50LM=;
 b=QZfch/+5WxO5rLZVSf5Qd9f4DQNZJ0eKpc9rCwtBEJ5qOzFXjJrDKXKMeh6kuD6OjIllkMUsv
 gzsA/SrEyfhAJY3o0AFRLWORcjArY67KvHA5UEwjHpfgbuCFf9gvRHx
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
index 15c569449a28..045e9b9a90df 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -8,6 +8,7 @@
 
 #include <linux/adi-axi-common.h>
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
2.51.0



