Return-Path: <dmaengine+bounces-10181-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCl/NA168GnyTwEAu9opvQ
	(envelope-from <dmaengine+bounces-10181-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 11:12:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D10AC48105C
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 11:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E8AE3055E74
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 08:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC303D8913;
	Tue, 28 Apr 2026 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XdhI5C1l"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B849A3D6673;
	Tue, 28 Apr 2026 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366445; cv=fail; b=Z80z0dUKnw+BJNgA6bXI+967vLviD+vUkRsEHkY9V7UJKUATfc7bor8jTDn2nfuJYXb8kN8vk7d2Bnj0H1UGHKVeu9lxoKwvdhN1XhiRTtMKnhlG+3WHZrI0inuNSWR3PYW54ktooifofBvcNCDodEyo7kwQNInQ/GjJea/pBzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366445; c=relaxed/simple;
	bh=U/DiUCGE0MTdXw22vutZnCVkof+cbVq6CdYlxmCcSLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PR0YDeg6TDQu+NClhwdGjpJccbzBRB9tSxk5twQ7npqJ2eIn2BC5kOr414Aotu4NPHX6Fd09ll7SPbs0+EOa5P6P6OOMRYxg+6aMgxCJxZkAMlAR7DR2amXXbSERb+hvScWMJt7wVlVEKk/TrOOod1XreWrhsQ7O2fhraPuPsxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XdhI5C1l; arc=fail smtp.client-ip=52.101.56.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdpFcg76LhOFjZNV4t4/ahWUhMpXhzdiX1pzsD0+Ya/QEArfEW57fkKbdv0ks8tIivxUasYs7OsY5Hs/9k6u45dnBvb4rX4NQjrX6dFsUclOR/vqh7sQBMusnUuk6kaTNMzhAEJ7BZL67zpuJd4eiGKvIMqEcceGNPWQE/YM/mXm4lTwRX9bauAH/1DSy6EDuzp6kkUEU+3+7ERfwdm0NStAAqLQai7+S7GdaulmQ1w8wIOfoluonD5m1WyQ6dsPgIBpbGQDWPNE4lyZxYjLpYKPyDeVqrO24yT9H9HLGAleIWpvj1yytmpbHIlLC5rt/fqsZZPvQ+y1zUxyRHrkIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMNmze9D/smZWTbqcmnj/N8fgqgsTRWcKHnTetGUt/Y=;
 b=asfjswpWcaEtIKb7s91GK+gc/LI50SEEGwG8sfzns72IU/VnIFPrQWH3abE67kuioEody5/6IK3GGK8Job+U6ak/n5WPnIaw2dNR6H1rI0JwsMT3ftIh/GrfCvp6/wrOtqMKORfRLln1h9i+SJ2QFt3ASZHoQor7IO65BqfvyRVpeXcNtARu3KWJzvIXXRS/YiTggJTu8dva5uBZ/gIO2K7wW3ZLSE9Ou7tRE60gnnPYQaFBG3pS1bne+OSIIXVOOucMgi+TsGDnSxX3ZQvozYXUznHnul6r+DtVDEB9yn8K/P8T6c/Svgqc7x0brgYJQBkVXcI9pQi/yWImnPgt2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMNmze9D/smZWTbqcmnj/N8fgqgsTRWcKHnTetGUt/Y=;
 b=XdhI5C1lP97c0IMiuw3t8N73gX8LLcVuS6NLDdAYsXAT7Cs4hHRA2LQJvbWGV9yhqrp0o84IQQ6icVKoFUB75V1EOKwG4sb3hX5d3+xHnV0qlE9wgxN1ZSN34EdyVREd3EJgTIShOhBaEvjM83TlUuCjzLLc6fhqFqp2Hb3pQ9U=
Received: from MW4PR03CA0209.namprd03.prod.outlook.com (2603:10b6:303:b8::34)
 by SJ0PR10MB4560.namprd10.prod.outlook.com (2603:10b6:a03:2d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Tue, 28 Apr
 2026 08:54:01 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::a0) by MW4PR03CA0209.outlook.office365.com
 (2603:10b6:303:b8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 08:54:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 08:53:59 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:53:39 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:53:39 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Apr 2026 03:53:39 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63S8q6Mb623293;
	Tue, 28 Apr 2026 03:53:34 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v6 19/19] dmaengine: ti: k3-udma: Validate resource ID and fix logging in reservation
Date: Tue, 28 Apr 2026 14:21:48 +0530
Message-ID: <20260428085202.1724548-20-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|SJ0PR10MB4560:EE_
X-MS-Office365-Filtering-Correlation-Id: 2105cdf1-2af9-4006-f1e6-08dea503b046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|1800799024|376014|22082099003|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MTAzQ8n3aao/b9YSiEV7ODHS1Zb0SluDPWakMYtent7TEJlitl4GgEgmXic2MjWr9sKFUPkYaffYaSGHgOoSE1mAdDVIKqIWXOGV+d6d25vdaCGbtyYVSikjj1q7rqzRinVLQk+Hs/Do3URvAcbDXVelGzBiWP127wtS6v+Nz6ACKOzlLVPRPveXOjmT1X6/23z20foVQ2ZKpOtn/ofcJoSRq0CRU3I8ThUcVdL3RiUEu4/alANGlNDEnob4CNTx6+bMkNKtVwLI/c2w8UW/l8LlZ5Cg/cWU/A0KGuFun6I5MtFTSJWt4QHv6QE6uViYHMvnDfavF+KLGk7IPtWBXHkjrUs6yHWW7MQ/f+kvSuy/b/EwBctiXNH2+GzS3gGxwkhLWgtJJ3Digjczzeyq8Z98hV434x+YI15pK1BWN4ZG567T0B0yDA001afQVua6p8vBIDtO/dySFIidSCWVphwLR7HklFwLdLfa2pGdS8WVCIA3Yw7kOEJOs2FErs8RnF+qGxxK50VE5Jo0E4s3u1c6/mQD7s9NRWrPrhdsqqYsLfK9eXihc8snlWIcbGhCmCVIaqRzb0FZSfnUeMT35xQRMCR36i6lZAjfoHdaP0SR389tpmCJM9pUbub7xCEMZuYTekUIOKCSjyPIPA3McZbraBIMh+Bnnnckokk2yLo/JJCUTwcufBpn3/X4AeaOlk0ocCzoh7iHhQEOKzn79A5zLcu2i3rZVcY0FJX5WlUUfAjCJZdLlr1vs5r99sn4woQEIPuXEd0X8OH9dvUw7sLXRKWS2lPFpHJTWaZmiJ7HLomH3DNBw7x9OBqw93Dw
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(1800799024)(376014)(22082099003)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oDj3qW0PLq/yTQfWanSXsw+lqzxl8lq14TIVCaeScUhuRk/9bRCgYYyfPqANt9jPq719oWlk0UvKdwyC9+Axx+OCG1cs18pEdGPNyHvtHTTNLQk8K0tZPQ6c1XEsDDyRy63eIoDub2e0L9dKKDQFqBNtU14pcWyXyaj6wvU75WK/WlyfP3dhZMBahJ5/VZsY4ChWcOTXDRqlj3VxmFmdC7u0Idg+/52gNoWVGnM20RpTSB94Z0isLLBflU1p+zp7iTtWSCa6CiOXOHNr3iIDiDd7ydOGGa1NiYeectIHNSqVTWteMaC3jZ40LSYx/a6H+83s5lHoh8ZO5CZTt58fzlJ15XaV+cpCAVbns0j0m3k7hpeBqNHUnBU9/zCrvrhLfosooLYXrbf9SFRPnekYdzHdCT1PtK7hFG2DbpI9iq7tiuYav3Yjw0rZlriVlk08
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:53:59.2778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2105cdf1-2af9-4006-f1e6-08dea503b046
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4560
X-Rspamd-Queue-Id: D10AC48105C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10181-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ti.com:email,ti.com:dkim,ti.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]

The `__udma_reserve_##res` macro currently lacks a bounds check for
the provided `id`. If a caller passes an ID exceeding the resource
count (`ud->res##_cnt`), `test_bit()` performs an out-of-bounds
memory access on the bitmap.

Additionally, the macro returns `-ENOENT` when a resource is already
in use, which is semantically incorrect. The logging logic is also
broken, printing the literal "res##<id>" instead of the resource
name.

Update the macro to:
1. Validate `id` against `ud->res##_cnt` and return `-EINVAL` if out
   of bounds.
2. Return `-EBUSY` instead of `-ENOENT` when a resource is already
   reserved, correctly reflecting the resource state.
3. Use the stringification operator `#res` to correctly print the
   resource name (e.g., "tchan") in error messages.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma-common.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
index 304dad59bf183..92b14b0b620a8 100644
--- a/drivers/dma/ti/k3-udma-common.c
+++ b/drivers/dma/ti/k3-udma-common.c
@@ -2010,9 +2010,14 @@ struct udma_##res *__udma_reserve_##res(struct udma_dev *ud,	\
 					       int id)			\
 {									\
 	if (id >= 0) {							\
+		if (id >= ud->res##_cnt) {				\
+			dev_err(ud->dev,				\
+				#res " id %d is out of bounds.\n", id);	\
+			return ERR_PTR(-EINVAL);			\
+		}							\
 		if (test_bit(id, ud->res##_map)) {			\
-			dev_err(ud->dev, "res##%d is in use\n", id);	\
-			return ERR_PTR(-ENOENT);			\
+			dev_err(ud->dev, #res "%d is in use\n", id);	\
+			return ERR_PTR(-EBUSY);			\
 		}							\
 	} else {							\
 		int start;						\
-- 
2.53.0


