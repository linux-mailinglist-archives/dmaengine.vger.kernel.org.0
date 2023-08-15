Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B15B77CF87
	for <lists+dmaengine@lfdr.de>; Tue, 15 Aug 2023 17:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbjHOPsd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Aug 2023 11:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238412AbjHOPsa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Aug 2023 11:48:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C82172A;
        Tue, 15 Aug 2023 08:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692114509; x=1723650509;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6mZtV45/a0WWAWHEkzrhdn8/A5kxobe5kaCWwzIzov8=;
  b=mfpAArd6wBnxQ7uR4Yzea2zAMnFMB0IyoRzAZFtbSdV8WaAu1KbvmYjF
   Bxo9vhKHvY1LfKtUqh01clgupo3NJmt/RsU7iOR4RZO1B3s5+OOlorAS6
   n4JrALduyzh+yHRkdPuuiqxtnPsfjYeWo+rmcrMgQ75XzzwaOqWuTKmV0
   6gIfx1XcKW3/oQuJgKU3PVkVXzcI4qNXQKRper6w1Ibt/gh/FxKjpAAua
   ahtKp8SHunUH4PXKCosbnyA0oVefc1Kr8jOFnISyLiv546S6h82ql5yel
   n1L6pUTzlus2+LWfW8VFRMoaPEzMCh16GNGhvdZq82F/FS7TZNQLFrjDe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362459628"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="362459628"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 08:46:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="733883233"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="733883233"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2023 08:46:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 08:46:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 08:46:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 08:46:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 08:46:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+fIoAUWX5Efdf6tootrnEBPHuPxOwYsCWjmFUsrudz00DV+E4v4W4sI1iOx/5AaUM6F96idMormXINfUfyMFjmIAt9o+wxsnaKhiF2KFTLYpDzj4NXCusZ4IWY75txc5hwVNe8DHOuDne1y023mZy3BGYt4jxHhH+/5DCFAH+2wfAzOxt7oNDHlpy15dsjWmq0ESBTOw59WwLXoJNiB0hVbugeXVL/IKcB9C3Zd+aRkxiue9D7PpFDq8D3UGGtPEQ8SRvEvEfi+CFXZgYfCbpc7ACVTJnKb/3RbvIEmvnicu+w9eZ8pMTuPNjavCEQGbE0w9ajKBDVFsy01wRuTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25hwxbJ44Obyj6x/EeBgLhYWKb3/Ky88UjutNiL5O+g=;
 b=G2mh59aTevoFKmtUfoAeLy+WXa2oApxj2s/5fif6Ud79z91Uh2DQARiD8WahSaR3Zq9TqnlYLa1KfEse3t8STrYySyH3NyR5pdqdwh/vUt8qMebO6ELft8pfEIKdlP8qgZat1HhJdwB0+6Cx3FYoEu85CQodb2eV05JnsGojxEuuPwcFT7UxuEdjWfCY0qYgYNhyLfntAnQ1sTt3t2CfUJYSAtf+42Tct55tiRN+7IJozDO4nrX3XFsadknspU2kJvasEvZgveuRvZ+Hu8nOLI3MCtmAdbZb4tGL623FoViq6GL5ta7z1y3n8qXhrj7KRik7FMc2Za8xiG84bZEbeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CH0PR11MB5489.namprd11.prod.outlook.com (2603:10b6:610:d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 15:46:49 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 15:46:48 +0000
Message-ID: <10a54c9e-eac5-b270-c7ba-262d9b920aed@intel.com>
Date:   Tue, 15 Aug 2023 08:46:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v2] dmaengine: ioat: fixing the wrong dma_dev->chancnt
To:     Yajun Deng <yajun.deng@linux.dev>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230815061151.2724474-1-yajun.deng@linux.dev>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230815061151.2724474-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0068.namprd05.prod.outlook.com
 (2603:10b6:a03:74::45) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CH0PR11MB5489:EE_
X-MS-Office365-Filtering-Correlation-Id: f0026d09-e3e7-4317-7e0a-08db9da6d62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jFxLb9Bx8gz9EX+MYa4FMD5W6bk/Sp/Ucl+b4zTua9YJyF0gBGJ6FlZ4AgvZ7YT6PmEJr6AWr0vGcDeJPaeTpCis6UP1NotIPnBIiZLutRu9EJ+eYJAoizh5xzKPN//QPcWj4lh3DBcWrZoIUp6TVEgzLQ/p7MAl88CqAYfu8pfgl3+XVko2u1Ga0mw9iHsrtLqRvI4Zvc/QHJRRZP0aUsoJDIpXNhmbtc5m1A44eaAFy4yvb+bStR0x/uWBbZxnGB7l8wC1D6PlzAqSUJDeClRsCZjAwFBEXWPy5UhRYOZdipfsFdSkR39nuSvrFdcNxvTom3BYh0e35OiWG4n7ThzNFt1C6IXlREmzb5fEQ1M9+gPC3+M36Vv7h7to/DKUvbBpM8ftcJR6/m2yayYJoGuwJvLeJUiAXXp633Guj9yQhr3SbOmLHYA8TGH4g/3bjynKUcwpTQYO/vhc8OtZJLkWYiUn4faX15NqCyK83Yy54TeTurXahpQVyNXepbayvtQfCURuT5of96gyDzDdAUC1lYTz6HDvdh6nMRKbsTem82s+FmY6fSac0vmkyEuIhzEzkPh/MPGzMoBvO7FJ0XbQSEmXNx4SaOoerywFSmDkxoyijc+Z20pOMmw054GEy6/vg5CAOJ3kLv31CeT7oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199024)(1800799009)(186009)(66556008)(66476007)(86362001)(316002)(66946007)(6512007)(38100700002)(82960400001)(6506007)(4326008)(53546011)(44832011)(5660300002)(31696002)(2616005)(31686004)(8676002)(26005)(36756003)(83380400001)(41300700001)(2906002)(6666004)(6636002)(6486002)(8936002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3d0VEk1TFJVU3Zwc1d6eXE1ajMzR1JhREhUNzlmZVRBQ0VOcVIzWjBiOERj?=
 =?utf-8?B?M21QVW5DQVRSNU9BYmVKa0Y3ZVhYcGNPOXRub3ZyQXlVSDU3UGxLdG1HRWRD?=
 =?utf-8?B?NE1yMGtudzRrVC9PRGsxQ3NwdCtDSVRoSjRPMVd3N2Jza2xTRndRWFBsOU1B?=
 =?utf-8?B?aUJObStvb2tZNXRNYWNRNC9WaVNDWFY0M01hQjRmZGRQYmFVUmhsK1EvbnBP?=
 =?utf-8?B?ZnJjZGljZGVHMWFMaDJzbWU2ZVZjQlRNSHdLSWEvZ1p0c3hOWTdWTktRa3p6?=
 =?utf-8?B?SC9hMThyNWhjNkFOWmt4emFUSVdyZmNTQ3NsdmV1ZWY4ZVdTZnQ3UktPSmlO?=
 =?utf-8?B?ZkVQODlCNWk3R1hocDUvRVRiTkk3bzkzbzFBbFlmWmREelFGM2plc1laSmNo?=
 =?utf-8?B?aVY4c2Fkekx1dHQrYWJpWXgwOElhcW5hRlgySng2T045QWhxUXhPWTNRLzdS?=
 =?utf-8?B?OHhKUGRLLzQ2SUZ2SVJPRk1kZjV3ejZ1c0lWRzNwVFo1WEo4aWdMKzROQzNW?=
 =?utf-8?B?bjEvWlJZcDQreS9aRXNXWHJ2dFNXNk1ncWp2OGhpMFVjdFJXZHBHZmpRSWpS?=
 =?utf-8?B?QlFINWE4TnpjQlFNbjV1U2xQeU5rVU9raWI1MXhuYUtQdDVES2Q2Vy9haFVG?=
 =?utf-8?B?K1Z6Z1RZaGRHOE03Z2swWGw1UERZaGFZd1Z2eTBDallvcUZoQS9GU1B6TTFj?=
 =?utf-8?B?ejNIa3hGUlk0YUJ6ZU5Ucm9XNFJmZnA4bEpId2wvZmpaMmdOSGlIcjRiMEJ2?=
 =?utf-8?B?R2JQZWVyYVExcFZDSXpFV3FMajRMR00xQThjMmkzMWdqN285bE0zZVFoQjNM?=
 =?utf-8?B?T0JqbWhvQjBQVytzaVNqQU1nVjhSU1VhVzBjOHFtWERkQWFMTFdtUW1jMVlS?=
 =?utf-8?B?ejdUN01oQUM5SGg5SUxnNW9xTlFnM05ZOGdQY0F2enN3d3lHKzNPMTVGUllV?=
 =?utf-8?B?M1lMMERFSlZJVGJMc2ROMjRUcUFocWloVHZZdlBUbW0ycGFEdnF5cmo2cW53?=
 =?utf-8?B?M2d4SThTTzlQcXlGUFU3c1hoaWlVYmg0QmhaZ200OGV0ZTlFVDFaQ0ZNUlpV?=
 =?utf-8?B?djdqekc0ak9CQ3BaeWlnZ3lJUDdsQ1c2enFDRFVOU28yRWEyQmxjZGp6WWFS?=
 =?utf-8?B?K3owU1lNTkdvOUcvZzhvSkc1UXRxSlRweTMyWkhQUk9pMkhpWGg5ZlB2MjZn?=
 =?utf-8?B?WDNWb2g3S0liSTZPTlNjTWVqVFUzRmd4aSt6akk0WjlqQUloVDNCeHNvOWhX?=
 =?utf-8?B?aTYyUzkyd1JqOUNTTCticUVvSFVISk5hK3c2VWl1ODRsbU9yZDkvcmd3Z2tS?=
 =?utf-8?B?RFI1cFgxOUh0VHNiOHFPQ3lhcTJIUGRNV2dLZDJhMEcxdCtHOVA4aHlSNndz?=
 =?utf-8?B?TU1UZmxBb0pYblBSTkZ6ckF0akZVSkZyT3RLaUZ1OEZLR3A4S2Q5SklSU25m?=
 =?utf-8?B?amxBeTRYYkpXOGdWRjVzaFlNTzBVbVVaQVNyRmlHS3dmeE54bTY4N3VibGhO?=
 =?utf-8?B?aDJVaW5wRnhKd3YvNDFNYzA3UWY0dnZUYkNoN3QvWU5aKzVLSzhkRDlmQ3BP?=
 =?utf-8?B?OEdseitnSGdVOVVuMGhUd3lCL2RIdUJhVk5XclJVYWQ3R0R2VmlmT2Fad2RY?=
 =?utf-8?B?OHBaQlUzVlBtNXlicUROS3RRaUoxNHJMVlhZbWZ2bWhZNFdIMkdqdTdFeFFV?=
 =?utf-8?B?ZnBzWVVzZ0EwNlo1blZZSnpobmZKTzUwWjZvdk1WajNvZnEwY1FBK3hiVm04?=
 =?utf-8?B?b25QanpGbGlXck14MVlOeW40ckVKTFVqSGg0UE1EWTNVNElXelRuVGo3R3Fa?=
 =?utf-8?B?QnhRUm0zWHFMaEhSeXZhTHN2MmRNVVhkejBXM0FIYk5IT3hrTktMeHczd1Fo?=
 =?utf-8?B?WXdyNlJKQU9sZVFZYmo0MDBSbk1TazVLUjJYY1VLRUZaQUFZdFhWOVAxdndV?=
 =?utf-8?B?MlpjdHZlWFFBRm1nQXRXSkJ6bnpQZUR6SU9MN2dWQ3BidFJDbE9Ia3BvVWJC?=
 =?utf-8?B?Mk4yTnE5b0lIZ0xwbkhoTTBySFNBQjJjV3FlUzA2bHlzMEJmY0gvNXh1SzRF?=
 =?utf-8?B?NVM2K2Z4d1ZLZ3RYMzhqYXMrMFZHNVJrL3ZNOU5FZUl3ZVN3R1Rhc2pvUFJ4?=
 =?utf-8?Q?uDSppvCmMeQzH9uHfACqoeLTz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0026d09-e3e7-4317-7e0a-08db9da6d62a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 15:46:48.8230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjHLp8IBbMmtHEBeMkQZ4KX5dbQropT4xiikSMV1fnRePfQUMX/sd9MwHYF9Am2wiPvYkJ2xSkN0plia/Mkcjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5489
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



On 8/14/23 23:11, Yajun Deng wrote:
> The chancnt would be updated in __dma_async_device_channel_register(),
> but it was assigned in ioat_enumerate_channels(). Therefore chancnt has
> the wrong value.
> 
> Add chancnt member to the struct ioatdma_device, ioat_dma->chancnt
> is used in ioat, dma_dev->chancnt is used in dmaengine.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Thanks!

> ---
> V1 -> V2: add chancnt member to the struct ioatdma_device.
> ---
>   drivers/dma/ioat/dma.h  |  1 +
>   drivers/dma/ioat/init.c | 19 ++++++++++---------
>   2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
> index 35e06b382603..a180171087a8 100644
> --- a/drivers/dma/ioat/dma.h
> +++ b/drivers/dma/ioat/dma.h
> @@ -74,6 +74,7 @@ struct ioatdma_device {
>   	struct dca_provider *dca;
>   	enum ioat_irq_mode irq_mode;
>   	u32 cap;
> +	int chancnt;
>   
>   	/* shadow version for CB3.3 chan reset errata workaround */
>   	u64 msixtba0;
> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index c4602bfc9c74..9c364e92cb82 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
> @@ -420,7 +420,7 @@ int ioat_dma_setup_interrupts(struct ioatdma_device *ioat_dma)
>   
>   msix:
>   	/* The number of MSI-X vectors should equal the number of channels */
> -	msixcnt = ioat_dma->dma_dev.chancnt;
> +	msixcnt = ioat_dma->chancnt;
>   	for (i = 0; i < msixcnt; i++)
>   		ioat_dma->msix_entries[i].entry = i;
>   
> @@ -511,7 +511,7 @@ static int ioat_probe(struct ioatdma_device *ioat_dma)
>   	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
>   	dma->dev = &pdev->dev;
>   
> -	if (!dma->chancnt) {
> +	if (!ioat_dma->chancnt) {
>   		dev_err(dev, "channel enumeration error\n");
>   		goto err_setup_interrupts;
>   	}
> @@ -567,15 +567,16 @@ static void ioat_enumerate_channels(struct ioatdma_device *ioat_dma)
>   	struct device *dev = &ioat_dma->pdev->dev;
>   	struct dma_device *dma = &ioat_dma->dma_dev;
>   	u8 xfercap_log;
> +	int chancnt;
>   	int i;
>   
>   	INIT_LIST_HEAD(&dma->channels);
> -	dma->chancnt = readb(ioat_dma->reg_base + IOAT_CHANCNT_OFFSET);
> -	dma->chancnt &= 0x1f; /* bits [4:0] valid */
> -	if (dma->chancnt > ARRAY_SIZE(ioat_dma->idx)) {
> +	chancnt = readb(ioat_dma->reg_base + IOAT_CHANCNT_OFFSET);
> +	chancnt &= 0x1f; /* bits [4:0] valid */
> +	if (chancnt > ARRAY_SIZE(ioat_dma->idx)) {
>   		dev_warn(dev, "(%d) exceeds max supported channels (%zu)\n",
> -			 dma->chancnt, ARRAY_SIZE(ioat_dma->idx));
> -		dma->chancnt = ARRAY_SIZE(ioat_dma->idx);
> +			 chancnt, ARRAY_SIZE(ioat_dma->idx));
> +		chancnt = ARRAY_SIZE(ioat_dma->idx);
>   	}
>   	xfercap_log = readb(ioat_dma->reg_base + IOAT_XFERCAP_OFFSET);
>   	xfercap_log &= 0x1f; /* bits [4:0] valid */
> @@ -583,7 +584,7 @@ static void ioat_enumerate_channels(struct ioatdma_device *ioat_dma)
>   		return;
>   	dev_dbg(dev, "%s: xfercap = %d\n", __func__, 1 << xfercap_log);
>   
> -	for (i = 0; i < dma->chancnt; i++) {
> +	for (i = 0; i < chancnt; i++) {
>   		ioat_chan = kzalloc(sizeof(*ioat_chan), GFP_KERNEL);
>   		if (!ioat_chan)
>   			break;
> @@ -596,7 +597,7 @@ static void ioat_enumerate_channels(struct ioatdma_device *ioat_dma)
>   			break;
>   		}
>   	}
> -	dma->chancnt = i;
> +	ioat_dma->chancnt = i;
>   }
>   
>   /**
