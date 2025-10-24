Return-Path: <dmaengine+bounces-6984-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F48C0739F
	for <lists+dmaengine@lfdr.de>; Fri, 24 Oct 2025 18:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FC03AD602
	for <lists+dmaengine@lfdr.de>; Fri, 24 Oct 2025 16:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3501A332EC4;
	Fri, 24 Oct 2025 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="s+r1q9eI"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010061.outbound.protection.outlook.com [52.101.228.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF98336ED9;
	Fri, 24 Oct 2025 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322317; cv=fail; b=FWrz9kqP4HCDSVc3dGJ3xq5ZQTACZrcEjoKFNn4P5d5vmVYM+qGYQhssOH8pXAJPAYfa6vLeU63rIJdr6tOCeXqc4CTlPcG7bnYlwMLPtvt1r4OpEfN2Vj99S3ZuIP288kI7Spr3taKvCKfS5TdYhrumEJ3NDD75/+mmROAPASE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322317; c=relaxed/simple;
	bh=A7ErNSVB1Sho97ikzIHuJ6O6nXnlV3yX+w4W/Zfr9ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cwIwZ0iGeizTlTvmp2Q+bFPwvZKZn6Hrjm6PU2ZJCavLc/0DYQrOpfcAdzO1I7nnLxpVZXxh8yH5JmI2xcWlA/43hCsZDfc1kTeIlGXR81j9kXayDnmcQOpOZjsMu1d32U4ckaVZVxhDq8QXZOrJ8p6jOBR5SkXFby5sVKKYO2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=s+r1q9eI; arc=fail smtp.client-ip=52.101.228.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y49EL7KOAwlUQKcy2ljR9L+VyMUZC+Auf1xR8snZRclTi8FbNLBSzmO5/8oocfDnaGaFo0naK3jdx9IssO1pOTS0US4GyGeI6/C3rPm9bQ0xzq2Nv0VJ8euR1eu8Czr1WlUCGBTe0rEJoaI8bEc/BwM98dKX2l6u/lF9r+5N6EvkDH0Xks25C2gp64oW0OHu0LcneiVDwmaiec47UaLvzapXv5TgKB6Cj84jEJaJwZFAiICkJ58mmrqciOB9D/3bd/kt8rCxqTR/X6izlJMBuAxG5jD6Tfefc99FKawIH8MBB9G2sIZ68iULTSOs6X3gZ3YgGsKdwOJBks/PuhgAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+dMhY9EQ/pDE3kGj+aUzHiUQztYoER9SMdH3tWxDd4=;
 b=fa6pmfGIfJLVW0S3CmMrAkcZHKNTov02nDE4GUh+Rz4PLEgEaCswIE+TDHh6uFn33VXzpjx1vPfdJg0AN2EqylyHSW7YBLPdpYQDsCMSfwlW4gdmEFANLK9gsUeaZ7O28/OF9tarH+E7m+S0aMsDrl/RY0nFK36Eyg6RA5Vk9O52FJnbf6UqPAmvPvTIQN8B1askqEHhxO8AC0jU18NXBhDktWAGWaiVjzwozHFjJF592QW31sJl7SMDz+x7YxXXblTOP9BKN5dMt0mUVs//dCStEBoWCPMhwcF+pokK7mgCQnVNE6eD49iOM0OQA6z7pOx0cjItaewfjzDNQjF/bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+dMhY9EQ/pDE3kGj+aUzHiUQztYoER9SMdH3tWxDd4=;
 b=s+r1q9eIov94Aq9Pt1S+fc9xuZxmlUUNmALbEPYQ5+wbfB2PyBcxNCOaamUZZrGoWy34g2iFEh8WJBd10lBQMicgDNCnjD/HYPwBjNlFsIgY8ucK4rFBqvwqSN1QG5vdwdDJ7L8fiF7v9Y3Y3+Y2V32RYyuBqwIBmKd8UNvzMlI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYYP286MB4675.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:197::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 16:11:52 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 16:11:52 +0000
Date: Sat, 25 Oct 2025 01:11:51 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, 
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, 
	Frank.Li@nxp.com, fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH 00/25] NTB/PCI: Add DW eDMA intr fallback and BAR MW
 offsets
Message-ID: <vjo5ov47vta4ufgcalhvx2vqrioo3rzipht377pbxjx6dhhwvf@mn6dg2wmxjek>
References: <20251023071916.901355-1-den@valinux.co.jp>
 <1jqzuu2gsh.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1jqzuu2gsh.fsf@starbuckisacylon.baylibre.com>
X-ClientProxiedBy: TYCP286CA0121.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::14) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYYP286MB4675:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e53d5f-f4e2-440b-6178-08de13180b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1jlcq/nNPIFZS2QedzsHH/chDDnJG9IzveDs3CCqEdTqJmvJ7aye4p2zFJBH?=
 =?us-ascii?Q?KUyMdFtes82RnIAi3iM1HMoS7XWo0YV2wzDvaam76+0OSWu7zymKkJmlqRcg?=
 =?us-ascii?Q?kfCe71vHFnUHcrFQ4NjLeSX0bpv0ra8gYS4jggg07TF7b6N3u/0Th2laP+cF?=
 =?us-ascii?Q?91BOQtufa6/CUymnC67pEtxzv+XoLraJJ4/lzQVgxByoeUD7PkiQkzDQQ8Uj?=
 =?us-ascii?Q?sCTri8daE4pnztJR/kf4x+N8rsaaP6D/GHCdIeL5vf/e02EF32P7CZGR9J8T?=
 =?us-ascii?Q?aOqDFrvzT3Fe1pJ78iZ+li7XMpvg+VYtOhtbNDHr9Nb5vLXeHRAy/dojHOTB?=
 =?us-ascii?Q?XR7unIHGgHuVAq+wuafJLlOQq1vaq2WvE8wVGc3Xxm7+ELlkhBFQ8Rgl1gbd?=
 =?us-ascii?Q?miy5nekrBnI1HsFoTbJPFoWNPiIHyi35k9HhryadcL4JSo8PeOFGz2W6qchV?=
 =?us-ascii?Q?7vHmFQYZydxxLoZ8cm1Fg3lDZcPNR+9R/AXxAMud14/FhllmFpF30+lg6bw/?=
 =?us-ascii?Q?hzAFjXY7EzAr1MuQhY0MYyuWYchXPeu3D4ekNDkRbEOLIsHIqxqDNrdz03sA?=
 =?us-ascii?Q?3MOAewT0yzK5+l+AFDzmLvVi5DXnG/KfC5j8dk0kzWXGdxoxu1dtMKuyqYLH?=
 =?us-ascii?Q?H6srhDDlw5tPGqrrtgt+TYz3aqFdYEBPYGMWCAnkWnUAMJnHBHlV4ytyM4qG?=
 =?us-ascii?Q?sjbmtfJrDNoxRGH0B07K+Z5Yk+RsQLHgmVTntxIX+QijN0Ckeq1nTWzSCS6c?=
 =?us-ascii?Q?R7WkjgEFIKKEE4cegmuvnjK5/zl4mMDsvAnXGutj1ZOFcMWs1Yg68FPH5YiL?=
 =?us-ascii?Q?psiAkqY0UkGT3qo7tI5fkX3EVTM02zlEh2J99E99YG8aa/JLQgmfNMfq7tPo?=
 =?us-ascii?Q?jLpaIA6ZKfeknbmUE/Op7YUI1XvF5VkGW6+ErCU3WLq6mYhK07EjJsK8QZ+y?=
 =?us-ascii?Q?O/JHj+T+D+aPo+qVHKVf+s2Be9g9d3EAnf5W6lEp/lOXNM4gDKOJjVliCca/?=
 =?us-ascii?Q?ACmkrgSbHIK3g7Q/WzByTiFNGtChf6x9Tl29DBnbbP7Kh+mXjypHXkeH8cZ5?=
 =?us-ascii?Q?sJf7RMh2JVD9dC6iPsEalDLmEVmNiIJbEV2OhTXXXNPMW7htvp0bU0h83C88?=
 =?us-ascii?Q?/TaTN1SXacz/HANOjWBNt2apgE13cn12QTq0cdZT0u6uF1aActZcxYBwCSX6?=
 =?us-ascii?Q?yNV10ZoEDIAUwRFEZlWSZ7GORuywdLkNJAJuWcHOiqqnlpPu8lLYKypYK4ht?=
 =?us-ascii?Q?HsJG3I1JMh4vrpWZ8kHBuyqtP2qmxvAwUvw0VtUq9xCBbcAbgc6erAWvxAny?=
 =?us-ascii?Q?mQER7OpTic/GssTC+OAj5iql3r5YUED6arCL6rUz+1STODKdFAprzvH0p9Y8?=
 =?us-ascii?Q?RL2FhB3NPksq0bcMtevcTdaLRrdKqabID0naF1cBQCLQIvIrlrtcccY9vG0N?=
 =?us-ascii?Q?2iy0n49mL6O8EFFzCpqLRA6p6gJxGrqE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L/ABNfvrTEGwzaC67SJWFjWgfBh81pX3x/h3r9mKqVUgCfWDix4B1D+bpVnp?=
 =?us-ascii?Q?UgA3a3kh7QbMqYZNCKW5zzusO5yX4dfXKrH+EHHU0bwvYl6UVBrRljvF3f7u?=
 =?us-ascii?Q?FuaDtxEaw/90ArPcEk8MH4Dg8xHZqn5piWSWot+zTWkanQcloMR8HY6RMuKk?=
 =?us-ascii?Q?6332zWb0c6G4r5y8DBMu5x3QkkFkLOIHocuoWtNncFR/ANosjuAtlXW418kE?=
 =?us-ascii?Q?R16LkO5QwfIlOtjI+EIIdHubYTGI8qgEIVwVKt3Kmyhz43+BardcQULpU9l4?=
 =?us-ascii?Q?Oth0C5TQ0btoqwzT5Hu5hhCp2qXNtfoFTud9WIaP2Msc+1INROVq4auC0hz/?=
 =?us-ascii?Q?qUmHK2zuGN/ZUonVVu7UUzOiKGFf97iG9ZExNiPUtVDuFgUrlFJFsLGQ3mZ1?=
 =?us-ascii?Q?zJjYd/HPz0CxwYVvvXeGw9vROQK3KZ3YnRAmSlluOfkQdzHru/Nv9+t9+YRQ?=
 =?us-ascii?Q?gOls1WBh806OhZWCBYC//lURhUGUWeB1+aZOjM6jwwGZ0oShCrxrpgU+Aqlh?=
 =?us-ascii?Q?WyVXNOJmDOlygU2IIeq6HZ+KqngnQVPhxtfgTfq8x/taS97LOvgzAYz4VoX9?=
 =?us-ascii?Q?3ijX3KY//OE2/fg9f4xJaYThoyGs/FJSuJHt35POBWuQnzNFfKJU+ANAMqNs?=
 =?us-ascii?Q?8PVSCLvEmj6Bg64inilNT050FOnfSJ5GdeYGpOo7qxTr5K0P5h6Q+IBR+L2s?=
 =?us-ascii?Q?IxQqgFH3ZDA+geIG2JeGgL3j8SgJ+FaweExyxUXWnTKo7li7FNpC9V28nTSn?=
 =?us-ascii?Q?PkNAlONWu4s1fKZvRd3ymKpsFnTkJ+/G27jzpd1piYSdqxOliUT5lGecJmV7?=
 =?us-ascii?Q?mYDD20IdPxwa0h0OUAKtB8jT9Qfsx92xKBN7/PX1UA9m46IAHa1nZTI+tnV8?=
 =?us-ascii?Q?rmEEj0mlZhYBM+CUlVVylw379ySeP8uC4EgVbACPiZOpaQFqSyEGYpoHQwqC?=
 =?us-ascii?Q?2YGdKE46yF8XUlNKKmzX049EBq1O7xSWnUt7HmK6J3CskoZY3JzCKaK0A1dD?=
 =?us-ascii?Q?RJQFF/swutzIDWNmlUAQ13etsuc8WagrVWWCfFNPQ8eBq8iuUAc76WEY4X3J?=
 =?us-ascii?Q?42MOHX2p5ehEQY5ze0SVtWyHBxoYRgTfDiwiSoFs0Aj9N9UqVuZiKmuTMnVL?=
 =?us-ascii?Q?ocy5Rq+suCoiMc7mw0Z1fGEAMGQ8E9MufOqai3WJ7PJ5ZO+yxdOzy492w7Hw?=
 =?us-ascii?Q?fjx8QWJfe1oDkgH4+EkXcUcOc5QvS2FMQRM4OOlAdDHYcprV2fw4GY1YrgGA?=
 =?us-ascii?Q?mGffQnOlr/7VudQNrbFJ7THE+Hyu+nY9H0kQOUV2oIw6OgZlRfsGy9gDw6vq?=
 =?us-ascii?Q?lKY+g9ujs+KKLeiJoQL4+fVNVtJEpdFBuuBsSeYhkUgMmhqkJGij2LGIO9XB?=
 =?us-ascii?Q?izwkz8URiF1WY5o+x/NNK26vhP7ugBWz1jd2ZYDWlNqu6WY2liEUpF46kgQV?=
 =?us-ascii?Q?XsZ2YvxytNFGJRz4pmr/BK/N8L09x6mmSWTAg6vyg9+CBB5qbOXwukB1iNEU?=
 =?us-ascii?Q?yZPbpoSrXuMXmxbHjFF0rXdlakANF5b3zgUOKk1+qcGFLTmXjWHKaZ2zIUiH?=
 =?us-ascii?Q?66rY259aYv08z5FYw5qGdOj8TpINzIo5YQwkdofafwptCWbPfGfNHkBIqE+B?=
 =?us-ascii?Q?tyzvNfcexJ3D0x6+Oeufl5M=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e53d5f-f4e2-440b-6178-08de13180b4b
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 16:11:52.3944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMKPuxTMwaBUS0c4Mb1sags/3DW8QeynEHfoTc9EjfmB1iaY/DnoU+5K29z+7TdjmG60XE5jPs56cTZjktz6Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4675

On Thu, Oct 23, 2025 at 09:55:42AM +0200, Jerome Brunet wrote:
> On Thu 23 Oct 2025 at 16:18, Koichiro Den <den@valinux.co.jp> wrote:
> 
> > Hi all,
> >
> > Motivation
> > ==========
> >
> > On Renesas R-Car S4 the PCIe Endpoint is DesignWare-based and the platform
> > does not allow mapping GITS_TRANSLATER as an inbound iATU target. As a
> > result, forwarding MSI writes from the Root Complex (RC) to the Endpoint
> > (EP) is not possible even if we would add implementation to create a MSI
> > domain for the vNTB device to use existing drivers/ntb/msi.c, and NTB
> > traffic must fall back to doorbells (polling). In addition, BAR resources
> > are scarce, which makes it difficult to dedicate a BAR solely to an
> > NTB/msi window.
> >
> > This RFC introduces a generic interrupt backend for NTB. The existing MSI
> > path is converted to a backend, and a new DW eDMA test-interrupt backend
> > provides an RC-to-EP interrupt fallback when MSI cannot be used. In
> > parallel, EPC/DWC gains inbound subrange mapping so multiple NTB memory
> > windows (MWs) can share a single BAR at arbitrary offsets (via mwN_offset).
> > The vNTB EPF and ntb_transport are taught about offsets.
> >
> > Backend selection is automatic: if MSI is available we use the MSI backend.
> > Otherwise, if enabled, the DW eDMA backend is used. If neither is
> > available, we continue to use doorbells. Existing systems remain unaffected
> > unless use_intr=1 is set.
> >
> > Example layout (R-Car S4):
> >
> >   BAR0: Config/Spad
> >   BAR2 [0x00000-0xF0000]: MW1 (data)
> >   BAR2 [0xF0000-0xF8000]: MW2 (interrupts)
> >   BAR4: Doorbell
> 
> Have you considered putting the doorbell in BAR0 along Config/SPAD
> instead ? Doorbells already have an offset in the config and it would
> allow the following setup
> 
> BAR0 : Config/Spad/Doorbell
> BAR2 : MW1
> BAR4 : MW2
> 
> If MW2 handle the IRQs, I suppose the size requirement is rather
> limited so it should fit ?
> 
> The modification to allow this setup is minimal and you would not need
> all the offset related changes below ... This is something I
> was experimenting on. I can share that if you are interested.

Thank you for the info. Somehow I overlooked NTB_EPF_DB_OFFSET / db_offset
when preparing the patch set. The modification should be minimal, so I can
cook it up if/when needed, thanks!

To be honest, since there is NTB_EPF_MW1_OFFSET / reserved, which is
actually unused, I assumed someone would complete the implementation for
MW*_offset once it really became relevant, and I thought this was/could be
a good timing.

-Koichiro

> 
> >
> >   # The corresponding configfs settings (see Patch #25):
> >   echo 0xF0000 > ./mw1
> >   echo 0x8000  > ./mw2
> >   echo 0xF0000 > ./mw2_offset
> >   echo 2       > ./mw1_bar
> >   echo 2       > ./mw2_bar
> >
> > Summary of changes
> > ==================
> >
> > * NTB core/transport
> >   - Introduce struct ntb_intr_backend and convert MSI to the new backend.
> >   - Add DW eDMA interrupt backend (CONFIG_NTB_DW_EDMA) as MSI-less fallback.
> >   - Rename module parameter to use_intr (keep use_msi as deprecated alias).
> >   - Support offsetted partial MWs in ntb_transport.
> >   - Hardening for peer-reported interrupt values and minor cleanups.
> >
> > * PCI Endpoint core and DWC EP controller
> >   - Add EPC ops map_inbound()/unmap_inbound() for BAR subrange mapping.
> >   - Implement inbound mapping for DesignWare EP (Address Match mode), with
> >     tracking of multiple inbound iATU entries per BAR and proper teardown.
> >
> > * EPF vNTB
> >   - Add mwN_offset configfs attributes and propagate offsets to inbound maps.
> 
> ... then you would not need this with and it would remove significant
> part of the necessary changes below
> 
> >   - Prefer pci_epc_map_inbound() when supported. Otherwise fall back to
> >     set_bar().
> >   - Provide .get_pci_epc() so backends can locate the common eDMA instance.
> >
> > * DW eDMA
> >   - Add self-interrupt registration and expose test-IRQ register offsets.
> >   - Provide dw_edma_find_by_child().
> >
> > * Renesas R-Car
> >   - Place MW2 in BAR2 to host the interrupt window alongside the data MW.
> >
> > * Documentation
> >
> > Patch layout
> > ============
> >
> > * Patches 01-11 : BAR subrange and MW offsets (EPC/DWC EP, vNTB, core helpers)
> > * Patches 12-14 : Interrupt handling hardening in ntb_transport/MSI
> > * Patches 15-17 : DW eDMA: self-IRQ API, offsets, lookup helper
> > * Patches 18-19 : NTB/EPF glue (.get_pci_epc())
> > * Patch 20      : Module param name change (use_msi->use_intr, alias preserved)
> > * Patches 21-23 : Generic interrupt backend + MSI conversion + DW eDMA backend
> > * Patch 24      : R-Car: add MW2 in BAR2 for interrupts
> > * Patch 25      : Documentation updates
> >
> > Tested on
> > =========
> >
> > * Renesas R-Car S4 Spider
> > * Kernel base: commit 68113d260674 ("NTB/msi: Remove unused functions") (ntb-driver-core/ntb-next)
> >
> > Performance measurement
> > =======================
> >
> > Even without the DMA acceleration patches for R-Car S4 (which I keep
> > separate from this RFC patch series), enabling RC-to-EP interrupts
> > dramatically improves NTB latency on R-Car S4:
> >
> > * Before this patch series (NB. use_msi doesn't work on R-Car S4)
> >
> >   # Server: sockperf server -i 0.0.0.0
> >   # Client: sockperf ping-pong -i $SERVER_IP
> >   ========= Printing statistics for Server No: 0
> >   [Valid Duration] RunTime=0.540 sec; SentMessages=45; ReceivedMessages=45
> >   ====> avg-latency=5995.680 (std-dev=70.258, mean-ad=57.478, median-ad=85.978,\
> >         siqr=59.698, cv=0.012, std-error=10.473, 99.0% ci=[5968.702, 6022.658])
> >   # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
> >   Summary: Latency is 5995.680 usec
> >   Total 45 observations; each percentile contains 0.45 observations
> >   ---> <MAX> observation = 6121.137
> >   ---> percentile 99.999 = 6121.137
> >   ---> percentile 99.990 = 6121.137
> >   ---> percentile 99.900 = 6121.137
> >   ---> percentile 99.000 = 6121.137
> >   ---> percentile 90.000 = 6099.178
> >   ---> percentile 75.000 = 6054.418
> >   ---> percentile 50.000 = 5993.040
> >   ---> percentile 25.000 = 5935.021
> >   ---> <MIN> observation = 5883.362
> >
> > * With this series (use_intr=1)
> >
> >   # Server: sockperf server -i 0.0.0.0
> >   # Client: sockperf ping-pong -i $SERVER_IP
> >   ========= Printing statistics for Server No: 0
> >   [Valid Duration] RunTime=0.550 sec; SentMessages=2145; ReceivedMessages=2145
> >   ====> avg-latency=127.677 (std-dev=21.719, mean-ad=11.759, median-ad=3.779,\
> >         siqr=2.699, cv=0.170, std-error=0.469, 99.0% ci=[126.469, 128.885])
> >   # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
> >   Summary: Latency is 127.677 usec
> >   Total 2145 observations; each percentile contains 21.45 observations
> >   ---> <MAX> observation =  446.691
> >   ---> percentile 99.999 =  446.691
> >   ---> percentile 99.990 =  446.691
> >   ---> percentile 99.900 =  291.234
> >   ---> percentile 99.000 =  221.515
> >   ---> percentile 90.000 =  149.277
> >   ---> percentile 75.000 =  124.497
> >   ---> percentile 50.000 =  121.137
> >   ---> percentile 25.000 =  119.037
> >   ---> <MIN> observation =  113.637
> >
> > Feedback welcome on both the approach and the splitting/routing preference.
> >
> > (The series spans NTB, PCI EP/DWC and dmaengine/dw-edma. I'm happy to split
> > later if preferred.)
> >
> > Thanks for reviewing.
> >
> >
> > Koichiro Den (25):
> >   PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[]
> >     access
> >   PCI: endpoint: pci-epf-vntb: Add mwN_offset configfs attributes
> >   NTB: epf: Handle mwN_offset for inbound MW regions
> >   PCI: endpoint: Add inbound mapping ops to EPC core
> >   PCI: dwc: ep: Implement EPC inbound mapping support
> >   PCI: endpoint: pci-epf-vntb: Use pci_epc_map_inbound() for MW mapping
> >   NTB: Add offset parameter to MW translation APIs
> >   PCI: endpoint: pci-epf-vntb: Propagate MW offset from configfs when
> >     present
> >   NTB: ntb_transport: Support offsetted partial memory windows
> >   NTB/msi: Support offsetted partial memory window for MSI
> >   NTB/msi: Do not force MW to its maximum possible size
> >   NTB: ntb_transport: Stricter checks for peer-reported interrupt values
> >   NTB/msi: Skip mw_set_trans() if already configured
> >   NTB/msi: Add a inner loop for PCI-MSI cases
> >   dmaengine: dw-edma: Add self-interrupt registration API
> >   dmaengine: dw-edma: Expose self-IRQ register offsets
> >   dmaengine: dw-edma: Add dw_edma_find_by_child() helper
> >   NTB: core: Add .get_pci_epc() to ntb_dev_ops
> >   NTB: epf: vntb: Implement .get_pci_epc() callback
> >   NTB: ntb_transport: Rename use_msi to use_intr (keep alias)
> >   NTB: Introduce generic interrupt backend abstraction and convert MSI
> >   NTB: ntb_transport: Rename MSI symbols to generic interrupt form
> >   NTB: intr_dw_edma: Add DW eDMA emulated interrupt backend
> >   NTB: epf: Add MW2 for interrupt use on Renesas R-Car
> >   Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset
> >     usage
> >
> >  Documentation/PCI/endpoint/pci-vntb-howto.rst |  16 +-
> >  drivers/dma/dw-edma/dw-edma-core.c            | 109 ++++++++
> >  drivers/dma/dw-edma/dw-edma-core.h            |  18 ++
> >  drivers/dma/dw-edma/dw-edma-v0-core.c         |  15 ++
> >  drivers/ntb/Kconfig                           |  15 ++
> >  drivers/ntb/Makefile                          |   6 +-
> >  drivers/ntb/hw/amd/ntb_hw_amd.c               |   6 +-
> >  drivers/ntb/hw/epf/ntb_hw_epf.c               |  46 ++--
> >  drivers/ntb/hw/idt/ntb_hw_idt.c               |   3 +-
> >  drivers/ntb/hw/intel/ntb_hw_gen1.c            |   6 +-
> >  drivers/ntb/hw/intel/ntb_hw_gen1.h            |   2 +-
> >  drivers/ntb/hw/intel/ntb_hw_gen3.c            |   3 +-
> >  drivers/ntb/hw/intel/ntb_hw_gen4.c            |   6 +-
> >  drivers/ntb/hw/mscc/ntb_hw_switchtec.c        |   6 +-
> >  drivers/ntb/intr_common.c                     |  61 +++++
> >  drivers/ntb/intr_dw_edma.c                    | 253 ++++++++++++++++++
> >  drivers/ntb/msi.c                             | 186 +++++++------
> >  drivers/ntb/ntb_transport.c                   | 155 ++++++-----
> >  drivers/ntb/test/ntb_msi_test.c               |  26 +-
> >  drivers/ntb/test/ntb_perf.c                   |   4 +-
> >  drivers/ntb/test/ntb_tool.c                   |   6 +-
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 242 +++++++++++++++--
> >  drivers/pci/controller/dwc/pcie-designware.c  |   1 +
> >  drivers/pci/controller/dwc/pcie-designware.h  |   2 +
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 197 ++++++++++++--
> >  drivers/pci/endpoint/pci-epc-core.c           |  44 +++
> >  include/linux/dma/edma.h                      |  31 +++
> >  include/linux/ntb.h                           | 134 +++++++---
> >  include/linux/pci-epc.h                       |  11 +
> >  29 files changed, 1310 insertions(+), 300 deletions(-)
> >  create mode 100644 drivers/ntb/intr_common.c
> >  create mode 100644 drivers/ntb/intr_dw_edma.c
> 
> -- 
> Jerome

