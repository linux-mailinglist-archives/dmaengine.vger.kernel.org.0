Return-Path: <dmaengine+bounces-6958-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC37BFF9BA
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A2F3B1740
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927C33002BD;
	Thu, 23 Oct 2025 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="C49l1S/T"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010001.outbound.protection.outlook.com [52.101.229.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD8E3002A7;
	Thu, 23 Oct 2025 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204002; cv=fail; b=DXy3PoWV3dbmSxKr1WjiDQ8iSA70Ar9ZS0WWajQoZXRKwFZQiwYTkybYXKTE6bNEUF7eVSvJ9iISbirM81YZwedNfVsxBPwIyTDXSCFcD8Z7lnL50htnKs1sxDZdRaFIt9IX0npaQ2JNbdreG8TKUXCkU31poIRJv3vY71iMFZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204002; c=relaxed/simple;
	bh=uu6N67nDcBwKqODIPajhCIkafRwQ/69ej7P8bI7JNnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jslkD0Ny3SElBfEsATeKuBwWQkWVxMDfHCMnzw5ZiT+RmMd6DIqeCCqQL303e26xOltIz/KQ9Wo+FBIep+YGwSZCRKDtWlXviT6eJfDyXoXfrnadfDg/ymbjcmh40xeDm4U6pCXTHTg29Ogs7j0vVEDrNkpaXZRIAms0BYk1ToE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=C49l1S/T; arc=fail smtp.client-ip=52.101.229.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGE3fwu3LJMKFZbaA64Vg742GckmuUBd4K5UhWFWnRflnGQuBohY3lkkk2ZdA+L7Fm3BbJXs3UzsXU9xURnhc4oVhpkOwNzNGD0Va4w6CC49Go0z8czXDCw7WbQfeOAvNDodoVULfkjRsSUy46QXm5OvLFljkMoCxkm2InP0UO0AdGAvKwvp2HB7ICC9wsgUu2mrP7tl4TCkwEjz6JDfXemu5KgBoqV6FgPTu3Y/B0llY3kCF/dF8o2Y7QBguT/pFJojAx7FppTMwTb1yECaZSRZE8Q1TIM2QfT/mw9NnMHndFTrglrMcMsrFvoeiIbe5qDcdw9AADKpyNXTETuZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+qQK1lbIBDEO+Ac9RCJO+5eASwT3EpZ4LQu5FT/aao=;
 b=uyJwrGznWG8o18ZyTAigeNRhiyZqzKq0J3iJMjWOwDEdzA0B9hRA7CcUGpRbC4WcW/zJK08HcmwmR2JlPlVCDMwAdNRN9rtVKf4STSwxEt7vfvCKS1IRbuGI80Jn1WY5PPEHfoonTh0BlFvmzvZWjjrSxyoYI2Vt2r8nJE0AM+ypOY7aYlczn95+jTcDHpdjKd1P6y1TH5V67RBnAx+ld/xVtQiv+hxaJgPzaBcaZ2D98zOf8utLDVC+Szd9vBY4coQad5DVU1v6F8FX15KPSvm1AKIrkBlcEcT0zbioo+N5H4bAeFp6Uw5pnldQ0W8d9xQu00XuNipKFdlI6Q0kgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+qQK1lbIBDEO+Ac9RCJO+5eASwT3EpZ4LQu5FT/aao=;
 b=C49l1S/T3XEiybxuHWEx6PEPkhlZUTclT2OTxXFYXEJoxl3L+Xjq9D48u/gmd7ViBhyaJrezcvsdcQ5OKxgHtbdFUQV0Hjvtt8wvcXon1YQiV9ioGr+wTVRMBqG2joLkic+5C0Rk5dy46k5HiQMNYERKav6PkwkraChhXtGVZZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYRP286MB4555.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:51 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:51 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	jbrunet@baylibre.com,
	Frank.Li@nxp.com,
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH 23/25] NTB: intr_dw_edma: Add DW eDMA emulated interrupt backend
Date: Thu, 23 Oct 2025 16:19:14 +0900
Message-ID: <20251023071916.901355-24-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0274.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::10) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYRP286MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c7e3f3-31fc-40ae-4c02-08de12048e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ah2WM0LFx3lysjkR14ld+Q7jLIq/rNn03s6rm5JU/sxpTIjnrOqeXSSxJCuv?=
 =?us-ascii?Q?tRCTpYAdo+hOoSUVCtx1Kj1BcVeeYPeS4YJ40aKPz+LrBJQVL7778qa1xtlB?=
 =?us-ascii?Q?LgA6TAvo2KjiS+L/9xsEsizwM8nknHX2HhNyfyC3M2kXVyaIboEF9EeYyuw7?=
 =?us-ascii?Q?B6ic4BvVOYROZZ8u0zT/k68As/rQK09Js7w17GfzU4gzaUvjg8zmXO9riHA8?=
 =?us-ascii?Q?SNzDsu9QbZm3o0ABDwub6VegsyBEMwrKeiMFwdtQ67X30wQuUi3EF8V5eQmS?=
 =?us-ascii?Q?QjpADzQUVPJWchU1/D2x6/QxiesXxfVdSKu+LBLFm3X4CFhL9kJuPYHhDtMX?=
 =?us-ascii?Q?z0n8K6s0MzNPe6MBs5CJ9lYlUqTyCsUK8PIuQjtFGglh6qPMWT3oQCzVLZkC?=
 =?us-ascii?Q?zgelznhXjuzplrqHZISiuWCpnNttIQrEjLa51Cc95ja5EEwxY1ABidIcWoJY?=
 =?us-ascii?Q?BzY7rrurl6lrDAEmouNdHzCenIk6a/6bxE1/VpbZ1qyrsIn0uFf93z7ehXIa?=
 =?us-ascii?Q?KxgFUWM+NeABQpsHVd2Rhg+2b9XCmJH7Hvu0C6tzbpQpUp8h74V2v3ICpejg?=
 =?us-ascii?Q?NbLPDySd09UFmPhClZzFBEzW8XV7s5OhonsXkIV4QxWkZQDsTeCp570X65my?=
 =?us-ascii?Q?0SRAj38oLPB3+xn7plhO9k0a7THi3jZgxifym0GXztHF5F6lCyzrvDEdN8ro?=
 =?us-ascii?Q?s+S0EzKfXRiZC6fDA+pqWnV+xl7oJ6liJwdxMDAj1BqyBbfsfEalw0b2u+P0?=
 =?us-ascii?Q?WyAj/xJee9RdXhh8nYi8pUBKdw/IcUtmZdafjuhc5jacE/HG20rp6MTdfJcA?=
 =?us-ascii?Q?ESf+C8KsozghgPAO5Y+hZ4B7Vps2BNY2jq3FIErTXZLUwW34V+YleoBfI1ml?=
 =?us-ascii?Q?jQYw241e1Fbas+tI6jkaks/3RG1Fh0Z4E9GECxUHT0moYdROOyjX+JETT7Y5?=
 =?us-ascii?Q?PtUUkixyPLdbzGH17dSlMKjxRYIl1QyTmLeV7TQmqd1X5ZtgrqtgNzQ2K6CG?=
 =?us-ascii?Q?dJhufooQx4q243oDiIGDFNZZ/RLBl9IXbzism23IENNCDwxpYwg15mfP7xsF?=
 =?us-ascii?Q?/WG7z7TlF/JpuzXRJvaQMZ3tRZRVEWe6faBqEqGsduMWet/s/1bmRkflqucY?=
 =?us-ascii?Q?ZwxkQzR9SG89nU2352aPGw+IoL4CdzdKmgBU43kLZXIyA1s1uRj1ps70W/wp?=
 =?us-ascii?Q?inxw+JnxwbPH45qsFB/JfLAzUi4E7BYH9RFT9VkPIBBmsZ7I/LyiDTK3HmVV?=
 =?us-ascii?Q?eN6cXp0hCar70ssYosaB2891aYb81ECrbR4FwcxEXMy6ptGfcZp8tzf2+/HQ?=
 =?us-ascii?Q?aNENxbdCRYAHX6vxkI2eVtmPUa82G0PnY4u7H6cYxc/PXPakaQxoVvaOEEDi?=
 =?us-ascii?Q?VzHMAPNiG5zq0SuPUt5lZnf9plIoAAWZwLKDdDhFozJTSpxRZGdFkj/dd9iJ?=
 =?us-ascii?Q?yE2yzaq+oNlkLCzs8al/nTyloC6piNi8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4x9h7BEzRU9Tt2vtw/agW7IHpUmjd9MOoQNAxqwvwKPUnMiB51Xv1HVukoR+?=
 =?us-ascii?Q?jMQMLd3YvxJhmfcA4dkL2Cr8U7VJy6HLNP+vbB19fXvWp23onPYVlwo0rYdC?=
 =?us-ascii?Q?xj2/xx9ByxDU6KLefSh2vExqn75fmsrexDWQz8PtFcpIy7zzRnRH/SMXn+yv?=
 =?us-ascii?Q?LDj5s1SzU5HMlqcBPWi4bDs54RKgTPqiBCREo6BaV/c2sMkoD9o1NR1aTzcY?=
 =?us-ascii?Q?axhtKgwiQ0XWFjNkrhvZlFXGI3hOzxyB8iLPqzkHCAOtwY5i+IPsXF9FGQol?=
 =?us-ascii?Q?0jE4aASFkbk4+7XtZBuVXs/8XQxyb3njkob4ELBhgcNX6UW0IRnGkSJ5s2Au?=
 =?us-ascii?Q?DWN7KfpME735LZmlj6oUTx4XbQ57Dkt2CPeLGHFq+zKmIDv6HMO9thY5Dkzc?=
 =?us-ascii?Q?becM12lrZXtpGf+hbFAE38MuTAiE0kiPgyAK1QEMRf883PGSjKMSZYYydFIa?=
 =?us-ascii?Q?wFRhszbDWIHb2XWK4WPtp2Q+PNeeKtkmi+US8OvGPvSGhHF/2pFVr5ke7bOI?=
 =?us-ascii?Q?MIpOTlLRCtWTS3znMqKn05O0DJ441ajQw8q9TJGxv9juYCpU/oF2cexm5/Eu?=
 =?us-ascii?Q?d4iiaVFlfRb6TPMGoBU70ab8JKXcFyih1Ccqza5+6I2CtViTz+80rx6gg18r?=
 =?us-ascii?Q?kchT3zVcxX/FJbzJIRHOdJT2DNW9YLEdZb2vhEYZQeBHNeUQGCTTVuUcZRBg?=
 =?us-ascii?Q?FG8CqbpVlfuhJBHiqEZ/+FdRBpnvqnqnlnPQJJKPC3l8fE4unZL9wwNaivDs?=
 =?us-ascii?Q?dvaI0GjqwHYVTNfi7eCxAm4TJW+8tRSIe7+y8vUA/vaYwH/RV3oCN2aoKIrD?=
 =?us-ascii?Q?SdwaiBzbX8OyLemHe6ZqWsx/R7O+S1Kh5dVeVhCkzdi23SivNHuxiNA7rRXx?=
 =?us-ascii?Q?JMLsMVqT8McDzRcrOvDrpgQerVQ+UK8qzE7ZYf38kh2t1lgD1bsK1Mobt7yA?=
 =?us-ascii?Q?nWCkWWhUGntPBXH8u7UK+NKzYWzGuRboK0H/msfl17Q1clxAf9FQJk5WTu5w?=
 =?us-ascii?Q?H7DZrueWcU8/SQhkPoWQ7ODC8Lf12SqpkJWIh6CpMsWStXxqDoczNRuGB2Vf?=
 =?us-ascii?Q?YKElrXCSgFSeti9yxa/SQ6I7Lpw2EmZCqjEuBVhcRr3MkOPjs3JeyCtLhu4q?=
 =?us-ascii?Q?4mRfS+Q0NZAkbFqK+0UXldZE/zj1WQKTNLpA5cqzWt/j/ZkSw8vjID2X4x+U?=
 =?us-ascii?Q?6J5Cadbdk017cMUWTGW6FOZDTzMOu1agXWjwUB9u+zrKwb8XXaGVH1gAuN8s?=
 =?us-ascii?Q?3UGr1qBLvJn/8cfrFkGgzxF40KINr6d0+OgqVIK6/YNcFrJzWDkjOgRLpzAM?=
 =?us-ascii?Q?O05uYHV4wHPlwdkowftJFQ0JZK17BysZrCvPJKwoN8IcOc2fkOF3FA3c++/J?=
 =?us-ascii?Q?jucib4qZj1bUB627qgQ7ccBNFePfzo7YVJyV9EbcCSq2/5+yow6PAtXgwK+5?=
 =?us-ascii?Q?VBw6H3y51Ir57k4P+/R0eUj2agyN5srac1u7XKZTeHtwonadbmXLeRgJ9gZD?=
 =?us-ascii?Q?qYu+BTRSGiEAPjbTDONuwJEd1gBMMyyQf9faZb1TZmQDvdIdzWHdo9T7t0lR?=
 =?us-ascii?Q?JyFhyW3Jn1c2u3xqV1QTs9vANAfRs4IRwSWhNIBm3KIMfi0C0ypog3Y1zEgU?=
 =?us-ascii?Q?n/6Tp/hwhf4ENu34fG/ytiU=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c7e3f3-31fc-40ae-4c02-08de12048e60
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:51.2596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGFkPGEwkdYeZuQtoGxMLzSVYQ+r/HAXlBxeFjLkDsvPyPPQIiVKjDy+lD4NgkcRvZdcQzKNYrW9DBgex8huug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4555

Introduce a new NTB interrupt backend using DW eDMA's emulated interrupt
mechanism. Enables interrupt-based signaling from RC to EP where MSI is
impossible due to security restrictions on the platform.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/Kconfig        |  10 ++
 drivers/ntb/Makefile       |   1 +
 drivers/ntb/intr_common.c  |   8 +-
 drivers/ntb/intr_dw_edma.c | 253 +++++++++++++++++++++++++++++++++++++
 include/linux/ntb.h        |  10 ++
 5 files changed, 281 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ntb/intr_dw_edma.c

diff --git a/drivers/ntb/Kconfig b/drivers/ntb/Kconfig
index 2f22f44245b3..5b7e1563e639 100644
--- a/drivers/ntb/Kconfig
+++ b/drivers/ntb/Kconfig
@@ -29,6 +29,16 @@ config NTB_MSI
 
 	 If unsure, say N.
 
+config NTB_DW_EDMA
+	bool "DW eDMA test-interrupt backend"
+	depends on PCI_ENDPOINT && PCIE_DW_EP && DW_EDMA
+	select NTB_INTR_COMMON
+	help
+	 Use DW eDMA v0 test interrupt as a doorbell-like backend
+	 for NTB transports when MSI is not available on EPF side.
+
+	 If unsure, say N.
+
 source "drivers/ntb/hw/Kconfig"
 
 source "drivers/ntb/test/Kconfig"
diff --git a/drivers/ntb/Makefile b/drivers/ntb/Makefile
index feaa2a77cbf6..cae84d132b78 100644
--- a/drivers/ntb/Makefile
+++ b/drivers/ntb/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_NTB_TRANSPORT) += ntb_transport.o
 ntb-y				:= core.o
 ntb-$(CONFIG_NTB_INTR_COMMON)	+= intr_common.o
 ntb-$(CONFIG_NTB_MSI)		+= msi.o
+ntb-$(CONFIG_NTB_DW_EDMA)	+= intr_dw_edma.o
diff --git a/drivers/ntb/intr_common.c b/drivers/ntb/intr_common.c
index e0e296fd3e3c..41b2752c6d03 100644
--- a/drivers/ntb/intr_common.c
+++ b/drivers/ntb/intr_common.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 
-#include <linux/ntb.h>
 #include <linux/module.h>
+#include <linux/ntb.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 
@@ -13,6 +13,12 @@ int ntb_intr_init(struct ntb_dev *ntb,
 		ntb->intr_backend = ntb_intr_msi_backend();
 		dev_info(&ntb->dev, "NTB interrupt MSI backend selected.\n");
 	}
+#endif
+#ifdef CONFIG_NTB_DW_EDMA
+	if (!ntb->intr_backend) {
+		ntb->intr_backend = ntb_intr_dw_edma_backend();
+		dev_info(&ntb->dev, "NTB interrupt DW eDMA backend selected.\n");
+	}
 #endif
 	if (!ntb->intr_backend)
 		return -ENODEV;
diff --git a/drivers/ntb/intr_dw_edma.c b/drivers/ntb/intr_dw_edma.c
new file mode 100644
index 000000000000..0e408ecfaf61
--- /dev/null
+++ b/drivers/ntb/intr_dw_edma.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+
+#include <linux/dma/edma.h>
+#include <linux/ntb.h>
+#include <linux/pci-epc.h>
+
+struct ntb_intr_dw {
+	u64 base_addr;
+	u64 end_addr;
+
+	struct dw_edma *edma;
+	resource_size_t rd_status_off;
+	resource_size_t rd_clear_off;
+
+	u32 __iomem *peer_mws[];
+};
+
+struct ntb_intr_dw_ctx {
+	irq_handler_t handler;
+	void *dev;
+	struct dw_edma *edma;
+};
+
+static void dw_edma_selfirq_handler(struct dw_edma *dw, void *data)
+{
+	struct ntb_intr_dw_ctx *ctx = data;
+
+	ctx->handler(0, ctx->dev);
+}
+
+static int dw_edma_find_backend_for_ntb(struct ntb_dev *ntb, struct ntb_intr_dw *intr_dw)
+{
+	struct pci_epc *epc = NULL;
+
+	epc = ntb_get_pci_epc(ntb);
+	if (!epc)
+		return -ENODEV;
+	intr_dw->edma = dw_edma_find_by_child(&epc->dev);
+	if (!intr_dw->edma)
+		return -ENODEV;
+	dw_edma_selfirq_offsets(intr_dw->edma, &intr_dw->rd_status_off, &intr_dw->rd_clear_off);
+	return 0;
+}
+
+static int dw_intr_init(struct ntb_dev *ntb, void (*desc_changed)(void *ctx))
+{
+	struct ntb_intr_dw *intr_dw;
+	phys_addr_t mw_phys_addr;
+	resource_size_t mw_size;
+	int peer_widx;
+	int peers;
+	int ret;
+	int i;
+
+	peers = ntb_peer_port_count(ntb);
+	if (peers <= 0)
+		return -EINVAL;
+
+	intr_dw = devm_kzalloc(&ntb->dev, struct_size(intr_dw, peer_mws, peers),
+			       GFP_KERNEL);
+	if (!intr_dw)
+		return -ENOMEM;
+
+	ret = dw_edma_find_backend_for_ntb(ntb, intr_dw);
+	if (ret) {
+		devm_kfree(&ntb->dev, intr_dw);
+		return ret;
+	}
+
+	for (i = 0; i < peers; i++) {
+		peer_widx = ntb_peer_mw_count(ntb) - 1 - i;
+
+		ret = ntb_peer_mw_get_addr(ntb, peer_widx, &mw_phys_addr,
+					   &mw_size);
+		if (ret)
+			goto unroll;
+
+		intr_dw->peer_mws[i] = devm_ioremap(&ntb->dev, mw_phys_addr,
+						    mw_size);
+		if (!intr_dw->peer_mws[i]) {
+			ret = -EFAULT;
+			goto unroll;
+		}
+	}
+
+	ntb->intr_priv = intr_dw;
+
+	return 0;
+
+unroll:
+	for (i = 0; i < peers; i++)
+		if (intr_dw->peer_mws[i])
+			devm_iounmap(&ntb->dev, intr_dw->peer_mws[i]);
+
+	devm_kfree(&ntb->dev, intr_dw);
+	return ret;
+}
+
+static int dw_intr_setup_mws(struct ntb_dev *ntb)
+{
+	struct ntb_intr_dw *dwc = ntb->intr_priv;
+	resource_size_t addr_align, size_align, offset;
+	resource_size_t mw_size = SZ_32K;
+	resource_size_t mw_min_size = mw_size;
+	u64 addr = dwc->rd_status_off;
+	int peer, peer_widx, ret;
+	int i;
+
+	for (peer = 0; peer < ntb_peer_port_count(ntb); peer++) {
+		peer_widx = ntb_peer_highest_mw_idx(ntb, peer);
+		if (peer_widx < 0)
+			return peer_widx;
+
+		ret = ntb_mw_get_align(ntb, peer, peer_widx, &addr_align,
+				       NULL, NULL, NULL);
+		if (ret)
+			return ret;
+
+		addr &= ~(addr_align - 1);
+	}
+
+	for (peer = 0; peer < ntb_peer_port_count(ntb); peer++) {
+		peer_widx = ntb_peer_highest_mw_idx(ntb, peer);
+		if (peer_widx < 0) {
+			ret = peer_widx;
+			goto error_out;
+		}
+
+		ret = ntb_mw_get_align(ntb, peer, peer_widx, NULL,
+				       &size_align, NULL, &offset);
+		if (ret)
+			goto error_out;
+
+		mw_size = round_up(mw_size, size_align);
+		if (mw_size < mw_min_size)
+			mw_min_size = mw_size;
+
+		ret = ntb_mw_set_trans(ntb, peer, peer_widx,
+				       addr, mw_size, offset);
+		if (ret)
+			goto error_out;
+	}
+
+	dwc->base_addr = addr;
+	dwc->end_addr = addr + mw_min_size;
+
+	return 0;
+
+error_out:
+	for (i = 0; i < peer; i++) {
+		peer_widx = ntb_peer_highest_mw_idx(ntb, peer);
+		if (peer_widx < 0)
+			continue;
+
+		ntb_mw_clear_trans(ntb, i, peer_widx);
+	}
+
+	return ret;
+}
+
+static void dw_intr_clear_mws(struct ntb_dev *ntb)
+{
+	int peer, peer_widx;
+
+	for (peer = 0; peer < ntb_peer_port_count(ntb); peer++) {
+		peer_widx = ntb_peer_highest_mw_idx(ntb, peer);
+		if (peer_widx < 0)
+			continue;
+
+		ntb_mw_clear_trans(ntb, peer, peer_widx);
+	}
+}
+
+static void dw_intr_release_irq(void *data)
+{
+	struct ntb_intr_dw_ctx *ctx = data;
+
+	dw_edma_unregister_selfirq(ctx->edma, dw_edma_selfirq_handler, ctx);
+	kfree(ctx);
+}
+
+static int dw_intr_request_irq(struct ntb_dev *ntb, irq_handler_t h,
+			       const char *name, void *dev_id,
+			       struct ntb_intr_desc *intr_desc)
+{
+	struct ntb_intr_dw *dwc = ntb->intr_priv;
+	struct dw_edma *edma = dwc->edma;
+	int ret;
+
+	if (intr_desc->ctx)
+		return 1;
+
+	struct ntb_intr_dw_ctx *ctx __free(kfree) = kzalloc(
+						sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	ctx->handler = h;
+	ctx->dev = dev_id;
+	ctx->edma = edma;
+
+	ret = dw_edma_register_selfirq(edma, dw_edma_selfirq_handler, ctx);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&ntb->dev, dw_intr_release_irq, ctx);
+	if (ret)
+		return ret;
+
+	intr_desc->addr_offset = dwc->rd_status_off - dwc->base_addr;
+	intr_desc->data = 0x0;
+	intr_desc->ctx = no_free_ptr(ctx);
+	return 1;
+}
+
+static void dw_intr_free_irq(struct ntb_dev *ntb, int irq, void *dev_id,
+			     struct ntb_intr_desc *intr_desc)
+{
+	struct ntb_intr_dw *dwc = ntb->intr_priv;
+	struct dw_edma *edma = dwc->edma;
+	struct ntb_intr_dw_ctx *ctx;
+
+	ctx = intr_desc->ctx;
+	dw_edma_unregister_selfirq(edma, dw_edma_selfirq_handler, ctx);
+	devm_remove_action(&ntb->dev, dw_intr_release_irq, ctx);
+	kfree(ctx);
+}
+
+static int dw_intr_peer_trigger(struct ntb_dev *ntb, int peer, struct ntb_intr_desc *desc)
+{
+	struct ntb_intr_dw *intr_dw = ntb->intr_priv;
+	int idx;
+
+	idx = desc->addr_offset / sizeof(*intr_dw->peer_mws[peer]);
+
+	iowrite32(desc->data, &intr_dw->peer_mws[peer][idx]);
+
+	return 0;
+}
+
+static const struct ntb_intr_backend ntb_intr_backend_dw_edma = {
+	.name = "dw-edma-testirq",
+	.init = dw_intr_init,
+	.setup_mws = dw_intr_setup_mws,
+	.clear_mws = dw_intr_clear_mws,
+	.request_irq = dw_intr_request_irq,
+	.free_irq = dw_intr_free_irq,
+	.peer_trigger = dw_intr_peer_trigger,
+};
+
+const struct ntb_intr_backend *ntb_intr_dw_edma_backend(void)
+{
+	return &ntb_intr_backend_dw_edma;
+}
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 1a88fe45471e..7daba67928e9 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -1664,6 +1664,7 @@ struct ntb_intr_desc {
 	u32 addr_offset;
 	u32 data;
 	u16 vector_offset;
+	void *ctx;
 };
 
 struct ntb_intr_backend {
@@ -1734,4 +1735,13 @@ static inline const struct ntb_intr_backend *ntb_intr_msi_backend(void)
 }
 #endif /* CONFIG_NTB_MSI */
 
+#ifdef CONFIG_NTB_DW_EDMA
+extern const struct ntb_intr_backend *ntb_intr_dw_edma_backend(void);
+#else
+static inline const struct ntb_intr_backend *ntb_intr_dw_edma_backend(void)
+{
+	return NULL;
+}
+#endif /* CONFIG_NTB_DW_EDMA */
+
 #endif
-- 
2.48.1


