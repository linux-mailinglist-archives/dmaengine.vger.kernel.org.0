Return-Path: <dmaengine+bounces-9645-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGVlDWzYw2lwuQQAu9opvQ
	(envelope-from <dmaengine+bounces-9645-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 13:43:24 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDE6325131
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 13:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA494307539A
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 12:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82623D47DE;
	Wed, 25 Mar 2026 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="byigq5vN"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011031.outbound.protection.outlook.com [40.93.194.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560143D3D18;
	Wed, 25 Mar 2026 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442227; cv=fail; b=T6xYFDclmZ1q91om1rIhOnR3rvqAwdzrf5NlBJZMVKz1set+DxjE4byZHYfi/dXD+rfuGnJFj8+sh20PR0PiWSeCITaSLJx3r+NiNCpjW2Dzb0HOMwSfltEzJiBo52XY9RTgwZuOK4eyBswhljc1SvQc6cNSdx6XTreT4hPtwCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442227; c=relaxed/simple;
	bh=mWxt+7uBDqzpereRbBNxqBxNWH0F6qwYc2WiEpK28qw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HlHhh05E3oP3ZHisMngL5m5XYnaaSGqcWmV6xYyFEWgbqQB2NaROn9HwycSz1zLP+jqP+WJTZFYP11d/OVYw72jTrT7SRbWLpgTcRdG6SuyYo5tLIE5zGiE+Y1tx0m5vGmDuXwEXcP0qjA0XjPov4y0Y26sxXTHW/miYGM554xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=byigq5vN; arc=fail smtp.client-ip=40.93.194.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjzDl/tUNXlt2+5z1Dq6dxHBdhmdcc7JKHGbnFZjzcjS+eRIXSEZCKB770TYruzA3ecapWrMgjmWeTHry1grhqVOSH/3LfOI2UKv+cLM1loDLDA4RZQvG+F4oFwa0qWbUCxQUpog9bshaFSTvPF1oMAWegaZVBYKKWdCVFK8q1/hLlOIryj8lqkLxp1jVku8RVtWWX0IwjCaOsTx1ebT1j3d44rdGATuO/F2Js4uikmL4AqufZk7dGd9SdbdIYr17twGVzMpAa5ultHuXW8NHGYIDimm9ZjAMt93vsknUpcA7XNuesgV/yyhpuPIHILt7lK8G49+Jtwox/sASRWqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaLd3noC1m0odAgHvpZLJsyfA3soJoMeXPEBYzc2PRg=;
 b=mtIWh6WQEY5uH4SLbVFb56WbahBxWkS7fwhSibX/zyyo4VmS+cHbDB95Y19p99x7N1Wvy39VmpAg31O92hD8Gkenggv7+LgdMH3tR6TZxApldU/EIYW3HFs6pU6zhPRcgFuosl3Ub/hM0k51N8jAOS5LI/T4choKJ267Lh6XcBh7+aDBAsL59zNzWZ6lr1Z6cZ7yFRsXi1BRIReqOVZergxDg+5RnbsaseK3B6/PF4Lqz6ThOBIW69Vgm9zgchxILyokIvVTIGADLoj86UexYhHLO6EuIv0fqYaU3DIrPk42RkfqBwO3ab/TZnKAFGrwECatvjvv/uukFY8AXwe+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaLd3noC1m0odAgHvpZLJsyfA3soJoMeXPEBYzc2PRg=;
 b=byigq5vNHnhUUzxMR/EqDQyqc3SbSTjCFTWe/wtf7TrjOANutwS/SWTqHD4Rc/bbqDtqvWaTuiZ/H/JhhqD4JJCWGqiEIqOiO5iO8CQ/Dj8/WNtFfodJgAmTARtlpp++C0kFWFngy2M/6u7a/9rQQ2iy1GWCXfHNGT118klLcx0=
Received: from BL1PR13CA0263.namprd13.prod.outlook.com (2603:10b6:208:2ba::28)
 by SJ2PR10MB6991.namprd10.prod.outlook.com (2603:10b6:a03:4ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.21; Wed, 25 Mar
 2026 12:37:01 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::ea) by BL1PR13CA0263.outlook.office365.com
 (2603:10b6:208:2ba::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Wed,
 25 Mar 2026 12:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 12:36:59 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 07:36:58 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 07:36:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Mar 2026 07:36:57 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62PCakEW270453;
	Wed, 25 Mar 2026 07:36:52 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <Frank.Li@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <nm@ti.com>, <ssantosh@kernel.org>,
	<horms@kernel.org>, <c-vankar@ti.com>, <mwalle@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [RFC PATCH 1/6] soc: ti: k3-ringacc: Add helper to get realtime count of free elements
Date: Wed, 25 Mar 2026 18:08:37 +0530
Message-ID: <20260325123850.638748-2-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|SJ2PR10MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: cea87195-dbd6-48d4-b058-08de8a6b359c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	V4vL4cyySgdTnRucf8UXonUldGqKv44lBtE5vUSxOY2WZsOmgdViulkNXF3traRhmeoR/mLAWNaGltXyf6qhA4t4TNx/Nvw0hJwfNdF052UT2VLA8UX/34l8YW9ia0X1f9r6Gc3CC2GhkMBL5T6/ExzBCABBvYUSKU9+VsF8tkHdyDQG6rjgbTzoGduCg4SgV9S/74zgflJhaQixWhklAgnl8FsWKx7tPta0sebc+/lB0jAOPepHh/YOniV8ng20wEDhX1YZjO7wg8RET5Vbw+t2wjIQ9+972M87DrZ6tTa2DGYk6sJPOqN69SpKZNzfIUIJVCzWteybB1G9ErtwAdKwXpYc+2zdr0UCKSIxp6kjZck+6Wx0tbk/uODU5srGEl+OnaW3hFk/Q3gVDKj+FbdjlLDudGVafeBniK0cJwIyArBkEjNG76fYTMLgRcOdCHugfdlY4E935C7a7sy+/R+xweP35SGuz7DLdoRNryKiwcln4cZ2iMJKw1HFOO/mjsnQQUGEbFSOicvCJTSc5I8eaDRsIxci5NwdieiGmUNrd6yILtTxwXmvbs8gG8BDcz4IdV5CGBnxnFeAT0pxMl3Cm9fgFeQqKL9Yht25kgmxJ0HjLJlXpNyGdLcyXmRjyRmIJwILuAQIWoewCmVdCi+YCh68dV24PekKc8dIJXRzwCwgIVTZw9mWkYrOFDVKJfVCPhONOBqI7m1fRzoNEQXDiFXP4cZkisKOXb7Kkz4nn+sD0vN3n/mqy/3QRSS50TRK0MMjEiqoi8JGQ8HjGE9dx9weJaTkyJuqJ03cAsEArNX0zOxDEh+IIXfSktMj
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R5syc9Q9G9uGzULv3hWQ/EISBEmR9xxEG8zHiAvuEAiEv38+uAS3r+ErbHklbyPuk3tVCas3hnlMnPxFoOlOuZH+xmljnC8/vp+m7YTu1ECEkrSnoAiFXywft8pwObcLfgRPpbuA8+O3XdRxs+YTrdtjJBsFBG4AYTkttuLr72mc1FZV8VUCXksoPUbx0tSGw3SDlts3HCjLiCdbpdnkkHS3gYmaLLXFpBOiF2MvAL99UGokgHu8aye2lhUuQwotlWRZx3rthY2Nqh6PUYiigPlaxCXxhE4w/DPKlVJAhO+pRvNUM2pJTgiFNA2yhUknLPp8kQEJqqMP8P8Oicn5jm5UZkNgxduwuEfdz46Sk+kzIGXoVUawIaDww21QWa41qBYKCbFAk09LZrUjTR09xrZTS8KjdeaHkQn3JzPlY2KVsYBaNCa39ut8QF5lSqrd
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:36:59.7678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cea87195-dbd6-48d4-b058-08de8a6b359c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6991
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,ti.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9645-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ti.com:dkim,ti.com:email,ti.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CFDE6325131
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The existing helper k3_ringacc_ring_get_free() updates the count of free
elements only when the software maintained counter decrements to zero.
As a result, for batch processing, we may read a lower count of free
elements than the actual count. To address this, introduce a new helper
that provides realtime count of free elements.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/soc/ti/k3-ringacc.c       | 11 +++++++++++
 include/linux/soc/ti/k3-ringacc.h |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 7602b8a909b0..1751d42ee2d3 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -905,6 +905,17 @@ u32 k3_ringacc_ring_get_free(struct k3_ring *ring)
 }
 EXPORT_SYMBOL_GPL(k3_ringacc_ring_get_free);
 
+u32 k3_ringacc_ring_get_rt_free(struct k3_ring *ring)
+{
+	if (!ring || !(ring->flags & K3_RING_FLAG_BUSY))
+		return -EINVAL;
+
+	ring->state.free = ring->size - k3_ringacc_ring_read_occ(ring);
+
+	return ring->state.free;
+}
+EXPORT_SYMBOL_GPL(k3_ringacc_ring_get_rt_free);
+
 u32 k3_ringacc_ring_get_occ(struct k3_ring *ring)
 {
 	if (!ring || !(ring->flags & K3_RING_FLAG_BUSY))
diff --git a/include/linux/soc/ti/k3-ringacc.h b/include/linux/soc/ti/k3-ringacc.h
index 39b022b92598..091cf551932d 100644
--- a/include/linux/soc/ti/k3-ringacc.h
+++ b/include/linux/soc/ti/k3-ringacc.h
@@ -184,6 +184,14 @@ u32 k3_ringacc_ring_get_size(struct k3_ring *ring);
  */
 u32 k3_ringacc_ring_get_free(struct k3_ring *ring);
 
+/**
+ * k3_ringacc_ring_get_rt_free - get realtime value of free elements
+ * @ring: pointer on ring
+ *
+ * Returns realtime count of free elements in the ring.
+ */
+u32 k3_ringacc_ring_get_rt_free(struct k3_ring *ring);
+
 /**
  * k3_ringacc_ring_get_occ - get ring occupancy
  * @ring: pointer on ring
-- 
2.51.1


