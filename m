Return-Path: <dmaengine+bounces-8650-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNqmBSQSgGli2QIAu9opvQ
	(envelope-from <dmaengine+bounces-8650-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 03:55:32 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BA8C7F0E
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 03:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10CB230045BC
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 02:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DC621D3D2;
	Mon,  2 Feb 2026 02:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R7UidxR8"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C371B1EA7CE;
	Mon,  2 Feb 2026 02:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770000929; cv=fail; b=iTILxTOnHD7mFV9ncTl+8WdZed8lmse0IqoWRunWKczZ15EgjfdDqdqrfNSrukrJZwNx3nI63oDGjm5ethqB8+P1uoM8NaCQImnxnPA+Bebo1S1iYcb3X0IeDBXQ4ZpAq3Ed/6SkWU4R1G43e6ta+UaI3PSlOqihcF5w393zG4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770000929; c=relaxed/simple;
	bh=XFTIuf3Gdtz3L5JfpvZoTEmelMK1rTBvS4iEYbASw/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uRVzQOSAreVJUb6HZt1+hrF2XI8nsBkxldqdhLdHs8LmEYfSVu7r1TnzCWALj9rVhIM8eh5ZfXQYF/6cSaJvHmkcFHZ8+lWdyF2KkHkQkmoCjpT2YkK16VL8j3zYvmbpHZwpydQDDozZHlOHPJL/Irz0dZTM3ZP0FqR20ZyLM/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R7UidxR8; arc=fail smtp.client-ip=52.101.46.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/7Dqo+MnSY+tUQcqXtrk5IgXaRRQBLjOoQxpIBP/oxgsuYIirdR3j+czh8oQH1kGxxFieZIshh0Ls/tr4Joi+VgtY5Xr65yJ1VO8mihRYXhFqwXOPZW+Y+g/Wmg8GeIflvKNYkaBy2707ycxJ9fmVa95hYaQr9gW1Ho1nKozfG5T/qXbQf0fzDto78zRYZb+wi5L4YmrDiZ5b7QZs2T4i5Lc9GQoiOyv00vZS6R8VOGDAvkNlXwua9qQprrx6q+NGN25pC8ULVSx8E1gHVrn3/lhrR6TrDVKgV1cW0zAeFUJeA/1iHfn+c0yrrEUezYyTOUjxTjUGdxId58NXQnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSRch2iGYC4i1cKJURW19ji/I3Jqys1iXhi0mcf0/cw=;
 b=eZ6Te6ZKaniS+lGUxRAPa0cwCJ52xll4TE3hTgRxaBpC4JeZ/CLrsGGFoaOZxTVqjUfJjmZK2CqoO77sMj6xPD+qmgJiQJK3KpKxKgu+C/UNpdE0gx4dnO1fZRTsnNDa2+xVbIop7kdgB5u8ZayR9QT4tIUBfmhOC5secan+ASZuslj9w85xyuJljNSn6aJPd003JwVh4Qq13qPfvGPYfb2iqyo3W2IqXSDIy5xITiLkjKQji1zwrb0V0eFvQbQLlVrlBaW7Y9EQBb5bey45xohcYXErukGiB+fBzcgq/GYYZJzEI5yQ0Pw12Bse3CI9qYNdFAhtP+IW7gHtwZLTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSRch2iGYC4i1cKJURW19ji/I3Jqys1iXhi0mcf0/cw=;
 b=R7UidxR85xfeJLVlGZ+triHNGpzFHiouhJSfGPzFJsG8foP98+uS6Z991KGwxEbIRRxhreTcyCgEJMlUzYUdzMfBuOdNQ16MKJSSCgI/ny9xHPf/6HvLhjfgi6ahW6suyckx22ryqdCuzMImLVdkHdCFKrJuCaWYAUzuaXSptXJbzSXV+XONkQzA7V3PUX2znnXoAixsscXVuBswsinrRhM9EIvJ6qc6kk+nMU2/B0lTPzDHWhNzvUWioiMDX02xirc49En5u/OWB8PVsaxdLgfrTyMBDD/v1LJ/OSr/BFt/oJhyHZeCN/relhsTYEYzsdJBJwnGDVHgLZWHIN6AXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by LV8PR12MB9357.namprd12.prod.outlook.com (2603:10b6:408:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 02:55:25 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9564.007; Mon, 2 Feb 2026
 02:55:24 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: dmaengine@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
 Vinod Koul <vkoul@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] dmaengine: tegra210-adma: use platform to ioremap
Date: Mon, 02 Feb 2026 11:55:21 +0900
Message-ID: <5964681.DvuYhMxLoT@senjougahara>
In-Reply-To: <20260119232557.10818-1-rosenp@gmail.com>
References: <20260119232557.10818-1-rosenp@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCPR01CA0179.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::14) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|LV8PR12MB9357:EE_
X-MS-Office365-Filtering-Correlation-Id: e306bee1-da41-4561-de7d-08de6206835f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHdUWVlVY2FUSHJvUnZWYTFYQUhqVTNFaXE0RmpScHFHdG14UVN2VFRucTBz?=
 =?utf-8?B?YVZUQ1pHdHpxVHZ2bzRldkFhWmNiNkpPSHJxbDZ2a2Q1cnFkKzhpbG9URUVQ?=
 =?utf-8?B?L0w5eXlWZTdSZHUyODRvWkNQTTZBNjVSZG5wK0k5bzNEK0QzOFpXdk5wL2xj?=
 =?utf-8?B?YkgzTTVhc1IvVUsxQ0MwczBRcm9mK2pYQ3BEMjJSMGpPaVFBeGhoOUZpYXl5?=
 =?utf-8?B?eDhSYU5yM2MvckpjcU1ydkNtMGRLZ0tBdzVGdzVGRDdFVVBtUDJ4Tm0zaWZF?=
 =?utf-8?B?OTEzUDlIQkQ0VkE1OVdxRGlkMHJPY1hSaEgvRGM1N1FneVZQTytPbitaUkRs?=
 =?utf-8?B?SWlLZGd3WXdXWXN3eVBFNGhLZnhGVHdBcnVRZUN5MzB0U2FiSzlONmp5V2xq?=
 =?utf-8?B?K2hFWFRkV0poWGFqa0pXS1IzSlF4RDYzcU1RSlByRlIwQ0owZ1hCQ0RiZXIz?=
 =?utf-8?B?cTRNRUlLOHdrSXVvc3R3RW1lakhqU1p1RUNlQ0VydDJoK0JRZ3lDOWZkWUpW?=
 =?utf-8?B?c0Q5UkpCOFdEZlRUazlrVFE5Z0o2Q0NNQzhmZGFqM3plZ1FuOWMvL3ludEp3?=
 =?utf-8?B?MHVDcDF1NFFwdC9yaGN1WXRhWm95MWJnZDVwU3VVbHRPN1dvR2pyL0RlZ2tO?=
 =?utf-8?B?TFFqaFVvMUsra2hMdmhrMS9XcHR0dmJFYTFDZkY1dktaOUl1Y1hJK2d4b0pW?=
 =?utf-8?B?aS9xQ0h4UXQ0WkRMTmgxbkpxZGxuRWtCNjl3NlpDUFJGUjBxaGlqOWVldEI4?=
 =?utf-8?B?Um9wa2wvaWxxWUlIVUlFSFJGUU84aHBqOFY1YnI4aDVjdEZCMlFMV1dKaEEy?=
 =?utf-8?B?a25qUEhmeURZYW45MittalZaT25oNzI4RDN2dWhFUWsydjFFaWhNWE5iazJP?=
 =?utf-8?B?T1BMRFVpOFVBZ1MyQTI4Z3ZMOGxBS3VRNmRwdjkvekh2V3FIN0M4VEhlc1Jl?=
 =?utf-8?B?UzBOMXN5VUhlNzRjY0dWR05YMmI4RDByYm9aUFA4U0lBSFI3WERCU24zUzhS?=
 =?utf-8?B?aFZaZDNjOFcrbkpVYVFrNUNDUUdTTHJZTXczc3ZiNEJFeDVEcTFmMG9vK3po?=
 =?utf-8?B?dG95ZFp5dGFrajNlUDZxMDV0YktrbE94bjVsejhlcEFNZFNYZzJtbHFWNXVo?=
 =?utf-8?B?U3ZmTm1pS0ZOUjNKZndTbXRkelluVlB6S0EvS3VrY1RaRjVqaHpKdElFVndW?=
 =?utf-8?B?bTlWakFoaTdpV0Jmc2cydm1iVDN0T1BrT21MWDc2ZEZBK1hhaGlhZVE2TGxj?=
 =?utf-8?B?NDVJQkF2QzJjV3NtTnlpcmRrZG5OQVBWZzVUVHRwQjl4b0J2c3FLRkNBTkg4?=
 =?utf-8?B?RE9KNTVBcVFlYUVuUUkrRFNTKzlNaFUyR280WWhtT1N1OW9DQ2pBUXpCUVhL?=
 =?utf-8?B?QWsrc3J4QXhldUtRa1ROSXZGSnprY1RUMHVOR0hmelY2aDZrT2ROTUUvcXYx?=
 =?utf-8?B?UE1YYTJYd2ZHR1dmRDVrcERaWWd4VGtTK3psanFBVzBMUGtxUlV4VHJNWmJv?=
 =?utf-8?B?YmZBcEt2TDRiS25wYk9GTjVwMHFsQWNwbUE5aFVXODZQRmw5RTRPZ2gvY2pm?=
 =?utf-8?B?ZVZQV0tKMTNGVUk5aHo0aDlrZWhFSFRHR2hsTU9QYzJMUzlsMm9pQkpIeTlK?=
 =?utf-8?B?WGNtaWFHeTBPNDdCQTZ6L3VqTWRnNkdKYlZhN2VXRFBVWjFNZGhUVFI2NmVu?=
 =?utf-8?B?MmFjaFVUcE5RTUQ1T3ZXUzFnN016VGoyN1FDUkMydmxCT3ZPVkwzRjVaZldM?=
 =?utf-8?B?Nmh1U0toK09XVmdXK28yN1lKZnVlZnoxb0FnQU92QndNVlhETGZ3YzhRTmM4?=
 =?utf-8?B?M2FzU3hoRU5sZFByazVGNWJWamZNby8vZlpqaTRzcGE4bWJlV1U2TnNCMDM3?=
 =?utf-8?B?QUpmM1V1aWFlQzkxcXFtS3JaWjhMY1FkYkxDWnI5OHZnRVE2RlU3ODh2ZFlW?=
 =?utf-8?B?cG9hdkl1cU1JSS9HYy9zcER4dkZ5QWRKVmpZZlVtNkRPM1hmTkxhTjF4enlm?=
 =?utf-8?B?K2xoQ0ZXeU9MZXdULzE1Znp3dEgxRUJZTXpPYmY3c2dzZld3dGNQTE1aTHp5?=
 =?utf-8?B?L1RMOFhqaDU0ckFDbHZUM2IxTHpNOWpRZ2Rxb0FQd2xOc2hhWFF2UjVTRHhS?=
 =?utf-8?Q?VvVI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1FJdEJucjhBT005dS9wZDFrK2ZuN0h3UzRkNlE2WC9pZTRKd0JIK1BkTmhV?=
 =?utf-8?B?NTJYWDZkRVg4bHhSVzQzL3UvRFlldHM2aE1NdFdtZ0c4eVRXTmdab1VZaWlz?=
 =?utf-8?B?cFd0U3dLTDFjR3JkNVNQVEpTVWxzNU1nSE1SMHpISjdldnVLY1RGTnZFcFhh?=
 =?utf-8?B?QVBNak0yemt1cEU5clM2b1lxSWo4N1pwb0ZYVlVucFd6TTZsb2dmVUJCZUda?=
 =?utf-8?B?bkxIcGFvY0VlTmxMYWl1MnJndFRnRUlMdDhLbHdBUnAxZHlkMWFmSnBJMVFM?=
 =?utf-8?B?MGdIL2gyRm0vbmpreUt5M2ovcGlNdnZFQnVlNkFrcklNMlcraC9YRysxR1li?=
 =?utf-8?B?OWtFQVJTZ21BZTcrMWdxVlNuRkZETFMrdnlaUmZNRmd2TEJxZzB6WGtNSjRG?=
 =?utf-8?B?aWZjcFBUTkdIOVdOd3JMeVI2SUtHMGZQQVpLTWJUVFl3cTN3dVBoZEJjQW9O?=
 =?utf-8?B?andyWEZwbUhERjFlcGl4QXVJbkUvdmpUaWFZOVZWMzhwZmo0RmdwL3BJakly?=
 =?utf-8?B?Vy9hL1BudzY1SFBKM3U4eTRWMUdqVnRTTHZQMG85cE5lRjk3bmpVL05RQXBO?=
 =?utf-8?B?UjRMNGRJYjlNSkxqWlIrQ2poTU01NkUrbHI0dldlSk1Ea216WFR4S2dUNnVr?=
 =?utf-8?B?OVlGQWJicUxNam1VU0Q4Z3ZNckhRR1A4QWZQM0lqRTBtZlNPSkQySzZVNlZW?=
 =?utf-8?B?QUNvU1FLU0g5djBaZll1MUIwY3c0cHpTdnUvSExFYnhqbWRNZ2plb1d3MlZQ?=
 =?utf-8?B?cWlSNUpkcDJtZ3pSWnpzSHNOelBCVmJ4UWRVc284Qy9EcmJZYWVFN1ByL3JT?=
 =?utf-8?B?NFBKMGVyTzVOek0wckkrVkVYanFJK1lUcEVDcytVSUNMK2ZKdTRsYm40Wkx1?=
 =?utf-8?B?TGIzZGIzNWU1cmV3YXhjTE9Fc0VUTDNMREY5VjR2OHQ2Um5tdTZnYzFiTWxj?=
 =?utf-8?B?dVFabFBTWDEyb0diZzFNZk9ySENHRE1qbGwxTE5VdTRGN1cwMldUVUkvTWZ4?=
 =?utf-8?B?ZEhiV0w0YVp3YmJEVTRSTHUzRmRtalAySkhrVHQxNjFIbGR4WmVRMlR3ZFYr?=
 =?utf-8?B?VXhmK0haQ0F3aFdtUkJKUjhoa0ZCL2Fyc0dZdDEyZFBKNmYweXZjUUFHZlRE?=
 =?utf-8?B?b05OYnBsWmJwMmM4U3hUSkkxRlQrdGdSV3VQNTFMU1BRY3VEUzJjTXhXM3lZ?=
 =?utf-8?B?VzdpSEJVcm9JSHo0S3JiSi9sdUtSMnRYcmJDTzZ4TXpmbjEvNllweGtOeHFQ?=
 =?utf-8?B?NFo5ZmxKT0pSZFBUcDhMb2Z5dUR4L2NhbTlJMkVwWHNpLzZPbmdkbHFhNm9M?=
 =?utf-8?B?eG1IdThyTXBVQ0NoMm9XUWRRR3orNWpnWmZOZm1qWGJhTjYycnFjeXE2WkZs?=
 =?utf-8?B?NzZvQWMzNVhONC9HeXRPRnVaN2pEeVVEMS8vKyt2ZmJneXhJb25ZbGNFU0dB?=
 =?utf-8?B?V0FvK21tZ1J2RHNtWTRuOXR0cDJZY0FkemF6VTVBZHBkZDFTM2Q3eWE4QUZ1?=
 =?utf-8?B?a1lsY05hbGh5VElIUWF4RHlyTjV5REc3SHB3UllhWGtRZ3lGOVUrY2t2eGsx?=
 =?utf-8?B?NnN1UFVuSmJQVFQ5YW1UbzJ0TVJVc2ZIRVlPQ1V1cnQ0cnJQb1FuTGhjSTdh?=
 =?utf-8?B?eUF4ajFNQjR3MVlXNGwxRkcvZE1RSHlaMUF4OE51TmgxUFB6MnhBTERJSVcw?=
 =?utf-8?B?bUxkN3RlTllEN3p6WStVcnBTbDEzVmJSeVlLaHk3SitudmJIRHVjSHQ2Mlhp?=
 =?utf-8?B?N1NTM29sUDZ4Uzc3c1dzdFhjR2hEVXB2L3dhNmFoeWlGK3R6SFZHaWhWVWc1?=
 =?utf-8?B?Z1czZWk4SmNzTW9EVUQ3UHh4dmtod2RJdTl2U29SYzExL3Z1ZC8yeHNWaWtQ?=
 =?utf-8?B?VHhVR2VPcGpqY1JzUmM3VHVwczRqTWNKMGlHVmRTWnhpMm1zNnBFR0JaK3lM?=
 =?utf-8?B?K0s3cUZEZUczYzZpeXNIL1E0a25yKzYwbnp6dVlSZVNDOG91R2UrUzdNR2h3?=
 =?utf-8?B?UFU0TEpJVWpsR2FmbUtoZUMvM2ljZ2FjWEVscVo1QW1BNTRTTWdlT1JXbXVT?=
 =?utf-8?B?RGJCNVlhVTBtUkl0QmN2em1nNy9FdHc3OEd0bkRXTHVuWk1PQzFqM25WcTZM?=
 =?utf-8?B?WlBuRHlsQWtMa1oxb0J0bWFyVld6Mkhva2cwOElYN1pBeHBnZEUxVTcxZFdR?=
 =?utf-8?B?dHdNcWw2N0RYS0szdERMRlVqWmUwTm9mRDBvTGVTWDlzNTVvd3Jjd0xhckxD?=
 =?utf-8?B?ZFVUajRTd2NUeStRbjhhL05vZGpxTWNBT3grVXg2MnVRcXNZN0dSTkg3ZW93?=
 =?utf-8?B?bmtwbGh4TkJ5ZHMxeVNrek1nam5tZXBWazJrVjJkVmdYLzFEK1hVVEJSdldx?=
 =?utf-8?Q?LGarxB45MwpRBu7An1ug0Qn7IBsRR7TPdICY2GhcRCnPf?=
X-MS-Exchange-AntiSpam-MessageData-1: OXFEMZnCGcGizQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e306bee1-da41-4561-de7d-08de6206835f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 02:55:24.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouGOuJ+ZxgaEIc4lPj3Qb4Dng9H+xrNoSa75Cb8zcIrB2/pDFJ/XxaskFuCSzCq6eGD+Mu8FxWWxgGaqQH86LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9357
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8650-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,gmail.com,vger.kernel.org];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51BA8C7F0E
X-Rspamd-Action: no action

On Tuesday, January 20, 2026 8:25=E2=80=AFAM Rosen Penev wrote:
> Simplify the code slightly with devm_platform_ioremap_resource.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
> v2: reword commit message
>  drivers/dma/tegra210-adma.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 215bfef37ec6..5353fbb3d995 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -1073,14 +1073,9 @@ static int tegra_adma_probe(struct platform_device=
 *pdev)
>  		}
>  	} else {
>  		/* If no 'page' property found, then reg DT binding would be legacy */
> -		res_base =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -		if (res_base) {
> -			tdma->base_addr =3D devm_ioremap_resource(&pdev->dev, res_base);
> -			if (IS_ERR(tdma->base_addr))
> -				return PTR_ERR(tdma->base_addr);
> -		} else {
> -			return -ENODEV;
> -		}
> +		tdma->base_addr =3D devm_platform_ioremap_resource(pdev, 0);
> +		if (IS_ERR(tdma->base_addr))
> +			return PTR_ERR(tdma->base_addr);
>=20
>  		tdma->ch_base_addr =3D tdma->base_addr + cdata->ch_base_offset;
>  	}
> --
> 2.52.0
>=20
>=20

The commit subject "use platform to remap" doesn't make much sense. I'd jus=
t say e.g. "use devm_platform_ioremap_resource".

With that,

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>



