Return-Path: <dmaengine+bounces-8605-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLVkF6yQfGkQNwIAu9opvQ
	(envelope-from <dmaengine+bounces-8605-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:06:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 126A4B9C5C
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11F643067B3E
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 11:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4453E37A4AB;
	Fri, 30 Jan 2026 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JgDsbCHK"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F49637A48D;
	Fri, 30 Jan 2026 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769770999; cv=fail; b=hPkDsaVNO/Kz9C5AhzERxdYxi1IXDgbMQhhXiGoa1YmNFcApLRmrdG3EvjCyJdYDmDcTutmPa3dhzkhZ5emuGH87GBd9IA8B0paPynI3d0JEk5JRy7v+8kmMqn8AAqdF23Pjrgg3WTYCo3cTBf3FWQNWVtoG4ojC5axwHVv6Wig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769770999; c=relaxed/simple;
	bh=b+fSWLF+RM0n6bTnFNPCM1eHEZECio1n9c3SFFB8BBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nsm/aiUtIasyARIc2b+oQgGjm06/JrssXqn9SyWclGlQANQ/LVZJ4+xutDkYlcQoNPhVxvzSTheSKVSBFhShIy9DCko6qL5qhNqGQ+rfoAAM4Yg12fAnHsZsMbrh+MptQ8ULJWZNjFSy92+ZJO4A3ZUfXT3mb29pmaBT4axvtek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JgDsbCHK; arc=fail smtp.client-ip=52.101.53.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amzYVNPt7TbP2zLQiD90v1MRmledV2CK1z47Oq3/bjgufPHQprgpo4M7RGR1cMPbJRSERNrAKPaN6lMxiqwq98bFwvOnDh7j0mWLbz1fJIUcuIMn+2fLH6zIPx7xRYdoaNyBN43v9LhjFBcFLZaGVeVSiLYfXP8HHNTJgi1SJ3/hDRiWPPtzrZhgBHwz5M9FP4qtdlH8DPnQ6J3XZVBBGu1KyKToQ/wWvBc08xx04jFBMs6WEE+meBIwlg512QrHutrNoKoTXR1B7/CJLr0vRJQ5eY9xIMQVTVppUUU8fEX4CRoOUo5DDVgjeh6WhpKkoQ9oJu28IjeFueIzR7aq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0/HmFBS5vdlUkvGjdwZj6BcIDLHN0SiqNu69mf9R/4=;
 b=LbvqUu1A83SGCyc4s+x/QZZY6YFFZD5n5qi2ViGuEpGKdr/sNidZLKBpao0KgJKsUWvUT2FIqEABOJxImzefu4YzsW90/NyZpISjRoZdkLRitF9G4bqJVZRmhC6WekLk3fuHAfDhvTK63wJNTQCpfbwSa5HFFRMP91gFCITu2+yjTn6pQ7TEUSFge26VcIMm1KUcYp1+Ps+f/kh2UqPTyFRl1yK0PJAOk+efI6TIvoqgDQND+ffoy9Q47eaTJsbXUKWYCWXBqmn45QQT32CBnzvpiEgSpTlE9LXaWyGq/QNHz9np7Y8NtLuL8J9dfQak2ezT+BgbCCZDXzeyr+lOww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0/HmFBS5vdlUkvGjdwZj6BcIDLHN0SiqNu69mf9R/4=;
 b=JgDsbCHKIm5cAS2jstMvIFC/IfwYDq6VqnuKtAZ24ulFLh13fBqiNw5PRpPLyBCjaeM8mAvP61t7i8DV1fjpc0EBukV93HPUjfwOtW1DRqKimcZxe2JnbiPmyZHPtLR9ARG4TH15QW96H346122zJeVq1Cf8+uzN5P01Oy6cakA=
Received: from SJ0PR05CA0014.namprd05.prod.outlook.com (2603:10b6:a03:33b::19)
 by SN4PR10MB5656.namprd10.prod.outlook.com (2603:10b6:806:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 11:03:12 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::19) by SJ0PR05CA0014.outlook.office365.com
 (2603:10b6:a03:33b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.2 via Frontend Transport; Fri,
 30 Jan 2026 11:03:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 11:03:10 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:03:10 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:03:09 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 30 Jan 2026 05:03:09 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60UB2HBo1204392;
	Fri, 30 Jan 2026 05:03:05 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v4 11/19] drivers: soc: ti: k3-ringacc: handle absence of tisci
Date: Fri, 30 Jan 2026 16:31:51 +0530
Message-ID: <20260130110159.359501-12-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|SN4PR10MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad110e3-1902-4bd3-abab-08de5fef281f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Xfup1vafxq5hUuUJieAwgscodr7KAuXxPAsFcFIl7nH3YDwetXRgGC/mO2r?=
 =?us-ascii?Q?RnuP4Ivj36ZqCd9xxYaeFvTCpxl5N2ffwx8YszA/g3XDpmLIX7R1P2cdPPyk?=
 =?us-ascii?Q?JZRizEcIziiXFbLx6FuULhZ/zDkgws+zXzDa7rHUMFNWEpAD2nucVg3klwmX?=
 =?us-ascii?Q?ciqKLRH+uyQvSIFF1XGfGi9exRBgqRpK8oBX5EgUjaAsL5Le7JK70TBckTfy?=
 =?us-ascii?Q?LMVOqtSmteK81536hBlm/6TJkdcvfMoxiL5yRf+EPCF7vX1gq2cDLbmdeD4c?=
 =?us-ascii?Q?Kj8WIP2HENvOyoaXbCOqDXfOgUEoIIuVyCEdD87koHTTrwOkZwC0jxpFTVZJ?=
 =?us-ascii?Q?5QnhT86hwyLx+H/Up5yvJzF7zj82gYX+kGuCpp7NDscJ6HwRKNIETbC0bcEd?=
 =?us-ascii?Q?j/GqXofIhCInwTglAv1jyQ4HQFqQU5phIpsGzNUqP9YgOKdqwqP7o9T65IWK?=
 =?us-ascii?Q?KG+s5A65Nse4b+weNjWoe2T4rTWOBVc8GGsD96+k42zMwhn84rKgy2/L/rvA?=
 =?us-ascii?Q?rafW0HeEHdXYdj/QCv8hKoKIvm5qeYO6kxrOktifcU8LZU+OHF3mGXL0Qp2P?=
 =?us-ascii?Q?EmPJmaj1vQ6ZWy7kIWR47VvsOeCYyBEZP+Qu1Mo9h2//omQfVoA4jGZK/XpL?=
 =?us-ascii?Q?xY6PULB87oT9PZ2f4r+//vRiBlCwFh34kGBVGr1E/9JkiZAFcBFSvNk4jmwc?=
 =?us-ascii?Q?8oMuSUAR+kaRfG52vVkSje7ufONgD3BVjcZ+oS6UpKMDK43IhYFoRf+QJjp7?=
 =?us-ascii?Q?oMCwuRrJ90eIkTu4U67x1kSjNy5AMQIJQmLvRI5xxuln5gs7urRG0pK7X3j6?=
 =?us-ascii?Q?+BOQx+tswqM9xOYBCh16+jTf36de6OYqXwbbRJu6AySKNM+lvaISX7WMOmef?=
 =?us-ascii?Q?WR/KVVP1WkkRT833kF6T18756FHFCxWG4idZtfmqcqR7gURj70bEp3UnWWTG?=
 =?us-ascii?Q?nG6aQunaUcqsJ8rZbrx1IUY7hS0xtAqmysDbCBMhSEl+bUA36mFnoJIOAvjf?=
 =?us-ascii?Q?/Wtkz1zaO3IxnvT36JWad/LbEwcMXlGsg+K8n08kB8tA4KES1cF41Wqq1VKB?=
 =?us-ascii?Q?kxuWtGPHbm7PiekGDQdF1vHnxivcAQtXliIyBMIhqnd0dCAc8pNkpAOjCONq?=
 =?us-ascii?Q?J7wy+ecTPFD1/QzdoeZjaoj8tCrquIfilTA/2/LK5++vPZmCSkB5jlIhkSHY?=
 =?us-ascii?Q?CkjEmSETKiriPA79o02Q38oqS0YsWCM4pD7FVqpAGt6T6ZW6dE5K7XcG3QBK?=
 =?us-ascii?Q?++bzr39Jt/ohy+TCloaUbG3QgYYgUQUlGtlGOZQrqgdL9Ng0Ec90HrFSCuzr?=
 =?us-ascii?Q?OCN+jxw0ymaTst8oYb8g8WfSsFvylZ64R8QJ5pTsGoiqcDiURdz8iMluIHBd?=
 =?us-ascii?Q?pkpfnysG7EnGKZ2PhY/9IGwmEgRV45OqME11B+hjiZHo0o+qKO/9/Ovi5B4r?=
 =?us-ascii?Q?XETcHaTpo2XfnriO1h8K8l7YjJIsbBRLuwyt3ILdsw/5tXieHwGtvl4ujzuJ?=
 =?us-ascii?Q?JLFq/KCPcNDfFGoKKBeSs6Y6eFs4m851uQG8rjH3v/vzOmRhRBypri7vFYzB?=
 =?us-ascii?Q?37hAMdxd9awa0q2ufzxTWBSQyEW5yTnMlrqyt4i8m1COyx7F1+ZQnavqs3+P?=
 =?us-ascii?Q?BLmvH5KTy6eInWT9REvvfQHRLmRqWvuC3CMq9sMBODTNNvpqkKnM7el5XqHT?=
 =?us-ascii?Q?bbpE8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0VzbYZJRXcrGp8VSk9/EVq/Si0Lwzxt8cwltM/gOmQvagbez1EiFzo7cQaDdzyKxwmliAEh5eQFU0R6muvZR25YbV3SrNkTFX77jdAUGlqVEPMSP956P4xABZ2E5dl1cuk6K5Oh5Xd1nwSUNLjGXDjqMYqfXgx6eW5+06lWsor4IVC2vVzm1JcxXUQ0He9GStKbdgKCYWL0TDfHheeku/wSBm/1KMwM4TP/23NA6OhoWfuI1msAklCX+MtxcBbSih2SBH2kCh87VffQqkFCqnc8sGgAfjhsbxdnR0Cb5Av1rmAKEtse81W62HcZKhOhI3UhYTw2C8zS/1+EkexStS+yuq8ZqvkMUgz9K3Ux95ey3VRsKDmb8VaHjWYFADsgYFVsYkSOXEuwNUBuXehytdESYkJgM/7jWiNnBqUbYtCZYcOED1FzYnwP+2DhJHOs5
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 11:03:10.6883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad110e3-1902-4bd3-abab-08de5fef281f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5656
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8605-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 126A4B9C5C
X-Rspamd-Action: no action

Handle absence of tisci with direct register writes. This will support
platforms that do not have tisci firmware like AM62L.

Remove TI_SCI_INTA_IRQCHIP dependency for TI_K3_RINGACC in Kconfig as
it is required conditionally (only for devices that has TI_SCI).

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/soc/ti/Kconfig            |   1 -
 drivers/soc/ti/k3-ringacc.c       | 188 ++++++++++++++++++++++++++----
 include/linux/soc/ti/k3-ringacc.h |  17 +++
 3 files changed, 181 insertions(+), 25 deletions(-)

diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index 163aadd589d3a..5499c0def527a 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -53,7 +53,6 @@ config WKUP_M3_IPC
 config TI_K3_RINGACC
 	tristate "K3 Ring accelerator Sub System"
 	depends on ARCH_K3 || COMPILE_TEST
-	depends on TI_SCI_INTA_IRQCHIP
 	help
 	  Say y here to support the K3 Ring accelerator module.
 	  The Ring Accelerator (RINGACC or RA)  provides hardware acceleration
diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 7602b8a909b05..fd7c960a3fa2a 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -45,6 +45,53 @@ struct k3_ring_rt_regs {
 	u32	hwindx;
 };
 
+#define K3_RINGACC_RT_CFG_REGS_OFS	0x40
+#define K3_DMARING_CFG_ADDR_HI_MASK	GENMASK(3, 0)
+#define K3_DMARING_CFG_ASEL_SHIFT	16
+#define K3_DMARING_CFG_SIZE_MASK	GENMASK(15, 0)
+
+/**
+ * struct k3_ring_cfg_regs - The RA Configuration Registers region
+ *
+ * @ba_lo: Ring Base Address Low Register
+ * @ba_hi: Ring Base Address High Register
+ * @size: Ring Size Register
+ */
+struct k3_ring_cfg_regs {
+	u32	ba_lo;
+	u32	ba_hi;
+	u32	size;
+};
+
+#define K3_RINGACC_RT_INT_REGS_OFS		0x140
+#define K3_RINGACC_RT_INT_ENABLE_SET_COMPLETE	BIT(0)
+#define K3_RINGACC_RT_INT_ENABLE_SET_TR			BIT(2)
+
+/**
+ * struct k3_ring_intr_regs {
+ *
+ * @enable_set: Ring Interrupt Enable Register
+ * @resv_1: Reserved
+ * @clr: Ring Interrupt Clear Register
+ * @resv_2: Reserved
+ * @status_set: Ring Interrupt Status Set Register
+ * @resv_3: Reserved
+ * @status: Ring Interrupt Status Register
+ * @resv_4: Reserved
+ * @status_masked: Ring Interrupt Status Masked Register
+ */
+struct k3_ring_intr_regs {
+	u32	enable_set;
+	u32	resv_1;
+	u32	clr;
+	u32	resv_2;
+	u32	status_set;
+	u32	resv_3;
+	u32	status;
+	u32	resv_4;
+	u32	status_masked;
+};
+
 #define K3_RINGACC_RT_REGS_STEP			0x1000
 #define K3_DMARING_RT_REGS_STEP			0x2000
 #define K3_DMARING_RT_REGS_REVERSE_OFS		0x1000
@@ -138,6 +185,8 @@ struct k3_ring_state {
  * struct k3_ring - RA Ring descriptor
  *
  * @rt: Ring control/status registers
+ * @cfg: Ring config registers
+ * @intr: Ring interrupt registers
  * @fifos: Ring queues registers
  * @proxy: Ring Proxy Datapath registers
  * @ring_mem_dma: Ring buffer dma address
@@ -157,6 +206,8 @@ struct k3_ring_state {
  */
 struct k3_ring {
 	struct k3_ring_rt_regs __iomem *rt;
+	struct k3_ring_cfg_regs __iomem *cfg;
+	struct k3_ring_intr_regs __iomem *intr;
 	struct k3_ring_fifo_regs __iomem *fifos;
 	struct k3_ringacc_proxy_target_regs  __iomem *proxy;
 	dma_addr_t	ring_mem_dma;
@@ -466,15 +517,31 @@ static void k3_ringacc_ring_reset_sci(struct k3_ring *ring)
 	struct k3_ringacc *ringacc = ring->parent;
 	int ret;
 
-	ring_cfg.nav_id = ringacc->tisci_dev_id;
-	ring_cfg.index = ring->ring_id;
-	ring_cfg.valid_params = TI_SCI_MSG_VALUE_RM_RING_COUNT_VALID;
-	ring_cfg.count = ring->size;
+	if (!ringacc->tisci) {
+		u32 reg;
 
-	ret = ringacc->tisci_ring_ops->set_cfg(ringacc->tisci, &ring_cfg);
-	if (ret)
-		dev_err(ringacc->dev, "TISCI reset ring fail (%d) ring_idx %d\n",
-			ret, ring->ring_id);
+		if (!ring->cfg)
+			return;
+
+		reg = readl(&ring->cfg->size);
+		reg &= ~K3_DMARING_CFG_SIZE_MASK;
+		writel(reg, &ring->cfg->size);
+
+		/* Ensure the register clear operation completes before writing new value */
+		wmb();
+		reg |= ring->size;
+		writel(reg, &ring->cfg->size);
+	} else {
+		ring_cfg.nav_id = ringacc->tisci_dev_id;
+		ring_cfg.index = ring->ring_id;
+		ring_cfg.valid_params = TI_SCI_MSG_VALUE_RM_RING_COUNT_VALID;
+		ring_cfg.count = ring->size;
+
+		ret = ringacc->tisci_ring_ops->set_cfg(ringacc->tisci, &ring_cfg);
+		if (ret)
+			dev_err(ringacc->dev, "TISCI reset ring fail (%d) ring_idx %d\n",
+				ret, ring->ring_id);
+	}
 }
 
 void k3_ringacc_ring_reset(struct k3_ring *ring)
@@ -500,10 +567,25 @@ static void k3_ringacc_ring_reconfig_qmode_sci(struct k3_ring *ring,
 	ring_cfg.valid_params = TI_SCI_MSG_VALUE_RM_RING_MODE_VALID;
 	ring_cfg.mode = mode;
 
-	ret = ringacc->tisci_ring_ops->set_cfg(ringacc->tisci, &ring_cfg);
-	if (ret)
-		dev_err(ringacc->dev, "TISCI reconf qmode fail (%d) ring_idx %d\n",
-			ret, ring->ring_id);
+	if (!ringacc->tisci) {
+		u32 reg;
+
+		writel(ring_cfg.addr_lo, &ring->cfg->ba_lo);
+		writel((ring_cfg.addr_hi & K3_DMARING_CFG_ADDR_HI_MASK) +
+				(ring_cfg.asel << K3_DMARING_CFG_ASEL_SHIFT),
+				&ring->cfg->ba_hi);
+
+		reg = readl(&ring->cfg->size);
+		reg &= ~K3_DMARING_CFG_SIZE_MASK;
+		reg |= ring_cfg.count & K3_DMARING_CFG_SIZE_MASK;
+
+		writel(reg, &ring->cfg->size);
+	} else {
+		ret = ringacc->tisci_ring_ops->set_cfg(ringacc->tisci, &ring_cfg);
+		if (ret)
+			dev_err(ringacc->dev, "TISCI reconf qmode fail (%d) ring_idx %d\n",
+				ret, ring->ring_id);
+	}
 }
 
 void k3_ringacc_ring_reset_dma(struct k3_ring *ring, u32 occ)
@@ -575,10 +657,25 @@ static void k3_ringacc_ring_free_sci(struct k3_ring *ring)
 	ring_cfg.index = ring->ring_id;
 	ring_cfg.valid_params = TI_SCI_MSG_VALUE_RM_ALL_NO_ORDER;
 
-	ret = ringacc->tisci_ring_ops->set_cfg(ringacc->tisci, &ring_cfg);
-	if (ret)
-		dev_err(ringacc->dev, "TISCI ring free fail (%d) ring_idx %d\n",
-			ret, ring->ring_id);
+	if (!ringacc->tisci) {
+		u32 reg;
+
+		writel(ring_cfg.addr_lo, &ring->cfg->ba_lo);
+		writel((ring_cfg.addr_hi & K3_DMARING_CFG_ADDR_HI_MASK) +
+				(ring_cfg.asel << K3_DMARING_CFG_ASEL_SHIFT),
+				&ring->cfg->ba_hi);
+
+		reg = readl(&ring->cfg->size);
+		reg &= ~K3_DMARING_CFG_SIZE_MASK;
+		reg |= ring_cfg.count & K3_DMARING_CFG_SIZE_MASK;
+
+		writel(reg, &ring->cfg->size);
+	} else {
+		ret = ringacc->tisci_ring_ops->set_cfg(ringacc->tisci, &ring_cfg);
+		if (ret)
+			dev_err(ringacc->dev, "TISCI ring free fail (%d) ring_idx %d\n",
+				ret, ring->ring_id);
+	}
 }
 
 int k3_ringacc_ring_free(struct k3_ring *ring)
@@ -669,15 +766,30 @@ int k3_ringacc_get_ring_irq_num(struct k3_ring *ring)
 }
 EXPORT_SYMBOL_GPL(k3_ringacc_get_ring_irq_num);
 
+u32 k3_ringacc_ring_get_irq_status(struct k3_ring *ring)
+{
+	struct k3_ringacc *ringacc = ring->parent;
+	struct k3_ring *ring2 = &ringacc->rings[ring->ring_id];
+
+	return readl(&ring2->intr->status);
+}
+EXPORT_SYMBOL_GPL(k3_ringacc_ring_get_irq_status);
+
+void k3_ringacc_ring_clear_irq(struct k3_ring *ring)
+{
+	struct k3_ringacc *ringacc = ring->parent;
+	struct k3_ring *ring2 = &ringacc->rings[ring->ring_id];
+
+	writel(0xFF, &ring2->intr->status);
+}
+EXPORT_SYMBOL_GPL(k3_ringacc_ring_clear_irq);
+
 static int k3_ringacc_ring_cfg_sci(struct k3_ring *ring)
 {
 	struct ti_sci_msg_rm_ring_cfg ring_cfg = { 0 };
 	struct k3_ringacc *ringacc = ring->parent;
 	int ret;
 
-	if (!ringacc->tisci)
-		return -EINVAL;
-
 	ring_cfg.nav_id = ringacc->tisci_dev_id;
 	ring_cfg.index = ring->ring_id;
 	ring_cfg.valid_params = TI_SCI_MSG_VALUE_RM_ALL_NO_ORDER;
@@ -688,6 +800,24 @@ static int k3_ringacc_ring_cfg_sci(struct k3_ring *ring)
 	ring_cfg.size = ring->elm_size;
 	ring_cfg.asel = ring->asel;
 
+	if (!ringacc->tisci) {
+		u32 reg;
+
+		writel(ring_cfg.addr_lo, &ring->cfg->ba_lo);
+		writel((ring_cfg.addr_hi & K3_DMARING_CFG_ADDR_HI_MASK) +
+				(ring_cfg.asel << K3_DMARING_CFG_ASEL_SHIFT),
+				&ring->cfg->ba_hi);
+
+		reg = readl(&ring->cfg->size);
+		reg &= ~K3_DMARING_CFG_SIZE_MASK;
+		reg |= ring_cfg.count & K3_DMARING_CFG_SIZE_MASK;
+
+		writel(reg, &ring->cfg->size);
+		writel(K3_RINGACC_RT_INT_ENABLE_SET_COMPLETE | K3_RINGACC_RT_INT_ENABLE_SET_TR,
+		       &ring->intr->enable_set);
+		return 0;
+	}
+
 	ret = ringacc->tisci_ring_ops->set_cfg(ringacc->tisci, &ring_cfg);
 	if (ret)
 		dev_err(ringacc->dev, "TISCI config ring fail (%d) ring_idx %d\n",
@@ -1346,8 +1476,11 @@ static int k3_ringacc_probe_dt(struct k3_ringacc *ringacc)
 		return PTR_ERR(ringacc->rm_gp_range);
 	}
 
-	return ti_sci_inta_msi_domain_alloc_irqs(ringacc->dev,
-						 ringacc->rm_gp_range);
+	if (IS_ENABLED(CONFIG_TI_K3_UDMA))
+		return ti_sci_inta_msi_domain_alloc_irqs(ringacc->dev,
+			ringacc->rm_gp_range);
+	else
+		return 0;
 }
 
 static const struct k3_ringacc_soc_data k3_ringacc_soc_data_sr1 = {
@@ -1480,9 +1613,12 @@ struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,
 
 	mutex_init(&ringacc->req_lock);
 
-	base_rt = devm_platform_ioremap_resource_byname(pdev, "ringrt");
-	if (IS_ERR(base_rt))
-		return ERR_CAST(base_rt);
+	base_rt = data->base_rt;
+	if (!base_rt) {
+		base_rt = devm_platform_ioremap_resource_byname(pdev, "ringrt");
+		if (IS_ERR(base_rt))
+			return ERR_CAST(base_rt);
+	}
 
 	ringacc->rings = devm_kzalloc(dev,
 				      sizeof(*ringacc->rings) *
@@ -1498,6 +1634,10 @@ struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,
 		struct k3_ring *ring = &ringacc->rings[i];
 
 		ring->rt = base_rt + K3_DMARING_RT_REGS_STEP * i;
+		ring->cfg = base_rt + K3_RINGACC_RT_CFG_REGS_OFS +
+			    K3_DMARING_RT_REGS_STEP * i;
+		ring->intr = base_rt + K3_RINGACC_RT_INT_REGS_OFS +
+			     K3_DMARING_RT_REGS_STEP * i;
 		ring->parent = ringacc;
 		ring->ring_id = i;
 		ring->proxy_id = K3_RINGACC_PROXY_NOT_USED;
diff --git a/include/linux/soc/ti/k3-ringacc.h b/include/linux/soc/ti/k3-ringacc.h
index 39b022b925986..9f2d141c988bd 100644
--- a/include/linux/soc/ti/k3-ringacc.h
+++ b/include/linux/soc/ti/k3-ringacc.h
@@ -158,6 +158,22 @@ u32 k3_ringacc_get_ring_id(struct k3_ring *ring);
  */
 int k3_ringacc_get_ring_irq_num(struct k3_ring *ring);
 
+/**
+ * k3_ringacc_ring_get_irq_status - Get the irq status for the ring
+ * @ring: pointer on ring
+ *
+ * Returns the interrupt status
+ */
+u32 k3_ringacc_ring_get_irq_status(struct k3_ring *ring);
+
+/**
+ * k3_ringacc_ring_clear_irq - Clear all interrupts
+ * @ring: pointer on ring
+ *
+ * Clears all the interrupts on the ring
+ */
+void k3_ringacc_ring_clear_irq(struct k3_ring *ring);
+
 /**
  * k3_ringacc_ring_cfg - ring configure
  * @ring: pointer on ring
@@ -262,6 +278,7 @@ struct k3_ringacc_init_data {
 	const struct ti_sci_handle *tisci;
 	u32 tisci_dev_id;
 	u32 num_rings;
+	void __iomem *base_rt;
 };
 
 struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,
-- 
2.34.1


