Return-Path: <dmaengine+bounces-7551-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0190BCB29B2
	for <lists+dmaengine@lfdr.de>; Wed, 10 Dec 2025 10:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC7AA3025F82
	for <lists+dmaengine@lfdr.de>; Wed, 10 Dec 2025 09:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBDC2D97AF;
	Wed, 10 Dec 2025 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C5EWQnsW"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553E62264C7;
	Wed, 10 Dec 2025 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765360467; cv=fail; b=llsXF8mIrpVoZkFdjYc3VIx7M8DrISQglnmQ0KUuptaPn/dvTOBM4UdG0573DpS8a5/xbPKyPNJhRTru24/dgg8+CZA1B6JdU4TZgwZVPWLryPRF7ttBZDPHcfOVem0LNoQad9KY/e/Ju2TmzKfgdKE2mAOH8a52opjxTCrs2cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765360467; c=relaxed/simple;
	bh=SItSbg6U0rVBJBXciVbrNpn/B+IbweB/PZQEqyJ0DcA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hpm8bK44jLdfhRLriq++GeWXdgFdcV2Spb1v78fkvKY+NlwvP1xoWPTLo3lvFtPOc+oIFAPe6ZV5Ab6RoZf4P4D3qBs8eZ37stlbTJu9I5tv689McBGLulJMFYrsWEO2P0m/HqKvFRFhGJADaAZ9/Mi6nnjr499zKQBDRHOY+nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C5EWQnsW; arc=fail smtp.client-ip=52.101.62.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAoUYqZrQ13Himamt1U7Zs20VttzwZxVXoUUb/6PcYkkZ+elkFKETYceCmYYz5eshZPbAjc259m7R28vEGULjGow7Eu6QqxHvMP0eOnkhGhLz0CbkL+21c/PNJr6jw/aRbGE2Tz+ciQ7PCT8tC1EssfPWqPQ7bTTlyuDbZFHkTxtZF/liT1nZT8wDCwsTTFNFBo6qrIM+SD0V3Gcy1SWSBHmWZo6uExJT42lf9C8KKeWoA9Yhfclw7fhRqFuMwu4V0iakhyiDfr79tuVdSbIti2Siw0F6D+8ojcy77GgmRC1pWmYJWS/pXKGsCu9jg7MPzWgosWLCPML6/jUUbaufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SItSbg6U0rVBJBXciVbrNpn/B+IbweB/PZQEqyJ0DcA=;
 b=j3LSVio6/Xdp9pf0jNiKNVhscdOGMqdDOasy7+IyPkkHgmnp5Pm+3hO1yKogRCeO5fCSFNEFbHLqs/0KydugSUDsDePTTQZzwoOPwe9jsI538SkxGh7ZiPZGPnGlm9zSSW/vzYRR0ZVFDsajhpOQ6F5zUMjXOtPWYigdxLPjwa9ZX3LYQqxHVp/xuKPU2EO13+104i4vtsSbHGiN3VmG7oF5HbrcyFN6GD2mIt1afnOHpWHvbsXsgpXJ51dAJpy3JeK/FjflfVfK+XUAdoQEHsSU+bag2ByUkBI1QcARa/MjQhGDdd09Ku9kut50AlL5+YCp8YfEk+Zh1e52AXNIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SItSbg6U0rVBJBXciVbrNpn/B+IbweB/PZQEqyJ0DcA=;
 b=C5EWQnsW8an6nHgihuQMEk7EXwiM+Fez4jF+4T7d4F8aB2yif+ITCuPl2xANJ9hTzEvlYYLQBYn5O2Y8NHfOnKpciczALoYcbgXQjpUFkZCc09AO1NfAS/tXiJ8Pcnd017SBkieN5QLVURH9JOw53sAjCA2VLmsQ/r2v0uXvM0c=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 09:54:21 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 09:54:21 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH RESEND v6 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH RESEND v6 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index: AQHcWtrmrcKa8eMzNE+aeiu6TdWOX7UMnEUQgAMbOYCACwByQA==
Date: Wed, 10 Dec 2025 09:54:21 +0000
Message-ID:
 <SA1PR12MB8120DCFD29F07EA6E00EF72695A0A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20251121113455.4029-1-devendra.verma@amd.com>
 <20251121113455.4029-3-devendra.verma@amd.com>
 <SA1PR12MB8120B42CB67E6A4F25318B4895DBA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <b6df2f2e-c1d6-4eb2-82e5-d7e149d12575@linaro.org>
In-Reply-To: <b6df2f2e-c1d6-4eb2-82e5-d7e149d12575@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-10T09:24:45.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|SA1PR12MB9545:EE_
x-ms-office365-filtering-correlation-id: d0fdf1d7-2b0a-4513-2689-08de37d217b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?S0lXVlQ0YXdrZXpsdkJPemtjYnNpamkvbjErUWtvbUgxOFFzRko3Ym9OZTln?=
 =?utf-8?B?ZGtkRXpwRmtVclZ3RlhMaFNlTGx3NjVvcFNBbFpLU1ozZ2h5T2FPb2xXcGpT?=
 =?utf-8?B?TjUvNUU2bGlndFFJdlZHZnNQbkpEZkRLaHkzK3Q4Nlg1UUpYTTJYTHhtWkxV?=
 =?utf-8?B?MEpDUC9EUk5RNWhHVzJRMHdFRkZiZnlVcXBJZWNzeis4Z3A2cGVKWHkzUkc5?=
 =?utf-8?B?Z3diNGNiK3BMRzFjeUFNaXlGVFo0NkhwR2FOUURNeGk2MEwrYy9tcWErdFJs?=
 =?utf-8?B?eUQ1SklaMVNRalFDcWRSTXJZVXBDV2FsWjNHME5IL3BMQlVkUWg2M1MyU3Jn?=
 =?utf-8?B?VWdYWkxUM1dsNmFMOUhqQVhQWkRkenorSk4yODZVUSt2cjFVbWVKblVNRW9s?=
 =?utf-8?B?dUM5RWkzajdtbjEzWnFaMm5aZEQzYTdJYmZjSVFJTjJUT1l5dmc2cjNOeW91?=
 =?utf-8?B?WjFJSTI0QmZGR252VTBOZGdPS0c3MmVJNmdWdm0xcGdHKzNScy9pYVpGUUdl?=
 =?utf-8?B?angyY0prK2gyZVR4TDJ4S3NBbzAycmwwdytzdEI5bFF4Um9GcEtFUW4xaHRp?=
 =?utf-8?B?U1l5NU9HeGgyNEd5MTZZOXRYVDRJSjMya3hDaHpZOGhmY3o1VDhJY1hYYUdv?=
 =?utf-8?B?VlVnWUw4d05aRnhZZ1h1RWp2UGxlNmhFU2pSN2xRdTlWRTY0WnpGL2I3MWVH?=
 =?utf-8?B?Z3FhbFIrRVlscXFEdmRtUnNQRUR4cVJlMmgvbGk0VENGUEh6QzhDYXdmWUVG?=
 =?utf-8?B?MkEzT0ZoaUlsdFBtYjNsSGgzOUdDRkt3Nk9zV3BhQ0Y5SkVyZnRHbXhuK2ZO?=
 =?utf-8?B?eDhJV2RXSXk4UzQ5dmM3TDI1c1B0amVaRHdpTkVBT2NENmlNOGV4OWgzczJ3?=
 =?utf-8?B?M0taNmd6Y3dxSVhwUUVvQzRJd1ZaczRjRkRjRlpkK2IyQlYzcWUrNzEwc3Za?=
 =?utf-8?B?dEc1YnIrWUN4cVREQUZjUHlKUGVPVVZiYkpEVXV2dkpxU3RZejhvZXFMd1Nn?=
 =?utf-8?B?OUNUK0EvbGxrOTMzN3NMQWFkUGtkWUJFRGJpdEZrRFduSlBFMnBEQytiYXIz?=
 =?utf-8?B?MzBRa29tOExZNG9qMHM5elYzUithMkZOd05DVHVqdWRRVEZYa2gyR0hSRVNN?=
 =?utf-8?B?Y2hqait0ZTZMTGNLTUs1RmNqRjArVlFPRkgzZ01JT1pNUjcwWFZVYlY3OUxT?=
 =?utf-8?B?N3l5UW12Z1I5ekJXYVNxQ29nVDE4cWZEMG4xcG95UlhRWFZOMCtjU1BSM1BV?=
 =?utf-8?B?TzJ3VXZFMnZMbGZqVWVSNDBOa2ZGWGJLRHFwVnFIWkkzSjJFc21YQ3FqWHRH?=
 =?utf-8?B?eTFKSmE5NlVGRkt0WlpGVFNLSGRzLyt3SnRKU3FuUVptSW45c2UrR3h1SzZq?=
 =?utf-8?B?a01BbE5Ia1ZSNnQ1MFQrb04vdmt0STkwUGFBTmlSY1NCRlpLVVdGRGljWk1m?=
 =?utf-8?B?dC90VzdqOStFZnNlTnZYSHU1MEFscnl4NFgzZFFCVEJBajRZYnAzOCtSN3pF?=
 =?utf-8?B?Rm9kWTNXd0NHekFqSDAvNFVMa2gzUWNyZDd2SnMybkhVSWpiM1d6ZlVPWER6?=
 =?utf-8?B?dkFxS0lqKytkVk1tYy9aWklpc2JaazQ3NDN2N2FVZTVUaFZkdGVFTkVJd3VI?=
 =?utf-8?B?V2xyOHNvVThONm1YbHFuUnQ4UVAxbEczNGE4SVJibjRjWlR6QkNUcDVUM21l?=
 =?utf-8?B?UnQwM2Q3OTUrd3M1aVRwRzB2eWtNaFpiblJXa1ArRXNmUVpOa3dNbE8ydDNk?=
 =?utf-8?B?TTRYNzdFTGNGcHFBSXhMelhKTGpjcFFpQ1pRNW9nRXhlajBNNjB6azY1NlU4?=
 =?utf-8?B?U1VxeSs3VFFEcUpjNkUzODE3TkVVR0lJUmtUUTJock9Ba0pIMVJhUXVYaHRa?=
 =?utf-8?B?TWJabkJEZzVyaGJXaUdEVjMya3hwZlp1V1dLUjMxYXNKYy82cUYwcVNDUVVt?=
 =?utf-8?B?MGZWODJDTGtLNjFWVkRyQ3Z6NUlBUmhtcHdkQmh2VHBadnNtUnEyV0hDbWlQ?=
 =?utf-8?B?eHFXU2tBSXJjdDlvWWRlOVlFY2NNbFFKNmx3K0JybEloS1dKU3Q3MjdkWkhX?=
 =?utf-8?Q?lPzrnZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjY3RFpobUZleVg5L0FhQ2lSeEt2dU1uOGZ4bXE5cGtyZS9wM0NCZlU2WUVz?=
 =?utf-8?B?MnZlYi9NU1d3WjJaRzlkaFZVR25ON1dtQkxNTEdudEs5R09uVUtMQ2tJZzFN?=
 =?utf-8?B?RnFzMmxGYlJacVdwZFdldE1iVFF2c3VoangrQ1o4dzA0OUN3ajZFT1N6cVBm?=
 =?utf-8?B?RFBSY3VJazBLWi81bUJRMUNUdmNpb0Z6aE5yNWRsaGhyMHdRTFpndFJTVzI1?=
 =?utf-8?B?U09XM2t2bEFqTUIraGh6bnUvUlo5UEFhSUErNE1JNFVUdkhxNnh5eUYrRWI1?=
 =?utf-8?B?blI5dGZvdVhxL1BzMmIrMWJRKzdSYnBqY2pKbG16SnJIbnA0emY4Rjh5NDZh?=
 =?utf-8?B?bGhSVGZTektoYi9RY2lpTmxPU2J1K3FtZHRpR1JFOGdRRXZCV2JjU3phaysv?=
 =?utf-8?B?SXdyL0lFcjJZNS8zME8xaFYvRjYyZUovdGgra2x5QXROaCs1Qkl2MldRL2h4?=
 =?utf-8?B?WkVhaHlpTTNISnNXK3orejZ0Zkp2VDAyRXRWUkFQU3c5SlB1cklFYkZkcmg3?=
 =?utf-8?B?OFlhZ1lNbEZrV1g5VjFKbFkxZG45bHVVQ2RhajNuRmZLY0dZY2RxdWZXVjhz?=
 =?utf-8?B?NzZSK0lzUnJ0WG1XRXQwTHBMdkRtVzBQbmlXc2llTFBJRE1zZ2JWNEZHZjBu?=
 =?utf-8?B?RG1ZaDBXOUt5cGZDQXREOFUwaEkxcUhoQTltNU9wSEVwZjNYNUl1aHZHenUx?=
 =?utf-8?B?YmMxK0M3aUtSNXNiMm9kZVZhYjNoOW1FVitTOG5SUlZIdGZGQ0djc0pab0Zz?=
 =?utf-8?B?TS8yZVhSMnZ6NjBKNUJ1bDRSR0JvN251akZzTWZESDhkZUtPdkJkc1NYL1pF?=
 =?utf-8?B?NEcwaWxrOXpkdWdMS0JzK1U0MEhQS3M4Z1l0aUI0YnErV0JYdGRpa3NyVHh4?=
 =?utf-8?B?QXRnUXJ2ampHQlEwU2FqdFRUdDh0MFcxQ3p6U2luZjZvMnVJNXZDeTNaK2xp?=
 =?utf-8?B?cnduTnR2ZEM1bmpMRitqSm5maVZlMnBUL0U1bnFoR1ZRRkhGY3JQdVcwd0dE?=
 =?utf-8?B?d1c3cWx6U2VYczJWaEV6TlFZaVhNMlJvWURGV0RmdEpwN2MzcUtXcFl6UUtL?=
 =?utf-8?B?SnNNMDJYbC9NRW0vckVmSjJ6YWl5Q0NndlhqbkhuWkk3WjlNN0JmYXh2QldB?=
 =?utf-8?B?RUpJV3U5STlvSE9nS3ZBSk9lVHdKUTJUTnJnamx4VUdXeE1LZ2w2MGl3L2tZ?=
 =?utf-8?B?eVFOM0dFYTM0b25MR0RWUDUzajJ4Z2MyQnUvcEZJZndYVVdzaU4rYXVLMmFw?=
 =?utf-8?B?cWw4YVNHNFJOK09YbW5Td0xqRURuWnZISnR2VVdNTlZGa3QxRkpqNUNrNmxW?=
 =?utf-8?B?Y1RsT3I4dklGTEFMY2RQcUxmbDg2ZGRwdXRuaTcxcXpKc1VZQVJLd09VOVBs?=
 =?utf-8?B?NkpkYzN6RU5hVWE0Q2FBZDZHb3JObndjZ0NFTndUaThTMHhFbEUxYVpxdDdm?=
 =?utf-8?B?NVZjbmJHQTA3VkpwVStrRGl5ak5zWVcxaTArTDMxU3B5SmFJcy8zY25WdXZv?=
 =?utf-8?B?WmdPajgydDBUY1RKUmZEWjFFSStYdThTb3pDbjN3OTZBdmwwQ0puUFBVY0Y2?=
 =?utf-8?B?cjZqYUJJZG1OU2lmUTBTcVhHczRBVzRmOHI0TVNVd21RMWExUHFoam9vV2Jm?=
 =?utf-8?B?Z3NnQ2U0VmVIWVZRTWNFVDlMeEw3UmRwdXV3K3ZGTk55MGhGSElId3BobU9r?=
 =?utf-8?B?RGdvRndnTVBMbW9vZ0JwYklJYTlQTzdWZkNRM2l3TEVUYitnV3ZJOG1Bcms2?=
 =?utf-8?B?emRLd1dHNGlHTU01UmNaWWFUSWNib0RGOW81RDVMSUpaSDZQWGg4U1IveFFz?=
 =?utf-8?B?UTAzVVFPci9GUGhOMi9KeUN5anYxZkNpbWIzcXFhWnBCTmJiaFQ2MExYMmRi?=
 =?utf-8?B?aHVGdHJTQkVTM1d3WDFVMldSeFNVbGhKZE10TVdTbFdRci9KSWpYRE9pUUp1?=
 =?utf-8?B?SG1vZmNrVW5XWWNnQVo4YzJsWTd2Z2k0bEdJWGF4L2krc0c5YXhzWUsvcGdR?=
 =?utf-8?B?V1hvTzhIUy9zOVFSOFR5b2VkaER0UGVkVGNYL0FFWXJHYkpHVjNXOWFRQ2lO?=
 =?utf-8?B?aDhNRUdwTXZFTytqMGcybzFPSmwvbmVodXFjeHdEV0JSVXlsSXBycGxpa2Jr?=
 =?utf-8?Q?75QY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fdf1d7-2b0a-4513-2689-08de37d217b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 09:54:21.2319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1AcGMyF+5jhMsNKN7f+IjXDWBqg3GijWK331i3TV6eKno6NiqqOow3INIxn3Ca/2zwevhC3trAFANTiMFH9+LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgRXVnZW4NClBsZWFzZSBjaGVjayBteSByZXNwb25zZSBpbmxpbmUuDQoNClJlZ2FyZHMs
DQpEZXZlbmRyYQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEV1Z2Vu
IEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbGluYXJvLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBE
ZWNlbWJlciAzLCAyMDI1IDI6NTQgUE0NCj4gVG86IFZlcm1hLCBEZXZlbmRyYSA8RGV2ZW5kcmEu
VmVybWFAYW1kLmNvbT47IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IG1hbmlAa2VybmVsLm9yZzsg
dmtvdWxAa2VybmVsLm9yZw0KPiBDYzogZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgbGludXgt
cGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNp
bWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IFJFU0VORCB2NiAyLzJdIGRtYWVuZ2luZTogZHctZWRtYTogQWRkIG5vbi1MTCBtb2RlDQo+DQo+
IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNl
LiBVc2UgcHJvcGVyDQo+IGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2lu
ZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gMTIvMS8yNSAxMTo1OCwgVmVybWEs
IERldmVuZHJhIHdyb3RlOg0KPiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJu
YWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+ID4NCj4gPiBIaSBBbGwNCj4gPg0KPiA+IENvdWxkIHlv
dSBhbGwgcGxlYXNlIHJldmlldyB0aGUgZm9sbG93aW5nIHBhdGNoPw0KPg0KPiBObyBuZWVkIHRv
IHJlbWluZCBwZW9wbGUsIHlvdXIgcGF0Y2ggd2lsbCBiZSByZXZpZXdlZC4NCj4NCj4gPg0KPiA+
IFJlZ2FyZHMsDQo+ID4gRGV2DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPj4gRnJvbTogRGV2ZW5kcmEgSyBWZXJtYSA8ZGV2ZW5kcmEudmVybWFAYW1kLmNvbT4NCj4g
Pj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAyMSwgMjAyNSA1OjA1IFBNDQo+ID4+IFRvOiBiaGVs
Z2Fhc0Bnb29nbGUuY29tOyBtYW5pQGtlcm5lbC5vcmc7IHZrb3VsQGtlcm5lbC5vcmcNCj4gPj4g
Q2M6IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LQ0KPiA+PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTaW1laywgTWljaGFsIDxtaWNo
YWwuc2ltZWtAYW1kLmNvbT47IFZlcm1hLA0KPiA+PiBEZXZlbmRyYSA8RGV2ZW5kcmEuVmVybWFA
YW1kLmNvbT4NCj4gPj4gU3ViamVjdDogW1BBVENIIFJFU0VORCB2NiAyLzJdIGRtYWVuZ2luZTog
ZHctZWRtYTogQWRkIG5vbi1MTCBtb2RlDQo+ID4+DQo+ID4+IEFNRCBNREIgSVAgc3VwcG9ydHMg
TGlua2VkIExpc3QgKExMKSBtb2RlIGFzIHdlbGwgYXMgbm9uLUxMIG1vZGUuDQo+DQo+IElzIHRo
aXMgbm9uLUxMIG1vZGUgc29tZSBvZmZpY2lhbCBuYW1lID8gKGUuZy4gaW4gdGhlIGRhdGFzaGVl
dCBvciBvZmZpY2lhbA0KPiBwcm9kdWN0IG5hbWUgKSBCZWNhdXNlIGhhdmluZyBhICdib29sIG5v
bi1MTCcgYXMgZmFsc2UgbWFraW5nIGl0IGluIGEgTEwgbW9kZQ0KPiBhZGRzIGEgZG91YmxlIG5l
Z2F0aW9uIHRoYXQgaXMgZGlmZmljdWx0IHRvIGZvbGxvdy4NCg0KSW4gdGhlIERlc2lnbndhcmUg
ZGF0YWJvb2sgZm9yIFBDSWUgRXhwcmVzcyBjb250cm9sbGVyLCBwcm92aWRlZCBieSBTeW5vcHNp
cywgTGlua2VkIExpc3QgbW9kZSBpcyByZWZlcnJlZCB0byBMTCBtb2RlIGFuZCBub24tTEwgbW9k
ZSB3aGVyZSBubyBMaW5rZWQgTGlzdCBpcyB1c2VkLiBIb3BlIHRoaXMgY2xhcmlmaWVzIHRoZSBk
b3VidC4NCg0KPiAgPj4gVGhlIGN1cnJlbnQgY29kZSBkb2VzIG5vdCBoYXZlIHRoZSBtZWNoYW5p
c21zIHRvIGVuYWJsZSB0aGUgRE1BDQo+ID4+IHRyYW5zYWN0aW9ucyB1c2luZyB0aGUgbm9uLUxM
IG1vZGUuIFRoZSBmb2xsb3dpbmcgdHdvIGNhc2VzIGFyZSBhZGRlZA0KPiA+PiB3aXRoIHRoaXMg
cGF0Y2g6DQo+ID4+IC0gV2hlbiBhIHZhbGlkIHBoeXNpY2FsIGJhc2UgYWRkcmVzcyBpcyBub3Qg
Y29uZmlndXJlZCB2aWEgdGhlDQo+ID4+ICAgWGlsaW54IFZTRUMgY2FwYWJpbGl0eSB0aGVuIHRo
ZSBJUCBjYW4gc3RpbGwgYmUgdXNlZCBpbiBub24tTEwNCj4gPj4gICBtb2RlLiBUaGUgZGVmYXVs
dCBtb2RlIGZvciBhbGwgdGhlIERNQSB0cmFuc2FjdGlvbnMgYW5kIGZvciBhbGwNCj4gPj4gICB0
aGUgRE1BIGNoYW5uZWxzIHRoZW4gaXMgbm9uLUxMIG1vZGUuDQo+ID4+IC0gV2hlbiBhIHZhbGlk
IHBoeXNpY2FsIGJhc2UgYWRkcmVzcyBpcyBjb25maWd1cmVkIGJ1dCB0aGUgY2xpZW50DQo+ID4+
ICAgd2FudHMgdG8gdXNlIHRoZSBub24tTEwgbW9kZSBmb3IgRE1BIHRyYW5zYWN0aW9ucyB0aGVu
IGFsc28gdGhlDQo+ID4+ICAgZmxleGliaWxpdHkgaXMgcHJvdmlkZWQgdmlhIHRoZSBwZXJpcGhl
cmFsX2NvbmZpZyBzdHJ1Y3QgbWVtYmVyIG9mDQo+ID4+ICAgZG1hX3NsYXZlX2NvbmZpZy4gSW4g
dGhpcyBjYXNlIHRoZSBjaGFubmVscyBjYW4gYmUgaW5kaXZpZHVhbGx5DQo+ID4+ICAgY29uZmln
dXJlZCBpbiBub24tTEwgbW9kZS4gVGhpcyB1c2UgY2FzZSBpcyBkZXNpcmFibGUgZm9yIHNpbmds
ZQ0KPiA+PiAgIERNQSB0cmFuc2ZlciBvZiBhIGNodW5rLCB0aGlzIHNhdmVzIHRoZSBlZmZvcnQg
b2YgcHJlcGFyaW5nIHRoZQ0KPiA+PiAgIExpbmsgTGlzdC4gVGhpcyBwYXJ0aWN1bGFyIHNjZW5h
cmlvIGlzIGFwcGxpY2FibGUgdG8gQU1EIGFzIHdlbGwNCj4gPj4gICBhcyBTeW5vcHN5cyBJUC4N
Cj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogRGV2ZW5kcmEgSyBWZXJtYSA8ZGV2ZW5kcmEudmVy
bWFAYW1kLmNvbT4NCj4NCj4gWy4uLl0NCg==

