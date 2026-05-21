Return-Path: <dmaengine+bounces-10598-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO0FNcmmDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10598-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:31:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7F059F6BA
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 056B33025AF0
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1B9395256;
	Thu, 21 May 2026 06:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="MpqRwl4p"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020112.outbound.protection.outlook.com [52.101.228.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3A73947B7;
	Thu, 21 May 2026 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345086; cv=fail; b=HZ5GOY2ZRRn5mZURhihJVwL/cLeVFXE5GgJl64mXtwjnOBgE/6dBAKJNhFSyjQ75IZa38GHINFstxim8dwUvSkqfHKDuLNISRRhFr+gVK0BRiX10zRL5jVjpODlhuQrVU5/3ZOGuhcXYJIBAq9EFyD4D7pqqbRLwxbeoxdInC6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345086; c=relaxed/simple;
	bh=z9dthnFDfK0fb4BcLCvo6391KaDSt3GcadQwebJgcFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XwoYYM2hENQLCVOs6WLRXSziK6c0ANuN+gnguJ8f8zZb+q2aUr6gdKQUVTW0W50GTW3CHWdhLFbisNGdUAZ4IFsnV1yNhqoN7+N+KHCaYTWIefrwKOaqPFrqJMnEvRVPQuEeYn9ji0BI7ZePd0PJ2NU3LM4U4KO03g63xMb3mb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=MpqRwl4p; arc=fail smtp.client-ip=52.101.228.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSN0uW8IiCDD5do+Zjht8dyMLmq/fXGUJNgbSKcL98fzApjymWqkEF2ZU62TlO+qfKxCr3q4FHnnlpWYDDisbiwQfRxLmo5S0NMEQy89Pj333mwzPAW51nho/0V7KQ32NP0+ecLC/Us4a9MtPpxq435oWjOBWd+kx1qhMa0pptzAEIHwdBH9TOPjEzLRt9dzw6dz2P+jJWpBh1IC1oxrNLZEcwCuIJlnK889IH10sOIgxRnQFa4hq5W+f1W9IcVN29wS1yASuoeDnjL32I/+uVUfonZlOLrIG8KYKYMBHhD2ZHF3/PlXUwiDk0UHuT8qaAqiq4Mye2wMbji/2BXJDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eM62hhQKNLmQINaiT0PtQjSGiD8UIYCSbym5Hc89HTo=;
 b=Qva+rR/luxb1wbViw/h6pCdQcytaPPjfq+Obqzf4/skT7k72a3fImcNs8EI4Tf6hnG3B0ZKL20lLyNqM/nJxXy5MfNLR2nacGaKUgmTxB83g7tjWgY4lX3BfdGYltFCZFMtccFMKtlpvL7c2YkJeWFDFTGJOf0ZfEsTLhvn5tI6q76isqeG2pgH/DI2ML9iXLLvBkjltKVbFbe0horYkQlRjWiGpTP/WkKeld4SbqZLyuLvf1zf5epJjrCc7q+f2caUCd8GQr3Fh5aKj3EqYjs9hsS27TSvxrh1leKOv1o4EFMLCu7exO0hNthGla5fizrRcA2tSGYmgow+77uoV1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eM62hhQKNLmQINaiT0PtQjSGiD8UIYCSbym5Hc89HTo=;
 b=MpqRwl4pXl2H+xlmAgFWnL7qRKbu9yESnEjrX5wu48YIqOs3uqJ8aRvFdts6GQ6WWnpLeaNvWnrxSs7s13mpjSPg09ba1b18siYaKSHq/NuYUTpoSDma3W5JhFkFcgWOX2PMA8ucXiJ6RH1hZ+ArAuGfkOuNO5eKEilFukYigo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7818.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 06:31:21 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:31:21 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] dmaengine: dw-edma: Add channel lookup helper
Date: Thu, 21 May 2026 15:31:05 +0900
Message-ID: <20260521063115.2842238-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521063115.2842238-1-den@valinux.co.jp>
References: <20260521063115.2842238-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be1b565-6809-41b1-22ed-08deb70292a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	G1IG00n4ssfROzGgOAwqgHeQlW/B+0c2wkbcMABv4Q8IwvK0htxhZV/i0X0tQ9cUb28yiBsC1uAMKQFN4CWR+i23rMD9R2vh99uwqSsellP0TKMVF7MHcsU7UCBCRYZE8Xjzt5h7sMe76SYfVajdTDNaiMmWcsW2vT2ditL7dCZd6osMZMRZK7CPp59NaAEUMb2dOIlEuw+UygclBywl+NzM8Y2iqzhxiL5Nfg7UaZDVETtlvewZEvP0SzMmJtx7/B/ZCx1X/qLBOkR1Cvj044L1mhFvhBL+iWrDlAfsGCHMzH5RyThq6/R6VdEnlLNq3nBQheoDoOYr9YiWzg45hq23lY19rBzKvBX8ro7sYWosQzZARqJwnsOYYHhTV0osmmkzqNRwSq49S6JObJxRm6gEyZIC3g9Orv8FKdNeZDf8oL/X2NzbM9H6W4dLf7dS+wYvumjFR3Dhb4APG85Cn/PVUYF2iKcvYtXcHCM8FI33GCqvfdid533rb5MT/R977yoLU1cOjjIFGUzJgrfMOi4PizlVwtY70vbYm7iOqaFTdT0brTgvJu5mcc4TplrxSoetv2H+fJQxxkfeVV6nfSGsHknws1yhbeyvUshVC8fNCxowFPyrOiTv5eAMNjsNbK+EbeUAqFohXL2QQmh8z/Bch71XtX+77E0oD4gVyKKR5GMu4tUxf9/dGmwROCbq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tnu6GS/R7PmA/4CyKg1MBf6tDh6/SUKZYmndo0r70+Sv7JRGdW6zNX/ST7Qh?=
 =?us-ascii?Q?mHx6cHf5eIfLIXC0h1xz6oUzs93U6HawYUYqWkvvzzDEbXvSSy7ARuPFCNwX?=
 =?us-ascii?Q?yRnJWWNAoktNwAGud3JHSxp9PlssoT3wzyS8Lo2OB2qklYIfU2LWFIXbvGL4?=
 =?us-ascii?Q?YYTeC4mz+jDHYp0x6yhhpLENRCikZt5EvU6THxDMTMmF/9V2IgNdgQDTvfkF?=
 =?us-ascii?Q?2THRNz4DFk1CbL9K432NVp3mbs2wLH8SU3PJgdPnj5YrVhFR+uf2/WNNWDdU?=
 =?us-ascii?Q?WsB07RVRHQmD2iR5MezB0Hh9EyZmZYkU3cl1/lgMsrLZmy3bGHN+eZfzSd1n?=
 =?us-ascii?Q?LBmHSp+uovsZokcjaP/d0h/ujZBEAJsqInqEa/+FBydWT3vfAXKNsFkGrRQ7?=
 =?us-ascii?Q?CBTg2I0i8mMg22m/01UlRW2IHoar9Uh8GTfqRBpQ4T3REptSC6+myzkiEOIS?=
 =?us-ascii?Q?JJQoZrR7Fw6+Xq0hqcJHE+C3pirzEwc+MbQSmaEEPS7GcpgdRvlqy3zq7nnH?=
 =?us-ascii?Q?oFZB+brYt0lA4/TZOdIGK+wGV55fnPGV8WTE5MAv8cHfft+U2wKqNOhxLn0o?=
 =?us-ascii?Q?0dMxqyi3lnVfUUNttkwfRnSH7ihz3w1rR8CvSUIp/8OHBQVHnKSol/e9hAhW?=
 =?us-ascii?Q?drCPMr9ofyWzsjQ+Be2yGl5ahk8p7UVTmVndEP1noLjFUgqKq1DcOFsHz9Tn?=
 =?us-ascii?Q?GFVziBtk2DIXUjaWdCOB+ZT9zBV2SZa7rH+Z/+quybkrkVXb3uF98vsboTSb?=
 =?us-ascii?Q?QIugB9nw/OEFrfBj4FfV1lAYMUfyrMsD9jJvpDshx1Us3qxfdfUN7A382q9N?=
 =?us-ascii?Q?HcKVxRq8fgvr8POpYPNxDbNelZAAfDbaN+izeV3uk+hPvo5vC4fuDRKveraY?=
 =?us-ascii?Q?OlUyEKWJeNXk0IqDv3tx/+qoirxQbCCZ6aqOlmoqsjslYdOIbBr7xqdG+nXz?=
 =?us-ascii?Q?DVNLK1rXgucNYoM6xHc8fAMNqUSgwIyZdricph6EMGpzQtwFwG1qtG6Wm92A?=
 =?us-ascii?Q?E2RNQHcvNWCAbCmBCZzRFOAxGOSLXDZ6gujwkF5iIGh6/Eb5AkaKGRBQ4uJe?=
 =?us-ascii?Q?GJ/gSYpl/NPj9qLUQy50wsu1Mph8Ow9ziPo8defdnAvMpOthZS1cVfWeailU?=
 =?us-ascii?Q?gG6hfoMOZuc0mlpJu2beQuscLB1BEO5aA7QGEvUEOnkBTYeQejqNTkggmFK9?=
 =?us-ascii?Q?c5MaAtaOlnLZCnp8231urqNbDWIsJhaGbeEcs02XEPeQ3ITJFx0XlRcy4RHf?=
 =?us-ascii?Q?XJLY2jKR8CNL2MdNgVQkjmYUe5Exiq5HpCxAyN0sacF6e5lCEzgoQ1vHcO9f?=
 =?us-ascii?Q?KPoYNgfdL/rm26L/egAZF2iMUc+AK9l2xNuOYqKBQXmvevV2rKtmeYLWwgsd?=
 =?us-ascii?Q?AlG8vi9XrG8TRjH2TRa5LXwEp2wMm8Z/HoeNNijxXWgjJDjP5uDfSSTZjbgG?=
 =?us-ascii?Q?9OgsF2wRo2GIWlv0j91ViSiqiuqNAvuKore38MtIrA6EKGF3jc8RqG8ipirR?=
 =?us-ascii?Q?ytqJCRamvUvHYD2SG+i1IkULKVbKVfN+JeBJeR8B63Re6AAQGB0ddnwiYS21?=
 =?us-ascii?Q?DRt6GPX1Y5nCGS13kEnfQkylcT8Sn9DjGlDNfaGAbGt07+gGovvmzvsoz2Gm?=
 =?us-ascii?Q?G79WCQPf8iLuxWzLjlkOQvp6DnpV9rHYsCjbSdJZ/cRYyQP9rVUKicpGCBaZ?=
 =?us-ascii?Q?G4cTozuDL4HQR4gn4MQgcstelyRkCtVYEi00URGdMOuNrL+Pl+I9ncbOfVql?=
 =?us-ascii?Q?y1lmmDi7yHusxL3IRabXuB3FCSi9hSMKoo0Hb5j58D237et0Qp0q?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be1b565-6809-41b1-22ed-08deb70292a1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:31:21.1695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11PGmmXQEcS6BtOvlBXaNsudWn+Nfwe8T3Jn+Sy3etnCt2W2Q7TgsjczSOptbVjhz2bdYo+7/PbEYl9gsZXu9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7818
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10598-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 7E7F059F6BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a helper that maps a DesignWare eDMA write/read hardware channel
number to its DMAengine channel.

PCI endpoint resource enumeration uses the pointer only for later
ownership reservation.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 32 ++++++++++++++++++++++++++++++
 include/linux/dma/edma.h           |  8 ++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c2feb3adc79f..6660380a1bbc 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -1189,6 +1189,38 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 }
 EXPORT_SYMBOL_GPL(dw_edma_remove);
 
+struct dma_chan *dw_edma_find_channel(struct dw_edma_chip *chip, bool write,
+				      u16 id)
+{
+	struct dw_edma_chan *chan;
+	struct dw_edma *dw;
+
+	if (!chip)
+		return NULL;
+
+	dw = chip->dw;
+
+	if (!dw)
+		return NULL;
+
+	if (write) {
+		if (id >= dw->wr_ch_cnt)
+			return NULL;
+		chan = &dw->chan[id];
+		if (chan->dir != EDMA_DIR_WRITE)
+			return NULL;
+	} else {
+		if (id >= dw->rd_ch_cnt)
+			return NULL;
+		chan = &dw->chan[dw->wr_ch_cnt + id];
+		if (chan->dir != EDMA_DIR_READ)
+			return NULL;
+	}
+
+	return &chan->vc.chan;
+}
+EXPORT_SYMBOL_GPL(dw_edma_find_channel);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
 MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 1fafd5b0e315..b4b42b2278f3 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -110,6 +110,8 @@ struct dw_edma_chip {
 #if IS_REACHABLE(CONFIG_DW_EDMA)
 int dw_edma_probe(struct dw_edma_chip *chip);
 int dw_edma_remove(struct dw_edma_chip *chip);
+struct dma_chan *dw_edma_find_channel(struct dw_edma_chip *chip, bool write,
+				      u16 id);
 #else
 static inline int dw_edma_probe(struct dw_edma_chip *chip)
 {
@@ -120,6 +122,12 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
 {
 	return 0;
 }
+
+static inline struct dma_chan *dw_edma_find_channel(struct dw_edma_chip *chip,
+						    bool write, u16 id)
+{
+	return NULL;
+}
 #endif /* CONFIG_DW_EDMA */
 
 #endif /* _DW_EDMA_H */
-- 
2.51.0


