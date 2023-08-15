Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C74177CFD6
	for <lists+dmaengine@lfdr.de>; Tue, 15 Aug 2023 18:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbjHOQDH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Aug 2023 12:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbjHOQCt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Aug 2023 12:02:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E4713E
        for <dmaengine@vger.kernel.org>; Tue, 15 Aug 2023 09:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692115367; x=1723651367;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N+f1ziggRs7MDAs5szRpSA8l6Xw8xvn9YOp/KucO5LA=;
  b=XcC33Tu1FMFSnC9XKVzee3jgsBO7vhgrB8gsGDFC3C7JgZYF7wVx9O3j
   tbz7xCAS+6Lcp/5oUi/Vew8l0kSpTKeI4qlForvu7+1EqbW7etNmNZEra
   BueSSDdig1pbe5TDhubX6+W9WFg11T7G53mLtxkcd8T/do2tUdKRMPBD5
   muFvZaaqDWXvUxCR5c/rtRi3kMfJsctrycGBg1RUrqDT9ZZnSipujj6Y+
   Uijjyf2MW5iijNQLt+rmFcTcZtxqQJGfxac2epdjTpuFTclA13te3M1F3
   oKz8tkMj35Nn1qJ8viW555gpOnXUOGRYTsiyEMF46DwltHz9peNfMgC7T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375081228"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="375081228"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 09:02:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="907659293"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="907659293"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 15 Aug 2023 09:02:43 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 09:02:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 09:02:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 09:02:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sk2JlDGjtHvfVM7mPDs/S2ySup/USPWw3wrUjLMpsY/XLzOreln0CghZkVI4Go2mSPNd22jqbFrg/poPYPkmbx26Fz2A4oOXa+lLU0Lk6LRrkj9bu2xP8n1N0jBjt+8jHqgJHLOpD4CAmCN4QtkyHUCZ7kt/Sp0+G0zb/a6fpTRkad2qovhKZ7BNDyBena7xwYbYqjeoci8cCatZy0iNyQkdNPPyXxxiw5pTgli6IJSUz1tjguaJBGyaO/X7SAX1SsrF1nIx2J25Pj7Oc8vDEGxIp+12G77yg9yxV6kII1ig8wlFMuNE+AOvoimaRkuzAGsm/+qY3q4KRxsV21oBtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o4EnfMDFO6HbVPkAdV0DGQ42hWG6hX7xufPhFHwE1U=;
 b=lW45JEeR8larAVS9NQBVegI7yyiBgkbTyEQRAjKyukVGu+PbmM74f2GJEY53+LHfrwaeIvbiM4e5wXO08ojJMwCXHiznx5AbZnoRiedHzJQlDH/1iRLs4rSnI2eHq8gcxwtv+Y++4r8anhMewHDE3D0LkbgXlyXOTfPxDgz+ppOTGki7duex3mMu1DZ4LQSUu+gmhlZVAKRBxxal1o25IwDG2IKKE7tdcU8qCIC19l4UCvXD0sinpysg3l/WYvUR4RKAIM7Q9H4LRcn+q6d5PSgxs3i5673t5Fp1IHIwqWo9flwOBTM3p+qr5Pjsq78anCTpk37Dgk7QJcgb97YX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS0PR11MB7852.namprd11.prod.outlook.com (2603:10b6:8:fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 16:02:41 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 16:02:40 +0000
Message-ID: <cc2f1609-f72d-4742-73a3-15942cb4a4fa@intel.com>
Date:   Tue, 15 Aug 2023 09:02:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] dmaengine: ioatdma: use pci_dev_id() to simplify the code
To:     Jialin Zhang <zhangjialin11@huawei.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <liwei391@huawei.com>,
        <wangxiongfeng2@huawei.com>
References: <20230815023821.3518007-1-zhangjialin11@huawei.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230815023821.3518007-1-zhangjialin11@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:334::21) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS0PR11MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 50513031-da86-49d4-78ab-08db9da90d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LgNXgvXlOQCt9Ze3IWtK0YRBDM5jHJP/P5IWGG+pGzgKyoDOqwP0yVAiFg8ewhObMGV2V9cCkazKKptm09khyGzc4QgrWtArooE6ckiuY9tFLYK05osFCYK4quFcAH9Z3ZTeZjYIxPL3YpaDGwfTfibRA8GK0y0gxJjwB0XZ6PQEBillZK3BDh55eqXzJZQDD675ZShubjZMAytyH4RRKyBmJ+IHNaB2c0aryi1E6BjV3/pmXQIaTAnH8rRSTpu/oolD0i1Yvnvgjd59LylYhajEX/o51mCaMpLrsTgYCZzhqb/s4iZr/DwrDf/NQ+nJ6nu6fuuSUhp7eOyn83T6unUIF37FwKtqoPfxsFVkySU2GN2bDpBxCctvRb6/oVZq4mySN4+sXlZyjPGyTRLK1Stip4lJIWVq2zEkUw9uylssUO5ztKpQ2Ri01lb2Scj2b3V4FlnH933dBs7H6N68Ai5twhXizvOT4Q0Y3EyE947FdldXYEd7gMDFL6hLbYqohbAiiXWbU75vhxGM9eXD9U/HHWO/zHeS83M8X4yfaGwVJa0IVg4uCcl7rhbkRwm2CKv84ij7FYaVDfDIRrMAsbqtG5Lt/oMlI4cm9yEBfsy0WJxOaun/ttGUMWE3PA4NKk94YKgUjI+BDDCsVyi76A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199024)(1800799009)(186009)(86362001)(4326008)(41300700001)(31686004)(2906002)(316002)(478600001)(5660300002)(2616005)(38100700002)(82960400001)(83380400001)(66556008)(53546011)(8936002)(26005)(6666004)(6506007)(8676002)(44832011)(6512007)(6486002)(4744005)(36756003)(66946007)(31696002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVozSG9YVnUxWklaN3hGYk5xd1VFVC9TMjlqRTlnV0ZFSFBPSzNNbXJlNzR2?=
 =?utf-8?B?aDlEVlp2ZVBXVXRVMDRyTmVUK3Awa2Q4bGxQNzNqOHVOb0p3NE96cXAyQUJU?=
 =?utf-8?B?WndoOHlWcXdIcXhMYmhieThMY2NYY3FRVWx6TG4wcXFWVXZzZkxsSjdaeVdB?=
 =?utf-8?B?REtCTVN6RFQ1NUpqZnF5ZFZVQzBDdXRuNzh4dmtWdjM2NmxhRVlVczl1eFRl?=
 =?utf-8?B?Y0dvQWRsaSt4SFBvTXNMQWJSbVduMEJJWGo0cWZwR3ZBSGQzNnRUTEQ1dHJL?=
 =?utf-8?B?YzBpNUFaMVZLaXFxbGNUR1NlZ3pGdVphalhVRGVXQmNCWXRMa0dQNHNpSEZ0?=
 =?utf-8?B?VFBWUmpOYVlUZ3BiZzQ2RWpjdjJ4M29ZQVF4V3RHZSs4UWxnL01aUmVvT2Zs?=
 =?utf-8?B?ZUxlaWJPVXQ4TnkvTmNILzZ4WStCdTBERDR3Nk9Uc3RvbWpJWHNJczJaWStK?=
 =?utf-8?B?OEp2ejg2cDBpaWttOWhZK09BRGxvU2hHWDVLWExkZVJGYUdZN2lnZk1XY2Vj?=
 =?utf-8?B?amRVVGcwYVZWcVRKZTZCQ0had3VLSzh2Sk4rTXVvcm83dGEycnRGMzhUdERR?=
 =?utf-8?B?T2RxeG5QcTNQNFFnQzczS3dENEE5SllSYXZKWk5hbkxEcHpGUFp4WTVYdS9Z?=
 =?utf-8?B?Q3pTR0ZVL1h5SkdaYWVnZ1ZHRVg2Z1BSVVVoR1RsNDJpK044L2Y5K2FQNUwz?=
 =?utf-8?B?bFRLMmFHMHBTb0hRTUVXV3B2NXZjREwwd0FWdFY4TE56MzFHL0ExeXhUekNq?=
 =?utf-8?B?bVQvVU9BQlJ3Ym9aNG15K1JwWjZWYkZZOUFtdFlvcUQ1aUd5Yk5JNEw4VGcz?=
 =?utf-8?B?TUplNndhQXMrQnFsVkUvQk1McGFKREFnQm9DbUlKYmdNMjFuY0JTTEZFRFBS?=
 =?utf-8?B?a25CSlVCSGdqYzltTkpVZURTemlGYXg1WVhrdEhMcVVVcGFGWGI0YW1SRVpQ?=
 =?utf-8?B?NFBvNXR5Zm5sZkdpcHpDaWRuWDZiT3VCMUU3VVdzeVc1WWdvQTZYT09yQTZK?=
 =?utf-8?B?V2RmK2lFNlNNS2VmYUh3bkpUNVJkaEFEb2hNZDZjUHRBWEs4N3Z0UjY0YzJ6?=
 =?utf-8?B?SUhVM25LRFlNb2VhSHc2cU1FMEQrMnE5a3ROL0ZsWHJOdkVKbEdwVEVXc3ZG?=
 =?utf-8?B?U05BRU5CS3RvUmJEeG9XNDg2bWUwTXlpTFVwNHA4WHdJdkpJWklxbitwa0R4?=
 =?utf-8?B?VWdZWDd2cUZ5bDM5b1V5NFA1RERCbGJNVTFxMmozdGRNbkxVeHJ4bUUwelB3?=
 =?utf-8?B?dUZ0RXo0encvaEhiL1I1VGJRMjlDaU1vTUR4K252OS9FZWdEVnFDdGpETVds?=
 =?utf-8?B?amFzdkEvaVpkYVJYMENoTlhNZ1AyaEpnaGJhZUdzN2ZrOHNVZ2RjelQ3ckIz?=
 =?utf-8?B?VHQxdFRsLzZESDBQMlNVaE5XWE5FakJEd3ZibGs0MFFYS1VCelIwK0Nvd1Y5?=
 =?utf-8?B?ZXEwa2NUUDQvbXNibFpSaUhmcVBEUExGY1pIRHlrc0J5MTdVdURIbEJEKzZk?=
 =?utf-8?B?Y2I1ZUVzUjJ3eGpGaFl2c1FzUlNTNzZ0NjNnMnhuUWl3KzdrMDk3N1RTL3Z2?=
 =?utf-8?B?NHE3NFZDeERqMlVGNUh2TlArS0t6dkxoMjlQR2tKMzhlQmE4ZGZoY0grQTlv?=
 =?utf-8?B?K2o3emM0RnJpNVpNUFExazV6SFprdFdsM0p0andISUYwbUxJVXNyYjVmWE9X?=
 =?utf-8?B?ZXRPNzhDeXozMURlblNsTnFSQkhVZmo0LzlmaGtJQUdLY1pvVTBuK0Z6Z1hl?=
 =?utf-8?B?SVJSZlpMNzBUa3FZSjlhOTNYcWFwNXZmVWJCVUJucVpWOVlEd2dsZVp0WkJ1?=
 =?utf-8?B?bk4wcm1OUFFIU1pUM1JnVzEzQ3VYdDNFdXg0Z2JXSjErSHY0Yzh0VmN4SVZv?=
 =?utf-8?B?RmprSWhMYk5pUDhSL2Y5V1U1UEhzZFZMUEhjVHR4U2lkdnMwVHY0aU12WW9E?=
 =?utf-8?B?MFA1dndqU0hQUnoraVU4VEN1YXJXTi9aRHBmYjljVnBiUjFISmIxMTN1TW1U?=
 =?utf-8?B?SEFCejZBUnRtWmJJbm9qdmNKMFZnMVNDOWRoSVVtWlpNZ2ZCL3d5MEVFc3Jh?=
 =?utf-8?B?aENPK1VSejVEVkhSODk0Nk5GenU4RXB4d1htUDZDNVhFaENYOCtKVURoQWV1?=
 =?utf-8?Q?3jSBdYMc1go2XpF9iug+0z6wF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50513031-da86-49d4-78ab-08db9da90d75
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 16:02:40.6841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEPU52b/VlOlXqRjUsQ9fqjHRmx/Ak3zE2YW1XocPgVMDSlZ/jbKyUYgb4vNoHLQCRpL5Uh8Vap0HlXffu6uIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7852
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/14/23 19:38, Jialin Zhang wrote:
> PCI core API pci_dev_id() can be used to get the BDF number for a pci
> device. We don't need to compose it mannually. Use pci_dev_id() to
> simplify the code a little bit.
> 
> Signed-off-by: Jialin Zhang <zhangjialin11@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/dma/ioat/dca.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ioat/dca.c b/drivers/dma/ioat/dca.c
> index 289c59ed74b9..17f6b6367113 100644
> --- a/drivers/dma/ioat/dca.c
> +++ b/drivers/dma/ioat/dca.c
> @@ -51,7 +51,7 @@
>   /* pack PCI B/D/F into a u16 */
>   static inline u16 dcaid_from_pcidev(struct pci_dev *pci)
>   {
> -	return (pci->bus->number << 8) | pci->devfn;
> +	return pci_dev_id(pci);
>   }
>   
>   static int dca_enabled_in_bios(struct pci_dev *pdev)
