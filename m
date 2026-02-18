Return-Path: <dmaengine+bounces-8939-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N4oLByMlWlhSQIAu9opvQ
	(envelope-from <dmaengine+bounces-8939-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:53:32 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B99F154ED0
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2738B30125C7
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 09:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2196333D6DC;
	Wed, 18 Feb 2026 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qlk9Ihoi"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D1033A70D;
	Wed, 18 Feb 2026 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408389; cv=fail; b=mWrmZG73KslMYA75XD+jJtzWqejoG8EGn/wm9nqSmV6Hab16Vl4ciEN3SBzyppFec4YrUY5kDh4k5Coma/kfOjbrU7XtpSSdMTEc3kKt0OJKg39x1BtC5qJ5QldbZaVMjwoGMNjsKmxHfsEJcGbw5ObUME2byuepDGHyVH7Zusw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408389; c=relaxed/simple;
	bh=ms0DI9sx6KQh3IxNpR2vgBaXm3zfD/pMePU0+6uXbPk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMVO6UxliBv5dWWDQ3/qTOGJ/jcUvBFR2nJZLGZm+keLnytpLpKysFIbaGRR2E44EFH8h6BwywZmgC/zjb9ig+JgSJfa+oxTSVUlj8jUSSOFjBQyxRcZ+g93N21OH6x8itj5DXpuJgLuWQDsnqngMXDqBQJ7HtY5roJ5RbnvBXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qlk9Ihoi; arc=fail smtp.client-ip=52.101.62.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Do5jf66tCmqhm0WHOPz5nXEPqOdxQg7bWtQqYwEfC9eQ1E4snbXVRjXOM9voxd4D+Yn2s4V+fJF8TQ3FhNbZYxZuYIQxkf4VQFKt6D6dic+NvZWRZy+YngbHOBvqaFQU3tqkv+tDXzz270sw8RubgmFbKcOZoIRPKWvdc9rbeg183DpGfvuvWGSoIG9+jN5qrNNMz0dHWe1QGlK0psajLuawCeDrSIZPsvMcqfKjJrCGSa/0H0M1DILHZT1VHoHx0le6Jr1O+ZOWkxhOqSWxL1wtqbBbYOw/4jffSB0HYsOAMiiiHK5ktmphkYwllNrPL2qUXly6LbfXd7JN5ta+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VvUtJvWgor+kURAct79KswHdt06kYad0yD06Bn09RA=;
 b=MkArPUGUFNR6/ofppNGUOoK6MRB4O/r8kpFmVO3RVueo6/cJVZicYrTwjhGg3l3lKhDoSQ9tzN1tvZbKfBDlkdPcp8C4Abo1WFcNlan0kzv7vzH7I5nq7EPdxpy+EIZS5P54q8YKXJus1lpF+q6v95K1RvfO2Vfi6jd3trWFdhEa0VuUZuGFV2oDkvqEwqmnoHLx9oe4nc3YWdOckQ8LF4ToC5n167eBB42M3pyqskpJcivCdixFiQpz743gGgopenyQ9xA6V0jGS0VWs4SshWYUH5vTD5cEj9KGi8wlxnK65NNK5GJ1mrhHM50R+GNILsCy+3oZ8/B6KtDtFY/uXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VvUtJvWgor+kURAct79KswHdt06kYad0yD06Bn09RA=;
 b=qlk9IhoidgYuhZ8xeeA7jb1eBmqoiRgoATdyJBR9wlMbgQBUj/osDJDClvsxkWLnCBo5ZukS3kmp1K4HiW4+meVM1t0a497sDp6tWfYt7JF38lhxBWQX1ki1Y+Mv7jU444f3VYRcGPaCQT1MovdnhOMo5oPozsH3XcTZ8r1MVnA=
Received: from PH0P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::33)
 by DS4PPF3689F8B17.namprd10.prod.outlook.com (2603:10b6:f:fc00::d12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 18 Feb
 2026 09:53:04 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::a4) by PH0P220CA0018.outlook.office365.com
 (2603:10b6:510:d3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Wed,
 18 Feb 2026 09:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 09:53:02 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:53:01 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:53:01 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 03:53:01 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61I9qpI8200561;
	Wed, 18 Feb 2026 03:52:57 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v5 01/18] dmaengine: ti: k3-udma: move macros to header file
Date: Wed, 18 Feb 2026 15:22:26 +0530
Message-ID: <20260218095243.2832115-2-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260218095243.2832115-1-s-adivi@ti.com>
References: <20260218095243.2832115-1-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|DS4PPF3689F8B17:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b48caec-7f09-4162-1014-08de6ed381aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yssQwqx8sI1CTaAudwNVqZ0aC6VkkjVzeix0b7oKvTEFOwgf7ypMJ0a91IKK?=
 =?us-ascii?Q?Tym/PArcrSBgvZfY9RlMTeuetuLFQgqz3+1pFCnMYi/HW08YFycjmSF8whWg?=
 =?us-ascii?Q?5imFjTlEsM+ZxsVy5+hl5u7BVL3IVmd5NYcmfM5zf5QZ6yGQO10If0dMZbgc?=
 =?us-ascii?Q?HpQWHsCxxMOqKat9WsthZ5rzR3Dh82nRiGlWAHnrefbHy+GsNLMXHfHcPDTi?=
 =?us-ascii?Q?ZUFq9MAy3T9ookH4FFkQ9aPQVxkazUsxDWsub9LTLBtVPMzdG7jHT++pdeEA?=
 =?us-ascii?Q?QAcc/NVbwOzbo4b2A6+PZBhwT5/tsTeDPFEG14YFR8gDVZrowUMthME0Lh7l?=
 =?us-ascii?Q?1vVdFGPx5PvEEtgr3gQUVlXzMNu+U2vCGYCNkj+CPiUmyNaE+hXbGbX50v5/?=
 =?us-ascii?Q?Ahtaw8sJoL6VmKT7QQf/vK2XcNXiVkXs+ESjvgoNjcc8LrJMD6NbvumkshIq?=
 =?us-ascii?Q?1+HpLL9P4uhT9ZuhP9vW8Y6yPjB6bxORutEpfOd+3bGXhajsGWg1G0THEd5y?=
 =?us-ascii?Q?xG7pA1EWIWWpQhruy1SI3SvqRLsfAq9gqk4ODyNZ34l6MdtEwKBlW6/d9Cp4?=
 =?us-ascii?Q?opMHw3Jysm7T3TXquFkbyLkLooYu5bJD7zb0UQAR4rrIVbC9YNrLUnKzAQ4p?=
 =?us-ascii?Q?M0y6hWVqJE0iXeAYwafV7jB/rWiEw8DVF5H5Jxcqaz0IrmeOeE2XQTPzHzPk?=
 =?us-ascii?Q?TZPKY5MyG40+XgcXpUlKgq4FyS1b6D5WvSYo5ImSVVTqwSvqvCwHRdggihS9?=
 =?us-ascii?Q?Dgijf5dPLrV8W6W5ekv45+D15nUd0Oqt/p9hoZOvLbzOT9b8WtMZO0jj7/xh?=
 =?us-ascii?Q?tZEleBdwv8fGkhpMrynpM0IjPqn8Uppb/eeCPJ+wSak//c4fq+G7axz19zmw?=
 =?us-ascii?Q?2jnkGuliI6PjP7pryWB0JiP6k3l/5S1OMk61Pj982q/0B9NaZnwY3CtB/nXw?=
 =?us-ascii?Q?JjqwA4ajputBTP5Jex4roAGVudeAywGOX3kt+t1KCCr7t5mLg7e7cV3OhKpD?=
 =?us-ascii?Q?81yflO7rySbgxzO/58BumOXTTzbK8aTUUHZuJKz4aFhOt27xpYLu5m4tErUH?=
 =?us-ascii?Q?FsT0dpAbLQU7x5Y3ksCdDHvSBzOxUVSmfCOEiy7J/DCSWOjIvpCp5KAp53sR?=
 =?us-ascii?Q?h7GN4Zfg6z06Gy82nispOi48H0VWcGSjhwCJMnJIRmNOqA77Q/mQ0sWS4MWt?=
 =?us-ascii?Q?LidcYwiKl1WLKhFK8hO5DgxZdTVEs9CZizx9bG+cS+EJs1ay3jY+h7JRE8mh?=
 =?us-ascii?Q?fsal7trJq2D5OZOk5Y1xPmVw+hjCKDjj69ifkvQ057bXlDZyvQWfKcaHLIDp?=
 =?us-ascii?Q?0yPdkbhtjUqlqIHdLP0qF4KK+P8Zy73RGcdgxkxwl/gRk9vKdtkxN1YBJ8m7?=
 =?us-ascii?Q?Nd36EdnS5z/Xp83BKgZN27R3xRVQSx401Ctcv6ctTT3Mu3xVEKvjcE24ltMZ?=
 =?us-ascii?Q?A0sdXPbYA4fUnTKU3UDXOXZqe4p2Mw1eJ1uazA7Om6yk1uM2e2HjPUQ43kGY?=
 =?us-ascii?Q?2bxD5WUdEcOPqQJioockRJ95EghfcHlD0b6rsA/kcnbTrK5nX07FJL1u5SA7?=
 =?us-ascii?Q?2B2BODls08LnS3a2+lmnOy8/CHuUL/CqVGqOblHLAY/XPysG5YO4u1Ke5D6y?=
 =?us-ascii?Q?Ob2h9+XAAtQgEZ5QSlwiYKyUDNe3bjqb8TvryGhzrr9qTHO81x9TEr9FZ5qY?=
 =?us-ascii?Q?uX1+M1y4Jv7cAGbG9mGNFVOygcw=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FZt3LHnYdeFwvhUW+Vv7GSymx+1mRWxkcJdGnRFuUg/0tN+BdHQgw/PyPJEnT0/FjytkRczGtSmyjpG5no3XJpffZ4R5Ro4SmE1jLs0FY3Ta/wPBmRJfvAG1SBQPCWZ1EKt0Zp1nhT4PvTMWBjTKHgiuOW4wFcCQi60xbUKq/1+USAzAuvYjHM3N9u9gFtbPszcUQUQugMXg9+uid4wKH+qlfbj9RDBXDYBipxnu+k92mvgAVG0KI0IHN99PE0RC0fszXfcjY/eXkbVpt0bnKbjDSh3aWnh5qtAkhSnhJMniuEtfAeE5QSdeRaLR6Mipq1r6eWvEjRal4yAqmdVLyJJc17gYZDxcCk1SsAEjHYIIVEbKTYIMufgZx9yv055SR4HQaK3+e8LSIK59TghyVQupFR3gag+MNhiUb/qjLmiD5XeJLTRg5mNH/lsVLpN8
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 09:53:02.4857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b48caec-7f09-4162-1014-08de6ed381aa
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF3689F8B17
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8939-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim,ti.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5B99F154ED0
X-Rspamd-Action: no action

Move macros defined in k3-udma.c to k3-udma.h for better separation and
reuse.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 62 ---------------------------------------
 drivers/dma/ti/k3-udma.h | 63 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 62 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index aa2dc762140f6..4cc64763de1f6 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -39,21 +39,6 @@ struct udma_static_tr {
 	u16 bstcnt; /* RPSTR1 */
 };
 
-#define K3_UDMA_MAX_RFLOWS		1024
-#define K3_UDMA_DEFAULT_RING_SIZE	16
-
-/* How SRC/DST tag should be updated by UDMA in the descriptor's Word 3 */
-#define UDMA_RFLOW_SRCTAG_NONE		0
-#define UDMA_RFLOW_SRCTAG_CFG_TAG	1
-#define UDMA_RFLOW_SRCTAG_FLOW_ID	2
-#define UDMA_RFLOW_SRCTAG_SRC_TAG	4
-
-#define UDMA_RFLOW_DSTTAG_NONE		0
-#define UDMA_RFLOW_DSTTAG_CFG_TAG	1
-#define UDMA_RFLOW_DSTTAG_FLOW_ID	2
-#define UDMA_RFLOW_DSTTAG_DST_TAG_LO	4
-#define UDMA_RFLOW_DSTTAG_DST_TAG_HI	5
-
 struct udma_chan;
 
 enum k3_dma_type {
@@ -118,15 +103,6 @@ struct udma_oes_offsets {
 	u32 pktdma_rchan_flow;
 };
 
-#define UDMA_FLAG_PDMA_ACC32		BIT(0)
-#define UDMA_FLAG_PDMA_BURST		BIT(1)
-#define UDMA_FLAG_TDTYPE		BIT(2)
-#define UDMA_FLAG_BURST_SIZE		BIT(3)
-#define UDMA_FLAGS_J7_CLASS		(UDMA_FLAG_PDMA_ACC32 | \
-					 UDMA_FLAG_PDMA_BURST | \
-					 UDMA_FLAG_TDTYPE | \
-					 UDMA_FLAG_BURST_SIZE)
-
 struct udma_match_data {
 	enum k3_dma_type type;
 	u32 psil_base;
@@ -1837,38 +1813,6 @@ static int udma_alloc_rx_resources(struct udma_chan *uc)
 	return ret;
 }
 
-#define TISCI_BCDMA_BCHAN_VALID_PARAMS (			\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_EXTENDED_CH_TYPE_VALID)
-
-#define TISCI_BCDMA_TCHAN_VALID_PARAMS (			\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID)
-
-#define TISCI_BCDMA_RCHAN_VALID_PARAMS (			\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID)
-
-#define TISCI_UDMA_TCHAN_VALID_PARAMS (				\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_EINFO_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_PSWORDS_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |		\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |		\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |		\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID)
-
-#define TISCI_UDMA_RCHAN_VALID_PARAMS (				\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |		\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |		\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |		\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_SHORT_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_LONG_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_START_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_CNT_VALID |	\
-	TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID)
-
 static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
 {
 	struct udma_dev *ud = uc->ud;
@@ -5398,12 +5342,6 @@ static enum dmaengine_alignment udma_get_copy_align(struct udma_dev *ud)
 	}
 }
 
-#define TI_UDMAC_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
-				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
-				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
-				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | \
-				 BIT(DMA_SLAVE_BUSWIDTH_8_BYTES))
-
 static int udma_probe(struct platform_device *pdev)
 {
 	struct device_node *navss_node = pdev->dev.parent->of_node;
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 9062a237cd167..750720cd06911 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -97,6 +97,69 @@
 /* Address Space Select */
 #define K3_ADDRESS_ASEL_SHIFT		48
 
+#define K3_UDMA_MAX_RFLOWS		1024
+#define K3_UDMA_DEFAULT_RING_SIZE	16
+
+/* How SRC/DST tag should be updated by UDMA in the descriptor's Word 3 */
+#define UDMA_RFLOW_SRCTAG_NONE		0
+#define UDMA_RFLOW_SRCTAG_CFG_TAG	1
+#define UDMA_RFLOW_SRCTAG_FLOW_ID	2
+#define UDMA_RFLOW_SRCTAG_SRC_TAG	4
+
+#define UDMA_RFLOW_DSTTAG_NONE		0
+#define UDMA_RFLOW_DSTTAG_CFG_TAG	1
+#define UDMA_RFLOW_DSTTAG_FLOW_ID	2
+#define UDMA_RFLOW_DSTTAG_DST_TAG_LO	4
+#define UDMA_RFLOW_DSTTAG_DST_TAG_HI	5
+
+#define UDMA_FLAG_PDMA_ACC32		BIT(0)
+#define UDMA_FLAG_PDMA_BURST		BIT(1)
+#define UDMA_FLAG_TDTYPE		BIT(2)
+#define UDMA_FLAG_BURST_SIZE		BIT(3)
+#define UDMA_FLAGS_J7_CLASS		(UDMA_FLAG_PDMA_ACC32 | \
+					 UDMA_FLAG_PDMA_BURST | \
+					 UDMA_FLAG_TDTYPE | \
+					 UDMA_FLAG_BURST_SIZE)
+
+#define TI_UDMAC_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_8_BYTES))
+
+/* TI_SCI Params */
+#define TISCI_BCDMA_BCHAN_VALID_PARAMS (			\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_EXTENDED_CH_TYPE_VALID)
+
+#define TISCI_BCDMA_TCHAN_VALID_PARAMS (			\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID)
+
+#define TISCI_BCDMA_RCHAN_VALID_PARAMS (			\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID)
+
+#define TISCI_UDMA_TCHAN_VALID_PARAMS (				\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_EINFO_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_PSWORDS_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |		\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |		\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |		\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID)
+
+#define TISCI_UDMA_RCHAN_VALID_PARAMS (				\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |		\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |		\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |		\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_SHORT_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_LONG_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_START_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_CNT_VALID |	\
+	TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID)
+
 struct udma_dev;
 struct udma_tchan;
 struct udma_rchan;
-- 
2.34.1


