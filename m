Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBF559F2C0
	for <lists+dmaengine@lfdr.de>; Wed, 24 Aug 2022 06:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbiHXEmR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 00:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbiHXEmQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 00:42:16 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E0F857C4;
        Tue, 23 Aug 2022 21:42:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ro25eg4LBpbsKMVMvdFiLuMa5UmA/Xs4vCCf50aP1TQfbEHeTA6QOVbk9eKVzb88q4ZSFG1eAp4Uoh7/U1BA4U5P9JVVUYpFZ7aGqNZg4cMmoQRzH0+f6HwwKrouPHqyXej1XvLegB3eQ18WF6TC0r3EWkBqw/oDno2eAVtpK0+RX7o/wIHAa4ucMXfrj+uFVbO3m1yiTmycS7ZUmU10Ts3jPHzEZHzbtbz4K8AmKDBIhXV2wd/CfFno+Y7MiP++iawMvg9I6UET/l/RO2qlM6/jbn3uMC7a0kfgWsgTF4Nj3gJi8Y/cmx4xTrTP7p+hOo/NdrZQazuZM9oLl49/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFov2yx6nItWw5YfDXMRBRdUbj/y7bDLTOanWkYZoy8=;
 b=dWMV2JyvCMNW2XCIcY62bS+fgAHQAGb9+ran1mtXdJJH4mwdTC1nXcE60rJuWG+NtC76T5gOgCRgFkJq6u5IhJ3P1YxFD3ysII9O7lThiSZxfzPNmLnKISht3PKz8k9Cefd4DhevV8qCJRVzJCKLUfeJluE4hc7lFYh80s8K5fVYAyzoStGd7H4cPY1Ia7/4C/XbTk6MlzHGz+F4+N02iyLYrjxpt3x1xQKiCNY9FtbgfO+nPEY7J/siuNrirqlWe8dr2A11VN88GT6IQjy0eVzflfpjYDRwcGZd7it7I+8BW03cqyUjC6X8WeifgnrvhFToto9H7ulHYjfH8FLmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFov2yx6nItWw5YfDXMRBRdUbj/y7bDLTOanWkYZoy8=;
 b=aFicr0Xvvuf7guKlGRKsmcZxbUeZbeDTQyamavSWE1H98gNZb8tTAMIXKoP0G78kZZ0efrlAkSu5Zi8HXUiRPhUsxRE+QuAaPOPbuR8RJo9TcCo2R0BtXBee1ug0mOcXO/yZliwD0BTqFF2xMvTiYon/uRNBj5yz2z0j1D8sjO4=
Received: from MW4PR03CA0088.namprd03.prod.outlook.com (2603:10b6:303:b6::33)
 by CY4PR12MB1509.namprd12.prod.outlook.com (2603:10b6:910:8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Wed, 24 Aug
 2022 04:42:12 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::29) by MW4PR03CA0088.outlook.office365.com
 (2603:10b6:303:b6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Wed, 24 Aug 2022 04:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 04:42:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 23 Aug
 2022 23:42:11 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 23 Aug 2022 23:42:10 -0500
Message-ID: <3fad221a-69f6-f30f-36f4-f4f54653a5d4@amd.com>
Date:   Tue, 23 Aug 2022 21:42:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH V1 XDMA 0/1] xilinx XDMA driver
Content-Language: en-US
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <trix@redhat.com>
References: <1660171522-64983-1-git-send-email-lizhi.hou@amd.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <1660171522-64983-1-git-send-email-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca8625f3-b91e-4e52-6c2a-08da858b02e9
X-MS-TrafficTypeDiagnostic: CY4PR12MB1509:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16akEDW5yBYLb9O8dSQTHeG6aoR7mxgJs185cjA2f1XcWcDFiE2spCH0yVl/Mhq7pIS5gzbaCVUW9c//l8XRvr9MGsawQ2LrJkEY517OydiRfY2V+QHz4zOtqjoEqG5CwrWGkEUMy+eJNrbpY0u/2uBryCt1AHBRDnyoiRBhQggV9w32GLaSlXxdUYeciqzLEWGLY0dy98BK5PJjKRGTexfZ7+856bSXuZ8klIZ4Be25OQGxsjABpKJyzi/eAJlYKmn+rnbf4gcMlj1cyrkZRN8hai7TthgXAKH3T0s++eceSCcEw6En+vsgCRD/46l5GDrzoCHsn6vOOTcgW3PE/781QWpbhHEC1wIKryTrEX11BxCtEzVxUoX8FXtXcRG/rFP1ia5AmV830KnurkMhHYUYoo/Rj0xWXelpjxMT5J4U4pMuzR4q4J1ikQqxaUvlyKXwc5f5uUy9oZTWcJfeTOGBedLIYfS0q5tTHfjbZK24RQWMNOppSIpWkQOAXzIb2ymQq+mXENJlqv7m/Ml473FrJ6klDqNIvVNSp7Yq2D+nUrIIJrcYMxjI90EAjfQ3SpS24lqp5sobXwsgUXn/nuZ5Upa9LAkN63FWzRcpdXyijIjCjVVhvps+ZkOyB5rYix64/4GJu5W8zKcg+21IfTRoG5RcF9IhTYWGqOJ5O0k6AkSsHGeMmrXjLymHtOy74jl5SRdKkykzVxSJxNE2REU0qF8Q6316y0eQsWggKPmRpDa8vczBNAJ2BfKhcIHkVYL2bTTaL5ANZluhidQhn2wTG+8Xy89pZpDhj6HjgSfOrJSX/NHxY7Akyx3oy6Zv57itdvj06ZNLb4vV/EwKvsDNX++OG7hn6ImyVY86qjweCtKPJBwEJ3e3pxTxwi6HCw5O0qJ7m5uZO/l921W56A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(36840700001)(46966006)(40470700004)(54906003)(5660300002)(82740400003)(356005)(81166007)(31696002)(86362001)(36860700001)(336012)(2616005)(8936002)(47076005)(186003)(4326008)(83380400001)(40460700003)(8676002)(82310400005)(70586007)(70206006)(31686004)(2906002)(40480700001)(426003)(44832011)(36756003)(316002)(478600001)(26005)(53546011)(966005)(110136005)(16576012)(41300700001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 04:42:12.0271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8625f3-b91e-4e52-6c2a-08da858b02e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1509
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,


Just a kind reminder and we are looking forward your review and comment.


Thanks,

Lizhi

On 8/10/22 15:45, Lizhi Hou wrote:
> Hello,
>
> This V1 of patch series is to provide the platform driver to support the
> Xilinx XDMA subsystem. The XDMA subsystem is used in conjunction with the
> PCI Express IP block to provide high performance data transfer between host
> memory and the card's DMA subsystem. It also provides up to 16 user
> interrupt wires to user logic that generate interrupts to the host.
>
>              +-------+       +-------+       +-----------+
>     PCIe     |       |       |       |       |           |
>     Tx/Rx    |       |       |       |  AXI  |           |
>   <=======>  | PCIE  | <===> | XDMA  | <====>| User Logic|
>              |       |       |       |       |           |
>              +-------+       +-------+       +-----------+
>
> The XDMA has been used for Xilinx Alveo PCIe devices.
> And it is also integrated into Versal ACAP DMA and Bridge Subsystem.
>      https://www.xilinx.com/products/boards-and-kits/alveo.html
>      https://docs.xilinx.com/r/en-US/pg344-pcie-dma-versal/Introduction-to-the-DMA-and-Bridge-Subsystems
>
> The device driver for any FPGA based PCIe device which leverages XDMA can
> call the standard dmaengine APIs to discover and use the XDMA subsystem
> without duplicating the XDMA driver code in its own driver.
>
> Lizhi Hou (1):
>    dmaengine: xilinx: xdma: add xilinx xdma driver
>
>   MAINTAINERS                            |  10 +
>   drivers/dma/Kconfig                    |  13 +
>   drivers/dma/xilinx/Makefile            |   1 +
>   drivers/dma/xilinx/xdma-regs.h         | 179 +++++
>   drivers/dma/xilinx/xdma.c              | 952 +++++++++++++++++++++++++
>   include/linux/platform_data/amd_xdma.h |  34 +
>   6 files changed, 1189 insertions(+)
>   create mode 100644 drivers/dma/xilinx/xdma-regs.h
>   create mode 100644 drivers/dma/xilinx/xdma.c
>   create mode 100644 include/linux/platform_data/amd_xdma.h
>
