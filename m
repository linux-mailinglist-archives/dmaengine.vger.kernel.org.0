Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47A42B5D75
	for <lists+dmaengine@lfdr.de>; Tue, 17 Nov 2020 11:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgKQK4y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Nov 2020 05:56:54 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34142 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgKQK4w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Nov 2020 05:56:52 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AHAuka1117372;
        Tue, 17 Nov 2020 04:56:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605610606;
        bh=KrUTk8ul87troFJrpjX2nEBHGpMAgPlBoUHLfqkKttI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=N57a+EYmGunHmUk0CrK3SaBvFLQyP9HZIozZ2Jsp6erWv6bhA9MyAbf3zOtkEYCub
         dQv5h/NRlz3UdZPBva4gW0MawvYutWCkbmwYISiOLgdUbWCUx+BqTlr0L3+ZC/vXMr
         TyAD9CY6wUpQT8t3dqvv9YTm5729JvR7R5PlexVI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AHAukCA010356
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 04:56:46 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 17
 Nov 2020 04:56:46 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 17 Nov 2020 04:56:46 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AHAu6tw087311;
        Tue, 17 Nov 2020 04:56:43 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v2 12/19] dmaengine: ti: k3-psil: Extend psil_endpoint_config for K3 PKTDMA
Date:   Tue, 17 Nov 2020 12:56:49 +0200
Message-ID: <20201117105656.5236-13-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201117105656.5236-1-peter.ujfalusi@ti.com>
References: <20201117105656.5236-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Additional fields needed for K3 PKTDMA to be able to handle the mapped
channels (channels are locked to handle specific threads) and flow ranges
for these mapped threads.
PKTDMA also introduces tflow for tx channels which can not be found in
K3 UDMA architecture.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/dma/k3-psil.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/dma/k3-psil.h b/include/linux/dma/k3-psil.h
index 1962f75fa2d3..36e22c5a0f29 100644
--- a/include/linux/dma/k3-psil.h
+++ b/include/linux/dma/k3-psil.h
@@ -50,6 +50,15 @@ enum psil_endpoint_type {
  * @channel_tpl:	Desired throughput level for the channel
  * @pdma_acc32:		ACC32 must be enabled on the PDMA side
  * @pdma_burst:		BURST must be enabled on the PDMA side
+ * @mapped_channel_id:	PKTDMA thread to channel mapping for mapped channels.
+ *			The thread must be serviced by the specified channel if
+ *			mapped_channel_id is >= 0 in case of PKTDMA
+ * @flow_start:		PKDMA flow range start of mapped channel. Unmapped
+ *			channels use flow_id == chan_id
+ * @flow_num:		PKDMA flow count of mapped channel. Unmapped channels
+ *			use flow_id == chan_id
+ * @default_flow_id:	PKDMA default (r)flow index of mapped channel.
+ *			Must be within the flow range of the mapped channel.
  */
 struct psil_endpoint_config {
 	enum psil_endpoint_type ep_type;
@@ -63,6 +72,13 @@ struct psil_endpoint_config {
 	/* PDMA properties, valid for PSIL_EP_PDMA_* */
 	unsigned pdma_acc32:1;
 	unsigned pdma_burst:1;
+
+	/* PKDMA mapped channel */
+	int mapped_channel_id;
+	/* PKTDMA tflow and rflow ranges for mapped channel */
+	u16 flow_start;
+	u16 flow_num;
+	u16 default_flow_id;
 };
 
 int psil_set_new_ep_config(struct device *dev, const char *name,
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

