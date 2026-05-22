Return-Path: <dmaengine+bounces-10762-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aItbFfy4EGqzcwYAu9opvQ
	(envelope-from <dmaengine+bounces-10762-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 22:13:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2F35B9EDD
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 22:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7B043010600
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 20:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42766377ED2;
	Fri, 22 May 2026 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GpESreRv"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AEB30EF90;
	Fri, 22 May 2026 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779480825; cv=fail; b=hSRbO6ovwAKP5WclBnL2YlIyiQQ7MKXpMMwK7Q3H9L1gGGiNDaw1sBCLUZ+YRgrY/9NT1wF8ufcvH43G75tXTqyjXiTiyLBHr/+Zf2thVP401YhsoSlfWEheHqrXbxxUx+tDOYi6ngtI7PbTbdJB1pG0zd7gXVm5eEoQ0J5SOpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779480825; c=relaxed/simple;
	bh=TTkJxxKTE83MS62V3KVeJbRtINkIYw+X24lQZxBW858=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=JKWcygL1H84lBsDa3K+7ik4t0ZpHXjYihZ6sGGbXupGvq0viz5cI3UoRcFXI/ozkJjZ/GsbVkxrD//A5aTYu0J9WGtXEFK7KQxZ6mGTtXtgZC0s/9/nMk7nLL3zuwzUXmVkxN0tcBx6Vl8WXlxMTAnOynRze706Nusc1PJdVMoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GpESreRv; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzfiWsyqKqEv825ifrh4OAiQpEZ4ira2ROS+idt3/pr9bi59o+heXGFp6fgYN7Uriem1z4TlxpPthDsITN5EklrwvNdu35KOEWxr9LMNoyErj86vNfB4Q8UAN2KDXF1k34C+NjBJWPcrGEmq50zBwSWewMt9wQvLQ2vXdR4rhNSgmm1JytwacrE0YXV3iV3kBKgsB4pPzmEB6PHwVcQg7zu4XMRSovMCcb2YtEHLkNIxBo79F+IGVvFBV6Y9gqbcy630Zw/88eBtS5BUP0km0zGwbqQNmAXSWBJC0ZeeQscoDFZGCRNmt4Am0f8pachMJya4DHTmEEFKbEP2eEiS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlRjswrjDFJ3aDV22+smxaYB33hXn8m4SpNRAf05P/E=;
 b=JklRMRIb+53xQ0erHrpT5z3RuSScHwX3yP/WrPZRJd+SNgv4jnuSxm1EaigxpoxUR5W6DTdO104Z9csWHHPyC8m9QWst+wpEPoFuE8rDOl9fP4BOGWzVE/rXvw4p/5as5wqzUL2LfRV+ExEOikodevAdD8XojnOLUzK99UyT/R8yJvynzsxndAoG8GblXrdRSFYEKiYe3G27cB8Tvearn3Nh6f4LsPH48Ovu8vZcZTahlgfhWryF/OPxaZT5FEgHATDDVg59bqzqXXyKbnJpUnU+GR7LFlk/wis8P7Swg0ioS1CwZA0k5IeYpRPljotjV9Kf207TgMRChW7BEtqDlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlRjswrjDFJ3aDV22+smxaYB33hXn8m4SpNRAf05P/E=;
 b=GpESreRvIDy4y9vOpTJvsakDs9N3CvnYeNlXdo8imgiXJheXSZTXZUEPBhjmgxfc1JHCY8exFdE1lfEU2G0YM888A8THzNXrFgJ1pjR2xuGArrn0BQxq8eFGaEj11Un/r6zbJYTUSXS1iaHht1BKOd7pPSTFv6e+6v1yPFwnv4G+6iwpWaSc2frVMg4fcHMNK3w4huD52DwjFLE1isyYOT5dUVrYUORlrKhRHjO5e52o7+Ug4L1hsAKQGNiWoXwNSKRVzBpkShPpzEUe+YpVrkpBoW8r5JTlSjOQwkOhSOSlIRAVvHWXHR8upLfChSRgZeW/dhswr0aFXJ2F5xRZ4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB11503.eurprd04.prod.outlook.com (2603:10a6:800:2c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 20:13:38 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 20:13:38 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH v2 0/2] dmaengine: add helper macro dmaengine_prep_submit()
Date: Fri, 22 May 2026 16:13:30 -0400
Message-Id: <20260522-dma_prep_submit-v2-0-7a87a5a29525@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOq4EGoC/3WNQQ7CIBREr9L8tRjARqkr72GahsLH/gXQQG1qG
 u4udu/yzWTe7JAxEWa4NzskXClTDBXkqQEz6fBCRrYySC6vXFw4s14Pc8J5yO/R08LMiNrcWmm
 xVVBXtXO0HcZnX3mivMT0OQ5W8Uv/u1bBOJOiU65D1SqnH2GbzyZ66EspXwby5NSsAAAA
X-Change-ID: 20260130-dma_prep_submit-cbeac742de48
To: Vinod Koul <vkoul@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, carlos.song@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779480813; l=3279;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=TTkJxxKTE83MS62V3KVeJbRtINkIYw+X24lQZxBW858=;
 b=s69zug+znTX3uN6heu4ztzMfcwJ97rSwTo0GcreXGP1T766rQK6JKB4bb857fhKGjz+ZwVx1Y
 qxc399UPOnKAvXbNvXbm+P1EzbjkR/90j2h1Xb5APl7IMgi5wbSlACz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB11503:EE_
X-MS-Office365-Filtering-Correlation-Id: f4eff776-04d9-4dbd-4b5b-08deb83e9c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	szfb5kPL+2gQBpSXz2yVSb+MrJDCBSFS41VLaHBYKR2856gjbMR2hVEb6ZAQZB/TEceJ1nKqiYn6vcB1tvWV9R3SyHrshWX3PePyt+Y1kaqdxppiRXanBR35ji8VEYj/inkOtBwBhBTWXo+v1ttyr/z7bQUl9OULrm2vm1eFnCpXBEZQMZYGU7PhGPeabcyze4c0YYrAs4APjVZIj9VOQ7AVCpsQpBs2VS3yk+g6E+0/cOjCDD1suWBRN5yONqXXEleNgeFAFg0ecLv9uifagItQdYQV/x8xIwRX9eNvxPIqXl0y21BXnpDvCHxN1KzuN3nTwGmoqumLv0CoyVwZwcYQuRKzKG4v1ErqPBll5OwtreOj9uhdFlG/FNkc1oLAan0YchkyXYC0AApODCDYHU5VRMvhiWMXH5Fe2sP6SX/Niw6DkGDT3S7mSXro6sibKs4qpW299W/LS8npPLrlOYB9r9pzmfy2Lih+KFvl/y3ifK1jjEdVB4Pf7QIao5t1vGQTLe5+seW9CF7hT3qpRpMJ8BZeKDVvGq01xy7OU3Ir22ai83wogRD/h9FZgEu7mNcATm352SCXKc0XHhbAiLefqyuaOXl8EmwMFf2h4/SPWiYPtvPrJpfuQLwV6tLtdONyuqx30dPNqdPPvdfcTaazvIBYAH4yW+B0XQyiOVK9nzTe1mELSdHUIba6o9rE8R5TUAuQNDcJtp7a5fB+oA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(56012099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3N6c1grRlFCMmMvTzhKUnFYeXphWXA4RDlMODQ4a0N3Q3laTjRRQ1U3RWNu?=
 =?utf-8?B?NktFK0h2eFJLYlhxME5PNzNmcHFBdTRCbzI2azJWcWZ2MzQwWnJUQmc5djZw?=
 =?utf-8?B?cnJYZnh3SHB4b2FVSVM0S0lVa2JYdXpaWG4xd2ZrOEJCcVNZWmpWeE84MDJ5?=
 =?utf-8?B?VGYvZlA4UW9JRmVROUEvanJXd0J5SXM3NWNzVEM4elVlZHBUOFNWVzQxY1dW?=
 =?utf-8?B?TkV0RU5YelRCUEFJbDYzR2NzcWNDbExNekpSQlJEQXkxNUNmdWNNT1BxRERX?=
 =?utf-8?B?ZjVmU09yWlljWEliYTJ3QnJ4YXVGU2VwaUNCQUF3WTVYbGV6VTRHckJBR3Zt?=
 =?utf-8?B?bmpSeG96TFl6S2NHdll1dWx0SW1DQ0xqVXd0eXRvZCtUdkFyV3pZNXN2Zzli?=
 =?utf-8?B?MjhmdEM4d1FiYlJyaDJsTkdNNVZzK1dscThtL1hiYmg3SzBnMXNRNUE0TkRZ?=
 =?utf-8?B?TDVXNkk2UU54U2xRR1JJVnVSeS9FVHAyNytjSXRvZ0dBZHZPdTYzdmpxQ29W?=
 =?utf-8?B?Q0VmckZzTWJYWUF5SVZ1WDB4U09Hc2xCTGlZT3NETHNDZWtCbWpRVXZmSEhP?=
 =?utf-8?B?aVU5NC9IYlpqVHJYK0R4bXdvczdRVGxDdnp1S2xDY2pJNWtwSEpaYVdNQStL?=
 =?utf-8?B?T2hhdUNBbmduTmZQQVBjMnpaQ0lxb3dRemltS0JzeGNTblBkemI0Q25SMk1C?=
 =?utf-8?B?SENVRG5oSmVLQTg4azRRbWx3L0YxZnpNQ24wQW1ENTY3dmkwOWJweE1IYVNH?=
 =?utf-8?B?c21iSUVQTkx5dXRuWnNrVE5LL1BlWFlXVDNNUytrSlhZOE12eUNzV1o0Ymdo?=
 =?utf-8?B?U21FMThDUU9Vb2FUdFhjRlg2SEpUeHVwOUpxcTZFN1pyOGZYaVFoVkpUUERH?=
 =?utf-8?B?QkJ0NVROcEZZQ2pvNnphNU9JNTN1SjBqZmZoeXFNWFFqdWRlcmlnT1JWaVRK?=
 =?utf-8?B?OWFCMXBoQy81NlNSYkJUdnNSZCs0MldHMXkvRnVrbnQ2blpTc0JDODl1a1Bv?=
 =?utf-8?B?Zk1WTjF3YXptdWZ0SFAwclIvY0xId2VRbVR0b0IvWWNLT0RzZk5XWWxWUmtQ?=
 =?utf-8?B?ZWxzZSswUUVsRUJiMDdjSTdRZGZGWHVoam4ycUNsOWIwYndwbXRhbTRPS0JX?=
 =?utf-8?B?TzR5bDFzVEY0eC9PeUQzUjRwZUJrdk5SU0d1Mjh4ZWFQQ2xMT0JIeHhJQkkr?=
 =?utf-8?B?bC9rSGszTDQ1cTVEbjZWQUhhempQRDRIZ0htUE5FNnZETTNodnp6OG85VmJV?=
 =?utf-8?B?QzRKOXMwYjBJZ3MwalU1UmRaSDFnZ1p2WktwMnhwV3BaQ1B6MStlQjhadHBX?=
 =?utf-8?B?QTUvcjNNOUtKQ1NYKzhJbHFjVTZURE0rUkE1QmhLS29WVEJtWXVTczZySCtS?=
 =?utf-8?B?UVovNUJZQXFqUzU2bjRpVUFjWjVqWldNRWpwVGx1V1dCUDAwY3V4TUw3WFd3?=
 =?utf-8?B?Q3pzcDgweS9maU1zY0IrQ3Zuc09FVll0aDVBMnJjZGQvTHp0emFya0NiU3F1?=
 =?utf-8?B?NStoUTc5L2hlSFRGeVhOZVRVSFA2Y2VzWFpVYURyMW9LZksrMzZES1k1ZW1J?=
 =?utf-8?B?M1JwQVRNdEx6OEtXaHZRRWljSmpUTFFSd3RLZzlQdTlZcERyUmE1SVBURGdx?=
 =?utf-8?B?K0dSL0UzNFdCa2lFWUdaVUora0RpMHJNd0I1ZlZrRUowdHFwUm9Dc2RLK3pU?=
 =?utf-8?B?TEZ4MkxIb0wxRmZOTm41bjE0M0NId05NVmdqU2VJbHVXSnRZaC9OaWFHMlRi?=
 =?utf-8?B?WlErSDNnSFEvZEtpclc0UjI2RS9qNktIMmdtVDFaWWR5N3FJTlVZREhZbVN5?=
 =?utf-8?B?elc3ZG5KcW5FelhNMVlJeE04MkhmUHh3Q01BSkpHUTdXVFZhV2dVZTh0N0pN?=
 =?utf-8?B?LzZNRSs5OGNraERqcEd4SUpKRzUwOXBsVXNMaGpibGlEaVUwdGxJQ1V2d0NB?=
 =?utf-8?B?MnNjQVRsTUdRYmtKR0gyQUVoR3FnUHlTTjhqMnByNEJmVWN5dUpUN1BuN3FP?=
 =?utf-8?B?bWk1VkgwQXp4SW9xSGVNTVpSdHNKTllDNjJLV3REaGIrZVV1dEQxZnRDbUZ1?=
 =?utf-8?B?Y1QyMHBXdXRzMEprN1hsaGNwV1FySjlsU1cxTklMK1VRanJFc01GMDcrUW13?=
 =?utf-8?B?VkMrT2pmNEFOcnprZjFkaStFM2RDNWxIL2tkaXdjTVZuRnNUdVN6alpPdUMy?=
 =?utf-8?B?RUc4UWdnVWVPSWg4UllJUHZBZlBHWkxHRzBoc0d1enIwbVcwWGdJdlptZWd2?=
 =?utf-8?B?V2cxRFBpaDRTc1JyYk9GT1Q3anBHZzVHSmV4UEdMcmFtQWlBbzl5enJOc2tH?=
 =?utf-8?B?TWRRUlBzTFEzTzE1S2VpL2lvRmxEcHBCT1BOczczVHdWbkJaZ2NoVzQ4Q3U5?=
 =?utf-8?Q?ZXuRg98bwADoMBirjypgEx4j5YtJag76nZJne?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4eff776-04d9-4dbd-4b5b-08deb83e9c53
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 20:13:38.5224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brlOU8F7PA305N4r85hQHThWbIBvxOD9Snm1aJqXS9cbbiV0e/0MlDAZg++tkKPZpmb5ERFTx4lUDJJEF3Zv1t30JaaCWaFmuf4uhtHCcmj0CACTI4Vq+4M5DNJKoDLa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11503
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10762-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DF2F35B9EDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add helper macro dmaengine_prep_submit() to combine prep and submit to
one call.

Pervious try to use cleanup
https://lore.kernel.org/dmaengine/20251002-dma_chan_free-v1-0-4dbf116c2b19@nxp.com/

It is not simple enough and easy missing retain_and_null_ptr() at success
path.

struct dma_async_tx_descriptor *rx_cmd_desc __free(dma_async_tx_descriptor) = NULL;
        ...
        cookie = dmaengine_submit(rx_cmd_desc);
        if (dma_submit_error(cookie))
                return dma_submit_error(cookie);
        ...
        retain_and_null_ptr(rx_cmd_desc);
}

So create help macro to combine prep and submit by one call.
patch 2.

 static int lpi2c_dma_rx_cmd_submit(struct lpi2c_imx_struct *lpi2c_imx)
 {
-       struct dma_async_tx_descriptor *rx_cmd_desc;
        struct lpi2c_imx_dma *dma = lpi2c_imx->dma;
        struct dma_chan *txchan = dma->chan_tx;
        dma_cookie_t cookie;
@@ -761,15 +760,10 @@ static int lpi2c_dma_rx_cmd_submit(struct lpi2c_imx_struct *lpi2c_imx)
                return -EINVAL;
        }

-       rx_cmd_desc = dmaengine_prep_slave_single(txchan, dma->dma_tx_addr,
-                                                 dma->rx_cmd_buf_len, DMA_MEM_TO_DEV,
-                                                 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-       if (!rx_cmd_desc) {
-               dev_err(&lpi2c_imx->adapter.dev, "DMA prep slave sg failed, use pio\n");
-               goto desc_prepare_err_exit;
-       }
-
-       cookie = dmaengine_submit(rx_cmd_desc);
+       cookie = dmaengine_prep_submit(txchan, NULL, NULL, slave_single,
+                                      dma->dma_tx_addr,
+                                      dma->rx_cmd_buf_len, DMA_MEM_TO_DEV,
+                                      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
        if (dma_submit_error(cookie)) {
                dev_err(&lpi2c_imx->adapter.dev, "submitting DMA failed, use pio\n");
                goto submit_err_exit;
@@ -779,15 +773,9 @@ static int lpi2c_dma_rx_cmd_submit(struct lpi2c_imx_struct *lpi2c_imx)

        return 0;

-desc_prepare_err_exit:
-       dma_unmap_single(txchan->device->dev, dma->dma_tx_addr,
-                        dma->rx_cmd_buf_len, DMA_TO_DEVICE);
-       return -EINVAL;
-
 submit_err_exit:
        dma_unmap_single(txchan->device->dev, dma->dma_tx_addr,
                         dma->rx_cmd_buf_len, DMA_TO_DEVICE);
-       dmaengine_desc_free(rx_cmd_desc);
        return -EINVAL;
 }

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- use API dmaengine_prep_submit_slave_single()
- Link to v1: https://lore.kernel.org/r/20260130-dma_prep_submit-v1-0-2198f9e848fa@nxp.com

---
Frank Li (2):
      dmaengine: Add helper dmaengine_prep_submit_slave_single()
      i2c: imx-lpi2c: use dmaengine_prep_submit() to simple code

 drivers/dma/dmaengine.c            | 28 ++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-imx-lpi2c.c | 21 +++++----------------
 include/linux/dmaengine.h          | 17 +++++++++++++++++
 3 files changed, 50 insertions(+), 16 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260130-dma_prep_submit-cbeac742de48

Best regards,
--  
Frank Li <Frank.Li@nxp.com>


