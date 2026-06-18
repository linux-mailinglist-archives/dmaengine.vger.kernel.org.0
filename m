Return-Path: <dmaengine+bounces-11625-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hOuQCRk4NGqcRwYAu9opvQ
	(envelope-from <dmaengine+bounces-11625-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 20:25:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2566A2224
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 20:25:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=YJicPo6D;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11625-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11625-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B104B3059A61
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 18:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD1C376A09;
	Thu, 18 Jun 2026 18:23:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E2D379C2C;
	Thu, 18 Jun 2026 18:23:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781807018; cv=fail; b=aqCI87OwWGdQkmdH3LNdoL+QcHOdDwz/99gFJKvPriasjaRGqrC5HVJlp+8fzCKM2e6eDUfVDaDVBtEHCFsxuUnwh/RcNe3XgksnB51RhSQhU/0FRBuGS8D5xnOWGeX0/Sv99+mfCSC2Q40Albre1jY4QEB+w7CwPszJz1ooru4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781807018; c=relaxed/simple;
	bh=iWLu506skiw/H3i1rERUuHREnglHZisggsRSasZzeQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ODHR7lgsX9dPHyxF2xkkuUauAWleiR1O3wdc+Tc+GTN6xW8RPYPlEcaRQcFEl6LvRKxhVAU4rLA3/iNqvVM/s10soXvQSWPIdNaHn7B7Ov4lDZWXww6ggpxPYn+2dZTMtQh7qnBS3/+wfIG5ZfN0YvhPHM+b/hpPXh+8Y4OBHs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YJicPo6D; arc=fail smtp.client-ip=52.101.70.71
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QskHNonEFXlratLeFJfCmUY4+b5CEBem8G2GX1etB+ihKLLndmuI4O9O/lkuT8K+DDFty+6jMZLDIDPw09oMIjzcOmVuz+NLqgJsHmKKTwP4MKizzuFog51PdXVdh86y8SiJOVq45oBGb2msbGBV2pRzUeG9YuFZ85Dqwvc6jDgd2As/2wRsoln0CJ7EpxwoYqqyUQF2zRSKwSTrBRzE/P9wvb/1HoWUb3FvoUGtIeKdUgTYUW76PU9pFurWQtsa7azgRm2/HjopJ2UtB5HynYFpLQKm9iP7LgxsttH6CAJD+bmmPtOqiRhWW3IVz33lDzdHPSaXdQuC8NL3OHJqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/88No2FjNFpgxCqtq4omypGqcboDvMtcKQeWpl5iRzA=;
 b=H0llqMWWMXRRdzxppu/2xcDEoYWYAOV6OH/rN9X3oRn8FVKt1u2VeL4wHFXNFOQTcXHyu8NT3IhJnqjffl9bbZFx1pkAj39sbFUUbzlspN89x8QXFXPScjqQZCKCcoomv1r2sTfn5KOXIgQpX83b+7JIXly6Vrn0w0Ivc7CbRi6TlAaFnD2qwhBx/HK5PdICHNJQ0GwNUaAey32ZCYBwO5pAlLo/qyCYItPyOQnDJan4oNVQxNtBXEV7FMjaQG+7LaSlH3vcDEz86jOd/NEFOaQN6OJCorTZtK9/e9fyJMrqTPR/EfkrQMRPribF9+skQGvhI0u9aRPQQEUZbNBzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/88No2FjNFpgxCqtq4omypGqcboDvMtcKQeWpl5iRzA=;
 b=YJicPo6DgjqCBbiSrscI5D/KOVjj619OF3xUPsg8BpvakYJ3qHimKRxdhekg3XoDQ8Z0rSk1/5Kg90jwbLOnJ1tytb6dYlUIIFa0UgeXeaQDaSQKWOuQd47Wu7dInNBFzMyPsswji3zDQ7Jv4vE34ZQYp0wEPNJkQJYfUEoaEg3nJDmvcKh+IvabT2b/fu4rww+D4ZG8zS9wprnkvdHkS9ZhaXiepfhUNoq+4M1fShgIQtZ9WzsNh2B6pB+FBTDA5f3F5+8nC9G7NfjJCfeiYTU2nUw7RLymiYrZGeWkq/RPcZJnE5rquHXc1IJSK+2ryLvuFCO1ufsJl3SWx+9/Ng==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB8455.eurprd04.prod.outlook.com (2603:10a6:20b:414::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 18:23:34 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:23:34 +0000
Date: Thu, 18 Jun 2026 13:23:22 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 08/11] dmaengine: ste_dma40: Use power domain for LCLA
 SRAM
Message-ID: <ajQ3mphsfF9esl-M@SMW015318>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-8-eb5e50b1a588@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-8-eb5e50b1a588@kernel.org>
X-ClientProxiedBy: PH8PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:510:23c::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: b20f6436-988d-42a8-8672-08decd66b4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|23010399003|1800799024|366016|56012099006|11063799006|4143699003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Jai7y5r0IF+m2bp8H9UUcRb6r+O4genN90E7L+ny5TcjX6o9nCz/D0Qzh9c+eLrz5risk+TBQfKqKJkNLrEVLQ61VSwcj1vhdC6AMsdTl2aTIqKHb0o3FxdyKCa7471KRhmE2PlIRpQxNCVXNqV528ni/IFqx3hn+AIL8vhRP9SI6/+cdy92uts4UpvkfQOtkzLrhYzC7OCqt5aCeOzQrN1TvzbINo0gcrzjS1Dvh5xQm+TcX27pVfJevMRZrJ7745zw0Ijog17HbH++M19Nj3uEQfmBSeWLO9zrhH+AlyK/JZi1WEapQChrBQctsOyWcZHeBpX3jqfOvtpqDTN5JzavmzCPh8douyh+iryoUWYd/YsYwnNQ1xmQjaRc/C/Ou2u+VjjP7tCBc9EMnqh7VH0zyf+AYyIK7nqaOiDIHe3Sk2BVaQV5gLG6gtU6Y1ztyc7TlA4/KXdp1EDbsKNYc4Ck+P8HiBlPEiuqiSAUWfrI7Af4yuwoY4oTJOaamc31feJ2gvkMO5bJXRr+gj+FFE4gARoz0usmItnPsOV2I1Lli2Yt4TtxXMdddiutb7e5Y464racPAHMvFG4akn49F8DDPv39Pt+yZavDkP/zm+ZZKNe6G9FAAByUOygUM2gq265mn9xS/r4sZl4d+74/8bm09gQ6Fs292j5h9tbqjab8LvY0ycjyVSGAH7dP02oCNEBPnDUC4H2T2yyGLSuuOQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wJTENkmUErz6BsVl/ssDYrRdFG36y00uuctsvX9yGdeQadWC3HWDIFB4kOcz?=
 =?us-ascii?Q?bLUwm9r1yp3TzNAzkpDuvrhKqVGm8+/EDsBAkdPC5pBfCtTDZhr6hRMK66v8?=
 =?us-ascii?Q?nmV+MiBOZ0VaeWfB9SCDybvwLz6uDEzYB0XPfjBHe/RR4oivRebfb//kUfKl?=
 =?us-ascii?Q?vXBaGObD8lIVXMIZiNVUf8jOO1TLCbqv03+j8pGp6UJSQ2nqUqflulxgrIjd?=
 =?us-ascii?Q?zhEi53PyqSPu6fWdAVLIbbVGM1Ph5To4A5fFP0iHlKb/jUWpNObHEblZJlvX?=
 =?us-ascii?Q?bOMWOvs1esaVlgKwX07wI0z4LqrJRAicsyuLHJszeNSyG5r3p5pHsd67fRvS?=
 =?us-ascii?Q?Ncn8r4Dnj2mZo/+6ffM869cHH20jt9uEs8e49SM5ZMIgSXn6n/YV5PUGzQmg?=
 =?us-ascii?Q?rjbtmxIbB5WkKZH/uQf3g0K3ZSskGaQrW4eBOaBkZmaDxRAJfLcDkdnKhdHa?=
 =?us-ascii?Q?uBR1EuCXArOxEyUAcutb3KcHVIKefmqkF7Umy1ZodcwqZSXaaELPfCylZ+Ba?=
 =?us-ascii?Q?DfRl/IhYr3yiIlPsXH2u1TEXMtAsN/CcHNsEuRUawyVIzIoNAbiVv0wiU666?=
 =?us-ascii?Q?5D9KlUqnglSRDPUhieOhgIaIIo+JaPiRprQ8FPhNNIhGK5a4s6RXPIin3w8V?=
 =?us-ascii?Q?aQ9kOsJI977nEI5gGkxtINKaphnq/GTAZ1bOF3/hEIaQmKeZpD1QobNMxzex?=
 =?us-ascii?Q?TNGG+E+6v0buP49UhRAEt16MgEqpeV3ZlM3OUWJ5hY+ObOiIukXBJqD7R5B3?=
 =?us-ascii?Q?aPHBqFi+pK4F2tb+hzBGOlY2lENf3wpeUOqdyfPwWTCLa3ZzWDF2nQTRa1Bd?=
 =?us-ascii?Q?2KXx32LFswkSnxcN7k1W+PUpi14zo3nFj7X3FxERZgUVowr4nlEpMSVcKql/?=
 =?us-ascii?Q?yBjgOQ0JbHx3Ba/jn0nlrTcwVqpEkG0dbEakTF60Nn3KKbPBJ8E6/vFL/xn/?=
 =?us-ascii?Q?ccgc+7Iei5/mHQtIfaDq86pH4s/ZbmUIGfgyN38RuP7bI42nkFUB6a6Ju2Hl?=
 =?us-ascii?Q?VM6g2FPvo1JU2UD+7Gh59BwWysZvDWVPKqAKGZQ6CopcW7yjG6hCIq+BlAw6?=
 =?us-ascii?Q?6T7lPRLJZgVwkUAFrGXRABj8DnGmoT7P/i5pkGKK3dPaOX/pNP4z5V5NAz0S?=
 =?us-ascii?Q?01wZMaxsgNDVPNLPtAn2DEXwqTyT7f9FOFa6mkFmOY7rlQqrjBwN0WpfCb7k?=
 =?us-ascii?Q?B1j0QQdwLg8EDp5zvFzYvKS6DAVQn2NCQKBZI0upMOTW2iAe4ZT3euHvpVyu?=
 =?us-ascii?Q?wZd3HZII/AuTa1x2XlWBZAk1vbNpNbmkSjiB3nnynq15EusyA49uC6W+5koA?=
 =?us-ascii?Q?KyYCnGhqLBLlf7LFjaE9G6o+kkaDZR4UWJFE/wkpO5v8pQAgUkbbde1gFEKl?=
 =?us-ascii?Q?NvJjL9nI0owGaZ+IxJWXgPI57rKJs1ukFYzYYFmGdeX/3IMG+FYqsY5kSGx+?=
 =?us-ascii?Q?oYbQyYEtIMChAZ7z4oYwtuZy5papbmi/8ri+skVeCqOyvncwWjaI8dma7pGD?=
 =?us-ascii?Q?akNaBuhp1Xjpl0zt/20gc1A55Cs+cOV6DlNj2nltl9G6xsnnsoY0G8i5u17x?=
 =?us-ascii?Q?5Q1QVcwRkFq1abRDLAV00C1muXSsgEYc6geUH20pZIu9g0tse1G9UrEll1Zk?=
 =?us-ascii?Q?yLGY4qaGj/EQo2HcpJiaSwTySqjR8oKU0L9KyPb0PDhlfQlsXace38JPYIuC?=
 =?us-ascii?Q?MTMFwd4vFugB02X/uYBtZ9+Tej3b7KupPjz5fKhpdFekbDxvcbCAMg5dEKpi?=
 =?us-ascii?Q?4oyepC+OJLFH5VDcDmU4mURgHH9ajdFFg733CTtUXKTheBHPdtL/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20f6436-988d-42a8-8672-08decd66b4d2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:23:34.0275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bo9KiCMpP4TCoPVpCm36aOFuSumeOKBDKAGEzG8unei4bRymbcO824S3SO2/L8T1cTIXDJrXo68x5QzjOId79hAdzCl6kjEKsXA0nu2RKPEEbGIGuwkjkOXpMoaHSEns
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8455
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11625-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ulfh@kernel.org,m:broonie@kernel.org,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lee@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-pm@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:dmaengine@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,lists.infradead.org,vger.kernel.org,lists.freedesktop.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,SMW015318:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B2566A2224

On Thu, Jun 18, 2026 at 07:00:54AM +0200, Linus Walleij wrote:
> Replace the LCLA ESRAM regulator with runtime PM.
>
> Use the SRAM device that owns the ESRAM34 power domain.
>
> Hold that domain while DMA transfers are active.
>
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/dma/ste_dma40.c | 97 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 55 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> index 9b803c0aec25..6ca67ec446dc 100644
> --- a/drivers/dma/ste_dma40.c
> +++ b/drivers/dma/ste_dma40.c
> @@ -21,8 +21,8 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_dma.h>
> +#include <linux/of_platform.h>
>  #include <linux/amba/bus.h>
> -#include <linux/regulator/consumer.h>
>
>  #include "dmaengine.h"
>  #include "ste_dma40.h"
> @@ -571,7 +571,8 @@ struct d40_gen_dmac {
>   * to phy_chans entries.
>   * @plat_data: Pointer to provided platform_data which is the driver
>   * configuration.
> - * @lcpa_regulator: Pointer to hold the regulator for the esram bank for lcla.
> + * @lcla_dev: SRAM device for the ESRAM bank used by LCLA.
> + * @lcla_pm_enabled: Whether runtime PM was enabled for LCLA by this driver.
>   * @phy_res: Vector containing all physical channels.
>   * @lcla_pool: lcla pool settings and data.
>   * @lcpa_base: The virtual mapped address of LCPA.
> @@ -607,7 +608,8 @@ struct d40_base {
>  	struct d40_chan			**lookup_log_chans;
>  	struct d40_chan			**lookup_phy_chans;
>  	struct stedma40_platform_data	 *plat_data;
> -	struct regulator		 *lcpa_regulator;
> +	struct device			 *lcla_dev;
> +	bool				  lcla_pm_enabled;
>  	/* Physical half channels */
>  	struct d40_phy_res		 *phy_res;
>  	struct d40_lcla_pool		  lcla_pool;
> @@ -628,6 +630,22 @@ static struct device *chan2dev(struct d40_chan *d40c)
>  	return &d40c->chan.dev->device;
>  }
>
> +static void d40_transfer_runtime_get(struct d40_base *base)
> +{
> +	if (base->lcla_dev)
> +		pm_runtime_get_sync(base->lcla_dev);
> +
> +	pm_runtime_get_sync(base->dev);

Suggest create device link between base->dev and base->lcla_dev, so run
time pm framework will auto do it for you

Ref: https://lore.kernel.org/imx/20260513-b4-b4-edma-runtime-opt-v5-4-1e595bfb8423@nxp.com/

Frank

