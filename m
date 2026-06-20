Return-Path: <dmaengine+bounces-11655-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ooH4MRTINmpEEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11655-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:04:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DFE6A94AA
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:04:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=AXp4iXsQ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11655-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11655-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1564E3050935
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853F1272E6D;
	Sat, 20 Jun 2026 17:01:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020079.outbound.protection.outlook.com [52.101.229.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351DF26980F;
	Sat, 20 Jun 2026 17:01:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781974869; cv=fail; b=OWbQV+XF7eyYydml/94cbXrYd5bV4WIA1VB6erO6Tl0thzQ1SzF54NRFrS79R5htSGKsP9EvIN9/sDb/lQIFX9/bcoTq6rj3M7ez+IgSN6NQngeEEpEyPZvnf03CeCA+t/cE0Sr/v9Vc9AxLM4bV6Y8pK23ia72QaUJscEZn1uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781974869; c=relaxed/simple;
	bh=wmZog1oNiSdENgV2/Vag6rin9Yhv2sRFk2N+hnZ2CIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fLgrVuzSxotJ8yOXSuOHoK3H76ON7WpNwVZpYl1A83iWeXKPESR4ih8QeAa3U0rRCgv8HM9kdpRTpUvb4+YkKp9zx7CmceW5/QwBjdUiaavunpPGotbxZkSetNwWqU++pBGiixZVPp62D3XbFjdFY9ezztiBRQkG7hNz8FAHn3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=AXp4iXsQ; arc=fail smtp.client-ip=52.101.229.79
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5cFxvS6HWOrUCLU/s+rFVkKtKCQ4vOf10mxvy9yvhHajLNNLFfDeepC9J8U4+2dOe0S35/N7vnRG9mLDqoGJ+4H1Xw4ARHeuZzkgr+m7MMf8RkGTfEVp1pcu+h0v+s+u9FsrPPrS1vuZ9XLP6E9xbtwO9P4cYw1/m10qQSwW4v8S1qaiIenXfJW8LaD12FOdDf57lICN9x9BqaUqCcOxUioq2/2mBACxOjpSyxs0Tv2LB4j27Lz02/ifj1Jc5tMsRKNPlEzTWEWj2/J1fh8JehJmiIShsQOg4lLXnZH7xONcXCtgwnDFahLYpK8IaULaN02W7Ej+B07YOcUwpPFGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6J2BxbFMP1jF6f9Lwp5RCQYh+KlHsSOLEg0pnLfL1g8=;
 b=bVioiYSlJdahhFBQpyLsmLpoA8VhWUhbJsC/7ntbht/bf/zKhK/1PPdyC0gY6/+pUPKY3/nU0Fg+9w00P1OglcysopocECkfikqw0wEFGpqIBhMQm4A0bsvUrMkvo6b27EYllySJZT3gDqmdNyBfzhS6Pxt4L8+zWjQnojCx735VD6sSgAMxlRzMZHtMCs7H6g4tVOrp+Vp3gKyjJnxlHBtAE2pSwUkiKwU4bKNWckil1PPXXKfvf4a5pwt5UIZG8XqufcFk1DpzjWyJKGXw4AfM4cxrI9TQk7eAPGmUbLysVDExalY6s5EG9hWk+pbxKPoTCVqYj8hxJjNXmZtCEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6J2BxbFMP1jF6f9Lwp5RCQYh+KlHsSOLEg0pnLfL1g8=;
 b=AXp4iXsQxGhEQFTKwgQiBX5OSXGYs5EkRX9NnRBilhotTE6F4y8kLNjFxXycipXoI/P7LUR95BvQRLLRhCCWUgKu/GZQhZC9XJHM7dSS6hc2GwimcIa3klJ7YuyP3MnGPi4nUYF4J43Ttp//TweIudcYwgYZeGjdGTHug5rT75A=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2673.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sat, 20 Jun
 2026 17:00:59 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:00:58 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/13] dmaengine: dw-edma-pcie: Add capability match data
Date: Sun, 21 Jun 2026 02:00:34 +0900
Message-ID: <20260620170040.3756043-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620170040.3756043-1-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0158.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: f82d28d1-32dd-413a-ca70-08deceed8054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10070799003|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ri7Diuq6LNQgErDoC6Rg7lJSVuGe+vbfrGqfk1Kl4Lu5mLq5Fn/IQzMZM60Ijl1858YtEoZlRz2oCFRtGexKCdi8mG00AlGKosoMY9Dk4FO66htcUH7b4kRbRjg1qnIjGmWQrYvk4zSFqngAspbSkgEUd7D7BRLMI2AOQf0LoH8MiLf3V6TRFPZ1G22XuZ/CbThf6m7cB7fdvIiHRDP27/de8bm14WpQCy02Wq2numyFKoIq6/OQWKA1r2I+w5VQjjO0pd53Z6eXhvp8+qWrGay+7kc1ecXhA42Vvhzx4GNOFL07tMqQyMekOTAAlb7CiQVc9pym+M2swcxt81TQDYj/v5Lvd2vu/BLCTv933mlc1yaSgJWJeZav1LPqkhOxN+vrrN4H/HKTNFWDwA6F8spnluYu090NUW87sP4U0uRi45+oyIW6ZauH/WBGNqsn/KNlwHHY2UElwMrfoS26NV7tMnW6z8HysZatKKafgdEDzZpxIit9BUhNoaDCFz4ZzV8ATh0AFvVlhI9u4oThgramG3sfp8pvTOezUyLp/cpdqgo8Tlyf6zBuWieqMdRp9pWr6Fn1Egn367wxV9tU/9EOmS3PowE1/cY2zcxRTRGwYOoEaKa0bWneERl/gkTYnmx2NUAi6xgRtxSYuKo15DceT1eSFRMe8jYu4rUv9wQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(3023799007)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xFe3Y7gK62+Ey/FXQsWBfrWBchKQdnrc5fE2XRG7V+xrJ4Wlm1t5nBy1RyLD?=
 =?us-ascii?Q?xmXurhE12MAWMlsGr/ZSU3pNFljxmZNNdeSBBLnHIovxZDbPQMzelVYDGAHm?=
 =?us-ascii?Q?7ceRnw8bboGQXdbzJl86aPl1vt/HUvBWxT7lskjwLj/yNNdasyv2kTSlzH/c?=
 =?us-ascii?Q?psoQNOrPG+pQTgG35pKUM2gBhnVYKrjPrjN2C4JwZSxLlxTh7cKfOamOEZ9k?=
 =?us-ascii?Q?rto/dusME4WcL4l6UiSBjpNE+buQeNN3sVcVS+4yQ6wedSf2Ng16JzJy8BSC?=
 =?us-ascii?Q?FIzSq6yT54vamwgfjMVe7E0jjx7yKj/ts1YpzDPpULKw7/2Rh7rDpGmT38q4?=
 =?us-ascii?Q?+olCexr1b0I8xpC2kMtZ8Z+oYsGeg7dBgzxghYQjWqIGyzZAWqyE/az4WgMk?=
 =?us-ascii?Q?6WV0BlfMjhOlzg/XvXPegFrrwWeCiAGxvpT0LoQzuO2RqDSyknX5uN5vPeeE?=
 =?us-ascii?Q?lrmL6VpWX6s7i4qUAVx/tCNyorcGRjie/5AercFtA6JD16gKLMjYNIn4wK32?=
 =?us-ascii?Q?dLUOalV7FucpcfrnjJGsHechDwOlu6W+9Bq+TFFmYSSHLYePjE9gNzyZBXNZ?=
 =?us-ascii?Q?TBixBgayfLeC7/v9La9aJauiMtaQcyVJaYmp8YkPscSa/n7f06J8PfLcNHJg?=
 =?us-ascii?Q?btgFo2neS2RbEOqfS6cvYjWOBKbQv9McGqXP2/s4l0bTjTD2Dvc9BwM+nYkI?=
 =?us-ascii?Q?xln0WhZ6QDK4KC4wISCOux6tQiazGa5NRFOSM66HK296Ie3ROV5PxMhzfJUk?=
 =?us-ascii?Q?lg9P6n1ULSfSh/rAHvbJrUlACAKIvIFHn3Htb9vt58zFw63QprB8kZdawQ9n?=
 =?us-ascii?Q?qv8EPPUQgQUywDBE2FnIVXzBTGPX6E0UbBjs60CSKBWrxO/svMo4baGxXfpQ?=
 =?us-ascii?Q?PKwsrCeJX7GpJoARClX+8d+cU5TzC6uqKvLATkuVEm6UD04z8Kta+MsqRUGL?=
 =?us-ascii?Q?0YJ7WSz7iAakqTGMaa4mMQ78TE5+SDYA4PoFgwsOB6Qz16/AvMiVBpx2e2TH?=
 =?us-ascii?Q?IjZrGaJQO4zKAZSOXXuxJq60PpE2A8z07SJui4FzhtiEvWjzNaSelFHInFST?=
 =?us-ascii?Q?ivdNV7C4UXsopXiOxMZJKcCoPWvktK8aWnF79wG7DoAM0bLDOOKteCzRF8w+?=
 =?us-ascii?Q?ut2C6LC4VD19yhePuyABLqIOhGq0ikEIKoGkKBhXPYX5Dr7tXQ7kkYh6jsKS?=
 =?us-ascii?Q?6OTT2PHoVZbsZQowa45yUcfJ1fR3eL4MAkTy0LAugRMsUSSWaRoAwLKSJm5X?=
 =?us-ascii?Q?2By0+SD+ajsblaUfHVz2nodGqhJPpmmxuU/r8THxq3Q3uSteXlZO4TnhvjTN?=
 =?us-ascii?Q?MUqHxz8EQ7fDHXV8cVR7lOsZB78kFGAZiz/Nj+dyOLaS2hbNuQEKUiKHqrfJ?=
 =?us-ascii?Q?cZ6g00gMpwyH42Q6COwVIjj+1DTGS5lNg/sOdQ7I1KCUJ6yMMWnRMGBRmB4h?=
 =?us-ascii?Q?GCt9uW/YPuhiSzbp7VVLG8JTu5zpcd1OORXMUeD9vs524cVPBCnhm5qwiA2b?=
 =?us-ascii?Q?B7Ss2hknV8NOc/edjjYUnzlWWfli7i2BAMNEBq45MYKyjzgKPnFhkzoaCxpC?=
 =?us-ascii?Q?hyNMY3Hwqhkc9BwJLk/bzvH9LEi+0mHzGHtm+3qs1riAW2YNM+8FJAGGk58m?=
 =?us-ascii?Q?GPfX4b75SsfB1JJdISCLrMDNlJ/bpf0apok7AGqBi2ZXOKSsGMJGC1MruLlM?=
 =?us-ascii?Q?ISEo306NWolV0p0Fb/cQMrTDpB2uyHQH+ar3Z2a/UHL6eX5+fUetik/dRP+3?=
 =?us-ascii?Q?fgOp6N+KPfK8aIoF3cSIjWBIqruNN0+snoeQcnzYaqjev9tDTaog?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f82d28d1-32dd-413a-ca70-08deceed8054
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:00:58.9238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FU/acTdgg5Pm5UnPUtkquzTBcMqUuOvHewXoqBAijjdQki59r5n6rwhm3vCC5CmuGBA6wS+X1p2p9EV8MTIzLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2673
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11655-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18DFE6A94AA

Move device-specific capability parsing behind per-device match data.

The existing probe path mixes two decisions: which static template a PCI
ID uses, and which device-specific capability parser adjusts that
template. Split those decisions so device-specific discovery can be
added through match data instead of adding more vendor checks to
dw_edma_pcie_probe().

No functional change is intended for the existing Synopsys EDDA and
AMD (Xilinx) MDB/CPM6 matches. They still copy the same static template
data and run the same capability parsing logic before BAR mapping. The
AMD (Xilinx) MDB/CPM6 entries also keep using endpoint memory physical
addresses for descriptor windows through a new match-data flag.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Adjust context for the AMD (Xilinx) CPM6 match added in the new
    base; carry the same match-data conversion over that entry and
    update the commit message accordingly.
  - Reject dynamic PCI IDs without match data before dereferencing the
    match data.

 drivers/dma/dw-edma/dw-edma-pcie.c | 139 ++++++++++++++++++++---------
 1 file changed, 96 insertions(+), 43 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 0ea8d59782b4..c08a77c0e508 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -76,6 +76,19 @@ struct dw_edma_pcie_data {
 	bool				cfg_non_ll;
 };
 
+struct dw_edma_pcie_match_data {
+	const struct dw_edma_pcie_data *data;
+	/*
+	 * Mandatory callback. It may leave @pdata unchanged when the static
+	 * template already describes the device.
+	 */
+	int (*parse_caps)(struct pci_dev *pdev,
+			  struct dw_edma_pcie_data *pdata);
+	unsigned long flags;
+};
+
+#define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
+
 static const struct dw_edma_pcie_data snps_edda_data = {
 	/* eDMA registers location */
 	.rg.bar				= BAR_0,
@@ -310,24 +323,70 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 	pdata->devmem_phys_off = off;
 }
 
+static int
+dw_edma_pcie_parse_synopsys_caps(struct pci_dev *pdev,
+				 struct dw_edma_pcie_data *pdata)
+{
+	dw_edma_pcie_get_synopsys_dma_data(pdev, pdata);
+
+	return 0;
+}
+
+static int
+dw_edma_pcie_parse_xilinx_caps(struct pci_dev *pdev,
+			       struct dw_edma_pcie_data *pdata)
+{
+	dw_edma_pcie_get_xilinx_dma_data(pdev, pdata);
+
+	/*
+	 * There is no valid address found for the LL memory space on the
+	 * device side. In the absence of LL base address use the non-LL mode or
+	 * simple mode supported by the HDMA IP.
+	 */
+	if (pdata->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR) {
+		pdata->cfg_non_ll = true;
+		return 0;
+	}
+
+	/*
+	 * Configure the channel LL and data blocks if number of channels
+	 * enabled in VSEC capability are more than the channels configured in
+	 * xilinx_mdb_data.
+	 */
+	dw_edma_set_chan_region_offset(pdata, BAR_2, 0,
+				       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
+				       DW_PCIE_XILINX_MDB_LL_SIZE,
+				       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
+				       DW_PCIE_XILINX_MDB_DT_SIZE);
+
+	return 0;
+}
+
 static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
+				 const struct dw_edma_pcie_match_data *match,
 				 struct dw_edma_pcie_data *pdata,
 				 enum pci_barno bar)
 {
-	if (pdev->vendor == PCI_VENDOR_ID_XILINX)
+	if (match->flags & DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF)
 		return pdata->devmem_phys_off;
+
 	return pci_bus_address(pdev, bar);
 }
 
 static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
-	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
+	const struct dw_edma_pcie_match_data *match = (void *)pid->driver_data;
+	const struct dw_edma_pcie_data *pdata;
 	struct device *dev = &pdev->dev;
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
 	int i, mask;
 
+	if (!match)
+		return -ENODEV;
+	pdata = match->data;
+
 	if (!pdata)
 		return -ENODEV;
 
@@ -345,36 +404,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
 
-	/*
-	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
-	 * for the DMA, if one exists, then reconfigures it.
-	 */
-	dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
-
-	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
-		dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
-
-		/*
-		 * There is no valid address found for the LL memory
-		 * space on the device side. In the absence of LL base
-		 * address use the non-LL mode or simple mode supported by
-		 * the HDMA IP.
-		 */
-		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
-			vsec_data->cfg_non_ll = true;
-
-		/*
-		 * Configure the channel LL and data blocks if number of
-		 * channels enabled in VSEC capability are more than the
-		 * channels configured in xilinx_mdb_data.
-		 */
-		if (!vsec_data->cfg_non_ll)
-			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
-						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
-						       DW_PCIE_XILINX_MDB_LL_SIZE,
-						       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
-						       DW_PCIE_XILINX_MDB_DT_SIZE);
-	}
+	/* Let device-specific discovery override the static template data. */
+	if (!match->parse_caps)
+		return -EINVAL;
+
+	err = match->parse_caps(pdev, vsec_data);
+	if (err)
+		return err;
 
 	/* Mapping PCI BAR regions */
 	mask = BIT(vsec_data->rg.bar);
@@ -442,8 +478,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
-							 ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
+							 vsec_data, ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -452,8 +488,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
-							 dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
+							 vsec_data, dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
@@ -469,8 +505,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
-							 ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
+							 vsec_data, ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -479,8 +515,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
-							 dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
+							 vsec_data, dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
@@ -561,12 +597,29 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 	pci_free_irq_vectors(pdev);
 }
 
+static const struct dw_edma_pcie_match_data snps_edda_match_data = {
+	.data = &snps_edda_data,
+	.parse_caps = dw_edma_pcie_parse_synopsys_caps,
+};
+
+static const struct dw_edma_pcie_match_data xilinx_mdb_match_data = {
+	.data = &xilinx_mdb_data,
+	.parse_caps = dw_edma_pcie_parse_xilinx_caps,
+	.flags = DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF,
+};
+
+static const struct dw_edma_pcie_match_data xilinx_cpm6_dma_match_data = {
+	.data = &xilinx_cpm6_dma_data,
+	.parse_caps = dw_edma_pcie_parse_xilinx_caps,
+	.flags = DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF,
+};
+
 static const struct pci_device_id dw_edma_pcie_id_table[] = {
-	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
+	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_match_data) },
 	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
-	  (kernel_ulong_t)&xilinx_mdb_data },
+	  .driver_data = (kernel_ulong_t)&xilinx_mdb_match_data },
 	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B00F),
-	  .driver_data = (kernel_ulong_t)&xilinx_cpm6_dma_data },
+	  .driver_data = (kernel_ulong_t)&xilinx_cpm6_dma_match_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
-- 
2.51.0


