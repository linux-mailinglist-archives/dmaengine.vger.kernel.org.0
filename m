Return-Path: <dmaengine+bounces-9266-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GATZKA0TqWlz1AAAu9opvQ
	(envelope-from <dmaengine+bounces-9266-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 06:22:21 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB88720AF8F
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 06:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16969301573B
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 05:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E9A21D3E2;
	Thu,  5 Mar 2026 05:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="YZ1ktLXI"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022132.outbound.protection.outlook.com [52.101.126.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67D6A945;
	Thu,  5 Mar 2026 05:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772688098; cv=fail; b=Md7czifboglKqfXf84rmY7CjfNdG+a9ymS4ph100t2nzObCJtxQjnPb3Riia0GTEqnjEui7RrAkAQDCWotSnU6pjXNcUAB2co5am73b5dlP1QJ0CMGb3BR51JafIiUKpGhJ3CiHwE+XelmbOcmunuLUb0SwM2uOLCipVSNuy2iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772688098; c=relaxed/simple;
	bh=7PNYKbf+TtAFYXwa5LluEd/bz1ACRLl90DTjSjGTnsM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s+ijPBKzamKw35dKAS+QVwcWF2jxaY99+j/SQzqorkyJkMTuOj4KzzDRXu/aLUUhulq4gC27cD2coBUhqyhyM3RU00SZ5zHDw7e10RmFh5/mhydGt/JaBI1wPy0chEm3eA31EWEbEPWslE61NKgUkbja/CbtomNgTawilExVDGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=YZ1ktLXI; arc=fail smtp.client-ip=52.101.126.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zi89av6bjFzqflpQ/lEdrrygwsL44CIWYIja5MRdqJc6UZf4VQKSVHvLo8ogIQ6v7FQbNYvxBcmTym1TQwHNz+x3mpFlslztdA+byc0BiZH7IeFmArrAnzvFbqq14EoroEGLkmz+xR9GBC235EvzLo3PPUDqlun0qUPHt5qP5cQXDnQ2m/P4/PHz1lFdapCznaifcBkf81IcvqeeQhHzeVFdHt4Ug5corgeASib6qlKN3dwhlyHkrRkOMLAstDbE4KkfAYuOZ6IQV63LZg/T8CpfcYT/rZ+dph2vv6yhBxXFXVgtRKQ+RFlnzPCuy0gfWWGb98fA+IfD6+LEIItx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhtVvvoT1QcnN3GcmIkKpdI17kOCyRWv3myjUyFloz8=;
 b=KlPH/FPtQvjOrHL6oyndja0GxbAkK8uWhGMQ/+yWGSJrDnqvf59NjwXbD7g8H4qSvd40Pq5Dv9mD0/fmbreQ8IEIOwtcjZuWObENRA+4afa4ijkJQey1ka691WhA/6y66NglydToR6FqJEWEKdgRnfpxlxbhfnnTvOOrBnuWDZFTXI7rGgOz3R5VI8lIZ0uGz+iXOQ5zH5DMpn8u0AV02vTNrd1vU3ldHG1bR4dJrArSc9Uezmcl9KXVDeVuQZBFYOchmgOJmFWd8vAovKcz+xYHQkHfjT7o8LVQTkzQ/YIzO5Kbu7U4yo9XYMWB2ReStYCmHPuakwkeGk5tZKnKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhtVvvoT1QcnN3GcmIkKpdI17kOCyRWv3myjUyFloz8=;
 b=YZ1ktLXIEiYiMrqguN1uymE8U95MVYyvnZ3ImBL4Gel/QWrKAKt21nUkiwZWwMYMTBr4tHFhHwWeX2py7zY79KvF5N+ZGRLOaNN6+u7V2NvNjw3mYQkb36MCAH6VupzzVUTZeWT0UoMp45XVbHJe1D7RA9LZLbPcPkrysYUUbAs+E7V5dwUqa2hrS8qflVG9uhOvDQs1u+YMgglyDFBM2nwoWhgYcH5kfRoUGPVs9CqMybGQU3DOyzvGgwngP6HbNk/ecsGd9N6Kfji8ZRsJHGvIB5bWwJYYJK7wq2MU8dy9OiUjS5qV9p9JN2qdNwLoAB4uMJkRyW6CDyLu9eYPgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEZPR03MB8183.apcprd03.prod.outlook.com (2603:1096:101:196::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 05:21:32 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 05:21:32 +0000
Message-ID: <7ee33032-586f-4b6c-8bd8-d55a18ed923e@amlogic.com>
Date: Thu, 5 Mar 2026 13:21:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] dmaengine: amlogic: Add general DMA driver for A9
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260304-amlogic-dma-v5-0-aa453d14fd43@amlogic.com>
 <20260304-amlogic-dma-v5-2-aa453d14fd43@amlogic.com>
 <aahUTp3T6QWbZiaz@lizhi-Precision-Tower-5810>
 <501fe36e-a3b1-475d-ad79-8b6523fe95e7@amlogic.com>
 <aakDyNdKhXdh-bnH@lizhi-Precision-Tower-5810>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <aakDyNdKhXdh-bnH@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:3:18::14) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEZPR03MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ddabd3b-09b1-4381-2875-08de7a770fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	Lk4/5LpgaRUpx7I5Mu+Srs7lkRhyK6YDZo9LWjfyrUfnRIwRVN81lKQRb+QPgkGfLNfsLjL3DscGVK+pwBs+OXLrBhfAMF/LXuYDaV9FI6M++xmvUxWm5keRWmyhvJH5iypWhNw/xVYvSKCzzyOhfgGMu5tTDv5Rb7f2LNTBR2Hl6XXGrexLDrMtOsUrLCitjqa2Hr0L2miIi458AMzRFYdxAYuczFfF8Nc6AJHqSFEap6wXMEIL/7AsjhdiX4zKkTUtZPTdd4Ny/vki1TKiH4iGIl6Aaj/j9g9eo7P5y/0YbX8KVrP4ihKjKahjYu4R8ookI15Uf6s70rnPO3+2ETSbjUknLlSnzy2swZXE0pS+gBv4BFSoyh9NvCCn2UkxfTD677c+jpyfF5vsJVMZEgbt3cqk5JtzN2WsSE9k03qIPImtOuK0VsGux4sH/+LRXKZcFC1AbQn8FxavNqxJu+Z6a8W8a+DhNS4dvKH1bSFRYoIE/warJFE7UEZESp+8xwMhY04VuSB23vwZxOZQI6VpdZ0ff8pn+IuvsvfBeVc1UTMr3w+bvt+1QUto15L0ObmLatSHGDcSdSmde1ARxvRQ2ZiQm7c1u3efEu1HuvsHlWkV6b5wgwcOwWX0SvI/wbZYqEpIUGLHltB/qFdluLZ2ZjgDQBVS1WDENwTXxU1DyhDRFcT249+ok5j0h1G8xQn0ctJ+JcSJlmcLOhXCgcPZ+BW5xlR+7sVD0/ahsn0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGEvRENnZGhoOWpha0Z5UUdBTFVzZnphdnBPa0ZXbi9WbzcyTW84c1BSZzVu?=
 =?utf-8?B?TEZCa1VuMXNEOXE0QTl0T3QzOXRMWmZGS0JkQS9pOTBZK2RQaVRaa0RobE90?=
 =?utf-8?B?RHo2SFZWaW5lREF4MzJIV3pHaTdMTzJTbmd3T1VrWHhFdzRmcTYrcnZzMGpL?=
 =?utf-8?B?VGVrTTl2Sk1zK2puQjJCeWZMUytUVVduN00rYmZ3RlE3K2hGZlFYVkRCcVIy?=
 =?utf-8?B?TUovTW1sVzZpd3JyZmJQTDB0Mk9iaTdjZUdHd3JXZVNOQmZhaXRoWGgrM2Jr?=
 =?utf-8?B?MC9lR0lxNmJRQ1F5V1FLWTYybHJCREJ5UkdIWHpaS0RoNFdrQlpDbXdwbTZn?=
 =?utf-8?B?UEhvNE5hUjVNc3cwbkFEV0ZBa2ZicGY3Zjgzb0R6ZDlGei9HTCt4Tm9NTnEy?=
 =?utf-8?B?VVBtSkpmc0doR3JQMWh2emc4Y01RSUdJdVhtSVVFQnVYWS9oYzJSSXdGYWdh?=
 =?utf-8?B?WFhpeVQxSW9vVE92Q2xNYUJEaE5HeXFWdUpRTXQ0RDRlNlpDS3lIRFk2S01p?=
 =?utf-8?B?VG5saU5pSHdRZEZueTVtR3o5dDNYd01lZXh1Mmo5TCtOZnZTOHZsaFp1VG9J?=
 =?utf-8?B?VVRydFAxUXh4Q1lrNFNIR0oyaWxndWxWc0hkWU5SaHo0VVhCR2JFekRmdFQ2?=
 =?utf-8?B?eFJOU1AwSWVzRGVDendtYmVlNlNGWnIyZVczUnB5SG1Tc0dmVU1HemFpNGZ2?=
 =?utf-8?B?VVFLaUlDYjllM25QSjVHR0NqUy9uTFdmUE5tUDRKYnVJdFErTXZkYnN2dEJD?=
 =?utf-8?B?L2M1QkR4NnNXS1NtRUxQUk9aOEJRVGlrMWdMeDlUaWJNbERoS2V5Si9MZTRy?=
 =?utf-8?B?c1ZhYkhCRFZacVIvK3d3MG5sYU1XWTNjdGpuRy9HYktabEJ6aXN5OHdSRnY5?=
 =?utf-8?B?MUNyaVh3aFl0WGVDYkg1T2ZHQWFHektKOGpkYlZXR2tOcFRMUTQ4Q1VOZTVh?=
 =?utf-8?B?aHRiR0lPdWJlRDlwY2QxV0RYcEMyWEN0YjhPREF6QjQ2M2NYOUFDMTNtSk1M?=
 =?utf-8?B?dkxKUE9pei9Ud3Z4cEJkUnVMbFpaNEZMNFVRT25iQk5NQXJwNjJrNkRJUS9s?=
 =?utf-8?B?ODdaR2pNZ0xma1pkQlpMckdaQ2p2b2hjakE1NlVrWWNmTDJ1V0M5bFpaMUx0?=
 =?utf-8?B?SjJjekJIZ1dYeXRNMEtCaURTZUtadWVqYU5nU3k3M2IycTMybzVvcmFwZUg3?=
 =?utf-8?B?bTl1Zm50bUFxMXRhOEJsVlRXLzdOQVdmRUZyMEhtWW1UOWx5MXB5b2UrSjVs?=
 =?utf-8?B?WXJ4aG1aREVwM1p5dDQ0cEdnSzhORWVDYndkUEd2UEdaRXNlb0ZHMEV5RFpj?=
 =?utf-8?B?bHJPbGxRa0hMZFdJY3pjSFNkSkZFZDB6YXBicUF6bFhzbzd6S2hITW85YXJo?=
 =?utf-8?B?N1FOdkIwd3VqVUJNNnpUVjAraDZXNzNyTzArWHVUZTdyNUw0YUR4Q0s2MGl5?=
 =?utf-8?B?WFNKTTh0N1RuZE51R2dIcmpiSHROWmxDWWJtc2Z1a3RPQ0N3WURtSTlIc2ZE?=
 =?utf-8?B?VlFmVkN6Z016OXo3VEpZVUdiTGIxaEgvdVFlTkNkWG1HcEpYVUE4RmZlMFNz?=
 =?utf-8?B?K0ZCa2lBOGVMaVlWcTN0MVltS1Z1eEgvTG5wWDFkZ0lsZFRMVE4yNDJsQndF?=
 =?utf-8?B?blYwekVhVytIRTZ1aUFXVWJRdXRXcmR1YkxHcmlpQTUwTDJocTFVeE1MNGVv?=
 =?utf-8?B?Rm1IRlhpS3pOSXVmUWpKaWgxZTk5MjVpM1BVeEFXSHJ2QTVSNHE2WTVwTFJJ?=
 =?utf-8?B?TkMrMm9Gb2NSYmJLeGs0czNJZkltRERhUExGWFdVbUNFVG1qcU9TYXJnY3Fx?=
 =?utf-8?B?NkJzd1VQd3E4cjJoTERORWp1ZDViRnFneWc3V1J4TGJxT1hLdzRueGN3MERu?=
 =?utf-8?B?Nk9NQ0N2VWlsWnVaOWJ1UWk5WVZ6c2d2ODJUWkNnS08zUWp4ejBhcDM3Tkxv?=
 =?utf-8?B?VlQ3US9qVDlGaVhVTitacW8vQnJ5N2pSYnJZcW54NnJWb29LQ1hhWVQ5Nmcv?=
 =?utf-8?B?MS9aNmVCWlNlTmFycjJzTEFQYVZ1TUJtazdyc0s2eUxQaUtGQWxyYXorUVp4?=
 =?utf-8?B?Z1V5ZTMvUWZKb3k2WEJ2aHVNeERyeEF2TDJpSlF5Mi9yZFoxbWI3UHRDOFpD?=
 =?utf-8?B?bmtRM2hmcDhJZi9zYmd4MFdGamJHait2SFFDREwrQys3a3RjYVdBTVczOGNq?=
 =?utf-8?B?Zm9SSGg4TmJBVFFON3JwQzYrdjR0eDlNZHQzRVFxL2dEeitDcXQ0bE55UlpS?=
 =?utf-8?B?YWxKS012RnovWXh0bUUyMVZJV3R3amNjRWxHcXZCaUh0djl4aXdEcS9DcURl?=
 =?utf-8?B?V255eWVNVmt6c2ZjNEwzUm1FMm1iL0ttd2ljelQvTDBRakQ0VWpKUT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddabd3b-09b1-4381-2875-08de7a770fe4
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 05:21:32.0796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlOHe9lIs7jaAIhqNbXyBWhzOy8w+ZNqWyr+15DinbHjkj87DbvmhPyMrU7gJyUqzZlk5Ilsfn7UcRU4dogjVqoK1BzBJexyh59AEH7Fqqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8183
X-Rspamd-Queue-Id: EB88720AF8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-9266-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xianwei.zhao@amlogic.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amlogic.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amlogic.com:dkim,amlogic.com:email,amlogic.com:mid]
X-Rspamd-Action: no action



On 2026/3/5 12:17, Frank Li wrote:
> On Thu, Mar 05, 2026 at 11:35:15AM +0800, Xianwei Zhao wrote:
>> Hi Frank,
>>     Thanks for your review.
>>
>> On 2026/3/4 23:48, Frank Li wrote:
>>> On Wed, Mar 04, 2026 at 06:14:13AM +0000, Xianwei Zhao wrote:
>>>> Amlogic A9 SoCs include a general-purpose DMA controller that can be used
>>>> by multiple peripherals, such as I2C PIO and I3C. Each peripheral group
>>>> is associated with a dedicated DMA channel in hardware.
>>>>
>>>> Signed-off-by: Xianwei Zhao<xianwei.zhao@amlogic.com>
>>>> ---
>>>>    drivers/dma/Kconfig       |   9 +
>>>>    drivers/dma/Makefile      |   1 +
>>>>    drivers/dma/amlogic-dma.c | 585 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>    3 files changed, 595 insertions(+)
>>>>
>>> ...
>>>> +
>>>> +static int aml_dma_alloc_chan_resources(struct dma_chan *chan)
>>>> +{
>>>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>>>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>>>> +     size_t size = size_mul(sizeof(struct aml_dma_sg_link), DMA_MAX_LINK);
>>>> +
>>>> +     aml_chan->sg_link = dma_alloc_coherent(aml_dma->dma_device.dev, size,
>>>> +                                            &aml_chan->sg_link_phys, GFP_KERNEL);
>>>> +     if (!aml_chan->sg_link)
>>>> +             return  -ENOMEM;
>>>> +
>>>> +     /* offset is the same RCH_CFG and WCH_CFG */
>>>> +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, CFG_CLEAR);
>>> regmap_set_bits()
>>>
>>>> +     aml_chan->status = DMA_COMPLETE;
>>>> +     dma_async_tx_descriptor_init(&aml_chan->desc, chan);
>>>> +     aml_chan->desc.tx_submit = aml_dma_tx_submit;
>>>> +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, 0);
>>> regmap_clear_bits();
>>>
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static void aml_dma_free_chan_resources(struct dma_chan *chan)
>>>> +{
>>>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>>>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>>>> +
>>>> +     aml_chan->status = DMA_COMPLETE;
>>>> +     dma_free_coherent(aml_dma->dma_device.dev,
>>>> +                       sizeof(struct aml_dma_sg_link) * DMA_MAX_LINK,
>>>> +                       aml_chan->sg_link, aml_chan->sg_link_phys);
>>>> +}
>>>> +
>>> ...
>>>> +
>>>> +static struct dma_async_tx_descriptor *aml_dma_prep_slave_sg
>>>> +             (struct dma_chan *chan, struct scatterlist *sgl,
>>>> +             unsigned int sg_len, enum dma_transfer_direction direction,
>>>> +             unsigned long flags, void *context)
>>>> +{
>>>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>>>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>>>> +     struct aml_dma_sg_link *sg_link;
>>>> +     struct scatterlist *sg;
>>>> +     int idx = 0;
>>>> +     u64 paddr;
>>>> +     u32 reg, link_count, avail, chan_id;
>>>> +     u32 i;
>>>> +
>>>> +     if (aml_chan->direction != direction) {
>>>> +             dev_err(aml_dma->dma_device.dev, "direction not support\n");
>>>> +             return NULL;
>>>> +     }
>>>> +
>>>> +     switch (aml_chan->status) {
>>>> +     case DMA_IN_PROGRESS:
>>>> +             dev_err(aml_dma->dma_device.dev, "not support multi tx_desciptor\n");
>>>> +             return NULL;
>>>> +
>>>> +     case DMA_COMPLETE:
>>>> +             aml_chan->data_len = 0;
>>>> +             chan_id = aml_chan->chan_id;
>>>> +             reg = (direction == DMA_DEV_TO_MEM) ? WCH_INT_MASK : RCH_INT_MASK;
>>>> +             regmap_update_bits(aml_dma->regmap, reg, BIT(chan_id), BIT(chan_id));
>>>> +
>>>> +             break;
>>>> +     default:
>>>> +             dev_err(aml_dma->dma_device.dev, "status error\n");
>>>> +             return NULL;
>>>> +     }
>>>> +
>>>> +     link_count = sg_nents_for_dma(sgl, sg_len, SG_MAX_LEN);
>>>> +
>>>> +     if (link_count > DMA_MAX_LINK) {
>>>> +             dev_err(aml_dma->dma_device.dev,
>>>> +                     "maximum number of sg exceeded: %d > %d\n",
>>>> +                     sg_len, DMA_MAX_LINK);
>>>> +             aml_chan->status = DMA_ERROR;
>>>> +             return NULL;
>>>> +     }
>>>> +
>>>> +     aml_chan->status = DMA_IN_PROGRESS;
>>>> +
>>>> +     for_each_sg(sgl, sg, sg_len, i) {
>>>> +             avail = sg_dma_len(sg);
>>>> +             paddr = sg->dma_address;
>>>> +             while (avail > SG_MAX_LEN) {
>>>> +                     sg_link = &aml_chan->sg_link[idx++];
>>>> +                     /* set dma address and len  to sglink*/
>>>> +                     sg_link->address = paddr;
>>>> +                     sg_link->ctl = FIELD_PREP(LINK_LEN, SG_MAX_LEN);
>>>> +                     paddr = paddr + SG_MAX_LEN;
>>>> +                     avail = avail - SG_MAX_LEN;
>>>> +             }
>>>> +             sg_link = &aml_chan->sg_link[idx++];
>>>> +             /* set dma address and len  to sglink*/
>>>> +             sg_link->address = paddr;
>>> Support here dma_wmb() to make previous write complete before update
>>> OWNER BIT.
>>>
>>> Where update OWNER bit to tall DMA engine sg_link ready?
>>>
>> This DMA hardware does not have OWNER BIT.
>>
>> DMA working steps:
>> The first step is to prepare the corresponding link memory.
>> (This is what the aml_dma_prep_slave_sg work involves.)
>>
>> The second step is to write link phy address into the control register, and
>> data length into the control register. THis will trigger DMA work.
> Is data length total transfer size?
> 

Yes.

> then DMA decrease when process one item in link?

Yes. When the link with the LINK_EOC flag is processed, the DMA  will 
stop, and rasie a interrupt.

> 
> Frank
> 
>> For the memory-to-device channel, an additional register needs to be written
>> to trigger the transfer
>> (This part is implemented in aml_enable_dma_channel function.)
>>
>> In v1 and v2 I placed dma_wmb() at the beginning of aml_enable_dma_channel.
>> You said it was okay not to use it, so I drop it.
>>
>>>> +             sg_link->ctl = FIELD_PREP(LINK_LEN, avail);
>>>> +
>>>> +             aml_chan->data_len += sg_dma_len(sg);
>>>> +     }
>>>> +     aml_chan->sg_link_cnt = idx;
>>>> +
>>>> +     return &aml_chan->desc;
>>>> +}
>>>> +
>>>> +static int aml_dma_pause_chan(struct dma_chan *chan)
>>>> +{
>>>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>>>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>>>> +
>>>> +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE, CFG_PAUSE);
>>> regmap_set_bits(), check others
>>>
>>>> +     aml_chan->pre_status = aml_chan->status;
>>>> +     aml_chan->status = DMA_PAUSED;
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>> ...
>>>> +
>>>> +     dma_set_max_seg_size(dma_dev->dev, SG_MAX_LEN);
>>>> +
>>>> +     dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
>>>> +     dma_dev->device_alloc_chan_resources = aml_dma_alloc_chan_resources;
>>>> +     dma_dev->device_free_chan_resources = aml_dma_free_chan_resources;
>>>> +     dma_dev->device_tx_status = aml_dma_tx_status;
>>>> +     dma_dev->device_prep_slave_sg = aml_dma_prep_slave_sg;
>>>> +
>>>> +     dma_dev->device_pause = aml_dma_pause_chan;
>>>> +     dma_dev->device_resume = aml_dma_resume_chan;
>>> align callback name, aml_dma_chan_resume()
>>>
>>>> +     dma_dev->device_terminate_all = aml_dma_terminate_all;
>>>> +     dma_dev->device_issue_pending = aml_dma_enable_chan;
>>> aml_dma_issue_pending()
>>>
>>> Frank
>>>> +     /* PIO 4 bytes and I2C 1 byte */
>>>> +     dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
>>>> +     dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>>>> +     dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>>>> +
>>> ...
>>>> --
>>>> 2.52.0

