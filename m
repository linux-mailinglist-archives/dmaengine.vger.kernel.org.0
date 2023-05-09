Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973946FCCFB
	for <lists+dmaengine@lfdr.de>; Tue,  9 May 2023 19:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjEIRso (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 May 2023 13:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjEIRsm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 May 2023 13:48:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3080635BB;
        Tue,  9 May 2023 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683654521; x=1715190521;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iXZtNR+OyqxCgnFJ9okZ6J9OorS5EjQMbZp+J6HkxhA=;
  b=l+JPY4jGyUrrxGVvHjpsHW569lCnkqOHF0MhN2/xQLelHdGwL9W6sXP+
   5hyl9EPIZ6PalD7bGzixu5PuD2S6DokaDGGPL1JIR6hEAxj9lH4QIvWGD
   RUtxneIIwfBlMJIvMPIpNX04XAzh9H8TcXm/InNGtFq/v7qcHL6F4zcI9
   PluNJckLd7QWEn20Q5uh8H0Wbhd7XxMXM/aj7a7jtFcjx5JysNcmyWkV9
   SgfOjYb2+dSnw6fSW3ob4O3SK1omr6jkSNROXh2Io095b4PAGSY0hxLJh
   VGJxxlpTseyvC0jgzUZOAuFcgWjHVJAyihJU+ZhRw1I9+NdyCS5iOh7LW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="339242061"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="339242061"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 10:48:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="810800672"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="810800672"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 09 May 2023 10:48:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 10:48:40 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 10:48:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 9 May 2023 10:48:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 9 May 2023 10:48:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkClnCNV39jTvIKuC22aGNiGwpmEbEWHbDHVk1Pt4BEEAugTF/sQBA+2YoLqUHgRo24Es/Rn/op1rl/VvOd18M7RJX8GGbtfAvZxcJ9qM0nXVlLXft5kP/3KRGQpAGkdImgaScnujEXFeIa9PyOdlG4fCTRr6RSNSJP+SuBxgotFfmvefEBO4zJUjvzvXnM9KIk+PZS5GwujoLxVXaY2JCsbnZr00msKrWGgYDgwlu5xYzKgOqQteXLKGugeXQxGDiz9qa6/Z5qiU5yV05TR6xxOwpAfh0njyeaER0xmgR9071FJfSr0Q220V8xON+e+8c6zFwy+m/EZMY8pr4BdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=As9m9D1jJ3WM0Ukz8fuhk7rbJTBHzyp2U9bqx5p6q/0=;
 b=mLPICvPQ4GSsk9cAtfCsbS0HB2iuzopMfUil0vIoDaGA21NdrK+MOCELcj++msR3/4EiwV0Xn7OfRi0CinDaBfZSAy0yr+gtY+K+x2ITULA11JOIvJ5AAahHOhG62AQJhi1JAxpVmk11BDPfCset7ECwB6t7QnVwvjvIwlRMXNQu28+0xl2jWkzQOdp3gjDuWnhTAZMQX0kD0hQUZXs2GxE3pkC9Tvg2flvsl49AYwcP8Fp62P1YgBbr8QS1/wwJ4W2plT9CTBXvKRf0dXzkDbz0k6H7MB7EVAGol4+xWh0H5vkQzxRT1cvHlAdrFpvyatg7SBubABcMVfn8tY8s+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CH0PR11MB5235.namprd11.prod.outlook.com (2603:10b6:610:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 17:48:38 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::bbe8:5390:54c6:b0e2]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::bbe8:5390:54c6:b0e2%7]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 17:48:37 +0000
Message-ID: <d9bad7c2-14d7-7f06-da50-81069853babd@intel.com>
Date:   Tue, 9 May 2023 10:48:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v4 01/15] dmaengine: idxd: add wq driver name support for
 accel-config user tool
Content-Language: en-US
To:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <vkoul@kernel.org>
CC:     <dave.jiang@intel.com>, <tony.luck@intel.com>,
        <wajdi.k.feghali@intel.com>, <james.guilford@intel.com>,
        <kanchana.p.sridhar@intel.com>, <giovanni.cabiddu@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
References: <cover.1683573703.git.zanussi@kernel.org>
 <a874741f266f57502d671843b9d4a9b563c372e3.1683573703.git.zanussi@kernel.org>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <a874741f266f57502d671843b9d4a9b563c372e3.1683573703.git.zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CH0PR11MB5235:EE_
X-MS-Office365-Filtering-Correlation-Id: d8504165-6545-446c-f3a4-08db50b59de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/h9IiOA4CiwYv0by9PGoYnbBpt4AssiqQX4CYs4cGEekvYiHwgB5C0Gr/r4n4046o+3M2oCjGWHTjaG4oheejTZbn3GRHktbA7vDM46D/r0eBB17ZKoiGmWNI6mz3vmIQxTR3iZGoIo+5z2bQw3TUSeLMe0tQ90dqXIKbS5rnQIAhZtFrO+ieTG4JQjVDyhHaHbOHr9eACWNTZdkoKFtfIdSvCO1mFgJ5QqAA8FAoKfVUUpOTz5R50o4s7ULxc0/r3C66Y6zrtZlDWjx85+kEOSXkTsOyo8/FIXCSA/t4duzyl5rFEYBaPIcGnBxczfHEeMxvxlUlq63sqJytv3p8PZhuIkRX5+EWyTwgEc1SQlU26FokUWDmuaYDkh03AP8xAcDJKejxmwMHSDaoT8uUH/ioSgpowukJkG1yLUoSNu5iWejmEDEiyC7AOkjb+vXS5yvgzz4K2rN9MNI2e+itGzpFQK7OFgzBxgAOnk46xXNa6le7dWkt4DlauBNjNRD5LMbCXpV7PeWE+hML34pKl7Blz2629IZvn+oB7rwvsPM1QARtDpTDHhHVmdbJaBK8tgDErJpT4Xtemvtzq31x5qSO9sxhHPLkjBFNTzIeqVA9YcaPethmw/ZVjQDHfg/+mN8RVsQaYXSerR4iXwH9tHbfNQ7LypwnO0qEhcR/sK57VfbpN2j6rkkU/DptQWz53R3PD0q3krTMdL/G5Rtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(186003)(2616005)(2906002)(38100700002)(36756003)(86362001)(31696002)(82960400001)(5660300002)(8936002)(8676002)(44832011)(66946007)(66556008)(66476007)(4326008)(478600001)(6666004)(41300700001)(6486002)(316002)(31686004)(53546011)(6506007)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlZxVm4zZE00SFRVcUpIR0czeldFV3VpbDlxbEFHWXJkTElQU1RTS2V0Unls?=
 =?utf-8?B?M3JCNzlzcG5NOVVKdS9udmgwWE5TOGhGRFN2UFZlUGdPWWVOL1IrTnRnRVE3?=
 =?utf-8?B?Ui83MGVtc1hMRGp6bndZWlJZS2ZMUDhTVWg5MnRqMzlLNTVjTHdyTkxMYk5C?=
 =?utf-8?B?OGpjTytKL1E5UFpHNFZqQk5jMVpQZ082K3gzMlc1RGJWTXBxNlVnTHhsWWFn?=
 =?utf-8?B?K2l1NC9LSHBjOFMydGxpYUxCNjJ0VWUxeWcrU1lyOGR2VWduc0JEU2tTV3da?=
 =?utf-8?B?bTd2RzJCcHl2aDlmbE4rTEFsZkt6YVU0YkUvUjhzWGpQT2FrZWFxQkUyUEZ4?=
 =?utf-8?B?WUpjYlBrVzljajFnOVBDVkxVbm1MZmFhTXYwcUZldnFNY0pwcXRVRGw4QVJL?=
 =?utf-8?B?Sll6MVdOajUvZytyZUhGTjFNR3gxY3EvNTZRWUxWZ2hhN3krRDROOUcyTy9K?=
 =?utf-8?B?WkVhVDVtVTR0V0daS0gvNDZ4MmNoa1dZd002OC9uZVcrdlF0Y0ZSQUd5Qzln?=
 =?utf-8?B?Rk1DUkpla2pLUWkvQUdCRVlHTzh4L0pJV1BsNWw5UEVsMHR0SFNEK3pjYjdO?=
 =?utf-8?B?aHhCa09GQXdHNnV5OHFHNXY3ZURHSk1waUt0c043MkFYd1F6VnR3bkZiWWhP?=
 =?utf-8?B?YnY2aGpVcERoMGtWUS9NZ3QvY09aN2Q1V0ZJdnpoSjVTMForY0tWVmNpd3pE?=
 =?utf-8?B?MTRHZ3hFeTUzR3ZxV3FQVnBTNE84KzlnWE9lZVRTSWhubWpLeTVUUEVCV2t5?=
 =?utf-8?B?cVlvV2pjS2dibzZwVzJoMk84V0NTc2lhWDZkUnVoOE9rSUlyb1dpRmppNzRJ?=
 =?utf-8?B?NnlIOFJjcnpsaEtqRkk3QUlkbEdCeGdkcWZJeDhTbjF6RmNyQ1J0OXpINFZ1?=
 =?utf-8?B?aGlWd1E5Tm1hUVVTSERMTm9tVng0VHl1MUFvcm5Nb1YxWklsR0xjb1pHT0VE?=
 =?utf-8?B?dVpMZWc5Um9DTjA4bS81UW5XdWViNDBGeHRHbXhxYzZaM0lmUXNXTjhvakhQ?=
 =?utf-8?B?enVMUWlTMDNtUytmYW5YVGNyVkI2aUoySmxMcDhZQ3VESXgrNXpJZmRlZmFE?=
 =?utf-8?B?czRTN1R0WTdBY0VDbGlvYURHSVJMSXFJOFZjcTZDbUVma3hITmZGdkNYNHNY?=
 =?utf-8?B?NVUwRFprUmhpMTRJNzRIRTFwRmcwMlU1UHpFb1Y4K3pSQmwzTTlIS0QvTjJM?=
 =?utf-8?B?UXJ0RVl2bktqSFF5eEVzSndzYis5TldZcHZQa3htWFkrbTVKT3pZSjByRGRV?=
 =?utf-8?B?WEhiVGxicUNqSzhYQ3JuZTcwMEFrMHoxdDM2M1JVK0srbElBQzR0R2FqOGhy?=
 =?utf-8?B?MzdXQXkyUm1OQzBmU2tLaHdPa3A3NnVXUm5Dc3BOWmhNTjAvTHozR1dlRGxZ?=
 =?utf-8?B?Si9WQVlkdlFTZEZIdEhoM2NGa3FLb01Id0J2VDRrMGRieDNpOWZPdEM3Z3g5?=
 =?utf-8?B?YXN6TmkwbHZvVU5rdFBoVGU3OUlLNk9PSzJBY2V4NGN3US9DRHN5STlJTjM5?=
 =?utf-8?B?RnpjTFpEUml2Y0daNFJ1bVNFM05RWFZIOWN6aFdXemlGMlVnbFN4OERJYzFp?=
 =?utf-8?B?NUFKV2JGcjErbnQwQ1VvanJZUllaWHV2S0VZZ0kzTDB5Zmk1UzlxTlk1MWpJ?=
 =?utf-8?B?b2pXK3VHM1lJckxQRXFUb21BRDR6TEtUcWR1ajBaajc3M0thdG5LMkVCaHIx?=
 =?utf-8?B?bXRNaEtNZnZadlB3M0Zhd29BN3JNUXhsRUMrc3ZlOTBQZE1rTkFmVm95V2JL?=
 =?utf-8?B?SjNvMGRmN3ZrTUtDMzZFejNXMFdKR2xFWkIwSFNJbE1GUVE4MmhocWFBMStk?=
 =?utf-8?B?dERvZFNNSVkwSE5lVWRwcXV0aGdFTlptUkZwQzdOc0NtbldVZmMrUkwzcGhL?=
 =?utf-8?B?bjB2UFRHYlR4eUZZcTM2VmZSUUl5Qno1OStieTlBdUM1MXR3VzJ4bWJ3WXVx?=
 =?utf-8?B?K1hqSXpnYlZnZXFJbzhJNTlPdFFpd25Ucyt2RW15YmtBenhURVJUWFJHaG9p?=
 =?utf-8?B?Tk9tNW9ONmRsNUVYcVBpd3AwYllJdVd0L3J0VmM3dkdIZGRNanBuTG9ubVZx?=
 =?utf-8?B?WHc0KzU2WldZNjE3bEtya3Z0OW1WRDFRRlg5NmNDQzhnU2JvQzV2Ly94bWFq?=
 =?utf-8?Q?jpoQX04OPYajlq9UzTaV8D2fh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8504165-6545-446c-f3a4-08db50b59de0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 17:48:37.3525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfXlMcW1zzEpCfhbbgYo6DCDAEPmJzCsaPhJ6FVHa5gSOO4EYZNKNK0ZPRvT+Z4lmYFTC2m5cKhFuB/PjXUG8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5235
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Tom,

On 5/8/23 13:07, Tom Zanussi wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> With the possibility of multiple wq drivers that can be bound to the wq,
> the user config tool accel-config needs a way to know which wq driver to
> bind to the wq. Introduce per wq driver_name sysfs attribute where the user
> can indicate the driver to be bound to the wq. This allows accel-config to
> just bind to the driver using wq->driver_name.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>   .../ABI/stable/sysfs-driver-dma-idxd          |  6 ++++
>   drivers/dma/idxd/cdev.c                       |  8 ++++++
>   drivers/dma/idxd/dma.c                        |  6 ++++
>   drivers/dma/idxd/idxd.h                       |  9 ++++++
>   drivers/dma/idxd/sysfs.c                      | 28 +++++++++++++++++++
>   include/uapi/linux/idxd.h                     |  1 +
>   6 files changed, 58 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
> index 3becc9a82bdf..d5daae442fe7 100644
> --- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
> +++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
> @@ -244,6 +244,12 @@ Description:	Shows the operation capability bits displayed in bitmap format
>   		correlates to the operations allowed. It's visible only
>   		on platforms that support the capability.
>   
> +What:		/sys/bus/dsa/devices/wq<m>.<n>/driver_name
> +Date:		Mar 27, 2023 > +KernelVersion:	6.4.0

Need to be changed to 6.5.0 now:)

After fixing the KernelVersion,

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
