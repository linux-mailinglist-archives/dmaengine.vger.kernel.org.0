Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B340B4571F
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2019 10:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfFNIPu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Jun 2019 04:15:50 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50682 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfFNIPu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 14 Jun 2019 04:15:50 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AC6EB1A05D7;
        Fri, 14 Jun 2019 10:15:47 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9A21E1A05C8;
        Fri, 14 Jun 2019 10:15:41 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4C62A40319;
        Fri, 14 Jun 2019 16:15:34 +0800 (SGT)
From:   yibin.gong@nxp.com
To:     robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, mark.rutland@arm.com, vkoul@kernel.org,
        dan.j.williams@intel.com, angelo@sysam.it
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v4 3/6] dmaengine: fsl-edma-common: version check for v2 instead
Date:   Fri, 14 Jun 2019 16:17:21 +0800
Message-Id: <20190614081724.13366-4-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614081724.13366-1-yibin.gong@nxp.com>
References: <20190614081724.13366-1-yibin.gong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

The next v3 i.mx7ulp edma is based on v1, so change version
check logic for v2 instead.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index ba74e10..44d92c3 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -658,26 +658,26 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
 	edma->regs.erql = edma->membase + EDMA_ERQ;
 	edma->regs.eeil = edma->membase + EDMA_EEI;
 
-	edma->regs.serq = edma->membase + ((edma->drvdata->version == v1) ?
-			EDMA_SERQ : EDMA64_SERQ);
-	edma->regs.cerq = edma->membase + ((edma->drvdata->version == v1) ?
-			EDMA_CERQ : EDMA64_CERQ);
-	edma->regs.seei = edma->membase + ((edma->drvdata->version == v1) ?
-			EDMA_SEEI : EDMA64_SEEI);
-	edma->regs.ceei = edma->membase + ((edma->drvdata->version == v1) ?
-			EDMA_CEEI : EDMA64_CEEI);
-	edma->regs.cint = edma->membase + ((edma->drvdata->version == v1) ?
-			EDMA_CINT : EDMA64_CINT);
-	edma->regs.cerr = edma->membase + ((edma->drvdata->version == v1) ?
-			EDMA_CERR : EDMA64_CERR);
-	edma->regs.ssrt = edma->membase + ((edma->drvdata->version == v1) ?
-			EDMA_SSRT : EDMA64_SSRT);
-	edma->regs.cdne = edma->membase + ((edma->drvdata->version == v1) ?
-			EDMA_CDNE : EDMA64_CDNE);
-	edma->regs.intl = edma->membase + ((edma->drvdata->version == v1) ?
-			EDMA_INTR : EDMA64_INTL);
-	edma->regs.errl = edma->membase + ((edma->drvdata->version == v1) ?
-			EDMA_ERR : EDMA64_ERRL);
+	edma->regs.serq = edma->membase + ((edma->drvdata->version == v2) ?
+			EDMA64_SERQ : EDMA_SERQ);
+	edma->regs.cerq = edma->membase + ((edma->drvdata->version == v2) ?
+			EDMA64_CERQ : EDMA_CERQ);
+	edma->regs.seei = edma->membase + ((edma->drvdata->version == v2) ?
+			EDMA64_SEEI : EDMA_SEEI);
+	edma->regs.ceei = edma->membase + ((edma->drvdata->version == v2) ?
+			EDMA64_CEEI : EDMA_CEEI);
+	edma->regs.cint = edma->membase + ((edma->drvdata->version == v2) ?
+			EDMA64_CINT : EDMA_CINT);
+	edma->regs.cerr = edma->membase + ((edma->drvdata->version == v2) ?
+			EDMA64_CERR : EDMA_CERR);
+	edma->regs.ssrt = edma->membase + ((edma->drvdata->version == v2) ?
+			EDMA64_SSRT : EDMA_SSRT);
+	edma->regs.cdne = edma->membase + ((edma->drvdata->version == v2) ?
+			EDMA64_CDNE : EDMA_CDNE);
+	edma->regs.intl = edma->membase + ((edma->drvdata->version == v2) ?
+			EDMA64_INTL : EDMA_INTR);
+	edma->regs.errl = edma->membase + ((edma->drvdata->version == v2) ?
+			EDMA64_ERRL : EDMA_ERR);
 
 	if (edma->drvdata->version == v2) {
 		edma->regs.erqh = edma->membase + EDMA64_ERQH;
-- 
2.7.4

