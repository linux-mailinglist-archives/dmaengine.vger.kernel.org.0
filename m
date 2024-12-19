Return-Path: <dmaengine+bounces-4038-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E419F7981
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 11:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B7F1893757
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 10:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB07222D50;
	Thu, 19 Dec 2024 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="H7He/Fae"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678FA22257A;
	Thu, 19 Dec 2024 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603886; cv=fail; b=ctqYW1wD1+mlfdJ7Gqsei0XCIkK/j5QfLlIhAUKXyYJbNRoOEE1xSX79jLlxZtsCdwaOBra7QT7UkffE2ZfWTeO6OiuB4Q7XQiEyHOnABjcCH/LsDIydSocwaTVzMTcUQDDGbHrYgUQkCsurkpqa+UAmDoyrWPnXE+ljti2krtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603886; c=relaxed/simple;
	bh=8BhD0/fjnNlsUFzT3o5yEf/BMFJaWaTfKPf3WYocHFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KsWjr8friKpX9BvLH5/fzV5B7Cmz8boAWRZXTryzNR+XSnfsFEqZVUffcOii5oB12VNTthUu2VwYmoDQ2zWa0wCXQ5UUtTXyZOJ3pxNl/fz+5jTGHrjBSafnLoAyUuI5i99dc0FzQ5vgbYrhyDL7hY682May2tMdMyOYG2DFNXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=H7He/Fae; arc=fail smtp.client-ip=40.107.20.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vY9gk45hd+7/WWIrdyZrSTrXJBTGVxTPuijgNQ0gqfG+SKRsrlAIVGoJtW4ZdRlrHxMsi/q41+sjLwiJqqBThGM+dSUSOE1QZqIPGsZrM9Pr28MhuiXuMTdmZPxBbW1bf50tZNRdtjCxFmfI/DfFdgDQkH1k7IyltGdkRg0ordQ6GB/ehK6XKk/uQQiBZZVSaA8sca5L1/pUe2h6G9cHEMLxOWzblD6Josn6pJId6fdaWlIAejMgmZH+mvKHFZh/ob61JBj25jeARH7YIUExSkoXCOJFQwPLl6OMVaeOCsB3WENiPDevDb6sV7wv5DpDjLPdbGpguIPLOpOpEZFrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLIJ+7nBBLog/Fi2pEuYSaG/9xdVGhxe8g8HDmS8MA0=;
 b=F/dG0S7XEsdh0L0lQImajp7jwYs03nC+nqCV5ZDKELBWxWhcGEVRmKEbKWWG1++FXbw48L6hSsjYURRfuN3tswNciykJ83m/Eb39OQNEs6QlEnAZBt3Uo55YFhpCMYQpapALNo8iQYY+WMDScZubaAZ5O09ClOgDJMoHwAlolT/kbJ9L4BrbRIBIIhm13l8DLV2f3RqASQm6GxGRMyHwJDflguQicnYSSupCbE2a3mj2qllXAJ4QVqmLo7X6117TZoH/Dt+13MgplM3VIeOcT3S2/bQKf+S6RP/gTHbUkdxKt/NjokAF+UVDsYwn4IxCNOyJsR2YvfNfLXI6lnsm6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLIJ+7nBBLog/Fi2pEuYSaG/9xdVGhxe8g8HDmS8MA0=;
 b=H7He/FaePXF1i+Z06nGDxqATkldYws8Ni/Rm/dD0QRRF6jgxh/V0hrDkkKqhodygRPbNGF7ZTOXhW1dkvtKDyNpOX4qDmPOEmnOQvYszdwhuaCuAWEfcZcZDry+PdSUTlE5+0KD2gRRkdHuU2KNoEhwNZvYaeepRdu1GB8LOIoGEZPMHBPRjZJb1/5Wn4KFf12OkDZz1RIFY2PA2T5VFSJ5XCjfOZPfyKcKAgq/pkGJo5A7Rr7rrVFuCYuPXa93Hrl+Hl7+JDXzBBNOcn+S/fj4hEjkzJxrA9q30owC0aVSXKAP0tDKyvBMwjEArhhAtbxGyEgJ9nSeua7moJpr8vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by PA2PR04MB10187.eurprd04.prod.outlook.com (2603:10a6:102:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 10:24:40 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 10:24:40 +0000
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
Subject: [PATCH v3 1/5] dmaengine: fsl-edma: select of_dma_xlate based on the dmamuxs presence
Date: Thu, 19 Dec 2024 12:24:10 +0200
Message-ID: <20241219102415.1208328-2-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241219102415.1208328-1-larisa.grigore@oss.nxp.com>
References: <20241219102415.1208328-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0125.eurprd04.prod.outlook.com
 (2603:10a6:208:55::30) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|PA2PR04MB10187:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb9f512-b46f-4073-d144-08dd201758bf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Smt4RGJ3Y2hGai8yT3R5SXgyNmlvUVpNcm9GeGg3UVJ1RG5UQW9RdFlNZm95?=
 =?utf-8?B?ODFGWUsrc3dzSHhHUnRnZVYwa3hYZVVsTWF5MVBrTC9qdEVSNHpOelE2TTVk?=
 =?utf-8?B?djlrMUhwQnA1QUROOE1USnh5MmIwaEhpdEV2NUVOVTIyUmlBdEZ4TkZSTnRF?=
 =?utf-8?B?NlBRbjdGcEdxb29vQ1BxVU5NcUV2eWFTK2IxUncwVkd5RVltTXlFaU5rblNr?=
 =?utf-8?B?SEQwWGJEK3FLZ2lNK0xzdjhIb1RCdEhtTUx0QlpuSjQySlpUeEQ1VzhGaXVQ?=
 =?utf-8?B?VXRqRGJkeVVJamFoUHQ3Y09kNktGWWVyTHBodzhkcHI5NjJjZTVHQnRkUWFO?=
 =?utf-8?B?ZEFrdE0vRHBzV0YzTk5DYVVldmxDUkJKVCs5TENMUXREcGl5NnBxaVZIVWpn?=
 =?utf-8?B?cFE3dTNOMEF0WG5YaXp2R1pnREhYQjlUT1JpQjROc0s2VlpSUXRqdnRsUHQw?=
 =?utf-8?B?NTFDaHN4NTM5U0JhdWd2Y3U1VzJpM3lseHIyWlZQRkhsVVJsQy91S085T2Ev?=
 =?utf-8?B?UWhVblljQnczN1VqZWllYjdlQ005NFB0S1ZoNElTR3lrNnVtQ0VSVEhURXc4?=
 =?utf-8?B?NVc1ckd2SStSOGh0K2F0Qk81Y0I0Ukp1VGRUckRvUyt0Y0I4SDBrNWZkVWdI?=
 =?utf-8?B?bTVnbTkyL0FreGU0bzg1K3dEcnJuRTlzWkJIQjk1TFF0ZTJRdW1KUld1K0dP?=
 =?utf-8?B?SUwvYXlpSHpzMU1hd1QvTFE0WGhWTjRRSG1wKzFzSlFXcG04NXBQTnc0TW5I?=
 =?utf-8?B?d2ZCVVllc0xkZHNqbHU3QURtT2JKZ0FLVElOdm5sbGducklQMzRtZmtxaVdz?=
 =?utf-8?B?eWh5UWVaRUYyWEV1eERPRDF3YmVKbnpEYTNRdmVZZVBRSUZaZHpWQVJsUm5q?=
 =?utf-8?B?NkxiRFJJZ1ZXTnRSTy8wY21WWDBOMmVKTHNKTmorYzNLSmZsYmhxK1ZMUkJS?=
 =?utf-8?B?VFJ6ekV0U3RKZWFBQ0lWZXIvWXZNL09QT3hDb2Y3WXRZNnhEOTQyOUhMMm05?=
 =?utf-8?B?L1Btd0ZjUXdpS2l3UDBtSDR4VTJRTXdONGYzRG1yOVltU25kNFk2aDZUS3BW?=
 =?utf-8?B?WTBLSnladXV0MUVYS1FoQ1F5czlnS1dDUE5YTXBGVHVUNGpQRXd0L2lrL0NP?=
 =?utf-8?B?U1FCdFB3VTJLRXprVS9QT2ZzQWxIdkZiU2MzMXVMamlmSFpDMUVpUlJQakJC?=
 =?utf-8?B?WVhVd1p5eWdrUTFLdnRkVUZrVkZ3WGJLOTBsYjVCNHY4Snh1bCsvcWRSdzVW?=
 =?utf-8?B?cU5YTm9sZDU0OUVCdnhlK296STBQOFJKNXNaS1JRckE1UW0zb04vc3B1clBH?=
 =?utf-8?B?ZW1BMWFTcVlaVVpmZldoZDBxbFdVdDZmdllqQm0rQis4b0tabUZlQ2R0VjFO?=
 =?utf-8?B?T1BoZG9yc3dQQlMwanRBSklZUCtKdHlxd2RiQVhvNW1NNURiU3JNMlJjR1pQ?=
 =?utf-8?B?T0k5SWoxaGJud1g0RFY5UmtXUFZhVmg4Zzlkck9rZjdFTkRrZmJNTmtrR3Ir?=
 =?utf-8?B?YytFNmIxUklyVk5EblI3VkpVUGpPS2F4L0V3Z21NVDl1Y2dPZUNSWUdxMGFw?=
 =?utf-8?B?N0pXM3puT1hnMnQ3TmhQNTlJa09LRGc0MU5qOFNhNGlYelc3VGZYUlZ2bWdo?=
 =?utf-8?B?T3ZWQzhOejFMa3BnWG5yYWdFWUZOY050QWt2cEtPeWkrZzNGeTFkRHduWkxi?=
 =?utf-8?B?S0FuSWJxU3YzUDhSNER4UHBLNVdCTi9ldXMyNjU5L0xGbHdEdExBZjRFQU5r?=
 =?utf-8?B?UXF4Zm9vVFRVRTYzVmUzczdqaFV6cHB5alFidzZaTnlwNmJnSGJQbHEwNEx3?=
 =?utf-8?B?ZFFQQkhxZnlXOEorNk5MWHZpa0hBdjBJNmhCN0JQUksvclc5MGpuaDNHTUhz?=
 =?utf-8?Q?LMiApCWc8MgEi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzF2c3BqS1ZtRnU3Ui9XWlZvdWFwU2JtaWwvaE1CWVFpOW9PMGpYc3dkRS9D?=
 =?utf-8?B?TlJkdHBSVFVTVUNFL0djZmxYTnQ0T2FuWjVrK010ZDNqaXhoT0IxUFVtSjJz?=
 =?utf-8?B?R29SMWxuUGoyb2Qxc3puZ0tLTXBxeXBxQXRIc3hTNk1kRUNIaEFSTGd6VDg2?=
 =?utf-8?B?K2d2cG96Unc5bXRnQSt4TjU5ckRhb1FXMDdLYWdHZU00MTdhZUZ4VkdYL0J3?=
 =?utf-8?B?WE42SzdhMkNFRmVYN2JTbktHVjh0R0gyNUR0ZEtveWJWcTJIMmhOT0pxcStB?=
 =?utf-8?B?UzV5RFBJbmM0V2tDZVJBWHBtZVNOeDYzdFBNYi9oWko1L0ZQcHhVemwvRW5O?=
 =?utf-8?B?akJaR2d1Y2UzMnRoOG1qdHZQSGQwVW9FbWpBTWhERHRCOWQvRS9nTnB0bnBJ?=
 =?utf-8?B?V3RpRXZpeWUrNkJYS3pxVWlMTVZmTy9LQnZiTzZLVHc1UTdKWVZoMElJU1hR?=
 =?utf-8?B?ODJnZHJ3WmducHpRUTEwSXVCUkhzR3hNTmV2KzlJcitzdktIdlhxSTdPdUN4?=
 =?utf-8?B?eXNwU05NWXFoSEhYTHhZMXpzb0FoM2QyL0wxV1FoVW9nWDYxQ3pidktlbXBi?=
 =?utf-8?B?QUtSTDVHRVhSVkt1RnRVS2ZJRTdTdHJIT01ZMkV5aVpLcGxQaGhVVTFRMUtk?=
 =?utf-8?B?TXVXM3pXYW9jdlhzYWZWeEFSeHczQ3FQSmpEN2k3R2NrUnlsSWlla3o5U3Bx?=
 =?utf-8?B?ZTZyTkJ6djUyTGFUT1dCYjRjaUtqS0JrK1QyWm5yeC9nbnZSa1pMaVBjb2NW?=
 =?utf-8?B?NTk4U2J2L0ttRmcveThuY0dHODJSR1FKNUpVWUFKckp3eVhvbEcxQno3SGI1?=
 =?utf-8?B?cXpzRENTY1NKSk5ueVRzbFdZUEVObWJGc0dVZllkaGY1WmNYT29qTHljMmp6?=
 =?utf-8?B?bTN1Q3FmdlNzVlp1Q3hJRDkzWGFJQmhOa3U2dGEwd20wMHBUbVFLVGZIZ2RV?=
 =?utf-8?B?MHF3RWRkWUl2WFN4VDUxMCsrRnA5cW84Y2hBeGpLcUl1OHBYR0VRV0lpRkNw?=
 =?utf-8?B?MUdYWGhSZEhScjBQa1MyZDJaY0ZRb3JoTncvY0o4UXY3Z3FzV1FiNU1TOW15?=
 =?utf-8?B?NHNqandJRHd3U0ZGeVJiY2t6dURTekRXeWN2QWs1TjAzZkh4ei90NnpaVW9J?=
 =?utf-8?B?eHE1ZTBXaEFqemZZR3FWU0Y4U3NPeDY3bmZiUXRpZjBlOXVxSmpvS1FGUlcv?=
 =?utf-8?B?aDZxUktUby9JL3RnQkR0bWo1LzBldEJFd3pMNjdiQi9Pa1loOGR1ak5CWXBE?=
 =?utf-8?B?YzlrMGRqSExaNGY1V2ptR0VpQnhqT2wydFd0WmdsVFY5bGtYcHdUVzBwdmhG?=
 =?utf-8?B?MFNNS1JPVW5scVJHZ3REbmJIekIrSlpTcGxKeWYyckJZa0tvZUdhWnJ5UDN6?=
 =?utf-8?B?UTh6cHZUUjB3TWZ5eFRvSWxHWnJidE4raWJWZUxRTklYTHlHSmRyZC8xZ2pu?=
 =?utf-8?B?THl5TkszM1BIdm1pQmo3elBpU1ZJOE44QWlIUlRLQWNFUjhENGxzbXFkclN6?=
 =?utf-8?B?cGdXRGxlaUIrSmFJMnVJMzV1SzNCQ1dtWUIrRWNZTlZqY1FEaUZJNEtyN0Qy?=
 =?utf-8?B?ejk4QzRhTnFhOURlZkNBbEhFS055WkIvM09sZnhIU1hUellBd3BTRDJWUnpQ?=
 =?utf-8?B?YWdKVmFqUVIyekhsbWNQSnA5RlpZVUtjOHZWQy9tOTlLTHRSS1JGZ3lXaEtZ?=
 =?utf-8?B?VUREOVFOaGN0YS80RyszU2hBdWF1UGlsR2tnZUhBUVRUMHNGS2VwcXRQdnpI?=
 =?utf-8?B?ZjV6SEF0cHVwVk1OK3dqRnZacjFQa2tvckpxOTdUNzlyTzRWTk94M1VtbEk2?=
 =?utf-8?B?S2RiTmVZMmVhM09oOG9GMkxSSElTQkN1WFVaV2FwYkhGbUlwMFpvRmtPNzVE?=
 =?utf-8?B?NFZYNlVjU1QzS3cxaEFKeDdJUlhBYlc1aVVyQzhTRnMxQU80UUNzelV1NlVG?=
 =?utf-8?B?NDNGckZyQzdTV1puaXJ4L21wL1MxbUpiYy9VSm1EdTE3RHFZbnBBL3FQSjFL?=
 =?utf-8?B?S3o2dlZKZkFZOE9oN1A4M1BwbzJZTi8xRTFLOGQ4ZGVtZ3BOQXdZSldidy9R?=
 =?utf-8?B?ZFgvSmNSQllDRW5PUjRYN3Fjc3RCdFR6OU9VY2F6cEZrMFpoZkFRbis0WlIr?=
 =?utf-8?B?ZmRpQ1EzNm12eGMxOTBWVGF2TDJYVTZNRXpmczhXMHBMZ1MxUVNTNEpiS3J1?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb9f512-b46f-4073-d144-08dd201758bf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 10:24:40.3103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DfSqFRh/bmJSZzxaV50Us0NcuAJ6mZfHb+N/5Khckfu5mLcdRK8v13X0nMGV/N57LKezUWQWaOu7PMy+CNrGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10187

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


