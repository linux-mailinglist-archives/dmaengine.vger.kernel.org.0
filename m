Return-Path: <dmaengine+bounces-9643-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLbjMbbHw2lKuAQAu9opvQ
	(envelope-from <dmaengine+bounces-9643-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 12:32:06 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D822323E9F
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 12:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CB803159503
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 11:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADDE3CD8B8;
	Wed, 25 Mar 2026 11:22:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023073.outbound.protection.outlook.com [40.107.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F53CBE99;
	Wed, 25 Mar 2026 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774437729; cv=fail; b=O6Emr+whAMM4nfUtSHMtQzAKo++Umj/VKIbtzc2c86r6b/hQ+tqotiS0DDdWHbKYdyagU16Fzy+bMr2zldvegs6OiXt+pQ0EXCftlGwn2/9eAJrlBiTkO3mxWSxlPly2mqjw3XzWk8RfaAiCxbe/7/4Ej5B0AcxFH84NSr05LqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774437729; c=relaxed/simple;
	bh=6NPUjDA7J5d7RowlaaeYHc7gC41+UQmnejFbwrrLMWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LL4daj+2KuFQtVdgomNlVEAsseCDu4KeN61JOWtVgUjC85H2OQStFMz94laI+MG+nQsqMtvPb2cfGNSM4dGXhvFh2hayLf/ac8h7CYAD+LsmPT2qB6bDDk/oEYBqrFv7bVTPwFHa/VvGIgr5T0wc5RK+bArQ3XFTLr6PjzIdaPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckGdc7A7J0blXBeVPmbgZTE99u5xZLB2nzPQMfKoqMsGYiCc+TTxkzzSZxm6TZsXWXqYt7uxWNTTd+oGIZhCHAr/NDMUKd76G3dfqcOYvB1AEG6Up0WzGLKazDHug/4EU+Bu9tVd/ftUluVe0Wgmj/bB0tb8m9iiLbaoezlG2MtC3gvVwENvzV3zwL7J3Ojt9bXpyqVWAacLWrfZOmpRWnfJcVknZ1295lZFaiCWvQLK/5eKJy2aKcWFd0np9Qhxd+OYeVmdffpJ6ViwWqcoQ/Opo9fUeCZq+oUBkXOwz2FUjg1OXL5vSk7o468sZDcF5qed05YLUZoqEUbsFxWCqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSVXXzX+7YEculvibBHwFwLpTRS4o/JrRp5O6mI0ZS0=;
 b=HjrpRor+/oM03SfGIsdhhU3RAxV7OL7SupeAcrevxWCQO7BGTCGZt6sdrlbwI30Vnn7FuOArUq8JH4qTEpMHAK8rPBufNV3dyG6Zsg0XHF2ZykdR2dH3WuXjGZrgS9sOpt+lv8+X+EfOsDBbyxEkTvHs7/nl2pr5V3VygylYduWoQ3ncI6D3FWnTx8M5Dft9Iw4quY7qnyWE6qIZmlX97rQU/aMwL8x1WFOqQh2bpZT7r3DRjF4dOx4//UZhn7gicAorn0LHxClDROqYYcHbzT5cAfrrtKBZ0TnD4AsiqDwcuKsfBpfSAVMCqxVGiu+MtEBHmXMtXqW1mF67AaUXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) by TYZPR06MB7064.apcprd06.prod.outlook.com
 (2603:1096:405:3a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 11:22:02 +0000
Received: from SG2PEPF000B66CE.apcprd03.prod.outlook.com
 (2603:1096:4:192:cafe::9e) by SI2PR01CA0033.outlook.office365.com
 (2603:1096:4:192::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 11:21:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CE.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 11:22:01 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id AA5104126F9C;
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
Subject: [PATCH v6 2/2] arm64: dts: cix: add sky1 DMA-350 node with channel IRQ entries
Date: Wed, 25 Mar 2026 19:21:59 +0800
Message-Id: <20260325112159.663881-3-jun.guo@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CE:EE_|TYZPR06MB7064:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 300dd731-bc0e-47b6-1f3c-08de8a60bc88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DISGWF9hrKl8RS8QJuLXPl7YbpypybOhNHwHXQ+yzZOCRsScZRfny9zoFQHrmr5QvUWzk5wUuAMyG6BNxXq6H+A8OazlC7de5A9Z9k1A9tCNwucTRkBWpHm03g4MrJGzo2RhVY4QXLsjxiUkCYYO5MCn7YNx/TngLtZbFGbyyxlhGdab/aJPg9Q0/NzC1GADfngdpBaJFjf4mWjLvb52wjQjpaFFCsqrL8sqb9mc3Rt6pVfiCxc6wLj/z/USK4Z3gvOPGfLnzH+PeXeFAQLStyNLa8q5C8RKXgzrixrNWjcBbDH8yBDBsd0/S+3QKqkNNPfjDhiW85C4TRkI+JCJDFIbEPNO+Wv4kLAPWhwPQLwPdsBU/N55CF9mUe7E+dMb8o0Dpdjn0LCFPDu+u1zxxOcub/Fl2x9E3pPHMk+KvtdG+uY82x/IE7wD0crOS+mrzaMjCY5oBanC51bDM6FYT8F+oudfvrh1EX/VDM3S3Ej6yQ0nf1NHowkFFfSC/mWchRDRS7eLHwdQUAIDwOMMBNu3elFt5zQFbg9YgJRq4aX8XvNz/Gqi9dz39etFeaLAeuZOObqKjvllFaovlZWG1P42fYXAMtopdG93F1Q3NCRhrawuqNt4PHxg2bMNNywwingCgFztEQGF5Aopd18qIdQnD8vp1qZUgVyCRd6Exee2lKxiHG7CY/rPMMN/CMfr5f8Y9326l21Scud86Rr/HmFmLuX2gZrJQRDM9gcMeTxpf+5yMFPrZROvCxG5EXAeBbrjJhESzR3PZCccUt5qHJsdSTIxB5qQMwuhJBp1s70+9VZHQKTpi46thJJcfD2y
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n6lYf50P59ALdV4g3jMNjUfSz/6yMVgcnCdQK0Joaj6o1EVTZGAKmdSbfz0uQdOv/DymfwYMHUa0qv1LrTl1ATBgPaltW79Nrz8lyv6k5i9vGEasSIdb0L1eDB+qFSMnIDBuqGPo8s+Etbv8cH5YeuKentt6PyUZTdjGF7b0CQoVcCHS1GEWemX7LIbsIQS2skY9oTJJzDXUT2uST+/iURQdo3s1b4JWAgbEuLaF/LwHeqeTLwHIbBxUTu2YhIshpZ3byytbj8tXjsj/n4LvVDzvbekmxrsZuE45nUpu5dgNhmxfre064/jgaGZ0huWkEVhQ2VbwUGGGhntXScEd55G92HR5JhXlYXxqC6x3IaKdY9wdUO0fPNXJxku0SgwGDsvwQDJydaNW9atKWYLa1ZZgpci4e8oyh8aeMrL07xgMwahNYH1IW7HSFJtsUX0Z
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:22:01.6075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 300dd731-bc0e-47b6-1f3c-08de8a60bc88
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CE.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7064
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
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
	TAGGED_FROM(0.00)[bounces-9643-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[0.63.239.48:email,0.77.53.160:email];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.63.161.16:email]
X-Rspamd-Queue-Id: 3D822323E9F
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
index 210739beac6d..ca3403df6e8b 100644
--- a/arch/arm64/boot/dts/cix/sky1.dtsi
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -480,6 +480,20 @@ iomuxc: pinctrl@4170000 {
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


