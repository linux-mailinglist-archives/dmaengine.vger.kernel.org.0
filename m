Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C5A641035
	for <lists+dmaengine@lfdr.de>; Fri,  2 Dec 2022 22:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiLBVvX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Dec 2022 16:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiLBVvT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Dec 2022 16:51:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A37CB23D;
        Fri,  2 Dec 2022 13:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670017879; x=1701553879;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HFuQxkksoqh+tIpM3C8/G+i8PidxmZiZHzaK3PyNtUM=;
  b=ibohBHOaH/7lKC6mcosdpTEywLNQjCpHK8jzqUIFN7NE/Gl04Wn+l4g+
   UxMYvr3y/RRS1wz7voanJzrZPIeouGip1UzgiVPeVNEs51xxadLyKjvuo
   MWBIxykOUUUwyEMupaZ1FyVR3H/gvpK8KxIQ6JcuZFxmDf60tyC0yYtBI
   9f2BzmMML46rby61EKYTxhKt82h6A1t/f6GzCnwPq7wv4WuCuiOLuF1h5
   8SlBNzLMF4eo5JCVWHp6oS5O1/9+aRvaSXNN4yv3146a5EmanUqw+8smY
   8a7D5kYdImGwjAV6EVxou/PtZGAzHyl5LdpzK1H28n+tfn4fC2Oo1JWXx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="316079387"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="316079387"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:51:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="622845028"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="622845028"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 02 Dec 2022 13:51:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 13:51:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 13:51:17 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 13:51:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYg6+kU7VBCMJ2AUGISfNsIl1idhye4qxfffAfNesfbLXNdsxJTHQgV+1EKQilXFwxLFYuEOO6gL/domJR9mhIy+tpv3VTkXTyTsuYVyT5ZWMgPTqZPwfUOysi1fxv2LpEVOx+J4Beq+IS1Rbabhf8Fza+hrV84JUUDL/Xn4UiV36BkQBY6fNTNsAx6G+zM4Vk02073vlEeFd0Fho6SScjXuknExlu/V1OqyDE9lGSLYaFfXYx9j97pGBc1AVN1HgXjJbQCQYIyjGHoLgDUskhd+O6potTUFfZGhPzlWZ8GNeiDxScLRvcp2eiunSEP3G7dQ6HRgzo40Cz15jfXaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+1I4/EgARveCYQ+NMQ0IsHPTKxAlLMwetXqb5qcG9o=;
 b=REvYm5Z4kAsU4G24AyArdQJ5fCHTc716lJGewrWOrYgUVVmhD4GxDMxq0hnpw6W5d8s5GXrtC9jCsyXnP+UJoi5Gb6aQqxa18qLUUZgSoHqc71vZ5gs8m7lJUseTPhiQciUiWRD8IgYj/tE3Wrf3r3121+uTtEgbE7lHPmmLJuFydfvP/rk4hgkbzXi6kSKjC/TB/CihGh7fkEkVBjYfjNHGk7tfJ9jW96KJML0KSq/iAWg+k9bGHYLETK7D5bIrsrSJ0RkWA/uTug3vxFOdXGUbEhRJxcgDmHkQzawx+pAO++KmIAFCG4bQx3ypjBaCMmDeGa5E1JlaEok0R63fBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MN0PR11MB6230.namprd11.prod.outlook.com (2603:10b6:208:3c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 21:51:15 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::b518:90b6:52bd:bef9]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::b518:90b6:52bd:bef9%12]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 21:51:15 +0000
Message-ID: <d9a6e626-96fb-0593-3410-3bed6c3fb3d0@intel.com>
Date:   Fri, 2 Dec 2022 13:51:11 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH 3/3] dmaengine: idxd: Do not call DMX TX callbacks during
 workqueue disable
Content-Language: en-US
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1670005163.git.reinette.chatre@intel.com>
 <93b5d144bfc16e0c0f640d5f7cfaeda6bf08753f.1670005163.git.reinette.chatre@intel.com>
 <IA1PR11MB6097E887BBCE14CE2D47CDDB9B179@IA1PR11MB6097.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <IA1PR11MB6097E887BBCE14CE2D47CDDB9B179@IA1PR11MB6097.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:a03:333::25) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MN0PR11MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: a63d358e-3436-42cc-cac6-08dad4af553b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2rxEO2ESBe+vUn3vQYiaAeMN15XgEsuToN18BS1mFV5Pv5t+jkxe4ZnO+4hOwnXl00Sasx02xlBx21W8lVHO/kYs4valYe/53RZP5FyaW+OorhO5Hj7hUtf8v9Dd/NtDpApL8UalwQCnVMbC6QNpQF6QrLyNy9tBF6JCUTld4zShyux12JOp6FTCkrH2T/IqfMiv/SP0TwTN9zoEiXdHwaKR2JVpcTXfIKH2HO5V07JhdjPR4vW8UOB4GmfrfpGDFKLGePTCSDBu22l+qjqdH9L2ByYV1CPmeUrsarFf6CCB+XpAaha+K+3GogxMGMx6kvpinglHI60d841DfLCFo4WbFiFFJpyvCtsiNUbAmMl9vLNsz1WuvZh+zOmFFM9lqBvu1apeUJgLUKFT3g8NGuKcdQRLQIOWXqZVN4qC2oMtI8XFPHF6s7rfIXbHZKU9KxCjKS+EICBff1UYx62dkPuyOAcbOE0zwkoEsd2ngfiK/6cyOqNj59/cu1Qs+3yAXNbTPlzCc+JM89uIlDUL3jKUizIM92IIklInSpxAoAqzGBvS9/mPuRQ4GtohxwiBl9pN6uOi84DLPxv6cfanKH5sWs4dGONeLr9e9tQnGCZ3137QeLWPslJYgllxCoBY6X941Kmea0mSVT36fJnZUHma9bVCP84cErKCbvf8GDHeAIccH8No1muuybmPoGZd+NFqVyfiLBbqMMv4VULqhbc8CLxSmly72p0F6tNuFg8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199015)(66476007)(41300700001)(36756003)(66946007)(8676002)(5660300002)(8936002)(44832011)(86362001)(66556008)(6512007)(31696002)(186003)(26005)(6666004)(83380400001)(2616005)(6486002)(53546011)(110136005)(478600001)(4326008)(38100700002)(316002)(6506007)(2906002)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nkg3ZFpCMG5HcUd4QXdiUk83OEsrU2ZaYU9FOVNKRUpid2JETGhwVFpuQTU2?=
 =?utf-8?B?dmdFLzk5a29URVJNV1VrRlRETWNjaG1WeGllK1hZVzNpeUJZV3FndkN2VVRF?=
 =?utf-8?B?MzlJa05ZKzFINERXK2dhVWtOc1lhQXp5UlRVNFl2U1EwN3FaZk9rdTdIKzVy?=
 =?utf-8?B?VGxZS25LUkdkTEhvWkJNQmNzOFQ0OFByMWRWcjJlN3d2UllyemdHcXlrWUdp?=
 =?utf-8?B?VU8wV1J5aDhHenEyMlJEZUFERStXeXZ3UUVXcDM0L1plK3BLVTFINWdPYVpD?=
 =?utf-8?B?WXh6WGM3czBHUzU0Y1VKNkZYSElwa0Izazd6K2YyZFBMUEtxMTdvT0JaZzhZ?=
 =?utf-8?B?dk9BVjgvM1YyMzZEeis5M1hLZ2RsRUIwNFo1RytsZlBTSlBVbFd4eXBnT0o5?=
 =?utf-8?B?R2xWd3RSV3V5QXpOeTRHcDdxZUR6Mk9UM3NTTnBqbW1YN1kvYmY2UEFhd3Zj?=
 =?utf-8?B?WkR2QVB0VERSU2JHZ2ZqMzlRR0lOeUdwdmd0VmJYa3lGZFJqRkpXVGw1WFpW?=
 =?utf-8?B?NWF4UWg4a2M5bjBqd0JzbDJSVXpQcHBjZEJZbWNCR2g4VlFKc3pKak9xOThT?=
 =?utf-8?B?S2lHdURvSEt5UXNQZjNQVVZFVUVVTHRyRHp2VklvL0ptdlQ3SmhvWHp6dzdG?=
 =?utf-8?B?WVltbDA0NElzdnh1VU16RmEzYk1MZ0tmTWNCNXNNazQ0OEhjbVBJTE52R2ZL?=
 =?utf-8?B?VUdGQnNvQjBzWnJxTy84WFA0QmEzQTZOMzdkd1o3SW1GTEs2WXFyMWJmUzFo?=
 =?utf-8?B?dmhUOGNybmhmL1RVeGc2dHl5OEVjT0ZNOXhrbGZCclFURHlyOVJvRTBhN3pE?=
 =?utf-8?B?eU5Ib2RHM0t5Q1ZoWEFqdUc4RWt2Q0tiaW1jb2FuNVdJS3NtdUxCUlNFVUFQ?=
 =?utf-8?B?K0h4QU1VNlJWdXArWnFqejQ3aldiSDQxUGlnbjNJTkpJWElaMEF2NFlVUUxP?=
 =?utf-8?B?Z1QxL0RhSmN3bis3SzBjNW1wQzRHSGNoUmgxZlZiLzNpbXpUZk9saXRnR2JG?=
 =?utf-8?B?SURYTDRDL2hvRlg1RytrODlHcnRWWUptOE01amZlZUZCb1FtTzNWWk9STEQ4?=
 =?utf-8?B?cTY1RytzbmpnY1FLYUFGdU9FdlNxZnVzVDhSMkZFeXQ4SHdCckk1UE9GNm1i?=
 =?utf-8?B?cGgxMXdZODdiVDg4NVRrMWZydTZ2L0hBM1hneUFCTDJVZFdBemxNSlF1dnk1?=
 =?utf-8?B?cGMzYjhnUTM5U2U4cDBlREJCNml3YzJGaEwzUUU2c1BTamNRVkhqdmV4alZZ?=
 =?utf-8?B?cS9DK2RpeUpUdXBBeEM5MlIwK3I2T3ZENHhTeUt0R1dWZUlmSG5Bb0g5RUtR?=
 =?utf-8?B?UkdrU0xNNEEwY1dHdjlDU1F1Tjg3N3RGTkhnaGpPSHR2MEhLN0xYcUk3NGMw?=
 =?utf-8?B?Y3BMWmRuZjZoeUVxRVJvZzFpVnpjVXAxZlQybXJFdlpFZC9weU8yK0ZzWWsx?=
 =?utf-8?B?WUhRLzFsK0ZZS1ZUNmZ0R1dRK1NlWVNTSk4xMHpXNnBuZTNTQ3NRV09GMUdQ?=
 =?utf-8?B?dit5NDlWQmtoSVhGeGRBcm5hd1RmU0xjR0lQd1VCbE5zUlMwYU40ZDdZTTQ4?=
 =?utf-8?B?UWJHZ3FVWUdZbE1HalVnNi9UZTczblo5MW9za1RPV21sT0w2dUxtZWJCS01m?=
 =?utf-8?B?RnFid1k4LytBZzRaMGpVN2hxekFJbEJIT2JCRmEyV3pKbk0rOWtRTmdxcmMz?=
 =?utf-8?B?U0NNQ1RiVEt0WUNlU0ZTY3Y3RjZtSTRFM2F1dE5iNHp6bUN0ZkNKWnNNK3Nj?=
 =?utf-8?B?N0JORGlYSWJ2WGxhRGFXSExFMlJmY3lIdVZFOHZEM3FpY3ZQVWNHN0cvT0t0?=
 =?utf-8?B?YVhDajNJTXRuY0kxMXFkWWVKVEdqazl2NVREcTBSaGFUUzVLTStVYStTeFJB?=
 =?utf-8?B?QS9kNUxZSjZFOXhoVnVjbU01OWtPUUd5emVvUEs5cVBYTWFiTjQ0Wmw3L25t?=
 =?utf-8?B?L3JXeURVR1RHc0h0VVF3TWlPYk1MYUg3VGdid0c0bjRMZkVvY3cyQ2NmamEz?=
 =?utf-8?B?bXJMcklBRDAyMzhUb2c4T1NDcURLMUZZdStBTTc1VTROSUJVNzlNN1Z5bm80?=
 =?utf-8?B?MDFhWHhGb2RXWjVTREZKdmtWOWcrZzJPUU85Q0cxaTZ2bzJGZ25ZK3dobHFs?=
 =?utf-8?B?Yk9CWlJxTUJoTTR5ZnpXS1llOXNvZWpYSS9HRzFnS1pDY0d5cGJwdHoxTGxx?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a63d358e-3436-42cc-cac6-08dad4af553b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 21:51:15.4131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XaeGo6n7qlHyLJBO/j0WTDcMTpavN+59U91anxb3X06j69qPB9gfmL4omvm3Sf1UUyst30XrSjb0zodiH9Km7oW6IQYbdbtu2g8eVMYL//s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6230
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Fenghua,

On 12/2/2022 1:12 PM, Yu, Fenghua wrote:

...

>> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c index
>> b4d7bb923a40..2ac71a34fa34 100644
>> --- a/drivers/dma/idxd/device.c
>> +++ b/drivers/dma/idxd/device.c
>> @@ -1156,6 +1156,7 @@ int idxd_device_load_config(struct idxd_device *idxd)
>>
>>  static void idxd_flush_pending_descs(struct idxd_irq_entry *ie)  {
>> +	struct dma_async_tx_descriptor *tx;
> 
> Nitpicking. It's better to move this line to below:
> 
>>  	struct idxd_desc *desc, *itr;
>>  	struct llist_node *head;
>>  	LIST_HEAD(flist);
>> @@ -1175,6 +1176,15 @@ static void idxd_flush_pending_descs(struct
>> idxd_irq_entry *ie)
>>  	list_for_each_entry_safe(desc, itr, &flist, list) {
> 
> here?
> +	struct dma_async_tx_descriptor *tx;
> 

Will do.

>>  		list_del(&desc->list);
>>  		ctype = desc->completion->status ?
>> IDXD_COMPLETE_NORMAL : IDXD_COMPLETE_ABORT;
>> +		/*
>> +		 * wq is being disabled. Any remaining descriptors are
>> +		 * likely to be stuck and can be dropped. callback could
>> +		 * point to code that is no longer accessible, for example
>> +		 * if dmatest module has been unloaded.
>> +		 */
>> +		tx = &desc->txd;
>> +		tx->callback = NULL;
>> +		tx->callback_result = NULL;
>>  		idxd_dma_complete_txd(desc, ctype, true);
>>  	}
>>  }
>> --
>> 2.34.1
> 
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thank you very much.

Reinette

