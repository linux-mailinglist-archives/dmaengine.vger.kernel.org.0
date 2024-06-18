Return-Path: <dmaengine+bounces-2407-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A93390D2C1
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 15:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82ED31F240C0
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 13:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA5D145A1F;
	Tue, 18 Jun 2024 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jZPBLJX5"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B460613AD04
	for <dmaengine@vger.kernel.org>; Tue, 18 Jun 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717313; cv=fail; b=ttq2v694MjpqRHMg3URqpurutEltZIbkEcpL+8nmxMQRkUkDNjjjO4wr4qNNgdsCmBwcYIgPz+jsGhHp1viFuXe7RHNocLepNqZx+muihq9btAhvTXcO7bVmcUegxZx0C/u/FVo5bxy5erEGCqTpl0CWHkuXUJeQKBcq7NGmSS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717313; c=relaxed/simple;
	bh=WdkMf7HJhWUxLjGkL9hwpNq3O0HRGswKtr3wZx5ODuc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oyZHAiuWnmHaVhIztMwOqhWp+4a/tkCMch7qL9bOTFNbCoRzfjuoa7mP0SlROKqWpJONEVb/eTiexmg8mnNwTSrGelFj5bUW0DPvtu0EBVXU58Jlgt0ZLFpmjqrcHnJY0NaBXhpzmTLbTcqVIk24zVIEiu8ZxfbcvC5B9ErAUkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jZPBLJX5; arc=fail smtp.client-ip=40.107.102.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nghqZTMGBaHYGq41S/+cpDALFeIGdMW5MmKxPXh63kG4fujn6uI3kZcv0IOWuMK5l2ZuzzigTNW0jKg7C9gHrDORZOWcI93suu0DoBuyv62sEPZvU+UjIGNLTm4tLezrxqyZrOOfj4nLG1CMl1H/8h8UaOy8GC3eRbXx3dWHpqj5XdzdUMkH+c05RkT+Qc3K92bTVHXWAOpK2RrPMbcBBGTT5EDe4CGy0ny8IxMKTFlXrXvRqJcv8KkEzpUh+b/jav7QMCM4v5sJiroaAF+YOXuW3Eo8tk7tqHuABVfKZ8kGqcpuAgIr6CyrZxWfRovqyiE3lx1XKK/AOvyaOzahqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHKxuk6b4RZutKNtpRGNxjj0XMgPrcrrOLEiyRfTE6k=;
 b=RmKqgptKQoJkFe9EhdrcqIHQYmfSJZJhFOvmqVXqVUA0a0jXgYHEzcNkEYWGc07CWxo2kgyNYGa/0f0JT+aeH4TR2btfeuHJjlKmCOsYW9604fkI3hbWhjUH6uVUvhqbh2JbccS9qCstJkYdnXSgIBsYMAFFvzFE76R2wl80jAPYLWdV/4+mEqcBkkXrlF6sVZxy0CH6CziH/chEcUZXlsAFMuQllveMP9fYQ2rEu4wlZKI3cqX6jA0k5ZWFl5GEbiveh9G05YexCEMmc7XboG6/Ojp+KRo6jr4VNz0m9T5vPerpdW2n3179c8IWF4HZK2YKielC2645bMmGDjR9lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHKxuk6b4RZutKNtpRGNxjj0XMgPrcrrOLEiyRfTE6k=;
 b=jZPBLJX5XPnPYV9Xl5H40hKCEtYYs68MoSTBiyb7nN2y3HdzoTK3v2nkiw5YMUjAtLFw1W4ZcFdOaRH2kV9681HZLQYWL4pzTjINdxy6l3todmDMoEjjbcAPpRXBvKnq0XQyu89eL6wU7kofUmmgPu5Bo2IP6S2jayKY98/NjZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 13:28:29 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 13:28:28 +0000
Message-ID: <033abbe2-8d21-4990-a438-dc255acdf62d@amd.com>
Date: Tue, 18 Jun 2024 18:58:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] dmaengine: ae4dma: Add AMD ae4dma controller
 driver
To: Bjorn Helgaas <helgaas@kernel.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Raju.Rangoju@amd.com,
 Frank.li@nxp.com
References: <20240617165049.GA1217718@bhelgaas>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20240617165049.GA1217718@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0210.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::19) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 43229c54-dc3b-40ae-74eb-08dc8f9a8a2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjZ3TVRUQW93OVNMWHZRMnY4Zm96eDJEcjFmTXVkVnFKTExWTkZrajRwL2FV?=
 =?utf-8?B?akROMGZqQ3lWdXhub0owWktCSlRXZ2h0THNrZmhOZC9XQjJJc1UvVkZDL2tn?=
 =?utf-8?B?WllmVU9KQlZVVzJmT1Z2SzcwRno5UEcxQ0NDSzgxTzZ5akoxYXp2Ymlkb29y?=
 =?utf-8?B?YXh4ZHlKRFZoWW0zR2g4OGsrbzB6SHZMd1ZTYTRJa0dCRjhtdFVjcWh0OXVI?=
 =?utf-8?B?NHdFczlhMDhoQ010Z2I1WlhkaDArNnNiajNGL0RLMXB1M0h6bzhLQ1RnZngy?=
 =?utf-8?B?M012M1dESU5haC9mblhoSDRXRzVYRXE0ajNnQlpOaEU4QmRQWmpKcENRbU5z?=
 =?utf-8?B?Q3pTQ1Z3SUNGU1RSK1FhK04wbDJKVE1vdWVwb0RaUkdwN05MQUVlVS9hV09t?=
 =?utf-8?B?UUM2SmJVbHB4WWRGWDNzWEwzc3RLNmowQVhlV3dUQlNLSHFXQUdCSGF3cEV3?=
 =?utf-8?B?TE5zVlNzRzVCUjVCNVBuTzYxejBqSktGTVV2ZmIremFzUCtLbCtQcXBOY2dp?=
 =?utf-8?B?VUMyV3VzQjRmZ3B5S01taWlpNFZONFh2R2Mvc2s3TWVmeFZ2VklrVTZHZkh0?=
 =?utf-8?B?Q0VqQkRsM0RnS1Bua21DZDdGaXNHWisrakwyMEZhdWc1U2JEaENCdWhIdDN6?=
 =?utf-8?B?d3pqUDQ4RVgrQU1namZJV3I4KzRqQm9GT2pBVHNMcFhHQXRvd1ZhdWkxNk1S?=
 =?utf-8?B?dkpJRDl1LzArVEhLNWs3TjIrdkdUdU9EOVU1Vkp5MkhSMm11TURubXNSaUtB?=
 =?utf-8?B?ZDBPUGhFNGxsTXI5cXRnRitGRTk1bG1tSzFwcHgzaEFGQTR2N0dMNW82bWRq?=
 =?utf-8?B?UEZUMjdWb1JOQ0hPWDZ3UjdLNm5iL2ptZUIrL2hNVDc1b0JZVnFhUE9TeVdp?=
 =?utf-8?B?c0lvRk1Mc0NiVUI1djRkYnl2ZVV5WEdLWjRvRE51ei82RzM2dWg2amJBbFNS?=
 =?utf-8?B?azdBd2hnNXU4LzR2bjN4OUQrV3M1U2xEUXAyY2d5ejNudnBvcG04ZzZNeC9z?=
 =?utf-8?B?dllucEdjZ0I4YVVPcmpZendNNWYyMHZ6U0xXTWJUTDhCaVFudGVqbWhMZGh5?=
 =?utf-8?B?T2N2cHdkeU9jcElXMHppMTJxVERJbFQwd3FhdnRxemxrSUFmMExoYlVRUTdG?=
 =?utf-8?B?eS9LVDc1MWEvZnpsenlIdFpzeDYvZENTL283c2FOTHR3VTc3OGRaTDNCMyt5?=
 =?utf-8?B?Wm9GRW5lV0RvZ0YxbHZKWFVLSmg4OWVtRVFPc1E2NDBxQnkzMHUxUmllNSsw?=
 =?utf-8?B?cGRCYzl0TGtiK0cva1FyMXl2bjJXYnZzakM0Vi91MHp2U1V0SUpwZ05OSVpj?=
 =?utf-8?B?WXFwaC9MK2xNVlNIWkpmZTJqb1oycWpzbVpsUDFZRCtMZTNPWU52YVYxem9j?=
 =?utf-8?B?Vi9DVFYvR1hpZVF5NHZOOHFTOTl1UXFYeUQxMTBQUG1tcmNneWFPREhieW1p?=
 =?utf-8?B?ditZaUhObkVkRDJ1THdqNDE4SG9LSElrRUllWkpNNHMvYjRYeVZPNmRRazMv?=
 =?utf-8?B?WnB1bFJZSmI1b3pWeDdoNUpXWXZZMHdwZkg3bDltMURrTFVHamtXQmlMaEE2?=
 =?utf-8?B?dnRMRXZoTkx1WUwwL0pPR0JsaTlEWXFsQWNQbWdTS3k1V2NxWG43eVNXQnlD?=
 =?utf-8?B?dFp4aDBQM3pzMHU0NVZ4NWxhMExSVkU1TEMvMk9zaGZxVDdWU0Z0K0thaXlr?=
 =?utf-8?B?Rkt2ZU5yeEpicm13OXhzTklGblVPaUF2b3VQZzhnMHROV0kvdlF0MU9uKzlV?=
 =?utf-8?Q?fVX3DZQQp9UAWgvhfI7hxJJ25QwyRa/b2+PAz1d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGROM0JPQVRtZEg2UDV5MDhCOE9Sem9KaEVxSEVRRGtES1RBWThaOFZvRXJE?=
 =?utf-8?B?OXNFUzFTYklDUFU2YlRLYnEyK0lpZmxNL0RXQkZXRUhJZzBYbmRaRmJvSm9m?=
 =?utf-8?B?NC9jS3BvUDZFV0hnOUh1Q2h6UlpPL2xxNEZPdzdabXRndm9mTmd4R2p3Rk15?=
 =?utf-8?B?ZWlNVjhid3Y2c0tnN3dRQ1BJeEpSL3BFUlNONTZaUGNiVlF2NTJxUGNXMkZZ?=
 =?utf-8?B?WHlrcDhFSThiSlg1MXoxODRGV3ZBNEM3TklUcit4cHlrTzZpRDh6eTdhUVRo?=
 =?utf-8?B?WWJNZExQMHU0UTB6aU9aSE5mMVpnUDZ1RlMxWUQrZVZUZERBbVlwRnNrdytU?=
 =?utf-8?B?QW13d3lNQXNqZVdsanB1aG43VStoS09SdFVkbjAzSlhSb0dPWHJrYnRkNmVO?=
 =?utf-8?B?WjBoeXZ2VHBkdU5hMWdpcXZSU2dIVWMyWmxHbkxlOGRNKzdpV0NnYWlkNG9l?=
 =?utf-8?B?Q0hwQ3RUTWhvdUU3M05HSlJRTldmMTl5VDBhNlB2cldNN0xoS0poUG0ybXR0?=
 =?utf-8?B?djhmcm4yNWVLR2lNMXMrTmFHQ1VBVUdMazJPTk1WMG5qSTRyaExoOEN0Tzly?=
 =?utf-8?B?SkFSaFNQRTdwa0FZYkdUTDZPZnZLTzVsOVBhdG93N2x4R3F0bzk2MTR0RkY0?=
 =?utf-8?B?UUtBTVkzL2ZDalpiaDVVM1lXeFZFeWNBQlMvT0h5dkJrMjFLZlorSmVNM3JO?=
 =?utf-8?B?T29qSjB1dGlHZkNBOTZWRlVpb2hMV2ZQcTVQblBhTVp3SG1SRmV5aVRHaHlT?=
 =?utf-8?B?aWZ0bXRUdTVXMkdOZndNOW1LUkRyV2tHKzFWMEg1THd6SmxQRGxCNFlMQTkv?=
 =?utf-8?B?UjdaTFJIMjhHQ2lGdmtGQ2R1K0IyVllzMjlKK3RGUmRCNlZ0Z2ZKbmhPY2Zt?=
 =?utf-8?B?MHFXZ3N6dU1qd2N1TFZZNHFRQ3kzVWVLeEVva3c1MllsRWNlNkgwd3dnbEY2?=
 =?utf-8?B?Z3lDOEIzbFF1ZXRYOXZRRldwa2VwWlhHbFRMa082N1lTM3VnNW9mQlJDbzFF?=
 =?utf-8?B?djFQQVl6dWdhSnhaUDlyRlhUWUQrR0ZRZmZwd0ZoSHBpYnAyY0UxcDlvTG5s?=
 =?utf-8?B?OGlZdWl1ZGU2SUFDVEJjSGxTZGczT083U2xFNnRQcGJjOTlYQjVvU0NUYkNx?=
 =?utf-8?B?d1pTdURVUkw2d3owSDN0ZnZoSU50RFpwR1ZWL0Zxcm5tZGsyWEZlR2pwNGV2?=
 =?utf-8?B?dmduQ1BOVElZVzNvdmJDNEpDNVI3WnR3ektNNFZIOHVzb1ZpRTBVMEpnOGV6?=
 =?utf-8?B?dkpTSlJSM2tmaDRBQXJJUTVPek1iV2d4MVNrcGlOWWViN3JKKzJYbmRXTkRw?=
 =?utf-8?B?aTdnOXYyOXNkV2JkdUhSVGFCTHVBSHdGSDhjK1JkOEQzcWsrT0NzOEVwRG5M?=
 =?utf-8?B?U3JnKzZKa2JOSUtoU0pRZWJna3JFaDBzYTN2RlVVRlBEdTBHanRnb3RyemJz?=
 =?utf-8?B?cC9hUW5yd2MzU0I2enIyTEU1c3VJRVdBanVuczZ6ZjVkR0FRNW5FbHBhZlZR?=
 =?utf-8?B?MEQxRkVYM2RtdFc3bW5RVndzTnRqWXY4MHZZYTg1TTNqS3RJeTJkbHlXOEhQ?=
 =?utf-8?B?bENONzJ5d2RpNU84WjhqVm5rQ1kyODhYa2tNcWh1YlF3aHRpZ0dBK3VYK1N2?=
 =?utf-8?B?c0JHUDZXM2lHY1JrNXMram44YjZDZ1E4RmZwOTRoZTNFU1pNS2UzSUFVK2hT?=
 =?utf-8?B?MlFDSnF5T25UTDgySFVmU2J5eGJPUG9rOWJXQWpzS2xUUDB5N1QrSHBqOURS?=
 =?utf-8?B?S2J2ZU1DR1FnYjlvdnhRYVA4eEExZy9IaE82ZjhkQ2FqZmRZWDdWVVhlRi9s?=
 =?utf-8?B?Y3czaTJVazh6clVaQWhJQWI4dlJRNEczZ0ZONGxMcks5Zmw5OFAxQlJ6N2Ex?=
 =?utf-8?B?T3o4cGU0SHRMRzVlMXFpWkhZa0lIcVpkaExTRFJSVytqUzdpenBncjhNQkFQ?=
 =?utf-8?B?ZE1BM2ZXN0dNSUN4TUlnaWdKTjNMT0RzNkRVOUVFZEc2SUdzbjNONklaWS92?=
 =?utf-8?B?eG5QNVBESktOY0ZucUszSVhHZ2VQOXc0UTZmV2dodnFMMlVGeVdPU1dDdlZ1?=
 =?utf-8?B?K1dDbGZzUXZkcFRRVUFwVTRzVE42UEJSV1N0UnYrZkRlRW1kYXA0dW9VcGhm?=
 =?utf-8?Q?cjwLRBhcJhnk1kIKnMo9TVJ59?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43229c54-dc3b-40ae-74eb-08dc8f9a8a2f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 13:28:28.9090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YQ4hkgmuiRV4aExFtqNslWLnqVz1gy2VkbGrR+dui2YXmV3LIEvccoE0SJs856MIJKDzYbewFZlTYnQQaH54g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990


On 6/17/2024 10:20 PM, Bjorn Helgaas wrote:
> On Mon, Jun 17, 2024 at 03:33:54PM +0530, Basavaraj Natikar wrote:
>> Add support for AMD AE4DMA controller. It performs high-bandwidth
>> memory to memory and IO copy operation. Device commands are managed
>> via a circular queue of 'descriptors', each of which specifies source
>> and destination addresses for copying a single buffer of data.
>> +static void ae4_free_irqs(struct ae4_device *ae4)
>> +{
>> +	struct ae4_msix *ae4_msix;
>> +	struct pci_dev *pdev;
>> +	struct pt_device *pt;
>> +	struct device *dev;
>> +	int i;
>> +
>> +	if (ae4) {
> I don't think this test is necessary.  I don't think it's possible to
> get here with ae4==0.

ya I will change it accordingly 

>
>> +		pt = &ae4->pt;
>> +		dev = pt->dev;
>> +		pdev = to_pci_dev(dev);
>> +
>> +		ae4_msix = ae4->ae4_msix;
>> +		if (ae4_msix && ae4_msix->msix_count)
>> +			pci_disable_msix(pdev);
>> +		else if (pdev->irq)
>> +			pci_disable_msi(pdev);
>> +
>> +		for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
>> +			ae4->ae4_irq[i] = 0;
> Clearing ae4_irq[] also doesn't seem necessary, since this is only
> used in .remove(), and ae4 should never be used again.  If this path
> becomes used in some future path that depends on ae4_irq[] being
> cleared, perhaps the clearing could be moved to that patch.

Sure I will change all the lines to be like this below
       if (ae4_msix && (ae4_msix->msix_count || ae4->ae4_irq[MAX_AE4_HW_QUEUES -1]))
               pci_free_irq_vectors(pdev);

Thanks,
--
Basavaraj 

>
>> +	}
>> +}
>> +
>> +static void ae4_deinit(struct ae4_device *ae4)
>> +{
>> +	ae4_free_irqs(ae4);
>> +}
>> +static void ae4_pci_remove(struct pci_dev *pdev)
>> +{
>> +	struct ae4_device *ae4 = dev_get_drvdata(&pdev->dev);
>> +
>> +	ae4_destroy_work(ae4);
>> +	ae4_deinit(ae4);
>> +}


