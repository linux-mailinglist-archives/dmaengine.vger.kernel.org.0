Return-Path: <dmaengine+bounces-8847-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F+2EizZiWlUCQAAu9opvQ
	(envelope-from <dmaengine+bounces-8847-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 13:55:08 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8DE10F3BC
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 13:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBD48303A6D5
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 12:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3301437883B;
	Mon,  9 Feb 2026 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="SD28gjgA"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020117.outbound.protection.outlook.com [52.101.228.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4399378833;
	Mon,  9 Feb 2026 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770641606; cv=fail; b=dK02JWu6RzIebbXun08JgpZHJPeVCAl7byYcP7WRpmcH+IodcvqV3v62fFdUMJLUNousxzzqG0P8vsIcxmwLYzidxSvEVI00ZTP3RrDhgDAOn3FAlmisBj8fev9gAXOTeOb9SF87JdvQT6NwPBVED0yAeLQgMDKg6maAv+IoSzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770641606; c=relaxed/simple;
	bh=Q0LxD97Soj7hEJ+St3dA85CRI/wAKQPn63lpzpyTUtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WiO01YNz4KZAX6e2hnttZb1x5mQFbmriv0J2WhwmydP1Ouniswvv1tD3gOAx3gernjeXVoJqaQvOj3UjuRA742Nnwk2zIxWofnGmbQ58uS8t45gBZH0QvvRnlC/HC3bnsBFiaY59vt22EZ0GmTGt/IrMGjjylO/WCplX+uB2hCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SD28gjgA; arc=fail smtp.client-ip=52.101.228.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTh8Yq7UT5oBkZK8JL5rYDoEdAKHBlh3sPF3lrETooTJRfqu29KxadZVY+rdW/chYYJwaGTI64wRc3tHedz8buk6NwnzsCUk7C9kcCXZz5zm+0EgiB7PK32Qp3iyo6BU2IhdPxm4fXCzNWS/XJMdyrcZW4doJGpwFL6hpc5ELs/SyP1TQLDLOV4la/PGhxaOQWYWX/ExtuRj3EOo6viP1fKshDGBmGcin0qm8IC3vpe7GQTmY5/lBnP//sueUnsIxBYeO4X/spZn1rRnviUsRmt6JGeGgUtlPqOtla3rX2Eko5OCnFjpTifWbQGAMywO++FsXtChqaEVHT+JrUNKaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNuuLIYbMWpPnjLs0IFMtvTnw+yFC3V3O/P17UR8MkQ=;
 b=n68REHE/WW+/SUmJEeCMP9eV0IAAj/2kvVWIb+H5z5MuNhWeljbvOfyOuVDdwkt0towK6VUr6zcjBQMOubOlCvFcE4gVGY+q3NDyiTse4+hHAydv9DrAw6dOFJYx+nrm3yvuly6O0/3CpzEOL6gf9eN8rQB2IsYPNnvR3T8yUbagOu947HneDuMcb1DS5JvDJLBiqsJJcMhHs4b7f9V1F1xGgmvbUYfdB9VSvdKdb8jR0hiGhVr8NBkn/cNziKTVTcAfKLX2NIRysXqG7jfj7odxhCjnLWsxbdgzCmMJZeFjJ5PR2GQGk7Sjq/QTeuibRnw8nLo9rQyYS053D40YjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNuuLIYbMWpPnjLs0IFMtvTnw+yFC3V3O/P17UR8MkQ=;
 b=SD28gjgAvde564yyuBC/oDLfl72SfHHycZ2rG0ygx0MMt8SbjTZHO2/oTx+IyQH3nv9YvM549oE6nAclV8Q7GL6yMQGCrLZdMKyNordSJ4n/rQAhC+DQNQJsIFrKLJm4Tlp6YRyFBNd3EnLqWpsXg+QA3uoduZEWIZuTI11Cbks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB3742.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:237::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 12:53:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 12:53:25 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com,
	cassel@kernel.org,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	allenbh@gmail.com
Cc: dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 8/8] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
Date: Mon,  9 Feb 2026 21:53:16 +0900
Message-ID: <20260209125316.2132589-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209125316.2132589-1-den@valinux.co.jp>
References: <20260209125316.2132589-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0076.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB3742:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ca2714-bdc5-4578-58b2-08de67da36bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KYQmxxNp2PKJdga88EJkTPAtWMktb/bDv9d/IYNwWrPYgecCDpovmjdyFDGB?=
 =?us-ascii?Q?2vLPh52qBpVHZ8xJF++Dk/0RvhExMXx7yRhr4nY13YbJ2kwNIXt1haL3kH3g?=
 =?us-ascii?Q?8/R0Xf1SIJAJOHun+q5ssu6QJSUB8GDyBY/U5d7gsWhvhZ2SVfEaUrnvlKh+?=
 =?us-ascii?Q?HQ4v6uS25tGct5yqoUZ/kUfTDaMfzVOrC31LDfVcthyVyGiz46CPq2oVNVSV?=
 =?us-ascii?Q?hiB7MdFSkcCzUQQSthlyqGBLfgofP91po5TTXyCYfU1uEySaJUQSnrlgreoO?=
 =?us-ascii?Q?dQvioYgpzjp9XSbBiB3BLWpuIe+S0IOEskp2S35HmkyZEqGADKkwuzTISenp?=
 =?us-ascii?Q?rtJBqyGrZM/xpOtAPrxlYopBkDZyqVrVjta2FFmKqQUry3Fzfb1n0nN2oswI?=
 =?us-ascii?Q?4hTOqaE6iVra+fuKpl8PIb7MDT6m5S2iySaq2rCDUFuLVnWz+ZzdTf0FLfxw?=
 =?us-ascii?Q?GhgUrvHH1mKPwmtTm/S3O5sMDW9RAYfWjdvKugabrUj3zN7PQm3NNWjqg31T?=
 =?us-ascii?Q?4pMdZyTNG0H+3CnGGYxyMsvQOE3PsDV1gWdjwlmRzPuDGVdCbrxLDf/e4vvS?=
 =?us-ascii?Q?37n1ah5o4jtdGwi2JK3lv/zoyA2jzIUI7UfWyVZbys5IQKfYzikLYK5S504o?=
 =?us-ascii?Q?G6+CQeBwJFvbLOlXHprBbzKTVdtAip/DWJW7f5AcgEjxCqCDHfCeCzxuAFXk?=
 =?us-ascii?Q?3qlPRQUnpPeDI2qk2+EWbtQ8Ck+f3nkgflRPXS1zeRbJMp3APTzSjMYuoGUF?=
 =?us-ascii?Q?+xCGCpRBuqzFBD4OcFDN1rROLBDDg7WUPYnmUvtrVk63b46rgpGzF9293xvd?=
 =?us-ascii?Q?PiqwqEnV4K6/uoNBywatwZ4aJXV/0ThZgV2pLSYVhTxXW/gsoUOFseIeVMOm?=
 =?us-ascii?Q?/pAMluAFX8sGbj4Y4ZEWOR9LT5NjttC7dM1mDIlcA7tynAWFTLKcDQlzfx4p?=
 =?us-ascii?Q?ClPIIP35QMWBONQhA+dxpG5Ic3ktND5bi9kLqkBjU4E640+ZyWL0cmi3xjLM?=
 =?us-ascii?Q?mlZcJmI0U0ZNSN685wpXAFLEXEnU7/TUXuH00N9qaYOSYi2S1xKawvzAnnAs?=
 =?us-ascii?Q?K1aa2wJ6/ZDUaLtHYHrRGivnSIWcHhC7yur9Z4ICYJeJzIaPp5J2BZu8ZqGC?=
 =?us-ascii?Q?zf3HLcQZn9H5N3FfzGPeiflHeCcc1NEE8/pBYkPGVRBXGnIk4QLqHJIsAQmN?=
 =?us-ascii?Q?kYU2zaq/PVWsSqX07s4gIos8xnminKuD01rvOFu60bmbWNdrjh0pV7p1bcPj?=
 =?us-ascii?Q?Drdf/ckD42hvARQopTIfs9Wd8v7zqtkte5EskvjY3EoV7vtHPdsF0yuD0z7t?=
 =?us-ascii?Q?X7Q2mbxZW4ryU/h0SlmqHKt2/hMR0dOPsdfiBI3hGjhoAswoXr8f5r3Bj2en?=
 =?us-ascii?Q?S3alVSsHKeFnEv0zu/GxYF9Y6ZJq8pa2CMjzhWLL7LuE40QcVfBnDhGB1ig0?=
 =?us-ascii?Q?V9CtZxUSu3H+BnBneGcOQdL35lsnYJYSUBo6f+HRE6vQ4Hs9nmcbObFmPyUx?=
 =?us-ascii?Q?wyKSka8wBVnSsehXpVU6XTQxChYRzPtn6tb7RKIY31k6xsscsC0/RUsrgMyx?=
 =?us-ascii?Q?ozHaGBipiz0hr3OGCDhgSX9a1PQlNF/GcgObRGgdkSOp3P25AEEPiqaVvOKs?=
 =?us-ascii?Q?UA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FM3phAqmiM2R9yFxBQehzlm78bzh3AMmgr+DDaF/BVmIWyWrznIklt8P39ak?=
 =?us-ascii?Q?QYDKaBQikKFQTiFUz7/WCQR5kBxETgZ5klQ2YJhv47qiA1+0q/zumT/cVmSV?=
 =?us-ascii?Q?B6+LFEuC3z5a3zDXrUy1MFYlu0soZknwDvg8BC2PfV63N9Us2sViNEYenpoi?=
 =?us-ascii?Q?bY0ZqqEl3DQweAw66kSQVW4k7nsATXuQpEJIWLSrAW6sptGAwSfVTOSSHsk0?=
 =?us-ascii?Q?qG1WZE4LqCYjKyRsYE1NTiJjgNRxCcF6Y6HtQILkAhmyNeeJudy28ly41PiG?=
 =?us-ascii?Q?4Rvm1zzIY52m8ZiW8AblpBvLkPFCrI66FC5qVnpsKu+INOEUEayHPqAPsQnL?=
 =?us-ascii?Q?rdghEqExvaWJ64lr6O0iqAhHm6dDaUbEQI7ZIe/trVDTpWAA2y6qaHQ0VT/U?=
 =?us-ascii?Q?jBCZ6kTKb77iz0FgyDKq6ld5u6CCrvSqM8d8y8tcpSLXplAIKv8kb7hL4rI+?=
 =?us-ascii?Q?IqiP3Vr/gFi5Q9vOBDgBXHEeWW5nplvN/Ku6KweQBU6ynyVGGVjVfHCQdaFJ?=
 =?us-ascii?Q?lFQUYJkiIt7veZELrSCK6RB9IQt82+j5kMQ28OW+hlgaDorRl00Tx5T585kk?=
 =?us-ascii?Q?v9CORG7Qs19dI+JUsdHg3ffzgT8K2+w75jfHwzu2/9Qe+8A5casb64d/b1GA?=
 =?us-ascii?Q?+SCm2NjtSONDQxsglVLV8c8i1yHpYllxnTIr1+Q9EWaRhrDlR9a4YV7gPwqK?=
 =?us-ascii?Q?35zjNtCEcqXTLhijJPZgQUnjshoS/XoKYj8fp6bLhuaREvjRHYbucdvTkabz?=
 =?us-ascii?Q?LPFBdu2lG+Pue3YimwQ23mSigxMnSVkVBzHv0NvN/0fYbC0p5mQUK571zQTx?=
 =?us-ascii?Q?22pBR6HtcR+SxdKrnJvB3a4gLqBXJN0+jNnYSjPykZ/ItTfFzb+LZc07B7A7?=
 =?us-ascii?Q?K9CeIRiRMbFFDUzm17K0f8G+BJMLhNLYFqIw5yfQRSEAZpH05wUUNssgdrHm?=
 =?us-ascii?Q?DSCSEpbLcUVsh2nm8pqZAisCb63TuM8KewOCTLZ+Pl3A4Lr+FKni5DilKQ7x?=
 =?us-ascii?Q?SCsGRsMzy00TH52mS7ZDLaadDlrw8V/spHG5AikIKD2N7bF8iIwo5pKLjbKp?=
 =?us-ascii?Q?AaSSqesCWxHIMDcgRuRWeq/hudnpcBCUZX8nHc776E6En2zBoUkHef5rnoGr?=
 =?us-ascii?Q?ZbXbz0I1t23PA/WZBc9Uy0xRfx1rm/s5uxwv3Yh04+K0xmNHoWDhkkEMKZv0?=
 =?us-ascii?Q?G1cpZuj3+t8BBo+GKGzaBz6ebMmv53nBxWv1mBb6oDWDfEBTOX5jRfGOZMl6?=
 =?us-ascii?Q?1wWnKftyRi6kw8J2G+5sMvZ8/aRLy+d37m49Z3f+B4dvHsbL+uJx85VNOmfy?=
 =?us-ascii?Q?Oi/bfB19abe+gV+ER/v+K6NhlG5lIk++Z4HHsUvcsIzqXRkUxHUeeAsiopQz?=
 =?us-ascii?Q?PCmYeddJH22Gb7fTbMn4EgCbeYlyA4O5b+5zNp9rcF+U+fV23w05I0b+S4Gp?=
 =?us-ascii?Q?vbWPOxTwCidvOstxyy8Dw176UaVJnU06UDkBSsu1J6K4CyNeQVzzJeIL2muG?=
 =?us-ascii?Q?NWdHdT/OZAPulyDWmNnEv+RDPPUSNKYPZUX0LEdPOdY8vwnmuLqIJQ0FJQQG?=
 =?us-ascii?Q?Az9nnrQrifAvVBQ0j81bzletfofxZ4pF5VajsxG6ppHOORJT8hbAnfpcbWMm?=
 =?us-ascii?Q?3Enki0HbDh8WGHCM2daS7ZYSbcBbLAUsqm+RzSHN+EdsaVitmTXwZ0Ijuge3?=
 =?us-ascii?Q?E8kMx6ujhzlT9pRVD5e8Yf+cVM7ROhm9+uWoEZi5R05RN1HRpQReWYhTGyvS?=
 =?us-ascii?Q?o2VL1IkKOyyA9U9waUXy90Kdsr5NvMq0h0sTz3/vAjrkhUXtsoBD?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ca2714-bdc5-4578-58b2-08de67da36bf
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 12:53:25.2772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJftb03hH7Qv+HI3Sn0krKMSPpPvhRutDmTYsBsQLVqG3h8jru3SELsmxHA94Y+lIDUsZQpFB0w3vbyMQIpJFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB3742
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8847-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:mid,valinux.co.jp:dkim,valinux.co.jp:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF8DE10F3BC
X-Rspamd-Action: no action

pci_epf_alloc_doorbell() currently allocates MSI-backed doorbells using
the MSI domain returned by of_msi_map_get_device_domain(...,
DOMAIN_BUS_PLATFORM_MSI). On platforms where such an MSI irq domain is
not available, EPF drivers cannot provide doorbells to the RC. Even if
it's available and MSI device domain successfully created, the write
into the message address via BAR inbound mapping might not work for
platform-specific reasons (e.g. write into GITS_TRANSLATOR via iATU IB
mapping does not reach ITS at least on R-Car Gen4 Spider).

Add an "embedded (DMA) doorbell" fallback path that uses EPC-provided
auxiliary resources to build doorbell address/data pairs backed by a
platform device MMIO region (e.g. dw-edma) and a shared platform IRQ.

To let EPF drivers request interrupts correctly, extend struct
pci_epf_doorbell_msg with the doorbell type and required IRQ request
flags. Update pci-epf-test to handle shared IRQ constraints by using a
trivial primary handler to wake the threaded handler, and update
pci-epf-vntb to use the required irq_flags.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c |  29 +++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c |   3 +-
 drivers/pci/endpoint/pci-ep-msi.c             | 129 ++++++++++++++++--
 include/linux/pci-epf.h                       |  17 ++-
 4 files changed, 160 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 23034f548c90..2f3b2e6a3e29 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -711,6 +711,26 @@ static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/*
+ * Embedded doorbell fallback uses a platform IRQ which is already owned by a
+ * platform driver (e.g. dw-edma) and therefore must be requested IRQF_SHARED.
+ * We cannot add IRQF_ONESHOT here because shared IRQ handlers must agree on
+ * IRQF_ONESHOT.
+ *
+ * request_threaded_irq() with handler == NULL would be rejected for !ONESHOT
+ * because the default primary handler only wakes the thread and does not
+ * mask/ack the interrupt, which can livelock on level-triggered IRQs.
+ *
+ * In the embedded doorbell fallback, the IRQ owner is responsible for
+ * acknowledging/deasserting the interrupt source in hardirq context before the
+ * IRQ line is unmasked. Therefore this driver only needs a trivial primary
+ * handler to wake the threaded handler.
+ */
+static irqreturn_t pci_epf_test_doorbell_primary(int irq, void *data)
+{
+	return IRQ_WAKE_THREAD;
+}
+
 static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
 {
 	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
@@ -731,6 +751,7 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	u32 status = le32_to_cpu(reg->status);
 	struct pci_epf *epf = epf_test->epf;
 	struct pci_epc *epc = epf->epc;
+	unsigned long irq_flags;
 	struct msi_msg *msg;
 	enum pci_barno bar;
 	size_t offset;
@@ -745,10 +766,14 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	if (bar < BAR_0)
 		goto err_doorbell_cleanup;
 
+	irq_flags = epf->db_msg[0].irq_flags;
+	if (!(irq_flags & IRQF_SHARED))
+		irq_flags |= IRQF_ONESHOT;
 	epf_test->db_irq_requested = false;
 
-	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
-				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
+	ret = request_threaded_irq(epf->db_msg[0].virq,
+				   pci_epf_test_doorbell_primary,
+				   pci_epf_test_doorbell_handler, irq_flags,
 				   "pci-ep-test-doorbell", epf_test);
 	if (ret) {
 		dev_err(&epf->dev,
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 3ecc5059f92b..d2fd1e194088 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -535,7 +535,8 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 
 	for (i = 0; i < ntb->db_count; i++) {
 		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
-				  0, "pci_epf_vntb_db", ntb);
+				  epf->db_msg[i].irq_flags, "pci_epf_vntb_db",
+				  ntb);
 
 		if (ret) {
 			dev_err(&epf->dev,
diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index ad8a81d6ad77..0e93d4789abd 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -8,6 +8,7 @@
 
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/msi.h>
@@ -35,23 +36,84 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	pci_epc_put(epc);
 }
 
-int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
 {
 	struct pci_epc *epc = epf->epc;
-	struct device *dev = &epf->dev;
-	struct irq_domain *domain;
-	void *msg;
-	int ret;
-	int i;
+	const struct pci_epc_aux_resource *dma_ctrl = NULL;
+	struct pci_epf_doorbell_msg *msg;
+	int count, ret, i, db;
 
-	/* TODO: Multi-EPF support */
-	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
-		dev_err(dev, "MSI doorbell doesn't support multiple EPF\n");
-		return -EINVAL;
+	count = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
+					  NULL, 0);
+	if (count == -EOPNOTSUPP || count == 0)
+		return -ENODEV;
+	if (count < 0)
+		return count;
+
+	struct pci_epc_aux_resource *res __free(kfree) =
+				kcalloc(count, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	ret = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
+					res, count);
+	if (ret == -EOPNOTSUPP || ret == 0)
+		return -ENODEV;
+	if (ret < 0)
+		return ret;
+
+	count = ret;
+
+	for (i = 0; i < count; i++) {
+		if (res[i].type == PCI_EPC_AUX_DMA_CTRL_MMIO) {
+			dma_ctrl = &res[i];
+			break;
+		}
+	}
+	if (!dma_ctrl)
+		return -ENODEV;
+
+	msg = kcalloc(num_db, sizeof(*msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	for (i = 0, db = 0; i < count && db < num_db; i++) {
+		u64 addr;
+
+		if (res[i].type != PCI_EPC_AUX_DMA_CHAN_DESC)
+			continue;
+
+		if (res[i].u.dma_chan_desc.db_offset >= dma_ctrl->size)
+			continue;
+
+		addr = (u64)dma_ctrl->phys_addr + res[i].u.dma_chan_desc.db_offset;
+
+		msg[db].msg.address_lo = (u32)addr;
+		msg[db].msg.address_hi = (u32)(addr >> 32);
+		msg[db].msg.data = 0;
+		msg[db].virq = res[i].u.dma_chan_desc.irq;
+		msg[db].irq_flags = IRQF_SHARED;
+		msg[db].type = PCI_EPF_DOORBELL_EMBEDDED;
+		db++;
 	}
 
-	if (epf->db_msg)
-		return -EBUSY;
+	if (db != num_db) {
+		kfree(msg);
+		return -ENOSPC;
+	}
+
+	epf->num_db = num_db;
+	epf->db_msg = msg;
+	return 0;
+}
+
+static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
+{
+	struct pci_epf_doorbell_msg *msg;
+	struct device *dev = &epf->dev;
+	struct pci_epc *epc = epf->epc;
+	struct irq_domain *domain;
+	int ret, i;
 
 	domain = of_msi_map_get_device_domain(epc->dev.parent, 0,
 					      DOMAIN_BUS_PLATFORM_MSI);
@@ -74,6 +136,11 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 	if (!msg)
 		return -ENOMEM;
 
+	for (i = 0; i < num_db; i++) {
+		msg[i].irq_flags = 0;
+		msg[i].type = PCI_EPF_DOORBELL_MSI;
+	}
+
 	epf->num_db = num_db;
 	epf->db_msg = msg;
 
@@ -90,13 +157,49 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 	for (i = 0; i < num_db; i++)
 		epf->db_msg[i].virq = msi_get_virq(epc->dev.parent, i);
 
+	return 0;
+}
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+{
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	int ret;
+
+	/* TODO: Multi-EPF support */
+	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
+		dev_err(dev, "Doorbell doesn't support multiple EPF\n");
+		return -EINVAL;
+	}
+
+	if (epf->db_msg)
+		return -EBUSY;
+
+	ret = pci_epf_alloc_doorbell_msi(epf, num_db);
+	if (!ret)
+		return 0;
+
+	if (ret != -ENODEV)
+		return ret;
+
+	ret = pci_epf_alloc_doorbell_embedded(epf, num_db);
+	if (!ret) {
+		dev_info(dev, "Using embedded (DMA) doorbell fallback\n");
+		return 0;
+	}
+
+	dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
 
 void pci_epf_free_doorbell(struct pci_epf *epf)
 {
-	platform_device_msi_free_irqs_all(epf->epc->dev.parent);
+	if (!epf->db_msg)
+		return;
+
+	if (epf->db_msg[0].type == PCI_EPF_DOORBELL_MSI)
+		platform_device_msi_free_irqs_all(epf->epc->dev.parent);
 
 	kfree(epf->db_msg);
 	epf->db_msg = NULL;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 7737a7c03260..e6625198f401 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -152,14 +152,27 @@ struct pci_epf_bar {
 	struct pci_epf_bar_submap	*submap;
 };
 
+enum pci_epf_doorbell_type {
+	PCI_EPF_DOORBELL_MSI = 0,
+	PCI_EPF_DOORBELL_EMBEDDED,
+};
+
 /**
  * struct pci_epf_doorbell_msg - represents doorbell message
- * @msg: MSI message
- * @virq: IRQ number of this doorbell MSI message
+ * @msg: Doorbell address/data pair to be mapped into BAR space.
+ *       For MSI-backed doorbells this is the MSI message, while for
+ *       "embedded" doorbells this represents an MMIO write that asserts
+ *       an interrupt on the EP side.
+ * @virq: IRQ number of this doorbell message
+ * @irq_flags: Required flags for request_irq()/request_threaded_irq().
+ *             Callers may OR-in additional flags (e.g. IRQF_ONESHOT).
+ * @type: Doorbell type.
  */
 struct pci_epf_doorbell_msg {
 	struct msi_msg msg;
 	int virq;
+	unsigned long irq_flags;
+	enum pci_epf_doorbell_type type;
 };
 
 /**
-- 
2.51.0


