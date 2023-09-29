Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46597B36BB
	for <lists+dmaengine@lfdr.de>; Fri, 29 Sep 2023 17:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbjI2PY7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Sep 2023 11:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbjI2PY6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Sep 2023 11:24:58 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E09F7;
        Fri, 29 Sep 2023 08:24:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MX9iVYiwo9Y6EKwO+OM0gqxmNuv3xcZB19ZNf9bxoSl7SDa6+xEAIefY67dTopy6pY06V4DvAXDIVg/3geCp7nXfN88o18bBgjaxp811w9NiOO2iGiaZd/cdyaJPW6ZJVzpBDVZR12SIkNlcUCZsaN3oIazwMPljDsqBAxS7sxi18R4cAq4tXjbHr6SMkw7iEWUNzB1VemzPWVPLAN3bMA1QUs/TGqIKiTftFRXHSoxflDD4BqL+VY/JwovZIlh3cgqla0Il93kYtksvOCUr35idkud4FNhftm4+iKSAOJbwA9RePqNK7k8gUoJ4cZ2mgE+I8cwEsPGs7b9HE5eYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxKOqgoYX+l07AbQ7me0Tz0PO/aWIQICOogrrgut+BU=;
 b=iefMBdppRVhcw0pxyCvtsDYE672wLeBm+OPPdLWByjF6ghISrLtpTCOC/REoI0mX4bBG8MUrqXB+Egu5uT4hkJ/riCjtHhHnHK2zIVFDduhMhqDA0D941D71RWIsLdXX1OjDGkGFxskRAt92ZBcCotPcz/zSL5mCDHxCQR2j9wWpjiTP2Mj+VYKm1pEVOjTG6lqKU21dpbcXqaDkeFiyMR6R3NJsTltlnjk0zWMCgjcfAWM24jUSlEXZIX6ZVudk55u0kMDHmyEumoxjjkOBfV9fC7e4BonY0iPDpS4lkei8MJjRebk4vmO6866kh/Kg6p864ixG1fIoGCcNZx1jHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxKOqgoYX+l07AbQ7me0Tz0PO/aWIQICOogrrgut+BU=;
 b=KluEeZ8g95yfk9syyMsKKSm6YZ+m1RP8lg+ugPkpA7C608l3+k0seqsRUIBkD5duVJBrVBmTEZovCJdt2J9KPAhAaijI0K2isAABq/biJTxKcYXexTyR+8Vg8MrYmCdnaUYz/sOv8ajGs4d+qBdLQxVtT9vpPp8PpDwjCv5OCHY=
Received: from SN4PR0501CA0105.namprd05.prod.outlook.com
 (2603:10b6:803:42::22) by SA1PR12MB7441.namprd12.prod.outlook.com
 (2603:10b6:806:2b9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Fri, 29 Sep
 2023 15:24:54 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:803:42:cafe::82) by SN4PR0501CA0105.outlook.office365.com
 (2603:10b6:803:42::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.15 via Frontend
 Transport; Fri, 29 Sep 2023 15:24:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 15:24:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 10:24:52 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 29 Sep 2023 10:24:52 -0500
Message-ID: <3641d9be-140d-ab19-aec7-6c38d7d5d144@amd.com>
Date:   Fri, 29 Sep 2023 08:24:47 -0700
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SA1PR12MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2ff20e-c347-480c-125e-08dbc1003b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k736WsbFA2rrSU4F1HUw7Nxq0Jji+dACRPW8IY9vPQ3NGyRVsHZykL350qthqolyeYviZ5vO3VIVORyoGfQ7OBbYjeZ4Jtuxt3fA4J7wuOVBv4srxiuq2EWzjrPaOSI7eNijmizx+ftBwXHRBHrBQ7MXeWqEFNeJgkasw0DvuA9vlP565nr9DnRi26j2emvDMgIQjR4ci1N0oiOpHt29bceNbOfv1HbkMXv/JdsHhH6Pzfjlyox7aMxwrE9jtNoBYFuvPhX0hXF57day2kNhLo3nAYd7ewCFQGGz3kxXNFxDzariXCuXnc1Z9n5YKyqQ1OLbLvHfjjC45zuajfWkfqFKYSpa6WG/vprrJZZW35t+U3LZiQK3R6ZpOLuKVsPxM9NbDFxofF3RBg0JX+8qRNrGiTMPftVeHS/xo7c5TgEmUhO0Vn6zaNgRMvb3FJ+VP3BuE0GOafxa5OSCA7SisG/vdpaLGLPUiWDsVtjRQuFviD7mzJS5bV59C/x8FenrI8Llsikf5V8l/8WVs64SyL5eVJ5MvTs+wXU1+WgLEKNVRZCARM+vXc1+ZZBV3c4fFULxUFzO8LphqIuWm9+oF+X918uNI/fpP8Jkvf5svJO+pfk6gkCqBGqQW3znsitbTOXn84RJls7WUYunAphu/XrEq07N6oVb9icwsNXviyqdQV7l2FGK9iEfNtk5p+mAbXBEGZ2oqsSz52akgg/WHIw/FaPMB1h14aUQNvyANthsg4whtfVdWSBkQwo8qxjSt7BFjLNH0YqFgBoHgGUj+uEVmif6LueKBiA5xVNBc9t7QIoz5yEiwNO7cO3iv5k28T3ZzRe1ihQvttzfNgV7uA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(356005)(81166007)(83380400001)(82740400003)(2616005)(8676002)(26005)(426003)(336012)(4326008)(36860700001)(36756003)(40460700003)(31696002)(2906002)(47076005)(44832011)(86362001)(966005)(478600001)(316002)(5660300002)(6916009)(70206006)(53546011)(6666004)(8936002)(16576012)(54906003)(31686004)(70586007)(41300700001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 15:24:53.9336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2ff20e-c347-480c-125e-08dbc1003b2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


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

Sure. I will add this.


Thanks,

Lizhi

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
