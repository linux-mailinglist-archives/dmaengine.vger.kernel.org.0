Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441726C16FD
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 16:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjCTPKr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 11:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjCTPKZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 11:10:25 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23786597;
        Mon, 20 Mar 2023 08:05:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDU43AvVjvELWStfCp+mmxYF8+I1QfQ+wCxqauAPRLWkt9mwV57LG3NJDyu5frloHiMlGFeocuVYSfD4EWMYqy97oL1hsZ841+gbD4by791ttxACfrzwk6TSYpu2P9lHQf6v/u5gIGOAfxUSl9K5RVsUZ0waPKSY2HzUAn4MF2Psk7IV/MDkR5S6YmKcYWg3wsxe13ut8Wfz/FTbH2dWLcSkbr650nuwIaxLB5zyflaZRBk6mS1vvaPKFCZfTeAAH9eNhBBxv7KArJudOpbglkQuFsM5DgenkHXZgFr1oaJ0uxRGiEFZvnu27SGtIOa7PEEuLmzLeIjXwe9ekECWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ko+wGnIp6KY/6btqATjrGDfpF3PjtRt6sZZgmt+VMOU=;
 b=SEUVlUu9mDxJ09m5XJXINedpSEaC9tz32zespxO0gVjbXwP+1KsvWo24vhIJXNMQnEaBNCtt2XTpVqAQhWF/XAHEpZTNzhYmN9jmlaX2qYa8zZixWqS6bjMemluMAxKK8IgvOlU48TN5nb3uCl7rTT7ewezdKadqTKwJga9pGsjxJWKG8o4dKzn4BjKZLQyMER3CJfyQehieh05Y1V++wPvcYIliW9GqxdnzrHwaAmOpUSrUx08W2/mSX1bnogrAD4W5g9fLEphclW2PtvBIk7ySdPHBt1RzHhdypHx8FUVML5wxPPfmOjNBD8McJ9YYnFepWzdm6Oj3J5ryVmYaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ko+wGnIp6KY/6btqATjrGDfpF3PjtRt6sZZgmt+VMOU=;
 b=Q9usroKkJkWbU71YoePCI+Y5IuKyngkQ28ehlNs5MR0RTKtFT9Jt9vmg6KlAEstPNqofIo1NNcLZ/RouyL1CLEtER63AiRmYTfqSoFqzYTW1yQtHOHKuaBmuDA5lU5wDhZuBvR4L6Fc5mJiewnTyOEh+F5unxQjXc0P6+eE4g+UXmiHO45N9PqDVjkM5Pt5ZS/jyxtYnKwz2Ni+KaYDdXTEJ8N+dXMIrXGpEzsVT/v+YJVgA5GLoWEqCHfuVl/AQapbXfegAfGIxa9MZ0OiRV4gI5HysBxspbg236bcZnjfxcNhUWjhu/t4VgHujEjPv/Y4VgoLO6JCUBueUO0zfkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 15:05:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 15:05:19 +0000
Date:   Mon, 20 Mar 2023 12:05:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v6 2/7] iommu/sva: Move PASID helpers to sva code
Message-ID: <ZBh2LTrijOuTkOm9@nvidia.com>
References: <20230313204158.1495067-1-jacob.jun.pan@linux.intel.com>
 <20230313204158.1495067-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313204158.1495067-3-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:208:32f::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca606b6-bd20-4db3-f1ac-08db29548525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IKEImQHE4CZ+DM4QrPzAyc39xKr9dh2hX8Ree0CVNnncip4jB2JDF8X6F/4EIjtE8c6QGQbRvQkK9ZOmkUQd0v6NhWUi6YCv7p8JnE5ijzmPeZGlezBV2ug/ezh7aal+zodiiG1QDIIGKr0AScfdcyD/MxzUdQckuKyDrz6gdeE1oguNSv7nb+jerUFJFqF9mmyCfgiank3O2yarvlV5kJouifVmRC9ncKrmVVHptN+ooYE0AitV7NSaHvuldujLFV3OIAly9WEcNflx2swOqeBA9hC4pWUR6AbH36pnscLmhRVnhNs25+mip8C4gT7FP1iXbd4tzScZFYJP4lHsNj9pRQACxc3hNChmpt7kdavO6ObAbeudwhZ+uE/AuhPyxWP4Ygch+V30t+eeJAjOoliji6QRj+OjfbYzqFLUEKn/jMkmQJaIx4AhNABNTSW0IbAeU0xS3w/3eoiEvpCepE+dlBf0YQibUR8zGdGpnyyKOX3dTvFdg+tGwoSaXWwsEU4HGtNgm0A1iqD7gPxNbD+0/xoiJdwyLx7FUxvy+4MhNvsW+lTdkE2xQxuig4Y7ebnI4renDVs8m1Symdu6Kcz2IZAhVlnXPz65XU9KOK5N5J3p1pPp9wotOvBNNT+R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199018)(41300700001)(8936002)(4744005)(2906002)(66556008)(5660300002)(4326008)(66946007)(66476007)(8676002)(6916009)(7416002)(316002)(86362001)(6486002)(54906003)(478600001)(36756003)(6506007)(6512007)(186003)(26005)(38100700002)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xhzGBjOyveYsJeYXqMdQldQ9Bnc1ffqd+hY6dcusKc8f0tIzAuqF54Pg4aj+?=
 =?us-ascii?Q?Y9VXutX/bFAfOXQqSGcvcVE5mo/fRcgK1isNAoGOrBnpJSAIReiQBBdRdJWl?=
 =?us-ascii?Q?La1gpncvrc+cFFNOo7nnSWzMOx4ksOKNDuqsaZCop0MKjS9+7cic0Od8iXqg?=
 =?us-ascii?Q?vL4e28XTYZ/Lvbxi7RH6gwCDzAqr7BNOCLwa/xV3qmOhZaK8DIykbudIiLpe?=
 =?us-ascii?Q?Y3IAMwpeK9HQ8v5VvNm+tvvDaPlxVR8y9Ciy0NuaZnM9cuI85iCAs/pmBW86?=
 =?us-ascii?Q?Ku3oMgAnL+gIRHjbMDozTxg1RxeuKjnTSjiLLk5mHFE4SKPtH2YtQdnLAGtm?=
 =?us-ascii?Q?mKNi1L+IFSQ7Q/rvTm5b/qXEazpOtYnkJf2YQo7WuCUYgG6I8opi45vWUfQF?=
 =?us-ascii?Q?IsixRKmsNZOtanEK9movNnMgiV37lOMerF3WLQJ7BgZrYYZtQXRCtp7dwtSm?=
 =?us-ascii?Q?BauEVjq810ouFk3ZpuSFDYyj3AFi9WJ35rip6CLkijLgTNiJhOJcfvTTg7wU?=
 =?us-ascii?Q?vp9wk3Xps95UM0zrRX6clQs+NbjT5alqqfzQZne1NmXgfU1LMapZ+6Ft69ve?=
 =?us-ascii?Q?2gboRaoMya+XfJrfehhiP/xs+fgmAsUoQLrdmdQqLnsTUiIlFLAYshaNmzsz?=
 =?us-ascii?Q?YDkNUkqdo5u5MlQHwzvaErKUB76AQevjvDVfRRLNQNDOobS3ILm7Xz370rcY?=
 =?us-ascii?Q?hB2f9rb9geu+RotTO8vg8q9ZzQ1M6mJWY2wmap5eFA6LtiXepE6nSDhGhusb?=
 =?us-ascii?Q?cPXKuWPv47cvV6l5GxyFYy0XHC4d7/twdBis0Lu8A3YkIbREJKwbI7CZ0119?=
 =?us-ascii?Q?bP2V9hZJHm1bRAbZIcvzAiqTa54XVfoEbuf8NAG9veiJSQGjzCc3b00wisZy?=
 =?us-ascii?Q?F5CB4o3P4nAhTr1hAAK1saOPO4TuoD+yTGTb6ir/f9ooi9v8FmN/RQIQgVNf?=
 =?us-ascii?Q?w80hzgBTkUAJGTtj+ktHk9DyJBSbqi8zoi/tf4QhKCSBG6EJhszLXiwY0v4p?=
 =?us-ascii?Q?VKrQ4QEQeyuOYpQn1jBtFyr3md6bhnA525nY+bJXH7eVx0zQfr8eWC+HdmOL?=
 =?us-ascii?Q?1x3419Xw6xm4inmzLTtlD/yFFd4IUsHzth/2Q4HwDChiU1j4XMX3a4JUgpJE?=
 =?us-ascii?Q?axkgxKABRKqBVQBpigTwg7jlds3dpDEKGbNE+gGK3yMitOrPHGavpjDSgf0V?=
 =?us-ascii?Q?nm4JJBVreKASVDbwBPfGOKRyHfuqlZ00xp9LQ+MPLNN0lJfK1wZVkcI+U4fg?=
 =?us-ascii?Q?fksNWDyeFA6ghI8vT7VLfWyLz7qAu04IcgaXJOay4yvSvLdo69NQgHHPB0YF?=
 =?us-ascii?Q?gSDhANsjGIXvUBsskQA/xTIBRwJbd6lZfxipzNXJ9gW1ywnNaCCqp+AlMTd+?=
 =?us-ascii?Q?b1UGsnatx0iB1JKG8VU9JgiZj3i7ZMHTQOIxvc/F+/8wk96EKYU348A3hLNj?=
 =?us-ascii?Q?eNA1D6TDYxncWHceCOM374MX363Y9MZHEpMJgjrG/JWGPUnjmwrSOJ0lp7G1?=
 =?us-ascii?Q?9J329p3gj++WFDPE/hcHgrbqbfT5dIE8Idwp2oAV8/7+MMsLnq3A66B+4MJQ?=
 =?us-ascii?Q?cIsM2NaWbr07W4YGQFsLwOfNqc7JYLWh8k7eeT0m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca606b6-bd20-4db3-f1ac-08db29548525
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 15:05:19.2779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHrXLJncRj/FjAoILS1Q9tmYP9gN9JNGpTZRxncDag5PcITXIFQoLNTDY8DFPX6F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 13, 2023 at 01:41:53PM -0700, Jacob Pan wrote:
> Preparing to remove IOASID infrastructure, PASID management will be
> under SVA code. Decouple mm code from IOASID.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v6:
> 	- put helpers under iommu.h instead of iommu-helper.h
> v5:
> 	- move definition of helpers to iommu code to be consistent with
> 	  declarations. (Kevin)
> 	- fix patch partitioning bug (Baolu)
> v4:
> 	- delete and open code mm_set_pasid
> 	- keep mm_init_pasid() as inline for fork performance
> ---
>  drivers/iommu/iommu-sva.c | 10 +++++++++-
>  include/linux/ioasid.h    |  6 +-----
>  include/linux/iommu.h     | 14 +++++++++++++-
>  include/linux/sched/mm.h  | 26 --------------------------
>  kernel/fork.c             |  3 +++
>  5 files changed, 26 insertions(+), 33 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
