Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E99F3A9121
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 07:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFPFZy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 01:25:54 -0400
Received: from mail-mw2nam12on2053.outbound.protection.outlook.com ([40.107.244.53]:42920
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229476AbhFPFZy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 01:25:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQxStCpyHcqGOpsGRVH3nLuQfj2+xDfDeUJhznN4I/4KYyDPoK0kMHoF2CspOYOjAYtTyGiLw2faCLhocKgHceEjZLVw/xSukuiVF/7JLqreK2tOrCBeVH1UY4GwRegaUfMjtCbODsIqyS5aqtoBC622swLHmvHtJ6SqA/wabTiZZ5efki1aGyFKyIB8x6LfMrM/R9OxaDBcD6aBrjtVqMCLCvgELOGVAvmnrwKDRnWSC2TB7EU0HjbmW/XcPRagHIX5FGVhoEu6majAN17dZScP/2urIq60BgDlNCw5etHjohiUoQJLB+mBYuuJvph//fAIOHsa7MuyicIDSSSpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/4N8dVOWf3d5Y7LwZuyBg7HD49iLfKlNbjZNsvP5c8=;
 b=A/YstmU2mw0fEzce+g98fLQASBjlWDgfkN5gcBikf75WZr2Wfc23mW54ISSXLDAP7938WXpN9pN1vyJKWg6WdtiE7yy2eXQaS0W/qZYE9AxZOaBZvaS9+rLKhdbZtzRk8Io0IPXez9O99zWasRBsgy0RRe5KyjC1XgX44oThhMl6zg3EJz4G0VhIm5glq6Pdd1qNfmeP/tdcRFWSXQs5FpDdp0i3ZX8v47TCginvV4wbqa5W0R4bKoIF2bVbEkuzBesPRStv19V7dpfJgS5hOjZbSvfhMGFwrSRbbgCojLVLl8QTYP+CISi1wnD0qTErNM05Xu9i0PCfOaAcTkZ8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/4N8dVOWf3d5Y7LwZuyBg7HD49iLfKlNbjZNsvP5c8=;
 b=h0ShMJn5h39qyfYfsUiPopDzdQ/SdUYVW6kGSbpLq9B5ik8Nvt0aMEOOw+6SOLz8TZHMeE44N0XmJFyf238gUVspe/R1PwHwK099JPQfxEiAazMD3gYAhx4DgFBTEIaQfRM9BFKM3GqyGuAMiISdj1Dv+OOsqw+YFXY7dYeM2qA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 16 Jun
 2021 05:23:47 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::e065:c90b:5f7:7e95]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::e065:c90b:5f7:7e95%6]) with mapi id 15.20.4242.016; Wed, 16 Jun 2021
 05:23:47 +0000
Subject: Re: [PATCH v9 2/3] dmaengine: ptdma: register PTDMA controller as a
 DMA resource
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
 <1622654551-9204-3-git-send-email-Sanju.Mehta@amd.com>
 <YL+9Y8U8XQ2FSV8Q@vkoul-mobl> <311d14a1-39f4-1aad-bce0-a64fee52d13b@amd.com>
 <YMl7f/nNRMUgFDyq@vkoul-mobl>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <22205182-198c-da65-b907-357280dff463@amd.com>
Date:   Wed, 16 Jun 2021 10:53:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YMl7f/nNRMUgFDyq@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [223.226.125.202]
X-ClientProxiedBy: MAXPR0101CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::13) To DM4PR12MB5103.namprd12.prod.outlook.com
 (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.6] (223.226.125.202) by MAXPR0101CA0027.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 05:23:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5adf44a-99e1-434b-f1b1-08d93086ead3
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB522985DDDEBA7191667F4859E50F9@DM4PR12MB5229.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOF4knaS3hhffgZFBK8JbCL9XQrq45XIyEXM4HmXzG0Xox6zTQIs53Lfy7LmdUvVzeiDseWU22xST/ofkoM+aij7c4FVPszh/zgl3ef1X8+uhzQOa444+pW03F58EP13Ga9/ItSXs7isRIitQ6dgbs3cTDuco6FuYn8hmZiGyn4fJd+ELFC6LtzNmYIJjLMljKnKxqVzMVP/SOIJciTSgGGa0cU83gfY2G8Zd/DvBE3GnCCL6VhbqiFRMP7aSHgOJHmRHJyJGkFNMhgf/TI0Bwm8cMa3a7gb4IiNSzoRk2Dot8J7vTE207oB5uqhU3b3giqbjOCHUE+Q0gdY9MVCf87iZC1aIPWi2nDrz18SkqbyJ9XPIoqhXrBtzZooxzQUDaasDm/HZdItlqcn0aZ+mO7dqCtSdM5chOzSh+M3r/MdFarE1TFJnVVGQ8lf5mOdWi89Zsixn1eH+eE2Ln/LOwGR2LNImRrqVLre3U0FEPawplHWn7qcDkTUKoQidtwu0xEmJwWXaQYqPvxXo+H0L0Zl+XlkjabtKYfwO2+Ays3Dd93yxJp3TlaulBzMLtcpx2+/uXum8IBnmtcY+MYNKmUMaYW7F4wTW/RR7qRQ9j7xv48fTcCt6qvrrBmrV7XlWoniU8thzQIr5ZD1LPZA0CLGsALY6xyP+IbMVyqWZuBs6VW9ksdPPD7Nel4HCRbV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(8676002)(16576012)(8936002)(36756003)(83380400001)(316002)(38100700002)(31696002)(186003)(26005)(16526019)(53546011)(55236004)(6666004)(6916009)(5660300002)(478600001)(2906002)(66946007)(956004)(2616005)(4326008)(66556008)(66476007)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cllHRXh3Q3IvdnQvbHFqMFUxWnJFTEJtamIvcnFJclZ4NTBUcnJyZDZXZFpR?=
 =?utf-8?B?b2JTQ09RMkIxbnppaExUaDQxRXJYY29QTFc5S3NRbThnZ1FGZXZIR0tCWmJ3?=
 =?utf-8?B?a0FISmJyOVdOZ2V1dWxXVktYWG1ja3lhQ0V2TU1MM3N6QkFVUVExS2xmbXJj?=
 =?utf-8?B?WmYyU0VGR0FzQ2lFN3NkZEFZbWhFdENVVGkwMGdjdm5xTmhuTSt3YjhLK1Bk?=
 =?utf-8?B?MkNwd0lLbkJ4czAzM2VRY2l1SG5MVFloVVlIV3IzWVNuK1dnZDJ2MTFxTWc3?=
 =?utf-8?B?UEV6U2E1Y1Q1K3cyNk1yb2FPUitUd0Z1bFc0b3A4L0xjUHdHeURpMnBnNFFs?=
 =?utf-8?B?WXJ5dzJIZno0QU9kZ0kwK3FMZGlOWi9ZYUNSZEhDWHZwbXNvYUl2clJ4TTh5?=
 =?utf-8?B?UW1LSVBBdUFRQW1YYWxJcmoxdVd5empIcTlMUXNJWkVNMzdtTisvaldWdHRR?=
 =?utf-8?B?dkc3UEp3c2lRSGFTUWVkTGpqMlJoZ2hJRVQwUzZmN01uejMzVVdoZU5pNnhi?=
 =?utf-8?B?eEVpZEpJZThja09neDRUcVJpa21jRXI4Y0JyaVhPUlI0Wkw4VDZWa3dtTFg4?=
 =?utf-8?B?bERCNFpSU1pyUGl0OE51RjVRNzQwSzk1QlZxSUhiTFo1UkZFSkZjMm9QRi9F?=
 =?utf-8?B?Zy80cmJpcWM0MUVnSFBYY1Q3R0gyTk80d3lob3l6U2NnYUM4SGdaR05oZHk4?=
 =?utf-8?B?MlMrSEwwUWhWQW1jN1pib3FMaEw1M2w2VlJCRXR3QWRoeFRadU1RN2V2RFA4?=
 =?utf-8?B?WUF5eU1PeGh3elZUaTJ6ZnVFM0hHbDcvQnNrOVFlRGYrbW51aW1zcjRNb2J5?=
 =?utf-8?B?a3owUlZ3bTc4S3IyVytuMDFDNTY1eVFybHc2b01hVWxrTjFoK3NyY21UbzNH?=
 =?utf-8?B?bG05ZmFiUW1hbVI3MXZ3YkRVNXVxaUp0ZjdYMjRGODNVYjdqMkFyaVBRU0tG?=
 =?utf-8?B?RE90ekFPN0pQSHM1OERPY21zOWZSTXRIM1hCM2RTdXZ5WFVzUUlCK0ZERG8v?=
 =?utf-8?B?K21KdEQwOGNrWlRKUU0xUWxPMFBQYlEvU1N5Y3FVMjJ4RE1KbStEK1VGaEpS?=
 =?utf-8?B?aGdKK1pCMGpHK1dEazUyMDh6aitaY2prV3A3Y3QrKzc2TEZZWjY1WWlOamtu?=
 =?utf-8?B?UUF1Tk9iQUdkWEJSdGd1dldCa2JCTnhtQTEwOWorODVpSFliVVM3SE10Wjl6?=
 =?utf-8?B?dDFJR09iTFNBQ3l1c3FQSzlURUpadDRiZU1yMjh4aTh6NENMUjczQnJHU1pa?=
 =?utf-8?B?MDF4TGRXWU51TmtMQUgwL1lpcExWcHBLcVZzcFdJb0h2dnp2ZWF3SUNMd25J?=
 =?utf-8?B?VDJmb1JUWGlIanQ5T21Ub09tSDlKY2l5dWpHd0ZFRVVvMDN2cW41KzM2TGpn?=
 =?utf-8?B?TytkOU1MQThQQW4xTFJob3lKL3JoVlhIVElXdXdBZUgvWG1tbXhWcnNpb0Z4?=
 =?utf-8?B?UjhONHNMcWVJcldqR3R6RFZSbTNmWEZjaCtPSW5nRTcxVFJGK2xjbERKeUt2?=
 =?utf-8?B?Qyt6NHlkemRkdjNlWG5LMy81NjNzakVTaWpEU04yb2tUY2lrRHZTRzFYZjla?=
 =?utf-8?B?eVJoM3ZFV2hZWjdEUnByTFBUYXV6WnZuM1NSWUNCa0F1SGo5L0QwR3VxVGUr?=
 =?utf-8?B?V3JKaEZ4ejgvTE1LbHpERlQ4bnpxOGIraU1vQ01zVWx4RXowb1U3aTRxdXR1?=
 =?utf-8?B?K0laSTNKYW1jQXk0c2kxaGtRdmNlQnZSdGYxLzBPaFhvc3dOVHdRY0htZTY3?=
 =?utf-8?Q?coNNJX+6BtlyctPhW1qqQe7di9V+8iLsw38XFqL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5adf44a-99e1-434b-f1b1-08d93086ead3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 05:23:47.6510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJPSZa9nNvmTYJFEty/a9np8izmUyDPPuYT+29vYZN2+EFcWWR4qATwz744abd3EcAIJipfSoFyQjKtmIjN3MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5229
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 6/16/2021 9:48 AM, Vinod Koul wrote:
> [CAUTION: External Email]
> 
> On 15-06-21, 17:04, Sanjay R Mehta wrote:
>>
>>
>> On 6/9/2021 12:26 AM, Vinod Koul wrote:
>>
>> [snipped]
>>
>>>> +static struct pt_dma_desc *pt_alloc_dma_desc(struct pt_dma_chan *chan,
>>>> +                                          unsigned long flags)
>>>> +{
>>>> +     struct pt_dma_desc *desc;
>>>> +
>>>> +     desc = kmem_cache_zalloc(chan->pt->dma_desc_cache, GFP_NOWAIT);
>>>> +     if (!desc)
>>>> +             return NULL;
>>>> +
>>>> +     vchan_tx_prep(&chan->vc, &desc->vd, flags);
>>>> +
>>>> +     desc->pt = chan->pt;
>>>> +     desc->issued_to_hw = 0;
>>>> +     INIT_LIST_HEAD(&desc->cmdlist);
>>>
>>> why do you need your own list, the lists in vc should suffice?
>>>
>>
>> Do you think this should be a major blocker for pulling this series in 5.14?
>> Would you be okay to accept this change in the subsequent driver updates?
> 
> Sorry that is not how upstream works, I would like things to be better
> before we merge this
> 

Sure Vinod, I will fix this and send the change in next version.

>>
>>>> +static int pt_resume(struct dma_chan *dma_chan)
>>>> +{
>>>> +     struct pt_dma_chan *chan = to_pt_chan(dma_chan);
>>>> +     struct pt_dma_desc *desc = NULL;
>>>> +     unsigned long flags;
>>>> +
>>>> +     spin_lock_irqsave(&chan->vc.lock, flags);
>>>> +     pt_start_queue(&chan->pt->cmd_q);
>>>> +     desc = __pt_next_dma_desc(chan);
>>>> +     spin_unlock_irqrestore(&chan->vc.lock, flags);
>>>> +
>>>> +     /* If there was something active, re-start */
>>>> +     if (desc)
>>>> +             pt_cmd_callback(desc, 0);
>>>
>>> this doesn't sound correct. In pause yoy stop the queue, so start of the
>>> queue should be done here... Why grab a descriptor?
>>>
>>>> +static int pt_terminate_all(struct dma_chan *dma_chan)
>>>> +{
>>>> +     struct pt_dma_chan *chan = to_pt_chan(dma_chan);
>>>> +
>>>> +     vchan_free_chan_resources(&chan->vc);
>>>
>>> what about the descriptors, are you not going to clear the lists and
>>> free them..
>>>
>>>> +int pt_dmaengine_register(struct pt_device *pt)
>>>> +{
>>>> +     struct pt_dma_chan *chan;
>>>> +     struct dma_device *dma_dev = &pt->dma_dev;
>>>> +     char *cmd_cache_name;
>>>> +     char *desc_cache_name;
>>>> +     int ret;
>>>> +
>>>> +     pt->pt_dma_chan = devm_kzalloc(pt->dev, sizeof(*pt->pt_dma_chan),
>>>> +                                    GFP_KERNEL);
>>>> +     if (!pt->pt_dma_chan)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     cmd_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
>>>> +                                     "%s-dmaengine-cmd-cache",
>>>> +                                     pt->name);
>>>> +     if (!cmd_cache_name)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     pt->dma_cmd_cache = kmem_cache_create(cmd_cache_name,
>>>> +                                           sizeof(struct pt_dma_cmd),
>>>> +                                           sizeof(void *),
>>>> +                                           SLAB_HWCACHE_ALIGN, NULL);
>>>> +     if (!pt->dma_cmd_cache)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     desc_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
>>>> +                                      "%s-dmaengine-desc-cache",
>>>> +                                      pt->name);
>>>> +     if (!desc_cache_name) {
>>>> +             ret = -ENOMEM;
>>>> +             goto err_cache;
>>>> +     }
>>>> +
>>>> +     pt->dma_desc_cache = kmem_cache_create(desc_cache_name,
>>>> +                                            sizeof(struct pt_dma_desc),
>>>> +                                            sizeof(void *),
>>>
>>> sizeof void ptr?
> 
> This and many more comments are left not replied, do you agree to them,
> do you disagree, hard to tell from silence..
> 

Yes, I agree with all other comments and will send the changes in next
version of the patch series.

>>>
>>>> +                                            SLAB_HWCACHE_ALIGN, NULL);
>>>> +     if (!pt->dma_desc_cache) {
>>>> +             ret = -ENOMEM;
>>>> +             goto err_cache;
>>>> +     }
>>>> +
>>>> +     dma_dev->dev = pt->dev;
>>>> +     dma_dev->src_addr_widths = DMA_SLAVE_BUSWIDTH_64_BYTES;
>>>> +     dma_dev->dst_addr_widths = DMA_SLAVE_BUSWIDTH_64_BYTES;
>>>> +     dma_dev->directions = DMA_MEM_TO_MEM;
>>>> +     dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
>>>> +     dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
>>>> +     dma_cap_set(DMA_INTERRUPT, dma_dev->cap_mask);
>>>> +     dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
>>>
>>> Why DMA_PRIVATE ? this is a dma mempcy controller ...
>>
>> This DMA controller is intended to be used with AMD Non-Transparent
>> Bridge devices and not for general purpose peripheral DMA. Hence marking
>> it as DMA_PRIVATE.
> 
> Okay, maybe add a comment so that people would know
> 

Sure. I will add comment here.

> --
> ~Vinod
> 
