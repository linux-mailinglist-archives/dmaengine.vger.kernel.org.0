Return-Path: <dmaengine+bounces-11659-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id McO0EMLHNmonEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11659-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:02:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3716A9483
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:02:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b="rTbR/SdW";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11659-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11659-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 622A9302BBD9
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306B725B08D;
	Sat, 20 Jun 2026 17:01:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020079.outbound.protection.outlook.com [52.101.229.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858FC26B971;
	Sat, 20 Jun 2026 17:01:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781974880; cv=fail; b=FgmVJgXhBfsNXLkIl0/915OsdojExOPBTtN4eijeu7CPesK8FKAOYr/LqmDCtNeMVCovZgGRC+dL8JoP254Dnu9JTEmhfW7cAqbGsYJsO9e4tbDv1Pli4L9ZTLwd+28BMgPxZCdQMXPkhXhEd4MFwUtimVQLof4ibgxR/nfmFYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781974880; c=relaxed/simple;
	bh=QDz3Q2C0EFrSVqUVmg7REKHws/2y+sYIBjIpmelkA04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hjtag9L2RJbGv1I9IBR9mlDeXxznjYmsJlfIGbyT4Yjf/wd0mfvfLxDGfuxAz+Gr6/cqqCoPEGh1qab+WyvfhiT26zroAk4Lmz09HNdLm7NfFTPC/a5tRocSOnKpeuv2uJg4xTt9/n1VxlpOMUJqgC+wkSnNu0rx4VLHNMrUCEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rTbR/SdW; arc=fail smtp.client-ip=52.101.229.79
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfoIEVfAQUmqmIm0BNOwf0VRalxlCYxRuQlPL7hDpglaEYK+BBkyusQmkvMdEOmQeCXhu0xWLjzm/s5DdG4ZS/s75w0hLuSoSe6u2hL/i0ofvxF4hrH8h+V8CatImAn5ov20XOO26nh6WCoo2azOAuz29Ble2hPrDaUp4XL4XbeNB0aVKCqADsNLutTZrpOI2iTi6Wv2eFaT5OK/qgksC/4LOROGgO6m9XPmcKu3uetyp0DnYeN2mOwwVvLPseeXCi9SZDKpOotHLjNQKdsqbQjDGxnn2VCtnpi8Utjquf6C4BYzwGV50BklYxeHOXzU/ZvfcOvg7GCJiOXKzI7PNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyWlbseSt79EP9PKfuZGI+A3mt8NnRT56CSVVpixyUg=;
 b=kN4/ZEz52s5D/CZKItVp6EQdPtKj/TJxIeXTmniYWNe5w1F+9G+/ToSZhWDHkm30NNs19OElgKT7i0Wzzrn56i3JBF7Y2CW5VusQ8193xD/mA6xlxZhcaMtFyKrOmJwIj+njWviScUrsDjT7rOcHSq/WYbYfvDex0Q8nRy4thpPgcvZ/JiCYY9EVCHKCl5j30cCbS8tIY8wIaL8POw3+9labkbGzuW7MvOwkOwcl+x8GTZ+9SSpYIlQftKgCUdbsmmBdqsQri33I3nSDoBRoAYC4DJ2feu74IYQI8PyIWkKys6VdeIFKDftfq55oS1argD3kn4WO3Di8TEYlTCEzYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyWlbseSt79EP9PKfuZGI+A3mt8NnRT56CSVVpixyUg=;
 b=rTbR/SdWNgb+ZgSv1kljL/8z4btiNwmbS5GeCHi8mo+lYupb8/E/lKRG12R4gGj7HJ+as+tKlVJk18ps45EPvwtAnYdGI5zLQMwz2t+MWnwyuRC6s0+nKa3UbA3tmL51iKIppRNp/FrnYhe1slpTClJJZk4hK9PLYfcRpHNNfXs=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2673.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sat, 20 Jun
 2026 17:01:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:01:02 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/13] dmaengine: dw-edma-pcie: Handle optional data blocks
Date: Sun, 21 Jun 2026 02:00:39 +0900
Message-ID: <20260620170040.3756043-13-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620170040.3756043-1-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0083.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf33ff9-8e7a-4407-685b-08deceed828f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10070799003|3023799007|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+9iQOfj2I9WsEQaMHg2sihQGyYTafsIf2ySWxJmMu53ea/qzgRMVwG2SmKpkBdTqZdg9viQNTY2/M2nQiTxfLgqvy0dnIHVmB4TyOaa9EzHkfG4gJDh4swv9yK8zBgTpZpz5ExxhhETkF3YqpeoctpbwUL+RUZKrEEq3Zx8q+s1hM/5vWZUkJ+X6UFtQZPYBWVsc6iR8uv+iszg8mzfoh0FRVzLk0h8omkQD0h4/1CwbI/LM5MqufiYmuPDIHt4Ya5cjtsZutRzCsqSwpHZnVcc1PjyVU9NIoyQy/7//789Bhcy5XwJaBu/lRmotGr/u+TZMrowm0RpvMcojLoXnF3KzwOHyqK3lNdL9ToQUuYXSo04+1BmNAroIJv3kGbtjDxQ9e613TaxJ+4NcRxkBJhvUObl17GXbOMmbeBIkwJPikhSGaHXD9t8GjVIOFg3usmA9/wueBha/Gq7nxpedlVWp+v3PRV87Fo+cSLsQMZpjL5OUKxzaQIaPoyvcIxFlW2UlZE7NImJzELsZsxGmXSRIH1hlhg+zHeCMU8hxAO06gcZLMcl+PNQTI11otDc3mzh87haQPxu3kpqgep+VYgPjP9bSxj1u/yzKPKCMFWHTQHZ+NfEKW4K713n6oJb/ycq7tHY5nneyFFbpvDhO1QKTDZ99XKxBFEJnnHSJqJA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(3023799007)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p+6TITWcgrurDrDhBio0OSK1PDSJrk6VAcc0dYXG8ZLscUzx5S8+GWjFmFQ2?=
 =?us-ascii?Q?0uQobBsP9gM47oRqw52UcfEklm9UeLtj0UwcOn7w4ibxyQRy7pJJUFol5kCW?=
 =?us-ascii?Q?SAEOdsbgMHBqX9KrrrFR7UdFV4agjdyi3gC41N7xR3WmRfgwhXNrQT4By7le?=
 =?us-ascii?Q?7EGY2CzB5EjsANt2SUbxoe2B4KsmsZLSTs2tAX9ix35npGnEV9Ubmz7EpufI?=
 =?us-ascii?Q?FbQCdLqQmXPp9+ny0RS61cz8qAHoO213SHJ26RHzC298jTXrsTqEjsQRZKun?=
 =?us-ascii?Q?OCQB6WyLLSgJ5CKVxHVqfrLm2ChQOS9CVL2+4VsuRYs/WSQRiK+R3bIS9IqP?=
 =?us-ascii?Q?A2DwUFjjheIkoE4Ayy6d5DOLtIu837xh2ihAFZGN0l1A9gfWzwQjtp1plXAD?=
 =?us-ascii?Q?kmUCsq3wlOxw7+x1fHBHsaQHUOBIbGkTYmumcO+H4Xb34fYL6J6Wmy6gNbtF?=
 =?us-ascii?Q?iAPolV6Jame5v2n/GsD8uJX8FO1Fxxi89DsapCyN4f+NYBg1ngQ67F7HsUZX?=
 =?us-ascii?Q?D7Aw9nUb9RhVs5y4nbiCnwvg1Aoud34biAOY+HhFO9AI1abqgclYgxzZkUsv?=
 =?us-ascii?Q?TMf7XECopkr6dtMjpoOoPD7A+tGkwc2G5hTPD7e+emnfg+mNUFp4DfibFkmn?=
 =?us-ascii?Q?IxP7seK1onycn2hYnZbiMioL0+/XAhTsv+0TOR7vZalUJ9Ri1YJYVv/A8QEX?=
 =?us-ascii?Q?VSocKufEoEigxfZbR3kVnehBg76nUgdFBj1tJBA7k/hKMr4ucvFsbUqDfj3n?=
 =?us-ascii?Q?ckTWpgNcSS9iEOYWGfac1ybJagJgSnqqC4/ZDj6Hc9B+2c2sSE/iUwqcKy2v?=
 =?us-ascii?Q?DkVSO8vRnfHCmJ48bZFf+a353LPaFYKrsa+J4V4K+tldrxFqqquaVEswqUyT?=
 =?us-ascii?Q?91GpdqSNDdPckRE0QnnQyJ5fiI7waa0/CnjfNPbskwLGC8eJLgsSlmil4jE6?=
 =?us-ascii?Q?rgsHO8ITC8k+osVyab7GUP7UHY+xoKRZE35m3zWv/blPIHwVdfqfP+KAudnl?=
 =?us-ascii?Q?BabTfsV64KUnkFUA/nNb32rWOna13cDXsp1y4CboSYOpSstLXPBmxq97OJvk?=
 =?us-ascii?Q?DDcDbx9EV0VipTCNxa3M5qrUZCtolGMhFHPthjOcOhvSh4VJ+YGMSvmWZpId?=
 =?us-ascii?Q?Wo9fe1XL0LLWnr05p7zNjFaEDvKImlnGTj8BOQCMg7ABn6qZg7gMHRNZwaL6?=
 =?us-ascii?Q?HSu+5MchAnSWU9NKYFTjKTCZxaZIOu9UZ9iNcWAyaOfV3Xw9c8kDhBylxpw9?=
 =?us-ascii?Q?Of+XqPNtV97+Nta7Mr/D7q1YfOP8tpX+34kN9tZVVZP0m5adOuB1jsUu624S?=
 =?us-ascii?Q?42K2uWxngwRD78b1Du+8KEZSgLQkpqWw2R3xqfy39hS/JkT+6hRiuVEqm9tL?=
 =?us-ascii?Q?D3KVVPPQCqO3+wGRGKDvkPK23db7ss4kqzhJ/1L6MdkH7/oYIWoygzwUSVP7?=
 =?us-ascii?Q?yBQ1UfRL8oan06AHUWVR5qvQ+4qtrCFc6zefhPzWYWmKKJ/zlf5OCULEayu3?=
 =?us-ascii?Q?YlMiJ4Kd+NKmK0uvyen1vDk8g82MTNqwNauRpAk+kF6p6P65NhZLGp1SAyRP?=
 =?us-ascii?Q?H4O0xs2NkuaLBTSnJZFScQ1pY/UcqcFDuu9xBMUI/Q+DrbPb8kK6ZrNqWJEE?=
 =?us-ascii?Q?pKPTaJRp1r+sUjxTDTxbznLZQBsi2j6xz3QWCEm7TYh1140nhhuFodBV4kv+?=
 =?us-ascii?Q?umJpsyAxGXBkT/kaLCkxU8KE/2fUlcwLVed+GSfppQlITZdxbfVe/f62f4de?=
 =?us-ascii?Q?0k2mdrJiiCn0PwERSEyaYAS3H1/xMMGwebSPQUeLkK4o8tYiwhBT?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf33ff9-8e7a-4407-685b-08deceed828f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:01:02.6615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsMdV3gdQbLNnrYKYMh1hMRlcMSmhnSXmZycrRwYJtdF3R5V6fj+NdMzIDEdcCs/fnlkwTyjbmhNHCWhNxms+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2673
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11659-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF3716A9483

Skip data block BAR mapping and debug output when a channel has no data
block size. This lets future providers describe channels that only need
descriptor memory exposed.

No functional change intended for existing Synopsys EDDA and
AMD (Xilinx) MDB/CPM6 devices. Their static channel descriptions still
provide data block sizes where data block windows are used. A zero-sized
data block now means "not present" for future metadata providers.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Update commit message to describe the AMD (Xilinx) CPM6 match
    present in the new base.

 drivers/dma/dw-edma/dw-edma-pcie.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 62740c8c3f93..622ec974a521 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -430,11 +430,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	mask = BIT(dma_data->rg.bar);
 	for (i = 0; i < dma_data->wr_ch_cnt; i++) {
 		mask |= BIT(dma_data->ll_wr[i].bar);
-		mask |= BIT(dma_data->dt_wr[i].bar);
+		if (dma_data->dt_wr[i].sz)
+			mask |= BIT(dma_data->dt_wr[i].bar);
 	}
 	for (i = 0; i < dma_data->rd_ch_cnt; i++) {
 		mask |= BIT(dma_data->ll_rd[i].bar);
-		mask |= BIT(dma_data->dt_rd[i].bar);
+		if (dma_data->dt_rd[i].sz)
+			mask |= BIT(dma_data->dt_rd[i].bar);
 	}
 	err = pcim_iomap_regions(pdev, mask, pci_name(pdev));
 	if (err) {
@@ -498,6 +500,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 							  ll_block);
 		ll_region->sz = ll_block->sz;
 
+		if (!dt_block->sz)
+			continue;
+
 		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
 		if (!dt_region->vaddr.io)
 			return -ENOMEM;
@@ -523,6 +528,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 							  ll_block);
 		ll_region->sz = ll_block->sz;
 
+		if (!dt_block->sz)
+			continue;
+
 		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
 		if (!dt_region->vaddr.io)
 			return -ENOMEM;
@@ -556,10 +564,14 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			dma_data->ll_wr[i].off, chip->ll_region_wr[i].sz,
 			chip->ll_region_wr[i].vaddr.io, &chip->ll_region_wr[i].paddr);
 
+		if (!dma_data->dt_wr[i].sz)
+			continue;
+
 		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, dma_data->dt_wr[i].bar,
 			dma_data->dt_wr[i].off, chip->dt_region_wr[i].sz,
-			chip->dt_region_wr[i].vaddr.io, &chip->dt_region_wr[i].paddr);
+			chip->dt_region_wr[i].vaddr.io,
+			&chip->dt_region_wr[i].paddr);
 	}
 
 	for (i = 0; i < chip->ll_rd_cnt; i++) {
@@ -568,10 +580,14 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			dma_data->ll_rd[i].off, chip->ll_region_rd[i].sz,
 			chip->ll_region_rd[i].vaddr.io, &chip->ll_region_rd[i].paddr);
 
+		if (!dma_data->dt_rd[i].sz)
+			continue;
+
 		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, dma_data->dt_rd[i].bar,
 			dma_data->dt_rd[i].off, chip->dt_region_rd[i].sz,
-			chip->dt_region_rd[i].vaddr.io, &chip->dt_region_rd[i].paddr);
+			chip->dt_region_rd[i].vaddr.io,
+			&chip->dt_region_rd[i].paddr);
 	}
 
 	pci_dbg(pdev, "Nr. IRQs:\t%u\n", chip->nr_irqs);
-- 
2.51.0


