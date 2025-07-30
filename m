Return-Path: <dmaengine+bounces-5897-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCB1B15AF0
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 10:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B093B0FDA
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 08:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E851C28DEE0;
	Wed, 30 Jul 2025 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="ZYefJsXF"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26129290BD5
	for <dmaengine@vger.kernel.org>; Wed, 30 Jul 2025 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865533; cv=fail; b=r9vybY+XdLZxldY8Q+PSmt3Pj7RbxwwPo5Jn6qA0TO23vveAabA94Mi+mpuKUB4DvWsvF8fRWeNR1qEjhZDraGnTH0rX8PBKobiB/VLV5FU8hH+3OfENZeWlRSJvqkE61ovj7ZFtuyOlQvzq5rZG6BsVapFJf2GLAnya+3kVRvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865533; c=relaxed/simple;
	bh=NstS6h/3lQ8W/UscFK3b4GHRWeGL2GGpgMccxxqhcbM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zv6Zlvw+IzNFlGwpJk67Ka0BijF8Y2uG5kLapGw7bNMIcej9zdmYxElzTARnlz/WxsUQp1Gs/lgORKK2b8GF/Wdl5ux9HigQ/2gMG9gp2KTNqHvKuTMBWS8omMrJOLrQ8VGHQMyti9cq1DG3lbjuMrOBquygmcWSrA9k+64p1lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=ZYefJsXF; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3+hBqTkV3ZxnedIZFZrSCGOf4n3HmAzOhFo1LNbDKSjdVaBhBS9NlDy9uCubbPrDLUM1p67hZ/gLIecUi2LLzwTk6CFAe/aW8py9dgSrq1cj/zuRphI1JXzOaWoTxT9uNbboQEDIi7t8qt0WaKz/QBvogH5P+oanGaZfR4nGCVAaXLBRZ3ZK+dnUe9FTJjSYLhCsFHhuVxIIOrfnVd38h61rwkmsMVvbe/XOwlVjSA5xc5cIQADVKmrR9OJmXErtm1joZD0Mv9IXRKP5lLmb/voRujriEJKz5+P9RLguJV3+q5owsVcOMYSgbsoaiJkxqFXH9LvJ224KfzH+bIlqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NstS6h/3lQ8W/UscFK3b4GHRWeGL2GGpgMccxxqhcbM=;
 b=B6Amo6GQ0+r5hPQ4nITwMZwNMIuyMTCjVwo/3XMwiB/VXVMsraWt3qHI13CacJ/aiiHHOcKq4bZ/39q5l+6bR89N3PikzfPHvKJwb+1GFMXKVk1MNJEuRwYXBCE+qBAacXKpVdjKEn/zuPS7jK0Ym4gQ0dKlrcBvWlP+IiRFVYySFswNaxJnH5AajymBATqjR5S3QFY/Xo8nWXEUfjushVw94412q+Rcv9qpEu4+RHZBpGna5jwcV5WeLgJnd+cuiS2s2aEJn8OaXLX1279wC2xIQJp1wNRpgYlU9kJ9+nqWy5+R1GTavgu4fMKefzOjw7qr2r2s+8lPNR1Lrs4nZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NstS6h/3lQ8W/UscFK3b4GHRWeGL2GGpgMccxxqhcbM=;
 b=ZYefJsXFSxi1p/KYF1DNRT12c5rp5TaHVERt44moO8XdT1pF0pFqMjLXrs6KPaQw/U0gjpffKHwEI0HGGD3/m5U50QpFJOJVu6D3DULa7dqYAQIB3k47cnNlJPtGNu22nD8xnIUf8Az/qKYhvAlB2vzUYBpC5QNFAF0LEL34uBtw+Uw6a2zDJb5Y3/TLFSA0Sl6NzOVd1KPUN0GtopDo68HWqfvUsx0tjHR+fj/CUrgqcmG/0yFZ0aM2sS17mVghcNn8JsXhdnLUAvP0aXR/GEc2R97dE54ngaDk1SvcVWhE/TzYLrbIoWJJVV3k6CZ5kvOa8oBnqz2qM2inuYC28w==
Received: from SA1PR19MB4909.namprd19.prod.outlook.com (2603:10b6:806:1a7::17)
 by LV2PR19MB5959.namprd19.prod.outlook.com (2603:10b6:408:14f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 08:52:09 +0000
Received: from SA1PR19MB4909.namprd19.prod.outlook.com
 ([fe80::6ff2:7087:8d0f:903f]) by SA1PR19MB4909.namprd19.prod.outlook.com
 ([fe80::6ff2:7087:8d0f:903f%4]) with mapi id 15.20.8964.021; Wed, 30 Jul 2025
 08:52:09 +0000
From: Yi xin Zhu <yzhu@maxlinear.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>
CC: Jack Ping Chng <jchng@maxlinear.com>, Suresh Nagaraj
	<sureshnagaraj@maxlinear.com>
Subject: RE: [PATCH 3/5] dmaengine: lgm-dma: split legacy DMA and HDMA
 functions
Thread-Topic: [PATCH 3/5] dmaengine: lgm-dma: split legacy DMA and HDMA
 functions
Thread-Index: AQHcAP2Lm3ojzq/R0E6vTWEblUnDCbRKMiCAgAAoPGA=
Date: Wed, 30 Jul 2025 08:52:09 +0000
Message-ID:
 <SA1PR19MB49094A599C555F550F4497CCC224A@SA1PR19MB4909.namprd19.prod.outlook.com>
References: <20250730024547.3160871-1-yzhu@maxlinear.com>
 <20250730024547.3160871-3-yzhu@maxlinear.com>
 <e3462ab4-73fe-4960-af4c-a7360288e3e3@kernel.org>
In-Reply-To: <e3462ab4-73fe-4960-af4c-a7360288e3e3@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR19MB4909:EE_|LV2PR19MB5959:EE_
x-ms-office365-filtering-correlation-id: cedb2752-1425-4cc2-53cb-08ddcf465e51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZWRhd0JrS0VpQkhBYVFMYVVKaGJGZFNVRmFKRnpWK0g1eW84OE8xRXR0cTBr?=
 =?utf-8?B?T1FRaS9lN2tOYllheEdydkhZTlFJaWpWVWpSZGFsYXRIWkpzN0NqTXBGT01H?=
 =?utf-8?B?TnZ4a1FYQUJaQjB0SU5mTE9SY24yQUREakJpV1pCcjlYZlIyWHdJVTEzZkV2?=
 =?utf-8?B?SGIvVnQ1ZjJVbUVoRUJWVThVVlhJK3Y3Y2dHQ29yOGs0TXBROGZjS3RvSnp6?=
 =?utf-8?B?T3JHYmYzMTcyRmZibE5RTWV5dCthWUQvSnUyeVp5bjNweGZtK0xQYTQva1Ri?=
 =?utf-8?B?OVg3ZHV6ckNrN1NFN2t4dngwd1dFMVBXVGo5MmRQRE5ZelhTTGJ1ZGlpMDZU?=
 =?utf-8?B?T1lUeUd5R2ZXbEh5dVFnMDdKcUUzSlV5aXcvbldMd0hqQVhrR0FjeThWREE3?=
 =?utf-8?B?dDg0ZFU5aUx0QldzeWp0WlFxWS9TTklVaVpLTTFsNk9rTVU0cEtFMFhxL2dD?=
 =?utf-8?B?WExndkszRS8zVjFSdkE3R2dXT29YaDdxektLN1AxYmVWZHRNbllXYXMxeFRE?=
 =?utf-8?B?aWpsQU9GdnF2YzBvSll5RXBTVHVCSlBKNFJkVVJ0b3o1TjZIb2tNWUxyU2lv?=
 =?utf-8?B?S3NVaHVZN29rVVNZZWw4LzZrbXNTaXZsd2IvVml4RVdkYjJ4TVljSzczWWUx?=
 =?utf-8?B?bTNMRnIrMGFmbndvZkllRnlYaDlPZURRLzh1Z2VzZFZCQzgyL1B1dEdnaGpV?=
 =?utf-8?B?SU0yYzB5ZXQ3Qmp4eHBobCtsYjB5d3VCN0YybnIzOTdwSlRvVkorRkhTd0J3?=
 =?utf-8?B?Nmd3UVZnMWdkaHIwZ0Y5aWZhSnA0Tzg2bS9tcThlWVdjZktSZ2FXcVM2ZTNW?=
 =?utf-8?B?cFpuMThtQU1rQ2lPd0d3QTRaejJEYXI1bzZCTlZVUFVQUDcyRXkrS1BPLzRk?=
 =?utf-8?B?Z0loRjZrd2dCZ2VQblhoM0tudkJPZ2E4MzUyMHc2UDUxc3UrWUJNYmVVSkdl?=
 =?utf-8?B?RXJSdGYwdDdMU3NQUktWYjdhRHA1S1F5ekN3eGtSRlJBWTVPakxrVmF6d0lY?=
 =?utf-8?B?azdWQUhZU3FrN1V3WlJtbDlZQ3dwMFZZN1BPQzJvbW0wY2FlTjhZcUd6NUlT?=
 =?utf-8?B?T3czR0lCWUdSK1RiMWs4bDhmWmhCNWNjMWZYbHJUVXRud0tHN3pXUUc4blN5?=
 =?utf-8?B?R1hQSkxGZ0FwK2w4K0krWVh0cjNFc3EwR3dtaG5IYkRDeDR6YStoMjVuQUFT?=
 =?utf-8?B?d0s1UkpTQlNrK1dvRUZNYUhXL1R1cHlwVkl6UExkT0FQMnhpOUlwRXlRNDZ6?=
 =?utf-8?B?TE1qRFhINUFlaml6U3NYcHVGdXJXNjVGWW55dG05YkJSMG13OWUxUkJOMDBn?=
 =?utf-8?B?cHA0a2N2aFRVWmRHNHdYemVIcDhFeThXR1BITi9mUzRTSnIxaWd6bzNBU2FL?=
 =?utf-8?B?UWtzTUNWbnJjZGY0QWVqUnpLSjlyV0c3R3EyS0p2UVdGYXhZR2JNY1FGMHE4?=
 =?utf-8?B?QlhHaG1tVVF1RnpkNzZZZnBJK3dWZHZVTEkranphQXpwOWUvY2NodmZDT0tj?=
 =?utf-8?B?QmcyVGxVZFp6TXhOajBacHVXRUZMRXU5dE5iQ2JlVjdjUE5RbTNKNlgrR0oz?=
 =?utf-8?B?cG43NmVJRmlwYXoyR0tWOVpWc244ZHQ2dnRxam15Zm1nYzlqaXk2d3FrM090?=
 =?utf-8?B?amdjWFJONlBKaFM0bEwrYlFtTElWeExlYVFpNHRIcnlqSWZsZEd1U1RFUnY5?=
 =?utf-8?B?c2dIaHl5YUF6VnBZZ3k0c0s2SndKdk80NUtLSjZNK0ViUUZhbDR6Yi9IQXB4?=
 =?utf-8?B?U0Z2T1phVnRvbGlpRHU2WEdpcVdRd1MvMXBjNkU0WnBENVlPZFhQRi9wdURW?=
 =?utf-8?B?YmNVQ0UvbHl1VzA2OERTak5SRk9SbHBIZnE5R1U1NGNieWQ5OGNwY1ViV1Nj?=
 =?utf-8?B?eWMxMXVTdVozMGN1WGlnR1djYXQyRzFyMUtnaWFNejdSaGExSG1hWnNIWDBO?=
 =?utf-8?B?cmIrWFhUV09lc2Z1M0tLdm9KTFdHYlU2bXFQL0VsTWZmS2kwUkI1NlIydzJl?=
 =?utf-8?B?LzE1WTFsSWhBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB4909.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2NTY2t6WUF3RTFJdnUyVUxlaWw2ZERzbmRmK1VYanJlK3lXOTlvRWFyZENn?=
 =?utf-8?B?QzdwaGh1U1dZMG03V1A5cFBZVHFsWFQ4REdHeGdXSTdGOEdXQVY2VENXS1Fj?=
 =?utf-8?B?VHQ4b3Q5ZnJGVFZqc0lndHY4QXpyN2RzR0RtUGFtcjF3b01VM2Z5Nk9KWGpB?=
 =?utf-8?B?RFZvOUVUVTR0Mlk1TWRTbmtzVG9kWWJpTklubUFiNHBiWHlvSDhvWUJqdzFi?=
 =?utf-8?B?aHdhZW1wUTdIeEtVYUliNTFHTlo2TFVMSE10R3lVd0FUL1VmcUJ1RnVmZVQx?=
 =?utf-8?B?WmtrdTdFRHFWeTMrMFlTZFlyOVViM2dEcmtwZURBSXhaMW1OdWswQUxSVDBM?=
 =?utf-8?B?U0hIc2hiL1FJa0pTMmNRVE5OYkFHS1hXUi91bDhieXBFSm5FRjFxZHhSNUVk?=
 =?utf-8?B?aU1obmZXa2ZXS3FpbnpCd2JzMVVlejJHWXJnZ3hLVVM5ZkxERWlIeERTVG5X?=
 =?utf-8?B?RFBJcG9XVjV5ZjQ5N25wbjJ6QnIzVk9Ub1BreUM4NHBRd0h0dytnS0VlWUoz?=
 =?utf-8?B?Vmk1eDZNK3NFK0VMc0ExVXNoOENySUc1dzlPSjMrWVhUOWhVRGlYY1E5UE1O?=
 =?utf-8?B?VzQ2RkU4dG15V3NiVy9CaEVMYndiM3RjdjdRUTJ0TmFMVlRuSDZRWk5DWklT?=
 =?utf-8?B?RjdiU0FmdnJJdlhUTCtoSUx4aHMvVFFvZ3dYWEtCd3pobVNLdUpZa29KZmhj?=
 =?utf-8?B?cGhROFhVSlYrRTVUdE5Pa3dTUmZUNTZGSC9tMktpUWpMT2YxaUVMbUFuZ1A5?=
 =?utf-8?B?ZUc2a1ZPUitjU0tKd3FuUllxNWVLb1dZUlkwWlFHTDYrdVpUMExNZFVaOVVF?=
 =?utf-8?B?ZTBqdFZDZDJWNnFKZzVCMFhlNzVXYnltZjFaZjZmcURwblUxYVVFZm5mb2s0?=
 =?utf-8?B?NTdCdXNkYVkvU3JhSndUYm1KbEVMVWtRK05JcDBUOU1mM0xQUC9PQXNkdlc4?=
 =?utf-8?B?YTYzaEhnYzFoUlEwWi9CSFRxV0gxSzkrUG44L0l5ZlJ5TTVheUhFSzB5cHY0?=
 =?utf-8?B?NE5NanBseUdqcXJMN1dVQjFOemVtbHpVSzNSRnVEditBK3JDWjF2b2V0Sy94?=
 =?utf-8?B?RFc2UEhrVFJBU3VuOUpERmNFbVh3UENQcUFVR0tzMDBSZWdYd3VWbUMrN2pL?=
 =?utf-8?B?Z3RaZmZXSjV5ajVxOWJVRUVJS0cyZldDaXp1b0ZHVHBDR3dka0s0R1lkL3p5?=
 =?utf-8?B?YXMxWW5NcExuSTJxNTNIbWlTNmtOVTJXTkV3dmUrb2lLOUpCQ3pjRTBjR3Ri?=
 =?utf-8?B?RFBtSkZXU24xMVAxOWozeFpaYzZmbVhGZFRRdXM4OUZKNm41TWFOWkpiZnFs?=
 =?utf-8?B?K3hmMUNtVVBpdWJKR1phTnQ0UzVBUUc2K3gyTng3dUhzYlVtMjlndXJmbHlP?=
 =?utf-8?B?Y0t6ZStoWHJSMW8zd2pNSmZiZGpoNGxJVGsrc1ZvSnVmUlQzK3pSd0xWdkhL?=
 =?utf-8?B?T0JzTytiS01nQktINFBoWWZOL2hreUJYbkxtbGxIVXhwUEJXeEZkRjFGRGpR?=
 =?utf-8?B?bU1DTE8yS3lRbUxST1JweXNqZ0FtVGFDdngxZnU1a1hPZ01pM0x2Z3lyaXhU?=
 =?utf-8?B?bXU5VUc5NHhhdWgvWDFMeVJVTUNGTktaelhCd0YyN1JuZ1pOWittcTMzR1BI?=
 =?utf-8?B?d1lNT1JIS0NkSGVYR0s1SURuOGlCa2JRdGI2SVpzVDhZdG52Q2ZoSCtvcHQ1?=
 =?utf-8?B?WW9oZzFBMm8rVjAyekZwWGFwOHpPaktiaHQvaVBpZVBHejRTTlRNTVF4UFB2?=
 =?utf-8?B?RmpKQnlSUnpaSUpsN3lWdHE0MUZKZDlSMU1qV0d3Y0kwTWxrZVFSZjEwQ25Q?=
 =?utf-8?B?cTY2WHlVbks0WTMxekdaSC9JWXNyOHRGaEJSZmlwaUNBK2dsc0tONS9vNHQz?=
 =?utf-8?B?Vmh0RTZ1dEVUMkVoZGdpaXgzNXVYYkI3QXRnSy9KelpicXBENEU4U2JQR2R0?=
 =?utf-8?B?Wmt5NkowU3RsNGs0Y1JYVEdEVW94VHA5TWU0R21QSmRVOU9SREhlSGxzOUxV?=
 =?utf-8?B?M2FMNVBnbE9SNC9zSWtMZXRqVUIxR3BnZmhubkNBVGo3eG9iNmNBQ0JKTHUw?=
 =?utf-8?B?MU9TdnRkMldvTVh1eSs5MldKMWJQUjRPV0luREtzT3JhSFpkOGFzZSs5UVBr?=
 =?utf-8?Q?CpP0D/wRZ2xiO3kS7UzfbkWmZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB4909.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cedb2752-1425-4cc2-53cb-08ddcf465e51
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 08:52:09.3262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDFyIiL+LLPyZ5Wmc5YhtZ+IYmftBS+G8JGnQv/wy/Zg1YxRv03iHDVafoaRqWxi9jHwmxsTKFXf/JsiiT5Lnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB5959

SGkgS3J6eXN6dG9mLA0KDQpPbiAzMC8wNy8yMDI1IDE0OjIxLCBLcnp5c3p0b2YgS296bG93c2tp
IHdyb3RlOg0KPiBOQUssIHN0b3AgcmFuZG9tIGNoYW5nZXMgdG8gY29tcGF0aWJsZXMuDQo+IA0K
PiBQbGVhc2UgcnVuIHNjcmlwdHMvY2hlY2twYXRjaC5wbCBvbiB0aGUgcGF0Y2hlcyBhbmQgZml4
IHJlcG9ydGVkIHdhcm5pbmdzLg0KPiBBZnRlciB0aGF0LCBydW4gYWxzbyAnc2NyaXB0cy9jaGVj
a3BhdGNoLnBsIC0tc3RyaWN0JyBvbiB0aGUgcGF0Y2hlcyBhbmQNCj4gKHByb2JhYmx5KSBmaXgg
bW9yZSB3YXJuaW5ncy4gU29tZSB3YXJuaW5ncyBjYW4gYmUgaWdub3JlZCwgZXNwZWNpYWxseSBm
cm9tIC0NCj4gLXN0cmljdCBydW4sIGJ1dCB0aGUgY29kZSBoZXJlIGxvb2tzIGxpa2UgaXQgbmVl
ZHMgYSBmaXguIEZlZWwgZnJlZSB0byBnZXQgaW4gdG91Y2ggaWYNCj4gdGhlIHdhcm5pbmcgaXMg
bm90IGNsZWFyLg0KPiANCj4gPGZvcm0gbGV0dGVyPg0KPiBQbGVhc2UgdXNlIHNjcmlwdHMvZ2V0
X21haW50YWluZXJzLnBsIHRvIGdldCBhIGxpc3Qgb2YgbmVjZXNzYXJ5IHBlb3BsZSBhbmQgbGlz
dHMNCj4gdG8gQ0MuIEl0IG1pZ2h0IGhhcHBlbiwgdGhhdCBjb21tYW5kIHdoZW4gcnVuIG9uIGFu
IG9sZGVyIGtlcm5lbCwgZ2l2ZXMgeW91DQo+IG91dGRhdGVkIGVudHJpZXMuIFRoZXJlZm9yZSBw
bGVhc2UgYmUgc3VyZSB5b3UgYmFzZSB5b3VyIHBhdGNoZXMgb24gcmVjZW50DQo+IExpbnV4IGtl
cm5lbC4NCj4gDQo+IFRvb2xzIGxpa2UgYjQgb3Igc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCBw
cm92aWRlIHlvdSBwcm9wZXIgbGlzdCBvZiBwZW9wbGUsIHNvDQo+IGZpeCB5b3VyIHdvcmtmbG93
LiBUb29scyBtaWdodCBhbHNvIGZhaWwgaWYgeW91IHdvcmsgb24gc29tZSBhbmNpZW50IHRyZWUN
Cj4gKGRvbid0LCBpbnN0ZWFkIHVzZSBtYWlubGluZSkgb3Igd29yayBvbiBmb3JrIG9mIGtlcm5l
bCAoZG9uJ3QsIGluc3RlYWQgdXNlDQo+IG1haW5saW5lKS4gSnVzdCB1c2UgYjQgYW5kIGV2ZXJ5
dGhpbmcgc2hvdWxkIGJlIGZpbmUsIGFsdGhvdWdoIHJlbWVtYmVyDQo+IGFib3V0IGBiNCBwcmVw
IC0tYXV0by10by1jY2AgaWYgeW91IGFkZGVkIG5ldyBwYXRjaGVzIHRvIHRoZSBwYXRjaHNldC4N
Cj4gDQo+IFlvdSBtaXNzZWQgYXQgbGVhc3QgZGV2aWNldHJlZSBsaXN0IChtYXliZSBtb3JlKSwg
c28gdGhpcyB3b24ndCBiZSB0ZXN0ZWQgYnkNCj4gYXV0b21hdGVkIHRvb2xpbmcuIFBlcmZvcm1p
bmcgcmV2aWV3IG9uIHVudGVzdGVkIGNvZGUgbWlnaHQgYmUgYSB3YXN0ZSBvZg0KPiB0aW1lLg0K
PiANCj4gUGxlYXNlIGtpbmRseSByZXNlbmQgYW5kIGluY2x1ZGUgYWxsIG5lY2Vzc2FyeSBUby9D
YyBlbnRyaWVzLg0KPiA8L2Zvcm0gbGV0dGVyPg0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4g
S3J6eXN6dG9mDQoNCkknbGwgcmUtb3JnYW5pemUgdGhlIHBhdGNoZXMgdG8gYXZvaWQgcmFuZG9t
IGNoYW5nZXMgdG8gY29tcGF0aWJsZXMgYW5kIHN1Ym1pdCBhbiB1cGRhdGVkIHZlcnNpb24uDQoN
CkJlc3QgcmVnYXJkcywNCllpeGluDQo=

