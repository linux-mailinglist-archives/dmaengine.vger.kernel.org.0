Return-Path: <dmaengine+bounces-7532-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4A6CADD0A
	for <lists+dmaengine@lfdr.de>; Mon, 08 Dec 2025 18:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4037D3014BE9
	for <lists+dmaengine@lfdr.de>; Mon,  8 Dec 2025 17:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B21428CF7C;
	Mon,  8 Dec 2025 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eTDTwxWa"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8239328640B;
	Mon,  8 Dec 2025 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765213809; cv=fail; b=M8k7s1kycGpzTyGAB3FciFA2aIRbfKG8MwYcUy7UaV90q/Gk1d7L5UZURtBL7QAqIfvwPUFZXr3z4haDEF+mLQlIpxl7bfvW86dhCO68rOQvJhVtYa+1XX8S9twRvOU33fai0GPDl/QByeAMwrxc+MZnWxh9Q1umYLezEtw17WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765213809; c=relaxed/simple;
	bh=VG3P1dKB4KIzbm6r+udQ7XmrvAhfT05/GgbfoN466II=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=MQ/13QIQhyMx5ND9lCLmK/0cCcKgFmsDETka21zdeSjX4x/baYT4GNbYcYUH7GSWzo14AR5OXPr+KyO1ZhnpnmFjREJhfRJQqq7quO6aXk+YfciyjnA+nzMQBeXw/cF5QoWjtgihor4HcoyLSNHdmIHXeD6E2KB599cpAL/jx3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eTDTwxWa; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Umk2KiQ6XD/2EK/8zE9vQjPcb58cJFNl5FS+zcfsGjgdOSmkkJr6Ncp/NQXmR/RciBfc7nyATozljnTzyqDTVRLNVRTyqFPH9Y7nKiHBbz0oNIg/BNWK21f62bdF3FqAX2NIegiqAF6O7Zk9OVhBfICTgKKD/YY7lsjFTt7dtuQ6O5tWxxc79eq1ddXaWPrUogyI8qQRbS5z8VT2zBvu2unckf8UKsUZOJBW7a80gUf4lgJuOYWKz8jSxkvjA7o/ZqX+o5DXWF+oKW1CJbfaYgVR6/Zq3l/3PuyJMoMfAFyVd71HCZsCMJ3l6tm43M5OlvpGq1ocz3MAVgrEiPF92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnsFUgfymOEzZ3bn3buKNg98tQVjC9ofRHGZU+zjYUA=;
 b=CajyAwnXRcVOBq3bPSleuegJDKjpT/UTaVKJk1bidv6ZlymbrvgXCQ5Zktn3k3RkpnjfgV2Yi8tI8GVK6IaBvTWbVyjGYsDPoBAk1qWzIVcHxBSSsaC7m4bYzHfxsQZcTmZar62OSNzIX6J0Xly0rflhnt/AtzNABPhC4FwjwcoSdfnw1OhuYD7juZzW7tMfGeTkHoU45EiyoEjFKUB8XJuHuWAqqHQc4zHaM/CbIHo4yVARs98VLurKDBX8NAgQIFwLwzdR832RtOd0Ke5j38cmAxQ6FaFqeDkxXfodpcD831j4TS+pnbqL0tH7NK42QtYHB9t4eI/IQCt4U/bAcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnsFUgfymOEzZ3bn3buKNg98tQVjC9ofRHGZU+zjYUA=;
 b=eTDTwxWarYUSiBq8ff6UlGLBGVo+otS0SfG2zXBg77yZaexKADccmRERf/Dzr8hAbYHn4hPyuZmwZRxLfBjST6nbYc7qK8cd3hfhyNAD+d9EOYu7d9seW3Sy0sIhqN9Pb1jOk2CtrRmLohATYiari/FZytw7+nfVjKfHpyCUAgSKJFb8agF0hjK/BDfD+fqyPVYHEdYclTXEfATQ5SdEieMR4gy4CYtoTt+bg2i/f2DqEavUxR/8I7gO9Oh+vJVJG81UYKLszaTrNHhs7pQinZPLclThkV3HIfhw8MRAix1m+T3rYsylmCWPnCZZQ2mM7Znisc7/wbycr1+o/64EoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI0PR04MB10318.eurprd04.prod.outlook.com (2603:10a6:800:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:10:04 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 17:10:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/8] dmaengine: Add new API to combine onfiguration and
 descriptor preparation
Date: Mon, 08 Dec 2025 12:09:39 -0500
Message-Id: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFMGN2kC/x2MQQqAIBAAvyJ7TtBFC/pKhIhutYcsFCIQ/550H
 IaZCoUyU4FZVMj0cOErddCDgHD4tJPk2BlQodWojIynd3em24UrbbzL0Ro9qYjGeoRedbfx+x+
 XtbUPldriQGEAAAA=
X-Change-ID: 20251204-dma_prep_config-654170d245a2
To: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765213799; l=2220;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=VG3P1dKB4KIzbm6r+udQ7XmrvAhfT05/GgbfoN466II=;
 b=yFrzld2B6HUkI8qsO/YCwPuLUH4E2BOWhBViAlFCgUTcis7UJWkjCFOz4Nol3LiOCEAZ4Yjr3
 9D4y5w9s8eGAsopfzsmjU0n68GHcyK3WXLhYd7tXCXAJzpNwov+G+4h
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:510:2da::28) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI0PR04MB10318:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c25d368-3146-4780-e987-08de367ca120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGNrc2pIYW5vWkZIVUExV0VoYmZMZ3kwd3BlVldkSDRuMVB0VzNCaVJZVFVj?=
 =?utf-8?B?MkRrY2dhL1NmR2JTVHJxWTZrZVdYWlYrTm94c2RETkJ5TFd0eTZ5ajA1aDd3?=
 =?utf-8?B?cERZajdFMmdLalB2UGVRK082bmFOSGJET0ExbmRNTks5TlBEV2JJTlQ1S3g2?=
 =?utf-8?B?dGU2NVE4ekF0K1NTU3JiZDRhdm9tUWZnQ29HcHByZXV4VjB4dnZ6dy9vV0cv?=
 =?utf-8?B?THh4cktPWUZUNkFrT2V4SzJVMGlVRFlZOUNtZzhxY3RuVXN1V28ydEVsY3JJ?=
 =?utf-8?B?bDU4aDdDK0ZwdU9qMmtKTVM4SzNiSFVxWm5NeWJJVFdUMnRoSmRqb2ZQQmZi?=
 =?utf-8?B?OEw0amVZTWpJZWFmNzVDdHBsR2RYem5vcFhEZlptcFo5TW5XQytEVXRGODNZ?=
 =?utf-8?B?SlBGTlhLZEJhYy9tc3A2dXZHMDF6RWlXNytXUlIxaTZDR1lCZ0JVWCs0VHBH?=
 =?utf-8?B?WEtiYndnVzBaVzVBalBHVEVaenlWVDQrQzBlWmNHaTdSa25LalpuMnNYdUdr?=
 =?utf-8?B?WTllOEpaT0Z0SG10RFhSSVV3YWl6RXpLSUFjZnZOaU5qTCtWRkJYZHFpbGxC?=
 =?utf-8?B?UGRPR1NPeXk1VS9ZcjZheVdQUFN2TlR4WmxLVjIxRXJnWTFZTXBQZ21xd294?=
 =?utf-8?B?Z1BhUDg5c0loekMzZmdWczdoRVFsclg0Qmp5RWE0cjREZ2tVYXQyQTFUcEJ6?=
 =?utf-8?B?MjFMWThiVW1nVWZhZUNtVU9jM0F5dldXeWlTWFptdVVpYjlrSlpJblZFaG8z?=
 =?utf-8?B?Rkl2V2RFRytvSTBVcC9hR3d4V2lDcVhlOVduTlg1OElsNUVOQ1JSUGwvSHN3?=
 =?utf-8?B?M2ZaK096cElRZTBhbTR0Zng5blpVWElPY3JiN0NBT0x6cmpNKzgxS1JzNGEy?=
 =?utf-8?B?Nmt6WUJtamNLNWhBU1BNamE5ZUkvM0s4cUpkazBWMGU1U0pDdHd6QUdJVGl4?=
 =?utf-8?B?NVlTYzhxaE9CRDkySXR5Z3dweEh6aXZRbkVzN1JvbWFyeFJwNXVQNDRubUE0?=
 =?utf-8?B?ZVQ2dnpoTmhSZzl6TFM3VUNIc1JJcUNPRkorZjY5OU5aWlJ4NHN5TnNZak4x?=
 =?utf-8?B?MC9CaHpjTEMwVTJoU1Z6U0VJOE1wQjFUb01tL3QySWNualJJQ2cyMGgwYUsy?=
 =?utf-8?B?WG8vZFFuM1RQTUtxUG82Y09rTjFjRkl0cVY0VlgrV1pyOXdkYTQ3VlcrQ0F2?=
 =?utf-8?B?TzBudWduTG9NTHhFWFNybmRqK2Q3QWkzc0JHYU1ZdWpGK0FnQnR4eUdFbStF?=
 =?utf-8?B?SVBMNWVVRTViV3JORTJOMWZsdGliaiswWnFUOXcyWUxsalNQamRlb2VzcGpt?=
 =?utf-8?B?Y0dyeUdlMVZKZm10Y1BobE5oMU41ZGZHeFh2djhGNnp1eEVvaXc5RFBaRHUz?=
 =?utf-8?B?d1ZPdkxRRElVTTU0WjhkdnVVOFcwZGk5OHJyOGladXNBZlYvT2xhZTRPeDB5?=
 =?utf-8?B?UXdkNk45WEdZeFd3T2hBaWZyeERCd3g5ZmVIVm9SMGluS1NUR0xOcWNIREpW?=
 =?utf-8?B?QlphamVwYk0zTjdVdXE2M1RHL0RBelY5MHRqeUJxUjU4V3lkQ2g5RzFFOS9V?=
 =?utf-8?B?cS9pWjBIZ0lBVnRPSjJXNC9jRWlDMWtvZXBUVjVFejFWb0ZBRzRHdzdtNzNN?=
 =?utf-8?B?MGhIQmVFaEppS2JaYW4yR0ZFQ1g1OW1LN2F2OVBZNFhHYWVEbW5JWHZzSjl1?=
 =?utf-8?B?NDBzZ2psc2w5clp5K2EwMXVyVW1MUEREQzUxWHNqQ3NCS0Z4S2w3TllnVkhC?=
 =?utf-8?B?VS9Icm9EMVpybXNzYU9POEZneFI0cFcxU2wvME5pdi9IUFZsZWdVV3phTnd5?=
 =?utf-8?B?YkswVmIrM2wrUEVTSzhFWGdQTWxYMmJSRVltMWQ3NWlyQmdFRDI1VEFVNEZw?=
 =?utf-8?B?SXQ1OTFWb0VBR0lmWjJtY282Y2tDOUFFV3dVSmFtV2tOM3JSVFNyYWNoMGdL?=
 =?utf-8?B?UVMvS3l0ZmxiU3ZkZUdPSHFHNXNvUU16SmFOdzZPeEd5QkFjR1hFMFdDaUZU?=
 =?utf-8?B?VExCUjd3YW1jWlMrY0Q1M0lobnNUREs2Y3pCN0hNVVNSQUF1ZUlsajIvR0sr?=
 =?utf-8?B?cU1hZzRDdENYNURGQ0RMZEJVL2l6VzhLSWlGQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3oyWkFqa3loWnNaYW5NMHFTN1JWWHk4Wlh5Q3psMy81blNEK0VqeDNtckU4?=
 =?utf-8?B?NlMrZStNbXdiSHc1TXJFemxUQzVPN1hLcFNtZyt3VURndFFzTGNSWjM2NktU?=
 =?utf-8?B?SWtxWHVyam9LQWZJRWtISVBWQVZ5c0Z4Qy90STVsdTd3ampNWUgvSjVrbmdu?=
 =?utf-8?B?aFVCTi9VUDVScGYzN21LNXZtcktkV25vclBsQVBOMVFVc0dEZUlzVVdPbVdM?=
 =?utf-8?B?eCtMcXVNT2Rtd0h2M2s4T0lyZ1NwTHdQaFczRU00TWdUMDg1bFNwV0NyR002?=
 =?utf-8?B?b3pLSVZBdHFtM3dQUk9mSk5ZQkc3L0lLSkNqdnNyQisvclhSeU1MQ1ZobXJR?=
 =?utf-8?B?bUdObEZxaVgyVWlDemZtL1NoRDM3ckY5Y3JmKzcxUXVhbU1ibmpqK3NWUmFX?=
 =?utf-8?B?NW5SUlVhdG1qTUZnK1hXRTZESG5udWJvUExKMFdLR2VvNDdCajc5WlZOQU9y?=
 =?utf-8?B?VTgyemswcEEvdVpwWVM2dXVBeThTSGJpRTNQcUVxMUMxMVNDY3BpanhsTU1t?=
 =?utf-8?B?bjJIOEdvYU5KbEFscnNOaFJqeW5HTFVtc040QWlLMnN0WHZFbHQ4a3dpRFZv?=
 =?utf-8?B?SUlZUThKZ2RmMlJpMUhxRzhDMVBMUHhoZFEvSmYxNFBTTjNCekZwSGlwWDJE?=
 =?utf-8?B?Wm1xKzRRRHh6RFViRWl0bTBrSkpvelNkcjNhL3lmUGNWSWFUOWQ1OXMzbVEr?=
 =?utf-8?B?TWZOcC91cHliOU5uQVZTbVhENTNxTUkzVDJyUUsxSFNhSUI2Mm9XRE5wd3JE?=
 =?utf-8?B?cE8zYzlpUURYVDJERm0rd1BTNmRXQjJJY052VlI0bGRQRFNOcXBsaTY1ZGYw?=
 =?utf-8?B?bzQwbzhrcEt5TFR1RDUvNFVFUHNWUVpSQ21aNXEzSW1FWUpGL1c4Q3JCTzEw?=
 =?utf-8?B?d1hMaTBlcXJReDJnN1BsVlJoQ0RPVEhZdG1UVklnaGpveE1MdndvQjNGeWpY?=
 =?utf-8?B?MERQZ1FnSFJyZmJIZzlpbVJnUitEUlZza0t0SkpaNThuREtYNmtWQU5WUWc1?=
 =?utf-8?B?cTdicWY1MTdaSUNleU5zMEZrZzBsOFpKZDR3a3RuaWc5aEtSbTBCVDlZMSsx?=
 =?utf-8?B?aFI4dEpIWC8xZU5NWHNYQnpVc0lhZ2JtL1ZlNkFNYXJjWi9FcFpKTVRVdzN3?=
 =?utf-8?B?RW85c3BDcWxKQzUwdFdacU1CeFp5RjVJei8wemY5RVdmS3VVNEgzNU5aSDRH?=
 =?utf-8?B?dmQ4b3RUN2FCd2JnQ0o3Ym5zQXB0WFoyZHdkZGxhME55UmNCVXJQZWNKdlVD?=
 =?utf-8?B?OHZhQVBMZXkzSkZQMzNyems0RVBVaTNFcElPQTBudEovVjlCMGgwdDB0ZGdH?=
 =?utf-8?B?VENOL1ovNU12S0RPdzBsOThTbnhHSEdmQWcwN1lBVW04aVU0dG5mWDVnbThD?=
 =?utf-8?B?N3ZoUk11L2J2cThNZkFoaTlGb0FCZjJycmFPK0V3VTNTUjJlOS9qTm4yT0lI?=
 =?utf-8?B?dVd1YmUzTTEwR3FzbnBsRHhHc2FLU1NuaGE0V1FWMmJTdHBKMkJrdllQRmMy?=
 =?utf-8?B?THBDTFdSUTJXemM0Wk1sSmN3c3laWno3L1o0czM5aFNwbFpzVU5KbTFWN1dR?=
 =?utf-8?B?K0lyOHdRdHhVVW5oWVpCcmxONzMrVkpBTzkrbDE5bzg4MXFPMlJ5Ylpndmhi?=
 =?utf-8?B?N0lRRHFvNG9GUXhtVG1SRTFUKzBYempkRzdvRTYwTGhna05vZXJtekJvd1hY?=
 =?utf-8?B?NE9YT1o0N1F4cVE4dTNHVzFBWTlkc29CcFRIVmxVSXRacEFHaTAvZm10czhM?=
 =?utf-8?B?YW5Hb3hBRkFaWEdDZWpnKzVaZjlHRlVRUTFkWElDeE94d1FNdVdCL242Titx?=
 =?utf-8?B?aXl4cERiZlY4QUxpVHgrTFlVUTh2VzJUNTZMNnV3QWpLdHVYVmN5b2lhL09t?=
 =?utf-8?B?MndNbGF6UGYzbnowY3A0QytaRkx5SjJDM3lWc0lkTmZnWlBLdEo2RUlsZm5Z?=
 =?utf-8?B?QnBOVjcyOSs0c21PcHR2K3NSeHJIRURhNzJYNXhRNkVWWU5Qd3NjSHN4bWpy?=
 =?utf-8?B?WjNxWUh3RC8wQ1FzajE2TTJoZW9WRFlwSnFhNU9MWFRPNGIrSi9zeGZaZ2oz?=
 =?utf-8?B?bG8xc3dUYTNKNWhmMFZjaWVhYndlemluTEhHdnplNWNpNTk2RFRaUmxqKzNK?=
 =?utf-8?Q?u0SgVMMxmOj8+SXRhUGvccFvd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c25d368-3146-4780-e987-08de367ca120
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:10:04.1556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZC+Gic6SbUUayDVOM7UMwPg9kKIRxtKs9P337SN0lmO25KSltLwD9KyH2oIgnR1stcM6WwKX5BQzuJfO5rTZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10318

Previously, configuration and preparation required two separate calls. This
works well when configuration is done only once during initialization.

However, in cases where the burst length or source/destination address must
be adjusted for each transfer, calling two functions is verbose.

	if (dmaengine_slave_config(chan, &sconf)) {
		dev_err(dev, "DMA slave config fail\n");
		return -EIO;
	}

	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);

After new API added

	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags, &sconf);

Additional, prevous two calls requires additional locking to ensure both
steps complete atomically.

    mutex_lock()
    dmaengine_slave_config()
    dmaengine_prep_slave_single()
    mutex_unlock()

after new API added, mutex lock can be moved. See patch
     nvmet: pci-epf: Use dmaengine_prep_slave_single_config() API

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (8):
      dmaengine: Add API to combine configuration and preparation (sg and single)
      PCI: endpoint: pci-epf-test: use new DMA API to simple code
      dmaengine: dw-edma: Use new .device_prep_slave_sg_config() callback
      dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()
      nvmet: pci-epf: Remove unnecessary dmaengine_terminate_sync() on each DMA transfer
      nvmet: pci-epf: Use dmaengine_prep_slave_single_config() API
      PCI: epf-mhi:Using new API dmaengine_prep_slave_single_config() to simple code.
      crypto: atmel: Use dmaengine_prep_slave_single_config() API

 drivers/crypto/atmel-aes.c                    | 10 ++---
 drivers/dma/dw-edma/dw-edma-core.c            | 38 +++++++++++-----
 drivers/nvme/target/pci-epf.c                 | 21 +++------
 drivers/pci/endpoint/functions/pci-epf-mhi.c  | 52 +++++++---------------
 drivers/pci/endpoint/functions/pci-epf-test.c |  8 +---
 include/linux/dmaengine.h                     | 64 ++++++++++++++++++++++++---
 6 files changed, 111 insertions(+), 82 deletions(-)
---
base-commit: bc04acf4aeca588496124a6cf54bfce3db327039
change-id: 20251204-dma_prep_config-654170d245a2

Best regards,
--
Frank Li <Frank.Li@nxp.com>


