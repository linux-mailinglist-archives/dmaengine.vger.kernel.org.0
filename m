Return-Path: <dmaengine+bounces-9638-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHoDE2k+w2kFpgQAu9opvQ
	(envelope-from <dmaengine+bounces-9638-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 02:46:17 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB5931E660
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 02:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 866173027501
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 01:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E5B274B5F;
	Wed, 25 Mar 2026 01:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="mYG8umg4"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011023.outbound.protection.outlook.com [52.101.125.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0062773EE;
	Wed, 25 Mar 2026 01:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774403165; cv=fail; b=LHXF/C1VpsuiTI83Qb7gRIrWReYHHl8Ow486niwkQaHA6I1WkCgozvwBI/RBBAr4wZpbjKqGmobULedaWNx/SiuFs5sauWaZmfSmvQngCMQ1uX2ahskiYk4iFWKQE4tx1OJymRhq+DUAidvAQKmkMrlOcZhGJnz+hgvyFpf9gPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774403165; c=relaxed/simple;
	bh=qOGZF/PryrkWnlVffT3tVE/bxfw0HxzbI7zdKw3bRTA=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=sdYNAIackYTUohCLxyRcdsIvUZ3eIuWNid755ieWOuk4d/fTUGUdDOIoSeljXt9aaLO1i9l79Qbj1wLmKZcFV1+z7e0fzuhweGAi/Fzs86smdVK+2m7A/1ExGAY44j9Q84Q74SeTc3eihLbtv301uXyuOL4n7zDPpD6tzem1+uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=mYG8umg4; arc=fail smtp.client-ip=52.101.125.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLChXXpGafRW+yKuAXeQzo5To4DaxiyqkSCvS9ehf48Er7wqB44jullFH83R3sz5yrlCm8BLNsd+juKPQA76mEUlHOG1I2LFOVRcU0pcgfNI5aV2EOBnnVaAM/nEip7sotqo0cqjIPFi1tz9XzQDRpYZEgG5W2UyxR2sF8fquBy1ooP+u82jtqPK0S77wqLDE/a5IfB4aMnCtNSgeNB+nMgbn/xgrD0E5q2G2PIow0VQpZoW0KbhUpjvinau+LWC/GyX1yNHy5V/vwAD4xizgPCpqL5IFFRU5oB62cecj9rdTbVVJ1dxYmu28J5EN4z/1ggra+ss7pS6b2HAqHN2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOGZF/PryrkWnlVffT3tVE/bxfw0HxzbI7zdKw3bRTA=;
 b=pJ4EPs6VxnXmp5tjmruURYo0Cl5h3T/UAog4N41d+ieztaxohlQT4FMzv3Z0HcFeNPdgVPkVwN6AJ/GOcWET1KjOnC2+Ln0KFxh/PQRQCRczxfiPwrcvDavBk+L9bD/b7ahfwSMVeu7vs0PrPFs7fPAUjF/CoDWhIYpcDY3Esii1IaUaJaBr5Q4fNGwg503ZzChdp9vz6fZAKYwwrTGdQ0VBSekJhOrbd2CAxpa3otcFypYsgRc9h5+YUs+KbWCfN7LiXddN/OkuGX9S87x6vlpx9CJ+Bj8RLsQbq4AWclofGNKLPEdb+SPKyAcTMeJl6LP1tl4gCLoB0U2o6338FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOGZF/PryrkWnlVffT3tVE/bxfw0HxzbI7zdKw3bRTA=;
 b=mYG8umg443VURNFGDBsFKJjamFjGvkj9xCIwwKEFOAsdprxT03mfO9uzN18Vyqgodw9/cZxjD51NXkdTPJW3gCgpQ8UEMh4xRdck3QJVaTNLX91XIJZcpvS+xErqFKUKVrit9RCNwN61eITDNd0POc8F2L/psbr9YEU3ZdY0nGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by TY1PR01MB10882.jpnprd01.prod.outlook.com (2603:1096:400:31c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 01:46:01 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 01:46:00 +0000
Message-ID: <87zf3wof54.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Vinod Koul
	<vkoul@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring
	<robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Michael\
 Turquette" <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Conor\
 Dooley" <conor+dt@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Liam Girdwood
	<lgirdwood@gmail.com>,
	magnus.damm <magnus.damm@gmail.com>,
	Thomas Gleixner
	<tglx@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai
	<tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	"Fabrizio\
 Castro" <fabrizio.castro.jz@renesas.com>,
	Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
	John Madieu
	<john.madieu@gmail.com>,
	"linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>,
	"linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	"dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>,
	"linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>
Subject: Re: [PATCH 11/22] ASoC: rsnd: ssui: Add RZ/G3E SSIU BUSIF support
In-Reply-To: <TY6PR01MB1737712A0D0415CF57C759D2EFF48A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>	<20260319155334.51278-12-john.madieu.xa@bp.renesas.com>	<871phb9ruc.wl-kuninori.morimoto.gx@renesas.com>	<TY6PR01MB1737712A0D0415CF57C759D2EFF48A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=BIG5
Content-Transfer-Encoding: base64
Date: Wed, 25 Mar 2026 01:45:59 +0000
X-ClientProxiedBy: OSTP286CA0102.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:219::7) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|TY1PR01MB10882:EE_
X-MS-Office365-Filtering-Correlation-Id: c89d7d07-b40b-4284-49d1-08de8a104477
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	pXjV5gW7vwjtgHwwzPJcgzzWuuzmyVvuzybgEJY+4ZdQbkn84aNWi0yu4dc2qfO2/Tvgbo6DeJunFptmBo/4dhUeUwdOQzEdAmzKRGtT4kv2o/GDhuk/OXmOOEA1eY2Yu4OU8BvgvzQkd/Qi4H7+M0vshQkPbwWs4cHUDM2hfUf3CdyxsWQEYHgDT0QRGbBSMuH3oQ/sseFLWs+VS2+KCboJbYPLj7+jUvp2KmrNEFXeNwZ4Gx43sHhkpTbTs3AzRCs+N1jucNeu2B/ZrdAP/lDH2k92U98lGICkP/58YN2pCn8FwKQehzFkNtoRY45mU12WIGk+QvxSKqzsDt/sceIAV0oBbusnKsX9UNWlABwRi/Byw6J2QbAgyNTGksH3j64gorjNLA6oRSW50aeE2tvmpMVvkgCX5go+BIVqAKpSqUvlPjjVk9txY9VeyVLIJ3kMtokgJC3hGOLGgBpLnZn/69NvtKDey2JLVgE5LzT7mQzokfc/82fa17RDvelZIg3Fyw4c3ZpnEuW6csgayvJBpkurBJyVCSYr/gH4hKpUXMHV3NmxSyzz6l+rIEe5qVyFOakDT61v0/izWxPIsLzkqXVY3+1ko/Vix1mJXAqF4f8ML0P4GTflc4dipu8O/die8lWvMmwPUDxv0UIemfbwpg/zHAf4Znramu7D5u64P9gVeGhsjBMbAqggL2RORYCkYtY5Y52tTubMMLauuNp62+FkUDIxM8yp4A9s/h4tmN3KkF1yJ0GgOY/mCoz5VnUYa53FMoHgfFlGc3DVLLrJOVQw5P/bheF4Yk3/9Cs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?big5?B?WkRRVkEwZkJiMVc3VzZ2K2pmNk5HUXc5c2dYdjgyOGphNk54Q1BXR1BqRVFpNmhv?=
 =?big5?B?UlROTU5Tci9SVDJYNG5pRmoyUE55Mm13RkdScFVPM2FIWjh4VkhpTklLNEx3Y0U3?=
 =?big5?B?WG9MbXk2Y3oxUTR4aUJFWXBhZThRUEN1VHhuQlVJS0xGWGlaWG5SZXRQSjZQRjlp?=
 =?big5?B?TWFaKy8vL2tJOFd4ci9XZmVuRmROT1l0Q3FVc0puUmJPZ1FqV2hOeDFNSGFwWE8r?=
 =?big5?B?TWZDcVNlN2lWUG5OOHV2QTFtYVRhQzFXYTUvak51blJobzcyRG5oSnY4U2RyVFVs?=
 =?big5?B?MkpWVm04bzY0alkwa1VMVWFxTUl1cGRSb1hOWHlCa3FaajRDUDd6SThyYzRzOSty?=
 =?big5?B?ZmlMR1RNa2dmb1g1K1JHLzhTNklJcXNIS0J2VlVIT2c3a0c5K3ZxNC91SktMSjho?=
 =?big5?B?Z2J4cEUrOW93WXNjNk5vUnltallLeTdJdU1DbGxtL1lka2NDY0ZvclNBUzBiaWUv?=
 =?big5?B?ZmN2UjNMMVBBZ3dQeXdISGpNRGxkNk9xM25VQ2dBV2pmbnhPRVNBK0k4WjNMdmZ3?=
 =?big5?B?M0dWTHB2SlJLUXRRbmdGa1JwRGNzVXNXbWlMYTRqUW0yUkxyVHlJWUk0aFArRSto?=
 =?big5?B?UTNRSDlqNlVnQUNqRGV5OS8yN2MvV1dhVlhhR0RQUWFPREVqN1RFeXk5OUphSEp1?=
 =?big5?B?SXA2dkthRGE2dTQxZFp5RnRwa0l1QTYrcnl4aTg0TmpTWFJTLy9XdzFzMXNJa1dT?=
 =?big5?B?ZUVORCtyWEhwbDlSZ0xoMTZGR3hqb2lmVFpBeXFueW53dTFOajFHa2lYMEErSmJJ?=
 =?big5?B?TDI1T2pYeGRCQ3lRbHo2Z05FM2ZCUUJVQzlnTGE5T3BRaUthRTQrZHp3czc4VFhP?=
 =?big5?B?ZGxVRUwvWTJ1WE95OWE3L3dZODhOa3B4Z09Pb093MW9XVjNxTkxjem42eDdhd0J1?=
 =?big5?B?ci8rL0VEeG5YdUhMeTkzVUkxeVhhL1ROMGFSV1RrMUQ1RWMvVjFUL1BXbUl0aFVt?=
 =?big5?B?TmdYczFha1dFNkVNSDhneG1jUlcwQ3BrbVIyMFpYRm1NNGtWY1BNbVc1Y1lyaERO?=
 =?big5?B?VG1zVUpSZnZrREpNT2JLT1hKNFlkZk03WUJtUjJ2cXJ1ekhLNkxwK2twd281aDVi?=
 =?big5?B?bjBMdHJwR0xVb2tWcGxKTHRUT3h6K2dwNDlLVXhqUktZWFVubzRYVFl6RSt2Nkcw?=
 =?big5?B?cDBlNGdPTXpZVmZ3aTZqZkMvTTFGdzgvVGg3bzlCMHhmMG5LK05UWXVRSGs3QnJ3?=
 =?big5?B?WkNoNzJLdU1tdGV3d2RPSTdITjFDMUxIVHBhY2xTRWhsMGhtcGlxUGhQUGRVbE9Y?=
 =?big5?B?SVErVklzaEhyeG5kdHcydkNuWkxEK2wzeXNxdkFRRnhKaTZXOTFUcU51Z3pKU3Vm?=
 =?big5?B?eTVXaG53KzNwYUhIR0U5Rzd5REFGUkRibUdTZTVMcHoxRDZFQVRMRDZtdGZ2eFJB?=
 =?big5?B?MStkbzJWU05oOWNsdW1iWTFvdEd1ZEI4NDNiT1ZCUjVhV1VoV2pWbjlnd0x4dTNH?=
 =?big5?B?WDNTTFFWQlNxVmF5eG9lNVBONXdIdmpzbGx5bW9hVVBxOWM1QmtKYnpHakZqOWtH?=
 =?big5?B?WVd2QTkyVEU5bXpLOVZjR1Z3L2wvei9HaDdGQWtSSVVQR0kxa2tNNXJzU2o3ZjZO?=
 =?big5?B?c1dWTEtGbDBQSkpwbGc4QVR4VTVha2ZiZ2ZraWxaQjBMRk1YWEdQa1plUGd5UHZO?=
 =?big5?B?SC9DWDBabU5qNlZpVHRGQ3NDb1ZsTThqbE1rRml5Zi9yL0pKWmpjWS9ST2VDREJZ?=
 =?big5?B?d25CeUpiVjBGejA4ZWl0SzViNlB0aDV6WTdFVFFWZGV0WitpazRsNytXOUNJd0Zz?=
 =?big5?B?YzVEUXJqZ0RqSk5CQWRaVHFIaFlsRFVlMkd0NTF3MHFGSlVBcE10VDN0NnhtZWUr?=
 =?big5?B?UUxXd3gzc2lmTmM2ekFHQmZDUS9raFpjNzRIMXlBMk9mVEtTSW9VK2laSkJpNnJ5?=
 =?big5?B?bFp0UWRZOC9vS3N2MmJsc3RuREt2b3RjdUJDa09QbXZSL21HNFJGUEx6UTlWRXdw?=
 =?big5?B?cHJWbnpUMk5XcnFLWmszWE45cXVTblZxdVRCa3dwaWZkelJNRXY5YjI0YVdCdnh6?=
 =?big5?B?TUxjSDM3TURLWThnNU9lU1QwU3BkejBTY0VPeGJEVFhZYnNnM1hHYklyakxPNXo5?=
 =?big5?B?OExuSE5zRXZacjFwRGIrNG1ySHEvNW5LM0xlNWdYRzRURGsza0E4SmpDbktwY25q?=
 =?big5?B?Qjh0cE90bi9mMHRRcTRxcit5YkFPdnlZZEZpUnFuejVrN3RESzBXcWY2UDAyY3kw?=
 =?big5?B?MmlrdnlhRGtrMkVrUHAreXJldkZUOEo0TU9JYlo5Q1RPOHJKKzVKcVRGMUlPN2RK?=
 =?big5?Q?2iGEYCV2Zh2H82Mo?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89d7d07-b40b-4284-49d1-08de8a104477
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 01:46:00.8157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1NPAiAA5PyX9Stwzvw/qZZsZrQSLjTTDH+KS0C5aqnDcY0NoFURqRbDmFVyoGcap0VX27BjEl/zwt+pRjsWdUf9ePWQexf+uqNgb0HvwVdjk6sspC9l+e0JKRE+ngmR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10882
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9638-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[glider.be,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuninori.morimoto.gx@renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,renesas.com:dkim,renesas.com:mid]
X-Rspamd-Queue-Id: 4CB5931E660
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQpIaSBKb2huDQoNCj4gPiBJIGRvbid0IHRoaW5rIHdlIG5lZWQgUlNORF9TU0lfQUxXQVlTX0JV
U0lGLCBiZWNhdXNlIFBJTyBpcyB1c2VkIGZvciBkZWJ1Zw0KPiA+IHB1cnBvc2Ugd2hlbiBuZXcg
U29DIGhhcyBjb21taW5nLg0KPiA+IA0KPiANCj4gSSB1bmRlcnN0YW5kIHRoYXQgUElPIGlzIHVz
ZWZ1bCBhcyBhIGRlYnVnIGZhbGxiYWNrIHdoZW4gYnJpbmdpbmcgdXAgbmV3IFNvQ3MuDQo+IExv
b2tpbmcgYXQgdGhlIFJaL0czRSBkYXRhc2hlZXQgKHNlY3Rpb24gOC41KSwgU1NJVERSL1NTSVJE
UiBleGlzdCBhcyBkYXRhDQo+IGJ1ZmZlcnMgaW4gdGhlIFNTSSBibG9jaywgYnV0IHRoZXkgYXJl
IGFjY2Vzc2libGUgb25seSB0aHJvdWdoIHRoZSBETUEgYWNjZXNzDQo+IHBvcnQgLSBub3QgdGhy
b3VnaCB0aGUgcmVnaXN0ZXIgYWNjZXNzIHBvcnQgKENQVSBhY2Nlc3MpLg0KPiANCj4gVGhlIGRh
dGFzaGVldCBleHBsaWNpdGx5IHN0YXRlcyAiUElPIGFjY2VzcyAoc2V0dGluZyBwcm9oaWJpdGVk
KSIgZm9yIHRoZQ0KPiBCVVNJRiBkYXRhIHBhdGguIFRoaXMgaXMgYWxzbyB3aHkgdGhlIHJlZ2lz
dGVyIGRlc2NyaXB0aW9ucyAoOC41LjIuMy4yOaFWMzMpDQo+IGxpc3QgU1NJQ1IsIFNTSVNSLCBT
U0lXU1IsIFNTSUZNUiwgU1NJRlNSIGJ1dCBubyBTU0lURFIvU1NJUkRSIGF0IHJlZ2lzdGVyDQo+
IGFjY2VzcyBwb3J0IG9mZnNldHMuIFNvIFBJTyBtb2RlIChDUFUgcmVhZGluZy93cml0aW5nIFNT
SVREUi9TU0lSRFIgZGlyZWN0bHkpDQo+IGlzIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIGhhcmR3YXJl
Lg0KPiANCj4gSWYgd2UgYXR0ZW1wdCBQSU8gZmFsbGJhY2sgb24gUlovRzNFLCByc25kX3NzaV9w
aW9faW50ZXJydXB0KCkgd291bGQgdHJ5IHRvDQo+IGFjY2VzcyBTU0lURFIvU1NJUkRSIHdoaWNo
IGFyZSBub3QgbWFwcGVkIGluIHRoZSByZWdtYXAsIGNhdXNpbmcgYSBmYWlsdXJlLg0KPiANCj4g
U28sIHNob3VsZCBJIGtlZXAgUlNORF9TU0lfQUxXQVlTX0JVU0lGIHRvIGV4cHJlc3MgdGhpcywg
b3Igd291bGQgeW91IHByZWZlcg0KPiBhIGRpcmVjdCByc25kX2lzX3J6ZzNlKCkgY2hlY2sgaW4g
cnNuZF9zc2lfdXNlX2J1c2lmKCk/IEkgd291bGQgZ28gZm9yIHRoZQ0KPiBmaXJzdCBvcHRpb24g
YXMgdGhpcyBjb3VsZCBiZSByZXVzYWJsZSBvbiBvdGhlciBTb0NzIGFuZCBhdm9pZCBTb0Mtc3Bl
Y2lmaWMNCj4gY2hlY2tzIGFjcm9zcyBmdW5jdGlvbmFsIGNvZGUuDQoNClBJTyBpcyBhIGZlYXR1
cmUgd2hpY2ggY2FuIGJlIGVuYWJsZWQgaW4gdmVyeSBzcGVjaWZpYyBjaXJjdW1zdGFuY2VzLg0K
SXQgaXMgZW5hYmxlZCBpZiB5b3UgcmVxdWlyZWQsIGFuZCB3aWxsIG5vdCBiZSBlbmFibGVkIHVu
aW50ZW50aW9uYWxseS4NCklmIGl0IGhhcHBlbnMsIGl0IGlzIGp1c3QgYnVnLg0KDQpUaGFuayB5
b3UgZm9yIHlvdXIgaGVscCAhIQ0KDQpCZXN0IHJlZ2FyZHMNCi0tLQ0KS3VuaW5vcmkgTW9yaW1v
dG8NCg==

