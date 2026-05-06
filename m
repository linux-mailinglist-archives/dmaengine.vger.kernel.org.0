Return-Path: <dmaengine+bounces-10245-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHswET6o+2mYewMAu9opvQ
	(envelope-from <dmaengine+bounces-10245-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 22:44:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CEF4E049D
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 22:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3260301828A
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 20:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395783AF660;
	Wed,  6 May 2026 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SwHoF/fe"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2359B3B0AD8;
	Wed,  6 May 2026 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100278; cv=fail; b=JKPRIfL15gpZ0tQN67CujujVc1H1/s/N6Je94PHWVwlAzT0DYhy8GWdL2RXkw3PMmo68ZQ1reVsFfexu8ox10RVo3QGT3f6xfAVQgpvLIFNb1R1UrvDz0kJakB8yPSDpB+0+f3HdvVgTSoZqcH/EOxJtQbcpa2Z/ziT0WN/gzXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100278; c=relaxed/simple;
	bh=rKGad3Y9jDTy3ErmCpirSi1ak0zuyxePwG7VCxtVVFY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KcH+Stri1E5t9fX/BKOvBiRDU3D/QPszc2cxHxhnrvP7IdcJyJNrAPoZkTuP5LLPQXu7FVTFD6vGXhmfCGMthxAprGVZpiFkc/JDMjzMdPlQGhPCD25+3MnzPVdmjPWYAqnyRkqigFhJC52FmXa1DLuMok4L/B/wdu3SMeormEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SwHoF/fe; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Su3K/YoWVGIv1PrYP5zKHjh6YEmwf3cG2u8+vLcaJtDSGxpnznXZhKnHRuQVJPbhQbCO+xP3uSZjv043I3BfphGuvwdLZtpVKmlLfHAOtAU4o1pf2yR3/fOSdyCknPP7urtqdgLeFd6QqNP7vdm2qx/JE/9akerLP4bYjXiF6Fu4FIiLm9OnPz4QLbrkhutkPlNt/zixzlj146xr0LPARSY3Kzr2H5s+TkUTNvTkeDbbDs9koNLrymegVzdsMqjbAQvUOfFs0vWOxmNUsHIPrXErcnJj9AYAq053NEMaaPjDwSlMbPuols2lnq5mSPo+uil2299mCqTI7BVa528bOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnlEYTtzjafAlMfUH7IJz7ulUph3WkfYyDbQ6nfk8Lg=;
 b=O9N3a3mNZzEKoG4ldaBZxiTpvNIh8kD8UldrQjle8oSgqaMR6w80R5fYKLmZVIRH0GOFAOAz+DjJlZEk5x3EvgAqklgQhGEM6tW1fsFM3a54wliyon3N+JS+ywulfHa3vUYBQ54gToL86MyI2hTuzrsghcJuLld1YnuLw9QkDEUBsCehUttk9fiJEL9YWlmAhj14et17t34U4uIgFW7ArGMX6wfl3O/mio5JrdNw5IjoZRZlsNBGqllND2oxOa5P34sLnynmt19RYCUpxkYTYVB+NlIFik0mx97A9tG0mp02/i8t5J5txbkKGSR28i9tjGYYxB5rridVVKy3UaU4fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnlEYTtzjafAlMfUH7IJz7ulUph3WkfYyDbQ6nfk8Lg=;
 b=SwHoF/fexbp2pbMCROdoHoUgd9nrULTmvc4DIPr8OyJ3FMPUCiq0Vux4+W4Rqt0HOAOse5U5iLlpbib8l1hLk4vdebEIXFwN4quL2lURHVfGBsjk7XggPEjJSHXcZ+wreo1+XFNgayMtMggeDjYaK0yse+t3v3fBskci5uyPdncrmF/kjiEQLIvb2O7vIafPGE77uvdfXasmOWtM35NRyISkhIhdHkeLpDyBshfI9OAICyT6SQVG5tnGWZPVxWUkpu8L2+WNY1eCBb351UhWbK/gwho8OuqeXebqzVQSWjqEPxarv6h1F4PN7UEI9uang3JmPqW2bjf3auKSjs5gbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by GV1PR04MB10479.eurprd04.prod.outlook.com (2603:10a6:150:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 20:44:32 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:44:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 06 May 2026 16:44:13 -0400
Subject: [PATCH v4 1/9] dmaengine: Add API to combine configuration and
 preparation (sg and single)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-dma_prep_config-v4-1-85b3d22babff@nxp.com>
References: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
In-Reply-To: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778100264; l=7332;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=rKGad3Y9jDTy3ErmCpirSi1ak0zuyxePwG7VCxtVVFY=;
 b=46XFsQOdyZbgJJq6MOMDuk07LFbG/x7HHQ/35f1PqR6iWo5Gl1xAalyPx6uilPER214FVMYsU
 Yu+9GnPBTHuDd7x881RSzKB+0XWpQDFXYnNpT3+5JI+mBk+ZMDgYe2I
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0051.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::24) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|GV1PR04MB10479:EE_
X-MS-Office365-Filtering-Correlation-Id: 96da19e5-3244-4794-4c5f-08deabb046ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|7416014|22082099003|11062099010|921020|7136999003|18002099003|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info:
	s/rnrRcHsp9VKYpEXrFU7uG5BPEB6XJhm+XdvZPVKQ5FCgBUgF9Yni7bynBM0UFF7tpDrX85t15mwHya5l0kLya8QD/Bq8OYoQ2173opTbPZtzKt3oShNeGd8bEdYrCisvogI6HV7oppOmBCS6qeXeh2p968a6Q8HYRp4BUXOIhK3eDI/IuvlH8bxklCz6FliIGykJAklQhb/L1EfbdNgkg/GmrAX3wL5+6ZEkMWofokeIsBuAOkhftUPtgVUS3EOu9Kgr6rRrUgMp+/S4TMIBA6nLrA5DYpBls6r6EXDFVPinPOOcuCrzYJleaKK5hzLyjci3VzI08KgQyDlpBYd2boU2CcWEPFPiQZkXcnqA5zOVstS+x9WytuAgPzGK1aMFRHOiKzz98t8ZNaJchlfa1rorjAY0P26rEr9ZzY9gbpchFsHfhwCJv06S40ekR3F9lZ2bSF5a4b7a+OBvFtU1GsSBCOMNB9Rr/ny3vuFXA88r4ltft9k4oeAXpxHabKTvABDLoO4flNmIc9suiFqz1ZNP25Z7MiT+Vz+nBYdfZwbSoTCvb3N6YPLs1BbpfnVg0mErTfDsMpPkgwxSLdMC7e61Q6wgdLWT9EcV/vyFiVY6vSDT7F+vpRH7kTN9/XSnfi/32uh/ruV8LydiVbKAEK2cWPknxLIf5zu8BPxBAxLVjY1G+ezF0upjiyffDUAOerylp5FUluZD38/x9+Pk7YmCNpAVIvPa+Qg+wqXNGU2KPZ+qJ9/z7c0ZurVgUhDZtx/8O7ztwp6+TjsCkGTQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(7416014)(22082099003)(11062099010)(921020)(7136999003)(18002099003)(38350700014)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVpRcXJlMm5rUWMrZnlHNHRaRndxUFp0ZlR5bWdIdER6ZjdNajVlSC9LV1Ru?=
 =?utf-8?B?WjlnTWxMblR4MTZ5Q0pmMklpMEpVS2Q0QjFYeXMxbWgzU3hQT1BHS2M2RUNI?=
 =?utf-8?B?Y1ZxQ1laalFKSHN3T1FBNHZTK3RhZXVTcklZSlJ6SlhqRk9ESUhLdUVsRUZE?=
 =?utf-8?B?ektLcWZqOHJ5NExpOU9sT1M5Nk8rMWI3SUMyRzJBRVRIUnkzOU1lRHkrZkVH?=
 =?utf-8?B?d1FMTER4ZlNUaGxDemd5T1poOFhLWDhXQ0dWRWRjMGlER0NQaVlvQ2lmOVNm?=
 =?utf-8?B?ZW9NdWpYQ3h6OUlUOC8wTU1mQzFRWkFoekpGbnM4elVML1FWaFFoL0krUG9s?=
 =?utf-8?B?L0dMNnkvTUdiTUpmOTBqbG1aS3FITW5ETWdvS1MyNTVFMVJ4eGpLa0wwTlds?=
 =?utf-8?B?eUs1dWV2RmRleGlWUmtzSzZwVzYyRVFYVTZycWF3VGhaV05TdmxsMXg0cEI1?=
 =?utf-8?B?K3FYSEl5U0tCVTFCY3hXSEJScWttbFh3SlJLeE5aY1pWNjA5NUxwdEVUbHUx?=
 =?utf-8?B?Yk40TVoxeDBDa0dKNUx4TFBiajR3NVJOdUlmZC9hMGVtc1lFc3Z2MXlhUU95?=
 =?utf-8?B?RFlnWnBnRnprTElob2Roa3ZLaWg4VC9yN1MxVUQ4WVA1eDg5Mk1XZDlqS3Rs?=
 =?utf-8?B?QUFza2IyTmRpaXhqM0Y4eGZ2ZXN2QzluL3FlL0ZSdHJSYktFS3EwbmVUZTBD?=
 =?utf-8?B?d3JOcC9HZi9MclNRZVJjVkZqc0NCalZTelF4bEhJQ2NoN05reVhVVkkyOWdV?=
 =?utf-8?B?NmlkWDFQYlo2ajRFajdGL0l5TU1GUnpNWmc3a09GTWNDenR1OXB4NWIrWGFG?=
 =?utf-8?B?NGdrdXZtWW9zclNBMGQ3TDBoZ0F0eGYyQzN1dGFrRUhDWk9adk8xTVUvNkt2?=
 =?utf-8?B?dXBJU1lwOFN4aHNiSXVJRFJHRTFlWEttQlFWVW1HY2g5NmRsSC9XcVV0SHZY?=
 =?utf-8?B?RHFaazc0OGJwU2VIeUZoTlNDSjJhTFhLem1QTkw2cEZhM2gyVWFDTExJQzFW?=
 =?utf-8?B?b3BtZmk2RlRPOXBnZE9qY0xJM0hVaFIrTm5DYTA2aThaUzN4L0c5bVMwSk9T?=
 =?utf-8?B?clM4LzFoRHNwUnNJOGhWZnhYRnExNGxHR0xFTDN2UzZMU0J5ZHJsSWZiZW1R?=
 =?utf-8?B?QThLZUFoWDg0R3o4ZEM0TzlxNDUvYW9jZkRjMi9UMkthQ2FyQzVBSXYxYlJO?=
 =?utf-8?B?aTAvNUVTZVlWM1hZVlovUXBxWUtkcHk4M1A3Umx0OUFmQmxwUExVYW9aNjB4?=
 =?utf-8?B?VTZLbGk2N291SVh2VWdGU29ncE13U09pVnJ4NnExVmRmL3VpTnRma2Vwaytt?=
 =?utf-8?B?em5vdkZSd0pYS21oRUR1cTN2ejlKVnA4aEsySzBINXJ3b09JVFJlSDNYMy9j?=
 =?utf-8?B?TE55NC81bjh1Ti9HaWFHVG5zejdQcWpWRXNrc1h2UjhnRnJNdlFSd3ozSVIx?=
 =?utf-8?B?UVJRQjMwV1RVQWFIRWZtWkxLZVlNTmpXbDJCT3QzeVJNZnBoMFBoYVJEelBa?=
 =?utf-8?B?Vk9iTlEvSFc2TVltRmQ5Rm9LajdoY1pSWVJiYm9UNnRKdVozb3M2MFNVV2N3?=
 =?utf-8?B?eUhrRWJzOFRucDdWNjVOMXM2U3NNNmd6Yjg3MFBJT1FYNzAzdjQ1RjJxenZU?=
 =?utf-8?B?dGl6YUNoaGZqMnZnbTBKUW5FSHh1R1NiWlpOYytEK00rNnppL0k5UXJ3WGpy?=
 =?utf-8?B?UFQyazVrZmhpYk1FNndmU2FrTWMyWTBkdlpMUnBLQ0gxMnVXOFNvdjdTOFVD?=
 =?utf-8?B?TDdEcWNNU244U3pqOXJWYmNTQVJISENYL3pHU2ZmQys4VlVEWVMycFYwOVZE?=
 =?utf-8?B?OVR5UFpVVm1UdkFlbkJhcHJLTkFtdmQzYnoxckEvSHJrVEZ3aUZnMitrd29i?=
 =?utf-8?B?MmJMaXQ1cVZSWXFzejR4c2k0cmdwRlo3M1p5NElnQlRHWkNoS1dQTHVRV1hH?=
 =?utf-8?B?R2JDVnN3TkhLcEh4K3hSeUcxRXh3d096Z2tkTG9tQ2pSM21UVGNPQ3NKWkpX?=
 =?utf-8?B?N1hieGlQanBJbkFwU1dsdG9JNTl3MWdFOFcweHA0VmNyNG1MOUVWQ0FoUEM3?=
 =?utf-8?B?bHVXUThjVjFxdWc0YlgxT1hERldOZy81aC9Kdk9YdWVPL1R1amVGUTVzMkNi?=
 =?utf-8?B?RDVDbHF3c2FQVlU3Vk1PWjBBWW1jWUhiRktIY0VtbUdWMlBHZnBBbWRudFlI?=
 =?utf-8?B?NHNVU1pFak1kc01IK0J5K3UzZ29qd1BjMERINXdMT2wyYmFTeStXMFVGUVpL?=
 =?utf-8?B?aU5PRmJZRmk2MVA0NHlOSGl3c3N1RmVxdE16NnFBellUTHZHcFZNTklkVjdS?=
 =?utf-8?B?UE56UnBOQVBUaFBNb2Z6eVdwNTZkdTQ2MjBCTGI0cjM1dml4MlBRdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96da19e5-3244-4794-4c5f-08deabb046ee
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:44:32.8100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0pj2cAjE6XXn3XBygIB01eaLcV6eSWAiNCIvXyoc0GQtSfJMF8NieH/hHqPGN+V2FyM5oh8OeIT9AVFVzU3eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10479
X-Rspamd-Queue-Id: B0CEF4E049D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10245-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

Previously, configuration and preparation required two separate calls. This
works well when configuration is done only once during initialization.

However, in cases where the burst length or source/destination address must
be adjusted for each transfer, calling two functions is verbose and
requires additional locking to ensure both steps complete atomically.

Add a new API dmaengine_prep_config_single() and dmaengine_prep_config_sg()
and callback device_prep_config_sg() that combines configuration and
preparation into a single operation. If the configuration argument is
passed as NULL, fall back to the existing implementation.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- drop context in device_prep_config_sg()

change in v3
- remove Deprecated for callback device_prep_slave_sg().
- Move condition check before sg init.
- split function at return type.
- move safe version to next patch

change in v2
- add () for function
- use short name device_prep_sg(), remove "slave" and "config". the 'slave'
is reduntant. after remove slave, the function name is difference existed
one, so remove _config suffix.
---
 Documentation/driver-api/dmaengine/client.rst |  9 ++++
 include/linux/dmaengine.h                     | 63 +++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
index d491e385d61a98b8a804cd823caf254a2dc62cf4..5ee5d4a3596dd986b02f1bce3078ca6c4c1fb45a 100644
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -80,6 +80,10 @@ The details of these operations are:
 
   - slave_sg: DMA a list of scatter gather buffers from/to a peripheral
 
+  - config_sg: Similar with slave_sg, just pass down dma_slave_config
+    struct to avoid calling dmaengine_slave_config() every time adjusting the
+    burst length or the FIFO address is needed.
+
   - peripheral_dma_vec: DMA an array of scatter gather buffers from/to a
     peripheral. Similar to slave_sg, but uses an array of dma_vec
     structures instead of a scatterlist.
@@ -106,6 +110,11 @@ The details of these operations are:
 		unsigned int sg_len, enum dma_data_direction direction,
 		unsigned long flags);
 
+     struct dma_async_tx_descriptor *dmaengine_prep_config_sg(
+		struct dma_chan *chan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_transfer_direction dir,
+		unsigned long flags, struct dma_slave_config *config);
+
      struct dma_async_tx_descriptor *dmaengine_prep_peripheral_dma_vec(
 		struct dma_chan *chan, const struct dma_vec *vecs,
 		size_t nents, enum dma_data_direction direction,
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index b3d251c9734e95e1b75cf6763d4d2c3a1c6a9910..defa377d2ef54d94e6337cdfa7826a091295535e 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -835,6 +835,7 @@ struct dma_filter {
  *	where the address and size of each segment is located in one entry of
  *	the dma_vec array.
  * @device_prep_slave_sg: prepares a slave dma operation
+ * @device_prep_config_sg: prepares a slave DMA operation with dma_slave_config
  * @device_prep_dma_cyclic: prepare a cyclic dma operation suitable for audio.
  *	The function takes a buffer of size buf_len. The callback function will
  *	be called after period_len bytes have been transferred.
@@ -934,6 +935,10 @@ struct dma_device {
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
 		unsigned long flags, void *context);
+	struct dma_async_tx_descriptor *(*device_prep_config_sg)(
+		struct dma_chan *chan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_transfer_direction direction,
+		unsigned long flags, struct dma_slave_config *config);
 	struct dma_async_tx_descriptor *(*device_prep_dma_cyclic)(
 		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 		size_t period_len, enum dma_transfer_direction direction,
@@ -974,22 +979,44 @@ static inline bool is_slave_direction(enum dma_transfer_direction direction)
 	       (direction == DMA_DEV_TO_DEV);
 }
 
-static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
-	struct dma_chan *chan, dma_addr_t buf, size_t len,
-	enum dma_transfer_direction dir, unsigned long flags)
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_config_single(struct dma_chan *chan, dma_addr_t buf, size_t len,
+			     enum dma_transfer_direction dir,
+			     unsigned long flags,
+			     struct dma_slave_config *config)
 {
 	struct scatterlist sg;
+
+	if (!chan || !chan->device)
+		return NULL;
+
 	sg_init_table(&sg, 1);
 	sg_dma_address(&sg) = buf;
 	sg_dma_len(&sg) = len;
 
-	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
+	if (chan->device->device_prep_config_sg)
+		return chan->device->device_prep_config_sg(chan, &sg, 1, dir,
+							   flags, config);
+
+	if (config)
+		if (dmaengine_slave_config(chan, config))
+			return NULL;
+
+	if (!chan->device->device_prep_slave_sg)
 		return NULL;
 
 	return chan->device->device_prep_slave_sg(chan, &sg, 1,
 						  dir, flags, NULL);
 }
 
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_slave_single(struct dma_chan *chan, dma_addr_t buf, size_t len,
+			    enum dma_transfer_direction dir,
+			    unsigned long flags)
+{
+	return dmaengine_prep_config_single(chan, buf, len, dir, flags, NULL);
+}
+
 /**
  * dmaengine_prep_peripheral_dma_vec() - Prepare a DMA scatter-gather descriptor
  * @chan: The channel to be used for this descriptor
@@ -1010,17 +1037,37 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_peripheral_dma_vec(
 							    dir, flags);
 }
 
-static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
-	struct dma_chan *chan, struct scatterlist *sgl,	unsigned int sg_len,
-	enum dma_transfer_direction dir, unsigned long flags)
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_config_sg(struct dma_chan *chan, struct scatterlist *sgl,
+			 unsigned int sg_len, enum dma_transfer_direction dir,
+			 unsigned long flags, struct dma_slave_config *config)
 {
-	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
+	if (!chan || !chan->device)
+		return NULL;
+
+	if (chan->device->device_prep_config_sg)
+		return chan->device->device_prep_config_sg(chan, sgl, sg_len,
+				dir, flags, config);
+
+	if (config)
+		if (dmaengine_slave_config(chan, config))
+			return NULL;
+
+	if (!chan->device->device_prep_slave_sg)
 		return NULL;
 
 	return chan->device->device_prep_slave_sg(chan, sgl, sg_len,
 						  dir, flags, NULL);
 }
 
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+			unsigned int sg_len, enum dma_transfer_direction dir,
+			unsigned long flags)
+{
+	return dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, NULL);
+}
+
 #ifdef CONFIG_RAPIDIO_DMA_ENGINE
 struct rio_dma_ext;
 static inline struct dma_async_tx_descriptor *dmaengine_prep_rio_sg(

-- 
2.43.0


