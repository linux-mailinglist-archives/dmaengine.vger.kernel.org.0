Return-Path: <dmaengine+bounces-8664-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP4tJRBtgGmV8AIAu9opvQ
	(envelope-from <dmaengine+bounces-8664-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 10:23:28 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 097DFCA113
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 10:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 463D730055A4
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 09:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D973E2D1936;
	Mon,  2 Feb 2026 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="l7LDcOqC"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022097.outbound.protection.outlook.com [40.107.75.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B623E33D;
	Mon,  2 Feb 2026 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770024205; cv=fail; b=MsrP+oVrSL6ial2xuOoA6Jgml5V6tsxqNHsyuAWYC+Usy5dX5Iq63WXVk5+wBpfdqPtjAXllpVS2Xu51C/spdV5oGkXZewkVbZXH2vxdmqEP0aDJDU33FS9mLgSf6tg5Gz9uXzw5YMuFu7fNoQhnHRxgCUf7Cg3bS5DJ3raz78Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770024205; c=relaxed/simple;
	bh=TFen8babGbUfShnFgQy6xWU8jnMovwxwF/Yz4XZnodw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CzfVXWUvTKP/trpQBe+1fum/ViJKYUuKRX1R2plcrf6RqtxV4yuAozPV29zDFi8UMfFlIHUanrJug4TpFpk7xoKv5TWyXWqZ1ib8+7B8yehUQDqmRoJLEGXEgLe1myxZ7AGpo7xemy2QdT4Gui6Zl4nNLGFSHtKs4VTa42vl0bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=l7LDcOqC; arc=fail smtp.client-ip=40.107.75.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdCNrROhoIkhR0+9Pw6U6SHa+pt1NjfxXypGYMe0WgmxEOADBq0yrAXwYGjw2FQiu3P2Z3VKc0hum2IzWjLQ16UyVgl93d7izTUpowfTXlcNV4ucw/9tMe3wmJo76e4gnBmZAaeDxvARfYdBn5Eyfj9w7mMxUVcq6aBNcNJk/nIxbhsfatAS541wMGPNdJqtKiB6rjg3icCNLkMxEoKvc4+U2Wr4/tl2pogTrDFwcP3HJTiLfaU4pKHlcBFF7hsZkfEQ2bS1Wi4hNCyqruR3oO8RSlSJbmKgirsYwMdZ4bI8hvS4w6buU4OE3Nmlb5wsiCgGj3m0sDS3+asDcH2Awg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ope1xeHfdD9PHrPeXNnWUDHUbvm6pC9x10ggu1zH3s=;
 b=FkiI4XzhszlBMjU9If8qvy8n5zglaXUyGwGAam79qUx3eOh/7CcoqCc66+kSKe67weVE68cdUOvwW/bVqXZSBvsCkHCgPcTx73jaUgCLoty8jNfHRlJsNeVtNaBxiccMQUr3YnYeenU6vfTdE2cqK4shFiIg3Yd+7YWvfU4hCq1CryG2dro1v7oJzDroliFjlAm1dTusBRzjkdhhXDNomnHhr206AFAEHs7+ONyKk64PghNEF567JNOmt/Sir71AnpuoAAVfvgNz160rXxsb0R91t9KtgKWusolBxLc45aHd2UnqceYVctsfhxFCxPM1TLCZbQbHIKYvWvHfqHATfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ope1xeHfdD9PHrPeXNnWUDHUbvm6pC9x10ggu1zH3s=;
 b=l7LDcOqCTCrKonDxwE5mu2F4vqdFI764oFiPrwQpDAW8jyHfSpy105+f6/rGYDY+TdLI8+aOTLCJnlGfMLRM9Wjbqcm7KDaimHXAPQaTz6OrCUKjsP2J8lRK9M79B9iSWCIc+TwydmTYYcGTAjKFG/kZ6cHBaflu4Nafx7LJy30SBiJnjQDYcjOfU8E8xMBXO+mOK5ORZlj+5KZPyqmeStzw9SmoYwWX+h0dB5FvrdgNevz//ihpSvG8FaAU9CH3zLrLJwhGVFx7c0fF2pdE6PgPnG1fCqSTnFkLCsNXeoYYtXLGbEckyWx5S5xyxynEXwc1pG0BUD2fHqre7Ox3AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEYPR03MB9802.apcprd03.prod.outlook.com (2603:1096:101:304::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 09:23:19 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 09:23:19 +0000
Message-ID: <260d0d7d-4324-4fd6-b12d-50ffeaa82114@amlogic.com>
Date: Mon, 2 Feb 2026 17:23:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dma: amlogic: Add general DMA driver for A9
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
 <20260127-amlogic-dma-v2-2-4525d327d74d@amlogic.com>
 <aXuhOZICKEHNQ3GP@lizhi-Precision-Tower-5810>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <aXuhOZICKEHNQ3GP@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0237.apcprd06.prod.outlook.com
 (2603:1096:4:ac::21) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEYPR03MB9802:EE_
X-MS-Office365-Filtering-Correlation-Id: e31c94fe-cdc2-4dee-0b14-08de623cb40b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzZTSFVQbitHV0h4eW4yN3ZRbkVBRHFpbGdLbFVuazNiTTZ6eVQ1WnExYkFK?=
 =?utf-8?B?V3pQc0hCRmVhQjVwUUkzUlFndjNaTUZOeUxPZWxLVEdob2s1UG9QOS9UL2cy?=
 =?utf-8?B?OHFsdmk4dk1lTDlrWlhZUHdVZjh5cERYenNRanEzcEJ4bHorbG5qcXROZ3A4?=
 =?utf-8?B?VkpNaGpYVzBqS29xVFBoZzUvampIbHV5bGpsNmdNdlhKeXVaTGp6NVpkakll?=
 =?utf-8?B?YUt0YjRvRnJvN3luVTM4eWlCQ2xWdG5xOFNMUUR5VnYrbFJ2SmpBc2UzSk4r?=
 =?utf-8?B?VGtPM1hoRWdxelN1aVA2U0VxWExPdXdJd1Izclc0eGFRTGNTQTBxcXNCVXZz?=
 =?utf-8?B?ZWdjYVhyYzdyVnp5UldvQjRuRFI0dmlBYnRtWDRCZ2d1aEVTTDM0d1JQMTZC?=
 =?utf-8?B?UU13ODlKMlpsRUFMVDJjRG9aV1hFNkRjUE9IQjNKZWdHUlhPRmlkdXhWaUdu?=
 =?utf-8?B?UVAxS0l1amlMd0ZYSHNOdC92TVZvSk5RcGd6Ty82UjRWcWtLNXJmZEphWStv?=
 =?utf-8?B?QmxYTWRneWFjaDFnSyswU2pLT1BEaFh3Mis3QlV0ZDJrNkRjZVBVNUtKTWpS?=
 =?utf-8?B?cGsvTjQ2bGhmY0tWcVhWWk1MWlNlTlZDVTAxbUZRdVlXbEZYTkxIeEQrL2Rt?=
 =?utf-8?B?MzJKZjd2N25jNFFrR1pwdjdaUy90TUlRYTNncnFlb0ZZR0Vyc0VGTkFyOVhS?=
 =?utf-8?B?MmlGaDlUNHZPOS81UFVDNUJ2cUJVMHNsQkQyZyt0ZW9yOEJMTEZkR1h6ZVJa?=
 =?utf-8?B?WGErSHpEQVRlUTQ2WHAvc3ZnSjFmeXhvSHNsLy9vTGJWQkpIdE1sMndFSHFP?=
 =?utf-8?B?RmZqSEZFZHk5Zm9qZjR4K3oyTFFCdmdQanZIR1lJdW0rODBwSk5aazNUU3hR?=
 =?utf-8?B?RE9iU0JPVEhleVA2dEtUMkFxZmZjUjYwMVVnVmxmRTlFNGppTFJEZlZLK3NU?=
 =?utf-8?B?Z1NRODdRT0VlUlgzNnpJZ2JycnhwbnBkdVgzYVUzaXF6Rk1BRzhTMHd2OWQ1?=
 =?utf-8?B?YkhwZStwV0laQjJwOUdNL0l2Z25rY2FNd1JZTWNxSFFPcUxpbG9wZDVsSG9Y?=
 =?utf-8?B?VWJBR2tOMS85dDhVdXZLcFkwY3B6UHdaNnFGSG5IaVFtR0JacEI3WVVpb3lQ?=
 =?utf-8?B?TkpJTGFjaHd2ZjVTbmZQQUxCL0hpUHhIMTFNTklFcUlFRmZhZHcvY05xZjhH?=
 =?utf-8?B?RjR3eU1neHZEbVVjR1lXQ3FaUWZhbjFCVzBoa0JDdEl6bDFZNGI2NC9seUpF?=
 =?utf-8?B?RTArcDhHVk15ZHNyako0cC8reVFmVUNuWHJrVDFoM3E2d3RUM3lkQmp5L0t3?=
 =?utf-8?B?Q1E0WVIzUEVHczVCZGxaZFd3MXBmQXdML0ZaZFZtT3UzS0dFdEN4T2N0NU9q?=
 =?utf-8?B?S2RKcnJtN1hZSUROQ0RudlF2ajNGWVFQclJ2M1VYVU9TUERURkF3UWMvYUMv?=
 =?utf-8?B?MVdvRnFEUHNjYVpqTDNBRXdUbEt0Z1Bzc1ZVcmpnU0lYR0pzVUZqSFl5TWdV?=
 =?utf-8?B?azNTMXRtemJRSzg5akNPOTJiUk90aXJlVzR4RGpHNS9BSUxiSEZaeEZMaDIv?=
 =?utf-8?B?SXIraitXQmZqZDJuSWpHcmFRd2hMaXVzcWE2VmZMNmd2WHZQWmZxTk9XN0o1?=
 =?utf-8?B?RjV6Tk5lc2ZrWUkyYjQ0NlBGVU5GTjlHNWZXZnVzVXdEY253TThKU1BaNzRt?=
 =?utf-8?B?VFBkN3RYT1o5YUE2R3VDbDMxV2JONC9RWE1IU2hIcExucGpTb0x5eENZaDY4?=
 =?utf-8?B?WExFVXZ5cmtNMWltOExLR1g0eGxhbGRaa3ZJdEorSUNYcjdDRHRJRExNbkZp?=
 =?utf-8?B?dHhDZzFCSm9pWmZHaFBZNHdPVXNML3lhZUFSeGRnSFZOUVU5N2NXak1SWlFC?=
 =?utf-8?B?OGJmaE9DSUhOTlU5clc5TVBPUTBkVXlTZGZ6MnJkcW0weEFjdEFzYWtwVFd3?=
 =?utf-8?B?RVZ4dk91K01BU2NuNmd4eVAwV2FsZy85eHRraW1SMktqUmVNb0RKTFFtRXQr?=
 =?utf-8?B?c1NCUVRCdm5DY0N6V285TlJJdnBWY0tkUGZCbFlZYjJLMkxLZG1BcDErRlBm?=
 =?utf-8?B?czRDNWFMYyt6UWhZcnRqRHBLdFhoQnhyeFNQZ2ZEbUFEekhTSXcyaVdJd3M1?=
 =?utf-8?Q?InIU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1pEY2k0K29TRDRqLzNycy80dDR1Sm1pQVZRTmJ6TElPZUxXSE9ScjAzazFW?=
 =?utf-8?B?cE91YmxybUIwRHUrZEVZYXREYnZ2dkw4M0swR2lhQThHakZobDRIbG5rLy8w?=
 =?utf-8?B?akV4Y2ZzZmZGTXZpMnBPY1VRK0hROVZsY3IwRDhNNmhIZkd4K0VxdnNzbU9E?=
 =?utf-8?B?R3pnREVsTDhSWFBlSnd5V3VYMS9WMW5tK21RYVdreHByclR1UTRRemJCTlpo?=
 =?utf-8?B?dmxlamVPQWFOSk9TR2RqdUEzRVc2Wmh3U2FKN2FYSENhb2MxUmpsRzN1UXVQ?=
 =?utf-8?B?dFJmeFJwTk51aitZUXdTeExTdHo2MTZVc0NPZzlYSlgvUGF1S3A0aCtqRUQ1?=
 =?utf-8?B?cC83T2NVZGtZZ0hzVFFxblpWM0I5MXYxbVRXQk1OaEhtV3RZZW8va1dUUk1w?=
 =?utf-8?B?U0hrS3lPRUlDZVZhM2dHUWxVQzNHZDQzTjl0NzJKMkVDaDdGZDJMdHN0QTZs?=
 =?utf-8?B?TmY5UkRMNHQvWTR3eDlxMU50S0FXWjNMOFFpcy9TRml2YlRuSnZkZUpRd25U?=
 =?utf-8?B?azB6a0F1MXNNc3NYYzNGMkxaeVJxS2ZVNm11RDVESlVsUGlVdFRkQWtTQktV?=
 =?utf-8?B?NXFvSkF6WTUvRzJxdFBOb1lVYXY5VWY2MXJaNStYVDZpNXBKYnM5LzNKeUZh?=
 =?utf-8?B?V1lZZ2c3OEFmUmpjQnZaZWRkc2h6NUdRUGZ2ODM1a2dKcnFia011NnF3WnFD?=
 =?utf-8?B?V0piT1NvWWlrK01Lc1BhUUptMmZmWUkwTjVBb3JTRDY2VGR6YkhsS1ZMVmtm?=
 =?utf-8?B?N21DTW1tbWE2R25SbTVPVTEreitrUzcyU0hVaVpyOFlTVEF5L0MycDgvcWQy?=
 =?utf-8?B?RlpxcS8zSlVKZ1lIR3hnN2dMSU1Ydm9zWThFaWZ6RG15VlhRa01EbHlOZSsy?=
 =?utf-8?B?bUl4N2dwcTQyL0VhR3RBdGVpb1RMeVlkSnhuMGV2TU5IUXNqYWRoUXNNMFpy?=
 =?utf-8?B?ZjA0RVpIcGhPVTBzUjBEd1ZwVFNJZk9hQ3kxdFRNSDZycktlT3RVSCtTYTNF?=
 =?utf-8?B?eFhjZGJRRzhJUm5DeXZmMXk0U3NUM1krNjE2U25icGtrM1dZaTNleklmQmNv?=
 =?utf-8?B?Mkw4MGdiZEo5U3VvVkZiY2RESXcyblQrTlpjQjljZEFUK2ZrQzY5cmYzc1ZM?=
 =?utf-8?B?dzY0cEpnWnBJWnRmWUZ5U1kxVkRlU2ZMZUdvVlI4K093M0lIODBMcUo3OXNU?=
 =?utf-8?B?OVJpY0tNM3Y2eE5UQ0FLanhQMmZ6ZndIUnVDMTE2SDN1SG55R2ZONGpiYTdO?=
 =?utf-8?B?ZEJMM1BuNGdhQWZTR21XSGcxWU1XKzJhNXdjc3lXK3BBSUpDWlJiNHI3Zmda?=
 =?utf-8?B?MExGcGdkdEJqZUt3c2UzbmZ3Y1laTGZzcm9YK1RUR0IzWWY3VGhheTZKTWpv?=
 =?utf-8?B?SkpzNWVHdE1kS0dmWEd1TFZBODlSLzQ0MHpMM2pteDd3VENjN1Jxd1JXVFJr?=
 =?utf-8?B?TGh6QWhaUDYwTUhPYitkakJzbEw0eFlBM0hTa3pVZlhvSGRXZEEwU0gzNnpn?=
 =?utf-8?B?dzFuTEQybTVVWWtHQjAvTnE2SHpRaHNnNWI5T2dVbUZOUUJFQzNJMTRpWUhD?=
 =?utf-8?B?OHdacDRHbk0vYXlLRDhlOXJLbk1zb042Y3UzSnVXS2p4eXRkUVVvencvNTdR?=
 =?utf-8?B?NE1xdUU4QWFod1lSZVN6TnEwV3ZqYjE3cUR1SVVLamwwQ3hMMTRNd2R0Z1Nr?=
 =?utf-8?B?T1BCUDV3RDRIWENVTVRDZDkzbkxQZXNvUWNYcXBQM1dGZ0VaREFzU2EwTEll?=
 =?utf-8?B?alBnMDZzbzVHQWt4YkJaUThNVnNvc252NEdDaVlLdzJUMnFiYW9IbTdhTzNE?=
 =?utf-8?B?dzVJNHREemdyVFovMVVzVUhuNzNjMnZ0OFlqNG5VM1N2M3BYdldaODQxU3FF?=
 =?utf-8?B?S0NrUmlRa3Q0bWJhYVNjMmJBTlNpN0pkWSt0aVBrRFBrNkVBeEZWRitOT055?=
 =?utf-8?B?SEhZNDkzOHNpUUs5T2o3dnNzdkoxUDVSZWdINkNLeDBtcy9CbzNoNXI5R3Ru?=
 =?utf-8?B?RXUxb3lqaVBtVjBtN1kxcXBhUHViOW4vdm5SZDg1YjZrOHZWN1R3WktJNlcv?=
 =?utf-8?B?RG9rdXh3YTN1d0U5aVU0dDJrd2xnSlJSM2tFelp2WnZZRGFtbWprVTJSRkNT?=
 =?utf-8?B?Y2xjcW8rTzNKREpBNTdiVkJzdC9qQlpRSENTZDAwOTI2UXdqUUV4WlBjUGg4?=
 =?utf-8?B?V0d2REh1NE9BUFhESWJyM1pGM0JsMi9XNEUrNzR3OThYMDI1UlYwN254Vnhw?=
 =?utf-8?B?cm4xK1BURDduaDAzaVptZ2o4OC85Wm9uVEloL2RqM0E5MGZPeis1OHVsWEpP?=
 =?utf-8?B?L2E1QlI3aFBmdmxPU1laTmJ6eWYvcEI5a3EzVkpVVDVZMDR0UkVQdz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e31c94fe-cdc2-4dee-0b14-08de623cb40b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 09:23:19.3164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okhp6u31ed/R0C1UWnVgHtBdU76J7V01VojoD5dLR0kqkd8a3zZSO5inNnnEwwLE7V6mc/TBah39qBjb2AOKc5F2IYXpYqTrO+V7NcuYrJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB9802
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8664-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amlogic.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xianwei.zhao@amlogic.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amlogic.com:email,amlogic.com:dkim,amlogic.com:mid,aka.ms:url]
X-Rspamd-Queue-Id: 097DFCA113
X-Rspamd-Action: no action

Hi Frank,
    Thanks for your reply.

On 2026/1/30 02:04, Frank Li wrote:
> [You don't often get email from frank.li@nxp.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> [ EXTERNAL EMAIL ]
> 
> On Tue, Jan 27, 2026 at 03:27:53AM +0000, Xianwei Zhao wrote:
>> Amlogic A9 SoCs include a general-purpose DMA controller that can be used
>> by multiple peripherals, such as I2C PIO and I3C. Each peripheral group
>> is associated with a dedicated DMA channel in hardware.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   drivers/dma/Kconfig       |   9 +
>>   drivers/dma/Makefile      |   1 +
>>   drivers/dma/amlogic-dma.c | 563 ++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 573 insertions(+)
>>
>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index 66cda7cc9f7a..8d4578513acf 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -85,6 +85,15 @@ config AMCC_PPC440SPE_ADMA
>>        help
>>          Enable support for the AMCC PPC440SPe RAID engines.
>>
>> +config AMLOGIC_DMA
>> +     tristate "Amlogic general DMA support"
>> +     depends on ARCH_MESON || COMPILE_TEST
>> +     select DMA_ENGINE
>> +     select REGMAP_MMIO
>> +     help
>> +       Enable support for the Amlogic general DMA engines. THis DMA
>> +       controller is used some Amlogic SoCs, such as A9.
>> +
>>   config APPLE_ADMAC
>>        tristate "Apple ADMAC support"
>>        depends on ARCH_APPLE || COMPILE_TEST
>> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
>> index a54d7688392b..fc28dade5b69 100644
>> --- a/drivers/dma/Makefile
>> +++ b/drivers/dma/Makefile
>> @@ -16,6 +16,7 @@ obj-$(CONFIG_DMATEST) += dmatest.o
>>   obj-$(CONFIG_ALTERA_MSGDMA) += altera-msgdma.o
>>   obj-$(CONFIG_AMBA_PL08X) += amba-pl08x.o
>>   obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
>> +obj-$(CONFIG_AMLOGIC_DMA) += amlogic-dma.o
>>   obj-$(CONFIG_APPLE_ADMAC) += apple-admac.o
>>   obj-$(CONFIG_ARM_DMA350) += arm-dma350.o
>>   obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
>> diff --git a/drivers/dma/amlogic-dma.c b/drivers/dma/amlogic-dma.c
>> new file mode 100644
>> index 000000000000..dca938638474
>> --- /dev/null
>> +++ b/drivers/dma/amlogic-dma.c
>> @@ -0,0 +1,563 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
>> +/*
>> + * Copyright (C) 2025 Amlogic, Inc. All rights reserved
>> + * Author: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/types.h>
>> +#include <linux/mm.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/slab.h>
>> +#include <linux/dmaengine.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_dma.h>
>> +#include <linux/list.h>
>> +#include <linux/regmap.h>
> 
> keep alphabet order
> 

Will do.

>> +#include <asm/irq.h>
> 
> Add space line between <> and ""
> 

Will do.

>> +#include "dmaengine.h"
>> +
>> +#define RCH_REG_BASE         0x0
>> +#define WCH_REG_BASE         0x2000
>> +/*
>> + * Each rch (read from memory) REG offset  Rch_offset 0x0 each channel total 0x40
>> + * rch addr = DMA_base + Rch_offset+ chan_id * 0x40 + reg_offset
>> + */
>> +#define RCH_READY            0x0
>> +#define RCH_STATUS           0x4
>> +#define RCH_CFG                      0x8
>> +#define CFG_CLEAR            BIT(25)
>> +#define CFG_PAUSE            BIT(26)
>> +#define CFG_ENABLE           BIT(27)
>> +#define CFG_DONE             BIT(28)
>> +#define RCH_ADDR             0xc
>> +#define RCH_LEN                      0x10
>> +#define RCH_RD_LEN           0x14
>> +#define RCH_PRT                      0x18
>> +#define RCH_SYCN_STAT                0x1c
>> +#define RCH_ADDR_LOW         0x20
>> +#define RCH_ADDR_HIGH                0x24
>> +/* if work on 64, it work with RCH_PRT */
>> +#define RCH_PTR_HIGH         0x28
>> +
>> +/*
>> + * Each wch (write to memory) REG offset  Wch_offset 0x2000 each channel total 0x40
>> + * wch addr = DMA_base + Wch_offset+ chan_id * 0x40 + reg_offset
>> + */
>> +#define WCH_READY            0x0
>> +#define WCH_TOTAL_LEN                0x4
>> +#define WCH_CFG                      0x8
>> +#define WCH_ADDR             0xc
>> +#define WCH_LEN                      0x10
>> +#define WCH_RD_LEN           0x14
>> +#define WCH_PRT                      0x18
>> +#define WCH_CMD_CNT          0x1c
>> +#define WCH_ADDR_LOW         0x20
>> +#define WCH_ADDR_HIGH                0x24
>> +/* if work on 64, it work with RCH_PRT */
>> +#define WCH_PTR_HIGH         0x28
>> +
>> +/* DMA controller reg */
>> +#define RCH_INT_MASK         0x1000
>> +#define WCH_INT_MASK         0x1004
>> +#define CLEAR_W_BATCH                0x1014
>> +#define CLEAR_RCH            0x1024
>> +#define CLEAR_WCH            0x1028
>> +#define RCH_ACTIVE           0x1038
>> +#define WCH_ACTIVE           0x103C
>> +#define RCH_DONE             0x104C
>> +#define WCH_DONE             0x1050
>> +#define RCH_ERR                      0x1060
>> +#define RCH_LEN_ERR          0x1064
>> +#define WCH_ERR                      0x1068
>> +#define DMA_BATCH_END                0x1078
>> +#define WCH_EOC_DONE         0x1088
>> +#define WDMA_RESP_ERR                0x1098
>> +#define UPT_PKT_SYNC         0x10A8
>> +#define RCHN_CFG             0x10AC
>> +#define WCHN_CFG             0x10B0
>> +#define MEM_PD_CFG           0x10B4
>> +#define MEM_BUS_CFG          0x10B8
>> +#define DMA_GMV_CFG          0x10BC
>> +#define DMA_GMR_CFG          0x10C0
> 
> Keep hexvalue consistent, low case or up case.
> 

Will do.

>> +
>> +#define AML_DMA_TYPE_TX              0
>> +#define AML_DMA_TYPE_RX              1
>> +#define DMA_MAX_LINK         8
>> +#define MAX_CHAN_ID          32
>> +#define SG_MAX_LEN           ((1 << 27) - 1)
> 
> use GEN_MASK
> 

Will do.

>> +
>> +struct aml_dma_sg_link {
>> +#define LINK_LEN             GENMASK(26, 0)
>> +#define LINK_IRQ             BIT(27)
>> +#define LINK_EOC             BIT(28)
>> +#define LINK_LOOP            BIT(29)
>> +#define LINK_ERR             BIT(30)
>> +#define LINK_OWNER           BIT(31)
>> +     u32 ctl;
>> +     u64 address;
>> +     u32 revered;
>> +} __packed;
>> +
>> +struct aml_dma_chan {
>> +     struct dma_chan                 chan;
>> +     struct dma_async_tx_descriptor  desc;
>> +     struct aml_dma_dev              *aml_dma;
>> +     struct aml_dma_sg_link          *sg_link;
>> +     dma_addr_t                      sg_link_phys;
>> +     int                             sg_link_cnt;
>> +     int                             data_len;
>> +     enum dma_status                 status;
>> +     enum dma_transfer_direction     direction;
>> +     int                             chan_id;
>> +     /* reg_base (direction + chan_id) */
>> +     int                             reg_offs;
>> +};
>> +
>> +struct aml_dma_dev {
>> +     struct dma_device               dma_device;
>> +     void __iomem                    *base;
>> +     struct regmap                   *regmap;
>> +     struct clk                      *clk;
>> +     int                             irq;
>> +     struct platform_device          *pdev;
>> +     struct aml_dma_chan             *aml_rch[MAX_CHAN_ID];
>> +     struct aml_dma_chan             *aml_wch[MAX_CHAN_ID];
>> +     unsigned int                    chan_nr;
>> +     unsigned int                    chan_used;
>> +     struct aml_dma_chan             aml_chans[]__counted_by(chan_nr);
>> +};
>> +
>> +static struct aml_dma_chan *to_aml_dma_chan(struct dma_chan *chan)
>> +{
>> +     return container_of(chan, struct aml_dma_chan, chan);
>> +}
>> +
>> +static dma_cookie_t aml_dma_tx_submit(struct dma_async_tx_descriptor *tx)
>> +{
>> +     return dma_cookie_assign(tx);
>> +}
>> +
>> +static int aml_dma_alloc_chan_resources(struct dma_chan *chan)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +
>> +     aml_chan->sg_link = dma_alloc_coherent(aml_dma->dma_device.dev,
>> +                                            sizeof(struct aml_dma_sg_link) * DMA_MAX_LINK,
> 
> use size_mul()
>

Will do.

>> +                                            &aml_chan->sg_link_phys, GFP_KERNEL);
>> +     if (!aml_chan->sg_link)
>> +             return  -ENOMEM;
>> +
>> +     /* offset is the same RCH_CFG and WCH_CFG */
>> +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, CFG_CLEAR);
>> +     aml_chan->status = DMA_COMPLETE;
>> +     dma_async_tx_descriptor_init(&aml_chan->desc, chan);
>> +     aml_chan->desc.tx_submit = aml_dma_tx_submit;
>> +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, 0);
>> +
>> +     return 0;
>> +}
>> +
>> +static void aml_dma_free_chan_resources(struct dma_chan *chan)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +
>> +     aml_chan->status = DMA_COMPLETE;
>> +     dma_free_coherent(aml_dma->dma_device.dev,
>> +                       sizeof(struct aml_dma_sg_link) * DMA_MAX_LINK,
>> +                       aml_chan->sg_link, aml_chan->sg_link_phys);
>> +}
>> +
>> +/* DMA transfer state  update how many data reside it */
>> +static enum dma_status aml_dma_tx_status(struct dma_chan *chan,
>> +                                      dma_cookie_t cookie,
>> +                                      struct dma_tx_state *txstate)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +     u32 residue, done;
>> +
>> +     regmap_read(aml_dma->regmap, aml_chan->reg_offs + RCH_RD_LEN, &done);
>> +     residue = aml_chan->data_len - done;
>> +     dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
>> +                      residue);
>> +
>> +     return aml_chan->status;
>> +}
>> +
>> +static struct dma_async_tx_descriptor *aml_dma_prep_slave_sg
>> +             (struct dma_chan *chan, struct scatterlist *sgl,
>> +             unsigned int sg_len, enum dma_transfer_direction direction,
>> +             unsigned long flags, void *context)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +     struct aml_dma_sg_link *sg_link;
>> +     struct scatterlist *sg;
>> +     int idx = 0;
>> +     u32 reg, chan_id;
>> +     u32 i;
>> +
>> +     if (aml_chan->direction != direction) {
>> +             dev_err(aml_dma->dma_device.dev, "direction not support\n");
>> +             return NULL;
>> +     }
>> +
>> +     switch (aml_chan->status) {
>> +     case DMA_IN_PROGRESS:
>> +             /* support multiple prep before pending */
>> +             idx = aml_chan->sg_link_cnt;
>> +
>> +             break;
>> +     case DMA_COMPLETE:
>> +             aml_chan->data_len = 0;
>> +             chan_id = aml_chan->chan_id;
>> +             reg = (direction == DMA_DEV_TO_MEM) ? WCH_INT_MASK : RCH_INT_MASK;
>> +             regmap_update_bits(aml_dma->regmap, reg, BIT(chan_id), BIT(chan_id));
>> +
>> +             break;
>> +     default:
>> +             dev_err(aml_dma->dma_device.dev, "status error\n");
>> +             return NULL;
>> +     }
>> +
>> +     if (sg_len + idx > DMA_MAX_LINK) {
>> +             dev_err(aml_dma->dma_device.dev,
>> +                     "maximum number of sg exceeded: %d > %d\n",
>> +                     sg_len, DMA_MAX_LINK);
>> +             aml_chan->status = DMA_ERROR;
>> +             return NULL;
>> +     }
>> +
>> +     aml_chan->status = DMA_IN_PROGRESS;
>> +
>> +     for_each_sg(sgl, sg, sg_len, i) {
>> +             if (sg_dma_len(sg) > SG_MAX_LEN) {
>> +                     dev_err(aml_dma->dma_device.dev,
>> +                             "maximum bytes exceeded: %d > %d\n",
>> +                             sg_dma_len(sg), SG_MAX_LEN);
>> +                     aml_chan->status = DMA_ERROR;
>> +                     return NULL;
>> +             }
>> +             sg_link = &aml_chan->sg_link[idx++];
>> +             /* set dma address and len  to sglink*/
>> +             sg_link->address = sg->dma_address;
>> +             sg_link->ctl = FIELD_PREP(LINK_LEN, sg_dma_len(sg));
>> +
>> +             aml_chan->data_len += sg_dma_len(sg);
>> +     }
>> +     aml_chan->sg_link_cnt = idx;
>> +
>> +     return &aml_chan->desc;
> 
> Here have problems, if caller
> 
>          a = dmaengine_prep_slave_sg();
>          ...
>          b = dmaengine_prep_slave_sg();
> 
>          submit(a); submit(b);
> 
> API don't limit that prep_slave_sg() must follow submit().
> 

Our DMA module uses a dedicated DMA channel per device and supports 
scatter-gather mode.

In function "prep_slave_sg" , data list has been placed in the hardware 
executable queue,
and the "submit" do nothing but assign cookies to prevent function 
dma_async_is_tx_complete called error.

When device_issue_pending is called, all data list will be processed.

>> +}
>> +
>> +static int aml_dma_pause_chan(struct dma_chan *chan)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +
>> +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE, CFG_PAUSE);
>> +     aml_chan->status = DMA_PAUSED;
>> +
>> +     return 0;
>> +}
>> +
>> +static int aml_dma_resume_chan(struct dma_chan *chan)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +
>> +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE, 0);
>> +     aml_chan->status = DMA_IN_PROGRESS;
>> +
>> +     return 0;
>> +}
>> +
>> +static int aml_dma_terminate_all(struct dma_chan *chan)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +     int chan_id = aml_chan->chan_id;
>> +
>> +     aml_dma_pause_chan(chan);
>> +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, CFG_CLEAR);
>> +
>> +     if (aml_chan->direction == DMA_MEM_TO_DEV)
>> +             regmap_update_bits(aml_dma->regmap, RCH_INT_MASK, BIT(chan_id), BIT(chan_id));
>> +     else if (aml_chan->direction == DMA_DEV_TO_MEM)
>> +             regmap_update_bits(aml_dma->regmap, WCH_INT_MASK, BIT(chan_id), BIT(chan_id));
>> +
>> +     aml_chan->status = DMA_COMPLETE;
>> +
>> +     return 0;
>> +}
>> +
>> +static void aml_dma_enable_chan(struct dma_chan *chan)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +     struct aml_dma_sg_link *sg_link;
>> +     int chan_id = aml_chan->chan_id;
>> +     int idx = aml_chan->sg_link_cnt - 1;
>> +
>> +     /* the last sg set eoc flag */
>> +     sg_link = &aml_chan->sg_link[idx];
>> +     sg_link->ctl |= LINK_EOC;
>> +     dma_wmb();
> 
> why need it? regmap_write() already have dma_wmb();
> 

regmap_write will call wmb() / iowmb(), not dma_wmb.
So I think it's best to keep it.

> Frank
>> +     if (aml_chan->direction == DMA_MEM_TO_DEV) {
>> +             regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_ADDR,
>> +                          aml_chan->sg_link_phys);
>> +             regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_LEN, aml_chan->data_len);
>> +             regmap_update_bits(aml_dma->regmap, RCH_INT_MASK, BIT(chan_id), 0);
>> +             /* for rch (tx) need set cfg 0 to trigger start */
>> +             regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, 0);
>> +     } else if (aml_chan->direction == DMA_DEV_TO_MEM) {
>> +             regmap_write(aml_dma->regmap, aml_chan->reg_offs + WCH_ADDR,
>> +                          aml_chan->sg_link_phys);
>> +             regmap_write(aml_dma->regmap, aml_chan->reg_offs + WCH_LEN, aml_chan->data_len);
>> +             regmap_update_bits(aml_dma->regmap, WCH_INT_MASK, BIT(chan_id), 0);
>> +     }
>> +}
>> +
>> +static irqreturn_t aml_dma_interrupt_handler(int irq, void *dev_id)
>> +{
>> +     struct aml_dma_dev *aml_dma = dev_id;
>> +     struct aml_dma_chan *aml_chan;
>> +     u32 done, eoc_done, err, err_l, end;
>> +     int i = 0;
>> +
>> +     /* deal with rch normal complete and error */
>> +     regmap_read(aml_dma->regmap, RCH_DONE, &done);
>> +     regmap_read(aml_dma->regmap, RCH_ERR, &err);
>> +     regmap_read(aml_dma->regmap, RCH_LEN_ERR, &err_l);
>> +     err = err | err_l;
>> +
>> +     done = done | err;
>> +
>> +     while (done) {
>> +             i = ffs(done) - 1;
>> +             aml_chan = aml_dma->aml_rch[i];
>> +             regmap_write(aml_dma->regmap, CLEAR_RCH, BIT(aml_chan->chan_id));
>> +             if (!aml_chan) {
>> +                     dev_err(aml_dma->dma_device.dev, "idx %d rch not initialized\n", i);
>> +                     done &= ~BIT(i);
>> +                     continue;
>> +             }
>> +             aml_chan->status = (err & (1 << i)) ? DMA_ERROR : DMA_COMPLETE;
>> +             /* Make sure to use this for initialization */
>> +             if (aml_chan->desc.cookie >= DMA_MIN_COOKIE)
>> +                     dma_cookie_complete(&aml_chan->desc);
>> +             dmaengine_desc_get_callback_invoke(&aml_chan->desc, NULL);
>> +             done &= ~BIT(i);
>> +     }
>> +
>> +     /* deal with wch normal complete and error */
>> +     regmap_read(aml_dma->regmap, DMA_BATCH_END, &end);
>> +     if (end)
>> +             regmap_write(aml_dma->regmap, CLEAR_W_BATCH, end);
>> +
>> +     regmap_read(aml_dma->regmap, WCH_DONE, &done);
>> +     regmap_read(aml_dma->regmap, WCH_EOC_DONE, &eoc_done);
>> +     done = done | eoc_done;
>> +
>> +     regmap_read(aml_dma->regmap, WCH_ERR, &err);
>> +     regmap_read(aml_dma->regmap, WDMA_RESP_ERR, &err_l);
>> +     err = err | err_l;
>> +
>> +     done = done | err;
>> +     i = 0;
>> +     while (done) {
>> +             i = ffs(done) - 1;
>> +             aml_chan = aml_dma->aml_wch[i];
>> +             regmap_write(aml_dma->regmap, CLEAR_WCH, BIT(aml_chan->chan_id));
>> +             if (!aml_chan) {
>> +                     dev_err(aml_dma->dma_device.dev, "idx %d wch not initialized\n", i);
>> +                     done &= ~BIT(i);
>> +                     continue;
>> +             }
>> +             aml_chan->status = (err & (1 << i)) ? DMA_ERROR : DMA_COMPLETE;
>> +             if (aml_chan->desc.cookie >= DMA_MIN_COOKIE)
>> +                     dma_cookie_complete(&aml_chan->desc);
>> +             dmaengine_desc_get_callback_invoke(&aml_chan->desc, NULL);
>> +             done &= ~BIT(i);
>> +     }
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static struct dma_chan *aml_of_dma_xlate(struct of_phandle_args *dma_spec, struct of_dma *ofdma)
>> +{
>> +     struct aml_dma_dev *aml_dma = (struct aml_dma_dev *)ofdma->of_dma_data;
>> +     struct aml_dma_chan *aml_chan = NULL;
>> +     u32 type;
>> +     u32 phy_chan_id;
>> +
>> +     if (dma_spec->args_count != 2)
>> +             return NULL;
>> +
>> +     type = dma_spec->args[0];
>> +     phy_chan_id = dma_spec->args[1];
>> +
>> +     if (phy_chan_id >= MAX_CHAN_ID)
>> +             return NULL;
>> +
>> +     if (type == AML_DMA_TYPE_TX) {
>> +             aml_chan = aml_dma->aml_rch[phy_chan_id];
>> +             if (!aml_chan) {
>> +                     if (aml_dma->chan_used >= aml_dma->chan_nr) {
>> +                             dev_err(aml_dma->dma_device.dev, "some dma clients err used\n");
>> +                             return NULL;
>> +                     }
>> +                     aml_chan = &aml_dma->aml_chans[aml_dma->chan_used];
>> +                     aml_dma->chan_used++;
>> +                     aml_chan->direction = DMA_MEM_TO_DEV;
>> +                     aml_chan->chan_id = phy_chan_id;
>> +                     aml_chan->reg_offs = RCH_REG_BASE + 0x40 * aml_chan->chan_id;
>> +                     aml_dma->aml_rch[phy_chan_id] = aml_chan;
>> +             }
>> +     } else if (type == AML_DMA_TYPE_RX) {
>> +             aml_chan = aml_dma->aml_wch[phy_chan_id];
>> +             if (!aml_chan) {
>> +                     if (aml_dma->chan_used >= aml_dma->chan_nr) {
>> +                             dev_err(aml_dma->dma_device.dev, "some dma clients err used\n");
>> +                             return NULL;
>> +                     }
>> +                     aml_chan = &aml_dma->aml_chans[aml_dma->chan_used];
>> +                     aml_dma->chan_used++;
>> +                     aml_chan->direction = DMA_DEV_TO_MEM;
>> +                     aml_chan->chan_id = phy_chan_id;
>> +                     aml_chan->reg_offs = WCH_REG_BASE + 0x40 * aml_chan->chan_id;
>> +                     aml_dma->aml_wch[phy_chan_id] = aml_chan;
>> +             }
>> +     } else {
>> +             dev_err(aml_dma->dma_device.dev, "type %d not supported\n", type);
>> +             return NULL;
>> +     }
>> +
>> +     return dma_get_slave_channel(&aml_chan->chan);
>> +}
>> +
>> +static int aml_dma_probe(struct platform_device *pdev)
>> +{
>> +     struct device_node *np = pdev->dev.of_node;
>> +     struct dma_device *dma_dev;
>> +     struct aml_dma_dev *aml_dma;
>> +     int ret, i, len;
>> +     u32 chan_nr;
>> +
>> +     const struct regmap_config aml_regmap_config = {
>> +             .reg_bits = 32,
>> +             .val_bits = 32,
>> +             .reg_stride = 4,
>> +             .max_register = 0x3000,
>> +     };
>> +
>> +     ret = of_property_read_u32(np, "dma-channels", &chan_nr);
>> +     if (ret)
>> +             return dev_err_probe(&pdev->dev, ret, "failed to read dma-channels\n");
>> +
>> +     len = sizeof(*aml_dma) + sizeof(struct aml_dma_chan) * chan_nr;
>> +     aml_dma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
>> +     if (!aml_dma)
>> +             return -ENOMEM;
>> +
>> +     aml_dma->chan_nr = chan_nr;
>> +
>> +     aml_dma->base = devm_platform_ioremap_resource(pdev, 0);
>> +     if (IS_ERR(aml_dma->base))
>> +             return PTR_ERR(aml_dma->base);
>> +
>> +     aml_dma->regmap = devm_regmap_init_mmio(&pdev->dev, aml_dma->base,
>> +                                             &aml_regmap_config);
>> +     if (IS_ERR_OR_NULL(aml_dma->regmap))
>> +             return PTR_ERR(aml_dma->regmap);
>> +
>> +     aml_dma->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>> +     if (IS_ERR(aml_dma->clk))
>> +             return PTR_ERR(aml_dma->clk);
>> +
>> +     aml_dma->irq = platform_get_irq(pdev, 0);
>> +
>> +     aml_dma->pdev = pdev;
>> +     aml_dma->dma_device.dev = &pdev->dev;
>> +
>> +     dma_dev = &aml_dma->dma_device;
>> +     INIT_LIST_HEAD(&dma_dev->channels);
>> +
>> +     /* Initialize channel parameters */
>> +     for (i = 0; i < chan_nr; i++) {
>> +             struct aml_dma_chan *aml_chan = &aml_dma->aml_chans[i];
>> +
>> +             aml_chan->aml_dma = aml_dma;
>> +             aml_chan->chan.device = &aml_dma->dma_device;
>> +             dma_cookie_init(&aml_chan->chan);
>> +
>> +             /* Add the channel to aml_chan list */
>> +             list_add_tail(&aml_chan->chan.device_node,
>> +                           &aml_dma->dma_device.channels);
>> +     }
>> +     aml_dma->chan_used = 0;
>> +
>> +     dma_set_max_seg_size(dma_dev->dev, SG_MAX_LEN);
>> +
>> +     dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
>> +     dma_dev->device_alloc_chan_resources = aml_dma_alloc_chan_resources;
>> +     dma_dev->device_free_chan_resources = aml_dma_free_chan_resources;
>> +     dma_dev->device_tx_status = aml_dma_tx_status;
>> +     dma_dev->device_prep_slave_sg = aml_dma_prep_slave_sg;
>> +
>> +     dma_dev->device_pause = aml_dma_pause_chan;
>> +     dma_dev->device_resume = aml_dma_resume_chan;
>> +     dma_dev->device_terminate_all = aml_dma_terminate_all;
>> +     dma_dev->device_issue_pending = aml_dma_enable_chan;
>> +     /* PIO 4 bytes and I2C 1 byte */
>> +     dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES | DMA_SLAVE_BUSWIDTH_1_BYTE);
>> +     dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>> +     dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>> +
>> +     ret = dmaenginem_async_device_register(dma_dev);
>> +     if (ret)
>> +             return dev_err_probe(&pdev->dev, ret, "failed to register dmaenginem\n");
>> +
>> +     ret = of_dma_controller_register(np, aml_of_dma_xlate, aml_dma);
>> +     if (ret)
>> +             return ret;
>> +
>> +     regmap_write(aml_dma->regmap, RCH_INT_MASK, 0xffffffff);
>> +     regmap_write(aml_dma->regmap, WCH_INT_MASK, 0xffffffff);
>> +
>> +     ret = devm_request_irq(&pdev->dev, aml_dma->irq, aml_dma_interrupt_handler,
>> +                            IRQF_SHARED, dev_name(&pdev->dev), aml_dma);
>> +     if (ret)
>> +             return dev_err_probe(&pdev->dev, ret, "failed to reqest_irq\n");
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct of_device_id aml_dma_ids[] = {
>> +     { .compatible = "amlogic,a9-dma", },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, aml_dma_ids);
>> +
>> +static struct platform_driver aml_dma_driver = {
>> +     .probe = aml_dma_probe,
>> +     .driver         = {
>> +             .name   = "aml-dma",
>> +             .of_match_table = aml_dma_ids,
>> +     },
>> +};
>> +
>> +module_platform_driver(aml_dma_driver);
>> +
>> +MODULE_DESCRIPTION("GENERAL DMA driver for Amlogic");
>> +MODULE_AUTHOR("Xianwei Zhao <xianwei.zhao@amlogic.com>");
>> +MODULE_LICENSE("GPL");
>>
>> --
>> 2.52.0
>>

