Return-Path: <dmaengine+bounces-5671-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9843BAEBAD9
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 17:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E893BEDBB
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 15:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621E52E88A7;
	Fri, 27 Jun 2025 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5GxjzJl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E80F2E7F3E
	for <dmaengine@vger.kernel.org>; Fri, 27 Jun 2025 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751036421; cv=none; b=OmkoIY0jG/xmiQPYFQ2YNVQPOUzHev2yIMNoD3X6R87xAjchy77Ocwmcqm6DlFeBuGIlXRQloijlyqUdznKiAmq1Vl84SnaU2XsdAXX0R/gmdpNPaaOOkeXTVae+o3VLRNc3DlqhMoIeKCELSd3T/c+DF5o5HQ4A/bKTq3makCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751036421; c=relaxed/simple;
	bh=kiMLD24nbhQ2c7z1BH8VGCJ87iZfdGhW+mxk6hvCkcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hcQL4cVTq5kxGpQIqWKRxmVUgRraSVVqNhII5AvZ0qDRO51o3LE0VR+3BfxQAim6ZeoPzir0pr0xIy3EnOutEtP5kESzMvuib4ywMADoQwIMe3IKW8nSwobTREIOCw6am55m9kWWTv+mhb5EDwXsvkUZ5zg3LvqvmYaB4cqRF6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5GxjzJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 008BEC4CEF5;
	Fri, 27 Jun 2025 15:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751036421;
	bh=kiMLD24nbhQ2c7z1BH8VGCJ87iZfdGhW+mxk6hvCkcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=e5GxjzJlduWn4knSXT9GPfb0R+x2bMMbjXEKgoZbDAhAZJjIpkB5p24Y1fYqHknKK
	 ukl2q9nmDDfo242vObg8DXHAfNwIDk1LAkCd5YyYUFG+kYF/+Pe7L/UJSysNmcBmu8
	 cXvQnBqCjtesdlQc7TZkd+lcZR7cr7QLrKDELUGEPEMqfidae3B3nwjmQPL2UvfWQf
	 b3a75NYcklWpLcXUOnxNcrz5XHsh26qHR345pa4PTzYJlO1xvk9MBOJLOSL1s4Rw7C
	 Xn4z6j6WcXNLlclY52VTX3EyfKumjCZcg+jQGNRpQ4v2AwliCyj7V1Cd7D2FosJBv6
	 YVPukH5J5xuiw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED68EC7EE2A;
	Fri, 27 Jun 2025 15:00:20 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 27 Jun 2025 16:00:22 +0100
Subject: [PATCH RESEND 4/4] dma: dma-axi-dmac: simplify axi_dmac_parse_dt()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250627-dev-axi-dmac-fixes-v1-4-2453674c5b78@analog.com>
References: <20250627-dev-axi-dmac-fixes-v1-0-2453674c5b78@analog.com>
In-Reply-To: <20250627-dev-axi-dmac-fixes-v1-0-2453674c5b78@analog.com>
To: dmaengine@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, 
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751036430; l=1521;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=dIUKoGAAnK7SSnlSFeEcmY/rlMpKq1hPjDfYUQ18lCk=;
 b=Xk6o2/Fnp25jr/YJ8mUGhju7CzRSt9fAcUx1X1jvk0383wbNk+ScUpdqvmLzADJ9gLnztqHXl
 +CIbptPApIwA1zxovCMzgpkY+GrezmL0i3Tq+qBt3tTTbHhbTCBbTbG
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



