Return-Path: <dmaengine+bounces-10627-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD1pBYO1DmrBBgYAu9opvQ
	(envelope-from <dmaengine+bounces-10627-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 09:34:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F355A0302
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 09:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 176263056FF6
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 07:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C94339AD3A;
	Thu, 21 May 2026 07:29:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023127.outbound.protection.outlook.com [52.101.127.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED837396D09;
	Thu, 21 May 2026 07:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348575; cv=fail; b=qUALDSoRMFPT+a6tN7avgA3wl0hCqATnlOmO1l16K3H7GGOC1c3l2E96rSOMpcsmlGCLsJoGagHNul4LyucOtNxYrNH6SDmVsla3SdAqmHmd9cnt6uo2pu5CIskB5U0yH+2nX5ptvSBAh+/hTtSREEigkbhaDBP8vP5e8y9g5QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348575; c=relaxed/simple;
	bh=/WG+r9qlyoh7o6+HzeTeb88wBvI2Ha9TVZZ+C0mlEyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdqJv0E5yXXd52J5P5qNbJ4ziJFfTaw+ji5QLRQdXe0C0m7oebXCRZJDyXS0r7WYKcON+BLa0ODk6x9lf7J5EqnibmKP5xh6bkg/8KlNLM0t+bA/qwCzYyrnc7Nc8+nYsPJb1BZQcXzlI7Jv6Q/UAU9UOUXcAEE9cB3/UAE7nT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1LN0yBazgW0blb1rHhc+hKO/o4KJhs1bSkGLr3RZUBDpMZF4OTkdT7g3Kpr7NL4d2Fb3yMUuoxvyPwpr2fWMrxGtqprGph1gZ+0O1GOH5nVB40Cl1iBVCdQuGTPBG57oNpM6L5XhJfq2n7Z2jXrbW6Ng61ncHQYXXeoTczALvKXU3U3EykA8zWilRRc7m9NJS3uvtnHy2TyJRyKHIMvq71aeb07Um7SKPdtPPPrcEvPXdOBKNpuhJQ9NejQcyPLaGVuHYlq4MyJ6u/TYvSSPjdAHfR4iJ6phmSbKEwzdzvcSC5OpfttdLiOkUbMiCXDKnBIUNGhvm5jUEzADRFpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RcfmK23eMrZnuQiyO8pwAcvBrQzk3ZRoKwBv/3RIco=;
 b=nXQSvXNHtA3bTy5A0WA2bUe5KjA5CPupTuSzU4XNTblDy5vNsEa+2LaiFVxFy7FKgJZdtRedGqmPe9PN/DUabAr9D/a6/f6K/5vdNbrxCVCgM1LxY7QYR1rSxLEWDgFBCJpT0mGM3jgIvUOxSCcvhs1w82rTGCDZJyZEjnpd4kiwaEdE0xEN5dmCI/thkxvX8D6MzOxQBod22Nc8C1iWtUZh6C6iOFztUFa4VJlvKpsAb1aNKnQ2PRrc2zCrvNVuONMpw8mP01TlHAalqCUocvxCIinRjFBSFALuLVfpVUepWqOngJumZl5wiuJEsMkz+MGIN0CqfsbarmL0LxPKpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR01CA0154.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::34) by JH0PR06MB7210.apcprd06.prod.outlook.com
 (2603:1096:990:8d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 07:29:29 +0000
Received: from OSA0EPF000000CA.apcprd02.prod.outlook.com
 (2603:1096:4:8f:cafe::ac) by SG2PR01CA0154.outlook.office365.com
 (2603:1096:4:8f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 07:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CA.mail.protection.outlook.com (10.167.240.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Thu, 21 May 2026 07:29:28 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 86FB441609D1;
	Thu, 21 May 2026 15:29:26 +0800 (CST)
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
Subject: [PATCH v7 1/2] dmaengine: arm-dma350: enable ANYCH interrupt for shared IRQ wiring
Date: Thu, 21 May 2026 15:29:23 +0800
Message-Id: <20260521072924.3000282-2-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521072924.3000282-1-jun.guo@cixtech.com>
References: <20260521072924.3000282-1-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CA:EE_|JH0PR06MB7210:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 69bd018c-f766-415b-beaa-08deb70ab15a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xYNIPzNzE9RUD/dG4XBw6hsqSZBuUuGXeXgP0KoB5pDoTLpkJWNl6g+6jp1WdKAfKM254ZYNAILkOl2tdzUQjvOBUn8upR6bQR/2ViB0jrYv7MkVD/C2uuf7881iRP4OgKPlEbUI5ufAT8T9kBQwNqoJRWfXitHbSZ8Nup3RA9jTMrbLwHJ+F0zAcM6hYFEugvNdNzD6u0rzMot4WHvhN3fMz6NzZsfFFb+Unx7Cgal1HGtAIF4I5XeqJJpq6dO3jTypPxGQirRPPFnbxeIVbJchx9WxmbmO7rWQtPKlXYS3If9BwNfwHjrZN1ExI9HVAJCGzV9HpTeSSnqnOiQJxAuyGdbI7/jW/QXbPvudfDjur9Kfu+mC8AlWZfS7thVeLWv1Y5/j8fYNUuZ/mn5djDEFEET6Iwc//pLaBMFfXwgxPWb1RTdZm4qgws7JYvsz3Claf5PXPwca7/H59PSi5XW5Am+E/HMDFdj39RaYTteJ/8QdmeZ0PjF5n3rh1Jkj7oHMu1EWfswwqbg9h6b/Ea63PZXLdztroLu2dz4y1FEq8w9icnsTiDuGcCO/VLCtWVv/iwl39oOkKwh5Of7km6WB8nDvl+nfVsYPbut0dvbxHPiCO7rFLVzOqBuMmy9igVlNS4ZS6c4TDsNct3CiKd2EShQr/KY2dWkEJZdsOQQvJYYZ5fR23M9ThKxka/aF6Fgm6Txo6ds26uOlbJWUSQZm3sl8EZdwEj/uwpjtTej1zmwzNA2Buv0moPrKXqdPBT+hziYh9c6eJ5NAcCqdgw==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7UMuOIDWE+t80N65kWd9RJrP6rQKkO5lT6sDtdQ4/1FRDxpM6oCzI+EoyHPDE7LQwJ3rxGmd0iB5upumrYtqM/nVCphvr7WVU7ntN95k6O/HrWUJtz6KAR8LaRP+Ahk3nev36dYj4EJls+QY7Ce8tVM02s1mdqlXBKtq6NWCDvpXCjCPwpnZtxZ+XO71YLeUoS+xm2e16JHIN0CtT+mUTHDKZclV2QDkm4t+on7K7x+8Ljn6RMjaS9Df+H3nxS/EqsRUIqnfHCH2jb91Wgo6svJbD/WZcZbap/nQdbfzYfSuAO9kfVKitCm49cPAK4MepK2/SSiGhIVGvTksCcFSOfigHjz47/q2bvrQ1VW1r+P13Gj12ChUJOQBme5MvE7ouf6AppPG4CwwstmnL6bQffgHlJnFjs6+36SwueDczy58vZzVvsFfdRkcdNEg9N2T
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 07:29:28.3849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bd018c-f766-415b-beaa-08deb70ab15a
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CA.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7210
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_NA(0.00)[cixtech.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10627-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A7F355A0302
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


