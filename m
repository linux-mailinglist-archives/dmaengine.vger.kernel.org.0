Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D323A716C85
	for <lists+dmaengine@lfdr.de>; Tue, 30 May 2023 20:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjE3S3w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 May 2023 14:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjE3S3v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 May 2023 14:29:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793AEA7;
        Tue, 30 May 2023 11:29:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LU+Nrv/AoAs7VcDPcwKSFSdJmo4NB/nlaAWjVKWkDXXJ7uguYFKYSb+TnfLclore/Isqpt+1tvOtxD/FLA592L5LyoRxoB9rV7USz6FDLu10hmilPtfp3nuSur0w0tXoIv6lRIiiVRQTpuxGXA24ynfLM0NUqH3BOR28oo30tJg3u2AUjPNtSzcw8KRQ+1akRd19l4ubp5ImYyui6Y/bv/Yaz03pNnN4g53FISlyUT72Ft8RIl9WPjSKvbOxic0fs+zAc7lEavQH3mo1bxABqznPFNkRUmVHiiYfi+pnuju7H+j26nLB96IhGM6uQqE3I70cmkQ1fHkR9Ef2ifT0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5oD418VbRmlQAmUNtXtcptFbivtL+KqzqWHiwV1uis=;
 b=KAJoBJ64dwOmeSvOxOAjIgbd5mMkuoLCeZn4QJRi4Iv73ZIKYkiWVL2mXulUp+stNwRTCVt48Sx+ZbAiMhDc559/MxksPR0opg5pIV76xvNAFmbCBEix3VYW38BMzCcyxUj0og8E30bZPxQcmZhbA0P1+VXc3/7P1UpcgBntFGtToE3FTg5clbfsmPcpgidRFlzpB+6iUzY2mi+FyBFZaCTlr7i2t2q/ZFtXJrgduFbDN972mF8D2jVYu89C0ANobFBSHJRUfmazvWKsPNgF8kG2wDN3fa9JRXpTyYFzfT4ujfovjmqMCSTNQ7AQEItB/pTzFCRzLFqhYNx0r8s73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5oD418VbRmlQAmUNtXtcptFbivtL+KqzqWHiwV1uis=;
 b=mdvh9hEVlbgtknno/Jmc+LNXDKq9SykbO3r+83KpfN9MF5PW56dl9O5dIybojQy5lTMcReiQY1+bJxUJF09byGixhgUJ86gbDvlGi4zSSXxv6QyXXn2phDiOvOQD9gkW1tUEJLKAfe2ySvAQq6V10IJVglFIuSBHsJ553vRcCpc=
Received: from SJ0PR13CA0070.namprd13.prod.outlook.com (2603:10b6:a03:2c4::15)
 by IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 18:29:48 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::4c) by SJ0PR13CA0070.outlook.office365.com
 (2603:10b6:a03:2c4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.21 via Frontend
 Transport; Tue, 30 May 2023 18:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.18 via Frontend Transport; Tue, 30 May 2023 18:29:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 13:29:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 13:29:46 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 30 May 2023 13:29:45 -0500
Message-ID: <aa375470-6297-0a8f-c520-7c3481520990@amd.com>
Date:   Tue, 30 May 2023 11:29:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1 QDMA 1/1] dmaengine: amd: qdma: Add AMD QDMA driver
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Nishad Saraf <nishads@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <nishad.saraf@amd.com>
References: <1685119795-11729-1-git-send-email-lizhi.hou@amd.com>
 <1685119795-11729-2-git-send-email-lizhi.hou@amd.com>
 <41f58a00-1ab5-3eae-0e32-0f6e05282cf1@wanadoo.fr>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <41f58a00-1ab5-3eae-0e32-0f6e05282cf1@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|IA1PR12MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: ed43ebfe-f927-4390-7977-08db613bd8f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Me0MhcJuxhchop85UQRtGSXcA5deIt8+2XhQrknLkPpzaRqorVU/LZNKO19RQGcn5UUb9eLqudIDxZGFoc8b0MKhUIdfQzSIoQL5p922zmY134UMFEE6m5K5Lpdf+EWIvNJTn2It7Q4lMSGhs1IdwgPr4SrEwZZXVsw8OLzhXFqY/9RpXd4g7Mp+EiI25Tm3+P8aaqarMj3E41N0nvfcz9wgseyXKsktM9I41oNh/UTNdszkBh0jMZ8erQHh8Tn/XAH/ztHjLFZlXH9f/DLCFGUkqvMX/EWGDPC9pq4Ip9LO9WxnJMwiCRE5D+G1DchCMY9e+/CzaWYmsUlZIjUB2TNJldfTiNoiUXaM4I1p83ReFYiDr3BTUP6cumB34YgrNBmhTtEOLutlcJkki9b6ijZdi04MdFg+YNAX1S9YYUORUMfAD0XG/MrtIki9xYKrZqRobB1VC618gCbZHv08v4N7P3lFsvNt5mWVJ1YtfEG+96R6vV+EO1aqP+x3rWIkQrxOwBSmhHy0ATzBwaGpfP+7hk5M324bCc0vJ9w5FUJo1DRLerO6ukYSFXXlBkPGoG0DsVgpoe5hi0Z2P+5rMRfw0vgw8fPzXfAo9HoMcps7s9Ocuy5evsg+siMiDYovVoTyLaT+w2HeEzhWhKc25C+UEAts0wIeYVo43E4puZ2k2omdg/92iffXhUHl8X4CYqbPyH119T3K3JlV+R26+NCLTPFyHSWql6IHDWPs5yqBCndXCmUjCWQIsifoBLLhjdoYP9NwX6PZQns8hiy3uwzEY7a97yuYVfXKOoh9IwNTEWDAtRhWvLM5owZaV4QCcWq66wHoYhmyxwDUpuFt3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(186003)(26005)(53546011)(316002)(2906002)(36756003)(40480700001)(40460700003)(5660300002)(41300700001)(966005)(8676002)(44832011)(8936002)(478600001)(82740400003)(81166007)(356005)(36860700001)(31686004)(336012)(54906003)(110136005)(16576012)(426003)(4326008)(31696002)(82310400005)(86362001)(66574015)(47076005)(70586007)(2616005)(83380400001)(70206006)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 18:29:47.2450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed43ebfe-f927-4390-7977-08db613bd8f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 5/27/23 06:33, Christophe JAILLET wrote:
> Le 26/05/2023 à 18:49, Lizhi Hou a écrit :
>> From: Nishad Saraf <nishads@amd.com>
>>
>> Adds driver to enable PCIe board which uses AMD QDMA (the Queue-based
>> Direct Memory Access) subsystem. For example, Xilinx Alveo V70 AI
>> Accelerator devices.
>>      https://www.xilinx.com/applications/data-center/v70.html
>>
>> The primary mechanism to transfer data using the QDMA is for the QDMA
>> engine to operate on instructions (descriptors) provided by the host
>> operating system. Using the descriptors, the QDMA can move data in both
>> the Host to Card (H2C) direction, or the Card to Host (C2H) direction.
>> The QDMA provides a per-queue basis option whether DMA traffic goes
>> to an AXI4 memory map (MM) interface or to an AXI4-Stream interface.
>>
>> The hardware detail is provided by
>>      https://docs.xilinx.com/r/en-US/pg302-qdma
>>
>> Implements dmaengine APIs to support MM DMA transfers.
>> - probe the available DMA channels
>> - use dma_slave_map for channel lookup
>> - use virtual channel to manage dmaengine tx descriptors
>> - implement device_prep_slave_sg callback to handle host scatter gather
>>    list
>> - implement descriptor metadata operations to set device address for DMA
>>    transfer
>>
>> Signed-off-by: Nishad Saraf <nishads@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>
> [...]
>
>> +/**
>> + * qdma_alloc_queue_resources() - Allocate queue resources
>> + * @chan: DMA channel
>> + */
>> +static int qdma_alloc_queue_resources(struct dma_chan *chan)
>> +{
>> +    struct qdma_queue *queue = to_qdma_queue(chan);
>> +    struct qdma_device *qdev = queue->qdev;
>> +    struct qdma_ctxt_sw_desc desc;
>> +    size_t size;
>> +    int ret;
>> +
>> +    ret = qdma_clear_queue_context(queue);
>> +    if (ret)
>> +        return ret;
>> +
>> +    size = queue->ring_size * QDMA_MM_DESC_SIZE;
>> +    queue->desc_base = dma_alloc_coherent(qdev->dma_dev.dev, size,
>> +                          &queue->dma_desc_base,
>> +                          GFP_KERNEL | __GFP_ZERO);
>
> Nit: Useless (but harmless).
> AFAIK, dma_alloc_coherent() always returned some zeroed memory.
> (should you remove the __GFP_ZERO, there is another usage below)
Sure. I will remove __GFP_ZERO.
>
>> +    if (!queue->desc_base) {
>> +        qdma_err(qdev, "Failed to allocate descriptor ring");
>> +        return -ENOMEM;
>> +    }
>> +
>
> [...]
>
>> +/**
>> + * struct qdma_platdata - Platform specific data for QDMA engine
>> + * @max_mm_channels: Maximum number of MM DMA channels in each 
>> direction
>> + * @device_map: DMA slave map
>> + * @irq_index: The index of first IRQ
>> + */
>> +struct qdma_platdata {
>> +    u32            max_mm_channels;
>> +    struct dma_slave_map    *device_map;
>> +    u32            irq_index;
>> +};
>
> Noob question: this struct is only retrieved from dev_get_platdata(), 
> but there is no dev_set_platdata().
> How the link is done? How this structure is filled?

The platdata is generated with platform device. For example, a PCI 
driver may do

     struct qdma_platdata data = { .... }

     platform_device_register_resndata(.., &data, ...)


>
>
> Should it mater, keeping the 2 u32 one after the other, would avoid a 
> hole.

Sure. I will fix this.


Thanks,

Lizhi

>
> CJ
>
>> +
>> +#endif /* _PLATDATA_AMD_QDMA_H */
>
