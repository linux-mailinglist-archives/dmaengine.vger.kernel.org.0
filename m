Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2571751027
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jul 2023 19:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjGLR7X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jul 2023 13:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjGLR6z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jul 2023 13:58:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3F02111;
        Wed, 12 Jul 2023 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689184734; x=1720720734;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dbpoyLBM4MOVMkbE5mkYvh8zhu8e1+DhwsVB6C7E3YI=;
  b=Jc7I5K373LCIeTeNSM9bHtRdYNWpaCk3D3K1AH8lXl6pcjwfGTDTtqBn
   ZEzxBAn8YeZo/xYjw/K3cvfj2vK5YLNblbC+uPtj0OdZaEeAkuMn+49e4
   hxbqANF9XSgikoNjZs1+e2BwY4V+L1UUHSsY/gbDYTavfagrAJjMvkXLc
   HJHrsDKomX7nuT1boSvvUEIPCwnzGsuIeGUTSXVxmmoL/9iTJwkgVjuML
   nrqRXUYb1JjEOyx8lt9EwARQXQxxnQLoYgPXs/PvNTJXOJEP7BUUE4Y4s
   lqD3L2W24cP22pPd5JlODpkiTow73WPh9MDmWnRB4gq8zQIwlrwNOXKUW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="345276065"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="345276065"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 10:58:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="835257734"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="835257734"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2023 10:58:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 10:58:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 10:58:52 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 10:58:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqIpwmPbMcx0wqVNcoMqCFrMVfWC/PRrD3t/Ikf0h2Z6wdtCSYY7v74JC0bEpJ3+YBQ62YNC16M/59rUN+Qa5FU42nn6zuvH7fleyYo86RkNDRoy9J39sYRZq2dU4I+oL2dmjGoG1Jj8Ijb1RdrLEcLAhsl0eEIwRC6lnTmUHu3+NaztfAlLmF7a5cnKw1oqfNosurXPzA1L76PKtd/1Bm61AZelQEKiw/vQcR7H3Boy1RiZ3q3+8rQdK8fh6mRYL6WxCi+wcJU3AAz2mabgWBGjUk21BqtfmAme9Tk7hx8b/VrtYvi6vN6fck+NaaxKcD+WlN9sQ/3mXT73yE/L+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfL/cWInh4mB0BDtlFehtIN0HTfLdkTHqVU47WMQ+0c=;
 b=K7/O2bSKnxjSADIzLLsTOcWg/zKCY2AJPWRiCoBr53yRPEY9M1sFWFdn4Ql/Piokipf8C+51EAofyPTXc4SJEvAp2oH7Z4Jao9z/AVSN4gU5hC419TMuaufvpOV5He34QhfkHwQkHxkH79BsmXUtRChWMthid1li74fseoAHAoewWnOD3Ep4qct6rnb4oEy8k3bM6NgAB0jFTZQx9QK5qCgom0zToDcCwxm4ePInDb/Yt/Q107hsTql23gy5G+9pYkuQDzQOAD+NkakLMsRNCA5Tm1zKMYCZ+iKaC9VpzG7Adj0q+UQ8azX1JKte+2TytGPYZok09Y44B3QCViMOYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB7137.namprd11.prod.outlook.com (2603:10b6:806:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Wed, 12 Jul
 2023 17:58:50 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 17:58:50 +0000
Message-ID: <56681a68-a2cc-6bd1-3e29-dfc02bc07add@intel.com>
Date:   Wed, 12 Jul 2023 10:58:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.12.0
Subject: Re: [PATCH v2] dmaengine: idxd: Clear PRS disable flag when disabling
 IDXD device
To:     Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>
References: <20230712174220.3434989-1-fenghua.yu@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230712174220.3434989-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:a03:333::35) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: b26b2397-eba5-4a8b-5895-08db8301a598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RaD/e5RFk/l/qgk/Qngkqj+732y50vM/QGGb1WqXsIDrlAF8YlePLimZz8bNI50QUOoloyF6+jtxd2iIrm07DA3f2hafv2TiKEtufW3SP1kLKtGehhb8n5lPNQn4AgI56GZQN3+WpOKOZ+AnbiJQAW3DjwfnMKW4aNi1BHzX1pPcg8GC4luS5mPU9AlAQYGE8OvNpW6Fn5DPN5IfUnNGOBDZ5JpujkhgKxYO1xwRvYfqBQO6W/c/y1EEVL0//WpyoZFQmaW+LB9WQSsbhE6LZ37XHpJHQ1atw7uPrgIQwJl4fhM2e0aTQ7rgoy3+kKE0UWl8rFKWg4HFQZtHUfjrIgE13c1L+Mvgg72x1WAjJ3sK1i5kj/1O3MgmJ7axksjXzPqDhI0Nb0qpfi0A+EKkkSjd+s8TzEiRv7szaoZ3TVXE0jUoWfr2kpFfblKsF+GRr4C+IMXM+h2Qv8iY10Yf9CVngOnKiYuzBxjAy9k/TveHVx5cJbppgJv8HwDSc9MsuF/iFUc1OexJSiPgcppb9ZnscV/uWNZ4nXdOmmGCUkfuy5AHLru/VvMvzA3u28uP+TlPb1pgO5crazmXa0zuZD0tnoaJqhO15Y4P7cQ1KDKAMTxB0OKIliXgMNm4GsQSp5B/uU/QLoDZot3okfBxMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199021)(5660300002)(2906002)(6512007)(82960400001)(38100700002)(83380400001)(186003)(2616005)(26005)(31696002)(86362001)(6506007)(8676002)(53546011)(107886003)(36756003)(44832011)(316002)(110136005)(54906003)(6486002)(478600001)(31686004)(66946007)(8936002)(66556008)(6666004)(66476007)(4326008)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlhzYkhTUXByOTFBWFhPSWxscjcyZVJ5enZUWUxQeWdIcC9jdVoyVVVDN0dT?=
 =?utf-8?B?L3pFWW12RDFjSktaUEMzK2tPVnArTTlLM1RaUW1LSGwxNHhLeFNZTkIxSWg3?=
 =?utf-8?B?RDFDdTg2WGttQUtIckd5MklGK3dtQUNlRjZUaDBIYXg4Y3RWUWZsS2tKOVh0?=
 =?utf-8?B?YTFONk0xQ0crZUd6WWtLZGowQWM4VmpLZHdLOGQrdGFuejRrVzBiYjhybkov?=
 =?utf-8?B?ZTV5V0lhR09QMXpITzhYQjRFWHJEd0pGY0NGcHlJU3NYMXI1Wk5FWjg0UDNv?=
 =?utf-8?B?d3lBcHI0YitFcGkzbk0vMjdKcWJqalZBVlNtWHhmb05haGd3QkZEQ0NDRU1B?=
 =?utf-8?B?OTJ0NlhUeXZ6dStmUlVqM2F5QmFCc1JjZ3FIQzhRUFNpbjd1VllpNHpkRjRB?=
 =?utf-8?B?R2o2NjNPeUNlRmlsTVdsSmZLeXJYaFNPTENUUTNmOUYwZFhzTGNiaXV0ekV4?=
 =?utf-8?B?OWw2cmIwdWR5dGJlYUNraWVYeVlMYjV6UFpFQzgvTThxaEhqaVlubC9veEhS?=
 =?utf-8?B?M01YdjFWQzZhcWRxdXNtN2RSbHllanNlb2MwQTluNW0ySlVHZGdxU3lmTjJp?=
 =?utf-8?B?aE9DZVQvR3habnFpVjR0NEo0cXFEazVNV1J1VVZ2QWlZNndmUDg0OWN4S1I5?=
 =?utf-8?B?UU13SGlzKzlUdVJLcGdiQmRSWTBYOG1XcW50eGFJaURDMTF3WlR0Sm9iVUFl?=
 =?utf-8?B?RGlWc3NMdmgxQ25yV0lRSC80c0JlWnFoRHlZT3JIdUNyRFNYVGtwaTIxcGFr?=
 =?utf-8?B?ZmtCUWU1a255YmJCdkNZczA0V2xVc01lWkFmYjFodlVpOGlmMXQ5ZG8yS2hn?=
 =?utf-8?B?NGpUd2dVbXBiclU0OERGNzg3UHovQlJpTnlNVFNrRGwvd2U4clByZTdUZndR?=
 =?utf-8?B?VkJRNHZ5TTR1ek4zUHczaVpCbm9WSmZvTHpqWVBGMjhXUkZ1bTZ0UFQzbkM0?=
 =?utf-8?B?ZWNlclNxNHhLcXR6Uk1MY0Q0aVJxNFBnVUpUZ1JnOSs2OXlVS2szOHZHSExl?=
 =?utf-8?B?MGk1ZFo2bFVCTWx5VXNISGdWTE9XckxVbE43cEJLblF1TUFNeTQ1MmpyMGVv?=
 =?utf-8?B?K2ZucTU0ZDlYSGQ0VVQwZ3c3MGtNSVFTczEvSWN1WTdYSjkySlVzT3Vtdytq?=
 =?utf-8?B?Tm9uejJSem0vTkpKbWU3VDhPcFYwck04S2lvTzV3azQzK3k5Sy9sQWg1YVYv?=
 =?utf-8?B?eGhBUEZydjhQZVFzRjJjOFE5QnJSSGUwbXFXNlh2aUE5dE0wUjlYVEtManBz?=
 =?utf-8?B?RlBrc0xTZ3JXeUk3S1pHY1RXSjA1citCWDYycGRTOXpRWkZjbUtRcWtlaXhp?=
 =?utf-8?B?eVo3QnN2a093dnAvK0VmZCtFMHhMaUg0dXJRN01EcHVZUkdzbkE3b3d0cTBG?=
 =?utf-8?B?b3F6c0dkdjFiZ25aWUhxUjZFejREaWx1VnU5V0Q3U3BqczNjeGZYSHQ0a1NB?=
 =?utf-8?B?QnhPNFd6cENwak1RNUo4NWh1RjE1a1grTWxiWGtjR21RUGxxRERCSXRJdnY2?=
 =?utf-8?B?OEtkenY4elZtL05aMnVVMmlyVFU0cUNmajdUMzJOV2lqVHRjZ3U4c2RtczZw?=
 =?utf-8?B?U0JXaFBTOStNMnlVR3NBdjZobTY3MzNybk9CY1NqZGU1c2hzVWd5cW9lZEts?=
 =?utf-8?B?alRFeEZkQ2cwT3MvZGYzQ3BWRDBCU2hvdE5leGlTb1JreG90VUZ5dnNBdDl2?=
 =?utf-8?B?ay9OMEh6RkxEWjh5NWVkNWs2aHdZbjY4V2JUNzFHSG41RTI3WlNYQ0pRWnMx?=
 =?utf-8?B?Rno1RGlaNHJtbkFkYnJPeE1GbWpqR1g1TFhIQ3lESDJJa3ZVWUNHR1NrSlA1?=
 =?utf-8?B?MFllZkpMa3ZQaC8rN1VHRGMyMmt0cXQ3a2ZjZXVMdFdrTzRaaWI1WjFCbkZh?=
 =?utf-8?B?T0h3R01tMjUzUXhJUWxHVFVZUVp2ZWhyaFFmVFVNeU9vM1l6b0xjZlBnZlhG?=
 =?utf-8?B?cUZSSkhCNkxwT3lCV1J5d3Vvd2w0YjZoZ3JHZzB2Z0JIZ1doUGtuZDloUFUv?=
 =?utf-8?B?MHlhUXV5NVVYdHJubkZINUlqVFkwRGxyQlpQZ3ZLakNZNU04dEFTTERUdHJt?=
 =?utf-8?B?ZjlEREFXdU0wamlKZGc3SXZTN0NhVjdrWDJDaEc1bHBpYU5QakNha0JXS1FN?=
 =?utf-8?B?Sk1ha21QeFYzTk9tR0NBc2U0RUFyeEw3YXQwcTRwK3h2MGFpdE1zY29CVDdw?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b26b2397-eba5-4a8b-5895-08db8301a598
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:58:50.1391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMNBskngVXxGlzn4ymusVPWJ9GxcDkLj6tsUw858N7n5zEbtVG/K/KAFbJHaYZXc4QsPdfkvAEq5eSVKzlhpmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7137
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



On 7/12/23 10:42, Fenghua Yu wrote:
> Disabling IDXD device doesn't reset Page Request Service (PRS)
> disable flag to its initial value 0. This may cause user confusion
> because once PRS is disabled user will see PRS still remains the
> previous setting (i.e. disabled) via sysfs interface even after the
> device is disabled.
> 
> To eliminate the confusion, reset PRS disable flag when the device
> is disabled.
> 
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

Should there be a Fixes tag?
> ---
> v2:
> - Fix Tony's email typo
> 
>   drivers/dma/idxd/device.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 5abbcc61c528..71dfb2c13066 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -387,6 +387,7 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
>   	clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
>   	clear_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags);
>   	clear_bit(WQ_FLAG_ATS_DISABLE, &wq->flags);
> +	clear_bit(WQ_FLAG_PRS_DISABLE, &wq->flags);

I wonder if it's better if we just do wq->flags = 0? I don't see any 
bits we need to preserve. Do you?

>   	memset(wq->name, 0, WQ_NAME_SIZE);
>   	wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
>   	idxd_wq_set_max_batch_size(idxd->data->type, wq, WQ_DEFAULT_MAX_BATCH);
