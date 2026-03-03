Return-Path: <dmaengine+bounces-9220-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDh5JC7ipmlAYgAAu9opvQ
	(envelope-from <dmaengine+bounces-9220-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 14:29:18 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6891F03CA
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 14:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71A3C302B76A
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2026 13:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D637A425CFF;
	Tue,  3 Mar 2026 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ajf7agc5"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013010.outbound.protection.outlook.com [40.107.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D83335543;
	Tue,  3 Mar 2026 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544432; cv=fail; b=aX65/wZmiI4Mv2X8aJ0Lpg95W2ZYdC7OuWm+xFS1QgDwPVVdxwVL/ZOoiiuNyUfl06YlTvk6F0sH52NmDYgTupJKuO9g48i0ggh+uchxY8YRIvpa5JPRldw2RNpgK/BY3mvgSlX7iOlCbT6iXI97qn3mxvpK+eUFoOcjiDOwGQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544432; c=relaxed/simple;
	bh=Z0O5f6iz5wSJ1rkGmylAiyRQsfMkuHv3YlVGrFZ/GUU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZtftOKKwtTlRbEW2QXQIZd2Ie4I120CsfmiV+wEsEQIzPe7Ae9EkMYciDbqJzhfHdPW7xa+R49At7tp3L/+Swcp6s9AT/e90bQjHaptbubuTHR8nFbImScPxxMz9xBr2zoSTOruCccZSM6NqRU61IQkqcQb23xbbNpt/7d6yn8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ajf7agc5; arc=fail smtp.client-ip=40.107.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgF24U2MisnIAtqxDxsh9rK5uVaYMpW6YTNloR565vsjgQ38bOcTXBQ6Q4qnsVmWdbn3l3kZudA/CvoKQ/Pp/lH7m5hHCLYr+LZ42W1Jdjd8kLOEzWrafzo4Uix26fF1K1Gi8tzx8j9L+S5hy38vtET/ro9nJi1bJ2UE5yHAb0XCu4lSU7bOoKPtoaZtEW8TdaY9jVtt4vPRInFyNuVdy3tdysdkrU1zIshH6mmlZaopc3p0ERASbXp8sLO82uHtyc6eqIQnPgazwRaF6id6Hy53gVFfMgPrbQTkJ8kZ4ryF4TrUkeb2nsT2hRCNaBXTlGzAzwcPHzQIC6WCXJHrug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VRhy2mW9gAFNAyM4o1fyPnvElBjaKHNwBYQGkhbdkI=;
 b=P4MXS3R2Y70ngMFJxh78qOx3IktoM+NnaTNgjnaFQl+jRSUZHgjOq5N8bQB8mZST34JhWHHv0xYpdQqd6EdrjOBDOWyR473n16EWuvKJIe/47bywSjI/Yj0QmYLLiBxW3ehzoaxA7o756utbCuYRxJ9MuQdCVEGkSdrjEYPy7FohS/aL99fAYXOA19P3XOxiURCwLhg54u+mVqJvXqesDWotWUjpwyWU+lXxcLYXPaSknPZ/sRujWH0tkRNbmSav12Dl332IgddpfUhI7y2OApzemV6U9TGdrQBu926G535BE03M5AZSWI1dSJ9b8MtHBGE5G00ePGYgejpZld6ZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VRhy2mW9gAFNAyM4o1fyPnvElBjaKHNwBYQGkhbdkI=;
 b=Ajf7agc5kb+vN5kIkyhPkunJb8W4GrF5WWhN+57gQK3JYkTQ1x8b9yq11Qbjc/QCjMaW8SuMeCxF9anX3CHVHaxaDXFGGT/0NVGh/rYpThUrAqts6tXiRGTuC+WGelTHEYUsKxXBZzsRu86p5oaKTtoyvpBzD2EFBTDIq3T51NRmztH/nG8099ST8NL4YCuHjDcWTaUcFzNSgsIUJYY+ppbJGtdskBYU4JPeAS/1t1rdrxumwWAU9BcALiee1NyaiYpsk1P20xlikw6aXza9icT3+QUL5R17Rs9mEKqI9Dca5V9kWoQSWKVrZcd6GqM6miMAqaoHj6DicYmoqy6cfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Tue, 3 Mar
 2026 13:27:05 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 13:27:05 +0000
Message-ID: <07e3d954-cd05-432c-bd6b-485f556b7c8f@nvidia.com>
Date: Tue, 3 Mar 2026 13:27:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] dt-bindings: dma: nvidia,tegra186-gpc-dma: Make
 reset optional
To: Frank Li <Frank.li@nxp.com>, Akhil R <akhilrajeev@nvidia.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260302123239.68441-1-akhilrajeev@nvidia.com>
 <20260302123239.68441-3-akhilrajeev@nvidia.com>
 <aaXziOMaW6hWCbsx@lizhi-Precision-Tower-5810>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <aaXziOMaW6hWCbsx@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0104.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::19) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: d31b6c5e-87ef-4d86-39a6-08de7928901d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	ovG5pOhfixVwaqQ3zS36DWl6bXsvPqMz4H++5wJCypxl08neTzziF3a9sTbJ7td7XgenIJ4KsaRuo+Z9wCKg6y9gaTkaxV2tpZHdz88eIoxSOEUxkO8weVYmvnZwwOIVC9rxE68u9dIN1Too5pn1kwmpQ6r4fFbpNQo+2x+og5xev7d4Fye3gVweVvb92QKgOwPKHlZa8NOtPJIuqXJz06zJZlkIWR1oC4cqk1bXy14coEgQmomtUF6CSHRJgz4gzABMZ39m9zCYrYJZJHmGKbrlzg4J1NOU6yXVludr4fMMejZFWqaWsTZzsJymeohjlNq9d7FaxrqIxbN3Nrrn8jYfBIrtk5llJS9IF8MsiyeUi1AAtMDKC/j8FXTnFM+r0OfHBGjn9Lkb+SXJhn9t0IOL6tm6ViNArspo7mUi7H0eo7D29qQZxrA5iXGBMXhnCipJZBIA9G/zFlhR3Ts0Of9+FUyxwi89daw2zQ0xrmXdPmSTKgjtioDJ8SXVcjMIRlQyWJ1DN+dz0nWDhjNb/ovfXnGJkpVX/8FQst1OQtiUhE6CFp9WeXnAFcFGT1VKHkX9+TnOvz6wGQVZP+XFeJzkzh2+f/yZAbHubvBgWopRTW7mvnHDQZhWQIaSj3Wnpe9SoX9NEpXcao/BOinwsr2azPtOK30UWGYxzapaAxNCOmwsPjDAMGUEz1CWetD22S4yzxhG+iW2TPX6XtLPhJcG/COXV0sdYNmcPnAQExg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXRPYTZhdnNsUEhKcDdVajJDb0JLZjVhc0E5K1ZmNTNLZVFDNnUwempEQVp1?=
 =?utf-8?B?K3pCU0RFa3VmQVZ2R25jZzNFSFhFcFpWSFZRMWFUZEdYSU9VVzBGNXhLeVBX?=
 =?utf-8?B?Y3VtZTBWazZyODlIa0hxZmRHeUNxcVU5TEZWUFlrblErR01hNWoyS3NTREZy?=
 =?utf-8?B?N1Vvczh1ZGgvUW9ZY0d1WENxcm5nRVNYOG4xN3MybTdjRlRjWkRPczkzN0kw?=
 =?utf-8?B?WU5ERUxkdW9SWWRHckVKdEl6RlE0VmRCdkRVbTc1cFVrV2I1Rkl4K2swRnhT?=
 =?utf-8?B?Q0ZyeEVmRG4zOHd3cXFpNGdVUGtZQU5BdkliMXBjWlRyU1BZSktIdnd4RlRP?=
 =?utf-8?B?LzdRVVlWY1B5RUNDaEhDVnZhSmdwSS91TVlZTTZsSzRnZjE3WTBUT3lYNXdr?=
 =?utf-8?B?bzNnMDdVSkI1WmtQczlYVGZyS1F6MTFQRFlrcDVmS0swVWpndlo2bjE1RFp4?=
 =?utf-8?B?cmVPK25YQVQ5ZUgwSkFuQ21HM21lcUhhWEZNVnNSN1NyYlJIdlR4bExSclMy?=
 =?utf-8?B?cXlhSFFIbU1XZEVSZ2JxUWJJdzJ2VThCM2dVM1AvT0RqQ3JLdkMrZHpwcnV2?=
 =?utf-8?B?L1ZlNFVKUmsrNWRlM2dSSEFJK2RKN0hoZnl6bFdSVmNjQzFUblVSV242SDlR?=
 =?utf-8?B?bkl5MnQwN0Q5VlBGWWx3bDJzOG9Ja1BUbnlPMUFNSE1SWVFweHJuZEc4UDhy?=
 =?utf-8?B?Wng2OW5JSWxMTG5aTUlpdmdmNU1tbkZtZ0pjUDFQVHFxVjVOZlVLSkl2RmZz?=
 =?utf-8?B?L3J2VHdWOEZIT2dEZlYxRm1RYWphQ1g4amtZRjFuMlBUWUVRWG80QUMzUGYv?=
 =?utf-8?B?QmpYOGVsdEE0Vm5sa1k0VkdWNXdLRFVTTEF1bHRZUUVRREI2Qk1mZ0FobUxl?=
 =?utf-8?B?REZGb01mdG1LczFFVEVXR21rWW9yblVwb25qQVFYSzVpMHpqRUlta2VpUm00?=
 =?utf-8?B?cFBZT3JMVTNYWlFsUjZNSEwxd0YrU0FTY3FibFQyNGZOdE0wSkhxYlZMdEEv?=
 =?utf-8?B?emJjMVRHWU1sUVFDMDFSb2pGY2RWQTI0OHhMQWsrMFVRdU1iQU9jY1dNcGd0?=
 =?utf-8?B?TzZycEcvbnhGUmU3SURiWFlYZitIcUZGa211TnU1M0krL21tOEEvUGRvUmpQ?=
 =?utf-8?B?Szh0ODRYWElZNklUcUVhUUZKektYSVNwVExVbE1KLy9QWDMxemRudXAzSnJo?=
 =?utf-8?B?YzY2Q05SMnVpaW1vNzFDZ2lUZWlpSWJnYUdXMWpkd0FwY2VBZVJRbUtnTVdY?=
 =?utf-8?B?NzlwQlNxUmhjUGlnSW1jQ0pLWUlaY09BOWt6V2VQYjhhNGU1WWRiK2lrMW9z?=
 =?utf-8?B?aExsNitaVVhwWkdoZ292OGhVUmt3enZtS2dpNnl0YnVaekw3N1hKSEt6UVNa?=
 =?utf-8?B?SDEyaURJU3RiNWFURTh6QlZEcXhvSjJxc0NNcG1YcllBY1hlMWVmVGIvZjYy?=
 =?utf-8?B?OWhvWXNBSXFzZE9BaEo5WU9FUTVGNmJ5V2p0ZWN0T1pBQ3ZicTFXNVF2K3cr?=
 =?utf-8?B?RmJaclBORnEvaHVjcjMrazd4Y0J3ZXU4bWhWN0JBeHg3eUZ1Rmt5WlpYay9i?=
 =?utf-8?B?dUJ5THJ1bDZtUGp4VGNzMzBrYnIzbERoWE1TNmZvSmJGRzBOckx4MWxzMDVH?=
 =?utf-8?B?THkxM3FhT0V2ZmdUWU5xODY5enY4N1dkZVpLcTFaYWpDZWkxT3ZEQUV6dXZn?=
 =?utf-8?B?YTRnQkEyUlRBZjNmYy93aTUzeGRuT0dHeXZsRDB1QVEzWXFqWTMzbTRhNlNF?=
 =?utf-8?B?STVVNGJnc3VWcWFnU2NYdUxSbCt4VFV6SG9RUk5XVzBQTEpPVWdOT0dmR0Fx?=
 =?utf-8?B?ejNPbFRyTC9aa2JRWmhlV29seEZpQjF0SFBJWTJVRExKNlRHQ28zdERrYUly?=
 =?utf-8?B?cW13L2pCb3g2UG9RK1ZwR3d3STB0ZDZOQURQSGwxYnY4dTZnbmRNTTBoTjM5?=
 =?utf-8?B?Y29SK2FOVnNUUUd0eUpVSjZDeWNxcEUzVHIraWUrVmJRSThSWkoxbEsrNUJW?=
 =?utf-8?B?Zk90MTVXWEJuVkdsalpCV09kdXJteG1aWGl1VWxqTFUwdUhyR0pESEQwK1Nh?=
 =?utf-8?B?MGpXOTBmd2NYTzFOb0QrZFR6Q3l6NzZLQjBjN0RVaUxUdm5VSWZIZ3lDWXp0?=
 =?utf-8?B?MW1uVU1HRGtQNzNocGZSNUhTZ3NESWxzSC8vY0tZU1ZMNVVDZTI4UFVkRVFm?=
 =?utf-8?B?OFNFS0U2aDZYM2ZUVWpLNWZmemx4V3JFamV2Nkx4RllabEVMaGloZTFpZVgw?=
 =?utf-8?B?cTFsMnV0SEdNYytVMWV2eHJhT2g4N2NzK2wyWWRnVkV3c1JldzRtaEZESVJW?=
 =?utf-8?B?bytodXlkSTlhUFpOYnJ3TW1ZdFRLY3I3TFh6WGVpai9qTUtLU0ZNQVVHUTJP?=
 =?utf-8?Q?e+po/awbTZw5aDgQJczPNTPkk+2RScevI+PMik5iYfZt8?=
X-MS-Exchange-AntiSpam-MessageData-1: CYDLtkqgHdDqUw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31b6c5e-87ef-4d86-39a6-08de7928901d
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 13:27:05.7494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mP4yZfMN92IjzqKb85WiZ0jd5lV7FQYOjVSn6Sw5XF5xlZkLhu1+no+PLJhb1osrD/1djpsaH8lCZK4q12QFWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882
X-Rspamd-Queue-Id: DE6891F03CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9220-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Action: no action


On 02/03/2026 20:31, Frank Li wrote:
> On Mon, Mar 02, 2026 at 06:02:32PM +0530, Akhil R wrote:
>> In Tegra264, GPCDMA reset control is not exposed to Linux and is handled
>> by the boot firmware.
>>
>> Although reset was not exposed in Tegra234 as well, the firmware supported
>> a dummy reset which just returns success on reset without doing an actual
>> reset. This is also not supported in Tegra264 BPMP. Therefore mark 'reset'
>> and 'reset-names' properties as required only for devices prior to
>> Tegra264.
>>
>> This also necessitates that the Tegra264 compatible to be standalone and
>> cannot have the fallback compatible of Tegra186. Since there is no
>> functional impact, we keep reset as required for Tegra234 to avoid
>> breaking the ABI.
>>
>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>> ---
>>   .../bindings/dma/nvidia,tegra186-gpc-dma.yaml | 22 ++++++++++++++-----
>>   1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
>> index 1e7b5ddd4658..34c9b41aecfc 100644
>> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
>> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
>> @@ -16,16 +16,13 @@ maintainers:
>>     - Rajesh Gumasta <rgumasta@nvidia.com>
>>     - Akhil R <akhilrajeev@nvidia.com>
>>
>> -allOf:
>> -  - $ref: dma-controller.yaml#
>> -
>>   properties:
>>     compatible:
>>       oneOf:
>> +      - const: nvidia,tegra264-gpcdma
>>         - const: nvidia,tegra186-gpcdma
> 
> use enum
> 
>           - enum:
>               - nvidia,tegra186-gpcdma
>               - nvidia,tegra264-gpcdma
> 
>>         - items:
>>             - enum:
>> -              - nvidia,tegra264-gpcdma
>>                 - nvidia,tegra234-gpcdma
>>                 - nvidia,tegra194-gpcdma
>>             - const: nvidia,tegra186-gpcdma
>> @@ -65,12 +62,25 @@ required:
>>     - compatible
>>     - reg
>>     - interrupts
>> -  - resets
>> -  - reset-names
>>     - "#dma-cells"
>>     - iommus
>>     - dma-channel-mask
>>
>> +allOf:
>> +  - $ref: dma-controller.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - nvidia,tegra186-gpcdma
>> +              - nvidia,tegra194-gpcdma
>> +              - nvidia,tegra234-gpcdma
> 
> nvidia,tegra234-gpcdma must have fallback nvidia,tegra186-gpcdma, so
> needn't nvidia,tegra234-gpcdma here.

I guess the same is true for tegra194 as well.

Jon

-- 
nvpublic


