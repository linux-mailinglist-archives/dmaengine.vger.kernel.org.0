Return-Path: <dmaengine+bounces-12-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDB57DC01C
	for <lists+dmaengine@lfdr.de>; Mon, 30 Oct 2023 19:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23953281096
	for <lists+dmaengine@lfdr.de>; Mon, 30 Oct 2023 18:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF0C199BF;
	Mon, 30 Oct 2023 18:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5f+rjgz"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4022D199B2
	for <dmaengine@vger.kernel.org>; Mon, 30 Oct 2023 18:56:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CEEDA;
	Mon, 30 Oct 2023 11:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698692180; x=1730228180;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J6swoZvJ9I3ctPpQIsZ0KOOGYHAr6qYae3j2AP7OzVw=;
  b=F5f+rjgzXI0ioOhGG9426xE5CfzyP0CwlzqYyw1KtmnOQNI9hqG/c3B3
   4oXbi1KTFdglMW5Ys7pp63F09LEpJI4kgCtZUKEkJ5HOYJ65/C3TM9I1T
   tjiOO+9t/cKsrwswPalifkW0teP7SzpcJ4ZFx4B6VEb31/NbgyvgIXP4j
   GbgfxyvUyhDfGSmWPrIKrIFph3m1gWYGEat9YHMtOUurlYKxgZ8Keq0+F
   WfmZfoguqnvg63qrDupCH2z+XYe9xDncE+K3d1MeL8ZET9lA4NJrW1hG2
   dGTnt5OOaX/d/BUW53AEi/9c+yfBSe4bVs9LbfbmnjwJRvCvFOplvwzkl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="378514646"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="378514646"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 11:56:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="1007512102"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="1007512102"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 11:56:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 11:56:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 11:56:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 11:56:16 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 11:56:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alHJx+BOyn5DuJUJzy2PaB13/SjGv6cx0tY3G5v6HAl/CBEtEEEZnZXTe/5vAHH2lqOZOSPKMC9hy+cIS60s54A9Htrx+qRwMIq2w8dXQDB6NqcjwowsyADtmnInTRr5sEvU2Uv+p0LA/lPjL1dznERc6jLoh6zRexolLFIKR8ydWFzQLylm76DPlRS/JDbEUxYN5WXQNkXuP2+bK9fE26gCIQJYZbCa7ZugCiLxmfQmHNPIO76y57hy7hktzkrapJP4nBy/8n/37pPep2EwIZGVtmerTy5YBrdrAHc+6eelhC8Rb/bAfZDQ5bsc1r0ODSfjATGxRRdAADoGgDKBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/TwT/xSz9T8KbTZUOdVR+YhquSWeQJgUGATtuEkMe4=;
 b=jMGGaaJd7CYz5GZVWC6rwOsCjd3XMgSpwUJhcCe9a60AaktBLnacQj2omO4izs9yhOy/1bNE1HTl2hkG0YZ1oABXkTRpjhl3CpIX963iC98neaFIU2KBfbp0jOtlWrcWKnVuhd1aW6kEmujvJSTCAl4vKKAyYMWtZjKPTmo6JzqYGQbrWhDGyopm8EErcJzb+LskKlCflBVeHfo3oslQ7fbxofJp3uA+tlwNyL44ZtWIUUUJbFU20qQBdp69GGDzHaoKzpXZArdLyiGG4Iyc54lIrgDUsIchF/QJonQfBFi7OFsN0dUhVwlaPBBRF5MN3PrrbzjGVMYKG6zBVqEL9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by IA0PR11MB8377.namprd11.prod.outlook.com (2603:10b6:208:487::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 18:56:12 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::92ef:1d38:2ad6:5e29]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::92ef:1d38:2ad6:5e29%6]) with mapi id 15.20.6933.027; Mon, 30 Oct 2023
 18:56:12 +0000
Message-ID: <02c203a2-7f71-efb9-5fbe-bc753de21ff5@intel.com>
Date: Mon, 30 Oct 2023 11:56:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/2] dmaengine: idxd: Protect int_handle field in hw
 descriptor
Content-Language: en-US
To: 'Guanjun' <guanjun@linux.alibaba.com>, <dave.jiang@intel.com>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vkoul@kernel.org>, <tony.luck@intel.com>
CC: <jing.lin@intel.com>, <ashok.raj@intel.com>, <sanjay.k.kumar@intel.com>,
	<megha.dey@intel.com>, <jacob.jun.pan@intel.com>, <yi.l.liu@intel.com>,
	<tglx@linutronix.de>
References: <20231029080049.1482701-1-guanjun@linux.alibaba.com>
 <20231029080049.1482701-2-guanjun@linux.alibaba.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20231029080049.1482701-2-guanjun@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|IA0PR11MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: 349b8b87-7bcb-41f2-5d40-08dbd979e29c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUPfIejmtVKC32WJry67xOVepUakXwvwVn6ASU2IBoswn+LwclEtimhw0VVWPD2zMUDSb9CwS52Aki8C6stKoahyK3J63znFOE+yaFfLfPtm6mgREsJJ/iGQUu7tkAoHf2j0aDhalqIFgEf8XiOE1cx5L6GnE/EhG/A7bkcLEzZsfphpwPfTfxcNx66ot6JusFBZiAI/liPW6WAL11moTBQsSFZUfCcaSl82Pz0akMV16jgyMj8Ia15MPfhIC5GtXM9bFXBWgsfMvN9dXny+O1GgPtK7v/dnOVPnvv3XQ++fOWAAm3e7GQeYsSyEEDm80SgWWRVlyuotMoHvfRGGT3WB8i+YMCQXtKcprVNYAiKzE6C0wNH8PuzWhnHabc3xtJ4iQFePcgFWwPZDPWBayGzRI5QAHoZ3BIJCprCkS1fnn+nl7m8LKbea6+o2DvxTZDGuYGIJRuEoSERHbzZxdiqioG3O52rkjc93o9Z5TZoSPKbWCFekY9yVyyAAlwBAdCCicjw/vtPxouLjUteQGWUCU1L3XrQJ+nQtCPf1Y8K2Y+cpgOXVcr3Q1R8NaOYw7o5DxjsVmqLcpX8Kw6SAfVhMHM1XaU1gYsu1QHWyJzu+2lGJbvNHXXQFPzntKPpmwiJdZrEdzIug7DrmuKXtEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(31686004)(6512007)(26005)(2616005)(38100700002)(31696002)(36756003)(86362001)(82960400001)(44832011)(2906002)(4744005)(6486002)(5660300002)(478600001)(6506007)(53546011)(6666004)(4326008)(8676002)(8936002)(316002)(6636002)(41300700001)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3grZDczWEQzbzJMRmpDU2pNRzg4Mk1hd2RpQXBPR3IxOVVzK3FTVHdpdWg1?=
 =?utf-8?B?UHdPYjdvQkJnK3NtajhVNmVGZUpENjJ1MGp3aitiYU1iSlNkOVRQRTlEYTAv?=
 =?utf-8?B?UVF5Ulk0MDlEbUVrTGZWLysvZ284aEVJZy90TTRwWnk5V3BXcS8yaEZDdnIv?=
 =?utf-8?B?NWdzUUlPQWZXM0ZGS0hLdVFPQjRPZkdQSGRFVytCT1R0UVVqZTlUTFB6ZzNs?=
 =?utf-8?B?MERxQTFxL2ZKUHBOeFh6eTNPQVVCVzV3RUQrMnNrTktDQXlEdlZDSU1acmlw?=
 =?utf-8?B?amNBTTB1cmt5UkVwODM5WDJlYTh4UzVnYy95KytJeVFqcnJZaGxVTWUrb1FW?=
 =?utf-8?B?OG5CeDczT01yNGlvNGo4cnF5Q3JubkFsR04ralhYNjZoSHBGMytyMk5UWnlP?=
 =?utf-8?B?eC8vQ2RqTWw2eHJzTHNZdk1Gdm1UeWN5ZVU1bXpEeFRSNVhVRnJQKzI0bGRV?=
 =?utf-8?B?bG05YktUWmg2ci9kS0ZUb1pkYzgrM0JYYVhpdTNUWEt2SE9YQ1NVQ0M3QWpV?=
 =?utf-8?B?eHg4UzQxN2NJcXFVcmxUbXlnbG1OejNrMDFPNlJXaU9BeTgyOUVCSGgxRzY1?=
 =?utf-8?B?NHdxUzlDZzA1YlhBQUVXSWQxeW1yN1hySXk5RUJDWjlZWDNLSHl4UDQxNkhj?=
 =?utf-8?B?emlQRTdXcUtBNXRXdzE3MEdrcUVhMjFodlUyNEMvV0dwYmpUeW9vVU5TZjA5?=
 =?utf-8?B?VWZZaHdyWEhpcmsrZytJWnA0dXRaQk1jNVZNZ3ByT2U1REtyWnVGTU9ZZnRI?=
 =?utf-8?B?RXhXQ1RNV3l2QVNCdXhWREFpejlVMEVuVEg2ZEZWcjhLUW9IQ2NSZnQ3YmhV?=
 =?utf-8?B?NFJBVEdrZXFFVnZjQnVPSlU4Z3A0THZqM1hISVRsY1N6ZGxIVGVZZ1hwdE5E?=
 =?utf-8?B?MUorYnZ4eGY4aU45eHFnTDlBdHB3WFdhOWY0SGNEaW9Pd3ZTT24wYXlWWGJq?=
 =?utf-8?B?VG90SWN4YjBEMEp1Y2JGVDRoYWJyZjVxeDd1djZtVU02S0ZPeExYVnBLWTlh?=
 =?utf-8?B?OTlQVzc0MGNxalovWUhjcHJvTGtEanB5NXpBNnUzZExtc3RVNmExUmhKT3Nk?=
 =?utf-8?B?ZVV0T2gzeVIvclpyOGVhM3llNUFYbmZxUHF5dmROVGZtZTNEZ2NrTm4zTFFi?=
 =?utf-8?B?djFOUEN2aWV5UnNhb2JrV2RMSzJIa1RLcXpYUTYrQUlteFpPcm5uT1IvdnVU?=
 =?utf-8?B?b2ZxVDhQOHVVak9TRG1MVGFSWHV6bnlqWW44OEhiZ3RoSERQR1JWUlJ5RS8z?=
 =?utf-8?B?cTl4Y0hiQ040VWEwNG9OVUsrMkYrY3d0R25Xbm4rcEhCUEJCVUZ6QVBxUDJC?=
 =?utf-8?B?MCtuaUYrNWZ4L0g5aFhIcEJhcWtEMms1S3NCV2tBYzFYTk5kTm5IK2F2M2Rp?=
 =?utf-8?B?OENVOUVod1ltNnR0MVMyYjFmUzU1cExjV0ZKKzgzNnJqNk0vVU00QWpHVjdw?=
 =?utf-8?B?cml0d1I2cXVSZittOWxtaElDNk1sa0E5NjBtdTdoc3BOQkZlZFdPYTNwQVVr?=
 =?utf-8?B?QnhsUVU1L1djWEg4NU5RelZJaE1oaFJONmFnaUNiRUxNWE10ekhRM29PdnF4?=
 =?utf-8?B?WEpVVUNkZkZWS0J0amdldnhCNHFIMmw1OFlYTDdWVmZ2ajFnUHA0OHFsaHR3?=
 =?utf-8?B?SWZJcWxNQzhkcWYxTkJFcDZkUU8rTlRwbWtSMDJGdWwzelgxdmpxZzlSN0ZZ?=
 =?utf-8?B?eTRRenh4cmFDN2wrSVNyWEFTbEI4SUxlZU1lVW5NaFJ1RUhRck5FWnpxNVdn?=
 =?utf-8?B?eTNpbWxMeSt1LzU5QUd5cC90VzZvV3Ryam9mL2Zja0hZcFhYZERWR1hqQ2N4?=
 =?utf-8?B?M1hwYTgzK0h5MGl0cFdrMGhFTEtnVkxZK2dsbVFkR01QZE51T0hXRkVkY2hV?=
 =?utf-8?B?SDR6SFpRbWpXRFgwWWFqMDE5UFB2U2VWTktVVUFPV3Nid1pHdHB4TUhLem43?=
 =?utf-8?B?UHpjdkcwMWRDS1NLNlRUZVRveU1KcEpUT1ZHY05Bd0hYdVdZUW5NNStjMHRD?=
 =?utf-8?B?a0o0ZWxZMFVPbEN0T1htREZLQnBzZ3pCMkdha2padzJKbjhCdzFvTzhWS1U0?=
 =?utf-8?B?eExkOHdUOVgzL2FRT2R3OEhuclo5Mjc1aTdCWDNDRm9MQVAybm0zYWI0TEJO?=
 =?utf-8?Q?PRcAR8t4zF2Ub36nhS4ZvaZSJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 349b8b87-7bcb-41f2-5d40-08dbd979e29c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 18:56:12.2010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9RFOp9HCIHeCUJSH1Y6h1ZXPgm1jJdMl1Jsi1G+LmElN0YGUanRlwLx1QXxYieyws+aZIUiqW9DcShERmVsxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8377
X-OriginatorOrg: intel.com



On 10/29/23 01:00, 'Guanjun' wrote:
> From: Guanjun <guanjun@linux.alibaba.com>
> 
> The int_handle field in hw descriptor should also be protected
> by wmb() before possibly triggering a DMA read.
> 
> Signed-off-by: Guanjun <guanjun@linux.alibaba.com>

As Dave said, need to add fixes tag.

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua Yu

