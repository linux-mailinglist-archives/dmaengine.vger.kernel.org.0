Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833B7532BAE
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 15:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbiEXNuw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 09:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbiEXNuu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 09:50:50 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2057.outbound.protection.outlook.com [40.107.101.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF9B9C2C1;
        Tue, 24 May 2022 06:50:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2P/1MbU9IZRbaXcevruaidYAdClzqz8MdK2a/uXaPfyolvuvH01dm7bF707YMAcYrvvpSPESYgiwvbEvZsSdRgVcpNMMOGPTTxoudzxJEsIIQqRf4O+1V94raSIn06SHKEnbyQGWipr7b+Jfp+BGDVnLrLBOaL6P+7NoyhFQMjdLg5oSubaSLKkPRv/vlr0dA2H1Ry6AospoXE1Kg/0KINmuX8o4aBo0+sfRLCcq7hcREmpOB24JN/5nr3FzM2fHFpNgQmz2RSibQNB8Cpb3elFBfzz95koWsuEZqoENPp8h5OnKwn5LytVYECJPy91bS0xV2DhVLiyK3cOnkDZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zNw/79ZZCAjMskAJk5IsIuvL8TRaN6TS93AEOMf4BU=;
 b=B+5uNgv3P0H31ztWWCpOY7NLPM3vzsI2gT9xB2HiN0Mv/WISunUg7B2K/VfDSPMeK0vsTj3VxzUncnMHVP7URZZmiO1TwWQCqzzhtHh5IDgF/zC5IakWGmQIHaQAcxk2X/UbBkAmY05L8+4LJ6jYZ2iXPRUXZwRJVzrrE+apoa15OkeGV2xUioiYD8ByBwQu5K22xwk1qnPPVWsJ+x4+0lFFooYyZ4DsiwZg3+DHRKGipsxvSn1jCfx3vYU1WJ6Gc3SIZjIpUcCPaSiWcjq4x5uSjnXBI379Igplivl1XVtMy8YX6IzVrxdbiHywSxa9T8klNMvhJIdjmIJQwg+lyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zNw/79ZZCAjMskAJk5IsIuvL8TRaN6TS93AEOMf4BU=;
 b=gMPcinGlywEpvqdLvauWt2e5/mVm+U3zmu8K4r7jbOG6VvKflcI+OFKb7746HzrChAPYMge8r5QA99SrkkZnqwS49tPEq9jzOVzJpDyRTZWwCze7LzKwT7VKy683oVCMUG7HBRuqSyXAiXP3EU16Eb4Jw8hkpf44L2QuY0Wh6xvV/NptCPmscczJyanAGL77oW8wJdvumer1M9OwY9We0DtV0Li4Teg1eYiP5UoqB2uEf5z2PPsA+RPRkzwfppuXOo7h/lBzPfbVfkZrJ5DMlixqLmRlRI7uHcrP2JL80EDRxVZoDxw20ytXudLnE5vGZKPK/q+3Jf5KoW//hJP9aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 13:50:35 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 13:50:35 +0000
Date:   Tue, 24 May 2022 10:50:34 -0300
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
Subject: Re: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Message-ID: <20220524135034.GU1343366@nvidia.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: MN2PR20CA0037.namprd20.prod.outlook.com
 (2603:10b6:208:235::6) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bac18a73-171b-491b-19b1-08da3d8c60ba
X-MS-TrafficTypeDiagnostic: MN0PR12MB6270:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB627006C81B01289AFEAD4E9BC2D79@MN0PR12MB6270.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QtVAaglkhxZ5gb3HHzvN3v4OxJ9CFRJePFXfnEdH1EpJoH3bfM+o11fOaHC8zmLV38DH3wwWv1HW6LndbGoCAEmh1RJLVxM/x9qaWntjoxj8JfVS0ka2121PQ/FMCFBkEAhcG9iXqrxZy1xbbD9sPibuHwGFn92XHNsWfRWf5YC5dP2c1hkw1ewQASL66KpFFJfUk22Rrn77WOQ4Yb6fHo5jmTbQSxgbM530sMPO1ZxWao0ldpPJxRxPclXGvV8e417qz9MJ5cqKGxxxyzigCGHBqeA18VkvH7nQjPkC5JEe+xB89vJ3Al3f6Y3XcYHbC0kmRqnh6XQ9niBK+sVeu5EJydrkdaA0l0mzDapv5WwFycRetErTEV09rFes0KHmOfZ4eA4UTOdSKFXVYw9JWWISa0fcsUEOVv6nWKR87C/8wZGZYKkvu/Iu5sl31LSWMjtGArahIARpvfRWdVjZTO9S02wjifILUiyN2C5rlXFX9HDOW7kezWU5RXptIQvZFzRj4U5WP/FaJms6Z7Bo5imRVLgJ/HC81Vy1NrPLnQEiQaDFg+V2NWpX2Tt/8y/sL0qqVUcyvBS222dPagLcawkonUy1G/2KjgSPHvoyBg/PkgroSfQpA/sk72AThuUoYRhW7Rn95nm8wSO2d3HNOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(4744005)(5660300002)(86362001)(7416002)(38100700002)(8936002)(6506007)(316002)(54906003)(6916009)(83380400001)(6512007)(508600001)(6486002)(26005)(66476007)(4326008)(1076003)(8676002)(66946007)(186003)(2616005)(66556008)(33656002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H3qYpZTCiDesTxxGhSe/NubcHJfjfZRmuWUDUs1xtbxJYtdp2/k2/XSAFojm?=
 =?us-ascii?Q?ayDooaKsV3WkGo98nlhiwPLQF8pkGQhAQEAx3CZZuKBtDG+4k16OMsDPlXr4?=
 =?us-ascii?Q?poL5TcKBtE10XxOnhMdUJz7jhhFKX/3BPdXmc6CcqANaLAbip7JBAAqC4d54?=
 =?us-ascii?Q?hTqDwwJrdgMoZ3Qwweo9PfcIPond0IFEAZMNgNFHBJhh5XxceQBkTXgGHsd5?=
 =?us-ascii?Q?kvBe9kZrv5+zKIqybM+wEOWxV3E9wVOcjHuC6Vm86puHv/BHm9dHlA2FWJui?=
 =?us-ascii?Q?rm/rKq7CDs/4yfRbZKKSVPU10dGaDO9zoNHUIN852wl9paK6PBjykWu/Zw9Y?=
 =?us-ascii?Q?LTgjzEIGMI3KKUWJWDhL8TNrXY15XVArxXt3KpKgBqYCoFxbF3gNbB5Wp8WO?=
 =?us-ascii?Q?gLwQg+CsYfzBfqoeh1SqK+R9soTiR7txpE0NydlV07zI/JdlMVM1LqlqUpMR?=
 =?us-ascii?Q?QsVx+Dmg/NX/rFyXL6QUZbLmO7iuFnKMAemnpw3IuZvHF8yrhEBH50Cwr7e/?=
 =?us-ascii?Q?9lMEs/PLfKNWgmfEH7SrFLDQKQ1gvrFfzBB8jPZgMt5t7HSUPhFUZm03ukBv?=
 =?us-ascii?Q?roEI+OUQ2/EoF9vG1GZSDNVPa1PV1AGoVax4yESi0qL1eoKF1afx21znsSaU?=
 =?us-ascii?Q?J+IYsUVmGiVnrg+2dj41voakc8neInYClpcODVdZWiVUpTAxDoYxIymmYvRu?=
 =?us-ascii?Q?js8Q+OTHlynUgMEmCKfXrDHRwSHeeByZZNw80nc0YZEY4KDszCkpFeBMR7LP?=
 =?us-ascii?Q?UzziAgZ8z991cTMKwXpRqiRgtaXiuKMQ07yYUXbuHlwKnQsMhhg3oxZAc1XH?=
 =?us-ascii?Q?c+/Eq3TQfvfbXfNG1IOf7GWV7nmv3WNlIlXKmadRS/WirW2tRfHsEEyD+QZw?=
 =?us-ascii?Q?XOklXt6cLhZMb/2I8Fb7KvoUZs4vQU2Yu6q2icuzvP1FAiOPwnOGHaO4UGPE?=
 =?us-ascii?Q?yIy/3yW7wX30Cd3NnZfOrLf9Q8DnskbkxchpnDUW6mkOQ45mrrxtiatFBFw0?=
 =?us-ascii?Q?Wz5JXAjKtMuHQaOQPhS4KUghxu4lTkKeAOYmfs33gfhm96Ka7t+wqfc83hGW?=
 =?us-ascii?Q?Q8tt/sQx4pKY+kCimn8weGA5ZaIQIEgtqNT6mKsXsGs5XTAIdEcc0yiRakVM?=
 =?us-ascii?Q?Jjqqiy23EjhYqvYBDCIGvJ1FjBZY7G5H5/K1KcwKMejApSsk7hq10aHtJCM2?=
 =?us-ascii?Q?O9CM0k4Tnwo9rKIEGggROFFIw0jQXYPYVio6wRe0m5gwlpgYHhihpeKDoWB9?=
 =?us-ascii?Q?ip+7roLDJQOPGkZFcxYLnKZ2l4Jv/S0CeXHm+roOcr9ysIREr+Th8gVm5MX1?=
 =?us-ascii?Q?DROhgqwhIoAhev1RUlGiK8xynlbOBuqHzgBQp3Cc2Yc21c0ZjjmpASm/U5uE?=
 =?us-ascii?Q?IxzRplDgShXiJQBkrvL7N3gq4oLcIEPfKt8B3qSoQv5ax+HUuoiaH/esB9Pk?=
 =?us-ascii?Q?DJu88Cl5DN6gzwKwhG/Jq4Z0gIntcQm0OX3ELa39HYFlXhyJjz2WQlLryRqW?=
 =?us-ascii?Q?h9BuO4XeUhkupCPaJFInNPcMf5Y0GkFZRKW2h7vUVJ0MRWMzVx0oPMlUFZz+?=
 =?us-ascii?Q?uX0SPoCItDG3vtu69QcrIYEhh5y3r9WOTmAJAlpv6gntbW1gliUo5a9xZqEg?=
 =?us-ascii?Q?PAfX0Fs1bYTB3c0kImRVFNKPN6uWlYpdU72wQKXyNFGaP9wxPMz9nZrMikO7?=
 =?us-ascii?Q?a3jpDwYN5t5EgruJG8gQUgnaLerBZOMskRX8w/LiYmhUgWRagkGBczz3XGK9?=
 =?us-ascii?Q?N7K3GklCCg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac18a73-171b-491b-19b1-08da3d8c60ba
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 13:50:35.4964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqWOhuk9UWY1iStJKlvIz3YNx6Y5W3SLwXBt5iIuiqZ5IZ2zqX4YIQ5MYLVinbVW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 18, 2022 at 11:21:15AM -0700, Jacob Pan wrote:
> DMA requests tagged with PASID can target individual IOMMU domains.
> Introduce a domain-wide PASID for DMA API, it will be used on the same
> mapping as legacy DMA without PASID. Let it be IOVA or PA in case of
> identity domain.

Huh? I can't understand what this is trying to say or why this patch
makes sense.

We really should not have pasid's like this attached to the domains..

Jason
