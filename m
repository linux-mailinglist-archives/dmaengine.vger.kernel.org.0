Return-Path: <dmaengine+bounces-8250-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ADED20771
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 18:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2240D300AAD6
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553E32D8773;
	Wed, 14 Jan 2026 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X4vsuDLa"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65E82E2DD2;
	Wed, 14 Jan 2026 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410805; cv=fail; b=sZRWADoXomhl9w/mv3tSor8BD+C/ZPbDa8OJA5RZ5n/mvm5GsV0EefX9M7kX7+lIt7eg7Q/qBpYc0tZ6PbA2JL726IK5rVn5Jb3c6UKyvxEHVkwlBFl13CFaUT+XHlLjyTyxk5EQqM+BnXgXpmKxZkTWDsNvgr3U7yRbwB9Dzv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410805; c=relaxed/simple;
	bh=632XUWGOMYOZiLtLoJ3EwiWd0NqZLl5JxC/BoS6qPmQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KpHYJ+bPurJTfXVRome9Buo61/K2M44oBsl/vPIYHD/hiHuugTsyvsifUMWB8K2gL8A7g00ha7RT3CPh+G0oADQY3EN4D1ktHO/6acFlQ7DeIBQFciItXxpFIgDOPyCabJJRJu2XUrbOsEwznxj3BjYyB6URCo5qhNMV2dg5C1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X4vsuDLa; arc=fail smtp.client-ip=52.101.84.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEOXyJdG6kb0clj9CwKqxxCp1uYmS4tHMHwpPOO+7m2+oxaR3PR6FV2J6r7wKVG+q97V5rPp4FPn0tV6haWvNtVSKlON0zI6O3uzr1oMv4/VGQ/V3EwVJkAUrYP0KAG2XwGW8CN0pLQaM4E/LfWPdWXpztPeV7Np77ZZxsNrkiY9Mdi/yd+8Ur8yFiEcxCrepq7LxfaMijEu9O7ZtWIXZ/ntI1ULRvrczqhIHXxWpBzi8x7jfuQupJB9mfGCeqoXD9+sduKszkTo0IKdjcQNWUwFctY6vKxjjmQZkPKwukpGn3GjvQ046eumLCafHs104maZ8WWkZXTfXIjDpFcujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQ1ujzgSUcvpZRHStJKmZ+yqoNmE2Qe84+8c6goXUP8=;
 b=e3JjWbZ7XnojKl7cBtTI2N6bCCS7/jgEn+TVqrnmJECdPfq/m0XUGICqCmu3JBB4F4mzDH/dBpDNjJxaeUEMEQhT9b0YszwhgUDNCH4JWWm9/nAxwxO4o6UncvSVuxxMloGGH1OURGV6Gp30i/aF9nmMHQvLmlNKA0YRbWqGCENJxwicoKG7oFkQkA7tagfX6/ibWfs3C4IFOXT6z2U66MfobGkQU4dibZ+V9IzaBzWjRWyf2XfFNiLi3MRXY0bu6n3lsZQHFMu0iRwvJsqu+BgiAkkaKsW73MiuzqjoI8eN5gi7qvJFVvSlTuEWn50e3pt2d/JBJyG2h8wsjkNSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQ1ujzgSUcvpZRHStJKmZ+yqoNmE2Qe84+8c6goXUP8=;
 b=X4vsuDLas77OuA646jOK+d56bBnNBvRz+mB0BYai1Au93T2ZhNkET3n4+CK0J+dw77IiMXJx8cgstgmqYxVZp8Ao/aD0ZwOaF5vLUXLEiuLqddg0Ld4pNVrzjAVUN0hyP2zKPyJ/yUi6BpKpEYZ6Bo+xHXZbWtihEd37QONcT5l2VmNIq9MHW3FrKsY0dtgkRoOFW8xPwHUIouhJnx9wRK2BIbCEc93C5q3jkXNRjfywp+M9HTAYDJCp7odnZpvi8KK57/QZNW10qlKIF7s+M4UsKq2Z92XOzzU7uM9oUJXAywEqsmrIBPB98dQ2xq5lGDOsGpA64IghDs6jkZr+xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by VI0PR04MB12155.eurprd04.prod.outlook.com (2603:10a6:800:312::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 17:13:17 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Wed, 14 Jan 2026
 17:13:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 14 Jan 2026 12:12:44 -0500
Subject: [PATCH 3/6] dmaengine: fsl-edma: use dma_chan common config
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-dma_common_config-v1-3-64feb836ff04@nxp.com>
References: <20260114-dma_common_config-v1-0-64feb836ff04@nxp.com>
In-Reply-To: <20260114-dma_common_config-v1-0-64feb836ff04@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768410779; l=7815;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=632XUWGOMYOZiLtLoJ3EwiWd0NqZLl5JxC/BoS6qPmQ=;
 b=nqrn8+IC1s7cFKbIEzrZkBSnQT/h/Ixv/Rkeh4kG9JZXwV4FywBhkvzWGDiIGrW3rbTptrjv0
 m2EaFafDlD+Dz+8tuUwPrNP6G2sw15RurJTK0FltMckr+tGrN0qEhQ9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY1P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::10) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|VI0PR04MB12155:EE_
X-MS-Office365-Filtering-Correlation-Id: c9825d5a-de1a-4b89-ecf1-08de5390359b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUxZMlE4NUpteFZocDNVV1JFNlFMSThCY2krbWdOenBJQjhLTlZ1NTBleXJx?=
 =?utf-8?B?NnhMZ3hSZ3dNSWZCRzJ5NVc4WSt2ZmZZNit4YVRqL1NoVnNsSE14aWttZ1hr?=
 =?utf-8?B?Zy9YdkRHV05VQ1VRb3FZOFpEaytFSTRTSVB0OXhrZ21PeENUbEVOcFFFZWo4?=
 =?utf-8?B?a1hycDdBenNuSlAwczhrQXpxREdFWG80K08wODRKT0d6UnNwK3NycUk3QzZN?=
 =?utf-8?B?TStUQkhXdWIvMnpRcjdycGd3S3JWbDhyZVlHSWZoRks5cGhLNGdDVlNEZVZZ?=
 =?utf-8?B?UHBFVUhoY1M5TE1VVWpjd2FFOTVpZHA2TXJUMVh6WDQybmhORUgyR051bjND?=
 =?utf-8?B?aSttN05xbU11ZDBDYXRqcXArM2Z2akdsRHpjNkljUkpsUGdtdGJPTU5EUFcw?=
 =?utf-8?B?dmM0VmhUN2d6cjdxd3J6NEo5eFoyUExiTEZnZkpITW1YWjJwMDdZVDNOVkVm?=
 =?utf-8?B?dFp0T0hkMGhJVU04Um1MUWNrS2dEYklLODBzOE1qQnNyMVpNSGh1K3F5VFNY?=
 =?utf-8?B?S3VwV3gvUGZGTWNQSW9sU29RTWVOUHMxY0dCOFNNWmNHVlIvUm9ObTRIR1kz?=
 =?utf-8?B?dnVNQTZwOVZheWFYOWNNM0Ezb1lNVFNhQUdQYlptV3JhWTZLQ1BxeHlibUtL?=
 =?utf-8?B?eXJwRHlybHpyMGNhRU5hUENXdWxacW5naEdKdEpqZk90aHJzNTUzdExIdDJw?=
 =?utf-8?B?aHoxR2FzblFhY1hYWnI4aUt6RENqKzcweU1ocTBIcFdzakNFQWcrUHNhS1R0?=
 =?utf-8?B?ek90MnV6Q3FaY25ZR0FRaFJlUzQ2ckNLUHl4YVJiZzVkUytRb29ncFk2L0xs?=
 =?utf-8?B?cUxvT01zbnIydWZFT3RzTThmTng0akhyblBHMElERWw2WVplbERBcUFNbmFM?=
 =?utf-8?B?UnRnaUl4NERBUC9GVE9oYXBCbjRodjJIQzV6RG0rWDc4OUxQKytsdGxlVWFX?=
 =?utf-8?B?aUQ4aUNId2JEaGxpSWFZczlmUG05cXhnRjRtckUzd09KN2REQzYxWm1XZnov?=
 =?utf-8?B?NVpITk5qMEpyV2Qwb1poa3BNclZSOGVDaTB1TWdQcnYwZTV4bnJpQXFBL043?=
 =?utf-8?B?VytlOExGRmlHZHUwRXk0UUdEd3BKKzAxSWFpdWN1SGxoNENHNXM0a2NsT2dz?=
 =?utf-8?B?bXUyQmsyYWdlUlFPd2RPOFZPS0dqQkE4WmM1cVJHNEhRZ1VETVZIcTdsMVpI?=
 =?utf-8?B?K1BFelRkalFZSlk3MlF0cC9OL2xrT0M0cE1ld3M1c2o3OGRhaVFqZHNCcWdl?=
 =?utf-8?B?dURiaTFvSDZjUGVWVGZ1OTJSazJCSWROWis5ZWp4VzJENHFQM1VhU0RiS1NZ?=
 =?utf-8?B?NW9lM2s2YnBWbkdWOWhoZVYxZXNROGpBNHNKVkJhUFl0REYraXcvek8yVWlk?=
 =?utf-8?B?VFNmSE9YdHgvQm0vZHd4U0U0L3puRTVyckpEakk4a1E3R3daaG42RkZXZ1da?=
 =?utf-8?B?YnR3N0U0OHVWb2ZVSGk0YjZDL0gvSjVTZ0VKMHZnUDNialM5amhibFJKdGVq?=
 =?utf-8?B?amtmRGlsRFlTakFwUWxEek9aUjU4Z1BERHhlU3YwM2FrNEJEbU9hQjJjQjRU?=
 =?utf-8?B?SDlZVmdWeUtUK0g3Z3loOFdWSTlobHdiUUNqV1hKQXpTa1Y5S1JrQXNiblZq?=
 =?utf-8?B?cEFOcVdhRVZrb3IzS0RGUXRHeHNhRUxyTmFZTUpjMmZld0FZUXNaWDh0L29N?=
 =?utf-8?B?MUlMZlc3cEFSSFRCakMxSkNDd0FoS2VNUUJPZXhuVG1KUG1DYy83SEFETkpM?=
 =?utf-8?B?QU5jTmN1dGVHU0dPVE9Gd3QwcXptUWRkR3dZb1U2TTE2TTJtTmhOWWdoQnlM?=
 =?utf-8?B?RVhYVE13MDNTN25WaEp1Z1BjQzJ5TERRaVZneU1BUk9ZNTNmNXMyN011VGo1?=
 =?utf-8?B?RVVJUmJxQjJwNEVxRUNOSEVRM3B2MVNYUDFWWUZMaWhBcVZ2RDkwd2xCN044?=
 =?utf-8?B?WWdZQ3h3MnNabmEvS25yWnptYmQ0aU1jNGRwUENCcmFOTGpNTmNoYU5zS2NF?=
 =?utf-8?B?Z2NSN3ZiOTd5UFVSSkdpZkpPZ1o5WDlKTUdoNmZ5alBTSWdnMzVJMVlJUTB3?=
 =?utf-8?B?ZHFVcVJhTWovTHBzc3dSL3QxMmJVeWlCc1pFQzgraDRybUI4M2ZzTERvNGdI?=
 =?utf-8?B?bE4vOUNjdFZXZzVMVGtGdzB5enl0NzdKNk9UTU9hVnY3VzlxK0VlVVpmWksw?=
 =?utf-8?Q?wUquhRL5qxKBYs4HgM6Bv9g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVo0bWl4VW0yRi9WVWx3anhsQjF2YlZUTVNKa3NtcTFSQXl2MERyUStwQXk1?=
 =?utf-8?B?TU1acHF6d0JrNzJlTWhPNjVqZGQ4OHVaWC9FSmtZTFYxSE5TZnZrQWxabzBL?=
 =?utf-8?B?dEFZK29PS296K0RlOHhQWTZneHRhSXoxRndOYjQ1T0c2TDkyQlFOeENDa3hN?=
 =?utf-8?B?QnFlSGx0bDI0N0diZkpaMngwcFBNWUlhbEs2UlAxSlV1ZE54SkY4eVBXSG1r?=
 =?utf-8?B?NnQ1L0tTUlFXSkgwSGtncmZQNm05UHp4anAycU1zVHVnNnhlUmI2akpmMlhj?=
 =?utf-8?B?QjNFbDdzQWJMRVA0b0JkZHZUbndudHo5NEpIekRKOFI0cEFRL2dNVkY0eDVm?=
 =?utf-8?B?UWtreXlvMFgrODJKeFYzZ2taMmxPc2pTN0ZlaGRqYkhUUXBJYnMrYzBOczFo?=
 =?utf-8?B?VGxibkJyWWd4aDdNUVNDWXJzL3JWaWduNUN5ZWg0TDM5UVRUbmZMSkxmbENK?=
 =?utf-8?B?d0plREpTdDdoSEhVRlM3UC8rU1B0L0dqQStUOUhFZWNUaTlSdU1iTmFUSzhF?=
 =?utf-8?B?YW94RUswTjdYVkJSWmRvQ2cvaDhlNWJvM3NRTXZHWE8vMHBWMXVCR2o1ajhh?=
 =?utf-8?B?TGZaaXJleGNRVzUzaUlMelVEV1lUYTBzc2MycVpFY2EyQlRXbGZ3ei9BR1FR?=
 =?utf-8?B?cnQraGc2aDFoOWxvUzhkR1NSZWtuckMyb3IzM3FOdWRsajRwZHk3OTJyTXhZ?=
 =?utf-8?B?b1AwNHNlREltc2luL25tWERIYXIxZHM3K0JHVFJVUnM3OExHejRmeFF3ejRP?=
 =?utf-8?B?SHRCOXphV3l5aXZxRTR6eUJsR3YzQWtmS01QS1dBb2pLOUtpVzJDNkliRXQv?=
 =?utf-8?B?N3A5OURHYnJCeXNJSDR4eU1VWHBuWHovWlV5c1kxdHUzQ1p1N3ZWTlNXdHg1?=
 =?utf-8?B?bDlmSWZ0T3BBNjNIOFlpa3pyOWxlMEIrUkg5WU1XeERyNUhKejdrbXZNYThi?=
 =?utf-8?B?SHMzWTREUnV4YzB2VzhOS3FsbTBlTDJWUWtNU3BVRENYSlZkUkVieE81WXo2?=
 =?utf-8?B?dEk4NHE3SUtHVjMyZURKWGxMakFNSktnRHFQQzB1Tk1OM2J6NHRwTmhZUnRs?=
 =?utf-8?B?Qy8xY1l5WDY1dDUwR0VNaEMrYng2Z08rNkt3U04wdGF6NWRvODNqYWQwdTRY?=
 =?utf-8?B?cXp1WmJrS3dqSkt4YjgyQmlEbVl1RUdObUlRaDJTRzhjMzd3KzRoeHNVNEVF?=
 =?utf-8?B?eXpvNUhtd2VlblEyc25BWVF6YTlNaTI1NUFiSGh2M3YvczhGT2NvdjJBTEZn?=
 =?utf-8?B?NkxoUVdHY20zK0dxOGZlbnNNelhBUnY1OElGZGdPR2lUS0U1Um9XbkRSNXRh?=
 =?utf-8?B?M3Jhdmp6R20zRzN4T0JsVDlpV3RjY0ZWc1VQUHhHbWhydWxXVVlQelB3UEE1?=
 =?utf-8?B?eFdRZ0UzVXdmS00xbi9JZ0pKbG1qZVQ4RStPeDhQU1l5UjVNYkVVUFdCS1gy?=
 =?utf-8?B?c0tnaFlLRGVMWjR6dWtROVdLZGFKNGNqSzExYmxza0xzdkVlTC84YkZWcVEw?=
 =?utf-8?B?TTYwL21jdG5GZ0lrT1UvS1c0bVRPektqTWVnY2lTT1lkQjJ5ZlIyMmJWd29a?=
 =?utf-8?B?QjgvOE4ybDlwQ1hZaHRBZlVQN3hwdE5la3R2bXo4NDc5Ni9sTmZ5S3dkU2Nt?=
 =?utf-8?B?U0NscXZCYTFuK2dVL1Q3WVJsRFVUVzk1a3ZBMm8xbmVqbzRGUlBDdzBicGVJ?=
 =?utf-8?B?bTRHVlV3WHI3RmE1UHhvK1Jrdm9YVG54MU8xeWh5a004bFBYazJmVDBzejRV?=
 =?utf-8?B?V2RFOWNMVDNubUQ4SFU4Q0RBa3JjbjFsL29FaEZzLzY1VjVDL1BWcEtITjlQ?=
 =?utf-8?B?Rm1neXhTRHdQRm1LdlBDeXZYajRXbGlXandIdFVlSy9CV0Z2OG9mbnpjWUJm?=
 =?utf-8?B?TFQyL3UvRE1KMHJid0d2NG84VCtkaDc2UlZUdVc4UlJXdCtIdjhWQ3RLelEz?=
 =?utf-8?B?T3lIL2FYWGNCSGU0QjJmWlhGcUd3Yi9pUi9TTDR0NUN6ek9ncGZReU5KZ2hu?=
 =?utf-8?B?LzBSZ1hkVlpSdEdkcERER1RvT1o5L1Y4WnNlajl6eDk5N1BOVWQ3RENZa3hl?=
 =?utf-8?B?M1JxbGV3cDdLUUpXdDJqM1c3aFg1QklmNlNPYlo4TS93cUFmeXJwbW1VSlFn?=
 =?utf-8?B?dW5zV0xSdm1Vd3pORHRxMmRCdEJucFVnd2VhNE1yVjFTUE5MSzE2YWlIVy9F?=
 =?utf-8?B?ZUQveTM2TDZUbEVkR21zUFlIQy9mU1RMTjVFMDJrR3A0SG9mbWRuRUhFajJj?=
 =?utf-8?B?TnJmbFMzNkxSYlNWQ1hUOGNRdDJNSDJrNFNFc1p6MFQzOVMwU2lWZUJRZy9h?=
 =?utf-8?B?c3Q5STRiTTlyQUZHdU1BcEV3UlVCVkVsS1hyN2pRTDlGVkdBcnJtQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9825d5a-de1a-4b89-ecf1-08de5390359b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:13:17.4109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jEIyxM1F5d7MRbkF3nQHmS2I+FSLjuAFMkpN3tVO5f1JbLHKiSdyfgmrfJjqdsC7bmwWdh8TTYKwxYB8Tfmpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12155

Use common config in dma_chan.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 88 +++++++++++++++++++++----------------------
 drivers/dma/fsl-edma-common.h |  1 -
 2 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index a592127580299681304b222d8cb383535dbcc10f..33fc4fa8d1302d899ce550b0ce5d4325fa2e3916 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -294,6 +294,7 @@ static void fsl_edma_unprep_slave_dma(struct fsl_edma_chan *fsl_chan)
 static bool fsl_edma_prep_slave_dma(struct fsl_edma_chan *fsl_chan,
 				    enum dma_transfer_direction dir)
 {
+	struct dma_slave_config *cfg = &fsl_chan->vchan.chan.config;
 	struct device *dev = fsl_chan->vchan.chan.device->dev;
 	enum dma_data_direction dma_dir;
 	phys_addr_t addr = 0;
@@ -302,13 +303,13 @@ static bool fsl_edma_prep_slave_dma(struct fsl_edma_chan *fsl_chan,
 	switch (dir) {
 	case DMA_MEM_TO_DEV:
 		dma_dir = DMA_FROM_DEVICE;
-		addr = fsl_chan->cfg.dst_addr;
-		size = fsl_chan->cfg.dst_maxburst;
+		addr = cfg->dst_addr;
+		size = cfg->dst_maxburst;
 		break;
 	case DMA_DEV_TO_MEM:
 		dma_dir = DMA_TO_DEVICE;
-		addr = fsl_chan->cfg.src_addr;
-		size = fsl_chan->cfg.src_maxburst;
+		addr = cfg->src_addr;
+		size = cfg->src_maxburst;
 		break;
 	default:
 		dma_dir = DMA_NONE;
@@ -335,7 +336,6 @@ int fsl_edma_slave_config(struct dma_chan *chan,
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 
-	memcpy(&fsl_chan->cfg, cfg, sizeof(*cfg));
 	fsl_edma_unprep_slave_dma(fsl_chan);
 
 	return 0;
@@ -483,7 +483,7 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 		       u16 biter, u16 doff, dma_addr_t dlast_sga, bool major_int,
 		       bool disable_req, bool enable_sg)
 {
-	struct dma_slave_config *cfg = &fsl_chan->cfg;
+	struct dma_slave_config *cfg = &fsl_chan->vchan.chan.config;
 	u32 burst = 0;
 	u16 csr = 0;
 
@@ -593,6 +593,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 		unsigned long flags)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
+	struct dma_slave_config *cfg = &chan->config;
 	struct fsl_edma_desc *fsl_desc;
 	dma_addr_t dma_buf_next;
 	bool major_int = true;
@@ -616,21 +617,19 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 
 	dma_buf_next = dma_addr;
 	if (direction == DMA_MEM_TO_DEV) {
-		if (!fsl_chan->cfg.src_addr_width)
-			fsl_chan->cfg.src_addr_width = fsl_chan->cfg.dst_addr_width;
+		if (!cfg->src_addr_width)
+			cfg->src_addr_width = cfg->dst_addr_width;
 		fsl_chan->attr =
-			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
-					      fsl_chan->cfg.dst_addr_width);
-		nbytes = fsl_chan->cfg.dst_addr_width *
-			fsl_chan->cfg.dst_maxburst;
+			fsl_edma_get_tcd_attr(cfg->src_addr_width,
+					      cfg->dst_addr_width);
+		nbytes = cfg->dst_addr_width * cfg->dst_maxburst;
 	} else {
-		if (!fsl_chan->cfg.dst_addr_width)
-			fsl_chan->cfg.dst_addr_width = fsl_chan->cfg.src_addr_width;
+		if (!cfg->dst_addr_width)
+			cfg->dst_addr_width = cfg->src_addr_width;
 		fsl_chan->attr =
-			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
-					      fsl_chan->cfg.dst_addr_width);
-		nbytes = fsl_chan->cfg.src_addr_width *
-			fsl_chan->cfg.src_maxburst;
+			fsl_edma_get_tcd_attr(cfg->src_addr_width,
+					      cfg->dst_addr_width);
+		nbytes = cfg->src_addr_width * cfg->src_maxburst;
 	}
 
 	iter = period_len / nbytes;
@@ -645,21 +644,21 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 		if (direction == DMA_MEM_TO_DEV) {
 			src_addr = dma_buf_next;
 			dst_addr = fsl_chan->dma_dev_addr;
-			soff = fsl_chan->cfg.dst_addr_width;
+			soff = cfg->dst_addr_width;
 			doff = fsl_chan->is_multi_fifo ? 4 : 0;
-			if (fsl_chan->cfg.dst_port_window_size)
-				doff = fsl_chan->cfg.dst_addr_width;
+			if (cfg->dst_port_window_size)
+				doff = cfg->dst_addr_width;
 		} else if (direction == DMA_DEV_TO_MEM) {
 			src_addr = fsl_chan->dma_dev_addr;
 			dst_addr = dma_buf_next;
 			soff = fsl_chan->is_multi_fifo ? 4 : 0;
-			doff = fsl_chan->cfg.src_addr_width;
-			if (fsl_chan->cfg.src_port_window_size)
-				soff = fsl_chan->cfg.src_addr_width;
+			doff = cfg->src_addr_width;
+			if (cfg->src_port_window_size)
+				soff = cfg->src_addr_width;
 		} else {
 			/* DMA_DEV_TO_DEV */
-			src_addr = fsl_chan->cfg.src_addr;
-			dst_addr = fsl_chan->cfg.dst_addr;
+			src_addr = cfg->src_addr;
+			dst_addr = cfg->dst_addr;
 			soff = doff = 0;
 			major_int = false;
 		}
@@ -679,6 +678,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		unsigned long flags, void *context)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
+	struct dma_slave_config *cfg = &chan->config;
 	struct fsl_edma_desc *fsl_desc;
 	struct scatterlist *sg;
 	dma_addr_t src_addr, dst_addr, last_sg;
@@ -699,38 +699,38 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 	fsl_desc->dirn = direction;
 
 	if (direction == DMA_MEM_TO_DEV) {
-		if (!fsl_chan->cfg.src_addr_width)
-			fsl_chan->cfg.src_addr_width = fsl_chan->cfg.dst_addr_width;
+		if (!cfg->src_addr_width)
+			cfg->src_addr_width = cfg->dst_addr_width;
 		fsl_chan->attr =
-			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
-					      fsl_chan->cfg.dst_addr_width);
-		nbytes = fsl_chan->cfg.dst_addr_width *
-			fsl_chan->cfg.dst_maxburst;
+			fsl_edma_get_tcd_attr(cfg->src_addr_width,
+					      cfg->dst_addr_width);
+		nbytes = cfg->dst_addr_width *
+			cfg->dst_maxburst;
 	} else {
-		if (!fsl_chan->cfg.dst_addr_width)
-			fsl_chan->cfg.dst_addr_width = fsl_chan->cfg.src_addr_width;
+		if (!cfg->dst_addr_width)
+			cfg->dst_addr_width = cfg->src_addr_width;
 		fsl_chan->attr =
-			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
-					      fsl_chan->cfg.dst_addr_width);
-		nbytes = fsl_chan->cfg.src_addr_width *
-			fsl_chan->cfg.src_maxburst;
+			fsl_edma_get_tcd_attr(cfg->src_addr_width,
+					      cfg->dst_addr_width);
+		nbytes = cfg->src_addr_width *
+			cfg->src_maxburst;
 	}
 
 	for_each_sg(sgl, sg, sg_len, i) {
 		if (direction == DMA_MEM_TO_DEV) {
 			src_addr = sg_dma_address(sg);
 			dst_addr = fsl_chan->dma_dev_addr;
-			soff = fsl_chan->cfg.dst_addr_width;
+			soff = cfg->dst_addr_width;
 			doff = 0;
 		} else if (direction == DMA_DEV_TO_MEM) {
 			src_addr = fsl_chan->dma_dev_addr;
 			dst_addr = sg_dma_address(sg);
 			soff = 0;
-			doff = fsl_chan->cfg.src_addr_width;
+			doff = cfg->src_addr_width;
 		} else {
 			/* DMA_DEV_TO_DEV */
-			src_addr = fsl_chan->cfg.src_addr;
-			dst_addr = fsl_chan->cfg.dst_addr;
+			src_addr = cfg->src_addr;
+			dst_addr = cfg->dst_addr;
 			soff = 0;
 			doff = 0;
 		}
@@ -743,8 +743,8 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		if (sg_dma_len(sg) % nbytes) {
 			u32 width = (direction == DMA_DEV_TO_MEM) ? doff : soff;
 			u32 burst = (direction == DMA_DEV_TO_MEM) ?
-						fsl_chan->cfg.src_maxburst :
-						fsl_chan->cfg.dst_maxburst;
+						cfg->src_maxburst :
+						cfg->dst_maxburst;
 			int j;
 
 			for (j = burst; j > 1; j--) {
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 205a96489094805aa728b72a51ae101cd88fa003..8e45770a0d3960ee34361fe5884a169de64e14a7 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -166,7 +166,6 @@ struct fsl_edma_chan {
 	enum fsl_edma_pm_state		pm_state;
 	struct fsl_edma_engine		*edma;
 	struct fsl_edma_desc		*edesc;
-	struct dma_slave_config		cfg;
 	u32				attr;
 	bool                            is_sw;
 	struct dma_pool			*tcd_pool;

-- 
2.34.1


