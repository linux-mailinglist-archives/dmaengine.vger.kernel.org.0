Return-Path: <dmaengine+bounces-4809-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AC6A79982
	for <lists+dmaengine@lfdr.de>; Thu,  3 Apr 2025 02:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95FE01892775
	for <lists+dmaengine@lfdr.de>; Thu,  3 Apr 2025 00:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876A21CD3F;
	Thu,  3 Apr 2025 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WpaHx8hH"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE88F481B6;
	Thu,  3 Apr 2025 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743641871; cv=fail; b=WK/L3d7+VeJRryFzhkwFh+7xR0tAS9jxF1oTKMg1vPYpQDzI9aUKCtXWkYU/+BWknRHzFuIqVbDKe2bcop4OpAwoBlaLeSIcr7HxasK8cP+M21+zkHALtvlkRox5IGK6VLa3w6qORDs4ArIknSnF1uC4HifT2pA5iX9FuCusWq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743641871; c=relaxed/simple;
	bh=KIeLPud9fXD0g/l/cIL7YM0s/jlDk0+tifuwdf1af/4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FQasvgiw/7oyC3LUOzv4vtAAUK2sov6y/fOqTSnTA7JkkvE1BnfXEb4Ux8mkyP+jmLNdMglyoGm22UI7tv4R83mzvkNLBOXXDjpDRKyD3ic8pw1h03yGx1lbe+eFAcBj2snqeFc4U3757Y+5bnYOc0z/eSnu5uGlJP2EXTKIKU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WpaHx8hH; arc=fail smtp.client-ip=40.107.101.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saxOQ7L2+paJ89lsp8w49ZJwQVK0rsTajOf8X/J8GSMK4ad3e8RhZkKztK0Tt84lopksovH1q6Gv7KXPVr4Ycxv4cX/+ySf7n1y5fSPD7bJM3c7yxpfFgTk2vHwfqAejEpaKNPHmFetSQEKfjWr/DzLmd2i3SbFvGOsWeooQLV0U2V7OTIzZ3W1/F2pTmRn3BO8gtBHCcDPs8AnpOl4XY7kHuorZk71mMHVaFfMqtz1Vomh7oqE4k4DMaJsJ7f0qFR8BAqsuW5YByEeFuAA8hq6gpvHH+tBvUoeyTATvmxvxprqgPmY+xLzOl0kEs5AQtBhuK/iOSD43RAbvFPvgXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6m5rbDa+dgiTNwfiteS62Y19uwtKKtXdCWikB5J7j0=;
 b=ngFecx1HfzxusBeBMZxPejCs0evD2dlFvBF0WZOwziCNf22EduZKnWvKhTVJgZvsrdisUW/rdAHsscWV1+McCOwiGrtK2SM98MWyYh6+gNJT/7FFRRVKhmV8sHtB1GCYN2oeR8Yy7uirxog4gh8VoRyuTd5iR90ogjWpE5uMHEFPAyYpCBIsUmNlXSgUn2WoA/7Hb5QeZwKsJRSo/WDyCfiLj2M5E5e9m8OvtaGkPZA2We4PEIXhO96HTA4XXsOMZLxhGwY04oacIRGo76jmvWfy9pTqhEWfvYn22S+wbckDCdHyuxybsjvdd9yAeShnrunnxqgR6IT77MQzETVCKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6m5rbDa+dgiTNwfiteS62Y19uwtKKtXdCWikB5J7j0=;
 b=WpaHx8hHlpeANGoWnIUoaTs9sgch1dGx0n0WOdsdX2JM8EYK1IVN/VpgZNLyErA8+PYdcFt8Z5KP5fbMDu115L6rj1OgRp6wGbME9YhkuNG7kV7JAxSjXLsO0ZpNEZ/83l/+gyDdrleMFm4wddTSlc35FjpO9e3Fpx01a3QqgUyyH3ZLn99hWXpvZ9Np/gWGlNAgE0BuPHjnZXr0MRktjomsdn+bw0gEj3QHGd0QkPkhyvOm9YkqCdvEfzXn1aX0KidBWsiu5EgQ+jljBInmZs5cWTHsOk2TVpn+1qZXdp4GHWKWF0RGVX3ZiikDVyNBESvEQiuFpOtW55Ec71bo0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 CY1PR12MB9673.namprd12.prod.outlook.com (2603:10b6:930:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.48; Thu, 3 Apr
 2025 00:57:46 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 00:57:46 +0000
Message-ID: <a1b7d7d8-4fc0-4faf-9938-57ccd1b861ab@nvidia.com>
Date: Wed, 2 Apr 2025 17:57:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dmaengine: idxd: Narrow the restriction on BATCH to
 ver. 1 only
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>
References: <20250312221511.277954-1-vinicius.gomes@intel.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250312221511.277954-1-vinicius.gomes@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR02CA0035.namprd02.prod.outlook.com
 (2603:10b6:510:2da::30) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|CY1PR12MB9673:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c6dea0-0bbe-4b77-889c-08dd724a8c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amFxcDViMVhuZ1VJMHZTTW5jUGZzWEdmWjdZV013U3ZIQklmMzQzNGZxUURR?=
 =?utf-8?B?aUFEQnVHRVRUOHY1TDVrY3hTSU5wM29rTTU4TzQrM1NmR0JuSFZ3a1hFWXI0?=
 =?utf-8?B?VW85RE0rcVgwaFY3RjdQcHJCVnBEL01MSmtNM2ZYNTVFMVBzOC9HbzF2eVpi?=
 =?utf-8?B?c2RGaTg3RWF2Q1g4ZThvVm14eFJXY3lMWkdvWlhNU2V5cWJjYkZGM0pocFNF?=
 =?utf-8?B?eE1teDdXeGcyczdLOWg2VnBMMllmdkFUMWFPV0IvTS85S1NETWNpR0R5RXk0?=
 =?utf-8?B?aDR2cjI2amhTOXlWcEJBY0U2aExkYis1T3RvbWg0Uzhhc1V4QW5FaEtTSlZ4?=
 =?utf-8?B?dWh4RkNNZ2N1Z0VvWnd4NVRPRkFHZ0M2NWl1dXo1Nml3eFE4dTRMUEIyM2Ev?=
 =?utf-8?B?S0s3ZW5YalRSa3I5NUs3NUdqME5QYmNoRERmemNHbEFMV1F3UVQ5amh1VVpB?=
 =?utf-8?B?ekNBdC9DOXkwVXVNNTkwaTdhQmpPNHFjam0vMHRXdi9IZmRRUWRyWFVhQXFj?=
 =?utf-8?B?bU11R0ZRU3RhNmFGNEdQdHMwMmIrTGFLOGtVUW5ia3krekp5RXY1T200b1cy?=
 =?utf-8?B?Nng1VEpiZzdaN000Q3Zvbk5iVkJmTVIxTDhML29PZjQ5TGdiblRLMm1jRDh4?=
 =?utf-8?B?Nk5WRTk1OUZrSytybjBKYnZQV0hvSHJYaFVWWlkrQWZETy90Zjl3Q0VqNVBh?=
 =?utf-8?B?bW10eXZLOGZvTVhzNTlud3JDcnFsZlVpcXIyNWpoSWw3R1k4ZnNuSjhvY2lQ?=
 =?utf-8?B?QURwUTVqYVlQRlkvbXBBTnQ0WWZ1ZVVqUWt3VHZIZ25Ta0VyWE9DcS9YNTdT?=
 =?utf-8?B?c0d3UHVLS0pMN3BWTGdBWk5Ka2diMWlLL1Z1aGJtb1pIaG4rNWQ1bElubGt3?=
 =?utf-8?B?L3BJbjJWSHFmb2dJYnFZbmVTaC9yWHV0MHNuc25ycHVzQjFCVWxiMGRQRlJx?=
 =?utf-8?B?a1U1VFRRdVBBMWZFYUh5TEdNb2xhd3h1c05hTThhVkNaR3gxbjhBZkZlRUNY?=
 =?utf-8?B?S09scWpDSFhvTFRxMHZBRXkyM3pTcFZBYmxXeFdjQUVjODdoMnN6cmdTK3lL?=
 =?utf-8?B?eGdUTGxRSEs0MGl1YUovSUVzSmt1SXFIZUZYY2N3dGVQcVBoQnEzMDc4QUFx?=
 =?utf-8?B?Y0FkT1pULzZ2ZnE0V0FNczFIdWJxRCs5N09wY3ZrVVlsL3dWUVBTaU11Vk80?=
 =?utf-8?B?RHdOSlZjd2IwWVlMcU1QZjdXb1ZQdlNkclM4TjVoS21qbEhjZDlTcTFlRStl?=
 =?utf-8?B?M1FNb2FTYW9lajg1azV2NDUrTXYxVFhtSFVLN05LR3ZuRFNJNXhIMnEzeDMw?=
 =?utf-8?B?anA5cTN3MlNjemRRK2d3K0xsVCtWOUxzdzVxd2hDWUpPMzVqR1VMd09oUUtO?=
 =?utf-8?B?TUcydW4rSWdCWklhRVFyYnFSZTB4QUNMakt1VmZ1VWVta1Q1YjNJOVZmRE9r?=
 =?utf-8?B?L1gxdTlLeHF0Q0ZmRXVNLzZpMzFydUlyQjF2VGszMWpaaklXa2ZXVDdvV29h?=
 =?utf-8?B?SnY5emZtUEZzTEJLWjhQR09OazBSdmVhWEk5VHpYNkc3Ry9SNG85QXBvdDA1?=
 =?utf-8?B?R0VmZjg1Zkl2MHk5ZGtzMlhJWSs0OU1KUENxSHhybG5Ca1FpTnBQZ2tGd1Yz?=
 =?utf-8?B?bEhxbVpRWjN3WWpiUXE0ekdNaFgwYi85YkdKRGVmdnNaVjZUdFRWUUtUUVh5?=
 =?utf-8?B?WUx2ZHdObGd0cFliZXV1Tnl4NU1rL293YVpXeU1McUQyV0srdVdIR2RWRzNx?=
 =?utf-8?B?NnRMRHA0QmpPMm53QUErY0sra2EvalpOZnY3MmFVMmo1elM2dmNoZnhJVkZ5?=
 =?utf-8?B?aTNKWHJjcTczRGlCUUJKKzRHOVo3NUViRlV1OW00djJGL2p2WHJIUXFxbXVE?=
 =?utf-8?Q?7pnSuDB2UWMz/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVB2ZDFLYUpxQXJHQldrT2xXNURLditqbFJhcEMrRmtsRjY5bnJHdGhxckZn?=
 =?utf-8?B?bWozTGJPTWVkalJTNFJQcndEOXc1V3FiaVdDT0p4YjFnUEJRZ0FsMzNkNHN6?=
 =?utf-8?B?amNaSlRpSldNREhqQWtYVXBNMitjZU5vZVlIYll5OUZ0bjRmZkwvbndqNitx?=
 =?utf-8?B?ZzFDTkN0ZUlzV0UvNlgxUllOWmhUa0ZHNkM2ekJkdC9vZ3VCREhydFdHVU1C?=
 =?utf-8?B?YkpNQS9ZemEwRFRsNnp0cTFYMlFCMnFEQzFHS2pLNE1Kemt0eDhyZ3ZpTTRx?=
 =?utf-8?B?L3ZoakZubmlqakcvNUpmNXdncjkyem5VUGcxbjZsZFpBaG5kVzFQbWo3Y2Nl?=
 =?utf-8?B?VzVaRXN5NjVsNVdUc0cwR21xZ3dNayt1Wk51aDArclRLQUozZCtpbjI1T1Mx?=
 =?utf-8?B?Wi84TUcwYzlZcXRJZjhJMGMyZHJsbkM3MnhZR0RYRTdCSlR3ZlpUTlpML29n?=
 =?utf-8?B?aSsxUHZ2dlQ4ZWRKYmcyVGR3TVA4RTJrMGc2TVl0aUJ3OGdyRHU0U0VobFAv?=
 =?utf-8?B?Nm80dUFmVkRuK1Q1bFFlc0tqb3JiTVFqaWFVWktnZ05OdzFQNVpsL0dUNVRu?=
 =?utf-8?B?T1YzL29PWjBiZGluNnJFV1NSL0Jzc2I5S3hoYUx5TGxCL3FURjZJd2VJVVBO?=
 =?utf-8?B?NWZnNVdIVld0RU90UzFEd3c0SHY5ZmF5a29PRHNPWDFzVnJmU0ZIb250R3hl?=
 =?utf-8?B?WUZkcW1JalhTOHNWL3MyKzJxNCtkZ3JBTUlqK3VXbGQrb3R5K29GVmNyQlFV?=
 =?utf-8?B?RUxja0pJSTBEdm05RmdrZy9lRmlsWFFUK1JUcDZTWEVqTU9QajRnVHRLbG5i?=
 =?utf-8?B?NlNsRXlEdkJMaXNuSFFLRXE1cjVTZXUrZjJNSm1mbjFNMFduYm50dUhGVm9u?=
 =?utf-8?B?azQyZDJxQkpkcHZtUWgxVTJVdWZsMFVaVHAyNE03elZPdnkxa1RjY2UyYlRp?=
 =?utf-8?B?REpTZXVhSVNMTHhSRXJGR0lyK1JjWGwvWG4wU2M4cW1NQ1o4RWZGM0p6UzJW?=
 =?utf-8?B?cjRod3ppV2pGSHhEWG1sTFd3MzF1WElKNlBodnRvSWZBSjhvR1U3UzFWQm8w?=
 =?utf-8?B?V1BZNDU2SG96NnRQNWh4aG8wcVIwNUlYd3QrNjUyenVzeEJIaE4vT1MrZTJ5?=
 =?utf-8?B?ZzhyNGUvVTRZeEtRQ0J3cXN2UmpkSkhiUlkxTUhVWVVYOHZPMEJDQ3FTaWRx?=
 =?utf-8?B?TW5zaXBRc1hpeGUvNkRPdDRSYU1NK0VtU1lJdWVoY3h1RVZxRkVYbng2NVl5?=
 =?utf-8?B?Vi9YbFBvQjVUVGNZNk1DODNYMVltc0hBM0NPdEpLejd6cnkydnJYazFyZm5Y?=
 =?utf-8?B?UzhqSEs5NHlvM2JzV1RBUjlycXZsZkNGOWpyTzRDWWdsUDlsT1E3RHdXY2Nq?=
 =?utf-8?B?c1JtYzY3a3htS2hSczY1WExrTDdJbVc2Z0MrUE1EZEtaR043Y2tpbWYxRnpP?=
 =?utf-8?B?UW9QSGIwbG9yQkU0cDdXMVUyeGpGMmQyZlI5L29yMXVjeXF3UVVBZXNiK25T?=
 =?utf-8?B?YXlFRGlRcXc0NnlLWkZ4L3VmK3A4T2hGUUlVUmNmYWN4SWpYWFQwVUpUbHQ3?=
 =?utf-8?B?OXZOdXpSQW1tbUxFWlhTNTZ6SkFKQWx3ZFNKNGR4WHNuRFBrZ0RZbThaUUFo?=
 =?utf-8?B?eFE3T0czM1RuU3RpQW9CcFNGNXlrY3YzbjVoTWo3RzR6ZW5RZU9DSUZzZ2wv?=
 =?utf-8?B?NytITlE1dkZBbmZPWTFQa3hmV29YSHdaZHhJeno2MHIvRzgzekJaK05rUGs0?=
 =?utf-8?B?RVQwWTZ3eVZuOVBySkZzbklrenRmWWw5SmN3eWd0ZmVZL0pnZUpJa0g4NVRq?=
 =?utf-8?B?bGFCQ3J2SEMzczNjZmZBU0oyZFh6cCtXOVlJdnN0VFQvbXZmVUsvcG9Rendq?=
 =?utf-8?B?MHJkd0F1NWdaU3VsMzVUdnJkb20zRS9HYmdCdG8yVmdkY2dwcUErTGQwRm5G?=
 =?utf-8?B?MUlNVzFBdmpUd1hsSUJCdDhjUzg5eTdLTkdCaVdpZ29OdDcrcFA2K0kvK1FM?=
 =?utf-8?B?dm82TDR2cVl2UFZaN3JPZEtXWUFoV0hGRnpIYi9xL0dZcStyWUZuWHNISVZ6?=
 =?utf-8?B?OUord2Y0SFZFU2NkdXF4aVdkWFdqTVlaZlZqaU82UEdtbHgxaUFETDNQUTFl?=
 =?utf-8?Q?DrTPHCxBMh1r8bWzilM+oO7BS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c6dea0-0bbe-4b77-889c-08dd724a8c53
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 00:57:46.5784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ru/EEYk5xLge3dzqan4lAMY/0fzG5PLBe0Z3b5Kx23JxQ4TSSr8oLmHOXpEgSxVMSMDdyGwzHwdUNrWG8WpQvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9673

Hi, Vinicius,

On 3/12/25 15:15, Vinicius Costa Gomes wrote:
> Allow BATCH operations to be submitted and the capability to be
> exposed for DSA version 2 (or later) devices.
>
> DSA version 2 devices allow safe submission of BATCH operations.
>
> Signed-off-by: Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>   drivers/dma/idxd/cdev.c  | 6 ++++--
>   drivers/dma/idxd/sysfs.c | 6 ++++--
>   2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index ff94ee892339..6a1dc15ee485 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -439,10 +439,12 @@ static int idxd_submit_user_descriptor(struct idxd_user_context *ctx,
>   	 * DSA devices are capable of indirect ("batch") command submission.
>   	 * On devices where direct user submissions are not safe, we cannot
>   	 * allow this since there is no good way for us to verify these
> -	 * indirect commands.
> +	 * indirect commands. Narrow the restriction of operations with the
> +	 * BATCH opcode to only DSA version 1 devices.
>   	 */
>   	if (is_dsa_dev(idxd_dev) && descriptor.opcode == DSA_OPCODE_BATCH &&
> -		!wq->idxd->user_submission_safe)
> +	    wq->idxd->hw.version == DEVICE_VERSION_1 &&
> +	    !wq->idxd->user_submission_safe)
>   		return -EINVAL;
>   	/*
>   	 * As per the programming specification, the completion address must be
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 6af493f6ba77..9f0701021af0 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -1208,9 +1208,11 @@ static ssize_t op_cap_show_common(struct device *dev, char *buf, unsigned long *
>   
>   		/* On systems where direct user submissions are not safe, we need to clear out
>   		 * the BATCH capability from the capability mask in sysfs since we cannot support
> -		 * that command on such systems.
> +		 * that command on such systems. Narrow the restriction of operations with the
> +		 * BATCH opcode to only DSA version 1 devices.
>   		 */
> -		if (i == DSA_OPCODE_BATCH/64 && !confdev_to_idxd(dev)->user_submission_safe)
> +		if (i == DSA_OPCODE_BATCH/64 && !confdev_to_idxd(dev)->user_submission_safe &&
> +		    confdev_to_idxd(dev)->hw.version == DEVICE_VERSION_1)
>   			clear_bit(DSA_OPCODE_BATCH % 64, &val);
>   
>   		pos += sysfs_emit_at(buf, pos, "%*pb", 64, &val)

Maybe folder the DEVICE_VERSION_1 check into user_submission_safe variable?

This way patch is a bit smaller, a bit faster in run-time,  and easier 
to be extend in case there are other restriction changes in the future?

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 86075cdc4420..80f95cb815c8 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1258,7 +1258,8 @@ int idxd_pci_probe_alloc(struct idxd_device *idxd, 
struct pci_dev *pdev,
                  idxd->hw.version);

         if (data)
-               idxd->user_submission_safe = data->user_submission_safe;
+               idxd->user_submission_safe = data->user_submission_safe |
+                                            (idxd->hw.version != 
DEVICE_VERSION_1);

Thanks.


-Fenghua


