Return-Path: <dmaengine+bounces-11918-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /YjAEejdRGpj2QoAu9opvQ
	(envelope-from <dmaengine+bounces-11918-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:29:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 931946EB997
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:29:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=oTvENtYg;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11918-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11918-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76E02303CE10
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 09:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B5C3F0779;
	Wed,  1 Jul 2026 09:26:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011070.outbound.protection.outlook.com [52.101.70.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6969619CC14;
	Wed,  1 Jul 2026 09:26:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897999; cv=fail; b=gx36f7QRHNuEJNnkkssBctr7a1GAaj7sV0x+eA76QjLSECg8RPAGmxnFEHH3qKsJ1vPiDZVBiMTL2E7wnrRMffTzGN8/OEo3kLStszQPUFmU2zYGvIrZKifaezidRXKko9YF1dn1aNfxWszERB9aqh6VQglhT5j02fO0ex6p5Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897999; c=relaxed/simple;
	bh=MTW4QKKiWcrccTMkxRvJGYy/juVjKuFTNle2qpab8c0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=shAixlQSgTe2lygmmnkApbsWCj7WjDqM32YPmAV0BhbtSNrGXFxnxf7OQDrQ1AWfqRv3by0gBPPBBWaSehWHEP/P8X1oF7sJPmrjbZMgc970nRY9635VsOHCZrCbU9PpT0eXpEI3RinqQ1W95Q5voK+yZdgsURNDuh3BU7KLbX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=oTvENtYg; arc=fail smtp.client-ip=52.101.70.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJLBaX5NJQoPHN0iR64hlGIwIftwJWrpb2po51AoeK3H8mJoBa80F/PIas03PDy9oU7wmio9dCCaF453LSFPTPKaeEJD2o1U3nek2v1g6cQ6XKOqdBy2DRUqbppgcUZ2l+CcIpH0baet2BBwrNae3+Ksk9LCTjEfuzIlrg4TWGBQqf153yQB7DfqMRtRnNnvJ0VqLtu1xM7Nit7L3pDOFzHZOdji3RMNgzWMTgx8yFKZf/YlAFB+WFWr7+q1FLOvt4ZxI+XUakjfndeWbMWU/8I4uSObdhkl72oQ8gsBz2d3tOEGx4fbxGkDu2cAvpFouKGiOosykVmB2RiPOyJ7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bM8JAlPOZUbfXo03Ev0Tz6vqn3xwx2/ikeOz6t3abTw=;
 b=XYyb0RhSfu4vH37xKrpEHn5gtouwNj4oN+cf3PvFWMBM0sToZLXpclzK3m3t2M/tuS0TEZLp2A4c+Z9MMqZADd5Ppmg9H5L9UBBmfOsqxdaJFCaw/MmEPSUmAM/z8p/K38e9R0GPzwVcAbzLb2I82v/8J0tIdQxSgbEg/he8LPAilhsx5wvMb0c7NK4GZdEVzR4mbLf7x69SfNG71dyzXMiLqZ+Szs2jfeK1UiImEFrpugb4ppKhlxpv8rDe/GbGBxALUMY1+XnsETqHPisL3fLtju7duiRsaY7A2cMGZg057iL2VVfg4CfXtqWt664+Up4uCXtH0kH9jXhM5+iZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bM8JAlPOZUbfXo03Ev0Tz6vqn3xwx2/ikeOz6t3abTw=;
 b=oTvENtYgYsYQlwoHrP3BoXJix1LZ5nfF/pbdS4HLqW9tZMg8IToeM6tKMy2oqS3R3qDNLUsxHAggToXQt1PizIxoSQawgx8IFOn0KeEyNaWH4SH4T1lSKLSjq/rbPxoevjpNr+mNWOBYArZFvxO1siSIlOFjcTMU9est9/b7jPIF2JfHa5pqCOgFxvBkdRRT7kBj6mu4KI6Of1jqWeTUdp95MKhlF/t24jIybm9iS308e66jf9skWRuVcC/rzHwPmwW/UxB9hCj2Lym+64jdBm8NHxqooIgJd6aDRz3KU//biFhqCWQHL1wywn+K2LNBVT4V1UzVQ7cC/a1XKL5Y1A==
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
 by PAXPR04MB8271.eurprd04.prod.outlook.com (2603:10a6:102:1ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 09:26:35 +0000
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de]) by VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 09:26:35 +0000
From: joy.zou@oss.nxp.com
Date: Wed, 01 Jul 2026 17:29:25 +0800
Subject: [PATCH v6 3/5] dmaengine: fsl-edma: convert DMAMUX clock handling
 to bulk clock API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-edma-runtime-opt-v6-3-354ff4229c00@oss.nxp.com>
References: <20260701-b4-edma-runtime-opt-v6-0-354ff4229c00@oss.nxp.com>
In-Reply-To: <20260701-b4-edma-runtime-opt-v6-0-354ff4229c00@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: Joy Zou <joy.zou@oss.nxp.com>, Frank Li <Frank.Li@kernel.org>, 
 imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To VI1PR04MB5807.eurprd04.prod.outlook.com
 (2603:10a6:803:ec::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_|PAXPR04MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 537460ed-0cb6-4166-0e67-08ded752d82f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	egegolg/cZeylte/ZZ/t3z2YFcqiFRidTYH9kBoBPjNJ+Z5IdBUymyL2KjvGpB92KmZUJ/ak6H/SJUXu+ZnrpjZIUCLAWZbXERYJwuxTVLnCWwIGq7Qh4I7x7NxtTVcZav3rOKjustZDl801NQ9lq/PsvB7oSouK55GwsQrBUjqQ47JTp3+dUqFu6K4U5prbh3k7bcYUp4BfvErpzB6oHzzt6lQBBWPacR3KIOuLtWIEM3gvHBLaEZT/8xXb+GmZ6/GWcFA6Tcv+yqqVNTtYY5HBW/z6RejZnAHQ9BXppvCe63pAEy4Lk780Fh9Rw8iMQZwHwJQaVETM3VHjVUtf16ya5nz79NXEDhYCd6G4Acx5+BM/RoJlPsZcF62T5msIDG/qXD77USD9Gj+H5idN93a2t954bqhvSmrwPkZx22WLH88GFnN4RLZ7Ne1cRg9sP6KVJRlS2ZNit4OQkw9Qo2VIyg10emlIbj5HOWEkrkkxQL+vAmWsB03aT3ZVwy1wHXfBRLhVyUY+HNd+ZsoyrUtZ4AcTcXbem2BTKfpDO7MGP1yOI34Zq+hxIQTKfVUuTAS3vdddlS+8kkso7dHWVm5QARPgd9NED1E5Zd4kxczAFjyIMmgQl7Mgr3jYsUbFYy1ur2NYg6122vgYNsYIieKGmroJjwcbiLpm4XOrE+s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5807.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ulp2bStHMStjU05tcGxKeUNzb0Y3VmI5RkluZnFWUzhwQ085N2ZXdDJ6Rmt6?=
 =?utf-8?B?emIvc214eXlpVEZXZlp6M0pGU3pkK0xzM1pIN2cyd0U2aDgxUnlwSTJHa3d4?=
 =?utf-8?B?elgrSWFsU0F3RXQ3UHJGS28wazAyVUx6ZXUxSU1yRTRSbFdIbUdML1pVZmZJ?=
 =?utf-8?B?UzU5MUtYdGVTNlpvblM1Tk9XdlZFUW0xdmluMnRMU2FOT3k2YndHdUZyUVhS?=
 =?utf-8?B?ckY0QW12ZEc2WDh0QWtZU0Zsa09wR2gvOWhxQ3l2c2N4UjE1cUxzc1dCc1hI?=
 =?utf-8?B?bnlleHNmcU8yRGpkZU9kQnEvdGNVUjZ5RVNxcnRmVzVkc2pVRkRJdUlvTk13?=
 =?utf-8?B?cUQ1VFZzTGJ1ZE9paGZwMGxyMTE2TXBOcEdhc0ZhT0lNMWpIQ1FreHFxRXpv?=
 =?utf-8?B?UDJvUjgwRWQ5MDQ4czBhRmFadFVxb0hqSGxEMmtjVzFsL1YzSkxTRFFGYklS?=
 =?utf-8?B?VitweVBsOU9mSnY0Rm1FcjBCdGdZaGFFeFNtVDE2cldQemtXcWhmaHhWd1Y2?=
 =?utf-8?B?NTNWbUpTNW1iZFJtQ29Pd2dTRkptcWtETkt6c00yR2I4SzhhU0phUlJmMDZ2?=
 =?utf-8?B?NWhkRUZYTFcyWklrU1hpVlREbjY5eGlrRGtsanRXVWplQjlUNmYreUtlRVZu?=
 =?utf-8?B?TU9FNC9PRStCWjBFSFFvVVpjMzNGaHpja2FFQy84R0w1T0xsdEY3ZCtlRVIy?=
 =?utf-8?B?VDBoSmU0Tk8yc3FNUkFlcFFGM0RQM04ybUZ3VzlrSjcrQnBKWXNodlRtVy9i?=
 =?utf-8?B?V3ZvaUZBQkNJR3doQXlEbnN2Sm8xOEhxVkloZFJBZTdzSU04N05qMElEbEJY?=
 =?utf-8?B?ZmtuOXVzQ25FVWdzb1NxL2FNWUJpamZkcHFXejVUSXVqQW5ZWEZZOFRvUjZJ?=
 =?utf-8?B?Uk9JWHdrMThIaitJeXBrdzdaMmpYTTE1eVhhOU15QnBMbXlOdkdvTkdqUXcz?=
 =?utf-8?B?R0ZrVjVZVHVJTzA2YzlLcEFuZ2JrRUhQS1ZEblR2bXhENGhzMllyK3ViN3pJ?=
 =?utf-8?B?ZytKbjkrNTBNMUxvQlpyVXNFdGVSNzZSRXk3NG01YkVDNVZaMzg3anNEVDRE?=
 =?utf-8?B?Q2pDQXhRbVhIbDhKK2swNVp4aGUraEV2aXNCaFdBWlNWbStnOFFSdmNBL1U1?=
 =?utf-8?B?eEEwaXcxUDNsa3NGbUZGaCtsTmlaTm9rNHlicytwVnMvTmUwRzRkTjRSRmY4?=
 =?utf-8?B?MnQxeHRhbTMrK1pIc1l1MHlia3EyUllYc29MekY3OXZDaDcxRDNFQVhobEhj?=
 =?utf-8?B?S242UC9NcHlwMzVpRDdqNVQ5Y3dGUW83VE5UVWRNVzdrMHRPcFduTVJYc0pY?=
 =?utf-8?B?NVU1czFFYmlsS3BIUG0xRm1tWFZISmMxQUVHbllaczRNNE1kYWVtY0pZdjhH?=
 =?utf-8?B?NmdueHZ1UlArcDh4YkZxcXRzRjVlV3lKS21ZMzFWMHZsbmZjOENLUUhRZXRK?=
 =?utf-8?B?aVV0Q3hRMkU0eTVoYXlrV1pKU1Bxb0xkUWcyTkNuMGM3T0xIT0tUTUJTQWpi?=
 =?utf-8?B?QUo1TmsxMzR1dDRyWTBUaWJYVk9nR01aYUFRQTR2VnFGM3Z4cDlmZkt0OTVC?=
 =?utf-8?B?ZklVenNmRTJRemNtRzlnTmdSMDBCQU9nRWd6S2hmQTl0OHU5Vkh0S1JpalV2?=
 =?utf-8?B?b0FGa3JkNEU0MlAvQXJGNEEvcU9XWDhCdWxrZXAvRjhLcWI2a0hVS25YdlVk?=
 =?utf-8?B?NUpoankvWmNya2YxZU1NSG9YcjNncS9UT2Urb2t5VWlGc0U0QnVHMGQrMlVy?=
 =?utf-8?B?Sit2ZDI4VWJacGZsb3Qxb2RnVnViZVR1OWE0VkFkYm1ZVkgyTFJuY05pMkhE?=
 =?utf-8?B?TDlaVFQxTlg5Wlp6T0VmaURjSDJ3b0prVmx0TnVTZHp3TnBLbk9nSURMOGVE?=
 =?utf-8?B?YkxUQ0Yrd0pwQ1lvVkRDQ2lpa0dObk5Yd2M2RzFpVnlSSlEvNGRlZ2hoUi90?=
 =?utf-8?B?QU1uQUxrSW5RMnA4RHdtZS9aR0RsRXNvVFRzeWlVOTlyZUJVNk4veVREYmJI?=
 =?utf-8?B?bUlETUIxMmtpWlRXVnhXUENuVzZISUtrSEYyL3RaWTFIUElwU3hKczNtMFc2?=
 =?utf-8?B?TWp2MEUwNVVvTG9VQ1o2ZTMxOVFTUno2TmduS0hPME83T2NxZ1FkckxrT2Iy?=
 =?utf-8?B?VVUrME9QUzZ4NU51UGlnNkdyU2dMUTNYUXkxWE8vUFlMRjJNdEUydEx0NmFz?=
 =?utf-8?B?ZlZIOWFkaFVUMlg3QkVmNlo5dFJocFVLTTJUUlptZkZ3Qmg5QU90VkhrOWM2?=
 =?utf-8?B?YkxNa2xQT0MvWWt3cHNtNEFvN0JSeDdhYWY2SFoveUIwWFovaE9obTBnQ2NX?=
 =?utf-8?B?MWc1NDJpb2MyTkJUN3RYS0I5bnRwRkUzV1FIZ293MmJsK3hrbHhVSE9PN0lj?=
 =?utf-8?Q?RTeuta9t4RazF4Mg0SW67M89dPcMSXMDM3RZE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537460ed-0cb6-4166-0e67-08ded752d82f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5807.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:26:34.9312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olgpjnCgZ4DSyMmHHEoD5SwAk597QcBhFMELOmSITWvimpENaW2sjTyACf3p3SA3tzsrpINxbQNvuNtrSKUIzV6cukdO0tfkKBwt/WHoEzHDEV9Bgx3h6uGcqnEx0Uir
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8271
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11918-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:joe@pf.is.s.u-tokyo.ac.jp,m:joy.zou@oss.nxp.com,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:joy.zou@nxp.com,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[joy.zou@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[joy.zou@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,vger.kernel.org:from_smtp,oss.nxp.com:mid,oss.nxp.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 931946EB997

From: Joy Zou <joy.zou@nxp.com>

Convert the DMAMUX clock management from individual clock operations
to the bulk clock API to simplify the code.

Prepare to add edma engine runtime pm support.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v6:
- Replace devm_clk_bulk_get_optional_enable() with devm_clk_get_optional()
   and clk_bulk_prepare_enable() in order to use runtime PM for power
   management later.
- add Reviewed-by tag.
- Link to v5: https://lore.kernel.org/imx/20260513-b4-b4-edma-runtime-opt-v5-0-1e595bfb8423@nxp.com/
---
 drivers/dma/fsl-edma-common.h |  2 +-
 drivers/dma/fsl-edma-main.c   | 51 +++++++++++++++++++++++++++----------------
 2 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 54128b3f45cb..824b7dd2b526 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -253,7 +253,7 @@ struct fsl_edma_engine {
 	struct dma_device	dma_dev;
 	void __iomem		*membase;
 	void __iomem		*muxbase[DMAMUX_NR];
-	struct clk		*muxclk[DMAMUX_NR];
+	struct clk_bulk_data    *muxclk;
 	struct clk		*dmaclk;
 	struct mutex		fsl_edma_mutex;
 	const struct fsl_edma_drvdata *drvdata;
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 88fc1b06e518..fe02b68d75fd 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -526,12 +526,11 @@ static void fsl_edma_irq_exit(
 	}
 }
 
-static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma, int nr_clocks)
+static void fsl_edma_disable_muxclk(void *data)
 {
-	int i;
+	struct fsl_edma_engine *fsl_edma = data;
 
-	for (i = 0; i < nr_clocks; i++)
-		clk_disable_unprepare(fsl_edma->muxclk[i]);
+	clk_bulk_disable_unprepare(fsl_edma->drvdata->dmamuxs, fsl_edma->muxclk);
 }
 
 static struct fsl_edma_drvdata vf610_data = {
@@ -751,23 +750,37 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_edma->chan_masked |= chan_mask[0];
 	}
 
-	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
-		char clkname[32];
-
-		fsl_edma->muxbase[i] = devm_platform_ioremap_resource(pdev,
-								      1 + i);
-		if (IS_ERR(fsl_edma->muxbase[i])) {
-			/* on error: disable all previously enabled clks */
-			fsl_disable_clocks(fsl_edma, i);
-			return PTR_ERR(fsl_edma->muxbase[i]);
+	if (fsl_edma->drvdata->dmamuxs) {
+		fsl_edma->muxclk = devm_kcalloc(&pdev->dev, fsl_edma->drvdata->dmamuxs,
+						sizeof(*fsl_edma->muxclk), GFP_KERNEL);
+		if (!fsl_edma->muxclk)
+			return -ENOMEM;
+
+		for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
+			fsl_edma->muxbase[i] = devm_platform_ioremap_resource(pdev, 1 + i);
+			if (IS_ERR(fsl_edma->muxbase[i]))
+				return PTR_ERR(fsl_edma->muxbase[i]);
+
+			fsl_edma->muxclk[i].id = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+								"dmamux%d", i);
+			if (!fsl_edma->muxclk[i].id)
+				return -ENOMEM;
 		}
 
-		sprintf(clkname, "dmamux%d", i);
-		fsl_edma->muxclk[i] = devm_clk_get_enabled(&pdev->dev, clkname);
-		if (IS_ERR(fsl_edma->muxclk[i]))
-			return dev_err_probe(&pdev->dev,
-					     PTR_ERR(fsl_edma->muxclk[i]),
-					     "Missing DMAMUX block clock.\n");
+		ret = devm_clk_bulk_get_optional(&pdev->dev, fsl_edma->drvdata->dmamuxs,
+						 fsl_edma->muxclk);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "Failed to get DMAMUX block clock.\n");
+
+		ret = clk_bulk_prepare_enable(fsl_edma->drvdata->dmamuxs, fsl_edma->muxclk);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "Failed to enable DMAMUX block clock.\n");
+
+		ret = devm_add_action_or_reset(&pdev->dev, fsl_edma_disable_muxclk, fsl_edma);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret, "Failed to add cleanup action.\n");
 	}
 
 	fsl_edma->big_endian = of_property_read_bool(np, "big-endian");

-- 
2.34.1


