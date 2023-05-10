Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53EA6FE6DD
	for <lists+dmaengine@lfdr.de>; Thu, 11 May 2023 00:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbjEJWH7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 May 2023 18:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEJWH6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 10 May 2023 18:07:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE8735BD;
        Wed, 10 May 2023 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683756475; x=1715292475;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fGbWd11AmPTn2ycGMoHRixNzLm+v4zmvU49nUFgbV1Q=;
  b=UDZqwCB8UZ+85B5CRR3hrN3UHix6XZpTsZrvCvDAfBKb4exwOCsbM0tr
   FkDDDoXDh1UQSTCkKPqQKUUIZymgwkT/XNqnUc/J9iuVv21VQUs3mWWAo
   XAETjc913TNfgvidpMr/9HsB69bbGvYYl+H/Y1AH95cyqHsQRasbDk95m
   SEGnFTuUPmSYedoy2Gb0QByO3a5CSViOypJAn9glHG4CL5DsjY6p2vJ2a
   ENt0k/h2lE0c7F+CAgI/IXcNGya1sEGl20skVgiyumad+c+HbzZ3KJ+Fq
   Hx5rE51kX7tpV9QP4weVg2vZsvr6z4mi12JLO3+HyxLER29qJdOnq/hTf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="349171808"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="349171808"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 15:07:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="699464801"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="699464801"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 10 May 2023 15:07:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 15:07:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 10 May 2023 15:07:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 10 May 2023 15:07:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWC0xddXEhQNjCrXXhmvjDo2vhKI0eWlICm6Vf0ZJJ1emkuMMh46GprpNwtunvH9hv7UrQI6Q0KCnTkE2MZtsVdtBp7k+ly27eLMG117L/ox6LEhB/6+KrUF2bpuuG1I4vtuz0ukZXC6g3YrDglBJVb1rHjHqmefgE3C/NNw6yay3eCHX59SKEk02sXYGa9+xyyKtbZUFlNruHPgTaDHgvb8e64pVom/zW2RLKd7G39a8p5bsTiGsyTgON0pd6dImxnEm7rlw3zBf5ubF2IaXIpAtNfUi8b9U6fWr7UFpbBgOl0ZDg+xaonXvntwPLoIAF6j+fhpEAd6E+Ild+EzDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VI/Yw0X0HawLwYXi5hpuZc42Wv93kGOWdjkLPdGVqE=;
 b=XCW0n2JIi3WhlVSYvXLl9AXSk/OSJIU8DZXFhSx/uAhG1D7r8YCuWIsi21/VQErVFxry9G5yuXYWkrjJ6frbNV1KPOWhf/YEXpUu32LHY/fXsxJCXchWvB8rMw1f8xbNWbMJL26o6Kbsdc5bOULOSbLK7GEYY+E+FQChoBS1H/Ud1ej2ojZlk1t3B6Xcb1Zh1WSsuUjOzPihiG2yFZRj62LIl2bhDRsfZJsejuENQh0woQVkteDBlrPQsEpQHHCw3n/RxVvgLwJ+VcMovJ+PyDHHJm3f5lZBubEh1yL33aj7jccVpFxclc4fGh+5yu+CyN+A/oIpGL9GHGxzXYLSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA2PR11MB4828.namprd11.prod.outlook.com (2603:10b6:806:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 22:07:52 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::bbe8:5390:54c6:b0e2]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::bbe8:5390:54c6:b0e2%6]) with mapi id 15.20.6387.020; Wed, 10 May 2023
 22:07:52 +0000
Message-ID: <c95dae02-ba49-8a30-24f3-687810ec1f98@intel.com>
Date:   Wed, 10 May 2023 15:08:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: idxd: Fix passing freed memory in
 idxd_cdev_open()
Content-Language: en-US
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
CC:     <error27@gmail.com>, <kernel-janitors@vger.kernel.org>,
        <dan.carpenter@linaro.org>, Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230509060716.2830630-1-harshit.m.mogalapalli@oracle.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230509060716.2830630-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0063.namprd11.prod.outlook.com
 (2603:10b6:a03:80::40) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SA2PR11MB4828:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c4bb58-bb47-4aba-b96e-08db51a2ffb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nmwRqFXNqtWfgo4EasXpwM67v6fXTqBJ7IeoVHln1zlrcA5yMfcUdx7oppexza3j7DSlooKbp4QrYmowK9YmSHehH/k46sIlUziUujB0rp9BhDpjMFzsET01+JUW1FUev+EnRJaoejKWX2yt2aWTOwYixkkS/k4zxSPa+4xc7+4lQ6UxrPqsYvIfZF2B2nSbj//BghGhmh5fNXvnOdcDLxri2z4ssXG0x3oeByQugTmDgqKIsy/Ll+rigWOeA67MYQMEIYBAILaUc/Ys+7BOwkFp6PWtw2Cu450d1lXawLehqfE9fU+9B5yUI5REeumKMD4LjVPXZsJqEDahLr4RUcv5rJHC9w052nuXcbVJ6XDwaisYMMwKLsiUbnsDFPbSdG8HeojoPvqhn7i7pXIJcYGnb9dzvImIgCh01IMsFM2xYsdBDXq4v6jV3iw4hgNgVsCXEwyLzqhXULEtZhleWaDOKAgMh+c2e9pw7EvZ230o/PoEFu7oqVXRUGHYWRr5GXEZW7Ju8Dz9nGEW+rwskyaUVkpWXa/A+VCptWWH8TNx8292m+CO2U8vD1cU0Ipy7RxLVUbSVEI761DJOhQqqR5E/12rzOSdyqGsivXq/Mmn/odP45ZqACuozeWzwXEEeeaZGVsu3P5xRjRkZra3qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199021)(66556008)(6916009)(4326008)(316002)(66476007)(66946007)(83380400001)(478600001)(44832011)(31686004)(82960400001)(54906003)(41300700001)(2616005)(38100700002)(8676002)(8936002)(6506007)(6512007)(53546011)(26005)(86362001)(186003)(36756003)(2906002)(4744005)(5660300002)(6486002)(31696002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzhJVTI3U3NHQ082RFFHQ243dVV3eHFEdFZXQXVtN2lRSERtYlRSMjNlamh1?=
 =?utf-8?B?VVpzMUt1Q1FDbzZvQncvdXZkK2lnekpmUG5XOFV4TUtZVG4rS214dkN2MFM0?=
 =?utf-8?B?c1JRU1NMVlAzQTljdXJNc2ZXRUMxYldYdm9hQVUwbWtXK1hHdER4dUtaS1pt?=
 =?utf-8?B?YnJMalhKT3lLeStmOE9qdVJLK2VWMWlQRlRxditsSWoxR2JBSTZTL2lOdnZH?=
 =?utf-8?B?V0FLd0o1OFhQMGdka1hXdUdtb3E5Z1hYWVQxaUEzT2VZcnVjeWlYWVY5MWVm?=
 =?utf-8?B?R0JIVGZCdG85VEhyeWZDTVNldU5wNnBBR2EvZVZLWVBxNlNVdmRUUTZHalVz?=
 =?utf-8?B?bVBBRkI2TW01eWc4K0R1RUw1dnhuQnlSU05xaDBPaWY2bnAwTVlOSklDWnYw?=
 =?utf-8?B?NkpiV295cUFFSFhuWXNVOWpTOE5iaXRqNG9jMU0yVmtZMVpReDhSZ0JLODRq?=
 =?utf-8?B?UGpTbmpYdGZBMlM2K0pNYWdzTXcvR2YzSmdaRnZoUXBVUjlGeUloeHFCYU5K?=
 =?utf-8?B?UUZXZVFxQXVXZFBjbVR2QWM1R2pQaU9wcjUveWZUOGhFUEpaaVI0c2Rnenda?=
 =?utf-8?B?Y3pjQkp3YzR2a3ZSak92dGw2VEExTno5cCtRdTRrc2hYa2lnU2s2MkZodVdj?=
 =?utf-8?B?eW9FMmhBQXBSci90aXFUZVk2djVKdGQ2RHp0Y1ZaOVZTT2RpTDhVcVhLRnFE?=
 =?utf-8?B?WnNyTmpEUDcvUFh6Wk5xVHBzSU1BYUd0WHZPRWp3Z0xHd2xvSTdELzd5T0lN?=
 =?utf-8?B?K29XYlFEWWRxTkdoL1RNZUw1K0FBMitaYjBMOHVrQUx4cE56TFBUT1IwMDVi?=
 =?utf-8?B?NDB4ZnAxdEMrR0VrZ2lKME8vQ1JzV3VRYkpWb3NGYlpoc3pvdnFBdW9BSXRI?=
 =?utf-8?B?cUVTK0dVRVd4THFxVVBjYlNYVlRkRG0vZS9jZVhNVnhiNnBFVis4ck9WaFpz?=
 =?utf-8?B?amNaTlgxdENSY1pseW5GNkJNcUE2KzJ5Y1pnL1ZIUy9wVlhDK1RkWjV2UlFu?=
 =?utf-8?B?aXhaeGRJRjRXWUZsSGpyUnQ3TVAvWHJvbEtyb2RJWFFEdlVMTXJRL2h5djVN?=
 =?utf-8?B?MzhhZXlLVUU3SUo4eFhmN0Z1RG84cCtWcDBQOE9CYzZyVzZWZG1yVEJhSnVZ?=
 =?utf-8?B?Z1JYb2pwc2JKWHhUaFM2RDNYWktsakNGcGMxK0g0UmRmaXB0bVZNWEhXeGFJ?=
 =?utf-8?B?dUp3cHlHcVBLS2M3aEhXQk9rUzdMS3hRLzJCYmkrRWF3eTVuMGJGOUZSSmFK?=
 =?utf-8?B?ZlRYZUwvbGJFUWNWM3pDdGxrYU5DV3F4Q0lnamROdFkyTjZSeTFwVFJvZFh2?=
 =?utf-8?B?VThUU1YyREplTWxsMnZWVUhMZVYzN3lQWkNJOE12bmxTb2ZOM25ndTd6Tmdt?=
 =?utf-8?B?cW9FeGphV3hIMnNBeU5EbmFTRm5rZWNLMERISllIT3dMazZNaW11UmlCelRo?=
 =?utf-8?B?ejZudmRtMW85cEJXZ3crVEFJZ3Mxb1BjYnIva0tUNm83WDl5d0tOTFpwSEk5?=
 =?utf-8?B?dXNPY1Q5dFNTOUdFVmpxMFh0d2lYYXUxZjRUYllBWFdBK2RGSisvcG03WExW?=
 =?utf-8?B?M0VZdUV5YVdScm5QT2VqKzFGdXlyZE5yelBGNWw2UnorZDNSVlplWHkzK1lr?=
 =?utf-8?B?c3NEUzNMeEhtMXFlMVRnL1dVNXZNZW1lVkR2WlBMRkZnRHVDbERQS2Y2TVFZ?=
 =?utf-8?B?WkhKMmNnQW5vZU0xdzZqSUttZkRXK3ZSRXorTUdVSklGS3prVnBnZHhMeUZQ?=
 =?utf-8?B?Z2wxUUZpVmZ5L1kyclRWNlNqNmg5T2tNWWgwMGNLUWZJUkJuY2pGWUtjaWZy?=
 =?utf-8?B?UGdDUmFzUWdNbVlGQndEYS9wNWk4bUhPZnB2M1pJL1JLZWpRSHRJWHRzb3Rv?=
 =?utf-8?B?QTB5RWhWZFp6M1ZIdzFwR0FORm9FUGp1bXN5emorKzFqWFdpblcveEg4ZDRP?=
 =?utf-8?B?VzhvRCswQjArOTV2aXEwUkhZVVZDMURqdGpiYUpxenZBY0g4WlQwcWdEV1JT?=
 =?utf-8?B?ZWFhVVV5ang2MEhPRDBFRVYrNDdMQWVzQ1B5TnJ4UGlNMHAwN2ZNVUVkWGFj?=
 =?utf-8?B?VXc1TkRGQi93eXpwRUE5NTVkN1h3eVFsMVBocVdNS1J2OUxxazBHQVJKaktn?=
 =?utf-8?Q?GrDldyKIhzCnFj6KC9b3Q3XkZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c4bb58-bb47-4aba-b96e-08db51a2ffb4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 22:07:52.2201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXeTvqEEuToiymA9z8DMT6/lhXd4aR8RryMZIyEfpYpccS2eteOOU8NfQvNileifyafQ7Uuot7uuQ5LXTDtA6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4828
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/8/23 23:07, Harshit Mogalapalli wrote:
> Smatch warns:
> 	drivers/dma/idxd/cdev.c:327:
> 		idxd_cdev_open() warn: 'sva' was already freed.
> 
> When idxd_wq_set_pasid() fails, the current code unbinds sva and then
> goes to 'failed_set_pasid' where iommu_sva_unbind_device is called
> again causing the above warning.
> [ device_user_pasid_enabled(idxd) is still true when calling
> failed_set_pasid ]
> 
> Fix this by removing additional unbind when idxd_wq_set_pasid() fails
> 
> Fixes: b022f59725f0 ("dmaengine: idxd: add idxd_copy_cr() to copy user completion record during page fault handling")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Acked-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
