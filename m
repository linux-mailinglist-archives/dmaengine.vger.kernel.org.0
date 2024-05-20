Return-Path: <dmaengine+bounces-2100-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917E78CA079
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 18:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4BF31C20D3C
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 16:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8D0137932;
	Mon, 20 May 2024 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lYpqeANe"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73713791D;
	Mon, 20 May 2024 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716221403; cv=fail; b=s7gDu3u54SAMTCTs6rexlYYK8LWMaBG1Fn4NmQBVnYFjuM7sffn/aMeK5tP2ZKu+qPBR7VzF5ZMPJlxKO+zlwSFoOhpbN/k2qULcthocxm3n7m9X14g65yzMF878VgAFhJoVRU/0X2pw78CGS3br7Bq2n7HGu6/UoEfpQt0n4fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716221403; c=relaxed/simple;
	bh=Ue9DoiTmBK6eu+g2lWFajA/J9GaQ6d3UFTf3Ewes2Ic=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BJJ0omO3axlvpQoQaGSFrH7s6u7iboiSdDFHdUeHsgBBwuixUXxaESMvBTMyp7P/rUoRlCqVJVP/PaUB0e3tp8bax/vR2IeKsBcoTgJaRkBd5WdnVLwOSWX5+nY27GrtrUVdinWF+F+/ALbg93B5xXpEnp1o7nBmrEYvprHTpPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lYpqeANe; arc=fail smtp.client-ip=40.107.14.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npBx5HPiG3lVWZJ5gXasauO88p5HCEsfz/T0HsKA1jBGwTNNgOsCmn0EpwbsEazwZZEWpsyl194tBX5DVhZ3z6N+5jYHNZop/ojw6ATO4B54k+h6FFSvwmAcxv/H7VBKwQbtEEKvdeHxkUiaiVriolAwTlp/B05yzKWkKXIIGro1L4UGLGeWeEOCzjSHm2sVihZbyL6UQN0CIIJmEMSeLnKBa3bHGgx0tQIxV3y6TCSRYxNyb+dYv06L/Nd+DZ9Kx/XYMkPgKucbIdIsJ5aZReGyHVBrRLg2bLU0WwUoOBDF5DF8u5acrr8OBg9SZtYGoawk8QsmxnAXZm75OaCNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDlgFfsLoKEnExBRGn7/MB1Z+OHdzQrEQt8j81qDNrQ=;
 b=E9emo35KxtTL6sVPk1TwtZvPbPKn4fPgKSyoEMmO3/QMjzxCpIevEqsChMPIMmWDCZABo1h/oO4sdAFSb42C+reRkETBA+VJsJUpcJlBJ4sKgcjSsj4AWPvmmSloqPOWAKxaQvKESmw0/VhgBnQlC5TO0sINsbARYkSK65vWoX4H5xO5HsaiRk+HZnEpTwbM4SIy+zTD5Ge8zy6cKqPhQbMrHF2JZGnTLe7rf1B1/3uBzfXxwbVIn8pLe0ebdGAUxxOWvfmoXP7vUd/voeYPf00nhAJZNklwf7JbTszfuufB16A/n/MdmyegPs7M8pNVfl99mDUilqt5LH5tIE7T3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDlgFfsLoKEnExBRGn7/MB1Z+OHdzQrEQt8j81qDNrQ=;
 b=lYpqeANe1aba3bWfS0n4YqRnCyheyzAbhG1VpVXdiFrZqT4Oj6FoWvpUo1sWy9gv5jdJWaV9cRXm+LORA2CExkKkTOsGhCKYxqPRwHre6lt2irvUVTokeqgBbyjlX9G0328C2/S4UYb6WwzrAUUpkbrAwatcWRjP0uI56hFYFEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8535.eurprd04.prod.outlook.com (2603:10a6:10:2d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Mon, 20 May
 2024 16:09:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 16:09:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 20 May 2024 12:09:12 -0400
Subject: [PATCH v2 1/6] dt-bindings: mtd: gpmi-nand: Add
 'fsl,imx8qxp-gpmi-nand' compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-gpmi_nand-v2-1-e3017e4c9da5@nxp.com>
References: <20240520-gpmi_nand-v2-0-e3017e4c9da5@nxp.com>
In-Reply-To: <20240520-gpmi_nand-v2-0-e3017e4c9da5@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716221390; l=1517;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Ue9DoiTmBK6eu+g2lWFajA/J9GaQ6d3UFTf3Ewes2Ic=;
 b=N1UcfsKGZk0yIQVrPMrzErBuP20r7w/OLMzY9vu9sxtb3lupBd7iC01wpTsT5b/dSJsiYPLNB
 zfCE/uOel6lA+bIFpNGhidXYu/Zh1jJKEODIbBds49vtNWr44/rkj3N
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:217::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: a577120f-6dc6-4b43-b079-08dc78e74c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|7416005|1800799015|376005|52116005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkJ0ZG5ieXU5S3pIblFIeUxabC84RVdYbHUrUlowaG5pL2gwSXBoVG5nTmQ1?=
 =?utf-8?B?L0J1MHZyZVRERytxb2lNRm5zK3hDQnJPdG5nblFpOVFtWEQ0N0NmWXBvWjlV?=
 =?utf-8?B?eURlcDJIS2pBUjF0R3ZEMzFkK3MwWHFRL2pCNUlOeEl0Y2hYVWFBVjdMOGlw?=
 =?utf-8?B?aWZNZkQ4cER4eENSUzZiNEZBd1k1Y0FzcHV6U0xmN204c3hPdkQ0cVpqRXpO?=
 =?utf-8?B?YytUSXlEYTlXRysvZ2NaYkk0NXBMakxVY2VON2wvVU5tckpPbXlSdmthQjRw?=
 =?utf-8?B?WDA5aWYvdFJCUmZpWXJJOXl0S3hLSVhsdWUreUJtOWg2bnpkVDR0Ym9jUkdI?=
 =?utf-8?B?aHIvaXcvQkR1amNHanNIVG1NaU5rSTUyQXJjSW1uL0lZejY1dGgyQVpabzBm?=
 =?utf-8?B?VW1ZbnA3MFBRTE0remtZbHlpM29DZk0wMStPaFVCaUtKTWFZcFhhU3IybERW?=
 =?utf-8?B?b3JuUHdkTUN1UDVNQjJpOFZDanpva1dBUDJLbUlCUVZTUG1pVFNhZ3l6WENN?=
 =?utf-8?B?YjV2MHNDWmlBalh4RjFFaXZMdlUvYzA5MFZML0gvM3NrYUJqaE4xNy8zbDgy?=
 =?utf-8?B?Z1NIa1pOcUZ1N3JPKzBHREpkQVlBN2kyTlJHWHNqcHZCeXN1MURwREhWQmJM?=
 =?utf-8?B?Y1o2aVZ6OVliVk95R3dUSmRNSTJ6MGxuSGpGTVJwa2hUYldZUFJaSjBickk3?=
 =?utf-8?B?UVJXWXBoNWZvQzZxc2VCVnJZWENLdElVMXVtcXIzcXRhRmxkZmxMdjhpRWEz?=
 =?utf-8?B?WFhDSkJWZ2tMc3NJdlJobXVTOGk2NVBYVC9NWDBNNmxtNWIwaG16S3dSZVFU?=
 =?utf-8?B?bG16SFp1MDFhc3Zpb282eXlueDJacC90aHlTVnpqVVovTmhKTmc2b0tWZjdt?=
 =?utf-8?B?SlJQL0RjWjhweEVGU2lUeFF2OGZrWnp6WEc0Wk5SbVI1bUtZRWtjOFAwdlF1?=
 =?utf-8?B?SGY1dzNCYnRRa2w3bkprQUU1ZStPWTlTQ3MyNnljZHpqb2tVV21mMkxkRnZD?=
 =?utf-8?B?N3FsNjZVMHVXbWl3U2c1TkJmd0VXb2VpeW5abzdjV0F6a0dEOEh1dVU3aDFI?=
 =?utf-8?B?Wm9DbmF6TW5IUVBralIwWUhaRzFYQ3VuTWtSRW42VE1tU3dWak5xeTY5QXJr?=
 =?utf-8?B?THhGOXJjRU5kOVpUQXRRODRudzZYS0UzZ1B6ZUl0OHdsQ1JqZE02UGRrNEdH?=
 =?utf-8?B?SXNmNUpkMVpkOGFpUWlvcThnSjFld2oxRXp1TEx2TjJUa1VMTmF6d3RiUFpB?=
 =?utf-8?B?TGQrNVkyUkM2MXU3cnZ0eStWWllFU3NYMXEwdnQ3dkRmR080dCtzdEJ3M2Jk?=
 =?utf-8?B?dVRyNnRWQWlLK3JlZGpJdXBYaHlsUlVwckduYm1xMGRncUdkcUpBVnJZMWla?=
 =?utf-8?B?dTFTUHV1ZVV5ZzJ0VVNndmRtb1dLeDM4aXlUbWJoQ01QMWxtcHlUSTJCQlB6?=
 =?utf-8?B?YnR3VWxGWnRtS0hraWt1RjJyalhML1NsNXZjQlF3ZFp1OXR6T2JsbE1JeWE0?=
 =?utf-8?B?SWFxYmdzKzZ1SGp2WmhRd09VMEFpOEwwUndhWGhEelZuSTY1alI1L25aL1Fz?=
 =?utf-8?B?NUJiZ29VZnhxVTFUbnBNTmYwT0VlN2duWDlqV3FtMlFKUEc5SEFYOTV2RUt5?=
 =?utf-8?B?ZFBqM1g5bktyS3hSL25LTzFCS1dGcVFidWpwODRUVi80Smw2K3o3bk8vMGdR?=
 =?utf-8?B?Ym81NDVCT1JKamdCUVhFcms3M0E1VDlEZCtUSGZ6UkRrYm05RWtjaXVuN0Ju?=
 =?utf-8?B?UEFmRDd2Qkw5UDhackl2U29ua1UxS0lIbExPQlV2Qm5SSTlmZjFoc0Zaek9S?=
 =?utf-8?Q?Q73ZmP7jKAb6Q5MxjA5Yk39CUeRktoo65gGnk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(52116005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVcwVG5Bam9WNWU4a1daeVh5YXdJWGxWVzRKaFkwVWFzaUVDNjZkYmVJbGFn?=
 =?utf-8?B?TDlGNWx0TWl3RVY3dVFKeDhoeThtbElDc0kxV3JXS1U5ZkJMalY1NzVCSzFX?=
 =?utf-8?B?V0hQQU15Qi8vL3FBeVN5Nnp5OC9JRzZYdit4TWhtT1h3akQ5aGFwVmRzalZF?=
 =?utf-8?B?eW9RcUdPdkhMNzRLT3cyTUl3cW5uVCtQOGZ2UnZ5VWFzMlQ3UDVZVUJNSlo2?=
 =?utf-8?B?UDZidkgwWnZMRm91Yll2VGdobHMvNjlIOG9nUmVrNWdKNHVIRnFTcGtHbFRy?=
 =?utf-8?B?SGtxSzFJTmZxUGFScWhoWnB1R2VPS0R1MmNOd0NwcW8vUXQydEUvZ0oxTmRo?=
 =?utf-8?B?eDZyYVlYY3dIMzZpblVPbnBLNytIdklRMk5ZM0F6QWkxNGJ2YjNmUkFxWFph?=
 =?utf-8?B?b1dSOXkxc1VablF6R1YxaForMEVadlQrNFZ5bHJLYno3U1BXVEtGMTRTV1dn?=
 =?utf-8?B?bDJML1Y0TFc1THQySy9hZThaVExFb2xsbWhqdTRFbDg5SENzNnhaaVBiQ1Mr?=
 =?utf-8?B?T2hjZ0RYZVgvN1pIMklXY0pjNXp0aHNuOUR4dllpUURYS1B6Z0gxNnpYbUx2?=
 =?utf-8?B?Znllb3d4bC9RUktTa3hCUGY0T0lWdVRuSFNFb1FyKzBMMWUwZEo3dEttNW9P?=
 =?utf-8?B?S1M5cGFORFg2eG1ET00xT25kVXphU3F1VDJKZVRUMDBDZ3RSdWFTRlcxSHl0?=
 =?utf-8?B?SjBFVVVQWmo5d3dIc3RFbkx5ay9wMitEcXlxdmJ5Snc1QzRLSzZHS3k2cGJB?=
 =?utf-8?B?d3ZGUHlXTzR2UUx2U2dwVDhoM3dOOHU3WHdlRHowdDdsZkZkQU1jVDkwd2JQ?=
 =?utf-8?B?OGdXSXJ2eHN5VFhxaDZqcGduM21WV0NZZ1U0RmpkWFAyN0RkQjVGSGhPM0Jm?=
 =?utf-8?B?bzNaOWZsZm1pM1pEOWZ3c0lIM0NNQVRwdFdGdzhwSWk3bVFVQmlyN3c3OU1B?=
 =?utf-8?B?eWowVGcrM3dMNi9FWENEZWRWa2dwZW1kM0NoZDhjTVdmdkZiL1l3SHBiVUlI?=
 =?utf-8?B?NW8wQ1ZwaENpNS9MdGFJUGVybStzbVNrQ014QW51Mk1kZGs2eW1wQ29xWmw0?=
 =?utf-8?B?RGNwTnFBdnljbDlwRnVvMUxhZjdvT0xTTzZwMWtGaEh3eS9oWDRpbHNZNERj?=
 =?utf-8?B?WHVIQU4xRzIxQ2FkNUllTXd4UFFCdlZlb1ZkNk1mWDFic0N6K1Vzd3BMa3Bk?=
 =?utf-8?B?cnVTNHdDczMzSENHSU9JYTdiU2xwNFA3M0hRcUdqOFB6TmZFRkV5a3RRYTQ4?=
 =?utf-8?B?K1BTVlBLQmNabHpDTFJNMnFoL3FQLzBWZEhzdE0rQzlud2QwY1ZaekROTTc0?=
 =?utf-8?B?ak0xVkNkek9ZbW5EdlhTNzZNTjFReXNqbzFxZ0V2M3V1Z0ExcHpDWVRwSEV0?=
 =?utf-8?B?a1pnUDhKMGpZMWIyOG9Tem82b2I2cFlLWGt2MFVYWmh5RXhkV0UyNHZYNm82?=
 =?utf-8?B?UFNKK01DL29MS01UcUFwdEpjNUppRVo3bGM5ZE1helZrNTlGYnJvUFgxQXdi?=
 =?utf-8?B?djVXUDNxcDVzY0xmRzY3aVRySytWS05VbEZJd0h1T0pFaUxiSmVWSmNNKzJk?=
 =?utf-8?B?L3pMU2dJeXNwZzNqQkk1RU1ucWtORkFBdWJaNlJFeTAxK1daRHBaRVlVbU5E?=
 =?utf-8?B?TDVJSitvcVFjaG5tWE9aSGN1b05SbkxqUE13WkVjTHQ0OHhXRjBrOEtaMEJ6?=
 =?utf-8?B?ZEdDSGl2cXovRlFLSklONjlWSlJpZVNWYkFyeks4Yit1VkhDWEx2Y3hxNmQ4?=
 =?utf-8?B?blBOSTIrbE9velBHcTVUb2pRdVkwRFdobElXNnJiVGJxTUg1RlpDRVpNQVRo?=
 =?utf-8?B?M0k0OHkwUit0Qmg2WFJRaGVPNFZGa3lHWFlIMytEeXphRGdPVUlEbkR3SE0v?=
 =?utf-8?B?dmxWVnJ0VkE2UVlJVkl3LzhIN2RWbEZTa0JjSjBwd2ZSenMwUGhYTTVkdHNw?=
 =?utf-8?B?alhPa3hEL3poV3V4Q0RaMW84QTFOellqQjV2dXNBRGhUMVdOOGFsS1FPYlh4?=
 =?utf-8?B?RVc3WnUrL1ppQ3NCWWRNbHlrQ2dLdHlXanZNMzZQZFl3NndKU1JuWm90NDhD?=
 =?utf-8?B?cHM5NjArTm9VYlAzaFVpemlyYWhEV2xtS3NuUXJ1UDF4Um1JSnI2MnU2UE9U?=
 =?utf-8?Q?j0Mc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a577120f-6dc6-4b43-b079-08dc78e74c9c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 16:09:59.8755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtWIdDDpIoIZZMP4JiVTIVyFua2JoUEZF0o8d+K1KEAsEil63Mtc3Zf9kO6FFdCuHZ9FsHkjf8z8EyGTUW7PfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8535

Add 'fsl,imx8qxp-gpmi-nand' compatible string and clock-names restriction.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/mtd/gpmi-nand.yaml         | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
index 021c0da0b072f..f9eb1868ca1f4 100644
--- a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
@@ -24,6 +24,7 @@ properties:
           - fsl,imx6q-gpmi-nand
           - fsl,imx6sx-gpmi-nand
           - fsl,imx7d-gpmi-nand
+          - fsl,imx8qxp-gpmi-nand
       - items:
           - enum:
               - fsl,imx8mm-gpmi-nand
@@ -151,6 +152,27 @@ allOf:
             - const: gpmi_io
             - const: gpmi_bch_apb
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qxp-gpmi-nand
+    then:
+      properties:
+        clocks:
+          items:
+            - description: SoC gpmi io clock
+            - description: SoC gpmi apb clock
+            - description: SoC gpmi bch clock
+            - description: SoC gpmi bch apb clock
+        clock-names:
+          items:
+            - const: gpmi_io
+            - const: gpmi_apb
+            - const: gpmi_bch
+            - const: gpmi_bch_apb
+
 examples:
   - |
     nand-controller@8000c000 {

-- 
2.34.1


