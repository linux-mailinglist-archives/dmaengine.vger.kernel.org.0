Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEEA6CCFB9
	for <lists+dmaengine@lfdr.de>; Wed, 29 Mar 2023 04:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjC2CBf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 22:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjC2CBe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 22:01:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E00B1707;
        Tue, 28 Mar 2023 19:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680055293; x=1711591293;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Nm9UEoXIkH8rqhfjqHmwnxTP4fn/iRXalxUfiTTwLJ8=;
  b=K7Dk1jmH+m4qo8nMfootygheN4xji2OJb+7uAJwLLW9S0LniQtvOCo2w
   bmGnaBvfKSODmuRvgTjUeIyJ0lNqNTLO4GFMxyHIGmFjMBvxV852Goc8/
   YgEsPVuuY1IzIKIxkVDw/bt23Glh5SlEpct3MEsv0qvpIfW1MB+/gX9sm
   lBYK5eITVRBskejLr7FT7+MHPJ4k5g/OBzZM3ezQ+J/jcwWSiKbFieFHt
   jlKPRnDD1x/I7eMcsu3xNEqykuZKSBQdK6NfLtpi2+mAXvKkMGIsC3l3m
   kjR2cjwm7IBIeOjjKJXHR06/8kCQqzdCU7VuphwRYVh+oZewgIK2nKMA0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="405689178"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="405689178"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 19:01:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="773369014"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="773369014"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Mar 2023 19:01:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 19:01:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 19:01:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Mar 2023 19:01:31 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 28 Mar 2023 19:01:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aeg0SiaZ/v3hU3Fe6dkOVrjuJiHXu4ZHcg7Sptx3rUcrf+Ca4juzXPWVvdC8+eA3OlmFncVwfpdG5zy/0gCOxeEJScWSEJ+axXT/qhvs8gnDoxBILDN8Y5L3MhrmkrJevyzlbjbpbTVhExH/f5NcIY8Y1j6uozJ/QoBP2ONsh3u5Svx+OGq4VBCLA5kFb2/pOtuFdBS5sri71gKwJoKdFhEzFo4WdA3Jr9iSzgswX2hZDkdaDjqML6dpPFTjF16jBbLeo8SIrT67bvFDbXqQtllUBg89t/iWYvoCS5FYwJXokab6uwRVqc56PDQ5fgW+Ayvu7x+g6lqkGzc3M7zFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqKLmYTNpYQa/CSFHMG6kq9Q8dAtej+qKRrZIWnwKQI=;
 b=F56TxhSaPfFUO8bWYCS+RsHHMqMD+DIO411SinWZEZulgOoFTeqzkjKzwJVtcI3uXBBo2wk/ZnSoHdR7jU5PnlqiN5T+dAGpYOOBcjewfzvyWxaCapsf27To3usD52bKWa/4sqj0gQefc45y4b/Tt5esWgkUsxDJett57TgoRqcI2HFWGKydglrGxESd8PLbXjclqeVT/hFuOIcV+uVmp309M5y3hsUQIOKALYXTKUsEib+jTBCS0QhDoYjCaug7eBUX62XLHLLNFPlFzMloCMz/GAkWvV2SmK1qT1eDE9fIsOXAZVsp3aYNDFRvWARGTrXaAY/b+9klf3MTVoozXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by BL1PR11MB5525.namprd11.prod.outlook.com (2603:10b6:208:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 02:01:26 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37%3]) with mapi id 15.20.6222.034; Wed, 29 Mar 2023
 02:01:26 +0000
Message-ID: <9f233d86-d8a6-f28d-93e5-e2614d7e9f9b@intel.com>
Date:   Tue, 28 Mar 2023 19:01:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] Expose IAA 2.0 device capabilities
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>
CC:     <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20230303213732.3357494-1-fenghua.yu@intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230303213732.3357494-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::43) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|BL1PR11MB5525:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2cee52-56d0-4709-4fd9-08db2ff980d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/mFPU6LtQGcYOGdGvwBkiuhxordUH1++htORGQHbDvJm8NVt0/klWxlJIidjq7b9BxA7ltXjUr+qgFtQJQjn+Ww5IlFb/DTgUCNtZxpYO6d5GpfZHNp344I2cgZLonx8EDhldijjMpAdAZNYlVwmOxPJitTO2xeSJVjr2+yLYh9AElxrntsQD8au0KU/XRD8SknrEe0DHiZsSwLS7r31xe4npw9JcabtNGVgqsVjZ3AcrrFm0617CLlg+w+6jM7iRqiqh+ISyQzSR47q97mENoVHtXbwSVOlQPRv8votolMfncM7P4d49py0JyhN34Z6IDagwkQvoKA9uyeUJbzi2JNdCO7+1Zgz/WYUOhjHRnp7rT4CTO/4Rny4KTIBTQZkMi3o9kHt9IFgKxRwWV8i0Q+b2RBOfFze6sJubsdmsBWBPCUqfIoFyaGGf5VEtTW2Satza3cldpz7WOcSziFpFrWLRSCx5dd/PtakiAHZb+W1tHPqSCXO7I0sH2D+Bd/36Kg1+U/d0fs8Jq1MRn/NR+5iaAJd7wkeyn9G80iXeWeqgQz/nUdqrjz1sDQlH/RMNBIqsMOs5sMkj+OTKBaPQ315uUd/K8YxQw1La0PFy99edf2WX9v4FSzGeozfyjHDAsTQoSr82PkjlmB6uhMcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199021)(31686004)(82960400001)(6666004)(26005)(53546011)(6512007)(478600001)(6636002)(316002)(110136005)(6506007)(36756003)(8676002)(66476007)(66556008)(66946007)(4326008)(86362001)(31696002)(41300700001)(2616005)(38100700002)(966005)(6486002)(44832011)(4744005)(8936002)(5660300002)(2906002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnIxYm1QQU13UVNFaHh5YUk4bWJ1Y2M3NzZpanJma3ZZdFZsaWZpcldJb1cx?=
 =?utf-8?B?WTE0a0tMeVhNdVhpMWNzdFNUbmdFR201T2JCdVVuTTdBU1FjQ1FVWEk2c3A4?=
 =?utf-8?B?alF3Tnp4c2tQVlpTNU1DTTRzcmxtVk5XT0pvRUFJWmxzamdWUHVJYnpiam5w?=
 =?utf-8?B?TnU3OFVGdTFYdEo2aDRxRTQyRnJBVjgraG51RG5hVjZEcjMwSTZSWXo2ZXJS?=
 =?utf-8?B?aDhmWjhDMWYxdmp0QjBNREZUL0U5U2ZNOEhUVVlBVVdobkx2Wk5Oa0VtSXBY?=
 =?utf-8?B?VWt0cFFhOEt2Z1p2YU54ekl5ek9YY0xNNDdiaFhCQXQ4eVk4RXZZWmExSm5P?=
 =?utf-8?B?UXBhK3FybzlBQm9pWHRIR1NaLzZBcWxkQ2tNMEpBelk1RDVXWHlpRElHMnVx?=
 =?utf-8?B?MDJ2Y012bklWUDdKdW1lWTFTdmYxVk1XeWdja2NZbEZjTUJJWTYzWmFTcnBO?=
 =?utf-8?B?TVpya0U2cHZzQ3dLdEU2NkR2dlNoYzlHUFRnaGYyUkVydnRuTkNEQTBpR2d3?=
 =?utf-8?B?ajlidnZHRFcwbHBxMXZ2QnAwN0VkeWFPbTkzTTc0MDVDU2lYZTlXTlpxY25J?=
 =?utf-8?B?RVlHUW5SMklFMU9Fa3p0VEQ4ZUZyZzRxSWlxUlZoYThvcUp2b1czUDdOQ3A1?=
 =?utf-8?B?aVgza0tybytyOGQwVkdDY1kyTnJ4VC9SNTY5MTk5Vkc5NlgrR0hUcFBJc1dN?=
 =?utf-8?B?dEEra290QkNUaVZNWk5HRlN0QmNxeXZ5bDRXQTNoTklKdFo0U0VNNWJNcUlz?=
 =?utf-8?B?VHFGR1RWMXROb3BMRFhGZllteHlkVHJJNUFqR3Q3ZU5hR0FCVmZpSUV6eVdT?=
 =?utf-8?B?djZvOThpV2NDaVV5ZDlqc29MY0ZSZnBnVHluRmN0U1M4RDlWNlNkMlZhYXVy?=
 =?utf-8?B?cXg5TFFrRjFCWlNjU2ZOWGhXYVFoYUxkMmNTNUlacFVwWlhuVExaUXBnQjI4?=
 =?utf-8?B?U2FyYWJ0Vlc3UmlERCt2Mnp0cFdkbmNPUTFGR0pRV0tIaW5aM1JSTDlPTHg2?=
 =?utf-8?B?ZlAraDFRRWVKRzVva1pTNTUyR2dScVdORzkwZUJLcXVvaXVxLzB3MnU0dXJt?=
 =?utf-8?B?SytzTDFSenB6L1U5dExveWtJQXJLb0V2emZhU3hLTXF1cFlvekJLTC9SaGVR?=
 =?utf-8?B?VHB2c1FaVUpCUWRURWdQZnVvVW1zSXdXeGRqbk1LOFVyWUpPQ0FSdllPYUk4?=
 =?utf-8?B?VWc1dlFtdGRWSUhReEFUdWtpYUprNjVhazc2V3BwUVBkU0Q5MUZLRFJKWjlj?=
 =?utf-8?B?SEZ4L1BNRDZSNWp0aEIveW4weG9iSHhEU0J2RUpBS1h6TXAwekZNS3NSZmx5?=
 =?utf-8?B?NTc0Uy9BL0RQeXprYitSMUtBN1lFY3Y2aGM3bVQxNmRtNjd0VTNYN2x1ZzFC?=
 =?utf-8?B?ZENCK0FwS0hzbXF5eXdrNDF2YzQ4MitKOHZDbmhPdGsxU1U1TGh2R2dha0cv?=
 =?utf-8?B?R1hMYlN5ajBCUUlueGp2SmhTZ1BHc1I1bjZwMHBoemxxamVSNElVMENrczZt?=
 =?utf-8?B?SnV0RlBDUk9iaU12NlpCWXlSTUh5RlVEOTBmN1FBNGFkcE5jbkFON2QwZncw?=
 =?utf-8?B?Y25UNlhCUisyMnFjWTc5QTlQL2ptUTNNSlZtc2FhK0xvUUovL3kyWS9LSVNo?=
 =?utf-8?B?UFh5NU5sTlFOc2wwS092Qi82SGRlR3FBaCtLM01oVlpBL2U2dlg1VXRGQTVN?=
 =?utf-8?B?OGEzWGxJbFJRYVNFRXV1VnRsN1pFaDBITFl5dmdGOVQ1cnQ0N09TUmY5TGRy?=
 =?utf-8?B?ZTdvc0NiUlE4OGdtNjE5VU1zUjF5cnFKc2FHQWViUTZha0xhSGNYV3NqY3hT?=
 =?utf-8?B?Y04rQ1A2aVZMVi9teUZhQWQrQTdOU3psMUh6VUJPWVFRcDRtNWtDejFlK1lX?=
 =?utf-8?B?cHpxdFRycUtjWFlURlBVdkxBczFPbVZ2VHA4R29oWDVOQVQvUng4cjJ0VU5H?=
 =?utf-8?B?WHNNVU9jbTNFenZUVlJscDBQcjRTNGNHak11TnI2UTJYV1ZLeEtXTDF4NHpt?=
 =?utf-8?B?QTZMcnl0Y3MwcWxXMGM2TDlRbjlsVXhsQ3owZmtYRk1RdkZaWFVUN2U4NUt6?=
 =?utf-8?B?SzZZYnRGa1dPaXErOVFyakF3NzJweXlYeW5TM1ZWZ1ROelJVVEtsMXZMejVW?=
 =?utf-8?Q?csH7x+LOSWHUnwMSdZ8oRPXyJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2cee52-56d0-4709-4fd9-08db2ff980d2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 02:01:26.0453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9NL7QTfLGPrWwyJ1lwL4Z2exkEam6MkUaI+ZWPsOFCc9473eUQ+fseqt8hVRUpn9zBFci4nqJAadxHhigbR7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5525
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Vinod,

On 3/3/23 13:37, Fenghua Yu wrote:
> In-memory Analytics Accelerator (IAA) 2.0 [1] introduces General
> Capabilities Register (GENCAP). Add a sysfs attribute to expose the
> register to applications.
> 
> This series is applied cleanly on top of DSA 2.0 Event Log and Completion
> Record Faulting series:
> https://lore.kernel.org/dmaengine/20230103163505.1569356-1-fenghua.yu@intel.com/T/#m13ba6167994f3add6446d2d7e242ecb637c54426

Correction: this series does not depend on DSA 2.0 Event Log and 
Completion Record Faulting series. This series itself can be applied 
cleanly on top of upstream kernel.

Any comment on this series? Will you pick it up?

Thank you very much!

-Fenghua
