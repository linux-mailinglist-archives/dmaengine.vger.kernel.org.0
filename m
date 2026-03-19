Return-Path: <dmaengine+bounces-9518-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEuzEd3Pu2k4owIAu9opvQ
	(envelope-from <dmaengine+bounces-9518-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 11:28:45 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B64F62C979F
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 11:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C2DC300253D
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 10:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B79F3BFE2D;
	Thu, 19 Mar 2026 10:17:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022101.outbound.protection.outlook.com [40.107.75.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB53B3C0E;
	Thu, 19 Mar 2026 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773915456; cv=fail; b=bDCil4cjIm4hNPdySVxokkBiZGntx4vcyAWUS394u0HzZ85ICiEPotv/vzFT1u7VRh9XogkYjprJl13fXhGxcLylYJN3LA3cpoyGWmZe/16BWiLH5BqCPhMUYL7FL+RQtrbVL+Sn+xE+M7YR+D4/pFIH99j7Jn2miGAinZSkN0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773915456; c=relaxed/simple;
	bh=Jz+GGQrB6qkaiH/dZEuWVS+3asEiSx3GKvm4IraADFU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=j0yQSNFbd9+FMW2LfvxGz7bO3oa7s6Hw+0UHt9Cnv8kVz1ksbGKcHVmOt8yJZAtJrf+bCwnkUreA229JDVhq3v4RSHpAxXvPSW019p2/VF3uVFt3Eia+Y0zB4b8ntd/pTJH5ryC1C8yZEQu8pug7Iy8zmSzBaI9HnkpwK4P670k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qK935ZgbuQdXbsjQ1wuOIW0qgn5xkUzcDY39XpwGrmOu/eohpElKyfkFdRyCUxfT1m80ddbVpprTlXpCE2XxvU03IzbSLxamEh9cbfatwPVNGi5qGVIIqpUqL+A4pAhWaztLeHAs33vw3JR0JZ2cqX0k38xGYfrosgmfWAtYEgrwLwgN+YVSpCEvE+vSrEt5xduA5x0HwM2BnHiH7OmdJQQ5sik76DmSLx4t2EhNRNXot9ZaQsZYdfk/2pc/jTiJ4tjB1WYRm5HoYODeOocmmAPEsyHKMCKa1dQ6XARC20QWq8X4nPDmE7/nj5EK7UOgANCw76Yub7t6qZTgJK3G2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTmwYG1mhmKeN25Fx+WB2jxAWI2W94YUTf0AE/OKIso=;
 b=kBpbWmRSerFzpUx4ZqkO8BlOBwNnlrwNDf0qqhtxBrjDOeAHKMW/gWT/PSP71S5OgrTQhoouOdd7c0ILVROdgtBgfNPOxjFCSrHjGdo6z8VExJFfrGfcdGnXqM8zUmZ0L/IKA1mzDW3EuavRV6OE001VE9/Ex0XoSdYdxnOwUqDun9V7ZOeO6ZhE9xsff1Bs2eaxPI7JgPjZ8NbrMICJcNsUlXkeuJCY7GTgoctoUZ8lT7DhWfJ1vKUo+7BYvMOT1Kh4NhI3i8g0E/+AR4ExYUxpFWc5aL68LV+F+G0xAOuKzT/FK2oqT3okXMSVfwLNmssI09xb4HXGFQNhG8q8gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR03CA0102.apcprd03.prod.outlook.com (2603:1096:4:7c::30) by
 OSNPR06MB8443.apcprd06.prod.outlook.com (2603:1096:604:489::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 10:17:27 +0000
Received: from OSA0EPF000000CD.apcprd02.prod.outlook.com
 (2603:1096:4:7c:cafe::b9) by SG2PR03CA0102.outlook.office365.com
 (2603:1096:4:7c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Thu,
 19 Mar 2026 10:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CD.mail.protection.outlook.com (10.167.240.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 10:17:26 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 036504126F83;
	Thu, 19 Mar 2026 18:17:24 +0800 (CST)
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
Subject: [PATCH v3 0/3] dmaengine: arm-dma350: support combined IRQ topology
Date: Thu, 19 Mar 2026 18:17:20 +0800
Message-Id: <20260319101723.246539-1-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CD:EE_|OSNPR06MB8443:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c053967a-99c0-4610-2e02-08de85a0b82a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	02354CC8I5tJ4q809GP04TVdI6AsE3Lqo8ce3VIt6Cox4MwkjnReze4cIAH59DenLhEhcWaZqjNP4l6N+kxbjQUEUf9Qd12Aa4cTziv2VISuxu7/Yt0uk2MRWicjeEyBRomslON4z1vSX2gnEEj9atXW5A2OiENJRGqaj1DvuVShS2ZfsL7GnZG5t1biS6jK3uM2mhpFXqk/bWLaQ1eqVU5+V+ki2TuUbt47KkfzBWENo70HW5uFDP0L5PC4r4hsyE42o7x3Gvi8EqGvBOmMADUxKJXG1LL1q4TZltMo9UkXRj+Pu51Z0RmaNI4PGgtT70ScqgCFvM3R1thx++/GwNoUzy7owLGiHIp4uNGbQZw94m7esJtIFVkn1j0MN/ol9L1QpQGHR/w2ZSvSOGF8TiJaEA+Oahlqv09dqP7K4UNab6qG0+PimOICcDZIg5xRHqB/lzpdLRtM4JJjOel0FWu2stBB1uDMCUlu4DpGUQ0m0xUc2bN9uB632wVsXT8bk/2w1L3NhSaATkC5eBwLYuLhH4W/iXZXwTFQStGG3GJaY1xDE9fEGQ798C3G2dHMIvMG5nJhIvbE1a43kUV9dJKCjIOtP1QgVkgG7mxQjzesnqaT5dRIdJxE0Uwu+zibKMKdzHwE+LODzwTjKLtYBYUzHPtMmdBZAp9I/iVctxvbqxoPljHQRgJVfdEjTQpTbVTxRs0ao/GDVv/jug8bX4NPhO+fhnG/O26r3UU4DWUixT0YDXmmaem1bRZmQqPQheRCcAFnjqGT+xpU3gVGpBbhPxpU3hGDnDn+xBIdsrCCjNBPRGlp18KKeYvBgMiz
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hz4F6G05+fXmt1Xej3g1Q0U9/RrTxqr+d26aa9RFINKDcNq79f6S3G9zZn2NrsU+Icv9nMre44/nOE5+amj0cw3Rf4FJmQp+L+hxqxQU2NXAhx1gb1OOPCS5UtWVbE43y6Y42ybV+E888Rac2TxPrgHdrvTQLG6nUNi5BsfZyLrk4JaJm81CQ/kNIl6nPstY7NZ3YUXWg9+fFG6+P4miovdHfXI2O01cTLQYJpHweNssJoq07jGrv9garnAE+y5Z46cb4bQLwYxSnIgeNvXJcilUiZ5coLKYL5YVRS3IztNbsVbyYQlKfbstPT1V1k2oUQOrsIUKp6WL/miHbCtfnyUZL3rvP1h86141V44CEcNYWB55dPWPB9GKNx1Iox9vHRV39vtqbG5BMCH4dSbDyRT9JbZe09fRTgn+Rmc3vufSW6DHJG9x4d0nyARrSi61
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 10:17:26.1924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c053967a-99c0-4610-2e02-08de85a0b82a
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CD.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8443
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9518-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[cixtech.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.102];
	RCVD_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cixtech.com:mid]
X-Rspamd-Queue-Id: B64F62C979F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DMA-350 can be integrated with either one interrupt per channel or a
single combined interrupt for all channels. This series adds support
for the combined IRQ topology while keeping compatibility with the
per-channel topology.

Patch 1 updates the DT binding to document both interrupt topologies
(1 combined IRQ or 8 per-channel IRQs) and keeps "arm,dma-350" as the
generic compatible, with optional SoC-specific fallback compatible.

Patch 2 updates the driver to detect IRQ topology at runtime using
platform_irq_count(), handles both modes in one code path, and enables
DMANSECCTRL.INTREN_ANYCHINTR only when combined IRQ mode is used.

Patch 3 adds the Sky1 DMA DT node using the combined IRQ topology.

The series was tested on CIX SKY1 with dmatest:
  % echo 2000 > /sys/module/dmatest/parameters/timeout
  % echo 1 > /sys/module/dmatest/parameters/iterations
  % echo "" > /sys/module/dmatest/parameters/channel
  % echo 1 > /sys/module/dmatest/parameters/run

Changes in v3:
- Rework binding compatible description to match generic-first model.
- Keep interrupts schema support for both 1-IRQ and 8-IRQ topologies.
- Drop SoC match-data dependency for IRQ mode selection.
- Detect IRQ topology via platform_irq_count() in probe path.
- Refactor IRQ handling into a shared channel handler.
- Enable DMANSECCTRL.INTREN_ANYCHINTR only in combined IRQ mode.

Changes in v2:
- Update to kernel standards, enhance patch description, and refactor
 driver to use match data for hardware differentiation instead of
 compatible strings.

Jun Guo (3):
  dt-bindings: dma: arm-dma350: document generic and combined IRQ
    topologies
  dma: arm-dma350: support combined IRQ mode with runtime IRQ topology
    detection
  arm64: dts: cix: add DT nodes for DMA

 .../devicetree/bindings/dma/arm,dma-350.yaml  |  31 ++--
 arch/arm64/boot/dts/cix/sky1.dtsi             |   7 +
 drivers/dma/arm-dma350.c                      | 165 +++++++++++++++---
 3 files changed, 167 insertions(+), 36 deletions(-)

-- 
2.34.1


