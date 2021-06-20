Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248CF3ADC79
	for <lists+dmaengine@lfdr.de>; Sun, 20 Jun 2021 05:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhFTDym (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 19 Jun 2021 23:54:42 -0400
Received: from mail-bn8nam08on2085.outbound.protection.outlook.com ([40.107.100.85]:1691
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229591AbhFTDyl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 19 Jun 2021 23:54:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0RCg3uBttfo6BPmTVnVZMBsQ0LFPEjTbqOYBqELIlLoqJqYHFYJ5Fhp+KuWdYm2ekNwRvwgUJz0SeLE/UfoIGseZsPFLKEZDyVFo/WMkksH8YQP/jyjPPElKM/av39scnjy03Q5OCylawzjPI+VLyM82mYIWc+hl6mZrohabTBWZ2gozuFRaeCt1HMNPMQKTVcX56lsM5um7+J/87doAXIR6mQRkGXHndVFT/CeyhyLt5scrby5BzQAVKnRG96leSMq5ytA3OcIyIQ9gWZivgFocjmBqV+XzqJt/+RMWVRke5VD+ONtWumwQtpflhjjy86PdoHjeT/Cp2EkCHba+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcgasTdIvLxv5I7tgliqpBFxvrNaiAULlggF0C2/s/k=;
 b=W9XDh6bSgIo6XEZVKDrQQwsSnt06MnWbpIwYYgHU4q+Qew8SIZgjZm3Im5C/uLmhEKPSsJr2b4uxukPXWFhGkUyAI3wcLQnP7OZ/5sk4zargvYbHK4kAP0cD44pphkBlpRQSopUFiTa1wEJqXfW9T+J45F8Mho/6aaTNB5OiA9Shp72V53fqSa4K9K0I6x7hAhYGfkeagGONz51sqpVJUkgWZeEJkBx3VvVpEqnK225w8XISIXr+LEaaQbF57ra0yspOAJsNI/ur6i051DQtKR9ju4QS52VHYBEJhU3Il2kzJJtxcht2Df8n0bdvtIHiXnHRPG1qj/HjHeCVHAkf+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcgasTdIvLxv5I7tgliqpBFxvrNaiAULlggF0C2/s/k=;
 b=F6sE3JDPxcZrMgKsYmuXHhFJjVN0yvK/BDxqTGE6GhkE/3SY5p/voOgVF2otEPZce9UqwM0Bk7Kg8ZmlEhuqFAo7l8jhi/FehTaJGL6Ex0nPUcPQQcLlg5E55WVnRF3o05Dhgfu89M4F1mZqIJa5/KuL8h4ANAhKf4ePcFkKdbo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Sun, 20 Jun
 2021 03:52:26 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::e065:c90b:5f7:7e95]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::e065:c90b:5f7:7e95%6]) with mapi id 15.20.4242.023; Sun, 20 Jun 2021
 03:52:26 +0000
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
Message-ID: <60c19d95-88c6-4a5f-e87c-88f3d32ea30c@amd.com>
Date:   Sun, 20 Jun 2021 09:22:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YL+9Y8U8XQ2FSV8Q@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: BM1PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::31) To DM4PR12MB5103.namprd12.prod.outlook.com
 (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.32.35] (165.204.159.242) by BM1PR01CA0091.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Sun, 20 Jun 2021 03:52:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41bda956-a747-494e-ef15-08d9339ed180
X-MS-TrafficTypeDiagnostic: DM4PR12MB5374:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB537450860499A477421D9D32E50B9@DM4PR12MB5374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:403;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +LnCAvLwCJsp1pnqWmBSpo3dUtR9YjapTBCViXLot4rHba8JxTq3AgnowSV7iN/O+ldBdBOiYoqgVJ7xr7eIkNs7Cmx2DDjsxD1fclxcL0hej1n9NPIFA7bkHxLJBk+LXZhjUVt6VhO7gPTMiKnzMh7EdEYcwmujysUTo970AtPuWHVve4d+slvwKa1gDpQRy0lUM4+U+PWszBdgeZc2Ci1nY1UTxM08tD4Pq88cmMlg9+VP37VBUaYFSxx1uqxJ24+UymnX+SzlgRGFtBFqC3pkEcfpaUNYVV5RsIjjFfS//rhY+bLg9I/N98nXxV1MXHu15bdMUtmGTgTMb+g89SdylmXrz70ux7/hk6yYEviOBC/4D/JDdVJJ8i6jKS2i17HHu8DsWUfjDF5QwDBwcXevaSIWpfJglgedXpPTHrwozlYy9w39TpZB/sEaWlcwUSprxCYgtVxjq98geMuJxpQf7RqR2yX0WryBOGfjcfh60CyArTsQl5pwKGIMhB5UjZqdWOoAlMoysQI0RAm2LvgIqtYMgQzDeR+dWQ0oGXuP/PteghrjluuuEotHYP4Ykk07U5d8FfILvhezHs+hEy2m65M3Lljq4xOgbrOX3tQPTnCGRJREx3Q663B9q8IdRKLOYnOB0Qtlzgy5MgEUgb65Qju4cz4S3dtNlvh3MkjykhlW3EMRAAvUNDGSZ+Ky
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(6666004)(31686004)(2906002)(38100700002)(956004)(4326008)(5660300002)(186003)(26005)(8676002)(83380400001)(6486002)(66946007)(2616005)(8936002)(66556008)(110136005)(16526019)(6636002)(16576012)(316002)(53546011)(31696002)(66476007)(36756003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFkyMTA4TmZWOGs3U2p0c0lVZ2JGRkZUNlU1bWtDUzkrb0lOTU1zd0tSRVlE?=
 =?utf-8?B?NEVGUHlEME5wd0hHaDI1QVFGU2lZQ3FEYWpTR1lSRVVwN3F2YnFNVGt0YnpW?=
 =?utf-8?B?aVY2T2RhWmgvUXhJeGxFeFlTQUUxU3prdURGSFlHdHhlK3dOcUFvM05DR1l4?=
 =?utf-8?B?N0l2OXJNeXAzdiszUWZXNjF5TWZjWUt6eS9EZDRVY1M2MG1YeGR3OTlMSlRp?=
 =?utf-8?B?UWkrU3l0a05HMHlheTRoV05RVWVrNVFXZExLdDhNOHR3TlR5TTU3ZEpyc3pW?=
 =?utf-8?B?Z3NIbnNBSEJQcExqUTQvUXFvL09PTGZ5RVVDYXVHQ1RrZDM4WVphMGFFczhq?=
 =?utf-8?B?NFhKTDNYbWExYk5VaVJhcW1UeUYvT1ZUV3dCeWRXdFlXRGZ1eEtZeUxvb1lV?=
 =?utf-8?B?RlRoZDcxOHRGMFBkTkhDMkV6K3F4Tm41dXcrWXRZNVoxYURVQnpqeXRaQUtn?=
 =?utf-8?B?bnFQcXErdG0yRU1VYW5MRkNPUXFzdmRIVDNpMXF6Q1pldG1JMVpxL0tBclpK?=
 =?utf-8?B?UVdKaDZ1SXBYNk40dTBmTkc4WTdpN2lWelE2Y1hBMGJONk45YVhIVnUrNjIr?=
 =?utf-8?B?L1NobUdiaDRKOTIyZ21wazZrK3FwMFdSK0pxSzRlU29aWUhzbVlCR3JZNzk1?=
 =?utf-8?B?b0FIOE1wMzR5eHo3ajZFckx4ZXMrZ0FYYmVlYTNBOEd3ckQ0RXp2Z2M1OVJk?=
 =?utf-8?B?RkJXeVV5M0FzbnlSSXFoa3I1UEt3YkZoZldBOTgzcUNPd3lPUVo5T2hNN1R4?=
 =?utf-8?B?VG5kNW0rcEVMZkZHSDNRblNqUGpBbE5EMWpMeGxNS2RyR01zQ0JpbW45bVRt?=
 =?utf-8?B?b0FwSUFjdzFTTk81NlhuSFdkbDdjSUVuc1gyM3BBSmxMUHIvYVdEelJjVlJy?=
 =?utf-8?B?VGhydlN5dnZDSzlIMzZJY2I2N28yRnBCTzlxS1lqNG03OHdyTUpDamxBcnJh?=
 =?utf-8?B?WFA3U1Nva24rMGd2M1I3RjZjeXVtekF0TVBRakVGUXg5aDRKWnBpdFVma213?=
 =?utf-8?B?Zm14ZHIwM29WYjh5RFY0ZHhHYlVOTnoxSkpyWStEcE1uU3JrZHJ1Zm5XQ1lV?=
 =?utf-8?B?Nnk0em5pRWZySC9GdDRSRmFCRkxieUw1WWY4NTZXY2JOVkw3aGd4cllFUi9o?=
 =?utf-8?B?cURHdldZWGNpdTdSQWtMaVc3c2dER2MxZldFSHB0b3NrM0FtTXoyQ3IzWUsv?=
 =?utf-8?B?aVMzM0NXZ3NzY2F1VXppV2VTY3BzN1ZQNkVzTXlJN3ZXbDVWaG1GclF6ZVhn?=
 =?utf-8?B?b3YrN2gzQW5SRkl5WTRobENaMUxNckdubGRlb1Bqdzc4K3VkUXZ6RFJnOHU4?=
 =?utf-8?B?eDBsc3RKelZsNFJjVHB6b2EwVmZJVDUrbUpoOFlwbnJ2ZmFvWG94dCtGSlMw?=
 =?utf-8?B?SFNmZUhQRHQvcy9VZUFxTmpwQWRyRXBnZHI0b09KVGNVMEI2TkdOcHgzOHVH?=
 =?utf-8?B?ZHI0TUs0c29keVUxUHo3M3grZHE3SXVkS1JiRS9KN1ZsV216UWhJRktabmJS?=
 =?utf-8?B?UFJpbm5HZVQ1WjRTT1VoZzRjVWJvMFBhVUlVWll4bStvd28xUVQ5SVNDTGYw?=
 =?utf-8?B?eUIwb3FzT2o5WjNpcjdRZnZFTlVuckRQMkVLL1ByOHJCOTVVdXArbXV1aU1E?=
 =?utf-8?B?NkN0OHpHNUpPU3VpZ1NZZjNMQ2s5OGJ4Vkw5Sk1XMjlYYUFuM2pkSUg0Y1g3?=
 =?utf-8?B?dHpTSXA1VytsYXdHY09kaExTMys4ZTQyN1o0TjZtUjQ0TkM4NVpKcU5VRXdj?=
 =?utf-8?Q?CiAlKNCYgkAiJn9zxIgjoAQSwIOoXhxjOZmcmUi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bda956-a747-494e-ef15-08d9339ed180
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2021 03:52:26.4822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZeafUoRp3sytHFys2OHLkuOhEk9x4Wz1O5zgnBtJSgCK4dQtZhZ4BG1ANdgYq6jKhTTAKbmchXKwT8mS8cZLGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

I have addressed all the feedback provided by you. I will be send the
update in the next version of this series.

On 6/9/2021 12:26 AM, Vinod Koul wrote:
> [CAUTION: External Email]
> 
> On 02-06-21, 12:22, Sanjay R Mehta wrote:
> 
>> +static void pt_do_cmd_complete(unsigned long data)
>> +{
>> +     struct pt_tasklet_data *tdata = (struct pt_tasklet_data *)data;
>> +     struct pt_cmd *cmd = tdata->cmd;
>> +     struct pt_cmd_queue *cmd_q = &cmd->pt->cmd_q;
>> +     u32 tail;
>> +
>> +     tail = lower_32_bits(cmd_q->qdma_tail + cmd_q->qidx * Q_DESC_SIZE);
> 
> why extract tail in non error case?
> 
You are right. it is unnecessary in a non-error case and I will correct
it in the next version.

>> +static int pt_issue_next_cmd(struct pt_dma_desc *desc)
>> +{
>> +     struct pt_passthru_engine *pt_engine;
>> +     struct pt_dma_cmd *cmd;
>> +     struct pt_device *pt;
>> +     struct pt_cmd *pt_cmd;
>> +     struct pt_cmd_queue *cmd_q;
>> +
>> +     cmd = list_first_entry(&desc->cmdlist, struct pt_dma_cmd, entry);
>> +     desc->issued_to_hw = 1;
> 
> Why do you need this, the descriptor should be in vc.desc_issued list
> 
Agree. I have removed the dependency of cmdlist everywhere from the code
and used the vc.desc_issued instead.

>> +static void pt_free_active_cmd(struct pt_dma_desc *desc)
>> +{
>> +     struct pt_dma_cmd *cmd = NULL;
>> +
>> +     if (desc->issued_to_hw)
>> +             cmd = list_first_entry_or_null(&desc->cmdlist, struct pt_dma_cmd,
>> +                                            entry);
> 
> single line pls and use lists provided..
> 
> 
>> +static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
>> +                                              struct pt_dma_desc *desc)
>> +{
>> +     struct dma_async_tx_descriptor *tx_desc;
>> +     struct virt_dma_desc *vd;
>> +     unsigned long flags;
>> +
>> +     /* Loop over descriptors until one is found with commands */
>> +     do {
>> +             if (desc) {
>> +                     /* Remove the DMA command from the list and free it */
>> +                     pt_free_active_cmd(desc);
>> +                     if (!desc->issued_to_hw) {
>> +                             /* No errors, keep going */
>> +                             if (desc->status != DMA_ERROR)
>> +                                     return desc;
>> +                             /* Error, free remaining commands and move on */
>> +                             pt_free_cmd_resources(desc->pt,
>> +                                                   &desc->cmdlist);
> 
> single line again
> 
Sure. I will addressand send in the next version.

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
Agree. I have removed the dependency of this list everywhere from the code.

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
The start of queue is already done here.

If there was any active descriptor when pause occured, that is needs to
be started again during resume. Hence getting that descriptor and
restarting the transaction.

>> +static int pt_terminate_all(struct dma_chan *dma_chan)
>> +{
>> +     struct pt_dma_chan *chan = to_pt_chan(dma_chan);
>> +
>> +     vchan_free_chan_resources(&chan->vc);
> 
> what about the descriptors, are you not going to clear the lists and
> free them..
> 
Agree. I will address this by clearing the lists & free them and will
send the update in the next version.

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
Sure. I will address and send in the next version.

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
> --
> ~Vinod
> 
