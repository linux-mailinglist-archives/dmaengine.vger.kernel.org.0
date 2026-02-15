Return-Path: <dmaengine+bounces-8905-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAl/J73kkWnWngEAu9opvQ
	(envelope-from <dmaengine+bounces-8905-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 15 Feb 2026 16:22:37 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F28A13F091
	for <lists+dmaengine@lfdr.de>; Sun, 15 Feb 2026 16:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D735330094F5
	for <lists+dmaengine@lfdr.de>; Sun, 15 Feb 2026 15:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED412989BC;
	Sun, 15 Feb 2026 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="IfUgUJUN"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021095.outbound.protection.outlook.com [40.107.74.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BF822D792;
	Sun, 15 Feb 2026 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771168948; cv=fail; b=QTVkVJcT7at+U2iSeNuCSvncnUyjBq+c6nJ327mWkUxcqhJKkQtX2pKRTKd9q/6KfRxHXOXWIF6qOfqjqJrbg9A7dhCyejST/r0cj06RXKrkpJUq8qAwvOKUqduWDEwcuizwQiMtlE6rn85UGfohHRVXRvJ8RjzVCjIn8qnjjTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771168948; c=relaxed/simple;
	bh=t5oZL7qw6YiC503AxTUXnPEuYbhL+hU3d4ntPaAHDAs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=p0zZgXfYZmDAAafUj4HAKcZVgZOekc5C/QR/6wvZPRvovUQVAjpwEaTTDRxJUuVy1R7S2Wq2axxkt0wc7X0FzA8D1epFZng5hlEb/vpFob83wue0Bq1AseLf0djZNqboUBoFGDvZ13RJEWT7E5Fhtk2/RXM4jt08zvQPlg2dC+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=IfUgUJUN; arc=fail smtp.client-ip=40.107.74.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNq9nvmT7oHtk74dceDmeVfogMj8AhDB7tIakm9Uf7dXO2nxIVA6xtAJXdyKePeF4cqCrBfimVwd9INmJJP+F163yxK3GqFGmUv8v3p/k8R9DB9noZiBnemIqws5n0yHl4fMKjthCJqfPsS0aimbmxuJbF/THZKoFf/loHvD9mKE7XeMGJ+skEJPCVn+SY/uMxc86gfWHqsuyOhX/XVUk9BDteVgmvAT3dBCZPtWoBSSt1NKxmEeB2PEXFToEfNSYVQCF90tru8uIm3GWc8S0xNP+YCZ6E2um8wX8FY3e40QIWpljvlSx3oCraTbMgD72qsltpEG2X5t4uOuV4vekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqbpHZqKSCmYt1AcCceXb4w14JAhjiXVr/crbo3AyA0=;
 b=rq//UhKQ2iQfyq9u2bzW1UFURFNp7CczRNToqxke1NAcVRLLDfZIzPD5WNz/OJzBFnCvVDn1CdDMznFRhRgYboEV8U9qM6/dcfFH2ChmwJbggGtRTYzpK/ppebIZzKkkBmxyJNajCithd2k3+jFXV1ejGeiwB2K4Y+HnDfNJHnSrJ9pgfRmXdb5XTQ2BclaaA8vOLUvyTTRWlFen0ncnMYUv5UFeMsZjzGpRdmtous6f8RvpX1Tgl01chT3LkD67tQCPZ8VyeT9MO9Fp/xsYO1Wl8UHF0quTMySUSaDyDeS8l/V0XlPxwRI2+w7DFFpaKaIjP8YsQ7qqznJqiDxqzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqbpHZqKSCmYt1AcCceXb4w14JAhjiXVr/crbo3AyA0=;
 b=IfUgUJUNnwh1P/QA9crpurOzj1i94XeWVEUchOamIHexw4FpmcM7pu+rISneA3GVi3zxpynrGkCjYcxrHZOMTRLlofIxtiPjK5BRq4BjNzhQrfN0q9kjZN9xmFv8Czl6zPjEnm1dOj8rjspoQT3R6juS4wqfXG5FAXK/vfGI4sM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2340.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:169::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 15:22:21 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 15:22:21 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	vkoul@kernel.org,
	Frank.Li@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] dmaengine: dw-edma: Interrupt-emulation doorbell support
Date: Mon, 16 Feb 2026 00:22:14 +0900
Message-ID: <20260215152216.3393561-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0097.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2340:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6d4e93-7da8-431f-6634-08de6ca603a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QBnOuAPSAoMbu5ikbXdYAgrhi1LE4bPb7iZYTh7eis1c0s+X06B5g8G0f6B8?=
 =?us-ascii?Q?bEsElf2sRIb19x/UmF4O50J63dmpm4g8Lz4P9OdpjW+te8y9D3IFBb4CxQby?=
 =?us-ascii?Q?UA22d9v53CWn+MmEm1ljDEyopOINe+lc/LayRA/faB9PdeRs3V99bKz0Zo1I?=
 =?us-ascii?Q?TP972zNcXI4Mp06FvVPBVyudhQocD1vL7Mbqg9fZLArMngTi5AVhueJDZeJ8?=
 =?us-ascii?Q?E1KZB1E+d/HHUPivguP8AG+Pf2MuXk4MKVBVrSZOXV7ddaV8jxRmvpKMeti/?=
 =?us-ascii?Q?d0wY0AB9hmwl3dhh0LG0LN64hOi4JBvSSpAL0tYae5sAXzunxIk35xMv+w/C?=
 =?us-ascii?Q?2SLi/5MWjP1YckzH86PWjepOP3T7/ALBjoU/Aa/+XifYoQdrXkwNMllTGFpf?=
 =?us-ascii?Q?aNeG0tSG8+gTtG5AYTbqJrg36Ieq+SDmmWy5uOl5RGSGiqQ3VL9qhzVMlUEq?=
 =?us-ascii?Q?MHLmdLgn0fWtEKzN1OI+T6DKWNCFPDVjOmMk/OHrLKT1acl/eaA/hYk8lYQO?=
 =?us-ascii?Q?F1xkPhPQaWmWLSNg4SrAJyhSNSIUr+7K2u0K0XTEy9/l0a3pVM3oBjNGzxOE?=
 =?us-ascii?Q?oWdBMTOzqd0GlDN9LGtdCODSo4+ZtO4a7qivdgnpd1NXPxOhA/fcuNf9iDzm?=
 =?us-ascii?Q?xyDwK+lqDmBTI2shoteIZos9HbgPztqiMCKGI6Nzsb3ii6FfTOfiyMJpa+XM?=
 =?us-ascii?Q?N9uKSOsmiNFj3PM/HUGHS/Fs9bJONt5kpk2AXxjD00KFgy3umQCH+VzQU408?=
 =?us-ascii?Q?7+qjP6g6MTil64iY6a4IzIyT8t31HRp5Zw4CeazGhYKMMjIfiAczHSuiy42B?=
 =?us-ascii?Q?nD0RDBZOf3o9GTBM3H1hK77Tlk135dDDWOOa96b1MnGx5f6MQ45O1soHGaKX?=
 =?us-ascii?Q?PTAxyMFszbdzhQDXdqSGnd70rmH2Aq3enFmsz6IIE2b6+UDL1wub+1tcbxmp?=
 =?us-ascii?Q?PqfP30/g2G/9Q6e/Goh1MkgZ1buVbop5fmPcfL1SwsoxpdxD9Wq7cpT6bGb8?=
 =?us-ascii?Q?/bcGbndHhmR8a3AG2YsXpkyzQArx+rL9bSAIVT8qCq1pgNlEu1Bbd0GE3QHI?=
 =?us-ascii?Q?NDQ5+jNVfEiOjTYSyAdZ+alrl8kNaHsvTKpo3pQ1gtIA8NmYjTEq7N//pYqa?=
 =?us-ascii?Q?5HT8zL1kyI1K8SXodkv8AVricum3MMKoBthxpt9HuTZ5LuKJbkhKvlaT8Ipl?=
 =?us-ascii?Q?BLyZ+eq/4YYCuJ4qCaPkjadPrT+A4Bl08nzRpUapgBN1TwU5RBXFL9Iknvp6?=
 =?us-ascii?Q?71QjhQN37Qqht+Vh+2hcSZaRVfIOabzAvQPPqTEeoR4K0vlP0yQ+OeyTPA/0?=
 =?us-ascii?Q?LwEoYc0UWrUWBavj21LUryjzmdjbhsSEgp/IeCOcUdYixpwN8M+LouDx0nBb?=
 =?us-ascii?Q?iIJ0J7xSj1p/vfIfAv9llA+XZe/w9qNkCCuaWasguzSHJRsMUERWz3LMB9M7?=
 =?us-ascii?Q?oTr/W0P09NegGTjN7XlR9dpMniGPtvCs8H1LW8+v7hHl6ZdGiPv32yxfZ4JZ?=
 =?us-ascii?Q?qpFwZPdOiyOywAnmcm/T+I2lwhhXZTPoTU7kDKLsEFD0Trqek0FCxZSDg2aJ?=
 =?us-ascii?Q?0FL696KGKdOypqzAZF8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eZOCy4SY4MS/HrrCtb6yrl+yV3TtOLsxHDWERywpJ+m8liDoi05IdPjYSOfn?=
 =?us-ascii?Q?zyBHa7vOS0bdgTztAeThcWIn1uxGBCrc7LFMcetBX5/vicIA0303qI20t962?=
 =?us-ascii?Q?9ozVrFPa1MrrcanuBVHSBjtYlViI6lDptys8A6SPud1bqKyhUOBkRyIRx+Ih?=
 =?us-ascii?Q?/1Ma0mcc1oE7usi31uW5FzDCNwzkVZYYg1fSdLQfX6fQKmIG/bjll61Z7KMS?=
 =?us-ascii?Q?FpUiZcZ8a9cZugE9/hW6/QQ9XCi3iQLyRWLMgA4CizFbJ/t3OLK4WP7Dgtb+?=
 =?us-ascii?Q?KEEJfUMo4dzPxjaUP1RZKu/y6vZdmFSirqMu8KFHwFs6P9l0LnkAXqjhY8Ue?=
 =?us-ascii?Q?YIc6PA+1Kv0ixI9SDuGFifNTKK+osiF4Lcuao3zt+B2KGE5JffPdZ83KwLiY?=
 =?us-ascii?Q?3BDZzTAacueXtgvtlOkNQNOTG2AFjERssnCnzE++PY/9VcmSYEv15lH56/UE?=
 =?us-ascii?Q?aHqh9fs/dMzCTHsFQIKWcLc0LVmNAe5YZ4fs46miSE5z2e4+MdAhB0IfGgDi?=
 =?us-ascii?Q?MA/Qsf4qsZDX+npS/cvgy+WTv35NPB+X0fYvk9avHDlhePTr5AFTRbYwoAC6?=
 =?us-ascii?Q?fJt9gEmSOQtqBgm1Vdhxj7ooeAp2YfB0Ov8clF+foEZ2aGw9DEvE0R1uCfH3?=
 =?us-ascii?Q?/G2r8NsL6no25CyMPMJKDJhDuCzDN6vIJ8KJtTMBsw5JUZQNfeIvbINyFsc7?=
 =?us-ascii?Q?yD9BQON3BgJQm/nSjY0HeyHvI9WWUC+p2Z19uL9jfgW8zbVTUCoPqtM4+ayD?=
 =?us-ascii?Q?HOaaom+JRxSRp0HBRKYtgjyKZGSJmZGO8drCp1Ohevj9ePhrupmtRAUnZuFv?=
 =?us-ascii?Q?JdJ6/HISVcVjbtIzsQiHMauKsBJBPeORnZ8lpN+YrXWAMt5NkaAPS5jxn/Hh?=
 =?us-ascii?Q?/j+qIdV5H4ZtaN/oRfOZmDJ1Y+HI4AtVkoa8QfGseqSh4axesdqcyjkCt2nH?=
 =?us-ascii?Q?1jKW6Jza64aF2+XODzmHRqn3srTM6y/0+f6hX/oM9yqRoYg1aThan7UhK9AL?=
 =?us-ascii?Q?RyowRHx1yhX36DAmN9APHcsVF/pnWOZ2Z+IejvXnkA//M/k4JQLk7TdEMgvV?=
 =?us-ascii?Q?lHFvm6cAecPWP942wgtkdUtskIDt+itmwxJ31w/C90SfEuUDdPc7jAUhRMov?=
 =?us-ascii?Q?s2Wefl0vxZHacamWitJ6CUikHM1ZA7Cao/XbLJkqaUYVCSqq8ROJJFgA91kU?=
 =?us-ascii?Q?0qr+RwCTAWWRfa3LhziN6YywdYYwbChQhcWcFrjDrcocTc0uKmw7NtHp9V28?=
 =?us-ascii?Q?yRZtobmMQvKVi+PPCUJ4ac2DHe/gQBk45OKJF4xBOcCINSyfKOjKLl/1GVgv?=
 =?us-ascii?Q?32rihX0XV/060bDOCTMmN5BwpNQ48cFtEvvqV2u2Le9yi/oveIykbc+YWhZC?=
 =?us-ascii?Q?w16+o39UQS1wErO/lBk4SAIN9kXvARaOIsVHjSkMI6HOVn7A16kfk5sdWBAw?=
 =?us-ascii?Q?3s9a3TzljXBaMG8x426xEI9/HcCg0E+CcdcSKCftPMwQLQ3Lv+BLPk10l4H0?=
 =?us-ascii?Q?nuXDhJdf7zHjdyWtQinOHQiPW85YwIXgIcWvFmmOZVfXIWczp+W6nFMHU0GW?=
 =?us-ascii?Q?JQinCvMfLGuaJjg8TJrVcEbRcx06s+A/VguTkeam2lyopcJfTLfDu7t+JaKf?=
 =?us-ascii?Q?GSrShmqVW1pLxy+bBaDrbfnBUnEU20z3wj7/w36MbxhzvSCxak3IffQTrV1r?=
 =?us-ascii?Q?ROwE+SaJoUFzkRbHM9mDCf/bLbjwlthCqaXWGFZ9udq3OmxDpDlVpdpVhAlS?=
 =?us-ascii?Q?nfHu3KOqtP6GhVOVpyGtVTEVV2stC6rS2euuluMNUzfZ2FB3uMXB?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6d4e93-7da8-431f-6634-08de6ca603a5
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 15:22:21.5401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bv8BXjXKPbqv167/uhVuplHUS+l42LThswU+jRXtRdl0FryNaLAUZ7ljUIAtbYNpHKri3/H0vSDcAyJCrskOcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2340
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-8905-lists,dmaengine=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[valinux.co.jp:+]
X-Rspamd-Queue-Id: 0F28A13F091
X-Rspamd-Action: no action

Hi,

Some DesignWare eDMA instances support "interrupt emulation", where a
software write can assert the IRQ line without setting the normal
DONE/ABORT status bits.

In the current mainline, on implementations that support interrupt
emulation, writing once to DMA_{WRITE,READ}_INT_STATUS_OFF is sufficient
to leave the level-triggered IRQ line asserted. Since the shared dw-edma
IRQ handlers only look at DONE/ABORT bits and do not perform any
deassertion sequence for interrupt emulation, the IRQ remains asserted
and is eventually disabled by the generic IRQ layer:

  $ sudo devmem2 0xe65d50a0 w 0

  [   47.189557] irq 48: nobody cared (try booting with the "irqpoll" option)
  ...
  [   47.190383] handlers:
  [   47.199837] [<00000000a5ecb36e>] dw_edma_interrupt_common
  [   47.200214] Disabling IRQ #48

In other words, a single interrupt-emulation write can leave the IRQ
line stuck asserted and render the DMA engine unusable until reboot.

This series fixes the problem by:

  - adding a core hook to deassert an emulated interrupt
  - wiring a requestable Linux virtual IRQ whose .irq_ack performs the
    deassert sequence
  - raising that virtual IRQ from the dw-edma IRQ path to ensure the
    deassert sequence is always executed

This makes interrupt emulation safe and also enables platform users to
expose it as a doorbell via the exported db_irq and db_offset.

This is a spin-off from:
https://lore.kernel.org/linux-pci/20260209125316.2132589-1-den@valinux.co.jp/

Based on dmaengine.git next branch latest:
Commit ab736ed52e34 ("dmaengine: add Frank Li as reviewer")

Thanks for reviewing,


Koichiro Den (2):
  dmaengine: dw-edma: Add interrupt-emulation hooks
  dmaengine: dw-edma: Add virtual IRQ for interrupt-emulation doorbells

 drivers/dma/dw-edma/dw-edma-core.c    | 127 +++++++++++++++++++++++++-
 drivers/dma/dw-edma/dw-edma-core.h    |  17 ++++
 drivers/dma/dw-edma/dw-edma-v0-core.c |  21 +++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c |   7 ++
 include/linux/dma/edma.h              |   6 ++
 5 files changed, 173 insertions(+), 5 deletions(-)

-- 
2.51.0


