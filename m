Return-Path: <dmaengine+bounces-3975-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B45999F2B48
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 08:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493B218861A0
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 07:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC05200105;
	Mon, 16 Dec 2024 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="av7Ty9kF"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D901FFC60;
	Mon, 16 Dec 2024 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335921; cv=fail; b=SYw/7CR8mpbtWez0eO5A6SdQzre8QwgZC/U3xYPZjTFwHtiImCOtuW9cZOV8krz7OPyW54xA1sr6UPM3gdhaKY5lN/dG6/CAvANzeLRY84u+L3woVDSWFg2/IiVMn+Q3kky7iwfKGVKBlFcHkvtR93YdBGTGQ5Ie7F1WxvEwzEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335921; c=relaxed/simple;
	bh=g0hyPjcqAZkv+r7RgWj/ak9g/4MZz3NBUpdZHO89b9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CceFBi9ObaRWAJDhZG06crnVu1mdD7Z2Mfu/ee111ZeK6m0rORIKjeOPiR/pasvh4owiwKdl9KBdeCFDNyvDlM6XG1h4DiMrawZNK6FxM2DMSNVngNIz2Tixo9O27APRBh1kaWL4kyEWSL7Nv7IOFMjmexKODTBFmFPQ59y9U6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=av7Ty9kF; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kt/2tKbpLFFSMdKQMKiuWDPxGDMok9S0vHpn2PWvttp3MXFGry5uaiHpZAjYH8umom7cHcb1wWc3lhDvpm9milOKPO64fhIDu7HxXOE9b7/S3auHEQjEO9CvV9daKJIMR+M5WMy4eZv4d74dY7luTNCwRuHEzyQDEyWMbSw36QuGC9gf27CRbM1Pp6szud6YOni7EqSuKPUOkrqWxU08E4TRJQegR7YPFOBqoVJIHyItQzde8NzEqNa9/MsdwIDt3WpNAMuRySpPw327Dd991odqyCIDMaWpk28h0hie8cEfQXFvvQdus/glRq5vuFCL26iWpNEmjZLj8CuTg5GXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IYbNyROv4P5mouCNyViMuQSGpX+YC+WB51W6BWVdOM=;
 b=C28B5skTeIJHs1FJSvEK+4unjIaEuaIjnMmVeAC1lXIsmxOqpvKTSYk6yyHK4+aGz2jBHUXlKx9fzWByqf9MSDZI3kpnIZayU62SNrG2mou0fO8cQxDZ4XbDL26IKUH8B3AGi3BmUGkk30hpgd1LdIGr6GyjP9xqRBASuQ+11XTU9JH4jGM4LoIhssVnFicGEJDK0znv7P8hk0u4zHYZodeB0vkefhrus/coPo9yyjeDv63zbWpjkmqcVyU4Q6zwUtSbT1oeA7F0zdRYogthG2+qOU4RCfJzcP1dqbo+GG0Ptv+dc5IVfx/a5qM5Vyb3TRMI5L4NHTwysV6upFtk+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IYbNyROv4P5mouCNyViMuQSGpX+YC+WB51W6BWVdOM=;
 b=av7Ty9kFwJ+S3MN9SFgPQD+31trjXy3TB/7GDvELP7ov1GWWrKjUGLqaIZuz0vU9FLPtCwZTfpCbMYSJNcEf0RHVxlNFYdQESF+gbfPXAPyEPmlRAg5qZ5+QU8qHRS/SDxQW0e2AlMVTXmQPmavDuzBdLx8iD7POdfGdI+PlWITH84VFUv9D7qAsJBQi1dayx7GAK1NI7alB12r/aDWY8wVhLOYt4h13TlLNIRE8v1FUEqmPer8CdE5o1471leyF1KaJmg6me+MK6T9sxv69+lGQEpsYfeK4ap+oYiBxQ88eBFpW/4pdSYuAjt3fC+rM3R1ci9s9oj2lcwjMrKvOBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by DU4PR04MB10361.eurprd04.prod.outlook.com (2603:10a6:10:55d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 07:58:32 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 07:58:31 +0000
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
Subject: [PATCH 4/8] dmaengine: fsl-edma: add eDMAv3 registers to edma_regs
Date: Mon, 16 Dec 2024 09:58:14 +0200
Message-ID: <20241216075819.2066772-5-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0086.eurprd04.prod.outlook.com
 (2603:10a6:208:be::27) To AS4PR04MB9550.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: a9d302f4-aad1-4952-1db5-08dd1da76ec1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZktzbEhlVkx4ZFI3amZhYmFRS2VXYjBscU5yTEFyYk5QTkRRTHYxUkJkaHBS?=
 =?utf-8?B?aTM3NGJFZVJYVHhmZGN0b0M2YWFDSFlRMjZWVnVTVTVGTWhHSllmYkYxNzUy?=
 =?utf-8?B?NWgrdzhEVFQ3c1hYOEJWS2s4NjQwcWo3NDZScGkraDRHbmJNK01KS3ZQYW0z?=
 =?utf-8?B?a0R1RlVRUkhBeDlIekNIUEkvV3lLNFhJY3NOYUJVRmtvZDN0aWZtc2tSZE1y?=
 =?utf-8?B?ODlKaTI1TXdxQWdqSjIweDVpVlQwVXZpQUtJbGd3aFZBTWhZTU1mb2c1ZlM3?=
 =?utf-8?B?KzJYY3k0VGVQakNPMEdoR1pKZ2VHU0lhQ2d0MTRoQkZqK2dGdVBYb3Q0bXg5?=
 =?utf-8?B?VWVxMklBVDFKUWhqQ0FBZHVudVVPelV6YVFSVmxVSEI2dTA4UUVRWjFITzZQ?=
 =?utf-8?B?aDlVeWhqaGxmQmdqc09DVE5TNHZuTGZGMlArOXJ5Z3BESkpUZ3JjczF6UVF0?=
 =?utf-8?B?OS9jSXhuN1l2NGVXY2RJRmxzdGJ6VjkwU0RaUEpTdUx1U01lSzZFeXdBSm8v?=
 =?utf-8?B?eXh3eWpVUEtvNVFSaW93bVVLZnFiaVh0bUw1UEVGQW1uZzZmT0x5VGtJeUg5?=
 =?utf-8?B?ZzJBSlNDQ3Y4WWhFVUNtNysrL0VyMUlYOHVKQXY1UExBUDJ4N0UvT0pxN2FG?=
 =?utf-8?B?aHV5U1krUUNPeDdjOWFkVGlsd2FlNk84QXN5dzlsdjhaN1BlS0tFNDBrZXd2?=
 =?utf-8?B?dmhPSU9oOUJLTjd5dElzaGFyeERkU1NMY2RSbWFpM3ZieE1IV0tSaktTYXV0?=
 =?utf-8?B?WmY2K0t1eW5oUEF3c0FzY2dQaG5RQVZBeWNlY0RzTGVSRnhoa0x4VVdVVjJw?=
 =?utf-8?B?UGs1Ykx0dGIrQjZIYUVNOGFEamNqVzdKZXNpbmVzNHJUYmJXaExsNm8yRFF3?=
 =?utf-8?B?OVpORjhhcG1McHFJaEppZDFpOTIzS3g2bm9hcWhjRXJOeGJsVWpsY0kwYVFO?=
 =?utf-8?B?a3NxRkt2VVczdFhpM3B0V1BlREJFemQ5UWZZMEJ1R1l3bDRkTjlPTGhoRXNV?=
 =?utf-8?B?QlNGNlA2ZzNXTVZhL2doTXo2bEVOSXlEMngwNG5Ed2lTQ0pvditSMDhCV3dJ?=
 =?utf-8?B?VTFzUDdUR2JmL0tmYzNBQ3cxcjBjRHpvNFdUQkZ3aUJaZm0vS3g3YlVRUUtk?=
 =?utf-8?B?d2U4YW1NaTByaXF1Y1Z5U1g0eVZEWnZOTmEyZWtpYnVNUGZFOHZDK25YcTRR?=
 =?utf-8?B?R3lUbEw3c2dwNUFTVlFlSndwQlozQW00WkZOMkI4WnVUOEZPL045N3JSRXA0?=
 =?utf-8?B?OEhjVzBKUmROcklxakFmSDNiTjV6RzdXbC9GN2Y4ZVZTc0xWcUI1bHR6dEhZ?=
 =?utf-8?B?dVhoSGwzcVZTR3VEOHBIREN5ZmtkTktlcUQzOVU3VmREdFBXNVNVSzIyQVNp?=
 =?utf-8?B?S2grd3ZGZmtOakJqcW9FUVBuNXF3S05TRnN1T1BJSTE0ejBaNnlnWTRlUjY4?=
 =?utf-8?B?elg1ai9ia1VyTmFLcmt4akJCZjRkdGJFQmpicFBPbHRKK2dJaTNKNGFUQnd5?=
 =?utf-8?B?cVNwSUk1ckVHaGJGREJOVkZvMmZWRkZXUmhBcGZ5RFc3d3Z4WGVqN0JFdWIw?=
 =?utf-8?B?OURYKzd5R1BYNzlHekpxMG00L283SU5kRXNzeVUzdU4wSnRFamlyMmNXTnN4?=
 =?utf-8?B?WUZNWHhmMmwyVmxpaEVlMG1hTXhnNlFaT1dQbHVyWXkyZGM1c3krdm11SmlH?=
 =?utf-8?B?aHdRWlVHajNVaDBIMVo3QVh3ZUp2c0hRNVdvUjlRSXdqMVZIZW9oRVRVcGpo?=
 =?utf-8?B?VGdqTlZNSUM4Umtvd2Q3cGpjQ2kwalVIRW9HRTVHZU9Ec01wdzkwTE56Q1gw?=
 =?utf-8?B?UmErdHh4dDdJNUN3cGlFcUtzRXpISFRhcmJnUTFJbWxSWWFWc0ZUWjYwZWlZ?=
 =?utf-8?Q?BzhFJGP0+6P0r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHpxZDBvQVJQM0FBVTdPUERFYVhRczJudTZXdlFWVGV6VUQ1WEgvTmhveVdr?=
 =?utf-8?B?WjVVNHd5MEI1ZjdWeHYxaUtJa0tLWUpXaXpGbVY1c3kzL2p0ZHdVeDltSGJZ?=
 =?utf-8?B?UURPZUVZNUgxTHhuS1NPdU9yYmNRL2svR0tFMTlVa0xWUlUzZWxNMzJMVTFY?=
 =?utf-8?B?ams0MXh6cFR1L2sxRVJiTWl1V25TV2R0TUw5b2tzeHo2cTNDelJwRHZMM1lL?=
 =?utf-8?B?WXZPWWdmTVZ4L3dFQ00yd0FCckZCN1ZHRjFpeE5CN1ZpaVlVTXVtR0dkS3c2?=
 =?utf-8?B?NWkrRTJjMmVQM1Z5eDh6c212SDZtTThYeVNTWEdTcDh5OGNPMm1JS1lKSXRz?=
 =?utf-8?B?WHZYQzlUbG9aaGh0ZkYzbFdjdXkvRWxJU0YyTjBhWWpKbFRSVzM4RHlpaG10?=
 =?utf-8?B?WHlMT1RabVJBeCtJejRMZitJeVovQUR1UHhTeEpoQ1g2cXdyN0Q2OVdIU3FF?=
 =?utf-8?B?U3ZwSG5iTHp4a2tLQzhBdE54KzVSdmszV2ovMkdnWFBPMVdJUU5mMzZDckw1?=
 =?utf-8?B?R3hrOXZNdk54aEJkWTVQQmdmNzlhd2JNRFFlQkZmYnVsUk1Udm82WFNWQmZy?=
 =?utf-8?B?M21VSEpuQ0F5d0lCaVIzblRRWkZYd1hVSDh0bkhXUlVnR0lqSy93TU1jY2Yz?=
 =?utf-8?B?TTNLYVNXYUhCQURBaXlYS2ZGeklDZ3U4RzgwWkVHc1hQRGV1K2N0TitEZCs2?=
 =?utf-8?B?Z2gxNGFxczVGcnVSNlhNdkNnSXBIMEp2eFF0K3Nqa2xaZXNBbnE3MnY3Qll2?=
 =?utf-8?B?RlJvK1B3bGMyWlpOUG8wUmExdWVwWHQxRVNMZ1pLY2ZHdzVkREpMZDY4Ujha?=
 =?utf-8?B?dTRCcEFXZFg3UmkzRnp4L000VkhVemh2b1B4bmJ3WjhjRmJneTc0ckFRaXVH?=
 =?utf-8?B?VEhYRmcxQ0d3bEt3Q3REYnNaOEM3dVZIdHpvem5kZEZjUjZkdHBVQWtBcktF?=
 =?utf-8?B?NEZFdFZqY2pVMFZFbG9LVGs0ajl4bkNJSFZ4TjFxVWVsMXUvbEIwRnhnallC?=
 =?utf-8?B?QVVUVDhuVHR4UnZJQk13a3IzVFpjRU0zVExHeTRxWlhvOHFsVE9uRnFGellR?=
 =?utf-8?B?RXRLb3dYQjdMMHgxODFhbi9VVlE4Q1gxZDVLOGVGRkxTcXdiYXVFRlY5Y3RS?=
 =?utf-8?B?Z1pIOXVROE1kTkxiYnY0OXpxU09VbHptTE80STBLQWRzVFFmSGV1ajFnQml2?=
 =?utf-8?B?VDh2b01RVTB1RitVZS94RVdTdXIwdUxhQzRzQ1ZNTCtlUjdCT1dVNytXc0V2?=
 =?utf-8?B?SEFDaHdncUhGY2xuakI2bUFucjdoUVEreUtIelE0SzkzN3RjZ2xPV0tNSjBU?=
 =?utf-8?B?L2NTODZvNi9pRlFSSEoyTEE1Lzc0eXJETUNzdmdsUVN1USt2aER2UUNOQzRy?=
 =?utf-8?B?WjVBVWVRR0hQd2t1Vk9xNWM0QktpYk9mWmRrb3BLZ1BTOU4vN05aSHQwaUFZ?=
 =?utf-8?B?R3YzdW8zamk4R3BBdUF2WGJNZDB0dmMvS0xtWlZ5ODBkalBXWlVWSU9mc1Na?=
 =?utf-8?B?NUR4RHVrSkVwY1FZQnZTaUkvditXb085UmtwNnZkVDZ5WXE0Q2xGQVpiWmt0?=
 =?utf-8?B?WlJQc0xWSzVQOFA4d0xBKzNlSjNScXEwek1qb043S1RML1lCSzZHV2ttWHpM?=
 =?utf-8?B?TDlVMnUrMHM2TkU1elRFWVNmWlFJRkF6ZGliVHhHV0RCQlVydFFYU01kTjQ4?=
 =?utf-8?B?dkhXN3FlUkViUytIWHNnMzNwMGFOMXJJT3VQZTNPdEt5VjJMMHNwY2pnTHlI?=
 =?utf-8?B?ZEQvU1Rkc084MEUwNHl4dU83SFBEZmlKWElGRHQyV2pSTDRjU1ErV1huTW1r?=
 =?utf-8?B?b1BJMlBWb1dKQ0Y0RXpuRWVrcmlBdUhYR0NZbldoWjBObWdFMG0xNTNiQ0ZE?=
 =?utf-8?B?L3gzNVBBdXFZTmxGWTFMWFFJMG1jUGVaRGVZSDB2SjJERjllMWZsYk9PTzlN?=
 =?utf-8?B?M1RaNkZCY0t6ZHFMU2dNR2lWWVdrdGc3SkZ3d3hmQ0tGRldBTG83NU0zS0cw?=
 =?utf-8?B?NjdpdmRKNXhmVldzdmRxRVVEdFhIZnV6NlJNeE1wK043ZUJVbENDNW9wVDd6?=
 =?utf-8?B?NlZKR0kyVzVKNTduakFpemY5dTNEeFN3ZS9BZ2VCd0xCM2tITEliUmVsNTlq?=
 =?utf-8?Q?c9XOHZaaeb0WVN1AeiqyCwKTd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d302f4-aad1-4952-1db5-08dd1da76ec1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 07:58:31.9032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhbQ08t7TeONy0YOmcWECUI7mp2xnNFyzRm1+o/7lxYOkxwAHuF077DweJq51uHymx8NZgWyNd1u7Bdo5kIzxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10361

Add edma3_regs to match eDMAv3 new register layout for manage page (MP).
Introduce helper function fsl_edma3_setup_regs() to initialize the
edma_regs for eDMAv3, which pave the road to support S32 chips.

Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
---
 drivers/dma/fsl-edma-common.c | 15 +++++++++++++++
 drivers/dma/fsl-edma-common.h | 11 ++++++++++-
 drivers/dma/fsl-edma-main.c   |  8 +++++---
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index b132a88dfdec..62d51b269e54 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -44,6 +44,11 @@
 #define EDMA64_ERRH		0x28
 #define EDMA64_ERRL		0x2c
 
+#define EDMA_V3_MP_CSR		0x00
+#define EDMA_V3_MP_ES		0x04
+#define EDMA_V3_MP_INT		0x08
+#define EDMA_V3_MP_HRS		0x0C
+
 void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
 {
 	spin_lock(&fsl_chan->vchan.lock);
@@ -904,4 +909,14 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
 	}
 }
 
+void fsl_edma3_setup_regs(struct fsl_edma_engine *edma)
+{
+	struct edma_regs *regs = &edma->regs;
+
+	regs->cr = edma->membase + EDMA_V3_MP_CSR;
+	regs->es = edma->membase + EDMA_V3_MP_ES;
+	regs->v3.is = edma->membase + EDMA_V3_MP_INT;
+	regs->v3.hrs = edma->membase + EDMA_V3_MP_HRS;
+}
+
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index f1362daaa347..52901623d6fc 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -139,10 +139,18 @@ struct edma2_regs {
 	void __iomem *errl;
 };
 
+struct edma3_regs {
+	void __iomem *is;
+	void __iomem *hrs;
+};
+
 struct edma_regs {
 	void __iomem *cr;
 	void __iomem *es;
-	struct edma2_regs v2;
+	union {
+		struct edma2_regs v2;
+		struct edma3_regs v3;
+	};
 };
 
 struct fsl_edma_sw_tcd {
@@ -491,5 +499,6 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan);
 void fsl_edma_free_chan_resources(struct dma_chan *chan);
 void fsl_edma_cleanup_vchan(struct dma_device *dmadev);
 void fsl_edma_setup_regs(struct fsl_edma_engine *edma);
+void fsl_edma3_setup_regs(struct fsl_edma_engine *edma);
 
 #endif /* _FSL_EDMA_COMMON_H_ */
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 0b89c31bf38c..cc1787698b56 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -495,10 +495,12 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (IS_ERR(fsl_edma->membase))
 		return PTR_ERR(fsl_edma->membase);
 
-	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG)) {
+	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
 		fsl_edma_setup_regs(fsl_edma);
-		regs = &fsl_edma->regs;
-	}
+	else
+		fsl_edma3_setup_regs(fsl_edma);
+
+	regs = &fsl_edma->regs;
 
 	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
 		fsl_edma->dmaclk = devm_clk_get_enabled(&pdev->dev, "dma");
-- 
2.47.0


