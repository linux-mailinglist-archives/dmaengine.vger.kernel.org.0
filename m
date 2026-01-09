Return-Path: <dmaengine+bounces-8153-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF66D0AE9B
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 16:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AB59307C9C5
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 15:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671A0363C57;
	Fri,  9 Jan 2026 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CDvcN1Xk"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5635EDA8;
	Fri,  9 Jan 2026 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972559; cv=fail; b=DyDRj5nQsTHTYa1ksLCI7v+dM7Lwbt0yCnKCKvqZBvoISqEtNNiZltKveo94j/F8clSaZkJNPxCBm99mf+jLXch9ua2tuxc5oInVxPRSXbp9jvxiiWbM5hpAG6W8wWUj1nD508CgJQKvFipPEcrFIN7l6Pc+z1f8RSTn4R3f6Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972559; c=relaxed/simple;
	bh=BVei9oaxixdZN/1lIiuFf7ag2w89A7PX0bp9V32XQPg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iCr3GS9xfSHu//qeexQP2b1SdEcpbMbKpt1CWtYt7XJS2fOwdlSu29l7/3lEhup4FcUnwzC1bHRpWi0T6qAeygl96gAxAc2wVLKRcefV2zP16eRtUxGkhNf27YBilIr2mupJ6RZOc9F5+WXKCX59yHknIDW7PKQxSQFIHztR2z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CDvcN1Xk; arc=fail smtp.client-ip=52.101.83.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d84heULISTaO+kXGo6CwgxL6MvsfJgnxbVGBVKIHl5py+qDcCGVIE9Yz/jBKr65Tllx1OpXQSwxwf89jTUzt4QR0b1pIxNs3CnR19wH5UpNcXsiKsY0Os+lLrbl2KIqr1pnwW1XP17kEp5KRp7ayTVH7sc6dJBOfGu3+RCWw+gjUc616gAVnCD2+ZtUD+0O5cSsIIA+ZNajziB83oek933yVaKilxNdWMVrU2ybN39mODZj/pmtZFau7svIViuFJ55pvZ8B0RB7zEw5eoJ6BWGjsZ20rwzwRA6PX3lTPfXF9Uhpp1qsZkA2gaxkeXPDAA9bqgddOwU3OYjv1JPqOjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TgGwDV/YKOQf4IuvHzx8VIIgBxGCZOV4+RWNREuWb0=;
 b=IZEx8qKDLd+e2HzjTVixl5mic3AgqzJc8/sW32SHsWJlkqjxdtqeMQYhcV+jvrADs4d/dcvCeG0aXTbjGenB7xc1tUGlznwBdze8k+4c8zsuGGc9uO6QqgLv+KVdEIhDh34udZrip8+GY8+smm8zDR/5s44/GoOnaLaCKEfDg1S70htttSLmHKuPiiVwmJnamjEaxhAmxZcGgx87eefs4eollKw9nZKkoeyY1nh98mRL/aLcIkyFVQTcAMN1r9pWktLBLthGrMeNF/5qm/2x7rfEJtyoWi3etn+vHwj0DxRBjLWonCkJHOJ9lvnAa6qtbZu/HxSTyamtXBglj7DBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TgGwDV/YKOQf4IuvHzx8VIIgBxGCZOV4+RWNREuWb0=;
 b=CDvcN1XkmIRObIVXNDNXnWjfmDyftHuNRyWZvifm2Qkj/bJ/YH6eadIX5egcRVDeU6tA3BJaB4MNcJuoEJfTdHDwr4BPNMtiyxlLatshVh5bV0hUsgpUyKt6qRCgjl39jwEtDUaPsjkA0XL7XWXSQK5AruvZtl4z1okY/StjFOdhLgQqywBXcnxWDtWiRgVLbykI3ZMQPnxuD6NUoivohC960Ui7i5lW0u617YayeDxP7plDcI0JhDjgR1bn4puS1zwavzGwB/w5k+BJrdgkVu4fEoNeMx9FIxfjfSmnWsvArECPHKKcfRVXAnxRdLT+1VLLtFM72ReqoxKv6hWE0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 15:29:13 +0000
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5]) by PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 15:29:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 09 Jan 2026 10:28:25 -0500
Subject: [PATCH v2 05/11] dmaengine: dw-edma: Move ll_region from struct
 dw_edma_chunk to struct dw_edma_chan
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-edma_ll-v2-5-5c0b27b2c664@nxp.com>
References: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
In-Reply-To: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767972522; l=9173;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BVei9oaxixdZN/1lIiuFf7ag2w89A7PX0bp9V32XQPg=;
 b=5eO8Z0dkpBcBQy8oSqcK/jwkQKaLVfH5WhDn7ooeiiUmHyq6E6LvWaZoSAlCcNwHB2xyffZsG
 AuFoh45rXqPD6EXGDSiHLjND6n6enjvRcxWi1a1amkljWS8Xi+WFhf9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0069.prod.exchangelabs.com (2603:10b6:a03:94::46)
 To PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8957:EE_|DU0PR04MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d62b5f-e989-4e88-1558-08de4f93d7de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1h1dEVuTVlTeHdqSUpLVFowclRzQTRodGpVekorRmtUc3VzL014ODVhVW0v?=
 =?utf-8?B?ZDIvRkZmM2srQTZxMmczeGZQSjVmQXFvbnQxTkh3djRsbENlTGNuUWdzSmw2?=
 =?utf-8?B?RnBFZHg5MHBZdStpS3RXclhwNURMMXZ3ZThoYnFKeHpxVGE1NS9Edy8vSnJK?=
 =?utf-8?B?Uy9RdW12Q1RSSmpmYWxjd09zb1phR3VnK2xwNTUrVGdGNng0bTVKbmRSODNu?=
 =?utf-8?B?dEp0YXhiQmNRNnV5d05yc0tScUlXNXhvNFRTU1B4a1k3WHpvNjNJaEFoUzhs?=
 =?utf-8?B?K0wzTGZYYmRzOGYvTjc5Rkw5SkRtV280eDJLSk5GclRsQnhkaEpJT3BvRCtw?=
 =?utf-8?B?Z1NYSmI0NXNIazUrRi93cXV4QTRVa3JYdDRmN0lzdnl5bTIvRzFYZmUxSC9V?=
 =?utf-8?B?azVSdm4wTHZvMHBpWXFtakUwaXZ2UEdRYlRnVGJGNThCTWdTaVpSeXNkSlFC?=
 =?utf-8?B?d0VqK1kzcGZhdUQ3Ymg0SCtqdGs4N3Y1SkozZm9rSjJaTSt6YkNSVm1BMXRH?=
 =?utf-8?B?RGhEMzRMNHVtSmtveG9OK3JKNlRWY0VFd1NMb0M4MXFIUnp0aTJDakFtZnhP?=
 =?utf-8?B?bHBybXlOR1Q0R3NudGxpakpUb1cxLzJiOEhzVm9BTGdJcnRyUGxSOGFzTE1n?=
 =?utf-8?B?UWlhb3VnNFNkZ3NUOUc2TzUvWm9ST2M4ZnJIaVdqY1h0ME1oVCtBaU9qY3VZ?=
 =?utf-8?B?YUFpdDFnNytCdElDRzJ3dnM3eFNsVzRpN0d3WWkveUFDRjU0Ykg5ci9zZ0FQ?=
 =?utf-8?B?V25FeW0rODdiYmVHSUVRK0txSXpKM3Bxd3RQb3BxN1N4b2R3RHpDNTYzRFMx?=
 =?utf-8?B?TlFWWkY1bDh6cytKY2FOS2l4VzZUMlZmb0tkcDY3YkRFY3EvYnkxVWtxUHBT?=
 =?utf-8?B?RmdmYThDZnVTN3J3Z2U5M2FBUG1UVERnNE50ZUlhSHNza2dHZTgrV3JDNWd0?=
 =?utf-8?B?NmFwankwZmxKZkVSZUdvMGMzSjFpR25jOUlmUFBVdDJnbUgyalhtbUVBUW9C?=
 =?utf-8?B?dm5lWGtBV1BTbmp1R3l4ZnFqWmw2MW9keXp3U21hQzhzUFdPR2kwMTl1QkpD?=
 =?utf-8?B?Umg1RHVMd0JqbHFJTkNJeXh0RTdOSjRUTFNEZjFlb3o1Zi9qQVB0N0s4eXlj?=
 =?utf-8?B?S3EyVElvZTNVaGZyNDJTK08yUHZhUWJpZzlkZVpCYUpmSGxDQ3VsRlhndEF2?=
 =?utf-8?B?SndnK0xiYWErcU9BWHE2dllKWDc1bER1Y2M2UFc3QkZGM1BZNVdHVy9mUnY1?=
 =?utf-8?B?TEVFa3lka1ZPTWhKcWRkRmF4THV0YlVESFplUzRmSU5aTC9OQUdSR3QrMEY4?=
 =?utf-8?B?WDNYV0tvbTdTTXBjeGRnTXltQmVZSE01OXhGRmFHcm5EVGRyVldkYW53NzVl?=
 =?utf-8?B?ZmFEZzF4alMwSnByRXU3TExYSXRSbVNSR29mbzRtdFdGa1p4TWVhV0poVndj?=
 =?utf-8?B?U3hLU3dPT3hkb2NPd0xHbzhDUkRyekxYbmp4WEh6TDVVS2t3Mmd6YVV4M0lr?=
 =?utf-8?B?bkFzTmVmSFBrSEc4R2tKT2tpR1lvdjZvOFphSmhmbjFoWFkwcE03ZFBaeHBC?=
 =?utf-8?B?Yzd3d3BneVZGZzZlalQ1WSsvM2ZDV0QrQXJPaERPSXFtc2JIa1BIMTVyWEgr?=
 =?utf-8?B?TXhGOFBmRVJrR0ovaWlhY0N2M1NpMnBMVkwyOTVma3NMeFRUTVYrQzhlWURP?=
 =?utf-8?B?Ump6c1pldDRaUmd0SmR5Ni9pQnVHVjloUkIwTW1LNi9qWThjYTBaOVVtQUwz?=
 =?utf-8?B?RDV3Tk5TaW1WM2NQKy9DM2RFNkZKd2tEcmtRYTJSZXl6aTJKbjZRbmM4cjM0?=
 =?utf-8?B?em5xWnBKKytGRngrZHhveWF5RnZ6bGJXa3ZXK3Z1RFlEMm42K0UzSENhQkg3?=
 =?utf-8?B?dUxXK093UStYbVB5Wjk5OGZQUlp6V1FwOVV1dFNxd0JEWXhMYkR6N255WUU5?=
 =?utf-8?B?cmFieHdob0I3Yk80MHAySWV3WGd3ZU9aUU0vWmRGK2xrK0VaOGRad1VZc0tK?=
 =?utf-8?B?bU5TN09rNnZweDNEdCs4SmZ2c3o0ZlVHUEw3OGk2NVN3WklBcngrZ0FJZm5j?=
 =?utf-8?B?Qk9qZUllQTZvOS9qemlrcWlrZkhZaVJpNEJudz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8957.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2pHaXJlczBUcXVFWEhXNk15d2dmYTh4Tng3SDlpY2V5blZ2T2NzcGNpL21t?=
 =?utf-8?B?aEhITDdkM2w3b3BiK0l5L1FPVmhST2VMR3dqRktLT2wwY2JzZklzR3dROTFq?=
 =?utf-8?B?Vy9wSXQ1Znhpdkx1UzIvSVVVUkdmdGhNa3I2d0hubDIydGZJZUNidnA5NnAv?=
 =?utf-8?B?eWI0R1BCMUZLM1Jxck9SbnRtcHF2ekIyUmRSdThpcE0rRXhKMmtLWWtpQXNM?=
 =?utf-8?B?azh4aFpLRXR0NWVKS2FBaUg1SEtvY28xRGRqdW5WRnZRamRkRjJ2ZUJCRUsy?=
 =?utf-8?B?MWV6SVhnWVZIZ1NHaGpXZCtoQnBrZFBOVE5LbW5ZK1d0SnFnNDhzR3Vnd1Uv?=
 =?utf-8?B?TjZLVThyMlpocmdmSitPSlQzT1hQT1VuU3l4aXA4N2RDajhVcXFsdmdTQitW?=
 =?utf-8?B?Q25peEJxenpYR0UrVUlZNlZKT0p6eXVOSDQxejd6NTNFV3paUWNzYUs3N0xT?=
 =?utf-8?B?RXBWa2g2NjdXVEgzQ2xoTFBiYjlIZm1uRGpQRmZaWk5HOEsxTElEWWJuWnFD?=
 =?utf-8?B?Z0VUeS9OVVEwOUxEQ3cvQkNVZlBmS01JZTBBK2pqUzFrbmhQOE93UlpmelRC?=
 =?utf-8?B?VXRjdDh6M2tDTVhxaTdyTHlFUk9jRjhhZWdRY1ZndUFUaS9WMVYxd1lJSXlO?=
 =?utf-8?B?ajE2OVRJbmwwRVZOWG41a25TTWhJanQ0bWxRaFMwMnpHSVNjRDNKc1RHMFVM?=
 =?utf-8?B?N3NkWU1hUEVUSEpDSnhHZWxNaTNwN2JFbVdmVnhLVW9sUlFmM3E0YXBxOTJ0?=
 =?utf-8?B?NXp5cnhUZjhaMElrR3phVEwyNFBZeWI2a1c2VE8xcXVzTE9DZ0dwVmp6QXd3?=
 =?utf-8?B?Wlc4UVQvZ0ZlMzdQMjZRYTZGMnVnTUI1WE5TSzFteDY0RXRCcjB4d3A4WEZ2?=
 =?utf-8?B?bDNZN0J0akdUTXF4UXU5Vmx6WHN6YlpKTFNEUTFDZVFCcERrTmtjZXBFN1Rp?=
 =?utf-8?B?SmEvQ1RvZWcxVXh2ZTFFVW03eWE5YnBTbG9XVmg3Z3daN3VFSEJIS3NZU016?=
 =?utf-8?B?S0V6UlBhRWJzMTVVQldvQzRjelFxaWlVN1FnZmpKQU4wNTh0alBWY3VOZG9F?=
 =?utf-8?B?WkFVQjA0cDBvTHUyaHl6RmFsNnFZUUFBMCsrQzFsdXcwcWdrN2JLbUhkMk00?=
 =?utf-8?B?bE8rZEFuUDJtWER1a3FGaEpONTVMLyt0akJyNUZndkh6STIrck1sU05WWnpo?=
 =?utf-8?B?MlJMcml3SktGZ1MxcFg2TytsdGZQdTY3enByMWUycG0zN0pyamFvMDFNZWox?=
 =?utf-8?B?VzF1NGNsY1FXVVBkeXlDOFU3Wll1dDZhdDVNbzZwQ09lOHZqNDRaTm4yS0p3?=
 =?utf-8?B?VHQxelhJUjhrNlhHMndpMmJmR2owR0YzK2U5SkplR01laWgrcCtWcGJOb0No?=
 =?utf-8?B?Q1Vzd3pZVW5Fa2RWZnpFL0RNQTlNWXNzQU9XbGs1YVBzRys0Qzg5djN1aTZz?=
 =?utf-8?B?MXUwQnZjd0JRR3FlZWI1SjB1d1pzbXg3N3BwOFVFUFpObkRqaHRSeHMycjE1?=
 =?utf-8?B?bzkremwwUEN1MEdPK1ZCTDhnMEFrSy9IT1hNZVhYTGdvY1prbWh1VS9rQmdP?=
 =?utf-8?B?MUV4NTVJRkhadE9rVFZOajM3NEl0TWU4U3NqMFB2d1h2Wm1KQUg0N1hlSUZI?=
 =?utf-8?B?U25weVBIYkFhTmp5WGpUM1V2ajFzaHRQZDUwMkxZM1phbUN6ZVVZSU5nc2hp?=
 =?utf-8?B?SW1UNlhMR1h0TW5sdTRramN1QSsyQkp3aTZtQkxhTFFPblp3UDFWMW9tRnF4?=
 =?utf-8?B?SjhMNnkrZGMvZ3l0alJZTVhSZGtLb2pXSUUrMDg5SjBKbjdDL1VSUEZ6MUJm?=
 =?utf-8?B?ZkRZcVQrM3psd2tHdVZVNW1tQ1dHQkN0K2hMNmRTMitEM3J1S3dTK1BEbWEy?=
 =?utf-8?B?ZVJld2pTSGRuR1pvMHR4djN1cFI1b1ZHYjdSNHMvWlhNT0FmWk51UTRiK3BY?=
 =?utf-8?B?WmpJNWRkSDIzTnVQU29pbEZvN216d1kzSlNwdXdBU1VCMlc5cTJGTVRKcjF4?=
 =?utf-8?B?ditJRzQ1ZG1pdmNnS2FHd3hZVjlqaGJYcmtkWnlxNXhxOWRtWTVNTi9FeDcv?=
 =?utf-8?B?QVVEd3pBZmZ1K1A0c01MeUJtZm5qSEpPWjJ6YnRBVGNveG1xN3B6SkpoTDBP?=
 =?utf-8?B?cEIyLzJDbHhIc1hSaTF3b25ONG9NVWlYNkFQTTJSNHJsejdxMjRNZFlrQnVu?=
 =?utf-8?B?Z3VnOURLWUxQR1FDdkRhN2l3VVY2YjkrV3dkUWNoRzU3emRKcUYzQTlYeVIw?=
 =?utf-8?B?aVV0OGZZQmQxcnV6SVdURGE3SU5CWGowWWJtb0dSNGZJNCtNU2p1OFBySUZn?=
 =?utf-8?B?WDFZUE53ZGp1MW84MFBnOTVsVXFTeUZ3VS93c29RYVNuZEZxeE80dz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d62b5f-e989-4e88-1558-08de4f93d7de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8957.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:29:13.7131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: biMjwASfsApzFfahybSiFQEuXsveA56xSs6qxrfYXBHHUOIEXrugrDLYF8dsUbH+U0TbdROJrTsMaX2c5HjyuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371

ll_region is identical for all chunks belonging to the same DMA channel,
so there is no need to copy it into each chunk. Move ll_region to
struct dw_edma_chan to avoid redundant copies.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 14 ++++----------
 drivers/dma/dw-edma/dw-edma-core.h    |  2 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c | 18 ++++++++++--------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 18 ++++++++++--------
 4 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b154bdd7f2897d9a28df698a425afc1b1c93698b..5b12af20cb37156a8dec440401d956652b890d53 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -64,7 +64,6 @@ static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
 
 static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 {
-	struct dw_edma_chip *chip = desc->chan->dw->chip;
 	struct dw_edma_chan *chan = desc->chan;
 	struct dw_edma_chunk *chunk;
 
@@ -81,13 +80,6 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 	 *  - Even chunks originate CB equal to 1
 	 */
 	chunk->cb = !(desc->chunks_alloc % 2);
-	if (chan->dir == EDMA_DIR_WRITE) {
-		chunk->ll_region.paddr = chip->ll_region_wr[chan->id].paddr;
-		chunk->ll_region.vaddr = chip->ll_region_wr[chan->id].vaddr;
-	} else {
-		chunk->ll_region.paddr = chip->ll_region_rd[chan->id].paddr;
-		chunk->ll_region.vaddr = chip->ll_region_rd[chan->id].vaddr;
-	}
 
 	if (desc->chunk) {
 		/* Create and add new element into the linked list */
@@ -767,9 +759,11 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->status = EDMA_ST_IDLE;
 
 		if (chan->dir == EDMA_DIR_WRITE)
-			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
+			chan->ll_region = chip->ll_region_wr[chan->id];
 		else
-			chan->ll_max = (chip->ll_region_rd[chan->id].sz / EDMA_LL_SZ);
+			chan->ll_region = chip->ll_region_rd[chan->id];
+
+		chan->ll_max = chan->ll_region.sz / EDMA_LL_SZ;
 
 		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
 			 str_write_read(chan->dir == EDMA_DIR_WRITE),
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 722f3e0011208f503f426b65645ef26fbae3804b..e074a6375f8a6853c212e65d2d54cb3e614b1483 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -58,7 +58,6 @@ struct dw_edma_chunk {
 
 	u8				cb;
 	u32				xfer_sz;
-	struct dw_edma_region		ll_region;	/* Linked list */
 };
 
 struct dw_edma_desc {
@@ -79,6 +78,7 @@ struct dw_edma_chan {
 	enum dw_edma_dir		dir;
 
 	u32				ll_max;
+	struct dw_edma_region		ll_region;	/* Linked list */
 
 	struct msi_msg			msi;
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 1b0add95ed655d8d16d381c8294acb252b7bcd2d..a1656b3c6cf9e389b6349dd13f9a4ac3d71b4689 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -280,9 +280,10 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_edma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_edma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
@@ -290,7 +291,7 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 		dma_wmb();
 		lli->control = control;
 	} else {
-		struct dw_edma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
+		struct dw_edma_v0_lli __iomem *lli = chan->ll_region.vaddr.io + ofs;
 
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
@@ -303,15 +304,16 @@ static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_edma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_edma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
 		dma_wmb();
 		llp->control = control;
 	} else {
-		struct dw_edma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
+		struct dw_edma_v0_llp __iomem *llp = chan->ll_region.vaddr.io + ofs;
 
 		writeq(pointer, &llp->llp.reg);
 		writel(control, &llp->control);
@@ -345,7 +347,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_EDMA_V0_CB;
 
-	dw_edma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
+	dw_edma_v0_write_ll_link(chunk, i, control, chan->ll_region.paddr);
 }
 
 static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
@@ -359,7 +361,7 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * last MWr TLP is completed
 	 */
 	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->ll_region.vaddr.io);
+		readl(chunk->chan->ll_region.vaddr.io);
 }
 
 static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -430,9 +432,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		/* Linked list */
 		/* llp is not aligned on 64bit -> keep 32bit accesses */
 		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chunk->ll_region.paddr));
+			  lower_32_bits(chan->ll_region.paddr));
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chunk->ll_region.paddr));
+			  upper_32_bits(chan->ll_region.paddr));
 	}
 
 	dw_edma_v0_sync_ll_data(chunk);
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index f1fc1060d3f77e3b12dea48efa72c5b3a0a58c8b..c12cc80c6c99697b50cf65a9720dab5a379dbe54 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -156,9 +156,10 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_hdma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_hdma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
@@ -166,7 +167,7 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 		dma_wmb();
 		lli->control = control;
 	} else {
-		struct dw_hdma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
+		struct dw_hdma_v0_lli __iomem *lli = chan->ll_region.vaddr.io + ofs;
 
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
@@ -179,15 +180,16 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_hdma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_hdma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
 		dma_wmb();
 		llp->control = control;
 	} else {
-		struct dw_hdma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
+		struct dw_hdma_v0_llp __iomem *llp = chan->ll_region.vaddr.io + ofs;
 
 		writeq(pointer, &llp->llp.reg);
 		writel(control, &llp->control);
@@ -210,7 +212,7 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_HDMA_V0_CB;
 
-	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
+	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->chan->ll_region.paddr);
 }
 
 static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
@@ -224,7 +226,7 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * last MWr TLP is completed
 	 */
 	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->ll_region.vaddr.io);
+		readl(chunk->chan->ll_region.vaddr.io);
 }
 
 static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -251,9 +253,9 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		/* Linked list */
 		/* llp is not aligned on 64bit -> keep 32bit accesses */
 		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chunk->ll_region.paddr));
+			  lower_32_bits(chan->ll_region.paddr));
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chunk->ll_region.paddr));
+			  upper_32_bits(chan->ll_region.paddr));
 	}
 	/* Set consumer cycle */
 	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,

-- 
2.34.1


