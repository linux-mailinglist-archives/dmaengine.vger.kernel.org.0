Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D999F77FE2B
	for <lists+dmaengine@lfdr.de>; Thu, 17 Aug 2023 20:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354555AbjHQSvG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Aug 2023 14:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354611AbjHQSvA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Aug 2023 14:51:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF7019E;
        Thu, 17 Aug 2023 11:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692298259; x=1723834259;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pzpwc1AWUmmGJeqhhjIzTNdkII5RF9msUmBFzmWn8Os=;
  b=RMn9gSg7LPve/JX7b+RJ3YfMF6GHRR6EhwSdLrJZZ3CbAIWaQhOGyEbb
   dje83nb6mncHJvXnM+s33Ndp3aEt3tYjuh+mbLoLeiZ6FbyjnHuoWh/gv
   cfPodtGBLcb3DerTYM5YSKgwCutdpOztRvXUqwmVVf00SQ7J5WlZuflP3
   HxN4h+zfi3WbFmtVSOCbiAl88i3lAcCv53kVWoT580nV6r1fKFCsUoEzt
   msAUGeNl/MD2kf5hYO23AgaWtUs8EJo71Jx5IMS7RfFfuB0cNJYjjaPOy
   FdWTAoBOpCwF6wjJGi5YrsIDpCQSHZPxL4GyjmJ+W4D62sIHTxGMns0uY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="353211201"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="353211201"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 11:50:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="878333729"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 17 Aug 2023 11:51:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 11:50:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 11:50:58 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 11:50:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6RuNzWeGM717Z8jsPl/nBKYEdVg2ONwY3085Ho93KUOftZXpBD+0ShyI1i+/LOjKs60XW1/HF4hOWVDoiYWM3X3XLn/3p3ujWxLAcJyXamToakSpig72QHtHNRcS0R1bDU/PP4Y52TZdiw7h5wEsnwNAms5zz+zdMLsfPD5/KszTLFcouhdPCeA6gZKUMkfkhcHZBDU/MCRPxkUdJV7TiMDxpE/134Ow11Poj+qR3pGBJh3igEKLWufebv8Ln8D+PTTf+W4xxGMUzF7kAQI8CuyZpdDNXW31T5bewcPDuxiU5H2PsOetNgAlLIIWe01BtAQebHx7j3eoMeGGDZFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mf03vUQS6XlvDA+inbM4BDjDiDhoQ58khnXw0V+17g=;
 b=RBVscv/NUqwRgaiMXgdUXbi6/FgRkIt7lP0pAOCZkHQxpixAtPE1Obor9mM8LHcNyNId+DedSsoQKObmDgQ+MkHFpd3pFJsI2rGdChlLl0wdFaKXn/EbGLAetCeDs6He+JfRQmAmpvpJSBPzSWanik6QKfZOB7ibIlHRZLrPlgDvPajFDP9Y/RXiaagR0B3jM403NXW5C1H5McowMLD9ANEhoeZki1yutPJ7GAlOAiNK/T9TV3XCjOEBGsoA5gif+b1Q0+xDiKugMfHyIgh225NZHIOz7GgjUFIdpKtsyfGpTMHjD5TJBz4+bJ2hf+EJjWeA6UhN2zP6luMcheek6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB6239.namprd11.prod.outlook.com (2603:10b6:8:a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 18:50:55 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 18:50:55 +0000
Message-ID: <a7f0016e-d51d-1e3a-d470-e6dcc18228e7@intel.com>
Date:   Thu, 17 Aug 2023 11:51:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3] dmaengine: idxd: Remove unused declarations
Content-Language: en-US
To:     Yue Haibing <yuehaibing@huawei.com>, <dave.jiang@intel.com>,
        <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230817114135.50264-1-yuehaibing@huawei.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230817114135.50264-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: bf963425-a54d-4461-3107-08db9f52e36f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AoVHUm5GRLaYfu+Z/RX6fLxQ91btE7u6ICibHwyDspexKV1RD/Jvg0Bol9JixWIJitXfX7ePkqYVMEMyBhgHDF0i4SKjtLErBxmrPpaeyX/bRQ96K1Km3Dqo2fwQC0strfBVGaq2zai8aUVh4Df9a5qCqQL8+DUttEIs+qWoSND2BJB3ViTs+vpPJidKo01uaaOJwDMMrpFwzGOD2c9fBBhEwCxT0aQH4xVFaXp41KUZFY1JnkaMQwIzE/PltuiXqwx+RZjJV8n9i8FFMOcNbt+a03bZu7UtPIfRlGSNCoKyq2mY8kOsja9uBuvyny63YDmYqXUrwGVeJ5saKbfHb12W2Fensdt8dq6j1b/XSOSKwtUSJYomGMTpD2HjstoVUXg1E4DasQzhghfzBXwDTmZ1rscbV9+HWFR/fe6+NB9JfoTjpUp0SkKDp8h420QmHKp+8BiGbxFkc8zmzWMFkEH4dWPeqQkBqt5mXI0uTqPXoJ31er2n/UulqWNO+Qk6YjMTr+RPUvPxhZUb1qUUANlJRT4Ss0l0PZr++YdORPW1tefljer9kCrzHjc4+eyu4psCIlRqqpP3XuQW0F2li6VLgXkY2Rrj9t18Rc4KzcPqynLmR2hEe9B+jdiuNks+FH+N4oYrWLhEjlARg05MRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(186009)(451199024)(1800799009)(31696002)(2906002)(4744005)(26005)(86362001)(478600001)(6506007)(6666004)(2616005)(6486002)(36756003)(6512007)(53546011)(44832011)(5660300002)(41300700001)(316002)(66476007)(66946007)(66556008)(31686004)(4326008)(8676002)(8936002)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW9mVjVxeW4vL1NCSi8wN1JhSXRkMG5kQ0NmcThqR2xhOXRQRXpOaHZyYzM4?=
 =?utf-8?B?ZEZFcUw5eVRwUVZTa0FpS2JJQVluTHdFU09saWsxajc2TUtSaWdWNDQ5UlFH?=
 =?utf-8?B?cW1yYTlKamx0dHRSdkZFNzZMOFE5d2JSZ003V3VHTnd3RXA5ckREemlibTVl?=
 =?utf-8?B?bHFWSUxwUFFNU1RmVEdnZ21mdGgwdENGTEFEUUFpKzh5L2tITWVtcGFoZEw1?=
 =?utf-8?B?dHF5YVNxaTJiSmNYeVlzTWpPYzRGMElOOFdsd012ZGx0Y2xFeTE5S3g2QSts?=
 =?utf-8?B?c1RsSWtMSmNIcDBUaDV3T3U3S0pybWQzc05CR2g5S2I3UUJkS0o2VFNWN2NU?=
 =?utf-8?B?WWpBLzlnbys1bjRyV0xaeWJ3MmZFQ284NzIrUGx1WDlhNm9hNTNxUjJMRTNh?=
 =?utf-8?B?NE01ZXUxQ2NjMWxTa1p0dGNTUXpTRUJ2Ry9oOXVlcDROcllNYld0S2t5bFYy?=
 =?utf-8?B?b0YyYkthbkEyRUFmcmdJWW9zVHQxa01OT3crYy9SaEIyNVJlQzJpUnFIRUZi?=
 =?utf-8?B?YVJ1WDJEd3AvQjBCUHhTdVViK0dhaUV0MG0rVkJISnc2RVJZMXNuMFF3UG43?=
 =?utf-8?B?Y25Ib3RXUXdDVmxpYURNWmFqV0VKb256NlpSeFMra0NTV3NFY3VTL2ZLb293?=
 =?utf-8?B?ckUxQmVqRE1BYWF0UDNzaGNEOXdkMEZjbVpEM0ZHajFqck9pbEtwMVJ4bXJt?=
 =?utf-8?B?MWhCSzZ0ZkI5aFFuTTl3YjdGNzdCMkVaNjJsazJncUhOc3ZpMnMvOTJTV1ZZ?=
 =?utf-8?B?Mmt3SGlUUk9oVFBHSzNsNWJQZXQ5RXR3bXFaNk1wK2VrK2NiNUxRZFJzdDFK?=
 =?utf-8?B?QkhSTS9mdjN5VkhOTUluMmVFWk5xRUV3dlB2SEFPZlFBaXFlUGVvZjhSVEVV?=
 =?utf-8?B?UFRFS0lyYkkwbnpacDBRQWtYemlGeDIzcmMwNW9BcHlYcDFhMFlVWUJFU0Jh?=
 =?utf-8?B?SVBNOFlzaUs2QUtCcmFsMW5OMGw5U29VcDNBR2xNTnJaYURvNlc0UHBuc09Q?=
 =?utf-8?B?Y3djTlVUaHRKamVaY01sbExFVlJJL3MzSjgyRVFQb2dwL1VJb3pvd0FuTFhr?=
 =?utf-8?B?NHQyWjB4UXdKSHhOL0RBZHYvWWhNZ3o5TGYzRnBZdXpUbS9WeHJtMzg1SE5Q?=
 =?utf-8?B?S1Vnc1NHMHZiK3plNnNLYUpxMlJVOWxTQzBKaWN5ZjY5ZkcycFltaTU3NkRu?=
 =?utf-8?B?VTZ6K1JtMDlSOGFvZ1diT3B0aUVUSzVEMmhVN2NxeHZnZGVsRElRekJWR2pO?=
 =?utf-8?B?bDFaVFBnR29tZHh4dHZBUFFEZDJLU3lTS0NoRmtxd3YybzB6UEY4MERQVUx1?=
 =?utf-8?B?TTFNczJwNk1icmc4OG9ybm80QmdDRStVbG9tTHN6MEtWOGlqbjRZdVBVTnVW?=
 =?utf-8?B?RmdvU095Ni9BQ01HNW91ZUlJOTZPcmtGWTU0Z0d2SEdKUktYdVFjUE81OWVt?=
 =?utf-8?B?SkZkMVZvWGJOSzRmNllXRDc2Y1diZXB6QVZqblhzTm9CMFFtYk4rY29kU0dr?=
 =?utf-8?B?R1JyaXE0dG90ZERud2FNWXdvVmQvNklBOXNBRmZkOSt1UFR6d0tTTFhiWWN4?=
 =?utf-8?B?SytBNEp4bmRGZlVVMDlFNUhpa1FzdUgrSXgxWDRPQksxVlpZYzJIcWVhRm92?=
 =?utf-8?B?c1JnMlU0cUtTd0tTL1JNejhnS254Z2xkSER6UUMxZFNUUkNzUmZ0S3FaU1Vj?=
 =?utf-8?B?LzBrUXRNUDVxeUd5VnlmQlhWR2s0cnJUWEdNdG9xMkZyZ3AwK1kzeGQ0b1hC?=
 =?utf-8?B?KzB4cEExcm9QYjN1TDhZQXFKd3BKNUtrcUNoZ243elkyWlJUSnZpQzl2cjN6?=
 =?utf-8?B?bXBhcVR6MG1NcmpZMDdTRjdBN2s2OW00UmJ6STEzTzZxc2dwNmJzSUJwekVF?=
 =?utf-8?B?SkFYZmFCeFo1K3ZnTHBPSDQrOUdFcDNJRHNkTUdRSkozZ05VL0dscnNiM3FK?=
 =?utf-8?B?Z0ZWMWZXU0grUDkzL1N6b1I3Uk5Nc1pwRGxQdzA1WjROZFo0YnhUOW5pS3pF?=
 =?utf-8?B?S3JPb0tUVG5PK3NzTS9KK1V0V1lNZFV4OHl3dXA3ZWNMYlBYNlIxYk5ZVEQ1?=
 =?utf-8?B?WDVqUnEzMERlbUNhMGJVVEhxUHN1L2VBbno0VGpPRzhXa1loQy9XMXEvdGJG?=
 =?utf-8?Q?opgeKNfwsa68R+9ns7r902JlM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf963425-a54d-4461-3107-08db9f52e36f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:50:55.7412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6E6ytFj80G7jHHIM2vZJge5ZyUdAynZt91aTF4OhbERq4XAbh9lIvlnXB6of+q3++TEQpvB9XI8XKmK7wHLRcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6239
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/17/23 04:41, Yue Haibing wrote:
> Commit c05257b5600b ("dmanegine: idxd: open code the dsa_drv registration")
> removed idxd_{un}register_driver() definitions but not the declarations.
> Commit 034b3290ba25 ("dmaengine: idxd: create idxd_device sub-driver")
> declared idxd_{un}register_idxd_drv() but never implemented it.
> Commit 8f47d1a5e545 ("dmaengine: idxd: connect idxd to dmaengine
> subsystem") declared idxd_parse_completion_status() but never implemented
> it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
