Return-Path: <dmaengine+bounces-8949-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CjwN5KMlWlVSQIAu9opvQ
	(envelope-from <dmaengine+bounces-8949-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:55:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A55F154F8C
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E8C430821D6
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4607833DEC2;
	Wed, 18 Feb 2026 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OAk3x+i5"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E88A33D6EF;
	Wed, 18 Feb 2026 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408436; cv=fail; b=J/+YiTEiUAvM36tqYlwJLHE0uckePzPwjbNmOlQj2hl2g2xdN2K0+O7ge6Gr9/lvWbJOb0sF+a0xwPhUzv9o2RJTEPY74wHiECZdSEohFJrAUtmIUOalCxWZU9jZwypGC9HjJZf8l9KOd8+yVITUf1UGJ0hInLUqI+YYm/EbHCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408436; c=relaxed/simple;
	bh=Q7eBslk+WFgaulzBa+TthOTZuCt25ESQVTfGz+dys5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkTyUQoANj4QzBvA1wEJEZRIyV2Mg/cfp7lTdXnLREWMbN/5DaL7QOuAIugPr1JtOQ/1U7HrIh5Fbv90cAsb4OAhCreUty4rGdpeRolO3d1VZAogfIPlHTyWgwyVD5RyF1TI0fkTIH1LJeKq88DfsbVNEc+rmCtBkecpEPZAXOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OAk3x+i5; arc=fail smtp.client-ip=52.101.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y98SsAiBDRz8B7Pwkn3PwIimCFej4MyLrnv5Kz+g3bhUmjm9QUdlyN05GhcujPq6SskJsgJCZWpe2KA2Bl4DhDgLFsHVqFQ3cPBpnCq1Vnnb+JDvEeME/MnZUJNSzG/Bz6KGBBMFlF4p2DL0R+4Kt9FLx6qDZGxlc69k+GOFAB9+LVlHs9aEFRFGVWwM7rjsldLRDlJ4fcyzTSWHcDouj0fkTVNFk5H+61waK3HCt02Fr1rRfA3aOy55DKiNl9+lfVw9oZ/zDjd6eybsvef2UMnAhaltag3TFzVzXAkOOU82bOkuoWqFNTql34twLAO5JPl9x5bQfiiDHFfRVrNDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxH+sMjOgYOYV3RFcp59/xH5SYTEjrLw0sW5DjhsE0M=;
 b=EevFmvuLDHahxUUGyZ/8ud0z8gsubqJw2BOyF0WXTaU/GtWoWpc54qC+A4pa38uB/LHr5CJpGur6F5r6qg5nJjFfZmOCru2zYKUjutSWyz/zRCWxKj9/wRa3EJMxWKUWiQa6ylxlHJ3ua5Tlt/LgzvGIvTWqYSRCABH9++wOusLkmPNq3/Duax5eDuesV4XInBXZnqaJHH+qr3f3ulRn+3v5WqBhAkhfsq3pvTUiF4SiJHDxPATSdT2cVGkvp3WFaocWzRLMucIbseJ2ghJPqbzpAbgIsL8ZTyYV7Ka5h/p0yKjpkldf9ZFPiwrng2AOFPeLhVVFxBkKzsafZkMmpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxH+sMjOgYOYV3RFcp59/xH5SYTEjrLw0sW5DjhsE0M=;
 b=OAk3x+i5CHKhLkwMFGsLEVMrlc70Zj8BFCSPiIF05NjPDDtqhTswDmeSEtFObRdlcZOMGBVA+LkIWsBeLXRBWMLs5pgzvFrwZGdqHXvw7vlyBB5MNdbaCfEDoyYO7i8Mko5mSqv1Wo05CKDgWzdV16PXsp3Bz/VRneKKjSOBbhA=
Received: from PH8P220CA0043.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::13)
 by CH2PR10MB4374.namprd10.prod.outlook.com (2603:10b6:610:af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 09:53:50 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:2d9:cafe::cd) by PH8P220CA0043.outlook.office365.com
 (2603:10b6:510:2d9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 09:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 09:53:50 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:53:49 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:53:49 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 03:53:49 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61I9qpII200561;
	Wed, 18 Feb 2026 03:53:45 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v5 11/18] drivers: soc: ti: k3-ringacc: handle absence of tisci
Date: Wed, 18 Feb 2026 15:22:36 +0530
Message-ID: <20260218095243.2832115-12-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|CH2PR10MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a1161e-06ec-4fad-bfe2-08de6ed39e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1QuRzfpR3bb0qPRv6cQA5cH30v66vs+L5qxalJpSIhUqZ2Qk+oz1fOaTDLzi?=
 =?us-ascii?Q?Cik1Mk52/sxBasjtZyzmmWWBkd6hrH65ctthjb7E56fVcPv0FCRv6sv1SfZO?=
 =?us-ascii?Q?efJIE3mtZj+Aniu6Dk9nGnJyngUpN1Q+Vt/AMP8OKC2bSki9lHqYHXWb4+ky?=
 =?us-ascii?Q?yBALyv0uxgfbcKUwROHAaOY7gA6Q71s9AKVai9tJzX5GsU3NICYFRoZ2VC0k?=
 =?us-ascii?Q?XwR3s80QV+npxvAlRKiMAOaH9dedXR7FyhmNs0/p4/pYk2DxbWAl8bJrkjj0?=
 =?us-ascii?Q?VCQ9nEfg+oQ1mZqOYi2kW/Wl6PU4z/W4EDwkAKPtE4enNIympLJya1cFsUoc?=
 =?us-ascii?Q?OC7OHqs4wxZUy6gSqSRUWhPeFPRbqDmQ29gsFtDQT28LqzKt60UhgvhqbFIl?=
 =?us-ascii?Q?x1UdUH4TZ9y1mTRsmB5pfXKWSan8o5NF6j3SdgQ2ixGhv+m70mNY5OHpCfoA?=
 =?us-ascii?Q?Ow2QE0v4JQtPy2LMORkHbxViahHfRY+RYT0wUkWzBtOMzfm0D93CY35y/Xm0?=
 =?us-ascii?Q?1GcfzTX1POVXrJ8BSsYEsQACFVgpmRolT1iuocmHLRpVhJ64ipw242iabWOq?=
 =?us-ascii?Q?p2bGYDCsp9CLwDFWLBsAPh3L4UqaVnVPP41UXQswNmg5pF4hX0ccjA8Zbw+O?=
 =?us-ascii?Q?g9hXohoT2MzlbZmVokIxwfhvNJKm40X35OdQ7BaIcxRPhPDdAXxjeWmEvFL6?=
 =?us-ascii?Q?aogfjJNlVfVW8z9/pxRVn765oMRs1qatsb1Jb5iHwUZiqrbPA6jQtr1p32aB?=
 =?us-ascii?Q?Zr9bMmPkmX9dQlsBbgMmRmIFCNCn9twDJcPFf+v/fpGVy88gjqP0DsKiJ8xC?=
 =?us-ascii?Q?iDyj+F5ic/oaUzRiK0RnadPg/rqdfgDLLII0ppxn5bVMD7gaYk0B9YoAykjx?=
 =?us-ascii?Q?kUFheNKCpo5bgtOI27G5jxpWOxc6DYIsETFDNh/kGF6llS/Ev9d0L/7/Jvh/?=
 =?us-ascii?Q?bSMvXuG+UQdW7QAjJQ+euW4YAFXseJmDHoXDGiZjoFzAR1F6QsWj6uCT3W4N?=
 =?us-ascii?Q?tRoDXoO+TMJ0c7p/BlzdOfVwmV1rQfFM2bTxt0eeJUsYJaZ0+zrAon2xT21z?=
 =?us-ascii?Q?DeCSPosB9xTWsz9tydyn7xT4HrD4cAc+xLcH3dWsUeJxusnHY7HzGngRLVne?=
 =?us-ascii?Q?pEbq6M/8m01wgwks9jKhZdYs7PoyxhcKd4PMNxbQdT/BqUvmxao/dJcUeMYx?=
 =?us-ascii?Q?lc+RRGqM3pbA7QeNP0ixwA6u6hbLE9e8ziNi60C/CSgDPpOuHWe5tTxqovDc?=
 =?us-ascii?Q?oRrPmY04HrrdomtUeHSl3nrbjdNQQYZblGkL7uviFWrzT90jNiWMao824K2c?=
 =?us-ascii?Q?1KFLFqdzRqmuTqDD7PMOmz29ZYZJ2QnAZcjkzoCYftTuOEq1ZcbTRSGRV4rx?=
 =?us-ascii?Q?awVEF2nOHEbYxgoWb377piwZ5zY9cpNr0dcD9jjTmBQyqCZ4/MjFLC2tx4SX?=
 =?us-ascii?Q?9B3krBeLc5pzf/jrj0nOdsBBclSmEX+CPvCfP1cpuXWADuwOppprJdKfPV1g?=
 =?us-ascii?Q?2kWuD6mBoYnZCd9RdfH+/0KnPW7FvtSCR1h08A3wuzlNOWkLnnJL5JTZgeST?=
 =?us-ascii?Q?9YRAlEBCZx2xzMr59z43nuVT7FsaGII2R9RDCnZ5Hcs3BXJ+f1MTEKnCwFQs?=
 =?us-ascii?Q?lC5/D112stjORJ7l0D8CzXJF9DSPThFuH+ogCEA6aKPg87clX2rz287fYu6o?=
 =?us-ascii?Q?nwRYVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lsxswAtFmUeCgjMMiTRI/Tf21MD7ewREIWDtMUoBOxuMXyV8KSdozcZCGTmFG65bpkhp5R3TLg8DhnH8KHFpp0LxS8MGh97qVYzbAKiF11lepNkPBTqCkqAxAdBBZ6St20hz2G78va3rz4DYuaGuyCbpBVO//rNA0mHcilI90hV+4mIpSu5PT4Drel3DYHxbSuxiK0z6SjIj6NcW0Kzrks0veMA3V5mX14jizYbX+Cp+SYZq6HnbMICKLD9Fk4Urk8TF/MQetolwaF2EMpPe9pDl76lp0Miof56zSunlimbwWb6j2JD0mP/yeEuivw57yfzKcTAXrv7ZhHWYpfVTgQCtr1HMy1gT8BWqUjqKMYyhz5BfR17Rg2KTKmhizvXewz+m1rsmvQG3+OcFiaIIFzuiJfybNdcCyz0x7Jw+a8VJbeEFFXSLD66IDo1OBnY0
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 09:53:50.1052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a1161e-06ec-4fad-bfe2-08de6ed39e0c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4374
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8949-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim,ti.com:email];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5A55F154F8C
X-Rspamd-Action: no action

Handle absence of tisci with direct register writes. This will support
platforms that do not have tisci firmware like AM62L.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/soc/ti/k3-ringacc.c       | 188 ++++++++++++++++++++++++++----
 include/linux/soc/ti/k3-ringacc.h |  17 +++
 2 files changed, 181 insertions(+), 24 deletions(-)

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


