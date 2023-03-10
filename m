Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFFB6B33C2
	for <lists+dmaengine@lfdr.de>; Fri, 10 Mar 2023 02:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCJBny (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Mar 2023 20:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCJBnw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Mar 2023 20:43:52 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8800AF24A6;
        Thu,  9 Mar 2023 17:43:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTjAmvs1m6Gk0JNpSvjqg9HCVz34p64WAesEEhEhmYluf0asuKHmIhVKuvHDwOvGqJyQyI2DOfLSjfXC/gZmcedt7iPVE2IEVSZh6XtEBl5K9kBVJWA4sFMO5HWl81TLoFCMQjKVJiWB3kZMDuy50SZ35ivZ3lfDj7w3/4alNstsNRPFsyU+6XODz686CIKv6MvYAoJ2toEffA9mVNtHXmdhdmYLTPyYwAUM95++ONig4sPqrxHY7Z8xsQLWYXx062SzzYBFJHhvg8yUtnf45EA/c8tQMcnKi2rfpsWKqAtyjMe34C8vFuDLO67dgOyB0zdMUN2JNqvMM0kA9jWi0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ft0ahTY9+V20xl19m/BjCXBVZiBqSUuFrCpsQrHm2M=;
 b=NxAwUXkS7BQmlERA7ZWiYlbx37VSwx2pBcJU+iaD73L1mTNy9NwZ6/pWvjh6MMoRhJmzrcX3aXWH4IFjpNEcQDb5eTgsVJRhnnMy8mxhxtdy7H4pTc4h72NtyTIqA5y7bKMcaXIIWKcpT48G3tntPmH8RvctXqqNvisolCjErGkqE8u3BEO7jLD/4vXT3lzZyx2KKcNunsu7MnhJEKhqBb9q86BKsIrR7R5PRMWkHqRzCq3o3iGSOEIpRaAazSZx+6n01qAZPhHtO7GTuhKnX/2Xg3Og7FlHIbnt9e9lk1IjzyNEFcWZQm6g2dIf7LmVVExHXz/ThhuAu4XJ3JUu0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ft0ahTY9+V20xl19m/BjCXBVZiBqSUuFrCpsQrHm2M=;
 b=H6KeGqAGnC+CmOspyF8XcN2iTclmA4if7nqniQL5u0pwEWBjlO07SRmre2ls5nnPggoSbwAa43kOVQhO1UYSahD9Lu2voq3XBHEHeLFP2BF9FdFoRxXPc8CW8ITdSziEw4HQivnygO3BxcE+61eTECgZoOl5Ecj1tTJuekfGPTRvf3gJeiPmOLIzc/t4PSJVURAem5s7dZo7zkGrivAZGfXh2isoE81sDkGKfvqDJQuLheaqREGHdibhqSIxNmq4HlXfR/Mr2MzKWbGLFi1vtPYbvoj5df9t1u6sc3G97M5FQh9Z7fTIqyD2uSJzJbL+ub32BuCnj+jT3naojG6/pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 01:43:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 01:43:47 +0000
Date:   Thu, 9 Mar 2023 21:43:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
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
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v5 2/7] iommu/sva: Move PASID helpers to sva code
Message-ID: <ZAqLUG0uhACSMeXP@nvidia.com>
References: <20230309222159.487826-1-jacob.jun.pan@linux.intel.com>
 <20230309222159.487826-4-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309222159.487826-4-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: BYAPR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: b853f10a-3cff-4230-c8b3-08db2108e3e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wr1ZskuR6r9Rgd9eLgy9uD/je9afaT5/mN4NsxOkDL1hiFu/2X24yeCnPj0lyJiEObOY/+xzppFdOoKkYGMRfmzdOU4c1EpuW+7Q8wa8E27g1aqICoBigEH/lboxRT85uGIjX0cNUfACW7J59mErLjV/lbHiPbq/AqqvF/ptJgnaGQ4BugJS/Cn5Fr4G91MUWYVMOpLhb6YQmetoQTmcHTniygo0GgXHCkQFn4bvSdYE5nQNTszZTtNsFQZVOgTrT/ymLr3FPg5q55vy22Ng4b5h+eNZ0nYGF3PHc4MhJ/8Knn/gvqMcfFL4KKaUJuID7QzMthIN2UAxF5/PG8OoZ2COMTP5fwNJSTnncPsN94nZHM1Ar2FEaabgovKCV3500ERKLd2WqajE6r/U8u6EM4CjILeH2jZFrQr2pw2602yvdO91i69/Y5fEJFDCJju2S0VZpw/oQilV9VkYCumdDLIL7sh0yJbDv7kkPQF1YAtTLLCyAfp7xGkCKBCAhqBFCVQg7FK9IrRHCuNk35Xpprz244ze/kDyr3jSYz6GOzwIkcdlpxsQYYk4YLG/p/bMWZg4IYrliqziK3dNxGFHl7jHb01V8AbrFaDihuNIaTuJRMSv2vBQmAzNx3PO2ry8VcrLHUf/Wolz6b/aJgHr+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199018)(36756003)(54906003)(478600001)(6486002)(5660300002)(316002)(7416002)(66556008)(2906002)(4744005)(66476007)(8676002)(66946007)(6916009)(8936002)(4326008)(41300700001)(26005)(38100700002)(86362001)(6666004)(186003)(2616005)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7qo0weu3uHd1TVrnh4cHZ1gjQLRxp5XVGQJwSLknyBvUkWOrAp11KiVQ9E0z?=
 =?us-ascii?Q?0QYydGM2GcMVFHsCfcu/KdC4cZH8Z6djNkfySz6ukbExmruhbdjfuwoz+fWC?=
 =?us-ascii?Q?R6XRb9nOJi0+DkePrkCW3LjL5tWzXwqzkhVCb5IzCWQk6Gbk1lxF1TWTeM/2?=
 =?us-ascii?Q?9gmywvQYEi7/jt01KXk0x34bUNyxnwK0y+7l3rxQryZdz3Z5g95npF4W/7x3?=
 =?us-ascii?Q?0cL6TuBD2d88n8oJx0OrOg+VsPhWsEUOZTAxoaTtzSOBAqYtGE+63kULQoHI?=
 =?us-ascii?Q?o7MZkpMzKI3PhjTtq6xxJ2P2042pQUi+rfD4IYpigK1rhZHM3ntHltLv1nWg?=
 =?us-ascii?Q?mBpBmtvcjzeSuBKOowBneasHa2GLzp9NJk4J+uqzFVqiFjeErRkDnAp6hr+H?=
 =?us-ascii?Q?JaiZ7pZBvMR7yGxAgfSpbmuIQh5Xsce7/omCBrWorCLijUkxOJXPPXoQmaSi?=
 =?us-ascii?Q?3LD119qKv+UPHFuleiwCbmUtssQ/UrlMmSp+wTGgMtFvOBBUUe6JBj9BuGOq?=
 =?us-ascii?Q?GDnamxCGdN3PdEx4Q8yWk48ibz7AiOfdNMmTmQlAVcEyB0QPdAVk9Nk0nSBG?=
 =?us-ascii?Q?uZCEsxX5Ir7i9mSMJojjMmCuGkSdNEXnE71Y2mB43A9toxqBN1dijAHmJ00l?=
 =?us-ascii?Q?OHZy+hf04fxYXsIK6iQwKW8eDi70PYzdOgcBZVgA2bqkuNBcPS9dAQObh98z?=
 =?us-ascii?Q?SFiB/IdpK7QQW2hpC5MFS1S9W83OLnF4sQLl0UTo73wrVc+znwnIucRuiHiM?=
 =?us-ascii?Q?TxbOq6SRStxhhZMMPX+0qxBCIKg8hv8fLKafRhQkvixwf9HE026++Vci5SnI?=
 =?us-ascii?Q?Lg7ypn3/FlFVIkPdOV2a1oFF8+OlBxU1W+GQGkhWjMG+oyzay/vOJm0kehjW?=
 =?us-ascii?Q?kwEFvkv7knxbFfFqHHhZ1eHy4lxFzJx8c1PeUt6FaYCqh37G7OPXOCp/1KrO?=
 =?us-ascii?Q?4+lD1WQ2DlkWWTwcD5T3s3QA/lP+oPoE8nzwMVkh8BeFsNhNbH2oS07secFm?=
 =?us-ascii?Q?81gjxDEAOljnVcylynEwzjmPVfCFeVl2HyG6RRXU4atAzHhv13DBCfP63Zgo?=
 =?us-ascii?Q?NTdsHx27CCbMN3wfHlYi9g99vpaCoqEAvxHSq5zrdZgd6U59gcX3eK0H2Xeo?=
 =?us-ascii?Q?+sJu5xq96gogdpEPnmvvIajFCmNIlj6bow9sj9ILUemFpajbwHEMzzEhQxIS?=
 =?us-ascii?Q?Oh2yLYoLrG5VXxA4cv7T2AjqUB2WhX48okEhkYRGLBTBPXliPWBMCN7/P8Dz?=
 =?us-ascii?Q?6IKgcy1M7PiRNc8FcqXpMdcIhNGWMl7byHbpYaVbKsJTfM/3oyl0S8VlqKnD?=
 =?us-ascii?Q?ep6Zlj/2Sy/1VudB8JN7BxZwnaNJ/4hel6QnaKUE3l4IHr5MiQgM0BffcpHk?=
 =?us-ascii?Q?dCuJ2m7Fy3dGkAA203AK4rN76PG2qy+PXxpJxAY9oS49JRbeKapBLgy6CQXp?=
 =?us-ascii?Q?M+iOVTOmJQy9jAXEMMezu5/ZBym49KNaIqoXq0FQP1YLfi7pCbawqgjOI5KX?=
 =?us-ascii?Q?GtA7begudG9n4zJM7loEOBFoEX4vy1DbN5pTyuLt/NZrwkI/3zA+03pxwP5A?=
 =?us-ascii?Q?hog2b9LHGvH4iE0LqssQp2WzEbHGNJl9MUmFrLBv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b853f10a-3cff-4230-c8b3-08db2108e3e7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 01:43:47.2786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bi4lwKoLeCu2wgPJTUk3ECDTRLWCsNS+TsmnaCMCRKw5hxyljej88NwNsi0rLBXb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 09, 2023 at 02:21:54PM -0800, Jacob Pan wrote:
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 2a243616f222..f341a7a855e8 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -8,7 +8,7 @@
>  #include <linux/mm_types.h>
>  #include <linux/gfp.h>
>  #include <linux/sync_core.h>
> -#include <linux/ioasid.h>
> +#include <linux/iommu-helper.h>

Don't include this here, fork.cc is the only caller put the include
there

Otherwise it looks pretty logical

Jason
