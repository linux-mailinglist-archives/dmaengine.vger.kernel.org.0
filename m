Return-Path: <dmaengine+bounces-4617-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F01FAA4A0B4
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 18:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E95C17638C
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 17:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBFB277816;
	Fri, 28 Feb 2025 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B1jF3Q4C"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012000.outbound.protection.outlook.com [52.101.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD614271835;
	Fri, 28 Feb 2025 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764574; cv=fail; b=kAKsoPvJploEAsG1aBxBniydluJV2tMkriExXJjUBJ3qj+oLz3U/0WjiSCdotp9hufNDqpwM8LMnvkPTyur5D8ZYFmkMFd9p8CDIrTOoY62CzOJogBFjleBHGvOQtWe7q38ANxnDksjC1HAf4fzfPUFTMmHUVGQCnungRvyf8y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764574; c=relaxed/simple;
	bh=w/6ig9TTlYlGZjU/9IyRQXXtqAoYeNQ1F45/b1xO+IY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sT0OalXDALYulJLNkROnltccQ3lYZ6JZg1FRA8/hsTqxdNm4QP7puOuhZn3vLo+CKewl6YQNcxz8P1Q7yMmMg+T1wVF7DHEAsYp/8KsmWrDyPXgUq5qpf1iYgt0iOJ363htCgr1/+SG+DsDHhm1pMgjAt0c+kItmZ72HMTubXDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B1jF3Q4C; arc=fail smtp.client-ip=52.101.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eX1kd5dcw4XLXiOmSiiplVmsemE3QySp7jnYHNcMAPxY7piq9JKg/rKh1jh8k9kfCSOAynQW12SxBG7WePRShmlmf7+aOrwgLcWX18GAEP1QZW7oh4CMIK2prH1relkhecWdMZOdQCUCwaqd+EnySQnCyl2u+oq1B/AUo0QX6f7V6kOOW9XYGuu3z1tabkcV0veOTzoAhpu+k+KSGAl+IrSWiTV36TnYSiFL8s9dYIpocVXBruIGoe+izSi77+66JaDbK6zm8/i6V/8M5zjSJrQbfvNWpRSUJyCJ6CgNXCcE48itUVSqZiKcJx5Dr1vvqCodVeytPFATNk2n/RkCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZnjK2/2KpcCj7q27I1a4AL4XpdjpWbe/vLdOl7/KIg=;
 b=wJ/c0bU2OCwnyD/D2h3OvOILtA/IG9lGnOPyX84sB1gfwiqWqXcAg3EwU3deJte0UgYK85uIAgVL3itlUKTJYQEOw6HdQk8z9tfJ61Ub3wv+A1w4N/8I818fB7BJl+ge1bxbuRGOFIQGdNxs6vWnONKu1UFcJCCk6gpr7yJ+F91OmZyUdxdaypBfbKMCmGiAUKJaGiVvF4hxWerqwPVdwJZ63J0EcMktDxKPFYXsi/O2Ols46UiH1afwihNvk7kCioFS/Tzfxx4vTl8H3m9gwmVybfgEfdFQsPLS8OsMSiWIrP7F+8EVx0hJmIVt2EDvhIqD/+4C+XXGUgrQOsWZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZnjK2/2KpcCj7q27I1a4AL4XpdjpWbe/vLdOl7/KIg=;
 b=B1jF3Q4CnZG9uDzQ1+YtaYajottXZofYkuU/CiRPgydpFwGJK2nD4XBIJy6uR27bt+SvTiqVRp/ajbTx6DS28c+Jnv5uv0Baq2Gmfj9VpRpXsMeu7cZgYK/eyQnxlRQQPgoBkua7QNhkaxwypPzj4Yo0kMU24eDYYOi0hCitfV72imdHXFL22xhHaxpYv8dgKz1NyIBmdMNMIRXbgy+5EbnmHLG3pCWK4YYxQleDE1i8AbkDEX5FcwwoLWehWvE4PN+VQwR+GUGyZusCPHHDknQpcWbRIAr3bFvozb6Cr61EEDK00nprOX0Sg3ZBuol22c6r+nRjEHOg+64J7l9M+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10498.eurprd04.prod.outlook.com (2603:10a6:10:56a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Fri, 28 Feb
 2025 17:42:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 17:42:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 28 Feb 2025 12:42:05 -0500
Subject: [PATCH 3/3] arm64: dtsi: imx93: add edma error interrupt support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-edma_err-v1-3-d1869fe4163e@nxp.com>
References: <20250228-edma_err-v1-0-d1869fe4163e@nxp.com>
In-Reply-To: <20250228-edma_err-v1-0-d1869fe4163e@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740764548; l=1395;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=zsjBFpk4lajE3GWIn1JANr/cft0EaVYhScZDK3IIFhM=;
 b=1KNVpiBlW0Ydiwb/7pf7RxdXz3Sw3G3H0biGZhQ5xynL/15KssbVfmMuDdWMsBo5jh3jeGmrt
 PNhbK7wyrzGD7vHv0cZdbWIER5+tKeuTaEbIBLTDXxw/MkZWMFkGLz+
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10498:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fbddf8a-5d66-4c8d-8758-08dd581f4e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akhKVzhpdXd4U01xZWtrd0VGTEhnakNjYm9ML1RWYTJEMUY1T0JKVjI0Qm9S?=
 =?utf-8?B?aEZPbW92SEFMUU1SVkpHSHlPYXlhNXhYUjZEd2F6YVJmdjQ2V1ZFZHBUSTZt?=
 =?utf-8?B?cDExR2IwVmZ6Z3JyUWhCcmdPd3k2cldBY3ljSXFYTHpXNkRrVi9LZkF2TGFH?=
 =?utf-8?B?eHRsT3B0RWJ5K0dtSUZIanFFSEVSWUhLYXM5UDBRV0o5d3Rrb0V0QTh1ZWNU?=
 =?utf-8?B?SDVxTVloVC9jR3MxOE1zQXBtRi8zZUZNV3poYzE4TmtFZE9MaEZtZ3pVSEpO?=
 =?utf-8?B?ZERLQkxBMkppbTBCMG1ZdTQ0SnA4Y05GV1E5ZFcxdWsrQTZvRWc2aERhaWUz?=
 =?utf-8?B?U1pCOXJZNFNUazIzOEJRYy9RSVB2cUI5SjhmR3NFQk1BektHbnVzSENPQjVO?=
 =?utf-8?B?ZXhQK3pXS1Y0ZkNTSEwyUTBxNmt2bGFnelF4NFQ3ZWZyc3Z3T3JxM3NzOWJE?=
 =?utf-8?B?eElhVXRlUXNqT2ZyVVQ3MndUZlZtaXBIQS81MkZEWjRhTWxlK3lzTm45aWEr?=
 =?utf-8?B?bVVGM1d1dVZwdHIrbi9YcHVNbUZPaWo0VUIzSHliUHR5bjVNUVFjQml5TzRv?=
 =?utf-8?B?bFJmVzJnMWRDR0pSODlTTW5lOU96dk9acGhKNUs4QytJMHU2a3B4S1FlY0Zu?=
 =?utf-8?B?NlVNV0xjWjVwQXdaOUY2TTN1NXV1bXJaUCtHQ0lWZytiN3V1b2RBOEYxSjkw?=
 =?utf-8?B?cWtRTmMxcjdLdG5QdE00OTgzT0M3aVQwbi8wSnBsMCs1NDZYNXhxVmtJM25L?=
 =?utf-8?B?dWFyWnNXZUdYdk1JdVNoUEtCQjNEWVRwSXZmeEcwL2svSGlsaE02U3EweDEv?=
 =?utf-8?B?bUhNSVV6UE52UU9KOXUvVVdDZHZNTUlUY0VJWHQ4ek5VTGE2YlhZSU15b0V4?=
 =?utf-8?B?bmkxeHZYaGkraVdNRk15dnhBZHhxeVJxNTNxK2VOMUNrQ01FVnFGTVlsY2lO?=
 =?utf-8?B?OC8vRkFwMkozZi9VKzBtUzFhY1R0S1dzR1JrV2JXUFRNNFRvY0tkUWp6eS9W?=
 =?utf-8?B?SEhEbmd2alBMeGplOGdoMExRS0JobDUxTlN6RmVhREZHZFpTSnVxVWgyWGwr?=
 =?utf-8?B?dGZpeWk2dVg3VEI2V0FSYk5kb3I1TXR0SzR3bEpubFRJYkVEaW14T0FNc09n?=
 =?utf-8?B?bktaTHhmS09DamQ5Y0VJOHNLMExwbGlKczc5VmFZYytVV21udXljdCs5aDVy?=
 =?utf-8?B?U3k0cWt6TWpVc0d2VzVvRm9wRG1KYjdXUkJCOVF1cUpaS2hWLzN5RHEvWDQr?=
 =?utf-8?B?RmFmaVl5TmRvSHlhUnF4R0twbkFMazVmSElWZGVURDFpSm1DUWhkbnB1RnVi?=
 =?utf-8?B?R3NYbytNUktPdmdxQkdPenNNNm1qWjZiWG5WV2tEWUVFUk5TZzFWMU5kSHd4?=
 =?utf-8?B?dlNjQkNXaUJ0aFVLQkE0SVVSaGxmYitRNGMyNXh6bUczVHBmMDlIQW80YjNv?=
 =?utf-8?B?b21vNUdYc0U2NHdoV1JVaitDYk9EWTNZOTlZWDdsdGg5d29iT09xdi8rYzNz?=
 =?utf-8?B?MXpNNWYwSGJNQTRlcGtMR0hCeTFXTE02a2FYTkxISlFTRzcrSzl1UlVrUlJL?=
 =?utf-8?B?MHc1K2t0VlNGZWlJVmROZEFBMmFGWGg2QnhEY1FTOWc4V010bUI5bG1RNk1S?=
 =?utf-8?B?U05BM0tnbHBOR1pBa0pMcGhiRlBzTWdaWU1zc0FJWHhQSExxK2N6RzRaUVlD?=
 =?utf-8?B?aVlSMjZMdjk3M1hwMHFzSjJpcXFaK3ByS09PSWZPMGNOTENYaXZwRzNZQzBN?=
 =?utf-8?B?RERpaWZ1M0RGMjBZZnQrUThyTkpzaDQ3eitDRVVLSUNjL3FDT3ZZeHZOUjJq?=
 =?utf-8?B?N2JCc1QrSXU4cjBBdTM2TDlXcEZyVnlobXB2L1E2dGZvcWppNzNSbTY5dmh1?=
 =?utf-8?B?ODdXeXY0YkZWVkdCS1JMODBOTnNaQWF6ZXpuaEErOXVXMnhwa0x0RlRMblZx?=
 =?utf-8?Q?X0jgrdJSEi1BdvQun8Bj8qTOUPkgiwgM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGVKMzNySEdXa3RXZ1p0RW5FTzhMRlBGM2hqNS9DY0xMc3ptdDhLWVBXTFFH?=
 =?utf-8?B?SWplQWIvT0FOMXpkYVV3NUpkYnAxdG1BUEI1VkpGRFBqREtLaGtYT3QzK3Er?=
 =?utf-8?B?cmtaRXVUUTdJUkh4TVNoQmJXbGpRaGdVR2pWb0NWMkxmcDgwOXVnZWF6ZGds?=
 =?utf-8?B?UFpkS3lLYmRUK1ZoNHRIbm9TT2Jpc0hEV0g4NWVrYzVwbEl1QkJFWExPZVBO?=
 =?utf-8?B?ZENBYUtRMzFaQnpLU3FRa3VNNkRsWks5MWVIQ0dTRXQ3MkJ5dWJuYmExLzkw?=
 =?utf-8?B?MVova09YM0IrakpFdDhRYWVveHNXWU4vUlVnd1NMcGcrTldVNHArTzlUeDM4?=
 =?utf-8?B?T2FNRklQdHdjWUtlbGgxR3Jya3lKNmtXeHpENDc1MWxURjBwU21mNUF4RWNH?=
 =?utf-8?B?VGxoRDlzclRPQThVRmI2VnBlc09QK0YvOFZ1TURBM2RSUGN1VVRrYW5Zdk9k?=
 =?utf-8?B?WUtoNmlJMittbGMwNk5kbW0ycDEzZ1R3SVFXWGxCSm5CRmcwYnhMdnlRR2hy?=
 =?utf-8?B?aEMyNjNybHFncm8vNGhNa0MxYXpUaHFET3VKL0h3YzVPSVNONjNOVlJuem1O?=
 =?utf-8?B?NzlhY1gzYkxpRnJVM1E4SEhqK2dGTEk3UHZ5SldFaTN5aVB1cG11bUhrYkJF?=
 =?utf-8?B?R2ZhRVJTSWZrN2FTd0pPd2k2bGRkNDVza3VmWDF3K3hDSDJRK0EvZS9iK05h?=
 =?utf-8?B?SlY1TUdnZnBHTm8xMk9FQ0tZb01HZU1qWjFhdTBUNVNITkRlY1luZjdzaEtB?=
 =?utf-8?B?RUpuQmR3TTFaSk40T0FuMElPTUZ3MFJBOWRyQ2hlQk5RWHVyS0NHZzluUmJG?=
 =?utf-8?B?eGdwN3VBSFRjdGpucXBqdzNHSDhJcUlNdGxIMThYemxVRXJCTzhQUlB4SzNr?=
 =?utf-8?B?allLR3liNFdIOVFSaEtMZGhFZDZyNkVYUHdJcUpvbFZ6dVpXYTUrRnB5enM3?=
 =?utf-8?B?aGdlK24zZGJvZ2tyWUpTL1BXdXdObVVhT2FxK0I2SmpDVkFMQmRnVXdML3ZW?=
 =?utf-8?B?eVVpd1E2UlUwU1JhbDMvNVIvNFpuUFdnOElVVUJ6V0YyZWxOZWMvTngveEE1?=
 =?utf-8?B?V0FmbDkybjNId3RPYnlhL0JxZFBCT3ZKTTBibkNJdDgzWHBQeHZqRkUvekdV?=
 =?utf-8?B?aElkbVlZeEJCdm1EVGdBcWZPWDhETi9LU0hKa3ZBRFdlcUhvL1AvM0ZHT2Nw?=
 =?utf-8?B?V0FZWWR2ZjltU3U5MnRPQnVtOHlzNHhjUFVocEJwK3hwSDhBaXlwNVlhSkdU?=
 =?utf-8?B?S1VoMWx5K3FhNmdINDBWMzF2cEJ3cWp0VTE0Qkx2ZktkWXRKWmJaQzZydVIw?=
 =?utf-8?B?MnFnYms3cUF6bU5iSDVKNFN6VmNMN2N1SW4ydG1WbEh3dzZzZ01ZcFJTZXN2?=
 =?utf-8?B?SUk1ZC8weDV1bEVTSHh6UGhSK0NiWFY4VmRIRFU4UHY1L3F2YU9IcWJjbFhU?=
 =?utf-8?B?WXFoV0NEWVFnMVlFZElWaVB6UDR2dzJncVh4S0ZFNDdqc3VsV0c3OFRRNlE0?=
 =?utf-8?B?aWhSbklYMHdLSllyZ3dsaVVPR3FKemI5QUsvRUhHN1M4a0NiRnRIakpRMzNm?=
 =?utf-8?B?Q3cvdmF6TGV2M3JBYjBsQnlHcGlXaDkzYWlJOTc3cytkNzE1WE9NNDEyY2RJ?=
 =?utf-8?B?SFZRQUloeEJoTktQM0ZweDF3OHJpSGl6UHk3UmNrdHVoaWZjcjZhQ29XY0lr?=
 =?utf-8?B?OEd1RmhCR0EwdGhEZHdaakp2RUV0V25tbUl6N21QcjBFcUp1MDVDTjBlV05H?=
 =?utf-8?B?aGIwcVJHSDkzSGFwVWM4M1p3T3hWSDVHZFVmZXN0WUlmcEhqV3RPQ1FuWU9p?=
 =?utf-8?B?NFczWFI3TjdSVTcrYTBkVXQveVR2N054bGNSR3RFN0dncVVyZjFSakVsQ3hI?=
 =?utf-8?B?blJ4czN4YkZrYVhHOElFSnladFJXS2RCcTc4Q1kvb2VRenNISVlqZGdaTjBj?=
 =?utf-8?B?WTZHVmZLZndWeEFxV0NWVVBNSFpmOEt6TkU1cExBNXdpVWdYQi9oS2xwMlJN?=
 =?utf-8?B?VjFtS25QdHJNaTJSL0p3eks0aUxjV2QwWFIzM2loL3VQdkVxaFd3VHFDYjFL?=
 =?utf-8?B?ZlpIUHVCenlwQkNrc291WWJCRS9URWR1Wkg2eUFZT2ZOTjk4NnUvWVY4VnB0?=
 =?utf-8?Q?hPIw+qKl0iyS/HWbjQ8/EiEYW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbddf8a-5d66-4c8d-8758-08dd581f4e32
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:42:43.6867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDD7hbMb1STpY5bGaiOrH8cfbHVWJMSVspNLREkTvLSFkL5g67gpTm8CA1eWi978NDMNngCdLI+r+SOpTFvVdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10498

From: Joy Zou <joy.zou@nxp.com>

Add edma error irq for imx93.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 56766fdb0b1e5..d8e54b893f8cb 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -297,7 +297,8 @@ edma1: dma-controller@44000000 {
 					     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>, // 27: TMP2 CH1/CH3
 					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, // 28: TMP2 Overflow
 					     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>, // 29: PDM
-					     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>; // 30: ADC1
+					     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>, // 30: ADC1
+					     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;  // err
 				clocks = <&clk IMX93_CLK_EDMA1_GATE>;
 				clock-names = "dma";
 			};
@@ -667,7 +668,8 @@ edma2: dma-controller@42000000 {
 					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_EDMA2_GATE>;
 				clock-names = "dma";
 			};

-- 
2.34.1


