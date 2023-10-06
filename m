Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386DD7BAF81
	for <lists+dmaengine@lfdr.de>; Fri,  6 Oct 2023 02:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjJFAPX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Oct 2023 20:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJFAPV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Oct 2023 20:15:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421959F;
        Thu,  5 Oct 2023 17:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696551317; x=1728087317;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n9qxhV57c2XMLtSgRl1e0epkm3NxpQ4vkIUhsQFe+kw=;
  b=bHT+v/hamr3ZjhdnksKTAqHxo+a80EhDe957/PfrcLv8ddn2oW9z26Rp
   h57tEWIv2iZdX1m2y0Nj0770CRc31k0C4heJMg4dYxcpNu1SNw14pg+B+
   boXUZJrXlRbRr199H155zGJzjj3brO43BTKyXnuXyaXxTt9n6EqrypOWN
   wBd8SboQ3OeKgLV5pxnNxE3/17R+rolWknEJ7grpqyVkZl+EViCnVzIRg
   2y3Btclv2cabW2ow1cf7sFzVfzeb5lXH040ogsouJLDsRvbFN7bT8K+oy
   OrI2XumDOYcSRvlvECEm5Sat7wF2QeKmMYZt6p3+7LI5QuzClIJh/KaMr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="469921362"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="469921362"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 17:15:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="868131790"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="868131790"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 17:15:16 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 17:15:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 17:15:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 17:15:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+oPpSM/td6HxjY6gOtudMJVY599KNmXuKP87qfTJB40z75dp6WMMoWJ3BNhHiCTTUpi+egwwXF6FwdvWfpeFoDzYVaW1zfY4QOjyQWGeLOCyjJpNXsT/NrcooA3jhkKV43L68rHTxzYtIboVyNIgml0qk0VyFyc1Ni880unQYCR0HXKNbnrd2t58ZiH935oj5C8vZA4l36CQVljkP9DjcnKAP1VgwDorlmmDsClMUjmkqOfI22fwsoLyH46TCBjw/jEephh1bwOGp/pSIXi0968Rnd3qcZ2P1nCSvc4hZkt0EOsHYXWOg07SpDg+gZU8juzXzTVrZgCBm8Sx3DCAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obn+uS4d8DAgI6D/s/bbRwMHhwAfe9zTISM7kaEsRQ4=;
 b=N/rePbduTzSsswDKXZhRplAOqGGL5rY55MNTad0az5alThAUTBAIGHG8wtsqZ3SpsbJEf+7xZ4hThFfwg0zEA4qRa1PYoTqRvQvzoBF5XxYSj1fcrcp3WFsz4ZCOIumfjQtk/YJtaxESQKbTcPR3fiyvw4AH9IumCuW0WoWEOeACk4k4hwqjOHqcuT2yS4e9qriUVsvQG/y+cCHf8RrH0LI6nJeU+JvZBB/8h3tqUBiRZxKJ3zcFcbzkr6KyyusZuOtmOxkhSN/zFsnZpXQ4TXiMdwKzAl+RZdUYgBL9xKm8iOrJC5S46I8b87U2uvZ1D5TC2zzCOdg7Ox5cUmVFgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Fri, 6 Oct
 2023 00:15:14 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::5fbf:2030:88a6:14fa]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::5fbf:2030:88a6:14fa%4]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 00:15:13 +0000
Message-ID: <0d72e2db-40cd-ec16-a28c-83793f20c435@intel.com>
Date:   Thu, 5 Oct 2023 17:15:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: idxd: add wq driver name support for
 accel-config user tool
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>
CC:     <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
References: <20230908201045.4115614-1-fenghua.yu@intel.com>
 <169642974297.440009.10230225002907030565.b4-ty@kernel.org>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <169642974297.440009.10230225002907030565.b4-ty@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::9) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB5423:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d08a4a5-4f5f-4f72-417d-08dbc6014fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kq9ZkERlMjk14DDjh0hW4814BpDlKIALnm6enVsalK6VC3ChsGNuIHvNul0kMvGA5q02llkDtC98NCVzaJ+GbBumhrMkllxkXV9xYY8aWJhn9hQ5ZRQPKECcszQQsDmubhM8B4ZsoU2IR6kNICgOIvqYpw3hVgyrLTgO+p3/dJboyQlDyUhHJFrjdK9bwQ/3v1zrR+KLzsEb4gXx6Zsxc9tQeQS9tjEEfovoXq9F/4IO/6kKS/15wJY6YbgzU7JQzBV7yTqKfJ6ur+mIISTeK4V4TXTWLi6euk5LQJu4vB+D+gavwNAM0vY7ExqVQj67S07ohAgk+2dqiJ+Wkd9MfpZ9aECzKK9zh4oAFWtnzVx5L4ZTisYkfEE1NXcmtrTMEKySleOT+wneUR/+kDbYlbAWDf+ycEuAg/MKnUkhaRwxyqPR7t89xs9atN7jHKm1uAKLADmuuTFSlM7HYR2Pnbj5tQquUyEb+1GEtFvO8YgSE80QjYfZdMu8g4E+uRJ3h4ENMBCVCRSRsoUyoyQnh9HfrzxtsIMt+xnN4ckXrOpHRNpY+ujED6yYBYwuT8WBjMGjJuoMsOwe4xIYkJJ70qcUAROoZrCPO4KRZeFEKIdrxUgVXXXEvT5mNLQoNZAotXHmoZE61rk+ISAyPr8e0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6512007)(53546011)(110136005)(82960400001)(66556008)(26005)(86362001)(4326008)(66946007)(54906003)(66476007)(36756003)(41300700001)(4744005)(38100700002)(8676002)(8936002)(5660300002)(31696002)(316002)(6636002)(2906002)(2616005)(44832011)(31686004)(6486002)(6506007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2g3d0N3OFluN3F0ZzVxWnBETmJ2dFJySkY0V2Zhck9tRG5FOGl3QitlNDFa?=
 =?utf-8?B?MXgydFFyZnRQWHpmbFZidjdiYVJZNEI2cFhnUWtzQTV0b0tQMFNQK08vRVJn?=
 =?utf-8?B?d1RKa1NLTmNEdnFQdzFPU2JLeVBxUjV3MzIvdkpTeFYwdnB0c294REJ4VnZD?=
 =?utf-8?B?OENSUWRya1dGa0FSazI3eWZ6WnZYTC80TnlPMlNJN1F4cWpEdlIrNTVqUWFE?=
 =?utf-8?B?dmVtM2RaQXExYmtNQzFvQ0lGUzlTaHlvNlZ1dzRWdUh5QnVWbkJpakdqQTJJ?=
 =?utf-8?B?OUlodjVHeHlCeVRJZ2FHd3dOeDljZC9PTmhwWDBEc09DaXFCR0lOWEllcDRi?=
 =?utf-8?B?bGhrK2M5WGcxQlpOeVZmdmtyU3hkOEhDeHBDc2p4Uml3TWo2cFNRSnl0WWZF?=
 =?utf-8?B?Vm8vZ2NrQ1pjR2tNeXRGUEtITjk2VlhKUGJSQ3p5aEtkM1ZSOWRVaGtrVVV4?=
 =?utf-8?B?Y0NjdFhIalBBZTYvVFJ5NUhXMm14MFZoVlkrVVZxdFIza3VxS2JuN3Y1UUhC?=
 =?utf-8?B?MlZ0cnE4ZlpXdm9JOWFVMllTR0U2dlk4cFZlU21PcHc3elhvOGJiZGQrOCs5?=
 =?utf-8?B?V2dkMng3Z2dQVkV5ZFlXTzNYc2s0cHo0djhmQXdFZ2EwbElLLy9XZjJURmJk?=
 =?utf-8?B?dWJEQ0lSNk9wMm0rb3NsSVJWd2xWTmI0VWxNUEluT3JLNUtZK1NoZUhMQ1hh?=
 =?utf-8?B?RlpSck5Wc0h5RkhTWUMrazRnTFQvaVc2VVZpYlorRU4rVFZPVFZWbzVxaExJ?=
 =?utf-8?B?SWFJWlc1QzZlR3N0K1NPclROLzYvOWoxc2lDZkhKeG5mTWdxc05iSS9yeEU3?=
 =?utf-8?B?TVVhdy8xbGk5Vnk3V3A1UUk0NTVkQmxiOXBWK28xUVJhRTZBWHhPV2cxRi96?=
 =?utf-8?B?TWt3dkY1Sm13b0RueFo0ZVNvLzhrQm1iWXhKT1Rkb3dxU3lwYVV1OXNZRCsw?=
 =?utf-8?B?NG5VK0lIRnlja2Rva3lCUkJWVm1TZG9XaHR0elZETCtuUGR0VzFNNE03RzJC?=
 =?utf-8?B?amZ2Y0JOSGF5cGZKYlR4a3krZ1pLaS9DckZSSGJXbUVta2hqL1pabXdkZ1BH?=
 =?utf-8?B?My9SQm1jUUt6NTVtOHB6UmF5ak95MzZjR2tlL0t6OGtKRzBXeFgrQVFMekdY?=
 =?utf-8?B?dFhHNU5LNm5lNXpIMXRFZENia1loaHkyRWpNcXUzU0JwVHBIc2w2RDM4YTVI?=
 =?utf-8?B?QlFsR2FFU2N3OTg5MktnRGdjYXBmSFBEcWwyT1RmS003WDBPOXhSYUFnUnJq?=
 =?utf-8?B?YTBmeVpHNGJBR3cyOXFDNHo3WlVnV0Y4NnJZVE5IL0tMWWhSQXFWZFJMTUdu?=
 =?utf-8?B?QUIvNldJdWlRTE50a2FZQWRNeTZHT05iNDZIcjQwTDhMQ2QrcXJZaG1PeWlt?=
 =?utf-8?B?WDVQMmxnWXJ5Unowb0g2WUdaRFpSUXRWNThzZnUwNUNLcHFMZ2wvSERvUmM3?=
 =?utf-8?B?U0RZSVF4YWxpeTR3ckhEay9aRGNBZm9KdGZqTmljbTMvNGpiQktPWVJhYmxJ?=
 =?utf-8?B?aGNLUEtodkkvVzNNRHpVM2VUTWRVM2QzQ1F4S05hRnpIZFYwOTYxdCtJc2pT?=
 =?utf-8?B?Y3k5QUN0bkwxRGNJSmM2Vmh3KzYwTW42eXdldDB3RUxDM3ozbHZHSGl0Wkxx?=
 =?utf-8?B?KzdURUh1R0o5WVh5b2pTWGRxUEVCS2pBTnVONk9sazJ0NWh3dTlHcjNLS1l0?=
 =?utf-8?B?S2x6eXJHZGlHZFUvaDlOWUVBR1VSK3pOVHZRTEszU1JKdWxBTlVuYy9xcmYx?=
 =?utf-8?B?b0RKMkN0cFVCUW9xMFNzMzhiNEYycTBTcTRjTCtqOXlSdmhEZkhmcGM5WDJK?=
 =?utf-8?B?a0NtSXBBbTMveWZPVFArampabFI1NHg3cjJBZHdxcVlqaGVkOThlaUNJNzIw?=
 =?utf-8?B?VFhrMlFuU0VreUdYK2l5Z3Z6S3hjMWxaOTNaY0tYd2hmRllGQ3dzWmlmWXFw?=
 =?utf-8?B?cUxGK2Z2bElwdXRJNlFCQi9ETXJVZ01Yb0RKaThXUFNwUHo1U3c2NnN2WXdY?=
 =?utf-8?B?SkcrMlpIRXhUT0JXRU4venRlSys2LytXNHVyaTRNVnhJRTRLWmZET28xRlN6?=
 =?utf-8?B?VTg3ZHpjdGZoOE1wV0tnM3Z4aDBHdEl0SFpnblhQd0QydmExclFpcGFrUHVz?=
 =?utf-8?Q?GoBMaTfxa5MTymkezcFdHEgSp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d08a4a5-4f5f-4f72-417d-08dbc6014fa4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 00:15:13.8624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkvQBRn9+7w/HVdvMRkHbLAw993gGLH/Tm9XWAxIAtVVJvH/0d+eaxXa4DXOKyvoLZiLW3Pz8wSMfd1ckQqLnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5423
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Vinod,

On 10/4/23 07:29, Vinod Koul wrote:
> 
> On Fri, 08 Sep 2023 13:10:45 -0700, Fenghua Yu wrote:
>> With the possibility of multiple wq drivers that can be bound to the wq,
>> the user config tool accel-config needs a way to know which wq driver to
>> bind to the wq. Introduce per wq driver_name sysfs attribute where the user
>> can indicate the driver to be bound to the wq. This allows accel-config to
>> just bind to the driver using wq->driver_name.
>>
>>
>> [...]
> 
> Applied, thanks!

All pending patches are in dmaengine tree now.

Thank you very much!

-Fenghua
