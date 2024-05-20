Return-Path: <dmaengine+bounces-2101-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A40A28CA07D
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 18:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D3B6B21EFD
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 16:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE712137C3F;
	Mon, 20 May 2024 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TO4B5EW3"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2077.outbound.protection.outlook.com [40.107.14.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F19F13791A;
	Mon, 20 May 2024 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716221408; cv=fail; b=gVEFldId0+Tm0DzLEIjeAKA7bcwlA4Aq4XPiEO2u6gqyvbiDgT+P9WsU/ooW+USuXhNlyAIW7NbLlhupmpSQR6n4623L/Dbx9ysHIdspO37WaBbyeK93SkJOnk7JuhPiZfwsngdSJsPfCRcLZCi3kx9lH0KrvR4uf/R3Xc6s0AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716221408; c=relaxed/simple;
	bh=8gM8Ady/cecQ90Pmy3nAQ77+C59Vc/wcv83Dzng1DKw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZFeOY89U+C+YmUiORUPk3WZuM03YxZ1Yvm/b7S0DCsSZDXGtgK+bSpc1skY47yg+uIpspsaJZNV6Gf4qMEStqKkYRJwX55h/EeKEDqgcpdLzIP6j7Y+tJh5qUTL1M1N3BPGqkHtfpY7KT+9+RlqdyBljmdkTOEBdmyXuTJW25lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TO4B5EW3; arc=fail smtp.client-ip=40.107.14.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CT8X9PgKvbx68arF00Lv/Mm4QLIpmzNeguBiA0+3IjloH6IOqsMH/nQ0QZ9t98c/j5IxvR12ML5SfTf5PdEJNxSz9rykuAE+vBbFISQ/Zcfqts78tr6aPPfDHvFplhGc4J02asi0dvc+91krZd/+3JGvMlpYjoFrhCpvVC6LUCo4Jz0L3F56mgcfW1tUibKSsPl4LB6hN8dwuNsBH1ipfWnNbWORm1crSBM/GW+PxfjnhEyu9iHVyJgd+Yzf7t+7vkZ8FEIzBiJdUikIJ/FncryvxcnwphuiM6GOJhQPBK5+Ur8P9ZqRaSdr8zDxRX6QV+wd4dkrjWOjV7veBlBfVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8UVwuUsBe9jOahUx7Z3y9k2YIrMSkcSTdZxCLYZJFY=;
 b=c6I1i5ekS8DeAcO5q2RCcJDBtcjyUhV+DoQyAxdSPopJVN6ShJFsSpEo2KIppc3HvVFKq24SycMQtSxanRgQhJJfFwvGifq1K+27Cmq4g7XWti9yIU50MDWtKvHcauoxAyEpwn0yr90TynUQubq3u42hnUdNIzgMJSRGefA7RbQXg9gd7J/8aUHVDNXZwkpUqPtd5WvOOUdqeNIO9/y53sdEHVidoU5q/1ziJ2inpQEGezGB2sHvcj1/7Jdg99JzFb3YV64Bx69Gp71TFfP1DQPHWpCLAlXs9ZDyz2D0kdayuQ/KNzKz/PqhTH/r5/M29JH3OxW3eTFKPosZORiTnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8UVwuUsBe9jOahUx7Z3y9k2YIrMSkcSTdZxCLYZJFY=;
 b=TO4B5EW3xx4pKp5amXMWKVoOMC2D1o1j4DB80GceCtCc5XyGMWKBtZEkesIwDGpXejkJR4qtNXH8WqrWif92ItPxNirrkgRWCvQLLlfd03mtbtiP1ZCePxvJAObT6i4jgbWuUXLmWJjZJTpG92qzTQdEMVBkKUDYbkDBHZMtcBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8535.eurprd04.prod.outlook.com (2603:10a6:10:2d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Mon, 20 May
 2024 16:10:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 16:10:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 20 May 2024 12:09:13 -0400
Subject: [PATCH v2 2/6] dt-bindings: dma: fsl-mxs-dma: Add compatible
 string "fsl,imx8qxp-dma-apbh"
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-gpmi_nand-v2-2-e3017e4c9da5@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716221390; l=1519;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8gM8Ady/cecQ90Pmy3nAQ77+C59Vc/wcv83Dzng1DKw=;
 b=kwH0H/oC4AMT973jjRiIE/NXPKvOcOf8PDMB+UI3/TlI15L3i6ZCHwScJD5fHBgCq5wYb2IkU
 wbci0k3XxyWBEqe4ighayUB7YRLhVy/9r5pAx+Z8gj+F0saF1xTIqJw
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
X-MS-Office365-Filtering-Correlation-Id: 165446dc-c3de-499d-6e4a-08dc78e74f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|7416005|1800799015|376005|52116005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0hNS0NqSnRjckpxczlwVU9nMG5vTHREUnZ6dzV5YytHRU9jUE9TelVRNHRO?=
 =?utf-8?B?NW01d2VTWDI5VlBQMjZ2Wm9GdUFnUG5samw5UXNUdmxJNEhWbm1JMDRKdC91?=
 =?utf-8?B?T2pjK1d6NWR5ZERMUzR4ZllGN0ttbEFKWXdoSG5SZ05GYjhVRnZja0JrTHps?=
 =?utf-8?B?cFFpQnFhaExTZXkwOGlidjJ6WWtrTkxGR2Z3THNVM0xlTk15V1VWT2J6WlhL?=
 =?utf-8?B?TjN4NFFYWitCTnUxZFR4VHlBY1pGMTA1aXljbmZRUHBiMnRoSUg2WW5GQmdD?=
 =?utf-8?B?WXJLT0o0ci9tWkNacTNjT2Ewa3NyRmE0emN2MGUrNUxadkpnNi9mUmt3K3c0?=
 =?utf-8?B?RFRhL2FrTW0yTkZWUVl5MU15RHlJekVqOXlRcUU2VmtyYzJuTXYxV3F4RzNX?=
 =?utf-8?B?VTFoTmFMZ0dPN0VaU3VPaHZ5WnNDUjk4Zk0xem5JdG5RR2JObDBEZVFaZG1a?=
 =?utf-8?B?c0JrelR5NDVoWTgzRFdLa1pOMGJGWmRYRmxkamg0K1FpeUNud3c4OEJobzNm?=
 =?utf-8?B?eCtZTEZhV09FdlczS24wZm1hN2xBalk4dEQrSWczbk9GVk5jSGtDZWY0ZURh?=
 =?utf-8?B?NmQyT04xVzBYdjdldW5Uc1dCT2k2ZFVjREYrU28yY3ErT1BER1dtWjlDWXBw?=
 =?utf-8?B?U3ByeGhpQmc4TXVsM0c0Qng5d0NnNUJnRVVHcTJFMnhQemgyWVAwT1JQVjFC?=
 =?utf-8?B?VGdNRTE1MFFPUWMrbkFNRnBTZ2syRVhLMkZuVkgzdW1uaERBY3VPbzlTTEhm?=
 =?utf-8?B?cC9Bay83Z0tCelNDbnh6NzdFNVExUVo0QWVENFNpL2FKWFZUREdydnI1a0Fj?=
 =?utf-8?B?KzVOWFkvaENCaDJjcXVJdSt3eXNGUUNxUlZla2hkczNKaUF0M21pY2svZTgw?=
 =?utf-8?B?SmpPRkFHR1Q4SWtEMTBJOFhxVjlVazJtRHRHVGl2YWxRY3FLREVnbHllQ1pt?=
 =?utf-8?B?V3BFcGhTTTJ2dlBUTXF2UEZabVhFZU5LdXNmVlhVV1c0VUd4WVhCNUROS1JL?=
 =?utf-8?B?L2FnbjFOZTlZR1d2RHRoVFBIWXRlVVkxNFZxMzVBOGhLMnE2UzlhTVFsMk9j?=
 =?utf-8?B?MXVCeFFvR3FFMjBINXFOMXplL2hGa1ROWFBMd1k4UkhLZ25OQ2FZY0NRcTBU?=
 =?utf-8?B?SlAzNm1ZSEZRQ1ZJWkZEeG5GV3hRdEo1ZWxvdVc3OGRCZ0tBaUhCK0pVK29X?=
 =?utf-8?B?U0RaQTRPMWpJeDhTZVJXemsrM2g2TWZBZTJoQkVVL3RoMUNDaExDU040NFl0?=
 =?utf-8?B?c21SckxBcHpuWnVmd2crL3pjdENhdmxWRE5Cc3dsNFJwb3czREMxY3Zwcmdw?=
 =?utf-8?B?R3JabUdtUzREYVZXRE1CQ1QvUTE0WjFvMnQxL0JRbU53OW9hOXRvMG9ZcU9j?=
 =?utf-8?B?YjFLeGpqZVhNdTFsQ0lqREd0YVY2NXZySk4vRHpzWFZoRG8rRldsMzY4ZjFv?=
 =?utf-8?B?UWRGN05vS2Q5K3Z5TGlCOUx6d25uL1N6UDRMOCt3VzZHR09Pa3VuN24vK1dP?=
 =?utf-8?B?aXhsY29PZ2h1c2hiK3ZvRHovM0lBdnhGaHhJeG5pOVZzdnB0U1pVVEJwYldM?=
 =?utf-8?B?d2MyQ1k0eVpxREJZWVNTajg3Sk05KzhoYTJsWmRsZDZxaTZFTXJYdnl6VkJr?=
 =?utf-8?B?cTZ5TVhvZi9yODJRNWJiRzdsK1BuOTlQVjJiN3BkQXlZOHBhd0pnSnM1YWQw?=
 =?utf-8?B?Ynl6cEJXV1hTcjlTWU9TbEFrbS9wNHp3aTVzUml1dGZ0b2dRWnBhcTRQSUVy?=
 =?utf-8?B?L2lyazd1ZmpBZU1ya0d1ZGR3K0c2UGlFMEN5UXNja0tUVWtqbGZTK1RBZSt5?=
 =?utf-8?Q?5J7+s15L53izKPAIouFKNLwB8n3WjHGajPc+8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(52116005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1QzaTVWMEQ5VnN5dTFEZTV2ME1PandZWUpuM0U0bFgrdHVkdXY1MjhLSXE4?=
 =?utf-8?B?ZmFmZGNjQjVtUTdKcjRtK3dtemFjdUJiUGFEenI2QTdXQnF0VUZ0eng1SWU1?=
 =?utf-8?B?Q3Q0Q1p4YXUvc0xNZ29ERTlaZTd6V0lHOXJLNm1LbHgyWmc2eFMxZlNvdUpW?=
 =?utf-8?B?Q2UyL3VIYWh6elJsc1V5NTF2MDZoTk9yZHI5TXZocTFDTGgranArZFNrSzRp?=
 =?utf-8?B?UTJPalpYT1hLNXlkMFZtSkpPREx0eTdJZnBRaU5FLzRqaUt5aldXWlVGMFNw?=
 =?utf-8?B?ZVBjdGM1MEMvMGwxTElzSTBscFo1K01jVUpWMEo2ZGJTaDBqMlRhMng3K0pz?=
 =?utf-8?B?K0UxTzExUDZWK2xjcWt5N2VMcnZ2WDJkSVNKQ2hzc1BHQzhFYjdXdGZoN0Iw?=
 =?utf-8?B?ODZnOTlJUGs0d2hFb1hEV0ZKb0hDY3Ezcko4aFQ4TEFINm1GZk9LVFU2a3VV?=
 =?utf-8?B?YTh5R0o4OFBhZFJtVUFYOCtIMk1jWkUrV3lJNndUK3loNFlpVUNuT1c3aE1L?=
 =?utf-8?B?RUNwQnpRdzA0VlVweUczYkwraUE4bTIyeXBxYW94djZEcStuMEVUeXFDQnRz?=
 =?utf-8?B?amRFYUZDdktaSytRcmFMcTNNVGtEamlMcjNxQXlHeDQ0Z0VSSlZUVEllZEll?=
 =?utf-8?B?TktxV0FaaEk5NEZza0J1VE1xdStyVE1NNUlLbHY2R0xTdDlaZk1oRFJKeDg4?=
 =?utf-8?B?a0NMZ2xZMzJ0SHVPYVA0Qkp2dXFvQXRROHIzdDlOczJKY2ZpTUJ2SUYvUC9n?=
 =?utf-8?B?dEl1Wkl1MzM3cy85WXU2aFBMTEw0VEVMWjhXZnhRTHY4V2NzLzlvRTBwblB1?=
 =?utf-8?B?bVNlTk51UlQzOUt4NXNJWWJzdm5jVE1lN29taWNCOWE5aDNDZDdxeG9ZWEtn?=
 =?utf-8?B?UElpK0NkZjkxbEFhRE1JZ3RoWU1wSDRzL1NWK1RvTk5zWWJ1VWFCOXRCZ29o?=
 =?utf-8?B?UUFuc1JKcXdLaG1TOFB3ZEppRmRVb24yYWlGZkVWeGFOUUo3dmUzUGx4c0xS?=
 =?utf-8?B?MjRnakJzb1J2VWhLUkgxN3psbXVXQUZGeHl2TE1UaVVPL2RVRjZvNG9OU2ZQ?=
 =?utf-8?B?YUh3MXBxOTRFb3Q4R1BCbndUVkc4OHlxTUdMbmtFaWlacDY3UHNrZEdmNHRL?=
 =?utf-8?B?cFNSSmt3UWtVWGdUbTh1RUM1SkRoOEMzbWNQMTNITXhZaUpZaWMyZmJYVzdu?=
 =?utf-8?B?eEZWb3ZnbUlLRTkwSjQ5WEU2eVBNYkhDRGtnMVVGckhkWE5FYUhiMEhzUWxC?=
 =?utf-8?B?TlFzdEhNLzFHSHRoYmxnakpzQk1mcXpTY1d1UTAxNUdZVnd3cXhXd2NTdm0x?=
 =?utf-8?B?bzRDZ2o1Z2R3c2hESlJDQ0x5R01sRC92eGx1QWREaWxsd05jQkVoOTgyRFJw?=
 =?utf-8?B?ME4rKzhrbGRERFcxMUQvYUNWaE03UzBaMFluMGNKM0RnZG5GRDNLT0VITEgv?=
 =?utf-8?B?VUFqQ2NETm9YSnJsc1RIckVyY3JyazRUREFrNHdIMkpLV3E5K1BLQnN6VlFv?=
 =?utf-8?B?RmtyakdRTGdLMHphdFQ0clZTM3huQ2xxY2I5K292aVdIT053RGVOOG9XQWJV?=
 =?utf-8?B?ck1iSXhwOFNDdmxBWmpjLzBJdXZYenJESW1IcFVic2Y1U29iVDErK28zQTF0?=
 =?utf-8?B?SzcwVno0WTdTVm1PZFNzNWl5TUpzY3Y1L2dWNURpZFVxc2V4SGJwQ24wWGt5?=
 =?utf-8?B?RXVFQkhHQlNHcHNKVE8yNW5DMGRwajZNOWRzamgvWE1qL0hYOTJCaVVDdGRU?=
 =?utf-8?B?T3dUZVh5eFBzR0JQVE5HYXR3UTliOFFsbVVOYWhRNVhaVng3aWQ0bk4rQmJF?=
 =?utf-8?B?Mm0vckJrbWs5MHBJT1RkcXE2QVNxaFBpa2NpbVJ6cU04YkhPdGxrVGphR1ZH?=
 =?utf-8?B?Qk85eDc0WHplQUlJTld5T0lmM2lhYVVGOC9jaDRuVVRiZVlYeGVHSTlCUDkv?=
 =?utf-8?B?ZHF1ZFJuR0dEdDBieCtTaUNMZUdibXQwOWl4eE42S0pRSjF0YmZPRWQ2RTlY?=
 =?utf-8?B?SEYxUWpwN1Rmdk9xYkV0TDBpUjZKODhwL2xadFJHRWtPQ0JOc0lEd0tLTzQ4?=
 =?utf-8?B?ZEpHcEdDSTFNUDFUTHhjZkREK1BxUXZTWE1SZHBzQ1VpNUttSWoyMEdGeHRC?=
 =?utf-8?Q?MA14=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165446dc-c3de-499d-6e4a-08dc78e74f59
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 16:10:04.4687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeMWF45uvWfcwi+El8zH5X3Kg9siEkxdSf62hCbCpgMTpYKbIgZ9itu3pzDDGYfEdHwIseVPdtCXqN5ZnDxheQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8535

Add compatible string "fsl,imx8qxp-dma-apbh". It requires power-domains
compared with "fsl,imx28-dma-apbh".

Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
it.

Keep the same restriction about 'power-domains' for other compatible
strings.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml b/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
index add9c77e8b52a..a17cf2360dd4a 100644
--- a/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
@@ -11,6 +11,17 @@ maintainers:
 
 allOf:
   - $ref: dma-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8qxp-dma-apbh
+    then:
+      required:
+        - power-domains
+    else:
+      properties:
+        power-domains: false
 
 properties:
   compatible:
@@ -20,6 +31,7 @@ properties:
               - fsl,imx6q-dma-apbh
               - fsl,imx6sx-dma-apbh
               - fsl,imx7d-dma-apbh
+              - fsl,imx8qxp-dma-apbh
           - const: fsl,imx28-dma-apbh
       - enum:
           - fsl,imx23-dma-apbh
@@ -42,6 +54,9 @@ properties:
   dma-channels:
     enum: [4, 8, 16]
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg

-- 
2.34.1


