Return-Path: <dmaengine+bounces-5461-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 635A9AD9773
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 23:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B818189E24B
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 21:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAECF28D8CB;
	Fri, 13 Jun 2025 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UF40NQ3V"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC0E248F49;
	Fri, 13 Jun 2025 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851015; cv=fail; b=ubTvv6zECIJ/zaEsbHCSwL01els7qEuu+WRZGFFbx71ctMj/iGHZCKFsuMyxJyFdlMsEo864hyjQS30AdPzPNEcqZaQYvtSbJt8Bklq6VyjAIyXXOJeP/NR/pRKMo+qAq8n3MipspVhH9NqI9G870gy2vh/VPJL6iwdF63dCaiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851015; c=relaxed/simple;
	bh=EJR5BQlUzfHa+xzRtpYq0TEfwkqrGKW6Fq4ZNkffZi4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iWf2ry880K1YGdDCARSKbWKgynWTMElKo+uSwyv5SZ1dSfKyM0jeWf+EEjf4FYQhaUpcEo+gH8ZqGPXYLabT9+nw+/TVw/5kUV5XSpE3Ja3Ur4AxO1QPnlRs69uGJ5XCHbj2WEvr1sFwFvvMAl1syHbt35JJLqb3E1dh+309nD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UF40NQ3V; arc=fail smtp.client-ip=40.107.101.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xg0HVka1MG9HTvzs/9WSfD6oCu4QGHg8cilDSqbXXyasQdkDT7v9yeW9RaWNOCujO78WCq2ehvVxFoplYoh/G1ERBDhEGTNYvaM/p1sowVksi9QbKoq8pfpkl9OYDB+lmUgUUk0OLkJ7YSlTWTzuu7oR+5wihkBB5dl8OXhusA6hwUY8OQNTlGn3reT2sBwNrF5pDS/pJhhDcG8xgw+idIz3AGikZkAmPgwVQKOOjfLif+jU0yvc0LFn4kxB4rAMJpuykYKDh+9Qe56c/XSYbZs72nz6VQWrRMVMdTdkP3mL2C447VCasmQjzWDCOHv8OT2iPvoNS0t8nJud60Lo1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVf++4ft1v1YaiS39iIkoicXhAjXdkxREPgTMynaSxA=;
 b=x6LglYiqvlvVQoTQnciG8un1pGHwYYOnDoJ9X5V16PKNhs9e1FaRTUhWnDycuxsj7eBjfDjus+YbhAp2DUvaeZC3yx/enNdxZ5WuwwWGH2lnESHluQyfsX0JzD89yO+Cv95pVctPmLOUDeRQzcoecC5EVvSDEFGKJaXpoYOvIqaRPeb98btKc3CvPMx1et6b279sQ8Ym/J+TtjBssI6fuSD/K0vkl9YjdLuOdP8dfZwb1GVaLpnYYOppZfDJsK3qh3nly10bFh0sQdYrWKoVU8BnEj+uIsMSNcBZ+tJJKxwYy1uWOeI7DQNEv6ep+PTLQfR5d+osZ0SH/8+OvPh2eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVf++4ft1v1YaiS39iIkoicXhAjXdkxREPgTMynaSxA=;
 b=UF40NQ3VEOlzru17XdNEQj2ep98RtS2/rNAUDqYjcFdeQMUGOWJhF0u26y2Ye7lz6G64Z6dMoD8DtIyIZV8LFbFRqlGmwyyTHyNpzMZcCfdEgS0Uq0Q3XgWcepMhQc62iPpbEx3aS31CC5MnQk7+P95uyjrMvg5K06+HCmHyLMpgQca4CkB4Phm2jRU/gZuh+PI6JzNn+yN7aTEJ+0tEOOtpn99dCM0Be97qEUlii7kRjufqO4HnIrEDZqItH4wmNm/YkO1j/xpnTOtgByDv/V503dMATnUtPrtaug1xVGnggzKEwEdTSDA2rhVsBXfDOW0VHqmXO5N9ku/aOAs/iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.23; Fri, 13 Jun 2025 21:43:30 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.8792.034; Fri, 13 Jun 2025
 21:43:30 +0000
Message-ID: <6ac192bd-e493-45f9-ba9b-12a81559c4cd@nvidia.com>
Date: Fri, 13 Jun 2025 14:43:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dmaengine: idxd: Expose DSA3.0 capabilities through
 sysfs
To: Yi Sun <yi.sun@intel.com>, dave.jiang@intel.com,
 vinicius.gomes@intel.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: gordon.jin@intel.com, anil.s.keshavamurthy@intel.com,
 philip.lantz@intel.com
References: <20250613161834.2912353-1-yi.sun@intel.com>
 <20250613161834.2912353-2-yi.sun@intel.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250613161834.2912353-2-yi.sun@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::19) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae27f0f-b2e9-49b2-00c5-08ddaac35661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bG01MjZHMkd0aXRoeFgvbGNaWXV2UWtYaWhrczh1ZHc4VHBXUzlmMTJya2hV?=
 =?utf-8?B?V2kyRVFhVDl6NXZoZGRVZFkrUE9TTk5MNHJzanlKT1Rkb2JjR29hVEVwMElm?=
 =?utf-8?B?UlF3TUZnQStkVXRmQlhFcmo3ZzdSN1ZNK04wczczT1pwS3B0Y0t4RFZITUhi?=
 =?utf-8?B?c2N6dllvUlhuQXNWeVdkUEtlelVUTmdZQmVqZ3VDWmk0YXBoRlRZVmtGMkI5?=
 =?utf-8?B?WnJkd2xISEFqNU5kZVFCbHNEZldVTTE3MWxESC9VTTE5TEJTK2xzSWFWYzd3?=
 =?utf-8?B?amhZcmx3QXZLb2dHczJSYkNuSnV6cEJzWTRJYXUwais3NlhFdEZWVU9tZjNr?=
 =?utf-8?B?b2F6ODF2bVNOR2k4SlFMSi9PTTZDUG5DaTAyMEVvaWdCZXZQaEJLcXQxaGtw?=
 =?utf-8?B?S2FJTmRneCtOSncySkFiOVFyaDZiblA0WmlNb3Y4UXZ5dmN5WnNkWUl6bTBx?=
 =?utf-8?B?TmwyN2FBdCt4bURDY0VtTjlwZkk2dVd5UVdvVjIrYjFWL0hXazVaczhQNkdP?=
 =?utf-8?B?NjU2V0gvRElVbjRPdXBnb0REUDFzd2I0SGJmREtTVGZ1YWN3emEra3lRU2dr?=
 =?utf-8?B?N2ZsZFB6eE5QK3ZhbTluUmlLc3VYRHYyMWtiTUR2ME5wOE5LM0NoS0liTTRY?=
 =?utf-8?B?NmY3V3BjSEgydnpZSkhGR3ZjWUZiWFRtazllNDRxMXVWd3NTdHcxRzZ0UVhx?=
 =?utf-8?B?NW9wVkZ2enBzbWxkWmRCZFBBejRXZVBWc2ZmNGVNbHlLTU9uZ1BaV2pIRm10?=
 =?utf-8?B?SUowaWJ6TmYwTWdYanAzM0lMWFhwRldodTllVUR2RGF3ZEJKZHFySGZZQmx3?=
 =?utf-8?B?MHNoeTZ1ek1Bcm9OMXIvajhVR0lMb3htWDgzb3NncEtmajhPV211SnFkTmZj?=
 =?utf-8?B?UnFJRGo5dkg1R24vUWxlajNmNnVsaldzWUNEODMvbVZrVFVTUWgrOUpjRjlV?=
 =?utf-8?B?eDE0ejNkUituRFc2ODBlOE16Mm1FTS91MHF3UnhNa283QmU0NkVsajVwTDNE?=
 =?utf-8?B?SHN1cks3c2MwdlVldUdGR1p2WHNSUElHNFJCZHNNR0UrQXhUMjhQY0lEcXBp?=
 =?utf-8?B?bUZLSng3Q3JtYlpPUXJyUlhSZ0hHektWT0pKUUlzOUxSSXZnRWZQdmVQUjU5?=
 =?utf-8?B?NWJCUmtpMjIrWWUxWlM0RnpWamd3VXBUUFVxM2tnUEMwMVNzMHp5SkR3elJ3?=
 =?utf-8?B?ejlranFNRWdLTmFpaHBITVNOejNuNkFONHJQZ1o3cnNnbnd1UE1pTExIRjRK?=
 =?utf-8?B?anE0T1lkZ3hQYmJQRjlpc3FvWFNYYjc4OUJWYVZrMlpENG9RVlNBa3hUcHkr?=
 =?utf-8?B?aXZTS0NTZmhYaXRZV1Zldk5CS0thd2pFWXAvd0M3aTFxN21BMnEyY2xuRDRZ?=
 =?utf-8?B?ZEx2M0RKdWQ2K2Nkd1djZkNQbTBqcVJ6eTEvODVJUFJVM2RzckcvVkNTekVv?=
 =?utf-8?B?REtxK1phc2RFUEgvTFNxUHBmdFFhQmx3cjcyZS9IV1RuSHg4QU51N1k2U2Uz?=
 =?utf-8?B?Z1Z0eEY3NmtLMDhFdkhUNUJLZDAvRDZOaGY4eEZjNVVhbFRQMTEwZS9FcVJG?=
 =?utf-8?B?RHloYnFjVkRwdE9XUVJrdGRGeUt2QmpOV25YUHg0bTZhdGNnUVNValpRdndO?=
 =?utf-8?B?elVwNkR5MkFjUHNKQ2x4QzVlSXVzRjhISGk3azNOYS9Sbzh4RkdidWZ6NWlG?=
 =?utf-8?B?YUwwSm82Z3NHMnRlaUc0Rk9UM2RReWYvNmxGMXhGLzZqZXBQTTRKUmJFSEQv?=
 =?utf-8?B?V3BUYnduNmVZcndxdk1hQzNMWGhYZXByOFgvOVJteDhncGVYZjVheXdVVHNQ?=
 =?utf-8?B?SUJnTWFYT3oyUmhCRWRSVStWR3lkYS9EVjlXVVdsT1FUZnVFRFVDOFB5NlAv?=
 =?utf-8?B?V3BuNk5kNGdTWkcySXJGbEZrOUg3cXpkTjlIUkpEcmNFVDhuZWU4UExiUjZV?=
 =?utf-8?Q?C/u83Tn6JYk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUwzaUJpYTlzc01sRFZDam5xaWVBZ3ZFVDBBaGQvUUQyc1lGaktwaUxpb21H?=
 =?utf-8?B?dWdGQ0svdjUyb0tYMzdmVnFTNGl5bjAvamxRT2RuNFZJVUJvdXlLRG4zQ1NN?=
 =?utf-8?B?Z2M4WHFqc2RBd3ZCTmdlZmNWbXVZN1psQm1FbkhVek9LMEh3V3g1OFdGc29y?=
 =?utf-8?B?QkpTVUcrVXdqWUQ0VnE4UzAyNmRWUGFzS2pHZlJ2c1pTVUFkOVBpVk1PT3BF?=
 =?utf-8?B?TFRLZUpwWVVQKzByanRYTUlubHBJMGVOSDhRVEFTMWxodzRhcUh4Q1pTMFQ4?=
 =?utf-8?B?QUJ5QVFMYmd2cmk5dHZtOU15THZsVkhlckM3bm1ycHkzSFhZNUZuTHBuRDM5?=
 =?utf-8?B?WEN0MFdzalk0dHNDd2s5MkxZdlBwd05DQ3ZmUVZGQjJYUmVUQzdrWnZkYTRv?=
 =?utf-8?B?RFVCOU9hUXFSZHBxbXZuVnJHK0tVSlpnM2VlRlkzaVRHN1dGUFd0MXM1VUJm?=
 =?utf-8?B?clh1WmVFc2NHaWhzRkFlUE9sa0Y0TWhnTlQvMGhGemdaWXlGMjhWNmhWVENa?=
 =?utf-8?B?UUFnblpsc3ZQWnA5SkFKeFppaE5ldy9hT0pKMjUzOUU1NDNQL1JHY2lqd2k0?=
 =?utf-8?B?VE5zdEtnZkt6WTc2dmdYK25SQnhCQW9ZaUJVV0wxMmJmOXliZE5mRzVvUVFD?=
 =?utf-8?B?L1FsbG5pdGh1MXgwY2JMWVVYSm1vYkhkK3E3eVJvQi9SUVNQUHkvOFdYdHgr?=
 =?utf-8?B?UUExaXY1UThNSlRwUi81NVU3UEZGVXVCL3hTa2g3SDJDSnZpTkJlME1HYTln?=
 =?utf-8?B?aDMybUJwSk9sekZ2VFV5YmVlS2dVRlA5dzNmY0FCb3g1OGFhbFE0TVNvQXlp?=
 =?utf-8?B?SmVOdlpWbVRtdXlCNG9IU2k4TW1zaGs0Q3p4WnlORExHSGhyTWhFcmRFQ0Yr?=
 =?utf-8?B?YVpDekxTa1pVRU40RlowU0JzV2JBcW9vczRpcnVlRDhhdG1yT0kzSHRXTGdC?=
 =?utf-8?B?WURhNTN2OTlVaEduN3dCVHgrK1hGUFl6cUt6WWdRcmRJa3kzZ05HTWV1Mmdu?=
 =?utf-8?B?ZDJUaXFRWTVSeldESmhwYURhSU1WRE9FTEllRkR3dytyeFlYUDhzZHd5UEEw?=
 =?utf-8?B?VUNRUGJqZ1lDUko0TU50N0E0SXFxb1hNak5qeWt2OUFGL2ZRZ2tGZWJNY3hW?=
 =?utf-8?B?MkgyUUhDc1hEQkxpaHZTbHY0VkhTUTJ3aTgraCtaR0lydGp0QmNZdkpHNmMv?=
 =?utf-8?B?Qnd5L1psMTNNenRWdUYwazQyU1prYWQ1a21UWDN1Wk1ndGVydkx1dkRxTnZ6?=
 =?utf-8?B?elkyaWlaM1FJZUo4YXkxM1J6eS82OXV0cXViaDRIN05iNXNqZFBWN3NSQkNr?=
 =?utf-8?B?QjFlbmhNeVNMb2RxSEthUm5uWFprOFFhamxldFNqK1FzbDFJTFcrODdiNjI2?=
 =?utf-8?B?VVNQTTNSZEhjVTJrUi82K2hybDlDTkFLY044dXVWUEtTbUErdk80bUUrYUlk?=
 =?utf-8?B?TStQZm1YSk02MVdZMEpDbUVxaVVqTjNqOStWQlZFbFYwMWZtb2RpZDFxT1RO?=
 =?utf-8?B?a3c4ZE5zNWptTFQ0ZWg1T3N0WlJRMG5NdE55VHIzaWxVM3hRVXZEcEtDZ3dX?=
 =?utf-8?B?OG9RZmZKVld6aVYyRkZrTDloSHRqZzBjTkxQTHpLM1NGVytRbllaZnFOQXFS?=
 =?utf-8?B?ZWUxU0UvaDVjeXBVNjg0eDdLTEVHZFk4M2I3V2lWQXBGb0VuS3VHL2xvUGor?=
 =?utf-8?B?Y045K21NUXVqUzNKSEN1eGQrbytYYTNmRUFKWGtIOW5lbmZvL1dMS0NQRThJ?=
 =?utf-8?B?T2NJamRzZGVRekpMMjdZWXFBMjlQeC9CZDVjOU9mczZMTHoxRWRNdTYyTDZU?=
 =?utf-8?B?OGs5cVk5cVZQOFV3RzhHeXpnQkpGNXBPSlB2c3VFNDBXV1VLSzEzVFFEbk9x?=
 =?utf-8?B?cUVGeWRiUDhOQzYxYloycHlmRlIwUk9WTk1kbUpOSFNhd01DelBCOXBoU3RJ?=
 =?utf-8?B?UndjdTQrWUY1Y204Y0E3NGZDd283anc1WGpoRE9EaGt6MWMyY041RVIwcEYw?=
 =?utf-8?B?dm82Z3VCSnQxTGNJVitOVWRQazJ4VEpsakxDSXlSbG1zekNYYVJpSW1tQloy?=
 =?utf-8?B?MlM2NG80NklBSnQyUndQRWxFa3dGUTNPSnRWUS9lRm5qR29zZFQrdThaS3Uw?=
 =?utf-8?Q?jr2CHESqBc2AHyO815uUn0+xo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae27f0f-b2e9-49b2-00c5-08ddaac35661
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:43:30.3902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uN/nfDpkoe43DeQMhzB0DbxN/4+LQY8EiJj9z+75oAsMLuxOZSHa/GB/Q9Eomx/TvUWrJ8rnDPrpI98TugD6+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242

Hi, Yi,

On 6/13/25 09:18, Yi Sun wrote:
> Introduce sysfs interfaces for 3 new Data Streaming Accelerator (DSA)
> capability registers (dsacap0-2) to enable userspace awareness of hardware
> features in DSA version 3 and later devices.
>
> Userspace components (e.g. configure libraries, workload Apps) require this
> information to:
> 1. Select optimal data transfer strategies based on SGL capabilities
> 2. Enable hardware-specific optimizations for floating-point operations
> 3. Configure memory operations with proper numerical handling
> 4. Verify compute operation compatibility before submitting jobs
>
> The output consists of values from the three dsacap registers, concatenated
> in order and separated by commas.
>
> Example:
> cat /sys/bus/dsa/devices/dsa0/dsacap
>   0014000e000007aa,00fa01ff01ff03ff,000000000000f18d
>
> Signed-off-by: Yi Sun <yi.sun@intel.com>
> Co-developed-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>
> diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
> index 4a355e6747ae..f9568ea52b2f 100644
> --- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
> +++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
> @@ -136,6 +136,21 @@ Description:	The last executed device administrative command's status/error.
>   		Also last configuration error overloaded.
>   		Writing to it will clear the status.
>   
> +What:		/sys/bus/dsa/devices/dsa<m>/dsacap

Since 3 dsa caps are shown together, it's better to change this ABI name 
to "dsacaps"?

> +Date:		June 1, 2025
> +KernelVersion:	6.17.0
> +Contact:	dmaengine@vger.kernel.org
> +Description:	The DSA3 specification introduces three new capability
> +		registers: dsacap[0-2]. User components (e.g., configuration
> +		libraries and workload applications) require this information
> +		to properly utilize the DSA3 features.
> +		This includes SGL capability support, Enabling hardware-specific
> +		optimizations, Configuring memory, etc.
> +		The output consists of values from the three dsacap registers,
> +		concatenated in order and separated by commas.
> +		This attribute should only be visible on DSA devices of version
> +		3 or later.
> +

It's better to document the "order" of the output of the caps. So apps 
can parse the caps. Something like:

"The output format is <dsacap2>,<dsacap1>,<dsacap0> where each DSA cap 
value is a 64 bit hex value."

>   What:		/sys/bus/dsa/devices/dsa<m>/iaa_cap
>   Date:		Sept 14, 2022
>   KernelVersion: 6.0.0
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 74e6695881e6..cc0a3fe1c957 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -252,6 +252,9 @@ struct idxd_hw {
>   	struct opcap opcap;
>   	u32 cmd_cap;
>   	union iaa_cap_reg iaa_cap;
> +	union dsacap0_reg dsacap0;
> +	union dsacap1_reg dsacap1;
> +	union dsacap2_reg dsacap2;
>   };
>   
>   enum idxd_device_state {
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 80355d03004d..cc8203320d40 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -582,6 +582,10 @@ static void idxd_read_caps(struct idxd_device *idxd)
>   	}
>   	multi_u64_to_bmap(idxd->opcap_bmap, &idxd->hw.opcap.bits[0], 4);
>   
> +	idxd->hw.dsacap0.bits = ioread64(idxd->reg_base + IDXD_DSACAP0_OFFSET);
> +	idxd->hw.dsacap1.bits = ioread64(idxd->reg_base + IDXD_DSACAP1_OFFSET);
> +	idxd->hw.dsacap2.bits = ioread64(idxd->reg_base + IDXD_DSACAP2_OFFSET);
> +
>   	/* read iaa cap */
>   	if (idxd->data->type == IDXD_TYPE_IAX && idxd->hw.version >= DEVICE_VERSION_2)
>   		idxd->hw.iaa_cap.bits = ioread64(idxd->reg_base + IDXD_IAACAP_OFFSET);
> diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
> index 006ba206ab1b..45485ecd7bb6 100644
> --- a/drivers/dma/idxd/registers.h
> +++ b/drivers/dma/idxd/registers.h
> @@ -13,6 +13,7 @@
>   
>   #define DEVICE_VERSION_1		0x100
>   #define DEVICE_VERSION_2		0x200
> +#define DEVICE_VERSION_3		0x300
>   
>   #define IDXD_MMIO_BAR		0
>   #define IDXD_WQ_BAR		2
> @@ -582,6 +583,21 @@ union evl_status_reg {
>   	u64 bits;
>   } __packed;
>   
> +#define IDXD_DSACAP0_OFFSET		0x180
> +union dsacap0_reg {
> +	u64 bits;
> +};
I forgot the format of dsacap. Is there any field in each dsa cap 
register? If yes, better to add a structure inside to describe the fields.
> +
> +#define IDXD_DSACAP1_OFFSET		0x188
> +union dsacap1_reg {
> +	u64 bits;
> +};
> +
> +#define IDXD_DSACAP2_OFFSET		0x190
> +union dsacap2_reg {
> +	u64 bits;
> +};
> +
>   #define IDXD_MAX_BATCH_IDENT	256
>   
>   struct __evl_entry {
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 9f0701021af0..624b7d1b193f 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -1713,6 +1713,21 @@ static ssize_t event_log_size_store(struct device *dev,
>   }
>   static DEVICE_ATTR_RW(event_log_size);
>   
> +static ssize_t dsacap_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	struct idxd_device *idxd = confdev_to_idxd(dev);
> +
> +	return sysfs_emit(buf, "%08x,%08x,%08x,%08x,%08x,%08x\n",
> +			  upper_32_bits(idxd->hw.dsacap0.bits),
> +			  lower_32_bits(idxd->hw.dsacap0.bits),
> +			  upper_32_bits(idxd->hw.dsacap1.bits),
> +			  lower_32_bits(idxd->hw.dsacap1.bits),
> +			  upper_32_bits(idxd->hw.dsacap2.bits),
> +			  lower_32_bits(idxd->hw.dsacap2.bits));

The output format of this sysfs_emit() doesn't match the format in your 
earlier example:

cat /sys/bus/dsa/devices/dsa0/dsacap
  0014000e000007aa,00fa01ff01ff03ff,000000000000f18d


And this sysfs_emit() is too complex and can be simplified as well.

So it might be changed to this?

+	return sysfs_emit(buf, "%016llx,%016llx,%016llx\n",
+			  (u64)idxd->hw.dsacap0.bits,
+			  (u64)idxd->hw.dsacap1.bits,
+			  (u64)idxd->hw.dsacap2.bits);

> +}
> +static DEVICE_ATTR_RO(dsacap);

Since 3 dsa caps are shown together, do you need to change the ABI name 
to "dsacaps" instead of "dsacap"?


> +
>   static bool idxd_device_attr_max_batch_size_invisible(struct attribute *attr,
>   						      struct idxd_device *idxd)
>   {
> @@ -1750,6 +1765,14 @@ static bool idxd_device_attr_event_log_size_invisible(struct attribute *attr,
>   		!idxd->hw.gen_cap.evl_support);
>   }
>   
> +static bool idxd_device_attr_dsacap_invisible(struct attribute *attr,
> +					      struct idxd_device *idxd)
> +{
> +	return attr == &dev_attr_dsacap.attr &&
> +		(idxd->data->type != IDXD_TYPE_DSA ||
> +		idxd->hw.version < DEVICE_VERSION_3);
> +}
> +
>   static umode_t idxd_device_attr_visible(struct kobject *kobj,
>   					struct attribute *attr, int n)
>   {
> @@ -1768,6 +1791,9 @@ static umode_t idxd_device_attr_visible(struct kobject *kobj,
>   	if (idxd_device_attr_event_log_size_invisible(attr, idxd))
>   		return 0;
>   
> +	if (idxd_device_attr_dsacap_invisible(attr, idxd))
> +		return 0;
> +
>   	return attr->mode;
>   }
>   
> @@ -1795,6 +1821,7 @@ static struct attribute *idxd_device_attributes[] = {
>   	&dev_attr_cmd_status.attr,
>   	&dev_attr_iaa_cap.attr,
>   	&dev_attr_event_log_size.attr,
> +	&dev_attr_dsacap.attr,
>   	NULL,
>   };
>   

Thanks.

-Fenghua


