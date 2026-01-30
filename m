Return-Path: <dmaengine+bounces-8606-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBiaIQmQfGkQNwIAu9opvQ
	(envelope-from <dmaengine+bounces-8606-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:03:37 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E6EB9B98
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F2843008263
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 11:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220CD37AA78;
	Fri, 30 Jan 2026 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="po8X2p0Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192483793BA;
	Fri, 30 Jan 2026 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771002; cv=fail; b=lMBa/baupN8wi8Dm53cHhUnXDCSTngB1lC2WP2TOxTL5FR538jzjPmY11kSat9QzPuphJZy4UsRMm1eSSRtxe0nGYJNQloaNRwoVNa7Uczw8O3ZUgKR4Yv6KytkLXmCHn5XCPmbfWSO9Nq3byJkkU2YQVm+bm3vVowpJFSijeZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771002; c=relaxed/simple;
	bh=c/H08gxFjJ2Fi7E/YHt5MqJKHlp5J3fmjkHbXsmJU5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaRG58Ij4A7WXsSvBN8pbW0jaB0o9Ijx9hjAGOiV+Y5bQcsM3Ss81t/eu6GqYUC0IyX0AeXCKEBSM1eJYK4CtJklYNypgli0vgzzexBJyJPwCgzfRupk2SHBg6/uMne3xGGEtG5VngebdOqUF56wblALeHHRc0chjec6e0X66IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=po8X2p0Z; arc=fail smtp.client-ip=40.107.209.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngavYS/BhQVqA2GJISSenDwK0Dv/LmvPpAakHi9FXLcekB8mc6oYUONlo6lMCoSenUH+rWqpEWhknOhWWeQAFgnAVc90lrf9O9PMwGmiSFvetG9JvSjE9YkAC8qSjMjPUbJmr9rxM6fWfsOOAQKXdHKptDDgl136Gxza4pnbKnQhIKdRS+fG8XouD9C46hMonLdOhT646TPxpT4DD2eQyL8YM0t9TtTVpQFIr6Nfz7oylD1/4puvXmUz+VrgKI1PZl039mYY680CJz7ow6eyp/G3izFN8gMSq5FCZKe10zyq1phZlVxIz/e888oxl4GYgexjWaItcalbGkdsIvi76w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGJ2zcyQk5gamoiO5PCb8dgOL5lmyv5Qi7hs4JxXy3w=;
 b=DoYSAGQo2NiLzfRFlFoSvP12Bot3NRD3xiM2xGuu9Keq1yxFMtbEUEMD9O8BGJ6SnN31HMwzpRip3FqaW5MS+o7OJTPcdzPO7qaqfwkXgRn40QgLz9Odrpb1tv7+vOrwvJBFPt8sFvhgfygJ8DXO5rf7VlGQAB9Sy914TVlnxBkAsdaCn2tFGI9ySyxS63c0Lsnure6YAouulmVWJTCn+HZKkXmpKhcKB2uIiM6uIodszQSoxTc8ZtmXqu+kPfi/AfOSAmTHxco3ANZQKvtDXi1xcPKZoNAXrtSVhSCWP+jdGpFqT4o7brRMAQvR5Eds3ddUWY0eOmh6sRhvlpPCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGJ2zcyQk5gamoiO5PCb8dgOL5lmyv5Qi7hs4JxXy3w=;
 b=po8X2p0Z9x1huZULdSKEe0Fo+8D8y4GJdxoWH/IWjScKejbU8tWJdPL7Qy5IKqBafZ+0+P9eU3JAGzH4hjaE4sBoJD7fpsEKGNFzN3vW6i2+KSy0920Q4VcVE7zc2rwO/LKoiqm20CVlZ3QbOxmy2HxaksImucOpvD7q713QpH0=
Received: from SJ0PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:33b::35)
 by SJ2PR10MB7112.namprd10.prod.outlook.com (2603:10b6:a03:4c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 11:03:17 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::df) by SJ0PR05CA0030.outlook.office365.com
 (2603:10b6:a03:33b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.4 via Frontend Transport; Fri,
 30 Jan 2026 11:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 11:03:15 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:03:14 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:03:14 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 30 Jan 2026 05:03:14 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60UB2HBp1204392;
	Fri, 30 Jan 2026 05:03:10 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v4 12/19] dt-bindings: dma: ti: Add K3 BCDMA V2
Date: Fri, 30 Jan 2026 16:31:52 +0530
Message-ID: <20260130110159.359501-13-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130110159.359501-1-s-adivi@ti.com>
References: <20260130110159.359501-1-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|SJ2PR10MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: e968c592-d3dd-4f6f-1920-08de5fef2af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qOQBi/GxvODEnii3gpZLghdCP1nipynreCsfN9ICU+eBRjFpstgYajCe+2Sx?=
 =?us-ascii?Q?5SjllQ8XIcC/VrefnFM2NYWB6HcVK0vT7aWcVSFBgNlIZTcGgLZJEXt4SqWl?=
 =?us-ascii?Q?Hw5VjFoh3eBaMAAAY9NNaSme2tRFXUjK54lYSbY9qVjYJw0t0O/JkNxsr1K9?=
 =?us-ascii?Q?H+WcKXdE1+Qqr6v6BJ7RW/RJbXVy4uCx4NG/NONeTGrHVjbBiAQ5fYfRA5PT?=
 =?us-ascii?Q?M9Zy6BJsr3GQDxIC0chCVNQAKANvFaOjujyZDyUiN5QjnRj8BchRV3dqO+O5?=
 =?us-ascii?Q?fhWzjiwyhNXlkM0eHSX7RxcMP0f7trMy3NYZDsmc2zKs6NuTyIPbMMWR76DZ?=
 =?us-ascii?Q?HPhDuq+jbe9r5y6bvb5C3XajnrmTQufpq6CMdtuIWZ8dFie9G/ChZUUA68tp?=
 =?us-ascii?Q?kEX6yqqmbEFahtOlN7wd09lUs7Pw84Qpfjrln93jltuUDc520Cs3FZnB9K1n?=
 =?us-ascii?Q?Q/0liADuISZXk2XiaogmmSXEwyWamCMVXzIZdjGd61f+9Nk3tyfAv8Vsvo0Y?=
 =?us-ascii?Q?KuzMwT61jAOasUaCVBNEH+vDl7Xna6zFmFHEAVkZvY5E86BpbrHubCen6y35?=
 =?us-ascii?Q?1Pk2hc8RlDZTN3N343Vk6g5UpEU2xxkwxRsmHmb9UVGizigXvIMiQYWet+6E?=
 =?us-ascii?Q?1729DSHMwLL1Rt1CTlY/mAAu4y2hMeDrCkLeOIyOnk80jxCyJslYJrx8xmrF?=
 =?us-ascii?Q?NPH5u5mNlsYyF4vst7iNgVxHaEf51TmM5duIuRHYZVwLpbEzrVGm00AtSFzO?=
 =?us-ascii?Q?dAtpV7LBegHKucv+tBR9Z6CV1KgCpRk0sfCyYxoOjWMddd2Ym5cXLk+H/tSP?=
 =?us-ascii?Q?pdKNgYPyKvd+JzwetCmMbJ5rO5p0k7oQ7zgMhmQqI/71Kml0G3Xk3KGfxlSz?=
 =?us-ascii?Q?YSBtbyrOrlw0HOSBKxnlW5tSb3oSjos+nhVE6f1s/SW5G5TevlDQ7PzmsEk9?=
 =?us-ascii?Q?QBXtOz3rTTUQgwv7sUyNVhIix40jCdg5I5Drg40Ust9gwm+qtQTbTLhBpcxC?=
 =?us-ascii?Q?K/utny1bwGTyExlgXPSMWS4D11erO4f0UHSwNHen5at8wapnf5Z+DBB4izbg?=
 =?us-ascii?Q?RMSCBF91Sg1UqV/yPoBQnw+Icl5N78+KuTwa0y13fYrYRZLRWXGirl55s2Lp?=
 =?us-ascii?Q?gQP+a8CqfTQyAhWm4Ldw3N4VTIouvyRhUCEfynt0erS+DzM/3mdWkBv8cko/?=
 =?us-ascii?Q?1uEbukYNGrfP1ElVZT2ePzI6xkCOKO+12bOf8bmliF9ah2TTOjBl8ITP7l8m?=
 =?us-ascii?Q?Qw+T/v6n+rDOwIxIaNvs3JJAX/4EErDAKRheGm1mA06gKCYg9+KQ6Jmgr/Mv?=
 =?us-ascii?Q?1Lzw05voiupBEFsiHWjT7uM1DJLhnNkzOA/Lg1PxSql88hmVhaDQQRDQTvd4?=
 =?us-ascii?Q?Pgd1IoR3c54CJI835R1wzqtquaduLHIFVxfWk18U5I3SuMBTgwB8hkmoM5rt?=
 =?us-ascii?Q?qlUHJoGVZMMzDEX+jsXLgiaF5oTio2z5gLqQnxkvdJVQUoLi66iLmw06Erq0?=
 =?us-ascii?Q?txq/sIZRVTXBCTAFoKRKlxPHvBWIdqHEM6C77DLyqDarQQMEN6LRJd65kGqB?=
 =?us-ascii?Q?VFeG/ZkqWaIgRnFJ58oxkXeeHEsQpjOec4yRhr/wxSduCYKe1fxOc3NwPbqb?=
 =?us-ascii?Q?+FhL9bNq8v+M45vMwLXIiYQ=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+ztJlR/21rNWuT6BMAeWam77K7Wyub/NPfVrOeUI+6vgE0BUdE8tXii9bMz77++ExHL73cVvUgXD72C1BmEW2sz7bP0l4pXFGcEHFXUBxOfrY0jZ3+wLylxym4S073H4IBQG5oud/qoSbQmsQGtW7D9OsvcUAi8SDPhEOV0wOMdJj8ukAyzvaG+sv4F4Ssh7wHByUZCHpoMZjnWrO7t1dDy7IyCwe0vKH5T6M5t6LeJLhAFQ+FIU0XGRqNslkvATQKSvhNIWPF6Ej/MY7e1il1V/KYawaFSSDy0u0NhLD1/sEnha+70IRqhBkWQgqw1b3ZQwfg/0QP8Jb/sAEnF7bxDE8x5O+g+5BNDp/5i1d6S0/JwYlhykicwIkbUwCQpqFOCIbZDb9ab1E0XHDg6ycUtufX7Z7PVVeT2ZZhYSlzQhEBKlV0Q6qUR1DvMuib75
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 11:03:15.4443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e968c592-d3dd-4f6f-1920-08de5fef2af7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7112
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8606-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,ti.com:email,ti.com:dkim,ti.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,2.110.143.0:email];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 28E6EB9B98
X-Rspamd-Action: no action

New binding document for
Texas Instruments K3 Block Copy DMA (BCDMA) V2.

BCDMA V2 is introduced as part of AM62L.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 .../bindings/dma/ti/ti,k3-bcdma-v2.yaml       | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,k3-bcdma-v2.yaml

diff --git a/Documentation/devicetree/bindings/dma/ti/ti,k3-bcdma-v2.yaml b/Documentation/devicetree/bindings/dma/ti/ti,k3-bcdma-v2.yaml
new file mode 100644
index 0000000000000..b0bfb19ba863a
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti/ti,k3-bcdma-v2.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024-2025 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/ti/ti,k3-bcdma-v2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments K3 DMSS BCDMA V2
+
+maintainers:
+  - Sai Sree Kartheek Adivi <s-adivi@ti.com>
+
+description: |
+  The BCDMA V2 is intended to perform similar functions as the TR mode channels
+  of K3 UDMA-P. BCDMA V2 includes block copy channels and Split channels.
+
+  Block copy channels mainly used for memory to memory transfers, but with
+  optional triggers a block copy channel can service peripherals by accessing
+  directly to memory mapped registers or area.
+
+  Split channels can be used to service PSI-L based peripherals. The peripherals
+  can be PSI-L native or legacy, non PSI-L native peripherals with PDMAs. PDMA
+  is tasked to act as a bridge between the PSI-L fabric and the legacy peripheral.
+
+allOf:
+  - $ref: /schemas/dma/dma-controller.yaml#
+
+properties:
+  compatible:
+    const: ti,am62l-dmss-bcdma
+
+  reg:
+    items:
+      - description: BCDMA Control /Status
+      - description: Block Copy Channel Realtime
+      - description: Channel Realtime
+      - description: Ring Realtime
+
+  reg-names:
+    items:
+      - const: gcfg
+      - const: bchanrt
+      - const: chanrt
+      - const: ringrt
+
+  "#dma-cells":
+    const: 4
+    description: |
+      cell 1: Channel operation mode
+        0 - split channel / no trigger
+        1 - internal channel event
+        2 - external signal
+        3 - timer manager event
+
+      cell 2: parameter for the trigger:
+        if cell 1 is 0 (disable / no trigger):
+          Unused, ignored
+        if cell 1 is 1 (internal channel event):
+          channel number whose TR event should trigger the current channel.
+        if cell 1 is 2 or 3 (external signal or timer manager event):
+          index of global interfaces that come into the DMA.
+
+          Please refer to the device documentation for global interface indexes.
+
+      cell 3: Channel identification for the peripheral
+        if cell 1 is 0 (split channel / no trigger):
+          PSI-L thread ID of the remote (to BCDMA) end.
+          Valid ranges for thread ID depends on the data movement direction:
+          for source thread IDs (rx): 0 - 0x7fff
+          for destination thread IDs (tx): 0x8000 - 0xffff
+
+          Please refer to the device documentation for the PSI-L thread map and
+          also the PSI-L peripheral chapter for the correct thread ID.
+
+        if cell 1 is 1 or 2 or 3 (MEM_TO_MEM and/or trigger type):
+          Unused, provide 0.
+
+      cell 4: ASEL value for the channel
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#dma-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    main {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        main_bcdma: dma-controller@485c4000 {
+            compatible = "ti,am62l-dmss-bcdma";
+            reg = <0x00 0x485c4000 0x00 0x4000>,
+                  <0x00 0x48880000 0x00 0x10000>,
+                  <0x00 0x48800000 0x00 0x80000>,
+                  <0x00 0x47000000 0x00 0x200000>;
+            reg-names = "gcfg", "bchanrt", "chanrt", "ringrt";
+            #dma-cells = <4>;
+        };
+
+        crypto@40800000 {
+            compatible = "ti,am62l-dthev2";
+            reg = <0x00 0x40800000 0x00 0x14000>;
+
+            dmas = <&main_bcdma 0 0 0x4700 0>,
+                   /* rx: Split channel, no trigger, PSI-L thread id, ASEL value */
+                   <&main_bcdma 0 0 0xc701 0>,
+                   /* tx1: Split channel, no trigger, PSI-L thread id, ASEL value */
+                   <&main_bcdma 0 0 0xc700 0>;
+                   /* tx2: Split channel, no trigger, PSI-L thread id, ASEL value */
+            dma-names = "rx", "tx1", "tx2";
+        };
+    };
-- 
2.34.1


