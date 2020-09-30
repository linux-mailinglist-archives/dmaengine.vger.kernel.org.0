Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D557027E4B2
	for <lists+dmaengine@lfdr.de>; Wed, 30 Sep 2020 11:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgI3JOl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Sep 2020 05:14:41 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35182 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbgI3JOh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Sep 2020 05:14:37 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U9EWkf035089;
        Wed, 30 Sep 2020 04:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601457272;
        bh=KrUTk8ul87troFJrpjX2nEBHGpMAgPlBoUHLfqkKttI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=erhe2dmhTBg6xdtP29WtORaC141HNSk954n2A6GFkVMAvz2YRhMEHqxrel6QgsYAb
         6eZpfianipRCucVy3eYFSyTxB+UuYx75spzg33QobGQgBoOZSReQ6egF3Klk9hUW9h
         YurHoRMUmBd5i3j20AjyZ73I5VpAEm83KKPTA4cQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U9EWnu122272;
        Wed, 30 Sep 2020 04:14:32 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 04:14:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 04:14:31 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U9DuJi116385;
        Wed, 30 Sep 2020 04:14:29 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>, <vigneshr@ti.com>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
Subject: [PATCH 11/18] dmaengine: ti: k3-psil: Extend psil_endpoint_config for K3 PKTDMA
Date:   Wed, 30 Sep 2020 12:14:05 +0300
Message-ID: <20200930091412.8020-12-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930091412.8020-1-peter.ujfalusi@ti.com>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
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

