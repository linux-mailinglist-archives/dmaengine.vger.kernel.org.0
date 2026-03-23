Return-Path: <dmaengine+bounces-9591-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHtYL0YqwWmbRAQAu9opvQ
	(envelope-from <dmaengine+bounces-9591-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 12:55:50 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA372F17D5
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 12:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 489CE30420A9
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 11:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC0839B97F;
	Mon, 23 Mar 2026 11:48:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023121.outbound.protection.outlook.com [40.107.44.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D4439A074;
	Mon, 23 Mar 2026 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266513; cv=fail; b=ugFUND3ZRzfiWLrEz1w8nise+Q6+akEf+igZvCsP3ocD6muNpw0onVIr/A7uyN9w5istN962noOpb2wcFrBgpQBzoSTRcaltVdbi1nj2TfYFGMlqgQEAnzoqfwYLYFjIslnYumnjyhxAQGffl7DsLIYCIZyTKGb2NzZMl5x29PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266513; c=relaxed/simple;
	bh=3jFZekRkwQNkYHP+Khaa6QSsGMHa31AO1WojcpZZkQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AuVl28ycFMs2VVifMQ3ZhgAHSZL3OII5PEXU5OCHmd46cmkalCupY3+fv+TnzFaEjlo8jHKnfECmKAhjyGByuAEkf+JReHWK9cmJBusNq51cljytfb2d3DGSFAJx7WfDwkk0+F5L/ITpOpW2++PSw4/Z2HXuP73rgVw30VWopFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgOBIZ2O42eHpzUac7gA29SwuK9FxR77OaQA2VEsI7iHjZomVoEKdqVOqIB2mwZmIye7w1LGydqzi7gNKfUBd8MU24lGU833JbpXW4zHhGpVO4aBrdJOJ/O7Ilx4heZuPYZhh42aADFpLF4q7Ntd+h1WtDXDAM/txbUVwXgFz1s6h45KrUXyLtiHBD5I4wsapJ2a1Zsn2AbhHYMnuUyM683ZKLvXuQH6NfzDzdbrcUIyS/EvJfJvDixboS9Hqn+32M+0nSZh7a9yT7FRiGk/sFPlDTRASYLe6/oNowNKPKaNKbTuTn2fa49CuA9PwUxW4mZmPUfB5kmRUjVxnmGvVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKDB0jdoKZi39X8HPp068xWyfksBFW34kbhM9caEeH0=;
 b=k8v4nku1v3aOFQfBm6lh9PjFn6mPSTKWGZiVeA7TEKRJVKt2lUXkYs5hBA1H2NN8G5Gvox+aljXgEHFxlx5W5N28/jf3HJhOaIEArUS7+gb6Kvq4o9PLCe8FX88bFjse5UwKOrLHAfWYOJ8BcojdxSxYTvvohB6fa12wHFPqjpF8t6vOS3cMLYufXR4DRkS2bWZ49hSd2isHqK439gHlcJjD4jROMD9hJuK6ae3SPlSLyGH/FqumJOc5RDzLshUdOB6cdmz0lnHQMbwuTb0VhviEOpAq/SSgn90zHIThGoSjxSeeduf/JHBz7juxEnFrfgBPxw9fF986nyWwKPpEjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from OS0P286CA0155.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:16a::6)
 by KL1PR06MB6906.apcprd06.prod.outlook.com (2603:1096:820:128::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 11:48:27 +0000
Received: from OSA0EPF000000CC.apcprd02.prod.outlook.com
 (2603:1096:604:16a:cafe::37) by OS0P286CA0155.outlook.office365.com
 (2603:1096:604:16a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Mon,
 23 Mar 2026 11:48:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CC.mail.protection.outlook.com (10.167.240.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:48:26 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id ADB444126F83;
	Mon, 23 Mar 2026 19:48:22 +0800 (CST)
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
Subject: [PATCH v4 0/3] dmaengine: arm-dma350: support combined IRQ topology
Date: Mon, 23 Mar 2026 19:48:19 +0800
Message-Id: <20260323114822.1925869-1-jun.guo@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CC:EE_|KL1PR06MB6906:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c6144477-9882-433f-8ba7-08de88d21829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hoXNjqyFEsr0LXO8FGGf52Y0Wxajmht4ruX9bxa0UpMz0hXgaJUj2w+iHlaadfJL689trNqIc4LPvmsbcIdnluLVCKuZokkbpFgKcjdX40iJ57VDKDCfEx+iI2Nu2DGKF7hjGZLYTmX0hqTWEtN1XC/CI8auGGuzarCBROtFMPj/fWCaa6lKFH6ReTH8YwtmJB6qDeFK7E2rdhqXt8XSRMdC6IG2t3zFap/yEZjmxA4Yi2tHNksPBOzLSflyZPtHrUUwynycN/dh2fOZfoubjBOjlwgBJZll6R0n57eN3gFjWhKza2Ofn8uk4LnPjrOZ0q21hSMVeAB9LVb9ov0wkFvg1jTkAjRyG6xxfRo+1NsAbyE4/WCSmO2y3Fl6Cy2GFyRnl9LA7+lw+y67WF11Pjfj4cs6m/pkzFQasEsHP5QTy6isfaiJh+T6zvsM7q+TzPa7B5oqUcqR6hVAx585J9oVzCR6pS6FNB58w9TshrJjPoZwH5j1739HDZO45HW1opHLYDV2+YlLZpwZQ235eH/LFL+NovBQsrPEBfPzqN28heSH96dO+giO42+4/srKRVaEaWfyOu8Hg1nEA/qANk3FTqc00dpNTrSUnsNIRQuQH4El1o6cQxRaovW62y83AW9fCdrNvYRxlIgFjW5KIGNSlWIuDM3qc7b2LCsRzNtuiQSTRSyW99F3hESYp/79nvrK9+0njvbWTNyl3jTUfJmxKGTg+/wAJHphkkCSJ3C51Azx16Qzudw0WdYP3UwF3/ZcCxwDviBtLhGyOqApqFyLOwl0/cpQ5QKn4B75pCWMllgdZql6OyQGkvf/BUd0
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D5YiKiYWqXAXpxFgEKYm3kWhk8cecbcSKfVxqnzhTsleQmylT1A/Omexzmul8KJsIvc29RVTi4nkWJYxQD7AYnO7GrVFwhnD4ujepgQM0j3jQrG9eY4J4gN/0rua0FdY2bJ0sdj8d6xRI0Y2bNc5y/jCASm4U0EOB12kxqOJQx2z6FCcGRd/nZELjdJxv5TrdvaIwNqCj6Y1iU8hNNPSKg1Nys1yII12z98vLGMrpxnuSuoFDGEDmzZT72Hr2ys0a28kVKU6N/KLhQELVZiCUuW7FKpZBVntwoE0uAoBlKJxKSvDtJLtIYzs1G6YpES9jFzQzpHj5QeZFg2g0P5WKB9QYIkKeNtGp/AjxjWqFjGHUqqr/ClQjmG/blvpAQUbZ6sTnxSMXbrW/NSS+Vs8iZvYCidn8eFk/uNpqmK1dauYdRP3xNuO7YVvEUzxhrP+
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:48:26.0483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6144477-9882-433f-8ba7-08de88d21829
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CC.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6906
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9591-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[cixtech.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cixtech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FA372F17D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DMA-350 can be integrated with either one interrupt per channel or a
single combined interrupt for all channels. This series adds support
for the combined IRQ topology while keeping compatibility with the
per-channel topology.

Patch 1 updates the DT binding to describe both interrupt topologies
(1 combined IRQ or 8 per-channel IRQs) and keeps "arm,dma-350" as the
generic compatible, with optional SoC-specific fallback compatible.

Patch 2 updates the driver to detect IRQ topology at runtime using
platform_irq_count(), handles both modes in one code path, and enables
DMANSECCTRL.INTREN_ANYCHINTR only when combined IRQ mode is used.

Patch 3 adds the Sky1 DMA DT node using the combined IRQ topology.

Tested on CIX SKY1 with dmatest:
  % echo 2000 > /sys/module/dmatest/parameters/timeout
  % echo 1 > /sys/module/dmatest/parameters/iterations
  % echo "" > /sys/module/dmatest/parameters/channel
  % echo 1 > /sys/module/dmatest/parameters/run

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

Jun Guo (3):
  dt-bindings: dma: arm-dma350: document generic and combined IRQ
    topologies
  dma: arm-dma350: support combined IRQ mode with runtime IRQ topology
    detection
  arm64: dts: cix: add DT nodes for DMA

 .../devicetree/bindings/dma/arm,dma-350.yaml  |  34 ++--
 arch/arm64/boot/dts/cix/sky1.dtsi             |   7 +
 drivers/dma/arm-dma350.c                      | 165 +++++++++++++++---
 3 files changed, 170 insertions(+), 36 deletions(-)

-- 
2.34.1


