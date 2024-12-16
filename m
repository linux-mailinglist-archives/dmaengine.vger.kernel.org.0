Return-Path: <dmaengine+bounces-3972-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFF39F2B3F
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 08:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AEEA16182A
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 07:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544461FF7BE;
	Mon, 16 Dec 2024 07:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Lsa6P90x"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655AF1FF7A0;
	Mon, 16 Dec 2024 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335914; cv=fail; b=DSgUuQe3NHhoyLjew5zwjz82yjgRDVfQpynywzmYUmu6kekD5nB/G6vzvZNyjvBr/MWUGetO28VEfF/eN4boAO/XSSlIRc6z52pchxLrM7tjYbMrZCpbkTfhgKAnQwt9IZtCcsADYhbLQRERvRPOzJfiI4FPUXkCHbt+axcbdGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335914; c=relaxed/simple;
	bh=h0ThtxV2ucK5fq1zwr19IsUVH2xykBQ117Z82aAByH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z8DPjPfzGJHk7x980DFURs6gD2UyGbVVfIG8Rvoj1Ko+lWhDyEU1lQccOQSNfo48xnLn9fibpK+PTIrhTVLQiiFQKc+k5Vb977d3lrlOK60pbdyd+vz4wGsO9BeEJarun7x2DkC10Rbrvw1+VPBkVxEpNvkID2eJjiYBydjQGQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Lsa6P90x; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiQKAGWWKNGYOKzyt/TaJblTyJN6WTx+InMqqziViHFnUXh4t1xdLO8wSZfBJxSST9ov1uqiO2j+ED3MI90Y9MkOBiMULpTdIdpQXIkaMAXdMNKLguSTSxposL5Z8F2K6V+X91b48Y3L2x7KMn8vCV/NuFfEtqBCK8JW86B/m+0gEYzVNrbC6HxWn2Jpnhs7wldDWm1BvsJ+QfsT442m3cKa0ANw9cNEwjpQiTIRmGFDUt1I/NuahH0mfd7Bj8GvcUmWqkTMXgIqVVl9r3UbseUljZVbkiKyHBKU/uhe6t/P2lsxlQ8a+qhA7laK7Jfmq1Xh+m5lmO2QQVYpHU9AZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpYX/Wba9b9blkBpLq1qKc1aLSTb28wIOKVhcxZUOj0=;
 b=yC9gBgFnZ9rX/4zxrBO1edN6vedm2kc6cc5WpYMWF5m5PsIexek2UEx4J4N1NbVfSGXwtXG8V/FSCtDSnXpSWoEf3dfHhgOcYQsvajqjwzOqcQB3VAq3RpBwKeqo04emqZVsoVMtFw2XLjKCT+0pam1EfE8hJn4k+cqpDtjhzSGgy+mxmLYgD5xTP2nKCRxlcvTnagUAV6k0KJ/YCpLySIxg7RH4lJkGd30te5N+VChkOM0hgC7eaYRj2BG9CB70kpN0ocrXnIeKelkWJ9TaGGbgyplGvVIQXj8g8pzZR6uTa6h5B+Xtdq5tyWSm2IEnjA7Y0mUKIEozY55rXf4GGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpYX/Wba9b9blkBpLq1qKc1aLSTb28wIOKVhcxZUOj0=;
 b=Lsa6P90xvi0N92GkAeg/9OJfNjf/wdRzAYaWRuzijjNtWihmfd9nzEn9z743v8R4YYd9eoB3Kjdmakd/XQDvQXRNgY0W3ea76eArVZFtjR0F+L+uKzpUxEHiDb707mf/WRtiGvzh7N4WYLR+v0XKevPoHa450sbLzYbdWQWWY6/GFCpNepWF40rHkhOPDd215pY6EtFBPkrjPOiqAdy1cDZxgJ4w/wfODmN+hHbGWp97tYjHHn4kbsQuiGjrUG57bQQ/uSXJ6xZKvjWoV/0jsj3ECicn49Pqf386NNYoY5HxaOi2ADMlNhEofUYbd+iOZ2SdldbgPvyEtQMNzLozWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by DU4PR04MB10361.eurprd04.prod.outlook.com (2603:10a6:10:55d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 07:58:26 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 07:58:26 +0000
From: Larisa Grigore <larisa.grigore@oss.nxp.com>
To: Frank.Li@nxp.com
Cc: dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>
Subject: [PATCH 1/8] dmaengine: fsl-edma: select of_dma_xlate based on the dmamuxs presence
Date: Mon, 16 Dec 2024 09:58:11 +0200
Message-ID: <20241216075819.2066772-2-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0108.eurprd04.prod.outlook.com
 (2603:10a6:208:be::49) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|DU4PR04MB10361:EE_
X-MS-Office365-Filtering-Correlation-Id: 06176cb0-50da-4be9-f314-08dd1da76bdf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2hXMFBXcXovT2hrMUhBTzc4UG51RHFaN1FhYW81a2Q2TzQ0RVUzQk12V0N6?=
 =?utf-8?B?dXY0MllCTmRFNVA1YnNKa0JUZTNXcHFGb1o3bEtheUlCMWpXVzcvc0xOcE95?=
 =?utf-8?B?Nk92S3lYbkpIOGtVbkp0YmhISnJKVUw3dGorcTR1K0crSEY3Y2R5UXUrSGEz?=
 =?utf-8?B?SW8xWktKWjRwYUNlVmhJSjd3UFZaaVUxOWhGd3ZPNEcwN3VzVjlhSGNHbFhi?=
 =?utf-8?B?bUt0c240VzZmVWNBSkZaUzg2dDlzaEJISFBMbnBlLzRmT0pmU095MWpBa3h3?=
 =?utf-8?B?L2FsRVhtRnhtUjFnaVpKN2dzZlF2cFdRNkVQWDlzMm5penVBVXBUUzU2WEYx?=
 =?utf-8?B?RVZFV2FYYkJtNEk2K1JnaEhteUJ1MmkvK0lrRUM2L2hWdGFuQU8vK1VhYzBM?=
 =?utf-8?B?VWUyZ2NyNktzWUtlcWZaWmozUVp2RUtCNTYyMHdrem1keFJjeUhOVXF1c3Nu?=
 =?utf-8?B?ZFJXR05kMEE1TnVtYUxJSXQ3bGNPdXFMZDdrdGNzdll5Wk1kOThzMVkvRHc5?=
 =?utf-8?B?V2FpZkZkbXQrUjRJS25OaURrYlFkVnhxbHBSRXJlZ2VvcU9ubU00anFESVlG?=
 =?utf-8?B?NVZoQmsxRUk3NjZlZ2cvVEo3WlYyNlNMSVhGMUJKTU1lTjdmMFJnV0x6SWdZ?=
 =?utf-8?B?a0NlOHV6MGx4K0N1U0JUTWdUWGJsTGx0UXJxa1VwY2p6K1hpN3NwOTFIcE53?=
 =?utf-8?B?ZWRKY2hUODdVSEZ6c0xRMkpCUGlxTk1YeHZDbW5OSjBzV0dmQnU4OEJ6SzEz?=
 =?utf-8?B?eEgvaDJ4MnNMQU5acWk4a0RoU1FvSE91cmJ2MkoyRGtzbExWNC9zY3RMK0VG?=
 =?utf-8?B?bzU5a0xBV3dUSFZ0UFJqazVUSFFSaWNuWmJlaDBuazRha1hnVzZZK0Jxb3ZW?=
 =?utf-8?B?Z1JyTDgwZ09jVDVnM2pwblREM0w1Ukt4OVhzalNoQ3BTYWFhNm5rM1d6SkNq?=
 =?utf-8?B?bmwwaG5seXZ3bldNNjJMWHUvQWtwQit4SkdHOVZYK1FudTVCeEhoR2thbHJJ?=
 =?utf-8?B?ZjM4MTZxQ1lvV2RnTGt6Rk8vNlNxV2RtVTF1SUx4d1BIZnlsNCs5UjhIYVhn?=
 =?utf-8?B?NTgxdkVxdjY5THV1NjVBbVNDc1JlaUx2RDlFc1J5cThsUlljdGNBZm5GVlQx?=
 =?utf-8?B?blRmUm96TjRUQ3gxN2xaWDBkc2Nqd2JWS1Z0Y2hXdGZIOW4vUWplUzhDMy9D?=
 =?utf-8?B?QmxHeUxTL04yTE1aSmpEaTU4K3k4bTJFRzlnbDM0ZEI2aHRVRmttMlRQUDZa?=
 =?utf-8?B?bC9GUGFBN2VveUVRRTNRV09MQjVwcHRtREZCY1d3bEhPbm1vL0RydlB1NUVj?=
 =?utf-8?B?VXlkVmRZQ1NTSnFvR1dzSE9IZEl0TkhWa2FoUTFyRTRhdFhWcnJNSGg4MGdn?=
 =?utf-8?B?TzFzUERTL3VvaCs0YTI3UTFHeWJ5SnZ6MGhiTFd1UDV0cUpXb2VMN1ZKRHdI?=
 =?utf-8?B?THovZDRaNkYxbE5Qd29md1lSZ3lCNkRFYkxma015aEZxWDRPTVRkNnpNcm81?=
 =?utf-8?B?aVUrY3NVc0pYSElNcUNVQkQ2ZGFLWEFpeW8yNGNsa0Rqb0NJL0R1MVgxN0Zy?=
 =?utf-8?B?WHRYZHJEVjRoUE1yNnl6TzVvYjJna2NqK0dLY1FSbGR4MVdCVDk2ZDNueGdn?=
 =?utf-8?B?bkpvWDh2RmJKWXVMdC9ycUVmRG5BcGJMNmJ1K1IxMnVuLy9UQWJZMXRJdmtm?=
 =?utf-8?B?NDdYTHlkcndVTGYwSjlCN2wyUE1ob0h0WG5lbGN1S3BwWE0rNVRvM0VFZyt5?=
 =?utf-8?B?WStnYlpFUzNNY1d3ZUlVbmIwajBxRG1TVVd0S3diSmlNMVluMWNVNVg0YUJQ?=
 =?utf-8?B?UzZWRHhDSGdZUFRJek1FOFBtakVRTTd6d1JySDk3REs1b1poOFlpUkUzb0h4?=
 =?utf-8?Q?giOpuXkxXKwdN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2Y1YWdMTUFBWHFKV1VmMDV0V1FreUY4Q3UxTmQ0K2J4aWpJUW9BT05haVpj?=
 =?utf-8?B?S01uVGZrRzZtR1plTElzQTVML1ZldnlIK2FaNy9jWk1oN3orRGlNcFkyTk44?=
 =?utf-8?B?bHFTQjdvRXd0QlJHaEtQY1hJWXI3d1ZteFlkTVZGUjdtMjBhMFF2c0wycXYx?=
 =?utf-8?B?R3FSTXNZTVV1eVgrOXAzSmRJMEErZHI3ZkE1SDlWaXBRZ01LejJPeXVQYkp0?=
 =?utf-8?B?SVNkdTRLbFhaMTdKYlY5U0x2NncwUC94NExLcnRRTnYzdzVQZ0ZYNmhxRTNP?=
 =?utf-8?B?bUZqRTMySWVDODloRFRwNWppODBGck1GeWg4KzRkMXUveVZRelhJNGw1MDVz?=
 =?utf-8?B?ZDlFZDdKN3JUYWlXSXRXUVNwTDEwMGdzOG91NmxMaE8vNlFuTGppZzJvNUlI?=
 =?utf-8?B?WVBEa0QwOFYzVExLNG82d242UHlZTTcvVFBzblRKYjJsTkNFWlcvaFdyb2d5?=
 =?utf-8?B?NHRnVCtobWNKT0NSdUtyRlloSDB1ZkJmT1U2ZldKVDNmZGp6cTFXV3c5Sncw?=
 =?utf-8?B?NURDMjZZQW83Y1hRQWVTTHdqak9JOWhZMFRoelhpYUNOMVRYN3p0WUdxM0lP?=
 =?utf-8?B?ZUpYdGQxU1Z4bUJGOFNzY3Z2VnEyM1VsWThQM0FqRWxPbnU0RVhoL3crVTBp?=
 =?utf-8?B?MWRoWWdiN0UrNjVUc3pDQXBIZFVNMkZ2V3AyeEFCODNsZWgvMUpKVWRpWm5z?=
 =?utf-8?B?Z1l4SzJVWG9vazhWT2xkWnVIY3dwZ09sTGR0bnhvOURoM3lrVnlkMUhhVTl1?=
 =?utf-8?B?Ri9kNCt5TFBlTVNqT0wzcklrY3ZyODMwT2NTeWs4NkEyRWsrR1ZGVUZxaWxT?=
 =?utf-8?B?QkVaSUZzSkdFTlRyY2VWNVhmeUxMWEx4YnJVL0ZocktXS3h6MlNwTGJDdWd3?=
 =?utf-8?B?Zi8vUUFHc3BoUjJ2bDRDVE1aalZFRm1jTGN0dXdjZEM3SkZyOTgweFJCYmcv?=
 =?utf-8?B?YWJ4a2pSd01RZDdTaExqK0Vud29XWis2RXE1clhGa25XOGdpK2c5RlBFdjhN?=
 =?utf-8?B?K0ozWDZCbFBpYUdtNVljNG43cGxRMFVhNFN0N0pRTUJRRU9QZmw0aFpOK0g0?=
 =?utf-8?B?dmlEMzJoTktmYzk5OVMvTXFtNW9rUXhPaG9TN1RpTUxGSnJsM0VUT1lQOXRQ?=
 =?utf-8?B?TFVvNURYdzhaMjdQTFh1RERDMkxheEl6SkdrcCt0OGJZOXlkMEIxbUdGSGNB?=
 =?utf-8?B?N3QvUVZlWm4xWWVQSTJjUGVzSVFxbGlyakFKeGwzeTExM3hMeXNmK1Y3bVZD?=
 =?utf-8?B?bnRLZEJnb3R4R2EzS0psdTBkOG4wNWs5dTJFY2o5NUZWd1IxblBySlN4ZE1a?=
 =?utf-8?B?aGhIYyszUU9OU3FISjJ6SEF6b3hRQnZ2c1M5MGFqc2pnRlRJd1hQc2pqUTBJ?=
 =?utf-8?B?aVFoOU9OOFh1blFpRDN3aWUwZG9CczVOTzdJR0J6T3ZkNjFZMktyUXZmaDJJ?=
 =?utf-8?B?REtGaEVuQ2x5K3hzWUpHR0JSV2dMWHRRWUNTb3FQdzNmc2tobE9mZGVlcW96?=
 =?utf-8?B?YXphWG5IdnRZSWZwVXhkbmorNmUzL3F2RncwY0N0eUJoYmZMbmxyc0NkZmt2?=
 =?utf-8?B?ZHRkZDJ0ZXJzWlR1dGhzblI1aTd4cVB5UERoZVNwM1VRRmVYVHdEOW1ab003?=
 =?utf-8?B?Ty85MHFWNVUzTFJMSnM0Q1d2bjh3Q28vbjVuaU0xUWxaaTNnUm9rNFc3T1g5?=
 =?utf-8?B?aWJyeHpMTjJoTUFmcy9VaUtQelduWUE5TlZDQi9aOWpnMWorQ3FDR0FUakdH?=
 =?utf-8?B?NnZRUmJmaTJSWDhNd0hPRFZhdU1mU1JoT1NNU3VFV2JudE40TnBUMEJ4dHdS?=
 =?utf-8?B?TXdpQ2s1R3dPcS9SazRBY2prNU11RWhvUDZYZ2tKbFgrOG1jVC81UlM0aGFa?=
 =?utf-8?B?WVNyWWJqT25lV2VoNDlydmlGTXhqQkVNRGUvVWhKVnpuY0gzM3dnSDh4eTRU?=
 =?utf-8?B?bUc0ZDVSSkJnN2s1VWU0T0l5c0NVSDNZanpPZTZKalF6VTVwWjNBYi9SeCtR?=
 =?utf-8?B?Rkd2WFhvVUduSm0vekhSMk1PVzh6cm1rQVdjVkxMcUlmRXF6bjRJZmFGUXJk?=
 =?utf-8?B?OGJJRk5DL1lpY0xicHlKRmhKUU82T0hFRVp6SmtqYVIxNVhqYkQvK3Bybm5i?=
 =?utf-8?Q?ro8Uv2aNOYjgguJ/W4xpb6wye?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06176cb0-50da-4be9-f314-08dd1da76bdf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 07:58:26.4884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mc6KEIWXzh1I6ZDPQaMkhizpJI2r68B7Zwbp2pLWWh53HdSNLivMTgERVWhCumF1W85rJlE5c1VbSAkz4PInbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10361

Select the of_dma_xlate function based on the dmamuxs definition rather
than the FSL_EDMA_DRV_SPLIT_REG flag, which pertains to the eDMA3
layout.
This change is a prerequisite for the S32G platforms, which integrate both
eDMAv3 and DMAMUX.
Existing platforms with FSL_EDMA_DRV_SPLIT_REG will not be impacted, as
they all have dmamuxs set to zero.

Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
---
 drivers/dma/fsl-edma-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 60de1003193a..2a7d19f51287 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -646,7 +646,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	}
 
 	ret = of_dma_controller_register(np,
-			drvdata->flags & FSL_EDMA_DRV_SPLIT_REG ? fsl_edma3_xlate : fsl_edma_xlate,
+			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
 			fsl_edma);
 	if (ret) {
 		dev_err(&pdev->dev,
-- 
2.47.0


