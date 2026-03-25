Return-Path: <dmaengine+bounces-9646-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPFXKLbiw2lvugQAu9opvQ
	(envelope-from <dmaengine+bounces-9646-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 14:27:18 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FFC325BBC
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 14:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3CF3327BD56
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 12:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1E43D646D;
	Wed, 25 Mar 2026 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lOLpDyzq"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE233D47CB;
	Wed, 25 Mar 2026 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442228; cv=fail; b=n0qkaQWCnxCrwKvb4iZNs/WYAzEezRhKNXA62oM2yd64Do8Je5WUWR9xl7fRU9A41ojsa3XGBr4VjGNHOvDPP/40BSzoGoIruBjQsoqMRAxQ2CiYy/lfueMDjeP2ZGc52AQlsS954n1hR+L+e8uRnBq5iPsfYKnEsNwUHNkJT1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442228; c=relaxed/simple;
	bh=VtF2Dn63V1qZsgnrMagHx1RYq/UllKKN9/DEtUYNdiI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOaP3RnlajeueFF6sLwoQHerPOEQC7aPS1Ay5xEmiEprmX/lnqcBpqk8B7joS6iOYkiO01ZVodmc/K/dEAbEnzfQ7oD7UQP8vGGlVyzSPUWp4WPcKHuXN2zkzIXpbtHUZrJNvodRwfKhx00vv1ie4zbrZogS3NyIzOnl0uztftM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lOLpDyzq; arc=fail smtp.client-ip=52.101.46.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgoRLuyPMik1/mwglpMjhQQcLmUsLsFkOHwIDALVtweBCC7s/d/GPniGEb6zZN8UnlLwbDMIVvZRRXh78A96ZlLGQdPQ0ug+6EJh9JS+Yti+LMVh0LInVswiTuTwH8CP8NkHdxKE7Rwh7r+ZMsfTqk5d8TB4z4lRhmEyBsDgLaUU2sagtEtH0j/YQHbsiVwwgCHtQ9LJyKUViE6kuymPUqirEihGzHr47D7C5qsrsd5lH1jRe5RGlBdS2yBAtvUCJ3urs+Yp+4SDV2CAvdpWdaJnsmjPReFYAGq9d50b7gUZgnP6GFUQZ/4dPOv5+PQGUQKbxXwKDeqqAC6vGvQ4Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXASJXcjmzTGF/yzR+p9MEZii5npAATesC5z9WWpk38=;
 b=hlPYsxvSsxcLazkAvGFStp9HHqsEvgVrv/ODPGui8KR3K66/ooIZaOj6Pqc35M5CFlIbzdmUxFeM3FeaN/Bqt3yikicNVS+zs7Q8TQmZ16dF9GW+GJlVQgeXA26LSKr34bzbiMktAYdX+sgQ6YCnU68K9vhSplsIHSgpkKFS6ckn+gh2jsOOImOEU4CvOdbbbVafenyGSevkd6Etfdrp3BqPizyu/sL0F88AF1FU8zgeKIUmxQahaSBSKaqANe2qrucv+2rrtdsf3HhorbkjcJvZwFrmPdWsjM8iz/Nnpbvh1D3hBgo26+kq2rDSXG06ggvqcFYviO/C6Pb2vTSE8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXASJXcjmzTGF/yzR+p9MEZii5npAATesC5z9WWpk38=;
 b=lOLpDyzqeRwcRIMhV3VvM+MX2dLEIrVIjq5Abc6U5wHe0bl0bcd5d4njkidHWFjn+CaiEI8oCCHuHO52YNPYiqaE7c//3iuzhmemxfGNTGao4Rpr7PltGUovG8phhIIOGeqwG7JtaQG4aUPvmj0mz25HDYesgC+WryEXLpTw4U8=
Received: from BYAPR21CA0011.namprd21.prod.outlook.com (2603:10b6:a03:114::21)
 by SJ5PPF1D8DEF14F.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::791) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 12:37:04 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:114:cafe::f2) by BYAPR21CA0011.outlook.office365.com
 (2603:10b6:a03:114::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.6 via Frontend Transport; Wed,
 25 Mar 2026 12:37:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 12:37:03 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 07:37:03 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 07:37:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Mar 2026 07:37:03 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62PCakEX270453;
	Wed, 25 Mar 2026 07:36:58 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <Frank.Li@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <nm@ti.com>, <ssantosh@kernel.org>,
	<horms@kernel.org>, <c-vankar@ti.com>, <mwalle@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [RFC PATCH 2/6] soc: ti: k3-ringacc: Add helpers for batch push and pop operations
Date: Wed, 25 Mar 2026 18:08:38 +0530
Message-ID: <20260325123850.638748-3-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SJ5PPF1D8DEF14F:EE_
X-MS-Office365-Filtering-Correlation-Id: 14229a37-b3c8-4f0f-c289-08de8a6b3814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	44MyB7moQ86QVdw4L9Q/gNT6bstKZ6jL2a2+q+S6akZM7JlMuoL+LW04hCTbrPjc3jZHNlDrPTvzqYQVWIhnHriesq+X2ZEtyaQgAs62H87NluGHTTWpJsykgfsiyiqhrWaDwyKT37ooBFF6iJnX8HYeVNKvygnHz4XEx+gdh25kk7wZMToeoR5NXnWm1LwOi7E6DkURQCipHbBwrX669UEBJtR6P2gNlwKijp2aqInZe/tcRTYjRP9Y058QHf+BcKcZavnFlT07kfxDpy1AKTcnQdFXtOoWFw9YZYvUBFzdG0DxM/E3YMgyFX0aeyt/mEf8pGJwbItBqGHinRu/dgHBj1hOjnFBN3BpohUjxbTGXLeigONk3wNR4fqT0ggkOPns5hGHGbrvhvFzpIwmgRASSblSL/AqpLLwTBYZ4zZhcHCbnlAst9yzjsg6X7ZE7c7SRHQ5M7rX3O6OuNB1rjWjn8Pz52PRz+t1F/TYeIk4c7JthJ+3XogOJXk1Mt3Ad04cVBvhS/gOmxZSxI5VpxBkfBg3aRpPYLYqqNDr7wcBQALrVdOOJ2WDz0q2/6gfWxvV9QX3+ICTMrlLw4qRHdXuM/d6N0wd44ehZ5bNBzn423uxMjo5q+m/u2XeJnNsWpImMC3SlFGDfQWxStGDPP/3OlaBe8JpIosn6c5P7WJmviTqIRpIIPzJUYPXyhSaJw4uwp6D2jK90uHJHWn3pPAXnQI+W8bOBF/eazqXVBvaSEaoXipKbNNzBwAzYAcTpMnqsa8UADddVew44MFfyfMYHv9U1/tvM0aCNAYGxxa3VzMrRrNSNbmbrYPEkLLK
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VHrsoDIhf7uw/mlhw71LVt5BINyErqThIA9IN0sZMuH+ZUUz8Zw/TANGVmJVV5gUP+Zu/jxqEz6gpdx8wcGH6NIFERH7MQn5E/m/+fMIQFarzY2G0QcH6jAZk/vpiKzcHc4K316WXPRWfFMQ0Jp2R66jxALDd1a3tef55zzMQwsSCluDo9FihQR2q9kvNLVM8nSY2BWjSzO9uaP+DKueq8gPhalInpwQX9k7lQZl8/xSv+ppduMjCgpjnM/e4IYCdKeop8b0ZJ90Koxj8jkan6Afbl7NpxAeo9y3vErJJgHeMF+8DGd7WLwYgHxqolyQ6KFxzsFmQ/kBvyAlZEr/EO7/t5H7Opg9OdtxS0VznZ2iMGXmY9SHLJs5d1rd2HdIy2ca2r6r06PPnCFvkHHpZ+vr8lPeMLP9I6XquCg4ZT1lLd7fMDC9Sxov/uyCALhH
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:37:03.8942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14229a37-b3c8-4f0f-c289-08de8a6b3814
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1D8DEF14F
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,ti.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9646-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:dkim,ti.com:email,ti.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 43FFC325BBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To allow pushing and popping a batch of descriptors at once to improve
efficiency, introduce two helpers:
1. k3_ringacc_ring_push_batch
2. k3_ringacc_ring_pop_batch

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/soc/ti/k3-ringacc.c       | 88 +++++++++++++++++++++++++++++++
 include/linux/soc/ti/k3-ringacc.h | 27 ++++++++++
 2 files changed, 115 insertions(+)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 1751d42ee2d3..33ae7db9c2a1 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -1223,6 +1223,41 @@ int k3_ringacc_ring_push(struct k3_ring *ring, void *elem)
 }
 EXPORT_SYMBOL_GPL(k3_ringacc_ring_push);
 
+int k3_ringacc_ring_push_batch(struct k3_ring *ring, void *elem_arr,
+			       u32 batch_size)
+{
+	void *elem_ptr, *elem;
+	int ret = 0;
+	u32 i;
+
+	if (!ring || !(ring->flags & K3_RING_FLAG_BUSY))
+		return -EINVAL;
+
+	if (k3_ringacc_ring_get_free(ring) < batch_size)
+		if (k3_ringacc_ring_get_rt_free(ring) < batch_size)
+			return -ENOMEM;
+
+	dev_dbg(ring->parent->dev, "ring_push_batch: free%d index%d\n",
+		ring->state.free, ring->state.windex);
+
+	for (i = 0; i < batch_size; i++) {
+		elem_ptr = k3_ringacc_get_elm_addr(ring, ring->state.windex);
+		elem = &((dma_addr_t *)elem_arr)[i];
+		memcpy(elem_ptr, elem, (4 << ring->elm_size));
+		if (ring->parent->dma_rings) {
+			u64 *addr = elem_ptr;
+			*addr |= ((u64)ring->asel << K3_ADDRESS_ASEL_SHIFT);
+		}
+		ring->state.windex = (ring->state.windex + 1) % ring->size;
+	}
+
+	ring->state.free -= batch_size;
+	writel(batch_size, &ring->rt->db);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(k3_ringacc_ring_push_batch);
+
 int k3_ringacc_ring_push_head(struct k3_ring *ring, void *elem)
 {
 	int ret = -EOPNOTSUPP;
@@ -1266,6 +1301,59 @@ int k3_ringacc_ring_pop(struct k3_ring *ring, void *elem)
 }
 EXPORT_SYMBOL_GPL(k3_ringacc_ring_pop);
 
+int k3_ringacc_ring_pop_batch(struct k3_ring *ring, void *elem_arr,
+			      u32 *batch_size, u32 max_batch)
+{
+	void *elem_ptr, *elem;
+	u32 ring_occupancy, i;
+	u32 num_to_pop;
+
+	if (!ring || !(ring->flags & K3_RING_FLAG_BUSY))
+		return -EINVAL;
+
+	if (!ring->state.occ || ring->state.occ < max_batch)
+		k3_ringacc_ring_update_occ(ring);
+
+	if (!ring->state.occ) {
+		if (likely(!ring->state.tdown_complete))
+			return -ENODATA;
+
+		/* Handle teardown */
+		elem = &((dma_addr_t *)elem_arr)[0];
+		dma_addr_t *value = elem;
+		*value = CPPI5_TDCM_MARKER;
+		writel(K3_DMARING_RT_DB_TDOWN_ACK, &ring->rt->db);
+		ring->state.tdown_complete = false;
+		*batch_size = 1;
+		return 0;
+	}
+
+	ring_occupancy = ring->state.occ;
+	if (ring_occupancy > max_batch)
+		num_to_pop = max_batch;
+	else
+		num_to_pop = ring_occupancy;
+
+	dev_dbg(ring->parent->dev, "ring_pop_batch: occ%d index%d\n",
+		ring->state.occ, ring->state.rindex);
+
+	for (i = 0; i < num_to_pop; i++) {
+		elem_ptr = k3_ringacc_get_elm_addr(ring, ring->state.rindex);
+		elem = &((dma_addr_t *)elem_arr)[i];
+		memcpy(elem, elem_ptr, (4 << ring->elm_size));
+		k3_dmaring_remove_asel_from_elem(elem);
+		ring->state.rindex = (ring->state.rindex + 1) % ring->size;
+		dev_dbg(ring->parent->dev, "occ%d index%d pos_ptr%p\n",
+			ring->state.occ, ring->state.rindex, elem_ptr);
+	}
+	ring->state.occ -= num_to_pop;
+	writel(-1 * num_to_pop, &ring->rt->db);
+	*batch_size = num_to_pop;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(k3_ringacc_ring_pop_batch);
+
 int k3_ringacc_ring_pop_tail(struct k3_ring *ring, void *elem)
 {
 	int ret = -EOPNOTSUPP;
diff --git a/include/linux/soc/ti/k3-ringacc.h b/include/linux/soc/ti/k3-ringacc.h
index 091cf551932d..6fffa65ee760 100644
--- a/include/linux/soc/ti/k3-ringacc.h
+++ b/include/linux/soc/ti/k3-ringacc.h
@@ -220,6 +220,19 @@ u32 k3_ringacc_ring_is_full(struct k3_ring *ring);
  */
 int k3_ringacc_ring_push(struct k3_ring *ring, void *elem);
 
+/**
+ * k3_ringacc_ring_push_batch - push a batch of elements to the ring tail
+ * @ring: pointer on ring
+ * @elem_arr: pointer to array of ring element buffers
+ * @batch_size: count of element buffers to be pushed
+ *
+ * Push the batch of element buffers to the ring tail.
+ *
+ * Returns 0 on success, errno otherwise.
+ */
+int k3_ringacc_ring_push_batch(struct k3_ring *ring, void *elem_arr,
+			       u32 batch_size);
+
 /**
  * k3_ringacc_ring_pop - pop element from the ring head
  * @ring: pointer on ring
@@ -232,6 +245,20 @@ int k3_ringacc_ring_push(struct k3_ring *ring, void *elem);
  */
 int k3_ringacc_ring_pop(struct k3_ring *ring, void *elem);
 
+/**
+ * k3_ringacc_ring_pop_batch - pop all elements from the ring head
+ * @ring: pointer on ring
+ * @elem_ar: pointer to array of ring element buffers
+ * @batch_size: pointer to count of elements popped from ring
+ * @max_batch: maximum number of elements to pop
+ *
+ * Pop a batch of element buffers from the ring head.
+ *
+ * Returns 0 on success, errno otherwise.
+ */
+int k3_ringacc_ring_pop_batch(struct k3_ring *ring, void *elem_arr,
+			      u32 *batch_size, u32 max_batch);
+
 /**
  * k3_ringacc_ring_push_head - push element to the ring head
  * @ring: pointer on ring
-- 
2.51.1


