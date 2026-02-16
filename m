Return-Path: <dmaengine+bounces-8911-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDZ2O3NIk2mi3AEAu9opvQ
	(envelope-from <dmaengine+bounces-8911-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 17:40:19 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AB0146475
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 17:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9690E30053E8
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 16:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5345F26158C;
	Mon, 16 Feb 2026 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IJPyaARv"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010010.outbound.protection.outlook.com [52.101.69.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF073328E0;
	Mon, 16 Feb 2026 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771259899; cv=fail; b=B2AGiX/BdoYkqJsKqrCZyRUfTQPu4kakshJm+8n4YlHkxEp347QcCI5hvgakZK/M07FVW2xOvT8dGSkxPORLMQOltwzhtuB3etA/Ccb++3scJMwj6Ebp7u79LCEBuEobOAjja7ChJatd6iYr31uVEvNjdWcnNA9d3Syb0ljz8Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771259899; c=relaxed/simple;
	bh=eZrRXXWzkcnmHh4gJ3jzTJQRVpT77/U4Tbmavt01c+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cAEGJvenThmGEv4c0G0IDabvki8rnyWA3ZY+58QgpFGlik+S23zzZ/l5LYuqr0fXoCZVdRbsGEjUPFhUEEbDxIjRTzuQoyAFzmRj6tfEK0k3brLqOxFODnNKDrwuz1FVBuBac/oLn6DGv/awc6PfrYXxEvj/UolvjgaB6a+aRn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IJPyaARv; arc=fail smtp.client-ip=52.101.69.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJreptVzI2/TBJbikX7X+pWvxVS70GbK7mMSR6ZSK3uRedZZlV+fmgGl9QluMgxBPCepmGahypDQElDCWTT7Xx5vcX1Pps/0wxZfKbull21+4FxuMy3N1gfoUAdTS3QhMZ3bZaWCRuEOC8EMsMiZ26l23O6YyIvaWc9B+/YMtIB8V1HvEqw/hIvwq6b9wAVAKXd9+BcwELQ+VInbxHdzpGqxehP5gbJWMpBumbuDU4UcU8JC+74WmiLi+ORPoNBhLtxeZJYPddIMWaNcqg6tkU157armDn/uicACeUvuQdpStXgw5z7wTodMUP/k2OMAj8cKG2IgBhLKaWKyJO743A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFJpXJg7wpesXjmeR43gm+Y+w52qDq6bZ+qlLISmc+U=;
 b=RMnxb9u53oKymrqAWnnGhQsii69kgTk0CNo3rAzPrlduaumrHS/PtKSEhmVIMZFQIDjvPnXLV+6s2gW9N5vk7i2jtbPPBxQDtvtGlwwnEg9wX2AUkSbJkm/DdG2+k7OuQCjoUOX7D3bvpQID50PnGCq+ge46z01yLffmjjM6R0q954h74HtguB3AFSoGKD+ggX+cmXo7ZkbScvOXbu/cYbWA1kP3baZqf/LL0LQwgkOnL9pcjCTffH3r9iDuYFFEYS18GhLbQbgCXuZDu4K4/ZKfPd4Ey9CK7mJxYOOwTnCOFeKT5SU7u1X/SvoYNab84NL4R0Ogw0cZ9Qtj4MNm3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFJpXJg7wpesXjmeR43gm+Y+w52qDq6bZ+qlLISmc+U=;
 b=IJPyaARvfoEBt8xUK80esnwPW8MS3YylUc8zvlXVESMIgacOMBck73qBu1HP/6wIUGoSoalsrDUwkS+h4bfgSUDbfTSKefizkJ/DIm3WKH62R8j9FAUaU1jqiMg2dRcDpzTdIIyD15hg4aAHEQzGFgW+tGS+lQamrcKf2EuCkdD21vt/9/DUVTCWlNi50q/XQ3s6Ko8aStfnFxXmQiU5T4/5xAgbXlaAGLU566vpaJ6oeiAEQt76FW7Q4XxOkD/4/RkRbhTnEVDmDsheU2NOSlaQgxg/3R/k64EsPQtZ64MSFngnltYceTNRMJbWL1nP0yoUpyjXbNGVhWq4rl9G0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB7011.eurprd04.prod.outlook.com (2603:10a6:208:193::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 16:38:13 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 16:38:13 +0000
Date: Mon, 16 Feb 2026 11:38:06 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>, Thomas Gleixner <tglx@kernel.org>
Cc: mani@kernel.org, vkoul@kernel.org, Frank.Li@kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dmaengine: dw-edma: Add virtual IRQ for
 interrupt-emulation doorbells
Message-ID: <aZNH7oup-ne77twC@lizhi-Precision-Tower-5810>
References: <20260215152216.3393561-1-den@valinux.co.jp>
 <20260215152216.3393561-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215152216.3393561-3-den@valinux.co.jp>
X-ClientProxiedBy: PH8P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 62c88581-7a61-49f7-c493-08de6d79c6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R+NMmObX7SRVgfbhWfcYF+kjPG77LpMFrIkpkgbMX3Pm1BUUcCsR3QvX7g9V?=
 =?us-ascii?Q?xVyqvmFvQgBtMPA+KOhCXzAvKvPHKKG6p5NdJV3IA7f984zR7yNdj3VmtKvw?=
 =?us-ascii?Q?k5PaYZz1UK6vYYUIRpZfcfXPP0NZmdY3GkqG2L+RUNFtKZF69Jbxpe3Rcf+/?=
 =?us-ascii?Q?f3Oxm28PjlMRPtbmgp+XsNj4xROybT8uJGIDoqSxC60TrHyc11BAiavEihYg?=
 =?us-ascii?Q?m5hqjSEKbHvvjP6yjcEz/foK/s67zW6yQpimOTCcqNSa7C9np3f3FuAa7/qR?=
 =?us-ascii?Q?PIPCjhoUgNUq1kI4KM85dbzWWupn5wYwVZjZ/dTUa3tJXv6OHcEuHLfSapjG?=
 =?us-ascii?Q?vw2vK+eacTyEhArLq8MOXPj6ecYtRJnFz63/Fgp8KsFH04VwmdO8HtVc3KUp?=
 =?us-ascii?Q?XWAkJznhLJqjoNRtNQL+asKl8ww73vEQGO/5FHbRMOsLvARqXSp+kjUn18z+?=
 =?us-ascii?Q?eSox1kdhPkcKF/3MGRSzvCycvCAa5nd4OxRp8N+++yOqzUuA/OjlQ35W3kMc?=
 =?us-ascii?Q?Y6Yl6fXSSp/fTpI648TFXv0YlLDkheHXg+g2FwpKdaCrN8eBQmLxX210MYmY?=
 =?us-ascii?Q?VCJuk1lyQu8WYNAGLGuMEKAbwlZ+k8XBQq9rsvovq0k9kCB8jcNp5wC6aep1?=
 =?us-ascii?Q?DriaaNh12ZFboVp5xtp5BGjCEHMJm7J0tb4JuANXEvzwrckCevOiO0KShSlJ?=
 =?us-ascii?Q?pXRjIO57V9ziewpOzSSEJ3eu5eMaOQaTQJ26UNXgW3zlrduo67N+EEPcCqgh?=
 =?us-ascii?Q?xBEW7XeoOkFzSsrGPm4+jdimMP6jWbUglFPo81SWIvhn1/HWSZ6JBmPfRw1J?=
 =?us-ascii?Q?xIZ9q5pLlPfTMNbn7MAd0FoNCrRGDpO+jwIMjwpuEKdJmy2X6sBO/8ezQvK2?=
 =?us-ascii?Q?baGM7f8gMHkE0vGvY/AyEB0x9cSmLYygcE1r0VGB4Xt6jIUNM3lWTWvfiPYp?=
 =?us-ascii?Q?4ejVWiydDNKcj6BdZ3MXVBc3joeZb+fewSFgen5DV71Le1XKuC9vrq8ghc7v?=
 =?us-ascii?Q?3wf/HVz2HNMQYlBBh/EEMPcKuaZND41CyoeR/s1nvwfHx4EOrlY0RHDfoQ3n?=
 =?us-ascii?Q?yt182sGsDPUwn1XxyUO3PbMUYyXbeERIcWjsI69PGJLWftlYQoMHJx/P8xbL?=
 =?us-ascii?Q?PHHkcYj2INSJlF5A88iJIquxYHQl20denMPtI2GmHKh7wiu/V94kGHJcljbH?=
 =?us-ascii?Q?Jv9ZRjwLct8HFMcc1NAZhMbL6VdVoje0bimtMoRVu/qBEP74xxDEQkzGViy2?=
 =?us-ascii?Q?GN3BGbHB25dE45JGmIGoAXkytURzFR2ETKTH642RN/ivO9hFl84NRKUal2vQ?=
 =?us-ascii?Q?vaCskE/3piR2uEFWaDBDGlDB4LSxUf5XLuHf5YXPSGXtqkuM2s6Ww++u+fOP?=
 =?us-ascii?Q?0Omu3Fy4q+7I0Uztmb4mIhWGOW5raeqXqrE6fAQskhmYMG9PKm6/nOeTHQZ2?=
 =?us-ascii?Q?hYNTycEIgROwoe3tK2oN+Xlmh3Gf+la5ctpm8Wd3jY2DrvB0NEijoBp0P7gd?=
 =?us-ascii?Q?TbfaaU52MdksIGAjXCCznCiPDlhBumckN3mhH+TDXFDDNX45gGgwvudDo8f+?=
 =?us-ascii?Q?0CbapaA6mOHWyAz2O+Ai1hh+9JkHFNDzIGc8bwwGY372dlu4ng8GMNLWfDWU?=
 =?us-ascii?Q?kpQPcD8n2SxGggAJz4HEqjk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/3yzdUW+CCFSXgm5NJ7q9FNIWePHwnrNypb/0atokeSxpgJtsPIZdLKv1t1k?=
 =?us-ascii?Q?p09P9tdmwUgpraAyw5xJjXDiQ+ot5V4Up0qcCkxPk5Y4K+Cvapi4YL36Cpkd?=
 =?us-ascii?Q?W9eZlmO6O4Y+kfIIZuWix1LPCdqTjkP/omMQg571iFYAp3I9Z4q4OgGzanm6?=
 =?us-ascii?Q?hRs9FW/0hTons29hzAYL7XI7ZZ4BFllKsBIF0ovh93YDeNVj6n6Divsi1l/a?=
 =?us-ascii?Q?UXx0STkQ8YUcUWrjSFZYM2Cj6xuR3DM4NhESc8/vvKcvZYh5HEwnYWseqBCq?=
 =?us-ascii?Q?3zCXqD5nZQDzFcSjs6QCbHPgna9Y07I3jxnPFpyBYzuln80Ql1gGT3bqTG1k?=
 =?us-ascii?Q?hampmRcZ2c/XtR5fOkI2rBKlaZsOnJbUUIPEg2FoskmsbDmq1YvGP4gX447c?=
 =?us-ascii?Q?x33cqhLeqmOGwrSol9u1p1B7cfRr8H2f1WgVbegPQMHGFMDuRgAPC4cmBk3I?=
 =?us-ascii?Q?RWmjVSrOhfnL1CHOAyGGkDqyeOQKSpuFii2mUISQGt9J+xSEGtofe98ER58y?=
 =?us-ascii?Q?En+LPnfB4CEx65XHcA1yXnS9uR/il/SR6eATfNUvJLkwUZS83nSwwm7Zx2IB?=
 =?us-ascii?Q?1mK36MlntEJPHF3P2jMdCqe6ICwSbCrmxwM1mtSIPbkS3gPRHpGn0lnC0sB8?=
 =?us-ascii?Q?ErjYyQec1unlqnTnbQFzAvIR3xvgOWBvA78hLkjfpeXSnn/phjZVR2HUSG0k?=
 =?us-ascii?Q?BpOWbC7tBAbvNWZbjOZic/5Scfkz2Wwule9o8WpG3HnWXLB8CIddxMZ7d1bL?=
 =?us-ascii?Q?r3G9uunFYpjf7iP5213ZcKnSFZciBNZhPJeqQkslb97ci5BY7hhaeIJHI5rJ?=
 =?us-ascii?Q?g8iSxrZpZfm/ZRs6x60TTt9KcyrE/iiU2UU/jeIjMzm/yvXyzFBhyMaZe3UA?=
 =?us-ascii?Q?Mhcy9zj/iHwNHWx8t0LcMRj5S+ZYQ2k4ZqLkLzIB9dkckG8D4SfWLMzsO4VC?=
 =?us-ascii?Q?HdL+pHigkvI6d0mHZy1jPefJFBzlO7ywEn652NkAO25Wd1Lz48K06V6+Uvwi?=
 =?us-ascii?Q?1shOcigl/RrZxRbCQlyTChr/vqis3V196LjW4MOtRO097xNszJgRjfJV87GI?=
 =?us-ascii?Q?nOZQDZ9lqtW+/7xt1Pvmg/MMA9/w2lUCC48dYL9jq1Jdj3YqSrfS76bi28BF?=
 =?us-ascii?Q?Mc2ydhCTZ5eBKIfpHxoIg+cfAHMyYMxRTFJT70sxUHIly1FZEWC8eT8JkkDu?=
 =?us-ascii?Q?hB1fOU1CoMrDqSwG2y6s359d7wBOe29Sbsw3dQKPp8ec/Ml7dOOb6USkeNVW?=
 =?us-ascii?Q?QdP8kg7yPCSD9MIlUkvBrRwIuuAuAZ7zRU8MWN3XdAcv1yNb65HZr8hGECpW?=
 =?us-ascii?Q?tkV/qTEkOLrkOnOSAH3RAar2cv/9XDrTrf7Pzs6iKMBo6bwFwONASRZCLAqo?=
 =?us-ascii?Q?UQTalvxStQmlgp/qnlKMj5bGdVG7FFhhnq18rchzZmoeTsZ1eGJbBy1I/hwY?=
 =?us-ascii?Q?XcTbZ7J8xpa+cBkw0jPbe9J5gjFSlsu37298uGheRGOAm4Ew/fTcViPBSIN8?=
 =?us-ascii?Q?MWKBNJ/+0ebX83qfAlHWNVB6uU+rcPT1RllxNl0kNpSNuPGBV0LKEKDuYJJY?=
 =?us-ascii?Q?tcAW97rAPIQcRBM1Tx5aPbR4r9Oz25nnfK8tieKplgf6eg3AltChrOUPIRnh?=
 =?us-ascii?Q?hK/OgkLITaZkR8c+/7F99XoeqLvM/NAez5eo8+Y3cLkG0j6SoulJVH2cBS4N?=
 =?us-ascii?Q?0PjL6oh2A7FkANs45Jzw8AqGke7gX6FfCMqGGOYpix7B3M2d?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c88581-7a61-49f7-c493-08de6d79c6e1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 16:38:13.0258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qv71RZnQYCnOh1NxK2vz9FPH+8No0bBehpGSsJTSKFzeAaPO0wq80L/C0vjBkMgTCktwj1yLE+P0HfAO2rL3zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7011
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8911-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:email]
X-Rspamd-Queue-Id: 53AB0146475
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 12:22:16AM +0900, Koichiro Den wrote:
> Interrupt emulation can assert the dw-edma IRQ line without updating the
> DONE/ABORT bits. With the shared read/write/common IRQ handlers, the
> driver cannot reliably distinguish such an emulated interrupt from a
> real one and leaving a level IRQ asserted may wedge the line.
>
> Allocate a dedicated, requestable Linux virtual IRQ (db_irq) for
> interrupt emulation and attach an irq_chip whose .irq_ack runs the
> core-specific deassert sequence (.ack_emulated_irq()). The physical
> dw-edma interrupt handlers raise this virtual IRQ via
> generic_handle_irq(), ensuring emulated IRQs are always deasserted.
>
> Export the virtual IRQ number (db_irq) and the doorbell register offset
> (db_offset) via struct dw_edma_chip so platform users can expose
> interrupt emulation as a doorbell.
>
> Without this, a single interrupt-emulation write can leave the level IRQ
> line asserted and cause the generic IRQ layer to disable it.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

I think it is good. Add Thomas Gleixner for irq part to do double check.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/dma/dw-edma/dw-edma-core.c | 127 +++++++++++++++++++++++++++--
>  include/linux/dma/edma.h           |   6 ++
>  2 files changed, 128 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 8e5f7defa6b6..51c1ea99c584 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -663,7 +663,96 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
>  	chan->status = EDMA_ST_IDLE;
>  }
>
> -static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
> +static void dw_edma_emul_irq_ack(struct irq_data *d)
> +{
> +	struct dw_edma *dw = irq_data_get_irq_chip_data(d);
> +
> +	dw_edma_core_ack_emulated_irq(dw);
> +}
> +
> +/*
> + * irq_chip implementation for interrupt-emulation doorbells.
> + *
> + * The emulated source has no mask/unmask mechanism. With handle_level_irq(),
> + * the flow is therefore:
> + *   1) .irq_ack() deasserts the source
> + *   2) registered handlers (if any) are dispatched
> + * Since deassertion is already done in .irq_ack(), handlers do not need to take
> + * care of it, hence IRQCHIP_ONESHOT_SAFE.
> + */
> +static struct irq_chip dw_edma_emul_irqchip = {
> +	.name		= "dw-edma-emul",
> +	.irq_ack	= dw_edma_emul_irq_ack,
> +	.flags		= IRQCHIP_ONESHOT_SAFE | IRQCHIP_SKIP_SET_WAKE,
> +};
> +
> +static int dw_edma_emul_irq_alloc(struct dw_edma *dw)
> +{
> +	struct dw_edma_chip *chip = dw->chip;
> +	int virq;
> +
> +	chip->db_irq = 0;
> +	chip->db_offset = ~0;
> +
> +	/*
> +	 * Only meaningful when the core provides the deassert sequence
> +	 * for interrupt emulation.
> +	 */
> +	if (!dw->core->ack_emulated_irq)
> +		return 0;
> +
> +	/*
> +	 * Allocate a single, requestable Linux virtual IRQ number.
> +	 * Use >= 1 so that 0 can remain a "not available" sentinel.
> +	 */
> +	virq = irq_alloc_desc(NUMA_NO_NODE);
> +	if (virq < 0)
> +		return virq;
> +
> +	irq_set_chip_and_handler(virq, &dw_edma_emul_irqchip, handle_level_irq);
> +	irq_set_chip_data(virq, dw);
> +	irq_set_noprobe(virq);
> +
> +	chip->db_irq = virq;
> +	chip->db_offset = dw_edma_core_db_offset(dw);
> +
> +	return 0;
> +}
> +
> +static void dw_edma_emul_irq_free(struct dw_edma *dw)
> +{
> +	struct dw_edma_chip *chip = dw->chip;
> +
> +	if (!chip)
> +		return;
> +	if (chip->db_irq <= 0)
> +		return;
> +
> +	irq_free_descs(chip->db_irq, 1);
> +	chip->db_irq = 0;
> +	chip->db_offset = ~0;
> +}
> +
> +static inline irqreturn_t dw_edma_interrupt_emulated(void *data)
> +{
> +	struct dw_edma_irq *dw_irq = data;
> +	struct dw_edma *dw = dw_irq->dw;
> +	int db_irq = dw->chip->db_irq;
> +
> +	if (db_irq > 0) {
> +		/*
> +		 * Interrupt emulation may assert the IRQ line without updating the
> +		 * normal DONE/ABORT status bits. With a shared IRQ handler we
> +		 * cannot reliably detect such events by status registers alone, so
> +		 * always perform the core-specific deassert sequence.
> +		 */
> +		generic_handle_irq(db_irq);
> +		return IRQ_HANDLED;
> +	}
> +	return IRQ_NONE;
> +}
> +
> +static inline irqreturn_t dw_edma_interrupt_write_inner(int irq, void *data)
>  {
>  	struct dw_edma_irq *dw_irq = data;
>
> @@ -672,7 +761,7 @@ static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
>  				       dw_edma_abort_interrupt);
>  }
>
> -static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
> +static inline irqreturn_t dw_edma_interrupt_read_inner(int irq, void *data)
>  {
>  	struct dw_edma_irq *dw_irq = data;
>
> @@ -681,12 +770,33 @@ static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
>  				       dw_edma_abort_interrupt);
>  }
>
> -static irqreturn_t dw_edma_interrupt_common(int irq, void *data)
> +static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
> +{
> +	irqreturn_t ret = IRQ_NONE;
> +
> +	ret |= dw_edma_interrupt_write_inner(irq, data);
> +	ret |= dw_edma_interrupt_emulated(data);
> +
> +	return ret;
> +}
> +
> +static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
>  {
>  	irqreturn_t ret = IRQ_NONE;
>
> -	ret |= dw_edma_interrupt_write(irq, data);
> -	ret |= dw_edma_interrupt_read(irq, data);
> +	ret |= dw_edma_interrupt_read_inner(irq, data);
> +	ret |= dw_edma_interrupt_emulated(data);
> +
> +	return ret;
> +}
> +
> +static inline irqreturn_t dw_edma_interrupt_common(int irq, void *data)
> +{
> +	irqreturn_t ret = IRQ_NONE;
> +
> +	ret |= dw_edma_interrupt_write_inner(irq, data);
> +	ret |= dw_edma_interrupt_read_inner(irq, data);
> +	ret |= dw_edma_interrupt_emulated(data);
>
>  	return ret;
>  }
> @@ -973,6 +1083,11 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	if (err)
>  		return err;
>
> +	/* Allocate a dedicated virtual IRQ for interrupt-emulation doorbells */
> +	err = dw_edma_emul_irq_alloc(dw);
> +	if (err)
> +		dev_warn(dev, "Failed to allocate emulation IRQ: %d\n", err);
> +
>  	/* Setup write/read channels */
>  	err = dw_edma_channel_setup(dw, wr_alloc, rd_alloc);
>  	if (err)
> @@ -988,6 +1103,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  err_irq_free:
>  	for (i = (dw->nr_irqs - 1); i >= 0; i--)
>  		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
> +	dw_edma_emul_irq_free(dw);
>
>  	return err;
>  }
> @@ -1010,6 +1126,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  	/* Free irqs */
>  	for (i = (dw->nr_irqs - 1); i >= 0; i--)
>  		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
> +	dw_edma_emul_irq_free(dw);
>
>  	/* Deregister eDMA device */
>  	dma_async_device_unregister(&dw->dma);
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 270b5458aecf..9da53c75e49b 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -73,6 +73,8 @@ enum dw_edma_chip_flags {
>   * @ll_region_rd:	 DMA descriptor link list memory for read channel
>   * @dt_region_wr:	 DMA data memory for write channel
>   * @dt_region_rd:	 DMA data memory for read channel
> + * @db_irq:		 Virtual IRQ dedicated to interrupt emulation
> + * @db_offset:		 Offset from DMA register base
>   * @mf:			 DMA register map format
>   * @dw:			 struct dw_edma that is filled by dw_edma_probe()
>   */
> @@ -94,6 +96,10 @@ struct dw_edma_chip {
>  	struct dw_edma_region	dt_region_wr[EDMA_MAX_WR_CH];
>  	struct dw_edma_region	dt_region_rd[EDMA_MAX_RD_CH];
>
> +	/* interrupt emulation */
> +	int			db_irq;
> +	resource_size_t		db_offset;
> +
>  	enum dw_edma_map_format	mf;
>
>  	struct dw_edma		*dw;
> --
> 2.51.0
>

