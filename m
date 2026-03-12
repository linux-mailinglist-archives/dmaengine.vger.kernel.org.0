Return-Path: <dmaengine+bounces-9405-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMw9DoHwsmlBRAAAu9opvQ
	(envelope-from <dmaengine+bounces-9405-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:57:37 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E95276245
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C73B13239A16
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 16:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378D93D3481;
	Thu, 12 Mar 2026 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wyaqwR7i"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021077.outbound.protection.outlook.com [52.101.125.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15BF3FB7EF;
	Thu, 12 Mar 2026 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334249; cv=fail; b=h7qnxmND+UH6s4LNRHniL6+7afMl0urnXRPzuIWBez9bMc0yPqia7wR0MAOEGUSSnoH8j3a1AJxGchriIo/gNbjhYY9bIuNGq7o0W5C7ORfg4b5Iz/ZYQbgHFQprc12Vag+HpY4EYAC34I3qmgngoVfUehqoAGPraQNZ33yMJ5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334249; c=relaxed/simple;
	bh=96t5+i+nTlQ21MAmusN6KCO32hRjbRF6L6kI9hvpNHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U7hQ1WHqh/XLSuCVlx4lwKEAtIZEpjpsL12vrXh+ebmO/7mx7rngZaJ9/z9jkSOE34Ux3zt9sCz0mRilrtD4sviGtBHK6MFDvHnu/gADY/AvFDOJ2bvib5g6yj5Hoi3QbFrToO8GS1L1+eosL/Kj74Cyqy12a7YOPCADdXfTNl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wyaqwR7i; arc=fail smtp.client-ip=52.101.125.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oY5SX/JvD5GKJByYb6bUgy91+4Iw83/f7edx01D2T2fBcEmrM1KvFNiYA6UUHhg3Va54cH440ReGwu570x+S2CjmckM9CbXzTJWyU7tuTsm4JbrudpBkidrnveKvKDJU8i6wv48XnbtyzgBIEOQ6ibjhsjFKWvT8SXnx2bNf50HAoc8p9YO9kynzxKIdbOODkIr1t7IjKWH01Ejfxxw+O4j2mFWGN7ZTldgRv0ZfhW/JCZBYa/Oe+2VYpMD4eDOFIoKChRIsmPexqzkR1ig++syZSGIBz3VCDQzm8Lh8wgtgdzxsooArAPs/AInm+hEQzd0iHWh5NfIEr5B4nN3aSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ELSolLDVsw8B83+RRmkMp+SU3/LkCtiB5Q1uBicCpg=;
 b=p4dhgW8H82e1Acc/V3nGmpfwhDB5IBQtprkdlfAfwlOCuE6jSfmWnjI6b/4zAEzNEeKbA4clwM1Jco/0b/UWgVYFKRzlSr+PsTvor4nz+hfirhLkcE2xofwp0ZL9PpKnb1cKYffPT2ZNlk5r/JQMgknIcG/I1NQlMH7YO4GTpMpYE38PYPITg7n6Z4pXvmbs+gaGubh0hl9IQkVTiBVGtjuQptpmrpeZgGOTG8spVgLE9Lf4kcP8B6ytQBfeNwqUwJmTnmD24sgI+Amq5j60htboeM3mdz4liS97oXz6MuoEUl6KEJSdq/Gl5R1l37y7qFgd4A3cVjUDk5wYo+119w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ELSolLDVsw8B83+RRmkMp+SU3/LkCtiB5Q1uBicCpg=;
 b=wyaqwR7i+yUgJAXjz7BC19kSq0+CEa9aUCH8vQr/mChAiK6GzNQdA+vX0Qpvbem2brpuQ0+pNSSyhS+Eq2NfkyF4GoYabjg5+8zyL0qnnQEFEtKLjpUqU1wtImax3Zym7cQLAUhs1AvKkUwv9iy9DUN6I/5aeowZrkG+731nX4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2018.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:50:19 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 16:50:19 +0000
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
Subject: [PATCH 10/15] PCI: endpoint: pci-epf-vntb: Support DMA export and shared BAR layouts
Date: Fri, 13 Mar 2026 01:50:00 +0900
Message-ID: <20260312165005.1148676-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312165005.1148676-1-den@valinux.co.jp>
References: <20260312165005.1148676-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0094.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: 4101fcba-2cda-4593-6a7e-08de805771d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JsDN1KYc52LGSFd2GRvEgQzTwAHZFhYUPAnvnbJGcsj4fnKJgJZXG0o48Mid7gh/t4o0ITGAVp3NfZdd9ff7ExMZoN4MRImokZLM7yVHlv/trIJ+CFTnkgPpgARjAYq+C1l5bCmwF5BdmQj8OnjUKJSOFQbpyqI6L0eTM7BiUXqkxnA4hAI0x2W29zvA4ocoii5cy9gKoSYemqIn+6JAJfL56wdKOo6nLo80Jos8DOhhlPGf/mA+cQnjz+3sw5doMt6cWjLfWrMrVYobYzt3drxKU5XtWxJ9VUeveH8k97isT19WA2nJpgvlZGPE74tFPGm1VxHCHIFKehKU58EcbRWVva1CBwINrhNw5FRZ4Dgl4Pp7UWTJrteFN5Qmy86guoT7GI4ZF8ACIhBhupGuMX+DUuGkkPU3Lh1JhxR7TpLcD50nu9oAknrxqKNeGDClvq2lQxoJE1BEg1offCEyiHIpfoERjdK6OIozuao1lceCQFrFMUOmzholBkiR++AFccMYMgGNJUG8/u8NbpckEqf1yJz/RnPGit8oN9p2/8qzB0QurTeI+WQET/zybJzbytK7pn/tDzw4Dyziyp0+Wv1m7FED0d/KmzJoGzPhyd4sw7IIIqjbyEwoQBUIB9ObPILrNhF+kFtLY8dOjV0rranJQ1Tyd/sprp744X4RVMwJDMCp02nLNlcO4CAgvk01lE4QNB2kny7GvuIsvXL/oMxFsnZS0rU7zN2UduEAFX8247tSwEnyi+e9VeSzi+fmii8glmeoFaZXv7Sv+yewaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J2CHDKMnrJ9f0gxkG/yv6WLZ1eDd/ftDNNfQBWs3FG50begDFBG2JqbjGz3K?=
 =?us-ascii?Q?DW1tD7yTPeZw7GtaguBRagtRJC3wowtqhB4zezor1bua2QWgQlqU9p5Cgm8/?=
 =?us-ascii?Q?pjYtOH+vP7Zmd0riG1bZtVEj8V44y9qwfaEzRcoWLIhWzml7/E+ePuRDhHom?=
 =?us-ascii?Q?QwYCWa5F9fmZ3J8+5reAiCDnFbMNytxlkGbr9reof0lJw2z7ck2A1t3d06uO?=
 =?us-ascii?Q?Pk170eloZzauL2pedvCVsLrui3w4aIEmK2xP6eMxYfvJHsmHM2beKbg9wh0H?=
 =?us-ascii?Q?f9BPE6TzqcAqlG54alCy+NjPcBjH6mWlaYO5+zu04L6A28uRmrOUt8PBxbH2?=
 =?us-ascii?Q?8OTxLnIL4t223CIvBCOQ2KJWV8plSVnw49mgQPy79YlqT0v3kkhWbIcWZjAt?=
 =?us-ascii?Q?ye6/wHHZBPy3HETqS/fReCBFYTlCaFua6z5aVzXdtNNjb39Ym22RyJJY793/?=
 =?us-ascii?Q?4Ap46kiBn4Aq7gn3swMVohV0wLx5JGA+rWKgFBbFBD/bQatF7yymnAKHnHWU?=
 =?us-ascii?Q?nPmqjyXZ7gc03dtDfatD9nfdzwdbuL0Y2bVzkcmdmz9srnhTt4tPfmVJrYkD?=
 =?us-ascii?Q?Ld37nRN7D8ovXvtUjGk2EaY6no7+J5UCT9xfmNFeIJRWmYP3Bb+/2MIJn9aY?=
 =?us-ascii?Q?X9qozopM/sCcdLxy1ytYNGzfYVwNfAP0m3rCuugZ40NSq08rxWs4uL57HIX8?=
 =?us-ascii?Q?+T0G/DqeDcvisXiMHPG4EcaH9NYBF192rCaYWIIGQ35K+v6dUhcDnsNKaqr2?=
 =?us-ascii?Q?1SoGYI68wrTj3Bnzvw/GGFIz44S4iWYL6zxQLwdDQuK2rgIwgClHsIi+qnoa?=
 =?us-ascii?Q?oljG86Fxvu2mUBOwnI0JcLB3JQV390QrwTcwK7eyTDQchb9B6qJpGCPFw/bY?=
 =?us-ascii?Q?S/qhco70MIL0xmYdVAWzo1XVEK4w/UOBu6GtC336qoGy3x8u/nh/ADiu7RGH?=
 =?us-ascii?Q?P7EosVtr0u0YrMP1LKaxY4HDVqFJDIXbW3/j46rKIF0dfa+gfUdZ4LvflgGX?=
 =?us-ascii?Q?mmmoA8gaLqjeIfienJ5gy3U7ph2Rr8unCy8lekojpPqMf/eAnkvsrdhWEZz+?=
 =?us-ascii?Q?aO/g+Kf1jVrmm9h6tldBLp6WKm3oqHP02SYzBBpJH57HAwYYKMWs4QhjngD6?=
 =?us-ascii?Q?SRmSWPhD2V1VlGld8VML6aS/60anamCgyWzsRGayC8OWnSTkiUZ0nQ6Panbc?=
 =?us-ascii?Q?pVSYFKWtL6Ignh0rns9U8NhSpW3+cEMQ1rz80vIYb8ebuhEhDhmUlUIShf2l?=
 =?us-ascii?Q?dzNrFBMjEtiAAIOryn8YV2Slnv8lvHOd5runr8mb5c3WH0rk73s7QCDg2eZp?=
 =?us-ascii?Q?8J/IVpGEmEyjhs4sMULcVn+qw1c9ypVohdBuGyK8XrYO1ZM70EnG6z6VyFpD?=
 =?us-ascii?Q?Y/phE5Par5ZEfsexIanqyCVLodycYySOm5GJ+Z33IYFYDF0JtRyCI3hOzPx9?=
 =?us-ascii?Q?ZOZ2egTz/x5R2uQffnLOUUAptY8nMrePu9Fd/U+Pi1sqkw+Gr2vS4ihdK9fA?=
 =?us-ascii?Q?XSyrHtr0zlPIhNYdVDPxM52gA33AeTr8VMhFmxe1gSw1G36VW68TmrdEZbqn?=
 =?us-ascii?Q?UI+CLOwS8uS4AGgdEhvXwnKQmHvyyK8yxJPPrD10r/KU+22pAl2X4T5wSlUM?=
 =?us-ascii?Q?GIwvIY2JaFNMBgUqxF85LI/Be7n6HEtMe/GhRDcvkpI3PEPmO4YzEPD1FMmO?=
 =?us-ascii?Q?cBTTfxc3Ts2+bpVaW4Uup+/C8xusdsIxivmLMWc56Th7Txzxp6qUWGLFmYFO?=
 =?us-ascii?Q?o1RPDEv+neFJ6kgCrYzfrUtFzz1YBD28bfR59+fZsxAzdjurObIg?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4101fcba-2cda-4593-6a7e-08de805771d4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:50:19.4066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYwwzFxhqxuTRlV3XV22YVNb1zwmDd17lx2wdIzR5ga/rt+aBqz+QjxYDLODhhH0AIVtzriWw3IsQRFB2jo2Qw==
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
	TAGGED_FROM(0.00)[bounces-9405-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: B8E95276245
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Teach pci-epf-vntb to publish a versioned control layout and an optional
exported DMA slice.

When the configuration still matches the historical one-MW-per-BAR
layout and DMA export is disabled, keep emitting the legacy control
block. Otherwise emit control-layout v1, which adds per-MW offset/size
tuples and a DMA locator for the exported slice. Add configfs knobs for
mwN_offset, dma_bar, dma_offset, and dma_num_chans, and use
pci_epf_alloc_dma() to prepare the DMA export.

Also add BAR planning code so memory windows and the DMA slice can share
a physical BAR. Shared layouts are programmed in two stages: install a
temporary whole-BAR mapping at bind time, then switch to the final
subrange map on the first host command once BAR addresses are valid.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 760 ++++++++++++++++--
 1 file changed, 707 insertions(+), 53 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 16656659a9ce..d493d64dca72 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -41,7 +41,9 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/sort.h>
 
+#include <linux/pci-ep-dma.h>
 #include <linux/pci-ep-msi.h>
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
@@ -69,6 +71,9 @@ static struct workqueue_struct *kpcintb_workqueue;
 #define MAX_DB_COUNT			32
 #define MAX_MW				4
 
+#define NTB_EPF_CTRL_VERSION_LEGACY	0
+#define NTB_EPF_CTRL_VERSION_V1		1
+
 /* Limit per-work execution to avoid monopolizing kworker on doorbell storms. */
 #define VNTB_PEER_DB_WORK_BUDGET	5
 
@@ -79,6 +84,7 @@ enum epf_ntb_bar {
 	BAR_MW2,
 	BAR_MW3,
 	BAR_MW4,
+	BAR_DMA,
 	VNTB_BAR_NUM,
 };
 
@@ -116,22 +122,41 @@ struct epf_ntb_ctrl {
 	u32 argument;
 	u16 command_status;
 	u16 link_status;
-	u32 topology;
+	u32 ctrl_version;
 	u64 addr;
 	u64 size;
 	u32 num_mws;
-	u32 reserved;
+	u32 mw1_offset;
 	u32 spad_offset;
 	u32 spad_count;
 	u32 db_entry_size;
 	u32 db_data[MAX_DB_COUNT];
 	u32 db_offset[MAX_DB_COUNT];
+	u32 mw_offset[MAX_MW];
+	u32 mw_size[MAX_MW];
+	u32 dma_abi;
+	u32 dma_bar;
+	u32 dma_offset;
+	u32 dma_size;
+	u32 dma_num_chans;
 } __packed;
 
 struct epf_ntb_mw {
 	u64 size;
+	u32 offset;
 	phys_addr_t vpci_mw_phys;
 	void __iomem *vpci_mw_addr;
+	dma_addr_t bar_phys;
+};
+
+struct epf_ntb_bar_plan {
+	bool staged;
+	bool deferred;
+	bool active;
+	unsigned int region_count;
+	size_t size;
+	phys_addr_t stage_phys;
+	void __iomem *stage_addr;
 };
 
 struct epf_ntb {
@@ -143,10 +168,14 @@ struct epf_ntb {
 	u32 db_count;
 	u32 spad_count;
 	struct epf_ntb_mw mw[MAX_MW];
+	struct epf_ntb_bar_plan bar_plan[PCI_STD_NUM_BARS];
 	atomic64_t db;
 	atomic64_t peer_db_pending;
 	struct work_struct peer_db_work;
 	u32 vbus_number;
+	u32 dma_offset;
+	u32 dma_num_chans;
+	const struct pci_epc_features *epc_features;
 	u16 vntb_pid;
 	u16 vntb_vid;
 
@@ -162,6 +191,7 @@ struct epf_ntb {
 	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
 
 	struct epf_ntb_ctrl *reg;
+	struct pci_ep_dma *dma;
 
 	u32 *epf_db;
 
@@ -260,6 +290,258 @@ static void epf_ntb_teardown_mw(struct epf_ntb *ntb, u32 mw)
 			   ntb->mw[mw].vpci_mw_phys);
 }
 
+static bool epf_ntb_bar_valid(enum pci_barno barno)
+{
+	return barno >= BAR_0 && barno <= BAR_5;
+}
+
+/*
+ * Legacy layout has no per-MW size array and no DMA locator. Only emit it
+ * when each MW owns a distinct BAR, all MWs after MW0 start at offset 0,
+ * and no DMA slice is exported, so older ntb_hw_epf can keep inferring
+ * the layout from BAR assignments alone.
+ */
+static bool epf_ntb_ctrl_layout_is_legacy(const struct epf_ntb *ntb)
+{
+	enum pci_barno barno;
+	u8 used_mw_bars = 0;
+	int i;
+
+	if (ntb->dma)
+		return false;
+
+	for (i = 0; i < ntb->num_mws; i++) {
+		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
+		if (epf_ntb_bar_valid(barno)) {
+			if (used_mw_bars & BIT(barno))
+				return false;
+			used_mw_bars |= BIT(barno);
+		}
+
+		if (i > 0 && ntb->mw[i].offset)
+			return false;
+	}
+
+	return true;
+}
+
+static int epf_ntb_validate_ctrl_layout_v1(const struct epf_ntb *ntb)
+{
+	struct device *dev = &ntb->epf->dev;
+	int i;
+
+	if (epf_ntb_ctrl_layout_is_legacy(ntb))
+		return 0;
+
+	for (i = 0; i < ntb->num_mws; i++) {
+		if (ntb->mw[i].size > U32_MAX) {
+			dev_err(dev,
+				"MW%d size %#llx exceeds control ABI v1 limit\n",
+				i + 1,
+				(unsigned long long)ntb->mw[i].size);
+			return -E2BIG;
+		}
+	}
+
+	return 0;
+}
+
+static dma_addr_t epf_ntb_mw_active_phys(const struct epf_ntb *ntb, int idx)
+{
+	if (ntb->mw[idx].bar_phys)
+		return ntb->mw[idx].bar_phys;
+
+	return ntb->mw[idx].vpci_mw_phys;
+}
+
+struct epf_ntb_bar_region {
+	u32 offset;
+	dma_addr_t phys_addr;
+	size_t size;
+};
+
+static int epf_ntb_bar_region_cmp(const void *a, const void *b)
+{
+	const struct epf_ntb_bar_region *ra = a;
+	const struct epf_ntb_bar_region *rb = b;
+
+	if (ra->offset < rb->offset)
+		return -1;
+
+	return ra->offset > rb->offset;
+}
+
+static int
+epf_ntb_add_bar_region(struct epf_ntb_bar_region *regions,
+		       unsigned int *count, u32 offset, dma_addr_t phys_addr,
+		       size_t size, bool needs_phys_addr)
+{
+	if (needs_phys_addr && !phys_addr)
+		return -EINVAL;
+
+	regions[*count] = (struct epf_ntb_bar_region) {
+		.offset = offset,
+		.phys_addr = phys_addr,
+		.size = size,
+	};
+	(*count)++;
+
+	return 0;
+}
+
+static int
+epf_ntb_collect_bar_regions(struct epf_ntb *ntb, enum pci_barno barno,
+			    struct pci_epf_bar_submap *submap,
+			    unsigned int *nregions, size_t *total)
+{
+	struct epf_ntb_bar_region regions[MAX_MW + PCI_EP_DMA_MAX_REGIONS];
+	const struct pci_ep_dma_region *dma_regions;
+	struct device *dev = &ntb->epf->dev;
+	bool needs_phys_addr = !!submap;
+	unsigned int count = 0;
+	size_t size_total = 0;
+	int i, ret;
+
+	if (ntb->dma && ntb->epf_ntb_bar[BAR_DMA] == barno) {
+		dma_regions = pci_epf_get_dma_regions(ntb->dma);
+		for (i = 0; i < pci_epf_get_dma_region_count(ntb->dma); i++) {
+			ret = epf_ntb_add_bar_region(regions, &count,
+						     dma_regions[i].offset,
+						     dma_regions[i].phys_addr,
+						     dma_regions[i].size,
+						     needs_phys_addr);
+			if (ret)
+				return ret;
+		}
+	}
+
+	for (i = 0; i < ntb->num_mws; i++) {
+		if (ntb->epf_ntb_bar[BAR_MW1 + i] != barno)
+			continue;
+
+		ret = epf_ntb_add_bar_region(regions, &count, ntb->mw[i].offset,
+					     needs_phys_addr ?
+					     epf_ntb_mw_active_phys(ntb, i) : 0,
+					     ntb->mw[i].size, needs_phys_addr);
+		if (ret)
+			return ret;
+	}
+
+	if (!count)
+		return -EINVAL;
+
+	sort(regions, count, sizeof(regions[0]), epf_ntb_bar_region_cmp, NULL);
+
+	for (i = 0; i < count; i++) {
+		if (!regions[i].size || regions[i].offset != size_total)
+			return -EINVAL;
+		if (submap) {
+			submap[i].phys_addr = regions[i].phys_addr;
+			submap[i].size = regions[i].size;
+		}
+		size_total += regions[i].size;
+	}
+
+	if (!is_power_of_2(size_total)) {
+		dev_err(dev, "Invalid total size: %#lx\n", size_total);
+		return -EINVAL;
+	}
+
+	*nregions = count;
+	*total = size_total;
+
+	return 0;
+}
+
+static int epf_ntb_bar_activate(struct epf_ntb *ntb, enum pci_barno barno)
+{
+	struct epf_ntb_bar_plan *plan = &ntb->bar_plan[barno];
+	struct pci_epf_bar_submap *submap = NULL, *old_submap;
+	struct pci_epf_bar *epf_bar = &ntb->epf->bar[barno];
+	unsigned int nregions, old_nsub;
+	phys_addr_t old_phys;
+	size_t total;
+	int ret;
+
+	if (!plan->staged || !plan->deferred)
+		return 0;
+
+	submap = kcalloc(plan->region_count, sizeof(*submap), GFP_KERNEL);
+	if (!submap)
+		return -ENOMEM;
+
+	ret = epf_ntb_collect_bar_regions(ntb, barno, submap, &nregions, &total);
+	if (ret)
+		goto err_free;
+	if (nregions != plan->region_count || total != plan->size) {
+		ret = -EINVAL;
+		goto err_free;
+	}
+
+	old_phys = epf_bar->phys_addr;
+	old_submap = epf_bar->submap;
+	old_nsub = epf_bar->num_submap;
+
+	epf_bar->phys_addr = 0;
+	epf_bar->submap = submap;
+	epf_bar->num_submap = nregions;
+	epf_bar->size = total;
+
+	ret = pci_epc_set_bar(ntb->epf->epc,
+			      ntb->epf->func_no,
+			      ntb->epf->vfunc_no,
+			      epf_bar);
+	if (ret) {
+		epf_bar->phys_addr = old_phys;
+		epf_bar->submap = old_submap;
+		epf_bar->num_submap = old_nsub;
+		goto err_free;
+	}
+
+	if (plan->stage_addr) {
+		pci_epc_mem_free_addr(ntb->epf->epc, plan->stage_phys,
+				      plan->stage_addr, plan->size);
+		plan->stage_addr = NULL;
+		plan->stage_phys = 0;
+	}
+	kfree(old_submap);
+	plan->active = true;
+	return 0;
+
+err_free:
+	kfree(submap);
+	return ret;
+}
+
+static int epf_ntb_bar_activate_deferred(struct epf_ntb *ntb)
+{
+	bool done[PCI_STD_NUM_BARS] = { };
+	enum pci_barno barno;
+	int i, ret;
+
+	for (i = 0; i < ntb->num_mws; i++) {
+		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
+		if (!epf_ntb_bar_valid(barno) || done[barno])
+			continue;
+		if (!ntb->bar_plan[barno].active) {
+			ret = epf_ntb_bar_activate(ntb, barno);
+			if (ret)
+				return ret;
+		}
+		done[barno] = true;
+	}
+
+	barno = ntb->epf_ntb_bar[BAR_DMA];
+	if (epf_ntb_bar_valid(barno) && !done[barno] &&
+	    !ntb->bar_plan[barno].active) {
+		ret = epf_ntb_bar_activate(ntb, barno);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * epf_ntb_cmd_handler() - Handle commands provided by the NTB HOST
  * @work: work_struct for the epf_ntb_epc
@@ -309,6 +591,11 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 		ctrl->command_status = COMMAND_STATUS_OK;
 		break;
 	case COMMAND_CONFIGURE_MW:
+		ret = epf_ntb_bar_activate_deferred(ntb);
+		if (ret < 0) {
+			ctrl->command_status = COMMAND_STATUS_ERROR;
+			break;
+		}
 		ret = epf_ntb_configure_mw(ntb, argument);
 		if (ret < 0)
 			ctrl->command_status = COMMAND_STATUS_ERROR;
@@ -320,6 +607,11 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 		ctrl->command_status = COMMAND_STATUS_OK;
 		break;
 	case COMMAND_LINK_UP:
+		ret = epf_ntb_bar_activate_deferred(ntb);
+		if (ret < 0) {
+			ctrl->command_status = COMMAND_STATUS_ERROR;
+			goto reset_handler;
+		}
 		ntb->linkup = true;
 		ret = epf_ntb_link_up(ntb, true);
 		if (ret < 0)
@@ -476,8 +768,35 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	ctrl = ntb->reg;
 	ctrl->spad_offset = ctrl_size;
 
+	ctrl->ctrl_version = epf_ntb_ctrl_layout_is_legacy(ntb) ?
+		NTB_EPF_CTRL_VERSION_LEGACY : NTB_EPF_CTRL_VERSION_V1;
 	ctrl->spad_count = spad_count;
 	ctrl->num_mws = ntb->num_mws;
+	ctrl->mw1_offset = ntb->num_mws ? ntb->mw[0].offset : 0;
+
+	if (ctrl->ctrl_version >= NTB_EPF_CTRL_VERSION_V1) {
+		for (i = 0; i < ntb->num_mws; i++) {
+			ctrl->mw_offset[i] = ntb->mw[i].offset;
+			ctrl->mw_size[i] = ntb->mw[i].size;
+		}
+
+		if (ntb->dma) {
+			const struct pci_ep_dma_locator *loc =
+				pci_epf_get_dma_locator(ntb->dma);
+
+			ctrl->dma_abi = loc->abi;
+			ctrl->dma_bar = loc->bar;
+			ctrl->dma_offset = loc->offset;
+			ctrl->dma_size = loc->size;
+			ctrl->dma_num_chans = ntb->dma->num_chans;
+		} else {
+			ctrl->dma_abi = 0;
+			ctrl->dma_bar = NO_BAR;
+			ctrl->dma_offset = 0;
+			ctrl->dma_size = 0;
+			ctrl->dma_num_chans = 0;
+		}
+	}
 	ntb->spad_size = spad_size;
 
 	ctrl->db_entry_size = sizeof(u32);
@@ -509,6 +828,7 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	dev = &ntb->epf->dev;
 
 	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
+	ntb->epc_features = epc_features;
 
 	if (!(epc_features->msix_capable || epc_features->msi_capable)) {
 		dev_err(dev, "MSI or MSI-X is required for doorbell\n");
@@ -721,6 +1041,35 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 
 static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws);
 
+static void epf_ntb_dma_cleanup(struct epf_ntb *ntb)
+{
+	if (!ntb->dma)
+		return;
+
+	pci_epf_free_dma(ntb->dma);
+	ntb->dma = NULL;
+}
+
+static int epf_ntb_dma_prepare(struct epf_ntb *ntb)
+{
+	enum pci_barno barno;
+
+	barno = ntb->epf_ntb_bar[BAR_DMA];
+	if (barno == NO_BAR)
+		return 0;
+
+	ntb->dma = pci_epf_alloc_dma(ntb->epf, barno, ntb->dma_offset,
+				     ntb->dma_num_chans ?: 1);
+	if (IS_ERR(ntb->dma)) {
+		int ret = PTR_ERR(ntb->dma);
+
+		ntb->dma = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
 /**
  * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
  *   allocated in peer's outbound address space
@@ -751,6 +1100,169 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 			  &ntb->epf->bar[barno]);
 }
 
+static int
+epf_ntb_validate_one_bar_layout(struct epf_ntb *ntb, enum pci_barno barno)
+{
+	unsigned int count;
+	size_t total;
+	int ret;
+
+	ret = epf_ntb_collect_bar_regions(ntb, barno, NULL, &count, &total);
+	if (ret)
+		return ret;
+
+	if (count <= 1 ||
+	    (ntb->epc_features->subrange_mapping &&
+	     ntb->epc_features->dynamic_inbound_mapping))
+		return 0;
+
+	dev_err(&ntb->epf->dev,
+		"BAR%d requires %u regions but subrange mapping unsupported\n",
+		barno, count);
+
+	return -EOPNOTSUPP;
+}
+
+static int epf_ntb_validate_bar_layout(struct epf_ntb *ntb)
+{
+	bool checked[PCI_STD_NUM_BARS] = { };
+	enum pci_barno barno;
+	int i, ret;
+
+	for (i = 0; i < ntb->num_mws; i++) {
+		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
+		if (!epf_ntb_bar_valid(barno) || checked[barno])
+			continue;
+
+		ret = epf_ntb_validate_one_bar_layout(ntb, barno);
+		if (ret)
+			return ret;
+
+		checked[barno] = true;
+	}
+
+	barno = ntb->epf_ntb_bar[BAR_DMA];
+	if (!epf_ntb_bar_valid(barno) || checked[barno])
+		return 0;
+
+	return epf_ntb_validate_one_bar_layout(ntb, barno);
+}
+
+/*
+ * Shared MW/DMA BARs are programmed in two stages. At bind time the host
+ * has not assigned BAR addresses yet, so install a temporary whole-BAR
+ * mapping first. Once the first host command arrives and BAR addresses
+ * are valid, replace it with the final subrange layout.
+ */
+static int epf_ntb_bar_stage1_program(struct epf_ntb *ntb, enum pci_barno barno)
+{
+	struct pci_epf_bar_submap regions[MAX_MW + PCI_EP_DMA_MAX_REGIONS];
+	struct epf_ntb_bar_plan *plan = &ntb->bar_plan[barno];
+	struct pci_epf_bar *epf_bar = &ntb->epf->bar[barno];
+	unsigned int nregions;
+	size_t total;
+	int ret;
+
+	ret = epf_ntb_collect_bar_regions(ntb, barno, regions, &nregions, &total);
+	if (ret)
+		return ret;
+
+	plan->region_count = nregions;
+	plan->size = total;
+	plan->deferred = nregions > 1;
+	plan->active = !plan->deferred;
+
+	if (plan->deferred) {
+		plan->stage_addr = pci_epc_mem_alloc_addr(ntb->epf->epc,
+							  &plan->stage_phys,
+							  total);
+		if (!plan->stage_addr)
+			return -ENOMEM;
+	}
+
+	epf_bar->barno = barno;
+	epf_bar->size = total;
+	epf_bar->addr = NULL;
+	epf_bar->flags = upper_32_bits(total) ?
+		PCI_BASE_ADDRESS_MEM_TYPE_64 : PCI_BASE_ADDRESS_MEM_TYPE_32;
+	epf_bar->submap = NULL;
+	epf_bar->num_submap = 0;
+	epf_bar->phys_addr = plan->deferred ? plan->stage_phys : regions[0].phys_addr;
+
+	ret = pci_epc_set_bar(ntb->epf->epc,
+			      ntb->epf->func_no,
+			      ntb->epf->vfunc_no,
+			      epf_bar);
+	if (ret) {
+		if (plan->stage_addr) {
+			pci_epc_mem_free_addr(ntb->epf->epc, plan->stage_phys,
+					      plan->stage_addr, total);
+			plan->stage_addr = NULL;
+			plan->stage_phys = 0;
+		}
+		return ret;
+	}
+
+	plan->staged = true;
+	return 0;
+}
+
+static int epf_ntb_bar_refresh(struct epf_ntb *ntb, enum pci_barno barno)
+{
+	struct epf_ntb_bar_plan *plan = &ntb->bar_plan[barno];
+	struct pci_epf_bar *epf_bar = &ntb->epf->bar[barno];
+	struct pci_epf_bar_submap region;
+	unsigned int nregions;
+	size_t total;
+	int ret;
+
+	if (!plan->staged)
+		return 0;
+
+	if (plan->deferred)
+		return plan->active ? epf_ntb_bar_activate(ntb, barno) : 0;
+
+	ret = epf_ntb_collect_bar_regions(ntb, barno, &region, &nregions, &total);
+	if (ret)
+		return ret;
+	if (nregions != 1 || total != plan->size)
+		return -EINVAL;
+
+	epf_bar->phys_addr = region.phys_addr;
+	epf_bar->submap = NULL;
+	epf_bar->num_submap = 0;
+	epf_bar->size = total;
+
+	return pci_epc_set_bar(ntb->epf->epc,
+			       ntb->epf->func_no,
+			       ntb->epf->vfunc_no,
+			       epf_bar);
+}
+
+static void epf_ntb_mw_bar_release(struct epf_ntb *ntb, enum pci_barno barno)
+{
+	struct epf_ntb_bar_plan *plan = &ntb->bar_plan[barno];
+	struct pci_epf_bar *epf_bar = &ntb->epf->bar[barno];
+
+	if (!plan->staged)
+		return;
+
+	pci_epc_clear_bar(ntb->epf->epc,
+			  ntb->epf->func_no,
+			  ntb->epf->vfunc_no,
+			  epf_bar);
+	kfree(epf_bar->submap);
+	epf_bar->submap = NULL;
+	epf_bar->num_submap = 0;
+	if (plan->stage_addr) {
+		pci_epc_mem_free_addr(ntb->epf->epc, plan->stage_phys,
+				      plan->stage_addr, plan->size);
+		plan->stage_addr = NULL;
+		plan->stage_phys = 0;
+	}
+	memset(plan, 0, sizeof(*plan));
+}
+
 /**
  * epf_ntb_mw_bar_init() - Configure Memory window BARs
  * @ntb: NTB device that facilitates communication between HOST and VHOST
@@ -759,54 +1271,55 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
  */
 static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 {
+	bool programmed[PCI_STD_NUM_BARS] = { };
+	struct device *dev = &ntb->epf->dev;
+	enum pci_barno barno;
 	int ret = 0;
 	int i;
-	u64 size;
-	enum pci_barno barno;
-	struct device *dev = &ntb->epf->dev;
 
 	for (i = 0; i < ntb->num_mws; i++) {
-		size = ntb->mw[i].size;
-		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
+		if (!ntb->mw[i].size)
+			return -EINVAL;
 
-		ntb->epf->bar[barno].barno = barno;
-		ntb->epf->bar[barno].size = size;
-		ntb->epf->bar[barno].addr = NULL;
-		ntb->epf->bar[barno].phys_addr = 0;
-		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
-				PCI_BASE_ADDRESS_MEM_TYPE_64 :
-				PCI_BASE_ADDRESS_MEM_TYPE_32;
-
-		ret = pci_epc_set_bar(ntb->epf->epc,
-				      ntb->epf->func_no,
-				      ntb->epf->vfunc_no,
-				      &ntb->epf->bar[barno]);
-		if (ret) {
-			dev_err(dev, "MW set failed\n");
-			goto err_alloc_mem;
-		}
-
-		/* Allocate EPC outbound memory windows to vpci vntb device */
 		ntb->mw[i].vpci_mw_addr =
 				pci_epc_mem_alloc_addr(ntb->epf->epc,
 						       &ntb->mw[i].vpci_mw_phys,
-						       size);
+						       ntb->mw[i].size);
 		if (!ntb->mw[i].vpci_mw_addr) {
 			ret = -ENOMEM;
 			dev_err(dev, "Failed to allocate source address\n");
-			goto err_set_bar;
+			goto err_alloc;
+		}
+
+		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
+		if (!epf_ntb_bar_valid(barno)) {
+			ret = -EINVAL;
+			goto err_alloc;
+		}
+		if (programmed[barno])
+			continue;
+
+		ret = epf_ntb_bar_stage1_program(ntb, barno);
+		if (ret) {
+			dev_err(dev, "MW BAR stage1 set failed\n");
+			goto err_alloc;
 		}
+		programmed[barno] = true;
 	}
 
-	return ret;
+	barno = ntb->epf_ntb_bar[BAR_DMA];
+	if (ntb->dma && epf_ntb_bar_valid(barno) && !programmed[barno]) {
+		ret = epf_ntb_bar_stage1_program(ntb, barno);
+		if (ret) {
+			dev_err(dev, "DMA BAR stage1 set failed\n");
+			goto err_alloc;
+		}
+	}
 
-err_set_bar:
-	pci_epc_clear_bar(ntb->epf->epc,
-			  ntb->epf->func_no,
-			  ntb->epf->vfunc_no,
-			  &ntb->epf->bar[barno]);
-err_alloc_mem:
-	epf_ntb_mw_bar_clear(ntb, i);
+	return 0;
+
+err_alloc:
+	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 	return ret;
 }
 
@@ -817,21 +1330,32 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
  */
 static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 {
+	bool cleared[PCI_STD_NUM_BARS] = { };
 	enum pci_barno barno;
 	int i;
 
 	for (i = 0; i < num_mws; i++) {
 		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
-		pci_epc_clear_bar(ntb->epf->epc,
-				  ntb->epf->func_no,
-				  ntb->epf->vfunc_no,
-				  &ntb->epf->bar[barno]);
+		if (epf_ntb_bar_valid(barno) && !cleared[barno]) {
+			epf_ntb_mw_bar_release(ntb, barno);
+			cleared[barno] = true;
+		}
+
+		if (!ntb->mw[i].vpci_mw_addr)
+			continue;
 
 		pci_epc_mem_free_addr(ntb->epf->epc,
 				      ntb->mw[i].vpci_mw_phys,
 				      ntb->mw[i].vpci_mw_addr,
 				      ntb->mw[i].size);
+		ntb->mw[i].vpci_mw_addr = NULL;
+		ntb->mw[i].vpci_mw_phys = 0;
+		ntb->mw[i].bar_phys = 0;
 	}
+
+	barno = ntb->epf_ntb_bar[BAR_DMA];
+	if (ntb->dma && epf_ntb_bar_valid(barno) && !cleared[barno])
+		epf_ntb_mw_bar_release(ntb, barno);
 }
 
 /**
@@ -910,6 +1434,11 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 	num_mws = ntb->num_mws;
 	dev = &ntb->epf->dev;
 	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
+	if (!epc_features) {
+		dev_err(dev, "Failed to get EPC features\n");
+		return -ENODEV;
+	}
+	ntb->epc_features = epc_features;
 
 	/* These are required BARs which are mandatory for NTB functionality */
 	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++) {
@@ -1102,6 +1631,59 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 	return len;							\
 }
 
+#define EPF_NTB_MW_OFF_R(_name)						\
+static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
+				      char *page)			\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct epf_ntb *ntb = to_epf_ntb(group);			\
+	struct device *dev = &ntb->epf->dev;				\
+	int win_no, idx;						\
+									\
+	if (sscanf(#_name, "mw%d_offset", &win_no) != 1)		\
+		return -EINVAL;						\
+									\
+	idx = win_no - 1;						\
+	if (idx < 0 || idx >= ntb->num_mws) {				\
+		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
+			win_no, ntb->num_mws);				\
+		return -ERANGE;						\
+	}								\
+	idx = array_index_nospec(idx, ntb->num_mws);			\
+									\
+	return sprintf(page, "%u\n", ntb->mw[idx].offset);		\
+}
+
+#define EPF_NTB_MW_OFF_W(_name)						\
+static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
+				       const char *page, size_t len)	\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct epf_ntb *ntb = to_epf_ntb(group);			\
+	struct device *dev = &ntb->epf->dev;				\
+	int win_no, idx;						\
+	u32 val;							\
+	int ret;							\
+									\
+	ret = kstrtou32(page, 0, &val);					\
+	if (ret)							\
+		return ret;						\
+									\
+	if (sscanf(#_name, "mw%d_offset", &win_no) != 1)		\
+		return -EINVAL;						\
+									\
+	idx = win_no - 1;						\
+	if (idx < 0 || idx >= ntb->num_mws) {				\
+		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
+			win_no, ntb->num_mws);				\
+		return -ERANGE;						\
+	}								\
+	idx = array_index_nospec(idx, ntb->num_mws);			\
+	ntb->mw[idx].offset = val;					\
+									\
+	return len;							\
+}
+
 #define EPF_NTB_BAR_R(_name, _id)					\
 	static ssize_t epf_ntb_##_name##_show(struct config_item *item,	\
 					      char *page)		\
@@ -1153,6 +1735,30 @@ static ssize_t epf_ntb_num_mws_store(struct config_item *item,
 	return len;
 }
 
+static ssize_t epf_ntb_dma_offset_show(struct config_item *item, char *page)
+{
+	struct config_group *group = to_config_group(item);
+	struct epf_ntb *ntb = to_epf_ntb(group);
+
+	return sprintf(page, "%u\n", ntb->dma_offset);
+}
+
+static ssize_t epf_ntb_dma_offset_store(struct config_item *item,
+					const char *page, size_t len)
+{
+	struct config_group *group = to_config_group(item);
+	struct epf_ntb *ntb = to_epf_ntb(group);
+	u32 val;
+	int ret;
+
+	ret = kstrtou32(page, 0, &val);
+	if (ret)
+		return ret;
+
+	ntb->dma_offset = val;
+	return len;
+}
+
 EPF_NTB_R(spad_count)
 EPF_NTB_W(spad_count)
 EPF_NTB_R(db_count)
@@ -1164,6 +1770,8 @@ EPF_NTB_R(vntb_pid)
 EPF_NTB_W(vntb_pid)
 EPF_NTB_R(vntb_vid)
 EPF_NTB_W(vntb_vid)
+EPF_NTB_R(dma_num_chans)
+EPF_NTB_W(dma_num_chans)
 EPF_NTB_MW_R(mw1)
 EPF_NTB_MW_W(mw1)
 EPF_NTB_MW_R(mw2)
@@ -1172,6 +1780,14 @@ EPF_NTB_MW_R(mw3)
 EPF_NTB_MW_W(mw3)
 EPF_NTB_MW_R(mw4)
 EPF_NTB_MW_W(mw4)
+EPF_NTB_MW_OFF_R(mw1_offset)
+EPF_NTB_MW_OFF_W(mw1_offset)
+EPF_NTB_MW_OFF_R(mw2_offset)
+EPF_NTB_MW_OFF_W(mw2_offset)
+EPF_NTB_MW_OFF_R(mw3_offset)
+EPF_NTB_MW_OFF_W(mw3_offset)
+EPF_NTB_MW_OFF_R(mw4_offset)
+EPF_NTB_MW_OFF_W(mw4_offset)
 EPF_NTB_BAR_R(ctrl_bar, BAR_CONFIG)
 EPF_NTB_BAR_W(ctrl_bar, BAR_CONFIG)
 EPF_NTB_BAR_R(db_bar, BAR_DB)
@@ -1184,6 +1800,8 @@ EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
 EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
 EPF_NTB_BAR_R(mw4_bar, BAR_MW4)
 EPF_NTB_BAR_W(mw4_bar, BAR_MW4)
+EPF_NTB_BAR_R(dma_bar, BAR_DMA)
+EPF_NTB_BAR_W(dma_bar, BAR_DMA)
 
 CONFIGFS_ATTR(epf_ntb_, spad_count);
 CONFIGFS_ATTR(epf_ntb_, db_count);
@@ -1192,15 +1810,22 @@ CONFIGFS_ATTR(epf_ntb_, mw1);
 CONFIGFS_ATTR(epf_ntb_, mw2);
 CONFIGFS_ATTR(epf_ntb_, mw3);
 CONFIGFS_ATTR(epf_ntb_, mw4);
+CONFIGFS_ATTR(epf_ntb_, mw1_offset);
+CONFIGFS_ATTR(epf_ntb_, mw2_offset);
+CONFIGFS_ATTR(epf_ntb_, mw3_offset);
+CONFIGFS_ATTR(epf_ntb_, mw4_offset);
 CONFIGFS_ATTR(epf_ntb_, vbus_number);
 CONFIGFS_ATTR(epf_ntb_, vntb_pid);
 CONFIGFS_ATTR(epf_ntb_, vntb_vid);
+CONFIGFS_ATTR(epf_ntb_, dma_num_chans);
 CONFIGFS_ATTR(epf_ntb_, ctrl_bar);
 CONFIGFS_ATTR(epf_ntb_, db_bar);
 CONFIGFS_ATTR(epf_ntb_, mw1_bar);
 CONFIGFS_ATTR(epf_ntb_, mw2_bar);
 CONFIGFS_ATTR(epf_ntb_, mw3_bar);
 CONFIGFS_ATTR(epf_ntb_, mw4_bar);
+CONFIGFS_ATTR(epf_ntb_, dma_bar);
+CONFIGFS_ATTR(epf_ntb_, dma_offset);
 
 static struct configfs_attribute *epf_ntb_attrs[] = {
 	&epf_ntb_attr_spad_count,
@@ -1210,15 +1835,22 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
 	&epf_ntb_attr_mw2,
 	&epf_ntb_attr_mw3,
 	&epf_ntb_attr_mw4,
+	&epf_ntb_attr_mw1_offset,
+	&epf_ntb_attr_mw2_offset,
+	&epf_ntb_attr_mw3_offset,
+	&epf_ntb_attr_mw4_offset,
 	&epf_ntb_attr_vbus_number,
 	&epf_ntb_attr_vntb_pid,
 	&epf_ntb_attr_vntb_vid,
+	&epf_ntb_attr_dma_num_chans,
 	&epf_ntb_attr_ctrl_bar,
 	&epf_ntb_attr_db_bar,
 	&epf_ntb_attr_mw1_bar,
 	&epf_ntb_attr_mw2_bar,
 	&epf_ntb_attr_mw3_bar,
 	&epf_ntb_attr_mw4_bar,
+	&epf_ntb_attr_dma_bar,
+	&epf_ntb_attr_dma_offset,
 	NULL,
 };
 
@@ -1372,29 +2004,33 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 		dma_addr_t addr, resource_size_t size)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
-	struct pci_epf_bar *epf_bar;
+	struct device *dev = &ntb->ntb.dev;
 	enum pci_barno barno;
 	int ret;
-	struct device *dev;
 
-	dev = &ntb->ntb.dev;
 	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
-	epf_bar = &ntb->epf->bar[barno];
-	epf_bar->phys_addr = addr;
-	epf_bar->barno = barno;
-	epf_bar->size = size;
+	if (size != ntb->mw[idx].size) {
+		dev_err(dev, "unsupported MW resize for shared BAR layout\n");
+		return -EINVAL;
+	}
 
-	ret = pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
-	if (ret) {
+	ntb->mw[idx].bar_phys = addr;
+	ret = epf_ntb_bar_refresh(ntb, barno);
+	if (ret)
 		dev_err(dev, "failure set mw trans\n");
-		return ret;
-	}
-	return 0;
+
+	return ret;
 }
 
-static int vntb_epf_mw_clear_trans(struct ntb_dev *ntb, int pidx, int idx)
+static int vntb_epf_mw_clear_trans(struct ntb_dev *ndev, int pidx, int idx)
 {
-	return 0;
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+	enum pci_barno barno;
+
+	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
+
+	ntb->mw[idx].bar_phys = 0;
+	return epf_ntb_bar_refresh(ntb, barno);
 }
 
 static int vntb_epf_peer_mw_get_addr(struct ntb_dev *ndev, int idx,
@@ -1695,6 +2331,22 @@ static int epf_ntb_bind(struct pci_epf *epf)
 		return ret;
 	}
 
+	ret = epf_ntb_dma_prepare(ntb);
+	if (ret) {
+		dev_err(dev, "Failed to prepare DMA export\n");
+		goto err_bar_alloc;
+	}
+
+	ret = epf_ntb_validate_bar_layout(ntb);
+	if (ret) {
+		dev_err(dev, "Unsupported BAR layout for this EPC\n");
+		goto err_bar_alloc;
+	}
+
+	ret = epf_ntb_validate_ctrl_layout_v1(ntb);
+	if (ret)
+		goto err_bar_alloc;
+
 	ret = epf_ntb_config_spad_bar_alloc(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to allocate BAR memory\n");
@@ -1730,6 +2382,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
 err_epc_cleanup:
 	epf_ntb_epc_cleanup(ntb);
 err_bar_alloc:
+	epf_ntb_dma_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
 
 	return ret;
@@ -1746,6 +2399,7 @@ static void epf_ntb_unbind(struct pci_epf *epf)
 	struct epf_ntb *ntb = epf_get_drvdata(epf);
 
 	epf_ntb_epc_cleanup(ntb);
+	epf_ntb_dma_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
 
 	pci_unregister_driver(&vntb_pci_driver);
-- 
2.51.0


