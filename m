Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D8D714FE5
	for <lists+dmaengine@lfdr.de>; Mon, 29 May 2023 21:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjE2Tna (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 May 2023 15:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2Tn3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 May 2023 15:43:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE91DB7;
        Mon, 29 May 2023 12:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AO7wNSRCtaPG7/ee6Cvp0H7/u1DoBSoJMYownJ+YnE3TAKcKyACJlcA50ub7D9eqVeGCARIzXLwLblYuVBbrnfy3shEsNNh/pnS9Jj13fFKBTJHTN/NBwJl5nDcewc/jRwPuZgl71GUFBgES2/FxKdCHmCxnzLbxCUwmGEVzJ8YErNYOLPT/gYrXbpEAOatBR390Jy68IibDNIGBG5T9/vvpz3ZStMxzt/fyPxKF2zlTQE524gFVe86h43TGE87tsHbUeuJsHKkD4CVaBcnFmL+wPygtlgLyBQrOtfLMZCMoG02LqlOxVFdhKqDtMrgvC8G5uvOE3DpV4ImG8Hd91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqcAYowFyi0xTJm1mzCAFe6H8W9s4ofxZSuDOiYEhGc=;
 b=V4xa1m4ORxI38jQkC42FA3AKF5jHy217GetvsEYZyr1M1PnvkRhmHx7tRgBJPTKgiHbXMknZWira4JVv5CgouBakXLDm118UW9tU8sy5KaH4oThNjKS7r8N4gjPxOE7/VHhqZx5g2NrBJdDdLYWfH+QJDio/MDs8rldZDTf6oq+jNwaml7bQIPHFr/0C/XewuxUs9nny3g+sA7qn3eBVIIyM1fSm0PeLQTJ4R2M5Gca6gk8r3tiVrca5ztiQ0sw95ae+QqQjPtsXxXTDHMBUgbJa0Xhd9YBbU1gghkpJocAYVzqRIo93Gx1BKMPFb+U9gWl0Bkem0BjyDSYhJ6YgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqcAYowFyi0xTJm1mzCAFe6H8W9s4ofxZSuDOiYEhGc=;
 b=mUO8sBaA23tf+F3FALfsDV/2W3igxZMU/tElcYyHaCHAUSIlB81nO5To8i1IPhyEPY1p0DiK+Jb4D2FIwBdsVuMbm1nar1MlLkwQCafGpX3UaQveoMOboccOshUFrCz2Y4+wLS5QQX1Wr0YHTmng3NKEPcXTgXVqgbdP7f49kPhu1jPECmEUNbFSceJ/JJGzbHeMNW0KR+YHdsbpk4VKj7YOpLENZUz4nC1QoAwXEmZoWhpASXfrk2OzsWaCNRnQT6MfadKZ88e6WHAOi/MVGCdT4rgDRTtvp3gqp19uncRwmLUfHG/wNPPjtKSfYTuJzTmAI2RiirLVv3HQsWWf+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB8598.namprd12.prod.outlook.com (2603:10b6:806:253::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 19:43:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.017; Mon, 29 May 2023
 19:43:24 +0000
Date:   Mon, 29 May 2023 16:43:22 -0300
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
Subject: Re: [PATCH v6 2/4] iommu: Move global PASID allocation from SVA to
 core
Message-ID: <ZHUAWjK4jXcEg8Do@nvidia.com>
References: <20230519203223.2777255-1-jacob.jun.pan@linux.intel.com>
 <20230519203223.2777255-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519203223.2777255-3-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: YT4PR01CA0375.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2d5197-5bfa-4c64-3529-08db607cf710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jRsezQLq4jE42GBUAQhqFn+RC3+0ri+rRxp9C5cewLj6pZW/UpjgShb8M7y+2VrFINB5SdLclmIqRA5ZniAhahRbEx4VFbmvqQJa7uI731baF7yx24DRXLBXuokfGbIgLatsfOYTPeQ7VmgJ3agD3y2oz2dE5Q2WAlkQWNm7XwyfULROlyBnC2EO7og+C0QvoVeJg2R1sJQprvyVdcKEwp5d5WJ5aNN3O2obzKranZmUz4sKXgcz0i1432jeeRGmnisLT0Fv2M+YwJ4pJyDzS3M0hb4aaO0jWdRJH+nf5MX40O9Ts5MDHtUtFCp2doYlrfcGp9IJzcDI3Dw+5kAr5BzY3Nty5CgOkyMxVtE2gHu7ddT8ptXHINliir5ITm7W3QQYczLC0CVN3MloZU7DLtClgpN7cE9o16d7JI3XHc+P+CCvmomcBKvmByqkJabUscij+i5CBHykKLjBA+c5A+VsG8ASS9C34W7Vi5UAOGUjQ1yy/YArTEru/5mhzAQ1xtwUaxGqjPxJh+7ZgO2EaofGsg9nGRd6rjLBimXIRQyOfPmbXtiBP50SW1hbqyp0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(38100700002)(2616005)(186003)(41300700001)(83380400001)(6486002)(6506007)(6512007)(26005)(478600001)(54906003)(66556008)(66946007)(66476007)(6916009)(316002)(7416002)(4326008)(5660300002)(8936002)(8676002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VVUXmdSL2xjYmkC9pJ/JWarnVwcPUER7FG7AuFoRb+pJKqO07i6YjdFOSShd?=
 =?us-ascii?Q?SVe4c35aYCUQ97w0Yl8C5XaOSBITJQ8Xz0qlVoiNVeIHMXArCeyZ0q/iv6jX?=
 =?us-ascii?Q?hAj+pjMt/iB96l2GPFyWLsYWLzcByKlbFIJmsSs81Xtd9ZddqsQhg72LD4Xz?=
 =?us-ascii?Q?8TcV6NJ+pKRXdEQl9YQjzXr0o4DjY1Rpl40G2K1FLs0POdOS97K6ZfQfIdjy?=
 =?us-ascii?Q?rz1uwA40IHg5oQItXBI/1zQw8TOH8LBlfK7e+i481HkoKsGzhFtjLCeQ28CK?=
 =?us-ascii?Q?LresjUlV9WA/Jka2agB3phwmWedIjSob+f5w+GUEBRN6bZcuz8RTafWaAOvh?=
 =?us-ascii?Q?rzzg0xCNsDhuKBtKiSCvfs5V9fXWc0qCCuUBStKDGgkwjjgomWhA2RJeFY9l?=
 =?us-ascii?Q?+R7h8gNhzKwlMQ8MLLP2VMKY9nSWxOF1W9uk32laf8Tv+L2HqSoCdaA9SVUv?=
 =?us-ascii?Q?w5X8ttFuNW8oL/jUXa5hYc+afP7SoFP75+LOCS0asr2mz0Ng7BF/9rysquPL?=
 =?us-ascii?Q?bwotHRt8LUgyu/JSXDsRWq7QaegrM+jpkpI1TnN0jsK0YFJzv3JKeBtzPMyr?=
 =?us-ascii?Q?a0BcNt3MhfFrKPBYW45L3BqgDp+sOgKsexk2dTtTuofhMwTSAr65WdO0aEsV?=
 =?us-ascii?Q?9RjWyXDvDSpEFbE/4hWqrWb23yhSgEbq0yQAjl+Yhri3e0CIjr81pmJ4B1XT?=
 =?us-ascii?Q?9fCfbIUSk1JbvbIz06rQaTeVm9uKMj/PMTITtYcoly28fG21yzFLCnBaZRCG?=
 =?us-ascii?Q?1415abz+tfNMGQtvy0t08aSglb+7XHeCq+iY1HsHYuRmcXyQ67KMPNG8XVPt?=
 =?us-ascii?Q?hPe2lzJJcRNsQi76ZL9H3ZxcqIDdU9tyBSXWqQVMeIONZ3sANRfHAtsryQtZ?=
 =?us-ascii?Q?aMPLKGgduAe7ZQQULg5UGpHjjFwYaNxNkpFzprbp6q5vw85ty8H4h5+VmEhq?=
 =?us-ascii?Q?vdz+2V6MTOP3DzK1rJU8mPvNJGwym1Hl5Hr6RpiXvRFgKeESSiZNQDR0p9aF?=
 =?us-ascii?Q?xFdzDl+HjvLzQPCOiD+P2EThOkzlcaAaTtyFin7wKwp84X2jKotejuXjl78y?=
 =?us-ascii?Q?84NjK7B6u6SqvZeF1ABHkCNqmQgZQmsna2IKau6lKUCb426LLbM5gXly65AI?=
 =?us-ascii?Q?vPDTivuTBFeTcm2jhKuPdHdyggB5+hKSYluqWk28lprNqs2NpODlY4tps7y7?=
 =?us-ascii?Q?nHpQ/F08CDuJ9ttb3YtBjeKgzwbGEqxGpPjB14KBTvIcoOobJCQbhxpHxoTp?=
 =?us-ascii?Q?Zo/QvIvLF5UztVS03lSr3pWdNrcVhl6X9oT4bX0F+dMvbynJAVjLDVp/T+YY?=
 =?us-ascii?Q?DP2Gr4MRMyB0+rVQAtCj7n7mT8ip/JqA/OHO88CoIR9kQYTOgdZp1KfYtbEL?=
 =?us-ascii?Q?iezj1uYL+78zA1BGQIVzNUSqbPFFwN9uN9j2Qw1OLSCslmo/nmFi131ZH078?=
 =?us-ascii?Q?0FTnr0slC37q+oOcqJDcH7Ojk8iy9DZNXpVJBjK+fkH5WPqY/3lu/l2p1+1Q?=
 =?us-ascii?Q?IuSM8CCvM+2Lbn0jxJWRgwOwf1CRjr7BuUkFut/KzjsrkU4SfQlpmuuQDTMj?=
 =?us-ascii?Q?5OKE4TfrjGrF+sisUNbAy1t8Ng1hK5dd3jZ+pGiJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2d5197-5bfa-4c64-3529-08db607cf710
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 19:43:24.2614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oZxRN3nSn2FXdpE3hFbv9zEWHvFyLphp9pIEE/HXwGGJ739/IUjxkBZGIS7IJzX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8598
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 19, 2023 at 01:32:21PM -0700, Jacob Pan wrote:
> Global PASID can be used beyond SVA. For example, drivers that use
> Intel ENQCMD to submit work must use global PASIDs in that PASID
> is stored in a per CPU MSR. When such device need to submit work
> for in-kernel DMA with PASID, it must allocate PASIDs from the same
> global number space to avoid conflict.
> 
> This patch moves global PASID allocation APIs from SVA to IOMMU APIs.
> Reserved PASIDs, currently only RID_PASID, are excluded from the global
> PASID allocation.
> 
> It is expected that device drivers will use the allocated PASIDs to
> attach to appropriate IOMMU domains for use.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v6: explicitly exclude reserved a range from SVA PASID allocation
>     check mm PASID compatibility with device
> v5: move PASID range check inside API so that device drivers only pass
>     in struct device* (Kevin)
> v4: move dummy functions outside ifdef CONFIG_IOMMU_SVA (Baolu)
> ---
>  drivers/iommu/iommu-sva.c | 33 ++++++++++++++-------------------
>  drivers/iommu/iommu.c     | 24 ++++++++++++++++++++++++
>  include/linux/iommu.h     | 10 ++++++++++
>  3 files changed, 48 insertions(+), 19 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
