Return-Path: <dmaengine+bounces-8281-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84906D25A63
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 17:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4779B30CE1BE
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 16:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ABB3B95EE;
	Thu, 15 Jan 2026 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="arE+Yrml"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013033.outbound.protection.outlook.com [40.107.159.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB3B3BB9FC;
	Thu, 15 Jan 2026 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493255; cv=fail; b=AJgf4u7nw6dsY8J/Iw5xjB9a/AscXjAg63ftcn5Ad3jtutm4yCZJmZScLDXYmq5MtL2RUrpxRkr0eTGEyoF2Fw0OD/q4Oyr+DAaIXFjIb8H9GDouWwSFpzkEhhNub9fd8LUW4PSliUTNsvaoMStI+PwPdOUuf6xKjSIuCTnC/O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493255; c=relaxed/simple;
	bh=SQCaozGDnqZZof8cp4kNNQdXYMha4tAf+PTC0BbfHrA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=m9egLwGuBgBAjXZOxbSUH2d+EnOwrwcQBpaGOg0mzvSwKirfpFDjoGBK7QZKBXBP/pph+6Hd6rMMdRnHrVLDYuMs9KfUh4ffEf4V7AiueCC3zGkyubraM46CVY6vtIVZWelbJWmrdseR7mLJOLN9LJFhDtEU7HehyvIEt9QfIcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=arE+Yrml; arc=fail smtp.client-ip=40.107.159.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDvtkB0O/Y87S2kH5rnCnv6byZsUPx6NX9/eg3UB/pKV5xL4c5qnah49WHIOcvK0SBBponVJ5tPXfaqqfLZscfIwpwtHeVUYpgrTxGr/Ww020SkOIqmW6c3ewoHUPt+qxnGuoU6lLA1fda0D1rt/dur2aQKnWsvs6GFHTDLwtXG6XOKlpggVSPy6xdD2uQpMkalikpzoz6LoJrJEam8h7+TiubPX1As7oXyezgs7700EVSbWtFfo4K3mQj94U9KEEpZf3+Dxf9DhS0dK83npmGnwUqvFPlGo7LU588OSCiyjUd9+F0K1utWWoTbVfaJhvGPrTGuJbwFCDVVyqUsyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/isUkW2dUX+3o19O7qOC7YAfzcg+sLKmLHDflIAGF0=;
 b=YMuzUReUXSmtCZLp5p5SdwPrLvbk/RxoSj9GUPiy65X86uu6gZnHfvkqVNURrvfSGWS8sI7SUbtu2a3Sk5kVPTQ1ONNinaRBTrpDJnPYB6bdiDcGvM7to4voup54NsAHen00tfUVRcm1urs3+iSgF62TFA7DVcx04BSsc9NXQeNiHs9drJ1XgbtV2xX0KtTNat21pMVyMOnKjL7+aut0Pcx6kMUxiySql/PQYG5X6DWW+Ofo0+476lPU8fT+G3i9NXOx236EsrE4SICefmlSacWbyj70UdE5r5Oxr6nxclfefwTIyXt1f7XKfQTtW6pn46TvJsumoX4uALWjw+Y+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/isUkW2dUX+3o19O7qOC7YAfzcg+sLKmLHDflIAGF0=;
 b=arE+Yrmlz7B5BDrFIQuX+UK+nuYKn7NbGo4QARdG2JhyfUjMpUJ7MBb+h6gDBQHPlno4ojvm6Zldd7SZ9VAWigqxeYK9hV+nfm/VB9APjkYzJwR0jO68Y6CDTCL6UIDjSk1cxMkMSe9ETZlkkQ/rcDM00lmJ/g40QXm/9ujDMAxmzhp0w5BkaG0dIyoa3o2AtGTWGOj4HpfMcpma9qjbTde39VOtOc4Se8O3Rbl2xo3ftMrKZh1Tp6V/evC6e5POtohsKd7WEdvazT+MXh7+K3AEsygBt3xpVr9IWtHvrmLu1vl9i3IO/lzzVXAkgQnGs5mAgNRKLXmEfIwGteI8aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by VI0PR04MB12235.eurprd04.prod.outlook.com (2603:10a6:800:333::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 16:07:28 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Thu, 15 Jan 2026
 16:07:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 15 Jan 2026 11:06:46 -0500
Subject: [PATCH v2 07/13] dmaengine: mxs-dma: Turn MXS_DMA as tristate
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-mxsdma-module-v2-7-0e1638939d03@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768493221; l=680;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=dh5gBs9pt4KR/3QKIUl3wn2CmlzaqBtYSrG0vQ/yYuk=;
 b=WkHE8ZqJGPpqbFtkwHJlpXzKwhR9pPuQ+anWhxrqDAIhKcsBTV4CZltLOCdhYD3MluL/laOe9
 fDCYIhfLAsvCexkkNe+rieqP7OkH0DKhBSiQb3DXjtnnbuLpn192mfa
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|VI0PR04MB12235:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9978ff-7339-4aa0-4edb-08de54502e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTNlVG40QmxwbFBwSFJ3VU9McjRsTXlLTU5icVIxUEQ1SDN1ZmZ0TnBXS2Jj?=
 =?utf-8?B?Q2x1eVNRV3pDMXRhWVhWU2JDcW9PK0ZCcnBQMGZJSkR0ZUU5N05JUGtsRE5h?=
 =?utf-8?B?dURMUWhkRDZGeVpGR1RPajk3R3M5M0JSdVk0SkNScmswUHJHSHN6WkxPbWRZ?=
 =?utf-8?B?SFNOa3R2RFpsa3pPL1g3T1dtZXJoV3JDaTUzVUNwTzZNWjBNT3RhVnZ3Zy8w?=
 =?utf-8?B?dVpja0cvWXN3RlBNQ2ZUSVo4R29vQ0ZWckhRbXREc2RDSEZqSlhPRGlMSjNY?=
 =?utf-8?B?cTVjZDZjZ1AydHBPd0RkVjVmZ0ZxSTNlV091Q3kvMmdKZ3ZJN1VST3FoalNv?=
 =?utf-8?B?aW9xZVVqTkRzV09EbS9DU1JLaU13QitkUTJqWHVjTHJ4VE1iV1dYVGR6SWpB?=
 =?utf-8?B?cHBVbWF6MTRucFJQaGRqcWQwb2NhR21lelY1Ym1aM2p0T2hjR0ExUnhhYzU2?=
 =?utf-8?B?WWdBdzNxVUJUa25ZWnBFREFFWHNZdC9SOWNabGxDeUoxeUkvdEc4SFlKVUlQ?=
 =?utf-8?B?aHJKUDZPN2RNSStLNHMwUzMzS1hzTGxpVDJFZVFIaHVFYUlCMlQwUlFpdnM2?=
 =?utf-8?B?aEJKdktMNjNXb2MyVE15MUFFYmFRRmkvdGcra2RvaDFGSDJuYytEM3k3VDFM?=
 =?utf-8?B?T0hMc1psY09ybmdJdHRTUjd4TER3QkdJaTY5aS8yeUk5MEFES0ZWSWxMdmli?=
 =?utf-8?B?Vkp2RXhuZUdPbCs5cENqTEVHbXd1SWhHMHQrSm53c0ZHb002YjhURXNOODVx?=
 =?utf-8?B?bDNjSXJ5VEUwK25MRUJTTVJyclFLZkY3Yy9nYnplaExoL3hLWXVzVkNwMm5t?=
 =?utf-8?B?cG1TTEFkREF5MVJveFozY2VVTEJhMmlDamw5d09CeElHa24wdlVOTU5oNkV6?=
 =?utf-8?B?bFFqR0NSOWZsZDM2UW0yNFNpSGZLTUJXZldBbmJ2OERXOWxFRnJNTnY2UkVJ?=
 =?utf-8?B?WEpKWjluSlkxU2IzRVBYU0xSbmxiTkgwWnN0N2hMWldpOHhhR1dsbE5zNDdx?=
 =?utf-8?B?dzdub1B2eGFWVDhoOFNGL3dxUWxRVWVhSVhmWWJEN1dqdWJIU0FoSUE4OUEw?=
 =?utf-8?B?TmJvSTFOdlJ0NWlYVXhCV1lUU3Z5UENEU25aWEtXdzMvYXFZNlhkQUh1WVJ0?=
 =?utf-8?B?c0hUd3FxbkRmOVFraGVHNzhJQ1lKTFUvNmkwZUU0TUZoRjFDenV0YUxVaUFo?=
 =?utf-8?B?bENSQVZTTEZIZXU5Ni9YNEN6REJaQ29KU0E1TXdMTGhvd0lZRmlQS05NMGhK?=
 =?utf-8?B?cm1tRXplOThUZDRWd0huSGR1TVN4T3kzMVVZSThPR2dlNGRTcjNSeStBZUNE?=
 =?utf-8?B?TDlka1JyYk1UVHVMR2RsZ2s0aVpoSkJRVEVVcWhRdjFVOEVkaFBDZWtSN1M4?=
 =?utf-8?B?c3ExNmM4SldEOWFFcFV0VVNBM0dFM3ZwbjJodHp1eWowNUVDd0FTNG9uejdI?=
 =?utf-8?B?dE83RDE0OU9CWjFWaFVkUVdzUGZNbFVFUlR6RFRrcU1sb1VodGhNT0p5YTV5?=
 =?utf-8?B?d2lmK1dwTlU1YW5ib3c0dmkrOHJBalRpT2s2c0tMdHArTXc0MWpxd0YxS2FH?=
 =?utf-8?B?YnJkLy85NFQzVUFRTFVDaHc4akFZQTlVVEN1MTNVNldrTk1wRkJETEw3ME5N?=
 =?utf-8?B?VXA5WUl0eXdCejY0YWFBRU5BMkxPNHY1UmZCZGt3WjVoL0pzWUovOWk2OFJ4?=
 =?utf-8?B?SXlTZFptaGkzRUNxZ0ZETng1a1NkWnU3M0YrcVRaUjMyOWtvMUtvSjZ3SUU0?=
 =?utf-8?B?OC9MemlHTzE3ckozUVlvWWVFUWcybUorc08zK3BHZkplcDhldndTVXEyK0FR?=
 =?utf-8?B?bUc3SHpXZjd2R3Z6RXY2NmFwNWx0Slh0bUg4cG5Bd0VoYTVBSlQ5cVJEYnN6?=
 =?utf-8?B?Y3AzWmlDUGVwYnhyY0s4a3kvamM5VCtSc21Yck94M0d1TnYyK0NMU0ZhZGx4?=
 =?utf-8?B?aTBtY3FabXJja0lOTUZVajA1Q0hhbVpqTGFmOWIrZTZCbGZ4MGRGajArQS9L?=
 =?utf-8?B?R1FSWEE2cVZlRVhvK1I0SktPWXVyVktwSUN5VVkxUWl2cGR6S2N4OFZCWWFa?=
 =?utf-8?B?cFZ4R1lJMXdZQnlVN1FsaGlWTWxVUXp3cXJVZHZWb1NhODBacHVxRFlPWkFU?=
 =?utf-8?B?Y0ErWVEyL0pnUWlHWXNZeWU5RUF5TW5XUExZNU9Mb08xMGlsaW1tZkNPaENC?=
 =?utf-8?Q?oro8EKhUOqhFZVL7/hPdm40=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3FjdTNwSDVsemdBc0FvT2dhNzdCUDVOUUdiT3VHcng3T2ZMZmdRaGFNUmRp?=
 =?utf-8?B?YTNDdHZSZEZUbCtldmY3QjFNNjJPLzY4SkE0RnFQSTJYSGh4QnlzbkpxNUlL?=
 =?utf-8?B?Nld4WGRoTUlSbGdVRkdhZ2grUVZaUDBYdk1WSThZVmQxQ3NYQmlLTU52UGxX?=
 =?utf-8?B?enVjRjQxQlRGKzBiekIyM2dQUHBMRnAzWGp3OWltRk0xRnFBOTFFT0lBazBZ?=
 =?utf-8?B?am5YU1FsbWpSMTVvYjlqQ1dJc1lqYWM3N3ozUWJQUG9RcW4xN0E4OTFlbGpJ?=
 =?utf-8?B?QjRKcU5YeGpPUXA3RHduZ3Y1L1ZUbXE4S1kwZ1VySSs1c0l2Vy9KV2NzVTdn?=
 =?utf-8?B?SEwrdEE3UStVcUhEdUU1eFBOMDhqUW1id2UzK1RSS28wWEhpMW5vOXROcjY1?=
 =?utf-8?B?Q2U4czVJbWI5WmliUHNFcVNUaFArWlhoeVdkTFFTdlp5QTRIWkNGaDBPU1Ji?=
 =?utf-8?B?b1Y2ZEIvOW9vZnBNdFdLc3lQOXgvVW03eTVjamVFV1BvVUlHZExWOVkza1ZT?=
 =?utf-8?B?WjlKQUV3VCtGZEZoWmdFSlJQNkNMcDBSa1lRUCtDVUFKM1hGL05Vd2k3ZjdQ?=
 =?utf-8?B?Ykp2NVZrM1dlUktLM2EyR2Zla1J3RXFsQnNlRXlYSG9SWEZReC9YT25VVmNS?=
 =?utf-8?B?TG1kbGNqbVVDWmhhcjF6YkYzejZpQlE3NGRwVXFwc0hoS0ZTcWVWWnJNS1dW?=
 =?utf-8?B?aTQvZFN5U0FVbnFsUkFjY29DRjlxQWw1ejZpWHVCL1gyMlQrOGljcUlHaDFC?=
 =?utf-8?B?anl0ZExydWVpRHRaTWROdUU0dGgzMlo3ME5VYUtIVlhGK2RQVzFJVForRnlU?=
 =?utf-8?B?TFJaZXhmL002OGVNOHVoVGNvVldEWkxuUHlrOWwyUVlmZXdvUk5CQWFzTDZ5?=
 =?utf-8?B?OXJMOGh2bFZVbTYrcHFBZnRoaDZ3QWpJUHZTTjNtS3VmQWR2czlud1hLQzFz?=
 =?utf-8?B?SUpyTVRNSGVtVm0vcDRlblVvZ3dwNUpxeDRMSlVacXpDZ1FldWNzOUgvOEl2?=
 =?utf-8?B?YmpIUHVRcWptcFVheW1vKzVNaXhHd1Voa1Z5dHFoa2pmVHhTTHp5Rm9HSnV1?=
 =?utf-8?B?eFQva0UwY1ZtSmRLelNocFB0TllQYnFocDJrTVpiZUZwVlA5dDJpOGZZbHVP?=
 =?utf-8?B?TDczTDBlZ1JsRDRjRU5KeENpV2I1L3hJMUl5U21ENGYwc0dhZm9XUVlYRVNJ?=
 =?utf-8?B?Ym9pajhPVkE0cTNzVzFhQ0pOR0J0SCtPcFY0UDNvN0tXbHVDVTJxTjNES0lV?=
 =?utf-8?B?Q0RpRTBCaFVPaFJMenRBbm1CREpidHBlTGU4MzdDRnRQUnczaGh3R3VZd1RY?=
 =?utf-8?B?K1lJR3BmVXBDMG5obk1iaGVadGRJYStBQ3dVZXBVMFN1aHVhN0ZOaWdxK3E3?=
 =?utf-8?B?bmcyb0srY3RnRHpHdmZzN0szYk5rWjJoRzd6ZTJNbVEzemNXcEQzKzg4OEpn?=
 =?utf-8?B?YVNhZmd4WnZxY0ZsdmZUNjFjS1kwWmt4RStST0JUS09YU0dQTXBxTHRucnRT?=
 =?utf-8?B?UDEyaG5xN1E5cWNwWTVoOWlWRU9OaklXbkVOQ3NZczRFZnJDSmNwV0I5Um13?=
 =?utf-8?B?eU1TZ3kydldneEppZmN0R2lhYVdKYTdSVkx4V3BZSW1OVzZuOEZtWFNJOE5u?=
 =?utf-8?B?WTF6ZGVQczdpQ202bDEyaUtLSEdDRGlQZDNwN2llQXJ6ZHYvcEo5eCtBNDRi?=
 =?utf-8?B?Q2hLZTFkTDNTRHE0SHBQcUlCQ1BZMkNqYjNJTytja0FVWExMNGdDaUh5Ym1L?=
 =?utf-8?B?LzFSdkxENExCTG1KSnhBUGdERi9LTXBJRVFycFBFakU0dVJGa1p6VUJjaDVz?=
 =?utf-8?B?UHJodEEzSDhWY2JGUjQ4YytuTUJkZEFXdGgyWDJaTXhZWG94bkg3REwyakFH?=
 =?utf-8?B?Z2xxNkc1NVFzUUl4L29mTlprRno5NzN1MWpJMmtUdUxUNU5nVTBBdnBTamF6?=
 =?utf-8?B?dnBSQkluU1pSTkhQU0tIVjFUMHgvMTVlNGJabmFpYU1KTjJEMmFTRnNPUjVE?=
 =?utf-8?B?UG1QREJ6b29qNVVxMlRSYS9hSnFmekZuMHRVd3B6ZGJqbnZSN25KWU8wbE9N?=
 =?utf-8?B?S1puajN0MndmdXVmWlp3eWZhQzR5VU00dEtzeVVPY2xBTTEraWNOa0FpYXRs?=
 =?utf-8?B?Z2taRUF6dGgrbm1nMWc1UmdsUGs5Z3BGWktpYWhrY3kzeW1VT3RsWEtIR2FP?=
 =?utf-8?B?U0xPUGZvWWZHY1p2MmNxcW43c0YvTURiYU5uTXZsZHNMZFcyRDJvMEJ5eE1W?=
 =?utf-8?B?ZUkzUUtmTm53MStmL1M0c2Z4Rlp1VWhiNWxoWGJVbTBLK1NQK1VobkRxNkxD?=
 =?utf-8?B?T0MxNmdLLzRLY3Q1cXMzOEppYURXT3NUQkFFSUZHNEh0eU5xK1AwQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9978ff-7339-4aa0-4edb-08de54502e26
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 16:07:28.2908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wHwZEPe7oYR125pjwl/UdkPeETlyr3gtpDJzo6ie2Dibb9ibpjuVSu4eZ03HOscb0cohoYMgB8h9aaOfNCA0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12235

From: Jindong Yue <jindong.yue@nxp.com>

Use tristate for mxs-dma to support module building.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 8bb0a119ecd48a6695404d43fce225987c9c69ff..b1c2d0fd0836edec9f9b6868e020310f50bba63c 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -505,7 +505,7 @@ config MV_XOR_V2
 	  platforms.
 
 config MXS_DMA
-	bool "MXS DMA support"
+	tristate "MXS DMA support"
 	depends on ARCH_MXS || ARCH_MXC || COMPILE_TEST
 	select STMP_DEVICE
 	select DMA_ENGINE

-- 
2.34.1


