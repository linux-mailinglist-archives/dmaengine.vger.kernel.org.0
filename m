Return-Path: <dmaengine+bounces-593-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968F081AD9D
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 04:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0DBD285D40
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 03:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50103524E;
	Thu, 21 Dec 2023 03:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kqhU2FhE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F033F5239;
	Thu, 21 Dec 2023 03:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703130346; x=1734666346;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Go4sTcQTpv+H654H+KX4Fji75I6J5alRBMti1bmmDnU=;
  b=kqhU2FhE4J6bs+WT5FY+ZXwO7juDmEGaO81h1zSscw8CjkFA0LgCeQt/
   Txx2VyKyOsb1Or+CbOMpnT6BZD0BARIMozPbYps34t1YsNGy9lrKVkVSG
   fO9XHB0W0jNfF8B7DfqjMvTYP+pvhNnw/CBLnR64cAewNBqyIQRapVU4X
   6RLi6EfVsgOJcVo22oMFvWXdYNalTalK3aJUbnh5aSbOjFs9oqNEGv9Or
   o52UwazKq53JA8uTDTHNkc+QvLkw1oLfhFnYpn2OjXDyMu/FpCHNzk4G7
   UoO0UbYeI1hBqp7mYM4PtSDnWNeFjpgdBFgRq5dzJf7rm5SmfPxi7CpMh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="376064854"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="376064854"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 19:45:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="842497980"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="842497980"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 19:45:39 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 19:45:39 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 19:45:39 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 19:44:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJXDmAmOZxEYaBDQJRoRE0/R9kWx63wnBz5QTgvHQ23pxkXpQw/TYt2gw0CtTak6lwaPoednjGMGr9SUPxmDiGxL2NeRJZ5LZw9dyhE2D65i8a3gUfEMM6C7TJuYtCY+FETmrScguzs57k4vXaBgrbe7UNpFUPpTQ0FyiKAWIRigGbGVOrRYYSjhi/KHM4Xj9KJoT4D8Yb7eOt52H6/2aSqDeK3NRF+Q8bmzNAtMBiLr/vjKkoDqyF3/mA0sQQ0ZziS0VU3DnfbkuxyH7vWxSI1j6770Oypx4ktUa8LmrulikqhZkKU+oaEez4pofJ9hd08Z0B2JNAs7241fAC4nKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsEGWuGXk0wA1UkbYFsWRf3n/wLTr3XcpuNYtY8m2vs=;
 b=lRxrjr7/CL9hhqPzV+IDRiuVuGCabGoWjy5859KUrd1GcO276itvtGIngGRPx4AgAEs9qsWltjRYKX9vHG9ITYtC6/7DKxyD/3ziU1ScXdq9XRJrt0xKRU3uZ/anU7FvNMg1i+EWlHpH5RKE+O8uR8VFXErGG29kdI6Ys1TJxoROkOniR81WRUMynZV1Vv6kQwxGO2eyMooKdT8fuZT6pCBlFB/FJ5r8Htu40xcal702D26zLlWZ8gIKhE5ry8WNwh0aCJwIERBEkauCLPgRNVBsWkY8ofDjrY1GFEOLiElIgfUAPHE6ESJAhlgAPZN5EJ9MpPr7MqSqiKOp0vijlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CY5PR11MB6416.namprd11.prod.outlook.com (2603:10b6:930:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 03:44:53 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::54ee:7125:d8a8:b915]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::54ee:7125:d8a8:b915%6]) with mapi id 15.20.7091.034; Thu, 21 Dec 2023
 03:44:53 +0000
Message-ID: <2dd7c5fd-7ecf-6741-1848-1585705d1589@intel.com>
Date: Wed, 20 Dec 2023 19:44:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2] dmaengine: idxd: Remove usage of the deprecated
 ida_simple_xx() API
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dave Jiang
	<dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
	<dmaengine@vger.kernel.org>
References: <ac991f5f42112fa782a881d391d447529cbc4a23.1702967302.git.christophe.jaillet@wanadoo.fr>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <ac991f5f42112fa782a881d391d447529cbc4a23.1702967302.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::32) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CY5PR11MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 96579a96-8ca5-4b1e-d2b9-08dc01d73127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: igl7z9JibYhTuPntGCuRIvEBRbSu4+WoEu/d5dpFuMKY34U8Sm1aasDnDo31HQUjQQL56TpiMZqa1z68EpqcxaGhz0FPOBmgx30aFh0ioVIaw56kUUe/F/JDqPWTD57PtMnhST/FVGc1sQ4LVIZO3MshpAEwCLnwJ/r75NvxYjbhJm0sXEUY6REe9ZvMM8ZLbSg5EPI3JqF8fVxFG1t8/KO0+jK5XOVAOiA2+M8etoV9POppHzMlxHUHxb9XNnhI4V6HantA5NBEpCPt8j5NEkzIErky20dSfH6mHC2BVGt8TWd+q3JzWJjG5IbYNVT/7flUiCgqTvbegT6LcAduoW6dzKOfp6Lmvr5p3MozrpuhuLImjD6nJBrOecvmidfALmhJzSABPEQUdvkKnQVXladvmYDPUvLdQPlx7YmL5c5e2bFKIWTascYOvESdtJLzzpKZ/ky+J1Om4v7/M1yNYmdGfby3qCR/+dUw5iKM4Yf6qjokpluWyTZSBL7l6Xi3UCYXRdW5URIrvCrMFgT31GBMAIrZv98HVEVGsmg3cyf/zBj/IMw9hEdZfyGvNSGHQa4iULq3cdUU+lbjdvHKpkOcO3TsfJIgU1xpm5E+NQgmpdjuH40Ppjm8/mMEfFmy9ApO70vtxRjkALYEMmuGgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(478600001)(110136005)(316002)(66476007)(66556008)(8676002)(8936002)(66946007)(83380400001)(53546011)(6512007)(6506007)(26005)(2616005)(41300700001)(2906002)(4744005)(4326008)(5660300002)(44832011)(86362001)(31696002)(31686004)(36756003)(82960400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3JFYktpcmx5WnE5cThubzVVZjV0VTczU1lIcW5NbUkxamE2YjRSSHpBOExs?=
 =?utf-8?B?U2lZNGJwVGQ5VXdZZG1HRmd4Q1FVZUI5OFo4SHdIYkZTc0dXenNLbFBxVlFT?=
 =?utf-8?B?Vkp2eUV2STh1eEFvUG1UWHExejRTdU94b3krcXhhS0JPM2c5R2tIdzdlZ205?=
 =?utf-8?B?YlhVMmVEaXhVaXlLSzhjdy9lZllSZGs0TUI1TkhIczhmcWJiQWxLaG9aaHVH?=
 =?utf-8?B?Y3N2TG9FMERrS0l1dU5DR2JaQWRaQjFDNTBlcWRTRWM2YmZTWCtuN0xxYlRa?=
 =?utf-8?B?Nll5VFhiQmdidHp2SEswYmpMNktZRkZCSWZHQlNML0Y0eEtoWTg0ME01bU8z?=
 =?utf-8?B?MzBwVlNLejVPUk10T1FWaURLTWVuRTEwSm5tRXZYak4yNHQzckdXRno4UUlW?=
 =?utf-8?B?eUV1MjczQzRhK1Z6a0pkWC9DME92ZWp2Z1hER2pwMys4TFhTcTVHTllWVXRV?=
 =?utf-8?B?MmlTQ1JXVHdGMUJrb3hjZUd0eTU0alB0OHc1QVVTS1B2NVorTDVLcENEVE03?=
 =?utf-8?B?R0h3cDZObGgzU01NYnZwSjRHVEhaZzA1ZmF3cExRb1RqdmIwanBLUUU5Q3p4?=
 =?utf-8?B?bXcyaXF6Mm0raHI0ckVWVHZmSStYeWZPV3lNK05DVlJCY3FIK3czQ1lMd2JR?=
 =?utf-8?B?WkF0RVFTYnRSdHpsanEzblpiTXFpNWU4empMZUs0dy9pcEwzbjZocFY0enF2?=
 =?utf-8?B?dmMwWE9DUjMzUlJwYm5vYldxMTBhSmFRWUo0bW9VTlBNcGxaZHZmZXFlRGRw?=
 =?utf-8?B?c3k5NXhJbzM0c2lDL2RGanB0enU5dDQ5Q2R2c3locW5ESDFNNmFFd04zVkNh?=
 =?utf-8?B?c2hBaFZtSEhyYjZhK0F3eFhVU3h4OTRvOTRST3d4aW5pMjlZTitVckdXVW1r?=
 =?utf-8?B?ODQvYXV5SWpxb1h6Mk11MHNXVWhvWHhyV0xtazhPVnVPeHFXU0dhd1oxSXNI?=
 =?utf-8?B?TFpyd25XYWhacGdpZDl5UUs2U3dWNTV6dkdvYVI5ek1Oa0pFakxscHZrei9o?=
 =?utf-8?B?Q3U0TXJiNWwybGdielMxUlNrYU9xWmZ1Y1BiQjkyd2FnSGJmVDRjRFRzR3Z6?=
 =?utf-8?B?QVhaemQrRkNwVWI0WXhGeHhNUVhyN2NrOHJhRnNsRHE5SGRTdDJHcG1rQU52?=
 =?utf-8?B?UlJtdTdoejFWNHZ4ZkNBNC96OHBnMTdSMzJqNzRFeER1VE1sSmFNV3YvN2Zh?=
 =?utf-8?B?eURLVUQ0UFYxTGdhb2UrZG04eVBHekhPbCtKcTJOeFJaVUR4SVJoeFFiYnda?=
 =?utf-8?B?emVWYWtuUEQyejExZTVyT1BuQnZRMXFMV1VEUStsZTZBM3plMEFVdXAyYXIx?=
 =?utf-8?B?azd3RU1hUHd5eW9GZlRncVFDbE1qTyt3TlBBcmMxUm1jSWs2MHVlOFMwVjEx?=
 =?utf-8?B?b2djaTNQL3dmQ1JqeTczSCtFanNZdmZCNmMwSUJ3amgyR2RCdzY3Vit6Qjdn?=
 =?utf-8?B?YzR4YUJOb0tUQ3NNOFRDSmR2V1YwcXBYOEVzdEhkYjlPYmJ1NURzL3pVYkYx?=
 =?utf-8?B?K3R5WEtOc2tsdWdtNm1UNHlZUlZFQ2ZuOGxZMEJpM3FNWXA0d2JLR3ZuaHZ3?=
 =?utf-8?B?T3VEbnVPcm1yd3k3MnVmZ0kzMXoyeGdVR0J3OGZUN0RsVGQvWjVERmFKQ3M4?=
 =?utf-8?B?TysxRm5mYm1jZVh2VEZlY25GV0U4OHR3OWtGZDNTbDJUY0xlRFdHeDJCRVF6?=
 =?utf-8?B?REFXVnJsVUh2cXh5dlVmK0VyY055bDJySFpiTjJMQVZwc3pmeU4vckg5NlZ4?=
 =?utf-8?B?TUxwWGQyVTlnMjRPV2pCN01mbFErZk9yTk1uQUQ5czBxMjdaeVhoa1NNVmhq?=
 =?utf-8?B?ZXdHZjdPWkJVTExNK1JPbm9ldUt6QnNvQlVhS2FjeFNHbkhBaWtPaWVsME0x?=
 =?utf-8?B?L1RtclBYWlB2QjhLQ0JmMnJTV1BTR3lZNzNBM1BObXVYM0ZjQTBNLy9YOXpH?=
 =?utf-8?B?dFRPZ2N6N2ZiSGxZUVc0bHg1WG9ubEgrOWFsSTB3aUhsZjN2RVgvWGpGUUow?=
 =?utf-8?B?ZXJEL0NFNm1vZWREeU9Id0FidXI5d093WW51R1BSVG5kRnltVGJRemd1MnhM?=
 =?utf-8?B?UndmUWNhclZkcHk5cDZVcGNJUnpBd1ova2lQZSs0Nml6aDcxSDMrRVNPQi8v?=
 =?utf-8?Q?mDM+bgGqkronoGC1JJ7yaKuCj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96579a96-8ca5-4b1e-d2b9-08dc01d73127
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 03:44:53.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9IX9R+aLH1r2+8ILOyLwzdn4uIDzkvLiqBAxaj1BOHZf2bp4R67UBW6wqHzDrAhsp7gBvToJwx17wrmiXr2Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6416
X-OriginatorOrg: intel.com



On 12/19/23 11:33, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_range() is inclusive. Sothis change allows one more device.
> 
> MINORMASK is ((1U << MINORBITS) - 1), so allowing MINORMASK as a maximum value
> makes sense. It is also consistent with other "ida_.*MINORMASK" and
> "ida_*MINOR()" usages.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua

