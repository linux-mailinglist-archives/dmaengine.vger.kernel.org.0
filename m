Return-Path: <dmaengine+bounces-8604-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPMWFwOQfGkQNwIAu9opvQ
	(envelope-from <dmaengine+bounces-8604-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:03:31 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CE6B9B88
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B160300AC97
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 11:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E153637A489;
	Fri, 30 Jan 2026 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UDTWx2z0"
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E9378D7D;
	Fri, 30 Jan 2026 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769770998; cv=fail; b=tWmpVqvzv7kCN4UZJwYAcEVTcRFrS3a0i3+b5ih5ZIc7BwTiy7sVlBTZ1CVNscb+0FrjsqsWDw0O5Zj8FBpJ3Mw0EMNL/3gYjRsWIzFDe8VJT+NAPt7G8tCzCK/ENyKSmMRgsykF4/bAAHzCHIPitdqyeYdfTszK82FS/q79qd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769770998; c=relaxed/simple;
	bh=TFfvL+PsFafY8LmkNCnxSvieOZZIUP03CN9kyK0T5kg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bwwoNd7BZkmaNWmqVh17B7Cq41RWYuli6Mir2NfA9qR0r5eMaDbstr/iWezdjzZGtzD8xhG2zAGkPpwYuCFYGg4ikx5sHJVEP6k/hjSHnU47k96wYUEwkTOCbif4kdrEHwZBbZzsbbhIGOjFnzzcHBDdbd1rBFtQICaMvSIeebU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UDTWx2z0; arc=fail smtp.client-ip=40.93.196.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J60m5QdHR2cdEFViiGGEOqDrMuT97sZaUcUF3Z3LWhORk5pY41med8SYbPqIqE9upY74nO5dDBzmSr50mORCPBXtrAS+/iZx0/AS2XcbQI/W4YKub0rQGHCf4nPt/3GOGuD1vvSkohJrcg6rtfP+TjAx4BymXa2kCZA5xMUycD1ttz3Hniv6qmrV8aK1/ZPZUmmYMICkqEbqDK/YOAKHvbhFs0HtrZh+9g83C14JuZCk5PwABE1vSQC0jBye3FhDvGurCubVXyg/YE5rNRpC9Hn1gamEH/0k/dN7hz6JhynkM2+/sB3BAZA3RJg6Wrut2USGcXGbjAWbZH3JcpR4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2m98ddZ89hiWEYDEvhihOBUBnlsOJ4TJttEiVBMP44=;
 b=rgDnOpbYyuW1pdezf/vRnALBMnhfKBgnNJAUBesO4oHQmTK4Pvja/FxAqa0VWNtqakIYFZISDb4A+kxrpFtiGtJAM2vZ0PlH5pSVBRKJVXoxI8xKS1LqqC4GOJBYaPql3gqNOqx4gjsymtOs67U4ftD3mb57FpYrq6fcw2qEyfyHOxL9CnJgN4oLt1MIpU9Cha7QYMRvww062xW+zDzyUwHEPK9tzdrbwl/lFjoin29EkXwd0Mj+J1LFsdR60TNGbPE2LQ8TlzWstz+Z77zlk66ojlIsuuLeVdFP5wYbw6mf0jC/2qtNKCFMjLGrVodsq87HZpRM1NMCyBUJ7Wzh2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2m98ddZ89hiWEYDEvhihOBUBnlsOJ4TJttEiVBMP44=;
 b=UDTWx2z02Fsf3feeFm4oNbvFlemgou2nPEmM9Y3c5KBktq/o35hg1jdwgFR8rj949PncVCKZd8IEPDwyPkg4I//8i8eLMDh4pN/TRdaX8VocKmgxk+rEdIOXDxccmUG7vojUZteLTibHbaqscUNjY/8prFgEFGIFX0k+8ZorKzc=
Received: from BYAPR11CA0107.namprd11.prod.outlook.com (2603:10b6:a03:f4::48)
 by IA1PR10MB7336.namprd10.prod.outlook.com (2603:10b6:208:3ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 11:03:12 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::95) by BYAPR11CA0107.outlook.office365.com
 (2603:10b6:a03:f4::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Fri,
 30 Jan 2026 11:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 11:03:11 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:03:06 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:03:05 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 30 Jan 2026 05:03:05 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60UB2HBn1204392;
	Fri, 30 Jan 2026 05:03:01 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v4 10/19] dmaengine: ti: k3-udma: move inclusion of k3-udma-private.c to k3-udma-common.c
Date: Fri, 30 Jan 2026 16:31:50 +0530
Message-ID: <20260130110159.359501-11-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|IA1PR10MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc27c4c-67e5-4070-868b-08de5fef286a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IXvqJbNg3SMsh9oCAFy4mX+h9vZYq+Et4bP4yStFDNbk/FphJDjiY5z8etR+?=
 =?us-ascii?Q?/of8yiqdD/SxuPt2rsgdcO1dN7AI8cGNTZbkFQnY83FWZkDQUTdnRsYuBWza?=
 =?us-ascii?Q?JxIptYishCtSPQC4T8ADsGy3tpH1Ior7aZFvCPOe13yjImJl4sxfxYmjOXW8?=
 =?us-ascii?Q?1SKLvDcml+mtMdAG4qSwtW6hnGJ+AIqQzSIMvV5hKdIdtn86lk6TXTLWQHDU?=
 =?us-ascii?Q?4QsIPwAGejiPKypoYz6BqXufEYibJj3wg93hRD0Q/eN/HWgWnSC1Vf8rqrXy?=
 =?us-ascii?Q?1XMBmU3pBzBeQ4zM7NG4D9ZTb4PAHDfm56/BrOqhkaQxn/OBDlTXtyaa7FJX?=
 =?us-ascii?Q?jizEDQ9O4rZaN5ZTqN7jMFgMzXk3HhdI1Z2WxATS3p8kjB/IgtkAjb79IjVg?=
 =?us-ascii?Q?2uHPuJDtRanRlwvb1YHr9g/m4JSXHD23Xqy9dsDROIuN2TFX11ldK+Vo8a4T?=
 =?us-ascii?Q?0v0A9xaUUMz2DJxqCEB/FWjNmtaAnpiyMTWTUR8xzRvPJw/f1lj/6fIGu/Ok?=
 =?us-ascii?Q?3IzrwCXP+JRny+d8h/+Nk+Jtw4bzMVpdfX8jHu+05hd3u3Ylwr6E00a7E7pj?=
 =?us-ascii?Q?WZ2EdJ2XJwu4xw8PABkZ0yuS/znraXNe9M1sEHVRUy5yPuYt8RGOmpFMtnTM?=
 =?us-ascii?Q?7JDcuNQhnTt/UbXsqyyzwm7oxhK+MEZHHPbvIt3Zn0fLOY2cR04HtETclwIh?=
 =?us-ascii?Q?1YnbYaEQ/AE8ht4qrsDgxlfM47UVeWneTSPfuLAFNRxydvYG9c+vH6sQ/otw?=
 =?us-ascii?Q?zG/rgvwN2RmfGqRV2GLzTG3EFZTiMzaDRXnxyla/tE7glaKp2Fk7t9HF799g?=
 =?us-ascii?Q?uf4OPCDk5o3JinRcQvjX2AutKHk3DiaOtATlzh808XwrKwpDFusqvsDQ7cCK?=
 =?us-ascii?Q?ZsbzebC6Rh7w9pL5GS8VauyHswMbaFPKIhhr1tjOi4db3VQm3cnzxIuV9CgG?=
 =?us-ascii?Q?ORZnn/IUN8uA+Kkmik2yAjQZtvE5kg37twaxtfqTlOix/QR4IpsHY7ObQnu6?=
 =?us-ascii?Q?2JIQqF8LdSIHr96u3qbMPwehRSZaNeK2N/JX9AT4f+yAEYq94Xjs1Yqltvgs?=
 =?us-ascii?Q?sxUiVJfPtdaAafKdg1xlWOTaujHTCO0S1atH/V9Fe9j6YWMGcuuGbb0FdL67?=
 =?us-ascii?Q?2nVsh8j2cVvIupw/sUumQ8kzus0zf3UidJVXMV1PfdBGb5iI/2wRrtBe73O0?=
 =?us-ascii?Q?YXXOIvKRoih9phHV8o5931gt7EFxn3F7lwjrWT2z3YrYLwRrIV0OEbtPQe1V?=
 =?us-ascii?Q?dIw1s49rPm9FnUtqLvVeG0QcjnRxkTryGvea5OwbyYB37eTz95N8pcADV/SI?=
 =?us-ascii?Q?nYUr6PYRobw4HwCk2BFm5hUnRtBalpeUo4n3em7v4DBN7Db2+AHpK48LyUfe?=
 =?us-ascii?Q?kuoSzSh07XKHtVA/+hG63GXoXCBxKFCCijFpb650Vo8/cxSn33oQspLqkVgA?=
 =?us-ascii?Q?II6r2gU267avDBf4d6Ba6fjP06+eSHsSDAjKUPpKsgHFYm3VM9L6C69Nk6Ma?=
 =?us-ascii?Q?8wUNWMRU72RWZ6YJkwMIcuswrOx+yQHj6jrcRXKE+/M2Ixje2uOapaK4SJho?=
 =?us-ascii?Q?jDoHVclFBNJ1WqUdqrkvhxsoa5recwSsve0s6bOMq11IwYnExQv/Hj60NGWl?=
 =?us-ascii?Q?lOJu/TI0AJC/T6UfEAhua1iyDN8XUigAZOBgAxmuVZIU2GKVHbyKxvmsz64W?=
 =?us-ascii?Q?Mj6o3LHB6MFO2h3QGxHverx3orA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	17HAeVYQrisaNocXLtUPEcwN3rYu08zdqd+TbK5QtfP3X1/ZezOkHlIv2H6z7MlVI/H24peOjBJSN/Zw4DxUseIGXTQwfe+qbCZmxPRZeUpT5Ipgk0dyDAeF6+K441U8NnrH2T9qml7XT770eIxH5+qFBhSrHLrEih7ijTVuqpdNAhCDJhAb0vVCK06pwzsCSEyazl2e4lC5fYNnCQsXtwQlhTj73MLtIp0EW6DbyH/uU2H0Q3IC19bKq6WP648QKXycvUKAcPPp87ptlROO0UIY6WN2DGJrOoSyKIccr8UrfPK6Nw+leXSS5nObB1TRwquPAIB0Q7PCZltY/Fm0783vT5jCgAPh6HTVJVhpVdi110O8lKq58aGhHq05D547ClyclEWtEyOiuCfuQEcNgaW2WyF14r6gx0nk5l7tZdp283R851xmtAF/JSoxnLWU
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 11:03:11.1830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc27c4c-67e5-4070-868b-08de5fef286a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7336
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
	TAGGED_FROM(0.00)[bounces-8604-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 07CE6B9B88
X-Rspamd-Action: no action

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
index 83cf3d01f67fb..a8d01d955651a 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2857,5 +2857,3 @@ module_platform_driver(udma_driver);
 MODULE_DESCRIPTION("Texas Instruments UDMA support");
 MODULE_LICENSE("GPL v2");
 
-/* Private interfaces to UDMA */
-#include "k3-udma-private.c"
-- 
2.34.1


