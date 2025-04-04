Return-Path: <dmaengine+bounces-4833-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C37A7C686
	for <lists+dmaengine@lfdr.de>; Sat,  5 Apr 2025 01:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586DD3B5491
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 23:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56BD1C84A3;
	Fri,  4 Apr 2025 23:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Legrand.com header.i=@Legrand.com header.b="Flnj1/Mg"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013071.outbound.protection.outlook.com [52.101.67.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1E15990C;
	Fri,  4 Apr 2025 23:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743807932; cv=fail; b=YM3wj72EPVjM7uma7Cz4y61eqEs8g34eE6Bz8nt+Xdg/MXziMWyZrdbsgdgUPH70vIm0SMG7Pz9jOWU1f2PkFsRpllwJKKLGmCNS5ZpII7h0IpGU6SYuzdRNDn++NWBja21c3FXyqv3UeQ+bEqzLofioCx38GHVYGnX13lr1QgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743807932; c=relaxed/simple;
	bh=yJZ50uv00+cj/aKBecrhku/AEfJNeBPwF7EWAwOBlGg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U1bYnJpHpLZGIDqA/JR38GePDo+Df7SDtlmtTpRxgq1zVJgVWb6kRWmDdh5S9/qNqmqcjCQqCQ77CZXjljSSTZ/IH14IBQEMxeoy+4eAZlI5cGEuHYEpKagQcJvUx7jy5AmCJLSVD0n8f+IDIah668SteLDZ7jL7sFVl/TYgzb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=legrand.com; spf=pass smtp.mailfrom=legrand.com; dkim=pass (1024-bit key) header.d=Legrand.com header.i=@Legrand.com header.b=Flnj1/Mg; arc=fail smtp.client-ip=52.101.67.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=legrand.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=legrand.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSl9ECovB8dNOWTCYsFBVlYDABqW8r70dPfUuXL45jJadK7yCUDRHC05TDZh3tQg7knb8DZdniMKv3KQzAZXByZDses+SmenNPSYjKPP7Z+O9Krob37vep21kvxbTe7AtaPA7mrAAB2XjLlCifXWJzj25QhwRMe9E3KUH9pdxYJTotH8CZNS4Opsjffj3iirJOuIewZK+73+vYevHplz6lJwTrOkhRz5J56rVhq+05uTGmePwYhNbly0w1v80F034h5d+1taoi4Mg+lAjX0bSKVemPo6fyCTbgFWffRwhaqUHSc4SZUHAuFSehOWIOO8OS/bcJJfWKbLvyBv7b+LZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wyeHWG0lr/hVN5dLabdGgZnsHK1uZ5NQXmdqS340+I=;
 b=RRp0ojsxPYUPOZpGA7JMcGMNALbpT7hRMSXJcFTevhV1bCyVoVOUu+ulMhsJRPztk9mhkKOM8eaA787JmXaVaso6vwOA0+lZYYIxPloF40XUw8ZKX2AhD4Ary7BiEmq8R/EJl7OCa6xtoatl+EULT0y+QCSFw7a8aHwPlNe1/t1t9kGLDMBawqxu7+R9W9yGHUDJu+Hh8J1jOd1iPGgc/1MbnWPzWhcXSulJdCXoHF23JlNYwFt44fHIXF/TE2cM7lBOVq1feVKghcflCxJ4XSqJaDE3tTa1K4ws9JEC2eGCRQc5Wsq2leqzpYRSxrv00sfWWImr5Xe9zsTih70A1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=legrand.com; dmarc=pass action=none header.from=legrand.com;
 dkim=pass header.d=legrand.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Legrand.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wyeHWG0lr/hVN5dLabdGgZnsHK1uZ5NQXmdqS340+I=;
 b=Flnj1/Mgu2esrhpxvdmIZM+KA9pjDjOcWmN5atQiqm4fGlJ2t1jsHsdRNGNkip1zVUBfYkE2qKmkmv2Is5ifxuPNxP7ICg2fuy3qCq23T68INBfJqQTNq/Tt7efwz9njPJuvMpEN/UPNW2XkplSUWNKFHgl7V9U5xe3p5c62iDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=legrand.com;
Received: from DUZPR06MB9057.eurprd06.prod.outlook.com (2603:10a6:10:4b2::18)
 by AM0PR06MB6561.eurprd06.prod.outlook.com (2603:10a6:208:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.46; Fri, 4 Apr
 2025 23:05:23 +0000
Received: from DUZPR06MB9057.eurprd06.prod.outlook.com
 ([fe80::7883:195d:c189:373b]) by DUZPR06MB9057.eurprd06.prod.outlook.com
 ([fe80::7883:195d:c189:373b%4]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 23:05:23 +0000
Message-ID: <11767500-9705-4bc2-9ae2-cbbd60b5ece8@legrand.com>
Date: Sat, 5 Apr 2025 01:05:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Add missing locking
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
 Ronald Wahl <rwahl@gmx.de>, linux-kernel@vger.kernel.org
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, stable@vger.kernel.org
References: <20250120144131.792609-1-rwahl@gmx.de>
 <dc9b9b53-dbca-49f5-a7e6-3a6a3112f1bb@gmail.com>
Content-Language: en-US
From: Ronald Wahl <ronald.wahl@legrand.com>
In-Reply-To: <dc9b9b53-dbca-49f5-a7e6-3a6a3112f1bb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::20) To DUZPR06MB9057.eurprd06.prod.outlook.com
 (2603:10a6:10:4b2::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DUZPR06MB9057:EE_|AM0PR06MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: b7aeda1d-d07d-48a4-b374-08dd73cd2df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnBsRW5xL2t5ZmxQQ0JIMCs1eXBzMWs1K1pDWHR0ZFlWSTdjcnZhODExU0I5?=
 =?utf-8?B?VTZiRkc0MmdqWWVrcGZVZy9sR2FhamNUeERJeGpaYnoxek5LZnpWckVCblo0?=
 =?utf-8?B?MWhvYVdLOUUwenBiOC85QWEzQkxETEtOLzYwcCtHekd4TzBsVlFlTU1JczhO?=
 =?utf-8?B?bjcyemI2MzNvN1l0QStkbGNYdHJxNDJJQ1BoRWRrdGt4bjVycnpQSFM3ekNR?=
 =?utf-8?B?K2h0WENXVFlJQ05SMFlPRmVVZjdvZnJUWFp6eUJpcnRsR1ZSbzg4cnpkNlhD?=
 =?utf-8?B?ejM5WHBKWlRMTTJkcHRzMU5zZldLM3NHbVFWNnlHdlY5SGhENTZOYU9DemFU?=
 =?utf-8?B?d3BYUU4zRlJHQWRQOXF4M2NuSXJWcktqWVZYcWRrVDlQUytWTitaUWJDTXBG?=
 =?utf-8?B?SWYvOXdlbHJxV01wN2t5S2F2RVVvTGJBWnlkdjdhcVM1VHdvdU9Ja3BhYnM2?=
 =?utf-8?B?UndmSGVXS3JUaG1zR2c4YTQ3M2twS0RPRWxjaURJdTRxRGpIMjlWT0pkSGY3?=
 =?utf-8?B?NTBpd0o3Z1NZZWY0NlhhNnFjNWxrK3JHQ3BsaC96TWlMQjI5ZlEwdW12N01P?=
 =?utf-8?B?MWk4VFRPbmlPdUVSemtMSXNMSmZLUFE0NDFYMk9lcFpXWTNlQjZ0RENLOTl3?=
 =?utf-8?B?ZG5Bcnp4UGh1VDk0ZnNXRnBqSUd1aENJV3NVTFMycW9EMHRpTGhua2xDWThK?=
 =?utf-8?B?b2lZTEo3RkVHNkgxQ1ZkRUZtWm1INUVNeU9TZ0xkbGlnUENiM3ovZ2NySTNk?=
 =?utf-8?B?bkRONmRoajA2cnYzZ1lSUndaaXE5VGgrYlROK0tocXJ1UkI1ZlJzaGppN25n?=
 =?utf-8?B?MFNCRGJmK3dGejYzSG9Lcm9XSitxWTZZSUwrWExSZW15Y0J4NkY4OHlsRUt4?=
 =?utf-8?B?OWovR1k2b2VXZStIMXdEbHhSQlh6RkVpT21lUFJHSUdFMmVmZUdaRFR6V0My?=
 =?utf-8?B?S0NBVDNYdFdjYTNlZVhEL1JRaENrUW4wU1NmdFVocHppU0NYUitzOTljZkEx?=
 =?utf-8?B?dlpzSVpzakdDY0oyeVBGcWltcU1XZlFFckJZWkFLSTh6TmFGQXdaYXpyY2JG?=
 =?utf-8?B?V2kzeVF1cUFjNUs3V1JHM0dKSWhkWUdoVmdBeFRjc3A4TTdTU2RZR01oaHRm?=
 =?utf-8?B?YlQzQlJpN2lIejkxT1VvQXRmOFcyUmpNZzdueHJMblQvUXJXcm9HREI3Nndv?=
 =?utf-8?B?SnNxUWVjR3JCazFueTJ5VkRrdkMzMkozYXB0LytPanFQQmRQamM4alY5R1JO?=
 =?utf-8?B?U2s1RG1uUEtzdWRxTXVjTm5ZZlVnMUNQclZvUVVMV01SeGVYOVl4a1NaUFZk?=
 =?utf-8?B?SlhkaTlLcjBjdldJTkdBWkVSVGltdnE0dFVpajBuZWN6cTBPZUYvTy9RRHpV?=
 =?utf-8?B?WmNlWkFQOVZuOWpFNDM2NHlzdmhUOVB4M0g4ekxYMytSQ3ZMWVZMdGs4RG1D?=
 =?utf-8?B?dk1Cdy9BMjhxMHpFTys2enJhQU0wUytWN2dGSzd6c1I5eGFUdXhiSG5IZGwr?=
 =?utf-8?B?dTJSM2FIWHhReWk5M1lYODB5M1lGaWNsajVXa2pKc2hjNTZZWkczZExDSHVk?=
 =?utf-8?B?Mi9pOXRWWkhoTGNGMkZsc1p0WGhMV0tnQXU1TENJRUl1eVdLbkw3eU1ZYmxN?=
 =?utf-8?B?L1FJbElPVHl2TW9JK1FaVnhUc0F4U05MTVc1MllnMzk5Z1NCNzdwdU43M1BO?=
 =?utf-8?B?Wlp2a3o5VGpRM2l5Q1ZXZU05TG9PZ25aMFhIdDZWdVE2VVFBcm1QcDFHdkxp?=
 =?utf-8?B?VnQ0WTcybk9mMXlkM3I5QTJibmgzaThSMTlRaTIrc1pZMko3Sm13NXZ0L1hY?=
 =?utf-8?B?cmJDeURNa281Sk9NcnhoTHUvVTZjNGJOVTZQNGZUdWx5b3FhYUpqd1I0TUtJ?=
 =?utf-8?Q?YzRlmfk27paf0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DUZPR06MB9057.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTFpQzFFckFrQnFFd2ZWR2lhaTR3Ny9XL2RwRDQ3OERRWE5MU0NhZ2pBRk1a?=
 =?utf-8?B?R0VrSTU2dmk2cUpPd0YzQnY3ZlRDbXIrVmd4cGtBeVBWSEtWL1VjbUUyK3Z1?=
 =?utf-8?B?bkg0QmZPQVpvL0p1UGFiSlh2ajRxWWpVb21QaU5SeGJsL29mandZZ0dnbEtQ?=
 =?utf-8?B?OTVXd2IwUEFYTnA5dEhSdE9WNDllVTRteW1VOUZQMjRaclBDYVAzSkV6UmZl?=
 =?utf-8?B?RmZ3YkhkNUg5WE14Q0NrV1RjUlZ0c0pJRlZINzd0cytCbkdLY1p2TW9zcGdW?=
 =?utf-8?B?V0I4SDVXcEpQcVQ2SXU3b3dCUkpCZXFqMzZYT3NzUjl6SjJLTnY3d1BHaUt1?=
 =?utf-8?B?SWxucDVKcTE4a0NURlRhajdtWFdGb20zOFVVWnBjUnpGbHVIdEdSNHVLekJJ?=
 =?utf-8?B?Rk4yS05WU2RHMHBaNXZ3NWZEaWg4a2cvbG5UU2xjRlhzbzVIUFNTNFJpWjQv?=
 =?utf-8?B?OVJzYVByN3FLRXNLT09lRGxrYUk2TjAyWmVwRTQ3dnljQnozbWdKcEhkMGVs?=
 =?utf-8?B?UjJYN2ZVTDhYaGlFa2RMK0hra2cwaDVVWE80OUg2WnlmemRhb0hoa3FoaEpv?=
 =?utf-8?B?Zy81WTF2KzI4TTdydTF4YmdTQ3hjVjVKcnU1VGsxMWY0a1ZPNkM0UHR2dm5Y?=
 =?utf-8?B?R0pkZE9pL3JMaGViTStjd1BuUUE3MXY1bXRLVVU3TkRCNi9SZTlPejJrT01Q?=
 =?utf-8?B?d0dGUGJ4M1hSM2NjNUpqVHhabWh6bUdqMXQ2WjY3S3FyNUV5WmsvVDlSRk5v?=
 =?utf-8?B?YXNtNC9zNjcyVU1hbVI1TVc3WHRZQnFPcTFyK0FMZi9xMDVxVnFYSkwxaHl2?=
 =?utf-8?B?SE90NlQzM3ByNGZvN3ZXdmZYTkh6M3B6dmhyRlRsbzduREljVmY0R1FoVUlM?=
 =?utf-8?B?Mm1PQ2tZZ2pPSTMxVlo0dTBFaFFjS3NVWm9veGtsZG5jU0F3YzhzNE5ib1dz?=
 =?utf-8?B?aEpXOXBueGIwUGtYMjljaWpuRThRdTc4T0tlcVRWRXp6SkNFeXRQcUE3dlZq?=
 =?utf-8?B?cWZ3N1poM3B6NW9YWm1JQzNINWpJc1dXZU04MkNHWnZva3hsa3NpZ2E5K3Ns?=
 =?utf-8?B?N1dHYzJFNlc3bmgyYU5rSkFZVTdCSklsTG1ybFBXRmxRTGZDS1o5czNzSG9S?=
 =?utf-8?B?Yzdvb3R6K1hqZUFuNVVQakpONGpOQ2ZCWGgyTndic0hVbms3TkJ6bnVXaVhC?=
 =?utf-8?B?RnJ5OXM4S1d4TkpjNUpKQXNwOFhudk4vYlZCSm5LWWdVRjZTbFgyd1hIR1BJ?=
 =?utf-8?B?YVh5aW54a3BoWXZsWGRFb2Jmd3p6NUZPelE3bjBuVVpxVjl3THBGdnFjeWlm?=
 =?utf-8?B?akxhUEVob2xJWjAvNU44cmJVRW9CUnBidFk4dkV3aHpQaThPTXl2YjdsNkFQ?=
 =?utf-8?B?U2dJTVgrWUt5bHRxcHVPbGFoL2xZK1lqSnE0VlMwaUNPNUpLK2l6YmhWOXVF?=
 =?utf-8?B?SkFqUk5mNklwYWJBMzJCb2dpZVJnUzdJcUhkZzd0dEx0c3hYWElLdjRmSG9x?=
 =?utf-8?B?Q2pVdGROQXBjeWZucDRQWWRIQmlva3p1aFloV0xERWs0YWlmRWhLaWJhcXBQ?=
 =?utf-8?B?Z3FDT2ZHcVpybVI1bEpRd2NJN2ZUUTVzckZHUHJPSUhZb0g5Q25rOXQvaG4x?=
 =?utf-8?B?U3RvbmxtYklEOVorM2pPR2xDRXRqWXA1WnV3alV2Umt5cVFkdk11TXRzWDNZ?=
 =?utf-8?B?aUcyZjRBTjNQanBtckczaVAvVW1XR1RCMFVBb2srUDhzcmNOSjJyWldkaUJt?=
 =?utf-8?B?NVhzSGx0V0UrZm1nWXVkNFFCQzN3bXQwQTRDLzJUSnowQ0s5UDhxSFBDWHNG?=
 =?utf-8?B?eU1zT1ZJTG9CRktGRklnTTdtOTVHQ1RiSGpEdis3TWg0cXdKQzVZSWd6ZGlh?=
 =?utf-8?B?T24zR0VVNGp6R0R5cGVyMm1EdFNKdWNVWnBWYit1Ymg4R1diYWFQSncyb1VS?=
 =?utf-8?B?dTg1TFByWEJyZ2VrMkVtL1JyZkJBS3V1SVE1L3c5WnBMRUM5SXNReHd3Z1M4?=
 =?utf-8?B?WVJvY2lIWWNWTE1tdGJJMCtta3FzS0xNL25zSjNGY1JhNDJwMmNzRlFGdVp4?=
 =?utf-8?B?NFFzZGlnRit0MU1RLzB0OWR2T0tGaUFIUmN4eUxsb21NYTRJMWhlbitmNTlr?=
 =?utf-8?B?cVN4OW8yNldrT3Vkb1owcW80bysxR0Y5UGpTR1JlVGJqM1JLMTRVcUFPNnA2?=
 =?utf-8?B?R2c9PQ==?=
X-OriginatorOrg: Legrand.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7aeda1d-d07d-48a4-b374-08dd73cd2df9
X-MS-Exchange-CrossTenant-AuthSource: DUZPR06MB9057.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 23:05:23.5391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uF7+7VY5+QgXh0B3go3+2tRAq4TrgpJY7Wu7Fa5k1llyYroRu8eCtxcGjIYGTMk2AsHPH8E5qNTfT0QO0x/lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6561

Hi,

I would like to see this patch being merged. Is there something missing
or why is it still pending?

- ron

On 22.01.25 16:22, P=C3=A9ter Ujfalusi wrote:
>
>
> On 20/01/2025 16:41, Ronald Wahl wrote:
>> From: Ronald Wahl <ronald.wahl@legrand.com>
>>
>> Recent kernels complain about a missing lock in k3-udma.c when the lock
>> validator is enabled:
>>
>> [    4.128073] WARNING: CPU: 0 PID: 746 at drivers/dma/ti/../virt-dma.h:=
169 udma_start.isra.0+0x34/0x238
>> [    4.137352] CPU: 0 UID: 0 PID: 746 Comm: kworker/0:3 Not tainted 6.12=
.9-arm64 #28
>> [    4.144867] Hardware name: pp-v12 (DT)
>> [    4.148648] Workqueue: events udma_check_tx_completion
>> [    4.153841] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTY=
PE=3D--)
>> [    4.160834] pc : udma_start.isra.0+0x34/0x238
>> [    4.165227] lr : udma_start.isra.0+0x30/0x238
>> [    4.169618] sp : ffffffc083cabcf0
>> [    4.172963] x29: ffffffc083cabcf0 x28: 0000000000000000 x27: ffffff80=
0001b005
>> [    4.180167] x26: ffffffc0812f0000 x25: 0000000000000000 x24: 00000000=
00000000
>> [    4.187370] x23: 0000000000000001 x22: 00000000e21eabe9 x21: ffffff80=
00fa0670
>> [    4.194571] x20: ffffff8001b6bf00 x19: ffffff8000fa0430 x18: ffffffc0=
83b95030
>> [    4.201773] x17: 0000000000000000 x16: 00000000f0000000 x15: 00000000=
00000048
>> [    4.208976] x14: 0000000000000048 x13: 0000000000000000 x12: 00000000=
00000001
>> [    4.216179] x11: ffffffc08151a240 x10: 0000000000003ea1 x9 : ffffffc0=
8046ab68
>> [    4.223381] x8 : ffffffc083cabac0 x7 : ffffffc081df3718 x6 : 00000000=
00029fc8
>> [    4.230583] x5 : ffffffc0817ee6d8 x4 : 0000000000000bc0 x3 : 00000000=
00000000
>> [    4.237784] x2 : 0000000000000000 x1 : 00000000001fffff x0 : 00000000=
00000000
>> [    4.244986] Call trace:
>> [    4.247463]  udma_start.isra.0+0x34/0x238
>> [    4.251509]  udma_check_tx_completion+0xd0/0xdc
>> [    4.256076]  process_one_work+0x244/0x3fc
>> [    4.260129]  process_scheduled_works+0x6c/0x74
>> [    4.264610]  worker_thread+0x150/0x1dc
>> [    4.268398]  kthread+0xd8/0xe8
>> [    4.271492]  ret_from_fork+0x10/0x20
>> [    4.275107] irq event stamp: 220
>> [    4.278363] hardirqs last  enabled at (219): [<ffffffc080a27c7c>] _ra=
w_spin_unlock_irq+0x38/0x50
>> [    4.287183] hardirqs last disabled at (220): [<ffffffc080a1c154>] el1=
_dbg+0x24/0x50
>> [    4.294879] softirqs last  enabled at (182): [<ffffffc080037e68>] han=
dle_softirqs+0x1c0/0x3cc
>> [    4.303437] softirqs last disabled at (177): [<ffffffc080010170>] __d=
o_softirq+0x1c/0x28
>> [    4.311559] ---[ end trace 0000000000000000 ]---
>>
>> This commit adds the missing locking.
>
> Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
>
>>
>> Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
>> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
>> Cc: Vignesh Raghavendra <vigneshr@ti.com>
>> Cc: Vinod Koul <vkoul@kernel.org>
>> Cc: dmaengine@vger.kernel.org
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ronald Wahl <ronald.wahl@legrand.com>
>> ---
>>   drivers/dma/ti/k3-udma.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index b3f27b3f9209..b9e497e8134b 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -1091,8 +1091,11 @@ static void udma_check_tx_completion(struct work_=
struct *work)
>>      u32 residue_diff;
>>      ktime_t time_diff;
>>      unsigned long delay;
>> +    unsigned long flags;
>>
>>      while (1) {
>> +            spin_lock_irqsave(&uc->vc.lock, flags);
>> +
>>              if (uc->desc) {
>>                      /* Get previous residue and time stamp */
>>                      residue_diff =3D uc->tx_drain.residue;
>> @@ -1127,6 +1130,8 @@ static void udma_check_tx_completion(struct work_s=
truct *work)
>>                              break;
>>                      }
>>
>> +                    spin_unlock_irqrestore(&uc->vc.lock, flags);
>> +
>>                      usleep_range(ktime_to_us(delay),
>>                                   ktime_to_us(delay) + 10);
>>                      continue;
>> @@ -1143,6 +1148,8 @@ static void udma_check_tx_completion(struct work_s=
truct *work)
>>
>>              break;
>>      }
>> +
>> +    spin_unlock_irqrestore(&uc->vc.lock, flags);
>>   }
>>
>>   static irqreturn_t udma_ring_irq_handler(int irq, void *data)
>> --
>> 2.48.0
>>
>


________________________________

Ce message, ainsi que tous les fichiers joints =C3=A0 ce message, peuvent c=
ontenir des informations sensibles et/ ou confidentielles ne devant pas =C3=
=AAtre divulgu=C3=A9es. Si vous n'=C3=AAtes pas le destinataire de ce messa=
ge (ou que vous recevez ce message par erreur), nous vous remercions de le =
notifier imm=C3=A9diatement =C3=A0 son exp=C3=A9diteur, et de d=C3=A9truire=
 ce message. Toute copie, divulgation, modification, utilisation ou diffusi=
on, non autoris=C3=A9e, directe ou indirecte, de tout ou partie de ce messa=
ge, est strictement interdite.


This e-mail, and any document attached hereby, may contain confidential and=
/or privileged information. If you are not the intended recipient (or have =
received this e-mail in error) please notify the sender immediately and des=
troy this e-mail. Any unauthorized, direct or indirect, copying, disclosure=
, distribution or other use of the material or parts thereof is strictly fo=
rbidden.

