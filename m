Return-Path: <dmaengine+bounces-9521-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFEsKFXNu2mXogIAu9opvQ
	(envelope-from <dmaengine+bounces-9521-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 11:17:57 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B5C2C9590
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 11:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E218C30157E8
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 10:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7BF3B4E9D;
	Thu, 19 Mar 2026 10:17:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023136.outbound.protection.outlook.com [40.107.44.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD93BC687;
	Thu, 19 Mar 2026 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773915460; cv=fail; b=GUzoBy1OFG9L83MfjZbz8oyvucyFeCfPP2bOUHReetOH8JfWWUg5Z914BDsMWt7olHIySlgKQaMGHsqbQ42XWdm7qvgI2zcrCECx3n9lIqqtUtalIC82x463jGDoIENkw9kZeZx3jOlO/NutSHJy5WcqIqlLpe9U6RSHHdZNdg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773915460; c=relaxed/simple;
	bh=1Py3gVRfRkrtVglFLcD/stoVf+ek/SXZlDC3hFWN+8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgsPdume8rPvzEWTjqSLSJtbjH1R9HlCPh6nMZnn7cjQgpJeZNpyPxjV7xi8pZgTy51i81apGwXPYPqXu6HsAcz8P973zrq8WAAqrOHGc9DkupwK3sf9nEt8E/MmmQqMV2VWkNDe5Z3sRRog594fc7uCvtD0hbffI4XqXN063FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPK5TJSdr1cvEs1ME+IN2s8C2PI1yTfiF2ue/pLXj15BVbOVcGJxbKDXFEUMwuViL7uwwUDX0Dak0xZxvQ9OP5Y7IaysECnpdzk+cENzyLxnxckJkw/UNSSSEtfYBByowelHlYpudueWVZaMBhyAQWKwoRkd3tB7dFs1buyyJG5jmpvHiwUrgf76Ipg+W48HJmWS7Za11ixhQ55hHtxl1lFwNdzzs32AQFn/OkxIX7/JWRc1CpDt7fNzm3g+BR9BS3DoDZf3OkqNv/niCTzqUNnbtSnMkxIhhTBUdyC//BdDJMveOoVI2B0yH7voFh2qpYIAah2MpZZ1zjgnFY2X5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6f+sfGJtGMAJL4D/I6yB+G0Bp/5QHjdEYrU9z9hHaE=;
 b=PadKfzE4RRLlQ2Qv0sT0mY4AvPfAERCzq+IQ66z5dugDtuMMrj8d0PCi9BnW33nUX7rlybH9HliqwLUk5wcELpL+JtnQuGssna8Udk4QdyKhfNlUWGFZb3k+ewtNEUNfWr9Otui+hFK3Jwyrdsqou5zAnvJoyQ9N5imrJleV7QE6qmc5UMOJT2wXlSGyRb/4LXYUQHFnHBH5oNbOI93C9jIZOdAYVsaZdnuHuEmcm/sXioSWRLHk8tBbZ/hbnvswiiR+tV/kfho17Ou3Y8ZFMmjreFcxGzFWeLf7ACXThL6YVznhqCF7u0fr/80a26fZsw2wISD5M0uJj+ezK8QyeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from OS0P286CA0059.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:9f::10)
 by KUXPR06MB8008.apcprd06.prod.outlook.com (2603:1096:d10:4e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 10:17:28 +0000
Received: from OSA0EPF000000CC.apcprd02.prod.outlook.com
 (2603:1096:604:9f:cafe::60) by OS0P286CA0059.outlook.office365.com
 (2603:1096:604:9f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 10:17:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CC.mail.protection.outlook.com (10.167.240.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 10:17:27 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 45C674126F92;
	Thu, 19 Mar 2026 18:17:26 +0800 (CST)
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
Subject: [PATCH v3 3/3] arm64: dts: cix: add DT nodes for DMA
Date: Thu, 19 Mar 2026 18:17:23 +0800
Message-Id: <20260319101723.246539-4-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319101723.246539-1-jun.guo@cixtech.com>
References: <20260319101723.246539-1-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CC:EE_|KUXPR06MB8008:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f4610684-c8fd-498c-c963-08de85a0b8d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|7416014|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	OC8VFPAwIy117ZjG5uqWzrqbKOpMFfI05hnz4bF6WXyzy+ZXidMbLwJdICe8WErYh0sXOTjNmHmFkf4eyKkBiimePZ9CVBS4yE+UrlbCV6FUiyw23kjpJjQ9t3wE5vmQNz7WFgbANO2I5BN0VZgs95E+gGweojsNazYczs0DdmKJxBUWNipC6yheduSk0EkJ1zAq4TNOAKJifLL7skYEGmbqMd0dXHTUo/gTU6/UIKahqxp4bDRAPysJ7whWILa3fnFgswlWgmFbFeugt7SH5fndY+j9sssBNqL/nNERJ7B52HFec+tA7FjnBvLIkq5ou0vH3kxXH1ZU68ZwcNmbltfMPt+e1xndhrE+FtD6edI8yLwdb5LL+kM4LZgzHTVrb9BAc1bQsFnQSAl5j5/JObEb5x8aprRMbv4Uvy+nn3H0/Ub1qCknbuZXJdvDZrOv0Yq3VmdSMvJNA8n7DrXROJgRn7V1tr3PZOUvelOCSh9usiytEQKCDWHMTsAf+E4nxGqwtORM2WMRG4+Cs/mvt9VVcaLBLWWND57D4RE1bPFOhsC8b9QvMV6/e/lWGXc/P7zSm7ixucYEZXBiDdR1Xok5Uo3IbSUCibqXj9t3TS2pxyBqt6fJEDvNPdM5uRucHuhFrHsGGzOzP2B7wzPV4+Q2ezi+89wuYfhFUX3MIUa+qlJ6mZJF8lLwXfgT9pM3v0EO/x6yOPqGlwbRpOHPvhQgoxEyBSI3p9W4F50UsN+RRipgct7hHSlmK19THlKOOABAbPCSlK99zuOxaOc1orGsMGpj7gXfxfafxkdcole4fvFniWb7i1ezlRpNPicy
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(7416014)(22082099003)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Cgz2nTyihN7Pg2P6yluiLK3zcHTyd7/7JzEpK+BBXUqK3SPIMm4ssVsfuIZn/gRxU6yrw5VePBBR+RGlR8KA/dVHI9rTnodXbGn/xIhW5bLcHzk6fU8a380Mn9d0fyoZrQ6BsRHPAMK3Q/9aChDnliP3cq4nNV6HXOgpwZhbjVAminNZemjyOYS6NpyXb7LVHlqDxALueXVRrbvWI8VTmWFL/RWOQYg1HmGmPuoxkEPK00uaa97FXonggq3GhOkxwvoLkkuf1uhohGppnN5x6eyQEdNJPCFowd6BZ9xc5pXeWqKRTG41JoFRxSjAcXyGd/cZUNdWpYNxsWQbPhwb+Hk97MIwz6bop5enUrB4MXINU9uNkOvn8kbaq7br8IaXS/BSoZiQukYpy/Cs5n9LP6MQg3U2qUz3WkwxyCDHSrGRzqiJ3SgQlTIFUcTN4s7A
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 10:17:27.3475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4610684-c8fd-498c-c963-08de85a0b8d6
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CC.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8008
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[cixtech.com];
	TAGGED_FROM(0.00)[bounces-9521-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.279];
	RCVD_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	DBL_PROHIBIT(0.00)[0.77.53.160:email,0.63.161.16:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cixtech.com:email,cixtech.com:mid,0.63.239.48:email]
X-Rspamd-Queue-Id: 10B5C2C9590
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the device tree node for the dma controller of the CIX SKY1 SoC.

Signed-off-by: Jun Guo <jun.guo@cixtech.com>
Link: https://lore.kernel.org/r/20251216123026.3519923-4-jun.guo@cixtech.com
---
 arch/arm64/boot/dts/cix/sky1.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
index 210739beac6d..1185c99d8d9d 100644
--- a/arch/arm64/boot/dts/cix/sky1.dtsi
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -480,6 +480,13 @@ iomuxc: pinctrl@4170000 {
 			reg = <0x0 0x04170000 0x0 0x1000>;
 		};
 
+		fch_dmac: dma-controller@4190000 {
+			compatible = "cix,sky1-dma-350", "arm,dma-350";
+			reg = <0x0 0x4190000 0x0 0x10000>;
+			interrupts = <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH 0>;
+			#dma-cells = <1>;
+		};
+
 		mbox_ap2se: mailbox@5060000 {
 			compatible = "cix,sky1-mbox";
 			reg = <0x0 0x05060000 0x0 0x10000>;
-- 
2.34.1


