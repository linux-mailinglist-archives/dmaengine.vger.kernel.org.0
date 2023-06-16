Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C56733C84
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jun 2023 00:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjFPWmU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Jun 2023 18:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjFPWmT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Jun 2023 18:42:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B8A30FF;
        Fri, 16 Jun 2023 15:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686955338; x=1718491338;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7a3TirIk0DgbzMhkxvJ5A/R/k8z0zLStwpWEjALUqw8=;
  b=ZZyWLr9oTsUeZvdk1DufyU5foWKOYj3rsmOwKf7xVF02usXVaTug6dGM
   as5orS6wII5/KNcRYufkUnkH/1PppAbAnJmI1XTyKXLDi/Na8VlJ1FxeJ
   1Y1Vgx6GcrvjxQ2P+3my33uTN3GTNpe9xBkx7uncaH9dieZ2BC9mdk6WZ
   bz4ygZLxRsPpF0ufVFkz4c/xa1ngxIWL23XrL+YkqXirn47ybRE0bwP/L
   y2NRaRXVBEQfb/GPVXJ5OsoSYCTM5vjl04QnFJVgDLxtf8ayRPlRpcJSl
   pEK4p5c+nmp6m7b3gMmzFmS+N+vnxcmwB24RPn8Io4pGsGDQ+r0BqwuvQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="359338642"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="359338642"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 15:42:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="959773456"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="959773456"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jun 2023 15:42:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 15:42:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 15:42:11 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 15:42:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODI0N0owz7Ncr5+6KpE8EaSySeyYp4/tCWFORcMBdI/lSyZ2BScIsiWKlywXH+SSEcgaSFy7jOiaRt/4kcYx7Tz6d1wtokhinkJZIzGZFreM5rLRFfcqxWrdnHZwa1KKERlbM7Vh6r92nnbUEoMreQxxtb/HLokn9qvwxUT540o9TcbV759mwPW8SFnD602vZujDBvuDSnvNOQaNMKAFef6OOVZng3mwmCo2GcrEU5GVqvHsdLr/+TaB6LRSQt6Y+fBOgVLxwXXVl6inOfef8wFzNCYjhBX4Id3E1+oRwFsYpvvfe814FvX4FTvpe4DwnKfCc3jY0PXLWqfmMUky5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+ZVyKB77NT9ZS69gxJhnEaJremH5dJkxnmSrhlIPZo=;
 b=ROU8ETRUUyWMENaITmzrzvmAd4AMdbOyNF5bZN5ag8GZnbSY27CcFxyDzfPNtnZt/Di/MNfRJKe1Ooa0dlcd7qoVSbKO92I7mbfSSPJzlD98Y2JbdTeSfALxWRv9lUjBEyxdEOrvAzD+EtFnuBq7tGxNXukbFvjucOw6+5JWXqwjHkfouY6JN0HZhWPCEbffpCfiygtU4DU7GTtDd9t5DgAkIHM6MCgEBfAY3zEq7q1k4gDKYWBHToZ0LlGD7aT1abjkRjciJOJCeua/GF2kMuUzX5/A80TpvsR9JBBgX4AyeB5MMZGMbN9fy1rO5YNWWoBIkL03r7Vb7kpeVejZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB4999.namprd11.prod.outlook.com (2603:10b6:510:37::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 22:42:03 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 22:42:03 +0000
Message-ID: <cdd0b117-013a-8bc2-9cad-be8ac1a985f2@intel.com>
Date:   Fri, 16 Jun 2023 15:41:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v3 01/57] dmaengine: ioat: Free up __cleanup() name
To:     Peter Zijlstra <peterz@infradead.org>,
        <torvalds@linux-foundation.org>, <keescook@chromium.org>,
        <gregkh@linuxfoundation.org>, <pbonzini@redhat.com>
CC:     <masahiroy@kernel.org>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <nicolas@fjasle.eu>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <vkoul@kernel.org>,
        <trix@redhat.com>, <ojeda@kernel.org>, <mingo@redhat.com>,
        <longman@redhat.com>, <boqun.feng@gmail.com>, <dennis@kernel.org>,
        <tj@kernel.org>, <cl@linux.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>, <paulmck@kernel.org>,
        <frederic@kernel.org>, <quic_neeraju@quicinc.com>,
        <joel@joelfernandes.org>, <josh@joshtriplett.org>,
        <mathieu.desnoyers@efficios.com>, <jiangshanlai@gmail.com>,
        <rientjes@google.com>, <vbabka@suse.cz>,
        <roman.gushchin@linux.dev>, <42.hyeyoo@gmail.com>,
        <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <john.johansen@canonical.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <llvm@lists.linux.dev>,
        <linux-perf-users@vger.kernel.org>, <rcu@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <tglx@linutronix.de>,
        <ravi.bangoria@amd.com>, <error27@gmail.com>,
        <luc.vanoostenryck@gmail.com>
References: <20230612090713.652690195@infradead.org>
 <20230612093537.467120754@infradead.org>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230612093537.467120754@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::21) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: 425b5faf-d7dd-48df-c3a2-08db6ebae765
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cePV/U0+oC2aw2qbg3RcPMs8uflOLw/g5dzlwBqqby0PEi4zvhr9QJQluOu8lUuiaHmeF1whSHz75v+/IZ0CfKGECNJkbXnAE1i0RO9YNoCXwDSr2SKukX4NxicP/FRHPZnf7+WgxQKe1p4tcVSs64WA07qUxC+PQ00DNRG0GEGKxQfKI8b6e44ydA0yg3FwavBqbp2q+YAnvty2q0DJkMjfbQoAPu/dDVcue9Mlp8+bIzKprK68vloWFQo1QLpLGD2Ib/wcFpeMoLB8vr6i0bBshnw0c8jMtuY0rgrjJlCE/doAIpM+pqYioWsM9EfhwFoaNKowpdUNnufxLvMUXvTMe8yzmz7wSlTCYX+oCnLsyJK5cM9OuzkAuZPZx+qwDi9oDWsdLqBYAs+bHp20EIJ9IHZztxjKd30T4BM+8pDOHBTLchC4s+gZMGAoBioeKoiQ7LeSptM5xQlJq5AeRdXFevDhLvpLB0Mh1Z4nHQKmB0hAqIMPy8ntJTn6Qw+E8efEZ/TJLDicLf2JjZSTbNAHRHhutfEcvacal5B93mVqExxza56ViOPatiItZA+Vvg0crlQtqqVmBEeXA2AFr1t3pvxgzvsFOXwyLntxz3ARW2Tep5WFsZv4e6DJNgTzicpby30+FhBwxVo8PE6Mpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199021)(2906002)(186003)(2616005)(83380400001)(66556008)(66476007)(66946007)(6666004)(4326008)(82960400001)(41300700001)(6486002)(316002)(31696002)(86362001)(478600001)(38100700002)(36756003)(31686004)(44832011)(6506007)(6512007)(7366002)(26005)(7416002)(7406005)(53546011)(8936002)(8676002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFMzc1F5cHBTSWVqQmFtOFNXY1d0dWxqVURpRjV1cUZLbGlTOWpHVTNZdkNr?=
 =?utf-8?B?b1h1ZUpBWUxqdzdZVG1xSzBCemlhN25vSTl4dDVXK2lzVjkyTVpsTFV1aVRi?=
 =?utf-8?B?WkhTeURjM045Y0VUUDRsZ2xlOG83U1F3VzIzenBBeDBLWmNTNlVZb2JHQXBl?=
 =?utf-8?B?d01DakZ5bmhodjFwUDMvY0UyZzlWdDJqVy8weFkzbHEvdVlld1hTclRwMElr?=
 =?utf-8?B?Y2pZWkJScXVGSlFkZk5XNE11R0MrazR2S2Z3MTJhSWN4dEEyWkRPa0tLOVp0?=
 =?utf-8?B?QUx1NzN4bnNHZmpNWmpmUmVOcC85cTNBc0lZL0dNSms2M0M1NEpHS0tYKzJ3?=
 =?utf-8?B?V1kwakFQSFZMb2tQbUYvdmlHTVBveWo3RTZvemtBUHNVR0VKTFE4eStIU2Qy?=
 =?utf-8?B?dXdsTWFkSmJveDB4RzI0UUxFWVpCTjVwWmJSVHRYVWdST1QzNERGaUgxUlBn?=
 =?utf-8?B?cncvbVp4aVQwQzFyZVNIM0w2VHUwNngxcTNRU004dmhsS0pHOHFCQitjN21W?=
 =?utf-8?B?MXE0RFR0VzNFaWxQNWRyeXBzR3pvemtSU0RYZ0RGRU1lVnZJWW80b2tsczhL?=
 =?utf-8?B?QjBkK1FmV0lPM2p5NSs1YWQwZ1JhVldRSVFBNkpCMnk2d2MxTUNsTUVMWU93?=
 =?utf-8?B?MjhSeWZEcTZHN0dVblkybzJLZ2IzcThtWlBtaDE2OEtja3hXUTlhZ1UzSlg5?=
 =?utf-8?B?akJWbHBaeEk2dnpXYlRJTU1SZEkwbnJ0eWNYc3NtcWtqWU10TkVvdjBwdG9R?=
 =?utf-8?B?cXhRNnZmaFFjcGxPdzJXNDkrY3R0djNWajIrdTBZTElBSjJKVFlibWRCTzNt?=
 =?utf-8?B?M0w5S1BUbVY4eEwxd2kzcFdqckhXSE1ONHZnVHN6aWFxVkxvbmtDeHhNYVQr?=
 =?utf-8?B?blhqTVNyNmk2YXhxL0Fna1ZvSjdFRVlROHBHTkVDSTRQMlhxYy9EVmtqcVNn?=
 =?utf-8?B?SVVEY2xnV2x3U0dBdEVrcjh4QUJzUnY0TUMvbG1wRjM5UUoxeW1RQU9DWDRp?=
 =?utf-8?B?d1Nhek1QcW9hL1pPVnRRNW9nenJPZ1JJcVBXVEJoNUlyS0xYQ1pYMUlDL0lE?=
 =?utf-8?B?U29Md0VvVXMyUTV2dFE1VVoxZzNsLzUxQWdySlB0V1JaWUxMZWQ4WWJTUEJu?=
 =?utf-8?B?dlRZbXh3dVB3enloZ2NhNmJyTWtyYWdrY0k3SzMzTmF5VnlzdVdBWjhPbkZI?=
 =?utf-8?B?ZisxSzlLL2JadWVvb3NqZFRCSEo1bW1nTTVoaEtEMVZqQXVWMjdKMVFqbWZQ?=
 =?utf-8?B?MVNqN0wrU0c5NktkM1U3a0Jhdnlsa2tPWlRzRTRoKzRKYW5kRURHaitoeXIw?=
 =?utf-8?B?U1VmM3lHVFNJZ3Jya3NKNFBocDJsOFkvT3UzRnVvdjgrK3hWalNjYjhpMnFZ?=
 =?utf-8?B?YlM3OFpBY1VCOGFYdmJ3cDRUL2p0cHZNLzhNd2hhcmd6Uk95ZFVKaktBQktE?=
 =?utf-8?B?YU1mVWUrbEljSTNEeXdNQzBHaGoxNnVqMVlDTktuWU9Ec2xRSExzY3hXelFr?=
 =?utf-8?B?SnJ1WGlxMjMrNjNhbTdYZXVoNHBSd1UrZFB1cFVIN1ZWSmRqQXh0Q0Ywck9m?=
 =?utf-8?B?MktwSmVyUHNYUUdiRjRsbHV1TWRjYnBBVCtnc29jcGxJbUY2TjRYb25tSnI0?=
 =?utf-8?B?NEMrM1ZRcFduUTM1MVIzNXhKWnFGQTdweGlzOTBRbFpsQmQzbHVtQXlSTFhh?=
 =?utf-8?B?WE9Uemk5Lyt1bFRHdlhJUFBDRDJFSzBVK2w4Qlk3bndKQmVTb2sxSEwwdy90?=
 =?utf-8?B?bzM2VkI4dGwwekJ4Y1lyTkRGeVg3Qld4SEZFR1liU1Fac1JVc3JsTXkyaWp2?=
 =?utf-8?B?c2xNMGkwOHozMENSU3MrL1BFK20xNlExMGU5aTRoUG1JY3dOMFhlSkswU09Z?=
 =?utf-8?B?Q09BL2ZTTXpzazBsODdZMGQ5UTFiaklHM3k5WEFoWGFobTBKUVYxd2pYdmEv?=
 =?utf-8?B?NFpzQU5OSzBSZFlVNC9QQ3pOS0hEYnZmcHNEd0lKZG01OW85alA2OHBaVE0r?=
 =?utf-8?B?dkozWFRiekQ1Z05kVHMraU1XakRScXhwNzQwSnlwa3hRdm5ybWdrbTVYWUFn?=
 =?utf-8?B?bHIvdU9rVzUrVVBuN3ZzMmNVM0gyZTVsUWNUTGRVSTY3bmhIbkRpTHlqTG1K?=
 =?utf-8?Q?ZlGNr6xdD96jQKAIE+9jUcADQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 425b5faf-d7dd-48df-c3a2-08db6ebae765
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 22:42:03.2096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hhGD8cQq5KDluag13cRXMq/w4XS8ROOSeKXGrnrFZojAyOSGayiw5ZcYMzsaTW6uCM25Bc8rCTmuj7R6oxYsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4999
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 6/12/23 02:07, Peter Zijlstra wrote:
> In order to use __cleanup for __attribute__((__cleanup__(func))) the
> name must not be used for anything else. Avoid the conflict.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/ioat/dma.c |   12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> --- a/drivers/dma/ioat/dma.c
> +++ b/drivers/dma/ioat/dma.c
> @@ -584,11 +584,11 @@ desc_get_errstat(struct ioatdma_chan *io
>   }
>   
>   /**
> - * __cleanup - reclaim used descriptors
> + * __ioat_cleanup - reclaim used descriptors
>    * @ioat_chan: channel (ring) to clean
>    * @phys_complete: zeroed (or not) completion address (from status)
>    */
> -static void __cleanup(struct ioatdma_chan *ioat_chan, dma_addr_t phys_complete)
> +static void __ioat_cleanup(struct ioatdma_chan *ioat_chan, dma_addr_t phys_complete)
>   {
>   	struct ioatdma_device *ioat_dma = ioat_chan->ioat_dma;
>   	struct ioat_ring_ent *desc;
> @@ -675,7 +675,7 @@ static void ioat_cleanup(struct ioatdma_
>   	spin_lock_bh(&ioat_chan->cleanup_lock);
>   
>   	if (ioat_cleanup_preamble(ioat_chan, &phys_complete))
> -		__cleanup(ioat_chan, phys_complete);
> +		__ioat_cleanup(ioat_chan, phys_complete);
>   
>   	if (is_ioat_halted(*ioat_chan->completion)) {
>   		u32 chanerr = readl(ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
> @@ -712,7 +712,7 @@ static void ioat_restart_channel(struct
>   
>   	ioat_quiesce(ioat_chan, 0);
>   	if (ioat_cleanup_preamble(ioat_chan, &phys_complete))
> -		__cleanup(ioat_chan, phys_complete);
> +		__ioat_cleanup(ioat_chan, phys_complete);
>   
>   	__ioat_restart_chan(ioat_chan);
>   }
> @@ -786,7 +786,7 @@ static void ioat_eh(struct ioatdma_chan
>   
>   	/* cleanup so tail points to descriptor that caused the error */
>   	if (ioat_cleanup_preamble(ioat_chan, &phys_complete))
> -		__cleanup(ioat_chan, phys_complete);
> +		__ioat_cleanup(ioat_chan, phys_complete);
>   
>   	chanerr = readl(ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
>   	pci_read_config_dword(pdev, IOAT_PCI_CHANERR_INT_OFFSET, &chanerr_int);
> @@ -943,7 +943,7 @@ void ioat_timer_event(struct timer_list
>   		/* timer restarted in ioat_cleanup_preamble
>   		 * and IOAT_COMPLETION_ACK cleared
>   		 */
> -		__cleanup(ioat_chan, phys_complete);
> +		__ioat_cleanup(ioat_chan, phys_complete);
>   		goto unlock_out;
>   	}
>   
> 
> 
