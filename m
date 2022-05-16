Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B590527FDE
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 10:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiEPImY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 04:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiEPImS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 04:42:18 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50328B870;
        Mon, 16 May 2022 01:42:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9fsn18YtIAKopMjtmz7i0M6omISPpAGk/oA8Siz8Ncmdjp+OlvGrg/sRO9eXgqE2zNVeIGw5hdXM72A5qg5ELLvyuBrC99AcNubKpNVD/GgzIhdgMMVbVZCj3oQM1Xd9hITf4C/E0VTlkeeLCYXucAV8U2ydUXLg8vxw43GYbOwt4iF3RKa5bpO30q3tjv7NhqwKNIZ0K/DXte9xjanAntwDBQt+WpvkI0ZnuxrtkSqSJkyx4oNo9YvaeZHnybFkp/ym1mHUTuJB3xDoVoEmCwadziJUicVNLnHsJi6YxUDlnZXLzsWBmn5ayKK6tP1xjRcFMwvuxQZJOqzKw0NXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXETIpPl1NQbqEYcz+Y2wILUPrndXaW9Aw+cg4Ip+y4=;
 b=hvqIW9Go5DhxVnmYz1Os8xEsuzDaOz8idousex5M54lTkhCQejvxMBuq2mRX2vYkpfu255d74qWfuD5Bpu3PTnR+/Gronmg+WFJ0qlhRHglfkZi3JMZUqFXc0njSDeWZ6zpgG9BgEBA7qQahK4+6vv875qHTjT71gy9Yc3JXSbuPcSprWO13yZMsCmeENFtldSENYm5xmCOhU+Iq9mFyxktgGheptisTpk5oAH5tSS+wgy/Gx2oCw5X3Lif7r89okejU2ubtcDqwQEJUHDlAYMYiRAKTdT32zfhQYiN/vG/1QnjSbMSN6kUcAduuFyFMmfEG/z+BWkWwnRoAY0JC6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXETIpPl1NQbqEYcz+Y2wILUPrndXaW9Aw+cg4Ip+y4=;
 b=tB8krMIZ51QPusLudCC2fRpZPYUB9pAvDY1Zn9AMa0UGmrRnpsv4I5XwWcZyTtpWm/EzBGnaBT6Vuq2ZDXzWAm/EjrUmI6lpAnNCoqwBx7DXSZMhYChVm6Th4eDS90EaF/KnHCNZ6ffBpvRr/aZCi+TxYsO+2AHLgvnfz1fGkEOHko0KR49VYxzQq4U9rWqG6Y2YHDNMWMa3VNvvI4wFxHnsTzRd2QjchBrxk2s15UWhA1NztwU9w0zxrmKGEdMVOlVqp3wOiOKlkqdNfdvoyo0kJ5z6BBvRmH0cnwF19X/pjZxZTsQU9nP+hBrFCT93+JKQxYrLAqFgx/KJC7fDRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.14; Mon, 16 May 2022 08:42:14 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a4b2:cd18:51b1:57e0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a4b2:cd18:51b1:57e0%4]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 08:42:14 +0000
Message-ID: <9539ac65-0e3e-9a2b-c21e-5602d6fbbe3e@nvidia.com>
Date:   Mon, 16 May 2022 09:42:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dmaengine: tegra: Use platform_get_irq() to get IRQ
 resource
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Akhil R <akhilrajeev@nvidia.com>, dmaengine@vger.kernel.org,
        ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, p.zabel@pengutronix.de,
        thierry.reding@gmail.com, vkoul@kernel.org
References: <20220505091440.12981-1-akhilrajeev@nvidia.com>
 <7673dbb7-6a85-6ab6-f1a4-a6f4724c0b90@nvidia.com>
In-Reply-To: <7673dbb7-6a85-6ab6-f1a4-a6f4724c0b90@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8123ad11-a6d3-466d-f2a0-08da3717f9b1
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB276768ABA21837C9DDB7B43AD9CF9@SN6PR12MB2767.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZxKtdngZF5+bkCAkGv6vZohguHuU7MpFolzfSawXbqfHi010lAvEU3rY4Kq8DKngUqBPiCq8p0tLYHLCLc1sdf4GaMEbcZwK2RWlRH58abSt0Nf7SfWW/KJU6prIoj49zXwjh95EZxPsbjiJ6pbW55G0uEqG5/ZwmPbeQlylcRQxoCu6xZ3qtOw+VndseyI7jzmO2yob8Qszty6HPrw0s7B+ZAvBzOZW0Soz7tqCQabbZZ66UAjoYiPwaNoiTW/G0qVYq6oVaeHhk5EFgg50x5v7FBlNOMTQGA+8alNLJE5sRPRsM6WCR/YhRJr9kfdWaBt75TAUYhzIASn8QodqQwdYCX7/KgK1khfMLZ1Kf3QrP59q6sk1uLPhJiWe5w9rxgk5otisH9FgZTnu4dNL2HLolv7FWM6mABKl7rDjF5g5kIr52hS8Hzd+PL1Q6cjTL3tMKhX6GR0NRGENjM3b7wvwzHt0nmPDDCIFIqyniY9n7DUgj5363evXdOoe65aSF839lsYGqTwudNErSFicj4S2YwMYck2AJ/axxCVMCxlcZQAn/HEfUjVWT5bIhTGF96B5z54KNDLRQWffhHr14l6GHMaNoE5nHeMxLzvqkdaz5BVq45+qRNTptsAgehgryKwgO/RCWqz8y35WBpboqYrFQakmEVkuMuT4okBY2lQZKaT1jy4j8Qa2dL5q/THd64DXZBW3tTjxWg+w0WaHXtPjUOxxomYnzWv8lM8kkkgP1W4dwIAfhqQDp/kPthY3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(55236004)(31686004)(83380400001)(31696002)(36756003)(186003)(66556008)(66476007)(66946007)(6506007)(6666004)(6486002)(8676002)(2906002)(2616005)(26005)(6512007)(86362001)(508600001)(8936002)(38100700002)(316002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTlYR2c2bWFHVVNvVG16emR6M1U0d1dhVFVtaHNLMVdzZVJZSElUUFllTi9x?=
 =?utf-8?B?WlBtMU9qUEJ4SVZwKzVadi9wYVRKNklremF1VmFxSEkvN29XOVJkQ2NXUGRt?=
 =?utf-8?B?RmhnMXJDY3NPc2FTWGVWdWlxV3NENjFKRDdERS9OKzQxVzkwZzV0SG45bXNY?=
 =?utf-8?B?MW83VlZTaVVDYThYK3ZYZk9HSWplTmpvNFlkM2hUbFF3SlVXeEVoTFhaeXdv?=
 =?utf-8?B?VGlBRnZuQUsrekVSUnl6ZnJyR0NGRVR1Vlg4emYvdGQxMDdPcG9QcElYUUxG?=
 =?utf-8?B?V1JQS1JMdDJ2WFlONkZ3Yml3RDNSZ2tpdUtIYldHck4xYW1GL0dKZ0VET0Ir?=
 =?utf-8?B?YmJTc1pRTXU5QWhJWkxnVU5ZVTdNdTExbE9BdDRUTlBhNDB3bFJLYnRFdEFU?=
 =?utf-8?B?ZWpWalhFVUVqamtGM1drTDZWalVReVdGWjhRZ21NSjJZVzZnYkU2elBybXgz?=
 =?utf-8?B?bVQzdjB5VE51b29qVzVWbWdFbU05MFI1VVUrNVhac1orWVZpMVV0VjQ1Nmdw?=
 =?utf-8?B?RmNJRHE0Q2J4czJEYm5yZWdENlFsZCtBRXd5c2U1bWVJcVg1Q1I1aDFKTTNm?=
 =?utf-8?B?aDlOVi9KREI4cmdPSzlPWFFkV0o1dm5ETmNRRW1DbVpneTRid3VSc0V0QU5U?=
 =?utf-8?B?NnFJTU4zeE5VcEZxL1hXeS9vNUxXQXJVd3VXSzVtbzBaYkthTjVWRi9oTElh?=
 =?utf-8?B?OXFVN1gza2NVcWFVb1g1cExiWm0zRExrdnZsTlpDRXlrQ3RoNU0zVUVKMlVp?=
 =?utf-8?B?a1Fqb0V3T2psaW82SmdocW9ydTFGY2RkLzJKYldhVDJYS1o3WlFVZFNpb1c5?=
 =?utf-8?B?ZEtYMzlYTGRDWHRQWDZmT0oyNlVTa0xyOWx5VUtFVEU1MzJTYTFlSU9xZUNq?=
 =?utf-8?B?cTFsenIwT08xa29zczBJYldsVkoranMrYTFOcVJ2czk3RXhGQTVLYk5ZVDF6?=
 =?utf-8?B?REZBVjZ6d1NHR210b0l3Vzh0Z1RZQnhCbWxNOE1hcldWdDBOeUdKTlErZHI4?=
 =?utf-8?B?d1FhaERJZHk1NEx0d3V5dDVqWHpCZFVLbU5xLzVsUVlaQnhUUC9hczdkeEs4?=
 =?utf-8?B?eEVmeHlId0Y3djdQSUdPNmw4c3BvV2Ftck4xQWVzeWhQU1U0ZGtGUGdUWkUz?=
 =?utf-8?B?ck9mOUxGNHV2YitMU2MvT0pEaUZOWFZGOWFQeXMwVUNuLzA1L2ZrTGJ6d3FM?=
 =?utf-8?B?aWc5ZDV2UzlsSW43T21rOUF2VzJQZWlaelFja1ZrRUtwWUFvd0lPL2VBVUFM?=
 =?utf-8?B?dDNBVnVqYitLMFROVmQxMnM2dFFjYk80WXFwQlIzK25MY3ZNcmlyai9VUUh4?=
 =?utf-8?B?Y1grUWVUUUFZL2R5Yk0xTlNNTHFtei9SS3BCaHBpc0paV3hHWTlqdmw4bmJY?=
 =?utf-8?B?Vlg4R1VrTnc0MFVWaFpNTnNhQkRxelJ0cE5VN203Mk1jc2FRUUZKREo5OEZE?=
 =?utf-8?B?bStHNUEwUGRxSzErbEdlOFM5UnZoY2ZLOWtsMkdJSThJVi9Hcjh2cWxRdzVp?=
 =?utf-8?B?VTcyV2lNUm5Wd3RqUU1FQ2JoNjFsQVFaSFU4czZUOGp4T1VFb3BrdVQrQUVD?=
 =?utf-8?B?SldvYlBTa041cUh4eFExZ0lwNHZ0MjBjRWFoYUZJUlN2K1gwZlkvN2RIMzBN?=
 =?utf-8?B?VXRrRFBVVHJrck53dkI0U0dqcjJySU04TG5ONTJBY2tZMmZsSy9OeStWM2Nv?=
 =?utf-8?B?cVhjZ2djT1Z2bTcwRDFMMWsyc251MmtYY1kyRkFtUUFXZS9EWHRTRjRDeHFx?=
 =?utf-8?B?b1FUWWE1UmlDSHpkSmllbzYvckFYZmY3Q1VmVlpnVU1vMEd0NVpQd3RTV0pY?=
 =?utf-8?B?RlJ6Wk9TaWZWa1pKczRZVEJmZEhKOFErczZMVGJFVXdHRkNkVXYvMjVURzU4?=
 =?utf-8?B?TGtCb011YzI3ZndWVXFwUmEzdzBVTkx5dTRrckNZTGNIMHVqem9JbFNHK2lz?=
 =?utf-8?B?Z2dqSGMxeTNaOFdtYUQ3RUxxd01FZ2pwcnRrS0EvbHBBN21RcU03ZWFvT0c3?=
 =?utf-8?B?MmpZQkUxZU4rU3J1NGZEa1RRcHp3NmhKeTRtcm41N0xERzM2akxwTVYwMHZM?=
 =?utf-8?B?NjROVlVkRjUwVGpnZFhubHZ5SzN6Z2pyelkweGpkYkh6RDB6QWhWYnNFVTN2?=
 =?utf-8?B?Z0hRRXhWQWxnTS9tMVNDSXpIRUtraE9XSnRTYTR1b25ZZ2wwaGlhUmptbWtM?=
 =?utf-8?B?NXBZMXVtaFBIYkVWRFNYeFpneUtodms0aUloUmZ2bkxKTW1RUDJqWGZvWXlm?=
 =?utf-8?B?RFBWOE1nd3Z3NU5GSTFMb0g2d3RXTjRGR2dHZ09DNEptZTg0amJ2V1I5RExJ?=
 =?utf-8?B?UWk3d2dxYlJMYWpsMWZBcTlnYXRoM2NqSnlNZFF1cUtYd0FoQzVOS3VDcWk3?=
 =?utf-8?Q?kTxBUwI0jfh+3DQQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8123ad11-a6d3-466d-f2a0-08da3717f9b1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 08:42:14.2919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7fdHqEY0G9fmeu1Uaiqe37pR82f2my1Xux4RZVr17vV0Te6I48jdEcQS5YaRWVOyKw5/OQOKqJWE9FUnlp5qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2767
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Vinod,

On 05/05/2022 10:18, Jon Hunter wrote:
> 
> On 05/05/2022 10:14, Akhil R wrote:
>> Use platform_irq_get() instead platform_get_resource() for IRQ resource
>> to fix the probe failure. platform_get_resource() fails to fetch the IRQ
>> resource as it might not be ready at that time.
>>
>> platform_irq_get() is also the recommended way to get interrupt as it
>> directly gives the IRQ number and no conversion from resource is
>> required.
>>
>> Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
>> Reported-by: Jonathan Hunter <jonathanh@nvidia.com>
>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>> ---
>>   drivers/dma/tegra186-gpc-dma.c | 12 ++++--------
>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/dma/tegra186-gpc-dma.c 
>> b/drivers/dma/tegra186-gpc-dma.c
>> index 97fe0e9e9b83..3951db527dec 100644
>> --- a/drivers/dma/tegra186-gpc-dma.c
>> +++ b/drivers/dma/tegra186-gpc-dma.c
>> @@ -1328,7 +1328,6 @@ static int tegra_dma_probe(struct 
>> platform_device *pdev)
>>       struct iommu_fwspec *iommu_spec;
>>       unsigned int stream_id, i;
>>       struct tegra_dma *tdma;
>> -    struct resource    *res;
>>       int ret;
>>       cdata = of_device_get_match_data(&pdev->dev);
>> @@ -1367,16 +1366,13 @@ static int tegra_dma_probe(struct 
>> platform_device *pdev)
>>       for (i = 0; i < cdata->nr_channels; i++) {
>>           struct tegra_dma_channel *tdc = &tdma->channels[i];
>> +        tdc->irq = platform_get_irq(pdev, i);
>> +        if (tdc->irq < 0)
>> +            return tdc->irq;
>> +
>>           tdc->chan_base_offset = TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET +
>>                       i * cdata->channel_reg_size;
>> -        res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
>> -        if (!res) {
>> -            dev_err(&pdev->dev, "No irq resource for chan %d\n", i);
>> -            return -EINVAL;
>> -        }
>> -        tdc->irq = res->start;
>>           snprintf(tdc->name, sizeof(tdc->name), "gpcdma.%d", i);
>> -
>>           tdc->tdma = tdma;
>>           tdc->id = i;
>>           tdc->slave_id = -1;
> 
> 
> Thanks!
> 
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>


OK to pick this up for -next/5.19? This is preventing the GPC DMA driver 
from working.

Jon

-- 
nvpublic
