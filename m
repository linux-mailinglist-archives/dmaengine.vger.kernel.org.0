Return-Path: <dmaengine+bounces-4035-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ED99F7851
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 10:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28153161827
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 09:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D4B223E6C;
	Thu, 19 Dec 2024 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GrJFfMg6"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27578223C6B;
	Thu, 19 Dec 2024 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734600073; cv=fail; b=I0suXyDfCRrCMY45VIOgVRDz/kRLdvJqAsuiLIoUFYX5dkomYn2/UKHNFgZzOCXIyWUU6WHP1G1I2NW+glPikWq/SdixQXaHjQhOfifbzfO1JF3LiIyRttN69ldsDUVZ6NFMAFjQLryp2AdSpNqwjang0lJqI64N3rYNf2r9hW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734600073; c=relaxed/simple;
	bh=+EQjfRbS6pUksXCoo1RLf9J4Wu9HOahBDCktosA7hy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uZ66M+xhq0YxRg2+BgDJMTB4kyOeNOaERcWWa/oD6pxbF7gX1Zy3WDsZ5xHRGM+U95ecNoehxG65N78MvNbYAmCPgIqS6Y+0YyCrYyIyyzLR2L9TQJIi/21wJRvK71AX7ejbGW8ERqROt0qBDEMOxpTFHrLQ70GkljCFOJ2b1IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GrJFfMg6; arc=fail smtp.client-ip=40.107.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldpCLxh54JxCuu4ptsTYQdoHoG2mOtLriPLMcHHhp7clOP5IUVSxOzRg/RFPV2tsnSZ0UdctYichqD4GJY7Fv+DHG793JOHTBNmKdJIjzSwlW7j0ztfakHbJb+Brn0YJScXKaQ4Pb338E/s02WqHnDFkaJ4WnNlFd3ijea08drIHgf8k8XihRwWOgZmBdd63pm9kUsHZN+zfosvM2V7oAR9WMpdVCmB+9/FL3fZU8b6cem5HqctiZhTfkULAo4j7PLDRh8VvtQYoJwTGK/WWHd1KcO/+HYhPUcTwSMaFMZf/6vYX2wmaiNSMhqcKMvf7DHHOpsmfaslNhnuGPgJavQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pfq1ciCyrr52NINz2DKlSeJUJzmw6YcZSgtL8D3O6LI=;
 b=AQzsHZvRlU7AojBpFX9ZFf5FvkA7Cf8Pp/XT8jdZ30/WquwdY4V8Ywr2lA9vrG+4AX18gYyET5X0DdjQhMYAJu/+06nW2MXqRJDU9aCeKJNsTrKk2SIRV9tbtFymw7RIX9+uVkNs+3s2rNS/QhfWFx/4f8mJ2ugYWYhYR/g8lBr1qtt5ittGNqrSCbPxWs/+9nvyEChraZeMjXr5aItu0J66V+PUEQ6pV94WFnRlJ9uzAaOs1gEwkYqUh6DBAztgknT0dCQhQo40oo8CZNQWje8opjmJNnAXxaLGysCez6Cn1rtE3sKG/Jkkph1iQPXEblNF3RI7oOVFBacuiFWgkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pfq1ciCyrr52NINz2DKlSeJUJzmw6YcZSgtL8D3O6LI=;
 b=GrJFfMg6jwZRFvhzRROukKyY1qgZhL2fZAgHGgFxrDkfL3p7pa6j71fTHJ8+ZtBIPR5/JWcnkE74OzKVLTjbHZBLGBhqG7H3kk6+KiBLxNL9cMDQClIWlfeDa1kRZXBcAfhpqVZ2GOl+GWPO8uKtzcHaayBWbIJGyF3I9JjYheaXjYFGs6MEhbqS1LT5NLbuU1opO80S/pzjyn9KbTviEP1IbCr+bfGmNOCYZIN/m/+JEikVZbdTWjBiNDw+mE3jD3wPWNpoOSDyfzs45pQFS+Sji5/s+Ij4iOh5sdDO+QRKGrU62AGkPa50g1xB3asNUB5/Oa/9sdyVYzyUnUOtxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by VI1PR04MB9834.eurprd04.prod.outlook.com (2603:10a6:800:1d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 09:21:02 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 09:21:02 +0000
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
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
Subject: [PATCH v2 5/6] dmaengine: fsl-edma: read/write multiple registers in cyclic transactions
Date: Thu, 19 Dec 2024 11:18:45 +0200
Message-ID: <20241219092045.1161182-6-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241219092045.1161182-1-larisa.grigore@oss.nxp.com>
References: <20241219092045.1161182-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0225.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::32) To AS4PR04MB9550.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 54ac90d9-32ae-430e-1472-08dd200e74fd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjV1RW1TemVvWTFRUFNLUjByaC9BdVBmTWl3cXZKdG5EdzZEbXpYMHN2Rzl1?=
 =?utf-8?B?K2pSWkdkUWhoMWN1eC96cDlWWmhUQWdIOU4yWlJKZ0tsN2FDejRjZE9zMDQ5?=
 =?utf-8?B?WSs5cFNwQk1hNUJCemYvcXh5Mm9UMHZCMG80dWh4RkV6VHgwM2VXWmxMSm4v?=
 =?utf-8?B?K04vT0NXeVdRODZyZTBYTm55U0ZYRVNYM2NCbDZuWkoyNTl5WUJrdk91N2I2?=
 =?utf-8?B?UVFyVXE4SnI5ZUJsN3NBWk8zRFhqU3VsRThpa0xhbUpYL1BhMzVvN2VISDF2?=
 =?utf-8?B?U20xRS9CaTBTMUhyR3hBeGlSRTNhbUhDcEVuOCtTanF1N1gvQWtzY09xZXFj?=
 =?utf-8?B?R2xkb1ZneEVUNkIyQ3Z2SzVIdGYxS3J0aVo4N2JRTUdhdmVuUUVFdWF1blZF?=
 =?utf-8?B?OHdWRWJUSFdOT1dESW1xWEl5anRvNSs3MU1KaEpBTU4zdVJmbk9LcXVnVUIv?=
 =?utf-8?B?VHJWb3QwT0N2bTUyVDE2Y0d0QnRkQXdLdlRJYXRhTUVkMkNoTTNyWHl6MFh1?=
 =?utf-8?B?VmNYcUtuQk1yZGVSOGFWNWVhNWlmTTRoV09QTUN0YmI0elVVWEZZMENiRjBj?=
 =?utf-8?B?eFZNUGkyRXdONVZOM3BJZ0NLelo2ZnF1L0ljVW91NjJmNzI4MVViMVNETzJr?=
 =?utf-8?B?VVcyMGVQOWt6NTNyOUFSSDcySGRaZTNUTmdyK2s3ek5qSjNPRE8xcFBYMXZG?=
 =?utf-8?B?d0xjOThrSEk4VHk2aWc5V0JkbzFtYjlzTG93ZkhqSS9zK25hYmpLZ0txOExQ?=
 =?utf-8?B?T1Z1MkNQcEZZazFjL0o4MDVmV0YvcEIzVTFkUFlHUXY4WkxYWFNpUVdsb0Ro?=
 =?utf-8?B?MzN2RUVBaWRpNlVKZHhtM0FoenlHcFM1azB2Yi8vNU9oOGs5bHJocGRiR0Nk?=
 =?utf-8?B?ODlscHhTWFZKMWlhNkVKckpyZ2g0TzhmdjZEdEk1NHlyejlKVjZRcVZqNDF2?=
 =?utf-8?B?bWVpR0hWaVE2eHg2Wjk5L0lGb0s0bFJCQVB1bXlyVk55dllZMThnL3BNNFEx?=
 =?utf-8?B?UGgvOTR4Q1JEN3dEZlNET1draFV3LzN4NWVtck00clRMTnhSM1BzTzFTdWdJ?=
 =?utf-8?B?WFlMTHMzN0xqY2lNc2UwWThPMWRTV2J4d2RXK0FSZ29oaVp2Q3Q4VGlwTFlJ?=
 =?utf-8?B?czJYaFdiMCt2bDVvQUNFRzdHeFRhdEg4MTIydG0vUDltakN0NzkrRUZ3UHpO?=
 =?utf-8?B?ejBzUm1iblF0Y1JMdkZsMFVCb1FlOVIrc2gySDdvQ0IvMmNnQm1SdWttN3ZG?=
 =?utf-8?B?TmpKTWc3TDVMcGZyU1Q3UXBtZ1NUaWs5VldjZDJobVdzMmhSY0RpL21CM0hC?=
 =?utf-8?B?OFNwbC9Ec2F2djZEL3E2OXduK0kxS0hwVmQvNHIwM0xZaVU0NER4alphQURl?=
 =?utf-8?B?ZlZXNGRwcnZRQnM4RVZmUmxTaU84NDVkN3BjQzdYNEZDaUhtUFlSWG4xZDdj?=
 =?utf-8?B?UitHdXhaMXVETCtKTmxlRjk3akE3MlBNUUdsR2JaMGlNOXhyQThxNGhXcU9o?=
 =?utf-8?B?SGVuQUVGQ0FQMFZxeUdvK3JBVWw0WlM5b3g2MW4yaXp2aHByRTQ4S3k4Y0N4?=
 =?utf-8?B?OEduMHQxbk43ZDJHNjJpVzU3TlhBNWw3dXl6OFROa3ozNEd5N2lodEhvcHRL?=
 =?utf-8?B?ZnZCeU9NYzVXUVBQVmFGR2VRZjZ6Umk4bG1SWThtUjVUQUZBMkdvQTBHRlJh?=
 =?utf-8?B?ZjFTaCtvdm1kaHR3dXEzRHUxaGRQdUJZQnVoZ01SZ0txdjdhcTlrWFdBdnpv?=
 =?utf-8?B?NUxuZ0VOY1BkbUEwZ00vVEwxMHBvS1JhYTcrdVNkT1V2MUhPd0RRQ0ZIaGdj?=
 =?utf-8?B?TDY1elhHNjRJV0lMeVUzTG1WeStsN3BOcW03cnY1ZVhEblV2QzlCZEFOQ21H?=
 =?utf-8?Q?fD1y/T4SdyNWN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3JOMHFmNWZXTkNjUUhmRit6ZUF1K0FmaE0zTkFLSGNWaWtXclJBOEZmZm1r?=
 =?utf-8?B?TmpENEVFVjg2cnF1Q3REenNaRmZDaWtYcmlNK0dRWXZRQVpjd3pTWDZGS2lq?=
 =?utf-8?B?OG11OWJPaHVCdm4wNDgvdFp6OGtuOXBubGs4M1R5ZmViOHlpK1UzKzBLODBj?=
 =?utf-8?B?UjRWUDdrN2E2cFFqTE5tRWdvTDRBbWlWMGJib3IzL1BuQkRMQnJQWjAwSStV?=
 =?utf-8?B?ZEJuRG9xY2o3TVdCYmpDK2lpS0dpditsSkwzNndwbFlrTmRaZGxvMnRTeTB3?=
 =?utf-8?B?YkozbEREQUF0SC92d25LaW9FQ2FvZk5aKzVVWkJGTjI1Y0lKcytJSC8xSnZE?=
 =?utf-8?B?ZGxNZjRFdmhrc1d3R0FwWHhsaGN6SkQ3M1dZM3UyU1JHWVFzSVVFVmFXcmJY?=
 =?utf-8?B?WVZ5Q3QwV2lFUVhTbGdnM01mRXZiUHdCeHpzWGgwRlEySVpHY3N5VXB6UFB0?=
 =?utf-8?B?emZvREN1cjZldTVXSFppNzNlbDBQOGEvQk85U21CNHdoTGl6TmY4cnovZnNl?=
 =?utf-8?B?RFBFMUlJNS8zaUZqckNrWWxteXNKcEE4SC8yMVBnK1pMb3lOdTlLYjdQU041?=
 =?utf-8?B?OWtFck1kbjlhSWVEYm1XSXYyY1pvbkU4RlVaa3ZYNStwMWJRcHJXUm9YbU1W?=
 =?utf-8?B?cEdrb1E4TXl2TkxWbytKY1VKdDJZMHpMRUhzbHdvVTRuUHdtNmtvVy9yTU55?=
 =?utf-8?B?djNHNXh2Qk9VNzBDcmI3L1o0T1NrRlA4Q3J0L20rUWdBa1lFV3UxbkIvc3dr?=
 =?utf-8?B?czZTWndZVVZhZ1hNbkZDLzRjdk5lQ1ZJNitFbzlCdTlJYXlWdWdwaDdOTnZK?=
 =?utf-8?B?bTRyQlBVdFZ1STJRT2JaUzlNNkR5UkhoKzdjYnZOYTBNV3ZXcmhlMHFwT09q?=
 =?utf-8?B?ZzlrZnFQTEVCLzg1a3FpRW13Qy9aUUw4SjJMRHVPSWNoc3lQTi9tT0hsN2hD?=
 =?utf-8?B?TEJxdXVodUZ1T3k5cXFPVWN2ZjV3ZjNtR2xWZE5kS21LQllLTFQvWVp5b1Vw?=
 =?utf-8?B?NlI4WnU2aUJmM1hRSHBveDdXSW5pdkFhVm55VTE3ZDkxSlIxN3F4bEJjR1BC?=
 =?utf-8?B?ZHdzVC9NSTRrY3cvTkp3YnRnNy9FYUdBckREVVAwb0UyT2RCR0FyRS9QcWRF?=
 =?utf-8?B?L3M4S1dOTFpCTkxvWDA2ekV4akpHRW5wSGdZMXRmYi9jSlZ4YWsyTTc5Yi9M?=
 =?utf-8?B?UlgvY3lYL3h2Wk5vOWtOUC9JdldkalBTMVIrTzNjQUJCTGFDTndOcitSOGN4?=
 =?utf-8?B?aDl5RG9jVWxEQXRuNXhIbC9sbzlTOXQ5TlloUXJNODVvYU1Sc1RwMmZNTDg1?=
 =?utf-8?B?cTdiYno2enUwQkRpaGlaQkZRek12cFRUbFJ2bWRCc3Q3ZXNkMmFJd2hhS1Vs?=
 =?utf-8?B?Tk52QXlmL3l6ckd6a0pCcU9DdUhhaGs3TXJLWFQ4QXV6c3ZFYkNHZlNlRWtU?=
 =?utf-8?B?ZGFyam43LzBJSUxjN2FPSWNzdVk5RzNQUHd3bjlRdjFDQk9kaUxmOVlNTW1K?=
 =?utf-8?B?U3ZOWWY1aDJ0RnBXRjU2c2ptOHRkenJDdVU4SXlTeEdmeVpqeWtWQXhGbGFJ?=
 =?utf-8?B?cDZZUWkwbHZ3SmtQWUhwZFN3WGlOM1g1cDZlUkg3dHk2RDFOMUtKRnh2dVJE?=
 =?utf-8?B?a1J2cDk5VmpOWS9nYm1vK0x1OEpZV28vVGUwMVU1d3k2VGUwNVExUkhSV0N3?=
 =?utf-8?B?N1dVYTU2K1Zub1F4YzF5RHlwMHhNRGI5SEhxOG1hd1FLTGlJM2U1QWlsUk44?=
 =?utf-8?B?VlhBTzNFeFlqak9qNFFmbkpQUVFsZFM1NW4wY1kzanJBdy9SVzN0MVNxOXdS?=
 =?utf-8?B?ZjhvKzNnUzBKbWVUazZyYXZOWFA2V3ZIdytRWnlzOWRudTFEbnoyOEVCdnFB?=
 =?utf-8?B?Y0ZhRnJXelBibVpDNmxXMUJ1a3djbVVQYVM5a1l6aGZOSkVYdjZkcWwrOSs1?=
 =?utf-8?B?OTBKQ0dqUnhJUVQrV20rUG9qT0NKSFdqODFxT0QyOFlXNnU4TjdTQm02U1E3?=
 =?utf-8?B?dUhnaEdPZjMzbTR0M0FEVkt0WHFra2JnczBrR1RGRWF0SFR3ejNvNEE5RjVI?=
 =?utf-8?B?blBjUGMrVld5UFVwNjVhRnpKT2NOTnY1UGF5ZXEzRG52ckUyU1VvVTNQTWd6?=
 =?utf-8?Q?2fizFMbsALcEbYy3gq0WPa6It?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ac90d9-32ae-430e-1472-08dd200e74fd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 09:21:02.3034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w24pyLzG8/GG1arIup8M3lnECbA2U1FWVmJIg/65G+YpMkcnuljKJZJkRdEPoolaavQl4MtCn8VADU14SA19oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9834

Add support for reading multiple registers in DEV_TO_MEM transactions and
for writing multiple registers in MEM_TO_DEV transactions.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
---
 drivers/dma/fsl-edma-common.c | 36 ++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index b7f15ab96855..443b2430466c 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -480,8 +480,8 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 		       bool disable_req, bool enable_sg)
 {
 	struct dma_slave_config *cfg = &fsl_chan->cfg;
+	u32 burst = 0;
 	u16 csr = 0;
-	u32 burst;
 
 	/*
 	 * eDMA hardware SGs require the TCDs to be stored in little
@@ -496,16 +496,30 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 
 	fsl_edma_set_tcd_to_le(fsl_chan, tcd, soff, soff);
 
-	if (fsl_chan->is_multi_fifo) {
-		/* set mloff to support multiple fifo */
-		burst = cfg->direction == DMA_DEV_TO_MEM ?
-				cfg->src_maxburst : cfg->dst_maxburst;
-		nbytes |= EDMA_V3_TCD_NBYTES_MLOFF(-(burst * 4));
-		/* enable DMLOE/SMLOE */
-		if (cfg->direction == DMA_MEM_TO_DEV) {
+	/* If we expect to have either multi_fifo or a port window size,
+	 * we will use minor loop offset, meaning bits 29-10 will be used for
+	 * address offset, while bits 9-0 will be used to tell DMA how much
+	 * data to read from addr.
+	 * If we don't have either of those, will use a major loop reading from addr
+	 * nbytes (29bits).
+	 */
+	if (cfg->direction == DMA_MEM_TO_DEV) {
+		if (fsl_chan->is_multi_fifo)
+			burst = cfg->dst_maxburst * 4;
+		if (cfg->dst_port_window_size)
+			burst = cfg->dst_port_window_size * cfg->dst_addr_width;
+		if (burst) {
+			nbytes |= EDMA_V3_TCD_NBYTES_MLOFF(-burst);
 			nbytes |= EDMA_V3_TCD_NBYTES_DMLOE;
 			nbytes &= ~EDMA_V3_TCD_NBYTES_SMLOE;
-		} else {
+		}
+	} else {
+		if (fsl_chan->is_multi_fifo)
+			burst = cfg->src_maxburst * 4;
+		if (cfg->src_port_window_size)
+			burst = cfg->src_port_window_size * cfg->src_addr_width;
+		if (burst) {
+			nbytes |= EDMA_V3_TCD_NBYTES_MLOFF(-burst);
 			nbytes |= EDMA_V3_TCD_NBYTES_SMLOE;
 			nbytes &= ~EDMA_V3_TCD_NBYTES_DMLOE;
 		}
@@ -623,11 +637,15 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 			dst_addr = fsl_chan->dma_dev_addr;
 			soff = fsl_chan->cfg.dst_addr_width;
 			doff = fsl_chan->is_multi_fifo ? 4 : 0;
+			if (fsl_chan->cfg.dst_port_window_size)
+				doff = fsl_chan->cfg.dst_addr_width;
 		} else if (direction == DMA_DEV_TO_MEM) {
 			src_addr = fsl_chan->dma_dev_addr;
 			dst_addr = dma_buf_next;
 			soff = fsl_chan->is_multi_fifo ? 4 : 0;
 			doff = fsl_chan->cfg.src_addr_width;
+			if (fsl_chan->cfg.src_port_window_size)
+				soff = fsl_chan->cfg.src_addr_width;
 		} else {
 			/* DMA_DEV_TO_DEV */
 			src_addr = fsl_chan->cfg.src_addr;
-- 
2.47.0


