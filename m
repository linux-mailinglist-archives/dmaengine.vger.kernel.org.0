Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9894824F3E2
	for <lists+dmaengine@lfdr.de>; Mon, 24 Aug 2020 10:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgHXIZe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Aug 2020 04:25:34 -0400
Received: from mail-bn8nam11on2087.outbound.protection.outlook.com ([40.107.236.87]:21342
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbgHXIZc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Aug 2020 04:25:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+f5CBBDSjQi8IvpJE5Yili4BxlC9SqztnB3mP0EYtQALmkcC3uvweh6xzQPZDGfEnu6zzsaNUESoyVAawbORObepC8syRp3KM/PgkDmAiYi/AUG64zbW3sxwqkMnBAMEmZ4SmTEIP9gIKzBcozFL/W902aHk0Ys1DyCSEBl+FZ7dDffFa5K1tGc5KWoC4vOHtj9YC0drmMCLkHuCAReqZVn2iX3EPTBfFWOl4QzWe7ZOPDGcXM6D5BtUTRfiHfaRHeRg7gBPm0HzT9TmVueTVr8BvdC853QhjKvhnAqTi+oof9ooyRtimGYCjLHGWr5ni3ouDOBqkWtcO+4zQYnyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6CdyL9TFR0cspO+cJ/SjC7osLWwD7WMpaoC5GZo3Mw=;
 b=RVPSirWiCJLxwJoP0k3Oo8G1I+hvXYpLDJoJFnKXhyYdmE3YQw/wmCpka1YLJQhvJKfQSQJQ2OA1LHv9mn2Ou1UKRwS1UlNn8Q1KyyxJVxs04OBkGmEHPxT7nRIw7AGuxOy/AHj/SN5rTbyHx+DqRNGQjnPpnLG9g7Ogf+QwwjPPQVgLTgM3fmMInUpUIMSjKgt86iTPD88AYEI3AaLCrze5wkEgo2kaj1gIiJieT3nADAUFI29/K4I2AKdGovq+ijadYT6oJ0zHOivHrm1N+sx80kAb2cO8QOHiDPcUnWSNW2mtJaE3CM9GFoOV1fpLXs2OZFBiBf86h2F5iaiUmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6CdyL9TFR0cspO+cJ/SjC7osLWwD7WMpaoC5GZo3Mw=;
 b=iDD0Edi4lWH85fuomB8VieWhKXEeF+ZMW8fwQSpAVg41TVAbrzqueo2CAw/y12+3RoUDB0Yk5fCXyWHCHaMTsC2pWkF7v0U4jC7Jw4QB3tFQLPh45d1xzUzxrQP4JibxA6vk3T5spUk7Q3kNp9cFh8ruaRuzzE7LT/pE0WoEU7Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3540.namprd12.prod.outlook.com (2603:10b6:408:6c::33)
 by BN6PR12MB1460.namprd12.prod.outlook.com (2603:10b6:405:11::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 24 Aug
 2020 08:25:28 +0000
Received: from BN8PR12MB3540.namprd12.prod.outlook.com
 ([fe80::b5a6:78c7:bdd1:543]) by BN8PR12MB3540.namprd12.prod.outlook.com
 ([fe80::b5a6:78c7:bdd1:543%7]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 08:25:28 +0000
Subject: Re: [PATCH v5 3/3] dmaengine: ptdma: Add debugfs entries for PTDMA
 information
To:     Vinod Koul <vkoul@kernel.org>, Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1592356288-42064-1-git-send-email-Sanju.Mehta@amd.com>
 <1592356288-42064-4-git-send-email-Sanju.Mehta@amd.com>
 <20200703074200.GL273932@vkoul-mobl>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <16f6f41f-8a3a-ee5d-9c2c-2f2e96ae367d@amd.com>
Date:   Mon, 24 Aug 2020 13:55:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200703074200.GL273932@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::21) To BN8PR12MB3540.namprd12.prod.outlook.com
 (2603:10b6:408:6c::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BM1PR0101CA0059.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 08:25:24 +0000
X-Originating-IP: [165.204.159.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 09d74bca-96da-4796-2690-08d8480741bb
X-MS-TrafficTypeDiagnostic: BN6PR12MB1460:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB14602BFCFEE308F849215DDAE5560@BN6PR12MB1460.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RKtIyys01F8lShyJLF7E4Qvk4tia1LnCbrgSGaD5zn9A07IFGMpT0bqscL71Z5NdnGeRyxJMeI5SNvLOiHaM47o/ThEOdt8URbQbB+XZXZZxI1PEJpb2VNKtDzplg/JOr0VmqKgXGehyvRYEKTUi5Wla7slSFz2EBU1IkXMIljPadF1BW28E6G/vfbb8kpJUZdwOLI3Ks9AYoZtfPl/nRH3ca7arXc9FnQ4YZPVzQeDfGYlVJlhE9agurEP2j0XY4kS9f30mDHdnPWbPuTP+qpAJCeiqy1lbY/35cpXiPkwSBZV8fVNlBvxRsqYD4G4H3WdkktSBDmXan2EAwoYW+YgQwxeYAOA3WyFJCjndjglMehbRF/DA47F5O1sW5w3t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3540.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(4326008)(16576012)(8676002)(83380400001)(110136005)(8936002)(6486002)(31696002)(316002)(478600001)(36756003)(52116002)(66556008)(6666004)(26005)(186003)(53546011)(956004)(31686004)(66476007)(5660300002)(66946007)(2616005)(6636002)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: l/9A7KyW7Zq7DAxY4dhY4GMX/9XAoD5jbGStse8JiaynDuAWCVVRj8bgq9elSrCQHzxhe37uf9LnRQuPKNYJ7AS4WvjRynBGYYHh5atKLiEHsGrdfjdC9puL4rGD71DYa6lOpP3/9s5M/lNVip3ZYTQbjvFKPV1urHYslkjTszcFe0G4Zqpa2txYZsdrZWPgSauiyEw+d+tQwaVhX2RAZpBE4AEO1R6AZmVyFj/esuBNSkAAT9qQVi61Ij0vpZNGUYsm73magSnYMAqTUpt8Rwe4qj1C2Wrwo9AycstKBIUrJwFJtB6KevPb4C4PZgpLh6FR5bTZYCPInwArFZh5ysNyFmrVMujAi6umjlSwkzI4W8iOgOBAddbBfIUmlGlk1wsYB3tiYmwiv6+KrFHKul1SHTGHpMXMP92aDDWXNTQvf1nX8rBb8bbFd19AtlCEueuu3xDnNddvDrfmqd/iLhSm+sZqC63dhvy8TnzTlu6YaHqq3ZY7oAi4NHL01hsTwwKt/K5mcSlvnnYbvyluVKm8MGyWR0wB/7yPd4oTA9d/tUC0zmKWtXG4owIYUrTvcvYMeb2cxqnrZzIVzrfYBaJ8475oO3Ds0t7HUf1ZUmm6DEUHuGnKUBXUqe36AeHh+x9Z0QNFxACooQeypDJ86Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d74bca-96da-4796-2690-08d8480741bb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3540.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 08:25:27.9299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urN5t5Ax/eqesBR/SR7T9jirb6IEx2AV74ENAxIMHDqmrKluZAgnXBEXTXamqa+FY8CCqFAYdGTgVjJaJBzImg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1460
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> 
> On 16-06-20, 20:11, Sanjay R Mehta wrote:
>> From: Sanjay R Mehta <sanju.mehta@amd.com>
>>
>> Expose data about the configuration and operation of the
>> PTDMA through debugfs entries: device name, capabilities,
>> configuration, statistics.
>>
>> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
>> ---
>>  drivers/dma/ptdma/Makefile        |   3 +-
>>  drivers/dma/ptdma/ptdma-debugfs.c | 130 ++++++++++++++++++++++++++++++++++++++
>>  drivers/dma/ptdma/ptdma-dev.c     |   8 +++
>>  drivers/dma/ptdma/ptdma.h         |   9 +++
>>  4 files changed, 149 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
>>
>> diff --git a/drivers/dma/ptdma/Makefile b/drivers/dma/ptdma/Makefile
>> index 6fcb4ad..60e7c10 100644
>> --- a/drivers/dma/ptdma/Makefile
>> +++ b/drivers/dma/ptdma/Makefile
>> @@ -6,6 +6,7 @@
>>  obj-$(CONFIG_AMD_PTDMA) += ptdma.o
>>
>>  ptdma-objs := ptdma-dev.o \
>> -           ptdma-dmaengine.o
>> +           ptdma-dmaengine.o \
>> +           ptdma-debugfs.o
>>
>>  ptdma-$(CONFIG_PCI) += ptdma-pci.o
>> diff --git a/drivers/dma/ptdma/ptdma-debugfs.c b/drivers/dma/ptdma/ptdma-debugfs.c
>> new file mode 100644
>> index 0000000..506c148b
>> --- /dev/null
>> +++ b/drivers/dma/ptdma/ptdma-debugfs.c
>> @@ -0,0 +1,130 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * AMD Passthrough DMA device driver
>> + * -- Based on the CCP driver
>> + *
>> + * Copyright (C) 2016,2020 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Sanjay R Mehta <sanju.mehta@amd.com>
>> + * Author: Gary R Hook <gary.hook@amd.com>
>> + */
>> +
>> +#include <linux/debugfs.h>
>> +#include <linux/seq_file.h>
>> +
>> +#include "ptdma.h"
>> +
>> +/* DebugFS helpers */
>> +#define      MAX_NAME_LEN    20
>> +#define      RI_VERSION_NUM  0x0000003F
>> +
>> +#define      RI_NUM_VQM      0x00078000
>> +#define      RI_NVQM_SHIFT   15
>> +
>> +static struct dentry *pt_debugfs_dir;
>> +static DEFINE_MUTEX(pt_debugfs_lock);
>> +
>> +static int pt_debugfs_info_show(struct seq_file *s, void *p)
>> +{
>> +     struct pt_device *pt = s->private;
>> +     unsigned int regval;
>> +
>> +     if (!pt)
>> +             return 0;
>> +
>> +     seq_printf(s, "Device name: %s\n", pt->name);
>> +     seq_printf(s, "   # Queues: %d\n", 1);
>> +     seq_printf(s, "     # Cmds: %d\n", pt->cmd_count);
>> +
>> +     regval = ioread32(pt->io_regs + CMD_PT_VERSION);
>> +
>> +     seq_printf(s, "    Version: %d\n", regval & RI_VERSION_NUM);
>> +     seq_puts(s, "    Engines:");
>> +     seq_puts(s, "\n");
>> +     seq_printf(s, "     Queues: %d\n", (regval & RI_NUM_VQM) >> RI_NVQM_SHIFT);
>> +
>> +     return 0;
>> +}
>> +
>> +/*
>> + * Return a formatted buffer containing the current
>> + * statistics of queue for PTDMA
>> + */
>> +static int pt_debugfs_stats_show(struct seq_file *s, void *p)
>> +{
>> +     struct pt_device *pt = s->private;
>> +
>> +     seq_printf(s, "Total Interrupts Handled: %ld\n", pt->total_interrupts);
>> +
>> +     return 0;
>> +}
>> +
>> +static int pt_debugfs_queue_show(struct seq_file *s, void *p)
>> +
>> +{
>> +     struct pt_cmd_queue *cmd_q = s->private;
>> +     unsigned int regval;
>> +
>> +     if (!cmd_q)
>> +             return 0;
>> +
>> +     seq_printf(s, "               Pass-Thru: %ld\n", cmd_q->total_pt_ops);
>> +
>> +     regval = ioread32(cmd_q->reg_int_enable);
>> +
>> +     seq_puts(s, "      Enabled Interrupts:");
>> +     if (regval & INT_EMPTY_QUEUE)
>> +             seq_puts(s, " EMPTY");
>> +     if (regval & INT_QUEUE_STOPPED)
>> +             seq_puts(s, " STOPPED");
>> +     if (regval & INT_ERROR)
>> +             seq_puts(s, " ERROR");
>> +     if (regval & INT_COMPLETION)
>> +             seq_puts(s, " COMPLETION");
>> +     seq_puts(s, "\n");
>> +
>> +     return 0;
>> +}
>> +
>> +DEFINE_SHOW_ATTRIBUTE(pt_debugfs_info);
>> +DEFINE_SHOW_ATTRIBUTE(pt_debugfs_queue);
>> +DEFINE_SHOW_ATTRIBUTE(pt_debugfs_stats);
>> +
>> +void ptdma_debugfs_setup(struct pt_device *pt)
>> +{
>> +     struct pt_cmd_queue *cmd_q;
>> +     char name[MAX_NAME_LEN + 1];
>> +     struct dentry *debugfs_q_instance;
>> +
>> +     if (!debugfs_initialized())
>> +             return;
>> +
>> +     mutex_lock(&pt_debugfs_lock);
>> +     if (!pt_debugfs_dir)
>> +             pt_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
> 
> please do not create your own, you already have one under
> /sys/kernel/debug/dmaengine/<>/ use that :)
> 
Thanks :). Will fix this in the next version of patch.

>> +     mutex_unlock(&pt_debugfs_lock);
>> +
>> +     pt->dma_dev.dbg_dev_root = debugfs_create_dir(pt->name, pt_debugfs_dir);
> 
> argh, this is already created by core and you leaked that one and added
> your own!
> 
Will fix this in the next version of patch.

> --
> ~Vinod
> 
