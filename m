Return-Path: <dmaengine+bounces-9409-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI7CDAbwsmnAQwAAu9opvQ
	(envelope-from <dmaengine+bounces-9409-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:55:34 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D34276104
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85E9A3069A83
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 16:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6911C3FEB19;
	Thu, 12 Mar 2026 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="OrFWaAU9"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021104.outbound.protection.outlook.com [40.107.74.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51283FE64E;
	Thu, 12 Mar 2026 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334255; cv=fail; b=ePY9mEvaVe+r6m4U/IJryv+t07WwlxdrF5XDm1/X2rsvdtmYp8mHyslBNq9Fz3tk4ArlP1EMDnnGw9hxjYgnoPCltQa0vg33ysF52tOsIsGYLyea657FJxu7rZ4Buab3ovsZ+KOB+S4Vq0HpIDa/g+CDsxAirXUGiPWZZUD7s7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334255; c=relaxed/simple;
	bh=zOtmN7bgn8wrv8BgGU5EjdpZbF5KkEwLII+VGmU22ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qnFw/A/txHQ7TETq0U4R7a6KBUCVJof3XVYPn8IErj1a2ynCKEGDWGtSMQVcPaxubiR+Aa1pRXmrbJyB7TOVxE7txRQlmtMOCl1vnBp0ijFThYpS9Db0R26//zaG8eh+zHvWZc4fStewtaxXrGbC+1vs2fnVLu1PVckT5CF5lLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=OrFWaAU9; arc=fail smtp.client-ip=40.107.74.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtmDKAHswcDuBoJJ4QkG5Bzo1AzS9w+8NRR4R6avNB9nypIvOtnnzu2yI/lKzSiB20kqwTxz8XtP3jXvKoxqAW7QjUMpaqftt4YF5IeD51EMjdpdz4ahg0BLRjfq8sl6SqLJ6hBKrpvRhwL6EnSth+MAGSRAi3/RZui7zi11+gw5TFd/DniFUf4MM7cy1XZmM43FdB04bHKyqOBNWLKew+Kd5aAk3JhELdgGF2kHK/+1c4I9ljSwyGnryWkGokegG+VU3RVekaXM2WUhatlpIhqu7qFyPVO+JnGagFuqklWSBMKRwUi2oNtbDipKU91e+d+WkcGU1zriOoy718ASsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVIEhD1RtLihjpQ6O8INqXxlmVQlEfcztazzmrUVJ1Q=;
 b=qZ5g2C27QY0h4s0LKzts5RfuBI2HbKGp8GfQCb6Gmvk5lYD32b64VA+8PQGcyYecMNEFgVZ5dLudc9nDf8OIEKbcE0DFd+UmsxyKwk16LPvzjUaSbwdyrInyrSOOYWqc+4ZDq0vHtNd0V1YAfpKkRyYepZ2+8qTsOsKhu14kMHTO1xxmT8nh7O8qd37c/YUp8C8tpdR1dHDN36Qf5inDFqncTXzvf8v6aJv4cB9vNlupzfHhdoendWJ9pTFhOn3uap7xBnGWR20cfW9Fwj8YB3mAcOXAL8RDjQfl+M+e9yNGhp3CSwxAAE+75N5kkBlJyOB59YZSdLCA5Blc7h/S2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVIEhD1RtLihjpQ6O8INqXxlmVQlEfcztazzmrUVJ1Q=;
 b=OrFWaAU9hUR87DLUGPzsC2mLTqacsocZTgyGQUCGHOFTM/+qjkbovKcgSUtIwfyUjVD8zbsi4V197wmzELlkAtIi5N9fLKMq6HqESvZOEXsgGx/+slnrhLaT8I7H1Y2v/Gud9Q2MF77mm8uYMGaoi2tRcyEo095YMdlM+lXOeXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2018.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:50:22 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 16:50:22 +0000
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
Subject: [PATCH 14/15] NTB: Add ntb_ep_dma test client
Date: Fri, 13 Mar 2026 01:50:04 +0900
Message-ID: <20260312165005.1148676-15-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312165005.1148676-1-den@valinux.co.jp>
References: <20260312165005.1148676-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0067.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d45b3fe-eb2c-47d5-dcac-08de80577393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	B95p9se05BW1MWD9pjT6Du9w41UY5EPqSjJOzgaO2IFNMVBPef+6YiP+FLUfPrts+yFulkzTx1QNArzLjInPRe6+hB3MZrXFXNLvtx+c+PdM3OZSPUtLMHAQzz9SYWp3HAJdi+C7RoSjKJyBTAtLUfROSTjNaMYC97VoxZRYcfuKGu8HfOk3jgNcLMzUmbtzTU5yrAgLUi9bDvlPw8bJIY6bRirJflex+9gsvXKu2LsB7JuOIaWajMq55AyYl48boehQJGeZA+hQoGbcAVtreazeABlbVgVFOHcAfXSmeOHtC+45gezIucjs4jVJHieXBhJYOQqSRh9E9Vxg/vtfr15yDD+8LSPTbN3mW7USLaTQkNm6UTPLvI8xGF6NWrB0jHc5OPdg346Ur2G1NEO0ogQlBTBjuYU7jwFaUprKmr7AKarIoVomqn4qTOs4eb+SL0cl5akJUahLOjJlzdSPSbwhCYL7BucG4BsZtUdYZzOUdqVkFq4w9zsl93EFMIlICFfFNQL5r4Qlusq9qfR1/Ucsw4zKKJ/ejrioFM9b19f3neg3fpuTTlAe8/muyk3w9LXQKrL21RB/9GQcQvdviPJCAIKoWpFUoNnRaoLp4zdrfNsHRQJLzF67rVL3CnL49xydEFYeKRaWgTAY3xA/u/dJPuh/j3D+Hf8Y1M37MVRrz3eCo0B/EMGn9qhTDra4x0lx2p5nrVTIwWRPXabClC6TjOuQPgjo3SdiP3zSQYoJ8iWTIzf9asZJMTVgK7snUTm7atknRvhLUt1StgaTmQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Osf2VeU6zgYLXhAjXO+yQMYV9RHe8kCGGnwf1dIKCWNrZg253FIpalOUnq0s?=
 =?us-ascii?Q?Xtwje9CRaUyfRu5D6A2IDZ+p+6wIb5VVoE9jg6pMoCzD+nu3cayi608D41ku?=
 =?us-ascii?Q?UESJivc2iy8Lh987784OIOZ0nWqff+PJwLkaA5d7bZ3t2tBSB4FwDIDUwydo?=
 =?us-ascii?Q?O8dqCctoF4VnXBGRP3so/UVHeiLOuQVA03nJW4pnLcksdiE2I078EIkhHpeD?=
 =?us-ascii?Q?AC3la56GhJQnvNBGR8eqWK7WcHL7m3N/Y8PC37VKbpjfSvQJA/Mg9rb0GdaA?=
 =?us-ascii?Q?9W3JBYI0uuqSDPyrIzF+TiWLSqYxHi6N5yzZEqy5nqQsy4qvz0vkYkbViqIQ?=
 =?us-ascii?Q?3CrR/06ljnhfcKkImQ+bFDg91C4FBBmdAD1I85MHbozjPh4+YQPIPwl9z5KK?=
 =?us-ascii?Q?Hx9hbBlZORI4+8k0/pUuz8oHKIDfKXq996pTgOIUquxFv19DeBJIYjtBVs9o?=
 =?us-ascii?Q?2U6YtgKNNg5owjsfi8dQmvm5vmtNcuVVBYVo3cXGyHvFQzdgvNfrk2b6ZB9A?=
 =?us-ascii?Q?PDmqszXwalT5RPvUE3brvWMN3t9mv96L+vXQ7FOhF4x4nrFp5B9UWbJ0ySy5?=
 =?us-ascii?Q?kyyUm+yEJAcvEgjVF7Lg03Lr5oTSKe3a4z81bK3zLazTAvdxE+4PhjBf8ZV8?=
 =?us-ascii?Q?eKz/PV9Nq+wQtscfjT2P4qbVxqfuIsHHzvDUGDPWBaJLnbdD/7KWfggEfPYg?=
 =?us-ascii?Q?OYKLMnkImn0RdnPRQ7nOEhPFnGgt2V37LMrlGVNFtqae6wy+VgiEN4owCIzD?=
 =?us-ascii?Q?9U9H/vKZ58288FyevSNjSFSLo4fJsDJMWj/OQSj6TMZ1JPxmQrA+Dw/AZTFi?=
 =?us-ascii?Q?hYbfwC/46vOQV5gYGiET2h8TA7E1pjaHM3xCpWiwzAQur8946m+RWnrrAni0?=
 =?us-ascii?Q?pb7TPv5XZSuqL87oLy5gMYb+dTI9yf2I1egiMSCy1mzeTfnfh4ZvBt4v3Rpd?=
 =?us-ascii?Q?vanYcGzL49h/wS2EwqQGg3eetBKCpTJxN9QOxKTgevOtJZFxfGpLIM2gpvG5?=
 =?us-ascii?Q?xwBBMCmLdh+t7nDsc/ZEL94JDq+NP9N1Y+79RPIfVIoSdm1BQ1owu3xw0GkY?=
 =?us-ascii?Q?TBfmLsUp/bNUCdvGq3erT+tiZj6Jw2BX+DfdotA0GuwnI6tCsb0ClReHgSVN?=
 =?us-ascii?Q?JJWjtNVYc/VSzkPb5DqesUD3UAyRZXTirVoaBKIS/e7npb8eqDzfAC27CtyP?=
 =?us-ascii?Q?ks5SBmojU66Pdp5/pNXa4SevdRmZItzPxPSqRYAugdRTQ+jn/O7ZnkpLIYfL?=
 =?us-ascii?Q?ajf6bcWaFWOt5iniVylw1kJMaud0tR3b/UKF6z9DF9jbig6Aw2H9/xs6XuNh?=
 =?us-ascii?Q?v7JNn/PtGPrUJZIaSeecJo6u/XyhUyvjdj7brfCOj65X16nK3qeekgZHqFB2?=
 =?us-ascii?Q?vFYIYhfY0rSHNI0iaP5p3Cuw+4/nLzH563dy2GuqTpezdsnWpouIC76UKWJq?=
 =?us-ascii?Q?yWUT8M1xTpdF9823f/ksEGXSfEmnOXcWn1qionOyyTNFLljwTR66htsqs76w?=
 =?us-ascii?Q?ok1tRw8uvH0ImrUgJ09afwK9o2gbqZ+xCHnOFOUyVVKC7wfpm84TiGRf//Pj?=
 =?us-ascii?Q?3Sl8Y7NpqnljzX/EiK+Ttyo1xkgFyWLUp/NgNJcl5U/xeqlt+nfpTbbfz32M?=
 =?us-ascii?Q?xCBL3ur0Ri3+00nNUrSjAKpWrLr3p+aSy9ZJ51i23yIeISmJaY67Lsl9rHgz?=
 =?us-ascii?Q?NvGy95y1yFB2ZBA1+Ln/MkBRIu1ogZjAhzTZMlHLcJO3uVk1hvsNd8TuL+Zl?=
 =?us-ascii?Q?+umvoKdvrPpWNmwyr+rS6iLbSwWM7WwtqPC7iIhKaJOokbvW/iSF?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d45b3fe-eb2c-47d5-dcac-08de80577393
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:50:22.3555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6vMGW71s3iKFXvuPzb/2JucBlk7EdmcG7VooEisNJATBy2n9V5hedEoEOz3P80w5jMLhWO2FliJXJ+CkARzig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2018
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9409-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,lwn.net,linuxfoundation.org,kudzu.us,intel.com,gmail.com,tkos.co.il,baylibre.com];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 16D34276104
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a small NTB client that exercises an endpoint-integrated DMA engine
exported through vNTB.

Both peers allocate a coherent test buffer and publish its DMA address
and size through scratchpads. The initiator requests the remote DMA
engine provider and uses it to transfer a known pattern into the
peer-published buffer. The responder verifies the contents locally and
reports PASS or FAIL back through scratchpads and a doorbell.

Expose ready, run, and result files in debugfs to make the flow easy to
trigger during bring-up.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/test/Kconfig      |  10 +
 drivers/ntb/test/Makefile     |   1 +
 drivers/ntb/test/ntb_ep_dma.c | 695 ++++++++++++++++++++++++++++++++++
 3 files changed, 706 insertions(+)
 create mode 100644 drivers/ntb/test/ntb_ep_dma.c

diff --git a/drivers/ntb/test/Kconfig b/drivers/ntb/test/Kconfig
index 516b991f33b9..30d0fede968c 100644
--- a/drivers/ntb/test/Kconfig
+++ b/drivers/ntb/test/Kconfig
@@ -35,3 +35,13 @@ config NTB_MSI_TEST
 	  send MSI interrupts between peers.
 
 	  If unsure, say N.
+
+config NTB_EP_DMA
+	tristate "NTB EP DMA Test Client"
+	help
+	  This test client demonstrates the use of an endpoint-integrated DMA
+	  engine exported through vNTB. It is intended as a simple bring-up and
+	  end-to-end validation tool for the remote-DMA discovery and transfer
+	  path.
+
+	  If unsure, say N.
diff --git a/drivers/ntb/test/Makefile b/drivers/ntb/test/Makefile
index 19ed91d8a3b1..f5bd0a85d4c8 100644
--- a/drivers/ntb/test/Makefile
+++ b/drivers/ntb/test/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_NTB_PINGPONG) += ntb_pingpong.o
 obj-$(CONFIG_NTB_TOOL) += ntb_tool.o
 obj-$(CONFIG_NTB_PERF) += ntb_perf.o
 obj-$(CONFIG_NTB_MSI_TEST) += ntb_msi_test.o
+obj-$(CONFIG_NTB_EP_DMA) += ntb_ep_dma.o
diff --git a/drivers/ntb/test/ntb_ep_dma.c b/drivers/ntb/test/ntb_ep_dma.c
new file mode 100644
index 000000000000..7cee158369a1
--- /dev/null
+++ b/drivers/ntb/test/ntb_ep_dma.c
@@ -0,0 +1,695 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+
+#include <linux/cleanup.h>
+#include <linux/completion.h>
+#include <linux/debugfs.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/ntb.h>
+#include <linux/pci.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/uaccess.h>
+#include <linux/workqueue.h>
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_VERSION("1.0");
+MODULE_AUTHOR("Koichiro Den <den@valinux.co.jp>");
+MODULE_DESCRIPTION("Test for using EPC-integrated DMA engine remotely");
+
+#define NTB_EP_DMA_BUF_LEN	SZ_4K
+#define NTB_EP_DMA_TIMEOUT_MS	5000
+#define NTB_EP_DMA_TIMEOUT	msecs_to_jiffies(NTB_EP_DMA_TIMEOUT_MS)
+
+#define NTB_EP_DMA_SPAD_STATE		0
+#define NTB_EP_DMA_SPAD_ADDR_LO	1
+#define NTB_EP_DMA_SPAD_ADDR_HI	2
+#define NTB_EP_DMA_SPAD_SIZE		3
+#define NTB_EP_DMA_SPAD_SEQ		4
+#define NTB_EP_DMA_SPAD_XFER_LEN	5
+#define NTB_EP_DMA_SPAD_CNT		6
+
+/*
+ * Test protocol:
+ *   - both peers publish a local coherent buffer through scratchpads and
+ *     ring a doorbell when READY
+ *   - the initiator submits one transfer through the remote DMA provider
+ *   - the responder verifies the pattern locally and reports PASS/FAIL
+ *     back through scratchpads and a doorbell
+ */
+enum ntb_ep_dma_state {
+	NTB_EP_DMA_ST_INIT = 0,
+	NTB_EP_DMA_ST_READY,
+	NTB_EP_DMA_ST_XFER_DONE,
+	NTB_EP_DMA_ST_PASS,
+	NTB_EP_DMA_ST_FAIL,
+};
+
+struct ntb_ep_dma_peer {
+	dma_addr_t dma_addr;
+	u32 size;
+	u32 state;
+	u32 seq;
+	u32 xfer_len;
+};
+
+struct ntb_ep_dma_ctx {
+	struct ntb_dev *ntb;
+	struct dentry *dbgfs_dir;
+	/* Serialize userspace-triggered runs through debugfs. */
+	struct mutex run_lock;
+	/* Protect peer state and completion sequencing shared with db_event. */
+	spinlock_t lock;
+	struct work_struct setup_work;
+	struct work_struct verify_work;
+	struct completion peer_ready;
+	struct completion xfer_done;
+
+	struct device *buf_dev;
+	void *buf;
+	dma_addr_t buf_dma;
+	size_t buf_size;
+
+	struct ntb_ep_dma_peer peer;
+	u32 local_seq;
+	u32 done_seq;
+	u32 verify_seq;
+	u32 verify_len;
+	u32 verified_seq;
+
+	size_t last_len;
+	int last_status;
+};
+
+static struct dentry *ntb_ep_dma_dbgfs_topdir;
+
+static const char *ntb_ep_dma_state_name(u32 state)
+{
+	switch (state) {
+	case NTB_EP_DMA_ST_INIT:
+		return "init";
+	case NTB_EP_DMA_ST_READY:
+		return "ready";
+	case NTB_EP_DMA_ST_XFER_DONE:
+		return "xfer-done";
+	case NTB_EP_DMA_ST_PASS:
+		return "pass";
+	case NTB_EP_DMA_ST_FAIL:
+		return "fail";
+	default:
+		return "unknown";
+	}
+}
+
+static void ntb_ep_dma_fill_pattern(void *buf, size_t len)
+{
+	u8 *ptr = buf;
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		ptr[i] = (u8)i;
+}
+
+static int ntb_ep_dma_verify_pattern(const void *buf, size_t len)
+{
+	const u8 *ptr = buf;
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (ptr[i] != (u8)i)
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static int ntb_ep_dma_signal_peer(struct ntb_ep_dma_ctx *ctx)
+{
+	return ntb_peer_db_set(ctx->ntb, BIT_ULL(ntb_port_number(ctx->ntb)));
+}
+
+static int ntb_ep_dma_publish(struct ntb_ep_dma_ctx *ctx, u32 state, u32 seq,
+			      u32 xfer_len)
+{
+	int ret;
+
+	ret = ntb_spad_write(ctx->ntb, NTB_EP_DMA_SPAD_STATE, state);
+	if (ret)
+		return ret;
+
+	ret = ntb_spad_write(ctx->ntb, NTB_EP_DMA_SPAD_ADDR_LO,
+			     lower_32_bits(ctx->buf_dma));
+	if (ret)
+		return ret;
+
+	ret = ntb_spad_write(ctx->ntb, NTB_EP_DMA_SPAD_ADDR_HI,
+			     upper_32_bits(ctx->buf_dma));
+	if (ret)
+		return ret;
+
+	ret = ntb_spad_write(ctx->ntb, NTB_EP_DMA_SPAD_SIZE, ctx->buf_size);
+	if (ret)
+		return ret;
+
+	ret = ntb_spad_write(ctx->ntb, NTB_EP_DMA_SPAD_SEQ, seq);
+	if (ret)
+		return ret;
+
+	return ntb_spad_write(ctx->ntb, NTB_EP_DMA_SPAD_XFER_LEN, xfer_len);
+}
+
+static struct ntb_ep_dma_peer
+ntb_ep_dma_read_peer(struct ntb_ep_dma_ctx *ctx)
+{
+	struct ntb_ep_dma_peer peer;
+	u32 hi, lo;
+
+	peer.state = ntb_peer_spad_read(ctx->ntb, 0, NTB_EP_DMA_SPAD_STATE);
+	lo = ntb_peer_spad_read(ctx->ntb, 0, NTB_EP_DMA_SPAD_ADDR_LO);
+	hi = ntb_peer_spad_read(ctx->ntb, 0, NTB_EP_DMA_SPAD_ADDR_HI);
+	peer.dma_addr = ((u64)hi << 32) | lo;
+	peer.size = ntb_peer_spad_read(ctx->ntb, 0, NTB_EP_DMA_SPAD_SIZE);
+	peer.seq = ntb_peer_spad_read(ctx->ntb, 0, NTB_EP_DMA_SPAD_SEQ);
+	peer.xfer_len = ntb_peer_spad_read(ctx->ntb, 0,
+					   NTB_EP_DMA_SPAD_XFER_LEN);
+
+	return peer;
+}
+
+static bool ntb_ep_dma_filter(struct dma_chan *chan, void *data)
+{
+	struct ntb_ep_dma_ctx *ctx = data;
+	struct device *dev;
+
+	dev = dmaengine_get_dma_device(chan);
+	if (!dev || !dev->parent)
+		return false;
+
+	return dev == ntb_get_dma_dev(ctx->ntb);
+}
+
+static void ntb_ep_dma_done(void *arg)
+{
+	complete(arg);
+}
+
+static int ntb_ep_dma_submit_xfer(struct ntb_ep_dma_ctx *ctx,
+				  dma_addr_t peer_dma, size_t len)
+{
+	struct dma_async_tx_descriptor *tx;
+	struct dma_slave_config cfg = {};
+	struct completion done;
+	struct device *dma_dev;
+	struct dma_chan *chan;
+	dma_cap_mask_t mask;
+	dma_cookie_t cookie;
+	dma_addr_t src_dma;
+	void *src_buf;
+	int ret = 0;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	dma_cap_set(DMA_PRIVATE, mask);
+
+	chan = dma_request_channel(mask, ntb_ep_dma_filter, ctx);
+	if (!chan)
+		return -ENODEV;
+
+	dma_dev = ntb_get_dma_dev(ctx->ntb);
+	if (!dma_dev) {
+		ret = -ENODEV;
+		goto err_release_chan;
+	}
+
+	src_buf = dma_alloc_coherent(dma_dev, len, &src_dma, GFP_KERNEL);
+	if (!src_buf) {
+		ret = -ENOMEM;
+		goto err_release_chan;
+	}
+
+	ntb_ep_dma_fill_pattern(src_buf, len);
+	dma_wmb();
+
+	cfg.dst_addr = peer_dma;
+	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.direction = DMA_MEM_TO_DEV;
+
+	ret = dmaengine_slave_config(chan, &cfg);
+	if (ret)
+		goto err_free_src;
+
+	tx = dmaengine_prep_slave_single(chan, src_dma, len,
+					 DMA_MEM_TO_DEV,
+					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!tx) {
+		ret = -EIO;
+		goto err_free_src;
+	}
+
+	init_completion(&done);
+	tx->callback = ntb_ep_dma_done;
+	tx->callback_param = &done;
+
+	cookie = dmaengine_submit(tx);
+	ret = dma_submit_error(cookie);
+	if (ret)
+		goto err_free_src;
+
+	dma_async_issue_pending(chan);
+
+	if (!wait_for_completion_timeout(&done, NTB_EP_DMA_TIMEOUT)) {
+		ret = -ETIMEDOUT;
+		dmaengine_terminate_sync(chan);
+	}
+
+err_free_src:
+	dma_free_coherent(dma_dev, len, src_buf, src_dma);
+err_release_chan:
+	dma_release_channel(chan);
+
+	return ret;
+}
+
+static void ntb_ep_dma_verify_work(struct work_struct *work)
+{
+	struct ntb_ep_dma_ctx *ctx =
+			container_of(work, struct ntb_ep_dma_ctx, verify_work);
+	u32 seq, len, state;
+	int ret;
+
+	scoped_guard(spinlock_irqsave, &ctx->lock) {
+		seq = ctx->verify_seq;
+		len = ctx->verify_len;
+	}
+
+	if (!ctx->buf || len > ctx->buf_size)
+		ret = -EMSGSIZE;
+	else
+		ret = ntb_ep_dma_verify_pattern(ctx->buf, len);
+
+	state = ret ? NTB_EP_DMA_ST_FAIL : NTB_EP_DMA_ST_PASS;
+
+	scoped_guard(spinlock_irqsave, &ctx->lock) {
+		ctx->verified_seq = seq;
+		ctx->last_status = ret;
+		ctx->last_len = len;
+	}
+
+	ret = ntb_ep_dma_publish(ctx, state, seq, len);
+	if (!ret)
+		ret = ntb_ep_dma_signal_peer(ctx);
+	if (ret)
+		dev_err(&ctx->ntb->dev, "failed to publish verify result: %d\n",
+			ret);
+}
+
+static void ntb_ep_dma_try_capture_peer_ready(struct ntb_ep_dma_ctx *ctx)
+{
+	struct ntb_ep_dma_peer peer = ntb_ep_dma_read_peer(ctx);
+
+	guard(spinlock_irqsave)(&ctx->lock);
+
+	ctx->peer = peer;
+	if (peer.state >= NTB_EP_DMA_ST_READY &&
+	    peer.dma_addr && peer.size)
+		complete_all(&ctx->peer_ready);
+}
+
+static void ntb_ep_dma_setup_work(struct work_struct *work)
+{
+	struct ntb_ep_dma_ctx *ctx =
+			container_of(work, struct ntb_ep_dma_ctx, setup_work);
+	struct device *dma_dev;
+	int ret;
+
+	if (!ntb_link_is_up(ctx->ntb, NULL, NULL))
+		return;
+
+	if (!ctx->buf) {
+		dma_dev = ntb_get_dma_dev(ctx->ntb);
+		if (!dma_dev) {
+			dev_err(&ctx->ntb->dev,
+				"no DMA mapping device available\n");
+			return;
+		}
+
+		ctx->buf = dma_alloc_coherent(dma_dev, ctx->buf_size,
+					      &ctx->buf_dma, GFP_KERNEL);
+		if (!ctx->buf)
+			return;
+
+		ctx->buf_dev = dma_dev;
+	}
+
+	memset(ctx->buf, 0, ctx->buf_size);
+	reinit_completion(&ctx->peer_ready);
+
+	ret = ntb_ep_dma_publish(ctx, NTB_EP_DMA_ST_READY, 0, 0);
+	if (ret)
+		goto err_free_buf;
+
+	ntb_ep_dma_try_capture_peer_ready(ctx);
+
+	ret = ntb_ep_dma_signal_peer(ctx);
+	if (ret)
+		goto err_free_buf;
+
+	return;
+
+err_free_buf:
+	dev_err(&ctx->ntb->dev, "failed to publish READY state: %d\n", ret);
+	dma_free_coherent(ctx->buf_dev, ctx->buf_size, ctx->buf, ctx->buf_dma);
+	ctx->buf = NULL;
+	ctx->buf_dev = NULL;
+	ctx->buf_dma = 0;
+}
+
+static void ntb_ep_dma_link_event(void *data)
+{
+	struct ntb_ep_dma_ctx *ctx = data;
+
+	if (!ntb_link_is_up(ctx->ntb, NULL, NULL))
+		return;
+
+	schedule_work(&ctx->setup_work);
+}
+
+static void ntb_ep_dma_db_event(void *data, int vec)
+{
+	struct ntb_ep_dma_ctx *ctx = data;
+	struct ntb_ep_dma_peer peer;
+	bool do_complete = false;
+	bool do_verify = false;
+	u64 db_bits;
+
+	db_bits = ntb_db_read(ctx->ntb);
+	if (!db_bits)
+		return;
+
+	ntb_db_clear(ctx->ntb, db_bits);
+
+	peer = ntb_ep_dma_read_peer(ctx);
+
+	scoped_guard(spinlock_irqsave, &ctx->lock) {
+		ctx->peer = peer;
+		if (peer.state >= NTB_EP_DMA_ST_READY && peer.dma_addr &&
+		    peer.size)
+			complete_all(&ctx->peer_ready);
+
+		if (peer.state == NTB_EP_DMA_ST_XFER_DONE &&
+		    peer.seq != ctx->verified_seq) {
+			ctx->verify_seq = peer.seq;
+			ctx->verify_len = peer.xfer_len;
+			do_verify = true;
+		} else if ((peer.state == NTB_EP_DMA_ST_PASS ||
+			    peer.state == NTB_EP_DMA_ST_FAIL) &&
+			   peer.seq == ctx->local_seq &&
+			   peer.seq != ctx->done_seq) {
+			ctx->done_seq = peer.seq;
+			do_complete = true;
+		}
+	}
+
+	if (do_verify)
+		schedule_work(&ctx->verify_work);
+	if (do_complete)
+		complete_all(&ctx->xfer_done);
+}
+
+static const struct ntb_ctx_ops ntb_ep_dma_ops = {
+	.link_event = ntb_ep_dma_link_event,
+	.db_event = ntb_ep_dma_db_event,
+};
+
+static int ntb_ep_dma_ready_get(void *data, u64 *ready)
+{
+	struct ntb_ep_dma_ctx *ctx = data;
+
+	*ready = completion_done(&ctx->peer_ready);
+	return 0;
+}
+
+static int ntb_ep_dma_ready_set(void *data, u64 ready)
+{
+	struct ntb_ep_dma_ctx *ctx = data;
+
+	return wait_for_completion_interruptible(&ctx->peer_ready);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(ntb_ep_dma_ready_fops, ntb_ep_dma_ready_get,
+			 ntb_ep_dma_ready_set, "%llu\n");
+
+static int ntb_ep_dma_result_show(struct seq_file *s, void *unused)
+{
+	struct ntb_ep_dma_ctx *ctx = s->private;
+	struct ntb_ep_dma_peer peer;
+
+	guard(spinlock_irqsave)(&ctx->lock);
+
+	peer = ctx->peer;
+
+	seq_printf(s, "last_status: %d\n", ctx->last_status);
+	seq_printf(s, "last_len: %zu\n", ctx->last_len);
+	seq_printf(s, "local_buf_dma: %#llx\n", ctx->buf_dma);
+	seq_printf(s, "local_buf_size: %zu\n", ctx->buf_size);
+	seq_printf(s, "peer_ready: %u\n", completion_done(&ctx->peer_ready));
+	seq_printf(s, "peer_state: %s\n", ntb_ep_dma_state_name(peer.state));
+	seq_printf(s, "peer_dma: 0x%llx\n", peer.dma_addr);
+	seq_printf(s, "peer_size: %u\n", peer.size);
+	seq_printf(s, "peer_seq: %u\n", peer.seq);
+	seq_printf(s, "peer_xfer_len: %u\n", peer.xfer_len);
+	seq_printf(s, "link_up: %u\n", !!ntb_link_is_up(ctx->ntb, NULL, NULL));
+
+	return 0;
+}
+
+static int ntb_ep_dma_result_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ntb_ep_dma_result_show, inode->i_private);
+}
+
+static int ntb_ep_dma_run_once(struct ntb_ep_dma_ctx *ctx)
+{
+	struct ntb_ep_dma_peer peer;
+	size_t len;
+	int status;
+	long ret;
+	u32 seq;
+
+	ret = wait_for_completion_interruptible_timeout(&ctx->peer_ready,
+							NTB_EP_DMA_TIMEOUT);
+	if (ret < 0)
+		return ret;
+	if (!ret)
+		return -ETIMEDOUT;
+
+	peer = ctx->peer;
+	scoped_guard(spinlock_irqsave, &ctx->lock) {
+		seq = ++ctx->local_seq;
+		ctx->done_seq = 0;
+	}
+
+	if (!peer.dma_addr || !peer.size)
+		return -ENXIO;
+
+	len = min_t(size_t, ctx->buf_size, peer.size);
+	if (!len)
+		return -EMSGSIZE;
+
+	reinit_completion(&ctx->xfer_done);
+
+	status = ntb_ep_dma_submit_xfer(ctx, peer.dma_addr, len);
+	if (status)
+		return status;
+
+	status = ntb_ep_dma_publish(ctx, NTB_EP_DMA_ST_XFER_DONE, seq, len);
+	if (status)
+		return status;
+
+	status = ntb_ep_dma_signal_peer(ctx);
+	if (status)
+		return status;
+
+	ret = wait_for_completion_interruptible_timeout(&ctx->xfer_done,
+							NTB_EP_DMA_TIMEOUT);
+	if (ret < 0)
+		return ret;
+	if (!ret)
+		return -ETIMEDOUT;
+
+	guard(spinlock_irqsave)(&ctx->lock);
+
+	peer = ctx->peer;
+
+	if (peer.seq != seq)
+		return -EPROTO;
+	if (peer.state != NTB_EP_DMA_ST_PASS)
+		return -EIO;
+
+	ctx->last_len = len;
+	return 0;
+}
+
+static ssize_t ntb_ep_dma_run_write(struct file *file, const char __user *ubuf,
+				    size_t len, loff_t *ppos)
+{
+	struct ntb_ep_dma_ctx *ctx = file->private_data;
+	unsigned long start;
+	char buf[32];
+	size_t cplen;
+	int ret;
+
+	if (*ppos)
+		return -EINVAL;
+
+	cplen = min(len, sizeof(buf) - 1);
+	if (copy_from_user(buf, ubuf, cplen))
+		return -EFAULT;
+
+	buf[cplen] = '\0';
+	strim(buf);
+
+	ret = kstrtoul(buf, 0, &start);
+	if (ret)
+		return ret;
+	if (!start)
+		return -EINVAL;
+
+	guard(mutex)(&ctx->run_lock);
+
+	ret = ntb_ep_dma_run_once(ctx);
+	ctx->last_status = ret;
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static const struct file_operations ntb_ep_dma_result_fops = {
+	.owner = THIS_MODULE,
+	.open = ntb_ep_dma_result_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static const struct file_operations ntb_ep_dma_run_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.write = ntb_ep_dma_run_write,
+	.llseek = noop_llseek,
+};
+
+static int ntb_ep_dma_check_ntb(struct ntb_dev *ntb)
+{
+	if (ntb_peer_port_count(ntb) != 1)
+		return -EINVAL;
+
+	if (ntb_spad_count(ntb) < NTB_EP_DMA_SPAD_CNT)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ntb_ep_dma_probe(struct ntb_client *client, struct ntb_dev *ntb)
+{
+	struct ntb_ep_dma_ctx *ctx;
+	int ret;
+
+	ret = ntb_ep_dma_check_ntb(ntb);
+	if (ret)
+		return ret;
+
+	ctx = devm_kzalloc(&ntb->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->ntb = ntb;
+	ctx->buf_size = NTB_EP_DMA_BUF_LEN;
+	ctx->last_len = 0;
+	ctx->last_status = 0;
+	ctx->verified_seq = U32_MAX;
+	mutex_init(&ctx->run_lock);
+	spin_lock_init(&ctx->lock);
+	init_completion(&ctx->peer_ready);
+	init_completion(&ctx->xfer_done);
+	INIT_WORK(&ctx->setup_work, ntb_ep_dma_setup_work);
+	INIT_WORK(&ctx->verify_work, ntb_ep_dma_verify_work);
+
+	ret = ntb_set_ctx(ntb, ctx, &ntb_ep_dma_ops);
+	if (ret)
+		return ret;
+
+	ret = ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
+	if (ret)
+		goto err_clear_ctx;
+
+	if (ntb_link_is_up(ntb, NULL, NULL))
+		schedule_work(&ctx->setup_work);
+
+	if (debugfs_initialized()) {
+		ctx->dbgfs_dir = debugfs_create_dir(pci_name(ntb->pdev),
+						    ntb_ep_dma_dbgfs_topdir);
+		debugfs_create_file("run", 0200, ctx->dbgfs_dir, ctx,
+				    &ntb_ep_dma_run_fops);
+		debugfs_create_file("result", 0400, ctx->dbgfs_dir, ctx,
+				    &ntb_ep_dma_result_fops);
+		debugfs_create_file_unsafe("ready", 0600, ctx->dbgfs_dir, ctx,
+					   &ntb_ep_dma_ready_fops);
+	}
+
+	return 0;
+
+err_clear_ctx:
+	ntb_clear_ctx(ntb);
+	return ret;
+}
+
+static void ntb_ep_dma_remove(struct ntb_client *client, struct ntb_dev *ntb)
+{
+	struct ntb_ep_dma_ctx *ctx = ntb->ctx;
+
+	debugfs_remove_recursive(ctx->dbgfs_dir);
+	cancel_work_sync(&ctx->verify_work);
+	cancel_work_sync(&ctx->setup_work);
+	if (ctx->buf)
+		dma_free_coherent(ctx->buf_dev, ctx->buf_size,
+				  ctx->buf, ctx->buf_dma);
+	ntb_link_disable(ntb);
+	ntb_clear_ctx(ntb);
+}
+
+static struct ntb_client ntb_ep_dma_client = {
+	.ops = {
+		.probe = ntb_ep_dma_probe,
+		.remove = ntb_ep_dma_remove,
+	},
+};
+
+static int __init ntb_ep_dma_init(void)
+{
+	int ret;
+
+	if (debugfs_initialized())
+		ntb_ep_dma_dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+
+	ret = ntb_register_client(&ntb_ep_dma_client);
+	if (ret)
+		debugfs_remove_recursive(ntb_ep_dma_dbgfs_topdir);
+
+	return ret;
+}
+module_init(ntb_ep_dma_init);
+
+static void __exit ntb_ep_dma_exit(void)
+{
+	ntb_unregister_client(&ntb_ep_dma_client);
+	debugfs_remove_recursive(ntb_ep_dma_dbgfs_topdir);
+}
+module_exit(ntb_ep_dma_exit);
-- 
2.51.0


