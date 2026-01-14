Return-Path: <dmaengine+bounces-8253-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87118D207ED
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 18:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A5CD30B3711
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 17:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946C72EBBB7;
	Wed, 14 Jan 2026 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YFhfmBhy"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40D72ECE93;
	Wed, 14 Jan 2026 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410817; cv=fail; b=P5oxSuOnTLSZxKUTej3GkTo8Hih2mYi24JKSqpv+K0CWw9wSK0QA1CK0TkwgpNW1j50PJHSoKnvaKRJJNiasNTmMjpp+swDS7dvm9t4cLSBq8qgBY7XHfVxtAc+DIrqExJ8g1IEY0egbvzkZI6cGcMveDIyW0fAClFE3KYWbZks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410817; c=relaxed/simple;
	bh=3y63TyYP7BOYQXn3w7jcajxclSrGCMkNn/bm2z6pSTY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=um25yIzLbFMIo+HqvL6u/OkJZTun4963J7vARLnhiUgyBaVD3EpvCd+JRBPOWRaclvztAW6BJ9ksAX++XQp7zs1GuWYvBQUC48++ScyHPjMBN24WlbOEdN3u6f8go3ja5qJxpiJX7zWihPKUtKbgweFClapxkt4OwbhaD9JHnlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YFhfmBhy; arc=fail smtp.client-ip=52.101.84.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpnktG9MG2jZBTf8cvbU7BkIzKKI1TOchHb5zMvy6ByHkKCTgB7gvl8CbpLne+MEqLVw3msngHRLdXG3OEl6+8yDwyG/29LEDsEElVIF/G0pycqm96CeCif5TgwJlvjHHwAtmrmt0m++GOn7cUyKtd5+EIVgAQF82xWREcnw8isTgEsHtgXkhQB8q9ar9AhwLdY2TcELijJfYR1+tuJCzcX+voCR7xXVVbCGboiwg6qkkK32SdSVIKlDXRK5Rj3vIxTlpjIKKuWpgSaxuv/RG2a8XVNAfYGDpdZR0h8HhFRc4JfRoJr/tCKM1slSY/yUmyzBXVlCa5QQiYykb8FxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rndFeVMVjxOc0AaKh1FX/5S3iK1purkWokdgUkSXeI=;
 b=CYRXl2dmeAvlvl8zB3ekhQON9WXVInQO2t0HGqcEZo7ZiMyyf32SSJ1VJPbFuYvn16qbJjnpxp4jKWu+DOEHbSrUXYiNEJ0PT1gXEjcZQPxS5Ol0YPLh/iNK6nfWdvLxXmnNsdZIc7YhB9SKhdMHf3q5ZR2vK5UagkUwRgtTjHHHSZBHXwSTat+OfgO1ulrneaPE4FL3ZN3lYy+zXcBfzolqGhCn/LOx2nz0Dpd+FH/X+InHjA6UQ4QWuwi9BrLtoQ3QITvUw+MBVhpDHYP8VlVxQdwq39Wch05la+Du91/Xq3AOTqfy/yR63oZnRqhoJgWhOLF4TCK2DjZg3oq+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rndFeVMVjxOc0AaKh1FX/5S3iK1purkWokdgUkSXeI=;
 b=YFhfmBhyO4v6/Ybs/uirhBVKsqCgiuNynAnyQFGz1OsHBD8OUONZ8Y0J+s4K5FJomCfC401tlCbxq7EL9ggiStqtCxmRQolI4i/33qjgLo43xS8xI62f2jWUhMjlT8wIoAW/OJiyxO1BgBKvzp7ulrY1TX+XwG74cMaIbs5aOek3qrP+491QzZ4NbB7/9r8GthYxpTSvYuf08QzrWorlMXgZG8gyfu9cxvh6rhmLN0ypj8IuUSAPibi4SV73a5Bby8akfKgr5it52WY7knTgjsETtB/NA0YXgu/nW/mxw2VD4dK8gKPGJPkm9qxATXqcQmrT7Yqsc8YrORGzvfIpfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by VI0PR04MB12155.eurprd04.prod.outlook.com (2603:10a6:800:312::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 17:13:26 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Wed, 14 Jan 2026
 17:13:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 14 Jan 2026 12:12:47 -0500
Subject: [PATCH 6/6] dmaengine: fsl-edma: use common dma_slave_get_cfg()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-dma_common_config-v1-6-64feb836ff04@nxp.com>
References: <20260114-dma_common_config-v1-0-64feb836ff04@nxp.com>
In-Reply-To: <20260114-dma_common_config-v1-0-64feb836ff04@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768410779; l=3287;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=3y63TyYP7BOYQXn3w7jcajxclSrGCMkNn/bm2z6pSTY=;
 b=cfs2WYv5qwzdk96A/gQoLrSoUG7flEV7Qr2OyDDH5vuAYpi/RFLw1nVb7BwcvNRK8tje1fu0o
 gzRqU5Rbh/SAWz9TKOyWRxa0YydvqV3kIxXHffxLjfUdCTENhNmhmAY
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY1P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::10) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|VI0PR04MB12155:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a6119f-e078-4a44-f0e5-08de53903aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG81cGhuZms1UGxpbkdwb2g4ayszT3hrVHF5elNYV3lKMjhUeXE1RUx3N1Mr?=
 =?utf-8?B?WjRhcFVpM0dYT2ZnbkY0Skd1YkNaTGdQZyt4ekpycFFsTGdsZ2JxZTROejhs?=
 =?utf-8?B?bXhkQ0J3RDZWWGdTZkhWNkdldk5wcEVoSzd4QVdmbEUwOUdhd0ZBUWdkZVk4?=
 =?utf-8?B?MFg2UExvb09NcFlvUEhlWGs4M1BrVTZiTjNQYXNwblRoSTZCcjRrdDU3c2pY?=
 =?utf-8?B?SjRQaHNsajFHODJBU3o5bEVPVlBVaGRpR1BTRDM0TGE2Ukh5NlpISm5JdW1M?=
 =?utf-8?B?dVJjR3lvZWJicDhLaEorYldRYTROeDVsbXpjdVZ4R1RCaTVjMG85WWoraWc0?=
 =?utf-8?B?QXdNVnRoZmpnZGx5cVFSQlhxRC84cUdLK2pMZUpGTzE5cXUyN25iQmJicmZN?=
 =?utf-8?B?eitKTFZpWVJiNkxxaXAyaVl0bEhqUjRTQzJsMXZTcWJ2anZGZ1oyNkZIbDAy?=
 =?utf-8?B?cUJDb2xFQzVEVVRTRkwwR09TclBWYVg5WlhMNm1vSjN5M0gxcG5jT00vQkFs?=
 =?utf-8?B?Y1VTS3ZzenprOHZrNm1YdUZUbU1NeDZQdGd6R0lqNmNDZVVmYzdRaVZoRG1Y?=
 =?utf-8?B?ZC9jNmVxTDF4cUt5U1ZFaUJvcGlQRkJFdlYyRkhKR08wQmNidEtxTUdWTFlj?=
 =?utf-8?B?ZHpLbUt4NFhMVURvZk9uSzM3TUYwUFg4Y25TVzhqUWVYQ0pxeGR5dGFoUTZD?=
 =?utf-8?B?RmVwbjA1bzlWMlo5NXAyWEt0MEsvYlZIL0RjdHhIUGdmbzdRdmI0N2hVRW1J?=
 =?utf-8?B?eC9DRWNWOEtIaGZ4ZTc4cjZBQkdkazdtUkZsdDBCdW92Rlg1UVltSE5TT1M3?=
 =?utf-8?B?SGJwSlBkV2J3ellZcGhwbi80cWRiSlozRXM1bDBxOTkwclJGMVZ0bWgwRjBZ?=
 =?utf-8?B?RDFpZGRVaVVJMGdCTDZNdjA0Z0tpSW9YZnBMZno2ZEVDK2UrODZNbklZWXdY?=
 =?utf-8?B?NUgzY0tFWkt6OWR5V0FreFBJejFEYnBHODBlbmFGUzFoa2JRcG1mLzhSY3Js?=
 =?utf-8?B?MVl0cm52MjczNlBWZDUybW9pZ2pOZkppMFNla2xTS3pKZFExY28yZmthR3I1?=
 =?utf-8?B?MnBUWDBja1VwQ2RjUm8vc1Q2NTA1d3FCS3dEWE5Bb0o1THlaM0RTL2dBOXNZ?=
 =?utf-8?B?VTU4L1ZPc3NPMHVhaWgzUWFFQTJLR2dNYTJ1NGthMzlFaC9xRUk3TXV0TVRL?=
 =?utf-8?B?T2V6Vzl6cFUySTcyTVlFblFmemRnS3RnNFVsOENrTS9uc1MvRUVpNkxHUnlo?=
 =?utf-8?B?N3FkZ0ZISWgxVlFkaEFHVmlKa0VXTTBhTTRqSnF6VFAvaTdsUFVpVUJoOXB5?=
 =?utf-8?B?OVFSNnpoSytGVUo0WXpKOXpVLzN3am41OHNZQUx3MS8wNzJmNnlPQ2FBYyth?=
 =?utf-8?B?cUZ5cDJVMDNyd0ZHemNMRTBoOWFTMUhrUTlLejZUN1V2ZU1UTWNwNG5kNkxD?=
 =?utf-8?B?bVdwR1YrQnk0UlZ1M1E0U3dSMFVsUHcvZnVYRitsVlZhOFNLNVlCVkZYWkVp?=
 =?utf-8?B?Z3NrSXpneGN4NFNJZ25aQy9SSmNsT2h6aG5wUy9tTFlCU2hKRjdQSWg1NXFG?=
 =?utf-8?B?Z1VaM1NCWTd5NUJ0cWxSTXhtWGNvNzJsNWxWR1gzdmpDM0RIMXNtdWtMa2Vs?=
 =?utf-8?B?aWFObmx2S3BUVGR2dnJES0pyN09sQk5oSWlnU3BLampqTkZyTEpjWkR6bXpP?=
 =?utf-8?B?UHR4QkczSFV2QThDcmVJNUVpQ1hXMlF3RUhqSUlMcVYvaTUvWDk3OHdXa0d2?=
 =?utf-8?B?SFpQS05pbjlqZ3ZvbEVyMjVWUUcwWG05cG5sRUZ6RHVuNG11NTNFYkh5YXA1?=
 =?utf-8?B?MWNpV2NIcVdxckVlSmtPSHIvOHhvVDFmaVo2bE4xVUZuK0hkWHZSd01lM1po?=
 =?utf-8?B?b2pGSHlkR3VEbUVmSWd3d0pTM0w2b2Q5a2c5VWRFVXN2enlHR3dGV0VUZlkx?=
 =?utf-8?B?VHVyaGlMZUgxSGdUQ1FYVDRlNzNhWmNGMFk4M2tuaFc4c29PT3BpWU9xWkt2?=
 =?utf-8?B?NzNDN1YxWTBCUHZtWE5FbVhFSkhOdHBLSDFYS3JMcHRtT0xCRzFlR2NxaEpi?=
 =?utf-8?B?UEY2ZXRrQUpNd08vNk1ndkQreXA5cUI1V2kremJQQkRxR3h1T1JsMkJkcldU?=
 =?utf-8?B?MFN2bXpiZk1ES0ozSFF5aUNnOC9aamY1L2gwTm1YYTJXa081a3BTMW1RQkRI?=
 =?utf-8?Q?2gqDVhaW5nn6i9Kuy/GDhgk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlZlNjlhSS9qVG5QeW4xRytuaURPcmMrRURocStJemxIV3N6R3U1S2hiZlhW?=
 =?utf-8?B?UmVnRTJ3SG8rc05FSWcyeUs0YktUNzMxbWQxY3p0ckVLQjZpMi9Ob3NxWGE3?=
 =?utf-8?B?K1h3RkdWb2xyaXlGeEtRR2Ftak1NLzBES3BHOUU0QjNOWDFPNVkza2FvWWl3?=
 =?utf-8?B?NUN3VHRwQ3FOR1o2Vm5MRFJPSnJITkdIUStuM1dwbUpramVibTNNcDRjNFRS?=
 =?utf-8?B?TjlCcjBxYWRwbWw5b3hiWWdOSlBhTHl6MEh1V2N6eGRkQ2FSTUNSbzZ6SXB0?=
 =?utf-8?B?eDZYWEZSU2dZWDRuSGl1d1VCeTJtVmJkVldGbGIrdTdFajVibWVRNTIvU0xI?=
 =?utf-8?B?eHVrWmVLZ1hHZ2xpTXpuTEZLQjRVOEhkUWlScGR2R0F1amZ5TlJhbml3b0Ro?=
 =?utf-8?B?V1dTM2xBKy9FbzlWdmJHRVk4cVlOcS9NT2Z6eldpSU9BT2dGSWRBcE5WTlN0?=
 =?utf-8?B?RFZzZ2RxVlkxbnVrdTJFWVBNRFhtSE0rMVYrdUZtOGNyTENlRlVicjVaem5E?=
 =?utf-8?B?QjlRNjQ0T2FiQjRTWnBjR2l5d3lEWTgreERSZGppYmp3cWhEKzBPRkZIekRw?=
 =?utf-8?B?RW1GRVNJZlBwSm5sOXlRbklZWVNqZEZsZklCdFhwdkQ0am1BZWcwc0Y2SEw3?=
 =?utf-8?B?emZOZnBVVGJxQmtuZ3FORk9VeW5sZ0t5d3lOOS9IRk1yR3NFV2NESTdJQTNG?=
 =?utf-8?B?a1lJVEVkdGROc01EL3p1V0tFd2V0U2JzMWxKc1daY1paSEI0M2FNZllqMmlN?=
 =?utf-8?B?N2ZsaUplL1h3YXJiRHRQMEdnYmNCazg3YmNwWUx6Sm9tYlNKSDV0V3VmdUNK?=
 =?utf-8?B?UGxrQ3dCT3p4ZkhjR0JCRHVQSHNTaGVOUVpieXJNTFN1VitrcEd5aXBJVEYr?=
 =?utf-8?B?YnA0WVArTkprM2M4L3Q4L2ZUZFgzczhJeEtJMlBLZVBYSU0veUZXNWt5TEIz?=
 =?utf-8?B?dXIydkZSL2xKb1E3azRQZVc2dlRnenBEQ21OSDN5OW84dUxZSHkyQWdXbElY?=
 =?utf-8?B?dkxHMnJwRUVzenhlY0F3bUVacXoyNTZoeHhIWFIxVU11c0lIWXZHenpXK21H?=
 =?utf-8?B?OXVNdTRZVnVmaDZjR0pSbzczNHA2WDNPb3NtZ3JjVzFRSXE1alROTm5XUCth?=
 =?utf-8?B?VDF2YnJvd0N4dDNWOGVKVmFnN0RtNUxmYlo2by95TkszMURlSE1VTWl6NkhP?=
 =?utf-8?B?TCtrTlZ0NzJSNmVUc2VDZmFRZkpMZXRPVDRXQVU2WUNhZzRNUG9NRDVsbExi?=
 =?utf-8?B?bmh6ZmpTc2xNSFUrajIzenQ2Ykx2YkJ4Y291czVEbk5nTUNUQWtsQjMxZHhy?=
 =?utf-8?B?dCtlemwxclNLMlpFN3dOMTFtRVNVL0w2TStFRytBWGkxVm9yWVBQRGdCQ1A2?=
 =?utf-8?B?QkNnck90aC9Xd3NjaEFhT01tV1RGWkZGRDJtbDZhQnp0MWREQmV4LytUcjRU?=
 =?utf-8?B?RkN3bmFFaUJUQktadU1PazliMnBON2lxK0Jac083UXNhdmoyRzVjWlkzRE5y?=
 =?utf-8?B?eDRscCsvc1VnUGUxVUs3WTd6ZjBmUCtKeVkxa1BIV3NTelIzREF1OWNTWmZy?=
 =?utf-8?B?ckxlNDFVUEVZbWlkc0ZXNDh2RDN3NTZxOGJyYjNMSnVQeWxCalBOMFhKWlN6?=
 =?utf-8?B?Slc1eXlHM29BMExySlltNENUdHYxaWprU3hTMXZ2R013RnFXU0lyNEc0UVFY?=
 =?utf-8?B?L3dGRGNHS3pzby9RcG1tcDlraFhEQjlvL0Q2bkJqa2RGNm13di91K0hmeHFG?=
 =?utf-8?B?ZEtGbUhXVkhlTitpYWI5aFZvc0c4SFMyaWlpNnk2QTBTNkFTV3ZyMkppVUV6?=
 =?utf-8?B?c1VhSDRtT2VzQXhRUFU2RUFjdE5tdStoZUhMeHF6ekZRelROaTcyMHNuZExn?=
 =?utf-8?B?clh1TnNNZFF3UGJaT25zaEM5NGV4VDVEK09qWlU5OFhBQ0gwMGJQWCtJVW5O?=
 =?utf-8?B?M1FzM3hoTkNWMXEwa1RodnBSQUdWN3JDVUh5c3RwL1lnN2NIMHdBcWphK2Rj?=
 =?utf-8?B?VHRuM2tjYVhRam9qMVhHTFc0UHRnK2dERlo3aVBnblRVY2tycUt3WWd0ZVVy?=
 =?utf-8?B?Uy9JN3h0UG1wQ0F2SDVoSkttbjJaeUFyT2thdzFDQjJJMHFSa2lpdHB3d0Fr?=
 =?utf-8?B?MVpqQzRsYVdQRDNEckVFanAwSTRwSHZoOWc2dHcxVmJvSjhvRExKTXVLSXNL?=
 =?utf-8?B?Z2Rkc25ObFgzaVE2L1JNMGVwa3A3bnI5Rm5TbkdIMTVTVXViMzZoQTZSUzA4?=
 =?utf-8?B?eEYvTE03MFhDMkQzL0s2Nk1ZSDE4ZnRMR2QzRFk0d29lZXFaUFFFMTNlUkVs?=
 =?utf-8?B?L04vdlg0cFBNN1JoajlWMW9tblJLTHV4YjFOVlFqdDV1d1RCRHg1QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a6119f-e078-4a44-f0e5-08de53903aff
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:13:26.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tq09AU2YZeGi/3YFnLY8xdVwG7Cvy5D49LYb2bEa/JmabHJ6IPPvlGTzu1Vk04+oAzx4koBN1g7fcOcKX/GHNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12155

Use common dma_slave_get_cfg() to simple code. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 61 ++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 33fc4fa8d1302d899ce550b0ce5d4325fa2e3916..c4ac63d9612ce9f1f5826a2186938a785ed529d1 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -291,30 +291,32 @@ static void fsl_edma_unprep_slave_dma(struct fsl_edma_chan *fsl_chan)
 	fsl_chan->dma_dir = DMA_NONE;
 }
 
+static enum dma_data_direction
+fsl_dma_dir_trans_to_data(enum dma_transfer_direction dir)
+{
+	if (dir == DMA_MEM_TO_DEV)
+		return DMA_FROM_DEVICE;
+
+	if (dir ==  DMA_DEV_TO_MEM)
+		return DMA_TO_DEVICE;
+
+	return DMA_NONE;
+}
+
 static bool fsl_edma_prep_slave_dma(struct fsl_edma_chan *fsl_chan,
 				    enum dma_transfer_direction dir)
 {
 	struct dma_slave_config *cfg = &fsl_chan->vchan.chan.config;
+	struct dma_slave_cfg *c = dma_slave_get_cfg(cfg, dir);
 	struct device *dev = fsl_chan->vchan.chan.device->dev;
 	enum dma_data_direction dma_dir;
 	phys_addr_t addr = 0;
 	u32 size = 0;
 
-	switch (dir) {
-	case DMA_MEM_TO_DEV:
-		dma_dir = DMA_FROM_DEVICE;
-		addr = cfg->dst_addr;
-		size = cfg->dst_maxburst;
-		break;
-	case DMA_DEV_TO_MEM:
-		dma_dir = DMA_TO_DEVICE;
-		addr = cfg->src_addr;
-		size = cfg->src_maxburst;
-		break;
-	default:
-		dma_dir = DMA_NONE;
-		break;
-	}
+	dma_dir = fsl_dma_dir_trans_to_data(dir);
+
+	addr = c->addr;
+	size = c->maxburst;
 
 	/* Already mapped for this config? */
 	if (fsl_chan->dma_dir == dma_dir)
@@ -484,6 +486,7 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 		       bool disable_req, bool enable_sg)
 {
 	struct dma_slave_config *cfg = &fsl_chan->vchan.chan.config;
+	struct dma_slave_cfg *c = dma_slave_get_cfg(cfg, cfg->direction);
 	u32 burst = 0;
 	u16 csr = 0;
 
@@ -507,26 +510,14 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 	 * If we don't have either of those, will use a major loop reading from addr
 	 * nbytes (29bits).
 	 */
-	if (cfg->direction == DMA_MEM_TO_DEV) {
-		if (fsl_chan->is_multi_fifo)
-			burst = cfg->dst_maxburst * 4;
-		if (cfg->dst_port_window_size)
-			burst = cfg->dst_port_window_size * cfg->dst_addr_width;
-		if (burst) {
-			nbytes |= EDMA_V3_TCD_NBYTES_MLOFF(-burst);
-			nbytes |= EDMA_V3_TCD_NBYTES_DMLOE;
-			nbytes &= ~EDMA_V3_TCD_NBYTES_SMLOE;
-		}
-	} else {
-		if (fsl_chan->is_multi_fifo)
-			burst = cfg->src_maxburst * 4;
-		if (cfg->src_port_window_size)
-			burst = cfg->src_port_window_size * cfg->src_addr_width;
-		if (burst) {
-			nbytes |= EDMA_V3_TCD_NBYTES_MLOFF(-burst);
-			nbytes |= EDMA_V3_TCD_NBYTES_SMLOE;
-			nbytes &= ~EDMA_V3_TCD_NBYTES_DMLOE;
-		}
+	if (fsl_chan->is_multi_fifo)
+		burst = c->maxburst * 4;
+	if (c->port_window_size)
+		burst = c->port_window_size * c->addr_width;
+	if (burst) {
+		nbytes |= EDMA_V3_TCD_NBYTES_MLOFF(-burst);
+		nbytes |= EDMA_V3_TCD_NBYTES_DMLOE;
+		nbytes &= ~EDMA_V3_TCD_NBYTES_SMLOE;
 	}
 
 	fsl_edma_set_tcd_to_le(fsl_chan, tcd, nbytes, nbytes);

-- 
2.34.1


