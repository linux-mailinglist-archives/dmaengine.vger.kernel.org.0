Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C8C25C26
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 05:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfEVD3E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 23:29:04 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45326 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbfEVD3E (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 23:29:04 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0631520001C;
        Wed, 22 May 2019 05:29:02 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C203200008;
        Wed, 22 May 2019 05:28:59 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DBD8D402E0;
        Wed, 22 May 2019 11:28:55 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Ma <peng.ma@nxp.com>
Subject: [V3 1/2] dmaengine: fsl-qdma: fixed the source/destination descriptor format
Date:   Wed, 22 May 2019 03:21:02 +0000
Message-Id: <20190522032103.13713-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

CMD of Source/Destination descriptor format should be lower of
struct fsl_qdma_engine number data address.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
changed for V3:
	- Delete macro to simplify code.

 drivers/dma/fsl-qdma.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index aa1d0ae..da8fdf5 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -113,6 +113,7 @@
 /* Field definition for Descriptor offset */
 #define QDMA_CCDF_STATUS		20
 #define QDMA_CCDF_OFFSET		20
+#define QDMA_SDDF_CMD(x)		(((u64)(x)) << 32)
 
 /* Field definition for safe loop count*/
 #define FSL_QDMA_HALT_COUNT		1500
@@ -341,6 +342,7 @@ static void fsl_qdma_free_chan_resources(struct dma_chan *chan)
 static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
 				      dma_addr_t dst, dma_addr_t src, u32 len)
 {
+	u32 cmd;
 	struct fsl_qdma_format *sdf, *ddf;
 	struct fsl_qdma_format *ccdf, *csgf_desc, *csgf_src, *csgf_dest;
 
@@ -369,14 +371,14 @@ static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
 	/* This entry is the last entry. */
 	qdma_csgf_set_f(csgf_dest, len);
 	/* Descriptor Buffer */
-	sdf->data =
-		cpu_to_le64(FSL_QDMA_CMD_RWTTYPE <<
-			    FSL_QDMA_CMD_RWTTYPE_OFFSET);
-	ddf->data =
-		cpu_to_le64(FSL_QDMA_CMD_RWTTYPE <<
-			    FSL_QDMA_CMD_RWTTYPE_OFFSET);
-	ddf->data |=
-		cpu_to_le64(FSL_QDMA_CMD_LWC << FSL_QDMA_CMD_LWC_OFFSET);
+	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
+			  FSL_QDMA_CMD_RWTTYPE_OFFSET);
+	sdf->data = QDMA_SDDF_CMD(cmd);
+
+	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
+			  FSL_QDMA_CMD_RWTTYPE_OFFSET);
+	cmd |= cpu_to_le32(FSL_QDMA_CMD_LWC << FSL_QDMA_CMD_LWC_OFFSET);
+	ddf->data = QDMA_SDDF_CMD(cmd);
 }
 
 /*
-- 
1.7.1

