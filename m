Return-Path: <dmaengine+bounces-6956-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAC8BFF9A5
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A733B11D1
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F82E2FFF85;
	Thu, 23 Oct 2025 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ZsFL3qhK"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010001.outbound.protection.outlook.com [52.101.229.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CD62FF142;
	Thu, 23 Oct 2025 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203998; cv=fail; b=LF2HqWB+XiFdCT34B8FDKi78L/ffILwJ6VobVzjKB+uxrjCSNPOq556EElbuRA81kCWG1Uvhn/HUDHAWZRbXw2r3ArDiNG2wrmQ9kg/R0jkhVKIP9zBalBwUwTCaoQJWn2AaQOHAQnutn7TaVEzt8fv2n9TYZAyT9WhhAZNE2Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203998; c=relaxed/simple;
	bh=nSHySCVR0vsuAaMLPr+Z73TzpoHUhItdZs05XdPO65Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZFlyxtIzYJSsiU8n/fTgUafG8jpPx9UvFNLnxKlhcx4YVdOsb8UEjguFDXeLmELkL26P41dzB76L9fcPAeYAjsdXBVQiasWY40lyVOJ0Pdhjg3nxmiXkMySQFNd+2rxMt2+8oM77L3IH5n7/YvjDqwwU60zzI92f7M0Nmg6XL5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ZsFL3qhK; arc=fail smtp.client-ip=52.101.229.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvnq0Uyrzh+uL0+vB/dZJG1GcLN+B6rLFXYw/Qq/QaDvkN7BtnnHN01dM3zcU+JvzxZ1YC5dbx1jnj13Wy+ZSKkebwba1wtrKOm0IHCChI83XL5GoJttYwowEQS/Mlt5HZWAFE3I0WiH7cZSz4Prjc2T2Sggctg1GgBjlByU5IapZXGf4SO7PJXpoaoZ0hBnx8XQOYZwL2MsFP644UDnn8cIO1z+ZwDynCz3R6ciosa1X+eCMhEGZxohuEfqcRFagtFaOBFHQAbY8EnWnjJw6slJU9RsfQ3t3W4KPXq/Bi1Cas2ma0kSSR2kxDSmXpAuvfKHHdoC0MzUDlwMx5OcGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqdN+mJWIPQQ2Ky6VZd7V0Yf+N/UGUg/a5xwzqX9geY=;
 b=sLWX8IqrUUP8A5whkII8gVH8emCq0RWpUJ3jUl88trcqjgLJorBRzFqZVp+A6D/gfSOSQcDgovhD2z+D/9zTEIgFm/sB8OCFiNnHMLCPnFXGa63Ad0N9hfGPIe50sztSMX+KfAT5WS4V53vwfw9lH+SOx6rqFO0JrAsHqJQJOSjQMkoge8RpFnZm00NHVzmNLGdJe2v7Ek4GhE3DIEY/QOGBZ3nqldKblXho8S3/Xju/IQd0G3e7W7MyIP2UBn6QIsBSvr40HKLieP2JCYdtG+dJiz4qwtRssnQnKvGCpAEVu6bPIz1HiRaN128Z8nothhWSS7bSYqV0Ac3ygtCcAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqdN+mJWIPQQ2Ky6VZd7V0Yf+N/UGUg/a5xwzqX9geY=;
 b=ZsFL3qhKDnAJUCHplQ17DnOnYMoD5lrvaoEvxLAf7NEUz/jARzwSwDapvTP8odGjC+y4AnIwq2tHO1Ghj1dRTWSAZi/blcQi0eq7+vFPeNAkDETkWCocnQL8deVC8pq1u4TXB9mLD3xO+wNV6+78rvQRwNY/US9ol8BcP4kr22A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYRP286MB4555.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:49 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:49 +0000
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
Subject: [RFC PATCH 21/25] NTB: Introduce generic interrupt backend abstraction and convert MSI
Date: Thu, 23 Oct 2025 16:19:12 +0900
Message-ID: <20251023071916.901355-22-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0062.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::7) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYRP286MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: a009a493-f2a5-4f69-8fa0-08de12048cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dVT1EMr10IIX4tw/H3S12zOnmz7drqvxdO4XU7wXwC/TcAS4SzhFP3359Gqx?=
 =?us-ascii?Q?QLxk8nmdl8uKsajCaTDp58EZqBoWrdL4yvPynuyGBdmNhWqDjIDiW6vFV+Yu?=
 =?us-ascii?Q?KxAbB3tAtAY6j+0OW5hchOjGYJNPfpdQO1PH3ahUD8E9g11c3btVl+AaSsE9?=
 =?us-ascii?Q?EIS7BpzqAI5dVP/WQtoUyViTxwTnqzgJMphdAF33y55V19p/nAYXBfNhIxZd?=
 =?us-ascii?Q?XO2kjJpF6Wx6TwIkI+vpd9SaGA3exn4yD9baNTeHVxGBRqALCz/3dkc6Bzxz?=
 =?us-ascii?Q?ddf+UzkL0dTOFN5XHa+qJSyobFCyi5Adk87lbURyh4JExDaKrWBcXmSPqOqH?=
 =?us-ascii?Q?08HsOsYIoqf4w4/fGm1PENrrQ+igyaPTUoMK9qAYl9vmjMDX3uddeqSHAeSY?=
 =?us-ascii?Q?ybemW/gDsHyQJEa+RcPlRwUpY2927biPO1P120uNpGbkxafWdpWBEHjcorGW?=
 =?us-ascii?Q?zWcmQtm7kwNSJwk6GrzfHb1fDB9v2sfvTtnFSRH0yiAVaF8NtdPZhi1gkwZ4?=
 =?us-ascii?Q?TifnJTPLtsq8HKZKlGv9au04mZBFg3f9L9vaTPmvOxegcbuOa1JcJvy3hees?=
 =?us-ascii?Q?7wVxgadPciPyjl8VZKgfecnGFheygBopzgHiuUzazOMduPf6U1V4AOKug8Aw?=
 =?us-ascii?Q?FgJ+nsOgUgrtn8JGldOCAmaQYwgBmr6Glwh8LbuB5YBcQJQdlyuvQ8xhl6hy?=
 =?us-ascii?Q?bYsT5CupUEdkvRUM15RQFo6BPtYX7EsA0bSWFqqSJ+u5FNajl4aq1hmV9XoJ?=
 =?us-ascii?Q?VN/RZxP8/URx2QqPWGxUEdSBIvpsyFLNb7dUUr5EH6Q2dSV1NN33s+sMnijU?=
 =?us-ascii?Q?mHvvVIIlcUtNM0o5PbgRQ8mQCgZdPJEWWuCn/eVUXIuKra2nR5dEXctO6QbR?=
 =?us-ascii?Q?QVSih0XkCl383u7aovxSvL5Gr8DUfYIHMFUv1gKO4kyWksJ7n6gUxZN4afnz?=
 =?us-ascii?Q?6K8Foe+LpMVkzFAdoXwErqTjU/PJRLW18Q4bjl+oWPIySaWg/7LZWOq9Pud7?=
 =?us-ascii?Q?JjpKqok+aL42XXm0BZRB6jfi38HHb+ewpVaAXEusoCYdup5Xnb3jJ8pgyHlk?=
 =?us-ascii?Q?Q0jT4qgyF8VBYwgV3ixfn4KMPkFxeoSIK8+WrSKX2pM6ayMhj24aKty7aa7c?=
 =?us-ascii?Q?mfRGT2ftpDDgTcg0CASl6bP46aicPP8mP52EHZXALvkk03XA2MKRlDsRdSoJ?=
 =?us-ascii?Q?TkEyMr/JKig2C5i6HicgBRHHJCmMeLYaQ6ItYU1D8gpuaAnJuNIgTvvHMmwt?=
 =?us-ascii?Q?1IbLlP9xBkEpa1GOgVUcBEnmPaKjyF/4JH+F1eqsGQIZTxbJBkdBV/R147N9?=
 =?us-ascii?Q?NudBQp8hI0xXJMhziQqCeh7rPcj3XoYN/pta7llwrsvFwH2g9fpy7qCEA3nk?=
 =?us-ascii?Q?bKW2xQu90rnkPnI0ePnN0atMcu2a0JNO3h5S2w0Ij9znDV2SHsWKu0po6Dm+?=
 =?us-ascii?Q?rbVSvQk+GlS24qe7DqxoDaLeCed/7yHj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wCU2UCr881896E2sO0b90hbA4Uphqpp3JFpHjflIN4i4DX80dvykqXfYDOW6?=
 =?us-ascii?Q?QxHGWbHFzYctEH8dj/ojWb10YqYNlSdtqfrw+7Iq4XWkZOkORtOzyv+6SAIS?=
 =?us-ascii?Q?yWpVRpY3ERdrxrKVw1THN7yNKXGx/+pl05j3chpGJqrGEVeaHsMHBDFmrZqh?=
 =?us-ascii?Q?EKzyTWVuqWM0V7T42KvuruImfOPEQENVolRQwla63l+f/26/RuKC2QaAiQ+F?=
 =?us-ascii?Q?DdQb56V3ANBnOIrvBeORDm16zdvf250rK2YE2lPkYgpKeg5LOqoDnmy4NyZq?=
 =?us-ascii?Q?AbZ649QfQYou41MIdI0htGog61SukWxG4JprwWGmPFNvyGDe3EI/Nmac2NcV?=
 =?us-ascii?Q?YdxWq9wJIE3WDYKvBZUENyyNyp91nE/zntSq1p4JNavH3IdIqSojWCBdO+Df?=
 =?us-ascii?Q?Mub3/6EiEcl483PPyT8z0NZhCAryzYt8xBwHsp++SPd2OvHBxU90N9LJyc5T?=
 =?us-ascii?Q?4FxlmeG4/mhOTfLzRpIMLIRSayoEtkEJb6f9s1fK6Tmod2e/GRUhX1UKXNu7?=
 =?us-ascii?Q?UW/Trf4KW2g1HzYhfk5VCtJLfiQqWOb/hC9DtEmdP0gOytz26j3ezkrh7i4+?=
 =?us-ascii?Q?XWmpVWgr4mCKLtAiRjaz2wkyo470k1HMC2UpgB6XbegsQCKI2nSGLz2b87P+?=
 =?us-ascii?Q?nfSn5XonG3w44bf1CRT8hZ4Tqi3RByLpw93efOTmm4/L1aw01qNpA04pVS8Z?=
 =?us-ascii?Q?FJkZsLHl5BUbGkr1mKul5T1gjX6G8IzYQ6v889uQlhqiXP/Rc9UVr7BIQdiK?=
 =?us-ascii?Q?lJpPziSrsDotgFmSKlNJK7ObLE36Iki3McwLOChOD0M77ipzDeT+1rF0+9Pe?=
 =?us-ascii?Q?m4JRNafiypE8sn3by/SvUIBX0fpvGdXoa4qwoiuIEebHibGbN44g/c32/Uba?=
 =?us-ascii?Q?K5QpX3L1gmUfcjzpaErRXWKNuD926B3GYdd9lu7JjaRnELji1N8kLJZpmbAB?=
 =?us-ascii?Q?DGKTCLCySK6WbUchLk1ZBaQFgzkglIBgaz7vM44TENIw3/T5wrIdzHw7FOOi?=
 =?us-ascii?Q?1qS341ItQztcEVqQstQnAmdZKLYTwLKu8u068TJptwl2eoWhsZw6Q7uDZi6C?=
 =?us-ascii?Q?32BZwFZW1YqBq6CaNlZ3Sj39vP2YGvDE+vxWZO+SxA/pfL4kOgHU2cOUomCK?=
 =?us-ascii?Q?PLDsc87tIDSe0DAcQbhn1zmsTQEmXJIhL8Q5z65cDpXvyXB4B9yU7wzhWrvl?=
 =?us-ascii?Q?Tj/BsjfnN6xG5VObfKNYf0FWEhcI32OkG/UIL1ThhWZwXDLMcRzZ0NdSAfST?=
 =?us-ascii?Q?zOCP6Etf05VyxvFhFyfm9a31eBvKomY9+RUiffNcbncy7bLCgRKMCzxIeLmZ?=
 =?us-ascii?Q?75NFloAQ1zsreAbdPPqgcd90Mtx1TSA2GipvcrJK8+UTIWUNn6e5kwNWEexG?=
 =?us-ascii?Q?CWpK4pIIuG7azcZ704KxoOTE2acYlsAkH1wlziNHlq3GQzOWCWAC3CUhP9qT?=
 =?us-ascii?Q?7tc/Sa5vXzOUEBohbLuCF90/9ugR8Aye7t1tiAY9tiEZQOjENHPZ7i/QJnOl?=
 =?us-ascii?Q?vBPPgptO/YSH6ccYstazweX4GmlfLF+YkY7gEoI+kKpHJ+8ovTaEFBbwB7Va?=
 =?us-ascii?Q?JIZynJ6gy2lHL15aW3qRWcNsclmKkF3BiW11LgZNdP+5raybmg/WO12A5qzJ?=
 =?us-ascii?Q?rQ81GX1qs0f5ZKqUSv6p11A=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a009a493-f2a5-4f69-8fa0-08de12048cfc
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:48.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwmb8y/jF6Fp4Vt0EaBnOzE+4hlgjbnxRzHLB+kinJw/++cKllLSjqzMLT+2uVAYtu2rTVdzalEsdeT68kceww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4555

Refactor interrupt handling into a new ntb_intr_backend abstraction
layer, and migrate the MSI implementation to use it as a backend. This
enables alternate backends such as DW eDMA test interrupts.

No functional changes.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/Kconfig             |   5 ++
 drivers/ntb/Makefile            |   5 +-
 drivers/ntb/intr_common.c       |  55 ++++++++++++
 drivers/ntb/msi.c               | 145 ++++++++++++++++++--------------
 drivers/ntb/ntb_transport.c     |  36 ++++----
 drivers/ntb/test/ntb_msi_test.c |  26 +++---
 include/linux/ntb.h             |  85 ++++++++++++-------
 7 files changed, 231 insertions(+), 126 deletions(-)
 create mode 100644 drivers/ntb/intr_common.c

diff --git a/drivers/ntb/Kconfig b/drivers/ntb/Kconfig
index df16c755b4da..2f22f44245b3 100644
--- a/drivers/ntb/Kconfig
+++ b/drivers/ntb/Kconfig
@@ -13,9 +13,13 @@ menuconfig NTB
 
 if NTB
 
+config NTB_INTR_COMMON
+	bool
+
 config NTB_MSI
 	bool "MSI Interrupt Support"
 	depends on PCI_MSI
+	select NTB_INTR_COMMON
 	help
 	 Support using MSI interrupt forwarding instead of (or in addition to)
 	 hardware doorbells. MSI interrupts typically offer lower latency
@@ -24,6 +28,7 @@ config NTB_MSI
 	 in the hardware driver for creating the MSI interrupts.
 
 	 If unsure, say N.
+
 source "drivers/ntb/hw/Kconfig"
 
 source "drivers/ntb/test/Kconfig"
diff --git a/drivers/ntb/Makefile b/drivers/ntb/Makefile
index 3a6fa181ff99..feaa2a77cbf6 100644
--- a/drivers/ntb/Makefile
+++ b/drivers/ntb/Makefile
@@ -2,5 +2,6 @@
 obj-$(CONFIG_NTB) += ntb.o hw/ test/
 obj-$(CONFIG_NTB_TRANSPORT) += ntb_transport.o
 
-ntb-y			:= core.o
-ntb-$(CONFIG_NTB_MSI)	+= msi.o
+ntb-y				:= core.o
+ntb-$(CONFIG_NTB_INTR_COMMON)	+= intr_common.o
+ntb-$(CONFIG_NTB_MSI)		+= msi.o
diff --git a/drivers/ntb/intr_common.c b/drivers/ntb/intr_common.c
new file mode 100644
index 000000000000..e0e296fd3e3c
--- /dev/null
+++ b/drivers/ntb/intr_common.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+
+#include <linux/ntb.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+int ntb_intr_init(struct ntb_dev *ntb,
+		  void (*desc_changed)(void *ctx))
+{
+#ifdef CONFIG_NTB_MSI
+	if (ntb->pdev->dev.msi.data) {
+		ntb->intr_backend = ntb_intr_msi_backend();
+		dev_info(&ntb->dev, "NTB interrupt MSI backend selected.\n");
+	}
+#endif
+	if (!ntb->intr_backend)
+		return -ENODEV;
+	return ntb->intr_backend->init(ntb, desc_changed);
+}
+EXPORT_SYMBOL_GPL(ntb_intr_init);
+
+int ntb_intr_setup_mws(struct ntb_dev *ntb)
+{
+	return ntb->intr_backend->setup_mws(ntb);
+}
+EXPORT_SYMBOL_GPL(ntb_intr_setup_mws);
+
+void ntb_intr_clear_mws(struct ntb_dev *ntb)
+{
+	ntb->intr_backend->clear_mws(ntb);
+}
+EXPORT_SYMBOL_GPL(ntb_intr_clear_mws);
+
+int ntb_intr_request_irq(struct ntb_dev *ntb, irq_handler_t h,
+			 const char *name, void *dev_id,
+			 struct ntb_intr_desc *d)
+{
+	return ntb->intr_backend->request_irq(ntb, h, name, dev_id, d);
+}
+EXPORT_SYMBOL_GPL(ntb_intr_request_irq);
+
+void ntb_intr_free_irq(struct ntb_dev *ntb, int irq, void *dev_id,
+		       struct ntb_intr_desc *d)
+{
+	return ntb->intr_backend->free_irq(ntb, irq, dev_id, d);
+}
+EXPORT_SYMBOL_GPL(ntb_intr_free_irq);
+
+int ntb_intr_peer_trigger(struct ntb_dev *ntb, int peer,
+			  struct ntb_intr_desc *d)
+{
+	return ntb->intr_backend->peer_trigger(ntb, peer, d);
+}
+EXPORT_SYMBOL_GPL(ntb_intr_peer_trigger);
diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
index 983725d4eb13..cdc3ff6040c8 100644
--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -28,11 +28,12 @@ struct ntb_msi {
  *
  * Return: Zero on success, otherwise a negative error number.
  */
-int ntb_msi_init(struct ntb_dev *ntb,
-		 void (*desc_changed)(void *ctx))
+static int ntb_msi_init(struct ntb_dev *ntb,
+			void (*desc_changed)(void *ctx))
 {
 	phys_addr_t mw_phys_addr;
 	resource_size_t mw_size;
+	struct ntb_msi *msi;
 	int peer_widx;
 	int peers;
 	int ret;
@@ -42,12 +43,12 @@ int ntb_msi_init(struct ntb_dev *ntb,
 	if (peers <= 0)
 		return -EINVAL;
 
-	ntb->msi = devm_kzalloc(&ntb->dev, struct_size(ntb->msi, peer_mws, peers),
+	msi = devm_kzalloc(&ntb->dev, struct_size(msi, peer_mws, peers),
 				GFP_KERNEL);
-	if (!ntb->msi)
+	if (!msi)
 		return -ENOMEM;
 
-	ntb->msi->desc_changed = desc_changed;
+	msi->desc_changed = desc_changed;
 
 	for (i = 0; i < peers; i++) {
 		peer_widx = ntb_peer_mw_count(ntb) - 1 - i;
@@ -57,26 +58,26 @@ int ntb_msi_init(struct ntb_dev *ntb,
 		if (ret)
 			goto unroll;
 
-		ntb->msi->peer_mws[i] = devm_ioremap(&ntb->dev, mw_phys_addr,
+		msi->peer_mws[i] = devm_ioremap(&ntb->dev, mw_phys_addr,
 						     mw_size);
-		if (!ntb->msi->peer_mws[i]) {
+		if (!msi->peer_mws[i]) {
 			ret = -EFAULT;
 			goto unroll;
 		}
 	}
 
+	ntb->intr_priv = msi;
+
 	return 0;
 
 unroll:
 	for (i = 0; i < peers; i++)
-		if (ntb->msi->peer_mws[i])
-			devm_iounmap(&ntb->dev, ntb->msi->peer_mws[i]);
+		if (msi->peer_mws[i])
+			devm_iounmap(&ntb->dev, msi->peer_mws[i]);
 
-	devm_kfree(&ntb->dev, ntb->msi);
-	ntb->msi = NULL;
+	devm_kfree(&ntb->dev, msi);
 	return ret;
 }
-EXPORT_SYMBOL(ntb_msi_init);
 
 /**
  * ntb_msi_setup_mws() - Initialize the MSI inbound memory windows
@@ -92,7 +93,7 @@ EXPORT_SYMBOL(ntb_msi_init);
  *
  * Return: Zero on success, otherwise a negative error number.
  */
-int ntb_msi_setup_mws(struct ntb_dev *ntb)
+static int ntb_msi_setup_mws(struct ntb_dev *ntb)
 {
 	struct msi_desc *desc;
 	u64 addr;
@@ -100,13 +101,14 @@ int ntb_msi_setup_mws(struct ntb_dev *ntb)
 	resource_size_t addr_align, size_align, offset;
 	resource_size_t mw_size = SZ_32K;
 	resource_size_t mw_min_size = mw_size;
+	struct ntb_msi *msi = ntb->intr_priv;
 	int i;
 	int ret;
 
-	if (!ntb->msi)
+	if (!msi)
 		return -EINVAL;
 
-	if (ntb->msi->base_addr)
+	if (msi->base_addr)
 		return 0;
 
 	scoped_guard (msi_descs_lock, &ntb->pdev->dev) {
@@ -149,8 +151,8 @@ int ntb_msi_setup_mws(struct ntb_dev *ntb)
 			goto error_out;
 	}
 
-	ntb->msi->base_addr = addr;
-	ntb->msi->end_addr = addr + mw_min_size;
+	msi->base_addr = addr;
+	msi->end_addr = addr + mw_min_size;
 
 	return 0;
 
@@ -165,7 +167,6 @@ int ntb_msi_setup_mws(struct ntb_dev *ntb)
 
 	return ret;
 }
-EXPORT_SYMBOL(ntb_msi_setup_mws);
 
 /**
  * ntb_msi_clear_mws() - Clear all inbound memory windows
@@ -173,7 +174,7 @@ EXPORT_SYMBOL(ntb_msi_setup_mws);
  *
  * This function tears down the resources used by ntb_msi_setup_mws().
  */
-void ntb_msi_clear_mws(struct ntb_dev *ntb)
+static void ntb_msi_clear_mws(struct ntb_dev *ntb)
 {
 	int peer;
 	int peer_widx;
@@ -186,33 +187,33 @@ void ntb_msi_clear_mws(struct ntb_dev *ntb)
 		ntb_mw_clear_trans(ntb, peer, peer_widx);
 	}
 }
-EXPORT_SYMBOL(ntb_msi_clear_mws);
 
 struct ntb_msi_devres {
 	struct ntb_dev *ntb;
 	struct msi_desc *entry;
-	struct ntb_msi_desc *msi_desc;
+	struct ntb_intr_desc *intr_desc;
 };
 
 static int ntb_msi_set_desc(struct ntb_dev *ntb, struct msi_desc *entry,
-			    struct ntb_msi_desc *msi_desc, u16 vector_offset)
+			    struct ntb_intr_desc *intr_desc, u16 vector_offset)
 {
+	struct ntb_msi *msi = ntb->intr_priv;
 	u64 addr;
 
 	addr = entry->msg.address_lo +
 		((uint64_t)entry->msg.address_hi << 32);
 
-	if (addr < ntb->msi->base_addr || addr >= ntb->msi->end_addr) {
+	if (addr < msi->base_addr || addr >= msi->end_addr) {
 		dev_warn_once(&ntb->dev,
 			      "IRQ %d: MSI Address not within the memory window (%llx, [%llx %llx])\n",
-			      entry->irq, addr, ntb->msi->base_addr,
-			      ntb->msi->end_addr);
+			      entry->irq, addr, msi->base_addr,
+			      msi->end_addr);
 		return -EFAULT;
 	}
 
-	msi_desc->addr_offset = addr - ntb->msi->base_addr;
-	msi_desc->data = entry->msg.data + vector_offset;
-	msi_desc->vector_offset = vector_offset;
+	intr_desc->addr_offset = addr - msi->base_addr;
+	intr_desc->data = entry->msg.data + vector_offset;
+	intr_desc->vector_offset = vector_offset;
 
 	return 0;
 }
@@ -220,12 +221,13 @@ static int ntb_msi_set_desc(struct ntb_dev *ntb, struct msi_desc *entry,
 static void ntb_msi_write_msg(struct msi_desc *entry, void *data)
 {
 	struct ntb_msi_devres *dr = data;
+	struct ntb_msi *msi = dr->ntb->intr_priv;
 
-	WARN_ON(ntb_msi_set_desc(dr->ntb, entry, dr->msi_desc,
-				 dr->msi_desc->vector_offset));
+	WARN_ON(ntb_msi_set_desc(dr->ntb, entry, dr->intr_desc,
+				 dr->intr_desc->vector_offset));
 
-	if (dr->ntb->msi->desc_changed)
-		dr->ntb->msi->desc_changed(dr->ntb->ctx);
+	if (msi->desc_changed)
+		msi->desc_changed(dr->ntb->ctx);
 }
 
 static void ntbm_msi_callback_release(struct device *dev, void *res)
@@ -237,7 +239,7 @@ static void ntbm_msi_callback_release(struct device *dev, void *res)
 }
 
 static int ntbm_msi_setup_callback(struct ntb_dev *ntb, struct msi_desc *entry,
-				   struct ntb_msi_desc *msi_desc)
+				   struct ntb_intr_desc *intr_desc)
 {
 	struct ntb_msi_devres *dr;
 
@@ -248,7 +250,7 @@ static int ntbm_msi_setup_callback(struct ntb_dev *ntb, struct msi_desc *entry,
 
 	dr->ntb = ntb;
 	dr->entry = entry;
-	dr->msi_desc = msi_desc;
+	dr->intr_desc = intr_desc;
 
 	devres_add(&ntb->dev, dr);
 
@@ -259,14 +261,12 @@ static int ntbm_msi_setup_callback(struct ntb_dev *ntb, struct msi_desc *entry,
 }
 
 /**
- * ntbm_msi_request_threaded_irq() - allocate an MSI interrupt
+ * ntb_msi_request_irq() - allocate an MSI interrupt
  * @ntb:	NTB device context
  * @handler:	Function to be called when the IRQ occurs
- * @thread_fn:  Function to be called in a threaded interrupt context. NULL
- *              for clients which handle everything in @handler
- * @name:    An ascii name for the claiming device, dev_name(dev) if NULL
- * @dev_id:     A cookie passed back to the handler function
- * @msi_desc:	MSI descriptor data which triggers the interrupt
+ * @name:	An ascii name for the claiming device, dev_name(dev) if NULL
+ * @dev_id:	A cookie passed back to the handler function
+ * @intr_desc:	Generic interrupt descriptor
  *
  * This function assigns an interrupt handler to an unused
  * MSI interrupt and returns the descriptor used to trigger
@@ -281,19 +281,15 @@ static int ntbm_msi_setup_callback(struct ntb_dev *ntb, struct msi_desc *entry,
  *
  * Return: IRQ number assigned on success, otherwise a negative error number.
  */
-int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb, irq_handler_t handler,
-				  irq_handler_t thread_fn,
-				  const char *name, void *dev_id,
-				  struct ntb_msi_desc *msi_desc)
+static int ntb_msi_request_irq(struct ntb_dev *ntb, irq_handler_t handler,
+			       const char *name, void *dev_id,
+			       struct ntb_intr_desc *intr_desc)
 {
 	struct device *dev = &ntb->pdev->dev;
 	struct msi_desc *entry;
 	unsigned int virq;
 	int ret, i;
 
-	if (!ntb->msi)
-		return -EINVAL;
-
 	guard(msi_descs_lock)(dev);
 	msi_for_each_desc(entry, dev, MSI_DESC_ASSOCIATED) {
 		for (i = 0; i < entry->nvec_used; i++) {
@@ -301,18 +297,17 @@ int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb, irq_handler_t handler,
 			if (irq_has_action(virq))
 				continue;
 
-			ret = devm_request_threaded_irq(
-					&ntb->dev, virq, handler,
-					thread_fn, 0, name, dev_id);
+			ret = devm_request_irq(&ntb->dev, virq, handler,
+					       0, name, dev_id);
 			if (ret)
 				continue;
 
-			if (ntb_msi_set_desc(ntb, entry, msi_desc, i)) {
+			if (ntb_msi_set_desc(ntb, entry, intr_desc, i)) {
 				devm_free_irq(&ntb->dev, virq, dev_id);
 				continue;
 			}
 
-			ret = ntbm_msi_setup_callback(ntb, entry, msi_desc);
+			ret = ntbm_msi_setup_callback(ntb, entry, intr_desc);
 			if (ret) {
 				devm_free_irq(&ntb->dev, virq, dev_id);
 				return ret;
@@ -322,7 +317,23 @@ int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb, irq_handler_t handler,
 	}
 	return -ENODEV;
 }
-EXPORT_SYMBOL(ntbm_msi_request_threaded_irq);
+
+/**
+ * ntb_msi_free_irq() - free an MSI interrupt
+ * @ntb:	NTB device context
+ * @irq:	IRQ number assigned
+ * @dev_id:	A cookie passed back to the handler function
+ * @desc:	Generic interrupt descriptor
+ *
+ * Free an IRQ assigned by ntb_msi_request_irq().
+ *
+ * Return: void
+ */
+static void ntb_msi_free_irq(struct ntb_dev *ntb, int irq, void *dev_id,
+			     struct ntb_intr_desc *desc)
+{
+	devm_free_irq(&ntb->dev, irq, dev_id);
+}
 
 /**
  * ntb_msi_peer_trigger() - Trigger an interrupt handler on a peer
@@ -336,18 +347,30 @@ EXPORT_SYMBOL(ntbm_msi_request_threaded_irq);
  *
  * Return: Zero on success, otherwise a negative error number.
  */
-int ntb_msi_peer_trigger(struct ntb_dev *ntb, int peer,
-			 struct ntb_msi_desc *desc)
+static int ntb_msi_peer_trigger(struct ntb_dev *ntb, int peer,
+				struct ntb_intr_desc *desc)
 {
+	struct ntb_msi *msi = ntb->intr_priv;
 	int idx;
 
-	if (!ntb->msi)
-		return -EINVAL;
+	idx = desc->addr_offset / sizeof(*msi->peer_mws[peer]);
 
-	idx = desc->addr_offset / sizeof(*ntb->msi->peer_mws[peer]);
-
-	iowrite32(desc->data, &ntb->msi->peer_mws[peer][idx]);
+	iowrite32(desc->data, &msi->peer_mws[peer][idx]);
 
 	return 0;
 }
-EXPORT_SYMBOL(ntb_msi_peer_trigger);
+
+static const struct ntb_intr_backend ntb_intr_backend_msi = {
+	.name = "msi",
+	.init = ntb_msi_init,
+	.setup_mws = ntb_msi_setup_mws,
+	.clear_mws = ntb_msi_clear_mws,
+	.request_irq = ntb_msi_request_irq,
+	.free_irq = ntb_msi_free_irq,
+	.peer_trigger = ntb_msi_peer_trigger,
+};
+
+const struct ntb_intr_backend *ntb_intr_msi_backend(void)
+{
+	return &ntb_intr_backend_msi;
+}
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 4695eb5e6831..ff4a149680c5 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -205,8 +205,8 @@ struct ntb_transport_qp {
 
 	bool use_msi;
 	int msi_irq;
-	struct ntb_msi_desc msi_desc;
-	struct ntb_msi_desc peer_msi_desc;
+	struct ntb_intr_desc intr_desc;
+	struct ntb_intr_desc peer_intr_desc;
 };
 
 struct ntb_transport_mw {
@@ -714,16 +714,16 @@ static void ntb_transport_setup_qp_peer_msi(struct ntb_transport_ctx *nt,
 	if (spad >= ntb_spad_count(nt->ndev))
 		return;
 
-	qp->peer_msi_desc.addr_offset =
+	qp->peer_intr_desc.addr_offset =
 		ntb_peer_spad_read(qp->ndev, PIDX, spad);
-	qp->peer_msi_desc.data =
+	qp->peer_intr_desc.data =
 		ntb_peer_spad_read(qp->ndev, PIDX, spad + 1);
 
 	dev_dbg(&qp->ndev->pdev->dev, "QP%d Peer MSI addr=%x data=%x\n",
-		qp_num, qp->peer_msi_desc.addr_offset, qp->peer_msi_desc.data);
+		qp_num, qp->peer_intr_desc.addr_offset, qp->peer_intr_desc.data);
 
-	if (qp->peer_msi_desc.addr_offset == INTR_INVALID_ADDR_OFFSET ||
-	    qp->peer_msi_desc.data == INTR_INVALID_DATA)
+	if (qp->peer_intr_desc.addr_offset == INTR_INVALID_ADDR_OFFSET ||
+	    qp->peer_intr_desc.data == INTR_INVALID_DATA)
 		dev_info(&qp->ndev->pdev->dev,
 			 "Invalid addr_offset or data, falling back to doorbell\n");
 	else {
@@ -756,9 +756,9 @@ static void ntb_transport_setup_qp_msi(struct ntb_transport_ctx *nt,
 	}
 
 	if (!qp->msi_irq) {
-		qp->msi_irq = ntbm_msi_request_irq(qp->ndev, ntb_transport_isr,
+		qp->msi_irq = ntb_intr_request_irq(qp->ndev, ntb_transport_isr,
 						   KBUILD_MODNAME, qp,
-						   &qp->msi_desc);
+						   &qp->intr_desc);
 		if (qp->msi_irq < 0) {
 			dev_warn(&qp->ndev->pdev->dev,
 				 "Unable to allocate MSI interrupt for qp%d\n",
@@ -767,22 +767,22 @@ static void ntb_transport_setup_qp_msi(struct ntb_transport_ctx *nt,
 		}
 	}
 
-	rc = ntb_spad_write(qp->ndev, spad, qp->msi_desc.addr_offset);
+	rc = ntb_spad_write(qp->ndev, spad, qp->intr_desc.addr_offset);
 	if (rc)
 		goto err_free_interrupt;
 
-	rc = ntb_spad_write(qp->ndev, spad + 1, qp->msi_desc.data);
+	rc = ntb_spad_write(qp->ndev, spad + 1, qp->intr_desc.data);
 	if (rc)
 		goto err_free_interrupt;
 
 	dev_dbg(&qp->ndev->pdev->dev, "QP%d MSI %d addr=%x data=%x\n",
-		qp_num, qp->msi_irq, qp->msi_desc.addr_offset,
-		qp->msi_desc.data);
+		qp_num, qp->msi_irq, qp->intr_desc.addr_offset,
+		qp->intr_desc.data);
 
 	return;
 
 err_free_interrupt:
-	devm_free_irq(&nt->ndev->dev, qp->msi_irq, qp);
+	ntb_intr_free_irq(qp->ndev, qp->msi_irq, qp, &qp->intr_desc);
 }
 
 static void ntb_transport_msi_peer_desc_changed(struct ntb_transport_ctx *nt)
@@ -795,7 +795,7 @@ static void ntb_transport_msi_peer_desc_changed(struct ntb_transport_ctx *nt)
 		ntb_transport_setup_qp_peer_msi(nt, i);
 }
 
-static void ntb_transport_msi_desc_changed(void *data)
+static void ntb_transport_intr_desc_changed(void *data)
 {
 	struct ntb_transport_ctx *nt = data;
 	int i;
@@ -1072,7 +1072,7 @@ static void ntb_transport_link_work(struct work_struct *work)
 	/* send the local info, in the opposite order of the way we read it */
 
 	if (nt->use_intr) {
-		rc = ntb_msi_setup_mws(ndev);
+		rc = ntb_intr_setup_mws(ndev);
 		if (rc) {
 			dev_warn(&pdev->dev,
 				 "Failed to register MSI memory window: %d\n",
@@ -1321,7 +1321,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	 * we will reserve the last MW for the MSI window.
 	 */
 	if (use_intr && mw_count > 1) {
-		rc = ntb_msi_init(ndev, ntb_transport_msi_desc_changed);
+		rc = ntb_intr_init(ndev, ntb_transport_intr_desc_changed);
 		if (!rc) {
 			mw_count -= 1;
 			nt->use_intr = true;
@@ -1803,7 +1803,7 @@ static void ntb_tx_copy_callback(void *data,
 	iowrite32(entry->flags | DESC_DONE_FLAG, &hdr->flags);
 
 	if (qp->use_msi)
-		ntb_msi_peer_trigger(qp->ndev, PIDX, &qp->peer_msi_desc);
+		ntb_intr_peer_trigger(qp->ndev, PIDX, &qp->peer_intr_desc);
 	else
 		ntb_peer_db_set(qp->ndev, BIT_ULL(qp->qp_num));
 
diff --git a/drivers/ntb/test/ntb_msi_test.c b/drivers/ntb/test/ntb_msi_test.c
index 4e18e08776c9..d037892e752e 100644
--- a/drivers/ntb/test/ntb_msi_test.c
+++ b/drivers/ntb/test/ntb_msi_test.c
@@ -26,7 +26,7 @@ struct ntb_msit_ctx {
 		int irq_num;
 		int occurrences;
 		struct ntb_msit_ctx *nm;
-		struct ntb_msi_desc desc;
+		struct ntb_intr_desc desc;
 	} *isr_ctx;
 
 	struct ntb_msit_peer {
@@ -34,7 +34,7 @@ struct ntb_msit_ctx {
 		int pidx;
 		int num_irqs;
 		struct completion init_comp;
-		struct ntb_msi_desc *msi_desc;
+		struct ntb_intr_desc *intr_desc;
 	} peers[];
 };
 
@@ -62,7 +62,7 @@ static void ntb_msit_setup_work(struct work_struct *work)
 	int ret;
 	uintptr_t i;
 
-	ret = ntb_msi_setup_mws(nm->ntb);
+	ret = ntb_intr_setup_mws(nm->ntb);
 	if (ret) {
 		dev_err(&nm->ntb->dev, "Unable to setup MSI windows: %d\n",
 			ret);
@@ -74,7 +74,7 @@ static void ntb_msit_setup_work(struct work_struct *work)
 		nm->isr_ctx[i].nm = nm;
 
 		if (!nm->isr_ctx[i].irq_num) {
-			irq = ntbm_msi_request_irq(nm->ntb, ntb_msit_isr,
+			irq = ntb_intr_request_irq(nm->ntb, ntb_msit_isr,
 						   KBUILD_MODNAME,
 						   &nm->isr_ctx[i],
 						   &nm->isr_ctx[i].desc);
@@ -131,7 +131,7 @@ static void ntb_msit_link_event(void *ctx)
 static void ntb_msit_copy_peer_desc(struct ntb_msit_ctx *nm, int peer)
 {
 	int i;
-	struct ntb_msi_desc *desc = nm->peers[peer].msi_desc;
+	struct ntb_intr_desc *desc = nm->peers[peer].intr_desc;
 	int irq_count = nm->peers[peer].num_irqs;
 
 	for (i = 0; i < irq_count; i++) {
@@ -149,7 +149,7 @@ static void ntb_msit_copy_peer_desc(struct ntb_msit_ctx *nm, int peer)
 static void ntb_msit_db_event(void *ctx, int vec)
 {
 	struct ntb_msit_ctx *nm = ctx;
-	struct ntb_msi_desc *desc;
+	struct ntb_intr_desc *desc;
 	u64 peer_mask = ntb_db_read(nm->ntb);
 	u32 irq_count;
 	int peer;
@@ -168,8 +168,8 @@ static void ntb_msit_db_event(void *ctx, int vec)
 		if (!desc)
 			continue;
 
-		kfree(nm->peers[peer].msi_desc);
-		nm->peers[peer].msi_desc = desc;
+		kfree(nm->peers[peer].intr_desc);
+		nm->peers[peer].intr_desc = desc;
 		nm->peers[peer].num_irqs = irq_count;
 
 		ntb_msit_copy_peer_desc(nm, peer);
@@ -191,8 +191,8 @@ static int ntb_msit_dbgfs_trigger(void *data, u64 idx)
 	dev_dbg(&peer->nm->ntb->dev, "trigger irq %llu on peer %u\n",
 		idx, peer->pidx);
 
-	return ntb_msi_peer_trigger(peer->nm->ntb, peer->pidx,
-				    &peer->msi_desc[idx]);
+	return ntb_intr_peer_trigger(peer->nm->ntb, peer->pidx,
+				     &peer->intr_desc[idx]);
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(ntb_msit_trigger_fops, NULL,
@@ -344,7 +344,7 @@ static int ntb_msit_probe(struct ntb_client *client, struct ntb_dev *ntb)
 		return ret;
 	}
 
-	ret = ntb_msi_init(ntb, ntb_msit_desc_changed);
+	ret = ntb_intr_init(ntb, ntb_msit_desc_changed);
 	if (ret) {
 		dev_err(&ntb->dev, "Unable to initialize MSI library: %d\n",
 			ret);
@@ -392,10 +392,10 @@ static void ntb_msit_remove(struct ntb_client *client, struct ntb_dev *ntb)
 
 	ntb_link_disable(ntb);
 	ntb_db_set_mask(ntb, ntb_db_valid_mask(ntb));
-	ntb_msi_clear_mws(ntb);
+	ntb_intr_clear_mws(ntb);
 
 	for (i = 0; i < ntb_peer_port_count(ntb); i++)
-		kfree(nm->peers[i].msi_desc);
+		kfree(nm->peers[i].intr_desc);
 
 	ntb_clear_ctx(ntb);
 	ntb_msit_remove_dbgfs(nm);
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 9f819c7383a3..1a88fe45471e 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -63,7 +63,7 @@
 
 struct ntb_client;
 struct ntb_dev;
-struct ntb_msi;
+struct ntb_intr_backend;
 struct pci_dev;
 struct pci_epc;
 
@@ -438,8 +438,9 @@ struct ntb_dev {
 	/* block unregister until device is fully released */
 	struct completion		released;
 
-#ifdef CONFIG_NTB_MSI
-	struct ntb_msi *msi;
+#ifdef CONFIG_NTB_INTR_COMMON
+	void				*intr_priv;
+	const struct ntb_intr_backend	*intr_backend;
 #endif
 };
 #define dev_ntb(__dev) container_of((__dev), struct ntb_dev, dev)
@@ -1659,58 +1660,78 @@ static inline int ntb_peer_highest_mw_idx(struct ntb_dev *ntb, int pidx)
 	return ntb_mw_count(ntb, pidx) - ret - 1;
 }
 
-struct ntb_msi_desc {
+struct ntb_intr_desc {
 	u32 addr_offset;
 	u32 data;
 	u16 vector_offset;
 };
 
-#ifdef CONFIG_NTB_MSI
+struct ntb_intr_backend {
+	const char *name;
+	int (*init)(struct ntb_dev *ntb, void (*desc_changed)(void *ctx));
+	int (*setup_mws)(struct ntb_dev *ntb);
+	void (*clear_mws)(struct ntb_dev *ntb);
+	int (*request_irq)(struct ntb_dev *ntb, irq_handler_t handler,
+			   const char *name, void *dev_id,
+			   struct ntb_intr_desc *desc);
+	void (*free_irq)(struct ntb_dev *ntb, int irq, void *dev_id,
+			 struct ntb_intr_desc *desc);
+	int (*peer_trigger)(struct ntb_dev *ntb, int pidx,
+			    struct ntb_intr_desc *desc);
+	int (*peer_addr)(struct ntb_dev *ntb, int pidx,
+			 const struct ntb_intr_desc *local, phys_addr_t *addr);
+};
+
+#ifdef CONFIG_NTB_INTR_COMMON
 
-int ntb_msi_init(struct ntb_dev *ntb, void (*desc_changed)(void *ctx));
-int ntb_msi_setup_mws(struct ntb_dev *ntb);
-void ntb_msi_clear_mws(struct ntb_dev *ntb);
-int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb, irq_handler_t handler,
-				  irq_handler_t thread_fn,
-				  const char *name, void *dev_id,
-				  struct ntb_msi_desc *msi_desc);
-int ntb_msi_peer_trigger(struct ntb_dev *ntb, int peer,
-			 struct ntb_msi_desc *desc);
+int ntb_intr_init(struct ntb_dev *ntb, void (*desc_changed)(void *ctx));
+int ntb_intr_setup_mws(struct ntb_dev *ntb);
+void ntb_intr_clear_mws(struct ntb_dev *ntb);
+int ntb_intr_request_irq(struct ntb_dev *ntb, irq_handler_t handler,
+			 const char *name, void *dev_id,
+			 struct ntb_intr_desc *intr_desc);
+void ntb_intr_free_irq(struct ntb_dev *ntb, int irq, void *dev_id,
+		       struct ntb_intr_desc *intr_desc);
+int ntb_intr_peer_trigger(struct ntb_dev *ntb, int peer,
+			  struct ntb_intr_desc *desc);
 
-#else /* not CONFIG_NTB_MSI */
+#else /* not CONFIG_NTB_INTR_COMMON */
 
-static inline int ntb_msi_init(struct ntb_dev *ntb,
+static inline int ntb_intr_init(struct ntb_dev *ntb,
 			       void (*desc_changed)(void *ctx))
 {
 	return -EOPNOTSUPP;
 }
-static inline int ntb_msi_setup_mws(struct ntb_dev *ntb)
+static inline int ntb_intr_setup_mws(struct ntb_dev *ntb)
 {
 	return -EOPNOTSUPP;
 }
-static inline void ntb_msi_clear_mws(struct ntb_dev *ntb) {}
-static inline int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb,
-						irq_handler_t handler,
-						irq_handler_t thread_fn,
-						const char *name, void *dev_id,
-						struct ntb_msi_desc *msi_desc)
+static inline void ntb_intr_clear_mws(struct ntb_dev *ntb) {}
+static inline int ntb_intr_request_irq(struct ntb_dev *ntb,
+				       irq_handler_t handler,
+				       const char *name, void *dev_id,
+				       struct ntb_intr_desc *intr_desc)
 {
 	return -EOPNOTSUPP;
 }
-static inline int ntb_msi_peer_trigger(struct ntb_dev *ntb, int peer,
-				       struct ntb_msi_desc *desc)
+static inline void ntb_intr_free_irq(struct ntb_dev *ntb, int irq, void *dev_id,
+				     struct ntb_intr_desc *desc)
+{
+}
+static inline int ntb_intr_peer_trigger(struct ntb_dev *ntb, int peer,
+					struct ntb_intr_desc *desc)
 {
 	return -EOPNOTSUPP;
 }
-#endif /* CONFIG_NTB_MSI */
+#endif /* CONFIG_NTB_INTR_COMMON */
 
-static inline int ntbm_msi_request_irq(struct ntb_dev *ntb,
-				       irq_handler_t handler,
-				       const char *name, void *dev_id,
-				       struct ntb_msi_desc *msi_desc)
+#ifdef CONFIG_NTB_MSI
+extern const struct ntb_intr_backend *ntb_intr_msi_backend(void);
+#else
+static inline const struct ntb_intr_backend *ntb_intr_msi_backend(void)
 {
-	return ntbm_msi_request_threaded_irq(ntb, handler, NULL, name,
-					     dev_id, msi_desc);
+	return NULL;
 }
+#endif /* CONFIG_NTB_MSI */
 
 #endif
-- 
2.48.1


