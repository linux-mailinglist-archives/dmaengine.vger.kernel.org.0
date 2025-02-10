Return-Path: <dmaengine+bounces-4378-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8CEA2EADE
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 12:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6801634DE
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 11:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A691DEFD2;
	Mon, 10 Feb 2025 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VAtD6GRt"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC391CAA88;
	Mon, 10 Feb 2025 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186170; cv=fail; b=KgRmGxtk5P9D8cBziSk6Px62+NK/nUQ3+FkgAkmFREN5utpwfpOHEULhap5U6aKuyO20LNpS5hA92k2dHgpyxQmevnMcLxz1qODlOFr40MUvVR0o22SfpY2B9daEgATta84ADCAypbzwchMrJ40AZo4adli/E5o5SGX0qK+lST8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186170; c=relaxed/simple;
	bh=aACkiDTlBjGpsslYcLoSKO8n16utV51uhxFhCt9TUOk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y3zhOvXsNwKJU7AsumNe9IatQ49PNMGosrNF6FKhFwpZlr3Tzs77Illz4EuzVlX2EFNqaoUkdD5ZCGJuxi9iEoF/dxIb9ePT7D9k/c48fFRpzzOOB7s458qFwhacOPrB1yf5YyINgS+7ekqHouS+n0hTuprmIqWO3iH2G//Xj5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VAtD6GRt; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jj8WsKILUm0taDdgRbmajn3/bf0+cKJCg4HYbeEz7ft2O/elv73WG9ztlT8KgQH5WgEQC9wnPgQPmN2yhd/K2gbtwFgB4LJV9Q/LPfOlsNRP5Kra/9CC7apIyIRZVYw4NVTWnTqhlOHTTZNeFXaswNbIICzZszu7pquhxLUAIs1ZKg0vKVmXtyvqzYa68WdGxJDhCFIckI3onEh9A8jqSsFOmrA89zvICeVrjJM9Of/fJWZDNfyAnBI9TO+h7pSggQH4NyD738032b9qMXK0xlF+j7lwgaLoN1bF5CtBqbzHSte8WjFSAkLm1jS42zuva4OO+jvAUL2UdF9hUrJlcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w41jTMh6Bkc/qQFI4FTfUkWD9cOgnGYaNmevXZWxTx4=;
 b=BKty1ZrTdCWyp18VjccN+cB7J8F89W5sbSO+Jz5Wpm8RVZY7tWP8z14RKwv4/IRm5N5fJhvfchlK+3n525pDJt7+t/gmSQZmiPrt0MJbfLRkDU3I/fwILvc+Cv9yv0rz1PMXWIQLEIcBMDs5qnoPCuN3S+HJDt2ophUNuko5SRqBXLtkb3NuXle777JefTVZ6/Im5PU0LtnJQbUgbGFss79sZkIBPi2KCTJwNZCm2ZqOr9AlgcJt5hWxqU+7RT2WWM0kuZou0STxq1Is6jrxb0phlSSBp4t5CWaG5nyaQsEyTdJAE5hkSdqFSoWUvCTCVdTqIfGI0c6YibV48YgoVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w41jTMh6Bkc/qQFI4FTfUkWD9cOgnGYaNmevXZWxTx4=;
 b=VAtD6GRtRz4/QQC6FMJpi3eOpl2/vpgook8lZqPAFWGCXQLhppM/k9/T1w24eFxErXXvc9Ylp7qvAcRkGVpqRCKuqSPbVIo8AkbIbS9lA4DcdsndWAU51xpJ1QipFKIFDzBR/ThpIGgVyrIZUFdFC89bLdKlOvR57WBB5bw5GYNVO2SKQ3xkfMFyIq+66D0XY+mLcsY8zbnFRCepKJp5YG2Jj+E3gSiL5XQZgC5sBZsOMuY+5ebls3yGdMqMKaKgdYxLsrGWT5AtUTEcuCSCjaOG21EPGqcGB6/5tkVSy9Gu4hteCac1lyFhc2r7jZPAN5+8Yxtd2/sdUjYQZaQCSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 11:16:05 +0000
Received: from DM4PR12MB5101.namprd12.prod.outlook.com
 ([fe80::8a69:5694:f724:868b]) by DM4PR12MB5101.namprd12.prod.outlook.com
 ([fe80::8a69:5694:f724:868b%3]) with mapi id 15.20.8422.012; Mon, 10 Feb 2025
 11:16:05 +0000
Message-ID: <2d190825-5284-4ac6-9735-051849bc9bb6@nvidia.com>
Date: Mon, 10 Feb 2025 16:45:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dmaengine: tegra210-adma: Fix build error due to
 64-by-32 division
To: Vinod Koul <vkoul@kernel.org>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com,
 dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20250205033131.3920801-1-mkumard@nvidia.com>
 <20250205033131.3920801-2-mkumard@nvidia.com> <Z6ncuLHotCAw61b5@vaman>
Content-Language: en-US
From: Mohan Kumar D <mkumard@nvidia.com>
In-Reply-To: <Z6ncuLHotCAw61b5@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::12) To DM4PR12MB5101.namprd12.prod.outlook.com
 (2603:10b6:5:390::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5101:EE_|CH2PR12MB4104:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6dcb3e-f59d-4625-f06b-08dd49c44f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlZva2lneFVZcFBMWE54cmYvUFRCZjhpRmFadHBMekN4V3N0TURCOFQydkpo?=
 =?utf-8?B?Z0ZsK3Z3SStZMHI1N1VTUkFQeTZYcFVhQ2ZwRGJJM2FiNHNHTHRZZGlSdjZJ?=
 =?utf-8?B?SjloQ1d4dHNjUUcvUENFUDBsanBiSmVUZXAwNlNOMjdlYTJyYU5YYkR2L1dP?=
 =?utf-8?B?VDZIQ3Y0cE91cDhCYW5ScWl6ck1IbTNJdEQxMHpXaWtIWWIrWHpGeDNXeWl2?=
 =?utf-8?B?dERDcXdLOU16TVlEVmZUWHlWbHNwU3hRZnBldTM2akRONzliL3NUaktlaFdN?=
 =?utf-8?B?V1VCNmhRMHF0eTRjKzlYL09vdnZLbkE0d251NEUrRml2SmkzQitKVXNJRDdX?=
 =?utf-8?B?dlN0OFE0OXA2U0duRHJaYUFUWkRtSWs2QWZKTmFwTnFBVnlqUERoRzd6SUQr?=
 =?utf-8?B?TXdHK2dsd3A4V1NTbnltUG5QSjVteUJMRWpPNklLVk9lSS9YdkFXVGI0OHBG?=
 =?utf-8?B?QlNmVjZuQTRTOFdIVitNOGd1Ym1odFdBd0RJZEtETHU1aE1qdlI2NUc4S3Nv?=
 =?utf-8?B?d0d1RlVJQ3k5cWNRakZsL09YU2R6NktxMzh6WXJBb0RyenRKWmoweTFmaVIz?=
 =?utf-8?B?dUQ0QUJTYTVHT3Qxa2lXSzRJUEhReDI1VHdvaE1CVHVHeGpUdytrSThhUjli?=
 =?utf-8?B?SG03RkZDeHdRODNNOUJxVGZsUFZGWlZaNUxXcDJZa1IvaThMM2tObkVXVjBC?=
 =?utf-8?B?bVdIais4RU1BbXd6L2ZSV2x5blR4YXc1N09GZjlRbE94Z25uc1NOTGtXMjBq?=
 =?utf-8?B?RjNIL25hWlhOWE1tTjBKMGhsN2xhdnVUTEJUOCtqWW1xNyt1K3dmMFJobTln?=
 =?utf-8?B?MFdOMEtzYWZGdzQ3ejlTTnZDcVRKUmpKTmVCL1lpK3VyTUxDTG1UbUYrMUtN?=
 =?utf-8?B?TXAzOGoyVjhidzEwRjBWVEltMlhJR0JQeTk2ekpVaExBd0s1UVA1Y1kvWmFE?=
 =?utf-8?B?WjZlRnVSQWFyUnVjMUxicncvanBsV3pRbmNnS245dXkyUXEraXlXWHFmamVp?=
 =?utf-8?B?dkhxMUpmOFIrMU5iUDJKWGhTYmdQdDQxUTlrWU90Wm9FK0RuajY2TEVLTFBL?=
 =?utf-8?B?WkFTREZTaUVaMmdjY2p2YkFDeFArbFZOZUVzaEtCN0Y1K0oxUzlrR1o4L3Fw?=
 =?utf-8?B?akFQbDVTNTQvN0NQOVh1cC80Si9NZHVIWDhlWlZrUjVSTEpQUVFTM2NtWjBQ?=
 =?utf-8?B?WU1DZmNlY3hjb1RNaWlMb28vbUVqQlBsWGZmcm5WTC83bXFNYlZLeGlGMnJ1?=
 =?utf-8?B?clVFdjhOT0VEOHhZZHJLYmJna290cThoWTVsNkJPZ1U0dVZzTXVaeGZna1Ay?=
 =?utf-8?B?NjRob0dFV0d3MUQvdDhFZ0xJNGRQZ2tnb2FqMWlUZjh6cEltcFlhclpMcUU0?=
 =?utf-8?B?OEM3Qmp1RXBFdWNMNVlQZDA5VWg0RVhGVm15NS9QMGg4OGt4cm54UEZJMXlh?=
 =?utf-8?B?b2trNnRoQVpxcjRYVkROcFM3NTBHYnZHd05HTTkvcGlCZkRBQXlJNFZyVGcr?=
 =?utf-8?B?bGFOcmNsUllhanZXZWVZbVpYV2lBd25NcGcySi90WXp5YVlQOXBhZjlwZi9s?=
 =?utf-8?B?QXJBWkNGRnZqMHZEbVFsM2J4ZTVCTERFK2QzbERQbzQ5N3FWOHVCR0l3WWFm?=
 =?utf-8?B?MGw1Zm93YUduUTFqK1dGY1VxYm5VOVI5SEJFUi94SWMyVDdsaU5MVjhoeFoz?=
 =?utf-8?B?OERBYUhITitoYXFQTXJzV09XR0ZoOFh1TFdrUmZwK3RRdTBmdlRjTmtITzcx?=
 =?utf-8?B?eW91OUFDOVdXMEh2TzVoNWNZaWViOXdqREUySG9rVzYyUGZIemNHaVVWNEl5?=
 =?utf-8?B?a1BxY2pTYW0wZDY5QmF3d1V1MTZRVmFSeU1XSUoyQWtlMDNCNTdoYnFCbUh5?=
 =?utf-8?Q?dHRY9VM7Xple+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVNSeGF1VjRyQWF3TVRhNDZxR2N1ZXNpUXcycVYxZndZaEVjQVA1ZVRqTUQr?=
 =?utf-8?B?TlFrdXRiaHlCd0gyMGZ2cDZ6KzlUYTRLN3FjaGVrc2IyeDhMaDV1ZGxTaG9K?=
 =?utf-8?B?SDRzaUdSMWpKTVpLWTllQ2RuNXcvUFptRXN5WVJnK3RDU0srTHZ2MFFkRGZR?=
 =?utf-8?B?WGVOVjE3bWtDR0Y1WU9OYWEwTldvSEQ1cW5udmh2UFFGOC9YT2xDNms0R2R2?=
 =?utf-8?B?VDh5dVFkU2Q1bUFLYTd6c25FSGd4d1c4Ti94dG9iZUJtWEZJbVhSYjIyaTlM?=
 =?utf-8?B?dElscjdITVJQUXBOenk3YWxNRXhvNFBZSTV1bWhSakZJU0JFQnpiTUszM2ww?=
 =?utf-8?B?L3V4WjN3ckNiZlhacFBLZndsZmNoTjNWK25rRHlYZ1FXSWhCaDF3NnBBM3di?=
 =?utf-8?B?bXpuMlUwUDF3Z0Y0dGptNnJ5bEg1c3lMdDNpUm15TTV1dXExeFlGMktuVHpt?=
 =?utf-8?B?NzlXb1grMlM3S1pMVEdkUmdJUExsMDFzTTY2K1BDeEUzVysrbUt5SjkvOFVj?=
 =?utf-8?B?UStUNmVwUzFDTUk5eEd5YVpnanV2aCtBMklDbVJwOUUra0hFcHVOR1RZL0ky?=
 =?utf-8?B?Z3kwaGs4a3p2Um5KREVhdDhwTkJJRHlYNFkvMzRHWXUwVERvbS9Ca0dwQmRv?=
 =?utf-8?B?MlJJcHV2dXhzb0xZY3ZMQ2hiR01UKzEwUkNiV1lEZU9vSFZiM1VVWWx2Mmcx?=
 =?utf-8?B?NkxtU3FzaXJySGo1RTA4eUd0ZnRlMDFSeDJlbWZFM3FRb043VklXSllCWWNO?=
 =?utf-8?B?TFlib1g5OUdoYWtJWFpBSzVEVHZ0TFMwL3ZESnVEM2RoTGswYlZtTGc5Uldj?=
 =?utf-8?B?YnBqUk1GeDRiRXpPOEJJOVBHYW9mUzFyVlBOcDNLTkhmQVJWdWRhd3czdmUw?=
 =?utf-8?B?b29HamVxTGY2QVppY1JrSUY1ZXZaeXBEbU05VWQ5SVhuWG9pLzFMZmpvR3RN?=
 =?utf-8?B?aVU0dVVVUVJsemNlRXNqekVtbVNDczF2OWtIQ1F4cWtjL25tdWpWd0EzSmFR?=
 =?utf-8?B?MEQvVUhpQ09hdW14TkpodkVDb0J0WUV2d0N4RXpGWWwzLzl3aHVOUFN2eGh1?=
 =?utf-8?B?elB3alZiM0MvcUZHTlNwSDFiN215R2s5WlVyZU8xS3lsUTdJbGVKZTlERVlp?=
 =?utf-8?B?WnJ3cGtXa04ycitTQzl6Z3dZZWFnZkJGcW9RQzgwTktNaFVOOE5pUmRxR1ZN?=
 =?utf-8?B?L0FUUmdjRXNEYlhSNHZuK2VPbXh3cGU4anc3QUFLQWRDSWxISzI2Rk1BVG5F?=
 =?utf-8?B?b25PdHJ1MUZ0RWt4QXk4UXhPSm9HZjJFSEczcnQrbWVYMU9wUFU2d1ZkK0Zz?=
 =?utf-8?B?QUl2Zk5LdnFvNXp6bm1DZE5wWnNKQlF0WHhvLzBEdHB1NGNnV3Z2R0w0Z0tr?=
 =?utf-8?B?RHVPdjB2QWdNMHpjeDl6Z0RKaHBpWE54UFc2aWJQNlh3SmduT3lwUlIwVEN4?=
 =?utf-8?B?b2MwWGFnb01uQTZCdk9vWEQ3NEFoclRsdElLMGx5TWJtQVNtdC9TenJtdXlZ?=
 =?utf-8?B?Wno1aldSNXpXWDVaaE5BZnhXYlJ0cFB1RHhha0V1bHdZZ0tGZm9pQ3JuN2N1?=
 =?utf-8?B?UVFrd2FzSy94WDlsYlpTREdsQUFhY2Q1TGdOaDNLTDRIcjNNdzR4ZTNlbmxO?=
 =?utf-8?B?MmdpaGpza0d0U2g0cktPTENVUUl4MHpOdkxLMEk5VHhDS1MrdEZWRC9GYnVm?=
 =?utf-8?B?MWNQMkkycUNWcENTbU5BRFU3NCt2aEJ2cmR6T21pZE9veHVTdUw4dzMzR3Ns?=
 =?utf-8?B?Tlh1UGlXQWo5R0VvR3hrWE03dXlGYmdocG4xVnR0VWUza09nNmhWc3lSWTgr?=
 =?utf-8?B?dnZPK21jSERHYVYwWWVZdERaS05GSTYyTm1yTTB5STRWa0RxS1lZKzlzMURx?=
 =?utf-8?B?Y0VkNDE4MlExNFBGdnFTYVo0SDZXTW0vcFZuMklvcjRoTS9VaDZZWEhrcGl0?=
 =?utf-8?B?QTdVeHFWVUFYSTg0U2JkS1R2UW9vYW9MU212cFllM2tTTjZKcHRUYmNJTm9R?=
 =?utf-8?B?YlFEaFZSa2FUV0EwN3Ztc0d4UEsxNEQ4cXJ1OFNkR3psMFdOWko4SmRVdHhQ?=
 =?utf-8?B?aHN5VEozOCtPaG95anlNUk1wS05nb0x6RXNQSC9EQU5tSHB6MkZUVzk3aVIw?=
 =?utf-8?Q?Xlxz/7KpLGOipttl3+pEyIOGi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6dcb3e-f59d-4625-f06b-08dd49c44f62
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 11:16:05.4269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALTEgZx56dccAHhqU96+go4GdcgUSxfezCd1r7RMWQFqXDCn3aokD62C0uIb8Jpx5M3ynjHx5QEuIwED2hrtXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104


On 10-02-2025 16:32, Vinod Koul wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Mohan,
>
> On 05-02-25, 09:01, Mohan Kumar D wrote:
>> Kernel test robot reported the build errors on 32-bit platforms due to
>> plain 64-by-32 division. Following build erros were reported.
> Patch should describe the change! Please revise subject to describe that
> and not fix build error... This can come in changelog and below para is
> apt
Sure, Will update the subject and resend the updated patch
>>     "ERROR: modpost: "__udivdi3" [drivers/dma/tegra210-adma.ko] undefined!
>>      ld: drivers/dma/tegra210-adma.o: in function `tegra_adma_probe':
>>      tegra210-adma.c:(.text+0x12cf): undefined reference to `__udivdi3'"
>>
>> This can be fixed by using div_u64() for the adma address space
>>
>> Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
>> Cc: stable@vger.kernel.org
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202412250204.GCQhdKe3-lkp@intel.com/
>> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
>> ---
>>   drivers/dma/tegra210-adma.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
>> index 6896da8ac7ef..a0bd4822ed80 100644
>> --- a/drivers/dma/tegra210-adma.c
>> +++ b/drivers/dma/tegra210-adma.c
>> @@ -887,7 +887,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>>        const struct tegra_adma_chip_data *cdata;
>>        struct tegra_adma *tdma;
>>        struct resource *res_page, *res_base;
>> -     int ret, i, page_no;
>> +     u64 page_no, page_offset;
>> +     int ret, i;
>>
>>        cdata = of_device_get_match_data(&pdev->dev);
>>        if (!cdata) {
>> @@ -914,10 +915,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
>>
>>                res_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "global");
>>                if (res_base) {
>> -                     page_no = (res_page->start - res_base->start) / cdata->ch_base_offset;
>> -                     if (page_no <= 0)
>> +                     if (WARN_ON(res_page->start <= res_base->start))
>>                                return -EINVAL;
>> -                     tdma->ch_page_no = page_no - 1;
>> +
>> +                     page_offset = res_page->start - res_base->start;
>> +                     page_no = div_u64(page_offset, cdata->ch_base_offset);
>> +
>> +                     if (WARN_ON(page_no == 0))
>> +                             return -EINVAL;
>> +
>> +                     tdma->ch_page_no = lower_32_bits(page_no) - 1;
>>                        tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
>>                        if (IS_ERR(tdma->base_addr))
>>                                return PTR_ERR(tdma->base_addr);
>> --
>> 2.25.1
> --
> ~Vinod

