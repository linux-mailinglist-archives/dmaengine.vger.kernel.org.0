Return-Path: <dmaengine+bounces-10167-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANl3Ns998Gl8UAEAu9opvQ
	(envelope-from <dmaengine+bounces-10167-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 11:28:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 787EA481699
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 11:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48F7A3295D37
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 08:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826E03DA5C5;
	Tue, 28 Apr 2026 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q0JwYACV"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB40E3D905F;
	Tue, 28 Apr 2026 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366369; cv=fail; b=AfFeE+gfO28bqsHhPoeO+bTJmhwdjUuPLq+xwwh3lTg+g0+mjakDtwek5RYj5MyfxX3wMVxj8y5gJOf1sl0crPMij2mfj9khnOSQLAx+FGwYXu58jGnYjQC0HO1LIvRMb37YT0pLsjNDMFjzF5yrFyUsrwou/P9G2MsHEfLnHtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366369; c=relaxed/simple;
	bh=NDqlDf3n2tS8Pona1Z1WtZ4OzW3MUZbJItiaXBIyBt0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dbtomZUgeJDbuqv9O+DpjX4n7a98+A4QTeQNcJ9+v+ciah8xwa1Zr8dSEDV7z2EXVBlEqrnIxF2fAmRczuwsWqf5dfa1DTu9sPnU5H99sI5YcuwIqACGR805F+bYNJCMhRXbBY9Fc9SWizAxjam/K0xYSBINMUmLqcGVypDlEUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=q0JwYACV; arc=fail smtp.client-ip=52.101.46.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxImIP5w5y2zl+oafrYD5I/4XcpMb6GzPIrg+EJG2O+eumW0I5Ep6oqdrjILhZzfxUNisyeS2gZj8Dig8gdbr6b2NiQlOb4fqUbjpgcmLuoNTy8OP50guoKi3M/suXNZ6cu08cBqDzuQax7dOMkLSB3a72gwORjg8TjRtFNKYmtLTrza5hutGPvDZLtlxTjWA8fpxCdCewcvSbiZsMBlm9WTkb9dv5GyuiKn1ZxsjppFmQsBZ79gQkEkCqkS2OS7j7A4ieH8vb8aKYy3JpColGV5L/6rMG1xXKM9lTNK5OpfseLPpxr0RTcqHqVpKwme3iKeNLvt2s8X5DmFhhv73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpxIoxDMIuDwGhFhUsSNJT8jkrPzYIt3kEp/GIogvFo=;
 b=falBDFOwLN4c3T4okGofx1zS7BJIPDmautU1Ft5tOAJBMS3VGgCS0kmRL2lGuu56Jq0KWk6o2Qr3znT632vnPMEwBi4n+mAy+yHitZ/xs49aVvMA3/SHGbSr33sjK0NByUmYW+Izk9Xs6Ycp+7zwoa/8pWpHt/PzUDqt2EYDFwPqgea+QkFxCya7g4lQzJ5I6b0Ep9ghVFwx1yeUfmWqGRkjUbyEHGT7PHihdKwGZZnVK9dNiweImGOEVquRWIQCZTYJf/XpKzEURKy3AZ6EiAZYKLVQMSMF4xq/Tr5hbOffw2PmeTavJMe9boGIHIUZy4S2bWuSsJRnMyXDCdlH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpxIoxDMIuDwGhFhUsSNJT8jkrPzYIt3kEp/GIogvFo=;
 b=q0JwYACVWrgnnUPUSYmNQ38iDkSAVJdv2tlA6tBTgoyzquEy15QZk9Tp7SPwLy6AX6W8Nn5Enb+AmNmUcIg5MG7p8vmskQvYLhVQA2bkPTY2Oxfy4j5iuF6KFVOE2XbsJaIfm2b/Uhrka+R9GAmyZeCIow1tHu1YsroZgDBpCiY=
Received: from MW4PR03CA0183.namprd03.prod.outlook.com (2603:10b6:303:b8::8)
 by SA2PR10MB4729.namprd10.prod.outlook.com (2603:10b6:806:11c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:52:45 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::ea) by MW4PR03CA0183.outlook.office365.com
 (2603:10b6:303:b8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 08:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 08:52:42 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:52:12 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:52:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Apr 2026 03:52:11 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63S8q6MI623293;
	Tue, 28 Apr 2026 03:52:07 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v6 00/19] dmaengine: ti: Add support for BCDMA v2 and PKTDMA v2
Date: Tue, 28 Apr 2026 14:21:29 +0530
Message-ID: <20260428085202.1724548-1-s-adivi@ti.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|SA2PR10MB4729:EE_
X-MS-Office365-Filtering-Correlation-Id: a631c869-50bb-4f04-a8dd-08dea503826f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700016|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	lYcFMAmo2VbJzXIFKpUtBem1qz0r38Ctb+4jSd7ayiIWSNeKFXqq042Nlyerv6Buni2dEsgbma+5Ba7QzlQB/LeYlwy4ITavpwypDAXEoRyg33893TE9ljyuXUggBL12ImB31uw8g2ze6xxqIJQHsGDE4tNZhpYc9fyae/iZmfSzoBT0lPSet8f92pIZSU00fVjK1ajU/gvzLvKL++Hdzt/woXUgZsjRPXnUv/i7xwkhjtBfetSGPjVdtfBjC5xcf9Nz6oVoreN+v2pY5Rd3UP4q96/uxlNIuuPXLVFgC+fakbysJcMy0SeGZ/d20BBahNFKgf75xPMGQRre3N5RuhAgrYN9EFQDz6JCUX5B/j/MRcOLDKjYFQfGYSOVAahUZs5frhLO2vOodjSeZPrlgnPov3kifOU00B+aBi0ZnqsiHDn/N4vujGv3nAgVs+5KJNbQ9+Z+Y4s0VEMyJ7bG/TGuS4wO8y970zfIuAIvdxL028Fkwo2Cihlb7rVJy1GdGH6oCdhaBLPGYWDvFVUvtIn7//2wq1dF03SJEyWBN4B+OW4CeTUKkaIIQHvkXI6KfX0lccjvwjnyUBXx5GesIAYc3nepSSAqy+17msLHa3a/HWqkncxF5UI1UOfTnW13tvqyraUa0pRjpvtTNQMts+6YVg31Y1B4/txbcnnGpjCJ3qANGxbNLxWae7K2zPAqkqfr+AYfnytZYOzGt3tzk3yOSpNa/AZgdvabaE3GeKdAlA3B6ylb2pZgVzOZbq41fJDCtkSxTsgkgakXEAL7SRJCeQ1FR2G6mAtYb4YPLaFAYssoU2+nR9QH3wPjLBC3y3l3JdnJciQkfns8mHufbg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700016)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jAu5/2MdqOl+czl8jRhbkGDTDUVJwir/RuBdNoWQ3Pl5vqwpy0HN71W+jiJW/5yIQaaf5ImAU2EhJIqegKePlWB/RkO28jhNwU1N88PZ1xwxA/aVUagOurwP0CczN2Zk7VrOJxZhThhuVCynusTu49ufXEjwV38K195L3eV0s9tok1C6qBNp9OzG06/rvHBedHKq3UXJinAFp//0a5ofOpFMWgnBYG2uwrRFDiriOYzIGkWepVjGESoKLVVPJoIyRPZPGi9IsMS4YTsOGtvgO5gPczd7mHquy5geNnMkDutqqr2luBJfc3oOOeHHshob2iNQGvM7X8hq2lg9ndW1z1GsjyDQAmHYVh2EFKMqySfRNdrP2AbDRvbjK+45GIN8IQPfWp2JRN/f8oSYpN52eiYXHmuz3XUKoW9Qkc70sOKfUxsXCCm5JiSlJm2RdNTw
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:52:42.3672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a631c869-50bb-4f04-a8dd-08dea503826f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4729
X-Rspamd-Queue-Id: 787EA481699
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10167-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:dkim,ti.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]

This series adds support for the BCDMA_V2 and PKTDMA_V2 which is
introduced in AM62L.

The key differences between the existing DMA and DMA V2 are:
- Absence of TISCI: Instead of configuring via TISCI calls, direct
  register writes are required.
- Autopair: There is no longer a need for PSIL pair and instead AUTOPAIR
  bit needs to set in the RT_CTL register.
- Static channel mapping: Each channel is mapped to a single peripheral.
- Direct IRQs: There is no INT-A and interrupt lines from DMA are
  directly connected to GIC.
- Remote side configuration handled by DMA. So no need to write to PEER
  registers to START / STOP / PAUSE / TEARDOWN.
- Unified Channel Space: Tx and Rx channels share a single register
  space. Each channel index is specifically fixed in hardware as either
  Tx or Rx in an interleaved manner.

Full tree with device tree patches can be reviewed at:
https://github.com/sskartheekadivi/linux/tree/dma-upstream

Changes from v5 to v6:
- Switch from interrupt-map to interrupts and interrupt-names in the
  dt-bindings.
- Reverse the if DMA version checks to check for v1 and else v2.
- Add new patch [01/19] before refactoring to fix sporadic crash
  observed on AM62x.
link to v5:
https://lore.kernel.org/all/20260218095243.2832115-1-s-adivi@ti.com/

Changes from v4 to v5:
- Introduce a new version variable in udma_match_data to differentiate
  between K3 UDMA V1 and K3 UDMA V2. This simplifies the approach for
  adding any future possible variants avoiding complex if conditions.
- Fix both K3 BCDMA V2 and PKTDMA V2 dt bindings as per the comments
  from previous versions.
- Fix minor nitpicks like following the reverse christmas tree order for
  variable declarations.
- Remove the patch [v4 19/19] that switches to synchronous descriptor
  freeing. With this patch, dma_free_coherent gets called in irq
  context and hence a WARN().
link to v4:
https://lore.kernel.org/all/20260130110159.359501-1-s-adivi@ti.com/

Changes from v3 to v4:
- Rename the dt-binding files to add "ti," prefix.
- Update cell description in dt-bindings and add client examples.
- Update k3_ring_intr_regs reg names
- Rename soc specific data to bcdma_v2_data and pktdma_v2_data to
  bcdma_v2_am62l_data and pktdma_v2_am62l_data.
- Add a new patch [18/19] to fix a null pointer dereference issue when
  trying to reserve a channel id that is out of bounds in
  udma_reserve_##res macro. Also fix logging issues in this macro.
- Add a new patch [19/19] to switch to synchronous descriptor freeing to
  avoid running out of memory during stress tests.
- Fix checkpatch warnings.
link to v3:
https://lore.kernel.org/linux-arm-kernel/20250623053716.1493974-1-s-adivi@ti.com

Changes from v2 to v3:
- Fix checkpatch errors & spellings.
link to v2:
https://lore.kernel.org/linux-arm-kernel/20250612071521.3116831-1-s-adivi@ti.com

Changes from v1 to v2:
- Split refactoring of k3-udma driver into multiple commits
- Fix bcdma v2 and pktdma v2 dt-binding examples
- Fix compatibles in k3-udma-v2.c
- move udma_is_desc_really_done to k3-udma-common.c as the difference
  between k3-udma and k3-udma-v2 implementation is minor.
- remove udma_ prefix to function pointers in udma_dev
- reorder the commits to first refactor the existing code completely and
  then introduce k3-udma-v2 related commits.
- remove redundant includes in k3-udma-common.c
- remove ti_sci_ dependency for k3_ringacc in Kconfig
- refactor setup_resources functions to remove ti_sci_ code from common
  logic.
link to v1:
https://lore.kernel.org/linux-arm-kernel/20250428072032.946008-1-s-adivi@ti.com

Sai Sree Kartheek Adivi (18):
  dmaengine: ti: k3-udma: move macros to header file
  dmaengine: ti: k3-udma: move structs and enums to header file
  dmaengine: ti: k3-udma: move static inline helper functions to header
    file
  dmaengine: ti: k3-udma: move descriptor management to k3-udma-common.c
  dmaengine: ti: k3-udma: move ring management functions to
    k3-udma-common.c
  dmaengine: ti: k3-udma: Add variant-specific function pointers to
    udma_dev
  dmaengine: ti: k3-udma: move udma utility functions to
    k3-udma-common.c
  dmaengine: ti: k3-udma: move resource management functions to
    k3-udma-common.c
  dmaengine: ti: k3-udma: refactor resource setup functions
  dmaengine: ti: k3-udma: move inclusion of k3-udma-private.c to
    k3-udma-common.c
  drivers: soc: ti: k3-ringacc: handle absence of tisci
  dt-bindings: dma: ti: Add K3 BCDMA V2
  dt-bindings: dma: ti: Add K3 PKTDMA V2
  dmaengine: ti: k3-psil-am62l: Add AM62Lx PSIL and PDMA data
  dmaengine: ti: k3-udma-v2: New driver for K3 BCDMA_V2
  dmaengine: ti: k3-udma-v2: Add support for PKTDMA V2
  dmaengine: ti: k3-udma-v2: Update glue layer to support PKTDMA V2
  dmaengine: ti: k3-udma: Validate resource ID and fix logging in
    reservation

Vignesh Raghavendra (1):
  dmaengine: ti: k3-udma: Fix sporadic crash on AM62x

 .../bindings/dma/ti/ti,am62l-dmss-bcdma.yaml  |  121 +
 .../bindings/dma/ti/ti,am62l-dmss-pktdma.yaml |  101 +
 drivers/dma/ti/Kconfig                        |   21 +-
 drivers/dma/ti/Makefile                       |    5 +-
 drivers/dma/ti/k3-psil-am62l.c                |  132 +
 drivers/dma/ti/k3-psil-priv.h                 |    1 +
 drivers/dma/ti/k3-psil.c                      |    1 +
 drivers/dma/ti/k3-udma-common.c               | 2610 ++++++++++++++
 drivers/dma/ti/k3-udma-glue.c                 |   91 +-
 drivers/dma/ti/k3-udma-private.c              |   37 +-
 drivers/dma/ti/k3-udma-v2.c                   | 1467 ++++++++
 drivers/dma/ti/k3-udma.c                      | 3104 +----------------
 drivers/dma/ti/k3-udma.h                      |  590 ++++
 drivers/soc/ti/k3-ringacc.c                   |  188 +-
 include/linux/soc/ti/k3-ringacc.h             |   20 +
 15 files changed, 5449 insertions(+), 3040 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-pktdma.yaml
 create mode 100644 drivers/dma/ti/k3-psil-am62l.c
 create mode 100644 drivers/dma/ti/k3-udma-common.c
 create mode 100644 drivers/dma/ti/k3-udma-v2.c

-- 
2.53.0


