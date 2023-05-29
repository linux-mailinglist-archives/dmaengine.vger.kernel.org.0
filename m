Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1629E714FFB
	for <lists+dmaengine@lfdr.de>; Mon, 29 May 2023 21:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjE2Tuy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 May 2023 15:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjE2Tux (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 May 2023 15:50:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9197FD9;
        Mon, 29 May 2023 12:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgB7oOymIP23NtE0hNUJRdCCXxjFYrpzi/TS1NKNyAHWVeJy0d9Fo8zGig8WNrg0S4+tk28QndK+gg4L1C2FuIwOjIXvFULXYpZfcw0rlguUwcIR/qBPwg4B2MHlIOgG/UuytH7bBTfYPCI09JGllhRyHul28UC9ctCASiboO514kYlL8L5uaG4kkteuY5DNxFQKQh/zvxtv3MOcQdqxkmINTrRDPsXxvVp1+03TNTzU6PsTY8AL7g8UQd/wYBkRqBgaujR8HDymvnnJsZW1/UFZbIcW1dtuopTnVf6IPmKILt3hi6FOm11Gh0+tA+V1FY6ARYBBSqHbcpER2Ul3wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dH+M3MQBhcdghQVtg6WYb37sKSEe1jId4ypZcAb7R6I=;
 b=EeU7DROnZIMyW4HIxXv/TLO/1IK0cj48CBC74dlS2adxCYhNhzgybEvVbMEelkGk231YCue6Mitt/2sYQ7w2JSO2Zsz5yoQgaXWqQ21h8rUYpYPrPCJT+9QUmmn8a59Ri0GOJT+pyB/etOwWSksXXauDOzFmlDH+g6b80hSPmTFlMQGcU889mSO4cPEXA+yQvPsRq661xJGQBpibsOqgvp45axbWtqtwoDv+bCYfA9Be9s7KpRymXgGPdzejg61g0f7TMm6ty9Z71YK/q1Vk7Ci3WJ4jShmxYhX0Hze6vmXafMrq/Q7LBneDPJpwDEMlz1WlhiywBFg5DLgcnNLqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dH+M3MQBhcdghQVtg6WYb37sKSEe1jId4ypZcAb7R6I=;
 b=RQ9Uv66Ijf5W/iyU+B8jGHsrGfIO++bR2CuHYQfPBUhnP9vlNftmXe6LvWzMxKjoYeoeivQi8t7nbzj0yDZVvCrh+DIx5ZXd7wlpq3Ga4j2yCu7OxCnwi2U4IcRfG9HdOhU/r5TFC7Cs06h0oYPaa0mwhfI03FIYPsdtrlXkhENx2Y52OVeudQWBS8BsjfzKWqxS5VaUWqleeDyGWqzmduJ+ymvbNht/eX8cQblhFhTpRl59XK0NNitxH3fAZVdGz/foSo9BWult+1hKAJjau0QxbaDol8Gkrj54S5q2CqjEbVy9A5vRaI1q+yl3LFk81AIXJWv0nEQmLArvlxyH+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Mon, 29 May
 2023 19:50:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.017; Mon, 29 May 2023
 19:50:50 +0000
Date:   Mon, 29 May 2023 16:50:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        narayan.ranganathan@intel.com
Subject: Re: [PATCH v6 1/4] iommu: Generalize default PCIe requester ID PASID
Message-ID: <ZHUCGFIpGp5Kku1S@nvidia.com>
References: <20230519203223.2777255-1-jacob.jun.pan@linux.intel.com>
 <20230519203223.2777255-2-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519203223.2777255-2-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: YT2PR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: ed10d3b4-df14-433e-facf-08db607e0120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXtnMCx7VUTv9QBek06ojR++wSdM6pROLaich6mGMIvNvgwjonFaCUxjSeuOnlkT6Ut6+JMWZT6rOW3Bw2kO0a/JbxRFJXF9tFo/E9wO/gWsHpRwBEHaR5MQWh+t8pC3f0uv55ct+ds40R5etcdxvcH3euezNY3WWWtTD4mWbpZ6OGtN+TiK/EZFW8zpA+655C0xHeWV6e6gHSvwgd3/MJYzjDdQZf9+tNx0o9CeZ1/pjy90x1Mhxpn3OgneGOZ6inGERc3h/mKUXFYDwvfYuz/qBxncsbQ0U3mBHQLdYuam2Djp2yWAzUbJlvVVyYlsENNK2LK0kGY75MVp5ZCCk03ctP8+eIPV90CzbVl/Eb9+1LCYJpW2qPSeoUeslU46qriqvjqt+Hgzfu9oj5pjs/ouVDFaZkFDDXzDrdWlZAHWcYzTZh2Pk5OIAofxKX3VvZ1hVGzMfKNWvAYDhCC1Ja/5ak0wSW80sldnHcphIEU9F8Tr970b5OTbdfVr+R0GB3/IQ5/Tj97BN40dKzvdKgxXVAxwdkBchhPrQ5LW3CSzCWzuSIqFmh1MzwBj/VnB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199021)(8936002)(8676002)(6486002)(86362001)(41300700001)(6916009)(4326008)(316002)(66556008)(66476007)(66946007)(7416002)(36756003)(5660300002)(186003)(2906002)(6506007)(6512007)(2616005)(26005)(83380400001)(38100700002)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RQqPrHruF4vc38uRlYQ/msuyoLcV8vKN89gNKi7nowCZO/Habw4FF09dGFxB?=
 =?us-ascii?Q?8d/FnCcHxt8HLoi73zAAoyU46iQ4QYK/I39xfYhxzpNPLYx+Z2Hmnsf+l3hT?=
 =?us-ascii?Q?liOHFWcXRqi9VHKvcWueiN+GUEQW/AM3XCxzsRTvRHxnTRu2qRKiH7c3/2HW?=
 =?us-ascii?Q?tXhI9P/IBSpsc2ZohcriOK6Jimdg9i3mHJpa7rE/kf+/c1xsgJBfZAUCl8S1?=
 =?us-ascii?Q?0H79IuS2utKXGngxHVtNjIjA+U15Zxjja7v7KkRQbCKi/xgAG0Frz2kiksZs?=
 =?us-ascii?Q?1vbsp5CZEDysFhS9czUY3fFcncaz9ytxUosJPLQeGObq3fXQRjJsHJw5Rtqy?=
 =?us-ascii?Q?FvGAxbt7OHzfYdH1oQgP7mIBgoCy9ErEu5zrDAZnw5czZoPAazFnW+lxUtcS?=
 =?us-ascii?Q?RSrw42z3ZDz8Ld596pMcGc+sIOzUwE6obtcv1/8qY4FHz69iN/BqaOG0QHyq?=
 =?us-ascii?Q?yUX1slffELv9tNiBo08h5g4P5Q2IspG7yT37J05iVqcvNPmHaS3Hg5mITcJI?=
 =?us-ascii?Q?lc32mFEACiU9uQ+1Ph5ZTbMZhYKj1FVFtLui15riOoPwIcCGvurdnks+rNB2?=
 =?us-ascii?Q?hwB6CpHxwhH1RMwlOk+y9ogMM9vyRVhL6rK4e8Ei1FcrFSKEqzqVyLbD8t6o?=
 =?us-ascii?Q?q18G7BYgF6xsKjuAcRlTYOy90NiC8NGwmx2jozH01IMeYCM1+s8g5sNrj2+t?=
 =?us-ascii?Q?S0YcX7KWC76M3SzcGKNbVvXS4pjVqDOQfnU6mRtbJkmd0XIbsgAxeANYFmai?=
 =?us-ascii?Q?fZHYsiCOUn6nhqsKF+Ruw3pIrzWPrrG20CKKLa/hifAPjLnowpqumCD7S6Ym?=
 =?us-ascii?Q?Yk825jJfS8STtm7ukEDxzM4r6yeFgZe2cI0A8J0Ha7NrICZjIUHol1k5b0DF?=
 =?us-ascii?Q?7tE5KEN5hPp8bfwYq9QOX6hwxSIXmTThQslT9VDhVXLYgvUPbYNgk0e+z8l0?=
 =?us-ascii?Q?ksao5aw1H8N20ecH5StdFsXx3FjjtAyLi0CgeOTa/uxP7ifRvlmLEawVol42?=
 =?us-ascii?Q?FWqq4JUtN5khf46Xmry4yEyi2xFhfhWmhX7qj/7wsOTLuxRxzWOCtLUKhpXc?=
 =?us-ascii?Q?3l5f5RTcFFdMu/brqvN5EgryVN6KzOeR1V4mk4W+NwzkgEffO1cCiKkronh5?=
 =?us-ascii?Q?eBFFHGyNvGi/nzHt+qAcMZzf7fJB9KI7mg38oMPjNytWnuOponafZtNiOnEF?=
 =?us-ascii?Q?eEXj/06srzrB0ut0fSIVA9RBguvI+lNyOVe2ss6eQ4aXvI+qzQ1npyGInrNV?=
 =?us-ascii?Q?+Z9syuFjbTLf7/TmRziUiB8K5NrsBsBGNuXldsDMeHlNH439nt9FivjGq0ga?=
 =?us-ascii?Q?j9q4gQEIXC9VZYsHPGvM3j6yYfwYeZMKMV7NFCxYnZcwigJ972d3qWGCYm01?=
 =?us-ascii?Q?tDeDeiHagznRXhHMqkJIGG+l8RzIxf83zvpirmplBOuJcvCrF97ik0KdJBP0?=
 =?us-ascii?Q?cLMuPpYlmonVkIplDkcYaLTEEkVvSAPjZO+u7Xy6b97LdKKfzISxOSTY8pmT?=
 =?us-ascii?Q?pGyhL/Vt1wpnUoxkPN3K45ZXBRnSIkveQfq9spTfjhxVXaYGdFq/44KQFDhC?=
 =?us-ascii?Q?1sSThrhw+lJLZoz4QchvvW7fZ+naAsBkiyicm+El?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed10d3b4-df14-433e-facf-08db607e0120
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 19:50:50.5056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YzOdP1HdwWs8ugzJdoHbcyjIpD8SgZ4YGqJ0v+4fo5Rsd7v6QlFgK2QGuE/YKS1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 19, 2023 at 01:32:20PM -0700, Jacob Pan wrote:
> PCIe Process address space ID (PASID) is used to tag DMA traffic, it
> provides finer grained isolation than requester ID (RID).
> 
> For each RID, 0 is as a special PASID for the legacy DMA (without
> PASID), thus RID_PASID. This is universal across all architectures,
> therefore warranted to be declared in the common header.
> Noting that VT-d could support none-zero RID_PASID, but currently not
> used.
> 
> By having a common RID_PASID, we can avoid conflicts between different
> use cases in the generic code. e.g. SVA and DMA API with PASIDs.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v6:
>    - let SMMU code use the common RID_PASID macro
> ---
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 10 ++++----
>  drivers/iommu/intel/iommu.c                   | 24 +++++++++----------
>  drivers/iommu/intel/pasid.c                   |  2 +-
>  drivers/iommu/intel/pasid.h                   |  1 -
>  include/linux/iommu.h                         |  1 +
>  6 files changed, 20 insertions(+), 20 deletions(-)

I tend to agree with Jean-Philippe's remarks on the name

This is the "untagged" DMA for environments that have optional tags.

Otherwise:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
