Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB027D70A3
	for <lists+dmaengine@lfdr.de>; Wed, 25 Oct 2023 17:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344384AbjJYPS2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Oct 2023 11:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjJYPS1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Oct 2023 11:18:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AC4133;
        Wed, 25 Oct 2023 08:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZo4J9af3zc/11+XOvLIUGl5C0UqnUejZs9GdnPkFh7hZ3A4AufHw3Uca8o7obuzcdtfH7WAPxeK6pu2MFwMb++P2DjskhQTwCch7kyZVU9wQl/yXJa20bZW+1ym/yphz02h0KSHHx+Rz4ejGyRbHylDHa73qfTOSBTzkrv1tfsuv5sdDOYg+7/ZaC6Kd7AivU0Zm/NCH+vuwilH+wxPm/jwGFG+vs/cVAzffeSdOKAv0tyO6ExsIcTXz2CGPh2ORSLcaMY1USwCdYDwc4jMSKnMvEu3XT6CUQM3PWPlOTuRRLA6jwJ6QEDXi9bH/s9HwCVhxiGUWAIStWl5nNvvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWFsq7DMx6srxfPykFah4y29DQlLluPp+bVApg4fZhU=;
 b=B2jN/Iuc6ySmkF7a2B7vbgw9CKr2J103Ia+D8p8uPXKo6MB8z6e9xrp+BF+2xo2GQu5iZ5RI/77ef3g+PTGqcqSZ/iPOg1a5zdCXN6tCRy36tMUhtL2nMgUIOqnLzcY5LAbr7TeI8q+g30ASk8RND0AxM/r7JzdvxnelVqaHUdv7FkWoH/9gR6n5aeU5GCV35uqcnd6rhF+Q62bbEPtjuflPkqxIhdQwgXO3X+NB7zdHMRCHM8+gFNimYNBJYptG7NrHFYxF/LdNhaVkLHlkXeQZRIPfc15RruCuMBI1JQWfoK9jLdh6JKi+Zn/Z9gywKprd1t1R7sl3baKjF+8vmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWFsq7DMx6srxfPykFah4y29DQlLluPp+bVApg4fZhU=;
 b=azSQHb1iwt6A6h4ALXC7SVKmRbvK3lvDt5ns/vfqLokQZ1OGT678nL2YEapo8ugnGLNEy5pXK3rUmyEiOkxS4oFPxu9Er3C+/SVe/zfNqbZ7jWdA0k4ajXu03gx413SNUZ0L+pRpZTQXRhuxFNMvgDtFnQILZrYs6jUya1J0aV4=
Received: from SN6PR2101CA0003.namprd21.prod.outlook.com
 (2603:10b6:805:106::13) by SJ2PR12MB9138.namprd12.prod.outlook.com
 (2603:10b6:a03:565::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 15:18:21 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::21) by SN6PR2101CA0003.outlook.office365.com
 (2603:10b6:805:106::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.6 via Frontend
 Transport; Wed, 25 Oct 2023 15:18:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 15:18:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 25 Oct
 2023 10:18:21 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 25 Oct 2023 10:18:20 -0500
Message-ID: <e23d3897-4f4c-a21e-3166-1458c02af299@amd.com>
Date:   Wed, 25 Oct 2023 08:18:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V5 0/1] AMD QDMA driver
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nishad.saraf@amd.com>, <sonal.santan@amd.com>, <max.zhen@amd.com>
References: <1695402939-28924-1-git-send-email-lizhi.hou@amd.com>
 <ZRVd4yodNiwhqO9R@matsya>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <ZRVd4yodNiwhqO9R@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SJ2PR12MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 7618244b-dfc9-4642-5b54-08dbd56da014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /TmCxRRIi33pOdZuMIj+oVdaKVDFADOk6/JDzzA/5aeH96JTNywlKwtELfpNMrDuLjZxWtUasahn7d+mn+3IcJGwyaY42vbsMXLGUzuxfGCZj2nCe63LLxOo1b2GmqeJ30uNtbN0yhy9gRx25IVhWvMqACFVr1J3+SE0AZlpP3yF62BXM2S36XHHWBSIE28GfpX12CuVjaKkjxb8k6oqrFuNpesxjPwvEwJlVtq0/b/H+JFUuiLRKGKRKYP0jJ8py6gtpMaYZRACo+vWC41F7QwAUKCjdnAFcMjtPcR3jKlMnQkBpk2Ne3RM8Pf1zCHL5jW2vqlFhrhqerIcfjRGl10r4ZTUg8WA9RWv4i+/NUZPQvt0/67fYuLxQl3my3JzzbYP+uPgqJ+LZn2bacSpaqOgT6kNOSTCzkycvG9r72ExmO9fTeA1DQNB6FH/klwJUWVTMMRcOpfETyEq0hMCet2GAiIOUwQ4Lk4JGfv7QzUnorIXpdx87mx8HDhDbOaiAQlDUfQc9GiQTltafNsNhVuJaIRbnLH83+yi84AaySnOV9sZclR/7FsnAUhZ5N9prmm+yRffSGugom0218/MKSLOLUNFF4oErGpPbtmEKZm3H0w78xWDCPckEHj6u+yMyjl6fnmkgoltZwmblEymnqaELYl3a9swvMIkHj4EKA7X7WscPcWuQtgLc9uqN/SL8Gjt0uh1tpH7VDFu8hF6+f5VzjlqeBIT0CuN7q+XbCNOnNd4/tsCuCD+zbE211oGiqok1G/umbKGG4TkwCLcqajhrT875wlQw+0cjsvG6SWR4vfohFPyPypRkgs77zGZH/LOXtKysxWk9oDAMhIAAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(44832011)(41300700001)(40480700001)(53546011)(478600001)(2616005)(70586007)(70206006)(16576012)(36756003)(54906003)(316002)(6916009)(31696002)(966005)(86362001)(36860700001)(47076005)(426003)(336012)(26005)(82740400003)(356005)(81166007)(83380400001)(8676002)(8936002)(4326008)(5660300002)(31686004)(2906002)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 15:18:21.6428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7618244b-dfc9-4642-5b54-08dbd56da014
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Do you have more comments on this patch series? I have repined V7 patch 
set. Hopefully, that works better.

Thanks,

Lizhi

On 9/28/23 04:05, Vinod Koul wrote:
> On 22-09-23, 10:15, Lizhi Hou wrote:
>> Hello,
>>
>> The QDMA subsystem is used in conjunction with the PCI Express IP block
>> to provide high performance data transfer between host memory and the
>> card's DMA subsystem.
>>
>>              +-------+       +-------+       +-----------+
>>     PCIe     |       |       |       |       |           |
>>     Tx/Rx    |       |       |       |  AXI  |           |
>>   <=======>  | PCIE  | <===> | QDMA  | <====>| User Logic|
>>              |       |       |       |       |           |
>>              +-------+       +-------+       +-----------+
> This should be in patch description as well
>
>> Comparing to AMD/Xilinx XDMA subsystem,
>>      https://lore.kernel.org/lkml/Y+XeKt5yPr1nGGaq@matsya/
>> the QDMA subsystem is a queue based, configurable scatter-gather DMA
>> implementation which provides thousands of queues, support for multiple
>> physical/virtual functions with single-root I/O virtualization (SR-IOV),
>> and advanced interrupt support. In this mode the IP provides AXI4-MM and
>> AXI4-Stream user interfaces which may be configured on a per-queue basis.
>>
>> The QDMA has been used for Xilinx Alveo PCIe devices.
>>      https://www.xilinx.com/applications/data-center/v70.html
>>
>> This patch series is to provide the platform driver for AMD QDMA subsystem
>> to support AXI4-MM DMA transfers. More functions, such as AXI4-Stream
>> and SR-IOV, will be supported by future patches.
>>
>> The device driver for any FPGA based PCIe device which leverages QDMA can
>> call the standard dmaengine APIs to discover and use the QDMA subsystem
>> without duplicating the QDMA driver code in its own driver.
>>
>> Changes since v4:
>> - Convert to use platform driver callback .remove_new()
>>
>> Changes since v3:
>> - Minor changes in Kconfig description.
>>
>> Changes since v2:
>> - A minor change from code review comments.
>>
>> Changes since v1:
>> - Minor changes from code review comments.
>> - Fixed kernel robot warning.
>>
>> Nishad Saraf (1):
>>    dmaengine: amd: qdma: Add AMD QDMA driver
>>
>>   MAINTAINERS                            |    9 +
>>   drivers/dma/Kconfig                    |   13 +
>>   drivers/dma/Makefile                   |    1 +
>>   drivers/dma/amd/Makefile               |    8 +
>>   drivers/dma/amd/qdma-comm-regs.c       |   66 ++
>>   drivers/dma/amd/qdma.c                 | 1187 ++++++++++++++++++++++++
>>   drivers/dma/amd/qdma.h                 |  269 ++++++
>>   include/linux/platform_data/amd_qdma.h |   36 +
>>   8 files changed, 1589 insertions(+)
>>   create mode 100644 drivers/dma/amd/Makefile
>>   create mode 100644 drivers/dma/amd/qdma-comm-regs.c
>>   create mode 100644 drivers/dma/amd/qdma.c
>>   create mode 100644 drivers/dma/amd/qdma.h
>>   create mode 100644 include/linux/platform_data/amd_qdma.h
>>
>> -- 
>> 2.34.1
