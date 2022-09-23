Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78D25E78AF
	for <lists+dmaengine@lfdr.de>; Fri, 23 Sep 2022 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiIWKu4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Sep 2022 06:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiIWKuj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Sep 2022 06:50:39 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC9FE170B;
        Fri, 23 Sep 2022 03:50:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkBgz62SEXBvRbdeGc4mzyBsVFqk1AADq76r0Yr9Lj+UmVqTVf7ltItZMTIBwF33UOP4PrHqXswHBagoUekyNgkc7xN2PC8W50cF03ehev2DRiVUJWTrVN4ZWd+zicYvteM6gwxbeLoBJBCYUdSmE8sF2bgWE6TCJCoRcWL1RcgnIbe2ySm2x4kFymAdoDXAOqcUWDVbfXWpSHNos5zdyrJqUfmP4VDQvGA2G/ytIT0UENEc3q8ZOkCDFw1uAejn6UH3VyVFHoNNcvR3F0Z3DnJI2T7pgM2APGIeNyLZI105LOc0uJ2mvK4rhZiZa/rGw5bZWlOlu26AEnu+ykmAgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq3OFKErN4SwkH81hJR9t80+rW6cQIkMMauTbkguzgo=;
 b=IpB3xKAK2SaGW28VeH8uAeMUSfgk8xRHohsdff+Nv2bjwHsUZ6oaIVaRRMv99TtYZ26B1NuP8QDRTDvR6PZ+MJ7zcF6ow8B6wLQnM28FNXAvCv11C3Ff+DzGPymjVbjrNp5WCthdFi3hgc6h754KN0sMt1VBMkWnM9xnvjYlMIyUeQ5e2uxPe//ieWoiIbZTA4SaLlgKBGBqgT8/HQHnsT/3PykdDDEQgf7SVF0n1sR4+vOh5AFcLES3rCT50LmZYylyjI9aLWPfkTqY9RZcRu1PLaFYXSKdBtS2bm+a9riORCRqD5g/Dq8FfMfafMxlASnghf+xEPpcxd6IoUN2JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq3OFKErN4SwkH81hJR9t80+rW6cQIkMMauTbkguzgo=;
 b=Tst2CDu4/NOm3wsEvup34kERMwJUBPYYFAlKQzOn4uRlGjMn1Q47MWjDfK90ehg8d8bG3Stqnqytclt5lKAk4svLG0EwpB3l4TbGT8zmTdsC49byeYoDL0/kmWsW5tB1Qaa0ZuiRqqMpwCwiRP9MbN2jc1RLhiFGHDA0xQDpNFfjmIb65Ltex43R7AUgplTQaCo+cO3WKjnHf9fuhpOa565IBudIs92JHI1SDpdLJVgSU/VzTZXjKI+NI74X9otyvPnJ2fjkCcwq6FSznUcXHDs8FXHJL3pFk8WiMDCyZId0SAvSt79F/QxXAseFcL9pC08aoD9xOWc9bEKWiE8x9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM4PR12MB5183.namprd12.prod.outlook.com (2603:10b6:5:396::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.20; Fri, 23 Sep 2022 10:50:37 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d%5]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 10:50:37 +0000
Message-ID: <d2b4a1f5-200f-2560-c249-709e4e2817b1@nvidia.com>
Date:   Fri, 23 Sep 2022 11:50:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/3] dmaengine: tegra: Add support for dma-channel-mask
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220919112559.58195-1-akhilrajeev@nvidia.com>
 <20220919112559.58195-4-akhilrajeev@nvidia.com>
 <8d15c575-a490-e1ed-7e97-5a5cdea0925f@nvidia.com>
 <SJ1PR12MB633958099C6DDAA4A428ECBEC0519@SJ1PR12MB6339.namprd12.prod.outlook.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <SJ1PR12MB633958099C6DDAA4A428ECBEC0519@SJ1PR12MB6339.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0102.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::17) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DM4PR12MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: 61057a44-0ccf-46b0-99c7-08da9d5172d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pdq3ocCTdWX5CAhk7pYQw4mNueC/w2QrnhJ3MDhnpYrpFXpElITJVrM0RerKA1rSS6xllyExS5/voxMIf1vlZCJYDjzXD+aC+oM3hbCOY0IijMJ892ni7IhMaKjjQhQuQAyaY/84RzjsiDOkw1TSCSCJ9mERkfPUNQ9MmxuvPiy/yxAX0pRQ+U7DORnTFDQQuKAXx1PHKOnLw0hBZ9QS4Cn0COMIHlBleTf14JTcxgII8pehBfWnIkxJ92sFYJp2zWrBLvyelyes74y7ZZZpNVXlm3a+4UugFJmEEM4o7pblXqetJlwGOoR987WhLKFNXF6aon5iApClcpLouunE4Jaf3Dg2pOjx3nPBwOEtR+InFfjo4vXXEUFufVWYHlpNHkyP0i/A9Dl9+RO/6mllBVRO1EsxHa8FLAR/J9dCMtQvHoRSl/KDgFtnD0hjUj8tHJHS7bs6CT/F96GkBCyX3XSOvcjdRHm4tRcyqfW0QNPgYKGdjFjmAu8dvlfzBq5ARCf4KUAEuteYcxoVJjg+dR21V0OmRdGOk6xGvzCdtZtZdcnh5TKoWyv8Tu+hcKMhTzLasG1H6Vve5fnIxItJC/iJppnZRcrjMdldwe8M/K+sQk1J36wGJ8cq+1fX7hACYhE0yOMSGA/+kuSu8QjXT0HDuZd4zQT7mGrrZXE1+pe4r5+Aei9zLgyoKhl1gLh2KGzLL8Q6LyTTrb5jctYduovQc6ofzo+KNplyMXAPZ0z7xTbBwl0pzize/Q2u2mMWaYinwtMedlN3VWglh1Y8z6jwL1cFTNhu69omQgQFB6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199015)(38100700002)(5660300002)(478600001)(6486002)(6666004)(53546011)(8676002)(66946007)(66556008)(66476007)(83380400001)(316002)(110136005)(2616005)(41300700001)(86362001)(36756003)(186003)(31686004)(6512007)(6506007)(8936002)(31696002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1ZlSEtHcUVDaEI2ei9FOHRZcGJ3Q1gxZEJ6bVRrMEsyekJrL3V1U0IzeWMr?=
 =?utf-8?B?WFF4SFYvd29CTHNyRXEybUlGZlVhYzNlVy82aitYVTE5NkROekl3QWFVOEJC?=
 =?utf-8?B?dWwxSU5MelJycHJXdUliL2JhUFJmL3VpOHRyWFNsLzBQRmR3SXg0VXYxRDlq?=
 =?utf-8?B?Q0ZwZjFVa1crOWh0ZUpOaHRReGRSMVM0dmFkdjRMZzBzSS9Qc0tKYlhRcGZS?=
 =?utf-8?B?WEJUVktlRjVQYnNPQTNyT3BOS2tQSzBJelRLTEtJaDNBN2Zvc25PbEtKaHlr?=
 =?utf-8?B?cnh5RWZxaUpVaXQvRXVNL3JwUWRHT1RzWjZPalRSMEEwc0xQYll6OUI2ZGRI?=
 =?utf-8?B?ZSt2dGtJT252U0YyUENraFZteU5nWGxaZUFGQ2c2MEhBb0t0RnNibmZyZi94?=
 =?utf-8?B?cWsrMUxzNGdwQjdFZlMyVVF5OUNwbDJxYmIrQUpERUFQV1NIWjhhRmRmS2Z1?=
 =?utf-8?B?eDBnOGsyZ0cxWkZQOGFsbThEY1E1TUVaMXNtQnZUZzBSUGZxejk1Z0Y1ODNx?=
 =?utf-8?B?TTFkUVpIdkRRR3oxMlU5Z05TRE1HRy9XTHpNQllaV2ladm9KNVJJc1RsRDJm?=
 =?utf-8?B?TndSNjYrN0NHSUUxSEg0U1I0VjByMTZJa2dNWDFYQUNmWE1RRWNMblFuQXdR?=
 =?utf-8?B?RU5XNUNWUjhDUldzSnFLR1FJbEhqL2R6MmZPQm1Jck8xUC9VbmF3TEtDV2Nn?=
 =?utf-8?B?VE1wK1lsTXovb0wvbkNRL2JSZy82b1dmRDIyR2FTb2JGUVorbEtvTk9yWU1l?=
 =?utf-8?B?eXVsRlkxdUh1cnRmaFRXd0w2ZnYvMno4cmFWYmNZTmhvQ0xlVDhLZGpwU0Yr?=
 =?utf-8?B?STZKbGwxSXRHUHJkMXl3RDE2ZzRYN1RzdEd2Y1p3MjZyRkNEVktpVjlYdFpv?=
 =?utf-8?B?cnR1MUtaWXRCakFudXZKSDhXV2I4b2ZyTFBQeThETFlOeFFCR2JPVU1JWGt6?=
 =?utf-8?B?OVMyNWxGUUR1WmJQdFZXUkJmMjIxc1AweWhUZzg2ckFaKytSWWF0VDV3c01p?=
 =?utf-8?B?SjlsdzJnM25VVldGS0NPOU94MlRidzdtNWhSQnkyYis3UUtFWlpTcDRZYVJH?=
 =?utf-8?B?amhsNlo0S2N4cmhXTXJhbU5CTWRwN0FCNmVyM3hMSmRIQXVraGhhZURFcmxo?=
 =?utf-8?B?QjNPUmtDaGNXNzN3bTYzT2JFVkw2Z3d1ZFVySEE1ZXlGWkNNQ2ZiQzVxb2NC?=
 =?utf-8?B?L2dkSStzajZtbHlNQitxckMrZnpXVi8rNEIwZzgvMERDS0JZM3Q2NS9oNlRU?=
 =?utf-8?B?dWorVW1WT1EvSG5EdzQzRWwrWGdPaEV1Vk8vTW5wZHRJVW9FUkZFcGpyU2Fq?=
 =?utf-8?B?Und2dmhMdkZrRk42VkxKbFRjcCtMMDdSRHZaY0RrMG9BNTdHWTR0d0RsR1A0?=
 =?utf-8?B?bFFCOXZCVUJueVhuSDQ5RnpoVEJWdG40WkgxcjRjdm5xZHNzOEo2ODAwRk9r?=
 =?utf-8?B?dER6V3ZmUk05ZG9uWFdwSDhJN3FYWkpDNWxmTFJlcmJibElVcFhnTGsvTXVy?=
 =?utf-8?B?MTVFV045NW92Q0U4RVFrODc5R3RCcDV1cmF2dVpLaXhsbHNlYmdqRW1yVlVv?=
 =?utf-8?B?THI1d1VwVThKL2VOM1RvUytjSkNxZjNrMy9WUUpSOElXeDJCWURxd2xlalZn?=
 =?utf-8?B?cTZ0V2FoRG44Y0dXU204a0ZJcEdyODBJQnhzUll6a3ZWek81cERjNmowSFdI?=
 =?utf-8?B?SDdzelBTUHNFNElsUFFFZmFuMFdIMTNhbkpaN0VyUUZDRXJNOVpvanliejQ5?=
 =?utf-8?B?SkVPTjdUWHFDWXdmcXhUTnhWK2RQbnBvNkRGN1V0SldCcE0rWGZCMm9HNXd5?=
 =?utf-8?B?VFRhK1Z3UE5iSmJkRG1ScXZnNjcrSWtkeHB2VEI0Zk1sMjNpZnRLaFRGTWd1?=
 =?utf-8?B?WjBzZmNodjgrUzZPdWdkVGhWUVJmQ2M4SFpxdS9uSUZ2ZU5GTFhhUHM0N1Z4?=
 =?utf-8?B?dFNia01HeDEvaUllOUV6eGNOd2lOQVhxTmh1UXk0M3p5SWxIcFFFY0tJQ1dR?=
 =?utf-8?B?VXRsVWlRTitYd0k0MDYyRlI0d1R3QUdmWUJrakNGWEtQM0E1QkFGTXBidjFn?=
 =?utf-8?B?UFFmamVpZHlWNXhwQU1qZDVqeEdMK1UvUFJ0ZnpRV2tBSXkvVHFDczg2UzdV?=
 =?utf-8?B?Y0JUcWRuSE9Najk0aVdibmw0MHpJWVhFeHA3b3R4TlptUm9PSWxiVWl2ZHY1?=
 =?utf-8?B?dXVFY3ZpWGQ4WW9mY1F0MjNpWXJBdnR4eXpQR2dJK1FoL3c2WjZXdGxMcVNk?=
 =?utf-8?B?QkV6cjNPRHFuekxNbmZTSmE2WEpBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61057a44-0ccf-46b0-99c7-08da9d5172d9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:50:37.3777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iQa1dZKOAR6D564ccZSxEWk/Q43I7uHIdKxbXxMV4kvCm61yibpozA8wO6poFdhXvTBtm5ivwK2DE2tfdrd8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5183
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 23/09/2022 11:17, Akhil R wrote:
>> On 19/09/2022 12:25, Akhil R wrote:
>>> Add support for dma-channel-mask so that only the specified channels
>>> are used. This helps to reserve some channels for the firmware.
>>>
>>> This was initially achieved by limiting the channel number to 31 in
>>> the driver and adjusting the register address to skip channel0 which
>>> was reserved for a firmware. Now, with this change, the driver can
>>> align more to the actual hardware which has 32 channels.
>>>
>>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>>> ---
>>>    drivers/dma/tegra186-gpc-dma.c | 37 +++++++++++++++++++++++++++-------
>>>    1 file changed, 30 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-
>> dma.c
>>> index fa9bda4a2bc6..1d1180db6d4e 100644
>>> --- a/drivers/dma/tegra186-gpc-dma.c
>>> +++ b/drivers/dma/tegra186-gpc-dma.c
>>> @@ -161,7 +161,10 @@
>>>    #define TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT	5000 /* 5
>> msec */
>>>
>>>    /* Channel base address offset from GPCDMA base address */
>>> -#define TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET	0x20000
>>> +#define TEGRA_GPCDMA_CHANNEL_BASE_ADDR_OFFSET	0x10000
>>
>> Why did this value change? There is no mention in the commit message. If
>> this was incorrect before, then this needs to be a separate patch and
>> tagged with the appropriate fixes tag so that this can be picked up for
>> stable.
> This is mentioned in the commit message.
> 
> "... and adjusting the register address to skip channel0 ..."
> 
> Probably it is not very clear that it directs to this change. Shall I update the
> commit message to have a clearer context?

Ah OK. I was wondering how this worked with 'channel_reg_size' but 
looking closer I see channel_reg_size is always SZ_64K. I wonder why we 
even bother having this parameter and don't use SZ_64K directly?

Anyway, for now this is fine.

Jon

-- 
nvpublic
