Return-Path: <dmaengine+bounces-4004-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD8F9F4D73
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 15:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED627A1158
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 14:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE94D27470;
	Tue, 17 Dec 2024 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AVgsVr0x"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB7D762F7;
	Tue, 17 Dec 2024 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445182; cv=fail; b=Z2AaJD+e9cI84SsXEfqjbg+WBGxA+uEMdTfppzK/1Vk+mZo5Z8wN2rmo4QpPVbFp7dv0rRyHJ/Uv9A1X/7cJf6uxZZ+YdG9Pk3ikr2RpvBM3k9zl7hsFXjiJBNsdIpiDH1XXGw/geZhjA2Rua2hRQUt5sLHPWZPgpNEdi1S4MKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445182; c=relaxed/simple;
	bh=PhQJc14G9hGHDNspI4eGgPu7Jh89OYkr1Ge7jpWsCkU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bhmO+blpYhrlkqJfzwwuUVzpspDNKU8WIRAubmIidRLnyM/qCd5AOq/2atokUNwLJvK2CHOk2gxd/8A6DnuGRwoOh67WGIjvkI63kQ7R61j/7+rGrAyDuzONYbJwixGqSnutoLzsRF9or4A/t+NhvS/vdnjbKKbXcca01MOqExo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AVgsVr0x; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHFwG9UYJhe/Mherh8WkRqJOLROHfjORQrRd0hsun6I+vVAZCuWLDp0DQThGM8v8caRvG0we5WTl/pi4loDjk2aMHekCMv0E2QBp9GSARtAJv/rPUYQCNBgqHVy2BoNrEKYKfZUJEQoyl7irs/lf3ZLw2YjrXc35STJQxXZQfRS2QmtcALeMRDgSyGHy0/1eEFOXyWFVhnJANUc7qAalLrDIwTqOEgajYsP2RfEQMfg9KzfuLcS8fiCBh5vv3wfsswYN41svXnjZClaioDGrTncFL4oIet/YXfIVKS2BC2Gj3UeBSFjY1i98VytEjfrPqIJSbF8aie1wQkcGsZDSQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eLW15lIp74hTOT5KFba9JIOkkEw26okgzoJqn4kS/0=;
 b=sRUw23udYKPG+xPq8p9FAGV8WuMNXmFjrfW7OuF3S0sxgqgpyGMknMNtRhOIEqLlLilQxWwz84zjm98MMafO0xQB5rWxLv+qxfU8UQMN1e1RDDeqwhk3oVPrwgHGDA9byaT2EdCTaFqlmMrf1ogx5hnomrICIZz8RDuPb9WYXr3EDneZCl2AGcxdezHVD0qqcYFfl6hAZYSS9GDejG3CJeaIC2ftXLuRZPYw277VW7gpTOGjADFhqnz1pLg1LeWPrWaxigDAc4rg9lOWpC39XHvnNcYmlDo9uQtbk0+FmEF01/wgZvCFS05m4oNjnYVvCwmhU37WjMa6OfhawJx6RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eLW15lIp74hTOT5KFba9JIOkkEw26okgzoJqn4kS/0=;
 b=AVgsVr0xwY0cWy9oUl1ri0OTTFy+uL1WOwcUu+6DnfJclaYvzXe4XY8SOn3Us7anUX9cVoPJPuz7VYG3sXEsnskA6hFcEhqIFw/YucQ/sDLJtS6Ql35C2MvEax72HZj1hLFKBD9rfeGaaHz/1epe6HEO2txniSGGpXYQinzO9R4XWRZ1Uo2nNkmhS2k/W9pOyj76/zaUPVc4Ii+dZJ4HsVT3bRlT22X7h+cuYVFMCThDSnM/J9aM1CnCHO0bSP4U6X0m5ofR7lQ7GsfXCTQmRB/vmq75Uyp7phiznltD5FfjCjbs6xdxYqaRQjSsYSNMMB1scLgubjfmB89cjmmeaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by PAXPR04MB8672.eurprd04.prod.outlook.com (2603:10a6:102:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 14:19:36 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 14:19:36 +0000
Message-ID: <d5badfcf-58d7-49d4-8a5a-d31de498f015@oss.nxp.com>
Date: Tue, 17 Dec 2024 16:19:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] dmaengine: fsl-edma: wait until no hardware request
 is in progress
To: Krzysztof Kozlowski <krzk@kernel.org>, Frank.Li@nxp.com
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, s32@nxp.com,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
 <20241216075819.2066772-8-larisa.grigore@oss.nxp.com>
 <d4afb25d-5993-4f80-9f80-0a548b6532cd@kernel.org>
Content-Language: en-US
From: Larisa Ileana Grigore <larisa.grigore@oss.nxp.com>
In-Reply-To: <d4afb25d-5993-4f80-9f80-0a548b6532cd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P192CA0029.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::34) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|PAXPR04MB8672:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a309ab-c14e-4011-f1e8-08dd1ea5d59d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVlvQ2FBNUhLZ2hsV1l1eFcvbGlJR0dtRGl1L3lVTjhSK3Y3M1N4bkZJOFJq?=
 =?utf-8?B?Rm5LVjUwMUpqTnFzYXJETllVbHYvbmErQnNyTEhNUGxBVzlFVFhUWFU4YTUv?=
 =?utf-8?B?SWJpcStYaXJCS29yUXVYeFpNU3kwbllTdUI0YTdsaHorNWFueW5nS0V3UG1w?=
 =?utf-8?B?V01PU05IY1BtcFBDeUJLanJOdUFEdFd6Y1dzcHpvV0duQjg0UGVxaVpCR3BR?=
 =?utf-8?B?aEVRUWRjRk5YQjJ5ZE1JQ1hmL1RzK0V0R0lOUzZIMHEwTW9mejcrY0RWeUpz?=
 =?utf-8?B?cXFaOURCSU9RYktjMDBlUzhDTmxNNVVHMC9tTXc3WERBZE1FektOSWRZaFc0?=
 =?utf-8?B?eU1vQ3FySEtJTjg1NGtmUGxHRTFaZVNaNnFZWE1IU2xQN1BOSk5YdGl2QjQr?=
 =?utf-8?B?cUVHb1RJa1lVK1N4bmdaWElMUVl0RXZaeXkxTk1xOHE0amcwNW9qZEkzRm1z?=
 =?utf-8?B?cEhIWHFGV3dlY3B3Z1lmM2ZlMSs3QU9WV1BGUElXUy9GcThwV3YwVm1abkFY?=
 =?utf-8?B?MENCTkVqd1RlTEYvT1FwQ3EvWUNoUnUyWGd1dU1lRC9xd0VoTmg0ellLbkdM?=
 =?utf-8?B?dTVzeHFWRlF4NlVzNFpmanZCQ1pELzJ5NThkUlNSUXNTeHdKWTQ0Tjdza2pn?=
 =?utf-8?B?SzhhZE9nMzUxajZScS9WeU5BOEZLTStVTnBiOG1NRGxIaUZuWFRZTHNCTXFq?=
 =?utf-8?B?ZGJ0WXQyQ0o5VEltMmxJU1ppUFV1cjFtQndOVmoyNGtZc21QMXVHOXlWTHp2?=
 =?utf-8?B?czNCMjQ5QWx6QmlnWjZxNnQvSSsrVEtDU2lRM1I3NDNSRGFnVnhVUWkzWXlo?=
 =?utf-8?B?Uzdza21hTjFsekljSjdGdlZLNEl2QjlUZVhtNjNKYzVSVFYxMmJKMS96UWtx?=
 =?utf-8?B?OWNONyt4SkZjQWhqbHl1emRwRmx6QS9HY05BQldNTTFBcWNJb0xUVFEyK2tN?=
 =?utf-8?B?L2IxZzFabkh0YVFzd015UFVIVmRFWGJJbHhoV1dIazF6QWJ2TEx5ODAvQUhn?=
 =?utf-8?B?U2lSR2VDMXhCN24vUnIwSnpGS2ozeXZTTXQwRGd0TjgrbnpoM2QzNzl0ejhx?=
 =?utf-8?B?dW9aUGQrdWJISlFpMXlTTnhQL1hsL3o2UjJad0gzU3pHQzMwK2M1aGhENnJp?=
 =?utf-8?B?Qy9KNm9XTEFyNVhjMjdNQmkxcjZCSU1IbXJkeWp6dnJGdHoyWUxLZ2M3dzZn?=
 =?utf-8?B?ZnR6ZHhlOXJPMTBMeCtUdUQ5blVvQktKRWpoZzdPTXlMZ0ZRd01paU1JYTVx?=
 =?utf-8?B?WjdnVDdYVUlmTnJBdnJndFNLYnIyeld5UjVzQmczRDRJdXFVMGZmUFpmOWZO?=
 =?utf-8?B?S2hlTWRXM0Q1SVBHcmM4cTRJdm9ER29adXA3Q3ZKU3Q5YU1tVDE5Vm5PbWRY?=
 =?utf-8?B?eCt2QW9CaTFleW9BN01WWlRMMHVUUmNiWGdiYWowV1Y3OGJBYndaRTlhWkc0?=
 =?utf-8?B?Vk9IanhEV2VFdmpmOHh4eEcvQ2cvWjBMV0FFQlo5MXFtMWhVVEUzNC8zQkpV?=
 =?utf-8?B?VDZGOGlJYlgrR2Y4OVlBazZ6cFRYL292MmdGYzg3V2t4Y2JWMmp0U1dIT1dH?=
 =?utf-8?B?YW9lWVcwcjF0RXRwdVJEVUU1UDFyV2RMMkNxVlhSaWN4Q2pkM1pMZGNqb3dC?=
 =?utf-8?B?T2RrSUJ5RW5kVXNwOEdqZ1NOdmRiNTNLNklYZTVQdkRhaE5id1FYd2FrcmFN?=
 =?utf-8?B?V2lqZjcrQlhVWEpZbFI5Z1JuTElYUDJHbWRVN2h4UUdWSWc1L2daZGJHSTho?=
 =?utf-8?B?N3IwWUNUbmZVRGVHRzR0bUkwUXRYYmovVWVmQ0M4cVc0Y1FZaWtKWDk4Yy9u?=
 =?utf-8?B?WUY2eHJSODV4Y1dKRkd6ZFFRNWVpdWNaV25oVkJQZ1paK2RUYkFiUDIyWjFm?=
 =?utf-8?Q?e67xtUvjyQwkC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUVvSVZualpOYlFBTWFGekdYWGxhOXUwTFY4WUF1cktRL2psem5xbi9oT2tE?=
 =?utf-8?B?QVdWS2gwMktJS1lUSGsvaDFyZ1ZYQmVTZFdvU0JMSUZDMk00MU5udVNkUXg0?=
 =?utf-8?B?MzJiU1AwZ01SY3ZpMXUwb1lSQVJhQ0EzM2UvZVB4VExUQ1hxM3o4VFV2QTIv?=
 =?utf-8?B?THRDR1VCVXAwZ0g4RTM5MUlEQVU4OThRalltWXNyczVkVWF0d3BMQ2xiQ2Fo?=
 =?utf-8?B?N2c5ZEdoS0k2VTUzVXdvSEFxNzFpMlk4SUk1dU5TcXRpTXRHWllxS0p2TFJE?=
 =?utf-8?B?cldsdVBsMzVaeGdPaHd5NGxhb1pFcG5zS1dvWUhITzRqMzVuMXZ6SUdNL2Uv?=
 =?utf-8?B?YkN5OGJBdU9OVUQwNG1hRnc1aFRkMXpwTjRQTWhSb21XRVdFclpURWlWS2c3?=
 =?utf-8?B?cEhaK3NDRjhTK3AxcklxenhNRjdta09iTjduTTdDb01STkJ1NGkxZUZEaW9F?=
 =?utf-8?B?R2owZCtvTmpSNVN3b01pUEVWd1IxdG5EMXNIZldkblZYU1BrNVBTTm9YUkNn?=
 =?utf-8?B?WTF5VWhJby8xa0NTSThZS3JzMmJoZDlocWc4dDd0VVpidnV5eUJSUEZ1MG5w?=
 =?utf-8?B?WnVEYXluaWQ0NlRhdHUyMVBmbGpOMFR1UU1GRnNiRWNBVjIwcnpOLzhmWW1E?=
 =?utf-8?B?RC9YbE5sVURuTXc1MnQva1pOc1ZZT0JTNmI4a3k4aXRVN1h6V3NTeldnaDNS?=
 =?utf-8?B?cnA4OUErb21xRExwMXFOS2s1cFlGZTNUZUUxanFZVS9zRlJteWw5NlBGaGhG?=
 =?utf-8?B?S29XNlRtdkdTaXlkV1NIQ3ZJeWhybTJnQzh3d1FIMXp3UG9hVysyRmQxZUI3?=
 =?utf-8?B?NjVUQ0N4VnQ2QzdrbjdCUStVbmpEWDRjb2YwUFBFNzBUWVZoRXc0cmtjdTls?=
 =?utf-8?B?M2VocVR5cWpPZ0hqZTIxMW53MzFOeWcyMXlwSnhQQmtJNkFTVEdrWlVEOVl4?=
 =?utf-8?B?VFM2UmVtdjBMSW4wOXdwR0RnN1F5NGxsbTN6UC80RzkrbDQxTHNUYjhTUVZQ?=
 =?utf-8?B?ZFlEWkI5RHdDTkg0QlV0RXZjVzRyWGZsQlloMFhhRk11K0RTTmdTSHQzdW1l?=
 =?utf-8?B?REZyT3ByT0tLTUxGWGpVUVBzSUcvcnpobFNYY2IwV1hQNmhLMzBzTzBmV1Vt?=
 =?utf-8?B?WlBaNDZGdm01UUwzd1lsTndOamhPZURQK3A1QVI5SjA2bnhnTEp2eXIzY0dP?=
 =?utf-8?B?dWpuWlpMckkvcGprSXFFYlo1cEhNSkVyYmdMcVVLQVJCV3h2RUkxaVgwU01O?=
 =?utf-8?B?eUt0ZUZ2T1BpZWM5c0pqZENJKzlLL2t4TUtNRDdtMEpMMm11VWlJTFZYbnF3?=
 =?utf-8?B?Z3pDOTBVQm14Y1RpNGpMa0R6Y245eStoc2FDM3lGcEF2UWUybTB4dEpQSkdt?=
 =?utf-8?B?YTliMEpEK2hOV0RRYmRWQ1lrcG4vYS9USDRTdlV0cTZqN2RSc1M3ZmJHV0Zt?=
 =?utf-8?B?KzZJMm9BS1BtSSt6YkhJSWJpNlA3U1M4YTVjWXBpMW5EVlNJT0Q1SHZCUFZB?=
 =?utf-8?B?aWgyUU5rbUMzekNJNGZHUGZ3b3ZoOEJ3QXRLSzZYd2MyTlJUOVdJeEEzdnpz?=
 =?utf-8?B?TlhSWlhHbVNzTS9laU1GWHZRcEZSQlRjcjdrMnpUazNRa3hJVjlNNStlQ25l?=
 =?utf-8?B?T28rZDBKelVwejF5cnBWOFFhMis4N0tnajBUVkVLVEtXeEJqM0tITWEwRW52?=
 =?utf-8?B?NndPWkY4Z2IzQ3RyZ1RpWE5PZzY4UkJFUEpLU3FONG12dktFQ1NKVzVXUlQ3?=
 =?utf-8?B?MFBzTWZPL3libzNieWY1YWxYWWtrSHdJdkVwN2RGb21Gd3BaMEdWTFJ6aUhy?=
 =?utf-8?B?MllkbVM1VkF0eWl4eUxYUFlJOGRDbnBZWlVQdXFWVlppREI5akQ0RjlXUC9r?=
 =?utf-8?B?dGQxOGNCS2l4MTlMNVRYZ0VyVDVtT0FJdXQ5UVd4anFLYWV1cENrQmlmVHcw?=
 =?utf-8?B?QkZ4eVNYWDAza0N6TzdiNEh4K2xCQ0tyc0pGWGZoRkF4ejBQbE5vSFViSWVo?=
 =?utf-8?B?UmExZGdsQmlQOVlqZm1EYUlXKzJjdGRoN2hkaDhNS0s4OVBWRUdrZml4ZmEv?=
 =?utf-8?B?SmIyZHdsSlQ5ZnpBWkVQMi9xR0RubU9mZHlIUjNwL2M4bVhSS0t3WjRiRlI2?=
 =?utf-8?B?bS9HUnUyQU9aYlVvaFNoSzF3NmNwWkFpUjFqL1E0QjcwYi9WazVZK0NqK05D?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a309ab-c14e-4011-f1e8-08dd1ea5d59d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 14:19:36.2458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOmV8EJ8BAw0pZh9n7NTrtY9OSIFUmvkLNgSpRatl6c3AeV1Hy0hK1asQWaGMb/Si1WdUaSbH2y8l4nvkV6FXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8672

On 12/17/2024 7:27 AM, Krzysztof Kozlowski wrote:
> [You don't often get email from krzk@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 16/12/2024 08:58, Larisa Grigore wrote:
>> Wait DMA hardware complete cleanup work by checking HRS bit before
>> disabling the channel to make sure trail data is already written to
>> memory.
>>
>> Fixes: 72f5801a4e2b7 ("dmaengine: fsl-edma: integrate v3 support")
> 
> Why Fixes are at the end of the patchset? They must be either separate
> patchset or first patches.
> 
> Best regards,
> Krzysztof

Thank you for you review Krzysztof! Indeed, this commit should be moved 
right after "dmaengine: fsl-edma: add eDMAv3 registers to edma_regs" 
which introduces the eDMA V3 specific registers including HRS.
I will move it in the next version.

Best regards,
Larisa

