Return-Path: <dmaengine+bounces-8850-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L7PGPUDimluFQAAu9opvQ
	(envelope-from <dmaengine+bounces-8850-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 16:57:41 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 820CF1123DC
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 16:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF7443004D92
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 15:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E5037FF7F;
	Mon,  9 Feb 2026 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ExN/q+oA"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA4D37FF60;
	Mon,  9 Feb 2026 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652654; cv=fail; b=ubGZwN/wMDZQ5prMfWSvdgwNdtnQh0WsAKgnij/QSpl067XL20Fzz1fu5D8+veeYEi+31y5mO0L1OWIyBpW+XFLWvY8sYpGf26qxaTjESTbnKcVwNUciYJHB3EHMoR6oEQ1FaKu3mrwBXYlYKxa6fJ1EYhAD+3Hodop5gM8meAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652654; c=relaxed/simple;
	bh=djVUquf9UXdKmMqH6tXRjLMhBAeA8ptndOwD00VffeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WM0JoGfjBw1LLAvUmUrTHHvK8sGfl9q1ZT9ahdTAO5ve11QyfK71wkB5HwIjT2skhYC564rIdAY1QZJLZvUIXT9lqYn0malrlx9rKfvMtmqK4DwmvOh0vfD2WndJQi8tI5BTUxOHTqyNRU2saXcuU/hl2GvYm3UqTScd1a1Onec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ExN/q+oA; arc=fail smtp.client-ip=52.101.69.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXuG6Cgw8hGEIxZ+/gEhUN2qwKCI3ZTIOO3iN31rl7ZpiAp5Ot1N2eBY2T+YROAKkPGc+DRVirz30kXHJhcBkcEPQzIdUnP7Z/jZPWrRuvyj1W+QZvyaDfEBJD4S6XFU2BAsOo8eMA+mue/pDQyWBtgMGScO9iSJDGByFAlflctzpPLbVsaUx0c5JR4Lw0n5JZRfYcBxp3gTFcMteSKjVT155m+XgJYzLcGOO0djml7ttDC9YZkZMhEGHPsfOH2WaqW3VillY6dcDRoSqvMZIFH+op0fuyiBynUzXazx2st376Rex4BY4p34CPOUheDAbcHy19JZQCjAUXyPFpolBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98qFw0aVBzEbPkVjJdrtKRZcDS9JE/YMWFwL1J6OcJE=;
 b=VnM+2/9P3HGXAs2TuT6SeJGlf2veoL6fFkUwZgjonNp1uBsLXI14u5bMIpWuDpbjgF1Ol78NzPlcl3oEQm2wR17mqI8s6ILC4vrjh7tJG8ZDXBYAz7On8ifPdU4ru8QVWA+cnE/fYllC1cN7zRLBTwdezzXoBXlj/8MEIVpX8WqgV7kbItzics4LEjqqFtv6HqB3U3KfQgQRLI5Y5jj/ejHigHYyGA0x5Y0bzNFGk+F7Pc6LJsCmby+d79Miv9tQIYYiJ1fdJtFaPxcOuL/zh8kXO9piES5sDDzuIuLoH5pt1PSNEl2BI4Bgkmg2/gP4yQ36CUZBZkolcDtZIc6dAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98qFw0aVBzEbPkVjJdrtKRZcDS9JE/YMWFwL1J6OcJE=;
 b=ExN/q+oA2IqzAZgO9DswsLZQZzwV8WN524u6762mSOyLO6YF5nu4RvmfCiWNxRgWW6eiTeQ3uZJRwbwCGmZSGIQssWuiFNDAIVuHXIcVtJI0uZmcBj1sPHPwzuph35a3l8xXw1S7jjW5+Lcqj7zfQW9BELbDsI5GsLsDhKrKinrWkFp5i26NPRVOO6FEeW0slPXb+G8mmyekBLsZ0obdJ66qqpkqsyI6fHl3n2vpGLr94lCbArsBu52IKeBa+TBIjdRgyk8WwIVK6Nq9XA3iDcqkMnUFGNTe27blhv4QxeK9AKFOLeUT1UeFlkRZaSzeIkrHRHw2Gc0P9Ivk8xWIWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV1PR04MB9516.eurprd04.prod.outlook.com (2603:10a6:150:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 15:57:27 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 15:57:27 +0000
Date: Mon, 9 Feb 2026 10:57:17 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, cassel@kernel.org,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, kishon@kernel.org,
	jdmason@kudzu.us, allenbh@gmail.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/8] PCI: endpoint: pci-epf-test: Don't free doorbell
 IRQ unless requested
Message-ID: <aYoD3V9X9H0sQpdY@lizhi-Precision-Tower-5810>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <20260209125316.2132589-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209125316.2132589-7-den@valinux.co.jp>
X-ClientProxiedBy: BYAPR11CA0090.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::31) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV1PR04MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6d16ca-6a75-4523-d227-08de67f3ec64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AhXkQJFmqg+eSeC4IzwOPeJojrGERvQUV5oaFaUsz25ZfS/Fy9dpUomm4ZCh?=
 =?us-ascii?Q?yiGbDv/FaSGmRojjw2pKGNzDPDIEj+LRWYGruIbge2rOKNRlkAnOnfflVkLi?=
 =?us-ascii?Q?QxoDOXjnsExnv4+GZu5iJQaAyBkrhlVYScZrjqPCJl43iWN/c32J8KXyLShv?=
 =?us-ascii?Q?upURkbRoL+bz735Da6BGZ1+2lr2xgD35tW6w4lzO0WIuCPKUun/NYiO31I/s?=
 =?us-ascii?Q?I7VSClPxfl/OZqeJV7i4Q/SIGsRaLaae7vmaMPH54S5ZquDJS8TI1Cg7SHcr?=
 =?us-ascii?Q?w5eH7y23t5XoEIbnKngoIDsgUdxCMc8aR1KZOEMSyK6GmpHVR6NgoNDjnvhm?=
 =?us-ascii?Q?RWoVUZwWuxynqiXlnIZ4kK45x5uaUHkP2zY9FVjMdV16WBvKY8aFpK/iqv/v?=
 =?us-ascii?Q?MAGU6CYHVBz0kcxjV5c+/62eRfPB7aafZ6LMpSPDWFe4DiIeflBCOdmbcxc8?=
 =?us-ascii?Q?hvER9cmtD96oNPflp/qZ7vGLi93OQvMrXMwnrcEUAO2mpiJg3JNIbb56oGoA?=
 =?us-ascii?Q?oeeJH4zoS0vDSXvgedxpnl9HrDjZG2I2904Co7+WFowdoCEmJ3j3Syb0tMX9?=
 =?us-ascii?Q?2MWylGoBS1eKt53ljJFZcHiOLBvHwayX51H78Ek0Y3RTc7ASwi+cOHF7oRHK?=
 =?us-ascii?Q?1zCrG92rGjyfmxoZrLyngRbTL3M/bAeP2Fbg32K5yKtKRE0acUvnxkDpXsaW?=
 =?us-ascii?Q?MLvml4oOZCH3GJM0dyuexWAPKF8DKGOnmUy20pE4P6C9ZhB2f229dYCSvxcC?=
 =?us-ascii?Q?WVyDNnqOl0nG+DAeLHUdtSFwuAld0MjmY2AaoljHBq4Qqn6QxxCF3CGuQzjF?=
 =?us-ascii?Q?Bf/dh7BZre1kkCXDXoLPaCO/uBeLPQ41buP639Te0Yuso9H4VdSKEc+7v12B?=
 =?us-ascii?Q?4BQjscAH71wNmdfGPrlFbyaqzJ2SqY5SAwZ7Xyb7m3+Ze73SqndayMN53gxk?=
 =?us-ascii?Q?LNVYf3Ms57ZHOHGEHB8sp2W4zSB8U0YlY5TcFZzTv2YvLZ1jq6bk/qrttYwa?=
 =?us-ascii?Q?L8H8M0Zbza2WDAZgGA2qa/eigXRS5AT9xJzJkbctCe4S/4a69UvtrSVKQAlL?=
 =?us-ascii?Q?LQnq0YXd7Hen0U4tgfE1+gaxmst6xRKNudn42YUwvaiIISOMLIl/W8esk8gU?=
 =?us-ascii?Q?kWhE/tlQ7GJ2/08uy2EixZhG6XIlFnmjeeyjvCS4GH4hSJUvBrg1UWxM8sAB?=
 =?us-ascii?Q?ISQHShzPn/k0OfKlk353kPStsgUGtjjoR4gha5LNnZvRYzMXgHNl5SUo3fsT?=
 =?us-ascii?Q?sZLlfTRQrWk2/mvQ243iwbSs7fOCIPdNHCCa5WEnqjAIE073BlV36uta9rsv?=
 =?us-ascii?Q?G0dm+a5lrcHJawA47HiXB/0b4F0JapaZjAlFmiHHNqspwDy2QRXvI2RTrzG9?=
 =?us-ascii?Q?LqngDgTXgAFFPxwRXmY9hM1pb33FOauiG/kaJW1Y7lTCqe8wLg3z+Hg9Cfkk?=
 =?us-ascii?Q?63akvJu1797qS7CQV6F4VzgoIAfb4BW845SCNuQbmgNQLPKYKoYMZBpgMF6R?=
 =?us-ascii?Q?kaVWpeCBsItdlxC85Vmv8Y0FuzGleFfg8CVZQNfXvLEittl5CiHsdSfVxd8R?=
 =?us-ascii?Q?5wI6V71jK/F+uKtzqyj+USQUNoFa17/Fthrn7nPQipXQbMY2A2X92VRTmrRp?=
 =?us-ascii?Q?QcM+5jf2ewWBDgUQdmSsP3s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?apOOg0/dv6ZMOjJYsCeAfzgO820ix2e88GxmROSoXHgTxE6CCXSnRFvtcR9n?=
 =?us-ascii?Q?AbypREFfZf3GUxaUJpIp+LU0AtIRA+uKSK/b1d0v+3R1n200jWaIc+L+MVDS?=
 =?us-ascii?Q?Ft106Hfg3Th7hNdAbdAuJGMomYCgW51B0QXHUiezrZfD3iL0DqLzFq/yY/iv?=
 =?us-ascii?Q?oNPA8Xl6YpFMnWIQIXxfxDdr4PothE6HEmuj80Ae4dQsXQy+/4hYTZpg48wr?=
 =?us-ascii?Q?8/dUKKqHoHeq+FmZE+09iTC7DxsjnDv1mr+gIEa/aQ3z4JGMAvt6srN+D/27?=
 =?us-ascii?Q?63PDN934lRjpWTvjkBmpgSZEuzU2csyUNiKKxp5ZYqlMH0xDSvwiq+H758Qi?=
 =?us-ascii?Q?rZiZmgGUDTaP+S6T1WHJo7j3lv6YQtnfcQlGkYxN/Nad+MrHvveD0oMJIBrd?=
 =?us-ascii?Q?MmQJ+OR6adbgFYam8d4VX0PlvFrkGOUKT+LML18DDySpKn4Z0qHAE/AmbZrr?=
 =?us-ascii?Q?hislusQQ7o4oLjV/lDiC7nCI8ocUU0bvKqHwJ/A3m6fiSNP8vJT0kXTZfL7h?=
 =?us-ascii?Q?pH2oy8k1ToD+LQmhbeBSXQdFmn4wS4uIJTx0LBIeUEq944T2UX9OemnzrHfA?=
 =?us-ascii?Q?igITILf2ayfRj007I8w/KSNQRLS4VCWhriouRbT5O81U/eRypmlxgyFsURsX?=
 =?us-ascii?Q?fNf8oiyb4W71Ntv7xEPAOpBmwZLcrYjnDE04Tn8OgNsb5CiE/YZtKcXmXLBt?=
 =?us-ascii?Q?IqkkHcyVNdqeDcU2zilL3iBn5kUDoSzgcQo3F/Se1SPR+ClJYpzDceu7sj2F?=
 =?us-ascii?Q?D3K3kWmjsH5MSpuTH3zm27lj1KSJicP/4rLcGE48ykMpqTpo3kG1LW/g9WXF?=
 =?us-ascii?Q?xShNkLkkLbFnUFGW14vvzSB4mNdSLFiY8rSfFPxr0eixKDN8tppK25dIDy5z?=
 =?us-ascii?Q?1RKW6lMRsTff3AUF7CkAP0yhUOohrqYdgBMddOzJx7ZVDkALhmQDvovfBTOp?=
 =?us-ascii?Q?4R2ejdLQOGm0ZNpgItM6RC8U5bWjD/V/l/BsbmkAEP9yBHOozCCSMUWcO8Fu?=
 =?us-ascii?Q?4OjqPthQ6gT1dyk3QXJNsXfo/rPC4R3Saf2JQz0XdMAV7E1G6ANGWLTHDMV9?=
 =?us-ascii?Q?AfajVHnbRkAw6X2fd0UzmtmuZNO2qCyhfqfezdhi2kDzrUlUeUIpsWxeFKrg?=
 =?us-ascii?Q?FDCnNG6gvzgM/MshHS6Cx/kRssNNu9Js6d+bj+xTtsA1pixnilGwc/MsBW+l?=
 =?us-ascii?Q?QJ+4T0na4XXrtvU5L/QR4Tq0PjwkE7nPKLbtRGiamo+CoxNOJwGFdbKtVQ9u?=
 =?us-ascii?Q?Tl8teZzZwIb+3YrfB6laYRRAVdb/fqeAoswXTbsSkUP0eAPmm7OYoeAT/d/1?=
 =?us-ascii?Q?TGRbTkSONTbBqB91PSmbOKKu48K2iox0Dx9F5bFvh2/8Iv40fuUiCMSyO7SZ?=
 =?us-ascii?Q?O14wF62gkPDT+uON3T8/QHpsVxlO1241Sf4r0ZndJO69zsfgwyicwVpk0Rjl?=
 =?us-ascii?Q?6mkPaj+kaQ01ilUjRPNA7Qzb+COcRaDB3IZ2u3T2TboW+1yZJcG2JRp8NhRh?=
 =?us-ascii?Q?jmAKFrVxD+a9X6lqhnfAGR5a5jXdfMSG1Vyg2vzjmEpX3/73Ff/LkUuT32NF?=
 =?us-ascii?Q?Kj1EP317eIYoJGOHC16OUlvjuCts4urvnyN1QCmRHRW8kotIFRB0K103LgQJ?=
 =?us-ascii?Q?xzmYN+DxRrKb+Frmwkqj43mjeJdXCpBQ+iFL0t5RdqSBk3bJwlcAHYt7m/Tt?=
 =?us-ascii?Q?5fAv0/zdLckB91CBraRaV6qwWVaWz9BTE5gDmf07ffqBzE/I?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6d16ca-6a75-4523-d227-08de67f3ec64
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 15:57:27.6138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltrrs0C3ELpZJTeJkxLpcDruXjiPPwuy+PVawI1ea1JJEmxOoEwC7Aw1B+prt1dv3xNLvYkt27c7N7HmAOkm7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9516
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8850-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,kudzu.us,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 820CF1123DC
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 09:53:14PM +0900, Koichiro Den wrote:
> pci_epf_test_enable_doorbell() allocates a doorbell and then installs
> the interrupt handler with request_threaded_irq(). On failures before
> the IRQ is successfully requested (e.g. no free BAR,
> request_threaded_irq() failure), the error path jumps to
> err_doorbell_cleanup and calls pci_epf_test_doorbell_cleanup().
>
> pci_epf_test_doorbell_cleanup() unconditionally calls free_irq() for the
> doorbell virq, which can trigger "Trying to free already-free IRQ"
> warnings when the IRQ was never requested.
>
> Track whether the doorbell IRQ has been successfully requested and only
> call free_irq() when it has.
>
> Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 6952ee418622..23034f548c90 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -86,6 +86,7 @@ struct pci_epf_test {
>  	bool			dma_private;
>  	const struct pci_epc_features *epc_features;
>  	struct pci_epf_bar	db_bar;
> +	bool			db_irq_requested;

Prevous patch clean up epf->num_db = 0 at doorbell_free(). can you check
epf->num_db ?

Frank

>  	size_t			bar_size[PCI_STD_NUM_BARS];
>  };
>
> @@ -715,7 +716,10 @@ static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
>  	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
>  	struct pci_epf *epf = epf_test->epf;
>
> -	free_irq(epf->db_msg[0].virq, epf_test);
> +	if (epf_test->db_irq_requested && epf->db_msg) {
> +		free_irq(epf->db_msg[0].virq, epf_test);
> +		epf_test->db_irq_requested = false;
> +	}
>  	reg->doorbell_bar = cpu_to_le32(NO_BAR);
>
>  	pci_epf_free_doorbell(epf);
> @@ -741,6 +745,8 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  	if (bar < BAR_0)
>  		goto err_doorbell_cleanup;
>
> +	epf_test->db_irq_requested = false;
> +
>  	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
>  				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
>  				   "pci-ep-test-doorbell", epf_test);
> @@ -751,6 +757,7 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  		goto err_doorbell_cleanup;
>  	}
>
> +	epf_test->db_irq_requested = true;
>  	reg->doorbell_data = cpu_to_le32(msg->data);
>  	reg->doorbell_bar = cpu_to_le32(bar);
>
> --
> 2.51.0
>

