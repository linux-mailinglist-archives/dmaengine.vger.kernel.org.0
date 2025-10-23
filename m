Return-Path: <dmaengine+bounces-6955-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FE0BFF8AF
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31FF31A031A8
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7632FE062;
	Thu, 23 Oct 2025 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="gZrzxZEm"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010001.outbound.protection.outlook.com [52.101.229.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E732FBE0B;
	Thu, 23 Oct 2025 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203994; cv=fail; b=F6HTGE/n9hSflHLVeZCOxSVaQRaKlHC4ebb7ErW8IUW1jzpCwIpmiUT4au5C4VMyblDm429L7YkV2z+W4x4kmEwmABIDa+k25L1z1HW2MDFSy5/hU9RHNpZvZJfNszmj6yZpnI3TfTXxmUfzZxyRl4U7rcXKdglnhDiVgwbax3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203994; c=relaxed/simple;
	bh=HHvePQhsOn5udlhhyl2q+oij4aEmiImdxFZVeO/iDW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gbYwU2a6IWfC4VLjR0sYwgHHoZ7SAZa76LC+q2HSTTZuA8pTj1pIXwiuCC+1klSw7Kof3e4GiiJexNJYwAprikIbIydzmk4u5KhVyd6UII0RTZeuXDEPEqYfEQVx5NFJM64DPrb44eYIF45YdzMJjYrMlCBR0SDYoiS35JqEb50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=gZrzxZEm; arc=fail smtp.client-ip=52.101.229.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XALltJF7+y9hErCDFy81k5m1Y7cn87tdjHzFVaujLF++FqrjcEIj64Eu0/5k6Za4F7OFdjDGMJxN6RDb19RZF8mdZuMn/to5TpYVRwHWvxUQQ0qglexV0YsDfoCatmS2F1nBjvzDsYLhRr1D7tWCQyhOKUYNb9KF4kKfjuHXyyL/zozrxENbyiQXzBl4Si/+rJdrpbINgOtDMSG+ZLBr9MqWklrEp43uWypZxbFbkDhFLGfk/gSzvCjdPgugO0tQOVM0rJccimM6Wr6J4gk2ffXVc3CioHZtUnRjZu7EYGM1yeVnHfm4SNPcfSslAdLh5tqrHFyfDVKS/z9iA/Htxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBVqk1iaKbdExkShWLIRzkuPCWnELf8T/NIc9UtZNZ0=;
 b=zCDp8t4nbrvpYd8/WCrdf3ZAA88n10y5l7N33BAL5Kmz4VZT5UBNveRDF+9p4TFxMqmBEclnlDkBj3rfmApxEpZkdXfx/wM8F0twXKbLvDCimeVjioJ+uVuiPoCxhPJG80Ed4Ll2OAy9JFdyrXYPY6qJFWIHOTassGrIons/Zm1iNVZUJ6aY9e9etNMBek+LhyQns084u/OIqo9fu4FYhO5O5WpK/KtT3CsW6AsS1HuloAnGeEp7JRfClW3LaKXSjdpoYWQBIXxS47QCXmLWETJ3ze1r1gQf+ebTzfvom1rnvscCL90s5nLF51m4R0SB3AOpb8HIF56XNCRfhysEaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBVqk1iaKbdExkShWLIRzkuPCWnELf8T/NIc9UtZNZ0=;
 b=gZrzxZEmLWwIumha7XMCl1W4xsChSLLD81ivAzPr9mSK9FT5Qszfnyf5Z7YCXfZehtFgDQN5+4d0YisfbwwbKHWaHGcvf3TcrqgzzqDAHvFVCevfOx7ov8nSiI1PhsWVhHxhuDAF7lpsi7ECdeJN0zVUirt25Zy/jIhQvfXLsYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYRP286MB4555.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:47 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:47 +0000
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
Subject: [RFC PATCH 20/25] NTB: ntb_transport: Rename use_msi to use_intr (keep alias)
Date: Thu, 23 Oct 2025 16:19:11 +0900
Message-ID: <20251023071916.901355-21-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0285.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::20) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYRP286MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a63b43-7c1f-4d8a-ec2a-08de12048c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K1KRXXEIvB6sxrmcjpWQ8UAHJ+xGzS7pBgXD/OUv9q3EkbAssL+VkQtWtSBJ?=
 =?us-ascii?Q?b3bLaisCTbPOb9o1wa3I0ghP372ExE0Pzmu45PBQ1LGVOkj++dM6Ii+SVy1Z?=
 =?us-ascii?Q?Z99v95q4oBQZG0XYsFyLau23xczidFjOraWenKn4MnxQZPy85nv/yRwKJTSn?=
 =?us-ascii?Q?Kpsyl9cbr12yRJrn8sr5bTIwZE1KnvxCSJg/X2VnQknU1nAFuDABhfd7hm9V?=
 =?us-ascii?Q?YtVKmTvK8luOd52rIbfqQ7tpXIezDIcHbWZefofroFNpiVgtsQw2ShwV2O2v?=
 =?us-ascii?Q?GmeHprAOpBng+f4enFVmviuMSprPY32xMOtofHu/S2icL+R+hBaVXPkyvYjQ?=
 =?us-ascii?Q?/gpVQXwqAnkDfgwwoXz6EABtrOLkVcboPkC5jjbaiOQxs9PO19snJkA2aT/U?=
 =?us-ascii?Q?CEiDL5OSmvd8lt/F6UWY3ht41YYJjqR8dFa7YSvlLRwkJwTXquYX+nw7F8Hw?=
 =?us-ascii?Q?uUxzX/tNO62GHugQSvb9IgI7ZyOLuXiDSfedmog4OIIfBkNjeinMv6OEeQsR?=
 =?us-ascii?Q?SomDh9Boh41zEZHe7x4l0daxSWNY5zO6ozvlgZoESg94SCyopUc+UxIiCX+9?=
 =?us-ascii?Q?M1Fr5tjDxSCKe0p/f34IRH+wp+zaCLCWZ77gPWj5IJLx0W06j7gNjOxplbch?=
 =?us-ascii?Q?AjDixS+mqFvxKLVJoaBlpOIwye4Qb+GoadtVrmIDISQNADYKaDaOldUYaioW?=
 =?us-ascii?Q?2hTz3j4eS/7SBFQerfMh4OPMM8wTdCsfO9bxk6eG1+FdnnvxJ4Plff6ggzvj?=
 =?us-ascii?Q?RVnYBjztGYIK2XG2ZGpp58ZawWk/SJVlbJKJmAmMSctd21Gq5g17g891dIJu?=
 =?us-ascii?Q?yBoUmXM6z63at9M6ibpT0PtWLq8U7l8qX/GcRZLK/OKegCbTilC5HrmOZt5N?=
 =?us-ascii?Q?R3C2TyPc4SLvc4WNUgeQTOGnbRusCATybLEOM87MDsTsNv/dXjdAXSvZT0An?=
 =?us-ascii?Q?O7rU5PzPDhHQ6Q2XkYUfV2IG+/W4/SqjexXcOZzcJ1N66qSaC869ZG7vOavF?=
 =?us-ascii?Q?EvrjHd++hf/d5/SmbS3XoOMMnO1W+fgbg0h3+zgs6n8U6dOo5tjbZwOcpSY9?=
 =?us-ascii?Q?0ZlWPR9Q40VcsUAuLkwfobayxcp7mT3rENzkCUsKppLCZMyD6LTZAb6WS2AA?=
 =?us-ascii?Q?pqDRIu6w+c0DCVkeWpKU71CNpIAIkY0y9odbokePkP63JbCHIFLl9a0lSsba?=
 =?us-ascii?Q?mG4B4aEn47nhabZ51/Idqqd2NNZlN1rzu5i6LUTVXPsbH/l638bf0Lp0dCmx?=
 =?us-ascii?Q?4t1t5XLp+Gpu3et1GAgvqXA/OzW/LOdgxt/CgGanYN+Ri1q0XCOwHTmru6lu?=
 =?us-ascii?Q?fBy4lobTSe3LkkE0R+1YzZP91uXkL5S0SNrEHSzGkgMkXch9YY0wTLKckS5C?=
 =?us-ascii?Q?lOr8wazVdy0Wwlt5BMna4RE6bhQNmd+Lo3Qvxkt54GmF+USaVdscFqv1VSf0?=
 =?us-ascii?Q?DHjL+sywlsHpfnmEHd6q0r9eG+kWH1HT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p1VkAHDe4JFuE9px7u9xzu2QZ6MLmM0LVWNlRpmzVi6mdSFnmtxHKLWwlAag?=
 =?us-ascii?Q?4xdKX0A9saMd5SAOQxI9uF7grxWk3pt2rjN07TGwktE0BC9I8uxDD8yFO7EM?=
 =?us-ascii?Q?tCUbe9tyaUUW6RYPBaO2fECqEdPqIvwzZNX5FzquNJB0JVaF/gauflzNn0oU?=
 =?us-ascii?Q?oedSr6GCz5W+sM5M/KEod99Gp6BjHvYMt1sDVSkip2T9hMKt5GmSSJN+hG9x?=
 =?us-ascii?Q?zSP3Yy1KFnWvGShWCdTDzFu4ihCVfjADN0FpAx2837kJKRTjzgvbrMTp5A+i?=
 =?us-ascii?Q?Ia3KQIaT/vuh2d5Wi/Sp8jRvlbkLaUjNZeKQxrECrRjgYdV29y3StA+RnOVD?=
 =?us-ascii?Q?0VU3CRm52lkE+/Alu3kfYRdljKjks1fpQOOovccSB69gitZ7a4tNL3t1FOHO?=
 =?us-ascii?Q?6Gyw9168kSFQ/oSpiQN/AISvB6SosGHcsS50fysGARuPXigEOhY0YIF1JH4W?=
 =?us-ascii?Q?YTTI/QCWMkBTyUXKxscpb7XiWdcf1PH8xWeF7wCYC6RNv8oFZIwWPQWHhsTm?=
 =?us-ascii?Q?7IvAzfSCKfO26mLb2KsX/ESAl/qiQJYWugNic6hpaaAa6VRnymTxtsrV4/u3?=
 =?us-ascii?Q?522ucMmCUBXJaBKbI/XPosD2xTP3B3qtkHiNvzfQF5JtPU8s89UjUtKeLWIf?=
 =?us-ascii?Q?0cozZFkb1lVXGG0z8Qs9vJP6Gmp6GnAllDoMZ7KEC65qT5FV93rxP4c/4vGk?=
 =?us-ascii?Q?ch26xxeKoy341XES3JSbCJCKNYRe4q8CoRh3MpTDX7dauCOV8grZdDqe60Rw?=
 =?us-ascii?Q?SsYL0O/3DLD/mWJXzJV/8l98P/a7o9VV5WDmx4uYOcIKmeb2uyuLtGCfN7y5?=
 =?us-ascii?Q?c7uuVNp8lbxuPj9b6U7hFdPFiEP9ipFl99YiD0x6fw1yEsJdYyQthn70oGsi?=
 =?us-ascii?Q?sSyiO9jeycux+NbA9+SkQX9j8xBHFCiH5dxHeaZceTUnsBdaqVyRsaTCZm0Q?=
 =?us-ascii?Q?JYDcnL5y7hr2ZKSk/H9p7Z5cfKmz37ScySWlxFPDVeOuZArD9Jpq5t/kX1wU?=
 =?us-ascii?Q?m44cNuQQQrdPRFAkdyVmvMQrzULC2KygjOefjScDJ5M2UtNoW06yqxbV34oE?=
 =?us-ascii?Q?wO7D7f0xPw7JztV0XFvYtrCyaFIe/AY0uo4v7hhOPSYlB5Vu8ROZKwd8Zb6Z?=
 =?us-ascii?Q?coWnnZoUrJuS+KuDQ6jUvsSoTd+iQArZWcd4kKTYG31p3R60dM0etws3Y8+D?=
 =?us-ascii?Q?HOeYNkle/mcHM+7yJWc+uxAlv23Jr82xYJg8Uih1U5VQY6xPq3FRhZmi2xu4?=
 =?us-ascii?Q?KyR1gak9bieENJDhb5EF5BLeL4S0U651yK3vGNs0wn1PWUhGfBwFnXSwkdEb?=
 =?us-ascii?Q?uGVM3AIke+RAbcRlCMqvD44QiWWKM3MmEKCv78tWG4S1VOK6+wbwlUbwJseo?=
 =?us-ascii?Q?ZHFHko9MTV1WAMKV6pL71sNpz8q1+NuYzMkEDRZVh5PXS8JshOgN9N9uelCo?=
 =?us-ascii?Q?KCjbPqOScn0JYXc+uNjOXBZgKcYiChCVUgujRkHkPg7CAIozJNo7taz7kZsG?=
 =?us-ascii?Q?wQ5RvikFVPMoXre/Qcvl07YVTZy/U68t6R1C/fwbDypRnCxc+8yaoDagGW6t?=
 =?us-ascii?Q?HMPNlxv+U1rbraGxRjx84wQh89RGhyFDesRv6A7pSyYCxTyUKAaE51dNYvy+?=
 =?us-ascii?Q?pliSH656XYq6JvOVOqglGHU=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a63b43-7c1f-4d8a-ec2a-08de12048c3e
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:47.6324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sMA3kq5xWMvEgpQVImzlkzp+IPEfjBCSnJGSiJJuuDf0KyrFm9LYEefE48IBQ2MG0MjV69eFoCiEN7j28ecdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4555

Replace the module parameter use_msi with use_intr as a more generic
interrupt selector, while keeping use_msi as a deprecated alias for
compatibility.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index d9fc450ef497..4695eb5e6831 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -97,10 +97,14 @@ static bool use_dma;
 module_param(use_dma, bool, 0644);
 MODULE_PARM_DESC(use_dma, "Use DMA engine to perform large data copy");
 
-static bool use_msi;
+static bool use_intr;
+module_param(use_intr, bool, 0644);
+MODULE_PARM_DESC(use_intr, "Use peer-triggerable interrupts (MSI if available, otherwise provider fallback)");
+
+/* Backward-compat: keep 'use_msi' as an alias to 'use_intr'. Marked deprecated */
 #ifdef CONFIG_NTB_MSI
-module_param(use_msi, bool, 0644);
-MODULE_PARM_DESC(use_msi, "Use MSI interrupts instead of doorbells");
+module_param_named(use_msi, use_intr, bool, 0644);
+MODULE_PARM_DESC(use_msi, "DEPRECATED: same as use_intr (will be removed after grace period)");
 #endif
 
 static struct dentry *nt_debugfs_dir;
@@ -236,7 +240,7 @@ struct ntb_transport_ctx {
 	u64 qp_bitmap;
 	u64 qp_bitmap_free;
 
-	bool use_msi;
+	bool use_intr;
 	unsigned int msi_spad_offset;
 	u64 msi_db_mask;
 
@@ -704,7 +708,7 @@ static void ntb_transport_setup_qp_peer_msi(struct ntb_transport_ctx *nt,
 	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
 	int spad = qp_num * 2 + nt->msi_spad_offset;
 
-	if (!nt->use_msi)
+	if (!nt->use_intr)
 		return;
 
 	if (spad >= ntb_spad_count(nt->ndev))
@@ -742,7 +746,7 @@ static void ntb_transport_setup_qp_msi(struct ntb_transport_ctx *nt,
 	ntb_spad_write(qp->ndev, spad, INTR_INVALID_ADDR_OFFSET);
 	ntb_spad_write(qp->ndev, spad + 1, INTR_INVALID_DATA);
 
-	if (!nt->use_msi)
+	if (!nt->use_intr)
 		return;
 
 	if (spad >= ntb_spad_count(nt->ndev)) {
@@ -1067,13 +1071,13 @@ static void ntb_transport_link_work(struct work_struct *work)
 
 	/* send the local info, in the opposite order of the way we read it */
 
-	if (nt->use_msi) {
+	if (nt->use_intr) {
 		rc = ntb_msi_setup_mws(ndev);
 		if (rc) {
 			dev_warn(&pdev->dev,
 				 "Failed to register MSI memory window: %d\n",
 				 rc);
-			nt->use_msi = false;
+			nt->use_intr = false;
 		}
 	}
 
@@ -1316,11 +1320,11 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	 * If we are using MSI, and have at least one extra memory window,
 	 * we will reserve the last MW for the MSI window.
 	 */
-	if (use_msi && mw_count > 1) {
+	if (use_intr && mw_count > 1) {
 		rc = ntb_msi_init(ndev, ntb_transport_msi_desc_changed);
 		if (!rc) {
 			mw_count -= 1;
-			nt->use_msi = true;
+			nt->use_intr = true;
 		}
 	}
 
@@ -1369,7 +1373,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	qp_bitmap = ntb_db_valid_mask(ndev);
 
 	qp_count = ilog2(qp_bitmap);
-	if (nt->use_msi) {
+	if (nt->use_intr) {
 		qp_count -= 1;
 		nt->msi_db_mask = BIT_ULL(qp_count);
 		ntb_db_clear_mask(ndev, nt->msi_db_mask);
-- 
2.48.1


