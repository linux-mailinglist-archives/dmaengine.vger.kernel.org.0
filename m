Return-Path: <dmaengine+bounces-12131-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QygDKcSYTmrjQAIAu9opvQ
	(envelope-from <dmaengine+bounces-12131-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:36:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7767298E6
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:36:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=PTj0vGm6;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12131-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12131-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1EF2F3047905
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 18:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE634CA29D;
	Wed,  8 Jul 2026 18:35:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396A4CA287;
	Wed,  8 Jul 2026 18:35:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535741; cv=fail; b=lDRHoIf82ppL9bwrTqZAChpH+mEZp7HLlt04SY+Ja+EDpgobVneAHpE0nDvNIjjFL0iXmnBt4w6wlPLd3XVueuVqvbmk/ugasZVqA9Vve+UgU+5PcAh5cZCw34I9wbv/VEyWH5JxLhA3uUX/DhWB4UtfpGnaOVgLrxvOFryWi3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535741; c=relaxed/simple;
	bh=ka9kK4KrQsiFuQ8VaCuD7Ocm0ukLLA6FePwvwbbbQ5Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=puDl9i92AFdcxllhfDAW2uhSnM7ddTleklEe+yZRV19o5jt71mXd2+BVTfW9qNS4uS/ztojZN/InU0Dk7HBWBgC5guWDOfvpxWz2lvimDK7AOb2KnRFngiJb3INJHjzeShPDirchsj9cOe/6vWPw/On6m7aa70/8rqCEkdFyiHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PTj0vGm6; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUqHoKryfWkFOzfl3vioIVPhdatEtocgkY9k91hblcW9z8k6y2SqUvxhT9RbcMpYWEZf5xXUZQm7RllSk/TNlDsX0O2w0NGleb8mESLYN2CeHWVOJ7YEQGQkTXOA7OuEWgf+/xCcP4nx0mvNaKAzAcAHhDghABa4ProRw1jYIdRhHekTrHiFjCXPMOS3l9uk3jQIrydL+VNYacyVkcDfuOgffJtXOavczmds1ouz/ti/rFlRqZykRLe3DbWbMF20Ubry83ersvafLFl0I9lqXL++obnKmPzeKqemZM08FqXN2eMfwvpsJpv0oMcMM7DNdccG0taXIh6OEHz823+RSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdEl86LdkV9nKp9o1EJZUr5v0ExfYEdIWLsA5ZtNGBg=;
 b=l9JhUQIfXW1OreeODIbTezkJ6T3uM+Y4ikgCJCYZ801OA+YdbPl7SYz/+FbZv6y5Q4Cy/qmOsQMH90fcTqccJ8wYUxtsQb6ip+BVcKZiUDBSIaLQdqLPcuzPk/LY55PRZotqz7tNuxNLszYgog/MIjrdaSkPOCSlfSpUcErOyYY6oJFA1QeDciMxTUzTzcwy1IHKUd5oUIjo9UVhmI5G3aTDjSl0hUwOoIermp3+zaPAdApuaOkXYntifRzPjmCEX3/Vx8AXOEf1Nqbl0NDBjzM3rKxeMjTEiZ2c1aOxl9VxhdyqA2iVvAxqpI8mx4t/+z3sMnOZ6lSq8wJGqQWY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdEl86LdkV9nKp9o1EJZUr5v0ExfYEdIWLsA5ZtNGBg=;
 b=PTj0vGm6AtmpOtry3n7ZG2uYG9Gg3HsxvAaN/Jg13QVCmkmv2IUgFuoossWjSUEonXgPXfGQyT73jpkhqOIefqcniUEdZRjwsRs6RRA0JMbMLCYhPCnvHqT6YP7sy1SyKiz+ywdK1cuhWcgi6GXt4gAA4DCM+zAF6wF9vNmyQClmjuPUvptWexwPOuRsbqkoXVhTryPARMauwT9mFwCY3w1TN6/L/BbylJnXtqAXVmxkg6pwfkA9Lex0iL7BNsSV+TYlcZck/4jy/Ux26IIUJW/SSocDo+MBd0/nJBllkqiDgY1tk7J9M4APh1WtG5MEHcy3e12amOGTATQcac8RAQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB9810.eurprd04.prod.outlook.com (2603:10a6:800:1df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 18:35:35 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 18:35:35 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 08 Jul 2026 14:35:05 -0400
Subject: [PATCH v4 05/10] dmaengine: dw-edma: Add helper
 dw_(edma|hdma)_v0_core_ch_enable()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-edma_ll-v4-5-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
In-Reply-To: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783535707; l=8061;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4EK0D3D/aLmHCCY94Jg6tvOeSLTRe5eZn5kbz2AZWXQ=;
 b=lrWlxMXynZ1kumK7gKmwPPpFPyF3tXY1or4yCmfvzS/WZTJN7KKc4pvGNALUXE6QwCRjANs7Y
 hbDfHYySCVABF8Qeymbb/G+VQ8BhP1xLkDWW28h/ZUUaDmufGcQccg7
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0082.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: 74279a27-0a44-4913-0606-08dedd1fb303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|19092799006|376014|1800799024|23010399003|56012099006|22082099003|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	ZPaeghFoUvxNX/Js1qXSh5N5sVNmNOPMbhoQ2ZqhqbKzhUrcJuZpg9J0+DzwXxMfrbXJsh6mcUIfej+l1ebThVuE7USD0PNfu36Zbabz7vq1WE8+aN30spogZx2DmdETDq+ti6qMGR7jtqStNqChhV0WfGJXbyenP8qdR4rIMyruduIGw8WpN4ehI/H6AYYMAPHx7N8HoYCg94wNBuIiqXPkgJc68C3Sk+WDkAxQIpEJ6MTjMY5oG8ifCoC9dscg/U9PgUnAuU88JHganosJO9iL2HPoEoHUhT1bBcjGo+JxcgQtBXkOxIkr+wBq+7RvkYJlT5f8oMv8HxQjsDCX6tGAOkG0cjPlo28JhTmgDQx1hUmQ/14ihQn6rIwddC9rRmkuRI3AIAhf8/c+8gwqkYBJz3T1LGgNuxkZYQvkUgA1K5OKjH6tHo3WgAuxVZrMKnpcvIJzP+XRKWt8imo4/7MeerJepi86F+FMnwUeXp8b4Aa7PA2Mr/jKebyEbcC8VPmiF2uDqVFhwVSu9X8CVy4MJ6hcxHrZxICyW/Vg4zo/2yjOLyH5Z/rZQMcMzIuBoEPKb399RAAkZ1ZbJbmAsySqXeNxHxSBYmi3CFjjBhfmfOcKdIeW0W8smplR6XURBm63ouVWFwer+9CHC0Gh7rMmClEL1u6Igno5luxoBaQMi30nSlkfuYPaBOmwvdK37CuPkNjLwPM4QEs/YuISoQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(19092799006)(376014)(1800799024)(23010399003)(56012099006)(22082099003)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW4rbHdyY3JNNmgwQ2RDTTNzMThNN2JFSFNqR2kwM0ZETzltYWhsUU5OQy9L?=
 =?utf-8?B?MzFjMWtNMXZzeEdpZmFPUGF2Mm94WjN4dGxDeUJSeGVzbWZoUHU4dHZEYUJq?=
 =?utf-8?B?aDYyT0s3YzlwTlBWZDluN0NQU3NJeDVHVjFXaU1wczJmQ3JIN0NGcHJLaEUr?=
 =?utf-8?B?NmhnRWhPWEFoTU0xaXQ1MFZHeFA2MEVsaE5ta243ckNPdSszVVkxZFZ0bzRt?=
 =?utf-8?B?Qk9yU1ZOT2IxS1hBeVpRNTRQQlZsZ1pCQ1BqQlZLa0lRVk1HZjRmWnRYOGpS?=
 =?utf-8?B?NXNsTzZLL01DQnByeUN2THVoMVRyZVJ3WUNlQVIrRVlNOU1La0c4SHJoUzFE?=
 =?utf-8?B?c1JYdDg1eGZwWDRtWXh6MGRwVldESW5ydTdENFpFeHhIM2wycUxQa0ZhZXZU?=
 =?utf-8?B?M0EvRU4yZ0h2d3V3aThMVCsvRGVSVmF4ZHQ2K08rRS82bFc5MWE1ejVzM042?=
 =?utf-8?B?VFdoRVdJR3pYejJNdGw5cE9MdENSNThZNlBzc0VCUHdMTnZ6WjczZzQzeGNU?=
 =?utf-8?B?dzNRbE85Y2RRSEsvQjJUSG1XQVNiTnFvcUFqeWt5RzZSSE9SU3lEWWZLb0pP?=
 =?utf-8?B?Z0NNdjIvbnQ0b2lZRjRtWGhmMSt0SWc2S05qRHhqZFFadkJQUnNnd2JCc3c5?=
 =?utf-8?B?WXRYbkxBUGRkMG5uUVVFL21mN2hTcG44WlR5cUxBTUV5SjJuQTM2NnhqVnFl?=
 =?utf-8?B?QWlFNjVndFBpYVV3aUhQMjVON0JZcHR3b0FVcTl5aEdDRWsyOXVDMm45KzJn?=
 =?utf-8?B?WlViZWVSakRzYldFVHorelZmbG5HakUwSlZmYit2S3RuTlRwTWcxeUZKYkJ2?=
 =?utf-8?B?RmlXWTZZWDhQSEoycDk3V0NVd3JLb0FGTmhmVUNlOEdyVUx2K3NaL1BvaENK?=
 =?utf-8?B?dlRqSU40S3pEMTgvRytOek5yT2NvUFJjVmJkcmVQVFJJdlNacWp2QlFWRkdD?=
 =?utf-8?B?bFRPTlJFeVhvRWhrOHc0VGhoVjZXTWE0c3g1Z2dwb2VMSktWazlxaVJiczRW?=
 =?utf-8?B?VGJrYWUxejZhU3NaU0pKcjlvU2ZFditvL2txc21Xa2RXbDg1c0hLcXdzMkFx?=
 =?utf-8?B?dEYvRFpLUGpKNFYrYm9jbUxId0dXamdvWEU4QVNteGFDeDlPQTVnLzVTVFRp?=
 =?utf-8?B?d2JmUTBrNlV1NEFORjhIek9KeDRPTHJDY1c5VFJhcE8vekNGczluK0lNU3g4?=
 =?utf-8?B?ZVQ3OUk2eVJXblg2a0NNcDhTQ0Zxc0FrUVVOcDYyTzdSbyt5Q3MxcWxNVTJJ?=
 =?utf-8?B?T25EMDFLeFlsY1NSV2MrbncwSU9hb2hlWGZaYXhBYktKSm95eHQyYkpNcm9J?=
 =?utf-8?B?a29aMmNPUHhuaVlOYk5sWGEvaDlCSkQ0WEJHRGF3YWVPbnNRTDBOU1Y0RnNH?=
 =?utf-8?B?RnhuK0o1MjJ4dTNDMHdBQVo5N25QNFJWNlpUNUNReTZnWjB1V1poUGxCSUlt?=
 =?utf-8?B?U0hWSUtnVUdBVEl2aFNXQVZSa3BGQ0QvcEoyb0ZwTC9tSUlBekxWemZnN0dR?=
 =?utf-8?B?MmxMKzFQL2dNc29vU0ZqNnMvd0J2NGxLTmNWSkcvRmdvRXpHWFRKbFNqQ2pS?=
 =?utf-8?B?d3FNYVpCaDJsRzFBSEdOUnR2aGpPU1lreUZjWm16aEFBbnNSQXJnTlV1RldZ?=
 =?utf-8?B?R1AwUWNuR2J6NzlqeVhETzFRNE9Kc04vN0p3U0pYOG1CeEJhSnMwRitNYWw1?=
 =?utf-8?B?VXkyNnhaOTBzZGV0andjLzFwbEwwalFBQnJNSCt0OWk1RkQzUjZHbUdtS3F6?=
 =?utf-8?B?R3VRUlFyaGJyN1BMcmlTWTY5YmJGN0xrcVE4clVBL0owL3gxQW9aNGVDcmdF?=
 =?utf-8?B?Um1qU0hnSUhNZEZ3Mm9KY1B2aVI3blQxemFFbFpIWlY1Q3RNNVVRdzdtUHRr?=
 =?utf-8?B?R2R5eW9oS3VHMzBTVTc2SmdMS25CUFpSQmNPM0YwUVZoR2R4bUNQOXQ4V1Qy?=
 =?utf-8?B?dVI3RzIzZU1mUkp2dnFNUmQ2UUNWNW5IWVhLaGNqWGtmdnFuS1ZBUmliaTZT?=
 =?utf-8?B?d25sbkEycVdqMG1KSFJwR2FPczRRRVVKYWl4NGVsMzV0aVBTc0RpOTFGQ3Vy?=
 =?utf-8?B?VXEvQVVsWHdzdFErNUQvRFpHRDRENmJXejRUZ21LeFJIbEkrdXNsRDVoT1Q1?=
 =?utf-8?B?TFEzMW1VR2h3Vm81QWhKWVkzKzZHdE9TRjArZXR1cHdDMHMwZkN6MzBjRWls?=
 =?utf-8?B?c21SV0hNaU5Tc1RPZUxZTG41U1h6RHJIYWtUaDJXUE1TUExPWlRJWlA4Q0dH?=
 =?utf-8?B?aWNoTUJPOU55RGFRTUd0aTFjVXBOZmJTMUt1c1gyL1p6dTNPanFXRC9HU3di?=
 =?utf-8?B?Y0YvaW05Qk9hQ20wVEF0b1NzbE1GVEZjZDdXSmdDR2xOaXp4cnJuS05uS2Vt?=
 =?utf-8?Q?NAFy35q+H5YmJTsZaCAV0VjdwL8Iwm6DOfpTK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74279a27-0a44-4913-0606-08dedd1fb303
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 18:35:35.2582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkwhtyCicthUuGbE9HxDHBm1y+1Egu2E1I8LanrAorWxtFuW8zbTom2qFUKcToTKIKuDeTguCZsUczRHJxd+GxKc+xuYi5NZ3vjyBiXdZxbjR2n5cRVY8TCVOvZaHfvI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9810
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12131-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim,valinux.co.jp:email,oss.nxp.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A7767298E6

From: Frank Li <Frank.Li@nxp.com>

Move the channel-enable logic into a new helper function,
dw_(edma|hdma)_v0_core_ch_enable(), in preparation for supporting dynamic
link entry additions.

No functional changes.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4:
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 128 +++++++++++++++++-----------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  54 +++++++-------
 2 files changed, 93 insertions(+), 89 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index c341aa5343417..8d38867cd9983 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -318,6 +318,67 @@ static void dw_edma_v0_write_ll_link(struct dw_edma_chan *chan,
 	}
 }
 
+static void dw_edma_v0_core_ch_enable(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+	unsigned long flags;
+	u32 tmp;
+
+	 /* Enable engine */
+	SET_RW_32(dw, chan->dir, engine_en, BIT(0));
+	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
+		switch (chan->id) {
+		case 0:
+		SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en, BIT(0));
+			break;
+		case 1:
+			SET_RW_COMPAT(dw, chan->dir, ch1_pwr_en, BIT(0));
+			break;
+		case 2:
+			SET_RW_COMPAT(dw, chan->dir, ch2_pwr_en, BIT(0));
+			break;
+		case 3:
+			SET_RW_COMPAT(dw, chan->dir, ch3_pwr_en, BIT(0));
+			break;
+		case 4:
+			SET_RW_COMPAT(dw, chan->dir, ch4_pwr_en, BIT(0));
+			break;
+		case 5:
+			SET_RW_COMPAT(dw, chan->dir, ch5_pwr_en, BIT(0));
+			break;
+		case 6:
+			SET_RW_COMPAT(dw, chan->dir, ch6_pwr_en, BIT(0));
+			break;
+		case 7:
+			SET_RW_COMPAT(dw, chan->dir, ch7_pwr_en, BIT(0));
+			break;
+		}
+	}
+	/* Interrupt unmask - done, abort */
+	raw_spin_lock_irqsave(&dw->lock, flags);
+
+	tmp = GET_RW_32(dw, chan->dir, int_mask);
+	tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+	tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+	SET_RW_32(dw, chan->dir, int_mask, tmp);
+	/* Linked list error */
+	tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
+	tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
+	SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
+
+	raw_spin_unlock_irqrestore(&dw->lock, flags);
+
+	/* Channel control */
+	SET_CH_32(dw, chan->dir, chan->id, ch_control1,
+		  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
+	/* Linked list */
+	/* llp is not aligned on 64bit -> keep 32bit accesses */
+	SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+		  lower_32_bits(chan->ll_region.paddr));
+	SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+		  upper_32_bits(chan->ll_region.paddr));
+}
+
 static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_burst *child;
@@ -366,74 +427,11 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
-	unsigned long flags;
-	u32 tmp;
 
 	dw_edma_v0_core_write_chunk(chunk);
 
-	if (first) {
-		/* Enable engine */
-		SET_RW_32(dw, chan->dir, engine_en, BIT(0));
-		if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
-			switch (chan->id) {
-			case 0:
-				SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en,
-					      BIT(0));
-				break;
-			case 1:
-				SET_RW_COMPAT(dw, chan->dir, ch1_pwr_en,
-					      BIT(0));
-				break;
-			case 2:
-				SET_RW_COMPAT(dw, chan->dir, ch2_pwr_en,
-					      BIT(0));
-				break;
-			case 3:
-				SET_RW_COMPAT(dw, chan->dir, ch3_pwr_en,
-					      BIT(0));
-				break;
-			case 4:
-				SET_RW_COMPAT(dw, chan->dir, ch4_pwr_en,
-					      BIT(0));
-				break;
-			case 5:
-				SET_RW_COMPAT(dw, chan->dir, ch5_pwr_en,
-					      BIT(0));
-				break;
-			case 6:
-				SET_RW_COMPAT(dw, chan->dir, ch6_pwr_en,
-					      BIT(0));
-				break;
-			case 7:
-				SET_RW_COMPAT(dw, chan->dir, ch7_pwr_en,
-					      BIT(0));
-				break;
-			}
-		}
-		/* Interrupt unmask - done, abort */
-		raw_spin_lock_irqsave(&dw->lock, flags);
-
-		tmp = GET_RW_32(dw, chan->dir, int_mask);
-		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
-		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
-		SET_RW_32(dw, chan->dir, int_mask, tmp);
-		/* Linked list error */
-		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
-		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
-		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
-
-		raw_spin_unlock_irqrestore(&dw->lock, flags);
-
-		/* Channel control */
-		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
-			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
-		/* Linked list */
-		/* llp is not aligned on 64bit -> keep 32bit accesses */
-		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chan->ll_region.paddr));
-		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chan->ll_region.paddr));
-	}
+	if (first)
+		dw_edma_v0_core_ch_enable(chan);
 
 	dw_edma_v0_sync_ll_data(chan);
 
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 156b1cc225091..31bbdc6a40642 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -194,6 +194,34 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chan *chan,
 	}
 }
 
+static void dw_hdma_v0_core_ch_enable(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+	u32 tmp;
+
+	/* Enable engine */
+	SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
+	/* Interrupt unmask - stop, abort */
+	tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
+	tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+	/* Interrupt enable - stop, abort */
+	tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
+	if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
+	SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
+	/* Channel control */
+	SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
+	/* Linked list */
+	/* llp is not aligned on 64bit -> keep 32bit accesses */
+	SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+		  lower_32_bits(chan->ll_region.paddr));
+	SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+		  upper_32_bits(chan->ll_region.paddr));
+	/* Set consumer cycle */
+	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
+		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
+}
+
 static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_chan *chan = chunk->chan;
@@ -232,33 +260,11 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
-	u32 tmp;
 
 	dw_hdma_v0_core_write_chunk(chunk);
 
-	if (first) {
-		/* Enable engine */
-		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
-		/* Interrupt unmask - stop, abort */
-		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
-		tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
-		/* Interrupt enable - stop, abort */
-		tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
-		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
-		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
-		/* Channel control */
-		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
-		/* Linked list */
-		/* llp is not aligned on 64bit -> keep 32bit accesses */
-		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chan->ll_region.paddr));
-		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chan->ll_region.paddr));
-		/* Set consumer cycle */
-		SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
-			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
-	}
+	if (first)
+		dw_hdma_v0_core_ch_enable(chan);
 
 	dw_hdma_v0_sync_ll_data(chan);
 

-- 
2.43.0


