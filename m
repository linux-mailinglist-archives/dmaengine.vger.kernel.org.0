Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9517D532BAB
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 15:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbiEXNvs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 09:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237992AbiEXNvl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 09:51:41 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637263E5E2;
        Tue, 24 May 2022 06:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PemnHfgfGSbE+WhoihWAXmznAdupXYtYl/rCsq0xb0ShvKRTaUercTEtI4EdBFW7LCKoNemF6WEsJxRpUpkhh3I0XZO7jr21KzcmB3dgKWuWE8ANgIYHpZTgEEBMsolvMU/DOQRieLh8ieX4JAcBQBgRoWa2fuOcknod/QIu9jlHAy1f73DmSh9LmSuJeetcTvlyTquaQxRZtbk9u+HPCk3+i9lkyc8PouZ/x7Z11Vfxi1EWyLJWqPO9OR7zEasn4gBUkrf2+tv10iKIntNnprcdLTZrh7kUkJQecWHGjV1/6CCxubhxVJHi6zJI7c+31XmjrPAVdiS5QdZVK5dfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PukwRsX+JmHD5N09748MoeymA2Y6G3XhM6DZ5iNnnEM=;
 b=QzK1AheutntMBIJL5s3Y5g3vRvGxEUTLDx2YkJeVv+DneSoxyk7TT0EFi64Ia+v8kz5ysGLOtiQUdFzup75IthtNlU8cS3Y8Fk0KQbwm6vdoJecIKIUftzozqokivhUyqKSgyty7AbCpBy/TyYwUL+tRISLMFXFrHbDwIzsLINOTFmbiFzv7ktti0+R59zPvEHg93uAR4tpJb6jMA5XPO9dwf3G8WNyU2Mn1/9QpHzIowJRAcDR6RzP5/YOTkOMyC2QQohiAhBc5I63Pvo9xlk7q4id2M4vUESUsuzlLuzGDDky3216RilU6EUA8HCRvoA5koZLnSiYjv1pBXp/AMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PukwRsX+JmHD5N09748MoeymA2Y6G3XhM6DZ5iNnnEM=;
 b=V/m7KrEihlMqVLI+NoveTpGDmPBGLpz7xi64GAmpp0TZ2gA3kUYJ9hXTxBnZvuWv7sgrxK9/fX3+eFzzzsEhnRuvO9FwvgEo9QRpuwP4S+EKxBTlmejEFFm4qDHLyTwec9YKU5wSDvu+P+4mFld8PzcM0tkRKjubWIXXXE02I2TR6/ZtQy84VK0ajOCitQV38kPqc0iFLeFOtwEUgy5Xyg+s8/aVr/8WR4DS+dZf7EHw51LYsQD06mU15o6g4FscW93imBPXiJ7xyYQlrqGQ5o1a6wtaMMrs4h8u0trQ2q1Ivz3twe5P4QWnSkmalW5PIH3aB34varTVm/5dJbxkLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1895.namprd12.prod.outlook.com (2603:10b6:903:11c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 13:51:36 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 13:51:36 +0000
Date:   Tue, 24 May 2022 10:51:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org, Yi Liu <yi.l.liu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 3/6] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220524135135.GV1343366@nvidia.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-4-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518182120.1136715-4-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2182ff5-ab2b-4dad-7ec5-08da3d8c84e5
X-MS-TrafficTypeDiagnostic: CY4PR12MB1895:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1895E609772DD560160D105EC2D79@CY4PR12MB1895.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VyPC5abRbMSayTdAiWn+WpLfxMcDFVqhWDQ/CaP7H6+b+te89OC0YSHXDInvLDsjtnYPcAFtMCXbRw42+wpw9y8EBmT6IGhhkzjcXSAtxMC1oslSD/SmqVkQij0aR7FBzmA6tu4GO+lsapgvlt/U9381c53jlX1VGhk6cmycCFnUA8XjtMCWnSXq0mslpAgRQ30dclOCV8wYnDlYLni7NNqrQcXpVkQqcYmu9iiMe/ueaJdRGkGmDo8w4hJnrFpuxm3o51HlQ8+xlB6j0EAEMsByhF+ygOE/rBjf2cH7I904ieOgPRrvUzGGdqOxXlOgcRzzFrGMjw6SBo01JS/z22tOpdUQfXHqWSgCUxu3RFbqWmr6pJB3VJRzVTTxWhOVouA+0BwA6KlGgrUUjPIHEfIZyPZIatUdVgV5UcaycoB/LdJQ9VvMqBJI5B2rJ2/pWQ0cRo8BIS7FGXbRWp8NvckkrI5eNMWewgDrPCLJt2+qJo4wL47YyatQ0Azqp+UYJ+ArkT4AGMiiERno5oH4HYAl2vsWsin7huc3Hmxf1H//a8VraCRe8wtWfJT5H5NBdE5mviHU3sP8e+wptGw/q8tnAl3n0551IbEd1wsv4gNXFyGcsUO8yVdmS6MXhk1ILsu9FK+LjBkoHXAXAranog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(5660300002)(7416002)(186003)(2616005)(1076003)(8676002)(66946007)(66476007)(4326008)(316002)(86362001)(54906003)(6916009)(26005)(6506007)(66556008)(508600001)(38100700002)(6512007)(6486002)(2906002)(83380400001)(33656002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S/JLbNVvpNfQw7mLQags8Fw4hujfISGf/a1rs4PJle13k1d1rtXuUOlg2IPz?=
 =?us-ascii?Q?+XtLkmx/DOhFSE73P19pxH/RzOsSDEbXgzSE/lLNQoEqQsd3mr4U7fcHc/HA?=
 =?us-ascii?Q?b/syUhxHKSdmDeYBdK5cel6e33uAJLHEa21dR8MnrkM1dbScnp8Yrk1u+WYI?=
 =?us-ascii?Q?Sy0K8cIP3vhLpd5dIcOJRVClqBy0fJosRMlQul0nEIKHzCjjnZmbmbx+0g2Q?=
 =?us-ascii?Q?L5ke7RkRwVb0dalb08j3GspLiKn1jyZT/oWYIQcSBYgxtI0CP57VH7Y13Zm9?=
 =?us-ascii?Q?5F77CDhDMcs6Wp15r9jH3fVtDgWu3gDqguj8l0NhkOQT9OKOMJGp2A4uXkT/?=
 =?us-ascii?Q?JpgBGOfBVd3PSsGXCwUcuWGsiGcVSCbDI+cqwz+DuLhoohHKG1pQEac2+kmM?=
 =?us-ascii?Q?QwW5974WJZzQB5AJ6fE9Du21vq2HgWPMcoKubZzZ8HxA16/5BXUTkiBY1YjH?=
 =?us-ascii?Q?TirbLOfPYfxmfMC+Lh+YNPEoTfIBBtfoQsXIHR5QFnwLpZhx0IEyoEdjhtRf?=
 =?us-ascii?Q?PO4sCv2nKo1QelLVAvDzZ+lCnpN6H6SSikUAVXQ9Anj31vCnEDIX36Lm9FpL?=
 =?us-ascii?Q?wkiYT7+A2SNkAWuAozQXisGH5eW6rrhMG2fc4pTa6EnVXCQF9O39b27yhIG7?=
 =?us-ascii?Q?j3XDw67nD0NsGkqYtqwnpv9v/xGIIjCkBmurWnXvvcsSzMNpFBoqD8fpvlgX?=
 =?us-ascii?Q?XY/CYbWEf9QNH6X6/zubpywFyNBV4KNLE7ygwA+WTBxK1ijRiM4e6V2j6N2o?=
 =?us-ascii?Q?w9SfPdTT8yyKBnoGVk00Dv+B6+rItZWzZ6R0Hh4CftmXbYLvsMgWi7H7hb4I?=
 =?us-ascii?Q?V9yZPWUgD5Prv/CrbzTDquoslxgG6vwkxuUWqUzFdPMO8bzxjr+i4xvz8/2w?=
 =?us-ascii?Q?KBNPmMUsk0vMQCT3IJ8KtMxW8Zj5+aJy5bbCh1ufWM2ro3w48RMntfIrXCma?=
 =?us-ascii?Q?TsTbQeLfu0ciNVPVm+mfpXBs7nU9eE8e+8+GqDxwdkJ5KS08PDGCgAH5eVDH?=
 =?us-ascii?Q?U6V4Nfw+LaAJdHzSVKcryF3L8Hu5gvQLcYf1/W3p7Nq8Dq1PfFBjlHvcd0Dg?=
 =?us-ascii?Q?UYhN65vejDGrDAuDfsxIj+3FjFnRXipdWtpZNIPM+MjzDoset7pfWkf4dmUY?=
 =?us-ascii?Q?QW04mPG6aWm/RAJ5wT4tPQeIzXbXVm3y+gfEUZQBj9CVY2BZ6woSvV6Z5YoP?=
 =?us-ascii?Q?+jegd+apZ+dzibk/8zdJEHKscfZytE55SgborcbAUjKX2kCQRsuiEpTuFK/N?=
 =?us-ascii?Q?XYLhtuTsl8R8yzAnRf22ejaKYeKUavbNKQZqDIb3hoK1nckwB6NZJ9AE1FYz?=
 =?us-ascii?Q?czV4gEdx3YBkojQ+rnAJV8rA8yw+gfyzffgC0tujGagodvO8jf7rO/EaLAZE?=
 =?us-ascii?Q?xG/BreYbc+nR8D5CtnXZj/T3eAPs3o0AYtYVmTmjpSjpd8W4/FP7HFiPwd0U?=
 =?us-ascii?Q?nEXwTfpgJywYC8ukYsiwpYkhLWZCC0IBNea5hbnTKFFTX1l5XjOGE6UPyBE9?=
 =?us-ascii?Q?SOPaMTNBK9gq0qHkwvJ2Nqu/X4dzbkeqJZnCtDV6VP3v8G/CF9RXPFAyjlNM?=
 =?us-ascii?Q?Cb4vIqs8/NjPStEtSweEolK4/2dobge0ti/IndmyzT1Bd4VJQuc2poPz5kgE?=
 =?us-ascii?Q?YdOrS7peTjhhDc2UKfpgDsXOIeBQ1Dr704r/lVuGWLuRn06iLwCOp3jZW0db?=
 =?us-ascii?Q?lPiTa5z3oTueo6Makqn2T6iec1zcXD8WQKj+4Jx+htxDYtz3wyQNA0datvz0?=
 =?us-ascii?Q?yREQOwQjGQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2182ff5-ab2b-4dad-7ec5-08da3d8c84e5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 13:51:36.2257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YW6G9xCXolCFq0qVg4WUZ1uHjpNz38E89SPDqFPnhkkF6UJNjLiuv5v45K7C0wmS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1895
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 18, 2022 at 11:21:17AM -0700, Jacob Pan wrote:
> On VT-d platforms with scalable mode enabled, devices issue DMA requests
> with PASID need to attach PASIDs to given IOMMU domains. The attach
> operation involves the following:
> - Programming the PASID into the device's PASID table
> - Tracking device domain and the PASID relationship
> - Managing IOTLB and device TLB invalidations
> 
> This patch add attach_dev_pasid functions to the default domain ops which
> is used by DMA and identity domain types. It could be extended to support
> other domain types whenever necessary.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>  drivers/iommu/intel/iommu.c | 72 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 1c2c92b657c7..75615c105fdf 100644
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1556,12 +1556,18 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
>  				    u64 addr, unsigned int mask)
>  {
>  	u16 sid, qdep;
> +	ioasid_t pasid;
>  
>  	if (!info || !info->ats_enabled)
>  		return;
>  
>  	sid = info->bus << 8 | info->devfn;
>  	qdep = info->ats_qdep;
> +	pasid = iommu_get_pasid_from_domain(info->dev, &info->domain->domain);

No, a simgple domain can be attached to multiple pasids, all need to
be flushed.

This whole API isn't suitable.

Jason
