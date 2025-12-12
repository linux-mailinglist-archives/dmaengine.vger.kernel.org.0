Return-Path: <dmaengine+bounces-7603-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F518CB9F37
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 23:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3FAC30B96FC
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 22:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB823148D2;
	Fri, 12 Dec 2025 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BcnCyThX"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA86531354C;
	Fri, 12 Dec 2025 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765578400; cv=fail; b=okticBPGoemdsGMsh93K/mM35v7Cv/Pxa/hSWfd9TrIvkBlyq23O9vceUzNYmoyzijezBUagc9ya3kaJeWbUUiXUWoJTh39B4YGW9npyVzthKWdxGEjjs7KSDGQadYicS1N0+heCWB+3bVESfWLB8umruYMLMeJhTYvFhHj5Mv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765578400; c=relaxed/simple;
	bh=grgZWDePbKHYJWs6lWhByzYgpraNSyzEXJBhc1iz1ug=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=i9VdSpG55WxIAeusI1YhJpYfJJaca7gohvuMKrC6gfRBx3qho9ZHtXNW2bh3l5uCTf4CaHj867IRoeVSaLh99Vbv4I+VvJ5HFEcqXvb7YiyCJVifW7u4KPVa1YBl7MAAI/F6DhK5koSoirXx62z6SVIyjTi5wVs7twsnAYYLPGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BcnCyThX; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUzgpbmQZM/Wf+L1JhdDt4fg4vFqUqtZpDk12na6CCOdMbo0b/F6rVMh1QIpr4j1X3a73okCB/ysx9zwUzficBmlV439QqaDq76Q91REEoZVgv6acpGiaMxGgHa0i2V/ZRtDvt0v8ALvBU533PhQOryr27sQyuylSmfU6ud02MkSVUnGIJ3BKf2Zffb0QGSWjJiomZx4SUVwAfQVohoxYTG/KpWbL+dv577oPl0i4CA17EOssE5XcFS2Aj2RZ5MUW5pVbQpdoU8Uq6j5g4NoE+0zKY4lg1CjQX6Emg+NOMcRxaYXi5lwWhqNN+k15MU8tzA09fgKVSKpv2M0sAullg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjg6gd+Z27nl4MszKT1BenNo2vwOSfKobBs5JAcLtVc=;
 b=eojDHvMry+mmZFgiSmQwvRL763BxZrfR3q5IR+8LNOB0K73nRqPc0NcLenXVr9qBLO8AtFrl9OUmL+VG7OMAmnB5i6yT0SAdp26bvYVG/XSFvaiOQV7fjjeCyl20lG6bSTnze6qNuhHYWOVsDf6FpEE/yaQQ5lmJmSKaUQ4BoIAOBb3HYPTEEmdk9pjF5NF042KXOdkSkexVRHavTLWaSrXisxrlLZ44jS5qZUpOpTpXlgkoWWywmwkMBZ0NfRM+iG2jV6tTVUuLik36zsMmr8pn5LHNbozeFsYTL0EGKORLgHHJ2/sjwupzVPQbrm60215DdeoDOr/cjE4NMM5c7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjg6gd+Z27nl4MszKT1BenNo2vwOSfKobBs5JAcLtVc=;
 b=BcnCyThXXs60xs7bs1ZzfuAkhFqIteorKGrV7fpxx8CnsP6fL4hF0nPHi09y7fzdd4QQrA5sLKjXnI0HGAL7qt/Dk0QFUKBFuMBZA8z/YY3B/ORtD6yjAG9giZax4xmMdFtmjip7I7R4E/eygOVq76u1Xt6yr9GWDVFNYyOgokQxwxvUHJwRqN0WrA7c8b4OUrihmbkuioxI1Pz4jFMCyaPyQGYnferUCNVlt69n4IuwDPnsFaqXpCYvYNFE4qqIWMv6islDg7zS+zTIpfeY1anyvcGdvCrM1GtmKiJ5fPiana3xNi8cTAnmUVQa/O/1YB5HDSBmoAHfq+fcIPn8NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV1PR04MB9053.eurprd04.prod.outlook.com (2603:10a6:150:1c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Fri, 12 Dec
 2025 22:25:46 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Fri, 12 Dec 2025
 22:25:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 12 Dec 2025 17:24:50 -0500
Subject: [PATCH 11/11] dmaengine: dw-edma: Remove struct dw_edma_chunk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251212-edma_ll-v1-11-fc863d9f5ca3@nxp.com>
References: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
In-Reply-To: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765578298; l=9633;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=grgZWDePbKHYJWs6lWhByzYgpraNSyzEXJBhc1iz1ug=;
 b=Osa5lYF1WTBGxM+iJW5jF6x0Jodbd+Pcd0M6owWzcqD97tloqU15eI4bJaIWA3wjjpARUZfH3
 0NsljCPckvsAzUOo7h1pGkwCaAdU9y76qsWKMTYGPr4c3flCvkpE3vg
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::38) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV1PR04MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c36bc6-fda0-4f60-4e8d-08de39cd6550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlZVbUVrb2ZJTTE0ckd3akVRY2h0SXlnaVJkU1RRMGlwUVFYTXRyUkRHaERE?=
 =?utf-8?B?L3ZaV2oxTncxSE9nd3Izb1ZTUGR5cnpKNHd4WkNDdzJ6ZnR6ZlFlNGJia29x?=
 =?utf-8?B?Vnh4N3hpdTZLOER5RmNJcTBQaldqa3FBV2xJNTJiMjk5dmRKNzBSWGtLNlJv?=
 =?utf-8?B?cWUxTjJ1MmgyMGc4ZHBaK1NpbFVKLzVuNnJhUnZ3SkJlV2JkaGZlV3UzZFgw?=
 =?utf-8?B?dmQ5NWVkcmxhUkVkQWlyNzk0TVNyampicFZKbjEyYzJzaTVodTZsR2MvbHVj?=
 =?utf-8?B?dDZ1MzFPQmhYYUFQd1FTbHBmV1FpeFcrbEowNWZxTEdNMHk5YnJOZ2JwRE9j?=
 =?utf-8?B?UGNkSFlxa1Zpd0RMb2NZeWJXZ1YwR05sV1dvV1dsYk0waWdZQjhxRktYa25R?=
 =?utf-8?B?bTdzM256TkVKUHFSczM5VEo2cGc3VU5sNjBPVmF4czFRUUdMbDJkWEU2bkpL?=
 =?utf-8?B?ZzdURXVGNisrcmE3RlRyVmJkQ3gwR0tlNm1hcnNKQTN1Ti9lblJlY25nbGpu?=
 =?utf-8?B?bXQrTlFRckRwakxQQ2hjNG5CY0lKdXVpNStXeGJoNzgvNS9CenlYdk1NSjBK?=
 =?utf-8?B?cFFRaE05NzIzbE94S05BNjZjVlhISkxTSzZMajdNWnRJeWtoWTZhNlg2Mnpy?=
 =?utf-8?B?dm9rUkVnZWRMTWE3RDYxb09MRUplTXBTVDN2WWR0VWFuN01Jc0VaQ05IZHFM?=
 =?utf-8?B?NTM2Wk45a1FaODBTQTMxc0ZTNVViSGt6WTBqWWw2OVlLd2owaGJRSmFLSGxR?=
 =?utf-8?B?aWtNRjliVkVoc0ZncVBpenlmeU1jaFViQnliNHBFVHN0Qm5QSDBZZzRzeVQw?=
 =?utf-8?B?UjhtTUNRVkZUOFVzbVJWejZCUTVVRUgxdTVhaW9CZDgwWWIrbUc5Y3NYb3ly?=
 =?utf-8?B?MEJhS1dmbTFsZEJuVzhXSDEvWDJwRk12Z1U0S3BWMEJSNlM2SUlBRmlDWWMx?=
 =?utf-8?B?VWExYUdDbGtwT2hoTExIVG0vblNRZnp0ZVhLYXliaWpDS0x2NjBtS1paV3A0?=
 =?utf-8?B?SzVlcDRRWi9JZFhxeFlVVFR2blNibFJ2MjFUSHBzZzdKR0Jma2NoNzBrdTVl?=
 =?utf-8?B?MGZ4UDEwMWo0R3pUaTNtdC9jdjZsbzdacThJZUMwenQ1c1hFRmp5R085bDVn?=
 =?utf-8?B?RXNudEVvMGhSY2tIQS95MlNCR0UwekhyWWpNUVVJb09HUHV3dktZY0RWVGkv?=
 =?utf-8?B?TFBGcnNMdHMvSmZIVTNkcEoyTUc3eDBoM25yYi9iL2hrcisxN3VaZ3U2aWVV?=
 =?utf-8?B?WnNQdDVYVWZoSWxCa2hmRlVBcW9XZ1hOaTVuT05hRTFXY3BhK1dsZXJubWZi?=
 =?utf-8?B?Q2Q2Mi92dEpzREdzR3M2WnRrb2YrSE9LYmVXYk90b1lqMlRqVDZ3R0Q4cklZ?=
 =?utf-8?B?UlF3NzE1eDNkUTZnd3dDNWNocXlDTkJWWGl6anhpOGpnQjhpRWlxTzRoUnVh?=
 =?utf-8?B?YnAzL0ZuNUZqSSt1d0RFY2dNK0dQZnJUSWh1RUpPSlNYaFVmcmZ1SDNxa0Nl?=
 =?utf-8?B?UG5JTmVVZ2lSbCtldGFPQ3ZhM0wxRGFtQ2RKZS9LdU1Cby9GZlE1TGVpeW9P?=
 =?utf-8?B?aURjQm1nSm9xenkrYUY3Z2tSeHo1czZxd1N0RWdlTXZlU2tyYXZJbmY0dStu?=
 =?utf-8?B?NmJSQmYyeldhdkVSNjdMYjNhV2xUVGV3dndzTjFwMm9WYWdScGw2dGtxN09a?=
 =?utf-8?B?T2htT05BRzcxWWU5WFpjc1hNdnM1SUVUZFlSSnNDZ3FWaEwwSVlrNGZnQUZC?=
 =?utf-8?B?RXkxWG13eWxKdy8vN3poWnVyd3g1WXF6TWNkNnh2Y3NzS3JjTDRUNkV3bTZr?=
 =?utf-8?B?amJhN1F4OG42cHl0Sm53SHdRZWFhb3Y3Zko4UFNpTnhsQXJ0bVltT0F1dmtJ?=
 =?utf-8?B?L0FoeU03dDIydDNYZGRTTHBQa1JGMlQydld4MnVDRldSMEZqREtjaC9ZNzNy?=
 =?utf-8?B?UDV2QWVwWWhjaFpUcmhpeWtpNmw0MGwwczVwTkZ5Mkg1enVKSHBFMDZRemQz?=
 =?utf-8?B?NURBRzc2Tzdadk1aYkFiczRiNFBNR3JYRklkcUZTOFJweUE2UHI4UW1Dc3dR?=
 =?utf-8?B?THoybnJWT1ZIZmEwM0t6dytpS3htc2MySGs5dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZThyMkRIM1VtaFcrRldXZ0pZZ0xVTEtoSnUyUlZxRVlOanlxL0NqRUMvcisx?=
 =?utf-8?B?WmlvaTJJem1mQWZnYW8zVXpheTYxUi93dGowb1JNYVBpSEhBeWY3NFB3RHdw?=
 =?utf-8?B?R1hLN1JXcnovRUw3emE3bTNIUWlzVWFweDJubnArUWcrQy9HZmFpU0Q4WXd6?=
 =?utf-8?B?VlZDNXpJWURLSkJ2a1BKOGJXb1Exd2JXVi9MeWxGc2k1L1Q1bDI2d0Uwei9h?=
 =?utf-8?B?ZlFGVWErQ1k2b0pXRVlYYW9ERlRoUjErVFF2UHRBUy85dkNNc2VlNmRSMmpn?=
 =?utf-8?B?MHV4UVVISzRQSHVIUjdjb2F6YWRTeU1oYU9QaCtTdzA1aDQ1V1lsYisxTHJR?=
 =?utf-8?B?aytkdGlub1JYV1JES0lBMEd6WERVMVI3OVJQNmdFcUlhU1VTbmhRT2tXT3li?=
 =?utf-8?B?ZmlrQXRhTEpYUFFBUVk5SGk4dzVUUHlKNUY4WTVXVGtscUdpeTFtNkFRaS84?=
 =?utf-8?B?dXp3ZUU4eHo3cllZdUxwalNlR09JcTY2TmFwNU1wbllMdlNURkd1bWpMM3o2?=
 =?utf-8?B?Wmh2bXpoWVc1S0tjOWY1RC9ZYlVjSGJjemJkdlJpcndqY3pqc3dnQWRGUlp5?=
 =?utf-8?B?RnZTKzhkUVRZbDNGZ1NsdXlWUnJmcTFzUzdneWxyaU92SzBLdkZaaE5weTNH?=
 =?utf-8?B?SlExMzdsTHZSRE56c3lYbFhrOGY1SWZvYXJqcHJuMzdwQkltT1VXaUxSbTBJ?=
 =?utf-8?B?SUF1VzJmV2NJZTcrUFFDem85UkdtVGVvZHIwaUN6NTltMVJQWVNaSklnWEk4?=
 =?utf-8?B?cXIxcEFIRHlkbTFqM2VteEtacWxzako2bW5saFJTbnlVYkg3K05vWUxTbjdi?=
 =?utf-8?B?eVVXZVRXbGtvVU1aaW5VZDJ3cURWbzY5cmQxMWRzcmVWTFVCMmt3K2FnODQx?=
 =?utf-8?B?L2dBcVRoQ2d0aEVoelQ2T1FjNENKUzlJZSt4UGRYL25WNGtwTzQ4dE4xRFlR?=
 =?utf-8?B?Z3dGbDMxZGlxSjI0eXN6L3VkYm5TT0xxdWZHRTd2MVRZbUVucWxzTVA3UDQv?=
 =?utf-8?B?VWQzdGkvU0hvaXNINVNVUjZ3TnQ5M0lScTV4OUEzcW8zRG9sUDN3NmR1TS96?=
 =?utf-8?B?Snd2alVjRHdwVWd6TjNwUlFyaHRpaHM1bUJDY29YSHBKODR5NnVDKzFHSGJs?=
 =?utf-8?B?Y2dKUkxsZms5WUkzN1BLYjlQRDk2SWRpREZpMjhPNFNGVzhUY1AreUtwMzlP?=
 =?utf-8?B?SG55bFUrVGxMcmI1REtYQ2xkSXp4RkxubUVWSFR5TjFPOHN0UFBia1M2Sm82?=
 =?utf-8?B?dSt2cE01bTJsWHZyYWl1eEFKN1hGaXI4akJjdWRuTjZTdThkb2lvdnlZWTJm?=
 =?utf-8?B?S2krbmw3bVFFYXlUcTIxOUpOZGpTajdFOUdqMktucThTbFo0RWxJYWtteEFK?=
 =?utf-8?B?RHdtZzV3VEd0cVRaU2lKaTNMN2JWR09HQ29UN2xLNDQrM2tsRmVFYU5oTWZ4?=
 =?utf-8?B?clNicG9uYUk5ZWs4b1B1d25VNE5LRnNjWXVzQ1BmYmhBa2gzampvMEVBWVlW?=
 =?utf-8?B?QWRRb01OcG05V2R2WFBGaFdXK2xxSVNsY0lzSlN6VERnY0lMVUVFVkdNUitC?=
 =?utf-8?B?ckNHZFlGaGVTdHM2bHUvUndXeW1LRkVGWlVsYzE3WVI0Mk1sVVFpZmNHTXVP?=
 =?utf-8?B?cjRsdFZEVHh0SkdtVTUyeWlPZzFpUllZdUJaZjNPSW5nNUZ0QkdzaW55WmJU?=
 =?utf-8?B?dUZwWlQrSmdTcnhrV1pKOFBzays2Y25aeG1iNEhWa0tsaUdOUENZMVIxNUJF?=
 =?utf-8?B?dU5sNkpiRTJEZUpmWVcvbm90U3lWTURVRWxJcDJPSmEwMW9QV1hiVVRESzZD?=
 =?utf-8?B?MkxaK0EwM0tlMm13RHNsNm1aYiszOVhQS1FsRnpNTzFDbHpKS0R5Q2pLZXNp?=
 =?utf-8?B?NkVuSTk5S3hzNVNOanNHaitkUEtGc0licS9pNjVvWmFPWDczT0N1NUpvYTRZ?=
 =?utf-8?B?aWJaTTFuZ21iVWJ2aE92U3F1NXgweHBEdEFtT3NjdnZOWWVEZXRrZE1sQjZN?=
 =?utf-8?B?MTljNnI0YVNpTkxUV2ZCMUFqOGh5WHlXelg4OEswRUk2Z0o2ZXlvNWdPMHZF?=
 =?utf-8?B?Vkh0bkViblBTdGxzcHNvZnA1YVVmbVo2YWh0dDczVFUrZ1o4dGVqcnR3ZXhC?=
 =?utf-8?Q?SxSs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c36bc6-fda0-4f60-4e8d-08de39cd6550
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 22:25:46.5376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jthNLHyNSz89ySV0WPcjVPODMQMXo7AgCPNoq4W8FOAJSLKeZ4zQVzgwBsP8Nv6JhbsopLu4EZN+IivtIw2oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9053

The current descriptor layout is:

  struct dw_edma_desc *desc
   └─ chunk list
        └─ burst[]

Creating a DMA descriptor requires at least two kzalloc() calls because
each chunk is allocated as a linked-list node. Since the number of bursts
is already known when the descriptor is created, this linked-list layer is
unnecessary.

Move the burst array directly into struct dw_edma_desc and remove the
struct dw_edma_chunk layer entirely.

Use start_burst and done_burst to track the current bursts, which current
are in the DMA link list.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 130 ++++++++++++-------------------------
 drivers/dma/dw-edma/dw-edma-core.h |  24 ++++---
 2 files changed, 57 insertions(+), 97 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 9e65155fd93d69ddbc8235fad671fad4dc120979..6e7b7ee99aaf6e1c3e354d36ca058813dc95b8dd 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -40,76 +40,45 @@ u64 dw_edma_get_pci_address(struct dw_edma_chan *chan, phys_addr_t cpu_addr)
 	return cpu_addr;
 }
 
-static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc, u32 nburst)
-{
-	struct dw_edma_chan *chan = desc->chan;
-	struct dw_edma_chunk *chunk;
-
-	chunk = kzalloc(struct_size(chunk, burst, nburst), GFP_NOWAIT);
-	if (unlikely(!chunk))
-		return NULL;
-
-	chunk->chan = chan;
-	/* Toggling change bit (CB) in each chunk, this is a mechanism to
-	 * inform the eDMA HW block that this is a new linked list ready
-	 * to be consumed.
-	 *  - Odd chunks originate CB equal to 0
-	 *  - Even chunks originate CB equal to 1
-	 */
-	chunk->cb = !(desc->chunks_alloc % 2);
-
-	chunk->nburst = nburst;
-
-	list_add_tail(&chunk->list, &desc->chunk_list);
-	desc->chunks_alloc++;
-
-	return chunk;
-}
-
-static struct dw_edma_desc *dw_edma_alloc_desc(struct dw_edma_chan *chan)
+static struct dw_edma_desc *
+dw_edma_alloc_desc(struct dw_edma_chan *chan, u32 nburst)
 {
 	struct dw_edma_desc *desc;
 
-	desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
+	desc = kzalloc(struct_size(desc, burst, nburst), GFP_NOWAIT);
 	if (unlikely(!desc))
 		return NULL;
 
 	desc->chan = chan;
-
-	INIT_LIST_HEAD(&desc->chunk_list);
+	desc->nburst = nburst;
+	desc->cb = true;
 
 	return desc;
 }
 
-static void dw_edma_free_desc(struct dw_edma_desc *desc)
-{
-	struct dw_edma_chunk *child, *_next;
-
-	/* Remove all the list elements */
-	list_for_each_entry_safe(child, _next, &desc->chunk_list, list) {
-		list_del(&child->list);
-		kfree(child);
-		desc->chunks_alloc--;
-	}
-
-	kfree(desc);
-}
-
 static void vchan_free_desc(struct virt_dma_desc *vdesc)
 {
-	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
+	kfree(vd2dw_edma_desc(vdesc));
 }
 
-static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
+static void dw_edma_core_start(struct dw_edma_desc *desc, bool first)
 {
-	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma_chan *chan = desc->chan;
 	u32 i = 0;
 
-	for (i = 0; i < chunk->nburst; i++)
-		dw_edma_core_ll_data(chan, &chunk->burst[i], i, chunk->cb,
-				     i == chunk->nburst - 1);
+	for (i = 0; i < desc->nburst; i++) {
+		if (i == chan->ll_max - 1)
+			break;
+
+		dw_edma_core_ll_data(chan, &desc->burst[i + desc->start_burst],
+				     i, desc->cb,
+				     i == desc->nburst - 1 || i == chan->ll_max - 2);
+	}
 
-	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
+	desc->done_burst = desc->start_burst;
+	desc->start_burst += i;
+
+	dw_edma_core_ll_link(chan, i, desc->cb, chan->ll_region.paddr);
 
 	if (first)
 		dw_edma_core_ch_enable(chan);
@@ -119,7 +88,6 @@ static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
 
 static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
-	struct dw_edma_chunk *child;
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
 
@@ -131,16 +99,9 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!desc)
 		return 0;
 
-	child = list_first_entry_or_null(&desc->chunk_list,
-					 struct dw_edma_chunk, list);
-	if (!child)
-		return 0;
+	dw_edma_core_start(desc, !desc->start_burst);
 
-	dw_edma_core_start(child, !desc->xfer_sz);
-	desc->xfer_sz += child->xfer_sz;
-	list_del(&child->list);
-	kfree(child);
-	desc->chunks_alloc--;
+	desc->cb = !desc->cb;
 
 	return 1;
 }
@@ -289,8 +250,10 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 	vd = vchan_find_desc(&chan->vc, cookie);
 	if (vd) {
 		desc = vd2dw_edma_desc(vd);
-		if (desc)
-			residue = desc->alloc_sz - desc->xfer_sz;
+
+		residue = desc->alloc_sz;
+		if (desc && desc->done_burst)
+			residue -= desc->burst[desc->done_burst].xfer_sz;
 	}
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
@@ -307,7 +270,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
 	struct scatterlist *sg = NULL;
-	struct dw_edma_chunk *chunk = NULL;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
@@ -369,10 +331,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		return NULL;
 	}
 
-	desc = dw_edma_alloc_desc(chan);
-	if (unlikely(!desc))
-		goto err_alloc;
-
 	if (xfer->type == EDMA_XFER_INTERLEAVED) {
 		src_addr = xfer->xfer.il->src_start;
 		dst_addr = xfer->xfer.il->dst_start;
@@ -396,19 +354,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		fsz = xfer->xfer.il->frame_size;
 	}
 
+	desc = dw_edma_alloc_desc(chan, cnt);
+	if (unlikely(!desc))
+		return NULL;
+
 	for (i = 0; i < cnt; i++) {
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
 			break;
 
-		if (!(i % chan->ll_max)) {
-			u32 n = min(cnt - i, chan->ll_max);
-
-			chunk = dw_edma_alloc_chunk(desc, n);
-			if (unlikely(!chunk))
-				goto err_alloc;
-		}
-
-		burst = chunk->burst + (i % chan->ll_max);
+		burst = desc->burst + i;
 
 		if (xfer->type == EDMA_XFER_CYCLIC)
 			burst->sz = xfer->xfer.cyclic.len;
@@ -417,8 +371,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		else if (xfer->type == EDMA_XFER_INTERLEAVED)
 			burst->sz = xfer->xfer.il->sgl[i % fsz].size;
 
-		chunk->xfer_sz += burst->sz;
 		desc->alloc_sz += burst->sz;
+		burst->xfer_sz = desc->alloc_sz;
 
 		if (dir == DMA_DEV_TO_MEM) {
 			burst->sar = src_addr;
@@ -473,12 +427,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	}
 
 	return vchan_tx_prep(&chan->vc, &desc->vd, xfer->flags);
-
-err_alloc:
-	if (desc)
-		dw_edma_free_desc(desc);
-
-	return NULL;
 }
 
 static struct dma_async_tx_descriptor *
@@ -551,8 +499,14 @@ static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
 		return;
 
 	desc = vd2dw_edma_desc(vd);
-	if (desc)
-		residue = desc->alloc_sz - desc->xfer_sz;
+	residue = desc->alloc_sz;
+
+	if (desc) {
+		if (result == DMA_TRANS_NOERROR)
+			residue -= desc->burst[desc->start_burst - 1].xfer_sz;
+		else if (desc->done_burst)
+			residue -= desc->burst[desc->done_burst - 1].xfer_sz;
+	}
 
 	res = &vd->tx_result;
 	res->result = result;
@@ -571,7 +525,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 		switch (chan->request) {
 		case EDMA_REQ_NONE:
 			desc = vd2dw_edma_desc(vd);
-			if (!desc->chunks_alloc) {
+			if (desc->start_burst >= desc->nburst) {
 				dw_hdma_set_callback_result(vd,
 							    DMA_TRANS_NOERROR);
 				list_del(&vd->node);
@@ -936,7 +890,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 		goto err_irq_free;
 
 	/* Turn debugfs on */
-	dw_edma_core_debugfs_on(dw);
+	//dw_edma_core_debugfs_on(dw);
 
 	chip->dw = dw;
 
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 1930c3bce2bf33fdfbf4e8d99002483a4565faed..ba83c42dee5224dccdf34cec6481e9404a607702 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -46,15 +46,8 @@ struct dw_edma_burst {
 	u64				sar;
 	u64				dar;
 	u32				sz;
-};
-
-struct dw_edma_chunk {
-	struct list_head		list;
-	struct dw_edma_chan		*chan;
-	u8				cb;
+	/* precalulate summary of previous burst total size */
 	u32				xfer_sz;
-	u32                             nburst;
-	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
 
 struct dw_edma_desc {
@@ -66,6 +59,12 @@ struct dw_edma_desc {
 
 	u32				alloc_sz;
 	u32				xfer_sz;
+
+	u32				done_burst;
+	u32				start_burst;
+	u8				cb;
+	u32				nburst;
+	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
 
 struct dw_edma_chan {
@@ -126,7 +125,6 @@ struct dw_edma_core_ops {
 	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
 	void (*ch_doorbell)(struct dw_edma_chan *chan);
 	void (*ch_enable)(struct dw_edma_chan *chan);
-
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
 };
@@ -166,6 +164,14 @@ struct dw_edma_chan *dchan2dw_edma_chan(struct dma_chan *dchan)
 	return vc2dw_edma_chan(to_virt_chan(dchan));
 }
 
+static inline u64 dw_edma_core_get_ll_paddr(struct dw_edma_chan *chan)
+{
+	if (chan->dir == EDMA_DIR_WRITE)
+		return chan->dw->chip->ll_region_wr[chan->id].paddr;
+
+	return chan->dw->chip->ll_region_rd[chan->id].paddr;
+}
+
 static inline
 void dw_edma_core_off(struct dw_edma *dw)
 {

-- 
2.34.1


