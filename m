Return-Path: <dmaengine+bounces-12242-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N7xTACDDT2r2nwIAu9opvQ
	(envelope-from <dmaengine+bounces-12242-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:49:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDBB733183
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:49:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="hO3n/qp/";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12242-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12242-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A13930B35D8
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 15:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE71423760;
	Thu,  9 Jul 2026 15:34:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE05842316D;
	Thu,  9 Jul 2026 15:34:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611244; cv=fail; b=eE/ZdD9WvVfT360G2x6DWSKET0r7t3a/MmQxowgJPE8bmcEIYEqO1ePyAUth0LUwNnD3dimFQIujMAnKMIycOhsol8lTlRGzc+dSrm/qAAmwgIERkaMvbUdrD3vtPMEZVSVFbhnUxYiRqTWYKP4EjunRYzOh/SJayZUtEoabnFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611244; c=relaxed/simple;
	bh=5ADtYYT9nHGg9r75fUUmD7kP+ZyXYecz9fkvhiP75w0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FQpcgX7ZA6iC4Ts04no+ibae5rF6QX29HoMqmjpG446peu0zdXaT6KD9umnrVkp/nb0EoRUt20ET9ta39O6UG43kfKClXOBWiYAjQuL1arIRnq0YeHnlqh1zne8hEHMocNZLv0Hr7QFENTsXj2RhDBwKWhw5GYLIFUWrHych4l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hO3n/qp/; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBjdU+A2Sd3QUHUPk0Y3a0DAlyBrW6U4WvtyrU8FncWX74/JBqrkr35EP2lMhx3z2Ah8eVLBN8tLau+LEmpjitIS4MUA1sjo236zFn8j8j6HYedZ71Mab1NJSjDD3dRIXs05xOYykbEf/IqlKIn425W6BcFB8Sz5HK1B/Ks9SL/zVo2UvAiaSZtaS8/JldGZHS+GkXDa6Nl7oA+K1GkaPMiRnz/jRsF+xlGge9A947tIFulIq+xecucVkSCykdbNEcgLgXy3Ts5D448cshE5B7Jitmd/TNToTQwoCqcQKz0ouMC/YhH9jXHGyspN7rKhlYh9jNgo2eADVHBrEKK+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfKHLiRpgb8s2RveiTCExK/O4zj6D4vRxlr8Y7CudGA=;
 b=j8+ctSEqdcciCsFCqBDnjGkgEJxzUJ410kPB9QRz/sSOaXlqjpKATh3vphMmQQx+WNUOgS8BQUXCN6jnaGgQuVRcummpUWofh0dS4eO7MIFHnNv+wrwEikgcz9hedLl9jKLSjKbQRSbg1LriEEt184xO21ATr1rdH4HlJbWggYyXQB8GBvh9tnL0DWJu7pX0xNIn5kfv6AWLv5CrpTOdvpIz8Lw1LNnhAIJGoxHnjYHdOV7mOcB3xlDyHUh2TDEjEiCTNkFtft7F5a+oWwdBaHtJDXm5XqEla2Jeaxuzw1Bf83I05uVClB0Is/hD7TMDN6fDD2m2nGZgMW+te3SW+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfKHLiRpgb8s2RveiTCExK/O4zj6D4vRxlr8Y7CudGA=;
 b=hO3n/qp/5ZXTHAG58XDUopaufbASnb3o2N57qM7Uk1Dd3brHVZFEC22ZAQyUJUSIMKEXTz5BgqFQ7tPp4mwi0gU1+OYETPjOF1rgKwhg3p7TMMd0pD8YeNf73zOfZzivhQOpCYg7cCJyl/NEinehJtFeS7Cf8QNWB0hNxtCzI9QzPpP94JEX3Lmk5MbxbtlTG/GjyayKfnw2SKYJCNKxKPW4Eu1xgoPqdqFKGRA5DTMj9HxG2LbqT6OG1/wMEhkmo/d9zUizJsUmUtWi54YO2uNOz+XJZ4Bqsr5Y0tm4dLMi3KD4UBc6JkflP6oAVfIHmnZgyafqVtyisWkHQXk5Kg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 15:33:57 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 15:33:57 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 09 Jul 2026 11:33:33 -0400
Subject: [PATCH v5 04/10] dmaengine: dw-edma: Pass down dw_edma_chan to
 reduce one level of indirection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-edma_ll-v5-4-e199053d4300@nxp.com>
References: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
In-Reply-To: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>, 
 imx@lists.linux.dev, "Verma, Devendra" <devverma@amd.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783611213; l=6919;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ErdapcPMmXhUaz/yq+JBAR/2OB2luFQ/CFcEy+/xZuA=;
 b=6c6HVjLa2JKjQAHF2eFwFVRJt6kyoOMiJbjMi++sDh2jmnx2JndpcZ4WVEcOShDLbTYFi/duq
 LUmNNrwmvOmBTgVq5Dm7lPOE/duNjo63N7ya2AdId+TFtWK894m2I2K
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: f8dedce7-ac0a-438c-76bb-08deddcf7dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|7416014|376014|56012099006|11063799006|18002099003|22082099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	6hr0CCOLL5n4SGoVbArOhr9RcXEYZj0M3l6VZwDpFiS+V8bZBJeeLLDx/Em4zd7s3U3KUodt50aGSgJ5eNEjo7T090X7bL7obU6188pKbnF3exAEG9LD6aMNOHJtcUC0QiQJKpZu1H1ixEEMY+1ed1aVerxhSk4HFwUuf7dEXxjQV4Izueg/xv1Gpgjf7/pLbbpUsFJjgSTiEM8tPArw5HXAg6924p8OCK5vStV1Sd0MYXR/j3aOOO/sBPf0AEYT6ZDH5jnonTuDfX2vbJhgFnxW0zrbetaTSmgEd/5tgMfhZHnGmEw/ZHNToxXZ5nxHKJvTavc92JRA9EaiLhL+G3w58QrF+1tFMI5+tB4A5u7Ea/grrj5Qd8dJSbvj1JqLosGs2mw19SqvIaEaXWqxrAmUibs8Q1g+Qq582gHvMKWju8H/dfC6ZeApJ9qyT+gsArQp3BDmmfooQHa3JSu1W18yITRYK+Wt09pLZ5kx6ajKiqfWmbEG/UORcs0m2V8quhYsVqaCG+hMkWRc66syCoRQd5aT8v3cS0CNKzG98TI3AsUH6dN3lzDtnGplI+7ptg0lNRMBWtDTHLyIQWLkaHeOGVBVdEL7l9XVIysR8WskpnauV1aeJVX3aso3NZ9T5SyX7XCTZn3dxiZW8J3+RQ0KmDnrUt9IXuW8QOSFwfXCEK1RJJtnLEnkcZEbKX0UbFSXnSf4PTvJyQO+O7qOHQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(7416014)(376014)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U09NMjRmQlNUdi9rSitPMEhOSUVvNzZ6SGtBcm5SZWh2UFYxc1FWWmNWbE00?=
 =?utf-8?B?MEtlRVNNamhJZE1qdmJpRy9aWWJiRk9kdmo0TmhqRDRUeUJpcE1tUFRWMnp2?=
 =?utf-8?B?R2k2dWtoMUlGdi9HbHRjellxWklMZjBFeXUvNWRsRSt5WExHdE5kcC82Tk5O?=
 =?utf-8?B?K0crQzJmajhhWWFHTTRWRmw5Zm93UFlPV2U3V0c2emRVYk9BeHgwa3ZFcVZt?=
 =?utf-8?B?cHhoTnlPa3RPSy9IZXZjbHlXUVBIUU9ITS9OSzRtQU83MjBNRDB1Z3RxV0l0?=
 =?utf-8?B?WjFjbng5N1Z2R1BaTTNQSWZMbEFMcUt1d09aRHUxbFpMYVdkdk1iV0hPWkdr?=
 =?utf-8?B?UXRrc2k2NExyYVBiK05UekdWWUl0dGVTZGhNTkFzY3R2djlNVGxJVHpkTUhO?=
 =?utf-8?B?M0k0b2lDbk1Gek41QjdNUTQwK2pUQ1NGOWdKODRIR2JodC9HNGVVV216WG95?=
 =?utf-8?B?bXp2dWdjeEpLcTdWK3ZvV0RWODgwaCt4d1RWcXA0OGlIYzlScFlpWFpTVmlV?=
 =?utf-8?B?RGtsNEFVQUptczNnZVp5RWtXWlZNeVduSmdpZWFCV2lUancwUDJuYWdMTjZO?=
 =?utf-8?B?bENyejZ5NlEvYTAvVS9lazIwZVNLK0dHZXVnbGhKTWQ4OTZ1MFlrYUpseUZV?=
 =?utf-8?B?U0lUTlhodzBSNWk5Q0o0VFl1SkFCU3VZcW1JMitQci81bkRIc2dIN3BLaG5o?=
 =?utf-8?B?a2Z5VHR5S2IzaHk0L1d4NjQ5czlIUFRUUXRvZE5aK1g0RDdtamV3bFY2R25T?=
 =?utf-8?B?cUZ0RTVGMGdMRmZaMXk0U3JVdWdnbEIzYnRBM3AweXRoUnlaWTZoSlJaU25Y?=
 =?utf-8?B?dzhDV0NzSmtZNWVYZlVyVjFWY3JwM2xmNjBGS2VqOEhyV2dmTjdYYmhJNDBE?=
 =?utf-8?B?QThOU25hb3BKQk44NEcwTDZsdXo2bkJPU0o2Z1duY0NPWHVRazNrVkt3dllB?=
 =?utf-8?B?L2lpemhTa3g3b1o0VTdTMmZFOUdneklUNEp6QUVZb0JvVmlzZG9Yekc4K3Bv?=
 =?utf-8?B?dldQR3hDNjVsQm5qTGFBOXhZdUNlVzNhdTlWYllhdzdkZm5SNHhVUms0aGhF?=
 =?utf-8?B?MmJqQjQ1RmZLK1N3NjNxcGVNemdmckZoUDNpcCsycTk0aFZIait3MVdZZ1lR?=
 =?utf-8?B?WkE0ZmJtcEpoWTAyOVFpTWJmOUVUaWowZ2ltSElSL0VkQ24wR1N4RE00VVFF?=
 =?utf-8?B?Wkp2R2tGU09HZEVwakdDekVTSkE3V2pKVkhiTmx2akNFRUFZc0Z4WnhDQ0tG?=
 =?utf-8?B?aHpVMEVWNk5RdVM0NHJtT09jdVEzNFhKaGNLWHdrMm5HTk1QLytVa1NIYW5p?=
 =?utf-8?B?aTZCTkt1WjcweEZGQ2ExUGpIdnQ4Qm9YczVVMFRxRzNmRTRtL0wxaWFJWFd0?=
 =?utf-8?B?SHZtbFF6ZVB3QjFpUXRNdHZWWk90aVBTa3VsOFdCT05Cb3VMajcrNTlsVDVS?=
 =?utf-8?B?MEZZU003dWFaSWV6NWJYNDN3MkhIY2tKUDFHOHJncW5lOHhGN1JSUjg4ZFBh?=
 =?utf-8?B?SU40eis1czBUaGRiWE4vMWpRVGU1Z3RzZXdCRzFpYWdWWmcxZXU2Z1Fsd0NC?=
 =?utf-8?B?ZHFlTzAyM2luRnB4MktpanhBeXNMYkdIYkJUdlFDTXlFcytiNlpxT0wxSStq?=
 =?utf-8?B?dXNwckcvUFQyODFpVWVNSlozWm1Mb3ZlSlFTcUd0UWhGc2pMUGZ6c1FoeG1V?=
 =?utf-8?B?UWxoeUVmMHlFNWJVWDlyRHkrdTYvYUxCaFJVZWpCSmdCUFpXNXhMT3pzVVVE?=
 =?utf-8?B?QWxjWjQrZDJMK0lkemxXMmlPQlV0aWFFTnQvUkM1QjZITXN6c0I1bFVVUzg1?=
 =?utf-8?B?Tlgzb1UvUG1pVUUvUGFvZnJwZzBYSGdWNEpkMmM1NkJ4d2E2bXFBQ0lKQ3dl?=
 =?utf-8?B?NWJzT2g2bDlaVlR6UkE2cFhVS3VvTmM3MmVlYmVpclN5emZGc0JZcGxFcXNq?=
 =?utf-8?B?aVgxZWlnb1hCMHFRaVF6UzdDcXltTEJvM1NNY2RjcHlhZlE4djArdWRId3l6?=
 =?utf-8?B?NTZzM090Q1cwVXgrV0dkNW1DL2JhMTNtc3dyL2hVMkh6Z0p5T0tOMUREaXFQ?=
 =?utf-8?B?cTB1U1VaMEJ1RlZVSUpvc1Myd1UxQ2NaS2pEK1RPYlkvaWVSQTFZOHEwTHhV?=
 =?utf-8?B?VUZ4SUI3NUNPTEpzckxBYW1sTnNFbXdxUkhYL1FjVC90aGhBZElCRjZZMlhv?=
 =?utf-8?B?L0Q5TWE1cVJ5TS93Y283NmhPUzdBaHczeUFhSWhBdGd4TTdac1NZMGovUURp?=
 =?utf-8?B?VkgzUlNoaUc4UVJFeUo2TVljc2lUWURXbDVNTjQ1VEtMRVFUODg3cWQ5dHJ2?=
 =?utf-8?B?Mjg1SnNkaWdYSzRlSDJBSFM1R1hGZHNmL0NDaUVxSkgycFNnVys0Mk5ZQit2?=
 =?utf-8?Q?ypZv7j6IWIhMIe3dTWgMl2xuSN0bYd3LcYANK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8dedce7-ac0a-438c-76bb-08deddcf7dfc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:33:57.6923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPLNRYDOgCQNC6eCzA6kucQ4T6iVwAsZxPBMO+XJYKyMW4h4IR17d1MQ+ShwMIYk09DGmGQk5iwvr/UOjeNOF3W0yfyk34RRomT8wscnY+1CWR3vtHE75tiqOjVFN/oE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9466
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12242-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,vger.kernel.org:from_smtp,nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim,valinux.co.jp:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFDBB733183

From: Frank Li <Frank.Li@nxp.com>

Some helper functions do not use any information from dw_edma_chunk, so
passing a dw_edma_chan pointer directly avoids an unnecessary level of
pointer dereferencing and simplifies data access.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
changes in v4
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 22 ++++++++++------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 23 +++++++++++------------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 51e50f1fdcac4..c341aa5343417 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -276,13 +276,12 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	return ret;
 }
 
-static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
+static void dw_edma_v0_write_ll_data(struct dw_edma_chan *chan, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
@@ -300,13 +299,12 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	}
 }
 
-static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
+static void dw_edma_v0_write_ll_link(struct dw_edma_chan *chan,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
@@ -339,7 +337,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 				control |= DW_EDMA_V0_RIE;
 		}
 
-		dw_edma_v0_write_ll_data(chunk, i++, control, child->sz,
+		dw_edma_v0_write_ll_data(chan, i++, control, child->sz,
 					 child->sar, child->dar);
 	}
 
@@ -347,10 +345,10 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_EDMA_V0_CB;
 
-	dw_edma_v0_write_ll_link(chunk, i, control, chan->ll_region.paddr);
+	dw_edma_v0_write_ll_link(chan, i, control, chan->ll_region.paddr);
 }
 
-static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
 	 * In case of remote eDMA engine setup, the DW PCIe RP/EP internal
@@ -360,8 +358,8 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * LL memory in a hope that the MRd TLP will return only after the
 	 * last MWr TLP is completed
 	 */
-	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->chan->ll_region.vaddr.io);
+	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		readl(chan->ll_region.vaddr.io);
 }
 
 static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -437,7 +435,7 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			  upper_32_bits(chan->ll_region.paddr));
 	}
 
-	dw_edma_v0_sync_ll_data(chunk);
+	dw_edma_v0_sync_ll_data(chan);
 
 	/* Doorbell */
 	SET_RW_32(dw, chan->dir, doorbell,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 20089d57f8ab0..156b1cc225091 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -152,13 +152,12 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	return ret;
 }
 
-static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
+static void dw_hdma_v0_write_ll_data(struct dw_edma_chan *chan, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
@@ -176,13 +175,12 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	}
 }
 
-static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
+static void dw_hdma_v0_write_ll_link(struct dw_edma_chan *chan,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
@@ -198,6 +196,7 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 
 static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
+	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma_burst *child;
 	u32 control = 0, i = 0;
 
@@ -205,17 +204,17 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		control = DW_HDMA_V0_CB;
 
 	list_for_each_entry(child, &chunk->burst->list, list)
-		dw_hdma_v0_write_ll_data(chunk, i++, control, child->sz,
+		dw_hdma_v0_write_ll_data(chan, i++, control, child->sz,
 					 child->sar, child->dar);
 
 	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
 	if (!chunk->cb)
 		control |= DW_HDMA_V0_CB;
 
-	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->chan->ll_region.paddr);
+	dw_hdma_v0_write_ll_link(chan, i, control, chunk->chan->ll_region.paddr);
 }
 
-static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
 	 * In case of remote HDMA engine setup, the DW PCIe RP/EP internal
@@ -225,8 +224,8 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * LL memory in a hope that the MRd TLP will return only after the
 	 * last MWr TLP is completed
 	 */
-	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->chan->ll_region.vaddr.io);
+	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		readl(chan->ll_region.vaddr.io);
 }
 
 static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
@@ -261,7 +260,7 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 	}
 
-	dw_hdma_v0_sync_ll_data(chunk);
+	dw_hdma_v0_sync_ll_data(chan);
 
 	/* Doorbell */
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);

-- 
2.43.0


