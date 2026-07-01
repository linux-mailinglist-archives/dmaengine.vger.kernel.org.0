Return-Path: <dmaengine+bounces-11920-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NWGZFxbeRGpw2QoAu9opvQ
	(envelope-from <dmaengine+bounces-11920-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:29:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B08266EB9B2
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:29:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=xJq7EMzX;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11920-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11920-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C698130E5E81
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 09:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA123F44CE;
	Wed,  1 Jul 2026 09:26:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4176432470A;
	Wed,  1 Jul 2026 09:26:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898012; cv=fail; b=GuWtBmMrT58r9VfWp66Y7+XwFUiOUoycyzR2bAtos4XTUxXeIEFB46BDnrTefKbqKij/0tUZIdLkMnRUyn6jp6KyxpCcXO7BlY/rhUD4Jnz+fKzqE3ypJcC3j+2tHLs5vb7yxtgWLk+a3vaTiAW8DTclS3KS0P4Eoi4IBCGeFhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898012; c=relaxed/simple;
	bh=+ZKtlcA/un3UvSfYIly+jicfro4ao68oXUPOJtpuk7M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kfw4ws9/yZVsjF4PfddOBM2nS5DnZ/eyvkLLiG8NTmoFgMr23AR79oWUHTjxD/WTJ49EzjVLXJkYKqxGiFK6ibyASgBhWqYNciG4PqP04JnoOxxxzA2PvbnS7p+yIz62OzNMkXzDSOaKI24JKN2JB7mq5PTst577Mgba2a4bRck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xJq7EMzX; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2oQUeQ/Otb1eTZ7yXP7gPhfemyuQPyN0wIcoboHocY3tiKwS5GIxJwW0uSDgnoEjKxtofMprhTizGS2hW0T42SjTWdeB4xpnIgk5340spMU7FK+4+akX3mds2NviJn5pzdFRNyE8Yf/lIEVA1qlWMElyg1mbvpLV6g6SvnXUZKDwzexEOBuM1FhMR+kPYbCqx0mWHtjlq86U1rEYK8tvvqya981MRJGFmNN42fkkxW8hsTf1WU07tVyfrCk6+8WIW/AcOzoRQtdmcG6az1A7fDWSdVGnRqdJX6GuKwDMM7HRLCgzqJHQxf4/iYxJnNf2B+ITcwSPJFrc+FjqTNZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmCtQ2g//2lSCFH89EA8m7MbFmE2YN2As0IHqr1wDXE=;
 b=Cj7ZRsrlURKI7MPdsyu1wDlPVmZhgLiDKQm1veaJUFEqs0GdururoQEs2mMC0qBW5SAtIqM7NhJtvQhxjT9wUJAvrofy3Ear9Kf4WdAGPVE/615VGXlqe22BGyg8fDZIuQDD2BNrHP5y3eLSqwfxwU94V4weQ/V8CRi7mIyAYE/ghrityzpLg1s7slg09X+6jzgbhSP1++2RsB4mOeAsxCdC6qgkZTCmJAM4IuTA6VuC+LK1NIykiv2bnnzR9CBpvAcjdZsjjyRAqBd30AAJ0O54qUDYOQT7nA0CV4waqx26VqKi10HZWBu3GNNooSsEpZbZaRniUILJbIU7oryclA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmCtQ2g//2lSCFH89EA8m7MbFmE2YN2As0IHqr1wDXE=;
 b=xJq7EMzXGjZdBTZHvedVRjv2N5oY7UJ2a1lcsOtAtZMt/ObcWySF3O3s9QomnKFg/XSxM2ihqrfRqVZtSzyollzKemoLp+AL9GouPzjqZLTBasJGlt56RVvRlNLtjMziR1etbHy5RsHDNN8A8s9yST5moP9vh6xy2vjtpQMWTRYPqv8tiNwSUMywDStzjsT+kIC+f+PBH6+XIFGnm/rrusknuNn7bol2EBfJJBjnpyed2TS2rcIe5e+HimYz/2JH0Y8KTpMEcOTXVq5FRBE/eqlKrQKD4N+lIwskUvm1IMRi4j49WrBFRgkVlo7gO87ImjEQyEsonmUX2U/CvP9jnw==
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
 by PAXPR04MB8271.eurprd04.prod.outlook.com (2603:10a6:102:1ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 09:26:48 +0000
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de]) by VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 09:26:48 +0000
From: joy.zou@oss.nxp.com
Date: Wed, 01 Jul 2026 17:29:27 +0800
Subject: [PATCH v6 5/5] dmaengine: fsl-edma: fix use-after-free after
 dev_pm_domain_detach()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-edma-runtime-opt-v6-5-354ff4229c00@oss.nxp.com>
References: <20260701-b4-edma-runtime-opt-v6-0-354ff4229c00@oss.nxp.com>
In-Reply-To: <20260701-b4-edma-runtime-opt-v6-0-354ff4229c00@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: Joy Zou <joy.zou@oss.nxp.com>, Frank Li <Frank.Li@kernel.org>, 
 imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To DB8PR04MB5803.eurprd04.prod.outlook.com
 (2603:10a6:10:a9::27)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_|PAXPR04MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f5e55b-8778-4306-d528-08ded752df97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9Q/ZN2sqfJO7lWV5iCNeMF68YWBrMF7kbhtRMLTW8Vhv0FMGMRVQ0G/ocnRZVOPHoshAyZpKoBp+P4HGIIg+K0HYllEGMv4TKlh9lz8prhPliiRjggJXiSOZO6KN0lj9fmNYNkx9XFjBS8T60fuXR58r+2VLfHTe5qRrBVpscqiuj8OvS06jnq1eSaxRaJVIPm+Acn0+L2Cv5WcXpjsAQIK0+5YemECinwAYuc/51bihKMAoueIJvmz/NnYMaCETfWxZRAQ2PDUzCt6Nscfx3N+kH9r/DzQdxkBuPIrifDRTNglitmThjQR1BzB9Vz3HL8T+uh64/u9dFA9M2AEpWRYu7JoozPXgmfuC2NB1WmjYqRaBJOwz53IzKZ9J3yBzXouA4o1d8w0fNinoc1lVaTYjK8rMSDsLSsMGbZAI5TfusfxJDl6gL49KxU4UC9Avtia6J2DFxkUjgt59DY6Dr1cIZseRG4R5Yxc0oQ+amhg4sHqsocZxgA0i7bCALlLYCISbd65+YaBTNldKxdx1/Ljqrsz5kI86og7IOhhfM9no0gq++8XWuSrVaKx85yjOOp438Mw3omtUbTrPzMIOX/0q1n4P7zIkVNfrSrAz59YKHAsFFTlbqXFcr9OoQMIu11HRRwi3qFj3clZRSJs8YI1Z6uICEeXtE+VXGHJ53qc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5807.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDZHKzBaZDB5cW0zU3FIaWFha0lzVXo1Vld0NW5rRGJ0ZGlYb2JPSUZwdlRH?=
 =?utf-8?B?aDQ5U0J4djV4MlovdjFBOE1ORDRuYUdtaythSGxwb3R6U29qV1lDeUplYnh0?=
 =?utf-8?B?SjVKSG9TK05BZ1F6YVBOMWRqT1dMRDlHaG1rWjIzZFcxNXU5WG1YZjlHVlpm?=
 =?utf-8?B?WktuY3MrdUd2TXRKQUN5eStqSXhnT0FKN3JRK3dqdnZmdnJ6d09wSVJnQjNj?=
 =?utf-8?B?dms0aVdxbFhCa2dFUnltNDNzckhYQ2ZTWFVtKzVTWXh5cllZZEc0d3h2STJL?=
 =?utf-8?B?SDBldmVUOE1uNVZaemZsdTBkQ05EWk5ERDFtTWNYS1JpMnR6WllDaEJobzZN?=
 =?utf-8?B?ZnZOaEVKcm4vK0tFeFFtUUE4NmVmYkFreWlNNmNEOGxLZDduVklaVXJCVzEx?=
 =?utf-8?B?Rnc0aWY3TElMZmJIbVY1RXd6VnZJL1FDNVBEMmFtd0lzK1lwTWRxWm9DQzdm?=
 =?utf-8?B?ZC93eGRoMWlEcWNwaHhTaEpiZEN5dnZobUtqM2lSTlB6R1RGWHBONTFqRW9p?=
 =?utf-8?B?Ym0xTXA4S3JVbnRiZHBwUXVZS2kzRU9mb09WTGIwZHdOSTFxRTdvUEl6Uk5B?=
 =?utf-8?B?cUF0V0ovemd5TkZCVlBpQ0lsUnBYY2dQNUZwYkRZWmk5TXg4WmtDZUFPL2RG?=
 =?utf-8?B?a1o1ZGdHcmJoZjF2MlB2Y1FwdDNuQVg3a3htUkxHc1dCWFB4UmlCRWYyWXZ2?=
 =?utf-8?B?ejBKT3dFeklHbURjYWhrNGVSQXd1c1JUV1M3VVRvZlJ0bVpGejRUZW50d2FX?=
 =?utf-8?B?VElvU3RFQkNuZCtQOFhySHZ3VjdESjNBZ2ZmcmdjNEtqTGtzTnhwZzBrcGVo?=
 =?utf-8?B?SlVzcCsza24xcmRSN0FzZGdiUzhBbk10cyswVjRrL2hQamRjSmdwOXhaNDcy?=
 =?utf-8?B?ekc3NTNhTS9TL2xmdE9KaTNLY3dqaldjRXlEZjh6eHFqNWZKTXhCYVMwNHZl?=
 =?utf-8?B?ZFVyQ2pmUkdEUzBWMWxNMk9mdU9pRHJlbDU1emhZUGF4ODc2RDJXdVFhcUNm?=
 =?utf-8?B?U2lYWTJjekVoL3NZSjJGQzFpZlZxN0gwOG50UTdRdmg4TnBkaFpzdG8vOUJv?=
 =?utf-8?B?Y1ltNytXb2J6MmI1cERUYy9zZStzK2Z5ejdseDZvS0pSbWdmaE1jeHFtZzFW?=
 =?utf-8?B?b1NneGVZWmlramVUMXAra0ZNUnc2ZXkxUjhRNlVkaVA3VmdleTdNZ05FazVD?=
 =?utf-8?B?VVVRY2E3VnhWRStDY3V3NW1uRWRkSTJIMTZrVEpxUmlLUVBWemtEMmZtaEV6?=
 =?utf-8?B?K3RONGtBZzhqNHpLS3ZnVFhITjhLZ1lZT0VxTkFPUFFhZjFEVEN4NjlJZU5q?=
 =?utf-8?B?dU1UdjhKWmxVYU42bGNOdWd3V1FoL0E0bTJObmxPYnJ2UmpjeFRobWlUUFRv?=
 =?utf-8?B?dWFTa3FoeVBQN200UHBPSkVScFQ0a1cycEpybGpJQ3ZlR1Uvd3UxdHhiUDFN?=
 =?utf-8?B?RkNMa0xzb0RsUEkrY2VwS3VwQ3RGaDY4NXdwZG1yMGhYRTNrVmVlK0NRUHM2?=
 =?utf-8?B?eUdVVjhBdVlVbjdZVkRldzNHYTlGRW1aNkhGWlQ5cFV5TURHZkJ1SkMxakk5?=
 =?utf-8?B?U2hGZEt5dnhHK09QQ0FCTTVWbW5vd1RJaHNQbExDRU9BM0JYeDY1SkFDWVdh?=
 =?utf-8?B?SnY4U2hKVUdtRzFZOUVrbG5rVWt2U01OdEp5WGhFRlMrdjc5VjV1YnlaOTQv?=
 =?utf-8?B?TG9mOGx3WHE4a3RWSm0rZVE2dzYvVTlVWkxDNmlLWmtLNkMzaDV2MjE0UEU3?=
 =?utf-8?B?ZUxNa3Y2Ym52VllQQk9yS0E1aDQ2QnJRakIvSGhmZGkzQmFGQllLZldZQmdO?=
 =?utf-8?B?Y3loM3ZrYURVNTZaMG1SRjgzR3h5S2JUSkVqeUVldUNyY3psSWorZXFneTZD?=
 =?utf-8?B?RUdxU2FVRTZXaG0rcnJQWWdPSEU3SnZCbG0ycVZzZEtBdDVBVis3UFc5WGpZ?=
 =?utf-8?B?anBlL3NhYTFZa3l5aWY3UGdUWlVhZXhHSmdNZ2F4U0JUc0h4UVJTYWw1ZGd4?=
 =?utf-8?B?YTM4RUMvcEd5VTNnZ2tNV2dHbWxKbVZkTGpiRjBNZjgyZUtSNGFPOHV1UURD?=
 =?utf-8?B?bm9nZWNxNEVPZFhUV3k3bXg3amI2akpETVFaZ3o4TXQ3V1d3UjE3czVkZUxV?=
 =?utf-8?B?dXRPcHVTZmJlWkNNa3g2SXQ0T3BqSXhrMkNrV0U5QzhJcmNRZ29qdytxMTdV?=
 =?utf-8?B?S2dpa2V1a2Izb3lUdjRvL3orZENKUDN3Z3dBYmZKME1LMHVRbGlWblEwcWdL?=
 =?utf-8?B?NkxkZmtUQzdvWXBMMVdIbWRpWHlSak1MR2NkYldNQlk4aWlSR09ySFZ6cEkr?=
 =?utf-8?B?eEs0SHBlb1pNU0hDUDB6NmdDV0ZVOWFnY1pwSDMrZlB5Z28yU0JJbkNZUGpp?=
 =?utf-8?Q?54aIFm34xtvAakvBB0DP/6+LDdzwCMSLQTaag?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f5e55b-8778-4306-d528-08ded752df97
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB5803.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:26:48.2880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdmx9ieCMkb0haQhUe9j+KBCIroMCNQjcgpTdXk/Hhfw5XRb0FWBQYHPYlt99LJEweNAopCsFTLgxVo/+Dyv2ru7CQ8aMeHaBP96sOBT7pCu0DQOCi5QLDxTtYQ5z7H8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8271
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11920-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[joy.zou@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[joy.zou@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:joe@pf.is.s.u-tokyo.ac.jp,m:joy.zou@oss.nxp.com,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:joy.zou@nxp.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,vger.kernel.org:from_smtp,oss.nxp.com:mid,oss.nxp.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B08266EB9B2

From: Joy Zou <joy.zou@nxp.com>

Remove pm_runtime_set_suspended() call after dev_pm_domain_detach()
to prevent use-after-free. When a power domain is attached via
dev_pm_domain_attach_by_id(), calling dev_pm_domain_detach()
unregisters and frees the underlying virtual device, making
fsl_chan->pd_dev a dangling pointer.

Accessing the freed pointer in pm_runtime_set_suspended() triggers
undefined behavior and potential crashes.

Fixes: ccfa3131d4a0 ("dmaengine: fsl-edma: implement the cleanup path of fsl_edma3_attach_pd()")

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 3518dfb4292d..266cc082a9f0 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -671,8 +671,8 @@ static void fsl_edma3_detach_pd(struct fsl_edma_engine *fsl_edma)
 			fsl_chan->pd_dev_link = NULL;
 		}
 		if (fsl_chan->pd_dev) {
-			dev_pm_domain_detach(fsl_chan->pd_dev, false);
 			pm_runtime_set_suspended(fsl_chan->pd_dev);
+			dev_pm_domain_detach(fsl_chan->pd_dev, false);
 		}
 	}
 }

-- 
2.34.1


