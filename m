Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D5F58F47E
	for <lists+dmaengine@lfdr.de>; Thu, 11 Aug 2022 00:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiHJWpi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Aug 2022 18:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiHJWpg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 10 Aug 2022 18:45:36 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A120326106;
        Wed, 10 Aug 2022 15:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAyfv8F1TtVmraOJZMgzsNXZ6egY8CRTIL+qARapE1mo4Wj8KXfGOH5WLItev3qsx6XL24/vzB9nZGuBOpU2AuAQlH7gC3IwVtNoyBQIV83oUW+4Xgt69mfpKNxGeIzMSivZalfntl4mGCJ6bbk9mHIHi1sTxsfR7v97CuOiHTLXwwjCU3M3G9JjuUUDiROggM2UJDmd9B9py/zu33nkCMG144nwnrAUl9t/dM+1hyFx6fKf7aTuSy+wcJEeLHUQOooM3Qgf/3IVhMUm0FY7AYri7zYfIDwYYnkfFfwE5qZflO4kM+1B5yaTlG9SejGZyq6B2cVBr/E+FP+X787ADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhTzjV0OT2QBKYciT2OwT6DLaWD4orz8uCq+fmwBLOw=;
 b=g74hAB+ijsKZifAbdDShaWsogDXNuYK78/26qphIttbCoCEgx5goS9pTvXrtej+tTmI+hSgEeTBGyXYnBGbUEtRnUyNHw3REbzixr56mPqejKwiR7x0ps3+rjz7OEp2YnHulaHdibSK4br7Z1j2Mo1J9wWAaHgaP3UEKap4iJmxkI0CpZExXfQ2IPcKWkiWs3woMRkHEtoAvnL0OjrAqnJBRYiVssqJpeCk8Wmntbq+vX7+SNyPt/vW4njfD23MBat03ymw1TwUTp75DxXZqc7NTtikvyVYUizam5vYiay1LIi2xdHOjzskJFLaN58Bco5qsVydJV858AgV6A3orQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhTzjV0OT2QBKYciT2OwT6DLaWD4orz8uCq+fmwBLOw=;
 b=Z2X9/+4G056tvIaYRIB/nHjSgJ5sl//ZG9JlwKCB/VAVc6FklZ/838Qk07hCp7He/00mfiaGfVu90WmAbl+mB6qh7/wTB3gPg/kJaVWhhP807WSzf1hpoK88uc1dbjgmR6RlK627MnksMGMhh+wwvvREdTKUSIbGbShR281kgjI=
Received: from MW4PR03CA0205.namprd03.prod.outlook.com (2603:10b6:303:b8::30)
 by MN2PR12MB3024.namprd12.prod.outlook.com (2603:10b6:208:cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 10 Aug
 2022 22:45:32 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::f7) by MW4PR03CA0205.outlook.office365.com
 (2603:10b6:303:b8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20 via Frontend
 Transport; Wed, 10 Aug 2022 22:45:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Wed, 10 Aug 2022 22:45:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 10 Aug
 2022 17:45:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 10 Aug
 2022 17:45:30 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 10 Aug 2022 17:45:29 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <trix@redhat.com>
Subject: [RESEND PATCH V1 XDMA 0/1] xilinx XDMA driver
Date:   Wed, 10 Aug 2022 15:45:21 -0700
Message-ID: <1660171522-64983-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f5ab596-4abc-4f1c-da6c-08da7b2207fc
X-MS-TrafficTypeDiagnostic: MN2PR12MB3024:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GU2tAF9IUP6BQlFdZs2RMVn1Odfif25YkfuirJ6ytknMZhh0OwOQXdLzrgLA11ONYZz5BXhpxkLRbYGK3DoHVcymwDaoBw28u5RPKdnlTmu0emPOsPIRocTuqvjqXLwTGI9qljlN4ZehhLFjA9g3OXF2oKn5CiL54a7S7Vd5DqqEpNLGD6WuehCg91QSlHkbJY7ApqfZpBI0Rttesv7f7685l5OIAEqUN9Vvo+hXGTaOF63qsBQSHoQqfULmw8AzZSNa8M3xUw9xMIE1eK9zW7XLUMe3lYPN7zp0vSkr58e3ORGfA7/JcvPDlsVjEjp+eZpIO0xpJkDnUb9p6Lt32pOACfGgD1+bN6fmmWtQj1Q6y8+OLZRy7KKUxNdhIJL41WyRu65V8330R9CveXMBI7/gYw6uIs+MYHGnQJ/51JRtzE7xvDnVdQKzJl2Mw48yZbm9BqkxauS67sBvvq21Nv1m7qkmV1y+BBr7/MneaRi5e9Uo86+/IWvRuLmI4xLiMA13oOH+/PZyq3UxNqh4xRoOj6tjmjgDFMERBrGn2lj6s1TB4ObyU3T3YCxAnS6eW7GkWHOfIPMsjjq+EUAjhD7Nq+tF+BfSJJB6eiXB5+bpBi3hMcelcHlXtdJO6WCG0eXJZ3QEX+M/VMIpxmCQ0SfJ0QSuBQEj0y/2fIgx6bd2euZ3dia226xae+LV1NxXJp+rQZkb5oSRXVJlZs9fLmmek+/muKDrRAjchMlRoq1+cYL6LCvZ8G/wzFzbkNLjQA8QbBRb0Y29LIzY7N0V3lkuALRKfbUG3Qnorx8R5imQLFxCR4vxoulEyNXy0OCh5aOIOh27ui7HvB9SZYWgzZBYFUagEjnEn4cbCEmyxPmvvqZHElpi/ftoNWdg7mSw1e97opljCgsIoaronF4eTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(346002)(39860400002)(36840700001)(40470700004)(46966006)(8936002)(36756003)(44832011)(82310400005)(36860700001)(82740400003)(26005)(478600001)(2906002)(5660300002)(47076005)(8676002)(70586007)(336012)(426003)(186003)(83380400001)(86362001)(4326008)(316002)(70206006)(2616005)(110136005)(54906003)(6666004)(40480700001)(81166007)(40460700003)(966005)(41300700001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 22:45:31.7743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5ab596-4abc-4f1c-da6c-08da7b2207fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

This V1 of patch series is to provide the platform driver to support the
Xilinx XDMA subsystem. The XDMA subsystem is used in conjunction with the
PCI Express IP block to provide high performance data transfer between host
memory and the card's DMA subsystem. It also provides up to 16 user
interrupt wires to user logic that generate interrupts to the host.

            +-------+       +-------+       +-----------+
   PCIe     |       |       |       |       |           |
   Tx/Rx    |       |       |       |  AXI  |           |
 <=======>  | PCIE  | <===> | XDMA  | <====>| User Logic|
            |       |       |       |       |           |
            +-------+       +-------+       +-----------+

The XDMA has been used for Xilinx Alveo PCIe devices.
And it is also integrated into Versal ACAP DMA and Bridge Subsystem.
    https://www.xilinx.com/products/boards-and-kits/alveo.html
    https://docs.xilinx.com/r/en-US/pg344-pcie-dma-versal/Introduction-to-the-DMA-and-Bridge-Subsystems

The device driver for any FPGA based PCIe device which leverages XDMA can
call the standard dmaengine APIs to discover and use the XDMA subsystem
without duplicating the XDMA driver code in its own driver.

Lizhi Hou (1):
  dmaengine: xilinx: xdma: add xilinx xdma driver

 MAINTAINERS                            |  10 +
 drivers/dma/Kconfig                    |  13 +
 drivers/dma/xilinx/Makefile            |   1 +
 drivers/dma/xilinx/xdma-regs.h         | 179 +++++
 drivers/dma/xilinx/xdma.c              | 952 +++++++++++++++++++++++++
 include/linux/platform_data/amd_xdma.h |  34 +
 6 files changed, 1189 insertions(+)
 create mode 100644 drivers/dma/xilinx/xdma-regs.h
 create mode 100644 drivers/dma/xilinx/xdma.c
 create mode 100644 include/linux/platform_data/amd_xdma.h

-- 
2.27.0

