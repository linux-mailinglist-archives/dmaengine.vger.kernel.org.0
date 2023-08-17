Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C0177EF10
	for <lists+dmaengine@lfdr.de>; Thu, 17 Aug 2023 04:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347644AbjHQC0D (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Aug 2023 22:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347646AbjHQCZz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Aug 2023 22:25:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296D9269F;
        Wed, 16 Aug 2023 19:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692239154; x=1723775154;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0QIDvIm4X4Mmku8DbDogr656ajJQX8sgKUZKMtslWUM=;
  b=FNr6NWlHg6CQcxNXGQzA55EpL6ymdUy8sEGqS7NbVtr7MTByyf6iy0t+
   jdpxncJYXoSGhltMOzfNcN+bB4TFnHRR/hsoDsStcbtLH43mzL86aj3Yc
   nSLW6SICG5zC2dAT0nfYQP3tyeFZzWZyOQc3Hl0wohklnnSDZPe0kVWeu
   qmW7YJysUWYqT2Dks8sSeNWSrOANs2C4OpEf9EFXy2Di9B5ocCyLzIamb
   kZjYPlmdC9wQDpv24THfKteaOe2rkryNcmK0q0/54pJmJye+dMDbu/YRn
   mHj2Dj4CgVVchl2kOVYLGlR/UNBKgNUdZ6dEAT4nROLjdLKNo2JcS6tfu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375458197"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="375458197"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 19:25:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980959411"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="980959411"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2023 19:25:53 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 19:25:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 19:25:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 19:25:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYhbxJwJ45zlhM6GmZUb9dAXsWg+kvty6LcW7FK5qT4dcSqteEcYdw0Ezeupp/ajLB62i1iuwJWfoVYxzSLyjQSChZikcchS/kMO8W2KRjBzb+QOndLlp6k0T5xblP0Mny+YNOwEiVOINh9Q/voFNu0iJb11cJEIxxUx1Am6vbnxeF36c+ln6ccNHVU6I3pxynukRAVZdM4G3AzJDJs6VfwMq9kv4ArOhLXjwRwIGaTXhZfad+TPmgDAGcWbgK5G/DLMrT4jSrG6xmc8SSdfR99XY9G2/hJteu0/9eh0y6NpOtBMp84zEO8N9bctYlXSqU5+WabBCIlR55PBbugpVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJA8zGryOOqXe/bxK1tmGbUF7OCAEM6H4UXc/4NowSE=;
 b=mury/aGZFfVl6Gjag6ZY+cLs+fCTEg5H2xHPhLbRQx7pIPtbdKwK2rmF441ozTBmboZKCEaAnps0Camymwk0PKtfTp+JxJndiucBFNbTLC8ILoC6hTm3UNOXW7U/OvhcjMNtH/sbBJSzA/1lpbV5L3dGQ4eACf/HIGL83qRfpb2BD5lUizCbThFmjwbr4hA8aR/20iBX3Ugjij0C1xXhm+7of/1rrRCAxl6ZOk44XTOXLNfmOZN+IXc7H1gIx3WSZPFtdPi2wnXT5noImaDVHm/fOzsfPfnvWQoeI1guvA5BRTGm5Ze+AK+f3MxvxCcSw7wkv8GoDOR2RB8WSdQUQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH0PR11MB7709.namprd11.prod.outlook.com (2603:10b6:510:296::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 02:25:50 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6678.025; Thu, 17 Aug 2023
 02:25:50 +0000
Message-ID: <2dabccac-a017-17d7-cd64-736d078af0a9@intel.com>
Date:   Wed, 16 Aug 2023 19:26:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 -next] dmaengine: idxd: Remove unused declarations
Content-Language: en-US
To:     Yue Haibing <yuehaibing@huawei.com>, <dave.jiang@intel.com>,
        <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230817015550.18624-1-yuehaibing@huawei.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230817015550.18624-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:a03:332::9) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|PH0PR11MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: f88d0e6b-2b94-434c-1644-08db9ec9460b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uCBkXmA7nifCY3a/3m/bqm6v7kchQGHMo2DSTDeIkmvATPSRMc1w9LgrRsQLPlUsRyMYBqFydaMCrgQtw1iuoBYysaY1D/wBG7tlEifXZNLF6q9YgY2Q1E563QjP8LkZIBJ8lzzdC79fYbfWvfYOOz9Th7YuA35Lxt3aXvGYXrDSrqcfeq0eD0FdWebx4A9o2uI5LRmV6Zzh86YOLB631upEPAAAKw0qtCUVw0+/OTx4goJ0+gRMd2GhOzTNjx7eEsD885jD2GXS/oB1GqIBkAFZfAzcJI5sOh9Yy9XjU4FRkDSfu0FG203pV21jkW1CBgjRykC8MmefUOhu37Sa+4xdTg3/N5xBcx38fSd0a17j1vzcQZdSCTKYlg1Ab3ujYzhhh3vGspk87s+srWO+EWlghq7wh1/A/TzSdlvQU5pEkY8onIbc9yeNrCcsXxLVyzQnLGXcl5TEQ4QcpqetEoQmxzamdu8LyOkpPn9ERXP9SRNyv+GFqWILkkC86Qn5JHV4zOzXQwfOXVYaoIlb0PbbY8eI25ybGHA9WJ4qgzM6nlY8IiXWKeMao5i6giaXGIaojjRSR8y3dMq2SMeJBEW0IXbL7qLAUpE64czt6BUasPKZpmupP7+aV+85czioAnX+F/mbcMkWjXksQQSR7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199024)(1800799009)(186009)(316002)(66556008)(66946007)(66476007)(31686004)(5660300002)(41300700001)(44832011)(38100700002)(4326008)(8936002)(8676002)(82960400001)(26005)(2906002)(83380400001)(478600001)(86362001)(53546011)(6512007)(31696002)(36756003)(6506007)(6666004)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEZnZ0xpRWdSeitrejNMbUt3c21KcE5aaU9qa0tYaDdwQlhWL3VJbmdadnRz?=
 =?utf-8?B?UGM1RGZUR2UyTWNRZVJ0Tnpsc0dPN2lHU29EWWM5WGV5YkNVNTBkUE83N2J4?=
 =?utf-8?B?d2tQRksyaThxS0hPSm9mY1dnOHlPeWNDL0MrUm9nc2tlSDIvRFlwUFY2TjNl?=
 =?utf-8?B?eHZaOExqd2VaZnROcWJwYmovUHVCWTBZc3hzT0I3VGR0QyszNGVxbzJNdlRh?=
 =?utf-8?B?YXRHMmkzMnVQdHBhWDAwdGhCVnh1Nmo1YkMrYUtrKzRMd0pKNkg3aTFEcnZW?=
 =?utf-8?B?alJrQS90ZnR4VThJQytpZEozOWZEMlM5dXlUMGFFZGhlWGpibFdJdXMwL2hZ?=
 =?utf-8?B?blNqS1Y4Umx0WllKRHFjMGZ1Nlh2eHNBcjBsY0hSK05vRnJ6Y1U1MzJvT0My?=
 =?utf-8?B?Z2VnSzl5UXU1UlJWM3dNeVRLNlF4dlVNbTBlSEM5OWdXc0o4cnQvM3JqcU9T?=
 =?utf-8?B?YlJsZVFnZE1ya2NFNTJRTE5XQk9oUC9UV1JLdnVuNTY0c0F3Vjhmd1I4dkVy?=
 =?utf-8?B?cVVzMUVWK3hmVlNTR3pnUzhnWS93bnFUSEtsS2hmOVJhSGRVcTJPeklIQ041?=
 =?utf-8?B?NXpQSEczbFEvZ09JSjJnL0dWalp0VXpkcWZPWURXQ2xMSXg0WFBYUUNMN3VJ?=
 =?utf-8?B?M2FHY2xQNThEbHVENnp2SnVtRG1UaytSazNsSzhIbnpTUDdVd05UcFFseU02?=
 =?utf-8?B?UjZ2ekN3VDQwaDZWRk4wRjgvemlIWm54WjJkSjB0N3NxaFQ3V0RuaG15K3l1?=
 =?utf-8?B?NFVJdW5YdHZ4WDlCQ1lpd2p1MWh6T0F6ajNNVVVIYWw1NzFlcXJhWGhhZkYx?=
 =?utf-8?B?MjIxeE5vanRhMkZWR0pkR1hmVjYvNHEveTd2VXVLRm5ZYXFwbW1SNkszZlFt?=
 =?utf-8?B?Zm5RWnF6TEZVZUJidDZYYUZIdHY3QUQwMFI1Q090N0luS0FlUWtIS3djWHIr?=
 =?utf-8?B?TVJZU2llMGNoMm1wUE9GbWpaWk96U2NWSEppQzhTdklYVWh3RUtyaktLRnNB?=
 =?utf-8?B?ei9rNFB6U2RPS3ZJUDVwK21xcGw0UkZTQTFOaDh2T05RdXQ0dkhMdGJ5alcx?=
 =?utf-8?B?NExqSHZGMDQ1Y2pGZGJZTGJ1RlpxL3kyd2RVTnZSc0xHS0VKa001YmNydmQ5?=
 =?utf-8?B?N1hjR1JiTThIa1JCSW8yOVpVVTdjRjlYWXIwOW42LzBFbW1xVVErbjdDUFoz?=
 =?utf-8?B?U2RBcU9udm5CTEt1TjBJMzZFb2RUZmk5bFUwWGQrTEwvU0lZOVlmSHpRaFRK?=
 =?utf-8?B?eUZXc0h1dkJ6N3RST0VhdXFVM0hCbGtDQUJlK242Qy8yNWQ5TnRhak41T1RQ?=
 =?utf-8?B?WHZsTjBMTGpOZUNoV0dkMjlRYWx2Ym1heGtFNk0yelRwQXpQWEZTaXc4d1lh?=
 =?utf-8?B?MDh4Rjg3RGtoL2pDMjcvUGM5eUhHSGtGR0pPYTlYN3lURDV6MVBnNkRxMkFN?=
 =?utf-8?B?eDVqYloyWVRsZng0SkE5VGl4cXE5aVNWS1gxdGtKR3YwRjR1U1pMSnlicStn?=
 =?utf-8?B?dDJmUk15aUdOUUpMdncra3JLQ01VVUV0WEZBZmEySVVkampzRGNObWIvZE5o?=
 =?utf-8?B?RzF5eFRDUmZIM0ZacmRyQ3AzWGlRM1RkZEJwU3RwWG9YbzZjWENuUnlmWUhS?=
 =?utf-8?B?SW5TV2pyUGN6dExWOUUvY3ZMc2VhRk5ZNTk0RmNYVkdhWkllQVVUK1BHUWRV?=
 =?utf-8?B?K3RMaXpMSS95VEtWYVl5Y1MrOWFhUFRrV3ozbWErU0Q1WW9EMDNGaWpjU2Zm?=
 =?utf-8?B?MzJtSlhtN0U2d0ZzSGRwd2YyZmlnUUl3UTlIZHNUcTEzN1M1SklCUlZOUHJF?=
 =?utf-8?B?cWFoa2ZrVVMvK3JSY1NDMmtJRVRscWZ2NFZxTk9Cb0hTaWJVejVCWG9kQXVF?=
 =?utf-8?B?TU8rTG13NWpRQjViKzIzcXlrSEJXZ3BYaXZlZEFNOHNybW1VVlJFTHV3NnNr?=
 =?utf-8?B?WUtyVkFPK09CZEl0ekI0enJoVkR3blE3ZTFqcGJ5ZE9RK1U2UnNWTzVqTlNs?=
 =?utf-8?B?eGtvRzBYa0NjT3hYS2JTR3lUdVJQUDlGWi9RTkl5UXlKcDRKMk5BeXNCM3cx?=
 =?utf-8?B?Y0dvbjAyTm5uSTZaT2labHo2bmtvdXZkNWpHSk5lOHUvTGU2MjREVFIyMUFV?=
 =?utf-8?Q?OamTCysS2cCG9519AGIzbZtq2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f88d0e6b-2b94-434c-1644-08db9ec9460b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 02:25:50.6515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAm7PD8IrrBUz6RFMSiwSE+bZHoBwYrxTcIw5EepCJC2TUbKQJBDdTf1CRMafEt/S3qennQ5mqT8toKOSXBHSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7709
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Haibing,

Could you please remove "-next" in the subject?

On 8/16/23 18:55, Yue Haibing wrote:
> Commit c05257b5600b ("dmanegine: idxd: open code the dsa_drv registration")
> removed idxd_{un}register_driver() definitions but not the declarations.
> Commit 034b3290ba25 ("dmaengine: idxd: create idxd_device sub-driver")
> declared idxd_{un}register_idxd_drv() but never implemented it.
> Commit 8f47d1a5e545 ("dmaengine: idxd: connect idxd to dmaengine subsystem")

This line is more than 75 characters. That's warned by checkpatch 
script. Please break it less than 75 chars.

> declared idxd_parse_completion_status() but never implemented it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2: minor commit message changes
> ---
>   drivers/dma/idxd/idxd.h | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 502be9db63f4..e269ca1f4862 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -660,8 +660,6 @@ int idxd_register_bus_type(void);
>   void idxd_unregister_bus_type(void);
>   int idxd_register_devices(struct idxd_device *idxd);
>   void idxd_unregister_devices(struct idxd_device *idxd);
> -int idxd_register_driver(void);
> -void idxd_unregister_driver(void);
>   void idxd_wqs_quiesce(struct idxd_device *idxd);
>   bool idxd_queue_int_handle_resubmit(struct idxd_desc *desc);
>   void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count);
> @@ -673,8 +671,6 @@ void idxd_mask_error_interrupts(struct idxd_device *idxd);
>   void idxd_unmask_error_interrupts(struct idxd_device *idxd);
>   
>   /* device control */
> -int idxd_register_idxd_drv(void);
> -void idxd_unregister_idxd_drv(void);
>   int idxd_device_drv_probe(struct idxd_dev *idxd_dev);
>   void idxd_device_drv_remove(struct idxd_dev *idxd_dev);
>   int drv_enable_wq(struct idxd_wq *wq);
> @@ -719,7 +715,6 @@ int idxd_enqcmds(struct idxd_wq *wq, void __iomem *portal, const void *desc);
>   /* dmaengine */
>   int idxd_register_dma_device(struct idxd_device *idxd);
>   void idxd_unregister_dma_device(struct idxd_device *idxd);
> -void idxd_parse_completion_status(u8 status, enum dmaengine_tx_result *res);
>   void idxd_dma_complete_txd(struct idxd_desc *desc,
>   			   enum idxd_complete_type comp_type, bool free_desc);
>   

Thanks.

-Fenghua
