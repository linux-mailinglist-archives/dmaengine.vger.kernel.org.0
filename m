Return-Path: <dmaengine+bounces-7401-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C52C9429A
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7D086348FA8
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0693148B2;
	Sat, 29 Nov 2025 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="SjEpsN0q"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010018.outbound.protection.outlook.com [52.101.229.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE70B313291;
	Sat, 29 Nov 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432283; cv=fail; b=IJYIyAxoLS1yBVtSEa8bDQx39SoSnzwSXyUYH54FQ2hKmmOCt1UdY5XkR+dxakotuxOArkuLVJ7/67gV1fqVYzVz4NUNgKHeVlhhgWBoQ2da1qLbgWCzkQNaviouKbcD0PZ2TGcarqJvuvKMhrchEHnW0e00Bs3X6Fr0JWl/O9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432283; c=relaxed/simple;
	bh=tzqJG1SQNV4QZQ4fJm6j7npLxwc1bMV7T3fWmuEbpjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lwt0LWxWr9+LNrUBSE2+FhrkeFeQof2ikYRNnht2jQ+A4F85EMOB9ZKiFiM5od+1hbgHt166EelrRAqlr5Z7BP37W8QDlQfiEB2MFs84FhYoGOIOYNxLH9jWve2ZhUk3qzS+Llf0oEX9vfwPidb6OSKxZCfnDn1TxiomJlJix2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SjEpsN0q; arc=fail smtp.client-ip=52.101.229.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhDBQiTth7MvqE+yrkS1zAjNmXBpETe66isBikwaelbNHM7vmK70BksJNED4OGK7R58bb3+QZYZadIQBjLjFXitNm788tGKGWvL5gnhifqBh4Cyeh4h6sgLTn8bo5SFyzi+5x9wilUKKx5i9T5/Gn40i295eBFAIVWowC2SeAN1TfRog63vfieqn0DEVjQZPtta1LbN4gUKEAExt3CpoqrDa5XqC5cGxBuQ6uAf/hSsw62q0sv3e//Xh3moXZAYlQj3uCMCUf9NxjC0Q68x4/z5dPEURPOnhUJO8zUmQu9KfUu67zzQD3NkRnt+xeeVq4Cl+pz6pTppkuucZDTvsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgnhoCETD1Lp7ZJbVi6b2EH7rIr1lCmT4Er67WtrMag=;
 b=SHObTWHNlA9mHu169C/mkwkWouW4yu2kCTSou7PAGuET6G1UlR5T4MKAxPmX3PGaShKX2vugTlfXcUJBHbhifdBqxyLDSow+heumZGP+pA9udd4fS+vuP9GqITJ5ml8QFeqUrGXpSmgXtt704u0x76gAZrwKJyJg2sqirUX+rip82MCL1d0XHOCQ+t4x1KcRxvAEynAK3isM0fpe+fOXz3oGsOPzAI9SYkQMEb2SAgq5Wgq/V4/KoyRKADmICnVQFezFGTy7KHCQJAqIZJKDX6GTiZPxFIPEQJOuLuQXJEduVUjGyF4PNaHYwi++MPriOVV4LTDlJGwxXYrqKS0h6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgnhoCETD1Lp7ZJbVi6b2EH7rIr1lCmT4Er67WtrMag=;
 b=SjEpsN0qFE1jkseTUqdWwoPZhnFiAp4SQHzkpJ9GRbUeWq/TCqI/LqOxnq/O7clxCTT5+a86OtJY4tiyjCvad+D0KDxtMiWqoBo00zcNfPEjetJdWjILax9Cfhjg6xC+KGd/l8iV4VvHYdyPJibzMENOfd354wyhcsyt0QdGNPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4684.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:35 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:35 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com
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
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH v2 16/27] NTB: ntb_transport: Introduce get_dma_dev() helper
Date: Sun, 30 Nov 2025 01:03:54 +0900
Message-ID: <20251129160405.2568284-17-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0067.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::20) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: 971e36ce-e429-4d2c-f25d-08de2f60fd7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mhBXBdQsPH+qBNU9PK7/6bgwmaRuA3kte4yYP2EhI1EXWXemfG22df6sC/Wo?=
 =?us-ascii?Q?HOwYySjsL9mw0kGk3ujsBdDfyhl7Cth/8pSBhwOoD0ckYuSXVws7usjMmThc?=
 =?us-ascii?Q?DE9TW1v0AHGHtmt3fKz6h8jGfnj3NVIsITJxf2aZcGm3jM91RZrb9rhiPFcb?=
 =?us-ascii?Q?ep2z+d8Cu98RH5gOpcQz5x73Y/KXZuAfsEem8OIsc/I4canCHMW/bMmGCM9P?=
 =?us-ascii?Q?/yIZWQjjWbDf0BGJlXqEqLogMqXbxSKFJRMRctOuyMzI3UnUkRklfw/Idwcs?=
 =?us-ascii?Q?n2R8REU9PizDThcuwhEmjil1rT9I31VH5FmVAC4IoIQzvvjJk0GzEayarWEd?=
 =?us-ascii?Q?VpqNz1IP/Z8p0hANwv4jbzhLUYoJzufdEDAqlfVvWzblONfF92LdqO3Db1WP?=
 =?us-ascii?Q?IcUPkDRVbIdA6hkwq3vU22vDckzJeLCe3oY5PR9pMwo9es2SQG16vhcINMb+?=
 =?us-ascii?Q?j5Z0AjQkqN88134OJJ7vc21XCKrwDMuZpfRFvf4O5WtVBpTbP0FbK34f9LhB?=
 =?us-ascii?Q?YaNm4fLgms+MZ9C3fUr1KgqmQn77ibylGg3K9aeKnGrRNidLyXS8P+jEiUSc?=
 =?us-ascii?Q?k0eJirvs9cqVGB60HTT94yjkRBrB54npD4jJNU5bfIPJjgDuyUQPtrelGqq9?=
 =?us-ascii?Q?t1x8+Zc1vbo/OrDqDAFvYDhUdpg3E8TaW/OMrOJcp+g3nB5lndbXsSTT1Of3?=
 =?us-ascii?Q?7qQMpaEud9KtYv6QraEsBov17J4jKUERyLxEubpp6WR4Dd9AErcYM/lvMsZG?=
 =?us-ascii?Q?q75ffvAXcAKlTCFlgJG/7Yc54OOpjjUmdtBOXPo2N+85PvI1z8hLNBuituHa?=
 =?us-ascii?Q?chKeumOfQZik5be+vLXA7EoOQRS/BN7YTdUoMF1OctdsiQv85bgQ7fJCFK+c?=
 =?us-ascii?Q?YO0tHOINdGcbkTkmjULqYL4ARgAv9U3BlBeWYh7YBQsFEAXLa+I9L76conW5?=
 =?us-ascii?Q?2J++QsIEzZNDwE07KnWsrn/+ykoVDKR2Ulth1rxbgXmJrNN97MyJJI49VJ9v?=
 =?us-ascii?Q?9fT1tUtiBAuBleOgN2YxKXMXPn1co818E6rix/i5GiulXlvQSSKg9UHfiOYk?=
 =?us-ascii?Q?2owbr6MHG+ikzLu0z9hOq4qjeIsRWTjk9jljLipA0sT5BvjqXrls7wLE2cG0?=
 =?us-ascii?Q?VYjeHfwznYSIO72UT8G6YoQrJ/8fU6sHqzm7hPYGlWRERlO8uXy0iw/g8n+E?=
 =?us-ascii?Q?Ba8AQFz62yzLvzLR8HaVhQKS96VA7XskVrauO9aROH9ah6gYYljexqhwMoMG?=
 =?us-ascii?Q?jRsV9vFwjdWZYR0nPiA1miBk2Qi3BGJIlD66gSKZb+qJ0i+/JMpKcG4sUXV8?=
 =?us-ascii?Q?G1rTSiCQC5WfEC6Mbdtox7LNb/4banNGRDeCEZ4/9VMSNhpwiihTM9vbCG+G?=
 =?us-ascii?Q?lwV10k6CKr0p4xv+K2dmMXWT550kexqWPLNTGlsu7xB/8tCjkI78jK6s3qTM?=
 =?us-ascii?Q?Bm/Fj+OiNWjVZIvA02MmKl0wa4JMmnx0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D1UQumgm3D92v1NSU3gAu6Zn7Efj5uOW5xeA4X496ALh9ZmBXd4QVC2wFAfr?=
 =?us-ascii?Q?2SuOPDXX1QFzEyQ+rEGsT6I+71U7aK/L0/TaNTtOXw1Y3Q6j7Nnuj/789RKb?=
 =?us-ascii?Q?1ASb/5CzzUHWV0lx64AKHgNpAOLZFAI1YIcWOqOVZpDR7gzpNv/27RFnjyL3?=
 =?us-ascii?Q?Xwp2bdilFwKqdF8XO9lm7MMFPNg7I/bz8yGm4mefz73GTr4kMTtgW/0wzDyX?=
 =?us-ascii?Q?xohl+XbYPi84XDs3CDDr/E6BZjG0aBbvzdsuxvhgIH0fTW7FXLaQfd73+1Z6?=
 =?us-ascii?Q?kwXJ/8FkRdL0w9GF1LQswfs5RVuqGX472cQVdMl2LMC3LONxusqzGRs7H0Gx?=
 =?us-ascii?Q?BuVrMsLRHIoL0ybSsv/DEYGvdMVp/+j4j1F1RlUftKf//Ge+GDcd6siCkDrX?=
 =?us-ascii?Q?moLqOHhd245d+s5gNoFX14REU8tAf2xQojUTlSo3uP8z0G/IM1YcjC8KepFL?=
 =?us-ascii?Q?tI+hwuFQicpxrxZZXqNDQrU525jDcInTxB1SH0ktCzFQ8tBZbRDf3lo6ctde?=
 =?us-ascii?Q?U8pfZ+V2Dfespe4aIHaxfwwWO4FVIw7O09zWc3UfylDTMgYXBdWz4nDIUjG8?=
 =?us-ascii?Q?VrwvY4HoQoA0HzfxO3NS+JgMhVlQQmTQP30qs4B6UPmLZY1hXvUfJZoUtnpC?=
 =?us-ascii?Q?sMLuDyVvH8+AsKl/sb5CDyqK5CgEkQWx2x4ci8syo+kFlZYG/yJSO6pKvS8/?=
 =?us-ascii?Q?titPsEIf3EbsGs1d43OnaVHJtm2utrUxJNQLdbi2pDj1s6lQq5E3wTwJlL20?=
 =?us-ascii?Q?cis10Jr2kM8000v2vFIojUTKW+JPGuaqaQ0evM829inU0wcbO/F7QJdv0hMb?=
 =?us-ascii?Q?TG8E4ln4hagzqzScPF+BQFbOVQaw5JN4TypmNitEzpiE4jPPvndPMWEnnXwp?=
 =?us-ascii?Q?jyvb0mJtm6YLc9836zyqHinLsuCR48UZYTjIR/v0LoEAnyFjINtFn9idsD9q?=
 =?us-ascii?Q?n487Em0KUu7VwO9p38b1ehSFpL+XKe0JmDXE+OU1UI/8s8kNSKLVx2ezvOwB?=
 =?us-ascii?Q?rBvxYDggBgh/VQpBGu57J51UZ+RnqNRJUorfkfl2wANKKQAhBhvwZygcbEW7?=
 =?us-ascii?Q?NqkR87Vpj5nBcW9fGfm6TmMiTENrQTj1CMPhJE1Dh+QmLTepBcKkQ/zDVXTD?=
 =?us-ascii?Q?YNQ4dTMOX38HozbueO1i9d8U8RiK3NJUpK2mnR387A1+WlyW8b1mMiBDo8Om?=
 =?us-ascii?Q?1cM8eLQ1y9DQRSj/0cVkGfo2A+Ep04hvLcLJVfX5QPqMJ8Aym6tMnWsjw1jM?=
 =?us-ascii?Q?D3EyGMMNKoY277202WhOg031jvpV42arSsntQJt61bQfq6+0aR8ZNHbAMckf?=
 =?us-ascii?Q?S4H56EZIOpPHHVYDb8uW1JNyHGPEB/+m2IUTZo8Eyx8AoPe+o0kLMKWuzUgb?=
 =?us-ascii?Q?jmc0CG2EvlQHzBkam3UE1Fx+dYgQQkX1QxRMaiDAm/zn0/DQPOl+zPDAxDIS?=
 =?us-ascii?Q?g/BJFnDLukawTaOBYzwKX8EjNGVBbuu/RDJTLqtvU+WDFP/uLz3x3tn9HwHD?=
 =?us-ascii?Q?1wvKABJXO7TJ+DhJIMwfPO8THJ6/wsZg6tg+CdwHuTmWhhi2Vg9gItpQRDMU?=
 =?us-ascii?Q?pjEOT1SccajVh+l9jW0t14CBV8PgWQ2L/dUtgpbjckwA6+ciSWm3Vkd+4+tt?=
 =?us-ascii?Q?/W7QENscQ201E+pUsD1y2YQ=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 971e36ce-e429-4d2c-f25d-08de2f60fd7a
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:34.9944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKipI8peuXnyAuJ4Q53n6wQHQaDYIhmBvxqTZNt2HKhq564oah7ThLP9d192vEBlLet/B/kMISzTsKuhxzzHrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4684

When ntb_transport is used on top of an endpoint function (EPF) NTB
implementation, DMA mappings should be associated with the underlying
PCIe controller device rather than the virtual NTB PCI function. This
matters for IOMMU configuration and DMA mask validation.

Add a small helper, get_dma_dev(), that returns the appropriate struct
device for DMA mapping, i.e. &pdev->dev for a regular NTB host bridge
and the EPC parent device for EPF-based NTB endpoints. Use it in the
places where we set up DMA mappings or log DMA-related errors.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 5e2a87358e87..dad596e3a405 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -63,6 +63,7 @@
 #include <linux/mutex.h>
 #include "linux/ntb.h"
 #include "linux/ntb_transport.h"
+#include <linux/pci-epc.h>
 
 #define NTB_TRANSPORT_VERSION	4
 #define NTB_TRANSPORT_VER	"4"
@@ -259,6 +260,26 @@ struct ntb_payload_header {
 	unsigned int flags;
 };
 
+/*
+ * Return the device that should be used for DMA mapping.
+ *
+ * On RC, this is simply &pdev->dev.
+ * On EPF-backed NTB endpoints, use the EPC parent device so that
+ * DMA capabilities and IOMMU configuration are taken from the
+ * controller rather than the virtual NTB PCI function.
+ */
+static struct device *get_dma_dev(struct ntb_dev *ndev)
+{
+	struct device *dev = &ndev->pdev->dev;
+	struct pci_epc *epc;
+
+	epc = ntb_get_pci_epc(ndev);
+	if (epc)
+		dev = epc->dev.parent;
+
+	return dev;
+}
+
 enum {
 	VERSION = 0,
 	QP_LINKS,
@@ -762,13 +783,13 @@ static void ntb_transport_msi_desc_changed(void *data)
 static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
-	struct pci_dev *pdev = nt->ndev->pdev;
+	struct device *dev = get_dma_dev(nt->ndev);
 
 	if (!mw->virt_addr)
 		return;
 
 	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
-	dma_free_coherent(&pdev->dev, mw->alloc_size,
+	dma_free_coherent(dev, mw->alloc_size,
 			  mw->alloc_addr, mw->dma_addr);
 	mw->xlat_size = 0;
 	mw->buff_size = 0;
@@ -838,7 +859,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 		      resource_size_t size)
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
-	struct pci_dev *pdev = nt->ndev->pdev;
+	struct device *dev = get_dma_dev(nt->ndev);
 	size_t xlat_size, buff_size;
 	resource_size_t xlat_align;
 	resource_size_t xlat_align_size;
@@ -868,12 +889,12 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	mw->buff_size = buff_size;
 	mw->alloc_size = buff_size;
 
-	rc = ntb_alloc_mw_buffer(mw, &pdev->dev, xlat_align);
+	rc = ntb_alloc_mw_buffer(mw, dev, xlat_align);
 	if (rc) {
 		mw->alloc_size *= 2;
-		rc = ntb_alloc_mw_buffer(mw, &pdev->dev, xlat_align);
+		rc = ntb_alloc_mw_buffer(mw, dev, xlat_align);
 		if (rc) {
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"Unable to alloc aligned MW buff\n");
 			mw->xlat_size = 0;
 			mw->buff_size = 0;
@@ -886,7 +907,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	rc = ntb_mw_set_trans(nt->ndev, PIDX, num_mw, mw->dma_addr,
 			      mw->xlat_size, offset);
 	if (rc) {
-		dev_err(&pdev->dev, "Unable to set mw%d translation", num_mw);
+		dev_err(dev, "Unable to set mw%d translation", num_mw);
 		ntb_free_mw(nt, num_mw);
 		return -EIO;
 	}
-- 
2.48.1


