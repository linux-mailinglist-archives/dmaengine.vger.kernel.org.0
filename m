Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B117AF0AB
	for <lists+dmaengine@lfdr.de>; Tue, 26 Sep 2023 18:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjIZQ2U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Sep 2023 12:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjIZQ2U (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Sep 2023 12:28:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEDCBF;
        Tue, 26 Sep 2023 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695745693; x=1727281693;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t4f9H9ok20j9hTTiQZ/IiBjKcw5ssj7pBNwjJAS4BnQ=;
  b=hBNTnER6PIjF/c8Me8Txzsmg+09CYlcegD3ScwOA+xocPMPiogMkIXt1
   kWSeDY+Xxf1PvtrJI2gwVRi2zEK+IGZsvnFXHrq5wajmz3jXlHOMI99Jm
   QxKAllQnp5ENtgvq+GpIW+GcQugTpX35dYE2INYRRdLTLBG1lo+Qy+YQo
   GvGHBM7s5X/oT89a3muU1bwVOfGgY9sE2vMh8smT2IbXOp3GzKMCRuhnV
   z13s0njvGPU5B6EKkQRoKB0NpTaPUVcBOhZjnep1+s8n9hOIukuaAAi6v
   P1YgWSWdtTKWdYwt98vWnMIiKGVvB+q457/J/mCWuez1RrYtC9cQ4teZE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="445741267"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="445741267"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:27:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752243622"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="752243622"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 09:27:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 09:27:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 09:27:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 09:27:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 09:27:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXJKQmsLJ1XTiPoeEf9FKUusDKhOE+EAzuM9UtsQyqcEucXrWjdkyLAKgcpilpVDtVMD3ZiSOGlCwcdna69aGzy09JUHTMX1hOyw5jEMJBB5lFUyrITp8TOtMWvRNLRRQ0llBj6xUet6gsu2xyi9ks7h3PDNAZKachmHMRKmsyB+VUFeS7mdAkHLzaT3lazKRbJQuBRB0dqcXhqC/8Yb4qa7k5STIhEQZLxXFURPiycE6ewujpkWp3IYzkib6qmoR1zbH/EA1Hi2v/IIgNH80nHWc8si6Sqb7AEu5NFLSrEChUvE1WoxgwwtQi0ZVyo3q9+/UFosf2Dk6t9fXN9Pxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxJuHhOSyadFmX3q+UnL9pMulgRPzmaCxrw5gVZ50S4=;
 b=fq+iUfiTJqgy0HMajCt7rwiDaza+5BRdR/PTQkaqoja7Mia1ALxyFbaqyhb/yMSCKGM+n8EF/Vd2/XLBDCc6XFpNG5yEgEWXmr86OyVkgzyLjSF+wddoAGbp6V6D4usCaez1x6PgW41wE1tJAyqYM0H3Sa1mhe8tds/bD5/95PCD1a7WBwk4/nn8aNYsW9pn6TQBBJAE/ejFC3rJrwClxelzRdi+q4Z0TGBOJnSik+G+fJJGwRmDdRZTZFbNV6V2jqNTjHWvP8HQ3HF/ddjSwTQM7JiS8QlBg93z99fzz0EWyfNuld+4U6NcT8xRfE+ru5sO6xKkm0YhWyTNAdf6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7141.namprd11.prod.outlook.com (2603:10b6:510:22f::14)
 by MN2PR11MB4629.namprd11.prod.outlook.com (2603:10b6:208:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.32; Tue, 26 Sep
 2023 16:27:53 +0000
Received: from PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::5678:c77c:3510:5b4]) by PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::5678:c77c:3510:5b4%3]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 16:27:53 +0000
Message-ID: <4d014356-cab9-f81a-15b0-0ddab8a5222a@intel.com>
Date:   Tue, 26 Sep 2023 11:27:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH] dmaengine: idxd: Register dsa_bus_type before registering
 idxd sub-drivers
To:     Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
CC:     <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Prinke <michael.prinke@intel.com>
References: <20230924162232.1409454-1-fenghua.yu@intel.com>
Content-Language: en-US
From:   Lijun Pan <lijun.pan@intel.com>
In-Reply-To: <20230924162232.1409454-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:40::21) To PH8PR11MB7141.namprd11.prod.outlook.com
 (2603:10b6:510:22f::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7141:EE_|MN2PR11MB4629:EE_
X-MS-Office365-Filtering-Correlation-Id: 455e6ebe-ea51-4e8c-4ba8-08dbbead8874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHtqqGpp58+jDTHbf9XchsUHDypLFtKgoGUoMMcNNZ41rQ3f83kzlv14XjJpZHLPrheOQS6ryOpdeofN4VXHkVib8jm/kmThNjABlnsvWUV8N6Uy5aF5KOBJ9Da/raBNh3lMUGIPbyUkW720b9sEckydE/yvW5uFu0J1fzI6z0oqVktgmST6ssZOR8wrY9Tptk7BAFBC6bi8Qntoajs2MKUb1kRb6EE3XKW0ycp9ZdNxO9PWCffLvjfs+QhudU2vOOwug0JKfOYN2CVr14Su2plOSbdG2AOEVCJkYa1h8SFuVz6THVISVbNHOonPpVsRdfxMj/jyIsUn+bDWxM3UwaDvR7kOh4lnWztyXSMMUHPKwXtiW4AoPtOI2BBEV+hXJ2AklsyJFMgqO6D5x/Oi9ChcrSB96YwxRVCd9I7Xe7RNUmFJbu46p3JwZFz/RJEN5yTjAC7tQ9TivO5IL0d1qKNBSCvRJinDrlzd/+MKRn27ST+xmUnjg7i/SoeLKYr/l6jELuLNaQ5qa/3BRsKxkq4Qn9k0A3g3h6YRniV2jFT9/ARMH5Julcdp6D29XuXERb1laACd/M7+/BccQKGMismtYwHW+pktjHq382x/pgbrAaahayBy2If8BNPTmFVLJIm8xUCMgmWVOk+bMfz1QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(31686004)(2906002)(6636002)(316002)(41300700001)(8676002)(8936002)(4326008)(36756003)(44832011)(5660300002)(66556008)(66476007)(54906003)(31696002)(110136005)(66946007)(86362001)(6666004)(53546011)(6486002)(6506007)(6512007)(107886003)(38100700002)(2616005)(82960400001)(26005)(83380400001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmhYSGorYkFXL0RTRFFKZ3BJRnVud3ZGemYwZDJET2w1ekQrT2wrdjVmemNy?=
 =?utf-8?B?TFl4ZThKR1ZFMjUxQ3c5VC9WUElybkxndjBHeE1nV2dZL1I3S09GR2FhTENm?=
 =?utf-8?B?Vk1qb1haY21mU0x0QVAyK2prWEZpVVdCelFHSkVqVGZtd1hqclZaN29hNzNC?=
 =?utf-8?B?NHZUNnFvelJJQ2hOMjZ6UkRPN21DTEdUMjVKYUtoWTNDZ1dFQWt2QVhkL3Mv?=
 =?utf-8?B?MlhIdEZYdzlKQisvTXdFTDFBR0tLR0FuK3dGYzBndzlRRFkvZ1VsdEQ1d0F3?=
 =?utf-8?B?WmljeWJZeVQyaU9Td3Ewd3RTeTNWYmZpdURFZ0xTWks5MzU5WHZuWDBFU1B2?=
 =?utf-8?B?ekNSQnA4OTczZlo0ZU1mWGovOWFVM3FLcU8ra3JaZlNYNUcwTlp4K1ZQSWNr?=
 =?utf-8?B?U2wwRUhtYnUxUVhSQzF2RDZsbXMzakpNTERhNUdrWXREajZGYVRWdXYvV2Jr?=
 =?utf-8?B?cW5rRGtEMlkvN0xCZHFwQTYxOGp5R0FRK3RwdjhpWGFMbzJJSDhVQ0VHSHI0?=
 =?utf-8?B?YjFzS2YyeFFtS0lhb1NkVWZXTWFRVjJrcEpBaTN5cE1jZUw1N1pCSW9Md09M?=
 =?utf-8?B?Zy9kWGNTZk5kMHcrVlM2OEh3clFBYXVWRVhXZTY3ZVBkTStWaHAycGFPdHBK?=
 =?utf-8?B?OU9ySGNzcFM4Q3QrQll3L1JyYlowZWF0TUZxZnROQTZUTUI3QWZMemFlbGlX?=
 =?utf-8?B?cXZPKzFJdXVjUTVUMndTVlg2SFdjclZpZFlOakpScEVGcjgxZUNoOFRlaHE4?=
 =?utf-8?B?NWpUU3JUODlDUngzNmtYbnovem96VXljYVBvcDk3RTNYMXVReDl6cTZKT3JS?=
 =?utf-8?B?UTM3c3FjaHVSNEY4cUd3QmhRRFI0SUVQTVJ1WC9kYi9YVXNxdGJ1bTc1anc2?=
 =?utf-8?B?b0dUODVoZTFYSzMxdmVkUzNNK0tWVzNVYVNCYnd4amNtbFVIWGJ4TjlROGNV?=
 =?utf-8?B?L05xcmRPYWN5SHBqT3UzQ0UvZGpKV1ozbS94WUEzbW04RUhrZHNvTi8ybnp3?=
 =?utf-8?B?a2R0OFZBek1hVndxOTBYS3p1b1hWeDRnK0JHeExLUEVsdHJrczhqZDBlOW43?=
 =?utf-8?B?ME83bWVsLzMrVXU2UjF3VEdoeUhDZXA3YWZTbWlUUTN2aVl6VUxSc2c2RmJw?=
 =?utf-8?B?OE40c1M4VWU5OFcwTU1vU1hoYmJjYkRpTzZvSFdnYzFyT0V1RURUVW1ScG10?=
 =?utf-8?B?ZXluN216RVg5dXE4b1c1YzRSSWlxNTUrMjhwYXJLcjdnUFpUMGF0STR0T1Yv?=
 =?utf-8?B?V3pkQW5OZ3E4MDk5WTV2NTQwV01pUEQ1b3pjcDVNWUlZZ1dsRXlPb3lKbEFa?=
 =?utf-8?B?aHBwdTkzOXNlamw1U0UvWlo0elFWcS9YMElEUmgwUU9wNGp6U1RKdXhkWlIw?=
 =?utf-8?B?d3NCRW44a2Z4TWRWbGdJalJlWW9WOXk0dGtqajhkUXBXVDdZbElXa2E4eC9E?=
 =?utf-8?B?ZjVrbWN4N3gxdnFjYzJodE1XYVhZMm9MUUErRklEeEpJWDFuMGttQ0VhTXRW?=
 =?utf-8?B?M2lzYjdRaXR6Z0UzNXdBV1cwYmVROC9ZUENGU25NRlBxZ0VER1Uyekw4c01Q?=
 =?utf-8?B?YVFsL0dkUFhOSitFZFFTaUl6bWNPMmVTWW80Y1V0NU0xOXgwVTZrUHFsYkJ1?=
 =?utf-8?B?WUlwY0tiQ3BuMWQvT1VJRHV1NHJETlBUa3lQODhMeC80ZlVhZHduNzRIK2FX?=
 =?utf-8?B?NGF2ODdpMUZkaWRuM3h5R0VJTUZqTWhiU0ZqT3JLMGM3Ym9BSmxaMTdQSlcr?=
 =?utf-8?B?akkxaUZsK3pId095OThla2J3NmJUcURaQXhiR1VNZyt5VXVpNTFVY3NIMHAx?=
 =?utf-8?B?elFUL2FRVTdjcTZWeEZDUkZONzhRZ2MzVk0vSk92K3haVUdobzkwaXFiVEFt?=
 =?utf-8?B?K3A4d1FJRTdpTE5XNWcwandYZERTL2lNaGZuVDJiTi9PcVVmdFpBOENXRkJC?=
 =?utf-8?B?RzhOYUdDS0FZS3kwbE9QSnBmbGtMaVRWVTVqTENGMVRNaXUzV0hrQVVVK25w?=
 =?utf-8?B?YVIwODlBZW9KRVE1MzB3dG1BQ0NpVXBFc2xROFZRbkY0MHp2enhHV3NEWFJ3?=
 =?utf-8?B?aFB6MTRqaXZyTjdNRkk0V2xMU0t0MEcxR1ROeDgzTWVPSk5HSThmUW1aQ1Va?=
 =?utf-8?Q?zwlYlITrZNdvldcxu73AFFBJ6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 455e6ebe-ea51-4e8c-4ba8-08dbbead8874
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 16:27:53.2686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTwsYsjMLRBRHphBnaHGji7MC0cP6NEfK0hwc9ttZ2ff4zEOhVkmd/GpvqJgpP+GN9YW6FVSTAx1/QZmHZaMvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4629
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 9/24/2023 11:22 AM, Fenghua Yu wrote:
> idxd sub-drivers belong to bus dsa_bus_type. Thus, dsa_bus_type must be
> registered in dsa bus init before idxd drivers can be registered.
> 
> But the order is wrong when both idxd and idxd_bus are builtin drivers.
> In this case, idxd driver is compiled and linked before idxd_bus driver.
> Since the initcall order is determined by the link order, idxd sub-drivers
> are registered in idxd initcall before dsa_bus_type is registered
> in idxd_bus initcall. idxd initcall fails:
> 
> [   21.562803] calling  idxd_init_module+0x0/0x110 @ 1
> [   21.570761] Driver 'idxd' was unable to register with bus_type 'dsa' because the bus was not initialized.
> [   21.586475] initcall idxd_init_module+0x0/0x110 returned -22 after 15717 usecs
> [   21.597178] calling  dsa_bus_init+0x0/0x20 @ 1
> 
> To fix the issue, compile and link idxd_bus driver before idxd driver
> to ensure the right registration order.
> 
> Fixes: d9e5481fca74 ("dmaengine: dsa: move dsa_bus_type out of idxd driver to standalone")
> Reported-by: Michael Prinke <michael.prinke@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---

I guess it was always configured as CONFIG_INTEL_IDXD=m.
Good catch on =y scenario.

Reviewed-by: Lijun Pan <lijun.pan@intel.com>
Tested-by: Lijun Pan <lijun.pan@intel.com>


>   drivers/dma/idxd/Makefile | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/idxd/Makefile b/drivers/dma/idxd/Makefile
> index dc096839ac63..c5e679070e46 100644
> --- a/drivers/dma/idxd/Makefile
> +++ b/drivers/dma/idxd/Makefile
> @@ -1,12 +1,12 @@
>   ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=IDXD
>   
> +obj-$(CONFIG_INTEL_IDXD_BUS) += idxd_bus.o
> +idxd_bus-y := bus.o
> +
>   obj-$(CONFIG_INTEL_IDXD) += idxd.o
>   idxd-y := init.o irq.o device.o sysfs.o submit.o dma.o cdev.o debugfs.o
>   
>   idxd-$(CONFIG_INTEL_IDXD_PERFMON) += perfmon.o
>   
> -obj-$(CONFIG_INTEL_IDXD_BUS) += idxd_bus.o
> -idxd_bus-y := bus.o
> -
>   obj-$(CONFIG_INTEL_IDXD_COMPAT) += idxd_compat.o
>   idxd_compat-y := compat.o
