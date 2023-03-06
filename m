Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DD76ACC52
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 19:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCFSUI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 13:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjCFSUA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 13:20:00 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E5B474FC;
        Mon,  6 Mar 2023 10:19:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NP2jmfvNHSO64zdLCeMsnud5ox4SqW8qR6holXo88opdQssTsSwg/FVTMUstjc9UycX6ZQ1JiiKHl+ZTSiZ/PW5C/TSlZz3sEbPGsczZT5gs6tqugcVEmM3OtXtCQzTjT6jmG9ONsMCjuvqhQrgQhN3LLAM3wYphuIf2Cj31BpjZZy4ishn5Nyap9A00RMhKt2qKkyn08t5PKG34NrsWv9PieRF51t4lqvSNesyIWmZ4enr3KghgUzmBRQ3jeNM58k/Af2woVLXXvW5w8HHJHRFcs3XSfaUYKJGbBEoE1LoxjkvM4uyW8/LtYcMBIofCdKl4wEaw/2tYvMf6G77t7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xbh1DZcikbZxp04XBa9UvmYrfqGUoxuNKQIYhQOdrvA=;
 b=GgUImvkVqUfg/7JP0Q4lkRL40XATTcqPj2E+rXa6bRvcNP7oRPnQft/VNL7sLu2PDp4LtdFG1uwRuTXI8V6DiFDJpkoIKeIxMQOdkDE4QaI6dKyEz8uV8ErHD6u8L/ixBtPb+j/SUjG2gzbkkj1UYWb0lihm2vhXQh3CA62VLtu0q7tF4/nontvnD/+T7/Gh4EWIRm9A5AscVj67H/7C43eJ4K4UlGTp91783veYq/u1jKvck1Ypq6CdbIdblNXfeeVQFUhPYK4mh+44q5s+sDEQqQPxv6GxJlsM374SaG68jB5vGebg74x0aWuFhGNm+DzbpamNCvhN31zZ1hJJWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xbh1DZcikbZxp04XBa9UvmYrfqGUoxuNKQIYhQOdrvA=;
 b=S9rbwihCra0JFz2B58IOslhvRcTN9Tt1gV7xkOZOf//h6gi6i9YEerJJbjmk5HNpszoavQ1cYmP0PeI1IIDWAXQhehpVajrbpHzOVkatYFaYyAohx0J2Vq4b1XPQMgG7F7ITK1dhD0rGDy/jNPR99RwlHlaS4DzBxNj/NBwGisjaebrn+Nyu+gOonW/raBUlZ7GRVOsJCyXv+lZhXfLpCTlD0ZXMkLY/A02u7y+nOt04TLgp5Z3a3qK6LlGElfLSRylHHR0TAqQVuZtqM7Ly02IGHYg25W1sQhYYgLbDXEqil/RwukC6kiFB0OsVm+qVbV4azcDv5KL7Quu9fK6AWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5419.namprd12.prod.outlook.com (2603:10b6:510:e9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 18:19:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 18:19:10 +0000
Date:   Mon, 6 Mar 2023 14:19:08 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
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
Subject: Re: [PATCH 3/4] iommu/sva: Support reservation of global PASIDs
Message-ID: <ZAYunPcgSOGFK8Qi@nvidia.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-4-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB52765C5E0DC0759880C08E258CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20230303134753.660d0755@jacob-builder>
 <ZAXkLN39VUSl+t65@nvidia.com>
 <20230306094408.2d675d5b@jacob-builder>
 <ZAYmS4Sx6bm+ziDY@nvidia.com>
 <20230306095759.1dd65cca@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306095759.1dd65cca@jacob-builder>
X-ClientProxiedBy: SJ0PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5419:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb4482d-7b3f-4140-d34c-08db1e6f485e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dSnSBaQe09Co7jWgVbXYVM2yAL7guPK3yZzbwsDpF6+ula3M6mtMRUPFAQbzgEtDAQQPwLNGvT6W/xohEv1R7jcSx+qGw/m+EMA8r/xANPPqwM9h5gikaumm+aUSqG3YmpMnmKT9j18FBeb23S5wxbu4GCzmyHytmZ+JAOVcohutXDoxa7u0gz9ZRkVspBoF/Xpzmmv5Qi6awD3IEJqwCsoI4neYA7NjDBKbpPTpUL7sdLbmJrxaJXJLdN/5N6a/DQddWXp2MB1F/z0bWCz7h3HmQURl4630kj9pHp6CjG9ucFdvjesyAZM8Ap61PiJ45yz54CqhTdqQOGyfzprEWSkyHV23k2z/kgIjgqAQ8fveHAfK5whPy4UyafpAZz7bSxJt68kL1niDWB6LcD2fmhK+NDCOqeH1Vz1Y4TCwptOThqqNjE9p7XUN4X2GE5KRPMmv7wjwlIF34LhNoP9OfqQwPUqfmaXb+7Irz7+VFCznuDHRNVQdB6vqjXKNFo8NwLMYSSx+nqSLsoHxMkulXbtzE5WxXohBEVoJlBNbXZPoScxav4uQAFipueOiRPi+jygUO6grxhc6FPvcW75bpk7rI5n7LLYan8G6ZnpWrhGC1VznKkXlIByhpe9EDCw/SDkxcRyb5bq4F1HUUJ/dUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199018)(36756003)(4326008)(66946007)(66556008)(6916009)(41300700001)(7416002)(8936002)(8676002)(66476007)(4744005)(2906002)(5660300002)(86362001)(38100700002)(6486002)(478600001)(54906003)(316002)(6512007)(6506007)(2616005)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qr6NJR/cqtSymHFnaCCs1FlgJCLyZ3r7qNf0aU9rYkLIIH0x2GgrgqUyvhbu?=
 =?us-ascii?Q?4O+vUfO6xtxeWZPziZlxuIpn7wPiEG1RX3wrLhGlutMa38lS3fHMilCGqysI?=
 =?us-ascii?Q?dL1Lt0J60oTM95cYPbINDcWKPS4ubUO4y2qivxaPRFD6WctCO8/I8YdU1WSC?=
 =?us-ascii?Q?npjU45nd7VkfyYgzspM2XCitOLbmRWwjjQgSfHP29MOZoLzHHvXIEERJEdOX?=
 =?us-ascii?Q?byvRrbv4nq4gEShP1fHQuLHHnU9l5ZGkRQ9AOU+BFBncxkYx6L+Ss+U9Q4ZH?=
 =?us-ascii?Q?R3PoEktf5/J+Mzrrd2Ho+mmYWqAlFVdlkPw+n3PwMVOXgz2ygD8UuRG1duzT?=
 =?us-ascii?Q?PpeCLiK2kOyhA4IQs+LkKVlNDj65ueU9Vupt/Q2fOdIMccMPoVLtkuySF+OQ?=
 =?us-ascii?Q?auhSftH5D68BhwS3mgNadZNbqMepTHWFjhO9MChqPKJHX/jgEoQLlEV0bL8W?=
 =?us-ascii?Q?xrXWjdim2+cRdCxFesolyFSapQncT9tySw7rZCR4h+x+p/uwy1q2qVP6HwSi?=
 =?us-ascii?Q?AkjHFlu//BPyjMDw9x7LlDfKCb//I0hEWF2umfLiZSWE3NhLUL/wrHUyjb+y?=
 =?us-ascii?Q?jKoN0S7Q8ULsEVyMcf2Bwjj04ecqWDf5m5KIjVpHrgMRJiXG3zIh/U+PZtOd?=
 =?us-ascii?Q?NWCM7BZ6J54ziHqIhcukzTzZC/npDhFfwj9Ktr8jDVuAglSCcGh4apPrfX5u?=
 =?us-ascii?Q?cOX9dNHEQtV3GeJJKmnEc2IVoFvZmlHWuCZDrpTk6qhfmGH4aR6njRF4Y/tp?=
 =?us-ascii?Q?QjI0+Cv1CFzUXc2AyQtiQLuxV0CeU4ntBvA/l0sFicB563ltFAEeSikHmPKU?=
 =?us-ascii?Q?e+lTHlzuWNsO5+iOPwLJEZ1HHYlOm5i5sYGU09obKwzd7VglSL32UgAIPWQb?=
 =?us-ascii?Q?G9IoHZe4xBecUkJHwmjhM80xocVI1dUdg5WzMRCveZZoe+ZIjklWsKvf8wXk?=
 =?us-ascii?Q?cyht8i2w1bMGtBzYaT56T1zEHSYxu4TLwJKhOS5OyD7JMZGmAD8ctjVyAOd+?=
 =?us-ascii?Q?XDMD0xepy0TIZ7mpXoQql6Bq3CXt7UFxJtMdxd8Lk6LkCFK339l6SPQhEgEj?=
 =?us-ascii?Q?AR3jHw3Pba/NXnLSrdL+m/BiBIK/hqD+Ft7ZicxVj5QvN1pujnBcnjOG6k7/?=
 =?us-ascii?Q?TyFGgbzFeR24xdA2TvHdc9N3lOId3q6S8UkCPO62FLWjHfK2IeW8FlWn9J2c?=
 =?us-ascii?Q?jfPXwD2THJxvHxjtw+WuveUjHmeqHMl2/jUQ5eEwDUIqwBdUYT0z5z16XrnG?=
 =?us-ascii?Q?YRmQLjEjpWvOsJASYV49Vhmn+inNXE1IIPdh4cJ28NcDS9m444uk4EYk5EAX?=
 =?us-ascii?Q?6PXP6yZPfWKvyUBZiLcHiV2ab38RbxEWcub052s/U+5IDIwWL3E2QLRe+ti+?=
 =?us-ascii?Q?P1OTgxrOQ2mirV4aEpecoXlg01M3Km+ItsK6ipfqPrFmI17wSn898vs2bHzn?=
 =?us-ascii?Q?+8PFaXbdc/ALNmXe4K+aOzGGZJcyPYbd352SBzvg2AlfGC4Wl6VEUiRfWIUR?=
 =?us-ascii?Q?dSZoviarxTJSIKbnsuevZtUSfBpFYIi6aZ3Kq4MRtv06siROB9XaBm8LNQJQ?=
 =?us-ascii?Q?fGSDMH59FaTNcyWkGEdaysJ5qpYBMFFyJbE5zeln?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb4482d-7b3f-4140-d34c-08db1e6f485e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 18:19:10.8684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDJQZnd23SQQLlc9FRnlIe54z3Z1POMipdztA9Qv1Gnwq+LyILxp8mmE1rj1l+u/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5419
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 06, 2023 at 09:57:59AM -0800, Jacob Pan wrote:

> ENQCMDS does not have the restriction of using a single CPU MSR to store
> PASIDs, PASID is supplied to the instruction operand. 

Huh? That isn't what it says in the programming manual. It says the
PASID only comes from the IA32_PASID msr and the only two operands are
the destination MMIO and the memory source for the rest of the payload.

Jason
