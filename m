Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4A76CCFC6
	for <lists+dmaengine@lfdr.de>; Wed, 29 Mar 2023 04:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjC2CEv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 22:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjC2CEu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 22:04:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D357A30EF;
        Tue, 28 Mar 2023 19:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680055489; x=1711591489;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2NuAb4/Xr2Lnz56Kr7PIRwkh7X6/tjUudJiJZzKfDYU=;
  b=R1dznFZPdiayFDRVCFCKu+Hfh9yvwkod1xsWyrlyib1qAyFKdd+diXNY
   uPHvmVSmguV5G/4quoPy4eqdNQp3e6CnkPJbidTzbUzMHTfE8SIM7q/dM
   iqKGT652l5qKZO8d7dYXTSwxHQSJ3Kh184IXukqD3f+RAf5g3HC5eQ+Jl
   +YpAAPqKEsolDA5fMuAVoy5GpD5kEAUl9MRU3o5IE/0drJwCoi6ZkR5CA
   GrEkCQ7k6W1JsSI6ihE+0RH8OTD/vUreQSyDgpARG4WzQrWdljSOGzCNm
   xdx44GSiafwWu4PwwvNyL5EfNlgclFdV9HljcIAh/ktlZUM6wvWXMwfPN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="329211072"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="329211072"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 19:04:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="684095893"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="684095893"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 28 Mar 2023 19:04:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 19:04:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 19:04:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Mar 2023 19:04:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 28 Mar 2023 19:04:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBegDeIWSq3xmfpxsZutVn13CAa6nbYRUKj6aeVrmnsYYTv6obVcVJ0wmIErx2altGDEMqKgSXuBOa0Vk4t/w9zFoxHji+pJ4LpQp8PuV17UQ4L0BoNox8YmW6QvKDdY1+oNQpLlmp3EM2BCbh9T10ymY0VwgphsLpjJGv9Vpja5N/scZ/2VVBQE9sX2Y+T/m3945SAIHKwphqPa3qSRl4ZO9SLf0zGno0iUnAZWRfjnCi0FWVPM0lke7M3rBnx1L1Fm6rXlv8UCSnL+ZzimV0LbGpz8fg4BNjnCFlD+RyxDE3VYDXJTbd/K4ZiEKhVypQbgpEwcug4bh5I2wPZjsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxpfiQZVICeW7wSl5vW2dqcRnSdyJiTQSdTfSNK61+M=;
 b=cFb6hKft9ATLFFAq+h1TeVm64DhnhM4FFKwd+pbg1e8Hd/8yeZcbVeAuVp/Ck0szBqefHBwPn1cL0GaaRkbPjqjPE905x8urXVJ7XCMQeWcRaWglf3U1i/WYPybtl4ZW5IkXG3K+O93ukQnTpOfNcTdscrQvqgbkiNq8XFGig4oZcuTlApMa0KE0eS8wMQ9Jz5sYSBT9KY4yh6iHSdWRL00on8k1u8I38odGG33TkX5o8OD8TDs/FAwJY2fJogO2BEalVTSW1xU0qzm/QsMB+nUSLS1BtiQ9a1/GeE+Kfw3JOn32EP28dWdbUeWJ4ZPIqodSLYPGHi0h55uLPW/RHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB6480.namprd11.prod.outlook.com (2603:10b6:8:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 02:04:45 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37%3]) with mapi id 15.20.6222.034; Wed, 29 Mar 2023
 02:04:44 +0000
Message-ID: <1a58df0c-7732-6563-6369-6e3cae5c1214@intel.com>
Date:   Tue, 28 Mar 2023 19:05:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/3] Add descriptor definitions for a few new DSA
 operations
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>
CC:     <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20230303213413.3357431-1-fenghua.yu@intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230303213413.3357431-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:254::15) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc34b6d-74e1-4aa9-ba31-08db2ff9f73a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZOMKTeqGYswQXWkoX1lhjZY0iNZpm2FwvDTSzl71/qHx8H5jn40dIgC+/MipHWmvKh7o5Qvto1CPUMicH0f4SPefQIinjgVlEKXUhA/hUBcIMvRl5N8/qFRpg5JbUNiPQwKk78AEIvdTFUZFVrBikYeGrgwqIdyH6j4DrS5UPxrEH2yv6uuvtxMo1SVmLza6/Sl8lQtsepvkZJPtwNBGczYqEPflBQsQlhO4/UUiMWO3GTUdjC1haOF7cMtx/gD9s/9ndXJCRl+TM6z008AKF1e+b5+dWBQUQXNjKqxzoKZYnmlHLkswft/TajSeagGV4DPf5vLIRzdQj2GIYNwKTUdgyE+QT7ns757/X75lRj3JvNFVeIvwhOcH6ZKI0aX1kIrIps3YnJjR/nN5dZ1SyQ/s7IBEJWAHismVMuM8yG71004/ME6UcUSTLdMOr1fJEWTjc3n1qGyWFl/r7snSzeA52MbzJsPyNX8SV1XlOh1BQSWCKMDyYN60pxjzsmqLiIh7P0JOIrWt1oa8Pg31r8RDjsfFX3FLPo85j8F8OARV5Jh9kVEGeUW/eA7GLbeI2/4Q939X0g67xw+oO8M9o0qTyBFgBOL+uDDN0cpirfoHibgNy7XuLHeYTkS2okfeQ9d9mE3CdyjLftOfAJ55Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(6666004)(53546011)(6506007)(6512007)(26005)(6486002)(31686004)(6636002)(110136005)(316002)(478600001)(186003)(66476007)(66946007)(8676002)(66556008)(2616005)(41300700001)(8936002)(5660300002)(4326008)(2906002)(4744005)(44832011)(82960400001)(38100700002)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmprV3UyTS96bkNSaXRnTDgvaTNwNGc3RitNd3hKUCtlbHArZ0RPcTBVcEFM?=
 =?utf-8?B?K3c0MXdjRDVZbmlQT1Erc1ZZZ0xDS1kzVitNWGVSaXJTOEVaV3c3bnZ4V2Nr?=
 =?utf-8?B?UThZUDQwYVdON1NuVWducXE3RE5aQzgyaEQ0aGtTRDg0RkU0dzUyWkhZNlVw?=
 =?utf-8?B?SGlBM3BYU0ovVVZ1SCszVWcraytVL3BxUDduQ3JJYURKUkVjcHVQQkxRTkRW?=
 =?utf-8?B?ZFJrbFRGM3hNSzBWZXUzVkpvRGFtZG5SMVE2OVp4L3lUWTVsUGt6UW5PRC9a?=
 =?utf-8?B?S1B0L3RLaHBPZXdqUGpGaGRPN1JYbVVXZmZxMjFwWU82UnJGMFV3NDB2T05a?=
 =?utf-8?B?V1NHa3BxNUNWWjZwa3dtRnFDWFNHOU1MQjR3TFBBZnlOa2RMTjlFTElkSDZF?=
 =?utf-8?B?dUxRRzV4NSs1Q25pT0pOSU1Rb0FZd21qMkJKdFk1NzNyQUk0MEVLZmc4SXdK?=
 =?utf-8?B?ckhyTzd2TXlCbFc4VDZra2dIemZveUxqUmJsYXRLdVlwN01rdlp3ZGlJcmcz?=
 =?utf-8?B?SXQwL0hyMk1KNm1Mdno1b2FmY2lSNU85UUxCZ2VOLytUQUhzaUdBRCthdlA1?=
 =?utf-8?B?cGdic1FyV21rc21tQy9PRlZvRmtTYUYyaEdzRlpQdzVyVXFGaXUxamttWGlM?=
 =?utf-8?B?dHg0R1hROHlHanowZXpRU3dTSU5TQTZUclhjT29nYk8xYkZ2VlFXV1htcEdG?=
 =?utf-8?B?Rm9KNUk0UDJyQ0Q2YUcrc1dNRjUwOHhLc2N0b3FoRHBIWHU4Smg1Y1BCTDN4?=
 =?utf-8?B?SlB6enFSbS82Z2x4SWdOLzQ4OWgxR0FEcVlOZ0V2YzhYUWNlRUxHaUFYazg5?=
 =?utf-8?B?b3hUT2ZOTFVsVGx5UHp0cWJHdjFHVXB6VjVPbWNjRS8veVdFSDFrR1gxNVc3?=
 =?utf-8?B?WFJ0bEdiSWZvYzI1cFRQTkhudlNrWHVIY3V5dzRXcmpadWJQdVl4K1JuZ1h2?=
 =?utf-8?B?TVEya1hQVVF2d1JPeTVsbityRUxKQ3FTUi9aQWJUY0hvSEMybDJkOFFHRHlK?=
 =?utf-8?B?aGdTQTF0aElyN0pYRDlhNFpORzI5K0pieHRUOU9ScEZnTVE4ZlJia3JpdjlK?=
 =?utf-8?B?TGpGbmVlR0NVeCtiSFdwdkxXeFFVcm9YQ2tXaWY0OU9icEp1bjFNd2NJVXJV?=
 =?utf-8?B?WjlEUTNVMW4xZlNla1pWK1FBTGsrdG5yMktVTXgxOUFXa2lNYUhxSzBobjc5?=
 =?utf-8?B?THhqUHhTL29mN0VtRW1VSlBaOTVTckhucXh2VzlZOHRPMnNuTGNnai9jeVV6?=
 =?utf-8?B?WXI5UGtSSFNaY2xobG12T3FHaTg2UVJDZU9DVncxUjFVRVA0a3IvbGdHVldM?=
 =?utf-8?B?M2xiL1FveUkzcjhaU3hDMG02bWFpU1ptMHYxbEhscW1ZNmRQRjh6ejMrVUJZ?=
 =?utf-8?B?Q0xhZG1jRnFEc0p5dTdOeE5LTzFBay9pT0lhWnJaVkdxaUZ4THZOaTFISWQy?=
 =?utf-8?B?VnA5Z241Nng0T2kzTlRZRURKZURqWE1TKzFqeVVXVkpaelQ0bEROcGgwWXRC?=
 =?utf-8?B?UDhnNmc2TG1jUXZNSnpkejF5MmFyV1VTOEZQanN1OHFjd1htQzZpaTlHVGRi?=
 =?utf-8?B?WG5kckwvUE84RnVSV3FBRW4yaFBEdjZxNVVlaTRFa0VFS3hkODlCSG1XREJh?=
 =?utf-8?B?NWtVelMwTTFTSnJUQkRJVStMY1k1b1F3bjIrUEF0NHplcE96YU9GMnY1YXFm?=
 =?utf-8?B?OU0raGdpUmRxN3lNYXZyZU5yUml3RVRCUGN4ck5BZXlEMzRqZmhCVm5keEdN?=
 =?utf-8?B?dTlMYnBJUkMzc1R4VU80M1dwU1B0SitXaUZINnBJcWxBU0pVWk1SR2xzdHUy?=
 =?utf-8?B?SFE3T3UvVWtlZW9EUy9ZZ1l5RHpRTGpzWDN0QXJObEJMQjJDVG12NTVYT2FG?=
 =?utf-8?B?UkdrV0lsd2xraDhZa2lGTXpwa2xCMnVVYUFpNVpvTlZ6YzUrWUZsUFRoUTAv?=
 =?utf-8?B?UklnYkNnUUJZUXdycHY4OE52cjBqTlNlQjFtL0dzUFlLRlkvbEJCd3Q5SmRC?=
 =?utf-8?B?aWdubG1pVE9QajNBOVg1VFdvWTRmdUxzUi9mczAzTGFDVXlOdTRhWFVKYmNu?=
 =?utf-8?B?emUwajBsQkxyNW9qcWdSUnFSMTkwSG45SDZDWmRSK1VFcDZrMllTM0hXa3Nm?=
 =?utf-8?Q?v+rLk6G5B65SNjLTmGqR6UQgq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc34b6d-74e1-4aa9-ba31-08db2ff9f73a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 02:04:44.7766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcCpiyYmorkU5FymoJUkDM7hjUr2QTk8w1bJPqRYn+d+ZjQimYTyllzWVWV5mVN5vcBBncgupQF7qRMY9NZN1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6480
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Vinod,

On 3/3/23 13:34, Fenghua Yu wrote:
> A few new DSA operations are introduced [1]:
> 1. Memory fill with 16 bytes of pattern.
> 2. Translation fetch.
> 3. Data Integrity Extension (DIX) generate.
> 
> This series adds descriptor definitions for the new DSA operations.
> With the definitions, user can issue the DSA operations to optimize
> corresponding transactions.

Any comment on this patch set? Will you pick it up? This can be applied 
cleanly to upstream kernel.

Thank you very much!

-Fenghua
