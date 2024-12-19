Return-Path: <dmaengine+bounces-4030-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5979F784B
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 10:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1691E7A63BD
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 09:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3529221D8F;
	Thu, 19 Dec 2024 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EO1k/L5o"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378462210DE;
	Thu, 19 Dec 2024 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734600059; cv=fail; b=PcpAykhA+eqXUB3/cYZBy2/qDSOKhah2jnNRVdKBzdkkb49BYx9aoJ+NtUjEImwMB8pERnh1egeeBg8jtcyE96tPOgDm0YiF/8DB7dO94cNuJgbY6gsyABd8t2YYTkewc47KfYFETF6vY7t2qcdhAsEoAuVRxHkLPn6TRPHvtfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734600059; c=relaxed/simple;
	bh=CBEjJO602nk1ReVwEh9g5AYq8vr1DC9T96A7EzXPOTg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u1T+4uJ4okaIMryGfZMaZaDLu9xEQfxrDS3DZ/P7jgQxJfoXg3ogBeWE6JnvrS7CNNzbP/9rKHnnIYlPE9+MYXttwPbrbd+n90Tsispz+7Du7SUW3gUcrDPk/dYUcfYdJrNZ2Xdi5vdd4vY6JM6r+ZNGObjrsXkWWKqaMabJ1yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EO1k/L5o; arc=fail smtp.client-ip=40.107.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ki4jFiWw8YpoX43MtPzFBhMaUdwkeZ20VGp8/qs5BsbmNMtt5vYa8nKUYJLHEtEcGS7LNJU9ihXsFI8eP8+8uaWfnMpiiGk1LPHZ+GyOQ5Rl9qmJDku9vzeTWa233BZLdTOffoXTLjQVCZg/ZdNTool9HLFqJP9Zw2hTiTDO2GmUEgz0WJBFPVliCwghKS4qNBSL67JBmZJxYq8MPTmDmgWg7rKw2wagw/qm+ernwQSmc5M6GLZK2EJjUMqg+WhvR8jmxPgPp/pm993iMNN9CF5VXSm8NE9Iut6DSxLLS7XnVnJYemlFlkCrd5euPaesg/ip0Kt6qWDrVuu5ctq2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SgL88KNwrdIz6MynwXTt5/a4/9tiadxMKIwED/sXhQ=;
 b=SXnWoxQB5fjuvLqeq9CB5uY213u1QbkfNUL59S5zkknNHB4vbvVUIxlPMCX7QZvIvN+b9yj8YfdJh4hzplKU/RwduzTUSG1rcOWTpXjM0LpXZ38KcnIwSB01JmrbV9/lmsNbWLhesLdu3BH4n91VI0PN3gP1T5XopJ8AQNH0ZpghF4Nw66IWQrBCDob3XBUbvtJVmKQYDRyW4+wHV7nODbY5hlfPKSWGI5+lFu9XC5vCfHjSSPu3eFZkD2DuASD01F/zPzepgjWHd33TF4HjD1LOpzkv2rKS6wjCwfofw9KvkAe9uxQds5t0PcDjhjNnzjD8QmBXyGYniMw/A7nEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SgL88KNwrdIz6MynwXTt5/a4/9tiadxMKIwED/sXhQ=;
 b=EO1k/L5oWHaVFAZXIkCyTlOB50MyrZoQJEj1jg6Fwoc10Mzj3hV/bS59EVjcE9p4qER66gYNAHL3GMoqZHZJ/qbJWGzKmSJNJ3s38CaJvFKn0kFbSvOqwyBZKwuf07vA9gwLXrr8RXLFvQNtaXKTaAiH0FgY+n+BxRgmhAFfjySl8xgvW9PfEJglw3twC56+3a1Dv+UxqsD8aog9bQPdIXkbjvMc7lM5J0Y2lXy3q9j5CwRDcPHf4uzF003Ok9tqaJMTAHoHjiaiZnCzPxlVWxQQ4UXAmEEvLXMbR2IyeRuyaSba3PrlEqKsUyd74VFAi0LxoznczWf3qWVEuC3bBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by VI1PR04MB9834.eurprd04.prod.outlook.com (2603:10a6:800:1d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 09:20:52 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 09:20:52 +0000
From: Larisa Grigore <larisa.grigore@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>
Subject: [PATCH v2 0/6] Add eDMAv3 support for S32G2/S32G3 SoCs
Date: Thu, 19 Dec 2024 11:18:40 +0200
Message-ID: <20241219092045.1161182-1-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0212.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::19) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|VI1PR04MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: 46a9d86c-5f7b-4c7c-210a-08dd200e6ec2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjlyQ2RWTzA5Y015MTVzd1ZuQWYweThnMXdrZVdEdVYwbXlWUzZySmhTRG0v?=
 =?utf-8?B?V2JYQUFwbHZxRFUwODRJYUVaVUQ3YjJicEFZSU5UeUNVcXhMcVIyRWpqZlhZ?=
 =?utf-8?B?cEZYSWVWWGIyTDJabU1QK3p5a3lMSFdCSEdyaXFCSjNqd3FSd21XOUJqbTNT?=
 =?utf-8?B?TzI2UHZkdzRCZ0trdUIzVFhoYlQvaGtJRnZuY0ExZmhLZUdNNWNnU2JoRlp0?=
 =?utf-8?B?MXZVN1RWODhSOEZHZ2p0UlRFZ1lOcnczWW9xczdoa2E4S0V6ZUJQOTRGS0lu?=
 =?utf-8?B?TG8wZFFIWmpadG5peHhBUnh6Q1ozR2tjaGFqelVHdnE5bE1ZVi8xTkpjOXpR?=
 =?utf-8?B?dE9EY3lsOXBHZmZJeTVUVW8wZHUvdXpiamFsSTNsYjBsMjZLdjZ2T21sZG5s?=
 =?utf-8?B?VGx4U21TTDkzN3pKVEhpUDNIemdRTWM5cldoLzZPVGsxcmh6dGp2cmdzVlBK?=
 =?utf-8?B?UXZOQXMvMHNxVWhmV0dGdlFrdmpJT25BYTdwcU0zVWtmRmxkMWREMFhXbTgv?=
 =?utf-8?B?WG1VZ2JxL1lQcDBwUkFWN0kvMXh4UW1yVlNzQ3ZLVjcrRWNKQzR2UU5RR3FO?=
 =?utf-8?B?R1IzTWZPR3dsVXZnWW5lU215d1krMlI1Nlh6cFZmT25yQllNMTlHSFplTXhI?=
 =?utf-8?B?N3BuQzZaQ1Z6bno3UWhrd2RIY3RxWUtoOVZKa0tDVFVySDdmNXFXUXFkalJV?=
 =?utf-8?B?SlR4dnBraE02NlFMZml6RnF2S09EbW9aUCt6NTNjY1k2eTcrcDBIRUl5bEZZ?=
 =?utf-8?B?SERZOTkwSkhZbHliNm85U2hsbDF3M25oWWRsNG9lZGJUZTJ3WW9EcnluVkxv?=
 =?utf-8?B?OS9oOHFGbEgrbnVIRGxER1ZxMVdGdDlFazVYY3NhV05MOVJNV28xeEJPOFky?=
 =?utf-8?B?SkwxUWllMFZzWDJiRDZSeUFHRTFZSmlTajJELzBwdVZOa3VDMUVsakloQmk3?=
 =?utf-8?B?RVJCOGRhTXc2L3lUZkx0TDdDa0E1dlBWeWZLcnRaS3VZQ1EwZ0Z0TW9BMUg2?=
 =?utf-8?B?YWZ6ZWlPcHN5WGtMdDBDR0x5cVU1Mmw4MlFSSE8xMkxDeUdwZjZtUTFTcUpM?=
 =?utf-8?B?N0tYWm1xSXBMQnhUbmlBMFdMYi96NVBjMUVHOTBWYWFFOUlvME5OdjgzeXRL?=
 =?utf-8?B?aTYxdS8yM3drQlhiZ0p0WTRzUXdFMmc4aVp6YnlqeFBoMjlnZkZzN3JBV0pD?=
 =?utf-8?B?K1FVcWxMdGd3U3ovN0xJSzArZXd4YWZ2NmtGbll1SjVoWERNUjZwWHZRZHZj?=
 =?utf-8?B?V1RHSEhOVFVBM1dtZU5Wb3hKbHhJVlhIbXU4ajB4TEFWOHJoMFM1NlJKc2du?=
 =?utf-8?B?SDBJd3Y2a2FJRjVZbGxEYWhNaWY1cHVxSlZOZnhrTFNLcUxka3o2ckdPQmx1?=
 =?utf-8?B?M1lSU3QvbkRTVVZZOEtSdVYxNmlDaTRDd2RzRnY2NmhkN21Sbm9aeGpBVzFj?=
 =?utf-8?B?K3NxZk5NWWQzdTBjSUN5Q2tVYjhmazRrVVVLTloyY3Irc1QzNmJ2QzhQRWRm?=
 =?utf-8?B?Z0lZY2xmRkRMOW4yK0RiU3czVEhYZlBxbnh1YWsvZEtOMUNEVGxnQVN4V253?=
 =?utf-8?B?Z0dpcE1MQ2p3K2VlMjdvdGMvdEpObmt5Ti9DcUYxckxkQ1JRYXI1cUttUEV2?=
 =?utf-8?B?MFMxZjVXRjE3R2dVa3p2ejMxSXNoQmgyaHgwSXlMZENBdFVWZDhzSU1acHVl?=
 =?utf-8?B?N1FLMTBCRkYxanlndytsa1Vocy93VUl6eGtYUGtKRm1wOFpWNUIreitaMlFy?=
 =?utf-8?B?N2tvWm15bS9iakVmV3dsWDIxak8wejJsUmh2SENpVmxhL25Gem9ROUtsSEpY?=
 =?utf-8?B?VUxSbTdnNWhjMFVDSzJiZ1pVbzUzNWJSc3B4bWIzRXIwSEc4OUVzN1hPTm93?=
 =?utf-8?Q?XUH/OKaRimM2n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWYySU5vcG5yTi9QQkxuK2xIdFU3T2NEVzdLRkNrM0ZOVEJRZ3ZXTmw4bjdi?=
 =?utf-8?B?RFVPL0pnV0Q3dEFQVXZpWXJYcGNISGF1YmhRRUQxcUI4UFhSRWQveG1ZeDJG?=
 =?utf-8?B?N0lYRjQ2Rk1OdHVQRkNkRitoWHpBZGU5SWs4b0NNVnNpM2lybXljVzBqUDMz?=
 =?utf-8?B?RkJablM4UDFBc3FFTFFHaG90cmlQTHc0eWpWZUR3OUxsN2U1VS9hdXlKeGhn?=
 =?utf-8?B?UDNFaXpCelkxN1AwMXVBTGFuU3VjeTRKRmZwWExQUWZmVjJkeUh6emFyT1Qw?=
 =?utf-8?B?alVoUmkxWEVPelE3V2VnaGhKYXJOMW1kU25wdDQyM2Y0NUdhQzJJVmdETVVN?=
 =?utf-8?B?MEJBUEJPTitZemtQT3B2ajVRblU4L1B1dVBzOElrNk1DVVZFQU9Ca2VNclVR?=
 =?utf-8?B?Nmhza21jdUNvZlc1ZlNTVGwvZXFZZlFFRGlBbDM0aDhhQ29TV2xXWWlXdUdY?=
 =?utf-8?B?OXN3TU9teU9uWWFneWdaYXB5eGwvMUE0b2lSY3Z1SC9CWEU2bEovYll6WlBU?=
 =?utf-8?B?dGhHUk5xYTc4Qlc4SGVORmhvZmxwNzUrbWVabDZ2Y3hMcTVwVzZaRU5qVHhz?=
 =?utf-8?B?ZXZtWUJ0RjFyUkJ0aXFES1dmOXFPMTh0TjYvRllxbno4MlBZVUJNb2U0NXVK?=
 =?utf-8?B?SUw2eFFoU05JNWt4eWxNUzhKR0xWK2RuSTBSbTNLSnhSNHBpeDJKKzB5SnR6?=
 =?utf-8?B?c0FWdFRZWXdidVBCcXVRMHhwTmg3NmNDQTFIdnR4aDE3K2pjY2ZBQnZOcWc3?=
 =?utf-8?B?dlZZT3lWRjRGME1ESVc3eTBnTGhYZkFveDVORnYyTURMczZObWlJRE9teU02?=
 =?utf-8?B?VTcwc1JlREFBb2RMcVUxdjJMWG5MMHF5U0lFSFZJeHJ1UU8xTTc5c09XM2pZ?=
 =?utf-8?B?cnBxL0FnakxEUzZjbHlhSlJ2QThKREg5OEp3aGJsQmUyRVczallHNjcwbGxX?=
 =?utf-8?B?MThCUFdXTVJyNmpFNFNxM3J6RFREK3J3Z1BYcEppSlROdnZ0SVQxYS8zQTEx?=
 =?utf-8?B?Qlp2MHdyZ3hoSzRISXZNbk5lV2JHZDg3OFl4MlBSL2ViK0xpN1JYOWd4WFhs?=
 =?utf-8?B?djVtZmFuNG8vVHZMZjlvNE5mVGtBdmh3RW45RUw1dWI4dmg1UEJYK0ZuTVpR?=
 =?utf-8?B?c0J6SXdkeXExNXVpb3hYK1Jrd2hsRm5CdXYyckRJbUFhMXZhVmVDRjQwVm56?=
 =?utf-8?B?cUtBeEdsbU1JaWw5d0ZJeWkvMXpVM1IrYnhnQ1JtbFNVanhXWHJBb2oxNmFa?=
 =?utf-8?B?LzRMM3NFTDFMWUFBaEJGTk1CMytxRTBoZi9OcmlIbUhMaDVnY25vU3dGc1pr?=
 =?utf-8?B?bHNQdWpVVVJ5N0c5RDh6aENWakpjTUVCeTNDRVpSSmo4WU9xL2h3SlB6UlBZ?=
 =?utf-8?B?T0UzSzBlU0lBa2NVcGVhajNjdkZJNE5yUkhjRHFqYXBWdTdJQmN6eEcxSUhx?=
 =?utf-8?B?Tlczd2JrV200N3IxbTFWYW5MVzBMamNuaWJxbUg4V1orRGc2RlRtRW9PY1dh?=
 =?utf-8?B?WUZpYXBxdWVBWVNhb0pWZGdWdklvTVRSWDZ6YWE2cU14d1cyWVNIM2xsSGY1?=
 =?utf-8?B?WGdUUTZDazVZUUlNSU1EeE1kaEcyYWpJV0kzeEtvbzVQT1lBYTBDdDh5MHZj?=
 =?utf-8?B?NVYyeWZ0RzQrY1JYeXUrdnVsamhuZ0RSeVYvK3ZHMHliajFjN2RTSjFiVFNs?=
 =?utf-8?B?UE14d01uRUZLRjcva2l1TzMrS3NOWk16UFdjV2dkNUZ3LzlRS09HRGF5eVVl?=
 =?utf-8?B?azRBRkx2aVBYTEJoRHI4cEEzNk5KME1xZkxBRW9OYlArNUFxVnJDOFpDSno2?=
 =?utf-8?B?Z2pycXR0NzlvL3V0V0FpbVN2dXlyU1VNYTFSNDJ6NTkxQ01QejV1Z3NOU2o2?=
 =?utf-8?B?S3VxTy96SVlaTWtpdElad21qVFVkY0pWbVZNTTNZcFFPOUJCcWcxUWVVZDdq?=
 =?utf-8?B?eUl5eStzYjd1ZnhXd1JJNTlRaFhic2dFUlBTcndaWXFHZDl0WGU5Uzg5Rjdl?=
 =?utf-8?B?MEZPQ2R1SjlMWVFNQUY5U2NaQ213UXJCMUNRNHpBaXk0ajNkcklObkpYLzZM?=
 =?utf-8?B?MVB4Z1RzemJPNllFSkNVTHlYNGtabDhYZkYybXduMUptaVhzZXZDOVJ2ZnIz?=
 =?utf-8?Q?OsHAqV2MpRk2xXntDHjuIttWl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a9d86c-5f7b-4c7c-210a-08dd200e6ec2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 09:20:51.9578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXp6/JgNBxSI5NASCPBHfFytaBE48Zh1ZWXI4owBvP56zxzrvWBKaocPLywcleP8f8pyoB9WDYfOi4FN7wJc8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9834

S32G2 and S32G3 SoCs share the eDMAv3 module with i.MX SoCs, with some hardware
integration particularities.

S32G2/S32G3 includes two system eDMA instances based on v3 version, each of
them integrated with 2 DMAMUX blocks.
Another particularity of these SoCs is that the interrupts are shared between
channels as follows:
- DMA Channels 0-15 share the 'tx-0-15' interrupt
- DMA Channels 16-31 share the 'tx-16-31' interrupt
- all channels share the 'err' interrupt

Larisa Grigore (6):
  dmaengine: fsl-edma: select of_dma_xlate based on the dmamuxs presence
  dmaengine: fsl-edma: remove FSL_EDMA_DRV_SPLIT_REG check when parsing
    muxbase
  dt-bindings: dma: fsl-edma: add nxp,s32g2-edma compatible string
  dmaengine: fsl-edma: add support for S32G based platforms
  dmaengine: fsl-edma: read/write multiple registers in cyclic
    transactions
  upstream: add eDMAv3 support for S32G2/S32G3 SoCs

 .../devicetree/bindings/dma/fsl,edma.yaml     |  34 +++
 drivers/dma/fsl-edma-common.c                 |  36 +++-
 drivers/dma/fsl-edma-common.h                 |   3 +
 drivers/dma/fsl-edma-main.c                   | 115 +++++++++-
 outgoing/description                          |  12 ++
 outgoing/v2-0000-cover-letter.patch           |  42 ++++
 ...-edma-select-of_dma_xlate-based-on-t.patch |  39 ++++
 ...-edma-remove-FSL_EDMA_DRV_SPLIT_REG-.patch |  35 +++
 ...-edma-move-eDMAv2-related-registers-.patch | 199 +++++++++++++++++
 ...-edma-add-eDMAv3-registers-to-edma_r.patch | 104 +++++++++
 ...ma-fsl-edma-add-nxp-s32g2-edma-compa.patch |  83 ++++++++
 ...-edma-add-support-for-S32G-based-pla.patch | 200 ++++++++++++++++++
 ...-edma-wait-until-no-hardware-request.patch |  68 ++++++
 ...-edma-read-write-multiple-registers-.patch |  90 ++++++++
 14 files changed, 1045 insertions(+), 15 deletions(-)
 create mode 100644 outgoing/description
 create mode 100644 outgoing/v2-0000-cover-letter.patch
 create mode 100644 outgoing/v2-0001-dmaengine-fsl-edma-select-of_dma_xlate-based-on-t.patch
 create mode 100644 outgoing/v2-0002-dmaengine-fsl-edma-remove-FSL_EDMA_DRV_SPLIT_REG-.patch
 create mode 100644 outgoing/v2-0003-dmaengine-fsl-edma-move-eDMAv2-related-registers-.patch
 create mode 100644 outgoing/v2-0004-dmaengine-fsl-edma-add-eDMAv3-registers-to-edma_r.patch
 create mode 100644 outgoing/v2-0005-dt-bindings-dma-fsl-edma-add-nxp-s32g2-edma-compa.patch
 create mode 100644 outgoing/v2-0006-dmaengine-fsl-edma-add-support-for-S32G-based-pla.patch
 create mode 100644 outgoing/v2-0007-dmaengine-fsl-edma-wait-until-no-hardware-request.patch
 create mode 100644 outgoing/v2-0008-dmaengine-fsl-edma-read-write-multiple-registers-.patch

-- 
2.47.0


