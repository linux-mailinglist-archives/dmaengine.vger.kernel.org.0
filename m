Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738896D2482
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 17:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjCaP5T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 11:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjCaP5Q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 11:57:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F7A1D2C2;
        Fri, 31 Mar 2023 08:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680278231; x=1711814231;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7d2NB/MUKAamP8VYXNlStiE1R+uM+pALYBPMMfj5G84=;
  b=MWAR0mds92OAMTdqSuRklS+1bs9oDjH33LpFonerzrAp4wy+BlkSYbey
   yc4z69UQsQnIwyKaYuhsTRybxm14bQf4b+3T0eY7H9hElOFxGai+uIka3
   fM3SE4crcTD6aW1tD+bL81aRHn5nU4IR3nK/P0dVyshwpvmcAuPTUhrML
   EPMwXP9szGu2pUMzHZrFXP4ZvM8V79gUHEIcCOa8agPswvkeRo8BQSxPb
   ECYh8dtZi52I04L8odD0LQoccMewNX4/5a9HeQIgn3nEAmInrh11SG7O2
   UWhvRyJZQKlItQHT6pHUZrJhyHzklo3DvGmRafUKJBAjtqqZMwXRk3cDn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="344007849"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="344007849"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 08:56:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="809091948"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="809091948"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 31 Mar 2023 08:56:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 08:56:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 08:56:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 08:56:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 08:56:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFYYIG7GXpztCWW582dm+PCMksdPnSOpOEF+qB6rnZYwhstdWefYeqlVL2UCyjmOFk9wETnyItlGFXvfsb7qJf9CFh5tz2/AB4lPZ2sLrTc2IvS/bjavns3dPG0uattUkmu16a4z2jO7GKbu80IwuPfCI3hqkhi86u98zE/fZSY8nl32SCZijo6x/38JMWNR7PY0z+/9CyOFrn+XQASoXxd6KRHOg/yl85y0Yh3E5T6R1i5OsR445b1fknkONKW8iDNfj4JJpOaZseX9bCV2y50WDsTGgO8bWo3OJ3ON+M2A5XAFWcl5ThrMLFVxR1MnkCU0g+HW57ID08hRIkwmug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXrC8YEAOjnpnKPlsKQycEuIDIXGHwhli6+lkBzz86k=;
 b=jrD0MkXoonNQ35P2ztb03eqWTfAA7eTyI4BQji2lcNTbUDHlKeO3gWVMnNHBRqQGDctdWBfP9GkW/2ZpEnS6URcVRw3ah0DGpQJtFSiWoix2QXzZ5BaMVBwk0vOP1CEXP1VuoxSIcsvIZXTreMqZ0UcZmQ4/jlzws2meev0JU9UBaMMPPosceU9L7YrSGgu9Q2H1k+Z+xGnUIHFoMjd5crH/iIaqmNhNRDCkDw0TTt0WjbFna3YMV3MVNTr7Npdlfo7Y7tvutLviLg7b5vLtG4OhamRjkIZ4VsmgZqPWsNQokgMqgEdOkOWw70UqPeYCc2eVFFq9hUtyafhVuBhELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6103.namprd11.prod.outlook.com (2603:10b6:8:84::19) by
 PH0PR11MB7521.namprd11.prod.outlook.com (2603:10b6:510:283::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 15:56:26 +0000
Received: from DS7PR11MB6103.namprd11.prod.outlook.com
 ([fe80::1f7a:38c7:8309:d17d]) by DS7PR11MB6103.namprd11.prod.outlook.com
 ([fe80::1f7a:38c7:8309:d17d%6]) with mapi id 15.20.6254.023; Fri, 31 Mar 2023
 15:56:26 +0000
Message-ID: <2ffc3330-f3bd-da65-1841-71dff2ca90b7@intel.com>
Date:   Fri, 31 Mar 2023 08:56:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/3] Add descriptor definitions for a few new DSA
 operations
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     Dave Jiang <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20230303213413.3357431-1-fenghua.yu@intel.com>
 <ZCbKNtJvGtwwrPv+@matsya>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <ZCbKNtJvGtwwrPv+@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0010.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::23) To DS7PR11MB6103.namprd11.prod.outlook.com
 (2603:10b6:8:84::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6103:EE_|PH0PR11MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5f5c9a-1e26-4d85-73bc-08db32007bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZVaBInUUz9L48AwYLaARe2BYBw0V8F9JRx4vePX15IgKpU8fwj9K7SDbMFiXroih/oljiqVDffkBnSFxF7sgr2DroVzVvfbilq4UH8+lHJqN9gvjqj3QH+KcWRbEJKNIv1EI/htkrMLx3BExTlDEvtfYA5FVyzFywpIuATWLQXJPEtyqYhDzop6gaQ6KY2DayYAGz2JqwWAYhGUsbpP+EdJOlY5F1mObCdCIrQEVnYe+FUqVNfWP79tX+EhJRCKZcn193lm3hNlX9y+HW13kjkwPgXyRsA5nQF2aIpyiM4PE/Ms1shZ0Za9D+qVv8ZhxKxTZUgoSxFL2HU9LYSbN/Vryqw3XcLKLxJ0KAMNZWIIAkqQLw9q0vpF5Zp3yBa5irstsfI4PNnmuLkYqNhZM0+0abN4Jz6LS6u3sYMwQ9jmAlYfZzfdA9uBYpsAVk1Vnb6SWN2MNXfjrgHjuI2a1saROwj5zxnZZicanZ43K77nkl5samXalVQnSs3EPP3ZZHMCSfFkyarZadJBrafpkousXxlpcKhgCynv6omV3+FY0bl4MJnkk9pAjj4DqTztUQwThE2dx23Zy6os4xI/Qy7xenfz0FF8u+PmwXbX3sGamxNlnlHSHUwAQT6bYwQoOASQTfbSAArfQAUpLkn3nEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6103.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(31686004)(6916009)(54906003)(8676002)(66476007)(6486002)(66556008)(66946007)(4326008)(316002)(36756003)(6506007)(26005)(6512007)(6666004)(2616005)(38100700002)(186003)(41300700001)(5660300002)(8936002)(478600001)(53546011)(31696002)(86362001)(2906002)(4744005)(82960400001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czczVFRBa045MmRBN3JuSWNiK1EvcGxtS2QvR1VRUlNxU2dGOVpxeVF2QXNw?=
 =?utf-8?B?NkxoMGVkc1VYaWtSWlF4N0o3L3pyVkUxN212MmlqM0FkWDRLT3dJTFplSHlV?=
 =?utf-8?B?MGNndDFZSk1LcDAvYXVaQjFvVUhZV1YvdkN6QWUvcm56THpPSXZjOVBCbTYy?=
 =?utf-8?B?KytmQm95Nis1ZUdTblQ2ZlhubVIrUm9NblZZZzVvR3YxL2lHRjVxUTczRlRx?=
 =?utf-8?B?VjIyL0k3Sy8zK3M0bERYSDRqbUxGdmxjdkpIb0lVZ2xmWm1WZ2FqeWZZL1NS?=
 =?utf-8?B?MFNHa0M4Mm1zbEdoRkI4a0pMVUxYbGw5U3hwTFZxSUNqRE5NQ2s2dURLZ1Uz?=
 =?utf-8?B?bG50SjJwU2VnUVJsZjZkaDlIUTB3aWplaFFjZWJrY2pINzE5MzAzTDRVQk0z?=
 =?utf-8?B?VWEzalgzRVc0QW01LzY4aHVSUm5yNjlndXBVbURTeE9xcFpEUHpybUtXYzQv?=
 =?utf-8?B?YzJaNndtTVRVWUlGb3ZKWnZadEg1SkFwdDFzWFhJcm9HVE55azZCSTdxT1dl?=
 =?utf-8?B?SDFuY21GdWwyaVFZaS9WVTdYK2RJa1RtTUpkQytrelpUZmY2OEFBTU1uWmN3?=
 =?utf-8?B?VHBMeDY3ZlNlbUI1NkZmNzZBMjhzNHVvUXBmUEduRmR6cFhETFBNb05TYjBL?=
 =?utf-8?B?MXhmQVkvb1lrajZCK2IxamY1SUlyUVZEVndjcTVleTlQVHpxcFBNRGhHYkNO?=
 =?utf-8?B?VENmNmUweHkvd0Z4ajFOZjN2ckRQZFhmdjFjeHJTWjJhaDQvSU53REJvcWJ6?=
 =?utf-8?B?cGY5bUQ5REtlc2xUbFFOMnkwTXlNTDl3YXJlMVdYNUNEbFhGZDkrcTNHRGR1?=
 =?utf-8?B?VC9OT2gzckRIOGljbHVGOHN5cVM5aE9UU0dMUGhGQlE1RFN0bmo1ZHVjMnhC?=
 =?utf-8?B?NCs1dVpGbWduT20rZXFyczdQNG9vd1lCcXdSQUJhbHhyalc5Qit5VlFoRWFS?=
 =?utf-8?B?U0RqV1V4cG5DVHU1Wlo3RFEvOFIxNkpRQ0FSbHpGeXJLSjUrczZLV1VOWjRi?=
 =?utf-8?B?TzdsTWNVd01uMGpWVWRYc2YwSlVSaHpjOW9NUGZZVzE0TzN4UVhRRGxhU2dX?=
 =?utf-8?B?b3gvc1NkaVlmS2psMDZGckxEMlM1MmtUVGFnQkk2ZWVqZ3pKRzNJSXJyZi91?=
 =?utf-8?B?MHZTdW51Mk1DMTJlc2JFVHJUQmwxLy81SnBnNnB1UGRkUzNjR1NPN1VldytN?=
 =?utf-8?B?TklnMTRkRnBOaXRacytvNUZIOU55QUFyM01kT2I0VVdsVjlTcjdXQ2graUNl?=
 =?utf-8?B?RkFUaTZCcEY1TE9vUysyQTBscEZRSWU1M2UxbXhYUUxaODZaSVZqRTdyZzhH?=
 =?utf-8?B?dDBQWnM0MHFUeVJ2MkJZSWNjOWdKVUpXUlovUkMxaCt5MUsvUlBrSmkyRFZm?=
 =?utf-8?B?aC9tVEpnTGNFK3lUbFZ1TE5wRndiZVMzYWxaVHpYYTlBTkJEWkM2eDZaRjBJ?=
 =?utf-8?B?ajhOL010WjZzTUhMbkdMdE4xNlF2QnJ3RytrTVZVZXJEajJMTzl5Yll5Zk1w?=
 =?utf-8?B?SHEvak9CSTIrYVJ5b1FuSTNSNWZoSys3M09aOGF5SkFoQ1JZTlpkZFFRd3JQ?=
 =?utf-8?B?SWs0TkR5eUlrK3ZnM1pZTGR4eFhYcC8vTWpqTEpVeFZYMVNNV0IvQjd1ZWFi?=
 =?utf-8?B?MVVMeGFnNlRhVktwdkFLcVQzU0pFVnpZaTZoVm5QdjZDNWJQU01NN05SQ1k2?=
 =?utf-8?B?eUx3RlBtNG9jUENsYml0WW5HbHZDZ3JqamZSanR1UG5lZ2s3aHhIdzN5T1gy?=
 =?utf-8?B?VHZYNW9RWDdiTCtoSTdCNHVWcmdrb3ZmZVdpcEtwbUgyUW5OR0ovTmJ3NGFV?=
 =?utf-8?B?dkRTSkhGaU9oRDUwSzAvMDdkd09BU3FaNWcvT1haOWV4RGZHQUtia1JQMGFN?=
 =?utf-8?B?NXFMQytRRkJNZUc1bURkVVBmQW5HdVh6bFpUR3hmVDNKeGNzT05RR0Q4dTg2?=
 =?utf-8?B?OGQ5SVNidkpFYUNlNFU4TE91bHJNYlZqUmdRdGdKZGVVUWV3U0JneEVqdlNa?=
 =?utf-8?B?dVZPdVpnVlBQU20rSHNpRFdSU0t6dlZBc1Q3UDZURUF1aFRTOVZSYVIyZTM5?=
 =?utf-8?B?WWhpbDBXVXRWSWVCWHNzSFpvQkVJdzcvbXlwSkU4aU56ZHJqc0xBYm9Ranhk?=
 =?utf-8?Q?kC7KeJtwDLcvyBhaGYnBPnzj7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5f5c9a-1e26-4d85-73bc-08db32007bd6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6103.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 15:56:26.4185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8J9BhdREcPiEmW8FAiYiTBdBwq9dEAGeZh2qXyago5QjRk/Q60DA7TSvhuyR3RHcshBqkB9nF/Qequ1MOvIkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7521
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/31/23 04:55, Vinod Koul wrote:
> On 03-03-23, 13:34, Fenghua Yu wrote:
>> A few new DSA operations are introduced [1]:
>> 1. Memory fill with 16 bytes of pattern.
>> 2. Translation fetch.
>> 3. Data Integrity Extension (DIX) generate.
>>
>> This series adds descriptor definitions for the new DSA operations.
>> With the definitions, user can issue the DSA operations to optimize
>> corresponding transactions.
> 
> Applied, thanks
> 

Thank you, Vinod!

-Fenghua
