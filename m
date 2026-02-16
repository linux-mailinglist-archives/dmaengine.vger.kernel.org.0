Return-Path: <dmaengine+bounces-8914-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ7TJ+5zk2nD5QEAu9opvQ
	(envelope-from <dmaengine+bounces-8914-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 20:45:50 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C49E1147540
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 20:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2424B3003BD2
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 19:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C76234994;
	Mon, 16 Feb 2026 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ljo0olcH"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013042.outbound.protection.outlook.com [40.107.159.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402B526F2A0;
	Mon, 16 Feb 2026 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771271144; cv=fail; b=ChrWzlBYfVY4Dt0FqtW38jS3H9986VJJs2/PQh4XjbNS7J68tAFNHYCIIsESW/WOrEFsiRwFyc6g19pjflECpDLuJg/+AkBRN6QjWs3zIG5Hp/njjFzEld8xAgajL7PBZsDQ/y5oSWwCiAVKmNXdL3kgj96HI925N6OV9h9risE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771271144; c=relaxed/simple;
	bh=GRqIXEJI1ViglU5XFx9D0KkyUWiV2z1dGXV7cOjcxtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dS9bo2binhFzjsUuX46WehoxYcVLFCFOifDuk+c6IWOagbu6kBQGBotd1OrewOkTZgVcoZ//LOCq+5dhTYA7/QCOKqSK4cEua5dGmh+qpoYlqeca0MNzBjsQvV/RWc9rupeLrfAhdsKII4TiLgTx0pWBBHSAXp8UbZmo9A+yr0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ljo0olcH; arc=fail smtp.client-ip=40.107.159.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dt/81d0sk7/OM/rsBbGHTkZc2flPzMnceTW0vw60V+nR0+FWDJMrwQyLeufPfIUEdZwktKHu0Av8cx8Bb7Ae6bz2KtIQytk9iPHqsgecAJtUkRGoF7G4INlg6W+wVD5glVDMlwXztvApRv3O68nFV/GPM/i6g+7VjK7ByYqvbjxB0AsWd49sK7WWMHzX9hyoDF08vjWn/c5ZeCxTos3fMVBdOYZB7hzN1Gge66+SqV+R0TkmPIHH/hpSYuzyj9TiGLx038sIeiBEV3MYqXrS9Bx6vxx0EtjnS1GFz7lvEZ0lmpgPJq9z7NMJYh+M/HCv39j01BXS9mpBjAkD3+xHWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmGEt9qUQrCX9Qfqi7Ynp3+XHM0HR3lC9Tkb60WJgR0=;
 b=vY9tOVsPX3FpDs1EwrpEk0e1goPX60vhqLlqoIEQxvJdFHYQ0fzrpkOOfQqFLL0Tc/UaroEojlAQkCOdJRrzR7YUEG0g4l8DpSy/AyzSCJ7kVB26VBiVcJapUJjGDommhRO36mHgRbrDUOlIhM0nxz//lXff8mDP2Jx94oOppD6t1/BQbOitpqn5JXvbCrywzKRTdtG8ZEMDGLZkAYd8a+/vK6LLXkAZng30BxoN2NPK0/ZIy3lPR4/UsbKeaquwzMAgOBFF9isoh2J0rGc1lQg5ChblhoJBgnjBJsse+yghSt+oN1z2+s5AupIpQrO8VrRvaYg8vFyNJ/30+EYKXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmGEt9qUQrCX9Qfqi7Ynp3+XHM0HR3lC9Tkb60WJgR0=;
 b=ljo0olcHUPyIj4YsxoFtpHZS7bKFC/LgL3XKs5D3b79e+/zyBLlGbiGw7eBd8fwZwkMFFy4SodQbyXsoBMHa/FuAkyo551PHcZycF+yuCViC+4zayOJsJsS8HbqAtvDvYTnCdaJB2oK4UNemsXhtfACexkTjhL2P5yhbJuocorteWa/IeQT29GHNkMbteNzJpht7r1ErICrh2+mDGlkE2JJPhen42BEJ16Aheny3wLOUCs+HujfIjW0nHf6sJo/6PPyFnxzxXzFpK4ochdFyisyXDNLaxkQwTAPlzL8pmDZFjixPx6/LcyrAqcZdtpSeLDh8ze+HEDo9FQcZSWYUWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM7PR04MB6853.eurprd04.prod.outlook.com (2603:10a6:20b:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 19:45:39 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 19:45:39 +0000
Date: Mon, 16 Feb 2026 14:45:32 -0500
From: Frank Li <Frank.li@nxp.com>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <aZNz3DxDdzuIf2Ar@lizhi-Precision-Tower-5810>
References: <20260216105547.13457-1-devendra.verma@amd.com>
 <20260216105547.13457-3-devendra.verma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216105547.13457-3-devendra.verma@amd.com>
X-ClientProxiedBy: PH8P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::11) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM7PR04MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: a56b75ab-47cc-48f1-9ca8-08de6d93f610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lABRIeKfWq1iN+OS3EKVjpJ4UMleJznAQKZ4+ohOLWyXhQkGbu0S7lRXtGae?=
 =?us-ascii?Q?dRF/5S3Ja0Vqu64iabxbc6qPozmvKKy/kcWaah5nAh4oaXt60PQHNWaZTC1l?=
 =?us-ascii?Q?VipayvZKJ7IYUNeCckJvneDf6t8/UozSDvI8CXoSNhTwile4XUFPhGmCaskU?=
 =?us-ascii?Q?nFRR9E1n1XaZeY1fTNJbyKoTRN0lP8a8/KWEUV2PDT6TRjZTQkxyueGCm+Ie?=
 =?us-ascii?Q?ciM3O7ZRpnwP6Rh7vhtck2l7BuMi2avV8Z7P3lvOPaPogMiyqqXhzVFMwLe8?=
 =?us-ascii?Q?ki6ADGocLRJ+XN8j/4YGlwvBglSd/kq7+hOsW7BdqeoPoZayuxe0jkVs0aUT?=
 =?us-ascii?Q?hsJJvmg+XWZjFmIUMtIAvhLMBivQry0FqFs3pB5zEp9NiyOvkfZYpPBD95VC?=
 =?us-ascii?Q?Y2zIqY/DZUuWYvzZrx6U1qUJUEkIluCM5xUN4hiyqLQfhF01IosEqtkMt77T?=
 =?us-ascii?Q?wZRi2/Y+PWDW3OTIbCojawOgUaVK8Mv5mCaedbsNOgGStwBV4m86gumNS7fr?=
 =?us-ascii?Q?JjyBtkghmOwbU3OxhqATQi7e/0Bue5W1A/pDCFrc/xOYxarDWf5kNbxPGDxD?=
 =?us-ascii?Q?Eoaeo2MgrYzIJP7mhX+WfNoJ1EdfHsrmadtNJp9jr4DoIiP85fuS64d2KKqU?=
 =?us-ascii?Q?afGIxpDXg4xOdZNzUXTWi7mgMEEFl1TyEr/G4FASc222fp9UM75kaduus9Nz?=
 =?us-ascii?Q?ikKSYCQEP1ftNxAIyYExf22Ak3fejhvYrLumPLeuzoOOHWrVxcCar/r0Qybn?=
 =?us-ascii?Q?GGJZhRkVKZI2ToMtkGykBnzB4Uu33EJdzsEsB1+7qj1BcEeqco9Im6pU1GIe?=
 =?us-ascii?Q?M3FMZnIryqEDi7s2e0yr7ReZQRM/7TUeEXTjfNGhhyFvI5oUREidCQmYKfiU?=
 =?us-ascii?Q?VjRMZhJb8zRPiwS/1eQQxyMVKk9e1vlpgKSNHzMdumc2cDuA0fPCqwY0urJy?=
 =?us-ascii?Q?1DLhenvwJ2DpsAiwPrLO1a7l+NtVnTdNezbj/7zIYbCZ6vZHkHhFmsnPiAXZ?=
 =?us-ascii?Q?DlG1T5+Eho03jaVvLSbbAw59g4J97hfyKcex5DdYbJpRuvlQpyXUb3/Tswkj?=
 =?us-ascii?Q?Ns+4WEidJmzOrtzvdHgbQ30pI6+KI/Cm0ytGMRUxNanblJBJgdTnzITDEbc4?=
 =?us-ascii?Q?3g2dSqMMjID438BbYH8M4sN2fICnb8iYJZyv07T9RxVMiispVo7Fg5hscixM?=
 =?us-ascii?Q?225y3n58K8Zby4KiiWdxGRvaiahL6AZg/S2jPOz102MfQtlu71ymy0a0NR8Q?=
 =?us-ascii?Q?1OWVRW8uRQbr2osM+YX4l7gSUsOwFRx4oOEgff2zxKJdvfL2TSUkKaqWOkrM?=
 =?us-ascii?Q?gK7c1jq1xaaUxtc/HGCHZ4K3e2+qgtl9cYCcWwYo/i3jijyHb4FPjctJ97Ma?=
 =?us-ascii?Q?wZ4sm2i9VgW7E1AiN6JMW67iWJ2HvzECtHFQqEQsN8i7aCFcJXOYsezq2j+u?=
 =?us-ascii?Q?6JYnXp389fXOd+ruY7NBA6IqTI9nuPG42uwTL1UELYhj70M7FfbaOH9d2s18?=
 =?us-ascii?Q?2R0bHjQByot2uuJbRQGcUWTlSkaKLYEQ18x+8yz696G/TmltQGvsHYFMoUG2?=
 =?us-ascii?Q?AgKyfFN6s9i3oQzcvcm7/C2/UTgBhprhgeVrmqs2+rp+Dl/inX6WpZZozVdX?=
 =?us-ascii?Q?CnNDzaBVkFdBLoYSmpKOG+M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ruid0T3uWudjUnhhahr1Vy9OcXKZM8UphO4b8gT7z3J6sspyN07uFWNXk2Fu?=
 =?us-ascii?Q?thSwTmsgfDZKxjJt2geAvLvrpIljR9Ao7ciFTQjgwwsyIengBp8XsLZOI+Ay?=
 =?us-ascii?Q?bA55DhnlRiDiwQyR/5s6vbllA+7swBs4gCdLIR+iQq7DVrs7snOEmYTkcx3e?=
 =?us-ascii?Q?BNh8fjZw+PijC/nH/ktKtqke+jSly+5JUUCpifBQfPM4wrzjS+dHqf4mOYXq?=
 =?us-ascii?Q?ty7fQd5jGe88hOIQTwzbKj6YBIOIIhpUGYCtCuSKiZzGJSuF8zFs39vl7bnw?=
 =?us-ascii?Q?4cCYg1w0fDFpcrd/CUgqay4BHi7ap0ElIM5XuRNgUChX48AbAnqlZoIWQfaT?=
 =?us-ascii?Q?+BAizP/bLN/Y/sJ8L3Xy0E5IOiFUStIw+DnSVxZOfW04TOVpOlRZq7c3xUGV?=
 =?us-ascii?Q?J6n107KtJabt/Tc2kYl3jL69CTzB3urQ3xJpbvjV7rnyo1OzULyHzlLJ2AFj?=
 =?us-ascii?Q?DCcIVsIe3Mkk4JihybHabc5PdGAzM36cN97MfpjKoJzhdzj2dLEUHFN9yGRy?=
 =?us-ascii?Q?8uOrrh+88MnPeWUMSpWcU8uKaYfzvzoq1/9gnH6nBme/n145DN+2CwDXEI8T?=
 =?us-ascii?Q?6RP1so7kM4gouMBG9EKjW/IuWxdsdyF/wgap4tXujGIVdUBYNLH8ZArHtB77?=
 =?us-ascii?Q?ZwSo6o7uVdVbR6lIBeOyYd3XX4soNudTUN6OATurdgQRptPZSms/RhN0AKcI?=
 =?us-ascii?Q?2E4tMVMl02TYfUEFq1e6pCPHjd6EHWq8F3TH1Dm4uqywTYNwCy8sANAuol2K?=
 =?us-ascii?Q?0Ak3Kvj09J6f/kicKdUNQA6lsjcxrjW2kzbNQfsvLvHZbf4DeyX8VNDcfF8f?=
 =?us-ascii?Q?gLcVRLpvLjACVT8PFvd5WuJ5FiECee85IEpkBEergK0/domPEoetNvcheKwv?=
 =?us-ascii?Q?EItn+jDWn4l5sDGBrUrBj2NZiswwZ+XlnO1ekt2MyDVLmsb48jjscNhu9Q5Q?=
 =?us-ascii?Q?CSA5INK0CmMd2aCixZIXlFb3PitBRzVNzDd3N+Kx2jiUulQ3z3PZIl5xQXBx?=
 =?us-ascii?Q?wnvSvanXLwhFo5ah92VFN9/4fJatWCuta39PQ4N/oyAjjxQxSGRbPvJGcjBA?=
 =?us-ascii?Q?8cMGpeoUqt/caTdUY22GnnfoJc5qaRzqvq5lJi0t+JdHiSG6DjyiGLMLqWNt?=
 =?us-ascii?Q?UHQFUiMnKxbh2/cxEXXrFG0ec3NHQsD2SYBtmw4Sf8n8rru4VVJZTmnF/w5a?=
 =?us-ascii?Q?tnObR9gtBL0dbNiLPIqKHGniN2NJtdlfs3wZWe4gsCEl11yMiTEaplR4KJeJ?=
 =?us-ascii?Q?c2Uta4isob4GjQEU1XLIVWzulcicBqa/csGzvsVtIWByljiNpiy8FT+ffh9s?=
 =?us-ascii?Q?oZfHOOdAgEpqI4cgGnSo1jS6UTAxqkRFbmnimz93EzHtU1aBwYrxT5jhihef?=
 =?us-ascii?Q?+i9W/Eof6X3nZVCJnzF/GSKdmvBbMr84zmzE3o6lcI3tjWTLGEUmkpjnSYre?=
 =?us-ascii?Q?QOVayr9Ha4L58fAyRA4ggNTfJHasSZZgtXMXl1VDLhW5yVolwRHTZCAD/AJQ?=
 =?us-ascii?Q?O5VvHaUH5+GgpigDmsr0XzyZKNE8msRJD72Ya3pBOOYkQxjb0WSZq3FR5Xt9?=
 =?us-ascii?Q?zNkAEWgXy5ggdJ6mC93vbCUnMC87w7mnAM+ykeCEZLbVFnfEoWNZKIy9+4mj?=
 =?us-ascii?Q?a8MYhXmoBLwW4sMtP1BVN+B1Ul8MrtVt9E/WYL+nb9ut0s+mUfhJMoi3x+IZ?=
 =?us-ascii?Q?Olc1iCiv/vC60xjZ+ZWnVaj6lVArayWf5sg4pSuDkL3hUDPIIKFwrGeoyxDB?=
 =?us-ascii?Q?YtA61+g9Mw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56b75ab-47cc-48f1-9ca8-08de6d93f610
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 19:45:39.2586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVlBk6Rf1LTKTA84QaanR/FbHz2E+mNuUb8E9/ERPSSshPLRLzY6ad86rUKDOTyFsVG5jpzDCezyqwdt501IUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6853
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_FROM(0.00)[bounces-8914-lists,dmaengine=lfdr.de];
	TAGGED_RCPT(0.00)[dmaengine];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+]
X-Rspamd-Queue-Id: C49E1147540
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 04:25:46PM +0530, Devendra K Verma wrote:
> AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> The current code does not have the mechanisms to enable the
> DMA transactions using the non-LL mode. The following two cases
> are added with this patch:
> - For the AMD (Xilinx) only, when a valid physical base address of
>   the device side DDR is not configured, then the IP can still be
>   used in non-LL mode. For all the channels DMA transactions will
>   be using the non-LL mode only. This, the default non-LL mode,
>   is not applicable for Synopsys IP with the current code addition.
>
> - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
>   and if user wants to use non-LL mode then user can do so via
>   configuring the peripheral_config param of dma_slave_config.
>
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---
> Changes in v10
>   Added the peripheral_config check only for HDMA IP in
>   dw_edma_device_config().
>   Replaced the loop with single entry retrieval for non-LL
>   mode.
>   Addressed review comments and handled the burst allocation
>   by defining 'bursts_max' as per suggestions.
>
> Changes in v9
>   Fixed compilation errors related to macro name mismatch.
>
> Changes in v8
>   Cosmetic change related to comment and code.
>
> Changes in v7
>   No change
>
> Changes in v6
>   Gave definition to bits used for channel configuration.
>   Removed the comment related to doorbell.
>
> Changes in v5
>   Variable name 'nollp' changed to 'non_ll'.
>   In the dw_edma_device_config() WARN_ON replaced with dev_err().
>   Comments follow the 80-column guideline.
>
> Changes in v4
>   No change
>
> Changes in v3
>   No change
>
> Changes in v2
>   Reverted the function return type to u64 for
>   dw_edma_get_phys_addr().
>
> Changes in v1
>   Changed the function return type for dw_edma_get_phys_addr().
>   Corrected the typo raised in review.
> ---
>  drivers/dma/dw-edma/dw-edma-core.c    | 35 ++++++++++++++-
>  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
>  drivers/dma/dw-edma/dw-edma-pcie.c    | 44 ++++++++++++------
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 65 ++++++++++++++++++++++++++-
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
>  include/linux/dma/edma.h              |  1 +
>  6 files changed, 132 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index b43255f914f3..ef3d79a9f88d 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -223,6 +223,31 @@ static int dw_edma_device_config(struct dma_chan *dchan,
>  				 struct dma_slave_config *config)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	int non_ll = 0;
> +
> +	chan->non_ll = false;
> +	if (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE) {

Need handle EMDA case. if mf is EDMA, need return error when
config->peripheral_config is not NULL. Or remove above check to make
code work for both EDMA or HDMA.

> +		if (config->peripheral_config &&
> +		    config->peripheral_size != sizeof(int)) {
> +			dev_err(dchan->device->dev,
> +				"config param peripheral size mismatch\n");
> +			return -EINVAL;
> +		}
> +
> +		/*
> +		 * When there is no valid LLP base address available then the
> +		 * default DMA ops will use the non-LL mode.
> +		 *
> +		 * Cases where LL mode is enabled and client wants to use the
> +		 * non-LL mode then also client can do so via providing the
> +		 * peripheral_config param.
> +		 */
> +		if (config->peripheral_config)
> +			non_ll = *(int *)config->peripheral_config;
> +
> +		if (chan->dw->chip->non_ll || (!chan->dw->chip->non_ll && non_ll))

if chan->dw->chip->non_ll is true, It should return error if you set non_ll
false because no LLP base available.

> +			chan->non_ll = true;
> +	}
>
>  	memcpy(&chan->config, config, sizeof(*config));
>  	chan->configured = true;
> @@ -358,6 +383,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  	struct dw_edma_desc *desc;
>  	u64 src_addr, dst_addr;
>  	size_t fsz = 0;
> +	u32 bursts_max;
>  	u32 cnt = 0;
>  	int i;
>
> @@ -415,6 +441,13 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  		return NULL;
>  	}
>
> +	/*
> +	 * For non-LL mode, only a single burst can be handled
> +	 * in a single chunk unlike LL mode where multiple bursts
> +	 * can be configured in a single chunk.
> +	 */
> +	bursts_max = chan->non_ll ? 1 : chan->ll_max;
> +
>  	desc = dw_edma_alloc_desc(chan);
>  	if (unlikely(!desc))
>  		goto err_alloc;
> @@ -450,7 +483,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
>  			break;
>
> -		if (chunk->bursts_alloc == chan->ll_max) {
> +		if (chunk->bursts_alloc == bursts_max) {
>  			chunk = dw_edma_alloc_chunk(desc);
>  			if (unlikely(!chunk))
>  				goto err_alloc;
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 71894b9e0b15..c8e3d196a549 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -86,6 +86,7 @@ struct dw_edma_chan {
>  	u8				configured;
>
>  	struct dma_slave_config		config;
> +	bool				non_ll;
>  };
>
>  struct dw_edma_irq {
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 3aefc48f8e0a..94621b0f87df 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -295,6 +295,15 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>  	pdata->devmem_phys_off = off;
>  }
>
> +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> +				 struct dw_edma_pcie_data *pdata,
> +				 enum pci_barno bar)
> +{
> +	if (pdev->vendor == PCI_VENDOR_ID_XILINX)
> +		return pdata->devmem_phys_off;
> +	return pci_bus_address(pdev, bar);
> +}
> +
>  static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			      const struct pci_device_id *pid)
>  {
> @@ -304,6 +313,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	struct dw_edma_chip *chip;
>  	int err, nr_irqs;
>  	int i, mask;
> +	bool non_ll = false;
>
>  	vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
>  	if (!vsec_data)
> @@ -329,21 +339,24 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>
>  		/*
>  		 * There is no valid address found for the LL memory
> -		 * space on the device side.
> +		 * space on the device side. In the absence of LL base
> +		 * address use the non-LL mode or simple mode supported by
> +		 * the HDMA IP.
>  		 */
>  		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
> -			return -ENOMEM;
> +			non_ll = true;
>
>  		/*
>  		 * Configure the channel LL and data blocks if number of
>  		 * channels enabled in VSEC capability are more than the
>  		 * channels configured in xilinx_mdb_data.
>  		 */
> -		dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> -					       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
> -					       DW_PCIE_XILINX_MDB_LL_SIZE,
> -					       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
> -					       DW_PCIE_XILINX_MDB_DT_SIZE);
> +		if (!non_ll)
> +			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> +						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
> +						       DW_PCIE_XILINX_MDB_LL_SIZE,
> +						       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
> +						       DW_PCIE_XILINX_MDB_DT_SIZE);
>  	}
>
>  	/* Mapping PCI BAR regions */
> @@ -391,6 +404,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->mf = vsec_data->mf;
>  	chip->nr_irqs = nr_irqs;
>  	chip->ops = &dw_edma_pcie_plat_ops;
> +	chip->non_ll = non_ll;
>
>  	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
>  	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
> @@ -399,7 +413,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	if (!chip->reg_base)
>  		return -ENOMEM;
>
> -	for (i = 0; i < chip->ll_wr_cnt; i++) {
> +	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
>  		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
>  		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
>  		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
> @@ -410,7 +424,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>
>  		ll_region->vaddr.io += ll_block->off;
> -		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
> +		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> +							 ll_block->bar);
>  		ll_region->paddr += ll_block->off;
>  		ll_region->sz = ll_block->sz;
>
> @@ -419,12 +434,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>
>  		dt_region->vaddr.io += dt_block->off;
> -		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
> +		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> +							 dt_block->bar);
>  		dt_region->paddr += dt_block->off;
>  		dt_region->sz = dt_block->sz;
>  	}
>
> -	for (i = 0; i < chip->ll_rd_cnt; i++) {
> +	for (i = 0; i < chip->ll_rd_cnt && !non_ll; i++) {
>  		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
>  		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
>  		struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
> @@ -435,7 +451,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>
>  		ll_region->vaddr.io += ll_block->off;
> -		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
> +		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> +							 ll_block->bar);
>  		ll_region->paddr += ll_block->off;
>  		ll_region->sz = ll_block->sz;
>
> @@ -444,7 +461,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>
>  		dt_region->vaddr.io += dt_block->off;
> -		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
> +		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> +							 dt_block->bar);
>  		dt_region->paddr += dt_block->off;
>  		dt_region->sz = dt_block->sz;
>  	}
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index e3f8db4fe909..a1b04fec6310 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -225,7 +225,7 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
>  		readl(chunk->ll_region.vaddr.io);
>  }
>
> -static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> +static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
>  	struct dw_edma *dw = chan->dw;
> @@ -263,6 +263,69 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
>  }
>
> +static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
> +{
> +	struct dw_edma_chan *chan = chunk->chan;
> +	struct dw_edma *dw = chan->dw;
> +	struct dw_edma_burst *child;
> +	u32 val;
> +
> +	child = list_first_entry_or_null(&chunk->burst->list,
> +					 struct dw_edma_burst, list);
> +	if (!child)
> +		return;
> +
> +	SET_CH_32(dw, chan->dir, chan->id, ch_en, HDMA_V0_CH_EN);
> +
> +	/* Source address */
> +	SET_CH_32(dw, chan->dir, chan->id, sar.lsb,
> +		  lower_32_bits(child->sar));
> +	SET_CH_32(dw, chan->dir, chan->id, sar.msb,
> +		  upper_32_bits(child->sar));
> +
> +	/* Destination address */
> +	SET_CH_32(dw, chan->dir, chan->id, dar.lsb,
> +		  lower_32_bits(child->dar));
> +	SET_CH_32(dw, chan->dir, chan->id, dar.msb,
> +		  upper_32_bits(child->dar));
> +
> +	/* Transfer size */
> +	SET_CH_32(dw, chan->dir, chan->id, transfer_size, child->sz);
> +
> +	/* Interrupt setup */
> +	val = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
> +			HDMA_V0_STOP_INT_MASK |
> +			HDMA_V0_ABORT_INT_MASK |
> +			HDMA_V0_LOCAL_STOP_INT_EN |
> +			HDMA_V0_LOCAL_ABORT_INT_EN;
> +
> +	if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
> +		val |= HDMA_V0_REMOTE_STOP_INT_EN |
> +		       HDMA_V0_REMOTE_ABORT_INT_EN;
> +	}
> +
> +	SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
> +
> +	/* Channel control setup */
> +	val = GET_CH_32(dw, chan->dir, chan->id, control1);
> +	val &= ~HDMA_V0_LINKLIST_EN;
> +	SET_CH_32(dw, chan->dir, chan->id, control1, val);
> +
> +	SET_CH_32(dw, chan->dir, chan->id, doorbell,
> +		  HDMA_V0_DOORBELL_START);
> +
> +}
> +
> +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> +{
> +	struct dw_edma_chan *chan = chunk->chan;
> +
> +	if (chan->non_ll)
> +		dw_hdma_v0_core_non_ll_start(chunk);
> +	else
> +		dw_hdma_v0_core_ll_start(chunk, first);
> +}
> +
>  static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> index eab5fd7177e5..7759ba9b4850 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> @@ -12,6 +12,7 @@
>  #include <linux/dmaengine.h>
>
>  #define HDMA_V0_MAX_NR_CH			8
> +#define HDMA_V0_CH_EN				BIT(0)
>  #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
>  #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
>  #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 3080747689f6..78ce31b049ae 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -99,6 +99,7 @@ struct dw_edma_chip {
>  	enum dw_edma_map_format	mf;
>
>  	struct dw_edma		*dw;
> +	bool			non_ll;

Can you check ll_region directly? it should be equal to
(ll_region->sz == 0) ?

Frank
>  };
>
>  /* Export to the platform drivers */
> --
> 2.43.0
>

