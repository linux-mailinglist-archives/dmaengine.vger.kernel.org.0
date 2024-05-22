Return-Path: <dmaengine+bounces-2133-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D3E8CBAB2
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2024 07:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A561028287A
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2024 05:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A147274C14;
	Wed, 22 May 2024 05:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CtLzpIFh"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016C51C6AE;
	Wed, 22 May 2024 05:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716356150; cv=fail; b=f7VC3CAmO9stS0iqLvD6dvmE5sgzkCI6QZqQrp8cO4p/I1DuxhmBNc1O0hezF6SOwoaWq+nOMcEtdj6h2GWU/qYgOiOxH1Tl90nrUeJUdhl/oo7VeUrwjI+Ukf07pWmBLlun+/R9bEVUw5CwqTIMjU6Bc5vNCOdYD4iw3iCiFiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716356150; c=relaxed/simple;
	bh=CaZK9vk7yhOPp3McqUr1kExo+uEbb8b0MAv4UsI7wAo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QwCXvEfGmYoX31PrxSRUclPoAMPLLQaLwGl0EwqrY5Ys29Mx3vWMK35/fgZkxInT+pO9nk6F5No7PNXfjLwxB9n6wnw3BqvIIQnbq9RdrZkGaz+dO3w7aYPS9RCLY/vXfpTA6Gg3v0TlclyqsEc2ljo2j66AfTM76HyKFpX4pmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CtLzpIFh; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nd2g17iBTXfblmYv+0RVu0KdBHBzGnzwx6tedZxpBkrGjCMRE82zG6AyWwPR7iHKwvPF3LY8VAKPH09VtEvpCiAfMCFKJd1yMo+e0k6wOMmQOd0T5Cg5bZqBo0lGINwqNxuIC16JQ0EFybLRy8nJp4Cw8ayBPsICBRCZ5V/IV1uskBhPqf4xvrGVrGf1Kvs16oISbDBcOd7zMoTpYKceIiPLf5/HaH9Z5rTlxnqU31KeYx9Fl4nqi60QgHkrK02wrmSrd2ejGQuL4r4BgabBgO6Sy1N1ld3JOI7GKF8KpV+pHcYd2qz51ityt9aZOsCvVZ5FlV4NXY7OC9r1R9VxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLVmX6rHjjHBbYh8xudWptanXxM/6sATLGabWTJZWug=;
 b=QhULAPMUFxFKGoHmROuIPDKlrdG32CfbSEw/INwXCDo5XrnNfsUJl71P7z49QW8l8EtyEnaYYYehnCaec8KtcRU/j1RebeVJ6xqcHRGVbQI6q9HsF4Jm20ugDW8d1GH3lGZW4snA62XQwyAqKNMX/FxOiraffP5trPA+RJQy2KpmW6ius1Tbu2VldMDUEdtB2gLhkZKCXSSVk1zw4UPECex3WQsxDwvY/GEVnA41TgnvLaeXOg0nnzA9wzzqhK4+8wBTExMpaEXvu0hQMxfVDoARy/UztKKPd+l+HXI2oVNcHvgk73B+TKqCCpg3jS8zUThg82FogSWLah1lcCIMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLVmX6rHjjHBbYh8xudWptanXxM/6sATLGabWTJZWug=;
 b=CtLzpIFheTkYCrPd0iAgLKh8wgnwQPvFszwu2bDoCKN6NPRRzq4DgBy29I5rn+fl16BML6c7M+G8u/oYQ2tntBCFwaUvJyQP0f+5WEddeQDdfr4/sdLYLqHEKUpF3RXdO/c5DIHs3zNoI9vZ4DMmP2zOfxMnDAgHzPLwG+i7uePRjlARlvKp+TxuA545UWV8prgGpHy3NGYhJxM9EwLruQ8pyHKg+OXALbRlkuf8cDyz+WXdawEK9dLBWrJmSgK4CvQnzcAX9vK1Evts4BXLRtW33VjhcWXWMOfQ9u8PHcW39mkfDeFXIA4uJAeAWH491gWGTGxUyacjGzirSYHTfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 05:35:44 +0000
Received: from CY8PR12MB7706.namprd12.prod.outlook.com
 ([fe80::eba:a472:8ec9:b80b]) by CY8PR12MB7706.namprd12.prod.outlook.com
 ([fe80::eba:a472:8ec9:b80b%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 05:35:44 +0000
Message-ID: <e6fab314-8d1e-4ed7-bb5a-025fd65e1494@nvidia.com>
Date: Wed, 22 May 2024 11:05:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/2] dt-bindings: dma: Add reg-names to
 nvidia,tegra210-adma
To: Krzysztof Kozlowski <krzk@kernel.org>, vkoul@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
 jonathanh@nvidia.com, dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 ldewangan@nvidia.com, mkumard@nvidia.com
References: <20240521110801.1692582-1-spujar@nvidia.com>
 <20240521110801.1692582-2-spujar@nvidia.com>
 <80b6e6e6-9805-4a85-97d5-38e1b2bf2dd0@kernel.org>
Content-Language: en-US
From: Sameer Pujar <spujar@nvidia.com>
Autocrypt: addr=spujar@nvidia.com; keydata=
 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
 tFh1Kv06N2eJoLklRzTKy6I=
In-Reply-To: <80b6e6e6-9805-4a85-97d5-38e1b2bf2dd0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0254.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::20) To CY8PR12MB7706.namprd12.prod.outlook.com
 (2603:10b6:930:85::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7706:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: ea078936-f1a5-400e-ed2e-08dc7a21064a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0szK3grOUVGMFFhOER1emUxcTU3Q012TlhhYTQvWjdvaU5WTTFsU2NGK1lF?=
 =?utf-8?B?MGtZS0VjUXNhekdDejF2TkFKTTJoL2tqQ0hXdFZOVTVUaXM3bHhEaWlodWl1?=
 =?utf-8?B?cU5yT1dMdVkrMEoyNTlDL1VuMFFCZHFQSnI3QUpLQTdPNUYrQ2NvZDNFZDlk?=
 =?utf-8?B?WENacXRQc0tqSGx2b2dxdlpqS1pTTHhKcjNKcW9IWXk0Um8ydDljLzBjTi8z?=
 =?utf-8?B?OTRadnU2akNPRW5NWnZMUEZQYlphUWNIcU9iZmVRbHJ2L2RxdGtSeWtpYUdQ?=
 =?utf-8?B?bkR6SkY5Sm44ZklOVzNneXBDeW5CTlZoYjBBR2pIYlJVbnRJekFXVjdKNnNk?=
 =?utf-8?B?M0lSaFVwdVplQXRDaDRjNjVXREI5YnFBN2hpVU12UEIwUjBib1J4VGcvVUwy?=
 =?utf-8?B?Q1JPMU9rZXcxRUNOZ2Q0R3kvSDBzMlNNQ3ZXSytOdUs5Q3o4TGxWV2xWQ1NJ?=
 =?utf-8?B?WUFVOHU5YS9LaGRFTmQ0SUxwZDBDczNnM3oyUnNkRlphdlhpUTBnbnd6S3d3?=
 =?utf-8?B?ZnM2K1FIbmY0TEJLd2RmNGVTY2FkdTV2bDhoTW9wakQ0N0NPNmt6eXRwNEdQ?=
 =?utf-8?B?SjZ3S0piMnNJb2lpN0ZhV2lwckg2RWRRaUloNk9WOTN2NTg5VnhjaWt2ZTJM?=
 =?utf-8?B?ak11L2IyTWRMdkV6cFE3UDV4UEFlZlU5N1pqL1VaL1lMOUlrV1ZFVVBsdldk?=
 =?utf-8?B?NGxvWjVCU0xrR2R4dlFBRWZSOElBODBjalkycUlrWTFzSXE4VEpmS3hBZDc4?=
 =?utf-8?B?SlpQY0lseTZzdVNFc1hDeEtScUttWCtlM2NJMDlXMjVwV0xTcXNISzhsM1FX?=
 =?utf-8?B?VU1uM1NOR2wwdjBaR25yU2FEdEdMeDdjMVNObzd3dS91SkVKQTk1YVYzUk5Z?=
 =?utf-8?B?VzVmQVdsTE9rNTR1Tk9XUVdic2dSY0F5RGFQa1FhZjMwUTZDemJjQ0hLZ1NS?=
 =?utf-8?B?K2xXM0g1V213eS84Zkp3THEwWUd2L3ZWOEtOOEs2ek8wNVp4ZnNHb1NoTzln?=
 =?utf-8?B?bjJqTzlTeHc0QWlseFBxd25PUGNNT0dMODczTWlWcUlLM2pJdDA5b1psQk0x?=
 =?utf-8?B?WFlvS1MvZzN0aHlRNHc5akUxYTVuTzRacklzT29wQVVVMlBib0hyUVdIcU9i?=
 =?utf-8?B?Q09rd0hIZ0x1TmNIZW9DYm9FZzBJdm5xSnBTaDJXcXdmVlhUTzlOWjVhczlD?=
 =?utf-8?B?L0Q0a2NOTHdybVFITDJPbkFuTUZNeHdaSy9USEl4Z1NiOXZnU1h5RVM1cWRQ?=
 =?utf-8?B?K2dibkxTLzVoVHM1amszQUhpRS9oVmxQNkw2WlE3UmgrVnJoZlErdGN5YzUx?=
 =?utf-8?B?R3lTOXl4THhBWWN1Y3VuN2VIbUdQZFhVN1cyTHhVWmFSSzVPZ1gzeUlhMWZu?=
 =?utf-8?B?MGxOTlJlSUpveVFTS3JPRkRxZ1BhakpLc0NtVGFEQ2NsMi9ETDBrMUwyUEZv?=
 =?utf-8?B?S3JrbXZjOERpMExJTWZkUmMvUG5VTUMwL3RaRG5ZV0cvNHdOQUJRMEZORHkr?=
 =?utf-8?B?eXlBU0ROR0pPZGdZMUVHWlZCVG1YUnVOb2QzQXNXUitXYzJVS0hucUpzanps?=
 =?utf-8?B?dFRlNkJ2Z3FiSXAvcWVsK2oveFpmcjhPaitBWVk0WjIxdjVXYlR1Z2Zjc05G?=
 =?utf-8?B?VHlXbnFiVmFBbHU5NnNYNVFnNzl0U212OG5JeGpQcVk1Z3kzSENKWTlrM1Rx?=
 =?utf-8?B?SENhcmpPM3FuOUowT3NybGdOWkMrL21TZkNwMjFnWXBxbW1udFZXNWp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7706.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnRHaUhGMEFmQ3AySzRLNTUzZ05PRGtUazNScEp6T3hhTERLdDRlbGFvdXJn?=
 =?utf-8?B?M3dyMjBWTkVPMnFFVnliV2R1SzVaOFVqL3kzRHNVK1VpSFBLSURtd2lIcXFz?=
 =?utf-8?B?M3JDa1l6MU5KR1F4b01xbXpXU01PZkMyYjdiWVBIMUdLU05nZ3lsQUJJa2dR?=
 =?utf-8?B?M1o2QzRUU214NGh5WVdJQkNUY2tQdSt6dURRQkh5QnZOcG8zOG9icXJYTEhV?=
 =?utf-8?B?T3licW5SZ2pBei84NEtnMktJUGdwQ2pvZnpodmZzVFQ3dmgrY2VGTFBMdFRB?=
 =?utf-8?B?ZDRRRlVjOFJVckR4OVI1U01SWk56aXFmc1ozQ3JyUWxvcVJzaUdmVkJ3RlJ1?=
 =?utf-8?B?cEVVdGJMWUxCR3M0ajR2dFAvUUVvQXgyOFQ1YU96Ly9INndaUFluZVlzaFly?=
 =?utf-8?B?U3VyMjE1ODIwY3huM1o5Ly9LUGNlYlRTRmtZbHpiSnRnbVJKaGM2ck9NSDds?=
 =?utf-8?B?KzZkOFR2Qk0xbWlVTGEzRjlsSjNMam55aGJOTEkyOUFaUU5YS2FQTUQ1TWxH?=
 =?utf-8?B?Rm1hbmYza05jNWo3UnoyamVRU2lHbTIrNGhnRnhndWE5bk9HcHRMMkR2RlZp?=
 =?utf-8?B?RU9lb29zcGJsV3Byd05KL3NuN29HRkVxWDkrNnk1cUk2N0FaLzBlcTB5NWor?=
 =?utf-8?B?aU03UjNIWHR1dWI0bmFjcGFycW5xS3lYM1dNb001bTlLblNsREVOMThLY2lX?=
 =?utf-8?B?UzdpdWcxQk9pZWxDajRIVUFqS2VNOG1jQTcyQU5PQU1FelZEVWxOQjJtTlB0?=
 =?utf-8?B?aFFseTdjK0lNTWVBdHBuendicFVSa203SmdXd2FacUF2K1pSMzJySFdsaWFE?=
 =?utf-8?B?YXhEeXJVN0xWZm5nb09vRW5jYmU3YmRsb0llR0tweTV2bVk4aU1ZcUZXejlW?=
 =?utf-8?B?OWJJL3F0NldwazllUzFib0JLUUcrSllZVTVtdXE1VHM2YUZzODhJTU5JYjZs?=
 =?utf-8?B?Wll1UlEzbUZnbXdlbVpTaFo2dHIyMFhOdGtxOWdsYkJoZ0VyTDdES3F0REVn?=
 =?utf-8?B?WHU3MUhaM1EvQnhIcWQrM1p0Y1A3UjljS21jL2xEWEkyaS9Jd0NPbkZpdUts?=
 =?utf-8?B?STFhNHMyUG9Bc20vVmFuVW1GWlk1T2hFY2xNM2lVOEQ3bFN4Zml4Qkh5eFhx?=
 =?utf-8?B?cFpnV29KRWF0MlQzTVZjU3pqTEE0SjFzZEp0SmVvQjZWeStFZ2NvaXoremhj?=
 =?utf-8?B?c2xsZS8wa0RUcGxGeGR5TXo2WVlsTXJuZ1RBNjFzd2tMM3dlODlFQTZxZkJ1?=
 =?utf-8?B?NlB4eC9JK1hCVUpVK1QrV1UrY2VpdVNObUJJTmdxUEllNVRoV1BGby9UTjlC?=
 =?utf-8?B?RnpUZm9SVlJJR1h0RlRmaGNUN29GRG81UVc0Z2UwSy90U3FBMkgzNXZPQjdD?=
 =?utf-8?B?KytMcS8xcnB6Mi9JbzA0NGpnNEx1R1BrR0VVbEc0dXdtWTgvTVB2OUQ4SmJq?=
 =?utf-8?B?RkdZVzVYeVhqUTBKaTcrWnQ0bFVSU3RpZ01PYS9TUkptM3g1TDZKQ2VtbmpO?=
 =?utf-8?B?TmVTM0VFczRneklneVFJcmlrQ2VvR21XUXNEU3g1RmszdEgrZ0w4Vy9paEpM?=
 =?utf-8?B?MUd4bjQyM0ErQzZ2R21EVUVDbUhSUmRMRGs2WndIalBrTzNiaURMY3cvTHY1?=
 =?utf-8?B?d01Fbm8xQmFHeEUxTjA1emJxLzB1YkgwZlEvK0t3MnJaVHN2QkwvbHFKMHRM?=
 =?utf-8?B?TVJpbUxiNE9EU3NYQ2ZFL2FTVHFHd3ZhN0RrUUxwK0planlZZ1VVVHFSU05S?=
 =?utf-8?B?eENpUGJsMkI1Tk9KQVlJVm9UaTRqdkZSbGhXdXZQQmw4OUV3VkhaY1pNNmxa?=
 =?utf-8?B?RUVYNkpHWkRCUDhJZkhZMnBwVk50ZStoaUVXaVFOaXo1TFhjRzYwYW94VDc4?=
 =?utf-8?B?Yyt3OGw2Y3F5RWQ0RWpzSkRXcGtscDY2ZkZRMUl2OENyOE01czRRTVJwUmZa?=
 =?utf-8?B?cDZDNzhObHdxWFBFMmxpV0NsbGhXRjZtTVU0cEMveHNXWHpqNXJsc3gzV0Mr?=
 =?utf-8?B?d1VjL01Ld2hTc1NzMTlqQmNxK1hXOG1Tb3dTdG9Nd1NUY0VycXFsdnNpdFJ0?=
 =?utf-8?B?NE15ZDdwcEtmTzFkRXZoM2JOa3l3VGN2MGRObjhHS3dIaERFMVorUUNKUHc2?=
 =?utf-8?Q?e+0jCyvNy7iss6Ym+h1qgZhKp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea078936-f1a5-400e-ed2e-08dc7a21064a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7706.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 05:35:43.9369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfnsqdYALXkcSAaW0FQhy7X1VStaH6eO3XSb53AZyQwWejOXa2PNj9yFNMOaYWFuDeoJIm52X16dUeyySEcHlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487



On 21-05-2024 17:23, Krzysztof Kozlowski wrote:
> On 21/05/2024 13:08, Sameer Pujar wrote:
>> From: Mohan Kumar <mkumard@nvidia.com>
>>
>> For Non-Hypervisor mode, Tegra ADMA driver requires the register
>> resource range to include both global and channel page in the reg
>> entry. For Hypervisor more, Tegra ADMA driver requires only the
>> channel page and global page range is not allowed for access.
>>
>> Add reg-names DT binding for Hypervisor mode to help driver to
>> differentiate the config between Hypervisor and Non-Hypervisor
>> mode of execution.
>>
>> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>>   .../devicetree/bindings/dma/nvidia,tegra210-adma.yaml  | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
>> index 877147e95ecc..ede47f4a3eec 100644
>> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
>> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
>> @@ -29,8 +29,18 @@ properties:
>>             - const: nvidia,tegra186-adma
>>
>>     reg:
>> +    description: |
>> +      For hypervisor mode, the address range should include a
>> +      ADMA channel page address range, for non-hypervisor mode
>> +      it starts with ADMA base address covering Global and Channel
>> +      page address range.
>>       maxItems: 1
>>
>> +  reg-names:
>> +    description: only required for Hypervisor mode.
> This does not work like that. I provide vm entry for non-hypervisor mode
> and what? You claim it is virtualized?
>
> Drop property.

With 'vm' entry added for hypervisor mode, the 'reg' address range needs 
to be updated to use channel specific region only. This is used to 
inform driver to skip global regions which is taken care by hypervisor. 
This is expected to be used in the scenario where Linux acts as a 
virtual machine (VM). May be the hypervisor mode gives a different 
impression here? Sorry, I did not understand what dropping the property 
exactly means here.

