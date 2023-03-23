Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CE86C6B59
	for <lists+dmaengine@lfdr.de>; Thu, 23 Mar 2023 15:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjCWOov (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Mar 2023 10:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCWOou (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Mar 2023 10:44:50 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DA523C4A;
        Thu, 23 Mar 2023 07:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJcRl98iEIqvPvFxbOX1f0vfmgN9D4Ebv6VnmB/kzVg+S2SCzf+bPyyjZyMA1NQhjePoqam24AKZ/T93OgAFDKwIuwcL6lwoHuV5osQZvHhj8n4Il+AaoGraGgWobOTIQXi1ZBlbIqHQNs/DDUBR+x6TZ/8o5b4sp3pXUS/+w1g+mp2D7P89TNgUEbTgXxW66KHjfRR0PR0rAPvBSmV6QuthMNCbliedzM5d0Be/wE+0V4Vt7ThOVfeuDR2DUyUQbSVvrCCgHg7DSGkSXCHcW/3Wzz2tNhohw+oJk8GjHdwDR0qTg+XSAf9CNgBx52fpjlr4cF4B8fBrFfKJDoMweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5OfBQRiycuaBHtBOx5aeEMwuOGWXdzHUtTHFG/eKFU=;
 b=Ih28e0qMxFiwakvDxZ0J3rHH/n5J4OjqKYhyXzbKZkibnnspzYUzKoEhZRCaH0tVjyE4ERx/6sa/ln7SItBTNM1evPkybnaB7u3W4qkAdjJwe8yNfCrGwXDQBHl/8rMaf393exMT8QwRFLxn2TfNT8tJfkTpz68wfKgqKpKxywvMaNBgjpw3x0QhJT1aDdjrCHIVW0FI12XMrlCPQZhtybun4wqqXSdS2tJJ6GNxa1E/kuKvlxqcKdNbm7Im6M9l5VKC1JFkTLOYoOQ0D4BByphvhjdZTEQgh4zv2G9B44Fv/ea4clQdavJSQPTkC1pXGQUH5iIzB2LNvMza9BJaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5OfBQRiycuaBHtBOx5aeEMwuOGWXdzHUtTHFG/eKFU=;
 b=o50rw0+PjZNdt5d9VHy69rxnG125tnzSzLweowkYv1Mw9UYFw3FoTvNkJBKwwTViad7IGxe+lATjFid2liVqnHEIlNxTRZguqIXqIj2LefD19A/ewDsdHVME0Ok4m0XeBk1T/30r6zthQVPnzFhT1t2vaEWdx/eKTKJHXKbry+iiAT73wxTMgsLx/Avk9Co2DAEHe5qYvs8zkmBunX0+ts2Wb1fwI0eXyvWocXUA/Dn7CaYEwMkAyZd19O1zFnSwvLjuG8IxY3ogOVuz7imdowC7Om1vES9eTuiFUgFBff0qeTe0iaGavgrnLKxsiwJzRI0Zyv5WjiTo888SCsnagg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 14:44:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 14:44:47 +0000
Date:   Thu, 23 Mar 2023 11:44:44 -0300
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
Subject: Re: [PATCH v8 0/7] Remove VT-d virtual command interface and IOASID
Message-ID: <ZBxl3FgN/m2Qus7V@nvidia.com>
References: <20230322200803.869130-1-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322200803.869130-1-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: MN2PR17CA0017.namprd17.prod.outlook.com
 (2603:10b6:208:15e::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 4836d225-7648-499e-6564-08db2bad2553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: laV7rn+toP6JvrKKq7YOydiXOIEBwQeZ+aQLdpEUYwpsePbUmf9Y9UdWlDm4xhNDXn74AoRyt01cFdWSSeg9LIRjf8s/e5nlf5wSvEWq/pPa3+xp5UH+B2L/oAAfiHmCY0qHCQNlfNQOyUasR5FO/eZKaM3Wb3WNBRHUo4eJTL/gqr1YBRdDQgsobEEQL5VyPAcVV9LtBlHl2tpEqa4HqogH9nHVMPTdKiR0yCmUQCApbBeyMwmOULXNIrGMJPYbzIshSlWt5mW4Cubee8btY95rfSG+K0eZ0AwYz4xzLS4Ln85hQAwM5sPpnVylopvo3/GKLKyYdQTxTY+fDk0L/arJ3EBP8oQPLkznE5Z/8ytFJPt6ZbZKxOVF5BNRvoGZrnAqGLYQpKEJ3gvNmcxwVoM3g11Fb6G/XqYf+9oydgrIoZUzuU0g2HUYnuM1vpvgXBreChYK9RZ7FQyXZWIWGKoG2Vymg715bk7oKfEyvSlATOE2fmZpSAbJPEGJKdICdqvTdt+wEdaklaXnDlQC71M0gv1y4kGiWy31dCSJfVdKnJHceHvjDNfd93pMBJeZKbw81LVGWdMmO+41u6VCjDMup3WRaNosqXn+g97FB5xMlDT13ud0mLuwT/mtMaUHWpWFOaka7XP6gP3V5Mh+Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199018)(36756003)(6916009)(8676002)(86362001)(4326008)(66946007)(66556008)(8936002)(66476007)(41300700001)(6486002)(478600001)(316002)(54906003)(5660300002)(2906002)(7416002)(4744005)(26005)(38100700002)(6512007)(6506007)(6666004)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TvOZCtjCdJwNDjZCGvWutS+XrBEb1YBhhuIcBkrSuhQLB3RJbkrwZjUjaByd?=
 =?us-ascii?Q?DY+aT5BhkOZPNLwUEOCgPJvdoiFKmFu39CmETWCgxhHmDtuLfoCkAUHLieiF?=
 =?us-ascii?Q?YTO/+VqMpYTAynkGFuLxooF/NM3kZLEkLt4Ndq5fXzQs4Q8vs2Xal34xG88E?=
 =?us-ascii?Q?FNqjD9KN7PxkyoTBGASIHtO0/iZFLsNmsBzqKYpNYav+u0BNOJg2BHGT3mDZ?=
 =?us-ascii?Q?/Fw9urzA0A2J9WQFKEgkXeIHi6MfBRTWiMavmib5/NnhrwLWTKGmSmg2kMw5?=
 =?us-ascii?Q?pNtZHtFkH0f6lqzm/pIbQr3cslNl8JXj5xorfrjWF1zslnaYdAgSAlQEE7rt?=
 =?us-ascii?Q?Pcy+CTcGlGhB/uRXruIXjjmEmoG8P2kJJMJWt2ae8aptTAS5LuLJCbvMjK8b?=
 =?us-ascii?Q?Lg0tVtg+5Hxq7/zgI5Xb7n2lHv1TNVIjZxNS5iN+uL2QkouCk0vkDrZK7Xlx?=
 =?us-ascii?Q?3TkdQPHNGvDdc6k32Vv+L+7T+d3dtHI78pY6FmuNCTypkahUkRdy3YHahiuH?=
 =?us-ascii?Q?UdUx4sE3dtzM18G0ruVQtaI9vMBXIy0/OWrhOudWsw+Np+i0ilS0PB0Korbk?=
 =?us-ascii?Q?4YLQ9BuDZS8rGlJGO7UavLx58emhSNima9VjzxhPWQh4Py0qGN3rWSRTLaAo?=
 =?us-ascii?Q?/jpdiARGovURmfbq2oYObjt0Pj41BuK4/KPCpD/JzMCltHTwq/3jZsn1MHr4?=
 =?us-ascii?Q?oX7pCFhc27iQTS+c0wz43c6Zz/ldoXOq+NZqYASigHbnBEmxxl0+1mjL2vsG?=
 =?us-ascii?Q?0r/5Ic/pTEimD67ShGrb6ryBe0aCE1owcZVq2btRah5DeZX4WNBRVahpTT7C?=
 =?us-ascii?Q?UhargBul45j7/KTjYWTv9c2x6U6ijL8bJp8GJkOo+i7QSk/2wwJ0m16CvrQ7?=
 =?us-ascii?Q?9IUTdOVKEMK/fa0DD2OTxIrO3ryAGPh/VGtWDLpafhr7ONTJgdXMTQQM1lap?=
 =?us-ascii?Q?y2gl1QXwYgRksL6hjcQPxgLMXgzNJZRJXauDCUuXNm9zU3X1f71Jh6MEhHfT?=
 =?us-ascii?Q?BEN1YEx+Hp0JVT6SVAF2QhiUCrsY9mgrw7HUOeu8pSQzvqvQauLHigrXYjEc?=
 =?us-ascii?Q?+9PaRDo7WNtE0Wr8IJJLEcJZidoVFWRMtu7skFsnwTkS4wA5hXOU3lzC4x+j?=
 =?us-ascii?Q?mJGb3++1LlWZr7DAARLBvVVjRYv1iOIiFj9wz7oI40itTnIy8NRTBTElPile?=
 =?us-ascii?Q?KEbC3P/kGv0OjVrNe43kIeEUJnc9bTT0IXZ5prJagBQC+oxtr7rghx7fKpM9?=
 =?us-ascii?Q?iClMopW8IA4zWo8S1F3Y4LK/RdBDRKRJxcB/jXVTY8H6qxcJEU6TsWYOHF+B?=
 =?us-ascii?Q?ebK9y39Wj7z1iAXg68OT00TRIv1+Iw53U9gDSMmY2W3mRZf4WmLgEoSRPaKS?=
 =?us-ascii?Q?UR6XiAF27ZGT4AMY0tQNRCd8bKEchM37rqhEZqC9YAC6heeWliolbcva+inP?=
 =?us-ascii?Q?1uuwE40mb83wrZmKl7jH0zGnOlWvkPrPF3ueuXJyKwGgruIZ493l3uZcUYnq?=
 =?us-ascii?Q?8fnvZA7sVJRH5jQd4N0X99nfUHYyVk1pMkQaRdcaw197a1LxgctBe5GT9H4d?=
 =?us-ascii?Q?wXczKlHIGmjMname2xfdffiqK8frJ7gQQxxHXC9C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4836d225-7648-499e-6564-08db2bad2553
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 14:44:46.8614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYTLrNF7E9ondJUrtxtbP3ZVAI6LgMYkVulL/y4wvvGF4n6p9Y5hFZAeMHd8CWoA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 22, 2023 at 01:07:56PM -0700, Jacob Pan wrote:
> Hi all,
> 
> This patch set removes unused VT-d virtual command interface followed by
> removal of the IOASID infrastructure.
> 
> This has only been tested on x86 platforms, need help with testing on ARM
> SMMU and other architectures.
> 
> 
> Thanks,
> 
> Jacob
> 
> ChangeLog:
> v8:
>  - remove #ifdef CONFIG_IOMMU_SVA since we have dummy inline functions.
>  - fixed a compile bug that affects bisectability

I think this looks OK now, thanks

Jason
