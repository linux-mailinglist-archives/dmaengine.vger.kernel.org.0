Return-Path: <dmaengine+bounces-10626-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOpbIW61DmosBQYAu9opvQ
	(envelope-from <dmaengine+bounces-10626-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 09:34:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D945A02E3
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 09:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E0E73026155
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 07:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9441B39935D;
	Thu, 21 May 2026 07:29:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023138.outbound.protection.outlook.com [40.107.44.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484143AC00;
	Thu, 21 May 2026 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348575; cv=fail; b=fhnUapWv/Qirwe9DdSVCZbgqyDD4i5Ne0M0us4Pxz4yTFJuGh2MWXZJhoj0GG3OyA83pDKHX4VY0lk/Gpval+cxU3NQI4wWy7n/yVygZa8BobcJ9FiD4s7Nq3VN/bkcukkJx/mgatVXXVfGR0WaaoNaqQx7combvF8VYPl0MM1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348575; c=relaxed/simple;
	bh=GbOym+CfPHD89sISyCW3KckYVRWkvPoPfdZwNHOOIos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=slENI4Xh3yySYJHNrWRwmC3DhepA3zisd4kP4jKlgtFe8GE7bJ3uFwEn5iM8a8Bwz2eP6Doyk6BUFriw0e7f/+VO7/GQlkId/cmX9QVR2voeTcr3I6lNnZYV13TnDdEOiYvdK4azaGkt4RvlCc3De1AFoPmV5RaGr1aEKb1/14Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JN2nKm54R48Gv3Qi3JrqFvfXPtWRZAUI9HDtpGt1IVFrlxr1NkVP1wVSmLXLIJROXykhGywdHGJjwVLX8XXiA/oHveOgsOGAbT/VthJwKRX2x98gGlKwvJ6RhUoAJ1KU8yKSkmxhZPLu906l4viq52QgYvUJun4wGJau1agHwkLhD0IzslkhU3DJzJZcaSrhAhf/Gk65bRIlY0q137r/ndv4UFwnO9jVUPolxHIufFTBOKJjBgpJeP7CUQtZKGgD5QaAfoTygl12paec0SvwpKFs6DTZtDhnIUWX/Tdgcrt9WHA75kfGKRKqE/pCJRQDxEQuqNHctH2WhmdXDgynpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+OT5iaiiu/0ZtCdDzuQMDNl5GzGIj6UbV2daq3Pmuw=;
 b=FanMF2su73jspUhX9NARBHxRuhAuqT42fvDpKIA42XcnoUMWrodwlAxBTLlqjo7ktI1fWzuokF0fhbSm5dMW4UPjTB+QsUtVihY4YbBqSHXg53Oy6n94CNErEtlF3/MhLA096yzEHlPfMdMq7GhjrtaSeA0Unn/lPa5mhF0Xl4nyYsZs/cY9/WnzHFlURAUczjX5ajqvgdErRYMbTH5iJEMZ9SErYkiDurKNe85jINJ2tzQ45xlSGZCVuZgg832rwmZRJDFsJATXowcYFiHpBPvql0jdYZ+a/g0x96nNH/aQBMyHP3xKOZfHzmRHvkz3cTC183kIZundsGPZEABEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0046.apcprd02.prod.outlook.com (2603:1096:4:196::15)
 by PUZPR06MB6267.apcprd06.prod.outlook.com (2603:1096:301:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 07:29:28 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096:4:196:cafe::7e) by SI2PR02CA0046.outlook.office365.com
 (2603:1096:4:196::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 07:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Thu, 21 May 2026 07:29:27 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 1FD0641609C7;
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
Subject: [PATCH v7 0/2] dmaengine: arm-dma350: handle shared channel IRQ wiring on sky1
Date: Thu, 21 May 2026 15:29:22 +0800
Message-Id: <20260521072924.3000282-1-jun.guo@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|PUZPR06MB6267:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 98ebc0d0-ec36-417f-afca-08deb70ab091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|56012099003|18002099003|921020|3023799007|5023799004;
X-Microsoft-Antispam-Message-Info:
	3KONVPLm4rlMDY0a9ooZWrmOP3dffoneav7XAUcY5GvsvoiWgTBmwzkq94VRXX1BUbcEx6eT5xPT2ZsakIf1St8iCX0QAe8Z6zL+7gzBBBjrv/DiRJFTMYJygd9WcNeU6zghKtlWNn9JGWM9HW41soqCVrYu12HdETlFIaNI8lalonV9F67EKbk1hUHfvX4mDw5yLTWT6FnKgEVd9oNbbNAPlWwpl8hsRbIAHV4spRyEJef7V9Wh/P64XSNEdWT0Uutrl/nOfO6UfhOXZ5sv2YjEDQUZmkxQHRSsmxPybJJZrY/kfVoYXq/S7OtswqKyBWujcxEF+551gMDbQb4fAITO8VHiF71avTC5CQWhvRk9FqNGgsWNEvnM9cLc7zN1v5rIakU249K3XRyNAQKyKRE5spewIbMVj6mEIKKRnq8v8UX9NuOnqcM11Fu/AYDRnvFv8ltF6YmszWIHvcI2fLAaid7UIEcdD9Yav3SwccHpkhakK8WSP4tuYPIbjhNwk8h6ePFnWTzd4918C2Fu86hHNTREZ12I0TQ3n08NsXfdAkPGw48yXuzffgPBmqrLTbSoH5LgZjAsB37YHrGfs7XUho2JEcVhfN3IJ0TLdTvcI3tk+mHiL3LpyJfvjYhcbQZ8OkVEIvZJVO9YCq9T/2XNi/6z20xl9mFTxrNCRe94lUFyhkgaqZGK3ppIpT7lOfSKN35XN1wV/zi0nYyLAYxVlZwvKIg+nmH67LFEw6bpuIFXWARUH3VAUtKt68nTVibQbeK/16TcOC3Stem0gw==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(56012099003)(18002099003)(921020)(3023799007)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	adb3x4yDlw848MmGVtX0wAq3nhQjbQgFeq7QhnCgfcuOQ4kgiwmgQzJFckX2eKIksOBCaGNn6UlXdS/8WhRJRI5Y64LtKodgScAXI9OmY2pmy04eZ+V6Cr3MpH2NhG0WkWdsfkNxVxOSvOJfoWrq0o6SLShoq7NSg8uOMO1JX14g2Cn+JgFI9QY1I30mytOOqK7OBtwF0XlImnVGPqnuH0vVTlEhdV5DxhzF+V5cGSXpoGoQ0rYur/1jdzaA2vbLr1CRyL5xiyh3bNdrDQ7CVDv1RIlbifj+T1zvxZbs48E6utO1GMt+XG8yMMogVGoqdbBLW1VJJH/eO0jxOM+j9K7ToVE3ki0cZmHeaXP5Bt/UKSl7k84OxM/IzPXxsrQ2Fzcr8OsMv0SxcASr6EoL7u+RUpJRVJP4ik8VytqhF2M+hxi9Pk6YptpZkvyVgcCv
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 07:29:27.1364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ebc0d0-ec36-417f-afca-08deb70ab091
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6267
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
	TAGGED_FROM(0.00)[bounces-10626-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 32D945A02E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series updates DMA-350 support for the SKY1 integration where all
DMA
channel interrupt outputs are wired to the same GIC SPI.

Patch 1 enables DMANSECCTRL.INTREN_ANYCHINTR in the driver so
per-channel
interrupt status is propagated even when channels share one parent IRQ
line.

Patch 2 adds the SKY1 DMA-350 DT node and describes the channel
interrupt
sources using 8 channel entries, while all entries map to the same SPI.

Tested on CIX SKY1 with dmatest:
  % echo 2000 > /sys/module/dmatest/parameters/timeout
  % echo 1 > /sys/module/dmatest/parameters/iterations
  % echo "" > /sys/module/dmatest/parameters/channel
  % echo 1 > /sys/module/dmatest/parameters/run

Changes in v7:
- Modify the commit log format for the driver patch.

Changes in v6:
- Drop the dt-binding update and keep the existing 8-channel interrupt
 schema.
- Simplify driver change to a minimal fix:
 enable DMANSECCTRL.INTREN_ANYCHINTR.
- Update SKY1 DT node to describe 8 channel interrupt entries mapped
 to one SPI.

Changes in v5:
- Fix the formatting issue in the AI tag.
- Remove the unnecessary "cix,sky1-dma-350".

Changes in v4:
- Reword binding text to align with kernel style.
- Revise the AI attribution to the standard format.
- Remove redundant links from the commit log.

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

Jun Guo (2):
  dmaengine: arm-dma350: enable ANYCH interrupt for shared IRQ wiring
  arm64: dts: cix: add sky1 DMA-350 node with channel IRQ entries

 arch/arm64/boot/dts/cix/sky1.dtsi | 14 ++++++++++++++
 drivers/dma/arm-dma350.c          |  9 +++++++++
 2 files changed, 23 insertions(+)

-- 
2.34.1


