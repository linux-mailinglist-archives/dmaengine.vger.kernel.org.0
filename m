Return-Path: <dmaengine+bounces-10170-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPWPNQJ/8GlSUAEAu9opvQ
	(envelope-from <dmaengine+bounces-10170-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 11:33:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3249B4817F3
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 11:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FC243032F52
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 08:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DF93DC4A1;
	Tue, 28 Apr 2026 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DiK9jQwa"
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAAE3D810F;
	Tue, 28 Apr 2026 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366386; cv=fail; b=j3zOjvTxgnV+zyYW9SGcQosIqQZKB+QQOCISWhBy+nri7ak1vhuAPHxDzj4fr2yImShDp+X9hDID4r7JFt526Thwqcrs2dE4vt2/lVA3nm+rEa3aFjrx/kBka/wwn9Y9wnNq3UvACHLKe54JDawn6OKbu4ylhTRj0ClIz74ytJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366386; c=relaxed/simple;
	bh=FL6pFKhcl0KhqsgZRQ5Rn6J+eI4+71d8mO/VpwQvZBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NyzV+U/trJzhkkk4dlzGUfRmMATWz+dB3IK/nH38aus7XBqlsfRGCwieErAXgk7DrQ2VnLKrsyrEzSofFzw5CPj9ZPL+8nzdYNK8sqCot3ns0wls0HwrTkF67iqJ+eXC2AlkwYuY1KEAvHf2u1ZnT0EpHJzL5Qq37FlO4TUcydM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DiK9jQwa; arc=fail smtp.client-ip=52.101.48.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wL0RD9EZc/ktVMuvv1r9lKw8BuXDXuRywroQz6mPTn6HXAEdMi3VpleV1TAjEYwoD6gl4b/m9AGr4+u3xEirUfxYV+mm0vH33Z65oKND8NQm2ooUoUkB9UQzQMFMXgk0qDA6hKAHbpdtw4SD/mfzDf/MmQ5/gau9rchThkdWR7HgD8xZhDt2Ykpr3x8xAY19usHaucRdfdd9TIAjObMWPr30I/g6ECzWhaTUl7MbK8X8E3A/HN0QdmLuBndRfUXosY9zX0xdflEey1xjJzcZgJsSFGdHILW6JWk4n2aWvyDfdnmkfpXqm+XexUjTKP8jUcbzDyhExxIG653Mr4smfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bd6jmkci0QKsJk2nCDDSZn7AM0lqsJgD8k8MS/Dm6k8=;
 b=M/4rP5wn0pAWGbiVM1YTZ/n7T33lEbO6XXCyM6ozHBTe1mjqTbO0/v6Fz1u5KEdt4N6wda0R2pJxAKMz1jkVUVQlW6HEQoSMZtTJ6m3/C01gC8AT1tB7Wr82KuxAPbNX3aunB6RQ6XZ72iSlP0RK+TQbmI2pzNzOoDztwXDUDp21GFEA/DpDbATCQlj3VtXjIwuI8XsldN003OalHpWqvrS+LbqnysIRBJ/K88lZjnLa8Pbb2Fse0LbncPFcJdae10ubd+rOrGtf9mll4kd9m1YO/Yc0Oy+zlkCgmCZVgLYjIeu2ZqbTnnJ9cEKrhoocyWfOE5jsaflLFWYrVnLGWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bd6jmkci0QKsJk2nCDDSZn7AM0lqsJgD8k8MS/Dm6k8=;
 b=DiK9jQwaXM3OFaz6VeskjyGKQVmlR7BlFMaq5zlwflnaSoMH64yzAGJhnt/0sJ1UyXykr2nAn4MioIR3QriCME2ixOu141nAHCnGsfuYKXDqlGgJQqeM3F0k6rRJL7gfA54gfSx5pPHodTQH9jndyNpAxUP34E9MlClra/FFWEE=
Received: from MW4PR03CA0206.namprd03.prod.outlook.com (2603:10b6:303:b8::31)
 by IA3PR10MB8707.namprd10.prod.outlook.com (2603:10b6:208:571::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:53:03 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::a6) by MW4PR03CA0206.outlook.office365.com
 (2603:10b6:303:b8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 08:53:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 08:53:01 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:52:40 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:52:39 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Apr 2026 03:52:39 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63S8q6MO623293;
	Tue, 28 Apr 2026 03:52:35 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v6 06/19] dmaengine: ti: k3-udma: move ring management functions to k3-udma-common.c
Date: Tue, 28 Apr 2026 14:21:35 +0530
Message-ID: <20260428085202.1724548-7-s-adivi@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428085202.1724548-1-s-adivi@ti.com>
References: <20260428085202.1724548-1-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|IA3PR10MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c9d6e9-e0a3-4513-ee7e-08dea5038dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	iNsaAg+FrU1MteLAcinmDyItrflG+iJ7jIfiXGV1i+q/PJqsU/smcp4oA6cVOZrhHZl08It2eAfedPXs7qm0mXZ1MkZD0ysWSBScfomjKOjfPlQIo0PH13UZKri1izpJusX4J1xzX4E4SyQC3n9IgeTYmlmj2ljrWcsoeBfAZgdiFHZVLlnc2fep0jqOymD5MNKD+38YP1ifyQZQ08UZZDmFqAzMLU2iEKAFOuPqMz94axiARJd0B6k5ATpjPxWgIj8ydLScHFS4IPteiscHoQ3fZmi4WeKEKk7DcPGJAgGs+eJZKb6QOYnM3dvPBci3IRi5nsAJA5j+ae7BFyTWiZrA5pzPCDzzyAGb+3lc5V2zkt+qwIwwuFJXwFWaH7Rayi0IiaRxK4Z2CXhNLRZingc25lI5h2zjZjLdDJ+jae8Gwzo2huJ1YmT8nO8FhTfmXdkohszBZWJW6kqOumo9novstbqiirgu0wrYS6Ug//Lo/QDg2pcVKaMCVTms+Fm4D5AwXpiRQSHfL6AO6+rA4Y1dju7rOD834Bi/u6K8qBy0hSMu4yw++lCLk6XcvRe5oWjtywQ2Cwol9HgG2a/gbAEfpO5a2aC88/9WkuFX7N5fJKNMSYfaZC7bk6vYQ7cZHxvebb7bQpN4uhBgDEHjHce1VoEmkRmcvVZ71Dgkvw9UFEHXfmS1BpKIcLoXagxzJnfeGPogNXd8Ip5ZODrl2ytk+S7Qy9lxxDzxh5NQGsS9rZSIBCSJ3SSSIQhc+8lSC2vSRb2YBlbzKEywfqtGr2dwFgO2xd7azzv/D0XijQYfi9erN8diQwnGP9Vr6LjH
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gaewmLXw3jvUAs/0I2ARwnQVbsaUb70n8SdaeaAHW4ZpsUNwdn/bDArcohETi9HnXXSGqQ4k0keuf5elE7Bt1/FLqHGCvWJu+gtVSA+lcABP7Ebm5SUhm5cZK5gLRFZQv2vZLV5u2C+GMsfos2fc6XKurXh/mscnxjWV8uNXjsmnkLdHwjtgGDj6FlN5/l3uTXsn54uv/0pD84dBAHbE7UJ66p8NcS7pve1EWnwZkEQrp4ebL4xwSc7AYv7BawvDb6xEJf+S8mKWh5yV0Fm7jb0TVvmns4USLUt76R920GhgfQENYm9RJF5SXGpyLAGywYIVgexSW8G+nlkkEzcHHGhGXShj1LUKxRdwXYMgxr7RzI2pPLnW4bREBUUYH9QyjpdAMA0YuR6y3vXzOuSMcBwFbWWROVK8rjj2vR5PTANeRpIQtslIRgp9e4T92v53
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:53:01.6344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c9d6e9-e0a3-4513-ee7e-08dea5038dea
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8707
X-Rspamd-Queue-Id: 3249B4817F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10170-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]

Relocate the ring management functions such as push, pop, and reset
from k3-udma.c to k3-udma-common.c file. These operations are
common across multiple K3 UDMA variants and will be reused by
future implementations like K3 UDMA v2.

No functional changes intended.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma-common.c | 103 ++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-udma.c        | 100 -------------------------------
 drivers/dma/ti/k3-udma.h        |   4 ++
 3 files changed, 107 insertions(+), 100 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
index 9cb35759c70bb..4dcf986f84d87 100644
--- a/drivers/dma/ti/k3-udma-common.c
+++ b/drivers/dma/ti/k3-udma-common.c
@@ -1239,5 +1239,108 @@ void udma_desc_pre_callback(struct virt_dma_chan *vc,
 }
 EXPORT_SYMBOL_GPL(udma_desc_pre_callback);
 
+int udma_push_to_ring(struct udma_chan *uc, int idx)
+{
+	struct udma_desc *d = uc->desc;
+	struct k3_ring *ring = NULL;
+	dma_addr_t paddr;
+
+	switch (uc->config.dir) {
+	case DMA_DEV_TO_MEM:
+		ring = uc->rflow->fd_ring;
+		break;
+	case DMA_MEM_TO_DEV:
+	case DMA_MEM_TO_MEM:
+		ring = uc->tchan->t_ring;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* RX flush packet: idx == -1 is only passed in case of DEV_TO_MEM */
+	if (idx == -1) {
+		paddr = udma_get_rx_flush_hwdesc_paddr(uc);
+	} else {
+		paddr = udma_curr_cppi5_desc_paddr(d, idx);
+
+		wmb(); /* Ensure that writes are not moved over this point */
+	}
+
+	return k3_ringacc_ring_push(ring, &paddr);
+}
+EXPORT_SYMBOL_GPL(udma_push_to_ring);
+
+int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr)
+{
+	struct k3_ring *ring = NULL;
+	int ret;
+
+	switch (uc->config.dir) {
+	case DMA_DEV_TO_MEM:
+		ring = uc->rflow->r_ring;
+		break;
+	case DMA_MEM_TO_DEV:
+	case DMA_MEM_TO_MEM:
+		ring = uc->tchan->tc_ring;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	ret = k3_ringacc_ring_pop(ring, addr);
+	if (ret)
+		return ret;
+
+	rmb(); /* Ensure that reads are not moved before this point */
+
+	/* Teardown completion */
+	if (cppi5_desc_is_tdcm(*addr))
+		return 0;
+
+	/* Check for flush descriptor */
+	if (udma_desc_is_rx_flush(uc, *addr))
+		return -ENOENT;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(udma_pop_from_ring);
+
+void udma_reset_rings(struct udma_chan *uc)
+{
+	struct k3_ring *ring1 = NULL;
+	struct k3_ring *ring2 = NULL;
+
+	switch (uc->config.dir) {
+	case DMA_DEV_TO_MEM:
+		if (uc->rchan) {
+			ring1 = uc->rflow->fd_ring;
+			ring2 = uc->rflow->r_ring;
+		}
+		break;
+	case DMA_MEM_TO_DEV:
+	case DMA_MEM_TO_MEM:
+		if (uc->tchan) {
+			ring1 = uc->tchan->t_ring;
+			ring2 = uc->tchan->tc_ring;
+		}
+		break;
+	default:
+		break;
+	}
+
+	if (ring1)
+		k3_ringacc_ring_reset_dma(ring1,
+					  k3_ringacc_ring_get_occ(ring1));
+	if (ring2)
+		k3_ringacc_ring_reset(ring2);
+
+	/* make sure we are not leaking memory by stalled descriptor */
+	if (uc->terminated_desc) {
+		udma_desc_free(&uc->terminated_desc->vd);
+		uc->terminated_desc = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(udma_reset_rings);
+
 MODULE_DESCRIPTION("Texas Instruments K3 UDMA Common Library");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 96df0893fa095..5c84741881cae 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -174,106 +174,6 @@ static bool udma_is_chan_paused(struct udma_chan *uc)
 	return false;
 }
 
-static int udma_push_to_ring(struct udma_chan *uc, int idx)
-{
-	struct udma_desc *d = uc->desc;
-	struct k3_ring *ring = NULL;
-	dma_addr_t paddr;
-
-	switch (uc->config.dir) {
-	case DMA_DEV_TO_MEM:
-		ring = uc->rflow->fd_ring;
-		break;
-	case DMA_MEM_TO_DEV:
-	case DMA_MEM_TO_MEM:
-		ring = uc->tchan->t_ring;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/* RX flush packet: idx == -1 is only passed in case of DEV_TO_MEM */
-	if (idx == -1) {
-		paddr = udma_get_rx_flush_hwdesc_paddr(uc);
-	} else {
-		paddr = udma_curr_cppi5_desc_paddr(d, idx);
-
-		wmb(); /* Ensure that writes are not moved over this point */
-	}
-
-	return k3_ringacc_ring_push(ring, &paddr);
-}
-
-static int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr)
-{
-	struct k3_ring *ring = NULL;
-	int ret;
-
-	switch (uc->config.dir) {
-	case DMA_DEV_TO_MEM:
-		ring = uc->rflow->r_ring;
-		break;
-	case DMA_MEM_TO_DEV:
-	case DMA_MEM_TO_MEM:
-		ring = uc->tchan->tc_ring;
-		break;
-	default:
-		return -ENOENT;
-	}
-
-	ret = k3_ringacc_ring_pop(ring, addr);
-	if (ret)
-		return ret;
-
-	rmb(); /* Ensure that reads are not moved before this point */
-
-	/* Teardown completion */
-	if (cppi5_desc_is_tdcm(*addr))
-		return 0;
-
-	/* Check for flush descriptor */
-	if (udma_desc_is_rx_flush(uc, *addr))
-		return -ENOENT;
-
-	return 0;
-}
-
-static void udma_reset_rings(struct udma_chan *uc)
-{
-	struct k3_ring *ring1 = NULL;
-	struct k3_ring *ring2 = NULL;
-
-	switch (uc->config.dir) {
-	case DMA_DEV_TO_MEM:
-		if (uc->rchan) {
-			ring1 = uc->rflow->fd_ring;
-			ring2 = uc->rflow->r_ring;
-		}
-		break;
-	case DMA_MEM_TO_DEV:
-	case DMA_MEM_TO_MEM:
-		if (uc->tchan) {
-			ring1 = uc->tchan->t_ring;
-			ring2 = uc->tchan->tc_ring;
-		}
-		break;
-	default:
-		break;
-	}
-
-	if (ring1)
-		k3_ringacc_ring_reset_dma(ring1,
-					  k3_ringacc_ring_get_occ(ring1));
-	if (ring2)
-		k3_ringacc_ring_reset(ring2);
-
-	/* make sure we are not leaking memory by stalled descriptor */
-	if (uc->terminated_desc) {
-		udma_desc_free(&uc->terminated_desc->vd);
-		uc->terminated_desc = NULL;
-	}
-}
-
 static void udma_decrement_byte_counters(struct udma_chan *uc, u32 val)
 {
 	if (uc->desc->dir == DMA_DEV_TO_MEM) {
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 7c807bd9e178b..4c6e5b946d5cf 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -610,6 +610,10 @@ void udma_desc_pre_callback(struct virt_dma_chan *vc,
 			    struct virt_dma_desc *vd,
 			    struct dmaengine_result *result);
 
+int udma_push_to_ring(struct udma_chan *uc, int idx);
+int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr);
+void udma_reset_rings(struct udma_chan *uc);
+
 /* Direct access to UDMA low lever resources for the glue layer */
 int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
 int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
-- 
2.53.0


