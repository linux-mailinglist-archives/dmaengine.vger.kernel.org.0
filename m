Return-Path: <dmaengine+bounces-12408-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KbmAFAgcVWotkAAAu9opvQ
	(envelope-from <dmaengine+bounces-12408-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:10:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5AC74DE26
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:10:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=kpSjysxl;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12408-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12408-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE78E317DA40
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27083446DE;
	Mon, 13 Jul 2026 17:04:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013071.outbound.protection.outlook.com [40.107.159.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11360344052;
	Mon, 13 Jul 2026 17:04:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962245; cv=fail; b=DPs4FXazPtkHl1C6eN4q3YtRx05iWIblW5T3Kv0qRJ8Sor9ExT1oAMMAdDOSr8HWgfAB9G7VCD6eYFSTc+6cGrfzcWApNwqNoOIYUFHZvfbJlp879DJ4bn81GN83wnG4rBPgzjsn52Nclm5ZVi7M7OAVRWOWOkSF+6AtzWm2bTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962245; c=relaxed/simple;
	bh=XgU71pUT/KCeZU0U6ewuYFUOO25aUcdHqgL5XWxadbU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UHQS2SLTff8bNJrQnqfYkrRL+pvjyLur3fUvK1SvGHC1Gs1a1rz6IAEJyXpLt2K3O97bZCgYM1GGEcg4w1qcRMR/edwOYoJpZouDBRej8PVusa3hVfR/vWKRQsgtdkIYuXg6mz1XfUK85NI2Ob33DYQIPfJ1UD4SCQZXKUAYTRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kpSjysxl; arc=fail smtp.client-ip=40.107.159.71
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmC+k+RsNq6TDjDpunNJxJXy1X4Vj3/CekBScjEN13GWOxZiW1PlmXwwq0e938n7ffk+AbwNUvEytmqNxhpXOsVDvfWDXMc1P8NwDCBT19tkO9bLkFc8S+4pG7unwqxh7ah9e3ooDD2ppqLiSprqYJ/vCVpD5NIaR+sB0GLFg0LJgAG4chVwXWaLIoIy6OvgK+DgEr3Vr2J1Gi0PTvbdI/dBg4tm1mkifIrWze63T2momwH65iIU8GtmS7o/u+uJ8cXsKPGP1etTBWh/OWrBpQLFEdmOfslLP1lr7/ZhCR3/ra1799AcPvq13QvORhGRf8i68w/EoOdDbnyeBojm/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuUzXrF9q5+NhxxCA45oJSm5gtJKgjn2+nefs1DTR7o=;
 b=ZrPYr+3v7UXCXNyoi5B/eT9OO+TelhvE13dg9XwOUXEoto58bnribjGhf1vKbEDGJRSJFTe1z5UVC/WRbJQAnwsc+t6chfksXZvo5LDNkOXwuPu/BOeP3pANRK9BxBh+VJy9I3WBibrZ0NV0v8EkI7cendAjv0DXVKif16vYO2eY/PpWq+h0pJi7eEIVhkPYR/yxOWnoWhvcPcD2e1U8ygRcLWYLYmciYts3JJStHv17toerMQSjmI4/e4suJTpyBajp4YuaAObTQ5SvsA35z7Q1XsYvHdqUWO7z2RIkS0jgcWqpJGhkeGma7DZIGBtSStXrVlVIk+UAy9ClikUZTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuUzXrF9q5+NhxxCA45oJSm5gtJKgjn2+nefs1DTR7o=;
 b=kpSjysxlM0542nfdNA50LFl8o1NTgqxOvjvqSxD5m0kGNdGdX4saXEdD4voThBM4e5/OXLZLOERN88EeMvImc/OFVthJSGeMPrTwwibciLY47Gn9sru+TfIkMFOqzFdwGsI6gahVTO4mskaUxjMZHsowyjRddDzG0Vvrcapn7qPYxR44VoQ7DWUsJ4e40gY3mTCaiYTA1l5Lyph5LjM47rhH2ZSDHzNM9PVH7wdHidx7q2+4yu8AZ40mE05qzGuDS8oK5ezrDyi0eMrQxGj3VPCPPYejILwC/9GabqyIAXhriuZ+VIDBvByn8ESUsHWCO/I8ukia+nrPw+mtWPFf8w==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10228.eurprd04.prod.outlook.com (2603:10a6:102:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 17:04:00 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 17:03:59 +0000
From: Frank.Li@oss.nxp.com
Date: Mon, 13 Jul 2026 13:03:25 -0400
Subject: [PATCH v7 07/10] dmaengine: dw-edma: Add non_ll_start() callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-edma_ll-v7-7-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
In-Reply-To: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
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
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>, 
 imx@lists.linux.dev, "Verma, Devendra" <devverma@amd.com>, 
 Frank Li <Frank.Li@nxp.com>, Devendra Verma <devendra.verma@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783962202; l=3734;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=beK3LZn8ZMDqfLRn7/Lq3YRDZ54vqb5FL3Y8sq62qQw=;
 b=T+i4jeE0MYja9BXNUO6EdkcurMyHBDXvkdUCvlaL7S9hg9Hwv3ow/EKs5Q8HAiy+ku1Hnbkdc
 nPxj2L9vYGgC1HjNB+xVwCPNQRqjFVNPh6WPU9PPoZR/Avm1lfXyMz5
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7PR18CA0020.namprd18.prod.outlook.com
 (2603:10b6:806:f3::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10228:EE_
X-MS-Office365-Filtering-Correlation-Id: db18bd55-6394-4042-c067-08dee100bb7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|19092799006|1800799024|921020|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	0Spi9dR2aB42glj5VqOwlrY8x9FAv4HUeObc+ebvQifpZaJiRehGsU85Y9ktGOm57qrvsT3919lrVNxO5O0GsveLnmMg8Yxvws48SXR52yskJgmtFo4UUAycOW3nK9YacQGnGKe8P89zGOAw2Q8tXUXMg31qEV5QbnGFgAy2r2mcLrbjFSFNmizLZ7pCt4L2UrfCVtbcXojuJdt3qlHu+gIzXLt+xiHjTrFSeZWFvRbmyUCputA+qwr+gpu/aC+8cLBnhy5HRFJ3yWTMt1b7HmnymLJwRS6JrmbkQhH0X8zuIuYhORfHUNZ9OzVRtzOuxqfi74nteHPk/h3bvSKekyaqwyLpC+q0VvG8WsM1XIgkhMCoTqoufGLy/orC0raq8Yx/mc/YiTBdBbMOGzhxj9B9m3eLljUeFSoM6bGSDSo0+O1AN3vr/Beu0c3SLFbuxSUOtm2XJYNYIcHyPXfbndlMiIPFdeFh6DpONwvLgG7C+2xr3ri6O0bOUjtcHVTDdtPVpRp5WhAeQJoU5p15kqmEKVHrZ/hGMnwVlfAZP05OdX/rRP2L31saqu5ozF1AvflOgii1SArTlCZu3C48MsNQl/pHBp58GZIkRkCHM94dDZQM3JTYLme5sM26u+DB1saecktMvuM1hClKxTyVZtWJubSdGIvyI1EiaRXtt/0kkvwmnrePTOafsFGTbUPIKe26se9nhZRpaSj88KRq3g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(19092799006)(1800799024)(921020)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDJmWllISkRLaHN3d1J4aTd6QjRLMlVHajhlR3lTRXhqVEtwcUVrLzVlUUVm?=
 =?utf-8?B?ajV1WTVRSlVXbFl4MlppZHd6VGpHOEhjYzJZMHNQRkhYaFFobzBVQkNVWG01?=
 =?utf-8?B?ei9LbmhpMmtBQ0VXR2hML3RoeUd1TlF4ZFl2Q0JjUGMyakNHZjhGZkE3OFY2?=
 =?utf-8?B?OGVUZExUQ3pKNDEwQ1grODVDWmF4ZC9HSlYrTDBvRC9tM3Y5REZPVlZXdHdD?=
 =?utf-8?B?RkNEOG43UWxDSDdiSWdoL05Ncll2cDlJcFNYbEpHVVNEZ0tsZTVaUDlUK2dy?=
 =?utf-8?B?ZG9LUFp5UkdtS1AydHh4cEw2bjFmaEZ2YWRGdm9uSk9vTkpiZ3BSK3dkZHhX?=
 =?utf-8?B?NWlXL2YzdmZ2ZndhaVFBNXhwK3ZNM0llMVZSb1EvMHJEV0hlWXVlK0o1cXEv?=
 =?utf-8?B?d0pqYUlyTTQvU2JQdXNnVkwvalQ2OGRJTXUzYWZFOWVjK0EzTVZiK2QvVVdr?=
 =?utf-8?B?NHJxdVlKYW9rb3FObktSVUZBb2N6Q290VEZVZEhPRStudm5SUlFFTDdoUUM3?=
 =?utf-8?B?KzdxelhvQ1RpQWxzeCtrb2tDM0xnRGZpWDlrUEc2UmFtUWVBS0pHUlhoekhz?=
 =?utf-8?B?Y1dkUTVvNFhQOEFCTk5Fb1A5WGFOaTdLWkVHY1hmNmlTNUVxU1NxSGIyOXBX?=
 =?utf-8?B?ZThKaUNKeTJBN3pmT01Tak5FQUR5akxsREpLUDZ5NGdaQ1gxbE5lWjFweWNo?=
 =?utf-8?B?Y0wrSDg1RExVby83ZnJCZ21PTzdub3EwTlB2LzhQbzZjWVM4T01raUlGNXA2?=
 =?utf-8?B?TnVDd0cvbVpacXpNS0NSbUZRbWFJRVJ5MFExU3pFVTliMkFnSEhxbUtzemFJ?=
 =?utf-8?B?YzUzQUJzZmpqcW0vN0RCaW12STJEcGdSNExCVnoxMW1DNjgzb2N5SFk0Smp4?=
 =?utf-8?B?M1JUSXlKQ1Zwdm5IcE00Z0pxeURxTmdEdktqandMOEEyVW5mS3psem96a0ky?=
 =?utf-8?B?MXNFelNuTVBlanREQVlzbnF2U2JzWWJ4MkZxajRVd3pOSDVRWmcwMjBPR2Yz?=
 =?utf-8?B?QWl1a3poalhwV3hUU3RpTXliOVQvazBWK2JOdUtWZ0tMbHppM2liUkxZOU5a?=
 =?utf-8?B?SEwxbVduQXdGcXZVd0krb01pbkIwbE9mRTJpSGlmYmNQT1ZlZURZbHhuK0dQ?=
 =?utf-8?B?a0d0SnZJbERtd1EwY3QwNjdmcmk5bkN0Yk5VODQxUkh5VUFEQk9sc1VmMHlZ?=
 =?utf-8?B?Uyt3VUVRYmxWbmZTREx4cFNiSUpYWktPZ0JadWYvbVhaZFlzMThHT1NVdWhP?=
 =?utf-8?B?TW1GcXk3MGJCeTE3eU5xZTYxbm5IZTVwRlQxZ0hyeEVHUjBuai83QzREN0JT?=
 =?utf-8?B?OFFoWG5mMEpKTVliTFZLZFpwYzhBMCtaOEdwQWlOdC9CMkxhNmdWOEJIMll1?=
 =?utf-8?B?S0w5R2EvVzVlRGsyQzJ6THJacHQ4UGlkWE9JL3d6NEREbTIveWg1emlvckti?=
 =?utf-8?B?RC9ubzN6SWplNkZaS3JRRmtibWhzL1JMZ2NpL2hjUzlSUm9HdUlPOThaMGRP?=
 =?utf-8?B?bmpnOC8reXIwUDdvT2hkVDZ4V3RZLzJFcnptN1RSRlkzeUZGNjhRZkpleGxM?=
 =?utf-8?B?cHFpSTQyL2s0U0JldHJpQ2RpVFQyVDkrZ3pSMjV1OTE1LzlkdlZ1anppQ2dr?=
 =?utf-8?B?a3BDS2krdEJES01mMk04eW9tYk53eU1vay9PZWNHMFBSMGxHKzhtNlJWMjdu?=
 =?utf-8?B?bDQzU3o2NzJYbEJCVDhFNEw5QmdxV3NXNFpla3FYeDh3ZEpTZVFZNW15OG43?=
 =?utf-8?B?V3ZlbGxxNjBnUW50QklXVm0vUyttbDFCMDFzdTRPTnc5M3huTG1JS2RjVnEz?=
 =?utf-8?B?SUxnSGh0WVloZ3RkcjFReWVLVGUySkgwMGRqQ3lIUXpKSjlZcnJ0aVI0QmRh?=
 =?utf-8?B?THJyak1SQ2x0L1lhZGQwU0tBcThzRjNjdUpESmxLOE0rOHh3K3dLU200REti?=
 =?utf-8?B?WWRhWGt2cWpTSnkxRmpPT255a09xVU9rZTNGbkkvLzhmQlF4WE01ckFsNlRa?=
 =?utf-8?B?Nm1OMFQyNkRKaG1TaVUrTHZ5M2hzVFJBNHljWHFtN3liR1ZWaGlJR2tibWh6?=
 =?utf-8?B?S1hVdzQ3Z3MxU3B1OXhiZVRkRDAxYWpTVjhySDFmTklJZXByN2J0ejN3bkhB?=
 =?utf-8?B?RjN3YUdCUExNeGRIeXZHcmwrclh3SUNHaGxsbmNQTCtuZ1VEaUNHNUtvR3hZ?=
 =?utf-8?B?cjBpRkQvS1lUWG84VjdQOVBUTXQvNFBBQ1hnRjErUTZMdCtHNkx2SjlyNm0x?=
 =?utf-8?B?bFZoNXR1dXd1UktuL3RwUXBWZjRydUk3M1RZL1phK09PSWZnWUovcW1OWEdI?=
 =?utf-8?B?WnNvekZES1VPR2pzdEIvUS93N0l6YUlqTExXSUZOcEhTUlBXZ1FIRlk2N0N6?=
 =?utf-8?Q?j57ltaewvm+3vUPZvImv63efDgXrXEhhCcwAx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db18bd55-6394-4042-c067-08dee100bb7a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:03:59.7519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kI7r+nua+XR9wFq6jD/1sc2iTW1ByKqzCf+uZncixtZbgt3V0sb1QL/lKzulHaMIGz5xDokp/y0aZLS6sWoBEvq/Q3kjy34VqpK6f0+XW057cGBH/uP5whDf/lGaqS7y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10228
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12408-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,m:devendra.verma@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,oss.nxp.com:from_mime,vger.kernel.org:from_smtp,valinux.co.jp:email,nxp.com:email,nxp.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD5AC74DE26

From: Frank Li <Frank.Li@nxp.com>

Add a non_ll_start() callback and move the common non-linked-list channel
handling into the EDMA core so it can be shared by both the EDMA and HDMA.
Prepare for the upcoming reorganization of the burst and chunk structures.

Tested-by: Koichiro Den <den@valinux.co.jp>
Tested-By: Devendra Verma <devendra.verma@amd.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- add koichiro tag
---
 drivers/dma/dw-edma/dw-edma-core.h    | 12 +++++++++++-
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 23 ++++-------------------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index bab4d49c92feb..e18d6e827c2c9 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -126,6 +126,7 @@ struct dw_edma_core_ops {
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 				  dw_edma_handler_t done, dw_edma_handler_t abort);
 	void (*start)(struct dw_edma_chunk *chunk, bool first);
+	void (*non_ll_start)(struct dw_edma_chan *chan, struct dw_edma_burst *child);
 	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
 			u32 idx, bool cb, bool irq);
 	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
@@ -201,7 +202,16 @@ dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 static inline
 void dw_edma_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk, bool first)
 {
-	dw->core->start(chunk, first);
+	if (chunk->chan->non_ll) {
+		struct dw_edma_burst *child;
+
+		child = list_first_entry_or_null(&chunk->burst->list,
+						 struct dw_edma_burst, list);
+		if (child)
+			dw->core->non_ll_start(chunk->chan, child);
+	} else {
+		dw->core->start(chunk, first);
+	}
 }
 
 static inline
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 16fe3ef43948d..641a513bc52e7 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -272,18 +272,12 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
 }
 
-static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
+static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chan *chan,
+					 struct dw_edma_burst *child)
 {
-	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
-	struct dw_edma_burst *child;
 	u32 val;
 
-	child = list_first_entry_or_null(&chunk->burst->list,
-					 struct dw_edma_burst, list);
-	if (!child)
-		return;
-
 	SET_CH_32(dw, chan->dir, chan->id, ch_en, HDMA_V0_CH_EN);
 
 	/* Source address */
@@ -324,16 +318,6 @@ static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
 		  HDMA_V0_DOORBELL_START);
 }
 
-static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-
-	if (chan->non_ll)
-		dw_hdma_v0_core_non_ll_start(chunk);
-	else
-		dw_hdma_v0_core_ll_start(chunk, first);
-}
-
 static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -399,7 +383,8 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ch_count = dw_hdma_v0_core_ch_count,
 	.ch_status = dw_hdma_v0_core_ch_status,
 	.handle_int = dw_hdma_v0_core_handle_int,
-	.start = dw_hdma_v0_core_start,
+	.start = dw_hdma_v0_core_ll_start,
+	.non_ll_start = dw_hdma_v0_core_non_ll_start,
 	.ll_data = dw_hdma_v0_core_ll_data,
 	.ll_link = dw_hdma_v0_core_ll_link,
 	.ch_doorbell = dw_hdma_v0_core_ch_doorbell,

-- 
2.43.0


