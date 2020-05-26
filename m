Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C161E1B8B
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2020 08:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgEZGtA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 May 2020 02:49:00 -0400
Received: from mail-eopbgr750073.outbound.protection.outlook.com ([40.107.75.73]:40536
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726756AbgEZGs7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 May 2020 02:48:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0MDQwy9n3S+IXLorrv2aYVpoNVGH4ZjoiSYF95NHWj/YxMbru/vtXJ4PAux1bSaV5NgKh+3cED19p9j9U4Oo8UFUPVwwOPTPqKWKp+TdgshaHoR50O1RVzYxMgyvsjqKqJ80eB8Cpbm1GtNzj+E4vd0WQ8uMXzkAvn9aBBcCRcserMetILCQt42mJSMmYzwLTXvDPkIItKSC9Pt4FIRtlpluV9pWK/pQ1b3FpGER2MGwqOXmJ+BsZyfVErA6J6RiUC2gB2EleekQa1BX1bMl+okb7098rTfC4/Pho/JF9OU0YEwsAJBRFNb+MJSPgNDTWjQRRNiLd9LerLrY/JyBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hf+aLAllo+blw8yht7TQ5cHSDNukfRIo4uN/E5GWuwY=;
 b=b0gb2fFSCBC8T1Ls4BOJMKWHRgc1oHPb8nscQAhYf6w8k4zU/Od+XfAvZ7wXTrETzeOBFNyUGDj/37EKjMjYuCPk9z+42dH37iXBqs6lqbjpg/sJ7D9DulnwK6uAZ32kRN7OAHphhIsnaxBlzwB9yC6STp9kxCWDydIT32bOEb2qbZONY2DapAKn9m5PRwWQNkhDL+S6mVITfbIU1uRcKIMqAVPZoxnz8Qpmj45dm7sjLIp2DiMvbnpYCSHH1DRd6nlDnUgTG0u8s3v1hqAa7qWvk2GBROGeGLUPFXa3yb6D5MfFki22o3q5/XFA3EdjM05qiQUEDItWssG+tyBaiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hf+aLAllo+blw8yht7TQ5cHSDNukfRIo4uN/E5GWuwY=;
 b=0T2llvPtEeWkanJJR+L1G5mG3RFqz/zF8R4SUeyR4mEigi+8nXPwO5KjckLwK9CmpR8ViyVwOzRsq/OXvQbFbWP0Iuqy6oRR6LXHzAhQ90HEEY3F22aAUG1OYY3re+3D97QDJEOmEHuquiG+FdqYgUtmbyar+r1/FpFKJapCC5g=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3420.namprd12.prod.outlook.com (2603:10b6:5:3a::27) by
 DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23; Tue, 26 May 2020 06:48:57 +0000
Received: from DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::d007:1b50:9d7c:632f]) by DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::d007:1b50:9d7c:632f%5]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 06:48:56 +0000
Subject: Re: [PATCH v4 2/3] dmaengine: ptdma: register PTDMA controller as a
 DMA resource
To:     Vinod Koul <vkoul@kernel.org>, Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1588108416-49050-1-git-send-email-Sanju.Mehta@amd.com>
 <1588108416-49050-3-git-send-email-Sanju.Mehta@amd.com>
 <20200504061445.GK1375924@vkoul-mobl>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <b88126b6-0f5a-8b5c-1cb4-444d854f8af9@amd.com>
Date:   Tue, 26 May 2020 12:18:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200504061445.GK1375924@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::27) To DM6PR12MB3420.namprd12.prod.outlook.com
 (2603:10b6:5:3a::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:7400:70:65d3::1] (2406:7400:70:65d3::1) by BM1PR0101CA0041.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Tue, 26 May 2020 06:48:50 +0000
X-Originating-IP: [2406:7400:70:65d3::1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f53f6f9-34f9-4fcc-9e17-08d80140dc37
X-MS-TrafficTypeDiagnostic: DM6PR12MB4105:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4105A71BA4F4657DBCADE6FFE5B00@DM6PR12MB4105.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OIg1oz1+at2XxW82Q77CHrdK0FHvSBVjY3ijK4Ho42svvTClObt3wPnekLsnRnE987Rvy+I7yPe/POF7bELTMIlqZ5ss3PXih2vIXQE6IFDgoEQ/LsTr8ChzXL0RJCQ1eTsqtKtQ7v9WR00IVP3fEEZL/CTK3aSC2+fLFhdPQThAFJa2RKBd0wjhJLaPwchJuhjMLoibQB2fwFzO4Wun1wF1ufjw4HfikCbYswaFCi3WkWYTsHKUGXmyWSYe5bTgRMySaZI5N6GX6trngBj1B+LZRxfuu+3exUgkmy+fpt/SjcLokZUM8uSwriH4pprb/VGewk5bk6n1pbqqiRVugN5D2SdWgVv/pNGnGViz/KL/72CIjnWKQfrVs9m+0SEt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3420.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(4326008)(53546011)(316002)(110136005)(16526019)(66476007)(186003)(8936002)(8676002)(31686004)(6666004)(66556008)(66946007)(52116002)(6486002)(5660300002)(6636002)(36756003)(2616005)(31696002)(2906002)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: OiW6e3OJmGm9wV7bsh67b2hb+/aQW+EFxTdO9gEI9KzljLbX1qCrooI3ndyklQoBceBohMb/qFm/rznySSzdJiSdn6U2OL7DC1/qO1m6yRNYPWwm3edtJLiC1ZCQsaS99sDeqAiIdyewM7PbFp/ZIYHW9Pb0mFFE7rUbC8Zx3NgtLA9mhFP9bWTIQXX8ZDdipWaAMa2yxuDHXf0nMMa8X4RLNCs352JVPbGt5RfvlZh7MVB1AQobrT07dheo0ZYyoqRxNTLnUR5n93qiWmhQwQEi+6i1L2zuoVxJfq0/OyVWOmLLW9WOvK5LhgSE51dP+s4QrWxnAb8cEfR7OM30zuzxS9kW65QlUohL20mfJv41SC/MgrHlnba81RIpivdRLWJGWXkSAvbG6bwm+TCA5vmQe60Xboc8+8WGfCu0Uk7y+oezYqr351LntJJOQHFCZJpAQNrXkPcC8mJuAB2WnTC0GhwijvNe+SjBHEdcD8tytm09tj71cWKO9s2HkjOs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f53f6f9-34f9-4fcc-9e17-08d80140dc37
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 06:48:56.1150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64FzzSXf3ul07DpE8hXZanyjg+1da0gvpZdfSRnp1/eskCVbGt15snkMNz/sx6mUFnDBj0It19zLDe5kdieUig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/4/2020 11:44 AM, Vinod Koul wrote:
> [CAUTION: External Email]
> 
> On 28-04-20, 16:13, Sanjay R Mehta wrote:
> 
>> +static void pt_do_cmd_complete(unsigned long data)
>> +{
>> +     struct pt_tasklet_data *tdata = (struct pt_tasklet_data *)data;
>> +     struct pt_cmd *cmd = tdata->cmd;
>> +     struct pt_cmd_queue *cmd_q = &cmd->pt->cmd_q;
>> +     u32 tail;
>> +
>> +     tail = lower_32_bits(cmd_q->qdma_tail + cmd_q->qidx * Q_DESC_SIZE);
>> +     if (cmd_q->cmd_error) {
>> +            /*
>> +             * Log the error and flush the queue by
>> +             * moving the head pointer
>> +             */
>> +             pt_log_error(cmd_q->pt, cmd_q->cmd_error);
>> +             iowrite32(tail, cmd_q->reg_head_lo);
>> +     }
>> +
>> +     cmd->pt_cmd_callback(cmd->data, cmd->ret);
> 
> So in the isr you schedule this tasklet and this invokes the calback..
> this is very inefficient.
> 
> You should submit the next txn to dmaengine in your isr, keeping the dma
> idle at this point is very inefficient.
> 
Sure, will incorporate the changes in the next version of patch.

>> +static void pt_cmd_callback(void *data, int err)
>> +{
>> +     struct pt_dma_desc *desc = data;
>> +     struct pt_dma_chan *chan;
>> +     int ret;
> 
> This is called as callback from pt layer..
Right.

>> +
>> +     if (err == -EINPROGRESS)
>> +             return;
>> +
>> +     chan = container_of(desc->vd.tx.chan, struct pt_dma_chan,
>> +                         vc.chan);
>> +
>> +     dev_dbg(chan->pt->dev, "%s - tx %d callback, err=%d\n",
>> +             __func__, desc->vd.tx.cookie, err);
>> +
>> +     if (err)
>> +             desc->status = DMA_ERROR;
>> +
>> +     while (true) {
>> +             /* Check for DMA descriptor completion */
>> +             desc = pt_handle_active_desc(chan, desc);
>> +
>> +             /* Don't submit cmd if no descriptor or DMA is paused */
>> +             if (!desc || chan->status == DMA_PAUSED)
>> +                     break;
>> +
>> +             ret = pt_issue_next_cmd(desc);
> 
> And you call this to issue next cmd... The missing thing I am seeing
> here is vchan_cookie_complete() you need to call that here for correct
> vchan list mgmt
> 
Here before making call to issue next cmd, "vchan_vdesc_fini()" is been used in place of
vchan_cookie_complete() in the pt_handle_active_desc() function.


>> +static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
>> +                                       struct scatterlist *dst_sg,
>> +                                         unsigned int dst_nents,
>> +                                         struct scatterlist *src_sg,
>> +                                         unsigned int src_nents,
>> +                                         unsigned long flags)
> 
> unaligned add indentation! Pls run checkpatch --strict to check for
> these oddities
> 
Sure, will incorporate the changes in the next version of patch.

>> +     dma_dev->dev = pt->dev;
>> +     dma_dev->src_addr_widths = PT_DMA_WIDTH(dma_get_mask(pt->dev));
>> +     dma_dev->dst_addr_widths = PT_DMA_WIDTH(dma_get_mask(pt->dev));
>> +     dma_dev->directions = DMA_MEM_TO_MEM;
>> +     dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
>> +     dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
>> +     dma_cap_set(DMA_INTERRUPT, dma_dev->cap_mask);
>> +     dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
>> +
>> +     INIT_LIST_HEAD(&dma_dev->channels);
>> +
>> +     chan = pt->pt_dma_chan;
>> +     chan->pt = pt;
>> +     dma_chan = &chan->vc.chan;
>> +
>> +     dma_dev->device_free_chan_resources = pt_free_chan_resources;
>> +     dma_dev->device_prep_dma_memcpy = pt_prep_dma_memcpy;
>> +     dma_dev->device_prep_dma_interrupt = pt_prep_dma_interrupt;
>> +     dma_dev->device_issue_pending = pt_issue_pending;
>> +     dma_dev->device_tx_status = pt_tx_status;
>> +     dma_dev->device_pause = pt_pause;
>> +     dma_dev->device_resume = pt_resume;
>> +     dma_dev->device_terminate_all = pt_terminate_all;
> 
> Pls implement .device_synchronize as well
> 
Sure, will incorporate the changes in the next version of patch.

>> +struct pt_dma_desc {
>> +     struct virt_dma_desc vd;
>> +
>> +     struct pt_device *pt;
>> +
>> +     struct list_head pending;
>> +     struct list_head active;
> 
> why not use vc->desc_submitted, desc_issued instead!
> 
Sure, will incorporate the changes in the next version of patch.

>> +
>> +     enum dma_status status;
>> +
>> +     size_t len;
>> +};
>> +
>> +struct pt_dma_chan {
>> +     struct virt_dma_chan vc;
>> +
>> +     struct pt_device *pt;
>> +
>> +     enum dma_status status;
> 
> channel status as well as desc, why do you need both?
You are right. will remove channel status from here.

> --
> ~Vinod
> 
