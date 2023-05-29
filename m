Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D1D714FF2
	for <lists+dmaengine@lfdr.de>; Mon, 29 May 2023 21:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjE2Ts6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 May 2023 15:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjE2Ts4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 May 2023 15:48:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893DDD9;
        Mon, 29 May 2023 12:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2oghUm+bbjGoRwCmmoJ/jWxT5iD0mfYNy4fqAuSdX8gC0/6UzVIKJfmVKKVULqFNzfz1XvyN/jAxibcL2kKwBVDna++bcj2xEYTBHXx5eIaQBiMIxG3O3L+d70OiMp6r86pkTJnrQCmK7ulpYHjeJpJLcE/Dj6/APyh/X8+cnxp/Ro2msuwhwFMnfBmpuSN7Irs3gdUzwhvhH4QjLevVFWAnuVP33nAEDWtXl87sr/s/C9+nd80cxtSADhJ4fheblEDEIFdjm6ba9zSUrSKehiQ8Vn5F9qh8dgyBPulPbHnxDoD+op5g5W+3K4hWAuQ3R3gJ+HWs3tghrJGJgDaZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7uiHRdWIGmtGjcRpn0WygW3OFYuu1QIhFQjOcmD11Q=;
 b=diMB1Ghos1FmqBCbo2DM0v7p+r8jGMQpDBFGLIeUBGoxB9PCHkyfaK2WAp6VY17Xhm/auqU2LAevflYLcfuS7XJSL4boGgvkLT7dzPH1cyD2qWlZ8kJg2ddMhPJ/Y+yFSdrCZqm8qJgr2v+LgdHKTYnhRqhUzR59yJiWuOD3TYgm74/1VjpPliC4dzvmqXtixxC89fdxH+Q2g+ZGe3xJ2fl6Fms16SuIb81/iX6YD9OtQdy/3uuDC8qeCcs3qrvRMoVvrEXK0yqBVW5EjCewdu35qKUuNmIzBcXYsOXfGE8D4HT8Mh6yfkbL3Wcb17k7KHb+xzcZyO91pO9JUreWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7uiHRdWIGmtGjcRpn0WygW3OFYuu1QIhFQjOcmD11Q=;
 b=djN+6jZx6jTp3nSOaAr+1Tlw5/Vuq0PhuXxufjkNTD7pblNr5Weot1wiE7Z7/cJGidIWjfegk8LhC3IeZENoS2uPQu21SJ25ZL+z/QJmbEueOHeQ0tUYUqVvbO22F1si38B1s8mXypXK+RUDk8y7m4GMBFmpnK264TsYskT5GB30+VWe6VLHsdmEOlnmjB8izKmSvI+2x1G+U6ptxl0nbSmTWdO49kKOpDvBfvU4EhH+/xkaEwNN6OBQ8dOeQCUcsGe7FaqgEGiJcH/OzqMkr75qA4iujw6jdSOG9DsQU4XsNXwR2e2hbbIq4j4Z9CDpN9Hx41AHnw+DaZS8r9pUeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Mon, 29 May
 2023 19:48:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.017; Mon, 29 May 2023
 19:48:50 +0000
Date:   Mon, 29 May 2023 16:48:48 -0300
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
Subject: Re: [PATCH v6 3/4] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Message-ID: <ZHUBoBev2Vzp8nGF@nvidia.com>
References: <20230519203223.2777255-1-jacob.jun.pan@linux.intel.com>
 <20230519203223.2777255-4-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519203223.2777255-4-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: CH0PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:610:cd::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 162514bd-1da5-43f6-9b3e-08db607db932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 85QhTbfJ4v+rLGov0PrzdJC1IvDNKhbSDfIqcMGIEdQA7iLtWqbKOC0/HAiVTd9/OHVn3UqP1dJhZsnsWEXZCrT4oVbJhnOu2sN+7Ff+pAytuZalBEzSPiyclIWTsAqQQ+sb1oJae3SUCB31ogX6m4NvjSXlVdO9QEQeIArGuuEkMMffRqDB6noiKIxNGw5vWGNIGy76cCipMvKgHa7pbqwgSHXoLe10Yw/3LSPjHSRwC0FLWEmJid/HnZXpBDI3nTeNc3U/UtrSgfLGIzQC0b7BL0f73avfUAvADZLTf4Km3GB/rHi63+e68ZD/6w8VtAnsUkFEEmon1k8hhMFrFW8dymTN7gnFJWteu3d9Qkyj3Iq5Wez7XQlG7VX7Dg5rIAtsHYMyHqjB7H3LFoXEr0/dXIURk3h2IhCxcgHopz2GopDVqYtFBaNK3YN9+G//6sj4GwztTneeFjpfdWmz6LT5jx5lTSdLJPCvmIzTebVrbm/HWASB7ZtMICAv1eK0aJwCOV8rbzNIXZTwiQv2SMvcPt9hNqHUFsded6ND3i+P/7knvXG/yyC4kT1JSR/x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199021)(8936002)(8676002)(6486002)(86362001)(41300700001)(6916009)(4326008)(316002)(66556008)(66476007)(66946007)(7416002)(36756003)(5660300002)(186003)(2906002)(6506007)(6512007)(2616005)(26005)(83380400001)(38100700002)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fv6005lStlJihsTZX9JMldNnGAGQy9yYuc5NCH/4XbcR9Hsp52AGuqLdRCTW?=
 =?us-ascii?Q?mGiySy95JEbAe2WipPsXwakAI9TSDhNOb23Tm+3g0JqqhkVHy62fEiY2NVmm?=
 =?us-ascii?Q?eNmeOz/X1nWHC/zbdfFucLoF3Defolel7sEpx4Z054820GHvD5So7C70hBoo?=
 =?us-ascii?Q?/NUHaFK96rE30BKCt5/L3kM2PxmGiULKcm4XTrVUxm2T+ir+Knqqd6FRThmq?=
 =?us-ascii?Q?TuoCAtmmI512pbtlBVcvzkSsVKy3hBwPiUf061rz2xgxMkVcECsUKsg8/UIS?=
 =?us-ascii?Q?JhUL12tYc1DUsgXhCcLTE9g68USts4y9cRtfuprLp8OovpfikQiUJ4upM0jG?=
 =?us-ascii?Q?uqeKan4V5wYqNyfEDqMv5VEEOICMoMgXmNKpZA8lURv/A5/JqP6LtwglNIQ8?=
 =?us-ascii?Q?7kq/BkykzesqrmKcN9gHAaxODORqBLYFIDw6BrAHMNvqQtGhWmg9qg86psTl?=
 =?us-ascii?Q?iOY93uEHA1WB5YXNxbvV4Mh8uvdgfWCTKq1US2ot5lQYejA9D8u7/lWR3taQ?=
 =?us-ascii?Q?sId8Pbsd+MnmxQoRt+7eG/ARKvEKJvbNvM6xlaFEeD6UwpVJUFLgcLIZU1c8?=
 =?us-ascii?Q?zkxAwilX5LFjCpufDS6aS93qV7H8npPRAiR7lLiiVdmpR6/gkOZajpJaC6tL?=
 =?us-ascii?Q?hq0k0Z8smwZ13D98ArLe9FzXyIRYBHNE26MQgmm6dcOCqAi432H95Pf1cuCs?=
 =?us-ascii?Q?dY4cAouJcPxWeBt9hsF6KkQU+ty+Hp9RzBj+aVMuwzPUGmqwCOlKMXKD6SzH?=
 =?us-ascii?Q?4qpFlxcAb+zez+LQ4IxNJ+835JgVKj1IbuVvIdgC+oJQq7qyf3EdD5gcP3+F?=
 =?us-ascii?Q?Wb7AynhB4OhaHAkb4p6vFxZ8w0Lj6xDPFX280j9IAkdA3DsR6pYOmP/Gg736?=
 =?us-ascii?Q?Vm9S1drFaAtGcJwjnts2202da4hnzNZ7K7lURNZ02BkJZHOTYF38eqAkBT+2?=
 =?us-ascii?Q?GVkP0DYDtXDqXtWURp2SraI14visjae98VKZAVHLX7cQsevpjurjTxHi8Wuv?=
 =?us-ascii?Q?aR081za3PvBbCHL891JFJKNMiI2CpJhZ4DWkGJ93sHXDTs11aWHj0dAM8+ij?=
 =?us-ascii?Q?sNS2vuPwIEa5SuHjwtHxugztSabFAPmB2n/JkOiersv+eTW9pI6gHKz4Wy07?=
 =?us-ascii?Q?tAat6UU7fVdDgqZKAZB3WQJnlS853W3lSnV6iumoRn4HWu1lbjh3BF+C1L4G?=
 =?us-ascii?Q?ed3jnC1aM2wVWY6G1fsgYQFpnlaPjzxS6TNdBXHaWvBHcbOPO9+WOyGWWH9r?=
 =?us-ascii?Q?rlP35SYOp2U/L3IhZpz2UR3/TWsu53jcpVUYz4EEGNtpZOW7s2mmapjZ5Bww?=
 =?us-ascii?Q?rCHdpIdTajKN75B6gKReOcSCyvItu/EC5HI3tSESvWjXbKXcb9rOTvviI+aQ?=
 =?us-ascii?Q?2NCNFWry9IGGNc/I/GVvU/tTJE3qiojHsA+UspDhq1pGnMVJnVcvTG6gTXbm?=
 =?us-ascii?Q?hzhqeUGuzkeA43OE232Mq5jBTUIwUrW4Q6IoHk+IU5gPvQhjLoMiSlRvfmvj?=
 =?us-ascii?Q?Hg6Ncp22IhPD2zTzyRAjWj9wvdiMq6VsRLWNyBxRFGNgXpyqEKE5hgI+7eBC?=
 =?us-ascii?Q?HGexX4iLmNeGrOdUUf0LL/xQBlZpvnDt2Euh7zrD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162514bd-1da5-43f6-9b3e-08db607db932
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 19:48:49.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wFVr+Avon+em8Sv6GaiSt+mPR5bws+liFc5e6zgc2zJycUi8KYKQDh/ulplrQiS
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

On Fri, May 19, 2023 at 01:32:22PM -0700, Jacob Pan wrote:

> @@ -4720,25 +4762,99 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
>  static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>  {
>  	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
> +	struct dev_pasid_info *curr, *dev_pasid = NULL;
> +	struct dmar_domain *dmar_domain;
>  	struct iommu_domain *domain;
> +	unsigned long flags;
>  
> -	/* Domain type specific cleanup: */
>  	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
> -	if (domain) {
> -		switch (domain->type) {
> -		case IOMMU_DOMAIN_SVA:
> -			intel_svm_remove_dev_pasid(dev, pasid);
> -			break;
> -		default:
> -			/* should never reach here */
> -			WARN_ON(1);
> +	if (!domain)
> +		goto out_tear_down;
> +
> +	/*
> +	 * The SVA implementation needs to stop mm notification, drain the
> +	 * pending page fault requests before tearing down the pasid entry.
> +	 * The VT-d spec (section 6.2.3.1) also recommends that software
> +	 * could use a reserved domain id for all first-only and pass-through
> +	 * translations. Hence there's no need to call domain_detach_iommu()
> +	 * in the sva domain case.
> +	 */
> +	if (domain->type == IOMMU_DOMAIN_SVA) {
> +		intel_svm_remove_dev_pasid(dev, pasid);
> +		goto out_tear_down;
> +	}

But why don't you need to do all the other
intel_pasid_tear_down_entry(), intel_svm_drain_prq() (which is
misnamed) and other stuff from intel_svm_remove_dev_pasid() ?

There still seems to be waaay too much "SVM" in the PASID code.

> +static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
> +				     struct device *dev, ioasid_t pasid)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct intel_iommu *iommu = info->iommu;
> +	struct dev_pasid_info *dev_pasid;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
> +		return -EOPNOTSUPP;
> +
> +	if (context_copied(iommu, info->bus, info->devfn))
> +		return -EBUSY;
> +
> +	ret = prepare_domain_attach_device(domain, dev);
> +	if (ret)
> +		return ret;
> +
> +	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
> +	if (!dev_pasid)
> +		return -ENOMEM;
> +
> +	ret = domain_attach_iommu(dmar_domain, iommu);
> +	if (ret)
> +		goto out_free;
> +
> +	if (domain_type_is_si(dmar_domain))
> +		ret = intel_pasid_setup_pass_through(iommu, dmar_domain,
> +						     dev, pasid);
> +	else if (dmar_domain->use_first_level)
> +		ret = domain_setup_first_level(iommu, dmar_domain,
> +					       dev, pasid);
> +	else
> +		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
> +						     dev, pasid);

It would be nice if the different domain types had their own ops..

Jason
