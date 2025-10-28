Return-Path: <dmaengine+bounces-7020-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A99C0C1465C
	for <lists+dmaengine@lfdr.de>; Tue, 28 Oct 2025 12:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A38B352137
	for <lists+dmaengine@lfdr.de>; Tue, 28 Oct 2025 11:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E05305948;
	Tue, 28 Oct 2025 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2qVlt33l"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C18302CB9;
	Tue, 28 Oct 2025 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651505; cv=fail; b=dTDF/K9WyBT7Gp0ZsWpSKDtxmMpJWvxX3/XTzN3M+KYR8Nx02w/pQkFabEu5rO0M2PsgKqjOsWw/jjyZJ1PGPW8/do29amIArKRq+bAZ3KXiCWcpvraSzXrSDMDK1RhuZPOO6IbZK44JmhT1kweWFVtNjP4ETrRk3XvNU8o2rSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651505; c=relaxed/simple;
	bh=HMr1xKWONxOvoIslc9JIFe8AygN338Ug3+q2gaYxOGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z26/0Z+SmKz99c0RoL3oAoc6M0wmiyULJ5pfmt9GfTa3MuATsCOIpJ0hOXvtHKxYMLCdFsafXii4Rt63o2qUEUu0E47cE3Ibj7e3OQaMQUrqaJ5R72QtYLGNxbMFG6gifthQLn5NgP2kndqQETtAnn0x+ebo2IJ8c3uBfcJ2e5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2qVlt33l; arc=fail smtp.client-ip=52.101.53.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjwEC7CHSxvH0CZFaSqtuS7msPJQoUElmbPcYmRRDAcEeQkHXp2G7hBasqsrB+8Qff/Y3+k+UF6qNXyd001qxiiRfXpyMSff9Lb0w+dnRP5JRC9U5YTTbuSue08TXXuryEyZ/QKn5dXwvo/tUsntSE9GH1IhqqE71dY3iu70cAmeGRlP2IcamsQyMwrhaANQSe3X6cg1crnNDpci+DpSVcRR/lDc8Fvfuw4H5wdXolNXGSsPm7VgVebixB1ydAnMudY2aPVfXgW/AlqIeF34/R4xzLbe+e5pXIq2bIHLWf2Ff3m9dN+5xL9VbSDiFTigzoJH2tJy92QuK8Bik3LQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMr1xKWONxOvoIslc9JIFe8AygN338Ug3+q2gaYxOGg=;
 b=BtgwubQ3LRdYNDzxggwMYRdig4qYu6bM7mktzgnAj8NTf6x2fdXnVkAbcPIJbzQ/jZdxq434Zor3hA3MYmj1qvYzQICjmHe/kyQ9D8DK/XNmXlM6GDkRAnOgs9Gu4oUTbMT5LU6Ph7XIwkpqIhUTAuJgaHmLmgZ3hNGzhTV+IG3ViEtJllonsZLCoNkJ6S8acESMVeH5FsqkoNlrC9DRNXUeBaMqGRoNyBnLwYQosBZ4deonC1BBxeD50TbZib0v+VAeazgsKz8oVXDSiE/z3GjRxCKLuQRZEaTVhNYRFYK+WSpgE4GFwHyHI4QhlE8lcpHE+lnwQBSqepIsXTOizg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMr1xKWONxOvoIslc9JIFe8AygN338Ug3+q2gaYxOGg=;
 b=2qVlt33lInfTy/VfTkKRQVHg6YSv5XrYFvHqZThGxzDYG7VBo7MsjDq7LoModc0v/92Zzfq3EFmo+5SxILqXFW+ZrqP9j4mqyCrPvznh44+i8q765fJnLKm5unAFqg63GC5HGxJYRqbSs25jBDXR+RX0CKijzcCmUls+kEfIYxs=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by CY1PR12MB9650.namprd12.prod.outlook.com (2603:10b6:930:105::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Tue, 28 Oct
 2025 11:38:20 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 11:38:20 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH RESEND v4 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH RESEND v4 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index: AQHcPQRterhw0IbdvkCPThJp/fTXvLTWDUIAgAF2JkA=
Date: Tue, 28 Oct 2025 11:38:20 +0000
Message-ID:
 <SA1PR12MB8120D254DF2ED5444F5236CB95FDA@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20251014121635.47914-1-devendra.verma@amd.com>
 <20251014121635.47914-3-devendra.verma@amd.com>
 <4rmlsvc4zffwlv6iye4sotpe3ezhblhlps6qglokrztno3wxte@tqiuci6fvcmn>
In-Reply-To: <4rmlsvc4zffwlv6iye4sotpe3ezhblhlps6qglokrztno3wxte@tqiuci6fvcmn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-28T11:33:46.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|CY1PR12MB9650:EE_
x-ms-office365-filtering-correlation-id: 256dab87-6f09-4d0e-7305-08de16167ef6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZVI3NHA2S2xyR0pXR1FKRDVvekdFREwvdDBZTVF2NnNTbVRGZ2hVRXNhUitG?=
 =?utf-8?B?d3pjYlY5NEFSbUluYTJWRVM3YXdaekN3bDBxTmY2eGlONXBtVkpqNUNoWG9L?=
 =?utf-8?B?ZXd4RWdYZTN0WEVKbDdodE9tT0lpQ2JhVHQ2Y01VdXRhdkZQUzZvUFUvdDVK?=
 =?utf-8?B?Znd4MmxNK0dSMjF2RW5adjJad016VTV1UDM5NXNWNzN4d3hPajBtQ3g0UUh6?=
 =?utf-8?B?OUZhRERic3ZydTdVS1Q0Y1Z4YlkzYThMMmxKaDhaN1F3ZVhSc3gydHlHYndG?=
 =?utf-8?B?a2xuZk5tK0RDdGJkenJ0eHZ3Kzl2b2FtOHEvWVY0UGdqNTZvK3NPNVFzNUp3?=
 =?utf-8?B?Y1hMTm9ySStPSkp4STM4U0JNQlV1V1lROFY0M0lJOHRMSGJyTzZJZWNqenUx?=
 =?utf-8?B?Qy96Z202WjIvWURUZjJpV2VjTE43Y2EzdzdnUzNGZVdJUFcyc3FzSGZPT0px?=
 =?utf-8?B?aG1aMHhWcEVnWTY0am0yOFNTeVJvSnVYL1F1S3RPV2J4NWNueGNid0ZDMDVS?=
 =?utf-8?B?QlJtbUsyRk8zNTRzQUxFOStpSmxXWHZpYVptYUVNWmZzUlRkeFZieXVNZkxH?=
 =?utf-8?B?VXJvNWl6akdieUg3aEU4dUdLd0hDZjlxSy9lblpzMlZXM2RVSHd3WVZacTJO?=
 =?utf-8?B?TElNcHJEVmVMSElQTWR2VlBXTmlKR2dGajh2WmxFektpR3lCWkVHOFV0dnFN?=
 =?utf-8?B?YUJuL1BTdkw2bk9LMy90M2RGNEtzWlg0RERPWGo2R3pNMGRaUmJocEVsMGFN?=
 =?utf-8?B?Qlg2UlBNbzN6Snp3K1VRbjFpandmQTZLdXljRS9rTW1OTGtnNllxTmdXV1dT?=
 =?utf-8?B?K1VYTzNkazJiNmFIM0ozN3habFFSdjY5QnhhUUZad2VXMnl6QXp3Rlg5MmV0?=
 =?utf-8?B?eTVXeE81ejNZdmJqVkVmNklMUXI3RlRhakp2QUZjS2ZkV1dja21kMVBPZHBs?=
 =?utf-8?B?SGpJQ3oxZTRzajY4V2RPcUJ5Q0ZDdENCY2Q0NVZJQW9xa0NGUUR2TkVKTk1n?=
 =?utf-8?B?SGVyeUJwRGZqU205SDhFZDdJY3lKWXBKTjRpSVlzKzJOVVU3TTVORGNIbmhJ?=
 =?utf-8?B?aXR0SmdHejhreDJKazBpZW9GSUxCUkwyempJRmRyMWIwWjhzU0FWN1hZdUov?=
 =?utf-8?B?dHlBcEVVMWdYdlhzaTR3TzU5K1JsYVROS0pFaTloZ1BuNThoUkpnS2NSalZm?=
 =?utf-8?B?UXZZMUx3b0xIL0NFMEF2T3RNUUlmeUZOVUVPUXl0NXcvVXVFRGtQS241ZzB2?=
 =?utf-8?B?b2VJck5vSk5HemxBTTRxYnVkeWgvRGlWUDNqSnVqNWRXZ1gvWXlXWDM4QitK?=
 =?utf-8?B?UHhmWUVnWDFtcHRpNmVkQkE0NDgzUGxqYUxUT3VCY2J5bm9Ecm1UUEc2bWlX?=
 =?utf-8?B?T3V2KzFMcDNGT2Raekp2d3EvdGlqU3RPZlROZStUcnovOXJrZ3pIRzRzVC9E?=
 =?utf-8?B?Y1YvMm1LTGVjQ0xJRmV0dVovWUw3a0RxNCtpaGRMK0lDNE41TUg5bGlvZGtW?=
 =?utf-8?B?UEd3V0h5R3BzZ1BYQnppOXZ2QjZyNW4zSmZYbHdESzhqT0ljVHovbjk2SFpY?=
 =?utf-8?B?Yy9qU0dWNytnNWVCVlFhamZjbHJ3eU9YUmRubmtMMzIzcHJtZzNYK0lydWgx?=
 =?utf-8?B?cm5VTmY2VHN6dSsvSDJUVTkvMUxkYUJmTHNLWk5BM1V5enk0VytLWGRWMXNZ?=
 =?utf-8?B?SG1mVXhyTVphSGtSV01kaHNNdWRMRm9TYVE4dWpyNVJVc2lINlMvdVZ6NmZQ?=
 =?utf-8?B?VFByOGZSeTZzcFlBQUh1a1h1MVkwWjliQVhtWlVaUExWa09MdFJqMVZRbHF0?=
 =?utf-8?B?anM3OWRGZ016KzlLTGJVQlh2ZnhaYWh6OHNYVnBWOVQ2ZW5hNmFzenR1YTZ6?=
 =?utf-8?B?ekdYeFVFUmx2MGNRM0V2T1VlVkJJWXVabUM0dGJzSjVhMEhiQjAvbnA5dnRJ?=
 =?utf-8?B?YXBQUTNBTCs2UDJyWk5aVkgzVmE3TUdMK3haL29IV3NOV0F3Y3hRcFI5OUkr?=
 =?utf-8?B?Q3hUcUxlSGFGalhiSmg2WHpFM2RHVWpSTTFaVldnVmc1WUo2QjQzQXZ1akdj?=
 =?utf-8?Q?FAIZab?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dk1wa2lsbXd2YnhLSGhYRjZZMlpxNmpTVnpsWHpmbVdGZVlEVjRvdEVPazFE?=
 =?utf-8?B?NzZjTmw3ZVFTQ0NnQ01HdlE4bG1salh1TW9RVVhXQmNjbFhlT1IxM01XVVpY?=
 =?utf-8?B?UWhscmhoN1hRLzM2aml4b2U0Z1dIclI0MmEra3BwZDYxaCtCaDlEL21kc01z?=
 =?utf-8?B?bURmUjdDbGc5c3U3SlVZbDZXSXhqZHJDU3dUeTcrUzZGeHFoaFZLN2lubmd5?=
 =?utf-8?B?K0FNNVNOZUxwQUFPRXlDeUZMeFdmclBybWtBWVNJU2FzTzhnU2wwWXlvOVJI?=
 =?utf-8?B?VHpiNW5VcUZsSCtPdDd4UUFSdlZ1cC9rdjEwRUtKOEFwMHAyZktvMzNEbElT?=
 =?utf-8?B?QUR0M1lIUGJwUmVjcUQwU3ZzVSsrUnNUZmNGaWJDRXRId2lGOUE5UDRtdVZY?=
 =?utf-8?B?QkY1Z3RRWG9FeHowWTVMa0VaS0lkcFpCb000TVp4c2s4aWx6dW1MUEJmYU84?=
 =?utf-8?B?THpWa3p2ZmloRnhCdFB2OUZvNTdOMS92K2U0SjNRazBqNG5wWUIzQUJFZ1Jp?=
 =?utf-8?B?N1hxS0RpYVlKUXNXUjMwNVAzQmtleWV4TEVnTm5CSS9uUEJiZGkzQ3BsSzZq?=
 =?utf-8?B?aFhibmxDY2tLSTdMNG1mS2hJY0NNaDFTVEJ3anVab2NWUjRvQkZyMmxOOURz?=
 =?utf-8?B?eW9NWVkzZU9JdzlGV1ZOSHJjZjh3SmVMZFNxdG5zeUQ1MjFJajRSYysyTHBM?=
 =?utf-8?B?eTFwSGlGeENBNEkwbmpWVmM4VmNpOGtNaVkzNndUYzU0VXhBaFBmVTZwRHR0?=
 =?utf-8?B?ZFBtUEYzTjFuRUQzRGo2NVhLL3c3REtZYlk0bi9nRm4xUk0rcXc4YXhnV1Jq?=
 =?utf-8?B?NTRjS2FSZmU0YnRRU1d6dWoyeTlpbmp3a2NhUkN5Z2c1c3psNThKVVNyQTN1?=
 =?utf-8?B?UDNHL1hSaURvS1FyYXpkazk2WUtYeWtCQUIvam5MTm83aGRxS0NVY3BxSGNI?=
 =?utf-8?B?amEyU25FdXlXdjZOaEhBeFlnUVc5Wmo0b1RXbUlpS1RWT2k4eWJzZE5oUWxO?=
 =?utf-8?B?bmJLbjNVMXNhNFhHSjg4a1BOM3BONTArRjM2em00Y1Q4WFduV2J5UXJGQ1pW?=
 =?utf-8?B?eXFjdm5RUjdyZ0Y5VldBdTJGb2oxSTlGNjFuSEw5SzFwUHJMM0dheks0RzdJ?=
 =?utf-8?B?ak42ZjFoYjloMnFLb3ZBeithM0Q2QWJvYjRocVRjeUZpb2x2SS9GYW1qQXNl?=
 =?utf-8?B?eTBiaXpoWkdrdkZQTDZRVU5pVFZhWk14VjZjbXQwc3BxT1YwRmQzKzZoOC9l?=
 =?utf-8?B?TWo4R0pWUXBndXFoWGtEQ0xjUFRBME1tbkFIcUxMd3RmOEZGUWNzbWRTcDlC?=
 =?utf-8?B?TXUybzdOdEJKbm5jT0o2ODN3MUtqa1E0eTlkV0g2UlBlWnpmYjNjTmdUZm9q?=
 =?utf-8?B?R0lBWTVGUVJMZkVSSngvZURyK1NHb3h5ZkJmWnZXd2tOYmhlcjVGT0VxTHNY?=
 =?utf-8?B?NGVGbXBLa3g4VDNyUGR3N1c0Z21NUS95blgwS1krTUxCNU9PNzFWNEtKRTFx?=
 =?utf-8?B?OVhJbWFVQmVkb2tvS2tHbllYWHNiSVJnQnJYUjZmWjNOUzdkdjdrZHlHRTJn?=
 =?utf-8?B?bVgxZ2FEeEVqZy9JRWYyV3B1YlAyMHVFUHBNVG9RQ0dFR2ozZzlWeVZ3dW5H?=
 =?utf-8?B?WnhUWDg3ODhuZGs0aDFrQUc1WVpRbnFScUN0ZklxSmZDV2hQTWtQVU16by8x?=
 =?utf-8?B?bjdDSWZVQkxGdTFSREV1WkdhUDlXUitxNDdFTHJPbDBLMEtjSCtFUDIyN3Iw?=
 =?utf-8?B?bEJyM2E2d1JFRjFDYUs5ZFlyYWJBcXhBWmtORDUyUlVmaGd5WjNRNE9RVEtW?=
 =?utf-8?B?cE53VHpJREFWcERYanE0SVZhQjlQK1JLdVVPa2pQUlQvNjNPRk9Wc3Fsd0Z5?=
 =?utf-8?B?S3lYZUdEdHZKaGJDcXJzSkQ1UkNIYXNqaWdmaU5UZ1lWWHhQb1VDUXRZOW96?=
 =?utf-8?B?TUxzWFU5QlFsUS9mMmtIT2drZ1ErQS8rNUZ1Z3l3amkvU1Zqd0g3TVowVWx6?=
 =?utf-8?B?Z1ZXbHB2cTJFZFlCakVoNzNHQWhkbUNtZXhlOVpLTm9PSEJBMDc1L0cxeU5i?=
 =?utf-8?B?aS9JNzJxZ1J0WHBIZDQ3MVNqMDlYbkhSb3h5SVVIQjVzaFRQamRFNjJuTmZC?=
 =?utf-8?Q?bHCM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8120.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256dab87-6f09-4d0e-7305-08de16167ef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 11:38:20.7788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ItZ84rHI0TvnxtVNpu8iUnLbQGIGSuEEh9MrKUtbNnCwrg0Js4RTqZB0vNrtq3efcgzGHa3zgeZATzi6NzHmeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9650

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KVGhhbmsgeW91IE1hbml2YW5uYW4gZm9yIHJldmlld2luZyB0aGUgcGF0Y2hlcyENClBsZWFz
ZSBjaGVjayBteSByZXNwb25zZSBpbmxpbmUuDQoNClJlZ2FyZHMsDQpEZXZlbmRyYQ0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8
bWFuaUBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMjcsIDIwMjUgNjo0NSBQ
TQ0KPiBUbzogVmVybWEsIERldmVuZHJhIDxEZXZlbmRyYS5WZXJtYUBhbWQuY29tPg0KPiBDYzog
YmhlbGdhYXNAZ29vZ2xlLmNvbTsgdmtvdWxAa2VybmVsLm9yZzsgZG1hZW5naW5lQHZnZXIua2Vy
bmVsLm9yZzsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgU2ltZWssIE1pY2hhbA0KPiA8bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggUkVTRU5EIHY0IDIvMl0gZG1hZW5naW5lOiBkdy1lZG1hOiBBZGQg
bm9uLUxMIG1vZGUNCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBh
biBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXINCj4gY2F1dGlvbiB3aGVuIG9wZW5pbmcgYXR0
YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBUdWUs
IE9jdCAxNCwgMjAyNSBhdCAwNTo0NjozNFBNICswNTMwLCBEZXZlbmRyYSBLIFZlcm1hIHdyb3Rl
Og0KPiA+IEFNRCBNREIgSVAgc3VwcG9ydHMgTGlua2VkIExpc3QgKExMKSBtb2RlIGFzIHdlbGwg
YXMgbm9uLUxMIG1vZGUuDQo+DQo+IElzbid0IHRoZSBwYXRjaCBhZGRpbmcgbm9uLUxMIG1vZGUg
Zm9yIGFsbCBwbGF0Zm9ybXMsIG5vdCBqdXN0IGZvciBBTUQ/DQo+DQoNCkEgc3BlY2lmaWMgY2Fz
ZSB3aGVyZSBMTCBtb2RlIGlzIGVuYWJsZWQsIHdoaWNoIGlzIHRoZSBkZWZhdWx0IG1vZGUsIGlu
DQp0aGlzIGNhc2UgYWxsIHRoZSBJUHMgY2FuIHN1cHBvcnQgdGhlIG5vbi1MTCBtb2RlIHByb3Zp
ZGVkIGl0IHNoYWxsIGJlDQpjb25maWd1cmVkIHZpYSB0aGUgY29uZmlnIHBhcmFtIHBlcmlwaGVy
YWxfY29uZmlnIGJ5IHRoZSBjbGllbnQuDQpUaGUgZGVmYXVsdCBjYXNlIHdoZXJlIG5vbi1MTCBt
b2RlIGlzIGVuYWJsZWQgZm9yIGFsbCB0aGUgSVBzIGlzIE5PVA0Kc3VwcG9ydGVkIGJ5IGFsbCB0
aGUgSVBzLg0KDQo+ID4gVGhlIGN1cnJlbnQgY29kZSBkb2VzIG5vdCBoYXZlIHRoZSBtZWNoYW5p
c21zIHRvIGVuYWJsZSB0aGUgRE1BDQo+ID4gdHJhbnNhY3Rpb25zIHVzaW5nIHRoZSBub24tTEwg
bW9kZS4gVGhlIGZvbGxvd2luZyB0d28gY2FzZXMgYXJlIGFkZGVkDQo+ID4gd2l0aCB0aGlzIHBh
dGNoOg0KPiA+IC0gV2hlbiBhIHZhbGlkIHBoeXNpY2FsIGJhc2UgYWRkcmVzcyBpcyBub3QgY29u
ZmlndXJlZCB2aWEgdGhlDQo+ID4gICBYaWxpbnggVlNFQyBjYXBhYmlsaXR5IHRoZW4gdGhlIElQ
IGNhbiBzdGlsbCBiZSB1c2VkIGluIG5vbi1MTA0KPiA+ICAgbW9kZS4gVGhlIGRlZmF1bHQgbW9k
ZSBmb3IgYWxsIHRoZSBETUEgdHJhbnNhY3Rpb25zIGFuZCBmb3IgYWxsDQo+ID4gICB0aGUgRE1B
IGNoYW5uZWxzIHRoZW4gaXMgbm9uLUxMIG1vZGUuDQo+ID4gLSBXaGVuIGEgdmFsaWQgcGh5c2lj
YWwgYmFzZSBhZGRyZXNzIGlzIGNvbmZpZ3VyZWQgYnV0IHRoZSBjbGllbnQNCj4gPiAgIHdhbnRz
IHRvIHVzZSB0aGUgbm9uLUxMIG1vZGUgZm9yIERNQSB0cmFuc2FjdGlvbnMgdGhlbiBhbHNvIHRo
ZQ0KPiA+ICAgZmxleGliaWxpdHkgaXMgcHJvdmlkZWQgdmlhIHRoZSBwZXJpcGhlcmFsX2NvbmZp
ZyBzdHJ1Y3QgbWVtYmVyIG9mDQo+ID4gICBkbWFfc2xhdmVfY29uZmlnLiBJbiB0aGlzIGNhc2Ug
dGhlIGNoYW5uZWxzIGNhbiBiZSBpbmRpdmlkdWFsbHkNCj4gPiAgIGNvbmZpZ3VyZWQgaW4gbm9u
LUxMIG1vZGUuIFRoaXMgdXNlIGNhc2UgaXMgZGVzaXJhYmxlIGZvciBzaW5nbGUNCj4gPiAgIERN
QSB0cmFuc2ZlciBvZiBhIGNodW5rLCB0aGlzIHNhdmVzIHRoZSBlZmZvcnQgb2YgcHJlcGFyaW5n
IHRoZQ0KPiA+ICAgTGluayBMaXN0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGV2ZW5kcmEg
SyBWZXJtYSA8ZGV2ZW5kcmEudmVybWFAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGlu
IHY0DQo+ID4gICBObyBjaGFuZ2UNCj4gPg0KPiA+IENoYW5nZXMgaW4gdjMNCj4gPiAgIE5vIGNo
YW5nZQ0KPiA+DQo+ID4gQ2hhbmdlcyBpbiB2Mg0KPiA+ICAgUmV2ZXJ0ZWQgdGhlIGZ1bmN0aW9u
IHJldHVybiB0eXBlIHRvIHU2NCBmb3INCj4gPiAgIGR3X2VkbWFfZ2V0X3BoeXNfYWRkcigpLg0K
PiA+DQo+ID4gQ2hhbmdlcyBpbiB2MQ0KPiA+ICAgQ2hhbmdlZCB0aGUgZnVuY3Rpb24gcmV0dXJu
IHR5cGUgZm9yIGR3X2VkbWFfZ2V0X3BoeXNfYWRkcigpLg0KPiA+ICAgQ29ycmVjdGVkIHRoZSB0
eXBvIHJhaXNlZCBpbiByZXZpZXcuDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZG1hL2R3LWVkbWEv
ZHctZWRtYS1jb3JlLmMgICAgfCAzOCArKysrKysrKysrKysrKysrKystLS0NCj4gPiAgZHJpdmVy
cy9kbWEvZHctZWRtYS9kdy1lZG1hLWNvcmUuaCAgICB8ICAxICsNCj4gPiAgZHJpdmVycy9kbWEv
ZHctZWRtYS9kdy1lZG1hLXBjaWUuYyAgICB8IDQ0ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0N
Cj4gPiAgZHJpdmVycy9kbWEvZHctZWRtYS9kdy1oZG1hLXYwLWNvcmUuYyB8IDYyDQo+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gIGluY2x1ZGUvbGludXgvZG1hL2Vk
bWEuaCAgICAgICAgICAgICAgfCAgMSArDQo+ID4gIDUgZmlsZXMgY2hhbmdlZCwgMTI3IGluc2Vy
dGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
ZG1hL2R3LWVkbWEvZHctZWRtYS1jb3JlLmMNCj4gPiBiL2RyaXZlcnMvZG1hL2R3LWVkbWEvZHct
ZWRtYS1jb3JlLmMNCj4gPiBpbmRleCBiNDMyNTVmLi4zMjgzYWM1IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvZG1hL2R3LWVkbWEvZHctZWRtYS1jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL2Rt
YS9kdy1lZG1hL2R3LWVkbWEtY29yZS5jDQo+ID4gQEAgLTIyMyw4ICsyMjMsMjggQEAgc3RhdGlj
IGludCBkd19lZG1hX2RldmljZV9jb25maWcoc3RydWN0DQo+IGRtYV9jaGFuICpkY2hhbiwNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRtYV9zbGF2ZV9jb25maWcg
KmNvbmZpZykgIHsNCj4gPiAgICAgICBzdHJ1Y3QgZHdfZWRtYV9jaGFuICpjaGFuID0gZGNoYW4y
ZHdfZWRtYV9jaGFuKGRjaGFuKTsNCj4gPiArICAgICBpbnQgbm9sbHAgPSAwOw0KPg0KPiBzL25v
bGxwL25vbl9sbA0KPg0KDQpTdWdnZXN0aW9uIGFjY2VwdGVkLiBUaGFua3MhDQoNCj4gPiArDQo+
ID4gKyAgICAgaWYgKFdBUk5fT04oY29uZmlnLT5wZXJpcGhlcmFsX2NvbmZpZyAmJg0KPiA+ICsg
ICAgICAgICAgICAgICAgIGNvbmZpZy0+cGVyaXBoZXJhbF9zaXplICE9IHNpemVvZihpbnQpKSkN
Cj4NCj4gVXNlIHByb3BlciBkZXZfZXJyKCksIG5vdCBXQVJOX09OLg0KPg0KDQpTdWdnZXN0aW9u
IGFjY2VwdGVkLCBkZXZfZXJyKCkgcmVwbGFjZXMgV0FSTl9PTigpIGluIGxhdGVzdCBkcm9wLg0K
VGhhbmtzIQ0KDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPg0KPiA+ICAg
ICAgIG1lbWNweSgmY2hhbi0+Y29uZmlnLCBjb25maWcsIHNpemVvZigqY29uZmlnKSk7DQo+ID4g
Kw0KPiA+ICsgICAgIC8qDQo+ID4gKyAgICAgICogV2hlbiB0aGVyZSBpcyBubyB2YWxpZCBMTFAg
YmFzZSBhZGRyZXNzIGF2YWlsYWJsZQ0KPiA+ICsgICAgICAqIHRoZW4gdGhlIGRlZmF1bHQgRE1B
IG9wcyB3aWxsIHVzZSB0aGUgbm9uLUxMIG1vZGUuDQo+ID4gKyAgICAgICogQ2FzZXMgd2hlcmUg
TEwgbW9kZSBpcyBlbmFibGVkIGFuZCBjbGllbnQgd2FudHMNCj4gPiArICAgICAgKiB0byB1c2Ug
dGhlIG5vbi1MTCBtb2RlIHRoZW4gYWxzbyBjbGllbnQgY2FuIGRvDQo+ID4gKyAgICAgICogc28g
dmlhIHByb3ZpZGluZyB0aGUgcGVyaXBoZXJhbF9jb25maWcgcGFyYW0uDQo+DQo+IE1ha2UgdXNl
IG9mIDgwIGNvbHVtbnMgZm9yIGNvbW1lbnRzIHRocm91Z2hvdXQgdGhpcyBwYXRjaC4NCj4NCg0K
Q29tbWVudHMgZm9sbG93IHRoZSA4MC1jb2x1bW4gZ3VpZGVsaW5lLiBUaGFua3MhDQoNCj4gUmVz
dCBMR1RNIQ0KPg0KPiAtIE1hbmkNCj4NCj4gLS0NCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p
4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0K

