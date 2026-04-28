Return-Path: <dmaengine+bounces-10171-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN+6Klh+8GlSUAEAu9opvQ
	(envelope-from <dmaengine+bounces-10171-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 11:31:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1310948173F
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 11:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E82632F449B
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 08:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BAE3DC4DC;
	Tue, 28 Apr 2026 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qCLV20RD"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012050.outbound.protection.outlook.com [40.107.200.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29BD3DB639;
	Tue, 28 Apr 2026 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366387; cv=fail; b=tqlsyzMg2Fg6VrHZMUdfzrJ1YDnBkAsvZEh/rrxHDjRuK6YFjgMqZZi+w0/8SpucDaayH7Pra5prh1lLK80INQp+WfdlGCIx8LHCKcP3I2gu2ig+SAtzQlW3SKTbwH1fMq/J9lcx98oxCXvnXfkvwNrbxT/8Je9YAUT4n+D6ojc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366387; c=relaxed/simple;
	bh=LwumOpe199VExSyyzeZWw/Ue88Lcu3JlwJySYjLGQ0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3ioNNBr8N8hGNWyi7gUDYM6d8O1B0o/L9LSqztvkT3iBxN3d7JygOyMbtIyHnemxmtLZ7v+oBbxDV5lhTp4nczHxjdSTU+0oOt/ssdJ0+mMG6ksCNPRT/GCU6PPjnXXiJ1xQZongxgU8ZkHzOkjqTjtpMM3lKkF0Hx/+SFdNBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qCLV20RD; arc=fail smtp.client-ip=40.107.200.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVdJL05KRyZSKZ8+qpzWUKFXTRtb8/Q8Kw4hQu9lawsP04ZCz3bOtFJvuMU8eJhF70HqVlU2184TmQ5KWSDrwuBCXKBi8G/qeDyzJEAwRsn6T3XNDk79Hl9qCLodf+tb22N+58Lqrk2Ozt1g/2wZPQgmJlNG2mbIV3hHPJ19piyRDtzWTGXvAMBKDCPnRG3XgBGp93O3NfFJnGszYGpU1yKVsIiBIXNJ9fTwS+nXb/4upOjLNL8QtcJBiRaLJI5pQ+srobZS/KeiSPySGFn72ssXDwTzjnn5qOMc9f7KtQ7qeyhyOw1mE4qg8n8ImWIq8iVUf0wLi+XZF/KU2BcUJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gm020M7t3gXs0yIJcS2Jy9mtLkPCGIU8QkZDD4/7/cI=;
 b=hn3awSJ6Ka3ehq+QEujKgte22d0JYBalAmFdyTSNJv2EUlCUxVSv9vLRheOnstXKVj8NKqoHMulJleHRoKMWExxvoUpDWSMPcJ1/+MWHXxlWndWHlqwtzX0ldorIcl3czbfUTfuec0bw0eTfIbH2EKOHZ/FzQtlVQRlxPPIwG0RGxNsd2znV99KRRmByPfMhyLyigJ9W6hsLIX76LqevHoWwLtrXtHz/QgPoWkCQgaJIiKfi3bqQxHqTKy2RJ8g5XVkUbekShsuwfj46EHQQQEZYQOFdTKT/SrUNhtvatdinCs217r82UDXPhjny2i5z1HK7QER+jkwUfQMxekKC7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gm020M7t3gXs0yIJcS2Jy9mtLkPCGIU8QkZDD4/7/cI=;
 b=qCLV20RD9INCGWEdfH4+/mwrEN24xJ+Bk6d0E38esPMndVPrewtzC7OPUE7MS9UGxHXsPrYKmOMlgsLy3ZHhdYMbucG0KgU9gZX6/wDGGdKlm4C6z07pVUeFD5C+vlW1b/23LIJ54e9bVBbcIKb9xOKzHPkeAUrVS4XTSkAnxRE=
Received: from MN2PR18CA0022.namprd18.prod.outlook.com (2603:10b6:208:23c::27)
 by PH8PR10MB997906.namprd10.prod.outlook.com (2603:10b6:510:3cf::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:53:04 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::4b) by MN2PR18CA0022.outlook.office365.com
 (2603:10b6:208:23c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Tue,
 28 Apr 2026 08:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 08:53:03 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:53:02 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:53:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Apr 2026 03:53:02 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63S8q6MT623293;
	Tue, 28 Apr 2026 03:52:58 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v6 11/19] dmaengine: ti: k3-udma: move inclusion of k3-udma-private.c to k3-udma-common.c
Date: Tue, 28 Apr 2026 14:21:40 +0530
Message-ID: <20260428085202.1724548-12-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|PH8PR10MB997906:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a64b9d-3dc2-48af-f024-08dea5038eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	c8nKy7sUHXVuDeaWmdicCkdPaKzglNiqEDy/7COpdXSLTFptYsaW1bLItzIvnMZaRJJWKrd+Gf22c/hYkoOLVMOqx1Z+HTgDVi+0N+FPK0TILeJ9XSFv0GSeRmu4NjCj/AE694sN1OOFt2K6BaOzHb3xvSvrMl6YH64vkie/uJWcIm6PO9IiqqNQ21V2ZYGjvo8zZ8URIDcUX6XNDOgiBW4iuQAKzT1gX4YrADO/VwvyHJ2zfNEmyz0oj+H6rhdUDkNoXyNu+ZwwpSWEdQg2U+mnFtfRLqEDPOqkp1CyI7cS8hb+KiF8YIu+ILK/iJt49OmKsq2ikLuLkKOW5/KO7Xz0cKRBWa5fV8oAYR0DfiXBQMvKOXj0HKogEFQf13jwOM8sZu9UIB8IUwSZdA8lI55KIlaH+bEirmhLPG45OAYLLD/V9idXDrcErFNkC9RR3lQQvNBzDG3ajRpZI1vsyKgfms/09K1T6LDSrYBAS6qBbhp54ZPWBHITXlKiNGWPuAciPk1VAibFH8ZSZBc59BKFwQ7mlRjeXM0dmy1Jse2/t6TXlCeI2oENpbDZX8doYACVTLDQaA7nttS9mdkQnEG/WL7x1A492e4ue8mYUackAYEjEuDji9B8XTRhP/PmH3pVjNw4RbtFSmF4C6ifER03mWbdU/fT/sr8GGcZv3Cyi6IUua+4IsrESljNtMhHUzUu4jePzOKa/6jFMNxF+IqxlNHYYJ2FmkyNgMke/+4S8msms63JrnvtXm3AH6/+u2KV/19ajyRv7jpNagwsxYJZgAxoUYKMdRULGVhRDkwcPvhle2VYV++BMOuUjz3J
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Or7zBhfO9BxHl1y2AwfUIdfQi2zBcH4CyTLV4xUkIkalOaOb79xeuLDnMS2d0e3nXYmyFLROcuVa6uyfx84WJUwU6/2evavKmVtScorbwGnDJ2cR8ySxZGKf+r8+5DIjmjBMriJ9zuflb1Bd2cGr4sDbCviVV4wpb4nVGU8txQE9zA5QH4vxboLpveuq94YsCPFU9frT1aZWM/JdkZ6vXhcxU+LRQW11YhdIZTI7/0WSj0J57NJ5sOSXbIe6Be6acdhaJ1e5Ba2UB6/5lv8o1JxjSHDNVfpO/d/IOQ5aIh919iQ9i3Q+FDFOUWI4O2MP7vJxsnEPyzoKclab840sWfMi0ihc4JXnitVzBhBJD7Bgc9rWqDkrE0ICFKzROBq+v/po9KbQ8lPFIHtjTDfHJJGRyUyuYsVGa0OAYXCN4A+lPx68er1leYNJoot3ONkf
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:53:03.3388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a64b9d-3dc2-48af-f024-08dea5038eec
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB997906
X-Rspamd-Queue-Id: 1310948173F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10171-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]

Relocate the #include directive for k3-udma-private.c to
k3-udma-common.c so that the code can be shared between other UDMA
variants (like k3-udma-v2). This change improves modularity and prepares
for variant-specific implementations.

No functional changes intended.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma-common.c | 3 +++
 drivers/dma/ti/k3-udma.c        | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
index b419b23c401a1..0ffc6becc402e 100644
--- a/drivers/dma/ti/k3-udma-common.c
+++ b/drivers/dma/ti/k3-udma-common.c
@@ -2539,3 +2539,6 @@ EXPORT_SYMBOL_GPL(setup_resources);
 
 MODULE_DESCRIPTION("Texas Instruments K3 UDMA Common Library");
 MODULE_LICENSE("GPL v2");
+
+/* Private interfaces to UDMA */
+#include "k3-udma-private.c"
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index d9d6cbda46b2c..58cbb399bc3b2 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2857,5 +2857,3 @@ module_platform_driver(udma_driver);
 MODULE_DESCRIPTION("Texas Instruments UDMA support");
 MODULE_LICENSE("GPL v2");
 
-/* Private interfaces to UDMA */
-#include "k3-udma-private.c"
-- 
2.53.0


