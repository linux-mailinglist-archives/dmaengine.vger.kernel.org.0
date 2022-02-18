Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9859B4BC244
	for <lists+dmaengine@lfdr.de>; Fri, 18 Feb 2022 22:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239872AbiBRVm2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Feb 2022 16:42:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbiBRVmZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Feb 2022 16:42:25 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AF153723
        for <dmaengine@vger.kernel.org>; Fri, 18 Feb 2022 13:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645220528; x=1676756528;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AnRO77tqt6wgD2FpRxJaBrw/xCYVQINKWD65KwHY/JI=;
  b=HIq1XcnkxK8QAtevZthChWQOHX4htZjZxFlmj1JKmUUT9GjJ2RCZTWVQ
   cVYK15CUE0Xsi8rKMIXZSdnZevXzAkre3C6JvUWAiQo/KYx7bQ42aqF6Z
   k/tkXhaex75jA5JE4XQ3KlHc0euyBpKlw/skqionER5IFFus+ZouZQ5u6
   +eVwkL6fMsWS1U80K4cJ9HPE6BJSfKChgu+idI8NU6ZZpiv2TWKExjD5r
   ZMQURIh9I2QLca05DEdhEPDVAOhIgQ1QFxC4hmJWxXwmt3pl8ZAWgpTH+
   sSBg6BSO/ir3X8biWmuhFL872YQtbqftQnszCzQWFzTnjCoNSDxy2g5MW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="231852748"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="231852748"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 13:42:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="542023021"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 18 Feb 2022 13:42:07 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 13:42:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 18 Feb 2022 13:42:06 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 18 Feb 2022 13:42:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVmEp4x/ttbCtFO5J1uMczrit0z3QhHee15tWx4ugWICReX3BcanFxRhDsvJOXCKbELNMdf4mxU1sMdN4b8eYdZAuLn94jjcoAJf2/j5oihXY2LOTPa1oxYHwcLZD+hFD5pBI/S8M5i5SxyfKbdYRjR8eHkbHqvLTwJxeZiOVCdFaKX76BxrMNRuPoVo9NTsdZbEtHFIxzjdakAhA5CyUn5Gr4lFp7IOpaBZRFutl7Z5RxGJ2gPj4vZ9vly7Xx8Vw+B5JhGvu5gv+NAz2D33kwa5QX2bCbuO+5uFrT1hBYT6KJVyd/gPMe14QtwJVNQxi68kzbBEcR19lHKfysExkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41viJLZzJ2Mf64LJsZONwejRFirda8qGP248nDR/pFE=;
 b=MY3TeHoEUzfNHxToFZB/cS168h43QE4OBMgniCE1Gra51qF1yeg5hJUplf+SscZFmJhEWsYBdD8e7RKC95L14HOSGC5HdxABN5axFLhHNpC2HAVv3hWwOochmYjDoaO4i5zpoZdpTsH0s5LwUCUpOam+AwWRG5utXHfmqpqBgUuZ2xbPB/aY8KCDFiLB9TcYfrnxyVs2F2dwKv2iii7zR3oCwB208tMUXFDdQjZvAWmjOzcKz2Be2F63nbuo18L/S24SK2yn89VuqTTMbH12mA29LS3uLo5f0KhJ54RKMxWfyQU1656xSYfgqrUsU0curBPprbIQPja/qFbMjgOPyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2824.namprd11.prod.outlook.com (2603:10b6:a02:c3::12)
 by BL1PR11MB5238.namprd11.prod.outlook.com (2603:10b6:208:313::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Fri, 18 Feb
 2022 21:42:04 +0000
Received: from BYAPR11MB2824.namprd11.prod.outlook.com
 ([fe80::a067:681a:8feb:4888]) by BYAPR11MB2824.namprd11.prod.outlook.com
 ([fe80::a067:681a:8feb:4888%2]) with mapi id 15.20.4995.016; Fri, 18 Feb 2022
 21:42:04 +0000
Message-ID: <7dea976c-3685-84ea-d2b5-dfeddc0f2045@intel.com>
Date:   Fri, 18 Feb 2022 14:42:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [RFC PATCH 2/4] dmaengine: at_hdmac: In atc_prep_dma_memset,
 treat value as a single byte
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <ludovic.desroches@microchip.com>,
        <okaya@kernel.org>, <dave.jiang@intel.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
References: <20220128183948.3924558-1-benjamin.walker@intel.com>
 <20220128183948.3924558-3-benjamin.walker@intel.com>
 <YguS4m1dRci/nBmz@matsya>
From:   "Walker, Benjamin" <benjamin.walker@intel.com>
In-Reply-To: <YguS4m1dRci/nBmz@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR14CA0033.namprd14.prod.outlook.com
 (2603:10b6:300:12b::19) To BYAPR11MB2824.namprd11.prod.outlook.com
 (2603:10b6:a02:c3::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a94994c1-d916-4cf4-0c6a-08d9f327810a
X-MS-TrafficTypeDiagnostic: BL1PR11MB5238:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BL1PR11MB52386B2E137B537D87235364EF379@BL1PR11MB5238.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nI6R0FxGAaw4s7qEmoGNynRwwfFaYx4m+rTGEFw7Fz8BlrAszSCAB5Epr2J8AkNA7I9xtVP7hLWleijq94r5+n5Q+UgU7swoKm3idrXL8aFmr+LgC1MTU10IxDqro64eJdpjAG+As6vxm9zFaoVfFvv/EOqUN/9BTzmjvwquuDPPDsCgRZ7HDR3FL7zJcfG3/qBMNS3CBcPMv4CIW2lGrYKHMCFcFFCa8zada6Hpe7H00UKCxyumdkR0Qb56v7rorlp/lZjlH1SvhtmFroNHWo68ffTloyN6DmmCuscv7CEn1eYeoJYuXxP9XEhE0VzMU/MhqZf4I92whl9JF759JrGgGAsoUqqz6s1XhZZ2fHV3J52AkZ5cugSHQSxGvungbRG7f8LgPkir3YPQ8WEG4PX/j0mjpAR2MS4URkw5yzrfX+b5Vdi2qWVOD5TxIph02FLZVD/9v7Kq5P/yaNa8pCKc8XGKIMkTFfPOU0RUvt7WpOaaLQawrsfWVqazFi21ym1R5hDkUhVH/VF570TIKaLx67ZgCkJtNWNOGTtl7Qg4+khcXfGtcJpt6Lg5pIhYjGOrR1DT4vk4ZRR7PJTD3TK8nao8xKef2LjFF3lQPxmyXZjFbtBk36D8XnYOBgyQrPstiPAxh3W7FCebs9/LKmLpr2qrNmAaOBuMe2Q5FmTvlun72QPZJJQFtg/y/vNBTUkpr5s4hZTubvE3B3VfxgG/9kMLoYZhlaVIF48e3kGFhbtqaJ5XevZx6tUVXKX8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(82960400001)(26005)(83380400001)(186003)(8676002)(6512007)(31686004)(316002)(31696002)(2616005)(6506007)(6666004)(8936002)(6916009)(66556008)(2906002)(66476007)(86362001)(6486002)(38100700002)(4326008)(53546011)(66946007)(508600001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ay9OYW1kVVpHbHQ2aG1CeUt1WmE0RnZyMUJKYkhsL1o0Sk01aUJvbm5udzh5?=
 =?utf-8?B?YWdwRHBXb2ZyakJ2czhRYUlkMFVXT05pWXV1WW9yWDBhYUV0V0I3OENiRjFk?=
 =?utf-8?B?bUFwVm9qYlNLOWRGOTNTT2YxOFFSeC9OSjZYd2cwdFVKTXVyUFc4dDMxQWRF?=
 =?utf-8?B?cE9xblNmMzVTNS9hZGdZMkFkaU55TjNmWVNham9zMUc5S0dLWEhZRExsQ00z?=
 =?utf-8?B?cjJQdEowcE9NdFFRREluNVNJNlBVeVlPVXlLN3lXQjB4WVc4clBDSUp0TExi?=
 =?utf-8?B?aVBvVWltY3Mrb0QrbzhlQ1dGOXpIcm9KcmNLblZJcFRtU3lETS9PM2ROWE9s?=
 =?utf-8?B?VzA5R3cxQmZKUFZsa3RXdHVtdjQzWUxiUHhqN1BPeGNrT2ZCMU9EYnZWQTEw?=
 =?utf-8?B?dGh6SkE5RktsSnI4T083ZUcvTFdKcXY5MEZhMHNJMDg2L1VXNTBGWW13NXZh?=
 =?utf-8?B?T09GRy9jL2I0UllhUFk3TjVHbFhaUjhtRkY5NFY2UDFpdkpuNkoyMlZBbWU2?=
 =?utf-8?B?c0ZTdVBGMHhVc1p4K0pYdWZoT0FDcE51aHhhRzhXNUdQSUlSYVBFRkVNbDJm?=
 =?utf-8?B?REVualhvUFJ0RTRkOGl0SzNvMFZmaTZXVWpFRkU4RkNTZUdaekliei9HVzFk?=
 =?utf-8?B?MlpaSUE2NFF3TmNoa3drc3dtOVppL3BqNHA5cXlpb1d4c21yTDkyVWIydUNZ?=
 =?utf-8?B?RkJsWVRKbXZsZ1hHWEpFQlpwcTlrQnFJdUczdjhBNlJ3UGcrMXNPbzhXWHpJ?=
 =?utf-8?B?NXFlTGRqdjFNM1RPeSt3c0xyektkWVM5emVDRS9xSXlRL0lmTy9CRG5CVDM1?=
 =?utf-8?B?L1NRbmQ5TFFMOERYUnlFSm51a0ZXZUpFMVFVRzhNcURzTlg2c2IycXVKTldn?=
 =?utf-8?B?Sm4yRkJVSnowcWNGUVJxWjllV2t2OG92L1VVVEtHM2JZQ2VBU0FtajZ5QkND?=
 =?utf-8?B?V256VU5yREdYdUE2bWdqaFN6UVNrbnNRR1creDA5eUdWKzE4Tndmd2xRSzRu?=
 =?utf-8?B?OXh5Y29mb2Jhb0dEdG5ReHlkOHQrQkNjMkVTT2lDdzBaTXFVSHFWTCtqYzE4?=
 =?utf-8?B?STBRL2RPQVhWR1o3ZzV5dXVlWUJNZGdjeGNiMW5HbG5lYWxLQm5GUThablhN?=
 =?utf-8?B?RGR4b2g2WjQvc2lhTFV0aE53bUlLZERwd3hWMS9ReWl5SEhsVThjZlRIN3c1?=
 =?utf-8?B?MXBGQnA1elZFbWFXalpkVEtzd3hhdUduYnR5eTlKRTFCaEZxRC9DcjVKV0Vp?=
 =?utf-8?B?L2NQcXlJUE8zVDdZS1h1MFYvUmxxeURPMzJNYTRzaXJWT05NMHl0Njk1VUZr?=
 =?utf-8?B?VHdnVk5NOTUrQWllelVIZkVvS0hmSEhkNFZ4VHZDWHlFS2R3ak1EQ2d3b2h5?=
 =?utf-8?B?ZDlyMmJUZVVtSGFrUkhmTVBMRTM4dmxaS1FuSW1xN2kraitZWUNiam94SHE5?=
 =?utf-8?B?V2Q3dU5jcHJDb0E1OStaUmJFWFNXcEh4c216cEF5c05TRmdYTHM4R05DU3BS?=
 =?utf-8?B?TDViQkczakxKWmM1RnV6Q2J3QWdhMGhvTmU2OUVYOHZnWHhzblFnbXNwcVpC?=
 =?utf-8?B?amNINHZ3ODdZa0JmekozblVoenlHL1FLUU9kSDZpWGhBNTE2ZlF4Ujc3NE1l?=
 =?utf-8?B?Z05zZy9nZXJxUFAvUDFIbVp0a2tGMjh5eDdPdUlaeGhqR3JKRThFc2dZdThV?=
 =?utf-8?B?ZHFVU1I0ajRHMjhGSkZJdzQxTTloNHBpN252UVh3Q2RXaDFyNSs3M051eWE2?=
 =?utf-8?B?dFZjQzRPVFl5SmZQUTJIMzNSTnFRY1VjREd3dFMzNU9TN05XS1gxR1VCUUVq?=
 =?utf-8?B?NlRzOHNmbXlKQ1B6ZUMyNHh4K2RlelJFOXVDWTdkZjVBbXNlV09hZjNyNHVw?=
 =?utf-8?B?RFc0TytSM05TN3d3Qk1DU3RrWGRnRmJqUUR3ZHQ2aFc0V0FkTWF3UllWbmFv?=
 =?utf-8?B?bktmZUNQUjROdkFYaWg5cTdyWVNhTE42OVNpWmFEWWh5alFjd1dCSnAwc3E3?=
 =?utf-8?B?UVpsZHFyM1VFQmF2NkplamJ1MVdiR3htdWFiNmdPQ0pyMUtrRU9GTGNsc1JQ?=
 =?utf-8?B?WDlnOENObE5rQ09FNDY3YzNXSFozcGlEYXpaZWJXZHh3bTZwMTB0NFVGRzhY?=
 =?utf-8?B?dklvSysyc08ySzFkQTVNNUtqbjI5R01wd1lWY3JnQzVlVWhXYVdaejFSOGsy?=
 =?utf-8?B?Q2hVVXJDMTBwQUo2dUU5Sm9xNmh6a1ZHMUJlNFplOTdLYk5LSlRObDE3a1R0?=
 =?utf-8?Q?DFb4ndhyHbKLwaA8cAqXK0kwBKQKMIy9+zEn9e4Z0A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a94994c1-d916-4cf4-0c6a-08d9f327810a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 21:42:04.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7sDkpa56liuhu+NxMASNwStnYTX3jZJf2+OHKu4C8I90nS0ROiObPip0NHyku3j6g8yzACSb6ba2X3gCfs9xfxXUZyM7Z2b+ADDRv69Qng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5238
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2/15/2022 4:47 AM, Vinod Koul wrote:
> On 28-01-22, 11:39, Ben Walker wrote:
>> The value passed in to .prep_dma_memset is to be treated as a single
>> byte repeating pattern.
>>
>> Signed-off-by: Ben Walker <benjamin.walker@intel.com>
>> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
>> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>>   drivers/dma/at_hdmac.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
>> index 30ae36124b1db..6defca514a614 100644
>> --- a/drivers/dma/at_hdmac.c
>> +++ b/drivers/dma/at_hdmac.c
>> @@ -942,6 +942,7 @@ atc_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
>>   	struct at_desc		*desc;
>>   	void __iomem		*vaddr;
>>   	dma_addr_t		paddr;
>> +	unsigned char		fill_pattern;
>>   
>>   	dev_vdbg(chan2dev(chan), "%s: d%pad v0x%x l0x%zx f0x%lx\n", __func__,
>>   		&dest, value, len, flags);
>> @@ -963,7 +964,14 @@ atc_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
>>   			__func__);
>>   		return NULL;
>>   	}
>> -	*(u32*)vaddr = value;
>> +
>> +	/* Only the first byte of value is to be used according to dmaengine */
>> +	fill_pattern = (unsigned char)value;
> 
> why cast as unsigned?
No good reason - I didn't think negatives would be used. I've updated 
this to be signed in the v2.

> 
>> +
>> +	*(u32*)vaddr = (fill_pattern << 24) |
>> +		       (fill_pattern << 16) |
>> +		       (fill_pattern << 8) |
>> +		       fill_pattern;
>>   
>>   	desc = atc_create_memset_desc(chan, paddr, dest, len);
>>   	if (!desc) {
>> -- 
>> 2.33.1
> 
