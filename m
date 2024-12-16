Return-Path: <dmaengine+bounces-3973-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5129F2B42
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 08:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0F818865C8
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 07:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8379B1FF617;
	Mon, 16 Dec 2024 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="m09XuUgB"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D0F1FF7C3;
	Mon, 16 Dec 2024 07:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335916; cv=fail; b=Lhy8X+QBh1+zbSIl/TTT75MJc8JwkYMvwfYhxNI94y3OhBWllWvGb5qWoeOAlNmq/J7HR/vXlv3W0klp9lQTp7lhmcHcF4KXxy5P7aFbX6Qhe/1NZ/hOcdO9T16l2EhDP5iric8zYkhDGaXxuXlV51P9AGZs+ZPvaJppYugkzII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335916; c=relaxed/simple;
	bh=4RvqRw53/gE8ei8QYh3kZPxplhESxMfoCabtJ/xdZFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BzQhT8Dn4G20IEa0XHgUhb9qsXUTFNtFV5d6xb1VYq6Z88nOzSf55VxNseOoCaiX54qR0hwDGS+S/EHRVqXD48jsD52/gTZ7PkqlNAFklMEBYhHyl9zRemHuQYxWXph3hdQ6D9E+Mvfme4PSO6kHCqu94Hf2y76Q3ZF+bwKhhV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=m09XuUgB; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGoH3fghyZ1GJG5yP0/TnS7+++DOG46JLSmV/EfV1XRYUtCbsoDA57tOcVhBnj4BroQl9fALW1H0WQaPgDS+GmNzdEkbbWHRbVzYM+ls0as2QetVBr8XhOCd98XudqZErzBEXCoYIo6uQI6QoPdCd7tQZ19mMi1qHljZuYKdvwiIyP5Tqui/g+0a06Dh0Jz2Im3CONAkmZ1kgnR6UJP5mCcZzeTDAc96MiJGFLmMy6rTogZqqwA2ooaZsqox7YLUmZYar7B6kCBaKXQZCGTpADIdtOO7Zb53rfs+KI7+/EXOOwIQrd63OokNXLZ/0QOiIxL8hXaFTT9F2yPG0QhyUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVj0tlAE8xUm+s8V2QlwaulZloHv7aYC5xKhXGA537M=;
 b=CMhgZ4FBF9kdwcLeZBsxTsUURkb96UuPT3Yo/yymiW7zx3uUdWkAyoak+UWYo53HQKTo+hvMwtx9zFV2wMXuoMIGncnhW3eErwbPr3NWaRdUBQrfEgxfjvlOf8h7mRMPIizJ9LvL6bF7cS1IJTPC1569f7l3Q1mTCxk/5UWIX6Pnjcs+fdc8NrTdkIsiYb5ZvQ2gjdajUP6X7yqDHEv+vJac9spQxgqABJ5qcvyEEadi6hFbNP+8EXEuwlOQx/AzSUwteAjYgmURdSj/aJhmI8IFx1fyN9yxbfeCidS8QCnExh7T3pTTRq2KykgI3Modw1dAF226ymu0BULDUNFrCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVj0tlAE8xUm+s8V2QlwaulZloHv7aYC5xKhXGA537M=;
 b=m09XuUgB0pl8wRz4DFaj18JOTyiSd0Xs9vMwPeAvdhHSTDcSeX4g8lJyTQa6s63BxBVyR8eYt81DHiPDV6yDpk1axAB4+uIH3QI5Yf6RNi+OaWuxyaWvihrbYS71Xg0S0HLgzasvYZ9IAQbNPy9bRhZKCJ32DZhcycBWnIDqYzUb4KEmDze12UZHJvLS2aU1c0Q7kpDzhKaakz6NogxHYLpSOisIOkkOzDGbCHzlUsVz7T4/CsgWkC7I59tkRmHoNwJCbh/Iful5s3Xb9kttgwaWl5h49RDX2fF4hGIIgZUd4ZyfFsrnXI7hEbaD00GRr//S8Qo7Ag83dIY3Y7QnTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by DU4PR04MB10361.eurprd04.prod.outlook.com (2603:10a6:10:55d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 07:58:28 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 07:58:28 +0000
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
Subject: [PATCH 2/8] dmaengine: fsl-edma: remove FSL_EDMA_DRV_SPLIT_REG check when parsing muxbase
Date: Mon, 16 Dec 2024 09:58:12 +0200
Message-ID: <20241216075819.2066772-3-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0080.eurprd04.prod.outlook.com
 (2603:10a6:208:be::21) To AS4PR04MB9550.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 866eec43-0fd9-418f-f2b6-08dd1da76cd5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nlo1S0N2RjNVdjhBdWNyQnQ0MUdqWXNJSUlqRnRxajFRNUZjOVU5bVdaai84?=
 =?utf-8?B?cEVTQ0NCVmdnQlJubmpiM2JaMlNFa0lDY25MTE9pcGt1TUJ5Rm1meFErUWdN?=
 =?utf-8?B?U09QZHRpL00wWjV4ZnVmN0ZvZXF4OEg2OG9iZzJjVENaVUpPRFNoeTRYM2Fa?=
 =?utf-8?B?dkY1RzZOSHNLY3VDUTZsNkpMdERrMjhGWUFMbkpXQnE4eGtkWThpSVRBajM0?=
 =?utf-8?B?QXVaRmExcDg5VGViclo0ZlViRHYrVFljbDgzdExKUXppZUdHOGhRWDlXRzJE?=
 =?utf-8?B?a1lyQk5YdTVNb0JVYUlyckREUUE0bkN2cmE1Zlo0TEJ0dFpzU0Q1ZDBSWDJt?=
 =?utf-8?B?U0hzQW9rVWZJOHRuYm41Z0VaUkFZazNlSkRsVU44TmZWdDBnSGZOdTF1Y2Qr?=
 =?utf-8?B?ZFdFbUo3WGJRRHhCVGZTdDJKaEFBbjIyQ09hakVUUkdtSks2WFRZenhqeDRh?=
 =?utf-8?B?Q2pqbEw4aXhsN0hsbXc1cUVNREwvaVRldXVma01lOU1LMktremF4NUljdThK?=
 =?utf-8?B?a2NCc1NrZi82dnR0T0pacHdpNUFlNG9Tcms1dXA1K1d3YU1ReG1SSHZvejdx?=
 =?utf-8?B?R0c3anlqVkJKWm5VdXlVbm5SMk53VnlDTXUxTWJGVmdWOHI1NFhaTk4yQlJF?=
 =?utf-8?B?R3MzYi9MMXJ2SmRub0ZYQWtJYzRmSDJFV09tWWVzejFrVXRseGNUUWR0M29L?=
 =?utf-8?B?MFkrQW16cnNnbVJ0MTluZ1Q1ME9obW1ZaTBsYm9hdmY5UTV2bVovVGZUOVB0?=
 =?utf-8?B?RlJ0dWlpMnZldlVpb2pRR29pYXVIeDZJYkR6NDE4b1dEN3ZSc3Z4bTJRdHJy?=
 =?utf-8?B?S0dyZVV5bzFsOFFvOHdWdThFaExPNDR6TXl0cmtscTVmaVlQeEFwNTdvb2la?=
 =?utf-8?B?bnRVWUVsTlJtOTR4QndrbnF0a2YvZjlpakx5SVZqUHRkOWpiblhRVVU2dUZS?=
 =?utf-8?B?OHdpQW5Bd0JkSXorNFcxMU80L1dxajNaQmJGRGtjY2JVSjBHdVBSQkEvaW5O?=
 =?utf-8?B?UUhtUWNSbU9rWjRzdDFaMG9sYWw3cng2YWd4UXlER1ZvM1lCeXcydGtJRWdC?=
 =?utf-8?B?b3plTHd4S25rT01CNGVKcWVpVmhhVjhmMEx3TTVrNGtMVlVTelZYYk1WWEZj?=
 =?utf-8?B?ZG50eW5TVmFudk1ZQk5vM21rQkJUTzV4UTZQc2V1WkFETnpza0VESzdDOFVo?=
 =?utf-8?B?WC9UUVhyUy9aMktua01tUTJFNk11S3AyZ1djL3pYQUc4bU9Cdkg0Zmg3emdF?=
 =?utf-8?B?TGtuKytDaGJBcHI2UTU4TkpGWHlEaVFOYXRIaUxKTVdQTWJaZFZ4Zk13K2wx?=
 =?utf-8?B?V01xa2lBS0YxaFFYMU1kTkpNQVkwUTZJM2tjQUdFQldKUGZ1azJRU2JWbnBL?=
 =?utf-8?B?S0R3RFNHbXphWUlTTWpzYzg0SUw2dEg1dXNES1J3VmFPQXZNUlo5K0lYZXJ3?=
 =?utf-8?B?SmdKSUFrZnJDOGk5WDAzL0JZNmR4bFBzTUtBSlBGNitXUXlyZUZjY2djYnZn?=
 =?utf-8?B?c250aGFiWjFObUVSc1g5OFVqSUs5SVEzUXl0em1IWFFzYlpLcmp1Q0VIZE0w?=
 =?utf-8?B?MWJpbGwvY2JLdENhSUxzUkYwaWd5WWdHTGJzMVh6SlROZVZLTzI1WWlIQ2dO?=
 =?utf-8?B?MGVCbnZiTk9rckdpSnl4bWNwUVJRMlg2MFVHRGk3NG4vRDJwd0hvclBQSHNI?=
 =?utf-8?B?SXJNOVpySDBtRERUc2ZNQkdteDFMb2U0NXBoWDVwRHNYdzdIc2svVlZ3N3NT?=
 =?utf-8?B?d3lKdW95Tmo0bzc0bit1Q2JIbHpMMEhJV2tuOFlEc3dvWnE1YTlkYXFnSzdq?=
 =?utf-8?B?a21VcHJydFMzK29NZkI2djlaSkM3TnBYU2VEZDczckdMRHRHeHhGUi96bWdO?=
 =?utf-8?Q?Px1SDxccGWJL9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXp1Z1Q1TUJZczJhajF4akFmb0M4U2RPTnVYbzNCVUIxVUF0VkRkT21raDcr?=
 =?utf-8?B?anY2aFIweHp6RlNWWnZiY2lpQlQ0bmcxQk92eFJGQ1I0R1JYTkpQNTM4eDNv?=
 =?utf-8?B?VUcrdmN1NDZTMmQ1K0IrOEc0Uk5GYk1pYzlpQU5JaVZrYTBEb3VMMENwU2w3?=
 =?utf-8?B?TUp0RDltcU4vbXdsVEUzYlU1dE9iajhZcGFwMnJYNW5PTStocUVtMDY3Y1RM?=
 =?utf-8?B?NWxnQzNYWUJSV216TkZId3E3Rlp5V216Q0NTaERNL3NTY09rbTFVeUwrVGxS?=
 =?utf-8?B?ZldaR3FIR21BVEdDdmtGd21YeU50ZGloenc3d3dlaVdPV2tqaDlnL3ZYeFZz?=
 =?utf-8?B?SWtzUml3U25JTkk0a3RBZUdXTkc4SEFPNytMNkVncUVUNjdybCtEWUpxN0tk?=
 =?utf-8?B?Rkw0eXJwM0wzTGxvRVc4a0pHZTZIc0dGM0M1ZFpLdG5HZm44M2ZwcmxScy9l?=
 =?utf-8?B?bTZveTIyR21qTDc3blFtRWYrbWdLcFltbnJERXp2YTZZTnFFWGU1eVZibE04?=
 =?utf-8?B?N3RwS25aTjdFbzl1amE0UjFQNWNkcVpIaldRdkhza0Y4MDExcWNwNm5iK2s3?=
 =?utf-8?B?TVpOSnJlYTV6bHYwaEdaU3JJOWx5NVFwdHprak1DZEV3aUVrVEl2WkZhRUl2?=
 =?utf-8?B?NGNXd2ZXNjhZRFdMRzV3RU9hSTZMbkpRNFpaOC9XVVlSSEVtOTc3cXFBTGpS?=
 =?utf-8?B?QWVnNVBRdFArNjVpcFVaRDlacHF2d2poQWdmUGtrRGdNQVFCMnE0SGpXSm9Q?=
 =?utf-8?B?Q3lpNTNSdTFqSnZ6eTloNDBIL0dzamg5NXZHTlF3NmwyN3A1UjFXcVJESThm?=
 =?utf-8?B?U0o2bW1tUHQvVk5aS3NyZmkzbWVacnQ5Y3A2T1ZEVzdGaGZyYjJ4MWRPb09N?=
 =?utf-8?B?TlJCTnB6YjMwZGZzSHVEUGYyRk5mM2luVDNHbkQ3eTFUdGhjcWVwUDJFMGpp?=
 =?utf-8?B?SSs2dzJZMDAzWGhHRnlxRXBQblZISnJBdHQ4Zk82NkpRTmZDS3Y2c0U0UVg4?=
 =?utf-8?B?dmNyZ0ZranFrSDlSUktBUjd6UTEyRnZCbStlcW83VkUvVVl5SWpTaFgrQnAx?=
 =?utf-8?B?bGxWUjJlcDRGWFF2d1RCcm9WeUkyWnQxbGIwQUU1V0I4d1hJM3l5MW5lUURY?=
 =?utf-8?B?Szh3NG4wb0hYUVRUc1ZHYXlhRlhZVGVDQVpvbm14U1IxQU9hVVU4cjljYytn?=
 =?utf-8?B?cnFkQVdXRkFwVXIxcTFFcWpwVVdVUHVZbmt2WVMxT0tpL0h6cGMyK2JJbmMy?=
 =?utf-8?B?Mkt6OW9ZNGlRczVYWmFzWmNkWGpHdUtJT2RNcHphUDk3MFFUSGJ3LzkveWRz?=
 =?utf-8?B?NlVSeUU0TDBDTHRSeE1oQVp5eWNHcWpRMkQ2ZGo3REJFS0t4K3ovN2RlOXN4?=
 =?utf-8?B?enR6ZEl0N0VZLzM1eS95cWxja0dYRG5ZMmRETXZTZUQxcnYvTFVpNDNPQ043?=
 =?utf-8?B?bDlEUHJoZ0g2WVJITExVTWYwQVJCWkR3THJRQmx4c08vN24yN2ZQaSsrYWl1?=
 =?utf-8?B?S3l6N3NmWlFlL0Y5VGphNUNCSU0wOXphcnB3eGlDYkxqbzMyeTJCeTZnakFz?=
 =?utf-8?B?cmNBamRzQkRBVWRqQmh2b0lxY3V3TGpuQTU2SFhRbEw1bnFHSUl0MmZLZUt0?=
 =?utf-8?B?UXloNDlyQlRkVmpIaFdrcVdVNEVpZXpOckIwYjNsVk5SNVcvY2hxU1NOOVc2?=
 =?utf-8?B?OUZoN2wrUjRoWHpMZHJWc05va2RTSktEM3psY1ZLaEhwQ1dGVjR2aG5MR0sx?=
 =?utf-8?B?aG93UzF0czJtNEpDOUpHSTdscFN0MEFKZ1BwKzNyMWJBV01PemNKZjZtaFpt?=
 =?utf-8?B?aEhseGFPempnQ0o1SGpZdkpId2dMNENDNTNHY24xVklUS1o0d1JHZ2ZCRGZS?=
 =?utf-8?B?cHJoUWJnaG1iU0tzVURiRUdSYjg0Y0lXVGRCMWgxLzgwR04wRXNuc2xWeTZ1?=
 =?utf-8?B?bzhlR0RHT0FpOGZpdXd2SU1DWWZ1TTdUYUIyNDQ4bk8rRjh2UjhtYVowOTRu?=
 =?utf-8?B?TldSTzZLSmJQd0JtdDBaNWpCU1k2Vnk0Ri91MDIrWmFOa1FoWGQ3dGZ1ZU55?=
 =?utf-8?B?Z2RITlBaSzNOdHlCSXpiY1Y4TE1qd2NyNU1FemE0K282SURqV2RYRWxIRkhy?=
 =?utf-8?Q?gXQ/HjI7kO+wmzCugCWToiCHH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866eec43-0fd9-418f-f2b6-08dd1da76cd5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 07:58:28.0982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+5rXYWj31qaQPR0c2gtH78QeVe2y3617lPtUBAMuVnXKBVbrF/Vg818P4EJsyTA879gL5K5FIGNDG2JDJevZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10361

Clean up dead code. dmamuxs is always 0 when FSL_EDMA_DRV_SPLIT_REG set. So
it is redundant to check FSL_EDMA_DRV_SPLIT_REG again in the for loop
because it will never enter for loop.

Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
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


