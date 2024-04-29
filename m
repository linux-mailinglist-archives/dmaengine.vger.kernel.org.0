Return-Path: <dmaengine+bounces-1974-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0838B63E3
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2024 22:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29D028762D
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2024 20:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADBE15DBA1;
	Mon, 29 Apr 2024 20:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5784047"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ADB1E886;
	Mon, 29 Apr 2024 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714424213; cv=fail; b=iMlkRDGn1z4M5J+dKee26h3I0s3ic05H8Yk19WxjmV7otUPHQpLTQnG8EMk+/yIt09Q/tIs5Q29IjHrXACzMDji4JLL4fi58AjBcBV+GgEI8rbjWCUOwKMhWokirxbIrU6FDrxDIiQWDQ74IJws1SYmuc7oqnHVcAlGwVQxPDtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714424213; c=relaxed/simple;
	bh=RN9xsGzN5nQzV+TWo6BI7avV1ZgzgqVk3JJo4kwdoP4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HK0QYUzTF2UjRmMFinYmE+CAaLlc0gPSIJaq+mcDJ65OX9vgHry3DPSAnuC91bXXhPrCnJOdgCHxG6lnSShok3cmoOAm35WR2AMKHBGeLeTUxwD81STk7W08uL6WS5QOUhfQL1PQwISk0Zcn/oaaeUkxqh7ZlfDpEXEdrQcqwgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5784047; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714424212; x=1745960212;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RN9xsGzN5nQzV+TWo6BI7avV1ZgzgqVk3JJo4kwdoP4=;
  b=j5784047CdzCqomEpkRZkzDEANHmVgrqQdesQJeGmvJqI7dMbwes58/l
   c+WaZN+zTGtycbWFu+MKvAFBLM5rycyzs+MLJ9RkGGtlCGgA+5dORJ0dn
   SlvLOAQDoPZLDYTOaMmQuH+noPRwSje64RIDt39i4AcP/X50qZrYoKfhA
   6jlmQ5YNFUKIPXviXKBKFT+9aPexd4QgU8N+O53a3sS3XSUxW9nzh6sEU
   J+/MG4gkzfLdgR0BRCUfO4fYzsk2ma+ax+oO0tfdjXISHKKEEhTvkqsN4
   KWnU2aJhgAyxjrF+GR2kPQncTpYu8Q8ATmMJfBsoJMULAi+FfR/pOeBLn
   A==;
X-CSE-ConnectionGUID: cqVLmn98SZaNF2N5/qVx5A==
X-CSE-MsgGUID: wFzbv5h1SD2iCAII3OxI5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="32610050"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="32610050"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 13:56:51 -0700
X-CSE-ConnectionGUID: XAuUf+C+Q3CD/ePbgFQMnA==
X-CSE-MsgGUID: M75wH9eCQlmUqaNZ5AOofQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="63707367"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 13:56:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 13:56:51 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 13:56:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 13:56:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 13:56:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndBsiRlCUWcFhAb3J+7wLNWXbqgie053DAjMwgIEkekbPtsNHwXCGHrgCV/OD4grvzaJT1IAUZpK3ZD67B1H7J5zYi6AYPLRkurZ7c7juH2ToMRx70jZGAV3FabNq+0LRtZGdU/WpK8OsJ0x9dj4rg8Lq/wCMFKh9oLnoAPm8uBHmPfKOkwYe+FWGVe7s8mitT7G2XUuUrNR1wNGuvvaX1uoPLK7jP7sIUpKl1bO79oJGlmCJ+eCwZ2KJ5sU0f3cO7SvUiAW/49maJX+v3RXp7i/huWhxWB9IAeEn4WTjBK4f57yKKFxCEuYLqLpgJwwgpfklwjULQTpnyRsLx3hIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfm92LRRnBK2BXhHwMFqrE1ANqaBCSpvEbU4BXpdo7U=;
 b=DDP6kgOxiKkqMWCa+MDsloZ941s4zKRzVsOC8wSGFb5st4o3wanVAK5T5tpwy1wEl1K9vzXY2x8rx0DQ8QU2ULJepe3Atn2ygynblM/M17Nr/tQqTqCELaU6gRE3iNj9Uxdz5S4o7FwM0jQKivibz4YU3XFRPS510EpEIG3oifK0Fl0zn5GuRAkDVgJ2jU3Zk//TeDpTlXFktrb3ACivZwLz+SoNuPtdMmoLrEDcXPkPC39X2yjiVmpJV2DqqONENG0bjYwkJAtvcdeUDJLvo4A9CSUqDNyEIPr5Wo81PFQrQ1qhhPh3yw3136HvlJEm2whN7hbwhmE40w875j1/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB5263.namprd11.prod.outlook.com (2603:10b6:5:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 20:56:49 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%5]) with mapi id 15.20.7519.020; Mon, 29 Apr 2024
 20:56:48 +0000
Message-ID: <8d384dcf-8688-ce7d-1dcf-432aad706221@intel.com>
Date: Mon, 29 Apr 2024 13:56:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: idxd: Avoid unnecessary destruction of
 file_ida
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Lijun Pan <lijun.pan@intel.com>
References: <20240130013954.2024231-1-fenghua.yu@intel.com>
 <b4d845d8-24e3-43ce-b1d4-e121f799e26c@intel.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <b4d845d8-24e3-43ce-b1d4-e121f799e26c@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0040.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::17) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB5263:EE_
X-MS-Office365-Filtering-Correlation-Id: 381503e7-c255-4f8b-5ddb-08dc688ee342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ei8yUkorTS9wcmtXaEM5clFJUkJqZ3lXU09XKzI4Q1RBTXZSL0d1Q2loYU5H?=
 =?utf-8?B?Z2Qya0x1TjRyTnBzRlVkWllRSXUvemxGUGxRMzVUVzRnWDZHajBlNGM2VTZI?=
 =?utf-8?B?ejFkSDFkZEx1UDM2MDMwNnhHTFRISXRXREM0dmEwOXMvOXFwaEc2S2Z0SXU0?=
 =?utf-8?B?VzdKRWg2NU4vMGFRbysyQiszYmdFZ1RhZU5iUGM4YXdGbnZLL3dGYlhONHBp?=
 =?utf-8?B?YnUyRjFLZUtOUzFYZUNHT1pGQXVwK1cvN2ViU2VDTzFqZ09EWHJwbDBrMjhP?=
 =?utf-8?B?alduWXRvcW5IWElWV3NVU0c2ZjFLQjg3MzRtZVlMR2VLMUlPZEUyMjI3dndT?=
 =?utf-8?B?KzRoeS9qbUpzMU1UWnk1dDVIaTRPK0lKNU1LekJzaHlhM2dWcEFVQTkrOXhl?=
 =?utf-8?B?ZHJsRFN1UE85SlhQMVNWTzU4Y0xGWTB1YTFGTDl2UFVOZjRmY2xReks3SmhO?=
 =?utf-8?B?TnZMVTZBTUtCcnFMMENDWnFVem52a3hqRjltRmFlbXVtc2dCajZHYnNtalBX?=
 =?utf-8?B?K0tnUEMvOTF5MVZvaXgrWWhGdE43Vk81S1FzVjlDOTN4ZEJJSXVHWXpkOGtz?=
 =?utf-8?B?VUZqZ21DSTNyN1B0TG9SMHJYTVJVZHJXKzIzVEh4ajVNSjVGTlZ5TWJ1SGhr?=
 =?utf-8?B?QnhRUUVISkpRbkc1eDV1bHZkU3Q0RkNHSzcxWU9RRFhyZGF1dmcwbHJ4WmU4?=
 =?utf-8?B?d21id0JyWVExVkhzQlJDZ20zdmcwME5SdlRWQ1NjUnZ5NW43N0MrOEdrYzIv?=
 =?utf-8?B?cHJaRC92YXZRaTkyUlc5TDFPbmplVzdPNmpzUkxrRzhJRStKd1NNNXlraTRv?=
 =?utf-8?B?WXVRdmRTQ3FVb1RQUnpVMU5FL3RIYXBiVnZEZ2ZrSlQydFlnSDN4cW9NSzdz?=
 =?utf-8?B?UjZ2cFFOWkVYT1dGMGh5d2tYMDlaeEwvREhFSS9oVjludnk5Z21maFBxY1ZD?=
 =?utf-8?B?RllNRm1GTU95ZnRVb0Q2N2U3OFVYMXdOWEZJdFp3b0lVMy9ETDNIVU9Kd3pr?=
 =?utf-8?B?QjhwRWlOQS8yR1VjWUdxVUMzUThDU0xBbkFCeDU5VnhEQ1dLNUFFT1hOTzhP?=
 =?utf-8?B?ODNlRlV4cWxPcENmRmJxcFVDM044aWM4WW5iWk5sc1Z2RldER2VSdmpqTC85?=
 =?utf-8?B?YVUyM3VKZ3RPODlHUHg5ZGdtdXlQWUdvME4vTnRHaUcyNFFHVm82VmQ5Z3ZU?=
 =?utf-8?B?VXFhZEJZeFE4bjFzOTYyamdwRnBBV3lOQ003RzZwVmV3c2pJakRjdkplZGlL?=
 =?utf-8?B?dTlVNjJrbVp2Um9melpGRWphRU5ZM1J0UFVJNXppQ0JHNWQySXVoYlE2dHJZ?=
 =?utf-8?B?YWs3eDVPYnJFVUlNQllzMkREaElkckFBbWt4WFpsTmZBOWMwdzRvckFGak9I?=
 =?utf-8?B?YUpCN2VBek9xMU5PczQyUTNVQ1J1Q1hRdVB6Mndtc2FsZlIxSVVUV3oydWxP?=
 =?utf-8?B?dlBIZlJlVnVEZmNaWDVQVGd4Sk9hbFVsOUlOREJ1NG1JVnNMNVBXUjZnbEtq?=
 =?utf-8?B?dFZsTGdWM3ZYTEIySk05NTdoMXV3d2JhR2pqSGVweUliaVFiR2txeC9KOFNv?=
 =?utf-8?B?RU9LT3FtM0s2UXl1UnhDazNGRW4rNFJwU3dSUDQzYUFJZUMxZS8rMnIrZ0Rh?=
 =?utf-8?B?QzlxU1hHKzIyaFpLeVlqSm1xMlJiYTlZM1VuMU8rdWJTMyt2Q2lQV1M5YUtp?=
 =?utf-8?B?N2pseUt6eklacU03amo0ckZiWXVHbXpuYy9JQXpsbXFrNFR3NzFNYWdnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmdURThzMHM2YW9MWDNRNVA4V0NtZXlWRWE5Rm9FQXcvNW9WZUFic0Y3Mnk4?=
 =?utf-8?B?L2hLc3hyYXBKL0hsa2V5cjY4OVExbjdlM0Z0MFJKN0d4MGhiQUFmaDBGWkZ5?=
 =?utf-8?B?QTlFem9XTWtOTmQycEFBNU5hdUl6bDFHN0NhTmZoSU5tWnJBRnhMdDVUdWdT?=
 =?utf-8?B?L3NpanhmWHcxdHUzbzc5TG9NcnVlOVdhc05WR0hnWXc0V29NOFlSSTF4NnJZ?=
 =?utf-8?B?OThMY3Q2Ylkxa0lmODNBdGVOTmJHNHQyNEUrTG81TnZuV3JPdXRLZGh4N1JI?=
 =?utf-8?B?aFpPT2lNSkpwd0c5ek5XNlo5dkJSSXpGNmlMQnlaV2JpVnlHem5hZU9YK0pt?=
 =?utf-8?B?L2dRZ3hZazF4UE1TNUxSK3BuZlc3cm5abmtudDVkTlFUUURjcFhZbXREaDNn?=
 =?utf-8?B?dGhyQ1ZZSlV6VEdCaXdFZHM3dmhRN1JWYXV6dmU3NEFpT3FJY1lxSVVtMjVi?=
 =?utf-8?B?V1hGWC9YQUpWTTcwSTdKbm4zaWEyT0xIcFMvWHFZUFZHUHVRNThVbVpiK0E3?=
 =?utf-8?B?R1VSZW12TDErd2lNaThyTE9GNDhnUE5UMVBxN1RMVFZodHF6T1lERFlZcXpT?=
 =?utf-8?B?cHJwa1NaMFVlSC91bXJzOXdlKzAyT2pZb25JOGNXNi9HbnN2MWJIT3JiS2JY?=
 =?utf-8?B?OU41czd3UW9GdHpRcThReUtLUUZQaFRZRUFzYWhuTm5EU2lqL2tReHAycS83?=
 =?utf-8?B?Y2g1anZFbWJBNHhMMzA5ZVAycVUyOWczYW9wOGxMdVNaQzczQUFxTllIRGZD?=
 =?utf-8?B?ZzNPdmQwOWoyUnR3bHUzM2hXdElKVUNnUkJYMjJrY3dJSkxDMWFTaFhGVTVL?=
 =?utf-8?B?RGY4ZHBhOFlPa0ZTR2hEUG1sZGJ4ZzJIR3dUd3ZQWnIvendBcVF2Ry9pSFUw?=
 =?utf-8?B?My9oU0NpSkpmclpTc0xGVHg4bFNkZUJVVWNNRmJ3MDgxUDdHN0xqa3c1dEI5?=
 =?utf-8?B?a3N3a01vMmp4WWlkZlV3SzZ4Q3pKVmszWjVMOEJIbzl1ZFg0YVZEVVB4ck5M?=
 =?utf-8?B?YXdXdkZtT3JBd0ZneDRtOHRSaWl0TTg0dUVMd2RraUg2NXFtTUIvajlZaFFU?=
 =?utf-8?B?dVNML3R4WDJvQ3JJRGFaY1FxUVlVUUFSVGVBWEZKMi9VMFNiRXdlMlhTVjRV?=
 =?utf-8?B?MjJDRmZ6L0tXRHVWa0dIc2xyRkpmZXBnYlgzTVJ3dlpFL003Q1VZRDY0V0pJ?=
 =?utf-8?B?OUpoU0tBY1NQWEhFNlZYWHg5TGJ2eklPaXlhanlFRlNaUUNaY3lrZkxVbW9l?=
 =?utf-8?B?aDFRb2ZaVWVVZlFjQzRFVmtrblJaY2tha0paZEV0RFVmSUZLZm9YenF0ZmVt?=
 =?utf-8?B?aCsvdGQwOVNHOUZJTGpRZkdWZk5Sak10VUFocy9lVGFBSWd5ZGtDMDlNQ3VJ?=
 =?utf-8?B?VHhFT2lEaUNHclVWaWZhUWw1OU8zVW9laDhpTUxiNGZZaVNlMjBxTXQ0cmJK?=
 =?utf-8?B?MEJRZ2RUK0FIeE5WdVRMQXRhcDhheG1IT25hN1FHYXUzYjV3UTdRTmo1NGxF?=
 =?utf-8?B?Y21nbmVjMkNMZzVJMjZsVTduZGxySTdGVEVoVExOUUE3YmN2S0tWeHYwYWdC?=
 =?utf-8?B?WXBBWG9NZWNOM0MxNkJyelhCV0xlYUZtWlo0OWhLMEdWOVFsdzJ5NmQ5aWNp?=
 =?utf-8?B?UU43cVBOL09OcEZzbXprQUo0aENmdGtkYXJWRGJYbjhTMzB1RzFmT0xnc2lk?=
 =?utf-8?B?OVROWWt2amUyZCs4eUtJdnlseFY5SEdaVzlnR25BZEI3cDZBMUFWa2pHU3RB?=
 =?utf-8?B?WWhtV0czVHQ4MDFRYlI3eVpRZEpXcEtRYkZhOTViQmFsOGVZaHBialVjRGNJ?=
 =?utf-8?B?ejB1MzEySFp1UUpFYWpYNkpEMlZPNkoxTkE0ajVaUUU1OUszcndmY1gwREZn?=
 =?utf-8?B?YzNTQTIyOGNnRXN5M1ZoMVpMSEgvOVVFbmFVRFBlczA1eW9iL0UwajRzcFk0?=
 =?utf-8?B?Q1VPMGcyQlhQQ2NFaEhwczdybGZ2bjJBMjFkZkZBc2RQZ0JRVW9EQlpKQ3B4?=
 =?utf-8?B?dHRUQVRId0Z1N1hMRjVadUtMWW1uNzM0YThmUWRtZFZQNnlpVXluZnZUbEZZ?=
 =?utf-8?B?MGI2bGJDUDN3ZmdxL2hTbGh3WHBXaDZQRnIxSjNlVTZQUzhOc1NrQlN2Wng4?=
 =?utf-8?Q?kww6X775Alea4eqgc/PJzzwEP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 381503e7-c255-4f8b-5ddb-08dc688ee342
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 20:56:48.9164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eysFHx5EuM7N44kqkNfsezcd2PDWf/DOfIxhbx56R9jwQdm5tPXE7cr3JojWZvu51YjUESRtfkFU2W58V7G3KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5263
X-OriginatorOrg: intel.com

Hi, Vinod,

On 1/30/24 07:34, Dave Jiang wrote:
> 
> 
> On 1/29/24 18:39, Fenghua Yu wrote:
>> file_ida is allocated during cdev open and is freed accordingly
>> during cdev release. This sequence is guaranteed by driver file
>> operations. Therefore, there is no need to destroy an already empty
>> file_ida when the WQ cdev is removed.
>>
>> Worse, ida_free() in cdev release may happen after destruction of
>> file_ida per WQ cdev. This can lead to accessing an id in file_ida
>> after it has been destroyed, resulting in a kernel panic.
>>
>> Remove ida_destroy(&file_ida) to address these issues.
>>
>> Fixes: e6fd6d7e5f0f ("dmaengine: idxd: add a device to represent the file opened")
>> Signed-off-by: Lijun Pan <lijun.pan@intel.com>
>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/dma/idxd/cdev.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
>> index baa51927675c..3311c920f47a 100644
>> --- a/drivers/dma/idxd/cdev.c
>> +++ b/drivers/dma/idxd/cdev.c
>> @@ -1272,7 +1272,6 @@ void idxd_wq_del_cdev(struct idxd_wq *wq)
>>   	struct idxd_cdev *idxd_cdev;
>>   
>>   	idxd_cdev = wq->idxd_cdev;
>> -	ida_destroy(&file_ida);
>>   	wq->idxd_cdev = NULL;
>>   	cdev_device_del(&idxd_cdev->cdev, cdev_dev(idxd_cdev));
>>   	put_device(cdev_dev(idxd_cdev));

I noticed this patch was not merged to upstream yet. The patch is still 
cleanly applied to upstream.

Could you please help merge this patch?

Thanks.

-Fenghua

