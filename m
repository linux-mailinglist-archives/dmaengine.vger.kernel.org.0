Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA286A982F
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 14:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCCNPy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Mar 2023 08:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCCNPx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Mar 2023 08:15:53 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05A25D77D;
        Fri,  3 Mar 2023 05:15:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RobmHhxboknCYwqxFXyVX+hYkq4kP/IH9MW3klNDioMSma88zPoNeeTiPSsN7nQyhSR09wNwgliBxgGYJV+w6ilAU94w5SkCW8VbGov0S1MI+5p0tsmwo4ZETlx9ZRahkr4zbwHLKLUfSpM5sLbf9+Go30nCx3cm/eZ4us9stC9wudnje9xBDOWhkmowZIDls1uDf2tlDed/6BsKNIdWLiVTg1BiM0ELlbm6WiDj4a9o8mzniyaJaxGa57nRC1ioyXkQhsu068+SPV4sO3Ad56ZGGeMEH8RLW4lIkdcHPTX0Ze4bccmpW+DPNONMMlGaoysdwKqVbzSlv7if0hag0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLKDETVPPs3MybJk7Pk8iKJRne5A3dTEr5VmbxXbbVg=;
 b=h5QxaQJpcFcLsz7oaJLkAsu+8MrLuI9+U4wApdCGyJyy5GkQ4tm2oShOQRGiC80NYZvGU+hpbtOrIaDvMBsejp71CPPk8dsZWdwZvp6rsgc84zPpVajam6J5DgrEWf8atVtZtOwThEAAWGnyOU2NWher5zDdhCAlghyAdMEUrfqCz36eJN4In9dC6hy0gAW0JUMaTHS3hNfIftvmLD4co5qU1VezrQ7DJUzLGUZKhLgnv2rU/N6Q3K5OTDkfU5Q7iAkni+ixiozPHwUNzrUczvmLLZs/Sm4/oJyq64PhjgeA4jcZqt3WJ0yqr5A1ZCu6aGT5FSWZc/BU9bxBF6QgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLKDETVPPs3MybJk7Pk8iKJRne5A3dTEr5VmbxXbbVg=;
 b=SoPvoOHAwOg29t4IGe0qe+yjXIHCuHxrUlLWOljPsC5tiAfb8Kbqb7S7ApWVPF6fhYBCSfej/t+MgASaWtNq26dOgEXrqunxgeIOs7Zm9JCdkLXECHYaVRh9ggCg3FZOYp2fKPZBqdNKL8iS4gyLWCSRGK556CEWQc4oGfPbd3LR3f+F9TBHo7COBgrLpZGIODBhbmGP5kB11WCzc0grNhU9WQ3T6rM30TqaZNwi0XVhTpq5hsX3q2HwKj+Eg/X221dltIN4wSkdYpTxtkcZuPZWuqmy5mMbTRU0OSz2A8XUSFtULasrTWOnpILm7U4dBl6e0anO4gL5WmmRrRKkPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Fri, 3 Mar
 2023 13:15:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.019; Fri, 3 Mar 2023
 13:15:48 +0000
Date:   Fri, 3 Mar 2023 09:15:45 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
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
        Kirill Shutemov <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <ZAHzAa0mnilf0N9K@nvidia.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
 <20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
 <3b7fb4d3-1fe9-a3be-46ad-c271be9f96c7@linux.intel.com>
 <20230302091707.58d59964@jacob-builder>
 <794c7dad-2e62-3afa-ea10-92179b0d1659@linux.intel.com>
 <20230303093235.GB361458@myrica>
 <3b2c6fe9-821f-9b84-acb6-777e8517a0fc@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b2c6fe9-821f-9b84-acb6-777e8517a0fc@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: 37933b1c-09cf-46a2-3c02-08db1be96785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: No70oEaZ0gB/yi5ckHDutT30uzTTEGvfmR2eK5V7qJ94CDDfoBLz0AFDqPpJ3r7z8XEqHIoNKYoUf9HntWlfRsKaRwT/F/E18fRbOLPbQ9x/Ty75OsDVecn85JcTrQ/cL8V+VoMQImdDMAv+1g6SDMKszVZhm716jwhC2PoSrlP8+0yURVz7dhnnrq8J2HszDGBoPn4XJUMgXFgAEk68eRRO0SAAyngmpGWaFh7fH8RadoDdWiXt7I4OniRzBc7uQyzJOZH8aWs49u7y6IT9wI/gqYUvkiqyP1P0XySV65oW0I20DgQMlU2Zl1VZYefokZV6aezeBTjXtVkMaFwUkyqNi8cfz2D7gksb/vnsGI9sBgJBaCpm2mLlVm286GpBtvRfW1CDKXdHF07V9vukgwDcb+KrOBJI9hBg+i0rUQsNBqGmP5zDo63hUR1EswInYdKRT7YWAEYgQe8pcE2WCIzzr3rZnWb4jZyeI1FCvFKYFOz/D+rrNq+XguQKDgtQ24h1ps9QUsZRZiS3Nt9H+ZyBcSR5zFSyoPft4htEd3XIgn3OW1CP/LTRzl7f02czADjMflr7jUMGrhBzo14yh+jTh5VWYlSVIz6rGHSPxHgU+bQFBXJpe0xju1YiG/P4tq73isHUzoF46JpC6OOdxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199018)(6666004)(36756003)(53546011)(38100700002)(7416002)(8936002)(5660300002)(478600001)(86362001)(66946007)(2616005)(6486002)(6512007)(6506007)(186003)(66556008)(4744005)(66476007)(2906002)(8676002)(26005)(41300700001)(6916009)(4326008)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QWHLMy5pDCxZze794/mGncM7mipI36BPmVbAQSOhEtzV69iOLrs4M/e+Yl4G?=
 =?us-ascii?Q?BcvgeaiQbG6ZKjVCSwzfaumkBA9/x+Y43x+vC9X1p36U7yXTO8EAPD2RPN8w?=
 =?us-ascii?Q?s92VP/FgKZoH9QCGof9sNF3zjrZmAZ7n/FK93W9Ki3CmOXq9VsjfdjCr3B6T?=
 =?us-ascii?Q?RTJSt3KIWstXq4UmE47IFiummNxAZJzhSTpXmDAYZ4o0sWJtasrChfoNqa9s?=
 =?us-ascii?Q?Be+/7UNv03/PiO7i/y2d7sVVXaLm7jXYCj04FxU8r9LQQZnrBE5gM7wXC/rS?=
 =?us-ascii?Q?0iEeQCCXicVw68xeSApR6dKzZ7X/Z9liFFiYAPTKWjJ7RxJdAe/tHtZnyGgw?=
 =?us-ascii?Q?J3V8aeI8rCx9zqUx1wjTt8ZYrulBRycJZ/ZUrD5Wv0iO6DuT0Q5ZIbqBFpIY?=
 =?us-ascii?Q?muW7nBcHnRRschoTcI65+0FryQbvdkx68b0zKKOWXibU+BwHwlj5sOEUKqHp?=
 =?us-ascii?Q?uM9VB25x2UabWeZ7IAXVuxv/5wKsdKLfPXd0ddjG2tpsiEpE+603E+3b3RGL?=
 =?us-ascii?Q?SyFrKIrtNG65+NzBk61Ymk7eytpQIYuoEQFCYnf9sjZ10hd161M+1hjJSxTi?=
 =?us-ascii?Q?5UsslMIKNpMqgyR8j6o1ziRFrbbeU4xeOTN+bGr79ZXe+IWL7BqV/S5Jn/HE?=
 =?us-ascii?Q?+8gH0crOtvR92/koLMJWGEw4MknxFtZwc5FcgsbJS7i0cWHsPtdIQxWRZ+0f?=
 =?us-ascii?Q?PXpFd5kzvtCFslgphtEGyU665qnUfvw7UFAZOVqcqsv6MGezcBXo3dmg8LWe?=
 =?us-ascii?Q?A76KyU1KyBSZt5VCZ2xHZuSoKA7WwfRyK4VWQ6DJf4IExOAVeAZ2Mzyi0HYl?=
 =?us-ascii?Q?oh0FrsQBA1iUsvysdL5XCYxTDuQrJvu+gIVMk2jtgrUcgW+nK4TLfhKwnjjE?=
 =?us-ascii?Q?os+oIWEl/lpd22gMJmUpfi4ZeJlfJU/Z0jpifaojuUjimQREjxZhi+PrsMds?=
 =?us-ascii?Q?AXaC0vr0I5VHysSwGwilwl9JDz7zY/1kZskqi5lW+N23OvoxX+mtejUQVl4p?=
 =?us-ascii?Q?irLFkCRWZUrM62YobCUSfKTXjZNGO3jRk8z4dznTqTQBga/aEPfb2+RFFGfW?=
 =?us-ascii?Q?PrlcrNuRextKnoma2Zyr5bsMzr0DsfPe1Dw5VGclnIYDlj4uZT45QfRXXZGG?=
 =?us-ascii?Q?nL7D5h2cvQCzZyPdj/zwNnW/imFxMLHdg3hB4qZ7gyRsw6/CTsXGZP6oQysN?=
 =?us-ascii?Q?MyTxI5UBmbHO+NGTkrBdEzTSyVeIhnl/Hjo5ep694dDJyktVdJk1/5zu9I6W?=
 =?us-ascii?Q?hPUTBMTcF8dQU+Q8EFsxFDL4mb7mA643XE+rh6VLNRr86tgO4ELobMa0HZdk?=
 =?us-ascii?Q?KyhZfvlwI12pxJoz7vCOkNrbF4jqKC2l9Nif65hfN1JFUeMXJXM5FR7dOqjz?=
 =?us-ascii?Q?02rE7jvZargbCKjp0/LXLhQyxduum7sKquQDeKT8L5z0o3CZSrrgW/3+o6TC?=
 =?us-ascii?Q?WozNGaEG9AlBYOVpdeNvMS9mm2IKQ7ccAppCAcZE8prxZ3kaTaEkpd3oO0/r?=
 =?us-ascii?Q?HlY8y5oo6o3ejYMJDImu1cMucfexnXQy0eWxQfz/GKgHmSgLAF7qYa3tsbja?=
 =?us-ascii?Q?QNglCGIkjQ6WZ9/0hvfpEgM2oCqjAMXegRMcp2ho?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37933b1c-09cf-46a2-3c02-08db1be96785
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 13:15:48.3202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQ1SvejwGmf4XvrUSHIIJiSUZynGj4uPUx2K7vxKcjNCmoV2SJnbEFok+Md1hNfL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 03, 2023 at 05:57:41PM +0800, Baolu Lu wrote:
> On 2023/3/3 17:32, Jean-Philippe Brucker wrote:
> > > I suppose the common thing is reserving some kind of special PASIDs.
> > Are you planning to use RID_PASID != 0 in VT-d?  Otherwise we could just
> > communicate min_pasid from the IOMMU driver the same way we do max_pasid.
> > 
> > Otherwise I guess re-introduce a lighter ioasid_alloc() that the IOMMU
> > driver calls to reserve PASID0/RID_PASID.
> 
> Yes. We probably will use a non-zero RID_PASID in the future. An
> interface to reserve (or allocate) a PASID from iommu_global_pasid_ida
> should work then.

Just allowing the driver to store XA_ZERO_ENTRY would be fine

Jason
