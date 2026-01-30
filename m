Return-Path: <dmaengine+bounces-8622-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHwsDGzQfGlbOwIAu9opvQ
	(envelope-from <dmaengine+bounces-8622-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:38:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F43EBC19E
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CFB13008D3E
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 15:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42EB3375AA;
	Fri, 30 Jan 2026 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OYdGMQDQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010000.outbound.protection.outlook.com [52.101.69.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F332E6BF;
	Fri, 30 Jan 2026 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787488; cv=fail; b=rVGaOnXi1znPsjNqLCAUdspzNytxfOXxKrn5ZUZDm9VmyesCIjd0w6MgSsYyQFv0wdn10TJYqEjdZPGVsNX0jK1lYavjnhVNpSkikVV5gYIGrcFajxSwmwzxek2X1YR1V95EgzO0lv+r+WrWBj3NUTmiwR0uK/1zmTYQIFtG8Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787488; c=relaxed/simple;
	bh=mZglA3TzWBg1O0LsEeLH47JEM1RxPAj7+trpk/ZGvS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V82fWFgf7JB4MxK2ovzJIhSPrTAUVGim//DWq+1e3XeS37LOuDA1zEdW9tz/lFHer/n+ZFcv7zNg0pyYVvT5hUAbMo1uEmjVfkRjz0S+dM7OKy6xj8z/KxXEiCIbNJ4No+T7ZgO6eF8lwdH98i0YhrF2pDfWcYh+Az0laEi44jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OYdGMQDQ; arc=fail smtp.client-ip=52.101.69.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTJADwIm1i0nb5c56o2cldNFLABL0+4Eh7vOFFbEiu+xsSc7XNBEvDuuHUDlOvvmI1ACyKPHn02aMsHancWqCzhzcpDMtFg89rdDMe9rRsDo3BRHtHJyS9pDr61EenuPf5hqSYm110xi4ymrAJoAftfJeDCrV//16jGnCsbOGyaRxS2OKnfWlaQFBXnUiyNYleF6q1fZ+sb/NExVwwHlBTtgGDfBuFFB3bx55AGZhg/CE7vzDsddXvHdxZ7rd0qihO+1oP8iphbs61osH9Pn3rWwslxcxRE3Tbh0kc1aXRu+kMACIHPIcrwBM2CNUVYAUEFgYAPbbZRYCidXc3j+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u27likTCV9boTGRLN6b3yp1VJypwH7typ80fBr3uWg0=;
 b=mcM6W91CVquRUgqbAZ/8U1y14rFqsha7ACaol5GQzHNb2s0V8CE2O0PoDUgrQgTnT0u49m7Wa85J8ibJS2Be/pKZV2N+P1f+ZbYzmPDu5i/O+4654xqidgy2sPDxT82bxifaCc8t4UZT5j6gf6O9kzuIV0fTT4BPLtLVzWmJWuLOlcbH8yX2+/f0iuQ4OfA8s+ypKn5C22ehaP8gS/HIUJxA50Wi+kDjPPPc7CvRCdIBIKPReZwHPYFHrvjbs4JB0+o/7QPPYbFurNKSWpcT95bfki5Gk57NNrvA7Hz8VdQxXEqT5pLgXj/BYNsojQtSyoi3mbf4O825wy++gVRHHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u27likTCV9boTGRLN6b3yp1VJypwH7typ80fBr3uWg0=;
 b=OYdGMQDQV7UAorVhX51GfFoc5+AfhBUR1ny5m7ppyqjRpw934+9EVUDr2u3yiD+BCYr7yqTLfSKjvbu31GtNzncAY9waMFHZ6ctH3EPa/D+wE9Kd2bRj2/WUNUyKQVWqc8zowzYDWqivC+ycQ1j0HhUD8qrQ5RBFCFIK+bAdohoXIpu490kCMd2i+GoSx3bCvaJt8OYcVatw29Qfut81Dg34l66iAWMHIRIVi9jyi5DL/2BwtH67QgAhoMz5PNcLj66i0CHc0p2VnvZK2eoVqkpH46qJ/+OnlHjC2Hs8+Jhpdtji0JPH2Zm0Xi2pzuot6j8Qh1CIs/7zU0Qm9l6G+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI1PR04MB9811.eurprd04.prod.outlook.com (2603:10a6:800:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 15:38:03 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 15:38:01 +0000
Date: Fri, 30 Jan 2026 10:37:52 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
	ssantosh@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, vigneshr@ti.com,
	r-sharma3@ti.com, gehariprasath@ti.com
Subject: Re: [PATCH v4 02/19] dmaengine: ti: k3-udma: move structs and enums
 to header file
Message-ID: <aXzQULmTf4dju/LD@lizhi-Precision-Tower-5810>
References: <20260130110159.359501-1-s-adivi@ti.com>
 <20260130110159.359501-3-s-adivi@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130110159.359501-3-s-adivi@ti.com>
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI1PR04MB9811:EE_
X-MS-Office365-Filtering-Correlation-Id: b9586a80-fb6f-4112-4a61-08de60158d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|52116014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ofkqDWCdIBVIZl8xYjbbEjos8edtqHtsh+DrrTsK0VqW4JHKpvD60m7ztcmi?=
 =?us-ascii?Q?urwim+Yg8zJiVCzwyRQy0j2tvrxWlkzxrrxQ81Rnhix0BMNuBoE6WqYMn1zn?=
 =?us-ascii?Q?3FkzAl1aYe+bshAYqz4pMxYvWo1gK5sOxiC4ic4JDkeOQEXL2H2rRLzHlK6z?=
 =?us-ascii?Q?T+kMVIZ9yrmUrw0uPBjB/JTz5NX6ZkL0X5g0s9SgWcdkt3JwakdwilQ4DGh7?=
 =?us-ascii?Q?iS8ZyBOgnsliAMXFE6/+CNeNP0XE8LAGo9KmhT2+9usS8xCJRKCXmf0UVxTi?=
 =?us-ascii?Q?iS/FTpEZlOyVFDwTLEgX05gBplQRJ8CWCFhpTtabVrIetRrKH/CzDNzAvnHE?=
 =?us-ascii?Q?3PEl30StkZnXHdWp5ujHM8zswbp6WbEs9HxewmhTmKHic9zxrqGxRg1Gpnan?=
 =?us-ascii?Q?unerRrt7PB1GFXwqrMfAqwM4i19QJvdAp4QwyUYfRl7SN/W6SL2qDFfO72Wk?=
 =?us-ascii?Q?Yu1CeN4j9FTJZnTM/Cs6RDq/8QCSVmQ+stlnZIQTyUdYVLHinGIdiQL+USP0?=
 =?us-ascii?Q?RFHtAWRmPfVqEWYTVfWmme7VpLrLtGx/B/18y1B0wMKb0jJEt/mIE5VpkCAE?=
 =?us-ascii?Q?7u//r1hns9uk90ad36gagOf3F1/K48xWY/MHXdRt05zRGgotrArj2gFc+B8g?=
 =?us-ascii?Q?4t2OQH2sWEeHW/A4FMp56/UEcbQK/gXv2xraobAgNSjS3CNodE/dn4OkPjsV?=
 =?us-ascii?Q?DBXt5Vh03DHiq+G1oouynjuJ9PhI+1lJrplrb9zAZOyeng0QTk+uOyyKsx6X?=
 =?us-ascii?Q?FxO4Ga3QYHVn2NBsB2K8Wtdtj2izPagBOp2YK0opoyKLdc5MT52emyMu+JYZ?=
 =?us-ascii?Q?qqB90XnHNJYAnd1iiefsT38BysFXY1rBHBUTjH/B0oP6AltROdjRGMh8s5Nc?=
 =?us-ascii?Q?OGcciZUiR2PKfMjwqOvhg+WNt+gkUiWyyak5rLjV85LQKreBQj+Un5B1UqIi?=
 =?us-ascii?Q?/+EswsPvs95DojaBlN5wlrxE+3p4nuLw3o8yYCVgKfy8feFzdKGVilXCC7hX?=
 =?us-ascii?Q?BwfxsComLrS8qTmPniTUen0p6RADo5RaXuotesKx5JatItIRYXdoSESbsku0?=
 =?us-ascii?Q?9J6x4FVe37rKFpTu2HMCRvfhQ0GOhIz/3EVeSvaJmnWHy57xXlcWQpGuSvww?=
 =?us-ascii?Q?FSvaxFPMsi/Y9YwvnuXyNJLAR6Q5/h+QUiBs67d5ezH83mnI4HahbJ0yE3+x?=
 =?us-ascii?Q?7Qe8Cbu8c5bds7CL0QL9+DCqGrCD0SU0gYDdrqrhdB+FCtOI8zkXZKQPliKT?=
 =?us-ascii?Q?yjaiWNPfEx1GV6Nt8d6mlEXJuSVS0fHvE79LQiv4ScBLij6nqY4fuzzec+5W?=
 =?us-ascii?Q?R8WzyH84Mut/aDnSNfqOxkx+EUbinql7jQ+LzCLpcMkFVqCZkbPHgZKpkuB5?=
 =?us-ascii?Q?wZOFu0SHQoLefwP4O7dAdGyF7639d5+DZiOFKKi96TKdcZ+GDHZnBjIlycf3?=
 =?us-ascii?Q?GAL+aolzGMqObXAJ8N45vODYmSmkY+2i2+vO7brJ9P8gFD3AwNDbAu4t2lpw?=
 =?us-ascii?Q?m22X8qDGbtkrjEvfsRq47iH042rLJZ0m0gqER5Eny9zvYpo3NYl0OeAPrLxO?=
 =?us-ascii?Q?UtkkUtUqZ4qqn9F7w28i0iwL5koUF0DVKVsrU9c+29/dEqjMweQz8roJAo6D?=
 =?us-ascii?Q?kWw4Nu64bDHe9AkVlsdBJwk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tkpjn7PEHwGCgw0064r6lOE/J0E42cg1vq4OZrmEVjvpdMOJ789Gjjlan3YY?=
 =?us-ascii?Q?O2jQEymqyr9578SF/ySB/NlP60uhr46gaRO+vvHu2Q0E/sabYK9SpBQdv8yX?=
 =?us-ascii?Q?V6hmX9Uo/Y0ALtcZ/HZdFBdV8KrjSaY4r8k8jIMitTPL+8W6b+Q/KiYQDuEV?=
 =?us-ascii?Q?vAIvJxTDMJSvfAs/R6J0WYjf8gs2OBn+wJK4XWMPgNcLj7YAtgbUr4hqGcU9?=
 =?us-ascii?Q?H9Opvrs5SiKjwubrxVryZKrBlzdZTBn1uadc4KhJGF1+5nR640DRMRbSs87+?=
 =?us-ascii?Q?LqrwxyhYA4rhHweE3BNqI9QSsDgMVcmngxngnBxh1SVLXR0KaOeRLSN/UbEg?=
 =?us-ascii?Q?KoeD0+Ce+y/zb2CI70HB1BND7KFqoFVESFyyqtYtJSxCOqyj8NcBT6EEva9h?=
 =?us-ascii?Q?Z9jmtul/5GSu36hsR7uvInUsQ0dRHyYiyzTEbnV+3qPVf/Ddrsf+wup2tlwQ?=
 =?us-ascii?Q?SvIezHaMsXJYD5JQ2SWnGGdUtPDPNGzXjY8+bArv5tkBBeRlY2pN10zJga9D?=
 =?us-ascii?Q?F5jQLaGF/bkEi7X5q5KwSR5NK1EBkCOgZy/gr9uFCgBLXtXxINyUrI0CEDQU?=
 =?us-ascii?Q?AUWczzJ7PzMpUQFTt1o8l2UWNHvNQEYQQrZ5mXiiCBWC9dlt/lHctqDjkpu2?=
 =?us-ascii?Q?TToz2PLctPipgDt6FiyQgLGuoDhp+CmkDZaR1tBrRXKIaLcszm7I6hIjADWH?=
 =?us-ascii?Q?hO5ptWtAS3vk22N+XBhgzVBpWUbN7sxmv4iAPSCQDPUTslVy+MFK1jH86cya?=
 =?us-ascii?Q?dWWLgzztDY5nz/BL/nWoEXao32fcN85DKkTWgNCtY48UO0wtV2rNOlj2dd+u?=
 =?us-ascii?Q?z+WEHGpAnT20xiFXDTAAIzEoQXFQ+uLTD69oAmQtvgpruQjDSsD5KFhdi6RF?=
 =?us-ascii?Q?n0O/YlNtgvnM8+TiU9A+Fh/Aw9P4DqeeIdi4zKfgZ5GfYtUZ4M9HnhRz2Ov3?=
 =?us-ascii?Q?V+EE48vPPH1t64e1qSPioNBSj+Voi3SDqAI2c8cvYjVk3swsP25NdJMnRG7e?=
 =?us-ascii?Q?nOKC/92fYrswJbTYarn6jIcBK8SRQtgdQtM31FjwudOtbrBpexvHt9Sk1zgu?=
 =?us-ascii?Q?VCYuqpm6FPUZhSTKup7X496HOP25S4ZiyPHyzG4mJnCMExtBijaF6MOP4NwI?=
 =?us-ascii?Q?O8p4vBt7WLPZlYgfx1IRycW1vrJvv3xUARoVgZJfovu3A/E8hlednen/dAJv?=
 =?us-ascii?Q?3EDjzhEqV3RaUboJsW008eN4qA0M/TfpJkdDeiJyAqjxtCvwXChNGK+/iJTb?=
 =?us-ascii?Q?w2KNlYyxFr9wN+yn/SlbOziGerPm3LpG+zrzJpK1fClnlPAjsR9K183YQHOp?=
 =?us-ascii?Q?wzC8X8D4PK/2W+9wI4RemVA+zd/KqO3irF7nT6FTgcIkGclvp3ksrMUn7loI?=
 =?us-ascii?Q?GDdraT5cK81Eo1Q/DoB5NRVlgKJIBU7ngeD10SwGWwD0PeMnJPgBzE4gWeQI?=
 =?us-ascii?Q?5R8sU7m06etz0ZiCmWj0IFjfQUN11AFRE/8iiyY7SZZd4vL3dyzwuiRp4fif?=
 =?us-ascii?Q?W9dFzmWMQi+b311MgBz1mySXTXVsabxN2bTlhZRhee2RDl2/zzQ+IzgKQH1e?=
 =?us-ascii?Q?3ec9rQqNcXafuMA38Mqpzx+Vwg1bg2YblO2fHzxiFHFmZBnu6Bqj1c0DXid6?=
 =?us-ascii?Q?QQzU3aXZHhZeUH8Ec+7ag9wfq6WHtiVFszkVcRiDAIOQudFbliO3f8qDPPZ1?=
 =?us-ascii?Q?Ohn9jp+jmRqLPN6E5jR4ZuqcWZjJlMIVYuxx0Rz3vYVuV1peqq3T0eCj46S/?=
 =?us-ascii?Q?PVD63wHJjw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9586a80-fb6f-4112-4a61-08de60158d20
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 15:38:01.4052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVYHVvxHIhhMXA1hlspZq5N3o5kSh/NtAPiTK5iVQAuSYFm2zef1xY0RKSyMGCjgu4HhPgFpBJrKKG4inr+/Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9811
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
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8622-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3F43EBC19E
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 04:31:42PM +0530, Sai Sree Kartheek Adivi wrote:
> Move struct and enum definitions in k3-udma.c to k3-udma.h header file
> for better separation and re-use.
>
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/dma/ti/k3-udma.c | 259 +-------------------------------------
>  drivers/dma/ti/k3-udma.h | 261 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 262 insertions(+), 258 deletions(-)
>
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 4cc64763de1f6..e0684d83f9791 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -24,8 +24,8 @@
>  #include <linux/workqueue.h>
>  #include <linux/completion.h>
>  #include <linux/soc/ti/k3-ringacc.h>
> -#include <linux/soc/ti/ti_sci_protocol.h>
>  #include <linux/soc/ti/ti_sci_inta_msi.h>
> +#include <linux/soc/ti/ti_sci_protocol.h>
>  #include <linux/dma/k3-event-router.h>
>  #include <linux/dma/ti-cppi5.h>
>
> @@ -33,28 +33,6 @@
>  #include "k3-udma.h"
>  #include "k3-psil-priv.h"
>
> -struct udma_static_tr {
> -	u8 elsize; /* RPSTR0 */
> -	u16 elcnt; /* RPSTR0 */
> -	u16 bstcnt; /* RPSTR1 */
> -};
> -
> -struct udma_chan;
> -
> -enum k3_dma_type {
> -	DMA_TYPE_UDMA = 0,
> -	DMA_TYPE_BCDMA,
> -	DMA_TYPE_PKTDMA,
> -};
> -
> -enum udma_mmr {
> -	MMR_GCFG = 0,
> -	MMR_BCHANRT,
> -	MMR_RCHANRT,
> -	MMR_TCHANRT,
> -	MMR_LAST,
> -};
> -
>  static const char * const mmr_names[] = {
>  	[MMR_GCFG] = "gcfg",
>  	[MMR_BCHANRT] = "bchanrt",
> @@ -62,234 +40,6 @@ static const char * const mmr_names[] = {
>  	[MMR_TCHANRT] = "tchanrt",
>  };
>
> -struct udma_tchan {
> -	void __iomem *reg_rt;
> -
> -	int id;
> -	struct k3_ring *t_ring; /* Transmit ring */
> -	struct k3_ring *tc_ring; /* Transmit Completion ring */
> -	int tflow_id; /* applicable only for PKTDMA */
> -
> -};
> -
> -#define udma_bchan udma_tchan
> -
> -struct udma_rflow {
> -	int id;
> -	struct k3_ring *fd_ring; /* Free Descriptor ring */
> -	struct k3_ring *r_ring; /* Receive ring */
> -};
> -
> -struct udma_rchan {
> -	void __iomem *reg_rt;
> -
> -	int id;
> -};
> -
> -struct udma_oes_offsets {
> -	/* K3 UDMA Output Event Offset */
> -	u32 udma_rchan;
> -
> -	/* BCDMA Output Event Offsets */
> -	u32 bcdma_bchan_data;
> -	u32 bcdma_bchan_ring;
> -	u32 bcdma_tchan_data;
> -	u32 bcdma_tchan_ring;
> -	u32 bcdma_rchan_data;
> -	u32 bcdma_rchan_ring;
> -
> -	/* PKTDMA Output Event Offsets */
> -	u32 pktdma_tchan_flow;
> -	u32 pktdma_rchan_flow;
> -};
> -
> -struct udma_match_data {
> -	enum k3_dma_type type;
> -	u32 psil_base;
> -	bool enable_memcpy_support;
> -	u32 flags;
> -	u32 statictr_z_mask;
> -	u8 burst_size[3];
> -	struct udma_soc_data *soc_data;
> -};
> -
> -struct udma_soc_data {
> -	struct udma_oes_offsets oes;
> -	u32 bcdma_trigger_event_offset;
> -};
> -
> -struct udma_hwdesc {
> -	size_t cppi5_desc_size;
> -	void *cppi5_desc_vaddr;
> -	dma_addr_t cppi5_desc_paddr;
> -
> -	/* TR descriptor internal pointers */
> -	void *tr_req_base;
> -	struct cppi5_tr_resp_t *tr_resp_base;
> -};
> -
> -struct udma_rx_flush {
> -	struct udma_hwdesc hwdescs[2];
> -
> -	size_t buffer_size;
> -	void *buffer_vaddr;
> -	dma_addr_t buffer_paddr;
> -};
> -
> -struct udma_tpl {
> -	u8 levels;
> -	u32 start_idx[3];
> -};
> -
> -struct udma_dev {
> -	struct dma_device ddev;
> -	struct device *dev;
> -	void __iomem *mmrs[MMR_LAST];
> -	const struct udma_match_data *match_data;
> -	const struct udma_soc_data *soc_data;
> -
> -	struct udma_tpl bchan_tpl;
> -	struct udma_tpl tchan_tpl;
> -	struct udma_tpl rchan_tpl;
> -
> -	size_t desc_align; /* alignment to use for descriptors */
> -
> -	struct udma_tisci_rm tisci_rm;
> -
> -	struct k3_ringacc *ringacc;
> -
> -	struct work_struct purge_work;
> -	struct list_head desc_to_purge;
> -	spinlock_t lock;
> -
> -	struct udma_rx_flush rx_flush;
> -
> -	int bchan_cnt;
> -	int tchan_cnt;
> -	int echan_cnt;
> -	int rchan_cnt;
> -	int rflow_cnt;
> -	int tflow_cnt;
> -	unsigned long *bchan_map;
> -	unsigned long *tchan_map;
> -	unsigned long *rchan_map;
> -	unsigned long *rflow_gp_map;
> -	unsigned long *rflow_gp_map_allocated;
> -	unsigned long *rflow_in_use;
> -	unsigned long *tflow_map;
> -
> -	struct udma_bchan *bchans;
> -	struct udma_tchan *tchans;
> -	struct udma_rchan *rchans;
> -	struct udma_rflow *rflows;
> -
> -	struct udma_chan *channels;
> -	u32 psil_base;
> -	u32 atype;
> -	u32 asel;
> -};
> -
> -struct udma_desc {
> -	struct virt_dma_desc vd;
> -
> -	bool terminated;
> -
> -	enum dma_transfer_direction dir;
> -
> -	struct udma_static_tr static_tr;
> -	u32 residue;
> -
> -	unsigned int sglen;
> -	unsigned int desc_idx; /* Only used for cyclic in packet mode */
> -	unsigned int tr_idx;
> -
> -	u32 metadata_size;
> -	void *metadata; /* pointer to provided metadata buffer (EPIP, PSdata) */
> -
> -	unsigned int hwdesc_count;
> -	struct udma_hwdesc hwdesc[];
> -};
> -
> -enum udma_chan_state {
> -	UDMA_CHAN_IS_IDLE = 0, /* not active, no teardown is in progress */
> -	UDMA_CHAN_IS_ACTIVE, /* Normal operation */
> -	UDMA_CHAN_IS_TERMINATING, /* channel is being terminated */
> -};
> -
> -struct udma_tx_drain {
> -	struct delayed_work work;
> -	ktime_t tstamp;
> -	u32 residue;
> -};
> -
> -struct udma_chan_config {
> -	bool pkt_mode; /* TR or packet */
> -	bool needs_epib; /* EPIB is needed for the communication or not */
> -	u32 psd_size; /* size of Protocol Specific Data */
> -	u32 metadata_size; /* (needs_epib ? 16:0) + psd_size */
> -	u32 hdesc_size; /* Size of a packet descriptor in packet mode */
> -	bool notdpkt; /* Suppress sending TDC packet */
> -	int remote_thread_id;
> -	u32 atype;
> -	u32 asel;
> -	u32 src_thread;
> -	u32 dst_thread;
> -	enum psil_endpoint_type ep_type;
> -	bool enable_acc32;
> -	bool enable_burst;
> -	enum udma_tp_level channel_tpl; /* Channel Throughput Level */
> -
> -	u32 tr_trigger_type;
> -	unsigned long tx_flags;
> -
> -	/* PKDMA mapped channel */
> -	int mapped_channel_id;
> -	/* PKTDMA default tflow or rflow for mapped channel */
> -	int default_flow_id;
> -
> -	enum dma_transfer_direction dir;
> -};
> -
> -struct udma_chan {
> -	struct virt_dma_chan vc;
> -	struct dma_slave_config	cfg;
> -	struct udma_dev *ud;
> -	struct device *dma_dev;
> -	struct udma_desc *desc;
> -	struct udma_desc *terminated_desc;
> -	struct udma_static_tr static_tr;
> -	char *name;
> -
> -	struct udma_bchan *bchan;
> -	struct udma_tchan *tchan;
> -	struct udma_rchan *rchan;
> -	struct udma_rflow *rflow;
> -
> -	bool psil_paired;
> -
> -	int irq_num_ring;
> -	int irq_num_udma;
> -
> -	bool cyclic;
> -	bool paused;
> -
> -	enum udma_chan_state state;
> -	struct completion teardown_completed;
> -
> -	struct udma_tx_drain tx_drain;
> -
> -	/* Channel configuration parameters */
> -	struct udma_chan_config config;
> -	/* Channel configuration parameters (backup) */
> -	struct udma_chan_config backup_config;
> -
> -	/* dmapool for packet mode descriptors */
> -	bool use_dma_pool;
> -	struct dma_pool *hdesc_pool;
> -
> -	u32 id;
> -};
> -
>  static inline struct udma_dev *to_udma_dev(struct dma_device *d)
>  {
>  	return container_of(d, struct udma_dev, ddev);
> @@ -4073,13 +3823,6 @@ static struct platform_driver udma_driver;
>  static struct platform_driver bcdma_driver;
>  static struct platform_driver pktdma_driver;
>
> -struct udma_filter_param {
> -	int remote_thread_id;
> -	u32 atype;
> -	u32 asel;
> -	u32 tr_trigger_type;
> -};
> -
>  static bool udma_dma_filter_fn(struct dma_chan *chan, void *param)
>  {
>  	struct udma_chan_config *ucc;
> diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
> index 750720cd06911..37aa9ba5b4d18 100644
> --- a/drivers/dma/ti/k3-udma.h
> +++ b/drivers/dma/ti/k3-udma.h
> @@ -6,7 +6,12 @@
>  #ifndef K3_UDMA_H_
>  #define K3_UDMA_H_
>
> +#include <linux/dmaengine.h>
>  #include <linux/soc/ti/ti_sci_protocol.h>
> +#include <linux/dma/ti-cppi5.h>
> +
> +#include "../virt-dma.h"
> +#include "k3-psil-priv.h"
>
>  /* Global registers */
>  #define UDMA_REV_REG			0x0
> @@ -164,6 +169,7 @@ struct udma_dev;
>  struct udma_tchan;
>  struct udma_rchan;
>  struct udma_rflow;
> +struct udma_chan;
>
>  enum udma_rm_range {
>  	RM_RANGE_BCHAN = 0,
> @@ -186,6 +192,261 @@ struct udma_tisci_rm {
>  	struct ti_sci_resource *rm_ranges[RM_RANGE_LAST];
>  };
>
> +struct udma_static_tr {
> +	u8 elsize; /* RPSTR0 */
> +	u16 elcnt; /* RPSTR0 */
> +	u16 bstcnt; /* RPSTR1 */
> +};
> +
> +enum k3_dma_type {
> +	DMA_TYPE_UDMA = 0,
> +	DMA_TYPE_BCDMA,
> +	DMA_TYPE_PKTDMA,
> +};
> +
> +enum udma_mmr {
> +	MMR_GCFG = 0,
> +	MMR_BCHANRT,
> +	MMR_RCHANRT,
> +	MMR_TCHANRT,
> +	MMR_LAST,
> +};
> +
> +struct udma_filter_param {
> +	int remote_thread_id;
> +	u32 atype;
> +	u32 asel;
> +	u32 tr_trigger_type;
> +};
> +
> +struct udma_tchan {
> +	void __iomem *reg_rt;
> +
> +	int id;
> +	struct k3_ring *t_ring; /* Transmit ring */
> +	struct k3_ring *tc_ring; /* Transmit Completion ring */
> +	int tflow_id; /* applicable only for PKTDMA */
> +
> +};
> +
> +#define udma_bchan udma_tchan
> +
> +struct udma_rflow {
> +	int id;
> +	struct k3_ring *fd_ring; /* Free Descriptor ring */
> +	struct k3_ring *r_ring; /* Receive ring */
> +};
> +
> +struct udma_rchan {
> +	void __iomem *reg_rt;
> +
> +	int id;
> +};
> +
> +struct udma_oes_offsets {
> +	/* K3 UDMA Output Event Offset */
> +	u32 udma_rchan;
> +
> +	/* BCDMA Output Event Offsets */
> +	u32 bcdma_bchan_data;
> +	u32 bcdma_bchan_ring;
> +	u32 bcdma_tchan_data;
> +	u32 bcdma_tchan_ring;
> +	u32 bcdma_rchan_data;
> +	u32 bcdma_rchan_ring;
> +
> +	/* PKTDMA Output Event Offsets */
> +	u32 pktdma_tchan_flow;
> +	u32 pktdma_rchan_flow;
> +};
> +
> +struct udma_match_data {
> +	enum k3_dma_type type;
> +	u32 psil_base;
> +	bool enable_memcpy_support;
> +	u32 flags;
> +	u32 statictr_z_mask;
> +	u8 burst_size[3];
> +	struct udma_soc_data *soc_data;
> +};
> +
> +struct udma_soc_data {
> +	struct udma_oes_offsets oes;
> +	u32 bcdma_trigger_event_offset;
> +};
> +
> +struct udma_hwdesc {
> +	size_t cppi5_desc_size;
> +	void *cppi5_desc_vaddr;
> +	dma_addr_t cppi5_desc_paddr;
> +
> +	/* TR descriptor internal pointers */
> +	void *tr_req_base;
> +	struct cppi5_tr_resp_t *tr_resp_base;
> +};
> +
> +struct udma_rx_flush {
> +	struct udma_hwdesc hwdescs[2];
> +
> +	size_t buffer_size;
> +	void *buffer_vaddr;
> +	dma_addr_t buffer_paddr;
> +};
> +
> +struct udma_tpl {
> +	u8 levels;
> +	u32 start_idx[3];
> +};
> +
> +struct udma_dev {
> +	struct dma_device ddev;
> +	struct device *dev;
> +	void __iomem *mmrs[MMR_LAST];
> +	const struct udma_match_data *match_data;
> +	const struct udma_soc_data *soc_data;
> +
> +	struct udma_tpl bchan_tpl;
> +	struct udma_tpl tchan_tpl;
> +	struct udma_tpl rchan_tpl;
> +
> +	size_t desc_align; /* alignment to use for descriptors */
> +
> +	struct udma_tisci_rm tisci_rm;
> +
> +	struct k3_ringacc *ringacc;
> +
> +	struct work_struct purge_work;
> +	struct list_head desc_to_purge;
> +	spinlock_t lock;
> +
> +	struct udma_rx_flush rx_flush;
> +
> +	int bchan_cnt;
> +	int tchan_cnt;
> +	int echan_cnt;
> +	int rchan_cnt;
> +	int rflow_cnt;
> +	int tflow_cnt;
> +	unsigned long *bchan_map;
> +	unsigned long *tchan_map;
> +	unsigned long *rchan_map;
> +	unsigned long *rflow_gp_map;
> +	unsigned long *rflow_gp_map_allocated;
> +	unsigned long *rflow_in_use;
> +	unsigned long *tflow_map;
> +
> +	struct udma_bchan *bchans;
> +	struct udma_tchan *tchans;
> +	struct udma_rchan *rchans;
> +	struct udma_rflow *rflows;
> +
> +	struct udma_chan *channels;
> +	u32 psil_base;
> +	u32 atype;
> +	u32 asel;
> +};
> +
> +struct udma_desc {
> +	struct virt_dma_desc vd;
> +
> +	bool terminated;
> +
> +	enum dma_transfer_direction dir;
> +
> +	struct udma_static_tr static_tr;
> +	u32 residue;
> +
> +	unsigned int sglen;
> +	unsigned int desc_idx; /* Only used for cyclic in packet mode */
> +	unsigned int tr_idx;
> +
> +	u32 metadata_size;
> +	void *metadata; /* pointer to provided metadata buffer (EPIP, PSdata) */
> +
> +	unsigned int hwdesc_count;
> +	struct udma_hwdesc hwdesc[];
> +};
> +
> +enum udma_chan_state {
> +	UDMA_CHAN_IS_IDLE = 0, /* not active, no teardown is in progress */
> +	UDMA_CHAN_IS_ACTIVE, /* Normal operation */
> +	UDMA_CHAN_IS_TERMINATING, /* channel is being terminated */
> +};
> +
> +struct udma_tx_drain {
> +	struct delayed_work work;
> +	ktime_t tstamp;
> +	u32 residue;
> +};
> +
> +struct udma_chan_config {
> +	bool pkt_mode; /* TR or packet */
> +	bool needs_epib; /* EPIB is needed for the communication or not */
> +	u32 psd_size; /* size of Protocol Specific Data */
> +	u32 metadata_size; /* (needs_epib ? 16:0) + psd_size */
> +	u32 hdesc_size; /* Size of a packet descriptor in packet mode */
> +	bool notdpkt; /* Suppress sending TDC packet */
> +	int remote_thread_id;
> +	u32 atype;
> +	u32 asel;
> +	u32 src_thread;
> +	u32 dst_thread;
> +	enum psil_endpoint_type ep_type;
> +	bool enable_acc32;
> +	bool enable_burst;
> +	enum udma_tp_level channel_tpl; /* Channel Throughput Level */
> +
> +	u32 tr_trigger_type;
> +	unsigned long tx_flags;
> +
> +	/* PKDMA mapped channel */
> +	int mapped_channel_id;
> +	/* PKTDMA default tflow or rflow for mapped channel */
> +	int default_flow_id;
> +
> +	enum dma_transfer_direction dir;
> +};
> +
> +struct udma_chan {
> +	struct virt_dma_chan vc;
> +	struct dma_slave_config	cfg;
> +	struct udma_dev *ud;
> +	struct device *dma_dev;
> +	struct udma_desc *desc;
> +	struct udma_desc *terminated_desc;
> +	struct udma_static_tr static_tr;
> +	char *name;
> +
> +	struct udma_bchan *bchan;
> +	struct udma_tchan *tchan;
> +	struct udma_rchan *rchan;
> +	struct udma_rflow *rflow;
> +
> +	bool psil_paired;
> +
> +	int irq_num_ring;
> +	int irq_num_udma;
> +
> +	bool cyclic;
> +	bool paused;
> +
> +	enum udma_chan_state state;
> +	struct completion teardown_completed;
> +
> +	struct udma_tx_drain tx_drain;
> +
> +	/* Channel configuration parameters */
> +	struct udma_chan_config config;
> +	/* Channel configuration parameters (backup) */
> +	struct udma_chan_config backup_config;
> +
> +	/* dmapool for packet mode descriptors */
> +	bool use_dma_pool;
> +	struct dma_pool *hdesc_pool;
> +
> +	u32 id;
> +};
> +
>  /* Direct access to UDMA low lever resources for the glue layer */
>  int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
>  int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
> --
> 2.34.1
>

