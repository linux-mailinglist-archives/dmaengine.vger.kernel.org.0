Return-Path: <dmaengine+bounces-10625-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I53KGu1DmosBQYAu9opvQ
	(envelope-from <dmaengine+bounces-10625-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 09:34:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B375A02DC
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 09:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0AE630234FE
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 07:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5B1379C5C;
	Thu, 21 May 2026 07:29:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023123.outbound.protection.outlook.com [40.107.44.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E8399039;
	Thu, 21 May 2026 07:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348575; cv=fail; b=Bz/XbmsoCWHTR6yAn+QlmzNH4uHlUOLOLxA1bkkq0E6fRQKPSEgu49iYHSNVhC96/bYnfvZp1XWTTa+2cDfAuHeGD6FjCLNj1PJF/EVRlm1m+BG/R/2xqlFpiVN9SCItOCmToyGJ3+UpUkrqQH0u0Hr5xnsGKJRcrR+ygMcJyz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348575; c=relaxed/simple;
	bh=HYkwSF1+DvBufNm2Ewk4k3jImkDzwCBdm12gtJIriZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZXa+8X33AIDLG7sC8ir6mTBBYF4DFZDX18OOViVGRiqP44OwZ6Do5i439+ab6+PCccWBArf0q/uBNpaT4yx1p/Cfu3kImLRvMFO4jSKp6PxEpHYlkVLE4y5LNVOphpB5blhm0DQ76qO+qA1CU1EKNlnzqrOtxqh2Hak7xCeI9d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkIeVPCdn+4Pc3Zpto8j4keeE3PDmW6ZBPd1SmwSPKLS+rDUtlg/p0WzeMtg6KjwwEZOk6gawSEbe8ettbBZ6+Xqz6Oh8U8SwkcUUvIwqLkUT+4PwNjKNv8ZWVV9Kvq3YmnW9M2eD0H8aIr+NBL+A0xvRO0oMGeya9NqB4bGruSGAAhF73SytTWFDVC6rdmoH/lbANq3z0ArTUNH9gyJaztGJwJMgGt5+ZrVh+l3CNPECTJlFTecY3fs6NgTfaoigSJnSHunJVOVC9z9+g40H04m4mEfxJz5JwOGx/Ta4pJyxQbsTIXB3VLXRCNdVRPo0Yaw9bV7lHiRRhYbg87tUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NFEHhBIbJD1YCyMXcRYvDkf8EG7neu+txkBEQyH45Y=;
 b=lO6QoCtFL3B+hSu+f6evkrnULvlk6kCitbK4FidHoBCAWtEnvE0Ic95TgJdOsMxY5UgpnCdJWMQgb+wrY9ifUfiVtLlwpZbNI+dNgsLgow652+a6NsjnPwbe9VcaiydKPWD7Atr0zXakmm1aK3GzaKRrDjTBbBHCAeC2jqxPUDihvbq5lNe8avHNbUj9j2V+Muau740kQJuFTbjOhW0jSi3II4mStom9ekQT2BVrx85wDm4tDfXbvWr8OhZ93Wg6uqkJpW8i2P8wSLQQ5kz4JkOTHnOSM/CtLr62ZMom15ZWcYIfSc2i18dHr+p6ebTgT45USIUG2nePQR/1hJXbrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0060.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2b5::15)
 by SE1PPF4D95A16FB.apcprd06.prod.outlook.com (2603:1096:108:1::414) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 07:29:29 +0000
Received: from TY2PEPF0000AB88.apcprd03.prod.outlook.com
 (2603:1096:400:2b5:cafe::fb) by TYCP286CA0060.outlook.office365.com
 (2603:1096:400:2b5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 07:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB88.mail.protection.outlook.com (10.167.253.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Thu, 21 May 2026 07:29:28 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id EA55841609D9;
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
Subject: [PATCH v7 2/2] arm64: dts: cix: add sky1 DMA-350 node with channel IRQ entries
Date: Thu, 21 May 2026 15:29:24 +0800
Message-Id: <20260521072924.3000282-3-jun.guo@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB88:EE_|SE1PPF4D95A16FB:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 43d594bc-f59c-4da2-e362-08deb70ab169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	46TnyAE17GHy5OP1bdmiwOIo0Ojl8viM2pUXPjlNUYqHMoffPaD5ETDJ0NVT8EAfFo9p5YaM7djnb8LqQ5GNppFlomA1KcVoEaJD4RBro+jifNKDG9RbrhofB0ts7PEFp4nRgEqQsjKDyVSNIzhCC794hCnpqGbRxKftl+FNfxAwIEPCzIqOa2Gq7tNw0rVSlpN6y6srmLKs1NOkGU3YW3XD+SGeJM9WccP5SoEAhJWkg2+JW49TWjc8ef0wDCsz0sLzV0pfcGDj5TTHVggPnKNJeJK6SYLPea52pU3Lgigw/QvUCjJIJ9OMhcsfuULVkbetM7PJdD0qhLCJGArPGIfyK0jGOBsseBB8gAe0dPGmn6CLlMmQZ2YT773EWErKO5aCaU1R/OVCDS35hz2Y7RSwNcB/bxJNwf8CTkN0+/R8koOJa6yDa4fCRGwjGJxH0G2tuev8XlPA+EFpJUh435R9Qq8A+9BBVqN6ezapeLNsLb6iWXo45uYulDWwEjMvufRfhUePHaugvPgifklrkALf8Z9wec2EFumxbcTcOrX2SZuZIy1UF/0ekhenPZncVZM6dXGdXuGRtMLTbiOcWKfA4jl6ANPFboHNk+ATPC+1CjQPyM4UMHuZWrHB/oLD8bnnv/OSdlWE4l4XgQ4EIf3crmwNib2jsNvirwnXAM7rXFlyKiA9dKNCIA3Q1r8492KwIMK6QDuNafA9gPOUVrT1v+HRAyDjHmHatSQ9TXCDr2rh/NF1Zy2ZEcarU7/WJyyWfmpvdETGwR/gqeg+5g==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(22082099003)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yRjxJU5iVjQlAJdt0WacJl0Oc9KzXVCKAW1fTvHmsNKgTRNSXYNEZlDWOi86Ef9b7Zyk8t95tS06p5eRk7i7j4VNvUenkpBPEm/c92JmER3Vaie8Tfp6c0/OF05STQLtWristkcLy3UtjoH8Yef4Qws7v/oSvpLghdI/Z9eK0wrLJ2WNnSSL64DMk1zor/8Ar9UNtwotxTwXjxUUh+UF6JSuBpg/+xYui+0fM3JsK/8+g37hOkUWkVtUgniLPd9tpnXuH6PiCxVum+a4+1kO+ZSnAXdJ9rUfEEYVx3/tvDdgyegW0UBS+HrqJ49E30PlOrPR3Y1tfXJTB0VwBXyJLF64lhFK1Zdhghj54sggVsEFAlY+sxWGuc+HYq+wpBamQqIaOkM1YFby58WLVruUBQChV0gKhS49gtPqiYUas1WR4frnRBIBUYw9q71N+z8Q
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 07:29:28.4949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d594bc-f59c-4da2-e362-08deb70ab169
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB88.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF4D95A16FB
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
	TAGGED_FROM(0.00)[bounces-10625-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: E8B375A02DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Describe the DMA-350 channel interrupt sources in DT using 8
interrupt entries, while all entries map to the same GIC SPI
as wired on this platform.

Signed-off-by: Jun Guo <jun.guo@cixtech.com>
---
 arch/arm64/boot/dts/cix/sky1.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
index bb5cfb1f2113..823adeef51f1 100644
--- a/arch/arm64/boot/dts/cix/sky1.dtsi
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -444,6 +444,20 @@ iomuxc: pinctrl@4170000 {
 			reg = <0x0 0x04170000 0x0 0x1000>;
 		};
 
+		fch_dmac: dma-controller@4190000 {
+			compatible = "arm,dma-350";
+			reg = <0x0 0x4190000 0x0 0x10000>;
+			interrupts = <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH 0>;
+			#dma-cells = <1>;
+		};
+
 		mbox_ap2se: mailbox@5060000 {
 			compatible = "cix,sky1-mbox";
 			reg = <0x0 0x05060000 0x0 0x10000>;
-- 
2.34.1


