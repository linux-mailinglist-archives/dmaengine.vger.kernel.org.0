Return-Path: <dmaengine+bounces-5109-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A79EAAF849
	for <lists+dmaengine@lfdr.de>; Thu,  8 May 2025 12:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7513AD404
	for <lists+dmaengine@lfdr.de>; Thu,  8 May 2025 10:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C0622173E;
	Thu,  8 May 2025 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ga6j7iNa"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D8C220F4D;
	Thu,  8 May 2025 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746701123; cv=fail; b=UyvPBoWaUj417vXFOedaEwR3E5x8DBIOiNCXUuHpK6/0BDyrCwSHNZzUnQZYi/U8udQD/hmS6gMx0pSCv1u09QnJ8MzpyC4j2BXEyWm1ZY8TzPbIF5YX9sf+IdRMfWIr9hjkoyXx1djinmf8pQhwL29B8Dgf+iiMlXnw6iGlDeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746701123; c=relaxed/simple;
	bh=kLLG9nn3X85UlX2DlicETG+x5ZyTOGpYOZvAMbklBbw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PYS/hUl6SCVkUN/CUpdbaKaN/zRkEXHutxNE2uEXTfMEO++CACuWQ5AO4M9SdSOrRgUMFl9+s+PcvgzyQF3qDlCEaRDJ/7IH/POfojPPdtqKoYv6b6K53vjejiEXUcrXJphY6UDcfAB+sRVY1do2oau+tpaM+oJYZ2vXwWFaXZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ga6j7iNa; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+NOMs46U1ltR0xCvIYD+KYMZXIutAR/kxqSyzggdCwc1JRmSvYxTGpudVa8enRglTz5vOTDh0T84C/dS2yLXnD+hBsjpqLB/98jrbXbIanYfW5PRZS4s5vHPseP/sCawnTL0Gs+cCzrMQs/xjaYwB4e1+HgT0orhVLi5jLg44OxRZ+t3Fyom3ggmCfjmVq1lVZMU4nfFwbipUUip4aF1JI9wPH1nOkBTtAE13cMS3ao9O7pghoY9DjDyKWQlHXtj83IXdVQkM+09YfaqYDzNKEjwgE0jLL85Iuxs2Gn5qGkqRH7nW2P1zTF1AwTNxn5wvQpYc4fPtz919YwUz6ynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/D12xy12xvXlBwumMfDELx2tiBdtzDjgPBvGh20Px/g=;
 b=aP/5QQt2ZoCJA004JhV5LXznfz3B5xBitMC3bBV0hgKLYoCWMiCE6tOGScrOGRzH6BWDLqesEVwcc4NulOZGOy0esPnYgnXa2SbKFcwy9YadQgt9+rGlPI6bxufaZnWsU2SES8vj5R77WpymysmVWTNvx8D51wanLdIxW43/HLXJ1OtL9GneJH95c08jc/eXlTeutvO1zWjheg50DEtbYPSxE+4bdleGY2J22EpSTeCr/cOFj5DNiBmkmDWSLfh5caOgii1PwGWJkoVUm2KE5ylkwoj86dm9OLjbNGIZP4DpmenNYR2P2RgD4C1IZpk8xrc2o1e5Kw/3f/WSWs4HJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/D12xy12xvXlBwumMfDELx2tiBdtzDjgPBvGh20Px/g=;
 b=Ga6j7iNaM97ve0wL4xxB7d+n6X2lc8fXeohRvGF5dRXqj+ljqrygr7HeY9hjDi+Rrn4/dKZF7CGxLXZRBFImVHr6C0pig11JqJqm9XQizBQ+WWTphMBzE6CC3gYIOTOLU9pYE7iDyY43gLlvX7XAYZzQpCtykJEmx01MK4cj5ivDEIyzTjIo7XsPizo0tovpcMQ7LAwoJ9bBrBhzVEISsVPBorbkAEq0couOp5VdmlZGl9IzaxUVYwzWvVO+EK7PoyL6XV6J+Sc8dYkCeLBPHZiVkJg8XzAN4iOxpzNg+U4VxMRP5iE3UeeewD30AzJ6C/pwew0Uy2H1Cg6loqnOGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Thu, 8 May
 2025 10:45:15 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8699.022; Thu, 8 May 2025
 10:45:15 +0000
Message-ID: <7a8cc7d9-30b9-404e-8456-8ad362440561@nvidia.com>
Date: Thu, 8 May 2025 11:45:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] arm: dts: nvidia: tegra20,30: Rename the apbdma
 nodename to match with common dma-controller binding
To: Charan Pedumuru <charan.pedumuru@gmail.com>, Vinod Koul
 <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250507-nvidea-dma-v4-0-6161a8de376f@gmail.com>
 <20250507-nvidea-dma-v4-1-6161a8de376f@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250507-nvidea-dma-v4-1-6161a8de376f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0490.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::15) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: 08dda5f4-0430-425f-112c-08dd8e1d6aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0F0TG9nUU8reGhQbysxb0ZNc2dSWStiRHcxTFBUQXRSZUJmVmFrRmxmKzlr?=
 =?utf-8?B?aUIxbjhTd0hqODM2ZmxmTHluWHNhZjgvUWJMVmp1WlhyNktpSXVUZWJLbWp2?=
 =?utf-8?B?T1NITUUyTkZnNzR6L2E3b1kvUmNOUEZPVkdxajhXYk9wQU04UDZzODBhdFMr?=
 =?utf-8?B?M1ZqN1Z1dGtoR2NEbGpHUklTOVRNamp0R1ltaWlSeE9kVWlCL05uNHNHVXpB?=
 =?utf-8?B?WXgxRGoxcWFxY3Y2K3hvNVNJVVh6VEVEeExKOERIUmE5ODRWVy82ZnBYdE1o?=
 =?utf-8?B?bjVETXREY2svSjlBT3YvTTc5MVRMS1A2MHk2WGxvZWxZTlc4eWJtVkVudGVw?=
 =?utf-8?B?K3lOaGpFR2FYR2p2R3ZJS25nZ0VuSVYwRyt0RlNBTTk2OUFKMCtvZXpMZDhH?=
 =?utf-8?B?L1FPOGZWd2l0K3BnYVhXTmlaRFY5WDN2NUNIUDl6S0phVmJBbGx1WmZrZHJJ?=
 =?utf-8?B?bjVvSXdUbmNWZm9TUTQ3d2s1Ym9ZcnV3M3d6R3FBV3pHWVZaWlZ3U2xid1BO?=
 =?utf-8?B?a1pTbXN6SjNhTlR6WlBHODA5ZVBWQldMYWdBV3ZKWU5Ianl4ckhzM2dpSVh0?=
 =?utf-8?B?UE13QzFwenVNV1M1ckMyL2tHellMaDVKNkpCNWFJL2dJWStIZVV6MUJlQjZa?=
 =?utf-8?B?WVNJU3NtQkNWbTMvV0s4ZnhoTWU0N3ZNMjBKNW12OXZEN1hBVldNQUFybWhs?=
 =?utf-8?B?cVhEQkg2YkpveGxLbkFHTGl5WjYrMDVLOEFxOHc4TWFSYzVuOCtRbk1jQXFr?=
 =?utf-8?B?SmR5Y0dVbnJUT3laeTZoUldUS010MmtBZ0JIS3hxR0J1dHBuRVhFbXpKclUr?=
 =?utf-8?B?aTRVQjBxT3ZUMHR3NWJFbWZsY3pQV2JBYlU4UFdzWDd6d2NNMTVSWHhBNENI?=
 =?utf-8?B?eHIwa29WR3ZmZEVyY2J2WWt6aTRtak5PZjBIWUhFYkRJQWVnRm5DeE1HUDNN?=
 =?utf-8?B?V21aNzl4eWdMMjBnQkVnc3AyYmIxenBxYjQyYVhCbUlWSGkwOEVzMitCUDBh?=
 =?utf-8?B?UE5aZXUyMnpNOE94YkJXNTdVT3Ira0pWMStQOHlRNDZuVG9ZeWNEcXM1STVx?=
 =?utf-8?B?NWFQSjZFS29oQmhBNll3NlpLUTFUaDVjQVhMY1lTd0tXQzZuSzB1c0FzM0V2?=
 =?utf-8?B?VzhXQk9zbytEMSt1Q01IU2RQbm9Pa0gwMXdJVkZidEtGK2p4OHZYa0VBWXJS?=
 =?utf-8?B?dXNLS1RJSEk5VHJ6YmJTRmJWczNQbVQ5b2Q4RnpCakczaldlSXNVZkJIbWtB?=
 =?utf-8?B?aXpNWGhHZkU5NUVNUU5aUVJqWU5Gc2JzYUVPanNjNXM3UytZM01mZDhvMUtF?=
 =?utf-8?B?VDU4YTNENTBPTGtsSVNIdld3aDFjZXdZYUxaV24zbnl5Z3J0YjVoOU9XdlRL?=
 =?utf-8?B?S21tekh6M3U3YkFTeTZPL2RaeHFZcGdJL1c1UWRlTGFUbkkxYjNHUkwydkdh?=
 =?utf-8?B?aitSYU9NU29INVdvQTJoeThFQ0oxTDJZaE1PamRpMlBVUnNIaHhVZUNDVXM2?=
 =?utf-8?B?TVU2K0twdWxtWTRBOFRKUzNiaGh6QUViay9SOURsZS9XK01HemZKYmRuWnp2?=
 =?utf-8?B?ZGtvWHMyMWdGTnNlL1BDa0pLV1U1d3hMZWt5S3hLTWVUN2VZZ0VNRzlYWUpr?=
 =?utf-8?B?R1A3Wmh0azNsN0g3dWhCOURSZXBtWVJyQ2RDb0E4dTArQWVaRW1QSEcrVU9p?=
 =?utf-8?B?MzUvSVFqSFR1emF2L2pHLzVaOTlZOTFPdHl1b1hXb29hdFVpVnY0OElGOFkv?=
 =?utf-8?B?bVZUQ1laQ0FncmNUcUJLM0dhTEN3SUd5VDR4TkQreTdiS1VqQ2pBY0VCT25T?=
 =?utf-8?B?R1ZZK3ZZRjVhR1R6QksyL0VUdVYxdU8rYjRIbHdoWGtiMm1qc2ZsenlwZnRp?=
 =?utf-8?B?YnNQdFNaY2tMWXZ3WGFMWW5MRkphOHVsNFhJd2N5aDZhdEgySHNicUIvNnda?=
 =?utf-8?Q?sg4dhwnSwr8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1pxY1dNZmpTUkZLRU5kZG80N2ZGTWxYbitLK3dJY1M1T2hSWDVDeW9rcVIr?=
 =?utf-8?B?cklVbktTVE1yOXBqWlRxZHpTTWdZMFYzbUFzNXRYMjRQY3Nic0dWcDFydll2?=
 =?utf-8?B?cy9WSFBuVmkwL3ovM0FQTHJFWnR3VEZ1SFVQc2hjL0lobHlON2k3Q3RJVFVL?=
 =?utf-8?B?ZXdoZzlJYW5yNG51RzJNL2RsdWZDN1ZqQ3FlUG04UW9PcGYxZmo0OXJVUkUr?=
 =?utf-8?B?MkdvR3Q3UVUrMEdiaXNxS3NqSWFtOHM4SUQ5cjl1RG9ZbndFbzErMld4ZldB?=
 =?utf-8?B?Qi8vWGlpbFhpWnoyTmZacm5uRUphdlhUZGltU1RzK0llNjVwN0VJT3VONWlk?=
 =?utf-8?B?UWlER2VQWFB6b3MrOHg5cnVTL0NpSzBQdDEvUEFmcVZtcVQxTlNuSUdnSnZv?=
 =?utf-8?B?Mk9HZ1JOdk1BQlZuZzQrR2pwTlhUTVRKN0g4eEU2Z2xHTXp2aDN0NTBWVmN0?=
 =?utf-8?B?NitCWGdCQTN1UGtTNnhEcXJJQlIxZmVhdWxTcFY4SUJKNUg2OHJ3WkdKc1dj?=
 =?utf-8?B?WFZYM3Z4c1hwdlhMa2h2RUVlaWIxbnBEWFlwUklBM2Q4cnVoRTZ2Z0Z1c2Fq?=
 =?utf-8?B?R0pqa0pXOTNDNXdEN3JLMFl4b3l2eWQ4M0Y4RDFoVWZCY3dpNkw4aGs0K2lX?=
 =?utf-8?B?eHJuU0ViNVhVOWlTN1phV3BGTnlwL1Y2Y216TCtZaWl0anJOTW91MFZWVkV3?=
 =?utf-8?B?Z0RQNXZURkk3SHFRMlpwT1JKMzhNOVFJTk5vbEZLcWF0bmxWeUdrQkNUMEc0?=
 =?utf-8?B?RVY3TGpqc0dEUm9zaGlRRnRyOThsQW9tVmo2Rlp2TXhRemZEWVFsd3B1d010?=
 =?utf-8?B?RE1nV1JXdTdtbjV1dnY0Rzg0RjV1RVYvb3ZYS0FkRnNZWm9uelpCMnBSVWlw?=
 =?utf-8?B?bDdHZ2J3djBVRTcxN0RWaWg0bko3dEF6c3QweHRoM2ZzL08wQzd6aCtuK0cw?=
 =?utf-8?B?QTV2MHoyTHowSmkyYW5XOEVGSk85N1ZwNExpS2pHZXJzTE5ISXU3N3B3VURp?=
 =?utf-8?B?elZIdWRGSE1Ram1UN3BGNUJnOVZLZDFtMUVuY1puMTZZS1BKTTFBSXUrVHha?=
 =?utf-8?B?dndyRWVwcm9JNms0WVRFZExBZzBsSXpQYjJFMm1pRHczcEFpcVhHWmlYWnU5?=
 =?utf-8?B?UFNIY1F0a0NWSzBTOEN2NEVXc1pmL2dXMjI2MGxDLzNHK25ZMGN3U1oyamFW?=
 =?utf-8?B?YVJzSjVNTnpvSC8yYnhwVnJMdzFreFZDQWpGZm01VzNvYWprUlNFTUFJY1NG?=
 =?utf-8?B?ZzRkSkhnOEtJN3Z1VkJzM3NtTVprbjVtMEZPZnN1dGJwZFY1T2hnb013b1Z5?=
 =?utf-8?B?aHlrUkxvT0xTNERyQVRldS83Snp6cFRYTVM0L1pMZ21xWktRWlFDeDA4Q2xV?=
 =?utf-8?B?Ukc5a3JEME1ULzFsTmViNmR4Nnc1Uk1wdEwrK1UvQk1ONmJIYzZuRjVFelA3?=
 =?utf-8?B?U3NwZWdvUXBKUEpLV1NCcmNVTHFLZ2REMEJjc1dHc1lOVnR0eHFmSlo5S08r?=
 =?utf-8?B?NW1ra3dOZ29ZWFdNb1lMT1ViT01lRWF1YTRTN2lZRjBBVnp0NlIvWlI3M2Z5?=
 =?utf-8?B?ejJmY1lPOVZ0TkdMYkZpKzduSHRRRFFQZ21xZXpOWkczdGRUOEtSckpNMEhj?=
 =?utf-8?B?TEMxbFBmQUNhOGFUdytHRGJVYWpQbzZyeDRDaVJtdTMrN2I2MmhHZmkyLzMv?=
 =?utf-8?B?MFRVdUJaNHFaR1ZnUjdhcjBhbWRYK3NhcWpaUmdabHkxY0h2TXRiTWlFSGxx?=
 =?utf-8?B?b29LK05LMlZCU1JWdWc4b0tsdFZVdlpJR3B6VzZRZC9DQWRyc0xZclRCdldq?=
 =?utf-8?B?czR2UGxlSjc0c1IwTnFndlRVK3d2TXhOdHlNcERqbWZ0dE4wdTk3ZXBzZURY?=
 =?utf-8?B?UG1MYnkzNUZXaElBSmhYVkcwNzJmNGZ2cjlBSTdBakZyWXJPU2xWeUpNZFFk?=
 =?utf-8?B?eEtmNDR2M3FGNlF2R3pRQ1dET09wUVhLbEMyaUx5c3hRdGtkRTJpVTlMT2NM?=
 =?utf-8?B?em85a2h3WThuSFJBNTRWS2JlRGNJVVdNSXhRcDBVWmM4UXhZSitYNTZhZ2xR?=
 =?utf-8?B?Y2V1NDJ2VEwxVVVZeTVHWFo0U25ZMnovSGlBTW4vR2hYRFVUNkd6ZU5EeWJv?=
 =?utf-8?B?SDc5S2RsOXI3bWVXcjAyS2duc2hUKzAxNXdQRjVCcVdRNTVvcmlsQkZWd1Zl?=
 =?utf-8?B?WGc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08dda5f4-0430-425f-112c-08dd8e1d6aaf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 10:45:15.2954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7Oo7AE0LtP7X8jlW7s9Ok2hOBc/D/3tlDVkR8g4jbUe/ZVg22E5wehzY4k9TN3eLUw+PzpbsFCWGFfY2eA1YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533


On 07/05/2025 05:57, Charan Pedumuru wrote:
> Rename the apbdma nodename from "dma@" to "dma-controller@" to align with
> linux common dma-controller binding.
> 
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm/boot/dts/nvidia/tegra20.dtsi | 2 +-
>   arch/arm/boot/dts/nvidia/tegra30.dtsi | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/nvidia/tegra20.dtsi b/arch/arm/boot/dts/nvidia/tegra20.dtsi
> index 8da75ccc44025bf2978141082332b78bf94c38a9..882adb7f2f26392db2be386b0a936453fc839049 100644
> --- a/arch/arm/boot/dts/nvidia/tegra20.dtsi
> +++ b/arch/arm/boot/dts/nvidia/tegra20.dtsi
> @@ -284,7 +284,7 @@ flow-controller@60007000 {
>   		reg = <0x60007000 0x1000>;
>   	};
>   
> -	apbdma: dma@6000a000 {
> +	apbdma: dma-controller@6000a000 {
>   		compatible = "nvidia,tegra20-apbdma";
>   		reg = <0x6000a000 0x1200>;
>   		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> diff --git a/arch/arm/boot/dts/nvidia/tegra30.dtsi b/arch/arm/boot/dts/nvidia/tegra30.dtsi
> index f866fa7b55a509a0f66d3e49456565df0d74a678..2a4d93db81347e3e1dd942e6c10a1ff5683402e7 100644
> --- a/arch/arm/boot/dts/nvidia/tegra30.dtsi
> +++ b/arch/arm/boot/dts/nvidia/tegra30.dtsi
> @@ -431,7 +431,7 @@ flow-controller@60007000 {
>   		reg = <0x60007000 0x1000>;
>   	};
>   
> -	apbdma: dma@6000a000 {
> +	apbdma: dma-controller@6000a000 {
>   		compatible = "nvidia,tegra30-apbdma", "nvidia,tegra20-apbdma";
>   		reg = <0x6000a000 0x1400>;
>   		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> 

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic


