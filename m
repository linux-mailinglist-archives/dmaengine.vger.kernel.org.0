Return-Path: <dmaengine+bounces-2062-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4447A8C8C22
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 20:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F47283C18
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 18:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE5313FD65;
	Fri, 17 May 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r/ktXj73"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EDD13F00F;
	Fri, 17 May 2024 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715969444; cv=fail; b=s73Mb+xsQofstMLzsacEqS2nrP82N9gkSmUIGfbsNMAp/L2gjL/p0CCt4pxGyN983LAqp1lko3rm7a42UhZ3vV0jHvunRS2wS+wKzpjaEw7rm02+xghl8F5GT2rdXPwenevjEBJE8Xj7ulwgmx7gpUjEr2lu85d5Z2KVPPj8qp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715969444; c=relaxed/simple;
	bh=tEWFhDjhtUKAug5WAg7nPU6hg6Eu3mFZf5v7yoTqdyg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ql9DDrrh/xfQsLAr/g/QrQjaZKC1FElsaxiARz36VRQywZh81hv/KLz76a6C/MhXFSmK2T556T9LhuFLYwlMb1tuvzlN+0qWHIg/fku0IM3jGl8x/Se/8NTh/oooky+lYdOmGRwunAtJtW/eQjlg7mAIvBQwwh592ju1CQcay6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=r/ktXj73; arc=fail smtp.client-ip=40.107.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQ0f/+IggWK0LXT4nopLmIdSz0hM0uX3dgcPxntlzEkW6dFVifNA/6ktHlVwo3C8/8TlvBFn7ekd4KlCAI2+76YXiWSXMHOE4ko/o6mefp/BMLu/fr6IMbmD2XBq37HTtlet32O+357Q4yDBtFD78LQkyigEP5axTYaDWB3PtTFy/yU9pJlI20pazqLLoGJ29MDhK5LSUiZREN2OWtR95rh0X0sPbp4OkBLugFtjayJwLx3fpszTLZS7zJLjOql94jFRxpW69CGd8ekFP17JoIefFRVbh7LmTts3syyfgRIbRoMC0Us/VwudEW/881XKjWR/MIWCyeUXetUlB4ZVsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frIX+JJp9RbZncA+FJ2gAHvej7lxIMqz+pvAH4izM2s=;
 b=ia/dSugJe8ttO9ZwK8pa3SH8Iy/C7yOKeM4se78kPXILFp+ARZeGUo+iPOva1U6LLIbpMKoDHw76A/rQ+jASuDdvr06R+WVX2OqSLz9kEgUR4PhdzqXupoc5OXzdmWs85xHV30au0mPmQxygd7s3/6JQdJ+doIFfh4ULwDWrF7QMJXv/0nlcxkqGRUtP2s3L3vPpl2lG+Bb7bCNHklESOzlKe33PQKC7O78WICqK3s63yyLUwGoS26AEvn3+QA8dv8kZrVNvBq5Ugm+myI7qU61FoUum+LYO/BXoRdQVNL/5HJbqYys/hanjR78j0FcldC8SVfcSu/Kb+9JukmTCyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frIX+JJp9RbZncA+FJ2gAHvej7lxIMqz+pvAH4izM2s=;
 b=r/ktXj73uy4y9Jvq+FYrqegg4qmctVKZyI5a9wcLcVJz8FFy5nPf2QgONH1BEe6ojSBl+/A6TptkLcgqOsxGq2/RUm2vEE8PM60t1bg83orOEpCr/ZkJToPnslSkNcwaB+aUhyUFaF4sOM4KmK4uHlrvtswWv9hShtqwAcuRW14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8955.eurprd04.prod.outlook.com (2603:10a6:20b:40a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 18:10:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 18:10:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 17 May 2024 14:09:51 -0400
Subject: [PATCH 4/5] arm64: dts: imx8-ss-conn: add gpmi nand node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-gpmi_nand-v1-4-73bb8d2cd441@nxp.com>
References: <20240517-gpmi_nand-v1-0-73bb8d2cd441@nxp.com>
In-Reply-To: <20240517-gpmi_nand-v1-0-73bb8d2cd441@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Han Xu <han.xu@nxp.com>, 
 Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715969417; l=3045;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=tEWFhDjhtUKAug5WAg7nPU6hg6Eu3mFZf5v7yoTqdyg=;
 b=AB60P0ig0zclmR0efXtybW2Ldf9p0om00y3oMQxbLE6UYFohVBbG5awXIvpM6efyzoVBtcNDC
 8VIMCVUJ59rDW88q1b/EPq5KEgkm7tusdw0nocST1zwcJNyAhLNLHJP
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:a03:60::45) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3df053-d2c3-44ee-2321-08dc769ca8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|52116005|1800799015|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uk1nemVDVkRiQ2ZKK1gvR1pvSTRkTGY5RHlBek5DTWlzU1JYY3dSMUF5eDR4?=
 =?utf-8?B?SlkwSytPMml2MjZIOVpHSy8ya1NXM1RpUTF0V1pqMkp1RWw3UkRmaVgxK0ZH?=
 =?utf-8?B?YytkM2lMZ3FJa0c1ZjdMV0dJRmhFcUExU0U0KzlPaGdnSUVXNnVFNkZHZGNW?=
 =?utf-8?B?U1BKWFczZGo2Y1ZaUTZCSmRtR1p4aUVidHViQTIvU1U4MzZWMTdIV05XMlI1?=
 =?utf-8?B?d01vTkdnbEVueWdiUHFMRFF1b0E0cFVieDJEUWpjZHRrY0RNVXh0eTA5cEJv?=
 =?utf-8?B?dExoN1FXZ3lxR083WnNRWkdlSWwwR3BBMlpDWXJGS2lTYzl3dkhldDJtWjRL?=
 =?utf-8?B?WjRjbWtCbVE3ejVZQllreW0xVm55OHVYNkZYaGJtcUdmV1VMb3JBSWJVbnU5?=
 =?utf-8?B?MTROTm4xT0VwaEtyOGE3TGZNaVZvZWFSbFBqOVBSM2djbTMvNEVLbzZ3eHZj?=
 =?utf-8?B?K1J4bGtZajVYd28xbGgvejdWS3FTT0NzcnRNOG9MMzVYZGR1Zng3emtUVzdN?=
 =?utf-8?B?TW9UTjgyTjJMSmxzNW83b3lKVEczcHd6UTRNL1ZqaDVVWXpHNzlxNTdZaEY2?=
 =?utf-8?B?MHlaeUdGTTdvbHRqNlZhbVhiWTVQallaT0hzOWRzbzBuTHJ6aG0rQzFYWkx2?=
 =?utf-8?B?M2QxQnRLc0ZrNkZCa1NMbngvNFJzQjBQS3daVmVMR1NFUlJCaFVZVlFTTzlT?=
 =?utf-8?B?eGRyTFdNYnpjekFybFYvTnVTU3VnLy9SYkJtSkY2Q2taNXpqYWRNRFI1d2Rv?=
 =?utf-8?B?SU1NS0lQY042UU1hcG53VG9iQkRpTGtRRzhCUHNPRUpVWVJQdTQ1cnFpSE5k?=
 =?utf-8?B?clZ3Zi9tQ2wrcGRJMnNVaXFTV1dDb0ttVmF1aFBOMkRXeldiZkFMYitaYjRR?=
 =?utf-8?B?SE5oOEZDM0VkRzhIc0VEL3AvVnJDeXEvSURtaDJMTllzcFFUMmZKeVhMUmV3?=
 =?utf-8?B?UEswWHlpRHRPQWxObVJLb28va3ltb3NZNG1KZlRSUDdsZ1dRbEpaT0kwWEI4?=
 =?utf-8?B?a0RRNS9jSUlMNFg0VzAxQVZqOC9QWjNXUFNET0d4TGlhUURtWkdLQ3h1MW9S?=
 =?utf-8?B?ZHNtZHVaZHVyOEZJM1FMZlExdWdzM2VNTzN1NWwyaC9Nd2NDUFJCV2NybFNz?=
 =?utf-8?B?WkdKSHBvcm15eW1sbkVTYU5mbGRQL2laVUJDbjdOREpZc1hLUGtrVTBjMi9Q?=
 =?utf-8?B?TlJ6N01Id25JWTU4c0hHWFRvYTVub1VLdngxb25mRy9PY1krTHZBQ1ZJRStM?=
 =?utf-8?B?N2duM3RxVHFrTWdqOHoyZlVzVnZFZ1dzdWJoZHkxK2tPNHF1bVpvUW9XQzdY?=
 =?utf-8?B?VFFmQjhRSE9xMlZuOGxKa1ZsV2JiK3JnV0hoNDhnUEtaOGZpenFKVDhMZDkx?=
 =?utf-8?B?ZWhKQkF1YXZMdlBST2Q3ZkRGcGJuSktXZXFtbzhZbkgrdEY0Q2hFM2JNdWc5?=
 =?utf-8?B?SHpwNnB6cnl3em9yUVJmd01lU1ZlcVd3ekdXbE1wZFNQbHZSTVdteGE5QVM2?=
 =?utf-8?B?MVR3OWRlam1PZjlzVUFXSUN1YkdzRXFSNFB6TENFSFdhOVRBRkttZ2F6eEVK?=
 =?utf-8?B?L2dGWmVROVFPZCtVUUpWWldPYmVHRTBweDA1Qi85QnBaeXhPejZFYkYvRjlt?=
 =?utf-8?B?NndUVGpxL3c2bVFxUXJHRzVta0NSQW42K1lUQ0lna3VqT0oyUVZ4WjliNUgx?=
 =?utf-8?B?LzRFM0JmVFlmamtKWkRoUm9WekgxSVRyUkJqZml6akpDZ211KzY2ZGI3c3Bo?=
 =?utf-8?B?ajgzVTZFNVNHeWI2bWZ5SlQzMVlNYnpSWVJxajgzWUhhZjYrK3dkcXF1c2hh?=
 =?utf-8?B?eVhDbGNTcGE4dVN4OCtVZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(1800799015)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWdHZXRsckhVQ05PVzBNZ2cyRHJ0SUQ3cUFTRHFSZSthQTVQaG5SWEYzUTZn?=
 =?utf-8?B?bFQ4d2o4eGhwOEh4ZjAwVkx6NVppcVpLYkd4bitKSHhOa3hWTDFiS3JCQ0kv?=
 =?utf-8?B?cXliQkhjUzl0cm4zOGtkM244bGM3eXNBL28rL0RTSFdhSmNOMmRqM0VGRjMz?=
 =?utf-8?B?MWJXbW9iQUEwWEdyQm0xNE43bTY0VmhHUW5HcU4rTVNjc1FsNVVvWE45Ulc5?=
 =?utf-8?B?T2lYU2hRQmhwSTZ6T3E3NDBNelczV3JRczdBK1pkeE12bEJGYUE1bWJvZjZH?=
 =?utf-8?B?dHNvVVIzb1IzOUNsd0l3SGFKTTJTUmQ2L0lDQTJxVnp1UDRJS0c5QzIrNFAy?=
 =?utf-8?B?bWV3Tll5aENoWXN3SFU4YjZvb1hrYTFLVjA1ZVJMS01qR0V2RXpUcVdMMERM?=
 =?utf-8?B?YTA2Tm9WOWFJNzdRUFlzeGF4WTUxZkhhNDZCcFRwdysxck4wNFBBMnJWZ1VX?=
 =?utf-8?B?RGhvckVpTmYwYVR0TFFHQUZaaWU4SkRxckV5OVNPK3gzQmNYT3pab05QZmww?=
 =?utf-8?B?Z2dmN1dnYmJKWFNWeWxYaEJXU09TbGZQendkaTR4dWtrRUkrWUpUVkIwUWdk?=
 =?utf-8?B?bXRpMzF3QXhzSVFTTk9lZEE1MTdObU9FYnBISTB3SFpFdzIvY1lteWNBSHJl?=
 =?utf-8?B?UG1nR3BCQjdzY2hxWVE1SjVUUi81aExKd2s0M0FWS09GZ3FYREc1Syt3ampS?=
 =?utf-8?B?T3llYmVZT1FlWTVCVnFBQ0ZZY0JHYXhMTnFtT1pqcXRGNTRWUk52akJjYUVj?=
 =?utf-8?B?Ykt3WTVIS0xHYlJVU2NTKzNubzVQbmhtRFE0ajJCTmtPZHZiVVQ5UDVDMWdF?=
 =?utf-8?B?SnE1akErdVJzdWg3M08zdlZVQVYyRGcxVFZxRUszZXF0VWJzK25ORzRHUTZH?=
 =?utf-8?B?cTVjd0N2L3pidHg1UVRtYms0YzIvT0dOTXIrOUttWWw3VFpxYXkxY3FBWEdN?=
 =?utf-8?B?am0rMEw2VmFqSHhIdUdkZzNUbDZPVHRhNFdNb0k0azlUR3R5UUhXY3VBRGNH?=
 =?utf-8?B?Y2R3WkVVc01ITFJTeS9mbTMzb05LcFM1OFcxSFRBVXEwdWRIVlZ1Z0FDZU5U?=
 =?utf-8?B?QlVMSERHYlhmRXNqY3NYeXdXb3BoUXdhODFVa1pSbmErMThSZFNSZXpSMk1v?=
 =?utf-8?B?NndLV2Z3RkdMbzYvdFY4UTJUUmJtY0VwTnlGODF3OG5OR3NRYnF2T2V2UHpw?=
 =?utf-8?B?WURqeDZVdFZFMUVBTU5abXRIb0ZnWFhXRFBlZVVuTUN5RFFGdTVoVVVxMXJP?=
 =?utf-8?B?SXNTeDIwblU3R1poWWFnaTNlRDRIRktDRDZMbGdzMGpmaVg3V3RvbEJpbWtw?=
 =?utf-8?B?S2ZhN3FTdHlVc1hxZUg0SWdCNlA1SjNYeWlNbVppT0h2ZkkzQkw5WVVCaXV3?=
 =?utf-8?B?ODZ0QjN2dVBmOXV0S3lqMGpPRGFON1psYXZjT29aOCs4ZXJ1UDE2SW9LcC82?=
 =?utf-8?B?cWpVRXhNcWkrV202ci9wM0Y1dWIwdEhNa29naUo4WFIvV05ndHk1Z3FJdllx?=
 =?utf-8?B?dG52NGFBWDAvOGhDL1JTR0g0ZC9GMko1QW1xYzNscTk5bER3YkhxQ09rVnB4?=
 =?utf-8?B?R0ZXTzE0Q1Q3elAwRksrVjlxUGJLSUJlY0dqRjZlTXZKUDJDckc1NUlBYmFX?=
 =?utf-8?B?UWk1RWI2ZG5sK29xNGd6bnJDOURnMmdVL0daUkNKWVlaMldWZ0lWMndKUTZ6?=
 =?utf-8?B?eVkyS0JTY1V1RDNKdDlNZGRPZUJ5dThCZ0Z0Skk1Ri9pNXdEbFlvZEJOUkpE?=
 =?utf-8?B?Vm81YS8yY0JpdXFtMlN4N0x2YTJkNlpwR0pIOVovSHRTT0k1aDVsUmlBT3lu?=
 =?utf-8?B?SUd2bzVFa1c0Ukwvd05KZDFaYm5jWDBQSDl4UWQvUU53ck9VcE1aTEdzRjQv?=
 =?utf-8?B?QkxnQ0RrcTR5UWJzUlg1RDNuU2VsQVlkQUtWTXBpSWJjUDEraUhCUndnVEJD?=
 =?utf-8?B?VDU2NEdXWDRLOVEwNSttTnVLMFlObkJteHBlZHZQNXA3WG96ZUYyR1hKdFBE?=
 =?utf-8?B?ZGFLR3hORmJQSlY1Vzh4SUFJNE9hbis2c1p5NHF2R04xa2hPS0Urbnp6aUFa?=
 =?utf-8?B?TEJCVElpbzdDcEMwblk3V0RaRWs0Ly85UlhPUWpkVzdUd21DNkV4WmZNUXJV?=
 =?utf-8?Q?OH64NQVXlNKBS06regVGf9pb6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3df053-d2c3-44ee-2321-08dc769ca8a0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 18:10:39.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75A6uUJWw4/g8eAHo+eV5oRnIoXP/qco6ZtHwd7ikDr13Y8yW7io1aHCbfI8ZSpc9a/xDIkdV96N0e9IPmJ5gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8955

Add gpmi nand support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 69 +++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 4aaf5a0c1ed8a..a4a10ce03bfe0 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -28,6 +28,13 @@ conn_ipg_clk: clock-conn-ipg {
 	clock-output-names = "conn_ipg_clk";
 };
 
+conn_bch_clk: clock-conn-bch {
+	compatible = "fixed-clock";
+	#clock-cells = <0>;
+	clock-frequency = <400000000>;
+	clock-output-names = "conn_bch_clk";
+};
+
 conn_subsys: bus@5b000000 {
 	compatible = "simple-bus";
 	#address-cells = <1>;
@@ -302,4 +309,66 @@ usb3_lpcg: clock-controller@5b280000 {
 				     "usb3_aclk";
 		power-domains = <&pd IMX_SC_R_USB_2_PHY>;
 	};
+
+	rawnand_0_lpcg: clock-controller@5b290000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5b290000 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_NAND IMX_SC_PM_CLK_PER>,
+			 <&clk IMX_SC_R_NAND IMX_SC_PM_CLK_MST_BUS>,
+			 <&conn_axi_clk>,
+			 <&conn_axi_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
+				<IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>;
+		clock-output-names = "gpmi_bch",
+				     "gpmi_io",
+				     "gpmi_apb",
+				     "gpmi_bch_apb";
+		power-domains = <&pd IMX_SC_R_NAND>;
+	};
+
+	rawnand_4_lpcg: clock-controller@5b290004 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5b290004 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&conn_axi_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>;
+		clock-output-names = "apbhdma_hclk";
+		power-domains = <&pd IMX_SC_R_NAND>;
+	};
+
+	dma_apbh: dma-controller@5b810000 {
+		compatible = "fsl,imx8qxp-dma-apbh", "fsl,imx28-dma-apbh";
+		reg = <0x5b810000 0x2000>;
+		interrupts = <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>;
+		#dma-cells = <1>;
+		dma-channels = <4>;
+		clocks = <&rawnand_4_lpcg IMX_LPCG_CLK_0>;
+		power-domains = <&pd IMX_SC_R_NAND>;
+	};
+
+	gpmi: nand-controller@5b812000{
+		compatible = "fsl,imx8qxp-gpmi-nand";
+		reg = <0x5b812000 0x2000>, <0x5b814000 0x2000>;
+		reg-names = "gpmi-nand", "bch";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "bch";
+		clocks = <&rawnand_0_lpcg IMX_LPCG_CLK_1>,
+			 <&rawnand_0_lpcg IMX_LPCG_CLK_4>,
+			 <&rawnand_0_lpcg IMX_LPCG_CLK_0>,
+			 <&rawnand_0_lpcg IMX_LPCG_CLK_5>;
+		clock-names = "gpmi_io", "gpmi_apb",
+			      "gpmi_bch", "gpmi_bch_apb";
+		dmas = <&dma_apbh 0>;
+		dma-names = "rx-tx";
+		power-domains = <&pd IMX_SC_R_NAND>;
+		assigned-clocks = <&clk IMX_SC_R_NAND IMX_SC_PM_CLK_MST_BUS>;
+		assigned-clock-rates = <50000000>;
+		status = "disabled";
+	};
 };

-- 
2.34.1


