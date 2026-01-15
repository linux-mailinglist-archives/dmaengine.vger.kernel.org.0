Return-Path: <dmaengine+bounces-8277-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2A5D259A6
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 17:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD53D302872D
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 16:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FF83B95F2;
	Thu, 15 Jan 2026 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GSh1Tpee"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013033.outbound.protection.outlook.com [40.107.159.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B5F3B8D7A;
	Thu, 15 Jan 2026 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493240; cv=fail; b=PD4cvuIzVNpdddf1HO/ZbGllbURnK6fx5e3gH2tOZHXlEd8GK07wemk4K6QKPSwmTx1dFEYSB+kjLVSgbu1HooneM2xNrdd8XfY3jKBpQDL5CY82rH8X3wdXK89W6yAiHpXX68dZFxh+jZtrDaRNP8Wqn52U7wsbq+QunI5nQhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493240; c=relaxed/simple;
	bh=NitbI6sG+hG/4wQV74/k7MccuLq7a+wuJrDikhGKmQ0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BQpFTNSr+/oxPTjP7woNskynZ5rxX93KZvg57uV2xqBsy+luID71XkmEnOmYD8MAxpXdKs8xU7VUGFHpxTI71q0ZRXa7xivSmFIy9Hl3trBZ2xyVaCsR9HhY76Kl4wdmh/ens/S6uw3WSmV4cr4ACNTqigJUFOiWzAo/MkgNxlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GSh1Tpee; arc=fail smtp.client-ip=40.107.159.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ga5WhWJxRjDoO2oZSs2M36Mpl25OHQjFqo9NHzLC4Suq/7jUCDtiwaUhB6F1L5nDG/4CATzaVPt4LZbYPt/2srzDJp70d40XQA1MHxhefqyfhd3GF99tp8j5POTPog3dBFQVod8yyPH0KdsWPoNpoLEDcZpmBCUi2Xz++/P1d/5xh/pU/prH0kR0O9BYRBvLMVNoWls6RRG21mKMsKS1Jr8inDnMl2dTnmDdJF+4PJUwK1w02P/b5WKJArrWwhNORJQAcPcsvEELF+WMxv4YwWHT+STn68YJhj0Grs9bX2veNTK+iPa9Fh/LYd+X0btWZovesftN/a+wtiJdGpdXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYspkIgNVIZsF2c4ymoSR7Nn2Hv1pt5jbL8L2ck41qI=;
 b=CAas24tcr96HhvlTvYWvkv9z1kayGCmkRgXMAtbMfaJYN8L9KXHwm4m/XeUGSV6sI1+Cq42p8ZdKLLQK/k1BzjgRSVwgRfoGyJqjWIZ5yNBcXa5haNTvHiyF9GsYMJLwJJhBmPqEWw+kebcNbzxfsI77KcTcCOhyIZymGaWSqEFGfedxxOS2vP0zCTibbHPsFE3/LuuaEgNfq4EBD1s1JYMq10zcYryQEfvN+VDFmi8XOP7TL/eTNTVADUqTUm2Ea6kD3E0IThjVKFRIZal4ex/qd2Mn4aEKiTa82KQ/i/eO8A7Ttw2YsZz/PZDKo02ceBcr16qjAPJpfaBPwhnDlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYspkIgNVIZsF2c4ymoSR7Nn2Hv1pt5jbL8L2ck41qI=;
 b=GSh1TpeeW4ZJMniOwqLv3XorXOELE8kiUbKM6fyGHkDfgGQqnLhpdalT8ah7csowz1GMCOa5T8KRBmAVBPs0ZZxE5vD7GfEiOd4HaM+mxrg8vbwu7pKOrwm4SjG4kI2WTJY+rVKdugKVtRyMRNv2CINotBvquBZGDlwQFZ1aqakFIMnq+UOXC7HLwnEVPbyzFJaBNMEou3PmymQdHt9yJVtrpj/Z3r7LPNqQj5Ep4pYBkzLmVdx1m8XxgTcLHGRTFykaMhlZUDsyvpmDN2d6FlFk1fFN4ym4txQDEGm7QvhEW/CpS77tDt2+rKxRB9vwf1zPJ4Ag+yYMjqwJezUMqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by VI0PR04MB12235.eurprd04.prod.outlook.com (2603:10a6:800:333::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 16:07:14 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Thu, 15 Jan 2026
 16:07:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 15 Jan 2026 11:06:42 -0500
Subject: [PATCH v2 03/13] dmaengine: mxs-dma: Use local dev variable in
 probe()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-mxsdma-module-v2-3-0e1638939d03@nxp.com>
References: <20260115-mxsdma-module-v2-0-0e1638939d03@nxp.com>
In-Reply-To: <20260115-mxsdma-module-v2-0-0e1638939d03@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768493221; l=2474;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NitbI6sG+hG/4wQV74/k7MccuLq7a+wuJrDikhGKmQ0=;
 b=2spmw0P4dS2TFM5n2X6fpxPJ86CAhcUCO72h2IAcM67GzlvtpRqZsgk4qmq0pnVcY5i2+ypW6
 1r/holxoR4sAaHSXgXupaHvC38q3+SFEEj6/e100erwXbV9o7YftKgT
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:510:339::15) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|VI0PR04MB12235:EE_
X-MS-Office365-Filtering-Correlation-Id: 099d0dda-9e02-4492-4b46-08de545025f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekJ0Mk5tTGZXU0N0Sk9ETEl0UExnNzdHSTVPN3o1bTdtbnVDVXJqaEFseVZ4?=
 =?utf-8?B?eE1QUFRKVS9yQlN1WG05VnhvZkY4dU5zczA1N0J4bGpuNHRhMXBnb3lvOW5l?=
 =?utf-8?B?N05razI3ZDdJOXpiZm9RKytvRFlDRTRVVXNlNEpqMEExTktyeko3OHBacFcr?=
 =?utf-8?B?eWJWNHlVaThOZ1p0RUdMb0U1WmR4b3pWZWREcWhXNVRpdW9MQlRuWGRBb0lk?=
 =?utf-8?B?NmliY1pWcXZYZlVwRlpRdWV0ekhvRkE4QzNQY1g3bmRmc3BhU3d0WjYxVkMr?=
 =?utf-8?B?dUZOM25tckJIbHJYSXFERmdwVEtQeEttZ3JUQUNQek9DSGd4M2Q5UTBFR3N1?=
 =?utf-8?B?ODFBbmhFclAwRENvL2l1eUw1L0lHbkdxRVhWdE9aeDY5OTljVDEwemN4dStJ?=
 =?utf-8?B?ekplTVlwZkhuNUttL1BTemtOemdpUUdSaXV6L3NuTlAvTkErNW9adDRsZFZD?=
 =?utf-8?B?a2FETE9YRXJCT2txUUpuRXRWVFpTQ0YvYjVCTnRKQXNkcURFK3pieENTbEtT?=
 =?utf-8?B?QUI0QWNGb0FKRmpKVGJqUzRvWExjUGQ2TmM5MkkxNjk4RVJ0T1FRYXNQWVpp?=
 =?utf-8?B?ZVBDZVYzVTR0aGZGWUxPaGJDSTE2RTU2V0JQNXBXdlRSeHA5UVNBMGxZc3Rt?=
 =?utf-8?B?M2x4KzNjMUpUNE4zRVBaZ1phK09lS3FXQkp2bk1yandCdzRTeXQvYmNva1cy?=
 =?utf-8?B?QW5iUHJ6QzZqWlJyRU5RaFlvQjhoMlQvelE1cVliSGJ2UDg5Qk00OFBKMW1K?=
 =?utf-8?B?RTdaWXdrTGwvbWs2MUF1d3ZnSTdyd2NmWmp5ZklNS2RzYXVQMjhmQ0tlQnNW?=
 =?utf-8?B?L1p5WDF1aGFpU1VnL1RjU1d2c3MyajBEMEFvTDBpMHc0VXhIWUpUU054ZHQr?=
 =?utf-8?B?alc1UFR1eWZPRUU0eVE4dlN0QzNKa2lSMS9ieGtVSnZlRlBwdkNwdkN6Y3o3?=
 =?utf-8?B?WHFhbFpqaldmNThhTEhmWWgveXBuUEtyaTVqZEJQbW5Rc096cjhiTjZ4ZGxD?=
 =?utf-8?B?SVBYUFQrdzVGMWpUT3MvQmZ1YmwzRnVTbU1ub0N6aXJuckttdGs3YXhkZ1NI?=
 =?utf-8?B?T2pzajR3OFUrODhGL3lydmlnZHlleE9HaUxZKzdmODJTN3RoTzc0UTZnZXRq?=
 =?utf-8?B?WnJOSzVpQkptM1BKM0ZYeDRJc1Vpd2ZWZExjdnhFTmlzNk5XdkJzRDd5L0xm?=
 =?utf-8?B?WWtkQ1duNnVzbEtjcUsrOHBUNkM1cEp3UzFjT1N3ckk5R1NOdG5teWlTa2JV?=
 =?utf-8?B?dUx1RUh4SGtTMWxlS0gxcWFxYVBrU2RGemhIQ25CTExyS2pMQ1VrWHdtYUs3?=
 =?utf-8?B?UFJkcXZlWTE0dmQ3cVg5c0tPN3dCZDBlamR6QmtpNGx1eFVkUmNuQ2RjMHVm?=
 =?utf-8?B?dGt6SExsSzRHVEh1U0R0TjJlT2pSbTlwRlIvN29mSFQxU1RLdUpsNjNkOXBC?=
 =?utf-8?B?YzJuVVlIaDA3N2RtdmNYZ095YVZhS1c5QnZ6NjhySlBFbEpnc3N4TVllOFhE?=
 =?utf-8?B?MVRvbFppanJKZTBQWUp3R3RhT2xBRTNMN3BHc2RzZ21YSmdOU1N3QkNkYVMy?=
 =?utf-8?B?aCtZSFhPQkdUNWdkeDNHT1JidXNzUVVyRmhYUUtPc3NnWVRlSnpxRlFxdVRP?=
 =?utf-8?B?d0RNdVUxalNzVUhmT0hKeGxtWHU2VHJQd2VDWFI2UHphcXhFaklDNThzUXA2?=
 =?utf-8?B?TEpDTXhOQi9SQ24zNXlsY1NwdDY4TXpuaVRBbTAyKzl3TnNIM2U2ejF6ZnpT?=
 =?utf-8?B?cFVGWjRUeG8xUVBrOXUzbzRpMXRaQjhRSmhMTElYMW5rN1lITWUyM0xyNFAx?=
 =?utf-8?B?QlVtWTRhZE1JUmpMam5SZWZyaUZxbEZkeHNpTm5kQUJic0Z5bzdsdXVQazRI?=
 =?utf-8?B?empWdUlQK0V0SzBHSGhqdjJRaTA4VzMrZGhEQXJZbjNCQmtGOWYxb1ZuUW9V?=
 =?utf-8?B?dEtJN3JsTjFHQ2lxVVVUMGtyN0gyeUsxeExxSldTRXFRY0FhRFV3OGExUHBs?=
 =?utf-8?B?TlBNbjIzOXVXQ0s2bWVGd1l0Nzk4dVRSckI0MUkydWZBMFBkYVhGakhpMkRs?=
 =?utf-8?B?M0JkVm5BWW54NVg0YlJyT2xXOE53WXZXU1U4cVhOTXRIRHBjYjIycFRsMy85?=
 =?utf-8?B?V3R6TEYwN1FpSlJaUTJVY2JHL2Yrbis2eE1EN0Q1WjBYZDJTck5UL0xxcEwz?=
 =?utf-8?Q?lUivJ3Q/5sYGUNBC1QfpC7o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVhRa1IvcWpnWVlBNThCK3RQL2hrbmxyZG9mUXZQWnJnKzkxYjZ2UlYxeURi?=
 =?utf-8?B?VzMzUFlweUdPNHN0dTh2Tkt4cTJBekc4ZXhJVktVL0J0ajlNY2NmMVFMRGlp?=
 =?utf-8?B?TzNaYlVJdmlXSWhkV2Viak5yN1pHd0QrWml1VWN6K2x5T2hrZk80aGVqSFRI?=
 =?utf-8?B?NkJXd3doY2xIeWZSbXhBbGpCaHZDdlBYNkdVaFcyR3NJRmpxamJlcFdmTzU1?=
 =?utf-8?B?dDBkWVk5RnVCQjVlQjN0em80VjBsN013TmxjVUJ1VGxURmk3Z3NIQnZoM1dv?=
 =?utf-8?B?SzlablpXZmx5MDRUY3FsMjdkVHNkbXRFZ01XRVgvR3RDb1F5cUVLV1MrSUFt?=
 =?utf-8?B?enJxR0FWMGVBL0dNRWRSYktzQnZVUk9KZGVWOFk3c0ZiZTFnZ204dFYzUWdS?=
 =?utf-8?B?V1pJcHdxbUJPeDFQKytvWkVNS20wU2dROVdSU2hyTnI0OWc4Zm52WmtuNlFj?=
 =?utf-8?B?cEpSc1YzYUhqRzRJZlVjdUhJMHVpODNqRFpxOGNDMnhRaXluV2N6YVpKdXNP?=
 =?utf-8?B?cFplOHlVY1p2ZENKQXVSc2wzZi9ucVF6RVZoSUc4V1dUTVY2bTg1dHJUV3or?=
 =?utf-8?B?aUU5YWlFaGJjVzY5M2dRNWpPMkR5ZjdMYmpzZFFLUzVDU0VxM2tnRG5Ya0ly?=
 =?utf-8?B?ZUVnWklONUp3cVFGSUw3MExLOHVvYmpMSThJVXRuYWVhN3NQT0FTVkdKWmd5?=
 =?utf-8?B?WnpzL25BVS9mSWd4ZlRiSXBLZ2huYjJvZEM3SnpGRFVWZnpNVWgvSU5nVzNN?=
 =?utf-8?B?d2d3dDNkblVwUDNDUDJ0bW9YUFN5NEY4ekxhOTNxU1VoNGZlamRyOS82eHJ0?=
 =?utf-8?B?dEcrTEw1VVh0VU1YUERoQWR2eXFOZzN4RSs4bXczdmEwQ0Nxb0d0ck9neVAr?=
 =?utf-8?B?SWthVmsydjJOQllScUdGOXMwVU00aDcwNXROcmhldFR6RWdBUnFDUW1Yekht?=
 =?utf-8?B?ME5xTXZaa3dCUjRPVXN4U2Fub2Zoc2pSZ3NPNEQ4NjN6Z3IvL2ZSSXhna2tD?=
 =?utf-8?B?Z05SdWpQTUZBM0x4aVIwTGwrSlNocDZEQ3UxSnlBdTNNQURuZUFJY1llUFZQ?=
 =?utf-8?B?SjdHV0RzMS9jckh1RmlCQ1pQUng2MVVFLzRDSVlUeUlNL0JXc2c3QnVBWFV6?=
 =?utf-8?B?MC9jRmNrUzZVd3Y2VGU1NHlvZnhDbHUyMnZveTljTWV5T2NScnYwT0M2UFNm?=
 =?utf-8?B?aE1wRjhHR09venNHUVZjcjhVMWFMTE1NbzhndUE0TldmbkxCeTZuS3N5a1JJ?=
 =?utf-8?B?YUcvN0lvQlJHRGgxMzZYV2FacVM4MTk3QzRYUG5OZWViUTdtVVp2LzRnanBk?=
 =?utf-8?B?eHZ0RUpxdmlqNlB0TFp3cEdEK2cvby9oNmgyL2dCU2g1S2VOMlYyUkkrSURI?=
 =?utf-8?B?NjVvU3lacjBxMzM1U1F6Y1ZuTFdPcDFYbU52M0RSYi93RTNCMkdKajFDbmx1?=
 =?utf-8?B?WXBtR3lNS1lQOGhuTzZ4U25EaDZCVCs2M2gvT0ExeU1rR2tOcWNtcGN3QmVk?=
 =?utf-8?B?NUxNbHdMVGhwcXNPc0txOXJscjU5dDF5eFAvR2N0dzk1OEh6VG1UUFV0aFdL?=
 =?utf-8?B?THExV1QyY3A2MVh3anVGb0tuejV0V0krR2lhMjNINUpXR3B5Vjdrc3VmTVox?=
 =?utf-8?B?cDR0WC9JTER2RW5uRTJ3V2d4eFc2OTA5TURQMGc1SGFRSGVxbzl6TVRyQm1h?=
 =?utf-8?B?WkpsajBxUXhnOEgyTVRrQk5IVVo1R3QvSXhzODc3NWljMTI4eG05OHpiZnNK?=
 =?utf-8?B?QWl1a3pYV2c5VjBORWNGVCtLNDlJTHNibm1qMFNDYk5ZMWI2a1pBdGZoZTJD?=
 =?utf-8?B?REZIWFVXYk1YUDk1Y0trSjdUS09PZ0YvY3VncDBrOHhvNS85QzhsZG83V2wy?=
 =?utf-8?B?N2lkSEtqK0U4V3VmS0hVQzZ6UjdaUCs2YWpSSXJsTk81Uy91SXZUdTRzYSs1?=
 =?utf-8?B?aUFWRXdjUVRuQ0JlTEJjTjhwSkpwV1lRN25DNmZOSm4wVGg2YUNkcndmTk5T?=
 =?utf-8?B?Z05oNDVzVXJ1c3JOMTFMMXY1aGh3QlFwQ3l5VEkrc2VBeXRhWEV6VEw0akMv?=
 =?utf-8?B?WTVMd3l1YnZ2cFRtd2lYbTBxMUZwQVFXV2dmRjhUQXBkVngxV0NwamVPSk5z?=
 =?utf-8?B?YlkvZkZVMUhDazlTNmNwTVVHZEIwR1YwSnBFNWwwQThrTDBHd2hOQm9RdTR4?=
 =?utf-8?B?U0tVcWM2MnFMNkIwMjJEd0RoMEdLbHhGL1dFWEl2RWp4emNUZVZzWFJONGg2?=
 =?utf-8?B?SnNMNkRGWVhUVkFUcWEvdVFyckxBNTVGcEszaFFGREVYK3J3LzU1eDd6VFRV?=
 =?utf-8?B?bTFia1VYWWVCRHFhaCtnYjgza3g4WnF1dTZhTjlyNlBMV2c3SjdmZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099d0dda-9e02-4492-4b46-08de545025f5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 16:07:14.5197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuZZnoPK4ELvciij/VkBET+qabgaANJarLd4w+4dmPqmBiUPAXnpmbwlZPNbytmhOOw9uvTSABiOGPpS3kVhLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12235

Introduce a local dev variable in probe() to avoid repeated use of
&pdev->dev throughout the function.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/mxs-dma.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 53f572b6b6fc62c6cb2496f0da281887f8fc3280..dbc8747de591cc83e39ef873633418f41b5ea982 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -744,20 +744,21 @@ static int mxs_dma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	const struct mxs_dma_type *dma_type;
+	struct device *dev = &pdev->dev;
 	struct mxs_dma_engine *mxs_dma;
 	int ret, i;
 
-	mxs_dma = devm_kzalloc(&pdev->dev, sizeof(*mxs_dma), GFP_KERNEL);
+	mxs_dma = devm_kzalloc(dev, sizeof(*mxs_dma), GFP_KERNEL);
 	if (!mxs_dma)
 		return -ENOMEM;
 
 	ret = of_property_read_u32(np, "dma-channels", &mxs_dma->nr_channels);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to read dma-channels\n");
+		dev_err(dev, "failed to read dma-channels\n");
 		return ret;
 	}
 
-	dma_type = (struct mxs_dma_type *)of_device_get_match_data(&pdev->dev);
+	dma_type = (struct mxs_dma_type *)of_device_get_match_data(dev);
 	mxs_dma->type = dma_type->type;
 	mxs_dma->dev_id = dma_type->id;
 
@@ -765,7 +766,7 @@ static int mxs_dma_probe(struct platform_device *pdev)
 	if (IS_ERR(mxs_dma->base))
 		return PTR_ERR(mxs_dma->base);
 
-	mxs_dma->clk = devm_clk_get(&pdev->dev, NULL);
+	mxs_dma->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(mxs_dma->clk))
 		return PTR_ERR(mxs_dma->clk);
 
@@ -795,7 +796,7 @@ static int mxs_dma_probe(struct platform_device *pdev)
 		return ret;
 
 	mxs_dma->pdev = pdev;
-	mxs_dma->dma_device.dev = &pdev->dev;
+	mxs_dma->dma_device.dev = dev;
 
 	/* mxs_dma gets 65535 bytes maximum sg size */
 	dma_set_max_seg_size(mxs_dma->dma_device.dev, MAX_XFER_BYTES);
@@ -816,13 +817,13 @@ static int mxs_dma_probe(struct platform_device *pdev)
 
 	ret = dmaenginem_async_device_register(&mxs_dma->dma_device);
 	if (ret) {
-		dev_err(mxs_dma->dma_device.dev, "unable to register\n");
+		dev_err(dev, "unable to register\n");
 		return ret;
 	}
 
 	ret = of_dma_controller_register(np, mxs_dma_xlate, mxs_dma);
 	if (ret) {
-		dev_err(mxs_dma->dma_device.dev,
+		dev_err(dev,
 			"failed to register controller\n");
 		return ret;
 	}

-- 
2.34.1


