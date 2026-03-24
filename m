Return-Path: <dmaengine+bounces-9619-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGn5B85+wmnqdAQAu9opvQ
	(envelope-from <dmaengine+bounces-9619-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 13:08:46 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C55307E97
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 13:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22F9F313584B
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 12:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1C23D7D8A;
	Tue, 24 Mar 2026 12:01:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023089.outbound.protection.outlook.com [40.107.44.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DDD3EF666;
	Tue, 24 Mar 2026 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774353684; cv=fail; b=et+EDW3Pe7pO5f1KGomiiY8tVAC2A2YQhTOzfcXbQb64zvGHqUrz0fpFL51bnSyyZxXnAxLOfvEaffFqt3CPteb54m/9e2/VitGCh4bZs9gsaSwyOG+abTEv1qRbdu87YNVIbbNn+VTi9pOGE/CjhMABXVy6AV80PZXP+CymS8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774353684; c=relaxed/simple;
	bh=yuNYyaIeERMI+JV0p7k0TqB7txQk6knrCCvEjawCxXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HbYIrUdmwvT4sKFfjkr9DecJjBAV0JiKLzz6R/vtXyeK91JaErrp8yVUqBmR4c9ajkmIu2bXiLNrD39EYns3g84KodmIF1rbzkPDul4tvoA7kv5s6Qeq+U4ut9ccd/GKKTN2FLXFdf7EzYx2Mm/LErhTjmNZwm4WzoU0pbp51U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaLu+Or/ljzl6Rzbs5QMDgViKhPdPKGX0NdBaHWiSkld+33Dt3v9mtAFwmN8RZnph+n6zV/jidfeJ2ywF3gFC6YZ3aQ1f7Ry5r/OpTRpQUXoCIOKMOzmxxPPOHUB4goMpwlVzndIZSTdrN8TmRj6G9SQDyJxacnip3Ga2QupMDWaIbzgWeFqYKkYXZZzg3rGXRugOm2y/ckUXNxEa159F/x31BKdoOc8a7w0JWDMDX+ylagov7p1RToYedYEzvDAE9D6390jeukmGOZ9SsbuwiOnAwhF5Faugy5jkMadbjJyL6yzBrczSkU/qE8GA1CXhYe4Mg+FsNckxy8n5+UhDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/48YHi9PH/jbHwNAxGtxWG5UWSPXla39qFvH8wMTRxU=;
 b=EIFMJs6p7J+a6TiTJoWMtf9bI7VUb/uonkGWAmahzg34HqPP79faVNpdoEwU5swn74BG2kC0y/oIDiS8TLZII65N6tGv1ovwsALFQLGWi+LOA1s8ftx3GqSdS9AAUDSs6lgp16kuq2EHeCNWfAOcccJL7SxmWfwZ7moDa3W4gzb0MG/abUUWtHsyItkzeFxPKNlALXDp5lTp/kfH4PSuwPXWJ89ZWkkxpKU43J/SykTZepX8F5XHyuEfHy8m2/WLlf9m96X9WJB/IwvD9ECNN+Z/C7ANH2ZYQb8AuoFIzU0sJDPDqwQNsxPVxmluo5r4p+JmOhkrMME49TOYg0v64w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TY4P286CA0119.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:37c::16)
 by TYZPR06MB6860.apcprd06.prod.outlook.com (2603:1096:405:1d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 12:01:15 +0000
Received: from TY2PEPF0000AB88.apcprd03.prod.outlook.com
 (2603:1096:405:37c:cafe::6d) by TY4P286CA0119.outlook.office365.com
 (2603:1096:405:37c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:01:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB88.mail.protection.outlook.com (10.167.253.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:01:15 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id AD9644126F95;
	Tue, 24 Mar 2026 20:01:13 +0800 (CST)
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
Subject: [PATCH v5 0/3] dmaengine: arm-dma350: support combined IRQ mode with runtime IRQ topology detection
Date: Tue, 24 Mar 2026 20:01:10 +0800
Message-Id: <20260324120113.3681830-1-jun.guo@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB88:EE_|TYZPR06MB6860:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6480a878-66a6-4501-1d34-08de899d0d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zNSACxjgafAiD0Qh6epW4DoYESRrYgsooJM6xuD672mPx60pvF0O33UkTPTVz+RSMzMu/OFXOGWF9FiMNu/N56LbJloYahUP7iINlTcd0MbZQ+e/A3VX8XdhOBPi/b6Sg1/tI+3kZkGrl3hQrBV0jZavUxHH3jOSkAtDpcTC6/tiidRvXAFlF+BRVXt0lywEuGRGtDqpCLFkJ0pF7CAlHBbYHI/n1ikEJpTS+5kCGRzzlTVgh11qKNKucxH7ZN+4mk3siP0njdGbm+NFDB23E/NNc4N7WMClmzGdM7dRg7Z2wDMsepGlQFLEQwz8dNGfXNRkkrabYctSFxN7v/7IJn7zd8K6wiiMYV61HOQeI18rpWbVfApySuaKhwVmaBcCm3EDTxsyefGI7KuYwPHJOLtSmUSw4glqH/q1HjI0yGvmBCVi6cof88iggLG+VI/0Cxam0ptGcDEW/R4xXQVYmYj1Enakmgx5jdMbiIEdKswD39OdRHUr21boduxMURqvg6hiP/GVOBkpehllF1f0aemD5gHX5OWFOZramEwxhGKqVV19lVQ2jhehGIfV9SnJ+chxK4QKIRHglejOm341UVUO2J6ZtSqrEx0EQzv3oQeC21WzTreZNE/Mq3eg7mYTJkn7h4c3wLI0cJR3VyUoVaEQToUzvjfMVsdyNP7d9p21rKOmGEfdXfgqMLaHAkrlF4kFLrvrGuqjZG46dVNbgKaOYseUPC+Ue9Y2peBxrrxF53Gy1k2pISk7kHy86/lzb7VxfePZoeK1OC68pQrlNpuoSERBXr0ujc/h8C15wXGDFnQnZIFOj4tWa9cbGc3R
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+8ucrI4K44X6V5WUeCBoxrkB/AXRR2eJ9oj64aDVJHQ/YTrY76tCrnAyP+/AbBWQovuAtYnoz5W7obGM1x5I3YRx3saobzA/D6gpsB7UBp8JPSygdOj/Wx4uwkHeEID6matsW358THBFpdVUs3aGa8vSD9vW7WLranmpeuzQGxauy6Ax5Z0cbV06E1FG6/XYUiiTZiZ7bbugqN6z6KfsXWG9ez+4nlbXi4rsqKy8BzRLV7laotVNHyC2q5TTjZY50t7UyMhB+pjVD/PwmG6xECYSa8FPTMMU0kf7XR0IPfTapJIO39q6yP2ocN0GWVX04q3oSiOzF74tL0gCvwviQljnjO1mhOttMsuB+yupe//IWkjcvs8jhlodJ8G3ZXxjjtLejNI2LHrDY/DsbZTAfv6T6cE0W0BAmoWL4vLUN0RODvF5NhkAsAhEfj+vYAyU
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:01:15.3570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6480a878-66a6-4501-1d34-08de899d0d1e
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB88.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6860
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
	TAGGED_FROM(0.00)[bounces-9619-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 79C55307E97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DMA-350 can be integrated with either one interrupt per channel or a
single combined interrupt for all channels. This series adds support
for the combined IRQ topology while keeping compatibility with the
per-channel topology.

Patch 1 updates the DT binding to describe both interrupt topologies
(1 combined IRQ or 8 per-channel IRQs).

Patch 2 updates the driver to detect IRQ topology at runtime via
platform_irq_count(), handle both modes in one code path, and enable
DMANSECCTRL.INTREN_ANYCHINTR only in combined IRQ mode.

Patch 3 adds the Sky1 DMA DT node using the combined IRQ topology.

Tested on CIX SKY1 with dmatest:
  % echo 2000 > /sys/module/dmatest/parameters/timeout
  % echo 1 > /sys/module/dmatest/parameters/iterations
  % echo "" > /sys/module/dmatest/parameters/channel
  % echo 1 > /sys/module/dmatest/parameters/run

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

Jun Guo (3):
  dt-bindings: dma: arm-dma350: document combined and per-channel IRQ
    topologies
  dma: arm-dma350: support combined IRQ mode with runtime IRQ topology
    detection
  arm64: dts: cix: add DT nodes for DMA

 .../devicetree/bindings/dma/arm,dma-350.yaml  |  25 ++-
 arch/arm64/boot/dts/cix/sky1.dtsi             |   7 +
 drivers/dma/arm-dma350.c                      | 164 +++++++++++++++---
 3 files changed, 161 insertions(+), 35 deletions(-)

-- 
2.34.1


