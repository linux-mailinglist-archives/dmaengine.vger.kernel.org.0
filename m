Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153D2628637
	for <lists+dmaengine@lfdr.de>; Mon, 14 Nov 2022 17:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbiKNQz5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Nov 2022 11:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237901AbiKNQzn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Nov 2022 11:55:43 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFF725C50;
        Mon, 14 Nov 2022 08:55:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ejshg/VhXXweJzRLIq+UaV5Pl7UEp+9mRy7UCoJiWVgAdYT1/zISpbWuMtQXmGw5E4il+rTt7W6t9ssEV6uCMucYAx7Quymd/znjRi3W4/BURGZWlt6htKDnNZleFJWB0EX6kPb9e4KZktMsucCy4m+O1mb9Q1/hHT9OJCA3vMRlQGQFRhxBn+2WIikjkKXwqmjCF/PkOvaQ1MMNre+SRrQ0DQsWOBFFfMep1b1Iz68kUPwtKSs2DFkWsCqfBr760fmm3/BIXr7OX7DRfJoiE0wypjQLAhHbScpzBsfzzGBEcFTqFEulZUSpW9tYzw22Ssr7+z4iQMZU253dyVBoMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQn1D2iRfyxIfeL1jqAo4KONp3NH74WbAYDtb4b1hC0=;
 b=nFzjYTg0Tp/leEZIxUPaOcRn0c9d5KVSix/5wUMWIHvoCDDG8v1Lt381T6DmF5pnXf/CQcUPMU1Iqh+XFj2BZRSQiopo4gEzA88kXtjTm/eLAqGXjtLbMrXRaTnz5hvT5RZVrXL9p5d6Plvf4Se3ODZd8aj24LZNRP9IOmcBKxwUI5hFjGmUNT2PccNvVvWKIuPjib3JiPuP4jfnuLiuu4DxWjx7uNRH0wdrlR5UV0dR4yMZlPxGKQ95CdM/X7QDIpLZvKTNShzfkdaAQfiXoont0f4EAM1bBl/RJ/cbJPTIoZLh8GXgQoQweLXuqsBGT6MrZDoB/Z3LxNx3ERn1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQn1D2iRfyxIfeL1jqAo4KONp3NH74WbAYDtb4b1hC0=;
 b=R5M/jL0c3tLP+zim6D10aZ1HdffDNPyU9MaM5MT7FJX3ujT8OQLlzQMQtS/pYt2RWOaqmpsWJDz+ePXojSQ6wi997M0uotQMfFcpIPxC9fL4NxY27xMP1AdaFsr/3I50gvnKXqB+QTRWObpiUCcyfNLLQ/NqhFX8Dd0SQm6CAzU=
Received: from DM5PR08CA0031.namprd08.prod.outlook.com (2603:10b6:4:60::20) by
 DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Mon, 14 Nov 2022 16:55:38 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::5) by DM5PR08CA0031.outlook.office365.com
 (2603:10b6:4:60::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14 via Frontend
 Transport; Mon, 14 Nov 2022 16:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 16:55:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 14 Nov
 2022 10:55:38 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 14 Nov
 2022 10:55:38 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 14 Nov 2022 10:55:37 -0600
Message-ID: <4d4acb1f-f53a-2a1c-8172-3ea6edbd352f@amd.com>
Date:   Mon, 14 Nov 2022 08:55:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V9 XDMA 1/2] dmaengine: xilinx: xdma: Add xilinx xdma
 driver
Content-Language: en-US
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <trix@redhat.com>, <tumic@gpxsee.org>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>
References: <1666720638-33496-1-git-send-email-lizhi.hou@amd.com>
 <1666720638-33496-2-git-send-email-lizhi.hou@amd.com>
 <Y2Uidg/iuQdxwSaG@matsya> <73ab286c-f8c7-8c4b-0508-5df8dde8e305@amd.com>
 <Y2VSfjWZSWY0f2n4@matsya> <e1244ca1-18bd-d6c9-6101-9b20940fda72@amd.com>
 <Y2YOHx3RBJxdx9xz@matsya> <7600d6a0-79ab-143d-28c8-77320d7ba12c@amd.com>
In-Reply-To: <7600d6a0-79ab-143d-28c8-77320d7ba12c@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT054:EE_|DM4PR12MB5357:EE_
X-MS-Office365-Filtering-Correlation-Id: de8b0242-f28a-414d-7d4c-08dac6610ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8T+1hwXH+lm3YqanJ04ispWLtUgp+0mN1Vh3Fs1C5gUxZBg0i81gExcNYgkrsvVeafYmzLxeB9sAVNT+lkIOiqCsodVUeU8MTpVWoPNZvMq4kUnsvCuu19r0y4D2OHlFNXwbkGqoul6IihQsCyQtfrHtjXyOrsW5RNmTTKl4Da4OpA+sAGnS0C7W3SsDxp02xEYzrw3pmVdEYvzNw8xYUMKWaUeaXo3oGAM3s/Yjtud0EPp+iG4Q9zgOqfgxBz+S1JIulwMvAo95BH7f05MbrggO3BWhno6UH7SZ5po6RNM2LLYwcVIei6Y7uaO5Ia0IrKCf2C/yoZTmY8vyCe8Obgo8pIeqpBysS5R2yk0tKNBFbsYgVEyNJhOzJGXYsFrxNxmQxaaw/gPw/Qek483820OK4uV8DRX2HaUmiVeqIua7rzDzsas+XDlPJnNLp1uKsjB5TpedGB2d80CdbYRlTqBQ5VjZLK9Vik3SykaMj6gYas7b/ItPqMD8hFfhXjcNZRWY9pbTh+4Y1lmQXQfZfc8auGmEIYiZXLM7zRx481i9cwoLL/MOCfRmdXeri5V23dbhHj5O4xBktTlWn+hD7Zo2cudjxGOprCNiLDEFTKBmzkhz+PqYX6+BsbSBIzfPocF/FqKdSY2d145440ezuQ0ZL8juykc+X01BGK6PNn+cdg69SXr4NryttD2u6sKcsHc7ng346+N9wUDxF9g764qDDBtnZbQC/9uCtTv3pL/2VZC+XFNaDHeU4WbastQZqK2dJmSdUcFOz1EAL5bmr5XbIakJNSlyQmZ0qV6h3Y0WfD7z+sYO/eA46kNqX5XatWK7onSdo7tdmR0SBzCJCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(86362001)(36756003)(82310400005)(31696002)(40480700001)(40460700003)(4326008)(70206006)(41300700001)(2616005)(70586007)(8676002)(336012)(44832011)(426003)(5660300002)(186003)(478600001)(26005)(53546011)(6916009)(47076005)(82740400003)(316002)(16576012)(8936002)(356005)(81166007)(54906003)(83380400001)(2906002)(36860700001)(31686004)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 16:55:38.7188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de8b0242-f28a-414d-7d4c-08dac6610ec0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 11/8/22 09:55, Lizhi Hou wrote:
>
> On 11/5/22 00:17, Vinod Koul wrote:
>> On 04-11-22, 11:17, Lizhi Hou wrote:
>>> On 11/4/22 10:57, Vinod Koul wrote:
>>>> On 04-11-22, 09:57, Lizhi Hou wrote:
>>>>> On 11/4/22 07:32, Vinod Koul wrote:
>>>>>> On 25-10-22, 10:57, Lizhi Hou wrote:
>>>>>>> +static inline int xdma_write_reg(struct xdma_device *xdev, u32 
>>>>>>> base, u32 reg,
>>>>>>> +                 u32 val)
>>>>>>> +{
>>>>>>> +    return regmap_write(xdev->regmap, base + reg, val);
>>>>>>> +}
>>>>>> Do you really need one more level indirection?
>>>>> Do you mean using readl / writel instead of regmap_* here?
>>>> Nope, I refer to using regmap_write() intead of xdma_write_reg()
>>> Ok. As you mentioned below,
>>>
>>>     why not move err into xdma_write_reg(), rather than adding in each
>>>     helper!
>>>
>>> If I use regmap_write() directly, I will not be able to move err into
>>> xdma_write_reg(). Having a inline function might be useful to add debug
>>> code.  May I keep xdma_write_reg()?
>> Okay, either way if xdma_write_reg() is doing only regmap_write() then
>> no, if it has extra logic like logging on error etc then it makes sense
> Got it. Thanks. :)
>>
>>>>>>> +failed:
>>>>>>> +    xdma_free_desc(&sw_desc->vdesc);
>>>>>> who will free sw_desc here?
>>>>> sw_desc is freed by xdma_free_desc(). xdma_free_desc() is virt-dma 
>>>>> callback
>>>>> it converts struct virt_dma_desc pointer to driver sw_desc pointer 
>>>>> and free
>>>>> the whole thing.
>>>> IN case of error, you are returning NULL, so allocated descriptor 
>>>> leaks
>>> I meant the descriptor is freed inside xdma_free_desc() which is called
>>> before 'return NULL'.
>>>
>>> xdma_free_desc(struct virt_dma_desc *vdesc)
>>>
>>> {
>>>
>>>          sw_desc = to_xdma_desc(vdesc);
>>>
>>>          .....
>>>
>>>          kfree(sw_desc);
>>>
>>> }
>> ok
>>
>>>>>>> +#ifndef _PLATDATA_AMD_XDMA_H
>>>>>>> +#define _PLATDATA_AMD_XDMA_H
>>>>>>> +
>>>>>>> +#include <linux/dmaengine.h>
>>>>>>> +
>>>>>>> +/**
>>>>>>> + * struct xdma_chan_info - DMA channel information
>>>>>>> + *    This information is used to match channel when request 
>>>>>>> dma channel
>>>>>>> + * @dir: Channel transfer direction
>>>>>>> + */
>>>>>>> +struct xdma_chan_info {
>>>>>>> +    enum dma_transfer_direction dir;
>>>>>>> +};
>>>>>>> +
>>>>>>> +#define XDMA_FILTER_PARAM(chan_info)    ((void *)(chan_info))
>>>>>>> +
>>>>>>> +struct dma_slave_map;
>>>>>>> +
>>>>>>> +/**
>>>>>>> + * struct xdma_platdata - platform specific data for XDMA engine
>>>>>>> + * @max_dma_channels: Maximum dma channels in each direction
>>>>>>> + */
>>>>>>> +struct xdma_platdata {
>>>>>>> +    u32 max_dma_channels;
>>>>>>> +    u32 device_map_cnt;
>>>>>>> +    struct dma_slave_map *device_map;
>>>>>>> +};
>>>>>> why do you need this plat data
>>>>> max_dma_channels is used to specify the maximum dma channels will 
>>>>> be used.
>>>> What is the device mode, who creates this dma device, devicetree or
>>>> something else?
>>> This dma engine is on PCI device (exposed on PCI BAR). Thus, the pci 
>>> device
>>> driver creates this dma device.
>> So it is a platform_device type? Why not make it something like auxdev?
>
> With our FPGA device, the XDMA IP is populated by flattened device 
> tree. Using platform device will support both device tree and non-dt 
> case.

Hi Vinod,

I am going to send out V10 patches to address other comments. Please let 
me know if you have more comments on this.


Thanks,

Lizhi

>
>
> Thanks,
> Lizhi
>
>>
