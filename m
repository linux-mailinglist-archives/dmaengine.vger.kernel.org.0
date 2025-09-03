Return-Path: <dmaengine+bounces-6356-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D56B42074
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 15:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F625687079
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 13:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB83B303CB7;
	Wed,  3 Sep 2025 13:06:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1CB3019CD
	for <dmaengine@vger.kernel.org>; Wed,  3 Sep 2025 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904784; cv=none; b=KL8Pv5jz7EuZwtbRJYHK8wReX37bUo829og2/VcdIM1+aPFYV/siVq0ViuV1i6rZloQ9hTHS11NdLY8y9u67luj/tNyzdT8vppcgUjAsqY/ocgRj68FXITwIj5xVKYSS4MxDtfOaRahLHr5qF8ulROZtB5h2eslB7V3XiFDprnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904784; c=relaxed/simple;
	bh=wK9kqRE+190Nmnm4ozR9PGQi5dhCYAkQNurhvOsKnTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iC7fIbvQBDFUIG1lk1CKD6aCjLHlLVxBFFU1RnkrUMf4OEJNYZ9Aucp4lSj7hdNCxZeDZ6D+/3YpzXWE5mbyhYKd857x0XFz1dB8/PFa+/lOE+EKCdP5FuIIx6i99VdyJ8R6Vqf+01N6+O9x6QLOsMOflHlG+w7a++p0NQtDxM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1utnBl-00006Z-U1; Wed, 03 Sep 2025 15:06:13 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Wed, 03 Sep 2025 15:06:16 +0200
Subject: [PATCH 08/11] dmaengine: imx-sdma: fix missing
 of_dma_controller_free()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-v6-16-topic-sdma-v1-8-ac7bab629e8b@pengutronix.de>
References: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
In-Reply-To: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jiada Wang <jiada_wang@mentor.com>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

Add the missing of_dma_controller_free() to free the resources allocated
via of_dma_controller_register(). The missing free was introduced long
time ago  by commit 23e118113782 ("dma: imx-sdma: use
module_platform_driver for SDMA driver") while adding a proper .remove()
implementation.

Fixes: 23e118113782 ("dma: imx-sdma: use module_platform_driver for SDMA driver")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index e30dd46cf6522ee2aa4d3aca9868a01afbd29615..6c6d38b202dd2deffc36b1bd27bc7c60de3d7403 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2232,6 +2232,13 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
 				     ofdma->of_node);
 }
 
+static void sdma_dma_of_dma_controller_unregister_action(void *data)
+{
+	struct sdma_engine *sdma = data;
+
+	of_dma_controller_free(sdma->dev->of_node);
+}
+
 static void sdma_dma_device_unregister_action(void *data)
 {
 	struct sdma_engine *sdma = data;
@@ -2370,6 +2377,8 @@ static int sdma_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register controller\n");
 
+	devm_add_action_or_reset(dev, sdma_dma_of_dma_controller_unregister_action, sdma);
+
 	spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
 	ret = of_address_to_resource(spba_bus, 0, &spba_res);
 	if (!ret) {

-- 
2.47.2


