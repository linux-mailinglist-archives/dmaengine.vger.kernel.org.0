Return-Path: <dmaengine+bounces-2063-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076408C8C25
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 20:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 608A4B20DE6
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 18:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0244C13FD7C;
	Fri, 17 May 2024 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CFGdRham"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3384613FD6F;
	Fri, 17 May 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715969446; cv=fail; b=l4SPQdVwjo+HCnTNRqo4sJhWY2PkHujcbnAcPCvpBjOzC1MbtluL6Vr0vq21W4Ek7PEcFFt0YLxPU+gSVn1DisydhciX/ULW4vgjGuPmRDNKhGvKk9mOUlcY2JrbumgG+imkJoHB1UTywwI2LHrAo5Unl18l6F7XzjpXv3Zr+gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715969446; c=relaxed/simple;
	bh=Sw93A6LU58pwgdnzIBCjouGCoo5gK8ry/LgTrzVBlm8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Obg1J5FNtvtekEuP0BVVAOp35ek6ZO8gLo5vFkJaLTLiybSFAevTjirG5v+MFhBeMtzM7RD41bhOO8mruCA02lSP2BT66/FWyWRuJBUGzRgGcKHtWl65gjKHL0u8pPRaVehGCgRPWNBsJnXOMe8Y0aZ3ucoV9UYoeZVRGsxHUCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CFGdRham; arc=fail smtp.client-ip=40.107.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3nh/Sgt6eKPKw3QEzgSVnV0/hLzG1BI0GGdtHF4mgZoKp3quN9S1p0BKhZ0o14/SzgDZTW24w6SBhMYlXKnEtgdlKzEW2pWhfzov6cof1CuyQAoHyX5kRYH+eWP+l7pnzF2Mz2LYCN45D8aCcfZ0DaeO4eH93RnwdWkj+Om4pgNvSVCJ4Uky5tVhtgzjbu7zvzQpGyOrDJeeo1Hoy8F7L7oC3+HJ6Zz/7rpc9/c6Xz/HypZSKktLdE5A7PMVW7aeMALGSqcaer38a4vp9OWbmLFOJ8LmLWDOOcwNMdT5gFHh53t8gjNCjDk3WxU37rji6bAauXkSp7/QE/xb13y1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym22gS0kdMfyxUPUeSJZsfWqaBY3uJD1o9Zz+PLgLKQ=;
 b=TqtBFx+yDjDrI0cRfrT8+dadjL+8P77wWdbBKiplEeO+7Xz9MH2HAAnBLITVG2M/Pnn9roa4xs0a52Pd2+G5XpYIrRcETYRPJeWDE3OmZriwtGHGZlO0sZbglwMQI6gFpCT1lVDszdD9tGDyThlZb6n3Qf03MHwiBKs7KQmI0nXHB45y2MkzPniDTLaVcqi33fWPw6s3LQVjNB5R8OZy1SQ6vkE2d0CPcZnv7pYFGBVmwohMV9MAr0WwTcoy07fQHmnRDcs0QeIOVO1vSlXUhAkPCQ9Cjo13VUXXkVSDMAxLCE+Q1xYv6K4F0ljV7XWBZTT1rtj/pGoUQRUU+WThXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym22gS0kdMfyxUPUeSJZsfWqaBY3uJD1o9Zz+PLgLKQ=;
 b=CFGdRhamkHNPmwW0ftnpRTV+AVamWbitLvD6O1NpUo5OmM2L3859YBlz+TNcikEA5cdLddOW2GuuDhOuDQmtNlWTVAaWGZxjRvgvdXHzC7q6kdkFirRwsGml9/dXwm8BPAsHrVz9wi1NXNDvvVbv9wsPg/srKTvQAlkIMD/LhYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8955.eurprd04.prod.outlook.com (2603:10a6:20b:40a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 18:10:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 18:10:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 17 May 2024 14:09:52 -0400
Subject: [PATCH 5/5] arm64: dts: imx8dxl-ss-conn: add gpmi nand
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-gpmi_nand-v1-5-73bb8d2cd441@nxp.com>
References: <20240517-gpmi_nand-v1-0-73bb8d2cd441@nxp.com>
In-Reply-To: <20240517-gpmi_nand-v1-0-73bb8d2cd441@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715969417; l=1138;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Sw93A6LU58pwgdnzIBCjouGCoo5gK8ry/LgTrzVBlm8=;
 b=aW3+VpMQiedBOh4DcfTwepzGO/KQLvlOYcYLIXV1GkIUhR2LYJcwog4CO7b4Dgso2+BBxaU4c
 dq17ppN58JoC/yecGeruat3i+SCzFLJdUFdnM5gMi5sEKLrscj0yqNK
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:a03:60::45) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ad61ec-810e-46d9-6b37-08dc769cab44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|52116005|1800799015|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NSszUUZTczRpRGJha2I0MHBOK1RlR3lVamJlaUVHTU83SkVZRWl6MEw0bG5q?=
 =?utf-8?B?aW1aK0lnS25LbmdpeHkyQktuYnUvZGFCdXNWdkdvTkhwRnJta1hZWVdTanV5?=
 =?utf-8?B?MnNzdWFHdTJYZ2g3VUJqTWpOZHgvajVZWFFjc3EwK3l3WmdRQ01MekZldnNU?=
 =?utf-8?B?VVZlNUhEOE5QRXp5Z2VzU0FWejdJMmcxL09EaVZXQTBnQnN1ZVlKVytXY3Ix?=
 =?utf-8?B?Q1JFQkYvbDBJVkpJNm1LdGNPZ2NGYkdnUCt4UHRFNlFLS2sxTnJtNUVwKzYv?=
 =?utf-8?B?ME4xWXRmTE5xa0lLcCt0ZEx5emhySnpsR1I4TUZsZkNJK05qeEJpdXBmZDc5?=
 =?utf-8?B?ajJuN01lNVhJczZ0T1d4ZktzMGM0SS9GQkg5RkFaQ0NzVkJTNExlWTIvSUFs?=
 =?utf-8?B?bTJQZURxT3YydTF5SG1zaXljQ1pqRjVZejlsUFErUUZHZVlXMC9sQ01rMUgz?=
 =?utf-8?B?TGhXN2QrNmZPcmx6U0ZZM0laQ3ZkMnpVWUpNTldETmx6TjVldWFQaWVPeWRJ?=
 =?utf-8?B?TTZMWjNCN1FjSGRva2xFdnFNQzBkZjZid2tCLzdnSnk4NVFZclptZUN5OXVp?=
 =?utf-8?B?ZXdiUmdweG9hNGRHbXZXRU1jMDJldU9YN2gwZG96VVZhejJsdHJBaEEvNzNK?=
 =?utf-8?B?ZForY1l4NkJzaFVJZzFWUkpFU2dmaFVHblRFOFpWTFJwQlJyOVUzNk04SVJZ?=
 =?utf-8?B?L3JJU2VOdDN1MnpyRm1SRkpaNklPdGJ5cXlETVhnUGt6RkQvMmJFYXIrYVZB?=
 =?utf-8?B?V2dDN3pOb085MXQzeWdIaksxdEZPT3hnS2VkOExwam1jNnlGUzlRd2lJTm9E?=
 =?utf-8?B?RWdhbTlqVlZLbnpISEdnM0JkOGI2cEFLZFhYK3VVeUplUHZ4a0xBR2g5NnlI?=
 =?utf-8?B?YjlSKzV3RkdLV0p4U3d3c2hwTElpZXdsRHdRWnhTNlphQ3R4RjRRM2o2WEli?=
 =?utf-8?B?MUlLTFQxWDV1c2NrK1JiMmtEQVVIRUdROVdCV3Z1V3AxNnlDOHcrWmNlYXRJ?=
 =?utf-8?B?a2hQeDN3QWx0ZnFraVhUa1lrMXJNSG4zM0VMYmtVUVpGSnNtSTNSbk1kLy9J?=
 =?utf-8?B?R3RnMC85MjFRTXgxT2R0SXVRYnhSbW9UN3hjRVFSVkxXWmkxZUlraHhORXNx?=
 =?utf-8?B?aGYvZC84RWtGU3NKb0k5b1Fzdis0ZlVURmVUZ0xmOGZpVzVhYjY4SjJzWGd5?=
 =?utf-8?B?VmZuNjI0NkZacWtsamZVVFVmN2NCM0g5OTdKUzArbVNFcTVrN1htYWIrb1Uy?=
 =?utf-8?B?eWEyVzQ1dXprU1V3aUFrN3FwOVdVSnhQMjVpVG1zb1JVSlJvODNxU1lDa2k4?=
 =?utf-8?B?NGFqaXBXdlRia2pnbWJuVStDWmx1OHRZajJEc00yTFVlNG1MM1BrM0lIVVZF?=
 =?utf-8?B?Z3JmQURXd09VUWNqdzcydGN1WTQ4V0VHc29VQWNqa0txejBzOFM2ejYwSjlx?=
 =?utf-8?B?bWVmWTBnL3dLWC93MFBNNk5JRG1QdkZrRVIrUElWVTJoTFdSSDdCTGVuOHBm?=
 =?utf-8?B?bFNVQkUrUVhUVExQTUpITGFLbDZuTk1OY2poaktFdFc4VE9mNTFQL2JrQ0R4?=
 =?utf-8?B?cjdMTU54ZTBLMnlYdFpUMm5lWEN3TW1UWkxJMVNPamNoT0tycTJGN0tRby85?=
 =?utf-8?B?R3F0YjNKNU5Cc0FHNFBNMUQrYU9BL3VVV0tNNXEvdUI1T08vQVZTYWtiWmhP?=
 =?utf-8?B?aCtZT3pIYVM5dlpEbTdDSTdPRWJpZUVGbnJ5SDJhbVNLcjNpVjIvbTRLSTlZ?=
 =?utf-8?B?VlhCNjdiaEhlUlAxSnZYdjRUaWZLWVFjNDBTRzQ0ajVCS3o0MWZSdTVlN3E2?=
 =?utf-8?Q?4Du1QtlezWXl5l0F1Ddk1YyQ7u29CM1MNhMpY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(1800799015)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEhEK2tSYXBpR29qYjlUVHVBR1NyYTd3N2lFUEZtM1NKTjhCZzRDOG8zK1hM?=
 =?utf-8?B?bUg2aWlzSTBBbGxMV3BjZ216MWJKUFNmWFVGM1BjN1oyU2QxaXFvbUhhRUpH?=
 =?utf-8?B?Y3JUams2L2lxSFRmY3J4VmJNbTRDL3ZJbkNWcXJGb1Q4cmlhaFVaVzRJTEVp?=
 =?utf-8?B?bS9IWEFnU2E0N3p2alpGVW1mTnF4Q2hRY3doOVBwcGw3bWs5TVVteUZUSmNX?=
 =?utf-8?B?V0lsc2U3U1IycS8zc1ZkVDZCM05pZWVrVTcvVmpYUkhrK1pYbGVnWFpCaVp0?=
 =?utf-8?B?MUJEdlhXQ1ZwTXJxUnZBdmswQ09IV2R5U0c2Q1lwZmEyRzB4ZXNTOHlmT2pI?=
 =?utf-8?B?aFhyd284M0xCMnFIRkh1a1J5NDhFMXd4TVU5dXFtZFRRRWFZRGdLZy9ucG5X?=
 =?utf-8?B?ZjBHNXNqaWJRaFJFMzZyUExrMmhMdEV0TTB2bGcySXNBU2l0NmNTSGhja1Ry?=
 =?utf-8?B?VHpSdWVWbXVTVi9OeUhDbGExRTFvaUZQN3lYSFFoUGRzcWxmcG1Zc2YzNkNI?=
 =?utf-8?B?Q09paFVrTkNIQWRwaHpkSGRGdmk5VVhZUkdXY2lrbE1FbUp3d0tDbWpYK0F2?=
 =?utf-8?B?NUNWS0l6WXhFc2tSMXdJUFc5bHZoUHpsVG5jU0xkZXZvazhaYkJSK2FRZmhv?=
 =?utf-8?B?WmdNdlFldnBYV0hyV0kyOElFSzJ2QkNYRjRlaEFFMUJ4MjhkeG02MXhEZ1Vl?=
 =?utf-8?B?MEtnZFpDa2lmMnRwMEE5c0w0d1hnNDBQYUk5L25mYzFlemQ1M2crRnJFM2Z3?=
 =?utf-8?B?SzBET2d3d1Nmb3o0YWtKNTZyd0tpeDAyUkxQa0VEcG11MFJVQXdndkhpcTF0?=
 =?utf-8?B?QWI4dUtuVG9yMFUvWE0zWGNubG9SWXZqeVhXbllQT2FXaGxJYXBwNFRVL1hw?=
 =?utf-8?B?VFFnZ0FYTjdZNkN6QXZBVUJQeGZUVHpEazFQdk8rVU0wcVZNM1hQQ1RNTzZs?=
 =?utf-8?B?MFdXZTlnM2ZvOVgzMm0vV2lKa0tBb25VbGJYbHdITVpPWjNIeWdWL1hqZkNp?=
 =?utf-8?B?aURtZEt4dEFyUERBQ1F2MGRoMjJ5RlBzM0pUdElBUU00S2p6ZWhOVkIzOVlQ?=
 =?utf-8?B?YzUxdDNjOC8vcWd0K1RrZm5TVzVhaC9XYktyZFBwNG9PVmFCYk5ZS21BNUxP?=
 =?utf-8?B?LzUySExtVzZ4eGNjN3ZNbHhNSkpGUWVtcnhlVWNBMFlwTVRDU0FqT096dDRY?=
 =?utf-8?B?bkkzN1h3UTR2VmlJRlJlck9ia3AyN2JBbXhhaGNTcDRDaG1zY1JMOXh0NFRS?=
 =?utf-8?B?MEtzWFkzeHRsb1QrV3BCNlp5TUZ3SlVHMHBkNm1MbExVWFlmemJySE5LTWwr?=
 =?utf-8?B?b3RZQk9Jd3h2MjFiUEVmUHZXN3VhNkdLakRTa1VUWW8wazlKMXUzdGNQTXUw?=
 =?utf-8?B?dGFaRkNueXNIZ3VncDJPUkVPTkxpZ3RjN21mQ1VCbWVvb2VmR3FSbGd5RVMr?=
 =?utf-8?B?U1pseG1sTnhsUmRaYlh1cWlWTjZpWFNJMWtsd0pOUFowV3J1citOa00xM2d0?=
 =?utf-8?B?Vm03cVVsZXY0VnVlTFNqNVROTDllNnlrejV0Q05vVGxuUnZjQlNqSFF0ZTM1?=
 =?utf-8?B?dDdRVXNuTXRjai92U0UxRTg3RCtSblZaeDQ2R3E0UGlvQ3k0SHBzQ3M1TXdS?=
 =?utf-8?B?aXpJeGViSWVjTzFiQ1hKdjRNUmt2UktGdWZ5a0I5Nnl6a2Y0c1QwZXhkRkpT?=
 =?utf-8?B?bTA0bytrK3Z3M1M2allqL2t1cXRQd1RuYkFiMll2MkpVVCthMStJU0tRSnVZ?=
 =?utf-8?B?aTg3QVZqTDlCQmwxRVpEK3RvckdydHVrVUdFQ2MwT3o5OWdLcCtwUytJR2sz?=
 =?utf-8?B?RzNpVTQrdWpDZnk4WTVQY1JEcDZXWXhWenRsdGc0R3ZSd2lESHJmMHliZGJo?=
 =?utf-8?B?dVVjQ3Q5SC9UZTJLeWFiejEyN1BwOXkyTnVBQVZkTjZ4WTlFdWNjN1F2Nlg5?=
 =?utf-8?B?TmxZUjVDSFZXMXdIUmljY3VIY1RoU2h5NDcxa1VhUFpHd0tIeTNVaUwrczN3?=
 =?utf-8?B?RVFJbnhiY0RBNm9QdE9ScWROLzNIMXZJMUg5aFdWVTBEZndLdDBTZFZiU0dW?=
 =?utf-8?B?Z0RaTEl5bEQ3VXNCblpncnpYVUhYTW5kS0ZkdVF5RHIyNmpnNWpJNzRoVEcr?=
 =?utf-8?Q?tAGx41woDr1DAj1PVFEKwwBBZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ad61ec-810e-46d9-6b37-08dc769cab44
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 18:10:44.0771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YRP7cYIConIV1B2uqPVwdKaCRAzn7xN9T6xgoprwNUirr+Ri1XM50DfFutiEhPTbHs6OIDq1fAeKMz8SxjF1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8955

Update gpmi nand and dma_apbh interrupt number for imx8dxl.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
index 6d13e4fafb761..1e02b04494e94 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
@@ -108,6 +108,13 @@ usb2_2_lpcg: clock-controller@5b280000 {
 
 };
 
+&dma_apbh {
+	interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &enet0_lpcg {
 	clocks = <&conn_enet0_root_clk>,
 		 <&conn_enet0_root_clk>,
@@ -127,6 +134,10 @@ &fec1 {
 	assigned-clock-rates = <125000000>;
 };
 
+&gpmi {
+	interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &usdhc1 {
 	compatible = "fsl,imx8dxl-usdhc", "fsl,imx8qxp-usdhc";
 	interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.34.1


