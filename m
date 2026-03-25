Return-Path: <dmaengine+bounces-9649-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIuNOzjhw2kgugQAu9opvQ
	(envelope-from <dmaengine+bounces-9649-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 14:20:56 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED173259C9
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 14:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 561E032B8BB8
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 12:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC70E3D88E3;
	Wed, 25 Mar 2026 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k062g8F6"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97583D649F;
	Wed, 25 Mar 2026 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442249; cv=fail; b=TSsTPaoZPqL6JdaB/dJ9gxSfwQuBxw4rPvgyOhfgJ9P0LGtg4pPT/TrQhThSEtLMhkK2rNB34dghxkptaGb5xq8YvQJGg+9HqAyjRXygNjradHMu/zjbhanTSu1+SwCXNAk6AxTeqqjJyTcEint9ArzshmMkHFHqplUvYTy4uuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442249; c=relaxed/simple;
	bh=HiZ+VPLZbfF6l3db/mu1ljsQ5rtoFGCJ5m84Gmx2Gkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCO/FePrgZ+EM3oqBeDlS1dkXsDTu5iejaof4yS+USyXjaCAalMcdC3o+hW0uEdIt/DQrYNLxN3EVl7NvmCuKNzUqjCAd4IpcJvYYSTqVmokfgP8RM0apbLkLj5AaO0xCwpcJQhbwDZqRHOIQomdkQY7g6gKmk2sdBsbDn9u5Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k062g8F6; arc=fail smtp.client-ip=52.101.46.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+ggAytmzduBVbYgfKfKS9jbj2ZQPACOGxqhRcenGs1qGkxuyY8Kr1Tql4pLroTZgw60i5SiRMjJrC4PiFqdkHb0QjlNKvS9S/x/MiYAoHaCnwy+qDdcNP7STiUEU43UL45OQE6DQ6fLM6ZoP/hwJ/H+SQIeE+hlH3TojQ/i3jgr3xqGW5GTP/IbkdF2bgW9JOueAriLmv4/00gimp4FJKQorG1FB3GVQjmB+HXuICl+tztOC++cPk4GDsDg15HCmaM4lkUDAMGGUiaBMLYunIUTIfD+P8CYs0yCn65xFpgt+qZsP/HScy3mPnczmx7voqIJ0jxTmbEywn1JH6DBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZzNn1Rt+54UzI+EauEKrW3CADixDP6XwfRrx2HLjnc=;
 b=tjqE4kdfdl4sXTVOa/SBwNscRgNMYpH2SAwuHVWJblwY6KNVa5bZY1cmE9urEO3NK+8568l7ZZvsKCndbQocpC3oMKxmE5blwd7p0ZyS83ke47D8W0ore6NAwclvORxygWkIcGQ76AqX40dRTsF9mhN9d2sXT56Bb42eaV2WrdzKXvZRjPBUirA2YOMNi561k/9uZbT9U1BQRd3n6WNqBMCig3d3bnAY2GBgI8iIu9SXB1AFfcX7oYZ9L5E+SCAbBAb+l8GXWAj0LpItf/1ydt7/2nl6L8wbTCU20Jp1oDOArCF4Ne/5+ZfzgTvFDK7WNK79qJYsc5QCtrm4lxZdRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZzNn1Rt+54UzI+EauEKrW3CADixDP6XwfRrx2HLjnc=;
 b=k062g8F6q41T/S8QCd6hevX/SELbMaeLGQImgfvU9R7g4WNXG+CkAzG1jhIv+JoxzkchtQRqo+FfDt45T9NrIRj2W1VDHEnjwcHmIQg95JYhdS7lakd+TPCX/TN5AQulHER1ErwRIrpimc1WhjQRRWrM06DD8sJn13D2EAer1VE=
Received: from MW4PR02CA0002.namprd02.prod.outlook.com (2603:10b6:303:16d::10)
 by CO6PR10MB5603.namprd10.prod.outlook.com (2603:10b6:303:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 12:37:26 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:303:16d:cafe::d4) by MW4PR02CA0002.outlook.office365.com
 (2603:10b6:303:16d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 12:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 12:37:25 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 07:37:24 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 07:37:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Mar 2026 07:37:24 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62PCakEb270453;
	Wed, 25 Mar 2026 07:37:19 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <Frank.Li@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <nm@ti.com>, <ssantosh@kernel.org>,
	<horms@kernel.org>, <c-vankar@ti.com>, <mwalle@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [RFC PATCH 6/6] net: ethernet: ti: am65-cpsw-nuss: Enable batch processing for TX / TX CMPL
Date: Wed, 25 Mar 2026 18:08:42 +0530
Message-ID: <20260325123850.638748-7-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|CO6PR10MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 040d6383-f2e0-4f78-b1d3-08de8a6b44f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	d9fMUbi7ZQC5zC+YtGblL4Bi02iSCexa3gCEzOherkr77QJesiElNsxW9v4X2V+vi/T/rIxOyfabAB4nwO7rgOb0hSlnEMkdtyuLH7YXCtOiaQ2Cu4tThIXv8Lbh3BvMTztt0KbPJbSbPRLLlG8zgNmgfMpdD+FexphQxvvCr2MPbOpo1Rd9QB+kjm/74IWfwOvKPI28fD4fWWZV0HDcO584PINicu04vmnbf45+39h6pglxp0tE7edoScxZeYQQ5z1HQKzpUwI4DZ/Eb1k2plEZxpU/U/hCZGd7UtWkzJYPf+igmWkdACJeEcgZRhj3nydcbjwD/RpgZDHkAH8Sjy/hXJAXYaAl3SvP0v8qMXuwPwICANjZMcGujfCJAcPlcpe0fFdkRUl1r2svY5JGUKmg0aQW5L3/xcSgZoT0/e+r3XVPEHpOL34pSsUt3NA6zr7l5UXoctFhWC8qi2nXqMuU+MpZW5XSaH2p8Y2q0/sPayytsMlYrYFh/pxCOaTkuVVE0hlWA7F3v+kFfBdnrvz1vvDDPPcF/tsLZFCGqhi/xOv5O3B4aXuEUCcpkXcSu7Q7WpdNclQYmA+xTu1/ZERloE3UEYeLyeioi5z61yfiLP6TVPBpUT0SUkXEtgN70ho3zWznMPl7sBHSZVhQ5hRVEnu+JWN+KD9J5XVNayJI/X3S61Wa1ztV4JRNK81mEZvKjjfZYnLaHX7FscVWIYecw1t12H0VceaDSx/iLFLeVWm8VkxHtQHCqx7aUAi2g3v1vlhOfyp9fkvrXeKrM4+qjN907PA31h9rDolJ8xWwYROL/P6aAXvA0jTRZlNs
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l1RQ7ChBnPG74Uq8TdIFEIaJBhAIiP5+FAGl1B2Jw1vod6CbxNUlMbeux1a/0HmlkJl9SlT2AP6lal5vpFLwKhAP3Ueyk4KdiZD33xaCAPBidm2oJE0lzfV1XyyoD+f6s2Ou7gWQJOuAf1fqw+yWqvf33jbyGyr+7JWU1D5QfYBbcQ82cenq0hUzToGuK1lgKrWxXQpv6tRS+16Yi+0AT2uHmmSXJbnBCBM1B8dHSSBFO/yqYxW8fYIz6x3bnfmhnFw0znzuH8HvJiZy2aMgiSGafepoXHZjTjp45FM0lSpm4w6myR7yi15tdU9jy87RmllVE0Fk9bns1/7Gf9k38a0duw0cl+ml2geF7s5AZitf87sX4iJklK4j4ev4iGjSFTvrx1c+LG81le8MMyqHC6HcXqQkbjov4TkOELG+A8UKJ90otF326X8df7bRoN7f
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:37:25.4795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 040d6383-f2e0-4f78-b1d3-08de8a6b44f3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5603
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
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,ti.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9649-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:dkim,ti.com:email,ti.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6ED173259C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable batch processing on the transmit and transmit completion paths by
submitting a batch of packet descriptors on transmit and similarly by
dequeueing a batch of packet descriptors on transmit completion.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 201 +++++++++++++++++++----
 drivers/net/ethernet/ti/am65-cpsw-nuss.h |  12 ++
 2 files changed, 178 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index fc165579a479..2b354af14cb7 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1624,14 +1624,14 @@ static inline void am65_cpsw_nuss_xmit_recycle(struct am65_cpsw_tx_chn *tx_chn,
 	am65_cpsw_nuss_put_tx_desc(tx_chn, first_desc);
 }
 
-static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
-					   int chn, unsigned int budget, bool *tdown)
+static int am65_cpsw_nuss_tx_cmpl_free_batch(struct am65_cpsw_common *common, int chn,
+					     u32 batch_size, unsigned int budget,
+					     bool *tdown)
 {
 	bool single_port = AM65_CPSW_IS_CPSW2G(common);
 	enum am65_cpsw_tx_buf_type buf_type;
 	struct am65_cpsw_tx_swdata *swdata;
 	struct cppi5_host_desc_t *desc_tx;
-	struct device *dev = common->dev;
 	struct am65_cpsw_tx_chn *tx_chn;
 	struct netdev_queue *netif_txq;
 	unsigned int total_bytes = 0;
@@ -1640,21 +1640,13 @@ static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
 	unsigned int pkt_len;
 	struct sk_buff *skb;
 	dma_addr_t desc_dma;
-	int res, num_tx = 0;
+	int num_tx = 0, i;
 
 	tx_chn = &common->tx_chns[chn];
 
-	while (true) {
-		if (!single_port)
-			spin_lock(&tx_chn->lock);
-		res = k3_udma_glue_pop_tx_chn(tx_chn->tx_chn, &desc_dma);
-		if (!single_port)
-			spin_unlock(&tx_chn->lock);
-
-		if (res == -ENODATA)
-			break;
-
-		if (cppi5_desc_is_tdcm(desc_dma)) {
+	for (i = 0; i < batch_size; i++) {
+		desc_dma = tx_chn->cmpl_desc_dma_array[i];
+		if (unlikely(cppi5_desc_is_tdcm(desc_dma))) {
 			if (atomic_dec_and_test(&common->tdown_cnt))
 				complete(&common->tdown_complete);
 			*tdown = true;
@@ -1701,7 +1693,34 @@ static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
 		am65_cpsw_nuss_tx_wake(tx_chn, ndev, netif_txq);
 	}
 
-	dev_dbg(dev, "%s:%u pkt:%d\n", __func__, chn, num_tx);
+	return num_tx;
+}
+
+static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
+					   int chn, unsigned int budget, bool *tdown)
+{
+	bool single_port = AM65_CPSW_IS_CPSW2G(common);
+	struct am65_cpsw_tx_chn *tx_chn;
+	u32 batch_size = 0;
+	int res, num_tx;
+
+	tx_chn = &common->tx_chns[chn];
+
+	if (!single_port)
+		spin_lock(&tx_chn->lock);
+
+	res = k3_udma_glue_pop_tx_chn_batch(tx_chn->tx_chn, tx_chn->cmpl_desc_dma_array,
+					    &batch_size, AM65_CPSW_TX_BATCH_SIZE);
+	if (!batch_size) {
+		if (!single_port)
+			spin_unlock(&tx_chn->lock);
+		return 0;
+	}
+
+	num_tx = am65_cpsw_nuss_tx_cmpl_free_batch(common, chn, batch_size, budget, tdown);
+
+	if (!single_port)
+		spin_unlock(&tx_chn->lock);
 
 	return num_tx;
 }
@@ -1760,18 +1779,48 @@ static irqreturn_t am65_cpsw_nuss_tx_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void am65_cpsw_nuss_submit_ndev_batch(struct am65_cpsw_common *common)
+{
+	bool single_port = AM65_CPSW_IS_CPSW2G(common);
+	struct am65_cpsw_tx_desc_batch *tx_desc_batch;
+	struct am65_cpsw_tx_chn *tx_chn;
+	int ret, i;
+
+	/* Submit packets across netdevs across TX Channels */
+	for (i = 0; i < AM65_CPSW_MAX_QUEUES; i++) {
+		if (common->tx_desc_batch[i].tx_batch_idx) {
+			tx_chn = &common->tx_chns[i];
+			tx_desc_batch = &common->tx_desc_batch[i];
+			if (!single_port)
+				spin_lock_bh(&tx_chn->lock);
+			ret = k3_udma_glue_push_tx_chn_batch(tx_chn->tx_chn,
+							     tx_desc_batch->desc_tx_array,
+							     tx_desc_batch->desc_dma_array,
+							     tx_desc_batch->tx_batch_idx);
+			if (!single_port)
+				spin_unlock_bh(&tx_chn->lock);
+			if (ret)
+				dev_err(common->dev, "failed to push %u pkts on queue %d\n",
+					tx_desc_batch->tx_batch_idx, i);
+			tx_desc_batch->tx_batch_idx = 0;
+		}
+	}
+	atomic_set(&common->tx_batch_count, 0);
+}
+
 static netdev_tx_t am65_cpsw_nuss_ndo_slave_xmit(struct sk_buff *skb,
 						 struct net_device *ndev)
 {
 	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
 	struct cppi5_host_desc_t *first_desc, *next_desc, *cur_desc;
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+	struct am65_cpsw_tx_desc_batch *tx_desc_batch;
 	struct am65_cpsw_tx_swdata *swdata;
 	struct device *dev = common->dev;
 	struct am65_cpsw_tx_chn *tx_chn;
 	struct netdev_queue *netif_txq;
 	dma_addr_t desc_dma, buf_dma;
-	int ret, q_idx, i;
+	int q_idx, i;
 	u32 *psdata;
 	u32 pkt_len;
 
@@ -1883,20 +1932,31 @@ static netdev_tx_t am65_cpsw_nuss_ndo_slave_xmit(struct sk_buff *skb,
 
 	cppi5_hdesc_set_pktlen(first_desc, pkt_len);
 	desc_dma = k3_cppi_desc_pool_virt2dma(tx_chn->desc_pool, first_desc);
-	if (AM65_CPSW_IS_CPSW2G(common)) {
-		ret = k3_udma_glue_push_tx_chn(tx_chn->tx_chn, first_desc, desc_dma);
-	} else {
-		spin_lock_bh(&tx_chn->lock);
-		ret = k3_udma_glue_push_tx_chn(tx_chn->tx_chn, first_desc, desc_dma);
-		spin_unlock_bh(&tx_chn->lock);
-	}
-	if (ret) {
-		dev_err(dev, "can't push desc %d\n", ret);
-		/* inform bql */
-		netdev_tx_completed_queue(netif_txq, 1, pkt_len);
-		ndev->stats.tx_errors++;
-		goto err_free_descs;
-	}
+
+	/* Batch processing begins */
+	spin_lock_bh(&common->tx_batch_lock);
+
+	tx_desc_batch = &common->tx_desc_batch[q_idx];
+	tx_desc_batch->desc_tx_array[tx_desc_batch->tx_batch_idx] = first_desc;
+	tx_desc_batch->desc_dma_array[tx_desc_batch->tx_batch_idx] = desc_dma;
+	tx_desc_batch->tx_batch_idx++;
+
+	/* Push the batch across all queues and all netdevs in any of the
+	 * following scenarios:
+	 * 1. If we reach the batch size
+	 * 2. If queue is stopped
+	 * 3. No more packets are expected for ndev
+	 * 4. We do not have sufficient free descriptors for upcoming packets
+	 *    and need to push the batch to reclaim them via completion
+	 */
+	if ((atomic_inc_return(&common->tx_batch_count) == AM65_CPSW_TX_BATCH_SIZE) ||
+	    netif_xmit_stopped(netif_txq) ||
+	    !netdev_xmit_more() ||
+	    (am65_cpsw_nuss_num_free_tx_desc(tx_chn) < MAX_SKB_FRAGS))
+		am65_cpsw_nuss_submit_ndev_batch(common);
+
+	/* Batch processing ends */
+	spin_unlock_bh(&common->tx_batch_lock);
 
 	if (am65_cpsw_nuss_num_free_tx_desc(tx_chn) < MAX_SKB_FRAGS) {
 		netif_tx_stop_queue(netif_txq);
@@ -2121,19 +2181,88 @@ static int am65_cpsw_ndo_xdp_xmit(struct net_device *ndev, int n,
 				  struct xdp_frame **frames, u32 flags)
 {
 	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+	struct am65_cpsw_tx_desc_batch *tx_desc_batch;
+	struct cppi5_host_desc_t *host_desc;
+	struct am65_cpsw_tx_swdata *swdata;
 	struct am65_cpsw_tx_chn *tx_chn;
 	struct netdev_queue *netif_txq;
+	dma_addr_t dma_desc, dma_buf;
 	int cpu = smp_processor_id();
-	int i, nxmit = 0;
+	int i, q_idx, nxmit = 0;
+	struct xdp_frame *xdpf;
+	u32 pkt_len;
 
-	tx_chn = &common->tx_chns[cpu % common->tx_ch_num];
+	q_idx = cpu % common->tx_ch_num;
+	tx_chn = &common->tx_chns[q_idx];
 	netif_txq = netdev_get_tx_queue(ndev, tx_chn->id);
 
 	__netif_tx_lock(netif_txq, cpu);
 	for (i = 0; i < n; i++) {
-		if (am65_cpsw_xdp_tx_frame(ndev, tx_chn, frames[i],
-					   AM65_CPSW_TX_BUF_TYPE_XDP_NDO))
+		host_desc = am65_cpsw_nuss_get_tx_desc(tx_chn);
+		if (unlikely(!host_desc)) {
+			ndev->stats.tx_dropped++;
+			break;
+		}
+
+		xdpf = frames[i];
+		pkt_len = xdpf->len;
+
+		am65_cpsw_nuss_set_buf_type(tx_chn, host_desc, AM65_CPSW_TX_BUF_TYPE_XDP_NDO);
+
+		dma_buf = dma_map_single(tx_chn->dma_dev, xdpf->data,
+					 pkt_len, DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(tx_chn->dma_dev, dma_buf))) {
+			ndev->stats.tx_dropped++;
+			am65_cpsw_nuss_put_tx_desc(tx_chn, host_desc);
 			break;
+		}
+
+		cppi5_hdesc_init(host_desc, CPPI5_INFO0_HDESC_EPIB_PRESENT,
+				 AM65_CPSW_NAV_PS_DATA_SIZE);
+		cppi5_hdesc_set_pkttype(host_desc, AM65_CPSW_CPPI_TX_PKT_TYPE);
+		cppi5_hdesc_set_pktlen(host_desc, pkt_len);
+		cppi5_desc_set_pktids(&host_desc->hdr, 0, AM65_CPSW_CPPI_TX_FLOW_ID);
+		cppi5_desc_set_tags_ids(&host_desc->hdr, 0, port->port_id);
+
+		k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &dma_buf);
+		cppi5_hdesc_attach_buf(host_desc, dma_buf, pkt_len, dma_buf, pkt_len);
+
+		swdata = cppi5_hdesc_get_swdata(host_desc);
+		swdata->ndev = ndev;
+		swdata->xdpf = xdpf;
+
+		/* Report BQL before sending the packet */
+		netif_txq = netdev_get_tx_queue(ndev, tx_chn->id);
+		netdev_tx_sent_queue(netif_txq, pkt_len);
+
+		dma_desc = k3_cppi_desc_pool_virt2dma(tx_chn->desc_pool, host_desc);
+
+		/* Batch processing begins */
+		spin_lock_bh(&common->tx_batch_lock);
+
+		tx_desc_batch = &common->tx_desc_batch[q_idx];
+		tx_desc_batch->desc_tx_array[tx_desc_batch->tx_batch_idx] = host_desc;
+		tx_desc_batch->desc_dma_array[tx_desc_batch->tx_batch_idx] = dma_desc;
+		tx_desc_batch->tx_batch_idx++;
+
+		/* Push the batch across all queues and all netdevs in any of the
+		 * following scenarios:
+		 * 1. If we reach the batch size
+		 * 2. If queue is stopped
+		 * 3. We are at the last XDP frame in the batch
+		 * 4. We do not have sufficient free descriptors for upcoming packets
+		 *    and need to push the batch to reclaim them via completion
+		 */
+		if ((atomic_inc_return(&common->tx_batch_count) == AM65_CPSW_TX_BATCH_SIZE) ||
+		    netif_xmit_stopped(netif_txq) ||
+		    (i == (n - 1)) ||
+		    (am65_cpsw_nuss_num_free_tx_desc(tx_chn) < MAX_SKB_FRAGS))
+			am65_cpsw_nuss_submit_ndev_batch(common);
+
+		/* Batch processing ends */
+		spin_unlock_bh(&common->tx_batch_lock);
+
 		nxmit++;
 	}
 	__netif_tx_unlock(netif_txq);
@@ -2497,6 +2626,8 @@ static int am65_cpsw_nuss_init_tx_chns(struct am65_cpsw_common *common)
 			 dev_name(dev), tx_chn->id);
 	}
 
+	atomic_set(&common->tx_batch_count, 0);
+
 	ret = am65_cpsw_nuss_ndev_add_tx_napi(common);
 	if (ret) {
 		dev_err(dev, "Failed to add tx NAPI %d\n", ret);
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
index e64b4cfd6f2c..81405e3bed79 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
@@ -28,6 +28,8 @@ struct am65_cpts;
 #define AM65_CPSW_MAX_TX_DESC	500
 #define AM65_CPSW_MAX_RX_DESC	500
 
+#define AM65_CPSW_TX_BATCH_SIZE	128
+
 #define AM65_CPSW_PORT_VLAN_REG_OFFSET	0x014
 
 struct am65_cpsw_slave_data {
@@ -93,6 +95,7 @@ struct am65_cpsw_tx_chn {
 	struct k3_cppi_desc_pool *desc_pool;
 	struct k3_udma_glue_tx_channel *tx_chn;
 	spinlock_t lock; /* protect TX rings in multi-port mode */
+	dma_addr_t cmpl_desc_dma_array[AM65_CPSW_TX_BATCH_SIZE];
 	struct am65_cpsw_tx_ring tx_ring;
 	struct hrtimer tx_hrtimer;
 	unsigned long tx_pace_timeout;
@@ -165,6 +168,12 @@ struct am65_cpsw_devlink {
 	struct am65_cpsw_common *common;
 };
 
+struct am65_cpsw_tx_desc_batch {
+	struct cppi5_host_desc_t *desc_tx_array[AM65_CPSW_TX_BATCH_SIZE];
+	dma_addr_t desc_dma_array[AM65_CPSW_TX_BATCH_SIZE];
+	u8 tx_batch_idx;
+};
+
 struct am65_cpsw_common {
 	struct device		*dev;
 	struct device		*mdio_dev;
@@ -188,6 +197,9 @@ struct am65_cpsw_common {
 	struct am65_cpsw_tx_chn	tx_chns[AM65_CPSW_MAX_QUEUES];
 	struct completion	tdown_complete;
 	atomic_t		tdown_cnt;
+	atomic_t		tx_batch_count;
+	spinlock_t		tx_batch_lock; /* protect TX batch operations */
+	struct am65_cpsw_tx_desc_batch tx_desc_batch[AM65_CPSW_MAX_QUEUES];
 
 	int			rx_ch_num_flows;
 	struct am65_cpsw_rx_chn	rx_chns;
-- 
2.51.1


