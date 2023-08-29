Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD5678CBDB
	for <lists+dmaengine@lfdr.de>; Tue, 29 Aug 2023 20:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjH2SLv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Aug 2023 14:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbjH2SLo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 29 Aug 2023 14:11:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA060BE;
        Tue, 29 Aug 2023 11:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693332701; x=1724868701;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X72np5QbkjGTMjJ3gNKsDewv16OCYcbTOvLiuXQHLuU=;
  b=E0aft6QcflT2gUqw13Fgj4ScqQFHgj5XJ14j0EE7TjTt2PEpdEZoVrrr
   rL21HgMpypAGokdMZA4WBQwhob7KvYwLf+qpM2xYoZRsuRXG3nHO0whG+
   t95xhR56JpyLTHCqjWJFfgSjfK6R7X7cDcoljYCAv1CdK76ChdePRvPB/
   ajfmHPnjWJlWRW1ArFhXTuhrxlYUdOkfWIQTrfrahFUs7mZXie8YeDmCc
   m0UOFcjFGixrGrRCCh23LJlfDwbWJrsG6KGmEGWgQoGDkBa7D4PfpyjAX
   izV7xV03u0zBYvc5ANeb5WZpDQ/0Z4LbhLFE/TFa/3AL8suBxP1H2sp2I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406442583"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="406442583"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 11:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="741919086"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="741919086"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2023 11:11:39 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 11:11:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 11:11:37 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 11:11:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FO2PeAAiBttncOSm2F7IuX6pGwzwSyWxiJClvqNCATpKAtyOCEpfGbZtqU524k4NVksC+jhzwHWhL8aMzvASrN0i+zSSQ9yvV2+DxXcA5NQW7Kvrw5W6MTpsn8C4q42QuZuEpnJkX7nw9X1RPGPMW9QG4xQKifktlhge4FDJk9MC8g/NwigKQPvRtQlG1PgSlP4TKPjjPKKznxoAlx+JxCQn0PWHXsEeZy9En9ZhbuQajh/3CmCFz6th1Vdx/+bgFJYTVVhd8L5kszt8P4mUnUePNGuyTRFrUFLf1tND3eFaIPRMsghLJFDgKD/UiUkiOj4f+yeARHbjb7CA8Kn29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpIRGhP+UV5lwfZWhT67mxoMqL2pcxBSMD6s25Gz7lw=;
 b=J4wX8xER5Iuwg1nf+pKwKkWZu2pxE882eXh2l8xFSSo/Q2acF+08CebDflgxSOO4761kW3C7i+H2Bm4Zz9seCfrOLaI1XEzxZUA0c1SJ/1Nq4lkYj/pRqsNkkUkTmhaIa+O4YeiOCZnou2yCEc+GXVarMheMYjqoPMNXXPNNYfTK3MP++u0vql9R0EkrgovsJcG7wtR5K1POSmTLeu51Wqs7t6LXT2yPT/aLKn4Z4Ok/d+WWTZzDNHQc2N2i5CjOrCCBUKRmbL8c9g/o6KFla81+BXdh9rD1qQpBB53H8Ls4xYvnaJh2P4u5YHi4Al3pXQQPRer+/qUOE50nTbmsSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH7PR11MB6053.namprd11.prod.outlook.com (2603:10b6:510:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 18:11:36 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 18:11:35 +0000
Message-ID: <488969be-2e96-2bf4-974e-1bb5e7bedcd8@intel.com>
Date:   Tue, 29 Aug 2023 11:11:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v2] dmaengine: idxd: Remove redundant memset() for
 eventlog allocation
To:     <coolrrsh@gmail.com>, <fenghua.yu@intel.com>, <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-kernel-mentees@lists.linuxfoundation.org>
References: <20230829180027.6357-1-coolrrsh@gmail.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230829180027.6357-1-coolrrsh@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0041.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::18) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH7PR11MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2b20dc-dd31-4d06-ca96-08dba8bb61d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GLjhyRB2E/R6SwDHi9QsCtFyvWR66sTDTC/3TmsN6QCZir+4pv//UF/k00lhbbHY8XXvj2NZo7Urqy4uuIQXOut+hxt8BfOEX1Huz6W77e3qj9E0GxEA7oH2UhFN3X7Sb5OK3DlJ4fmiJDUgH3MhkTJmeY/jeV2GuNoFlQp3ICu9BNt+S/fJLPfJhRnsfIWFUKqU4g/fupiycwOc8mHvWbfNPDmX3Kx07Qx2j197qhcIbJGqKAtH2rdiBDM+R9F6Wh8aCsJ9sAZQ72wHzxRInewsJo4ogtZkMo3idTXCLZIkOaTDsullC2Vq80tVl/HhfujU4na3a9xTvYAjDfHlubOc/jkNsDuFSmolGAfZ1K8V8SA5aTzCOVug4u0R39Su9F5279zKjs46A1Q2AboNwK96h41Rn+u7vytYNa68GISSyAI+8VTyA2bo5ywRsA9VQuh3+IxXWF+ZWv/9u3zYNc1JIQjmdeLSgPFd8n9KspNtJ6YErWpmghqqQQXl5vW1jaaR+UjLoLoOpFG6O2a7YSK7GH5Wfvo35KMf9a7Ovikv1OMDG4pep7/vC6RSFJtQIyKUjwqQCB2ixrwPk7S+Ymod+4pWzogdfxdAXDYTCs7AuoDa6yY7M3RmL+A0oDsRiYSbc+yu4CZVRSd8SkigDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199024)(186009)(1800799009)(31696002)(53546011)(6506007)(6486002)(2616005)(6512007)(44832011)(5660300002)(2906002)(82960400001)(4744005)(38100700002)(8936002)(4326008)(8676002)(66476007)(86362001)(41300700001)(66556008)(66946007)(36756003)(316002)(83380400001)(478600001)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk5XQzcxZzROZWIyRVhoZGlYYnZxK1RyTmhHdytkUXBvZm40U2NxUnRSNE9r?=
 =?utf-8?B?dzI1SVRHVWJMMWdwSmZZTUp5RE1zU0g2cW45V0pJUG9kTDVBV2lSK3ZiUDMr?=
 =?utf-8?B?ajJNeDdNYnBHSXVkMnVneFJwNmZYOTQwb1ZFdVZ6eWRmd21hdERub3ZtcVFj?=
 =?utf-8?B?NG9nVGdRMFFhZ1d6WDZEMGZlWUlBTldyT010L29qeDl6cERuUDN2Vi85bUhU?=
 =?utf-8?B?WWQ2NVZUaEJQMlN1OCtiUWplUE1jOEszT3k1TU02aGw5b0F1bHhMaWx4Rngy?=
 =?utf-8?B?Vi9ZSVEyeHF1MjBKWWJKRlpmTGQ3ZGVxT3hwOUVSK09JbmY4cG1kQ3NhZXls?=
 =?utf-8?B?WmZQQWlJaWhraXZvbFM5bVJGUEZuUGNUaWJkWFE5Nzh2YnZ6VXV5eUd6TXB0?=
 =?utf-8?B?dGxNemNJMzRaS3ZXc092d3ZGaUtvS2VtVVVIejd3eUNldTRqTEU0NGVVY20w?=
 =?utf-8?B?aS9BMjNMUVZtbU9HLytkR0pucmpXK242blo5aXFtVEovM2luYTFZWnBRVlVy?=
 =?utf-8?B?VzhYcm0vVGNJc3lQMkJwSHFZK3RDMFk2M1JlTlBvTEs5dHhuMUpYeWJsc05j?=
 =?utf-8?B?aEpWczdXbkxUWEt3NlZUTkRwSitlSkN3RC9jVDlMN1pRa1NvVUp0WWtqeXZi?=
 =?utf-8?B?akpoYkVQTXI5aStxVnBabnhBMUh2RGlZRUJKU3p4SzBiSVQ4VFZtZnEvcWpo?=
 =?utf-8?B?cyswWk14Zm44UXNQNmI0Y3pFTVFIdmNFQjRzajhncXBjS2xsdDVCZVpKak11?=
 =?utf-8?B?TjZINDFWWlIvTUZPTVNjUTkrbTFVUmJwdTJnRVZDRDBtWWxNOFJwVDFjaUI2?=
 =?utf-8?B?cUduWk00dkNpRkNyN1ZBcDZ4L09MQzBQWXo0eGlVOGpyQTNQQm1lWEVJK2I0?=
 =?utf-8?B?MzJPelBLUjdqWGdKbkZPclN1RFlvZXA2ZEozaFhpT0pOdkRyUlBWa2wyam5z?=
 =?utf-8?B?c3dEZ2JrL0Y2dEV4OWNRMS9rVDY1dno1S0pwWU42M1E5eG9HYjkzZkpCRktV?=
 =?utf-8?B?M0ZJZG9xdDMrZnVsUm9JaldIZjNTOXFHbVlFWEhGcnRVczBlSjNIQkV0c0lo?=
 =?utf-8?B?SDZRSmRpMHJvRjh4SCt6NFFFN1pWV1RJblpZNHdsaWdzM09PNENYRitzWmYr?=
 =?utf-8?B?QVc4cW1DMnRrNXErdGhES01Jdzk4THpPUXRGeVNRbUIxUnpzWWNkeHdwQzVz?=
 =?utf-8?B?alB3aW5LemRUUXBUdVNvQU5hdGZEQ1RZMFhLMmdBV3VuYU9ZdnZkbi9EeUtn?=
 =?utf-8?B?Z3lMLzZ0bEExMkE3VjI1a3JhWDh4VFFXdFpWMXFQWXRkc2gydy9MRi93ZHcx?=
 =?utf-8?B?Y2tlOGJlaTRhRis2ZzFWRmNZMzMrNTJnVC92Y2hRa1JDVlVlQzBZbExrUzhB?=
 =?utf-8?B?dFllamVLNVExNXhuaHNrQmVvcXl5Mi83U0FhMTZkMlp2TW5NWHI1SWlwUUtu?=
 =?utf-8?B?eHU4RmdHMWxlWFdVTEhhSDFUamhtaVdMbXlTcXMvTDViYUV1OXpIYm9kdUIv?=
 =?utf-8?B?ZVM0WnNyS3hZeEw5WUs3ZllFWmNwZnI3SW1OWXcvZVZyc0tPSlF4ZmVGazA4?=
 =?utf-8?B?MlExK3ZoUllQelJlWUw2K280NkdDVWJnNE9CbjdVekxkaXRvRGtpSHlWU0tm?=
 =?utf-8?B?MjRGMDRoa1VIY2NlMlFIbm00TEYvVG16MlNCbnR6SSsrN3c5aVpsWjYwRWRL?=
 =?utf-8?B?eUZoZnFtRitYTUN6NXFjTXhFVGZ3T1BBblZxZXl4NytvMnVYbzdZTFY3bE83?=
 =?utf-8?B?SVdwcFR5RGpueldVRDhyQy9Ua0E1K25YeUFEeEVCUk9idEhMRkkvY3FraVlZ?=
 =?utf-8?B?K3V0Q3JRUDhsQjk0cm5LdzVxMmoyU05GTjRlaXBSMWVFR2Z3cnhSV0gxQzVY?=
 =?utf-8?B?Z3FSTU1uL0xlMzByTHY5bmQvQUhIOWttZ2dwa0Y4WjN6b0tNMUNhVjE0RG9j?=
 =?utf-8?B?amNsVmxiVXF1SnVSTUp2T1cwRFhqWnBSZUdGN1B2R0RrdDkvenRpbFdBWjBw?=
 =?utf-8?B?RUtWSFgxZUkreW5jY0F4bEV1VWRwbWY2Q3dBSnAyUzVQU3ZuRzVmUHU3em5V?=
 =?utf-8?B?MlpWZHNka2NlUG1idGQ5K3htR1pud1E4ZmhlOURRaFVIdmliOEdSd2t1Y0pR?=
 =?utf-8?Q?KeEeq7x4qDc7xznU6KgGyKik5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2b20dc-dd31-4d06-ca96-08dba8bb61d1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 18:11:35.8918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJaHvy3FvvxWU6lhomt8EALCWYfmy16yY3RxPbni28PVy8yUAKX6o5wjPEl4xDTK4WUMjg00cybd+MraqcBcRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6053
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/29/23 11:00, coolrrsh@gmail.com wrote:
> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
> 
> dma_alloc_coherent function already zeroes the array 'addr'.
> So, memset function call is not needed.
> 
> This fixes warning such as:
> drivers/dma/idxd/device.c:783:8-26:
> WARNING: dma_alloc_coherent used in addr already zeroes out memory,
> so memset is not needed.
> 
> Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> v1->v2
> Renamed the subject line
> ---
>   drivers/dma/idxd/device.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 5abbcc61c528..7c74bc60f582 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -786,8 +786,6 @@ static int idxd_device_evl_setup(struct idxd_device *idxd)
>   		goto err_alloc;
>   	}
>   
> -	memset(addr, 0, size);
> -
>   	spin_lock(&evl->lock);
>   	evl->log = addr;
>   	evl->dma = dma_addr;
