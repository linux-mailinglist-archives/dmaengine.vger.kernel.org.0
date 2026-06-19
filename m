Return-Path: <dmaengine+bounces-11639-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nNtDDbtRNWpiswYAu9opvQ
	(envelope-from <dmaengine+bounces-11639-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 16:27:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E836A6680
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 16:27:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="aRqn/qpV";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11639-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11639-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A196F300F176
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 14:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E15397338;
	Fri, 19 Jun 2026 14:27:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013021.outbound.protection.outlook.com [40.107.162.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E002D97B7;
	Fri, 19 Jun 2026 14:27:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781879224; cv=fail; b=upZ0OLVvUIlCbx3lRvfDWjKUayX+rpiJJ/UiGtDov4Huwi48XbPsGeXltwU5SBEBJWYYSPd1djgW9PcH9S0WiMkHejEfraK8uBwSZmNWZG9PV0uOGQjvZWkRjWAslq5xvtbTFU4R1GqwLsvxRW+9hVyz/ynrioXkqe1CMRkGBzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781879224; c=relaxed/simple;
	bh=fXqwMbJAy07vIfv06Ytehu26Ma6Un4xRmlH5mniqzD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S4iUvITfwO0pa1lBbdq1qY5dsBcZeeYp4NaQuYt5ls5dyL9wIivQciAjgHyElmkb1gA6Wm7nqmrZxR1c1rBvKOgIprFtGHxuZJ1Gybuf60UboEgUbgld6R6Ci4OvQRrq1oF8l95Xb8pAkECRlP8SUN/7mkEmpxlmCPtaM21Ihe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aRqn/qpV; arc=fail smtp.client-ip=40.107.162.21
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L15iVxLsRg5U3tex5+5wULAz/0mvKrDNHH+1n9ZGwkMIEQwdn7+vL3yKqJxcpu2BtgxGziAmu1iHpc5JKDtEwzHd1/9+b9xMPve+e0wOp1jLIIkdIZqtUoX/ABYTCd0b4+C8wPgh9Si4Ujz0sFXTG+/3scIix3le9Pz3z3vLoFyR5i2E4xeUQF9cjvIePRyY+DK2c+gH8kn7g3Uy27BqklQAgJ5MOV4PonvTUGMIdtzbAyIFGRvlGKkoMYniu9u7WAOMys7TfeH1m5N6tfFCzEEZ0Ju7aWqxaJABRyxcao0PcB70B/gGPeqJw6up28j4CfxRxjICadUEaOVJ5Nbv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQRyQjm0eW95XTPGToyQC0pYI3S0wqpUQPOquz/b4aY=;
 b=B9dsgMrllF3AttpqyjGQlpN1c/i18XPlFMrbn20HxbyUkphQJSOZtq/MvYe+6v6zayd3Y2pg42zPhCbUaxy/xngAnyRU5AJlVObd+imAmu5wT35lxBzOjskp1b8ya3q6gbnnTHdJvMe83O/9QT8hxZGS01/ZwHnGeRB7fdCOjuP4P26De0xOGf57eVOXvPxwQsWLK3dE+7eJOVR+JavunaeCj2VsqYsJFEsuSTCDqRmmyYeknT99oDe0vrA4IcTfTFRoFO3QeJE+kwTRD6JQtiaM+GF7tRKURa8FcCf5WhUg05VtIog3DyKrlwhgI35CKreBW5F+50Y1O1xDs1aONQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQRyQjm0eW95XTPGToyQC0pYI3S0wqpUQPOquz/b4aY=;
 b=aRqn/qpV12Y0wkpR0fr+XQVAGaoKjHZwabeZN2nR0dGXXe5Om/RBF+Pf9KyDR3Np77AAggmdP9DbILbmdWd2aALUYAIUjUB3L998QuPpbVr1zrKtNyhzOw7ivcBakw6NzIiYeqXECfU2lT+vIHlfhtA7V/YML6QT10cr89bDQbzgLVNmXGG9RkCQ1xG7aCXYyQE4mUPpmFQkbE3qmgXdKOR4AYOXMsKgYkqAkJKtCXGOb+PVRey5EGA4YlvpWlpIIOAp4bZ4Dw9aZESYSf8wqtVQv9512FrNKjeKQ1GcDjMOYFwRD2+LTQNjvTyZYjF/R9yDXkh6rz9PHsGH1Sx0Pw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB10337.eurprd04.prod.outlook.com (2603:10a6:10:562::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 14:26:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 14:26:58 +0000
Date: Fri, 19 Jun 2026 09:26:48 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Yuanshen Cao <alex.caoys@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] dmaengine: sun6i-dma: Refactor to support A733
 interrupt and register handling
Message-ID: <ajVRqK2OlUPlOc1S@SMW015318>
References: <20260619-sun60i-a733-dma-v1-0-da4b649fc72a@gmail.com>
 <20260619-sun60i-a733-dma-v1-1-da4b649fc72a@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619-sun60i-a733-dma-v1-1-da4b649fc72a@gmail.com>
X-ClientProxiedBy: SN7PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:806:f2::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB10337:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bcb7700-0c32-4827-6a76-08dece0ed213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|1800799024|376014|23010399003|6133799003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VyyMy8f1i3crb1Z6+onODJ8kgqLi4qFolxqme9/Yv5lBtofL6X27Frlz948QqK+gh9jxaSsekLH2NTX+2Z+XdI/SX1R8JXIjCPFX1YZa+AS6HLUzSsHEiWXNXRsHmuK8/lqCCMBl+qT1g52INboXWJOW9PbhNZYv4Vep0FBj2iJEkXCrusV+DmipAAIeA7ze/SiLfKt9SRmxz6M8xZyqsPqspxA8ucW6m1i6z3RwcUZqJyrwP1jnk3H4OqI3hsnl4E/89cLtuV4NyJGyfNUWivU3omCqlctF3isDzVsqP3Y/tjNz8Tqa5xtqdoOgr/GVrJGGf/jQNog48CqQWd3nwDI0NVJMqW6ZcGjuGb10xKGe3E09i+HDsP+7y3HJBQdpyVY4Xo9XLDcyCzjiMkHKfkM/Pq6qWAN38fss0GMuhBNkQGqgith5RVapYv64TDu3LFt58H5EtWusjtMMmoTykApZyPrnq9CVtJFq0OGbOE4qui6z7KI7mKABFOP5VWXgBOtkQBrGUv24zm2cymuyt2upUeTrHlsf1KkGWSHswf0s7qmeCikZwE1GMfP2yvpwfNZRV5lkQE1JTWhDG6KSTr5MgEne2DR8ncCZCLT7PJlg4qMTkSyl5UVSM+UWemGUjOlBuvn9Uj/6t5KW01p+tv3eRjbqxHzS0IybRQlpgHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(1800799024)(376014)(23010399003)(6133799003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4iHg9tb0JqY0GdDIMwUTx+HAFIZ/yWxTFkkQzJ1kbc9yV/uHXjOBzdn4wvsy?=
 =?us-ascii?Q?xsrGhBGkQoxmtsTRqOWUZmp53oBqjpzfmFC3Jqsre3lqBxkRKaCPh/PcM5rJ?=
 =?us-ascii?Q?TI+PcINBzlERo3tEpP1Qi4SfTsse6NZZf3kQ6Q/hBiVIWPYwGw7Ll+S+KVAc?=
 =?us-ascii?Q?/nTLbGCcfvXT1Z0QCw0ys9XzaqUx25edFtHK70XOoCAE8dDXUR+uatZo2ejA?=
 =?us-ascii?Q?x/edjpJSdFZiIZ8sO0rkf7oU81t0ZE+VNj8wi8ygmNnkl+uHRkTKMhw6dhGp?=
 =?us-ascii?Q?SxjW0nptI1lOOGhw+S9cCV1/uCPJycPZNNlQYyhmp4FPhh9LEJmTUTjhjodj?=
 =?us-ascii?Q?PLkI6Dc5j6ObRvOpdS1L2+xqjivNXxSry4N3D94gUXTlrssFIVlBxMrVxE74?=
 =?us-ascii?Q?Xs9avbr8KMTnG12FDo9goneP1GG/H9ZyHqb4Adk3wmrRyOZ+L23E/v3QMpFq?=
 =?us-ascii?Q?asNsyblL9fu4CMdINJYYzUzjoLQU93WJZ7wyJhv5oyHhxXntFKZVk6GEaR6J?=
 =?us-ascii?Q?csCcaTqhSJh/N3Aysi8OfC/ogAUN5KY2q4HEFP0+edN/CwrEYzaK/ibgoINX?=
 =?us-ascii?Q?0dSPLyCEb2G6RbzRjatob1XQvM6ZEPQSp5SZY1vfYfoAdoi4uFX8QlsKd++j?=
 =?us-ascii?Q?kgl4ApBCLK9wXADoyLO0B3toHua5R2LyEyTLo4QSmR3fDpkF3Rz1uc/QgNIe?=
 =?us-ascii?Q?bgwBTgQHdxtmZ/w9rDyYFA6F28uNiEZwzl44oq8+d3i7Ifbs1zyjxQ/3T/aq?=
 =?us-ascii?Q?uNVgb1H5NY4BinkRWq2sy+vyzUwh0Po4K2R+eUeV+8+aRHSAqullj31ezXme?=
 =?us-ascii?Q?cWarhERUVuQ2a1T+Wk9initDzD1Mqhj8DZPW9wFcx4n9P3R1Tqj41L6g1Uma?=
 =?us-ascii?Q?uWmTpgoAMbtd6NdMcmbEo6HFI3S5cyjGiH65go0OHzN6AKPNwWuje0X0iK7F?=
 =?us-ascii?Q?9aHhLOyVL+Zht3tEYa0T2iH5gw5AsMhttzYQfqW8gE5P+WJP4SL81LTyHKYm?=
 =?us-ascii?Q?NMtMv0ZRjznFYfWUJUjlVtlXLIyPSPMzOmHpYbdkpibmrcscwKEi3qyhX9ki?=
 =?us-ascii?Q?KaJhJvAo4+CZPFPDb/iD3z3cAjU/1xm3T0Zsl+AWHpsHkKSlTuR3haq+D4YZ?=
 =?us-ascii?Q?O2zB57l0822Fm8k6w7y8sekfzC/f651B0u/izDtd3TW4LT0uAL25/Ymywr7q?=
 =?us-ascii?Q?0vh7QRPnjCGY7lwxJuYlz/7do+ivk+SpLm+KI1oplWYYKuqIG5RvYoSpbCvY?=
 =?us-ascii?Q?kc7XC1yYp6Sliye99Ne7NZgylCqiHf/M4dkBCtrhffRz+l5s1HEc+mm881AS?=
 =?us-ascii?Q?VNZL2kBFb+yus6vynXdx8kvXYnVfUWNaGO9ffmNp1rBCf7gTKR3OjWbkAoam?=
 =?us-ascii?Q?N6MBdet7g3/e4LdLhjA/r1Rnz9VTLz3+LoQWvaq6DIkkLiCh5ApiufpyBP+0?=
 =?us-ascii?Q?rFpFbEMstHB0xevfXNuCEYK0jTkXc73tyBKPCDKtWxoR/O+Sn/jxA47lKN7p?=
 =?us-ascii?Q?HFz3tGUduWzNjlJA+RgAczwfe8TOeyIUEUfGFRjiiGMv9H7V93FxjNitcVsm?=
 =?us-ascii?Q?CVCnXCjTgQvQrZV02a/YiqsIv62i1hqiX2HtrwIl43AVqlYXu0U9xS80WtOE?=
 =?us-ascii?Q?2gKyqMrPF2bzXkGAkI60qyQOgs1/RuZnbSJISW88qGUN4qQor1KeOSzcXugN?=
 =?us-ascii?Q?HkUoQT+NPYt3IRU8O5h3rMHZZB0RZIH/XjbR5XGqJLOLoF2VejBXQIHi2SoO?=
 =?us-ascii?Q?8ycLhLc8o8CUkLBG6sjk37/K/6T3n4rg00izzT7fUMBpajhEnzv6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcb7700-0c32-4827-6a76-08dece0ed213
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 14:26:58.6014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzU2NunCEDPYCXDRB1xXYpv4NMOCAn54R1F9Uf+Ho1KUpvQtxmEM1p00mVDJvQDfQY7Eiq635j+F5sUpG7MDBLtkJMEpUOIaON1G2DRqMQuaOmzZEmxs1lvKn++fiqPQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10337
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:alex.caoys@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:mripard@kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:alexcaoys@gmail.com,m:jernejskrabec@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11639-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sholland.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,SMW015318:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97E836A6680

On Fri, Jun 19, 2026 at 04:53:30AM +0000, Yuanshen Cao wrote:
>
> This patch is the first step in a refactoring effort to support the

avoid use "this patch/commit", Just

Refactor ... to support Allwinner A733 DMA controller.

> Allwinner A733 DMA controller. Currently, the `sun6i-dma` driver has
> several functions related to interrupt handling (reading/writing
> interrupt enable and status registers) and register dumping that are
> hardcoded.
>
> To support the A733, which has different register layouts and interrupt
> handling logic, these functions are being moved into the
> `sun6i_dma_config` structure as function pointers. This allows the
> driver to use a polymorphic approach where the specific implementation
> is determined by the hardware configuration assigned during device
> probing.
>
> Changes:
> - Added function pointers to `struct sun6i_dma_config` for:
>     - `dump_com_regs`
>     - `read_irq_en`
>     - `write_irq_en`
>     - `read_irq_stat`
>     - `write_irq_stat`
> - Implemented generic `sun6i_read/write_irq_*` functions for existing
>   hardware.
> - Updated existing `sun6i_dma_config` instances (A31, A23, H3, A64,
>   A100, H6, V3S) to use these new function pointers.
>
> Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
> ---
>  drivers/dma/sun6i-dma.c | 74 +++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 69 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb..d92e702320d9 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -138,6 +138,11 @@ struct sun6i_dma_config {
>         void (*set_burst_length)(u32 *p_cfg, s8 src_burst, s8 dst_burst);
>         void (*set_drq)(u32 *p_cfg, s8 src_drq, s8 dst_drq);
>         void (*set_mode)(u32 *p_cfg, s8 src_mode, s8 dst_mode);
> +       void (*dump_com_regs)(struct sun6i_dma_dev *sdev);
> +       u32 (*read_irq_en)(struct sun6i_dma_dev *sdev, u32 chan_num);
> +       void (*write_irq_en)(struct sun6i_dma_dev *sdev, u32 chan_num, u32 irq_val);
> +       u32 (*read_irq_stat)(struct sun6i_dma_dev *sdev, u32 chan_num);
> +       void (*write_irq_stat)(struct sun6i_dma_dev *sdev, u32 chan_num, u32 status);
>         u32 src_burst_lengths;
>         u32 dst_burst_lengths;
>         u32 src_addr_widths;
> @@ -347,6 +352,25 @@ static void sun6i_set_mode_h6(u32 *p_cfg, s8 src_mode, s8 dst_mode)
>                   DMA_CHAN_CFG_DST_MODE_H6(dst_mode);
>  }
>
> +static u32 sun6i_read_irq_en(struct sun6i_dma_dev *sdev, u32 chan_num)
> +{
> +       return readl(sdev->base + DMA_IRQ_EN(chan_num));
> +}
> +
> +static void sun6i_write_irq_en(struct sun6i_dma_dev *sdev, u32 chan_num, u32 irq_val)
> +{
> +       writel(irq_val, sdev->base + DMA_IRQ_EN(chan_num));
> +}
> +static u32 sun6i_read_irq_stat(struct sun6i_dma_dev *sdev, u32 chan_num)
> +{
> +       return readl(sdev->base + DMA_IRQ_STAT(chan_num));
> +}
> +
> +static void sun6i_write_irq_stat(struct sun6i_dma_dev *sdev, u32 chan_num, u32 status)
> +{
> +       writel(status, sdev->base + DMA_IRQ_STAT(chan_num));
> +}
> +
>  static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
>  {
>         struct sun6i_desc *txd = pchan->desc;
> @@ -460,16 +484,16 @@ static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
>
>         vchan->irq_type = vchan->cyclic ? DMA_IRQ_PKG : DMA_IRQ_QUEUE;
>
> -       irq_val = readl(sdev->base + DMA_IRQ_EN(irq_reg));
> +       irq_val = sdev->cfg->read_irq_en(sdev, irq_reg);
>         irq_val &= ~((DMA_IRQ_HALF | DMA_IRQ_PKG | DMA_IRQ_QUEUE) <<
>                         (irq_offset * DMA_IRQ_CHAN_WIDTH));
>         irq_val |= vchan->irq_type << (irq_offset * DMA_IRQ_CHAN_WIDTH);
> -       writel(irq_val, sdev->base + DMA_IRQ_EN(irq_reg));
> +       sdev->cfg->write_irq_en(sdev, irq_reg, irq_val);
>
>         writel(pchan->desc->p_lli, pchan->base + DMA_CHAN_LLI_ADDR);
>         writel(DMA_CHAN_ENABLE_START, pchan->base + DMA_CHAN_ENABLE);
>
> -       sun6i_dma_dump_com_regs(sdev);
> +       sdev->cfg->dump_com_regs(sdev);
>         sun6i_dma_dump_chan_regs(sdev, pchan);
>
>         return 0;
> @@ -549,14 +573,14 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
>         u32 status;
>
>         for (i = 0; i < sdev->num_pchans / DMA_IRQ_CHAN_NR; i++) {
> -               status = readl(sdev->base + DMA_IRQ_STAT(i));
> +               status = sdev->cfg->read_irq_stat(sdev, i);
>                 if (!status)
>                         continue;
>
>                 dev_dbg(sdev->slave.dev, "DMA irq status %s: 0x%x\n",
>                         str_high_low(i), status);
>
> -               writel(status, sdev->base + DMA_IRQ_STAT(i));
> +               sdev->cfg->write_irq_stat(sdev, i, status);
>
>                 for (j = 0; (j < DMA_IRQ_CHAN_NR) && status; j++) {
>                         pchan = sdev->pchans + j;
> @@ -1124,6 +1148,11 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
>         .set_burst_length = sun6i_set_burst_length_a31,
>         .set_drq          = sun6i_set_drq_a31,
>         .set_mode         = sun6i_set_mode_a31,
> +       .dump_com_regs    = sun6i_dma_dump_com_regs,
> +       .read_irq_en      = sun6i_read_irq_en,
> +       .write_irq_en     = sun6i_write_irq_en,
> +       .read_irq_stat    = sun6i_read_irq_stat,
> +       .write_irq_stat   = sun6i_write_irq_stat,

Can you define macro like to avoid duplicate these init code. Or set it at
probe if it is NULL.

Frank

>         .src_burst_lengths = BIT(1) | BIT(8),
>         .dst_burst_lengths = BIT(1) | BIT(8),
>         .src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> @@ -1147,6 +1176,11 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
>         .set_burst_length = sun6i_set_burst_length_a31,
>         .set_drq          = sun6i_set_drq_a31,
>         .set_mode         = sun6i_set_mode_a31,
> +       .dump_com_regs    = sun6i_dma_dump_com_regs,
> +       .read_irq_en      = sun6i_read_irq_en,
> +       .write_irq_en     = sun6i_write_irq_en,
> +       .read_irq_stat    = sun6i_read_irq_stat,
> +       .write_irq_stat   = sun6i_write_irq_stat,
>         .src_burst_lengths = BIT(1) | BIT(8),
>         .dst_burst_lengths = BIT(1) | BIT(8),
>         .src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> @@ -1165,6 +1199,11 @@ static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
>         .set_burst_length = sun6i_set_burst_length_a31,
>         .set_drq          = sun6i_set_drq_a31,
>         .set_mode         = sun6i_set_mode_a31,
> +       .dump_com_regs    = sun6i_dma_dump_com_regs,
> +       .read_irq_en      = sun6i_read_irq_en,
> +       .write_irq_en     = sun6i_write_irq_en,
> +       .read_irq_stat    = sun6i_read_irq_stat,
> +       .write_irq_stat   = sun6i_write_irq_stat,
>         .src_burst_lengths = BIT(1) | BIT(8),
>         .dst_burst_lengths = BIT(1) | BIT(8),
>         .src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> @@ -1190,6 +1229,11 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
>         .set_burst_length = sun6i_set_burst_length_h3,
>         .set_drq          = sun6i_set_drq_a31,
>         .set_mode         = sun6i_set_mode_a31,
> +       .dump_com_regs    = sun6i_dma_dump_com_regs,
> +       .read_irq_en      = sun6i_read_irq_en,
> +       .write_irq_en     = sun6i_write_irq_en,
> +       .read_irq_stat    = sun6i_read_irq_stat,
> +       .write_irq_stat   = sun6i_write_irq_stat,
>         .src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
>         .dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
>         .src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> @@ -1211,6 +1255,11 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg = {
>         .set_burst_length = sun6i_set_burst_length_h3,
>         .set_drq          = sun6i_set_drq_a31,
>         .set_mode         = sun6i_set_mode_a31,
> +       .dump_com_regs    = sun6i_dma_dump_com_regs,
> +       .read_irq_en      = sun6i_read_irq_en,
> +       .write_irq_en     = sun6i_write_irq_en,
> +       .read_irq_stat    = sun6i_read_irq_stat,
> +       .write_irq_stat   = sun6i_write_irq_stat,
>         .src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
>         .dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
>         .src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> @@ -1232,6 +1281,11 @@ static struct sun6i_dma_config sun50i_a100_dma_cfg = {
>         .set_burst_length = sun6i_set_burst_length_h3,
>         .set_drq          = sun6i_set_drq_h6,
>         .set_mode         = sun6i_set_mode_h6,
> +       .dump_com_regs    = sun6i_dma_dump_com_regs,
> +       .read_irq_en      = sun6i_read_irq_en,
> +       .write_irq_en     = sun6i_write_irq_en,
> +       .read_irq_stat    = sun6i_read_irq_stat,
> +       .write_irq_stat   = sun6i_write_irq_stat,
>         .src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
>         .dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
>         .src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> @@ -1255,6 +1309,11 @@ static struct sun6i_dma_config sun50i_h6_dma_cfg = {
>         .set_burst_length = sun6i_set_burst_length_h3,
>         .set_drq          = sun6i_set_drq_h6,
>         .set_mode         = sun6i_set_mode_h6,
> +       .dump_com_regs    = sun6i_dma_dump_com_regs,
> +       .read_irq_en      = sun6i_read_irq_en,
> +       .write_irq_en     = sun6i_write_irq_en,
> +       .read_irq_stat    = sun6i_read_irq_stat,
> +       .write_irq_stat   = sun6i_write_irq_stat,
>         .src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
>         .dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
>         .src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> @@ -1281,6 +1340,11 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
>         .set_burst_length = sun6i_set_burst_length_a31,
>         .set_drq          = sun6i_set_drq_a31,
>         .set_mode         = sun6i_set_mode_a31,
> +       .dump_com_regs    = sun6i_dma_dump_com_regs,
> +       .read_irq_en      = sun6i_read_irq_en,
> +       .write_irq_en     = sun6i_write_irq_en,
> +       .read_irq_stat    = sun6i_read_irq_stat,
> +       .write_irq_stat   = sun6i_write_irq_stat,
>         .src_burst_lengths = BIT(1) | BIT(8),
>         .dst_burst_lengths = BIT(1) | BIT(8),
>         .src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>
> --
> 2.54.0
>

