Return-Path: <dmaengine+bounces-11657-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0m+/MnDHNmoUEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11657-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:01:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B036A944D
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:01:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=P3gFoeIT;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11657-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11657-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20E943006450
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700F726A1A7;
	Sat, 20 Jun 2026 17:01:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020079.outbound.protection.outlook.com [52.101.229.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A215325B0B7;
	Sat, 20 Jun 2026 17:01:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781974873; cv=fail; b=tGJsaMoOzgPJ91z6FVMmsKcYxMBG/aKeHArBFGAFlVQJ2E5xItuUPrAqAqUUR4pYnIuKG9vkgtFXYWr51fiSY3gWFQ0uLDFa3AG+WMLLzKMecSIq/ExrivEtEzgjppKlUxqA0TGGUBPGcld3057RSXm5hZVxA1UBYxV9/wlGWS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781974873; c=relaxed/simple;
	bh=pUoGdu8Bgsnkb/ajcNz8FbBwGguhmyN/NzD9tQWCaUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VpCSGufdkIzMNDMlaPrZSwDEi97WxkqRSU5sBMzzZOrKy+WlDUJIUC+pC9NvhWjjl+B95aRjNFEeiv66tjTzeH7gqtLgLWm0uv79k7qoTLf76rfDvtTxic4Rq85GUWwB1T60XthtDL/IEL+77ZWOR2sUWCT6lrFctb21/7lFg10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=P3gFoeIT; arc=fail smtp.client-ip=52.101.229.79
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgVeZki9/oRrQ5nCNpA4OyrpGxB2J95OwSjVO8lkEMKI7ymy4oBpsSfVEwd5PMRhWmZbE/ZxCQhUlNMjnGvHvHh9uhO+2Ig2h4psfvm7/2nuSbqvvWpPWuDghB5OlS5oJBzBuTyRIbgp3rycqa9Skj1jDMO05otTyOvjacmKDV55D9D+t6GxzUF2r+3QZTFFeZvNtcug6M94tRfkh88YXYDYuDvG+64k3DdJ9EXwxgYzoiPzzOJJJdX1bp8LcUEOEtnHauKAWyUu8Xlqfu4iuAgUjvKqAovBJhLSTc5/9VubZATY67HqfCKqP+3B6hDIO2S+vpbjVRzpVCBzSigMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT0xVwHRUVegoUl1sbWqKaS9IoIDc4VkSeUKu5qEEtk=;
 b=Y2Zx9lSzorUA0TPaPxBFQynPdeARyStY4tFuk1F7OOYbp0cihLTR+oc+46uaLVRHpauu0nRBpWvHWfudMoaygxKKsWe0Q6suD+hr/L5BrHT43B+qpitOmBr1xkH2CT9glkfmogPJvpTEbnN98coqmm7LeLinRDBPgSYf5v3PvzHDi/3tRMTLqy+qTSkFHpCfXJ64pntbnZvPsWePa6zk7xQNfpA1yfXj3UyhUQBmamYZPg7vXVWX6VX5iORz0qJEW4zk9m+PAT7xbGGTzdjE0r2JvVatYcgTZt+21gyIMX1727BnDYzm4sMweTWzgykkEP2va81num8tqD7fNYnhqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT0xVwHRUVegoUl1sbWqKaS9IoIDc4VkSeUKu5qEEtk=;
 b=P3gFoeITV4CjRKCIOFnqbXRrBotWsDeTb2im1sDHchpZWLt3yMu3h9kVkWAEED/3YU1JEPP09MpcHn8wFh1554XCwi9Oq6oqf//YKQi8YlhRDliQoqb+8jq0ImcCOJ5n0X1eu7hUfE1yii5pmCFc6OjWcUe6RNR2Qs44aaK5Zro=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2673.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sat, 20 Jun
 2026 17:01:00 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:01:00 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/13] dmaengine: dw-edma-pcie: Add platform ops to match data
Date: Sun, 21 Jun 2026 02:00:36 +0900
Message-ID: <20260620170040.3756043-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620170040.3756043-1-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0086.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: eadd268b-10a8-4a39-403a-08deceed813b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10070799003|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DP6yWaYNyUN3s18E8EtyEN19NxXK1C9G0eSGKnpeFVrDrIf5pW4n76BfNjz+c/bRMc9/TYZcQSI1p/fQnf5jca3Sy4PWCxrCaIZkkE0ErDbcMoZl9uTt0/RdPwYBAS7oc74efsqfOkSXJBBSCqDVd7LPhyeM3vMiFVoXwUGax5RnhNeO1seD2m821mvJOmMvdYwxWPJF+LtFMP8jkEEaUTpwgplgyc1K7+l2v8LSFww2D5BhbF9Wc7yEp2kiiJ5Wi0rswdxK7J1D56SPKjg/XPfhtdbWSlofCRN1dyig4vfuZ3bkvGeujGbEVk9JYXrPBVFgnop1jvMeHskloyUvTHEeEghfTsO9EAZEiOnfyeJV5PJDWuwwaq0DzSdbKQdMkRdOAKSX8aDcc+shT7ITy3EVbedeqoXop4gEA5Y05PB+A4zwSieG6OXJ5c0V6uugTJak/BCZ26DA6Eu1Q+jdvxqcAsYGllQXATx6/t61IaSAf/qbkXdl2qy9gbhmiN9ZAZNc/ePRqURFBpWCa1KQvJNnElWpFmH61VsAYdyHy9NzIQjphq0/UyrG9CML2HC7xJj7Betloqkhs/G57Lz0OdCVr+8EdL6BsyancUHli4uGnbJdcYIdgv47gvhkK6iAebpJPyNzX5gYwGht9MiLnr+b23HG+iW4XfSAvj2dxDM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(3023799007)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sMXc9groD1GzxXvAaNyn8Pb9efeDJ/mE5I1i/oFY72gIX8UaqGvNDTaNGwws?=
 =?us-ascii?Q?S/WSoz0cHPvX4uULimdDMj9PJw4FjGVUGXH1V2GcODFIVnjVdz+14fTG8Mi0?=
 =?us-ascii?Q?Z+SBv0mZ+1X8pmyCkc1U/YdKY0x8J2z80UeKycOMktw3dpremYpRRYRwN4/4?=
 =?us-ascii?Q?HqbZvYicM6/iXgFFmZP6ouOoWsokCC7b9j7rHDSUE4ZAOj0gedsZa+KV6yLc?=
 =?us-ascii?Q?rgS6Uf4zx9aULJ45gNVhrLSdu3jFbfx75skej4qq9hAIIBAecyZEzf4z8mzz?=
 =?us-ascii?Q?4rhk4ckWTqVhEQcBrUrmo1U3JWHB0cjLlYwOfiObvYamlW/EOUDjCsVZy06i?=
 =?us-ascii?Q?Z8W6aHOXRr0uPt5F7suDrITH9bFrzuMkkaMDPndwsq7jSpZTFka44sW3icDw?=
 =?us-ascii?Q?mf14N/nkhlA+iYvPWLTxaO407rtF5cZ9FE7yzILvLLYJxuXPZYxpW37YbfGw?=
 =?us-ascii?Q?fKGKRtSTRYNkbb05wmSR0f9exPJ7r8sRcR+N8qGvT+o7+fmIjwcWj/4PRwFg?=
 =?us-ascii?Q?fX2lT02G+dbUoWYBqQYNJp8dnE57lwIXBL/eOID1Y1Qz0Ka0DX/xV2SdAA5b?=
 =?us-ascii?Q?+IsLVrK/i/jDIrNCVS9JVdpr6C9E6d7yDHwjeXldatRnlyFrabsNdhUkEfQK?=
 =?us-ascii?Q?zDkFcFoRInRaMuh01sjhwL1uudKHFKFvkzVyVDld5KbFKQxgaFUkmIELShqI?=
 =?us-ascii?Q?GENNnt53s8v/DGuSlFSG3nBNVfaY3ywCtf/mx+qHhc5bYvKNt3PeuO8vwfsb?=
 =?us-ascii?Q?0QKxDMsEdSy4qA842D2lQdMaOR4DOvqHS8ltQ5FNzeuSBrnmCgMQNC5eWh25?=
 =?us-ascii?Q?B4XSHuQVglzZdmZIfdKlWea8KMUXE8uWisN/NmX+lIEVhcuAf5Pr8x+/7Amc?=
 =?us-ascii?Q?Zq/Kr9fo7cxNNLFTkSoGK8kmJwMg01zuhhwanwfeybEZQm+CkDpljyDtIOlq?=
 =?us-ascii?Q?TDikLspA0dPaYUTYIBS4jL3x+iRg/tdyze3k0ow0p3fTGNXDi5q/taKaHEH/?=
 =?us-ascii?Q?yJrVMpxGRnM4g2YwWLi2jZgPfUwLrWeHA4gBBFQw9CPmqDdQnH3NVskw6ZXL?=
 =?us-ascii?Q?N3IDfOQ1kuBGfG/I5lq/i0JIa0LBru4LyFfgbu8lctCDwJoJyRGEfsS1K4k9?=
 =?us-ascii?Q?PHKTsISfv7RMJsngDZxp/oLRU+rpbvVBWmax2f7Vewg3RnIrPCdhkk6yy8LC?=
 =?us-ascii?Q?RE6eiPbzMZOuEE0GyGg9VgOMstI1Yo5jnU78leJVOSsXD/KOJAPa3ocQ78P8?=
 =?us-ascii?Q?4Ds5CRateO4umrZjXJKHoHo5OtS++2ppNuLRcKYslPCO0/p+3gRvGzPAfo2g?=
 =?us-ascii?Q?lijlbTzY0VOuq93VKympGwOAYepJATbMlkYYT1pC5KFN3NJ+HjVv/o4Fz36r?=
 =?us-ascii?Q?PUbKBD/6srNRj4juUgbMb8HtHzZwS0Oif1oA3Auwyyu9Z8u8LGNEnQdl00GS?=
 =?us-ascii?Q?meay9JpJ2x1pNPBRQQbPt+m2V122GKfA7Ixh9sOhgCBQhVYmNKyfO8ErHHsH?=
 =?us-ascii?Q?XjbGYoDoKbZvNHSeF3IQSXVOpVBAz4UwdD/3eMwjqIE5KQxRSCOO0PqiAmbh?=
 =?us-ascii?Q?oXTy2l3sWtDmDPwe3JmnCMyX+4UIxYK1XmGJ1dafZOOVlXfM022Cp5/YrjmP?=
 =?us-ascii?Q?hvkT+u+Abv5z1o9YelrjSzHermWaOqww2prLcynbGAJh/eXHmheGYVBnk9Nz?=
 =?us-ascii?Q?wGXfQnAGg/npuR0sIulz3ccm6g36V7C/dY4adicX9Cx6mfUZTNPBSq6ghVvg?=
 =?us-ascii?Q?i5yZ8RLWsU/MR1cZ/z4yG98VYdOydNNQeGbrnc79/RwQ2L+hhxwf?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: eadd268b-10a8-4a39-403a-08deceed813b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:01:00.4329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TCA7yYuVxXS4Vf0YMBlKCeeCsxFP3FsRRXD7/LPyFf1GIfvIQ3nP58eOlk7ZyAsiAbkky4P0ZKNq38TA/lh0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2673
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11657-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61B036A944D

Move the platform ops pointer into match data. Existing EDDA/MDB/CPM6
matches keep using dw_edma_pcie_plat_ops.

No functional changes intended.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Adjust context for the AMD (Xilinx) CPM6 match added in the new
    base; keep it on the same dw_edma_pcie_plat_ops as the existing
    matches.

 drivers/dma/dw-edma/dw-edma-pcie.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 5249324ad6bf..96038aaca079 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -78,6 +78,7 @@ struct dw_edma_pcie_data {
 
 struct dw_edma_pcie_match_data {
 	const struct dw_edma_pcie_data *data;
+	const struct dw_edma_plat_ops *plat_ops;
 	/*
 	 * Mandatory callback. It may leave @pdata unchanged when the static
 	 * template already describes the device.
@@ -403,7 +404,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	/* Let device-specific discovery override the static template data. */
-	if (!match->parse_caps)
+	if (!match->parse_caps || !match->plat_ops)
 		return -EINVAL;
 
 	err = match->parse_caps(pdev, dma_data);
@@ -455,7 +456,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->mf = dma_data->mf;
 	chip->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
 	chip->nr_irqs = nr_irqs;
-	chip->ops = &dw_edma_pcie_plat_ops;
+	chip->ops = match->plat_ops;
 	chip->cfg_non_ll = dma_data->cfg_non_ll;
 
 	chip->ll_wr_cnt = dma_data->wr_ch_cnt;
@@ -597,17 +598,20 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 
 static const struct dw_edma_pcie_match_data snps_edda_match_data = {
 	.data = &snps_edda_data,
+	.plat_ops = &dw_edma_pcie_plat_ops,
 	.parse_caps = dw_edma_pcie_parse_synopsys_caps,
 };
 
 static const struct dw_edma_pcie_match_data xilinx_mdb_match_data = {
 	.data = &xilinx_mdb_data,
+	.plat_ops = &dw_edma_pcie_plat_ops,
 	.parse_caps = dw_edma_pcie_parse_xilinx_caps,
 	.flags = DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF,
 };
 
 static const struct dw_edma_pcie_match_data xilinx_cpm6_dma_match_data = {
 	.data = &xilinx_cpm6_dma_data,
+	.plat_ops = &dw_edma_pcie_plat_ops,
 	.parse_caps = dw_edma_pcie_parse_xilinx_caps,
 	.flags = DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF,
 };
-- 
2.51.0


