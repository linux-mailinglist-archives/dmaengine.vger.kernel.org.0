Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16411E1AFD
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2020 08:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgEZGK2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 May 2020 02:10:28 -0400
Received: from mail-bn8nam11on2065.outbound.protection.outlook.com ([40.107.236.65]:39136
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726207AbgEZGK2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 May 2020 02:10:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVM5xHMTq7eu2xPtIBszwAdtDXd/6lMZaqrMlFJyMCVmr4vLQFPGL0T2DJ0be3TA4rNtEO0GkC4de6J8TgDEV23ak2nyF8UHY2GgZoDqU0jxCYfod5pqhFLlsxJeo9HjgDRBwhM/qi/Ggusg7VuX+cwGNMQX90QWuisZEJoFBxCWnlSaDI79FJCrjQLqoSHLUgwenGcESbmpRlMrzHtHrP0u66daZQ+GAjTSupWNddsrwO4sKPHHeRscGkBr/WS6qmG3+TOdKK+vpjWXzJ4hVUQecHw035nLUc/Eykq4x1qc+MZjsvB/oTj9b0FLdcWSsXGslP+aeku3v2y6BJ0fyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVdE3LEia6LaEeCUMw1Ox1io46n8dusWNR4GW1NtiBM=;
 b=drTwubObJJgowZuLkVeQmBH2lQVwgxaMWHleWzEDx+6QMQCgORO9neWV6/0BbUbFg2653QKBa4i8jSXF7GltrZSNy10j1Fz6gYW1ZmdrW6faedRhx/TcXeyQWHGxGdsKoo0/6M7Jc0S3G+0KvPgJz434Hr5ppplc9B2seGLSmw2gyPmR2L3m3SKopXE3RUw7cdDx7Yvpzae0LuUJVb/YNEXcg3uLZnKv34v9ge9mvGCji/Nzrb6JruEdvBbGYtnbe9Gycd0f5F8EKT+P7w5aEH4QIAoNDKJKWXlnToACNCO6qP6C7cu/8mT6aBNH0xozMK8tIWiM0aa1eMht0Pluhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVdE3LEia6LaEeCUMw1Ox1io46n8dusWNR4GW1NtiBM=;
 b=eqK3SQsgRZ1Me6bzbPShbipk+xmIGYvnmu5uxZbV6zaJR6Hk3kj2yVq135eXjy/RtV+n8e8SATgkt1dIyry5Qwc0aiFKbjJw0zBEfvim43NNe1hPE/qHqMEtfbLilkBpDqm5Xob1o5P7Z7RjL0m+IHkoMkB2EVMo/SHSpE9225w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3420.namprd12.prod.outlook.com (2603:10b6:5:3a::27) by
 DM6PR12MB3291.namprd12.prod.outlook.com (2603:10b6:5:186::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24; Tue, 26 May 2020 06:10:24 +0000
Received: from DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::d007:1b50:9d7c:632f]) by DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::d007:1b50:9d7c:632f%5]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 06:10:24 +0000
Subject: Re: [PATCH v4 3/3] dmaengine: ptdma: Add debugfs entries for PTDMA
 information
To:     Vinod Koul <vkoul@kernel.org>, Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1588108416-49050-1-git-send-email-Sanju.Mehta@amd.com>
 <1588108416-49050-4-git-send-email-Sanju.Mehta@amd.com>
 <20200504062002.GL1375924@vkoul-mobl>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <280220fd-9780-e2b4-7a5a-26f3a0119c43@amd.com>
Date:   Tue, 26 May 2020 11:40:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200504062002.GL1375924@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::25) To DM6PR12MB3420.namprd12.prod.outlook.com
 (2603:10b6:5:3a::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:7400:70:65d3::1] (2406:7400:70:65d3::1) by BMXPR01CA0061.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2c::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend Transport; Tue, 26 May 2020 06:10:18 +0000
X-Originating-IP: [2406:7400:70:65d3::1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0aa435aa-2cad-4522-e4e0-08d8013b7a73
X-MS-TrafficTypeDiagnostic: DM6PR12MB3291:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB329175B0D9E64EE28C4DD9DDE5B00@DM6PR12MB3291.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5sqVS8LgW5zwGpRWyKjRhEF0eW8fmeVc1U2DoEvSgtLGCz/lSzpbS3yUEjGFPkey52A4FVNEfhIF33i1IVMKDdf/c7S3Fi6/kcz+2ZqghTThHPgUw7mdzC0lJB7F2tMOilwOi0BUC47a0JJCI5/qS8ohAGkDoV3QTR/8MIdcPFRjcf5WlCjAzenZ8zDZecvn7wCXegk/SrU9tECYKWyB2jEdJqqzhyaQ9D4gETD9Wh83wtI+uv2QJ7HKWTb3tD3+0INtHUnYaEcuByVteH/9TOto/lE42WSDQLS/TJYccXAHQfL/bARccoQXOL1z/BYoSCU032XQq8Unw9sYLqWnRj+7ELMHbIeK1DBMF0Hrh1Jb/sPv9N0/S7G1bclrV0oz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3420.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(36756003)(8936002)(2616005)(110136005)(8676002)(316002)(4326008)(478600001)(2906002)(31696002)(6666004)(6486002)(6636002)(66556008)(66476007)(66946007)(52116002)(5660300002)(16526019)(186003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: roIws0FCNRzp0/2Nqt1CZTQRM2olUAatpl427LEl/5xlZoNKoJcT5zQCtLBCFWuGGRUHYsfgyQb1a94JVIQtmQ/jwbuypmSPex9Sc6mTTcHyFZ3qlMtT+uq7PkwntNht5dPDQyrJuapODiUK+5R+xqjbtaUxKb5X2SFSkjunPQLDRW0uGYlKvk+WwCtRUFtUKJRJ9jwAP/G9lD4dTpslKAKXD704ttnC9TYAJ5opD//mDQv7F7LaLgwD3M5A4cKhNrjZv0/idDF9Y8ThmuB1ryh3W6FsqXhDp95k70KB17/dVslFbtWyfZcvkUrGKp10pNCqrEabcxbkevRHUN0qAl1e4BHEdWlFfzACX8z1VNdTfkzacJcGFxmw2O3RdxOO5I8sNGmG89SYeLcExSr+DK5+BNP0S99JCeFji7VNeRdta3hzwaXVvK/cjaAOTk56y4kfSNyTaBaDRz3+q90WEdpfADlvs82FXqCFbgceqz5twuz2ZtIDEFrmZG48Jds/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa435aa-2cad-4522-e4e0-08d8013b7a73
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 06:10:24.3188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjEnk7euP4VqtFCbQe5FcU5KSmYa22Nq3qEb3bnavcB/LztiakpbxmWl0Aldi1zVxuMLDTcXS3ufkDQICJlTDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3291
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

>> +static const struct file_operations pt_debugfs_info_ops = {
>> +     .owner = THIS_MODULE,
>> +     .open = simple_open,
>> +     .read = ptdma_debugfs_info_read,
>> +     .write = NULL,
>> +};
>> +
>> +static const struct file_operations pt_debugfs_queue_ops = {
>> +     .owner = THIS_MODULE,
>> +     .open = simple_open,
>> +     .read = ptdma_debugfs_queue_read,
>> +     .write = ptdma_debugfs_queue_write,
>> +};
>> +
>> +static const struct file_operations pt_debugfs_stats_ops = {
>> +     .owner = THIS_MODULE,
>> +     .open = simple_open,
>> +     .read = ptdma_debugfs_stats_read,
>> +     .write = ptdma_debugfs_stats_write,
>> +};
> 
> pls convert to use DEFINE_SHOW_ATTRIBUTE()
> 
Sure, will incorporate the changes in next version of patch.

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
>> +     mutex_unlock(&pt_debugfs_lock);
>> +
>> +     pt->debugfs_instance = debugfs_create_dir(pt->name, pt_debugfs_dir);
>> +
>> +     debugfs_create_file("info", 0400, pt->debugfs_instance, pt,
>> +                         &pt_debugfs_info_ops);
>> +
>> +     debugfs_create_file("stats", 0600, pt->debugfs_instance, pt,
>> +                         &pt_debugfs_stats_ops);
>> +
>> +     cmd_q = &pt->cmd_q;
>> +
>> +     snprintf(name, MAX_NAME_LEN - 1, "q");
>> +
>> +     debugfs_q_instance =
>> +             debugfs_create_dir(name, pt->debugfs_instance);
>> +
>> +     debugfs_create_file("stats", 0600, debugfs_q_instance, cmd_q,
>> +                         &pt_debugfs_queue_ops);
> 
> Pls use dbg_dev_root in struct dma_device as root for your own debugfs
> 
Sure, will incorporate the changes in next version of patch.

> Thanks
> --
> ~Vinod
> 
