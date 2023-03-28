Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E6A6CC7BF
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 18:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjC1QTX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 12:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjC1QTT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 12:19:19 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965F710241;
        Tue, 28 Mar 2023 09:19:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdnP2y1lc6oCyj/91Qzwb3dSXTOOnV5UxDILTumyldkVgcqwiHufFDXu0IvhNnOfeswfys5OX5SPohIG7nIaqp4OtcQB9pyD2lhPP/g7gU3blz/CNbAZFyPsXeltLw8Kde7cQxU9QMMXMlIYcLdwMx1QS0CRJTXp8ZlUYkSgxu1249nZEnmUO19OyRjCVy8kAdeM4rGeQXrnmXB79PhSyesxEgEz95QTQ8ag+9/sUK8AxEpyYxdvvpBZm1mjoaMwNgANs5aghc8IHb0fpOsSDEDWerF7jStEyeIcW0Z0GiOjXOtjM+wvCKjlCjt5+hk2hfW9jme5XDGEmf4CQIcQBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//38Z9gw6I263jS+fzakIhfANt9YEcn5GVjlfJ2/nB8=;
 b=dCt/0RpWgvHp5BQvuKPpA9tNtBeQ+cbJjoeDL+qExmV7iiHOoOh5tV2NWKzxC1DeqTGEqly19tf6zO/WXF1NxxQdN98GuMgDTHEKwcz0pgVaNhTsgqtdsQc1pUW9Rq7vGGYfe9uBanVAAs6U3WMeQbT2bHDXEz0HFeUCKQD2zT3zfIHmPGbiLDJpyEY6wpsb3wyKIgAvuYQBuyxyq9YCoWMMiu43TI8VquEzxEk9C8oRWC7/Kv/Qt+KXuQ1KtilLKaLjlS9YhWOHnW9zfn8CzuGSgl+n0jSapAiwSFhbs5P2upV57M5ZfxHeGnxVO3RkziuM4KsE4TT2LFf1RWRZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//38Z9gw6I263jS+fzakIhfANt9YEcn5GVjlfJ2/nB8=;
 b=fyi1WY2xug+FS+ZoF+/R1iYAsz3EvePUsmEvAac+B3nqmWW9qCeS5TB1UhvwQg0gFmnx3VsBUhV355fD/il9QJcWQr/3Gm5S8Pan4WaEfc1k7kgWihqeatuJCPj8GlqSmBirsXew5pe3JPKBaHWdjTZqHL17yyzQYzXFydSRysUmpoa7IX6yMbDLL2qXfr8doVFxat74f4OJCJpLOMLAI5jMPDreyKjnENWgtgrcYTV2O6BJ0Qbqp1PddOVKlGaYAx+RlHBPzcexuZm5ex7hiGVDVnIxmpnOa+mfMFraGCBe3tzaJ+alQMHSh2cr+1GlfcFrcmU+o6HqYQS3wmlR0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB8289.namprd12.prod.outlook.com (2603:10b6:8:d8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.41; Tue, 28 Mar 2023 16:19:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 28 Mar 2023
 16:19:14 +0000
Date:   Tue, 28 Mar 2023 13:19:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v2 7/8] iommu: Export iommu_get_dma_domain
Message-ID: <ZCMTf5RwebmELsoT@nvidia.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-8-jacob.jun.pan@linux.intel.com>
 <e7d53d04-6b7f-05a4-3077-42470c6d2823@linux.intel.com>
 <BN9PR11MB527623AC2CE25EDA10FF81548C889@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20230328084822.4b46e649@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328084822.4b46e649@jacob-builder>
X-ClientProxiedBy: BYAPR21CA0020.namprd21.prod.outlook.com
 (2603:10b6:a03:114::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: 41227b94-e5d4-4b9d-fae1-08db2fa82bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVPSAqgj2yUKyQdPvs1CskrK71rQ8N6S3IA7wBaDCMxetFZH3iAsNYexBQ6ppQtmI76iS4DE7XiCd0dtzTsxeFbry2bN+PNSDh84aV+gtOr2cobXwXtgt0ZF4KlnqFD8T70giE/dkkyCkLr7brjeFHraCChJmP75V1pwcU9P7W89zjtLypefP4F03ceZKLxdhy09gbVA812K6yooFUUEf5B8H1pFgeKXJD9/GAdoN3UQ4wiW4Qc6NHE7mW59TO3WT9kA0QNtgBuJs/KGI55XUZeyc7mM1qmA5xhA9mQlmQxoVbNhy538fFq89L7h2oE4KbfDT9hfzxNnPhqMnX82FrlNk9dit9zGo/PjAJ/nRX23gAMwTYv/wU+lknfa0O+7pZC9jd3DCg1mMbGwWdcT3kzdEZ/DJMntrVHrk8/n7oGPRKvgG7uRDUWTtAJZ6jJQMFshk2bXFPJLA7sbIcEhbJBRnDo4TBOolVdDk8pc3yMG+LNQswnfmixA8dj4cJAtcyvgwtioS8UoWss5191W8TuTQXDfOTTj5VzgIgRG88R/KwZAuHgaApQwApDARsgn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199021)(86362001)(36756003)(2906002)(26005)(6916009)(6666004)(2616005)(83380400001)(6486002)(478600001)(66476007)(4326008)(316002)(6512007)(66556008)(8676002)(66946007)(7416002)(186003)(8936002)(54906003)(6506007)(4744005)(5660300002)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y6xMrueGo1P4YOAw9OdkFX905+rV3U3p8NY2/5dC/PXWlSbOg/Dr2Ftq+PjW?=
 =?us-ascii?Q?wGKHgjmxiA2JwJPnyP76wwLVKkPETUUsrwvX4sRZekCNcmpaxbfBI1SVQNir?=
 =?us-ascii?Q?y8Sq1z1VZCOUC8qJmBS4OQ1R1nOsC4ESniIWTmXQAZA5VXQJpA3bBY48I2SS?=
 =?us-ascii?Q?Oe+nTfNE2GvCpl7IRPnkJfM9fhyv25gMqK26uUDYV3tN5pY6jMIxOhxxcizs?=
 =?us-ascii?Q?Li1/VskhFLLPwta0k/atKqk04rH9nsTeF7boyXMqZ65ot/8Fr0aug0Y+dnMc?=
 =?us-ascii?Q?e/jIHub3CIN28Cu+5O043u1elvZ3ooushFf2GxBvK6IM8ajS+zQG5OczXd1+?=
 =?us-ascii?Q?YFH3/VZh80mtF4TPbZiesBU7T9Sr664x5Cwq+Ww/74ZI3INq3afPzgEnNSNt?=
 =?us-ascii?Q?O5M0tuggvmB8sIzl0MzfiP7vywpUKLrMz6b+V6aW6eqSEXAqlfoXCYvcm7DR?=
 =?us-ascii?Q?SBraNBS8J/DxuWuj3jkx4PaioZIxQGh6lyEDdTPzlGnBUrWLGY0L85FlsplD?=
 =?us-ascii?Q?p07QFlPQHWHlfY3SHHRB1nL7TUpxofsj+uxT6jZOs1BnkOMeGqNwxP1N8jAT?=
 =?us-ascii?Q?w2KOI93y+jXQTdF6KExJNsXSBlFBrW2EXP6MMkoHCXDy8N5VjCiBIrP5XtM1?=
 =?us-ascii?Q?DsVoPuh6GAp5syNYkdLvOcz5UUGh5yGJsh2ahJ3b3vopV/G3KT2QQ59lutSq?=
 =?us-ascii?Q?+DXqU8jStWgFlzHuku1ZpnvuUVf1ogNb+l6jZ7T8uimDPrzuV349KlOQcRVW?=
 =?us-ascii?Q?vvdYW6Tzz542wzkPRk+ZWTDglJr6cu/piBTpoljiJ8A6gr9O8hKHUoqKFKxR?=
 =?us-ascii?Q?oMbVJ7zpb/fr0yGChD1cYdg/vbRSctQoj5Jhb50gZ2DIiV8taKXorXebMH7P?=
 =?us-ascii?Q?OBI+2X21MjV3pQopZUN1kLZ024/sJc4AdkTfnz+ybDqMUCrYjb+zJuPwmDOs?=
 =?us-ascii?Q?A4smCz9yo38STMBiI3wdATeHcCzXEUnt+Mf9pskJkb3Jpo0Ro8FjDVeFIuqi?=
 =?us-ascii?Q?Eh4+esREbqEfW76N7VW7ljoWMJMlud+tat7QsBf78K5PKImvfi41RQfeYnBi?=
 =?us-ascii?Q?dOSyeSLrz3Q3MWb66AR5w3TJRy9GDXL4OS26+9hoJfy0eJ1bLZlsJ1X3at1V?=
 =?us-ascii?Q?Z8rOA0jcU+NOoARag9RRwu68gA3iNumH+CNqWVTaShoLIWCjj78lHEPyQJYt?=
 =?us-ascii?Q?3XMwtkJXKzX/KCO+n1Nm4w5TdTboGIBZ5XL11dgMqmwORralRUCrizGH1l7U?=
 =?us-ascii?Q?x3Qk9j1CXVnT4bhx8vLKVZk3nfWLEqQgTUz5pwKCo99YobewQKm3kGzl2lLz?=
 =?us-ascii?Q?wHPWl/YjnuJrbq39ylMob+fD+fJX6k0y640i/c6zipkp+78LBRbNrgRWdtaU?=
 =?us-ascii?Q?PBcNSRbvke7lW2SqyLVm6x3OWhxdr/bF/9O0pt3rYQ3h6HL0fWOv1B18zuQS?=
 =?us-ascii?Q?tHKUkeXbcw4QQRl7NzinvQV+r4dCRWArJQ4vEUbYQOLXfPPZ9UpLUnc2tfQ0?=
 =?us-ascii?Q?QMv5rF7u7UIWAaOhpsBx50y8up2UYSO4VlyWoOckTDffmUvjFq5khxlecQuP?=
 =?us-ascii?Q?3x9ZpRgd7FhBNkIHv7MfdayvR/wzSLGcdmyRpYer?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41227b94-e5d4-4b9d-fae1-08db2fa82bc9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 16:19:14.0600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32O/DbFoVENXqefh5t4bi5eW4130IPaZV57AEs9ZbZnhFDn6cDo23yyzGPAPzRAI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8289
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 28, 2023 at 08:48:22AM -0700, Jacob Pan wrote:

> > Agree. The kernel driver managing the device wants to get the current 
> > domain of the device then iommu_get_domain_for_dev() is the right
> > interface. It knows the domain is the dma domain.
> This goes back to v1 then :)
> 
> I thought the comments from v1 is that we don't want to check the domain
> type is DMA domain returned by iommu_get_domain_for_dev()
> 
> If the driver "knows" the domain is dma domain, why can't it use
> iommu_get_dma_domain()? seems paradoxical.

Huh?

The DMA API operates on the current domain of the device, be it
IDENTITY or UNMANAGED.

You have to copy whatever the current domain is to the PASID and you
should definately not check if it is DMA or something.

Jason
