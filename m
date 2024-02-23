Return-Path: <dmaengine+bounces-1101-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5462F861887
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 17:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33361F224CB
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 16:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50E7128831;
	Fri, 23 Feb 2024 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U4VPDVMl"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD78384A37;
	Fri, 23 Feb 2024 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707426; cv=fail; b=Sk/tyk0FeSNS1nnzooIaSaArBxKOYGwBYzMucO74pp/x/WvVfi/MtelvQortsWHo34YySDBNz4TycqqoOoxNCpHeSrkw4lny+F+RNzAQjse8r1Gy620Doa+hA3xAyil6mdwGchKeaXNKCk/K/SeVCuE5alYqGSFmY0KxYs8wvoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707426; c=relaxed/simple;
	bh=PK0b6REY+aezegtPHhQjPP7bLmf+GEbSfBanD3e3k90=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fKiM55AvXTpyhZmcRt24jqwajZ7NMXb+bLCDmyb4VOsxG31fBhBZoyg9Yzn/B8D9hu914aFD8GvTvAwAThNjodgd1w1TQHgY8tIM1mxdSLVHt7ZO1gcPakQOIa7jSi57BHUXUzw87gzoDKrB9bjnJHiMOkXrsc2/edM4GHo2IhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U4VPDVMl; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c25Afx22CEH5ZugQvNuz3loUh3Ge7EXLL4PtymNI9fCfgeSb+FKXpfCXJwAGzRocL5t7ZTHOosEr25nvXlRqyg1CaDmkBheKQPj/CH2yNphHUoOVOT1mw3xwfg1nNlQHeA440z+yH+ZvQmWoP47S7hH7INJcM7EUZWm/orUb8XcOlVAsb8zygcBj96WUTt9+i5bWET9HAw+TeI7uA+ZHgn+Wmu5xV91vnwNG3yC6ynYB2O3mytIHjY831JTAPblUyu2QKPxK/cPO5XOkSTAAoizjWDF96H3oY7dKPNvKzylV5b6EUKIPil2Xm8o2zeK4J6mycE99hHlGlSiXwAxxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDRZaMc9z3c/fNsnadu7iC1WOhR0GdmLUbCcdr5PmII=;
 b=aOgg2Bf/2/CXja9ACfZMuS1uHdNg5OGtf+NU6veevOkD7fwcDDABYH2X6J732npgcWHrGBewxsxqYPC20+YWjYn+SNYUBqSQxDpTXd5UscPZq4pZJb/83tQrUSRjOfg2O1C7CpL7c+iYtF6tS9hjIIWPZ2ocuu8wS6nK6IlRDlWSLHMyNhGiaOyeqQp56JWWibYi4r1MrxjWZSdoikzaeir8i6Rvm1S0f6TGqMhjr/ndByXyT2OQQDftcJw9/EMJOgFb0WCYxPD9PFndTDj81+P28IElNJfSwJvDXcMEnjnMihB9HKTWUBMS7R4SaXFvaP6O1HYfyoFQxGof6fHlow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDRZaMc9z3c/fNsnadu7iC1WOhR0GdmLUbCcdr5PmII=;
 b=U4VPDVMlHPsnr9J5YO/LvF1V0yJhjoIx3AgTwfoQew9NGQ5HnZ+mHA9T5kexIIG3uHAPMcU58N4wh1IXtw2q7qUhpeziAYF0wPVR+XI8V4SQFpSPMgV0VTEidg9nIidsmtYZIf8Dnp9mRbT+djddTyCbJi8rOY5itvislAP81go=
Received: from DM6PR21CA0002.namprd21.prod.outlook.com (2603:10b6:5:174::12)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Fri, 23 Feb
 2024 16:57:02 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::1a) by DM6PR21CA0002.outlook.office365.com
 (2603:10b6:5:174::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.12 via Frontend
 Transport; Fri, 23 Feb 2024 16:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 16:57:01 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 10:57:01 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 08:57:01 -0800
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 23 Feb 2024 10:57:00 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <nishad.saraf@amd.com>,
	<sonal.santan@amd.com>, <max.zhen@amd.com>
Subject: [RESEND PATCH V8 0/2] AMD QDMA driver
Date: Fri, 23 Feb 2024 08:56:41 -0800
Message-ID: <1708707403-47386-1-git-send-email-lizhi.hou@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: bf52b980-d1b8-45c3-6e47-08dc349074d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3owEvGogpXxedVTS6NpxEtJPnYAd6CO/ZvuSnz6uR1VetekzlL74Z41cW3SgR7fm8ZBCILHSmZdOgVJ+J8OZlPFqa6jawhQHMro/9ap3DLKk6/MtC9/rYb7BGBZqNfwgOk9Ocvtw3Zj9A3YW9TDS7eEeWdJ6eb1T+lUmgXEvMsvuSsmnsoiQcbP9NH2iSoN+3pX1dIm4QubBFIN54PRKrmK0U/DxjbdmZZFKq4jaoyCDEnyotX/0tmRVSSqwUT7HbUxn+epti1XW1j82A6fwshewKjWMeCPDwjU8+6vhDJAlF9rYfZf33zTSIOUL53nsqiY19umZo90E0JSL/bZe9EBwy+Tc588jdtgCltIhi+VvoZ0DOsJPjNUJrw43DDSgVDYsInG70z2WoBNYATwLg+TydQxyRSWQhYeCBl3TwGR8YVKoI8E3yNIeCJDhR/s1SyxACtzlBkizEufHajQt+W592nKLA71+GIp+iFJNnzieMTlrC62mqOcZn9aR4wzk1++bSkt4vx28JANYs//ztccyhNy8NV8Q7BvUrK2AZr9AAr9m2Z82hpt9Y82prvqneX6MI3S8j8ueEFFcaxXI0FIialYGwDXVn5uH01TCXLkBwWYI3Kt6mZQDOEWOaV6NZVR3DqnM2HHRdIBDLGafjw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(230273577357003)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 16:57:01.9025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf52b980-d1b8-45c3-6e47-08dc349074d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

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

Lizhi Hou (1):
  dmaengine: amd: Add empty Kconfig and Makefile for AMD drivers

Nishad Saraf (1):
  dmaengine: amd: qdma: Add AMD QDMA driver

 MAINTAINERS                            |    8 +
 drivers/dma/Kconfig                    |    2 +
 drivers/dma/Makefile                   |    1 +
 drivers/dma/amd/Kconfig                |   14 +
 drivers/dma/amd/Makefile               |    6 +
 drivers/dma/amd/qdma/Makefile          |    8 +
 drivers/dma/amd/qdma/qdma-comm-regs.c  |   64 ++
 drivers/dma/amd/qdma/qdma.c            | 1185 ++++++++++++++++++++++++
 drivers/dma/amd/qdma/qdma.h            |  265 ++++++
 include/linux/platform_data/amd_qdma.h |   36 +
 10 files changed, 1589 insertions(+)
 create mode 100644 drivers/dma/amd/Kconfig
 create mode 100644 drivers/dma/amd/Makefile
 create mode 100644 drivers/dma/amd/qdma/Makefile
 create mode 100644 drivers/dma/amd/qdma/qdma-comm-regs.c
 create mode 100644 drivers/dma/amd/qdma/qdma.c
 create mode 100644 drivers/dma/amd/qdma/qdma.h
 create mode 100644 include/linux/platform_data/amd_qdma.h

-- 
2.34.1


