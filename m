Return-Path: <dmaengine+bounces-1836-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0508A352F
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 19:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4519B238A5
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 17:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F4E14D70F;
	Fri, 12 Apr 2024 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wNMqfQSi"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1530714D44F;
	Fri, 12 Apr 2024 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712944528; cv=fail; b=oF/ClhSvzIaL175CmLY2PQUn2/mnwEZYZvl9zzTBmbSBbxwLLL4kVCOP+Qfrmoy83PPzS2zdElP3jB85gMeNU4eo2jeYB/Mo4dAYmIUFfOEvmx2OGBLEA9/EUbbo2o+fiuf0qsljpQ1DcORs/At/s7c7XDmWbYuQYVD7BxY37ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712944528; c=relaxed/simple;
	bh=R7UhHZArmV5IDC4eInIRuoz87QJ0u4i3pVmfYJE7DsE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V5dIrb4QUJpKiOFANahvL5GUhmymMvfFNeg5253YF+qHB6GerbRPZ8N596k3/EFgCNfDwgrFOR9i0ojv14UnJZAFo+nHBKfO3LnFJZ32wsLUKfdHh+Ikbj/64g8JFqNS7Qd0UFCcZvGQbGFAO1DVQv3T5HPnkvaG5amsbqCKk+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wNMqfQSi; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8AJpvdPhj7j1op2uvvttjGR14XO7I+fXknkO9mtCuiOKqfXFrLccvSTP6gCNvucKJEBXdWMXmfdm2QG4Zd0sjEG7gOlkMLYnEx8vZDfL3P/2J9JkDPelW0n+ZBChmfF5CQSvd+mAtpd+H4Vwt+ryOV4WvbMEmpRhk5xGk9xkvKe2B7pR0pAwRbuJYbp8xli0aIRWa5Uf3eVjEYbmCblmAH4NUKqzqr0xMOVuk5O+A05qKW9ceA3dN22Ai9tZPYxlT55jyQSY1eKaKbacl1oWiXS7+rp5uT5KGePA66z2zZs4zxAd9P6i7o7Gqz87Tz4ENNlaXnVXJ4Zvf/NqWTNLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQsmjPcWV4ajg59WtSsQbrcNKJJ/IKwSgzEykSST9Ks=;
 b=SLNs9eYc4+Lb9xPT8eareOzoQgJyRNProLJDek3ZNcIU0rbrKIpRoGjMLGiNAd/qYnXlUta/njTeISFrLRht6+tj4kkxt9vBH29uN4ScQmBVI7hkfz18Q9A0iVX41YWmVWJFb72RuduISbLL7we03LO5YrjINacfkBxOUgA1zTcYahiEjgOJdd07Bo5FjsUV2WHxeXc/Jet8V+XORghN/zVjqhKdmDx3TkRaRlILbXzrC5eibgcq04IKQITUx+Yd1IfV9bWX0QEk/GnancS//ae5iUeQtAm+M+dn27d0aPVvZ0fvKIYSNIK+5z85KKqUOGO/srYBfm8KqJjX6OtdVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQsmjPcWV4ajg59WtSsQbrcNKJJ/IKwSgzEykSST9Ks=;
 b=wNMqfQSiUwVxNaiya8G5aVhG1wV4wdrQ+rGTcJvnsGVAwayPru9rzgFt14GvqAvsHXCu/VWGpo3lPYWtsrjPzz85Ip0D44FmsKBRuW88l8n9YSQhvXHqVDDyb2l8pHnyDKCocFXYLOGCSv5XqWD30zWTyLfTqPvB5U8qqvz8Hxw=
Received: from BLAPR03CA0120.namprd03.prod.outlook.com (2603:10b6:208:32a::35)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 17:55:21 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::25) by BLAPR03CA0120.outlook.office365.com
 (2603:10b6:208:32a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.30 via Frontend
 Transport; Fri, 12 Apr 2024 17:55:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 17:55:20 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 12:55:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 10:55:20 -0700
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 12:55:19 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <nishad.saraf@amd.com>,
	<sonal.santan@amd.com>, <max.zhen@amd.com>
Subject: [PATCH V11 0/1] AMD QDMA driver
Date: Fri, 12 Apr 2024 10:54:00 -0700
Message-ID: <1712944441-28029-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 66439ac7-c069-45bc-d8e5-08dc5b19b883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UvydliJ/HYo4IeuVxBl7iTl3ZQKaKqLiKirKsOc3uD/V+BXj/XzTNszrxbkT81b0T3U5Ws0PHnY/5sTIClUR1dwynEdmTMsgomSQef5ROQIHvogHWdIe+XEqXkcEVTEOlGubWcChMhBcbtCeDlUutT/LkMEtwvIDMBp6y/YmV3T2qHOOqZfHT7i7lqLlNeZux7cxwU2qd/8TTBQOO1eXmx00TrZ50eQyOl3j0A+ZWPz85OrGo2WE4h0p5GIi3jf1zNi+F6BJQntfG/FRotkMiGLb5ejR2/0c07CccZ7oty6k4ZBArvObxntP9aqM0eXhqiuXI+OHPHXiiIR9fjQBO4Ge8vfExYkwVOZv5AwmSPHL9hK9g8VsrihjvaPG4WY1MwS2NsZYPaxqyluC1+GyysTinJhQJVeqTFep012sidC/5xEIjD3gMqWWLlurXOx4eJHIGEbMlU++NHEp+SWQAzYz8Do65aGdP/k3MIZLIqahy9YKtwFBsd+F7HmqhMyrGzaXaGV4UBL47dmkAjsiVs8hT5aB45LrYv7ZIGMkVhy9cdVGbsL9QQ8aombJ4ZMJi0UkC8zCaP/fFPM9oGCjTWvGrLJgxEOTKgPsT/AunwlwOBzCT+BOAKseki/++27e7f/osIVEht3xJVND5xVcTVX8CS0ZX7NpUVwzHbdUmVYjWRHmkPBupKGRMt9dQJaKWB8h8R4/ccrPWgu19lEsb/+4xPSwMT/Jkszy5apzzaPlnpfMiSycUYV6QmANwms6aIJ7/ZSmcUEdqlUPykC45Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:55:20.7257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66439ac7-c069-45bc-d8e5-08dc5b19b883
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347

Hello,

The QDMA subsystem is used in conjunction with the PCI Express IP block
to provide high performance data transfer between host memory and the
card's DMA subsystem.

            +-------+       +-------+       +-----------+
   PCIe     |       |       |       |       |           |
   Tx/Rx    |       |       |       |  AXI  |           |
 <=======>  | PCIE  | <===> | QDMA  | <====>| User Logic|
            |       |       |       |       |           |
            +-------+       +-------+       +-----------+

Comparing to AMD/Xilinx XDMA subsystem,
    https://lore.kernel.org/lkml/Y+XeKt5yPr1nGGaq@matsya/
the QDMA subsystem is a queue based, configurable scatter-gather DMA
implementation which provides thousands of queues, support for multiple
physical/virtual functions with single-root I/O virtualization (SR-IOV),
and advanced interrupt support. In this mode the IP provides AXI4-MM and
AXI4-Stream user interfaces which may be configured on a per-queue basis.

The QDMA has been used for Xilinx Alveo PCIe devices.
    https://www.xilinx.com/applications/data-center/v70.html

This patch series is to provide the platform driver for AMD QDMA subsystem
to support AXI4-MM DMA transfers. More functions, such as AXI4-Stream
and SR-IOV, will be supported by future patches.

The device driver for any FPGA based PCIe device which leverages QDMA can
call the standard dmaengine APIs to discover and use the QDMA subsystem
without duplicating the QDMA driver code in its own driver.

Changes since v10:
- Fixed Copyright

Changes since v9:
- Merge 2 patches into 1 patch

Changes since v8:
- Replaced dma_alloc_coherent() with dmam_alloc_coherent()

Changes since v7:
- Fixed smatch warnings

Changes since v6:
- Added a patch to create amd/ and empty Kconfig/Makefile for AMD drivers
- Moved source code under amd/qdma/
- Minor changes for code review comments

Changes since v5:
- Add more in patch description.

Changes since v4:
- Convert to use platform driver callback .remove_new()

Changes since v3:
- Minor changes in Kconfig description.

Changes since v2:
- A minor change from code review comments.

Changes since v1:
- Minor changes from code review comments.
- Fixed kernel robot warning.

Nishad Saraf (1):
  dmaengine: amd: qdma: Add AMD QDMA driver

 MAINTAINERS                            |    8 +
 drivers/dma/Kconfig                    |    2 +
 drivers/dma/Makefile                   |    1 +
 drivers/dma/amd/Kconfig                |   14 +
 drivers/dma/amd/Makefile               |    3 +
 drivers/dma/amd/qdma/Makefile          |    5 +
 drivers/dma/amd/qdma/qdma-comm-regs.c  |   64 ++
 drivers/dma/amd/qdma/qdma.c            | 1162 ++++++++++++++++++++++++
 drivers/dma/amd/qdma/qdma.h            |  265 ++++++
 include/linux/platform_data/amd_qdma.h |   36 +
 10 files changed, 1560 insertions(+)
 create mode 100644 drivers/dma/amd/Kconfig
 create mode 100644 drivers/dma/amd/Makefile
 create mode 100644 drivers/dma/amd/qdma/Makefile
 create mode 100644 drivers/dma/amd/qdma/qdma-comm-regs.c
 create mode 100644 drivers/dma/amd/qdma/qdma.c
 create mode 100644 drivers/dma/amd/qdma/qdma.h
 create mode 100644 include/linux/platform_data/amd_qdma.h

-- 
2.34.1


