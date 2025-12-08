Return-Path: <dmaengine+bounces-7539-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82971CADD8E
	for <lists+dmaengine@lfdr.de>; Mon, 08 Dec 2025 18:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0758930CFC3F
	for <lists+dmaengine@lfdr.de>; Mon,  8 Dec 2025 17:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72452D94B5;
	Mon,  8 Dec 2025 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Soatled9"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013005.outbound.protection.outlook.com [52.101.83.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16D628CF50;
	Mon,  8 Dec 2025 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765213843; cv=fail; b=gMNHBL3Shx5FvgSBa5f3NypWqENPuu5Ov0ugEurxnshhcqsThJH16rae2tz48tpW8A6671HSiBbGYHWmB9hI4fUcxI2fNtA5Qsf2XX3KdEZCQ5cOhE1rlCuOBEpATG7mZ0uVkqU6PkMeiTYsC41kahLHdvyf7an6dnUuk6LryAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765213843; c=relaxed/simple;
	bh=EwqEIPJgHF7NC9qDG/X8Xk08rImBkoWATPL7s0dkX4o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ABQpPrN80judoT+mZPYo2vOgywYSNT4cQ99LTcmN6TyouobighXyglU0hsJ1ESZQ+tS34ffaGPnQYy5ROuQ9X10CauZ9AHPNZec7ZptdtEh3W6kmi9cmRYImuHSZNuJyArm9Bav2B65QaJzKvUuUuf3ad6cKIEydGLXMHOKA65E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Soatled9; arc=fail smtp.client-ip=52.101.83.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBfjqqnqFyqFip8Mxkt9aDXubfcyqVVxrC0kaqCujrQOi+NLd1fJ14VunQktuGDKD7claO3M1DTDEbQnnU0mH6knCxwBkvWBQtD9Rwx3hAesgmCAfWLlIvpPqI5EVNj+S+u99EIMQ2Cm+R+dYpATiRvE7VlCQm6384YpZVs2znVwpNfXBwD4UFpUYVEj8YgJqrLORmXR82VIUG1/qmnfg7gNIU86OY0HmCgd0A9C3GlB5dDnTYR4J2t3LbdEzvMN6OeLA0FfxFCRsfQb44+kg6UhGXZp2LPGM/hVQt7WcASCU5Fw6q8ys8MeNEaBe2SlMd6f0302fd6ctNgFznRTQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OF0NPTzno8P0i/09UAP4yGbxWYgyYeu5gICzVn963g=;
 b=TIJqywRZaKmLh3CKUSF3kDIqWcQA1izA1Difbg4O7NOC85LORqYulBgnKWZV9Jicfl20bgeWqyDKHfqzdjDG5Su0Gx4yTUwo9+r6eNHzYN/IizdP6wdNSaG8w+zX4jbRwm8QFBjtWAUPmEZWBQfrd64m98QbqoYIWj9pXqNZrXuGViVlGj3ZSQXDBoCdmV6htxF32D6NQReBy90C7lALyVbaix68Xk21XXKyXp64KBTNkt+/ADt3BVA/SCWW9O3XFWU4FmgDQjiwAZ9liMErwbKe8UwVgV08yJbJz9aexXzq+KI5D2r5JApVTzdbzTfSktIv8AT/lG9M48CtgALVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OF0NPTzno8P0i/09UAP4yGbxWYgyYeu5gICzVn963g=;
 b=Soatled9d0EyoeRApum1mRjbel9oY4I/57OijHOv3kaSEpdv2JYt2xaoqvPcHim/3q0D1Q1MhgiS5PPhC7Um2yGGSxel1KQFALbs4XMeQz/FtbkatuLHMuHzcvoX1dsEMh1Frc4+diQbNIhz9Q7cPsNSwOoUbMnEnLrnnIg0egO97zrCLzmeTFFTnqHEXduVMLUyQ/euxCjbPCUfDgHW+d7m4wEQoLRDzykPGiCbHlA+fFIYWd+Ilob+XnvEAu2AOMyul2X3UhI6V5MJgUUpPS0nbqZaMqOK9gm7XQwBl0avu+yPU9um06IRyKPZKgAhPrNiKCTAtSEqL7Z3cJtJKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAWPR04MB9888.eurprd04.prod.outlook.com (2603:10a6:102:385::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:10:38 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 17:10:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 08 Dec 2025 12:09:46 -0500
Subject: [PATCH 7/8] PCI: epf-mhi:Using new API
 dmaengine_prep_slave_single_config() to simple code.
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-dma_prep_config-v1-7-53490c5e1e2a@nxp.com>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
In-Reply-To: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765213799; l=4475;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=EwqEIPJgHF7NC9qDG/X8Xk08rImBkoWATPL7s0dkX4o=;
 b=WQiMFbOH0IFwq1jktqxAug4kR4s4kLvJ52qklDH0htGMXPI4g0OBdZWe6FWa3JuYdeg4oZr0U
 C/D1dHMhGN1D/Q90e16wq0l+oG5QsVnRDep4CVhGs3qYlmS1vkDUroI
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:510:2da::28) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PAWPR04MB9888:EE_
X-MS-Office365-Filtering-Correlation-Id: 0385b28d-e66d-49c4-5c8a-08de367cb5b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0cwdUE3VFRISWlDdWRhM3lPamdleEtpUEVOZ1hlMFdBLzR4Zy9OU0RKZXBm?=
 =?utf-8?B?b1N2SXhodXd1MXlCWldjYmF6NzdoQ0pwT2FCTU1qa05VN0FJT0laTExjVzZ0?=
 =?utf-8?B?QitVRkxBalQ3VUV3WWNzK0hEcnRXdUkvSHNiaExMa0tHVmkyZVphUlZXRVFD?=
 =?utf-8?B?Y0RoL3duaC83YmZOWnBoN1I3R3dHeVZSMmxuMHl6Y3RyenlRM1NaTGpVNXBK?=
 =?utf-8?B?U3FoTkU3SXJOM2RzQmdKUkxqSG43RTdHWGM3dVJ5WnVuM2loN3BEM3RFZzhS?=
 =?utf-8?B?VHA5MVR5Rk1lTFUzd3VJWnJ4MG9TN2hpL1VoM3BXSkx2RHE2QWZZSVN6aEl5?=
 =?utf-8?B?RXA5Qmpsb1ViT210OEJQSHA5VXpMY0M1aUxpaUppbjFxZmtOZFlIQlEzclBC?=
 =?utf-8?B?dHZxVFh4Smlwb3hhL1BEdDZZd3dsRXdaSHV5THR2b3UyNG5qSzdUYjJqaE03?=
 =?utf-8?B?SW1SbHJ1TjlURUtXTFdzWTMrSmE1aWVJa2ZqWUd1alJpMDg3VVdyLzZhWmY3?=
 =?utf-8?B?ajBBL3oxRWVFQ3RscjM3UWo2cGZRSUMzaWpkRXk1V09zaXl0bjZBTlJUSkZ6?=
 =?utf-8?B?M0c1ME1zTEhCd0dsNTlaNStHK2JnalFERnJCTXRBYjdkejFlL2hGclg5Sm9v?=
 =?utf-8?B?M2RhT3FqUCs3d3BscDlGM2ZaV29XcTlBclhUU1hCSGxiVUE4TWtQQitwNGhH?=
 =?utf-8?B?ZnBJeHhrZ1hXTzdWNmt6S2RVdWhZV2xqc3lzV1pRS0c4YVRqd2RlNjFBTUpy?=
 =?utf-8?B?bWMwckt5OFFEYi9oVzhVTjhYc1o1ZThlakpBRTZEam9jRXhiV2RycU5DdG1Q?=
 =?utf-8?B?V1NmcE1Fd1JSckhwWXEwaWZWSytmbzh4UXBnRDJrSXhxNGYydXNkV2lIM2dq?=
 =?utf-8?B?eFZ0MktYcklCbkFDQ2tRbmJZdFJoUGtOcXhxU21WUnpxYTM0dFMwNXlSZTdS?=
 =?utf-8?B?bWhvY1BWOFZnVzcwT2FpeUpkbkJpS0w1K3IzbjZzV0ZvYVR0OGxLTDhrOU1t?=
 =?utf-8?B?U3ZUQndJT0VrSzIxdkpFQkNWQ3ZsWUV2TUozbGpDSXM3amZsYkFGRXREUzU4?=
 =?utf-8?B?QlNJWTgxWjdpcThxaGpkM2xoTXhaMGswQlFNM2J2UTAyU0wzT1NyUHZ2MmRk?=
 =?utf-8?B?RUYxT2YzNHRPK2RGZG5tOG9HTVBpaWM2NFZ1RElLY2pBUnMzanROd1FQOTcr?=
 =?utf-8?B?ejZYeGl5RWxGRW51ZVVKOFNBSUJObWpndjQyWmZ4WExjTW5YaGM3RnlLV3Zy?=
 =?utf-8?B?cU1SMDJ0dklNVkJUcC9LTTNMSUl2VUJNUFRLVURvSFE4SXNjNmZzejcxUnc3?=
 =?utf-8?B?V1dzbUFwTHJDM3B6YVM3VEp2OTFTbXpDUE9jMU1iYnl3SldFR1M2RWlTUEt0?=
 =?utf-8?B?MFd6Z1RtejlLWmV6Tk84VGJwdjVpdGh0cVgxbWJGQ1lCV3NncUVFRmpoQlIy?=
 =?utf-8?B?Y2pjK01VUDgvRndiNnFUbVMzNURIYWNHNWE3am1qdG5UZk5YQUw3blBTczds?=
 =?utf-8?B?TTlycEtOSk5ob2haSGlMR0NvcVkzQVlzVStXWDBYbnNvb3YwblhrVElaMllZ?=
 =?utf-8?B?QnFLellyUWVEVC9MZU9Va1krRncrTDBBTDkvT3Z4VlltUnV6YXRWVXAvV3FF?=
 =?utf-8?B?bVhOYTlFdWcycmk5MHEraEREaXA0OHdyV1dOTEl0Z2NlQVVpOXFQd0E0eWtI?=
 =?utf-8?B?SVlSbzNnMFFLZXRpWmdYRm1vZ0Y5eGFPZ3E3eFUyTHhTUzRSWXlpYkpKQ2VN?=
 =?utf-8?B?UDRCUkZRa3phcGlFUVRtdEdHYndJN3loVEdST0VFRnEycm5BUnZBNG9NS0hH?=
 =?utf-8?B?RkVCZ3BEL0NWcmVBNjRzMHRhNDJaQkVtVStlUlhhK25ZdEczRVVkNG4vOHps?=
 =?utf-8?B?TTd0ekEvSm9CYzdJSFN3R01oWStBOEIrZ0IvMkpuUk5qekxCaFdNQWFGcGdT?=
 =?utf-8?B?QitMdXZ5UjY1SDNsOGNpZEdpN2l0ZUJWbFNsSW04ZmRjK2JnOW5USkRObThR?=
 =?utf-8?B?QWdISVZjTXpHWlBmdWgvYWJZYy9oRVBYUTJqSGFNay9ja0h3S1VxcHZSNTZ4?=
 =?utf-8?B?UzRBZzlsN0J1V2Y1QmlXMEZNdEo0OFJLbW5kdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmlJR3djSG1qeWhjdWJ3aDhEUHhpT05OZkQ0UW5VdlhKSHJvTEZwU1k0Rlhv?=
 =?utf-8?B?QzRrbStGYkNhWkZxbHI4bzJHSGVZNnZjQjlheWYzRm1QbjBZUCsxTVFJTlVV?=
 =?utf-8?B?b1BJcHlPd2lWbzJTRC9jSlpXK2ppSDQ3YmhJK1R5TEtybW1JYnNPZzcyQzRP?=
 =?utf-8?B?UlhkVDlELzJVSU9NY0hRazNaOXhRYmZrMlduUXBaenpKdEVDRzh5S0pGL25C?=
 =?utf-8?B?c2JBTnNoT2pFVDlMRVNDRVVqYkcwRGo0NTNWbjBReHdFcHJxVnlFUFJPS1Bw?=
 =?utf-8?B?RExVWmttbEM5SUtwNDRuMHgwenU1eFlKVjI3ZEhrc1RMNnlzMG1CNkoxOEFy?=
 =?utf-8?B?WGQ3alE2ODh6TTUyODJXMmNxY0dYSDNVTHJQVnJ2TXd3MEg1Mk8ycFV6Sy95?=
 =?utf-8?B?UUxOV3RQZms5OU1pck5HYzVCaDlWM0hnYXFJdkkwQXQxY0ZFblkwMTBESFBB?=
 =?utf-8?B?K2NPb0FrWE9BZmprY0FFdUVCeFB3YWJlSm5tS1VlaVdCZ1VMOTN2QUNpUnBO?=
 =?utf-8?B?QzM1TDZNV29FbnBZVmpFNmZSRVZUZUxQcGJ5QUxkZHVkSlJaUkNQN0w0aTNN?=
 =?utf-8?B?V3NSQTZhSXBPZ1NTZFBEczlHUTFPV2YyKzM3RlAwTHlUMXUxSkI0ZnRqU3du?=
 =?utf-8?B?cEpKQVlESkxlMnFTSnJ4VU9QNzBhWm5HeFJ0dmptb2RFMnpIeWc4TlhabnU2?=
 =?utf-8?B?S2pQOUFnMDRkdWNnKytJR3lpMU5PdXQvaWx6QjRKNEg3TTN2UmlVbTVGckxs?=
 =?utf-8?B?cVRKVmxaQUl5bHNNbVNkYmY3dW1nRk5vQmJROFNqVjVxblQwTkJoT0xxTGk4?=
 =?utf-8?B?MjlZYmR5VHQrTUVUejB2QTg2cTcrTDRPWkVtdThWS3M0THdETm95dlNKWU5w?=
 =?utf-8?B?U0xWYjhFRTMrbXVnN3VNOWZvWDdJNWFCWEpzWlB3Zk9kdFBXOXVNM0JWWVJW?=
 =?utf-8?B?Z0lnckhFYVV1WFdhZGpaNU5va0l6RU5QZVVQOFFrQVF2enZkN00vWGtDTkVj?=
 =?utf-8?B?aUFZZHNMaHBmd3JPdm5LVlg4MjBSSzJ3M2h2VDYwTWdPUWdmY0J0bFc3N3U1?=
 =?utf-8?B?OTVtYVpwM1MzUWcwQjR0SHEzTDNHR2k4SzZId2lyOUhyYWt0czNuM2NlL1kv?=
 =?utf-8?B?WmxuYkVjRlNvRTlPM2FmQWsyaWw3UXhZaUZpYUFlN0haQ2Z3UnkzRGdrbFNV?=
 =?utf-8?B?Uk1SblRvYmorbktLQ09tM0JkRldHQ2Y2SGhlc3pFQkIvSlZHZzlYR0c0a2lS?=
 =?utf-8?B?dksxQTI4Z0ZVTnFCZjNxV0IyOWlZM2RWTHVaQmYrRkJObWlDSExkT3F6SjJ4?=
 =?utf-8?B?RHY2Mnhjc0xGend4M3UzeTJTTkhsSEN4ZXdWbkltaGh3bFZDdWFoS0JGajlu?=
 =?utf-8?B?OG0rNFhUT2tySkxmcTNiMGlHNDN5QjhtRElVOERzcWdPUjZrTnhSUHdIOG8z?=
 =?utf-8?B?Q0o4QWNhNHg1SlQ3NXVsVWRZVWUxQW5nazBSNGEza2RkRGpMYjV5OHNsaURu?=
 =?utf-8?B?K2ZQUXNkTldLanRmaWpmcUxsbDdscVd2amx2dCtncWJxUkxsOXVIWjlMN2xt?=
 =?utf-8?B?RjM2MmtJWmorSHpqQldtTWEzNkdabDViU2p6bjNuK2VyRmIwdW1wT2RDbkNH?=
 =?utf-8?B?c0IrWHNzVnBvS0RWR2piZXFrMy8xb25NRTV0ZC84UTcxanBIMWJ2UVBQY2lm?=
 =?utf-8?B?Y3p0N0NvY0ZuaUpwSjZZUDhaenc3ay9VOTdtQlRIa1lMQlA1Zi83eDNBQVZp?=
 =?utf-8?B?WncrNFlFNklJRTdsbE1LVHlZWkxrWmZSK3pvZFlqUU9jdkZnM2EvaEJGWTNq?=
 =?utf-8?B?Qm5PRUJJeXpjTkFBTFo0ZEV1RWZwK0JuM0I2K0Y2R3dDUXp1dmJWWGNUTTZV?=
 =?utf-8?B?MWc3czdzSkIyTFNsR1dUS1p6NnhhSEZCcDg1UyttditWTSsyTHpoV0pqQ29W?=
 =?utf-8?B?N3F1ZDZhL3JsVGpPKzVJZVhBVzd3bWZwb0loVnUreHdVN0x3RkdDcmdLYThC?=
 =?utf-8?B?MEx0TDhKSmZzVXI1QW5laEZBemhDNmR6bU5UUk5XUytmQWJwb2dlbEJpSDVP?=
 =?utf-8?B?Szk5dWVBcXh3MXAxU3BWeUxkOXZxS0tYRDA2YXJRUEpmTE1YS0lwMkc5MHUr?=
 =?utf-8?Q?m12A7fsB6KhX6P1ibGiYvp7Zk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0385b28d-e66d-49c4-5c8a-08de367cb5b6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:10:38.6567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygi5/WiwwWXPpV+UAIgWBVgYzZlYefrsz7t77O1DaSUzBgHpuryO4b7vw6Pfv3vFTN2jZelc66IBDhsFD4R6pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9888

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Keep mutex lock because sync with other function.
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 52 +++++++++-------------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 6643a88c7a0ce38161bc6253c09d29f1c36ba394..11999a7a156dee057f04f0f9277f6ac5a7f1d7ee 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -328,12 +328,6 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_DEV_TO_MEM;
 	config.src_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_FROM_DEVICE);
 	ret = dma_mapping_error(dma_dev, dst_addr);
@@ -342,9 +336,10 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
-					   DMA_DEV_TO_MEM,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_slave_single_config(chan, dst_addr, buf_info->size,
+						  DMA_DEV_TO_MEM,
+						  DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+						  &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -399,12 +394,6 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_MEM_TO_DEV;
 	config.dst_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_TO_DEVICE);
 	ret = dma_mapping_error(dma_dev, src_addr);
@@ -413,9 +402,10 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
-					   DMA_MEM_TO_DEV,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_slave_single_config(chan, src_addr, buf_info->size,
+						  DMA_MEM_TO_DEV,
+						  DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+						  &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -502,12 +492,6 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_DEV_TO_MEM;
 	config.src_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_FROM_DEVICE);
 	ret = dma_mapping_error(dma_dev, dst_addr);
@@ -516,9 +500,10 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
-					   DMA_DEV_TO_MEM,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_slave_single_config(chan, dst_addr, buf_info->size,
+						  DMA_DEV_TO_MEM,
+						  DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+						  &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -581,12 +566,6 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_MEM_TO_DEV;
 	config.dst_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_TO_DEVICE);
 	ret = dma_mapping_error(dma_dev, src_addr);
@@ -595,9 +574,10 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
-					   DMA_MEM_TO_DEV,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_slave_single_config(chan, src_addr, buf_info->size,
+						  DMA_MEM_TO_DEV,
+						  DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+						  &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;

-- 
2.34.1


