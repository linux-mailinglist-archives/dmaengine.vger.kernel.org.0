Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EAF6ACAE7
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 18:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjCFRnI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 12:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCFRnH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 12:43:07 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20619.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::619])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD00D6BC11;
        Mon,  6 Mar 2023 09:42:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRN8n5W53bIEWzu6vZ/ARhY62guyWB8R17UA4KDCQVfgzu/9CzHig1bM1+lFvDRhQYyPK/w9SiWf8vKqoVzwMDbv4Amvshaw69qTQsWFIi5AZJYp8d1owlsojAsUxReIKuvOk5qXSUlV0uT+A/R0QF20q1IMbrEvKGAYvu0U3cWhj1CwF4QmojMrQ1eRWp8CKml3+1yhDxNyXha+7ac9B1D04uvsOEhJGeJDsp97OaSHaibVqbcui8mXzLmiyNMKVtT3ukLeTCS1A/71OuXvdW+/QFvtm0R14hIG9uoXwMUMa9p1w9pZ74zdQHTQAEf4XZF8tC84gryxqABo+DWofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5rC4CT6iJEoemOFDbLBtbZ0Gi6WhOj2fIyS3GHYeBc=;
 b=b8SVk7+D79sBz5JETfmrMUf7jc3fXZlP4pmPn+P8AV51sgLQfc2/7NHlzaKcIqMW6PR3H193i62dpKIQfxeFl4UhMhyJ0eNcJz/qy10kES5hk7b5LgN6Hh4bgpDHm2PUdKinI2qCyB2UTxNbyH6od0n1QA1zzhcSE0syiPSsy3YnwYJrFspcOrUaEBigGaMem9lWRluUcNk03AKusPmIOOY6uHUvcV4IKidBGXXjOGFB1BgqmL421JPssWRDLCiigrYEQ1PREn8s5DpRyb42jB7fwirUy+gzANCoXC5k4/9O+9Gn8JiJn7v5S2OEPu1O221R7foy36UE3vIM39dRCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5rC4CT6iJEoemOFDbLBtbZ0Gi6WhOj2fIyS3GHYeBc=;
 b=lXLzUPvCShuAtIgdKQId/FQ/dItqPb4+p30zBUYQFtJ5yF5aIIS70gIwhKssYG7sBtw/7Eq2nnIuGmf+5Fp/JXpXe8E7g9UhK5HMWI1dOHUdQ8dgNusI8xkmCTv/7YnFlWpCaimbaiEnIhK+YSfexCu7fFwgs+Z94huQRN4vMGAuSibZdg++5asJJCj2i4S24R7f9D4yl+R/O69g2daGYnKNghrPpIJ1r0VBP4nqP0wWgMSpYKu6J6PkexZ8ge/x0GerbCW+qmGTkpVVgENytK3/LRjHNCST3Z/BI7YAGh8Hd4FugJPbOYimXjIpdFYqvm5S63Yj+BOF6rApSl30mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7253.namprd12.prod.outlook.com (2603:10b6:510:226::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 17:41:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 17:41:24 +0000
Date:   Mon, 6 Mar 2023 13:41:23 -0400
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
Message-ID: <ZAYlwzQEcDHZKoju@nvidia.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
 <ZAXjVaucrkEvrfsw@nvidia.com>
 <20230306093626.31c1573e@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306093626.31c1573e@jacob-builder>
X-ClientProxiedBy: BL1P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: d9148832-cce8-4c4d-4587-08db1e6a015e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7AovJw7aHq7Vfbx1vyBlzl6nakbiEFT5gC8UHy70PIkoDsNF7kH63jSlud8AL4GtircACDs8MM6fkbN72E3+WI15mi6C2gToHt31VnFRTRFtsZDO93yeFksqqhvgAwqHN4ev134KFK96xMC6EXGj/cf4zAeS9c/CxdEGkJR5li0ziPE+Poknynjv2bThbo/xd894SkjE5FNILwwxKoochDVuQDELqPFPpeWRvc1RSDG5UfVBkGM4A/PXXPuapfjFeVIJN3wT6YwRDcFNgzltGrwcrmuWKpKYV/GnbLukiS+kehnxUeLFhMiwKNc5rJ2AX8qIXOskm04TRjIC5RUZTq7/0HvQue7Tu4opMrsOAD+FglQpTnP9DG0sOn7bMpzfvtJnES42r5LAdjLjEnmwDHS3E6NFt2hZuU0Te3yPnhc3i+a+XZrbYzZuBF54CUbR2HCDw5nIogHc0eYZqi9YdFB35NEGVx4A0SR1uAE9iUMhEj1HduNCv5gLOEmSZA4wD6f5pWj3Iqhst9Y0BPraQzDKDwWxxv0TxnbY50jizG12gjNiCvZ/gssudwU2mDezGihkgPPeKOgBOHQ1flgVvy1b+nZRTQmv2eLVXQ+nXwPdIAIgLdN2ukowl4BXavdmonGG9QNITrrn3morDtfdqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199018)(26005)(6506007)(6512007)(6486002)(36756003)(86362001)(38100700002)(186003)(2616005)(66556008)(66946007)(66476007)(41300700001)(6916009)(8676002)(4326008)(2906002)(8936002)(4744005)(7416002)(5660300002)(478600001)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qXwh40cpKb4qIUa17xoQtKQHMJAs/rRzyq4R5cUBVdRAWXLMxR4RCSk9BuR3?=
 =?us-ascii?Q?CMiXFPX5zx9HbyK6B8CsKxMTXWRj+WnQcJKupddf1uV8q3csS/Hv5XOSKm1W?=
 =?us-ascii?Q?0DpGUB3D74fUxNe28DR40/m/rwg7I0enAYGlEV72qlqBGWek2hVZNa2/jkvU?=
 =?us-ascii?Q?rdCHCLq1i6HGycun38Ax4NaGzxcFO6gNien6JpoKw19ydG2DYF5iq99DrVz7?=
 =?us-ascii?Q?1zPqozpjSKD2oo/2xVL4NzOTqbtABPs1c4PrmjBYw6EvkdTeFe5GofG9TlB7?=
 =?us-ascii?Q?HUYkZ7P1pbLnZMzQIF6gsUaQXt8Y6fJ449FHHjy3hnsWkat3Ycjbijl4I74T?=
 =?us-ascii?Q?HJYGJ4l10QahsVK6O7/KY2I1abp289CkJBblfp5g9cY8s2bLHtcqoxNpmklA?=
 =?us-ascii?Q?gJ+JLZS8E1dYtkSO0lIKGdZ8YvXrwkA+m071TEkB/xzQlH5FGb8BlYzIvAtf?=
 =?us-ascii?Q?Fsa/bFQemGBn3l6KG5Zpbkb01oPjQ/9Lcj+0Qecly9wBkmadCgT8QucKkr4W?=
 =?us-ascii?Q?hI97cIlGqiop7C+y1SDEWTXi5TSeRAKgq1N54/mEjDLxMPK3A6MI4nQ7KuXx?=
 =?us-ascii?Q?hThFOKK4FYKL8AejJDnkp8UnmrMEbkUjS1TNO1l3y4NiPb4sSCN2nA6I9WCF?=
 =?us-ascii?Q?3RFrjp01AQg1zyxm1gdEZGQ4LXawKAyrjYd2x6JMjYZ3M4H7zVv86kKah9dO?=
 =?us-ascii?Q?Gw/fMNgDjkRe531iTUxLaORKSstpH7f94WFBo34WHUNOxgjA2oVWP3dAa+Ho?=
 =?us-ascii?Q?cbhxpzYkNT1FrjVIFv+KtjYRcYJZzraJGmIVHi9a99k5D4FGnf2Wfkw+hDdg?=
 =?us-ascii?Q?xNTrsIrCgxrBsVLEpW3Aff9P4Prgi1FiJjTwhlUuzZ9u3GJXtk4a0+hbzb5V?=
 =?us-ascii?Q?fKRo+oAnMv7CnKY0uph72KMaBj1OVS8LUeGcp9eVcRHaD/m01TN+ycWmDkDs?=
 =?us-ascii?Q?A6jV3OZvOaefbWUQE8QWa885olA0IY4Yh6QE110qFAi48R6StrDL2MnWBRfy?=
 =?us-ascii?Q?vL5w0xCnzpEy1E0VxlKxuR4Vcyrh9UtsEkCTMBvEqLYRJdSzdmCNfRvCNi5L?=
 =?us-ascii?Q?XOy12qH4Lrf71s08VkANnHvZNrcLiI6DuPXRL71ZTL1QRCo0jqJMepfzMASZ?=
 =?us-ascii?Q?ih8lnsCPrJ8hpPzw662O+QEQ0KUmh79WtndzDObaHkDuZmkWaJx0+5QURga0?=
 =?us-ascii?Q?l2zV+3RYlaWW5OJvrBDvmUS/9ZZUajEQKMWbHZtc0dOQzlqRSjVk1XzYecEz?=
 =?us-ascii?Q?nqMVAXT1N+5dd7d2Wroop4Y8Ts+ptdQiKafn4ceocqNJ1F9AOpv/qSA9HXnJ?=
 =?us-ascii?Q?ag9tHseVaLOiFZY1Cb7p2O+g/9kFY/+o8icwFj+EA0CMwdJd+Kb6HQPOxv3/?=
 =?us-ascii?Q?9sU/Bp19QbKPNp6JR62s5bG0gvpwadp0OxRadJ+yEVgicpoO1TC7jWFZ+WNW?=
 =?us-ascii?Q?FyQT9oiKRooTjTUjLsWamYdERkxMp/2+tyH0ymPsB3CT437u6vDG6D4jkYcT?=
 =?us-ascii?Q?yIOkZu4szEPMWCdz26rYVTd1Nlt3v1AV5TM6srqvoz70ofgsggfMb1wxKxR/?=
 =?us-ascii?Q?/rgya5SkvvrHkcK2QabTw3zTewHu7bcr2ZnI7OdH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9148832-cce8-4c4d-4587-08db1e6a015e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 17:41:24.2785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Db66Xsp+PRfmuXKpdcEfGviT5ZCCOVl1wQw8zlCLNLUl1J4F2RTRBHf+utUri7VX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7253
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 06, 2023 at 09:36:26AM -0800, Jacob Pan wrote:

> > It seems like all this is doing is flushing the PRI queue.
> > A domain should have a dedicated flag unrelated to the type if it is
> > using PRI and all PRI using domains should have the PRI queue flushed
> > here, using the same code as flushing the PRI for a RID attachment.
> Yes, or if the teardown op is domain-specific, then it works too?

That could only sense if we end up creating a PRI domain type too..

Right now PRI is messy because it doesn't really work with unmanaged
domains and that is something that will have to get fixed sort of
soonish

Once PRI is a proper thing then "SVA" is just a PRI domain that has a
non-managed from-the-mm page table pointer.

Most of the driver code marked svm should entirely disappear.

Jason
