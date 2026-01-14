Return-Path: <dmaengine+bounces-8262-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C3CD219D2
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 23:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E129E30AEEE1
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 22:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB813B5307;
	Wed, 14 Jan 2026 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SR1LolIq"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011030.outbound.protection.outlook.com [40.107.130.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0283B52E7;
	Wed, 14 Jan 2026 22:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430086; cv=fail; b=uoSAeaykRP5rK1DRehqqkeHtaAnzOThpmLD1GpPy0YmF6WpHp5trBtQK1R+fgp7Z5j1I2SqcU+T/fWN9TN9Jin4clRNT9mKUn56LnCpv0sDCOx5Ziijdpic5jJWpTxxDbhjhrZx216FCiaMPv7B0gnJvVNwLLZ9vzns3yey1qkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430086; c=relaxed/simple;
	bh=Mfrzo2V67IVQHgN9EPvBkJRZlHDrWUjyU3Zw+QzpNaU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Qio2A4hyozCcp8Gs+qV5VRivxSWl9mKUAusx7BArn7SDnAc6UsmdEyiQLE2SvCpnLcU1Rsh541Bv+ECFGF+TaT3ze3RFDe6+FeSp7r4yPlCDad7aNOoo+1kurpXl8Vdh/h7QeTloopgWUfCgIju9fM9bvJkJf96uCHkc3SlD0h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SR1LolIq; arc=fail smtp.client-ip=40.107.130.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uN7v3x4jlUvHH039Pda7qrN/6vkz0hfTlDrons1R72QiXatO5MvW7xynom6upu0AFHZyU231ZKE02S5KHkA3h3ugxWBsnUjODk7aBIviybxHjD0zHaoH7hSP7mw6YDu77Y1+Ma7VJnkcPbHvR9vTpz/VuF1XcqhL7+lFtYm9O/bk6QwH1eGi8pr1BXr/iNav+FGkX94zHwNujgIrggZjeu07v8x6KgO6BnfQx37DNmv9bOI5rKu4GnWCB7Zf8+cR2zZOcCU7uOqwit4DFxEPnCWUUM/Jlt0GhMEb1pbqJFbc2cHq0UBXZzmS2tCV8voah0AG3Kp09sm1sY3emL3LBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZGvnht0+hVb22RH8M3p8kHrtPUeN9Pc3hEmUr6gpX8=;
 b=s2lhVIb7SvzdkK+Bd5h6TgO2inWoC4j8TkvB3GN+d2UY+KSRTHH9FrKjW45G5adpoIq7UbydSOPREHMoUkscmglG+6ic1vWergj/ez9oHzw+g3KyuGOQAY7GzMk0XGqF19e+5pyJyXtCpQifaRvX4dgbj/C2lkoJMl4SSJmOQ1vcLxKZSSgFesZUKKqhf5nw1Am5x7WR3T8NeMnciXSmCcb+AHsQdf+P1woL4UjEjm81fsJCO1IgZQyqFnhwJJjBPnXRPeewfJ3uG31XlumuxmzSGYnMe0rDv1OLKJBy5KdguZn+j9erj/q1aBXtsKFcYZQQTY8l7Eer8JBuob6HFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZGvnht0+hVb22RH8M3p8kHrtPUeN9Pc3hEmUr6gpX8=;
 b=SR1LolIqIYIUQkCqCPIVKGdeYf8/iV1VQpO4ljEqJxBuAJf4vnAPf8BbqOq3HXUvyAdhwlv76KLC4gLpVkWAAUL5MBxSjFhr0uB4IxYRrCjquHacRsruOMNj+aLrDkXM5bLd73pl7758kv6ZWrA991/SQZ2Iun7+4CbRjfXs6l4VmBTzWjV6Jg0Hw4v0S2VUV/K2cCFAzZf+MvrHDLqT/mViXgWeZHrvFDOL+vhYiXmrsK6UjGd/u2pJA4Zapp1KiuZc0DCz9ZvGJM0FJZA3m3+oFPQRB8KJObHPrjC+fUk7HHVYyJhYH9Ummm2dWvrJp9GlUxZTsoNgC25Ikb+6TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 22:34:11 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Wed, 14 Jan 2026
 22:34:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 14 Jan 2026 17:33:20 -0500
Subject: [PATCH 08/13] dmaengine: fsl-edma: Use managed API
 dmaenginem_async_device_register()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mxsdma-module-v1-8-9b2a9eaa4226@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768430015; l=1712;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Mfrzo2V67IVQHgN9EPvBkJRZlHDrWUjyU3Zw+QzpNaU=;
 b=uwVknkcBAqGOFal8q0481z+aVusD17cuQi1EOwg3x3VTAba9LT7FK1hHYL1ELEtlprtWRDQMj
 38awpTh4sm+BGSIm+FL1+MPOh+oTS0M/No6B4MGNqTKTTxRyGX7/nWV
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
X-MS-Office365-Filtering-Correlation-Id: f5092160-c9eb-4174-db1b-08de53bd09bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bytHeE5USVVDUEZHYllUalpyNHZGMktPMzF5OG9zdWUwQk0zQnNyKzI5Z0ty?=
 =?utf-8?B?ZE1Yb3pkRzRKemVoTlUvV2VRNGxMYnZsR21nOUc2MVFDSXI4OUUzVmZLTEh5?=
 =?utf-8?B?U3ZPMlEybXZQSDRZMFBDRjBTcU9kb1RrN3FwOVVzZzlTc3VLSDU3MFpheW1q?=
 =?utf-8?B?ZVhKWnBWSWlJZTQ5d1orSzl0UVdHOEk3OFRRWGljWnVSbTVLY1hqN3gyTXJ4?=
 =?utf-8?B?dDlFRFR5bHdnYnpRZGJveFI5ZnNyN3hRM04yaTJxaGRxMXpURVYzS1BnaTh1?=
 =?utf-8?B?cDFNMGxDY3RxdDRmMElJV1Vib1J4THhzODUzc3VIaHlLK2c2R3Y2V1UxRFRJ?=
 =?utf-8?B?L1Z3OEorT3dFOXNsc1dycUdEZUU4cnVWTGU2T3JXR3B0M3lUYnNNNTNkazdI?=
 =?utf-8?B?ei9BWVBzMFlxdW10WVBIWEk0UXhoa0c3TCtiUmJTSWVBRWFVbm1lVHRlQTYr?=
 =?utf-8?B?c0U5NVNJK3F1MnkySTc0bHI0U05DSk5UaUZ5K0tyNmhoc0lLdW5sdkdhbCt3?=
 =?utf-8?B?VitvTGNLdXJFRjZuVWFtRHhSdGFFUWFyVDRCRDZmVnNtYkZ1eVJCa25UR1NU?=
 =?utf-8?B?bzJMSU8xelJRdENuY0M4Szd1M3UxeHo2UmREdkFEd2JnaHB5Rjg5blFXNnVN?=
 =?utf-8?B?UkJzMHBLZkY3akwrZUs1QzRvR1BQQW94T0pFSjA1djRrWXZrUlgyR0VMamRI?=
 =?utf-8?B?bS9HSVQ4aUxYLzVlZVJtaGU5Uk5sQXpRai9VS3pETjErZHA1TGQ2aUZwWHhj?=
 =?utf-8?B?RGJUd3FNQk5xU2tGd2ZBbG9NZmd1ZFVPcFloZ3Q2UXVQRWtOSDVVeXNtVENL?=
 =?utf-8?B?S2J6b0J1eUpYSFRkOWx4TjIrN3lrNFlNR3BiQTJiQWFlWmQrVlAySkI1N1NG?=
 =?utf-8?B?SHNSVGhaclhSb0dpeVlBQUd0WHlDQkZ5TC9EaWU1NmQzN3FjMjhaQ1RPWHRY?=
 =?utf-8?B?MzMxcWVjR010ZVV3b2ZSOExkbjN0Tk1GMHdXZko2ZnlMSE4yMHROd2dab2xm?=
 =?utf-8?B?aUVMYUFqS05ySTRreXVxbXZXZ3ZtMFc2UTlEMjJXRUI3VVdEaTUxaWJ3RjlY?=
 =?utf-8?B?VWMvc0tkNXJ4NGljNE0wcStzY0lvdS9HalBRM3FLdzR0U1VlYXRLdFFuSGZY?=
 =?utf-8?B?UzhJZ3hCeURQUG9Za3Q1dHNWeTdXbEdZaDRGNm53TGpMcnBUeW54anMzd1Ri?=
 =?utf-8?B?YWxNVVNkTnI1RW1ncmY0YXhRdnAvVGRQKzk2SHhOY3NVb0Y4cDBZZHpiY2dF?=
 =?utf-8?B?L3ZIdnF2YTJOTzlZR1JxVTVXM2N4SkZ0MkZDYXkwcklUOFNGSERYQURhV0RB?=
 =?utf-8?B?TW9wbXFPZmdtZ1gzZzF4bWRNcnNTZUtTSnNyVnBNaHZ3TUlOYWNucnlFb0hE?=
 =?utf-8?B?d2pHTkdFTXpIUWk3eVg3a2QxZXhFMzJ6ZFlSdjJTckF2bGo5U2xOUVJERC9n?=
 =?utf-8?B?WjRWYXFCdUlNZW1DQ2VjZUlVc2RZWm15elQ3eW4rZ2JzUExGMUhUR0QwWDZV?=
 =?utf-8?B?TURqOTA2Rm95dnNsWktPQlpiZW0vb0Z1a0g3dW9nYlE4QWNBVE1iek4zYXdv?=
 =?utf-8?B?aUk5NStqUWFHVldxaTFqUDhEZHlsNzd2Y0FucFo2dEM1Q1RtZnEyMmFWNU90?=
 =?utf-8?B?eTBYZlk5cEpPVFBMZitCSlhpN3JEZVB6M2gzNDY0UFFqb3R4NEpFTFJmR00v?=
 =?utf-8?B?TWt1MkZWUjZSNDQ2MHVTVUFGY0doWDczTkMzWnE1N295Z2pYNExWMlhHSHNI?=
 =?utf-8?B?MFA2M3dCYktBeE1VU3QyS3VmSmRPU3JNVi94Y2hzM3VQRWdqV1BrUU41MWVw?=
 =?utf-8?B?MnpWYWhSYUY5TlNZQ0FHeFlYNVBiVWd1TDhVOVhmNndjOXZSSUY5NStUNDZ0?=
 =?utf-8?B?T09HQi9WWkd2OG50SDdrM01IMzlIREtETkVUY1E1K21xd1pWa09weVBweERy?=
 =?utf-8?B?Q1hKVWRTVGlGak1tYjhSRUxLRGhPb0JIaUhxOHU2Wm44bUM4Rm5wMHowRVp0?=
 =?utf-8?B?QTczbkpHSGpqUHkwYXo0TXZseVZldVZhNld2VTNxcysyZDM1M3d4QzZ1QkZq?=
 =?utf-8?B?L3RKWm4rSm0rYWdraGlCZFViWWtyYUxQaEs1aVRSVkhZZlBOVU1hbDlUbWdS?=
 =?utf-8?B?YkdEOXFGSGZxZTUwZHlXbzVCVGlKSU5oSzlhQkJuYUk4RDAyZURQOXFKQ1ZR?=
 =?utf-8?Q?cnlrg9RQ6oCzRB0ANpDApeE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkxhVllmTlIrTEE0Y2daK1c3VldqOTFmMnYrcU5JQmhUUE1vVjA3Q1NzRGta?=
 =?utf-8?B?Njlta0V6VzdUMjdFY3VGbGxMVW5TYlFFWWVZaGVEOFl5dHU3MGlHaktrWHRQ?=
 =?utf-8?B?RHJDdno1NXY4OGV4cnhBcnpWbldndldJNWM5OW9ydVhtUUhEeGlLM1lBVlBW?=
 =?utf-8?B?Tmt1ZmQ1UndFVHlqQmRuS3dGcWVudTFOMEY0S3BHS2xUdWQwQW5qSUpjQ2dU?=
 =?utf-8?B?SlZpaEdIb2xwbHYzd2l4dTNWYTNuSXV3MWRYV0NQczZvcUtrQ256K2crQi9z?=
 =?utf-8?B?eU5XU2NXMFYzNnByRHFmd0ZoRW83QUIzUHFYcmhiMlh3SnY0MnNxTllFTGtz?=
 =?utf-8?B?MEkwUitTM0drMzlwRlc1ZXhWUy9BbFZqMFZhYVUxUVg5eCtUTUhGVG1tb2sv?=
 =?utf-8?B?WFBaUmJMUHRJVTdQVGQwZTZZdGtwQ0VURnJJa0ZWbDBGYjNTRVdKV3FCQ3V6?=
 =?utf-8?B?Z3pKb3ptdG0xZlRTTDZOUkI2c0d4bStmc1RYS1FuSnlVZUNOK1JsNmNENzJC?=
 =?utf-8?B?TUR2aGNqVXZhMWdCTGZSeTArdFFzTmJhOHBrbEhoY0p2WkpVTGRWVUdKQzZJ?=
 =?utf-8?B?R2pVcHFtTGVXdDhQVzV6UFVLUlYwQzV1VFlEU2ZuMms1UTgzOXBZV0NkY3V5?=
 =?utf-8?B?aksrTGYzS3kxcWtXTUlBOEZ3MEhNTlNtdXFsbHF6M05Oc015dkVPdjZWQzNT?=
 =?utf-8?B?aUMycG5zRDk1RHZGbWRJNVZWNHdydjVCY0JldWcvdEtjYWZhbmJMSmNLd0x0?=
 =?utf-8?B?QXFnMjFUVUlTanliaGsxUU5GTjBtbXpPZmQ5MjhNYmtVTnArQXVONnZ1OW5o?=
 =?utf-8?B?SW05cUxFemdsZ2NJOTVnV3pDNnR5V0NJNjVOek5UeGtzaG5kcE9TclA4RjJX?=
 =?utf-8?B?TG1mZHh4Ukd0QmRiVnE4bzRKVnN1aWpZMkpWbWx0TXEySFh0TzJBSHhaWVhY?=
 =?utf-8?B?U3IrYWs1dEtTTkdMWmpWOExUaGhiUXowcHVyaUpPM2x0R3FzamZjWDIwQkNl?=
 =?utf-8?B?dWJBMUt0MjlWdEVKNWJoZkFYWGVRdE00SUtaUkNYYVYySUFud1hwNVdCM295?=
 =?utf-8?B?L0o4TENtR2RHeFNySUxuNys2NE5IUzZOckgydXBiL1hQZTMzbTdBMXpWYXBY?=
 =?utf-8?B?Z0JITlU3MVErZUtualBoY1NxbE9ITE5pMXpSKzYwVGhGYkduTHorM1RrM0h5?=
 =?utf-8?B?eHJ1YjVMR05nMnpBMDNjV3pHVzk5QW5CbFZpSUl5SW1SUXIrcXAwMFlac3ND?=
 =?utf-8?B?RWRXN2lHS2tUUkc4N2VaMlB6aUhiWUc4MlBMa1pHS2dxYzR0TVpwTC84aDNL?=
 =?utf-8?B?REY0K3V0dGdBTU1jY3ZnZEd0Y3hFd2xVNGhSZ00vWWZRc1lnTWRxY05TUm5E?=
 =?utf-8?B?NXRTR3B0YlNyampXcUZrWnRBZisya0dmblJnY0wrUHFuZ0wzeE9BbGdEOEJQ?=
 =?utf-8?B?SU9DeUJQck1NQjlkeklnS0FvNk9mOWdyY0UvUHdjODVQcHBud2NjUEs3RFBi?=
 =?utf-8?B?dlllTFVrV1NxOUJDczc2QXF4b0FLYldBWWhGZFRnVFZiNUx0SGRiQVVHN1dW?=
 =?utf-8?B?WWNGZVFMSkZoUHJZd3lTaFZyeTRMSk5OaE5nNXFUczIxOG44SzNvcExROHlO?=
 =?utf-8?B?VFlVbXZPWGJiN0pCT3NCaWh2TTFadkhhWkVnMnloZ1d3aUxUQXQ0aW5iUGpX?=
 =?utf-8?B?TDlPY2Z5aEVrd3lpdDFPM3B5N2dpNVZvYWE1am8wSlV3b2NzWDUrVVZyN0RL?=
 =?utf-8?B?Qms2dFRvZktudjloaTZRWm5JZnROSXc1WDZYejhVbEtreHMrL1lndzNNUktt?=
 =?utf-8?B?cS95TW1Vakl3bFgzRndJMzA1Z3dSL1JXK2pHbGJCRlFDZGNuZFc0TVhlMnlJ?=
 =?utf-8?B?RDBMY2ZVUTBSWWxHeklJenA5SXpiZWZYOXpsWXc0YnJNTCsyczNoV28ydjBD?=
 =?utf-8?B?ZVRBZnYwcHRwc090R3cwZE91VGFOVURQMDJQMW5ZTlpleGpNeE51V1hVQlRE?=
 =?utf-8?B?UGNVZEp3bC82empjMWNjWjltbmZ0RVR0NlJhTVJvaUpBRU5Ja2lxSGpzTEZq?=
 =?utf-8?B?WkN0eHpQZlljamdjbHNNNkFWNDFZQTRSN2lxWHlKbURPVjR6ZWkzaXpjQmY1?=
 =?utf-8?B?bjNSVit6M1YvT0g1ZDdtdnp1QWYvOEZsQi8zUzZtZmVqVkhWSFdUTXAzb1ZY?=
 =?utf-8?B?ZldMbWxHc2ljb3UxZ2xBa2Zkd0lvdnpENThYZkltYmFmbTl2S0VXbkxXcXNL?=
 =?utf-8?B?UVV4YXNkYjE2YmNyL0wzdStDQzdWMDFlZ0lndTlwN2NtREN4Z08xSUJzbzgy?=
 =?utf-8?B?WVBiQ3VXTTBOUkJmQ2lEanVjMHJhRU9CajJMZXEzcDZ1RWFIQnZsZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5092160-c9eb-4174-db1b-08de53bd09bd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 22:34:11.3482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLTtrwxec0IBlWSJ5mknpoSn0jOWLWeXzNmLNgBuEOuMS+HX8qIWzbw3mUlXo4be/N3FnuQpUvqnqP8PHhqe4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

Use managed API dmaenginem_async_device_register() and
devm_of_dma_controller_register() to simple code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index a753b7cbfa7a3369d17314bc5bc9139c9f8e5c27..c0305fd2ec06c41dfa8396bad6bfc225fd3861f0 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -882,20 +882,19 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, fsl_edma);
 
-	ret = dma_async_device_register(&fsl_edma->dma_dev);
+	ret = dmaenginem_async_device_register(&fsl_edma->dma_dev);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA engine. (%d)\n", ret);
 		return ret;
 	}
 
-	ret = of_dma_controller_register(np,
+	ret = devm_of_dma_controller_register(&pdev->dev, np,
 			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
 			fsl_edma);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
-		dma_async_device_unregister(&fsl_edma->dma_dev);
 		return ret;
 	}
 
@@ -908,12 +907,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 static void fsl_edma_remove(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
 
 	fsl_edma_irq_exit(pdev, fsl_edma);
-	of_dma_controller_free(np);
-	dma_async_device_unregister(&fsl_edma->dma_dev);
 	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 	fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 }

-- 
2.34.1


