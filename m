Return-Path: <dmaengine+bounces-10685-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI7dHKg5D2otIAYAu9opvQ
	(envelope-from <dmaengine+bounces-10685-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:58:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E21EE5A9BD8
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C607A3628264
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4DB368D4A;
	Thu, 21 May 2026 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hvH/QdKD"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013038.outbound.protection.outlook.com [52.101.72.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018F1368958;
	Thu, 21 May 2026 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377623; cv=fail; b=STAez1X5FLLpyFEUbL3Hbh/KBCjNNwp2szVW1RMcQbgQyK67rx120NUDwedeM7j4Xilj38402urEqM8/JGtHbDv8CALcTCEMZaH32zNPjp5bI6edf0afgnaesPCCXKuW989tc867LY/h23/3ANsrBQtuZRk+pzcn3eyE+F7zdEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377623; c=relaxed/simple;
	bh=o4DDDSzLztOwfYwsjBOrFT9GqTVKUqh8B0q6PGNnTaw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jXMvf4ZB8nK568kewvurlfQH7RtKlRKxusUdQEJbBvT5C78r4AbeNzE802fNObx2BRyguankpXPz9f/t0Rwjz/DEnPYpMmt30Mi9iAGMZqGYevdYs1JYddbm91fGgWqlGhrYOThvKi0+Lx9VdCQmOKHH6U5YXJUPVsTuC3ZySoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hvH/QdKD; arc=fail smtp.client-ip=52.101.72.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZFV9C4gGLbULbvztSruFonFzSy3Hk2tZM6PFw39aHVn7O2bwBZSddtygjEXUmiGmGAUMp/GiveBlJ+HZrXngOFWTqTZCEzV4JNcnPFF6pKS/jMXIUiK2eud9lUFkM3FhZMDkQDMqkqZ3ldq0D0Z84LFvqKUSEoykMPkQuenWvXuz3bupE+vXyG0GswfoaSFp7902TbV2AJt3WGs5QY9TgcSRuIkIxJ4FEoJIRjhtZy7YyvxbznkkZB0GsQmfXykMDWJEkYOo9iOIty72zd32CBrSVVIedtbRWfam76+1caX3xghzZGdex3A1MBpGUpSX7uWu6c/bhyexNf2LgpkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnIdGNHqiocEltmZilMsapPodAqOlnYNHMwi5ucR1+g=;
 b=fPEENx6QbXP27NCEoQn0+mQ0LHHYIh0/AnHFtw9cgX4YAz28UFFEXU9DR6MCfbvSqbt9ZXIirWpq6ANUlDnIRbTyO0qFOPm0oPkRxL8Y56VV7ItzXHjvGfPkDZ5TEjCpHqHQQyWqVKTE/3JzTc3/dGrYh5sIRH5fu2RC72nnk7GxjDYB9xHqZIvJgw/i86BQ3FOtXjafXcDqvCqM1bjEJpujvj9PJTksi7Uh/HnCeaixp+K7M8aM/goTkSUyU+UJ2ArGyVfWqfzUiCM3xMVVTSmTHfUhl/hZBNrSe7M0mwp8zCcZq1VZtONJQoi+lKqxUPMXcvZXXuFVu38Eaa3XnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnIdGNHqiocEltmZilMsapPodAqOlnYNHMwi5ucR1+g=;
 b=hvH/QdKDq/XAPh7WY+OwHREqLm4AwOcUBJm/m0cr60QquugxdNi7rWFdFi50fLc9I4Vw2bo5XKC8Pt5oWx0mv5AF/RqpS648KAle9QN7vMFNxIFBL84Yx3+pk/nGHGbOMpuau/hidoIHGLxj3DvY+An4hxIK5PE8OnPdzcRZHBtIV5Lois+fsBH3WtPCvY75SwlQbepaOTSe9BvNIMDvb6pJYW5edVQNfor2YiOF5abYfiJHf9NFcXU5p4r9/I4uw2Rt6VjGv5hii5Oufp4ZRRjq/IPDRiHIw2baknzXhJ6YwQOY0UQE3VhgTdZCRCNgkL4JwAqAw+XK0w+PhAssmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AS1PR04MB9654.eurprd04.prod.outlook.com (2603:10a6:20b:476::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 15:33:36 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 15:33:35 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 21 May 2026 11:32:53 -0400
Subject: [PATCH v7 7/9] nvmet: pci-epf: Use
 dmaengine_prep_config_single_safe() API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-dma_prep_config-v7-7-1f73f4899883@nxp.com>
References: <20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com>
In-Reply-To: <20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779377571; l=3642;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=p0avzyaZ0rF1zdTLEWhOo1gsMmR8mWj4gAVj36s7c+M=;
 b=MDXLOumLXEQ/0a8a8ARtMLqIVTTbMB7oKrsLwe/Js2iPi4R+6V8auUBN5SaKpE3lvMBAzmyOi
 q9/rGz93kG+BKZCa6usCNv49lF1OAWotVjlQu/5QQurCX+Z+6luDOYu
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P221CA0034.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::11) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AS1PR04MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9e12eb-e37a-4b1e-0f07-08deb74e52cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|921020|18002099003|56012099003|11063799006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	0Oo01CcMs/12RWK54h8qCRqVTacu92v9x86At+UeqmC+vpZ4pyUSvntHbUv664R/O2BTrmwRP1kICwzEaM+VeWmBb4NeaYT0FmAE2jOhgwzDP145HU0zXJE85+Z9l6KfZjiZ+ADDnMBGsRvdT6pOII4u64sPWkP3kzX/+w+eQjDvyVD91ntpodeX6x2NTM9tMtR54FU36jeH5GtnVNwJ1f7iFDjMUtIcMqvSF2KVRHdogBOSIskWOvi7VK8V0xdoenPnmRohqr9QV9PeOplEaxR37elj/Lu+NtVPvgLEejzABVfV4L/8h1f01J/109BV5Gj/KJTV0zL4OXuBdQOBkKRvS7D5NneZtoONLc4O81aXTqqgdyqxnpps5GRRDSHQYxSOMhwYOHtAycuvQLd6LL/n0ba+pVW2n2TSoO8T8kwep8sk8Gxd4hnUKvaDmBO7ksiw/gktzV7YLOn8c/AuieTHs8oCo5L39tBTTXZD4s+fKraiZoKvhkLRpRxQqGsgVsl0S6POXLsuPKfKjnGspHkXOnztQMDuQxzamRDJ8SunskGCIbwa/KcNNZ2y5+HhM4F4Yw22zHEnLo0DkSuy/Bc7XTj4iYmT7fT0w/iEtZAcoa1wX/ZFE2zRxc5V8i8O7P5P+y99qkIy1RYBohGAXuhNhqNG3FhCtTf0A6sWlY8ShstX3rlcm9LtbV5JIvIhI+xkwkCMG7/wCGAgcjL7qQulc7fl1KxDWdUebI4wW/I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(921020)(18002099003)(56012099003)(11063799006)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0NCbkR4a0JZK1FSdGxmU2ljRWUyMm5Xd29yakhUUEZneUFzV3dncDhqVGdG?=
 =?utf-8?B?SC93aWhvMFNIVjJMa1ZGTEEyMW1NRkhZclJiQTlUTVh4UW1BM284enJLTUgz?=
 =?utf-8?B?b3pzeEl5TWZEKzZxQXZrbjd0WEZxdjlvZGxEalI0T0NoQWI0RGNrZkdTTHRL?=
 =?utf-8?B?QmpURmJuTnlscUQrdFgrYjV4U2EyMUg0K1VkSytrdk9FUlROWlh1V1V0Q25u?=
 =?utf-8?B?SzlsYjlNTFA0dTVON1pGWGlPSkNRbUZxeXNyWTNKMUhFb2FtemJ1SmhmNzNE?=
 =?utf-8?B?M095MXo0Q01aNlh4cmZXSVBQZzR5b0FvNjlub3JUY016N24vdGtpbDkyVXpr?=
 =?utf-8?B?ekthc1lnSFZLT2hydUtoOUZhaWJkbXNRcDg2TXArS1V1RlQ2bWJ6TStyQlo1?=
 =?utf-8?B?bU1sT2ZDRkQwSHhUNWsrRm9DTHQ1L0VpMXhRTENZLzNwdFhxTU52bHh5Nkg2?=
 =?utf-8?B?cU1NeUMzVzFGQ1c0d0JhMlJFRENwaCtvZlJrYjB0QUtxeTF5dHE4bzlUZXhw?=
 =?utf-8?B?bjZqWjdsUkJVRGtOVDdkc3NqL2docGRtWlVlcVBLd2NWNUFVUE03cUloRWRQ?=
 =?utf-8?B?SmdJTHhuUXFzbk5KUjlIbjROS2ZpZWdUSEN2aGQzcXF1dmI5aUlYRHEvUjNn?=
 =?utf-8?B?cy81TDJWZmFiVjhPWHJRUnhpZGpKSnJ6UStCc1k5V1g4bmhya1R1ZUJzdXQw?=
 =?utf-8?B?Q0NZcS9wVDM1bWcvTy8vZ2xnY0tsWklVRXVTQ1pXbzNWWmRpeXZvMUhhTTBr?=
 =?utf-8?B?T0lHTzYxczNZYlVrNGJHdGw5SnJNT0NoQzFTZVZRaEJEcDJwZVh6Q0hnRXZK?=
 =?utf-8?B?NWNtV3VMcGEvTW1rZEVneFN4b1JNOWpxZFBrY3RjNHE1M00wajM2SG1tSVdP?=
 =?utf-8?B?L3lmU3UvTnoxdGxjQ3QwVjVzWTRLdS9RYXRGQTBKN3J2SklxRW9RUEw3cDht?=
 =?utf-8?B?ZjF5R0k5bTB1ZFNQcmt3VXJ4QXF3TmNpMC80emhHeTRMS2xtemdrOGs2ZTJR?=
 =?utf-8?B?TERBbmk1RndxSXEybzlycjY2TzNkem1HSERDZ3NuZ2tjV1pIbnoySGwvMitu?=
 =?utf-8?B?QXBROW1qejdaU1h3eFdSaEZzVzBKbllUeDdMSzdsalExbDIrbXhTZmJJZTUx?=
 =?utf-8?B?VStJVzByUFd3SmhHL2hnK2Z3Z1VNQlRVSm9BUjBTNlEzd1RTcU5IaXZadDB0?=
 =?utf-8?B?SlNiaC9SalJOMHBYWmNOaTMySXV5MjVHU0xyQlFzUDJweE1mMkhDZFFkaE9M?=
 =?utf-8?B?WStaU2xndjlRYzUzd2NXbnA1cEFPT1d0UEUrbGNJa08xMjFRdllpblFJRlFN?=
 =?utf-8?B?THhaOWtpcEZkUE9meU1mand5WWJmTlBDOFdLN21HTEhiajNkNXVROFNUVUpZ?=
 =?utf-8?B?enptd29peVBNTUxUUUlaN2I2NXN0cFA0TFVjSUxSVHNjWmQ0M2xXTGVRTFo4?=
 =?utf-8?B?eE1Ya2VBRm1wQ2VIN3NsY0s1TTNkbStkT25YNUFkbEJQTDRZMGM0bnVCcUxT?=
 =?utf-8?B?M0FMM1pCYWtLaXgyYXFyc1hoNUUrWll4aTRiaUc4Sitlek1tcU5zMTQ1R2pR?=
 =?utf-8?B?ek9VMytjRlRHWHY2RWRFa2xCWlJxelRkM1pjV3FJcStqYjFzMUwyNmpUZTRh?=
 =?utf-8?B?d2xsUFJHL3RrWmhUdkhsUFVTYk1VWStsdG9XUXBFbVlqT2FIbk9CVzdQQnBD?=
 =?utf-8?B?NDlKM0pHMzRiTXFKOXh0WWhDWFJqVnBaYVAxRGJFYTBKVkdyY2Y4RElXcWhh?=
 =?utf-8?B?S21FcXBoaEJsRlZ1OFlWZWxXZ1RXU0xDeklXTVVtdUs5b3JaNlZDU1N0N3Bq?=
 =?utf-8?B?dEpiOVdBVFNIRjFKbE1JVnFaVUNzMWlVTUV0aXkzbmJDSEo1VWk5WlArdHJH?=
 =?utf-8?B?Q3FFbVFLaENoVVY3WGlPRzk0S1dqTzJteFk5OHdKd0JteVZXT1dpT3QvbHFD?=
 =?utf-8?B?Wm9ZZXhOb081bHJ0bW40VmRvWDNLL0gySTUzcldvdkhqdWsvNlhXZExzaStx?=
 =?utf-8?B?WjZzZEE1R3FrL3l1R0s4NGZPaTFaQ1JJaHJoejZHWlhJQ3J6ejM5bzNYbkxV?=
 =?utf-8?B?U1ZwalFxb1JHKy83QmN5MHhWOXgydGdhaERJLzhkSGd2OFFsWmJoY05EbmxW?=
 =?utf-8?B?TnJWWkNiUDJaU1R6am1vSG52bUFDZ2puNVlhampPRk1PaWxyZk91MXo0Y2NS?=
 =?utf-8?B?a3g2NUhUWWQyakN1emdEU0hHWFMvWHVDbnMyYUFHY1hxKzFLWXR3RlVURkZG?=
 =?utf-8?B?a0drMnFJLzhLT3E3OUpQU2lsSXhDVnlaQVFBckRBQnV5WCt6VGFRdno4QVJH?=
 =?utf-8?B?OVFzOFZNTWdUUFdUbTBJTE12UWVIdFdRa21qWUVqYjlyTzUrdlJENVJLcXhv?=
 =?utf-8?Q?D5NJjL/TIInSyjFm3uWm+m8a5jURqqIFyxr7N?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9e12eb-e37a-4b1e-0f07-08deb74e52cd
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 15:33:35.8655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /RZhP+UhWtV7hbxHB/8rH3YHPhN3AgDTArSHkx/mkcxiwHZrm87VP1gp8wl5KC/Fz6TcIfJgu/yu78CqdRigSYdWTjj2kw3/BX+RI6aOA/9E5lHfnW506gBm96JviflQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9654
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10685-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E21EE5A9BD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Li <Frank.Li@nxp.com>

Use the new dmaengine_prep_config_single_safe() API to combine the
configuration and descriptor preparation into a single call.

Since dmaengine_prep_config_single_safe() performs the configuration and
preparation atomically and the mutex can be removed.

Tested-by: Niklas Cassel <cassel@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v7
- remove dma_(rx|tx)_lock totally (sashika AI)
change in v6
- remove local unused variable lock (sashika AI)
---
 drivers/nvme/target/pci-epf.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 2afe8f4d0e461..b1ba2d0bea6d9 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -210,9 +210,7 @@ struct nvmet_pci_epf {
 
 	bool				dma_enabled;
 	struct dma_chan			*dma_tx_chan;
-	struct mutex			dma_tx_lock;
 	struct dma_chan			*dma_rx_chan;
-	struct mutex			dma_rx_lock;
 
 	struct mutex			mmio_lock;
 
@@ -295,9 +293,6 @@ static void nvmet_pci_epf_init_dma(struct nvmet_pci_epf *nvme_epf)
 	struct dma_chan *chan;
 	dma_cap_mask_t mask;
 
-	mutex_init(&nvme_epf->dma_rx_lock);
-	mutex_init(&nvme_epf->dma_tx_lock);
-
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
@@ -336,8 +331,6 @@ static void nvmet_pci_epf_init_dma(struct nvmet_pci_epf *nvme_epf)
 	nvme_epf->dma_rx_chan = NULL;
 
 out_dma_no_rx:
-	mutex_destroy(&nvme_epf->dma_rx_lock);
-	mutex_destroy(&nvme_epf->dma_tx_lock);
 	nvme_epf->dma_enabled = false;
 
 	dev_info(&epf->dev, "DMA not supported, falling back to MMIO\n");
@@ -352,8 +345,6 @@ static void nvmet_pci_epf_deinit_dma(struct nvmet_pci_epf *nvme_epf)
 	nvme_epf->dma_tx_chan = NULL;
 	dma_release_channel(nvme_epf->dma_rx_chan);
 	nvme_epf->dma_rx_chan = NULL;
-	mutex_destroy(&nvme_epf->dma_rx_lock);
-	mutex_destroy(&nvme_epf->dma_tx_lock);
 	nvme_epf->dma_enabled = false;
 }
 
@@ -368,18 +359,15 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 	struct dma_chan *chan;
 	dma_cookie_t cookie;
 	dma_addr_t dma_addr;
-	struct mutex *lock;
 	int ret;
 
 	switch (dir) {
 	case DMA_FROM_DEVICE:
-		lock = &nvme_epf->dma_rx_lock;
 		chan = nvme_epf->dma_rx_chan;
 		sconf.direction = DMA_DEV_TO_MEM;
 		sconf.src_addr = seg->pci_addr;
 		break;
 	case DMA_TO_DEVICE:
-		lock = &nvme_epf->dma_tx_lock;
 		chan = nvme_epf->dma_tx_chan;
 		sconf.direction = DMA_MEM_TO_DEV;
 		sconf.dst_addr = seg->pci_addr;
@@ -388,22 +376,15 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 		return -EINVAL;
 	}
 
-	mutex_lock(lock);
-
 	dma_dev = dmaengine_get_dma_device(chan);
 	dma_addr = dma_map_single(dma_dev, seg->buf, seg->length, dir);
 	ret = dma_mapping_error(dma_dev, dma_addr);
 	if (ret)
-		goto unlock;
-
-	ret = dmaengine_slave_config(chan, &sconf);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto unmap;
-	}
+		return ret;
 
-	desc = dmaengine_prep_slave_single(chan, dma_addr, seg->length,
-					   sconf.direction, DMA_CTRL_ACK);
+	desc = dmaengine_prep_config_single_safe(chan, dma_addr, seg->length,
+						 sconf.direction,
+						 DMA_CTRL_ACK, &sconf);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -426,9 +407,6 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 unmap:
 	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
 
-unlock:
-	mutex_unlock(lock);
-
 	return ret;
 }
 

-- 
2.43.0


