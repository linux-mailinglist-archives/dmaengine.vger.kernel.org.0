Return-Path: <dmaengine+bounces-3981-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6299F2D89
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 10:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6CE1886E7B
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 09:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF46202C3E;
	Mon, 16 Dec 2024 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ufk5BVEF"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C06F201269;
	Mon, 16 Dec 2024 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343045; cv=fail; b=i7Xujdty28dpvKQaC6o+s1AEhoAYq6DllMzKTi07+yNZF7yK+UKoaoQJAnP/k9Bh25g/60wO9xR3uYAGaNmhAk/MoRnHxJDhn44L57uzVKSgK97X9yGn6l5QdOkARLgHSGRVSbcGxVqHcesb0ZWNTvYVXdAsOlIsVCpCvUTdHUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343045; c=relaxed/simple;
	bh=F1nfKVc22SqJHoUp4cRCQuHUDAF8XYX+kV+i4ihB+Ag=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y+LcjMVbO8nmnw8TPpCZF6Ae3H1l950kVFNja2Mf9T9CBvYlus+LLn4/zGNNenHyg7rEFhA4DeTCDc4KGSc900wNbCZRZM0+q5wOS1BwjfU6abg8NRdwc3tn9gp/uwnLloga8nFGcX8kHkjMFuf2mLcJ/9YgNzpgnq3L04YfFOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ufk5BVEF; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7Q4YOmFTEnVjdL0TvxjMRlwypllKhgkrKRhCko4asMYsocMd+8GIqn/wFVgXLLlI3Qe3AfdKOO8Qq0hfLNXeRbMwUnVabvKfcA16sBt8NmJ7/ZQuFWmdYZ2Ek/Alcpm+NGG03EmbdqOEXj4HBakhTUO1rmDxGwfgUpfTGsLlN6V7RiAvTJ0aw8XUNJqadU4oozmuOPemP75QWWiWGOI0BSvbTE7hM8RYaqK4mIH6WEKFCQNpoVDDm63l+8n0PLw99FXvWRgeKEIiBUmKAxlEgsj+4r42R4lKMGFi6c69q6Pl4JyAzszSEKfWTEh78JDjKOvmKDZ1F9kTGVskVdH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41DSFfgP1FCp4pl/V1ugzCaXbAXN+4f74x15rLFmgTk=;
 b=rAdzmZC7DyaUi1x02rPSh3KsCq9e0Iei8SSwcMcBdwUQxfRaRSwtrMBF60SS8m+2idr6mBxZKUBQ8nrMk2s6YQIRZ/7CS/b4XbduE/nx4wpcbAfUxC2xkCT8JYzcH/q952tWaj2pePi62oyHNF2sH0z6ofcFiR9BxXDP2SkRoJDHLhMkQSS/6Nil7hIi1WXnD+Czpw0wN8WvEaYOnFDW8Ogy8+CecdmB+MUmviwp19wZiKFeWtKvbWLPsDvzjDNJY9mOeKjaRH0h1v+MwZQU41LS0xVIR/sGP/ZHnAJ8laMA/BxIXQ7T4wOSJSBz1WJtjQruosTd9GXfUA/MyIfMeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41DSFfgP1FCp4pl/V1ugzCaXbAXN+4f74x15rLFmgTk=;
 b=Ufk5BVEFSPcjioFDu1BDtIL9th4NCLDBS1m8PK5Lo476hOKkDQP1swY/GK7D/v1tXF+WrQ7mYTzKcWRWdaYrfROUXfFPUq/GezSnRZnAYij9XA3DLLKyh6yQixzuc7Tp2rU89ONoy4bWYAU22+zhokBHn6nvihD2fPazSz7EF39OIgkW7FvqRuRcXYHHRYtSKv/OMMqTWJ0diK+Mb3N/2dcTVY6fQL5ApGSawLUQSzLBJlXArZy6Y2v4cxCELLFjZ5fbToj3qymZ3smohDvFqW5PMW/M8g4Xdocj1y2lTywVKsQxCrdvlhpEPiEdXJ6l46jV12HcsZiwrepGD6QEyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10)
 by PH7PR12MB6693.namprd12.prod.outlook.com (2603:10b6:510:1b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 09:57:20 +0000
Received: from DM4PR12MB5101.namprd12.prod.outlook.com
 ([fe80::8a69:5694:f724:868b]) by DM4PR12MB5101.namprd12.prod.outlook.com
 ([fe80::8a69:5694:f724:868b%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 09:57:20 +0000
Message-ID: <8e74373e-c91b-44ec-847c-29ac17f6b469@nvidia.com>
Date: Mon, 16 Dec 2024 15:27:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: dma: Support channel page to
 nvidia,tegra210-adma
To: Krzysztof Kozlowski <krzk@kernel.org>, vkoul@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, spujar@nvidia.com,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241205145859.2331691-1-mkumard@nvidia.com>
 <20241205145859.2331691-2-mkumard@nvidia.com>
 <aa7eef93-6948-453c-8eb8-d7f4f7572808@kernel.org>
Content-Language: en-US
From: Mohan Kumar D <mkumard@nvidia.com>
In-Reply-To: <aa7eef93-6948-453c-8eb8-d7f4f7572808@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::12) To DM4PR12MB5101.namprd12.prod.outlook.com
 (2603:10b6:5:390::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5101:EE_|PH7PR12MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: 73969db9-c321-4c7b-a04e-08dd1db807df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y051MnpqY3ZWM1VsemNKcGMrM2M0WjIxYmZWbTB4TEh3aUN2bmFMSXc4VWFv?=
 =?utf-8?B?TWdEQzBrQ3piS2hyTEE2RldBVEdFc2E4cDVOT01HNTBrSGhMUW0xaWtPTkln?=
 =?utf-8?B?NnNMNXMrVVpGalpSd0VMeE5WcDB6eFpKQWNFcGdnNVROcW9wbXAzcFRzZU9L?=
 =?utf-8?B?d2VNbG5Ub29iMlVJRGNXdHhESmxhYm5BSFl6L2pOd21tQ1lRelppNzZkbU05?=
 =?utf-8?B?ODFFQVRlRS9CZVExekd0NlAxRy9lbVhZVVorTjJHbWkvTkFyQ0hKM0dGVG1l?=
 =?utf-8?B?YXdUTXRCNWdKbUVKZlNVRW90QXVHUWRmYVRNZk50WDA3SUlkWVR1QS9kZGRL?=
 =?utf-8?B?a3lNYTZsVUZOcW52UVA4YUZrK1pNZU83cjdkVVJIem00Q0taQ3E1Y2NQNWg2?=
 =?utf-8?B?ckZRTE5wR0tSSHpTbG1LRU1namJubFpKUnBJZENqUHJmWVRVaG91OHhnbndr?=
 =?utf-8?B?b3drcS82WTRzRW1MVkF2czBtZStUMHhiYjRyRVBsVThBYVA5WWVFNGQxS1Aw?=
 =?utf-8?B?bXlhZVNxZXJLdEY1dDR6Q1dIYW5VemZOdjV4V3AwaHhid3V0S3hWTmQyamEx?=
 =?utf-8?B?dWlTNWwzdUdMMHA5S3laQUd4RXg4RTZDbHN6bDVZazREaGVhTkZzUnhEeGVO?=
 =?utf-8?B?S0VieXk5aVZsaDFoaUlMUW0zM1dxMTdwV2U3N1AxK0tTWkFsRmFiZ1QxUXN6?=
 =?utf-8?B?M0RPTDdUd0FXL09lUm5wYTdocDEvU0FSWTBYbGxqaVFnL2xLZy9UYmx3WGUy?=
 =?utf-8?B?cnpMZ0hhZUswQUV0b0RIT1luR1V4a1BRQzJiMWZiMHFOd2RqQ29xdXlpN1pp?=
 =?utf-8?B?MXNqbnBLZG1mbnZGc0o5Q0w4ZWlPNG15dWFGK0FLaUNaUmhYTE1Sa1pDTUow?=
 =?utf-8?B?ZXlLdTEyVW11OW14M0pQVkFqdU1WekRmc0FzNFBkZk9GVks0d0t6bXV4WllS?=
 =?utf-8?B?OFI4LzhMb3NYTVlBYmVEK091U0k5ZmM1SDQyYkQ0MjFUWi9HVFUrME9iQmhO?=
 =?utf-8?B?VUMvMnkzN3VYMXV0RlRNQlYvWmZVb2NuVUlxNThVUnlFMGtjRzkyU3dkaG5r?=
 =?utf-8?B?MjUvdm5DTURGYlVJWjUrbjFYTjJtdVE2NXFkYXdpMmhsdHBQLzZsczg4UjhT?=
 =?utf-8?B?Q1E5OSt0VzFvaElRSEduczdQMGM2TkMzeHpJL1V3T0lKNG80eVBCQldaTHhY?=
 =?utf-8?B?S3Q3MUQrL01PVzg1Wi96aVBjZmYxVmxLV0dzNjB5Z0d4NzNwcDVIUUFTWUNS?=
 =?utf-8?B?a2liVnVxUHZMeCtqeHlvenRwMkVhWWVUMzNSQmQ1YnhLaTdiRTZTMVJLNkpX?=
 =?utf-8?B?cWFoSkJwVkZ6M1JnUGltK1RjMzJLeUdndWNSQ1A2ZVlXcFA4WUNjT1NnTXl5?=
 =?utf-8?B?VHo4REluZ3ZCaTY2OWVxclpIc0VXMjFJaUhNZnlnMjFpV2EyNExyK1Y1eEo0?=
 =?utf-8?B?NFJTTmhkd3k1c2ppbXFEMFRxK1Z5TWFYdG12dW82MTJ4Y0lta2NjTnVVVHRx?=
 =?utf-8?B?Mkt2RCtXek5hbVBKUm5UeUhJaW9VWDFIa3ZJUGVRVVlNWHJuOElPUlpzd2R0?=
 =?utf-8?B?NUh6WC9RUkZxSGlmWkt4VVZvVllZUkpvaDNic092dEd4VDFhNDdTTHNxb0lQ?=
 =?utf-8?B?cm5KZ1h2cmlsRnRsVFFteWpjVTYydzVBNFcyUEd6dElocXNrcy9lbVNHWjh0?=
 =?utf-8?B?OUJ3V3FWTk05N0NSdldyVjhXSzQzN0VkZVJad0FycXpyTk03eWw0SCtpc3hk?=
 =?utf-8?B?Y3FhSlJDRnY2T1NoWmpPdUlaQmN2M2xQOG1zUForYmt6dHphTHBNUFFQSUxG?=
 =?utf-8?B?OG1zSEowdm5QVW1CcjdCYW9adnZ5RUJmT2p4Vm94UTdPbUswOC9pcTFRT04r?=
 =?utf-8?Q?PlgB+MO8YWFG+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUh1aU44SEcvdk5EWlAwK3JTRmswc1BMKzNxM01iRk5MYy9BZnYwd3JXRDFY?=
 =?utf-8?B?b3hhaTQzVEdBMVN1dFU0OVMwdFFTVUYzZXpyY1ljNzZwTXdjRHl0blNLbU1x?=
 =?utf-8?B?RG9ESDVhMmFia21DVDNGbHQ1V2EzTTlrdkk3c3JaOElvT0ZJSGNyRnN4ZU1H?=
 =?utf-8?B?S3B3bUNaNUN6MUNEcmhzNmNudjF3N3JhY1hQQUhjd1FaYWVrSGFIRkpPbGJM?=
 =?utf-8?B?RHBWcEtnT2s4M0hGTCsxV0J4VENudlhRWGpDMlF3SWdraDFvdWpsMVhhb0g2?=
 =?utf-8?B?V2pKdEJsSkhVdU5MYjJJWlJBNFdvZVJhdmk0bFJKb2dqQlNWNHg1WFRwSGRu?=
 =?utf-8?B?YXZWSE91YXZBR09MV2VmSHRhVklzcFlDN2IxNE45SXRFbk1TRys3NE5GbUlv?=
 =?utf-8?B?OGRhWlI5ZG04cGM5TUVPajhKV0JuV3JoQjloT1F5RUZ5d0ZvU3lweWxVaFZC?=
 =?utf-8?B?Ukc0U25vdkpBSmNGdXZtMm1aTWQzQjZhb0FqcmErL1hNand5MnZScTBwYmFQ?=
 =?utf-8?B?YTEzLy9NdDI0Rm9tYnM3TC9mWEpuTlA2VDVWOTdNZGNuVXBEYnVVK1pMNlRQ?=
 =?utf-8?B?cThQM01tWXRxRVk2UGdBakV5Nmprd2NIMURLVzFPM1dNTUJMSkpuM0EvOFpN?=
 =?utf-8?B?ak13cEFhdXc3MGRnOVM0Y2pWOGdqRVdyNjJ5QVlEY3ZWaFo5ajV3ZE94SUJx?=
 =?utf-8?B?NUxIYlhLRXVwcStKbW1FdWRwZXd0Nldsd2R1L2paOXYrS0E5Ty93L0pWNzJI?=
 =?utf-8?B?L1NLMEg1NWJXRkNBd1hrTzB2WVFFMVVkeEt2MWViTHVkOUVnWmVJc2hDbjZj?=
 =?utf-8?B?VDF4Q3EwUURUbmR4dUdYNjhhRVp5UzNFYWdrVHJyZVpydFBOZXVIVWRDTDho?=
 =?utf-8?B?WjRFcDVuWFlQTEY0NXVyL3RqblR6Z1hXL3JXblprUGUvamFsSVlzaEZFZ3lz?=
 =?utf-8?B?bEJ3WGZyb3NRU0J4cTBqM0RNRmg1cTFkMnhWRENnNFBKakE0YVZ6UTZ3K2Ni?=
 =?utf-8?B?NEYxc21Zd3ZzUjJvd3ZhUVFoUVNqUXpDSFJZbmVLYUsyMTZGUDI4NnRRNHhE?=
 =?utf-8?B?RVY4ckhVbXlWdXQvQmpKUm5seGRDMmxLTHBRRFFxOU4xOUdPRlRITGpBR2tz?=
 =?utf-8?B?Vkt6U1BGVnQwUmlkK3V1WHdxcUt1S2tTUTVDM3hoWWJPaDk1MGhNK3gyRDVJ?=
 =?utf-8?B?V1dyRXdSZ2REY0I5UjBpTXhTUkxzZ0R4aXhNVXdyd3FpNU9yRHN3MkFhcmMw?=
 =?utf-8?B?V2tDcnBzQ3VTYXVFL1pyODUwUm42VVZEMHdsZUw5eGxxem9XekprTjFnUHBN?=
 =?utf-8?B?T3U0TWxUcC9vNVliaUVpelRmaGNvMVdhcW80R2Q2ZDZGd1lLNnBoSTBXT2Nk?=
 =?utf-8?B?dzgxQ0xDdEJoYmFtcHNXek8yOTR3bkswRXFBK3RkeXF0WS9QYmREUGdKeVdK?=
 =?utf-8?B?bVl4bTRUK0h1aVNVNHhHYWpOVFJIbitTNDRZYVZUZ2RGV1phMHlCelBxSnNq?=
 =?utf-8?B?NmVFUi9LZWJMWlFBTUt1NHdlTG80QnVFNy9TZkl1bHNDQm8wWllsamJJOXdO?=
 =?utf-8?B?ZkJoaGVMb2RHWTI1ZEg1Mk92a3lYa3oremVJUTRJZVlWcDJRTlRCbUYyUFpM?=
 =?utf-8?B?VXp4WGprNTk5d0o4UmRnbkRDM3d5WDNyWW9FVnp4Q2tCbkx5UnlpR1ZpU2pa?=
 =?utf-8?B?TzYzbVVoeWhFTjNOUW1Yc2xKaGw1VGdKTXhyNnA2VUtGZWJpWTh0KzY2dmo2?=
 =?utf-8?B?cENLeGRTVStoTkdxL1pDbUhCZlZuaDdwTFp5VkkxREtsbFBRUnRtQTQ1V2Qz?=
 =?utf-8?B?bWk4MHVVR0JZUW9SSlVndXpQYlNkYmZaMys3anR0VHZSOHkvdXVkOWhTMWJ1?=
 =?utf-8?B?M1VkMmhFamsxaHZwNGxxSkNPZHQyZGViZ2tPRkV4dzR2dE5DR3krVE5wdk90?=
 =?utf-8?B?UlhtMU1BSmtWS3RYd3N4Zlhjckp0Wkg0K1N4QnFTam1GcXRlWFdvdUE4ODZT?=
 =?utf-8?B?ZDlxSWhWTFR2TkszWW9TL0xoSTgrL0NxWXlqTGlYRitGRk9tOUZvSlIzSGFS?=
 =?utf-8?B?WnArL3lwcGFZQWQwVWxxKy9hNDNmNDFJQ2pRZCtqOSs4NUpBSGJXWFlCQ2tr?=
 =?utf-8?Q?k7DTsD0ZK+ZEtamgOYteFocOc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73969db9-c321-4c7b-a04e-08dd1db807df
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:57:20.3464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMaoPzCtzL4Kdk7dw1qd+zFfQNSzQUaP5ww8Z4DEIsKjbz0QofWjSD33lV65VaREEKaNL8V1jqiVHL/GKNb+7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6693


On 05-12-2024 20:45, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
>
>
> On 05/12/2024 15:58, Mohan Kumar D wrote:
>> Multiple ADMA Channel page hardware support has been added from
>> TEGRA186 and onwards. Update the DT binding to use any of the
>> ADMA channel page address space region.
>>
>> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
>> ---
>>   .../bindings/dma/nvidia,tegra210-adma.yaml    | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
>> index 877147e95ecc..8c76c98560c5 100644
>> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
>> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
>> @@ -29,7 +29,24 @@ properties:
>>             - const: nvidia,tegra186-adma
>>
>>     reg:
>> -    maxItems: 1
>> +    description: |
> Do not need '|' unless you need to preserve formatting.
Acknowledge.
>> +     The 'page' region describes the address space of the page
>> +     used for accessing the DMA channel registers. The 'global'
>> +     region describes the address space of the global DMA registers.
>> +     In the absence of the 'reg-names' property, there must be a
>> +     single entry that covers the address space of the global DMA
>> +     registers and the DMA channel registers.
> Rather oneOf listing the items with description.
Acknowledge. will fix in next patch.
>
>> +     minItems: 1
>> +     maxItems: 2
>> +
>> +  reg-names:
>> +    oneOf:
>> +      - enum:
>> +          - page
>> +          - global
> This is not correct. You said it covers both.
>
> You also need allOf:if:then: block restricting it per each variant/device.
I will fix the above concern with the next patch version which will have 
clear variant/device specific restriction on reg-names property usage.
>
>
>
> Best regards,
> Krzysztof

