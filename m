Return-Path: <dmaengine+bounces-2653-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA18C92A4FD
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 16:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DB3281A2C
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 14:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCDE482DE;
	Mon,  8 Jul 2024 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uEeQqZu0"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F359113D275
	for <dmaengine@vger.kernel.org>; Mon,  8 Jul 2024 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449932; cv=fail; b=YFRHfYCaRBLjFb+M2+c38Z8LTbrBFSMf6CkeBdUrqX3SgUNFIFRtDZVzgLy5eBagXZICJg4cf3zCX55ogsVYTX6vXDXECr1Nb3yXWa6aGESFyzZDEZqQE4oQV/Msp1MFSbH+9fpHgNf9PsXmLqH8o0nnU8PdobYheELwoXhjUvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449932; c=relaxed/simple;
	bh=J544fe2Yj11p6iDUipsNP5NkWV0yxcVT9mqD/LsxQ1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gq/2KWPYePvAaCKv3SmOI/0piZ1FeJmoYUrMfSMmlvPmcKYmIHcxR2MYX0ve6g2TRK+9OjVcs27+8RwcerHY4Yw2PxWwwV3YM/cJntA6laf+6E1/f/WzZQbEhzU48XLFhfJETdddq2xKuLOaM285h11+RQuTnoN1k02Trd5kuck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uEeQqZu0; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8vaC0B68dH9FvGN2ubY1nbLkd27qnprRi+USDxfgtcsaJ1MVIkqAaeEikmpqJRNhcFzi/ivlupJ0ZGAjR/C3FMl4/lOTvhTqvchpsGxsAQOk/2nvtzQuv7M8eTZmoF9/HCr3kggXLHzwk5AcV9tpbDZ+DWikX86l+tGJa9mvFGFPGBtWc0FodgSGLAH/5Z7Qm9wdMe1cIyiA69Jz4qmY73VOcWuEjrrhw2KitPIGP146oA1s6uVr6S9+k1jLjUcRQ4L/pp6YAovVPkV4ikgvIRrr5CqDMCROG1mQSfM7Nc7UjJHPLtjT3aBHe633x2cYRHTneF+NFqFoDLo/JUQvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuwWx2KCbNJ/yLgXyUs01UNRIKJdiWaX/FYMeYt269A=;
 b=b52GyW8j8FIfPh3uNK+jxfTHqJyIRwQOMPX77gJGOiKYy0Z9jX4tlDmuNl/KjPbOIrkz1YaAlJ55M0QltHsQE5NLKTYChlIwHLVetugHeZi4DFd33Dm8mTJqvLBb+j+0so5YHjC3FklIveiODFBXBnvfySvXGa6Pbxlmfthg1EjEWkz2pfscK2DgdoSuGav+b5qxoCKNotKkcBYGmWOs5eqYZMz9NrGk/xunicFuB9kIb236b8NTiZCoB+vAb1yTp7zwytG5MoyVNhbxZHa2lBY0wXJ1mxTZGpzCBpFQIv7q3z2MdYQ47F+xB6aSSpajNvbzF5Oo+Dozk4A7zuQyLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuwWx2KCbNJ/yLgXyUs01UNRIKJdiWaX/FYMeYt269A=;
 b=uEeQqZu0dGE7OWJp13HXF310moWvEIILei/oOum3ktqniq2GJ9S7aYUacy8x6Dd5lKzTZvckjM8tbhK02mLQLb1f03YE8DjBsoPrMnr7fYfeHRvZHIP0eXgk+PMYfspkPWSVcPtZNDilx36m6tye0iFC3EVTrSyJ/8vzZNSWEsA=
Received: from BN8PR03CA0027.namprd03.prod.outlook.com (2603:10b6:408:94::40)
 by PH8PR12MB6747.namprd12.prod.outlook.com (2603:10b6:510:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 14:45:26 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:94:cafe::f0) by BN8PR03CA0027.outlook.office365.com
 (2603:10b6:408:94::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 14:45:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 14:45:26 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 09:45:23 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v5 3/7] dmaengine: ptdma: Move common functions to common code
Date: Mon, 8 Jul 2024 20:14:56 +0530
Message-ID: <20240708144500.1523651-4-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240708144500.1523651-1-Basavaraj.Natikar@amd.com>
References: <20240708144500.1523651-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|PH8PR12MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: 46fdcfe7-d814-40ed-da03-08dc9f5c9b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yS7fzWSnsS33WfRce3lHqMrpc4xhV7EWsg1jwuQlUGWk+f/8EfT1RwcthwHv?=
 =?us-ascii?Q?rhP0NUn19L9r9HMB3mK7frzjs2WCrvkpDtiZ5bavbm1sC9kNclqyGeju6WcW?=
 =?us-ascii?Q?QfwkXVIkwDzp1bxyD2ns0vZwQP6dXPcYEhFNezM+vERGxmK39kKqtVgAzq9E?=
 =?us-ascii?Q?to2K4MW1ll5WREPD4VtXdXVRExNoecRYKuj7S+7XGnvMjHv1hEQxCFopFDaI?=
 =?us-ascii?Q?xXt611MahHAzROD3Ia1YtN7NwU7oxlLSgYxX4LQ0JZXatccBnSeuytVK88Kn?=
 =?us-ascii?Q?7fMcmVhqbuebvylDSH7k4JzNMvUq5CL2s0ngRW0a6x7y5ymKQe+W5d1Up2hv?=
 =?us-ascii?Q?zCb/+qu229U0u4LSRrO8I9Oy+VMbzRrtZJvNjBuUuC9HXgTEym3QE07qExBZ?=
 =?us-ascii?Q?f0HVLnRYXjWnZS0k8xd0Pf2Fxc6UwDgSyTZ24Ba8yEU0/g9xSNE9tb1FAboN?=
 =?us-ascii?Q?EsDr+thVDLViwu2Ynp9A7x6o3FuFetakobUWcOutspidnsAnoVOtCKR7krcm?=
 =?us-ascii?Q?uy4ifFlt2pGIjX7H5pcX6Wwxqh1OUMUBKQOGJmTszf9VFI7wTOTQlj+oFbwj?=
 =?us-ascii?Q?4QI7S2XxPf9tqsSwDMPuvf4Pa6evEJmpiW39wWNHuLVJx5l5CAXPY89qsSWy?=
 =?us-ascii?Q?XV1aGgsLqcA5eqtM5QJrF3Ielf4ycg8hqRjG19kXZyccymmchHWu9jn6oDgs?=
 =?us-ascii?Q?Ykaqy3RmmvnTx16LOJi4VpWxm4cUnODmeyGjOFHZRsgLdKauUaCqWx+zyeGS?=
 =?us-ascii?Q?mWpuFHkBGMvgC6XSxlzCVHcUWIqrvsT3UDkOvWs8169KDWkRYofrl2++UWK9?=
 =?us-ascii?Q?4Ua+r5H1c7RNWXYAXymapJK3xI/bk0p3cdPyhaTlXPa69OYixlgaKDp1srXM?=
 =?us-ascii?Q?g+Z48gQPzk295VIeCzuDjcOcHW8uVezbqtvC8mrXaAO6/bnEgIl6xsfQoJwv?=
 =?us-ascii?Q?qAbR6NPzrUFMdc+xdmse5CJYlpJ+axD1v4atsmpaxnn3r7tQrMqdCM7bBp5D?=
 =?us-ascii?Q?X0ZWpZ80HiKBqWjk5866Zi5or3CTRXhVzdUr9vidTRDvFEAxJCpsGFjsvpzD?=
 =?us-ascii?Q?7VYChaP/SFatzcMM78TtyWXpUlzUriZfnq6hlmjDC1NKR3FX0I+tPWGIGmSr?=
 =?us-ascii?Q?EQIVyUVsoBeLSh4Z6ubricSmT4P+MWbSwtU+iUAcOUd2nfli2PnHg0w6Er8O?=
 =?us-ascii?Q?OvmD0yidIuVCkViN0sXA5/JxBcJCaAQvmjV+xzOHNiet1GwMkQ0j0PHLhx0e?=
 =?us-ascii?Q?bOlOpneN/Dy0BWe4Sa54jiSsKSnfRu2HYDoHRIQyKXcj4MFGeDIFQwaVVVc2?=
 =?us-ascii?Q?9omLt5GaYr58TLo9Ke0TFcWoV70gFgm33mXrF0ItxxXm7DUEc6OTpjs1kAoM?=
 =?us-ascii?Q?omJCkb2k4AnSAvrpH6tyLy74VzdjHqUMecyqs0Ts+er3H/J4rHIx7SDxmYEr?=
 =?us-ascii?Q?NgUYHoZXOzuWBBAA1TzGL56kfqEL/q37?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:45:26.4779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fdcfe7-d814-40ed-da03-08dc9f5c9b12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6747

To focus on reusability of ptdma code across modules extract common
functions into reusable modules.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 MAINTAINERS                             | 1 +
 drivers/dma/amd/ptdma/ptdma-dev.c       | 2 +-
 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 3 +--
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 539bf52410de..97d97ddf26f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -952,6 +952,7 @@ M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
 F:	drivers/dma/amd/ae4dma/
+F:	drivers/dma/amd/common/
 
 AMD AXI W1 DRIVER
 M:	Kris Chaplin <kris.chaplin@amd.com>
diff --git a/drivers/dma/amd/ptdma/ptdma-dev.c b/drivers/dma/amd/ptdma/ptdma-dev.c
index a2bf13ff18b6..2bdf418fe556 100644
--- a/drivers/dma/amd/ptdma/ptdma-dev.c
+++ b/drivers/dma/amd/ptdma/ptdma-dev.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
-#include "ptdma.h"
+#include "../common/amd_dma.h"
 
 /* Human-readable error strings */
 static char *pt_error_codes[] = {
diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index a2e7c2cec15e..66ea10499643 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -9,8 +9,7 @@
  * Author: Gary R Hook <gary.hook@amd.com>
  */
 
-#include "ptdma.h"
-#include "../../dmaengine.h"
+#include "../common/amd_dma.h"
 
 static inline struct pt_dma_chan *to_pt_chan(struct dma_chan *dma_chan)
 {
-- 
2.25.1


