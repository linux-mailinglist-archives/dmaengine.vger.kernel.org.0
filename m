Return-Path: <dmaengine+bounces-246-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952FE7FA6E4
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 17:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9DC1C20ACD
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 16:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DD3315BD;
	Mon, 27 Nov 2023 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J7cM+xut"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B94183;
	Mon, 27 Nov 2023 08:51:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+p295EUDl2Y9HwIz9+JkQfchBu5tBCtVG15Us6fhFMO8Y7ba9yx9FZ6jD4umAyWraS8sXIR3S+O3wNiXh5g/Ms1oCDTXaMIZ7c+JY5/hBc4jzizwYsB9F3+5KIMoXVVUMch2dzKL0lYPrMEBNHwWo893SjnQilzj1SNRcuapqiTJxhq/ZAFW08HwoqXVU7Ko+s6rPTH/qctQ60VQxHBqBvk1Z1fgITEdTc6DJWj+TVvGfNUTmvjAU0XYo53eUrHFlmx5uWtPO7zvbg4rX4zYeJLj/hXeq/LhTzv05Tm5czZmEEp1/gE5LPcKCVQ4aNFBDgAiJyOq+x++m0ueb8JqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZbIeGCJ0HXzo6fjF6E6MPMNyp3YBGP8Gsp+RJTEz0o=;
 b=VcrHEs4u4Z1AtIuDSUAT1qbRGpz5fziz2J10p0yuSWp2cZ+/ZlGSrgrEPyAtuMX/qBV/hFQQsg8+CBpOkajhYsJ1rPDgBLZEjkYZrsVfCNr8WYndl1bjW9wiMmPrt1e3MQN8klbhZGSVVTljvyHchc6g0QQAt18FVGhGD0lgxJhHJCnh55WwUArSjbAD8hbwugaw2+90VDGr1yF3B7RXXvJYx0EGzCnvKtjPtfdyJQKLkXJWGm/QM/paKXn8ByFyqETJ907mky148e2tqpuM2EjpcLyS2hPECULW9FpFJpnq8x57UeVDSd+hIjQuFtOYSiOuAp1hpWL+6LliFIabnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alatek.krakow.pl smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZbIeGCJ0HXzo6fjF6E6MPMNyp3YBGP8Gsp+RJTEz0o=;
 b=J7cM+xutt9M01JLmWOJyqV3uTWLdPUq/Q2T/woQDp0eMZej0abV0PwmsrCO35wStLRe8df9OwRgKinJ+RzJPUg0ACqCKeY0/0N+k/drdasAHqPKetFTkDTISZLuSaWnbRQIEC0vYSPzy1dw96RyVldECzbN6AYBM3DNQpv56A+Y=
Received: from SJ0PR13CA0111.namprd13.prod.outlook.com (2603:10b6:a03:2c5::26)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 16:51:36 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::72) by SJ0PR13CA0111.outlook.office365.com
 (2603:10b6:a03:2c5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19 via Frontend
 Transport; Mon, 27 Nov 2023 16:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 16:51:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 27 Nov
 2023 10:51:35 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 27 Nov 2023 10:51:34 -0600
Message-ID: <f4ab7b8e-0b4f-ccbc-fe74-296688b606ee@amd.com>
Date: Mon, 27 Nov 2023 08:51:34 -0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 5/5] dmaengine: xilinx: xdma: Ease dma_pool alignment
 requirements
Content-Language: en-US
From: Lizhi Hou <lizhi.hou@amd.com>
To: Jan Kuliga <jankul@alatek.krakow.pl>, <brian.xu@amd.com>,
	<raj.kumar.rampelli@amd.com>, <vkoul@kernel.org>, <michal.simek@amd.com>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<runtimeca39d@amd.com>
References: <20231124192524.134989-1-jankul@alatek.krakow.pl>
 <20231124192558.135004-6-jankul@alatek.krakow.pl>
 <401bc91f-f558-8185-8f14-dd1ef41aef17@amd.com>
In-Reply-To: <401bc91f-f558-8185-8f14-dd1ef41aef17@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|MN2PR12MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e5534a-af33-4b45-5e75-08dbef691e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QwntImEPaDFrrNvTNHfpAV2XALwprX5rlITR9t0+BI+ctWtcTrH5OD7lOZ9nIU8mqQQd1zuhXMh9NI4DE1ytAnSk8SLfHdDwWX/Lda56kYoHXfoSYS2P9Uq6VTF10vqJC8kkohTSl/sItSOm/oGp0JgFeBKjbniPOuxSPqqbZCanWQYU8tc1dMo6FwU4m12bVOpyoGOU3GU4dgejOavOPbHCAOizJOQp7RZEA94Dt7Yq7Lcg6scwkOh903lpg7JK06XB0s1UZzAqTFa5gLpI4PtbHersnhPUXdW59TYkxzR+YbDffTB7aZc1zGx01GPI2O+vB+le7wdF6J4rYNpREz9NeaLsjEnfS7jZ5SL/aXUwWes4VC5SSyeI77sxPp6bhenNAn5M7lRjaQJpb29G3GBwNIN1yG/vgo8zUXt0RSjM1Fjky4I1WL9Vz/Ni3X9ThQPGeqk8Wjm3/j7HmD99fC6/w87/5mW/O1UDvg/bMpv4me5SFd5D4Qp21fN3CbWNGEX64F8uuDAexu5axCjBoWO/RZ7LeIp/xVkwYBjTVTaJnXzhClfo/NwBn2fUJb5Tu/rz2qIuSrmeY14vrhwLjh1vqUyUCYXDGWs5m6kjw+lJuPYAxmnbqXh4q7k3uB1vvR9LUM2ZtgjOto7e8bZL2yBsC6C5L7pCoAYvHDDhsfSir176AWgzk3aWZ0Ub/Fpbq0Z5Axdv+g+lZY/rC8Q51sbdv3E2oBHhsRNGurkk8PO9zmm3neGiZyUTdxOx/90VHvhYy8BT6m73WVUneJ45XL+UI7qDVAgn137POL8H6M6c9Mjh5oe0YNxZt4banOm4
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(44832011)(2906002)(31686004)(36860700001)(8936002)(8676002)(41300700001)(26005)(70206006)(316002)(6636002)(16576012)(110136005)(70586007)(53546011)(5660300002)(336012)(426003)(2616005)(40480700001)(83380400001)(47076005)(356005)(81166007)(86362001)(31696002)(82740400003)(478600001)(36756003)(40460700003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 16:51:36.0682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e5534a-af33-4b45-5e75-08dbef691e50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143


On 11/27/23 08:43, Lizhi Hou wrote:
>
> On 11/24/23 11:25, Jan Kuliga wrote:
>> According to the XDMA datasheet (PG195), the address of any descriptor
>> must be 32 byte aligned. The datasheet also states that a contiguous
>> block of descriptors must not cross a 4k address boundary. Therefore,
>> it is possible to ease the pressure put on the dma_pool allocator
>> just by requiring sufficient alignment and boundary values. Add proper
>> macro definition and change the values passed into the
>> dma_pool_create().
>>
>> Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
>> ---
>>   drivers/dma/xilinx/xdma-regs.h | 7 ++++---
>>   drivers/dma/xilinx/xdma.c      | 6 +++---
>>   2 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/dma/xilinx/xdma-regs.h 
>> b/drivers/dma/xilinx/xdma-regs.h
>> index 6bf7ae84e452..d5cb12e6b8d4 100644
>> --- a/drivers/dma/xilinx/xdma-regs.h
>> +++ b/drivers/dma/xilinx/xdma-regs.h
>> @@ -64,9 +64,10 @@ struct xdma_hw_desc {
>>       __le64        next_desc;
>>   };
>>   -#define XDMA_DESC_SIZE        sizeof(struct xdma_hw_desc)
>> -#define XDMA_DESC_BLOCK_SIZE    (XDMA_DESC_SIZE * XDMA_DESC_ADJACENT)
>> -#define XDMA_DESC_BLOCK_ALIGN    4096
>> +#define XDMA_DESC_SIZE            sizeof(struct xdma_hw_desc)
>> +#define XDMA_DESC_BLOCK_SIZE        (XDMA_DESC_SIZE * 
>> XDMA_DESC_ADJACENT)
>> +#define XDMA_DESC_BLOCK_ALIGN        32
>> +#define XDMA_DESC_BLOCK_BOUNDARY    4096
>>     /*
>>    * Channel registers
>> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
>> index de4615bd4ee5..d32ae93e18b6 100644
>> --- a/drivers/dma/xilinx/xdma.c
>> +++ b/drivers/dma/xilinx/xdma.c
>> @@ -735,9 +735,9 @@ static int xdma_alloc_chan_resources(struct 
>> dma_chan *chan)
>>           return -EINVAL;
>>       }
>>   -    xdma_chan->desc_pool = dma_pool_create(dma_chan_name(chan),
>> -                           dev, XDMA_DESC_BLOCK_SIZE,
>> -                           XDMA_DESC_BLOCK_ALIGN, 0);
>> +    xdma_chan->desc_pool = dma_pool_create(dma_chan_name(chan), dev,
>> +                XDMA_DESC_BLOCK_SIZE, XDMA_DESC_BLOCK_ALIGN,
>> +                        XDMA_DESC_BLOCK_BOUNDARY);
>>       if (!xdma_chan->desc_pool) {
>>           xdma_err(xdev, "unable to allocate descriptor pool");
>>           return -ENOMEM;
>
> This is probably not needed. The 32 adjacent descriptors here is 1024 
> bytes. Defining 4k alignment should be good enough.
Oh, Just noticed the you have changed the alignment to 32. Sorry, I just 
hit send too quick.
>
> Thanks,
>
> Lizhi
>
>

