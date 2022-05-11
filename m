Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A417523B07
	for <lists+dmaengine@lfdr.de>; Wed, 11 May 2022 19:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345238AbiEKRAa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 May 2022 13:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245580AbiEKRA3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 May 2022 13:00:29 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EF513CA0A;
        Wed, 11 May 2022 10:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGD2RovL/FnumyYpLA6VGHIEMztyCOaLrjqWDOewasoExcEda/J0ksDg3NcFJRN42nQF7IotvIYn46CSONGztlpIjQsW6pXOP1ZOe+n3eK47CJRQf5+DnQIihpeP/1bz89HrBubZRbXnnWon7uL/QnVQDDdSoJMxEW/S7/kT66l3cjhOW5TJqqz4nOI0avZKQBC+loYmSp2PkrfIYrNwugcPsS1Xgps4ShKB0y6xkBx/e3FZEWHzts+OY0wm3e58W2c8J6F42lPK4ekQPBx7ZUWK/9XgKMbQVe86+v0H28xrQkLWsBNpiYEUn5Ou1mRv6g+0yFvipGIaS6KGC4J3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/ZNDDSDpYqzZpmWbki4zmGAsxGMH9nVBhAl6/ujHmY=;
 b=LKS6YXXuoWgqXUltXTGYMmfqXuNv6v7DemrmWgAUw+CAlfrmEU5NfTQ65FoFItzVWubUmH0WLT67N1Qg7Ej0nX+FEXE4XtO4I+se0vtVXw+GUGT/Svxe32KO1zmAKQ09wfoYSFCpUne/2IVhVzSI+wzKrqiUyudkSwc5OmRHC0YsMK333oaWyJoFmDppfpswsmcklBIui0MJx9FJmWDxvFLi00wVQ0zFU2SpuwDpAL83QtRhe+EFWixWZknvKENKLlx4u/1Xf2MrmfjvqThd7e3Ed+iTK3y1mgwZmYVVBbbvp0Xcn1OR9NPMK0a9Ou37Buv2VngYkAhDQZWOffj2+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/ZNDDSDpYqzZpmWbki4zmGAsxGMH9nVBhAl6/ujHmY=;
 b=aHWbCNiW4QPBHRpwGNnbOD7VHfWY/DdAPJEvtC8Ze2jh3Iw64Phe98O5/J+ho/6KOUx6irUN7cBz5hCwuTFb/zaq/3/UVtbZsnl4FatAXr/O5Ci5Y9hfaZwX3Xg0GdeeD8Th72jFpN/usgNqbu5HGV8td2E15jZdbA5qTNNYuk4V+ZzD/CaiPyDr1fXTvrqx6zCfBy0r8p2VnMO5I1i12EjrJqsDd/0c/sAnUW9iY638NzlQmxI1cV2bOZ4bIC7VcZyhBzQIuQ++6cCDNf5g10dlBnZGJp3/Gso6tgSVOsuHnwLimBMw0GCb0Em08tdjjBmgWvN79/MdJnUp/PNfrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR1201MB0163.namprd12.prod.outlook.com (2603:10b6:405:56::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 17:00:26 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 17:00:26 +0000
Date:   Wed, 11 May 2022 14:00:25 -0300
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
Subject: Re: [PATCH v3 1/4] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220511170025.GF49344@nvidia.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
 <20220510210704.3539577-2-jacob.jun.pan@linux.intel.com>
 <20220510232121.GP49344@nvidia.com>
 <20220510172309.3c4e7512@jacob-builder>
 <20220511115427.GU49344@nvidia.com>
 <20220511082958.79d5d8ee@jacob-builder>
 <20220511161237.GB49344@nvidia.com>
 <20220511100216.7615e288@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511100216.7615e288@jacob-builder>
X-ClientProxiedBy: MN2PR22CA0030.namprd22.prod.outlook.com
 (2603:10b6:208:238::35) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dcf0603-b187-48b6-2a83-08da336fbeec
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0163:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB01635F6195379664CC262D18C2C89@BN6PR1201MB0163.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+dH5Y91zhNWZGo3LOU7i6CFQyqDGAqiLg4Lr1PfllowiI1kTcSJoo9hXutZrbeGDKPQJRwi5KWTLmzityRFSHH6C5F0gtgCFoHbscHojPfOKdhZ7+DdtRl2Kp77z1spPwIiavXNMAtIzkGC9Kbe1QKYlIAiMOdjbYdMldp+X6Xf/NEx3cMxhKHm6zvpkNyv21O0vzu94t9nVma/JOssmJohUjIX0mQarA1lbDY3NSHOcdpnlrsydMKAHSW3eINw2eS7ja7YKwAIv5WOzzqpWaP6PRJb3D5yescXtLnYEShioRwPWiZFortHf+n9Ca7Kw45A34+A/aq5lipdrt81WkHtuFmU2SHaWgsW2xZxlxAesuAYrqQNglSgbayx5h1k/aKti4/Z94ZpovuzWLTSUnUJLQeqSKIici64aqsgkWKx6t5jKj1IhU86FlBGTeji1wFjfk0Jzzogde+LYqF2BfdgAjG5xZKCLRYDPC1ykcjImxF0yXTqAc9Ez+BAmtiTwaJfJYalDm5/Qpuh/rXqUTsCQMb+gWd3S0FeEwOy1u/QENcwTyMuAWJgi8HC+/pefRfADjoshBVdHFJa8803f9J6NIdjM0+Sae0XmCOzIoiZM3dAIVGA0OwQ0VJf+wnsGcqKg1vEYvlPaAWhUxKHBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(2906002)(7416002)(5660300002)(33656002)(8936002)(66476007)(8676002)(66556008)(66946007)(4326008)(86362001)(83380400001)(38100700002)(6486002)(186003)(1076003)(6916009)(54906003)(2616005)(26005)(6506007)(316002)(6512007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BFBo0RLISVeGKUU00f5zL6E2YuhABFHO28wWZNdxHU65kUi/YMZGb1MqR9Qt?=
 =?us-ascii?Q?SlCV9clC/6+3sHY68a6PVb3SC4nVDwScZ/PwkCuV5cDsowoYz+SzGoY9GPkq?=
 =?us-ascii?Q?EC7hfn3Jp/2tCekuYNE3J8Tds8HPpqrhdaB3NeHR3m01dfihu3XRlifDMfs7?=
 =?us-ascii?Q?E1n1BIqLXOsLQ4/WcDHDifAPRfjNI0+sh53fh6HLVEJUzFtcxtlUzGuOPfk9?=
 =?us-ascii?Q?OUDhI5gOKS6xwcB3wfuKUD/XU2zhPxr91fQzx5VkXK1RpfZtZbeN87D7JU+S?=
 =?us-ascii?Q?4nEX1iIk6EEJcFtKFyj3JB0FHZef7sn6lPhcOkxtAG7NayoEi8BpToraEsa2?=
 =?us-ascii?Q?IN4vete871a91Rp7jcvlVk+C2F2RGBOtKGOp3I2l9CgPw/u4N69CsSUPAvzP?=
 =?us-ascii?Q?tSX8/3AoYuuO5Jt7h8yk1UIyBnVEuVP5S/JBXiL3ZNztHbkmvZWZH/XgLmNt?=
 =?us-ascii?Q?U3ODTPu+0yMrBQCQx8eomOTBQXLeCoQ/xeTZ+shYOlLPRWPDvPnSUbwCEdBv?=
 =?us-ascii?Q?bzrpEAPB99SDmBgghJX9fwY5q6hi3Xl6ycmWgpX8P7DmmTtBOn1hv2e63zWS?=
 =?us-ascii?Q?QUhgmUvSuftR265BlIVKQexGGqJNe9YpbpCWWwxmE5JZ/SJz6TmleID3tD+Q?=
 =?us-ascii?Q?BH4ykMxLzMJfRIuPFUYBNFtYee5yhXNWwDHckWFdCLnNOtNjH0127YbWfI/P?=
 =?us-ascii?Q?XPwh67ZPsEaHg7yXChcJSyYEQjVMK5zpQfg+YpRHlHHzuT2xNM5YI4u3uUSN?=
 =?us-ascii?Q?5Y2QxtIFXd6sHOyWQbd/bmI/lQq5RaCdpeOII5hEB2g852pZoGquJQg4HAnq?=
 =?us-ascii?Q?FfxSw2qPiNi92ihH5Q9oIgKCUcqKixgcF/WtC7yZ+V8ToRsH7dAjokSnPJcJ?=
 =?us-ascii?Q?QXo2D+W2ZpQbnZTMgTWHpLG+WhlGjn1idHmLkaNbGGkAtAdyys/scDoOAijR?=
 =?us-ascii?Q?NG/x8/Fo4p24+kYWbH9079NDYFarioG7fQHb/iQBHJ/XmDoU99XryJmCMr56?=
 =?us-ascii?Q?0xKAvM1WGFqPfUdHEscQFavk5jJT6oYYkcR3sso1K8IkorCSND1yXD00zzaN?=
 =?us-ascii?Q?UYkpRTcsUXqpNATLME0KxdZtxViXf5Mti/kSpne7z6eMNVO1qsuXiT1q/nD6?=
 =?us-ascii?Q?aH9UEg6c/MWwdsYbhAzpFfk9aPj4qbzOchCaw/jr5uThnxgigKv4M7gLdOz8?=
 =?us-ascii?Q?8uohRKMtPrk5g0O2UpecaZF6MFDQ86fHLyhBPpgpXE1LH0Y6OLGyMElziDro?=
 =?us-ascii?Q?JIfGLQKoyE7px9e8y3O5F0ryU0UujFIMR/sjPB1HvHPBJQqwefEAYz5R4cR7?=
 =?us-ascii?Q?z4tpvh7/RbVU8sJqnpSMnFSrjGn8LtgVdDz9JPsZDu9AHMS7tEj/+gvK4+Td?=
 =?us-ascii?Q?bUrN/leNoAMOGxT9sGiSZKYjIDd5vfQPanIET42jgjEq0K7jZXJW2vpxvLq4?=
 =?us-ascii?Q?WEDX3lIV9lVcBUC80DMU56Ui+UVX+7X9B60IhTdizGuzLq5Gb0j26b2oAwIp?=
 =?us-ascii?Q?lut4CZHnGMIt+hu7xGuZ113xAZtO0Z9AMi9yWgbFLmk6uYcSoxsSsjP7EI1Z?=
 =?us-ascii?Q?kg+ZD/3sLh4QaBeHbRLx3qPzs30wUeH64MrCwmmjOu9kl7o3sv3VbdbZMxyf?=
 =?us-ascii?Q?Mxn42rHevjhfBJBXr7Mpwe2Foyw+Nrxddh5W82p4dugB9nZ/kgOP7LdJIcRf?=
 =?us-ascii?Q?fepOgBsTik3mdAC5pJHDyouJH1kl2n8lO7ZqUQqKmVNhBi6xiFoRD8COm8gQ?=
 =?us-ascii?Q?Q57OCrFmFg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcf0603-b187-48b6-2a83-08da336fbeec
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 17:00:26.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uW2mbUpqxh2m/9TgB1xw+jRY2bcmd02o4wTvJI+L7M/PvJtDaFVO2ESn2ro7+t3v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0163
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

On Wed, May 11, 2022 at 10:02:16AM -0700, Jacob Pan wrote:
> > > If not global, perhaps we could have a list of pasids (e.g. xarray)
> > > attached to the device_domain_info. The TLB flush logic would just go
> > > through the list w/o caring what the PASIDs are for. Does it make sense
> > > to you?  
> > 
> > Sort of, but we shouldn't duplicate xarrays - the group already has
> > this xarray - need to find some way to allow access to it from the
> > driver.
> > 
> I am not following,  here are the PASIDs for devTLB flush which is per
> device. Why group?

Because group is where the core code stores it.

> We could retrieve PASIDs from the device PASID table but xa would be more
> efficient.
> 
> > > > > Are you suggesting the dma-iommu API should be called
> > > > > iommu_set_dma_pasid instead of iommu_attach_dma_pasid?    
> > > > 
> > > > No that API is Ok - the driver ops API should be 'set' not
> > > > attach/detach 
> > > Sounds good, this operation has little in common with
> > > domain_ops.dev_attach_pasid() used by SVA domain. So I will add a new
> > > domain_ops.dev_set_pasid()  
> > 
> > What? No, their should only be one operation, 'dev_set_pasid' and it
> > is exactly the same as the SVA operation. It configures things so that
> > any existing translation on the PASID is removed and the PASID
> > translates according to the given domain.
> > 
> > SVA given domain or UNMANAGED given domain doesn't matter to the
> > higher level code. The driver should implement per-domain ops as
> > required to get the different behaviors.
> Perhaps some code to clarify, we have
> sva_domain_ops.dev_attach_pasid() = intel_svm_attach_dev_pasid;
> default_domain_ops.dev_attach_pasid() = intel_iommu_attach_dev_pasid;

Yes, keep that structure
 
> Consolidate pasid programming into dev_set_pasid() then called by both
> intel_svm_attach_dev_pasid() and intel_iommu_attach_dev_pasid(), right?

I was only suggesting that really dev_attach_pasid() op is misnamed,
it should be called set_dev_pasid() and act like a set, not a paired
attach/detach - same as the non-PASID ops.

Jason
