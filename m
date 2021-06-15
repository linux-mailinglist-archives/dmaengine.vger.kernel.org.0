Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA353A7D4C
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jun 2021 13:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhFOLgZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Jun 2021 07:36:25 -0400
Received: from mail-sn1anam02on2068.outbound.protection.outlook.com ([40.107.96.68]:24442
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229972AbhFOLgX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Jun 2021 07:36:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQzZi6lMUBRs4Ooqy6Zvpu1J7eSAeUOpC+knp8eYSCHN3BA0EknSxempmIKzR3ZtKTcSB0eBAP3vZzauHNlDaC1JNwcx4BlRWYuo5Q9RxELZB9gkCAsB2atIpkMp8+XA7inGJX2Bw6PizQCraMoE1o+Wd7OHCBD4xZNzIC5gox0Ol98KbgyFTpiQOTTg+6ETZiZs51rFoG9VFpVOHcxTnS7A3YDl+v+RvpZ0g8vwTpq1/oJIzQD/gpdambbHmrVKYIw+CPv6O7rrtS0DuGuXDkHJIL9EjRLvh/Ct6AS9ECqiyPja7sjmnnCNlOBS+vGgpCvk3cXbw530dz5XXtgawA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Of4irOUOy0Yky3xY0LkeBbGdF7rGh/LwZdP9stZgDE=;
 b=XWIbx4EDLUJaUdwITE29Ybv7Jgpy10bMROCDRz8Z6NMspTY4knXkSMyMtJ6cd8Fw+g7Qlo4iOWY60xX0Ndz6Up/B+cT/MXh2+zMPN9LbU0CuvVU0CNO6IrMeTm/+MyRaiEycFo6Ai0/lxI0tbJo2cqgFfF+zs5zKL11X0oPD9R9WimcyCYiJ0quaHmZW5A34mjFLVWiB2/vIRmHu1Wi40HBFpcsJ0f3dM0JBgB5aW1MjFdwclLUi58xlYsE6O85rzB1SWbBKWZkhwIaA2TGEX/x5cJzDP2RRw2fnQoJPTmZ1DKIvcs69uKNZ5VtcuAv1pDHxjuy/VCh2BTKTJL+bFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Of4irOUOy0Yky3xY0LkeBbGdF7rGh/LwZdP9stZgDE=;
 b=xGhvt+wQeKOfDZzz5PlOWlRy31Raxkc4EYNLn20Q8GBE2SeR3Y2OkbYkankFL9u0Z0jUBsQHjGisRCVQJMQ6aLNWGwuE27xyM0rB5EBZ2tQ5fWRYgcMO7ywaVdHbRNDUcLIgmPMSaIv4dreDLp00eVoI5SQRRNSjywdHK03pihI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM8PR12MB5461.namprd12.prod.outlook.com (2603:10b6:8:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 15 Jun
 2021 11:34:18 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::e065:c90b:5f7:7e95]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::e065:c90b:5f7:7e95%6]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 11:34:17 +0000
Subject: Re: [PATCH v9 2/3] dmaengine: ptdma: register PTDMA controller as a
 DMA resource
To:     Vinod Koul <vkoul@kernel.org>, Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
 <1622654551-9204-3-git-send-email-Sanju.Mehta@amd.com>
 <YL+9Y8U8XQ2FSV8Q@vkoul-mobl>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <311d14a1-39f4-1aad-bce0-a64fee52d13b@amd.com>
Date:   Tue, 15 Jun 2021 17:04:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YL+9Y8U8XQ2FSV8Q@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: SGXP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::20)
 To DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.253.16] (165.204.158.249) by SGXP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Tue, 15 Jun 2021 11:34:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c213d07f-05be-47f8-eb9a-08d92ff1828a
X-MS-TrafficTypeDiagnostic: DM8PR12MB5461:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB54616925DEB6F06CA56E2ED1E5309@DM8PR12MB5461.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GiOUEfPPEV+qrrSdNV1Que8YfkhRQP16BDT+p/O3gDCWsQ4gvizb3RzUpK2jv2IQCGdY4NlIKeSvIomCp5E2Nf+fXzDmoinnzM+9j/C6KjZ98LLO639khLf7tfuk6hzQND3wFHspmtM8sX+4xJvMYze6NGmeJoKkpb4gtICT0Ldvs7tLyQlmb3LE93Gj1lQEnonFyUwRnRLNo7z+nN5y14NAQvFCdK0fowkaIka9BLItEwlR+HZ0mKjwdnuKxjZy/s4dfXjbhLIP3mM0iiWbz32/MG+gpvPp7bLeS9tiL+2GsULykk6qNZo5G+RXEy3lX7AEpsEX0oyXn3KDAmUL8b/VitpjkuSBjW+Zw2WU4P6UH40INYdqWVCgIdkclQDLOTGCnWjxxg5j2Kjs9C0VeuEzjRLx71p1aJFIgmBAfmYyBx5deXxQFP4CrMZwqZl7UwvWOyPvAi2wvkP9/UoKt6s8hMxb9w8xAn01S9pN9yzI5N36DXMnoTaL0f23lh6wtyBnG8IxupwZYB/phm0V6SkFUe1QmEccHSbR4wTxZB3pM2NQZvEyI9iy5sF974418MDcGKu1ayiwLjpeHNdwRqmkFWGF/pXVC+O8yA0m/Bxq9WMb3JlcfoPV0yAT0S8lAbuRPZ7AqyUm1HlUeesHG8aQyTzSgMUOBuw7K3F+IwBh2o49r+t30CYTA42kj+Rx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(5660300002)(66556008)(31686004)(66476007)(6486002)(6666004)(8676002)(26005)(2906002)(478600001)(316002)(38100700002)(186003)(31696002)(2616005)(956004)(36756003)(16526019)(4326008)(8936002)(16576012)(110136005)(66946007)(53546011)(83380400001)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym5iTmR0WDh6U3Jqd0I3dTMra2JZVzZBc01OdmM3cStKN1NpRnJsQURoZG5D?=
 =?utf-8?B?YW5HODFmOGlXeW5BN3pYbzFETlBZdFdOV1grb2NKaXR4YlRCZENpcEpGQTJI?=
 =?utf-8?B?MVFBMXdjTHVsaXBPMWFzSm5USzNVWHJueUU2cHg1Q3ZocGlXZ1owU0FpSG5N?=
 =?utf-8?B?TDBicUNCRVhaTzUyKzNyd1grYStHNmU0bGdFbFFZSU41MTJUcm95ZE1EemY1?=
 =?utf-8?B?MG9veVRXa3ZBendCZFpESTNRQ2ZyZW9KU0tTVURkeFlDU09ObjhDUDlUUmg1?=
 =?utf-8?B?QVBIVmdITG1TYzFNVzlNNjF1UUJ0bG9Bd0N1ZFNvWDB5YzFzNjFIV3pSZGhh?=
 =?utf-8?B?RWI5YkNCcjNwUHFDR2M4bDlpS1BZU2dOaFkwcW5DdGxhL21FMHM3THQxZ09y?=
 =?utf-8?B?ZGVHRTFuVjRpa3V2aVZ5Mk9pdXgyRVIvY0YzN1IweG5SUWYyTEtWVEFwaXM0?=
 =?utf-8?B?ZXN4bXdnU2wxMlBMUVNadzJUbFdFVXFUNEdOQm1VYkZJV3Rxd040Tkw2VHl4?=
 =?utf-8?B?MjBNYkc1Wmc4cGtVS05Jcy9qTmkrUlJLbmJuRmZWQU9RSEk5NSt3V3k0c2ZF?=
 =?utf-8?B?TkhvN0RwZ2xuUGpyRmhWUm9IeGppSVFsU0hndDlwSG5LSVNLeFNMSGdWSUFT?=
 =?utf-8?B?Nm9zekhXdXN2VWRyYWVRL0dsUFRzR2d1T1QxNzlydUtCMEFrTDZIRnRrbE41?=
 =?utf-8?B?TGVRVnN3SWRzVXllRS8xQ05YWXJkTHhwNU1kUGgvd3NSSWdGVGxsdENSYVQr?=
 =?utf-8?B?VVc3TDBGSUVZd0RDTllGTlp3MmdKeWtZZU5EOUFSUUlJY0FtNVdEbXFIU3J0?=
 =?utf-8?B?U1VlOEo2NkdFZ2p6YzlsU0JtUFZnS3BVSzIyTVArWlNYRTBUTlV4UDBHejVT?=
 =?utf-8?B?WmJqN0VnV3dYTUJGdVdDaHBGY3dPNGM4enE2bUR6MWFSTGVvQzdNOEp5WGdM?=
 =?utf-8?B?bkVQUDhicUEvY3V1UUYyUVloNDc5Q1FIT0s3MDFGSU5YK0h6aHgzRVNEZStD?=
 =?utf-8?B?bGQ0aTAxbGdseGhOKzcvZlB1cFA4bzFpaWJnYUZMSEJoK3RHYkRacThPbVZ3?=
 =?utf-8?B?bXhCK2YyNExOVnZXc2NrVnRucEhJejJURmgwc0gwb2l4N1g5SFJQK1g5bTJQ?=
 =?utf-8?B?eWNkdkJGTDVRdzdKN1dJT3FLREl5VXZIbzkrK0ZwOGYwMHdRMTlNOFYvQnIr?=
 =?utf-8?B?dWphSW4rdmVXc3V4d09ENWlEMzB6VHdRT01zbXBpUXhBVk1haCtFRE5ZV3BV?=
 =?utf-8?B?N3BFUkw1UjdBdHZLWVh5a0NTVDN4RmVXQjhnZ3VLdmdqREdJNWlNYVR6NGoz?=
 =?utf-8?B?Y2tQUndkdFU0eXVaRTlmUVBrcDAwVUpRcEZKWGw0VlhYSmRGenpZOUhQOWx4?=
 =?utf-8?B?WFNaS0ZoWHhqeDVrOW1mN2RyQXhLeS9UcXFQdmFTSjF0djB1eGFURnN5ZTYv?=
 =?utf-8?B?SFpLTmJ6c1U0MjBWMnM4dU1nWTFBNC9wNTB1TE5TYXNXdm1VczFkbTE1M2xD?=
 =?utf-8?B?bFFGSEhsc0FHMFRJNjFlWlYzb2VVU2tybnZXQXREZ3BWRm12Ti9sUzdhUDRx?=
 =?utf-8?B?WFhzVy9FREJJUThYRGoyWkpkM1NFN1VKNHJka3VHSHFFcTVLd1paM0pUWEt2?=
 =?utf-8?B?MUY3aE42QUFZQ2JvRTljeDk0YU1SYStVQW1PclJFU1NEck1DQ2Z2TmtRWEtj?=
 =?utf-8?B?d0pmMUZjYWV5MkhvRkpVMXFtakRYMkQvTHIrZUNGMEJUK3BZQWZBZ0Z3d0dO?=
 =?utf-8?Q?qCgPrYWbWoqiDFcZOX95axZpt+eirfKMONddEXC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c213d07f-05be-47f8-eb9a-08d92ff1828a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 11:34:17.8141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xysOEvbu/lR2/bG4l7pBqTrOaqrJzQmvPYgJQAfBwCMK1W6pWCY7PzXlRnpRcS6ps/0TvkLMG323JUPD5aDnnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5461
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 6/9/2021 12:26 AM, Vinod Koul wrote:

[snipped]

>> +static struct pt_dma_desc *pt_alloc_dma_desc(struct pt_dma_chan *chan,
>> +                                          unsigned long flags)
>> +{
>> +     struct pt_dma_desc *desc;
>> +
>> +     desc = kmem_cache_zalloc(chan->pt->dma_desc_cache, GFP_NOWAIT);
>> +     if (!desc)
>> +             return NULL;
>> +
>> +     vchan_tx_prep(&chan->vc, &desc->vd, flags);
>> +
>> +     desc->pt = chan->pt;
>> +     desc->issued_to_hw = 0;
>> +     INIT_LIST_HEAD(&desc->cmdlist);
> 
> why do you need your own list, the lists in vc should suffice?
> 

Do you think this should be a major blocker for pulling this series in 5.14?
Would you be okay to accept this change in the subsequent driver updates?

>> +static int pt_resume(struct dma_chan *dma_chan)
>> +{
>> +     struct pt_dma_chan *chan = to_pt_chan(dma_chan);
>> +     struct pt_dma_desc *desc = NULL;
>> +     unsigned long flags;
>> +
>> +     spin_lock_irqsave(&chan->vc.lock, flags);
>> +     pt_start_queue(&chan->pt->cmd_q);
>> +     desc = __pt_next_dma_desc(chan);
>> +     spin_unlock_irqrestore(&chan->vc.lock, flags);
>> +
>> +     /* If there was something active, re-start */
>> +     if (desc)
>> +             pt_cmd_callback(desc, 0);
> 
> this doesn't sound correct. In pause yoy stop the queue, so start of the
> queue should be done here... Why grab a descriptor?
> 
>> +static int pt_terminate_all(struct dma_chan *dma_chan)
>> +{
>> +     struct pt_dma_chan *chan = to_pt_chan(dma_chan);
>> +
>> +     vchan_free_chan_resources(&chan->vc);
> 
> what about the descriptors, are you not going to clear the lists and
> free them..
> 
>> +int pt_dmaengine_register(struct pt_device *pt)
>> +{
>> +     struct pt_dma_chan *chan;
>> +     struct dma_device *dma_dev = &pt->dma_dev;
>> +     char *cmd_cache_name;
>> +     char *desc_cache_name;
>> +     int ret;
>> +
>> +     pt->pt_dma_chan = devm_kzalloc(pt->dev, sizeof(*pt->pt_dma_chan),
>> +                                    GFP_KERNEL);
>> +     if (!pt->pt_dma_chan)
>> +             return -ENOMEM;
>> +
>> +     cmd_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
>> +                                     "%s-dmaengine-cmd-cache",
>> +                                     pt->name);
>> +     if (!cmd_cache_name)
>> +             return -ENOMEM;
>> +
>> +     pt->dma_cmd_cache = kmem_cache_create(cmd_cache_name,
>> +                                           sizeof(struct pt_dma_cmd),
>> +                                           sizeof(void *),
>> +                                           SLAB_HWCACHE_ALIGN, NULL);
>> +     if (!pt->dma_cmd_cache)
>> +             return -ENOMEM;
>> +
>> +     desc_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
>> +                                      "%s-dmaengine-desc-cache",
>> +                                      pt->name);
>> +     if (!desc_cache_name) {
>> +             ret = -ENOMEM;
>> +             goto err_cache;
>> +     }
>> +
>> +     pt->dma_desc_cache = kmem_cache_create(desc_cache_name,
>> +                                            sizeof(struct pt_dma_desc),
>> +                                            sizeof(void *),
> 
> sizeof void ptr?
> 
>> +                                            SLAB_HWCACHE_ALIGN, NULL);
>> +     if (!pt->dma_desc_cache) {
>> +             ret = -ENOMEM;
>> +             goto err_cache;
>> +     }
>> +
>> +     dma_dev->dev = pt->dev;
>> +     dma_dev->src_addr_widths = DMA_SLAVE_BUSWIDTH_64_BYTES;
>> +     dma_dev->dst_addr_widths = DMA_SLAVE_BUSWIDTH_64_BYTES;
>> +     dma_dev->directions = DMA_MEM_TO_MEM;
>> +     dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
>> +     dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
>> +     dma_cap_set(DMA_INTERRUPT, dma_dev->cap_mask);
>> +     dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
> 
> Why DMA_PRIVATE ? this is a dma mempcy controller ...

This DMA controller is intended to be used with AMD Non-Transparent
Bridge devices and not for general purpose peripheral DMA. Hence marking
it as DMA_PRIVATE.

- Sanjay
