Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBE86F35F0
	for <lists+dmaengine@lfdr.de>; Mon,  1 May 2023 20:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjEASlE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 May 2023 14:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjEASlC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 May 2023 14:41:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26701707;
        Mon,  1 May 2023 11:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682966461; x=1714502461;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nSDzlk/R2GGgkh3c5Tp5+k8WE6e6eMd7+lqhCgSTr+Y=;
  b=njM6qWSbZiv3hS6Pp5AQQKwWyO+kshegcMvOkpcZJOkmmsSSuR2ycDgz
   68yxUkSoLyiYgqu2Kl2xksXRgS6Hyh9Q+bP3cxpILMsDBsglhBz1Dmqfz
   7T59pEwgNwD/uLdb0Kh67sOHLivWhMu9SNCex0Zpd82AKALV1j0KLETOF
   EFFWyMOoV5o6qbotbPYGmioNuwsDjbFrWO94ipPdNdFhgIV1lMaeETAJ9
   YzsVG1VQmPQRY1X2SU75xcCGiqDrziacK+lBrNqdE4I19fQOjN5Le23SP
   ABHhbt7cofUDGTJhYbzbDaIbEvqB1gIiwWcFDnAtdR3t9Mmhq+kHI9zfw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="351179991"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="351179991"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 11:40:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="807530463"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="807530463"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 01 May 2023 11:40:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 11:40:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 1 May 2023 11:40:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 1 May 2023 11:40:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiBabdjhjtNKUw359uHVOeH8gmWe3ULiFiIQvvF4+RJrh18anrw++yC8lQ1maRp/iCB7HfNnnAf22t2ykz7rxJhqExKadj/f7amDYbVFg2RCi/tBVxOyw+8+Uh0kPDRHA6zVK5iFMSbQDLB4st+5EruNZjMBfJtBWq5F1x6+H31ARJOyeKipTYRM2nczUwLNAM2FpH7uyDOmW7XF6Txov6KTFskTVcQplY9sItaelZ1n0gqjpLlQt5gXwgHP3L6rdHKu/mAfHsuSfw/wnjl4BG6sXLguUh4nsFwJF4CSSmWRJAKAEol+vb8x8foHRbX3OehRWLSLknHVB9YoObdfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIWkNF3VdsZrzWlthE9RDHLRsEGs2GlYRNiHs3O5AZ8=;
 b=CnLmcLL9okSb+8VLCihGYgZOV3++Ubvw3Vd38A8K/G/CqsccVj4B5IuIZlcBYc0xpnCB1V3YvJi6JAh7oBvy1gHWx6uQ8zMQU42ngoRAF7iS807fE95rJh/VAh4K9Hw0kQMcytpgowHGzZ3TLVkVXxtgOnXTwJenIwso4EbbzXt1pGL4s+2iK6F0Cfzsu4PJXjfQkn43cma4PFqiqej3W7FADUjw57XBnyVyAYG7Czorp3hmImPFW57qlYiV5yb0YGokWUkU/oJHDnN+wV4Xy6mbiyAYNgI/ejaYZWzPYkEyuZI6lfeqbsSGAooUTS4CE4VpsXeG0769RKBmSMv2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by IA0PR11MB8353.namprd11.prod.outlook.com (2603:10b6:208:489::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 18:40:44 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::bbe8:5390:54c6:b0e2]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::bbe8:5390:54c6:b0e2%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 18:40:44 +0000
Message-ID: <36a5c34b-b8ea-0590-66e4-a797d7953255@intel.com>
Date:   Mon, 1 May 2023 11:41:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 04/15] dmaengine: idxd: Export descriptor management
 functions
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
 <20230428205539.113902-5-tom.zanussi@linux.intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230428205539.113902-5-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::28) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|IA0PR11MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 2457f74d-f5b3-4ff0-89a1-08db4a739254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UweGpvXwj51acdREf2/xK870Mr0G0iVT4WpxHIVAbwLaAbeWyU7v3M+x7LNgoUjne+kCoCGAF0xT0+x1qjy/QuVLhqkuvOJq83rYbTtTQSNftqE25JeVXZpLacLYK4ZWIRLzV7wxuE8tgnF7RYToSf6dvcNm3D99NxVh76GzvDBiQaQnjrB06sOQFDdTNfIdUofX8q4rVU8DAwG4fzKHdEhc1XRXH+tv0b57SewhDsRsJJg108RXWZH1nniJEJGXYsD3ePeEnrS1Mnu0iPXbfmBguyZTKnaRzY5pmwovqezXl6kxsInGTP9Z4flU7ldZUdjcKDYj5QUuHlIRV9S3J7K5aZjmEfyCDoB/5s4Wy/9mFT1BuPObn040+cDEriz8+rjOudSMIP671n0VBnaaz+kg2upAriw+EvrnKYlOVcqEh+vNmM51SV9O7cDaUP8Lv/+cGPM19TBLTPgyhUW1+nLyDyKwY+qta/0x8g6/3kTwPetIiq04M3zML10V895IsgvA03bUXakXBF5JIMYJPHuvcIOAjZwHXpDeiRrKGRr5R9SyImE+po7nPG7nzBZ+TDpbf5NfLqQ/rfbpgysYakSSK+BkI7MjQjfMMvZIevKI4pct2OIwtn7kzsHQqqvAIb3AKKILnWN5yypsweeejQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(66556008)(4326008)(66476007)(186003)(316002)(82960400001)(66946007)(6486002)(478600001)(6666004)(558084003)(31696002)(36756003)(86362001)(53546011)(26005)(6506007)(6512007)(2906002)(2616005)(38100700002)(83380400001)(31686004)(5660300002)(8676002)(44832011)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmxMcGNocTNiZXp4QXRsMUNMVFM4TDUrRU1CeHIxeXljM0Z2bUIxU1EzSkdx?=
 =?utf-8?B?NGxiREJKdU81RnVmS0lMSnBFTnlyUGhNWGtZdjl1YXlFMzBVVGpMN0hTQ2NI?=
 =?utf-8?B?c05FZFNQSUp3Uy8zU0xGWFBWckNUaXdlVWN1U3phY2IrbTYvaVRwMCtNVHdx?=
 =?utf-8?B?U1ZNbURCVG5hWEJMT1JDbzlRMEI3ZWhuUGVZcXY1WTM1NHNDNXJrei9HME8v?=
 =?utf-8?B?UWRReGUvNHdxK3UzcDFsQWVIbE94dFA4TGtKbURpMFAwYXpoa2NHdEJCbTJV?=
 =?utf-8?B?ZTZDdEdOSWlWSGVlODNBOU1XY0E0RzlUTUlRKytQNmpZb3pCbm1CNStCVUFK?=
 =?utf-8?B?dzNXZ0c0aGxzQ003Mkw2dUZvVXNlU3lMcmhiTFhhNTUvdDUyRjdjTmRBTjhV?=
 =?utf-8?B?SDloZThhRXFEdDJLd3pwUktsa0RTV1JDanYzbFdzOG9weWRmM1ViTnBkcnJM?=
 =?utf-8?B?RG9IcUdEanhHWERsVUM2ZTJVNnhyZDBINVorekpzYmxhalRnQnVncGxKVll1?=
 =?utf-8?B?MVMxWVVybUxwM1RrbUIra3RSR2pPTjIwQ3hBSlJRT1hjaXpIbXZWdmZBbHpN?=
 =?utf-8?B?VFNLTGhzdVpWTVhVMU00bGZKcmszaUFrV2I3aWVOM2tWTkE5OTQxbWpjQndI?=
 =?utf-8?B?VCtEOXVXWjdmV0tnN3ovNFBSR2MzYTVIZlVPVUNiaWhKOHhObXJjb2N3UHBu?=
 =?utf-8?B?QUltY2FRNENoMGZpc2Z3OWdKdEo2cGhzZHlQcEtHTTV2bFBEWjJKMnhvMWJ6?=
 =?utf-8?B?Y3VpeWZrbGRnZUNPNWJMZkRnVW5hUWV0R0lFK0F2dHkweGJyT05uTkNlS01y?=
 =?utf-8?B?aSszNEI1b25qNnAxQkhvVDJFR0lKZ0dMc1JlRzZQV0ovc2wvUlk3QXJxSXVy?=
 =?utf-8?B?SkFZY2hBSCt2Y2RlMEh4Mk1FVDk3WUlvdjlnY1AyOWZGOG9SaU9UL3hsRUg1?=
 =?utf-8?B?SDdQVElPZ0o2WTdXRWtVeEdETjJVbmxnRVZQaWtVMzV5dnRZRHdCVzJkUjIz?=
 =?utf-8?B?eWR3QVF2cmR5KzJPa0RVYVFzUDVJcDhSaTYybERhZzJjUlI2UkpTdlNsVnVw?=
 =?utf-8?B?ek1HQkhGbEJsTnp5ckI3NHZpZWpmZngydTF1MFNEbXR5bmx3TmVydFY1a25s?=
 =?utf-8?B?R1FLOEZsVEZUN2RrWDVyQkxINWMyZjkyU2JSSURjZ1VoRXBmWVVYQVMwTGtK?=
 =?utf-8?B?bFRjbGcxc1pXdHVnZ1hmYXdRMWNnb012dzFHUjFxTk5qY1N5Ni9CaG9pWHF4?=
 =?utf-8?B?Syt1SDJ1dTBlVjJCKzF4Zlk2K3NubmFYSURtekQ3Um5rbGlmR0k1MHBHTnBl?=
 =?utf-8?B?QkJvWk5QSmNkSWgzU0lDbEtBRTdDbCtLZDM5TjdQSUtmVmUrQlNSbWZpZHRz?=
 =?utf-8?B?SEhVMW0wOGJQK3I2RjJubDBWUEJUbThjSXM4TEhUNTRUVEZYSWQ4Zm5RVVpw?=
 =?utf-8?B?NmJOcmlIOHU2OGY4bWtlL3BWQ0dJdW1XWXYwMmJVQzM2TWtWUzFUKzJpcUow?=
 =?utf-8?B?d0pWd0Jyc2NHWWRobzBKQWdLRktFUC9uaTFzL0lJWkp5dzhlMUZ0dGZQeENX?=
 =?utf-8?B?cSsyejFQOFQ3ZFdzdHRUSWs1S29Rd0haMC9PMnVlSEd3WXI1OE1GdVY5MnF4?=
 =?utf-8?B?UHNIb0ZCRS9aTlVXZngwZHI4ZFBTVkRYQWlXbmtsSDl5OFZlM2dUQ2RlK0gr?=
 =?utf-8?B?bE80RTEzNm9XdFE4UlRRTlRRY1VDaXFLcW50UCtqZE9xK3ZRS0l0UXNDc3JQ?=
 =?utf-8?B?M1RXZ1crTHgxd3J6RHNYZVVLRGNrTEg3K3p0VXVMRnpnV0dTbjFQYStUY3p3?=
 =?utf-8?B?OGpVekRlaTJ5SUd2RVA3TVdZWEZGSjVUTnI4aEdXQ29kcmJtN0pNZkNaWnJR?=
 =?utf-8?B?SlFsc2pGRFkrTTdIdDV0emtlS2YvdGJNenVEaUFBUG1xVGJ0aEw3djZ0VU1Z?=
 =?utf-8?B?MW45ZFZhNEpPVVltSThTdUJPb1BpaGU4cVhrZldiWjJqWm9ibUpUbnFsNkx6?=
 =?utf-8?B?dk5NcjJTM3BTTFQ4MWExS3pVMlptZXhCQ2dRcWxabzFIbk1QZmZ0aFA1YUgv?=
 =?utf-8?B?b3FqOWNFbjVSREIzdFBOU0k3VnJ1bk5uc2hHWHVmQ3VSRjNVZnFBRzJIVzFP?=
 =?utf-8?Q?zB/3ZjwmnKiC0EJCh2KN+poIU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2457f74d-f5b3-4ff0-89a1-08db4a739254
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 18:40:44.2354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFP3j3EjGraW1IpyoGbq8AA6hm5FUsgX6Y2z7rAh4tHkGe3x88a86fRlGrs7Ohmsqk8E1VmsJb9tFAh5n3SMwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8353
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
> To allow idxd sub-drivers to access the descriptor management
> functions, export them.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
