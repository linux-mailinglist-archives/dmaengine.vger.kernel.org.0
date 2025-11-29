Return-Path: <dmaengine+bounces-7398-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC93C9427D
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351CA3AA591
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749E3312829;
	Sat, 29 Nov 2025 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="SUx4WvJA"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011006.outbound.protection.outlook.com [52.101.125.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA63431197E;
	Sat, 29 Nov 2025 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432279; cv=fail; b=VGDLZjOUDtWSiejMpDwWeWf6evtM2dQaH78G5s6z3l4DzLr0A/TH/zvLGpWKpjPTWf1OZK+imZ3Zr0phQgVk2qGopsWsTlpmZm78pwpscvZ19dl/OVrSUw1dRPIrWR/XsuQeauBa78tvXQqwjrxAiZTD6zuR/u8UgUBlrsxbQqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432279; c=relaxed/simple;
	bh=xt+0qSxQBDmG8df+mvB5mUpG1MpkA4C+2usBg21Wuos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ON3AtoYYr+vfEQuYWiiS6QsbZHONPFkT6NS8tfXliCioJEw18BNwqzQTgS0ZVGs5ZojKLn+wYRPH9nWHW8TS1itv7zjel6JPyBkeREkUqSgAIGOtswu9bcVKu8EsHG9abb6XehPYmJZbqFwNX3mti46mTnxA/zaES53zXRR0scc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SUx4WvJA; arc=fail smtp.client-ip=52.101.125.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qnq6Tgww06qt8kC6XxLY6iatDgtQprSwuxqevVO+9ak+QryajLQF6CI6KXHI5EQ8A4543bgnMJXA8+2woLFG+wVaJ8iajtG9Xqej3HTKf8OqQ4NK1STo0O5dGlXYceH8O5XNYUP3Myn8AyNGdihzv+JDmZGWHwY3skCIhjpNUysJvlYlN1OqQ7Ia61uVuw+EFpymSPXKbHmfFOuDmdTe9cl04ybRL8+wRp29eHgS1GGMrcJqg+EHpazYJFW+HjDIx/LQacg34m+4lAmt3Q2r4e6hk+voRPIt07LAOURnCZBrUklvyR4BdoIhHkbfXdUIal09bAEOcI9MDR3p2V0Xlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgShy1qhML3JwyEhuyxCgAkQgAuLp7cGTdOEZ7oONKs=;
 b=aGnOwUQuJjYTYohzkYzes3rrxtiH8HcsFzv8QZeFs+aHbGs4krAdgL9bFB5lMCTXBLyl+stzKpbwzxmp62UtIoF2zPBPDF5vw6uwbtuob7rC2XAaJCFj89GaUb2fINmxUB8e6gjDTQ3ZKuD5NxpERdH4WgtEXarps6clJbw80hL3XPvWOjZ+TfW1xeo3cs2+oj2caCAA3YABb9PCDAHxT7V1pr64G1oJUd48aKiZlY7jn0iRqeMjfQLYgLgmVMg/R5dkfBrzhSJtalxsWXpJJwV9lWHnLR+H065t7w14q+zubO7Goxw4fE/HWaoRB/Z4+CvmvOny2IXQ07WOwphcwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgShy1qhML3JwyEhuyxCgAkQgAuLp7cGTdOEZ7oONKs=;
 b=SUx4WvJAqeD/2q/35wn4lXpYRh/+u7XutRVqgUD6u8i+uIg5i4sX3P00unhkxuxod/OcPLja/MKnw38FhEjaUiI89kT+Ut9CttXMBniWuzhw/mdn7cTjOWaDNosXSTPp7PjLhD0eRv53TqU2FK74JKx3VmKVUlzyTutdNZ02SLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2050.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:30 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:30 +0000
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
Subject: [RFC PATCH v2 12/27] damengine: dw-edma: Fix MSI data values for multi-vector IMWr interrupts
Date: Sun, 30 Nov 2025 01:03:50 +0900
Message-ID: <20251129160405.2568284-13-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0062.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::17) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2050:EE_
X-MS-Office365-Filtering-Correlation-Id: 70602f15-a2bc-4ba0-9699-08de2f60fae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kEbzfED5Rc+gb9ADd/9h4LOaSMHmcZU19WdbWmNew8qCc/eLTmaLECx1nHcj?=
 =?us-ascii?Q?cJ+W1QERvfTaE3Ic6OWWOYMZQ8JI+RgvoorTbA7dm0ZsnnR1MQ3Cx+VeTzNP?=
 =?us-ascii?Q?7M+Xx2cma249kzgzpKVFHnJqAE+y+PrlgN9VfuWKPYbhNOpROH4Yi1fWbl0G?=
 =?us-ascii?Q?UZ8ZIi2qbyHOC05zQk7rNrhtf8RdpJa2eXvUT9aNGm1UfHnWkA7SAghiv+7q?=
 =?us-ascii?Q?F1Pwu57u9yTmWtTklCriV+aOcnglvkzZr3lYUx6RSgWc/AUxHNDA0t90gMmc?=
 =?us-ascii?Q?Ohsv8DyPtXmP1sqFvTWhKvN00dz6juPkTP0kAa4ffFk8Tm6NXqr1P6eUXPV9?=
 =?us-ascii?Q?/a4/KyBZygxEbCwF3hHAfJv4bQ8/I1ZLYUJQhOpl2dZbBRXKdIkc0FDy819t?=
 =?us-ascii?Q?DrE+4aE4EGoqEavytewU8Xd9U3bMVDZOTBbwRc2CofAoqKO3yJ6MOK8fUEbn?=
 =?us-ascii?Q?Sy5YkWVwKrnVaCqLEasTR7hoxcxcFiI6/myrItdiHpvUE2qzMuw5LOAgybye?=
 =?us-ascii?Q?KMEszzmPrIEo8r1Zu5DIGcOC3ISm96uUFBbZWtEjv5FfHiiOTwpsrpI8rJiw?=
 =?us-ascii?Q?ydfzgzETyWW74P4kpn1zsdcth4s0v/v4pTIV+h4jXiEs/RESowQcUP2UTEHQ?=
 =?us-ascii?Q?oBCdS9rSqPynYZOzub+SDU7KamPv5JjyDWfrW1K0BtATkMnBrSTB4I/mKSpB?=
 =?us-ascii?Q?RSd/KRfHFsOExrcvi78Q66kqX64RARPutQIZcKgReDIwp6reD711/XOs0UG5?=
 =?us-ascii?Q?L66CbDCURpI3TW4JJxSIQhdQmQlvE279WRvvAczKbj2g23fCZi0mVYOxfoAh?=
 =?us-ascii?Q?L4w0x4QDbnfVzt1lgMAVhJFw2GEuQQZJY9zTBGbZXtrqoIOxdCQfowIqRnNC?=
 =?us-ascii?Q?E0ccGpfHRpVAr/bIV819MVsthG0y921XvI3tWoUUQ8XcszW+ey7/YzQ9GajE?=
 =?us-ascii?Q?8nypiGG1BIvR7MLg2WHt+8Rjw1mK4tiT3SQ65nZ5XoHiqlN/BEWFomrsBb3w?=
 =?us-ascii?Q?HGnee5F7Ch4NZcK4XVVzOLs20NnEP38PxmMd8PaI09e6tUvw+7HwFT04uJ5J?=
 =?us-ascii?Q?M2R/NW84g3IbWBzFf2zsOU4JuNDjFNc/rmnk8MSfGwRRSJGax8NZPXMhmCaf?=
 =?us-ascii?Q?TxDTs+nSDY/L4zxbWTvC6rd6rFiGe1HUIvIfL4ENQeekHQOdHF5oA72DptFE?=
 =?us-ascii?Q?1ErVofpqFze0R1FFJP1887ZywwpuE7zowXkPacT3YFR2BuXsbvjkXPqKtGgt?=
 =?us-ascii?Q?AKlmJD5sNagxQlkJZQzs3S0lYJJmYGwIy0pJSRyU6aG9PZByxgkHzuKvtCoi?=
 =?us-ascii?Q?FYw42DexBw067iLPgm+DQgjGL5rrtbcjgZEfEuJZZuQuiFgcbyQLFru1/6H7?=
 =?us-ascii?Q?2OO/kWNjvB5zNfBkUixYeYol0fCmP4Ka7KbaaQxzoJhtkNkyItx6IKXnPXwI?=
 =?us-ascii?Q?dnMIpWp11uBTUe/g1UU6BGjYQHMEYlM0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d0jCoObcVyKsGrzEceFDZno7z4HuYEMklNNatYCHLZvfcGpPj9SvfZp1Poko?=
 =?us-ascii?Q?KqJNG1YLuFjlnnag+20UhIr+CgjQJ4Kt6C0j+KZ8BtCpKX+YG9mTA8bGFEqC?=
 =?us-ascii?Q?kKC4z8dsP7W62h/gqReO95/txQDVaqGopix1EK/IchMuboenetLsL4ngASs1?=
 =?us-ascii?Q?9r66ASny+rRCy4+8pEpqFMiPQLFtH9S7omLLaGlPp7UZQdfw7DcI3DGqXYta?=
 =?us-ascii?Q?V2ULkAOzbzzY7vfmI7rMPLoyrk3KSEc01+q4vSfLm0vKBBRWCPUuNHKhB12a?=
 =?us-ascii?Q?tPSM6Hl/qpR4pBhB90M5LbGggA7hMh86Q6hSnu5nvmFRvyRU9wWo7L9MGnbf?=
 =?us-ascii?Q?2Lc6HelEK5RBcSSeshndthLfMUJUfmsP59jwU6arFcnt1I/jyUN77zwITTKp?=
 =?us-ascii?Q?M2cIucFkPT2M8tHBwXiygLVtch+0xqBFF2/1twNNXfKQUJai7H/wmGt1mlXG?=
 =?us-ascii?Q?n8FIKkby7bhF7J/C0yPUryZkL1xSOjgJjXeRsG4O9uKTRsunaUbLnLnuC1JV?=
 =?us-ascii?Q?6xVSvNXTk+OnnInnhm/u/TnizKuidQZbnpLgdxpyeU3EdYB7x+6aYNX3ouT9?=
 =?us-ascii?Q?yX91U7wp5l7WisDaNYuO4kP0ugMCByL7+QOb+4sMeQ9w5nQDBnAUMWGl2ukQ?=
 =?us-ascii?Q?2ICrhBS/bSX1ikTM0k7Z+a+MHpmZg79stxDHTVBGOWKoWbCiIJj2o4VkmOI/?=
 =?us-ascii?Q?EaLpgv9YiIczL04AigUlY1W++yked8AE1A45e5i51D2dpJaLNxzvw9vCHkaQ?=
 =?us-ascii?Q?NaQXHbSx7O6QhJjzubV4USpEPjox203WxEYvB5Ohkeh9233BXGiz1uYl3IaV?=
 =?us-ascii?Q?vT7DhkDDTaMmp2KtNiSQoBt4P4tnCbwd3jirc1T6DNaILqWYU1o+9fFvxn8I?=
 =?us-ascii?Q?G5KmJstJ3oXEAbQ/8r/qpXIb3twEHDgP2ZFLkgwFmvYbqBeYBWogFD40pk/9?=
 =?us-ascii?Q?ywvY5Es/J2Hk8Eq1MxU6scjm37ApSCzWgwK/ZrK2V+ALW/E1lMtWpAfVvz3v?=
 =?us-ascii?Q?3J3GU49jjDIHdzqe7YJzFQyC/xm//SsPCCZcaIRGrrwcfjvdDuPDgg5EPSSi?=
 =?us-ascii?Q?0ZmJ3KEKxft33hOdRJAqcw7e5gUtFBXNLMHtdosPYy5xRcmXB2J5TmUllsbP?=
 =?us-ascii?Q?u1vhiuOpoTKsP4YlqbL71eGZU3aIvuk0EBkxUyfE+EuSha+VlvNsDYwp8cAM?=
 =?us-ascii?Q?YFZlptl2VKptQ7kI4EC8ylrgi7oa+wGtRSdfYpxe6KIbFMk8OWUgRT5wfy4v?=
 =?us-ascii?Q?nkezKBwMuPflVrQ8dHOVJChtdf4FuT5AcV8KeNvh54z6r2Ca8EkwsN8b+07z?=
 =?us-ascii?Q?X1m1Xwjec6V9YohHOmPoK4BWHZhKtRRL6m7D9uuP0L/6GI453Qns0ro/1Bkc?=
 =?us-ascii?Q?MEN5sGrHshSKieK2u/5uHVlxA+JlaycmaUNuJ/jGjo6djXxhEO+bjVhTmBgJ?=
 =?us-ascii?Q?jeTKQzhuc66gvg1sWb2fERerHRwCreyktbwMNkEkXzht6KABowbInqe8SFOD?=
 =?us-ascii?Q?3Tf2g6dYq0ls+zEaDUYfRBQCBaaBeE0nL+c5QZIGAjdWhmHRdElBFMBVkxGf?=
 =?us-ascii?Q?/mFLPSo3IYaCxUk2pI9nAXCeoDfSnfqzwY53oDirb9XaF3+ssQT1uXJyb3b+?=
 =?us-ascii?Q?T+U0CQ1ROsdO+e4ftyo/5UM=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 70602f15-a2bc-4ba0-9699-08de2f60fae4
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:30.6705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/HM8gmQJBi1H4ZAyZCtC9eGiGvZQuPdhlDH5NKWMPml4kT7fYGvwMAIYT14zyWJORXWHW4HWIxH56VtM8kTlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2050

When multiple MSI vectors are allocated for the DesignWare eDMA, the
driver currently records the same MSI message for all IRQs by calling
get_cached_msi_msg() per vector. For multi-vector MSI (as opposed to
MSI-X), the cached message corresponds to vector 0 and msg.data is
supposed to be adjusted by the IRQ index.

As a result, all eDMA interrupts share the same MSI data value and the
interrupt controller cannot distinguish between them.

Introduce dw_edma_compose_msi() to construct the correct MSI message for
each vector. For MSI-X nothing changes. For multi-vector MSI, derive the
base IRQ with msi_get_virq(dev, 0) and OR in the per-vector offset into
msg.data before storing it in dw->irq[i].msi.

This makes each IMWr MSI vector use a unique MSI data value.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8e5f7defa6b6..3542177a4a8e 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -839,6 +839,28 @@ static inline void dw_edma_add_irq_mask(u32 *mask, u32 alloc, u16 cnt)
 		(*mask)++;
 }
 
+static void dw_edma_compose_msi(struct device *dev, int irq, struct msi_msg *out)
+{
+	struct msi_desc *desc = irq_get_msi_desc(irq);
+	struct msi_msg msg;
+	unsigned int base;
+
+	if (!desc)
+		return;
+
+	get_cached_msi_msg(irq, &msg);
+	if (!desc->pci.msi_attrib.is_msix) {
+		/*
+		 * For multi-vector MSI, the cached message corresponds to
+		 * vector 0. Adjust msg.data by the IRQ index so that each
+		 * vector gets a unique MSI data value for IMWr Data Register.
+		 */
+		base = msi_get_virq(dev, 0);
+		msg.data |= (irq - base);
+	}
+	*out = msg;
+}
+
 static int dw_edma_irq_request(struct dw_edma *dw,
 			       u32 *wr_alloc, u32 *rd_alloc)
 {
@@ -869,8 +891,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 			return err;
 		}
 
-		if (irq_get_msi_desc(irq))
-			get_cached_msi_msg(irq, &dw->irq[0].msi);
+		dw_edma_compose_msi(dev, irq, &dw->irq[0].msi);
 
 		dw->nr_irqs = 1;
 	} else {
@@ -896,8 +917,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 			if (err)
 				goto err_irq_free;
 
-			if (irq_get_msi_desc(irq))
-				get_cached_msi_msg(irq, &dw->irq[i].msi);
+			dw_edma_compose_msi(dev, irq, &dw->irq[i].msi);
 		}
 
 		dw->nr_irqs = i;
-- 
2.48.1


