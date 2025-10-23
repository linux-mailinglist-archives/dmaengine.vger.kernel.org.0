Return-Path: <dmaengine+bounces-6939-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F72BFF891
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79299503F9B
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A422E9755;
	Thu, 23 Oct 2025 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="QdnMMO63"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010016.outbound.protection.outlook.com [52.101.229.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316952E6CB3;
	Thu, 23 Oct 2025 07:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203973; cv=fail; b=X9Vf2bPRWx66/YVnriLKqMb4/3k0/khPxHCoBjCntTZO8fOb4giyA2X3BJnGkbkgRxPbqcXlqTy8ID8SXpGOq8IIZGOpEITYwRazI+LEnKW82M5reDZN7sWN5cP6fiL4MqWEcJ1UHIg0WxLWtfnD/OXH/O0nB4npcXHIYtTI+5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203973; c=relaxed/simple;
	bh=AfSPc3yS9emtbnkNJoSAjd+6NNVAsQLDanUDh+E6FUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cv374rY7929RPUsNl6YLVOiQFwVxhevKUP//6D9HoiDgl1Om6lAvhYhfSY540LemPfsMrVwZUtP5MCIeRBZ/9bsHzTCCONmd3d2CbEZxw5nE9YKdQvwluWvlJYMXw304iNk9hFigzLijFhX2JevPj7dGODEsQ4H9ikgzgBR65q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QdnMMO63; arc=fail smtp.client-ip=52.101.229.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9nwU7ktcxD+yS7gGjB5H63lYMUTdGSOMFmx91Vg8iezNqRx1gLL7NvBo2tk5SFLmFuPNT/szjgXu2zKtgCMBA4T+pz+Q112PgGcUwMO6w/bCReyT8FnZ+BS7pBhmlmzCQ5X2hI+DteNYpg/9OE3z5LwMTaAgnQ7WXqPsCQQtSNxVeS8Yt2Q15jiJ4FOF0JsFT1J1xHTkgxAIJGc0Tup7l5CD2IHLWquIadodGVX88w6y6VxrA85cfTqEiwmIf0sMAT4TF38qX52uO06YammXC5sGTGBWXbLn4YbIw5725inHlTo/iGmLDItDOfBatj0Pn5RpSw0qnhcBZ/qDOjJMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gnenupYkY5PlWslXZOMojW4YoQk3SqrA0lesD6JlE0=;
 b=C6X05EA23qZ/+ckQKmkvHPY1sASvK0zAotAHPABBFqP5aTSaljL/+VnJKP2ZCBw7y4CN2JijXDnaodUwDt6aqMXtIudbXOpWB5OwDrXgq767qrMr74+KORdCfHWt+GfY9YJ8rtY1/P3BWD6htF1pTZBzcotut+SBh3SS0oLxiQgWF0TKOZE1YIU+pavioVZuRZWWLGBATedBLrqM8pf9g7cemgSpIrHubeSqS/ZPvUMis3UY3IrQlgAdB3n3t+DMFwcqHibDpPuyvjiqDno+BYCODCYaJwXQ0T4GqRs69CXeb1yu0cgfl/cNwDmGAcgobFm/+Vw0ixPsVVggBOE8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gnenupYkY5PlWslXZOMojW4YoQk3SqrA0lesD6JlE0=;
 b=QdnMMO63iJJxSu7Mub+EoVP7GdpThJ42RiZJSnPZ/EVPXn3ubb+W0AHWiRdVQZdT6W4kqm+L2FYgBFFBf28S1QkllKfCwA1nnB0rN3oA37m/H6wtoh7OONJjiA1lp/EeJpT2xuFM6hdKOPTsYRykYYK0yjW4LOeODVuMqcs5Pr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TY7P286MB5387.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:27 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:27 +0000
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
Subject: [RFC PATCH 04/25] PCI: endpoint: Add inbound mapping ops to EPC core
Date: Thu, 23 Oct 2025 16:18:55 +0900
Message-ID: <20251023071916.901355-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0058.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::7) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TY7P286MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f25273e-2ff6-45c9-3ca3-08de12047fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aPLRtKzeLZ5eG7Bq2vp/59lnVIJsX65nzoF4o05B1ksLV/OwFcCOaJ7bLtnk?=
 =?us-ascii?Q?pyXESO36r701nNBCBCVFvjYoBVwuvGPFS6/3Leg+PhcZQvlvujiAoorJKPkd?=
 =?us-ascii?Q?Fn+xl/ZczcDJVK7wNkmLrddZiD4QanqYEdC0pGgVexsmMqRwiAIhzu77EPMV?=
 =?us-ascii?Q?77tsVqhzqsvoWpbFTW9+32HeayMyaDrU3b3mw4Pj9hKXnpxcxc456NzuLOcd?=
 =?us-ascii?Q?mMpQDsDadQ6Z/0cJUWf282tCfwCSJHf5tg1IlfB/UUoDxEaQ4Nr4jHRClcbK?=
 =?us-ascii?Q?BqTZT/CY7sWC9gw4Ofu7s6b/7Qit9cCdai8AarU/MZav/91j+tdJxEQqv66d?=
 =?us-ascii?Q?7w6iKO/yM44AyVdnjXIzS2MUtM1eAzNGWAsTd0/QHzcdElQHi5iUBsa2tYV1?=
 =?us-ascii?Q?VKpCPMIXqs63t0Pf2bijb56gG1AK2I/jwEvDD18/WPS4AqaEhtU0cabpwhDO?=
 =?us-ascii?Q?nlcSUhvRJD3pd+z6Zzk3IQhEAFs5+otaiZmOYtlm1CgpSu0rlTrJMSKmdh1j?=
 =?us-ascii?Q?ls8c5bYME7dCnNrjAo4yjUwbh9mMtYG12Hpp2wa3b+8aW4fZQKUJF36SSrTG?=
 =?us-ascii?Q?KguWyp0L9Y+PRk3ZyBxQwe0oxVkmAE7MdB+/0eoIFaYh6aAsu360GwDKD8Ix?=
 =?us-ascii?Q?MG67IAhhGJztTW4S6X5cNLHbPc0Uam0Q6RHcxbC4/BvWdXiXnHJ7YCmhAX9W?=
 =?us-ascii?Q?/euYl9U2Wmx70BiWrTHD57kgShUWryb1lZQjKWNxvvHVkOyCgUbekEG2jfKJ?=
 =?us-ascii?Q?VFCWeWjTDM05eH5iS+Fh839IgytIlW4j/pyYxmMk7pGt5dpM3tGoASpK4l5Y?=
 =?us-ascii?Q?ZQoeBoAHLm8rUQkZSRswf1Nrb6lshmbQJNRIaI8UQY81UUMHvlZ/luj459iI?=
 =?us-ascii?Q?yTSjnYtsoRQpO0YM+p0BYik5dJNq0zwgh9Ix6cuL2i5840g4czzdtGCXH90z?=
 =?us-ascii?Q?4UJUq83hzsAw/NkwcQSPtS3ZwCGYmb08U8jOX1LweAsRf8gdwqN/bOe48x70?=
 =?us-ascii?Q?Oh8KCyxTuyJAvJC3Ayg8zik1RNVE8j3UuQtZ88cUYyjArbNOGms8Wvf32hXc?=
 =?us-ascii?Q?l6FiWTjpSOvKUY5yDaqkDQtBCJwkcBWc9VLiY4kFr6HOXr6HlpgaQgj/Cnyt?=
 =?us-ascii?Q?Q3AwHcUHReTNt9Tzu1XZuAU+fS/X95YAUoC61xjPA5oth7msBT5OrKQR5DvU?=
 =?us-ascii?Q?MMgUXjQVh7+mTGf5e8qT5gFyeUm/a2pNSOCknywLdp7GtqwygeQUBFAITAOl?=
 =?us-ascii?Q?k7pi2BT5vZbGfLiRUANkmrkQJiaz0I2h717FyVKJt9ar1YuyKhHXdnRYZCNZ?=
 =?us-ascii?Q?zNtyNmO8BPnn9awZlXB3YrS8+Pg+HMkctbtdzpqRfrkuijJqCuV4uM3fOi8P?=
 =?us-ascii?Q?jvhC1MaCwaF5MGhJeZEwFFhpbR5Edq6+iF4iGcpYrmU4tmNW7TEn7qMdDKQR?=
 =?us-ascii?Q?ib4LJSdXxoSKZSLz57mZMWxtuuT4Esxu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mKp5hUZAdY0d7nMNi8afQTF5J9b/cvfkYwWaVzOFYPwjw0btNNVcJ9Tvd2zK?=
 =?us-ascii?Q?yNeauJfBxY+yZxpv7UlwH+Bv0brEfbuSUfl82bdt19/8LC88V8CupMnMbDga?=
 =?us-ascii?Q?IX6Hoq5l2HCQKRTZfpg6z/8SMqwBEns6RYB5PTmY1aY7QSXgfLgrcDd8cwu9?=
 =?us-ascii?Q?PKNMNzyWV/2s7MK3CDHWwhYlYbLr3+wl5IMUtYLgZBbiJtIrLIv5NYsD29Gq?=
 =?us-ascii?Q?XkaAYKGPPg/Ggi48hCC19zSOIPRd4FzT7nU6eR1KwV/6591dAFJ+3X4cmSXe?=
 =?us-ascii?Q?rTqd1tSpVvg/SGDz4rZlwmdQGI8mJSEGUcS5d2W5h5LeG15srLku6Iw4kLry?=
 =?us-ascii?Q?zZUrI1kR9XER7ri9A0541iXkoneorX5KabyxHhUgiPMZAed7xohqCtBLM+QZ?=
 =?us-ascii?Q?uHn7hUAwanlcizMgtUe1dn3qtkjLljNCxHpa0fkrWGFKYcz3U1FpP8Bwz0y6?=
 =?us-ascii?Q?Za8u3Ak10xpDn6/935ERMJTAlTcbD08P2QHFn3xVXHaxGofiaLVNIOOeISoU?=
 =?us-ascii?Q?pFKarnm1dlv671JHZL7I/GNFihFWef4E833pk8Uqs8izrT0JplATwfIUgSTX?=
 =?us-ascii?Q?kQIPCz+eR5m4SXMiYOlevuvfFK5ko8FC8jm3nIs3wAzNP8XEDxhbaPSQYFw3?=
 =?us-ascii?Q?bJzqocboF14SFkEha4fxesxh7EDYnvlwQvxw46HMjdk6y5Lf3+aFnnptSxB9?=
 =?us-ascii?Q?KmsrMAnMY1Wj3B1L7+rmnqJVYkOKTQS8Yw0lXmQpuwkJsv3EIjZwzRoI+JPR?=
 =?us-ascii?Q?Y/r6daIjw6h0tSj70DxnE+ZKveP31hzkeliHfhyYpa1yzlAqVxLomFWqj8dX?=
 =?us-ascii?Q?3gQ0nGBASip3P0XuTlZ8iXN+Lgy08Q+5L9vZdTHEdOW0eK3HPlWcKRNVDxhI?=
 =?us-ascii?Q?SdZZFwf5NhzQTR/2A3pt5bMnRr6EBaK863lyuc153r1+++sSkmuWNkAg/hzZ?=
 =?us-ascii?Q?h0+Dz463PAL+S3Ivoudnvnplekoe5EkBBZVUdzNmnaaZhpDSZGdAm6e1x+kc?=
 =?us-ascii?Q?r0KE3WgR2FR2W4Ba2oN2qr+gc1OI3bo2Qsa3yz+D3KVcHUu/ZbEDyi2iYZ7M?=
 =?us-ascii?Q?HZ47uiFll5xtmzp01LnnLTM0H8ADqujz/GkTEUIpIB7FFwH5oS/NZ6qcM9gb?=
 =?us-ascii?Q?Rht9xuwaWsw+yxrlQCEnEXc8/hpB7OMsOnsoFvnhFfS4NTfF1aDnl+rT04eL?=
 =?us-ascii?Q?Lp8HCrBOboI/6F8LOTMks4VdxbimFSzMXK0Cb6GxNuM2QSofraGpUAeCvbp7?=
 =?us-ascii?Q?FTf22adRWaRN9hrtutM2u+TQwSjBGnBW7lD217U2FRngqoIEUYmpG9Q91CDe?=
 =?us-ascii?Q?ZnS39uLoovmfn9F+2Fq5KyH87g1oT0KikQ0W0HIdJNwPjRjX/389Db00Hawt?=
 =?us-ascii?Q?oOwrgLZ/WQzlNFWWJmB7ONj3j+S0nVQ2IgPOdXB3gkFL5QbxuuVvJQ14+lyW?=
 =?us-ascii?Q?aGMoM8MX48Cve1+u6paMNuaoFvL0l0gOjKQLlRwKH3vXL3d0OHtYYCnGUMMU?=
 =?us-ascii?Q?Hr/c7Rq2IgdaJmkb0aQN6+8K9k/+qkB57iQn3jCUAmBW0SRPvuQtOeMKcyVs?=
 =?us-ascii?Q?YpEnAQdDLVYtgHUj3OpcTiLpYe6IctbfolvhPJrVxAySy7maRKXowhezcoUF?=
 =?us-ascii?Q?8+2wO6/9ZP/YciTlCdzq3Fw=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f25273e-2ff6-45c9-3ca3-08de12047fe5
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:26.9585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqX7jw3Aa2Nio1bPD21cs89+RxQywIyhrsGP4A1h9xe9daXxk/AR9ngJNms3W0PhKb0J71GFIHbP9Fmi6lz0Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5387

Add new EPC ops map_inbound() and unmap_inbound() for mapping a subrange
of a BAR into CPU space. These will be implemented by controller drivers
such as DesignWare.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-epc-core.c | 44 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             | 11 ++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index ca7f19cc973a..825109e54ba9 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -444,6 +444,50 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 }
 EXPORT_SYMBOL_GPL(pci_epc_map_addr);
 
+/**
+ * pci_epc_map_inbound() - map a BAR subrange to the local CPU address
+ * @epc: the EPC device on which BAR has to be configured
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
+ * @epf_bar: the struct epf_bar that contains the BAR information
+ * @offset: byte offset from the BAR base selected by the host
+ *
+ * Invoke to configure the BAR of the endpoint device and map a subrange
+ * selected by @offset to a CPU address.
+ *
+ * Returns 0 on success, -EOPNOTSUPP if unsupported, or a negative errno.
+ */
+int pci_epc_map_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			struct pci_epf_bar *epf_bar, u64 offset)
+{
+	if (!epc || !epc->ops || !epc->ops->map_inbound)
+		return -EOPNOTSUPP;
+
+	return epc->ops->map_inbound(epc, func_no, vfunc_no, epf_bar, offset);
+}
+EXPORT_SYMBOL_GPL(pci_epc_map_inbound);
+
+/**
+ * pci_epc_unmap_inbound() - unmap a previously mapped BAR subrange
+ * @epc: the EPC device on which the inbound mapping was programmed
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
+ * @epf_bar: the struct epf_bar used when the mapping was created
+ * @offset: byte offset from the BAR base that was mapped
+ *
+ * Invoke to remove a BAR subrange mapping created by pci_epc_map_inbound().
+ * If the controller has no support, this call is a no-op.
+ */
+void pci_epc_unmap_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			   struct pci_epf_bar *epf_bar, u64 offset)
+{
+	if (!epc || !epc->ops || !epc->ops->unmap_inbound)
+		return;
+
+	epc->ops->unmap_inbound(epc, func_no, vfunc_no, epf_bar, offset);
+}
+EXPORT_SYMBOL_GPL(pci_epc_unmap_inbound);
+
 /**
  * pci_epc_mem_map() - allocate and map a PCI address to a CPU address
  * @epc: the EPC device on which the CPU address is to be allocated and mapped
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 4286bfdbfdfa..a5fb91cc2982 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -71,6 +71,8 @@ struct pci_epc_map {
  *		region
  * @map_addr: ops to map CPU address to PCI address
  * @unmap_addr: ops to unmap CPU address and PCI address
+ * @map_inbound: ops to map a subrange inside a BAR to CPU address.
+ * @unmap_inbound: ops to unmap a subrange inside a BAR and CPU address.
  * @set_msi: ops to set the requested number of MSI interrupts in the MSI
  *	     capability register
  * @get_msi: ops to get the number of MSI interrupts allocated by the RC from
@@ -99,6 +101,10 @@ struct pci_epc_ops {
 			    phys_addr_t addr, u64 pci_addr, size_t size);
 	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			      phys_addr_t addr);
+	int	(*map_inbound)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			       struct pci_epf_bar *epf_bar, u64 offset);
+	void	(*unmap_inbound)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				 struct pci_epf_bar *epf_bar, u64 offset);
 	int	(*set_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			   u8 nr_irqs);
 	int	(*get_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
@@ -286,6 +292,11 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		     u64 pci_addr, size_t size);
 void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			phys_addr_t phys_addr);
+
+int pci_epc_map_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			struct pci_epf_bar *epf_bar, u64 offset);
+void pci_epc_unmap_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			   struct pci_epf_bar *epf_bar, u64 offset);
 int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 nr_irqs);
 int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u16 nr_irqs,
-- 
2.48.1


