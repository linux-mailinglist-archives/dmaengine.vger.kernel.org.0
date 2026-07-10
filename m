Return-Path: <dmaengine+bounces-12329-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FmQqCcAnUWqhAAMAu9opvQ
	(envelope-from <dmaengine+bounces-12329-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:11:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D8573CF1D
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:11:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=fStM1X8j;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12329-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12329-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F333A3143FF1
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 16:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3038478E57;
	Fri, 10 Jul 2026 16:48:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011070.outbound.protection.outlook.com [52.101.70.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6534D478E3D;
	Fri, 10 Jul 2026 16:48:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702118; cv=fail; b=o431FrSr9S837zosSIVFiG3OiwV6OEbnnVpYMa90Fx++D3lZd5RyAVvwB8qeG9d8IuL76ats6ClZEN/OruL8gPOm3XgcT/T+EBvaPc17BErOCanq1q+m39lXnM9kx51PhoA92wNnrPCQl/i1LnN+ntQdVv6DbvGVfKXjyWPnUG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702118; c=relaxed/simple;
	bh=yvPwnDZmrlh0fwppVe0OLvF3BVWLpT2Y1jXpItnJlZ4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YeX0CbjY3HxOnfPxR5Y0DxuFqsWLYl+VRuurzmMFvG1nVntq02flMyXpg4zIOCHIhUSVP5ec66u2AldMsWsRbwVEx/Ira6gd3GVkTe7CfDcUrNMyh1ylqv2LA/6GmpD9qE1SBPAoO2DSX4S+Vcag6p5xr1Ox8f1oNMs54fNp3Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fStM1X8j; arc=fail smtp.client-ip=52.101.70.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvKoLXpoVqGkYoB+jpyUqIEqMxuxHwcyj+oVAhOoxBQ6gbvbQo9yI7ObKex1cAboeeTACxORorCIP0Yyos34nR+vGcrpJTnXjA44Jll1Cl2zEd7Izs+EiyHXk9/bHVDAo6QrbmX4UejsSBeFJif1Jw3vjbPs3vVuJ4kIo0xMrbyGyxP6Q5Uh0ALUCqtNDwO7O7f4/Fc1+yLhjilU2Vg+AJStw8ZbqGyUR9/df2eVFX8Sr2QfxOj+ZViH92WvcIfR6eXQ/Zt+BCwG6hxvHGZY1xet4WhdcgUfzac/m+5V+OD38sdHmyyj8Uzn/FX4PjVbJ0AZAzNvqrxWsrey4CJ6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrBZl9W0kqdsiipmliASH33yIMN/jVDBHqiyK7fUMJA=;
 b=rxkJ6AK+78w+8kTpcrjKnmccww4N8/Mtok9CraBGGhhvwg4EoSZxc1ZKqb8tbNvFPkW3D3vQwIRztry2J6W9Mi+DzsBEh381BuLp39hWOFIWKUGwMRiGTNNsRuuHZfvg1fUpkAcZVq7wvMugrd86hk/aN2pd6IdCy48FPJrbgTPMuIgKzzCclhjtv36H1QQf5jnOD6GEAFdtizmbg+YywzDAPiNBr5ccpEEte0ZuUMOUSVIBVrk/AjzHV16Z7W/yIO5unQY8jmttOENJAsYBsKJXut3IsB/qVef2hOYZB2Fhs+Z8VJpfmhUWLoKSC2yy6bC5pDzYnj7cOmUZJf/dVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrBZl9W0kqdsiipmliASH33yIMN/jVDBHqiyK7fUMJA=;
 b=fStM1X8jbk3Wv8c4xM33n4LDbn9ZmSNhLhHtPU1M21BX+uz64mvjgdXTyx9TbLZ9kMPC2Q73bEqF0+ILJ6102IfQq4RwCblO8QAP1dJ5M+lDicRGc2PSnpWezwnlhWVk1ZiepDfwHdiYyNCq4dmO5qRsNoFxUXxzpMD6ww0OxV9rnbqGbPZEqyY8sDFtAqaXUTilMGpsx7TFz0pCImnWRvw64CKqqtrTPZpf2GhDkweS9Tu3yRoVtnbnbp4Lu89Ks59j251cr+9nZ1yK+fQuC0d5b++dYzMLh8EIkRmGJcLmN3xlN4XFkVAZlAWu9nhMgQyp25OM0wYZDj5bkxFKvQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9345.eurprd04.prod.outlook.com (2603:10a6:10:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 16:48:29 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 16:48:29 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 10 Jul 2026 12:47:49 -0400
Subject: [PATCH v6 07/10] dmaengine: dw-edma: Add non_ll_start() callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-edma_ll-v6-7-1471d278b73a@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
In-Reply-To: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783702067; l=3682;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=LO3iSgVjP18J5ombaOKncW8om/QRIKrEzKhmIbVez/8=;
 b=QEsTmp8c+hWqv3y4gliAzL48d920oks0Oaz4Vk3XCkgEoFYhs6SXnwk+s6gFCwwniGQDeJVbs
 lpnAJO81SKxB79fYN04JQ80xxlYe3iIW12HKfYf8FfBVrt6vpx+js3d
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0054.namprd07.prod.outlook.com
 (2603:10b6:510:e::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f3c573-a3cd-4a44-90a5-08dedea311b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|23010399003|1800799024|921020|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	o+bgTvKdnXQm+/YqRsw83leUucz00wiw3U7Fi9PSGy6hlG2AUKjWA99YpDqN/pVJTK/mQFYXs7lUry3mcv/2PpNIXnCT7ojo71OUV4WfTH2rBXbYKWqJH0AEKmTMZutK7Sev/+9BOynTk0w3RgoLcB96JXOrY0/S1s9kAErHIH5Iby+Mfv2hEexDd6svk0w+LkvP10rfaRC8G3xQiAaQnfRUhydOLEpHpy5JwKZ2TnvmYAhiFDYiYjQBbSz5CIlvKIdusH54AKU+Y9c2JiIIFN3dRoMhFKAvmeQ7s4dLAAiaeslJH9EqZNik2kvsYpi2JS+V2vlG3boMw8eHr4dnBbiJrVtTKuXJF6oVxmmKWSD/Oeu8f7gtoUDb3ohEUjmFb6/9jdRL4eMlkc7oWAynRbPIMrgpZu6mkXYvnm8HUqvX8UzdGV+p7LiChIVRTRmyYMtyqnbIdIQoaC8RF7/g/m4Qq9S7mfYuY4duF2ROCEAtAkWiHNEWl8FXhdsl3srR3xUg+7uQ41dtk+ywxnCu7Zca7P8A7+Z2bzw5jp2oKpdRbBjy9gm/sBpw+GOTq5Qx8EhV3/sFTyVnLxtXwZsKvKQowDmigLP3L/cefKfG3x8XBuFn8fnshLZ4qKM0TP80Gx72fFtfYpXxhZgwdjdOidWR9gQSWQXZ3CtsgXSrYu5h6/kmkdrGr7J+TuAiY8jGGLKoQOiaOziXXH7X51U8Fg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(23010399003)(1800799024)(921020)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmFWVXJTVkh3MU1LcVNXMmZnRGt0R1czQkpCQ3NnazErWHdEUjZjbjB3Q2Nv?=
 =?utf-8?B?VUhDcU81YUs4UHdmaU1ZUFNhVHUvbHlybFJwTGVmQ2d0WFVrQVdjSjUxU0VU?=
 =?utf-8?B?bC9nNjFyREIrVEY4OTV1NGJ1dGhtWDBlODJEVlFVRm1jVUZmdUswQlV5SzRT?=
 =?utf-8?B?dkVMZ1lFQVhJM2lMbDN6SlFTbm9ld0c3d0tORllpbHRDWlJSb1RiUU94QzhH?=
 =?utf-8?B?TnZEWUhHNmQ2KzYzYWtZMlJCRTBIWXI0blZiak9HUkFKRFZmellxcG85QVZ0?=
 =?utf-8?B?NGZMdkZMWmc2UGQrQlNXd1NCbW1vKzRGemZBN2NIenNmdDZTT3RWVm9oVGVK?=
 =?utf-8?B?WEI1T2JaalExbW8veUdKYjZGU2gyaTk3aE9xcUJaeVo3L2JRNU94QW1OVDZQ?=
 =?utf-8?B?UUhUMlQ5c095R2c5TklqajdzVE1uMmU2dWtHdkU1MktoRHFhR3JaU1BBSVAr?=
 =?utf-8?B?N1NvMW5WY0hQdSt2ZjNMWEZCRzlqQlNNeW5CV2tGSy9qV1ZURjdMbVpOZmw0?=
 =?utf-8?B?ZUlQREVkMFA3UEhRQkx1MU81a1BBb2dZbUV2dnlZUzVzZlJrM3UzRHRPOFU0?=
 =?utf-8?B?b2IzV0hoS2RVRWl0cVhmU1JtbUh4ZTZzSzJ3MHQ3SS9WRDJuM1gxbStTK2lT?=
 =?utf-8?B?ZUJxc3VWenAzdU9OWWdEb3hDNWZKN1BmZmxqUEM3V2psRWJQUXlxWElDS3Q3?=
 =?utf-8?B?T2tLRjhUTlhiTEd4OWwyRlBHeU5TcXp6ekYrSm1SZWYwS3EzK28vaEE0eXZy?=
 =?utf-8?B?MDltV211bFFzWlI4Nm9iT05tU2tuS2FtYTZ2Zlp3azRxTG9kU3ZDUFdLdWM3?=
 =?utf-8?B?S0VncG9jNWVMMUEya0NFcGpwSVcyNU1iV2M4WHphLzBnalpXR1FROXgvY0dw?=
 =?utf-8?B?YlVYWU1uNlBib3QrQjRNWG5ESTNka1hwRnpCenpPYm5vcDlBc2dBNVJDZUY1?=
 =?utf-8?B?MDlLYjM3Wk53QXlhbUhveVNQNU1jM1lmTHFMZE5aRlFHdmdHKzJJeUh2K3di?=
 =?utf-8?B?QUxWRGhlS1Y4YXVXbjA3OURHQ0h3SGFvdXFWMVpUc3h5anFhd3kvR3YyS3pa?=
 =?utf-8?B?R1BPNndIcWs5UmtYUVNzbmdqY1pKdjFQeFE4My8wT1BwVTl0SXBUMzExNUts?=
 =?utf-8?B?dTNqVlpsbE1vZjIrSEVvdStJcEFHMG8zb3NjK0lwa2dZVmtUYm9oOTNiNUJW?=
 =?utf-8?B?akhtc3J2aDhBanFBZmhvRERNSWJURFd6SkxOZjNBeERzbHBtRVBCZ1VTR1Nj?=
 =?utf-8?B?bzhMejNrcmZySWt6NXA0VTU0S0VlZjI4QU9OVHVCaUdaZmlBb2gxeHlaQ2sy?=
 =?utf-8?B?eTA1SDJJMmhFakNVWVlMbDNFVTdna04rSGVFb0Yzd3d3VTUvNUUySWFobGNr?=
 =?utf-8?B?MS9OaWlSVXMyMGxVaUJkdk5ZNGZmRnh1M0pxL3k3MXBhdXd2bEoraFVYQkpk?=
 =?utf-8?B?MWE2eWlUaFp6ZnJuZDc3clpTZjErd2tzOW9Zd2NRaSsvU0FaUE41aHdBdnVp?=
 =?utf-8?B?aUZ6QWlWNWFDdVBFek8zOEF6bjI0bk9pYStTMVhxWThQT28xQ2pkS1hwRVBi?=
 =?utf-8?B?TVVwNFdIRERIMEZMMjloYkhqdUZvaGhxb0RMMkp2ZGJtbUVLWTVTNkYwcUF2?=
 =?utf-8?B?WXhVVXBncFUxazNHRzljaE9BWG0reTh6MVA5Yjd0VmNxMjErVUxNR3A3MlV5?=
 =?utf-8?B?bXM4cWoyNVpKMGE3bjBXdHMwUnRyUFpoUzNRYmJJWnprYjI1M3FiUCtSZG9F?=
 =?utf-8?B?UHUzdkNsek9NVWJ2NlN5YmdVWkgwUEpQSTdhK1dlOC9lYWlnZldCVGwwL0x2?=
 =?utf-8?B?OTRHeHk4UjJZbVNxWnlSVTFqdEYvNGV2eXVCenY4akZuT2pGWUs1QmFySkdP?=
 =?utf-8?B?eE5Cd3V6OEpqeWhZeDM4ZWxmTGZOSnU4YTgwa3ozMVBYQmFGbk9hV1pLQ2F1?=
 =?utf-8?B?L2VsOWJJVWRoR21sM0F4enprejMreTlXMmN0Z3lzdmMwR0R6dlB1S1dGbis4?=
 =?utf-8?B?cG5lL3hzSW9nODdDN09kaFNLSlh3S2xkUXBlTDF6WnhEY2JrdC9MOHNrK2Np?=
 =?utf-8?B?dzROTmZwdG5WWUFGUWlHdEZQTEtoL2JzS3piTlpURk5HR1N0cEt1bjAxdnVB?=
 =?utf-8?B?eVJrQUVoblltTmJ4R0MxdzJJYzAxcktQdE1PcHlMVTZqQUR3QnJYQTBzazVm?=
 =?utf-8?B?RXcrU2MwYnJEYmE3S2M3MXVnaW9jV0I5ZDgyK3hNTkNFTGhBMHhSRVA4OXhm?=
 =?utf-8?B?SlhhTFFIcDY4aUVkVW1mZXB0b3BFNlhqbU1tV21VV2JnNTNhM1J2Wml3NkJ6?=
 =?utf-8?B?eG9BTGlaeGlWY0JTVExMYXlvMEpjSUtQSDh2VUt1K053REhCSHB4Si9JSTUx?=
 =?utf-8?Q?7Dkzt4RHoRRKTrHR7dRnOPf+p+NJUYu4hT/ip?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f3c573-a3cd-4a44-90a5-08dedea311b5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 16:48:29.3747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQxQSYaBvRsOhvQpQ4o0iU49kssn4jGkO+nQ+Rmmv/MqdmLHFjB3zx20QADfBxO3qHUs5mfCf0z5VmyQAyp90wj+KTfzdCWweQccZ0JP92pmAz/j/CFA8GAYnDSU62j7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9345
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12329-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,nxp.com:mid,nxp.com:email,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82D8573CF1D

From: Frank Li <Frank.Li@nxp.com>

Add a non_ll_start() callback and move the common non-linked-list channel
handling into the EDMA core so it can be shared by both the EDMA and HDMA.
Prepare for the upcoming reorganization of the burst and chunk structures.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- add koichiro tag
---
 drivers/dma/dw-edma/dw-edma-core.h    | 12 +++++++++++-
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 23 ++++-------------------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index bab4d49c92feb..e18d6e827c2c9 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -126,6 +126,7 @@ struct dw_edma_core_ops {
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 				  dw_edma_handler_t done, dw_edma_handler_t abort);
 	void (*start)(struct dw_edma_chunk *chunk, bool first);
+	void (*non_ll_start)(struct dw_edma_chan *chan, struct dw_edma_burst *child);
 	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
 			u32 idx, bool cb, bool irq);
 	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
@@ -201,7 +202,16 @@ dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 static inline
 void dw_edma_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk, bool first)
 {
-	dw->core->start(chunk, first);
+	if (chunk->chan->non_ll) {
+		struct dw_edma_burst *child;
+
+		child = list_first_entry_or_null(&chunk->burst->list,
+						 struct dw_edma_burst, list);
+		if (child)
+			dw->core->non_ll_start(chunk->chan, child);
+	} else {
+		dw->core->start(chunk, first);
+	}
 }
 
 static inline
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 16fe3ef43948d..641a513bc52e7 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -272,18 +272,12 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
 }
 
-static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
+static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chan *chan,
+					 struct dw_edma_burst *child)
 {
-	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
-	struct dw_edma_burst *child;
 	u32 val;
 
-	child = list_first_entry_or_null(&chunk->burst->list,
-					 struct dw_edma_burst, list);
-	if (!child)
-		return;
-
 	SET_CH_32(dw, chan->dir, chan->id, ch_en, HDMA_V0_CH_EN);
 
 	/* Source address */
@@ -324,16 +318,6 @@ static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
 		  HDMA_V0_DOORBELL_START);
 }
 
-static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-
-	if (chan->non_ll)
-		dw_hdma_v0_core_non_ll_start(chunk);
-	else
-		dw_hdma_v0_core_ll_start(chunk, first);
-}
-
 static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -399,7 +383,8 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ch_count = dw_hdma_v0_core_ch_count,
 	.ch_status = dw_hdma_v0_core_ch_status,
 	.handle_int = dw_hdma_v0_core_handle_int,
-	.start = dw_hdma_v0_core_start,
+	.start = dw_hdma_v0_core_ll_start,
+	.non_ll_start = dw_hdma_v0_core_non_ll_start,
 	.ll_data = dw_hdma_v0_core_ll_data,
 	.ll_link = dw_hdma_v0_core_ll_link,
 	.ch_doorbell = dw_hdma_v0_core_ch_doorbell,

-- 
2.43.0


