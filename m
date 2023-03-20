Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA726C2136
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 20:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjCTTUs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 15:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjCTTTX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 15:19:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21032E1AD;
        Mon, 20 Mar 2023 12:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPm4XGecaAiJgw3lJXTRNLXUSU3V68+xXN8PAOCTIPo0QDoObUwWCDHfdNB/8kOSbqy6yamhw50FLk3aORYnYKLsjM7v1A+A5cm8hq0BzPa2YmWBLElY3OMS60HbG6w5ieKmajqC2640Pe+CvnansJNstfp1R1+I8O8naDuwF4pBfJ+PBZH8XxwVYN2vqoNlO567svQ/0UNVfedt03GBEzAeHS4aL0PHn7/d3UG6nWdPtyRAcwanRvJnRIO2hKOI/xYHnFgym9wExvpYSXkyC3gq84WlnLK0uA7Ww8M0UoWrAaSD2Rm6zaC/MoNVPIrDMT600Tr5XhzExjmhLIiFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0TooSyZrgXJgX6GFt4U94Y+9mX47rDQeSZl8faGHLw=;
 b=Ny9qHx3OPD3V2lWkar+xYdAf1zzDLQ67ML7xjwIR0SGWKbAEI05eEf6gOYFlNOl0mRACgcXW0v2J+ymN94Z+Eevt9B28FFnnw43+Z9k3LBY8IeZfvEF1xUgh9TLYvLTVTjXD+CyEGdc84Fa6U+jHuDSv9NFZNxZLgzyYMlhBnAVGGgeLPxpTb4HmirHrkVJ7E3HPbfiTDeFtEkeTCm/NLZ1jl4B2hbaEpEd0tzLqhjNOKSGm/WGgf7Q2l2/L+mO3Tqni0Jr2fyhsbHiFFjBAQrcNKw03jAfwtbT72K3gQH9BSxDPuWcCNxzU+LMwzq6iBgPGiafQ0eninmiveSeFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0TooSyZrgXJgX6GFt4U94Y+9mX47rDQeSZl8faGHLw=;
 b=D75kv/zWnB2wyTE1yWQEDzcNLxPqhhu0M9qKkotNoqTqmKGq7g1ZDc4LARbPtLElkqhiEeAhRKrjG2GmMoDj5o961roj7oyO/VmQnYQW9VJvBGz6/xDjHHuAbcKfR5uIMucntQaIlEtHfJ6uBF71PSsJnuPENUcLyz2ANe8jK6aKWb5ieQIIqJpLSKEM8Tr24dwmA1vh1f5N1oH+7/wiUt5bZLdWC7X/enb+tu1ebYXP+RuJsTqm3AHIKpOPM66KceFcAlwznIBHN5gVY4TS52PlUqq3U05FotugaHH2ukPomC43i9yaaON495497J3FaAMZwy8XNI2pRt8BktdvjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 19:11:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 19:11:12 +0000
Date:   Mon, 20 Mar 2023 16:11:10 -0300
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
Subject: Re: [PATCH v7 2/7] iommu/sva: Move PASID helpers to sva code
Message-ID: <ZBivznuBdkadHbA+@nvidia.com>
References: <20230320185910.2643260-1-jacob.jun.pan@linux.intel.com>
 <20230320185910.2643260-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320185910.2643260-3-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: MN2PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:208:160::40) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f2ab1b-6698-4f54-8b0f-08db2976de62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RY/4lE4Tw8x2ILn0WfpL9rty6al/UsN+BT1mM5OBGmfwQR3TXNGLZXFxBefVukcuU4FKLYnHBsVGeXkWSu0aqcFbry3WQCNYaFn57/XwX07BHpFu7UK2ciHsAyDxa6N0q8fnBjQAd6b3fSoWbjfUZJ1amKqkjnxCioHQXQEaihtw4l7C5G/0/iCKdrnWpREFIHVf5bcHDTN9DhwEh4UgaUD7kU3QP4rCo65Hkt7isT+HTG6m/upcptRqVCZIHScQ+lNntGXYdNYzEV0JWQoE5jIRIw+eg9JvXS5n+8tq3ZWhtluca/2aTeJkbQZdr6eYeEVbKLxMdP2YMIBBjZvmNslOTOSymayQcDr0Wh1VTCf+ZdD+lY/ytEDjG4iKSd0j+T2c+B3QqgJQcVXaUiv0PA76jPHC1rPMwRH5WQRg5T9CXgoLuhk2yVuqWSplyECYHOYlJ5ASy+Kg4xRwB4GPi5m6jcL/CiqzkV0pDTg4cCylXdEKfJBlp+u16vWjmxoiL0iEnEhCbCia0Ogx2G+NR0ToLQzd8nMG49wKvtSFVjGXH5AKgji85nT2WJDl9Dkp7hXl6h4e56eq8iNlK44wz5raRzJCMAhRzgPrsVxXsD6GLnnWh/Ny0DKsTOSDqhNOXpKR0vQbeTB1NBmP3kh8Vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199018)(5660300002)(7416002)(6486002)(41300700001)(66556008)(83380400001)(478600001)(316002)(54906003)(6916009)(66476007)(4326008)(86362001)(36756003)(8936002)(8676002)(66946007)(2906002)(2616005)(186003)(38100700002)(26005)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5jd7m6H+cAjCOc/FULoz+in+y5bMIQJS77yyw4PaMN4tELMdZNxglYXCRHJz?=
 =?us-ascii?Q?NOorg8UeE9YJ/Gsca5fXxvcY6f+NXVIHtaVnVKH+vAceBHYe7VU4lxCAfHr8?=
 =?us-ascii?Q?fgjreDb4hdYxDARUI2uNnmhJuNpSWXf8B2m1Jsc84k8euoOcDmdy8jCjlB4m?=
 =?us-ascii?Q?7mCnY6nbKVV/LAExE3MXBlzYqcQKQJAeCNOUVE9Zpd08+/3L35z3qYnGKEzZ?=
 =?us-ascii?Q?1551Xho/i5PlOMckDDuSSHcbrAGskoWt57y5wJBaasnl+MAWMEhHVLG9Mjc0?=
 =?us-ascii?Q?DxtX3E27R+YNSH3r+C43CfPbhACKTgOD4sD4swCo7SOtIvPB/FCf4Q4BNU4q?=
 =?us-ascii?Q?lDNa/qbVr8it4GRTKW6+MAoBj5CwG7PBjniuUe2py+MyywVqOs3Kcn0tRx9j?=
 =?us-ascii?Q?a7332fob2waERUHkdjpeiiTd0suRgIA8ifkvsFrYFy/qwqNAH1vyaVmAa3k0?=
 =?us-ascii?Q?FZCrb13CWDLP+KgFAQqKibbQeYo+HVcFyWEeuc5a1ChZo9xn2j3tgb85qVxo?=
 =?us-ascii?Q?oCH1wU+Dc6xSEjXajXTUeU9fgqo9rAHtj6CQ+jrUreuZLqVgkchjF49LxtEe?=
 =?us-ascii?Q?pZY6mTARmg1E2QcDZphXbRgozvjTEAcFZQPqYM0NVlT+8WxQnl0wMSHjpIM6?=
 =?us-ascii?Q?y/nF3+CJHTX3a3w3iy78Gc/omy+CFIu7xO65FVcVON/F4MxodVZg6/R21L9S?=
 =?us-ascii?Q?2fbsWPcEjGrmQG1b7YOvEIN1GraziJOvKdotw8U3C+krE0Yiwg8J9cj1OpJ+?=
 =?us-ascii?Q?OaW2UZEcYynD1lXYZ7kTeEqzHY4p7Lg8+NTBVgp+UGrbqOJb/2A9geoBoXWu?=
 =?us-ascii?Q?WDQuJJgCDY4XeucvZ0I9SZ3mWdMB+e9iGLUKDb1+omWvMbndBB4oiObUJyy9?=
 =?us-ascii?Q?qUJmpG63PpJCB7BUJaKMVGGKYAPFynlTvuz37TpA/EYel72mqIVJlofJH9yz?=
 =?us-ascii?Q?Dk6G5gRk5SoxRSUgmYcRCB+XzFOXErBtDCxiL2EzCGzu4TCswzaqh/x0pD3g?=
 =?us-ascii?Q?0695ADDBNILKiBXm2mYkMqEPPJP9DBQ6Pg3B7WaNXeiT1rxMmhc95L0I2uS6?=
 =?us-ascii?Q?gCdN3qwPPU2oZW4lVP4zk0s30UGN1iEE6OpjX1Y175/0kUxKkxThsPIo9HQD?=
 =?us-ascii?Q?nceTBY45bf0s1c4h6T+DY+9xYsnH6sZl4xt7FwHoCR18KL8VW9RpxJAGEWpg?=
 =?us-ascii?Q?NNuCmNW4DLW+uQ8xjwZZtQVfOM2vVIV1DeVp3gMBtYtiynxeN5ngWViKG+3R?=
 =?us-ascii?Q?bfV2X67ud2aOeFye6h9Iba/ozksAqWDMjb/HoZaS2wnn/KJtAoXCk041BSQ7?=
 =?us-ascii?Q?3AYklAV7HlVbOxmDkCGJ0D2iG8vHZu2nCBZPhYzsPd7VV3sa2WGLeG0Tajac?=
 =?us-ascii?Q?4+xsHeepkM7bdjaZQQhFx2Sq+0boeviZOeIz77vNJ1ZXPqlN5DC6YBKPPIiW?=
 =?us-ascii?Q?Op+loxhe+dhGvNvx5KarGF0vVs0sb6Pi419sQDuNRAyfSsvC1nPx2VZQkMek?=
 =?us-ascii?Q?n5pS64IGAKDrRhDei9IwlBNkY8GJRlEMd235SPy+LWlH/zuflDc/Okqh899T?=
 =?us-ascii?Q?rNRBr0gkOx8gt/zKssGGDx4HFjoAGnECESSK/3MI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f2ab1b-6698-4f54-8b0f-08db2976de62
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 19:11:11.8811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5SRUfzwgKmkcsjWuV3LTdwtjdJFTlSURciRLqXSJfYSQLsNk+kS1Kq7Sn5HZqgT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 20, 2023 at 11:59:05AM -0700, Jacob Pan wrote:
> Preparing to remove IOASID infrastructure, PASID management will be
> under SVA code. Decouple mm code from IOASID.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v7:
> 	- use CONFIG_IOMMU_SVA around PASID helpers in fork.c, Fixes a
> 	compile problem.
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
>  kernel/fork.c             |  5 +++++
>  5 files changed, 28 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 24bf9b2b58aa..fcfdc80a3939 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -44,7 +44,7 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>  	if (!pasid_valid(pasid))
>  		ret = -ENOMEM;
>  	else
> -		mm_pasid_set(mm, pasid);
> +		mm->pasid = pasid;
>  out:
>  	mutex_unlock(&iommu_sva_lock);
>  	return ret;
> @@ -238,3 +238,11 @@ iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
>  
>  	return status;
>  }
> +
> +void mm_pasid_drop(struct mm_struct *mm)
> +{
> +	if (pasid_valid(mm->pasid)) {
> +		ioasid_free(mm->pasid);
> +		mm->pasid = INVALID_IOASID;
> +	}
> +}
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index af1c9d62e642..bdee937da907 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -4,8 +4,8 @@
>  
>  #include <linux/types.h>
>  #include <linux/errno.h>
> +#include <linux/iommu.h>
>  
> -#define INVALID_IOASID ((ioasid_t)-1)
>  typedef unsigned int ioasid_t;
>  typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max, void *data);
>  typedef void (*ioasid_free_fn_t)(ioasid_t ioasid, void *data);
> @@ -40,10 +40,6 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>  int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>  int ioasid_set_data(ioasid_t ioasid, void *data);
> -static inline bool pasid_valid(ioasid_t ioasid)
> -{
> -	return ioasid != INVALID_IOASID;
> -}
>  
>  #else /* !CONFIG_IOASID */
>  static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 6595454d4f48..d3f81dc6e4dd 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -13,7 +13,6 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> -#include <linux/ioasid.h>
>  #include <uapi/linux/iommu.h>
>  
>  #define IOMMU_READ	(1 << 0)
> @@ -192,6 +191,8 @@ enum iommu_dev_features {
>  };
>  
>  #define IOMMU_PASID_INVALID	(-1U)
> +typedef unsigned int ioasid_t;
> +#define INVALID_IOASID ((ioasid_t)-1)
>  
>  #ifdef CONFIG_IOMMU_API
>  
> @@ -1172,7 +1173,16 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
>  	return false;
>  }
>  
> +static inline bool pasid_valid(ioasid_t ioasid)
> +{
> +	return ioasid != INVALID_IOASID;
> +}
>  #ifdef CONFIG_IOMMU_SVA
> +static inline void mm_pasid_init(struct mm_struct *mm)
> +{
> +	mm->pasid = INVALID_IOASID;
> +}
> +void mm_pasid_drop(struct mm_struct *mm);
>  struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>  					struct mm_struct *mm);
>  void iommu_sva_unbind_device(struct iommu_sva *handle);
> @@ -1192,6 +1202,8 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>  {
>  	return IOMMU_PASID_INVALID;
>  }
> +static inline void mm_pasid_init(struct mm_struct *mm) {}
> +static inline void mm_pasid_drop(struct mm_struct *mm) {}
>  #endif /* CONFIG_IOMMU_SVA */
>  
>  #endif /* __LINUX_IOMMU_H */
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 2a243616f222..da9712a3ba73 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -8,7 +8,6 @@
>  #include <linux/mm_types.h>
>  #include <linux/gfp.h>
>  #include <linux/sync_core.h>
> -#include <linux/ioasid.h>
>  
>  /*
>   * Routines for handling mm_structs
> @@ -451,29 +450,4 @@ static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
>  }
>  #endif
>  
> -#ifdef CONFIG_IOMMU_SVA
> -static inline void mm_pasid_init(struct mm_struct *mm)
> -{
> -	mm->pasid = INVALID_IOASID;
> -}
> -
> -/* Associate a PASID with an mm_struct: */
> -static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid)
> -{
> -	mm->pasid = pasid;
> -}
> -
> -static inline void mm_pasid_drop(struct mm_struct *mm)
> -{
> -	if (pasid_valid(mm->pasid)) {
> -		ioasid_free(mm->pasid);
> -		mm->pasid = INVALID_IOASID;
> -	}
> -}
> -#else
> -static inline void mm_pasid_init(struct mm_struct *mm) {}
> -static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid) {}
> -static inline void mm_pasid_drop(struct mm_struct *mm) {}
> -#endif


> @@ -794,7 +795,9 @@ void __mmdrop(struct mm_struct *mm)
>  	mmu_notifier_subscriptions_destroy(mm);
>  	check_mm(mm);
>  	put_user_ns(mm->user_ns);
> +#ifdef CONFIG_IOMMU_SVA	
>  	mm_pasid_drop(mm);
> +#endif
>  
>  	for (i = 0; i < NR_MM_COUNTERS; i++)
>  		percpu_counter_destroy(&mm->rss_stat[i]);
> @@ -1140,7 +1143,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	mm_init_cpumask(mm);
>  	mm_init_aio(mm);
>  	mm_init_owner(mm, p);
> +#ifdef CONFIG_IOMMU_SVA	
>  	mm_pasid_init(mm);
> +#endif

No ifdef here, you correctly made static inline dummy functions above.

Jason
