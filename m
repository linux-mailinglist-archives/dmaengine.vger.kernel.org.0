Return-Path: <dmaengine+bounces-9408-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH2HLJfwsmlBRAAAu9opvQ
	(envelope-from <dmaengine+bounces-9408-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:57:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A01E276295
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80CD9324BA91
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 16:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3A33FBEDA;
	Thu, 12 Mar 2026 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="JyXQNqo9"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021077.outbound.protection.outlook.com [52.101.125.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE533FE34A;
	Thu, 12 Mar 2026 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334253; cv=fail; b=Qj7msuonVHsc3DN5Be1OCIE+VFDV+iFG9FD0FCni4tlK9BmWThSaBm0MXQa2VQ/bKNylqF+EhqIil5xpwZttSyKZGMLZq1mGufweYY2srrsncK/4UFRnZm+St3lXIZb3lChrrN/r2NDHTYDjekGy4iOfr8xEpRsByER418LGYWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334253; c=relaxed/simple;
	bh=IKq3rY37jDd4epN4grBAvKpEx//zpQarCjj2rMJigsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gHS7YvtkxVRPN2Ehr1+tDo70DD4x0MyPL5Vm5fZGrZh3r5IWbOT435VT34a6lZiVI3uZo6WWsDyHLeD3YnF1AWt7eGq1oLiKEC/zwjbLXs6XTQ/Qirxbh4yITUNuagSMZKU7KjsyvMOdjWzWvlW8BGNyUe6pG842Hmq+HB5piV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=JyXQNqo9; arc=fail smtp.client-ip=52.101.125.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMWd6f499fssPKcbFNnuvFi5IvR6Xq/f/U6ldxa6Q605WSDYOVBvAF/ZQ0Bx/GD0ALJ2b18HLyRTcSZ5bxI0IgM9UNLuiyIrdCcNifwiUc+nSbep4I+mPdp5N/hBx11Mp9gvoQMmD7bffqf5RLyXgCK5ro4t+j5q5jq021DRnGTkQtTrnaP3wk9HSxDSqsckrigiWO3E8y/qv9XsHE/0snHoiLgOmd8aiccrYxv/3x9hjG0mMAqVrcvzAKdNov1zoSReWicofeSqB+X/APN3WKJppZjeNfkj55X/NhGaFjbAVWXXkHftb+7guHfKo58DjpiOLchyls/zqLVaeNpyQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTNy20acGrWygUYA1RMwUkNCnqvEspEkjJiEzmuytnQ=;
 b=fF3cVSwCqakfc8axT2IQDq3YZhUEouJEU/7edOefI/OEazfcrGYJGsbwAQfeOnJqxApPaT4qpDN1z53vaYQlzG1NzSITP8yjs53H2de7WuBN4Jp48vNVyEfR16WWln/f6tqdVHyUkc4YaOnp0dzwYIHNKpK58CKNcz7cLe97dog3coour7cWVgDoFfYez8iXtXJXmIDJCoCZ/SG8jjeMi2XW4Rltu+bMF0bCAzeOlv+5uDu9SmBUJpMyCm+QQqJESrqDx6LG6IlHbXMcq0ogKe2vwNHgKlWA3n1vJi4+66DWNRWquDxIxAtPOliIOzdXI8rpRW0qQW0BC459mNL5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTNy20acGrWygUYA1RMwUkNCnqvEspEkjJiEzmuytnQ=;
 b=JyXQNqo9ht5yHQK1M6smjBjABsJzLygbFvGHNlt7153LFssYmMlne4Of0dQHNGyymCQP7LLLZqQepl0uJo+yVDJB0OspBRpGkWhp9v5VNRwL074AHueweCu2EdEX7FgaBVLQHmAPoEe+VDFRcnnj6NH1hEvCt044Th6TT4r3DSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2018.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:50:21 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 16:50:21 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 13/15] dmaengine: dw-edma: Add auxiliary-bus frontend for exported eDMA
Date: Fri, 13 Mar 2026 01:50:03 +0900
Message-ID: <20260312165005.1148676-14-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312165005.1148676-1-den@valinux.co.jp>
References: <20260312165005.1148676-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0090.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8aca7c-43c3-42da-3f10-08de80577328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	H38pC1FQRmMCQ+yWOHJrPe/93KIqBnFO7F+8h/1s83sS7p+ALJTfjJxN7VZvza9NLfOt4olxzQ7yd72NMdNlx42Xw7OFxfNP4bQY9WClwqlwi4omKocm5xOeR4JVaMcnIXi3c3BvF34tzpAMEvl84nq8q0nZB6vph9Iom3HAs0xK8qDfLk7h0YYvg6jluFXQiBnOs4evOY+sykBMHWWtNRBPAkqAaadHm8VB48f6kyoiWXzGV3zW3qCxsUsmkYdQgNQ7ydeumkg1RCpgBsQIIybOgSt1JupQbc7hehzNoT6oZgOgX7Q5X3A2yuHVX+z79hoqv2EAZ0kPdv4tf2iZtMyuMwDgG40TZ61CWIzaxn2epL+plHXNiOWiDODYoXRtLg9x8H+cIaNro84p4qaJ1MecjVJ99NKiJW/ybRqH5am6ml/TJuSQhcvr3SsYiE45+VsZCyD5PbnNLbNgAMKT4vfEsy5heiIAg2qP17gLoQ4c4+WPni065pO+uuzxj2HwJlC7pUR5yjZTZskwv+I5eGGwJdIUdor6/gwfxoU073Vkr+bTp2GlHGDJ49fGjDWOK1IomOEpzJ9rzbubPxtfhdy3Z/eTNnLMFMXirxB+hlUbRiIgFa44cpIZxMxzoQMsa47P1hzKGQ/mqforDl+7id4A1GHS8orMdh7SUHIodGgiAgywLPeq84T475ntMBpQtGoR12R8U3xLtW3NSQpMGHrxiUxEpk7PbI7U+rCKTJmwyho0M+Jn2uyHqUI/kDrEd6BGS19CNDD9yYUf+XuLdw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5j3crC1MK5RpKs80E8Q1lvOB0XHlG5WPofiQkZsNTLUdVnaoWt4Ucx61SmT1?=
 =?us-ascii?Q?uG/Qc5/Nfc4RjuCi3xLBw9MHj77Zi/iqJsI+r27oK2ekR2Ve2fnkCQ3TbfaP?=
 =?us-ascii?Q?CNfhpr1mvbuDsOeRzvIkPFMxbkyX0fXcwv/XLxWOD4kSW2n9KzQ65OFJw4u2?=
 =?us-ascii?Q?9zP4rrfnDykA+OMIxqmmUU5/mSHJ6xe2gMofperaGiYgxOWrj01S2lYE2IKo?=
 =?us-ascii?Q?LzsEEFRPUgiQi6xdyGCz47h9XDsJiUWN4vwR4oF+KLwXvJtAUg2yDzb5mHPI?=
 =?us-ascii?Q?vj1XlersDZFb54/M0klW+641oS4vN7Bp9p7mAsOc45ONG2aVk/g+d1NtCkdF?=
 =?us-ascii?Q?PO2Qn/J/wJR/txZJfJ9ZqWqtQWOOaKJo4DkJLukT9BuxIDseKbrFw23/xyCp?=
 =?us-ascii?Q?Q6AWKFyxJ+tYar4FPRyPtOeIxiX2AnH/56E7yksXdlTjBbije8ZjSTIhf8XS?=
 =?us-ascii?Q?aJRvxTXDorswVdWpPuqhJNTJH71Op5qjjYkSA2Hr393PGqLYXmppewd37OND?=
 =?us-ascii?Q?xWGnpBUO5oCANk0YIDC9xoO8LQzbrVDmoaQHSUGkYWKLIASB4fFc9SJ6kMwe?=
 =?us-ascii?Q?ewNQGaUDFuJ4Z7uxS1zfg32K0OBhwetGxBWO5MyS1o4hOM/MH4UIzLFjUgf7?=
 =?us-ascii?Q?l97FRpyaVE3ERdKoA3tDWtlz4cM4Nn7ZRv1boJZKWIJ4Ee42HJWT1nHS/rIo?=
 =?us-ascii?Q?okJT4l5kX9aut/V8xiu1Mi7C0yBeWFCheOqS0RDySBHQVdsbcyJHbpD31qyD?=
 =?us-ascii?Q?aTrRYeW9UbY5VIoYDZOLMwSobmejKbsRj4gg5XXcIGGvU1ca/27Wz1ga584W?=
 =?us-ascii?Q?+8Sr2+hXthFGvZQrNTnyrWsd9J2Yar4e0hof2h56gREO0Wam7YBlh4iuieQn?=
 =?us-ascii?Q?csN22X04tx4qqIVbwIIHoPz91/vLsx9N3Pv+FIk2rEJDSV4Qztv6QFFG+FFK?=
 =?us-ascii?Q?9EaGWx8Xewb9HJl4V6ToQsMqTfEMorPc1j/hy3LS97+54qzEtOoC5BCidz4P?=
 =?us-ascii?Q?TMaoiCTYHqxiiZY+ZYkXBMKJPjTytbaSYBx+Uid9MLi0iVync71t4XNa7/CB?=
 =?us-ascii?Q?cxH9TeoifU9dyCVn3yhAArN7/ZnjrGafCUGyZHTx5sRvSu9i2QqjSAmfklsA?=
 =?us-ascii?Q?9ql16xPmC84dZLMQYGnF+k7/54Q1O3YOCJ0IxhDlEeVfWNKFvABot0zUFw0s?=
 =?us-ascii?Q?ZYTVRphAKmO4Rk3F0jn2Pe2Nao1Z57/bADd0BXvvC0gXQngwZNyLvyaVsfTw?=
 =?us-ascii?Q?KMJYavXmzipOvHXczV5CsWA8fuXDuyVzjo8kIuk++ovrZIQA4kY4gpibaYoq?=
 =?us-ascii?Q?ji4E1cL51QIsu0m85N6RF5vkylc2u4PN9s4wNJjS1ODVN0PsgFdfyLSJDpaW?=
 =?us-ascii?Q?vD0+68fHK/1zCQRSvkZoOC48Y5bY3qSW0b6IUk1uVPU6oixBa3p9235vlap+?=
 =?us-ascii?Q?Tof1okGOlo5G+Mr6CGG20zia6EBA2lMcviomVlrceVCJdRnch8PZeCXFrVoJ?=
 =?us-ascii?Q?M9eCeFE49bfweBzgUsjPBX6wLlQPfxuKmTzVXSoZcVanIhzf5GQnv0enCwIi?=
 =?us-ascii?Q?tB9E2xrUc0esAv927LL4tYXc8GN0fFd7XGzXeMvPa0RXJzt7WL7kDwebhGy/?=
 =?us-ascii?Q?BheqtBSkon0DCR+w+jTWC2PRTGptRs3DMUN0okFdb6KDRw6Or9RnU+fcqLWr?=
 =?us-ascii?Q?ECu8ZRifDQPQ9eGuZVccG9AbpcpqFQP8Q54g0PJJPifgo3Ae7t7P9WvmHCAX?=
 =?us-ascii?Q?pYEmeDbwUpzQ7JQfj6+liDX3UIAxMufPfv585JF/Jll9QgHreCA/?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8aca7c-43c3-42da-3f10-08de80577328
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:50:21.6116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FzO/Y12n8BCee3FiArMAAg9y7vxyWT2wQfkm0jlPbLuCThdDd+JaBFIASQEGbw0IfZrxDhH779pGp/WkdVzdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2018
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9408-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,lwn.net,linuxfoundation.org,kudzu.us,intel.com,gmail.com,tkos.co.il,baylibre.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid]
X-Rspamd-Queue-Id: 1A01E276295
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a small auxiliary-bus frontend that binds to the DMA child created
by ntb_hw_epf when a peer advertises exported DMA ABI v1.

The frontend reads the ABI header from the exported BAR slice, wires the
controller register window and per-channel descriptor windows into a
struct dw_edma_chip, and then calls into the common dw-edma core.

Use the parent PCI device as chip->dev so IRQ lookup and MSI message
composition continue to use the vectors owned by the NTB PCI function.
Default delegated channels to remote interrupt delivery.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/Kconfig       |  11 ++
 drivers/dma/dw-edma/Makefile      |   1 +
 drivers/dma/dw-edma/dw-edma-aux.c | 297 ++++++++++++++++++++++++++++++
 3 files changed, 309 insertions(+)
 create mode 100644 drivers/dma/dw-edma/dw-edma-aux.c

diff --git a/drivers/dma/dw-edma/Kconfig b/drivers/dma/dw-edma/Kconfig
index 2b6f2679508d..a31f6bd784c2 100644
--- a/drivers/dma/dw-edma/Kconfig
+++ b/drivers/dma/dw-edma/Kconfig
@@ -19,4 +19,15 @@ config DW_EDMA_PCIE
 	  eDMA controller and an endpoint PCIe device. This also serves
 	  as a reference design to whom desires to use this IP.
 
+config DW_EDMA_AUX
+	tristate "Synopsys DesignWare eDMA auxiliary-bus frontend"
+	depends on AUXILIARY_BUS
+	help
+	  Build a frontend for an endpoint-integrated Synopsys
+	  DesignWare eDMA controller discovered through an auxiliary
+	  device, such as the child created by ntb_hw_epf for an
+	  endpoint DMA engine exported through vNTB. The driver maps the
+	  exported control and descriptor windows and registers the
+	  remote engine with DMAEngine.
+
 endif # DW_EDMA
diff --git a/drivers/dma/dw-edma/Makefile b/drivers/dma/dw-edma/Makefile
index 83ab58f87760..2545ce4a1989 100644
--- a/drivers/dma/dw-edma/Makefile
+++ b/drivers/dma/dw-edma/Makefile
@@ -7,3 +7,4 @@ dw-edma-objs			:= dw-edma-core.o	\
 				   dw-edma-v0-core.o	\
 				   dw-hdma-v0-core.o $(dw-edma-y)
 obj-$(CONFIG_DW_EDMA_PCIE)	+= dw-edma-pcie.o
+obj-$(CONFIG_DW_EDMA_AUX)	+= dw-edma-aux.o
diff --git a/drivers/dma/dw-edma/dw-edma-aux.c b/drivers/dma/dw-edma/dw-edma-aux.c
new file mode 100644
index 000000000000..a7481fa289d0
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-aux.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Synopsys DesignWare eDMA auxiliary-bus frontend
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/device.h>
+#include <linux/dma/edma.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/pci-ep-dma.h>
+#include <linux/property.h>
+
+struct dw_edma_aux {
+	struct list_head node;
+	struct pci_dev *pdev;
+	struct dw_edma_chip chip;
+	void __iomem *bar_base;
+	void __iomem *ctrl_base;
+	u32 irq_base;
+};
+
+static DEFINE_MUTEX(dw_edma_aux_lock);
+static LIST_HEAD(dw_edma_aux_list);
+
+static struct dw_edma_aux *dw_edma_aux_find_by_pdev(struct pci_dev *pdev)
+{
+	struct dw_edma_aux *aux;
+
+	list_for_each_entry(aux, &dw_edma_aux_list, node)
+		if (aux->pdev == pdev)
+			return aux;
+
+	return NULL;
+}
+
+static int dw_edma_aux_register(struct dw_edma_aux *aux)
+{
+	int ret = 0;
+
+	mutex_lock(&dw_edma_aux_lock);
+	if (dw_edma_aux_find_by_pdev(aux->pdev))
+		ret = -EEXIST;
+	else
+		list_add_tail(&aux->node, &dw_edma_aux_list);
+	mutex_unlock(&dw_edma_aux_lock);
+
+	return ret;
+}
+
+static void dw_edma_aux_unregister(struct dw_edma_aux *aux)
+{
+	mutex_lock(&dw_edma_aux_lock);
+	if (!list_empty(&aux->node))
+		list_del_init(&aux->node);
+	mutex_unlock(&dw_edma_aux_lock);
+}
+
+static bool dw_edma_aux_region_valid(u32 dma_off, u32 dma_sz, u32 off, u32 sz)
+{
+	u32 rel;
+
+	if (off < dma_off || !sz)
+		return false;
+
+	rel = off - dma_off;
+	if (rel > dma_sz)
+		return false;
+
+	return sz <= dma_sz - rel;
+}
+
+static int dw_edma_aux_irq_vector(struct device *dev, unsigned int nr)
+{
+	struct dw_edma_aux *aux;
+	int irq = -ENODEV;
+
+	mutex_lock(&dw_edma_aux_lock);
+	aux = dw_edma_aux_find_by_pdev(to_pci_dev(dev));
+	if (aux)
+		irq = pci_irq_vector(aux->pdev, aux->irq_base + nr);
+	mutex_unlock(&dw_edma_aux_lock);
+
+	return irq;
+}
+
+static const struct dw_edma_plat_ops dw_edma_aux_plat_ops = {
+	.irq_vector = dw_edma_aux_irq_vector,
+};
+
+static int dw_edma_aux_probe(struct auxiliary_device *auxdev,
+			     const struct auxiliary_device_id *id)
+{
+	void __iomem *base, *ctrl_base = NULL, *reg_base = NULL;
+	struct device *dev = &auxdev->dev;
+	struct pci_dev *pdev = to_pci_dev(dev->parent);
+	struct pci_ep_dma_hdr_v1 hdr;
+	struct dw_edma_chip *chip;
+	struct dw_edma_aux *aux;
+	u32 dma_abi, dma_bar, dma_offset, dma_size;
+	u32 desc_bar, desc_offset, desc_size;
+	u32 ctrl_bar, ctrl_offset, ctrl_size;
+	u32 irq_base, irq_count, num_chans;
+	u16 hdr_size, total_size;
+	u32 hdr_irq_count;
+	unsigned int i;
+	int ret;
+
+	ret = device_property_read_u32(dev, "dma-abi", &dma_abi);
+	if (ret)
+		return ret;
+	if (dma_abi != PCI_EP_DMA_ABI_V1)
+		return -EINVAL;
+
+	ret = device_property_read_u32(dev, "dma-bar", &dma_bar);
+	if (ret)
+		return ret;
+	ret = device_property_read_u32(dev, "dma-offset", &dma_offset);
+	if (ret)
+		return ret;
+	ret = device_property_read_u32(dev, "dma-size", &dma_size);
+	if (ret)
+		return ret;
+	if (dma_bar > BAR_5 || !dma_size)
+		return -EINVAL;
+	if (dma_size < sizeof(hdr))
+		return -EINVAL;
+	ret = device_property_read_u32(dev, "dma-irq-base", &irq_base);
+	if (ret)
+		return ret;
+	ret = device_property_read_u32(dev, "dma-irq-count", &irq_count);
+	if (ret)
+		return ret;
+	if (!irq_count)
+		return -EINVAL;
+
+	base = pci_iomap_range(pdev, dma_bar, dma_offset, dma_size);
+	if (!base)
+		return -ENOMEM;
+
+	memcpy_fromio(&hdr, base, sizeof(hdr));
+	if (le32_to_cpu(hdr.magic) != PCI_EP_DMA_MAGIC) {
+		ret = -EINVAL;
+		goto err_iounmap;
+	}
+	if (le16_to_cpu(hdr.version) != 1) {
+		ret = -EINVAL;
+		goto err_iounmap;
+	}
+
+	hdr_size = le16_to_cpu(hdr.hdr_size);
+	total_size = le32_to_cpu(hdr.total_size);
+	hdr_irq_count = le32_to_cpu(hdr.irq_count);
+	if (hdr_size != sizeof(hdr) || total_size != dma_size ||
+	    hdr_irq_count != irq_count) {
+		ret = -EINVAL;
+		goto err_iounmap;
+	}
+
+	ctrl_bar = le32_to_cpu(hdr.ctrl_bar);
+	ctrl_offset = le32_to_cpu(hdr.ctrl_offset);
+	ctrl_size = le32_to_cpu(hdr.ctrl_size);
+	num_chans = le32_to_cpu(hdr.num_chans);
+	if (!num_chans || num_chans > PCI_EP_DMA_MAX_CHANS ||
+	    num_chans > irq_count) {
+		ret = -EINVAL;
+		goto err_iounmap;
+	}
+
+	if (!ctrl_size || ctrl_bar > BAR_5) {
+		ret = -EINVAL;
+		goto err_iounmap;
+	}
+
+	/*
+	 * The exported DMA window is only guaranteed to cover the locator and
+	 * descriptor subranges. The live eDMA register block may be advertised
+	 * through another BAR, or elsewhere in the same BAR, and must then be
+	 * mapped directly.
+	 */
+	if (ctrl_bar == dma_bar &&
+	    dw_edma_aux_region_valid(dma_offset, dma_size, ctrl_offset,
+				     ctrl_size)) {
+		ctrl_base = NULL;
+		reg_base = base + (ctrl_offset - dma_offset);
+	} else {
+		ctrl_base = pci_iomap_range(pdev, ctrl_bar, ctrl_offset,
+					    ctrl_size);
+		if (!ctrl_base) {
+			ret = -ENOMEM;
+			goto err_iounmap;
+		}
+		reg_base = ctrl_base;
+	}
+
+	for (i = 0; i < num_chans; i++) {
+		desc_bar = le32_to_cpu(hdr.chans[i].desc_bar);
+		desc_offset = le32_to_cpu(hdr.chans[i].desc_offset);
+		desc_size = le32_to_cpu(hdr.chans[i].desc_size);
+		if (desc_bar != dma_bar ||
+		    !dw_edma_aux_region_valid(dma_offset, dma_size, desc_offset,
+					 desc_size)) {
+			ret = -EINVAL;
+			goto err_ctrl_iounmap;
+		}
+	}
+
+	aux = devm_kzalloc(dev, sizeof(*aux), GFP_KERNEL);
+	if (!aux) {
+		ret = -ENOMEM;
+		goto err_ctrl_iounmap;
+	}
+
+	INIT_LIST_HEAD(&aux->node);
+	aux->pdev = pdev;
+	aux->bar_base = base;
+	aux->ctrl_base = ctrl_base;
+	aux->irq_base = irq_base;
+
+	ret = dw_edma_aux_register(aux);
+	if (ret)
+		goto err_ctrl_iounmap;
+
+	chip = &aux->chip;
+	chip->dev = dev->parent;
+	chip->nr_irqs = irq_count;
+	chip->ops = &dw_edma_aux_plat_ops;
+	chip->flags = 0;
+	chip->mf = EDMA_MF_EDMA_UNROLL;
+	chip->default_irq_mode = DW_EDMA_CH_IRQ_REMOTE;
+	chip->reg_base = reg_base;
+	chip->ll_wr_cnt = 0;
+	/*
+	 * ABI v1 exports READ channels only. @hdr->chans[] is defined as a dense
+	 * prefix of the remote hardware READ-channel space, ordered by remote
+	 * hardware READ-channel index starting at 0, so ll_region_rd[i] can be
+	 * consumed as local READ channel i.
+	 */
+	chip->ll_rd_cnt = num_chans;
+	for (i = 0; i < num_chans; i++) {
+		desc_offset = le32_to_cpu(hdr.chans[i].desc_offset);
+		desc_size = le32_to_cpu(hdr.chans[i].desc_size);
+		chip->ll_region_rd[i].vaddr.io = base + (desc_offset - dma_offset);
+		chip->ll_region_rd[i].paddr = le64_to_cpu(hdr.chans[i].desc_phys_addr);
+		chip->ll_region_rd[i].sz = desc_size;
+	}
+
+	dev_set_drvdata(dev, aux);
+	ret = dw_edma_probe(chip);
+	if (ret) {
+		dw_edma_aux_unregister(aux);
+		goto err_ctrl_iounmap;
+	}
+
+	return 0;
+
+err_ctrl_iounmap:
+	if (ctrl_base)
+		pci_iounmap(pdev, ctrl_base);
+err_iounmap:
+	pci_iounmap(pdev, base);
+	return ret;
+}
+
+static void dw_edma_aux_remove(struct auxiliary_device *auxdev)
+{
+	struct dw_edma_aux *aux = dev_get_drvdata(&auxdev->dev);
+
+	if (!aux)
+		return;
+
+	dw_edma_remove(&aux->chip);
+	dw_edma_aux_unregister(aux);
+	if (aux->ctrl_base)
+		pci_iounmap(aux->pdev, aux->ctrl_base);
+	pci_iounmap(aux->pdev, aux->bar_base);
+}
+
+static const struct auxiliary_device_id dw_edma_aux_ids[] = {
+	{ .name = "ntb_hw_epf.ep_dma_v1" },
+	{ }
+};
+MODULE_DEVICE_TABLE(auxiliary, dw_edma_aux_ids);
+
+static struct auxiliary_driver dw_edma_aux_driver = {
+	.name = "dw_edma_aux",
+	.probe = dw_edma_aux_probe,
+	.remove = dw_edma_aux_remove,
+	.id_table = dw_edma_aux_ids,
+};
+module_auxiliary_driver(dw_edma_aux_driver);
+
+MODULE_DESCRIPTION("Synopsys DesignWare eDMA auxiliary-bus frontend");
+MODULE_AUTHOR("Koichiro Den <den@valinux.co.jp>");
+MODULE_LICENSE("GPL");
-- 
2.51.0


