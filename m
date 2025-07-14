Return-Path: <dmaengine+bounces-5808-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331F3B0448B
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 17:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE044A3171
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5367925C83A;
	Mon, 14 Jul 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLiqOLKO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E67E25A645
	for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507541; cv=none; b=npHG9VCTQZP0vVTRJuHz8odQrFtqBNr0QyJBrbyiCtUbQC4Kbn5bglenK77XHK0it9TOZyvM+3Q7nMv9xliA8Tq9+9mVEPa8UChY979hrYQEYr08SxkpLVv0Vaq1BBU0DZ9gXN0LUkYrTeX5elXb2vY0VgZAZLIcTJiVZtjxswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507541; c=relaxed/simple;
	bh=Rd6o8pDXikzAlTDUKP6ZQpoh+QmeJDOhnSsyi/IwSbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gWkzDz80/IqVr/jb9p79sp7Or+iLN6qk+S4LssSNYIEQgRAy0aBE/1WDo0JeHUeLw8722AHkdRHBQEJTd+NT4uGj87RiAOTJJLCOO+3HaY7mjmqH2ybE4ZrWMQw1DkagNeBy8dQAE18WKxBoF4/6ZCeA/kZaWwQehSsz+HAmKzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLiqOLKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE7C5C4CEFD;
	Mon, 14 Jul 2025 15:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752507540;
	bh=Rd6o8pDXikzAlTDUKP6ZQpoh+QmeJDOhnSsyi/IwSbs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nLiqOLKOZG5gY7uloz6NLVz0Cpp1lXzv+GEyg1c3Lb+xACM9iFsvBqHI2RFoOeVpf
	 dbyqPkplwRzrRZT/B/bMJPUo5emC+I9Ihl3bhLt9HrCcRz9mQw6UK3G4xfQni3BdVQ
	 tB9cDHje4WbaIYBfNuznmgQoDw3zgZdm+9WJNpt+Cce3o6cgxZwtERP4N/3JuP0g6r
	 vkfu/40OD5mfu9hTRPwyL4Bt+TWPmzURD2+0S8wUlPauLn66ki19kD7/krKPqMgTyd
	 byxk66WFOVwlzDJcJnHohl2EadODa2Tjv0V+rES3lF1HE5g5n6FDhBvadPQ5GgsKIX
	 pl+Q3c2fDrIVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4219C83F27;
	Mon, 14 Jul 2025 15:39:00 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 14 Jul 2025 16:39:10 +0100
Subject: [PATCH RESEND 4/4] dma: dma-axi-dmac: simplify axi_dmac_parse_dt()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250714-dev-axi-dmac-fixes-v1-4-c3888b0d671b@analog.com>
References: <20250714-dev-axi-dmac-fixes-v1-0-c3888b0d671b@analog.com>
In-Reply-To: <20250714-dev-axi-dmac-fixes-v1-0-c3888b0d671b@analog.com>
To: dmaengine@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, 
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752507553; l=1521;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=zr8s3sNnjY22gMwbOqfgSaxAAz3Ulgnov71IpuImhaU=;
 b=S6fQccm7oco/ty5GBa1ir1qdIiwPjn8Gg8DEI4Dx3RuIflfLoVHv+a4S12plv+P/4m7pYkQio
 3XpM715qF/lB0fhrLhwzJsbGF5umhjQCsLADmXyr5O+P7DqkmbNpxzS
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



