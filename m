Return-Path: <dmaengine+bounces-9642-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGdsA7fHw2lKuAQAu9opvQ
	(envelope-from <dmaengine+bounces-9642-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 12:32:07 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B85323EA1
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 12:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D53130B6D4B
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 11:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEA13CD8C3;
	Wed, 25 Mar 2026 11:22:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022132.outbound.protection.outlook.com [40.107.75.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ED93C9ECD;
	Wed, 25 Mar 2026 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774437729; cv=fail; b=KfbFqKFVYO1dfZR08Nok3tzlSKTHRym5AvYRiB6o5lYrtfZn0ojGd/mDWu7FnKzyqlU3mot8y/bSBSXJhgxfFyUxoKFz+pqZLp/eiR1bNmFM4gVovSy/Eok9cjIgk6wSDTpKjKVAmkopN4KQGQmOxtQkLVJS1+T6p67GUw5MG0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774437729; c=relaxed/simple;
	bh=/WG+r9qlyoh7o6+HzeTeb88wBvI2Ha9TVZZ+C0mlEyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKXff5sjhSrhQT3iqSYoms+0UCYlhyQK9ga3ZHZ8OW73UxZxU3AY/2MYrqjDDHlvcfbFdaLO5J1ySN3wOVHJ+9Tkw6sYbxwVpebXpAn9Q12EppRIXhz6vSvhgnXnrSdzjPzWFPygbT/lCa2VsRasyh+BPbE5OayUemYl2giuTGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5EuAb/+EpWzto9PY28s875SlTXRc2rr0CcHBnKUAd8GAS4WjO4qn6oUYs403zbtLZUIuo0cOdoxPF1O/45FuyNPXgurPnd1ZrRkCMHXTZfIrb7pngW0CZF7K4u38sN73XLbuJE7XRHaZS7g2fYjxJGdhcSwZA1AwcYb05sxtLQwSZDGsYrmRkisekKLS2jFxeOIsY4HZ2No03oWNNyms/73OuG/3jFb2rx3FMmUWH5X1Htk//kxLlnqQKdD0V03wA7qgAMMo+N2aZ898fQun/ZCxolvqY1v/aAFCz0xcGGKA/eaPzPNHVrW5yrmKLvs7dwql5DlpaatkJU8RX7uCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RcfmK23eMrZnuQiyO8pwAcvBrQzk3ZRoKwBv/3RIco=;
 b=yu91o7UtRBiLcNVDDjn+HgEiJ4OSESbVf/OlxDT+iVp1LEaNLOpwLxd0PtzQGgfing+Owq36cBYbO0wwZM7+Cmu7TibiQBEoW9PQ13JuIb7Io8Y6GUmpL39G+dKwtY6BV6gPDXkEEzGesjx4vEwBAvazDHTWO2HxQq6grMBipx65TQahDgj+ABWA2SLbEiwcrVkT3rJXkXH1/t+APDJ9goNxNzHQ0HA9P+Au1xWmyODoQWIMkZvmsr+wWgAOErZ3YDwD0TxIokgi8M6BqPzzB932x8A35wIbDAJTjSSsmKGGAfokI2yB01s1STBZ+5vNevAzJKoflyrBPJmjRBi/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCPR01CA0031.jpnprd01.prod.outlook.com (2603:1096:405:1::19)
 by JH0PR06MB6581.apcprd06.prod.outlook.com (2603:1096:990:33::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 11:22:03 +0000
Received: from TY2PEPF0000AB83.apcprd03.prod.outlook.com
 (2603:1096:405:1:cafe::19) by TYCPR01CA0031.outlook.office365.com
 (2603:1096:405:1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 11:22:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB83.mail.protection.outlook.com (10.167.253.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 11:22:01 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 473B64126F9B;
	Wed, 25 Mar 2026 19:22:00 +0800 (CST)
From: Jun Guo <jun.guo@cixtech.com>
To: peter.chen@cixtech.com,
	fugang.duan@cixtech.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	robin.murphy@arm.com,
	Frank.Li@kernel.org
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	linux-arm-kernel@lists.infradead.org,
	Jun Guo <jun.guo@cixtech.com>
Subject: [PATCH v6 1/2] dma: arm-dma350: enable ANYCH interrupt for shared IRQ wiring
Date: Wed, 25 Mar 2026 19:21:58 +0800
Message-Id: <20260325112159.663881-2-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325112159.663881-1-jun.guo@cixtech.com>
References: <20260325112159.663881-1-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB83:EE_|JH0PR06MB6581:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e4343c19-d5fb-4620-f9c2-08de8a60bcb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Wph2GkWum0a+qatuj4Q+14An9C0GYd2bANsWI66xI0OXvZX/tKVADknTLhIRUfQrofqr5rL5VbjLjtX6oj8Au/eZ/r99cktloXJjvelIHWbkLvbpVJnV6uQAxaqW2t9seF0Hs9o4e+mc2d/jx86sVsKSvR4hQufVrXWTS86qzHZmk9gsaSKjnUkQVOyC7zBTLxZ0Ytf6IQEBFVDmZN4HNeUi3iYvG4O6txnnTrPwiPGJgOPmvqqieteFOAHPXrnBJulDbzxvNHiN6JavFNrmWob/QWZ7ck7bTrnW7Q9ufzbSKm9pzV8+g8IJ0vHuEhp/4l4fwtv3eRtjd1yn2RGjaGyE2Eo4UEMIzkLh2HbMr9AleX0zWBQSHEFl9SO2gQM+IO/8uvIXmykbgtQrmtXndTNhEyAUEwm3TPnJ0OLPU+NziHRox6WCOsd3VIm06nk35n5bZlYGVKDlqUZkokon324VqQfWARLDvO7Q5rdk+/lN0410DGAY9Ig/lzjgGDlDLX6PS6xG84qCzlQW+73jAiI3TbXDP+0PbWzAjmdlKUfFBrfi986dqawZ9D42uySKhYYTLBemsU3VpaRuPma7hLX/rTbZCQABulwFoIsMIQfZ2/IzhLmf+I8Mivb3n2xXq4VD1l7S5onbu2SjeDFM4N5BoYJ3Mwm24f05mxwgQhWobVbV/lkkD4H9u1js1WeRUD2Z+spTpViLcVAz/dOgUd7b299u3uXaP4ITq9LiNFRoF0woQxAcx4prNlGyYWq8t2aq3WsOmViP0zmiQHLXrPa4uvlgoSdu10KRJzxPXhYUBTyNgxqhBm/VAEeN/pTX
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rLSgBHwHcuKpu0xowvsPGP0oS8C/yvn4ZgEOWKtGQWcEPjIa16CMDX4WCj/9oNDDKBHJmKNyd/tTITINdxKXG32oJUclcy5C7Ltz/D0LN2h68ZuCsLJVI1nbDqN4/pqd63qUExj77nstNti+G25irS2m8Y1OgvwW7UChveBr/N/g256e/YBwjKe5lmVlb1s0544BBHanE4KIhRLM9RtwWAkasYly0Qa7h9w7aPelcT9SM482hpnNHi730/NacmVwQXx6HZoAvpEu8yeWitfafjT+UBjhwcuw9uC7/nTyk33i+iF97/PwFNUmFinQMSeQQp1/udIMbea4NDISMoHxbMhGxx4BioUHdTU9Cg/eR1ZUL/Uqa+1C9qcagXryklxbOZwhaZS44u8ga7nNcWK3YaJGnv1phBjqAhh42ejoT0Xeaa67lbZ0HiPX/g74+mk/
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:22:01.8228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4343c19-d5fb-4620-f9c2-08de8a60bcb4
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB83.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6581
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9642-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[cixtech.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2B85323EA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable DMANSECCTRL.INTREN_ANYCHINTR during probe so channel
interrupts are propagated when integrators wire DMA-350 channels
onto a shared IRQ line.

Signed-off-by: Jun Guo <jun.guo@cixtech.com>
---
 drivers/dma/arm-dma350.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index 84220fa83029..09403aca8bb0 100644
--- a/drivers/dma/arm-dma350.c
+++ b/drivers/dma/arm-dma350.c
@@ -13,6 +13,11 @@
 #include "dmaengine.h"
 #include "virt-dma.h"
 
+#define DMANSECCTRL		0x200
+
+#define NSEC_CTRL		0x0c
+#define INTREN_ANYCHINTR_EN	BIT(0)
+
 #define DMAINFO			0x0f00
 
 #define DMA_BUILDCFG0		0xb0
@@ -582,6 +587,10 @@ static int d350_probe(struct platform_device *pdev)
 	dmac->dma.device_issue_pending = d350_issue_pending;
 	INIT_LIST_HEAD(&dmac->dma.channels);
 
+	reg = readl_relaxed(base + DMANSECCTRL + NSEC_CTRL);
+	writel_relaxed(reg | INTREN_ANYCHINTR_EN,
+		       base + DMANSECCTRL + NSEC_CTRL);
+
 	/* Would be nice to have per-channel caps for this... */
 	memset = true;
 	for (int i = 0; i < nchan; i++) {
-- 
2.34.1


