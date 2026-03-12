Return-Path: <dmaengine+bounces-9402-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHUdIm7wsmlBRAAAu9opvQ
	(envelope-from <dmaengine+bounces-9402-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:57:18 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 074B9276222
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 667A4311578E
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 16:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4653FB7DA;
	Thu, 12 Mar 2026 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="cT8A+RSs"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021077.outbound.protection.outlook.com [52.101.125.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D369F3FBEDA;
	Thu, 12 Mar 2026 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334240; cv=fail; b=ixGmO373uQ1l/neDm9EyI4kscqcZE0o+OZoy0IbemeAi8mQVVfKkNZen9j4mlaD6D3KKyrU+5bMx3YmajtTr7lJ6BPV9cchET+QmtFWTPO66HllMKGNNQ1oOqHZXM3IANRLxjEppP+1DayCPAJuVngGZfgI+8W5M1a7x4dHjF/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334240; c=relaxed/simple;
	bh=lRW1ouca4Wyzn+yAJHqiPt4DGODvY3XZUPe+mgsZpo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hq0EISW3ndAvTLlNyxXqGPLDD63SgXIxF2Q3evpPHbEpyndMJC9adXaWygMizNSGgjwJ8JBbqYM29wCkkbRw/zkkN5NQsKP4uALXCBsGf8rT0626/KNd/Ed1BR0bSu4x8EUjhXeLC4AfRvhp8Y0WPtKB8C3x77rr9YD2yU432wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=cT8A+RSs; arc=fail smtp.client-ip=52.101.125.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwJqzVWW81D/y/yMpgOtn+sO4H6f8zI+7EPW/+SlarijyB51UAIw7/vgZAB4gxtw9QuAg/R9HLPF8uIzuZ+0joji5G26/jJLKbnIt7OVzcSaevgTpElpJWrO6O4qsqg+rf8rJwHe5KOsnUF1LCUzMOU3cv5FuKHQF2nkmPfzR3yQN9OvZi8HCdnddoWZfS0xGw3QCjP93n/qDpitntPicB/qG3kGeq9RwfmFBxaMG+P/gj7XY/j4k/AjMu6Mlo8p1oRG8WxuqeC33tq71y1frna1X//dhzJJy1B3GXgSdFWneL5lnnTPM27lSti23/JwW2FNY2eES/DaqIMutmK23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HG5pSuEOF+ctYFpt9+jU8iX/WBKsiZ9txO/eDns/QqE=;
 b=rZQrAKwzEXCI+6MxnkmJhLjPlxhuT4qqkDI31nARIgwnemGFqSLBb/CKDZZsWgZeLrFTCLqvhL0lq7cy81BED6sGoGB+v/X8tBsgxbxAtSa9RK4jdhc0jJHVZnMTXqkHGHRRsWeyJqYOcnT3B//J4uMpfBemfrPDg7xCDGQynNdzlaew2LwpHOoe7LZl5uvvKF82nZpe8KmPCy5JwS76ZAxrN6HkAub5HDcrCLxn02Q/f4V6uBs8uSJ7GlojCOBR3OStnV78YXxPkZrvA36cL/EO2o6W1RoXNREr9cgPrIrJBC4m4VORh7RoVZyE0QvcWOHD+qxHfjlQDEpDu8kgMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HG5pSuEOF+ctYFpt9+jU8iX/WBKsiZ9txO/eDns/QqE=;
 b=cT8A+RSsIbZ7DWM/7Ix2je9LaH5Ogq26MLKVdDMoj6nlqk7tqXR/tQ+hx9ACOgKR88mTMx3gWK2i/g+k2l0v3NtfvJeaZuDd/tmBQ+u9n+4Ll0Q+gSbVaMkXIrVXjt6KpX7TwrTGOG8nYxtuvc+q0ksbF37uB6C9+ROk/8EcUkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2018.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:50:17 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 16:50:17 +0000
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
Subject: [PATCH 07/15] PCI: endpoint: Add EPC DMA channel delegation hooks
Date: Fri, 13 Mar 2026 01:49:57 +0900
Message-ID: <20260312165005.1148676-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312165005.1148676-1-den@valinux.co.jp>
References: <20260312165005.1148676-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0106.jpnprd01.prod.outlook.com
 (2603:1096:405:4::22) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eafcd0d-3eeb-4239-bf04-08de80577087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5ULyGO5YCVG8vGaxSSc/TvSty1K6dtz5Dgi/Osaj5kCj9WANMkTbT3qcMw9lQ2RKrI4Z8ENTu7tezX4yfN3OFr3tebXH+k08DpfdHrjd/7qP1RPZzMv/Z33M4zWJ2b071YbjkL8Sx7rcfx9ekCG8gKfBViqkyp5O9VX3VI9nWAud23elEkuSKGOZxu35cNRspoM9DoBWB71DBHQFplrF5T2JqR4U+wMe2nL3YPWWr/3EWwelGzhV2zjXP2CD/x8U5wIL68pPtI2GDix2t+pGoAPk4sEHC5+MWBEvSlI7JwXx0lH+oI1ozRKELXffuM+HcfNCKU4K6z+ETQqqlxPLcJNjhXgaLoZA06DurUu5wWWoxFCLdyprhPYnbCdOO6nbYKcrEX8CVrfGOZDjfUNjbrKWgFIPTdrwpYRAjhjykkmzX0uvrrZmCH4lJFYRqYx8qcU9QPLML5WQkU69NLkcQ3lVAAnQCYtz1dJWM58wYQbDLZdmYTTU0UZoKSYpMar5fgkdqMMuMkRaCvx9lBtLB1ztguMXIoAZW2l/9mVtbCnOxNxkk6N7QO8g1XVRjRhWTX0YjhA8dV5t0D+MB7vr7bL7Abh6PfeZi1Puw49f1XrnV97iDSdCeFGg5+qpKs3ws+AomxoTb4bSQs5StfWKwQ7HUxjQ9UkSeEmz04Dsf/jPLA8WVEcfysvPCac+zbW7ZXsAxgJ0FyksywtMjMaTg+iYZ85R3iKR1OhoXyWHWthg9bVjfnJ0olMdgpxKf9wo76rYZMDnoQOW6Gd9pSrWoQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hQIYqW9F0gnKucBBD/0gXoTT0xnFFffJHA9Tgxcs3IrCLLeI3vqtDWDIovVt?=
 =?us-ascii?Q?cRggbQM02B2hzeSeRN4FZIqC+/+0KnbRa1yCieXlNzrEAZjvD9mmXPxczyWS?=
 =?us-ascii?Q?HVoU0SgM7s7Ow3uE1hTagvtHT+MllYtnJd0moz6jP2Kyf8WytrUOkNbc5qUS?=
 =?us-ascii?Q?8t+FaiWASL6+blqIUkiGFgK415n0pjJMcN41A1M9h8X2LTcjkJjlPbnbwSyo?=
 =?us-ascii?Q?jC8crtXkjW3DLi0Pp3iieSHWnhwYbLcyHzIzICvdy5GKEUCPc8fx0lxCXO+G?=
 =?us-ascii?Q?b8lNMricA5AsHV/0Xe83bKRp7/UjikGzTvSO1DiA1T2y4f3ausH5gzsqjHLR?=
 =?us-ascii?Q?dVioDahodERxXkdvqupZQrtQs2Xve6pxtpAboOIH47pHdC5CEmirnJT1zwdg?=
 =?us-ascii?Q?oEmhi5FHKeysQuI5x0X786HgvjiPJQrdwWqqc9uGz1SsdCNX0WCAo2+Tc3ND?=
 =?us-ascii?Q?u/G4s4xq6E2UUfps7uBHTKvlIdXNBmZEveQVGqi75BKRmnZLuTiTpiiS8e7v?=
 =?us-ascii?Q?qvOuTnOI2l3qfDyT8lTjWEADicQMCSnM+xJ64TRlN/dJtaAZGR6hz4pstuTj?=
 =?us-ascii?Q?QKvztwXXTPmnJw3/lR5V+bQKl9j09V1Z07BWXIL8jiAIv04JkOBFQ7QXdKId?=
 =?us-ascii?Q?Tpkcgi5MKx8br4eC1cN7hThsh9H1xFcGlSKGGaTBDlwQeU54KVHMIvA11gn/?=
 =?us-ascii?Q?gW91VMda3FDqXBx/uohMmzjH2MvnTWOLk5LN6qcH1c3gj8x29RBvwt7f80cK?=
 =?us-ascii?Q?mguSUooJ5aa86qQcACG0CbS9KYIiEdvwUObbtVfWNRF6Cll4ORlq5Y+7e4Xo?=
 =?us-ascii?Q?3I6jqNFmeeKw4DAN01Z+gaUafwM22Yh0l5SKinFlzAxwKJsDS4EBE1h8C9RM?=
 =?us-ascii?Q?VKSVw/+W3zjhdZNPRpcra2Xy/7iZAWcnhCgPdPivuXMEUmeYBOLfG1F+2UJO?=
 =?us-ascii?Q?XPutWqhZ/JzrtxiCPvSr6LMZIdn/GwVAUo7/Xi+1Y5N5YuIyH/o3kAV1oA8/?=
 =?us-ascii?Q?kziGKl2Vc8Xa335QGDffk/U5d8kvs/1uNLPaZIEMNrXiLCSF0d9/xFeW0vf9?=
 =?us-ascii?Q?u9CooFS94Gr15pEa9V4o6wFTaq+TY3KvLdItvZfElnsLtNIxDuzQ1ke9e3y5?=
 =?us-ascii?Q?VkDj+G2cS52q9sQWP/sa641RBoiZggziIcfA5Ev1ZIQ13W/fnL1jW9Fnwo8T?=
 =?us-ascii?Q?QkBfiAUbQVNVJeLkvzGWmZYv3bxldFN+U+zYv0ZazAvlwWlgrGHWuOPi0JQ7?=
 =?us-ascii?Q?6UFelx4kFMtBLC8DB/DT5DkrDxafJFFm0VByI9Q+d8uCG/l3HxN05HG1DCCy?=
 =?us-ascii?Q?aXj3sNS5+XD1giN3hpK8tPMdtY0Qkjq76gWA8aH5aidFAkUobZiFkyEqLKxI?=
 =?us-ascii?Q?o/z3y3W7YiFnH7ecMBy1wDgtlRF+m6vd84chQTEdTqQwzaKdZiWsYfS1KEoV?=
 =?us-ascii?Q?HCNA6v1xcZI0KwuSf+6ePW0tXjddmsN7JhRh5K6FeuadyFriN7IW4CmcZ0UL?=
 =?us-ascii?Q?eT8gXz6MMQ9pZKzsLnF+DpV/7gPSNEMeMB4gUAGg/+jJogvoPx5NC9CqZRls?=
 =?us-ascii?Q?B4KQFLWBu4sF4qCbq0e1Qin5Qv1M2DRgw6oz0j/Bwrqj7MSs2D3oBLozlyO6?=
 =?us-ascii?Q?adTBYgEJSVG1kGIhNH0n7DRBgtHIrx4352yMTvEMU+BPvD3ku5ohoEYzzX/o?=
 =?us-ascii?Q?dkKAIDPkkZqLfbPFkMNqfA3clrnyinSHGdkz5gEmmuWqR42Icy8UKSvPMaA8?=
 =?us-ascii?Q?x/92P5kWpAwS6D6yz698RDzPFFHh52hSNwIo1SIXPdAOd7s0NhaZ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eafcd0d-3eeb-4239-bf04-08de80577087
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:50:17.2179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mywHg07SsMbDILwolc7gXC3LqCrQZC2ubx1kjflkfvtNB5+FuTGAOEjdFNTlt1ofXIU4NghpSG4rg0gk7PdcqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2018
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9402-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 074B9276222
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add EPC ops and core wrappers to delegate and undelegate controller-owned
DMA channels.

The exported DMA helper needs more than a passive "delegated" bitmap:
it must be able to reserve channels away from local users, let the
backend perform controller-specific setup (e.g. prevent the EP from
racing to ack the completion interrupt for delegated channels), and
later hand the channels back as a matched lifetime operation.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-epc-core.c | 84 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             | 19 +++++++
 2 files changed, 103 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index dc6d6ab4ea1e..892f7ccbd236 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -197,6 +197,90 @@ int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
 
+/**
+ * pci_epc_delegate_dma_channels() - reserve EPC-owned DMA channels
+ * @epc: EPC device
+ * @func_no: function number
+ * @vfunc_no: virtual function number
+ * @dir: DMA channel direction
+ * @req_chans: number of channels requested
+ * @chan_ids: output array of delegated channel IDs
+ * @max_chans: capacity of @chan_ids in entries
+ *
+ * Return:
+ *   * > 0: number of channels delegated
+ *   * -EOPNOTSUPP: backend does not support DMA delegation
+ *   * other -errno on failure
+ */
+int pci_epc_delegate_dma_channels(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				  enum pci_epc_aux_dma_dir dir,
+				  u32 req_chans, int *chan_ids, u32 max_chans)
+{
+	int ret;
+
+	if (!epc || !epc->ops)
+		return -EINVAL;
+
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
+		return -EINVAL;
+
+	if (!req_chans || !chan_ids || !max_chans)
+		return -EINVAL;
+
+	if (!epc->ops->delegate_dma_channels)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->delegate_dma_channels(epc, func_no, vfunc_no, dir,
+					      req_chans, chan_ids, max_chans);
+	mutex_unlock(&epc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_delegate_dma_channels);
+
+/**
+ * pci_epc_undelegate_dma_channels() - release previously delegated channels
+ * @epc: EPC device
+ * @func_no: function number
+ * @vfunc_no: virtual function number
+ * @dir: DMA channel direction
+ * @chan_ids: array of delegated channel IDs
+ * @num_chans: number of entries in @chan_ids
+ *
+ * Return: 0 on success, negative errno otherwise.
+ */
+int pci_epc_undelegate_dma_channels(struct pci_epc *epc, u8 func_no,
+				    u8 vfunc_no,
+				    enum pci_epc_aux_dma_dir dir,
+				    const int *chan_ids, u32 num_chans)
+{
+	int ret;
+
+	if (!epc || !epc->ops)
+		return -EINVAL;
+
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
+		return -EINVAL;
+
+	if (!num_chans)
+		return 0;
+
+	if (!chan_ids)
+		return -EINVAL;
+
+	if (!epc->ops->undelegate_dma_channels)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->undelegate_dma_channels(epc, func_no, vfunc_no, dir,
+						chan_ids, num_chans);
+	mutex_unlock(&epc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_undelegate_dma_channels);
+
 /**
  * pci_epc_stop() - stop the PCI link
  * @epc: the link of the EPC device that has to be stopped
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 7dd2e4d5d952..db8623b84c56 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -142,6 +142,8 @@ struct pci_epc_aux_resource {
  * @stop: ops to stop the PCI link
  * @get_features: ops to get the features supported by the EPC
  * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
+ * @delegate_dma_channels: reserve controller-owned DMA channels for peer use
+ * @undelegate_dma_channels: release previously delegated DMA channels
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -176,6 +178,16 @@ struct pci_epc_ops {
 	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				     struct pci_epc_aux_resource *resources,
 				     int num_resources);
+	int	(*delegate_dma_channels)(struct pci_epc *epc, u8 func_no,
+					 u8 vfunc_no,
+					 enum pci_epc_aux_dma_dir dir,
+					 u32 req_chans, int *chan_ids,
+					 u32 max_chans);
+	int	(*undelegate_dma_channels)(struct pci_epc *epc, u8 func_no,
+					   u8 vfunc_no,
+					   enum pci_epc_aux_dma_dir dir,
+					   const int *chan_ids,
+					   u32 num_chans);
 	struct module *owner;
 };
 
@@ -403,6 +415,13 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			      struct pci_epc_aux_resource *resources,
 			      int num_resources);
+int pci_epc_delegate_dma_channels(struct pci_epc *epc, u8 func_no,
+				  u8 vfunc_no, enum pci_epc_aux_dma_dir dir,
+				  u32 req_chans, int *chan_ids, u32 max_chans);
+int pci_epc_undelegate_dma_channels(struct pci_epc *epc, u8 func_no,
+				    u8 vfunc_no,
+				    enum pci_epc_aux_dma_dir dir,
+				    const int *chan_ids, u32 num_chans);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
-- 
2.51.0


