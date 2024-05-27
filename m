Return-Path: <dmaengine+bounces-2178-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357E38CFF13
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2024 13:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A0E1C20A75
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2024 11:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C16E15CD7A;
	Mon, 27 May 2024 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J+4asMU3"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A8131E41
	for <dmaengine@vger.kernel.org>; Mon, 27 May 2024 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716809660; cv=fail; b=r3Bm94lks2vw37huxEf8+OUz7Lwr+S5+oWtzxL8uDnoNPHiB663C3i3ZvMSLeRyEp48J+maHjfcrcKyuuxwXF2CAQtJ0jX5F/JKmkTqwcVh8ndI0nldIhxsmELTDsu3zpBJI5FnGdL+YBvIFqrGuOrdQksuLTh3+ejMsdxEH4B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716809660; c=relaxed/simple;
	bh=L4pVPrzMSymANLOo+HXVvNfJ0CMPLNauBcQrK5mqqsU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b3zjJj7yktlLdMB0wS9SU99uewVATf5atjhRsP50XryM35wevkBwHzVvpbk+yS3POFnFpKtbibV+x+oXdz79InXLxzrqu4Xx6NJDV1T6RsqLK+HGDZm0ptBjeQ8jEuYVU/xfovYf5E6NHpofBcqi+TbvHqYfF5mgJWD2/mIUKuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J+4asMU3; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFlXAqlXzRRm8/2WoC8xuyKDWkmWPjt35wRxPqc6DX9F300HF0GlO2k+pvC1Nna1K5kOgxgfAq6OpUkoGRWEvkI3Zg+xuP5Nmq9wHQXhcP2WtSYtCjadTluhOke7bNJstd3evR1c6kNCd8XAvWvFVVfzAc93NiYkbKVG8rusFxQJ5977g89pesbrl0a3MibJW1erJU2FrdiwiPJeyFrNbrJ1hvLpsOXf7Qro/K+X6bqVeeW9MTI1hrkZpGCP1DFwAskZT9iyfXmooJdxcQnbuFHIwvs5L24gFMoyIGk+DUiLWMmKdh03kHCn6ScNd+++o/nm588pTHYXPZHC/bqmiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttDejlXK3U7LmwhzHOuGemBMLDUC4ZJwfyxf0Wn3NeM=;
 b=RsneZ6SXhnJHVcCNTTNLgDTnatBb45Snj7TKptF9fAA4mNFe1Gw86RljMe1aOnARb3e2iFizGmGnQqSMaqCQPyErHWzbgs8wbX/zpeHLT6buq/7D0Roogn2zrCjklfLJW+QkbCabspJxm75Y7sADHVmb826Hz0w4L7qG8hsCtH3Uti66/P3wjewt89ObzM4jNE4l5IbEPc90u7x0Awa5JqRP/0f90OP1PVTgjP8AbhBwX20P1D7rh29OIVdpcj4sbK4C4PSZtuUTrLKOaawNPqDd/hilVTcTDWGaEwuKZuJLSoaF0qIU52K1vg6vlVHHQNuIK92RAVDsM3GaLN78gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttDejlXK3U7LmwhzHOuGemBMLDUC4ZJwfyxf0Wn3NeM=;
 b=J+4asMU3MBCKBIzo56BjVTC5jqElnGSvhQKNGXU46l5N9oZ0mMvSEhc55t2S1svjBcY63yZc4yU0yqprbKg2meZ0+7lM+Vudiqvcp0fwuVzHOjfjz/EMXaV9VeIyCVcYiX3yg4wEzAbF0cysPqyEOnqkGWRokKJx90FOPw/ALx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 27 May
 2024 11:34:11 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%4]) with mapi id 15.20.7611.016; Mon, 27 May 2024
 11:34:11 +0000
Message-ID: <6d8d996b-1732-4e69-95e5-af4673d24908@amd.com>
Date: Mon, 27 May 2024 17:04:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] dmaengine: ae4dma: Add AMD ae4dma controller driver
To: Frank Li <Frank.li@nxp.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, vkoul@kernel.org,
 dmaengine@vger.kernel.org, Raju.Rangoju@amd.com
References: <20240510082053.875923-1-Basavaraj.Natikar@amd.com>
 <20240510082053.875923-3-Basavaraj.Natikar@amd.com>
 <Zj5kmc766qmOwjq1@lizhi-Precision-Tower-5810>
 <22e39316-d446-46a4-9c11-96e97413f842@amd.com>
 <Zk+87eRJBvbO+BhG@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <Zk+87eRJBvbO+BhG@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0200.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::11) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: 5602cca9-e88d-4018-c373-08dc7e40ed8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEs2Q2JCOWJ5UEVOVS9zTVdlTTRDeWtnWHNlNXQ1ME1jVnVmZFRDZS9panY0?=
 =?utf-8?B?ZkpSUmtNdWFPdU5TcTBVSC81eTM1VzNVODltMW9xeWYyOGlqVDJtOWt5dWdw?=
 =?utf-8?B?YTZNNDFwbm9nQUtUeHFZYjhOR1pGQWt6Zk1kdTRmWEd0S21MT1JWVjdmc096?=
 =?utf-8?B?aDQ3VDU4ZUlUMkprV3UveDNtU1R2cTVDQ1hicFN4R3gxc2ZPSGpLb0J2Q3RS?=
 =?utf-8?B?VkE0K0xuS083ZndZZXFFZ1ROYUVlY2dsM25aeXlUS0hlMDllQkljRk1GR2xy?=
 =?utf-8?B?MkVtZ29SZG1iQUkrZk9KMXAyVmU1cnJ3REZoZlgzTFh3R2xSYkM1R2hUU21M?=
 =?utf-8?B?dmRNVWFNMDNESW5rTG9PWmUwTnQ3S2I4ZDdGOFVmSTltMDZwVmVhY05TeCtx?=
 =?utf-8?B?K0VKRk9IcTBsMWZNWmY2dzRzOUIvT084QkRJWjQ3TmZlTE52bHlWT0EwQUlP?=
 =?utf-8?B?KzExcDZKQWVHS0w3RzZ2bzhTZm56R2piM0ZqME1OdC9Id1Z4R3NPOTZGRS9m?=
 =?utf-8?B?MjF6NytkeFZNekFPYklzSXBETTBSSnpydjROT0p1bld6K2UrYVZhckF1SXlr?=
 =?utf-8?B?b1ZKVUgySHI4NDNzbGZCQy9CNVhoRzlWZDFhVVVKQ0gvTTRiTVBmME0wTXo3?=
 =?utf-8?B?UUJPOTV4WTdkcUZHTnJzYi8rVStoYzA4ZjRyTVZpYWhuU3d5bG55VWV1dlNJ?=
 =?utf-8?B?ZUtTbVJ2T2ZEbDYzOXlqMEJRRlhEQVpNSVVRcEdrR2NENHgrZDBwSldzbEVD?=
 =?utf-8?B?Nkp2QUNmN0lHU2orYXpDd3d6cDRXd2IzNFJqV2FFU1NJbFlxdGNtY1VvVXIw?=
 =?utf-8?B?K1dRWTVlVGZDRWRkUHBWSjRiWFppT1dXLys3MkRQY0hYNHpLT3hwb1pEeXpH?=
 =?utf-8?B?bTM0SU9kbEVGRnZGZ1NXV0FUQVlyNUVwa2lUT0JhQXprSjZTdTZFZWU1U3pz?=
 =?utf-8?B?UUh6STFRblIwS08rb0VkeEJaU2RCWlBKV1IrMmZLWFFqMW03L3FDc2J1UjJ5?=
 =?utf-8?B?cDlUM0RsOWJxYTZUditOQ1ZLOFBtamJ5MHAvQWhPUFlmQy9kVEJxN1krdEFD?=
 =?utf-8?B?Yjh4SnpOeHIvQVdOb0p0UlV5UEdIa1h1OXMrTVp0Ukpra2FVWm1tWlp1SzhL?=
 =?utf-8?B?M1hFRFpmd2JWZTIrbkxhN0JYUGZLSFQxOHJkdkN3dUplRkJ5TGZzWFFIQWFR?=
 =?utf-8?B?a21PcjZNczR6Tzd5UXp0MTFlSXhPZkx4YW00UzY1K2JiQWdNeHZRRExxMm5l?=
 =?utf-8?B?S0doWWNoakdMQ2YwMmluNjJoT1Joc0svSFc4V0o3N29ZTEN3VlREUmF4VmlG?=
 =?utf-8?B?bjkxT3h3by9tTU5aeUpOSmxRZVpHOEhyclpZbVJPQXpLVFU4cFZJRUUyVldH?=
 =?utf-8?B?VzBYT0pqRkVnZndlNWN6QWM1ZVNka0lUS2x3ZEJROUxxdmpGYjh5ai9SaHBY?=
 =?utf-8?B?eHdQTFlxYzRtLzNVQnU4cnF4RmxOQzZvWWxNNWdwNExtZUI4dnplN01oMm9h?=
 =?utf-8?B?THJxZDJvY1gwbmRHTlhrVzIvcnExYTR1WVRUK1ZkaUM4MzlRTWFvTW03Mm16?=
 =?utf-8?B?dE1lVGljaTVOQWVTNGRsanhmNFcyUmQ5NVlOdWErVWFHYmpSMGNXVDZXM0xk?=
 =?utf-8?B?RW5lVnI5eHdMRS9ER0oycWl5VDRHQkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dndMTGRLbU1yUVlraVVkaUEwVFd6bitqT3hIQlJ3Ykg1UjR0TEl2MCsvcjVl?=
 =?utf-8?B?Sm83SmFDaDYybHhxSVBYWG9BWndxdDRtSUhZaSt4dlhhWS9IYzYrUjl5U0w4?=
 =?utf-8?B?YW5UVzhwdW9NYjF4ckZoblFoSnpoWTFXSVNHc2NlNmVtbVFHdVhzalBaenNG?=
 =?utf-8?B?TllOWVYyNmRYSzhMamY2OFVOdXZISnNpSmNzVkhYcG55d3NjNGV4TWd4RmZ3?=
 =?utf-8?B?Q1QzZFZsTVhrSmhrQkk2K0ViTzgzVEQwOGdicjdkZUhENDNhcUhPMitEM0Fp?=
 =?utf-8?B?aGZjZWR5V1dsZlNJeG9talJtdWxLS1l6YmVDV1dXMkRZWWxmOEYzWmtWWXRn?=
 =?utf-8?B?RUZ2cExPR1lhQ0hqR0FtZzIva1BFUitwd1hqT1pab1J2ZVlmMDJuYzM1enRw?=
 =?utf-8?B?dHg2L25XbzRSenRNeGdkR0EyYkF0U3FMZGQ0RlFaQm5Gc2l6RjFVSFBOTExI?=
 =?utf-8?B?UlBlTHhobENTYzZqb0RaV2N2eENJL2p1cWNsbXV3cFhzY0paZEFjNVNTUHhn?=
 =?utf-8?B?TE0xTHZsZTFvbkptWnFMM3NkNm96cUhHV2QrVGVRYm1BaUhpUkNMM2VhSUpx?=
 =?utf-8?B?b0FYcWI1aGdHS1ZCODF2L0t6MjkyditNSVVRaG55WWVyVlNIRm9UMTM4bGFx?=
 =?utf-8?B?MWpvTmQxK3pXQnU0ckZXNkdmZjRDL25hU0NNcVRTRUhWaFlBbmdjcjRoQlpS?=
 =?utf-8?B?TDNTUkZobUFSSVdwbHp4d3hkb1Y1OGJtek1ncGF4VWRHYWtQNHZlVzZqS0tT?=
 =?utf-8?B?S09paUlhRE9KOTVwZFg2VVc2M2RBeDBpNWswWTVQcTdzT3Z0d2tNZ2xpTnJF?=
 =?utf-8?B?dG82WHZNVzByWlVyYVdRSmxHMEZiQ3BTOTRxbVlNZHJ1VVpkbktDNVBUVmRr?=
 =?utf-8?B?eDh4TGtnUzdiUGtNNlNXZlV4cnh4Tm1DU24xMFNmY2l3ZytQa3JZcjUzcVZD?=
 =?utf-8?B?N1NTc2QyWjMxSXR2NFBYRlhHdmpuTHFJalBZNXVjeitMYmhCeE1vM2xOT2Uz?=
 =?utf-8?B?RGxON3J2MWFDY2FQVUsrOW15aWw0b0NOeTdVeFZmRngvV1dtSlRXRGtUWjBt?=
 =?utf-8?B?TDdYVnc0V2RlcUNJQUpOb1pCRnhuSWZlZVdxMXRUQ2l5emh2bm44dmE3b1ZI?=
 =?utf-8?B?ZmtLZXFBZjR4eENtNnFHeEpqOUFibDROUnd6bG1aYncvdEZ1UzFKeVJrVndy?=
 =?utf-8?B?V0phNnE5Wml6bnphUE5HN0xYV216VFBBZFZtaDJkZ2dhMVZ5ZnZsNEFhb1hn?=
 =?utf-8?B?NjVRVHlEWWZJSFpJdGxmTHpydnk2cjExWFdud0x4T1RjUkRza3RHclE5SnVW?=
 =?utf-8?B?TXBhVk1FTUFvbUkxdDJRd2QzT3gwWFBPMFE2aGN1RkJ2a1NnUUFURkNPUjJU?=
 =?utf-8?B?Q2Ivc0daVGM4b2dDN2UwS24xVmJoZjRyaFc2VGIzNkNsbmVUeVpqM1VZa3Ny?=
 =?utf-8?B?dnA0cnd6SkREQ1loNEt3ajc5YU1MNlZmTU5Mb0RsOGcyOUdmMm95YWlpV2ds?=
 =?utf-8?B?WUExbzY1eG12VHR4Q2dxODM4NkVKb3phSTJ3Nk1nVXBiSkJWY2o2OVI3VjhZ?=
 =?utf-8?B?MXMwU0FTZHlMVStPbnZHU1VMNWNsaklhbkozMVpVekhMK2JqNHdEK3IrU01m?=
 =?utf-8?B?NTg1UVFNNUFqeDVMTE84blJGV2xhWkFBTmJZSEVUT0ZZQTJjMmFaM1RrQ0hj?=
 =?utf-8?B?YUhXQVMxS0VWNmZybzc0eHpINjRrYTlUdFk4S0V5UGFwMXhWWVJ2TEtMWm9q?=
 =?utf-8?B?REJ4dWRacnFORGE0anFUdDhIWUhqaFNab3hGcktBbVk1ZVg3VWMva21xZjUy?=
 =?utf-8?B?ZXZ2d2tsRlJjTjFWbVMzdWdUelU4UWRUK3Y2T2p3b2J1VXZrSkp2UHNQTklq?=
 =?utf-8?B?b1NjamplWERwNmpYSG5mQ0dJTlVlSnRlQWRVY3dGcS9jNWJWSjZ4RHFOWG9U?=
 =?utf-8?B?SmNWOUFGU1A2WTYyZ3BRMnlyQWY3T2psQ0VCRGpnZGJDQzVMRTZlVFRTYTVZ?=
 =?utf-8?B?MlNmUzh0eWkvZGpkbGxrWHRCUmRLRmtSckk1emZlVFhxbHhON3NDRW11OS9V?=
 =?utf-8?B?L2xvaVltajZDT0NMb0dZYlgxTFFJdzBxb2g0eVJ1ekFZa1JGZ0NtL0M1MFB6?=
 =?utf-8?Q?2Ac13AiZJgDddM22XRx8kzcZY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5602cca9-e88d-4018-c373-08dc7e40ed8b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 11:34:11.1480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IzvluRR9ZtZkmqsMQNnl59dDhO/fi2BEiCVnF91zYoUYFK3sziS9vqMoS9VTGrwV81bOqZ+uTX7YrPZ8NQ0O2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353


On 5/24/2024 3:32 AM, Frank Li wrote:
> On Tue, May 21, 2024 at 03:06:17PM +0530, Basavaraj Natikar wrote:
>> On 5/10/2024 11:46 PM, Frank Li wrote:
>>> On Fri, May 10, 2024 at 01:50:48PM +0530, Basavaraj Natikar wrote:
>>>> Add support for AMD AE4DMA controller. It performs high-bandwidth
>>>> memory to memory and IO copy operation. Device commands are managed
>>>> via a circular queue of 'descriptors', each of which specifies source
>>>> and destination addresses for copying a single buffer of data.
>>>>
>>>> Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
>>>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>>>> ---
>>>>  MAINTAINERS                         |   6 +
>>>>  drivers/dma/amd/Kconfig             |   1 +
>>>>  drivers/dma/amd/Makefile            |   1 +
>>>>  drivers/dma/amd/ae4dma/Kconfig      |  13 ++
>>>>  drivers/dma/amd/ae4dma/Makefile     |  10 ++
>>>>  drivers/dma/amd/ae4dma/ae4dma-dev.c | 206 ++++++++++++++++++++++++++++
>>>>  drivers/dma/amd/ae4dma/ae4dma-pci.c | 195 ++++++++++++++++++++++++++
>>>>  drivers/dma/amd/ae4dma/ae4dma.h     |  77 +++++++++++
>>>>  drivers/dma/amd/common/amd_dma.h    |  26 ++++
>>>>  9 files changed, 535 insertions(+)
>>>>  create mode 100644 drivers/dma/amd/ae4dma/Kconfig
>>>>  create mode 100644 drivers/dma/amd/ae4dma/Makefile
>>>>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma-dev.c
>>>>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma-pci.c
>>>>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma.h
>>>>  create mode 100644 drivers/dma/amd/common/amd_dma.h
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index b190efda33ba..45f2140093b6 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -909,6 +909,12 @@ L:	linux-edac@vger.kernel.org
>>>>  S:	Supported
>>>>  F:	drivers/ras/amd/atl/*
>>>>  
>>>> +AMD AE4DMA DRIVER
>>>> +M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>>>> +L:	dmaengine@vger.kernel.org
>>>> +S:	Maintained
>>>> +F:	drivers/dma/amd/ae4dma/
>>>> +
>>>>  AMD AXI W1 DRIVER
>>>>  M:	Kris Chaplin <kris.chaplin@amd.com>
>>>>  R:	Thomas Delev <thomas.delev@amd.com>
>>>> diff --git a/drivers/dma/amd/Kconfig b/drivers/dma/amd/Kconfig
>>>> index 8246b463bcf7..8c25a3ed6b94 100644
>>>> --- a/drivers/dma/amd/Kconfig
>>>> +++ b/drivers/dma/amd/Kconfig
>>>> @@ -3,3 +3,4 @@
>>>>  # AMD DMA Drivers
>>>>  
>>>>  source "drivers/dma/amd/ptdma/Kconfig"
>>>> +source "drivers/dma/amd/ae4dma/Kconfig"
>>>> diff --git a/drivers/dma/amd/Makefile b/drivers/dma/amd/Makefile
>>>> index dd7257ba7e06..8049b06a9ff5 100644
>>>> --- a/drivers/dma/amd/Makefile
>>>> +++ b/drivers/dma/amd/Makefile
>>>> @@ -4,3 +4,4 @@
>>>>  #
>>>>  
>>>>  obj-$(CONFIG_AMD_PTDMA) += ptdma/
>>>> +obj-$(CONFIG_AMD_AE4DMA) += ae4dma/
>>>> diff --git a/drivers/dma/amd/ae4dma/Kconfig b/drivers/dma/amd/ae4dma/Kconfig
>>>> new file mode 100644
>>>> index 000000000000..cf8db4dac98d
>>>> --- /dev/null
>>>> +++ b/drivers/dma/amd/ae4dma/Kconfig
>>>> @@ -0,0 +1,13 @@
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +config AMD_AE4DMA
>>>> +	tristate  "AMD AE4DMA Engine"
>>>> +	depends on X86_64 && PCI
>>>> +	select DMA_ENGINE
>>>> +	select DMA_VIRTUAL_CHANNELS
>>>> +	help
>>>> +	  Enable support for the AMD AE4DMA controller. This controller
>>>> +	  provides DMA capabilities to perform high bandwidth memory to
>>>> +	  memory and IO copy operations. It performs DMA transfer through
>>>> +	  queue-based descriptor management. This DMA controller is intended
>>>> +	  to be used with AMD Non-Transparent Bridge devices and not for
>>>> +	  general purpose peripheral DMA.
>>>> diff --git a/drivers/dma/amd/ae4dma/Makefile b/drivers/dma/amd/ae4dma/Makefile
>>>> new file mode 100644
>>>> index 000000000000..e918f85a80ec
>>>> --- /dev/null
>>>> +++ b/drivers/dma/amd/ae4dma/Makefile
>>>> @@ -0,0 +1,10 @@
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +#
>>>> +# AMD AE4DMA driver
>>>> +#
>>>> +
>>>> +obj-$(CONFIG_AMD_AE4DMA) += ae4dma.o
>>>> +
>>>> +ae4dma-objs := ae4dma-dev.o
>>>> +
>>>> +ae4dma-$(CONFIG_PCI) += ae4dma-pci.o
>>>> diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
>>>> new file mode 100644
>>>> index 000000000000..fc33d2056af2
>>>> --- /dev/null
>>>> +++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
>>>> @@ -0,0 +1,206 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * AMD AE4DMA driver
>>>> + *
>>>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
>>>> + * All Rights Reserved.
>>>> + *
>>>> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>>>> + */
>>>> +
>>>> +#include "ae4dma.h"
>>>> +
>>>> +static unsigned int max_hw_q = 1;
>>>> +module_param(max_hw_q, uint, 0444);
>>>> +MODULE_PARM_DESC(max_hw_q, "max hw queues supported by engine (any non-zero value, default: 1)");
>>> Does it get from hardware register? you put to global variable. How about
>>> system have two difference DMA controllers, one's max_hw_q is 1, the other
>>> is 2.
>> Yes, this global value configures the default hardware register to 1. Since
>> all DMA controllers are identical, they will all have the same value set for
>> all DMA controllers. 
> Even it is same now. I still perfer put 
>
> +static const struct pci_device_id ae4_pci_table[] = {
> +	{ PCI_VDEVICE(AMD, 0x14C8), MAX_HW_Q},

The default number of configurable queues can be changed up to the maximum
supported by the hardware to achieve optimal application performance.

Applications can utilize these per-DMA controller queues by dynamically
loading and unloading drivers with the desired number of configurable
hardware queues. If we restrict always to max hardware queue, then
we can't use dynamic queue configurations for each DAM controller.

Thanks,
--
Basavaraj

> 				    ^^^^^^^^
>
> +	{ PCI_VDEVICE(AMD, 0x14DC), ...},
> +	{ PCI_VDEVICE(AMD, 0x149B), ...},
> +	/* Last entry must be zero */
> +	{ 0, }
>
> So if new design increase queue number in future. 
> You just need add one line here.
>
> Frank
>
>>>> +
>>>> +static char *ae4_error_codes[] = {
>>>> +	"",
>>>> +	"ERR 01: INVALID HEADER DW0",
>>>> +	"ERR 02: INVALID STATUS",
>>>> +	"ERR 03: INVALID LENGTH - 4 BYTE ALIGNMENT",
>>>> +	"ERR 04: INVALID SRC ADDR - 4 BYTE ALIGNMENT",
>>>> +	"ERR 05: INVALID DST ADDR - 4 BYTE ALIGNMENT",
>>>> +	"ERR 06: INVALID ALIGNMENT",
>>>> +	"ERR 07: INVALID DESCRIPTOR",
>>>> +};
>>>> +
>>>> +static void ae4_log_error(struct pt_device *d, int e)
>>>> +{
>>>> +	if (e <= 7)
>>>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", ae4_error_codes[e], e);
>>>> +	else if (e > 7 && e <= 15)
>>>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
>>>> +	else if (e > 15 && e <= 31)
>>>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
>>>> +	else if (e > 31 && e <= 63)
>>>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
>>>> +	else if (e > 63 && e <= 127)
>>>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
>>>> +	else if (e > 127 && e <= 255)
>>>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
>>>> +	else
>>>> +		dev_info(d->dev, "Unknown AE4DMA error");
>>>> +}
>>>> +
>>>> +static void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
>>>> +{
>>>> +	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
>>>> +	struct ae4dma_desc desc;
>>>> +	u8 status;
>>>> +
>>>> +	memcpy(&desc, &cmd_q->qbase[idx], sizeof(struct ae4dma_desc));
>>>> +	/* Synchronize ordering */
>>>> +	mb();
>>> does dma_wmb() enough? 
>> Sure, I will change to dma_rmb which is enough for this scenario.
>>
>>>> +	status = desc.dw1.status;
>>>> +	if (status && status != AE4_DESC_COMPLETED) {
>>>> +		cmd_q->cmd_error = desc.dw1.err_code;
>>>> +		if (cmd_q->cmd_error)
>>>> +			ae4_log_error(cmd_q->pt, cmd_q->cmd_error);
>>>> +	}
>>>> +}
>>>> +
>>>> +static void ae4_pending_work(struct work_struct *work)
>>>> +{
>>>> +	struct ae4_cmd_queue *ae4cmd_q = container_of(work, struct ae4_cmd_queue, p_work.work);
>>>> +	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
>>>> +	struct pt_cmd *cmd;
>>>> +	u32 cridx, dridx;
>>>> +
>>>> +	while (true) {
>>>> +		wait_event_interruptible(ae4cmd_q->q_w,
>>>> +					 ((atomic64_read(&ae4cmd_q->done_cnt)) <
>>>> +					   atomic64_read(&ae4cmd_q->intr_cnt)));
>>> wait_event_interruptible_timeout() ? to avoid patental deadlock.
>> A thread will be created and started for each queue initially. These threads will wait for any DMA
>> operation to complete quickly. If there are no DMA operations, the threads will remain idle, but
>> there won't be a deadlock.
>>
>>>> +
>>>> +		atomic64_inc(&ae4cmd_q->done_cnt);
>>>> +
>>>> +		mutex_lock(&ae4cmd_q->cmd_lock);
>>>> +
>>>> +		cridx = readl(cmd_q->reg_control + 0x0C);
>>>> +		dridx = atomic_read(&ae4cmd_q->dridx);
>>>> +
>>>> +		while ((dridx != cridx) && !list_empty(&ae4cmd_q->cmd)) {
>>>> +			cmd = list_first_entry(&ae4cmd_q->cmd, struct pt_cmd, entry);
>>>> +			list_del(&cmd->entry);
>>>> +
>>>> +			ae4_check_status_error(ae4cmd_q, dridx);
>>>> +			cmd->pt_cmd_callback(cmd->data, cmd->ret);
>>>> +
>>>> +			atomic64_dec(&ae4cmd_q->q_cmd_count);
>>>> +			dridx = (dridx + 1) % CMD_Q_LEN;
>>>> +			atomic_set(&ae4cmd_q->dridx, dridx);
>>>> +			/* Synchronize ordering */
>>>> +			mb();
>>>> +
>>>> +			complete_all(&ae4cmd_q->cmp);
>>>> +		}
>>>> +
>>>> +		mutex_unlock(&ae4cmd_q->cmd_lock);
>>>> +	}
>>>> +}
>>>> +
>>>> +static irqreturn_t ae4_core_irq_handler(int irq, void *data)
>>>> +{
>>>> +	struct ae4_cmd_queue *ae4cmd_q = data;
>>>> +	struct pt_cmd_queue *cmd_q;
>>>> +	struct pt_device *pt;
>>>> +	u32 status;
>>>> +
>>>> +	cmd_q = &ae4cmd_q->cmd_q;
>>>> +	pt = cmd_q->pt;
>>>> +
>>>> +	pt->total_interrupts++;
>>>> +	atomic64_inc(&ae4cmd_q->intr_cnt);
>>>> +
>>>> +	wake_up(&ae4cmd_q->q_w);
>>>> +
>>>> +	status = readl(cmd_q->reg_control + 0x14);
>>>> +	if (status & BIT(0)) {
>>>> +		status &= GENMASK(31, 1);
>>>> +		writel(status, cmd_q->reg_control + 0x14);
>>>> +	}
>>>> +
>>>> +	return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +void ae4_destroy_work(struct ae4_device *ae4)
>>>> +{
>>>> +	struct ae4_cmd_queue *ae4cmd_q;
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < ae4->cmd_q_count; i++) {
>>>> +		ae4cmd_q = &ae4->ae4cmd_q[i];
>>>> +
>>>> +		if (!ae4cmd_q->pws)
>>>> +			break;
>>>> +
>>>> +		cancel_delayed_work(&ae4cmd_q->p_work);
>>> do you need cancel_delayed_work_sync()?
>> Sure, I will change to cancel_delayed_work_sync.
>>
>>>> +		destroy_workqueue(ae4cmd_q->pws);
>>>> +	}
>>>> +}
>>>> +
>>>> +int ae4_core_init(struct ae4_device *ae4)
>>>> +{
>>>> +	struct pt_device *pt = &ae4->pt;
>>>> +	struct ae4_cmd_queue *ae4cmd_q;
>>>> +	struct device *dev = pt->dev;
>>>> +	struct pt_cmd_queue *cmd_q;
>>>> +	int i, ret = 0;
>>>> +
>>>> +	writel(max_hw_q, pt->io_regs);
>>>> +
>>>> +	for (i = 0; i < max_hw_q; i++) {
>>>> +		ae4cmd_q = &ae4->ae4cmd_q[i];
>>>> +		ae4cmd_q->id = ae4->cmd_q_count;
>>>> +		ae4->cmd_q_count++;
>>>> +
>>>> +		cmd_q = &ae4cmd_q->cmd_q;
>>>> +		cmd_q->pt = pt;
>>>> +
>>>> +		/* Preset some register values (Q size is 32byte (0x20)) */
>>>> +		cmd_q->reg_control = pt->io_regs + ((i + 1) * 0x20);
>>>> +
>>>> +		ret = devm_request_irq(dev, ae4->ae4_irq[i], ae4_core_irq_handler, 0,
>>>> +				       dev_name(pt->dev), ae4cmd_q);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>> +		cmd_q->qsize = Q_SIZE(sizeof(struct ae4dma_desc));
>>>> +
>>>> +		cmd_q->qbase = dmam_alloc_coherent(dev, cmd_q->qsize, &cmd_q->qbase_dma,
>>>> +						   GFP_KERNEL);
>>>> +		if (!cmd_q->qbase)
>>>> +			return -ENOMEM;
>>>> +	}
>>>> +
>>>> +	for (i = 0; i < ae4->cmd_q_count; i++) {
>>>> +		ae4cmd_q = &ae4->ae4cmd_q[i];
>>>> +
>>>> +		cmd_q = &ae4cmd_q->cmd_q;
>>>> +
>>>> +		/* Preset some register values (Q size is 32byte (0x20)) */
>>>> +		cmd_q->reg_control = pt->io_regs + ((i + 1) * 0x20);
>>>> +
>>>> +		/* Update the device registers with queue information. */
>>>> +		writel(CMD_Q_LEN, cmd_q->reg_control + 0x08);
>>>> +
>>>> +		cmd_q->qdma_tail = cmd_q->qbase_dma;
>>>> +		writel(lower_32_bits(cmd_q->qdma_tail), cmd_q->reg_control + 0x18);
>>>> +		writel(upper_32_bits(cmd_q->qdma_tail), cmd_q->reg_control + 0x1C);
>>>> +
>>>> +		INIT_LIST_HEAD(&ae4cmd_q->cmd);
>>>> +		init_waitqueue_head(&ae4cmd_q->q_w);
>>>> +
>>>> +		ae4cmd_q->pws = alloc_ordered_workqueue("ae4dma_%d", WQ_MEM_RECLAIM, ae4cmd_q->id);
>>> Can existed workqueue match your requirement? 
>> Separate work queues for each queue, compared to a existing workqueue, enhance performance by enabling
>> load balancing across queues, ensuring DMA command execution even under memory pressure, and
>> maintaining strict isolation between tasks in different queues.
>>
>>> Frank
>>>
>>>> +		if (!ae4cmd_q->pws) {
>>>> +			ae4_destroy_work(ae4);
>>>> +			return -ENOMEM;
>>>> +		}
>>>> +		INIT_DELAYED_WORK(&ae4cmd_q->p_work, ae4_pending_work);
>>>> +		queue_delayed_work(ae4cmd_q->pws, &ae4cmd_q->p_work,  usecs_to_jiffies(100));
>>>> +
>>>> +		init_completion(&ae4cmd_q->cmp);
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>>>> diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
>>>> new file mode 100644
>>>> index 000000000000..4cd537af757d
>>>> --- /dev/null
>>>> +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
>>>> @@ -0,0 +1,195 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * AMD AE4DMA driver
>>>> + *
>>>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
>>>> + * All Rights Reserved.
>>>> + *
>>>> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>>>> + */
>>>> +
>>>> +#include "ae4dma.h"
>>>> +
>>>> +static int ae4_get_msi_irq(struct ae4_device *ae4)
>>>> +{
>>>> +	struct pt_device *pt = &ae4->pt;
>>>> +	struct device *dev = pt->dev;
>>>> +	struct pci_dev *pdev;
>>>> +	int ret, i;
>>>> +
>>>> +	pdev = to_pci_dev(dev);
>>>> +	ret = pci_enable_msi(pdev);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
>>>> +		ae4->ae4_irq[i] = pdev->irq;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int ae4_get_msix_irqs(struct ae4_device *ae4)
>>>> +{
>>>> +	struct ae4_msix *ae4_msix = ae4->ae4_msix;
>>>> +	struct pt_device *pt = &ae4->pt;
>>>> +	struct device *dev = pt->dev;
>>>> +	struct pci_dev *pdev;
>>>> +	int v, i, ret;
>>>> +
>>>> +	pdev = to_pci_dev(dev);
>>>> +
>>>> +	for (v = 0; v < ARRAY_SIZE(ae4_msix->msix_entry); v++)
>>>> +		ae4_msix->msix_entry[v].entry = v;
>>>> +
>>>> +	ret = pci_enable_msix_range(pdev, ae4_msix->msix_entry, 1, v);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ae4_msix->msix_count = ret;
>>>> +
>>>> +	for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
>>>> +		ae4->ae4_irq[i] = ae4_msix->msix_entry[i].vector;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int ae4_get_irqs(struct ae4_device *ae4)
>>>> +{
>>>> +	struct pt_device *pt = &ae4->pt;
>>>> +	struct device *dev = pt->dev;
>>>> +	int ret;
>>>> +
>>>> +	ret = ae4_get_msix_irqs(ae4);
>>>> +	if (!ret)
>>>> +		return 0;
>>>> +
>>>> +	/* Couldn't get MSI-X vectors, try MSI */
>>>> +	dev_err(dev, "could not enable MSI-X (%d), trying MSI\n", ret);
>>>> +	ret = ae4_get_msi_irq(ae4);
>>>> +	if (!ret)
>>>> +		return 0;
>>>> +
>>>> +	/* Couldn't get MSI interrupt */
>>>> +	dev_err(dev, "could not enable MSI (%d)\n", ret);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static void ae4_free_irqs(struct ae4_device *ae4)
>>>> +{
>>>> +	struct ae4_msix *ae4_msix;
>>>> +	struct pci_dev *pdev;
>>>> +	struct pt_device *pt;
>>>> +	struct device *dev;
>>>> +	int i;
>>>> +
>>>> +	if (ae4) {
>>>> +		pt = &ae4->pt;
>>>> +		dev = pt->dev;
>>>> +		pdev = to_pci_dev(dev);
>>>> +
>>>> +		ae4_msix = ae4->ae4_msix;
>>>> +		if (ae4_msix && ae4_msix->msix_count)
>>>> +			pci_disable_msix(pdev);
>>>> +		else if (pdev->irq)
>>>> +			pci_disable_msi(pdev);
>>>> +
>>>> +		for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
>>>> +			ae4->ae4_irq[i] = 0;
>>>> +	}
>>>> +}
>>>> +
>>>> +static void ae4_deinit(struct ae4_device *ae4)
>>>> +{
>>>> +	ae4_free_irqs(ae4);
>>>> +}
>>>> +
>>>> +static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>> +{
>>>> +	struct device *dev = &pdev->dev;
>>>> +	struct ae4_device *ae4;
>>>> +	struct pt_device *pt;
>>>> +	int bar_mask;
>>>> +	int ret = 0;
>>>> +
>>>> +	ae4 = devm_kzalloc(dev, sizeof(*ae4), GFP_KERNEL);
>>>> +	if (!ae4)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	ae4->ae4_msix = devm_kzalloc(dev, sizeof(struct ae4_msix), GFP_KERNEL);
>>>> +	if (!ae4->ae4_msix)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	ret = pcim_enable_device(pdev);
>>>> +	if (ret)
>>>> +		goto ae4_error;
>>>> +
>>>> +	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
>>>> +	ret = pcim_iomap_regions(pdev, bar_mask, "ae4dma");
>>>> +	if (ret)
>>>> +		goto ae4_error;
>>>> +
>>>> +	pt = &ae4->pt;
>>>> +	pt->dev = dev;
>>>> +
>>>> +	pt->io_regs = pcim_iomap_table(pdev)[0];
>>>> +	if (!pt->io_regs) {
>>>> +		ret = -ENOMEM;
>>>> +		goto ae4_error;
>>>> +	}
>>>> +
>>>> +	ret = ae4_get_irqs(ae4);
>>>> +	if (ret)
>>>> +		goto ae4_error;
>>>> +
>>>> +	pci_set_master(pdev);
>>>> +
>>>> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
>>>> +	if (ret) {
>>>> +		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>>>> +		if (ret)
>>>> +			goto ae4_error;
>>>> +	}
>>> needn't failback to 32bit.  never return failure when bit >= 32.
>>>
>>> Detail see: 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=f7ae20f2fc4e6a5e32f43c4fa2acab3281a61c81
>>>
>>> if (support_48bit)
>>> 	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48))
>>> else
>>> 	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))
>>>
>>> you decide if support_48bit by hardware register or PID/DID
>> Sure, I will add only this line dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)).
>>
>>>
>>>> +
>>>> +	dev_set_drvdata(dev, ae4);
>>>> +
>>>> +	ret = ae4_core_init(ae4);
>>>> +	if (ret)
>>>> +		goto ae4_error;
>>>> +
>>>> +	return 0;
>>>> +
>>>> +ae4_error:
>>>> +	ae4_deinit(ae4);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static void ae4_pci_remove(struct pci_dev *pdev)
>>>> +{
>>>> +	struct ae4_device *ae4 = dev_get_drvdata(&pdev->dev);
>>>> +
>>>> +	ae4_destroy_work(ae4);
>>>> +	ae4_deinit(ae4);
>>>> +}
>>>> +
>>>> +static const struct pci_device_id ae4_pci_table[] = {
>>>> +	{ PCI_VDEVICE(AMD, 0x14C8), },
>>>> +	{ PCI_VDEVICE(AMD, 0x14DC), },
>>>> +	{ PCI_VDEVICE(AMD, 0x149B), },
>>>> +	/* Last entry must be zero */
>>>> +	{ 0, }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(pci, ae4_pci_table);
>>>> +
>>>> +static struct pci_driver ae4_pci_driver = {
>>>> +	.name = "ae4dma",
>>>> +	.id_table = ae4_pci_table,
>>>> +	.probe = ae4_pci_probe,
>>>> +	.remove = ae4_pci_remove,
>>>> +};
>>>> +
>>>> +module_pci_driver(ae4_pci_driver);
>>>> +
>>>> +MODULE_LICENSE("GPL");
>>>> +MODULE_DESCRIPTION("AMD AE4DMA driver");
>>>> diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
>>>> new file mode 100644
>>>> index 000000000000..24b1253ad570
>>>> --- /dev/null
>>>> +++ b/drivers/dma/amd/ae4dma/ae4dma.h
>>>> @@ -0,0 +1,77 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * AMD AE4DMA driver
>>>> + *
>>>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
>>>> + * All Rights Reserved.
>>>> + *
>>>> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>>>> + */
>>>> +#ifndef __AE4DMA_H__
>>>> +#define __AE4DMA_H__
>>>> +
>>>> +#include "../common/amd_dma.h"
>>>> +
>>>> +#define MAX_AE4_HW_QUEUES		16
>>>> +
>>>> +#define AE4_DESC_COMPLETED		0x3
>>>> +
>>>> +struct ae4_msix {
>>>> +	int msix_count;
>>>> +	struct msix_entry msix_entry[MAX_AE4_HW_QUEUES];
>>>> +};
>>>> +
>>>> +struct ae4_cmd_queue {
>>>> +	struct ae4_device *ae4;
>>>> +	struct pt_cmd_queue cmd_q;
>>>> +	struct list_head cmd;
>>>> +	/* protect command operations */
>>>> +	struct mutex cmd_lock;
>>>> +	struct delayed_work p_work;
>>>> +	struct workqueue_struct *pws;
>>>> +	struct completion cmp;
>>>> +	wait_queue_head_t q_w;
>>>> +	atomic64_t intr_cnt;
>>>> +	atomic64_t done_cnt;
>>>> +	atomic64_t q_cmd_count;
>>>> +	atomic_t dridx;
>>>> +	unsigned int id;
>>>> +};
>>>> +
>>>> +union dwou {
>>>> +	u32 dw0;
>>>> +	struct dword0 {
>>>> +	u8	byte0;
>>>> +	u8	byte1;
>>>> +	u16	timestamp;
>>>> +	} dws;
>>>> +};
>>>> +
>>>> +struct dword1 {
>>>> +	u8	status;
>>>> +	u8	err_code;
>>>> +	u16	desc_id;
>>>> +};
>>>> +
>>>> +struct ae4dma_desc {
>>>> +	union dwou dwouv;
>>>> +	struct dword1 dw1;
>>>> +	u32 length;
>>>> +	u32 rsvd;
>>>> +	u32 src_hi;
>>>> +	u32 src_lo;
>>>> +	u32 dst_hi;
>>>> +	u32 dst_lo;
>>>> +};
>>>> +
>>>> +struct ae4_device {
>>>> +	struct pt_device pt;
>>>> +	struct ae4_msix *ae4_msix;
>>>> +	struct ae4_cmd_queue ae4cmd_q[MAX_AE4_HW_QUEUES];
>>>> +	unsigned int ae4_irq[MAX_AE4_HW_QUEUES];
>>>> +	unsigned int cmd_q_count;
>>>> +};
>>>> +
>>>> +int ae4_core_init(struct ae4_device *ae4);
>>>> +void ae4_destroy_work(struct ae4_device *ae4);
>>>> +#endif
>>>> diff --git a/drivers/dma/amd/common/amd_dma.h b/drivers/dma/amd/common/amd_dma.h
>>>> new file mode 100644
>>>> index 000000000000..31c35b3bc94b
>>>> --- /dev/null
>>>> +++ b/drivers/dma/amd/common/amd_dma.h
>>>> @@ -0,0 +1,26 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * AMD DMA Driver common
>>>> + *
>>>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
>>>> + * All Rights Reserved.
>>>> + *
>>>> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>>>> + */
>>>> +
>>>> +#ifndef AMD_DMA_H
>>>> +#define AMD_DMA_H
>>>> +
>>>> +#include <linux/device.h>
>>>> +#include <linux/dmaengine.h>
>>>> +#include <linux/pci.h>
>>>> +#include <linux/spinlock.h>
>>>> +#include <linux/mutex.h>
>>>> +#include <linux/list.h>
>>>> +#include <linux/wait.h>
>>>> +#include <linux/dmapool.h>
>>> order by alphabet
>> Sure, I will change it accordingly.
>>
>> Thanks,
>> --
>> Basavaraj
>>
>>>> +
>>>> +#include "../ptdma/ptdma.h"
>>>> +#include "../../virt-dma.h"
>>>> +
>>>> +#endif
>>>> -- 
>>>> 2.25.1
>>>>


