Return-Path: <dmaengine+bounces-9647-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLemBbHYw2lwuQQAu9opvQ
	(envelope-from <dmaengine+bounces-9647-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 13:44:33 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A5032516F
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 13:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D4ED309A797
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 12:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D6F3D5237;
	Wed, 25 Mar 2026 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gObccjiu"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195603D4132;
	Wed, 25 Mar 2026 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442233; cv=fail; b=CpEhmD2JdUINuFr1m9gm0g8gM5LLptNPzWDVLrLqXQm5Z3VijZF8Vxb4oKrryri4EiSshgU2YfiIf8lNXwXvna6mcrRVq1g4qHjeguFhxOdkugIDHzZBO1W7+OsyaZHRzo9JQz4nnvAyLkAmyBqAmHw2gDUyospf4ike5+YtWmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442233; c=relaxed/simple;
	bh=/PSCNRiqROKUR+dU+cJ9fSgqQ23LbkP8bIDrqmfr/Ao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8+xvmY5iCtoUksfruK31AhNPvh4+oVPPW24z5nAn/SbTOCi/ey1zhPHx+/PtAmF6C0Z8Qx3drfzcGC5tphsbRaTBwMm8mvihURfCNKu54zGc9C2NoYfd8omHavZGbsGTSXm9BIKgWSgQ4n9RupRdywReeuz6Bm33hlR9QZIppM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gObccjiu; arc=fail smtp.client-ip=52.101.46.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dW8Y8sSbFaUpJNDccmvZwVX0/NLzTRAYrjDRFuM30KTKIzs0/Q+7RzgZfY212HNOO3dvoRGNGFlCQenzNnvR+KChIr4uF6BmE3jF9Y3i8mXoTkYA5PL3lhMtg2LjxNSWo3w2pYAf7AkXOXrJc3bCTLnvBPhSzDywEMDuNm8jOIH0mhoxa3sAlMGpQSns2Bm7Q0D5sOENb6klPcq3eK+LgFl648BsJykgz6Kq8kb3jgNSig8j7ywxJQrWwQBz2vp7/IAyn5ZPoPiGXSJ9WClg44PVJK3eogvXPAa2MLWmrgFvMQyyeh8bsjoA4Z07sWTL1oT5GpVTmBoxozZcKzgCWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgKZ7m4P6eAx2iXaOwJ4lkCoEHQIYnxfzLoU2fRC6ow=;
 b=tD6G9+Yyl97YyobizO3uixKimu5yThy8phx6t49yywrHTmdxlAYMgMxUvX8yFS/MbuJO9M2Qig1WYieFtU8MMigl6JHx6OWiUwKlW6MKOuwRjZY4SzVZbeoWJ1Vy9+ZiKyi9vZCcFa6ZHQ/dc1ASZSfaVkVAQgRca7gf6Jjx8/CFy51CMqRu2F/ylvXW9sRLsTj5VDjHOZhtb/8yucimEJYHb5oNkyu3cf2mNGhvTrLrM9lIwUTanbG56rF9A2RBAh8Z82MZaCtAvikt98jcKy/9gAZb2qWSgoTuw8V03BPpEONEGheo5hIri9ozNzVp177pAQE3hDQ/sOA9AFGT7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgKZ7m4P6eAx2iXaOwJ4lkCoEHQIYnxfzLoU2fRC6ow=;
 b=gObccjiux7e/IQFVZBamVb5brnL+4y7X1+KVKYooN8za8edKActZgVQA+i7EpH5gXkMqTz3he1WDIXzTwDb6R+W1HTI8NEHJSV+a9tZGDzvLNGbayqQaqQZjHTPGhc9kpFak5g2E2KK939xHcDNlydInlJyoJGfoLkDiEb/HhaU=
Received: from MN2PR22CA0028.namprd22.prod.outlook.com (2603:10b6:208:238::33)
 by BLAPR10MB4868.namprd10.prod.outlook.com (2603:10b6:208:333::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 12:37:09 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::9a) by MN2PR22CA0028.outlook.office365.com
 (2603:10b6:208:238::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 12:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 12:37:09 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 07:37:08 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 07:37:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Mar 2026 07:37:08 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62PCakEY270453;
	Wed, 25 Mar 2026 07:37:03 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <Frank.Li@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <nm@ti.com>, <ssantosh@kernel.org>,
	<horms@kernel.org>, <c-vankar@ti.com>, <mwalle@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [RFC PATCH 3/6] dmaengine: ti: k3-udma-glue: Add helpers for batch operations on TX/RX DMA
Date: Wed, 25 Mar 2026 18:08:39 +0530
Message-ID: <20260325123850.638748-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260325123850.638748-1-s-vadapalli@ti.com>
References: <20260325123850.638748-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|BLAPR10MB4868:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ef2f5b-8217-4cd3-7da6-08de8a6b3b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	hNMA/YMX8+b+8oY7hEFzCX4ka+Mo/N9QHLWOf2pK6lpkhFW7BU2kfkhvryCDOCH9ULPkdcY2FDp+6VTvSeLkEirsnJjAsgOGgSZ/FLoLROr7gpKibtlcwarRpCCSpDm0oE714fqiLFj7Tg6kvY2ZSAXtjD2c20aeVuBt3NXJxYOKfAPvdVglcDrkiZxn0HO3KokjV3+PgCNtXC2olWiXSZ2H24WlQuaEUy2uLJYT1Y8/ydpx7Rl8PcFhjAtn4jMlJIwp25xw6pXKVHOafTOm8vK5ZSY39Dxb8t8OCi6T4UdXoPwY24WxNJulhdm3ykw633nZEA69LnEUkmJN0KElueCZYo2a80nMoDvExQsQBd7Qde570gxNG3mCML5oZJS+34qcICgcREAHPkPuC7CCrthiBXCUQr+I2UNeXgWIzz33QA7OM3P0qZdTyf51Ml5L6QIUn6YEHhPRnU6SaMCyp9+NjSkVRHrfe6amriSX74pahHKao0kItlQNg+BXmsK8m3LyFliA4YBIVMoFQXit07vJH0rOY8yo5HbSGTKQYlHEzcEofpYl20xjcuS7q8sA832zIfwGwVS8NGliuyW6rB7f+VfDR0lQjscZEdH43huzzmQ5qLUcHMQmweITspkmLjnc+ebdPRuhS4fa8vi2dWiF8CKU61anqurYXPzR91GfgKJwDjzTCkn7SskAKBXLnBPZKSrFDnVho49EtPM/b46U7uzcckN3pV5s3F0gO614+kPARcOLuGu5+iXPe2AlBe4ndKnUdDsT6acA1nld4w0SsOQBm082Kf8+3MGN9bNoJpshH7K7OiHKwVT9lI28
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B+LKMKLP73xLUfw/LiInwyIC6PA0piF7f0mXJ20xJJrUtRNTIizln67vq6U/BXutlXKiUvrPzmbdMFDIl10MvDqqHMeFsm+xS7XkdnhADgGfYHGpbFpYEWbTEopEeluCUtjGCxW1Nud23b0Zj5ws9a8/nQouhBUWQPb/0n9oKDHSOze1TX6ruKWGWp9g7/0zeVCrLybN0KLabPd/NznCnJJNZ2oct9NaWs03QQ4QiDnD9Toq2LisQP7BUcEOE4+WGjb4rqaZEQ6nwglmMqCOBnNS2hjuT21y+hKlTvTqYoGe3LD+yE0Rcu+1oatUgpwco6c9i7xcuwE3LpnR+jYY5ObajYdJUhcj382hpbpKES8bKQS3h8UUz+g90du4F2vmAsKVX2ff9YceCpcPZT9BIDJGPL8zsKRmNCa3a9sIyAB3SsQK0XqQGh8LN6tU9vjR
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:37:09.3362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ef2f5b-8217-4cd3-7da6-08de8a6b3b51
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4868
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,ti.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9647-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:dkim,ti.com:email,ti.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C5A5032516F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To allow pushing and popping a batch of DMA Descriptors on the Transmit
and Receive DMA Channels (Flows), introduce four helpers:
1. k3_udma_glue_push_tx_chn_batch
2. k3_udma_glue_pop_tx_chn_batch
3. k3_udma_glue_push_rx_chn_batch
4. k3_udma_glue_pop_rx_chn_batch

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/dma/ti/k3-udma-glue.c    | 55 ++++++++++++++++++++++++++++++++
 include/linux/dma/k3-udma-glue.h | 12 +++++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index f87d244cc2d6..15835c521977 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -485,6 +485,25 @@ int k3_udma_glue_push_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_push_tx_chn);
 
+int k3_udma_glue_push_tx_chn_batch(struct k3_udma_glue_tx_channel *tx_chn,
+				   struct cppi5_host_desc_t **desc_tx,
+				   dma_addr_t *desc_dma, u32 batch_size)
+{
+	u32 ringtxcq_id;
+	int i;
+
+	if (!atomic_add_unless(&tx_chn->free_pkts, -1 * batch_size, 0))
+		return -ENOMEM;
+
+	ringtxcq_id = k3_ringacc_get_ring_id(tx_chn->ringtxcq);
+
+	for (i = 0; i < batch_size; i++)
+		cppi5_desc_set_retpolicy(&desc_tx[i]->hdr, 0, ringtxcq_id);
+
+	return k3_ringacc_ring_push_batch(tx_chn->ringtx, desc_dma, batch_size);
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_push_tx_chn_batch);
+
 int k3_udma_glue_pop_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
 			    dma_addr_t *desc_dma)
 {
@@ -498,6 +517,21 @@ int k3_udma_glue_pop_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_pop_tx_chn);
 
+int k3_udma_glue_pop_tx_chn_batch(struct k3_udma_glue_tx_channel *tx_chn,
+				  dma_addr_t *desc_dma, u32 *batch_size,
+				  u32 max_batch)
+{
+	int ret;
+
+	ret = k3_ringacc_ring_pop_batch(tx_chn->ringtxcq, desc_dma, batch_size,
+					max_batch);
+	if (!ret)
+		atomic_add(*batch_size, &tx_chn->free_pkts);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_pop_tx_chn_batch);
+
 int k3_udma_glue_enable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 {
 	int ret;
@@ -1512,6 +1546,16 @@ int k3_udma_glue_push_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_push_rx_chn);
 
+int k3_udma_glue_push_rx_chn_batch(struct k3_udma_glue_rx_channel *rx_chn,
+				   u32 flow_num, dma_addr_t desc_dma,
+				   u32 batch_size)
+{
+	struct k3_udma_glue_rx_flow *flow = &rx_chn->flows[flow_num];
+
+	return k3_ringacc_ring_push_batch(flow->ringrxfdq, &desc_dma, batch_size);
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_push_rx_chn_batch);
+
 int k3_udma_glue_pop_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
 			    u32 flow_num, dma_addr_t *desc_dma)
 {
@@ -1521,6 +1565,17 @@ int k3_udma_glue_pop_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_pop_rx_chn);
 
+int k3_udma_glue_pop_rx_chn_batch(struct k3_udma_glue_rx_channel *rx_chn,
+				  u32 flow_num, dma_addr_t *desc_dma,
+				  u32 *batch_size, u32 max_batch)
+{
+	struct k3_udma_glue_rx_flow *flow = &rx_chn->flows[flow_num];
+
+	return k3_ringacc_ring_pop_batch(flow->ringrx, desc_dma, batch_size,
+					 max_batch);
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_pop_rx_chn_batch);
+
 int k3_udma_glue_rx_get_irq(struct k3_udma_glue_rx_channel *rx_chn,
 			    u32 flow_num)
 {
diff --git a/include/linux/dma/k3-udma-glue.h b/include/linux/dma/k3-udma-glue.h
index 5d43881e6fb7..9fe3f51c230c 100644
--- a/include/linux/dma/k3-udma-glue.h
+++ b/include/linux/dma/k3-udma-glue.h
@@ -35,8 +35,14 @@ void k3_udma_glue_release_tx_chn(struct k3_udma_glue_tx_channel *tx_chn);
 int k3_udma_glue_push_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
 			     struct cppi5_host_desc_t *desc_tx,
 			     dma_addr_t desc_dma);
+int k3_udma_glue_push_tx_chn_batch(struct k3_udma_glue_tx_channel *tx_chn,
+				   struct cppi5_host_desc_t **desc_tx,
+				   dma_addr_t *desc_dma, u32 batch_size);
 int k3_udma_glue_pop_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
 			    dma_addr_t *desc_dma);
+int k3_udma_glue_pop_tx_chn_batch(struct k3_udma_glue_tx_channel *tx_chn,
+				  dma_addr_t *desc_dma, u32 *batch_size,
+				  u32 max_batch);
 int k3_udma_glue_enable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn);
 void k3_udma_glue_disable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn);
 void k3_udma_glue_tdown_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
@@ -127,8 +133,14 @@ void k3_udma_glue_tdown_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
 int k3_udma_glue_push_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
 		u32 flow_num, struct cppi5_host_desc_t *desc_tx,
 		dma_addr_t desc_dma);
+int k3_udma_glue_push_rx_chn_batch(struct k3_udma_glue_rx_channel *rx_chn,
+				   u32 flow_num, dma_addr_t desc_dma,
+				   u32 batch_size);
 int k3_udma_glue_pop_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
 		u32 flow_num, dma_addr_t *desc_dma);
+int k3_udma_glue_pop_rx_chn_batch(struct k3_udma_glue_rx_channel *rx_chn,
+				  u32 flow_num, dma_addr_t *desc_dma,
+				  u32 *batch_size, u32 max_batch);
 int k3_udma_glue_rx_flow_init(struct k3_udma_glue_rx_channel *rx_chn,
 		u32 flow_idx, struct k3_udma_glue_rx_flow_cfg *flow_cfg);
 u32 k3_udma_glue_rx_flow_get_fdq_id(struct k3_udma_glue_rx_channel *rx_chn,
-- 
2.51.1


