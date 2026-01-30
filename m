Return-Path: <dmaengine+bounces-8616-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDpMK5bMfGlHOwIAu9opvQ
	(envelope-from <dmaengine+bounces-8616-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:21:58 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6E1BBFA2
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 320DD30160F3
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 15:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFA6378D80;
	Fri, 30 Jan 2026 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P+mSVkNl"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013022.outbound.protection.outlook.com [40.107.162.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B343F2D46CE;
	Fri, 30 Jan 2026 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786499; cv=fail; b=rXBe4obf3wUDx+p3iWbSCgJhoRyMMx9ovFpyQR2AXKCDdNvszbnKgeU1JAy+2w0IjHYLUYw5HpgtnPZg7imv60EY112zP+djLNgFrvi+M8bJyWXS+Hy8YpiYRGWJI8i/RODv1PCwBVGUd3vg7BK72NqHjVdk52Tlhhl0guSLXps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786499; c=relaxed/simple;
	bh=zhRKPBjThAPZrIPC2UK44Y80ql/gs88JqoFmen6sN84=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=bWuZH6q915V1GSqqhDCpUB6DGGCombCOMXGy11z5SGch2LIdQtpPDETmzTjkzpbonuX6tPZUlhgv1FWLYZ9p4v6sQmab183/Wrkg1aC1Ar8mrT/8WeHRzkfV2MOySWUrkp61MYiybPHt/87Vl6gKoP3VdkpEBh6vw72mPOmH+7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P+mSVkNl; arc=fail smtp.client-ip=40.107.162.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPYcptY3gvnnDyWwRjmAYeFx+3x6Tj81liD6L4DzKye2YNkCyonqveNzwp/M98KEjjWS+8gPTSYvdQOp0UBYdutCiDOECadvC+B/xp9Nfdg9/txJtOV74cGN4oAAV5LA7xhO0lDfgi4kem/+d68AK0gqEAYt6DpYnBJXAuy2Npbd1/wzNwiqqtlssyoglnWHhYp15RGLtQv8RpSSV6jufWOBqB1F/51dDNA7IJ6FiLqOBZJp91Kh3JfbtQl9lK6nB31c6nWB3/6HVlicbRnY712OVAGoHtUhqXKZ2HPMRGMfQiyaVVYLRp6WKIREbhLgRiDbkhnUqRpq7YLQwsv37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SInvc7NnrslviwxHhMFxQqoPVuPamlzE4CS0b97d+2I=;
 b=KPywghAEHQ0L6oU5AUWvob4GBSyFvRRnlAt79FkC4qLDc0YH4DilGL7Am6MeqfXgUDs8cN1GL+993Mmw/XLNAQGVHgM5tXfv2ti9atcvTfVIeTKk77hLG3jCGp7XxYKSpGfxBntUAjJzLl9zr/1bAGexENbW0yGQJAcIrA1sO+kxfvRPUlduJK7kIVNDnW5klUUkUZrTatY7g9n5ANNPYojNJg05MIXj5tiPRCRzq+Uu7EE3I67Dm8yWPH+VS46cdSnMxM/cE5bRZ4y4oWbejrWzv38OyMq1fzHjVqd3C0XL1JTPh+BBpIIfCCc2AQ028vZyScH6+ZRJhvVpHAZFxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SInvc7NnrslviwxHhMFxQqoPVuPamlzE4CS0b97d+2I=;
 b=P+mSVkNl8L+4hdyTQsuqToKwNI4LFv7kEZTlsg+7LWr0Y7J11DxnJ4662yUVWU2zxRvsk0aGfOw7GqGnTyz3VrJMK8COWAAQFEyKw5swnbeh61CG3uIvbmo8cxA+L6ykHCSYDuFNjVPhFneBvSRanQaR5Z8yGWZnb1wT/7/DZASCq9WmNuSFL7bZVc7GbO/Ko/zD7xwDFap/0Kc7U5baYkycMEFVui1YizZGoew1a2CKQ/5Hc7o/hpVCzyDqZfEhwyyRyJWYGokUpRDHQw0Hk/ke6VPJw6PP7IbVJatpTJa30+ZmSJq74l/fKlEZsdx0OHXWRm7idJBNhy77b2cidA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7795.eurprd04.prod.outlook.com (2603:10a6:20b:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 15:21:31 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 15:21:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/2] dmaengine: add helper macro dmaengine_prep_submit()
Date: Fri, 30 Jan 2026 10:21:13 -0500
Message-Id: <20260130-dma_prep_submit-v1-0-2198f9e848fa@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGnMfGkC/x2MWwqAIBAAryL7naAWFV0lQnxstR+ZaEUQ3T3pc
 xhmHsiYCDMM7IGEF2XaQwFZMXCrCQty8oVBCdUKWQvuN6NjwqjzaTc6uLNoXNcoj00PpSpupvs
 /jtP7frvTtTphAAAA
X-Change-ID: 20260130-dma_prep_submit-cbeac742de48
To: Vinod Koul <vkoul@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, carlos.song@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769786487; l=3034;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=zhRKPBjThAPZrIPC2UK44Y80ql/gs88JqoFmen6sN84=;
 b=Q45sRkUjWsLKutBe4n+8GzcDvLRdLMcq8qeXlFyp1GbNCgjzmyuEMwcQTltZMrx5CmougcXv6
 BbO+9bwH9i4ABChJWR1DdrZGYl3mhsG9VhVCGBRg+o3hDkU2c0D5wJk
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0063.namprd17.prod.outlook.com
 (2603:10b6:a03:167::40) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM8PR04MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f3a9d6-130e-49c0-41e7-08de60133ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlYvenVxRDZkTi9ZVWN4UFNnWjFLcENUVmpiZEJweGN0ZUwreHNyT3hSOHdQ?=
 =?utf-8?B?WEVYdUV1Z3g5TzlkbHRIcDQ5SU1CaEhvb3l2TFg2U0VVRlljb3hsYVNobFVO?=
 =?utf-8?B?RHNLNHY0MGJBZzB3U1BpVy9XTUNiVW1zWHVjQW1RZDJtZjd2Z2hwMEpGWlRI?=
 =?utf-8?B?M2VYcnFlSmlPeU1sSG1oL0gxam5rdkxIZGErNlY5MElhRnJQQVNOWHpUdDE1?=
 =?utf-8?B?ZUwxZDI3OEhwRXRmYjhBRGVEcGJPN1NWQ3VlSndEK01zUzNKOFRUcW96VFVw?=
 =?utf-8?B?MlZlNWlpUWNROFZkdmk3RkVpVUQ1MnpFM21IMkxlWmU5YzVNRSt0d3FTMFVC?=
 =?utf-8?B?TXdVNWxoVm82d2pRbmRJcDZKUkhlOVY1MkZXemNkODlEbGtiSlFWd1dKd1M4?=
 =?utf-8?B?UWpEUVEvWEdRUFhFNE91NlBKRTZRKzhGZFpnNFN6Z2FkNDRrbzV4RlZTcnBC?=
 =?utf-8?B?bU5MTGVNMklmMHdvYWhaTHEwdDNObmNVbXNkdUx0RzRhbk4yM3JIbFk0T3Fz?=
 =?utf-8?B?bURIeGZYcmV2WFJmK2IzWDB6b3NCVEV2NHhrYytFYzdGbEdJcGo5dStxenRF?=
 =?utf-8?B?ZVo2SmpmYlYvMkxUM1ViNzZwenc4bGJRUmFqbDlzSk8yK3dSdVNlYXdLNHg3?=
 =?utf-8?B?Qkx1ZXNDUEg0bFNOZDVoWWdSekpZWERKUWNON3NEbzFLVVFqajFBa283Z25L?=
 =?utf-8?B?WTJpUFlJZ1BBR1BBUDJudUxlYkFxeUc2aFJGNkk4aVBYb3J2ZU5IM2dzaHZq?=
 =?utf-8?B?ck1ISGYxVEV4cGgwTmRLSXBmL0R3cjBYZVo5dHlBMkh4WlNITGdBMGcycytF?=
 =?utf-8?B?eERBclhhdVRJbm5DUmJUWHdLQkY2cGQvYU4ycW9jL1NVWVJnQjZNcDFXOGVl?=
 =?utf-8?B?b1NNTTlINHhWUUJSR3FmeGFqbStxKzlOQ0Z4TCtCSmNxRTVzbEZJeUVwc3U5?=
 =?utf-8?B?TE1LWjRVZDhXWjVSWHFpcTJ2dGZQdEtXUUFXMDgwWnJ2TjZQYmYwbjZ3L1VE?=
 =?utf-8?B?T2VFZXhMRkdETmZZalp0UDUvVGdiME1malAyOFZFdGpoc1FUdUNvTkQ1VExJ?=
 =?utf-8?B?WFd5bGZ6WmZxQTBUWWg0NzZVTFpxeUNFcENNN0YzYm04K2RqK3NNWW03V21m?=
 =?utf-8?B?WTRqMUtQTGN2SXRXV0k5b0NleDlXU1NLd1BJY3JMSTZ3RWpJVXRWNk1YZ1Zi?=
 =?utf-8?B?YlBHNWo2Z2JaKzhBUTNqYlI2RkpURStydVluVlN0SVE1ZVc0QjhZMForUW9k?=
 =?utf-8?B?ZFdiR0xibDhuKytLL2g2aVR2ZWhNU3hZVWJtUEdJK1p0VVNEZEZtUCsvODE1?=
 =?utf-8?B?eFVXK2FpTEdUWEs3NE93MkE0eDhJaW1HQ2tSZm90dExPTWVlZHRJMWs3WGwz?=
 =?utf-8?B?WVdiemU2OFliZ3JZb3pHYTN2WHFQYjVjK2RSYlZEVUxheTZXTWNaMnV4UFlr?=
 =?utf-8?B?eXBDYVppeXpXMXNrbytWTzlGS05hSnY1M2RrU3ByTSthVnd5TVlYUVd2cUFU?=
 =?utf-8?B?Q0JCZlBpYzczd2xwUWN1SzhGUWNiekpsaHdTcURCbXhEQ21GNmg2QUVaeXY5?=
 =?utf-8?B?V3RIYnd6SXlSUG1CMnlKcTYzVnpSZnpRdzZsNUxPYUZVbDNHelhOblZOYXNz?=
 =?utf-8?B?WXdOK0I2UW5Wdk1oTmhnTllCKzFTOGh2T0czSi84bGo5bkdjY3dHL1E5NVJl?=
 =?utf-8?B?T3FlVFE3eW5Gb2hlTkc4UFJYcDlsYkttOHZLa0JObE4zTi9MZVB3RjVMSmZR?=
 =?utf-8?B?WTk4WnN0cnBWd2NXdUc5UHp0bGFEblI2RHJ4TkZOdG9IOXpaNnc4dHNPczIv?=
 =?utf-8?B?TjFDOE9qcklvWXhZN3JoSzNxZkt4S1pIWXNBVDN5Y2hONTQ1QlkxNHMrVnVM?=
 =?utf-8?B?M2FOQzZRWFVCWUxVTk1UVlFZR3kwZUVRR0x3OWx5THUybVFYMTVvVTF3eWJY?=
 =?utf-8?B?Uk5sdi8vdVRLQmFxbUl5OWloUnNNUldXUjdyQldZaFNSRHhDNkd3OURJM2Na?=
 =?utf-8?B?SFdJbm5FN2ZPTWp4K1hBMld1eTdCNDc1SEw1aDJrWFZBR1lOcytWUCtOS1JB?=
 =?utf-8?B?R3pqUDN4OUFIMVB1NjdHWS9rREF5dHozL3RyV1BvemRDWnNxWjdwRFdXNHI2?=
 =?utf-8?B?eHVkSU9sVWZOWDlhZ1d3ek95MnhIaHQwSEFlWXRSc1hhN2huUlY4TThiSFgz?=
 =?utf-8?Q?l9iDvM2xt0Cc75FufVMMJvw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjdEdTBnYVIvamc0cTZSdk5lVVFVUTlyeGcyS3VZdWxmRFJYRzNSYXRLdHAz?=
 =?utf-8?B?WndvcEZ0UDVrVWIyTTdIQ2taRFJoYTgrRlVJTlQrRXVZaGozNHd1am5sRFJD?=
 =?utf-8?B?VnliS0ZvZllFTTBQTWtjV3VVQ1ZHZVQxVkVodTg5SGtFNUJ2OGlhLzQ2ZjB6?=
 =?utf-8?B?WW9VZlhIQ1k2NnpYb3Ntd3VwWGMzYXVJRkdoSWNIT2lEWldwMHFzU3J1UlBj?=
 =?utf-8?B?ZHIxOFB2eWZhU2kwcG1BL01uam9zMktwbTRyQUt1UzdjWExhb2k3ZHIzMk5r?=
 =?utf-8?B?cHJTUUZiU0o1M1YzaGtpUjVxeUlrSVh0dmtjUmhBait1eFFBQnVJSDBhdmtM?=
 =?utf-8?B?Q2ZXOHFNaXh4ekNQQjBmOU9EKzAySHFsc1lYeHlWYlB4czljenEwcFVGT1dN?=
 =?utf-8?B?YlpzT2xWdjVOTVdsZEp3TkFsRXBkWnJtS0ZWb3FIWGJ0VmwzODE1K0pKbkx3?=
 =?utf-8?B?eGhyYXdNTEw1cE5sM2ZONDJUYmpaT2hzTmpWdjArdmVNeE5TV3ppQkdlVDVY?=
 =?utf-8?B?Z0ZtUVVIL2dYWXZ3ZHVFTkp5S2VRclBBaDE1VHVueFhlOHJSVzJCRW4xVVEw?=
 =?utf-8?B?b3pJSzVZS3dlVUNQU3BGZkxBdkNiN1BEMWJpamk4RlFGeSsyNm9SUkFRSG5n?=
 =?utf-8?B?UURzeC9nQVEzNTRtNDZwYUQvci85R3lUUnRJRlNVWmhqckVBWWZVckRmbXBX?=
 =?utf-8?B?TnNBbFNuNFp2V2o4Z2hNVHhuQmpac2Z5TlRObGZWeW8zK1J1WmFCTGt2U3Mz?=
 =?utf-8?B?d1dKWC82Y0Q3VWQycDBlbWJqd1o0RVVIREJUUnJId0xUWWRTWkJ4eG1Dc251?=
 =?utf-8?B?b1g0K21nV0tYQWRuR1RtUU9UeXVFanQyQ3h5aHc3L1FpNG1vWlpBd2N3RG4y?=
 =?utf-8?B?c0tzZGQrd3VFSFdZNFRQZVNMVm1QRG5OTmdQdGc0ejJ5YW9WOXZYUDN0a045?=
 =?utf-8?B?RlNxektRUDVOSS9KdGdIQXpkTi9FYmVpMm1iSnJLUXRKOHNlOUJyV1ZxWXZI?=
 =?utf-8?B?TmhuQ2VhbzlUT1d2dEU5cjRlajhjTG5icjNFV0E4aHU1L3pXTlVkWkZQV0Ry?=
 =?utf-8?B?alY4YjRiUXBzRW42MmRuWkFQeHhBWUZQV21GalBNR0FjRlFHQmhHTVlDUDRT?=
 =?utf-8?B?N0FYTFJGS1dmQW82ZDAyRWJsZjNMYzVCRVpsQWt4aGhLa1ZBb3d4Ym9KTjNZ?=
 =?utf-8?B?K3lxQmgxYnptbmpoT2xJQVJMbTNEVGNPcXk2ai8wYTBRcEp0ajB3aTYzTEg4?=
 =?utf-8?B?MXBGVUswa1BCQngvSGcxZENmbEQ5dXJWVSttNC9qWUVQbGdFWGZKcFkza1BO?=
 =?utf-8?B?dWhkbjBoMVB0S1piNzdjeVNIc2R3NzZYd0x3OTFDY01pSFNIWEVQSWpnMjVO?=
 =?utf-8?B?bWEwWUtrdEZzSUorQXdLaWRkNzcyeHp0ZmlKbVdFU0l2K2dZNzZ3dkYwTVl1?=
 =?utf-8?B?bGE0OUJidi9mYWs0bVRsaUp5UGxlSEhpVnlDUVhhV2RnZmVRVkVBZjRVT3l2?=
 =?utf-8?B?cnprTFhsQ3VWYmttb3lFdGlXWkhWaGdmck82eXpNcEEwZlRXc1YzR2c0YU9P?=
 =?utf-8?B?OFB2Rk5yV3VpU2JKK2NlR2o2bFBmNS9xeDlhUjRaWDZCYUdGcmVHUWdhMEhk?=
 =?utf-8?B?OXhxd1lqd2thZ2IrOGIyYjRxWmEvQjBUelB5anloVE4xb0JpZUlCRHpUWmNj?=
 =?utf-8?B?cGgwYUNXZG1VNjZHYlA2VnlhWG1EeTFleDhyMjdjK3U4bXdHeHoyTDVxUE5B?=
 =?utf-8?B?dU1acjlpcjVIOUlWdzNJR1pjWHd6ZnZObG5IdjJoVEVSZWd6OGZrWHZLbTBT?=
 =?utf-8?B?YXBWYTJFd1hwMGt0OU5NcDE5ZzNuZ25ib0V6UUN3QlM1Z1FNTzhocjFLWHdH?=
 =?utf-8?B?VnhuNTYrUDFET1l0UmNkMUkyUjRnNGFzS0VOYjlNYU1RaUY4RVg2Y0J0Yitm?=
 =?utf-8?B?L1NxZE5mRmxZMGZLVDN6Uzg2LzAzTUF2UXlkcFBsdWxCQnVuYjNodzlGRVNm?=
 =?utf-8?B?bDl5bUQwV3M5OXhRaGRsL05PeDVMQmtycHRBczhzNkY5YjJhbXBNbnFRbmZS?=
 =?utf-8?B?aFlVSXBBVjJQemx4aDkyMThlRDQzWnV2eGk3ZHNpWGE5Y2g1TVdJNjY2RFVk?=
 =?utf-8?B?RTlvZ2U1SXBSMTBWejdYRjhkZ3BqRlJoZEZZVlFSanFNSUdSRC9DZGNqdTBt?=
 =?utf-8?B?cnRiaTVUeXI3L09NSm83dldUaFhsY2phdnNnSnc1elBWUk9PSjBjdWxGYUNh?=
 =?utf-8?B?WkphN08wY00yMVBRTE05R0xWcXBOd3NKRHgrWElKb0NrRmZRVlBUcUNoMEt0?=
 =?utf-8?B?Z3ZnUTBlT25ZRElpNmxQTk1GdmR0Mk1UMUVVMzBlQ2M5OHV1N2JaUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f3a9d6-130e-49c0-41e7-08de60133ee6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 15:21:31.1646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: od1kaA6PRdaUJbflOaSRLkLU4mb9xJVutIrR2xYfWxSSQhMUiQSudW+HJhwzMmq+Ovg2S9vJnup3beyLGwwSGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7795
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-8616-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 0D6E1BBFA2
X-Rspamd-Action: no action

Add helper macro dmaengine_prep_submit() to combine prep and submit to
one call.

Pervious try to use cleanup
https://lore.kernel.org/dmaengine/20251002-dma_chan_free-v1-0-4dbf116c2b19@nxp.com/

It is not simple enough and easy missing retain_and_null_ptr() at success
path.

struct dma_async_tx_descriptor *rx_cmd_desc __free(dma_async_tx_descriptor) = NULL;
        ...
        cookie = dmaengine_submit(rx_cmd_desc);
        if (dma_submit_error(cookie))
                return dma_submit_error(cookie);
        ...
        retain_and_null_ptr(rx_cmd_desc);
}

So create help macro to combine prep and submit by one call.
patch 2.

 static int lpi2c_dma_rx_cmd_submit(struct lpi2c_imx_struct *lpi2c_imx)
 {
-       struct dma_async_tx_descriptor *rx_cmd_desc;
        struct lpi2c_imx_dma *dma = lpi2c_imx->dma;
        struct dma_chan *txchan = dma->chan_tx;
        dma_cookie_t cookie;
@@ -761,15 +760,10 @@ static int lpi2c_dma_rx_cmd_submit(struct lpi2c_imx_struct *lpi2c_imx)
                return -EINVAL;
        }

-       rx_cmd_desc = dmaengine_prep_slave_single(txchan, dma->dma_tx_addr,
-                                                 dma->rx_cmd_buf_len, DMA_MEM_TO_DEV,
-                                                 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-       if (!rx_cmd_desc) {
-               dev_err(&lpi2c_imx->adapter.dev, "DMA prep slave sg failed, use pio\n");
-               goto desc_prepare_err_exit;
-       }
-
-       cookie = dmaengine_submit(rx_cmd_desc);
+       cookie = dmaengine_prep_submit(txchan, NULL, NULL, slave_single,
+                                      dma->dma_tx_addr,
+                                      dma->rx_cmd_buf_len, DMA_MEM_TO_DEV,
+                                      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
        if (dma_submit_error(cookie)) {
                dev_err(&lpi2c_imx->adapter.dev, "submitting DMA failed, use pio\n");
                goto submit_err_exit;
@@ -779,15 +773,9 @@ static int lpi2c_dma_rx_cmd_submit(struct lpi2c_imx_struct *lpi2c_imx)

        return 0;

-desc_prepare_err_exit:
-       dma_unmap_single(txchan->device->dev, dma->dma_tx_addr,
-                        dma->rx_cmd_buf_len, DMA_TO_DEVICE);
-       return -EINVAL;
-
 submit_err_exit:
        dma_unmap_single(txchan->device->dev, dma->dma_tx_addr,
                         dma->rx_cmd_buf_len, DMA_TO_DEVICE);
-       dmaengine_desc_free(rx_cmd_desc);
        return -EINVAL;
 }

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (2):
      dmaengine: Add helper macro dmaengine_prep_submit()
      i2c: imx-lpi2c: use dmaengine_prep_submit() to simple code

 drivers/i2c/busses/i2c-imx-lpi2c.c | 20 ++++----------------
 include/linux/dmaengine.h          | 16 ++++++++++++++++
 2 files changed, 20 insertions(+), 16 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260130-dma_prep_submit-cbeac742de48

Best regards,
--
Frank Li <Frank.Li@nxp.com>


