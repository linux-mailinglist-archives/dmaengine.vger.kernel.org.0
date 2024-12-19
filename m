Return-Path: <dmaengine+bounces-4032-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEEA9F7845
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 10:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AEC165FF2
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 09:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AC52236EC;
	Thu, 19 Dec 2024 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="b3HT/8LD"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1015522332F;
	Thu, 19 Dec 2024 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734600065; cv=fail; b=cfd9EuhP8QNr66y8d3k+dOkVF9rDY8pz0rffFehsdH2Q/xl1iNHM9MdJw6IlsPXiE/GFsf3RqPYQoCHGU/i/RSzWDe6ezUEV2cPc90oBOwXAF+y7tDYnmPQ0qSrWMJLga473ddClGI0iZE5puuGx4RZcdFrODH/G4DIferG8RQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734600065; c=relaxed/simple;
	bh=98XY1a7JJVwiXnOcAyieAc4D9SnwiEirbyAuDC/CiBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oy3P5ksLUXqHvDgB6Ii5nFmS0UVJjFHMYrdmUtu2xLNMyLKq8D1GoVj0T39XhBhv/qVrc1arUt/u+b/KUlcgJDWz3AlZiR1oAoCDDN+4RUrjbeP79oZ3nqUTWwOHwSwgKOFCKfuq0ivI/C9N5xA/D2POH0TpT65C921k0sI7ljU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=b3HT/8LD; arc=fail smtp.client-ip=40.107.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKfRgk3oeG7G9cmgCsImTtkuENHpWDjGqF9JIVZ4bnRGBXRS2jPQnRnIw8RjKOUnOlIrejiFmuA/ucERbUfDt2gzMOtTp+CzgSdw2aRkGbEggD65WOOWMm33Zyjg+8cwyl4jkjzGVqZvIrC2OxDThRe1qcwdT2iRtLTcqxx2XgF45iatxnVOHwf8FKR8mb13WQ26LvG8Z67vOARaKdIX5GLRsB1d1Qq7nN9vgFiGwM1mhrTcbIh499IJs9D5Qa0QHngcHNOw6Qady3iK8jm/UwoQK8+aQcLqk2wvxsFDFWDC8eThGtAKx7NOuFBpJwubwQ+FxLWIAm7CsVTS2xCS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CmmJJtzZ4GKvoSl5NZeQ2TTqc2zau2UVovMX1/ogI0=;
 b=W/w3FxJ4StDjAo0D+Hqa88IuJ2mQGm002uFvBjeEnQ8mtkbLsNn4uoIMlVLkrlUZHzurOrBoIosp0OkpmgSXltVagkuaBu+BpnoSWyHtKJUd6AtRGAYzYiB5UI1XzA6wnCB4y6PdkQmpsFxAyJ65vLcC74K5EzazlX7WKwR1ar2JhyEVr6D6YV7t44C3VEuzeURZYR6QSerlnVTS48ZCDyRp9PBbd4qVtIc+xe+t/LfcNBVfXRNqxuAVDKO6ejo/m4cinjYQXG/qfn7R02rft9bsx0NSnYLEVbOV0diLcjKSFpzXYr7CkbZeqelvJi+OWMKc8AZVSJcfosGLm9FBvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CmmJJtzZ4GKvoSl5NZeQ2TTqc2zau2UVovMX1/ogI0=;
 b=b3HT/8LD8xmvXnyYl8/jV9M8A5w7nTvwG8qp/MY6pMs1uS6xcpv9jzVGGHJl1FejQ+GMiEezzEZ7m0jLmIe6zamaMat4LKdBPMuTjne3daS3LKGgZye4U1voci4W25cJyOjwU6U2Cxtkk6bdWrKlarPhnTMN9RtuBerngEyADHyUkcmKOy0MclGzJ9AGwtyPNoN7hZ9hVeAbP0IjrT0RU1fhjrml6aAEyGlNrLuMFbqwvTh1YAZSG7QtRUAQwLKJH5M0s3jKKkVl+hXNWYhOlrTZcVthwOPSQE+nudhpwUMOsAlwCq/H+5EBYwVHBFQ7td7tJYR2Y2CQEN1s/G02RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by VI1PR04MB9834.eurprd04.prod.outlook.com (2603:10a6:800:1d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 09:20:55 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 09:20:55 +0000
From: Larisa Grigore <larisa.grigore@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>
Subject: [PATCH v2 2/6] dmaengine: fsl-edma: remove FSL_EDMA_DRV_SPLIT_REG check when parsing muxbase
Date: Thu, 19 Dec 2024 11:18:42 +0200
Message-ID: <20241219092045.1161182-3-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241219092045.1161182-1-larisa.grigore@oss.nxp.com>
References: <20241219092045.1161182-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0212.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::19) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|VI1PR04MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e6194e-e954-4e3b-f61c-08dd200e70ea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFVUQUtVSk9uSG41OVRXS2VaSlpqSFBudXM3bE83SlFaTXNGek9GbTZZVXRp?=
 =?utf-8?B?azErbTNPVGFwb0hSSzNVUzZWVnIrbjF5YW8wNFJxTXVDUnF3MnJIYTJ6SE83?=
 =?utf-8?B?ck0xSDg4REFEM2w3U0pMaGJIZ0oxVlFkNDR0TUZZRHBtZ3MxVzhmdHFNOWNS?=
 =?utf-8?B?MWsxbk0vb3hDbkJOREM4eEpEaTNqODRnVWlqM0UzbS9TWThNQUlINWlwR0pT?=
 =?utf-8?B?TllFbGRXRGU3SnkzdzRQdEFHR3lxZUZNZE54ZCtMdnRlVGdnRk11Y1BYeDZX?=
 =?utf-8?B?S1NpZ2ZaclcybklHaFpIOURGWTVFczVJUTFOek00N2dYeTJCTmdPa0hVZy9V?=
 =?utf-8?B?V1pzMUhMM2cwV2NQcHlJdCtMUmJTN0tOMmt2anpaQjBRdDVhaXF4eGxJMUQ3?=
 =?utf-8?B?VStnaWJkdmo0aTdsU0xmellKQlZRYmFJRHJHZlpzRWEwSWQ4WE8xUEI1UTJT?=
 =?utf-8?B?c2JCK3BiaFJtSS9xL1pYcGNLZDZEUzB4R1VFN3dHZWdPZGJCWURvNWF1K1Jm?=
 =?utf-8?B?TVVDdk9Hb0JlQ1J5TEx4YTQrQWsyZVFVQTdocERRMjdteWRqMXBpbE5OaTkx?=
 =?utf-8?B?TlhOY1RrZEJkSjZqczF4ek9iQllTOExZa2dVeHJFNUVXcWRrMXFaL09xdm1h?=
 =?utf-8?B?Q2F2T0M1UCtVNkw3T2puaHA1MTROWVAzaVY1ZDlJMkVEMURwWThib3N6aWdB?=
 =?utf-8?B?SDZvdnVlYU52Z2RiWkwyZlJuYkUwS3R6QmFIMitxVkczaVRZQ3BaS3RoU05p?=
 =?utf-8?B?UE5pN1ZKVTNZYWExeC95QmRLSVZYYnhObStPYXJrMForSlU1R1FkOGY4c0tY?=
 =?utf-8?B?T3NoRHJGSU1oTnZmNHpxeTBEOE13b2JHemdUNDlwek1ock5tdzg4OUNMM0pO?=
 =?utf-8?B?Ulg0RXdnM0tTSXV4TDk2Ulp1amIrK3dzbWZHR0o5QVpCeEp6b0pCcUQrNDhT?=
 =?utf-8?B?ZzhzK0o5bHlVNHlkampEMFpMOFNwNXMxQ2h3L2ZtaGZkYy8va1ZiWEwrbWFX?=
 =?utf-8?B?K3NjV0NmMThvRDQrekxXeEI3cHBSVFhiZkRkMXdqMEpsZ2E5UlBDbHREUkdK?=
 =?utf-8?B?eGsvdm9JdUl6bEtXS0V0eVhtTUhWUFU0V3YwUHdETmJSV1BvT0pKckRrYjAv?=
 =?utf-8?B?bTVMUmgrQ3VZVjJPNkdwZ0d1UGRCWUFvSEFram4xcGtlNysrbFpMS282UC9Z?=
 =?utf-8?B?TlNDUFd0d3JIU1I2WTB5QWdmUFJyaVpIL0tUaDAvc0JJZTFVdVF1Z1B3NDZs?=
 =?utf-8?B?emI2Q2FRUVFMRGxoUFFpMnpkSGw0Yy84ZUtoUXdESkI1VFJlWVNvVFBKM0dF?=
 =?utf-8?B?eUlubWlQRU1XbjIwOW1NcitzNFZEcFBEKzgvY2FSNytxRXdpT1MrbGFrd1hN?=
 =?utf-8?B?VXU4MzNBRndnalFhY3AwRCtORVdkd0d2aDhaY0xuOXJETGZ6b1NPbmcyN1dp?=
 =?utf-8?B?MFRuTWVFZ1VuV2lzd1NDVXBMY1lCbEVVdnFldWxpTW5neVJ6ZDRxRW1lTkhJ?=
 =?utf-8?B?cVJ3MEVVQ2VrUmZYTjNaTWlXdEd4QjcyWGQwR1hNVEJrVW1qMUorL0ozMkRi?=
 =?utf-8?B?ZlZ3emE4d0FMeHorVFVHY2RYME5Pc2k1dTJrNUdUWUt2dEZLejdLTldWeEM5?=
 =?utf-8?B?RVBZVCtKYnFqV09OSFEyTmFBVU02a1ZVZjJvV3oreVh0YW5KS2I5S3QwZDZ3?=
 =?utf-8?B?N2lKMGpIMGtpZGVzZ0hGb2JiMU9LUnlJdXZJUllTQnJRaDhEeDFESlNNTDdk?=
 =?utf-8?B?ODJzNzFqdm5hZUw1eUp0eVVrWk1MMjAxRHNoeTdvUU82MXN6c3ora1pCQ0xW?=
 =?utf-8?B?a0xZT1JJOHVVY0d4STJZdGlmdzRDUy94WVcyZjloaTJWNlAzZklQMVk5ZXcw?=
 =?utf-8?Q?4IyboPnKMVlcG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVR5NjROd3IxaU1hNW9DUzRJYUVocWE5TEY1dkdSYXhZU09abHhIclJGV1pJ?=
 =?utf-8?B?UWNCNnRKMzRBYlo3R25LKzhnYlhBTXZaWmZGRG8rSkNaQ0FuU0pRNmk4emw3?=
 =?utf-8?B?ZUlqWkIvdUNzMUVoZGN6NmEzOHdocFZsMEtWU09UWFA2d0d6UThOUFcvNWFZ?=
 =?utf-8?B?SkoyN1FSNnNvMWtUTlU5dER4M2p0R1hYWG5oRXhNdldtWXJRelVKVEw1eDdz?=
 =?utf-8?B?WkYvR0Nab1RENk5LV2pDeXpuQmw1ODNyRmpXVEpXdUNHS3N1RmFoOTg4V1hD?=
 =?utf-8?B?U1VCT1FTalFEeEkrVXgzTXBWMjdXTnVUbmVVdFBBN3VZTWtmNjlPd2JYZkxk?=
 =?utf-8?B?bWVmRzd5SzR5b250T3ZOU1UzRTZnRGdhckRYZUFZVTc2UFAySGYwZnJHdVc4?=
 =?utf-8?B?R3BwU0Jtc2pzYUZwa2Qyc3ZTQVAwMWF2WkZTNjc5cnZZR0hFSFlRczRXVmJ6?=
 =?utf-8?B?ZzlIZEZnWEE4dmRrM1M1ckUrTVVMYmxDajVEcHQzcHZxNnlabC8zU1p1MXI1?=
 =?utf-8?B?VVU4cjNKT2t3OXc2OUFVMDBqeFZMamVFZ3Bwek1jYWQrOXphcjM0Vk1GY2Jl?=
 =?utf-8?B?MzV2eEFJL0VHT3F5YmF5cVI5KzRGQmpGOHVzNGV2TVQxeFJyeDVyZVdUcG9U?=
 =?utf-8?B?NDRoTWFhWVhQZHpDK2VwUHNJTHpvV3RNOFZscXR6cU5GbVh3MU1hVVZzUmVK?=
 =?utf-8?B?V3hyUUFRamJYNVZsRXBIY1NDUGRaaTM0VHg5Wmp1VklEaFFmRGNTdm9kUWFN?=
 =?utf-8?B?UmgxK016bUQrYWJ4b3dJejM1Nkdtdk0zcUcwNVcrRnVjZzVJbnRVYml1Q0xi?=
 =?utf-8?B?SStpQzlnWkhaa05EUTZBbm1NUCtEWmZMN2RUZVo4aVJ3dXB5NGhkb0Rxd2pN?=
 =?utf-8?B?cElVdlNzRkdTYlBVV1RwM1RmeWNGNmJQZ01Zck8xWnI3RHIxZ2FzZ0dBR2lG?=
 =?utf-8?B?ejVzM1dGNUhmTnFJTnZGTHV0bG4yeW5Salh5b212S0dveWJJQWNSWEo4dEZC?=
 =?utf-8?B?b1JueEVSYXVYaW0vcjdqcWxkWDI0OE5VNmtJT2dCTHhKazdYR3lkNDh1SHd0?=
 =?utf-8?B?VlRKaXNHZW9SZitsZ0JYSmJ1bzNWRy9RYXBzRXhRQy8yK2lIa1ZVcmtSbUQr?=
 =?utf-8?B?OWxaK1d0K3h1a2ZBeXJ6OHM4Skp4MEQwUHVXbEtEbEl4aWxDUlYrejhKaTlH?=
 =?utf-8?B?enFGUkk5UU0xOU9iUWpiR0VzWWUwWHo1WldVRnpHZXhNdzN1SGJsV25xUWM1?=
 =?utf-8?B?b1hiUngvNWxTU0c3c05reEt5VDVjdDE1cUc2WUU2S0ZTR0g0VlNKWGtFS0hk?=
 =?utf-8?B?OEE2VzE3Y0JERnlFc0VVa3JEa3FkK3MrSzVmRTJnVjlmbzQrMzVFeFJ0cE4x?=
 =?utf-8?B?aEJJZzBYTGZ1ZTQvOVRCNEdMMlYyaXFUeEJpNEVFU1BHMitqTFdrMzd5RmZU?=
 =?utf-8?B?WUJpb0NwSXV1enRqZjRibG5wZ2d4bUlKNVhEN3pXTTl4Y2oyM2Z1enRxekQx?=
 =?utf-8?B?VjIyOTdFcHpaS25ucVA1cyt0NlZmcm5kNGZqRFQyeXhRUGM1UlNkb0l5M0Vw?=
 =?utf-8?B?WUc0eDhMZ0ZBa0V2VmVGQ3hqZjdmYVhYTnlDZU56bnpJeW0vUGZ2VExCbTNj?=
 =?utf-8?B?a2NUS2NhdVZYOSs1OWpCWFhnb0IraHRvY2F0eEdmdldYdlV5OWlUWlJGOGt5?=
 =?utf-8?B?RGN0MDlYRk9YVkh4VkpwWDZoQ2xwM2J6cWFkOUZVRUVJaGNYMThmNWljVWZt?=
 =?utf-8?B?VGVmWTVjY1hubFUrelUrWmVjdjN0S2gxY2NLbG5OeG9OZW9Eb0w5aEh2MzBM?=
 =?utf-8?B?NTAwcnhYRmFRWm9vcFZKWWxwNSs5aEMxY3V2SGQ4TjBtQlpsZjNuMFdUNTl0?=
 =?utf-8?B?L1cxRUthR0FBSEVRNllkdklCQjZGQWJoMVZsMkc1cTNmSjlKeC9EMGFvY2s5?=
 =?utf-8?B?aGtwUks4Rms3Tkh3YUVPN3VzMHhxbVpZdU00OGMzQ0NIREdZeVdySGRkV0xN?=
 =?utf-8?B?VU4reUIrYU1pRUtYRFA5WWRUbHRDcGs3UWZ4REtIL2UxamllME1vOUlQM0JS?=
 =?utf-8?B?MlQzenZlT2RoWEZhQVZuajBaam1semZ4eHpoNGdiY1ZlKzc4RVpybm16YjZY?=
 =?utf-8?Q?c8noAdkrdxoLNHjPPfR+Jk4S+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e6194e-e954-4e3b-f61c-08dd200e70ea
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 09:20:55.4900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pbm5icRLRnRSVBOROSKaM8l3LDv9biFxA0sjEMaF+p6iYq9QuXHnDi2iQdqV1KNGkdscdxkfLRPt3fQsykN1gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9834

Clean up dead code. dmamuxs is always 0 when FSL_EDMA_DRV_SPLIT_REG set. So
it is redundant to check FSL_EDMA_DRV_SPLIT_REG again in the for loop
because it will never enter for loop.

Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 2a7d19f51287..9873cce00c68 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -517,10 +517,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
 		char clkname[32];
 
-		/* eDMAv3 mux register move to TCD area if ch_mux exist */
-		if (drvdata->flags & FSL_EDMA_DRV_SPLIT_REG)
-			break;
-
 		fsl_edma->muxbase[i] = devm_platform_ioremap_resource(pdev,
 								      1 + i);
 		if (IS_ERR(fsl_edma->muxbase[i])) {
-- 
2.47.0


