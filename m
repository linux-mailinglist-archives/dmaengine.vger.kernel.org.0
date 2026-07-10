Return-Path: <dmaengine+bounces-12289-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id njAQDOSrUGrM3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12289-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:23:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF71738648
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:22:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=Ble5kMEd;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12289-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12289-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EBC730A86C4
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABA13F20F4;
	Fri, 10 Jul 2026 08:15:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020111.outbound.protection.outlook.com [52.101.229.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261933F0ABC;
	Fri, 10 Jul 2026 08:15:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671341; cv=fail; b=KLEG++65Zm7kUSFQUQOF2II8X9JBjg/qvUMYUUKQ9UporLYvLy6wdQHM/khGM20K9thsGPquu762rmYASGuMOqnmVjea2qqby1s5Q4DEIumNoLmAlWCefOLGvItpznSlg2zAfbliYONnMxnHwMxJHZf6JMbaJbo/MZHLKkLJ2pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671341; c=relaxed/simple;
	bh=J8ba0MGKvCjFYpthvauY/D0Mbg0D+kkUNoUxh4m3Ye4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g2FPb8aSJI9GUZ8gVZrN69fhe46gjstJMVuWgFwICBnLEyfasiLOBYDVtnPK8Z//vYNfilg5k8Gr57ZrSmMSYmQI+3VQaDY3lOnEzVASxhTovSyKK8fE9MzZNcNrlFZ8A/uAZv6+hbmNnG6xK4iN6SMvynmi4TnRs1hLCyCJ5H0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Ble5kMEd; arc=fail smtp.client-ip=52.101.229.111
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5E6/uyx1ubva854lfDqRwpsFfS3+SPTsyhsge6fT7wcNcKcSyjkKxn/IM8+KDueR03X1yq58+ZtsKJW+zhIy7aI1/Zo9s3ZDmVxF2NxvR3sxkeTYTl8BQi9dx9kNXMNg+kYczGFQRYdEypOKiNAFIRVnn87pl1O2ochs9IHcmcrM+g9Xgl+FktrERNhdqWCUmkr/SmmZDTHLXeg8dARpKcFrIvVPixXof4JDbINR1UjN8d/ndA+Jn2LUxuSyLFMx88R8bJDhGy1fTy65UnNTIEoQAF2ykq+vxwuCDWl5RDIm8rKkXSuQmuYWC32AtEO9tmIpSaLcm0P0178cfbHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMg3OxXIUvvzuO1Joy6NPZNluoGwZZqhOVdI4Te1Yqk=;
 b=HoKzSk1RddXCQqaJZfiayunIQP752PdZgD3RxUpg3ks9/BW/T2TG3QPdgLW6qLyvXRicsBqv/TglbsgAVemf8CRZcV627eaBrGqSzMGMFN5BSDgiKC3zVf55mq05iKrYy5HMMvHceaehrhAmIK1Wbuc8Rc5sgGVQMPhim6xVvyELU/9UP4DeyeUKm718JIeZRPmPT9uFCiozLa5gS3CT4X/FTDhQ1OkPEUqCdfVXNBCdZIHIscaAkWwJ97rC5iIlpxS3NQ6lQE6Cm45XsoCxRblFZ75KP6hTMX5SL3irE70tmdnoyFmBE00WKLAA48lTiIxWjHcu54TkxARo++zXSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMg3OxXIUvvzuO1Joy6NPZNluoGwZZqhOVdI4Te1Yqk=;
 b=Ble5kMEduhlq4Gff0e0gTaBUbmA5nJvQpO0ifNKq+Z8bABH2gvgpFKQeXnzttNgmWnlIiLlanJd0EFo6Lt0UH8S5smI5A4c7gweSrhx/lM+BfrJDmfLvNW7Nad8P7VSV0lIGoKiKlIKM4WrgCUDYazZe59ZUk8U9BjuN/qd81Ac=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6307.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 08:15:26 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:15:26 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/14] dmaengine: dw-edma-pcie: Add capability match data
Date: Fri, 10 Jul 2026 17:15:11 +0900
Message-ID: <20260710081518.2394357-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710081518.2394357-1-den@valinux.co.jp>
References: <20260710081518.2394357-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0008.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: e17a6035-8fd2-45c3-16dc-08dede5b65c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|23010399003|376014|18002099003|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	MB8vvVXISJsoxbqvN2wyKbHkrc3mwGGUrVDcOfZ7q203F+0PQkTdUQxBr4qxHzSAL1dcmVT9oaB2/xiYWeNnVClNWGpoPLQlIwdVVOJboWOwjep40bizkos4nfWnzZL2ExzadblgIq4mxlV3BW+EI3RzRHUkhLcQHlFNvbh3+BScbR289wrhMR/hMBrktcllQrBOa65AGfNGAE6VoXD70BYIP7TS/+UGpURfBQpuUxzWn5AQMR4Z3OH9tyb5i4TWU2uIour37ZkQoBxG6ut2N9AfjeKWaffnBweLucLdfz/I4rqjrQfzTiZdxaGSn22CAtzUYNImxBsfhwTIp7SuK3pWXHORvAk1TZ6WTNfQt/t4DKuMbfXW7SR7sxi3dXP/1cCOETsmkfac3iN/9kImzKaLL9LPHnDKCokWyl6qciCZe7x1KEb14hMoFTuc4+u/ze3XTN5i75VRNrEglVhOaiYAg9cvP8DhhgJTR1Rpnh3fllKzBbGFbRxWKJuKr6pWinO/2w9QAmnzlJa5wrCaPizJ0LMk64KemD6lXNyw7zTtkdfSFr4AGSVzBuF36NYdv5A2Q9+VZKgrUXnv+GYoP5FPAbOzy7clSjH2522zGcpn0AzAp/fZnwKI0fok4QUxzgGFqshJ5auXJRaWin5Zn51/c9x+iVfVGfk19U3pr/k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FTjmQgYSfwBXrYUxpp9Azrim4O5wfghNAdXMoFu7wt3VyzplFdntcZ2VM/1P?=
 =?us-ascii?Q?mh4MHdY/s37/iYPH8Aq7IKfZqeRbUPJQD3lFkmGjpfWLMuJWrzzpi2oT1FT/?=
 =?us-ascii?Q?gejzwYkKmMwfblLKZEJrmLWlPE5SwSO2aTznyzdp8nkLglEMeMLIrb9YvjYt?=
 =?us-ascii?Q?QKFlc7iLXU5bbLFs2mntQwls0sGdwQGgZWnRiwCtF4pfy2zb9761xDaFAttO?=
 =?us-ascii?Q?+e38u4NV/Zvu76iIzyXCzIgmbnc1xcXxGteQHfjePq5bh4cUsRaXmo5dlDPC?=
 =?us-ascii?Q?E+oYnPyt3BcHUz5khR6ndKbAUX5L43ez/YWY2m3EobRxo5RPuGTtiXAKXgMp?=
 =?us-ascii?Q?itfljgVDGaeb8la8+mzQRTPiUwuHU83+NaPX4IPwFjLfUB/MZrNf02U+6SOF?=
 =?us-ascii?Q?xyLCOek0ipz7JYeZAWOWVYATL2+oGohL8HfEZDVv17eA7BpvtNx0BYIXqGBw?=
 =?us-ascii?Q?4awSVgbUiAc1q1xF5l0xtXYz5rzMyjSOL0cuJJouJbEJljczn5UMh+IOdG2L?=
 =?us-ascii?Q?x3lS7ZJVxTNMV8yTEiw3YVZiR1NI8eYp133snO4OdfCZtKT+o9rdFDKmUCyO?=
 =?us-ascii?Q?tMNkJNGX70lC2Q9OqAZkwn23F6q10sxbmrA+QwGrck/PlVdKk1cne/kJ3iPS?=
 =?us-ascii?Q?dRvJZSwWN1ikd4SKa/I6mV/WdqD+XW4vKk6UoN4pHsRYCWNKtXUJ9MlAxYgf?=
 =?us-ascii?Q?dbUacfwkCRyQoojCiDYW1YWVdYZM7RvypG7MJB7XrsyfNVw2I3UOMBGbcztC?=
 =?us-ascii?Q?O6uJxSyJlRI+CtxKGU6iYB2nyIIycu6egoxjko6K2tn9eKjQ2Vkz0RJgo5yn?=
 =?us-ascii?Q?eWLz4CEBn0tJ+NTks8IdMODJDs9T7tClwUr7ZQUnpM+NC3e/u/8rUCYnCPfo?=
 =?us-ascii?Q?MTgnnv+IXPWxXIzChpue3IJ8974v0FxVCbtHpuRd2b6GJjNGSMfpzFsz3ydP?=
 =?us-ascii?Q?hWkVHYEdtqy1/h/UmSL0/gQk0GyxWtZOx2cb5tVUZ3Z5M5fgrfKiux3NB6Xr?=
 =?us-ascii?Q?idgPkTk8LFRlB7vvo430OzLH3jFGm6yMyO06k4Q45CNwevXH3OJJDz7sxbMS?=
 =?us-ascii?Q?b6b5wKR2S1PDXa9JoXkoubf1LMMICtivkhScZPUMSuZlVMbmOQvE6PKV86gB?=
 =?us-ascii?Q?bZ+M/fNqmp2FS8MgjB4W2jUVg9EV4giO4WbilXMrQEA7lGZNj1u1bfBm/hau?=
 =?us-ascii?Q?C0mtuN7fXrbtEEMmUxymRCFVLOcH86/tZeXUYiDG4FrDSkmW9NtD8jZs85/F?=
 =?us-ascii?Q?wqe1wFYKilvqffPB3DmB03m2sPCuDxEgXmGxPJXSvzz6M65op/jxYVY2xP4d?=
 =?us-ascii?Q?UVwzPbzj3GQIFcycYSupJKEVYgvFJLccou3VMV3EvHRFRB3MQnONg5abuFbU?=
 =?us-ascii?Q?q3+O3DX9c+u6pRwhaAi5pJPuPb0Tsb0B5Ezvx5PG+q6iK0YLnemDiOc/ZCEX?=
 =?us-ascii?Q?rBqGZFFY5e37vHjbRGKB/tMq2SwRcg0ijJBurqkr3/LbHnLcrAhYplwRSXYD?=
 =?us-ascii?Q?yIYs6OkGZBS4jp1CiJETto6flYfX8cGBM4B8XrwWWoQh4kC9rCVppO5GxMJW?=
 =?us-ascii?Q?zmn+JTOYQQhUfQ+JHUVG812Qp7DrS5EMpMyBVohmLPIgIJaXliGKbGMErn1D?=
 =?us-ascii?Q?0pdP3D4fwDumlOWRyWc+Z38SAJ52blG1/TcjJVh1aw/dl4IXrTGGX6yK2L2J?=
 =?us-ascii?Q?UxnGFw78Kcz2yVrHOULu6MEx0j647gGsAIgOFnQ7pAxSzOtCn0k0YHlJRF8s?=
 =?us-ascii?Q?DhbxPJRD4zaelb9/0WSQ9qZiXnpAcnkkX+cxIZSjoJ6qtkE1GmP3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e17a6035-8fd2-45c3-16dc-08dede5b65c7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:15:26.5062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aO5l081zjVB3sDaDwl/U2Lcolp3BUX9pzBB2KMn4AINg0xGQNarWrDl8pYGfwniPW6SAv4Oczjhjm7fC+bx3xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6307
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12289-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BF71738648

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
Changes in v4:
  - No changes.

 drivers/dma/dw-edma/dw-edma-pcie.c | 139 ++++++++++++++++++++---------
 1 file changed, 96 insertions(+), 43 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 8ecf67828a52..22e3efa6b365 100644
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
@@ -441,8 +477,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
-							 ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
+							 vsec_data, ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -451,8 +487,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
-							 dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
+							 vsec_data, dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
@@ -468,8 +504,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
-							 ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
+							 vsec_data, ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -478,8 +514,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
-							 dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
+							 vsec_data, dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
@@ -557,12 +593,29 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 		pci_warn(pdev, "can't remove device properly: %d\n", err);
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


