Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C85B65CD74
	for <lists+dmaengine@lfdr.de>; Wed,  4 Jan 2023 08:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjADHCR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Jan 2023 02:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbjADHCP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Jan 2023 02:02:15 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B1311A15
        for <dmaengine@vger.kernel.org>; Tue,  3 Jan 2023 23:02:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieUBqG/VgZLyTYyYG6087SeGOC8peWuAqWdgft1RfAMYQ0iFxW1+iUlVmQlFPKmFI3yjjonpsa2/biuU/cZsbRWFiJp45KWuTXrxJp8ML9uObiMikCI8knCKtL+UdIqESS4Pj9Muhb/scRZWSuZh/Ovq98EZGlpGGvbUQEAI4+qtyvaNXgwnrrJbMARwKqR3MbBVSMPB8Mx4wB2Mh9PAhg9Nz224LkQlV36uiKlCJylm20gvFe5ASnpwTomI9MCStkrCWaKHGMH2za5BcK87bSCDFbXvbRE+rNPk/GvPdctaSN3Cb4MdIZBT1I9PVFa038I4ZLaTSBousjoq795r1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4+N0kCaE/s9h/kloeFKGUeaM0Pfj9dWk6GeeyzqhJs=;
 b=VEYLoBSMnkCI+FUdga1eZ+YC18vWTsPhic4tcCf4px/HIfGJrH0aWo5QIGxEltWGnH0Nqc7PV15k+xyW2youHwf8GRd04V1eLvW7fOwonrg/n+QenIUH3XiYu0euEEb5CLOBgK0QUOPpOjHLwOJ7MW1XizLsf2QV3ukXS+l7amYoWK5dFMWBj9HYZx4tFifgEJ/IX1+tK1u0BidJQixXtIOKhFsniIRMLUQnvgey3velEoqBHeD4Ntr3IHWhWMfLBoDIIck2cjMEo+5iHeCQPTQJAT3gI5tQBBPQPDI6jKbn8U61Ttz1IetvofTuDvlsZKPYu7V2t6+qOHcyEwlVeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4+N0kCaE/s9h/kloeFKGUeaM0Pfj9dWk6GeeyzqhJs=;
 b=Ph2AZ146TYmBGNAvSMVpeg1BIlp8lfh02nuaSHxG3fblNhjwdHKq1rXloeHhvC5SHq95eBiVcRwTLX4Wr88dv980jeqqhwoxd8xXPXULwgYEpwozE+mG9RNRq2my+XPglpY5CjMZo7JPlQC3efGuvgLx5KI46oUSGZ7YRRvWjScPYbu/p2po8aZ0GNAimNIfe+JsOO3Sz7PN0XJOUlgHRFL3WnTXbbjj4iDP4rglimqlW1fH02wdhPIok7Oxgz0so6dOiUd+chQl9kZdjQ7Fi99TqLMSYJ5g/L5C3/hCy4tI//99/KIhc5hKHXt8Za8nbTUGJcEbz8EVA+dpXXFbEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH7PR12MB5973.namprd12.prod.outlook.com (2603:10b6:510:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 07:02:12 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 07:02:12 +0000
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
 <20230103163505.1569356-10-fenghua.yu@intel.com>
 <Y7RpuqbTAM11wVQG@lucifer> <Y7Rq0WRc4p3lCkjk@lucifer>
 <IA1PR11MB609703A614F64CD34FA8F02D9BF49@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y7SMYF8MlzeqDgp+@lucifer>
 <IA1PR11MB609745A8BE83313FAB0236C29BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH 09/17] mm: export access_remote_vm() symbol
Date:   Wed, 04 Jan 2023 17:12:31 +1100
In-reply-to: <IA1PR11MB609745A8BE83313FAB0236C29BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
Message-ID: <87tu16rdea.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0077.ausprd01.prod.outlook.com
 (2603:10c6:10:3::17) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH7PR12MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e2b142-9abb-470a-cebf-08daee219a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9sqVcLScDR7EEHRx49yJL8h1XboVt+704Xv+Jv6tp0JcAGmt6F8ttia34F6rwCaVNE6IfBxuZKDUm2nzfxnsq4xXR6MntQmXyVekKixN/j8ylayAhD9NQIV1lrHzrQtzEOIRNLFD5XwVbITL0fIBAEemkSbIBhL3PWApYstaWA+hteMp5RNXflS6njCJn1k3co42c1HBKnWAcAMIEo0e5h6U1914dZphQssftTF77uLfR+dkJohezMKZ1rcV42+M/Cu3A9iAEBT6A7Ew1vNvOizxqkomI6dN0tPknqxzYbKc6+WQNfnzz/1OvC/67QxuDKHqyFZEDqcMAS7/Ubv6HYz+/SQpo3aiwniRCGhqcdraQaTR/MZ1s7MiKr3ryzXTXgbs28UlZhzgSKjnke6kKIQmazE0/GKFBckrY5VUhcg0JT7mHpF/BWlbRearQQy1s5kMr6Vxp0kWlEShGqzuE/gBXKKe/CL+JTyGmQlnZ3uhQnQldI4EM3y2HWksbXeRicYAUOVhuwakhI2dV0DKo7ZkNwY7QN5xTmTxE/+5E80Z/BgqEcIIWM2wvw+o5gOR1Zf5ylp7JMu6yc+EDCnHl5dqUj0LRBshkOvSE9PytfMTH/WJH/MPLYopKK4vRQKIivBUje6m831CQ1bNLq2Hnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199015)(26005)(6486002)(6506007)(478600001)(186003)(6512007)(86362001)(6666004)(6916009)(54906003)(4326008)(8676002)(66946007)(316002)(66476007)(2616005)(66556008)(38100700002)(41300700001)(36756003)(83380400001)(5660300002)(8936002)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CeFfz/Pmc7AIxK9Qix6grLzwNTX5AvAJOQsrdrwLw9ycnFyTd9kavMi2XGoE?=
 =?us-ascii?Q?Wc655rSw6ohWMocxb8W79Yk7dtbHgfA6CzCLanoag4RKSYYqgcXaPRi2Oo8C?=
 =?us-ascii?Q?/JdAiBNsndzLiSu+R0Kgg4KmowralEC+zWIMs4mgLoIv7XkwXQQUMLy+MwRp?=
 =?us-ascii?Q?I2blwmDlP28GyhkibFUppB67KGtSLgDphfmBssQACTrUK7Xlo5rQJxJWAWtt?=
 =?us-ascii?Q?y0mqeDIfozWATQaXqMT+rRT/xE5SJJIdvkJyj0W+V3mT5uO09VLhmvoVtxhy?=
 =?us-ascii?Q?bdwEb30IP098WjUAZyceugtzb8RNdTNglVvr7lF1RZDsnkC67KiT3i03gURQ?=
 =?us-ascii?Q?oX7ruGQfBtpJw7w4nGpbEKyWqZyx/D3t2THyUw6e4s91Yf18FBnTH2FugUbF?=
 =?us-ascii?Q?Uh11koG1cxLil9JwW3t2sViLYSVh72EVNb2oklsWOrNkwtE/HEb5udHFKukm?=
 =?us-ascii?Q?pp/AZvpelGeV4oBKYfsqH1n3LZ5PCJbQqMM6Sf/FDaabV8O3qM9M/2smbTpb?=
 =?us-ascii?Q?Hhf6VTqycZZFVoYuCzgCqFkcVTikkVzoBnz5VHyVHRYx8pX6zxUYmIdGgJF/?=
 =?us-ascii?Q?v+jFdeszmGy+8mWG0fnS65uPqbYcbUfFP+qx1T+WQ59RtjFzVvQbIPiFNw0X?=
 =?us-ascii?Q?JktK8arNljExX/xcUuj+kbU3E518OYFuOJSR3LEBGkCuxccb9tRL9MULx588?=
 =?us-ascii?Q?F/iQuP9oxTTL0KyXevwunVw1AzKjUmOa5RrEdIR/T7qwR9hW+TvWiR2bkDmX?=
 =?us-ascii?Q?VJTlYExNlSrAO0tRWHyQm0PEpBvGrLFZxt8nHLUuhaDWy1Ka/hEcZmdSM1+J?=
 =?us-ascii?Q?vvBbOLqOoe+MrTetMoFSntOATdNl+KP6pjUZ7v8x1Q634t419vetgOxMI8i1?=
 =?us-ascii?Q?FlQ1EaBtXky8K6latofeixjTBUyDw4cRoE0cfyDIDJXAYyEFkZFrpuTGC5lp?=
 =?us-ascii?Q?D3YXUr8kFYx0VqxtJSIMx/KZNM6w0DegSlAh8urch2gZEuMDdiuDgOUQchwU?=
 =?us-ascii?Q?LELqNWftBF0IQ5j9CO/ooALUoPFcdnU38d2RsjhDhmWpGRkn1dmb3kmcznPq?=
 =?us-ascii?Q?JlwbUbGG0WVwcn8UHKiHSI+S4kcUk6HXcT0n3p2Ms0j6BWnbs1JuyM2A0w1B?=
 =?us-ascii?Q?nppuQRppBFQFDYU2z56QJYEgvz53BFRuen0bfeO1wyMi0enC6BEGGJU8knfJ?=
 =?us-ascii?Q?MYimzOFfSbcetBILRmmpDg/GSlYP1CCTqzte//2WV3/RC7bFu1xAMtwymJ5/?=
 =?us-ascii?Q?tsyX8YOk79JYD9JQ5irOzj3pNUECiO+2MRtDoQiKtcTzRNNEl1Sfx0tNGg0V?=
 =?us-ascii?Q?OQ/JjR9adFSm1WuwMcXzTNyKY+AIiT+zoca/Y3JBVecjrELDp3GmifyLGDfQ?=
 =?us-ascii?Q?oP3IBuOb/D+N7ifGimLOiAlhNVz0OXTvLK33C5iYm4dAVv/sutJa1Lln6qna?=
 =?us-ascii?Q?rVVB2vvQFD7Q282F2Vefrdu7VtlsiZOdrLNNrK82ERlu9Meku/aaWFxOqCBT?=
 =?us-ascii?Q?JXWLJ8u1n8pUWd1CfQ42azyK/7YGRa2owjSIzVfcZWUOoJtf7DeSFa8Qc7gh?=
 =?us-ascii?Q?f6y8yV2hc4vZS3j++cGDtAKm4yL9TUnfO0DBbLK7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e2b142-9abb-470a-cebf-08daee219a73
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 07:02:12.0208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKkE/v8L6pmi2wnLSSxdsTCuL2bOldXIVEceJVhXGbv4d/c6Y9NmR/gXUM60A1hwfktRBVAv6yWb1p0wftQgbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5973
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


"Yu, Fenghua" <fenghua.yu@intel.com> writes:

> Hi, Lorenzo,
>
>> Hey Fenghua :)
>> 
>> > access_remote_vm(mm) directly call __access_remote_vm(mm).
>> > access_process_vm(tsk) calls mm=get_task_mm() then
>> __access_remote_vm(mm).
>> >
>> > So instead of access_remote_vm(mm), it's access_process_vm(tsk) that
>> > holds a reference count on the mm, right?
>> 
>> Indeed!
>> 
>> >
>> > > >
>> > > > Is there a reason you can't use access_process_vm() which is
>> > > > exported and additionally handles the refrencing?
>> >
>> > IDXD interrupt handler starts a work which needs to access remote vm.
>> > The remote mm is found by PASID which is saved in device event log.
>> >
>> > In the work, it's hard to get the remote mm from a task because
>> > mm->owner could be NULL but the mm is still existing.
>> 
>> That makes sense, however I do feel nervous about exporting something that
>> that relies on this reference.
>> 
>> The issue is ensuring that the mm can't be taken from underneath you, the only
>> user of access_remote_vm(), procfs, does a careful dance using get_task_mm()
>> and
>> mm_access() to ensure this can't happen, if _sometimes_ the remote mm might
>> have an owner and _sometimes_ not it feels like any exported function needs to
>> be equally careful?

I think the point is the remote mm should be valid as long as the PASID
is valid because it doesn't make sense to have a PASID without
associated memory map. iommu_sva_find() does mmget_not_zero() to ensure
that.

Obviously something must still be holding a mmgrab() though. That should
happen as part of the PASID allocation done by iommu_sva_bind_device().
 
>> I definitely don't feel as if simply exporting this is a safe option, and you would in
>> that case need a new function that handles different scenarios of mm
>> ownership/not.

Note this isn't that different from get_user_pages_remote().
 
>> I may be missing something here and I will wait for others to chime in but I think
>> we would definitely need something more than simply exporting this.
>
> I may define and export a new wrapper access_remote_vm_ref() which will hold
> mm's reference count before accessing it:
> int access_remote_vm_ref(mm)
> {
>    int ret;
>
>    if (mm == &init_mm)
>         return 0;
>
>    mmget(mm);
>    ret = access_remote_vm(mm);
>    mmput(mm);
>
>    return ret;
> }
> EXPORT_SYMBOL_GPL(access_remote_vm_ref);
>
> IDXD or any driver calls this and holds mm reference count while accesses the mm.
> This is useful for caller to directly access mm even if mm's owner could be NULL.

I'm not sure that helps much. A driver would still need to hold a
mm_count to ensure the struct_mm itself can't go away anyway so it may
as well do the mmget() IMHO (although it really should be
mmget_not_zero()).

In any case though iommu_sva_find() already takes care of doing
mmget_not_zero(). I wonder if it makes more sense to define a wrapper
(eg. iommu_access_pasid) that takes a PASID and does the mm
lookup/access_vm/mmput?

> Do you think this is sufficient to take care of the mm reference and is a good way to go?
>
> Thanks.
>
> -Fenghua

