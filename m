Return-Path: <dmaengine+bounces-7794-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BE9CC961A
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 20:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAB163042182
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 19:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CB22D24A0;
	Wed, 17 Dec 2025 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="O3yGNi/V"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011024.outbound.protection.outlook.com [52.101.125.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0681A26CE3F;
	Wed, 17 Dec 2025 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765998825; cv=fail; b=ZLgz3x+zZV1Sn5Fv0n8rvwbtHLZ5SDHqUqDcao0L1nTMaZLUXAAKXqabkDOZLpdQOR5kSKDue1SRU8umkNTy3owNMubphAMU8wwxs2WnLuTmaCTFKpL56WQs/WwveeJCm+Wwycl7tnsmayqqUbHn3wrLPtQMvH1wnyFLu2/4uPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765998825; c=relaxed/simple;
	bh=zBYWYJYvS+Kv+kYvItQR+pQ2Nq8qm+CKr5UOtU5i9Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cvBDU2s4D1ptHBkWvq/6JaHdewBA7ymm8OzOEYdRBk88Sk336fpydKw/j01BJ1mahvQOeiFuesoTIvtLvvnExYOS+WL3ILrG3qzv3NUvRloHTES7dexhDClsAHDKs5AKkl+BX/EjYUCPKsyfMl6RCikajuAGPuxOJ5wBj38qJSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=O3yGNi/V; arc=fail smtp.client-ip=52.101.125.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from OS9P286MB4633.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fc::12)
 by OS9P286MB4253.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Wed, 17 Dec
 2025 18:58:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNDVgkkTVXDcOdC81RwNJDyZV67sxc9f19Hl8lW7C84cO37K8uPclRbaADpQRNjbT3mJUldgScfOqL+pzOP26/YWnqUprXRFlSXXdQXOpeiASIJjLj+rCUPoEQsRZpS+aJmmqOPpqSIxSlB4FjnOX40Saxe3yf3MJay05x6xiMUtRLLRPxE6tXpTsphBLrLwhyIsLJ3+pCp6Ypk0steZE08qbAkr6R4rhIO0ps1PjH64dW5Lp4kBRNfM3M25j+3TE6tYuTeDj7YotQ7uLyyS2v5MSURvQ4XJ8PcJS9V2sfuYGfPYJdbQoj+NQEY4nm15X58L9u5oeDgIq/g0Mpr/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tg0IjAjKuPqKUYfu402JjSwcRuXZ0WNpRg8vBf5Vtqc=;
 b=JBlyyir6HoNZNi81EP0gaK0FBmM8RW8qNcHxvEr6KySL/fCsv7ToZJwD0NQdDKTjeVGrdt3A8iTNUC2B6K4LAF8Ab0UMIJvyFG7VcTDmFhLVETtsuKTVO4uyCl6ExnTXyVCBcoMVe/xXBc+YD2g0zUhFbRgGyQP/Ts7EoxqGp2g9P6/ePtWmiZWcAodATS+0kFVb0c2zsp/ehfJDiVN3Ogi2vhhHrf7P2xgwf5BWqG6YpWDXsrcZiMoAycKMxzujgnQHuDljLiE0nkf5332c7EENdA7w4CpU5pHOGnMF+x8UqVfdmBTXF64EqFrsSzAzJBwh/3w/H71fXPC3CbvQ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tg0IjAjKuPqKUYfu402JjSwcRuXZ0WNpRg8vBf5Vtqc=;
 b=O3yGNi/Vh/OMQe7e4/12CV1uWxEo50SMErkFc5YJ4lTYbnSzmDfFjv8WAa2vn3Bu7mAdF1UtF3Yz6F5muo8knNNaiNUVgmymHDk3lv3LJ7XIhv+aVaW5gMCoPNkSfrGqGnaGIXncV9l4/DKsxs92vB4EqWyWnarY0o8aZgbGMho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4633.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:19 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:19 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	utkarsh02t@gmail.com,
	jbrunet@baylibre.com,
	dlemoal@kernel.org,
	arnd@arndb.de,
	elfring@users.sourceforge.net,
	den@valinux.co.jp
Subject: [RFC PATCH v3 07/35] PCI: endpoint: pci-epf-vntb: Hint subrange mapping preference to EPC driver
Date: Thu, 18 Dec 2025 00:15:41 +0900
Message-ID: <20251217151609.3162665-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0128.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::17) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	TYWP286MB2697:EE_|OS9P286MB4633:EE_|OS9P286MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d0a198-4c89-47a4-182c-08de3d7f3b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?geLivJ1NKFKH9s083FKrp7Owcr+VHW9RSoKQaVP3qSXsxovutP3aECbhfQa+?=
 =?us-ascii?Q?e9NTq9kYTVhvPuQTctvWvXsyMaAaqna19kM6VRnTRU5eqGs7r+98mQS5P1Hn?=
 =?us-ascii?Q?ittaSqhTN/qT/1zDhsaUwSpzXKFPnQHUE+FvcwadYp9r0Za0fdLyaLFy+mjA?=
 =?us-ascii?Q?I9XVXAcEvHgY/Td6M/Yenryp9G3mOHL/rtHv1C2oy3omUWxJFJv1KE4pGGTq?=
 =?us-ascii?Q?3YE8CkA3ROkIjsvhEEkJEdC+8nemk8c5dPxXlRORT8NL9eEdmQiPboo792+s?=
 =?us-ascii?Q?2s+nmvTdrIzkxvQacrf4DZx1EpFlJFyr26p9hFCG1xMRXw0QohtrJllctW/c?=
 =?us-ascii?Q?ZNbNVhSP+VtAgfqAmcALw5fc7/QNjvA7ruqDkdUGWoxhT3+/Eiki9twHptsW?=
 =?us-ascii?Q?I3sDCpgx0ylLx0n27Ue6/8+0Z2D0dDV65c/qy4Yggqghnc7Wdc5Yh3kadFBu?=
 =?us-ascii?Q?8TAxTU7A89pdcnPoWshYGVG0WdJMNke2WgkfeIV2yy1TuzGxbSDJQBEfPk/Q?=
 =?us-ascii?Q?4a+E9LOUqiuJQDTQHRKVbCoGABNZ6xUEZlpyv17mBVSYbUrm4BNCoXXkUnEE?=
 =?us-ascii?Q?p3vqcLrzDCNbDf/LP1JYCbF2MWqNs9xU78UDVijstxDwnrcwyzC78jQ7O/1v?=
 =?us-ascii?Q?e1g++ydr9YuBBO1Hz0NtER+Wm4ORAhdofWFxMn91Ajdox0cAerijvRkLZe90?=
 =?us-ascii?Q?AGurwG463YE1vHKgjQoOx/aTVcIeOwTKOz0FwNv6QZZcbGcjCTgfT9fnzxVQ?=
 =?us-ascii?Q?qYCgFlLHNdXp5nblL+YXm+SuVHd4PI05RV1ur8YNWUM+muLAZWFT2FJAXYVJ?=
 =?us-ascii?Q?DHQjHFKu6QN9kuOnogKGZFnWj2SFvLQsWacDxiiW+biMbjOPbB4uzc32RIYk?=
 =?us-ascii?Q?epengJHxbT4Uz8Bw0Kjc6KIp/2X/kKggHJz/smrAZ5dr8bBtduhzgGxN6mhI?=
 =?us-ascii?Q?wd6dz0hQzSSaL73x5+oSUHgB7zlKqK0TvYGU2OeKKFWcsovOSFt989EMUZyQ?=
 =?us-ascii?Q?OcwbPTCJfkhd+MmQsp5MnzQ/IEuubjyZEcCJlSB5YTLUqdlBhE6j9thV7+fX?=
 =?us-ascii?Q?QSpdONdWO+lxgDOaXF1qkhLxkG1WNs+DRaC7bqhxZMt5yj21wVj/UHksXq+7?=
 =?us-ascii?Q?VAfpJ6mqKDjj3fZNfhN8FjT/MaPLNUHemPMeCBC+GmbmTSawdEwe98Ljx/uY?=
 =?us-ascii?Q?PGYAxJQmYaYrUM1SjQMzAT7LApizcJaezMckTu0PJ9e7t121/DL1u9+EsGes?=
 =?us-ascii?Q?5i+QIl5Mz53P1/QiSlbQibFxJemKvZ9mc3KgtDkzVDiDsx+zg+WxOzNpHviz?=
 =?us-ascii?Q?fI06Vb0hPW4aKQValpCDHcpkmp6ROvJamwCdHUgRxDBMx6a9uNRfAIw3Xx6G?=
 =?us-ascii?Q?5WFoSp12+cvXJJcslGQ0Sqn0ryABhNJsPkq8F/liPLiaH+2sNNFQA/3xyet0?=
 =?us-ascii?Q?4V15SWIozKD4MhNkqEednfoFWwlYrXiy?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?YDDzvBVoE1S0krbiSxW4LJYAlpeMHUTnhnhitV6H1M7gM7zdbW5ajmFCosb/?=
 =?us-ascii?Q?RpjtcnmFdUJUNs0UmU6Hei3yl1sqdgkMALgLUBTIax5VHZN2sNZ/A/9t6vK+?=
 =?us-ascii?Q?GvY/JAelSq1DzogKOXTjnEKtjUjXrQtT4YNq8+wwDTouIZ6xPXAMx4lvs0hc?=
 =?us-ascii?Q?X3nagf9YHGPaow8tui5I8+xpisSmyj2qLaYLUWF8haLgT0NwA+NmRcwWO+uH?=
 =?us-ascii?Q?EvMpO7fnMem0ew6NmxbRKWoe+SLwrPN/h4hLKd6Vq4LQi5dRb9mlxmy7jmV2?=
 =?us-ascii?Q?oYox/5LD8Wl3zuttx3j8FApch/vdtqSYQ/BujVGFOBVhqEeWsg6fm+e3RtRI?=
 =?us-ascii?Q?t3KDB2qoQ9mtzFhY9iipoJaZAeMcU01Dv5LWHLPMjZ+oY5rhFPsT4l8GxegN?=
 =?us-ascii?Q?+7BCzs5Y88gptT2AWpYLV8hdSl4kE5abbR4Dhol146GcwYgdVSxFTJ9My6Ap?=
 =?us-ascii?Q?H0MLV8ABKBe9WH4ilxPsEu3VFTKsUyzuslWdmYPOjlSwx96Z4PZ3n6CXTEQy?=
 =?us-ascii?Q?Mi4FLatyp2HgI2OtCz3x8NiquZb9QDxtbIU/qxQOTkbcyyp8WHEZi8gTyN/J?=
 =?us-ascii?Q?dMOqimhj+TyaJbabX1rgKOQI9EDeZ9AsuT9Tr1mDti/JKmEN1EDlRrkzpmzq?=
 =?us-ascii?Q?86KIhVX7/g4lIRTLuBXMOm8h4r6L6z/EmUy4d82JA/MjssVp+qtj9NcyVsCM?=
 =?us-ascii?Q?Kytu0d5kgLDXJWRjmD9Tdh01stZZuE4LQakOzZtiWtrUBd4ev5KIY78jysea?=
 =?us-ascii?Q?i/n5HJT7x4AH8Flro34BdAa1TUhdb85AjioAXVCBQNGrPhI7HaAjCiWMXu3J?=
 =?us-ascii?Q?3xfmlF++VQzpRszrDsWd/E6T9T/mC1YFRBv6codSDe97rtUixkLlk3LBx3p8?=
 =?us-ascii?Q?55Madf9kVaguuSZgASpG8hUwSeDciXBg/sVpqoIQsz67TEp1Ci4+E+PCVddN?=
 =?us-ascii?Q?r6ITZum1aJs9KxsJGPJDIC2jkcwx7okn6lseWmoWAHMsdYDF5famXDO/rBah?=
 =?us-ascii?Q?mVf8/mGDvZuh3scllYiL1Lauk8OzPQOhZ/DdiOAVYfhiY+A+WOk5Q1l9/IeK?=
 =?us-ascii?Q?I0Qa2kU+mybG9ng7x+OEgzlFRfjz7nBQWqMykl0IHX33NotsuSRFw2VNSQVI?=
 =?us-ascii?Q?noqmlhhnHqM4E2uH8f3aU1GmWEWarM0773qOEqQ4AsOjKxfSk9sqfkcmHtNW?=
 =?us-ascii?Q?UJoakOP9f8dFygYC6UWFAWLtRrrOG/T0Eekc8qh1FkWW5xTIXEODAuF7ECnt?=
 =?us-ascii?Q?VdH5hkjtQzk/uDVJ5/45xh9HxWvG5jSrUj5Tb1Htf8GYC/0t9sNQP709AM8Z?=
 =?us-ascii?Q?oJuZgaOSO+YW71g2mYBv9aTfTE5SsjtYWCHdjw+Rt0IIcKTtwkqEcOgnRlyv?=
 =?us-ascii?Q?eMw2JquqIUv6fRIED5Hn9KHA6CZwixln1YMWewBdlBuGiJ4CPq/Z7bz2auMv?=
 =?us-ascii?Q?naNF6FrMtobOWfsWNT+kKj1c7k3PplIvtfonsTnsEFFSXg7bo4C/QCj0R14S?=
 =?us-ascii?Q?O/C5jVLRKjguR6dfiBuRUi6oului3tywzGv94gFg5SGkZGS5Bn+TQw0AzWTz?=
 =?us-ascii?Q?EQDIbjc7u4uk810M65LROtFJfLDrI6Tj2ypiL0cuVMRCRu8fGCXS7fAXNPNe?=
 =?us-ascii?Q?rRoJA0MmPH39ssW3qxlljrg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d0a198-4c89-47a4-182c-08de3d7f3b20
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:19.5985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPSysmBAgdngsRbMoQ4QKdFE4RonmWAMMt7n8Q3uGO4qTonnt4dFfXE4iUREzw2FvRddPTYGYwXb+DqypQkMdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4633
X-OriginatorOrg: valinux.co.jp

Now that pci_epc_set_bar supports subrange mapping, give a hint about
that when calling pci_epc_set_bar(). For example, DW EPC chooses Address
Match Mode IB iATU mapping when 'use_submap' is set to true.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 337995e2f3ce..23bbcfd20c3b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -731,6 +731,12 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 				PCI_BASE_ADDRESS_MEM_TYPE_64 :
 				PCI_BASE_ADDRESS_MEM_TYPE_32;
 
+		/* express preference for subrange mapping */
+		ntb->epf->bar[barno].use_submap = true;
+		ntb->epf->bar[barno].num_submap = 0;
+		if (WARN_ON(ntb->epf->bar[barno].submap))
+			dev_warn(dev, "BAR%u submap is not NULL\n", barno);
+
 		ret = pci_epc_set_bar(ntb->epf->epc,
 				      ntb->epf->func_no,
 				      ntb->epf->vfunc_no,
@@ -1391,6 +1397,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	enum pci_barno barno;
 	int ret;
 	struct device *dev;
+	unsigned int sb;
 
 	dev = &ntb->ntb.dev;
 	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
@@ -1399,7 +1406,28 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	epf_bar->barno = barno;
 	epf_bar->size = size;
 
-	ret = pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
+	/* express preference for subrange mapping */
+	epf_bar->use_submap = true;
+	for (sb = 0; sb < epf_bar->num_submap; sb++) {
+		if (epf_bar->submap[sb].offset == offset) {
+			dev_warn(dev, "offset 0x%llx is already mapped\n",
+				 offset);
+			return -EBUSY;
+		}
+	}
+	epf_bar->num_submap++;
+	epf_bar->submap = devm_krealloc_array(
+				&ntb->epf->dev, epf_bar->submap,
+				epf_bar->num_submap, sizeof(*epf_bar->submap),
+				GFP_KERNEL);
+	if (!epf_bar->submap)
+		return -ENOMEM;
+	epf_bar->submap[sb].phys_addr = addr;
+	epf_bar->submap[sb].size = size;
+	epf_bar->submap[sb].offset = offset;
+
+	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+			      ntb->epf->vfunc_no, epf_bar);
 	if (ret) {
 		dev_err(dev, "failure set mw trans\n");
 		return ret;
-- 
2.51.0


