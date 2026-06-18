Return-Path: <dmaengine+bounces-11626-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jLVOOps+NGr2SgYAu9opvQ
	(envelope-from <dmaengine+bounces-11626-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 20:53:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E8F6A23AA
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 20:53:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="Bwp/V/NX";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11626-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11626-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCE8F303F3D2
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 18:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAFF3DE450;
	Thu, 18 Jun 2026 18:52:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013034.outbound.protection.outlook.com [40.107.162.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A5E3C3C12;
	Thu, 18 Jun 2026 18:52:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808741; cv=fail; b=WGVUi8nfVe6IuHWJDBgFyK6gFTL9eS84AF5u8goua+iKnVLv3AxEk5aAQn/uD8lfao4kfjUzgDBKW0lMxU6ka0JsDfyU5StD1iLjHt+iUdnodxy3FdWusPF2orrtx6jUwECmympklk0G4xiyyLoPVfKi119ZkQ6znOmihwT5Vfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808741; c=relaxed/simple;
	bh=2eB5HBtIma9z617K3e+lI3c6RJ7uTgikDkvOwzulPHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QTJqlHKtWospaDUmsRm5dBLcf1iBS6I2cJ1ytEKgUNPK7FSvs+90nCaXxbs16OvLkGQks/OGyQPk8aEemXfjA4ybwpV/ROWj6bxj+0rn/3pAnauTlUQ14YkQWcx0pNoQUZfBrWtOabfdg5WSxkjmjOOhg5q+rS/Jhi4Y8na98aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Bwp/V/NX; arc=fail smtp.client-ip=40.107.162.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHw/OMFZBEiYkWk774n9C6+Snm9QzBrl/o5WfJilUakho/1XYPr+dCqOGHvROXCjkFPkb9dbO3+r1CJjqLQ7AlN1pbQ1MwLqXbboiN31wJv9e9Ug2l6Xj7txVrhnG0xK66yXuxXVaschd5mtpVWHthec+TwWGUQEJMKyOxZtJRgvKFBNPKlV53qP3LEJkj1Hl51pGMQWROA2KzSkLqMPcG/ovVhsqsXsV82qPYUP1Tz387s+EQKQPXCD64vLRPTdha4SaR6UevUwbJ6EZSYtDmsWGLX5dwnF1YpFusyXKkCPFdWs+P4P044B0eCP1dPH/OqhYCLoEY4p/ZUFkBZyEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tirR7lfsZVF/WhCbi1OXHqKdFMnP7mj5+FwRh2WsuHA=;
 b=kek/PWLHRCbsQ5fMeLOOwWlMZWRq0tt4y5aNCjfICSVT4YbLFRGn0ulalqdZWFj6XglDGdAvukMYl7IZazQuMJ9H3woCbWxYxJhhe01kbiv0CWgryCm78sjwDHUGGsQ791Og/4BnBel5JzpxIYDIL7j3gWnUzByxpegE2HQRoBimLLn/3zpBws1rJaT0mpUEKO0wnr5nU1hrEBGO8YHq29jSbXmgqiiG7HWQ6SWd1AgOV41BR8kCuSiwK82hE6u3+MZ0S9/0Y2OZYir4AO3ZDr1TDEQ0Y5Tg4VtTlFSDHS+2qW3hdLyrXaTa9xmlW9YN8PzB0F8/Ey4wl2WRNRB7sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tirR7lfsZVF/WhCbi1OXHqKdFMnP7mj5+FwRh2WsuHA=;
 b=Bwp/V/NXZkBk/DsWXYirumgPX9Mwkovv9Ho5EsdmauTFqb7PnbD4dt5vWz6vWRQUT+8Z/SesHmDROTjuIzT/0a5QXnub2jt/d1MM99s7CQ9xIcnjsnQKTjLOb9ROHe8m2jFCP/YwoclUhRXUuRc7iCaHBLoiUFFGGy5yWNxlP+YgWtQ3WI1EJe7wzhoS4cdZwqAFtCfWehI+N/8oDkr/c4kzKrRpO9rzHAhRmFE0LMUkY9dg4mYa3u79LGwkcExCKz9gMNuzfpCNxAvYeQkzlMUYVbGoON7E3H0OhCFE0F4JqSh58bLJGi7Q6i5Kf1YbX22OdMU7iYiyCyCPTxHuHg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVUPR04MB12217.eurprd04.prod.outlook.com (2603:10a6:150:33d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 18:52:15 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:52:15 +0000
Date: Thu, 18 Jun 2026 13:52:03 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Golla Nagendra <nagendra.golla@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, michal.simek@amd.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jay.buddhabhatti@amd.com, harini.katakam@amd.com,
	m.tretter@pengutronix.de, radhey.shyam.pandey@amd.com,
	abin.joseph@amd.com, kees@kernel.org, sakari.ailus@linux.intel.com,
	git@amd.com, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/3] dmaengine: zynqmp_dma: Add per-channel reset
 support
Message-ID: <ajQ-U_ElSZuP8-pk@SMW015318>
References: <20260618071056.2024286-1-nagendra.golla@amd.com>
 <20260618071056.2024286-3-nagendra.golla@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618071056.2024286-3-nagendra.golla@amd.com>
X-ClientProxiedBy: PH8P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::31) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVUPR04MB12217:EE_
X-MS-Office365-Filtering-Correlation-Id: f0fbb027-01d4-4c02-6bdb-08decd6ab6c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|23010399003|11063799006|56012099006|4143699003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	eVL710sYp2XCAiAYYZSOkQDfb+hownPcNmkX5JtsV+qQQrx7ugsgGuD+m8ECv5MbmHu5uGIhNvSXV8mShnEzozPHMZR5UBPydp+uc+7ngXQdmIRJ16ZeinWjgaFJWkzwPODrv4IVzNVavhhtO0E3CaOeeywOjJUZOCJE2wh1QP0wFymydKo9LX3YkdHUyW8jT+yF+7WUrh52Y82DXzekza7QgPGNr0UCVLTp53t/NF6zhwheQ88u9kQ/D/7EfeoNfpm4F+2Jz77l2/UIPfkgCU7LZI5Xcps3/lVnsIS6dU9tvuEBiPPRjvXcNSa5ubHxmNoLZ3yrKkHO0bOMCLx/t6hTaCQlrGj6XwLpCwXjmzHna18Ovm4a5ta8tMnlfcfXJD5CPZr4uergxBiPmlaXBbu+pyY/iHdL+lnYPxnhBDJ47r8SW1LVOP8mCWVp7jn9T39dHN/NnCpRIqr30mBUh0vK5wxg0dFYE7o1pI2RSDcSo7Ni29g9vBLLjthaNxBLYh5VvQl1+lLlBR2BnbOLc4Rgd09t/pQYlONzUAOYOSuXCVZdhe6nr8mNLdKC6LDHTE6qT07PQU+/AllGCXclZTOncNDoQAtCt+ovqqMgRzEqhkgg0PwIGhSHRiqQ0bVhmh7L8QA/NHmRfzqWDti/4mWUk6gCT4hT0FNaAquQpWJfl+a3o0sI6fjsRDmN5pqK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(23010399003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F2UGhUA2VPfzYCwlDjpkstSSPulv23x70ppFJp56q+1VjbGKNPWULJlcFIc6?=
 =?us-ascii?Q?pKj+O+2o356rjwclpsIREfX5zMt8XkzczzPWoXGhZO5FMOzDVzlHF23GppqZ?=
 =?us-ascii?Q?rWkpAEjbW4XeFI4p5hUjdQCdMACbiat+UW6V3RzssWvYN71pL0L+Z2LpT33e?=
 =?us-ascii?Q?bqPMVDgKzmqDcvmlTcDANlkLsDAKCZH5A7N5IJ0qtaog6/8Ka1NeRiKWmwMT?=
 =?us-ascii?Q?pXtNqba7jmaSudmANFwJBRSMr3TPIN4vg7nXlvCzP47r4ya3404z4z744y9p?=
 =?us-ascii?Q?DRA6uUBX/zl6GWHZ2ea4L8oYIkI0XctOKqTKlaMGrFOKztv004ikGeYODRT6?=
 =?us-ascii?Q?X2rtgJLXVc3fvAPKSGjFY22okJ5ad9rvtqNmr0xE6rrwwyX03eRXSYs225Ch?=
 =?us-ascii?Q?7dYQNA8ij257mIe6ypwlx8VxtqcBy6seJDMtPGyGdOA1yrKIPopjuwDQQLYQ?=
 =?us-ascii?Q?DBrTVR+Gc72RvXZUb62TIMsQwccoWxuixdNs6IfyjTkgx1Dr3dKMWu32AT5O?=
 =?us-ascii?Q?6ECx6rF9GABSL6PoKqH7UvaNHOY0giccf7bqPOKqHyxdlFXx7AIJ07cUih20?=
 =?us-ascii?Q?BPvQT2S/Lv+TdOKBVoBGLvMdxfFvMtb7xtux0N8HkM82lgPSUge7sVZ2jVvJ?=
 =?us-ascii?Q?SBf6qStzYqIMJX/kNtIAJVj9Z6Uu5KPaNt98firWzVhz+CkU1WbD28ms1OOO?=
 =?us-ascii?Q?yJMoXdWl1sI0L5rgEhn/e55l9KBQO0ZsG/ExseyIMp9vrtoHgxD1n4ivOuEZ?=
 =?us-ascii?Q?pzM4Bs08CvldZ9Gcb647EHmjRxOkNhZfknSVLwwEl5ucWS9zXwUKDivUUDle?=
 =?us-ascii?Q?FaM+XSl+aZRWvYo2aXR16M8GX2Ayr0CzYVIO1MAFy57UDWZR2rXMgV3Q9mna?=
 =?us-ascii?Q?VRA0/0IBUPalkoG5OrEwuh7nki5zSjBGolmUoyuO2wmE2wAmBt/uK8ceBuRz?=
 =?us-ascii?Q?k2aV5YcOg1PlOdmNJkUv5CQXBYeQZCy2oI22tJL0ScS14GgpOSipL1YRha4Q?=
 =?us-ascii?Q?AzF3QZRWQ/joIlwbgRKzaxjz5KfmDRjm5jhE1m3YJkusZLrqjUdK7eaOMS2U?=
 =?us-ascii?Q?1KLqJF6v7QV2AH/dN8xmw4OauUwwH4qMqY2tNkOUvWHKfJ1QWleysP2iqZsu?=
 =?us-ascii?Q?rE+2FflAaGWtkrxYaLETllumBb0IpZTUYp57unUwwMqOj98jHDr3vBNZUBaB?=
 =?us-ascii?Q?3UdOOanL41I9yWbdwvRaw1aSrkvC1ifsmVzG+G2qknPuFVXaR3EEROVLNYi7?=
 =?us-ascii?Q?1OP/RjeT0OG8deuNRSKVjfHewx2pRYRbD5qajiFd/3pVYfzqc/7y4iWittNl?=
 =?us-ascii?Q?xmBioIL1q6lD5s6X7eztg3ohw+Nv7Jp6uG8smszYcNuVLDUj+kTitIGiiKD3?=
 =?us-ascii?Q?5vEyRsDGZuvOY6Rx3vzkbHJv7npTe0XddPxhcH8OhlRcbvufrNMCr6P8/oF1?=
 =?us-ascii?Q?cOHy6QlY068J7riXQ/U03HnX+kb3rai1dQJVn1cS2dGpAwon5A2zsYVFRfEE?=
 =?us-ascii?Q?mnyqeDOI743ULAOD8hrqsDfSSVQBThaPciObw3aN4ex3pW0bpotEQ1HOmibq?=
 =?us-ascii?Q?TRKGaE918Bu7XXKp1DfKTlfqVfTpzi6BeLLuOElGiUMlQ46pN8nED109M/KE?=
 =?us-ascii?Q?K5uvbZ8v6F5vALuBn291GsywTLWFMG5mqSSXOFlXTM/ZztAWhdORfxlvvkXb?=
 =?us-ascii?Q?+r9N40+QoW6/sv+7vEKcOs5wD87n0VwKeTOdQqVtinuXyPAJnFuWIfQ6UZu5?=
 =?us-ascii?Q?QPAOoHofhXQes+nuLE6LRiqqFLO2AFTOH2PUQX43VU8JljtAP1qo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fbb027-01d4-4c02-6bdb-08decd6ab6c9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:52:15.3054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8/5wld98LScXeql74BQYQY+a+P1bkXagik7/aOcCxJzaodC8vCWwztv2jamRY3OoSMO32YgBc4qgGl0C5/h7gJ5FxviYb4yS4UJjy/UoRonQ+2EcVhxWhQyt9hyyzf2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR04MB12217
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11626-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nagendra.golla@amd.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:jay.buddhabhatti@amd.com,m:harini.katakam@amd.com,m:m.tretter@pengutronix.de,m:radhey.shyam.pandey@amd.com,m:abin.joseph@amd.com,m:kees@kernel.org,m:sakari.ailus@linux.intel.com,m:git@amd.com,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,amd.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,aka.ms:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83E8F6A23AA

On Thu, Jun 18, 2026 at 12:40:55PM +0530, Golla Nagendra wrote:
> [You don't often get email from nagendra.golla@amd.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Versal Gen 2 and Versal Net SoCs expose a dedicated reset line per
> ZDMA channel, replacing the earlier approach where a single reset
> was shared across all channels. Add reset handling in the channel
> probe path using device_reset_optional() to trigger a reset pulse
> on the channel during initialization.
>
> Platforms without per-channel reset continue to work unaffected
> since device_reset_optional() returns 0 when no reset is specified.
>
> add pm_runtime_put_noidle() in the probe error path before
> pm_runtime_disable() to balance the usage counter incremented by
> pm_runtime_resume_and_get(). This is particularly important since
> device_reset_optional() can return -EPROBE_DEFER, causing the
> kernel to retry probe() and leak one PM usage count per retry
> without the put.

Use sperate patch to fix this problem

Frank
>
> Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index f6a812e49ddc..a9dfec3c0ca3 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -18,6 +18,7 @@
>  #include <linux/clk.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/reset.h>
>
>  #include "../dmaengine.h"
>
> @@ -916,6 +917,11 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
>         if (IS_ERR(chan->regs))
>                 return PTR_ERR(chan->regs);
>
> +       err = device_reset_optional(&pdev->dev);
> +       if (err)
> +               return dev_err_probe(&pdev->dev, err,
> +                                    "failed to reset channel\n");
> +
>         chan->bus_width = ZYNQMP_DMA_BUS_WIDTH_64;
>         chan->dst_burst_len = ZYNQMP_DMA_MAX_DST_BURST_LEN;
>         chan->src_burst_len = ZYNQMP_DMA_MAX_SRC_BURST_LEN;
> @@ -1152,6 +1158,7 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>  err_disable_pm:
>         if (!pm_runtime_enabled(zdev->dev))
>                 zynqmp_dma_runtime_suspend(zdev->dev);
> +       pm_runtime_put_noidle(zdev->dev);
>         pm_runtime_disable(zdev->dev);
>         return ret;
>  }
> --
> 2.34.1
>

