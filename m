Return-Path: <dmaengine+bounces-2105-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5658CA08A
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 18:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C76283BFF
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 16:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BD71386D9;
	Mon, 20 May 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gMnBNFOf"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2079.outbound.protection.outlook.com [40.107.13.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2291386D1;
	Mon, 20 May 2024 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716221427; cv=fail; b=cRdocTnu7euuGzlYroJC0+5EMse0jbc7h58cyxqNlqQ7pSyHgeOkzw/ALTKJmS2+8pMgwMqhAKDFkci5OTn+/GRKUuJKcptqtOoK0IJZ8HsBKUR9d61TMfaJUZSrOj+c2SW1WNO2Pbq7gnw5aQKY1rY/o3JptiKGhqOdPHre8sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716221427; c=relaxed/simple;
	bh=Sw93A6LU58pwgdnzIBCjouGCoo5gK8ry/LgTrzVBlm8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mjAGslM+FWLr0pOKkC4HYTj0hsBeXLBJwCeIp93UfEODwWI0r0aE3iyqRfJbxHSWInra/RNGH0XsYWNWKvn7ZN94Cv5LxtmC9FpqSGC5CpSebJf2dyw69X4Y5HbdRSAZxNUYGfzzOBG05jESWpwc9VMV/Chs8mTs6KV7/zaXavo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gMnBNFOf; arc=fail smtp.client-ip=40.107.13.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiOrtIdwHvamzgLzSqJEjF/9M2JuogJ2+Ie4rFAS81fODPaFELwNVOhgm9nZxU3wyXeVQhpKp0Y8kC3PjuyPSr0pSMjtNIFJeaTXnQO72MCHxCdH93/jLWmU9u2EtDVkv1aa1aYeC5rb8sTtTPH2saBM0fNN6dmXPQmQpYl9l1kIPo/HbrS27P19/7ugo4X3pq9dW/1BoeW8ipOWOcWS1vuTycIXdJaC3TSZzo2gQou/mEO6FE2JwLQ1d1hsi376JOgWJS/6UwcGzIuf6yugziUU3s4alnKLnlVpCTl1avs147uP2zxqtk22qWbPiO6J8e2ArW56Mee6HR9HhTi1EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym22gS0kdMfyxUPUeSJZsfWqaBY3uJD1o9Zz+PLgLKQ=;
 b=LlW0Kb4rtALA1IOAJQIlleFm/iKUnauiOgklpCq2LrY2TjMbOCGG+UTAP6jikExVETa8GQaTNTDYqmOfx27zyM8H8kwbDf0XmFnisNNzt/WdGzEO2SiUS1TWpkFZnd2r0wtUXScxsjinC+IZa2RgQH+uLTPwMEqmjYO8b1Q15bcYaIiMO7P65gUTQBC7kQS0jVuB7QIxjcNr+nzAv7jSGsb/DnlDo3yOeEBGXPQNvuufTHTofMyPaHUaIiei4ySB1OlEnNrSFhmn7cTKhaZutYtjzzlZtUhjsa+LxeEOb4g4ZMa5hq0RCbfti4VQ3qv+n/Y3lQS1JL+kRRR3qoZWdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym22gS0kdMfyxUPUeSJZsfWqaBY3uJD1o9Zz+PLgLKQ=;
 b=gMnBNFOfIOSnch9+9J+Nbc5Fhy1/9XO9Sd5WV4L5pdIWk41TTFAikUL2feMQew79wKW8shUwzyFIut9BbLQo/TgnVC3nt0viYVkBCQpp/hjOlVRP4qU0QrgQJKLynaY3cl82Y9UVqogVJ+qn6BHTIZ8UXFcOtbYZ5vNmmyYV0OI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10164.eurprd04.prod.outlook.com (2603:10a6:800:243::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 16:10:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 16:10:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 20 May 2024 12:09:17 -0400
Subject: [PATCH v2 6/6] arm64: dts: imx8dxl-ss-conn: add gpmi nand
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-gpmi_nand-v2-6-e3017e4c9da5@nxp.com>
References: <20240520-gpmi_nand-v2-0-e3017e4c9da5@nxp.com>
In-Reply-To: <20240520-gpmi_nand-v2-0-e3017e4c9da5@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Han Xu <han.xu@nxp.com>, 
 Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716221390; l=1138;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Sw93A6LU58pwgdnzIBCjouGCoo5gK8ry/LgTrzVBlm8=;
 b=upZ07m8D6i/iO/oD46qx8maIkgr5h7E8WR7Mqy3WShtHlqah0hdDt6PgjvHZ437pCzAXjArfR
 kvIwSV9dHWWA4QXMJnkju55EMy1OlwPoOixTCkaJFnivtoNwmo6BVEm
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:217::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10164:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e493966-ea42-40c7-e432-08dc78e75a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|52116005|366007|1800799015|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0JvVUIxd0kwbWhFZXdBYkpyL1ZYREtMOHp2T2ExYldKMURabUJ0b29FZmpu?=
 =?utf-8?B?TUZXR2Q3cFBMYWl5RlVwUXhzTVQ0V29pcktYUHVHTytBNXlMalM2QXhMMjk2?=
 =?utf-8?B?NElDK3lxR3EyOVljb29WNmVBYlFpQ0xhb1AwTmlxNWQrYk04ZS92REpzbDZp?=
 =?utf-8?B?cU5HOVpmK2FRWnlQc2ZXRWxjY0gzdjRyK3NXdWhpY0JzWXBqYjJ2Ky9Vdllz?=
 =?utf-8?B?bW15Tm81SzdBdzRkVS9SS0JNTS9POHJWaWNXTkVaSUxzNTJJcndiMzBOT3Zk?=
 =?utf-8?B?MGo5T01PMXkrVElJWnRmUVBNNXJtTDh5bnA0UVJNbHdjR1RiQ1F2Unc4NWIz?=
 =?utf-8?B?VVUrcmZ5TXFLMVY2N2x3Um91aThzeHZHRUJMNHFFL2J0SDVRWjZSN0tKdGNl?=
 =?utf-8?B?eHRldzJnNmtvOHRSdDgwNzdTK3JUYk0xQW9SQlY4NDgwZDlUcFNCcCtybGUw?=
 =?utf-8?B?bURWdWJOTWFFbkdhWUNnNWVGT3pMWlRnTHBCMVpoRDBaejFGNzRJdTJaWXhp?=
 =?utf-8?B?cXBFZG5jMHIrUGkxQlUyeXNFbmRSSFNMd0tGeVpldG5jV2lpd256ZnBTNW5Y?=
 =?utf-8?B?RjlpT3g1QW8zclRHSWhnbS95WmxONDVYVkk1RXE0MlJzV0VrTVFaLzAwM2Fa?=
 =?utf-8?B?TnZxbWZvMzQ5VmM1VmRERCtIVVhXOXEyNHBOT2o5S0ZLWlJFQWFsYk5ta2ha?=
 =?utf-8?B?c2orM29nZnBtc21QQm9va25oNEg5QnlqTzR1ZmhXd0hkekQ5aUswVUEzc1hk?=
 =?utf-8?B?WHhVRG95bGxvR1dZL09jL0YzQmpGV1QxcmREU1B2bEUzVm1NNEY4VUNKM0U2?=
 =?utf-8?B?RENUQlJGcTlaQUk2U3MxTFJKaVJVQm9uemkzNEpUTThiY0p6UEZwWVlkMGJC?=
 =?utf-8?B?UTNNbE5IdDZJalhhTDBhWExEc1ZtdG1tUTk0bkhYRnUrczFId2NCOUZZejlM?=
 =?utf-8?B?bHZ4ekdoYXhjRzczR0kzRW4zWm1uUVdZZTVkWUhCaVQrMzEveGFMbG04dnFN?=
 =?utf-8?B?RUdGOGtVeXRhVmRDVFR6WkJIQlB0eExzLzNRZC9zcFNFSm84aUltNjlNeG9m?=
 =?utf-8?B?SmZHYUFaODN5T3pkU0dHVzkyYnVXZVBxRzA0OWNwSnM4dTlvK0NrM09UY3RN?=
 =?utf-8?B?NGh6WDByRWtob0FMV1ltMkc1Q200VDU5VmhSWkRqamJqNzBIVzRtSFZyanE0?=
 =?utf-8?B?NDJZakYzaTZyekI1WTc4OE1lWnZzWmpNZ0tXSVFPY0VMLzRCbWg4VXlZS2NH?=
 =?utf-8?B?cEJxbVRGeU1veTZnWVpCUzhxS2lObnIydGFybmU0QWlmdzdWTitpMFpMU3JY?=
 =?utf-8?B?NjZNemsrcFBmOXIvZDMzeFhEd1NJVWpPUEYvNlVkVlNxbkdENUdRMFdVR0ZY?=
 =?utf-8?B?bFNOYndQNUl0T0loQThYb05JVVVWaVNjTzlrMnVweGg2cXNkOCthazl3cDR4?=
 =?utf-8?B?VlEwdldyd2d5cjgrMTFVWDQ3TUx3b3h3RG9mQm10NkVxbUd6MS93Y0FueVBP?=
 =?utf-8?B?NXlSb0V0S1RnYkJkazBSU0tjS0p4ZHRRTmpCdFl3azVuZ2ZnNW9XTCs0Rk5R?=
 =?utf-8?B?Yjd6L0NTell3d0xneHFiekV3UkJPdUtwM0kzMWJacit0VXU1TXlmZHR5S2hT?=
 =?utf-8?B?ZGlwdldQK25BbE0yaS9INSs4a1RCbkZnQnhlajQxSmtHWTZTekpqbGg5dldS?=
 =?utf-8?B?TjZ5M0pKb1A1WHg4R1Z4OU5uUkVUUG9HdDUvSEVwODdSc3JVbWlpbXBFTDI1?=
 =?utf-8?B?aTNJaDBxZVR4cGZGRi9ZdUtoQWg5dGs4UkVHM1lJcjVrNTZsUktnMVg5V1d3?=
 =?utf-8?Q?X4HTD8eRpVevvAIwPnao0WIxb0WUKza1Uhne8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(366007)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U280dUczTG1hQmtMbnJta1FJYnpZeVl2OTR5dS9BbFhmU0lhWk5PemJvVm1a?=
 =?utf-8?B?VnB0QjZOTXNjWDF6V2h0cjFIdlRJREdqS01UZW1KMitnMXR1SGJRSmJQOUY0?=
 =?utf-8?B?M1AwQ1MvT0RlbG9wVGxmR2hGb01OTE1jMTVqTElpRUE4UlNRcHRKVHZqMi8v?=
 =?utf-8?B?dDZsYlJ5V3FKWXU5VkptTWhIdXc5cWJpbGVSQUJlSEYrOSs4dk1VWS9QTXZY?=
 =?utf-8?B?d0tzWEd2endKRE5oVHZaU0dVUFhDYjMxb3dQKzA2aFlVU0lqQ0hDSmNPM0pC?=
 =?utf-8?B?TGFXUlo1WmZhQnBjWUt0K1hxY3E5ZFcydWYwT0VwdEZIT1RrOFR1S2dRd2Zp?=
 =?utf-8?B?b2xDSjE3eVpzb3pIMzVFQ211eStLSXkrc1ZZSlN5SmEyamY2T1VuVTI2U3Rr?=
 =?utf-8?B?ZGJ2RElGSHA4aDZVRzBNNjdSVjdrZFdiZ0NyNmI4TnlQYWo0dUF6NUN0Zm1Z?=
 =?utf-8?B?d01ScVNqaDlEUWdBUDlNSGUxdExGRC9wZzJCRlhINnhpTG42a015cDZNR0xY?=
 =?utf-8?B?V3FhVzROam1XdW82akQ1eC9hNmZFbUV0bThGTWp0RWlDTW1zZHBYbzZKeThm?=
 =?utf-8?B?NU9wRER4T091Qndtdk5uWWQza2FsbHZaTk40UTFyZ2M1bEVqSkI5SW1jN2Z4?=
 =?utf-8?B?MEF3NFJzcUFmRlhheEpsZmp5MnlReHd1dlpMbW1Qb2xXOUc5ais2dWtoSC9y?=
 =?utf-8?B?ZEVXL2xDbExCQnc5N01ZTk5kNG9lMW9VY1JJV0hiUzBIYkV1MFZhWTcxcGdD?=
 =?utf-8?B?a09lMk9ZTWJGZkd0djkzcnI5aWsrNm12OTFqUUtxM1NVRXRoZnF6T3Y2Y2xh?=
 =?utf-8?B?am95bFdJZW9keGk0Z0VnRjdUQlVtV0pJSVQyVXpLR29DVUNWTjR5WTBFYTdx?=
 =?utf-8?B?YmJHS3N5Ti9wUnR3YVVzeGlLcWJUNmdFb2NzN0xjdU9pbHdpWkRQdzlFMFVU?=
 =?utf-8?B?aTlxRlpRSEZCdnVRc3ZYc2lzN01RU21tZGs3RklqZlZicG1TZG8yb21XR2FP?=
 =?utf-8?B?MVM4QVFIUnVtWTByckdXZ3hvdzNWN1ZlYzFBNTFsc1Z2TWR4NVlnMEhZT3BC?=
 =?utf-8?B?SUNyQnIwTzhHcXFQMlFROGdJS2xXbHBqLzVYaStsQlVzL3Z2dmUvUVZuWjRB?=
 =?utf-8?B?MWhMaXVxUEVVemFZT293S0FhYXh5VWg3RlJtQVNIeGo1ZnVTUlU3Rm5Nbkxz?=
 =?utf-8?B?VGhUUXFPVEtsanUrZDRmSWVoVmMrQTVkVVc4dnVMUTZXbnc2WjFJdmhpRkJa?=
 =?utf-8?B?RDNaVEhBYm9iaVA4dFdVcXZHK3ovMDllOU4yYVFrV3RPakdJT3d0aXV3Wm4r?=
 =?utf-8?B?d1hhRlc5Y084c2JzZjBvOU5UVGJ4VXo4RStQUzJ5eXQya25hSm9kQm83Wld1?=
 =?utf-8?B?dHZvdGRoamlUa20yVTZibERCV3FnRENVRStlUG55enpaZ1pmdndCci9Td1hv?=
 =?utf-8?B?enZod1VoSEFacjcxUGcya2hyVFVBdUtNY3JZeXdFZkRUeEdDajI0S1hlS1dD?=
 =?utf-8?B?QjBTRW1Oa3BaSlMzZlZVZ0Z6TTJqVy9LLzdpb0hBcFEwQVZZWk5zZEMvdENp?=
 =?utf-8?B?TVZCeDIwZ09KZlZKQnd0dU1tQW51QTdLdWxuWkpnRFZXNXVLN1VNcnc0TUU5?=
 =?utf-8?B?aXpzeVNKdElYbzdvL0NXampqR3JKaVdrbVpFNGZCRDZnN0hJdExienlVeTkw?=
 =?utf-8?B?VFlrbEpIVlducWxKRWJGb04vaEhPcTZFQ3hpb3IzSkNBUWRmbmZFUTg3V2pC?=
 =?utf-8?B?elNnSFJGMjJXQW01aWI0Sk5YanMwNkJnbytzVmY5eTAwWTd6bWlDcUF0RWNB?=
 =?utf-8?B?MkNoUGFLNkNhek12bkdBS3ZXZFdvekR6aTVXaTR6RUpuend1QWdNUVdYN3Nm?=
 =?utf-8?B?amtQMHd4cmc1VjF3RGNyeGN6U1UxVmFyemRzZUJTbW9CQmVkUERmck0rOVI2?=
 =?utf-8?B?OXkzUU5qRjJ1UThkQ1F5OXUvbE5ac0lRdnhocFZ6aHk5RWN5UWlicU01Ulpu?=
 =?utf-8?B?OThHRFFxdHB1TDhRTzNENGhPMDVpN0VpVGRZSVVHZGJoWkd1aCtGNEVEUkY2?=
 =?utf-8?B?MzBycDcrZm94NHptWjh6T1htTSt3TjYrbk1DZTd0Z1VDbUZMbFRiUThFNFJ6?=
 =?utf-8?Q?j62E=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e493966-ea42-40c7-e432-08dc78e75a7a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 16:10:23.1202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgE0KgUPbwNJivB8TpQEIyBcayj0CQNuj+EOFpjkv4g1HpxHK8x18c9e3HZAm6syyCM/Sq1w6qKI5po7Qn55/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10164

Update gpmi nand and dma_apbh interrupt number for imx8dxl.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
index 6d13e4fafb761..1e02b04494e94 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
@@ -108,6 +108,13 @@ usb2_2_lpcg: clock-controller@5b280000 {
 
 };
 
+&dma_apbh {
+	interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &enet0_lpcg {
 	clocks = <&conn_enet0_root_clk>,
 		 <&conn_enet0_root_clk>,
@@ -127,6 +134,10 @@ &fec1 {
 	assigned-clock-rates = <125000000>;
 };
 
+&gpmi {
+	interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &usdhc1 {
 	compatible = "fsl,imx8dxl-usdhc", "fsl,imx8qxp-usdhc";
 	interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.34.1


