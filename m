Return-Path: <dmaengine+bounces-10821-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKT5OqPtE2pCHgcAu9opvQ
	(envelope-from <dmaengine+bounces-10821-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:35:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8986D5C685B
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E622E30045B0
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90293A873B;
	Mon, 25 May 2026 06:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="rDRPdzen"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021078.outbound.protection.outlook.com [40.107.74.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6853A784A;
	Mon, 25 May 2026 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690907; cv=fail; b=ftDrxtfWCsK5raqQ/jA2aHJXu9wv1nhBmvdvGZNnAD7tzP9cy/PPBvb+ED+nifq8b0syPNnB+qpgpfIz7MvKB/7ritTxOYhq0k/fqoB/B+WNAZkXLuOo2uVtfqhE+WIWvC5tjYVHtIiMjAeq8ID0dEQy2RIXSvOdzpg6zkvfMZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690907; c=relaxed/simple;
	bh=xupSMoh7sJH84KOQ9LPKMbX2M5FVkLAxsVYm9kAjFnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T3+8WJ4TRZlC38dxkDWM2JksBIZAOboyzA4gUpy18N3zUq8cRVRuGMiLE/yHGNZ1VOBczE6YvMybFFA7E9WVbAwZ9OOytCE6nfk6cH9Ricwz3ErrMw++GqMINe32mXiMS6AlGz22Dln22EK3B1hzwel0Oy4EtBxACuzORea5qnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rDRPdzen; arc=fail smtp.client-ip=40.107.74.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDz0ZAFuBZS/DrB3FICvTmAWM5g+C2SIyHOAQ0LeOwOez15KFavf/H3Ce427qkPuSjXUD+ftHECnIkWhn45SrSypupTyQ+mxqPkdG5NmUFvmcXt2aMPGns59cFkHj8YN9RlX21exPofOlQTvFcnWfJK0hYilC1+z7L2U0x+O3JcMHzfZK5859NTBzsbKpWeCfVCQ6vLht0ALPOBVBuS+kaC1kH4lYaK4xQRTUEqeFErSMBfdBTl5Kdx54ldF0V2Nvr7BWqjCOiKBsdsPsaz77JroZyZJ7CKydyMCqhzCUDKIutUMQH3Q4TIRouXbkdqYpqnEH4XLX/QMvZOhCq3RBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8Kd5PMKJ1p9ZX2WiTOp3478oz/MWFzaycfRVmo/Rio=;
 b=SqUPa6h8pU4Ev5rxyFuEAKHPt4vr/Ym1iIcSNszizdNPGR0/Otkh0SDpRnLIFMHiFYtHnkjFjBQiWPzMICiktpeUia80Q/Jr393HYQjNbAXsDqRMoO8cBTdNw64Wyqoq8g/M5935RTnPlZjIbepEB0EZwRtqHF/fTWmWtK7j8zY0b65cJAXokhBNXI/2109jZqs/DjgRsrp4ppDp9+iTVLb0p0Mefvg1jQKyxqitWxUcHYqXLe5RNSQspDiq8vz0py/mhXHoo+1GRXqF09sw24kIx45YiQShocSCbRLyIvRHmB6BD3BoIXjKgZbY4I6/hEHHcLUU6yOXXW/nRthaLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8Kd5PMKJ1p9ZX2WiTOp3478oz/MWFzaycfRVmo/Rio=;
 b=rDRPdzenGhivB4ioX69K2i9jz95mHBRkpXSXRBhPEAUdM4kvMyqfiYPAEiC4XeR/QprlOLCQLvjwQ5A1A5qXxEOFqblZDE32D0/46DvQran2bL6KmpbzxVG89F4D6XsIGzC0zVheBI2hHQwotROWh7mf2vu1fl8tp9qEPl/8lU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2349.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:188::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:35:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:35:01 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v2 3/3] Documentation: PCI: Add PCI DMA endpoint function documentation
Date: Mon, 25 May 2026 15:34:56 +0900
Message-ID: <20260525063456.3317509-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525063456.3317509-1-den@valinux.co.jp>
References: <20260525063456.3317509-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2349:EE_
X-MS-Office365-Filtering-Correlation-Id: c12eb64d-3692-437c-3d10-08deba27bf23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|921020|3023799007|6133799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xkmfcfpGvy6C2zIovj0kFUupbtelK8+RRkMCJfJCUmVpLvaLy+Kc5YpFHlPkc86P3vnoy4V8awCC1t4lpfS2l/zQCywnJu+SpiifdFcvfPvRl8agEi+z60S3pJ5pFsBKTda+H1SPe+KzjwHnKuGz94m3d50mirhHzQRpvzvnzo1JD5jFCxfxbA7+iT2iNQTWDoy7Mmx9xnCyP2uYzfUMtMbSt/Eh7m1hHCmEhJ6L1Eq2Yj5Iudfe7w40r+kPvV5XQX2JXDubjK8JW19rWTClgVGEQJNM9uOZbpmMBUoZhfSs9Vw0nwEVcVzwLYoClDRFEdng3iTRk2koXbxY4Nr3JHkZs0U7TvWzG/p5iDGDGQnjbHRJNC7tLjj5lCuDupVBufrCqgt/LzuibaVtyx3ZqYWj4AnD0BUdg0lgvpc6xKYOplHFim6lIC07t1R21FTqVr1lST6LffWFLFYJNgrah4Xkphp006pjqf8jJNeAGbjZJvVZ24HHa56uPX5IVLXaQdyB6ExJ7logcqJ0XCsf/tLedJEQ/CyoMG0y4zpoYYJ/ONeWR2F+kiICtqWAKYFTH6FzYoF+Dy7RbsMlZ0GgHbPrJGAZOPgAImHM0qOi40cIULtxXP7nMLdyycYesTCbO1DuIdsK5zyQjHQcsvfrAgFne2fdJkYYtlPorlsOIAGq9RMybGQiIPW7dD9wrF3P3RFS7nqIv8s2O54etDcz43QWYx//Ki5O2KYqqG+r5bQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(3023799007)(6133799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c4wtolXRq4qfyM9a6nGOFqkbyfVDhKJShXCTMUlKZkjst1rusJC19oJbTODG?=
 =?us-ascii?Q?+X16fwZ//NQmQUdY0T+P1aR8F/SC39X2M9VDZ0aMHhKnm461Bpmxp0MCBlHQ?=
 =?us-ascii?Q?z4ljfh/7IAh/i1Vi45GEG4gucVoxJlWIDPKwbO2XHhgB0BP3VMHDhG2SOiDL?=
 =?us-ascii?Q?Gvy3hlYXTreHKQqZdzIqCGdb0sQdxF1oGg2NI1pnCDOiJPC9IbN5oeDJzICu?=
 =?us-ascii?Q?Cf2gYH9Z5k4kxP77hGuQg1tapBUnR9qO6QTxe6Sj+pdeMs2xq8FxmV7/S3a0?=
 =?us-ascii?Q?sXZtSSZyatmqwHfJVlCdGOsJDCK1jNDSsx6u6A9acvSpmknhK5qVh1vWLAzD?=
 =?us-ascii?Q?NXemM77yEU/ZJmAGwrRyUDDYQUZXTuZH72hUlJhua08hyemKoiu8LDMldv71?=
 =?us-ascii?Q?L9qPlTh+vuy3T74RQ3kaz/CezoV6QBWnIitufSNd6H2vI3pA6WLAjWJwLT2p?=
 =?us-ascii?Q?XKtzpVAv5H3QUumZbdTvDpzKT3UA18W0AQNW9mmOp5NjHs6Xihdsk82R76AT?=
 =?us-ascii?Q?uridEt2IT0B/jzurF6/SQhcS6E6MYWXmlquIukHvIkwAUsjw4Aud0EtqEpKF?=
 =?us-ascii?Q?M7KhZz9mQ+x4DY1+gwdFzST8kdqGd1joAxc13QhzTyTXID0z4jJPl9YqfpSM?=
 =?us-ascii?Q?MBThvrKuoX+TaMgKnL7doSteSc/FNVVZE4nFFFhpIs7XXNBYGh+DUpHn3He0?=
 =?us-ascii?Q?YlhO1AbNE92/3uBkE/1fgioIhZMjXqUKeGq2jyw+U1o0njYlceevwE51THim?=
 =?us-ascii?Q?yfV5iSajOR6cgZsc7W3Cck73pqN0yq+P/Rcz9IXmCELpMvYn4TIgso3OhMtS?=
 =?us-ascii?Q?izs66yh6dpHXaNmMg/R5FiF3+oGjU6rdwiscVX1quNQy0H5+VedwABYkq0KF?=
 =?us-ascii?Q?BTPdeQSrAjLRGoq3GWhfXiGkfEIrHblMI4okJbmxBoEueawM8hhaFAMdqP+1?=
 =?us-ascii?Q?xcqI2jzGidFkZaXGV+umDUVCoxJVZUKGz8vPRmqv/wd895xL72cEILVQ37qk?=
 =?us-ascii?Q?/PEyrr+aCIzaLk47LhCyXeQFvadwraYgReYWNEbFbMNpzRfhNK3URNMxCbBW?=
 =?us-ascii?Q?PNVf0wTkNgZ0Wp7343JIetWjALvoDRJuUKU9tWxL7CUR+TvEDzg++qoZNnnn?=
 =?us-ascii?Q?8Qvz3g2Zf7iCgNDWGSAZJ7x5hD3JdK0ARoPF1qNcAHk7KEjvl3JvAaHAT1Vh?=
 =?us-ascii?Q?QbbmJCfZHJat2AyUDS1cS3Qmaj1eWgj0oAZ7LHbdkiu/r6B7tHH4JqPG9p80?=
 =?us-ascii?Q?bPjkQfCqBNukixf0jsdcmCIKvbucFoY69w0JDcGRqdjq6ZJyO7aFzBqUypEI?=
 =?us-ascii?Q?qDNTs11OeSvc6vWm59kTsJCxtK8I4TqruvO/vGk4NeB8gO4+6xP8LJKx6xsP?=
 =?us-ascii?Q?aOrGNr3G3G+CeW1b1aeiS7VkVH/0j0h0LjXA5qh3AQjJKfo6NRz54PjfqrOp?=
 =?us-ascii?Q?FRVUHH+S3A4lEalE0+JE4sf9gc3uoIOE1kb84PxaXTg7qpPibuDmjMDP2qEw?=
 =?us-ascii?Q?uRpeBtwnzpNCWOFydwe8J6EsyQoXwxCll1KVdzYtLaRjXxt96U0RevFqIwT8?=
 =?us-ascii?Q?uSlKtJASi8pAMjCP+PLmaXZAWATbw+N1n8QHPa34Qn8N3g5TQnmr5zAIvzQK?=
 =?us-ascii?Q?2KgzWkUcU/AsU/y4eHvpyQWka/R1P+RW5vOoso6ZbdygeCJYXhBTfQNtdwkz?=
 =?us-ascii?Q?vlb4a+Sgd1iECP8ThJn5O0WZ8dgfmEK6qxK7XU6PJNEjvHpGlfoOzjsy67LP?=
 =?us-ascii?Q?iVddf3xrm8o0XNXzKeCpsJ9v/IsLdRQZ7QcEzdV3nN5ouNmpwXrn?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c12eb64d-3692-437c-3d10-08deba27bf23
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:35:00.7353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VhviiGqn61qIKQ9LTN5s63PcXolLfa/OzW1yHQDLx2b1jXL+4dnklLrFNHYuS6Z2CCAx4rwN11wOZiWJlqD4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2349
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10821-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 8986D5C685B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a function description and a user guide for pci-epf-dma. Describe
the BAR-resident metadata consumed by dw-edma-pcie, the configfs
attributes, endpoint controller requirements and the host-side DMAengine
usage model.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 Documentation/PCI/endpoint/index.rst          |   2 +
 .../PCI/endpoint/pci-dma-function.rst         | 182 ++++++++++++++++
 Documentation/PCI/endpoint/pci-dma-howto.rst  | 200 ++++++++++++++++++
 3 files changed, 384 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/pci-dma-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-dma-howto.rst

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index dd1f62e731c9..cd4107e02ec2 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -15,6 +15,8 @@ PCI Endpoint Framework
    pci-ntb-howto
    pci-vntb-function
    pci-vntb-howto
+   pci-dma-function
+   pci-dma-howto
    pci-nvme-function
 
    function/binding/pci-test
diff --git a/Documentation/PCI/endpoint/pci-dma-function.rst b/Documentation/PCI/endpoint/pci-dma-function.rst
new file mode 100644
index 000000000000..54caf4fafe00
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-dma-function.rst
@@ -0,0 +1,182 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+PCI DMA Function
+================
+
+:Author: Koichiro Den <den@valinux.co.jp>
+
+The PCI DMA endpoint function exposes an endpoint-integrated DMA controller
+to the PCI host as a PCI DMA controller.  A matching host-side driver
+discovers the endpoint DMA metadata and registers the delegated channels with
+the Linux DMAengine framework, so host DMAengine clients can submit
+transfers.
+
+An endpoint Linux system can already use an endpoint-integrated DMA
+controller locally through the normal DMAengine API, for example to transfer
+data between endpoint memory and host addresses reachable over PCI.  The PCI
+DMA function provides a different ownership model: it delegates selected
+local DMA channels to the host, so a host DMAengine client can request and
+program those endpoint-side channels through the host's DMAengine API.
+
+To make that possible, the endpoint function publishes the DMA controller
+register window and descriptor memory layout to the host, reserves the
+selected local DMA channels on the endpoint side, and lets the host program
+those channels directly.
+
+Constructs Used for Implementing DMA
+====================================
+
+The PCI DMA function uses the following endpoint-side resources and
+configuration:
+
+	1) DMA controller register window
+	2) DMA descriptor memory for endpoint-to-RC channels
+	3) DMA descriptor memory for RC-to-endpoint channels
+	4) MSI or MSI-X interrupt vectors selected through configfs
+	5) One endpoint BAR used to publish metadata
+	6) If needed, one endpoint BAR used for dynamically mapped DMA windows
+
+The endpoint controller reports the DMA controller register and descriptor
+resources through the endpoint auxiliary resource interface.  The PCI DMA
+function uses those descriptions to build the host-visible metadata and to map
+resources that are not already visible to the host.
+
+DMA Controller Register Window:
+-------------------------------
+
+It contains the DMA controller registers programmed by the host-side driver
+to submit transfers, control channels and handle DMA interrupts.
+
+DMA Descriptor Memory:
+----------------------
+
+It contains the descriptor memory used by the DMA controller.  The PCI DMA
+function exposes descriptor memory for the delegated endpoint-to-RC and
+RC-to-endpoint channels.
+
+MSI/MSI-X Interrupt Vectors:
+----------------------------
+
+They are used by the delegated DMA channels to signal completion and error
+conditions to the host-side driver.
+
+Metadata BAR:
+-------------
+
+It is the endpoint BAR used to publish the endpoint DMA metadata and handshake
+bits.  The BAR remains stable while the endpoint function programs the DMA
+windows.
+
+DMA Window BAR:
+---------------
+
+It is the endpoint BAR used for DMA resources that are not already visible
+through a fixed BAR.  The endpoint function may switch this BAR to subrange
+mapping after the host-side driver has found the metadata BAR.
+
+BAR Metadata
+============
+
+The endpoint function places a small metadata block at the beginning of the
+selected metadata BAR.  The format is defined in
+``include/linux/pci-ep-dma.h``.
+
+The host-side driver scans the function's assigned memory BARs, looks for the
+endpoint DMA metadata magic, requests DMA window programming, waits for the
+READY bit, and then parses the metadata to find the DMA register window and
+descriptor windows.
+
+::
+
+	+----------------------+ metadata BAR offset 0
+	| endpoint DMA metadata|
+	+----------------------+
+	| optional padding     |
+	+----------------------+
+
+	+----------------------+ DMA window BAR offset 0
+	| mapped DMA resources |
+	+----------------------+
+	| optional padding     |
+	+----------------------+
+
+The metadata can also reference resources that are already host-visible
+through fixed BARs.  For example, an endpoint controller may expose the DMA
+controller register window at a fixed BAR offset while descriptor memories
+are mapped into the DMA window BAR by the endpoint function.
+
+The metadata is BAR-resident instead of a self-contained PCI Vendor-Specific
+Extended Capability (VSEC).  Some endpoint controllers do not provide writable
+configuration-space backing storage large enough for a new VSEC payload, while
+they can map endpoint memory and controller resources into a BAR.
+
+Channel Ownership
+=================
+
+The ``wr_chans`` attribute exposes endpoint-to-RC DMA write channels.  The
+``rd_chans`` attribute exposes RC-to-endpoint DMA read channels.  The function
+reserves the selected endpoint-side DMAengine channels so that endpoint-side
+DMAengine clients cannot allocate and use the same hardware channels while
+they are delegated to the host.
+
+The current metadata revision describes channels in dense, zero-based order.
+For example, ``wr_chans = 2`` exposes write channels 0 and 1.  Skipping a
+hardware channel in the middle of the exposed range is not supported.
+
+The current DesignWare eDMA unroll and HDMA compatible support also requires
+each exposed direction to be delegated as a whole.  For example, on a controller
+with two write channels, ``wr_chans`` must be either 0 or 2.
+
+Interrupts
+==========
+
+The PCI DMA function exposes DMA interrupts through MSI or MSI-X.  The common
+endpoint function ``msi_interrupts`` and ``msix_interrupts`` configfs attributes
+select the interrupt vector counts programmed into endpoint config space.  At
+least one MSI or MSI-X vector must be configured before the function is bound
+to an endpoint controller.
+
+Transfer Addressing
+===================
+
+The host-side DMAengine client supplies the endpoint memory address as the
+DMA slave address.  For example, the ``dw-edma-pcie`` endpoint DMA metadata
+parser passes that slave address to the DMA controller as a raw endpoint-side
+address instead of translating it through a host PCI BAR resource.
+
+The host memory buffer used as the other side of the transfer is still mapped
+using the normal DMA mapping API on the host.
+
+Endpoint Controller Requirements
+================================
+
+The endpoint controller driver must expose the DMA controller register
+window and per-channel descriptor memories through the endpoint auxiliary
+resource API.  Endpoint controllers with other DMA register layouts also need
+matching metadata and host-side DMAengine driver support.
+
+If any DMA resource is not already host-visible through a fixed BAR, the
+endpoint controller must also support BAR subrange mapping and dynamic inbound
+mapping, because the DMA window BAR is assembled from those resources.
+
+Current Support
+===============
+
+The current host-side support is implemented in ``dw-edma-pcie`` for
+DesignWare eDMA unroll and HDMA compatible layouts.  Other PCIe controller
+DMA implementations need corresponding host-side DMAengine driver support.
+
+The ``dw-edma-pcie`` PCI ID table does not contain a generic endpoint DMA PCI
+ID entry.  Users need to bind the host-side driver explicitly using
+``driver_override``.
+
+The current metadata revision requires the exposed channels to be a dense
+prefix of the hardware channel numbers.
+
+Security Model
+==============
+
+The interface is intended for trusted endpoint/host deployments.  A delegated
+DMA channel can access endpoint memory addresses supplied by a host DMAengine
+client.
diff --git a/Documentation/PCI/endpoint/pci-dma-howto.rst b/Documentation/PCI/endpoint/pci-dma-howto.rst
new file mode 100644
index 000000000000..84f322881aa7
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-dma-howto.rst
@@ -0,0 +1,200 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================================
+PCI DMA Endpoint Function (EPF) User Guide
+==========================================
+
+:Author: Koichiro Den <den@valinux.co.jp>
+
+This guide shows how to configure the ``pci-epf-dma`` endpoint function driver.
+It uses ``dw-edma-pcie`` as the currently available host-side driver.  For the
+hardware model and layout see Documentation/PCI/endpoint/pci-dma-function.rst.
+
+Endpoint Device
+===============
+
+Endpoint Controller Devices
+---------------------------
+
+To find the list of endpoint controller devices in the system::
+
+	# ls /sys/class/pci_epc/
+	e65d0000.pcie-ep
+
+If ``PCI_ENDPOINT_CONFIGFS`` is enabled::
+
+	# ls /sys/kernel/config/pci_ep/controllers
+	e65d0000.pcie-ep
+
+Endpoint Function Drivers
+-------------------------
+
+To find the list of endpoint function drivers in the system::
+
+	# ls /sys/bus/pci-epf/drivers
+	pci_epf_dma  pci_epf_test
+
+If ``PCI_ENDPOINT_CONFIGFS`` is enabled::
+
+	# ls /sys/kernel/config/pci_ep/functions
+	pci_epf_dma  pci_epf_test
+
+Creating pci-epf-dma Device
+---------------------------
+
+Create a ``pci-epf-dma`` device with configfs::
+
+	# mount -t configfs none /sys/kernel/config
+	# cd /sys/kernel/config/pci_ep/
+	# mkdir functions/pci_epf_dma/dma0
+
+The "mkdir dma0" above creates the ``pci-epf-dma`` function device that will
+be probed by the ``pci_epf_dma`` driver.
+
+The PCI endpoint framework populates the directory with the common
+configurable fields::
+
+	# ls functions/pci_epf_dma/dma0
+	baseclass_code   msi_interrupts   progif_code    subsys_id
+	cache_line_size  msix_interrupts  revid          subsys_vendor_id
+	deviceid         pci_epf_dma.0    secondary      vendorid
+	interrupt_pin    primary          subclass_code
+
+The PCI DMA function driver also creates a function-specific sub-directory.
+The numeric suffix depends on the endpoint function instance number::
+
+	# ls functions/pci_epf_dma/dma0/pci_epf_dma.0/
+	dma_window_bar  metadata_bar  rd_chans  wr_chans
+
+Configuring pci-epf-dma Device
+------------------------------
+
+The host-side ``dw-edma-pcie`` PCI ID table does not contain a generic
+endpoint DMA PCI ID entry.  Choose a PCI vendor/device ID for the endpoint
+device::
+
+	# echo <vendor-id> > functions/pci_epf_dma/dma0/vendorid
+	# echo <device-id> > functions/pci_epf_dma/dma0/deviceid
+	# echo 1 > functions/pci_epf_dma/dma0/msi_interrupts
+
+The PCI class defaults to ``PCI_BASE_CLASS_SYSTEM`` and
+``PCI_CLASS_SYSTEM_DMA``.
+
+The function-specific attributes are:
+
+============== ============================================================
+Attribute      Description
+============== ============================================================
+metadata_bar   BAR used to publish the endpoint DMA metadata and handshake
+               bits.  It is kept as a stable BAR while the DMA windows are
+               programmed.  If this is left unset, the first usable BAR that
+               does not already contain a fixed DMA resource is used.
+dma_window_bar BAR used for DMA resources that are not already host-visible,
+               such as the DMA register window or descriptor windows.  This
+               BAR may be switched to subrange mapping after the host driver
+               has found the metadata.  If this is left unset and a DMA
+               window is needed, the first usable BAR different from
+               ``metadata_bar`` and not already occupied by a fixed DMA
+               resource is used.
+wr_chans       Number of endpoint-to-RC DMA write channels to expose.
+rd_chans       Number of RC-to-endpoint DMA read channels to expose.
+============== ============================================================
+
+A sample configuration for a DesignWare eDMA/HDMA compatible controller with
+two write channels and two read channels is given below::
+
+	# echo 0 > functions/pci_epf_dma/dma0/pci_epf_dma.0/metadata_bar
+	# echo 2 > functions/pci_epf_dma/dma0/pci_epf_dma.0/dma_window_bar
+	# echo 2 > functions/pci_epf_dma/dma0/pci_epf_dma.0/wr_chans
+	# echo 2 > functions/pci_epf_dma/dma0/pci_epf_dma.0/rd_chans
+
+``wr_chans`` and ``rd_chans`` default to 0.  At least one channel direction
+must be configured.  The selected channels are exposed in dense, zero-based
+order; for example, ``wr_chans = 2`` exposes write channels 0 and 1.
+Current DesignWare eDMA unroll and HDMA compatible support requires each
+exposed direction to be delegated as a whole, so set a direction to either 0 or
+the number of hardware channels in that direction.  If ``dma_window_bar`` is
+configured, it must be different from ``metadata_bar``.
+
+The common ``msi_interrupts`` and ``msix_interrupts`` attributes select the
+number of MSI and MSI-X vectors exposed to the host.  At least one MSI or
+MSI-X vector must be configured.
+
+The function-specific attributes can only be changed before the endpoint
+function is bound to an endpoint controller.
+
+Binding pci-epf-dma Device to EP Controller
+-------------------------------------------
+
+The DMA function device should be attached to a PCI endpoint controller
+connected to the host::
+
+	# ln -s controllers/e65d0000.pcie-ep \
+		functions/pci_epf_dma/dma0/primary/
+
+Once the above step is completed, the PCI endpoint controller is ready to
+establish a link with the host.
+
+Start the Link
+--------------
+
+Start the endpoint controller by writing 1 to ``start``::
+
+	# echo 1 > controllers/e65d0000.pcie-ep/start
+
+Root Complex Device
+===================
+
+lspci Output
+------------
+
+Note that the device listed here corresponds to the values populated in the
+endpoint configuration above::
+
+	# lspci -nk
+	01:00.1 0801: <vendor-id>:<device-id>
+
+If the host was already running while the endpoint function was configured,
+rescan the PCI bus after the endpoint side has completed the configfs setup
+and started the endpoint controller, if the platform supports it.
+
+Bind the endpoint DMA function to ``dw-edma-pcie`` explicitly with
+``driver_override``::
+
+	# modprobe dw_edma_pcie
+	# echo dw-edma-pcie > /sys/bus/pci/devices/0000:01:00.1/driver_override
+	# echo 0000:01:00.1 > /sys/bus/pci/drivers_probe
+
+The device should then be bound to ``dw-edma-pcie``::
+
+	# lspci -nk -s 01:00.1
+	01:00.1 0801: <vendor-id>:<device-id>
+		Kernel driver in use: dw-edma-pcie
+
+Using pci-epf-dma Device
+------------------------
+
+The host side software uses the standard Linux DMAengine API.  A DMAengine
+client driver running on the host must request one of the channels provided by
+``dw-edma-pcie`` and submit a transfer.
+
+For an endpoint-to-RC write transfer, the DMAengine client uses a host DMA
+buffer as the destination and an endpoint-side address as the slave source
+address.  For an RC-to-endpoint read transfer, the DMAengine client uses a
+host DMA buffer as the source and an endpoint-side address as the slave
+destination address.
+
+Troubleshooting
+===============
+
+``pci-epf-dma`` requires endpoint controller support for DMA auxiliary
+resources and MSI or MSI-X.  If any DMA resource must be mapped dynamically,
+the endpoint controller must also support BAR subrange mapping and dynamic
+inbound mapping.  Binding the function to an endpoint controller fails if the
+required capabilities are not available, or if both ``msi_interrupts`` and
+``msix_interrupts`` are zero.
+
+If ``dw-edma-pcie`` fails to probe on the host, check that the endpoint was
+bound to the host driver, that the endpoint BARs were assigned by PCI
+enumeration, and that the endpoint DMA metadata READY bit was set after any
+DMA window BAR submaps were programmed.
-- 
2.51.0


