Return-Path: <dmaengine+bounces-4138-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC637A13F1F
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 17:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94253A73EC
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BA922BADF;
	Thu, 16 Jan 2025 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O4uA4isP"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24EB22BAC0;
	Thu, 16 Jan 2025 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044345; cv=fail; b=U6kTPPU3u+bUuPIpeuhscvYS2a9VIyDTjI1HTddRLdMsO28xQm/hUQiG2qJcsSkKypKWzEskkoGj8/ptugHxuzRGrXIVd1VbvsEi0HmjkAEd5IH/kg1GIp8UD7cxFVVkkZ96FBYLWK+KzrDI8S1zpuYhM5yn6EC7WzLzKW3M9BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044345; c=relaxed/simple;
	bh=Ub8O9k6ZeEfzXdZMtNPhD0JYwnURaiMEkAY+bHoLdg8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZWXBm2HPwxK0IfBFJimIi5HQz2FNfMy83eCUvnw61I0wHGUqvMWwWH70joi7j7vOjzlRgSnXaPcuNajV/qypOUAOYIHWZym2Bh5/awNHiU+BAPKVk16IMBt5zw878m5zO51h4UPJRqbmbLCU9/vnNG/mGf44y8GcAMCFrJTB6dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O4uA4isP; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4EV5wG3iKINcJZsjacYYeKnnqGGjFh2GgecG5mNOsjDEvUeRQwzEwRpzTMxlWZMLbjU+WwQtItCkDSmaHBX6pfKM8r5ZGGDfAYrYlH7OWeAvd1MZjkqLE9hEn5BHDDp5PBq63LEyixDnlxmKIh4gLSFAiEjinhEwYunK2lwNzrCS9iyaGZKO+0LV4yKZi+Q7m4RzGh7Zj3pRAgQZGKTlvtMOeOWnpfcDg/8UP4TPySCK7MIwoh9+xkREwMQlGIFS7qkzLIDSpgyAF/12nAUT63+WFMVaK88GkKh0kEs3H8EQ3uncq4kACJ2f15CvCVMy8BQpncwQL+Y7H+IRgpGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R24v1m+ow62w0Te/lXmiazXuzUSFq1Q2CBr+dT9wvI4=;
 b=MpQT6NlN1HXhWHgPtJ3j1DxOEtwGFzFG1cwDDi9cqsKZEOvYmlJKGpLiZUNkcAqhcXdvZc4RzqlVMVGfMrFybxBsfOMsiOqI7N+MlIf3lCxVjQfwKO78wUnIAT6qZmyQYEH8Ze/x2YmW4me+aCNBHtutmdsZu0faO46X9WguKj5rJi7uEgtrrRx6A2c6uMWkPYLTcwoyzPOSPZ28yYMUy1CiqFq6SDUMZpm2GLACTWfjESpnvazdVfS3zaNG4zOtFxoEwKNaUDiHMPgsch3KttB+GW9teNaJJ4CKOTREzZSqrQ2RIqSZp6c4pbsvMMgUi08LARBw/l5zowgpYb545w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R24v1m+ow62w0Te/lXmiazXuzUSFq1Q2CBr+dT9wvI4=;
 b=O4uA4isPyFI+4Z/e7TXIwaspYPXsRgdAmY9eEq4r1FhoxQqvDtGW5AgHjLR9aJfSc094r2BI3y9z9+lB3Vb/VBD8nQvTQe+a33+OBnt4zFoHq81uK4yiF3tGeNgQ0g7DGQTBMpuoimwt4hzgAh58IHaFYPOqhk3P+y07ccb0EAqyZWPSrYZho3135yBw5zDBSpfyjELujrT+7KOQdqSk7u7qfsuPdGkC1rHpsIs78hXOWtGYcpSaEdTmsdDAy3fy8s4e+7IC1QuW4qF088RbxfKpvReSsP2o7uzpsMj7/mFGM1W6RGlmMzx55pUEVoBQ6DLCAL2h45hBPMVdwrppZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.15; Thu, 16 Jan
 2025 16:19:01 +0000
Received: from DM4PR12MB5101.namprd12.prod.outlook.com
 ([fe80::8a69:5694:f724:868b]) by DM4PR12MB5101.namprd12.prod.outlook.com
 ([fe80::8a69:5694:f724:868b%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 16:19:00 +0000
Message-ID: <58faf41b-9f04-43e5-9a43-d143107f5675@nvidia.com>
Date: Thu, 16 Jan 2025 21:48:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dmaengine: tegra210-adma: check for adma max page
To: Jon Hunter <jonathanh@nvidia.com>, vkoul@kernel.org,
 thierry.reding@gmail.com
Cc: dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250116155220.3896947-1-mkumard@nvidia.com>
 <20250116155220.3896947-3-mkumard@nvidia.com>
 <c16c58c1-97a0-401d-a8e9-57619b2f99bb@nvidia.com>
Content-Language: en-US
From: Mohan Kumar D <mkumard@nvidia.com>
In-Reply-To: <c16c58c1-97a0-401d-a8e9-57619b2f99bb@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::20) To DM4PR12MB5101.namprd12.prod.outlook.com
 (2603:10b6:5:390::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5101:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9d8da9-e5d9-4ccc-c042-08dd36497c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2x4OUpvK3lXcXZDTGxsZDJUbDdtQXBneXJPcFRkSGZjQjZFM1pIS2tQQXFQ?=
 =?utf-8?B?a3B1eS92bUNEck9yOStTZDhmbFpGUW9RSi8vc0RaQkI0OUtuc2liTHZDNGRr?=
 =?utf-8?B?L2drMDBURWhnejB0cG9ZNXMzQm90K3N5Z1JZaW9GL2Z5Nk1zQVBDWmVwVVFM?=
 =?utf-8?B?NDE0dG1CSmFwYjlrVTdtQzcxaTRuNnczM25tSVBqamozdVk3V0JFb3lRa2lp?=
 =?utf-8?B?bDBZeG1GMGRMZFNtVnlTZDkwL0ZZenV0TVBXdTFGeVE4bDJjR1l6NDRnVjQ0?=
 =?utf-8?B?RS9xU2VxU3NLazFvNzRNbE4rcitWTTB1cmh3ZEZDdStVRFRTUWVaVVZ3a002?=
 =?utf-8?B?MmgzT2l0RWhjb2tHTlpGUU5uQmgrNEtGd2NFcUI2ZHNrWllhM09UTnhVbEll?=
 =?utf-8?B?S0ZPbnAwVzdxS05iZk04RklTY1JDa09Ya0tWWitleUV3a2xXOWdmUG9MSkFY?=
 =?utf-8?B?bWx2bDFPU1RSWFg0VU1tQzBoNUdtNENCTE1QZFhoeDA1Q1pJckUrTE9iQ3lQ?=
 =?utf-8?B?SjRRYlExaHd0cXZYd2RqenQ4VUxNa3RoWXJpdHhST05NMGx1ZTJFMDVvNnpB?=
 =?utf-8?B?T0ZMRXZodzFCYWpiejdqdzZIbjZDbFhDUldEYUhSN0F3M3R6aTRnYVNzbzhV?=
 =?utf-8?B?SjNRYzA4cFViMm5ma2ZPQnZWLzZzYkRITUhVYkcwWGh6ZERsMnBaYzhyK2pP?=
 =?utf-8?B?UmpIaThRM3dxcHdHbWY3Rnp2V21idWFJZVVwbGdOcXIzUVdzOFJudGFFMnY4?=
 =?utf-8?B?QWVtUkpCN0ttVjZkTmtRTW52UExmN1ZZZ1NGN0RpL2ZwRnlyVzJFcFh3TnFF?=
 =?utf-8?B?TFVYc3ZMUlhiRnREdUVYZnFDc1ZrVkl4RDZnN0lCV29sQXU5Y1A3RzVDcWpT?=
 =?utf-8?B?aUE4RGJieXplMnl3cUx6S1NTMXNVOGFHWmhWaksvLzFpZnEzeGc0em44cHd1?=
 =?utf-8?B?ekxTekZxMnFRVHhpR1VEemQxVjNDMG5vZTU4WVk3b09nNTB0Rzd0MWYzSFp0?=
 =?utf-8?B?M0tWVGdkSk9qVytKVVVkTmZlVmZxY25jeUJkZnZXN1ZEUWh5VGRKcFpwZzcv?=
 =?utf-8?B?UW9tMERLSDlqa2tPSDlpWTNCVDVCZzQvbU5OandpRmdpS1NBanFtTEJqS1pu?=
 =?utf-8?B?aUlIaCt6SmtsNzUwMFZLSWU3NEJZWDNxVU9OUUF6MHdGNU1VR1FQZUp2L1dZ?=
 =?utf-8?B?Nm9oT1c4RzhNam1GZjk1TDhZWWNMbjBER0J2RXpiSVRmU1JqbVFnNWxtSFIv?=
 =?utf-8?B?YTlVRk5UM2hTOWJEYi9hVXdMbkd6ZDNQRmJNaGRpMzJCRTA2bW81cjhXNE9v?=
 =?utf-8?B?UjBsZVlvS0k1bUtpYzlzdmcyMmh1MDAyNGJNd05ZNHZjSThlaW5LVGl4MkFY?=
 =?utf-8?B?dnFaaFdydFJzWWpIVzRTR0Zsa3l5NWwwQm1HL0trc01xMEpReFh4U0lsa29z?=
 =?utf-8?B?cEo2QVE2YUVLcGFjR1o4THZQYTN3WjNFcTBqNGl3YVhUQUxaeEkrdG1IbVpH?=
 =?utf-8?B?VWhtSFF1SjVSa1lpQlN6a2s1LzdWdWp3MDdBbzZXcHRVOVo2dTdMLytBa0Vl?=
 =?utf-8?B?ajl0Ky82SDU3MHFhbTFkVm1CbytOZzBZNzZ5M1FwOXNlWGdGYkhwTjg5aldY?=
 =?utf-8?B?SXU1STYxWjJQVkQ0WitmemNzZ1JpTDNTRWY5ZzR1SitKYzhWTTZsaWxlUWZX?=
 =?utf-8?B?c2FiTmtYdXF4YXh1U3JscDVuMXZLWFhmNE9TUVk4UlJTekUydDM3eGhlUThl?=
 =?utf-8?B?UkJXSzB1bUEwV2djVmdLc2l6blp6SzVTVGpIVnZnTm84M25oWWhGYzVTcC9q?=
 =?utf-8?B?NzFVRVY4WmJZVWlpVDV3dDVNRkoxUy94MXFCNVMvTzF1UzlKMTdGcmw5VGFT?=
 =?utf-8?Q?bNEhAP8PM5jeQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXRBSnpkdnBLbE5aS2NZcVZnd241ZGhVbldtZnJOdDRmRnhUaU0zOGZ4SVd5?=
 =?utf-8?B?WFdKN3A5WjM2ZHRPY1prb0RaakR3Q211dEtxVkU0TzBsdWs4NFUzd0c0VC8r?=
 =?utf-8?B?SGd4NEZmMHJPSjgyY1RKa0V3S1J6VGhCV0pZdHlyQTF2OXdiU1hOczhxUEtO?=
 =?utf-8?B?dDUwSWx5YmtydWd1MzhOWEJHd1BqZXR4YjQ1RVFXNGlHN3k4Q3RlQkdZSENN?=
 =?utf-8?B?K2xkU2thRmZnVTMrK1FIZEdIR0h4S040WU5oV25WenBkMVk3TXFKUXJZRzNl?=
 =?utf-8?B?dkJNQVptU2lMQlNGNm83ckdvdkpXRzhpWFpxMU9rWFozUkZqOFVpWi8zWWJ3?=
 =?utf-8?B?ODVWUktORER4SEpueHdJS0lkelMvZjN3bVVnbk5XRTE2ZGlGWGRpcGtlUnoy?=
 =?utf-8?B?NjZ2NFhhSHZrNXc4NnhPNUN5RjU0bW9EWENrSWdFQThvTG5FZi9iSGxua3lF?=
 =?utf-8?B?ajlZVUM5am9yclRNOFVoYzhOR25QL2t4THFLRzYwWWJpVStCTzY2TXE5amlG?=
 =?utf-8?B?TjR5VUJBekhRMWk4UWFJc0hNblJsb3QyOHZCQlBSYlRPWG04OVI3VllSSmlW?=
 =?utf-8?B?OTA0WDFSa0pnRGFNZldQUEl0ZWxYRksrU3FFUVE1dzBROU4rOFdZQVgzOFEv?=
 =?utf-8?B?OHlOakt5UmpYQ3dYQkJqZ1JKZ09vR1FDSHlweWFRdkUranRjdGdrRE03ZGpo?=
 =?utf-8?B?cFNyRUhsbEM1TW5lWUxYaTVyOGlHTEZwMWxYOTVBdjJkSHYwM0YyRjdJMDdj?=
 =?utf-8?B?c1Nqa01lNnB1UWdTaHNNOEhLRXMrUDY5WGlqNmF3VXJVZlU2c2tmdDdHMURK?=
 =?utf-8?B?N1ZobUdmcVgwZ29nUXUxcFdjNFdjMEdPZjgrTmRYcWp1OGt5NzV5YjMyVm5S?=
 =?utf-8?B?Q2QyT0ErdDA2dmpOREdCbS96Z2NQdGlvTG9JRXBFL2NWV2MyUjlPc2Z2TkhC?=
 =?utf-8?B?UW5QUnNFNlpKYW85VFFDcldrV2ErUnJ4ZEovZGt2WWdtWDEzcjJvc0RPaXRQ?=
 =?utf-8?B?NmFqclRaL2JFbUZma3JhVytLRlNJeXIxb0dlS2F3eTZmRFB4bXp0cVZKRzU2?=
 =?utf-8?B?c1JORTZmMHJkdWt0QnVJaFdrSUNzQWJITFZYb21jZTMzakdlbWMxWEZXRDBP?=
 =?utf-8?B?NnNnTHREeVA5QzdNbkdRNE5sRHVtcldkWWNQVkp3K2NjWjYxZXRxMDRJc0FH?=
 =?utf-8?B?eEY1bnBzOCtEUS96M05zZGhZYzlDL005eWc0bExaNVJtR08xSHFGSTZIbEtT?=
 =?utf-8?B?NTZzR1ZuQ3VmM01Dejh6aWJlZHlkd2lMVHpZWnYwNlk4MmsyWk5tRllwSlow?=
 =?utf-8?B?U29YQW0vT1NxY2MyTUFvUmR5VnZ1dk9IbTJiQ1N1TUNaZUpSNmoxWk0rdk5k?=
 =?utf-8?B?c0dPN1Iwc2FMNGR4bzh1bDFXQU4xaUgyanFVK1pneERzbkV6bmwzRVZVZXZn?=
 =?utf-8?B?OU93VWJ1ckVsWHFxQUNvdmFDOElObVpMZWtFdVJQQTBDMFFkTENjTDlzSTk3?=
 =?utf-8?B?cWt2RExwaWlLRHAreW1BWjdoNy9OUDEzTERCR0g3aTNaYXlhK0x0RnNNdEhM?=
 =?utf-8?B?Q0Q1c3VUNGJud3ZnR0hIRUlGTDNacjdtWUJkVndEUk41ZmNMeE40ZkhOTmVa?=
 =?utf-8?B?YkVieUxBdnV2SmhHMW5rdFJPY3gwTE1nUmFQZ1l6Ty9DSVBNTTVTTnJwRWlZ?=
 =?utf-8?B?VGkxeXVwcVQ2RXJQR3l0MjZsSXRWdEVJc2tnMHU5WkFqTFNlU0UvSzNKRkdN?=
 =?utf-8?B?YXArTDJFdS9QTVBuVHhjOW0rbGFORDIyS0lMcEs4WVMvVWQvMXVTZDJReEZs?=
 =?utf-8?B?cG5SWENMRVVxM002aGw4TGpGYThwaUhobU9UZlEzdGFZMVJxcjRnZnJUbTRo?=
 =?utf-8?B?VXNUNjZVNFlNYzM0YXhrei9XTzU4YXovKzVaN2VFVlIvOGExRitGcGJURjdv?=
 =?utf-8?B?bGJtdzJqdFdsUkpTdVV3QzdBNWt2V1JDd3ppY1JPUWdnTCs5V2VqcDU5dHFX?=
 =?utf-8?B?amJ1NSt6VnFPRklTelJ3Z3V2czQzR3ZkcjRCY3R5RTFJTmh3UWFsQ0N4TWx0?=
 =?utf-8?B?bTE0eXlpbzFTc2R6VUFha0FwSjByMlZsQmVxYStES3hQdTcvZGZQVDBtdmQ3?=
 =?utf-8?Q?dqbIsrp/kUyfYJK3p32hsFIgW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9d8da9-e5d9-4ccc-c042-08dd36497c2c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 16:19:00.4038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1LTsrzQPwH0JvANTs3954aQ95ndnNh6NHTx2KwmqtsgietDGYxiv99t0/l2Y7Y7ckfeynmm1jaNpuzCG+iPEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989


On 16-01-2025 21:24, Jon Hunter wrote:
>
>
> On 16/01/2025 15:52, Mohan Kumar D wrote:
>> Have additional check for max channel page during the probe
>> to cover if any offset overshoot happens due to wrong DT
>> configuration.
>>
>> Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
>> ---
>>   drivers/dma/tegra210-adma.c                  | 7 ++++++-
>>   drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 2 +-
>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
>> index 258220c9cb50..393e8a8a5bc1 100644
>> --- a/drivers/dma/tegra210-adma.c
>> +++ b/drivers/dma/tegra210-adma.c
>> @@ -83,7 +83,9 @@ struct tegra_adma;
>>    * @nr_channels: Number of DMA channels available.
>>    * @ch_fifo_size_mask: Mask for FIFO size field.
>>    * @sreq_index_offset: Slave channel index offset.
>> + * @max_page: Maximum ADMA Channel Page.
>>    * @has_outstanding_reqs: If DMA channel can have outstanding 
>> requests.
>> + * @set_global_pg_config: Global page programming.
>>    */
>>   struct tegra_adma_chip_data {
>>       unsigned int (*adma_get_burst_config)(unsigned int burst_size);
>> @@ -99,6 +101,7 @@ struct tegra_adma_chip_data {
>>       unsigned int nr_channels;
>>       unsigned int ch_fifo_size_mask;
>>       unsigned int sreq_index_offset;
>> +    unsigned int max_page;
>>       bool has_outstanding_reqs;
>>       void (*set_global_pg_config)(struct tegra_adma *tdma);
>>   };
>> @@ -854,6 +857,7 @@ static const struct tegra_adma_chip_data 
>> tegra210_chip_data = {
>>       .nr_channels        = 22,
>>       .ch_fifo_size_mask    = 0xf,
>>       .sreq_index_offset    = 2,
>> +    .max_page        = 0,
>>       .has_outstanding_reqs    = false,
>>       .set_global_pg_config    = NULL,
>>   };
>> @@ -871,6 +875,7 @@ static const struct tegra_adma_chip_data 
>> tegra186_chip_data = {
>>       .nr_channels        = 32,
>>       .ch_fifo_size_mask    = 0x1f,
>>       .sreq_index_offset    = 4,
>> +    .max_page        = 4,
>>       .has_outstanding_reqs    = true,
>>       .set_global_pg_config    = tegra186_adma_global_page_config,
>>   };
>> @@ -922,7 +927,7 @@ static int tegra_adma_probe(struct 
>> platform_device *pdev)
>>               page_offset = lower_32_bits(res_page->start) -
>>                           lower_32_bits(res_base->start);
>>               page_no = page_offset / cdata->ch_base_offset;
>> -            if (page_no == 0)
>> +            if (page_no == 0 || page_no > cdata->max_page)
>>                   return -EINVAL;
>>                 tdma->ch_page_no = page_no - 1;
>> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c 
>> b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
>> index 45004f598e4d..2af939bab62b 100644
>> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
>> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
>> @@ -466,7 +466,7 @@ static int fsl_samsung_hdmi_phy_configure(struct 
>> fsl_samsung_hdmi_phy *phy,
>>       writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK,
>>              cfg->pll_div_regs[2] >> 4), phy->regs + PHY_REG(21));
>>   -    fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
>> +    //fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
>
> Looks like we need a V3!
Oops! My bad, will remove this unwanted line change.
>
> Jon

