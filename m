Return-Path: <dmaengine+bounces-5105-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB5EAAE8EB
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 20:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB7C3B1E10
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 18:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988FD28B7F0;
	Wed,  7 May 2025 18:21:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mxout37.expurgate.net (mxout37.expurgate.net [194.37.255.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A380D28D846;
	Wed,  7 May 2025 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746642106; cv=none; b=Qv+3gBJcXC8OlphZusLFbpEpqHbk2KD21NCdhInA6bZleJkI5CluVMXg1MZqnaZxPNi5gDpyZySZhpc0CsosdLlkiC7e9LD5J0natlHFAfflY9BWVklKMj6drDUwJ1I3eXjUN/yl/sdiykTs2qFJ8UiorXZJX9PZv2FYAVkk0KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746642106; c=relaxed/simple;
	bh=n90AbWhkxSIUXM9JviyGZUSG0v9mcDVD+LyKYob5t8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Evdw/jvO+WkwxAN2whKjyEGF4MVWGMZ7vDZ8vCKkNGli7hdhq50QJKRCmnrJ816cTBNakSzh1H64ozmgCB5iq6K9LkBIzxA24Owyc06/2Q1xqdtgdP4AKXXNwUCduV6RT4qjbCfn7ltwOP4CjeeNQx42VcvrYwBwMj3MGpXy5NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brueckmann-gmbh.de; spf=pass smtp.mailfrom=brueckmann-gmbh.de; arc=none smtp.client-ip=194.37.255.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brueckmann-gmbh.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brueckmann-gmbh.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <thomas.gessler@brueckmann-gmbh.de>)
	id 1uCjOc-002WP0-AF; Wed, 07 May 2025 20:21:30 +0200
Received: from [217.239.223.202] (helo=zimbra.brueckmann-gmbh.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <thomas.gessler@brueckmann-gmbh.de>)
	id 1uCjOb-002Q3U-8p; Wed, 07 May 2025 20:21:29 +0200
Received: from zimbra.brueckmann-gmbh.de (localhost [127.0.0.1])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTPS id F1027CA0310;
	Wed,  7 May 2025 20:21:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTP id E0C2ECA04D8;
	Wed,  7 May 2025 20:21:27 +0200 (CEST)
Received: from zimbra.brueckmann-gmbh.de ([127.0.0.1])
 by localhost (zimbra.brueckmann-gmbh.de [127.0.0.1]) (amavis, port 10026)
 with ESMTP id wCZj7PF64PHc; Wed,  7 May 2025 20:21:27 +0200 (CEST)
Received: from ew-linux.ew (unknown [10.0.11.14])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTPSA id C1437CA0310;
	Wed,  7 May 2025 20:21:27 +0200 (CEST)
From: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
To: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marek Vasut <marex@denx.de>,
	linux-arm-kernel@lists.infradead.org,
	Suraj Gupta <Suraj.Gupta2@amd.com>,
	Harini Katakam <harini.katakam@amd.com>
Subject: [PATCH v2] dmaengine: xilinx_dma: Set dma_device directions
Date: Wed,  7 May 2025 20:21:01 +0200
Message-ID: <20250507182101.909010-1-thomas.gessler@brueckmann-gmbh.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1746642090-96E4C21F-1C64AD5C/0/0
X-purgate: clean
X-purgate-type: clean

Coalesce the direction bits from the enabled TX and/or RX channels into
the directions bit mask of dma_device. Without this mask set,
dma_get_slave_caps() in the DMAEngine fails, which prevents the driver
from being used with an IIO DMAEngine buffer.

Signed-off-by: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
---
Changes in v2:
  - Change to Suraj's simpler version as per Radhey's request

 drivers/dma/xilinx/xilinx_dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
index 3ad44afd0e74..8f26b6eff3f3 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2909,6 +2909,8 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_=
device *xdev,
 		return -EINVAL;
 	}
=20
+	xdev->common.directions |=3D chan->direction;
+
 	/* Request the interrupt */
 	chan->irq =3D of_irq_get(node, chan->tdest);
 	if (chan->irq < 0)

