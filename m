Return-Path: <dmaengine+bounces-8276-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B4DD25A03
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 17:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3A423094A45
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82003ACF04;
	Thu, 15 Jan 2026 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FhdlfUYu"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510323A7F61;
	Thu, 15 Jan 2026 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493234; cv=fail; b=bSmSMi+xNtZfhh5KHakyt2kkw/OYcIkJR0p5+oDs3ptA19b2bI272Brgq5972A3u8u9axJW4KPCpLqoz6UyIy/omGvEHOba/EioSx2rDuiVp1kRxxh0lqXSQyJOmM2xZrKDqSSZ5UEDENQ1N0l5DbrQpQujkM4DAfr8FDyBTQgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493234; c=relaxed/simple;
	bh=GlassXC6T5YVcZB8CD99aM3ImtaqJYCHCRVEsXDzZ4E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LP8TwnqniEoQCd563QQlvfRtk+e0BFrxVuBm0X22oa8K4lCFETc54Lt9AXLwOepROSlT+3xR7PN0C9pfGt9lWYtzl0f3I9vUoOkP6jol1LHXYCclhThBtG1WtqoAtfg+swXcn6WN59jOwTJWjYh8lW8lq5+cGhZbRp1EoKECxBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FhdlfUYu; arc=fail smtp.client-ip=52.101.72.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsWob8iu7rxrTRvNM+8jmuNxP5iidKpmf5LY7REwdsk984rIgyap7OHcMYvrMvJKo06OscfLOjGrAy+lvSk/G9Q7sJOrntlcZKH/1eU/TevNDPeUHBej7yIbIqRP+VVQ/ZR3fab7f/Txm8iTS3h8fajxmog8gZCm2uMcnHVaGqOgL/d3Z96UV2Mae/WCPqCiVYFLznKdu+l0hKS3ryxfMuLCOaqQqsWK1AzJTiZ8rFie3cPazcnd+G4HinY/l/2eVtcTksazDlsfz1Dm5gz8bbIDp5DOeSxcsVxFWKNXmlsZTasZcrUAr5MCH6ovafdX26MswQnzK9ufWKiNG6BDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUGJRn0fWv9aFV2kLjSBiIwvqm1manqZ1O76dINpPQU=;
 b=BOYxEA17BOmKM9JJF6L90sNl1cCee4dANAY2hUDo/J29MnyJOqOi0zivAq+nPjB83ta4sijzF9inep48C1vagoaceP7GFsyfuS2ylz8wi7lpgTYpXOvVDr0UlYxLuBO7blVylspI8JSvSBimjSQ26+MYZ7Yu7M5kJ/MPvA0BwrekTjlB5KMTLXE0HjGy42gkAWd+oHdrstTY/Dy7v4p230nnQkkPElRGC3Tb2HXIIR6tNxxdaERlP9UVzaJbQ5NNaZd5Ok4U4YobGakHWBssHhjabnFZWckfyFFjyP9opMyVQ+mZ0n92P7s0Df4iXiZVGQkwHCtmPU7VvtY3KD9pSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUGJRn0fWv9aFV2kLjSBiIwvqm1manqZ1O76dINpPQU=;
 b=FhdlfUYu5+/1L+e7qS4QhbDL2VHopNAiDsqh56Z+4p+lZhYhj5MK59vIbYCS2GPjR+x3VTPPcZAh/cAkY1wco2hfwpGZNI2deROHBQ3OD8xRn5d62WWTBeDuTUdtYP19A20jeKWCz7jGnwiAUN4ZVwDtzjk5GInXKyFeF06ExUB2a36N6TUf+SvOEd+Y32HLv1ukMDRaCEd1RjKInfi7jRSA3T0e7G8xAii+EEx/t/o/yuzX4IZWpU7vhM9q2gLqTjwrrqr1zGJ5Nx0D2fg5yu6SoVZcOXzkorP9si+AU5t8fMRb7vfieU9AtahTHrztGFPhovD0w5wUDERXQTYA2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by VI0PR04MB12235.eurprd04.prod.outlook.com (2603:10a6:800:333::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 16:07:11 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Thu, 15 Jan 2026
 16:07:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 15 Jan 2026 11:06:41 -0500
Subject: [PATCH v2 02/13] dmaengine: mxs-dma: Fix missing return value from
 of_dma_controller_register()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-mxsdma-module-v2-2-0e1638939d03@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768493221; l=765;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GlassXC6T5YVcZB8CD99aM3ImtaqJYCHCRVEsXDzZ4E=;
 b=j6uJ3KqfFj4zkCadELKvOf5OUYYLC68sJt3SQfzdQjP9ZCNnuAbATEAYjhQHEf4KFdpGjXJo+
 8iRieyRLd0sAcyO9u9H7EPlJMESQiGtyJiZzGhMTUZbSlkrTQjbxk7N
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
X-MS-Office365-Filtering-Correlation-Id: 3ad73cb5-096b-45b3-0e28-08de545023f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnRuZkZ2V25SOUpXZ3ZzZHVpeG5oZTRheUlUaU9vM1FBOVFhc3F6bW9WNTdq?=
 =?utf-8?B?Rld0SlFjYjBoQ1JLUXVGcGprK0R4T0FRSUZUenpZbUwrQ3NKQU8wNnk5a2x1?=
 =?utf-8?B?cXFtM1VTa2Jqekk1b0dNMnJac0ZBcXZPcTNMZUFxUmdRRmtCQjJKbHdCNy9X?=
 =?utf-8?B?aXlBMjkyY0FLeXJkSWtRMWdDM2t5YTh4UTMvSld5SlpQRkFlckU5blNid01Z?=
 =?utf-8?B?Z0cwSGVjVWpvTGgzQTZvOGk3eUthUW8raGQ4dTVpaVhZZWlkMGEwTjhxWCsz?=
 =?utf-8?B?cWFrT09nbkkyTjdKOTdsN1RFNk9IdlJmT1NmOCtUbHdvL2IxaWY4ZHJNSEh2?=
 =?utf-8?B?VXNNa1oyZkdZVjNZVFpnUC80VVlydVRjK3lFTDBsdDZrUXdXTzdYbnRvYWwz?=
 =?utf-8?B?eCt2OFd4dHpQekE0Z3lQSkZ0L2MvY2ZmcmlSYXZwQzk4ZDZvREE5cFVKUlhz?=
 =?utf-8?B?clBDZjIvSGUrdkp4NysvYjFYOVh5YnFRUEFQSEtHTzN1eWhMVWFnNHBuUGpa?=
 =?utf-8?B?ZW5zWi9XVWZLYnZaRXVZc1pmREd0RUhhL3V1eGZtcjYyZ2FxWHFPeWRvR29z?=
 =?utf-8?B?RVNCeFk2dW1YZ21Gem9LNkFsQzJwVnE2aVNVcEVyM2lqODJGOUdLdmZ6Y1dI?=
 =?utf-8?B?SCtEWnlWK1kraHExdkVGN1REdDVUUXZjVVhQQ1JBNUs3YUx0MnF1S0xBRVRT?=
 =?utf-8?B?TmhVN05KbDdsZExkQjJZWGJVTnRwZysvL3RBTFJxSUhHdENXMDVDT3cyUFdG?=
 =?utf-8?B?NjNHVGt0aGRrTFZEVW9tci83RGVKdkcrekRpYldwbmNYMnNJaFJBdEhYWTBn?=
 =?utf-8?B?ellNd3p5M2NHOFh6eFQvc3l5a0lFWHMzS1R3TFVzc2M0VDJPVlo4OEFkUW1u?=
 =?utf-8?B?aHNqdVNyNXorWFBSTWhzYUc3QWtCY2M0UVdlK29hdTVSQ0t6V3l5dUxZRFo2?=
 =?utf-8?B?T0tsSEZXSzQ4L3NyUTdSVWRIa0dXRER1UTRFVXdZT1hqWUtPT2RpWWplYnZj?=
 =?utf-8?B?Y0QvSllTdndvUzMzRm1FYk1aYTBmSmhpczYyNFl2cDR4dWo3ZTJ2aFp2UDlW?=
 =?utf-8?B?NEZic1R6YnJDVHVsOVJMS2tZWklDWTlhTlRPK0FxZTJJemZEcTFzWStVUzE0?=
 =?utf-8?B?MFNieThhMEZveW5UaG93WXpYZUVQeEQxOG90Tm9SZDJxdVNGcHdJT3N5NmVw?=
 =?utf-8?B?d29KSjZFN2l6OFFJdlNGYjZNVGdzaFdINWxBd1ZXYjRJMUdsOXRpYzlvRkMz?=
 =?utf-8?B?bXdZWkZWcHl2VXlONjBvZGFQb0JWOU9RcjZ4QUVBZUt3aGdocjU5bWcxVytx?=
 =?utf-8?B?MEVKUHliSzZoM0FqVy95MFU0bW9KQVhPRVZxd09FS2ZoRGNGZTlCTXQyNnMx?=
 =?utf-8?B?elo4TU5lQ09qS3BLdExQUE1ybnpYNXpkQWRycnRuRlJxM1BjUEY1KzUxd2s1?=
 =?utf-8?B?MUNvL3MvTEJlNTB0ODJINWJXWnE1cXRpdmNweWtEMERaVGw1R2Rrb25WTG9F?=
 =?utf-8?B?NlpTV3VWVkxGM1BwSndiTGsyWjlFbUlIc3F4ZkxhU1hUMGlhTkFhYWk5RC9a?=
 =?utf-8?B?eHc2cjIySGJ1TzBxcXJGc0FyeThNL3NPS0taVkYrOXFMd2swRHZjZnJ4dzlv?=
 =?utf-8?B?eE5jU3F6ZFZKWGJnaUdEM1c2SCtmNlZMWHRXREM5UWQ1dWxCaGY3dEpyL1VN?=
 =?utf-8?B?ck10YXlvaFptSzdPWExZSXZDbTdIT0xVR2UvWlpvdUVNZ0krTkFiZlhZZVdk?=
 =?utf-8?B?c25hWVpTSVlYOEJPUUtmS2UzWkpvSkNUeVRBa0dnNmVwOTUvMkRNWWpvU0wz?=
 =?utf-8?B?MmpuLzNsR0VwZ2RSKzR2WG5TZHZLbDRuRnZSdUNFb2NobjRIWFNLamQ3NUcw?=
 =?utf-8?B?RVNqMVRSQkRhT2dZL0R3OU9rWDQ3bk5BaTRVZGJHaEdmWnd6OHpEcGg0S1ZL?=
 =?utf-8?B?Q3lVSGhiS3J6NVk4ZE9yNWp1MFY3TUpoN0ZVR05EVTRsWDFzWVVVbGMzQmlP?=
 =?utf-8?B?UUNDZVhTekRtSG1oSk5iMTBtMGIvTjlITUNibVBoZFdkSVJyWTllQ1dJa25L?=
 =?utf-8?B?dVVuS0pxRmhTU0Q1VWptSDgySEJWNHppdWVzMWtHM1ZoajEzakxHeW9QTTZE?=
 =?utf-8?B?WVJROWwzUG1Zd2dHbEVpSzNQemJ0bEVaVlFIaGtCZVFRZTVPUWgycFFDc2Yw?=
 =?utf-8?Q?JTbbQHdQubgiyw+x6q9V+uI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rmk3RncveEJJNDJpTzFMQk94WGxaUHdmRVRqRyszY0MzUmlGWHcyZUljOUlU?=
 =?utf-8?B?aXlwb1lFVWx1dUM2aS9zTW8ycno0Vzh5bGpxNEdNd2sydU1rREtqaURZalkx?=
 =?utf-8?B?UXZoaUlGOGJzTjFxWHVqSjh1bzlPNHVWV2ZwbmdYVm9qejVycnJmL3EybXJK?=
 =?utf-8?B?WHdDT21pUW5taTVTQ2RORGQ2R01UUm1PZ1h4MGRZSnlJdUwyWnUwaGo5YUhs?=
 =?utf-8?B?SGhmVmVFM1BwM1VHUS84eFBZQ05JVGUrL21nb0ZyVVloSDRiZkVWQU40Y3I5?=
 =?utf-8?B?VXpaakNzb2g3T2l5R2V2bVhqWG1hQlZJd0dJOUV4eVlKUjB1M01rcHRYczNh?=
 =?utf-8?B?Q0IyUFNXcERTczZCU2dsbUpjUTBMb05OSjN1RFFpM3FncHFPWFV0RjZEU2h3?=
 =?utf-8?B?R2t2UkJob09iYTVnbUVCQUdqY3ljb240YWZFdFdGMlVFYTh1NnhnV2Nld1Vi?=
 =?utf-8?B?ODY5Y3J2TmRSVW10QVZYNWtWSUpROTBjRWt5UUlBNGxSc0xtTkRQZ1g2bVFx?=
 =?utf-8?B?V1NBN0FTcFBLajYzekV6cEI2VE9OQ2tnR2VveUVZTERXb3JYQW1QV3NJNTJJ?=
 =?utf-8?B?QThIZThmT25wMFVIWjJDcStLUGttcEJueDNxVU9BbTA3UFdsRk5SZ3hmTXo2?=
 =?utf-8?B?NlRIdlZPcUNPdkFOcC8vZmtuQ1gvREFlRGFsMWtzSXEwQVJ2UHZkZWMzMVZR?=
 =?utf-8?B?R0FNMXFsM3BWUDljbGVic2YvcGdJYktWY0VvVzRyaUdsY2d5TFFjbURLT1p5?=
 =?utf-8?B?RjBySVpJM2ZpRDJtV1lyWmFNR0RGait0TWw1anBVRDhQcmgxQnNMWWtvbTZZ?=
 =?utf-8?B?eEJEUmIzM1lPdVo0eEdvRmF2WVlibis3eXFrSVVzM2ZSb284U21HbS92R01n?=
 =?utf-8?B?NTA1WUZDSE5DYWR2STNnWURiMWhXOVNzbDh4ZGg2K3dKV09yMlZkMy9PMFNQ?=
 =?utf-8?B?bGRPVlBkbEtGekpSakFtdFJaTnBNZVB1WC80YXk2OUJxWUo1Z1ZxbzZ4cGZX?=
 =?utf-8?B?M1ZINWhwRk1EK05qYmdvMEdzK0hyb3hzdmMzUXNnWFR0VW9yRkNQbFJpSkpt?=
 =?utf-8?B?aUxaZHVnZlFreFFRb3MwQ2w4d1ErV292akJVekNZZzdVOGVCVXNIL04vT2JK?=
 =?utf-8?B?dU1aZnlYZXhIRHZMV1VNSWNjYXpjRWVJb3hoZmhzSkJONForQ1QzdVVOUith?=
 =?utf-8?B?Y1VKLzNNelNUYVZrdFdIYjU0dWVnSlIyeDZta2cyRXJPbkZ1c2tvMFliekVK?=
 =?utf-8?B?TzN4S1R0dVVwdldwQnEzaG0xOTAveEJ4V0hFaVBqc0w2K3hZK2tmZnhoTXRu?=
 =?utf-8?B?TzYwU3lFNDdlU3cvQndCclU1alpqWi9KUnBEdEZ5TnNNVTkyM0MyRTFjSmZI?=
 =?utf-8?B?ZkdVcnlXQkcxczQ3OVplUEZieVJYeUJQd0ptaXE4YXk4TTROUllaaysyZkhx?=
 =?utf-8?B?WW5IVDZYRkRaak1FczQxYkE2ZWNWZHNOK1o4eW9NV28rTU83VzY5dC9oditu?=
 =?utf-8?B?aktBQWx2aGRRdFRvMXNTNWZWeGZCVGVtcG96YS9ld3V1VDRDTjBOUzJQYmlI?=
 =?utf-8?B?MlNHNGZnM1ZYU2dUREpVbTA4YUlyMHhRL1U2V2hXVzRlMnNNUXEwcko0Y3dB?=
 =?utf-8?B?dFdZQ29xcEM1NW1uRnhwSEdyQmJ0SHhZd25UNjNzT3FNL3UyY0dBcUltS1BF?=
 =?utf-8?B?NVVKUUNKaE9nZzVqQ0E5cUFncFlFUnNFcUlaSGVueW0yclFrZUhkZEdoVWNk?=
 =?utf-8?B?bnpsTlVUa2M5RDVSOG43VVFQUHBPc05LMGsvOFExNW95Q2VhNTJ2N0tSdTcx?=
 =?utf-8?B?QytEbUV6Qi9ZdDNMVWpOTFZhN3RCTmY0UXBBVng3bVFxYzdETmZ1YjUxYnNl?=
 =?utf-8?B?cjQ4c2p6TkJGdnp2eDZWZk9qVHdLNFRQOGhoRFhUV0FnM1NFZDFDVE9iTUVp?=
 =?utf-8?B?ZGhQdUc4Q3VETGRGSVlLdHJhT2dESWhDQ25qMUlyZDMrd1EyQzZKYnd0azB4?=
 =?utf-8?B?SGpRSi9JT3RTa2dPdjcvRzlKMUU3T09KdjlxOE5EeStpUU1jUVcrQllaZnVi?=
 =?utf-8?B?RUVCZW9JQTNoZGNURU83WksvV1JQNjE1emc0ZC9sS3R3cVkrWjBSMlNHdkNW?=
 =?utf-8?B?UDZPWGYzL3YrZU85aDl6L3RyZDVjN3RYYTdZMTRha3pYNFFrQmFyY2ZGQTE2?=
 =?utf-8?B?dDNUQTRqSVRZaTEzVndXNU1teHVBeDl3d1pKa0dFTVp2SUorV3MwemtFYVVi?=
 =?utf-8?B?WVVqL0RFQVFKTWVqeGpWSHl0aGdvQWYyNTlKSWU0ZUdYNy9Fc3VUZHhmQkZZ?=
 =?utf-8?B?SlV2TXBUeUlGK2RWQWRkbUgzekNQZGxyUGhYdWg5T2QzaC9yOU85Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad73cb5-096b-45b3-0e28-08de545023f9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 16:07:11.2055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yl411TA8/fzHskbtG4fg1kZyXMrKYoR41wajB2k9aBYek2l97SRNNe5NAN6NGObSZ3Iutjb3SJiXPAesc0kESQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12235

Propagate the return value of of_dma_controller_register() in probe()
instead of ignoring it.

Fixes: a580b8c5429a6 ("dmaengine: mxs-dma: add dma support for i.MX23/28")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/mxs-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index cfb9962417ef68e976ae03c3c6f3054dc89bd1e6..53f572b6b6fc62c6cb2496f0da281887f8fc3280 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -824,6 +824,7 @@ static int mxs_dma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(mxs_dma->dma_device.dev,
 			"failed to register controller\n");
+		return ret;
 	}
 
 	dev_info(mxs_dma->dma_device.dev, "initialized\n");

-- 
2.34.1


