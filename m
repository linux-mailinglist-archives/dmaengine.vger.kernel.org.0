Return-Path: <dmaengine+bounces-8945-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLX9IFGMlWlhSQIAu9opvQ
	(envelope-from <dmaengine+bounces-8945-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:54:25 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD69154F19
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BC1630095CB
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 09:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AFC33D6F8;
	Wed, 18 Feb 2026 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WfPFUJOQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013070.outbound.protection.outlook.com [40.107.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0FB33D6E1;
	Wed, 18 Feb 2026 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408419; cv=fail; b=PGzXc0Bdepu1PcarMg1Mr/p1o+x2cmCzkZxIjjghNvwD9cX4h5wMzDUwvVxuPqmqnPgBONKf4pnalWYlyXa7LY+MWyf6AvJEoLs8OcCjLT9Z8aKeRpzmXSGcI9aeU/0UCM38cC/VUb6TN1SvzwKFjHWzdLCtQu/V6KtQRESI9XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408419; c=relaxed/simple;
	bh=wFbtxU9Ezc5ijfHFCJg2pDTN6coI4ZWFoQM85diQUbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYDed0O3pDgZTEWt5j1W37ps6hrPJwJ2AGyP6+809HaYd98fm5fLJeNaewLZVfNUbcjvUNhJ6x2exPTSIhUooL/nbfiCHRWYpd1AkzsqQ0JVnDRbu1lLMd3k5aE4KnGzsPIqPozeeAXVI70Ruy1zK2XjnOT4zDy7IfMEGCB/jdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WfPFUJOQ; arc=fail smtp.client-ip=40.107.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIVrsAyGy8erWulkeyVsaRRNrsOp+Q1oUgxYpTAkgWAzRruSnPFgbNZemP8e0y3yijP57naMIZhhvpLsjn4JE0sFLte+0uGH0R7AFU9rQr7dwFCXARbrfkSZH0gfUNx+kDHRu0qSJYgSC51r9scFu5Ow9ixZXOr6PPpS/sfz//EoNpJ5mjsP2FfCN8clN1YQ8U5+WXX1FhwmzfKW7yb1NvkcEoWUKi3gVPPyXhJwonwpUe2UzkKX8KLQIdpWXTvSeB3SUVMq4eY3oyHUeq4NOzJfh/mAse7B7og/MolY95FRfh7AK0+L9Ftm5VmBfikl3P9aHU0otgLukt1UoRtWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itOFzPckacMWe0+jTNOoRqOC5YFLcK7FMnzwb6K59T4=;
 b=ufEKFYL7AqigWQcXLKDRPAbj+ueRpwZqUQofMZX5Kcvudl3bgQc3x6swmR0dFMyHpJ7mJuLKNhS3UyYvQKEf6KvG9UMLGDoDBFoI4xgtoZZOw4PxSbWWkFfk/6MqV7a4a/cVsLBujpMS0n9wQ3Hd7s37d0ep6DCVEZud2z1EMi/cxGe5YlKwCtHN/zaFP7FvDEtXSJD7VYLIlV/si4vWzh+/U/Zq2pZUKUa48BToIYIJQ/XrorrrTDwia+z/OkwihsHhQ0FhutCEeR5zbzIXLJysnGUtAw3fdcGIOiVV72U6aFvuLr+LIH89Cjf/RqTlUD/SFhPdLNMoM30ZOT400A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itOFzPckacMWe0+jTNOoRqOC5YFLcK7FMnzwb6K59T4=;
 b=WfPFUJOQ+EiEzfFCJUwy8yVQOKUQe8FFyJ28W9RcKxYWz1wrpAaAgm8gTegFfg0W2p4XPdCLiplmvOzh9ljgsfD6pUavv5Oc54QnxeB+1qMm7zLLHJkwZduq9zR9WB0iVFKJRl7vE8TCqnce7L1ISfo9x6w1kGI/3YvxqDafHDs=
Received: from SJ0PR05CA0151.namprd05.prod.outlook.com (2603:10b6:a03:339::6)
 by BN0PR10MB5112.namprd10.prod.outlook.com (2603:10b6:408:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 09:53:32 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::aa) by SJ0PR05CA0151.outlook.office365.com
 (2603:10b6:a03:339::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Wed,
 18 Feb 2026 09:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 09:53:32 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:53:30 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:53:30 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 03:53:30 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61I9qpIE200561;
	Wed, 18 Feb 2026 03:53:26 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v5 07/18] dmaengine: ti: k3-udma: move udma utility functions to k3-udma-common.c
Date: Wed, 18 Feb 2026 15:22:32 +0530
Message-ID: <20260218095243.2832115-8-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|BN0PR10MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc03e81-2ed0-43a8-f816-08de6ed39364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0yGo9T69uDpXs7FzoCOE99y3o0gdzlkMVwQZ8WTNBFmXS12/VaKTnQRhTAfE?=
 =?us-ascii?Q?3qDryfdbpeoyQhNsNkLPmD6Ul2YnSXqFb1UOwrCQoS7dZDpbW4WVyKm9n5sT?=
 =?us-ascii?Q?19ATuNpmAZHTu5BFXVTbIRsSsrEL/mimv8CImFG0hV2ICQ4FUrsqdHNX1wYY?=
 =?us-ascii?Q?hs9rfqGv8ShloTpK2bikoROw6rwJE7BPd6zTT6YnIhLKkJJlMQK3YWktJLH2?=
 =?us-ascii?Q?hjEPZExjAaAy+u5FlB10Mka9B5VBVOvBFej2Ew7/m5yRV3xRCdwxEls3IC7+?=
 =?us-ascii?Q?CH3QdOZlv07M5cGiY8noQy6E1QJPbF+lbwLLlHBqePOfFaBKDX+AQ5+zBRP3?=
 =?us-ascii?Q?a4MVYSsBWBhnQdPPWTkpP4VWZjQ6nIgpp0QV0sVlKzKBp7kYnXj9xhwZZn8j?=
 =?us-ascii?Q?qTu8XnNOdJIoHPw+AxqZb+JmpuBVjkfDKyYa42JUNJmds4hNKe1snI7PHNlu?=
 =?us-ascii?Q?udEWQGIksi+0z/4vlK/uHzPQJ2+CK163qTVPgdBwU6LcvOnmbpM0zuyxTAWy?=
 =?us-ascii?Q?hnKCNEMl3CgDZVPLJdnEHqgFfkfPRgDS8jX4nGz/DkcdsJwk2Kl2TYTF/vdi?=
 =?us-ascii?Q?qbJZLD3TJbE6XMVGNOtgNPTkHSPxShtFiHCFbLJ2RzjhhPWEqTsqnSyrRExC?=
 =?us-ascii?Q?4AKgdAUBzMlyu44tjcEnMxnsJvBF8BYpp8Qk+wIoddbm3ekOQRDT7ukgdhOy?=
 =?us-ascii?Q?GTNy4ivSjJiyTyhFNUHNd98hvHkMPE+q/5I3nLX+TSMFRgzfpBtTkktXPAt5?=
 =?us-ascii?Q?a0yYhTlVNBxBEwJrcmADTd/3ruSbdEva0iu9nFf+2n+PJYGE25HneG83ZIrF?=
 =?us-ascii?Q?jTVpKtre28Pq0dG1osOH9bxWoEXm2sIH/sauBHMeLjt/y6BVf+szJO72V4e/?=
 =?us-ascii?Q?kU6EmjwL6J0im0S3lg1WSHZKr/bK1udaQ2lsJXD4y7UH5sQwxSAmAs0FZR0k?=
 =?us-ascii?Q?YSONt9OH7uTIaS6srRUXgGecAvQ1V4WCkpE2ybGxKe1wPCYmftTs4xQBFg3I?=
 =?us-ascii?Q?nr8xO9sLIxVi/r/ZfgioFIvkwah8zTy0k/Nmqs3H6mH2k1N74LxO5rbB1Ak9?=
 =?us-ascii?Q?iIWxjQDfFwdNedcqETpx5pardeiVP3zx/Wbfaf9jHiVl3Il0z/wfLGsLIUQx?=
 =?us-ascii?Q?OAALtuUjXmWVH8JabmN7QctvU1WV9to6NNnzW8H7uxSDK4xbb6ItSQO4u83j?=
 =?us-ascii?Q?1/hoN3QX/UAAuIF4F1Kjsoh+bs8uAqD5fOiKQyUWX0nNmSOng5/k8wu/xS50?=
 =?us-ascii?Q?Cd9w8sK3ptzcCJNaTMyfq4s69FCtPfuaU2NBdCTv5VxnGxt+dT/Tx/dmGxeJ?=
 =?us-ascii?Q?b4rfF85wL0JhX/uGq1rmkPyRXZRCcjgXXc3te1gTe+Xb6Lsn683VeI1lHjDv?=
 =?us-ascii?Q?qkbVE9iMlELId0TeA8Q+fPq/rn7AqLTa2Kp0PcdzNotURA1UytIDit1ngdt7?=
 =?us-ascii?Q?ajPziiF1ICCM8vayinplJ6zzxt6fuz3xEUAmCzKJIlQNRPworSBGDsM7l6Ww?=
 =?us-ascii?Q?B9uEvkywayc3rrP18BuZAtGclQl2E9KmjbGWhwQCx8yLC2ohmhznW9R9wPIQ?=
 =?us-ascii?Q?Sk9e9TDn0VRbBhX0zpfpN746HLTsbWY9hzk6ZtzSpuy/Ywhr0H0DUrcGzwaa?=
 =?us-ascii?Q?RjFCOenn1EA9j++uTwk6O6aihbSpc9ohLbFx2JTbqktkaYfTK64CMu4Cgtki?=
 =?us-ascii?Q?Qg8zUKMRO5TnqfVDFURRMaqkju4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X47jliX2A7cMoChQ3BMZTd9D930QoeQkGIcK+5cSUrBhbe7CWmujPfF4vKpITi/+suzYy7SWrZ24Cwm7qE7qgAq45ui/Ojc1xhp7qie/KyJ632X/ZwpEDA64djnB+v2M/Eop5g7LNDnZW/WXjkzMTbLwP38qJjdEdih40hzYOR13B67akkq2bQmuw7YTl+m5Pwxo5d49tX8lsE9nxJMlS/pxgtQm83pEWKY7xba13Mf3TdiYFX5dnlA8DQpwqYx5CFfeG0U6X8zGZqyPTt6rgVdYc2cJ3sf8e16mB6c/CtVUQrm2jAf+D6uDiiNzkn9V3vxcL6M260iCYwVGJxXF7n0zZMPKWI0PM+EuKeZfGsXl/0kHWlHkOBwx9/Q3RtWWoPHk/h7FWpsLfWKUZwbaJ1cZJJaaQm5aeTp0mGjK8xnXgRq9zupM4X33BZyZHcn5
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 09:53:32.1822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc03e81-2ed0-43a8-f816-08de6ed39364
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5112
X-Rspamd-Server: lfdr
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8945-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:mid,ti.com:dkim,ti.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,work.work:url];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6BD69154F19
X-Rspamd-Action: no action

Relocate udma utility functions from k3-udma.c to k3-udma-common.c file.

The implementation of these functions is largely shared between K3 UDMA
and K3 UDMA v2. This refactor improves code reuse and maintainability
across multiple variants.

No functional changes intended.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma-common.c | 549 ++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-udma.c        | 531 ------------------------------
 drivers/dma/ti/k3-udma.h        |  28 ++
 3 files changed, 577 insertions(+), 531 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
index 4dcf986f84d87..472eedc4663a9 100644
--- a/drivers/dma/ti/k3-udma-common.c
+++ b/drivers/dma/ti/k3-udma-common.c
@@ -4,6 +4,7 @@
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
 
+#include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
@@ -46,6 +47,28 @@ struct udma_desc *udma_udma_desc_from_paddr(struct udma_chan *uc,
 }
 EXPORT_SYMBOL_GPL(udma_udma_desc_from_paddr);
 
+void udma_start_desc(struct udma_chan *uc)
+{
+	struct udma_chan_config *ucc = &uc->config;
+
+	if (uc->ud->match_data->type == DMA_TYPE_UDMA && ucc->pkt_mode &&
+	    (uc->cyclic || ucc->dir == DMA_DEV_TO_MEM)) {
+		int i;
+
+		/*
+		 * UDMA only: Push all descriptors to ring for packet mode
+		 * cyclic or RX
+		 * PKTDMA supports pre-linked descriptor and cyclic is not
+		 * supported
+		 */
+		for (i = 0; i < uc->desc->sglen; i++)
+			udma_push_to_ring(uc, i);
+	} else {
+		udma_push_to_ring(uc, 0);
+	}
+}
+EXPORT_SYMBOL_GPL(udma_start_desc);
+
 void udma_free_hwdesc(struct udma_chan *uc, struct udma_desc *d)
 {
 	if (uc->use_dma_pool) {
@@ -1342,5 +1365,531 @@ void udma_reset_rings(struct udma_chan *uc)
 }
 EXPORT_SYMBOL_GPL(udma_reset_rings);
 
+u8 udma_get_chan_tpl_index(struct udma_tpl *tpl_map, int chan_id)
+{
+	int i;
+
+	for (i = 0; i < tpl_map->levels; i++) {
+		if (chan_id >= tpl_map->start_idx[i])
+			return i;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(udma_get_chan_tpl_index);
+
+void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel)
+{
+	struct device *chan_dev = &chan->dev->device;
+
+	if (asel == 0) {
+		/* No special handling for the channel */
+		chan->dev->chan_dma_dev = false;
+
+		chan_dev->dma_coherent = false;
+		chan_dev->dma_parms = NULL;
+	} else if (asel == 14 || asel == 15) {
+		chan->dev->chan_dma_dev = true;
+
+		chan_dev->dma_coherent = true;
+		dma_coerce_mask_and_coherent(chan_dev, DMA_BIT_MASK(48));
+		chan_dev->dma_parms = chan_dev->parent->dma_parms;
+	} else {
+		dev_warn(chan->device->dev, "Invalid ASEL value: %u\n", asel);
+
+		chan_dev->dma_coherent = false;
+		chan_dev->dma_parms = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(k3_configure_chan_coherency);
+
+void udma_reset_uchan(struct udma_chan *uc)
+{
+	memset(&uc->config, 0, sizeof(uc->config));
+	uc->config.remote_thread_id = -1;
+	uc->config.mapped_channel_id = -1;
+	uc->config.default_flow_id = -1;
+	uc->state = UDMA_CHAN_IS_IDLE;
+}
+EXPORT_SYMBOL_GPL(udma_reset_uchan);
+
+void udma_dump_chan_stdata(struct udma_chan *uc)
+{
+	struct device *dev = uc->ud->dev;
+	u32 offset;
+	int i;
+
+	if (uc->config.dir == DMA_MEM_TO_DEV || uc->config.dir == DMA_MEM_TO_MEM) {
+		dev_dbg(dev, "TCHAN State data:\n");
+		for (i = 0; i < 32; i++) {
+			offset = UDMA_CHAN_RT_STDATA_REG + i * 4;
+			dev_dbg(dev, "TRT_STDATA[%02d]: 0x%08x\n", i,
+				udma_tchanrt_read(uc, offset));
+		}
+	}
+
+	if (uc->config.dir == DMA_DEV_TO_MEM || uc->config.dir == DMA_MEM_TO_MEM) {
+		dev_dbg(dev, "RCHAN State data:\n");
+		for (i = 0; i < 32; i++) {
+			offset = UDMA_CHAN_RT_STDATA_REG + i * 4;
+			dev_dbg(dev, "RRT_STDATA[%02d]: 0x%08x\n", i,
+				udma_rchanrt_read(uc, offset));
+		}
+	}
+}
+
+bool udma_is_chan_running(struct udma_chan *uc)
+{
+	u32 trt_ctl = 0;
+	u32 rrt_ctl = 0;
+
+	if (uc->tchan)
+		trt_ctl = udma_tchanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
+	if (uc->rchan)
+		rrt_ctl = udma_rchanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
+
+	if (trt_ctl & UDMA_CHAN_RT_CTL_EN || rrt_ctl & UDMA_CHAN_RT_CTL_EN)
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(udma_is_chan_running);
+
+bool udma_chan_needs_reconfiguration(struct udma_chan *uc)
+{
+	/* Only PDMAs have staticTR */
+	if (uc->config.ep_type == PSIL_EP_NATIVE)
+		return false;
+
+	/* Check if the staticTR configuration has changed for TX */
+	if (memcmp(&uc->static_tr, &uc->desc->static_tr, sizeof(uc->static_tr)))
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(udma_chan_needs_reconfiguration);
+
+void udma_cyclic_packet_elapsed(struct udma_chan *uc)
+{
+	struct udma_desc *d = uc->desc;
+	struct cppi5_host_desc_t *h_desc;
+
+	h_desc = d->hwdesc[d->desc_idx].cppi5_desc_vaddr;
+	cppi5_hdesc_reset_to_original(h_desc);
+	udma_push_to_ring(uc, d->desc_idx);
+	d->desc_idx = (d->desc_idx + 1) % d->sglen;
+}
+EXPORT_SYMBOL_GPL(udma_cyclic_packet_elapsed);
+
+void udma_check_tx_completion(struct work_struct *work)
+{
+	struct udma_chan *uc = container_of(work, typeof(*uc),
+					    tx_drain.work.work);
+	bool desc_done = true;
+	u32 residue_diff;
+	ktime_t time_diff;
+	unsigned long delay;
+	unsigned long flags;
+
+	while (1) {
+		spin_lock_irqsave(&uc->vc.lock, flags);
+
+		if (uc->desc) {
+			/* Get previous residue and time stamp */
+			residue_diff = uc->tx_drain.residue;
+			time_diff = uc->tx_drain.tstamp;
+			/*
+			 * Get current residue and time stamp or see if
+			 * transfer is complete
+			 */
+			desc_done = udma_is_desc_really_done(uc, uc->desc);
+		}
+
+		if (!desc_done) {
+			/*
+			 * Find the time delta and residue delta w.r.t
+			 * previous poll
+			 */
+			time_diff = ktime_sub(uc->tx_drain.tstamp,
+					      time_diff) + 1;
+			residue_diff -= uc->tx_drain.residue;
+			if (residue_diff) {
+				/*
+				 * Try to guess when we should check
+				 * next time by calculating rate at
+				 * which data is being drained at the
+				 * peer device
+				 */
+				delay = (time_diff / residue_diff) *
+					uc->tx_drain.residue;
+			} else {
+				/* No progress, check again in 1 second  */
+				schedule_delayed_work(&uc->tx_drain.work, HZ);
+				break;
+			}
+
+			spin_unlock_irqrestore(&uc->vc.lock, flags);
+
+			usleep_range(ktime_to_us(delay),
+				     ktime_to_us(delay) + 10);
+			continue;
+		}
+
+		if (uc->desc) {
+			struct udma_desc *d = uc->desc;
+
+			uc->ud->decrement_byte_counters(uc, d->residue);
+			uc->ud->start(uc);
+			vchan_cookie_complete(&d->vd);
+			break;
+		}
+
+		break;
+	}
+
+	spin_unlock_irqrestore(&uc->vc.lock, flags);
+}
+EXPORT_SYMBOL_GPL(udma_check_tx_completion);
+
+int udma_slave_config(struct dma_chan *chan,
+		      struct dma_slave_config *cfg)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+
+	memcpy(&uc->cfg, cfg, sizeof(uc->cfg));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(udma_slave_config);
+
+void udma_issue_pending(struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&uc->vc.lock, flags);
+
+	/* If we have something pending and no active descriptor, then */
+	if (vchan_issue_pending(&uc->vc) && !uc->desc) {
+		/*
+		 * start a descriptor if the channel is NOT [marked as
+		 * terminating _and_ it is still running (teardown has not
+		 * completed yet)].
+		 */
+		if (!(uc->state == UDMA_CHAN_IS_TERMINATING &&
+		      udma_is_chan_running(uc)))
+			uc->ud->start(uc);
+	}
+
+	spin_unlock_irqrestore(&uc->vc.lock, flags);
+}
+EXPORT_SYMBOL_GPL(udma_issue_pending);
+
+int udma_terminate_all(struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&uc->vc.lock, flags);
+
+	if (udma_is_chan_running(uc))
+		uc->ud->stop(uc);
+
+	if (uc->desc) {
+		uc->terminated_desc = uc->desc;
+		uc->desc = NULL;
+		uc->terminated_desc->terminated = true;
+		cancel_delayed_work(&uc->tx_drain.work);
+	}
+
+	uc->paused = false;
+
+	vchan_get_all_descriptors(&uc->vc, &head);
+	spin_unlock_irqrestore(&uc->vc.lock, flags);
+	vchan_dma_desc_free_list(&uc->vc, &head);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(udma_terminate_all);
+
+void udma_synchronize(struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	unsigned long timeout = msecs_to_jiffies(1000);
+
+	vchan_synchronize(&uc->vc);
+
+	if (uc->state == UDMA_CHAN_IS_TERMINATING) {
+		timeout = wait_for_completion_timeout(&uc->teardown_completed,
+						      timeout);
+		if (!timeout) {
+			dev_warn(uc->ud->dev, "chan%d teardown timeout!\n",
+				 uc->id);
+			udma_dump_chan_stdata(uc);
+			uc->ud->reset_chan(uc, true);
+		}
+	}
+
+	uc->ud->reset_chan(uc, false);
+	if (udma_is_chan_running(uc))
+		dev_warn(uc->ud->dev, "chan%d refused to stop!\n", uc->id);
+
+	cancel_delayed_work_sync(&uc->tx_drain.work);
+	udma_reset_rings(uc);
+}
+EXPORT_SYMBOL_GPL(udma_synchronize);
+
+/*
+ * This tasklet handles the completion of a DMA descriptor by
+ * calling its callback and freeing it.
+ */
+void udma_vchan_complete(struct tasklet_struct *t)
+{
+	struct virt_dma_chan *vc = from_tasklet(vc, t, task);
+	struct virt_dma_desc *vd, *_vd;
+	struct dmaengine_desc_callback cb;
+	LIST_HEAD(head);
+
+	spin_lock_irq(&vc->lock);
+	list_splice_tail_init(&vc->desc_completed, &head);
+	vd = vc->cyclic;
+	if (vd) {
+		vc->cyclic = NULL;
+		dmaengine_desc_get_callback(&vd->tx, &cb);
+	} else {
+		memset(&cb, 0, sizeof(cb));
+	}
+	spin_unlock_irq(&vc->lock);
+
+	udma_desc_pre_callback(vc, vd, NULL);
+	dmaengine_desc_callback_invoke(&cb, NULL);
+
+	list_for_each_entry_safe(vd, _vd, &head, node) {
+		struct dmaengine_result result;
+
+		dmaengine_desc_get_callback(&vd->tx, &cb);
+
+		list_del(&vd->node);
+
+		udma_desc_pre_callback(vc, vd, &result);
+		dmaengine_desc_callback_invoke(&cb, &result);
+
+		vchan_vdesc_fini(vd);
+	}
+}
+EXPORT_SYMBOL_GPL(udma_vchan_complete);
+
+void udma_mark_resource_ranges(struct udma_dev *ud, unsigned long *map,
+			       struct ti_sci_resource_desc *rm_desc,
+			       char *name)
+{
+	bitmap_clear(map, rm_desc->start, rm_desc->num);
+	bitmap_clear(map, rm_desc->start_sec, rm_desc->num_sec);
+	dev_dbg(ud->dev, "ti_sci resource range for %s: %d:%d | %d:%d\n", name,
+		rm_desc->start, rm_desc->num, rm_desc->start_sec,
+		rm_desc->num_sec);
+}
+EXPORT_SYMBOL_GPL(udma_mark_resource_ranges);
+
+int udma_setup_rx_flush(struct udma_dev *ud)
+{
+	struct udma_rx_flush *rx_flush = &ud->rx_flush;
+	struct cppi5_desc_hdr_t *tr_desc;
+	struct cppi5_tr_type1_t *tr_req;
+	struct cppi5_host_desc_t *desc;
+	struct device *dev = ud->dev;
+	struct udma_hwdesc *hwdesc;
+	size_t tr_size;
+
+	/* Allocate 1K buffer for discarded data on RX channel teardown */
+	rx_flush->buffer_size = SZ_1K;
+	rx_flush->buffer_vaddr = devm_kzalloc(dev, rx_flush->buffer_size,
+					      GFP_KERNEL);
+	if (!rx_flush->buffer_vaddr)
+		return -ENOMEM;
+
+	rx_flush->buffer_paddr = dma_map_single(dev, rx_flush->buffer_vaddr,
+						rx_flush->buffer_size,
+						DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, rx_flush->buffer_paddr))
+		return -ENOMEM;
+
+	/* Set up descriptor to be used for TR mode */
+	hwdesc = &rx_flush->hwdescs[0];
+	tr_size = sizeof(struct cppi5_tr_type1_t);
+	hwdesc->cppi5_desc_size = cppi5_trdesc_calc_size(tr_size, 1);
+	hwdesc->cppi5_desc_size = ALIGN(hwdesc->cppi5_desc_size,
+					ud->desc_align);
+
+	hwdesc->cppi5_desc_vaddr = devm_kzalloc(dev, hwdesc->cppi5_desc_size,
+						GFP_KERNEL);
+	if (!hwdesc->cppi5_desc_vaddr)
+		return -ENOMEM;
+
+	hwdesc->cppi5_desc_paddr = dma_map_single(dev, hwdesc->cppi5_desc_vaddr,
+						  hwdesc->cppi5_desc_size,
+						  DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, hwdesc->cppi5_desc_paddr))
+		return -ENOMEM;
+
+	/* Start of the TR req records */
+	hwdesc->tr_req_base = hwdesc->cppi5_desc_vaddr + tr_size;
+	/* Start address of the TR response array */
+	hwdesc->tr_resp_base = hwdesc->tr_req_base + tr_size;
+
+	tr_desc = hwdesc->cppi5_desc_vaddr;
+	cppi5_trdesc_init(tr_desc, 1, tr_size, 0, 0);
+	cppi5_desc_set_pktids(tr_desc, 0, CPPI5_INFO1_DESC_FLOWID_DEFAULT);
+	cppi5_desc_set_retpolicy(tr_desc, 0, 0);
+
+	tr_req = hwdesc->tr_req_base;
+	cppi5_tr_init(&tr_req->flags, CPPI5_TR_TYPE1, false, false,
+		      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
+	cppi5_tr_csf_set(&tr_req->flags, CPPI5_TR_CSF_SUPR_EVT);
+
+	tr_req->addr = rx_flush->buffer_paddr;
+	tr_req->icnt0 = rx_flush->buffer_size;
+	tr_req->icnt1 = 1;
+
+	dma_sync_single_for_device(dev, hwdesc->cppi5_desc_paddr,
+				   hwdesc->cppi5_desc_size, DMA_TO_DEVICE);
+
+	/* Set up descriptor to be used for packet mode */
+	hwdesc = &rx_flush->hwdescs[1];
+	hwdesc->cppi5_desc_size = ALIGN(sizeof(struct cppi5_host_desc_t) +
+					CPPI5_INFO0_HDESC_EPIB_SIZE +
+					CPPI5_INFO0_HDESC_PSDATA_MAX_SIZE,
+					ud->desc_align);
+
+	hwdesc->cppi5_desc_vaddr = devm_kzalloc(dev, hwdesc->cppi5_desc_size,
+						GFP_KERNEL);
+	if (!hwdesc->cppi5_desc_vaddr)
+		return -ENOMEM;
+
+	hwdesc->cppi5_desc_paddr = dma_map_single(dev, hwdesc->cppi5_desc_vaddr,
+						  hwdesc->cppi5_desc_size,
+						  DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, hwdesc->cppi5_desc_paddr))
+		return -ENOMEM;
+
+	desc = hwdesc->cppi5_desc_vaddr;
+	cppi5_hdesc_init(desc, 0, 0);
+	cppi5_desc_set_pktids(&desc->hdr, 0, CPPI5_INFO1_DESC_FLOWID_DEFAULT);
+	cppi5_desc_set_retpolicy(&desc->hdr, 0, 0);
+
+	cppi5_hdesc_attach_buf(desc,
+			       rx_flush->buffer_paddr, rx_flush->buffer_size,
+			       rx_flush->buffer_paddr, rx_flush->buffer_size);
+
+	dma_sync_single_for_device(dev, hwdesc->cppi5_desc_paddr,
+				   hwdesc->cppi5_desc_size, DMA_TO_DEVICE);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(udma_setup_rx_flush);
+
+#ifdef CONFIG_DEBUG_FS
+void udma_dbg_summary_show_chan(struct seq_file *s,
+				struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	struct udma_chan_config *ucc = &uc->config;
+
+	seq_printf(s, " %-13s| %s", dma_chan_name(chan),
+		   chan->dbg_client_name ?: "in-use");
+	if (ucc->tr_trigger_type)
+		seq_puts(s, " (triggered, ");
+	else
+		seq_printf(s, " (%s, ",
+			   dmaengine_get_direction_text(uc->config.dir));
+
+	switch (uc->config.dir) {
+	case DMA_MEM_TO_MEM:
+		if (uc->ud->match_data->type == DMA_TYPE_BCDMA) {
+			seq_printf(s, "bchan%d)\n", uc->bchan->id);
+			return;
+		}
+
+		seq_printf(s, "chan%d pair [0x%04x -> 0x%04x], ", uc->tchan->id,
+			   ucc->src_thread, ucc->dst_thread);
+		break;
+	case DMA_DEV_TO_MEM:
+		seq_printf(s, "rchan%d [0x%04x -> 0x%04x], ", uc->rchan->id,
+			   ucc->src_thread, ucc->dst_thread);
+		if (uc->ud->match_data->type == DMA_TYPE_PKTDMA)
+			seq_printf(s, "rflow%d, ", uc->rflow->id);
+		break;
+	case DMA_MEM_TO_DEV:
+		seq_printf(s, "tchan%d [0x%04x -> 0x%04x], ", uc->tchan->id,
+			   ucc->src_thread, ucc->dst_thread);
+		if (uc->ud->match_data->type == DMA_TYPE_PKTDMA)
+			seq_printf(s, "tflow%d, ", uc->tchan->tflow_id);
+		break;
+	default:
+		seq_puts(s, ")\n");
+		return;
+	}
+
+	if (ucc->ep_type == PSIL_EP_NATIVE) {
+		seq_puts(s, "PSI-L Native");
+		if (ucc->metadata_size) {
+			seq_printf(s, "[%s", ucc->needs_epib ? " EPIB" : "");
+			if (ucc->psd_size)
+				seq_printf(s, " PSDsize:%u", ucc->psd_size);
+			seq_puts(s, " ]");
+		}
+	} else {
+		seq_puts(s, "PDMA");
+		if (ucc->enable_acc32 || ucc->enable_burst)
+			seq_printf(s, "[%s%s ]",
+				   ucc->enable_acc32 ? " ACC32" : "",
+				   ucc->enable_burst ? " BURST" : "");
+	}
+
+	seq_printf(s, ", %s)\n", ucc->pkt_mode ? "Packet mode" : "TR mode");
+}
+
+void udma_dbg_summary_show(struct seq_file *s,
+			   struct dma_device *dma_dev)
+{
+	struct dma_chan *chan;
+
+	list_for_each_entry(chan, &dma_dev->channels, device_node) {
+		if (chan->client_count)
+			udma_dbg_summary_show_chan(s, chan);
+	}
+}
+EXPORT_SYMBOL_GPL(udma_dbg_summary_show);
+#endif /* CONFIG_DEBUG_FS */
+
+enum dmaengine_alignment udma_get_copy_align(struct udma_dev *ud)
+{
+	const struct udma_match_data *match_data = ud->match_data;
+	u8 tpl;
+
+	if (!match_data->enable_memcpy_support)
+		return DMAENGINE_ALIGN_8_BYTES;
+
+	/* Get the highest TPL level the device supports for memcpy */
+	if (ud->bchan_cnt)
+		tpl = udma_get_chan_tpl_index(&ud->bchan_tpl, 0);
+	else if (ud->tchan_cnt)
+		tpl = udma_get_chan_tpl_index(&ud->tchan_tpl, 0);
+	else
+		return DMAENGINE_ALIGN_8_BYTES;
+
+	switch (match_data->burst_size[tpl]) {
+	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_256_BYTES:
+		return DMAENGINE_ALIGN_256_BYTES;
+	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_128_BYTES:
+		return DMAENGINE_ALIGN_128_BYTES;
+	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES:
+	fallthrough;
+	default:
+		return DMAENGINE_ALIGN_64_BYTES;
+	}
+}
+EXPORT_SYMBOL_GPL(udma_get_copy_align);
+
 MODULE_DESCRIPTION("Texas Instruments K3 UDMA Common Library");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 397e890283eaa..e86c811a15eb9 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -61,92 +61,6 @@ int navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
 						src_thread, dst_thread);
 }
 
-static void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel)
-{
-	struct device *chan_dev = &chan->dev->device;
-
-	if (asel == 0) {
-		/* No special handling for the channel */
-		chan->dev->chan_dma_dev = false;
-
-		chan_dev->dma_coherent = false;
-		chan_dev->dma_parms = NULL;
-	} else if (asel == 14 || asel == 15) {
-		chan->dev->chan_dma_dev = true;
-
-		chan_dev->dma_coherent = true;
-		dma_coerce_mask_and_coherent(chan_dev, DMA_BIT_MASK(48));
-		chan_dev->dma_parms = chan_dev->parent->dma_parms;
-	} else {
-		dev_warn(chan->device->dev, "Invalid ASEL value: %u\n", asel);
-
-		chan_dev->dma_coherent = false;
-		chan_dev->dma_parms = NULL;
-	}
-}
-
-static u8 udma_get_chan_tpl_index(struct udma_tpl *tpl_map, int chan_id)
-{
-	int i;
-
-	for (i = 0; i < tpl_map->levels; i++) {
-		if (chan_id >= tpl_map->start_idx[i])
-			return i;
-	}
-
-	return 0;
-}
-
-static void udma_reset_uchan(struct udma_chan *uc)
-{
-	memset(&uc->config, 0, sizeof(uc->config));
-	uc->config.remote_thread_id = -1;
-	uc->config.mapped_channel_id = -1;
-	uc->config.default_flow_id = -1;
-	uc->state = UDMA_CHAN_IS_IDLE;
-}
-
-static void udma_dump_chan_stdata(struct udma_chan *uc)
-{
-	struct device *dev = uc->ud->dev;
-	u32 offset;
-	int i;
-
-	if (uc->config.dir == DMA_MEM_TO_DEV || uc->config.dir == DMA_MEM_TO_MEM) {
-		dev_dbg(dev, "TCHAN State data:\n");
-		for (i = 0; i < 32; i++) {
-			offset = UDMA_CHAN_RT_STDATA_REG + i * 4;
-			dev_dbg(dev, "TRT_STDATA[%02d]: 0x%08x\n", i,
-				udma_tchanrt_read(uc, offset));
-		}
-	}
-
-	if (uc->config.dir == DMA_DEV_TO_MEM || uc->config.dir == DMA_MEM_TO_MEM) {
-		dev_dbg(dev, "RCHAN State data:\n");
-		for (i = 0; i < 32; i++) {
-			offset = UDMA_CHAN_RT_STDATA_REG + i * 4;
-			dev_dbg(dev, "RRT_STDATA[%02d]: 0x%08x\n", i,
-				udma_rchanrt_read(uc, offset));
-		}
-	}
-}
-
-static bool udma_is_chan_running(struct udma_chan *uc)
-{
-	u32 trt_ctl = 0;
-	u32 rrt_ctl = 0;
-
-	if (uc->tchan)
-		trt_ctl = udma_tchanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
-	if (uc->rchan)
-		rrt_ctl = udma_rchanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
-
-	if (trt_ctl & UDMA_CHAN_RT_CTL_EN || rrt_ctl & UDMA_CHAN_RT_CTL_EN)
-		return true;
-
-	return false;
-}
-
 static bool udma_is_chan_paused(struct udma_chan *uc)
 {
 	u32 val, pause_mask;
@@ -275,40 +189,6 @@ static int udma_reset_chan(struct udma_chan *uc, bool hard)
 	return 0;
 }
 
-static void udma_start_desc(struct udma_chan *uc)
-{
-	struct udma_chan_config *ucc = &uc->config;
-
-	if (uc->ud->match_data->type == DMA_TYPE_UDMA && ucc->pkt_mode &&
-	    (uc->cyclic || ucc->dir == DMA_DEV_TO_MEM)) {
-		int i;
-
-		/*
-		 * UDMA only: Push all descriptors to ring for packet mode
-		 * cyclic or RX
-		 * PKTDMA supports pre-linked descriptor and cyclic is not
-		 * supported
-		 */
-		for (i = 0; i < uc->desc->sglen; i++)
-			udma_push_to_ring(uc, i);
-	} else {
-		udma_push_to_ring(uc, 0);
-	}
-}
-
-static bool udma_chan_needs_reconfiguration(struct udma_chan *uc)
-{
-	/* Only PDMAs have staticTR */
-	if (uc->config.ep_type == PSIL_EP_NATIVE)
-		return false;
-
-	/* Check if the staticTR configuration has changed for TX */
-	if (memcmp(&uc->static_tr, &uc->desc->static_tr, sizeof(uc->static_tr)))
-		return true;
-
-	return false;
-}
-
 static int udma_start(struct udma_chan *uc)
 {
 	struct virt_dma_desc *vd = vchan_next_desc(&uc->vc);
@@ -453,86 +333,6 @@ static int udma_stop(struct udma_chan *uc)
 	return 0;
 }
 
-static void udma_cyclic_packet_elapsed(struct udma_chan *uc)
-{
-	struct udma_desc *d = uc->desc;
-	struct cppi5_host_desc_t *h_desc;
-
-	h_desc = d->hwdesc[d->desc_idx].cppi5_desc_vaddr;
-	cppi5_hdesc_reset_to_original(h_desc);
-	udma_push_to_ring(uc, d->desc_idx);
-	d->desc_idx = (d->desc_idx + 1) % d->sglen;
-}
-
-static void udma_check_tx_completion(struct work_struct *work)
-{
-	struct udma_chan *uc = container_of(work, typeof(*uc),
-					    tx_drain.work.work);
-	bool desc_done = true;
-	u32 residue_diff;
-	ktime_t time_diff;
-	unsigned long delay;
-	unsigned long flags;
-
-	while (1) {
-		spin_lock_irqsave(&uc->vc.lock, flags);
-
-		if (uc->desc) {
-			/* Get previous residue and time stamp */
-			residue_diff = uc->tx_drain.residue;
-			time_diff = uc->tx_drain.tstamp;
-			/*
-			 * Get current residue and time stamp or see if
-			 * transfer is complete
-			 */
-			desc_done = udma_is_desc_really_done(uc, uc->desc);
-		}
-
-		if (!desc_done) {
-			/*
-			 * Find the time delta and residue delta w.r.t
-			 * previous poll
-			 */
-			time_diff = ktime_sub(uc->tx_drain.tstamp,
-					      time_diff) + 1;
-			residue_diff -= uc->tx_drain.residue;
-			if (residue_diff) {
-				/*
-				 * Try to guess when we should check
-				 * next time by calculating rate at
-				 * which data is being drained at the
-				 * peer device
-				 */
-				delay = (time_diff / residue_diff) *
-					uc->tx_drain.residue;
-			} else {
-				/* No progress, check again in 1 second  */
-				schedule_delayed_work(&uc->tx_drain.work, HZ);
-				break;
-			}
-
-			spin_unlock_irqrestore(&uc->vc.lock, flags);
-
-			usleep_range(ktime_to_us(delay),
-				     ktime_to_us(delay) + 10);
-			continue;
-		}
-
-		if (uc->desc) {
-			struct udma_desc *d = uc->desc;
-
-			uc->ud->decrement_byte_counters(uc, d->residue);
-			uc->ud->start(uc);
-			vchan_cookie_complete(&d->vd);
-			break;
-		}
-
-		break;
-	}
-
-	spin_unlock_irqrestore(&uc->vc.lock, flags);
-}
-
 static irqreturn_t udma_ring_irq_handler(int irq, void *data)
 {
 	struct udma_chan *uc = data;
@@ -2097,38 +1897,6 @@ static int pktdma_alloc_chan_resources(struct dma_chan *chan)
 	return ret;
 }
 
-static int udma_slave_config(struct dma_chan *chan,
-			     struct dma_slave_config *cfg)
-{
-	struct udma_chan *uc = to_udma_chan(chan);
-
-	memcpy(&uc->cfg, cfg, sizeof(uc->cfg));
-
-	return 0;
-}
-
-static void udma_issue_pending(struct dma_chan *chan)
-{
-	struct udma_chan *uc = to_udma_chan(chan);
-	unsigned long flags;
-
-	spin_lock_irqsave(&uc->vc.lock, flags);
-
-	/* If we have something pending and no active descriptor, then */
-	if (vchan_issue_pending(&uc->vc) && !uc->desc) {
-		/*
-		 * start a descriptor if the channel is NOT [marked as
-		 * terminating _and_ it is still running (teardown has not
-		 * completed yet)].
-		 */
-		if (!(uc->state == UDMA_CHAN_IS_TERMINATING &&
-		      udma_is_chan_running(uc)))
-			uc->ud->start(uc);
-	}
-
-	spin_unlock_irqrestore(&uc->vc.lock, flags);
-}
-
 static enum dma_status udma_tx_status(struct dma_chan *chan,
 				      dma_cookie_t cookie,
 				      struct dma_tx_state *txstate)
@@ -2256,98 +2024,6 @@ static int udma_resume(struct dma_chan *chan)
 	return 0;
 }
 
-static int udma_terminate_all(struct dma_chan *chan)
-{
-	struct udma_chan *uc = to_udma_chan(chan);
-	unsigned long flags;
-	LIST_HEAD(head);
-
-	spin_lock_irqsave(&uc->vc.lock, flags);
-
-	if (udma_is_chan_running(uc))
-		uc->ud->stop(uc);
-
-	if (uc->desc) {
-		uc->terminated_desc = uc->desc;
-		uc->desc = NULL;
-		uc->terminated_desc->terminated = true;
-		cancel_delayed_work(&uc->tx_drain.work);
-	}
-
-	uc->paused = false;
-
-	vchan_get_all_descriptors(&uc->vc, &head);
-	spin_unlock_irqrestore(&uc->vc.lock, flags);
-	vchan_dma_desc_free_list(&uc->vc, &head);
-
-	return 0;
-}
-
-static void udma_synchronize(struct dma_chan *chan)
-{
-	struct udma_chan *uc = to_udma_chan(chan);
-	unsigned long timeout = msecs_to_jiffies(1000);
-
-	vchan_synchronize(&uc->vc);
-
-	if (uc->state == UDMA_CHAN_IS_TERMINATING) {
-		timeout = wait_for_completion_timeout(&uc->teardown_completed,
-						      timeout);
-		if (!timeout) {
-			dev_warn(uc->ud->dev, "chan%d teardown timeout!\n",
-				 uc->id);
-			udma_dump_chan_stdata(uc);
-			uc->ud->reset_chan(uc, true);
-		}
-	}
-
-	uc->ud->reset_chan(uc, false);
-	if (udma_is_chan_running(uc))
-		dev_warn(uc->ud->dev, "chan%d refused to stop!\n", uc->id);
-
-	cancel_delayed_work_sync(&uc->tx_drain.work);
-	udma_reset_rings(uc);
-}
-
-/*
- * This tasklet handles the completion of a DMA descriptor by
- * calling its callback and freeing it.
- */
-static void udma_vchan_complete(struct tasklet_struct *t)
-{
-	struct virt_dma_chan *vc = from_tasklet(vc, t, task);
-	struct virt_dma_desc *vd, *_vd;
-	struct dmaengine_desc_callback cb;
-	LIST_HEAD(head);
-
-	spin_lock_irq(&vc->lock);
-	list_splice_tail_init(&vc->desc_completed, &head);
-	vd = vc->cyclic;
-	if (vd) {
-		vc->cyclic = NULL;
-		dmaengine_desc_get_callback(&vd->tx, &cb);
-	} else {
-		memset(&cb, 0, sizeof(cb));
-	}
-	spin_unlock_irq(&vc->lock);
-
-	udma_desc_pre_callback(vc, vd, NULL);
-	dmaengine_desc_callback_invoke(&cb, NULL);
-
-	list_for_each_entry_safe(vd, _vd, &head, node) {
-		struct dmaengine_result result;
-
-		dmaengine_desc_get_callback(&vd->tx, &cb);
-
-		list_del(&vd->node);
-
-		udma_desc_pre_callback(vc, vd, &result);
-		dmaengine_desc_callback_invoke(&cb, &result);
-
-		vchan_vdesc_fini(vd);
-	}
-}
-
 static void udma_free_chan_resources(struct dma_chan *chan)
 {
 	struct udma_chan *uc = to_udma_chan(chan);
@@ -2822,17 +2498,6 @@ static int udma_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
 	return 0;
 }
 
-static void udma_mark_resource_ranges(struct udma_dev *ud, unsigned long *map,
-				      struct ti_sci_resource_desc *rm_desc,
-				      char *name)
-{
-	bitmap_clear(map, rm_desc->start, rm_desc->num);
-	bitmap_clear(map, rm_desc->start_sec, rm_desc->num_sec);
-	dev_dbg(ud->dev, "ti_sci resource range for %s: %d:%d | %d:%d\n", name,
-		rm_desc->start, rm_desc->num, rm_desc->start_sec,
-		rm_desc->num_sec);
-}
-
 static const char * const range_names[] = {
 	[RM_RANGE_BCHAN] = "ti,sci-rm-range-bchan",
 	[RM_RANGE_TCHAN] = "ti,sci-rm-range-tchan",
@@ -3463,202 +3128,6 @@ static int setup_resources(struct udma_dev *ud)
 	return ch_count;
 }
 
-static int udma_setup_rx_flush(struct udma_dev *ud)
-{
-	struct udma_rx_flush *rx_flush = &ud->rx_flush;
-	struct cppi5_desc_hdr_t *tr_desc;
-	struct cppi5_tr_type1_t *tr_req;
-	struct cppi5_host_desc_t *desc;
-	struct device *dev = ud->dev;
-	struct udma_hwdesc *hwdesc;
-	size_t tr_size;
-
-	/* Allocate 1K buffer for discarded data on RX channel teardown */
-	rx_flush->buffer_size = SZ_1K;
-	rx_flush->buffer_vaddr = devm_kzalloc(dev, rx_flush->buffer_size,
-					      GFP_KERNEL);
-	if (!rx_flush->buffer_vaddr)
-		return -ENOMEM;
-
-	rx_flush->buffer_paddr = dma_map_single(dev, rx_flush->buffer_vaddr,
-						rx_flush->buffer_size,
-						DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, rx_flush->buffer_paddr))
-		return -ENOMEM;
-
-	/* Set up descriptor to be used for TR mode */
-	hwdesc = &rx_flush->hwdescs[0];
-	tr_size = sizeof(struct cppi5_tr_type1_t);
-	hwdesc->cppi5_desc_size = cppi5_trdesc_calc_size(tr_size, 1);
-	hwdesc->cppi5_desc_size = ALIGN(hwdesc->cppi5_desc_size,
-					ud->desc_align);
-
-	hwdesc->cppi5_desc_vaddr = devm_kzalloc(dev, hwdesc->cppi5_desc_size,
-						GFP_KERNEL);
-	if (!hwdesc->cppi5_desc_vaddr)
-		return -ENOMEM;
-
-	hwdesc->cppi5_desc_paddr = dma_map_single(dev, hwdesc->cppi5_desc_vaddr,
-						  hwdesc->cppi5_desc_size,
-						  DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, hwdesc->cppi5_desc_paddr))
-		return -ENOMEM;
-
-	/* Start of the TR req records */
-	hwdesc->tr_req_base = hwdesc->cppi5_desc_vaddr + tr_size;
-	/* Start address of the TR response array */
-	hwdesc->tr_resp_base = hwdesc->tr_req_base + tr_size;
-
-	tr_desc = hwdesc->cppi5_desc_vaddr;
-	cppi5_trdesc_init(tr_desc, 1, tr_size, 0, 0);
-	cppi5_desc_set_pktids(tr_desc, 0, CPPI5_INFO1_DESC_FLOWID_DEFAULT);
-	cppi5_desc_set_retpolicy(tr_desc, 0, 0);
-
-	tr_req = hwdesc->tr_req_base;
-	cppi5_tr_init(&tr_req->flags, CPPI5_TR_TYPE1, false, false,
-		      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
-	cppi5_tr_csf_set(&tr_req->flags, CPPI5_TR_CSF_SUPR_EVT);
-
-	tr_req->addr = rx_flush->buffer_paddr;
-	tr_req->icnt0 = rx_flush->buffer_size;
-	tr_req->icnt1 = 1;
-
-	dma_sync_single_for_device(dev, hwdesc->cppi5_desc_paddr,
-				   hwdesc->cppi5_desc_size, DMA_TO_DEVICE);
-
-	/* Set up descriptor to be used for packet mode */
-	hwdesc = &rx_flush->hwdescs[1];
-	hwdesc->cppi5_desc_size = ALIGN(sizeof(struct cppi5_host_desc_t) +
-					CPPI5_INFO0_HDESC_EPIB_SIZE +
-					CPPI5_INFO0_HDESC_PSDATA_MAX_SIZE,
-					ud->desc_align);
-
-	hwdesc->cppi5_desc_vaddr = devm_kzalloc(dev, hwdesc->cppi5_desc_size,
-						GFP_KERNEL);
-	if (!hwdesc->cppi5_desc_vaddr)
-		return -ENOMEM;
-
-	hwdesc->cppi5_desc_paddr = dma_map_single(dev, hwdesc->cppi5_desc_vaddr,
-						  hwdesc->cppi5_desc_size,
-						  DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, hwdesc->cppi5_desc_paddr))
-		return -ENOMEM;
-
-	desc = hwdesc->cppi5_desc_vaddr;
-	cppi5_hdesc_init(desc, 0, 0);
-	cppi5_desc_set_pktids(&desc->hdr, 0, CPPI5_INFO1_DESC_FLOWID_DEFAULT);
-	cppi5_desc_set_retpolicy(&desc->hdr, 0, 0);
-
-	cppi5_hdesc_attach_buf(desc,
-			       rx_flush->buffer_paddr, rx_flush->buffer_size,
-			       rx_flush->buffer_paddr, rx_flush->buffer_size);
-
-	dma_sync_single_for_device(dev, hwdesc->cppi5_desc_paddr,
-				   hwdesc->cppi5_desc_size, DMA_TO_DEVICE);
-	return 0;
-}
-
-#ifdef CONFIG_DEBUG_FS
-static void udma_dbg_summary_show_chan(struct seq_file *s,
-				       struct dma_chan *chan)
-{
-	struct udma_chan *uc = to_udma_chan(chan);
-	struct udma_chan_config *ucc = &uc->config;
-
-	seq_printf(s, " %-13s| %s", dma_chan_name(chan),
-		   chan->dbg_client_name ?: "in-use");
-	if (ucc->tr_trigger_type)
-		seq_puts(s, " (triggered, ");
-	else
-		seq_printf(s, " (%s, ",
-			   dmaengine_get_direction_text(uc->config.dir));
-
-	switch (uc->config.dir) {
-	case DMA_MEM_TO_MEM:
-		if (uc->ud->match_data->type == DMA_TYPE_BCDMA) {
-			seq_printf(s, "bchan%d)\n", uc->bchan->id);
-			return;
-		}
-
-		seq_printf(s, "chan%d pair [0x%04x -> 0x%04x], ", uc->tchan->id,
-			   ucc->src_thread, ucc->dst_thread);
-		break;
-	case DMA_DEV_TO_MEM:
-		seq_printf(s, "rchan%d [0x%04x -> 0x%04x], ", uc->rchan->id,
-			   ucc->src_thread, ucc->dst_thread);
-		if (uc->ud->match_data->type == DMA_TYPE_PKTDMA)
-			seq_printf(s, "rflow%d, ", uc->rflow->id);
-		break;
-	case DMA_MEM_TO_DEV:
-		seq_printf(s, "tchan%d [0x%04x -> 0x%04x], ", uc->tchan->id,
-			   ucc->src_thread, ucc->dst_thread);
-		if (uc->ud->match_data->type == DMA_TYPE_PKTDMA)
-			seq_printf(s, "tflow%d, ", uc->tchan->tflow_id);
-		break;
-	default:
-		seq_printf(s, ")\n");
-		return;
-	}
-
-	if (ucc->ep_type == PSIL_EP_NATIVE) {
-		seq_printf(s, "PSI-L Native");
-		if (ucc->metadata_size) {
-			seq_printf(s, "[%s", ucc->needs_epib ? " EPIB" : "");
-			if (ucc->psd_size)
-				seq_printf(s, " PSDsize:%u", ucc->psd_size);
-			seq_printf(s, " ]");
-		}
-	} else {
-		seq_printf(s, "PDMA");
-		if (ucc->enable_acc32 || ucc->enable_burst)
-			seq_printf(s, "[%s%s ]",
-				   ucc->enable_acc32 ? " ACC32" : "",
-				   ucc->enable_burst ? " BURST" : "");
-	}
-
-	seq_printf(s, ", %s)\n", ucc->pkt_mode ? "Packet mode" : "TR mode");
-}
-
-static void udma_dbg_summary_show(struct seq_file *s,
-				  struct dma_device *dma_dev)
-{
-	struct dma_chan *chan;
-
-	list_for_each_entry(chan, &dma_dev->channels, device_node) {
-		if (chan->client_count)
-			udma_dbg_summary_show_chan(s, chan);
-	}
-}
-#endif /* CONFIG_DEBUG_FS */
-
-static enum dmaengine_alignment udma_get_copy_align(struct udma_dev *ud)
-{
-	const struct udma_match_data *match_data = ud->match_data;
-	u8 tpl;
-
-	if (!match_data->enable_memcpy_support)
-		return DMAENGINE_ALIGN_8_BYTES;
-
-	/* Get the highest TPL level the device supports for memcpy */
-	if (ud->bchan_cnt)
-		tpl = udma_get_chan_tpl_index(&ud->bchan_tpl, 0);
-	else if (ud->tchan_cnt)
-		tpl = udma_get_chan_tpl_index(&ud->tchan_tpl, 0);
-	else
-		return DMAENGINE_ALIGN_8_BYTES;
-
-	switch (match_data->burst_size[tpl]) {
-	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_256_BYTES:
-		return DMAENGINE_ALIGN_256_BYTES;
-	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_128_BYTES:
-		return DMAENGINE_ALIGN_128_BYTES;
-	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES:
-	fallthrough;
-	default:
-		return DMAENGINE_ALIGN_64_BYTES;
-	}
-}
-
 static int udma_probe(struct platform_device *pdev)
 {
 	struct device_node *navss_node = pdev->dev.parent->of_node;
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 2f5fbea446fed..797e8b0c5b85e 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -625,6 +625,34 @@ void udma_reset_rings(struct udma_chan *uc);
 
 int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
 int navss_psil_unpair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
+void udma_start_desc(struct udma_chan *uc);
+u8 udma_get_chan_tpl_index(struct udma_tpl *tpl_map, int chan_id);
+void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel);
+void udma_reset_uchan(struct udma_chan *uc);
+void udma_dump_chan_stdata(struct udma_chan *uc);
+bool udma_is_chan_running(struct udma_chan *uc);
+
+bool udma_chan_needs_reconfiguration(struct udma_chan *uc);
+void udma_cyclic_packet_elapsed(struct udma_chan *uc);
+void udma_check_tx_completion(struct work_struct *work);
+int udma_slave_config(struct dma_chan *chan,
+		      struct dma_slave_config *cfg);
+void udma_issue_pending(struct dma_chan *chan);
+int udma_terminate_all(struct dma_chan *chan);
+void udma_synchronize(struct dma_chan *chan);
+void udma_vchan_complete(struct tasklet_struct *t);
+void udma_mark_resource_ranges(struct udma_dev *ud, unsigned long *map,
+			       struct ti_sci_resource_desc *rm_desc,
+			       char *name);
+int udma_setup_rx_flush(struct udma_dev *ud);
+enum dmaengine_alignment udma_get_copy_align(struct udma_dev *ud);
+
+#ifdef CONFIG_DEBUG_FS
+void udma_dbg_summary_show_chan(struct seq_file *s,
+				struct dma_chan *chan);
+void udma_dbg_summary_show(struct seq_file *s,
+			   struct dma_device *dma_dev);
+#endif /* CONFIG_DEBUG_FS */
 
 /* Direct access to UDMA low lever resources for the glue layer */
 int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
-- 
2.34.1


