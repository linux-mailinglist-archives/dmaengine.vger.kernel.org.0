Return-Path: <dmaengine+bounces-9650-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHJ0NfTcw2lwuQQAu9opvQ
	(envelope-from <dmaengine+bounces-9650-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 14:02:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 306313255AE
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 14:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B63C031003D0
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 12:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648233D890A;
	Wed, 25 Mar 2026 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="URIJyzwb"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAA93D6479;
	Wed, 25 Mar 2026 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442250; cv=fail; b=DJs3GGRpU+V7qzRFsD5W4hwJWCYFJcMD/sBFjbiwhPgFgdxSiyHy1de1+LI1R6r7eGHelt7fboq83Gv2R/x7WHj1slSozc4N3+CL/I5h91zxT5UKBt3bMOJwW/G1wb8+KB6cRdsz1bWV8cXRMZJ803U1oMdvUCffjaBFy3g5jy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442250; c=relaxed/simple;
	bh=bP969poS//3XnmZ/QjP+eCAjGQPcmuBfN4DhgoK1aHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrKhQcnrnz8tV92qJXGrLib0DPSlHY3gZP+qanVcpvIJ3uCldsaYZjOg+qyMMJXA68wqeP4NixOqt29f6mUxJoqw1c2ZRsTvQmRpJTKsBheWiaR/M70dVodR2GAg9AyuX+AiWq/ViuMI6JmKsZB/PNS5sK2Y/u6lb/giMyH+ev8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=URIJyzwb; arc=fail smtp.client-ip=52.101.52.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=no90UM1H4Kqbl2NaLBcsFjUP/KWrUUg27x5HZRp7JXb0MCxeDrkfwPgl6rm06xwcmMWq2zATroTVMWYXWNLR4JQX0MZN4pUbudEOWrzrbYPXY/8aj94qlOZ3J8LzhK51KQIUfd0LzznizzaavTq50X/ViIlBhSvqNAj1iQYxurfM58dP0cLNlHjKEMz1MxNDmP4DEYOTD7dJF3vhIlNEIrO20QgxMu2Xz4yzScNOcWc5vaZ4ID4inV5D5yfKSMUCJsYV+A30L5Trk75M5ErD5wMGLebZKagKlVKr0CSd279OEL+VaJWXbaue/GDNQUBZqJ2G3UtsCLt6zyd6OEEfhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vu1AUID/ldOMuoztObRz8yFB0/0ULQ723MqhzYuYpmE=;
 b=MnOY1fnKkXVut140GA0aL3jDNheuxm9Pp47bmnBm4vv380LJDhjyiP02KjzIyPCIGQuYmV42eCGMJgIrFINhjMhalzyUOMI8dfqQ8Ud/3hN7AHShPV4n/D0KzRNC3ZNt4fQMGfmZ5BR1c1He81N/TjiFD69fjuJkMnsRFIL+eUDnoEJLR+80au7A2qqgZfVxHqIHhuXwbMATufDKBY/FfZVos+HiHrJZL38d0Ivuun83nfsgF+l2tGDJJaQFZJWXM5jjn4jWngzn3dRBFFoMXp2lbh9EkHKB/TmcXXHLuzVDGd+OTVAdq3REzfpRoYYOjFgcR7/YDkIhTkjaiAlOBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vu1AUID/ldOMuoztObRz8yFB0/0ULQ723MqhzYuYpmE=;
 b=URIJyzwbwFz47S4/fq3iCacN+zR0Sa4gv4I5XB9Abooj7wmFFoFw2j9q8E82+cK8hZnQB3JitT860PiixNvxX3mjophTTVVRUjn4AKdf1VjfC5cNsjJbhEzXfhR++V/6N9waSlnGM4EN5y3BQAw0Cf6TxpyuAA30RbXSKXkOhhU=
Received: from PH8P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::26)
 by SAWPR10MB997789.namprd10.prod.outlook.com (2603:10b6:806:4e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 12:37:25 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::a0) by PH8P223CA0030.outlook.office365.com
 (2603:10b6:510:2db::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 12:37:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 12:37:23 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 07:37:19 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 07:37:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Mar 2026 07:37:19 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62PCakEa270453;
	Wed, 25 Mar 2026 07:37:14 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <Frank.Li@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <nm@ti.com>, <ssantosh@kernel.org>,
	<horms@kernel.org>, <c-vankar@ti.com>, <mwalle@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [RFC PATCH 5/6] net: ethernet: ti: am65-cpsw-nuss: Recycle TX and RX CPPI Descriptors
Date: Wed, 25 Mar 2026 18:08:41 +0530
Message-ID: <20260325123850.638748-6-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SAWPR10MB997789:EE_
X-MS-Office365-Filtering-Correlation-Id: b2cafe92-40f8-4234-d120-08de8a6b43cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|82310400026|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	rrrBVNPXjVPE+uMxypDR2BtTuver7Y7XrfT6EiJ0QK12yHFGS/jYus8hB0+gCHu6WVKR3PRdDUFfQuoWEdZA3qMiNn9i19imTNsMmeuOCIHnezIJHOfBkr9G9azEVR+bIrybfi6ykyfkSiej/sF99kpRLwT3Qbp4QUcrdWDlw6+F6v+xhh6gV0M7rJ6T9jPmf/bChR7C5JrLeudobyaJZHD61LR1+Mi+8ln0zNy8f1/Cmbd/Bx04Q5uHQm/Mnj/83tDY95WTkEURUMx4ua4iHEZVEVMee2AgxUeLJv6/G+hpcEGkew0qOrI6sy/YRuf79oV1fTX5Db/pdB8P0MI7l+ijcQfQ/onjzzr+Iq+QeUZrULsfPFY867MaAxmewWpyGrm9GlX6bhuz3bwg8PydwI31vuNVgEB/Rj1CwntUl/4D/X18mpB9wSSJ8redgDTtyGS6LFBHEdJP2CjLN5vmHcyic6s1Hq18I5ichSCUgIFM+pOxmwNGFawf+lqg3Hu/fUWeO9CSeUJ2UBZC+3R0DEV9ttoAS9Arr4xcgznE2PwKda5iyDBH9mgOjSf7nJVD0oej3IctD1/vjJyhS9FW3Att+THzE5VrKRr6oTSaDK7DV8Ug5pU5JJI+UCiGPKw0fXulEGSZi1jVkIShoPHJ9mXUaBSWboUEGlyPVOjl6wgUAb2U1V86GwibTcp9dkejIeoXYzmRB/2mXUHDJbUfFD/+pSkarcLlqYulIikt7XqVdh8mriOLQJpHTKnS8RN/5PaEPe/FPt4PcgfC6MJJCpxxyX0MWMcr9nrtRNmHBrgtRqFKFC6MzwykZRV8ZL9X
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(82310400026)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wCU+KOi+ipkgtMgcpMYp3hdaEhlS6Z2hc4UA94usTtUDnPSWEyOu38qH5tg2v5YsdDa+qy7skPwtxiuV56cQ0Yg6WxRY0kD3YQOzo7DPD+tE5DWiUwnKT/ly9oWD7SwTjWulHS0W/V/J+pZqicNIFKF1gkSaoPrTQHRWqV8GuEMMZJ5oin7gX4TIk0bH/c6fnzAHlEaiXi9gPmfAG4Ui2lwmpF4BXOip3NY8TGMZmxVOg6vGPOC1Aw6Rv4rT/ovLdW027BOr3KgBXVqTmdNYN5RVYnTdiZ7ek+tC6MRiSOmpquhaAlH2rCjj1ljcHHoQrInHIB0FO3NdmbYWVrXIJeAPgt75tINuw1fQETBT/c4WDCXDzs/uShddP/QNTfz5+l27z+MyyT2UIFkewm2TU9J53Q9joglyD8njLxgaKGiJHw3B6ZrcoVIqFTRlU7Ej
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:37:23.6191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cafe92-40f8-4234-d120-08de8a6b43cf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR10MB997789
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,ti.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9650-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:dkim,ti.com:email,ti.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 306313255AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The existing implementation allocates the CPPI Descriptors from the
Descriptor Pool of the TX and RX Channels on demand and returns them to
the Pool on completion. Recycle descriptors to speed up the transmit and
receive paths. Use a Cyclic Queue (Ring) to hold the TX and RX Descriptors
for the respective TX Channel and RX Flow and utilize atomic operations for
guarding against concurrent modification.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 237 ++++++++++++++++++++---
 drivers/net/ethernet/ti/am65-cpsw-nuss.h |  19 ++
 2 files changed, 233 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 6df6cb52d952..fc165579a479 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -145,9 +145,6 @@
 	 AM65_CPSW_PN_TS_CTL_RX_ANX_F_EN)
 
 #define AM65_CPSW_ALE_AGEOUT_DEFAULT	30
-/* Number of TX/RX descriptors per channel/flow */
-#define AM65_CPSW_MAX_TX_DESC	500
-#define AM65_CPSW_MAX_RX_DESC	500
 
 #define AM65_CPSW_NAV_PS_DATA_SIZE 16
 #define AM65_CPSW_NAV_SW_DATA_SIZE 16
@@ -374,6 +371,122 @@ static void am65_cpsw_slave_set_promisc(struct am65_cpsw_port *port,
 	}
 }
 
+static size_t am65_cpsw_nuss_num_free_tx_desc(struct am65_cpsw_tx_chn *tx_chn)
+{
+	struct am65_cpsw_tx_ring *tx_ring = &tx_chn->tx_ring;
+	int head_idx, tail_idx, num_free;
+
+	/* Atomically read both head and tail indices */
+	head_idx = atomic_read(&tx_ring->tx_desc_ring_head_idx);
+	tail_idx = atomic_read(&tx_ring->tx_desc_ring_tail_idx);
+
+	/* Calculate number of available descriptors in circular queue */
+	num_free = (tail_idx - head_idx + (AM65_CPSW_MAX_TX_DESC + 1)) %
+		   (AM65_CPSW_MAX_TX_DESC + 1);
+
+	return num_free;
+}
+
+static void am65_cpsw_nuss_put_tx_desc(struct am65_cpsw_tx_chn *tx_chn,
+				       struct cppi5_host_desc_t *desc)
+{
+	struct am65_cpsw_tx_ring *tx_ring = &tx_chn->tx_ring;
+	int tail_idx, new_tail_idx;
+
+	/* Atomically get current tail index and calculate new wrapped index */
+	do {
+		tail_idx = atomic_read(&tx_ring->tx_desc_ring_tail_idx);
+		new_tail_idx = tail_idx + 1;
+		if (new_tail_idx > AM65_CPSW_MAX_TX_DESC)
+			new_tail_idx = 0;
+	} while (atomic_cmpxchg(&tx_ring->tx_desc_ring_tail_idx,
+				tail_idx, new_tail_idx) != tail_idx);
+
+	/* Store the descriptor at the tail position */
+	tx_ring->tx_descs[tail_idx] = desc;
+}
+
+static void am65_cpsw_nuss_put_rx_desc(struct am65_cpsw_rx_flow *flow,
+				       struct cppi5_host_desc_t *desc)
+{
+	struct am65_cpsw_rx_ring *rx_ring = &flow->rx_ring;
+	int tail_idx, new_tail_idx;
+
+	/* Atomically get current tail index and calculate new wrapped index */
+	do {
+		tail_idx = atomic_read(&rx_ring->rx_desc_ring_tail_idx);
+		new_tail_idx = tail_idx + 1;
+		if (new_tail_idx > AM65_CPSW_MAX_RX_DESC)
+			new_tail_idx = 0;
+	} while (atomic_cmpxchg(&rx_ring->rx_desc_ring_tail_idx,
+				tail_idx, new_tail_idx) != tail_idx);
+
+	/* Store the descriptor at the tail position */
+	rx_ring->rx_descs[tail_idx] = desc;
+}
+
+static void *am65_cpsw_nuss_get_tx_desc(struct am65_cpsw_tx_chn *tx_chn)
+{
+	struct am65_cpsw_tx_ring *tx_ring = &tx_chn->tx_ring;
+	int head_idx, tail_idx, new_head_idx;
+
+	/* Atomically get current head index and check if queue is empty */
+	do {
+		head_idx = atomic_read(&tx_ring->tx_desc_ring_head_idx);
+		tail_idx = atomic_read(&tx_ring->tx_desc_ring_tail_idx);
+
+		/* Queue is empty when head == tail */
+		if (head_idx == tail_idx)
+			return NULL;
+
+		/* Calculate new head with wraparound */
+		new_head_idx = head_idx + 1;
+		if (new_head_idx > AM65_CPSW_MAX_TX_DESC)
+			new_head_idx = 0;
+
+	} while (atomic_cmpxchg(&tx_ring->tx_desc_ring_head_idx,
+				head_idx, new_head_idx) != head_idx);
+
+	return tx_ring->tx_descs[head_idx];
+}
+
+static void *am65_cpsw_nuss_get_rx_desc(struct am65_cpsw_rx_flow *flow)
+{
+	struct am65_cpsw_rx_ring *rx_ring = &flow->rx_ring;
+	int head_idx, tail_idx, new_head_idx;
+
+	/* Atomically get current head index and check if queue is empty */
+	do {
+		head_idx = atomic_read(&rx_ring->rx_desc_ring_head_idx);
+		tail_idx = atomic_read(&rx_ring->rx_desc_ring_tail_idx);
+
+		/* Queue is empty when head == tail */
+		if (head_idx == tail_idx)
+			return NULL;
+
+		/* Calculate new head with wraparound */
+		new_head_idx = head_idx + 1;
+		if (new_head_idx > AM65_CPSW_MAX_RX_DESC)
+			new_head_idx = 0;
+
+	} while (atomic_cmpxchg(&rx_ring->rx_desc_ring_head_idx,
+				head_idx, new_head_idx) != head_idx);
+
+	return rx_ring->rx_descs[head_idx];
+}
+
+static inline int am65_cpsw_nuss_tx_descs_available(struct am65_cpsw_tx_chn *tx_chn)
+{
+	struct am65_cpsw_tx_ring *tx_ring = &tx_chn->tx_ring;
+	int head_idx, tail_idx;
+
+	head_idx = atomic_read(&tx_ring->tx_desc_ring_head_idx);
+	tail_idx = atomic_read(&tx_ring->tx_desc_ring_tail_idx);
+
+	return (tail_idx - head_idx + (AM65_CPSW_MAX_TX_DESC + 1)) %
+	       (AM65_CPSW_MAX_TX_DESC + 1);
+}
+
 static void am65_cpsw_nuss_ndo_slave_set_rx_mode(struct net_device *ndev)
 {
 	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
@@ -423,7 +536,7 @@ static void am65_cpsw_nuss_ndo_host_tx_timeout(struct net_device *ndev,
 		   netif_tx_queue_stopped(netif_txq),
 		   jiffies_to_msecs(jiffies - trans_start),
 		   netdev_queue_dql_avail(netif_txq),
-		   k3_cppi_desc_pool_avail(tx_chn->desc_pool));
+		   am65_cpsw_nuss_num_free_tx_desc(tx_chn));
 
 	if (netif_tx_queue_stopped(netif_txq)) {
 		/* try recover if stopped by us */
@@ -442,7 +555,7 @@ static int am65_cpsw_nuss_rx_push(struct am65_cpsw_common *common,
 	dma_addr_t desc_dma;
 	dma_addr_t buf_dma;
 
-	desc_rx = k3_cppi_desc_pool_alloc(rx_chn->desc_pool);
+	desc_rx = am65_cpsw_nuss_get_rx_desc(&rx_chn->flows[flow_idx]);
 	if (!desc_rx) {
 		dev_err(dev, "Failed to allocate RXFDQ descriptor\n");
 		return -ENOMEM;
@@ -453,7 +566,7 @@ static int am65_cpsw_nuss_rx_push(struct am65_cpsw_common *common,
 				 page_address(page) + AM65_CPSW_HEADROOM,
 				 AM65_CPSW_MAX_PACKET_SIZE, DMA_FROM_DEVICE);
 	if (unlikely(dma_mapping_error(rx_chn->dma_dev, buf_dma))) {
-		k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
+		am65_cpsw_nuss_put_rx_desc(&rx_chn->flows[flow_idx], desc_rx);
 		dev_err(dev, "Failed to map rx buffer\n");
 		return -EINVAL;
 	}
@@ -508,6 +621,7 @@ static void am65_cpsw_nuss_tx_cleanup(void *data, dma_addr_t desc_dma);
 static void am65_cpsw_destroy_rxq(struct am65_cpsw_common *common, int id)
 {
 	struct am65_cpsw_rx_chn *rx_chn = &common->rx_chns;
+	struct cppi5_host_desc_t *rx_desc;
 	struct am65_cpsw_rx_flow *flow;
 	struct xdp_rxq_info *rxq;
 	int port;
@@ -515,6 +629,12 @@ static void am65_cpsw_destroy_rxq(struct am65_cpsw_common *common, int id)
 	flow = &rx_chn->flows[id];
 	napi_disable(&flow->napi_rx);
 	hrtimer_cancel(&flow->rx_hrtimer);
+	/* return descriptors to pool */
+	rx_desc = am65_cpsw_nuss_get_rx_desc(flow);
+	while (rx_desc) {
+		k3_cppi_desc_pool_free(rx_chn->desc_pool, rx_desc);
+		rx_desc = am65_cpsw_nuss_get_rx_desc(flow);
+	}
 	k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, id, rx_chn,
 				  am65_cpsw_nuss_rx_cleanup);
 
@@ -603,7 +723,12 @@ static int am65_cpsw_create_rxq(struct am65_cpsw_common *common, int id)
 			goto err;
 	}
 
+	/* Preallocate all RX Descriptors */
+	atomic_set(&flow->rx_ring.rx_desc_ring_head_idx, 0);
+	atomic_set(&flow->rx_ring.rx_desc_ring_tail_idx, AM65_CPSW_MAX_RX_DESC);
+
 	for (i = 0; i < AM65_CPSW_MAX_RX_DESC; i++) {
+		flow->rx_ring.rx_descs[i] = k3_cppi_desc_pool_alloc(rx_chn->desc_pool);
 		page = page_pool_dev_alloc_pages(flow->page_pool);
 		if (!page) {
 			dev_err(common->dev, "cannot allocate page in flow %d\n",
@@ -661,9 +786,16 @@ static int am65_cpsw_create_rxqs(struct am65_cpsw_common *common)
 static void am65_cpsw_destroy_txq(struct am65_cpsw_common *common, int id)
 {
 	struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[id];
+	struct cppi5_host_desc_t *tx_desc;
 
 	napi_disable(&tx_chn->napi_tx);
 	hrtimer_cancel(&tx_chn->tx_hrtimer);
+	/* return descriptors to pool */
+	tx_desc = am65_cpsw_nuss_get_tx_desc(tx_chn);
+	while (tx_desc) {
+		k3_cppi_desc_pool_free(tx_chn->desc_pool, tx_desc);
+		tx_desc = am65_cpsw_nuss_get_tx_desc(tx_chn);
+	}
 	k3_udma_glue_reset_tx_chn(tx_chn->tx_chn, tx_chn,
 				  am65_cpsw_nuss_tx_cleanup);
 	k3_udma_glue_disable_tx_chn(tx_chn->tx_chn);
@@ -695,7 +827,13 @@ static void am65_cpsw_destroy_txqs(struct am65_cpsw_common *common)
 static int am65_cpsw_create_txq(struct am65_cpsw_common *common, int id)
 {
 	struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[id];
-	int ret;
+	int ret, i;
+
+	/* Preallocate all TX Descriptors */
+	atomic_set(&tx_chn->tx_ring.tx_desc_ring_head_idx, 0);
+	atomic_set(&tx_chn->tx_ring.tx_desc_ring_tail_idx, AM65_CPSW_MAX_TX_DESC);
+	for (i = 0; i < AM65_CPSW_MAX_TX_DESC; i++)
+		tx_chn->tx_ring.tx_descs[i] = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
 
 	ret = k3_udma_glue_enable_tx_chn(tx_chn->tx_chn);
 	if (ret)
@@ -1103,7 +1241,7 @@ static int am65_cpsw_xdp_tx_frame(struct net_device *ndev,
 	u32 pkt_len = xdpf->len;
 	int ret;
 
-	host_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
+	host_desc = am65_cpsw_nuss_get_tx_desc(tx_chn);
 	if (unlikely(!host_desc)) {
 		ndev->stats.tx_dropped++;
 		return AM65_CPSW_XDP_CONSUMED;	/* drop */
@@ -1161,7 +1299,7 @@ static int am65_cpsw_xdp_tx_frame(struct net_device *ndev,
 	k3_udma_glue_tx_cppi5_to_dma_addr(tx_chn->tx_chn, &dma_buf);
 	dma_unmap_single(tx_chn->dma_dev, dma_buf, pkt_len, DMA_TO_DEVICE);
 pool_free:
-	k3_cppi_desc_pool_free(tx_chn->desc_pool, host_desc);
+	am65_cpsw_nuss_put_tx_desc(tx_chn, host_desc);
 	return ret;
 }
 
@@ -1320,7 +1458,7 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 	dev_dbg(dev, "%s rx csum_info:%#x\n", __func__, csum_info);
 
 	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE);
-	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
+	am65_cpsw_nuss_put_rx_desc(flow, desc_rx);
 
 	if (port->xdp_prog) {
 		xdp_init_buff(&xdp, PAGE_SIZE, &port->xdp_rxq[flow->id]);
@@ -1444,13 +1582,48 @@ static void am65_cpsw_nuss_tx_wake(struct am65_cpsw_tx_chn *tx_chn, struct net_d
 		 */
 		__netif_tx_lock(netif_txq, smp_processor_id());
 		if (netif_running(ndev) &&
-		    (k3_cppi_desc_pool_avail(tx_chn->desc_pool) >= MAX_SKB_FRAGS))
+		    (am65_cpsw_nuss_num_free_tx_desc(tx_chn) >= MAX_SKB_FRAGS))
 			netif_tx_wake_queue(netif_txq);
 
 		__netif_tx_unlock(netif_txq);
 	}
 }
 
+static inline void am65_cpsw_nuss_xmit_recycle(struct am65_cpsw_tx_chn *tx_chn,
+					       struct cppi5_host_desc_t *desc)
+{
+	struct cppi5_host_desc_t *first_desc, *next_desc;
+	dma_addr_t buf_dma, next_desc_dma;
+	u32 buf_dma_len;
+
+	first_desc = desc;
+	next_desc = first_desc;
+
+	cppi5_hdesc_get_obuf(first_desc, &buf_dma, &buf_dma_len);
+	k3_udma_glue_tx_cppi5_to_dma_addr(tx_chn->tx_chn, &buf_dma);
+
+	dma_unmap_single(tx_chn->dma_dev, buf_dma, buf_dma_len, DMA_TO_DEVICE);
+
+	next_desc_dma = cppi5_hdesc_get_next_hbdesc(first_desc);
+	k3_udma_glue_tx_cppi5_to_dma_addr(tx_chn->tx_chn, &next_desc_dma);
+	while (next_desc_dma) {
+		next_desc = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool,
+						       next_desc_dma);
+		cppi5_hdesc_get_obuf(next_desc, &buf_dma, &buf_dma_len);
+		k3_udma_glue_tx_cppi5_to_dma_addr(tx_chn->tx_chn, &buf_dma);
+
+		dma_unmap_page(tx_chn->dma_dev, buf_dma, buf_dma_len,
+			       DMA_TO_DEVICE);
+
+		next_desc_dma = cppi5_hdesc_get_next_hbdesc(next_desc);
+		k3_udma_glue_tx_cppi5_to_dma_addr(tx_chn->tx_chn, &next_desc_dma);
+
+		am65_cpsw_nuss_put_tx_desc(tx_chn, next_desc);
+	}
+
+	am65_cpsw_nuss_put_tx_desc(tx_chn, first_desc);
+}
+
 static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
 					   int chn, unsigned int budget, bool *tdown)
 {
@@ -1509,7 +1682,7 @@ static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
 
 		total_bytes += pkt_len;
 		num_tx++;
-		am65_cpsw_nuss_xmit_free(tx_chn, desc_tx);
+		am65_cpsw_nuss_xmit_recycle(tx_chn, desc_tx);
 		dev_sw_netstats_tx_add(ndev, 1, pkt_len);
 		if (!single_port) {
 			/* as packets from multi ports can be interleaved
@@ -1624,7 +1797,7 @@ static netdev_tx_t am65_cpsw_nuss_ndo_slave_xmit(struct sk_buff *skb,
 		goto err_free_skb;
 	}
 
-	first_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
+	first_desc = am65_cpsw_nuss_get_tx_desc(tx_chn);
 	if (!first_desc) {
 		dev_dbg(dev, "Failed to allocate descriptor\n");
 		dma_unmap_single(tx_chn->dma_dev, buf_dma, pkt_len,
@@ -1672,7 +1845,7 @@ static netdev_tx_t am65_cpsw_nuss_ndo_slave_xmit(struct sk_buff *skb,
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 		u32 frag_size = skb_frag_size(frag);
 
-		next_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
+		next_desc = am65_cpsw_nuss_get_tx_desc(tx_chn);
 		if (!next_desc) {
 			dev_err(dev, "Failed to allocate descriptor\n");
 			goto busy_free_descs;
@@ -1682,7 +1855,7 @@ static netdev_tx_t am65_cpsw_nuss_ndo_slave_xmit(struct sk_buff *skb,
 					   DMA_TO_DEVICE);
 		if (unlikely(dma_mapping_error(tx_chn->dma_dev, buf_dma))) {
 			dev_err(dev, "Failed to map tx skb page\n");
-			k3_cppi_desc_pool_free(tx_chn->desc_pool, next_desc);
+			am65_cpsw_nuss_put_tx_desc(tx_chn, next_desc);
 			ndev->stats.tx_errors++;
 			goto err_free_descs;
 		}
@@ -1725,14 +1898,14 @@ static netdev_tx_t am65_cpsw_nuss_ndo_slave_xmit(struct sk_buff *skb,
 		goto err_free_descs;
 	}
 
-	if (k3_cppi_desc_pool_avail(tx_chn->desc_pool) < MAX_SKB_FRAGS) {
+	if (am65_cpsw_nuss_num_free_tx_desc(tx_chn) < MAX_SKB_FRAGS) {
 		netif_tx_stop_queue(netif_txq);
 		/* Barrier, so that stop_queue visible to other cpus */
 		smp_mb__after_atomic();
 		dev_dbg(dev, "netif_tx_stop_queue %d\n", q_idx);
 
 		/* re-check for smp */
-		if (k3_cppi_desc_pool_avail(tx_chn->desc_pool) >=
+		if (am65_cpsw_nuss_num_free_tx_desc(tx_chn) >=
 		    MAX_SKB_FRAGS) {
 			netif_tx_wake_queue(netif_txq);
 			dev_dbg(dev, "netif_tx_wake_queue %d\n", q_idx);
@@ -1742,14 +1915,14 @@ static netdev_tx_t am65_cpsw_nuss_ndo_slave_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 
 err_free_descs:
-	am65_cpsw_nuss_xmit_free(tx_chn, first_desc);
+	am65_cpsw_nuss_xmit_recycle(tx_chn, first_desc);
 err_free_skb:
 	ndev->stats.tx_dropped++;
 	dev_kfree_skb_any(skb);
 	return NETDEV_TX_OK;
 
 busy_free_descs:
-	am65_cpsw_nuss_xmit_free(tx_chn, first_desc);
+	am65_cpsw_nuss_xmit_recycle(tx_chn, first_desc);
 busy_stop_q:
 	netif_tx_stop_queue(netif_txq);
 	return NETDEV_TX_BUSY;
@@ -2195,7 +2368,7 @@ static void am65_cpsw_nuss_free_tx_chns(void *data)
 static void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
 {
 	struct device *dev = common->dev;
-	int i;
+	int i, j;
 
 	common->tx_ch_rate_msk = 0;
 	for (i = 0; i < common->tx_ch_num; i++) {
@@ -2205,6 +2378,10 @@ static void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
 			devm_free_irq(dev, tx_chn->irq, tx_chn);
 
 		netif_napi_del(&tx_chn->napi_tx);
+
+		for (j = 0; j < AM65_CPSW_MAX_TX_DESC; j++)
+			k3_cppi_desc_pool_free(tx_chn->desc_pool,
+					       tx_chn->tx_ring.tx_descs[j]);
 	}
 
 	am65_cpsw_nuss_free_tx_chns(common);
@@ -2260,7 +2437,7 @@ static int am65_cpsw_nuss_init_tx_chns(struct am65_cpsw_common *common)
 		.flags = 0
 	};
 	u32 hdesc_size, hdesc_size_out;
-	int i, ret = 0;
+	int i, j, ret = 0;
 
 	hdesc_size = cppi5_hdesc_calc_size(true, AM65_CPSW_NAV_PS_DATA_SIZE,
 					   AM65_CPSW_NAV_SW_DATA_SIZE);
@@ -2329,6 +2506,13 @@ static int am65_cpsw_nuss_init_tx_chns(struct am65_cpsw_common *common)
 	return 0;
 
 err:
+	/* Free descriptors */
+	while (i--) {
+		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
+
+		for (j = 0; j < AM65_CPSW_MAX_TX_DESC; j++)
+			k3_cppi_desc_pool_free(tx_chn->desc_pool, tx_chn->tx_ring.tx_descs[j]);
+	}
 	am65_cpsw_nuss_free_tx_chns(common);
 
 	return ret;
@@ -2353,7 +2537,7 @@ static void am65_cpsw_nuss_remove_rx_chns(struct am65_cpsw_common *common)
 	struct device *dev = common->dev;
 	struct am65_cpsw_rx_chn *rx_chn;
 	struct am65_cpsw_rx_flow *flows;
-	int i;
+	int i, j;
 
 	rx_chn = &common->rx_chns;
 	flows = rx_chn->flows;
@@ -2362,6 +2546,9 @@ static void am65_cpsw_nuss_remove_rx_chns(struct am65_cpsw_common *common)
 		if (!(flows[i].irq < 0))
 			devm_free_irq(dev, flows[i].irq, &flows[i]);
 		netif_napi_del(&flows[i].napi_rx);
+		for (j = 0; j < AM65_CPSW_MAX_RX_DESC; j++)
+			k3_cppi_desc_pool_free(rx_chn->desc_pool,
+					       flows[i].rx_ring.rx_descs[j]);
 	}
 
 	am65_cpsw_nuss_free_rx_chns(common);
@@ -2378,7 +2565,7 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 	struct am65_cpsw_rx_flow *flow;
 	u32 hdesc_size, hdesc_size_out;
 	u32 fdqring_id;
-	int i, ret = 0;
+	int i, j, ret = 0;
 
 	hdesc_size = cppi5_hdesc_calc_size(true, AM65_CPSW_NAV_PS_DATA_SIZE,
 					   AM65_CPSW_NAV_SW_DATA_SIZE);
@@ -2498,10 +2685,14 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 
 err_request_irq:
 	netif_napi_del(&flow->napi_rx);
+	for (j = 0; j < AM65_CPSW_MAX_RX_DESC; j++)
+		k3_cppi_desc_pool_free(rx_chn->desc_pool, flow->rx_ring.rx_descs[j]);
 
 err_flow:
 	for (--i; i >= 0; i--) {
 		flow = &rx_chn->flows[i];
+		for (j = 0; j < AM65_CPSW_MAX_RX_DESC; j++)
+			k3_cppi_desc_pool_free(rx_chn->desc_pool, flow->rx_ring.rx_descs[j]);
 		devm_free_irq(dev, flow->irq, flow);
 		netif_napi_del(&flow->napi_rx);
 	}
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
index 7750448e4746..e64b4cfd6f2c 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
@@ -6,6 +6,7 @@
 #ifndef AM65_CPSW_NUSS_H_
 #define AM65_CPSW_NUSS_H_
 
+#include <linux/dma/ti-cppi5.h>
 #include <linux/if_ether.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -23,6 +24,10 @@ struct am65_cpts;
 
 #define AM65_CPSW_MAX_QUEUES	8	/* both TX & RX */
 
+/* Number of TX/RX descriptors per channel/flow */
+#define AM65_CPSW_MAX_TX_DESC	500
+#define AM65_CPSW_MAX_RX_DESC	500
+
 #define AM65_CPSW_PORT_VLAN_REG_OFFSET	0x014
 
 struct am65_cpsw_slave_data {
@@ -75,6 +80,12 @@ struct am65_cpsw_host {
 	u32				vid_context;
 };
 
+struct am65_cpsw_tx_ring {
+	struct cppi5_host_desc_t *tx_descs[AM65_CPSW_MAX_TX_DESC + 1];
+	atomic_t tx_desc_ring_head_idx; /* Points to dequeuing place for free descriptor */
+	atomic_t tx_desc_ring_tail_idx; /* Points to queuing place for freed descriptor */
+};
+
 struct am65_cpsw_tx_chn {
 	struct device *dma_dev;
 	struct napi_struct napi_tx;
@@ -82,6 +93,7 @@ struct am65_cpsw_tx_chn {
 	struct k3_cppi_desc_pool *desc_pool;
 	struct k3_udma_glue_tx_channel *tx_chn;
 	spinlock_t lock; /* protect TX rings in multi-port mode */
+	struct am65_cpsw_tx_ring tx_ring;
 	struct hrtimer tx_hrtimer;
 	unsigned long tx_pace_timeout;
 	int irq;
@@ -92,12 +104,19 @@ struct am65_cpsw_tx_chn {
 	u32 rate_mbps;
 };
 
+struct am65_cpsw_rx_ring {
+	struct cppi5_host_desc_t *rx_descs[AM65_CPSW_MAX_RX_DESC + 1];
+	atomic_t rx_desc_ring_head_idx; /* Points to dequeuing place for free descriptor */
+	atomic_t rx_desc_ring_tail_idx; /* Points to queuing place for freed descriptor */
+};
+
 struct am65_cpsw_rx_flow {
 	u32 id;
 	struct napi_struct napi_rx;
 	struct am65_cpsw_common	*common;
 	int irq;
 	bool irq_disabled;
+	struct am65_cpsw_rx_ring rx_ring;
 	struct hrtimer rx_hrtimer;
 	unsigned long rx_pace_timeout;
 	struct page_pool *page_pool;
-- 
2.51.1


