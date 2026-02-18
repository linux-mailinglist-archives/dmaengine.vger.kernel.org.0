Return-Path: <dmaengine+bounces-8950-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCzxJxiNlWl7SQIAu9opvQ
	(envelope-from <dmaengine+bounces-8950-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:57:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 048BB155041
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB7CE303B7CF
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 09:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7BC33D6F6;
	Wed, 18 Feb 2026 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kLg2RYf4"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9158633D6E1;
	Wed, 18 Feb 2026 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408445; cv=fail; b=Bkmnx2XPaSTPhTivG5/lD7XggQGL9TPd8Mzt81lotLET0BV2X0axy0j6VVC0xKwm48o3+5eMxEiOCTlIJsQt+OWcTo1BHOc9JusGJPXRW7DNjAAqKx7ZNpz1eE9DKPBLZYLC3Y7kOrb8mEYxKNDnXHqEY51t9PWaa7hmkQq9+Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408445; c=relaxed/simple;
	bh=zZs1QG2+FOMaLJ9AQS8h4E4abMnWj0O4mpKWaks6VE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cxe0CmZeH+3UAOAJ6D3Zf/jeI9BqwJ5g/GxrbFJT+1sb1gbwEHVUY7kCTkDu3uwVP3Qa9oWuX73MGFb9npkIF93FybQFs+taYWPmk/W/itUl72qQvQcFZlqCYe8QbZ2ZZLA36FmJ3MSxd5KQ7bAGMm1EzhbE5DLitdqZVsFpfuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kLg2RYf4; arc=fail smtp.client-ip=52.101.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGPTmLBUeWuaVoS3x6bdLbOkKUnRiQaqntLIW6yHoQJqrWHXOpKXQ0J9+bHk0DOScYV/vSxRzKLosIYG6/MSvYda232JrlJhjuylVJUnVJyxNcH5pcXejZxrWg8FVeMbEIid+2riDZK4z3G3ViD7ag7VzZFfI7ahdAiledHQ4Ai33eRW25rI8/xBcXf8+VWslp/xMf8IOAVHduRveCVpRjZRCeL63+Bj9COGkVXNRWroDeZWMsiQpm1g3rDjRuU2gG5VJGSkkPEUAKFOweHC2vagpGr+JuQgFFvouANJwEi27mLK0r+zU38hNeaym9tST1/GVc2CC0iH5exSmTDuLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Vfut6LTTTN6NRsRAb8ysALKW+pWY5zz3y5Wdwu4dcY=;
 b=mvzr6eEB5ZBx+auX+E6eh1BSJl9/ICbZFGImBypYz0Dn3wr+CAOOSETBHAcJf70tuzZaXoIWDoh7UsANUrMSED6aiFMzJ1YnQXZna+/hhKXJQMOduMd08+5Wn63XRLx0j1fzhivFJMN0MsItZ23yca1PkKfVBkJ1dhfYOeBX0x9vsBDhJ9UIB8LeYC/dUEJzPyhG+pAgO+oqnmT4Nyb/pZYKySkPj3dKhB+7HU32BSStewHy5AfpHSo6MZz8J1KtZX3SQRfEPH7kNZJ7ErXdlx+mKiFBxwXFe3UNFl+iL3PzesTPYGlRIN6bDATkjPvoxXi1G3SySIvx3+RdpIHqgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Vfut6LTTTN6NRsRAb8ysALKW+pWY5zz3y5Wdwu4dcY=;
 b=kLg2RYf46BX+qhJnubDBj1tlZvWg9Jg9Jo6PpT3o/xE+U8E1EWHgsaKc8YqEIFv9thkoI/tNS9JXEXLZ7W25XukE/zjR7xPg47nA+X/nEhf7qqPiYf7+TGhGZ+iZJkhmJ4cGFdMtFRYIb5TRxDMNzCmr7UjJQ6VQ1gmJtdpmguA=
Received: from DS7P220CA0039.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::33) by
 IA1PR10MB7470.namprd10.prod.outlook.com (2603:10b6:208:453::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 09:54:01 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:8:223:cafe::a8) by DS7P220CA0039.outlook.office365.com
 (2603:10b6:8:223::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 09:54:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 09:54:00 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:53:54 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:53:54 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 03:53:54 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61I9qpIJ200561;
	Wed, 18 Feb 2026 03:53:49 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v5 12/18] dt-bindings: dma: ti: Add K3 BCDMA V2
Date: Wed, 18 Feb 2026 15:22:37 +0530
Message-ID: <20260218095243.2832115-13-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|IA1PR10MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0bc331-b07e-4c42-3d93-08de6ed3a3fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eczf7FDt4eABOBclZWVmz5tmiFbbD1v2gkBlu+g3yfaWnBhC+WGF9ozrQnlk?=
 =?us-ascii?Q?dwc4szOmlTYIbtmI45et2pESCAsv2POO3EDBZY229cVBl+/y6Z9s2V/575rK?=
 =?us-ascii?Q?gcJJuKXCJ3+S+5UzeNEyo3lZWL59qDTmi0ddJG7MyFW8O+7cMBfhSYMdRMOn?=
 =?us-ascii?Q?ph4rjBaUfgjSdfckwi4GrfY32S7gGXnsB0vb5rtm9Wypp3nhY+kYeTMMeQQX?=
 =?us-ascii?Q?yF/eIr7VkLgYG59ApIRalWPuzelHdL+xpHn/wv/QRylRco8DiCVnFaC45QdO?=
 =?us-ascii?Q?S6BGRHE5lnCt+mZUfXkTtcHUA6d6KWJOzra1CrX3Cu7ZWlcKIGtjZdvTLhgH?=
 =?us-ascii?Q?sDiuB+vLhTS0odOfI8EdG8TBsTtJ5dUobQm5Roj65K39nH1g93MB6IDr4v4r?=
 =?us-ascii?Q?XV+pZAU+MfAOlF0TCFVnNScJoGGLg5g9ETKoEgyTN05OCi7Ddiokkm+P7FCh?=
 =?us-ascii?Q?p2zDVqXn8zw0Jqhv0PJ+kVXjSa3yK0No8mqvIUVmPsrKEXXcwokSnefD1ard?=
 =?us-ascii?Q?P53kbtjUJIpuG42H/RiEN0XInxD5P+PSMdQ5tHNOS+BQcG4LnpPbmVsktgWB?=
 =?us-ascii?Q?lyhM6s0w6iNrQ6mm/KiVZblxH0wA3Iwv/t6Q58Ldjv89ut5gFaZ3ljAi6BEu?=
 =?us-ascii?Q?7Rw6XAqh1x/Mv+33O1n6f769wCpTbJwEx7PzkPI0RokLLKqX4Mw76i1C7kFM?=
 =?us-ascii?Q?EnvNShQ/E2f6z1Gpi6czOZlI36VSKsi4SOW5E6AgzU735MHDP+o3PSWwH0VI?=
 =?us-ascii?Q?kSLhYYjz9awnqbI/PF3SO7Lqu51y1j1owipviauuB5LZfNu+uj37Z/izeyb1?=
 =?us-ascii?Q?gtL9kh+B5BY7PqwemdTs0bnFP+YtZJwNNmKmOUdAssJDC57ywcujV1uyY/+C?=
 =?us-ascii?Q?NXQyZiEAXGhGAC5C1VF+xkmDSNZxM5lTbj23mtUVElqAFUywM5sh689kIH02?=
 =?us-ascii?Q?pKuCezvKI7mYZ8LWL/Pc2J0Gp6sHzhEdM6Oe87ZHeD+4u/0hDNCfs4grAPj5?=
 =?us-ascii?Q?n/ZeUpZNg7KBIjReZIlI+phD9sQlITnaBNeWhLCvQ7exC7D9oC6Z9yzsepuZ?=
 =?us-ascii?Q?RT+P0y0dJ/I4dgpBn1e03n+AdgeoO1HQ6G6LFITLPJj0EeluYCFFQOfzCHNC?=
 =?us-ascii?Q?TBuivXqCY3vcbH3XJ7oZpIuFVzHJL0W2hhOHquAwX0Mj0BJAfYqEhBpPoC6g?=
 =?us-ascii?Q?zAemQK+ZsoboWC/97QmHpou31BGXDDNVdgpV5jQLmqkfPP3AScDRR/WjE6Cc?=
 =?us-ascii?Q?QGHZI5kSeMt6VHpwBfiX1XSZYx1zcWNXRloeJA9VED6Z8vbKvoDOV53yTjV8?=
 =?us-ascii?Q?t0Pza86v7cPVkPHE+aL/uI2OUs31omefn7CIPprluhiCMOUDMuy1F3s8ucKj?=
 =?us-ascii?Q?ZXQPcTv99a1Kg4dGiX5bvPinsRHiLSM8761TMXw0IqK6otop7okN+zcOmIlf?=
 =?us-ascii?Q?rrzAvr/AqNIlkOn6dgAQarN2FAoVW1KwVqukzhhosy0qBEHOvpLU/iX68PjB?=
 =?us-ascii?Q?5sK4RnIJ7ClFub+jcT9/UEz+CJSzPv0s+FpRIYjSH44aebsXNY5um2YSMBD4?=
 =?us-ascii?Q?IAbYKAZGvV9D1YZ4wLQMqnorpJ2IYr40dFaUbULSJsAe19X4jPiNvv67CGLU?=
 =?us-ascii?Q?khvNxeKkHTSGuxWdzRmxkrXQ3qQHo6nOLZ3sIItpWp9DEweHkoKiP/xOxUbi?=
 =?us-ascii?Q?nM0+5P0kHVtyBRoHoNZap+WE3zc=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vM/7dqySq4gmi2nIxB4gWkDrtCImTAsvicW4bVXHsqf15CTN7y0g0QRAVtM2Fw+1DoHWJ1Rio2cDoL9YUFy+UtrBwZJgyKo3zDgWtSY36kkOV2CZKnW4n0dgXEGFNBxjO07BAU+zMLbZwbOCEvA4QABOKcuOEguBe/ghp0+bmoooq8EH4g2Ff1jF/NovIMHLpRam5+mEnumXztFW1lIH2S9awXhC9GIAhduT3QIfyLhKDquFD0RbmOioPvdwPYykN/JMkac1wNh9Uk18FqRA/ieK4uBwF5qVuFSqlys4xkrBFlk1uBctiZbOGOd5J3xqr2u35X1elUbgo1u2OsAEPzMCAGFDI5h0WARcphRYhhLhbRfwBWfXP5YJZ36yiK2aX11H08ijLFtGTDZuKuFm0G7kowpsIb1qEhJ/ZjpsSNnQU6n8Mou7lmC1CVIGKKpl
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 09:54:00.0399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0bc331-b07e-4c42-3d93-08de6ed3a3fa
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7470
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
	TAGGED_FROM(0.00)[bounces-8950-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim,ti.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 048BB155041
X-Rspamd-Action: no action

New binding document for
Texas Instruments K3 Block Copy DMA (BCDMA) V2.

BCDMA V2 is introduced as part of AM62L.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 .../bindings/dma/ti/ti,am62l-dmss-bcdma.yaml  | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
new file mode 100644
index 0000000000000..6fa08f22df375
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024-25 Texas Instruments Incorporated
+# Author: Sai Sree Kartheek Adivi <s-adivi@ti.com>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/ti/ti,am62l-dmss-bcdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments K3 DMSS BCDMA V2
+
+maintainers:
+  - Sai Sree Kartheek Adivi <s-adivi@ti.com>
+
+description:
+  The BCDMA V2 is intended to perform similar functions as the TR
+  mode channels of K3 UDMA-P.
+  BCDMA V2 includes block copy channels and Split channels.
+
+  Block copy channels mainly used for memory to memory transfers, but with
+  optional triggers a block copy channel can service peripherals by accessing
+  directly to memory mapped registers or area.
+
+  Split channels can be used to service PSI-L based peripherals.
+  The peripherals can be PSI-L native or legacy, non PSI-L native peripherals
+  with PDMAs. PDMA is tasked to act as a bridge between the PSI-L fabric and the
+  legacy peripheral.
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
+      - description: BCDMA Control & Status Registers region
+      - description: Block Copy Channel Realtime Registers region
+      - description: Channel Realtime Registers region
+      - description: Ring Realtime Registers region
+
+  reg-names:
+    items:
+      - const: gcfg
+      - const: bchanrt
+      - const: chanrt
+      - const: ringrt
+
+  "#address-cells":
+    const: 0
+
+  "#interrupt-cells":
+    const: 1
+
+  "#dma-cells":
+    const: 4
+    description: |
+      cell 1: Trigger type for the channel
+        0 - disable / no trigger
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
+      cell 3: Channel number for the peripheral
+
+        Please refer to the device documentation for the channel map.
+
+      cell 4: ASEL value for the channel
+
+  interrupt-map-mask:
+    items:
+      - const: 0x7ff
+
+  interrupt-map:
+    description: |
+      Maps internal BCDMA channel IDs to the parent GIC IRQ lines.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#address-cells"
+  - "#interrupt-cells"
+  - "#dma-cells"
+  - interrupt-map-mask
+  - interrupt-map
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    dma-controller@485c4000 {
+        compatible = "ti,am62l-dmss-bcdma";
+        reg = <0x485c4000 0x4000>,
+              <0x48880000 0x10000>,
+              <0x48800000 0x80000>,
+              <0x47000000 0x200000>;
+        reg-names = "gcfg", "bchanrt", "chanrt", "ringrt";
+
+        #address-cells = <0>;
+        #interrupt-cells = <1>;
+        #dma-cells = <4>;
+
+        interrupt-map-mask = <0x7ff>;
+        interrupt-map = <49 &gic500 0 0 GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
+                        <50 &gic500 0 0 GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.34.1


