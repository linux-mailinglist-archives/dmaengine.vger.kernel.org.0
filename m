Return-Path: <dmaengine+bounces-8286-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CBBD25A5A
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 17:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C248830D477A
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 16:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F223BF2EE;
	Thu, 15 Jan 2026 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eFTtQWpE"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968D83BC4FB;
	Thu, 15 Jan 2026 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493271; cv=fail; b=AqFx1jBuH2z8x0FT9xRWVCDfC0SofSxj/AlNqxe0OGqTqiMiHwymsEAmJf9JMetyx5+6g3Sy20xnQCCqrol5c3V0I3emqpHLCB3dlL5PwuUsIEvFLTWhzMd2yF1L3akBJXiJfxffaQkHR4twik3kfcbPro5emM/W/tnYtucNWyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493271; c=relaxed/simple;
	bh=mtWh9Hch5ipVRwCs5krrPrgeutiWaVDjxVDb7BqYxnM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aY9ew+aUlnBqpxnxTdOpsXEywtK4pGnlccGaolCdfxa5gLMsYk+P0HkPLdVDlmI9gV71oLRNfn+my+IGUa1RcZBqLK8plona7IEokYpqoUu8MfONngPQTC0yT+FMpHdR9oIJ+yiXDgyQktn9Fh6W5wzRUe9mSVA850783WGoB5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eFTtQWpE; arc=fail smtp.client-ip=52.101.69.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shJeSEaiZlQJCPdF79koHDhUFMwN4rkCKzp/7ARmznGsA2POIB+0l967co6d8egYCt+jix+6n+6U49s1xIng2UoJOp119QUw/0UyUWSEAaNXhyZzuzgrwGHNRT46x5sqasfKMPy/oqh3JsiF8Q5ERwf++612tsaFaNIxVElYSZ4NnB+W+Hj0j4HLyr1dcKEZ0kqWpmCP5yOKib95AqXCIiilgMH+ZII+0B/F3RcT1G+/xWvxJasM3xdvoY+DrgMGzdSqklNWdID7m8KXEUfOtLba9+4yzLpTqCkoIF80sGcpEO76j8ptOvwqXkwYTEOgbcojOppd/bWM/CBJ/02qow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GPckIE97hpzL4zQy9F1FrQQhqwyhIQD4NMx9ypn0h0=;
 b=wLHhf0+oKY3+qurjLEZMhVjJeu3vWMjHmK3cajQGeCO0L4SSerkyi1Iy+1Lo0m1ecZB61kbylGGLu4nCP8twnC6I/klTnDzkpAjaAj4f9lBFwMHnosokx2sLlLm1/OJPlTQQ9zj66fcB+shXTHknVfOIy4NYYgkyaseehJjB7A+9jcSw8sC3gtaxUizAJnOhMny7Oni92z5bQAJY1wqWzjr41w0YMx/WuKxAQMY2++toz107SUPN2sPzGPhk8HeIfykpxZQZXzASpgIYVILHZKJWqhEDrGVFFJTZp8Z1LyjrkkzD4SKUJfh0OEfi61IiYpp0ucT9ubicXrtbO7pHeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GPckIE97hpzL4zQy9F1FrQQhqwyhIQD4NMx9ypn0h0=;
 b=eFTtQWpEiy9+98W+gGZf9NQ9Y+CiLSeeQ5L2IipqbqM99YSm3JfpYM8qWZTLyEWlmFgyNMNUW+ZjJ4jbrpufntqN2QS7/6nR4DuutXN+HDZ12WzmkiaIFld80aR6wYtxJYW4GghiZkYej+TRgmpFoXo6HFBWQOScTc4arqLvLyBC49GOL1bCKOBy1OX/5ttOvqiFmS2AQIkDmogn/mVyEehGkZzPzrsurtQebJx42h9Bq2tcdEXpmerycq7zPR0cMK6/0nYiHSMr7u3ccKa9fB6CG8Ut0Wm/XXsKquVE9R/ppL5szAIASdpvY7QhPe9fkqEZ6e9DMwp4Fh2oL6abdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by DBBPR04MB7628.eurprd04.prod.outlook.com (2603:10a6:10:204::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 16:07:45 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Thu, 15 Jan 2026
 16:07:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 15 Jan 2026 11:06:51 -0500
Subject: [PATCH v2 12/13] dmaengine: fsl-edma: Use dev_err_probe() to
 simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-mxsdma-module-v2-12-0e1638939d03@nxp.com>
References: <20260115-mxsdma-module-v2-0-0e1638939d03@nxp.com>
In-Reply-To: <20260115-mxsdma-module-v2-0-0e1638939d03@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768493221; l=3281;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mtWh9Hch5ipVRwCs5krrPrgeutiWaVDjxVDb7BqYxnM=;
 b=oZMIryFsFFk0L5sAnHcRhgfKGwx0mWzQzPVUp3KuZAuRw5pm7gTRqKNKrP6PO2qS5pEmPix5H
 gcEBYh9/+z5BEFlZ0ZUc0ZZbi9JDowWLR2verl0KPDKjKdUZL7861Lf
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:510:339::15) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|DBBPR04MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: b178e75a-c1e6-4f14-5bcf-08de5450384a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SytWQVdrcEJZU0o5eUZCU3NsNHVMZXVQWDVFSUJXT3pIdzZmUzhma29zMmcw?=
 =?utf-8?B?ZjgxY1lsVWNlcHRmQ1Q2SGdhaTlCTmVNMnRUcWFJdGJkM3VBVU1FNFMvaUhx?=
 =?utf-8?B?ZzB0UGNBQUUxYkVyc21MVkFyV1hGSk1hb1FubzAvWVhCM2Q5QTB1ckl3SHRW?=
 =?utf-8?B?NjV4Qit0dUVnZHduemdmWkZORlVRblFudnFrMXE3TExJVEd2SjZWVnp0VUVl?=
 =?utf-8?B?R1dDb2VHOHR3RE5YcFNYZCtuK0U0WHB4bXc0cU9xUFdkeDU1bkNuSmRYejdo?=
 =?utf-8?B?VUNFWVR0NE5WeTVHdkFqTXcxQXZIa29yR2hOUlZ6TTY5S0l2dFZhWkdPdXlX?=
 =?utf-8?B?a0VoaHFOUmZ5U1E1UXVZOGRhR3IydGxOdzZ3VTFsSEVoVVdJQTRodEcxeXlO?=
 =?utf-8?B?czYyeGR5WWhuZlZCcUJkSkpUZ3BRbC9BbnJJNnlBTTFiNmkxMW5haHVFamtF?=
 =?utf-8?B?OUFoSGxSSnB6S3VwZG5kRS80VUlZZ0VudHA5ZVY5bUNmOXJkdU42bFlUL1hZ?=
 =?utf-8?B?akxTL1NOTGhpMlZhV21MOUgxS2lsYmMwU1ZFblJPMDZOY3NKV0NNcU5rLzEw?=
 =?utf-8?B?ZU1qK044R2tyYXRaVUNza005UXA3Qm55SUdrby96UTgvS0FwR2hwR2VwbnVm?=
 =?utf-8?B?V3ZFV0lSR2Vvb3F4cTNFKytHWi9tYklXZmVUbllVeDFjTzlyeGV0RVRncFFu?=
 =?utf-8?B?VlRmdU1VcFhhTHVhamFqZlFsaWkvTTFvalp1NFRhZ3BZallDdHFCbHExNis2?=
 =?utf-8?B?eE0xdTlha1pTblluSVhUYnlyRGFXeW5OWnRXUC9LRHlEejlGMmJFZU00Tm9j?=
 =?utf-8?B?UGZ0OEJBcCtZbzF2Q0c0Vk1uNFMzalhLbDFQVDlpNVV5NEE4dCt6SGVvQjhr?=
 =?utf-8?B?bnBlRFdlNmw0N25LUTUvcFBWWWpkMXNiUUp5eHRBNEZxVm5WQ2lsQmRhVkdv?=
 =?utf-8?B?NmZkUTV5RzJ5UnBBR2huZi90WWhYNzJpclo3ZXhMUTZBN3VHZTNCa29yVml6?=
 =?utf-8?B?eSttOHBxSW1ZQTJHNFIrTXkxV0Y4aUo4d2lNVDNXbGtoUVdEYkppM2ZzdWhN?=
 =?utf-8?B?NC9kSG9ZUU5MMlFLZ2NCT3lhZ1lSTEpHM2cvRW1nQjk3UmpYRVc3RkQwUjM3?=
 =?utf-8?B?V0tzLzVCU2x4dDFLV3JHdFVEVzA3bTRVaFg2V3o0eDBEbjRHa0ZIc2hLYWtm?=
 =?utf-8?B?RmJvV1ZyUUVlYjhvRnRhUzN5eThpcnFJLyt6SzNuVm0yaVNyOUxzS2g2VHBx?=
 =?utf-8?B?Z0ZkSDIwMm92ditwaG1OS2FvTFpvenI5WlNLNFQxVHFXL2NOWlhCdDUxaGlC?=
 =?utf-8?B?alp4NGtnb1pzdkhJcXpjT0hQZWJpRHR5MGNGS0E1M2pGTmM2SzVHM1hIKzFW?=
 =?utf-8?B?b1lpQnRKZHIwT085L0ZjWVV5eWxQZEV4YlMzQkhPdGF5T0ZiK3lRd3RkNmd2?=
 =?utf-8?B?TGNqNmxDdGdBTVZwMkxPTVRucEpOcTBqVlBhd1VkV2paYVRSZ2Z2WDRHbWow?=
 =?utf-8?B?bUUwaGVEc00xbm9vNW81dEc4Y2FqZzNZeVp2SDdZdFJ3V1VWbUt3bzhzV3ht?=
 =?utf-8?B?SFNWTE5KZlNFV2Y2SzJZVS9tUzBwaGpERlllNmh3K2FqZml2bVlBTkcvUW5L?=
 =?utf-8?B?M1RoazFMVTRLVkUrQ1NJdG5EUDdlK0tNdWxJUUZXOW9Ha3lKamkxMzlDUWFU?=
 =?utf-8?B?aER5bC9IOVNlQ2FmcXkxMTk0Um1YRzZqMldzRDVWNktqUyt5YUE3WitEYWVs?=
 =?utf-8?B?SlduQWVlN1hIOEV1T1lNN0lROEhzSU5QWHd5ZnlEMUdkZFM3cDJhcjVKVU5C?=
 =?utf-8?B?ZVovTzFzOU1EZjdXaTd2OWtLd05iYjhUV3VNVGhYSWhoRm9UYmxGc1JaNlBJ?=
 =?utf-8?B?bnNGK2IxU3BraFIxNXluVU1xVlNOQ0FOOUE4eEJNREZiQnZmK2dVbWhFUXo5?=
 =?utf-8?B?bDQ2eExsdkNoVXQ4RndDZ1NCTE41R05WZEFtNHVIOXhRWVNGVy90c3JTbGx4?=
 =?utf-8?B?b1MxRWRRZTd1cU9KNVlZUGxWYW5HSnB5aVkvZW4zUWt3blAyRE52UW5LTk5s?=
 =?utf-8?B?YzJZdXFpUzdOL2lpZEQ0cG1Pbk1GRy8rWFlNZi9oSUVpNjdkQ2cxL0dGSDFw?=
 =?utf-8?B?a2N4c3JsTSttRUYzNFdGUG1oOHEvM3hjaFRhN2NyN3h3N0lic1QyVWtMdHI0?=
 =?utf-8?Q?kl/CLYJuod0zELjLREAiMPI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rjh6b1dVcFF0U0pFT0Q2anRTalc1M0xaeUhlZUZHUmFnV09ic0lTRVNzLzRC?=
 =?utf-8?B?QVhkZUgzUHNUdVBxb1NqM29wOU5DZUw1RzhHdHEyK2lyMXpiVFNZSlJqVmo3?=
 =?utf-8?B?c21xaUdncGtncFlDR3NqVVFPenAvc2V2V3h1YlNmLzVoamRRSExpcklURVZH?=
 =?utf-8?B?NWFnT0lERm5UMSt4S1dXRHdEU3BCRUxpaUJhbGxCUEtZSzkwMGM4SC9jZVk3?=
 =?utf-8?B?R0ZtdzlaSG5YN2xNZkM2UmRreFFnWXgwMmxRVFJOZFZIcUZvMUN6Qm5Hd1Zz?=
 =?utf-8?B?MFFWRjdYK2x3WTRObFZzeWdoRWZiKzhZYW05bFlpQlVTV3hDZzVKNUdOaTZN?=
 =?utf-8?B?VU95Nk96R1JHOU5nb282aDNWbm95Q3hjdndrdlRnK09rd285dTU1M0tPWWxY?=
 =?utf-8?B?eTNRUUcreFpxRmp2Qm54NWFuY2VBY1F6bnN4dG9ZRm9FVHNxTVhCejRrUnh2?=
 =?utf-8?B?a2JZS0xDYmpFZUEyaVhKcU1PREg4UDZhM3hGOVRhWU1hcHhCTnVNTWZsQjRL?=
 =?utf-8?B?dk1kL1o2RWNnWXI5OFYxQjhWc09Pb2tGR1VrMC9BSEJOV1Z0L3VOUjhiZVBj?=
 =?utf-8?B?WGdFQ3krNnF6YWpQMmJuSmt5ZUlhcS9ucW9UcEdaV0lhQUw4M01KRllTWVBq?=
 =?utf-8?B?MHJjd1ZacnJvaElrU0xRU2ZNcWNXVmhQSkhxQ2EwVkNTWEt0SDdMVTF0a3ZQ?=
 =?utf-8?B?Z2FNUlh6eHRyUjdJcG10alloTzdwMnNoNWpPZnY2Z25nRnRZTlF5RHlGK241?=
 =?utf-8?B?ZUc2dFBnOUxCcERRUTJGRGY5S2w4ek9TNnd3b3p5V1VvdHNiZHBCdUpZZHpP?=
 =?utf-8?B?NlFjOXBOdDhpUmN2QlJrbkxhRzJpUEwyeXV4eGt5djZ5bzlWNjVaZVhaMVlV?=
 =?utf-8?B?QXJveEJIWkVBOFVjWTlZNldPc0tpbW1VL1NTVjA4QXlMTElvWERWd2J5TVdi?=
 =?utf-8?B?OEdaa3FSTVBraWtoNXRRMEV3Q2R6THBMNzF6WE5pV1JIU1d5Y1l5MngwT3VE?=
 =?utf-8?B?dDlIWVdoZm8wdHJBbktrSkhvcUhmMkhWQVJKNExMZC90YjUvdlliVTVxYlZz?=
 =?utf-8?B?SmxJa0RhdXRYYTBocmJPUnhYcmNRNXFjc1NnNTlpY0UyYTdTUGtxTkgrTkNj?=
 =?utf-8?B?dzFNbDdKWklKQ0RDVVJXaHRWUmFhRlpvSkxQS3UxZWRXUW5DRkZQazFiRXpO?=
 =?utf-8?B?RVM5YkJvOUY2WUowc1ZIRE1FbXpqeHhuYUdPUGQrMUJtUlZVZ1pSckZ0M2Fu?=
 =?utf-8?B?K3F1czN4YS9jNGluQlJQYVYwVlZIdTM3S3RrcHJaTTRvbnhRbE9qb1RjbHh1?=
 =?utf-8?B?SGlJL3RFVk1mc1lIT2Jmbk9UbnlpSThlSzhTMXd5dFNVTFVpb0xJdFdVcGg2?=
 =?utf-8?B?elNwakVZQnNaNHZqUzY1SWtEWnY2azFMZFZ3ckN4MnlYZFRYM2oyNEcvb0ZJ?=
 =?utf-8?B?ckt3NE92bUVuZnllTGR0M2N1Mjg1QlhIWXFOWkJlbUQvVlBJQmVzWkFHcFhs?=
 =?utf-8?B?b2d6SnBBTFlDWUk4YXNVK0JjV2JGWWx0NERlNjdPZ040ZUdPZHVuUmx6dEVF?=
 =?utf-8?B?MGlUTVowUC9WR1U4SS85VGVHc3plcUVYekpLTzYyTE5VRUs3TnBjQURxN3Ev?=
 =?utf-8?B?bWdWS3g5M0JrQlZvcWFzakZqTUVab2xQeHc5eGdaTHZ4TjRkeGR6bXFLcmI4?=
 =?utf-8?B?QXNGb3RLUVlaZVNFcGVyNjg1b0R2N0tleFhCRytwV09Cb2JnSkNyY1gyVmZx?=
 =?utf-8?B?ZEFtK200ZE03WVRzYlFkclJsbmdZRWlCNUdHQWhVR1IxV1pNVFVKZFQ2UGcr?=
 =?utf-8?B?R2d0ZzQvRWZEVDFkcEtCTU93bXVyTWFGbDVqZXVib1FONnRCME9tcTFzZU1K?=
 =?utf-8?B?OEJVK3ZqTmxLRVl5ZytLTlN1bWIzZ0pNN2NVeWR4V2d1Q3JIWWs3RSthWDdR?=
 =?utf-8?B?bnBCTUdvMUJVRHNuUDljaWIyeExXbllhWDhuYk5sblFEaEprMmE2aW9jT2R1?=
 =?utf-8?B?Ui9jL3Z5YkRycHh0b1dDTjBtS0ZmRlFKWmc1MEJFQVBaSm1jZitCY0dKMzlB?=
 =?utf-8?B?SW8va0FCZDNuTlgreUxoWXlwTEpZWXYzZjZ3dnZVZXhVR0g1NThtaWRGNGtJ?=
 =?utf-8?B?RWlRakJNeDdZVnJZWTRrZDVNVXIrZWd3dm5oQURzSUI5UHZWNkZ4MVBHbk5T?=
 =?utf-8?B?L2t0SUJ1YUZTMEpKbVFlQ25jRHVIeC9sZDhIemFUaktDMGQ0TjhrRnJldEw1?=
 =?utf-8?B?TGJpWk1UeUhTOXBzRXVhUDZ4dmNvQWNCR29QaXZpS290M2FPSnBlVzFsRkxr?=
 =?utf-8?B?alVNUExWS1AzMllQVkN3cHV2NnljTk5QNVdLNVdVUEVMQ1ExdW5xUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b178e75a-c1e6-4f14-5bcf-08de5450384a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 16:07:45.2657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5dwjASB2QtgCZIp2LIG7K4M1S/dllaryiPzMeisavfH/heRYi1uN4PwqZVFyeOAlhRCpmZBNYZIjnliFxKmkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7628

Use dev_err_probe() to simplify code.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 47 +++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index c0305fd2ec06c41dfa8396bad6bfc225fd3861f0..8804217facba7870a0a9973d99ff7264cfa2b59c 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -709,16 +709,14 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	int ret, i;
 
 	drvdata = device_get_match_data(&pdev->dev);
-	if (!drvdata) {
-		dev_err(&pdev->dev, "unable to find driver data\n");
-		return -EINVAL;
-	}
+	if (!drvdata)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "unable to find driver data\n");
 
 	ret = of_property_read_u32(np, "dma-channels", &chans);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't get dma-channels.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't get dma-channels.\n");
 
 	fsl_edma = devm_kzalloc(&pdev->dev, struct_size(fsl_edma, chans, chans),
 				GFP_KERNEL);
@@ -742,10 +740,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
 		fsl_edma->dmaclk = devm_clk_get_enabled(&pdev->dev, "dma");
-		if (IS_ERR(fsl_edma->dmaclk)) {
-			dev_err(&pdev->dev, "Missing DMA block clock.\n");
-			return PTR_ERR(fsl_edma->dmaclk);
-		}
+		if (IS_ERR(fsl_edma->dmaclk))
+			return dev_err_probe(&pdev->dev,
+					     PTR_ERR(fsl_edma->dmaclk),
+					     "Missing DMA block clock.\n");
 	}
 
 	ret = of_property_read_variable_u32_array(np, "dma-channel-mask", chan_mask, 1, 2);
@@ -769,11 +767,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 		sprintf(clkname, "dmamux%d", i);
 		fsl_edma->muxclk[i] = devm_clk_get_enabled(&pdev->dev, clkname);
-		if (IS_ERR(fsl_edma->muxclk[i])) {
-			dev_err(&pdev->dev, "Missing DMAMUX block clock.\n");
-			/* on error: disable all previously enabled clks */
-			return PTR_ERR(fsl_edma->muxclk[i]);
-		}
+		if (IS_ERR(fsl_edma->muxclk[i]))
+			return dev_err_probe(&pdev->dev,
+					     PTR_ERR(fsl_edma->muxclk[i]),
+					     "Missing DMAMUX block clock.\n");
 	}
 
 	fsl_edma->big_endian = of_property_read_bool(np, "big-endian");
@@ -883,20 +880,16 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, fsl_edma);
 
 	ret = dmaenginem_async_device_register(&fsl_edma->dma_dev);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"Can't register Freescale eDMA engine. (%d)\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't register Freescale eDMA engine.\n");
 
 	ret = devm_of_dma_controller_register(&pdev->dev, np,
 			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
 			fsl_edma);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't register Freescale eDMA of_dma.\n");
 
 	/* enable round robin arbitration */
 	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))

-- 
2.34.1


