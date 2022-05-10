Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD1B522794
	for <lists+dmaengine@lfdr.de>; Wed, 11 May 2022 01:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbiEJX2O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 May 2022 19:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiEJX2L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 May 2022 19:28:11 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFF05371F;
        Tue, 10 May 2022 16:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YK+imikyNy4yLZrwbf8NVPWpu1v1NIhpHmUjZ+1wkimAag6JXgZ7NCH9Nw/JAOs7b5Z6S/7CdSBCfVnKpc0NVYbivWrMZ5e87pqYOyACFFfwmQwV3h/9fTliE4Kca5Ul/YHtO/qIt19iW9JddXnjdTuCJM60s7s8c2dV90OHWGi37NQmpP1V1SABIvO6G70kScnLAWRhfy4zY3NK2CJUlHCcVfjt1EOYKNswUvMXTtsedv9Fo5RmWZJXj/1pVsL3ZhgBbUF32RVd9NFBwk07kdBfinMDaEgYta2B2THuObM/p/JEn/sykg7jKiVzG852iIQNvcq09VLv1GDlINc3qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYjvpExMcmJaV9JVCsx5PJp6QJF63jV+DWBqkpDGj0Q=;
 b=OrTsCLdL1lNzGPT3O3Qm7iF3UcjFo959QxKQ9yugQ1SzuX2XQf08ri0U0UfdMxm3K2oiQBtcZdeBoWjasUJQqQJOjSV9o3fox0pocVJcOoxHXB0oM3iRnQbmrIbh/Wdr5XlVSweCeqyZr3CU6gl3q3ptxNPOAxh65oSOwl9wOVLx+X1r0qZHxJmteR0+axsyB+ZPI3rNCGZQn9c/ts15QdVnAeKfEjjx8WNq8XD5k12UHRxMJmT69Is48SAG+0FG8I0B4rnJ5okSRNtMCYuplii3YyXDfRIH+5o0TPTGbQyxnoXChBKrzRsoKcR+H12OdG+4BhmXVdCZ6wKC6kjMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYjvpExMcmJaV9JVCsx5PJp6QJF63jV+DWBqkpDGj0Q=;
 b=CLH0kj5vbd5yTOgZd69n5xG4wm+uUEqpbWwaA/tUP0zsj/O4dXNV/2x9hmF98pXO6DCoibzfJYZykBBdzqAQvYl9/Q/40WLkLKP/fq+p/RpdrX8GhMTi1sstoRnhZA+4ZhkuY9aoHoL3JZZAICmVM4zgLjWK3uSe7Aax2+pQS4uaXfvVwm20dpRZ3497o2hcCeKNkNIY+tQ50FwljoE3atTZZRtm5QGDzefA5Qb/y4epmdkndMUbEX9Uaw4ORC6VNveDAqlcUj6GPcEsY2gB20krsyygyFQ8iKJBoYe1oFnozIf860xLGLVy02/sJfCNA7XXAQfYJ2qlTY4LTUEk0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW3PR12MB4588.namprd12.prod.outlook.com (2603:10b6:303:2e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 23:28:05 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 23:28:05 +0000
Date:   Tue, 10 May 2022 20:28:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org, Yi Liu <yi.l.liu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3 2/4] iommu: Add PASID support for DMA mapping API users
Message-ID: <20220510232804.GQ49344@nvidia.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
 <20220510210704.3539577-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510210704.3539577-3-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: MN2PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:208:23a::8) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f26afae2-2258-42ef-68af-08da32dcbbed
X-MS-TrafficTypeDiagnostic: MW3PR12MB4588:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB458820389BB701D185C3C9CAC2C99@MW3PR12MB4588.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q84fp52culB4SaFrfIzl7zIEQty3eAKm9P7SBFpHHc6xhqPD3N8JieoAa28vUiBz2e7TIxbD9CGE0hW3vVhEoMyUF32YGx9HrjTRBQYWqHdI5FfK2hp8o+HHXib+qih7+Cz5tUU1gdY4M4usaJ/NpEgr3aY3Enq88kvrgLr3KmFy6qQZmr6QNu6KydDTn+Z1s+0Vxga+2uuNi+RV7x5ecgcszhW1qAIbo8FLMYFUUbvY+UTxjtJYGdsVyasViicYx6yJ5KYWxkTIKu8INqKvryh9O9Zd9dQU1VbVBqnZFZBztFDMpEWr6FrRLf6NKJLkOmNM1Z3b5+ajBkU3SJxmXaISIqW13n6VJvo361l+HZIJrbAFVv9grz44cSp+vmIMznkvAIZwTkVEPwiaoYbSgC++QiXzJdm5IAfkvpWsGdX0nD4RcWilrtpPHqB6uDBYuKtfO4yqYCp2rBhGiP6+9nLOrur5DjNEbcqF9xJWtmk3bezkYNphg+uaXujIoZ1abSrxGh4n2OUL1BH1MGaSzjF16so8hEKL7vvpkc12WSqjG6AusANtcr0Yrc3t1ZDz+7+VoXXCFrXDMa6v+/wnzF3f5twdqH/W8WdMmKrD5ZB3vcKIbpx8+x443FnskU2jczY1I90k7zKGYyK0DpkUsb3apxUPuDi6VLiVUSiFNEjlOae41OHs1UrfeTG4wMVAfrAa18ygVZaiYYBNimL8Pu6DJIOxl4hJYhpmFVo9OWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(2906002)(36756003)(8936002)(7416002)(33656002)(5660300002)(8676002)(66556008)(66476007)(66946007)(4326008)(38100700002)(186003)(6486002)(6916009)(83380400001)(54906003)(86362001)(2616005)(26005)(6506007)(316002)(6512007)(508600001)(26730200005)(19860200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JqbjeEOfUvPhOJLZWca76Bdb8HJWp/J23I3AsxXTCBfc4StTSP0fwRqQx+u8?=
 =?us-ascii?Q?U2wEeFzsyNLwbv7NfOcTzy6MHZCv8KpsEF5cteBPT4WDAmQ0j98NUTaeRoXO?=
 =?us-ascii?Q?JBwm5d67KP0I+yd8LyLd4Xhc8qZP6PyAYbw67lHPg2/mMMTqzK+sSY7/sR7r?=
 =?us-ascii?Q?Aj0aGfe8VgyIml7+svtIJ88kbIMy8Q3u6sBK3D40wroHIrx6IU89TXavE3Tz?=
 =?us-ascii?Q?LgEjX6mWag8hXw7F7SLD6bvHrSqAn6Z/4OgsbEil59tdmCdCpiFZxRa1oNoq?=
 =?us-ascii?Q?DLq8vSQVT+V0+0KmiQb503s7Ip/EY0CbR2Ld3KNEbO19U7QbkZgBwj4nVZbg?=
 =?us-ascii?Q?GHyXlcrhb+HtV+zz/whvU+CRpO8zHQ/zXIgztw1hqMfguDQd2l6bzuSMAsks?=
 =?us-ascii?Q?soOK4/MW6YA9g6jM0HySvUu5lMnwUiO9sP67TCnTh0BDheYFSJpsAf8LF1K3?=
 =?us-ascii?Q?PbB7ayBrqd8Km6/o1bLvuzK9BkBCqLqx8yY3QHVDlzuHCWQgr1h6TeUMegCU?=
 =?us-ascii?Q?ZrpwX5LR4y9lDYlIL94msYPjdAXuSl4ORng9aamiSursokRU4523l6y6NClW?=
 =?us-ascii?Q?dMwRl6rTe92lnfr5Hazx7CuENFCV2PKZksf+hcz4eRl/YeHHRXeIHqJxfqZN?=
 =?us-ascii?Q?mnaEAdunK2xHsHjZYSfuOZ1CyTbBqhp9rIbzgMk3QCo6BUenhnZgduHY0WK3?=
 =?us-ascii?Q?7FF1L2lHruavMIotbeKRP8joIsV+Pad/Oh95Ba1yETKWhujuIIsB9o8O0eSb?=
 =?us-ascii?Q?BOCMdugM4bWoP2StNbOSwfKOMERvAAldR5S3g1Ta9kmtT56S/k9FhgjbqiAk?=
 =?us-ascii?Q?f6ZWDNasDDoxRtLGusQq/Ixe0YMtnZOmZgdh2mKSdvFXl8jr4ksFDqTX+mld?=
 =?us-ascii?Q?9GM927LO5aFWujXxivD5F/EcCISYGb00C0SmBly8LxRNtW6TMx0gyTKI7Y63?=
 =?us-ascii?Q?WL/jljMx+2KIu1kfJkt9DU7AOOMTrVzeoVCOY57SIumRfRusWwrQvk+JN7k1?=
 =?us-ascii?Q?cN1CRF1p9vtKVD9mtgbaBxBuL+QpPkHO1ojnNPyIFzU/O6vHivQ5kJsL89IH?=
 =?us-ascii?Q?997osKvJWKOJmrXq6OSyLf+YgkCszbpgzcF0zkLk5fbmbUcuG8JelUATICuB?=
 =?us-ascii?Q?IpiS2sfUA1ZLn+VNQP5Kutcnqv3D7YdURDauFgLZO/kNZewNUsPUC6g+9bdR?=
 =?us-ascii?Q?LsrYK3jNsqYMmwAVomdCSHnAii5oJVs+IdT/Kt7Ccj8fMM6T99NNymJdlkgw?=
 =?us-ascii?Q?aabaeRIrsJEbCfBf4XmDv2zSToG1ErgrZi0fA/kNzfMqU1zwjvXx/Aq0POlH?=
 =?us-ascii?Q?Jya+BRAJjrQnUYz7VAAZKA0kzJSMLL1qgXCXU55WiTfL2k1bQ1mN6rKJSTUU?=
 =?us-ascii?Q?w/Qo9wcDxeUclfjZXhtoFdfezwf80yXw7cmEwtUWwBSVFkwqSLoq9A594Gvz?=
 =?us-ascii?Q?MdpjlITKrp1E1LjNt1YUnCpQDAwKEpBDr5G0EvCn+8t7UUkBFhRci03qpFhs?=
 =?us-ascii?Q?btBwJs3b21whemWF2TWVZ9MY+jj+/b3MRy9iYD9LKVi0sNyjNKE7J2LaSI3d?=
 =?us-ascii?Q?cn1vEUzjiVcdQl6Za5bHMqcaFhCnwIfNAT8TaZZgevAT0byeMifQnFhmUGwK?=
 =?us-ascii?Q?4GAPerta8+cFUPJy+BEMP9tnYWG+3e7fVgFXvomR5klRkkUvIEvwGVl+d4S8?=
 =?us-ascii?Q?HgT9cBVu+VuXAmRdyyqU08I5GkH1BzbbL9gXd7nl4YjPh+b5Ggphoxo2KVcA?=
 =?us-ascii?Q?D8EMSk7SWg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f26afae2-2258-42ef-68af-08da32dcbbed
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 23:28:05.4844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oBoDP3L2iCm7lwSjTOpRERUCgCs0FrV2s/aGKD2uoaQL7Owf4Tp1JsQKq7/Yf2d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4588
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 10, 2022 at 02:07:02PM -0700, Jacob Pan wrote:
> DMA mapping API is the de facto standard for in-kernel DMA. It operates
> on a per device/RID basis which is not PASID-aware.
> 
> Some modern devices such as Intel Data Streaming Accelerator, PASID is
> required for certain work submissions. To allow such devices use DMA
> mapping API, we need the following functionalities:
> 1. Provide device a way to retrieve a PASID for work submission within
> the kernel
> 2. Enable the kernel PASID on the IOMMU for the device
> 3. Attach the kernel PASID to the device's default DMA domain, let it
> be IOVA or physical address in case of pass-through.
> 
> This patch introduces a driver facing API that enables DMA API
> PASID usage. Once enabled, device drivers can continue to use DMA APIs as
> is. There is no difference in dma_handle between without PASID and with
> PASID.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>  drivers/iommu/dma-iommu.c | 107 ++++++++++++++++++++++++++++++++++++++
>  include/linux/dma-iommu.h |   3 ++
>  include/linux/iommu.h     |   2 +
>  3 files changed, 112 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 1ca85d37eeab..5984f3129fa2 100644
> +++ b/drivers/iommu/dma-iommu.c
> @@ -34,6 +34,8 @@ struct iommu_dma_msi_page {
>  	phys_addr_t		phys;
>  };
>  
> +static DECLARE_IOASID_SET(iommu_dma_pasid);
> +
>  enum iommu_dma_cookie_type {
>  	IOMMU_DMA_IOVA_COOKIE,
>  	IOMMU_DMA_MSI_COOKIE,
> @@ -370,6 +372,111 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>  	domain->iova_cookie = NULL;
>  }
>  
> +/**
> + * iommu_attach_dma_pasid --Attach a PASID for in-kernel DMA. Use the device's
> + * DMA domain.
> + * @dev: Device to be enabled
> + * @pasid: The returned kernel PASID to be used for DMA
> + *
> + * DMA request with PASID will be mapped the same way as the legacy DMA.
> + * If the device is in pass-through, PASID will also pass-through. If the
> + * device is in IOVA, the PASID will point to the same IOVA page table.
> + *
> + * @return err code or 0 on success
> + */
> +int iommu_attach_dma_pasid(struct device *dev, ioasid_t *pasid)
> +{
> +	struct iommu_domain *dom;
> +	ioasid_t id, max;
> +	int ret = 0;
> +
> +	dom = iommu_get_domain_for_dev(dev);
> +	if (!dom || !dom->ops || !dom->ops->attach_dev_pasid)
> +		return -ENODEV;
> +
> +	/* Only support domain types that DMA API can be used */
> +	if (dom->type == IOMMU_DOMAIN_UNMANAGED ||
> +	    dom->type == IOMMU_DOMAIN_BLOCKED) {
> +		dev_warn(dev, "Invalid domain type %d", dom->type);

This should be a WARN_ON

> +		return -EPERM;
> +	}
> +
> +	id = dom->pasid;
> +	if (!id) {
> +		/*
> +		 * First device to use PASID in its DMA domain, allocate
> +		 * a single PASID per DMA domain is all we need, it is also
> +		 * good for performance when it comes down to IOTLB flush.
> +		 */
> +		max = 1U << dev->iommu->pasid_bits;
> +		if (!max)
> +			return -EINVAL;
> +
> +		id = ioasid_alloc(&iommu_dma_pasid, 1, max, dev);
> +		if (id == INVALID_IOASID)
> +			return -ENOMEM;
> +
> +		dom->pasid = id;
> +		atomic_set(&dom->pasid_users, 1);

All of this needs proper locking.

> +	}
> +
> +	ret = dom->ops->attach_dev_pasid(dom, dev, id);
> +	if (!ret) {
> +		*pasid = id;
> +		atomic_inc(&dom->pasid_users);
> +		return 0;
> +	}
> +
> +	if (atomic_dec_and_test(&dom->pasid_users)) {
> +		ioasid_free(id);
> +		dom->pasid = 0;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(iommu_attach_dma_pasid);
> +
> +/**
> + * iommu_detach_dma_pasid --Disable in-kernel DMA request with PASID
> + * @dev:	Device's PASID DMA to be disabled
> + *
> + * It is the device driver's responsibility to ensure no more incoming DMA
> + * requests with the kernel PASID before calling this function. IOMMU driver
> + * ensures PASID cache, IOTLBs related to the kernel PASID are cleared and
> + * drained.
> + *
> + */
> +void iommu_detach_dma_pasid(struct device *dev)
> +{
> +	struct iommu_domain *dom;
> +	ioasid_t pasid;
> +
> +	dom = iommu_get_domain_for_dev(dev);
> +	if (!dom || !dom->ops || !dom->ops->detach_dev_pasid) {
> +		dev_warn(dev, "No ops for detaching PASID %u", pasid);
> +		return;
> +	}
> +	/* Only support DMA API managed domain type */
> +	if (dom->type == IOMMU_DOMAIN_UNMANAGED ||
> +	    dom->type == IOMMU_DOMAIN_BLOCKED) {
> +		dev_err(dev, "Invalid domain type %d to detach DMA PASID %u\n",
> +			 dom->type, pasid);
> +		return;
> +	}
> +	pasid = dom->pasid;
> +	if (!pasid) {
> +		dev_err(dev, "No DMA PASID attached\n");
> +		return;
> +	}

All WARN_ON's too

> +	dom->ops->detach_dev_pasid(dom, dev, pasid);
> +	if (atomic_dec_and_test(&dom->pasid_users)) {
> +		ioasid_free(pasid);
> +		dom->pasid = 0;
> +	}
> +}
> +EXPORT_SYMBOL(iommu_detach_dma_pasid);
> +
>  /**
>   * iommu_dma_get_resv_regions - Reserved region driver helper
>   * @dev: Device from iommu_get_resv_regions()
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 24607dc3c2ac..538650b9cb75 100644
> +++ b/include/linux/dma-iommu.h
> @@ -18,6 +18,9 @@ int iommu_get_dma_cookie(struct iommu_domain *domain);
>  int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
>  void iommu_put_dma_cookie(struct iommu_domain *domain);
>  
> +int iommu_attach_dma_pasid(struct device *dev, ioasid_t *pasid);
> +void iommu_detach_dma_pasid(struct device *dev);
> +
>  /* Setup call for arch DMA mapping code */
>  void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
>  int iommu_dma_init_fq(struct iommu_domain *domain);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 1164524814cb..281a87fdce77 100644
> +++ b/include/linux/iommu.h
> @@ -105,6 +105,8 @@ struct iommu_domain {
>  	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
>  						      void *data);
>  	void *fault_data;
> +	ioasid_t pasid;		/* Used for DMA requests with PASID */
> +	atomic_t pasid_users;

These are poorly named, this is really the DMA API global PASID and
shouldn't be used for other things.

Jason
