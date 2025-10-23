Return-Path: <dmaengine+bounces-6957-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD1EBFF8D3
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7887419C19B6
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8782E282C;
	Thu, 23 Oct 2025 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="S5YnTbtE"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010001.outbound.protection.outlook.com [52.101.229.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D732FFDFC;
	Thu, 23 Oct 2025 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204000; cv=fail; b=aUsL06967F+ht3zDWRFB4BitorJ06NRS3SROOMBTdhVWvnM9ufotQhfZghWALvYvAcHyVUOunwmnVldbOBHJ+dJTsNb5GIYJ8u/xKc5Qr16bGxNkaCRgOIABnFpWbfYUtgxDPneZXgbnVcwNBQfQ0YG1Bi4xk08JGbKsaxUXzEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204000; c=relaxed/simple;
	bh=fjJhqRCWj3fTwesjpdgQWW6pj9o8yCh1GVPgWhfQIfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hnRvkhvLjfSKHMaPfhxJXhBNxcel54316EtVSBTG2cDJpoL1oyGgNWRP6OzjLjavyEQb6mZO9KaODv3qdN+XJ6jJWKYXcEFyESECuc8NnpjQeptdQ7ARZ0z8cN8NIcmQ/YcqyNelxw8SObP2VUFJyt8DVSg7b/PTGVcjrlJ3YYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=S5YnTbtE; arc=fail smtp.client-ip=52.101.229.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDK1Bb3BRB7mc0FQPHp0A+cyuf4O6XlHG0FZ+IqZXCWTUD8KXYZ04rioRNQaH9/SBgOc5qkO/F2vmaI3Q+pGZurFe6WGESitzMnUEbkj4jMmiGoj7hiBq1dUQg4Z0MowipeVHWYssTjBdp9AEo7HNG/q6AnuzcnrOazbd6mqHsca4//Swu8Z28RGbQoAWj6wSA7WIhDRDRgyL3+D17DJDYACw54ISZayyBcJCfzbICFTqac3Rf5Dz3RZD5SiLQYsPwsbv4CIEL1QTvYS/BAXn5MlDG+GCK+EtXx+1m3THvSKcGLDr8Vew/oDRMgeArVbIEKkZtHCgdwVVAxocuEMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94Mtazti3JysasAtnCHIJES2qclBLehTS/GYXSjhAHU=;
 b=BbtUBKVRcmeI7C3VkDyDA5hVy+wsk8G0vsp20rQRQ0W8E83ZhDIgJyTew8Rt9xjyJdkAHyS6q8sxBIpcXGlOxG1JLx0SUxzvFZzvoIuOh3njObTC5c0LmtTl85wVFZuyRdYfrhQa0l04uCS9B76SkmzcIsOW1FxBk5YNyPkJnOKiXctiFQtgX8hX6jDRJ75ETLNpPkEMbYYlGoBCQhy5zk2l+e42zUUSLKVwUzod8xfU4O/GR/UbSvbLa9auER2ChojFeC2h1OCTwoLhPXSxrIlApOyIkKplgB0hMkfO1c+ry5qrdiFgNItITz3O2IXGIxLaNncotSxCxwoc+Cs7zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94Mtazti3JysasAtnCHIJES2qclBLehTS/GYXSjhAHU=;
 b=S5YnTbtEDhwx6OBgXMdFkX4kezJSWtM5eVOD3ejuFq6FIdR3j1Tx/x3TZteacw8YqGpBDZzggN8xzhYhpdrsY0qOWRdwj42vVoQk+pJRJUuQpFVihkVtrlKxy7XzSxjFfDdkhHOMVqLopPHv2mMno6lZtHbN607wO3D2Y8LSeL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYRP286MB4555.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:50 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:50 +0000
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
Subject: [RFC PATCH 22/25] NTB: ntb_transport: Rename MSI symbols to generic interrupt form
Date: Thu, 23 Oct 2025 16:19:13 +0900
Message-ID: <20251023071916.901355-23-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0042.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::18) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYRP286MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dad12b8-812c-4eb4-543f-08de12048da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Uhdpd/Aye1/OKpCKR6c54vk4PK1r1VxUCPtsEHmIhRurXiqsABOLMLR4Wd/?=
 =?us-ascii?Q?vOnPQtii6D/jcRV3jTJqU9hv5M4kia7DDOHeXfvZCvePzKxJwbnfcTk8DuOw?=
 =?us-ascii?Q?ccGFPhpEoIbiJqp0TzNrfFQ4oHQOUuw8JS4+zA+O8F9Qo4PBw6Fo0H7XJMkc?=
 =?us-ascii?Q?6BB1URspPeT3NYF7XHn5vFSMzFnIDz8ihErwXHRZvQZNcrAXMGjnq0HJ6Vnu?=
 =?us-ascii?Q?UB1NPSZAkSjmEv22PnmHfrQ9MBlrgfFFZ7WrXTW51IzuJ2I+kA7iNp2UMAbk?=
 =?us-ascii?Q?r1A+aUDMVd5dwWpDnGu9XshEFQ9edFZVbeqsXOJUV/QI8iMIULE2XoN7svy/?=
 =?us-ascii?Q?VmB84TdlYRSpk4wU6wlBjS6iwsyWI3hqV/VMPEZdAWPu9GPMxId39/w1N5uA?=
 =?us-ascii?Q?+akK2neKwQvXbX45I7vyFSlRyAMl4BKYvxLE4qcN5u+aDAZd0oInUHTMaGOB?=
 =?us-ascii?Q?XDRK6Ls6O//3NVa6MgBocq/zSM9rCe9DLhfAK5CgSh7UgoWVUtGqEEluTwxW?=
 =?us-ascii?Q?v2HR7jFBWuUyHPWN2BCfujia+BcQawEBeYuJjO0V+o7jLa2rfrKGNG+nlox3?=
 =?us-ascii?Q?rq+fwxBvt2wwthcccgp+ZVU/pf6WeuyWNI362+m0h3iuhF22xQMmTBnQIRdO?=
 =?us-ascii?Q?hW26g9cRptdDIVR4usTNc6knC+kofArXg0U4/UMffUKyFu6E+R7AyZDnAMt6?=
 =?us-ascii?Q?JnKCH9Cq6AFn8GKwZv5D7n3AONKsQNbrnu9WcVtQ49h5YePsRJsI9v+t0YNu?=
 =?us-ascii?Q?0PQVgKdoxOvlfBsgWd7eBdt+UR2u357zhUiv9tNHFoAex+7/G0QcEJKSAZxg?=
 =?us-ascii?Q?BExS/YTMGdaJp9gGo6MtAJlzEf83v+Lac9VBcnEKOT/rWJSrxDRpnbqQzS+/?=
 =?us-ascii?Q?j2ZtuEtH4MCjuJ8UIhh4AVumHHLFjCdilbj16siscwhp01z96HT9H6hIxl7f?=
 =?us-ascii?Q?qoGUnGy0IMyXxtms/k/yZ3h5hp4DRb3yVc2xO7R4xuhxQsLD4DguDNpp2jmI?=
 =?us-ascii?Q?LnWqH+jvOduvMgEUuhbKGe4N7RBHJB8YW/qXmR9z4xh5jKgy7qW6qKK4C2lb?=
 =?us-ascii?Q?HgTRG3ygTBp6IeQ/8LnPAYt3jzWgPnzbOyliMtxM0+CdqQlZk260Cr0qgbDT?=
 =?us-ascii?Q?WTj98f4BJEwueOIC6kPcLWzxofUczkw44k+0GYHUR3vauyWDkNfmX2OzRm1B?=
 =?us-ascii?Q?wXeWoZWs2/GMD/NRb5eDx6Us8rP3X+/j0F5R9s8zd6yBnxiM1TcH89iAOEsP?=
 =?us-ascii?Q?M0khUm95KltOolFZ1XyfSMuvsR7fP1CucqKh206ROI6RQoHV1+N8quZ0UGNa?=
 =?us-ascii?Q?uRPZ6Qqngq6ALFl/dSCXRGzUo0EheJj+W/jGhdxzgG3iOABInLPe3M2bFZvn?=
 =?us-ascii?Q?iErHSCTNX1acznROYocybBmKNy0q+odF27ciBl1gzmLE6wFVDL4Js04fNWLR?=
 =?us-ascii?Q?ykbkq8yubWpAO8NrQG+067Ujwe/BpXll?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zw0fA0a/v7tcpcSiqQjG9kYr7CPaCHdyiekLai6clOvJD6qPhuwme4uDk4CI?=
 =?us-ascii?Q?oFC7f6VGRqtSCQu9nm65rIHZUVLku/dwVI8TOR4DlO6CgI7tGc8UVxhayrSg?=
 =?us-ascii?Q?VdyEK0/1HzJlnc4j5VBPy116WT/iOvpbKBVJxJiMBsksW33GOZwwgThWxU12?=
 =?us-ascii?Q?D7V0LBPD1J62/5pxrU2zSXOyLTRytk3f7BHnSanbXLbMRxG69cu+Os/XZZJy?=
 =?us-ascii?Q?M9j6IMp7WfP+jsLw1cFT90BhHguoZm7HL33srEVrshHOtGV6MFsiAAs/GE6x?=
 =?us-ascii?Q?WPJsMHx0W3DmqNKSoOWcETeU/hAWz09eD+560TvrEUFe6rGHOQUxVz05Nsnc?=
 =?us-ascii?Q?mKcnyOCfQ3AmFU8og0yhzmkc49O+rat8p0A2c49YOC1XSXvumX9Z5ONNj3Zq?=
 =?us-ascii?Q?7td6XKd2dPVnTYdgM7nmwH8IFi/4G35Hsou6UIT7uBlD2VFuDgXgTwTV9JXa?=
 =?us-ascii?Q?bdcqVuBGwz9szkEBJ3ZD+kmSZH32vKsxmBBBjBQrFlB0uXTxguuiy7VQNU0i?=
 =?us-ascii?Q?rFgA4hxcJw7tRvRLJYeStFsOsePeclhi0KEJusjsiMO5nYae4Qrod3EdgSRr?=
 =?us-ascii?Q?Y0q2/h7H+qAR7i3OGC83+VKssxs2HaV4k4DhEQ9MjBBdWj4bPumhTNFLsg0A?=
 =?us-ascii?Q?NmoGsm5QA5q2W9ELdLaiMByKM6weJ8hEYt1isXbBQ+gvZob/uMYi9iZ48/Ms?=
 =?us-ascii?Q?mOqF9uunS1UjzgtZclX49wxyGp79cCtoX8DDLkTOdpTL2E+qYTXRFAIvr3fG?=
 =?us-ascii?Q?fpBObPGRGIN9zaJKKtakTA/7nYh8cKijXtp/ZtWJxXxu/Q0HRh70sMwsXk6+?=
 =?us-ascii?Q?a6OBY4UOs9+wXdkbJ1UJegJzf7TgGXqVDetC6tQr2GheTXSbhYh2t3DQfjsD?=
 =?us-ascii?Q?Y8TeetDadXBxQz00ooKCoT4ymuv1rmQ4Zcinwa9eQwpb9TrKq/wZwjytGatw?=
 =?us-ascii?Q?OLTBVci2N4GFnBXbqIvE2VpJtKA1rI/teKELsfX+ArvZfPux6TmNjclJx49j?=
 =?us-ascii?Q?sxTHHbbcmha9l08s4qf5EGso8Hatkyjr6u9ahBao+qX+iYHohHT3vN3jsK0c?=
 =?us-ascii?Q?sIciu+fGpXCdsulU55DrH+2S51kRj8xALd4H1iGQM2KDGjYahcrn5LGhnzh0?=
 =?us-ascii?Q?mM4AcUb9dDfNIYLSQxvjNgBBBtb4blLLwABdOO7HSu1ibLyqxNACRf6DyKH5?=
 =?us-ascii?Q?gmESGBkGV+HbrfwekDNa8MMRY3ZaD3vxiAtu085QSkK4PJEzpQVaNmiZEAKO?=
 =?us-ascii?Q?AkJWE8Y977Ilr/5l+lf6KMhRlA2ND5CTHUmJJrQVKspjgCdqnrG1X/8x33Ve?=
 =?us-ascii?Q?zW3tBuxiouTFgJnOoSCXdgON+WrmWGcRY+7XqYP9BZqAIGsfvf0h7fU3sF9X?=
 =?us-ascii?Q?JcYbYWDjgNa9Nlmm9cIT/4mQXuKmHV4y4w2xPu9PX5JsdARkmDVHH0lMEwob?=
 =?us-ascii?Q?MHJbCmxvURb3duh9Hzi0MGVdRPE9XPnAGdFP7z93OVGHbSC5AtWL2KWPrvzx?=
 =?us-ascii?Q?Y7kUyy3GsheUragkhn/zA06g0EraiWyTZl1/N2KnD8mUeG3pwAHvsHAExnGt?=
 =?us-ascii?Q?/spGMVESTI0FzPr+6sAS35IO1ljF/qnjroG99TsBVWwk/eQl6cLpBtUcgC4G?=
 =?us-ascii?Q?Sl6kudGTukjAX8FmBeG1z+k=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dad12b8-812c-4eb4-543f-08de12048da5
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:49.9878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrkL3TAEwpnp2JJ9Y0y6VtJyCRo3++/yulJ1pq7P6WMfT2K7F3Mt+M4ZyqyB/nMPlpkLeiXhO+2SCENslvZ25g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4555

Rename the remaining MSI-specific symbols and functions in ntb_transport
to reflect their new generic interrupt backend usage. This unifies
naming for both MSI-based and non-MSI backends.

No functional changes.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 84 ++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index ff4a149680c5..a4f51c9f18b7 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -203,8 +203,8 @@ struct ntb_transport_qp {
 	u64 tx_memcpy;
 	u64 tx_async;
 
-	bool use_msi;
-	int msi_irq;
+	bool use_intr;
+	int irq;
 	struct ntb_intr_desc intr_desc;
 	struct ntb_intr_desc peer_intr_desc;
 };
@@ -241,8 +241,8 @@ struct ntb_transport_ctx {
 	u64 qp_bitmap_free;
 
 	bool use_intr;
-	unsigned int msi_spad_offset;
-	u64 msi_db_mask;
+	unsigned int intr_spad_offset;
+	u64 intr_db_mask;
 
 	bool link_is_up;
 	struct delayed_work link_work;
@@ -702,11 +702,11 @@ static irqreturn_t ntb_transport_isr(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static void ntb_transport_setup_qp_peer_msi(struct ntb_transport_ctx *nt,
-					    unsigned int qp_num)
+static void ntb_transport_setup_qp_peer_intr(struct ntb_transport_ctx *nt,
+					     unsigned int qp_num)
 {
 	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
-	int spad = qp_num * 2 + nt->msi_spad_offset;
+	int spad = qp_num * 2 + nt->intr_spad_offset;
 
 	if (!nt->use_intr)
 		return;
@@ -719,7 +719,7 @@ static void ntb_transport_setup_qp_peer_msi(struct ntb_transport_ctx *nt,
 	qp->peer_intr_desc.data =
 		ntb_peer_spad_read(qp->ndev, PIDX, spad + 1);
 
-	dev_dbg(&qp->ndev->pdev->dev, "QP%d Peer MSI addr=%x data=%x\n",
+	dev_dbg(&qp->ndev->pdev->dev, "QP%d Peer interruption addr=%x data=%x\n",
 		qp_num, qp->peer_intr_desc.addr_offset, qp->peer_intr_desc.data);
 
 	if (qp->peer_intr_desc.addr_offset == INTR_INVALID_ADDR_OFFSET ||
@@ -727,20 +727,20 @@ static void ntb_transport_setup_qp_peer_msi(struct ntb_transport_ctx *nt,
 		dev_info(&qp->ndev->pdev->dev,
 			 "Invalid addr_offset or data, falling back to doorbell\n");
 	else {
-		qp->use_msi = true;
+		qp->use_intr = true;
 		dev_info(&qp->ndev->pdev->dev,
-			 "Using MSI interrupts for QP%d\n", qp_num);
+			 "Using interrupts for QP%d\n", qp_num);
 	}
 }
 
-static void ntb_transport_setup_qp_msi(struct ntb_transport_ctx *nt,
-				       unsigned int qp_num, bool changed)
+static void ntb_transport_setup_qp_intr(struct ntb_transport_ctx *nt,
+					unsigned int qp_num, bool changed)
 {
 	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
-	int spad = qp_num * 2 + nt->msi_spad_offset;
+	int spad = qp_num * 2 + nt->intr_spad_offset;
 	int rc;
 
-	if (!changed && qp->msi_irq)
+	if (!changed && qp->irq)
 		return;
 
 	ntb_spad_write(qp->ndev, spad, INTR_INVALID_ADDR_OFFSET);
@@ -751,17 +751,17 @@ static void ntb_transport_setup_qp_msi(struct ntb_transport_ctx *nt,
 
 	if (spad >= ntb_spad_count(nt->ndev)) {
 		dev_warn_once(&qp->ndev->pdev->dev,
-			      "Not enough SPADS to use MSI interrupts\n");
+			      "Not enough SPADS to use interrupts\n");
 		return;
 	}
 
-	if (!qp->msi_irq) {
-		qp->msi_irq = ntb_intr_request_irq(qp->ndev, ntb_transport_isr,
-						   KBUILD_MODNAME, qp,
-						   &qp->intr_desc);
-		if (qp->msi_irq < 0) {
+	if (!qp->irq) {
+		qp->irq = ntb_intr_request_irq(qp->ndev, ntb_transport_isr,
+					       KBUILD_MODNAME, qp,
+					       &qp->intr_desc);
+		if (qp->irq < 0) {
 			dev_warn(&qp->ndev->pdev->dev,
-				 "Unable to allocate MSI interrupt for qp%d\n",
+				 "Unable to allocate an interrupt for qp%d\n",
 				 qp_num);
 			return;
 		}
@@ -775,24 +775,24 @@ static void ntb_transport_setup_qp_msi(struct ntb_transport_ctx *nt,
 	if (rc)
 		goto err_free_interrupt;
 
-	dev_dbg(&qp->ndev->pdev->dev, "QP%d MSI %d addr=%x data=%x\n",
-		qp_num, qp->msi_irq, qp->intr_desc.addr_offset,
+	dev_dbg(&qp->ndev->pdev->dev, "QP%d Interrupt %d addr=%x data=%x\n",
+		qp_num, qp->irq, qp->intr_desc.addr_offset,
 		qp->intr_desc.data);
 
 	return;
 
 err_free_interrupt:
-	ntb_intr_free_irq(qp->ndev, qp->msi_irq, qp, &qp->intr_desc);
+	ntb_intr_free_irq(qp->ndev, qp->irq, qp, &qp->intr_desc);
 }
 
-static void ntb_transport_msi_peer_desc_changed(struct ntb_transport_ctx *nt)
+static void ntb_transport_intr_peer_desc_changed(struct ntb_transport_ctx *nt)
 {
 	int i;
 
-	dev_dbg(&nt->ndev->pdev->dev, "Peer MSI descriptors changed");
+	dev_dbg(&nt->ndev->pdev->dev, "Peer Interrupt descriptors changed");
 
 	for (i = 0; i < nt->qp_count; i++)
-		ntb_transport_setup_qp_peer_msi(nt, i);
+		ntb_transport_setup_qp_peer_intr(nt, i);
 }
 
 static void ntb_transport_intr_desc_changed(void *data)
@@ -800,12 +800,12 @@ static void ntb_transport_intr_desc_changed(void *data)
 	struct ntb_transport_ctx *nt = data;
 	int i;
 
-	dev_dbg(&nt->ndev->pdev->dev, "MSI descriptors changed");
+	dev_dbg(&nt->ndev->pdev->dev, "Interrupt descriptors changed");
 
 	for (i = 0; i < nt->qp_count; i++)
-		ntb_transport_setup_qp_msi(nt, i, true);
+		ntb_transport_setup_qp_intr(nt, i, true);
 
-	ntb_peer_db_set(nt->ndev, nt->msi_db_mask);
+	ntb_peer_db_set(nt->ndev, nt->intr_db_mask);
 }
 
 static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
@@ -1075,14 +1075,14 @@ static void ntb_transport_link_work(struct work_struct *work)
 		rc = ntb_intr_setup_mws(ndev);
 		if (rc) {
 			dev_warn(&pdev->dev,
-				 "Failed to register MSI memory window: %d\n",
+				 "Failed to register Interrupt memory window: %d\n",
 				 rc);
 			nt->use_intr = false;
 		}
 	}
 
 	for (i = 0; i < nt->qp_count; i++)
-		ntb_transport_setup_qp_msi(nt, i, false);
+		ntb_transport_setup_qp_intr(nt, i, false);
 
 	for (i = 0; i < nt->mw_count; i++) {
 		size = nt->mw_vec[i].phys_size;
@@ -1141,7 +1141,7 @@ static void ntb_transport_link_work(struct work_struct *work)
 		struct ntb_transport_qp *qp = &nt->qp_vec[i];
 
 		ntb_transport_setup_qp_mw(nt, i);
-		ntb_transport_setup_qp_peer_msi(nt, i);
+		ntb_transport_setup_qp_peer_intr(nt, i);
 
 		if (qp->client_ready)
 			schedule_delayed_work(&qp->link_work, 0);
@@ -1317,8 +1317,8 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	nt->ndev = ndev;
 
 	/*
-	 * If we are using MSI, and have at least one extra memory window,
-	 * we will reserve the last MW for the MSI window.
+	 * If we are using interrupt, and have at least one extra memory window,
+	 * we will reserve the last MW for the interrupt window.
 	 */
 	if (use_intr && mw_count > 1) {
 		rc = ntb_intr_init(ndev, ntb_transport_intr_desc_changed);
@@ -1341,7 +1341,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	max_mw_count_for_spads = (spad_count - MW0_SZ_HIGH) / 2;
 	nt->mw_count = min(mw_count, max_mw_count_for_spads);
 
-	nt->msi_spad_offset = nt->mw_count * 2 + MW0_SZ_HIGH;
+	nt->intr_spad_offset = nt->mw_count * 2 + MW0_SZ_HIGH;
 
 	nt->mw_vec = kcalloc_node(mw_count, sizeof(*nt->mw_vec),
 				  GFP_KERNEL, node);
@@ -1375,8 +1375,8 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	qp_count = ilog2(qp_bitmap);
 	if (nt->use_intr) {
 		qp_count -= 1;
-		nt->msi_db_mask = BIT_ULL(qp_count);
-		ntb_db_clear_mask(ndev, nt->msi_db_mask);
+		nt->intr_db_mask = BIT_ULL(qp_count);
+		ntb_db_clear_mask(ndev, nt->intr_db_mask);
 	}
 
 	if (max_num_clients && max_num_clients < qp_count)
@@ -1802,7 +1802,7 @@ static void ntb_tx_copy_callback(void *data,
 
 	iowrite32(entry->flags | DESC_DONE_FLAG, &hdr->flags);
 
-	if (qp->use_msi)
+	if (qp->use_intr)
 		ntb_intr_peer_trigger(qp->ndev, PIDX, &qp->peer_intr_desc);
 	else
 		ntb_peer_db_set(qp->ndev, BIT_ULL(qp->qp_num));
@@ -2477,9 +2477,9 @@ static void ntb_transport_doorbell_callback(void *data, int vector)
 	u64 db_bits;
 	unsigned int qp_num;
 
-	if (ntb_db_read(nt->ndev) & nt->msi_db_mask) {
-		ntb_transport_msi_peer_desc_changed(nt);
-		ntb_db_clear(nt->ndev, nt->msi_db_mask);
+	if (ntb_db_read(nt->ndev) & nt->intr_db_mask) {
+		ntb_transport_intr_peer_desc_changed(nt);
+		ntb_db_clear(nt->ndev, nt->intr_db_mask);
 	}
 
 	db_bits = (nt->qp_bitmap & ~nt->qp_bitmap_free &
-- 
2.48.1


