Return-Path: <dmaengine+bounces-334-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3037FFB79
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 20:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A3E1C20BED
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 19:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42AB52F66;
	Thu, 30 Nov 2023 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T65RmwOH"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02896D7F;
	Thu, 30 Nov 2023 11:38:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbB2o9spCbjo97WfNJE0ypkRCl+X5B66/jK4JaIxoK612dcvAwtNqDtDohHvS6mAD3dE/a7UO6Eb2iDMJ/gePz8lRohxSti+A5cMk1Zy8LG5OQwlUnP1GId7ahSTTCq+vGro29GE7YlQbQjg2YhZxos9eVjsin25osac6xXIFqcbM7ihfSiUT0td45WLSq+NM82FVwymoZAWZq7j98p2/xF5BUj//i9i5dUeE+bOdfKpooXX3R50Od/9YBXFSgEHrnxYisx4hwdWKB0ds8cJ3/Hnk0sPVMU4jjKY8hiOENBfrwX7fb5X/4yoI0mvriACKOkwkofwfdxNPJFiLESxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDRZaMc9z3c/fNsnadu7iC1WOhR0GdmLUbCcdr5PmII=;
 b=KjYow+94tGrpDmoXkLRZMwH5v39oGWAtWG7mgN7GMwcb9YHrle+831dY7KeCXH8qj6tr2OKbzohNo02F/8Prod/sIZ5nPeCQD2iYMiLGLOsjl5T07IitivMOFFcwB8ipcg4viDNdiRZxMuPY4fF0rfiMeyxaemBYyMKvMIZK7s+mrm+CMnbAZsCnWaV6pdabbphTxtJ0PJhOaW0FvilvE3PealyNZ13eygzcI6pF2JCqL6pjeXV7sikKPkHz5ydPs/ucICdVby2d1ZfOjVTwlNpOO0g7/bUvUJryfaeDoa7UvXwidxyyc4KnpEbRAgHj1jf4I2C2CZYeCdcz3RR13Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDRZaMc9z3c/fNsnadu7iC1WOhR0GdmLUbCcdr5PmII=;
 b=T65RmwOHGhzhH875XrpkxmnGM15G5Nj0qDqo2fvYLq850ktWxYWwZKwEG2M9p5wXrHhQIrt33u4NkCQ8e8dqPjSKMpG8dA3NaaWSGV+c67NKHHyddU7OL4HfGrqx+KApmlZShwghApnI4O6yIRsWMLd+c/0p1x6rcksv8m2nQ9M=
Received: from CY5PR15CA0001.namprd15.prod.outlook.com (2603:10b6:930:14::8)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 19:38:48 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:14:cafe::4e) by CY5PR15CA0001.outlook.office365.com
 (2603:10b6:930:14::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.26 via Frontend
 Transport; Thu, 30 Nov 2023 19:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 19:38:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 13:38:47 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 13:38:46 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 30 Nov 2023 13:38:46 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <nishad.saraf@amd.com>,
	<sonal.santan@amd.com>, <max.zhen@amd.com>
Subject: [PATCH V8 0/2] AMD QDMA driver
Date: Thu, 30 Nov 2023 11:38:21 -0800
Message-ID: <1701373103-67868-1-git-send-email-lizhi.hou@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|MN2PR12MB4271:EE_
X-MS-Office365-Filtering-Correlation-Id: 99054f0e-66d1-4829-48c6-08dbf1dbf8cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cZEcjF6h3247pVVJuOb2GCx/TPBp5GEe10Vzp5zbKx8pyJMYXQCKtOv22KA30qhEuujDoqRQFrLaO8FeO5PtZtn8sNE0GuwbbazDbAzbKW51Y6+6zRiKUniG2vbWAXmYnVZ/5pejQg4OwVtcxH0+qGYWBxl0BBjt92cFCQEVyLdMRx7GLe0HrIfh7pacW1kzIhIWs6uG7CY/NV0bQREqAMm6O1JldexJIejXzQKillDs98CsIRDzsyGALMNXDhWY8NOl3vYHNi0TegpV3OVTontwCnlWLm20aJgEz3kcS7GHXfF4RuvA/CuHTReIw3VEfdYjYUg52jkhtmtaybADDweCy4PaJKnjaFhWGlk41R0hEqhwHadMUW89SSMLbDs5Eo+Q5JGdzzkvj2MeoYHgsL8IHMabq9UGGaPpHF50V6A++zQDBASgat2S2gkGUyPth42WeFB4L8bx69R1YzKwl5iNKoeGOXYatpGSBMSWR8pcC0t77BP2mAAe9D1Cg+Lxm6P7lbfroAj8Npy1MPNFGuFbRdhJcSOcEC6U19gc6+j3CGZgi9YMX5FowwB+hiBCS+H+cwoCWT1lWLEuKxVWWTRsk2WbRMcd2XSo4eo+nUfWfoA5cCpGUgAHHSC+3+91b3bPxo9iTAwR/FP0MoDeWqGIhm75DGhN51UvGbpwNxrlp1gyPHhm5PLRnFvtGid5PrFwd5X4z5iHSi2PLWlv+E3V/n4CvoEoR5hAwVx2TNS6/51uzt0As2R8y3V2GptoVG/RVAEnNxoDxrIpCtttHRyPyRpTkFHEn/IWqLy5+PFlMNbU21s7vtLGY4ZinZIexufCaIYutca1FGy/kgR9Vw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230273577357003)(230922051799003)(230173577357003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(46966006)(36840700001)(40470700004)(81166007)(47076005)(40480700001)(356005)(82740400003)(83380400001)(26005)(41300700001)(36756003)(336012)(36860700001)(426003)(2616005)(6666004)(40460700003)(966005)(5660300002)(2906002)(54906003)(44832011)(316002)(70586007)(110136005)(70206006)(478600001)(8676002)(86362001)(8936002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 19:38:47.6167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99054f0e-66d1-4829-48c6-08dbf1dbf8cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271

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


