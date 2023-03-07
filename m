Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0580B6AF5E7
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 20:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjCGTkr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Mar 2023 14:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjCGTk3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Mar 2023 14:40:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDC9A8811;
        Tue,  7 Mar 2023 11:27:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0943BB818C4;
        Tue,  7 Mar 2023 19:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0317C433D2;
        Tue,  7 Mar 2023 19:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678217222;
        bh=PBKx560qNe8SnH7l569PMqQ0gHZ8kT097OdmdKuoVds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVzu7GyBTNvnhQ+BDcyMOBD5vxDwAxhYNF4PydRfeVB2Pt8vRSoZe4DA6MiICz4tG
         YThKxWvAPjzBDVBMIIz9PnzMKmfHdFXAjCVvR9m6cjgQ2gO3WO+8KsMPofoPB99ROv
         oNw3Y36IFkH17+/e9/Pywydg546M98tKPyibI6AubtZt1q8JdFHuBJnebF788w276p
         6HXLF8vjfLBo2G0v+164zfSgSv64wQe1sRdGDDjWbaa5uCIT5c1x1S4DU35fhL13lM
         +5NS37WGHUsIxEijS3ucTqNLH4E4DUIlfxXGA1H920CFP5SYkn8xQ6AuFYuXh7jUZu
         LQTctTZWmT9RA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] dmaengine: ioat: Drop redundant pci_enable_pcie_error_reporting()
Date:   Tue,  7 Mar 2023 13:26:54 -0600
Message-Id: <20230307192655.874008-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307192655.874008-1-helgaas@kernel.org>
References: <20230307192655.874008-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci_enable_pcie_error_reporting() enables the device to send ERR_*
Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
native"), the PCI core does this for all devices during enumeration, so the
driver doesn't need to do it itself.

Remove the redundant pci_enable_pcie_error_reporting() call from the
driver.  Also remove the corresponding pci_disable_pcie_error_reporting()
from the driver .remove() path.

Note that this only controls ERR_* Messages from the device.  An ERR_*
Message may cause the Root Port to generate an interrupt, depending on the
AER Root Error Command register managed by the AER service driver.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/dma/ioat/init.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 5d707ff63554..6ca62edf47bd 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -15,7 +15,6 @@
 #include <linux/workqueue.h>
 #include <linux/prefetch.h>
 #include <linux/dca.h>
-#include <linux/aer.h>
 #include <linux/sizes.h>
 #include "dma.h"
 #include "registers.h"
@@ -1380,15 +1379,11 @@ static int ioat_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		if (is_skx_ioat(pdev))
 			device->version = IOAT_VER_3_2;
 		err = ioat3_dma_probe(device, ioat_dca_enabled);
-
-		if (device->version >= IOAT_VER_3_3)
-			pci_enable_pcie_error_reporting(pdev);
 	} else
 		return -ENODEV;
 
 	if (err) {
 		dev_err(dev, "Intel(R) I/OAT DMA Engine init failed\n");
-		pci_disable_pcie_error_reporting(pdev);
 		return -ENODEV;
 	}
 
@@ -1411,7 +1406,6 @@ static void ioat_remove(struct pci_dev *pdev)
 		device->dca = NULL;
 	}
 
-	pci_disable_pcie_error_reporting(pdev);
 	ioat_dma_remove(device);
 }
 
-- 
2.25.1

