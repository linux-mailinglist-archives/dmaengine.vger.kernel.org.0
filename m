Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08B74E1006
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 04:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388701AbfJWCbF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 22:31:05 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45340 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387795AbfJWCbF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Oct 2019 22:31:05 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 42CCA1A0B22;
        Wed, 23 Oct 2019 04:31:02 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B200C1A068D;
        Wed, 23 Oct 2019 04:30:58 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 866A5402D3;
        Wed, 23 Oct 2019 10:30:54 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, leoyang.li@nxp.com,
        anders.roxell@linaro.org
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Peng Ma <peng.ma@nxp.com>
Subject: [PATCH] dmaengine: fsl-dpaa2-qdma: Fixed build error when enable dpaa2 qdma module driver
Date:   Wed, 23 Oct 2019 10:19:59 +0800
Message-Id: <20191023021959.35596-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fixed the following error:
WARNING: modpost: missing MODULE_LICENSE() in drivers/dma/fsl-dpaa2-qdma/dpdmai.o
see include/linux/module.h for more information
GZIP    arch/arm64/boot/Image.gz
ERROR: "dpdmai_enable" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
ERROR: "dpdmai_set_rx_queue" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
ERROR: "dpdmai_get_tx_queue" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
ERROR: "dpdmai_get_rx_queue" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
ERROR: "dpdmai_get_attributes" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
ERROR: "dpdmai_open" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
ERROR: "dpdmai_close" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
ERROR: "dpdmai_disable" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
ERROR: "dpdmai_reset" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
WARNING: "HYPERVISOR_platform_op" [vmlinux] is a static EXPORT_SYMBOL_GPL
make[2]: *** [__modpost] Error 1
make[1]: *** [modules] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [sub-make] Error 2

Signed-off-by: Peng Ma <peng.ma@nxp.com>
Reported-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/dma/fsl-dpaa2-qdma/dpdmai.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
index fbc2b2f..f8a1f66 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright 2019 NXP
 
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/io.h>
 #include <linux/fsl/mc.h>
@@ -90,6 +91,7 @@ int dpdmai_open(struct fsl_mc_io *mc_io, u32 cmd_flags,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dpdmai_open);
 
 /**
  * dpdmai_close() - Close the control session of the object
@@ -113,6 +115,7 @@ int dpdmai_close(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 	/* send command to mc*/
 	return mc_send_command(mc_io, &cmd);
 }
+EXPORT_SYMBOL_GPL(dpdmai_close);
 
 /**
  * dpdmai_create() - Create the DPDMAI object
@@ -177,6 +180,7 @@ int dpdmai_enable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 	/* send command to mc*/
 	return mc_send_command(mc_io, &cmd);
 }
+EXPORT_SYMBOL_GPL(dpdmai_enable);
 
 /**
  * dpdmai_disable() - Disable the DPDMAI, stop sending and receiving frames.
@@ -197,6 +201,7 @@ int dpdmai_disable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 	/* send command to mc*/
 	return mc_send_command(mc_io, &cmd);
 }
+EXPORT_SYMBOL_GPL(dpdmai_disable);
 
 /**
  * dpdmai_reset() - Reset the DPDMAI, returns the object to initial state.
@@ -217,6 +222,7 @@ int dpdmai_reset(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 	/* send command to mc*/
 	return mc_send_command(mc_io, &cmd);
 }
+EXPORT_SYMBOL_GPL(dpdmai_reset);
 
 /**
  * dpdmai_get_attributes() - Retrieve DPDMAI attributes.
@@ -252,6 +258,7 @@ int dpdmai_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dpdmai_get_attributes);
 
 /**
  * dpdmai_set_rx_queue() - Set Rx queue configuration
@@ -285,6 +292,7 @@ int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 	/* send command to mc*/
 	return mc_send_command(mc_io, &cmd);
 }
+EXPORT_SYMBOL_GPL(dpdmai_set_rx_queue);
 
 /**
  * dpdmai_get_rx_queue() - Retrieve Rx queue attributes.
@@ -325,6 +333,7 @@ int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dpdmai_get_rx_queue);
 
 /**
  * dpdmai_get_tx_queue() - Retrieve Tx queue attributes.
@@ -364,3 +373,6 @@ int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dpdmai_get_tx_queue);
+
+MODULE_LICENSE("GPL v2");
-- 
2.9.5

