Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEB23D8A77
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 11:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbhG1JRE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 05:17:04 -0400
Received: from mail-dm6nam10on2083.outbound.protection.outlook.com ([40.107.93.83]:16832
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231465AbhG1JRD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 05:17:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pt02w2Q1ScZzAdZ5hhADMbZawoFeJ30Xu4LTKkVEU5UzOxusgLvfxWSdF0uLAvVsZGEZSccGAT1tdX2+3D39Nv1ygCwq5ZcJKy1Kz3fagCfRrrsPxyKlX9kil926LHayga7ltrHoUeIbUNeuZRSW4ZOG1ZV85IwCBTbY5QXx6zxK1rZOmFLVez+Ig1eZBZ9/pw/RJXzeYE7peXR1kKyHb0VJR/qLVfgJKHaV/Z0aeBKkl6bnG5Ehe/GXTxlmAZb3ef8XjGbH5quTbGvDgc7AYb6J3K4ACdFwVtePbuCuQrbdIpD7wzB7TkU22xGDHA3TTScnu/2xC+tX7R7PfFfD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOspHOaeWeYXmUY96XbJ2bdr+IgeEib4izEgqLBYcuc=;
 b=dDupbFt5PjUKwPkhZYghfoqwMJOCURM867jbgGdyE1GH82kZQNwCSKtjY1dwtO8CazUeUvaBXYaVeZO4XMSdb72BzEXnHvFyXPyrG1qLXxOSVZnHDgiAXViS5uNtQZSpA7TAl0YXmVCNXArKVjxBWRQxCkCO/o5ykkKLXxbTt38CQ3gh2rB/IF9ZxCzvCzuzd39xXPUyL2TowTJMe0UHI8f5krh7ZJAtuE2VUHEBCQSWnfjhKPI8NvpJ0bIVr1pCyW2fo9ojq10S7u/Yy0hNldqgPpxyFPjxxP+qVosLk//0m7WAhUqZGBxcNn1MkdclbWMhKwo3oRd7qPawGDTn8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOspHOaeWeYXmUY96XbJ2bdr+IgeEib4izEgqLBYcuc=;
 b=ItzEfnlgCn532ZiXSFN9vAvPFL2/PKllGcPdhy4W2U6AjNqM91XZAHE/evKD5el+TLua80pLB4EcgugzLKVB/Jeycgy2ivYO+zz8mmJiHW7NC/X5wD6aQWWMilgKW9MLv50DDU1sPOtXcwUSu7qJYnQnja6OeyNZFKq5a9OJuHo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 09:17:01 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::18ea:5df5:f06e:f822]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::18ea:5df5:f06e:f822%3]) with mapi id 15.20.4373.018; Wed, 28 Jul 2021
 09:17:01 +0000
Subject: Re: [PATCH v10 1/3] dmaengine: ptdma: Initial driver for the AMD
 PTDMA
To:     Vinod Koul <vkoul@kernel.org>, Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1624207298-115928-1-git-send-email-Sanju.Mehta@amd.com>
 <1624207298-115928-2-git-send-email-Sanju.Mehta@amd.com>
 <YQDxSwT0DYqEf0z5@matsya>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <bc51b4f7-d604-ecb1-873c-2c9238b675b5@amd.com>
Date:   Wed, 28 Jul 2021 14:46:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <YQDxSwT0DYqEf0z5@matsya>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::34) To DM4PR12MB5103.namprd12.prod.outlook.com
 (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.136.44.125] (165.204.157.251) by MAXPR01CA0092.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 09:16:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b58c5da2-3704-4c53-a82c-08d951a874e4
X-MS-TrafficTypeDiagnostic: DM4PR12MB5133:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5133A6FCBDC594B2ECA2544CE5EA9@DM4PR12MB5133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rveHj18hnqF/20XoaaTQ7zZt/JNFOLyPf/PtFlfRyhy0GMhnVBnzb3WP4GQwE1rZIvV0gMcsEk9jh23acXTog+6ysTLOApBpfeqg0uz+vBRLyp6KCFLc2vuAI9sUANW6LMU5+b/SjSjkCLxwAXMJGTKvhCRCEIkrOzvQUWKFfURDi28y4pvuVXKa5b8frUGKocr0esepMsHohLVhzWedLWWaKsBlhx2aIYoB/tjD8XO/Vs6cXdV95SlKxixGyA4yrWF04+laiEjcUoDTkQ/u4qXsP6hotbINlR1seOeiSfM3FzeKXrULWS5zEcGJdY6D71Vz8rmJpLkPl+u1aElYX5A/xKx1GC8HUantTwn4gyPUTOCTiW1rMaPZdnBUgWv9RzHqmgi/TCzXuMx3H9KoqAalwALP1ef8c3nrvRw6YHKOk/mVlH9iWzeEa5LBYzuhil5DM1k0mMsM4G9/+Yo2zTL1wPec1t0/rY666ve5qfHe259D1s2OYeqVwFDPb5QFyYaigOHNT3E2QH7/ROo/705XUgOJNIponI/ILrH12hr45kTWA8AKr59kfmtVq8zDO0os9pCv/yF8yMoWOpKNHDO7PScn1lAKwnkzR1hbwG9u8Zmmo47qHL4RDBeA7KjZ4WPmpTWGZdVlV/MyPYFGC4Saoh5fGE2fHPiB+JNVSfWPJlbE4ftGOmAugKGQri5cQmOM1H0oIT68Mk6iIcMotMs3TFo1mHxUxktllUpIYoE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(186003)(5660300002)(38100700002)(478600001)(8676002)(6486002)(4326008)(956004)(110136005)(2616005)(6636002)(66946007)(316002)(31696002)(6666004)(66556008)(31686004)(66476007)(36756003)(26005)(53546011)(2906002)(8936002)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnJPMkhHdjBQdmFueFViVVhJYVlQZXFVb2NKb3ZhMVlGZDB3ZHV5dkJMemt3?=
 =?utf-8?B?OTIyUHJTaXo2RTNBYWh5c3krREJBQ0dUalFWRWhyUFZENVRNc0hNTDdFbTBn?=
 =?utf-8?B?aXhaUW9TSG9jdXVvT1lPNjd4Uzcxb0hQOG9OYWtoTWFWR0w2Q0ZmRmlPQmN1?=
 =?utf-8?B?UmVQUW5nY1ptMmpQS1VkRm84WE83ajRqNzV2NkNGSDFnN2NZdzBnUnJaRDVl?=
 =?utf-8?B?YnNoRkc5Z05ROUJLYmpBeTBHY2kxRXFldU14dEhEY3d1c0JlWGhHVTM4TCsr?=
 =?utf-8?B?Y1RacURJczNDUVR3R2ozN3E3MmVzTFcyemIvN3RVZmhUYkM4RzQ2d0w4WFNZ?=
 =?utf-8?B?cnozeVhoSHdYQzBoUGVYazdMbkxOR3lGRXRRZDlKUDZoc2tPckJYbVJZeFRa?=
 =?utf-8?B?ZTZST3B2dDhWVDd0cWRHdUtZVGVPblNiTzFRMG94cVpUem96Rk5taHQzeU5r?=
 =?utf-8?B?QnpOTE9XVEdZTTlndXplOW5PWjZVL3Fkb202Mjd4MEVzODNVTWRRWkpDajNi?=
 =?utf-8?B?c1Y4MTBXcVVjQ0xjdGRSZjltZ3ZHbzZ5L2dLc2VTaFVIWktxWTMySGpkaHdD?=
 =?utf-8?B?TEpKdFZzSlFHQVMwOTk3ZTl1d2dXakd4MVNTZ2s5eVFucEZMYTFMdjljZHZD?=
 =?utf-8?B?SFIyaVUzTnR4VW1ENm9wWFBDVUFaSWNLbHdwbGlFS2NqdW5JbjJGdEtlaStF?=
 =?utf-8?B?bnZTTWhuQjNMM2U0SEhjYTlsRjhjS0pSbDM4R2FiNjRodis3bHg5dWxaaVgy?=
 =?utf-8?B?bTBCU1JzUC9ONzVscW9ROFNIZ0JSNE5EV0JERWhiZzVqald3enN1Y0RYdjBy?=
 =?utf-8?B?bFlBZGVEQmNjMzZlUmpLZ2NtZ2ZtaFJ5dTNTbndrRXJpRGFjQ3RFb0tBNGFS?=
 =?utf-8?B?eTVjVk9KVW9VL2VaZm9oMWx5SmRVemhBMkVsVmVpVmlDdmlaUHVVdHhVMlc1?=
 =?utf-8?B?KzlNbVdrN1l5ZlFuSGxiMklCeWszbVExalduNjNpYlY3TXNiS0dGTFV6eW9R?=
 =?utf-8?B?Z2lFcE9BWk5zbDViVHZiVEtobXJxaXFrNklBdUFpdjRWblhrbkRpcU9BR3lN?=
 =?utf-8?B?VVZxOUptcXpRVm9kTE5IREVrQ1FubEc1MzY5NGhWbEcza29wZzhNZHBXQk9k?=
 =?utf-8?B?eWtieEZFMElMeExrRUc2RTJoMjFvaWVqWFdMdC9meSs4TUJ6S0h1Z3AvWC9S?=
 =?utf-8?B?bEd0a21BNW55cXFHbnNERC9SanFkMmFQL1ZzcGhnZnROTjFqakVFaE90bDhY?=
 =?utf-8?B?cVoyR0RLUnZvZ2ZaS0d6TVQzbzE3cXJrd1BDdGZDN0IzcGdVMFNQK2F6R0wx?=
 =?utf-8?B?TmlrREtYZlg2VFJyOU5OL2dvVHJEUitGOVAwZ2pYQW0zOUJwWnR1QlduZlF6?=
 =?utf-8?B?TlF1NmxLZzRtOXlQV1I1RTRXT3p4OGl6M1BVQktsMzJlYlpDTlBnQUR6dE5x?=
 =?utf-8?B?S1FDWFg0cndOWXdqM052VktzWU9ZMEIyNzFOS0hNNmFXR1V0UDlNaHRVSHpu?=
 =?utf-8?B?dkZGTVRSWXRyU2pRZjEvZFhldjJGMnRWcTVXU09PaU5ETmNQZmxpdEhwbFFN?=
 =?utf-8?B?YUIrVzFXWE1GdTdLZ2pQOGkrUlhWY25DalBMMndEV0UyNTRxSGFPUTVNMTkr?=
 =?utf-8?B?bGM1RHVlbDd0b0JtQThDUzMveFZpcU1MYVIrek5TOWhqZ3B3NVY1TWJKRHg1?=
 =?utf-8?B?MTFIN1ZLZTVWYnQzTEZ0cjZ1YTQ2OWVTb29ZOWMrY1E2dEVSbDVvaDVKeEow?=
 =?utf-8?Q?FdoLCuhrPumJyUYLx3freBuy3oGin6gtynau+Fl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58c5da2-3704-4c53-a82c-08d951a874e4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 09:17:00.8876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpXcRGgQYL0NIPj4PgbW9dv78tXsLn3dRVbqjdmwcqGrzArXQOsSXuvBFNFmUIzQ4Os4nvmhCfkLne0oVKYjeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 7/28/2021 11:25 AM, Vinod Koul wrote:
> [CAUTION: External Email]
> 

Thanks Vinod for the feedback.

> On 20-06-21, 11:41, Sanjay R Mehta wrote:
> 
>> +static irqreturn_t pt_core_irq_handler(int irq, void *data)
>> +{
>> +     struct pt_device *pt = data;
>> +     struct pt_cmd_queue *cmd_q = &pt->cmd_q;
>> +     u32 status;
>> +     bool err = true;
>> +
>> +     pt_core_disable_queue_interrupts(pt);
>> +
>> +     status = ioread32(cmd_q->reg_interrupt_status);
>> +     if (status) {
>> +             cmd_q->int_status = status;
>> +             cmd_q->q_status = ioread32(cmd_q->reg_status);
>> +             cmd_q->q_int_status = ioread32(cmd_q->reg_int_status);
>> +
>> +             /* On error, only save the first error value */
>> +             if ((status & INT_ERROR) && !cmd_q->cmd_error) {
>> +                     cmd_q->cmd_error = CMD_Q_ERROR(cmd_q->q_status);
>> +                     err = false;
>> +             }
>> +
>> +             /* Acknowledge the interrupt */
>> +             iowrite32(status, cmd_q->reg_interrupt_status);
>> +     }
>> +
>> +     pt_core_enable_queue_interrupts(pt);
>> +
>> +     return err ? IRQ_HANDLED : IRQ_NONE;
> 
> On err you should not return IRQ_NONE. IRQ_NONE means "interrupt was not
> from this device or was not handled"
> 
> Error is handled here!
> 
Got  it. Sure, will change it.

>> +static struct pt_device *pt_alloc_struct(struct device *dev)
>> +{
>> +     struct pt_device *pt;
>> +
>> +     pt = devm_kzalloc(dev, sizeof(*pt), GFP_KERNEL);
>> +
>> +     if (!pt)
>> +             return NULL;
>> +     pt->dev = dev;
>> +
>> +     INIT_LIST_HEAD(&pt->cmd);
>> +
>> +     snprintf(pt->name, MAX_PT_NAME_LEN, "pt-%s", dev_name(dev));
> 
> what is this name used for? Why not use dev_name everywhere?
> 
Sure, will change it to  dev_name.

>> +static int pt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>> +{
>> +     struct pt_device *pt;
>> +     struct pt_msix *pt_msix;
>> +     struct device *dev = &pdev->dev;
>> +     void __iomem * const *iomap_table;
>> +     int bar_mask;
>> +     int ret = -ENOMEM;
>> +
>> +     pt = pt_alloc_struct(dev);
>> +     if (!pt)
>> +             goto e_err;
>> +
>> +     pt_msix = devm_kzalloc(dev, sizeof(*pt_msix), GFP_KERNEL);
>> +     if (!pt_msix)
>> +             goto e_err;
>> +
>> +     pt->pt_msix = pt_msix;
>> +     pt->dev_vdata = (struct pt_dev_vdata *)id->driver_data;
>> +     if (!pt->dev_vdata) {
>> +             ret = -ENODEV;
>> +             dev_err(dev, "missing driver data\n");
>> +             goto e_err;
>> +     }
>> +
>> +     ret = pcim_enable_device(pdev);
>> +     if (ret) {
>> +             dev_err(dev, "pcim_enable_device failed (%d)\n", ret);
>> +             goto e_err;
>> +     }
>> +
>> +     bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
>> +     ret = pcim_iomap_regions(pdev, bar_mask, "ptdma");
>> +     if (ret) {
>> +             dev_err(dev, "pcim_iomap_regions failed (%d)\n", ret);
>> +             goto e_err;
>> +     }
>> +
>> +     iomap_table = pcim_iomap_table(pdev);
>> +     if (!iomap_table) {
>> +             dev_err(dev, "pcim_iomap_table failed\n");
>> +             ret = -ENOMEM;
>> +             goto e_err;
>> +     }
>> +
>> +     pt->io_regs = iomap_table[pt->dev_vdata->bar];
>> +     if (!pt->io_regs) {
>> +             dev_err(dev, "ioremap failed\n");
>> +             ret = -ENOMEM;
>> +             goto e_err;
>> +     }
>> +
>> +     ret = pt_get_irqs(pt);
>> +     if (ret)
>> +             goto e_err;
>> +
>> +     pci_set_master(pdev);
>> +
>> +     ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
>> +     if (ret) {
>> +             ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>> +             if (ret) {
>> +                     dev_err(dev, "dma_set_mask_and_coherent failed (%d)\n",
>> +                             ret);
>> +                     goto e_err;
>> +             }
>> +     }
>> +
>> +     dev_set_drvdata(dev, pt);
>> +
>> +     if (pt->dev_vdata)
>> +             ret = pt_core_init(pt);
>> +
>> +     if (ret)
>> +             goto e_err;
>> +
>> +     return 0;
>> +
>> +e_err:
>> +     dev_err(dev, "initialization failed\n");
> 
> log the err code, that is very useful!
> 
>> +     /* Register addresses for queue */
>> +     void __iomem *reg_control;
>> +     void __iomem *reg_tail_lo;
>> +     void __iomem *reg_head_lo;
>> +     void __iomem *reg_int_enable;
>> +     void __iomem *reg_interrupt_status;
>> +     void __iomem *reg_status;
>> +     void __iomem *reg_int_status;
>> +     void __iomem *reg_dma_status;
>> +     void __iomem *reg_dma_read_status;
>> +     void __iomem *reg_dma_write_status;
> 
> this looks like pointer to registers, wont it make sense to keep base
> ptr and use offset to read..?
> 
> Looking at pt_init_cmdq_regs(), i think that seems to be the case. Why
> waste so much memory by having so many pointers?
> 
Yes, you are right. I will make this changes.

> 
>> +     u32 qcontrol; /* Cached control register */
>> +
>> +     /* Status values from job */
>> +     u32 int_status;
>> +     u32 q_status;
>> +     u32 q_int_status;
>> +     u32 cmd_error;
>> +} ____cacheline_aligned;
>> +
>> +struct pt_device {
>> +     struct list_head entry;
>> +
>> +     unsigned int ord;
> 
> Unused?
> 

Sure. Will remove it.
> --
> ~Vinod
> 
