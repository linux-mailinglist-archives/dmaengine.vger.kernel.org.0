Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC186AE102
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 14:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjCGNqi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Mar 2023 08:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjCGNqO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Mar 2023 08:46:14 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4914D8389F;
        Tue,  7 Mar 2023 05:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678196754; x=1709732754;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Loq9Lracqpes2fRB8pj3rw0wF9D+DbRX3RD3tJtS1zU=;
  b=lh2I5dY7GlLbeUggiu2U/EpeXkcvISr16XbuBmoVjG4wTYKpr7/mc3ak
   TTGxmaGkobWlIxOM3dOWpq36HWwfh1Vy/DmM+klHWrZXlO6ub3IP2PjhH
   0oASY1HaS+unysDM1bOV/QnsNrhbIkq38LRnYlpEZ+IoAZX9RKJ5BV/Q8
   RDmTNUR8d6TF36X+a4SExqaGDcQevaZa7HVZZsdBvMcZh2DTjaOYn7n6H
   VAFhJrBJtt3zEj4GsFACotMa6q4eFXIaIFbeq3jJjMs/m8WwaRf1fHcDr
   IEqphl5NJFPzzxSnX0Gp58/JJ858tGnEYyJnYMxa+Ed0KcIP/+vQP+E7D
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="316250054"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="316250054"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 05:43:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="706806652"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="706806652"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 07 Mar 2023 05:43:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 05:43:37 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 05:43:37 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 05:43:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ep8nH/iiUdewGSqUm55YOMC32XVCFscn3vQq+CfQSEDLYXtNtJeH3fXU+rN1lLNAXkldJm1RUbNbEUp36CviDfw/WUMdM8VmhslYLRpBjImoPYFFiB0CftasQCTCFKl3nsig54fSIEMvoyxTaubxByoznj8RwVG5CeA1L82jc4eXP1huxI4cprAoGska5iNT7ZwQ5vLOpAiKGWRyqofjmjYodfCisxCgTkiGM178wQc2bNNki8YTAxxU6VKbsyRpkQGoJ400aC3Kztgag+MCcIcyXqeXh4GH/jEbgVDOZxwBF08abi2ij5oHw0b3UIyMTUTxcp7p3d5q89bFGVntEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubeT/0Xgkysa4c/hOlIpT41Oxn1VhjHOo7t1sqehAIU=;
 b=PWvvnQ3R7rTeBYlNRRtxHQcp5MlrYX6zl3cPjLQnCenIc5gW3OCspa0cbJZVLr+Z4cu5Z4pVKG7ELXIPsDnyL6NcSWSzgVUcdmIC/FwprgN4HUuJ1votndU52+bt7k06P7v+SGTpRhU3KlieHjBcQa2B+tfthfJkf0k0qsPj6cQsXuR53V5YNbr+wXgPoQz829WwTjZpzlGp8h3oMTcVLXSsAMAooIn+cIHWGVQrV889mflH8e4kjwfngXKh89V6qk8sj2jWBiBYOyJp28KaEn//GG1GWUC6dO29KcJ5KHdwEKEKpdtjciqiKy85FF7V9e7tI1wagP+c9BAjeRNYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SJ0PR11MB5813.namprd11.prod.outlook.com (2603:10b6:a03:422::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 13:43:36 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37%6]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 13:43:35 +0000
Message-ID: <c44caf95-6fe5-c336-e47e-d624e9c27054@intel.com>
Date:   Tue, 7 Mar 2023 05:43:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 01/16] dmaengine: idxd: add wq driver name support for
 accel-config user tool
Content-Language: en-US
To:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <vkoul@kernel.org>
CC:     <dave.jiang@intel.com>, <tony.luck@intel.com>,
        <wajdi.k.feghali@intel.com>, <james.guilford@intel.com>,
        <kanchana.p.sridhar@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>
References: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
 <20230306185226.26483-2-tom.zanussi@linux.intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230306185226.26483-2-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::26) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SJ0PR11MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 29871bf9-5a16-440b-672d-08db1f11f2bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5+dhTm/ajWyYklAb8u2bJiUU+PZCtw2ZgUv2WO39kEPJ9OYTH4JPmrsCrxyDQsnygIewEsDXOXKdAAQfIVsLVYd0QD86ahcCZFBqYosGu5wvSse2g7PLHe0aWq/0zT07Y9W1cOT8bKOnmU+CkXbbqywSkZKmTNApRa7FoFILi0IiB089YyHQdGP9/txy+o5Jj5LcCRt+b3p1uJVX+dqogISqEgsdxD9gosCI4wMCoLd0Pml3hk2zkzG6s0xoEhnsG8rhR4vLa3Vk91dPjpDY1m8Y/7R/L21ruKD266N4zSpkU4PHNXb08JARYhBRNOrN0E6CgjA/95lcYn+LjHWODgmo8KcwQ9pfLt3yeK5oCrAkvjvJBJZLTZ3Z6E2IU2OpeSGqI4Pv+I7ZgQTfs3hUrLHvWUbQc7jTYKithPvFp73MTmaJgU5otxN9ftrE5a/SC1T6RUTNFweWUwMGvH4ZpfmoPh45lsvremExobERqat6yiwnfc7BYt4E2nhnCR+diGnNPinZkc1FU18JTDedL43o8CSEMZMlBHY0+BOj1pr+n9wvC0eeR3ZQq5DtEYq27qHxGdL5Mvaa1K8QoroMnN4vZAgYsn43fOOCQc1AHeYmB4OIOIDDlEw0bOPitjLyVe5WcAqTVd/Zy/uQF0aEjg9d7Tj7qqpiaJfZgvYF+nSbO+EHOcNPfKEiTnrKuF/gF1ONCChXlkf8WmbbEZBRe6NIgFS03O9YLvnFgytwqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199018)(31686004)(6512007)(36756003)(38100700002)(2906002)(478600001)(8936002)(5660300002)(82960400001)(31696002)(86362001)(186003)(2616005)(53546011)(6666004)(26005)(6486002)(6506007)(4326008)(66476007)(44832011)(66556008)(66946007)(8676002)(316002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzQzTk4yYWNZM3V4azBYL0R5TkdmNDdlSGIzWDRrR2ZwTjZHbk9NMTRRYnZh?=
 =?utf-8?B?d2xNbGdBcnRISzBidldQcmdXdHdJRncyM3JISmozb0xHNnpWTTdDS0lEWFU2?=
 =?utf-8?B?RFpHekxSVXc3RzloWXpUY3gxYnBYcDY1L2NzcDZ4S214bkpOWnpPYmY5RVQ1?=
 =?utf-8?B?cmt4SkI4UnpXY09OSS93c28yY1UwUmNkSkpFaFlXTm4zbDFhRkNSOWh2VDZU?=
 =?utf-8?B?WC9tYXdBcU1tVitvRGxFZFZwTzRUQXhSM2RUQW8vcTZPV2E3Z3lFTnliam82?=
 =?utf-8?B?eGF4UU9YSEE1MncwTU43ejVQTjhuYUFqOU5oUnB0UHRkSlV4Tlk3QXRPZXV5?=
 =?utf-8?B?Y1FFeUZkZkZRR0J2UzQ3TDlNUHlJc1l2S1VJc0Znam9FRkNQWm1HNVR6TFhI?=
 =?utf-8?B?cFhrT1JGUmx1c2hPNjZYQnhJcURJMGFGSS95R1h4aTMrcmJYNk1LbXp2ckgr?=
 =?utf-8?B?MjQwNEp1Mm1JZzZMdmVGSklyN3ZTQ21hWU1ncjBzbm02Mkl4QUJHc2hUSWpT?=
 =?utf-8?B?a3hxWUpyQk1SaEU5aHJLYmRxT3ZIMGtyb2RhRHptTVlOS1k0MlFxMXkvbXhC?=
 =?utf-8?B?aEcxb2RzREhveUZ3ZzBoK0lhcEEvUmVTR0NPSjdwalhYR2ZmVDZ2V0Y0MTln?=
 =?utf-8?B?bmRHR2NjUTdKZHJKUDlscDVqeTZSVjNET0RIeUI1cVI5UDBQZEJIc2FxNlRE?=
 =?utf-8?B?UmNwQ1dOdHk3bkhhZ0VsbHNKR3ZxQ2JXWE1QNW12d3BpWisxMHpCbXZzUEtR?=
 =?utf-8?B?cUpPTkJOb3RPNkpTOElSUFdlN05QdXlRWUUzWTNHV2tJeGFSVldNV1VvQkNh?=
 =?utf-8?B?bTcza3Z2M25TZG9mcmJzL0p2eGo0aFRxK3M2NVhsdkVKNW1WNm5IWnBnRnEv?=
 =?utf-8?B?RUZiRVJGZ1BZamQyUC9XYVNaeGozMEFBd0NqckNMM2NlUm5BU1JrSkE3dE9h?=
 =?utf-8?B?VEl3NSsvd1orV3JpaTZJZ2ZXaE5mOEIwS0FSYlJqUzRDRFh4RGN1WnpKMEh0?=
 =?utf-8?B?RmZKdWhiTGNKVmFWL20ySzdaamJUSTJkOUJyd3pxN3pnT2xwcVFYOTkvZllP?=
 =?utf-8?B?c1hvakxGV01FcnRBZU5QWU0razdLdEZUK3VRRjdtTC85bWphR0pmWEdsb1h5?=
 =?utf-8?B?TlVaMytGTm9PRVE4WWlIMllzVUhvenpYOTg2NnJLUXA4OEdGOEFzVlJOTmQz?=
 =?utf-8?B?RTRJNXJ1UTIvb3VNaitOQ1lONUNFUzFqZ3p0QlhsaERQZml2WCtNMmtCL1ZK?=
 =?utf-8?B?V21rSTVsTDBQOW1CTm44bkw1SUxxTlNiNEEyR1RDUW9nSW5jZVpGaURXZXpH?=
 =?utf-8?B?SXU4WG1qdHMzakJUODNGaFN1aHMyc3daUVBXNGpXb1FZaFZ1clo4OFQ5dlRN?=
 =?utf-8?B?NjdURXU3dWZwbnd2RXlicEI3aWZsV1pZUHJlcDROU1hESnZKbFN4WUdVM1Fn?=
 =?utf-8?B?RkVyYkE4VjJnbmNNRXpmSStBK0psV3luZEtIVnIyY0RzaXR3M2hucGEyWjFm?=
 =?utf-8?B?KzE0dmtrWUFMN0dYc3RKZ041YWZGelRUWjJWb2xUVmRvWUR3OElGMGN1ZVBq?=
 =?utf-8?B?MFRwdFpXQ3FZQjl3Q1JrT0VFaWhYUEl2T0RUTkdFUktxY0I2eEgwN1gzTUgv?=
 =?utf-8?B?TThGbkJ2MDgzaFBzWE9ibjNXWEFGcHBtSEYybW5QUDN2VzlUSStNejJWcXIx?=
 =?utf-8?B?L01halVuMjNLUzZubk4zYnVSSXh1VW1qbm9GV0MveVVtMmVuWHJ5RjhqbjAv?=
 =?utf-8?B?YUxZYjF3NjVtNlVGeXNNVzVyWi9RRW5aajhzLzhIVkVxQ0tJeDF4YnJtd2Vr?=
 =?utf-8?B?YzFaTm8xRmt2bFZJQzg3YkNxZ3d6dHMwYXpkdVZ2SHZWSGZtRG5LeGpmeHJ4?=
 =?utf-8?B?T2FzRnBWclpTREFFY0RMRmV5V0xvdmhSenBYQUxrOHUzM0lVOE9EMml2VEpm?=
 =?utf-8?B?ZEJsZkdFWWRzZnRuendhQitFMkpnZzJHZWhoZnpLbWhFN0p0UHhsL2JIa2Mw?=
 =?utf-8?B?eXZlekQ1elVjNnM4NGxiVXE4L3IrNnhhM3VnWVVJYlRmUkpEamV4b3NYcXd4?=
 =?utf-8?B?YmRhYWgzc3ZId0UwakhQdytheDdlZ0VrVDBrYWlPOThSa1RKdFlFVXNZd1R4?=
 =?utf-8?Q?TXCHwwOvki/mrpA6SpS0BPTvf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29871bf9-5a16-440b-672d-08db1f11f2bd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 13:43:35.7334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4D2LwRbIMKayIdAV0RfmgvLFPi3MY4cmqnqJIltWa+fVyDX4kN/KbTswIr7st753kidYZEhM9BCDTMDdz+n6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5813
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Tom,

On 3/6/23 10:52, Tom Zanussi wrote:
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
>   drivers/dma/idxd/idxd.h                       |  7 +++++
>   drivers/dma/idxd/sysfs.c                      | 28 +++++++++++++++++++
>   include/uapi/linux/idxd.h                     |  1 +
>   6 files changed, 56 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
> index 3becc9a82bdf..e9a37e064193 100644
> --- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
> +++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
> @@ -244,6 +244,12 @@ Description:	Shows the operation capability bits displayed in bitmap format
>   		correlates to the operations allowed. It's visible only
>   		on platforms that support the capability.
>   
> +What:		/sys/bus/dsa/devices/wq<m>.<n>/driver_name
> +Date:		Feb 23, 2023
> +KernelVersion:	6.3.0

Need to change to 6.4.0. This series won't be in 6.3.0.

> +Contact:	dmaengine@vger.kernel.org
> +Description:	Name of driver to be bounded to the wq.
> +

Thanks.

-Fenghua
