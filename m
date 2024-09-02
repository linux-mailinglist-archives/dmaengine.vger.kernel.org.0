Return-Path: <dmaengine+bounces-3059-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8EC96800D
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2024 09:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720991F21173
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2024 07:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C040B1714CF;
	Mon,  2 Sep 2024 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KV1WIcLs"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1850A17A93C
	for <dmaengine@vger.kernel.org>; Mon,  2 Sep 2024 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260873; cv=fail; b=ALeIKhDlONoTXNpxtzOZgQZji0tUznosrx8phgw96fV4670/M7mOTFY4Z1Un4MRiwkttBck0vItlJDrL1mW55hO3gDE4uBFFoBRs3I8zojqaqUHpBNwe+Le/B4r91eKsivEh5y044rnwahuHqMDIxCdYw7QvCH2pLyTTpqfDxgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260873; c=relaxed/simple;
	bh=UqJbUs5KJU3CqmUWn2tB3sHsoMmyraojoZ+gjU7Dvkc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OGaCNuGvW4oAxEMFcTRpovHa39LGLqp/qRoNWfUaekls/r+OQcDAi6TM3mzx9UhWJ33c0v1aGMNr5I904bWNddoKRoqQ2a5RqPoymMFZM9Oo8YZM/5NSfESk9P05Boq1dhvWuycVUNvJsqsYuyShFuHyi+I6xHVDf27Vdf/qlXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KV1WIcLs; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htudya5zplRLsCDPmyi7p85x0rxQGlz7QGYwQOuHFZskdcgbkypCWD3h27HEAhiMYAT8zjQfkXka6ob2Q5zKVSBEfGZfC45bR34MIW7IczbfFtZw0B/VubgHOCG3M0kL4KRc1ocdEp2cB+gUM6d2H3/nAh89nZ+iBJdWOSCiArrv6rviDG0XWrxKfTiXAR590B9trgvghseMOO7zKPDOEQKAoIANjCbTPehnsRp/4HYhui7l5PWvVe6kTd8PAzmPWXhP6UfSLyow+cL8D+E7lPrB6yG9VWZwbfQHtt41P+cnmCaxh7ko79XtgOsHWDHCsNzOptY96BfHfT/RkLZ6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqufukqYnysH6gEdzSN++PwgHDT4oFsHiDSuWWvwAuA=;
 b=r87cH92pgi/uTnH6wsGaWcWTDSRhnmyFRsBmbK72DgZf29vfqsvCH6s7/nSD5zziWu/k4TbUyfP7NAe0Y+QgbjCmdpJaXi47CqOQmRtyuoKRlRxObhITfJnkq1s0d5jnc55gvpzURxR4luNkWQl0Ovq5KOF0oZFrcZehRrky8YFD8IE3haaros9Puh3lqOsdu+dEC+t0DHf/3mEfS54LYttlmmc69YuIDKWBUXcf+S0jbUaC01g2OvrRo/lxXH0frnoEOAgEpl98Hf7qfHo88xNtkCIuXNAcS3xqu5RrruFtLQJ5qXmum+EUdmda41eaInI5lKNxm7BS8qTIdo5m4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqufukqYnysH6gEdzSN++PwgHDT4oFsHiDSuWWvwAuA=;
 b=KV1WIcLs6DJeko6uoAUREARe+nP1ux5RMqX0TSx3A038FFoYUS+KeRPVfaOmlkjMdR9A+uPi+D8yxxod2amATHhrDhV3VdHIki3YP478yqIEPt1MHCFWTO8zpHH5YSM++mW/n2jsdV1nzpx/FYcsr7jGV/XWJmW+Lh70bhyhwa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 07:07:49 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%7]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 07:07:49 +0000
Message-ID: <9a813b70-4e24-4001-af4f-cbcf92582cb0@amd.com>
Date: Mon, 2 Sep 2024 12:37:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] dmaengine: ptdma: Move common functions to common
 code
To: Vinod Koul <vkoul@kernel.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: dmaengine@vger.kernel.org, Raju.Rangoju@amd.com, Frank.li@nxp.com,
 helgaas@kernel.org, pstanner@redhat.com
References: <20240708144500.1523651-1-Basavaraj.Natikar@amd.com>
 <20240708144500.1523651-4-Basavaraj.Natikar@amd.com> <Zs8jpVrnBuyr/wiQ@vaman>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <Zs8jpVrnBuyr/wiQ@vaman>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0253.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::7) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f40800-39b4-4f0a-2dcc-08dccb1df425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGxkaCtoWFkzWEZJa0xRQVFUVUNsbVZkREJIbTlVM3hoYkM3U0I0YWdGODI5?=
 =?utf-8?B?M21rUnE2cGg4dEM2aENhTmdkS3FBYzhDaXVtYndia0FTaVIyWTZ6U1lzQmVV?=
 =?utf-8?B?bGtUYVJSL1hJb2dsRnVaRHhhS245RkJRSzZKT1BycjlHMUQ3a3V5Y2dDc1or?=
 =?utf-8?B?YWNoQm1zcUdTcU5FY2RubDRaUkZwS1pXazNnZzlYcUltT09aaHphV0g3VCt0?=
 =?utf-8?B?SzJacGZ5ZC8xZ1VrSFJzUEoyV0xhVjI2ZGZnanU3K1NPclRzaVlkUzdVZFJB?=
 =?utf-8?B?Q2FBQ0J5TEhDTENwaUVVNjZ3Y1JPUDhDQzN4UmdJQjBKTGtVM0V3VnJSamNM?=
 =?utf-8?B?ckE3QWM3ZG0vTm1pbFdnOVFFUlJubE9ycDVlWkFpQndpWHUyekI3SFI2WGJz?=
 =?utf-8?B?ZXVXTzJBT2pDUWZTTXhGQ3hOaG9GOVhMbS84dmJTV0JIcDlxQ3hHRlZ6b2dY?=
 =?utf-8?B?VTg1dW16aEVkenBwamFnaHVaS0liY1lOKy8zamU2U1RPYzltOGZrM29NaWRW?=
 =?utf-8?B?b0x6cnhJQnUwV29PWnJqcFhCZktJOUhUTHZab0c0a3VBUkFySjl0aWxTU2Z5?=
 =?utf-8?B?L2I5TzRtekl2RFV6NTNjQ2JmbE5oWVpnd1lkV0hHeE53T1hGM1gwRWRjdzhp?=
 =?utf-8?B?azc4OWZYSkJjNHJ6eU5OMWtCUlV3bWhPRmZha0lYVjFoV1cxeTY0amhNKzlS?=
 =?utf-8?B?aHpZUVRyeDJJYktNQm54SnlyMGxoc2tmWDNNSkVvdzV0b200ZFFJRUJJenBC?=
 =?utf-8?B?eFRTdFFtMmdlOVBHWDJLYngzZW9XZjlKelhTUS9EK3ZJTlpVbm1hRFA3MUdO?=
 =?utf-8?B?UlBSckVpeVpxRE94VmpudkMyanV5T1NsOWQ4cDJCOC9wckpLN2ZVelZMWG1G?=
 =?utf-8?B?TFFiSkcySDduMGV0RXhyVHF2Mmg3ZWowOE5iMm9NREJqNytLQm1ielpHaG41?=
 =?utf-8?B?Nys0N2hWdnh2b0xBWjlnZmliN2NoOU5MZWwzd2h0Z3pBd3M0MXVwekNYSGlu?=
 =?utf-8?B?VVUwSERMNHdEYnQ2b0YrSDFGQ3ZRdlFHdm0vLzV3NHZNOFNBOS9aZXdZZWI2?=
 =?utf-8?B?dTF6ZmlGRWg3VHdhOVNMMGJ0clRrSTFwMGNhQTFiTUtvdktIci9uakp0WWZi?=
 =?utf-8?B?RTRFb01sb2VyMll1RXhtODg3UmpYc291VTVlS0VPQXdpZklGViszc1NFdVBn?=
 =?utf-8?B?RkpyRkZpNDZWUlk0S2V2QkZtZER0S0ZCUzl4MHVYUU5KbjdEVitNRzFncjNj?=
 =?utf-8?B?UU9MY3lFY1BaVXNmZnBxcHE5dnQ5TE9wbFZsZWF0OTVCMmhBc3k3V0NHd3FD?=
 =?utf-8?B?NDBpQjFEVE9rTE9iaDBiejNrdnhMRDRhekZiMkp3UUIwU2tKYmhGbXg1R3FH?=
 =?utf-8?B?eVJZRU93OUFjOFlGYnVQcTRnMVZMWFZ0N0J3Tlo1VnpZNDl2TGpsY3ByOGdU?=
 =?utf-8?B?WEk2WEYxMWVwcE9RRlA1QTgrN1VueDZTakY5ZXhXQmMvdW5pWHhqK0w5alNp?=
 =?utf-8?B?Q2VJeVlUNWoxVHovZHZkMkRoWXBlTVY5WlNCdXcvYWdXUnQ2eUl1R3JRRHps?=
 =?utf-8?B?ZmdIcXErQjY3UUQ2R01UZEJnVEFnRWVWdUFFbU50ZmFqTFhTUEhhL2FXS2pj?=
 =?utf-8?B?VGtidUZRWUlIcGJJRDVOcTNHbEJ2ZVFNaW1PWEtTWXZHNDRkNnM5QXJqeUkv?=
 =?utf-8?B?MERSTWFLaTMrbXdEOFVQbEhaSFFqcE9GOFlvNFA5bld4VmhjYWdMZFNwWlRo?=
 =?utf-8?B?U1RoamM5Uzc3SktsVmI4NnY4Q0ViSnVYb3RDYTFHaW44NUl4YjdCcURMZG9m?=
 =?utf-8?B?eksreGp6RVBSSEFTT0FqUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEdLNHBzWnVYMDRSb0plVXZBU0IxK2Fra0w0YVJXNW4yaDlkSGxQOGFrcnFj?=
 =?utf-8?B?clE2WlpobFpZejViV2xnNWxvRTQ5eDNLNGk3WHY0aEtWSjZpcjUvOEpjTEVT?=
 =?utf-8?B?emZJLzRJRUVQbVg3bFpHakY3THR4UVJ1WW5KcktqWnV0bHF4ZWdCVHJpRFh1?=
 =?utf-8?B?ZzdiNHpCc3JWMTJZc0E2L1FkYTRRQi9TS2JiaFEyU1BwdkRpMXYzMmo5ZXlq?=
 =?utf-8?B?WUZlM2ZkbE5ncGtobjM2d2EwaEJOQ3NsaElwZHJrRzVoVk1VaDk5b2hOUGJE?=
 =?utf-8?B?bGtJUFRQOWpyWHQ2QjBYdVFUVHFCSmVFc0ZsRWw0ckREOVM4RDFHUGFRK0VQ?=
 =?utf-8?B?MHljb2JGVFEwS2ZDZmpaMlJpY01RYWk1WGRVdFpEcjBsV0lRMkJTTWhTUVBm?=
 =?utf-8?B?MFROSHBNTkNlSDQzSVlraUJFeXhjRGtoRFA4cmhFalMzb2hjVGMrL0ZyWGl4?=
 =?utf-8?B?dFhidkVEZGc0ZmVFcnh3SjNwUUFkZUpBb3M4aGxkVEdhUnZBYWRIaFVCcUVR?=
 =?utf-8?B?eGNtaHFCVlZ5dkFnOHNnUjZRK25ac1diS1FoZkFnaWcwd0w5THZiaiszb2pz?=
 =?utf-8?B?NngwZGdEaG51dS9tWnJHakNyMlNyOE5tUXFkSG5YKzMxLzJDRmFIYUZaWFRJ?=
 =?utf-8?B?eXJ6K0IrSU16M0J3Sm80ejhGK1cya3JMQ2RFZHB4eXdTUElUQ2RJcWdlbmpq?=
 =?utf-8?B?MVA0dVV3YnoxTThuckl6MnN5MXJaK29HYVgyV2dSZUxsT0FtKzBjbDdhMERJ?=
 =?utf-8?B?SnhBSXNZTCtaNWFaRVB5ajl3cHZyOHlNd0xDdkRvanpZMHFWaTAxa0FlOTBH?=
 =?utf-8?B?Q1p0THkrbmlMSG82TC9udFMzTVBBckFkMkdwTHVVN3UwMjJuUDZMUzd0NjdB?=
 =?utf-8?B?bmR3U1FvM3MwK0VUYnNMT2plNWUzZ1psOW5wMFc5SWNKZmZGdWxmUklsalh2?=
 =?utf-8?B?eDZaZFZlQXhLRGVORUdVZ2tibWNnTVA3V3l2d2ppVmpTQmhSUXh3c0V6YVJN?=
 =?utf-8?B?c0MzaVhUekdvN2hyWjRMclNVZzNTUm9BNnE2Umk3WGoxM28xTFN0YWg4eE05?=
 =?utf-8?B?UEh4U3gwZXptOGRiWUFVSy9vblY5dWRhbm8zdjVoWHY5ZTEyS1NBaHlDcFV0?=
 =?utf-8?B?cklPbTN4Y3A4VHAwcnlPSVZsamZ3MnArOFdHSWRlYmo2NDJOaTV2SXZ5alNr?=
 =?utf-8?B?aUxoZDQwR3VWeStKbDNwS291SWdndm1RbTkvRlNpalBOODFSd2hGMU5JWkd4?=
 =?utf-8?B?T3BnUU5ET0NNYlJvb3ZmQ2toNnhlaE1nMWF3VHNUWUFtUnFQbjVQMzB5Skdo?=
 =?utf-8?B?L1d0ZENFWTd6am12aFJibWxCai8zVldPaHpWbFBnZlNYM0txTHgvb0dRKzRp?=
 =?utf-8?B?ZUh3SkNTQXRqWnB0UEVoT1lzTkl4d3hYSVZMYjdSV2ZFTzlFWnRLOHJaK1h3?=
 =?utf-8?B?RXAxWXV5ZTNhS3p5ckdCTll3V3lacHZCSFhVaDBqanc4N0puc3o2ZHdTbzh0?=
 =?utf-8?B?L3pPaElmU09GR1JPUnk1VmlzR3dvdTJ5UGFyS1MrL3kzc1RicGMvNlRRTWo3?=
 =?utf-8?B?VFRMdXp1U3JrK1BkTUF3RTVJbmY0cUUrdFE0c01xZ0pHcjNFY3NRb29pUFcz?=
 =?utf-8?B?TkV2SDBwdGtEaWxiYkNKRVNiUFp0L2k3M2ZNTk5qblRJcHBrZU1GUDF6SzVJ?=
 =?utf-8?B?bWw5dmhqVHFBYjBwZEtJMEN4enNWdDFNSlJoRTFZQm1BVVVNcUNBYTVEc0lF?=
 =?utf-8?B?dUF5RUJxVUFoMUw3ZVhRMVZQM2NiNXhZT3p2M3FjVG81K25kdEl4bkYrbFVy?=
 =?utf-8?B?bWpBSWZaUFY0Z2hrQ0JaTVJKMG4yNXZrN0VmVGRtcVhEaFd4MEpzZitXUkdO?=
 =?utf-8?B?dEh1VGk0NkpicUhsWHRyTmN4ZjdJYVZjcnkxSjIzKzNPaFBmTXVIY1IyeGMr?=
 =?utf-8?B?Y2JLVm80LzE3RU1obkFXd09yVll2dEhtOThpRzlRZUlHYUx2M05wK3krRzRQ?=
 =?utf-8?B?ZXM0VHdQS2FIVXVkTTlPNm1ic3J6OEhXeFVHU0xkMFdsTjVsWGE3Nmhwcy8x?=
 =?utf-8?B?bVh4bVd1VCtJRFMwRzZOanFUb29WazFLeFYyZmRTejJQVU83SURzMFBQUkdM?=
 =?utf-8?Q?97pdECWEiIWJU13Q4gxUfyln2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f40800-39b4-4f0a-2dcc-08dccb1df425
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 07:07:49.3928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIKOBmNZenoadtpLXap1yA+YbMeV61f3wY1nCO3uVLP4vFSa7lKxRMDjGsxKHf5Y53D8q5sFQAqEFOZV9F8BUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453


On 8/28/2024 6:48 PM, Vinod Koul wrote:
> On 08-07-24, 20:14, Basavaraj Natikar wrote:
>> To focus on reusability of ptdma code across modules extract common
>> functions into reusable modules.
>>
>> Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> ---
>>  MAINTAINERS                             | 1 +
>>  drivers/dma/amd/ptdma/ptdma-dev.c       | 2 +-
>>  drivers/dma/amd/ptdma/ptdma-dmaengine.c | 3 +--
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 539bf52410de..97d97ddf26f5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -952,6 +952,7 @@ M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>>  L:	dmaengine@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/dma/amd/ae4dma/
>> +F:	drivers/dma/amd/common/
> I think this should be made amd/ to avoid churn when a file is
> added/dropped

Sure, I will remove the common directory and include everything
in the C files.

>
>>  
>>  AMD AXI W1 DRIVER
>>  M:	Kris Chaplin <kris.chaplin@amd.com>
>> diff --git a/drivers/dma/amd/ptdma/ptdma-dev.c b/drivers/dma/amd/ptdma/ptdma-dev.c
>> index a2bf13ff18b6..2bdf418fe556 100644
>> --- a/drivers/dma/amd/ptdma/ptdma-dev.c
>> +++ b/drivers/dma/amd/ptdma/ptdma-dev.c
>> @@ -17,7 +17,7 @@
>>  #include <linux/module.h>
>>  #include <linux/pci.h>
>>  
>> -#include "ptdma.h"
>> +#include "../common/amd_dma.h"
>>  
>>  /* Human-readable error strings */
>>  static char *pt_error_codes[] = {
>> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
>> index a2e7c2cec15e..66ea10499643 100644
>> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
>> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
>> @@ -9,8 +9,7 @@
>>   * Author: Gary R Hook <gary.hook@amd.com>
>>   */
>>  
>> -#include "ptdma.h"
>> -#include "../../dmaengine.h"
>> +#include "../common/amd_dma.h"
> So the driver was including old headers and now new, but I dont see any
> functions being moved? Does each patch compile...?

Yes, this compiles. As mentioned in the previous comment, I will remove
the common directory and include everything in the C files.


Thanks,
--
Basavaraj

>


