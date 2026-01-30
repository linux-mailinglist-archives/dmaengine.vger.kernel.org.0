Return-Path: <dmaengine+bounces-8607-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIY2GhOQfGkQNwIAu9opvQ
	(envelope-from <dmaengine+bounces-8607-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:03:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DD2B9BAD
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69D2D300789A
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 11:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D70379989;
	Fri, 30 Jan 2026 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cqUr+XuE"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896D37B40B;
	Fri, 30 Jan 2026 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771007; cv=fail; b=IGFV0bX/GpNobIcMPrSqMRXkr7N0PhtOtpbqsIJgPx3WXY1YMkpFP8bruqhUofLeVLtCXPM1oa43ZXjdvjjTophrt/bLyPgQmt7qfPx3hVPA/s++Pa7D5+9Sr9eFhuiil6cMIdpJ2Prn0uprkqnBAWHdeTiMeF6MbE46bWRXGNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771007; c=relaxed/simple;
	bh=rmLaMOQgrBuoGCure95Sx4FQnosYhF4wpfH+AtB4/q0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rm7L1WxQ+1MD8AGZ0vhv0A1NOpQf3dJ7z/2VPqyscWA6B2TCy1HN0RsN7IYMV4vkMdop0p7YjiezsF0g+iLjs+RjTFihjvXS7gXwGBvXEHRRi2uhLo4hFCPjjV0WSwvw9Z8MbnC+C+W82zi4fiq9CN+A1BhOP8LpsHN9bKuzX0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cqUr+XuE; arc=fail smtp.client-ip=52.101.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blH3jCvyXpSH4H3wI7UAgS/BF9FRxzb7ec+vUp41loCtke3WTJaST6Yco+tp6Vj3vp/1C4vtR0fl7yX5i5YeI/ov4srUtN5I6fN2ePqpPkygqMTiep9bTLr/ddFSCPTmve9+dF0mzSJgJWLKy+ffGBmEo/PjqSvWtnFbzVDrywXk7eJxNDImqEcQVp+GSVq6M25/B4nXoqpkYLKHHSqrwrWt3YReGmWT0MnFrTJI6g/Ly/57z5TnVB5nXWrK0W+kwPwBQBEQpCKWknnET45kYUDULVSxbzglYaTsZx4XUct1t7RY0x1VDpkhbF2IzP/LuZohskS4iX27uawq2S2F6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJrAlx6lO+F7VT68NfA+jYVBa/9M218hBQEtuCnhwRs=;
 b=nFGkgAcwjokhpM0ONxyiFt7SI5mLUuZOfblkzjrt5A5MYIhB7FCo49i9jlh6PGIw6P9Wu5xVN4HO9qhrgVw07a9jXVjntpbr3k963uq9BvgVUG6ovmEy1P/zf1YPQTwQaK7rahgZerIzAO1OOFXnwi+QTsByyIzrbxBaK3CGglcWeK+wvSmiF+H9aB9FlX3ZOe/1mg1YNlJp+kH+58P4F8IbbYwh2ay874hP3qhTI3xQtfoTSiEaiwfXOaD2wuc0RHi4nkssl4ANk+2aAprYi//R3X3GZsm5Tfy/LsQps4UpJh9k1dLP8wKvPZurzAL1US+XpUVWDI7+grunst9w7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJrAlx6lO+F7VT68NfA+jYVBa/9M218hBQEtuCnhwRs=;
 b=cqUr+XuE4CfTz5K+00LAEADY0DIwKnfLSY2p19h4JpU6fApWW74tahJow2RNToAK4wDZHOexEeHCZ3HAyXthOOQXlJKLr7CShDtdvurOg4y+Wse0y69LI9Z3xThEqUpkPP/xJji48XpvIEuKCx3w4Aw2kPGGBYXsVg6iIh3fIjQ=
Received: from PH0P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::33)
 by CYXPR10MB7952.namprd10.prod.outlook.com (2603:10b6:930:d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Fri, 30 Jan
 2026 11:03:23 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::fe) by PH0P220CA0018.outlook.office365.com
 (2603:10b6:510:d3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 11:03:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 11:03:23 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:03:22 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:03:22 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 30 Jan 2026 05:03:22 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60UB2HBr1204392;
	Fri, 30 Jan 2026 05:03:18 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v4 14/19] dmaengine: ti: k3-psil-am62l: Add AM62Lx PSIL and PDMA data
Date: Fri, 30 Jan 2026 16:31:54 +0530
Message-ID: <20260130110159.359501-15-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|CYXPR10MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb278e3-e8a2-4563-ff3c-08de5fef2f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nr38oYvox/I8Akg9jyJa3QJn9k7vukLg30w1/dzeqCehNPqOFw5uPoBSaQJx?=
 =?us-ascii?Q?Z4msxJTVVz3SOfcXvEDGylThuP+7AjqUwEC+ZVLhx1BJ/UbdyO1v3VxL9+7s?=
 =?us-ascii?Q?vjjlyqmKryqZcttwlruOmLZt5fp0xn6uKsQFeIFpXXxbzrWdehWVKDSaHVIR?=
 =?us-ascii?Q?+4HDLRrouIweAPESCdCWiqnDFB8HsGZG8Wv/9qbUSqNuqaR16UlMb+fmgxjo?=
 =?us-ascii?Q?bXgixUt4QQ22le9q0cHEQZIurrhd0Kof7wpPMXXFV1S9b5qnEPZVYWnXL8It?=
 =?us-ascii?Q?LgfGMSXIueugK9IeXbXXU8cIzm0FAbec0iuuzk4xg3XCl+Cjh7LDqpAaQLMg?=
 =?us-ascii?Q?+8HfPTDE+sXm5kmIFR1fYhna32vvebKwrN65DZb/k+Z5nsiLS+B3CzIgxQrR?=
 =?us-ascii?Q?67sUSPgdLzhwtLbbANXq+qGM8V/HnyC7WFbDih4bBVBCHFFRqP/NlV2PME4z?=
 =?us-ascii?Q?J9lgG15vv7gJ+gaq0SNKckWuQRffzkw4RdPNVMErbWMwMazzPrCDLpzKBoE1?=
 =?us-ascii?Q?PHwGrFyKvTDl1CWxj6w6W7waDk5oHWQ98e1acVTf4nn3SJ+T4qzo5Qxm7i7l?=
 =?us-ascii?Q?7ZbeogJDZD8Gg5yZlmrtxkD/C5SMeIO4IFr5tX+CwGHVVYR1UwHuVq8O6USU?=
 =?us-ascii?Q?huECGoRaB1orhqCjjhpKslNp+y1jYpP6TayOcYNyeC32OBgnT7ayKgNMF3Rv?=
 =?us-ascii?Q?uQlKWYeo4h2dIyZgBHvGgTEkJeOhY9eXidWTt4i+KEwRHdxgZLBaPID6NMUk?=
 =?us-ascii?Q?tWKm9oq7i+gNClCOeUSt+AvX03t3FY5rIMHqZb2RAc2M4fO1BC2paKe6awYs?=
 =?us-ascii?Q?4PGDWJbx53g1Lq5oZSu7S4hJLMdNI3C/LKoNGuZD8p0Z44XQyA0TuQrU1CY0?=
 =?us-ascii?Q?jCoh3XFGrsNN4Ytdw12ajwFn9DE1JyZ6wyx7fx5/9e2NtoasI+uqz3+f7AEM?=
 =?us-ascii?Q?xrN4cFrSyHAInBlbTibbv+GbzFNOr/Q4cAkKi/s+AvHNwB9qOV8SBPGvvlMQ?=
 =?us-ascii?Q?3t3jGiCQA2FC6xVyY9tvakovQP/mrqVQLkcSrxrHlT8QAhGB0lWyYsaFDNyU?=
 =?us-ascii?Q?YDnJnwxpHrhip5uEUC742XPCdRInZyCsu+ZIXXTycfjj21yp27NSfrs2KVIf?=
 =?us-ascii?Q?djxzVPgB3rIVkPSvGfYTejhYdagfrlFNKnMo0AO2OzGiTVCzjNCz2jv26zfZ?=
 =?us-ascii?Q?dhIgT0cqGg+KrbNQ4kWAwU/JJp3avNciejt4+S6F/RYkEzd5CNRLnS0izgYu?=
 =?us-ascii?Q?fz6Qe+H2szoaAx99ApW9h/9Pal8GxH37chiF9/BuO2gmfbfc4+8YxhVMpD/r?=
 =?us-ascii?Q?1IesNFAIp9tdUsmyjCGOFUw7Yw/cJu9n4B3cuHD6m3HvkfonMtm7hrHJ6PIA?=
 =?us-ascii?Q?NVDlCcVxnqpxEDVsfL1jLsO/gjTPWP8s/juPMPwtwXOM1BWhqLgUynyFGWXV?=
 =?us-ascii?Q?cZSMwHJ645j4OtPX5whjfbd3TU2nKn0EJ+OYTkIPIgLbMa+bYTwVPBLgRF4R?=
 =?us-ascii?Q?TA6SvhUAk+modMxm2JN048Iq2A1261qb0/o4xw7GCphv+ofjvN/nuDH77xH2?=
 =?us-ascii?Q?9cc4P6tq7WQL05muJVCu84PRULihNr04Rhzx3LjMbEOaRHCKOzzWWbYeq4cU?=
 =?us-ascii?Q?wSpfgYag5iabSxocddZjGRg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mKDZ0K3PYftkt+SDiiIQM14O8Z4xQZBfdwQ5AWlIQEG9P1V71/4X312EFw2Q87z84RQS9M3X8tda5U38qbcqWJeI1jp6N5UBqz8Y6iqi9y/FRnyTeJL5rOA/0PhPadXMoAGBbyRY98ySOIyvnKa6mIEpdVtpAd9lmt15c+jmvd4eB75nneaqEb5gwWuYc5VwJOPchsscBNa6QbNVhrMiprGnAxPGzCXBAJ5+3yDBlvYqLcfibOB/t35zGDyza84ycvOvsytSFv9DjBzU6e59d0n3UJiocyI0Lrxx1hFWZwrYFjJhqtlQZWa40SKGoBvu3wLkt445xsWAxWiGcgZvYrtXF81g1sdUwT8PKJeFzyxnzAaJM3LpfS/ozLFC6bTf767OlDwsj249rk2zriYRZ13mtdNa8tyeiL0DmV/XpKtm33EZDZ44IMFsvzx8F0Ig
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 11:03:23.2458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb278e3-e8a2-4563-ff3c-08de5fef2f93
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7952
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8607-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:dkim,ti.com:email,ti.com:url,ti.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 06DD2B9BAD
X-Rspamd-Action: no action

Add PSIL and PDMA data for AM62Lx SoC.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/Makefile        |   3 +-
 drivers/dma/ti/k3-psil-am62l.c | 132 +++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h  |   1 +
 drivers/dma/ti/k3-psil.c       |   1 +
 4 files changed, 136 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ti/k3-psil-am62l.c

diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
index 3b91c02e55eaf..41bfba944dc6c 100644
--- a/drivers/dma/ti/Makefile
+++ b/drivers/dma/ti/Makefile
@@ -14,6 +14,7 @@ k3-psil-lib-objs := k3-psil.o \
 		    k3-psil-am62.o \
 		    k3-psil-am62a.o \
 		    k3-psil-j784s4.o \
-		    k3-psil-am62p.o
+		    k3-psil-am62p.o \
+		    k3-psil-am62l.o
 obj-$(CONFIG_TI_K3_PSIL) += k3-psil-lib.o
 obj-$(CONFIG_TI_DMA_CROSSBAR) += dma-crossbar.o
diff --git a/drivers/dma/ti/k3-psil-am62l.c b/drivers/dma/ti/k3-psil-am62l.c
new file mode 100644
index 0000000000000..45f5aac32f6a0
--- /dev/null
+++ b/drivers/dma/ti/k3-psil-am62l.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2024-2025 Texas Instruments Incorporated - https://www.ti.com
+ */
+
+#include <linux/kernel.h>
+
+#include "k3-psil-priv.h"
+
+#define PSIL_PDMA_XY_TR(x, ch)					\
+	{							\
+		.thread_id = x,					\
+		.ep_config = {					\
+			.ep_type = PSIL_EP_PDMA_XY,		\
+			.mapped_channel_id = ch,		\
+			.default_flow_id = -1,			\
+		},						\
+	}
+
+#define PSIL_PDMA_XY_PKT(x, ch)					\
+	{							\
+		.thread_id = x,					\
+		.ep_config = {					\
+			.ep_type = PSIL_EP_PDMA_XY,		\
+			.mapped_channel_id = ch,		\
+			.pkt_mode = 1,				\
+			.default_flow_id = -1			\
+		},						\
+	}
+
+#define PSIL_ETHERNET(x, ch, flow_base, flow_cnt)		\
+	{							\
+		.thread_id = x,					\
+		.ep_config = {					\
+			.ep_type = PSIL_EP_NATIVE,		\
+			.pkt_mode = 1,				\
+			.needs_epib = 1,			\
+			.psd_size = 16,				\
+			.mapped_channel_id = ch,		\
+			.flow_start = flow_base,		\
+			.flow_num = flow_cnt,			\
+			.default_flow_id = flow_base,		\
+		},						\
+	}
+
+#define PSIL_PDMA_MCASP(x, ch)				\
+	{						\
+		.thread_id = x,				\
+		.ep_config = {				\
+			.ep_type = PSIL_EP_PDMA_XY,	\
+			.pdma_acc32 = 1,		\
+			.pdma_burst = 1,		\
+			.mapped_channel_id = ch,	\
+		},					\
+	}
+
+/* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
+static struct psil_ep am62l_src_ep_map[] = {
+	/* PDMA_MAIN1 - UART0-6 */
+	PSIL_PDMA_XY_PKT(0x4400, 0),
+	PSIL_PDMA_XY_PKT(0x4401, 2),
+	PSIL_PDMA_XY_PKT(0x4402, 4),
+	PSIL_PDMA_XY_PKT(0x4403, 6),
+	PSIL_PDMA_XY_PKT(0x4404, 8),
+	PSIL_PDMA_XY_PKT(0x4405, 10),
+	PSIL_PDMA_XY_PKT(0x4406, 12),
+	/* PDMA_MAIN0 - SPI0 - CH0-3 */
+	PSIL_PDMA_XY_TR(0x4300, 16),
+	/* PDMA_MAIN0 - SPI1 - CH0-3 */
+	PSIL_PDMA_XY_TR(0x4301, 24),
+	/* PDMA_MAIN0 - SPI2 - CH0-3 */
+	PSIL_PDMA_XY_TR(0x4302, 32),
+	/* PDMA_MAIN0 - SPI3 - CH0-3 */
+	PSIL_PDMA_XY_TR(0x4303, 40),
+	/* PDMA_MAIN2 - MCASP0-2 */
+	PSIL_PDMA_MCASP(0x4500, 48),
+	PSIL_PDMA_MCASP(0x4501, 50),
+	PSIL_PDMA_MCASP(0x4502, 52),
+	/* PDMA_MAIN0 - AES */
+	PSIL_PDMA_XY_TR(0x4700, 65),
+	/* PDMA_MAIN0 - ADC */
+	PSIL_PDMA_XY_TR(0x4503, 80),
+	PSIL_PDMA_XY_TR(0x4504, 81),
+	PSIL_ETHERNET(0x4600, 96, 96, 16),
+};
+
+/* PSI-L destination thread IDs, used for TX (DMA_MEM_TO_DEV) */
+static struct psil_ep am62l_dst_ep_map[] = {
+	/* PDMA_MAIN1 - UART0-6 */
+	PSIL_PDMA_XY_PKT(0xC400, 1),
+	PSIL_PDMA_XY_PKT(0xC401, 3),
+	PSIL_PDMA_XY_PKT(0xC402, 5),
+	PSIL_PDMA_XY_PKT(0xC403, 7),
+	PSIL_PDMA_XY_PKT(0xC404, 9),
+	PSIL_PDMA_XY_PKT(0xC405, 11),
+	PSIL_PDMA_XY_PKT(0xC406, 13),
+	/* PDMA_MAIN0 - SPI0 - CH0-3 */
+	PSIL_PDMA_XY_TR(0xC300, 17),
+	/* PDMA_MAIN0 - SPI1 - CH0-3 */
+	PSIL_PDMA_XY_TR(0xC301, 25),
+	/* PDMA_MAIN0 - SPI2 - CH0-3 */
+	PSIL_PDMA_XY_TR(0xC302, 33),
+	/* PDMA_MAIN0 - SPI3 - CH0-3 */
+	PSIL_PDMA_XY_TR(0xC303, 41),
+	/* PDMA_MAIN2 - MCASP0-2 */
+	PSIL_PDMA_MCASP(0xC500, 49),
+	PSIL_PDMA_MCASP(0xC501, 51),
+	PSIL_PDMA_MCASP(0xC502, 53),
+	/* PDMA_MAIN0 - SHA */
+	PSIL_PDMA_XY_TR(0xC700, 64),
+	/* PDMA_MAIN0 - AES */
+	PSIL_PDMA_XY_TR(0xC701, 66),
+	/* PDMA_MAIN0 - CRC32 - CH0-1 */
+	PSIL_PDMA_XY_TR(0xC702, 67),
+	/* CPSW3G */
+	PSIL_ETHERNET(0xc600, 64, 64, 2),
+	PSIL_ETHERNET(0xc601, 66, 66, 2),
+	PSIL_ETHERNET(0xc602, 68, 68, 2),
+	PSIL_ETHERNET(0xc603, 70, 70, 2),
+	PSIL_ETHERNET(0xc604, 72, 72, 2),
+	PSIL_ETHERNET(0xc605, 74, 74, 2),
+	PSIL_ETHERNET(0xc606, 76, 76, 2),
+	PSIL_ETHERNET(0xc607, 78, 78, 2),
+};
+
+struct psil_ep_map am62l_ep_map = {
+	.name = "am62l",
+	.src = am62l_src_ep_map,
+	.src_count = ARRAY_SIZE(am62l_src_ep_map),
+	.dst = am62l_dst_ep_map,
+	.dst_count = ARRAY_SIZE(am62l_dst_ep_map),
+};
diff --git a/drivers/dma/ti/k3-psil-priv.h b/drivers/dma/ti/k3-psil-priv.h
index a577be97e3447..961b73df7a6bb 100644
--- a/drivers/dma/ti/k3-psil-priv.h
+++ b/drivers/dma/ti/k3-psil-priv.h
@@ -46,5 +46,6 @@ extern struct psil_ep_map am62_ep_map;
 extern struct psil_ep_map am62a_ep_map;
 extern struct psil_ep_map j784s4_ep_map;
 extern struct psil_ep_map am62p_ep_map;
+extern struct psil_ep_map am62l_ep_map;
 
 #endif /* K3_PSIL_PRIV_H_ */
diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index c4b6f0df46861..2a843f36261bc 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -28,6 +28,7 @@ static const struct soc_device_attribute k3_soc_devices[] = {
 	{ .family = "J784S4", .data = &j784s4_ep_map },
 	{ .family = "AM62PX", .data = &am62p_ep_map },
 	{ .family = "J722S", .data = &am62p_ep_map },
+	{ .family = "AM62LX", .data = &am62l_ep_map },
 	{ /* sentinel */ }
 };
 
-- 
2.34.1


