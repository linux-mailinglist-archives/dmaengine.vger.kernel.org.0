Return-Path: <dmaengine+bounces-9644-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMsdInPew2kgugQAu9opvQ
	(envelope-from <dmaengine+bounces-9644-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 14:09:07 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF5D32574E
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 14:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C71D30DDAFF
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 12:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17C53D4132;
	Wed, 25 Mar 2026 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ze+7g3Od"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909F23D3D18;
	Wed, 25 Mar 2026 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442221; cv=fail; b=K3Hp0osYR5C/SHyzymhVNxkjTmaAYpBVP5OvXreNG2hY1Uu18NfwK1YZF5vWA59kBeQs7n1LKW5XiNnkdOhm5PE4+XHfCXOf4Oe7SSZqsFoDTLoKFBEmcolsKQX+pmb62EjBsuSlyfQcNZ0JJk7UG4vhNPNcSxIlXLT8pmeA8TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442221; c=relaxed/simple;
	bh=tZh6UM8t2lGHaP1kvhQNxedzTabcRTBaThhqPh86dTQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dYVgLBovCbOFdk5LEsZh3hV6yIMzMrZogwCm4fq752pZwqFe39fsq6JjZhFUm8FnUMsB1PBJuLKgFHcHszl2TnbjZxVq9WtWvaSCLthN8aAIFfLLt4FGETky1Xpm3wzRQV6hkEVurrt6DmxUtOTTyWfWiR2HcyhPWXuTaMZQtpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ze+7g3Od; arc=fail smtp.client-ip=52.101.62.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWn93wTS2oUB6FNbNLxB+K9oMxByYa8JkQRaN1C+VuiojKXvGyrkI872Yxq3bb6QrOTyUgfJI4SxnDKzcrcLbcJTIXI1r6PNmvzMWG/I2D4khu5fTyfyz3o7TPsk/WIIsELvO6XcUt9zRJ2fj8PB7D2Hq6F0LyUQQwngpHfymLZa8kzk6HA7MOj/7X7L+rRAea+NfRLOUDHLOjnF/7Ysjil1N+y3KirXrD4HVX0A3HehEjzK9OSbfPdXvTYGDCUv3k77nBPBCx7mOxonYGJvDrTOvIiLY20bvlB2C/05M1pXcJLz8dgEk/u0YjaalRP5ZprWIRjzq/aRtMf8oCJeoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13K24TFOG1F3oiqIzwcE+0XCvGAkUcd6KJJKOkscNqs=;
 b=L3kry+1HM0nc/7VR7yVm4Ww5qWlnVr7omdfYfpAwyjjy7v5zzTvGIw/oC86UWsnPYfRleBS/tqx5zWtfo2XIRrVnqCq9DNVJ3c/FmxgiVRmRhbeeg2MaRUvBiXL20ypkG34rgYpchBbFlTchEn3AbDoj7vM9qFmbdODp6jScQCOaWDxnKy/0faTOIIcOhStifXNIomaN0TI0w9W1/w8t/5ioTBw4CwGakqLT1E1swRxdBos5UzRSoqZlGUqI+OKoPEzamBvCeEstOPeHoa1426uOKB7LHOJJ0pEjZieSXbUSCJRjqS71NMTNsZT4fyCy158g5D8pxqSovIFXBc+KRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13K24TFOG1F3oiqIzwcE+0XCvGAkUcd6KJJKOkscNqs=;
 b=Ze+7g3Odus6DwMdgGRtxlhP2CH1FU9oMmOrTPOiR0OXX0n+xwNLJzL5v4CpUZF+Qk9/r/HqFV0/lU0Yc7fRxbD/LarRz+qc9xHLkpYNlLybE/pdbr68UV4zta1vzvvV2GKrvSpCFJ+uYnwiWCUlLkp3jf7JfDc2GDFPIp82TylY=
Received: from BL1PR13CA0266.namprd13.prod.outlook.com (2603:10b6:208:2ba::31)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 12:36:54 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::a1) by BL1PR13CA0266.outlook.office365.com
 (2603:10b6:208:2ba::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Wed,
 25 Mar 2026 12:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 12:36:53 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 07:36:52 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 07:36:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Mar 2026 07:36:52 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62PCakEV270453;
	Wed, 25 Mar 2026 07:36:47 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <Frank.Li@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <nm@ti.com>, <ssantosh@kernel.org>,
	<horms@kernel.org>, <c-vankar@ti.com>, <mwalle@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [RFC PATCH 0/6] Descriptor Recycling and Batch processing for CPSW
Date: Wed, 25 Mar 2026 18:08:36 +0530
Message-ID: <20260325123850.638748-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|BLAPR10MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: 34377229-c7f8-409e-2d63-08de8a6b3218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|7416014|1800799024|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	fupXZG7i7nGMcebxbv88NKItjPdVvg3R4Cz5/QVctbG+ndsHJUaaHhB5u8J7WIpycQqgYp2cTaKijfwoiPfkzpvx+2y2zz9bHTEmy1zD2HbGsF1sWWPEm9MwqtmDr0/edCWO2MDlco94FNYTgV9my8h8LIWn118iADdIIjAWLBQQL+eBP5l6dEwcnxVQJpAgXJzJLKZfJRXAMDukbM6o4BKN+m9KfMfiTLNnq5Ge+atkGKHYsFPV69RzQ/EqTXEb19N2DCXR38spA/h86aL45eztoH/plwXvMyXbYYY1BPwKTzky9WIlB2f/acmhcVWH2A+jGZ5RoO/lPPIyIQ3l9UTZNJ63698BKzBZD7tshNWxUZPKLiUPdwXTHUnORcu/rls96VYvZVeA6ivM5a5fjd3/jMzl89waQJTKOK/Svn4cp+Nhk9fKEyTxgmJZrVEv/yXWg/HkXrPihfRAh9iwPJp6bNaLbw5Imp3MjWCIVFTaY5krd0fz/QdoZPCVC/6VKFXCV+rYbfrNR+9vYaaziR08Gb4jQ9NgvdkBRELq8iLiJ5F+Hmbwth87QSyHkeaFvcTmTcGJ9sD4VWcxDuLbPb7HBBfM8n7sYX99pwjc3XKMnk78eErl81EcvD+pw1vaFzNZq4zH0uccYxXiYLsc93YxU8aGHUlO3ZG5yuqJ823reXG3iNJ7T7DmOSNtigjTdrSpX5elq7/tjub06OpDQXK8OZo9b7gJQru9Uuf8ZIuS7rjkQf5rrgmWlcZNIdpMNz9hukoIkKJN0keIi6QoGKf+CQWHq9KCIVrvyFzd20C/NemoAL1PHfGRj831eH6k
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(7416014)(1800799024)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CJFpBGnll5olIkhIGSKTkynfyuaWRObmkcxR/WCQddAE6gjhusenz70vhu3CaP1okNxfyriBLf/WDluHSKTjew6bJXa89P4qyy4nhxw6/BUN+0YR+UmYCx3Gwog5M+Tik0WhNoppMP4D9ntIVN3KrVZwXaTBEH4gwdjj3xe3WClGMgPzsjwx4jFtwDRSsYKd7HmqjIxiG7zScDJY8BcURpcEEWF0yQcmua07Dk3zDxf+UjxAVem1XZmETBMdiM3FiS04LdG/tItrlYwCKsKSPqXz9a5ozphR/7Jpx+owqH2BpBlsLnVtFlzXm0PMmkRMwe0ZFbDDzi4+5MHGdPkvlT7HlBvWgvx5U+yBSyL4S5q1p20fp5ZTTMbpIcPeQgT/rc2IZE/DSwqZ8BMMiutl0HjynwYtKGznY6Hka8HAnudkfRcsbnH5ry2HvgNuVLL9
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:36:53.8573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34377229-c7f8-409e-2d63-08de8a6b3218
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,ti.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9644-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ti.com:dkim,ti.com:mid];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9DF5D32574E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

NOTE for MAINTAINERS:
Patches in this series span 3 subsystems and I have posted this as an RFC
series to make it easy for the reviewers to understand the complete
implementation. I will eventually split the series and post them
sequentially to the respective subsystem's mailing list:
1. SoC
2. DMAEngine
3. Netdev

Series is based on commit
d1e59a469737 tcp: add cwnd_event_tx_start to tcp_congestion_ops
of the main branch of net-next tree. When I split the series in the
future, I shall base the patches for SoC and DMAEngine on linux-next
and the patches for Netdev on net-next.

This series enables batch processing for the am65-cpsw-nuss.c driver
on the transmit path (ndo_start_xmit and ndo_xdp_xmit) and transmit
completion path. Additionally, this series also recycles descriptors
instead of releasing them to the pool and reallocating them. The
difference in memory footprint without this series and with this series
is hardly noticeable (being under 1 MB).

Feedback on the implementation w.r.t. correctness, ease of use /
maintenance and configurability (sysfs based option for changing batch
size) is appreciated.

Series has been tested in the following combinations to cover edge
cases:
1. Single-Port (CPSW2G on J784S4-EVM)
2. Multi-Port (CPSW3G on AM625-SK)
3. Bidirectional TCP Iperf followed by interfaces being brought down
   with traffic in flight (and TX / RX DMA Channel Teardown) followed
   by interfaces being brought up and ensuring that Iperf traffic
   resumes.

The primary motivation for this series is to improve performance in
terms of lowering the CPU load and achieving higher throughput for
gigabit and multi-gigabit operation.

The upcoming features that I plan to implement are:
1. Enable batch processing on RX
2. Batch processing on ICSSG similar to CPSW (since batch processing
   increases latency, it might not be desirable to enable batch
   processing and may be skipped as well).

The following sections capture the improvements brought about by this
series.

[1] AM625-SK with CPSW3G (multi-port / two netdevs) and single A53
processor (remaining CPUs are disabled) with each MAC Port operating
at 1 Gbps Full-Duplex.

===========================================================================
Baseline for [1]
===========================================================================
Dual TX Iperf UDP traffic at 100% CPU Load averaged over 30 seconds:
403 Mbps + 408 Mbps = 811 Mbps

Dual RX Iperf TCP traffic at 100% CPU Load averaged over 30 seconds:
336 Mbps + 331 Mbps = 667 Mbps

===========================================================================
With this series for [1]
===========================================================================
Dual TX Iperf UDP traffic at 100% CPU Load averaged over 30 seconds:
428 Mbps + 437 Mbps = 865 Mbps

Dual RX Iperf TCP traffic at 100% CPU Load averaged over 30 seconds:
332 Mbps + 337 Mbps = 669 Mbps



[2] J784S4-EVM with CPSW2G (single-port) and single A72 processor
(remaining CPUs are disabled) with the MAC Port operating at 1 Gbps Full-
Duplex.

===========================================================================
Baseline for [2]
===========================================================================
TX Iperf UDP traffic at 84% CPU Load averaged over 30 seconds:
956 Mbps

RX Iperf TCP traffic at 100% CPU Load averaged over 30 seconds:
941 Mbps

===========================================================================
With this series for [2]
===========================================================================
TX Iperf UDP traffic at 80% CPU Load averaged over 30 seconds:
956 Mbps

RX Iperf TCP traffic at 100% CPU Load averaged over 30 seconds:
941 Mbps



[3] J784S4-EVM with CPSW9G (multi-port) and single A72 processor
(remaining CPUs are disabled) with one MAC Port operating at 5 Gbps
Full-Duplex.

===========================================================================
Baseline for [3]
===========================================================================
TX Iperf UDP traffic at 100% CPU Load averaged over 30 seconds:
1.26 Gbps

RX Iperf TCP traffic at 75% CPU Load averaged over 30 seconds:
1.73 Gbps

===========================================================================
With this series for [3]
===========================================================================
TX Iperf UDP traffic at 100% CPU Load averaged over 30 seconds:
1.28 Gbps

RX Iperf TCP traffic at 75% CPU Load averaged over 30 seconds:
1.75 Gbps

Regards,
Siddharth.

Siddharth Vadapalli (6):
  soc: ti: k3-ringacc: Add helper to get realtime count of free elements
  soc: ti: k3-ringacc: Add helpers for batch push and pop operations
  dmaengine: ti: k3-udma-glue: Add helpers for batch operations on TX/RX
    DMA
  net: ethernet: ti: am65-cpsw-nuss: Do not set buf_type for SKB
    fragments
  net: ethernet: ti: am65-cpsw-nuss: Recycle TX and RX CPPI Descriptors
  net: ethernet: ti: am65-cpsw-nuss: Enable batch processing for TX / TX
    CMPL

 drivers/dma/ti/k3-udma-glue.c            |  55 +++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 441 +++++++++++++++++++----
 drivers/net/ethernet/ti/am65-cpsw-nuss.h |  31 ++
 drivers/soc/ti/k3-ringacc.c              |  99 +++++
 include/linux/dma/k3-udma-glue.h         |  12 +
 include/linux/soc/ti/k3-ringacc.h        |  35 ++
 6 files changed, 612 insertions(+), 61 deletions(-)

-- 
2.51.1


