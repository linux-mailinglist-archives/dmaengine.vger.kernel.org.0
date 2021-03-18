Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407743403F9
	for <lists+dmaengine@lfdr.de>; Thu, 18 Mar 2021 11:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhCRKy1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Mar 2021 06:54:27 -0400
Received: from mail-bn7nam10on2067.outbound.protection.outlook.com ([40.107.92.67]:60630
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230001AbhCRKyT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 18 Mar 2021 06:54:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkBSEIol5MOwNiqxfKT6pirCwCalGzQZFG30BL4yEAwLIhxTt/acJgIsSfVjIXoDIfseezUeOQxlxCa0nSIVndPZSqkYX3ww8vy+54O4O0ZAaQt0xJfSMNi1X0LkCFAkTnYNBCzgj+QN59JuiAzD+AqC6SMVz5ZyrmXFf7miGnZq/glguioDu4DCXv8nYCfKlc3Or6L7meneKoB0Q+NW8ilJa2h5NRQyCkxSHqSSZDWWPNg2/BuKIW+8bITnlEM0sDRKoMqUtGYE74t4NqtlaMvIcLQoUp5LgVUJHcwBJBwq2OIYyRU8QX9wPOouPTDwfMuU83yEbQBMaYeqgsamOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhg5PzowF2QV+olfDLlfjU1Yg+4DjpsgcAABr9B+hrU=;
 b=V6mlDoTbeBqka/OhXJm5GUYVcbusKEUu5hiDNWeGKMLdqe9/ea2T8o2Or0MP189XrRwdgZJ/UvxpDhxiIpjp3DbnBynWHyEdBPy/iPRYvYkoF9xqMfeuEkBLNdLEh1Fw32NF455FD219JSEcO1UO5m1GrIoGoEbKvXQQjtZZVeTNtN84WcD/owJmKxJT0ypnLWNIjDy9f8T8fm6Sn87I3nCUj7MdDzbNJYV0YuN7+EO/q1PVThMK85kz6/6C87kUNZPK0KmdCvE1pFYWd8LpIusEQk7rdxKXQfPVb6xY5GZ+jEreNAKEJQQv8nAwsi3rv0wDNObeeAIx7YPbj+ICeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhg5PzowF2QV+olfDLlfjU1Yg+4DjpsgcAABr9B+hrU=;
 b=ur96DSe1Ht5c0Lx4Y91W9GoetGw+aX+LIMm5/EyqoDJfe5i6Q0H2hJb+iFkzXVEw9Yd5twVSqQ1LMEW5tWYkLPGql5tCvHt1pVWz70f0O0+93uHbPGYR80oIT1G+UquHXkcTHQ1WHk1/48MPnAhQVZ3h4dXC0sXYNwwUbsznCY0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB2549.namprd12.prod.outlook.com
 (2603:10b6:903:da::10) by CY4PR1201MB2549.namprd12.prod.outlook.com
 (2603:10b6:903:da::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 10:54:16 +0000
Received: from CY4PR1201MB2549.namprd12.prod.outlook.com
 ([fe80::e974:eaaf:2994:ccb6]) by CY4PR1201MB2549.namprd12.prod.outlook.com
 ([fe80::e974:eaaf:2994:ccb6%4]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 10:54:16 +0000
Subject: Re: [PATCH v7 2/3] dmaengine: ptdma: register PTDMA controller as a
 DMA resource
To:     Vinod Koul <vkoul@kernel.org>, Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1602833947-82021-1-git-send-email-Sanju.Mehta@amd.com>
 <1602833947-82021-3-git-send-email-Sanju.Mehta@amd.com>
 <20201118121623.GR50232@vkoul-mobl>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <19466c1a-88a2-eeb2-77c0-9c0df1975713@amd.com>
Date:   Thu, 18 Mar 2021 16:24:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <20201118121623.GR50232@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: BM1PR01CA0111.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::27)
 To CY4PR1201MB2549.namprd12.prod.outlook.com (2603:10b6:903:da::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.32.35] (165.204.159.242) by BM1PR01CA0111.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 10:54:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e5596f27-bffc-4340-b09f-08d8e9fc2cab
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2549:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2549AD0BB4CEE2EACB8BD0ABE5699@CY4PR1201MB2549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rFmHG1rlYamwgbzID66AXe7cRXDzGddN5bXmHpOjy6my8A/Y8hajawnjYJJgAcxYIhXkXkwJL8exDImuKssoxt/nICpaTwFxHXGUTpd5IrotlUlTd/HyVa3jI93vpLcg7/iwNch89Y81CuM8M/aw3rcZvLBaj2l949TCr9z0xC/vIVYm0GLVnMQ5ozFk7IeSiZm7K1kxNJDR0eUuZDnSoRXc0SbcJXiGkddGiEfpMbIHjRzW2TCqN4QSsVSiR6kAiDnUJvkRNuS9nhLJ+hKT1pPFVPALLRDdJ4m98Fd3hviuNxJKvh3AokIZSAEcDck5+CJCFZe4BcN3HtbUoTnaYQH9b2GDT9imtbhFxFIkmAk4vg+AboIOmezEujvas3n4cq2/lMwX8nUUBKMQ37B2a27NkYZ04JGmgQRin+RyKOJg53u3xHuFYpVhpubgXNu7McwWhHNqYuT+/UfvDHW9X9fMSGTRm+h3t4BDRMXD9e2CQe60dzRtu1JY1DDj1bXQgYhm27Rt74DQ7SB3CNwNQHYFC7C5W1ESA9vcRmcabsTsCBiXqEdnL647DVKPUHyAFek8h44l8WxrI0sO8WEybj0h8hqM4o1O3bkgdFC1DxaqHwGT5DAn5WoCKlxBBRF4jipMQYAeMq+dfPqg2TNqpbeZ5+V8r5QLlFbBDMY4NQOM4xd7BzCjA1Pkfj2jAUsD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB2549.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(956004)(4744005)(2616005)(8676002)(4326008)(52116002)(66946007)(16576012)(31696002)(66476007)(6636002)(5660300002)(66556008)(2906002)(8936002)(6666004)(110136005)(6486002)(478600001)(38100700001)(36756003)(16526019)(31686004)(316002)(186003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M0pFbWh1a0tOTUhwQ2dTN0x4U3RsRmFaUWgzL0VoOFBoUTdxUHkrRm9SSWgx?=
 =?utf-8?B?YXo3MUZQMHdsNTFZc2xXek0zczVINUpITXRCZFNxaU1UMFVEMjlXVVR0OEVD?=
 =?utf-8?B?emc2SUJtdW42S1VvUzVLalZxWnZQNkRnZWdnaXc3cEY5b1U5SHVUL25nL1dI?=
 =?utf-8?B?QzdFUUxPZDExb29WRllVTHQ1eHdCT0diVWFidDFMeHdIZCtlZjZaTWcvT3Z5?=
 =?utf-8?B?cVk5cFRCcXFCbkh3MVBDM2hJd1VvVGowZmp1YTZZekFxM3ByVzFOUGtpSlpl?=
 =?utf-8?B?ektBVThJNHRXM1RmcVZOQ0czZTNDeVkvUlo5SloxU1kwSkJiYklCZnEyb0F4?=
 =?utf-8?B?c1d2MTdQdXhPLzhDTEd0Um1KZnNpSkJuMFpmeUpsakhTanI0L205N1J1VXRQ?=
 =?utf-8?B?c1ZydUFrdm9wcUErcWMzK2d0TkUvWEVBTm1CK2xRcHpaVi9HSk5ZSVNQbXAx?=
 =?utf-8?B?aVYxZVVjYmhCQUUwV3BJRTBXcm5sYjNjNGxVbG5uLzYxblhTUDlld3BnYXcw?=
 =?utf-8?B?VzY1STNNYUV3TUhuYkJwOUR6SnZGQnBTQWcrK1pqZUM5eTYyVlp4NDc0YVZM?=
 =?utf-8?B?aWRXU05lZVdJK1dDNHl3cVdsV3RFa2k4cHhNUHAzczhlVzlWRTdaNWVwL25u?=
 =?utf-8?B?MERaOTFNNW1tdm5VbTNmUGZybitMdVRKVW5pbUs1UjdkNk5ubFJuZTVBcEQ3?=
 =?utf-8?B?OUtsLzhKelMwRFRzTmluMUZ4SEREOEkrOFpjMFFiSGpRMmpiR2I4U3pXSFd0?=
 =?utf-8?B?aWFrZWg5S0ZuUGJtWCtCa0Y0MDl4RmR5ckViL2tZaE5ORGo0WGdiUFd1ZDcw?=
 =?utf-8?B?TXdtUG1CZGdFRGR5alYra0FFc1pZWGIzUGNycmxEdmVtckJsQVF5UG5tUVUw?=
 =?utf-8?B?a3hMT3hwVlZGbXAzLzVlaDlORDM4OXMwYVRZOWI2dG5VeTN2WCticmpqSTVh?=
 =?utf-8?B?S21YSHpPei9KcisvTXpIK1B2cEUySjllSEFwUTFKb0NyVHpWOG9MRzlnK29t?=
 =?utf-8?B?Y1lKU3JOZmVIWjdpZFFpeUdaM1k5VmZlSEorZEJ2SkpFdnNYLzFJMlNLdjRk?=
 =?utf-8?B?KzZKdHY4ckxvdi85d1hmL1RXVlJPRXl6dmNLNWdQbXhCT3lkSEVKVytTQW1M?=
 =?utf-8?B?eXBUWThyWGVINlN6RFpxRCtNdUtuMVRCaFpxdjdVSlV1SkIvc1U2UFJmSlFh?=
 =?utf-8?B?U2J4RHhkV3BsdHJQQVB4RGc4NmY3dnhJMFlQZG1SUWtPTGR4bWEzTHJlZE9l?=
 =?utf-8?B?dGJBampoR1F3TjFrd05TajN3Wk1od2prMmI4ODBhY2VqanJmZHY0Ymx3eUhm?=
 =?utf-8?B?Nk1LQWFWUWUwdFg5Tk9kZEcwanZ1ZE9xWm1TbTVhUE9ORkx4VTlpQTYwQnF6?=
 =?utf-8?B?VnhWdWJNRkRyQ25NMWVrYUJleGErM1dqNkVMaTM3dmlwMy9Ka2VmbWtGT0ln?=
 =?utf-8?B?ZVJGQlJoazVxK28rSGx6QmZHV2M3azhZTlduemkxVGF3cU5FTzB4WVB5aVF5?=
 =?utf-8?B?N2JlK0JHd1UzMVUzTDd4RGxzNVhHNnY2bDkzU3AzdXNxMmxLeG51dWNNRmE0?=
 =?utf-8?B?NWdVT0lXTEZWM0NXMWgwS1VpTU0xTHl1TlZCZ1U0YTRqUlI1aGw2Z1JFbm00?=
 =?utf-8?B?MnhoZjhSYUdINVJlRncrbWNsR3UvV1RNVG5jcnE4ZUJQSXd2OWQvaFE0aDBK?=
 =?utf-8?B?ZERKaDBKeWFHMGszUlp5c1IrSm9Qa0N1SlYweXBNYmN2Y0NkRVc4UjRIK3NJ?=
 =?utf-8?Q?7/3RsUZwpG8hXbpdjzO4IoLkjqGUMBj2QbYssl0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5596f27-bffc-4340-b09f-08d8e9fc2cab
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB2549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 10:54:16.4754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iq/p2h7kCvVy04tBj2fJtyUSDmbOQNxdAE2KkqD29Zxkj1g66KRYBJPqMgp6nX9kLmcbnZSiScV3NrDPZC5yAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2549
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

>> +     dma_dev->dst_addr_widths = PT_DMA_WIDTH(dma_get_mask(pt->dev));
>> +     dma_dev->directions = DMA_MEM_TO_MEM;
>> +     dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
>> +     dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
>> +     dma_cap_set(DMA_INTERRUPT, dma_dev->cap_mask);
>> +     dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
> 
> Why DMA_PRIVATE for a memcpy function?

This DMA engine is intended to use with AMD NTB IP and not for general purpose DMA, hence set the cap as DMA_PRIVATE.
Otherwise this DMA engine will be used for system DMA. Please correct me if my understanding is not right.


Also, I have implemented all of the comments for this patch except this. if this is fine, will send the next version for review.

Thanks,
Sanjay

> --
> ~Vinod
> 
