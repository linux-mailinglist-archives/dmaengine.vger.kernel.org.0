Return-Path: <dmaengine+bounces-4845-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13EFA7E74C
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 18:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4063ABC93
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 16:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B46C214A75;
	Mon,  7 Apr 2025 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OniqC/lK"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2077.outbound.protection.outlook.com [40.107.103.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F84214805;
	Mon,  7 Apr 2025 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044430; cv=fail; b=pRlkx2hkvIh7CEM4Md/6SB6pPrbDFFldpdBYnJMFK+RZMMAYWaLooFn02qBGmkb/A3hzxqDK8KoK13cTXG6mqVraxGneAmEaZTb2qBJNsSozN0PVf5rFlrllm0wtpVpGq8ddeU0/7HgeY4zLpnMopzHCzLy8fusqsqsWlty/1LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044430; c=relaxed/simple;
	bh=wDy16vMxtvNqz6BO+23914UkHW8fi2SXeaIACVSeW5k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mhY0N9pr67R1dATK1xvVZsZoFLYh6Bh+3t08778In1glV4TraLl6RklnZxxTEysi620W659oor2P2JmFRfyrOdYwue2U5boq/tv8xD5hbnvIjo3MPGUInWeZzSDDAOEwvWte8RSbk6izFx316hIpCvGOwsSuvAb+xIF/PcQdLsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OniqC/lK; arc=fail smtp.client-ip=40.107.103.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5IFomjOPvWZFWUK819+uZuv0e/PsHv4NtC0dEhAfkuFt7M2VPLdXo2g/0fy6vL3F6xqVtgT/cnFESlffc8lTjvybZrLib8CDuFBW0y21j9Y0aMV0bYNcZBZJCimMENJsNPcL4el37SbFB3Z69aEMrMFPgblZlfmyU6JgbCsahp9+pdzzImRzRevliVBikLjp98g6xzIsL9cwZggcQr/9mu9kzpR0HbpmbKZFEyMpTUfh5TgVPkZoWqTNo67YPU3Z7NsE73TdZCOOZEanbvmOu8B+B/mArXaIw2s3/x4Ky5sm7m7y8MNMFkLItJI84tvtxvWSgxUxXwDHbt5z6m1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHX6ZKE2P+4ZEnK+pIGDXbzfJzSK8AZpol/fGaBErZQ=;
 b=yvHWy0ucETl7jEMD0V2KsAMwpoiHafKbi9cZiV18nxsGew3+UQKa2acuukfqu+JqOf7FMGufzDsr18lBdb2TEfDtNr5Aq7Rp4f8I4V9pgK4zecMv2Ya2IxReSfdT6o5tI+34XDq7F1ss2Wix7W6tNAZFAmX8gkrinrw4WIJifBJzx98ptutu6W3VWFWDlzqcbXeL83ILSP46NWxdGhajgEaJxzPQLRT+iF/D47Bb9vtmadZTspD1fsc+KPdZfaKWaI10Z/JEVrCk5ogKZw95Y3OU8LzRq1L+jLE64yucRvDsX/BH4+R6SX7FFerDqpFpZRuPDSRMe6bbMAQFAMohbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHX6ZKE2P+4ZEnK+pIGDXbzfJzSK8AZpol/fGaBErZQ=;
 b=OniqC/lK1715fLJML5on0fzsnheP89SDs4Ut2pbghGmt3737jpXIwsY9kDN8gcCY+hLw9BhcKUG65RoWxtcL7QPnPwzyaoYg77W4NTJ85q2EuhX/c04SdKbIsNSZAL82ZPyLFLo7m1B79nzIPslv3w6yDnLhuF+wIIeXDrYOZjaf1H3HtNBYbYguFIKyrrNN5c+Qn/uRWcyzbW+VJckzVgRlq0qrUrIZ86czexfDUFMU+Mq/naq9rCwmtngQAct98N+QIDsIY5q/xxwfZxHudj4sc0oJmd2UrIRLqIlG62RffsI421+7I1zpZNuaGRa1Rtd6WRowm3tHzsXwdj6BZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7029.eurprd04.prod.outlook.com (2603:10a6:20b:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 16:47:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 16:47:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 07 Apr 2025 12:46:37 -0400
Subject: [PATCH v2 3/3] arm64: dtsi: imx93: add edma error interrupt
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-edma_err-v2-3-9d7e5b77fcc4@nxp.com>
References: <20250407-edma_err-v2-0-9d7e5b77fcc4@nxp.com>
In-Reply-To: <20250407-edma_err-v2-0-9d7e5b77fcc4@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744044406; l=1395;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=vlQwR+bBZ6elPxxCgjF7nPXgn5SK92exsAVCSX4YmU8=;
 b=h8fBdQm4SrKo8H2sZc/2YpCjR7GejMPVr9X4CG+iUUgcSDHPLJnTARyMjuUEtlRQmhLQU5TjG
 /PUP2Va48xcCe8lC7BEfheQGizhti0UzsFqGgsl9aYshpDq0iLQxpM/
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::8) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 122ec928-48c3-4e0b-37a3-08dd75f3d58a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlBaV3d5Q0ZkOVEvR1FBWVN4Z0dXZ2daOFl3K3NyL1VKMVZWUDZCMytmaU9a?=
 =?utf-8?B?NjZiUFRVQW9kb3RDQkkxWXUwNlpjcEdCQUxNZnhWdXhQc1VINW5KcVBPTzFx?=
 =?utf-8?B?dTJCT3QwQ2d2TVo2b3U1OGV2ampCQWpKT3kyeXgvVlhrcVNmUTBFQWlqazB5?=
 =?utf-8?B?bHNGSi95VWhSS1JwdHp1M0p4bk5RclVoTXZrcCtxWlFlMGYrY2pjQlBRcTFn?=
 =?utf-8?B?SVhOY0RxeXV0c05nNnpwZWw0d1VLcGg2SVp2L3dXQWdUREVoWDFCcmlpNXJv?=
 =?utf-8?B?d2gvMUVYRjllOFMwRjduRlowMysxOXU5NmY0b1lYTGFPWStCWHowOWJ6Skt3?=
 =?utf-8?B?YTZIS2V6WlRDMlRtU3lYTGRQcUd5VXVGR0lYRlNzejlTdHVsdmxsOGRMQWNV?=
 =?utf-8?B?NWFsQmpBTHVJV1pjYkpnU1FLOE5BQ1lMN0JtU1UyUit5K3F5SkpiNWhoVHl2?=
 =?utf-8?B?S0dNMkh1M1lJL1lQWXZKdXpiQW9ycVB5QXI2Nnp5UEhQcElHRTJ2TTV1MU5H?=
 =?utf-8?B?U2NxV0krVWNvc0Fqbk1halluUjBHRWxDUU16OEV1NFdkZ2xDOEcxK3ZQRnZ2?=
 =?utf-8?B?RElOeUI1N3kwZEI4V1ROWXRRZUp6MElLQmFuM0V3TGpQalZTK0NlaE90LzZC?=
 =?utf-8?B?WncyUXFHRVB1ME9KY3V6UWxad0x4YTBmWDQ5Rkh2S1R1MHBNaVErY0pVcVZP?=
 =?utf-8?B?VEU5VTB2d1dMNWpCS3ZBdys5WjdmWGphOFNnSk15azlVbndhWUVoOXdENFJJ?=
 =?utf-8?B?ZXB3UTlDMUNhb1I2dTlkYUR6a2J6bmJ2eUk4WktTNnVUd0lkWlhZU1NPNTd6?=
 =?utf-8?B?eGpnbkx0ZHhkd0lDbmQyMUJacGJ5RDB0UHZCVnhKejdHc3JHWXMyeURWTGt0?=
 =?utf-8?B?TlFLU0M0SnNqVEZsS29tYlF2encrdVRLaVN6Y1lVZjNLU3BIREFrUU80aXVo?=
 =?utf-8?B?R3ZSS0lWK1FLOWRocGFJb05MeDZRa1dIMmdVVWF0Qm40alRVQ2daS1NtZWh3?=
 =?utf-8?B?MDhvOTB1SGNnRkhMbXZGZUthOXJaRHNncG5ZWlBWRk42MHdtdVJTYjg2aW52?=
 =?utf-8?B?RDFnS24zZEl2cFQ3blp0c1JiRUZHNFRCdVNHY0FyTGNpSUdPckpudTlMTUNL?=
 =?utf-8?B?bmxlOTBqbXhiK0ZZaTRKSGJxOGlkQlBORWNjMDVkclRMK2Q5cnl3UTYyL3Zv?=
 =?utf-8?B?YnArcm1jbWcxbmZwM2FBcWZab1VCRGpJa3dFNjBRU0xFL2pPcHpIdWxDT280?=
 =?utf-8?B?RkRwQTFWY1dteXlpUStuQVJLb0p6dzRGY0phUURjeUZXajc2bWhpRm5VZFFy?=
 =?utf-8?B?b2xpb3BXWWxiaEU0OFRnanVqSG5lRGU1ZCtIZ1hBbVFCUWN4SVpFVVlhRWp6?=
 =?utf-8?B?Sk5zR3VYcHRqNUs2K1VwM1BpT0ZSbElzbUpnSWEvZmFPdTl6b1dMdnFVTStV?=
 =?utf-8?B?eVRFMktablhZREZlczFac3ZETEZEYVc1OUxEMzZZdlFHcXNUbXBSMTBIUG0r?=
 =?utf-8?B?anZDU0ZQSVFaazVJWEN4eUpoVE5hSnlQN3JsMkxjQTVOSFhtcUpZWHFDV3VU?=
 =?utf-8?B?b0ZLaktKalVwY0FIT0RlSEV5eHJIQXJaNnQyOTIxMDFjZFFaTmgvMUY3Mkh2?=
 =?utf-8?B?OUdnb1hOa2JCMVVmN2pDdUsrMGJwM3RTcGw4dXZuV1JFZkVRNUVlYnYxT0VO?=
 =?utf-8?B?aHJyVlQ3OXlGOW9QRU55Q0Z3WHA0d3AycjBycW8zeEZYaGdmd2dvZFcyWmVn?=
 =?utf-8?B?eTlHUG51VzFnOXM5TDEvektQZTQxOWxkSmxjM3craENXT1J3UFVodWFFUlhj?=
 =?utf-8?B?RDEveEpENndWdis1QjZqMGg3ZG8yZVVyVTAzL0FITHRvWXVsNXhqU2lRNFEy?=
 =?utf-8?B?bmg0b2NGazFSRmowTXlqakRmZk5pR0NiaWpHYmRMNXdVa3J2cWFFZHRRNS9q?=
 =?utf-8?Q?qxVdz4Ha5Eg6MTSxpw4PbqK/Wl5laoxA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW9iYjIzTHIrVGRZVXg4TFVqUmppM0xKbUZwZjhDUDRDUXR2QnpEc0tzTUMr?=
 =?utf-8?B?cFJXNU9Qa2RUV29qY2VLR0oxRENJMHpkZUJSbVlFeGtpQmw3UVFSa2dLd1Ja?=
 =?utf-8?B?SmZ3dDF5em0vSFB5bGRHL3BiNm1xemRLNFRhbXkxYUlscGYrQmo0U1RVdkFy?=
 =?utf-8?B?M0tQMG43OXpVN2YvMHgrVnEyd3FzRGVsK2ZIRkw4Z1E4VFg3cFpNMGU2dy9Y?=
 =?utf-8?B?czlPcXRKWTJFN0dWWXNhSmJzRWhhWk1PTzZLTmpkR2NmeXBrKzlYNlhFSWY1?=
 =?utf-8?B?MXdyOWQ3YVEzR2p3ZFFTemJPS3ZjUUdGWXFQN1RhdkxMQTNLNTRlOGw2Z3Nm?=
 =?utf-8?B?T2VuNks0RTFhdjBJNFluR1pZbVJEdjI1RDdqUVFva2tBcTFwbktHQWl4cXZu?=
 =?utf-8?B?L2puYUJzMzB6RzFOUHdEY0ZZaEtDYlptOENYSGNKb0Y5SjNrcXF0c290cmJp?=
 =?utf-8?B?S2RvSVNLMWtBYmxwZlRGdEs3MzVNeUN0UkhWYnJsVWxzdjkvUThqa3cvZVY1?=
 =?utf-8?B?UDcrWjlwdDExcitmL3B2ZmF0WTV0K2t5MUlucjB2MjkzcFJEVkY2UzhOaFVo?=
 =?utf-8?B?dE4xcXpvOElUc1psdFNBZ1VDdFdvK0xkdTJxRThvVHpmclhwLzZtZ1lzc1RX?=
 =?utf-8?B?M2J5ZlArNHNFSVYvM0ZGTlFFWHVqVkZNNjVnU2R5cUo1QUJCeWVRMHZ0YkJP?=
 =?utf-8?B?RzJib2p3dnNhK29NRFA2b3Z3SmdGaVpIRkJBcjlTSmZmOEFYRzF1dUNrVnVi?=
 =?utf-8?B?QS9nVjJIVmVxQ0xMT3I0Mjdmd1RiRjkweFU0ejlUcWJSSGhSYjFvOWoyK0JG?=
 =?utf-8?B?R2JPZWVaZjE3Y09NVWxuTzNIVksvVlZtaXdxc3MrdCtpN0hCZlJTWkhmaEJ1?=
 =?utf-8?B?UHU4ZmorL0xFYlRtcnBUMVlvdUVVNVFBQ0J4WmZsaWFaQWlMTmlkaHl3WE5V?=
 =?utf-8?B?NCtMdEtQN0dCS28xTHRROEMzbHFHVXE4TThzV2JQKzlveWdoUGtFSk5mVXFB?=
 =?utf-8?B?YmtkSUVKRGg3TXc3RnBtQ0pmM0phZVVVblJhNDgxMzZTaEVoQkxwSWFzYlFx?=
 =?utf-8?B?TXBubkdXZ3pDR25VbDhobDIrNnljYk82b1dibkNTMlhNcTFsSFFWOGdkaEpC?=
 =?utf-8?B?dXViOGVBYy8yaFYxbGJwUnFrUHFUc29wTEw3bXV6UVdpYWlwSDRJRGVnUXM2?=
 =?utf-8?B?bGFscDROekYyTlQ2blpPNHUxT0Flb0lnck9XK3NjbVI1blpDYnltbzNuZHVK?=
 =?utf-8?B?SzEvNnlZVWZic2lkZnVaU3JnYm8vTHJhL0RTMFRKNFZseUlKY3RPQ29IWXRE?=
 =?utf-8?B?VTY2SUdMYzNQVzM1RC8xbVlBUkcxc2FpQmRGM2pWcnJhZXg2NUZvWDhsMVQ1?=
 =?utf-8?B?Z3IwQlpyeG9jbDU1bm5iN3VFWmZyM3hVVUlqc3NWTFdObEtJMUs5eWtncnQr?=
 =?utf-8?B?YjRyMnJkd0h5SDdBYTh5UXVoQUZoaVhzVDM4RjZvTit1RU8zOGV2bTA3RDcy?=
 =?utf-8?B?cW1Pci9ZZzJ6YUJLdTFxOXh4Q2hVNW9nOVVGNkYvZno5eGorRWpOdFdNY0Vz?=
 =?utf-8?B?aithQzhrMVRwUDhxd252blBEZExRTHluQzB2THdoL1hEODFvbXVSU3BHbWxZ?=
 =?utf-8?B?SXp6a1RpTU5zRkJmTXlGR1ViaWVlR3lGeTI5SFNnYlhsODNoMnQ4RmJzWUUw?=
 =?utf-8?B?U01SMFVCSnI1cDFhUFpDZlZJcWNMbzg0bXJoSWFXZXZwcldKU1d1bUJHejFY?=
 =?utf-8?B?RDZPWGlxa2tzcVdNZDl5Vmo2QmNud0h0OC9vK0ZDRXVjODZudjRwVmorZlh3?=
 =?utf-8?B?QlFkWlFjRnV0dFBPcE5mbS81a2U2S0Jybmx6bGJ1MVN5WmZWb2o0czhGSHhG?=
 =?utf-8?B?NStVb3hZR3ZtVnN3OXkwNGF2c0dYVmxPMHZKOEZLZmJoMGp2UWxyNXR0UWRF?=
 =?utf-8?B?bVI2MHdsV1ZTZWRMVmFkNG1WSDV6ZG1WZUtHSnpmdXNKYU1SQ2RNdGs1MGlM?=
 =?utf-8?B?RFdiWmZTWXRSdExDWW9zM2RuY2VOdFc5djMvelgxRGx0K3g2VmcrMGdFS3Vr?=
 =?utf-8?B?R1FDUmE5dG50dmVCUzZOZ1N3MGE5TVUxeXJqSUJTd2ljR1pia3pMVHNkKzBN?=
 =?utf-8?Q?NZT8pSS0prpd9vKF1o6E3wFoG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122ec928-48c3-4e0b-37a3-08dd75f3d58a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 16:47:08.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yywLmvK0k9s4FApiYPLvvRNDsco6paMxtuY/cUTImMcjimyS2gsJfcRU7O4GLY+GayUgRfn9DriZb1FVGC6RCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7029

From: Joy Zou <joy.zou@nxp.com>

Add edma error irq for imx93.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 64cd0776b43d3..9f6ac3c8f9455 100644
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


