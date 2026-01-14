Return-Path: <dmaengine+bounces-8266-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B383D219EA
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 23:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CA0A305F312
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 22:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29323B8BBF;
	Wed, 14 Jan 2026 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TAh1E4Rr"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904753AEF34;
	Wed, 14 Jan 2026 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430106; cv=fail; b=YZQx/DNewWrUXGTrrzZ8vUMOdVZ1016HFrZZwAY6dxAJuV5TxvWnEet29pqNGSryZl4R6vWl6M1ooMDstgLr6r5qKfTknXOFKufQ6kbSLl+Uo4PvUccSmlFbSnh1ka9a0W5RqX1/HgIjbhbFJ+Xy8E5V7Q8drrbDwxExXfgY2yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430106; c=relaxed/simple;
	bh=qa12qCvVjcto3KZzY4Y3LKmNK5yieXGtyEDDIcjU46c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Yxc70O78Eq+5mwCdyjxxGZfflaLgyohO++pr9gx/R+iqNMT4xrjgxPbyPM4Ox6V/dle4j8QMgB+eQ8DEGnh39xQmBy6UuqLt+hl/xjeAlaUrwV8UE8Md5aklUJZ6oZ3WNkA/H1mZBHIPIPOY9ycp3rf3eCL+VtFGbyAV7kUJpZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TAh1E4Rr; arc=fail smtp.client-ip=52.101.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxaq/nhWQgAnakFys+wC4AX1hpnAUBwwG5XmQ37iQW/MTb2OGwZ79wth7GOjigXbjdX0B1x3cT8QSm/3iegAzmp1jXa4g1cfoB9NB9bHygC1yZkFQdnUcgurgISYaqYQpk5PViKBofY/ysaa/bxggvV7WEI+lYBblbhhBnijNdZVxIuYF4HYDgdECKE87deVsn8K4iRSi+CKNecNFgbbPnMfXOGQachfFp0k+ddaPRzSrMrBFWlrGaZFqa27Qb38VmWPQLJEmItg8o51SACexdZ7TbQSz9QoqrRmStKrAMsEzsOZWc5yNXrig5RlochcYCihaJwjpqEpZPzT1Klgtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzXVUfCikU/CH6YenUvZ8dbJ+qttDoX5n9MFRjohbnM=;
 b=tzXCL83jh04Jodj8fWGCii3JImPoXMEfVulR2E6yAnKzm2PXZDY9BfCpzTWv2ZHLeBXlFYdVh7VmhbGmcLfc/vjfrAh03HuXMCSPwqwzyaacbMV1xSsUEoSakBfYTcrqYPCkiUbagTi3/WTBbXL9wG9hJH2kariFPelpvJ+siUcPFqbB+tFSEwp6E4OXNmmmI4CaVrzc+kG+C1nXgR743KT78NyBCtT5uBpJYWVCvDiyo+iKx926gORPPh5k7ldJZkw3PPJ5hP1/y9tgPiFQOpBFO6k4U37/IaHuCy/7d2OAeU00dBepBXpXC4bk4m/kYSrx6xGOQycAoFmXIbIPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzXVUfCikU/CH6YenUvZ8dbJ+qttDoX5n9MFRjohbnM=;
 b=TAh1E4RrcPz013EXFAZyCAqrPT0Q1vmOiNljeTh/MVKx8SLbUgTqBdnQ9mfuNE2UPXsubOiaIvKViP0mGgnuxXm6rKzqeBgMbaGQ1O/UU6dnmGQLHbGTdzRon5cpcv938vu/TWY44OwyTxCRkZfGAu3MZUP8UB47Kag58XemJO4uv9vzmtnsM5mZzYuWQAMl/Ev4KSjRwmNGnzYVOOdW/v1nSQUh8YxTLpk3IViWHflISmEDoVLiQiSh3w8/xG6+NTDngdW9+zM9qCLW/GHKxjFFwsDlG58dvdKes2H+LNwgTxb6ZQk2YU4qhAuPVu7h29xKGkQUyPDHUpSh9DhGiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 22:34:30 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Wed, 14 Jan 2026
 22:34:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 14 Jan 2026 17:33:25 -0500
Subject: [PATCH 13/13] dmaengine: fsl-qdma: Use dev_err_probe() to simplify
 code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mxsdma-module-v1-13-9b2a9eaa4226@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768430015; l=2838;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qa12qCvVjcto3KZzY4Y3LKmNK5yieXGtyEDDIcjU46c=;
 b=zW4R8dcFy3T6OU8IZfU/6A+I9A4l0BXSEEHOKNWedytReoH7YbwAreLFSDJNa/ZHjf52YUiQT
 VhnlY0mjf9MBwuZbUZaTB5RBSZPUYe6fw5krglPyi6XvWAmoeajgLI0
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
X-MS-Office365-Filtering-Correlation-Id: eda03ce9-a87b-481d-db1b-08de53bd14ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXNDbVlQdUwyREhCd01seU1WbXVCbW5ibmZITEpnenhiQXozUGd2S2pWMUFr?=
 =?utf-8?B?ZVo4THJDRXJ5aVprRjluTW5hU2NhRXVtVnJxbEM0bU1qSUxuTHVETUtnUGxK?=
 =?utf-8?B?dVgxRVo3ZVdnS3ZYYTFZclM4N2l0cjhqUFVNMlZzZUdnbEFlUm9ML2RPZ1Rl?=
 =?utf-8?B?NER2UitQbFVtazAyUTFtd3JBNnErVFpwZG8rV1JiZ2gyYTlXcWJ6aGhBZ0V1?=
 =?utf-8?B?YVFLNXlpQWNYZ1hqMmhwWjdMTVpZUWk2QTdnN3FFdXl6NCtjUnBRZlFvZ3FV?=
 =?utf-8?B?L1p4dWhLWHhOWFZiV1RJUmZEbXRMbXdkVVRKLzlIUDEwcXQ3MEFndU1PV1ZQ?=
 =?utf-8?B?UE5TNGNvZ3RLUHVwVkduZmJ2YWp1M2VhN1NHMFhCM1U4VGhXWVh4M0Y0cXJC?=
 =?utf-8?B?SlNMQmROVDVPUDB0SE1PaDRoWmdMbGNWY2d3NVQwTHNxVDEzUkJOOXZRVm1h?=
 =?utf-8?B?NHo0N0E1NlZmYnhiN1g1SUdSMVB1N2prL2JxeWVhaENiMHpEZ3FLa01BK3Jx?=
 =?utf-8?B?c092OUVGTGYwa2svcXBHUDdaalF6SGowQ1B5c1BUVVJ1NUNnODluM1RnbWJm?=
 =?utf-8?B?S0RjYzQrTTlkS3RVeGhyT29MZjliVVR4bUJFN3gxOUZEcmJ6eGJFbWhMd3Y4?=
 =?utf-8?B?NDZyN2V0K2ZZNDRUWUNrR0pybFVKRkxTZWs0TXNPbEw4Z1pMT0NvVHBWMTZl?=
 =?utf-8?B?czFpT0FvWXZuclRoNThud3ZQcE5uY0E4dzQzek5qd1U1QjV3c29MZUZjd0hm?=
 =?utf-8?B?T3JuN0dBNVhHS2tGVkxtTVY5aGp0TmN0QkNyS3NGRVRYZGZRVVpFNzFreXZq?=
 =?utf-8?B?NWFRM0ZtVW1sb1grOSs2OFU4aVlTLy83SHo3dmFNSnUxUTYzSDZONDhFemFy?=
 =?utf-8?B?VXA4N0U2WXV4enRNakMxYnVWbEtCMnl2NWxyTkFDRTBFa0c1cU9QSVZxQkQy?=
 =?utf-8?B?MUxseTg5bnNvcUVBYU04NWFpQXRDQml0L21MUjF2YXNPQWdrZnBuYmp1RXFu?=
 =?utf-8?B?SG8yRmp2L0VRWnJXUWVnSGc3Q1lod3BSbERNY2RWNUg2TnA0bGpDRi96c1hG?=
 =?utf-8?B?UGJHRUVEdXJtY1dkOTlZbjAvUmdYZmQvbldsaWMxSnpValJDRWlReVQ2S1lq?=
 =?utf-8?B?MG1FMlNRWE5YalZYQXJxM1FaMGdWeVNzREgzVVB1eVRHUGR3cGQwT3BtYnRM?=
 =?utf-8?B?c3F4bm9UeUQ5disyaXU0QnJKVFZQZFJiVkRZMjNUVVZha2FlWnh6bTNsdDM3?=
 =?utf-8?B?VjE0UnVodEtmNUVaZE9tMjI3dmtvOHVMVHdIdmp3S1VPU3JOQVY1MUk3UUIw?=
 =?utf-8?B?SjVTdk9mcWhlRnl4Vld5UDk2c3lPbk9tMTBXckp5RHpaeHNHQXBkNU1ncHNz?=
 =?utf-8?B?bHNZNTRwK29FQXJhZHk4ZVRWLy83dFB0T0E0aHhMSXJiczJnV2U5bnJ0YTVp?=
 =?utf-8?B?OHIyeWwwRHJXcFVEZU9WWTBGdDZKYmo4WlpkTllJOWlaMEwrUXhOL3lMaE5R?=
 =?utf-8?B?VnpNNWh2ekltYW8xUkYvbkxNakZXcHpoMFRXREVXd3JydTNNZDMza3VjaXY0?=
 =?utf-8?B?ZW5ncDAxZzF6L01zZmNLc0lYcmtUWXdodGRMdklrcUthZEsrM1lIUStBOVhj?=
 =?utf-8?B?R1RoV1BWeDJSM1R0NjFRcmRkZ0dIaGNub293SW9FZWliQ1RtYm5TODdyVjdv?=
 =?utf-8?B?d2MzU1lkdVg4d29qbkRLSVVkMVE2OUs5U1BMbVcwNVdWWWdpZU1BODhvVGU1?=
 =?utf-8?B?WVBmMU9qZ3B3allZdEFsSjQ4T1hBbHg4ZUVOcDY2MmJRcVIxS1E0UHBqbTUz?=
 =?utf-8?B?SXU5blFMU2Z4TVJOT3h3NW9Zek9VeHJpK2NjWUVMbGtad0Y3eS84KzhYQWFq?=
 =?utf-8?B?U3RJaXdiamwwSTBHUEFsMkxmbGdVSTh4d0oxdTU5cG5Dc0VkQkgwYytuVlN4?=
 =?utf-8?B?UkpMSnFWM3VucHIybEhCTDBmZEJsT2w1c3ZZZDUzZ01Ba3hhVmF5RFF0Zndx?=
 =?utf-8?B?Y1ltazhqMDhEV3kwdEFUUm82WlNuV0I4TW1TQW82Q1A2UjdndHZCVmFxZm1H?=
 =?utf-8?B?dFJLeGVJMm1YTGNHTU9WOFp5djlKaTFXKzd2V3k1eUJxK3dMczR5SjRROERm?=
 =?utf-8?B?bXZrMkx1cjdpWlYzVWM1alh5Uld5bGtWVFl1UHMzV0VRWVdqR29xRlkwRnFS?=
 =?utf-8?Q?gHaPnkIoa2LMpFrWjFbsltA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzZNdGZlT3pQSGJXc091cFkyY3BxWEVIQm1iV2xrbzJqU2V6dUtkaDRxZytC?=
 =?utf-8?B?RHFNdExXL2tscUExc3l6YkltMUk3bjZkRTRKTHUwcEYzUHBaNE8zMTJBc085?=
 =?utf-8?B?bEQySVJiaklBUjloTWc4R3pDMlk5L3JGVlVyUGFMSmxtL2lBckZEZTBVNTd0?=
 =?utf-8?B?OUZXcFF6cGY2d0pCRGRXeGtZTmIwYUd1bEZ3NmRaT3FxV3B1N1Jjb3preDg1?=
 =?utf-8?B?SFA3ODRDWmt5UzdjSW84QWIydllpcEsxNHVpY0xzN1BOS0ZreEVlaUJxZU5O?=
 =?utf-8?B?VkI4dlhCZ0Q4aXkyZU05MU84ODlRcUptMnlkY25mNzBsOEQrSEt3LzQ0MlB6?=
 =?utf-8?B?WEM4YTdodzZYNkR3YkNrUFV0QXpwb2E0MXhsRmVRQ2ZjMkVQemMwdktCS2NV?=
 =?utf-8?B?S0U2M0UyS0h6TDFtelgxY1FCMXZGdllBditQQTYvb3FSbEF5cDU5eVcrbXY2?=
 =?utf-8?B?d0FkNlFGYWIxcGMvRzg1dTVFT2creGtRQnh6THJHSkZEYUFxd0lBcDFMaFY1?=
 =?utf-8?B?TmVXY1FQbkJTRXBkQVZtUXZTd1hSaW1xYmtQeXprMGd6eHZRTnNGZEFpSSty?=
 =?utf-8?B?bUhpUjVNL2tiUW5RY2wrYk1xVVZHTStCMzBoTk5CaW1pN0J4QUdsZDliZ1VW?=
 =?utf-8?B?UFVza2VpdHFUVkdEZklBQ2NtVnhERm5pME1TdmRWTXg0QUF0OVBOb1pERVJE?=
 =?utf-8?B?ZGhqOC9CQW02SG5hUGdzb09hc1ZwNDdMcEdxcjFRVmhuUm9UcDRTTitaQjBl?=
 =?utf-8?B?TzRGa3hCQjVLbGRHbmszU2hWa3J0YUtpZFpHVUxESk1heTN5elhlVUdqM3ZN?=
 =?utf-8?B?NUxQTHJOQ3BEVDN2K1NPUjlhaWo3MGpyZlBINGcvRElKWHVkMXJuR1FKVVdu?=
 =?utf-8?B?WXBZWUJVY3ZIRGFkUU5zMzlBWU5aT2NIc3FhbE5lRFNhdW8yOEF1VHVHVGNW?=
 =?utf-8?B?ZXRHRVpOT0hMdTEzK0p1bGF3SDgyRHVzRmlZbEZ3N3l0UVMyeHRrWGIyL1Fp?=
 =?utf-8?B?NVRpa0tJRUUza1FjNCtFUDJVT2hSUHBuYXJweGxSWTFmTU5WTHRhQUdrL0Ja?=
 =?utf-8?B?b1JXZjdCRWp3Q1B5a1QvZkhGbFhicjZHVzRSakFxL0RFY1RJRTRRV2RLcmto?=
 =?utf-8?B?Q0JCQnhNSkxPSmJwWHNyQU45N1VBdTFGUDc0WU53V3RadTlBT09kVjA4TWJp?=
 =?utf-8?B?aVl5czZSTHhqZ1orL3djTGdLYjlwL1MxMDBROWUzVDVmY3dCTzBSdFN1MnJV?=
 =?utf-8?B?Q0s4b0lsTjlzNEVBcUhQdlk4YkhSSXNwN2dlK3FSM1c4RlkwbHVDei9oQ3Zp?=
 =?utf-8?B?a3BYbzVMQW5GRGgxSVNuT250MkV2VmpZT3RDZklUM1lnSWlHdjJhb3lkOXV1?=
 =?utf-8?B?TnRkL29vY2FGY2dYRG15bkFWVHBKdk54ZUx1ZDB1YnJwR29EWXNUd0ZXeXRn?=
 =?utf-8?B?WDJJY1VOajBJQkpvb0ZxVDJ3aGUweDlEdUZrZHlJYlVqT1NkdzhRZjR4VG1r?=
 =?utf-8?B?ZjNXamVTS1JCcGxINHlCN2dXVWF5SFZRaUxvWUdaWVFvcmJ6Vnd5aXZhNWdB?=
 =?utf-8?B?ZEFHVHRyTVV3RlZWVDVReGZxUnhYaTFaYW5BSWJseW5HV0ZGbm1LMERpR0FK?=
 =?utf-8?B?YlRyZXBzeVNCVllrNmxEMXZuSTNVQ0ZTaXRzYW0zdXR1VzBZN3dOSWpISVBT?=
 =?utf-8?B?K09xNXovOTV1cUVFZlVEbTdzZU82TjhRajlMWkttSUlpWXBQbkF6dThZWjlQ?=
 =?utf-8?B?WGgrU2FtOElyU1FTNTJPWDByMW1QWVFHTnZPWjhObnkwNXErempPUXRPMmlp?=
 =?utf-8?B?bzAyWldtblVkT3BwOXNqUmdzRSthdkdsZW9ObTNETlAxQnJJUHhBdnlNRW5B?=
 =?utf-8?B?RmlBd2Vmby9FYXh3OUM2c083RHR4T3RpeVk4bEZZOGs1S1g1OGpxYlhoOXdH?=
 =?utf-8?B?Y2ZYNnArNGtkRThvWGFQOTQ4UytzcFgxSFBLaXhWcWJ0QkpwaFFRdlJvUUMx?=
 =?utf-8?B?YXFCcDhiMXFzYWpodVhFM21Sd1NCNGh6MHlmRVUzQnFMUC9ZYjJ6QTVpZXdD?=
 =?utf-8?B?VVZPdG9Ed3RkWTgxdTgwdFNhRHpCL2ZzRzdlb0QzVHE3Vi9aK0owVE1IWXQ1?=
 =?utf-8?B?azJ5TSsweEQxaDFqUkR3b2l1WHpQc01mcHprL1hNRkZSYWxNWUFjN2JpS0w2?=
 =?utf-8?B?OE11VEExMFQrYVN4NkxmRjI2N0s3Q2traDE1UGpvZWZnZDFyZHllM1UwblVL?=
 =?utf-8?B?SzZraDNGZ2Jpa2xGeXVkbnVPcmJnYnpwYzhMNDVLYWVEbExEaW9Mc3dmbzFu?=
 =?utf-8?B?aHV1RFlhbStlT0twV203YUFhcGNzY3hrQlBSY2tMc1VDL25JZkxDZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda03ce9-a87b-481d-db1b-08de53bd14ec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 22:34:30.1007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqysySMcwSRc1qmb3y+KXZdxWFtCTzgy+DYt+Xck0GRLG1Wsz1l+bg6tyajVdEaNcX6w13CX4kAQQfVxrGsx8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

Use dev_err_probe() to simplify code. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-qdma.c | 47 +++++++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 6ace5bf80c40be4226b17503fbe8caf8f08dd139..4c3a06653c909ce89677b66aa6a900c82c38a872 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -1127,22 +1127,19 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 
 	ret = of_property_read_u32(np, "dma-channels", &chans);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't get dma-channels.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't get dma-channels.\n");
 
 	ret = of_property_read_u32(np, "block-offset", &blk_off);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't get block-offset.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't get block-offset.\n");
 
 	ret = of_property_read_u32(np, "block-number", &blk_num);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't get block-number.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't get block-number.\n");
 
 	blk_num = min_t(int, blk_num, num_online_cpus());
 
@@ -1167,10 +1164,8 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = of_property_read_u32(np, "fsl,dma-queues", &queues);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't get queues.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Can't get queues.\n");
 
 	fsl_qdma->desc_allocated = 0;
 	fsl_qdma->n_chans = chans;
@@ -1231,28 +1226,24 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 	fsl_qdma->dma_dev.device_terminate_all = fsl_qdma_terminate_all;
 
 	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(40));
-	if (ret) {
-		dev_err(&pdev->dev, "dma_set_mask failure.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "dma_set_mask failure.\n");
 
 	platform_set_drvdata(pdev, fsl_qdma);
 
 	ret = fsl_qdma_reg_init(fsl_qdma);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't Initialize the qDMA engine.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't Initialize the qDMA engine.\n");
 
 	ret = fsl_qdma_irq_init(pdev, fsl_qdma);
 	if (ret)
 		return ret;
 
 	ret = dma_async_device_register(&fsl_qdma->dma_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't register NXP Layerscape qDMA engine.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't register NXP Layerscape qDMA engine.\n");
 
 	return 0;
 }

-- 
2.34.1


