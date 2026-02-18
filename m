Return-Path: <dmaengine+bounces-8957-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMJNDqCNlWl7SQIAu9opvQ
	(envelope-from <dmaengine+bounces-8957-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 11:00:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 971921550B8
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56CE2300C24D
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 09:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4B233D6EF;
	Wed, 18 Feb 2026 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d4Ttsg9H"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013067.outbound.protection.outlook.com [40.93.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C349433D6E2;
	Wed, 18 Feb 2026 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408797; cv=fail; b=Oh7tHBQbPO7zcVLbps/Q0ybM57UiAys85tk16Esc2wB9u90I6cy8u9qyYo3ZrkzKMQfKGNvsOmGpVrYnk8iDj3NWA1geZf9YHDR8Q7N+RyR0GFy1ucoz+tMGvkQYIpzjbEVUemlFen9rO8MCcfYXcdIgWsHjuR0RQfBCT8YYtoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408797; c=relaxed/simple;
	bh=7gQ2DC9f045j2F6qH0DRz+RSYFgGLne4blLbN5UR1t8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tQdZzsdM6/sfg7NbQ3Rpi1ABuphVITfqswz9qc6fkNM57a4sVUgpQPiReKyHhbu7fQQLhuo7+siY/dkVB1xQmDDjWDJPbCmXrOEbYiOgffWMKWwobOXm2KTSkhEC3HgVtgfZc/ozcUPDU8/qCRetkSGCQN55uKWmfFuGi+Os/6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d4Ttsg9H; arc=fail smtp.client-ip=40.93.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAvDYAlueFORV6/kDQF0By1tSSSB76pkSDnm4BdL/6a+jkrG1ge+zAaXdXTjl7j1v7hzDRnyDDkTEj288YgATf7Tqb9kWhBgfSGlxqwiY9soTd4vM3edaZ16AOOSJTOwGXbQKWCvOsJlAPGSxFOeHEgIr05pszO/KvvYXnZEw5UimBSJQVnNdQjH5EZxfYca3v8JP6mwcW0VzM/AsVwazk7/jukzsMSehqGtNNiA1K6d5XdWlqa+S0XNkP2tSAGvREBU24TJiW32j9ZVP9NmUiQLYUGZE5jckHBZBgi8DKja+cxekzhzJx6wmnS/IwxWxM2v0VVFE3wuioYxBztIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PW5cni17Nbv5po8U9hoWZxhW17kBTE0ZbsYnijfqlP8=;
 b=jF2FqX7Vjofi9p44ihGAje1E2gSPEZdxg/ogFwCSCCSn94pn6qq01CiA1f2sax1PJpTaPXBgQZSf5pCkvU/JnIGzA4RQl9H72slBWVLhE2kDbjD7QjdTq80MTod6Z8YNLHjW3KxT+Jmk5Nt5mG72VX7U/dlh83s5vEl/ssbx+Tnoykyg8qaUoJ2JuOY1xnQSxK20Hi3o708b0P0+F5YHorAar3FSQHAMepg8P+uN7OlB+h1cYtU1gxe2Llh/38yGDzly5UNV7I1u4uKpQ/FpN/ABiLyznS608U2jpC6JJEE6sgJvx78/5NFBuLQUXciVk14u6+B5BaHSdfi32R6cHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PW5cni17Nbv5po8U9hoWZxhW17kBTE0ZbsYnijfqlP8=;
 b=d4Ttsg9Hco/nA3jlKQFHSvMpskAT1rmdn5dWFwsfsAc3O6oHKU9tFyqeAjds1lhiErANMoNlVp0knG+jo8/w+UKy4ndQlffLronmOdKyIbBYgpnGbxGjM5MzKkHJG36qW91V57Ity4BEIcnMx9DEHp+wQGjTjLVs3UsH1cwVhg0rA9O7L/DE7w0glzDBykIFxdUDUgXih1kFJXx9vp07kCiAPTa4v0EoUwkiGRTd83VZPtKWomJnNPIprku/iYuDHBTgswJeQVBtNl8hNvmjU9B8vF80nIb9PAXUaZ3yYOWP3FnF6kJdJJ7QYgQ5iNU5Cts1NzAFh+t/uWaP+eDQrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 09:59:51 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 09:59:50 +0000
Message-ID: <eb42fefd-758f-4c02-86fe-01d21a08e101@nvidia.com>
Date: Wed, 18 Feb 2026 09:59:46 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] dt-bindings: dma: nvidia,tegra186-gpc-dma: Add
 iommu-map property
To: Krzysztof Kozlowski <krzk@kernel.org>, Akhil R <akhilrajeev@nvidia.com>,
 dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 vkoul@kernel.org, Frank.Li@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, thierry.reding@gmail.com, p.zabel@pengutronix.de
References: <20260217173457.18628-1-akhilrajeev@nvidia.com>
 <20260217173457.18628-2-akhilrajeev@nvidia.com>
 <e26ac880-c397-46ee-a308-be2de608e3d4@kernel.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <e26ac880-c397-46ee-a308-be2de608e3d4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0099.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::15) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 37fcd51a-8f2d-49d6-d87a-08de6ed474ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGhtTWRIOFpYUHA0OFVzcXpTUC8wMGo0LzhBOGRzZlVpVlRqTXNHbC8xK2gy?=
 =?utf-8?B?czFRVDBoN3Btc1BJbms4UllUdm5Ma0JBNUk2dEx2VGxtWTAwNS9WK0tTaUwx?=
 =?utf-8?B?bjhXcGpRWXJZUndQdm9wb2l5bTJLYU9PQnFxc2x1YW8rdEZoZFZrQ2lFcmxT?=
 =?utf-8?B?TjhYTU9zMlVGRUxHOTByTzV1Q05QbXdobFh4ZTMrQ0dWbEpUanV1M05FWkRs?=
 =?utf-8?B?TXpOMWVBQ1JodGdtWkxic0hQWDJBczV0aHFIL2FveWExVjAvMXpHYXZXVUU5?=
 =?utf-8?B?VzEza0NoNW1TcGVMVG5FR3IwSW1sUFlIVlE3RWZ1aXFaVWltcGhvci8zak93?=
 =?utf-8?B?dU9MUmFHWjBIUlFRQTcrWjRQeGRMYXNiR2Z2bmVJUFVncjJhZkVReGlKd3Uw?=
 =?utf-8?B?V3E3VTBmYVZCZkx0OENCUGdRK095MkNGZW5zQ09waUZLUlRBeDA5QzhidDhy?=
 =?utf-8?B?akJTeUZ6TjR1WGJmZVVDQ21BUFhtOHAzT0VxVmdMejM4SFVtWWJrT1ZhekRK?=
 =?utf-8?B?R3QwS3ByUVhHL2JQMXpraGk1T2NKaTBYYzVNNXJwaTh1SS9pY2h4NlRvWldt?=
 =?utf-8?B?ZWNEcTZ3MHNHZDJuMHFQWjNkZlU2dlBGcFQ1QU5aZE9qYVhSeldNN1h3VEky?=
 =?utf-8?B?N2xZaXVKaTZXbU9icnpsZUhXcDJmdVhlSTRiZHNzSTl0eS9FRjVTcnFUQXhN?=
 =?utf-8?B?aVUwbkhQdXJFYzd6OENzenhVR3FrWUorU2wrbDg4QWY5SkxvVEdFclBrWlBE?=
 =?utf-8?B?eUtsNElHMGhaNU0xNDJlejFKaUJUd1VZUEtSbndYSlZxL05yNXVzU251VVYr?=
 =?utf-8?B?OTlFRTUzVnFSSzFKL2Y2WDZJYmVGNTAzdnpUQmlWNXV2aWIweEJjbVNjZlNW?=
 =?utf-8?B?K0lKK2c3QW9xZU8zdWUwQXlKb3RwQUFZS0FGQnJ6Z1hvSmRvVmVTQWtuYlZu?=
 =?utf-8?B?RmFwQ3I5aEpTYmxVTVZtaEZGejdteVZaenBtZ3dCQ2N0bVBYUk1tQ3N0ditK?=
 =?utf-8?B?VVMrZ1NpRE4rNjNKalFteDQzM2xXR1VlQ0wvejlvb2U2Si91NmdPZ1daZ0lC?=
 =?utf-8?B?UUZTbHdTUytOcVZLWTBYV2lsT2ZkWjErYisvTGRpUVJsY3RSakdERnNPU1FS?=
 =?utf-8?B?dDR1T3AySmNmUVVMYkhRNjhsTzhFbVdwSXRFVktZbjFPbi9oL1NNQWNLbzkz?=
 =?utf-8?B?NEJpbkxwV29TdmE5cm1zMWNPYmtUenNZc29aNWhnMmN2TXdzWko1S0JSZ0Jw?=
 =?utf-8?B?eTlSdGxPaDk5dlBWSFUzZjQwdmQrNGovbVQzKzVQbWQ5WVlYS0JiQ285U09N?=
 =?utf-8?B?VHdIRnVTWHBoVFFjRHJja2ppTlhDbWpxRVBoSEZ1NTM3dFAyOExMaW8vSW1y?=
 =?utf-8?B?cmNrWEFRZWcrUHBCUW84dUdJLzhtWExNdU9zOHlUTElja3lhTVRCN3kyeDVH?=
 =?utf-8?B?M0c5WUVTaTczK1VURFpCcGxVbW9FMjJOcTJIZXV1VGVYZXozRFBVQ0xrTVVj?=
 =?utf-8?B?bnEybXB2MXY5ZFQvVnZsb1JBQi9pdWtQSCs2aFFjaEY5UUhJU2wvNXFXclM1?=
 =?utf-8?B?aHJzTkN5SG1TL0NZQnhWajNDMFF0TEhuV0FKUmd4cklSL203anlGcGViY0hO?=
 =?utf-8?B?cTFQRk5iK1BNYkVuL1hmQjZMUUd4Q3NhT2Mya0pjZklKU2VXZldna0Q2dTZC?=
 =?utf-8?B?Q0ZBbVFTSE4zY09zMDZmV2Q5S3lqUDJ0Z1JCcEg0RUE3ZXFpV3JPSzdVUzl4?=
 =?utf-8?B?YUR6R056VFJsRmlYbTkxNmpWMW5uSm5GK3c2ZjVuNlBKVUt5ZlBmQWY3S0tB?=
 =?utf-8?B?Zmg4S1hKR3hPbERDVDZpWFVXU1BFa2VNeVpic3ZZcGJQQkRqeVJrN0ZTRCs5?=
 =?utf-8?B?RlFIZmVnM2Raem9Ta0NyWHNzRVlILzc1ZURIcEF2by9xd25ZYzcvVE1Held6?=
 =?utf-8?B?SEpvcVgrakk4OUZWbTljVS8yTEFvUEtiUWVLSEN5bkpNT1I4QVRFL3Via0lG?=
 =?utf-8?B?ZkswSk1ZWWNrUjR5bEV1bWlMaSt3dDdGSVJPWEVLVlg3NlZBQks5Rk5keDI4?=
 =?utf-8?B?ampkRkwrelRRbWx6dlVWblNvWnVSSGdLbzhXbnpCOTB4NEltVk1XRHRXV1pj?=
 =?utf-8?Q?J3uY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVR6RmJYczc1Q0ZISUtsY29INTB2RGF0M1JoR0Zia3FPTmV6cm5pMzI0Nk1i?=
 =?utf-8?B?WEIrSUJ4WjhmV3VpRXBOVGo3YmV4MlRITjdma3ZhdUhuUkJpeDhTRkV3TEZt?=
 =?utf-8?B?U1o0MnJPZk8vcTFYYVkzR0plcUpmQml3WVBJU0RxaW5qMTIxVFdQTDVPbEpO?=
 =?utf-8?B?UWY1c3RXYVJSQWtCSlJHcE5ZeE1seVNYZVBnY3hVTis5cUlkVFRCMzJwek1y?=
 =?utf-8?B?bmR6d2ZvMHB6djN5cS85Uy9aR213SzZvdGhzd0NqT2tKYnlVZ2dGOEdsMlND?=
 =?utf-8?B?TkV1UVZLU1BtRkd5N1BOK2dGVEE3cmpidStWTys4RUtPSjdYTDhneVpLb2pG?=
 =?utf-8?B?VzhGeC9RN3B1TkFmNEpHYmNSbWdjWmdwVS9RSVBhTjBXbXBPUHZ0akNNbjBw?=
 =?utf-8?B?L0x6QkJBUlVZMi9nZHlrMW1mMjFDSnlha3M0R2s0Uy9qREtKUE5MYVJoK1Aw?=
 =?utf-8?B?cUd0WUY5dHJoY0F4UzlyTVZGVDg5SjlobVRuM1JBVFI2c2ozYVI1aG56UjNt?=
 =?utf-8?B?ZTdXK3VMNGZTSFJnSWxsNkVmN2dxS2RHNXA0bnBvYVlTbFlxN29FbmNNOUZm?=
 =?utf-8?B?d0RRb2NoV3VmalcwSjBnQzJ4SGZDa3dxRXBTU083bXREbjliRUJlcUVCZ0M5?=
 =?utf-8?B?VEZuaGRRNHlwVm1kaG9tem9iMTlESDJwRlZvY0JlczJnclluYnl4c3IyRkJU?=
 =?utf-8?B?UEFiUWVFNzcvZXg4bkpsTXFqb0pXSlVqT3ByUm1lUGM2MFd1aklqRjJieWJ4?=
 =?utf-8?B?VnJwcXo4dE9iUFNqZklzM3E4UTJ1Q281Q1Y3RGMvNGtUbDVvQnd3cStkaXIz?=
 =?utf-8?B?VTc2YU5sM1BCbzBwSG90TUd4ck1STUFXV2FJOVo1Y0ZQbmtnTWw3RExlbG0r?=
 =?utf-8?B?bStYbGNkbkxwTnlRZ3pYS3dzb3psNWFlUGNENktHRTZydDN1YmRTcEVkNThX?=
 =?utf-8?B?NmJjUWJvVHN3NHYvMnpFRXZnbUpqai9IT0tLUU8rdVg4SUdWdHlxYW9EM3p4?=
 =?utf-8?B?Vk5HSVluZDErWTBVaVVOcmRZR0w1ZmhocTAwNFZrKytURGFUbUxQbnlndTRC?=
 =?utf-8?B?eUtreVNybUtMQlNodVY1UXdlbFpaeUZreEJYYXU2SUlnaXU1M0kzZWhxK3Nj?=
 =?utf-8?B?NmF0dFV5V0tublpNL2F5OFlheVBHZlZOZ3g5N29USWJtNkMyVFpLNjdPWFVy?=
 =?utf-8?B?cWJSWC9vLzE3M09tS3NyOUdxa1RHbXFNamp5NUJPU1BidythZTRYQnNlQ2Mw?=
 =?utf-8?B?V2prQzZSTWtmeC96dVhDcCtNTnVuTSt5c01EMTJrRWNUSXA2U0x4bW1rTzdr?=
 =?utf-8?B?c0NoV2lFWkFCMWdoMnF6L3F4a2UweEM0VWUzaVV6Z3JiNkNMZjgzNkFzMnZY?=
 =?utf-8?B?ZThJSUpOOEEwRkpvVkJFcGNVdG1xMDVaOW9mOHIrZ0swR1FOUTVKc2JpK3Nq?=
 =?utf-8?B?bk14L0pTTnYvekV6c0dyZXY1Z3RkcDhYNVp1b2s0aW9HOWU4c2RxcmdibWUw?=
 =?utf-8?B?U0hNeXRSMzFFSjdRZnM1OFp2Q1pmNVFKWWpBelpLSEhFbjZBYTN1R2JPS2Ew?=
 =?utf-8?B?NjJYdzR4MU5vN3FoSTF1RFExNGVMWnFvNWtGWno3N3UrTkNoam9LQ0RLejQ3?=
 =?utf-8?B?aHM3a01KZTVxbGJIUHlwTHR1bkptbGxqNWpvQjBRVzdVQ0U1UStpUmtpQWpD?=
 =?utf-8?B?azJSQXFhbWkyZVVGNVhndGcybDNUTDJ0RjVmYVdpdE0xZEZqbUNuZDlPR2Y0?=
 =?utf-8?B?bFlIRjV0RVp6UnJ5Ynh0MFhwOGNMNnhaaSthZ1p6WDRwNmtVQVY5WVZEbzBG?=
 =?utf-8?B?dnBJN0pYMHZNY25hOTZEMUswa0lxVDRReExIRFl2a2Y5TlMwanJib0lCU2p3?=
 =?utf-8?B?QjA2aGhEQTNJYmNVdXhubis1Y1MwVU9lSnRiWEszdUtrdXZNdnVzY1EvM1ky?=
 =?utf-8?B?Uk1pNVV6Qmc1SWhEMks0cVJZaFgzM3Z4b0tmc2dzck9HczN5Y2FURDhmWkRi?=
 =?utf-8?B?a1huY1BTYUIrZVpVTVo2MktiNEkvRmhSRTJvZ0VsZk0zVEVpc2RwT25jU1JT?=
 =?utf-8?B?SlpoNFpGNUtVbG5HL3VVTldLYXdxYUFQZ2t4OFIxUWhwQWNwZmpTemU4ZVdQ?=
 =?utf-8?B?OHlaZmZUVm5GYUVaZktaVi9CZTgxamhtTTIveTQvN1RvNThhOEdYYTZNdFFN?=
 =?utf-8?B?UWZIUEFwNysyMmRNU21PNEFXcVVCMW81alhsNU5FV3FIUGY2UytKRUFlWWNH?=
 =?utf-8?B?clpMSDlZU2orWDZQL3libjZOSmc5ZjJ6SEZSbEJXOXRvRWhLL1RjNW5LQW15?=
 =?utf-8?B?OWdna1V2RU42UUYwNG5CNG11bTdoK29kL0FWc1pyakwyWGhVNEpsTDdpejRs?=
 =?utf-8?Q?VBhNLIpxsnyGjupkSvlICtSVdbSgiZopUz/iVCozluBSX?=
X-MS-Exchange-AntiSpam-MessageData-1: uBFoQKtZgW9RLQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fcd51a-8f2d-49d6-d87a-08de6ed474ea
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 09:59:50.7898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOX1kq/QEnjWfEe0P45OGRzRxB7sZHu/SdAC/3Jn6OdY/kIaoKPnjYIRhtACFg9IG0wF2PbX6qitqYWmSozDPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8957-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,pengutronix.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 971921550B8
X-Rspamd-Action: no action


On 17/02/2026 19:53, Krzysztof Kozlowski wrote:
> On 17/02/2026 18:34, Akhil R wrote:
>> Add iommu-map property which helps when each channel requires its own
>> stream ID for the transfer. Use iommu-map to specify separate stream
>> ID for each channel. This enables each channel to be in its own iommu
>> domain and keeps the memory isolated from other devices sharing the
>> same DMA controller.
>>
>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>> ---
>>   .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml  | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
>> index 0dabe9bbb219..542e9cb9f641 100644
>> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
>> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
>> @@ -14,6 +14,7 @@ description: |
>>   maintainers:
>>     - Jon Hunter <jonathanh@nvidia.com>
>>     - Rajesh Gumasta <rgumasta@nvidia.com>
>> +  - Akhil R <akhilrajeev@nvidia.com>
> 
> With 4.5 trillion USD capitalization of Nvidia one could assume they can
> spare few resources to test the patch before sending it... instead of
> relying on Rob's and my machines to do that for them.
> 
> Expect grumpy review because you do not care about our time.


ACK! We need to do a better job here. I will work with Akhil to improve 
this.

Jon

-- 
nvpublic


