Return-Path: <dmaengine+bounces-9038-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PmOILjZnWk0SQQAu9opvQ
	(envelope-from <dmaengine+bounces-9038-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 18:02:48 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6870618A400
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 18:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CAE583004D06
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 17:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7835D3A900B;
	Tue, 24 Feb 2026 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KztPFskB"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DED93A7F6B;
	Tue, 24 Feb 2026 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952558; cv=fail; b=SjZ5ZDzi1vCvG/YsmSFnSQLs7Pb9MzmCbaOoXjAcszn8tpsflNnU2sxBvRe4xK+PsOHZ6HOxoEo7MkAjupRXabQdoCdxsHSoOhGN3fZGGh7n8TGpUBWwu8/Jx6UhqpeYRQDYNu/LDSd/6BBchdBcScwrORrkMu+yZ8kyNWVetfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952558; c=relaxed/simple;
	bh=6dZRSAnaHXzSVGw3mwFPwPFAkVU62O9nTfzqiEypus8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MXDQSPzj55UNtpXFMj9XkYyo3bPDcZVHpsk47elda4CqzGJsUFEYsJ+fsYTVJWLeNrLuLEAjyWAnGwyEM3hFnA8aw5QPK8z8J1XK6kjZkQ33T5Wph9LyeO+L7+cHMw0Hr8TQeejKvBhabJsX3VdE3cnKEwpuTVZ+8S9LJhS8BfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KztPFskB; arc=fail smtp.client-ip=52.101.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDbVRRPjLgE1fvpf2ExiVybUt3tYyl3Mz/nz349zXNC+hO2iFEEnPj9w2PgP1wj5Djzirm0m1bh1U9cSd/JPnxJAZRHnYErZCDaMtu7/iE2mut4Jy6NdUBI5yD5rw0Y2yQYJX7hZRjIySh4ddkuqAmOjX7FOwvyXVJMvqfdFJ4Ynu9jN/mufy0Q11J6I/e+eKL2zEWkobu/y9a3j5RYw3hNtW696+RxN+Kt6CjAkntlkBK923N1miISdqTL+K1YtXtv+If9smORa1rWehwiDwXCvO4w7+bFgHPvDiavnnSxE2B0CfRvTdOXKrIkKQMiHeS+yQCKtoR0owtUqo6r2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0j4AT4sbpBZpy64+zQXObZzU6BiRvXHQ4OFiEvSEQnw=;
 b=hKpc2euoVSnVSXBMs6SJFLDnwUUqKiLn84bh/zQZUhilcXuAtnBLYOQWPCnAd3mL9vOL4J+MqzrOnehCq1obZfZDWNqnWZn5hTBWyuSCO/Nm8xCndGhUDXRM1nqk/ObIbg9Z39+fflv+NnBRpae9YFFWpJ7+SvZb/6P25FBGJ5Chzn4XHRN/+7ekOIIzICPegeXoTV6LTi1WZn72Ub0nPtmm27axGXnph2thL4LiXQuiFwazGl7dmhTLuztZ83QE6QfVGKCjc57eID7ynnXzMgb5FrFqzhjRnOFGf+x5GRtZXpgp36qvkuufh4YGuhLKGZf1hGbFCeU9PikO5KQHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0j4AT4sbpBZpy64+zQXObZzU6BiRvXHQ4OFiEvSEQnw=;
 b=KztPFskB7B3lJaJ3Uk0WdU6CLzVZE/J6APVlbjSCTNl10Lfoyr7b5HOP+Klr/PX5dZn6F9S6fuiqYxwRAaK5BdxN1yj9ghM+bH026el8zDGnypN0KLFhBH2Q4w8rXLwc3MeH1RWxhyixfEIUhlshwrMB7KhRvjOH/+C7e2fOoEpZ5ElyxHK0B770EiD4BIWCvoOERWpSi3XlfBpy3jHRtjWYmWk2v5GkI6t/ULixC9NLW1pgwP7Ird7eY2iG91EtPKqQ05UWKlNTG0H4kX4WVCCUensaUNlmJJ/eNFg1FXQHQx3JSXCMBXLT4V6jxg6dnYuacmsVHVsGKgd+hoUEPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 17:02:31 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 17:02:30 +0000
Message-ID: <e7944c01-5ede-445e-94df-ce1006414a0d@nvidia.com>
Date: Tue, 24 Feb 2026 17:02:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] dmaengine: tegra: Make reset control optional
To: Akhil R <akhilrajeev@nvidia.com>, frank.li@nxp.com
Cc: Frank.Li@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, p.zabel@pengutronix.de, robh@kernel.org,
 thierry.reding@gmail.com, vkoul@kernel.org
References: <aZStyRaoMYBlNOSY@lizhi-Precision-Tower-5810>
 <20260224053922.43058-1-akhilrajeev@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260224053922.43058-1-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0029.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::19) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b10118-fd05-43bc-3344-08de73c67ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjVYSDZBaTlUam54eC9vUmdKZHlibXc4c1FIQW1UR0xWM09PQy9KR3QyaGk2?=
 =?utf-8?B?ZTZKNXZXVzU5MnU4U3c2VjRrV29odGpVckdKMnRXRmtSUFVOUklHeFBoNStq?=
 =?utf-8?B?Q05jVmxKUGFxZWxJdTNYVE43Um0yaE1JQThubXhtcVhmQnM5QkNhU2VZbi85?=
 =?utf-8?B?WlFnMHRNZjNxRmlpWUVacjNEL3lLbTBZZm1ZSStPZi8yTVhHWHErSTY0dG94?=
 =?utf-8?B?K0ZVVEdLNnNYZXRlMHNEUE5qMnZtQTFCbDVzWmd3aGxQZ2NLTjlLT01qdmxp?=
 =?utf-8?B?Ym5kTkdqdUV2dWtzeUZHV21BOVdNZmpiSUJRdG04NTQ1bUVRWWVQaWgzVFAw?=
 =?utf-8?B?dTlmRGJLMWlPSjlRclpCeXNzSlZtdFUwZUZUL01tUjMyenZRWG9JZ3dQbUd6?=
 =?utf-8?B?dStQamt0a0RMZnJ2cTlVRVIzRVluRmM3Z09PbDRJSWJlV3hIdEpvWGl1M0Zo?=
 =?utf-8?B?QUFyWlhyc3VDUUJ1UlhrS2hJWVFTVGV1TE5OKzBrRTVhVEFWWnAvaFB6ek93?=
 =?utf-8?B?d0pOOTRwQXdhQ0xTc2djWWk4RlVuZkJZcHU4UHZZaE02RS9XZ2tuYjZOeXJ6?=
 =?utf-8?B?NlFwcVFQemFINVZvTWNXYy95LzFpZCtNVnB6a1ZxNFpEbDlvUGJoV1cwTmpC?=
 =?utf-8?B?Rnh0NitqWndnU1RORUtxMVFvaGdVWGh4TERtMnBOaU9CS2YxMGVBb0hKM1Zk?=
 =?utf-8?B?b3NUcE9IMG1KYWNOTWRsL1dQS0dXQmNKTmpyUGh4TEtvVjJQSkNYSnEwckFq?=
 =?utf-8?B?WXdRaWNGQWpINlVhM2xZZE1GNW0vNjVOT3RNek15bGxDSURpbW92SVFzelZh?=
 =?utf-8?B?WW5rWkIvL25FZ1M4RWVEMElQZDNFYmY0MjJwV2VTQnlYVDZvSUI5WXBDUFNi?=
 =?utf-8?B?L0lzdGJqRy9Kc1N6QnBMa1VhNy9DazNaQ0VaVm1vQ1FoZDFxY3Vwd2xzd0J3?=
 =?utf-8?B?ekkzRmpCMjZYU2VpcDB2V3lkZTVWWjNMYkxOQkxDNHMvZGxNMURHUmQ2QkpM?=
 =?utf-8?B?NVpXY2oxVE9qZmRSUE1RTDJLanZXeW5URzZPV044Ryt4N1V4enM1RlI1MDR1?=
 =?utf-8?B?SE8xZlFudnkwaDltd3BIUzd1UTI4K0d3K0xSTzdwS2grcnJ2QVpIVDY4MzFS?=
 =?utf-8?B?YldzdlJYVkpYREdVdVNpS2daQnVKUnVGNXZXczJ4USs3NVU3WUhtaVhueXlv?=
 =?utf-8?B?ZkVUT3MwdS9JbWwzeCtod3NBdDE1Y3hNaGg1N0NBenJYU01WVnF0S1pvWmgx?=
 =?utf-8?B?WjBwM3V1Ny8xK3JVRkRaczF1WlFxVVFYZDZHdHphL1dzZ0EwMG9WYXl3V1BG?=
 =?utf-8?B?NGFVRXZobW9aZXlIM2J4c2RJK29ETjVuMkRvRXZhWHhaRTF4QXUzc3RsUVF1?=
 =?utf-8?B?eE5GUWQ5QXRPSE4yRlVNN3hPU3Q5Z2lUUDgxbUw0UnExOFMrdmE2MWJ1ZjNN?=
 =?utf-8?B?cytiZUNUMlVjRVAvcDJOK1BrRUMwTVp2WU9HdFc2dU9Hem90c1I5d2xFR0Zw?=
 =?utf-8?B?blgyUldZeDhDaXV0d3hpVDduU0EwZEw0QjRFMk1aWDQ1N0pkWjBVU1lQNER0?=
 =?utf-8?B?djVXQVAra2FTRkhxM2Foa05Rc3FYOUpLUEJzTGhWa3lweE14RHVvVE1adTE1?=
 =?utf-8?B?cTdTWjJidlMrZ1JrTWZRTXZzZWxuOFBrNWN5QjNCYUxPOEFkZFcydTQ5aFcx?=
 =?utf-8?B?V0l2NkJPL2Q1c3lpUFViOFlqNUswVnFBZDVDd1doWWFMdzY3QTllcENBZDNZ?=
 =?utf-8?B?TDM3YStEcEtCM0xiNVlKakdoNHcxUWV2MlNoZ0IzTGNENThRVUpRdlZueHMy?=
 =?utf-8?B?Y1NTRTBYQmxDQ3ZlSTRZNUtLem9ZblUzRWpxRmpiSG1RUGZxMEF2VllEL3p3?=
 =?utf-8?B?S3c0Qm5KaFVUT2hBbmYwWld1WFMwOHUyYnZHbWxXejIreWQ0ekJqK00yZnNC?=
 =?utf-8?B?cUZUQnI2OWFkWXRtajhOZDB3VVFVdzdBZXFXTFU4RGdzNjE2eEpISFl5bDhr?=
 =?utf-8?B?eDk1dTRITm5KTmJsRng0dWlqS1lKejJmSGk5YVROdnUway9CVGZzeUtqV0VH?=
 =?utf-8?B?cENXUDlpTktEQkZIMDdrVTZqVFc2bWxXTlJOTElYUmN1Q01IbzNFTkNxWjFy?=
 =?utf-8?Q?Dp08=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk40WTMrb0xpTzVFNktKU09VdjhQcU02Q3JBYWhoNTRMOHhPRlhLLy8rTGVP?=
 =?utf-8?B?d1FqelQzY01mNUZWaElsVEcrSkVMaFFvVGFxVGpIeHlRRjRrOWhNSHN2Z0wv?=
 =?utf-8?B?UG03MUJwajRQQjR0TVUzMkw0WEgrNTVic2JGNmtpRC9VaWdUVkFtdHAzOTBY?=
 =?utf-8?B?dmowYVdid0Vub1BaMWROMlJTZmNYZ1dWeWdOVThPK24zTEhCbitCSnp0Nkg0?=
 =?utf-8?B?cXpBOGQrSzVTYklwV3VZR0YxTEpTaTJyZmlrbzBxZW9TNXZTZjl4U2cxNFRa?=
 =?utf-8?B?eHJzaHZZWnRSa3VvdElMWUVtMTNBTWViMlJyL3YrRzFYeTFEN0Q5KzU2dWNo?=
 =?utf-8?B?OTlFTHA4Z2pOaWZHOG5uYzM1WU0zRmc4bnZQb29qd1B3a0x3dng2T0xFRnlC?=
 =?utf-8?B?NURrelNDa3pnV0pTUGwwY2hYV3lSL2xRaU9Ca3ZEMW5kZktKZURWNGtFRVZE?=
 =?utf-8?B?WE9GR1BSWjBnamtoRGt2NzIvcTkrSklBZ0E1T1FzUmZweGFrSElZeWh4TFFO?=
 =?utf-8?B?VzJoelNDK2dXbG95SlV5M3FWcUd3RGhmWDBEcXNrL2VOZUgvL0hqbysrUzdx?=
 =?utf-8?B?VnhYRUQrU2xBd2pnMFA3VkFjMkN2amsxanpnalVpdW8rZEJLR3JXZGx5S094?=
 =?utf-8?B?UDZwQzFydWF2dUdqQ1FjVGFkSS9xUTFwdnJVYnFtWmE2UWlOZTl0a2dUei9T?=
 =?utf-8?B?TUJIV0pQMkpVQlpSUkt1YmI1ZXFJOXYxOEZkRXVYcjNQTnhyNlJTYTI0OFU3?=
 =?utf-8?B?L0taaWREOExIcWpaRmZGcTlBTVl3RDk1NUFJYXdkMGd2UXZRZHBIUW9zczh2?=
 =?utf-8?B?MDRBQlV4WGFoWmt2V2toZHc4WURNdGRPR1V1NTR5OUtIcnlQbXFwVlJuQk9u?=
 =?utf-8?B?MjVleS9rbHJ4TFV4ZHltbk5UODVBM0V2bGRFUmk0Nzhic0R5WGE4bHVaY01D?=
 =?utf-8?B?NG9HSjJLdVVyTXhOMzk3VlQwSUxnZ3MxSkVrRktNVjMvR2g2WEJYNkJWZnRn?=
 =?utf-8?B?SHhXQVNQZElKU0hOdzA3N2xqMy91VnNpanM1eWMyZkNDMHl6SEhJTDNXa2JE?=
 =?utf-8?B?bk8yc1dvYWlJWnY3RUF0WUxFTkRtdXQvUUZkbXFvUjExOWNieVBQSThsbCtj?=
 =?utf-8?B?ZWNHYngzNEtFU2RDWDVWM2ZtZGg5Tzl4bjhWZFAxcjZaOXJSeTRZRyt4M1pH?=
 =?utf-8?B?aFpHRjhpYkVDRkxVZmwwcGErdE91UzQ0dzh4aUpJRGl0QlQvdXc5N05TOGFH?=
 =?utf-8?B?NGdFemxuQjFSdTY2cTY2ZzJKMHZMK2JhNmZ2eS81OUR0SVJOVEJOQ0d4RXYw?=
 =?utf-8?B?S2VkQ2h6TVd5TXdrRFpuQXJENkhSMC93bjVTQUo1dFdMS3R3eVBDM2lKbmFv?=
 =?utf-8?B?TWw0NjB4TkMzM25lWmZJbzBLaVdYL3drRmNrYi80SUJNK0lVZnZhT3N1MjEv?=
 =?utf-8?B?eStWS09CU2JpZEVkMlQwMndyNTVRcUMzSHI0M3JzV2hPR1AzTUpCVDU3c1Jl?=
 =?utf-8?B?VlU0OXpiMVg0cWp1Y0o1VUtQTHBZbzNrRmJpeG9SODl0anZ2eHo3VGZUamxK?=
 =?utf-8?B?RkxmeFY5b3RjQ281c3NXQnVqNjJGd0dTRXBzbmhJWmNqVkpqS2JMNWhqa1pV?=
 =?utf-8?B?ZlllRW5tdlRVMlA4Q3Roay90V3Rocjk3WlovV2grYWtOTUlzL2tNMDZDamo2?=
 =?utf-8?B?SjM5Z3lwbEphQVlpMnJNOWNMR0pwZUp0d3hIbVFmQ01YOC8xQjNNc09yWjJi?=
 =?utf-8?B?eWs1d0d4L2crSlZsMEpqWDl4akZzT0czY2YvS2dpY0xZSzlINGpJWUppbXlr?=
 =?utf-8?B?TkNkQVpxMThkRHRSOUZkcURJSWphbk5DV05aeEp4bzl3NTluZm9Ydmx2a1JU?=
 =?utf-8?B?bHlFVSsyb1RFaEI2eVljR3o4WjdKUjdhejRydmJCMXg2ei94MjJ3U090YnA2?=
 =?utf-8?B?a1VjQUJUeTFqekJJbmRYU2FxZ01RWGQ5MVlVSlpQL2lYSzFiMDdOUHY0NEVZ?=
 =?utf-8?B?WnE1VUwxbDZwWDUrYkxBWU5GWFJycVBWUUx4cDRnTnZqYm91b3VLeXNmaE9h?=
 =?utf-8?B?Q2FobG8vaWxpNjA4Yk9mWitORDFCVVhZaFI0V21Wb0pvNWJCak1KRit5WHdS?=
 =?utf-8?B?REZmOVdicnIvV1ZHeG41LzAxL1ZKQXJDcXhPZlRhcFVrMWJ0QTBRUHpZVEhr?=
 =?utf-8?B?NkpWSG5ZRVF2aG5ITlFwSjlSVHVRYTlEeG5XaDhaUEx0cFc2MWdBdkFlMlRO?=
 =?utf-8?B?M1kvdlhhYTBFRzNkRXFzWnVucWFIU1IrZFBoc2xQNStjcFZOMHRmMFlBZG1s?=
 =?utf-8?B?N2JlOGJYcEpWV0dlanBVSjhycWU3N25YYnFkNjZtOW43YmZPWFJMdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b10118-fd05-43bc-3344-08de73c67ec9
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 17:02:30.3154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgiqWsUW6tooOEA7mz5uWLSZsRvFZVa9Yytelzhg4druklE45O4XOfnNuKpbJNp4TEsp3hReKA2VYfmQhl3eCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9038-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RSPAMD_URIBL_FAIL(0.00)[Nvidia.com:server fail];
	RCPT_COUNT_TWELVE(0.00)[13];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,pengutronix.de,gmail.com];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 6870618A400
X-Rspamd-Action: no action


On 24/02/2026 05:39, Akhil R wrote:
> Hi Frank,
> 
> On Tue, 17 Feb 2026 13:04:57 -0500, Frank Li wrote:
>> On Tue, Feb 17, 2026 at 11:04:52PM +0530, Akhil R wrote:
>>> Tegra264 BPMP restricts access to GPCDMA reset control and the reset
>>
>> what's means of BPMP?
> 
> BPMP is Boot and Power Management Processor which is a co-processor
> in Tegra and runs a dedicated firmware. It manages the boot, clock,
> reset etc. I will put the expansion in the commit message in the next
> version. Do you suggest adding more details?

Technically you don't even need to mention BPMP here if it confuses 
matters. We can just say that for "Tegra264 there is no reset available 
for the driver to control and this is handled by boot firmware".

Jon

-- 
nvpublic


