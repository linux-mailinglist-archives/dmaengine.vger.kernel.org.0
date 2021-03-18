Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11F03403C6
	for <lists+dmaengine@lfdr.de>; Thu, 18 Mar 2021 11:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCRKr2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Mar 2021 06:47:28 -0400
Received: from mail-bn8nam11on2042.outbound.protection.outlook.com ([40.107.236.42]:42802
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230079AbhCRKrD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 18 Mar 2021 06:47:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmt7a2V1OFydIqfALFRxU1Du8Jrgx4uFGXKbEdxfR5d2JcS0T4a5VeuML+wrbQV5SSIeoAa3MUHdj4NicqWuYoIE3Zr+oBxlOu2Om9zm42hHsJgl0BHN5Y4aLs3SYr1XzcJUxPV2Nx7yrgUVNJ77e6bLTHmcqJ/ReqWtOzIMCbrgF6nUJp+xe9v76vkB30IlvWT5f6KqJm7g4VgVJ3ZyF995y3pSupYFib/MZ/pHI7nbdQDA/Bew/t3tkW9BFui5SfnFQZ8ZlnGVKXg3s2XnT7ZclLr0d1doAh5JDeCgISY43/D+/+KxAYHlK55maqXeSmlMbw3oUT6LeK5jRZ7RyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1ZMW2sdvo8GmGSfcyOKlSiRZYR9Pm67Hu4OG6/42oM=;
 b=OREwh7PxU36Q2y8CIrsoAGZw/1iRg6KAWCydeLGgzlwuE/GJELhRTkbFWNZAlQafZCFhfts/WgDVjXQb6oCVzmiFka2Klt+n6JDJaRn7u/Bv1ZSM38OA5f3cZURiYHZ+Ua/DLMlW/k9BeMTBIn7C+RO6sK1t3mgoJaQd3fs9Jkcvmx2J53UkXp3O+ebCmIVJdqoLw6a4WUege1oaJOII0yxJ2mzjyDkaxzJjWB1XDTNkhEI3f1Zh2mWfMWuJYEfdJh+kW7YnA1poBKgHEeGC3vfQqMamaoQVQb+C4JbPEuBRaYs2fzDV5RO0Iwy9bm8QIL8IhctUCmWN71nf0Jkbgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1ZMW2sdvo8GmGSfcyOKlSiRZYR9Pm67Hu4OG6/42oM=;
 b=F5fcJNXfnLjp2DBxJRBx09paeE7pL9HXPIZcxLjzuF/4f/cvVXySVWcERxYawH+Rc1hmK8zpDfOuIAih1wCjCoshPwE/72hAd81uJvBdzdB6MzcF4Y7EhQa9mCOWgM3MF4mkHgGIeIKNBZyH1lhNMcbarZWlhPpcaNJn+KJYstg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB2549.namprd12.prod.outlook.com
 (2603:10b6:903:da::10) by CY4PR1201MB2549.namprd12.prod.outlook.com
 (2603:10b6:903:da::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 10:47:01 +0000
Received: from CY4PR1201MB2549.namprd12.prod.outlook.com
 ([fe80::e974:eaaf:2994:ccb6]) by CY4PR1201MB2549.namprd12.prod.outlook.com
 ([fe80::e974:eaaf:2994:ccb6%4]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 10:47:01 +0000
Subject: Re: [PATCH v7 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
To:     Vinod Koul <vkoul@kernel.org>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1602833947-82021-1-git-send-email-Sanju.Mehta@amd.com>
 <1602833947-82021-2-git-send-email-Sanju.Mehta@amd.com>
 <20201118115545.GQ50232@vkoul-mobl>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <5605dae6-3dde-17f9-35c8-7973106b9bea@amd.com>
Date:   Thu, 18 Mar 2021 16:16:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <20201118115545.GQ50232@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: BMXPR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::11) To CY4PR1201MB2549.namprd12.prod.outlook.com
 (2603:10b6:903:da::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.32.35] (165.204.159.242) by BMXPR01CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:c::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 10:46:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5deae115-472e-4e53-9120-08d8e9fb28f9
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2549:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2549839258BB3954C9274221E5699@CY4PR1201MB2549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eHTRobCjVwFaF5Y9lOtpsFL1tnyBtuVIolyV43uPwoyRmpC+kpVMZF0NEX+2+QUix5ZwW2t+uM/Y5ncjt1XK/FThM3LbnGodHqMRrG55gL3leHZvOA6FjjLim2RXl4C7RNQpMG0eB0TtX/UF9r4/EQvefvDaCOtVlylVRQfxfKFtFggisp6V6ZVD7W0JQ1IpWLExrGQgUJUqk4KCJCXY4pR0sQ+Ph4Hy1RLvxLn1zEiFTVBf6ssg+wNSCTSBDs5m+Eag3CYu4RJblaiAvBUa/V8BoVlPtb0j05qmggd7NzGcJkhmHu2Rb4Krvw/jorvbXiaRU3Lic7/NM+grctOk5aPAcoxjfoPk0T32ygYaMJS+Hz8bwfVynBK8hEMZWhcTuojuWvoQTVYrdH0O0q+0jrNYx1tH+NgW0R5nJVnvR2WCiHzl/QAiW4pZWsAGhRDhiWIBoZu5wUa16djBbHoEug0M1782dci7o/5fC1WyIzv+5sYySJlUZf5ptWGaVYZWSplCobqTQNj/zEBAWT4Sy/LbjLNTfLEQYYb12c8ACIq9G+8ZX2QY+8cZ3S8OfW3Q1ub/9PZZLERfQNtHKN77H0+8bwNEILmi+4O7S6FIg1AnIZh4PIKhtPEIE9SGqNl44X1qNoJTqQqO1FbMqNcX6BsxEg0Dl/Q5eU3kUZ7ibuQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB2549.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(31686004)(36756003)(16526019)(316002)(8936002)(6666004)(6486002)(478600001)(38100700001)(83380400001)(186003)(26005)(52116002)(66946007)(16576012)(2616005)(956004)(6916009)(4326008)(8676002)(5660300002)(66556008)(66476007)(2906002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OUtzblFZRm9MQ2krbkQxQUl1REFIL1lEeE5ybTc0MU12RGFTbHVsMUhBSHE0?=
 =?utf-8?B?MXBSZW43aHpSTCt2SFpXTEJGSFBIa1dLR2pncElXWWVicjdKZnVpRzEvc3Rz?=
 =?utf-8?B?NnFIZ1dFRFRPZ1IvajZTNkRPalpua2x5QmRoMk5DNzRPM2RueS9ocGtkaEFn?=
 =?utf-8?B?bEpXUW1rQ2pWWkZtOHdMMTJqNkR2Z2NQRytpb1BJclU4ZW0rT0N2L3hWZnQ4?=
 =?utf-8?B?bU4vbDBjNklYcmt3RXBBZTNtQ2NXUG42Q0U4d2cwZ0hJYzJBQ2h5QVJWNzNW?=
 =?utf-8?B?R0RCenNGOWxmMEZCMC9WRThtRzRBcjRKWWZDVzFOd0ZvWis4cnh3MXdpL1No?=
 =?utf-8?B?eEtpK2N2M0FZMnBaRTFQR3Jxb2pteFdxbkt0b2svU1pOc2VMUUZaWnEvbXp6?=
 =?utf-8?B?MmhZajBqR2RtSWU1YWllajNuUU1DM0hsdFdIQklrYktFbzI0M1BLdkl0ay9G?=
 =?utf-8?B?OXYyOVlFc1doMjlHWk9zenBvMDdHMnYxWkJ3R2dPMVcyK1ZubkhZbjA1aXpF?=
 =?utf-8?B?eDFNT1FOdk1MbDRGY0ZSOWJ3THJGNWRSdnd6T1cwYmdOeGc0eG1EL042L0RW?=
 =?utf-8?B?ZDFIbXVLeTlJaktIR2hWZzlwdXVHRnJXZlJ6SXFuRXVEeThCWHJjbmxsdUM0?=
 =?utf-8?B?K3d2QStLVDE5Y0kxUlBaeTYvZHdnT2NWMWJ1ZzlLMWhmbnZVK0tXekEzZE92?=
 =?utf-8?B?ZmJoNU5tRWd2VWlIM2JQNGs0eGlUOFJNMlVWOWNxL0ZuMVRQN2ZnSmE3THkr?=
 =?utf-8?B?YVJHd2l3OHlQNDd0MnY0S0wyVFpoaFZ2cU81ZDJrb3BZRUFGTXJxY3lud0JY?=
 =?utf-8?B?enB5d3FDVXFNWjh2WCtyUzUvbk16ZXRWWnV2TjVoaWVDMVpsOUVKdHRGdFc4?=
 =?utf-8?B?L1dnZ1hoeDRKdjlHY0tacFdSL1hsc1VxSEFPZXlneTl5ZUx6aFdUem0rdUx2?=
 =?utf-8?B?NU85TDVHR05XcFIvRjhBcnBGNlh1cTBVb2liZHJUYU4rK001TTlxc2hqbHhq?=
 =?utf-8?B?T1NEQXFsVTQ2cmNmT29URlhRandmL1RaMzZVZEkzeiszbkVna2lXaHMyQldo?=
 =?utf-8?B?MkVEZVZ2Zjk3OXpCN0RVOTVoRFZoWGo5QjVXdUs1TzRBN2NBWmdNK21sTll2?=
 =?utf-8?B?b01GRkR3aCtvSmNGUFVHeXVwR05XSS9MZ3NXeTgxdXJQL0t6RHIzRkduREE3?=
 =?utf-8?B?T1hjTHFuM1ZRRko5ZWVwaitwem9iTlNtWjFnYnBZbVRuU3g0UE04R3VTNzRR?=
 =?utf-8?B?cGNsRFdLYVdGUjNiYjlhUFJBOHRZcmMwR01PWVYvdUdlUjB1a2JHRHdHeGdk?=
 =?utf-8?B?NjJKOFJDaWJrczRsOWY0RVZXazRaSFVuU0RQSTd3QUVYZ3lqYWVBM01wT1lH?=
 =?utf-8?B?YW1RaHo2RlVtK2MwclVEVnJTNlh4ZUIwdmoyTVpnb0xKajVLMnI2cWc3dEVy?=
 =?utf-8?B?TGQ3WUIyVGNIbGZmWkM2am0yaGJRQVdidWtqakhPWXJRbWlsTjlBdkQyaytm?=
 =?utf-8?B?Z2JyOW5vS1k5MmMvUjl6NTRySTRoQTdlci93NWJGYWpPQUR6OE9QREhMYnRz?=
 =?utf-8?B?Mk1sUndVOTZjdEwvL2tDQVU2MkFCUXlLZEtkKzlHRkppZHVDL1kreGdMTVVG?=
 =?utf-8?B?Y1daRFRxRVJSUU9MWUJEWTJSOFcxWnR6WjVUazBSMERJN2dCdy9sSllmT0Vm?=
 =?utf-8?B?OWIyZnh5U3Y2NGoxdFo2ZmlxdnUvcGV2cEUwWkk3OElsT25ycVVneFZGcmdn?=
 =?utf-8?Q?WbR2QoWHEeo6OoDTai8Wkyi2hsf2jfLbPl8Hx/l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5deae115-472e-4e53-9120-08d8e9fb28f9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB2549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 10:47:01.1840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkSLRnEmwpAAmJY+7n6/JCv4d1ICQ7pPLES6yi29yx4DW9FicSvnZfldpr5ZVSD9ijjFC/7P2AmHvnEJExJVcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2549
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/kthread.h>
>> +#include <linux/module.h>
>> +#include <linux/pci_ids.h>
>> +#include <linux/pci.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/sched.h>
> 
> why do you need sched.h here?
> 
>> +
>> +#include "ptdma.h"
>> +
>> +/* Ever-increasing value to produce unique unit numbers */
>> +static atomic_t pt_ordinal;
> 
> What is the need of that?
> 

The "pt_ordinal" is incremented for each DMA instances and its number is used only to assign device name for each instances.
This same device name is passed as a string parameter in many places in code like while using request_irq(), dma_pool_create() and in debugfs.

Also, I have implemented all of the comments for this patch except this. if this is fine, will send the next version for review.


Thanks,
Sanjay Mehta


>> +static int pt_get_irqs(struct pt_device *pt)
>> +{
>> +     struct device *dev = pt->dev;
>> +     int ret;
>> +
>> +     ret = pt_get_msix_irqs(pt);
>> +     if (!ret)
>> +             return 0;
>> +
>> +     /* Couldn't get MSI-X vectors, try MSI */
>> +     dev_dbg(dev, "could not enable MSI-X (%d), trying MSI\n", ret);
>> +     ret = pt_get_msi_irq(pt);


