Return-Path: <dmaengine+bounces-3127-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F05B972127
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 19:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C562822BA
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 17:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B0D17C7D4;
	Mon,  9 Sep 2024 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="USnl1M7V"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4C117A924
	for <dmaengine@vger.kernel.org>; Mon,  9 Sep 2024 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903342; cv=fail; b=YRH3bxN2AlpScTO0kPvyIoL2clphK3O9h6SQlCNi7bz0Nsa1MvT4fJfb71OrJ0BR9X8JiIXDrMv1AyAZo6h6bAh56fMy4u9nHhhnyGJgbw7aDJq+uABsGBHpxJXD9XqCKRMFrte9YKCCRdoqvJFBR8k1fKIPo2Iz3Q3n7vHWSCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903342; c=relaxed/simple;
	bh=7J35hZRANFSLqaCzRt/xpmNg6bz7T4okiipT7+eiY6E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bdr2MrMvQy43aGvW/NDsWaoVQXMA9x7TgTuE9EUyGWCXaL/NkuyOOiqKMZDFOdlWb92HucX2MJ1S718I22y+5qIH+4J3kxqNtO1LRAZwkKRvMyL7iIVS+8IpstOYbH/EWCJqjGfEaXMPuZAbCAu77wYtSxx36rsIsqeBec1nJ14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=USnl1M7V; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGmuP1sJhsCdtTLPH4Xvx+kaxQE4RFbVvqCrar7hjCiGA9RcnAzuRVbaEuQ0GagURYs1f7c88YLVF3ZoJhzrNv0yZgUW5luIQ2NTpE2aws2jv7PyPornwKVjinTgzhw0DGvppeOsXWmqUYUoipszGFL2Nf3P0ryYDGJnIkHstCsxNuLPpmhfYlnFT9HeKwedZpXshy8v2OC8ryiCWjy1JkuAt6EqJKj2z5jHzMG+z1aQMnYY0lhCSURBWQPQShgQE8yJiKPLbuCJdS2b+BQOGrXFE+WvXuuAfROQp3OkArZwnBwjcIzwR5hJjvlp6VcehM+4je565T8a9Pe0YWoKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7J35hZRANFSLqaCzRt/xpmNg6bz7T4okiipT7+eiY6E=;
 b=LkAOSekDxX53UYUaj0IlzhOESaEW+hZ7v26Kk9q90ent+apA5IK1ThdYtp/YqCJ1hVuTGdIdCSAzcQeRuTmc0AvOlaMOHWU93uHel/SdrW91s3QWU3YpnrwqAnHNFQ02K1bMKGHCNnDiCRaVLVZd7yk1pP0Zo2K0XSBCAA5f8ZmN6g7XoqFAYffx4g4kxb1/AuNY0XCFVzqmI0ol+HliVFx4lJcDmQwrK9sEB9rwFDEUt2BpHsdpVHBqfZvdaPNT3uJpQgN/UQWfylZMgSJJL2k5uNXMn5X/MQEdNKshhLL1gYZxRF5fZy0MKa3ggTssWN8nfYEGwDOBjLX5gaOUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7J35hZRANFSLqaCzRt/xpmNg6bz7T4okiipT7+eiY6E=;
 b=USnl1M7V68h3eZP56fb8n2LofSfk+oEJ8I7J5y0ysbdI/VQd7eJBteiKf9ur0XdBMViG4km87pYiQOIkeFqEa1uF1rvvvb1eNUtagbh9VHYY7WLVhyQbDj5l1Lmjtu3gcSDebdZ4S6uHou0+JAu1aIIJATjlvfiZUysG2DwCBE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CY8PR12MB7660.namprd12.prod.outlook.com (2603:10b6:930:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 17:35:35 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%7]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 17:35:35 +0000
Message-ID: <d4a24e99-e1fe-4ab8-89f9-f13219160099@amd.com>
Date: Mon, 9 Sep 2024 23:05:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] dmaengine: Move AMD DMA driver to separate
 directory
To: Bjorn Helgaas <helgaas@kernel.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Raju.Rangoju@amd.com,
 Frank.li@nxp.com, pstanner@redhat.com
References: <20240909160049.GA531275@bhelgaas>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20240909160049.GA531275@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::8) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CY8PR12MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fc45a9-f79c-4fbd-913b-08dcd0f5cf9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHlhQkY1eTY3UWkzTzhwU1J4OHliazFpYVNBL1IzcURCTzcrWjB2S3dWcU81?=
 =?utf-8?B?WXBGS0U5QUgwbFVteWpnVk04RnIvOEFkRDJTNmZNOG9KdzFQcnZKWVZLajZX?=
 =?utf-8?B?dm5qOVNLM0hmREtkT2M2cENUZUJWUjBldVJtMHdSUnlNZTl0ZE82cXRQUVpk?=
 =?utf-8?B?V081dFVlWGlVemZNcVRvdGkwU0VpaDNFNHkvUEFVOFRQYWdDU1dwN2dPYldk?=
 =?utf-8?B?alBxekhreEhyblVpVGpXNG1IdGkvcHVkK2FkRkpha2hjVkJzWTY1QllnUzVr?=
 =?utf-8?B?WDBVQXV5RjRZWForNmRodXUzcU1jY2hpZExZOWozY09RRjZ0ajRDeWdtcXdo?=
 =?utf-8?B?dVE0MzYwUlpoQ3RkVjFCNVUrYUpLQTFqRkZiM2VZcHZBaUNDOG14UmR3Z3JE?=
 =?utf-8?B?SDl2MUwrcXhNc0JHZW9TYVFxbU9LYktkdm0vZ2h6NEZSMHBBRE5zM0wyVWN1?=
 =?utf-8?B?L3BVeURPWWMxaFJoZEdneWpTOHc1YUI2N0hEODdCaVlBVkhycGlVRkM4TDRY?=
 =?utf-8?B?clN3NnBPbVZadmtPVmpnVjBERFlOeU1PNTJ1Y05SU0pTMmVQWlFpQUhXdE9S?=
 =?utf-8?B?NUhFL0ZMZEV0b3BZTGlLTkNIb0pBTHpPZVhMWld5L3FoOWhRM3NSRGZPTVFC?=
 =?utf-8?B?bmRia3k0eFJNQkc3WVNDYnhhL0VhSFdrd3JTSFQ4TGV2MUZnSmRBUEl3US9G?=
 =?utf-8?B?Q2pFZG9KdVN4cGM5cUIrL2Rjc1BrNnhjc3lYWWVvdXJnTVdjL0U4cnNtcC9Q?=
 =?utf-8?B?NE9MM1NBZGJ2WVJhQUZoNDA0QzBpYWFwNElGS29sOUUyay9qZEYzQXVxbDNm?=
 =?utf-8?B?NGZsRkZQdFJ6eExxdFYybmxwUzdtVUVLRDkyRWgvZEtmSFN0aHFIbk9aOXJ3?=
 =?utf-8?B?L1lWV1AvK2NaK1R0U1dSSVBFS25NZ0dzT1B4N2JDcGxLdTZUSXI2N1MzMHMz?=
 =?utf-8?B?bjJjdWtMN2U0UTBqdmNuS2tFNDFQTFAxRk9paGJzK2pMa05haU9hdktwZERP?=
 =?utf-8?B?bVM0dFFzcGZadnFkSkhxRjJweHQ0dWpZUmF5RlBCVHJpbzMvdkRrWGlsYTV3?=
 =?utf-8?B?cldTSzhpUzlvcE5RU3ZqZlZ2eFErUXJNZlFsNjVhbGFnaEtySW12bnlkWEtW?=
 =?utf-8?B?WEdqbER1QVdKSVpldzdoU3BSKzFISXM1YXVJZ3VVT3VxVEpURE5hU2FOa1Bj?=
 =?utf-8?B?UWlwQk4vNnN0VXBmMzVRYXNrRUdGSEN5YlBFWXRFZEJJMDRtdHF0bko1ejlC?=
 =?utf-8?B?L0htTVQyQStscFFucjMyd0Fqa1h3ald4dWZxVllERjRhSmVkMzZScFhzUW1J?=
 =?utf-8?B?NWNSSWhFYms2VHc5a2RSMlIrdmxvckRkU3lIQlRKeUkwZWo4TmJrc0I2eURl?=
 =?utf-8?B?LzQveDlvNEwxOHVnemErU0Y3Tm9LYm5pMFVpVlpYcDVEaUdGTHA3RXVxazhj?=
 =?utf-8?B?RHNKUGlGKzBKN29JOU1YcHNHa0crTEZhSHF4ZUJBV3B4UTk0OGFuSEw2QW5I?=
 =?utf-8?B?Y3BwVDQ4MTYrSFpyOVFsQnJBZVkwZnd6d3FJR0JVZnpZczArSlBrcU9va3Ju?=
 =?utf-8?B?OHBmbDhlNTVwNFN3VUhYK3l3bTNVMkN6S1IxdDF5Vms3bzA2TzRVUUVKZEFD?=
 =?utf-8?B?aGNkdFJQK1RXUmxLRjhXa3hIZzFXMG9kcEdJVzZBbzJsL3BqWEFRbzgxTDZY?=
 =?utf-8?B?RTZuRlZJcUEyRE9ramZIUmdGY2loNXBhOEpvYTY5c3NQbVo4L2JRSlhWNnlM?=
 =?utf-8?B?UENyN3lkRGZRVG1pVWIwQ0wvbE1qS09TakJiWGNORStleVlZeXZqclJCVVFl?=
 =?utf-8?B?MDVPRllEWTZlR1VVU3RnUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEdZNEdTcnlPMVRmR3hwR2ZLY0lHQUxnaXlSdkE0Uno0RExpY0tKOG5WdFkw?=
 =?utf-8?B?MGpGd3lmUDZGMUc3MzA1Ym1ueGQ5cW56Q1c1V2NhZkE5K1hxSjZuV3RnV2tk?=
 =?utf-8?B?M0YwL2Q0cGxkYTEvb25PUERPOEYwNVNtSG1GOUtOeWRZZmlLaWFsL0V0K3Yv?=
 =?utf-8?B?ZXpON3p6SUN3a0tmaTRlVkYxR09QL2IwUDJLcFFyZmZKVjFGS0MwRzhwdkVM?=
 =?utf-8?B?UnZWUVhYU3lOL1IxRUdSNGtCZCtLMUlzZDE3WUNvQTBJVjlyTXIyMmp2VG1v?=
 =?utf-8?B?Y2VPOTBOUnhjcHpGb2RXb2t5Zmh0N0l5L3ZXbUNRU3N4cFdodVhWZzJTS28v?=
 =?utf-8?B?YllCMmVDdWtlcUhVSEMzVDJxRmpueXc2QTNOUzR1MWxyeE13WkFyVFU4ejRt?=
 =?utf-8?B?RDdoalR4V0s1YlV4eFBlazlEczRjeW1pY1VyRDgzSndRYm01ZFNGK0dSVmRV?=
 =?utf-8?B?M203RUd5WTZzdXhoRXFGSTNwSE9JellpY1JCUS8xK1lyYWs5bnorN0RyWkRZ?=
 =?utf-8?B?WnBKWjgrYVF3MEYxYU5lb1RmUk16Zzg2N0dRRVZuVHZmNlV6dlk3Q2xZbjNM?=
 =?utf-8?B?U2x0aW9QTkxiQVcyeVppaGZyOExUcWdBZXhPcVdDbDRQT3BBcUNyakNlTGxu?=
 =?utf-8?B?cHY3SnVlb0ZBT0NBaUdpaEZHcGNyZXd4NW1abUNqNXpRd2FMV3RGcFZrbisy?=
 =?utf-8?B?YTM0SGhOZzNTNXEyNDJKTUNvTWJvVmJXUlpJaWtBVk02aUNSS0NHMFpZSUE5?=
 =?utf-8?B?WWlRT013Z2pwZk9ENG5rOVNwVmQ4bDJmQ3MxUWRISEtlOElWT1VlMlVId0pu?=
 =?utf-8?B?Q05TUkJ2U2lCMTFxRm5iN0pRcWxadlQvWHc4N0pUSkJybWVjekZUR0xxdlNn?=
 =?utf-8?B?NDFEQ3JLR2sxbHFnMTlWKzdqLzNwOGJGUEE5amdiQ0tVRHpQSHQ2RkhiTXlO?=
 =?utf-8?B?OW1paFUrWk10MXRicHB3K2dSdVBTeHNFbUM1M0N0ZEdyZ0hvYlQrUDh3NG9S?=
 =?utf-8?B?WGJNS0QwZUpNTVluTzlHOGhSZEo5N285T095N3RSUjNxbm85K2RMVmFhZlNt?=
 =?utf-8?B?VUh0MjROc3pKTmhxb1BrQ1NsTWhoVjl3SlVKWHAvZEQ3V3NMTG8weDlIOFg2?=
 =?utf-8?B?MzJvMzRaSTBpb1FJcFpvVWZJVmlYbUk2V2xxcU5TR3VBNHRVQ1RRODNDaGZh?=
 =?utf-8?B?ZHBkYjU0MHVzNmNvNXpiVE5ETkQwd0o0VlBRMnRLU05qdkIrVTlOVFpEUWF2?=
 =?utf-8?B?UGJNU25pWDVUM1liTUtGVWRVRFR1a090cXJNRGhFa1YvMlBkR0tBN0pvdERj?=
 =?utf-8?B?TXFsK3NXWjh1UUIwM2pNdDJzelhaV3I0VFQ1cVMxQWJUVktsaHRnd0hHem9M?=
 =?utf-8?B?dm9vT0k3bFVzczBidnJ0OE5PSWppbGwvRWU1TnBNM3RRYmpGdWxMSFhiYWxv?=
 =?utf-8?B?Yi9TVS92elNjYjZRbmJEM3cxTE1LK04vdTVEcjBmby85ZmtJOFlReW9LWFVM?=
 =?utf-8?B?WllBaWE1cWFDR2ZHRGF5am0vWGwrUVJyVGYyNXNKME9KQWdzRzRkdCsyeTVN?=
 =?utf-8?B?RG1POFpnV0VPMkh1c2hONzdaZ2k0ZGZ3ZlhZcUJhdlBSaFpoZnVYTm9NSFRz?=
 =?utf-8?B?R0NtMGFxRG5NM1BFRUN6eFh1VmFlUTVubUJVeTNMTFk2VWlmMHVidlFvTHJC?=
 =?utf-8?B?RU54OS9LWTIxOG1iVTB5Mnc4ZVRocHBGWkFiWkZMODVTOWMyaTFPWHpZUURI?=
 =?utf-8?B?enF3OEExODkyLytoblpLQTJ5ODl4b3hEVWNXMmZZV0xiTUduL3J3NXQrZ3dR?=
 =?utf-8?B?R1dsN0ZYWWhpa0JwelRSMkNUOEt2UU9Ra0RETmUxQVVSaW50SFJZQ3RMREFS?=
 =?utf-8?B?dThvdmt5UnlSUGFFaC9iRnIwaHIyUmhsQng0aVc0UXV0dVcvWC8wRlQ2MDg1?=
 =?utf-8?B?NWtjcmpWaG5HMWJHYnFWZ05XMEpXbUplTFZoeGlEUUU2WjBLRVFoMm9ZVDZG?=
 =?utf-8?B?d3k0Q0xJaUp2ajU5NE9FeUtEUHh2NU00UUs3cytpS3VhL1N1NW5LSUVHVG5J?=
 =?utf-8?B?bnA0UVlxRmdGYmU1WU1QN1FRaWJ5QjA3N1FRMzlKcDA0d0dnR0R3VUlZVzYr?=
 =?utf-8?Q?pbDDCkLOS1slWML8fpbTldfQB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fc45a9-f79c-4fbd-913b-08dcd0f5cf9b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 17:35:35.4884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpnjtyuXF2fuB+8fG/iAWnmBcFuUMOsJINrHC/2zVOqfrSh4qV7qETzx/kX/Lrqs50NMG0necw5OIhFjof5wGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7660


On 9/9/2024 9:30 PM, Bjorn Helgaas wrote:
> On Mon, Sep 09, 2024 at 06:09:36PM +0530, Basavaraj Natikar wrote:
>> Currently, AMD PTDMA driver is single DMA driver supported and newer AMD
>> platforms supports newer DMA engine. Hence move the current drivers to
>> separate directory. This would also mean the newer driver submissions to
>> AMD DMA driver in the future will also land in AMD specific directory.
> Since you're adding a second AMD DMA driver, the one-line git history
> will be more useful if you mention in the subject line that this patch
> moves the "PTDMA" driver specifically.

Sure, Bjorn. I will make the change in the next series, such as
"Moving the PTDMA driver to a separate AMD directory".

Thanks,
--
Basavaraj

>
> Bjorn


