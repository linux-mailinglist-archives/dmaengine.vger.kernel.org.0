Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794D86C146E
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 15:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjCTOLS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 10:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjCTOLQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 10:11:16 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EA27A87;
        Mon, 20 Mar 2023 07:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9/03LI93hVixczg0WdE7EAVn5py72LEumiGkkysEb4rMOGwA4Lb4t3pwrgP8v7LpelbMrrVH443tSqGQrNsOexUdixpMlTnjrRmCqRkNt6KOZe+iTgn1Z/niIjd9rQ3CiQ9ZX0Ytpjg/qkBUj54pd5tQFm3TUc9UZEzHHCkLQiOSzohhVOKJD7chQGQipPXpWlApCBrj8YMjvIhYu+XNzcqyVVhHCNVntoE3E5wcLK1LN713TVWAH5OTRCy28jGiqQ47H7RblZdTUBavTvglcl18vUb8UpoifUKkFpi0mpWLfDsKPUZIDMl23d7376gk41T2xtvdM/L4NpCnNACwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6sOyCftS5Sw89rUmrVxeleLvb7pv7LtLYA89EBaXgo=;
 b=K3FZrQ4/YuzWotduKG0LT8nA9TvZaur0BgjFD46YZFwQtvoBQ2M2uQ26rJZ/EokYSpbonA8hUP1bYI7CQboZlssqE5cz9PeODuR++wKt1WB6vmgWGyUYBjpMFDwmbd58Ubl064cUfYlQ/C5LDLvCbGA0RWlRfCKs3n0b4HTHeZuV2t7C+cnlVJHdwk499ZiCKBkRM43cyPRcJUdpir9dw0IAB6oi5Tl3xgYWUh1u8HrdtiOiFo+od/Hv76Oi/tl4V7GeazML6nYvCTQGQlHiUexMgWBA8zqF2dGSiuiw4Bn4ksuqHbhzfnHFSr/VFIWi+R8ZjVPk+H3X01ZlJ3ZI8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6sOyCftS5Sw89rUmrVxeleLvb7pv7LtLYA89EBaXgo=;
 b=LOvIr8JsrfAhX9wH99yAiLPAS2HsIRwYx6CoX8lsqX94yYMvNdobEkqOVSazMn+KuqBuMPWVyxfiQa5fukOYG1duGxuvWctIIayZrc5H77h3qvLF0QNnyGg1hhxJe52+T8r/FdBGttqqYmXp8rx6eOiKRtEJsubpqcnS/lZOOZlDC1l6MOsC+AH7sd528eluDhCIBZwMAHogTGrU2pIAdOPsJ4hhGp/cf1QqACOD2queVv6RsKfdfXNnrGUWnQgQ5HKv5XOApy4timlzsONKLlCL9pPjcaoz0VST8e4o3BR0mWmwppL+1wbcaszwfZO2b0RChrRODWzjZidnAw5nKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 14:11:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 14:11:14 +0000
Date:   Mon, 20 Mar 2023 11:11:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <ZBhpgHIJOvZFwaWn@nvidia.com>
References: <20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
 <3b7fb4d3-1fe9-a3be-46ad-c271be9f96c7@linux.intel.com>
 <20230302091707.58d59964@jacob-builder>
 <794c7dad-2e62-3afa-ea10-92179b0d1659@linux.intel.com>
 <20230303093235.GB361458@myrica>
 <3b2c6fe9-821f-9b84-acb6-777e8517a0fc@linux.intel.com>
 <ZAHzAa0mnilf0N9K@nvidia.com>
 <20230307143209.2873d9e2@jacob-builder>
 <ZAjSsm4/PDRqViwa@nvidia.com>
 <3050c4a3-8ced-2469-4546-4af9620d3363@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3050c4a3-8ced-2469-4546-4af9620d3363@intel.com>
X-ClientProxiedBy: BL0PR02CA0066.namprd02.prod.outlook.com
 (2603:10b6:207:3d::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d47b53-b7da-4de5-65a7-08db294cf6e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hz3bk68CHb6zRJTnTJL4lIeUD8fRRi5Uknd7oAXHag06rGEJIKKXDWapuvslGFwIbK67jIcdPBYQIUk9uZYMwyBDGMgUQ65dZ9VwIWAKqItChYa0tBruCV5KQCyiHOe4OITVWVdG6plWCS7pkoDQH/HOlJGACXw7QljPVSQNX2gbspImJJifSblAv3oAytSr115e6zstQ2Nb7BHtP89zhzezHJEbeQOipFI3oM6n1AutIsBFCmW7DZdmE5kdfi8OLkImS6r576YZyG0pPjWzDbAFInMHqupvlQLRifyitBS7uWBqhcdZSPg7WA4UaF7jJVIzc0DAycbHYOA2LxHe6ZNSfzwOU8GzVpkcj+vAo64EhvGqGLmI50Yg4dddp69KR0HlAZTfOu56gTj0lu5GA6lkCFY/gN3Jap6i/ZYvp6gGXDdstJXOZRVtrk5Tz2Y7rQBF3uc/MEfNc8jWK+Vy7zovE3Wtb4p1pN3TWMM00IQb58Wrkz4kR9EJqRgHllEVvJ4vi6hy+ZzxJT8/ZCylg7IzHoplgP6725y86gKLYYlHg+pV+hQEEgB09MDBsvgGJ/epKOgSx3Dc5FHR9v8xj20eJ8nNfV0NDGNYpULXwEvIQE8+Dv5VJq3uSv/Ahbnl5U+oiKo/onPXZ0sOK6em1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199018)(8936002)(4744005)(7416002)(5660300002)(41300700001)(4326008)(36756003)(86362001)(38100700002)(2906002)(6916009)(6486002)(83380400001)(478600001)(186003)(2616005)(54906003)(26005)(6506007)(6512007)(316002)(66556008)(8676002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GgkCmqU3KogB+JgQtV966lp108hqqc8z2WO3nA5yfAVewX7mwl3C6gdD1ehv?=
 =?us-ascii?Q?g6G6A/T0sG3rrpbk8PLwfqOdTlWwNhswsMCvzngMvt+HBHIuTcAkU0OAsyMp?=
 =?us-ascii?Q?gG/2FYK48UTtnR8iKTjnjDLwBkKazmsYVfxE4uJ3/0oDxsOawOOEzdRITZ1D?=
 =?us-ascii?Q?LgIbz1Ag1ZSht2hRlEsDE1LzHPEeoPjOk058x/H1q52yTuRpiK9XTpJn/GAI?=
 =?us-ascii?Q?dbdc40brCa2mXzXm7tznCWSbR6KyJXkn28iitW7EDLKiYYFoWcT4kSIlkz0T?=
 =?us-ascii?Q?a+bAQwy6NcaOtJVVBAlcPNgTPaj3Eq1Dc4MyXZNAxvc+ABwM26+crbsAvn8q?=
 =?us-ascii?Q?jtNv+rWSPCRA5QcTKdRLe6wNWaty8fu8cfe/QtJZ+RiPdfO4HqjacufAhU4d?=
 =?us-ascii?Q?cTcx2tzPKX6rLjh1uNn3DpmH2Nf50dg+Tu4ZRKIv8jeuFNMaH6iE728nEdzs?=
 =?us-ascii?Q?yGEknkrY3di2jLfwc+E4btEz+WoyNEBdGSXmaXzXCgaVmYG8xPBDiAF67SyG?=
 =?us-ascii?Q?WR/Kk844yiS6hSGmOZ9sgYtYs361O5cWE0kulkuVtVDOSJGVcM1U7mBFU/Qe?=
 =?us-ascii?Q?ihiuAxWC0N+aun1hIQcq3KROX+hez9uSuYyF56CK8h7pYOmkuGhVn6T3EuWF?=
 =?us-ascii?Q?J05jT+YaPsJQX+iDWFCS7/TvjoVvLaoSYdlW0c8gzXfG7PUwomNSunJ8f+1j?=
 =?us-ascii?Q?6g3Q/97cH54LiDhrW+wa+pJiNNsE4Hs8UVoIHWXWaLWgROOWB7wdyB8JYAzv?=
 =?us-ascii?Q?6UoXlL8M1peOGyS8hTN1ccae/XBh/hVm71W2c4yGUlfDQF0V/6LboGdRZdGJ?=
 =?us-ascii?Q?zbtoebB9Kgphbe8haWHZ3JijcJJKwkQFh+tzBrNfFFJmAKdQTD5w8q9+Ot/M?=
 =?us-ascii?Q?r/RwWEEja57X7PIDD19LY+/dHWF0E8s8QoFE443UiRNymwosckFgKvzpDrvq?=
 =?us-ascii?Q?1QDaR4GBoUHHjzrRc2azd38WYA9Vk9vfpWlanmTHF4LChjJORbDE9wDgVoNH?=
 =?us-ascii?Q?XxL74YzpeRl0XIhG7CCN1pQnbMcxRC+XCqXRn4xNX8HQCngt0pFu8qNAM/tZ?=
 =?us-ascii?Q?RHxhZU8gSkI6U/vXsULn9dDzlS1oz9Eedu92odn36sP6tIBPX9d37fgCm03A?=
 =?us-ascii?Q?DQjxVo/smcsSl4tLpWAoNWNPkWZFwtcfHwbApcOUNaz3NXdFdr8TcRqVIyEV?=
 =?us-ascii?Q?gBunkzF0pqnyErJ7dA/TpE4QAwr4nnCXSVnl+cKgHo+sqL9t2WKmr98tWHrl?=
 =?us-ascii?Q?+nLaPPJbLgKiYDzXH3ndkahZM7WbLDDyq0Ne4dRvClfcXjBRORejzslTp+YM?=
 =?us-ascii?Q?PzED/TVPuMkuQZr+XBqlgfEJ7VnQljwY4JqaRg6+5U6HVXb5MFJgz7EaO1xH?=
 =?us-ascii?Q?WnUxu7LtcvzdbElY7U9xDvub8SR7njCOIvZP6HodZ3VKfzPHP10Eq7UyErUV?=
 =?us-ascii?Q?ZH9jK8P67vrzyEm9LuzqmYA2ETylJrirFvUUQs7NOTT+ZBxYc8KrDLAFvfbH?=
 =?us-ascii?Q?GbwkYWP7Ays8CZmp2jM1U+N+4vwKLe0yZzHPBbOt+VSQ9mN6tYa/CpNv0wjD?=
 =?us-ascii?Q?7zSFW6dPu1EVaUuWOZ/WsJ57dWq4D1gIAqLOq8cy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d47b53-b7da-4de5-65a7-08db294cf6e6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 14:11:14.1167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrS+PrmR8K4P9lKHvJHBzR6vnE/kb7xUtwCjXgQCo2dcGCZM1pzNDzOkt6ICKiBc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Mar 11, 2023 at 09:18:30AM -0800, Fenghua Yu wrote:

> Ok. I will maintain mm and find mm from PASID inside IDXD driver. And will
> implement accessing the remote mm inside IDXD driver although the
> implementation will have duplicate code as access_remote_vm().

If you really need it and it really makes sense, then export it 

Jason
