Return-Path: <dmaengine+bounces-8190-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB63D0C294
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 21:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE23630A32ED
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFF5366DB5;
	Fri,  9 Jan 2026 20:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F538i7ce"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255ED366DD3;
	Fri,  9 Jan 2026 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989659; cv=fail; b=TZWfbnFWftIJbW7v9PuGbB2Z9vrikiEbHcK64ZPRMtt6WJcL6/w8BAMAHU6QbbjOrduBzzfSHDFAaAt6kddFF6OtDy7twpz/QKZ7+cU5i8nsgMB403yMR98po197LokSM+fBuPFUd+0HPSs2JuQWkFsCQtz5+pnonsD7me6LLsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989659; c=relaxed/simple;
	bh=YSZ0p06OajOfaZljT0C5X0e+QmJ7Iw3Sj84MQU3Ifg4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FZkvm8QOJJikUZ8nlnoeFoHVznZOpTEhlyOPEKNUhv0iaJeX/NOSFmgD4xmll7DazxKrelU5iITRedBFj+TkVa0rK/iPjsfmMtZ3G5jcbPSrFghRee2dzbadcdfOJuzdj9db8QWKB8emTsyWBrSFerhCTm5rvVCtOwtQw38hvBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F538i7ce; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hk7tu3Fqj4oaGOG04c32no9JxgMWUg/QXSSv4ls+yiej593qRe9UEmkGvUjdyMatdrJQ9CZep/uztc7zDfmodVYYdLsseEtIqm+WV+ayfLgIQjgPmoU5s57ak84HntfoStsKo4zssLym5FqJqQGwxJuMlDAo2VoKbe27odg+seDYLvy0SEJgnSON2JJW5xfOT3hGkfP8ufWurBn8gkXoOdJIZxrFejcstJ4ppX4enQQfniX1JAUU/nsdA51sSjy50RssbRST6sc6Pdj313bdTkOvsUruR34dFNtMgP8a2Aea/tEDAurbVqZcJRY0eddrApJwH4EqQnVJ8xj/qZcjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCsFumrSQGRZ+YEeVjasmy+WcbcHdpjtrrzEyMZ2b2Q=;
 b=BVAOXHHnz2MOVrGgcppbnrBvYvexx7nd6Z98hwY3XBNCaZX5PyVQb1ALd8Mqh5fXAncN8+XmaBza6E8HtmBJMdPo3vzol8Q4OFi3dQjtMCs8xAXbEr8VzvyPf/iSvlwDbhg9iG5yF8WI3QC7tQ6cillH6pEKwAURy0AvoAD6rW1BuYNI22bTc4pXYjHenAJQyMkcaBnFxE9D3+fndnzYd1v/Knvv5qlB6JJ01qV2tGAhmNdRKvWr2FGeudv1LVE76B4omz4gfNTgPicalKK2fJMYOI61roBar73baLJGXLBqWeAC3WcR0g0Mowzm7jm8IWQBJPKwedDjr8xSezj8eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCsFumrSQGRZ+YEeVjasmy+WcbcHdpjtrrzEyMZ2b2Q=;
 b=F538i7ceWZDVRykcWHhVr+F6bSCgfDlzBKtFdaDMFDhmmD4rIXk8p9ASvB0QSLRne1/xX6T1CLqTnmiqH6v52scq1x+e+yhObgaHP7CFZPISWdjIUlSE5hz43B7RQh90O26EWiJDb++A/gs3Mm8NJ9VWUErSJx7b4ZJtxXHITxCnIABGWHSSsiSZJYCOwjR8dvn6M3AXHpaq1gWqSdyY39sS3wSpTtdNuV96fqbc8KMBDawQ+eFOmxmXsnmlQQe31W8885Ov/B3HIBw8B+nGsxhLvzO/P1u7kB1UXA5Zvw2AEGVFGVnt/qfJCM6I4JAJ9jJFUjNnvg4ME8dhNLYBwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAXPR04MB9106.eurprd04.prod.outlook.com (2603:10a6:102:227::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 20:14:08 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Fri, 9 Jan 2026
 20:14:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 09 Jan 2026 15:13:29 -0500
Subject: [PATCH RFT 5/5] dmaengine: dw-edma: Add trace support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-edma_dymatic-v1-5-9a98c9c98536@nxp.com>
References: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
In-Reply-To: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767989623; l=8053;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=YSZ0p06OajOfaZljT0C5X0e+QmJ7Iw3Sj84MQU3Ifg4=;
 b=AkURRH9GgUTTiSrhja/s8JZHlE5ONAgrqktt94Rn62cqd5YNkupfYji7r1tJ3sBwqH7ObGnUO
 mzkNc6y3RYjCa4SGYUaxRCA+vcdnHyWYJhb4sc0MnfDYPJFErfr5lOb
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::14) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PAXPR04MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: a56d3496-d3a0-4c49-3576-08de4fbba547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHJWeXJTWGlsc2diWjkrb0tCMEZ3QmJlNjkyVzRnRXR3UnR6YUFLMUc0NG1a?=
 =?utf-8?B?NHgra1dCZlpVQUFOaFc3U3h5U2o0QkFWVnYxWjlJdlRZYUxQbWJ2bm9iZjg5?=
 =?utf-8?B?MVVoQXF2MHRJa1JBdlN6STlZSlNFWnB2N21reWJiRlhoR3l1YWdZQTZ6b1BR?=
 =?utf-8?B?R05ZdUl1bGx1K2R4MXBuQjA3RFhTdkMrVVhURDRZMzd0Vmt4ZWdHVWoxVGFG?=
 =?utf-8?B?K21kWnZkLzNteWxmU1QvQ3RjdklSeklpdU5uNnN1YllxdlVXZVlWdkt0TURI?=
 =?utf-8?B?ekFYQ2tBWlRLY25KOFJ3ZWJ0NEdpUGZ4bXBIcVNvd05ncDZzODM4MEx0RFI1?=
 =?utf-8?B?dm1FL2doU2hINGxEaHhEbTZkbGZicnI3TUV1Tmp6cFIydzV6VDJEZnZHVGZu?=
 =?utf-8?B?SGoyVU9EUm01WkM4Y0QxZDNnbWw1aTVudUl6SCtic1NFYlV5KzdKTWRPVUIw?=
 =?utf-8?B?V09jNkxwWFY5N2FReXpIUXIreVp1RGlMa3Z4TnM0MVVuWVI4eHdSc3ljNkd5?=
 =?utf-8?B?aXBPWm1KVjRTVmpING56blNqWHZWdm5WcGUxYWNhQ1crQ2pVZmFSRUhNaWVl?=
 =?utf-8?B?bGNmeWw3dXppWGN1K1BaZ2dRT1RSV2paM3J3bCtHZUpLVkd1eUIzQk4zWW5q?=
 =?utf-8?B?RDlPdnpienFzNHRxSml0TDZ4RitiWUlhVnNKOCsxbU9oZzI5b0psQUxrN3FB?=
 =?utf-8?B?VXZsT2txeWw4Ung4RmlsQWt4a0s5U05oZXR6MzdHOUFqcTJSWXphSUVUdkkr?=
 =?utf-8?B?bFhJdzJJQlRvV3hGSGxDZUFuWW9Ba0JCNU45bkFCa3hoSlBEME95YUFyRmd4?=
 =?utf-8?B?Rnc5bHpyZHkyZDBJdyt6VDVOcGlxM012YjBBRUUzNm1tQ3FIVEhZL0J5T1lS?=
 =?utf-8?B?WjFvS0R3WHErZzZ4Znk1ZmZaWG1sTU5WWFlTQ3FpZUxza1hTN3RMeEF1ekNW?=
 =?utf-8?B?bG1IR0F6VkNaWDN5NFpOQkN0WlJUM1lDaEVOOUJNeHZIMGY2ZXdIZGUzcjFl?=
 =?utf-8?B?a2pDQndGV2crdTNOcENCRFpoTmNNSGkyWm9pOFpiRms3dXdkTTZ6c2NEMWtF?=
 =?utf-8?B?YTAwamU5emQxU2F4eVBiQmQyNWZkaUZhUGcvNWwwaU5xWis3Vy9VM2J5ZlA1?=
 =?utf-8?B?aHYwMUFWSXBDR1M2UDBORG9scldzbHdxRFVKTnR2ZGpxTGdBQXNpaHU1UGVK?=
 =?utf-8?B?Tm5JN29qNmhJVUxwbFhqVHp5MFFTZ2QzemlpNkVtdXAvTkwzbkpwcFBJRWpj?=
 =?utf-8?B?RWJ1ZW9LVHRiMHhJRHN5eDQ1bUp5S2RmbTlvY3VkQWd3KzRvcWlvSzJ0QUVq?=
 =?utf-8?B?eGNaRTMrR3M2OTNiQVlrWGhBaDBvVmhTcmEvbWFkWWlId1JUVkwyaUR4dldQ?=
 =?utf-8?B?RHBYbEVlTnZqV0hXY2JldUpMZ01LMU42UTVMV3A0RDNhbWk2Rnd6S3NiSWZK?=
 =?utf-8?B?WVQ5Z3BEUVdSVVNsUVBzdGllZ3JnK212TWdmWlNNVjFtZUxKOVYzdXpZZ3RZ?=
 =?utf-8?B?S1NZeXQ2aHU1cEhjUUcySGt0blBSeVlxRk8wYm8yell2R1dueE1CQnVWSG5X?=
 =?utf-8?B?QkJtT2FobFdWR3JiS3hWWThUTEtMZmZscDFIS0hJa0p1SFhZMTcxNzcyVE1J?=
 =?utf-8?B?L3hVQmRRazk4SVpka0Z1NldRanN3R2UxWFRzdFJDeXY3MGxIK0wrNEtTUTlG?=
 =?utf-8?B?S3k5OXFhdHVYbWhnK3Z4c1V3Y1ZqSFVSWkJNMmxyVHUvcTEwbXZsRHdiNlBH?=
 =?utf-8?B?blN0Z3F3cldraVNRNW10TWMrRUlPVFdQdFVmRituNjJwbzVhbXBzc2xBZS9C?=
 =?utf-8?B?RHBBTk9yVnMyMnhGQkRHK0RVdWJnWURmTmszQU9SYkRZbng3aVRUSkFudHJn?=
 =?utf-8?B?MUVHZkRHcW1vcmdWRWpQMUU0WE1haUs0dmZ6UDVCbXhZeTlON09EK1AweXlj?=
 =?utf-8?B?ZEQveWt0eU9rZkRuOHR6K1hpVDF3by9JUXVzSG1Fa2hJUkh5YzhyZURXaWRC?=
 =?utf-8?B?aTZQMnU3MlhTVGRIV1hsUjVGTjZDbzdQNXo2VGZ2bytaQit3MGEvTzJxWlVM?=
 =?utf-8?B?YkxjR3FPSEJnNmZLWEJBRC81SUYrUnJCWHQ4Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RCtoSEdSd01SSlR0Z1RmL1YvVUFqU2F3QjcwV3ByVlVGeW9sZTBmRXhTK2lp?=
 =?utf-8?B?ck5SaGRmMVNhU0R0K1Y2UDFtVjFMOVprOFQ3VmxvWkptQUVZeTJQdHpwdU4w?=
 =?utf-8?B?b0FQZ2RTMFV0UW5sQVFaaTVON20reFpaTXp2MmZaOEE2R243bG5vNGhSd0lE?=
 =?utf-8?B?cjVyay9rY2tRMXNFalExalQxS0U3c29vbzFSZzBPenViYXZzbkpyTVV0WmU0?=
 =?utf-8?B?K2E3ZC9tdmtScXU5dTdlUUdhKyt2eDlyTndtaHJMM3FINFU1ZXhNSFBOTFh6?=
 =?utf-8?B?TkNRTlN3SEd0Q0NvcGhWMmFMQmFKV3F6MS91WFJCWXVyZHdsenEvZUFmYjlz?=
 =?utf-8?B?VUtqOUhieWp3TUgxRHJuOGJZTlpWbVhWK3IxbVVGZUFFemRIckFKVVhIVlVN?=
 =?utf-8?B?Q2ZiWDU1QWludlB4QkFKckYyK2hKRDNZaXlyckR6aFZLVWQydlhubUJtbHhK?=
 =?utf-8?B?NjV2alU0TzE1MGZFSWZPSW9xalBGT3o2cU10RXE4ejI0VHRTTE9qSG55MGEz?=
 =?utf-8?B?WXNlaThTZk5tS0Radld1b0hUd29EOEJjV2h6b2UwYmRlbXl6WVJQWi83NG5I?=
 =?utf-8?B?SUdVS1hsUmE0akEyNW1nK05oUWNNcDE1bjFTUStYTUZtcCthck03dGJEeUFy?=
 =?utf-8?B?bUk0di9uOGNpNDJBaXczMDNHcEM1Zks2TjBVVlkreHFFa2UyM3ZWTWVSZHhv?=
 =?utf-8?B?TE1teko0NHdhK3VEaVRCR1J1aVZuRFBqdWQ5aTkrQm95T2dsL2NvYmtpMGRB?=
 =?utf-8?B?R2ZTeTJXTkl6bEw2YkEwOEdkT0lHSmExRXF2OU4vdGFoMXdCblJxaW01ZnJ2?=
 =?utf-8?B?bXFzYTdFRGFPeGtnNzdiWUdpT0FFajZLWlVHeFgwWmFuTWZmTlV6NE9VbnlD?=
 =?utf-8?B?MGdGaC8wNGFaaVk2RTM3aEloanFha2ZBV2hhaW51V25yUXpVNnNscTZXTmlp?=
 =?utf-8?B?Q1BLbk1LNTdta0tZVG9laDJaL2duTGRidWNSRlIwSmNvb0N6MGJOWmN4SWFU?=
 =?utf-8?B?ZWYvdEx2Wjl4S1dhblhtbDhObFdpV09BTE1PRW1TSVdIeDV2TUc0K2p4aXUv?=
 =?utf-8?B?RWRvQWdQNjlNb3BXbjRVZy9KNE91S3QraXhaZkFuQVNSSUlOWER4NDRpMVBi?=
 =?utf-8?B?UHkvUS9DSXFERXNsSlY0NUxUekNTdUlaVDhxT2pHajFPTTVyL3pCVzl5eGFk?=
 =?utf-8?B?SXdtRXAwTEZLQ2Erb083RW9tNnE3WVpsQlFkTVVjVEZ4dXljQkY4dnZ3M0dn?=
 =?utf-8?B?REVRSElQYXlkck5DODlhZXJORHZVemtqU0JNL1FRQ3g1aUlmZUtBbCtnZk04?=
 =?utf-8?B?TXN1WGxrUnVJVWdIaG4xalhiYjJrSDdVRCtDT0RYTjdtbm5IRmpPQVdmR2sz?=
 =?utf-8?B?bitCTmFuL3prTGVlWk5CaVQzMjYvdWhETTFhbVNCbUpJUFcxT2lSNFg0VXdQ?=
 =?utf-8?B?dzF3YlAvWHVDb2c3aVZIenJTR1VidXBnS3pVN2F0RnQrS1hhd2NCczR3S1hm?=
 =?utf-8?B?UzVvNVlUREVVdXppZVpmaUxqWGFOcmhFQnk2SGZnOTU4c2lhMnl0dUJaR1V5?=
 =?utf-8?B?ekQwRm5ERDN4RjZISVJxeFFVMUJsYkxSNzFTaHk1ekNqcFdSNVFRT1FWUGk5?=
 =?utf-8?B?M0pIdUgxSW1ZREdSMHQvS0NuVjA3bi9OVHJEKzRnNzF4d0YrdkNHSVFISU5p?=
 =?utf-8?B?bmxCZmpiandOcFhGVW9CNGtvSHhBYzVyVHZEeE44emFRMEFiYUFMR3RhUE9r?=
 =?utf-8?B?YWQrTTZJeVJLSmpURFRSamNqeTl2aXJOazZ2dzZjbzF6RTdaRmpEditwUlFy?=
 =?utf-8?B?NlZNTXVUUm1oZjhtLzJieEEvaVJDV1VlaGU1V0xDT2pmd3RuRXE4RkpKODZK?=
 =?utf-8?B?M2N3cHd5NDBrQ0l5THF6bEtLd1BIa254OEswVFZ6RWlNVkMyWllvSkpweXc1?=
 =?utf-8?B?dlR1czBKaXNLaGx5Z0VMYVJjODY0UlRuV1VrazkxU01OMkZEdnRvSXZkbkZS?=
 =?utf-8?B?cmFaTUVibDlhMm11TjJQUUhldnZJV2VTZ3M0ckFzOStMQjFwaW1QQzY4MEVU?=
 =?utf-8?B?b05pVm5Fcnkvb2pqb05pay9PcFV5eitqVXZpRjFPbmVuNkdkY2FodmtMNktx?=
 =?utf-8?B?K0t6cHJCWHFrc09EVHhJT2wveWQ4bERWNnJNa0Vkd0I1RGJVVW42LzZIQkNV?=
 =?utf-8?B?UXNsVFNBZUtONkJSTDQ3cFZ3TjJnY241WnJCL0kxcTd5QWduQTdSb3lnTlR1?=
 =?utf-8?B?aTFPSnJPQnFxQXg5aUt4aFlpVzZBVkpDNU1ESmhIRnpIaXIxalNHY3RTc1h5?=
 =?utf-8?Q?KhgR04PimrMVXhCTqc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56d3496-d3a0-4c49-3576-08de4fbba547
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 20:14:08.4720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUa7ivKZn5zVqGCzL6YKdpEr2rwUDH5NGmrZHS4n/CpPSBGooEEbXNBFr6jxQ7f9intRX+TUNdhAGbnSciuwGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9106

Add trace support to help debug eDMA problem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/Makefile        |   3 +
 drivers/dma/dw-edma/dw-edma-core.c  |  12 +++
 drivers/dma/dw-edma/dw-edma-core.h  |   2 +
 drivers/dma/dw-edma/dw-edma-trace.c |   4 +
 drivers/dma/dw-edma/dw-edma-trace.h | 150 ++++++++++++++++++++++++++++++++++++
 5 files changed, 171 insertions(+)

diff --git a/drivers/dma/dw-edma/Makefile b/drivers/dma/dw-edma/Makefile
index 83ab58f87760831883bcfad788306e1722634a83..3e31e7d92f3ecb577136bbb0e430801b6f8ff2b3 100644
--- a/drivers/dma/dw-edma/Makefile
+++ b/drivers/dma/dw-edma/Makefile
@@ -1,9 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 
+dw-edma-trace-$(CONFIG_TRACING)	:= dw-edma-trace.o
+CFLAGS_dw-edma-trace.o		:= -I$(src)
 obj-$(CONFIG_DW_EDMA)		+= dw-edma.o
 dw-edma-$(CONFIG_DEBUG_FS)	:= dw-edma-v0-debugfs.o	\
 				   dw-hdma-v0-debugfs.o
 dw-edma-objs			:= dw-edma-core.o	\
 				   dw-edma-v0-core.o	\
+				   ${dw-edma-trace-y} \
 				   dw-hdma-v0-core.o $(dw-edma-y)
 obj-$(CONFIG_DW_EDMA_PCIE)	+= dw-edma-pcie.o
diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 5aacd04bd2da4a65aabec48f6631f6f8882eecfd..339e372eb8cf60c3baa0de3e3576865e27d91716 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -111,6 +111,12 @@ static void dw_edma_core_start(struct dw_edma_desc *desc, bool first)
 				     chan->ll_head, chan->cb,
 				     i == desc->nburst - 1 || free == 1);
 
+		trace_edma_fill_ll(chan, chan->ll_head,
+				   desc->vd.tx.cookie,
+				   desc->burst[i].sar,
+				   desc->burst[i].dar, desc->burst[i].sz,
+				   chan->cb);
+
 		chan->ll_head++;
 
 		if (chan->ll_head == chan->ll_max - 1) {
@@ -141,6 +147,8 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 
 		desc = vd2dw_edma_desc(vd);
 
+		trace_edma_start_desc(desc);
+
 		if (desc->start_burst != desc->nburst) {
 			dw_edma_core_start(desc, !desc->start_burst);
 			ret = 1;
@@ -193,6 +201,7 @@ static void dw_edma_ll_clean_pending(struct dw_edma_chan *chan, int idx)
 							    DMA_TRANS_NOERROR);
 				list_del(&vd->node);
 				vchan_cookie_complete(vd);
+				trace_edma_complete_desc(desc);
 				chan->ll_end = desc->ll_end;
 			}
 		} else {
@@ -348,6 +357,8 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 	}
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
+	trace_edma_tx_status_info(chan, idx);
+
 	/* check gain because dw_edma_ll_clean_pending() may update cookie */
 	ret = dma_cookie_status(dchan, cookie, txstate);
 	if (ret == DMA_COMPLETE)
@@ -609,6 +620,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	idx = dw_edma_core_ll_cur_idx(chan);
+	trace_edma_irq(chan, idx);
 	if (idx != chan->cur_idx) {
 		chan->cur_idx = idx;
 		dw_edma_ll_clean_pending(chan, idx);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 94d49f8359b99a9b0f8ca708edf81ca854dff4c2..ecc08dc0d34f4a86cc739dd12a1ce46ace58045c 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -140,6 +140,8 @@ struct dw_edma {
 	const struct dw_edma_core_ops	*core;
 };
 
+#include "dw-edma-trace.h"
+
 typedef void (*dw_edma_handler_t)(struct dw_edma_chan *);
 
 struct dw_edma_core_ops {
diff --git a/drivers/dma/dw-edma/dw-edma-trace.c b/drivers/dma/dw-edma/dw-edma-trace.c
new file mode 100644
index 0000000000000000000000000000000000000000..2620ad61a9436a8d21b2408f3613c585fba0d9bb
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-trace.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define CREATE_TRACE_POINTS
+#include "dw-edma-core.h"
diff --git a/drivers/dma/dw-edma/dw-edma-trace.h b/drivers/dma/dw-edma/dw-edma-trace.h
new file mode 100644
index 0000000000000000000000000000000000000000..3be77b42b04947407536523d1535d1eb7d9bdf71
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-trace.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2023 NXP.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM dw_edma
+
+#if !defined(__LINUX_DW_EDMA_TRACE) || defined(TRACE_HEADER_MULTI_READ)
+#define __LINUX_DW_EDMA_TRACE
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(edma_desc_info,
+	TP_PROTO(struct dw_edma_desc *desc),
+	TP_ARGS(desc),
+	TP_STRUCT__entry(
+		__field(u32, nburst)
+		__field(u32, start_burst)
+		__field(u32, ll_end)
+		__field(u32, cookie)
+		__field(u32, id)
+		__field(u8, dir)
+	),
+	TP_fast_assign(
+		__entry->nburst = desc->nburst,
+		__entry->start_burst = desc->start_burst,
+		__entry->ll_end = desc->ll_end,
+		__entry->id = desc->chan->id,
+		__entry->dir = desc->chan->dir,
+		__entry->cookie = desc->vd.tx.cookie;
+	),
+	TP_printk("chan %d%c desc %d, nburst %d, start_burst %d, ll_end %d\n",
+		__entry->id,
+		__entry->dir ? 'R': 'W',
+		__entry->cookie,
+		__entry->nburst,
+		__entry->start_burst,
+		__entry->ll_end)
+);
+
+DEFINE_EVENT(edma_desc_info, edma_start_desc,
+        TP_PROTO(struct dw_edma_desc *desc),
+        TP_ARGS(desc)
+);
+
+DEFINE_EVENT(edma_desc_info, edma_complete_desc,
+        TP_PROTO(struct dw_edma_desc *desc),
+        TP_ARGS(desc)
+);
+
+DECLARE_EVENT_CLASS(edma_ll_info,
+	TP_PROTO(struct dw_edma_chan *chan, int idx),
+	TP_ARGS(chan, idx),
+	TP_STRUCT__entry(
+		__field(u32, head)
+		__field(u32, end)
+		__field(u32, total)
+		__field(u32, index)
+		__field(u32, completed_cookie)
+		__field(u32, cookie)
+		__field(u32, id)
+		__field(u8, dir)
+	),
+	TP_fast_assign(
+		__entry->head = chan->ll_head,
+		__entry->end = chan->ll_end,
+		__entry->total = chan->ll_max,
+		__entry->index = idx,
+		__entry->completed_cookie = chan->vc.chan.completed_cookie,
+		__entry->cookie = chan->vc.chan.cookie,
+		__entry->id = chan->id,
+		__entry->dir = chan->dir;
+	),
+	TP_printk("chan %d%c head: %d end: %d: dma cur index: %d, complete cookie: %d, cookie: %d\n",
+		__entry->id,
+		__entry->dir ? 'R': 'W',
+		__entry->head,
+		__entry->end,
+		__entry->index,
+		__entry->completed_cookie,
+		__entry->cookie)
+);
+
+DEFINE_EVENT(edma_ll_info, edma_tx_status_info,
+        TP_PROTO(struct dw_edma_chan *chan, int idx),
+        TP_ARGS(chan, idx)
+);
+
+DEFINE_EVENT(edma_ll_info, edma_irq,
+        TP_PROTO(struct dw_edma_chan *chan, int idx),
+        TP_ARGS(chan, idx)
+);
+
+DEFINE_EVENT(edma_ll_info, emda_terminate_all,
+	TP_PROTO(struct dw_edma_chan *chan, int idx),
+	TP_ARGS(chan, idx)
+);
+
+DECLARE_EVENT_CLASS(edma_log_ll,
+	TP_PROTO(struct dw_edma_chan *chan, u32 idx, u32 cookie, u64 src, u64 dest, u32 sz, bool flag),
+	TP_ARGS(chan, idx, cookie, src, dest, sz, flag),
+	TP_STRUCT__entry(
+		__field(u32, idx)
+		__field(u64, src)
+		__field(u64, dest)
+		__field(u32, sz)
+		__field(u32, id)
+		__field(u32, cookie)
+		__field(bool, flag)
+		__field(u8, dir)
+	),
+	TP_fast_assign(
+		__entry->idx = idx,
+		__entry->src = src,
+		__entry->dest = dest,
+		__entry->sz = sz,
+		__entry->id = chan->id,
+		__entry->dir = chan->dir,
+		__entry->cookie = cookie,
+		__entry->flag = flag;
+	),
+	TP_printk("chan %d%c %d [%d] %c src: %08llx dest: %08llx sz: %04x\n",
+		__entry->id,
+		__entry->dir ? 'R' : 'W',
+		__entry->cookie,
+		__entry->idx,
+		__entry->flag ? 'C' : 'c',
+		__entry->src,
+		__entry->dest,
+		__entry->sz)
+);
+
+DEFINE_EVENT(edma_log_ll, edma_fill_ll,
+	TP_PROTO(struct dw_edma_chan *chan, u32 idx, u32 cookie, u64 src, u64 dest, u32 sz, bool flag),
+	TP_ARGS(chan, idx, cookie, src, dest, sz, flag)
+);
+
+#endif
+
+/* this part must be outside header guard */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE dw-edma-trace
+
+#include <trace/define_trace.h>

-- 
2.34.1


