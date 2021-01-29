Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E394F308D75
	for <lists+dmaengine@lfdr.de>; Fri, 29 Jan 2021 20:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhA2TcU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Jan 2021 14:32:20 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33754 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbhA2TcT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Jan 2021 14:32:19 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10TJVQRG050654;
        Fri, 29 Jan 2021 13:31:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611948686;
        bh=6+jM4+HbnMQcRZuB7Fd33N+uADhJPDXM58VLVeKPsxQ=;
        h=From:To:CC:Subject:Date;
        b=lsf9UgQhAnDLo2wWOINSCAjdASwFLcqq5NQfHedRZXsvVY3XodQzJXF7zwUt7ACVy
         YdqPIzI57Laml/YtxZ1TMF73+XUWHAKPvr1bxWQ1i3+FfoetsjIqIf/MN8q9xo/qK0
         6xEHSTron6cYyuwKNC1++l4mup7lzXm6j3OpNmXw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10TJVQLm003222
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Jan 2021 13:31:26 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 29
 Jan 2021 13:31:26 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 29 Jan 2021 13:31:26 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10TJVOBQ064916;
        Fri, 29 Jan 2021 13:31:25 -0600
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        <dmaengine@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] dmaengine: ti: k3-psil: optimize struct psil_endpoint_config for size
Date:   Fri, 29 Jan 2021 21:31:17 +0200
Message-ID: <20210129193117.28833-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Optimize struct psil_endpoint_config for size by
- reordering fields
- grouping bitfields
- change mapped_channel_id type to s16 (32K channel is enough)
- default_flow_id type to s16 as it's assigned to -1

before:
text            data     bss    dec	        hex	filename
12654100	5211472	 666904	18532476	11ac87c	vmlinux

after:
12654100	5208528	 666904	18529532	11abcfc	vmlinux

diff: 2944 bytes

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 include/linux/dma/k3-psil.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/dma/k3-psil.h b/include/linux/dma/k3-psil.h
index 36e22c5a0f29..5f106d852f1c 100644
--- a/include/linux/dma/k3-psil.h
+++ b/include/linux/dma/k3-psil.h
@@ -42,14 +42,14 @@ enum psil_endpoint_type {
 /**
  * struct psil_endpoint_config - PSI-L Endpoint configuration
  * @ep_type:		PSI-L endpoint type
+ * @channel_tpl:	Desired throughput level for the channel
  * @pkt_mode:		If set, the channel must be in Packet mode, otherwise in
  *			TR mode
  * @notdpkt:		TDCM must be suppressed on the TX channel
  * @needs_epib:		Endpoint needs EPIB
- * @psd_size:		If set, PSdata is used by the endpoint
- * @channel_tpl:	Desired throughput level for the channel
  * @pdma_acc32:		ACC32 must be enabled on the PDMA side
  * @pdma_burst:		BURST must be enabled on the PDMA side
+ * @psd_size:		If set, PSdata is used by the endpoint
  * @mapped_channel_id:	PKTDMA thread to channel mapping for mapped channels.
  *			The thread must be serviced by the specified channel if
  *			mapped_channel_id is >= 0 in case of PKTDMA
@@ -62,23 +62,22 @@ enum psil_endpoint_type {
  */
 struct psil_endpoint_config {
 	enum psil_endpoint_type ep_type;
+	enum udma_tp_level channel_tpl;
 
 	unsigned pkt_mode:1;
 	unsigned notdpkt:1;
 	unsigned needs_epib:1;
-	u32 psd_size;
-	enum udma_tp_level channel_tpl;
-
 	/* PDMA properties, valid for PSIL_EP_PDMA_* */
 	unsigned pdma_acc32:1;
 	unsigned pdma_burst:1;
 
+	u32 psd_size;
 	/* PKDMA mapped channel */
-	int mapped_channel_id;
+	s16 mapped_channel_id;
 	/* PKTDMA tflow and rflow ranges for mapped channel */
 	u16 flow_start;
 	u16 flow_num;
-	u16 default_flow_id;
+	s16 default_flow_id;
 };
 
 int psil_set_new_ep_config(struct device *dev, const char *name,
-- 
2.17.1

