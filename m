Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1D265E162
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jan 2023 01:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjAEATt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Jan 2023 19:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjAEATl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Jan 2023 19:19:41 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356331D0CB
        for <dmaengine@vger.kernel.org>; Wed,  4 Jan 2023 16:19:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSeYCcKR3x59V8V36gVecFWce9WbRCdXdpc3JYyhVAxBgjbT2yNLkQSdUuNjNR59lC9kRRHdtPAZWWZ2oWeQgM2OOnbTpR9dysd9P/p9yj67OavDp5AU1rR2+WNmqwNrMskJEw6JcYb3K9Nz22WwRjt09JzRawq1cRzm5ZE9TBNmtVI+1T2jXFiWMWNVMcamrRFxYbiO71cjyyZU6HZ2Fur6z8jV1tifse5BdoF4Vv8cVEPi5db4u2p7SA5jWOdn678WMBYPvztMAqjgbppaskUqNtGwKLrDwmhfAXQCedJTcUX18HgW3+9iF8iZ8XppmFGl2hsr94tz9ehSg3EObg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=If1YWFUypXSX+90VERo4+aQcx06wYKkl8PuMz3q0N8c=;
 b=TbaAqHPLmHxzRN01H/4aWIjC0BkS52lZVAFFPrdwf1k3JsUbs4qvMsGMyjQiJV7KtEENoapQAhFkgRVzTNpMNi9YKwJRXRWBLweecaEz9DJcVKeFrL8tiVJIb7uD+yp74qTw867ibSzoUeIdFZNQ2Uy/mFjCCz3upwUjjhCOG4m3746xUevQe485DtLVphqPTRveTjxluDItnupuCh9SwXqKQwrEJDyCLimrwd10WOk9tUlyYxXEWtDYa6wddFweU9dfPzCmOeyf4frY9MClZ7gWYMUxSM5baKv6q43rnA1zZDA5V+LP4grmQF/SizuEvebEUOysn2uR8PePrG29oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=If1YWFUypXSX+90VERo4+aQcx06wYKkl8PuMz3q0N8c=;
 b=pREyMbsNW3n5Ec9ZRVsdGjnZQgtk2q0w80cG92zjfNxVPBRAUQM98jMfMDX/AzLni9C0iSvIGEICgyp4OkOhAM9TVcFveWvQEhNSrMkT+ybHAOzdzxln6bKI90M46XTodHoxX/UoBY74YtRZd35ajaugX7OV+i0CLWfgjc3Nrlrh0zeJhVipM3kuwPKxwsrL2QhfhnKK8BBRhAQs2oeQMKTIOYQ6yuGIZarygiM/yfx7sRuG4kqFPjMypCfpGRQb4TzWqn/hhapbLh7i1x+UDSXJUg8M/NP6SMkIBpKs8CuV3h6+7lOll8HS4XbfxfMv0elqrM4RwXLRoWMVNL/hHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CH2PR12MB5513.namprd12.prod.outlook.com (2603:10b6:610:68::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 00:19:38 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 00:19:38 +0000
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
 <20230103163505.1569356-10-fenghua.yu@intel.com>
 <Y7RpuqbTAM11wVQG@lucifer> <Y7Rq0WRc4p3lCkjk@lucifer>
 <IA1PR11MB609703A614F64CD34FA8F02D9BF49@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y7SMYF8MlzeqDgp+@lucifer>
 <IA1PR11MB609745A8BE83313FAB0236C29BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
 <87tu16rdea.fsf@nvidia.com> <Y7XZ8zY3KIRDlu/f@lucifer>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH 09/17] mm: export access_remote_vm() symbol
Date:   Thu, 05 Jan 2023 10:57:02 +1100
In-reply-to: <Y7XZ8zY3KIRDlu/f@lucifer>
Message-ID: <87k021vnmw.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:74::22) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CH2PR12MB5513:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e18efdc-a2bc-49f1-dd26-08daeeb28823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0p2rch4dX3JPQKpLQ2+kUyosfpqt9NdwGowBGsWJvfaXGcaAoZlq+O+qqCp3KmviUr+SkvO92b1tJFuqCnsvaMj05dMovnGUyAmrkxvb2uxsGLniXHhpxlovT0dSlQu9e+oKfSS12xiQs5EB9YhYNSHu0bDRgSEaX3upjGaE6QjWhc4vPKww3SW9S6HnJSN+C+jpPsDUo+8W/6y9MZqatxyI29Dnuh0GYBNqITUO+PTDWPKPfClO8sND91NwUBKz3Fa9WW2NHfeN/DzFgUpHsEBaJ3lOs1urIZks2Z+HX1FrbQ0HOX87+Aw1ZVqIOwj0QX352eMsTIKY6mVEAE/m95YNYuTHXoUui45RbNf8Qn+AGZN00eq03/7hayHzcAc8sa18q0tWIUdPYAV1ki7bgW4NyW7RdG25c/5uKyQ1dr4R1i430+Pkzs++fAip/6HeJXc3LPsTfYBZYTHe0GTFx/jtUEeg8/M6vsozxq5mdCOgpL4gHO4KL8WDir///n1Yb6VjD3lZZ3gROP3ZujhY7merV5CTX53O1G8d5CcG47BPcGR52xGXU7J0fBr2IMl/MZvMP5ljavSveoEVKNzi0TVZhNo6a4xLEgfOdOOKED+leOT35n3gp4Q1WaUiwOMZfzWAWkX1CGvVuBCiHGqKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199015)(83380400001)(2616005)(26005)(186003)(6512007)(6506007)(6666004)(86362001)(36756003)(38100700002)(41300700001)(4326008)(66899015)(8676002)(7416002)(2906002)(5660300002)(8936002)(6486002)(316002)(66556008)(478600001)(66946007)(54906003)(66476007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VrvDPnG5acOi/i7YIAy0Hy3u/PltrZ4ZwY2Alex46LF8nSPQXCPokNrpFOuo?=
 =?us-ascii?Q?EdgO02zOmMT0eIF51+/poTUzT8zLMuD+X2h4OLpuB0DscrgXyTGbsho6DAN0?=
 =?us-ascii?Q?qXp58slHkEoL5hSCmO7eFAGe2xuTnwWH/lPmL+b6NCiWxPH0V3AHiHSD/Heo?=
 =?us-ascii?Q?VIP7RfNS+jQyZRc73DJ7JSOfcr1eiBiJz3z2Oi365r6b978tscvginjMkY3v?=
 =?us-ascii?Q?eZMSpi+SoSFCXv6AdEKWNVBGryw4kppHmM0L/roa8/tsnIt+jOy9ZRtlz6Tb?=
 =?us-ascii?Q?AirdNcotaFw2VUf6oiX8fEL6KOJ03IxKV3/IUDs9YLOOojXXU478mdeFfzj/?=
 =?us-ascii?Q?KQdq1/DtI5HnL53z84nk1CR+bg+6ER21KCKv2nwnoVq46GcrQE+1/O95uyfc?=
 =?us-ascii?Q?snVEE7YFMMxJ5zDuB8DinFsV+jj9gwq5MFtK2cjIkBTc4HuJ4UTEKDI6KPRP?=
 =?us-ascii?Q?LeFoIPWLE/eyCuwlzxSe5ZO3Nbx40XY72ZhqtX9fN+gXqDHGIFBYGtrL+1jS?=
 =?us-ascii?Q?WbjSEuec04HrKTWVHtMRL4FLDZ6ypW5baraHyl2gTDgwcFZHuHOtVhS3klcC?=
 =?us-ascii?Q?T67b1oa+O6UJ2fzBsAmDMEk1IESoLmwB3wyxEdF3US8glBdtJKNASGiec3Po?=
 =?us-ascii?Q?h6Ghsv0Isb44pUPek8fOKEXePp8t23aQ488de8Lm0PsKpptTHc3anwm01Iyr?=
 =?us-ascii?Q?I+87QjvmzsCaxcUvSHctiL3CAfQXagcfyY1kwyJI7WjUvkV2QmZFm3gxFtNO?=
 =?us-ascii?Q?lgnILajoAq9DFRdw0UBjESO5Lzg0KEAgCnwQ05szTVFMRqgTwz4XM/GvWBJV?=
 =?us-ascii?Q?g0nOB4r1k7wcFMN8QW/cr/JVcPgqhoXs8pXLsOGPU1DuxbhHY7qrNG3PezcC?=
 =?us-ascii?Q?oxuuy5Pzw2VAfKBdNefL9SLlaSe7ynkbDYwZsV/ZQ9oAZWO/ylpBugBsg/3+?=
 =?us-ascii?Q?SA6c6cHN9Cpdscv1mpef8YshFzQJFRa9EANlAc5vcOVbAAG7VHTCYw0ZhyG2?=
 =?us-ascii?Q?u4X7qWB+1AYZAwbg9qL+wtGNKRh3uEB4v445+bEbn4iSgpyQDzPQCYQEks4n?=
 =?us-ascii?Q?l6O/BvsEWmoPYRQ/z6CyxXrTMpKYAbw5me+aGAuTfIEKOZmqEJO6c22vaK9y?=
 =?us-ascii?Q?lJbeRDsq1A03rmBPLeB6HlYivC+At7mmmmQ7jFyj3svqHB6Pzepa6f62cpg7?=
 =?us-ascii?Q?SYr+yxWi68igq8a1IBRzdKbrhOGtDNmsqDoEt/JxwTYWsGCoVz7WG1LGbET9?=
 =?us-ascii?Q?8lgv2ALp+1fY2BafBVgisP+UDbJMDiISy4LHKff/uljWeYmkJeQANEnO0C+c?=
 =?us-ascii?Q?Mv4IAS4lwWqOS6AqoGQL0Hrk6gBqPnYN8HhbFxJNjcF0qME6W8aLLK/S12be?=
 =?us-ascii?Q?nKle0pITWxdTnol8nP66DWt18cm9n+UQyW7i4BwEiXZLFkDmlK72q6lVr44f?=
 =?us-ascii?Q?bFkrNknepYpwRdg2nNYHeAcKnfS26msyW8qD+qNuNiwsbb45sVg2ghzPFUTt?=
 =?us-ascii?Q?XiVapJ6u+sN1bnfpCbQq5R5/17VahZEn2P9avQpR0IbodyPoUQsUThWGEQIc?=
 =?us-ascii?Q?UzGyxCIWzPDtBteAQbOV6f94GUhrGX6x8ngO4RGZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e18efdc-a2bc-49f1-dd26-08daeeb28823
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 00:19:38.3550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5SvJpL7l8EWSw8N0csz39lsmwmDF8va+y/fVcGTrTNIuG5CJ9vHQv0MZP1n14d3XCGgTlaC65L4HMMPhZFNnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5513
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


Lorenzo Stoakes <lstoakes@gmail.com> writes:

> On Wed, Jan 04, 2023 at 05:12:31PM +1100, Alistair Popple wrote:
>> Obviously something must still be holding a mmgrab() though. That should
>> happen as part of the PASID allocation done by iommu_sva_bind_device().
>
> I'm not familiar with the iommu code, but a brief glance suggests that no
> mmgrab() is being performed for intel devices? I may have missed something
> though.

I'm more familiar with the ARM side of things, but we can safely assume
we always have a valid mmgrab()/mm_count while the PASID is bound because
iommu_sva_bind_device() -> iommu_sva_domain_alloc() -> mmgrab().

> We do need to be absolutely sure the mm sticks around (hence the
> grab) but if we need userland mappings that we have to have a subsequent
> mmget_not_zero().

Yeah, iommu_sva_find() does take care of that though:

 * On success a reference to the mm is taken, and must be released with mmput().

>> >> I definitely don't feel as if simply exporting this is a safe option, and you would in
>> >> that case need a new function that handles different scenarios of mm
>> >> ownership/not.
>>
>> Note this isn't that different from get_user_pages_remote().
>
> get_user_pages_remote() differs in that, most importantly, it requires the
> mm_lock is held on invocation (implying that the mm will stick around), which is
> not the case for access_remote_vm() (as __access_remote_vm() subsequently
> obtains it), but also in that it pins pages but doesn't copy things to a buffer
> (rather returning VMAs or struct page objects).

Oh that makes sense.

> Also note the comment around get_user_pages_remote() saying nobody should be
> using it due to lack of FAULT_FLAG_ALLOW_RETRY handling :) yes it feels like GUP
> is a bit of a mess.
>
>> In any case though iommu_sva_find() already takes care of doing
>> mmget_not_zero(). I wonder if it makes more sense to define a wrapper
>> (eg. iommu_access_pasid) that takes a PASID and does the mm
>> lookup/access_vm/mmput?
>
> My concern is exposing something highly delicate _which accesses remote mas a public API with implicit
> assumptions whose one and only (core kernel) user treats with enormous
> caution. Even if this iommu code were to use it correctly, we'd end up with an
> interface which could be subject to real risks which other drivers may misuse.

Ok, although I think making this an iommu specific wrapper taking a
PASID rather than mm_struct would make the API more specific and less
likely to be misused as the mm_count/users lifetime issues could be
dealt with inside the core IOMMU code.

> Another question is - why can't we:-
>
> 1. mmgrab() [or safely assume we already have a reference] + mmget_not_zero()
> 2. acquire mm read lock to stop VMAs disappearing underneath us and pin pages with get_user_pages_remote()
> 3. copy what we need using e.g. copy_from_user()/copy_to_user()
> 4. unwind

Seems reasonable to me at least, but I don't have any strong opinions as
I only noticed this thread while trying to catch up on IOMMU
developments.
