Return-Path: <dmaengine+bounces-11640-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DuKrKV1lNWpnvAYAu9opvQ
	(envelope-from <dmaengine+bounces-11640-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 17:50:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FE06A6D7A
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 17:50:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Iw+k8E0+;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11640-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11640-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62D7C301CDAD
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 15:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F5A3BA25F;
	Fri, 19 Jun 2026 15:46:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013040.outbound.protection.outlook.com [40.107.162.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE99E3B9928;
	Fri, 19 Jun 2026 15:46:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884004; cv=fail; b=bLgk6t8LukZ6QIUIZQg0Qap8c0Ls61kjTrkdq//WUlTw6CF4B+sCd+v2bIwMzB97LXJQe1AYYOyeHYvFvBb3cOt+VQT5/IU+HQgMkT0IniWKP6QCwvmZ447H6Xymlv09+v6EuhZx21qEfZ8wBoKhtoAGc5qZ+P1t0sC604IGy0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884004; c=relaxed/simple;
	bh=tYph5Cz3EU9mMSmG0UqAXgxPUeIR+WwNi6JNItu/aVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uvwZer2kKmxG5lqFDF5MHCYhn2etNLd78w0wOlVNJbMGi5papjDtPmmNkIbNrbFIM7HPRGrFH1GtMezrrnF1WYv0uFmKNzyKeCc82EaGV54WQujpC7UJm4ATANd/U3dVLUnVlkhhjFVaRhkXUESDKPEp3mXo5P7WJHRV5rSPhsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Iw+k8E0+; arc=fail smtp.client-ip=40.107.162.40
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhRD4HVESE2GN8RAluNf9DVOoywgcuPFPnVTxIIhgic6V8dpklXpbMIpadtuozQqoT6flvZ/Za9//4Dpgm8eW8nQxlqefLbSNPhUcjvYo+0+tPydU0Ciedbl/35iWTwtp4J/ZlBetZHkuiH6etD894G9RGYHyc3/zJg1tuhR2COUmLGPV0Ro3S67DBTwAN3+n79mZ8bn44uA4Pv5lTN2ZGj8VgwvOGRoQrYJ/yQSmtQcO9gBZqw/cCjZ4znzqdP1zNqFnzrXcHoigw+VrVj9gxeptVZ/cb+AIgwZnX2VQtA9EFFnfmMJIsISLUWdqF4yzOdzONqxGUPO/9PdYjH/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaLLIDHuL5dAnerllBRi3Wz6jxiL5S9/m4cNTw2wvRU=;
 b=AjBR05o1mGVUK7WoSXJ4uqQEkUmvH6PiJ9boMYdBec5aPQi0IXdjDI4CB4LxxKCdfAOZvBLkgVyeedFFzUyr57vWLSkhcL5/+Cks3Bg3AUrHmQpOnM34ZVQj+Oq6ZbRHOCeLI9vD0BOGj18QvdyMUvVcuXbw7NzJ0ZzADfrntGlxLQh6gIfh+8ANcYfwEHpmzS5/jTO5kiKDs8ShCb6ed6C9ZtWHR3krlZFGVXfBcc45PuJ3ipzt5mZPMQd48XVhjHm59RmYITTrYUn1g43k6MlBgQf7zA6w6/KsvcQOYayzGmiFIUGGUwWo85eiiA6VoEjZdzWUiDqeNJsBJVcQjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaLLIDHuL5dAnerllBRi3Wz6jxiL5S9/m4cNTw2wvRU=;
 b=Iw+k8E0+2l6GKfMGJNIEhC8G8J6jfxE7MZk9DmbjSEmF48xEEXk2KBfluaIqxEmlCDxMSCYhtCaIvvzLVN4E03rY+wFInOUlVu3hBFt/KWKbzWAWen1dD7UuE6WN6tQ8YFVylTZW9oWLubdIQUqT4xyX3wyY8cSAs0bcJEFUOpVpOn0dUzsHkdspmgzOmdzBEuIm6NpFW/U8QcMm+Xvn6yQgQzWhL2goL9JlUIgcMPfDzg8jFedQ2Jr6PjCPl3cYnl5srXgHYFdMUjqTxIBw2/Z2JwYHWL1RmS+aKNJUUx6rq2Lo+wSyZutMdMrUQCFeJDkAryJyND1bsHEMtLqGoQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB9792.eurprd04.prod.outlook.com (2603:10a6:10:4c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 15:46:37 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 15:46:37 +0000
Date: Fri, 19 Jun 2026 10:46:27 -0500
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
Subject: Re: [PATCH 3/5] dmaengine: sun6i-dma: Add num_channels_per_reg for
 flexible interrupt mapping
Message-ID: <ajVkUyWGmaUua9Zo@SMW015318>
References: <20260619-sun60i-a733-dma-v1-0-da4b649fc72a@gmail.com>
 <20260619-sun60i-a733-dma-v1-3-da4b649fc72a@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619-sun60i-a733-dma-v1-3-da4b649fc72a@gmail.com>
X-ClientProxiedBy: SA0PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:806:130::34) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB9792:EE_
X-MS-Office365-Filtering-Correlation-Id: fd403438-ccc2-4760-121d-08dece19f260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|7416014|376014|22082099003|18002099003|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	pliRJdDYrSiYGtonY/mOpiJKA4XXdoTFQTywqqwAio5mKUbP4c0QyVSzYLSt1aJE2OKoWDngyVjiZYUF+4GlX54/AryaQZneGVqWo6+DxoHDNOsFUfE0CP4FDIeyWGO90remevMp99QU64Q1jMiLLNVUS5G6rMtnCAXIkxJnPy91ntLV+kAML9ZRrIU/uGhb3p9LbMfETCkr3BO8yqELakQ1ZeuAiYmryw8AEt+Zlp1dt9m+F2O7PDPB4htEwUIZfW+BZfX5H1zjP437ypVG5aphzS+osbkYp8V3p212HZkJ63PAisANX7vmeB3jBzcyB6TSkyuO/JV16ICR4tZls7d5XSlMHmgXvZ71HrgVKIyU6xD6VJpojFMaBspfJr442Ld27NHNWxwC2zyQp30fvOZKY2IpLqfSVkzV/S5SiQYExP4TqGUM5BEPh5kB6ZgW45+90CGIXgrrbPo0JSBBVa5gzBtdg01Nr0SbS/JkKo6bfAeE3OmsLSaseNl6a9SZzIRBsSbDakhpLpky/ZPe33SJunT88vSTetRHS4hOIiMykHCGMtMbGRAtdKVGoLSnOBh5jBnEoYPaiEzBNDAv8X2d4Ajz2J9otYBudYgko6rMTWMZfo/s18XFGZeGn5fgPvm2W0/hy40HLQdA7pSjW/1JuYtwqFRQzY6ZLy7eV0o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DRDnxQvh/M2ZOSPEFasADqzlYiK6PCotv7QZoIf2Q+pXCg7aEu7F6KEWwxVx?=
 =?us-ascii?Q?y+jOVHsiXdyyKcyqbcBo4SZJNotpXJgtDB+ZhuXYlNcB2c4XSjzzK2y8gBWg?=
 =?us-ascii?Q?n2mrwFDjxY6Np4dp3adVpWmi3a2Udn0q6D8J2gLvDybxkhj9iiXRcjgNUpyP?=
 =?us-ascii?Q?ZjMeyriKtVUXJ6fj6qhu1z7c/J4X5FhjA5y4lLpFtHYoBCknbx6UUAPQu9i7?=
 =?us-ascii?Q?9fbagAKpH53M78mxi+PKsZj25EQoeBl59flfdabBb4Q9JpjWNHRn+J0ZMiI8?=
 =?us-ascii?Q?qdyRqQhmH56N+4zHhAj0JPs71sfYKdnNiJB6g7sGwIJTP6qbz5dHkrbpSFdH?=
 =?us-ascii?Q?1Dc+oQfrFrUNG+k5WCHJ7qNs9cUUT2unmmqIWq+gVMRtTax6VlrOMGIkG8v7?=
 =?us-ascii?Q?nDu3QjGWKsQeTTbxoWKjafZ6AGp+wgGwvqAnE61lALxc2oiE1qYgAdx89Nky?=
 =?us-ascii?Q?qr46kSRLW/dtUungBUCbR+aoV5Bg5QQ5+Kzv8BRdYg57q5xg05ZT1PVdEmX3?=
 =?us-ascii?Q?YBx6fJu05jRP6ZA4izSDrKomfc75EuN+TnfJBAx1akw2VIATc3r+Kk2tVymO?=
 =?us-ascii?Q?ua5HKQxrWp3vwO89r6QaYHIqfEW/7Cv0prHkDy0RV7azvWtcPl7Tztgxr2A4?=
 =?us-ascii?Q?6aAGh71jG7JHb1WZJDVrT42yi+oWXJMEOTQfb5kB0x0VZThrsc4h9PJT1s3H?=
 =?us-ascii?Q?PrdAqa5IovG6K1lk8XMm2IR/JENoiHlPsQboc7k74Jy+dErocRZlPK9z5i34?=
 =?us-ascii?Q?Hv9ZSCjEeTZQyA7CNQ7lsNdOb8l2lvJ9YH3OQxCeOj0H+8CmhLLpWGuVPUWE?=
 =?us-ascii?Q?zsd9QLy1/FvkXqmTEbgZmuEkv62lOzeXIVBe7zPMi64zUjv1YXwQ092Himu+?=
 =?us-ascii?Q?/WeqvqwWdp8OIwvw9dtkUVf0usr5W0bSos7K/glaBA4iNE4TQN2Gj/JS5cKS?=
 =?us-ascii?Q?ah6y40pfU0lyFPIgIElyEU2aT/PLEQ1MuhkSNpuCMrnshw6MBU9pjuNK8VLS?=
 =?us-ascii?Q?6Vh3+BQ7b4KJklrPMyEymuYg/rNaz4DIgoEMj3lTByCotME0jNYf9rB2SVh5?=
 =?us-ascii?Q?UZPO9ufPm+H6lpYEwB7bQbOKAcLYe8ttWLCoa2N2Xh4bnpmNgcM0Efa7GVGg?=
 =?us-ascii?Q?1JdeAEqxPp6/r+TxYrU+y2Y+E3ZA29TnhwvS4A06sQlnRYwmuzmxFinql8Xy?=
 =?us-ascii?Q?8zo1KkVhum9jBkBjeLlffax26FMfeNEkAwibVl80kfRmq2944vF5Xw6fY2uY?=
 =?us-ascii?Q?FDIcWtskPogcwob64qJtDwN7i7fNsmIiYhF53Jz3XWU4Q84/2V0W3zUlmMkz?=
 =?us-ascii?Q?VEdhblb1cDz/BF5adjWuTUsP634CxXrS9hxNLZRH3w775FLv20WfS6w/l0H9?=
 =?us-ascii?Q?jSGsMkcnrdPufs6Z0B65TBLc85jVu/CClPk/jQ4KxO5SWVmc5W8nfSGBiDEQ?=
 =?us-ascii?Q?3l3x+H4l8o3GZauZm5COuMvBVgDe1InsnJmkJeIh4asSAvRuLLITMe/lng5K?=
 =?us-ascii?Q?DDVs0w2CTIfsfzY/R+kGCTlYXpBDp8qkOzNsXLFURBtR5ZFUGbTJmgw+PRgs?=
 =?us-ascii?Q?LsXAFjh5VqXLTVsRsO6ebpB5cHk1YrI0tXc2/8im2AGGwD0Y9yLi2JgfFPRF?=
 =?us-ascii?Q?0IfHH+n/3QmGIeOIT+MmYz6gMdCto09md0/kVlIPxMgXL46Bae1lLOyEDAcM?=
 =?us-ascii?Q?39YkvgSno2SAl+2bWjTRXI5pFPOLXfOyX5c+RBtG5xR4K6U1Byp8Xwg9ajzG?=
 =?us-ascii?Q?N3eUWjFmFYnzGQU4/L4+cy4YMyGNm9kHhhFWyVPK2TnI1+BiH8sE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd403438-ccc2-4760-121d-08dece19f260
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 15:46:37.1749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJlo8+fsDNTH3+nuXNNdTkXxlYnJbxco+eaDWUJUrBb+X3yXswd3ymRahqgtXbulPNQOe4ys0X8rTzfbqihgL6cl8E5PZXcXT12tdy4ZjYoPchwQP94x/Tk/LuMYgbd1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9792
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:alex.caoys@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:mripard@kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:alexcaoys@gmail.com,m:jernejskrabec@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11640-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.nxp.com:from_mime,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44FE06A6D7A

On Fri, Jun 19, 2026 at 04:53:32AM +0000, Yuanshen Cao wrote:
>
> The previous implementation of `sun6i-dma` had some implicit assumptions
> about the number of channels per interrupt register. Specifically,
> functions like `sun6i_kill_tasklet` were hardcoded to only disable
> interrupts for IRQ 0 and 1. `DMA_MAX_CHANNELS` is also not in used in
> the past, and the old SoCs never has more than 16 channels.
>
> The A733 has a different interrupt structure where the number of
> channels per register may differ. This patch introduces
> `num_channels_per_reg` to the `sun6i_dma_config`, similar to BSP, to
> make the interrupt handling logic hardware-agnostic. It also sets
> `DMA_MAX_CHANNELS` to 16 to align with the new BSP code and ensure loops
> over interrupts are correctly bounded.
>
> Changes:
> - Change `DMA_MAX_CHANNELS` definition to 16.
> - Added `num_channels_per_reg` to `struct sun6i_dma_config`.
> - Replaced hardcoded IRQ register calculations with values from
>   `sdev->cfg->num_channels_per_reg`.
> - Updated `sun6i_kill_tasklet` to loop through all possible interrupt
>   registers based on `DMA_MAX_CHANNELS` and the configuration.
>
> Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
> ---
>  drivers/dma/sun6i-dma.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
...
> @@ -1171,6 +1174,7 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
>         .dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>                              BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>                              BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> +       .num_channels_per_reg = DMA_IRQ_CHAN_NR,

if previous patch have MACRO, you can put it to there

Frank

