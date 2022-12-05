Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7F7642E12
	for <lists+dmaengine@lfdr.de>; Mon,  5 Dec 2022 18:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiLERAp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Dec 2022 12:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiLERAo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Dec 2022 12:00:44 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC3ED2F1;
        Mon,  5 Dec 2022 09:00:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WY8a3EusDK4b/+P+buznkpO85HBjnC00IuycaiA0f9RyJFoDAT+WcPgXGiK+IvPQcNZxTlgxVO+WoMhWq6Gz6IvO67YFY/KHDuALcw4rryMfjREfvvfuX8G/sTX2tmraaprdKE9pHUgjeToGt1lu0SXxXIonFWxOferrvqJ5WmaOSskTeXzMe9mN97y023fMRWHf1zdj6PzFg+ara3Kshtx8AOxB3Oe+mLNWe/D1LjWxcqLRUhRx5rDA4SA4xkGxfLz8NzBmJIhJZnC1RoknkqCsbBhGUNK35+GWn1KGOllotdobiQZpPeY0qzy5Jl71ssJvloE+5aPd9WqJp4VGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQHbo2a1SwxYOEgtm2YM+lAqS6Fl7AYV7yra2x9EP+U=;
 b=Ry1+5+k8O93Lex6WLmjxKEpmROytIEQYKUQ39BLOXjQl92jcu9MFXqRz/82TBlhnKcmtsiVvJ96gzaB2vs+LRX2MhKsPpGOnHc76nfFJHzdr17UFqyQ5ZehwxgI7Tl+C+pPWtoK26NKbbntGVFqPlqWrEXa1V8zABPL+Ed4syi2co6rkNEgBjxYeKpkddb7ZAs1SfWhS5Ugfd1BeYDKAvm5MD/iLwuK8Z73mCHHO24/nyw28YuPJyHUIEF9vCnJhG2a2SSiT598ZGY2zZ4Xpix8BJAGNVU2QdXTdiXAZK+ouDmfHDLRyN5YwDxgiTImGmXOAK/eqGrAfYJFGFhZxaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQHbo2a1SwxYOEgtm2YM+lAqS6Fl7AYV7yra2x9EP+U=;
 b=MioDBjAgKSsT9qawA/YsJ5ngwykfyTxVZrRn0fN0a6fLvcDejeQ/ZwA7fvdjtxhgUo8scGgxFSJF97D8MwIyOeBqeFD7/Aiy+04svRHe8LBcQwhvGep6Ho/jOYM/DGoGgmK4cwVDFcXcqyhnJ9iF+H6SgnY8J8YFTBX9SNfuiIk=
Received: from BN9PR03CA0714.namprd03.prod.outlook.com (2603:10b6:408:ef::29)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 17:00:41 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::cc) by BN9PR03CA0714.outlook.office365.com
 (2603:10b6:408:ef::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Mon, 5 Dec 2022 17:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.14 via Frontend Transport; Mon, 5 Dec 2022 17:00:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 11:00:38 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 5 Dec 2022 11:00:37 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <tumic@gpxsee.org>
Subject: [RESEND PATCH V10 XDMA 0/2] xilinx XDMA driver
Date:   Mon, 5 Dec 2022 09:00:24 -0800
Message-ID: <1670259626-54430-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|MW3PR12MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b950467-67ed-4515-4b45-08dad6e23d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JcGikWjinlCYjBB2cfMY8upaLTjzv6iU/Z205Dxq5JgoutfDbYqQPFG+11v2lbtKu18u6EiNd8g80fRycLSdnASxUukbk4tWSid11tS1FedHV4I1jUF0GN+y29gc2EAu+y6KxPTDMJ03RewZ65zMQAscmDAymMSlUB4pbcHuwFADsxfwiDeVosUPTzO1/5IIbacDtbJuYEf8V1OXFTnNrp0WI8gCd/qsWOsT7GmU+5XbCmASc/YNGTprme8lrIAefj39VX2LsmxCRuGEkuHSWNF2ekdLXE8iymtq3B9zioaaQ3sHdOGZg9YCexWFhFnsdBqcS4mCK8OHXHAQyxW+zMcxY4uENDElQZG0AIDavhuDoQ+iRBcBIcLqFr7+D+qCB39HW12E4Av9up1RQaCY8rFMYBd2uSkMi2whE26R+dRHsDM09OVrUN8OwFB7w16wZ4cKbG6vwXUdjMJ0VzOniJtR9G9nosGg5A4gIkmTWBSLLJJTQpn0vZU+b8AA1S4RawsvVSgs0LQw9Vb22Kvn0xtMBKgRT3gmuXJxzwjKv2Ndp7J/RwStGAu3/Ybc1gy0o2OblPBK9W+jOdCGCoFYcGXwBr+jnuhvr/SLFMFH2y+cXNB8LLiL0DBmPjLdZoKRJZHI/sUOnyqYq0of36nQtGDoc6uVZ3EDteg67Hl05rotlOwH+KN1olN0hv91g7IkXWPOfPhvQErTIhrweFhErbYkurZoXM3dToPsEsl9UDtH3pnc1Yjw/987B1ZAKTerHQJJG7IYnMH48exlKYanG1CoVkZZQMawLmCXzNtW/UHLcDnSomPrRAwgEVwSoSUO
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(82740400003)(86362001)(81166007)(356005)(70586007)(4326008)(2906002)(8936002)(70206006)(8676002)(41300700001)(44832011)(83380400001)(36860700001)(478600001)(40460700003)(2616005)(110136005)(54906003)(316002)(966005)(5660300002)(40480700001)(82310400005)(336012)(186003)(6666004)(47076005)(426003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 17:00:40.6092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b950467-67ed-4515-4b45-08dad6e23d59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

This V10 of patch series is to provide the platform driver to support the
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

Changes since v9:
- Cleanup code based on review comments.

Changes since v8:
- Fixed test robot failure on s390.

Changes since v7:
- Used pci device pointer for dma_pool_create().

Changes since v6:
- Fixed descriptor filling bug.

Changes since v5:
- Modified user logic interrupt APIs to handle user logic IP which does not
  have its own register to enable/disable interrupt.
- Clean up code based on review comments.

Changes since v4:
- Modified user logic interrupt APIs.

Changes since v3:
- Added one patch to support user logic interrupt.

Changes since v2:
- Removed tasklet.
- Fixed regression bug introduced to V2.
- Test Robot warning.

Changes since v1:
- Moved filling hardware descriptor to xdma_prep_device_sg().
- Changed hardware descriptor enum to "struct xdma_hw_desc".
- Minor changes from code review comments.

Lizhi Hou (2):
  dmaengine: xilinx: xdma: Add xilinx xdma driver
  dmaengine: xilinx: xdma: Add user logic interrupt support

 MAINTAINERS                            |   11 +
 drivers/dma/Kconfig                    |   14 +
 drivers/dma/xilinx/Makefile            |    1 +
 drivers/dma/xilinx/xdma-regs.h         |  173 ++++
 drivers/dma/xilinx/xdma.c              | 1004 ++++++++++++++++++++++++
 include/linux/dma/amd_xdma.h           |   16 +
 include/linux/platform_data/amd_xdma.h |   34 +
 7 files changed, 1253 insertions(+)
 create mode 100644 drivers/dma/xilinx/xdma-regs.h
 create mode 100644 drivers/dma/xilinx/xdma.c
 create mode 100644 include/linux/dma/amd_xdma.h
 create mode 100644 include/linux/platform_data/amd_xdma.h

-- 
2.27.0

