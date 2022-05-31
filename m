Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9015396BA
	for <lists+dmaengine@lfdr.de>; Tue, 31 May 2022 21:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbiEaTFz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 May 2022 15:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiEaTFy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 May 2022 15:05:54 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4737B6D85B;
        Tue, 31 May 2022 12:05:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5+lK8Iifkz7m/GnNlQ328SLhBon79k6iybGvMSFX6guK65PenhiGa4N/39V9nbn3UGCIcwCMrxaYoK4TiDsApRmtbLsHh4fEcgv5b+/m0unfHidTWKmiBho/23XtDV2zv4a0Q0JPOg/2h91NdI4SaoSIOzSQ14AXDy+Hny2J9cf8hYSatisDmIvpQVcPAktUx0Yjn1+d39tqVVQyRrNvUGO0HQKntSxz/TdRkRTTv0KtgxYEhOTLnKHTnJdFcp8h6rxfJfM1+cqMnI0XTApKdjaaiSON4UGZCv2HGKtwM1aZ4xWuK+w2vhFQuToTuQ4lwz1lyEKIBV5W086w6k8ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cgjj1+Psv56IlxBf1IX8HBDI7NnMz02Pb3TeAtoaFNw=;
 b=P0Ievcf7crlNeyfaqOMvWX8LqZ4WPZm+EFmcxj+5thP9rDg3T+ZM/tMBGZbCphZv4VLWx83BeVsohbBAxZtr8jep9Kegb+25BsFYUnlbrIXClxZKIegYQn0OUny45MqyoPI+wqCsMcyzoSJAHys0CZCodOvi958INUd2E6V9jyTk2GbyXJ4cmUaMRmdY+z9RYJB6tbi8Jmf7Vie0setLuno8Ty3RfkcKl0qqDSmTskEbmPG/4RU8kJIscfvbQTXhhBAlQgkmvyVwuvI6jVxI9T2DQSjVOH9UlPlHdUvHLHjZO0b3LRcHsqdsKT8QdgJItOd79BYEdmVOGOc91Ap2pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cgjj1+Psv56IlxBf1IX8HBDI7NnMz02Pb3TeAtoaFNw=;
 b=fB5LoMmVGDS3eHLHcMPZfRI02kcGHPPhumjEHMBVynT/hYdQWdqxael9oxWfs/Ghj0sASmlZHd8+u9ACtN1eDL6Q5RaeAuX7tAYYEg3PtuRD9PUr9XJQiianzW/T0pzpCNHnoiX/PkfQT01zXwqmQkH7DC6PKhOm5Sm014E5zO5/BCjYYAU6EAfQCBvGmcNC/DQ1GXZ3baxiWy+PHaYkjfNiASRNHPCmDIlCqmeWQWYBzzfWxYnAxVjRrJagrFekOhbpthQMF972Gk80GhHGxK0bBCjsHJWtP8pBjK2UL5iGzGQi4A4SIL7Hgth2nTRUb9Ky7OCwp6y9c/bSbUTISA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1582.namprd12.prod.outlook.com (2603:10b6:301:10::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Tue, 31 May
 2022 19:05:51 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%9]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 19:05:51 +0000
Date:   Tue, 31 May 2022 16:05:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Christoph Hellwig <hch@infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Message-ID: <20220531190550.GK1343366@nvidia.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
 <20220524135034.GU1343366@nvidia.com>
 <20220524081727.19c2dd6d@jacob-builder>
 <20220530122247.GY1343366@nvidia.com>
 <BN9PR11MB52768105FC4FB959298F8A188CDC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <628aa885-dd12-8bcd-bfc6-446345bf69ed@linux.intel.com>
 <20220531102955.6618b540@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531102955.6618b540@jacob-builder>
X-ClientProxiedBy: BL1PR13CA0419.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::34) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef5d9e1d-19dc-42b1-ad9c-08da4338947f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1582:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1582102352F9F069221B4D7AC2DC9@MWHPR12MB1582.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMwSkXqHwcBWZhGwZDmXwQMhp98Hnw0XIAEJOxRdPaeI4SL5akq3xuhAMva/jKxG1gCZnOFx4I9Fs3fFTcfe1JuzSgzTi7dMuvY09Bmi27QlXrxN4A5i2Gb+iDZBdAjYIIkZBCsgAy1D96R/Rn5DZ8zQE+VDF1bPliI9a1gcpBJ+w8eCecuNBY/YW1pazJFx4LG6zR99+/gyjuBm3ZoVN/cYpH/niIf870+7jQZPj0KDcDddxq3lgHvhhFtymCER4twE2zKfWxxEv1QGCqoVdPv3IwqeIh4wN7eY/yREXOkZPWlRyd9UvTCEu/5TIehIYSOMtqBQZh714UaetCUgJxYcXhXZu0IcrDcdCkmK6dOZbV5B4oOar+5gRSozVWdpqs0PNNLFgW4LJge3r3q1yTuAwmuajd9ZstyOt2+tI37XDFgYzaS85MBTuowaCJ/4QFoADuF/zmGeP6naDB7TEL+YOADbpthx0L5PYXfniF6ddvi8rr+Z6/URtuJi33+5gy6z7RvGTpSzSsIQp+WUw2MmAuvx/3b5wec2FxqOVZNFbm40TtEQ/t12DCQBf+vCko4brrGY58Nip7iQZxfEoWd7bCEJzi65XKET0iTfwMegnWp2yD55YH7ybputlhgX6EWpPekdsHEgH/dGJX0H+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(316002)(7416002)(86362001)(6916009)(5660300002)(4744005)(2906002)(54906003)(4326008)(8676002)(66946007)(66556008)(66476007)(38100700002)(1076003)(2616005)(186003)(8936002)(508600001)(6486002)(36756003)(6506007)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d6LRLyGvc99mcOwnFvYbdvm2AiJCcvwIohk2pTz1QGO59jQMS+wLX4kYISQ+?=
 =?us-ascii?Q?CEByxZzqapyL4eiHlcdJ3Ew+enjhLJGx2p0ETUDDqUv1N7ZNft+LadWdNM2H?=
 =?us-ascii?Q?pez9HftvibFyH3/6hbXWSW9mTcCnINUia3CMNRlUmR3Kz9dQJ7JCv83NjFSL?=
 =?us-ascii?Q?H7B6fL/kKudKP2dzDRG6c4sEDEBVjPu+fhwcEe1PEEfHrwc3PrS/8ww8L+OQ?=
 =?us-ascii?Q?sgf5ocIEDx9v5Txy7DbPtjMHOZC2sIysTZDhDJA9COcQRWgNTkOqJw2PH0wZ?=
 =?us-ascii?Q?/a0m6OzN6DaDY8yXied7EnXElPEH3HK6t9f1ceJ0TeHA7ZdrS51sATF7uR6X?=
 =?us-ascii?Q?pyyStENFdFo7pyGZL2+cqZvnI2R5UgYliolOAd0rfCYOgK1iiTgW/08Xlr1I?=
 =?us-ascii?Q?45lg7kqI97e+iTd87lD2e5JZP1pkdDg1Xg71/RuHjbDvmf4L4QZyikUGBa6F?=
 =?us-ascii?Q?nGL4T2ku0QnVQao4wS29QGsm0iCvM50S1WJhu4w9Gbo04Y9JaTknQ94sURCQ?=
 =?us-ascii?Q?eUF1pxKTK6GISZ7is/aMfnJiNqI180EooCwZaAJFwVr68ENkCNav/blNc9a9?=
 =?us-ascii?Q?GbpwVTbOMmIqDMaTIu0o8wCAKEaOlkZsCf8Ot3NRxLyzOY4a5qh5Dh1MKzlw?=
 =?us-ascii?Q?GeNs3h4rt6ePDvfkDxGFY9YLn9FMHRr+aUnRE73zXnYwcRzt4CJKoF/AabFc?=
 =?us-ascii?Q?ghqaqAoG2CX3ECQgATQcXEFRy8ZhM93gLFZxWw0KzYtnPElkkKyZrZeLHPmV?=
 =?us-ascii?Q?+9iI0dergnsS2kgHsTyxUtui2xgZHmQpkT8J6p6gdVaZMqdo5gVnwSnaRmnl?=
 =?us-ascii?Q?V+Q9DLutb+u4O6hKC5TPhFO+iAVTHPm3HGFXDSfCVl0/ouA3SJz22ivgyChi?=
 =?us-ascii?Q?PHqiUE590dgbVGAMAtY9/75+NjDmxOSVwZkQpC256lfKfmBYTB0nPv0wfw7o?=
 =?us-ascii?Q?iUDlMWLZjRZz47rUC1TsfXheja5Ri7LwMoGs7zOeFanyNGGYRPs1b9LMkgut?=
 =?us-ascii?Q?QVulxHFC6ew9HMZg30SepTFpmQ43VS+V5bCwtTCaAcvuveaJB5XVYkn9jza6?=
 =?us-ascii?Q?7ucTtVpn8lAMBy9z1nSQUvR/zBe00CnSa8Sxw2/ePt7M0li0CBVpoXayYqgx?=
 =?us-ascii?Q?uQkHX/Ps36SaH4xlNdMfHnMd+g1oPgAgV3+gRVes4mcgJJLbZhvQnfBP11B5?=
 =?us-ascii?Q?kRp9TZB4bkXq2GXK8evuMEmit+hFW04qh3qH5GmNSFuYfwd37iEC6hXilaUZ?=
 =?us-ascii?Q?KbhrMDLNL29AJKwe0T3cBqqnEcaOxVtohFq/2nykz9jKk8BaB8yrTS6okumS?=
 =?us-ascii?Q?+mognbHS5yAAUntms8BIxbZoEnDYg9Ir1/ZIieLpabPTC1k6Y0G+2ETXShCG?=
 =?us-ascii?Q?q+Ia4rS60jByzvtSYp8So95c+6J0O6xOEz+4Igwg4/cMHSB7WnXBW7WZPPm9?=
 =?us-ascii?Q?sntRvWT0GsUrkZOoKkel8ZNBrgJztn6d84YdpWkFBrsSzIgh4MT1M5ArcWiN?=
 =?us-ascii?Q?9x6Ql1TXLV3AXxFf21FfXASDuWtc1+EsiGKGD8j4Y6b7PfDu9ThIwnmh3tjx?=
 =?us-ascii?Q?bSVyHhW4BqTqoIWyGoKL7OOjeee2NvsxkGxaxOkjK7vGmXO/QFoxKEiG0M4y?=
 =?us-ascii?Q?tyLIz8f9rnkbNuSFzxREBZhHcdnlodqCcoYqVLOfQZg4RhyUtCmztY8SsrUI?=
 =?us-ascii?Q?2K9eNLEpObK+k38czdIQGKNSM1Pnfrec10acEPRHZbY/svOEWhe01Yjq//5B?=
 =?us-ascii?Q?yW2e5zg4xg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5d9e1d-19dc-42b1-ad9c-08da4338947f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 19:05:51.7154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbzWCmpUtq6fXTfZjL/NlCPnE2A+LUYdzJ4J9RmXBiLU1K2yKp6UU3VjwkZAm0qq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1582
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 31, 2022 at 10:29:55AM -0700, Jacob Pan wrote:

> The reason why I store PASID at IOMMU domain is for IOTLB flush within the
> domain. Device driver is not aware of domain level IOTLB flush. We also
> have iova_cookie for each domain which essentially is for RIDPASID.

You need to make the PASID stuff work generically.

The domain needs to hold a list of all the places it needs to flush
and that list needs to be maintained during attach/detach.

A single PASID on the domain is obviously never going to work
generically.

Jason
