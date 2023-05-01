Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEF86F35E4
	for <lists+dmaengine@lfdr.de>; Mon,  1 May 2023 20:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjEASi5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 May 2023 14:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEASix (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 May 2023 14:38:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0471986;
        Mon,  1 May 2023 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682966332; x=1714502332;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fnSXNicqRaAf/lDuQ95cfep6naWAgLuVKMjjTZJP4Xg=;
  b=hBKgu8M2SHPHN2HGbcGf9p8+oddlbRnfF7eU4IUT6VHIofbLJsMnHe2b
   0Wl6lSwRY3+bEpud6TCz4u5160jFvZF4vLc158gigx5jenfvGrS7+6vwv
   42x8j6AfpmI99A+8XAKJloJo+R6iml2oVobzKy9yE85pQKbIWa4jN+5Ig
   6zsZCBSuk5aOHuDNgUblwMjtUB85oNDYNBsBEOMCe7zrNnLF0Dq93yiyH
   fWYVilz6k+vdV00IVybyUbWvgLkt2AnH7M/cQdCweWleXperl2kyuNSkV
   3sUG5b9OdoMYgHjHAUGVoGTXT/kqOTBKKfomfi8mWz0kZc0smBzmsykpB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="351179221"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="351179221"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 11:38:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="807529995"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="807529995"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 01 May 2023 11:38:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 11:38:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 11:38:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 1 May 2023 11:38:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 1 May 2023 11:38:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkxosQcYMKausW3ITG6ckdNs7fMNO66n2DEjWUD+QKuHKNYzuGaXYViBjzNG641nHOk9zQE5GEHS0e6p/sp40DgqK3F0SDY4zCZoe48ffDBYccoykoMKVBZ2zeqE7yDViPDRwAm8yynvnDx4RFncvslbOLCmHRm39HIJgxmFsmavMNNwfOMQ36jYntHb8mo/rIpXS6kBtYaW1HLu0DpbxLIc/2A1p9tNOrbEq4E4XPF+DPpmomdxCtA1abr5VrD/tKu18H7/rvCIzrPsJZHnB7Up5u+uTPbscNeV7nzZtIJA1MINUGimBTLRdIlT73csapfvg1gfVsNreuhaXRm+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sa6BvLGg+gFjnH+3s3ESLV+wiWMBfQ3M1a8E94QGMlg=;
 b=HTi5pOlqHoWI0CqNnoNMUxGVoi8/UC7OlwXJgTUvqQT3z6GaBgxTQZqeYb34vc81fPdJEjmc0HOWBhI1mixKYU27xyuvCJSy6PVGdrcuw/rebSomh8ueCPcGhYK4y1jdVexif7UvrUNePK3PvNbZVApwJjMxUCw/Ds2Te4KwKbh9j9CpfE29t6zMo1Lvy439Qy0RLATcbPMsf+ZATY8lB8K12EVwiQDyfX95Xl/yPr0OM5gHMfi5Lrk2aU0sMjvaLFN8xGzgY2hTsSSI5FrinjBWBq910Vm0dK9RB+JS+ehpouktrER5iT684eCHVvqWgOAlw5Vq78YH4j5ipCxkjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 18:38:46 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::bbe8:5390:54c6:b0e2]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::bbe8:5390:54c6:b0e2%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 18:38:46 +0000
Message-ID: <e235d406-768b-71f6-7f1b-828087cd37e3@intel.com>
Date:   Mon, 1 May 2023 11:39:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 03/15] dmaengine: idxd: Export drv_enable/disable and
 related functions
Content-Language: en-US
To:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <vkoul@kernel.org>
CC:     <dave.jiang@intel.com>, <tony.luck@intel.com>,
        <wajdi.k.feghali@intel.com>, <james.guilford@intel.com>,
        <kanchana.p.sridhar@intel.com>, <giovanni.cabiddu@intel.com>,
        <hdanton@sina.com>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>
References: <20230428205539.113902-1-tom.zanussi@linux.intel.com>
 <20230428205539.113902-4-tom.zanussi@linux.intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230428205539.113902-4-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::23) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DS7PR11MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb5bb6a-6593-4e18-40c0-08db4a734c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InZI42httc6YzcawE3z8JUj3e0l01fXqI3y2vktBzgv17sakhBdkGnpM9mF33OyvOvj3caWOzihUpZ6OCeaGSIAE1gptxJCUKdxeQh9oDUWis9hoq3R5/OpwDodOhZpYvydnfnDvVrJZZ6cAVeZfjd8hUL+ttuZBVMwPNg5Y6CXMNCVTX+7NY2//wINYEY7oOUG78D02SfHOVl1r2iTZBDZZMwEFJ3KnSHgk6etfesHQwWmixXSSVJaOgduL3nTxOpUYh7lRyRxTxPDhm6x+gYT6TvaqeN7fZtAoMGrABm3AkuOlP/PUH36CSTOdFrXVDpxpWb8UJP+791i/6q7cr8q6XFFiQ+R4zYuxIFVL804ETjohuo4F+h1K7XUod0KqZo8B9qfkalkBYpG/quf/Mel6HqsLCVK4N7eyWzgvHgbHTbrg3jBh9+g1dshZ1RsxEXfx9ePIxiYJtbaxVRT0oG0J0G06z4J4tqkb8XbGA7+8l58KP+c0ke/Phm9+7SexEw/U1UwbBJ7D/IucfQJx9+M0fnbuXqJCp/HDmrZW+j7JM8CqdioWGvONekRYnDBfYuHdhkEvjXiSRsPKH44K+E4ktYgMwgu/2IVFRWRcwVJJd+xnuc925iYlwjA/Y9v3H1RYc5yA3d6KHBuo+nVnig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(31686004)(31696002)(86362001)(558084003)(36756003)(82960400001)(38100700002)(2616005)(6512007)(6506007)(186003)(26005)(53546011)(6486002)(6666004)(478600001)(4326008)(66946007)(66476007)(8936002)(41300700001)(66556008)(316002)(44832011)(5660300002)(8676002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2EzcTJYb1JVdnB6QU9xOHRYN3dsTTVMQVIzeDJnOFlmdm1kaHFIcFg4WWF1?=
 =?utf-8?B?RERCUkNMaitzTVZEbVgwTmhYdGxUbHlVSmU5OFc0ZlBpNDVib1dBWHVsUVFW?=
 =?utf-8?B?cnBoTTdudmpZWDA0Um9IbnRodldRdzV3bWJvYjFjbzA0dk1NSUJFMEh0bUpG?=
 =?utf-8?B?U1FLMXVvYkdjSGgzdEVzeUNRYzBtT3lpU2lDS2NPR1U5TThROFJaRzRQclAr?=
 =?utf-8?B?ZHBOd3hhRUtRVmxtSmpOa1BGNTlTb2tzMGtxc0ROMW0rZGNrRmxONlhDbUM3?=
 =?utf-8?B?VDVmQ3BSTVJqcUl2endCZFBZdG84TFFNb3R2K3BsU0RlV09yY0gzY3V2NGwz?=
 =?utf-8?B?MVhOYjlNcUdEV0tGTnNVeElkeGdiRWdSajNUNStIYkpJMUtETW80TkRIZGlM?=
 =?utf-8?B?OUlTUWdadmN6SWNTZzU0N2oxNUFaUWlhaFpKZSsxc0cvTTlvMkZVSzUwRmM4?=
 =?utf-8?B?c1o5cTRvZ1Q4SW9oemVwYjIrRzlLbmdWMW9GQ3VwSDAxK3ZFWFhjZnVid09K?=
 =?utf-8?B?aXZzQWRDZVdBS3JXUXBQcXo1UEEzZmkrd2t6ZTFGN1JUQ09HY2lvVkVYVVBa?=
 =?utf-8?B?aCtrbWcrRzM0NWpCd1kzdlI1UHkxSVdpK0o3VDd5QUdvMm1sS0VMdDV0TGky?=
 =?utf-8?B?RkNFVkxocmRGTFRUODg1T25YVGFNQ2pwcTRhNm82a3JJeEdKMG9XeDM2N0lU?=
 =?utf-8?B?MXhRYjF4Sk8zWjY4RFJBaklkcXRaSHZkQUdIbUVlenJrSWx2dlR6aFY3MXJz?=
 =?utf-8?B?T2tqWG9uWnoyWlU1RDhSSmNmbFU4US84dFdieW5KR2hqcjByNGdxOW53V0tu?=
 =?utf-8?B?V0oza0JXMWVESm9abFhWamhoWWxEcmFiYTVudE95eVo2LzhhbW55N0psaCtk?=
 =?utf-8?B?UU1mcWtXTXVhMVhxS1hiRkhldXpDcFJPVjdFVFZPbldIMHpyaEFhVzVCUlFn?=
 =?utf-8?B?aElNK0tDa09DMzFNdXVDQktBdWJZYmhVVXJQQkl0dVJTdmJpREdTUHFPNkxW?=
 =?utf-8?B?R2RUTGJIN2FTbmlWblUxMzZ3a1hLKzJUdUFZc0ZpWHpGZzFQMlRVd2UwVTRI?=
 =?utf-8?B?WERpS0tibWlsZ3BwRzNscm83QjVTbHFLVVJ1cTdYV1lyVjhvQ1lQTTNTSjIy?=
 =?utf-8?B?Z0kvbnEzT255Yk5pVGZPbzF6Y0cwcHZ1NHJpTC9YaEZOQVpYZjBPUDMrTlJx?=
 =?utf-8?B?OEdKc2hqdDBzSHZlUngweHJEV0pkTHR4Z2pHNHFRYmNvejZGK2VjMUhHZVNT?=
 =?utf-8?B?VTVjMXJEOHF5MnJjY0tQRUdrbHJyT2ZuNVU5cGgwemVZaE1NdDRCV2gxNllr?=
 =?utf-8?B?MVlTQkZiN2ZQQjBvcFJLUkZEWVhEd1dxL3RyQmEzdkJtenJab21iMmdadjlr?=
 =?utf-8?B?TldBR3NQL0cycE13Q2M3UkhxVnpkV1k3MDFra2tlaE5vL0IvNVp3VVVwaklB?=
 =?utf-8?B?WW5HTlkrYzFXMGVSTFBGNG9mdEhBVHJyVGc0TUNXcjc4aWdkNEJyOW90aTQ5?=
 =?utf-8?B?bWU4VXcxeGRsN3BUZUtUMGtObEg1bTZZaTdlMGhrUzNaRURCZzZuOWVjL2Np?=
 =?utf-8?B?cmhNVkNUdFIyM3JpWVpWbzBEUlN6am5jN2pXdDhKSjZRUENYU1hMUXJublcr?=
 =?utf-8?B?blV6ME5Wa1lIa2hKRFN0Wlhxc2RoQitqUS9YRFFuMU1pQ0dYNHFIeTE2S1FO?=
 =?utf-8?B?RzBidDZLNzBwZ01LVzRrbGE4SVlkR2tvRTMxZ0hta3FOVUZIL09Qa1hvWnln?=
 =?utf-8?B?VWFGK3BQVUVabzlLSWpCcnlndks0NkwwUHplcHh5NzhnZDAxWWtsZlpidXZE?=
 =?utf-8?B?MHR1UU1TcHNFM0dUQXJhL2NrVHVRSlBBNDFYeEh2dWNsa1BGSThPREJIVmsr?=
 =?utf-8?B?ZnVNSFYrSGtpTTBRTENuRGIyQ0hkTzdHVVNEK2VPRmVnQzRqR0ZPWDdtaFc1?=
 =?utf-8?B?bzdGTlRWaWM4eE1Sa25KQTZXTUM1VGluVEN3RFE5K2pzcTByaktqcVQ3WUZj?=
 =?utf-8?B?MU40aHdGaTdnSFc5ekJ6RHRlRW5QWDZVemVlZ3g3Q3VhQTJhMFlFZTFvN2lS?=
 =?utf-8?B?MXpGQXFUMUlKR0FpRXRJR2sxNnptZFhZcHY1RVduWEh5RFV6bGRteFRWY2N4?=
 =?utf-8?Q?5FlGUOlwnMbPTPw7OJ8dVmsDt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb5bb6a-6593-4e18-40c0-08db4a734c1a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 18:38:46.4855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHnPw3jb9PPjYLyg4MsIzL/ltynmxzYsqkUW4BG1ZQoDcj/prC8c3Av46PSMYXqv9FIEgpfqnLpLhJfl/jZI8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6269
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 4/28/23 13:55, Tom Zanussi wrote:
> To allow idxd sub-drivers to enable and disable wqs, export them.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
