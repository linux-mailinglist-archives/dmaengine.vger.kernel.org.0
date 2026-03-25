Return-Path: <dmaengine+bounces-9641-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOWtFZbIw2lKuAQAu9opvQ
	(envelope-from <dmaengine+bounces-9641-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 12:35:50 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B48E8323FB3
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 12:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBC4C315EEB3
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 11:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DE13CCFB2;
	Wed, 25 Mar 2026 11:22:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023097.outbound.protection.outlook.com [40.107.44.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E7E3BE15D;
	Wed, 25 Mar 2026 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774437728; cv=fail; b=jHrP03AIDtyJrVTcICx69NOEg6PYFa7IfahjF+q04XgNwsvo34eees34nAZa9dnoaNdGyM3vsMF7AyM7iF3D6TdLXXQmC2KnwNC98SRRTPX+hHw50xXEWEukAhypT4L30ZHnTONSAbRNiZ5StQ6pFySj6+sTmEJOVcWQvvQ3mfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774437728; c=relaxed/simple;
	bh=+KTPSI2prCXu+vIs9DUJ3tiOz63pLiKV+DZgAYiSETI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aPu/E2EanyLY9YA+N9Svs8ylrptbbTlAXfkQLtN7mOYM11fnhpP4p1CDkf1iZp6JDcwxW6684VyGube/TdQUjMAnzQznC2HJntVlx35cfMkx7FGLrlipXn9XJykDY7sbCmwqtGvAj0MolA7SE7YMzu3Vexe73Y1+BiaivLVCBBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Chu4fe7RZVKOZXZgzY9SKS3AsA0oYNnLXOjGaOSsuT8ScvdvL/dAPM0uW5Z9ofqFl8k/1ZEHzlbNqvuT0suKOQXYHM31Roengi2XdHng/4WGcwnHLX4qqykJ9xrQH1bv7KjZw2d8mvKwmowx/zFUzg2LOCNc8M9VYiL0gLCZQmHWyN4ZejtLf0qU8w0Cx58huBFvfWEq8VbFvVj1+ZQKJhuYwTV/UXj7b+01AmA1SMn3sRHOvG7/HqmgpgnDL2Yjmm2ieXYF16QudYtpqqBtaVoKsAHQSW5cURMnP8OvKS2m4LqEZK0+HQB2o4fdafkFJEAA/hiocIVnyDl4SuivNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUng7xsJsVuKxmG4d/Phsrr5AfYhOLGcGOlm0+NVjYA=;
 b=ikEu8GlddIRewui2lTJ3NI7KNWZ3BalX3lPL1/IbqE4QjTcW9tg0cR50TA4DK83mCBd5gpVP0nqX0EZjAjEO+GSw2gVFC+mmLweidNrzavQu7U9m44Q3MifmOlFzRpts3/zgjEbbyYu3Xi8b8L5UaFX/zkDQM5D2CphCo18tGxfceP/BoQMlDVJ6KTsbUv+SK+HvQkS50lM3JPS/JaSn3Q6qd1P+BnHRyqEcKcldBEnEDsQTka4vp9dG48EPX5ajKF11RtE93Ue/Bi0RlAzTnFCzZQ1cgr2RroMl6tZ/f0ddfUkbwYLu9YryqdNggN6XgV4tn4bnB9IynUxrDNrqrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) by KL1PR06MB6686.apcprd06.prod.outlook.com
 (2603:1096:820:fe::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 11:22:02 +0000
Received: from SG2PEPF000B66CE.apcprd03.prod.outlook.com
 (2603:1096:4:192:cafe::a0) by SI2PR01CA0027.outlook.office365.com
 (2603:1096:4:192::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 11:22:01 +0000
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
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id D51684126F9A;
	Wed, 25 Mar 2026 19:21:59 +0800 (CST)
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
Subject: [PATCH v6 0/2] dma: arm-dma350: handle shared channel IRQ wiring on sky1
Date: Wed, 25 Mar 2026 19:21:57 +0800
Message-Id: <20260325112159.663881-1-jun.guo@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CE:EE_|KL1PR06MB6686:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dda8f7b8-04d0-46ee-8fdf-08de8a60bc79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GowSDUskEPt3QHP358CqH7v4xyYJ5NDxPDRmhXjDapjJi3MGSoveSgnxLQhocTNsfBbB+1zvufnqW9c2Wa46idLWroXNc4YTlo6n41fBsMD5uMTUyobQmmLCbYIp0pdTvgHoOgiBhXTK25+fQqMf8JFLLdyadmiMs8JauPGl6pkvmoXtWvKMKToq/KTm+ruPXhYhcx/3cVL44afP3A3G5PaXY2OjVdeVsFmtudCXGKc3Dsx09rAKY8c46J6fqehZ+wI0RxqlKfgsikjFONpIZJROFeod+x9pO2Wb2MZxyuvPuaqliW9w2bGpPHlpgmhk8mjQT+7KIpb3PUX8MaDZVy8lzxUpYunlswXW0KTPHc2F9il1BEiLX6ZOOim0hQjiooRTEFeHWZqdhqklVrFlg6lbUJBj5ToZank+vbbCiogO1eOFtvq2ozkpvldaGCnMGuyqckR/um9F9S/fdTlEz3hfEAEU/fCBTiCgy0xZRM3zRc5/wacFS4ihvpJRzU5q2Kd7vuyL4cLgQz1tRv6TQTTc8Pd2gZg7/0aS99wPwiiWHuwHmab4DJlfu+6otDA+lwqVouY7ruR9sGpxguQy5aP6IZlVEFvzJnmPpi5sS+IB6iEW6ZbHxCCPYkelLz+WYL7A31aBloITGUoagWGXUDUYnd86PmFO8hmmPOMHWXnmLBJpZBuX773ZFHVwAshwE4l21EBkoJupJkmj+f3TPof88aGauRceQCKGJcLCgz6qnXQJNg3BAAXpT/rjXURBtiWyr4kdV5Tfq9sJghNEG0bkM/USIRk/1bGc7TvlGWKW3OKYx6sFlrB18qfvGqjH
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cJ90qwUP/Ybfwi6qeWO8jSzJ3YSBnFjh7qSaaCOWA88He9GkdQNuScFaKh8ywgZxtW1iBZYZGCO6D8G3L/XsgWjl7Y3ucgCYFuFmsEVb4d7kZNiYOXaAAOlN9xIq0ngieVuNHhQHsdHhCZQ35dl41O1sG+cCA3Ty/7fNxzP5mO1SrVQ26pODQHCjmO7Ef3EcxofmeC1VsX1Qdm7PVd4dHTDuq+Qe4KLRBJFJDo/BUw/5UcZzTx2mp5YcLK+0dW76neXtz0+VzPEw9ESfZbW4Ayd+XGOrpSKI/XIc6rOMmcU9FQYqzK5S7K3+z4QpcQ+Cqroo8cly0/ZFGAp+QGjKgzW0R50NVq6Kleax3gIlA3P8fkj/dJSyKD7gyCGj3+skXFR/VziLgh4f/UmZN3K4Q8bh3KfCHHRXFa1IHhoksOhALAF9NNaH4AYHCYZvU4R+
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:22:01.1818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dda8f7b8-04d0-46ee-8fdf-08de8a60bc79
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CE.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6686
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
	TAGGED_FROM(0.00)[bounces-9641-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: B48E8323FB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series updates DMA-350 support for the SKY1 integration where all DMA
channel interrupt outputs are wired to the same GIC SPI.

Patch 1 enables DMANSECCTRL.INTREN_ANYCHINTR in the driver so per-channel
interrupt status is propagated even when channels share one parent IRQ
line.

Patch 2 adds the SKY1 DMA-350 DT node and describes the channel interrupt
sources using 8 channel entries, while all entries map to the same SPI.

Tested on CIX SKY1 with dmatest:
  % echo 2000 > /sys/module/dmatest/parameters/timeout
  % echo 1 > /sys/module/dmatest/parameters/iterations
  % echo "" > /sys/module/dmatest/parameters/channel
  % echo 1 > /sys/module/dmatest/parameters/run

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
  dma: arm-dma350: enable ANYCH interrupt for shared IRQ wiring
  arm64: dts: cix: add sky1 DMA-350 node with channel IRQ entries

 arch/arm64/boot/dts/cix/sky1.dtsi | 14 ++++++++++++++
 drivers/dma/arm-dma350.c          |  9 +++++++++
 2 files changed, 23 insertions(+)

-- 
2.34.1


