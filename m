Return-Path: <dmaengine+bounces-9104-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGu4N6Zsn2mObwQAu9opvQ
	(envelope-from <dmaengine+bounces-9104-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:41:58 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0C519DE8F
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 259B03016515
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 21:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6A2315D23;
	Wed, 25 Feb 2026 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xa2vdzCb"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076F779CD;
	Wed, 25 Feb 2026 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055716; cv=fail; b=iwLIptCX/gBb6MxXMT8uH3KMdliSJ6JskvslMajBKcgnevVCDEbYjD14fC7vSuQDoCXOORak1hkTnHNYAcch7q7EyRWIryoTQobMxoE2igafhfT1wdcKIC2pKmeuidmZ6dfhEvPD0BuuoavmnlC2bR761OH9silsedwOZCWrv+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055716; c=relaxed/simple;
	bh=4obAHHvUGw4ZshMxjq0t6NlkbdbhSVvJkuEXcXsMeNw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=tH/YLPaJhAod9pZ+uNeQ/eWOVUa0a8VTPlsO1AvpQgU/wzFsTDPgExV4J1Gy1dLfKoMSoNGdoIcqmOmKnnpnWHsWCuc/bHiS/fWpIpI2Jqp21a439xkh3VB55IgZvmbv425F5mNx3RodrWYFnjOP68aX/mDNzhqcJAhngtt0H9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xa2vdzCb; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Enj6MY9IsT2AKdSrkozikt5LTdprEKY9dgIyHnHOBtKJ5SVoeF4G6lBGAk/7tMCYV2B/PcqyW46kID49nk05+Olf22nW+2bW1JkKoLMpn3voMlGb9uxcN344ypTAyX73YPf2ud39DwYfN49enlWb5kWJlWUavi8Zz9E5LNJbo7l6iYy1Z4dRQ5/Yd9DEJgVCYlQuRDlHNlD23u1ul9Kdx4PAZs4iz5XxgdGQV4OV3oVIE4vlZNcabn6Vo4hxRd5UUs+3mrXIsf3ObJ565C956tPWp51U3VJJNFoX7vShwyx8WFVP4dJEFv+e2JWxEotjM9DDh+shhRqY2KD0ItT7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxNHN+S+k3xWClxOogfKn7JInRorLRhslyjVYvtEh74=;
 b=KUnHFirKQnoR5tjqgvRHjHdY7hsLRLDuQV2e2+oTy7DzeX16zcsOcGRqOM4+fUmjDBQ/KXekpHEvtnSBZUEthPwwtAX0Kuh96M+rCAEW/Co6Tb1jFkeIU3k6378x4Eh0h3jQbKOv5+XQ2eTeLo4lLizfNBPciSkJdH9JHCbeZ2/T10xyqt4tGB1wzoGVuizlYC6w+RYpiaqHP/M/1hGoy3A+0k7SaCoMLm//nWpvQJEQXh7FIBffUbaQo+Js6Myhk9oMQRSOydxEU2QzSF8X1KSfAsXoYkcAcMsgs4LNTcb/VlkfefobZpb+6x0QiUbr9qeLn3StilAIxllqTdVAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxNHN+S+k3xWClxOogfKn7JInRorLRhslyjVYvtEh74=;
 b=Xa2vdzCbY33eYZLRbQUtfCXyl92cg4OpWYvdTqH0SAsxlNeRIj4myYWZbuKAHwbQ95pEvqFCQG11FnfTLqnZNP2DPgkm6MxwjbK3/1CmonUZs0wFdlC5klEsV8QcmxMj/QAghf2ambN7pGcpbPhICT0SKfJQidtAHmiITwXDRCyiB/sSO/1qTZ2N3XNjKCxYlHWnnq8XnLsstQGMq61xHbHNU0e6BdQhkx4rSWAUNKuqALk0FKhvF+Cdot1J3ruX07bVYFXOvCKjH4F1kfyyHSomqo6gJIeMpmSJhQW+B8WIYSIK3eUV9TvWQDPL3c1RkRhSzLqzaVRpHCE6wuLJQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7346.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 21:41:52 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:41:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 00/13] dmaegnine: freescale-dmas: small improvement
Date: Wed, 25 Feb 2026 16:41:36 -0500
Message-Id: <20260225-mxsdma-module-v3-0-8f798b13baa6@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJBsn2kC/3XM0QrCIBiG4VsZHmfo75LZUfcRHTj9a0LOoSXG2
 L3ndlIEHX4fPO9MEkaHiRybmUTMLrkw1iF2DTGDHm9Ina2bAAPJOG+pL8l6TX2wzztS7IEZo02
 rOkmqmSJeXdl650vdg0uPEF9bPvP1/VfKnDKqetAKtW4B5Gks094ET9ZOhm97+LVQLUMuRaeEs
 kx87LIsbzqIuLPkAAAA
X-Change-ID: 20260114-mxsdma-module-eb20ccac4986
To: Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Saravana Kannan <saravanak@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772055708; l=2057;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4obAHHvUGw4ZshMxjq0t6NlkbdbhSVvJkuEXcXsMeNw=;
 b=ZlUlbmxkxO90WxsclpCmIdE8h2jC02uJ3jzG2EodpzURM/0wpDV6Q6kABhscZ8flNcjhVSErl
 BUJyAyiWIoBA6mfURBlN6Q839v8NlXtrn0YCuCuw3yNj2ct8EgbLs5S
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:510:e::27) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM8PR04MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ea4fde-2dd4-48be-b162-08de74b6afed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	eVA4/YZTzYoTWqPwuA8DoMHkLqdmR1ahV/SuVTtyKb63oSS4pJ4PaoVx0+LRnmUYqeGOr8tUyEdIAk8sc6zQ5PyKWR6qZSbE81tfjADopGnoiaGPOU+rkaRzj4IaGlnkkdv72805eBNR4z9hp+ORcBU6mU6QaDb/JxQTdfWf3bir1tDEok5LSC1BdTqRBDGYs/H2wi28DtETiMBY9wKOQa68oUkOlMKlfbyVP3D0QLeNBGDkcnM7lOrU+DYNjzmO1hDz699CEoT98UmEEXE5myLgA8GPNthMhu/WiF5awIq7QHRc9MTYDtUr12116yRNnzsgweshAs6zWUGLucsQBMpAZOHbby0/gVBlEvsj+PQIHqBXXhI4y2hnpQwrK8d4I6Eewn+7fg6l8LfsMXrliZ1PwXD4SMWtALJ3WL06LuOihn9GHQ8VPNdEao21Hvxrx2zte0Lny2CbgwC67zpRx4eCBRhpw4j0Z4EqTLSxM37pWMarAqnKwx8LeJrrxo2HjtDUAMPN6xcTAT1Z6NGX2h77QpY+3f/mciQyh4LPNJB6XfXclzXWOROMOie5CPwcfCE9UYBMIH+6Scv+wHilpeRHRk9/OasrwuAKRYm1pS7YMVJrTCbqdhMwIEBnAMF/72hjTVBPlpwpGgDJekf37y1zTsh5e7+sOxfH2fP2mtCpPfe6N9SIuJfE+eqtzd29OVfjzHhGN/msePYz3CC8hs4uX5/ojUbOHQwRR+btLtVQR6Sdk/+9/wwdnNSkCE/AST1mw4Xn6jW47gLAM684s7cE6Zy0Qsj+ohJNPz3SmHE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEh6dnRKSjRWQlBKeWdMdURvb1NIRU1NSzdHM2Z1dGVUWlMvNTZoQWNYT2xk?=
 =?utf-8?B?aVR4b3BHcERTTVB2WFFTeE9nK3grUHIvdWZlUFlKVWh1UEJWK1ZDUzU1a0Zy?=
 =?utf-8?B?RXhOVFhBMWNiWVJsc0lOR1RnMUsvaE5OY3JBY2NtdzUzd2RSbGZ3NTRPem9I?=
 =?utf-8?B?TEtuYnpRUThnYVd2S2gvZk9GTzVPd2FuQzBiWGRxdFlRWUI1MlJxTHF1Nm9X?=
 =?utf-8?B?RDZTdE9RL2p0VGhmd2tqUHU3Ujg4Z3NJNk5GU0ZpQmFDSUVXMjlhc0pTdXJY?=
 =?utf-8?B?Wjk1QzlxZGN3R2ovdU9WdG9iS2s5SWVGM0REZXgzdk1JeWpqTFJzREQ4S0VC?=
 =?utf-8?B?VStNMzlaK1VWTmd2RGg2UnExejZNbFEzUHJkaG93LzJXcEJqMnhnYXdQWWJU?=
 =?utf-8?B?bkExRmdVS0Q2M2IrbmtNVE8remF4YnRSUmdxNUlIZUtFVW0wNzRndlBmNEw1?=
 =?utf-8?B?VEhoWnFHS1lkSkhsaTd5UXlrYm9RcmtrTXBVcVBwQmlBSzhYbUNJL2k3Rlov?=
 =?utf-8?B?MTBhTzhEMGNFczd5QXlXK3EwT0F1TmhpMFdtMnNOZkI5SnlJcEZXdWFkTHZY?=
 =?utf-8?B?Q0owMzBGcHE0Z0N5cnZYaEZ4VGJOcVZiWUd2QU95TDMrSmJsZkF5VFBlWTRk?=
 =?utf-8?B?U0xtL3IwT05NNFh0QkZtT3oyVnJQOVhZeUxEYzNmcjZza3pReEY3U1A0UFF6?=
 =?utf-8?B?cTB1QVU4ZkVPK3kzeGU3My85T25WK2lKVkV1TkpPSnFPR2FmbXVEWmlIVHNF?=
 =?utf-8?B?Uis2SjJ5N0FkQlY4UTVuWDdHb1JGSHFyN1I5RDFNQ251SExaL29BUFI1TUFY?=
 =?utf-8?B?RG5Nak1tc3JKVUpFNVd3d0htQy9MNlBjYVBZWFNZK1Nhc1Z1Q1RPYjQxbDQ2?=
 =?utf-8?B?aENmTGZFN1ptR0YydUJVaXJaNGI2OEVDODNSQkpzNGp3dm9PWVZVek5PMERu?=
 =?utf-8?B?VzF5V2RlWDYwdEpYclBwMWk5aFBFM29Cc29hYmc5MzFHVGlhUVJCRUNuSUVC?=
 =?utf-8?B?OHVLUy9XNGh6WmxXY3U1L0VOdytoMFJzMWUwaEtNeFJySndBdndtakFsS2xC?=
 =?utf-8?B?M25OT1FobUtJaHJnUGR0OHlsd01VRUJKWVhwVG1KbEdia3dRU1RMem5wa04r?=
 =?utf-8?B?aTlJYkc0Qi9IY2w2VWRiSVlXZjFqVzEyWU1sR2NuTVpJekRFektJdzNBa1ZV?=
 =?utf-8?B?RGE1L1p3aEJDZFk4N2pMdEZvaGs4V05nREpBTTk2MHZZb2hvdjJxYWxZdkVD?=
 =?utf-8?B?Rlk3UFE3SFFkaDFMZVBEdFhEd2lXUlZEUTdnNCtDNkJ0a2FaRGhtQjJLdEQ5?=
 =?utf-8?B?ZHROTlQ4UVVCbnpRT0tXUHowZmNlMmF5bC9HN21PODBWTVdxMy9iT1JEckJo?=
 =?utf-8?B?ZTFCY3Z0a0NjMTJqSDRtV2dkWS9XSEtrSmIyMlRDNnRYMmM4V1NQU2ZQZG91?=
 =?utf-8?B?RGI0SkxpbHYyL2NDWldrVUtpNFlwZlJXM0tGYUxOSjdTS1lvbTVIbGZQUFhS?=
 =?utf-8?B?Y0Jxa2tXVXA1YmYxUDNWaDkraFVGQ1NFQ3pJWk1IR3kyaFcwME9rQ3NVaGtT?=
 =?utf-8?B?ZFd2aXJLN09uSHFJeXVNZHcyMEpPZnFSZHhaTXBydE1MZnFsU1o1dUthK2l5?=
 =?utf-8?B?Q25ReTVLWHdyTHNVQjExcGJUZEFXQ3ltZnBENll3RXVGelp4S3hWTjl4NDZT?=
 =?utf-8?B?RnBMVGEwL0xYRnZEdG96MDdHbmlhZmhsc3c0c0N3ZDV4bnpoSG1GVFRPWm5o?=
 =?utf-8?B?UVJaOUR0N2FWc2M4RzRyMXZrZGwvdXFsZ2lrQlRYbkRjdkhsSjI0NkV5SUFj?=
 =?utf-8?B?RmNsNzZlaU9oVGFBampiVFlDWTlKTWZwSU5GZk9zcGR5MXhyczNleDl2NXNj?=
 =?utf-8?B?K0ZZQmZtV2trTUk5Mkkvam41MlVjaDMvOXVqQWtoRkFROEpnMFNhL0c0Wncx?=
 =?utf-8?B?UkRDNWoyMUlQNEFNcU1aSnBoYkZ6ckZ4TmM2Vll0NlRFV0JpY2R5NjdaVUhX?=
 =?utf-8?B?Q3NjdXdKcDR6VmhjbFpSZjBVTE82L1pUci95eE05VUdzZnMvNDgwMmYwdU43?=
 =?utf-8?B?ZXhoU3FLU0dkQnQvbVNwalU2VXdiTXBNYjJONHRDYnhGeDNrWDlKN0txQ0Qy?=
 =?utf-8?B?ME02dHZwZC8vZWRmbTVSRUtkS2tkRDNISXdCNFllZ1RYUTBPQ1hjZHJ6b2Ru?=
 =?utf-8?B?MDNXbWkrb3p2VTlJN2NwT0YwTVB0N1ZhWFJqQkN6RGNLaE5WbVo3RGhrb3lu?=
 =?utf-8?B?aGplOVdhMjNpQnExUDNwN2o1bmN6N2F6alUyOE1mcmwzd3VEdm85dE8yK05K?=
 =?utf-8?B?VHVjVkk1N1pac0I5dHlMTjlmRXBGQ0FCWC90QTdqdFJsd2JBYTQ5QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ea4fde-2dd4-48be-b162-08de74b6afed
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:41:51.9515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzTcT0n5j/N7HoGjwjx1yJDgaIyKy4P9JeqC/BiLnXTYSSll7QneMrc4hwFyaf3854VaTNRUsWWAfIzE1BDtUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7346
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-9104-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 6F0C519DE8F
X-Rspamd-Action: no action

Add managed API devm_of_dma_controller_register().

simple mxs-dma code and add build as module support.
Use dev_err_probe() simple freescale dmaengines.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- rebase to dmaengine/next
- Link to v2: https://lore.kernel.org/r/20260115-mxsdma-module-v2-0-0e1638939d03@nxp.com

Changes in v2:
- fix missed int at stub function
- reorder patches according to dmaengine
- Link to v1: https://lore.kernel.org/r/20260114-mxsdma-module-v1-0-9b2a9eaa4226@nxp.com

---
Frank Li (11):
      dmaengine: of_dma: Add devm_of_dma_controller_register()
      dmaengine: mxs-dma: Fix missing return value from of_dma_controller_register()
      dmaengine: mxs-dma: Use local dev variable in probe()
      dmaengine: mxs-dma: Use dev_err_probe() to simplify code
      dmaengine: mxs-dma: Use managed API devm_of_dma_controller_register()
      dmaengine: imx-sdma: Use devm_clk_get_prepared() to simplify code
      dmaengine: imx-sdma: Use managed API to simplify code
      dmaengine: imx-sdma: Use dev_err_probe() to simplify code
      dmaengine: fsl-edma: Use managed API dmaenginem_async_device_register()
      dmaengine: fsl-edma: Use dev_err_probe() to simplify code
      dmaengine: fsl-qdma: Use dev_err_probe() to simplify code

Jindong Yue (2):
      dmaengine: mxs-dma: Add module license and description
      dmaengine: mxs-dma: Turn MXS_DMA as tristate

 drivers/dma/Kconfig         |  2 +-
 drivers/dma/fsl-edma-main.c | 55 ++++++++++++++++++--------------------------
 drivers/dma/fsl-qdma.c      | 47 +++++++++++++++----------------------
 drivers/dma/imx-sdma.c      | 56 ++++++++++++---------------------------------
 drivers/dma/mxs-dma.c       | 37 +++++++++++++++---------------
 include/linux/of_dma.h      | 29 +++++++++++++++++++++++
 6 files changed, 104 insertions(+), 122 deletions(-)
---
base-commit: 9a07b4bb2c6019a8c585f48ee9b87fc843840e6e
change-id: 20260114-mxsdma-module-eb20ccac4986

Best regards,
--
Frank Li <Frank.Li@nxp.com>


