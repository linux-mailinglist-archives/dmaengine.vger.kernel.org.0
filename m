Return-Path: <dmaengine+bounces-9418-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AGmOjGys2lYZwAAu9opvQ
	(envelope-from <dmaengine+bounces-9418-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 07:44:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C3A27E46B
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 07:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A61330AF3DC
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 06:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797ED359A94;
	Fri, 13 Mar 2026 06:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JAmiyZ0P"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010059.outbound.protection.outlook.com [40.93.198.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224613537C6;
	Fri, 13 Mar 2026 06:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773383159; cv=fail; b=dlokbDrJ4XUMz4O2bFbrGUnMqfAbA+JtaA+eebR+vRSJCjN/zUYWK9b5UBSCzbucCOdJoumytmjW4HZeM669U4vRMvFZ1KqJjUjiTlW4NGcj1B43Ls19mz3NujQhb/gjeBqQwrifvGgSP7fTqm6AgZrBRO9PdLPN1ar/lE92ALU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773383159; c=relaxed/simple;
	bh=NL6sKEt4zRdaTuJj2NAvumXJEcfIAY92xol+oCbjscE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCIzGEJ0U1C3HYCbrk6Kb6vU/Ks99rD4Bytts3sDZd8xDljPybnZHeBxxin+zATW6jSaan2dDlKjvVOWQbKQTR4MAiyWzjqfJ5uXB6jjwz74SBQAhngCHwniKgF6NKyB9RqjG0YJ0dTjLSNWmO6/aGQuDieyD1DgZd/dL3m9U6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JAmiyZ0P; arc=fail smtp.client-ip=40.93.198.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdFvH5IFasAZgjtB9f7vRxDdnOkdSxnt+mj19V6qQZ7WjxCPS7RZ7hLXRd07bAOUKNzljxeHyKRErwEN8Rw4RvVoqS/AzS6GKnfCmHNnWjSKkzD5GyMUEzMBY6DYnOY3V7oRzaQSbui/x+hqFl4MxS1763bFgabeCGvSYyvssYDKn3D9RBPoVBmmEmVkKQUS9Vmo7Ft8vGBwpqS7BD8MqRSR9c6k5WVXmP+xQBn7cbMmEqgNnwQirHWULdHCo3lftbHJrd6Lua6joBwrEQ4MyoMg0tRinrLIStpQ94hsbRi/ffEcEL6em7u8yVY00/Tx01BV/iwCfq1kXJTffCmCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKdrvTl/rG8iIr/pcNwmUAcSi2lPaphrF6+j1uPDQaM=;
 b=cm27IoNyw+2FpaaU2FCJhUSoZ4fLy/S391ez4zdbRhOVzlBVboMAlgBesJHALILPE8OBEm9buJvkFj6FzuT8dOjFsg9UfPeEdQysjrrL6HNArqFxARuDtmvCfTnTwTFijkpxW7FI7hoF4YJdEeK5VuP9jq8Sf5GVYYu3ce1Of1A/BDqVqyEQbPVijP3oA6WI50nkuj54+bULO7qlTcxIyag6y2U6XcW4+O60RIn7Meus5OKEt649Fp8Qq5u6gbKznJdJ2RefKJ9bCKGVPb2wZd7OvkzrVB8cAtsOReykQmZssOjJC7XAnb0l/D69uNnYrv7qcCTOkstBze635jJrLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKdrvTl/rG8iIr/pcNwmUAcSi2lPaphrF6+j1uPDQaM=;
 b=JAmiyZ0P8zAQjuLlnIUQbG5raGpvThIJ+TCXSCtHwDxLgF6anG40mlYrdXmow5LWsK2hSPkLOQ0yEBMqWjr/Bd1V/hdNBKw1xih2h4+y5KKa0zyTh0VjmIgp3Ci41aCQfn6c3wgLeqhLeZDAln2Nsu5BR8XX/bBvMu8VoyHLoNc=
Received: from CH2PR02CA0028.namprd02.prod.outlook.com (2603:10b6:610:4e::38)
 by SJ5PPF1394451C7.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 06:25:54 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::60) by CH2PR02CA0028.outlook.office365.com
 (2603:10b6:610:4e::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.31 via Frontend
 Transport; Fri, 13 Mar 2026 06:25:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 06:25:54 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 01:25:53 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 13 Mar 2026 01:25:49 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: Vinod Koul <vkoul@kernel.org>, <git@amd.com>, <srinivas.neeli@amd.com>
CC: Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Suraj Gupta <suraj.gupta2@amd.com>, "Radhey
 Shyam Pandey" <radhey.shyam.pandey@amd.com>, Thomas Gessler
	<thomas.gessler@brueckmann-gmbh.de>, Folker Schwesinger
	<dev@folker-schwesinger.de>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, Kees Cook <kees@kernel.org>, Abin Joseph
	<abin.joseph@amd.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 3/5] dmaengine: xilinx_dma: Extend metadata handling for AXI MCDMA
Date: Fri, 13 Mar 2026 11:55:31 +0530
Message-ID: <20260313062533.421249-4-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313062533.421249-1-srinivas.neeli@amd.com>
References: <20260313062533.421249-1-srinivas.neeli@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|SJ5PPF1394451C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 108fd581-8a21-42f5-f944-08de80c96158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	R1wsWCb2Hzi5QiQ+1NyJH2UnPzR1HS6/ku1cQ6DGyvyscZwmNZtoXtUro1XwsRl/ZyV1QKFoX0gY5MgK+4jChW1DzlH1l/La42q5r5Y8j5DXRrqDsbDs0ghvXvlj3pb+vxiWraK1pfNu9DO2h4kk+hOxFJewe/Oqqa61rp0f6BxYCYmOLkU0eYYhfNSEqB73FCa3Ket+RoiVmFx7UK+nzIlqpM5EaxvWVEJ/axLmzQuS9/DCCSMjntwxMdJ5WPwZBmev5p1Ql76o2vpeiKE3Ui9uagJjtiL30YV0zjO5/vvq/fzaWWyzg8bNrfZ0V/91mU8nF5gLauPC4xcfTilesEVRfr038GX0C2+EYRnauJNpVAwQuw+V7KrsAz6QcF3OiaCI0M6MXjcn9z/urpD96x95srQX+zmmws312kkyUVYi5StirPKGsv936g6sJmIeH591x82IZOCbj1wGJaYt6wz+bvVOBUUa7i54MWK2UGLZsARKh8M/auTjaC2aSxItiW50rLunJcQZ9xFGkroa1mOXoa44lAudqH58wSjMNJmLrQiVgcSA8wLQ9oHa8JWfz4o3NOghg9vrbQqw2Nd5sUlYjsFkatHjTQ7kKTXmvU0zsM4JDWSAzqP2Rp+9YcQu+uv262PFp/FXOIoxkiF3s/ejgtSeiEzq9I+PKmugKIwugwpnyYFgj8PyOmlHb5HuKjXFcmMlUaymz0cagGb4bBpYL61u/8IygVHSpjJIqsEaPZgstZdeiXZ/fQHIXQqtJWP3jwhYS/Nz34P59vc4Cw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vOerLlV65k42IQYdkD9SiT/Qk/ElkMeEgL+olZCzih3evKCAlHymE1m0Bm9xzDBli0U7x7XajG8j1+op9dJXo9kdEl//pRW7k6izF8RX23TxHKoXbNAfOEiE995E+oGnKwtjq9wFzbsiqCliUDFFp3DT9MU8rM+gJRm2qN+/yCBXWFbec03RT96o3e01CNRfyeezd7Osu7s5ipws8y8dZ4LeYlTBqHRBPY+vVtE5mwmRXGzGSkjXjwHE4z7ugbmv1mlOePfzKQD/Ia8yDm1G8rwLvn+QH5f+zHba1WwQgZjyTyPW1/o5lEuOH5eqmKSrQ37aRE66EBAt9sfs2TCAUR65IgSkxsUAetqs9aJ4p53fxyeq3YiZp4XupQTc08blBFDJMYjgaWaLa6NnoFUlbR6+ApL+vvRZjW8aZS8uHK4758Ef3qoL8RO3MxuEzK/b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 06:25:54.2871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 108fd581-8a21-42f5-f944-08de80c96158
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1394451C7
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9418-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 13C3A27E46B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Suraj Gupta <suraj.gupta2@amd.com>

Extend probe logic to detect AXI Stream connections for MCDMA. When
an AXI Stream interface is present, metadata operations are enabled for
the MCDMA channel. The xilinx_dma_get_metadata_ptr() is enhanced to
retrieve metadata directly from MCDMA descriptors.
Add corresponding channel reference in struct xilinx_dma_tx_descriptor to
retrieve associated channel.
These changes ensure proper metadata handling and accurate transfer
size reporting for MCDMA transfers.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 00200b4c2372..52203d44e7a4 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -222,6 +222,8 @@
 #define XILINX_MCDMA_BD_EOP			BIT(30)
 #define XILINX_MCDMA_BD_SOP			BIT(31)
 
+struct xilinx_dma_chan;
+
 /**
  * struct xilinx_vdma_desc_hw - Hardware Descriptor
  * @next_desc: Next Descriptor Pointer @0x00
@@ -371,6 +373,7 @@ struct xilinx_cdma_tx_segment {
 
 /**
  * struct xilinx_dma_tx_descriptor - Per Transaction structure
+ * @chan: DMA channel for which this descriptor is allocated
  * @async_tx: Async transaction descriptor
  * @segments: TX segments list
  * @node: Node in the channel descriptors list
@@ -379,6 +382,7 @@ struct xilinx_cdma_tx_segment {
  * @residue: Residue of the completed descriptor
  */
 struct xilinx_dma_tx_descriptor {
+	struct xilinx_dma_chan *chan;
 	struct dma_async_tx_descriptor async_tx;
 	struct list_head segments;
 	struct list_head node;
@@ -653,12 +657,23 @@ static void *xilinx_dma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
 					 size_t *payload_len, size_t *max_len)
 {
 	struct xilinx_dma_tx_descriptor *desc = to_dma_tx_descriptor(tx);
-	struct xilinx_axidma_tx_segment *seg;
+	void *metadata_ptr;
+
+	if (desc->chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
+		struct xilinx_aximcdma_tx_segment *seg;
 
+		seg = list_first_entry(&desc->segments,
+				       struct xilinx_aximcdma_tx_segment, node);
+		metadata_ptr = seg->hw.app;
+	} else {
+		struct xilinx_axidma_tx_segment *seg;
+
+		seg = list_first_entry(&desc->segments,
+				       struct xilinx_axidma_tx_segment, node);
+		metadata_ptr = seg->hw.app;
+	}
 	*max_len = *payload_len = sizeof(u32) * XILINX_DMA_NUM_APP_WORDS;
-	seg = list_first_entry(&desc->segments,
-			       struct xilinx_axidma_tx_segment, node);
-	return seg->hw.app;
+	return metadata_ptr;
 }
 
 static struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
@@ -848,6 +863,7 @@ xilinx_dma_alloc_tx_descriptor(struct xilinx_dma_chan *chan)
 	if (!desc)
 		return NULL;
 
+	desc->chan = chan;
 	INIT_LIST_HEAD(&desc->segments);
 
 	return desc;
@@ -2613,6 +2629,9 @@ xilinx_mcdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 		segment->hw.control |= XILINX_MCDMA_BD_EOP;
 	}
 
+	if (chan->xdev->has_axistream_connected)
+		desc->async_tx.metadata_ops = &xilinx_dma_metadata_ops;
+
 	return &desc->async_tx;
 
 error:
@@ -3261,7 +3280,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
 	dma_set_max_seg_size(xdev->dev, xdev->max_buffer_len);
 
-	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
+	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA ||
+	    xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
 		xdev->has_axistream_connected =
 			of_property_read_bool(node, "xlnx,axistream-connected");
 	}
-- 
2.43.0


