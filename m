Return-Path: <dmaengine+bounces-8940-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBBSGzOMlWlhSQIAu9opvQ
	(envelope-from <dmaengine+bounces-8940-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:53:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 086F4154EE7
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFBD13035253
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 09:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0D433D6DC;
	Wed, 18 Feb 2026 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ixfa4zqD"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012064.outbound.protection.outlook.com [40.93.195.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A938F33D6F8;
	Wed, 18 Feb 2026 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408392; cv=fail; b=I3bth5bOk/A2pA5USclMM8ljTXCqw5bWoppM5Cs0gCGEaejfrDfveeM6E7+Pt+kwZF0hyhyGz6UQa1kd5+Lh6lVGkSC+5PFZ9D5zLGZqZ3jK/NJAKDgdxITUzrc57V4eI28vp/tHisxDIIsZEO571/YAXBlOJ2OnH1ndxPifEBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408392; c=relaxed/simple;
	bh=WIsasd5cJbSc55UONupHF1w8ft0Bqvx76gCFPH53hVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=de+DKM6z9CXrqJFG7lI6ogcW3y5s4c722nhtk24u8kjK9EMBMUPnPpkyl2kzP8JW/LawjgDgcQWgWO7SAqOePXVhEdfd7fD5k4gwMN/Nna70uIIIHZd4ta8tWkPQg8yrFO8nSiGHIOgqUZq6Qx1SOoA2eO9z3+BSbGTAszeN7lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ixfa4zqD; arc=fail smtp.client-ip=40.93.195.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnumCgYsRvmFB+tBGkGUN4B076Z946wEe70Gi9bua4fGC6q6jyJyiS6uTy8VV9sEeN7jvYa2fjuNdsGIXb5B1wG/wVgDeHMgaN0p5T9mx06n7oozJXrB5bFykbyaozDZvFePl+XUCqNyx4HYPP54gF7FVF3vyC4XcOo/2VSNi8jJ522HyxLtf8T7MonyyzQFBwRCzfoSSgO8GyGjEApOObS0ZoBolFUWmjbtisMwprBaQl+qLKUan/fs6qI+rT25iNVlEi2LqKf5LOP07bUp6vhxy49oAf51vIEy+xHc0+VRA+rv1ddBGe3E/myLRLt+xFNmXVJGbH3sv8rPYjwwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk4zzGSg3yIbuBXciAYnrbYUyOg2Y61i3m63DVZ7i44=;
 b=cyE4lSK1ZDiDdxMJyYugfncgIxTTDdJfNjWleoLDo38Dy2BRMnUvCRN8vIRytyxWR/iAzhayW0AgzVpL19ZzX3vIm+93amdKM3h++4x0QKQG6RM/aFTUjt2kE78lXontahyG7GOFVAx6loBM/nVq9vEfEPGYwNiXiAV99wH609JDfAiMX/pPe+NuIacA5GLGVw4Slk8ZtclOB3Wx3rvGVNe8sMfXCjkjjN8uuIbHFVWKpwhV721DKGLQZnMdcYGJE8ecAe7z+bQkyFYqZbEdJIi8FFU+wp32+EahY27KzlZF6iBEEF0P7kRw8nd3DptGIOzQXIrAoRH3Fc6OL8H9bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk4zzGSg3yIbuBXciAYnrbYUyOg2Y61i3m63DVZ7i44=;
 b=Ixfa4zqDkIVs1CFKCoaFI2EJmoZS7gwtloTkR/kmuYZeFbhxCovWV7g5XsLkKxWmXNDWscFeDIxe43lEuhMb0Noj12vXuL+yMNEBVMjvihskrzSZbkuxSCyreMW5rlE101LcJvlXwN0LC7JmpLF6Vzo776iAPSRsurWg7JUY744=
Received: from BN9PR03CA0530.namprd03.prod.outlook.com (2603:10b6:408:131::25)
 by DS0PR10MB7407.namprd10.prod.outlook.com (2603:10b6:8:15c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 09:53:08 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:131:cafe::7b) by BN9PR03CA0530.outlook.office365.com
 (2603:10b6:408:131::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Wed,
 18 Feb 2026 09:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Wed, 18 Feb 2026 09:53:06 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:53:06 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:53:06 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 03:53:06 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61I9qpI9200561;
	Wed, 18 Feb 2026 03:53:01 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v5 02/18] dmaengine: ti: k3-udma: move structs and enums to header file
Date: Wed, 18 Feb 2026 15:22:27 +0530
Message-ID: <20260218095243.2832115-3-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|DS0PR10MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abface1-3510-4547-cb1b-08de6ed38444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MqEN5cL7WnC10fS0MPoXfoXoe346BNiKgwkJ9vTxq6/oOq9G8z1gxns5XOfx?=
 =?us-ascii?Q?Ahdw5Oa3Uiw1Lsc2GEZzuhUXJAnv87QsxF6AclUVbSfZ3Ct/9qrTXc2ALIZ2?=
 =?us-ascii?Q?kk/LMFQA6a8aaGk7AvfTX3DIuGMWRd7S8tPoFSuMZc2WXNyoEkq8uWjsOmbM?=
 =?us-ascii?Q?5JX1LIkBE8ts8fE4qkW2rGj26g8d0oNARSW+6cDx2CH7XOXtjWIPB3TH2v2g?=
 =?us-ascii?Q?wqcyskGo5tP7hlaN5VfcJ9FT0+y1SZ35kQxXhaGScSEn5ZcMiCREZQqXCSCK?=
 =?us-ascii?Q?5shRsKqQU+Qr6Ar2T6ZErrkVBSImYe0O7prU02UuoncXu4+Hg3Ykx8CMOPyx?=
 =?us-ascii?Q?CEs6TYk1wojqrpkMdLB2T3LQwuiM9yuhet9QAIptPfbYMZnDNyAHbNj1BzVR?=
 =?us-ascii?Q?VRgV2DpHHg898nZnFiOmfEO7t1dny7yVOMMfiQl0hVgE+ZuvSYyNZvOb8wSZ?=
 =?us-ascii?Q?YSCg+wBt8JPW9Wc9t7U92j6ddffY7fyW1oLIdv/wJmLfbr3F7egxVZMiI3G1?=
 =?us-ascii?Q?W4RRiZUropeIG90uLftyZGcazcXHZCY1WrffxcL39Y9r+VDnnzBsGYrUl+bF?=
 =?us-ascii?Q?qXofJs69eJZHDK6DU8ObC9dlwe4RbxL7yvoCjy56iL/uhiAUjV0Q3lKx9ULS?=
 =?us-ascii?Q?ep78X6sPOVEo0EIiU7Oo94CMBfHUhYKkgtkZYz84PSEjK/RjrSD5LBkzON0h?=
 =?us-ascii?Q?pMJXuYXqCBACjT24FzFF3pW0q3vaCJj/EB6gRA6GSbYMcq9tCFO3h+opFOBZ?=
 =?us-ascii?Q?JOWAHgpP4Bl4OwlX/Be0uARjpBKEQphYpe4B7Ep9yAY+mWmxVoezd28OP/Et?=
 =?us-ascii?Q?3EEO9euZ8D07wgwYNnjDAjiITZeIjwDxRvl/zYCdCMT2SChkCquscHiswlMy?=
 =?us-ascii?Q?361HSfcV4frp8jPjf2j6Ca8Oark5GZGVEbi4AV9OR8qJKOwvxPYuqGdzWE3G?=
 =?us-ascii?Q?ABNoqxwFRGsJMToRK+ChAL0CdF0fmLDDVxFsxVIUABqF4yobNp7z6GgZkAbo?=
 =?us-ascii?Q?TVNJspgUk6vTlv1AuvobGAqv5WnwnlrdOBtxy1QlcLDk1ezphnM0g35t35HR?=
 =?us-ascii?Q?p0EEwEGURC+N6zlf6YWSJIYMQYXHusUziMW6atah27d63x0mWm0ObNk2Ax+s?=
 =?us-ascii?Q?DpTVR29f2DrlhUq/tDf7ix7RCWBQjH63HSeC09uRrVm8x7P7qIBvFAsOjemn?=
 =?us-ascii?Q?6dRwHRM17k/2XcOv6eY6GgKrz/Sg23QlYfxl3wsZB3MH+sk5WB35aSJvz0f2?=
 =?us-ascii?Q?hasLMk5A0+0IHYYIpYzUkAQDH9TOommJehy820rY9t5k0JwS3tO82/1vIUMx?=
 =?us-ascii?Q?jlhOd9x0kresS9B5XgBY9QNKDzGoqLIsMs4S4irV1uDQxiRvTc4yA/Gid05W?=
 =?us-ascii?Q?achpU+N75/R7LTWL6AKuiubtVxcI4kO7DmRmyqH3DUIiOHbnwgW5LqsFNl1+?=
 =?us-ascii?Q?4RB1WS1kDivEZM2q9aG0/vwO3XaTQgIPHYy2qABTctKyc9/xgnfBU6pNOLMg?=
 =?us-ascii?Q?sLVMFL9PvB84HcaSKOOUPeZlI3N4yCfDoVKYlVfsVd8wC98LjZMh1+SnWRpf?=
 =?us-ascii?Q?NAtC6mhE+OOOCrsqPlGVzgyP3guqM0etyOa95ZLmQrjV2zGSBs3DF+DOhGjZ?=
 =?us-ascii?Q?VTIE1R2plswBGEsJfVNiQrzf13WLvXUG9Su0eOGhRmqb?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pjuLqrXA95DXWuXKHpV82EZwJGyCLPpHlsDLXQNgA0JBKHtEuPL/u1I6I1XwVmPVAjCe/l7+mLiWGBJ2PAwV/F2Ntzi73hFcS7/OjvE/AH/Y48WwZld7okz2lYJct+dychgNJXpvBATJEAx7d1g4vRjafDLEF3asMH7llDi6qXv73wS+cX8iyPkzS8Svn2ZUi3Ku8H0WjAtxH5/UR1eAVgUrn32s8DkO0FiRFjOy6ZUMVbEh5GgHtzYcD5yY7+fwqEnZfztT3Y/sD9lB7Rz9YRfqmOJvVhfffQE+RtrQF6BMQnIYLTPrsbD+9RPWNFoKD1oS3TWw/rGiKDolNSXnhvhn+REy6EJ4DXXSwU4rkEi+qQWT3fyL9EEcXaPsfy/j2jVBuCxwy+KWbk0fTU/eJndiHVZKAzUUqh+VdOObyRLz9c6+3pRNVFUZYK0JpPqE
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 09:53:06.8216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abface1-3510-4547-cb1b-08de6ed38444
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7407
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8940-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim,ti.com:email];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 086F4154EE7
X-Rspamd-Action: no action

Move struct and enum definitions in k3-udma.c to k3-udma.h header file
for better separation and reuse.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 259 +-------------------------------------
 drivers/dma/ti/k3-udma.h | 261 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 262 insertions(+), 258 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 4cc64763de1f6..e0684d83f9791 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -24,8 +24,8 @@
 #include <linux/workqueue.h>
 #include <linux/completion.h>
 #include <linux/soc/ti/k3-ringacc.h>
-#include <linux/soc/ti/ti_sci_protocol.h>
 #include <linux/soc/ti/ti_sci_inta_msi.h>
+#include <linux/soc/ti/ti_sci_protocol.h>
 #include <linux/dma/k3-event-router.h>
 #include <linux/dma/ti-cppi5.h>
 
@@ -33,28 +33,6 @@
 #include "k3-udma.h"
 #include "k3-psil-priv.h"
 
-struct udma_static_tr {
-	u8 elsize; /* RPSTR0 */
-	u16 elcnt; /* RPSTR0 */
-	u16 bstcnt; /* RPSTR1 */
-};
-
-struct udma_chan;
-
-enum k3_dma_type {
-	DMA_TYPE_UDMA = 0,
-	DMA_TYPE_BCDMA,
-	DMA_TYPE_PKTDMA,
-};
-
-enum udma_mmr {
-	MMR_GCFG = 0,
-	MMR_BCHANRT,
-	MMR_RCHANRT,
-	MMR_TCHANRT,
-	MMR_LAST,
-};
-
 static const char * const mmr_names[] = {
 	[MMR_GCFG] = "gcfg",
 	[MMR_BCHANRT] = "bchanrt",
@@ -62,234 +40,6 @@ static const char * const mmr_names[] = {
 	[MMR_TCHANRT] = "tchanrt",
 };
 
-struct udma_tchan {
-	void __iomem *reg_rt;
-
-	int id;
-	struct k3_ring *t_ring; /* Transmit ring */
-	struct k3_ring *tc_ring; /* Transmit Completion ring */
-	int tflow_id; /* applicable only for PKTDMA */
-
-};
-
-#define udma_bchan udma_tchan
-
-struct udma_rflow {
-	int id;
-	struct k3_ring *fd_ring; /* Free Descriptor ring */
-	struct k3_ring *r_ring; /* Receive ring */
-};
-
-struct udma_rchan {
-	void __iomem *reg_rt;
-
-	int id;
-};
-
-struct udma_oes_offsets {
-	/* K3 UDMA Output Event Offset */
-	u32 udma_rchan;
-
-	/* BCDMA Output Event Offsets */
-	u32 bcdma_bchan_data;
-	u32 bcdma_bchan_ring;
-	u32 bcdma_tchan_data;
-	u32 bcdma_tchan_ring;
-	u32 bcdma_rchan_data;
-	u32 bcdma_rchan_ring;
-
-	/* PKTDMA Output Event Offsets */
-	u32 pktdma_tchan_flow;
-	u32 pktdma_rchan_flow;
-};
-
-struct udma_match_data {
-	enum k3_dma_type type;
-	u32 psil_base;
-	bool enable_memcpy_support;
-	u32 flags;
-	u32 statictr_z_mask;
-	u8 burst_size[3];
-	struct udma_soc_data *soc_data;
-};
-
-struct udma_soc_data {
-	struct udma_oes_offsets oes;
-	u32 bcdma_trigger_event_offset;
-};
-
-struct udma_hwdesc {
-	size_t cppi5_desc_size;
-	void *cppi5_desc_vaddr;
-	dma_addr_t cppi5_desc_paddr;
-
-	/* TR descriptor internal pointers */
-	void *tr_req_base;
-	struct cppi5_tr_resp_t *tr_resp_base;
-};
-
-struct udma_rx_flush {
-	struct udma_hwdesc hwdescs[2];
-
-	size_t buffer_size;
-	void *buffer_vaddr;
-	dma_addr_t buffer_paddr;
-};
-
-struct udma_tpl {
-	u8 levels;
-	u32 start_idx[3];
-};
-
-struct udma_dev {
-	struct dma_device ddev;
-	struct device *dev;
-	void __iomem *mmrs[MMR_LAST];
-	const struct udma_match_data *match_data;
-	const struct udma_soc_data *soc_data;
-
-	struct udma_tpl bchan_tpl;
-	struct udma_tpl tchan_tpl;
-	struct udma_tpl rchan_tpl;
-
-	size_t desc_align; /* alignment to use for descriptors */
-
-	struct udma_tisci_rm tisci_rm;
-
-	struct k3_ringacc *ringacc;
-
-	struct work_struct purge_work;
-	struct list_head desc_to_purge;
-	spinlock_t lock;
-
-	struct udma_rx_flush rx_flush;
-
-	int bchan_cnt;
-	int tchan_cnt;
-	int echan_cnt;
-	int rchan_cnt;
-	int rflow_cnt;
-	int tflow_cnt;
-	unsigned long *bchan_map;
-	unsigned long *tchan_map;
-	unsigned long *rchan_map;
-	unsigned long *rflow_gp_map;
-	unsigned long *rflow_gp_map_allocated;
-	unsigned long *rflow_in_use;
-	unsigned long *tflow_map;
-
-	struct udma_bchan *bchans;
-	struct udma_tchan *tchans;
-	struct udma_rchan *rchans;
-	struct udma_rflow *rflows;
-
-	struct udma_chan *channels;
-	u32 psil_base;
-	u32 atype;
-	u32 asel;
-};
-
-struct udma_desc {
-	struct virt_dma_desc vd;
-
-	bool terminated;
-
-	enum dma_transfer_direction dir;
-
-	struct udma_static_tr static_tr;
-	u32 residue;
-
-	unsigned int sglen;
-	unsigned int desc_idx; /* Only used for cyclic in packet mode */
-	unsigned int tr_idx;
-
-	u32 metadata_size;
-	void *metadata; /* pointer to provided metadata buffer (EPIP, PSdata) */
-
-	unsigned int hwdesc_count;
-	struct udma_hwdesc hwdesc[];
-};
-
-enum udma_chan_state {
-	UDMA_CHAN_IS_IDLE = 0, /* not active, no teardown is in progress */
-	UDMA_CHAN_IS_ACTIVE, /* Normal operation */
-	UDMA_CHAN_IS_TERMINATING, /* channel is being terminated */
-};
-
-struct udma_tx_drain {
-	struct delayed_work work;
-	ktime_t tstamp;
-	u32 residue;
-};
-
-struct udma_chan_config {
-	bool pkt_mode; /* TR or packet */
-	bool needs_epib; /* EPIB is needed for the communication or not */
-	u32 psd_size; /* size of Protocol Specific Data */
-	u32 metadata_size; /* (needs_epib ? 16:0) + psd_size */
-	u32 hdesc_size; /* Size of a packet descriptor in packet mode */
-	bool notdpkt; /* Suppress sending TDC packet */
-	int remote_thread_id;
-	u32 atype;
-	u32 asel;
-	u32 src_thread;
-	u32 dst_thread;
-	enum psil_endpoint_type ep_type;
-	bool enable_acc32;
-	bool enable_burst;
-	enum udma_tp_level channel_tpl; /* Channel Throughput Level */
-
-	u32 tr_trigger_type;
-	unsigned long tx_flags;
-
-	/* PKDMA mapped channel */
-	int mapped_channel_id;
-	/* PKTDMA default tflow or rflow for mapped channel */
-	int default_flow_id;
-
-	enum dma_transfer_direction dir;
-};
-
-struct udma_chan {
-	struct virt_dma_chan vc;
-	struct dma_slave_config	cfg;
-	struct udma_dev *ud;
-	struct device *dma_dev;
-	struct udma_desc *desc;
-	struct udma_desc *terminated_desc;
-	struct udma_static_tr static_tr;
-	char *name;
-
-	struct udma_bchan *bchan;
-	struct udma_tchan *tchan;
-	struct udma_rchan *rchan;
-	struct udma_rflow *rflow;
-
-	bool psil_paired;
-
-	int irq_num_ring;
-	int irq_num_udma;
-
-	bool cyclic;
-	bool paused;
-
-	enum udma_chan_state state;
-	struct completion teardown_completed;
-
-	struct udma_tx_drain tx_drain;
-
-	/* Channel configuration parameters */
-	struct udma_chan_config config;
-	/* Channel configuration parameters (backup) */
-	struct udma_chan_config backup_config;
-
-	/* dmapool for packet mode descriptors */
-	bool use_dma_pool;
-	struct dma_pool *hdesc_pool;
-
-	u32 id;
-};
-
 static inline struct udma_dev *to_udma_dev(struct dma_device *d)
 {
 	return container_of(d, struct udma_dev, ddev);
@@ -4073,13 +3823,6 @@ static struct platform_driver udma_driver;
 static struct platform_driver bcdma_driver;
 static struct platform_driver pktdma_driver;
 
-struct udma_filter_param {
-	int remote_thread_id;
-	u32 atype;
-	u32 asel;
-	u32 tr_trigger_type;
-};
-
 static bool udma_dma_filter_fn(struct dma_chan *chan, void *param)
 {
 	struct udma_chan_config *ucc;
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 750720cd06911..37aa9ba5b4d18 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -6,7 +6,12 @@
 #ifndef K3_UDMA_H_
 #define K3_UDMA_H_
 
+#include <linux/dmaengine.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
+#include <linux/dma/ti-cppi5.h>
+
+#include "../virt-dma.h"
+#include "k3-psil-priv.h"
 
 /* Global registers */
 #define UDMA_REV_REG			0x0
@@ -164,6 +169,7 @@ struct udma_dev;
 struct udma_tchan;
 struct udma_rchan;
 struct udma_rflow;
+struct udma_chan;
 
 enum udma_rm_range {
 	RM_RANGE_BCHAN = 0,
@@ -186,6 +192,261 @@ struct udma_tisci_rm {
 	struct ti_sci_resource *rm_ranges[RM_RANGE_LAST];
 };
 
+struct udma_static_tr {
+	u8 elsize; /* RPSTR0 */
+	u16 elcnt; /* RPSTR0 */
+	u16 bstcnt; /* RPSTR1 */
+};
+
+enum k3_dma_type {
+	DMA_TYPE_UDMA = 0,
+	DMA_TYPE_BCDMA,
+	DMA_TYPE_PKTDMA,
+};
+
+enum udma_mmr {
+	MMR_GCFG = 0,
+	MMR_BCHANRT,
+	MMR_RCHANRT,
+	MMR_TCHANRT,
+	MMR_LAST,
+};
+
+struct udma_filter_param {
+	int remote_thread_id;
+	u32 atype;
+	u32 asel;
+	u32 tr_trigger_type;
+};
+
+struct udma_tchan {
+	void __iomem *reg_rt;
+
+	int id;
+	struct k3_ring *t_ring; /* Transmit ring */
+	struct k3_ring *tc_ring; /* Transmit Completion ring */
+	int tflow_id; /* applicable only for PKTDMA */
+
+};
+
+#define udma_bchan udma_tchan
+
+struct udma_rflow {
+	int id;
+	struct k3_ring *fd_ring; /* Free Descriptor ring */
+	struct k3_ring *r_ring; /* Receive ring */
+};
+
+struct udma_rchan {
+	void __iomem *reg_rt;
+
+	int id;
+};
+
+struct udma_oes_offsets {
+	/* K3 UDMA Output Event Offset */
+	u32 udma_rchan;
+
+	/* BCDMA Output Event Offsets */
+	u32 bcdma_bchan_data;
+	u32 bcdma_bchan_ring;
+	u32 bcdma_tchan_data;
+	u32 bcdma_tchan_ring;
+	u32 bcdma_rchan_data;
+	u32 bcdma_rchan_ring;
+
+	/* PKTDMA Output Event Offsets */
+	u32 pktdma_tchan_flow;
+	u32 pktdma_rchan_flow;
+};
+
+struct udma_match_data {
+	enum k3_dma_type type;
+	u32 psil_base;
+	bool enable_memcpy_support;
+	u32 flags;
+	u32 statictr_z_mask;
+	u8 burst_size[3];
+	struct udma_soc_data *soc_data;
+};
+
+struct udma_soc_data {
+	struct udma_oes_offsets oes;
+	u32 bcdma_trigger_event_offset;
+};
+
+struct udma_hwdesc {
+	size_t cppi5_desc_size;
+	void *cppi5_desc_vaddr;
+	dma_addr_t cppi5_desc_paddr;
+
+	/* TR descriptor internal pointers */
+	void *tr_req_base;
+	struct cppi5_tr_resp_t *tr_resp_base;
+};
+
+struct udma_rx_flush {
+	struct udma_hwdesc hwdescs[2];
+
+	size_t buffer_size;
+	void *buffer_vaddr;
+	dma_addr_t buffer_paddr;
+};
+
+struct udma_tpl {
+	u8 levels;
+	u32 start_idx[3];
+};
+
+struct udma_dev {
+	struct dma_device ddev;
+	struct device *dev;
+	void __iomem *mmrs[MMR_LAST];
+	const struct udma_match_data *match_data;
+	const struct udma_soc_data *soc_data;
+
+	struct udma_tpl bchan_tpl;
+	struct udma_tpl tchan_tpl;
+	struct udma_tpl rchan_tpl;
+
+	size_t desc_align; /* alignment to use for descriptors */
+
+	struct udma_tisci_rm tisci_rm;
+
+	struct k3_ringacc *ringacc;
+
+	struct work_struct purge_work;
+	struct list_head desc_to_purge;
+	spinlock_t lock;
+
+	struct udma_rx_flush rx_flush;
+
+	int bchan_cnt;
+	int tchan_cnt;
+	int echan_cnt;
+	int rchan_cnt;
+	int rflow_cnt;
+	int tflow_cnt;
+	unsigned long *bchan_map;
+	unsigned long *tchan_map;
+	unsigned long *rchan_map;
+	unsigned long *rflow_gp_map;
+	unsigned long *rflow_gp_map_allocated;
+	unsigned long *rflow_in_use;
+	unsigned long *tflow_map;
+
+	struct udma_bchan *bchans;
+	struct udma_tchan *tchans;
+	struct udma_rchan *rchans;
+	struct udma_rflow *rflows;
+
+	struct udma_chan *channels;
+	u32 psil_base;
+	u32 atype;
+	u32 asel;
+};
+
+struct udma_desc {
+	struct virt_dma_desc vd;
+
+	bool terminated;
+
+	enum dma_transfer_direction dir;
+
+	struct udma_static_tr static_tr;
+	u32 residue;
+
+	unsigned int sglen;
+	unsigned int desc_idx; /* Only used for cyclic in packet mode */
+	unsigned int tr_idx;
+
+	u32 metadata_size;
+	void *metadata; /* pointer to provided metadata buffer (EPIP, PSdata) */
+
+	unsigned int hwdesc_count;
+	struct udma_hwdesc hwdesc[];
+};
+
+enum udma_chan_state {
+	UDMA_CHAN_IS_IDLE = 0, /* not active, no teardown is in progress */
+	UDMA_CHAN_IS_ACTIVE, /* Normal operation */
+	UDMA_CHAN_IS_TERMINATING, /* channel is being terminated */
+};
+
+struct udma_tx_drain {
+	struct delayed_work work;
+	ktime_t tstamp;
+	u32 residue;
+};
+
+struct udma_chan_config {
+	bool pkt_mode; /* TR or packet */
+	bool needs_epib; /* EPIB is needed for the communication or not */
+	u32 psd_size; /* size of Protocol Specific Data */
+	u32 metadata_size; /* (needs_epib ? 16:0) + psd_size */
+	u32 hdesc_size; /* Size of a packet descriptor in packet mode */
+	bool notdpkt; /* Suppress sending TDC packet */
+	int remote_thread_id;
+	u32 atype;
+	u32 asel;
+	u32 src_thread;
+	u32 dst_thread;
+	enum psil_endpoint_type ep_type;
+	bool enable_acc32;
+	bool enable_burst;
+	enum udma_tp_level channel_tpl; /* Channel Throughput Level */
+
+	u32 tr_trigger_type;
+	unsigned long tx_flags;
+
+	/* PKDMA mapped channel */
+	int mapped_channel_id;
+	/* PKTDMA default tflow or rflow for mapped channel */
+	int default_flow_id;
+
+	enum dma_transfer_direction dir;
+};
+
+struct udma_chan {
+	struct virt_dma_chan vc;
+	struct dma_slave_config	cfg;
+	struct udma_dev *ud;
+	struct device *dma_dev;
+	struct udma_desc *desc;
+	struct udma_desc *terminated_desc;
+	struct udma_static_tr static_tr;
+	char *name;
+
+	struct udma_bchan *bchan;
+	struct udma_tchan *tchan;
+	struct udma_rchan *rchan;
+	struct udma_rflow *rflow;
+
+	bool psil_paired;
+
+	int irq_num_ring;
+	int irq_num_udma;
+
+	bool cyclic;
+	bool paused;
+
+	enum udma_chan_state state;
+	struct completion teardown_completed;
+
+	struct udma_tx_drain tx_drain;
+
+	/* Channel configuration parameters */
+	struct udma_chan_config config;
+	/* Channel configuration parameters (backup) */
+	struct udma_chan_config backup_config;
+
+	/* dmapool for packet mode descriptors */
+	bool use_dma_pool;
+	struct dma_pool *hdesc_pool;
+
+	u32 id;
+};
+
 /* Direct access to UDMA low lever resources for the glue layer */
 int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
 int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
-- 
2.34.1


