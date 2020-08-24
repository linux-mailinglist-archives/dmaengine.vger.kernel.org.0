Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5777724FC59
	for <lists+dmaengine@lfdr.de>; Mon, 24 Aug 2020 13:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgHXLNm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Aug 2020 07:13:42 -0400
Received: from mail-eopbgr690085.outbound.protection.outlook.com ([40.107.69.85]:45126
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbgHXLNg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Aug 2020 07:13:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlIk1BdmdmIyrM4XvfV6jrsEmcxyC5e92EVtJw9R/G5ndTPrU0V2KlEk3Othh4dhSWwv4wTXp7D6V+prhJHm0+9TalIswWC7+qGmGeyV1JC3lRk9KjIBmJjcSeAuqJNqhDGUG2vDea4htL56HhQn5sbm0TmOaLwu21ceQjqTTNknOYafh7a2Q0iXTtVlvNUtgQUv1JKk0QS752CBYZzCUvxez01eqQyFs2eOZmzkUiApeLn47br+Ux0K5SeeL3l9BNe6dBaObmw+D8Ta3BPVoELAEf1htdZxOBi/aU9syh6EFe70AU6VFeJgDm8ylPlRo55RUD9hFX3JcBX6Vkzy/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2njqb41UOPWik1Ygi/QrhiJrallP5/P7NIReVN4Z0nk=;
 b=RIURJZgvnZOBX+YQvquF/xKQY7P9MhMvI4jOV5k3d8B3kQrXdRp1YGDmIqPziJ8eRL1vxv9S6GmbAuxy4L58GbI4PpdR6iJLZJ0+lZOvBh6t54xfD+LoB7wsSwdI5fhiroYx+euCAVIRRVQSUeYG/YkuKGSuJ9RQQA+VHo5p+Gu5T+ZaTEbtyRwFihRzGQvTZ04lK9xQ97F1y3H6cmeBAgVVJKJZvqsUmo02GBM45nWjwpAQWTn8xe/uHq7cyoSX762N51tV/T8o8p6qL0d5joo9LpNcIzHCjoTefi0tGHPIX8yvbsTINvYHRPG509wPf9asJtDMbdgZsSTt9vb4KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2njqb41UOPWik1Ygi/QrhiJrallP5/P7NIReVN4Z0nk=;
 b=lDTDrg4nSBob9l6ATL35kRT6GYuFB796OGjWZ1+DzEl8J/c4UkAZlo8qzIYuxtK3PAihzaSE6BL5oiMbcxSQDznCBx0ozPQnzEkyYU9Q+MLiPFLz7tRh9bfomII7d6abZSM4+RuatZ4CR08QXw4ZNyeR+i8M9p8+FFxvBJ7MmDg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3540.namprd12.prod.outlook.com (2603:10b6:408:6c::33)
 by BN8PR12MB3217.namprd12.prod.outlook.com (2603:10b6:408:6e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Mon, 24 Aug
 2020 11:13:31 +0000
Received: from BN8PR12MB3540.namprd12.prod.outlook.com
 ([fe80::b5a6:78c7:bdd1:543]) by BN8PR12MB3540.namprd12.prod.outlook.com
 ([fe80::b5a6:78c7:bdd1:543%7]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 11:13:31 +0000
Subject: Re: [PATCH v5 2/3] dmaengine: ptdma: register PTDMA controller as a
 DMA resource
To:     Vinod Koul <vkoul@kernel.org>, Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Naveenkumar.YA@amd.com
References: <1592356288-42064-1-git-send-email-Sanju.Mehta@amd.com>
 <1592356288-42064-3-git-send-email-Sanju.Mehta@amd.com>
 <20200703073704.GK273932@vkoul-mobl>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <44882bd8-c0f6-adf8-9481-b7dc5079d428@amd.com>
Date:   Mon, 24 Aug 2020 16:43:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200703073704.GK273932@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::15) To BN8PR12MB3540.namprd12.prod.outlook.com
 (2603:10b6:408:6c::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BM1PR01CA0145.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 11:13:27 +0000
X-Originating-IP: [165.204.159.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ffd399f9-0a45-47e4-03c9-08d8481ebbdf
X-MS-TrafficTypeDiagnostic: BN8PR12MB3217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3217AAA552A890572AAD5B68E5560@BN8PR12MB3217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWVKMXi0DJlT9y8djlx1hCwQZ7Ub4tm8as8LPFIQGUerihPz5zR7+/wJK29LhwBD6jPG0mn6n/zQLf1lxyy2wtIvNfhtnoG8JtLKVjZgMK/sjeJe3/84CnS8QXcniUpiApde1UpXBptwvBQRipSAxHeT1s/eTXfpyCe7iUAPrxZRFMfrLSW8R4ehXfyyUw7N2c4Yf/qNpoZqXDrvpb/R1KeZAEVSr+uI+DT5ioepCW/YqfZ07sgm+SUcHjpX5R+jAqqDkNow5EB24tpA/8aksN5MeWGX0lWD5B/7611Tuja4+UY+j26HVzSBvq+S9/9XXIwvRE24f/J9TMKOLui+eqmJrCKrLuCdklFtT1jMabKXTxbVQYRhzvXMj9A+qTtW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3540.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(2616005)(31696002)(66476007)(5660300002)(83380400001)(66946007)(8936002)(956004)(186003)(36756003)(66556008)(110136005)(2906002)(6666004)(4326008)(53546011)(52116002)(6486002)(316002)(31686004)(16576012)(26005)(8676002)(6636002)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: lgRtMFaX/hu6YwWxdw35Xa1OEzQQRaPVR/YNBphhYHNeYYGUOyLW3/Bbh1blbGXQuZYSf/3ZW5BVYnOYnUEErtWYhBXGiDFu20O1DHdn8JOeprvHVlTx8bQ6RILn++9fxuP0jU9ZDiq0bykAhyd15N8p6FKI1nfOwCwy0GmsCTLdWdzMmlB+C6H9ghoU0Dl2GQd87fWFQGFEHaUE5rxmtIW18324yxReQruJghjuXTUG2GNUvjbnSV8C9zTREMj7bo0SVDIoESCdDDLa2+mkwfG854f5osVXHVAE1sQxhF5j/FcK6Xm3gfniLA/IpaSPwh/5N3Tq3IiO07dRv3d86yKwxBijFtMhwHyJ7M4ezTyo9ibqSb43R4ZNfzdeyPliM1WU093XFr/6vjzllE92qw+X6h8SkQEVVwhLZlWaF9x9V0qGQCEIGfGnG9KOYoeKszqFASxDU8rJkfffxQTocXfZtN0hUndWyarOqZFm97AyRioU4HoyfDFr3uFDxxYDfWPsjRf4DMVL8JKx3SFgqlWAjgeK8GSwitQJriS/ntWRVZeHMroZ+gbWvoZJBYbuK4fAYZRnPyLJ9XAMgQ5zOJXAw6uIDsrYFjcMdXwAc9/2x/8CqAmIvwGDovswKYzMY2RsXU2o1ODhIpPoegv+mQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd399f9-0a45-47e4-03c9-08d8481ebbdf
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3540.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 11:13:31.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOQI8toG9H4IqlwGKguTLWySV/T7YZaD7BRvdCGbc9jxxrMTmTvp6SrVVmc5Mw5P3RqT6O1F29B0CFWbxQJ9hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3217
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/3/2020 1:07 PM, Vinod Koul wrote:
> 
> On 16-06-20, 20:11, Sanjay R Mehta wrote:
> 
>> --- a/drivers/dma/ptdma/Makefile
>> +++ b/drivers/dma/ptdma/Makefile
>> @@ -5,6 +5,7 @@
>>
>>  obj-$(CONFIG_AMD_PTDMA) += ptdma.o
>>
>> -ptdma-objs := ptdma-dev.o
>> +ptdma-objs := ptdma-dev.o \
>> +           ptdma-dmaengine.o
> 
> Single line?
> 
Yes.

>> +static void pt_free_chan_resources(struct dma_chan *dma_chan)
>> +{
>> +     struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
>> +                                              vc.chan);
>> +
>> +     dev_dbg(chan->pt->dev, "%s - chan=%p\n", __func__, chan);
> 
> drop the dbg artifacts here and other places in this and other patches
> 
Sure. Will fix this in the next version of patch.
>> +static void pt_do_cleanup(struct virt_dma_desc       *vd)
>> +
>> +{
>> +     struct pt_dma_desc *desc = container_of(vd, struct pt_dma_desc, vd);
>> +     struct pt_device *pt = desc->pt;
>> +     struct pt_dma_chan *chan;
>> +
>> +     chan = container_of(desc->vd.tx.chan, struct pt_dma_chan,
>> +                         vc.chan);
> 
> add a to_pt_chan() macro for this?
> 
Will fix this in the next version of patch.
>> +static int pt_issue_next_cmd(struct pt_dma_desc *desc)
>> +{
>> +     struct pt_passthru_engine *pt_engine;
>> +     struct pt_dma_cmd *cmd;
>> +     struct pt_device *pt;
>> +     struct pt_cmd *pt_cmd;
>> +     struct pt_cmd_queue *cmd_q;
>> +
>> +     cmd = list_first_entry(&desc->cmdlist, struct pt_dma_cmd, entry);
>> +     desc->actv = 1;
> 
> active?
> 
This is used to indicate that the command has been submitted to the PTDMA queue.
This variable is being used in many places in the code.
If the name "actv" is confusing here, I'll change to something else.

>> +
>> +     dev_dbg(desc->pt->dev, "%s - tx %d, cmd=%p\n", __func__,
>> +             desc->vd.tx.cookie, cmd);
>> +
>> +     pt_cmd = &cmd->pt_cmd;
>> +     pt = pt_cmd->pt;
>> +     cmd_q = &pt->cmd_q;
>> +     pt_engine = &pt_cmd->passthru;
>> +
>> +     if (!pt_engine->final)
>> +             return -EINVAL;
> 
> what does final mean here?
This was used to indicate completion in the initial version of code. This has no use now.
Will remove in the next version of patch.
>> +
>> +     if (!pt_engine->src_dma || !pt_engine->dst_dma)
>> +             return -EINVAL;
> 
> what does this check do? we have a valid cmd which IIUC implies a valid
> dma txn so why would one of this be invalid?
> 
Yes, you are right. Will fix this in the next version of patch.

>> +static struct pt_dma_desc *__pt_next_dma_desc(struct pt_dma_chan *chan)
>> +{
>> +     /* Get the next DMA descriptor on the active list */
>> +     struct virt_dma_desc *vd = vchan_next_desc(&chan->vc);
>> +
>> +     if (list_empty(&chan->vc.desc_submitted))
>> +             return NULL;
>> +
>> +     vd = list_empty(&chan->vc.desc_issued) ?
>> +               list_first_entry(&chan->vc.desc_submitted,
>> +                                struct virt_dma_desc, node) : NULL;
> 
> Always remember there might already be a macro, so check. In this case
> use of list_first_entry_or_null() looks apt
> 
Sure. Will fix this in the next version of patch.
>> +static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
>> +                                              struct pt_dma_desc *desc)
>> +{
>> +     struct dma_async_tx_descriptor *tx_desc;
>> +     struct virt_dma_desc *vd;
>> +     unsigned long flags;
>> +
>> +     /* Loop over descriptors until one is found with commands */
> 
> This bit is strange, am not sure I follow. The fn name tell me it would
> handle and active descriptor which is passed as an arg, so why do you
> loop?
> 
> Can you explain this?
> 
There are two tasks this function handles.

First, this function checks whether the passed descriptor is already submitted
for the PDMA queue or not. If not, it will return the descriptor to submit for
the DMA txn to the queue.

Secondly, it loops through all the descriptors from the issued list and checks
if the all descriptor has been handled or not. If not, then processes them in the loop.

>> +static void pt_issue_pending(struct dma_chan *dma_chan)
>> +{
>> +     struct pt_dma_chan *chan = container_of(dma_chan, struct pt_dma_chan,
>> +                                              vc.chan);
>> +     struct pt_dma_desc *desc;
>> +     unsigned long flags;
>> +
>> +     dev_dbg(chan->pt->dev, "%s\n", __func__);
>> +
>> +     spin_lock_irqsave(&chan->vc.lock, flags);
>> +
>> +     desc = __pt_next_dma_desc(chan);
>> +
>> +     spin_unlock_irqrestore(&chan->vc.lock, flags);
>> +
>> +     /* If there was nothing active, start processing */
> 
> What if channel is already active and doing a transaction? This should
> check it first..
> 
This case is handled by PTDMA engine. Therefore,the channel busy case is not checked here.

The PTDMA hardware queue has two pointers to manage the queue "head" and "tail" pointer.
The head pointer points to first (oldest) command in the queue and only the initial value
written by software prior to enabling queue. Hardware updates this pointer when it fetches
a Command Descriptor from memory. Software is not allowed to modify this register.

The software is supposed to update only the tail pointer of the queue with DMA txn.

>> +int pt_dmaengine_register(struct pt_device *pt)
>> +{
>> +     struct pt_dma_chan *chan;
>> +     struct dma_device *dma_dev = &pt->dma_dev;
>> +     struct dma_chan *dma_chan;
>> +     char *dma_cmd_cache_name;
>> +     char *dma_desc_cache_name;
>> +     int ret;
>> +
>> +     pt->pt_dma_chan = devm_kcalloc(pt->dev, 1,
>> +                                    sizeof(*pt->pt_dma_chan),
>> +                                    GFP_KERNEL);
> 
> If n is 1, why you kcalloc, why not devm_kzalloc()?
Will fix this in the next version of patch.
> 
>> +     if (!pt->pt_dma_chan)
>> +             return -ENOMEM;
>> +
>> +     dma_cmd_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
>> +                                         "%s-dmaengine-cmd-cache",
>> +                                         pt->name);
>> +     if (!dma_cmd_cache_name)
>> +             return -ENOMEM;
>> +
>> +     pt->dma_cmd_cache = kmem_cache_create(dma_cmd_cache_name,
>> +                                           sizeof(struct pt_dma_cmd),
>> +                                           sizeof(void *),
>> +                                           SLAB_HWCACHE_ALIGN, NULL);
>> +     if (!pt->dma_cmd_cache)
>> +             return -ENOMEM;
>> +
>> +     dma_desc_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
>> +                                          "%s-dmaengine-desc-cache",
>> +                                          pt->name);
>> +     if (!dma_desc_cache_name) {
>> +             ret = -ENOMEM;
>> +             goto err_cache;
>> +     }
>> +
>> +     pt->dma_desc_cache = kmem_cache_create(dma_desc_cache_name,
>> +                                            sizeof(struct pt_dma_desc),
>> +                                            sizeof(void *),
>> +                                            SLAB_HWCACHE_ALIGN, NULL);
>> +     if (!pt->dma_desc_cache) {
>> +             ret = -ENOMEM;
>> +             goto err_cache;
>> +     }
>> +
>> +     dma_dev->dev = pt->dev;
>> +     dma_dev->src_addr_widths = PT_DMA_WIDTH(dma_get_mask(pt->dev));
>> +     dma_dev->dst_addr_widths = PT_DMA_WIDTH(dma_get_mask(pt->dev));
>> +     dma_dev->directions = DMA_MEM_TO_MEM;
>> +     dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
>> +     dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
>> +     dma_cap_set(DMA_INTERRUPT, dma_dev->cap_mask);
>> +     dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
> 
> Why DMA_PRIVATE if it supports only memcpy? Also have you tested this
> with dmatest?
> 
This DMA controller is intended to use with AMD Non-Transparent Bridge devices
and not for general purpose slave DMA. Therefore we made it as DMA_PRIVATE.

Yes, I had verified with the dmatest.

> --
> ~Vinod
> 
