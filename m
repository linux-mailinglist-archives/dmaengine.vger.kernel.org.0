Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3431C65E382
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jan 2023 04:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjAEDcE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Jan 2023 22:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjAEDb4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Jan 2023 22:31:56 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06480485B6
        for <dmaengine@vger.kernel.org>; Wed,  4 Jan 2023 19:31:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpEKnKRn53wpsAgif8P15rHJJxYCviLpLJSpgSE9TuLUZQ2mwIB4bLGlLiqXuZK6YvZuJ3mVtDEjOoaUdlQhGHvl6MG0Mru/yJekKxzYDxKr6/4MEwDcqYf9woQx71KFfL4RGFXaTaCTKw198IElNk38JDb54WDglutKy+wRFb2QBZvwcbgB0PRoGPJumyxiZjJG1bhJ3VjMxZ0ToXVQKX2ncZgU1ZACj2tfMCGOZS2Aw1qOzoyN87k4s9uC/GCZi5Edo1ucfxdC/ocA+oT9FQ1ZKwfXrDRlU4GMByEElSoqVH75kT+9Fbh8aCpoAZ0C9qHm8wRhVlC5HncF3+bM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jF5IWH6aftL2BATdJNhs8sbB7B4PbQV80+cuVLfGBpc=;
 b=D6n/g9aRzgnzTrJ/fvpL8VygowwETPKDlP8le9wrgV8rFAStmsWqhnjbYwnoFOIK6wG/1FeTKYvnXiETX4sb5N927m6EXSGkMSodTQ1FoklShvu8KIbhu8D8Z8hYKbqJxjVmxItg/VxuC/FD6Tc37aIAyAMgVE41k8boOCVsguLSo4TrICIQtiSTVxsnZUsLExMIpQPdYMa/c73E73Xp4hIUXI1gcjC5vUDJdjwjExXHJRzikmcGbvZmv20NzmmnREo9ROzM9IcCZQU3pP5w/WQfRBwhm1/V0V0Ut9ekxfWEr3dZyaaRQkf3R8i/gZYEZ/2+UIQL0q0uKoOjJchDeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF5IWH6aftL2BATdJNhs8sbB7B4PbQV80+cuVLfGBpc=;
 b=S0yPVXu/MYkDU5vtx6W1OMXxswe440Sm2/bp/p17wMibh5Y10AXFRxvU15b1wGEDuTYY76R3CGVzZEyxL9AXWTniZ1FJuyXR4y9EyM6oyfh7/9L5R6LdQ2kXT38RilYIY96qR1L8qh0NKYoTV3iKeLwudbQN2AuDAWaCwdV1Tb4JkgXO06Oh/QetEg9/JLI+kYWdhd6U0bqE1XBaqhDs85sD5bXQ3wqcuj7fhcYPH70ckQ6ncldPbhbh4ZfYduTJP8AxbIwZhSyxYqgKnukugXxqYqr5yIh0ADtdhgeVn57YjyHkTZb25j8XFdcgyeFScNWLx8FCFkG0n2CGFSpGIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:441::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 03:31:54 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 03:31:53 +0000
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
 <20230103163505.1569356-10-fenghua.yu@intel.com>
 <Y7RpuqbTAM11wVQG@lucifer> <Y7Rq0WRc4p3lCkjk@lucifer>
 <IA1PR11MB609703A614F64CD34FA8F02D9BF49@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y7SMYF8MlzeqDgp+@lucifer>
 <IA1PR11MB609745A8BE83313FAB0236C29BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
 <87tu16rdea.fsf@nvidia.com> <Y7XZ8zY3KIRDlu/f@lucifer>
 <87k021vnmw.fsf@nvidia.com>
 <IA1PR11MB6097336ED90E27E78E069E299BFA9@IA1PR11MB6097.namprd11.prod.outlook.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH 09/17] mm: export access_remote_vm() symbol
Date:   Thu, 05 Jan 2023 14:22:28 +1100
In-reply-to: <IA1PR11MB6097336ED90E27E78E069E299BFA9@IA1PR11MB6097.namprd11.prod.outlook.com>
Message-ID: <87tu15u061.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0228.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::23) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c87e9ab-9b25-4d33-382a-08daeecd638e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YsLb1NvKBuEcbnwroS/9K3JxGafIdApkrB9ss3m8/MLnsj2cWa3grkCbwlVgQEe+p+tzJysCn9e3xsDE6ylkKAE9ZHzAoXTt/TC4V/8oDaKRIeVfasOLKW8vOt1iNk+yqajvtC5G9C19SAI973hqEDYcN4WCkI0KIBqFDvGllkQ7FSX9+CZ+FSs6WbV7//PcVcS1k1BRgyle8edQgJ7oSrPIb5ASDqjwvq0eikj6Dp80xQF9Gos7HyIi3kPxAc8m9ZUjXK0o5Gk+aLObsnVTxaLs0JLXju1BTftZirCl5p0AaW/+fIpPSxPabYc0Js9FVAKabnad9vQUMKAxdSkILJO6wX9GH+Nzt+Y09OkqUXbqP7X0+euC92ya6Iqkle4NsYUzfkyenaz2ieEYxOOFI7Y2Lo0JcOU67+istGLNWRSyxpUPYdEl/ER0R4CuU42gBxWW+/KeRxwgynPMVnvmBtQKW9aGzLuCEp0lovykCc7f8WYbVAYvNn+DDRt6KuWvUDaV9Fk8+mTlpuOTHwQ/b7wJnvvxmBzKgO0Z0yU+0MQ1KsVh0h9WEl4RV0NMa8jQn3jq16JAg08/JB8p7fAXt7SgWtcmP6xaJhF+/E+GtYcYEOuFZ2WDLcWFMar/tUI4WVbQQcVIr82zuwyrmsIg9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199015)(66899015)(5660300002)(7416002)(41300700001)(316002)(6916009)(54906003)(2906002)(66476007)(66946007)(8936002)(66556008)(4326008)(8676002)(478600001)(36756003)(6506007)(6666004)(186003)(83380400001)(6512007)(2616005)(6486002)(26005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ixXeE+CmQsQv8R+HwqrhAEVUVSBkVwur3vOcTirjUV8HkVAwfwJpks67Z1iu?=
 =?us-ascii?Q?n5kYyNLBxLu04ZwaDfseDe/ZvV09pl+fxIVehID2o/al0GKrSq7Zcuxm7616?=
 =?us-ascii?Q?HdLfpYag2Vymh83cUIJeROWTwcWJJfGClHWlp/bKYWBgzWlk9nG2REBAvOzY?=
 =?us-ascii?Q?oocnUO3vU0zQa33aD7zdWGhcs0tPqcGhKW4BaNi7VMgZ/4lJnHv/FXTR/Urx?=
 =?us-ascii?Q?2jphynldEpJ4WB+1sTebqnkfhuWAVG8TSXXCPubx4jksfeap58Su+islLZjb?=
 =?us-ascii?Q?i+qll9KTt3zpvfwvwuCtuJp/WrtrtNnHnQsIGJ2WfzxpBNXhYM7D8DA3XlW7?=
 =?us-ascii?Q?HcDDX8HjzBA1m5rDkFmSICAl1JS60NOM8QFepau9kvVui3A12Md9p/bzrNDS?=
 =?us-ascii?Q?vKB8ke8DyydRTiLmN/1Yy7lZKsN62iFqWt4Ggp1IlJS7A6G758N86SJvKT6M?=
 =?us-ascii?Q?AOfXjI0KsJFxlzooSQWh3WMUhDoaY+B/66+GYXsGkQNpoKF9vXeTdf+lTQjy?=
 =?us-ascii?Q?L8Wjhl1fdGFkCipj4ySm1eFoO1uLQAw94ATewIY0H35u4JklblCKExmAOMfC?=
 =?us-ascii?Q?rkSgDVag+1o1eybc8Srjf9uN9oygkJBhvxVZLM3kR6qA8rd+yvTmBR9THDaS?=
 =?us-ascii?Q?X+cR9oVTDwt4g4TUi+vljnqHaAS8sCRPgHfgPXtecieg3rXudYawba69/aHl?=
 =?us-ascii?Q?eSPE3PJ3AELGt10XEjd+osuZu9R4Mb+KU8OpblAvtgugryP2rFpQdwtVp5na?=
 =?us-ascii?Q?zNU7Apz/PyzHgN/UQ5k2WPH1Moc+qj9HeCE/sr4ALoKxc1x7g792XaNFtWip?=
 =?us-ascii?Q?W0t6h1ns8qEHcNhcf447QFbhiXUe4P2zwTrCbS8E6cFxgqjAQtVfy5214q+W?=
 =?us-ascii?Q?s4qO9mhW+I/m3rm+N2nLkDlaeqQSrpkSWuoYWZAcUmyoNNLjM1OHF7qXpUvF?=
 =?us-ascii?Q?mxtjX7P31Z6GnLQwFxfA1vScLkxPHW0vI60lV9cS/XuLKFcLUaBnfUBvpHqz?=
 =?us-ascii?Q?wLqkBQzkUQD6l0KIeI04cqPiWkCwetmqMAkwDiWkKIsf3uUSDlccYYWUiKnl?=
 =?us-ascii?Q?olgdD3vvgYu1BhitUCCKRZbiKqyDoxgBO2X+OSVfFd7XKRn0DL2POJ7NtZ60?=
 =?us-ascii?Q?ldb5Ux2xfwKxIO/aSH200cHHm1JZ819m6YAchmG7cPVIJHPdiOIUExhPSY99?=
 =?us-ascii?Q?Y7uXS1bIrE2Jc9ASkWVDi+aiaEAQtrShi4y2tZKrxcobEf0dKiuQuevqXBYR?=
 =?us-ascii?Q?XgyYM5Qa6HZpV5QfsC0LC1FaeuL1Mgl+QVSGVxpKZDdeV7/tApQXmPgyLnnA?=
 =?us-ascii?Q?oI3P0uBsS4xmRbYwAlzoYOgPLpGbTrAyytC8FlJ73Fst2Twepa5NZrVxCcIT?=
 =?us-ascii?Q?IkGxCgOsEqPHf6bapseR8KBzJ7gt8FHfWHtmfUN9CMYzvwbDLGiRZvlu6yNu?=
 =?us-ascii?Q?qIIsdUhFBdeK+FtJb6ssNDRyTxRZXt+k73tDPn/sHZU81pDeLBouF+3Pirf3?=
 =?us-ascii?Q?emEPCUQjqkNjC9jnLqrc6JZk4sZNLkxAqEiygcBCazZB7ADzbTwTiMV9MZ0B?=
 =?us-ascii?Q?31jq/AgjlSDorMeJg5yNYZkFBdrolNHK6pie47iS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c87e9ab-9b25-4d33-382a-08daeecd638e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 03:31:53.3880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlcUlrMOOAvKTa4EXFHghAWFr//KwUpUZ3JpZJskzf49hzlvNesevP9Y2EMCQ7VdSxvJ8w0G/jAv6skzZQ6BUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


"Yu, Fenghua" <fenghua.yu@intel.com> writes:

> Hi, Alistair,
>> Alistair Popple <apopple@nvidia.com> writes:
>> Lorenzo Stoakes <lstoakes@gmail.com> writes:
>> > My concern is exposing something highly delicate _which accesses
>> > remote mas a public API with implicit assumptions whose one and only
>> > (core kernel) user treats with enormous caution. Even if this iommu
>> > code were to use it correctly, we'd end up with an interface which could be
>> subject to real risks which other drivers may misuse.
>> 
>> Ok, although I think making this an iommu specific wrapper taking a PASID
>> rather than mm_struct would make the API more specific and less likely to be
>> misused as the mm_count/users lifetime issues could be dealt with inside the
>> core IOMMU code.
>
> The iommu specific wrapper still needs to call access_remote_vm() which is
> in generic mm. We cannot avoid to export access_remote_vm(), right?

The wrapper still needs to call access_remote_vm(), but that doesn't
imply access_remote_vm() needs to be exported. I think the logical place
to put the wrapper would be in iommu-sva.c which isn't built as a
module, so you would only have to EXPORT_SYMBOL_GPL the wrapper and not
access_remote_vm().

> Are you saying the iommu specific wrapper doesn't need to the mm code?
>
> Thanks.
>
> -Fenghua

