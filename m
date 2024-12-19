Return-Path: <dmaengine+bounces-4031-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D789F7843
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 10:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC63116D7DD
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 09:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF02222D7C;
	Thu, 19 Dec 2024 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YZ/Ro2XS"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2CF222577;
	Thu, 19 Dec 2024 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734600062; cv=fail; b=Vqqgyj8nddcRTEzLVoomFtH06EqNx1Ovg8+iSLQd+4CucQDZutecMBwgRKdm5P1Ahq2BqTJgQURbsLETOWsFg4SL9bOEX8eIrIm8/GlkYv+R25B/r/G1/Lld8cFRDbRfr/hQylVpprm9R8HffdB+oUjgcml0+QSOIpAGsO86eQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734600062; c=relaxed/simple;
	bh=8BhD0/fjnNlsUFzT3o5yEf/BMFJaWaTfKPf3WYocHFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=teqVZOOsrfaDODjFU7O0WOTa6UEgiQ1eu2z3FPZWmv64EwcDBEra/Ge6mT1k/qWNA2c3Y8b1426e9wtMHKhfteNr4vsmV+Numi2spUKV6TIKZxV1wWsmEnAqexvSCjCNKzGHHad4eEut3o5c+np0RwEyswXxRZAKJv20bqB3sXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YZ/Ro2XS; arc=fail smtp.client-ip=40.107.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+TZt0CCdpjMYkofz/Ro164cSFZWN6lmzTPqTkpuJWuaHz9zixQDZW29irI2IODj0+ZaIGUVZNZRfJyj+wpp13RPvn6xXGTIKp1f89fEJWLxwhlMpp2gu87BwFNWPvRwN0KSG+fK0kSUDhPFpfxkHVwifGYUDfLmCL/VzJaiwSXtVI0BbQI7f5YgL9ZwDUHPU+MRy1SuHoZ6NICxCOROWtlcYxEopxZ1UgzNGV7lIBAIpw8Ct39XDKF6o1uvNC0RKdCajoy9y2lIQ+MzcmVzgR5gnpR81frVZ6PwxB9EdofJ34u0CGXzGKTtql8lrvWx+u8Q3DDoLkESOCici8K7cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLIJ+7nBBLog/Fi2pEuYSaG/9xdVGhxe8g8HDmS8MA0=;
 b=YdNFLPuGIBy9+fPlAy+JqBDPDcEK9UJbJL9RpYAvrY1S3iRrhk7bSxLUO5Ed/gIW+5pk231WhP8R3U+u7+Htyd/u7WwOELpfVnCStfa79AO5ttl2CZRxFRlcbaq0UepITaiPJInwTsO7dw/6qjoLTcRicQA8pz0sr56xvUL0KQyRs8XhhLrgr7wGSWwd4+9AuWUFiaTuYZqlaiHgbdunfEUTHSOlaapQhckIFplghN8YKIzcEQgzCTKNTA649VHjM8OZYdmrCjHfisGpbwOHgcy2xwTLwa2WibRSClIAEvIlT94wWTqBo6jawXtA1eYAE+FmEJSZSJRMVJnuS7Lk3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLIJ+7nBBLog/Fi2pEuYSaG/9xdVGhxe8g8HDmS8MA0=;
 b=YZ/Ro2XSWvj7r+NQptlesdcC0Yol9B5q5DnOol+tsL6kRZQpdGoSLxt0MKjj0zPg7B7hwVJk+vx0x98f3W3cH8jXkfDcjRqTv8cW0S7LNFutn5/mZ4Lbt6FaRl3PpzmMYxmU1+d7eGhiDF5u9/aYg+ECuI7xCabY7whnqg8TyKff6+By1GRFXGEXjVdcsMnXJKgJ4kLCdGCJy7IckYhA4qUvZNEKhY4TQfh3+s17lTbYD9El/5k5N9dJr85DUPKtJ3wzVIb3/oRgNcYnRCJU2YdWU0kqxS5Dfr1j/fVFNVwTe8GmxFBFMbj+IuSG9lu/TAZN5odVQ8xACALpgL9YJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by VI1PR04MB9834.eurprd04.prod.outlook.com (2603:10a6:800:1d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 09:20:53 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 09:20:53 +0000
From: Larisa Grigore <larisa.grigore@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>
Subject: [PATCH v2 1/6] dmaengine: fsl-edma: select of_dma_xlate based on the dmamuxs presence
Date: Thu, 19 Dec 2024 11:18:41 +0200
Message-ID: <20241219092045.1161182-2-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241219092045.1161182-1-larisa.grigore@oss.nxp.com>
References: <20241219092045.1161182-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0208.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::15) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|VI1PR04MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: 2832f585-ca06-46ce-f385-08dd200e6feb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clRwSkdScUNDU0M5Z3QvUWdBYS94dmN5Rmthc1hUS1MzOHRJZDdRY3psTzI5?=
 =?utf-8?B?amdQd2NWSVMxT3E0UVBNSTRYbXo5cHoyOVhoTzdlc2ZacGhEYlZGNXJxZU40?=
 =?utf-8?B?Q3k1QUZFc3EwSWtxOGdEMHRGRVVRQ0UweXd2SHZPZmQybFZhdkF1Y3JPbXFs?=
 =?utf-8?B?YWVnVDgzcnpqS0JoaGl1Z3JEbUV6aVZiK1FrMVhuaHJPaE1LclBBYm5ROWM3?=
 =?utf-8?B?S0pnYXhWanJ1SWZIS0NzZFpmSkM2UEs4N3dqbEVlczIwWWpGZlNXdUtlOFlS?=
 =?utf-8?B?V0NMVUVNb3dPU2VNVVRodEo4WUd5czBFVmR3NmkzcDY2M1JNYzJTc0JGVVll?=
 =?utf-8?B?MnRKYlUzNFRNbXhIWStHenZOZkVwenBhZ3o4bE0rNnVJcmN3NlQzbE03REE4?=
 =?utf-8?B?aStFeEVRaGczTzRRcWtBakdNekZObThSbGE5QWp2SkpwTFFNeHlIWVA0ODRn?=
 =?utf-8?B?Ykhvd1N6S0kwanJ6L0hvVUxxV3JpMDRTd29aVGc5aXI0NG05NXJISDBHVlpz?=
 =?utf-8?B?a3NJbDIvdWlLK0d6Y1QreEJ5THFrVlZWQmo0T3p5UEQrdXFsRkpyS2xOQlM5?=
 =?utf-8?B?MFErT1k5Y3FBOGlXK1ZNZTEyM1JZcU1pNjBqY1V3Y0I0OGtFdUlnb0t1ekpW?=
 =?utf-8?B?MlpmQVpUd0tXcm5Fa1J4UlBtQjhZbHU1cnEreGhHcWY1bEowRWZzekMwcEZm?=
 =?utf-8?B?bm0zV2RHcVp1MHNyYTlKS3FxZnV4d2Q4SHBFYnlqa0YzSDhmMlArNTdWamsw?=
 =?utf-8?B?MWw1N2JDaWNpUlEya3VXS1VJWkRjZ1pkYmdwYUpVSE94Vnd3d3dqbTU1ZFQr?=
 =?utf-8?B?UWdKdUExWi9iSEw3RjZjUjZoWlVUenhxaTkwV01idHR3OENxYjMreE4xV2JJ?=
 =?utf-8?B?eTMxZ3F2V08wb09kclo0N2l1b1dKNzAyVEs3cjkwbVYxZWR4RFE5cEJPMXpL?=
 =?utf-8?B?MEp1alpOaXlUaENIcFNiY2t6d2lGQ1VJWHcyejRjeWhET3FVQ3cvS2t1U250?=
 =?utf-8?B?V0NUTURBSVY3NVVLUmU1Sk93RUVJNEgvUHMzMzhpbHFVK2lvdU9qYjZRVDNQ?=
 =?utf-8?B?cnFacURreFJvb3J4b3RSb1BWbkF1MDd5V05jUy9VeDNScVQxbmV3alcrQ3Jt?=
 =?utf-8?B?akxsZm92S04zREVsRXNaQjJjYWdnSU1sWWVhUHVObW0xeU16ak5wdEt0NllO?=
 =?utf-8?B?dVlGOW9NdEtxSnlVSUhNMmhPc2J2L0tXM3l0YzhjbzAwLzVmc0lRUWd4NHQ1?=
 =?utf-8?B?UW9WRDhYUWFydVRDUHBvaDd3L2tDZ2FRU25VS0xjcmd5blYyQ2xhcURVY1pN?=
 =?utf-8?B?MHp5NmJzdHd2bjk3YXlYcjgzRFR5ZTAxMGlBby90SVRNKzc2U0pNcUtvajVV?=
 =?utf-8?B?elljWkRMc0hxWFJYZjVBTUVTSGpWTE5VMStuUUhBTTd5L0dwYkVHdGtlU0xC?=
 =?utf-8?B?T092bldaN0pzTnU3dnYwNk5oWmNiZ0FBSCt1VXcvQUxraVZDQXFmY2wyTG9u?=
 =?utf-8?B?c2U1Um10VUc1RTVFc1NXcEJFOHhtbnJkK3ErT0s1VTVUV0pSZ21jNXBZOEFO?=
 =?utf-8?B?MHhaQ3Y2cmdiQUJPRFdZT0FVZTBjdm4vcktyRTI2d1czWmlDMWQ2QVhzSVJ0?=
 =?utf-8?B?YWtiNGdHY2xTYlhrU0orbmo1emdOZDBLckk5NnJ6dG4yQ0tsbHBmQy9UeHhO?=
 =?utf-8?B?VkRBNUNsVGxrQVFiZzFJUXVHVWJVVzJUWEx4TGR4TW1xcm5MRVF3cWVlWDNr?=
 =?utf-8?B?WEpCVDFiTEk5VktrenFESU8vUDYrMUp2b1g0aTFoTUpXVk4rVjgwL05UMDl3?=
 =?utf-8?B?STB6Rm92djUyZks3ckxSUCs1dnBENDQ4VlpvdHVqRlR3VVZLUDBIeHBRVWJk?=
 =?utf-8?Q?bIfWEtPqbWA2/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGJBN3Y0VGNKbHFSeStDYkJOWEp4V285TlBLRlMwSUNrMXlBanJTc2xLSHZ6?=
 =?utf-8?B?ZE1qa25Zd3B5SHVacTZVNmJiR2dDY08vQ2tJc3REZDJPQUljSkw4bENaOE1T?=
 =?utf-8?B?aExvalVZKzBhQmI3UVlieFRjbmM4YXpkc21Sc05YQzVVMHIzQWwxOGhuMTdQ?=
 =?utf-8?B?d0ZlODkvN0hxdWljMTBOZGhPamJ0Qklkd2I4NjlqS3dSeHRaQWRVbXBiL0JF?=
 =?utf-8?B?VWNZNU1Ca3R3Uk5Lcmw1UVZ2TGZUcXZ3bkoxL0I0cXVuVG5zK0pFZWx6Q2pT?=
 =?utf-8?B?TVo2a3JYOTVyQ3JuRDlWTk9RbWxORVpKYVY4TXpnc3V4eEJuS2pGTFVCNTlh?=
 =?utf-8?B?Vk5IdkdRMHBYbGIyVlViWW9CTVI4ZG5KTXp2OThWYktycktJT2FoMkN4YWhz?=
 =?utf-8?B?a1NpT3gxaFZJWS9KclBRWXZOOGZQVE41M2lUaC9kQVlUZXBTRldpK0x2b0cv?=
 =?utf-8?B?TXk5akpRbUdxNWZpZ3N0SDlsQ1NyQkQra3djZlNHT3QwbnZwUHpTNVZqQ0VY?=
 =?utf-8?B?YUJwWk10bVBZanFnSHA1QS8rL0s4MjNOVDI2OWVpdXhZMkc5OE5IN2JiR1kv?=
 =?utf-8?B?Y2FnTFJLS00wZm03amJOYnVOa2ZFak1RTGRWVkd6SzVaUmpONWtDNlptZ2FX?=
 =?utf-8?B?cXhhV1paT2J2UVE1bUp3bDZFZjNUNVk0MGJWZEs2UmVNSHBzUHFPWDVpdWZL?=
 =?utf-8?B?YW9BZE5PaWhKZTRzdWRvUGJGMXFUU0xzZ2ZVaG9yYjFTSFFBdHFMNFMvNlpz?=
 =?utf-8?B?SUVVQ21kS2VmNFBkYUFGTVkzSXFKb3FETXkydGlQQU9kVG1VSnVSV2VUK29L?=
 =?utf-8?B?Z3NGRFlUcjBINU5uWmFIRWowdWZ0OXg3UmFpUFQ1ZXVUMENocy8zRmpwTXZt?=
 =?utf-8?B?UnFsRUxIZW8rVmVlcGVVQVNYaVlZM0ltalVmYWExREhWc2ZrQS9OL1k1dDFh?=
 =?utf-8?B?cTFzUWtvVkxJN2xFb1crdG5YS1A1Qmd6V1BLTVphZ3NCY0hxc3pCL1U1UWUr?=
 =?utf-8?B?QzN6QXFXMURJcVUrNHJMRzAxUmMyYmFuVkVmaW8rMFFJMFUrV1Uwa0ZBdDZ2?=
 =?utf-8?B?NGsrc01PNnZBWUxoNTdCUWl3czVJUE5rOU93VzhmeU1yQzc4bGlCUVVIQlha?=
 =?utf-8?B?TWkxbDBhL013RlcvdkZGbC9LeEQzeXZTM3ZjUDc5SGpMaGVDMTNHTVVMZkRp?=
 =?utf-8?B?enFOOE5ONUxyak51WmhkcFJaNU5kYzF2ZnBFaitTQmw4dWFWcytiekY5VWpx?=
 =?utf-8?B?YUllS2w5WkRFdUpLRGtzM2k3UytOTGU2OC8zSjU0QmJ1WE53dEpaNGN0SW8v?=
 =?utf-8?B?ODlTYnF3UlA1TUJ0bTIwWTlQYjBFSlg5Z3ZZbDNVVjlNdkFUSldaU05ybG9V?=
 =?utf-8?B?Y21QempwY2hWcmVTQTBaU2tRcUZxb2pRdUtUMUN4cEdRTXlwdkV1ZTJGL2Ix?=
 =?utf-8?B?ZjRzOE96S2o5cHNFMVJlMHo2QlpGMDA4bUYzVitWMzNtcVAvK28wOE9VUzZ0?=
 =?utf-8?B?dGRuSUVOdit1TmtiNjRMbklPS0NXMWlQNGJrTmE0Y2FnUDNPWkNSV2tlYVky?=
 =?utf-8?B?dWQzTnBSdVY1MlRsaHluU09OWTVwUUFUajFaYVNxOTJvMUdaWFNEd2MwMnhs?=
 =?utf-8?B?N2ViS0p3amxONlRIK0xwaHZ6TWxSOWRrYXZhOGFCdzB6WGFLcjBySkw3QXhL?=
 =?utf-8?B?bjJZRWE4K3lHK0MyVFdRdndLMmJTTzRrMFg4eTBhZDEreHJ2L1hDcFlaNy9B?=
 =?utf-8?B?SG4zWmlEWUg5UGMrdHgrWlVGeGJpQXhhRDM0WGUxRElhRWtWTFRWa2hyeG1K?=
 =?utf-8?B?UXBaRWhrT05kRDA1UzRCQ09kaWF4LzBlVW9yQWdBakY1STZJR0gzcERnNUdI?=
 =?utf-8?B?aTcyR3B1a3hCOVo0YVE4MnVnNzdsZDZQMUVHbU1uRzFDR3Z4WkxCZCt2YVda?=
 =?utf-8?B?VXErOGxUUm9FNjBRS1Axa1NjYldRb0lOT0lGOHRrakdrK2lrNW5TSEZJOEl0?=
 =?utf-8?B?K2VNQkYrRldpTWRvSWRKZUxZTE5nc1FRQW0xcFhEMHc0eGFPRHVjRER2V0Ew?=
 =?utf-8?B?NUd0MVdtRlVoWU5hdTdxalV4THZEQlhNVktZenpLYVZnU24wNmtxUUkvSHFU?=
 =?utf-8?Q?BD3hQRk8qnVBrnIx5MHrlI8Zw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2832f585-ca06-46ce-f385-08dd200e6feb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 09:20:53.8180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4oi/wVB/bLGfsWrVXtHXrZWNaXMf3h7Cc2KH87T+vt1HCQiY3gbNZv0M6+K3LyMBlIKJVRcJPXW7W0eMNVIRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9834

Select the of_dma_xlate function based on the dmamuxs definition rather
than the FSL_EDMA_DRV_SPLIT_REG flag, which pertains to the eDMA3
layout.

This change is a prerequisite for the S32G platforms, which integrate both
eDMAv3 and DMAMUX.

Existing platforms with FSL_EDMA_DRV_SPLIT_REG will not be impacted, as
they all have dmamuxs set to zero.

Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 60de1003193a..2a7d19f51287 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -646,7 +646,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	}
 
 	ret = of_dma_controller_register(np,
-			drvdata->flags & FSL_EDMA_DRV_SPLIT_REG ? fsl_edma3_xlate : fsl_edma_xlate,
+			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
 			fsl_edma);
 	if (ret) {
 		dev_err(&pdev->dev,
-- 
2.47.0


