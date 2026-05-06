Return-Path: <dmaengine+bounces-10247-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIvRFGOp+2myewMAu9opvQ
	(envelope-from <dmaengine+bounces-10247-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 22:49:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A4B4E0637
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 22:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 778D4306C3F4
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 20:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F283B0ADB;
	Wed,  6 May 2026 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h1jn3S1B"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013071.outbound.protection.outlook.com [52.101.83.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB2D3AF660;
	Wed,  6 May 2026 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100288; cv=fail; b=aiq4EiPR9CuvkYolTOVmYAfU62UsNHtmANQxkSLYoTyTEYwcLXzzWJd2SzLcZzxzP4JRBvcCtjXrqXHEntqAxySetjTVrS7KjV9rRxqgOnUKgfRAY1iRKPGbT/e4EK39tfkSF0NScQ+UTARs36YvbxXl1g1VoEN2yBzqYGskpSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100288; c=relaxed/simple;
	bh=5Ht3OpV64qQBJF72UE+o9BDFv/FIRBIdPMczb03BKkU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=renP2dbTLZzzTwsv0MDhj+gJNDuJ+JPBKCj35heNUOhXM34PbUgsCKKzSlDafTSrbVvaviOSbxPRXboopL8Z2azBndbQPvTtawHpgtvC7/QN+z5FW24TgUK1lwsYNBbpCgqVlUeB+qEtT2xiDf9qvNTxc0CRlD9LePBhK8fmoAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h1jn3S1B; arc=fail smtp.client-ip=52.101.83.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWo+ghL/9k5Vgg4M09kfP6FhiWvHpoB4w6e/oVkYhedvw5HAl1ZLEKMzp9IPldfqo88W307kIBU8Q/B85j2wPQKhxyInL1eY8CONote4VAZ8lSlS++U+evNvbJobjD0k/iuLussVhWUpv6rRM8l/qm6nv0JKEWUIWNCDACCYFelgdsQMRxDUR7aqBcjGZteqbpnPz6VJXQ/nqEYxGKbfQgiaOMaUXI2Cte/4AgZVkHAy966V2vVRnG8en6Bi8wG6dwGS6JsI4QAWZ9FHGdJ8PC/cGKJ8qQcrEdCqsTKtKLqMis2XCzhI6RHEApcUEGEBNHQRd90S2ZVqD48ItwGx3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8QTXNED7ZIuZSaGEpmFtKE9Ea58WrXFvajE8xQTBvM=;
 b=EVntTRqp9m+H+ScynZoHfPqL1bsI5D012lIyDYLS32puu4E59zii1pV1jyFfPg5zJu+OPk+IzfrLqSTiZM+ZRUw8fZRXnmYQCnA+Xi8IDVzKyrPbqS7aHEY+lUkb7gBltEzrRSf+b1fk7v751X2LFyoGOyF4HCoOQSXk8ZEaMm7MeVH5z+m2LUuq+R7QfAlxVZwQPdz6aWrxwdRYxzUDrf+pzwtTbRQIp4u4QVms3bzgvusTD/37SvONhjhM/OJW0S5NQzKxSwEkoZAvFdGklRUpzNikfZpwZuhZDxS0kXOLYgsUDtecdcPzK11GcVT+ZHEZBEZ3ieBwsCERQjUXOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8QTXNED7ZIuZSaGEpmFtKE9Ea58WrXFvajE8xQTBvM=;
 b=h1jn3S1BSacugPug/u7NThQqDKEJ6qR/m7yZqVhwpBf1v92AOUM0AUe9VK3mmKO8Ww8dzMbrqBUV5z+wEU/xc3is9i/SRqIHZulpWRnI5AiKviBt/YmfZ/ouXpv3s9wXd1MtiaenGOOOloF0k2RTQqckoexSw/CZ5u9BQsGCg5c3PMRkaV5pyrW51A0R/qYge5awnWzNuohfdzljIUoHeoEauAlhwCL4toyyg/lzzaeYJPuQSy33nyeKqYqFEuPeL5q/yBEFzlq3YK5iJap1fZaiV0jgK20K1BW10tBlFpjnCSkCRBBw8tTvLZIPE/pDnlnwyY24cCWWmqaagVyZog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by GV1PR04MB10479.eurprd04.prod.outlook.com (2603:10a6:150:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 20:44:41 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:44:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 06 May 2026 16:44:15 -0400
Subject: [PATCH v4 3/9] PCI: endpoint: pci-epf-test: Use
 dmaenigne_prep_config_single() to simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-dma_prep_config-v4-3-85b3d22babff@nxp.com>
References: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
In-Reply-To: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Damien Le Moal <dlemoal@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778100264; l=1293;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5Ht3OpV64qQBJF72UE+o9BDFv/FIRBIdPMczb03BKkU=;
 b=+gyRCk2F2wDoHpaQqe7/bP02FVQZ3YlTJjqGMMQO8UIfMxP7fQkdJK8BmkYkQMRH+fVNE3fME
 5vf9NoxHwYpAlAoy6UCjH8crUY1HgCBwvgIECeUhJPKcirqQ3irp7yY
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0051.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::24) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|GV1PR04MB10479:EE_
X-MS-Office365-Filtering-Correlation-Id: 17259e45-42fd-4a50-de52-08deabb04c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|7416014|22082099003|921020|18002099003|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info:
	bAKJL5w3hb4zgbGg/UPX1sZVuIRXTSmEvT20MIP+GktDJldfdOi1k+Tv1HY+N4OVDnyUmrJvLw1aYr4HuV2rJFuuHUbeqwQJRtyrtySy2XICX06HNGPRB6jGVXcb+TOq/wFRwk2HV9XsnnudVQVeNIAwtwdoFP20JGYVGxF8IN1RxN3+wc/Wms21EwTuoi4Zv4sJhuRi5W8emo5QGBniPTsZa6lX9lBkjil1ek7mUYEnF4kgAGub3ayQtweuTidXeSCim/GAYHcHF1/s2wdM4MnA69Q5DAPFTR2/IHrJ0j1hT8GhsVfYVh0BrEH1ogfXzXoqI7rgCk2K//hb8Kod5IJLH13y6v0qW+DdFf5oErss77R/zCAuF2co3A+e3qzZCeHQUCEMEhzKV51x+t3u73dhvKKJ6pjijDRsBg7YRs4NmgYR6dwMXGh5cB6qWWqv6w0faBJDZz6ZAr1fnDou7BPj0lD1gNmb862fL+Ti9bPzLFhJxJe7IIrQYZ776wecFdaMwU3i28HP2eXCMBIV7lHCSQFs9U+tLnym2gf1+popzd6+O0W/G5x6hBvm4+/03LMCCDCwQx+l968jwCfaK6TbzDp9xD903hiodthLfdfX3h/pQoegud9xHhOgD9Pkv0RgyiEThekjwjfhA3cQsmf8lO95qfZ7QqCZDYEYhYBXbqvtYOVUUfl/TkUTBoqvbSnTyFpuWhLKDtEeOeoRJWkocyYJHSkVqfp03F9hwfq/Hc/S8egnP4pSoIZ4aSfA539VarWzx9lxAVaRg4q45Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(7416014)(22082099003)(921020)(18002099003)(38350700014)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVpuOEhJV3pCUXNaYk5rM0s5UndVaE5rWi91a1QvRG9DUVU1QWZDOEYyZ3hy?=
 =?utf-8?B?RU5MRjhGeHF1cHl1a00zcWU0LzVsUVdPaGtzRVBaNlM0b1MxdVFKb1graW1V?=
 =?utf-8?B?TlVOUHc4cHprUmZDSUJOajJMOVFTTkV6ZEQ3dWFSL1plWStBTXFrdDdnRHh0?=
 =?utf-8?B?T1pMQXVUQURtUXJSVzhjSXhxY1J1VjNCRlJPSUFySENzaW1ZMCtmUm1qWndj?=
 =?utf-8?B?cEM4L0tpRkltWmtIN3JzcHVDcWhleTAwZjZJSDdSa1dwTktIejZhV1ZYdExY?=
 =?utf-8?B?MEtCRjFLanNQdjVWZ1N3YWxjR1pVek1zWHkxSWdNWUI1eXdmQzUzOGVzM0J3?=
 =?utf-8?B?QkE3MXlBZFIrMUk2UVlhVkU4MmpJVEVYQXB6VWZRa2YzVXdaRE5JemZGTUVN?=
 =?utf-8?B?VEY5aGQ4YW9RVlAzaERDK2NZN2lHU1BKR1Ixb0JMZkFBa1A4ZURiMW0zbFlZ?=
 =?utf-8?B?OHU1VVRSMWk0eEcvdlNjdjd5MW1mSXhCWWQ3RVVxdzgwUUJwcVJWSkhoNjZH?=
 =?utf-8?B?czZyZ3RTTHhKSzk5OXRENHhLRTBmT09PdDJMK3RocjEvYzR4dzRBREswQnFo?=
 =?utf-8?B?ME1RYnVaaGpoN2ZUQ3krNEdqTzQ2MUpVZFJXTjhtK0dRQ2M1WVhSbnF2dDVF?=
 =?utf-8?B?K0ZuN255VWcvOXNaeEpualRrT0Q1UDhtUm50NVpvSVhCdldLVjEwSld0U2Jj?=
 =?utf-8?B?L1BlQzBJVVRIbmR6bzJ0QVZyS0J0N05TT3RBdENPbjVHbEM2Q0RLbWtkQ2RE?=
 =?utf-8?B?dUtoWC9iY2g4dGkxZG1WYXpUWS9wY1dWRnJvNzdsWWFFNE5FeUV1cUFOdFFk?=
 =?utf-8?B?MHVGdk10b0NOamZTL3Jnb1I5NGkreTRJalNDOVgzQXlrTTJ0SDg3cnlqbEpl?=
 =?utf-8?B?b01QWTErT1hFSXp0dndGVmozZWYyZE9FZ2piY2ZLOFRCOElpeFk4YzQwNTNU?=
 =?utf-8?B?U3J1Nnl6MDBVTVQxZE81S21JcWNKakgvTyttMEpMeW0rSDNkYVVETG1oSjdw?=
 =?utf-8?B?bENialhGKzJtMVA2V05hYzczWlFVTGF4UnJwUWFMc2JCZzUxdDAyRE5ua1Nn?=
 =?utf-8?B?NmlzTTFGVk5pNUlldXZzRld0cWtTcFJTdXJWaHZ1THFSQS90b0N4aHk0bmc2?=
 =?utf-8?B?WDE2aUVtWGtaTTJqdlJJMGVjVXRwSW1CZmVDQWtITlc5OWtkVUFzTE5XL1ZB?=
 =?utf-8?B?V3V1UDlEMU9iVjRscjRtRjBIeUZGUTdaTWl2UzYvRHpianVmUVY3T0Z1cThW?=
 =?utf-8?B?K2VseFpNcHBKNXR4RFM5cGtnQVRnWm81encwWkZWMnEzS3gyRTNubVljb3pV?=
 =?utf-8?B?b1h6aU9BU2hLaVZnaWVKL0xSZStXUmNUQlI0RFZvOVRib0ZHTW9WMWZIazdj?=
 =?utf-8?B?dmV4RzNxZUVac2ZyS3ZBSHM2dmRhVHlkeXF2bHBxZXk1LzdDNTR0bnZEMVBV?=
 =?utf-8?B?dmJkam9VbVFQS0p5b2FDQzcxQWlmVnhtSjFsSm4vUXplaGxCdGJQcDNzMGZ4?=
 =?utf-8?B?Z3Q1d0F1N2hVd28xdGRZZU9qMWU2TEtuR2tPQloySDRDUTNyTFhYUGMxcUNS?=
 =?utf-8?B?WE1zYno2MWc2YnNORUNYbDdMdWVjZHRRU2hSbDRFUXlOSkZYYzVPckpESjFE?=
 =?utf-8?B?dGhWUUc3UFk2R0prNWpjUXYyN2xENU9qcEJqQmQraUF2M0djZFZuNWZ6YVU0?=
 =?utf-8?B?R1pSTEpQeXFWSytBRjdlRTZ5eUZBbjBiNTluQ0daYkVTeW1pNGxiL1c5WHY2?=
 =?utf-8?B?a2pxWW80VjB5YVNOOGt6dXJYTFlzMmhYQXdtOEw3V1k5VEZHbzZhdkxxb2hJ?=
 =?utf-8?B?NHAwZXpjRzYrZnYxTDBaYy9VOVJpVWFibXVpUjhocWQ0c2RDYXhSV1FESUFs?=
 =?utf-8?B?T0NWTlM0RE1XRlNpdHBrcEtsbGNsTy8wWVFpT2ppNFVqZUJjWWlWWmpNdWM5?=
 =?utf-8?B?UjAwQlBMaDFvYkNzSjIwejBsSG02cjdmcG9HVmJWNWwydGhDN0FqZlc0dCs3?=
 =?utf-8?B?SXBpNVZjcGIxQWFId3BQVFJ0ZFdmb1p2akd6amYrUmtLNEVWM3JkRWxXU2ll?=
 =?utf-8?B?WW5yMFBYNHZhNXNpVGpSM2lJQ0NWbjlGcFhlSFIwRHBkYUdkcU9QTHZxU1Jt?=
 =?utf-8?B?MmQ0eTdrUmlZMEtIMk1tSnlXUmk2OUdEUE5qU0hGNDB1bkJIVXV4NnRHME10?=
 =?utf-8?B?QlBNMk9JTG9Fc2dJa2FLZ1pKQ3dHdUx3V29UQUo5SVVYZHhsZFg0VjllMlhR?=
 =?utf-8?B?QStYUCtMTHJNeVRkQ2ZMQ1d6TDFGZUZJUFA0bGkwYnJkbEQyR0FDR05mTkk3?=
 =?utf-8?B?TklIa2hMQ0RlZmxOZ0ZJMXFGNUYyN1BOMU85MG5pd1NlRFppWnhkdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17259e45-42fd-4a50-de52-08deabb04c14
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:44:41.4021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1U0VTTU8jZ1DuGSyyTlC2/AgsvDs9egKwYhKF0RazeZiy59hl6qStBiiPVrWZBgwEas2Ccb1eXOF5YpuZ85Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10479
X-Rspamd-Queue-Id: B1A4B4E0637
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10247-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

Use dmaenigne_prep_config_single() to simplify code.

No functional change.

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- add Damien Le Moal review tag
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 591d301fa89d89addf5df16e775e80460b689589..0f5cf2d7951088af3801ea1cc240b2ea8627eed5 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -182,12 +182,8 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 		else
 			sconf.src_addr = dma_remote;
 
-		if (dmaengine_slave_config(chan, &sconf)) {
-			dev_err(dev, "DMA slave config fail\n");
-			return -EIO;
-		}
-		tx = dmaengine_prep_slave_single(chan, dma_local, len, dir,
-						 flags);
+		tx = dmaengine_prep_config_single(chan, dma_local, len,
+						  dir, flags, &sconf);
 	} else {
 		tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len,
 					       flags);

-- 
2.43.0


