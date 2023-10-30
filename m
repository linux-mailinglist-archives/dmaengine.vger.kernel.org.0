Return-Path: <dmaengine+bounces-14-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7A57DC04B
	for <lists+dmaengine@lfdr.de>; Mon, 30 Oct 2023 20:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179221C20AA1
	for <lists+dmaengine@lfdr.de>; Mon, 30 Oct 2023 19:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DF71A588;
	Mon, 30 Oct 2023 19:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SUYrnAXQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689FF1A594
	for <dmaengine@vger.kernel.org>; Mon, 30 Oct 2023 19:20:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E894D9;
	Mon, 30 Oct 2023 12:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698693634; x=1730229634;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ggOauiGPL6Fby/j0ofPZZeYvmKYdutaoArf0mnKmDdo=;
  b=SUYrnAXQH6jOPiM5mgr3sAIJrGfrxjqTiP4QWbpZNWhdY7p28s69rleR
   Y6E7TfegacRpS0PxYlHY5U/Gq876nftdPvxeaCHZZwggfFqoOS8Rj35PJ
   2/2I9IA+BrTDIY7yxR4TLbuRJKyFcyyMS+xAPZUPS0LF0Wh3J5Yiw0JRP
   sE/ZIccMH4BTgU1w6eE2iLzaIfNqWbdrPNnE2Ume2l7ZwpP22l2xfW6Cm
   WrN1beGzrgGKsxyJDrRtWSUoNSDSoybkunMkaSBU1XQ85Z0vp2nkh1wHo
   cbMm3ipTtKWUKh9ppPnKzlm7iiZTj7SMvAvHJT1M9oBNFdGtUglhMA1pa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="368353971"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="368353971"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 12:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="795348287"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="795348287"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 12:20:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 12:20:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 12:20:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 12:20:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 12:20:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lemJPi/DpD7ptIweCOR4ZcJPGuB307+E1iTuZmyWglt6vPlaM+QlS5VbhIe08Ee2Rn8xbEOjvmzoGCW2FUYAXsgmDK+Bk/AVopeeBBLV3ZPiZ+CPOlQd2RqhGlqojAlvQa2lQ6mkuPmCnf8yCH6yqpZfsJzRgL2fPars2Ayvjj/IvojRsMdNnTb0fWbYzqOBvAS00eHuDNOMZAhdLm8AXeuE6dpwAc/Ve1JZ1npU2NekiRKh86CB/pE98bw1L1OJkfuRA8JzhgoV/w00+LHUA8M+YHEJBvixMljhXnfc0unXY/tjaB5BFdS8MMqMw53njLA5GzqyKwLVAeMkH1qM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhzY+sHcsKE2DlR1DCDhlYxNQLwsxuFU/mawHFRw4z4=;
 b=lBjwiJqumzM7fKCD+lwSxMvtcYee+VFY/uATVZmhM6f2YTJ8oDmMEQP8tavo/yLvjznNZs3UOripzV1/IphROkMtMSdPa4bLgujUc6xJlcJLGihGolTo5ovIq2lbW4u8WggFEypoa5+VAmHfIlBNqpsR1hgdtbuo6YcZe9D3W+TaKwGSOrQYat1kvvDbrHBrREW2TUGvU6iTdcEGR19jzlcPx+wkWUeXdChuF534rSQDosBb5nd8eG/jg7P2PCMhV4FE2U0IxspItAzTQhTRDrAdeNG6z8yCQKNaoroWHEkX7QNJ8NJWhs99Jq+1gmTqTMwDI7mOL3A1Q3dL4V4nPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH7PR11MB7963.namprd11.prod.outlook.com (2603:10b6:510:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 30 Oct
 2023 19:20:27 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::92ef:1d38:2ad6:5e29]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::92ef:1d38:2ad6:5e29%6]) with mapi id 15.20.6933.027; Mon, 30 Oct 2023
 19:20:27 +0000
Message-ID: <658133e5-922a-b05c-3cbd-cd967f406427@intel.com>
Date: Mon, 30 Oct 2023 12:20:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/2] dmaengine: idxd: Fix the incorrect descriptions
Content-Language: en-US
To: 'Guanjun' <guanjun@linux.alibaba.com>, <dave.jiang@intel.com>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vkoul@kernel.org>, <tony.luck@intel.com>
CC: <jing.lin@intel.com>, <ashok.raj@intel.com>, <sanjay.k.kumar@intel.com>,
	<megha.dey@intel.com>, <jacob.jun.pan@intel.com>, <yi.l.liu@intel.com>,
	<tglx@linutronix.de>
References: <20231029080049.1482701-1-guanjun@linux.alibaba.com>
 <20231029080049.1482701-3-guanjun@linux.alibaba.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20231029080049.1482701-3-guanjun@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0064.namprd02.prod.outlook.com
 (2603:10b6:a03:54::41) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|PH7PR11MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 5393c70f-1ca9-4f09-4d9f-08dbd97d45d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVHpEBqm0Y8Jii66ay802LY+2RL0K8wT+wje4SvdmBbVduY4716QYUQysqSspFc0TuLUDkTlrxOZSQw3f5dnoFUrenZ18bZN7xlxNwil8D1H7mgZjst02T6u274rcZJSHph3Q3VAgoYUPz6qBZPi1PTypXn6qyg4QcGB6JZWeNA8PMLyi4Zf1q7ualX7paYQjbO5275RLXzzgcISQ6uBgFjD48s43Hf09vTVkBbtW0zUhapwsijGk9VmDNQKVq3Nj45CRu0Y+Hp7eeADOEurnxU7I4Ex4rTRRa7M1xfbwS/gyODCh88Sfumax/Q2RmGq/vRE2PQBeU5IMinWxJouc1RhA0Kqel38Bag6lEszZJ0cyLJbtw7XBAXOtXGNPlLSIxCMilpQgrKGuRUvX65lVqUrc6w05jYL3OGrQOF3JaoNxjJ+kzSAOxyCYkA0x3KUsv5Ybiqdo3FbP2BGrAsJ3r1d03wehuhqFJl8erWYvBJsixOKeaDS9LF8ttOU7cR+yzRFNdyPak/ZC4rbmm4Q49Aoveet6N/auA6GKgI8LmUcXYkHvosYZ8E1KSrx9hJWaODWjdtLGE2LSw5jLw8McnbOGhfU7GJ0sCicMy51vMaSgtb+TCBL4Msa2wjNN2oXzrO8GqxSZDKE5hoP9e6XIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(44832011)(38100700002)(478600001)(66946007)(66556008)(66476007)(6636002)(6506007)(316002)(53546011)(6486002)(4326008)(82960400001)(6512007)(41300700001)(83380400001)(36756003)(5660300002)(31696002)(6666004)(2616005)(86362001)(8936002)(8676002)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWlJRUxIZlpqekgvek4wWjBiTmpFc0hEN2NGbnNiZmhub2R4bzNhV2VZM3Na?=
 =?utf-8?B?a2dLOG1saFEvVVhGeHFjaWdyRDcrOEZLRjVXYzBSaWsvTWdCOXRqQUc5Rjg0?=
 =?utf-8?B?WnducC9mcWFZb1VxRERGeVpMd1VnM2hwMjFiakk3SWV3K0hmSXFDbWpwMXB2?=
 =?utf-8?B?ZlNxUEZ4RHpHWjJlQmFEV29IUEZuWTI4a0l6NUN2Rk12RmgxOFVjcTVMZVRk?=
 =?utf-8?B?MUFWZmtIVm1TeTJLT3FFY2xlUlphSkhLeHRmQUZzdmJGZ0xRZkRMM0tKS0h6?=
 =?utf-8?B?bnJ3SGFWQ1AxeU9uNDkySmJNWWNsRVFHNXg3NVpqclFwSi8zWUNGaFBPVEJU?=
 =?utf-8?B?b2xqR2hDcWgzVjJXSWdReTZyNWxHdlBXNlJ0aHd5QXFMYlRUa2crUCs1N0t2?=
 =?utf-8?B?ZEw3c0VBRWhjVlhLYlg1VlI5ZTFLcng4dGE3WnJWT3UwMnZKTkN4U0duVU5P?=
 =?utf-8?B?U2RsMHJhK2JMNGs3Rkp2UkJNVUZidExYOTVJQ2lxd0g5MjlrdkY0ZWhjQTVw?=
 =?utf-8?B?Vm5uN3dPdTVFbkJvSFVtOXQ2dDdLVC9OSWYxSEtWUnpnTm1RT2VKd2xxenFC?=
 =?utf-8?B?UWFHY21tZjJEVkVsZGd2L3M1TUpkSjVWSTk0NjFkL2w1RnJIcGc1bjE0a2RC?=
 =?utf-8?B?N2tRVGMraHZOK2M0MTNxQXJHM1hJb3N1Nk1COWRVNWJ2NVdMeXlNMzZWYVVP?=
 =?utf-8?B?OThMZy8rNDNUTDZRLzNucG1YWnVydlVlL21CZUZPempjbDRXSmQxeDl6K3kz?=
 =?utf-8?B?bFIzNFpHM0c1YVJxZVVSUm5sRHVzZXg3ZGEzT2h5WXBZQjhhTlVoVnFkUTNt?=
 =?utf-8?B?N2lpbFpBWXlvQWpFdnJ5K1ZKRHFkSis5QjJjWCtqNCtKczVocjFjNG1DVEVz?=
 =?utf-8?B?MHRkc3dLYUJ1L0oxZ1BxR05ObUdNdXYyMlBGOURKNE9ZWWE1aGEyT2RPUzM2?=
 =?utf-8?B?RUtDZllZRTVYaHgxTktRSlFRZG91ajIxUXVSamUxRlY1elp4cFFDaUo0d3dN?=
 =?utf-8?B?QTNISGlrYTJOYjZwcUdNSS9aOEN2UnJDeElXeGdhUnB1bEk1SXdzejFiMW80?=
 =?utf-8?B?S1lDQ01yQzkyZkJUdWQydlc5ZmwrTFZWc0ViMGdFbGNpNGtMcGRtUUJKZ0Nl?=
 =?utf-8?B?cHo2QWV2STgrVERUY1dBTW42VnptOHJ2M0s2OTI2WlFFakVQbUxPWlNrTk1k?=
 =?utf-8?B?QzEzRDZtZDMwTlRGTUdPNVhDRXpsMEFZVFJxQnV4MWtuM3BadGVnOVR3dHor?=
 =?utf-8?B?U2VrNUNmMDNpdlJZdmdVL0FzS05jT0dMY1laUWtXaThpeEVoK1hTWWNMU3Bi?=
 =?utf-8?B?dEl0T01nTGMxNGtPazk0SDVvRHpMT1hDdUFMdkUvWHFrSmN3MFBnVkk4aks3?=
 =?utf-8?B?dDRGNklWZVg1ektNaTA0b3ppOWExRnQydHh2cm4razR5NzY3RDFKdnc1Q1Y5?=
 =?utf-8?B?eW55L3BvZ3NGa2FtVlNLbk43MEpaUkFMLzBjRk5iTWhQV0RlOUZkRnNQb0dW?=
 =?utf-8?B?c3hCN2Voa0tsVzV6TGxhSjRLNjN6Mk1yQ0p3ZFBoME1JZWJiQWV0WEwvV3hy?=
 =?utf-8?B?Rk8xU1I2WWVPM055cFNFN1NFZzhGeUFORU9DOEZhV0o3UFJpM1Y2L3o4eVox?=
 =?utf-8?B?akplbnJldnMzMHN1d0Y2c09uM0laSXVKU3kzTExrT1VkK3RsemE1WjZISGJM?=
 =?utf-8?B?RTZ5WUtqUmNVZWRHOG9WZUNQOSt2M1o4Q1dTZHBIRjlpMGJzUzA4R1JvNlpo?=
 =?utf-8?B?Sk03OWJaQ1d3eHpJWE5EL3p4RzhLQ1VKNGIwRW0wZXM2ZEczeVBIVGZDTEhF?=
 =?utf-8?B?WkxPeVNHZCtzSzRaMjhnejFzOWFSc1VRMXM2UDFHWkczU2E4UU1hWWtFTnpy?=
 =?utf-8?B?cVdZUGc4eTlhY2NDeStBR0svb01yQSt4aWpGNTI3ankvbmxNaVFkMHU3OWtC?=
 =?utf-8?B?Zkwxekx3MDJYalpMQzI3UGN2ODh2Ymd3aklFRDl6MzlheS80SG5Sam0yYWZV?=
 =?utf-8?B?bXIrdHk2VVRVZ3RiV0hwZmorc24waTk5LzhmOHFOeXVCN0NZTVNvRGQvcnpO?=
 =?utf-8?B?T1d4Tk56WEFjZnlmRTNBVXV2enFFbUt0ZGQ1WHNnOUFaOXNRZnh6enRrSEVa?=
 =?utf-8?Q?zFZD5q+rA8TOn9CXaqYy9oXMT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5393c70f-1ca9-4f09-4d9f-08dbd97d45d9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 19:20:27.0741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+9n4bau99EcDhiw/YdbnQrXAgstOkZKOqlUEr15KT/bwqsKZALNgyklJzrBXACak0fcoFK4bjRQW5fkcmyiCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7963
X-OriginatorOrg: intel.com

Hi, Guanjun,

On 10/29/23 01:00, 'Guanjun' wrote:
> From: Guanjun <guanjun@linux.alibaba.com>
> 

The subject may be changed to:
dmaengine: idxd: Fix incorrect descriptions for GRPWQCFG_OFFSET

> Fix the incorrect descriptions for the GRPCFG register.
> No functional changes
> 
> Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
> ---
>   drivers/dma/idxd/registers.h | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
> index 7b54a3939ea1..385a162a55f2 100644
> --- a/drivers/dma/idxd/registers.h
> +++ b/drivers/dma/idxd/registers.h
> @@ -440,12 +440,15 @@ union wqcfg {
>   /*
>    * This macro calculates the offset into the GRPCFG register
>    * idxd - struct idxd *
> - * n - wq id
> - * ofs - the index of the 32b dword for the config register
> + * n - group id
> + * ofs - the index of the 64b qword for the config register
>    *
> - * The WQCFG register block is divided into groups per each wq. The n index
> - * allows us to move to the register group that's for that particular wq.
> - * Each register is 32bits. The ofs gives us the number of register to access.
> + * The GRPCFG register block is divided into three different types, that

s/different types/sub-registers/

> + * includes GRPWQCFG, GRPENGCFG and GRPFLGCFG. The n index in each group

s/that includes/which are/

> + * allows us to move to the register group that's for that particular wq,
> + * engine or group flag.

s/that particular wq, engine or group flag./that contains the three 
sub-registers/

> + * Each register is 64bits. And the ofs in GRPWQCFG gives us the number
> + * of register to access.

s/the number of register to access/the offset within the GRPCFG register 
to access/

>    */
>   #define GRPWQCFG_OFFSET(idxd_dev, n, ofs) ((idxd_dev)->grpcfg_offset +\
>   					   (n) * GRPCFG_SIZE + sizeof(u64) * (ofs))

Thanks.

-Fenghua

