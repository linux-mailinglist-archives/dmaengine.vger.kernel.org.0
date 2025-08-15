Return-Path: <dmaengine+bounces-6045-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CBCB279E4
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 09:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0919A60729F
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 07:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D062F99BB;
	Fri, 15 Aug 2025 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="P8qsPOdp"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E7E2D0C80;
	Fri, 15 Aug 2025 07:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241686; cv=fail; b=ZeLIe+QtjT9SAOJTexC7t9+qgfO7NGK/euj1vshDqpPtdNx2E5iwb0JDDhnbm+hNmAwB3dUOE/oc6t0dgdaXDQrNGiEKMRJpjtgef7n0DxzOmOSTL24WEL+iDoRXIvpJAUBLfLKL4zqiskkch/S+5rb3pTDnEhDKdqCuNcmWEIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241686; c=relaxed/simple;
	bh=Hqhl5PpEf0Ty+LMk7oP/XFjrpvid/jqtXW0wYNY7tUY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=drTvow4EzOvofKeiLgx3uueAyhXAkZWIKP7bnMGKv3a2pTczBbtCsZ39n8owqi/6aNGkK2OI0SnsiQU7dJhO6mT7JxE8qtwPXwneWFpo3SJ+qsD8dXEIK+uYd1VLaj/BsNLwGGst+38BXg6Q51oUQJ958vUawNkzu6vwob1CJNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=P8qsPOdp; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMpmlGxz8WHiexYfVWQ6luDsC04wVAKZ7BIVKeB9oSFJMt7hyU8BgUDe2e/PEwYU59kVO46kF+sT5GIBPBImojOV2gy4+NLa3rmCKqMy71A4YraIFm32w637GLSJhwF3NQfZUQu+bJcNYQiGT0EMiKpt586gHFf1LMa+rMPR730CliMYff3tOCwbqqG/RVYJQi74V6sx0nShF9v8TcUkJooG4SfE29u0g9OkBbqfoKUF3RXzKuVf9y/XsLG3DumcGZIPHakWhAUivYFbjbNUt0XFH9bjET5P0DFzyYlGcSBejsXiAtdp3aBcUXe31ALc3RvfBtt4pS6N16ugq785kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hqhl5PpEf0Ty+LMk7oP/XFjrpvid/jqtXW0wYNY7tUY=;
 b=ccCDAEEO7Zt/e6VqcZTPF7diWTVnSghmoY19Bv5FY91vgskjWzY/X7IPf7Zq5ffDTxwy1sF9i/acTr3llnm0MgemBnm0C9cYuYGdemfY0YdR1lTtxZJmeiqsKpQdkd8fhFZTXzK4TYhgRbiPM6BxtGngoKOiOA6gYaurhFU9n2kb9IYnvlwYGOHuH5loWQhM5LMhGUUDJxZtDU4nppB0wGpAfmctA5B3FoS5XkauFHBgSNZwzN1/vBiJ6aCy+f1Z/JPGUtUCRQwoUgUuhySiUHcutimgdEVWFgGBvsmiouJhBB3zBX4ANzt9sbMjB1EATS21LeFClBAvoe0D3qX93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hqhl5PpEf0Ty+LMk7oP/XFjrpvid/jqtXW0wYNY7tUY=;
 b=P8qsPOdpAdXSGJJw/+9MeOX9DBsWmo09JlVTwC5f8eQy801BpFWhlRJ/fK+knI/22qqAflLAdSZ6Jtw91f6R2+Pow9MPXfuGxENXccEx7JG539FPCZnkgQrDyjQUqud7DFMg86GkInMjA8QguwYP76e2y34QAd7r594FjlHg1zGr6VOkSBH3BRmX2SfuPxTG6957zJg+glr3K4bI169Jwwaal5yUq0HQ4fUqS4IOEB2MP92mL5/GwxbmrpOUyVjAgQHwSpoL4Vd3rByYblFKTQ9wnXpgs64iSFU8pE7XnAZp+vRL9dbA83RaHVZkwSeZPLEyuHSoezgnWOPbu08tog==
Received: from SA1PR19MB4909.namprd19.prod.outlook.com (2603:10b6:806:1a7::17)
 by PH8PR19MB7141.namprd19.prod.outlook.com (2603:10b6:510:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 07:08:00 +0000
Received: from SA1PR19MB4909.namprd19.prod.outlook.com
 ([fe80::6ff2:7087:8d0f:903f]) by SA1PR19MB4909.namprd19.prod.outlook.com
 ([fe80::6ff2:7087:8d0f:903f%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 07:07:59 +0000
From: Yi xin Zhu <yzhu@maxlinear.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "kees@kernel.org"
	<kees@kernel.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"av2082000@gmail.com" <av2082000@gmail.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] dt-bindings: lgm-dma: Added intel,dma-sw-desc
 property.
Thread-Topic: [PATCH v2 1/3] dt-bindings: lgm-dma: Added intel,dma-sw-desc
 property.
Thread-Index: AQHcCBPALrBJpgW7V0mdzTs1Qi24hLRYReGAgAsMz+A=
Date: Fri, 15 Aug 2025 07:07:59 +0000
Message-ID:
 <SA1PR19MB490961745C428F56D7E114F7C234A@SA1PR19MB4909.namprd19.prod.outlook.com>
References: <20250808032243.3796335-1-yzhu@maxlinear.com>
 <32a2ec88-b9b8-4c4d-9836-838702e4e136@kernel.org>
In-Reply-To: <32a2ec88-b9b8-4c4d-9836-838702e4e136@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR19MB4909:EE_|PH8PR19MB7141:EE_
x-ms-office365-filtering-correlation-id: 887d64cb-46cd-4089-8af2-08dddbca77e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RFZhSVdmYU1ib3ZCZkRuQ1lCeTl0MmNLa0N5SmlXQS84NWtabUxqdmNLeis1?=
 =?utf-8?B?YlJGOGgyY2c3cVFGa1FFNHlTODJ3Q1o0K2dId2hNckV3aCtNSnFXbnAyRlRt?=
 =?utf-8?B?QTFEL3gza1RvcnVRemRJbThNQzl1bjdRNnVsOEpoVWZIWHFYRlhUTzNMSVVo?=
 =?utf-8?B?WkVxNnF0M1FBdHNtUU1ZVkFuQ2VVQTJtQ3Zqekh2UHY2dE04dXF3aXdFM2Rj?=
 =?utf-8?B?My9NNzBnWkVoWHlmaUx5OXBJVVdxdTNWQVB6ZVFuMGRYRmJFZW9WaGhadnlx?=
 =?utf-8?B?Nzc0SmVtNWpzSjFvWmZXL3FxQitkSEYwZkNLaWJCRnF4YS8vcXlQK3Bmbk12?=
 =?utf-8?B?VVFVTWZoajRnL2dUVUUwMG9Ra0E3V2JwbGxaQ21EbGIxSk5sNkFIeWcwaC9i?=
 =?utf-8?B?aE9VMjBOdUpOb3ZYL1p2TEdGbWxteVNvTW0zRHl3dmRkUDZFbWRmckRNakFs?=
 =?utf-8?B?RElVTGdjT2w2K291amxCY0pQYnUyNUtmOWloWWZOWXlBdzhTb3N4TktrOGJi?=
 =?utf-8?B?RFhid2ZiSEkxbWwrUzVtdVYrMnc3djBvTHNLdkptVzZYK0lsb1FwN0U1bEk2?=
 =?utf-8?B?Szd1VHhEOE51VTBNbCtKOFRXQ3JiSC95ejBxdjJOZEhTRzRCVHpORlM0d2dK?=
 =?utf-8?B?aGQvbGFqZHliYnozME9YNDMvVWRsOWc1b0oxeTZxUzBBUTF3RWRSQjNjSkEz?=
 =?utf-8?B?TW9WMHB3eG1ad1NmZWNsbkRDQkFEakNQOXpicURMU0E0YlpzSzJGeEZ1eEVE?=
 =?utf-8?B?VnN3MDVzbStadXdxa2R2Z2ZPVGdGSDZ6djgwRnNvVzlSbWFBWG41MkNpLzBn?=
 =?utf-8?B?Y1RhL3Y3S3NuUjM5SU5ONTdBak5SSUhKZDZQQ3U3YzJpN2ltQzBQMHhmc3dO?=
 =?utf-8?B?Qm5pdFNnYzJIQ3ZFaFp6cUlON0VYV1hPRDBOM0hoZEJnS1c4NXNJQWo2Ny9p?=
 =?utf-8?B?UzgwNEszRE9sdExqZ1c2TDNsZTNHMjNDOGw5dUZWQUJZK0FkUTQyTGJmMWsx?=
 =?utf-8?B?bndKM2l2OGpkZCtObnpUc095RmRvRms1Mk5aVi9kR2laTFFIbVFsUG9pdFlI?=
 =?utf-8?B?MkltaGVMcWFydy9IQU44U05jOWpHS2Q3d25kNmdVNWF3TjE1eXN5MGw1cklz?=
 =?utf-8?B?bVQ2UnZ2c0FpT2tHWlkwYnNOY3J1ZDdVRE1RK2JOTm5scUdzdnBxbFFRQWJ4?=
 =?utf-8?B?WlBaMTEyand1WUJyVGNIMGN1VUhVUzVxN0xlcVRKSWxYU0ttQitsVEJ1ZW5u?=
 =?utf-8?B?RUFOa0hBY3NwZ1NEY3VtMjNXaWtKazZEUWFYWkVmZmZ1NVhrcGVhQ1AxQ0ZZ?=
 =?utf-8?B?Yk1XNWN1NnlONllkK2kyaXl4WmdWY1RuMER2WXYvTUpubkJvNFRYelRsa25k?=
 =?utf-8?B?MWk5cnFBSE9TaEJCbTZBb3hiQ0RpRWRncmwrR0s5MjBnMldsbExNUm55QXFW?=
 =?utf-8?B?UmU2MXJoOXREdjNIOGtmOE1JeGtWSlR1bmdFSjhwN2pHQmZxc3M1MHlCWGxz?=
 =?utf-8?B?YlZRTHMxSHVRekVXL0ZMc2FUd3FTS2FPaWhrM0owUG4rcVB0aXZzeTY1VURl?=
 =?utf-8?B?ZWh5bUVIUy9yZnpwZjhpaHJHVWlEVDJVbVExcWJZWHp5RzZYRmVRK0E2cWw0?=
 =?utf-8?B?aWU4QnVpK1VVQ24vUm1ML1VpSisyQ3ZxYlRTUXplMXN1aEpkN3hhMXVTOU13?=
 =?utf-8?B?WjNXVWExSEJkQ21TYmIvbVB6aERpTnJlMGhFVDFDWllvdm1wOHNSSVN0WWFv?=
 =?utf-8?B?YW9JckZETkg0dkxTeWxmQ3NLczJSTkw0eTJ6NHowSEw3MkFqSDhnamF3ekZt?=
 =?utf-8?B?QlExK1lqSVZkSysvT1F3bm9YRTFBQTVtZ3l4T2ZiTldkdnJhZjc5blNGUngy?=
 =?utf-8?B?anY3b1U0N1hJZmFVL052Qi9BSUpTa3duTGZrNnN2UjBDTmNRLzNpdi9jT1hs?=
 =?utf-8?B?SldZVnRhRXlGdzl4WTlEMVo1b3dXY1BhSDdWeTZKVlRKdGlpdjVNL2lCL2xv?=
 =?utf-8?Q?q4s2hD3cEuo47ogWJx+CxdFz/cfU4c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB4909.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ak11OGhpaWhEYW1mV3A3NlBNQkZIY0RucUh2ZUxDU2NKcXM4KzlBVEN0V1Zt?=
 =?utf-8?B?QVJ0d2NzUndLM0piY0ovOU9UdlNuNUxhUVJKL2pqM2xvVklBbWh6eUNJVklN?=
 =?utf-8?B?OEhjT3ZuSkF2bEFCTE5CdDltOWoyeFRJbVI5MkFKSDcxT0djNXhveTQyU09N?=
 =?utf-8?B?R0VJSmdNcEQxb04rVGNOS21rcWNTL0FMWHdZRjljTUk4MVNaNmlqWUpUL3FR?=
 =?utf-8?B?K0dJRVZNbWc1c091elBaU3AzaS9KRFlCNTJLcXFIeEpKaFBMZWMwZEFzS1c5?=
 =?utf-8?B?eHZVZkZmckd3QXF3Rm1mdkRaZjJVYTE2RVowZ201R25tSDVEOXhMZExDSkJN?=
 =?utf-8?B?SnhrcXhvV3plQllTejRPZlVZRXQyMDF6aTZKeDB5WGp3VmV0bDhrNFlrN0E4?=
 =?utf-8?B?Mzh5UHNpZDh4S1hXSFlmdW5PZmhLeFQ0RGRuYlRrL2t0N085YnJYTEs5SEd6?=
 =?utf-8?B?VlNEUW03aWkvSGE3NE0vSmMwRG1xN29NYXQ2aEswaUl5YzZ4Q2xLRVNaczZt?=
 =?utf-8?B?Wm1xMnNtV1ZmMVJsTDIrODhnZUVLWGk3TCtHS20zTXUwaU1URGV0NHhlR1BW?=
 =?utf-8?B?R0FtNlpMdmVzVDVGb0IrNXRKQ0ZHN3l0a081QUovZkd3UUF5L3NvMGhFdzhi?=
 =?utf-8?B?cXZsSkxmcDhEb1hNWmtWU01BU1NwdTJUbExKV056b0svUm52SzVsekxyek5r?=
 =?utf-8?B?TUVSYWJUenZ4a1cyaTFvekZyT0ZkMVFjWHU4WGZNMmdTYmpUUm03V09OanpY?=
 =?utf-8?B?Rzl3K0tNdm5jUXdMbmtXdGhQNVFsMUNHbFQ2cmlRWWRvblpDeEtTRW54THQz?=
 =?utf-8?B?NXVKYVZUaWFFT1hzMEtrRTZpbkxtc3IwenZwbzVERkRhVGVrVHFwcCtzWEpI?=
 =?utf-8?B?aTAyS3B6SlJDYjBjRmowMHZoM1pvK0ZpS3FGL0RCSjd3aWs4K2w4V1dySWZv?=
 =?utf-8?B?NjMzTVRSM0pGNzFSMVlyWHpGUTlPOTNPVXBJWXNmWkEySHZNTEhSRWZtQlZk?=
 =?utf-8?B?bTRUckp4QWVmbUVjdDMzWFI3U05TWWk0LzFIWkdLcXdTcy9jYnR1Tkx1ME9Q?=
 =?utf-8?B?RU9aczc2V3U3MDZYR2xHNkVkVjlNVWEyME10S2dnUkJJYlhBZmxwZFhSSzJT?=
 =?utf-8?B?SHBpRGczYnc1bmg2ZGhwWEh4R0FSM3FqRmxtKzJSUlpUQWxWbWkxcEN1dFo2?=
 =?utf-8?B?V2xYMTRUV05RMkhncCtRSFRHMXNBNDQ5Y28rbStlNUFuNmZzU3BFMzZNZUQ4?=
 =?utf-8?B?ZFN4aUs1bUNIeXJKdEhQejdwUENjTEpCTDlDaXZ3RFRzb1hjRzdKakFKZnZT?=
 =?utf-8?B?RHFRK0MrcGVMUk4xdmhLWGdzdG1NUU5CY3lWVXUrNysra2EwLy83dVNjU0xm?=
 =?utf-8?B?VUR6aWp0STBqUnFTRllMSUtFU0V4YlpWQVJNTUZwVEpYN0EvUG15eGowTWQ4?=
 =?utf-8?B?eWg4ZUkxWjRzY2Uydkd3TWtvMHpMRFpCK1FEQ05YT3JySVhCdEo0S2ZPdHZH?=
 =?utf-8?B?MU5FNTQ2TFRHNms0VDBTMkVZOFRpL2RIMDRNdWVQREFSRGVXbXQ3RHpOa0pn?=
 =?utf-8?B?eUlBSUZ3SFg2cUxJdDBKTUJuL2Z0Y2c4SUdXOWdtUlpXVnp0Z010MXVUeWgr?=
 =?utf-8?B?OFRac3hEOWF1KzNWbTFOd1loMmV1YmNKeit1WUNNWVJVUXNab1lKaERUSkNM?=
 =?utf-8?B?djNQVmpaQmxIcm5HSW9GQUlBM0FPbGxqWWpuQ0lCem9GcWpSTFBWcmdPVlYx?=
 =?utf-8?B?aDROL0FpWW5PMlJnMHZocGw3cUpZMkJidFVYWk0rTkZDNy8yQ09mSDRZcUE1?=
 =?utf-8?B?MmNvOXd6MGlOQmZyUmkvT2RLemFlUG9IdjYzWUpUL2tWUUF6V0VoZDQyV1JB?=
 =?utf-8?B?ZnBFRG00d29ZMmwwalRqWFp5MngrdFBEN1k2YWY2Ykk0azVEL1oxcWpzNGZx?=
 =?utf-8?B?akkydWdKNUNNTzExckFKOVFsdG9HZHZWRU1yWVpVNGt4cTQwQlZQdmdVTzIr?=
 =?utf-8?B?ZEc5WXJTeThoSzZJOWk1cjBCUlBncXZ5VERRM21PMWUwMzg3T2xDNFBiV2ZS?=
 =?utf-8?B?MzBzUW5BbE1ncnp6VU53WjhYbGNuTmk2UDJYV2dYaUViMmJyZk5PR3ZsNmxE?=
 =?utf-8?Q?8faU3mCKznaHoZsLhoVfJb/VJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 887d64cb-46cd-4089-8af2-08dddbca77e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 07:07:59.7353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bo1A6EhTRB9Pdxpb6BoP3hjIyfGmwEYEDYA4O/SM7nAuMxS8ik8E/nUECm8YYlbiC3f/E3baEt6j44Uy+sWbzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7141

SGkgS3J6eXN6dG9mLA0KDQpPbiAwOC8wOC8yMDI1IDE0OjEwLCBLcnp5c3p0b2Ygd3JvdGU6DQo+
IA0KPiANCj4gV2hlcmUgaXMgdGhlIGNoYW5nZWxvZz8NCj4gDQpTb3JyeSBmb3IgbWlzc2luZyB0
aGUgY2hhbmdlbG9nLiAgSSB3aWxsIGluY2x1ZGUgaXQgaW4gVjMgcGF0Y2guDQoNCj4gPiArICBp
bnRlbCxkbWEtc3ctZGVzYzoNCj4gPiArICAgIHR5cGU6IGJvb2xlYW4NCj4gPiArICAgIGRlc2Ny
aXB0aW9uOg0KPiA+ICsgICAgICBJbmRpY2F0ZXMgdGhhdCB0aGUgRE1BIGRyaXZlciBzaG91bGQg
b3BlcmF0ZSBpbiANCj4gPiArIHNvZnR3YXJlLW1hbmFnZWQNCj4gbW9kZS4NCj4gPiArICAgICAg
SWYgdGhpcyBwcm9wZXJ0eSBpcyBub3QgcHJlc2VudCwgaXQgaW1wbGllcyB0aGF0IERNQSANCj4g
PiArIGRlc2NyaXB0b3JzIGFyZQ0KPiBtYW5hZ2VkIGFuZCBnZW5lcmF0ZWQgYnkgYW5vdGhlciBo
YXJkd2FyZSBjb21wb25lbnQgdGhhdCBjb250cm9scyB0aGUgDQo+IERNQSBlbmdpbmUuDQo+IA0K
PiBOb3RoaW5nIGltcHJvdmVkOg0KPiAxLiBTdGlsbCB3cm9uZ2x5IHdyYXBwZWQuDQo+IDIuIFN0
aWxsIFNXIHByb3BlcnR5Lg0KPiANCj4gSSBkb24ndCB0aGluayB5b3UgcmVhZCB0aGUgZmVlZGJh
Y2suIFlvdSBuZWVkIHRvIGRlc2NyaWJlIGhhcmR3YXJlLCBub3QgU1cuDQo+IA0KPiBCZXN0IHJl
Z2FyZHMsDQo+IEtyenlzenRvZg0KDQpDb3VsZCB5b3UgcGxlYXNlIGdpdmUgbWUgc29tZSBhZHZp
Y2Ugd2l0aCByZWdhcmRpbmcgdG8gdGhlIGRldmljZSB0cmVlIGF0dHJpYnV0ZT8NCk15IHVuZGVy
c3RhbmRpbmcgaXMgaWYgSSBjYW4gY3JlYXRlIGEgcGhhbmRsZSBsaW5rIHRvIGRlc2NyaWJlIHRo
ZSBETUEgZGVzY3JpcHRvcnMgYXJlIHByb3ZpZGVkIGJ5IHNvbWUgSFcgY29tcG9uZW50LiAgDQpU
aGF0IGZvbGxvd3MgdGhlIGNvbW1lbnRzLiBTb21ldGhpbmcgbGlrZSB0aGlzOg0KDQppbnRlbCxk
bWEtZGVzYy1wcm92aWRlciA9IDwmeHh4X2h3PjsNCg0KVGhlbiBpdCBkZXNjcmliZXMgc29tZSBI
VyBjb21wb25lbnQgbWFuYWdlcyB0aGUgRE1BIGRlc2NyaXB0b3JzLg0KV2l0aG91dCBpdCwgaXQg
bWVhbnMgU1cgbWFuYWdlIHRoZSBETUEgZGVzY3JpcHRvcnMuDQpQbGVhc2UgY29ycmVjdCBtZSBp
ZiBteSB1bmRlcnN0YW5kaW5nIGlzIHdyb25nLg0KDQpIb3dldmVyLCBpbiB0aGUgZXhpc3Rpbmcg
ZHJpdmVyLCAgSFcgbWFuYWdlcyBkZXNjcmlwdG9yIG1vZGUgaXMgdGhlIGRlZmF1bHQgbW9kZS4N
CkkgY2FuJ3QgY3JlYXRlIHN1Y2ggbGluayBpbiB0aGUgZGV2aWNlIHRyZWUgd2l0aG91dCBicmVh
a2luZyB0aGUgZGV2aWNldHJlZSBBQkkuDQpTbywgaXMgaXQgb2theSBJIGNyZWF0ZSBhbiBhdHRy
aWJ1dGUgbGlrZSBiZWxvdyA/DQoNCkludGVsLGRtYS1kZXNjLXByb3ZpZGVyID0gIkNQVSI7ICAg
Ly8gaXQgbWVhbnMgQ1BVIG1hbmFnZSBETUEgZGVzY3JpcHRvcnMuDQoNCkludGVsLGRtYS1kZXNj
LXByb3ZpZGVyID0gIlhYWF9IVyI7ICAvLyBpdCBtZWFucyBYWF9IVyBtYW5hZ2UgRE1BIGRlc2Ny
aXB0b3JzLg0KDQpQbGVhc2UgYWR2aXNlLg0KDQpCZXN0IHJlZ2FyZHMsDQpZaXhpbg0K

