Return-Path: <dmaengine+bounces-8557-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDs9M41Qemnk5AEAu9opvQ
	(envelope-from <dmaengine+bounces-8557-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:08:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCBAA77C7
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 064323019812
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 18:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7CC372B35;
	Wed, 28 Jan 2026 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VV0kreT5"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013040.outbound.protection.outlook.com [52.101.83.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE00371079;
	Wed, 28 Jan 2026 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623554; cv=fail; b=EmRVrKUb6o9YvPIX4/neYHKurBRFd89FgnlJRaVA3A9lKjjSlV0x4SaWN7K5agk5VKy/Z+2yqNCj7xcuXCct25GZ/WtLhsj/SC2BKWMmnhvO9CrDfHoIiPB84/ZkXWbOtOl/RFzhuMotUtdtVhZXd4XChoPsxwrvqdKg6tAVq88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623554; c=relaxed/simple;
	bh=AHVBEh0gnNWpb8Hjx7zcg3/86QC2AIilWWxv7QMQz6s=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=bPz6vzwN91mpTYq7NRemsAn9u/Um2oPfcWknN7FXY9Xrp1RHglGUH/fgqYRCdSKnnpo7T2vRtP+zyXcs11X9k/rOvsf6rYW1AV8H/1XW9fnaKFbgjH9CSv4uIZ5YHXcFJSajDpTgmROwrYezoaUkEV77vR7LwLcOLZKEP25fZe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VV0kreT5; arc=fail smtp.client-ip=52.101.83.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKh5xuy4PH3U7xW3Gh05IJhmQ/G4frm9YsdUO3AKMNkSW57v+j+jh54IjzvKSgwqY1KhXlfjG9daIvCjRepKBXJLSUAdI1uAPuwLYj31DpwZYUUsrducUNLuSvdgLu6L0wZVe6evIYHzo2n1eSYUEXsA5i5t4AA0aUB2yqDgplIKTD3HxxPnGJ6XUxycQpW/Ojsf8yutURU2sEfnr4XxqC8f9jGcr76dzZrHjBtXBGuvM6d2wQQZ9SaqllXiuy/PDM9KYN4b39xYRUMej4AMZmm2wOybBDJGuwzhFAHhEcmZjgaL2pei5fhJKFO+xomTY4E0OVS3t4AlevLrZOqySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqVEgMXgTtBM+ViEpecO8YlLYQXtNEsOck60hKhdQ6E=;
 b=UHIR5aa2TABwTu68JZr6XCGVxooLRKDpeBtT/Z9VtgjN8swNceTRJAX8EjyELO069FTF5V7gPPfoiUkyxSr5ND3tornSF9x+h1L/FzA/bQFE7VwAW8ABuEY8R3jKhxlftPAZSuCnTutb/pW0M+qs1h/Hgvw2/W97lDXgSQZgr/qxbNCTKsGmeIscCiZsJG14IHl6//nHodsAe3O6PB5ZJD2FquP0Hvzyt7nny31+sPlIVsgDAdUlysRO79EQlUtKrYIYeVRz0KzzyENJGT7aYXN6FpbuV/P1gP8e7EE+eqB0aV9Lw+KsBXQwY7Xbu0R1Ie3ql1nqfJeSnCjqjHVJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqVEgMXgTtBM+ViEpecO8YlLYQXtNEsOck60hKhdQ6E=;
 b=VV0kreT5VH5VP4skYRhhtD0X0uMGHxWHzOJ5ToCzkOZDtpeMppxZH4ZyPRB1dhaPf5rQHMhNJV+aR5/HvQ17gsfaRn6w25oeXKeulh0LhWTp9KIvG1wwg0BfQw1MyOnYKHa/yXUDLqs2CiS3UDgEEFfcnkIVcthiBfeipj1UVpyRTnCuajt75e/UTozAdDLwqKBiRpvBfR1HOcJqaxuIqLkldkCTtXVSqHM6bhnmY54FwGRDBFkCwjn0oTl0ckrWTFZH6t0twCmUGOUAPdmYTAc+D0rWyK5+SAbYU2gtEjLJpdk2iDQlXFcIGNOVe5zXqidKSxo4Z0Rom9va/yAoVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 18:05:47 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 18:05:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH RFC 00/12] dmaengine: introduce common linked-list DMA
 controller framework
Date: Wed, 28 Jan 2026 13:05:19 -0500
Message-Id: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAN9PemkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0NL3ZTcxPicnPjk/NyczCTdpEQzy2RTUxNLQ/MUJaCegqLUtMwKsHn
 RSkFuzkqxtbUA87XngGQAAAA=
X-Change-ID: 20260119-dma_ll_comlib-ba69c554917d
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769623545; l=2736;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=AHVBEh0gnNWpb8Hjx7zcg3/86QC2AIilWWxv7QMQz6s=;
 b=FV8VZhoMlFlfrK8TB7GXIUSZDR6Ln3H3q+kxmebl7Kb6FQDCtwumCkxOW/DpStnXRD5d897fU
 NtYaLP2Ze4LC7heGn1WEqvdTDu7k9Vfq4AYo9Z3akP0e7RhZs5z3idE
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:806:20::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 582662bd-9cc3-42fa-30a6-08de5e97dcea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXRCVjRyZThacTYxRFc3eGpFOS9qekNSOGJIZXQzZGs1a1E0M2VYSW4rY0xi?=
 =?utf-8?B?N2JpNmFIVWhYT3VNcW9wd3hMaldjb2dEOENCSGZOOXBTeENsbjR6ODBaOXVv?=
 =?utf-8?B?dk9qbm9VOFdPM1R3djgxY0h6bWJ1ZUJ5Ym84Q0pzNGpXYjM2UWpzSlBNZDNU?=
 =?utf-8?B?NGpHVE1GYmpadW5tRmc2cmpLS09kUlg4THd5YkQzVHNyK0ZhYStLeEtDZEZ6?=
 =?utf-8?B?OHpIL2NqOWthM0lwRHZFazV5VkYrWUNOQ2hIZFpSS29oREtHMno2djcrVURO?=
 =?utf-8?B?VFIxVk02aG5pWTFmUHlLR2FsdnJ1bldPeWFJenhsZlhpMVpFQ2cxbUUycHdu?=
 =?utf-8?B?NmxHeDZ2N01td0luYU9vYngzaTlOSXlZVjRQbjdsbE1ZcUN4cW1NMFVCOFo2?=
 =?utf-8?B?YURWUlNiN3JTbkJUOVc1ZG9mRkpFeFd5WWFTVEZBZFpJejhLckhGUjUycHNr?=
 =?utf-8?B?eU5zaHNFellnR0xXNVJaeTRWRDQ2MWtDdkpKcW0rY0RtdUp3ZURsNlN1QTN6?=
 =?utf-8?B?aUhaNGx1RlV3TmNPV3hTMDA3OFBCSzcrQXFBdXptdE9xTjkrMGxickZBbVZX?=
 =?utf-8?B?b0lFb1l5T0ozYWg5bG1uTXE2Vm13TUpGTmhxbDNyenp1Q1IrU1J2UlM5RTBG?=
 =?utf-8?B?YlVZQTd4bC9ZamFld1B5L1BBeDRZSWRPWU1ObGRJbmljNmxWMEVIOUlEYVJ1?=
 =?utf-8?B?eDB3NVRYaEFJdWVhcnZpaGNaNzBYWEhNWXFnUnpmK3JJUmN1U1FlKy9ZK01F?=
 =?utf-8?B?SWxrV1ZXb1Z4WkxxYTRWN3VrU0ZYMlVTM2k2T29lVWgwUWZmeUg5SUdOY3lo?=
 =?utf-8?B?OVcyQUkzTGlUbnF5ZEpFQUUvdGxuTXYrbjd6WmE2L0FsN0RCVTZKN1NIMXN1?=
 =?utf-8?B?bTRzWXZkbHFBajNxMUY0L2pSTzJTVHpLV011ZmplZWhWQUR6Tklsd2RZUUU2?=
 =?utf-8?B?L1RKS0M2ZXYrN0tEMFFDb2o5VldnaXdURGdIb2xzdm1NL1hzWHhVUkZsdVp0?=
 =?utf-8?B?ZWs1OVVROEZoZ1Ntd0NQZzlYYTAwQk5Sd3hIQ25BM1gybE1mZkVlSVFVTHJD?=
 =?utf-8?B?bmNkTjNRVVFKSk0rUVJKNUI2aVVRK2o2OVcveXVPVHhVcVB2R2RLSlFnN3dW?=
 =?utf-8?B?V3lYRWs3QmNXY3FNMHZPbGhGKzFCMVoyMmwwM2NkekkybnYrQ1F0WmJldG0x?=
 =?utf-8?B?a0ZYMWVURHYybWpad01KTXdaOXpvTUNUTUhIdlBPNzY4SFV3Zjd1ckgvcUwz?=
 =?utf-8?B?MGdDazl6Z3VabVE4SVVRR1dMeHA1WkxPVHZ1S1p3a1hBVlpPRlg0bTdrUnRh?=
 =?utf-8?B?Vy8yU1JLY3gvYXkyKzBDN3oxN1VLbndJdWZWM2dLd0p5WktOWXhCdG9GZjJl?=
 =?utf-8?B?bmxXek1Qek8rUXp5VU5FS1NILytDaVlHTGVFVENDNTIyZmNtUXhZV1EzN1pr?=
 =?utf-8?B?a1VZM3RhdTRxYUZpMFZ2M2k0L0hsZVZMRVR6ekFmRXRhcjRGVmVQbVluSVdW?=
 =?utf-8?B?bUN2YTNaQXNkbFpzNXM2WEhvODBkV1FqdDZJS1dNZnlUMmttK1RiQ0c2bTBF?=
 =?utf-8?B?L2o2OEFZdVVvZXZyUVAvYktvcUREVnhSNFd1QVl0TTc3VVh5ckQ2aUlyQ2dS?=
 =?utf-8?B?aFI4MTh4MHNZTUR4TTRwWnA3ZWhWaVVNb1Z2SGpiVDd4eFZEdVE3N3FRRTFJ?=
 =?utf-8?B?aGNPOUp4azg2MkVKRTR6cEpVc0xnZXd6SDhINU9XS1ladDF0UlRkU3hYSjN6?=
 =?utf-8?B?Z1hJNE94NUFudnphRUkvV3VPRXE1K000c0FtV2RBSnkwMGFYb2ZGc05ENHFv?=
 =?utf-8?B?S0d2b1BSalRhRjlQWUZlVUFIc3dTNDJFak5YZm5WWlJNNmx6Nng0dGRkOGJp?=
 =?utf-8?B?SmpndWtTL0Vudnd0VGFTdlIzVldWYTVEUFlzcklXbVpZUkJSL0VFLythaEda?=
 =?utf-8?B?eThmbzZtV2JUOGxwcUFCTXVwK1J2RFpUK3J6em4veEhmcDYveUFOaFFyazVr?=
 =?utf-8?B?ellDTG1ocmU0bFJZZkhqbEVrbGhwdmNSUVNQOUZVVnJYWU5pZnp0bTNQQ2Zv?=
 =?utf-8?B?K3JaUnFoT0xERnZ5MS9GVGpLYjNSODRzdURqYkx1RHZRd3ZibzRZUEx6ZVpJ?=
 =?utf-8?B?ZSt0dWxxc1FLMGYzRUFndFFkSTJTM2dzVFJxNnV6Q0VaY1IzVlVmZ3JzaFNF?=
 =?utf-8?Q?4Ah5Tvez6MIF+saEcsR+oSI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEt4czB1elJuTXlFNHJ3bXJacE81SFE2M0pYRDlKZEhNTG5OZmg4aGtlK0dl?=
 =?utf-8?B?Q043dzVvN0ZyWlJQUWxsaWdWVU5TSytIcGFZems0bENkRnZFclN3bmZVOE1l?=
 =?utf-8?B?R2E3RDE5ZTRJZlJxRHVqeUtURmczd2pRQ05rVzVoWTI0dU05NUszbjhkNCtL?=
 =?utf-8?B?cFB4d1VMWm1CNVY5MGlzdnJOQ0hqSVdQbHRaM1BLaVQzaGRLSnE4Z1ZLMkx2?=
 =?utf-8?B?SFE3SHYwYXRIc1dNYmVMZUVQaWY1ZnZ1cnc0MHp0NEQ4WXZ2WGVTOFBVT3Na?=
 =?utf-8?B?YVBLTUZGUjJ6L3VvbUpMZHE0WlRIR01CN09PQ25NckVUM0R1eWtjMGhlQWxC?=
 =?utf-8?B?RVRJcUk0OGkwNVFTSUpNUDJRRzdWOU52VklrYUtqekdJM1l0RU5DdkdTL05D?=
 =?utf-8?B?YVVnYXBRNlM0VjFDUEt4SFd4VU9uamExZ1AzYi83Y0Z2ZzFsSVltMXIrQ0Fl?=
 =?utf-8?B?RldhNVh1eFRqelJ5Vkd6WWtpY3pSZ1VmVlk5ekI3dE9DODFDSjIrMlpZSGo3?=
 =?utf-8?B?R1RPNXBIY2tYdmxmYnhtT0JzY25KNXo5ZmZwa3o2QXpqUUJpcFRFMjF0eWhE?=
 =?utf-8?B?TDRWVFNzbzkrUmJCdCtYZkZhOFpTbzUrYmxraVFMczhQajlyNDVaNTV4Z3dn?=
 =?utf-8?B?OUc1bDU3R0dad01GUnlLaHIvMFNtNHdkNGZGVWNTUmFMTjJLS3NDamtFMHBo?=
 =?utf-8?B?UUwyZVh6aWFSa0tLNmV4Z21TQ0RWTTgreUlIdG9KRVJJRmJINWFDdUh1Mzl6?=
 =?utf-8?B?dHljUGxNU2IrMUhJSE9iL0gwbWlQMndSenZOeUI0ajcrajdpRmthN25vUWc4?=
 =?utf-8?B?YS9zQzQ5VDJDbThnUDRsRlhpMS9FK2k4ck1vdGI5TitzYTFQRThSQVMwWHhF?=
 =?utf-8?B?aFViZlgyOTlGVWVQVjhQYkJLZHphQkFTWk50Z205YnVDM2FLdy91VGZyY045?=
 =?utf-8?B?MG9qTzdQcXJSdzVsSGcwL1daN3l3b0RlZmJWdWRIMlpwcHZkc2RleDhUNkQr?=
 =?utf-8?B?d1ZacVhoKzBJYTFKUVVmMUFBWCtuRHZ3NHFYcGZWMjNYOXdodU4rZnJCKzN0?=
 =?utf-8?B?VFZGQlJzK09vMk9WcHY0T0NzNmtmajNLcGNhK2YvbFNHMkxGRnh3TkxMY2lJ?=
 =?utf-8?B?dWNMM016a3MzN0Zock02bGN2Ti9qOTlGN3RnNzlXQ3h3TnVxTlRyL3RxNVpH?=
 =?utf-8?B?andqV1ZKNklkRjAzWmtXeG8rbDJ2aUxYS1RCK2NNRW95dXp2elluaDV1MnNm?=
 =?utf-8?B?a212ZjZnK01PZndvUnRsRHFKWktwV0FLNnUvK0JCWXIvNGx4OHZLdWl4OUpp?=
 =?utf-8?B?aTV5enlpUTNaejl2dk9XMmxhb2RJL1RIdHcxTVZTYUdHM1BtbklHUjI4TFVt?=
 =?utf-8?B?cDlwNDVDcnJaOHJpOXRSYVN6TUJkeVB1TW1ocG9FdXlYR0NEc2ZzbmJSYWZu?=
 =?utf-8?B?Q0lubGRGRk4wQUttdkVRTlNHaTJ1cCszWlhBUGlJQkpKUGVVT2t1V2R4N2Rm?=
 =?utf-8?B?MktIRGhVUXY3L0VlajVYYzQzTjVqeVE5L0QzRTh0MUE2MG5Qd0d3b28rb282?=
 =?utf-8?B?R1BrNlN6ZitYdFBpK0JtMEhHaVFSY0FDQWVzczluM1hCcFJEUGNVcDZsOFJq?=
 =?utf-8?B?UzFZblp6dElPdWxvMFpUam1MWnQzS1F1REhLYi9SQzJKWEFaMWhZcEQ5dFRr?=
 =?utf-8?B?ZEhyQmVZK1VDQ09HUnVUVUZjb2FmcXpENWt1Sk0vVDRHTzdpV2pqa3JlaUZO?=
 =?utf-8?B?bmpLeEUyRU03cWJveUJjdXZFYkJNaWs0NzM3NitMZDVkTlpjSGpHTFhKbHFI?=
 =?utf-8?B?OUllS2wwcnU0T2daYk1oMlpNc2c5Y3dMcWYvcHhLWm96VWFyUnhkZ2xFVDZ1?=
 =?utf-8?B?TlZkb1pZY1BBQzY5MjhOKzMyZW81ekl4M1pXVXIzTkxIbzl5SUxDOFkwbVJt?=
 =?utf-8?B?WUFsRHp1d2ZxOElvRnJTRFdxK2NLY3V3TFhuMGt0dVFMaDY4VjlhVUJlV1h4?=
 =?utf-8?B?aW0zQkNNWVNnWmQvcVhwY2labE4vK1hPaCtqMHJlU3gxYmlkKzNnWldtVU9C?=
 =?utf-8?B?RGt3SDhsVldlZXhVWDZXWkxPakNIZmFWK0tkbVR2V1o5cytZbkNiQzhJMTRM?=
 =?utf-8?B?NDd6ZU5PZ0FmN0l4RDZmdVFSK0FKNGRIVm5wWTJnRHlMbUpIcW9TL055T2pL?=
 =?utf-8?B?bXpkUnVaLzF6YXo1c2ltckRYN1ZmSjFybkpqUk01QW5XQ2hYTHlYUEp2cVY1?=
 =?utf-8?B?YXFSVlFEVGw0Q0I2RElzMlNoZkpxREtCWjRLdWdOajhvQWNrQkVIMWJiM2tL?=
 =?utf-8?B?clZjSEhqK0dDZWdtbkVDQk9uYkJybWlKblRJNnhGVGdsS09ZcjlPdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 582662bd-9cc3-42fa-30a6-08de5e97dcea
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 18:05:47.4525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3pdttog50CGf+UP5FgamdtVyX3BwtQq9Xhayz6WzxQw/20PNxD+7uDRf7ycZDK6BDOjAzXQkMWJg3wl7TveLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8557-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CCBAA77C7
X-Rspamd-Action: no action

Many DMA engines, such as fsl-edma, at-hdmac, and ste-dma40, use
linked-list descriptors for data transfers and share a large amount of
common logic.

Introduce a basic framework for linked-list–based DMA controllers as a
first step toward a common library.

All DMA descriptors have a uniform size and are chained as follows:

    ┌──────┐    ┌──────┐    ┌──────┐
    │      │ ┌─►│      │ ┌─►│      │
    │      │ │  │      │ │  │      │
    ├──────┤ │  ├──────┤ │  ├──────┤
    │ Next ├─┘  │ Next ├─┘  │ Next │
    └──────┘    └──────┘    └──────┘

The framework is derived from the fsl-edma implementation and provides
common descriptor allocation/free and helpers for prep_memcpy(),
prep_slave_sg(), and prep_slave_cyclic().

This patch series is based on:
  https://lore.kernel.org/dmaengine/20260114-dma_common_config-v1-0-64feb836ff04@nxp.com/

Additional functionality can be added if everyone agree on this method.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (12):
      dmaengine: Extend virt_chan for link list based DMA engines
      dmaengine: Add common dma_ll_desc and dma_linklist_item for link-list controllers
      dmaengine: fsl-edma: Remove redundant echan from struct fsl_edma_desc
      dmaengine: fsl-edma: Use common dma_ll_desc in vchan
      dmaengine: Add DMA pool allocation in vchan_dma_ll_init() and API vchan_dma_ll_free()
      dmaengine: Move fsl_edma_(alloc|free)_desc() to common library
      dmaengine: virt-dma: split vchan_tx_prep() into init and internal helpers
      dmaengine: Factor out fsl-edma prep_memcpy into common vchan helper
      dmaengine: ll-dma: support multi-descriptor memcpy for large transfers
      dmaengine: move fsl-edma dma_[un]map_resource() to linked list library
      dmaengine: fsl-edma: use local soff/doff variables
      dmaengine: add vchan_dma_ll_prep_slave_{sg,cyclic} API

 drivers/dma/Kconfig           |   4 +
 drivers/dma/Makefile          |   1 +
 drivers/dma/fsl-edma-common.c | 448 +++++++++++++-----------------------------
 drivers/dma/fsl-edma-common.h |  35 +---
 drivers/dma/fsl-edma-main.c   |   8 +-
 drivers/dma/ll-dma.c          | 353 +++++++++++++++++++++++++++++++++
 drivers/dma/mcf-edma-main.c   |   6 +-
 drivers/dma/virt-dma.h        | 114 +++++++++--
 8 files changed, 606 insertions(+), 363 deletions(-)
---
base-commit: daf496ddce1475078b500e30e0a16de3d8fb9c8a
change-id: 20260119-dma_ll_comlib-ba69c554917d

Best regards,
--
Frank Li <Frank.Li@nxp.com>


