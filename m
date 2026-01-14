Return-Path: <dmaengine+bounces-8258-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E73F3D21991
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 23:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACECB302C4FE
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 22:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED573AEF51;
	Wed, 14 Jan 2026 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BbehcyWc"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011030.outbound.protection.outlook.com [40.107.130.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B43A89BA;
	Wed, 14 Jan 2026 22:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430057; cv=fail; b=mcEXCL6K18D+YI2taVGpaxBX0JtT9q1deE/Ja7n27ZoXsrefnQk5Q9MkajObgZHgWxkdzQ02FU6/OrbPkJbGoe6gXqcP9QFwMNqvN/I2cY2Xb7FhFSjl1MVz+nkvTWtC16jbg9LoGCXXrEmoID+V8l5/8aqUimhLNwuJ0625AO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430057; c=relaxed/simple;
	bh=FhgE166InUFFz2TVMogatfGmbhHKQUHcr5xgZhzrrFI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Se5sP7+6Cf37ylTWn5uch4KxwCOaNGHpyYTPjr0LhTcMJ3Vv55m2EzM2TidFO6V6OBmTDDWS3i97sgTkXuULAfvyloYKdkSu5WstYpV77JhE5OMLk3HAFR/8WjwDRDtJbEsWGhvXhu15P1UeSmKrfHkoqaglgEs+sHzjbBFdcio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BbehcyWc; arc=fail smtp.client-ip=40.107.130.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7p8NK4YZgsdUN5PFdqG6UoBlNlBD+D4IjRhLHkMG89RLLD2poqoa8BGy6D1Zysl8vkmD8KYso7Off7slJ1g0t4N0HNzSuetH1tFQMNGh/qUk1wCvCVkUWBRoKI2VoUOllOUSjmO0c7yJf0HWvYcuJ/A1UJgmPCdz7sdbk7NUpD0sSiPYxexnDJcdM84EVslGZQfpaSt8UrNbeaHuwKXSDX8KKy3XLm6jEOJO4ksCcR0wSPN64JK+hTm2eD4IuisyZ1+CvOUIUzJuMlXw2LLtHo4c1saKp7NKyvugkNElbIx1b1DQZ+xqSJJ+zzr3MAgKvrAfWEiP40i1jckUPA2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4B/cq6xwUQGr+xm/k4G+ErwjehZENnowV16fN4L6XEc=;
 b=P0kFyhkrbyTaJ/EftBhjimIfYOxbbsYkrB/2boD4iWlrIP8LCnjxlFTEdnPpLXixHtOcbN83vgH3OCcMPZ3PDT9uO+q6vrhoeoJacwCatF9mz5cOENqTjkNiif64rG5QCCBJt5wfV/rWKkaxF7jfmcTUfDnuzczlNpH/NFPfp6qEgb9zuRCcxcYzVjDztqXOCaWwAWRgyrn9G5KnIj9iBd5DiNQeaudWRNN9MjNSa4HuydZI4boKCMTQzbC5LCgGdmP9K+hlUESubn6QJh/CPbg806yAk1bOZ3c8/FHKZqbHGS698kq1HoB7o7kVle+T3yRXR4IVcQzwyIePzK4NhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4B/cq6xwUQGr+xm/k4G+ErwjehZENnowV16fN4L6XEc=;
 b=BbehcyWcrGgfrOngGHpmZQfF/tsNulqXHtTF9wU/XLIHew2NPftBXmPzdlW09c23ogOKRb/5z3fDWFTXug8EWv0Qqf9CKE2mHHcHlmUf25CZ6hfkpBgBNaT/e6GhaDIrNbQ91qlffkUj5S0683i2yHMUWL9r6Pg6OoyoHQ1+FA9vj/5czhMcG+aPjDQ2Ki1C1ivet4HE5/Uj6yBI9FjFQ4jq00JS9fiOzW2hQbCf75s7cQae7r5iRDaxmmUr7VJEoY4cBfOV2B7GyK0rFUEGyn0NVBeZoxinViqY0eevSbS7cXnztcRw9TLDNvLQV5dqOYmARL3aa065IxdRMnP+fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 22:33:56 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Wed, 14 Jan 2026
 22:33:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 14 Jan 2026 17:33:16 -0500
Subject: [PATCH 04/13] dmaengine: mxs-dma: Use dev_err_probe() simple code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mxsdma-module-v1-4-9b2a9eaa4226@nxp.com>
References: <20260114-mxsdma-module-v1-0-9b2a9eaa4226@nxp.com>
In-Reply-To: <20260114-mxsdma-module-v1-0-9b2a9eaa4226@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768430015; l=1565;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=FhgE166InUFFz2TVMogatfGmbhHKQUHcr5xgZhzrrFI=;
 b=eWUhCTILapiE9y2G+/R3SVNmLLrW/57tgoyjqLRhA9wlXVUU3Q2wPXt895/iLc86EwO0Gy4xP
 wUWF1LnTUPnBlciHe65W2jhhcBDFM4r8YGX1v0BK1gH3IvmvjN2O0/k
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::19) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: a037c40d-4de6-4b8a-1114-08de53bd0091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlVLS2ZsYzBORG5pajdFb2MvMTR4N3VDd1R4eG1NejlqK2xkTHJkRXNGclN5?=
 =?utf-8?B?QlVNS0xqZ0Z2UTFFbkNTL1RKS01GTUtFNGZWZDQwVUd4VDN1cW9hd2lYaVJp?=
 =?utf-8?B?d0o2UjRoYUVaOXI0TE9rVkpGOStZM0tmODlWenBudkFFdndDYXlnWkEwOE5R?=
 =?utf-8?B?bU1HTkFvT29ZdmRmWVVUbHVFbUFYSmcycWtTOFRnVmZTeG9kTmdSSm1vdTRx?=
 =?utf-8?B?UXBRWUtxdk96bk55eGpCZGJGUkVwZWJYZG9QdDVVQnhEWGxXWlAra0IvV2Y1?=
 =?utf-8?B?elc2S01McllFRWlmSFpQTm00Z2s1cVc1bVkzT2dhR09NYmoyR2toV09WVWUw?=
 =?utf-8?B?ZGI1Rk1ScEo0OE9xMVFLSjFPMHkxV09TaFdjbGVhRHQvbmFDbzVGaHB2blZ5?=
 =?utf-8?B?bXhxRGpMUVhIb0syajBNblVwOFNNS2RVbmFjSXhGbHdhd3BOS1c1QXpSM2NT?=
 =?utf-8?B?b0hiN1FUNTV3MWJDWTVCS1ZHSUJDRER0Sk1WNURHZndielRwWGQ0SlRPaE1Q?=
 =?utf-8?B?UTJEQmVkVDVmVk90U2pQNys2SVVDQ3ZCYXZ3Z0p3b1NrTVlCME8wdllWK3VM?=
 =?utf-8?B?azRDZUVrVG15RnArSFowbXpXeUFsNlJkS1c4azZoenpMZEtKQW5wQys4RzJC?=
 =?utf-8?B?MiszMlUwOEZacDRxYjZwcTRVdDdiTVFlVWVhZjVWY2g3bjF3L05hNWdMUlEz?=
 =?utf-8?B?VFNaN1pDWHFUSUJFemFXRnVJQ01IcEVJcjdoQUNZSVFudHc2Y3RjbENsb0Ru?=
 =?utf-8?B?a1MwUVpLc0puV0VBS3M2UkMzaEFpb0g5NzQzWUs0TmtlWnlTS1JzTm5UNkJX?=
 =?utf-8?B?K2EwMTdzQk5XMHZpUEZEWlVLNVBhZDFFNHRvQXRYUFMrU0s4UTNwOHFIdUZN?=
 =?utf-8?B?SGQ2c241WFFQWlhiVFlacDBqcVpRT3BoUGdkUGVZellXeHZXSlBSL3RUTEUr?=
 =?utf-8?B?ZzVlVTZ4NHFqMUNsTnB1eUs1K0oyemtlcDZYNVZVenlnOTJIdFpnV29DOFVv?=
 =?utf-8?B?YlhpYkpRbHdOc0gzdG53VURrYk1XaUtaSmJ3V3VrQVVNd3FJSExTak90cUZH?=
 =?utf-8?B?STVTNHJDTzNDOXNHSEFHLzdWcllSaUY2TC92S2x5QzFtMlJWaTJaaEZwaEN4?=
 =?utf-8?B?b29MNTJhTmhwc0lGL3VaOFBPN0JOQU9QNkJobkJjQTN6dFpUc0xucitTbTQw?=
 =?utf-8?B?bEgzUkF6dW5ZR28vaUh4UXVvQ3Ztc2NjNFU2YW5ib1N5U2dnbjRZSFJlNDc1?=
 =?utf-8?B?NFdOc0ZEY2k2SjdvYUNBZEIzd3NpQytLNEtFczhwb0ZlMnREa0dwU2Q3YmhR?=
 =?utf-8?B?UVNtK0MzYXRXaGdQTDhCYzZhQmZpcDBSTmNOOExvY0lRbmJoZ05kNVYwOHZQ?=
 =?utf-8?B?Mk1yanF6dVdBTm12SjJPT0FmNnFxUnRxK2pRcVFRa01ldEw2aXptTmFlQjVS?=
 =?utf-8?B?Q3FIK2Z4OEloNE9xOVEzZ3ZHUS84N1ErbytMR09oQ1MyQnVZcy9CU1M4TUhs?=
 =?utf-8?B?akE3Y0RsQTdFR285UjRwQUhVUjdtMlBockhMb1FtZ2kxdFlYaXRZdjY1Q2Qx?=
 =?utf-8?B?L2g1UWlYdzVpN1NqSGJCc3M0UE41SmU4eUN4VmxFd0ZIT3p0NGNGWS9UNVFn?=
 =?utf-8?B?bVlpRWVGdDlHdnA0ZlU4Qnc2M2haQnRJRGpqcFNvYUlUeWFoUHVIUlF6c1Ar?=
 =?utf-8?B?SlR0NzhFVURlR01wUE1OS3l4ckxESFVSMmNKWFBTanA2QjRMZW4yYzFETGQv?=
 =?utf-8?B?OXhlWU1UMWFhN052dFlpdGM1cmVuS0dmc0FQYzRLVFg4S3VFSVJLb1hLSnUx?=
 =?utf-8?B?MXFyeExFWkVrWXdJTzJ3TGJLR0VmWnFrRUN1aFZQWkRhcnFsZFpWU3pvdEUw?=
 =?utf-8?B?bmlRbjFYUGJnNkJYeUNKKzdXbFgzcEpMMzNwZldqYmwyYlBiVG1WSEpNQWJu?=
 =?utf-8?B?bmIra0JHblpvZStFNlpxYWVPbWErM3ZXdHRaMmNCMmNwcXR3K21zV2FNREJ2?=
 =?utf-8?B?a0pqcDNQN1BqblY2eXo1YWMwbkFKam9pTE5XS3FNT1ExbUl5aU14eDFsTjNj?=
 =?utf-8?B?WDJHOENiRHd1RFlPUDZuWlpaNVp2dkpYNTI2S1JBTlZ1Nmw4ajlQTGJVRmlW?=
 =?utf-8?B?dGlyckJWeDNEenA5eThKbEhJZThjd2tjMzh3WFJta0x3QVZqRWd4TmsyRjhw?=
 =?utf-8?Q?DJ6Cx15/Z1Ppg58aNweyh+0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXNXRmlIaWVUVDFaYmdqdmVadVZ0czhERHZ4dHpheXplemorN2k1ZjhydGND?=
 =?utf-8?B?WGI4ZTc5NmZ0ZUxHZDJHdm5pS1B3Szh6VXdMQ1RhcVVrZmlTVmJ2bStmQlNE?=
 =?utf-8?B?ai9vbWtJOVdtNVkvZTFQdDNWVDR3dVF3N1UxQ05VODE1RklwTzBsR2lSb3hq?=
 =?utf-8?B?cThTSjAxRVNoT0doRlloMHkxcklLQ2M3QkFRelZpcmNyK3JLNE0rM0c3b0tY?=
 =?utf-8?B?SHhhbkZpNEZlTVpXY0NVSFdGUzVTdDMzUEM3bmI2eXE0Qm85YVRhbFJFOWlI?=
 =?utf-8?B?ZnBDWlFjMFBFMVR1NVJBSHZIL09RaTk4dDE5Ri9uVmIrZ2tVQ3Y4L2dMbTRG?=
 =?utf-8?B?allvem83NjdCRllJUFV6ckR5cE5ZSmFrYWhRUDZJWG1XMkJnR0IyMWZySGNQ?=
 =?utf-8?B?YmVmanhpdWZvWjlrNm1XZ3dYUlEvY1ZRK3VOc2ZRN2FrZVVEaFY4NnUrVitj?=
 =?utf-8?B?d1ByOU9hZ3NnY3ZiQW9QeDVodjhJM3dPU1I1ckdYNDNvdGNTakVVL2RXWWls?=
 =?utf-8?B?NnR6NEd1eGoxRTYvNlVoSktobno4NlpyOHhsYTRzbThGdzg0Q21XMnZwcVBt?=
 =?utf-8?B?TFUvTjVLbGc1UXV5dW1nbUZFaDd4QUl2b2c4dlcxUnBubEJoaE9KZ0pmZlcz?=
 =?utf-8?B?MnVGVnFSQUsrdmtVR2VuVlRjYWFQcndKSnB5ZFNlV1ZVNWxjdVFHaXZHUTAz?=
 =?utf-8?B?ZzRBeUxJcTRGYXJSd1B0QzBueTlSQjYxZG9rYVBGSVRzYkIwZnduRGRsSWt3?=
 =?utf-8?B?NUNlN0VDTzBjQUhQUUlNYklha2lzN2hmZGY5dnU3dzk0TTk3RVFhVEVqZjFB?=
 =?utf-8?B?ZlJSU1Y2bVR2MXlMcDBreXlRL1grczZtK3h0LytvOG5qRi9GQUd2OFZ4NlZJ?=
 =?utf-8?B?cUFQMnJNdFpPLzc0NUI5cHhOQ2VJVWFiZWhGcXU4UWNsb2trUDVGZ2dYL0Rh?=
 =?utf-8?B?c0lqSXpvcXo1YVFuMnBUckhmaGwwK3E4eXZvTTdYZ2tpSXRSYklnbG83bWZO?=
 =?utf-8?B?cmRub0o4QlhRKytRUzNpaVNNcjdBd2VPeEZXeXNPNDU2UW1VdTgyOEd2ZEN1?=
 =?utf-8?B?N3pmb2NFQXNGU0U3WkhDVVdaQW9KckdnVCtUdHNrWGJBVnJoTmNMQlIrS3lB?=
 =?utf-8?B?cTdvUWNBS25aU3dOeURVRkxQWkQ5K2ljZDZXN1NuOTlXU2RLZmhrb2VHOThw?=
 =?utf-8?B?M1pFek10a04vVFRHekZKNjRPWnBrRlozQUFOWFZsSmgwZmE1YURDUXJOY0U5?=
 =?utf-8?B?S05UMXdzcmxXUVV3Qk0vZTVqYWJ0M2d2RU5EVmh3Nks0UkxySWhqTEpMSDQw?=
 =?utf-8?B?L0UwNURoVGZUc245Sk9nSWFtMndsUjltS0NyOFhsbjh5MEJlQ0RJN0dHOVF4?=
 =?utf-8?B?eGRlVzZYS1hLdldyQ0c5S0ZGVWU3NVlsbzZSWGZURW1kVDJlVXVaMENPalox?=
 =?utf-8?B?UGJlMExqdHZFT2oxYkxYcCtNdzJHbk9xMkFzQzNYVEpqYzZtSHpIQWloOFR0?=
 =?utf-8?B?UnpGTE9jNytOemYvcy84R0Q1ZlJ5NC9ZTy9mQ1ZKKzJtUHRXRjRJOWY3YU54?=
 =?utf-8?B?cU4xZ2x6allnYzhJZGNxd25IbnZZK3pQblJWOXE5OWJWNGZsMWVmamkxOGJH?=
 =?utf-8?B?NEdNTEwyOFJNS09YS3RzOUs5d0F2WG9aZlQyYVhFdXhZWjFBZjZ5VTIwYWNB?=
 =?utf-8?B?S01oQ1BMaTRoUWVWczZPT1o3UXNYL0xiYmNxOFpOZnZidi9rUXAvWDZNTmhv?=
 =?utf-8?B?MFl1dmhjdXU2RW1oWFBvdGdWVDNSRVd0WklyRnVxMG5MKzFySnJiZkhkR2U0?=
 =?utf-8?B?bk9nZmpQaWxrV1dLS1dVQTZ2bmRieHV3L0tPNi9PVGkvUlZJYUN2MVpkSE1L?=
 =?utf-8?B?TFVmV0Z5OGl4bTVwbnVYczFUNDdPemJyQTNDUnF3MzFXbDMraFJMcDZHWGxS?=
 =?utf-8?B?bXJ3UTNKSkFpYWNnQ3lOcDZQc3NkWEVtMndIZWtlNktEOTRQMVBJanpGTkN5?=
 =?utf-8?B?WktSMUE0Z3ZIck8xaTlFbFV4cm1rRDl2ekNmRTV5eHB5L0pUVk0vUnNpOXlZ?=
 =?utf-8?B?M21DOGt0M0NLcEJPOUZSTmwvRTlDN1NRa3RvZGpyVHd4V3paLzRuaTZLNWgr?=
 =?utf-8?B?bmhjK09TWG1JcDQ3bVhlTjBYdWp3eUIwazdOaUthUjNVREY2NlNEUW9XNnBF?=
 =?utf-8?B?RGdtSjdCcU4yUjZFT043K2IzQURMOEpiTnNlZUVtKzNNR2NhQTR5T3loMk1U?=
 =?utf-8?B?MHo3TTZtZ3FmZVFYQmxiUWc3ODFZNk9sVEt3SkUyMFpueThHaGhWWXd0Qmh5?=
 =?utf-8?B?RmVRa1graTdhT3RYeXo2L0ZCek5oRlhwMUhjZnlRK05Xc21DU0tkQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a037c40d-4de6-4b8a-1114-08de53bd0091
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 22:33:55.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMB65qhZWoL1izpf+JeYiou0vaQ/tPlRxKgQ3z3oajzz+QA/b98Mk55EGBm86jDBSOWrTkWvN/wLmBMSqQGy7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

Use dev_err_probe() simple code. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/mxs-dma.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index dbc8747de591cc83e39ef873633418f41b5ea982..c1d4c6690df1af476aeafe77ff7f78bff1e413f1 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -753,10 +753,8 @@ static int mxs_dma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = of_property_read_u32(np, "dma-channels", &mxs_dma->nr_channels);
-	if (ret) {
-		dev_err(dev, "failed to read dma-channels\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read dma-channels\n");
 
 	dma_type = (struct mxs_dma_type *)of_device_get_match_data(dev);
 	mxs_dma->type = dma_type->type;
@@ -816,17 +814,13 @@ static int mxs_dma_probe(struct platform_device *pdev)
 	mxs_dma->dma_device.device_issue_pending = mxs_dma_enable_chan;
 
 	ret = dmaenginem_async_device_register(&mxs_dma->dma_device);
-	if (ret) {
-		dev_err(dev, "unable to register\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "unable to register\n");
 
 	ret = of_dma_controller_register(np, mxs_dma_xlate, mxs_dma);
-	if (ret) {
-		dev_err(dev,
-			"failed to register controller\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register controller\n");
 
 	dev_info(mxs_dma->dma_device.dev, "initialized\n");
 

-- 
2.34.1


