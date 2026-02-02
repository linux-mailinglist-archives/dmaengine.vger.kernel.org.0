Return-Path: <dmaengine+bounces-8662-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFBBNpdegGlj7AIAu9opvQ
	(envelope-from <dmaengine+bounces-8662-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 09:21:43 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EEAC9A3F
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 09:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26D8B3004246
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 08:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F7234E76E;
	Mon,  2 Feb 2026 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="PypnIXHj"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023131.outbound.protection.outlook.com [52.101.127.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C17D34D4FA;
	Mon,  2 Feb 2026 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770020499; cv=fail; b=hJDDAavNC7lPJYoKmmcKJ9vM1e/D80F4HwyCzQSPhE9YNJ9ZBNzrgHCEaXDsopQlF5964Az0AX2yYDtSP5wqbIy8Wuq/ThKcR2TYsKJPiHR8X40vr+kbkPrBPdH3P/iKxCVcF9UyzS5KLUgqkCMOU666atOljufu5d+k6D6cJVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770020499; c=relaxed/simple;
	bh=im40d93y4WTI5f0CniWyaIgGFNL+3yeOlWAevnF+Qw8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GqNXZMco1WrERXBPCj9wq0LdB5Fgj7jQCFHMHcmcSExdUNSiRAmEKweTjiJyXZ68o9eX05TWBiexASjv2EbTmODin8wEGHYqXgq3ewmEjTEfdzSfunsrtqNNiRzJNvZYhdLn2nQp1THiivSJeqlnOsEBFHM5gN/CHUjNITplG8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=PypnIXHj; arc=fail smtp.client-ip=52.101.127.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/YRJV3LhK1HProKj6MRQByrkCawjVHGpU2cMeZttw5xXGy5k3fQeuCDSifhv6J0KEMMO+G9WnwSVUliOYcp+N85QRIx9Xblwi4kmnvcQm2iCNnqlayBzjFRx7k+jUpPp9TTjTZwVpR3ZyA/hrVR2mJBf0vaBmN4Ie4FC05t9kBH8403ve0NyMqBpIMBl5WloTpTeIeq/WSSq4bu39Yr46xnnWhIjMyskdV5nHRROxMDBnnP8qZ0KCXf2/wvwVXYBdGI30dealZOGDQ/nywMXnX04XFnrNlO6QZ1A40daBt+Pcu9iV4IWFJlXW3iOx2NvmdFpeTk1SlQkj6GCsOtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDjqwS3OiwgfrdKM7uUMK33t5x0fiKeHz7beFcyE1Zs=;
 b=R3fwraogeZSy6cfttXmTbEMpxuLqV9jVkMiuQyvA2tNpk+o1wBn3jA8Z5QTT4gzHIopfbWrF31ub5TKNh5wkQAXk6A8PBmPcpyfnhwBh4h+5IUVs5L7QEyVHch4pktOUY1pmjddZGSiJ9up8uL8yIXca9Z/SbOupLN0bIMomAW0Ro36klFmnR6bACG5Fz0ZHZ6GGQoQPxcXQYGAISu8YKw0TVqvzqCZLwRhT53lG89VnwfoGyrbAeRSsGgNZjj3toWWMPl7h/+pC14fv+kXbMYVHUIMcv0DlPs9dxxis5CkpjH0bKJut/nxNm7PMp+o/ColRzCF3XVkKI1Bob3R2xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDjqwS3OiwgfrdKM7uUMK33t5x0fiKeHz7beFcyE1Zs=;
 b=PypnIXHjdKkwf1PkpGnkwv8891rFu4xWCpcoGpAedFaEe0b2tGluOVXLFwzLiL16hvfCCYTsl2M/QeOIzdYW8lgGra2RiVH/DuzMseST4qZrP119ohQ6oGcnRKThL109e18hJCFWtJJEES+sW9vcz2OZHSNG0sGMPMp8DW267WeUc0GHYpLP2lIi+1C/VmFalD01JuDb5p4CBP4kVq2kupMqpTQ2vac77Ng0PFnIPy4GNWqNbpBWIY6jBTUVWvoK6aijFk9YsKE5b2+lgQj4E2O4NG2EzkoqSMLztj3YgqPCvqz8fbCBCxZNieW307TKgeUKU8Eg2cMNt/oeaV592A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYSPR03MB7912.apcprd03.prod.outlook.com (2603:1096:400:477::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 08:21:29 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 08:21:28 +0000
Message-ID: <734dfc87-e3b6-4e54-a2c8-f6c01c81c2d4@amlogic.com>
Date: Mon, 2 Feb 2026 16:21:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260127-amlogic-dma-v2-0-4525d327d74d@amlogic.com>
 <20260127-amlogic-dma-v2-1-4525d327d74d@amlogic.com>
 <aXue7DTy7mgwxeks@lizhi-Precision-Tower-5810>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <aXue7DTy7mgwxeks@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYSPR03MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 741663df-893a-4132-51e2-08de62340fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3ExT2VrdW8zNWhzeGdtWUdxYUlDYzVDK21oUUt5OTJUN01RRGp0c25VYlMv?=
 =?utf-8?B?a1I3cFVDblgra1oySnczTVBLaWZjVjkxOHhGeDZqeGRBNTRTWnNPd1NTb0h6?=
 =?utf-8?B?WVluWFk5c3U2UnVqUkw1eW5PL0hSNzFTcEE0RWtLM0dwRkdWSkZ4L2F0bVda?=
 =?utf-8?B?bWxWbzFBRWxuWXBoK09hQy9DOGhab1ltaGo1ZllERUk5aUNzZ0dxNm5SVUIw?=
 =?utf-8?B?QXE4Wk1uV2tSZzR6TFdqTlBncVB1Uzg2a1Y0cUFsMWlIVkd1WVI1cFVHQ1dk?=
 =?utf-8?B?eDF4WWtmdlNGY3dBcmt1MHNPZUFYcGtVbTQvdGl6RlBoNmlVcmdmSGRnME04?=
 =?utf-8?B?NnBoa0s5bnpxMkIvd3ZQOVdSZXNxdUdsaWlsQ1h0OHp4dVM1OUZWbmo5cnk0?=
 =?utf-8?B?R0tjTmtJaTIzRUVvSnFtUStDKzFxbHl1S3VtQzhWYlVKZklVaTB2Q3lTdmZO?=
 =?utf-8?B?TUVwbjFiMDl6dS9xT1ppSHlCT29iN0tpeVJOaENGTDR1eGNoMmZ0UGp3QW96?=
 =?utf-8?B?U1ZkQkJQRGU0QTVhWDlBNjhJWWYrSDNXb3dBMEhRRTFHVnVzR2VuQmtIWDRj?=
 =?utf-8?B?TkpMUC9jbk5Jd0NhUlV0b1l3Nks2SVZtV2Nvc3pzWE9paGwwM2RyTmdUekZP?=
 =?utf-8?B?UkVxemQ5QVVoZGVMT2xqaVd4MDJDaWdjZEVZQXIvK3Z1QkxHTEt1RkVYOG50?=
 =?utf-8?B?eHNyUGt4MThtbDluVVdNTE92bm9TRzZISGp1Mk1nck9TSzhBTXNNR1BOQ3c4?=
 =?utf-8?B?eHc0RGlKQmN5bjRkUXVTQnAxTjhPb0FZNFA3OUhVYklhaC9FR0I4bWZ2TGl2?=
 =?utf-8?B?cWFDbnBZM3RpcEVGS2t5bzNaanVCcUVTWG81bWRpaHU4cWx0cUJLVFBBVGVX?=
 =?utf-8?B?clluT2hLeGsvUnBkT1ZaQ0RWSkwwazc5RnlJbC9sWjZSQnBOSVlZN0lTdVRq?=
 =?utf-8?B?d0g3bStKYjBDMjJtanBlZ2oxK285WjdFMVdzY3h0ZElYVFFTR0FUVmpLeCs3?=
 =?utf-8?B?RHJ2bWtXeEE0eTNReXMzdjNLYkc1VkRqeFZ5aVRlNWlrc1JacENTTjNVZkN3?=
 =?utf-8?B?c0M5a3U0aWRwRGVBVHR3bEhsaDB4NEhhTDhTU1ZZbGdJUlRhamtzc1dYT2Fy?=
 =?utf-8?B?OXVuT3lKYXMxVDR0WEwwWGcwOU41Z2o0SGxDaE5FaUtzaXlocGtRY2gxYXYy?=
 =?utf-8?B?RmVWRlA1UmJVYmhJeU9qNnlWcG50c3lQdUkydWxVcWhoQXdNMWNQN1FtL1VZ?=
 =?utf-8?B?RE9rcHU5VXVaakdIbHkvMERMbFhXOHBZYXhpc0NRbnJnUjB6WTdPOTNNNW9v?=
 =?utf-8?B?MURQQVZuMHRhdWxkYWRKYTdyNW9NQjJMMTFzMzhvMVlDSzJPVmRKQ25YcHlp?=
 =?utf-8?B?cmUvR1RFR1A3RlY5eUN6aXFjaDJTdlBjM3VJcUZ3UjN3RUdLT3RWd3N2Y1hP?=
 =?utf-8?B?REtmVUJyTjMwdnZFa1oxNzVtQWJ3VkJRbWd4SzA0bUhuTXgyek1jNi83cjRp?=
 =?utf-8?B?UURCbDlESCtodkNteHNHWXM3UmRWYlliK0l2L2RqZU5CcVh5UURocy96cDIw?=
 =?utf-8?B?NkErbStsb2hmaUZXZk12SFlDYWF3ZzlrcGZYUDZVVDJsTFlVN2tMMmlsOWhs?=
 =?utf-8?B?djVCbG15V0ZQb1ZocGtjTWVIam9CcXpjeXlBWDY3QkNLaU5zcmJUaXBvYXFz?=
 =?utf-8?B?akRKRkQ5eHV4VjZNYXcrazdMUkZPbVRaZnY3dFA1bkJMR2RYN2NmK1h5dlZX?=
 =?utf-8?B?M0hwSUZxb1MyM0tEQ3cyekE1cFhKWXc4b2ovS0U1NFdiU2lLdjU2empUcWdl?=
 =?utf-8?B?N2pVSWFVRHhUMUNxZkJPOVYyaE9DRGxERi95cjRNdzFQM1V0c1luUVRyUG1w?=
 =?utf-8?B?R0lNeERtQnJDcEtZZFZyaE5XcTVraWhibEV4L1FLUi9hek5XQ1ZyR1dNQXBy?=
 =?utf-8?B?M1FsNHh6TERaTjl2em00UFY5ME9yL2hJWmhwQVlGNTI4Uks2RFNNYWlSYVJY?=
 =?utf-8?B?czljSzNYK2ZDY09BNzJsb0RRWHNZeFFkVnVpRW5EcEJYWjNmVnZPMUkvZVlv?=
 =?utf-8?Q?dHr7Q3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dG9yNHl1QTBTYktxY0hSQ253U0RnVksyTWx1NDc0NlJVVmNRR05ncnpvQWtZ?=
 =?utf-8?B?YVFMR0htUEVMdVpySTBJNzR1TkpTNHhwcDVTNXhPcWJIUTRmOHhEUTNyR0RB?=
 =?utf-8?B?OG42ZzcwOGVVWEFEWEs2NExnSWttdU04a3BOSGg4MFpZeWc0SlgyVHNoazNw?=
 =?utf-8?B?eDNYNmYrNDlwTHJDSGE4UHNSSHVhSWIwb29GQVBKRXBmUStIZkRzUTlFTDR6?=
 =?utf-8?B?Qkh4RDJTM21uUDBHRDhkOGJOell0OXFpUGx3bkRDUWpybXVlZi9sVmpmN1Np?=
 =?utf-8?B?YU1xMGJDNndLb2QyK3RMM3NONDIveEdNZTZUSFBPU3dQTGdXTE1FQ0FjQlpj?=
 =?utf-8?B?SmxnSjM4OFN6NGJtbEZvUUJ6OFNpYkI2c1cvbm1UK3lTazZsKzJhVS9qV0VI?=
 =?utf-8?B?cTVkdWJqaUZWQ1JnOWlPc0Z0SW4rK20zc21aS0Qydktpaml1c3U4MjMyZXJG?=
 =?utf-8?B?TnVSMnoyM040N1J3bGVaZm83aTJUQTNwbVBPKzhNcS8ybmFJUjRUQm80RFFp?=
 =?utf-8?B?c1dmdlUwVTJRNnFUQVh5aWpyM3piSVMwYXNlOURpRWdWZFBTQUJIeE1Ham1y?=
 =?utf-8?B?NUIxdVlYb0Jlc0huSFlheVZMZUxlSmhjVWFEVVA1bG9EWUV5bjhmdm55T01F?=
 =?utf-8?B?VGkza083eld0dW9rSS9oL05ZK0VYQkhwdnVrOU40STdjNW1qb1pWcGwxTkw5?=
 =?utf-8?B?bjRtU2l3bnZKTCtrVm9XeldHUWRBVTBTMjJYOEFuYmxzemI2eFdKU3ZSdXF3?=
 =?utf-8?B?NzFWTndtOFlhOGx4NGZRdy9oSTFEcTZDZy9KaUZzMnFsRWhuWVhKWmN6b0Vz?=
 =?utf-8?B?cmJRVzlnNlhlTW10ZGtJeE9VOEI5ZHNydGZIc3ZFNVRaUmdaR3hlVXFiUVZX?=
 =?utf-8?B?N0c2T2lDblRpbUMycE9EcXhLOHMwOVhLMW5OaEZNd2UvZVBZTlFpcTJIQ3Bm?=
 =?utf-8?B?eEJON2UzRHJqTGdnUkVsRndVaGpQQ1V6bzFES1BYVUxoRTFOUHZ1VmNjMTVj?=
 =?utf-8?B?OVI1d0ZwV1pQTU5uZTk2Tld4MVh1aUF2L1FYVzh1MWNueDFvKzBkZXMzRXhk?=
 =?utf-8?B?eGxUVHFBMjRuejVMQVBoMWs1ejhkb2tZSzFRSXByQVBkRWFOelZKUTd2VFRy?=
 =?utf-8?B?RC9rNDZRT2YvNTM1aVN2Y1ZQZHRqaEJ5UEMrWWpIaXNsNGZqdVlNbXNyajhD?=
 =?utf-8?B?WXR6UXN4ZWNzcFJiWkUvN2pHMG9iVlRqR0syUC9tV05rTHRrS25iRHVFTWhP?=
 =?utf-8?B?VTBLWjgrWVF2TFpZRmxBc3VQaDNqNjU5bWtWMktOY0MxNXE5aTQ3RTBZRE1j?=
 =?utf-8?B?YmE5OE4rZlBaMGFGdkY4ZDFzOUR3VUpIQ05CRXZTaE4yak5NQnJCeERKUnB3?=
 =?utf-8?B?MGRuZ2ZvVjNtLzREWmthRFRNVFFXYW5CNW82bXk2clZOUzZXY3BCV3FJa1RH?=
 =?utf-8?B?VFZrZkNUb05OUWU5Z1NtVU1KMUxEVmhoaStRQkNjeVZqdjRRSWFzejlRSllC?=
 =?utf-8?B?NHkrZEpEUGhsQzRBa3Q2dytva3p4cjlLQjJzWGtRWVg5cldQUUFJMjNJV2Jt?=
 =?utf-8?B?ajM0NzhFSGFPYXl0emFzVFc4SFYrQ0Z6WE9QMTZpdWU1Yk84VGR2NUlQTDZU?=
 =?utf-8?B?Z0Z4d0xJRW9wTWVYVXN4THFWZmxwbjJJN3UvNTQ2cVpiZWVpcWhsajlDb0g1?=
 =?utf-8?B?N2YzMC8ydkxVeXF4WkhFZVIzZThIMHZ3VHR2MjZXTHp1aUtaeXB5NytjSVd2?=
 =?utf-8?B?VG1TTWZTVzZHeGpydFhWVkw2WFgrWHB6SFJNMSt5R08wMDN6M0txclJ0T2ZX?=
 =?utf-8?B?OENBdllqeTZERVpqTjJ2U2tHa3ZkUysySHdLS1YrTDVaTHdsR0tqUlM5TFJ0?=
 =?utf-8?B?ajNodW95ZWFYUnBTdTFldEFEdjAvMkZuWGluRjJnT3FLNHhZT08rSVNMeis2?=
 =?utf-8?B?V0UreUVRQmlxRi92enRqR1JDeDIxN0h6S0FlVDlpVm1SR2JIMU1JWFRGbCtW?=
 =?utf-8?B?OHNZaytYMVN1YmxKQ0pMVzRkNW9DaXA4ZEF5STZNeGxUY0lOZ1h2Z0I2Sk5O?=
 =?utf-8?B?N1RQV1piK0d0RzRVQWQralZIVVJKUVFKcjZ4KytmSFJzUEVSV2pUSjJjRVdh?=
 =?utf-8?B?OVlnRkd5TUFkZkJKd29UNG1OVzUzR0IxamN4L2xHQ3lHSk53eDZwYjFrbkg0?=
 =?utf-8?B?UmttbVZOYzNEYWxXdVNTdjYxRjlTNmdIRGxsbjdaUkNGOXc0OHVIZ2ZOR0R5?=
 =?utf-8?B?U0tSOVBCUGl4S1lXblN6bUs3d0VyMkpDY1NDYSsxbXNuZCtUZFhSemk1UllK?=
 =?utf-8?B?M3IvSUhCd1lQQXllMjJ0dDBRMGIySE5tazJzQUhIQzVDSFZMWDRxZz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741663df-893a-4132-51e2-08de62340fd6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 08:21:27.9129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lS1vDCqlpr6QVWHQZItmkdZUUqmYS1K1J2BRYn7crdcXTQV31NV6Y+bvdX7uOdEpJJy5QpMMFASQZZDOjuTQfyxuyj6AXX5DiTwRmQzJ6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7912
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8662-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amlogic.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xianwei.zhao@amlogic.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,aka.ms:url]
X-Rspamd-Queue-Id: 27EEAC9A3F
X-Rspamd-Action: no action

Hi Frank,
    Thanks for your reply.

On 2026/1/30 01:54, Frank Li wrote:
> [You don't often get email from frank.li@nxp.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> [ EXTERNAL EMAIL ]
> 
> On Tue, Jan 27, 2026 at 03:27:52AM +0000, Xianwei Zhao wrote:
>> Add documentation describing the Amlogic A9 SoC DMA.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   .../devicetree/bindings/dma/amlogic,a9-dma.yaml    | 70 ++++++++++++++++++++++
>>   1 file changed, 70 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
>> new file mode 100644
>> index 000000000000..7d044152fd76
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
>> @@ -0,0 +1,70 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dma/amlogic,a9-dma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic general DMA controller
>> +
>> +description: |
> 
> Needn't  |
> 

Will drop '|'

>> +  This is a general-purpose peripheral DMA controller. It currently supports
>> +  major peripherals including I2C, I3C, PIO, and CAN-BUS. Transmit and receive
>> +  for the same peripheral use two separate channels, controlled by different
>> +  register sets. I2C and I3C transfer data in 1-byte units, while PIO and
>> +  CAN-BUS transfer data in 4-byte units. From the controller’s perspective,
>> +  there is no significant difference.
>> +
>> +maintainers:
>> +  - Xianwei Zhao <xianwei.zhao@amlogic.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: amlogic,a9-dma
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: sys
>> +
>> +  '#dma-cells':
>> +    const: 2
>> +
>> +  dma-channels:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    maximum: 64
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - '#dma-cells'
>> +  - dma-channels
>> +
>> +allOf:
>> +  - $ref: dma-controller.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    apb {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
> 
> If use 32 address space, needn't apb node
> 

Will do.

> Frank
>> +        dma-controller@fe400000{
>> +            compatible = "amlogic,a9-dma";
>> +            reg = <0x0 0xfe400000 0x0 0x4000>;
>> +            interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
>> +            clocks = <&clkc 45>;
>> +            #dma-cells = <2>;
>> +            dma-channels = <28>;
>> +        };
>> +    };
>>
>> --
>> 2.52.0
>>

