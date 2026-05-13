Return-Path: <dmaengine+bounces-10409-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAAEJAJfBGpBHgIAu9opvQ
	(envelope-from <dmaengine+bounces-10409-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 13:22:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 093315321B7
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 13:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96510300B454
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 11:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD9138D6A9;
	Wed, 13 May 2026 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C4hntlWN"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A37325B0AB;
	Wed, 13 May 2026 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671325; cv=fail; b=oaeN1zTYb5AkWISTSs/cf+VAS+Qpu0gWR6/Okro2GyD3pVy9tNZna82NuWaa0oCVGruUkcfpl+KZ3vCbeY41sK80I400WqUg/Vy7HnaPNtc5zLqUC/06VNakZX4aMaxd71kdOMHS/VPij4xJZF7+TuhY9ThAncF8/gUQ9K36yoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671325; c=relaxed/simple;
	bh=AaU0fyPgbMQGU8yA7rbpsjQLFqsQoQo3xCMbhsASvjg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=rkGgfoMraEhOfDTcuZcIHLKRxZKf4bberilJj7xdgJG5HQKibLbao4NesfvdmVSSaUL2/kvXUDzyyD7YupjZ7MjopZ6MBEYBEifkm77WMHf//Uz2QQc1iFwrfRlz8Dg7HnM6aTcjeZHXkur1B/GjhTosnoVbz2jH9Uw8mVVAI7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C4hntlWN; arc=fail smtp.client-ip=52.101.70.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+C9I5TO/VY/4kGwDPx5kr1z6+ku33UjGj8FfT18+RwHGWfHe6nVtC0XgY+/5kpVSmRuEIbbR9xBEfrKqx6lzcJBO/Qg+D5LsL8S/C6sRSn/FTviWIop5EMDk0IOiADZCYrCO+y12IqtWSlZx9DrkyLASBWLBZLRrsVbE/25Q5NrE0RFFeyGgV8UB20Ap/Ze/vnKRVweoyQQpmUiThFI6LETpwF2Ns/PRBXyrdS72fYnlZqO8p03lfGTwclr6kRpGocutWEu0WsX6BV3fMqL2Kh+xg2SRJC1+ZC2Qs6W7fSj5yzUMCUXXAGEmFem5XRaFvCzaAtYyYUUdtWqi+KBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grCtQPwgyWs0DRqZhYyrLpaF57lOJktDr0o9Mj0U3TI=;
 b=uwfPvrCRqt1qm6xaDFzkF+9DKq3JofNdN7Wj+BX0/NtgwhkEvl0ElBzjUUcB7HpR+7MKvpAlJbWmhCZqSn16B/rJm4SXp8HTG9zet1WqR5dyroK6muD5nHKMyqb0Zou2NMsxZqzAXHOscRwAneAfikBir2McfYJKCY6pmCI/OSkB+sQJzw5ZkP5eijVDZAvXs+XMbTpyYuhsJry35wLKrTrt3SL2MaRoBCbe2EA5ThtZVAngDUmVDFdke+8vKz7uXOD9aHHZgQU6nYirUlxspBIiIPRirxi0BGTANzlAL0yQ+MHVR/OWdvG70u6vt9zTnlSMlf9h4rJlBCM7SnGI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grCtQPwgyWs0DRqZhYyrLpaF57lOJktDr0o9Mj0U3TI=;
 b=C4hntlWNbOY5VAH20q193v8iaWoNvXSGvdRIW6yIMSVcc99wLIpSpCBs4OkbVh6mpfuI/c3vspDzwGKCQhzwW4OKKlyuxpArC3VP9TfHGItl+5Exv+a80VfrqFZLBpI8yMYSLd0asryTfsLqFrP46l8BVdvhldMFxTWauq6VN4l2XyyaluoK3sS34S647c8Q2BathLoBx3+sDdARfDfCgTnYzWY67NSrcBAGDbqfKSFrZnD1BaXpfiTCPEbxApuFFJk8HItMDdMSTJMd1AI83OihwdtA+5kOloOGf26SbIDlA6WLc2Qss0ciH/l2SAwTBqFezpmqR1M+I8PJnbwpnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5765.eurprd04.prod.outlook.com (2603:10a6:20b:ae::26)
 by VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:22:00 +0000
Received: from AM6PR04MB5765.eurprd04.prod.outlook.com
 ([fe80::bc76:f507:9b83:9d69]) by AM6PR04MB5765.eurprd04.prod.outlook.com
 ([fe80::bc76:f507:9b83:9d69%5]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 11:22:00 +0000
From: Joy Zou <joy.zou@nxp.com>
Subject: [PATCH v5 0/4] add runtime suspend/resume support
Date: Wed, 13 May 2026 19:23:46 +0800
Message-Id: <20260513-b4-b4-edma-runtime-opt-v5-0-1e595bfb8423@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEJfBGoC/4WNOw6DMBBEr4K2zkbGH5Skyj0iCoOXsAU2sh1Eh
 Lh7DBeINM0bad5skCgyJXhUG0RaOHHwBcylgn60/k3IrjBIIRthaoWdPkJushg/PvNEGOaMdug
 ECeW0vmko4znSwOspfrWFR045xO/5s5ij/atcDAqUqnGa7tKqun/6db72YYJ23/cfqJMAQboAA
 AA=
X-Change-ID: 20260513-b4-b4-edma-runtime-opt-afb0e03d4484
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::15)
 To AM6PR04MB5765.eurprd04.prod.outlook.com (2603:10a6:20b:ae::26)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5765:EE_|VI1PR04MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd7c182-19f3-4a93-45b3-08deb0e1d9c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|52116014|38350700014|11063799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	BIhd2gRk7AqMkx/Ytyt+WFj9mt8RzeCyPq99fC5P7jJlSjUhYmn5xXRR3JDq+HbbPjCuUFTSbfYibrqosd2zsK4Zr830p68KYzcsJGeP5CYwsMjoI2XW57ell6TtcML2Gc/CYaWlTKNO7CDS4Xl3p0F234QHSSNhBdWKaeOVlrlpy6xi+uUVYYeVwBwbxMQ0d+bFm2uydWPDlvG1nN8AXSeE4fQkGKfc5MdRSL2dWiARjJE6+CVwFQX8war3JCJzL2QvOztH6gWqTKR1TYOnzoFdcOKosOPbg1PVWfUNdjV+cjmbZwK/C2uMEdr4K5727lyDj72z0/pzGwrPM9vtAnufwxCPQfn4grhWB8nBbp0A4kz4n52xevjx5myivs6gbeG8tXyCati0+ee2N+LfRGkw8am0J0d3AJ0sY+5wwlYqH/7wtcZH96iIhkTef8pCN7ziJBuiwnS165Ji3Tt6X3Q4/og2oiXZge1LfhtDQPsD9Z0KbgYIT0nAGa3iXg6GCMf7yjqMgU+JUPpiaIaT2xFhHUpmKKhgI4iiBbiSmABC49HsGENdpYXunkFtKfiI+GgwpcDo05T0qegrNu5V6yLmq4+4PbuXzQo8kt/taH2BrynRLmAUAb96aqyOkdJLh85As+L4b8E3E5NrOYscbC65bYtC3xhJPF8JZpHNZ9nVhprv4Afjgd1Wfx3dRvjUG9yGf+T7OlNK6CrU8IZClbFO6mpHIb8OAcblujS5h8ZUv/ALSvsbTpauWDLL0UVh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5765.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(52116014)(38350700014)(11063799003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SllITnlyeXZEeUJ4SmcxOUhVazI2dE8yNmVTTEQvMGxCaFFCSExWU0loV2Ft?=
 =?utf-8?B?TnI1aEpOVkJhN0ZDSFptVlF5bTVHZFNrc000TGl3SFRaQ09CZm9SWmFLM0JU?=
 =?utf-8?B?QloyODJTcjFpQWxyU0ZNckFUdHRzNFBBRTFTUk16aDRWRVlDbHJFREM5YUNR?=
 =?utf-8?B?Y0Y1M21McDlsSDFQem9DWU9XL0s0cFdXM2FUeGF3a1B1YUhzK0JIWmNNYU1y?=
 =?utf-8?B?UEdwZHE3VDdZYUJvT3RkbXpCallJWmxyeHR3bUZXZ3U0Zi9iVEZ4amRsZzBE?=
 =?utf-8?B?emUzNldhRFlWWXpDRXN3SWZueDg1cnlyOXUyRDF5by9heEJGRFhTSVdLR0Zq?=
 =?utf-8?B?V3N4SldGUjJxcnEvc0FDcWZsQ3dhNWd3RFVGeE5DeUF0Y1hnbnlFUGNSYTdU?=
 =?utf-8?B?NktWcmVHcDZIc3VIZFJiZjlVc0pWcGtXaHc5VTQxUURLbGY5STMzQ3Nna3Er?=
 =?utf-8?B?OUgxZVFGR1Yvc0V1L3JtNzZxMk43RG9KUWRDOUlNY3ZFNmVVQnUrazV1cnRX?=
 =?utf-8?B?UTRsSUNEdW1kK0p1aUUyNmJnUUVncGRTTGk3Z2lPbzdrRWNERTVuT29SNU5s?=
 =?utf-8?B?OVJCRTZqN01zcFh0d2E1RGhvV05xbUd0Y1k5Rnh2czRKaDhaSEdaZ0xjYVpw?=
 =?utf-8?B?V0pYd01zZ1p0Y1hHcVIyN0V2RVRNclB3OXZPdnB0c0FyRHRIVnE4QVVqQkRy?=
 =?utf-8?B?Umg0eFdscGlnR1JmSEpMbkN4dndLL1VleWlEMHVhU0l5UVQwcVdCaEZKa29F?=
 =?utf-8?B?YS9Mc0RVT3I3UzVnNDFqS0FVSGZQUnlaK0hUZTRMMjBEektvZUFXUndEdk5l?=
 =?utf-8?B?a29qS2FiRjAvUTJEU0prK1FOaEh0S040RUJaVkxxdlI4eGhZMDJHZ1l6RExM?=
 =?utf-8?B?UjFRdXZadTNLeHErYnlrYys0TzRZNVlTcmtGVkppL3Zva1FuWTdNeGdlSGhl?=
 =?utf-8?B?NGxvMlh1T3Q1TW4wa0xTZjBEU1N6RHJFTkN3TkZ5V3BKRkZWL1NCRUlwUUJn?=
 =?utf-8?B?L055SmlnR1FvWnhNM2FjdURCNGROeFN6Y3hSekJoaHVrZnBFWFRkTHdFUTVq?=
 =?utf-8?B?TVpQbjRFKzFWeUJjVUFXZlVXWTAycmFVNW0rUWtZUWVOVmg1UjVEbUQzanoy?=
 =?utf-8?B?dmVnWlFVekJVcGpNdDJvUDBLaEZRNGt0TkFIV0dMbDd3S2ZLeTF0czFQcDRZ?=
 =?utf-8?B?ZkdIaEVtU0hXTlJGY2lEVWN5MEFhWkJtWk9ZMXhNV2VIUGJKeHRtSCtZZWJZ?=
 =?utf-8?B?UVJkQ0k1Q08rOHJLWVlsN3BwZUpFMm1FN2w0MUd1OWg5WWdFWG5LaHkxUUVp?=
 =?utf-8?B?b1pjbnNoNXBpblRIbWk2bzFoWXhPRGcxVzMzSStwZEZkZExYZW1tWHpRSGJN?=
 =?utf-8?B?dEt6TlRZUmFNSXAxL3JXaE5HaFREUVp4SFkvUmIwMTN4c3V6ZEFHYUJYemFW?=
 =?utf-8?B?NjhwZjlNaGtWR29PNW84SmNGcFJiSmxaKzNUQ01KbGI5UEc4ZG9JUXVld1du?=
 =?utf-8?B?bFFZUklHMGlxM2ZYbnRYTkNIS2hyb1Vyb2toMzU3N08wQnprOGNNazFTUkI0?=
 =?utf-8?B?VWNEM0JBUGZBUVRvMlhUQlZmNXFCZWhiTzROS1k4Szg3Ynp2anN5amUweFE1?=
 =?utf-8?B?WFdmblBrSGNWUFdMUkJzMUlUVW1DdWMwM2ZqbVpMNk5iWlkxZG41Vk5xNjVE?=
 =?utf-8?B?cjR0eHRxS1RVR0ZvOVFZRU9abFZldm9MdVJzTUczbUdIc3FlYmM0NFVLRzhP?=
 =?utf-8?B?eFo4QndzWFk4SlpDZEpuQVVCNmlZQUJqV0hHZGVXeERLSGs5eUpvRFJCYzRY?=
 =?utf-8?B?cUpJV1NyTVdHaVBHblhtKzdUbzdXU3U5TVRwQThvTFlhc2JmNzJEcG9hYjdI?=
 =?utf-8?B?T2Y3VmpHS0xDN003UnBIMzkzQTB5TEpSNmt1VEd0WlIwZ253bnpvUEhoL0hp?=
 =?utf-8?B?cUY0eE9hdjNzMzhlVkxGMEZHeXF5a0lHeklCUjZZcjM2ZlBHdWROaW5nR05m?=
 =?utf-8?B?RzY3NkRsOU9uSGFLaUZmY2VxVEtpVDhKWVRWeFpHdGxkUDBOQnR0bHBLcENv?=
 =?utf-8?B?QXRySGtab2s5NDFWOTFoVGZNdzdFT1BDNlM5Q1JrMlVlMm5tb3ExdHlMSm83?=
 =?utf-8?B?bnNNYjhpS09rR3JkZjJaNC85VFd4QW5YRmQzT2xjOC9IT2lWbzl5NVljejFG?=
 =?utf-8?B?S2NxR29rckt5bDdrSVdJaGFmekg1aldaR2VpQ0lHTUE0YUlUbEE4Z0V5VXpm?=
 =?utf-8?B?bGt5eStxdnhvZnJaTHBod3dEMzBOaTVtR3I2RFdXbnBCbks1ZXlsb3BBR1p1?=
 =?utf-8?Q?fpUrREiSlQh+9Aat9L?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd7c182-19f3-4a93-45b3-08deb0e1d9c2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5765.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:22:00.1554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shYZz1LtDhu3MdCnAd6/rlo/T0K4fYSDejLlR5IEIX6L1byn2KPQnSZCuy529zXO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6797
X-Rspamd-Queue-Id: 093315321B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10409-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joy.zou@nxp.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Clean up driver FLAGs and introduce runtime suspend and resume support for
FSL eDMA.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in V5:
- add three new patches, two of which replace devm_clk_get_enabled() with devm_clk_get_optional_enabled(),
  and the other convert to clk bulk API.
- remove unnecessary flags FSL_EDMA_DRV_HAS_CHCLK and FSL_EDMA_DRV_HAS_DMACLK.
- remove redundant clk_disable_unprepare() due to the pm_runtime_put_sync_suspend() added.
- use devm_pm_runtime_enable() to replace pm_runtime_enable() and add return value check.
- add return value check for pm_runtime_get_sync().
- replace pm_runtime_get_sync() with pm_runtime_resume_and_get().
- replace DMAMUX clock handling with bulk clock API for edma engine runtime suspend/resume.
- remove dev_pm_domain_detach() when device_link_add() fail because the fsl_edma3_detach_pd()
  also call dev_pm_domain_detach().
- remove device_link_add() DL_FLAG_RPM_ACTIVE flag and pm_runtime_put_sync_suspend().
- add clk_bulk_disable_unprepare() for clk_prepare_enable() fail in fsl_edma_runtime_resume().
- remove the extra space before RUNTIME_PM_OPS.
- add skip channel comments for system suspend.
- add clk_disable_unprepare() for dmaclk at the end of probe function.
- add clk_bulk_disable_unprepare() for muxclk at the end of probe function.
- Link to v4: https://lore.kernel.org/imx/20251017-b4-edma-runtime-v4-1-87c64dd30229@nxp.com/

Changes for V4:
- fix a typo dmaegnine/dmaengine in the subject.
- Link to v3: https://lore.kernel.org/imx/20250912-b4-edma-runtime-v3-1-be22f7161745@nxp.com/

Changes for V3:
- rebased onto commit 8f21d9da4670 ("Add linux-next specific files for 20250911")
to align with latest changes.
- Remove pm_runtime_dont_use_autosuspend() from fsl_edma3_detach_pd().
because the autosuspend is not used.
- Move some edma channel registers initialization after the chan_dev
pm_runtime_enable().
- Add clk_prepare_enable() return check in fsl_edma_runtime_resume.
- Add flag FSL_EDMA_DRV_HAS_DMACLK check in fsl_edma_runtime_resume/suspend().
- Link to v2: https://lore.kernel.org/imx/20241226052643.1951886-1-joy.zou@nxp.com/

Changes for V2:
- drop ret from fsl_edma_chan_runtime_suspend().
- drop ret from fsl_edma_chan_runtime_resume() and return clk_prepare_enable().
- add review tag
- Link to v1: https://lore.kernel.org/imx/20241220021109.2102294-1-joy.zou@nxp.com/

---
Joy Zou (4):
      dmaengine: fsl-edma: use devm_clk_get_optional_enabled() for channel clock
      dmaengine: fsl-edma: use devm_clk_get_optional_enabled() for DMA engine clock
      dmaengine: fsl-edma: convert DMAMUX clock handling to bulk clock API
      dmaengine: fsl-edma: add runtime suspend/resume support

 drivers/dma/fsl-edma-common.c |  14 +--
 drivers/dma/fsl-edma-common.h |   4 +-
 drivers/dma/fsl-edma-main.c   | 220 +++++++++++++++++++++++++++++-------------
 3 files changed, 163 insertions(+), 75 deletions(-)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260513-b4-b4-edma-runtime-opt-afb0e03d4484

Best regards,
-- 
Joy Zou <joy.zou@nxp.com>


