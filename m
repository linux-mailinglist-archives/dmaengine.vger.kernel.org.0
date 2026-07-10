Return-Path: <dmaengine+bounces-12277-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QroUMmCrUGqz3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12277-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:20:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4284273860B
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:20:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=QdbAiDOe;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12277-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12277-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34E5D3009503
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D586E3D45F4;
	Fri, 10 Jul 2026 08:15:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0B43EF0A4;
	Fri, 10 Jul 2026 08:15:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671325; cv=fail; b=k+peyVHG96unQ6VCHr3o4fdt10icdevj++0wDbxEuk+xSiVvzklBAf7gKRCC0G0MvAbcVcPP+Sa2mzCpvYTZfVO3kpxP1A+HYmWiTrXJEKoLiqwzSTAmBq8sylf4fTlvmVKN2Kk4aF5ahgA1b57MRNPnrW69DtsY7QcLANRMGM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671325; c=relaxed/simple;
	bh=FXct80RiQtwmL69ryA3inHdFfh0FY5rJ5BbnMSKqfKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eQqgjqnU8QIUu52NSv/0tm4BwDHfUY3PgsS2Z+bDD5sFHYv6QGRJp3GMHf7ZuQxDXocRhwEuuP1ChU2Ev10Jw5c4vMrwXc01Tk95QMQi5P3UH1MIG51jmfBNChmgzWW0yXJAu+L+aTb6QL7Errpsds2fYlVim1rGp9l1aeM+B24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QdbAiDOe; arc=fail smtp.client-ip=52.101.229.113
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAbkh2SiBFD/jhrPfyBMwrXg6a5/o+K7qJhocUC7GUaG/cUrnGS44RdTVCTrTcVgcysN1E1Gx35Z6BAyLjgIHyJRWqhca6a1Va7w4OWffesNiSOVAZXmai7btIAMwuI/72ptFgXljVl73P5mnzxP9Hv8ARtLj+5JQlCNImn1UWWfzFI1G8M/gsc3sQV1Y7Yky7u9/0o0fuEeY+2YiMbmV0x6wmVVNAKRv08KEblw+UI0n/D0lEwzCPknKMWCev2wfdaJ96PCodMGqNAB91WaRbTQQShgTK9GNsHH61Qq58uMOWmaCUqw1rcmUVZXwp/uvOI+Bt8PLDQghzmnvVN/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gpRR6C4VAWl+e6BXnkSZz6l8XwK7W/6BOWR/jQIgsE=;
 b=Ok2nyWgOGF8Eic/Fy1VinSea/Npz9cGMBY665CPm+M8Dy/hpxyOm9Cxl2XXQYEoSBQ05cgGBINxwNrqIGBbms6XpoHr7iN1l6znkH3tgV+BsdAK+WN0TP1HV8JYstzgaDYwWFdl3BxLhZd2lkICMlH2nYzHx6cyIotGSBt1XGfbiwlAdPfxum1CSAj2ftPkZnigST2m8VUJH9Ju01XWFWx+wP14hla9ZONQbQPjBS6hBEw0DA5lTR+w8urz2hvKg+BYc16uKna6MmCSlE6YH/afD0CJJkl+o7Ho5DlrqeF+Zk5EHkxm49iVkKieAqhZOAfSDCIlvumQ+CFMAtkRY3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gpRR6C4VAWl+e6BXnkSZz6l8XwK7W/6BOWR/jQIgsE=;
 b=QdbAiDOeEMiGbqGtckQP69K7LZxJmclNlGQpgrIu0Hvbxry1K9tPICt5M9fFb8Gw6d79jt5EAbn5WWK5J5NI1POi+3pYq4Bxm/zhf09ARJvYdOdEQfn0hIiZ0Q06svm3LoWCSx1I0ku53GfzReMrucdDFF5m2uttgZ0hWmH1r8I=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6307.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 08:15:21 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:15:21 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/14] dmaengine: dw-edma: Factor out HDMA interrupt setup helper
Date: Fri, 10 Jul 2026 17:15:05 +0900
Message-ID: <20260710081518.2394357-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710081518.2394357-1-den@valinux.co.jp>
References: <20260710081518.2394357-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0090.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f6bf2c-31ee-44d9-11b8-08dede5b62d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|23010399003|376014|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	IG5vOWzcsEt2HTgoseVO3LIbx9/sccGysapfbzKINISCFxIbkh/37mOuE4Xd19v3zWT6kTc/2K0+gSO+01MyN8nICPVb0VJ9lBGp1zulz+ca0Hiqrmjm3tMTb7nWYSTbXk/6HYoNWK/XGWldTqYWtCoCZduE9+9tHsx4OIiXZ7LjZcdbo1uTtpS2cu4o1QWNAs+w0k2x+pIG1JfVH6gKNyfOjCm0gU2XCTRHeQae62CGm8AIFVRpxZS5gz24O4WAVWf1jnVEljfBFYKPnnAnZ4iZabBLNWPs3R2VhSwonrNwWFJH7hznFbqmbb6+s8IKh7OO3L/7852XMXBsxOHTAv6OEacT4UwyX3oZhnE4T/lGG6ZhraUwlpQ+zP+tcOBfNGgxXv53eMFDbZ2ZnKJ0HA0hn8YNI5z63K1rE1ufxbhlv+plgXe4bZ5Zf7YQ2S6aXqDDzs8ds8VUznaam/A/5/P0qqEGwNog4kPSbprc8EMaGKJAkx96fjPCF5QuI0sFJA6VPLNHndxpzCE0/Vo6+ZNIm3wfbbKyEJJtq+HccVMck7KIk/hnQIBHMW766aMO2Fu1dkrrXBZbN8xO5Vgnc4rNY7NBVvWR+p6tQ98TCzFsbJEbOW6lGAs7BTGvh0cT6Lj5kqUeQ3nH1BFDyAA98MWcH8N/+wBdYwcePFrNE7w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ek229Gyryj07bRluMEMwMf7a4h07tBx3QFrTdXkkJ9O/M3Uzd8RXwINKLOhQ?=
 =?us-ascii?Q?9nuIw+bNEwb+z88JwfXsiDQ6RSyL1M3KTmrwJLDNAmZsx1PnD3XBYSTgsDF8?=
 =?us-ascii?Q?oNuq0KoJ/WYNtp4Q/1xub8L7rTDanN/Tr6zOuv/F8ABRdmBHaDX3+wibr2ak?=
 =?us-ascii?Q?zfUMQiqpMRY0A98fWuahRnhxlVvPIuoksm4F1qxabFG3wkAVYVlFkThdNRb/?=
 =?us-ascii?Q?XgPiSGIZw+pY5vhLFgLteFqtPsEps1rLWA0EtXA8z6/CuqEIH857VVpelfd5?=
 =?us-ascii?Q?6JJrwxFV1aiyYW1aszNCYNM1sieS9DJt55f/YR/u+Sxexzgc5VN3vteaxZYb?=
 =?us-ascii?Q?wwDkJj32v0f36h6gYNQCDHpjNKXQlnUZdXux6+nYsAFb3jTJUm6Pqcz4Yp+X?=
 =?us-ascii?Q?wSqBt8MiFK47d6VNItGK2a11fukFkPC4PwaCF10dCUxVGtPMksYCMJyKTmoR?=
 =?us-ascii?Q?eeFwFkTyc3GgJLC8Mej4Ab9sTgt4fQd1wMFK731uJ3n9ikXiS3mixGtOX2HK?=
 =?us-ascii?Q?I99fz58SMEpJCja+TVlsbt8V0DizLPZGgv6xBibDIwMqKgpAzfiNS/0tYvr1?=
 =?us-ascii?Q?q7KYIxkqW2PY80zHErl8AN32WbxTuWA3/B7jDuh/vzq4uGNryuyOTMYR5Wt1?=
 =?us-ascii?Q?qH/rHiy3KAChe2QzqJ2W2+N0V5Xv2Ml2HhDQWen9SWgdEDfwWhkACLKIzUGd?=
 =?us-ascii?Q?Lp9o4+AHkfJ801z7HhWx5Plhruk/pVMk91jkPgEML+yJjW2qp2vTpZQGJiWU?=
 =?us-ascii?Q?kQ79cKbRbO30LNDo6hmJ2Z+fIYFSo/oGiz+xDWvYR3bURpEWPWPxGACR1dFb?=
 =?us-ascii?Q?Mjfe5A/pCtAV61LGNFJ3Y/SgG/W3jtlLxXL0kpxvaFWKuqjTIzE5T4OKnCjE?=
 =?us-ascii?Q?6uifZ4M23eXuMF15+w2VHXkwAT2s+NLWuPd9hZnBAUWKeVwcVO+RzM61mgIv?=
 =?us-ascii?Q?s7fLR5FxaKgE0m2vrmUWZL5Llaw2SfUn5tvlra5FmV9HCr5EKDRNyyEcWd0e?=
 =?us-ascii?Q?8Y3S9Mz/q7FPwSQ0kXv+awIp0zPkatx6Eeac3HTo5wOS1pdf8NK1FjEDDdAa?=
 =?us-ascii?Q?uqnw+mVXrUKPTdVhDxDecbwHk8JrxRAWlHkIf6iPM7hkKST8by1F5+AKpbcT?=
 =?us-ascii?Q?1mVbZaWt1lFrJmDRmEBTg9ViTbKxho4KrNvNXSspv4JHa3w0F2WXY9ipP1tz?=
 =?us-ascii?Q?2ZvRFb8yaOSgxyM9RlLlx0IaUFyviFSO6uPgee8h/RQXTGaGlxOPHdwIHxC0?=
 =?us-ascii?Q?3tcpL7ojEpqDE/XSgdikd6PfDeLeEWuAs12LJp35T4R54rGrVMraorZ2h79+?=
 =?us-ascii?Q?DlIQBHJUVlGqqhUOqLI/zY03pqBLyuL7FDndbzAUMmUDKNLtH66aCPrDGidi?=
 =?us-ascii?Q?DOC6+t7JbFmxmCQQ3anMCyLy8jqfHZ8It9XBp0PeGeFYd8yCscI5IH8lEXxL?=
 =?us-ascii?Q?JnDJFeZt4PJw7VCmBGQQ1kP6My/7lPtEEXG+LQ46HA3F75PVSTfFxvbdqUJk?=
 =?us-ascii?Q?KdWPQlSrSgrV/FFpip+vmZ2O88zHhAl4i83BgOlt8oGQrZ3oYMCJ1waS8KB3?=
 =?us-ascii?Q?kGcQ+1vKfDnJCvYxtMNx5ed4nB1dJ0YqoKWxWPJtpd8jpQT2Ch3zTKQR1oLX?=
 =?us-ascii?Q?XcUFwdjVPnlCnnwc9o4VOBkG+0G/Vo0K7DOSAGk2v2Zc/zADM9TRpsjTvBtI?=
 =?us-ascii?Q?9GBlHar1sJXzFQzdhxYZpCJUAULm0Aj8uGrijygxeaKIuEDJCPBr9CyoLYNf?=
 =?us-ascii?Q?Fz4hj1D7aPhJ+vcH/xgejtvKsO0liE447thXH971Mp2sgrnPSmjS?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f6bf2c-31ee-44d9-11b8-08dede5b62d0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:15:21.5053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6zLJsHORn22aSI8aWLRS9YoMIlkeWZ8DAwVHh26aqV3ehsiRaHf8RgbIHWELnoUpdjc3mMGMp30OL+wM+DMPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6307
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
	TAGGED_FROM(0.00)[bounces-12277-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4284273860B

The HDMA linked-list and non-linked-list start paths both program the
stop/abort interrupt setup register using the same local/remote enable
policy. Only the interrupt-mask handling differs by transfer mode.

Factor the common setup into dw_hdma_v0_core_int_setup() before adding
per-channel interrupt routing support. No functional change intended.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - New patch. Factor out the HDMA interrupt setup helper before adding
    per-channel interrupt routing. (Frank)

 drivers/dma/dw-edma/dw-hdma-v0-core.c | 34 ++++++++++++++-------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 2beec876b184..44e7b6c1263c 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -50,6 +50,21 @@ __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
 	} while (0)
 
 /* HDMA management callbacks */
+static u32 dw_hdma_v0_core_int_setup(struct dw_edma_chan *chan, u32 val)
+{
+	if (chan->non_ll)
+		val |= HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK;
+	else
+		val &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+
+	val |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
+	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		val |= HDMA_V0_REMOTE_STOP_INT_EN |
+		       HDMA_V0_REMOTE_ABORT_INT_EN;
+
+	return val;
+}
+
 static void dw_hdma_v0_core_off(struct dw_edma *dw)
 {
 	int id;
@@ -238,11 +253,7 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
 		/* Interrupt unmask - stop, abort */
 		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
-		tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
-		/* Interrupt enable - stop, abort */
-		tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
-		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
+		tmp = dw_hdma_v0_core_int_setup(chan, tmp);
 		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
 		/* Channel control */
 		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
@@ -293,17 +304,8 @@ static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
 	SET_CH_32(dw, chan->dir, chan->id, transfer_size, child->sz);
 
 	/* Interrupt setup */
-	val = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
-			HDMA_V0_STOP_INT_MASK |
-			HDMA_V0_ABORT_INT_MASK |
-			HDMA_V0_LOCAL_STOP_INT_EN |
-			HDMA_V0_LOCAL_ABORT_INT_EN;
-
-	if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
-		val |= HDMA_V0_REMOTE_STOP_INT_EN |
-		       HDMA_V0_REMOTE_ABORT_INT_EN;
-	}
-
+	val = GET_CH_32(dw, chan->dir, chan->id, int_setup);
+	val = dw_hdma_v0_core_int_setup(chan, val);
 	SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
 
 	/* Channel control setup */
-- 
2.51.0


