Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8BA0BD160
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 20:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505079AbfIXSNF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 14:13:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:44098 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439771AbfIXSNE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 14:13:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 93C9FAEF1;
        Tue, 24 Sep 2019 18:13:02 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        frowand.list@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        xen-devel@lists.xenproject.org, linux-tegra@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     mbrugger@suse.com, robin.murphy@arm.com, f.fainelli@gmail.com,
        james.quinlan@broadcom.com, wahrenst@gmx.net,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 09/11] of: device: remove comment in of_dma_configure()
Date:   Tue, 24 Sep 2019 20:12:40 +0200
Message-Id: <20190924181244.7159-10-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924181244.7159-1-nsaenzjulienne@suse.de>
References: <20190924181244.7159-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It's not longer advised to use notifiers in order to setup custom DMA
ops.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

 drivers/of/device.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 267b509df517..018c52688546 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -81,10 +81,6 @@ int of_device_add(struct platform_device *ofdev)
  *
  * Try to get devices's DMA configuration from DT and update it
  * accordingly.
- *
- * If platform code needs to use its own special DMA configuration, it
- * can use a platform bus notifier and handle BUS_NOTIFY_ADD_DEVICE events
- * to fix up DMA configuration.
  */
 int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 {
-- 
2.23.0

