Return-Path: <dmaengine+bounces-7599-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB4BCB9F1B
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 23:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A89331234FC
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 22:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3690B3128A9;
	Fri, 12 Dec 2025 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PiiS0xYN"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934023126A8;
	Fri, 12 Dec 2025 22:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765578391; cv=fail; b=bZGh2TVBp3EQwddRQpJHd7NQkCnE6k7viRcCATnFsqSJqAGddCs8pzqUuwe/pmSu5rEGauLqoJc9xm9vplQ8vXORJSQY69n3lXKjnBj4TtK63H20yoI7XGX0wz3SLW7D2SHuMXZ0I1q37LwhHch8JOG7b9A8rTqfQSWp5/RMaGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765578391; c=relaxed/simple;
	bh=mxkkeUkhqdBRaLfd5eE7eoKCRi/hPytS40oGEpFcgt4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jqUXA2/jF2z6GlyUn2xapyiSbziDX3JHFbXtbt+fcYBbZBnhzFoI3ATVOVMtz2g6d2sUHtcJmLEYYKdOKRm3aOgvz5CwR3e9SGB3f6Qzo5+YYYE532QhJ3302uhCk4m4LkYmcjPcL271z84tXeCkiva87M1r7f8AQWrdDNL49nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PiiS0xYN; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cymosCBVukmTXmrfsJhde5bSpCQWkgnxrCzjuXrpA+aUUe7u9s9XMJ4OGYtu/7qNxMN6CFKjGFPc2XjJpTzLCcO1AQfjMKd1R/SNZXffYZwLG89lDIQGra86AfBiO9drDMPpWgDOyERGBc5kb3wJxd2j3obFWTPm0IWPooQSJEpg4Y3ZhAnrDCRt5yPxoVqGIQC5sRKX9kammDW5nqzNXkNnyOQuecBRyfO0OZp5r+QY3Zb+6ajwUHdOev6WiiTTadPoh+ZbwyPlXx2Ha1zy+dtZUwESnmTdqZDk/24xi8EJhzv1k2PU0QLqTmucj7cA05e4r5IdkC9QnYBU4gk4YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwvHUP0/AfESvT8ZcTUWPFOVFvTZ/aN1cB047T/aRzk=;
 b=kILvBMBoz9ASFAN5nfYt9TyZatevuw1mSW8pfTSkjxkJSTWpmwj5zUZWbnjNSNbf9WDYCRfKnUmwA5SPHzxlywXyIIF164Mruf/3BL6IAxeHj8PrDNzHC/30Qy99Dmg43XDYmfQoUJ6oemKeYitqKBlApFs1IlkOgfZonB4DLId95yHxFTjvLN5AxaM4WNzM+bmWXnc6GiOAhHOWYmvhlBlCH2zqZFYWeG7VUh9l2gsEcxIMKM59rJuGjt0I5wN4zBB/YUP7oDVK6ExuWtlSWZxPDFoj7vcfYi1cqUhEDbMb8ZYKCjfUuYvIwWwg9qnDr9JNJeq4KCFyEi/mQ1FTvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwvHUP0/AfESvT8ZcTUWPFOVFvTZ/aN1cB047T/aRzk=;
 b=PiiS0xYNYFO97iGrRQsw+HcU6EgPWYDuo1fiwpdYzrIhFMocV+q+oG8GCBG34KzOpMl6JD1KZQ3BS4BB+fnK4T5XrF6xzZtkXyxCGLcbG7sf400XoTxgJPQhxWtYTtBIybBXJH/4je2dKMe3O9l4u5t1MCgCul0rodBr02oC+fjNfpLI3QqodJxJblL/MgU+qFH2Lp2K2q38xV1MMMuUvKYZCemZG9POln65vXiE3RsH5dl62D2pIaZt4gV8b7igh1ZG9eHRKizebefUAElIn0cEBxfEH+TLL8TL5tU0NX7hUOgQt5fHu4ad1nVmHxyTEFytc/JKiblqTGP2s1BmMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV1PR04MB9053.eurprd04.prod.outlook.com (2603:10a6:150:1c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Fri, 12 Dec
 2025 22:25:30 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Fri, 12 Dec 2025
 22:25:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 12 Dec 2025 17:24:46 -0500
Subject: [PATCH 07/11] dmaengine: dw-edma: Add helper
 dw_(edma|hdma)_v0_core_ch_enable()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-edma_ll-v1-7-fc863d9f5ca3@nxp.com>
References: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
In-Reply-To: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765578298; l=7899;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mxkkeUkhqdBRaLfd5eE7eoKCRi/hPytS40oGEpFcgt4=;
 b=vkUsLkUkA9KI+uoM4Rb5iZgBwhwdplo0N61sh+WT6NwmcHMeV98m6F5lX0WO/OOR7N5RI5CZc
 /rxiXEEwCfOB2RYu7UEmrG1aAW8e0HqW6/Mo1D9v9kwYnIFrQmUMPOp
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::38) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV1PR04MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 8feeca90-e3d4-463a-8c33-08de39cd5bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmNQTmpTSWx6VmtZRFN5b25pTlFuaHE0S0FpQSt4bjM2NGc4UjB2aU1QUldI?=
 =?utf-8?B?NDc1YkJrZUI2VlJWYUpMZ0JEWldSdFdTOEJBUWZsSno3QnpsdEdPOWVPL1Qw?=
 =?utf-8?B?N0hwbWlxVGpnZDRhRlk5dzJQdjRpZ2gyd0ZhemhzMXlCMEhTa2V3VzFrZFoz?=
 =?utf-8?B?NHBOK3IyS2FrVkFZSWxoUnlQR1hsSFVWTVVadFJ1RUY1Q0tkZ3M2RXNEWWFU?=
 =?utf-8?B?Z1M1MzdtMlFuc09qaFNCRHBuc1ZEcTBYeE1zTEsrTGU4aU4ySmo5endQOHJZ?=
 =?utf-8?B?V3hRRHphcmxVdEhsRUl3MjZ6NnVaSjlLZWxyYVkwKzhxN0ppdHA3bzdpMlV3?=
 =?utf-8?B?Z0drbmZWOVhjSEt5ZU1WZjlDVmdjejBpL3p4Y0dlUUtMb0JySkhZRi9aQ1FO?=
 =?utf-8?B?Um5WU1p0VllmUGYwNGExL25jT3daNFFsVHdOK0JBdXRaOGtHdDFsS0xxQXhB?=
 =?utf-8?B?SnBhTlpOYWx2dS9wQlVHY2N5Mm9yN09TNjQxRk1WcFFjbUxTMm05VkRjSDF3?=
 =?utf-8?B?ejZoaE51OGFXWCtsRm5XeTRUbGpZQVljdm5nV3hSOXExOUw1YkduQ1lNWFNT?=
 =?utf-8?B?NERtR2VWdFhnNTd5emlXQVF6Sk10T3d0ZzZXMXZrOU9rQnVudVJ0ZkNETkVU?=
 =?utf-8?B?NjRWbHdWVE5xRzNhMTdnRnV0MDk4VEpWQ2ZCbThJajVvTEp0b2YxVmNhNEU5?=
 =?utf-8?B?N2swTHhPOVJKajFkRFo4VE5LNG85NnJuaDh2bWw4dlRINVF1L0RaNTFXeVF6?=
 =?utf-8?B?RW5aelpFd0tQNFIxRysvcjFBeHJkTzFHeTNmdVFPQm9PdVB1UFBhbWpYZUNV?=
 =?utf-8?B?ekxEQy9uYXNVbDVjWFZJZTRXZkQ5dll1VXBVOWF1b1JMS2tDUFhyWXY0d2w2?=
 =?utf-8?B?OFg2Tmcrb0JGVEY3WHVwYjF3V1BaUG5NU0hHeVlZZTFaQlo0cUZQK3dwQnhV?=
 =?utf-8?B?cFVaWjlkaHExdStzUjJHZlQrUUd3OWJjWU9SVWhjZ2NUa0lLZ2NYaEVrMEoy?=
 =?utf-8?B?S0VMUXorVGhrTlZpUWtBa3JKV1E1MUwycXMzWlZ0T2N4dXZhNlRlcHgrSVdV?=
 =?utf-8?B?R1piQm1yd2VVNGVXNy9MVFVFaDVTVkFwc3BpdE1qUXNMQTFyV2xBaVpFVDNR?=
 =?utf-8?B?clpwMW5HRW1GL0Fra2dwUVhmZ0VTS0NDL0J2eGtXMDdvMnpUa3VNaHk2Y0ZT?=
 =?utf-8?B?TTJJdHlDQzhxSno3VVJKdlMrRkpicUJrZzJsWmlHWXptb0JtWUgwbDZlVnlY?=
 =?utf-8?B?UnJuWjJlRXdBZitQODhzL3Bod3NsbWNNbUVUODU4dXFoS05TM0JTZlh5TXk5?=
 =?utf-8?B?RXNKU0V4dHdiQ2pxbGdOc3JRNEt4VU9iOUN5Rms0amFrUzNDZHRuaWlwc3lI?=
 =?utf-8?B?YzBFMmVxQlU5SzZCYUlidFhoWmZQK1FrSWJvZWl1SkdwK24xUzVpN216eHIr?=
 =?utf-8?B?YTNYaWhTVlplVGtwbEtKNndlSFVheGtiWE1qaHZBeTJmdHJmZzVRc3ZDdFcx?=
 =?utf-8?B?dHFJV2UxMmlyQTQrelZpNE9UeVZScTA1ZmZYNWcvTXU5dDVxWHNSUlF4V3hM?=
 =?utf-8?B?Q3BiL295Y2J4MFczUFlSaStRZ2tjSmFzbXl6MHpuL3VWc0NzdDVzOVpVR0Ro?=
 =?utf-8?B?YzNMUUwrYkt1NHRhbTNzQlhsb0V0OU1yTkF3clRLMGxCTnBSVXNGTml4VnlD?=
 =?utf-8?B?RUNTaWZ4eXVObDFaL1dqMzdwTXMwWWhxV1NaUVNqRFhOZjBjKzV5VmYxMzNE?=
 =?utf-8?B?Uk9XMFp1VHdzK01lNlVVd28xL25FRWtpeFgwZWVGSVJjRjRJN0ZtTThxQWZP?=
 =?utf-8?B?ai8zbytwcDlRdnM0Y3NINlU3clZlMU16SE5vSUpGTlBBeFZxM1FtUzI2TTFD?=
 =?utf-8?B?ZThZOHVqQndkOUJ1UUJoTTFvZTE4NG03cFIzMUd1NERpYVpBM0JzZktUYm9D?=
 =?utf-8?B?bHJSTjJ6QTRtUm5iTVJ5eFhNNk1xYmZEU1RGNERYUmI4UHB0WVRaN25wRlhB?=
 =?utf-8?B?VGVkTGRtQkJOU1VKUytWZ2FvdTV3VWcyUHpvZnQ1TTNYbmtRRjVBelF4WUwx?=
 =?utf-8?B?SzZnUE9aSmYyTk5MaHY2dEkrYWZ5S1c4VjNSUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUtOcnpGSTRSM0xBZWxYUkdDdE5MMDN2QU50dVNQWWx3b1V2R0p2N0JyMmdP?=
 =?utf-8?B?SWZDNDZOUzRDbmRFY2F5dG91WjRGbEw3cHVvSDNhSllZTktITy9UbS9uV2lw?=
 =?utf-8?B?ZGRtZzl4MDlobW9LSndqN3pTMHdwK1hzRTZwQitDUVhDNjVwaVJHbUN1QkM1?=
 =?utf-8?B?anlCWVJmM2pXTmxTQyttWjBsVXJHVzlwb1B3dTRiZmtXajZwWXRnUVFTQnV4?=
 =?utf-8?B?ZjBaTkpBZzBpUGphWXNNYkNRTFZVeEpCMWlPbm0yUVpWV004NzZ5K0tYSGFI?=
 =?utf-8?B?NFNaZmN3VWxRWlJOa1YrMkpWUFJEMXBEQkJjdXNaOHo0TWJEdkY1VmU1RUpX?=
 =?utf-8?B?dk1DKysxT0Y5UEVHQ2lOQ3ozaXc5TUtSeE9XWXh4c3ozZDVGZ0RLdmdkMmNw?=
 =?utf-8?B?R1BycW42SDhMbENQTXkrMEpTbTlFY3c3cTlzR3RiTlhlMEllZktzNmRZdCtq?=
 =?utf-8?B?d2cyQUxNSXBLZGpEVVdQaVZYVGlHa01vcnIwaDhiTjVFbDYydkZUdTJ4bS9T?=
 =?utf-8?B?aVRrdW1WNTJuTmFEdmpUZUtuQlpkNmQxQ3VwcnNCOWFkcHpGN2lYSUJRdE8v?=
 =?utf-8?B?aXlMbGJCR2ttbnEzcFUrV3BnNDZQVDJhT1U3RTcwV1JqbG53S2w0dmxXa21i?=
 =?utf-8?B?UVhydGFWd1ZtcXZkZGJVQ3h4bnVDWUpXT0MrR3gvRXFnN2R3NDYzYlpRT2dJ?=
 =?utf-8?B?YnI0bUVFNGJkbWsrQmtnTjV2SmtEZDJaci80OEJMT2wydkxKUFhobk1SSytz?=
 =?utf-8?B?UXphOFlEdHh1WFZlL09ja0ViZzArZGdoK0ZxU0pCaVJoeTJRMzR4cXowK0lw?=
 =?utf-8?B?QTFob1NNWE9QdkttVHhVeTRMMkQ3NHRqbUlINit2MWFSWjR3K3FwVkFLSU9C?=
 =?utf-8?B?QmFYTFJjRGk1WS96TTRvL2ttMHFwYlhXeWh2N05raGpZYStpTHp4WFlKVytO?=
 =?utf-8?B?Tzk1aFVxVng2anp1Um4zUlYzanAxa296aXJ2K3I0YXZlVEFxNnkzb2luamE3?=
 =?utf-8?B?TTlNT0FVcEcvVWNyM1RXOHdxZkN1UUgzNHZiZUpRUzhHVGVXd1pqMkc1cG9G?=
 =?utf-8?B?RVhodkt1ejNkdklqLytzTmNtWFBBZmhwWVNoNTV2VDIrcXlGY3JaWDQxaTZn?=
 =?utf-8?B?NjVPYiswL0JOMHBQK0F6VWVNa0xlVERSTnRtUTFIOWcxdStFN2FXS2pVZldr?=
 =?utf-8?B?OHkzbVZsUnJFRm43dUZnQXUzcWhWdmZRK0dIZVNSS1lwL2dQS2ptcnJYRWdq?=
 =?utf-8?B?cG44YUluZEtPT3VDT0lHR2kweVlqMnc5VmMzMGRNd1RTUytmdU0xdE9tT2s0?=
 =?utf-8?B?aENuT3VoUHlhcnFZTStseVdpTHlEUWswbGQ4bUZja1J6R01CdE56c1VxQUp5?=
 =?utf-8?B?WDNDYnRSSEhuUHcxemV0ekdTQmtVeWRad1BVWkg2bnNkRUNHVFg3MGJjemVt?=
 =?utf-8?B?dUtoc09JU2dVVjR5SDZiQStFWHp6VUliRXhmeDdTc01nTTNSOWsvbzNDRXJO?=
 =?utf-8?B?YXd4S3U0dXFadjlFVTNoU21sMFFoT3h2bWduTzNsMU1saVBiUnF5bmpTK3dn?=
 =?utf-8?B?cUZ2ZW04aU9zNWxZWGsvOVRVMlI2KzYxQ201VGFwVy90a0M4bUhEVE0vWWJw?=
 =?utf-8?B?bC8yNTZhOVA3Vkk3Nk9Kdzk2d3VJaVVCNjg3VU5GeEp1VGlnc2tndVVzQndS?=
 =?utf-8?B?ZkFJV3ZjSXFVcVFZNnhRREc0Y3pxaHdOd1NiUTRHL0h5UElYQ1dVNHF4Sk5x?=
 =?utf-8?B?VFAwU2g5UUUrVWhtM1ZSdHlOM1lrR2htS204RjcwRkdhMkVLb3lWYjlFdEFx?=
 =?utf-8?B?OTdYTlVocVp4eFlnUmMwZURaZ0VKUGxDbVcxWU1PT0k0aVBIaUdPWGNKdTNy?=
 =?utf-8?B?emdTMUh5RmJxc0ZPcE5LV242c1kwQjVoUUNtQ29xUml6SXV0TE1HeWFPQmtS?=
 =?utf-8?B?QTNJQjZqUUN3ZXdDUWxiNVZCQTlBYURPY3N6TTZLWDUzMVlXaERWSk9ldWpn?=
 =?utf-8?B?TmR1a2ovcndFTjZWc2phWlBub1BTY0x1YVYvME95VlA3cTJKVzZ6VGpCTEt3?=
 =?utf-8?B?WDduWkZ0L00rckVENXU4ZjlYekJ6RFd4MTdZOGxBTS9SZzFNU3hyOWRzeFFV?=
 =?utf-8?Q?tXog=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8feeca90-e3d4-463a-8c33-08de39cd5bc6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 22:25:30.5130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEY17UKMksAshModkrRo9oGOppdw+Ti2FREN1TjIJUpzEiOHPuVNiZN4NpWyrw9ETFq90EkL2Mgro9D+X264jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9053

Move the channel-enable logic into a new helper function,
dw_(edma|hdma)_v0_core_ch_enable(), in preparation for supporting dynamic
link entry additions.

No functional changes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 128 +++++++++++++++++-----------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  49 +++++++------
 2 files changed, 91 insertions(+), 86 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 79265684613df4f4a30d6108d696b95a2934dffe..cd99bb34452d19eb9fd04b237609545ab1092eaa 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -318,6 +318,67 @@ static void dw_edma_v0_write_ll_link(struct dw_edma_chan *chan,
 	}
 }
 
+static void dw_edma_v0_core_ch_enable(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+	unsigned int long flags;
+	u32 tmp;
+
+	 /* Enable engine */
+	SET_RW_32(dw, chan->dir, engine_en, BIT(0));
+	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
+		switch (chan->id) {
+		case 0:
+		SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en, BIT(0));
+			break;
+		case 1:
+			SET_RW_COMPAT(dw, chan->dir, ch1_pwr_en, BIT(0));
+			break;
+		case 2:
+			SET_RW_COMPAT(dw, chan->dir, ch2_pwr_en, BIT(0));
+			break;
+		case 3:
+			SET_RW_COMPAT(dw, chan->dir, ch3_pwr_en, BIT(0));
+			break;
+		case 4:
+			SET_RW_COMPAT(dw, chan->dir, ch4_pwr_en, BIT(0));
+			break;
+		case 5:
+			SET_RW_COMPAT(dw, chan->dir, ch5_pwr_en, BIT(0));
+			break;
+		case 6:
+			SET_RW_COMPAT(dw, chan->dir, ch6_pwr_en, BIT(0));
+			break;
+		case 7:
+			SET_RW_COMPAT(dw, chan->dir, ch7_pwr_en, BIT(0));
+			break;
+		}
+	}
+	/* Interrupt unmask - done, abort */
+	raw_spin_lock_irqsave(&dw->lock, flags);
+
+	tmp = GET_RW_32(dw, chan->dir, int_mask);
+	tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+	tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+	SET_RW_32(dw, chan->dir, int_mask, tmp);
+	/* Linked list error */
+	tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
+	tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
+	SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
+
+	raw_spin_unlock_irqrestore(&dw->lock, flags);
+
+	/* Channel control */
+	SET_CH_32(dw, chan->dir, chan->id, ch_control1,
+		  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
+	/* Linked list */
+	/* llp is not aligned on 64bit -> keep 32bit accesses */
+	SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+		  lower_32_bits(chan->ll_region.paddr));
+	SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+		  upper_32_bits(chan->ll_region.paddr));
+}
+
 static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_burst *child;
@@ -366,74 +427,11 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
-	unsigned long flags;
-	u32 tmp;
 
 	dw_edma_v0_core_write_chunk(chunk);
 
-	if (first) {
-		/* Enable engine */
-		SET_RW_32(dw, chan->dir, engine_en, BIT(0));
-		if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
-			switch (chan->id) {
-			case 0:
-				SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en,
-					      BIT(0));
-				break;
-			case 1:
-				SET_RW_COMPAT(dw, chan->dir, ch1_pwr_en,
-					      BIT(0));
-				break;
-			case 2:
-				SET_RW_COMPAT(dw, chan->dir, ch2_pwr_en,
-					      BIT(0));
-				break;
-			case 3:
-				SET_RW_COMPAT(dw, chan->dir, ch3_pwr_en,
-					      BIT(0));
-				break;
-			case 4:
-				SET_RW_COMPAT(dw, chan->dir, ch4_pwr_en,
-					      BIT(0));
-				break;
-			case 5:
-				SET_RW_COMPAT(dw, chan->dir, ch5_pwr_en,
-					      BIT(0));
-				break;
-			case 6:
-				SET_RW_COMPAT(dw, chan->dir, ch6_pwr_en,
-					      BIT(0));
-				break;
-			case 7:
-				SET_RW_COMPAT(dw, chan->dir, ch7_pwr_en,
-					      BIT(0));
-				break;
-			}
-		}
-		/* Interrupt unmask - done, abort */
-		raw_spin_lock_irqsave(&dw->lock, flags);
-
-		tmp = GET_RW_32(dw, chan->dir, int_mask);
-		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
-		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
-		SET_RW_32(dw, chan->dir, int_mask, tmp);
-		/* Linked list error */
-		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
-		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
-		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
-
-		raw_spin_unlock_irqrestore(&dw->lock, flags);
-
-		/* Channel control */
-		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
-			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
-		/* Linked list */
-		/* llp is not aligned on 64bit -> keep 32bit accesses */
-		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chan->ll_region.paddr));
-		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chan->ll_region.paddr));
-	}
+	if (first)
+		dw_edma_v0_core_ch_enable(chan);
 
 	dw_edma_v0_sync_ll_data(chan);
 
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 27f79d9b97d91fdbafc4f1e1e4d099bbbddf60e2..953868ef424250c1b696b9e61b72ba9a9c7c38c9 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -194,6 +194,31 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chan *chan,
 	}
 }
 
+static void dw_hdma_v0_core_ch_enable(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+	u32 tmp;
+
+	/* Enable engine */
+	SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
+	/* Interrupt unmask - stop, abort */
+	tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
+	tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+	/* Interrupt enable - stop, abort */
+	tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
+	if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
+	SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
+	/* Channel control */
+	SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
+	/* Linked list */
+	/* llp is not aligned on 64bit -> keep 32bit accesses */
+	SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+		  lower_32_bits(chan->ll_region.paddr));
+	SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+		  upper_32_bits(chan->ll_region.paddr));
+}
+
 static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_chan *chan = chunk->chan;
@@ -232,30 +257,12 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
-	u32 tmp;
 
 	dw_hdma_v0_core_write_chunk(chunk);
 
-	if (first) {
-		/* Enable engine */
-		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
-		/* Interrupt unmask - stop, abort */
-		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
-		tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
-		/* Interrupt enable - stop, abort */
-		tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
-		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
-		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
-		/* Channel control */
-		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
-		/* Linked list */
-		/* llp is not aligned on 64bit -> keep 32bit accesses */
-		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chan->ll_region.paddr));
-		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chan->ll_region.paddr));
-	}
+	if (first)
+		dw_hdma_v0_core_ch_enable(chan);
+
 	/* Set consumer cycle */
 	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
 		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);

-- 
2.34.1


