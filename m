Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133CF6ABFFF
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 13:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjCFM6D (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 07:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCFM6C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 07:58:02 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018E7E382;
        Mon,  6 Mar 2023 04:58:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mR+y70KpRfI0ZmHVN/EfeGIFNQBlYcdqVuH0l7A5KHs4qMGSOVaf9YjIzkCltkn+mNwm0n4TkeSV8i3caci3gyg4n4WT1pA1lR0nBRU05jTk+Dc2KQ9WEEhLtGWDBPptrsjyqMZQNiIag5QGumh4UJhC1g8rIbtcHKt7eeebNTrlAnrvMz5OFNWKm0oYwkbd+Xy9dKbVfss1dUrldArvEplvlx+6c38ZRhm0c7gy8ZJHyueVLQC/3SAy7C2S15EPxgevXWkLvkm2y60FelJo3/Jj6gqbib4M5oa/B+7eAyRJQwfqhRHm70+EWPcepNElrLIEtCFTr0GaDGUo8nuOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huDpbx4E+/tgqrZpvEIuMxmbmNH2Sok7QIDfRX4i/I8=;
 b=Oag59sYX5lf7dBNw0Iq2KwklsY8zjc/eOT6AfIvmhpdxzrZ7QqYtVtsVo/kdT68O4wboOc9IDIerWsqjLZJohVuSgMepGO7BVsmw4a8LGolI2pzdDTMOjWziHJ/kDM3Y1PFWzyUCxg6h1CwFGnhJwQz1X37gsYWGbyNsXqICBeld8dOrL1dgXGC7py7KGMzkUUFjTE2/1oEetUIf7V5fzyfsGS+cjddflD9OcfGdT06xex75SW0EDIVLhfXCau/yvE6HGZcErOv+VeudEi4tQO4OhxU2xhw7/xa8O6HNIu4w0cWlAuirmishFS85xM3l+fJ1Id32gdL2UBlQ7AoOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huDpbx4E+/tgqrZpvEIuMxmbmNH2Sok7QIDfRX4i/I8=;
 b=Z+o+St1HXsYWqv65b1AfMePdLN0wqvAlq4V89L+kCju1zFGBrYJnAEChHQM8/QtviDtGN0A4OUbf6Wog0uZTXmR60nmx5yGMsdJu57ByTAnJaY5uf4SKOJO43y9HtUXOrCQuoPcLdoZqQckzKdUVlraXDY3UMKGt94Pmbl0QIFat/qXCIse6If9oQrZ6fLdJYBV3+vFgWRf+Rb8SsRd4hH3QyD9isn56SMms7MkINcKnFjp2k23/CHN0+JqB62PXdAtpUZWg5D8/KC1KzPMHkzvpQ9Z1UYdb9B1zZ7Hv1t7SaZaSffXrp/rOmSUAsNmFj+DWZzAVGYX2olubqt8jpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 12:57:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 12:57:58 +0000
Date:   Mon, 6 Mar 2023 08:57:57 -0400
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
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for
 default domain
Message-ID: <ZAXjVaucrkEvrfsw@nvidia.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: MN2PR20CA0054.namprd20.prod.outlook.com
 (2603:10b6:208:235::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 39244f84-205f-44e5-f5e1-08db1e426909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k4lhm/coqU/zTgClen/Qou/R4gx96kYejAqxemGwcCU2dQgMCqQTq8EbSu1MgBOxu60AisFw1YpHdUe4oYO0mh6zg/3Bwe++s0g2nfhHSWnFGa3SpPqrEi8uyC4xt+mQhrmbhCEYokF7negPhsVYgCgvo8Bq10Vx6EsTlMSW70NtdG4ViUTAYJ9vZt8dLf1SAAaGJB/Q++ppzUKvil5Hfe5TqXiWYPPLKkvhFyAWScMQnPf4fK9FAnskQFHhuVvULnkwSV6PpQwa/pCr+mOX7fhP/ZrIHUONGUDZLVM3mcdoPEjN3LlVT+Hx0kxIOhVr0iTPL7oMRbRVUEImwfa0l8XqGN09ZtoS4WdMqkaVSvyD3rJ2VOkCEWQ4yIJhbFfWz1UOvU4BSnQUAY/eE7MZZxCkvWHWrdBamGYKKoCwKwKq8RfuSsD/+rZrDcT0fump37kAq7wghYCKGeaGUV3P0BsrcLX427FpQGlBRC+dpgDpI3Q060Luo+uv68B91Z8aXEtRKhBzZjA3osFfqRl4sy9gxNPFoK8d/uKAoem6sc9IJ7AnZtsyASrkvHWllcL4vVdy7PwlDHrxsKkRj/nA2ZJwS/DwRuOsbrxYBRMGWMprOEQimadhyyPP1B1PeBgAetKLygWIsg032lMjvG+BLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199018)(8936002)(7416002)(5660300002)(41300700001)(66946007)(66556008)(66476007)(2906002)(6916009)(8676002)(4326008)(66899018)(54906003)(316002)(478600001)(36756003)(6506007)(26005)(6512007)(6486002)(2616005)(86362001)(83380400001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V01XQkF3OGpsYVFOMHNLbXU4T2daZHplSGJkUkVwNHBCbGdSblpSdHkvTVVU?=
 =?utf-8?B?QkpITk83ZnhpV0NvYUhpQ2l3NkZLUndFTlN6cWs2YSt3cXc4MkpuVVd4dVln?=
 =?utf-8?B?MzFpTC9FeWVxUmJ0T2lBSXgyYU9HZWxsR1ZRejlXcXcyM21WLytNL2YvVFEr?=
 =?utf-8?B?OGdQWFRVTlNQcXBVaitWUTdoY1VPdUFYTkhNZlZrVnZBSFdMU1RiM0VObVZp?=
 =?utf-8?B?N0Z2WnBObE9PMzFmV3QvSmRYM3JCT25rM2ZqUjlKdndGWllSNVc1ejYyTnVO?=
 =?utf-8?B?NWxTVUNINHRZVlpqajUxOVlUQitQOXgxNVF4ZzloTFZiMnkvNXhDZ25OVzNm?=
 =?utf-8?B?b0RRVjlscVVYS0xQK2ZQUTdvNkJQeS9TUGp1MHFiSmxhTkZZWmU5eDJyWnhs?=
 =?utf-8?B?cEd3akJJcTdTTXhZL2wyV0lxZ2tvbk9wK3FYV3ZTa0VXb3hERjBYMTFRaTFI?=
 =?utf-8?B?dE5GZGN0S3gvbUJmVnkzSXowYkxkbHFYTlJSN1dITHpCai9mUzcvdXBRY0dQ?=
 =?utf-8?B?ZWs1cE5JMTZielNCWXBTeWdFL25iNVd6RU40ZXIwYjdKZnFDek1MbjRrV2dY?=
 =?utf-8?B?Y0dsaFB0Q0RHelRMWlI0RjNES1Nnb0R5WnFtejBtVVlUZkVNSEdUV1orbTE2?=
 =?utf-8?B?d1NuQXlEbWpydDBEQmRaaUpQQlV4M3Y2U3ZqVUxHSEVONVZQd2dvZXM4SlpH?=
 =?utf-8?B?RGU1WERvNWhvOGIwRnVrVzhCa2lSdXhWaDU2UElJOFFmZmI0NVQ0RHdWcTA2?=
 =?utf-8?B?Q2RoL2VqcGtObE5EUnVmODlCZFJyMkYwcWJDaHloNFdJb1NnTFZMRzNic1h2?=
 =?utf-8?B?dmp1L09yWkRVN2xPaXQ5RTVHdVRHQzVwTnVYUmZGVk1adjNTRDhFVDRqdUk1?=
 =?utf-8?B?NGtWL0lVc2tta1dDaHpVTk1ERUV0OTVCYXNWOGlzZGRCVFBydVRUZWF4a1la?=
 =?utf-8?B?MHV2N0JrL0ZwR2ZzRVlJc3daVXZ0VEZScmFoMFM0ZExVazRlSS80WWlqanU0?=
 =?utf-8?B?NUhtY0pSc0I2eVNMOHFoZGNMMy9VTmQyb0ZtRENjUkR4N2QrUDFkQldzOFAx?=
 =?utf-8?B?UDZqUnRwdlA0cTZIaVpIQjdaUkJtZUhDNDRCWDhHUkdiNXQraTJvTklTaGQ4?=
 =?utf-8?B?YU9yaC83TUJvTi9mSEFjVDhGdTJTblBjanFmcExJRHlIRVU5SFlRNkg2eXBz?=
 =?utf-8?B?YnNmVndrWE1rK0VzcGhnNkhZUyt3dkhVdDBzS2l5VFE4MER1WENESFU3QVBm?=
 =?utf-8?B?UnBVdktaeWNRMHRBWVhQVjQxRllaVVhlSDZaaGQ3Y1dNOWx3S2dEZ1B3ZWhi?=
 =?utf-8?B?VVFsVjNGYmFPOGI4NEpPSnl1YTZuVWdzNnVXYzdUcEt3aFFXMXpKb1A3NjFy?=
 =?utf-8?B?M2laNkUvWmhSTmV4Z2pLREhhUTBzd0pYdzVCczRXczVCaXJYOFJINXBQdTgr?=
 =?utf-8?B?Y3lBOTFiR0F0VzgwK2RDZUdBQUFSNXI4ZEZub2V1eU11eHVJbmNBekNiQkVo?=
 =?utf-8?B?WGoyL25NYkFMK2hUVVhLeVFPcUR3SFNEU3B1aDRTbDlSUVdPSjNnRGdqaFV5?=
 =?utf-8?B?dVJqamw4TTNrcFl5YnNyZ0VvVXhGMW94OTZQLzMyZjFVbWd4YTNNeTRuQ3U1?=
 =?utf-8?B?dGlLUEc5YXJRbC9ZN2dxZlhVRi9SSkVHMUEyOHBuQXJISk9MRWt2NmtkRTJF?=
 =?utf-8?B?VmFFVUFoNHcvTCtUbEwyU0d2VVQ2cmUxNFVxL1NBOUk3S01sRnluYlAyb3BL?=
 =?utf-8?B?dmtBUm5xN0NydzdHSWJKUHphTFVWeXdFalZOa0ZocWpXdVA0Y2dGQi9SRG1I?=
 =?utf-8?B?a0kvZ1NSSHZNaGREajJJdHR5Yjc5Z2tDL1BvYlVyZ3FSYnUvTzB3dVFoNmRy?=
 =?utf-8?B?MlQxeThLQkxHZGtLOUlmTUNLVXRhMGY1RTdmeW5yV29JNUp1N1FSbmxETEZ6?=
 =?utf-8?B?c2hzU0xCdlBVSkhJQlRMSmZwQWcyYmJaa1hSZDJ4b2phMHQwZXJ1NUtaZzd1?=
 =?utf-8?B?TXBKMm0wUmt4RVlLUjRJMnpvdElvRndUbnkzOFp6RlVhOGRBenBPT3haQlNU?=
 =?utf-8?B?SHZ5TWlDcDUvNjE3QnUrdmJhZW9teUtHeHFGZzBJOEp5dHhMaHMvWW8yanMx?=
 =?utf-8?Q?mD5DM45eoQHMsbC7rbPPHCVXy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39244f84-205f-44e5-f5e1-08db1e426909
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 12:57:58.3554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2cj/KFTx0OGo8JZzKWEMkdTTNG3xDpxC2k2zvCJyAbiS7ZLtHjdibijRTTe+5cV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 01, 2023 at 04:59:56PM -0800, Jacob Pan wrote:
> On VT-d platforms, legacy DMA requests without PASID use device’s
> default domain, where RID_PASID is always attached. Device drivers
> can then use the DMA API for all in-kernel DMA on the RID.
> 
> Ideally, devices capable of using ENQCMDS can also transparently use the
> default domain, consequently DMA API. However, VT-d architecture
> dictates that the PASID used by ENQCMDS must be different from the
> RID_PASID value.
> 
> To provide support for transparent use of DMA API with non-RID_PASID
> value, this patch implements the set_dev_pasid() function for the
> default domain. The idea is that device drivers wishing to use ENQCMDS
> to submit work on buffers mapped by DMA API will call
> iommu_attach_device_pasid() beforehand.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 10f657828d3a..a0cb3bc851ac 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4665,6 +4665,10 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>  		case IOMMU_DOMAIN_SVA:
>  			intel_svm_remove_dev_pasid(dev, pasid);
>  			break;
> +		case IOMMU_DOMAIN_DMA:
> +		case IOMMU_DOMAIN_DMA_FQ:
> +		case IOMMU_DOMAIN_IDENTITY:

Why do we need this switch statement anyhow? Something seems to have
gone wrong here.. SVM shouldn't be special, and why does this call
intel_pasid_tear_down_entry() twice on the SVA path?

It seems like all this is doing is flushing the PRI queue.

A domain should have a dedicated flag unrelated to the type if it is
using PRI and all PRI using domains should have the PRI queue flushed
here, using the same code as flushing the PRI for a RID attachment.

Jason
