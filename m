Return-Path: <dmaengine+bounces-9618-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAwxKE1swmmncwQAu9opvQ
	(envelope-from <dmaengine+bounces-9618-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 11:49:49 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 43175306B8E
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 11:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BB823046E9B
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 10:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D59D3E274B;
	Tue, 24 Mar 2026 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BNIxsw6V"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3615934DB6B;
	Tue, 24 Mar 2026 10:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349275; cv=fail; b=n+HiooMMy6UMlrl+/qlbW2q+FwQGCNTK9Q3/T4nMxEfnfsaM3N+cCEPJYX/zZXUm7fs0wAE19bomxfq8kH5e1Dge2QumX4rBSlPcCwI0TrA2MQMzULLEhurhGyY4omsTb6PxlRxjq3fSyRSrcZ9aL1f75qgSbzZjZGXvlMDspyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349275; c=relaxed/simple;
	bh=KMjsMX5fVfRMtFuPPKoAIKYYTB3tLfoPINeIGSO5wxM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=URLWE2pYClvzGWSlwZGwUbBaRjr8IM+BSoRRgBYrDWJ/dhsxHz7f6llY923zkNRXghPAbbVnCYawVi047AIgrt5UZ0wQGoULbhUJnzrclG187EuiiJTwDrEQ2moZ1w0IiD2j2flmi6FWxLxqd1Pr1eujqG8uW+Se58sEQBWRkKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BNIxsw6V; arc=fail smtp.client-ip=52.101.56.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7MzUWAW2SeAwev1V0hG8B3IK7npn/7ARCTS++QIB35GlKTRaHGMpbapwjX08tPkbD0tj6yS3fs1oC7wL/0iKNmm4iTt6wyC3SxXe5MxH2G37pBYDSbGpMiA/ych9fFKqeHV15QXJ8qejif9fSBW8yPRSkaunI624flJqMLhB/ifH7GE97K5Iw2qlB97ff1ZtDrEiuGb/T7HNlvXnS/Lu2navDYzNEhdDYodqHwTfftVDsHWUaz+km8X0BTj6iPShlGufCuaFs9CcHah+yu5YEZPeGG8pfjRKcmYDUFvnl2CTMbCRBOp39uPZd6ApPDd8SdppesuSUYELV1o54a4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGV5BtqQo5fZS9ZUeriCQ+dO7SmJpVg7PXNr7h4sf9k=;
 b=c7mxtsGjVg3Q4kwRgG3o+1fLReklRh3DrpMFuyIVGMBK+oG+bjNUMyMebVFwKoUg2D4QsC9DyAlTd+TgwKwk7iEI/5WdcEZLNuXwtiSUs67H+I5NUGgh5RReTI4T3CsoiQ7/Or6RMJlTgD0bWL8BofzGj0qVX6ixTwvqUnw7NrtssR8Pya8nEe1MEST078H1WGk8yORq8jggqlZ8UoLfA2W+BXJPZ8Okf7zmRIW9x7FUn1hzOXOaD/vc8A/KkDSnfNliTmm27rMlfjAyFwDunXJDrNg5FdUtAHUy9Fei2/6ZrNzxgrbUclJwuItpoJVHwPdH17TlORjmcftoe6CX8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGV5BtqQo5fZS9ZUeriCQ+dO7SmJpVg7PXNr7h4sf9k=;
 b=BNIxsw6VQl0pNU+3UhO0WAMLDEHWG2rWiwehW974VpuHYUuVHyS+JKAVy5w5CpSw/+neussEggQrj+bizw4wC+D5IWuftJ9pa0z4tGhFKrY4npbTy8zF6trZoM6w+hYQsnTbLd1xFqG/xnx8/FWwXVeU1HGhaVhWqEG5oHp3yU5jlgevNZkXizVU45tiIUeEprkEcAtkdT9UmwRy3lRUGxY9EIg1IE8VWHOajPalQxEe5HPB43fd/OEv9RnChcwHyuaujYRnvcpVthnXrALN9//fWhgxiOTmTXspcCHGR5MszeuAKFVqkhL8QPImiwg2VqBKwongR4QNvzml9Q2IBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Tue, 24 Mar
 2026 10:47:50 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 10:47:50 +0000
Message-ID: <55dc0957-fdc5-4821-891d-76df677ca94f@nvidia.com>
Date: Tue, 24 Mar 2026 10:47:45 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] dt-bindings: dma: nvidia,tegra186-gpc-dma: Make
 reset optional
To: Akhil R <akhilrajeev@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260316171823.61800-1-akhilrajeev@nvidia.com>
 <20260316171823.61800-3-akhilrajeev@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260316171823.61800-3-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0289.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::13) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|SA0PR12MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: be76ffcd-f730-4d79-b11c-08de8992cb8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	wBKTfOcOg5ldCLVhQX4jlPUVRNuA6RswGgQTOztEdJdlrYtFRqjCGQkA+tTg2J6xQ5vmAMVnZGRIoiyhdh7dtXsdO8nK6sNSbyiG7vgH/3wH3pw0ADJsWMQ4L0VBOgJzYQppf1SVzjK9rk/NbKNisigbb11xKuHbUVIAW9mmyVDRWwqIPCGe/GiCqIu43UVPrNoq9BqXuhJCfcbHbQsB1DtW5tQefukakoaOmctdLY0FEey8EwttbWWS1KRb+N3Shf63g1O+v72iqyQ11+M9VNwv/DgVPKthbdL/SX1P8RObYSyfEAtQO8BGoNrWazvwQbejmYKLBxo51aU8v8T2uCS6KROExQsxv+InmcdNm3h3wH1EtXzXTVU58YqaH3lEZrpzRlV+NVHcHV1CNn4taNBLHTswlRoUsSCuoQ/fRcuSly41TfnY8nz9TEay6Z1kokHt9VoCXXohH58eBYD14fdPP5bVpCFNBJx7dRncg5VknNjwg62LbgdW1RUFfP+DXC1sFWXTQfndG5U0mWHzV7v89CiHPlFXn3wgT3vA1AZ/kiqX+DBv0gvwud6JGf2RcLdWdeUHbWoTtriiT1xPBGaX0zwf836S+BYlYjy62gMiTIyTobIT9OSmmoQUnmTEEDL0adigsYx5eHXhv/FiklB9WxaRsvYxCA/8dL0Dm+wAoMGkqp/qc7vGzYgdM+nBIznwn3Xnl7XcnVkFi153e+87O9saFuowS7jBjfV/a9u3mU68D3KTDj49EF4SDGWnM37rsKI6diPSaLRxhjVbDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEhXWXRleGpDTVZpazF5Y283OGF0UGN5TWo5NW5nT2lJQ0YyVTkwYVA4TjhV?=
 =?utf-8?B?dVJGUFRzYTBpT1FpV0ZjbUJCeHlpY092QjNRUWJXeUk5a0JyT3hmQW1ubVpu?=
 =?utf-8?B?M0NRTytkSWF0RkIyZWppNjBPRlQrQURjUndHT3hBUithM0htSFA0N2lLUmJK?=
 =?utf-8?B?alpya2h0MjRzNnZjdExyUURDRDhXMVZtZ3c1U3l3eDNHaWVmcXNxSnBJd1BV?=
 =?utf-8?B?MXZScGI1WVNqQlVsSWl5UXhJN0ZrNkE2cGtaejNPaGl0OUc5Tkk0emdXekZr?=
 =?utf-8?B?KzVwSU5IYVFkb2E4WFpvc2tnRjNob2luVThiN1pHaUk5VVRIbEpFSVFGdzlX?=
 =?utf-8?B?YzliS21EZXBkTitUSDJWWEFQSEo1Sk5vQWN3eGFnNVY0WUV1SnlQSHhpbDF0?=
 =?utf-8?B?czFjd3JubzcvRjZTYjdobHg4ZXhsUTZ3cnZXR1dhNzhneTZ6d1ZQQzBmRnNK?=
 =?utf-8?B?WnpMQmtDd1g5RkhHT2J1TjgrNnlYSWluWThtUzBNa0NzWURybU5FTHNFVEVl?=
 =?utf-8?B?UDg4RDZGSlQ0TzRtRFhCQlZnRTZ2QW5FemVuRWlQSnM2czdEOUd1R3JGQ0hx?=
 =?utf-8?B?d2tkN29sZjZnenNmZFB2YXlHbDhYQkNQSTdheWhYS0VCTTFGaVdkMVppT1k1?=
 =?utf-8?B?T1V2NlpyUEZTcVREOThkditDcm1OU2xTbXQ5a1hjSE1DaE1vVnB2cDhoYmJm?=
 =?utf-8?B?dWFMeXN5MW5zODFKbngvYlkxeFJRTjduaitYcUIyaG5hTkRjMjh6amxmVENp?=
 =?utf-8?B?RExIbUt3M2p6ZS9DTm1LWlNnMmZaWVdvd0F3MlpGZmtZYXNUWnlsTy81anhV?=
 =?utf-8?B?aWpteENmUG5BZG9pMm1xc1g1RGhkZVp1d1dKcm5yb2tPQllDSzRiZjV1di9S?=
 =?utf-8?B?bmxMaUNGWUhHU29QY0NXRjlSM3hEQ2x3ekhIVHBJaDJKeHBvYWFPOURDNzZt?=
 =?utf-8?B?eEZzUlR2ckVmc1BiYm0ycE1yK2hOdXVwUzkrK3l2VnhvUFBqT1VIcWhxRFR4?=
 =?utf-8?B?VGpuQVBoS0RGeHozODE3aFBnb1BNUzRLd0VCZzIxRVIyTjhxdDlUZno5NFll?=
 =?utf-8?B?aVFzNVVFa1pLTDhGSzBvRWZuZnFQcmErNk1icjliQ293eHJ1ZjF3RWs5S0xr?=
 =?utf-8?B?ZWZVSXQrVlJ4R3lKVG1tZnNORTd6VSt1elFpVjRYL0p3R2dUbjNWM0NRdUhm?=
 =?utf-8?B?ZmVod1FndXV6cXBvNWthTHEvY0dxenRaOUhQdjdYaWZiL3V3RXIyNmJMWTdP?=
 =?utf-8?B?MVcvVDFaTmxFSTRSWW5lWUZmTzBOQmhvYzFXcERzSmRxNWxwc3RZbXNkYTQy?=
 =?utf-8?B?cU5oWGFFVEUvQVhpQTVwOFpHaDNwMXY3SVNQYlFBbmFZUVJqeW42OWw5eE1z?=
 =?utf-8?B?d2h5MnRMZ3BrdUIvMG1OYTZHOW9tREZwUWVHVDlQR1pWMk9qekZJNDdMd2tY?=
 =?utf-8?B?V3hDNGk1cTVRZkVSUWhMMWdyNGhhTWQ1cGhjdWFzREdFWCtMZmVQZVd5cFJB?=
 =?utf-8?B?enp6aktnMVh4UU9uTzd2SzFvT0dQb0FCT3hNRGl3ZDYydlhKOSs1dHRscHZp?=
 =?utf-8?B?TVZOaVNZRFpnMTJmUnFobnd3N0FsY3AvUzExQzJKN2dneDZva2RLcm00aGxs?=
 =?utf-8?B?QXdPWUpraTVsWXRGMlhxUFhycnVPNTdOYW1kVFdSb1JRcEFRVkVOTWUvRlh6?=
 =?utf-8?B?K204RnNkdEt3TXhsdmRzWnBXYy9KNlpMU0VSakRTRjNocDJZcElnc3JLSFNs?=
 =?utf-8?B?eDlSVEsyaGJ4V2UrV1lxaFVqKzBiR2ZCRk1tYkIzb1pNUEowSXJKak5BWEpZ?=
 =?utf-8?B?V2dxRDMrSUVrYjFZUTR3UEh3NEE2dVg0MVJxamQvUG0zUm9uam1DNWljUE15?=
 =?utf-8?B?QUVJM01jc0IvaUZ6UVRqWlJTalovVTd4UUdvUFVtTmZEd3ZXd282TFFhNzdU?=
 =?utf-8?B?QmpFU3JjaVhiSEdXaXNIUlZJQlNyMUp4aW81VS93dThjZnlVaTFjQkhKMjdk?=
 =?utf-8?B?Y0xmaldlQmxMWTV4S1d2RjhsVUNXcFViejdUWjF3djhvcWtUVE9tU2FNdGhE?=
 =?utf-8?B?eTRCaXFSUE8rRVhQUGZCWEFYVUI1SkpVT21vRXEyQ1o1Yy8zNWFjOUlJZWVl?=
 =?utf-8?B?WEovanVoZ3VFeHdhVXdNT1daMG1zMFNmLzdQbUxZcERTZjVjOG4xdkF2NGpG?=
 =?utf-8?B?TzhpeEo4eWw2Q3VKd0o0VjZDZUZpQjZnOVltT0srNVZ2K1pSL1NFSUFOYW1h?=
 =?utf-8?B?KzZDcHZaMnZTMzRzWTBoNXAyOFZlZWpGTkZpRXBzcS80NFNhTHBYTXFaanpG?=
 =?utf-8?B?a3BQQ3RDb1IvbHhBb3kyRllobmVtMGJxbjdTRktJTERzMW1oMGRqZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be76ffcd-f730-4d79-b11c-08de8992cb8d
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 10:47:50.7339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6SuXebERZoUy6A39dYi2n3OWN9sezyPLtGZ48hvV6wYEr6Gz3gHZOOW+is5GQS+X0UFlUvJ1sAhtTJAp0U8RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9618-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43175306B8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 16/03/2026 17:18, Akhil R wrote:
> On Tegra264, GPCDMA reset control is not exposed to Linux and is handled
> by the boot firmware.
> 
> Although the reset was not exposed in Tegra234 as well, the firmware
> supported a dummy reset which just returns success on reset without doing
> an actual reset. This is also not supported in Tegra264. Therefore mark
> 'reset' and 'reset-names' properties as required only for devices prior
> to Tegra264.
> 
> This also necessitates that the Tegra264 compatible be standalone and
> cannot have the fallback compatible of Tegra186. Since there is no
> functional impact, we keep reset as required for Tegra234 to avoid
> breaking the ABI.
> 

This is a fix for Tegra264 and so having a fixes tag here seems appropriate.

> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   .../bindings/dma/nvidia,tegra186-gpc-dma.yaml | 25 +++++++++++++------
>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> index b5d8fd0b281d..b849d4cc2901 100644
> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> @@ -16,16 +16,14 @@ maintainers:
>     - Rajesh Gumasta <rgumasta@nvidia.com>
>     - Akhil R <akhilrajeev@nvidia.com>
>   
> -allOf:
> -  - $ref: dma-controller.yaml#
> -
>   properties:
>     compatible:
>       oneOf:
> -      - const: nvidia,tegra186-gpcdma
> +      - enum:
> +          - nvidia,tegra264-gpcdma
> +          - nvidia,tegra186-gpcdma
>         - items:
>             - enum:
> -              - nvidia,tegra264-gpcdma
>                 - nvidia,tegra234-gpcdma
>                 - nvidia,tegra194-gpcdma
>             - const: nvidia,tegra186-gpcdma
> @@ -69,12 +67,25 @@ required:
>     - compatible
>     - reg
>     - interrupts
> -  - resets
> -  - reset-names
>     - "#dma-cells"
>     - iommus
>     - dma-channel-mask
>   
> +allOf:
> +  - $ref: dma-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra186-gpcdma
> +              - nvidia,tegra194-gpcdma
> +              - nvidia,tegra234-gpcdma
> +    then:
> +      required:
> +        - resets
> +        - reset-names
> +
>   additionalProperties: false
>   
>   examples:

-- 
nvpublic


