Return-Path: <dmaengine+bounces-2974-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EDE960ABA
	for <lists+dmaengine@lfdr.de>; Tue, 27 Aug 2024 14:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CDC41C22CB6
	for <lists+dmaengine@lfdr.de>; Tue, 27 Aug 2024 12:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60CF1BA87C;
	Tue, 27 Aug 2024 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jXg+SJiN"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F701448C7;
	Tue, 27 Aug 2024 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762637; cv=none; b=T0VKOTC2zhKap/IyrpfTrL4bY5hdApOVWL7KHtfWyIRnSQpfyfUsIjuGej7S9FDIBYmZO7gwbz+GuIaIi+6jXIcG2oCOFOVB9EXPu8AqMQjvzin/t5N+C/AZ5PjtSx++KAFyfzKGbbQk1pqWY2WpZ8nEJH0v1TAVZo9mrHefn4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762637; c=relaxed/simple;
	bh=NfIaEbFE6tne53B1K3SP4w24tpX68fomxSGpy77tg+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=tmwncjAJ6REmM65CYMF9/OZoFTxec6xtHCZ6BkbGHlOdi0WOP7xsT1rn2ayWf8Fhb6PeJRsUXOND0+OHXNbxBOgAqWi6z8vmKmOdUj99SJ76Y00GRpeP3IO06vdKLxR6NCy+HtNm2WEB7vhMgrQHWqrbfJET51Nebz5Ffhby4xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jXg+SJiN; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47RChpuQ052238;
	Tue, 27 Aug 2024 07:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724762631;
	bh=3pqorM7dKtY+DzoF9cedtwlfUW9R6L8fI92J7JrO2RI=;
	h=From:Date:Subject:To:CC;
	b=jXg+SJiN4aoiUj194zomIxDhsKwW4VwoaT2isbOHVP1EEt6FOCxcrOCCnxO4dhxU2
	 DLSgCKdTjGCDFGNkFVdH/bUlS65/maUnQPLlOARU54jMlbRrMt9YrFrnk2fWKWCG59
	 qECx9dHovCDt/GuaUX3Rtb69V6U8jbxw58j8d9Eg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47RChpfB129625
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Aug 2024 07:43:51 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Aug 2024 07:43:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Aug 2024 07:43:51 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47RChoFM031725;
	Tue, 27 Aug 2024 07:43:51 -0500
From: Jai Luthra <j-luthra@ti.com>
Date: Tue, 27 Aug 2024 18:13:37 +0530
Subject: [PATCH] dmaengine: ti: k3-udma: Prioritize CSI RX traffic as RT
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240827-csi_rt-v1-1-f0c5b9488a1e@ti.com>
X-B4-Tracking: v=1; b=H4sIAPjJzWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyNz3eTizPiiEt20ZLOktDRzA8M0C0MloOKCotS0zAqwQdGxtbUAVPu
 qu1gAAAA=
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jai Luthra
	<j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2207; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=tn564sNM/13BQBwb9jpbPGeKvRjs2Pl64fLXhn1aJ5k=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBmzcn/+PrDQnDiKcS6/A0/eY19ql+GJock00/uW
 80Na7O0XNyJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZs3J/wAKCRBD3pH5JJpx
 RQmvEADCjFydaBgUU33NKi20PCN4kvA31+hgOZ7SHpSJXp/KY19J8zOgN+ugiR5agkkUxWMEzYT
 MBYeIxkOs3AHjBlNoh9e1jvhelVEM01AtNx9rCVioBukuBaKK+64wGnt3HTnjKGIh9X8rX1cyAH
 hTN8VXfMCBwj7/OEXaJSgLpMpuGZoZL+Pjvo3uA/0KsdgqBgbXYVGo9V0CAkoKlaRioAe5htBMX
 dgOgAL+WsHO8RjIZ81fPtvko/3zKgOFgEdpBEfmv+lM1+q6juY21IjH7lE2LIQe3djbIOIMYsLG
 c8tUAedE5OONWOWMxVtLypExbqt5EVxmVi3dqLYKhoHU3wvRxvxiscjXfJ/R2bYfpmDTUn3xOfy
 6zWw0VUuG2cH1BClUen1REAtFhef9lfARS6hc8QvMhe8gDjiFYJf5KxVfxDzfywd+V2a1gNfrGu
 sFmdOrIFWnzsAuzfLqDsoTXMCWqTWudtNFayYHp1WoEz5PmbmhnDGjTwkyyT2EKcHtjPETjz/hv
 VjbC6dzJmS3L4Yq26XFNVj8Uh+fUY8Ecl3PXf/F+9hUVjaduQmiXQO3C4ritoG4VrgWl8ZvU8pn
 KjV5aa9bXAs84MJctA0hpgqWOtoE0DDECyOQXsRNpcmjaJgFS6PFKac/tg73i06V+DUAIKM1hZg
 Eknih/O2iYAceyw==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Vignesh Raghavendra <vigneshr@ti.com>

Mark BCDMA CSI RX as real-time traffic using OrderID 8/15.
This ensures CSI traffic takes dedicated RT path towards DDR ensuring
proper priority when under competing system load.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/dma/ti/k3-udma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 406ee199c2ac..74cdb9ec07c3 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -135,6 +135,7 @@ struct udma_match_data {
 	u32 statictr_z_mask;
 	u8 burst_size[3];
 	struct udma_soc_data *soc_data;
+	u8 order_id;
 };
 
 struct udma_soc_data {
@@ -2110,6 +2111,7 @@ static int udma_tisci_rx_channel_config(struct udma_chan *uc)
 static int bcdma_tisci_rx_channel_config(struct udma_chan *uc)
 {
 	struct udma_dev *ud = uc->ud;
+	const struct udma_match_data *match_data = ud->match_data;
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
 	struct udma_rchan *rchan = uc->rchan;
@@ -2120,6 +2122,11 @@ static int bcdma_tisci_rx_channel_config(struct udma_chan *uc)
 	req_rx.nav_id = tisci_rm->tisci_dev_id;
 	req_rx.index = rchan->id;
 
+	if (match_data->order_id) {
+		req_rx.valid_params |= TI_SCI_MSG_VALUE_RM_UDMAP_CH_ORDER_ID_VALID;
+		req_rx.rx_orderid = match_data->order_id;
+	}
+
 	ret = tisci_ops->rx_ch_cfg(tisci_rm->tisci, &req_rx);
 	if (ret)
 		dev_err(ud->dev, "rchan%d cfg failed %d\n", rchan->id, ret);
@@ -4332,6 +4339,7 @@ static struct udma_match_data am62a_bcdma_csirx_data = {
 		0, /* No UH Channels */
 	},
 	.soc_data = &am62a_dmss_csi_soc_data,
+	.order_id = 8,
 };
 
 static struct udma_match_data am64_bcdma_data = {
@@ -4370,6 +4378,7 @@ static struct udma_match_data j721s2_bcdma_csi_data = {
 		0, /* No UH Channels */
 	},
 	.soc_data = &j721s2_bcdma_csi_soc_data,
+	.order_id = 15,
 };
 
 static const struct of_device_id udma_of_match[] = {

---
base-commit: 6f923748057a4f6aa187e0d5b22990d633a48d12
change-id: 20240827-csi_rt-fc6bff701f81

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>


