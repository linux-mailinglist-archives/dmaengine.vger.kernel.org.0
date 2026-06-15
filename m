Return-Path: <dmaengine+bounces-11544-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +gWoFwJJMGp1QwUAu9opvQ
	(envelope-from <dmaengine+bounces-11544-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 20:48:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2246894A6
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 20:48:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=WxHFYbFa;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11544-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11544-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3808A30A3ED6
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 18:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EC63A9D84;
	Mon, 15 Jun 2026 18:48:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265833A9631;
	Mon, 15 Jun 2026 18:48:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549287; cv=fail; b=FYaUq1d+kikMZitXottvN0/whd5hnqVundxI6pUQV3i8H8N8SmV89dCDtqdzFDNg+X8zbqXALjdvzVWha8+06pyXww0x2khVsH+2+CfiDttk2+w4riBDWt2DwXjAFaa+4hbuHueB8DuNxOe3SY6F14gZFWJZnzzUu9/mtwDFl5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549287; c=relaxed/simple;
	bh=7QxHD+EKLcF74YCCGkHIGdYLX3gk6rxiYZydZK7ieMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g2rhOpWujmMXJE5cvXQ6KbW+cdDB9oR3e0620zj4CA02IYAWdm1yLPx2Uiwh/d0X9e09q+fjzCCK/1iam4ER3RoMY1fvKp5JLDVrlDFaS18mZzIsg8FQ9EbHuCynZToYMuzMOpCczoPHXLaGNSTKzPt6sAKjGhV5mvLNP8MUcwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WxHFYbFa; arc=fail smtp.client-ip=52.101.69.67
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGLR1Fc5hUkj6GOMq2FyaDv2l8csMLoRft/5tTRZdc8U1GxPscgITBR0AHoQHw8zXSkhngts4/ulZMxfxvCG4DwtJC/DOoGfLjftAUqDc+EB3eYZEaSmryDjLsBWzVNOjbK4avaHQ1ziP6C8XpEO8GgIY05cAM/jz8GtOyTCLrp2rR6oVyGY4YkphTzBgPIzl8wTJC5lFB5e1xgUVEmycHeFzUcSyNaMFO2qVQgAP1Wb80ewzxzODaKpVI+RZiQk6eFej3fWjAcdeOswitRwKTMWVUhMbGzi/ZhhKpYx9mEjK8uY8/R7kQZYGfrIXQhpwcYS6MsIi9AlBGycVcShRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABwhseARrZMCELElsCYdSUPC/V4dABuf87GcGQCcQcM=;
 b=UtoLR8IQntpgpOUk9gZdf/HYUhm9lcFeYxIvK3QDbU1qv2CXy2Ru0RRumuPGUNu5IIp+Y+RK1sUUviMqzKKppy/1NCyqhV2VCOMSGwM3tdqUmJ+O1YOY+dN3beyLzcE2Ous38bnzC71TkM6RIDN4xh0ZQd2k1YvP9th0acTiFbtaTKy8RD+Q+1VwweK1lDi/OOUtwatlWcYD8N8Fios4hoLdmlM3KK6t5TUgFbNVpIk7OxZTcsrKTwDkqb/1B8EeeG/2w9y7zlWZ8WfmqYcKbEuMPJgWd3lJMbWY46Eipx28AwhcA1Tf+sY7eH6MieIqaCffuHuZLX8jWd8c8qvjPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABwhseARrZMCELElsCYdSUPC/V4dABuf87GcGQCcQcM=;
 b=WxHFYbFamdy8spkdlAuqpHHm3UKnsZApvpdcKGO7Eecc9w0HZrBHfmWajh+OZU0xyiZZ3N+bpo0hy+aNsf/upIYX/0W0H+QFGgliLNS+Wt9+kzfb0bx+RcPhEbPHIycE9zqQj50j53uE1WPsivJYIcZI7iJGN+sEK+lc/bwBg74Fpfh5tbE8sObibT+/B5MlhXlI/YgDvPoNdCNjeG5ERuCPxH6xZqVoRt1yUiYqtaPTCL4yHthX+iWxp0+0vhxnztUV/ZA2+Dg8EBsreHOQ++TelBjAyEZQooWa3iAxdYruJiN4icwnAQtGnmgqOd3C9LZPQizImLVtV13Ca41HVA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VE1PR04MB7325.eurprd04.prod.outlook.com (2603:10a6:800:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 18:48:01 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 18:48:00 +0000
Date: Mon, 15 Jun 2026 13:47:48 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>,
	Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/17] dmaengine: dw-edma: Serialize channel state checks
Message-ID: <ajBI1NKC34P4fA9Y@SMW015318>
References: <20260615154111.2174161-1-den@valinux.co.jp>
 <20260615154111.2174161-6-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615154111.2174161-6-den@valinux.co.jp>
X-ClientProxiedBy: PH1PEPF00013300.namprd07.prod.outlook.com
 (2603:10b6:518:1::e) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VE1PR04MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ee448f-76e2-4f2b-c948-08decb0e9fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|366016|1800799024|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TPmItOK2rf20rXQEkUjMhboGGtMQ2KqjGHbBrtKZzx1vYZR5X3tRjsY+pkOSCjv4LzEzhn993pgY+YgEJV7IWdDVqPboWy893C7r29eET0wk/H+I4T5kAlL0jlzGW5MqeSENS5uQFD/SpSaEQog/Sah2VUKttCaHMSrqbNItaib9N8HnJBhRH4BrSRjth+xcZfpwHwgYgiaEM4uPy56h4eGJ7Zy70PRpHrN5+sOQW/2R1c6WqcRdVCQqrHrz7oLfxp7B8H22oSvtrrkP7IuU9rwzafd1IrF9a/wF9MSAcjGUY/pUKpWjiuPDxiqiJtFcjUSmDFNIkBY54RQFq6qMOY9hOnqhyZjzDAiDcxowpL88DvfxpkslGeutdB9xUbQZ57+3Ll/7jjnuWU9SDClaZxKHUMFP66VkleGysN0cRBn2HEP1jQgLtULNxHJZvvjnZ+q7rok1SBqIRTNz5EnSt2wBmtszqHx2ZpE83E493YFpuk6GuUP8JLdwbaYY0RMQS2nKq+UWkoS37HQjdtkuc63A6Pu84f0I/pDflrYz7Tjpy6nYJbPmHBT0SAyJbovgMcl7lPMFUWGzxryIje7rKpPlMskXwggFagNpgbCTBqN9LTSEEnNsxMiGK6F9o3+7InllA230ezl1SnrTywk79TCN3rFuo1RzvFJJJDLNtU6IXGbpve1MOLYWxg74PwOV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/F1rdZSiLJ4Lx6thdKOpad+iMXLDz4d0pmAM3SQ0wJ08YYLtkR7zWbqFQzJv?=
 =?us-ascii?Q?09PV2w92ivQIbcCfsnPQUpbdFOfkJj5Me9QtrvomQDo0eivnyYkeKQHdTGNi?=
 =?us-ascii?Q?IfS/AE3h7j3p/JXMaWB2NEg9e41xRW6MzTJbUqf3llWbtM2YUst1Z/293e+N?=
 =?us-ascii?Q?ViYdKbFXLwqD75/a41XYsqhy9/G0T6CmRhpIQDo5vWu/EU4xOrJQBCOOIdDO?=
 =?us-ascii?Q?hoFh9MeWGoomPE+ey7wFTMQBRL6Ivw1JYcK/aFPp88rPtA+b8oA+bhpRxehO?=
 =?us-ascii?Q?ukoe+MnYOWTJ3C/uNDU80Tt3H42mPWJCwcyPPuXENV/OyDc66S1DaBoaWlac?=
 =?us-ascii?Q?bOIJGekrDeFObp+M05v+Ccm1goszLDd3QY/eEJDGHFweeyvS8ZA9pfZukvQy?=
 =?us-ascii?Q?MNZOuXNqEZqTuIqCqvn+npa9bs9zukRoh3GlR+n4/NtEgQpT3rHb3j1JMThc?=
 =?us-ascii?Q?bbPnYw205gs1ORmcfuAYeKasGO8Wc0Mq+NVaEx7bmx4Vg+ZKYcfag2FMhz1j?=
 =?us-ascii?Q?FU1KN4PenFD+w44mBhPjZ8afQEUzZijn0nrtS/3ULO7tzdTZBNz4O5gjRPkb?=
 =?us-ascii?Q?PDPSlxhH8WQ0y6C7D5hWwrT29A8cDfdGzfW74r/EiJnwMRqMN5KtK4CmEl+2?=
 =?us-ascii?Q?YTsJocppH5YyLGFArT5/bhE7IpFKDEdRc/NvK3fV+fnaKfS6F8DekWRMNE29?=
 =?us-ascii?Q?pUmfUMQe6xrGdMs+do4XUk6YQn0v6cuLqYnuBpI9iBQubR6gjhc4GNYKLdv0?=
 =?us-ascii?Q?tqd17N+j2hjHFt+pipDh3g9Ww/9quGD3a54tpcX8ns/rwTM2Vc1LU7JjpUMR?=
 =?us-ascii?Q?f6Qcn2Vj1L6DRo0SKpBdUwXo2tHBjFWRHYguFLRRtDTOBQOjC3BNBsXPrbk4?=
 =?us-ascii?Q?fAyUCRD56i/vhI3xxNqy77ecfUwo71+k1wv1a3/aeyGH52qKzqMcSw5QB89t?=
 =?us-ascii?Q?JFGahsOy16N1TkrPKJoBA+rxfBi4Hwh5nutuQu00YPythC2AORekzLYFgfjJ?=
 =?us-ascii?Q?RPZkK/WYiGFlhPgsJe915+WX2Q5RXPJFL5VQkVvBUx0zTgsWI9SkABGOqPDa?=
 =?us-ascii?Q?1pGaNRlgu0ofh/ImGur1ncjAOI2u2sPByzNkvz7SoygdUk+6/1/yrZ+3FKtq?=
 =?us-ascii?Q?+dCDRRx2JNrytw5Lp9W8UAv2kj+hSUpjJ/38EdQRWPErtkZH9AZ1nEuAT+2K?=
 =?us-ascii?Q?Gc1s6Z3r9P7c7uDfoLYEurLpAw0GQZL2Zg+vRwmjY+E5x/SkTI5m79U00Gm7?=
 =?us-ascii?Q?1wyTvsY27KQJ8Qd4vPAA8mlN0JrFWQFg6DLW7riDF0HiBaXcNU82jxtDH60V?=
 =?us-ascii?Q?QAFRISgG2nEBdtZbpMS82jahLKXe07DbgiXNFh2XiKIi4HmD62PQXPZxub7J?=
 =?us-ascii?Q?3e77MU4/5HoUSKbNhaTiD9r4KhpR/YqbRV308wrUSRf3Khz69SNBwRH709T6?=
 =?us-ascii?Q?IpI0qH/Wikr2Z8mZBdex2ITYDLkq4YE+603axNqyF+6EAQuU1pXAxrkLxpr8?=
 =?us-ascii?Q?AfkW4g6tDcN6COyUVTSN2bjPni/2VfF92s0uBBMcPmzpS8louCNsr/SO9B5i?=
 =?us-ascii?Q?Ug/IlauTo8+C5s2LKrZkV2xU4Viz2iaHiQwIumyiKugyyTag4Ythf/Ja2O5v?=
 =?us-ascii?Q?uRt6XWx1S4RArHlwLplflfdXoiMB2yqqlrJt/Q3rkX1LZ34Obvhbs7cWoqBK?=
 =?us-ascii?Q?6JM60c7+nk+DqoRtybJGMorppw+/AFnmow0923JaI0rsAXg/zpkegC6Plctj?=
 =?us-ascii?Q?617KcJ9Mi+TszUM1MLkKD/4HO9cKU4ubG6q1PPzOu6w0D7DyUhN1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ee448f-76e2-4f2b-c948-08decb0e9fe5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 18:48:00.9017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4q5yOcOgTSVIHp3cWk659R8f5sVPmhsbGvz8AT7aCpfRM5nRNohBz50NJ99RhHXUWhw6FzDB5XDgiu/C5oEiLUlhLOsTnNCKPT14J6XXJ40WdugfN6ardoumhFlJhWn4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7325
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11544-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:fancer.lancer@gmail.com,m:cai.huoqing@linux.dev,m:cassel@kernel.org,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,synopsys.com,google.com,lst.de,gmail.com,linux.dev,amd.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SMW015318:mid,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,nxp.com:email,NXP1.onmicrosoft.com:dkim,valinux.co.jp:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB2246894A6

On Tue, Jun 16, 2026 at 12:40:59AM +0900, Koichiro Den wrote:
> pause() and resume() read and update channel state without holding
> vc.lock, while the interrupt handlers update the same state under it.
> Take the same lock around those state checks so that request, status,
> and configured stay consistent.
>
> For example, pause() can observe EDMA_ST_BUSY right before the interrupt
> handler completes the final descriptor and moves the channel to
> EDMA_ST_IDLE, and then record EDMA_REQ_PAUSE on an already idle channel.
> No further interrupt will acknowledge the request, and since
> issue_pending() requires EDMA_REQ_NONE, the channel is wedged for good:
> terminate_all() leaves the stale request behind, so even reconfiguring
> the channel does not recover it.
>
> issue_pending() already runs under vc.lock, but it tests configured
> before taking it. Move that test under the lock as well, so that the
> decision to start work is made against the current value rather than one
> observed before a concurrent terminate_all() deconfigured the channel.
>
> Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw-edma/dw-edma-core.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 2777dc0b2aed..489f7fe49840 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -177,8 +177,10 @@ dw_edma_device_get_config(struct dma_chan *dchan,
>  static int dw_edma_device_pause(struct dma_chan *dchan)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	unsigned long flags;
>  	int err = 0;
>
> +	spin_lock_irqsave(&chan->vc.lock, flags);
>  	if (!chan->configured)
>  		err = -EPERM;
>  	else if (chan->status != EDMA_ST_BUSY)
> @@ -187,6 +189,7 @@ static int dw_edma_device_pause(struct dma_chan *dchan)
>  		err = -EPERM;
>  	else
>  		chan->request = EDMA_REQ_PAUSE;
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
>
>  	return err;
>  }
> @@ -194,8 +197,10 @@ static int dw_edma_device_pause(struct dma_chan *dchan)
>  static int dw_edma_device_resume(struct dma_chan *dchan)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	unsigned long flags;
>  	int err = 0;
>
> +	spin_lock_irqsave(&chan->vc.lock, flags);
>  	if (!chan->configured) {
>  		err = -EPERM;
>  	} else if (chan->status != EDMA_ST_PAUSE) {
> @@ -206,6 +211,7 @@ static int dw_edma_device_resume(struct dma_chan *dchan)
>  		chan->status = EDMA_ST_BUSY;
>  		dw_edma_start_transfer(chan);
>  	}
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
>
>  	return err;
>  }
> @@ -249,11 +255,9 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
>  	unsigned long flags;
>
> -	if (!chan->configured)
> -		return;
> -
>  	spin_lock_irqsave(&chan->vc.lock, flags);
> -	if (vchan_issue_pending(&chan->vc) && chan->request == EDMA_REQ_NONE &&
> +	if (chan->configured && vchan_issue_pending(&chan->vc) &&
> +	    chan->request == EDMA_REQ_NONE &&
>  	    chan->status == EDMA_ST_IDLE) {
>  		chan->status = EDMA_ST_BUSY;
>  		dw_edma_start_transfer(chan);
> --
> 2.51.0
>

