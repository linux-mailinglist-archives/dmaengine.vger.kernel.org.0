Return-Path: <dmaengine+bounces-8948-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DEJJ4eMlWlVSQIAu9opvQ
	(envelope-from <dmaengine+bounces-8948-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:55:19 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13442154F7D
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33FD4307DCA3
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 09:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF90D33DEC2;
	Wed, 18 Feb 2026 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lMi+MfTd"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222A433DEDB;
	Wed, 18 Feb 2026 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408432; cv=fail; b=TfypPzfwsttl2CXdVWcEQA/J4Tz/JP88fvF3pmyMuPlgigMtzGJz5jJk1gVRT+4q5N97EYxL2qRGDHG8ErxK1bOEZSBabtnmwr2V33onS0cPSdH4FQvffw/M5ezSCjDgVjfbAVnJ6Bquy5xYyIl7fsV35eYTM8gPgJM5DiuqZUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408432; c=relaxed/simple;
	bh=TFfvL+PsFafY8LmkNCnxSvieOZZIUP03CN9kyK0T5kg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lUQT5xmERRBeMg9H7b77nJycVsi1p6TJK89c0MrZJs403DqJQ1emljnRr4BUJ6wS4grTFN7ThF21Qk1M+MYhLE+pRy6qR2VbQYVpDLzLRsacDpoY2eWMAwo1ZxTe7cO3sBd0wtcKEYqiJTf4rbK1Ok78XMLvP1XR3q+Ng/OzPFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lMi+MfTd; arc=fail smtp.client-ip=52.101.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWXz+OBpJzQkG+CpS1eJD7WjJpRaGWovtdqNZCla0F+hOecoiHYMZDBUUFIjzwzBd/6Ky7VMa3xEvDx8cAISMWy8qe822CYl5pL1DDzOlO5mEXd027VZsrXxG9rDz4lnnjdAoEC6l8Q3lKxbst8AGhZU++uZhhhyetpkJmn8cxNQd5HzctMnaShtrpWavWWSbHaA9w6BuowpBgbgyLQfap+dq5Vq0SzniqXC04ooPgUBTeTSakVESX+oxO8oZWRhoSialjhzroURwsxCBpSRF+7IoTcJiALhcEF0dwrZLLhsYNSzBUIZS9sAwbFcwXlOO+pyVo4A/eYF09g+2fILnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2m98ddZ89hiWEYDEvhihOBUBnlsOJ4TJttEiVBMP44=;
 b=NdsRZ5l9P8yskQhH3iRvMD7fSdJhmpmIdh8xXccighkYpV5Xu5wovDFrt5U/yCtKIOWw75enj1Shreg5gKT8YLXtrcUKdSSeO+xJ0z2KaoINijbi3TQr6dNNAtbTZab5eTTrvj3HGLZEoZJ+uZUuvBnW81qmD6TGQvNP1MJfJlgiB1vzKGgQTXEdwoH24HtbM0Yzn70OocT7ANxQdtF9n6dYkAT8RYMRWLWeXX1eHbTu0eCQFdgnqpdOMPq6y+kzo5XBLAQjD2VahK6jOYsUDG5mcl9LrEzt57g9jjcn27I10gbKXrGfuBVYYD1nNEGu5qcnh3SRqmS45ccAwf3kPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2m98ddZ89hiWEYDEvhihOBUBnlsOJ4TJttEiVBMP44=;
 b=lMi+MfTds1gFG2ycXDgSHtcEs/fJPamlNDKBWf8iOOjXJapwf0Ceqo+f1J5iOUhH4JYo1Bck4dIIP5G11J0OzE6SPIiuPKSameZXgUc8ZpArXnQscXsMDrpbjO32YP/9AG3Md+QpiQ97IdgyMf80XZyIp+3WfLwPdFnSvLqdYos=
Received: from DS7P220CA0037.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::30) by
 DS0PR10MB6945.namprd10.prod.outlook.com (2603:10b6:8:143::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.13; Wed, 18 Feb 2026 09:53:48 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:8:223:cafe::f9) by DS7P220CA0037.outlook.office365.com
 (2603:10b6:8:223::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 09:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 09:53:47 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:53:44 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:53:44 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 03:53:44 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61I9qpIH200561;
	Wed, 18 Feb 2026 03:53:40 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v5 10/18] dmaengine: ti: k3-udma: move inclusion of k3-udma-private.c to k3-udma-common.c
Date: Wed, 18 Feb 2026 15:22:35 +0530
Message-ID: <20260218095243.2832115-11-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DS0PR10MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: bfdad49c-8179-4afc-57b9-08de6ed39c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IlgiuGgnlkOXUhFXlJSJXZHzoWj+7vL06tdep0VVJ3wDQs7hu45Q+lwx1Ce9?=
 =?us-ascii?Q?tvi9wTe2mXqnKhTZIVtdu+xXHp5JzFgK48+6pED4XCic4YsgjlUs+fubWQye?=
 =?us-ascii?Q?6GOLH8cDNNfIeHsEesnOIX+C9TNQ23pZTRXTODhd4/NfN3/Y3bvukqBH1SpV?=
 =?us-ascii?Q?9qa902JpbGw3T//IrVlvTaVuu7U4TG9Tjw3OJDB+J+xleCH8FTXBA9rQrqSX?=
 =?us-ascii?Q?QnHfPOpaGQqS3CzwiPb4Js9xImmiCzlKfebLNknn6gzJqqoSE4bGPKbUFxIU?=
 =?us-ascii?Q?kBwp88Kp16yjgbPKYu36gdy6ubNvxY050Sq93joCdiIukv45J5H+XiU31zn6?=
 =?us-ascii?Q?JWSOkXtAhRMrtVVdtj83oCG5pAAOOtg1qnS8R0oY3R3pI0D/igLFkJHDHWLf?=
 =?us-ascii?Q?3ImcZp4OyYVADbrnMLn72sz4ZcoZZdh2Ou5TnooVYk9h3fXK/7GyX8euBaOD?=
 =?us-ascii?Q?L0leH1ndlXxJX6cb/XHFh88GcMuHZFYbD6u2LHgBEY9sZE5/cGav0+Smyw6j?=
 =?us-ascii?Q?mVSAYoku8GvV/2UIIhXnmjM7Rl4uiGlAYjG/zRceZZbfmIjOVVk1iGo9hMQ+?=
 =?us-ascii?Q?y9uloEV1yNRw4LaYEqrtVuDrnzmDNfeXPhEudiHYGm59CfPDetbecE1iNp/B?=
 =?us-ascii?Q?bv8oENwoJCOwJB6qwjdRhV1BhzFuZz8V4DHG5a+GSDD0PmyaW6aaAn18HkkF?=
 =?us-ascii?Q?HKO20A2JtEksOeAnzqtAT1C5sxcIqTqemIaLPsqcK3Rj/HkAWWq2+XS8JAxL?=
 =?us-ascii?Q?WZHgkYQcRigGvZiAFooTOBfrR/Yqbv8XAdd665eAYGUavGk0YKlJG0qSzKc9?=
 =?us-ascii?Q?MqWMSJ4Bfyt2IE5AHWUeCuzCYmlsAgChxQ4uGAb3Wv7T9kGZdHKxoneJMnQR?=
 =?us-ascii?Q?fF6mQcEpGw5Wasdn3sNN3iLwEGniSyHnlz9Ve099QeXjp0v58YojGUbyq3gM?=
 =?us-ascii?Q?EJvxODaZJF73oQrpNb5SFh7/vmLI2XUAs9qoUjoUWzL0rdcpR59bh143XhTm?=
 =?us-ascii?Q?G/YlucL0NRPSi4Y45YGHEmFTNvEPCK0yObGlO5lJUc4GeTCFqrETHFsfZ+bE?=
 =?us-ascii?Q?slkFQr1glymTcuUrTTiS+jeB3WTkz49sHBJpMf1t0y/ZKLG8EjIYAM9bXWan?=
 =?us-ascii?Q?g4sX1vXfGkYurQ6zFYskErgcVIdfZKWmkCeXEe62HGVU5dZlNYAD6FUDJdNj?=
 =?us-ascii?Q?2w6Ld8D9rnrbhJyBWqVPiljANgATtzT/18JrVvPL53i62R+/eTuev7jD2Df0?=
 =?us-ascii?Q?vZyw/PzMuN18Jmc+axx/8qHT1a5O56R40TtaDaB0KT5DayW5tIZ1jD8JpRSy?=
 =?us-ascii?Q?BKOgYGZRIhPqYSq/qVo1wK2ORe2irAjNG+IrX0gHdX5UMhJyHKXsCzmI+bV3?=
 =?us-ascii?Q?XAh5+gc2LmMZMTXyhxnwdWVgcaVbWARkFaGLKnzMp4YG6ciGQ2xLnurCr5Rm?=
 =?us-ascii?Q?pH3ZFsAk5BiJtFhvnUK7aS5OlJW1TSLK8pvHyYG78nD9HvMUxMi0qEtNzLbn?=
 =?us-ascii?Q?R/K5ZDFKSNyjOffyhVv20BAWvvZ+aWmwzyOFEcGThL337FfPeWL7TVEbMTNo?=
 =?us-ascii?Q?2K52dU8z3sGdNwLDLOtvVaeoftYEIMRgX3KrmCgvaBkx/6wLP82ZFtppHemF?=
 =?us-ascii?Q?bsKu3TOFIfy3poeRVtK0OH/ckdS4y2dVJo1Apyza8YvIqUyiWDCGimOVYC9E?=
 =?us-ascii?Q?lSHk2exsf5+ETuhyKWvWcmCCzvM=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D+G/poAEzVxA8Kpix5L94al7HTPRxkVD5FeLqArkeuM5vxEm6OvybpXjho1BcMyyb2BYqaLqrebz8Bx0ResMdcjujByhhLCP5MFr/Tql03Fgm4FJ8s/Q3BlAx7X6ImQvsrh/+z97EABzNEjYeSl+1KL069xYIJ/xHnM2Te9oBra8feSvRu34x/xM2voeazmN1EWxf9E5OUeQmGIg/UWbHYQXJ+NEw9yj9CNL/VyqRqtyAiatz1RKrbE5cFZlHvApbobRD16eUq9fp9gjhA8NHfGsywvmmXcNLDML5V49OLH3pe4DzsHXygA/8JIeKBEPsn5/ds79j9x/I0J2Ieb8RCGP+25jwhJaJ87/XauQ211Q7ehHqz2xsPtIaXdHy2EI9nKBPcBoE7U3Kn2CW723PJJyZm5Qz3kGvb+0dAGkcx8KDDA+GdqabKyMbIv4ZJd1
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 09:53:47.2877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfdad49c-8179-4afc-57b9-08de6ed39c60
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6945
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8948-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim,ti.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 13442154F7D
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


