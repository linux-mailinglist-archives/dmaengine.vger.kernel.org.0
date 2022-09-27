Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A003E5ECBF4
	for <lists+dmaengine@lfdr.de>; Tue, 27 Sep 2022 20:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiI0SO4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Sep 2022 14:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiI0SOw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Sep 2022 14:14:52 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88611E3D0;
        Tue, 27 Sep 2022 11:14:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImiCIgMrajgt5yxkvrDRJHjnfJqFxRBuGAv/f/0ZUvCfu7xZmaToluzS+o3qXu401U8eFH2IoS+OAEkdWP82TbYhFopdZqoJn7ksHjG0bjb6+t6P82NPOpBHdfs+AXfOq5d9Mn5g9GyHAjxn4g9lZXJy7M/aslxiBAuicN5bzq7f+4ZO1NVebod5It7fWnrihufButUGT4c8kXz2bNWdfaB5e4Xu6D1pfw6v2/uiXXrqWODoE4XwnNZ3eaKSdENUfbhFAI9mIB99Ikjgei6IQUo/jPUjCtRnBz59ixL+xKfvtyZJJsu3VnlBco5mIKUvwxjg2kIABBfhKGYhQwqmyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URi4MJL+/mJjyobGSwyT/FWVrEuXrU6GOt+Jp0ZHzlE=;
 b=fdoO0USMmWq0YI1+lpsyEQB0KBBGEUEaJLbIQbtGotisoqjc/ooqWB6T+FgfXnzGplpxgR2nhCszOhwVdSTKRZFYxUoR2UiNK8PdxUgPIsnKzCsBD+ArXF32iQyoK+rpIyminj9NkqXK9WwBOizOfOd13j1Vp2PXBiANsuVF7K0ZAw/Jz0o4SDp+syxVMecsViEk0gAvDWJDDtn+6tCpie1O2JSPIqI7luil37wdftltlMKQzZdSldWnDEgtKbPLXesVjbkLlZK/aCZYRfL0P8pOshVbyCI4VWMX1GTV2uPy5/LuNdMKn8x/O3Ix2odfP+Mdmb9Ceajf1t+oBryjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gpxsee.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URi4MJL+/mJjyobGSwyT/FWVrEuXrU6GOt+Jp0ZHzlE=;
 b=mopSPeW+SVSt7HhtIXyjJKPPQ9D7FHqF5IicDdaiWXB10PJTswnZYEUfWAIg4wUk+tH+yFNtCrvGpsXFfBtGgNxDd2P5X0qRdWUSLDfvovnohcTyYWfU9UKCR4p8Mfy66gulLGlVN/r4X1MZse96ao/A9JOGQxdtWCr6nfdjgdA=
Received: from DM6PR08CA0036.namprd08.prod.outlook.com (2603:10b6:5:80::49) by
 DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.26; Tue, 27 Sep 2022 18:14:46 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::3c) by DM6PR08CA0036.outlook.office365.com
 (2603:10b6:5:80::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Tue, 27 Sep 2022 18:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Tue, 27 Sep 2022 18:14:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 13:14:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 13:14:45 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 27 Sep 2022 13:14:44 -0500
Message-ID: <2339d3e2-1c1d-4005-b5bc-e115f3c7a6cc@amd.com>
Date:   Tue, 27 Sep 2022 11:14:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 XDMA 2/2] dmaengine: xilinx: xdma: Add user logic
 interrupt support
Content-Language: en-US
To:     =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>,
        <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>
CC:     <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>
References: <1663871905-60498-1-git-send-email-lizhi.hou@amd.com>
 <1663871905-60498-3-git-send-email-lizhi.hou@amd.com>
 <a2b5c35d-ced2-ff83-c550-4bbf29973b80@gpxsee.org>
 <64388266-1707-ee20-c3ab-edb67ada68dc@amd.com>
 <c0430eb7-d607-acfd-201a-db56db982309@gpxsee.org>
 <5f77987e-49bc-e035-19e0-52c25f4adc7e@amd.com>
 <68fdd2a3-b881-470b-c5b3-0f2fc881ed27@gpxsee.org>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <68fdd2a3-b881-470b-c5b3-0f2fc881ed27@gpxsee.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dfd39a7-9081-4662-9cd1-08daa0b42886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CloMndp4jEWdH1rSPvyMSVwaKZ9vHeQHxsB/k7VljAj2fZMCF1qkHjqJaYnm28A6YwKAz/GPVXI4RcXYlU9kIAkXyOZfEsexHCdMDEYAMmyweBUZFiKM6vulKQNpfXlTwGF2+SJKpsbO6QydTjA5VWTr8dPTcDE+lP2SmjrIUz+PIgFRBvVACJnr75uxZky5mhvo3Wcjh2yu2dfS/CVLPaLEdaWjH8huK9yxq9mXYuzjZWZMOu45BHTsLYMK+hY1soz2W1GNGvUDEgkbSyRvcTJSH4WlWyOiQd9OASQjjWNsdmdegBFXa/jIgkiy7hswKzHJFPvoxMCDGAcRzIETSkEhSX1hiZk++zm6xb0OFZpnOduy1PyFzcoSVZqZdvV+wWL4nzVNEumpdXlmrzvHaLUX6nBjEht52mtvOP2QGIKk+2blXI4q/Cw3DJZL1TAH+pWa6XN9OfKr/MnwU5Cn9yHkJi1OITzKXhMLLcp+arFRPSoU+BH4Dz3JSaXJZzQfFhzswUzFd8sHvq5/fuLtoRLH5l+/hoL2LCyDV6SYoTiKF7PAqdCYiQZuEVyDJdXLLMGG6kXpScT9mDB6OTMLKs0MarYOVrI+clw0vhuw2MoG7Pc630bN9hYVYhpZ1HNipcysf3L1bumXyhB5IR903H0nX/t37gBX0mBI5IfwXee9JOX3xqfEfMlSg4pnwuh1bkdIxwXhfMlnJC9XdV8CZ/jfolbGGDhwTAbTFLGAS59kOohG66N/E2XM/EdpQMFNGwgwPe8DBDITwtnIWWuJ+3D0hdSWfx/Q8kuTAgaB8TjCIm7rXC8HPAjMUfKjs5YVvpSB4htaEkBdFppDGf2Dsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(70206006)(70586007)(81166007)(356005)(4326008)(8676002)(5660300002)(31696002)(86362001)(44832011)(2906002)(2616005)(8936002)(186003)(66574015)(426003)(336012)(83380400001)(316002)(478600001)(41300700001)(40460700003)(26005)(36860700001)(53546011)(110136005)(54906003)(82740400003)(16576012)(47076005)(36756003)(31686004)(82310400005)(40480700001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 18:14:45.9877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfd39a7-9081-4662-9cd1-08daa0b42886
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 9/27/22 10:54, Martin Tůma wrote:
> On 27. 09. 22 19:18, Lizhi Hou wrote:
>>
>> On 9/27/22 09:46, Martin Tůma wrote:
>>> On 27. 09. 22 18:28, Lizhi Hou wrote:
>>>
>>>> Okay, I got the point. How about changing request/remove APIs to 
>>>> enable/disable APIs as below
>>>>
>>>>       xdma_enable_user_irq(struct platform_device *pdev, u32 
>>>> user_irq_index, u32 *irq)
>>>>
>>>>              user_irq_index: user logic interrupt wire index. (XDMA 
>>>> driver determines how system IRQs are mapped to DMA channels and 
>>>> user logic wires)
>>>>
>>>>              irq: IRQ number returned for registering interrupt 
>>>> handler (request_irq()) or passing to existing platform driver.
>>>>
>>>>      xdma_disable_user_irq(struct platform_device *pdev, u32 
>>>> user_irq_index)
>>>>
>>>> Does this make sense to you?
>>>>
>>>
>>> I think even the "irq" parameter in the enable function is surplus 
>>> as the parent driver (the driver of the actual PCIe card) knows* 
>>> what PCI irq he has to allocate without XDMA providing the number.
>>>
>>> xdma_enable_user_irq(struct platform_device *pdev, u32 user_irq_index);
>>> xdma_disable_user_irq(struct platform_device *pdev, u32 
>>> user_irq_index);
>>>
>>> should be all that is needed.
>>>
>>> M.
>>>
>>> * something like:
>>> pci_irq_vector((pdev), PCI_BAR_ID) + NUM_C2H_CHANNELS + 
>>> NUM_H2C_CHANNELS
>>> can be used from the PCIe driver
>>
>> How does parent driver know the first few vectors will be assigned to 
>> DMA channel?  Parent diver should not assume the first 
>> (NUM_C2H_CHANNELS+NUM_H2C_CHANNELS) are for DMA channel.
>>
>> Parent driver passes the system IRQ range  to XDMA driver, and only 
>> XDMA driver knows what IRQs are used by DMA channel and what IRQs are 
>> mapped to user logic wires. I would keep the "u32 *irq" argument.
>>
>
> The parent driver knows how much DMA channels it wants/allocates. If 
> it is possible to allocate different IRQs than the first 
> NUM_C2H_CHANNELS + NUM_H2C_CHANNELS to the XDMA IP core, than that 
> parameter may be needed, but I haven't seen such HW. Moreover, every 
> parent driver author should IMHO know how the channel and user IRQs 
> are mapped in their specific HW configuration so this info can be 
> "hard-wired" in the parent driver, but I'm fine with it when the irq 
> parameter is kept anyway. All I really need is that the enable/disable 
> logic is split from the irq allocate/register logic so I can use the 
> other platform drivers.
>
> M.

Thanks Mark, all your comments are very helpful. And glad to know you 
are fine with irq parameter. The IRQ binding is set by xdma driver ( 
xdma_set_vector_reg() ). That means xdma driver is able to map any 
system IRQ to dma channel or user logic. That is why I prefer to keep 
irq parameter. Just a FYI.

Lizhi

