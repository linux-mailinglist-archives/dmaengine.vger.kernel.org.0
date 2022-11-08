Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781A7621B3F
	for <lists+dmaengine@lfdr.de>; Tue,  8 Nov 2022 18:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbiKHRzy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Nov 2022 12:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiKHRzx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Nov 2022 12:55:53 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36DA15FFE;
        Tue,  8 Nov 2022 09:55:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1y85KsJN+I60opHmuqCRk8t6CqASL8yWZxsHp2JIUfMOxxBcugVX29EYLbvmRlwGYyPZVCthovgYV36mDv2oyXGsUz+ofLOj8XAtba3Ldn3dsSGuIjzVzd+40cD0IgRLgVB5yOjbQVms0g1FikNCJx7/HYrw6ukG6flFrXM4IvHYOypap/DHp6efvLBgdEPcJEdjEExSaZrE3X/y89cxXfdXamailGC1SrhW70QzJypCSsrugRMqYbcexGWJ/SkSdh4+Ztd/aJpIXpHPtyA0CFG59/jzmdxGKdmA1Dk8KorO5K5M2FnUFvmnpHMcnvyi1WtxdQFu2TILjVO0cGMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jmfn0oqBeeWsy9GhZVCyJjtGU6nM3Y8BS1oSYpixj4=;
 b=MNrPvwT8yLPb862d9Y/v4UfNxe97qkYfCjxygsRXU1F5ZNVTJ3b4K51fZk8RIuoHFlvDC708v2Kf9p/yjwHe1x8JKuOEZszSlhIabislbeHFHGnwgACQl1DgM7Ut96hm/yyUFXW5iDDIgCl4Efpf9biVDHhvNTaEbUsdEaZRc1ZCsab0AMdQYBP8LJAnlVv/gk28EO3pHAAvbyHiNyZW/r0zOVNHld1PQzwRiIEN4ofUpptGCEFTpkI8LnOIhb8dKtMy9eYns59egfDjyL0BYdFOvj6KW9kaEcrryV4LXzlaqNjS0mCOw3Kc6G0SDcBhwjh+PuaubF133HIHRn/cew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jmfn0oqBeeWsy9GhZVCyJjtGU6nM3Y8BS1oSYpixj4=;
 b=z0OPfvfHhbrVYj9uYW83q2AstrjODXYQoqPCfDwUcJCKenHiI9CZd26r2Xtthxnp6qjIBFTINTwWbE23UvnI7Rul1Bt0TsVTpoqoT61weqaawKqRUhbPRE9ZjB5YxqdRX56NyHByZC0dNGQUqAgGKTAGfRyeQK5KNGDIc8R4v10=
Received: from DS7PR06CA0035.namprd06.prod.outlook.com (2603:10b6:8:54::9) by
 PH7PR12MB7115.namprd12.prod.outlook.com (2603:10b6:510:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 17:55:50 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::ab) by DS7PR06CA0035.outlook.office365.com
 (2603:10b6:8:54::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Tue, 8 Nov 2022 17:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Tue, 8 Nov 2022 17:55:50 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 11:55:49 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 09:55:49 -0800
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 8 Nov 2022 11:55:48 -0600
Message-ID: <7600d6a0-79ab-143d-28c8-77320d7ba12c@amd.com>
Date:   Tue, 8 Nov 2022 09:55:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V9 XDMA 1/2] dmaengine: xilinx: xdma: Add xilinx xdma
 driver
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <trix@redhat.com>, <tumic@gpxsee.org>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>
References: <1666720638-33496-1-git-send-email-lizhi.hou@amd.com>
 <1666720638-33496-2-git-send-email-lizhi.hou@amd.com>
 <Y2Uidg/iuQdxwSaG@matsya> <73ab286c-f8c7-8c4b-0508-5df8dde8e305@amd.com>
 <Y2VSfjWZSWY0f2n4@matsya> <e1244ca1-18bd-d6c9-6101-9b20940fda72@amd.com>
 <Y2YOHx3RBJxdx9xz@matsya>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <Y2YOHx3RBJxdx9xz@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT113:EE_|PH7PR12MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d0272f-956d-49df-4480-08dac1b27905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NmclPVp3jQjU5WhdE1PF1PzSyEm23vZXuIeWgPEQuMxV6bFHQZ1vpy/LwUeJhaKf5S8NIOi8GSDYEq1Q7YtmYukFcY1UTD/ow+EJ/QGhihMmHvB52iT/Su/WSXKPy4N5yNwP7PTHX480XAIyCpwAIoE98DV9XMQUKklCqqwi4G+Z8oPyYp0fHVWCXjIOoDs2eI7WNxAm+4GcdQm86vVNnlYYrJjgiRUgAdWInjkZeA8hldL7Alew1MJ6KeCLxME9NkkAvRyIsSCauHWQngy3lnpqtoTbudlP97IY66Pb97RcH3ZnF+14x6H80kYLBFsTYEq6LEDfxsWMe6zl3gQ9tZMWVc4aIMz8FcmwJDroFOhoDI89c6TPax01RGdXrUVfUvb360itJudk17XXZuUCi6FaBtESzPmMhAuSoSB6wVFN9tfnl+JYaKTjl5cfn1ZaSsyqe0T3gmzeA2/9j4qzNgIjXUKUzqyFxJqkZcyxNPG7KXoS5uXzmuP/fLdzDBHRRz3udSJJEGR3uK5PO1TXIf1dPkws1kUmB2rzXhIY2nqAEo/cKMncAQPtG687mcRzeUP4ZM0gaJvOrGtiYvDxVyKBHx7Iam1YuE7Ayqr/RK/1FSidpEb8KtFF7XJMpqRciVh5b9Gl9cCvifbYJoFZm00Yky/lnSEOTj7lOhF4J1yYfbS2IRteRJKlgEweb9NrSgMLOPkTV17L+PNKvkG2pybb6t80E2yHcXS2GDOe6ntcoRjHpDEjyvns2ZhmdgAsOb3p+SbZMu+cQhbxT241mJ5ZCy53w8qKpqLgbGrpLyvztcpjrCzkIWHHE62BjAFn7nUKMpFNPCnzIRP2g4ZH+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(426003)(82310400005)(40480700001)(31686004)(478600001)(316002)(6916009)(16576012)(54906003)(53546011)(70586007)(8676002)(70206006)(36756003)(47076005)(26005)(4326008)(356005)(41300700001)(8936002)(186003)(81166007)(5660300002)(2616005)(44832011)(40460700003)(86362001)(36860700001)(2906002)(82740400003)(83380400001)(336012)(31696002)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 17:55:50.4293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d0272f-956d-49df-4480-08dac1b27905
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 11/5/22 00:17, Vinod Koul wrote:
> On 04-11-22, 11:17, Lizhi Hou wrote:
>> On 11/4/22 10:57, Vinod Koul wrote:
>>> On 04-11-22, 09:57, Lizhi Hou wrote:
>>>> On 11/4/22 07:32, Vinod Koul wrote:
>>>>> On 25-10-22, 10:57, Lizhi Hou wrote:
>>>>>> +static inline int xdma_write_reg(struct xdma_device *xdev, u32 base, u32 reg,
>>>>>> +				 u32 val)
>>>>>> +{
>>>>>> +	return regmap_write(xdev->regmap, base + reg, val);
>>>>>> +}
>>>>> Do you really need one more level indirection?
>>>> Do you mean using readl / writel instead of regmap_* here?
>>> Nope, I refer to using regmap_write() intead of xdma_write_reg()
>> Ok. As you mentioned below,
>>
>>     why not move err into xdma_write_reg(), rather than adding in each
>>     helper!
>>
>> If I use regmap_write() directly, I will not be able to move err into
>> xdma_write_reg(). Having a inline function might be useful to add debug
>> code.  May I keep xdma_write_reg()?
> Okay, either way if xdma_write_reg() is doing only regmap_write() then
> no, if it has extra logic like logging on error etc then it makes sense
Got it. Thanks. :)
>
>>>>>> +failed:
>>>>>> +	xdma_free_desc(&sw_desc->vdesc);
>>>>> who will free sw_desc here?
>>>> sw_desc is freed by xdma_free_desc(). xdma_free_desc() is virt-dma callback
>>>> it converts struct virt_dma_desc pointer to driver sw_desc pointer and free
>>>> the whole thing.
>>> IN case of error, you are returning NULL, so allocated descriptor leaks
>> I meant the descriptor is freed inside xdma_free_desc() which is called
>> before 'return NULL'.
>>
>> xdma_free_desc(struct virt_dma_desc *vdesc)
>>
>> {
>>
>>          sw_desc = to_xdma_desc(vdesc);
>>
>>          .....
>>
>>          kfree(sw_desc);
>>
>> }
> ok
>
>>>>>> +#ifndef _PLATDATA_AMD_XDMA_H
>>>>>> +#define _PLATDATA_AMD_XDMA_H
>>>>>> +
>>>>>> +#include <linux/dmaengine.h>
>>>>>> +
>>>>>> +/**
>>>>>> + * struct xdma_chan_info - DMA channel information
>>>>>> + *	This information is used to match channel when request dma channel
>>>>>> + * @dir: Channel transfer direction
>>>>>> + */
>>>>>> +struct xdma_chan_info {
>>>>>> +	enum dma_transfer_direction dir;
>>>>>> +};
>>>>>> +
>>>>>> +#define XDMA_FILTER_PARAM(chan_info)	((void *)(chan_info))
>>>>>> +
>>>>>> +struct dma_slave_map;
>>>>>> +
>>>>>> +/**
>>>>>> + * struct xdma_platdata - platform specific data for XDMA engine
>>>>>> + * @max_dma_channels: Maximum dma channels in each direction
>>>>>> + */
>>>>>> +struct xdma_platdata {
>>>>>> +	u32 max_dma_channels;
>>>>>> +	u32 device_map_cnt;
>>>>>> +	struct dma_slave_map *device_map;
>>>>>> +};
>>>>> why do you need this plat data
>>>> max_dma_channels is used to specify the maximum dma channels will be used.
>>> What is the device mode, who creates this dma device, devicetree or
>>> something else?
>> This dma engine is on PCI device (exposed on PCI BAR). Thus, the pci device
>> driver creates this dma device.
> So it is a platform_device type? Why not make it something like auxdev?

With our FPGA device, the XDMA IP is populated by flattened device tree. 
Using platform device will support both device tree and non-dt case.


Thanks,
Lizhi

>
