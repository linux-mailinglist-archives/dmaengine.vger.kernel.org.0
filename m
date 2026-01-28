Return-Path: <dmaengine+bounces-8568-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LCWBjxRemnk5AEAu9opvQ
	(envelope-from <dmaengine+bounces-8568-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:11:08 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0442A78B2
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F04553051B8B
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 18:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2C1378837;
	Wed, 28 Jan 2026 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c0qNa3lq"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013055.outbound.protection.outlook.com [52.101.72.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074EB378803;
	Wed, 28 Jan 2026 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623574; cv=fail; b=MOKL9lpVKV6+w9nsL0Cy8DZmKN4OJlnYRJzDmj5crkIX2oRv3jJIp5NgvjkRE6c0geXvavEObtyX+WJp1Ftbw18/GTpiuIs0TRw1aTk3zZB+3XFUem1Ab5rem1l+i45kO6jfc3WWTd3ZuZGOdJqkgJ4mekSAJ6cmFNfEAvgGN5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623574; c=relaxed/simple;
	bh=T/R1cBEiR3v0+MtMeMed2PnwWXA62oWKFIBXUBGCHT0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=j7MuPw6Exd5MVkG+XNFLIew4YtXuWMVeWPcdo2YyZrhFcZYYtW/WhmSVMbitTqNIku64GUeECVmJDwGG33SPzUtckk2NlY7WeB2NZwZQvI2QFCNaFJHivDGeFkUbqwnRyLLy/BQz049/Vkncr0GdZRyg/i/qa1CE3dv9et5x4yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c0qNa3lq; arc=fail smtp.client-ip=52.101.72.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flWhHcX6y5K6RoLpudf49dqXj2BvAtiUXwmS03QjvU0eHR+uyB+QvwLylyzV/RA3iQqzukFIdCTNiFvwwcxtppSj+KUIS+uB8OoQvWWfVd/kYLGcyeP/Li9/X9i2HYSfubZ1gzSPD8RS7MomgnvvGeMRHqFJyM/q+RoxBrlqfk2nO5uOtS+hmsEGfBKKacPsUNc9SMaAznAqhzS6GnlC1Qe8JCFlp/lm0WOptJuLYkCffob4n/UvrRFWG32SQkgAPtlpTS44cFOCor2d8CJIoNgLbsoUz4tPZYbLZGudj5TB6HqFTla6xt7xpIoskPbZdkPagYbOIJbNAXn8yvvGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+qS2Ko7f+qaIMTEuVoEhd6W/HjUxLrSlJW68ZYvYag=;
 b=TvL+sMSI/g2GeGA6tyaEtsjPnk/FA51htPsNpMNGOJwvMKEdilUpbaNPKoD6XtyG0sQjGXzHujDwt6QcHg1fJ8WkourpCNUsbkb610gcboQGRL3nAcMzn4Ip84l5dQuED+QkDw3Ie5bghwpuL75C/PEn40hWYRF19MWQb+8L7dX+y9KBz/HeNfj293x9X0utADc7fyzD3Q4EZDTXm75Vmy68VsIOgQlaq6N6W7b9VhGrpOxdXCYGue2ZLqxpA3jAJ/Kd0aH5CZo8+oz8epyVv5AC+1KNXr3Lo7qj/ETC9ovWXyrS+vCLBBb5ydXHTgvneQs7rvgeW4aRfDrawb58hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+qS2Ko7f+qaIMTEuVoEhd6W/HjUxLrSlJW68ZYvYag=;
 b=c0qNa3lqQpMoHwobpOlom51mIk/MzvCKgkZ8aJ/L79PHU3VtYXeQyjA2s9VMAeUvkgVOLqygdEu9PFiPtOvkzyaxPylPr0J/Xu8OVeAeodhg0VtFcEGStSiMRF185jQbLcQK3zVJum4i78KBzkTEGbGD9AGKdsYYX/DlXBuE+b5Tyn4r7EYZA9MhkQcN4SL7mC6Bkihwhure3uJf6/yUzZaZPnyl0gnr4E1FAdLzWAhiyowUeuS3oVrciaa1/e3v9VmGaekFiKaaKh6yRVSfRSalLUd6cDLnFps2152E2hz6vai7h5cwMS8VVaHwq83Tox1ma/xxcHC53eudSgLbMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA4PR04MB7600.eurprd04.prod.outlook.com (2603:10a6:102:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 28 Jan
 2026 18:06:09 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 18:06:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 28 Jan 2026 13:05:31 -0500
Subject: [PATCH RFC 12/12] dmaengine: add
 vchan_dma_ll_prep_slave_{sg,cyclic} API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-dma_ll_comlib-v1-12-1b1fa2c671f9@nxp.com>
References: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
In-Reply-To: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769623546; l=16298;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=T/R1cBEiR3v0+MtMeMed2PnwWXA62oWKFIBXUBGCHT0=;
 b=NjpoSeIeeu7dmTxOprVfSkd/JGard4izn4NerZxrgGKX7a8TQPfFm4AI20QMFh/IANmev+HVG
 m6gNLTiK61lC6D+5PE9VmNuBxL34NzMuCY/+To6+IHR1A2nllUNpkOV
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:806:20::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA4PR04MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 953db963-2bdf-4438-717d-08de5e97e89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUIrTk41WFlma1AraTBFczJXem5tS2UvMGJCT0FzcnpJeUdNV1piNmJ3bEcw?=
 =?utf-8?B?VnkxeTZqOGZ0bFczejlyRXZVR0ZocVVDZmxsUnNkUnRYK05qZGx3NVNkbVdE?=
 =?utf-8?B?QzR5Y04zdmZSbUY4NXQwU1BRQ3loaXlDWll3ZVNZem1IQ1ZlcTJ5SEpDTThW?=
 =?utf-8?B?VUtESEtOYmEvcjZ6YzZOZFhCV2NwN3lsUlArNTR1QzFVNkFPQldNRE9nSTgy?=
 =?utf-8?B?NHJXSUJGNUI5ZFRpMlFtMXI4K3ljVnZRL0VOMVZjZ1dRSUVrQyt1MFhNblJn?=
 =?utf-8?B?L2Y1ZkF6ZjIvRHMzL1Nsd214SmFHRFg5d2NwUEcyUG5sYk5tenUyMEhIazFJ?=
 =?utf-8?B?T0dFWGRpSUN2Qjk3bjFvNGlHQTh1UDJncjk0SUJlZ1hhdVJ4Y1ZhMDhPMTk3?=
 =?utf-8?B?TXdwaHU5SFp1YkZjVHNKdlVQNFMvNWNQb1ZnWXM2NEF2dFltRGhGUXBQSkN1?=
 =?utf-8?B?aUl0ZnRxOFgwWmJnNGpvTG1wYXRST2JtYlFRV3o4Z2JqQUNXUnlQWXV3T08w?=
 =?utf-8?B?bTdCTkRXR0dtaHJJU2hlNmhpNmVSTGhXU1pGWklDU1JaRTl4VXdFOHJ6MXBT?=
 =?utf-8?B?bDVUQWxSVTg5djFFY0p6T0RQU1pjUlIwcTFNMWM3N3F5eXc4cTVPNTY1YU4x?=
 =?utf-8?B?SC91aFNUYWdvUmp2UDhtbW9HaWl6em1SZXBEdURBckFIYmxGYUhwckM0Nll6?=
 =?utf-8?B?bzVEZEJRMXgzcFQ0UEdCTlByWWwyYnNYQ0NLV0Nkb2JscDNIOTFmOERUQlpx?=
 =?utf-8?B?T3JqWTg4NSt1UGJOZG9XVkxpUnpDRXhFZFBWNkJ3TkRYM0ZCeFJqT3RSSklQ?=
 =?utf-8?B?UlY1WVdnVG1ucEVRd1o0YWZtTXZLeHlXbkhQVGZjR3h3cDczZFYwbzA4ekpP?=
 =?utf-8?B?Y0R0SGJEV2VVeUJJTk52dzJZVlVhUk9rc1RmTEhDdng1ekxMeUEyNEMzL2NE?=
 =?utf-8?B?Z04xQVZwMlNoaDZNbWkweGdvWmlyUVVrbjBoVVl5YTFZVjRDaXVaNkdTazVm?=
 =?utf-8?B?aTh4VXpBSlZXdlo3cGQ2SkN6eHpVNzJYOENySTZOYzA3QnFLTkxrRFdJZk1D?=
 =?utf-8?B?c0RqY1IzeEVQYXJvK0tMMHM1V3VuUEFZUGdHa1F1dTdhYjBVTE5ac0pRWG5C?=
 =?utf-8?B?OFl0TEVucTM4MEdML05xaTBpMzQxL1NWd3B0eUhtMmM0Qkw2L25ML1lQdWs5?=
 =?utf-8?B?bmxlRCtFblNjdkNxZFBQL29qUUdWenhkVWVOcEZHVW5FMVQzYjVwaGF5VXlW?=
 =?utf-8?B?ellRWnhrRGZFUGVLMThGSFZBR2c5YkswbVBtYm9MY0o3eW5KekJoTHZTTmNs?=
 =?utf-8?B?SWZjcGg0STlnbUhlMC9OZmF0YmNaQlNYN24rN3pTYVcwcjdzallPS0NBaHZo?=
 =?utf-8?B?SmFncUk5Nkt2Z1ZMdUF6Tlh6Vi9ldFJEYnQ1OEVpRzN3ZDYzcjZpZzUrZlJx?=
 =?utf-8?B?UWxVRHFkSURtaGhtTm1ucnZjOEpvcTljQmc3Q2E5blp1eDZlUFByZU5MNHRM?=
 =?utf-8?B?UmlYdzZNY2FQZXB3cmx2bG5zenVHUGwvazI1Vm9rTHU1bGJjc3Y4eXlLUDB0?=
 =?utf-8?B?c3ZlMitFdnRoQUJKOWpvR3hTYi8vS2hZWHNWcVBqN3RocXRXQzE5bE1jK2Ru?=
 =?utf-8?B?ZVhLdnhqOTR4dUtEa1ZXWnBDYnhuVVJnQmdsMEcrb2pzbTdLNHZ5SG5ySFkv?=
 =?utf-8?B?WGhEVHVWeFZndXkxbFIvVjB1eENOWmwxZytWRWpOM2s2Y0QrQnpHVXltTDNO?=
 =?utf-8?B?OS9xdGxlRExwc3JvK3FieTJPaXIyNVJVN0d0MnZGdDJncjV0bXBpQVVPU01n?=
 =?utf-8?B?cE1lZ2E0cm5yV2RzS3FlVzlEa05wYXdRVkdJSkRodUNld0Y1dWhjMkNRa1VM?=
 =?utf-8?B?YXpSVWFramtUWmdxeUV5TjFjaU9sWG9OdXdjV2sweHFYWEFzbUpzenZ0Y3JV?=
 =?utf-8?B?RytlVGgrREFXSllGNzdEVzhRd2llaHZvMG11WUFHNXdFUTBCZGhjTzYvY1pj?=
 =?utf-8?B?Y0dEUEl6TUlSNDhaYlFJVVJRa1UzNXppcmpzbXA2MEpuVXYyQkJJdUhSVDFP?=
 =?utf-8?B?YzJsSnpvWGFWTXhsTEpza1hOdHVyYzZHQnRpT2Z4WjFudCthN1hxWS9PRVZU?=
 =?utf-8?B?VS9MZTRDeFZ4NE5WRmphN1FhdkNoUkRLREU4UWtWYS9nUk4wVXY5MG5Lek9h?=
 =?utf-8?Q?yby4gkhs1v+xuJe6JXdYxEg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm1OU3pudFhqZ2tXMzgwZ2pMUU42QVBESkhkSi9FMGtFVkVxU1R5ZkJnSXg5?=
 =?utf-8?B?T2k4STA2YS91cGRCQWJTcmZkRUFsTXhnRG5UVGt1V2VXVlE3MkdMRTlRRndp?=
 =?utf-8?B?THlselNXNXNwNFk5cmt1dE9YamkwenlTTFpJYzF6MW55MXdGeUt6emc0VVYy?=
 =?utf-8?B?cXJNTHNaeCtNN0IzeHJjMlhDM1BDWEpPanFZbCtiVGdQN294aGg5blYxU1Rx?=
 =?utf-8?B?dnEvNGN1bGdHU2FvZmdKL2JDbTUzYU11eFR2bTFVMnFINWF3V04vWGtnMzBF?=
 =?utf-8?B?VERvYUZnSlBNd2xab1pxbVJCWnFsRStGTEc3VDZWYmMzN0l6SFQ0QXNVMFdn?=
 =?utf-8?B?TFpMM0VRWGMrN2pBOU9zMlcvOUM5RUo5QkFOanNhT3FpL1BMMTErOUZMS1Q4?=
 =?utf-8?B?ZEE3S2NBSkxPZGErWnZHUlRnQ3VWMDdwQ0Q1Wno4Mno2OFd1VjhNVkZNWWdu?=
 =?utf-8?B?dUZmQ2JWL2crTzVQN25rNnEzZ0dmVC9tV0Z0NFBrdkJ4dXhSa1NNcDNEM0dz?=
 =?utf-8?B?bUlMTm5uWFgvQWxSSTF4NS8yb2p0c3RjampNRm85STFHS0YyMWZIV2hwL3VX?=
 =?utf-8?B?RGJwMmhUNEdyUDBTMzM2RXl4VzZwSS9iZ1Vka1hJN3dla1FFRlVQMXY0RUdQ?=
 =?utf-8?B?dzdtTldXUFlOL2dmNWFjNWU1RkdGaUNna25WQzNpK3o2M0Fza2k1MGEvSldx?=
 =?utf-8?B?aGJCWkNFcGYzN2hSTmVzaWZPL25FWFBaM0ZSWk1nbkl4WFgrYzFubStxWXdG?=
 =?utf-8?B?d01ycFdUZHJMWVB0TUVEYUV6QWl4MFFUVnNha2N1M0FmUG9nakcxbWNxRnBm?=
 =?utf-8?B?MTFOY2FoY0JjTDBKZ0ZUT2xscGtWQy9qUGRxd2liSTRIdUFsUnQzQ0NweEhG?=
 =?utf-8?B?WkIrWXdhd05ISWJYcThneWk2YitWMGcrbklNL09sbnNxUWR5bzBTNW9YdnAz?=
 =?utf-8?B?SzdBUHVRMWJPdlNTVlVQME81TWxSVEJBTFQvK1kwcE40ZmpKNWlRQTZIbVNp?=
 =?utf-8?B?NDgzV29MdFVPMCtMWFR3aHpMbEtJcEloMk5NZC9kdWZLdEFuS3orNktVcFFC?=
 =?utf-8?B?ZHBVTlEySjQ5a0hRS1VkNEdOMEplQWFYcGVaNVBaZWVpcGFwdWRIL2w4RjBu?=
 =?utf-8?B?OUpJZW5hcmZEWW1VVWt4QVhSS1oxT1MzaEpieVNUczVQMTJCUVdhc0VlNWMr?=
 =?utf-8?B?ak83WjU3V2owN1dlZVlCbEVWWXRCQ3pIWndveDYrOW9yWjI1L2Q4ZDdpWDAw?=
 =?utf-8?B?d2RNY25aUFNSNG8rekJnSzh0NkVES1B3Wm5pSTkrc3hLRzZJZGxwbFlSemtX?=
 =?utf-8?B?Z3MzL1F3NDQ2Wm9WS1dmQ042TnBpQ2wwQnBXRmE2d1R3OTh2N3p6MlRsTUFy?=
 =?utf-8?B?UjRBeiszOVZPdmNvaFBBSGhVR05CWlFZaHp2Q2Y2V1ArcE1ESlkzV1MwK2gx?=
 =?utf-8?B?WkFhaWJLYzRWcUY5anpGVGpUdktkWDRjajJzdUh2YXVEcWh5T3dzS2htZWRz?=
 =?utf-8?B?UEp1RFQrME0rSGxMOStuTzN4aEk2dnNIZ0I3QlVNMnRJa28wQ1FEcm1PaUwv?=
 =?utf-8?B?SUJOU0lrbS9rRGFqVkhqMUZ0NjRWcXhnckFIWjVPa0tWWnRiMzA1UmRJYkJl?=
 =?utf-8?B?ajJhMURnUzh3TEhlY1RVSTFGcTFONk1xU0pBaHUzL3Z4OVRsN2h5MXhrZHU2?=
 =?utf-8?B?SWE5QXV3TzV6UGd4d3llZUlvS25oSkxRYmlqTzNWRXZIOWJpcW5Uc1FDdFVa?=
 =?utf-8?B?ZWlzUmVaZTR2bWZVVk1veFg0NmhER2hIVFg3U3YwVUxCQjJZRklTcW43NWdM?=
 =?utf-8?B?V29SMUNuQ2E5a3R4ZklpVGJRM1NEWVZEY1NabnBJbnhoakNscTB3cUJxUUxL?=
 =?utf-8?B?OVlvbTdCOEtFSjVrT3pKenBreFdFTVhMWlF3dEJrNFhIc0crUjVyWHFzdEZq?=
 =?utf-8?B?T3J6TlJwZzUzR3VwTzF4RDdKNDJlb0dQY1ordEZRTmY0enhEdTJESGdWU2R4?=
 =?utf-8?B?ekFuLy9JNVlSdnBKeERDa0dMdjFTVjNIUFpGR1NnRk10cWtoNDhwb0s0L3BS?=
 =?utf-8?B?YUF1V0VTdmZwY0RNZTRCWGNBeWpVQ29JL1RzZXA5d2dFMHdWT1NrazZvcTYw?=
 =?utf-8?B?YmJFaTJvODdoUDZrZnlSdDFkT1FkWnl5RklsdlIyQk05U2IwK29sSGt5RFFP?=
 =?utf-8?B?U3BudUVwQUtxV0lzUUw1NHdaT1E1OEgrSkt5a1Y4WGRDWW12M3VDdktBdDdp?=
 =?utf-8?B?Q2w5N2VGd0k0bG92VTROekxQN3M0RERsRVkxT1BBalhMeWRlOW9MU3BtS3RJ?=
 =?utf-8?B?cnczM0ZBSFEyTFo4b3VJMTFTKzlyOU9YVjF4VlN3cndMR2I2QlM1Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953db963-2bdf-4438-717d-08de5e97e89d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 18:06:07.4250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezSQ4eWSjXOQ3VYOrMijcWIbAfbO/sUqbYtu3A42Zqwx2fujytRDvSWp3WQNHyatDHefCnsBjyTBJdgi/rSeow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7600
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-8568-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+]
X-Rspamd-Queue-Id: B0442A78B2
X-Rspamd-Action: no action

Create common vchan_dma_ll_prep_slave_{sg,cyclic} API in the DMA
linked-list library, based on the existing fsl-edma implementation.

Update the fsl-edma driver to use the common API instead of maintaining
its own implementation.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 226 ++++++++----------------------------------
 drivers/dma/fsl-edma-common.h |   8 --
 drivers/dma/fsl-edma-main.c   |   4 +-
 drivers/dma/ll-dma.c          | 112 +++++++++++++++++++++
 drivers/dma/mcf-edma-main.c   |   4 +-
 drivers/dma/virt-dma.h        |   9 ++
 6 files changed, 169 insertions(+), 194 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index fdac0518316914d59df592ad26f6000d2034bcb9..643e8bd30b88a2cf66eebf024505428365b8f0ae 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -534,185 +534,55 @@ static int fsl_edma_set_lli(struct dma_ll_desc *desc, u32 idx,
 		iter = 1;
 		disable_req = true;
 		nbytes = len;
-	}
-
-	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_MEM_REMOTE)
-		fsl_chan->is_remote = true;
-
-	/* To match with copy_align and max_seg_size so 1 tcd is enough */
-	__fsl_edma_fill_tcd(fsl_chan, tcd, src, dst,
-			    fsl_edma_get_tcd_attr(src_bus_width, dst_bus_width),
-			    soff, nbytes, 0, iter, iter, doff, irq, disable_req);
-
-	return 0;
-}
-
-struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
-		struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
-		size_t period_len, enum dma_transfer_direction direction,
-		unsigned long flags)
-{
-	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
-	struct dma_slave_config *cfg = &chan->config;
-	struct dma_ll_desc *fsl_desc;
-	dma_addr_t dma_buf_next;
-	bool major_int = true;
-	int sg_len, i;
-	dma_addr_t src_addr, dst_addr, last_sg;
-	u16 soff, doff, iter;
-	u32 nbytes;
-
-	if (!is_slave_direction(direction))
-		return NULL;
-
-	sg_len = buf_len / period_len;
-	fsl_desc = vchan_dma_ll_alloc_desc(chan, sg_len, flags);
-	if (!fsl_desc)
-		return NULL;
-	fsl_desc->iscyclic = true;
-	fsl_desc->dir = direction;
-
-	if (vchan_dma_ll_map_slave_addr(chan, fsl_desc, direction, cfg))
-		goto err;
-
-	dma_buf_next = dma_addr;
-	if (direction == DMA_MEM_TO_DEV) {
-		if (!cfg->src_addr_width)
-			cfg->src_addr_width = cfg->dst_addr_width;
-		fsl_chan->attr =
-			fsl_edma_get_tcd_attr(cfg->src_addr_width,
-					      cfg->dst_addr_width);
-		nbytes = cfg->dst_addr_width * cfg->dst_maxburst;
 	} else {
-		if (!cfg->dst_addr_width)
-			cfg->dst_addr_width = cfg->src_addr_width;
-		fsl_chan->attr =
-			fsl_edma_get_tcd_attr(cfg->src_addr_width,
-					      cfg->dst_addr_width);
-		nbytes = cfg->src_addr_width * cfg->src_maxburst;
-	}
+		enum dma_transfer_direction dir = config->direction;
 
-	iter = period_len / nbytes;
+		if (!desc->iscyclic && idx == desc->n_its - 1)
+			disable_req = true;
+		else
+			disable_req = false;
 
-	for (i = 0; i < sg_len; i++) {
-		if (dma_buf_next >= dma_addr + buf_len)
-			dma_buf_next = dma_addr;
+		fsl_chan->is_sw = false;
 
-		/* get next sg's physical address */
-		last_sg = fsl_desc->its[(i + 1) % sg_len].paddr;
+		if (dir == DMA_MEM_TO_DEV) {
+			dst_bus_width = config->dst_addr_width;
+			if (!config->src_addr_width)
+				src_bus_width = config->dst_addr_width;
+			nbytes = config->dst_addr_width * config->dst_maxburst;
 
-		if (direction == DMA_MEM_TO_DEV) {
-			src_addr = dma_buf_next;
-			dst_addr = fsl_desc->dst.addr;
-			soff = cfg->dst_addr_width;
+			soff = config->dst_addr_width;
 			doff = fsl_chan->is_multi_fifo ? 4 : 0;
-			if (cfg->dst_port_window_size)
-				doff = cfg->dst_addr_width;
-		} else if (direction == DMA_DEV_TO_MEM) {
-			src_addr = fsl_desc->src.addr;
-			dst_addr = dma_buf_next;
+			if (config->dst_port_window_size)
+				doff = config->dst_addr_width;
+		} else if (dir == DMA_DEV_TO_MEM) {
+			src_bus_width = config->src_addr_width;
+			if (!config->dst_addr_width)
+				dst_bus_width = config->src_addr_width;
+			nbytes = config->src_addr_width * config->src_maxburst;
 			soff = fsl_chan->is_multi_fifo ? 4 : 0;
-			doff = cfg->src_addr_width;
-			if (cfg->src_port_window_size)
-				soff = cfg->src_addr_width;
+			doff = config->src_addr_width;
+			if (config->src_port_window_size)
+				soff = config->src_addr_width;
 		} else {
 			/* DMA_DEV_TO_DEV */
-			src_addr = cfg->src_addr;
-			dst_addr = cfg->dst_addr;
 			soff = doff = 0;
-			major_int = false;
-		}
-
-		fsl_edma_fill_tcd(fsl_chan, fsl_desc->its[i].vaddr, src_addr, dst_addr,
-				  fsl_chan->attr, soff, nbytes, 0, iter,
-				  iter, doff, last_sg, major_int, false, true);
-		dma_buf_next += period_len;
-	}
-
-	return __vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc);
-
-err:
-	vchan_dma_ll_free_desc(&fsl_desc->vdesc);
-	return NULL;
-}
-
-struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
-		struct dma_chan *chan, struct scatterlist *sgl,
-		unsigned int sg_len, enum dma_transfer_direction direction,
-		unsigned long flags, void *context)
-{
-	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
-	struct dma_slave_config *cfg = &chan->config;
-	struct dma_ll_desc *fsl_desc;
-	struct scatterlist *sg;
-	dma_addr_t src_addr, dst_addr, last_sg;
-	u16 soff, doff, iter;
-	u32 nbytes;
-	int i;
-
-	if (!is_slave_direction(direction))
-		return NULL;
-
-	fsl_desc = vchan_dma_ll_alloc_desc(chan, sg_len, flags);
-	if (!fsl_desc)
-		return NULL;
-	fsl_desc->iscyclic = false;
-	fsl_desc->dir = direction;
-
-	if (vchan_dma_ll_map_slave_addr(chan, fsl_desc, direction, cfg))
-		goto err;
-
-	if (direction == DMA_MEM_TO_DEV) {
-		if (!cfg->src_addr_width)
-			cfg->src_addr_width = cfg->dst_addr_width;
-		fsl_chan->attr =
-			fsl_edma_get_tcd_attr(cfg->src_addr_width,
-					      cfg->dst_addr_width);
-		nbytes = cfg->dst_addr_width *
-			cfg->dst_maxburst;
-	} else {
-		if (!cfg->dst_addr_width)
-			cfg->dst_addr_width = cfg->src_addr_width;
-		fsl_chan->attr =
-			fsl_edma_get_tcd_attr(cfg->src_addr_width,
-					      cfg->dst_addr_width);
-		nbytes = cfg->src_addr_width *
-			cfg->src_maxburst;
-	}
-
-	for_each_sg(sgl, sg, sg_len, i) {
-		if (direction == DMA_MEM_TO_DEV) {
-			src_addr = sg_dma_address(sg);
-			dst_addr = fsl_desc->dst.addr;
-			soff = cfg->dst_addr_width;
-			doff = 0;
-		} else if (direction == DMA_DEV_TO_MEM) {
-			src_addr = fsl_desc->src.addr;
-			dst_addr = sg_dma_address(sg);
-			soff = 0;
-			doff = cfg->src_addr_width;
-		} else {
-			/* DMA_DEV_TO_DEV */
-			src_addr = cfg->src_addr;
-			dst_addr = cfg->dst_addr;
-			soff = 0;
-			doff = 0;
+			irq = false;
 		}
 
-		/*
-		 * Choose the suitable burst length if sg_dma_len is not
-		 * multiple of burst length so that the whole transfer length is
-		 * multiple of minor loop(burst length).
-		 */
-		if (sg_dma_len(sg) % nbytes) {
-			u32 width = (direction == DMA_DEV_TO_MEM) ? doff : soff;
-			u32 burst = (direction == DMA_DEV_TO_MEM) ?
-						cfg->src_maxburst :
-						cfg->dst_maxburst;
+	       /*
+		* Choose the suitable burst length if sg_dma_len is not
+		* multiple of burst length so that the whole transfer length is
+		* multiple of minor loop(burst length).
+		*/
+		if (len % nbytes) {
+			u32 width = (dir == DMA_DEV_TO_MEM) ? doff : soff;
+			u32 burst = (dir == DMA_DEV_TO_MEM) ?
+					config->src_maxburst :
+					config->dst_maxburst;
 			int j;
 
 			for (j = burst; j > 1; j--) {
-				if (!(sg_dma_len(sg) % (j * width))) {
+				if (!(len % (j * width))) {
 					nbytes = j * width;
 					break;
 				}
@@ -721,27 +591,19 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 			if (j == 1)
 				nbytes = width;
 		}
-		iter = sg_dma_len(sg) / nbytes;
-		if (i < sg_len - 1) {
-			last_sg = fsl_desc->its[(i + 1)].paddr;
-			fsl_edma_fill_tcd(fsl_chan, fsl_desc->its[i].vaddr, src_addr,
-					  dst_addr, fsl_chan->attr, soff,
-					  nbytes, 0, iter, iter, doff, last_sg,
-					  false, false, true);
-		} else {
-			last_sg = 0;
-			fsl_edma_fill_tcd(fsl_chan, fsl_desc->its[i].vaddr, src_addr,
-					  dst_addr, fsl_chan->attr, soff,
-					  nbytes, 0, iter, iter, doff, last_sg,
-					  true, true, false);
-		}
+
+		iter = len / nbytes;
 	}
 
-	return __vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc);
+	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_MEM_REMOTE)
+		fsl_chan->is_remote = true;
+
+	/* To match with copy_align and max_seg_size so 1 tcd is enough */
+	__fsl_edma_fill_tcd(fsl_chan, tcd, src, dst,
+			    fsl_edma_get_tcd_attr(src_bus_width, dst_bus_width),
+			    soff, nbytes, 0, iter, iter, doff, irq, disable_req);
 
-err:
-	vchan_dma_ll_free_desc(&fsl_desc->vdesc);
-	return NULL;
+	return 0;
 }
 
 void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 7cba3bc0d39537e675167b42dda644647bf63819..b5bfd3162237bb9dd585bbf91e6f9f73f0376112 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -469,14 +469,6 @@ int fsl_edma_slave_config(struct dma_chan *chan,
 				 struct dma_slave_config *cfg);
 enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
 		dma_cookie_t cookie, struct dma_tx_state *txstate);
-struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
-		struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
-		size_t period_len, enum dma_transfer_direction direction,
-		unsigned long flags);
-struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
-		struct dma_chan *chan, struct scatterlist *sgl,
-		unsigned int sg_len, enum dma_transfer_direction direction,
-		unsigned long flags, void *context);
 void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan);
 void fsl_edma_issue_pending(struct dma_chan *chan);
 int fsl_edma_alloc_chan_resources(struct dma_chan *chan);
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 1724a2d1449fe1850d460cefae5899a5ab828afd..e405aa96e625702673b5fc64e1102b50d18eb894 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -848,8 +848,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma->dma_dev.device_free_chan_resources
 		= fsl_edma_free_chan_resources;
 	fsl_edma->dma_dev.device_tx_status = fsl_edma_tx_status;
-	fsl_edma->dma_dev.device_prep_slave_sg = fsl_edma_prep_slave_sg;
-	fsl_edma->dma_dev.device_prep_dma_cyclic = fsl_edma_prep_dma_cyclic;
+	fsl_edma->dma_dev.device_prep_slave_sg = vchan_dma_ll_prep_slave_sg;
+	fsl_edma->dma_dev.device_prep_dma_cyclic = vchan_dma_ll_prep_slave_cyclic;
 	fsl_edma->dma_dev.device_prep_dma_memcpy = vchan_dma_ll_prep_memcpy;
 	fsl_edma->dma_dev.device_config = fsl_edma_slave_config;
 	fsl_edma->dma_dev.device_pause = fsl_edma_pause;
diff --git a/drivers/dma/ll-dma.c b/drivers/dma/ll-dma.c
index 66e4222ac528f871c75a508c68895078fa38cf7b..de289e10468b9c0e6ab6c15b1bd49ab2b627e59d 100644
--- a/drivers/dma/ll-dma.c
+++ b/drivers/dma/ll-dma.c
@@ -216,6 +216,118 @@ vchan_dma_ll_prep_memcpy(struct dma_chan *chan,
 }
 EXPORT_SYMBOL_GPL(vchan_dma_ll_prep_memcpy);
 
+static dma_addr_t
+vchan_dma_get_src_addr(struct dma_ll_desc *desc, dma_addr_t addr,
+		       enum dma_transfer_direction dir)
+{
+	if (dir == DMA_DEV_TO_MEM || dir == DMA_DEV_TO_DEV)
+		return desc->src.addr;
+
+	return addr;
+}
+
+static dma_addr_t
+vchan_dma_get_dst_addr(struct dma_ll_desc *desc, dma_addr_t addr,
+		       enum dma_transfer_direction dir)
+{
+	if (dir == DMA_MEM_TO_DEV || dir == DMA_DEV_TO_DEV)
+		return desc->dst.addr;
+
+	return addr;
+}
+
+struct dma_async_tx_descriptor *
+vchan_dma_ll_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+			   unsigned int sg_len, enum dma_transfer_direction dir,
+			   unsigned long flags, void *context)
+{
+	struct virt_dma_chan *vchan = to_virt_chan(chan);
+	struct dma_slave_config *config = &chan->config;
+	struct dma_ll_desc *desc;
+	struct scatterlist *sg;
+	int i, ret;
+
+	if (!is_slave_direction(dir))
+		return NULL;
+
+	desc = vchan_dma_ll_alloc_desc(chan, sg_len, flags);
+	if (!desc)
+		return NULL;
+	desc->iscyclic = false;
+	desc->dir = dir;
+
+	if (vchan_dma_ll_map_slave_addr(chan, desc, dir, config))
+		goto err;
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		dma_addr_t addr = sg_dma_address(sg);
+
+		ret = vchan->ll.ops->set_lli(desc, i,
+					     vchan_dma_get_src_addr(desc, addr, dir),
+					     vchan_dma_get_dst_addr(desc, addr, dir),
+					     sg_dma_len(sg),
+					     i == sg_len - 1, config);
+		if (ret)
+			goto err;
+	}
+
+	return __vchan_tx_prep(vchan, &desc->vdesc);
+
+err:
+	vchan_dma_ll_free_desc(&desc->vdesc);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(vchan_dma_ll_prep_slave_sg);
+
+struct dma_async_tx_descriptor *
+vchan_dma_ll_prep_slave_cyclic(struct dma_chan *chan, dma_addr_t dma_addr,
+			       size_t buf_len, size_t period_len,
+			       enum dma_transfer_direction dir,
+			       unsigned long flags)
+{
+	struct virt_dma_chan *vchan = to_virt_chan(chan);
+	struct dma_slave_config *config = &chan->config;
+	dma_addr_t addr = dma_addr;
+	struct dma_ll_desc *desc;
+	int nItems;
+	int i, ret;
+
+	if (!is_slave_direction(dir))
+		return NULL;
+
+	nItems = buf_len / period_len;
+	desc = vchan_dma_ll_alloc_desc(chan, nItems, flags);
+	if (!desc)
+		return NULL;
+	desc->iscyclic = true;
+	desc->dir = dir;
+
+	if (vchan_dma_ll_map_slave_addr(chan, desc, dir, config))
+		goto err;
+
+	for (i = 0; i < nItems; i++) {
+		ret = vchan->ll.ops->set_lli(desc, i,
+					     vchan_dma_get_src_addr(desc, addr, dir),
+					     vchan_dma_get_dst_addr(desc, addr, dir),
+					     period_len, true, config);
+		if (ret)
+			goto err;
+
+		addr += period_len;
+	}
+
+	ret = vchan->ll.ops->set_ll_next(desc, nItems - 1, desc->its[0].paddr);
+	if (ret)
+		goto err;
+
+	return __vchan_tx_prep(vchan, &desc->vdesc);
+
+err:
+	vchan_dma_ll_free_desc(&desc->vdesc);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(vchan_dma_ll_prep_slave_cyclic);
+
 int vchan_dma_ll_terminate_all(struct dma_chan *chan)
 {
 	struct virt_dma_chan *vchan = to_virt_chan(chan);
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index 60c5b928ade74d36c8f4206777921544787f6cd8..6d68dfd97b47c88d2499540b10564b964820b807 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -221,8 +221,8 @@ static int mcf_edma_probe(struct platform_device *pdev)
 			fsl_edma_free_chan_resources;
 	mcf_edma->dma_dev.device_config = fsl_edma_slave_config;
 	mcf_edma->dma_dev.device_prep_dma_cyclic =
-			fsl_edma_prep_dma_cyclic;
-	mcf_edma->dma_dev.device_prep_slave_sg = fsl_edma_prep_slave_sg;
+			vchan_dma_ll_prep_slave_cyclic;
+	mcf_edma->dma_dev.device_prep_slave_sg = vchan_dma_ll_prep_slave_sg;
 	mcf_edma->dma_dev.device_tx_status = fsl_edma_tx_status;
 	mcf_edma->dma_dev.device_pause = fsl_edma_pause;
 	mcf_edma->dma_dev.device_resume = fsl_edma_resume;
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index 0a18663dc95f323f7a9bab76f2d730701277371a..d1bb130f0fd798f8ec78cc8f88da3f8d1ae74625 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -308,6 +308,15 @@ struct dma_async_tx_descriptor *
 vchan_dma_ll_prep_memcpy(struct dma_chan *chan,
 			 dma_addr_t dma_dst, dma_addr_t dma_src, size_t len,
 			 unsigned long flags);
+struct dma_async_tx_descriptor *
+vchan_dma_ll_prep_slave_cyclic(struct dma_chan *chan, dma_addr_t dma_addr,
+			       size_t buf_len, size_t period_len,
+			       enum dma_transfer_direction dir,
+			       unsigned long flags);
+struct dma_async_tx_descriptor *
+vchan_dma_ll_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+			   unsigned int sg_len, enum dma_transfer_direction dir,
+			   unsigned long flags, void *context);
 void vchan_dma_ll_free_desc(struct virt_dma_desc *vdesc);
 int vchan_dma_ll_terminate_all(struct dma_chan *chan);
 int vchan_dma_ll_map_slave_addr(struct dma_chan *chan, struct dma_ll_desc *desc,

-- 
2.34.1


