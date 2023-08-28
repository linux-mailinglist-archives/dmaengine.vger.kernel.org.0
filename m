Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7066178B725
	for <lists+dmaengine@lfdr.de>; Mon, 28 Aug 2023 20:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjH1STt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Aug 2023 14:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjH1STe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Aug 2023 14:19:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE3213D;
        Mon, 28 Aug 2023 11:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693246771; x=1724782771;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sdcXLuTtB2arlZ+u3bQlzu2XgNPzGfRNBoR1eH8jtvM=;
  b=JRaruXIhvATjO3rdlBHs0C0JDFpMgfcnOcbd0o2BeIof2IpUbS3PtN8U
   BGqdK9qU1wESli2yQIlnLmJkSmtVowrbK4g7I9C5nGCgyVv0KYGU6RcEl
   XkBmRJ7cdv1wEeADe4PSQ9b4PKK7lXhcz7YU2hNAzKf1uQapLPRXvivHr
   7Cve8tD1K7hrTQbqyUy8sOXSA/1WwzPfCI0u4XZAQFYrJ2VteTUPwLih4
   bBcY5K6wOLURjqZUHAFJC3QHAb8nvIdItunvPW+x9EwOQrflkoxCJ7CJV
   mnJaFOEOCzXSvmfAzoEd/hyHCq7m5SkdcrYh119XcitTTXST1BhCs14q0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="375137253"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="375137253"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 11:19:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="852968164"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="852968164"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 28 Aug 2023 11:19:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 11:19:30 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 11:19:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 11:19:28 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 11:19:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLqDQVU+cO7qmI+aG9VgdxPJx7Uh/4JVx6mMo7Qs3oY7piNo0SXWHHr5uA3p8+TqG3icF+ig6ZKUTkeDw6A5fQs8l7babDaZCHxADrugXKiSUWmCqFm2lIOhHvfOPmGpnV4CdQkIupHQSzsXE1CDTzqVm3PM5LnAs0eT2kd/ITIWFm6cqWbDTejniiM/rCRefM1o6iwGBxDStGpiaLpaQWZlU1th+EJSbHJuMi4i4GZQsdCqbl3R1SCiVIeu6xXFPN9dv+03lvl2w5boTDmzf/bt0H1K+tVtnkR2umj3z/E1hQUT0uOiEZP9zb3mZ6rk3Qnw7Xdh1ht5f3UptqKYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOqZLAKKp9pjnl/zuPPLhTO+89kRbWQ5LAcbufQ4s3Y=;
 b=TPt5HRKc5m4jyZKSE1hMuMy8WVA2Rt6gX1Wwe4h2ZNB8QnNrEGbK/qv1Dtnpg0zznXHC7yCq7jbKpannaSgapXTnd8rkQQVBI7JMvJyo0uOBsvP2I+zzPNELO3s9wv3eD3UdhcKOZaINr4tbSxMFPcDdzTUodkvZ+wybXp5DvzvZy+NOdpb7xAq4KuHeSF4vSqlZ6Y26igpjCdaWhLAgwWlRnJagke4iW2RF00aXDdkcVR6JgSuzPJXWQSJnaIrEeFLT7fSDk13q8sQYBgq1Jhw1Ykt694f8XC4J3G4gAdKV9mriCrvmqbADnMypfMVjjri2Um79EePnXzOMGcv51A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 18:19:17 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 18:19:17 +0000
Message-ID: <37795c12-85f2-a9fb-dafb-fd181e04b86f@intel.com>
Date:   Mon, 28 Aug 2023 11:19:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] dma: device: Remove redundant code
To:     <coolrrsh@gmail.com>, <fenghua.yu@intel.com>, <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-kernel-mentees@lists.linuxfoundation.org>
References: <20230813132203.139580-1-coolrrsh@gmail.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230813132203.139580-1-coolrrsh@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::28) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM3PR11MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 703b76b6-be48-4d00-bc9e-08dba7f34a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nb5He+hPGQJtIUxwVpwGTxzfVHZSSvHnqeSnRWLWYS2E6TAqEF+ML7wcSKRyK2LtNNbjGB5KcLQfgnzFxxf+hUG56V2wPJ1TuHNFjJebxUKx2W777v4mH26VJ6bYrpwzA1smzgFoZ5978SXOq/YPp+vruEULJS/VKo9QxpSiVop0MditocUdxBXmDbD/JjoVdeLyqzNq11t7tSTA/4ZwOdlhhIdPjtweEEtLpY39CGuwpWUpsJxWmsPEf/HE3ritmI6CcUT8rEKfkX+tHvtm5sSEFa5ALavH0sBJ/UfX4Io2Pf2RUkbxZUOUOf+jrZYopeBCm/LKjnc2VUaQKTBQq2KM74G/sjodvJ9H+agNl9zJzzAZTWVO9xEEoJTKa6uBWcOIzmb71TfDB2Dxkt1smL7lI2J4FD5MRg24eBPQy5/zUllyTbGkAQDxcfLdYE1Qa+3ZvdEZz0aQJCUOuvWRvZZMb5kXvrTNsdocbkDbeqbGMZ4Wgg5O/W182IU8K52lCdRrw+CtJV6SHGCKaBtlq5Jzn91YbbrymyIeBbN9yE+qzaadi8cK4Gk7q+jCPeL/PmUxKkNjrlxnM9DNb7dWqq88sfoS8TaHhIdEROoZe6F04xPDxjYEINHR2EmX23wEeNmRrz/VBcuJPtnY+rbqyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199024)(1800799009)(186009)(8676002)(8936002)(4326008)(2906002)(36756003)(66946007)(66556008)(66476007)(316002)(5660300002)(44832011)(31686004)(41300700001)(6486002)(6506007)(26005)(53546011)(2616005)(6512007)(38100700002)(478600001)(83380400001)(82960400001)(31696002)(86362001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3prV3oxdlNQemE4cW9WSDBHeXIwK2hIOU1DUjRhUUJSaEgyNHJNQW5TWUhp?=
 =?utf-8?B?VUJ5aDhnYWhPT2VZVmZUY2M1Kzh1QjZaRGdIdnVvRGFaS3l0ZHhWVlpQbXpa?=
 =?utf-8?B?ZDBseXNwKzBkSERmZ3F3c1ZSejFscGhXdGFpWE9XWU1tWHlIejU1ekVnczQx?=
 =?utf-8?B?Skd0cnZMd2krWmhNSXhyeDJWVldyZ2lIc2hWSjNNMGQwYVh3MG44M3V0OTRC?=
 =?utf-8?B?U1NaMUZnTXBYT3JxdVJQVzZML2ExSGJTaCttcSs4bXNxTzNNMUhXSDFtcjVU?=
 =?utf-8?B?TkFON2J6NU5JNFJmUGk1ektkZ1ZJUnBNNzhBVzJWMVR4UmRmcVRsbDhqT1k1?=
 =?utf-8?B?Zk5JRm1UN0pSTmJSVmNjZDdiSWdPUkZrS2lnS3NTY2VrSWU2YUdkZkRmSjVD?=
 =?utf-8?B?RzIrZ2pKQmJnS3EvWDhWOTdXcFRscWJIbnpuaVdtaWhXOVBsU1hEbHduOStD?=
 =?utf-8?B?OXIvbXFDUEF2SE5XQjJOdDZFRmlSVDlqRTIxTzIrYzBHVGVBM2ZrRWpFUHNE?=
 =?utf-8?B?MVlJZElVNVN3Y1BabmdEMnBpVUFUVkR1SkcwUy9FeTNqRHN5N2gvaFplRDQx?=
 =?utf-8?B?WmFBS01nR3drVUd4QnJaU0VEL05zbzVlUTVLaFR6OTMxcnFCazZjMGVsYkJH?=
 =?utf-8?B?d0UxdnRvbE9ZdUpubUFkSW5IK1lJVDFDM0V5cy9jKzF4dU4xcktPRHZ2TS9h?=
 =?utf-8?B?TFNaaDVBWk9ZVTVMeng3TEVOMVdVOWt4Q1c4c3JsOWxJVnR2WGdhaW93RmJl?=
 =?utf-8?B?RlVqU0FlSWN3amlKV3ZwUTNsaUFMQllKTmpmT3p6NU1GKzhsVHBaNHpDMndX?=
 =?utf-8?B?eEQ1SStpdmRtaUE1RWNJdnk3dXNvTmR3eEViaGtpNU9TSU9WZkVGb0EyT1FD?=
 =?utf-8?B?RjM5QTFWeTJOTXdqMnB5S05GeXI4ZHJrQmV2QmpmK2RYU1E3dWtrZ0pSc0ZD?=
 =?utf-8?B?K2ExM0ZQcDZDdVFpMkQzM0ZoVWJENTNuVktlS3k2TWJyTVJ2dVFSc25rd0ZB?=
 =?utf-8?B?a1dmR25JQzRsUEw0V3kweUpCNVA2RDV6cXlxeUV4Q2ducE9hNVhxQUYxaGtH?=
 =?utf-8?B?a1F4NTJDaUVyd2pWb1U4a1ZZOGVxdXJMaVVucDQ4eXJRbUphcVhxM3U4YkNh?=
 =?utf-8?B?VUtUc24wdXZIOE5mRGJQYkhKUnc1VmVoVit6cE9mUEJJY2hyOHlMVStFaFBo?=
 =?utf-8?B?REpWZkZVVHYzWDZOd3JzeERQN0pmRldHcXN4MWdJOEhJT2crOW1nQWp2Wlhm?=
 =?utf-8?B?NTZTS0VhdDBFZUltR0Z4RWVIRkhyVFJpaml0cStZUlhBdkszVE12b3RHN2ZY?=
 =?utf-8?B?WVFOTzA3U29IVGs4Z0dQQUI0Y2NVemVJaWlPc3QxMnRDbjJ1L0x6Wk96ODBh?=
 =?utf-8?B?NFlVUTlSNFhmZllZcWl4SXBLOU84ZW5pRzhhWGxBdGp6aCtvZ3FMNUxpekhQ?=
 =?utf-8?B?WmxZQ3AzMGhmb29nTjRLYWRhbTN5QlFHUGx5bkxzS3FvTnBBQnhiNUl1THV0?=
 =?utf-8?B?Z1lyalZKMFBiUGlBMFY4OEszMExzL2NoekxoODhMTGZkeGR5cW5TeEZLYUh4?=
 =?utf-8?B?MmhMMTYvTHluRURXY0p0NVB4b3FlUG9kSkxYeExka2Vtd2dwVVQxOTBmYU9C?=
 =?utf-8?B?TjVOWXpxNERIblZyM1JsdndMU1ozQ0tiMVlTOG5iam9DNFVHZjdxeVhiMEov?=
 =?utf-8?B?Ry9KNjZrWnJzQng4U2JNc0YvbVVNRXQvRWZscjdVUHRQL2Y5Y2xVdFI1b0d0?=
 =?utf-8?B?eDJhYVBOOE5iN0JnNElDdCtKY3J6cXRZL2xlSjNjeEVJV1BZQVc1MDVlZjB1?=
 =?utf-8?B?ZjlkRWk3TkMyZ0d0M05tMmxKbmNmNmFrR0VlNlVOaHBEUk9mbmIyYWdSWmtp?=
 =?utf-8?B?N1FmYWFZV0hKSVJPRHVyYkVyZm84dEJyd2ZHQ3YxRHJzUm5WNTN6OTNlSzcv?=
 =?utf-8?B?M1BnbjBaMTErQng1ZGJFdTMrMTJua2JqZGVZYmRvbVBzcVpxY3k3bEFEbTNO?=
 =?utf-8?B?aWNnQlhNZ0xqczVvU1NQQmNFTXQ3TFA3R21iOVJOc003WHZzTlh6L2lUUWtW?=
 =?utf-8?B?RUNkZ2QyNTE2MUNzc3oraklOd2pPUE9UdDFmbW43YWNmSmFLcW5jd3c5TUN1?=
 =?utf-8?Q?uEUYtpa2Jj6tecyO14Mp+YhCQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 703b76b6-be48-4d00-bc9e-08dba7f34a3b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 18:19:16.9789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMu9t8tA2HqpFA23tkosYUnC3qmYzsFarRdh/pqMNE8CDLrMW10sVeACt0fVqKPV4EX2ZM3mFBUlH7afPRoEFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8735
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/13/23 06:22, coolrrsh@gmail.com wrote:
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

Please rename subject line to:

dmaengine: idxd: Remove redundant memset() for eventlog allocation

With the change,
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

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
