Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFD87B846D
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 18:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjJDQDS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 12:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbjJDQDS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 12:03:18 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27892C0;
        Wed,  4 Oct 2023 09:03:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBdmRxl8nem9U4HulZ4eMAy4Bg3lNrUQp3jKIhWh4jMaLv8ix9A8T0njhnndA6e5YktOlpFQ0EvcSIYqY4s2CxXBobGRx8crg1gfHhxRMAWRaXYkXyV4QUhyHKpzTmux/V9FPa5m4nLxp/jkMpJD5zoFYBfGBUlg3rJ9U3ewgBouARAZVG1T/Ef4iD+QnW4N6Mee2v4hqULYa9K5kDWk29CmVoQcMSh4AV7oxF7yrKrGqLnxWNYxNzK1Mt6v7XEtmTdR9ar3lJ61XZrolMSApLEpIsjr5gNtR9WzLkXYlcG1j+eq9YLHSM6PtyimuiiO2iN0Wvpu8POcXp7kFEQuBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRcFNA7NMBQqsj/6yWOtDY1G0Llo5tLVX4qXrYsxdyI=;
 b=Xf/rgKPvwsoZug4h/SVOF8t6eo23m0rIDpAYZ66vttrqP9wnfrD1ueYce3Jv2vFRHFIIAs5AcUHuDe5vQuU2Lsj0Sfvh4d5rz0rfruKKNlX9RzXO7xxsL9djmkYUNUeJh5YkscnzbYwSkHQ8B1pYUudVbmLzTDazpcROd6grw/eczKFuet8XkWr/hOhEfJNqj8SmtGwuTQpWv+e6PHmNL7Ya+opfySFBJ1wqL8GLtR3kEoK/71yoBH2/IuagUKQNKrvwUvqbt496lEs7RPY2BuWWbzm5aPiQu0LikquHOuhcsxdIExcL/yny1cEKUWsjVpEdTCsAIwsjU+L/4FMvtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRcFNA7NMBQqsj/6yWOtDY1G0Llo5tLVX4qXrYsxdyI=;
 b=I4u8XJ3JkhyxawGya0XVnttgowge4azqT49znzm3LxLuPv4BSWGwj1bNGZtZ6Khnwb6cVqJgHARwBqKsnrcnpWgI0uo+ZF5FQb36O21vlkkmo60aIT5n0RoDlPIWUrOvuWY8UY0+EcVv3/uJAylCcDu4I3PZdNzTLvG4Sqoe5vE=
Received: from BL0PR0102CA0032.prod.exchangelabs.com (2603:10b6:207:18::45) by
 IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 16:03:10 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::da) by BL0PR0102CA0032.outlook.office365.com
 (2603:10b6:207:18::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Wed, 4 Oct 2023 16:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 16:03:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 11:03:09 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 11:03:08 -0500
Message-ID: <299a9a54-89c4-75d6-67d4-3aebfc6fd414@amd.com>
Date:   Wed, 4 Oct 2023 09:03:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V6 1/1] dmaengine: amd: qdma: Add AMD QDMA driver
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Nishad Saraf <nishads@amd.com>, <nishad.saraf@amd.com>,
        <sonal.santan@amd.com>, <max.zhen@amd.com>
References: <1696008263-42937-1-git-send-email-lizhi.hou@amd.com>
 <1696008263-42937-2-git-send-email-lizhi.hou@amd.com>
 <0750d8b2-b624-3293-23ac-a034c88d8e0e@wanadoo.fr>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <0750d8b2-b624-3293-23ac-a034c88d8e0e@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2614cc-3874-4831-a42e-08dbc4f367df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SAbiODpO7IgoE+5Zi5sDK89m1BqcSqoQ1ddQP3meQ99OJGxqwovAK6H/xvzbE1hopgeXYwHv9QH8kunNc81QvCZm/5OT6HLzq+sVobhOW21lhv0YzaYv450IUAI/PRUsS24ap5ZJmTs0BsLS/caNRWteTrTDq7Y8/9/piFvwi+hLbc4eOS+LPS4/LnozI1JPX3j4MEjFdXt0rzzygq/fKLHnwvJdeYRkHuX/3ncqYGDiIzyNlsPqwkhZVJt7tw6QU3irvbUjEqdowDTsLJxFVEWJZhhg9s9bWAqr+wmlApO8KoPilhdeymhe1rYHZrJdVPzFZbBZ5sOvZ1oXuS/XKmK97i5lF+TG1LULON1gSpDnaleAgzTchmi9aaM/iRQhKICPyLGnOD2uCGOjOtemxEMaLjY7FBuQX4wTvgPQny/Rrzur5K/jUstgZPkWLHjMVb9i9GnJJ2+WRod5bkotbuG9Q+tqC5N1q9il0CmXZeMRqXJN93rekZgN2YKDB+69qgk2brNzGGO3KQxAUu5AZ2XEXlSOkszrgddITRJIxy6DMZjWH5YRDtPYhuD2RG3BsLtE7FisAcJu1b2qKS3EwBHvki8ldwSe4i5MibB+bYh/7yAbHozFG0DaN4pirctE1wGtbLl/kSjnWYpVBR/1/LV1vvyNuhNSodHSirMyRgnnD/b0Xk87Djg7r8az24lcYkFRew8voNtKkoa4C5TUWZc3R0vdy1DcQuPTlIJFVjr9wttowcqKHolOtqzxligBGYpETVjU6xlJ5wLCghcTqmJVCNFy2n281rLWzfMdfp8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(31686004)(40480700001)(53546011)(478600001)(966005)(6666004)(82740400003)(36860700001)(356005)(31696002)(86362001)(81166007)(110136005)(2906002)(4326008)(47076005)(16576012)(2616005)(66574015)(426003)(336012)(26005)(83380400001)(36756003)(70206006)(70586007)(44832011)(41300700001)(8936002)(54906003)(5660300002)(316002)(8676002)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 16:03:10.1551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2614cc-3874-4831-a42e-08dbc4f367df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 9/29/23 13:35, Christophe JAILLET wrote:
> Le 29/09/2023 à 19:24, Lizhi Hou a écrit :
>> From: Nishad Saraf <nishads@amd.com>
>>
>> Adds driver to enable PCIe board which uses AMD QDMA (the Queue-based
>> Direct Memory Access) subsystem. For example, Xilinx Alveo V70 AI
>> Accelerator devices.
>>      https://www.xilinx.com/applications/data-center/v70.html
>>
>> The QDMA subsystem is used in conjunction with the PCI Express IP block
>> to provide high performance data transfer between host memory and the
>> card's DMA subsystem.
>>
>
> ...
>
>> +static int amd_qdma_probe(struct platform_device *pdev)
>> +{
>> +    struct qdma_platdata *pdata = dev_get_platdata(&pdev->dev);
>> +    struct qdma_device *qdev;
>> +    struct resource *res;
>> +    void __iomem *regs;
>> +    int ret;
>> +
>> +    qdev = devm_kzalloc(&pdev->dev, sizeof(*qdev), GFP_KERNEL);
>> +    if (!qdev)
>> +        return -ENOMEM;
>> +
>> +    platform_set_drvdata(pdev, qdev);
>> +    qdev->pdev = pdev;
>> +    mutex_init(&qdev->ctxt_lock);
>
> If this was done later, it could simplify some error handling below.

This lock is used for sending indirect commands. And the probe function 
needs to send indirect commands as well. Thus, the lock init can not be 
moved to the end of the function to simplify error handling.

>
>> +
>> +    res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>> +    if (!res) {
>> +        qdma_err(qdev, "Failed to get IRQ resource");
>> +        ret = -ENODEV;
>> +        goto failed;
>> +    }
>> +    qdev->err_irq_idx = pdata->irq_index;
>> +    qdev->queue_irq_start = res->start + 1;
>> +    qdev->queue_irq_num = res->end - res->start;
>> +
>> +    regs = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
>> +    if (IS_ERR(regs)) {
>> +        ret = PTR_ERR(regs);
>> +        qdma_err(qdev, "Failed to map IO resource, err %d", ret);
>> +        goto failed;
>> +    }
>> +
>> +    qdev->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
>> +                         &qdma_regmap_config);
>> +    if (IS_ERR(qdev->regmap)) {
>> +        ret = PTR_ERR(qdev->regmap);
>> +        qdma_err(qdev, "Regmap init failed, err %d", ret);
>> +        goto failed;
>> +    }
>> +
>> +    ret = qdma_device_verify(qdev);
>> +    if (ret)
>> +        goto failed;
>> +
>> +    ret = qdma_get_hw_info(qdev);
>> +    if (ret)
>> +        goto failed;
>> +
>> +    INIT_LIST_HEAD(&qdev->dma_dev.channels);
>> +
>> +    ret = qdma_device_setup(qdev);
>> +    if (ret)
>> +        goto failed;
>> +
>> +    ret = qdma_intr_init(qdev);
>> +    if (ret) {
>> +        qdma_err(qdev, "Failed to initialize IRQs %d", ret);
>> +        return ret;
>
> Should it be "goto failed"?
Yes. Will fix it.
>
>> +    }
>> +    qdev->status |= QDMA_DEV_STATUS_INTR_INIT;
>> +
>> +    dma_cap_set(DMA_SLAVE, qdev->dma_dev.cap_mask);
>> +    dma_cap_set(DMA_PRIVATE, qdev->dma_dev.cap_mask);
>
> ...
>
>> +struct qdma_device {
>> +    struct platform_device        *pdev;
>> +    struct dma_device        dma_dev;
>> +    struct regmap            *regmap;
>> +    struct mutex            ctxt_lock; /* protect ctxt registers */
>> +    const struct qdma_reg_field    *rfields;
>> +    const struct qdma_reg        *roffs;
>> +    struct qdma_queue        *h2c_queues;
>> +    struct qdma_queue        *c2h_queues;
>> +    struct qdma_intr_ring        *qintr_rings;
>> +    u32                qintr_ring_num;
>> +    u32                qintr_ring_idx;
>> +    u32                chan_num;
>> +    u32                queue_irq_start;
>> +    u32                queue_irq_num;
>> +    u32                err_irq_idx;
>> +    u32                fid;
>> +    u32                status;
>
> Using such a mechanism with this 'status' in the probe and 
> amd_qdma_remove(), apparently only to simplify the error handling of 
> the probe looks really unusual to me.

Ok. I will remove 'status' and add more 'goto' labels to do error handling.


Thanks,

Lizhi

>
> CJ
>
>> +};
>
> ...
>
