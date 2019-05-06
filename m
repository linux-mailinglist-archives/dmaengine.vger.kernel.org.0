Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF0E14384
	for <lists+dmaengine@lfdr.de>; Mon,  6 May 2019 04:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbfEFC26 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 5 May 2019 22:28:58 -0400
Received: from inva021.nxp.com ([92.121.34.21]:56748 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfEFC26 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 5 May 2019 22:28:58 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E7870200100;
        Mon,  6 May 2019 04:28:55 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D1CB92001A2;
        Mon,  6 May 2019 04:28:52 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A9B25402A6;
        Mon,  6 May 2019 10:28:48 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, leoyang.li@nxp.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Ma <peng.ma@nxp.com>
Subject: [V2 1/2] dmaengine: fsl-qdma: fixed the source/destination descriptor format
Date:   Mon,  6 May 2019 10:21:10 +0800
Message-Id: <20190506022111.31751-1-peng.ma@nxp.com>
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
changed for V2:
	- Fix descriptor spelling

 drivers/dma/fsl-qdma.c |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index aa1d0ae..2e8b46b 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -113,6 +113,7 @@
 /* Field definition for Descriptor offset */
 #define QDMA_CCDF_STATUS		20
 #define QDMA_CCDF_OFFSET		20
+#define QDMA_SDDF_CMD(x)		(((u64)(x)) << 32)
 
 /* Field definition for safe loop count*/
 #define FSL_QDMA_HALT_COUNT		1500
@@ -214,6 +215,12 @@ struct fsl_qdma_engine {
 
 };
 
+static inline void
+qdma_sddf_set_cmd(struct fsl_qdma_format *sddf, u32 val)
+{
+	sddf->data = QDMA_SDDF_CMD(val);
+}
+
 static inline u64
 qdma_ccdf_addr_get64(const struct fsl_qdma_format *ccdf)
 {
@@ -341,6 +348,7 @@ static void fsl_qdma_free_chan_resources(struct dma_chan *chan)
 static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
 				      dma_addr_t dst, dma_addr_t src, u32 len)
 {
+	u32 cmd;
 	struct fsl_qdma_format *sdf, *ddf;
 	struct fsl_qdma_format *ccdf, *csgf_desc, *csgf_src, *csgf_dest;
 
@@ -353,6 +361,7 @@ static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
 
 	memset(fsl_comp->virt_addr, 0, FSL_QDMA_COMMAND_BUFFER_SIZE);
 	memset(fsl_comp->desc_virt_addr, 0, FSL_QDMA_DESCRIPTOR_BUFFER_SIZE);
+
 	/* Head Command Descriptor(Frame Descriptor) */
 	qdma_desc_addr_set64(ccdf, fsl_comp->bus_addr + 16);
 	qdma_ccdf_set_format(ccdf, qdma_ccdf_get_offset(ccdf));
@@ -369,14 +378,14 @@ static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
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
+	qdma_sddf_set_cmd(sdf, cmd);
+
+	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
+			  FSL_QDMA_CMD_RWTTYPE_OFFSET);
+	cmd |= cpu_to_le32(FSL_QDMA_CMD_LWC << FSL_QDMA_CMD_LWC_OFFSET);
+	qdma_sddf_set_cmd(ddf, cmd);
 }
 
 /*
-- 
1.7.1

