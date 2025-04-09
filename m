Return-Path: <dmaengine+bounces-4863-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5B2A82157
	for <lists+dmaengine@lfdr.de>; Wed,  9 Apr 2025 11:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106C71896A26
	for <lists+dmaengine@lfdr.de>; Wed,  9 Apr 2025 09:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A6325D211;
	Wed,  9 Apr 2025 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VPl2DgCR"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1A125C70B;
	Wed,  9 Apr 2025 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744192286; cv=fail; b=T0YcSAPqbXqioohiM2Qo2YyT4Vh4a70zoT3nlG1sYHi0zX0RS+5qtnDnniUNfBbugQsc5cCvIZvASlI4IMrSWZEGW3x8w5Kre3xj1Hzcw4XMKIW/01CXw7UEt+Yr8sOweJFUJP3g4Co2PJ2z/rwq4725QwA6t2YmEmXitmY45Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744192286; c=relaxed/simple;
	bh=vNztbsWclpkMdFwf8dpcl6pkZUFZy8h1nkorWySa1K8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V2/XJ/+Hj7RRSoOe9x7pxNJ6FgCvuBJC6XlgVvTSLOXLDhkPMr2VwUyU4B3UB7zsfPsTfREdcf0BwmDdYzl/NjF7DypBm3RWnJCdKSELelW8jsKjunqlHJqUPWwZRSacdSP6/6keTkO4web5h64Zn0NARXOvFdpKyHZCVjVdi7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VPl2DgCR; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1wf5tAgNqSFgHpaxc4lF+US2AjC68MaST3fBJRXHscN5jNzCWaxjR/j5mwQRPGjd8JS5Ybzp+gdz+DB7X+9LLAvhlK2OmLJSm7RlMB0pxLEKRoJB4vG75UG9bP0EaPQTbXlQNbSKF+qv++C8Jq2bE7twTi6GqqYAg9Alj8vaXLpY9x09HpVOAyOXJEikdOW36FdLKzf4Bi+LwvNyXs+5TV0hr70u6oMfLZbCD8gDh8FlJxolMSXKqk0HWN3dloP7pWhNnjRv5gHsj0UjNbjU2fk8iZhZrSIMXfupMUB4erbCmiSt5e/w40Z40v1zen2P6iHX9bfUEpQhmuZxC9qeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNztbsWclpkMdFwf8dpcl6pkZUFZy8h1nkorWySa1K8=;
 b=EFO8GSxZJeqnS0dU88ZfI7gAO3r/9Q5NMFcjfvf+zyHTIPMU3RQZgJJknlwYL8EQ1+b54UNpygFY6M4CBFLNmjT5cfI4VMG/Dx9Zl5wXO2ywCWzhR1Q/UgvUlqAqWgR4XMtf8EOrsPXGPAlldTY4lV1KLSQwXThNJCL1D0tElEUoI5bvVTFT0HoYeHFtMiejlMMOqlemFdkotgQ4dEQPnDnYAZ1k22Z3YtNXPykWqh238sJEb8fP+zsHi98+dZwgP5PNqtPA4/gasLcdFzeWbtXDmxX9BslKn4HMeQerIWkXXc/oowc2LLV92qbXInMIsHrVfbb9Kl2LgJSxufInDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNztbsWclpkMdFwf8dpcl6pkZUFZy8h1nkorWySa1K8=;
 b=VPl2DgCRqk60YWnjQYtl6pqb2H4l+qPetGaTAqWFx8hi+UfTGeMmm8lk9qFk/HPlqIEZrsGcOybwy7H9UoJ/eIuJ7X1ZeFmKAgyiH9CnAn8WWsFaHIeWLDoQNO3Jzm92zWmjOhsAMiSg971SnhEfFUugNbvCo3Pyhk4VAoi2YgULQgo2QRHhbEbDehsDkZwlyf1A21BltevEmtJzGLfczX/Y5Zu1tKNRzLKyUKtw2dbaVxcQbiORWtmCsFFJZMv8BqgB7P5MtBwjHxkAjKi/cbleHo90kUJVpBx8mE1tjPqwzQ4Fq+I2j8SHEMXYnMIAsmivX8jSiRBOOye5+s5w1Q==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by VI0PR04MB10591.eurprd04.prod.outlook.com (2603:10a6:800:25b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 09:51:20 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8583.041; Wed, 9 Apr 2025
 09:51:20 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>, Peng Fan <peng.fan@nxp.com>, Frank Li
	<frank.li@nxp.com>, Joy Zou <joy.zou@nxp.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, linux-serial
	<linux-serial@vger.kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, Christoph
 Stoidner <c.stoidner@phytec.de>
Subject: RE: fsl_lpuart: imx93: Rare dataloss during DMA receive
Thread-Topic: fsl_lpuart: imx93: Rare dataloss during DMA receive
Thread-Index: AQHbqSgXmF0lJ7q5rkuUhpKjo5mhwbObEITw
Date: Wed, 9 Apr 2025 09:51:20 +0000
Message-ID:
 <DB9PR04MB84299ACCDAFE6427B30699F592B42@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <a9263ccf-2873-46e4-8aee-25e0de89a611@gmx.net>
In-Reply-To: <a9263ccf-2873-46e4-8aee-25e0de89a611@gmx.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|VI0PR04MB10591:EE_
x-ms-office365-filtering-correlation-id: 379a5782-9dfc-44b4-ad0e-08dd774c1489
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YUJDb1NmbWNxcXNUU0piN01sbjdnRXV3NDdHTDZyRmJDblFhLzF5Mm9nWTF0?=
 =?utf-8?B?cDkwS24zNWhDZEllQURhRjNqN2xVZWVrVmF4WE1XTHJiNWFTUjVBSVJpR21R?=
 =?utf-8?B?b1hQNlFtS25KbzI1c1V4b0hUbm1WeHBjUkV4VFc0bHcxWkVuYnB3TkRNaGEw?=
 =?utf-8?B?L2I3ZStiKzJJT1dHVWMvM2hYUStSL1JZSERNOThzelM3WmdyYkJwYklKNTNx?=
 =?utf-8?B?TmhtU2pEWmY3dm9qUmpoSHlPYTE1STdTMUJIeTh1TFNlMDVwZERXbU15bWF0?=
 =?utf-8?B?WGRXUG1KUElFaVQxRjFzVEd4bjVYZDBxL1MwM2RpcWYrQWlHUWFpblBtRTMy?=
 =?utf-8?B?WVFQdjhMTUVqTnJWdXlGSWNMZTRabzlvbGNKWGpLM0RWM3VWb25YTEh5ODFD?=
 =?utf-8?B?WHJFcjc0N0RqUG5aN21iRkFLMFU0WHIvNVE0WUwvYkNadlpWWm1TaThIR2Va?=
 =?utf-8?B?ZnQ1MW1yU0hsemQxSCtBM2J4NXlHTmdNejJiUUhZZXM0YVUwdmg2ZTZ3cjhB?=
 =?utf-8?B?dWFId1JzVFpYVjRLbnRqbHd6Nm9NWTBMZEJOdHgzY2Zad1ovNXIrc2hDWVhQ?=
 =?utf-8?B?MlplZ1FZcmpnaEd1TTZCWWZDWElmUm52U3lKK2tncDRSblVpT2U2TW9vdGEv?=
 =?utf-8?B?b25QWm1CeXZ6dm94a1VYSUptdko2V2Q0WFhNMlQvaDVaZXE3MGRHcmVXdGRX?=
 =?utf-8?B?elBHRUpybXUwaVQ5UXd2QXkxU3dDbGkzaFpUam1CTmM0ZE5tZ1lXUGVQYzZN?=
 =?utf-8?B?MmhUSEZpNlIxcmtlVXQ0SEZ6WGk1aVByQ090RmEyTjZwMkYwaXV3RjRJZEhn?=
 =?utf-8?B?ZjN1WHlIUCtZcHdKdUg0M01LdlB1R2dOZ2l5Y084a1ZhTitsaVVGaXRFbi8x?=
 =?utf-8?B?S2xOTWtHSm94cDByZUY0bW02bEREcmJGeHUyMGl5djdvS2hPR29qT2pMZEQz?=
 =?utf-8?B?RVUwcktIUWhwMStIaWRPVzVrMGNpYnNpQkYyVWpjR3pNVmQrdVpLejdXMVFo?=
 =?utf-8?B?VFZHWi9ER2xMU2pqb0FETkdFYzVMWmZtTERjSjZ2eFBRektvQ0tSamNYd1VG?=
 =?utf-8?B?djgwdlpGUnNLcitqYkJBTEY5QjB0Nk5jQ2krN0MxOVJ6N1BSVytPRGUxOFVV?=
 =?utf-8?B?NTdMODN3bmxGODBLRUhjSW1WMFYxb0JKdURsTzV2c0VCcXdZRDlqZ1BKSzl1?=
 =?utf-8?B?QzcrY2FFbEJmTXBYakNxU0FMRi9EMjZjWGRXQnVuSnZyZklHVHh6WDBzRUs3?=
 =?utf-8?B?VGdXTFlJbEwxTHY2cytSMzBIKy9JeUFyVGkxcXJYUEFud01IeXJGZjFkY2tM?=
 =?utf-8?B?a3BydktYNTMySDcrY0dRQnI0UjBXSHFFZjhaMnZISFNxUXFmUytnb2phaDlW?=
 =?utf-8?B?YVEvTlR0UWtKYjF5am5kdENYSzlGakwrcG0wdW14bHZXLy92T1ZVZ2l6SHN1?=
 =?utf-8?B?bDZaYWgyVTdaK2V5UnQyMEs1VTNKcEE4RFpHczlYOWdUckgxanlDOWVIMlhi?=
 =?utf-8?B?VDhTbFpzYkl5amtyY3lRblVSZU5wS1NFOVcvVGVPVGtEb1VheWJtYk04UVYz?=
 =?utf-8?B?bU9lb3NFcjNWWmhEN0tyY2x1MGFtV3NUMlEwRU9HYUNORTJnZ1dra3pFUHds?=
 =?utf-8?B?TmhScWdOVzNFTFBQMW5ITHdEOFZrUTRwZGd5OHIzWXJ5UnlNUlBqZnh0cHdw?=
 =?utf-8?B?aE54cDZhK3hxcExsY3d5UExuckJXTnlFTXR6dit5cEZpblJUMlViYzhIcFFo?=
 =?utf-8?B?QjdtVG1WNEgwTmpTZll5UFlNMktDQVZIZjhjdjBObVFUZWQxQndlb1ZIN0VF?=
 =?utf-8?B?Yk5sWlVLR0o4eFl2ZXlmdmZsYmlnQ0pTT3lzZ2pJSHZPbUtsZ0VFaldyc1BT?=
 =?utf-8?B?Y1AwbmhmblBpUmt3UVNlNk1LdUdqNUU5YTZjVWtLeW5UdUZva21SWFpSZ042?=
 =?utf-8?B?blFDVWxTV3BlanI1dDlGNDVPc0doQ0VTU0RjRXdPellSZDVQS3pmeU15cDlO?=
 =?utf-8?Q?5eEVR+l+EM1dKAUarE2T3EVyPS6FR4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RklETE8yQ3hRK2tMd0ZzYkJhNjZNUGhRYitudDFuVENGMVJoQ2g1WmVkUTd3?=
 =?utf-8?B?bkU4VlRRUjNvLzZzYVNHSFhqRSt5UklHcWdtK1RRWTV5a3R0VlZWRmExTlJR?=
 =?utf-8?B?cnRMOFpzcmw5S2tQN2pUVnVBY1R5b2dPT3pGOEZqWk9LVHZCZG5aNVo4SzFh?=
 =?utf-8?B?RlJWSCtMaFJSeUNRbXdYemkwWnBGTzV4cVo1SG9SSmtEeUZ6b3RFU2dxUGp4?=
 =?utf-8?B?ZGk5VmNYTVpyUFJaRHRnZUcxWFZNM2Y2UXBuQzlsbm1GSlVRRGFiTjdDWWFV?=
 =?utf-8?B?MzJFZEVUcXRydjlDajROZjZ5MStpeEZNdFpJT3BZUTBzQ3VJaFE3aEo1ZlNw?=
 =?utf-8?B?eWFtM3FWUlUwM21BUVUzNzUrZWNuRkozQ2VKbERLbndIY21Sa3ZtL1ZwZFAv?=
 =?utf-8?B?NDAxbWJoWC9DTzZNWEc0blBHOEtiWGVnaTJiQyt2YlNPYmlZYXRxdTZLYUNu?=
 =?utf-8?B?Q25MSXlOekRuWTFRWTV5K3BVdk4vMnR4aENQajFUQmpHQmpDVGQyYkh4aGdV?=
 =?utf-8?B?bFliMDd1aHpqZVkrd1hhSEpUSUphRU9ud3pxWmErSzBvaUhJS3N4ek9mbnVi?=
 =?utf-8?B?YkFuTWZ1NlRtQ1hrSk1DWkxkZmNoSkJVNFJnb0VBY0lGTVFnSE96bGdkZ2xy?=
 =?utf-8?B?Z1ExSUxNWVlDZmFpSmc5STMvU2pEbWJNcXV4Nzl5Vlh6TElyNVhoeXdSVFBE?=
 =?utf-8?B?bVJ5WGxpNTJIcTVTSThRWXZHZkVySFY1dzBDdzVpbmlMRTR0dHZLa3lvaU8z?=
 =?utf-8?B?UGNVL0hleDJVSEc4VVJXaVNqVkZUTWZUMlhmZzJRYzJFVG1Sc2YrMlZZa3NK?=
 =?utf-8?B?b1padDBKeGliMWRhL011aTVrWWo3RjlmN1VTSGgvTEpzSFdrVTVvdnF4MjdG?=
 =?utf-8?B?ZXk0YXRNdTNFY2x0WXVkWngvbFZZOHlpdXhUcmNSYVZVSjk3ckFVMWhLVC9C?=
 =?utf-8?B?cVhkbEp0TUhvbHJxV0N2VEM1THJkelZzRVNVZzhxbkxzLzVBWUhONkxEKzIr?=
 =?utf-8?B?RDZzQzRKV3FtY3I2Nm9tMXRTTWZSNzFFODJBdzlrTnJnMXZ2NHRMdGg2OGpI?=
 =?utf-8?B?S1d3MnYvR203WlFBN09oSEx1ZUFhV3p5RnpvMktMTGNDUkR4RmdtY0ZhRHht?=
 =?utf-8?B?OHNVcjk1bHJQOXlubjBLRmFxSGczVmRGVERTbGNjZWpGcGFTNUFGam5YUnlu?=
 =?utf-8?B?WjNtaDFMNWhGd2lKNzNaS1hwVGpiQ05HTlBLSmtIaHpIRGZXdzhKb1BnWkd0?=
 =?utf-8?B?VzZOeURJckZsbE9rc2ptdWhxR2drcVl0TVg3TWc2RUViS2JVT3BsalFWNE9z?=
 =?utf-8?B?eU81N0hqczdiN0dnVUFZNndkcGhuaVB4aWJsTEcvMko0MXkvUTlXSkNPbm9h?=
 =?utf-8?B?VjE1WlVoeFd6V2ZWNHcySkxTS0VWRkJnQjduL3JXTERKQnFnNVg3M2NJUEJC?=
 =?utf-8?B?K2wrSDdhaEJlZ3VtNytLYjdFS0FuZnAvbEJOT1VaWDRKSHYrOTMwTWlxcitD?=
 =?utf-8?B?UDFLRXU2dWNpUVNUdUg5TmNBemRYeVpoZHJwUzAySkozVTlNMEQvcVNObmdq?=
 =?utf-8?B?WVJEUDEra0Y0Y1JBMjJ3VHlBblk4R0lDc0h5SGJVZjFjM1FVVkFIUjZiejQv?=
 =?utf-8?B?aXZ5V0doUlVQTnlmY2hobEpWTTF0OEFlbzBsR001VjJYZHFaVTEwYWlGY1kx?=
 =?utf-8?B?dU5TK0dpMGJZaWk2ZTFEWEhEZ21jalZhQjFnWk45K0E5NTkxOUVrY0NLeGtB?=
 =?utf-8?B?a3RWRFMvdVB0SDk3VWVTSTlRT3FyOER6emJFekU5RHZ1cDNrNTJDWFh4Y3Nk?=
 =?utf-8?B?QVg1Y3lUV05tVUhwdEhZZHVYS1J2eVZhUU5adnNiS21yMHpqVVoyZEZaSGF1?=
 =?utf-8?B?bVVDT3VPQUpOSDFpUjJxeERVQk5JaStSYmJKemMvejdmN3plY1FoRjA5SFRI?=
 =?utf-8?B?Uk9rcjUzUjQyS1dGb0hYN21mUnN6bktlbnc0RzUydzVXdzdSZzgvOVpPQlhR?=
 =?utf-8?B?Zm81TGZqbTZ1Rnh5ZTQ1WnduYklNemF2SWYvTkVXaHZZalVwY2tyVTNOQnJx?=
 =?utf-8?B?Rmw1S3FSNTlwZ0Q0SndleXZhRnVQN1YvOExkN0N2TjZpc1owZXdZYnlHQTk5?=
 =?utf-8?Q?neyM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379a5782-9dfc-44b4-ad0e-08dd774c1489
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 09:51:20.2085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0r0W5CzvNz199+YRecZGBS37VbIk3wlOgLxNgCQXX5FZba34A5Ffqlbmrs0/+TW3/Mckrcsnsl8rYZRPvKN7Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10591

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlZmFuIFdhaHJlbiA8
d2FocmVuc3RAZ214Lm5ldD4NCj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCA5LCAyMDI1IDQ6MTkg
UE0NCj4gVG86IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT47IFBlbmcgRmFuIDxwZW5n
LmZhbkBueHAuY29tPjsNCj4gRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+DQo+IENjOiBpbXhA
bGlzdHMubGludXguZGV2OyBsaW51eC1zZXJpYWwgPGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5v
cmc+Ow0KPiBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZh
bUBnbWFpbC5jb20+Ow0KPiBDaHJpc3RvcGggU3RvaWRuZXIgPGMuc3RvaWRuZXJAcGh5dGVjLmRl
Pg0KPiBTdWJqZWN0OiBmc2xfbHB1YXJ0OiBpbXg5MzogUmFyZSBkYXRhbG9zcyBkdXJpbmcgRE1B
IHJlY2VpdmUNCj4gDQo+IEhpLA0KPiANCj4gd2UgaGF2ZSBhIGN1c3RvbSBpLk1YOTMgYm9hcmQg
YW5kIG9uIHRoaXMgYm9hcmQgdGhlIGkuTVg5M8KgKEExIHN0ZXBwaW5nKSBpcw0KPiBjb25uZWN0
ZWQgdmlhIExQVUFSVDMgdG8gYW5vdGhlciBNQ1UuIEJvdGggcHJvY2Vzc29ycyBjb21tdW5pY2F0
ZSB2aWEgYQ0KPiBzbWFsbCBwcm90b2NvbCAocmVxdWVzdC9yZXNwb25zZSBhcmUgc21hbGxlciB0
aGFuIDE2IGJ5dGVzKSBhdCAxMTUyMDAgYmF1ZA0KPiAobm8gcGFyaXR5LCBubyBoYXJkd2FyZSBm
bG93IGNvbnRyb2wpLiBUaGUgaS5NWDkzIGlzIHRoZSBpbml0aWF0b3IgYW5kIHRoZSBvdGhlcg0K
PiBNQ1UgaXMgdGhlIHJlc3BvbmRlci4NCj4gDQo+IFNvIHdlIG5vdGljZWQgdmlhIGxvZ2ljIGFu
YWx5emVyIHRoYXQgdGhlIGkuTVg5MyBzb21ldGltZXMgZG9lc24ndCByZWNlaXZlDQo+IHRoZSBj
b21wbGV0ZSByZXNwb25zZSAobm8gZnJhbWluZyBpc3N1ZXMpLiBJbiBvdXIgc2V0dXAgaXQgdXN1
YWxseSB0YWtlcyAxIG9yIDINCj4gbWludXRlcyB0byByZXByb2R1Y2UgdGhpcyBpc3N1ZS4gSW50
ZXJlc3RpbmdseSB0aGlzIGlzc3VlIGlzIG5vdCByZXByb2R1Y2libGUsIGlmDQo+IHdlIGRpc2Fi
bGUgRE1BIGFuZCBvcGVyYXRlIHZpYSBJUlEuDQo+IA0KPiBUaGUgaXNzdWUgaXMgc3RpbGwgcmVw
cm9kdWNpYmxlLCBpZiB3ZSBkaXNhYmxlIGFsbCBvdGhlciBETUEgY2hhbm5lbCBleGNlcHQgdGhl
DQo+IG9uZXMgZm9yIExQVUFSVDMuDQo+IA0KPiBXZSB0ZXN0ZWQgd2l0aCBMaW51eCBNYWlubGlu
ZSA2LjE0IGFuZCBMaW51eCBOWFAgNi42LjIzLCBpbiBib3RoIGNhc2VzIHRoZQ0KPiBpc3N1ZSB3
YXMgYWxzbyByZXByb2R1Y2libGUuIFdlIGRlYnVnZ2VkIHRoZSByZWxldmFudCBkcml2ZXJzIGFu
ZCBub3RpY2VkDQo+IHRoYXQgdGhlIFVBUlQgZGV0ZWN0cyAoVUFSVFNUQVQgaGFzIFJYIHBpbiBl
ZGdlIGRldGVjdGVkKSB0aGUgUlggc2lnbmFsLCBidXQNCj4gdGhlcmUgaXMgbm90IHJlYWN0aW9u
IHdpdGhpbiB0aGUgRE1BIGRyaXZlci4NCj4gDQo+IElzIGFueW9uZSBhdCBOWFAgYXdhcmUgb2Yg
c3VjaCBhbiBpc3N1ZT8NCj4gRG8geW91IGhhdmUgc29tZSBzdWdnZXN0aW9ucyB0byBhbmFseXpl
IHRoaXMgZnVydGhlcj8NCg0KV2UgaGF2ZSBub3Qgb2JzZXJ2ZWQgdGhpcyBpc3N1ZSBpbiBvdXIg
aW50ZXJuYWwgdGVzdGluZywgc29tZSBkZWJ1ZyBzdWdnZXN0aW9ucyBmcm9tIGZzbC1scHVhcnQg
c2lkZS4gUGVyaGFwcyBKb3kgY2FuIGdpdmUgc29tZSBzdWdnZXN0aW9ucyBmcm9tIGVETUEgc2lk
ZS4NClBsZWFzZSB0cnkgd2l0aCBMaW51eCBNYWlubGluZSA2LjE0Lg0KMS4gQ2FuIHlvdSBwbGVh
c2UgcnVuICJjYXQgL3Byb2MvdHR5L2RyaXZlci9mc2wtbHB1YXJ0IiBhbmQgImNhdCAvcHJvYy9p
bnRlcnJ1cHQgfCBncmVwIHNlcmlhbCIgd2hlbiBpc3N1ZSBvYnNlcnZlZD8gVGhhdCBtYXkgaGVs
cCB0byBnZXQgbW9yZSBpbmZvLg0KMi4gQ2FuIHlvdSBwbGVhc2UgY2hlY2sgaWYgdGhlIGlzc3Vl
IGlzIHN0aWxsIG9ic2VydmVkIGFmdGVyIGVuYWJsaW5nIGhhcmR3YXJlIGZsb3cgY29udHJvbD8N
CjMuIENhbiB5b3UgcGxlYXNlIGNoZWNrIGlmIHRoaXMgaXMgc3RpbGwgb2JzZXJ2ZWQgaWYgc2V0
dGluZyByeF93YXRlcm1hcms9MT8NCjQuIElzIHRoZXJlIGFuIGVhc3kgd2F5IHRvIHJlcHJvZHVj
ZSB0aGlzIGlzc3VlPyBNYXliZSB3ZSBjYW4gZ2l2ZSBpdCBhIHRyeS4NCg0KQmVzdCBSZWdhcmRz
DQpTaGVycnkNCg==

