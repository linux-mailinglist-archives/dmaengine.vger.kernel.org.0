Return-Path: <dmaengine+bounces-6358-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C35B42069
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 15:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AFC2540702
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE27F3019CD;
	Wed,  3 Sep 2025 13:06:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0422EC548
	for <dmaengine@vger.kernel.org>; Wed,  3 Sep 2025 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904784; cv=none; b=dYLCBNBxtUOS0j4t8gRoxIMuUO2PUSzuXL3RXq/3uSQxk4rQLMBsqIH0Q/08cDwD+yr0z5RV2GYmgPjg5p1B3r9pJ0DIoKkek9k9ps/tFMc+W8rds63Ms1gwtfEh+nKqsasf6DBqRPLSYa5z8Q5JoIxjnfuEzj7m/9TNvDQkqB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904784; c=relaxed/simple;
	bh=dO5AouNWL4aNepxpem6zpAWY9cfFLUMSDdsjvpTHUbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BL6Qhi6wbr/XvhBNspkzs+QAvj2neevObf2FajRD+uB59/YBvtV+SnXYsZAbCwwab56nhS0arJHuogDsAj1PH7akLxr47o5LHewSzTSinwZaXP+l7WhyjuOfGqmMy01UL+3UuJ/MsQGUmsWaceZtYZp09qB3PUorjwPqJuTxiUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1utnBl-00006Z-Vo; Wed, 03 Sep 2025 15:06:13 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Wed, 03 Sep 2025 15:06:17 +0200
Subject: [PATCH 09/11] dmaengine: add support for device_link
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-v6-16-topic-sdma-v1-9-ac7bab629e8b@pengutronix.de>
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

Add support to create device_links between dmaengine suppliers and the
dma consumers. This shifts the device dep-chain teardown/bringup logic
to the driver core.

Moving this to the core allows the dmaengine drivers to simplify the
.remove() hooks and also to ensure that no dmaengine driver is ever
removed before the consumer is removed.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/dma/dmaengine.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 758fcd0546d8bde8e8dddc6039848feeb1e24475..a50652bc70b8ce9d4edabfaa781b3432ee47d31e 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -817,6 +817,7 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct dma_device *d, *_d;
 	struct dma_chan *chan = NULL;
+	struct device_link *dl;
 
 	if (is_of_node(fwnode))
 		chan = of_dma_request_slave_channel(to_of_node(fwnode), name);
@@ -858,6 +859,13 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 	/* No functional issue if it fails, users are supposed to test before use */
 #endif
 
+	dl = device_link_add(dev, chan->device->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
+	if (!dl) {
+		dev_err(dev, "failed to create device link to %s\n",
+			dev_name(chan->device->dev));
+		return ERR_PTR(-EINVAL);
+	}
+
 	chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
 	if (!chan->name)
 		return chan;

-- 
2.47.2


