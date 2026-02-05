Return-Path: <dmaengine+bounces-8763-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGexLYDAhGnG4wMAu9opvQ
	(envelope-from <dmaengine+bounces-8763-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 17:08:32 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31709F4FB6
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 17:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB0C2302C666
	for <lists+dmaengine@lfdr.de>; Thu,  5 Feb 2026 16:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF97839E6D9;
	Thu,  5 Feb 2026 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TmTLyaJJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013062.outbound.protection.outlook.com [40.107.159.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3938E39FD4;
	Thu,  5 Feb 2026 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307675; cv=fail; b=tXoOXw7kPVq8njgMU4Dry5tMWnQdUHTTyTXvhEYDsuDROGQcQN+IfhguS+Eq13jD2tmVpZgmiEW9ntvk8SLag/y9BnMZ0EkyIgscehaBaEqepYQcKT4ffasthqpsHXpUKNHe3jWsA9XsHc/m/Kh2k2UOiALVHEbPePwr1aCI8lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307675; c=relaxed/simple;
	bh=je3DIfwdgN7AT1TtzgZI0lXJl/MnwcIJuSNKaGB44A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zd2VNJC3X6eRST8n99+RoMIftfuxet55AWI3n+s2p9oXCQISdpn73k5Y8tDKGFar3/rgfzkqQIh24T83xYC4G6Ia8cJ5Kzebt0dm3rXBCMox03vmJLfzFaa4NtMh6NuZFgUPqMgSskXDuMkYyWhKGKGsyfIUWy0jBu5uUjcyrx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TmTLyaJJ; arc=fail smtp.client-ip=40.107.159.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSa/NF9vZJTncw+V1aB/RXfndq6d7XxGgg1NKmsk1tJoKOSs+QZ1/qvTQM05N9q8aIk8s3mdtpM7ezo5xnPURA4lOyqcxsgUUQumcrzBWQ/BkBSlY8qV+uJL84NxT5Z3mbTPNZpOrV8bzxz62QkCNNLrR5MPAYQqbPlOnIFXULtCqgrwnFfKC6WfPVCmBW66MoOJs9CyQ04jfLvra8MIcNC1KaC/smTRljoRfUKEJ7xkHllrj5IBhyQTsQgqFWBLar3STtbdxy1TGwtHpaBPxkzbPxFS2DoUWJOJfZfRWoAKQFVR5gPnSaeM91jcIVgJpzGATHBxvbgf1tdnBvEANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5o7pt7b7+z71faZ4Mb4XaYvwea4byQcy/AGkvHr1Er0=;
 b=fU2h+jghG9MLDXWZbupuWZVveklPz6oz7FQCO9fOkbESgf3vKu/NCV7767ai04cOvQ4Sqfe2S6Daku7ZUebKW4XeL7v+2RSHmQiqIZOV6zZprAGNrVeeLXhnzOtNwvrqhgE1nCXHFLpbon/OLZlHNHbUXw0yxoQos6YKCeVjm3tZ4HwwRkuz++PnVvk4pqhyXegkE9N7q6iHfT2RvO59wlNtcGmNG0xrNUKRmEm5ot+MlqpizOwphwomoqvIv/YA7IkrLUZY3Qp+xKlkado/Nt8t7N8rdPiB/A1q7YXXbqaGCVKwRfDzk5lxDzWXpP3raeB1bPEo7qBpec+ateRu6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5o7pt7b7+z71faZ4Mb4XaYvwea4byQcy/AGkvHr1Er0=;
 b=TmTLyaJJhv+QoZRyZOGCHTx3gvcfigtKvgpdierbsK7uBRlVXUtebsBFOT9kJrNd7DIxQdHK9CZyJFVoMrMLJJBx0fEW/Zmmq4dhASIi9gxij5jk3qE6aX6o6qiVfrlZ37+fkMhhDxiyOpR/zYMs/ZAoNupqhZCUkhsaJBAeVVAs2LwZy/Ijf1n1g0qAHg4cSZlFdDUEa3Zixvd893RBCmdHDqejOrYb+gC5s8NL+qgvDNjXdg2M/meJoa9tfxAEdZEbEABd5iihYa8UVimgZQ9TQuIryI28qwbd4DBlHUs+FX0yBDH7tOqS6132rvBQUbGkJZJXXJhTLNfS/qTgxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DBBPR04MB7769.eurprd04.prod.outlook.com (2603:10a6:10:1e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 16:07:52 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 16:07:51 +0000
Date: Thu, 5 Feb 2026 11:07:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/11] dmaengine: Add selfirq callback registration API
Message-ID: <aYTAUFT3LstnaHey@lizhi-Precision-Tower-5810>
References: <20260204145440.950609-1-den@valinux.co.jp>
 <20260204145440.950609-5-den@valinux.co.jp>
 <aYOF_JNYZF9IFUCr@lizhi-Precision-Tower-5810>
 <p4ommmpcjegvb4lafzecf67tzmdodtuqexeoifcn5eh7xqyp2y@ss76d3ubbsw7>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p4ommmpcjegvb4lafzecf67tzmdodtuqexeoifcn5eh7xqyp2y@ss76d3ubbsw7>
X-ClientProxiedBy: PH1PEPF00013313.namprd07.prod.outlook.com
 (2603:10b6:518:1::4) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DBBPR04MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 08131457-7969-49aa-8978-08de64d0b6e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cR9ODn+xFbJ8a1Ukgb1tNl7FAou7JN4ayBvn93pTIseFONAX6UkVBRQsnqJe?=
 =?us-ascii?Q?ectez1vEDsncXdV6mMzEi+vPYkrwaga4KVYB9bp1+mk0myXjl+VyQxUJRU/I?=
 =?us-ascii?Q?4M9hMlM2Ggo1PGEOtk+AcAysivYxO7Ug6j9bOAw3cIwd0ndy5NqB3Z/kbTem?=
 =?us-ascii?Q?jYrCyX8T8Ngf7qYppKPIPSaVYFb6tRIm/oapKhjDh2t9mpeS0qclwESh//As?=
 =?us-ascii?Q?Nb7NBH+k+/ab9TBNQeUb59bq0nQQMsL3pbb1r6Y1++RbtNHOtKEAS9V1gC8+?=
 =?us-ascii?Q?TKw+jmk+D6pBwUPP5FMnak7PgIcKNIQlWD9nsVDQDFNlR60ZSdyQ/oO9feV3?=
 =?us-ascii?Q?BSKdKKUZM2A0OZIMzKkI2oUawwO71tWyPcSIDfeCjvHwaJX8h9PLdGlG0gN1?=
 =?us-ascii?Q?3qxNUyhrASWk6Jic52dDUPV99E0DxymjC6Ee3gObxMIvtvUKVGava/AmP45q?=
 =?us-ascii?Q?B6YB5+37UN6bPa6Hum8Fc4jE9uMNnJw1d5CJKosUZYSxtz8WSjuSzofqhbdv?=
 =?us-ascii?Q?tzuAHxRAPl2QJN+S/PHFYFx986tICGclR4L9HK01xqESC6+Uq6PUjul9vrTj?=
 =?us-ascii?Q?BHYnWc7ggjN65/+xvpxTQnODWgXtJuf+vZntISX+wnbBI2lbuyb7cAiUj/LA?=
 =?us-ascii?Q?NLHgYUZcOjYNQloB/SpBW+hkq/sqpzZr4IfYHYLqg3XTOrkNFy88WWC2AjbA?=
 =?us-ascii?Q?yQwsRaNyC/9eSJafje40Q5PhSdHI+wJT8eo8C1QSD+/m8e7sl3TZVdIlV4/o?=
 =?us-ascii?Q?2XoAfAwloOOvt6jpp88XFMQec2xY/UQDY6lBKq0nlCG9Sl+HZ/mzzT2EHJwe?=
 =?us-ascii?Q?zPPxEkxRNKP0+wGUiRNwF1oc+sORyC/jjTFGo+6RDpMDcgMtSQbAiIe/d3Ei?=
 =?us-ascii?Q?zf/JN8d6NqmxCShFjnl1cv0A5Cv7WpUqE0LkoLSBKCNZ35bGsvZm68k6ZTjT?=
 =?us-ascii?Q?KXYRXOzO9S9b0tX8xhoBOap550RT1op0+8Ao+I8gB3/Rukhw3ZGlBC6Vsi/B?=
 =?us-ascii?Q?BoIyZj22O2g87kqHnt9+9AIXgwvivVAH/yeTok7vDw/bQkmbbEtye96/iT+H?=
 =?us-ascii?Q?KAab5k4bzykd7bAuNjA04viTk2LC/jHB/lcH8wAYsxDUCNcaJ3XZe/NtX9xD?=
 =?us-ascii?Q?VrZZsWXQcvhX2n/RKMXXUo80LtIDTQTR2pHXmpcehGjbZzBCk3d5B8LY9URx?=
 =?us-ascii?Q?vUu/VHOolVJSmVV+Gi+OJnCJdsvf1fm1cNWjy4iwDdceCeYsXv3jOE5CkBZm?=
 =?us-ascii?Q?/NKGyF6J30iR29I2IWwd4an81BqJpDMFuEu3hMSNNtEnicmMmU9LEGJvY/mP?=
 =?us-ascii?Q?sh3DJvkIYbkG0JmJIHzo8mmCEMhc6wNyjIbBVJaWr76XgWiccbrcVvfuaNTP?=
 =?us-ascii?Q?aed1Pys3noN/TK8WBobvAf81xvmWPZiKx2U7wAuN80sMEpWGmH6asuvAx46o?=
 =?us-ascii?Q?pCmjVSXBFXQrqfL2orMIpqTM6OlzGDHHTKSOpIS5Mlype4RPZylWasnHAvEr?=
 =?us-ascii?Q?12/wtL7BWFWL7dxlnA8axsCymyIpus1ZG518EKqTDG/w5a9JDPPJGbCyYc4P?=
 =?us-ascii?Q?RPO+ILcU00HRtYv6F3iM0dKdnQoJaTLzQ/tdjTQe2GU7Yh8p9K/MKAUEUDz/?=
 =?us-ascii?Q?z6cAtkRyuT193TTWiHstEG0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MskyzmU3BWrehYoo8RaT4ZYem51RUsSih5nHPZC/Mj4nm0LfVx3ABRfVrsqn?=
 =?us-ascii?Q?2JN4elNCwrcP9ba3UiYhI/rHxxst0Je0/Itv42iMncJcarYIakmmWGxYuRo0?=
 =?us-ascii?Q?sJqp9ZbRrUjLe4f+ZjnnzIzbUQnIE70yjI1uwWYkd+H1RpjwnuWwhUKSEw8o?=
 =?us-ascii?Q?xdHDK83JQxu4rU45619UXgMU7FsO0V3PG5qyN/dwqFO5xYQDnnCdOmc/E9fM?=
 =?us-ascii?Q?mEQKHa5t88vTQCmk1kxqWMiXmn+ddeZiXp1Y6ER8Kh8Gpu7BofJt/n9XSjR3?=
 =?us-ascii?Q?+f4Az25FergQqIwO76+u4FwAdXYFHZ/s7nu9+QFF206upqkafpovutFybar5?=
 =?us-ascii?Q?ZbyzJ2ROjBnWdHf8z9NW2m1EBIIt5iyOFkxmiZbvIViKDu4OZyFHbfr9UMiC?=
 =?us-ascii?Q?8Rdjy3qtKav7RImaKaNHdD1Db1exmEBdrCiBhVB8g5Frh/3HmYUjZa9cDE5+?=
 =?us-ascii?Q?J80ElzTMYqAWgLS8aror4amdzoN2BR+7g8zKzf13r0kBWLpnXIlpPNFQuGTw?=
 =?us-ascii?Q?ohX9qUMLdNsVgibLBduSulFEscNALn0eDH2Mpz/GM4zVl/u+j0kohvmAuWo1?=
 =?us-ascii?Q?ZNC/8EroQf9EF2ZRy3ZtXKwibuCuwqMKqtEkprLwa7m1kd08x0JlYRWnsfpe?=
 =?us-ascii?Q?ZOFYPHuIPxe44Vk8XdpRxTioPbXR/jhQ+x2xOh77kc26+etXy+bddvV7i/ai?=
 =?us-ascii?Q?pmNlSC0ytseMwJjkrK4M6JCDOUfBYOMGk8MVjWbwgg8qeJ6iOZU6Tgsd0LQB?=
 =?us-ascii?Q?VYqveGuKQ4Ue5zixvprn8TjXmQTo+eLzMNoI+/JrgicWG7jMd0VjsrT4du+v?=
 =?us-ascii?Q?m2XUgTr6slcQKPu2iHwMj1JayRBXV0MuuLHzkCuMWYC2Eol+RtRUD+4eUCbI?=
 =?us-ascii?Q?oZB6RlZqhWgi6anuBpv6FtEX+OBYVEJOw+IFEyc5Jlr2k5JI1iGFlntxB9EJ?=
 =?us-ascii?Q?wAbzD3jvOU71OB4UGR0U0jPx2HBAZ61b5xX9MXSf/tXJJoDK/KAv7BJJcb4/?=
 =?us-ascii?Q?DZb99NiaxbWFmDcFUbdBZN04zvNfSdw6Fr4Goxy7zZlApJRPFYMhILrehma9?=
 =?us-ascii?Q?kviZ90gVFhNmZvaXXQIzFuwGfRtLXdDfMjsUSdXUgbmKdohpwJ2MCqzijPW0?=
 =?us-ascii?Q?UIfrlAnP+ZgFcnWZ/p2Nk+hXByuWCNbS6V305F1JQ/MFjPOxtXvo+xyAfnid?=
 =?us-ascii?Q?X/X4B9By/CUgkMZLZm6IeAg2I3k/CYVGH/7H7ZxbhnC4e3qLEZ/dKafhS8TN?=
 =?us-ascii?Q?ziYQTRixh9J1+qKEAW+/fF8iI3y4URj2JIVIhUsW20gmWbgD6eBnShJjE1Pa?=
 =?us-ascii?Q?OPSbvQ80RtgkR3k8rrvG9k2Igb4StPs6PbYJMIwdISiA+o80uZL6DugxZYg6?=
 =?us-ascii?Q?Cr9aj0OL1AKrbyq9hAJHhjSZPPcMt554ZDjPI9luZj6xmxVADi3zZa8uTFi7?=
 =?us-ascii?Q?UEsAPe4u8VbajuRxxwBVj6HRivQ90lHmD1OeBNzwGIcu5+DvIk/NMaxokA/5?=
 =?us-ascii?Q?iPXkolQsBxBppQIlaeUkw2J89tzjRzqdE1Uxbg9OYYhPEBsUFSdu5OT6fzot?=
 =?us-ascii?Q?tsbF5mMbfB5XEKjHXTP9MbIaEbzqamFmA7ahGQUN4emhOuj7ZCFbG/Fx53iU?=
 =?us-ascii?Q?Rs93P0jrf1A6ecGiIFEqn+4Wo/fTATFEXVOpN6qn+m7ZtkdYI+xoh+ZuVeiX?=
 =?us-ascii?Q?HBVNOn5PX1DTYxhdfQs3TDdR1WOdg21WYvdyIYxNPDxDLtYHYb6KpHdAUcSs?=
 =?us-ascii?Q?IqPhlDW/HA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08131457-7969-49aa-8978-08de64d0b6e5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:07:51.8721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQCdqultOitwH0bCbwTvLyVaSyRZGpuGZzpbc0ME8DDEwwPRrwJlUf8UeR4OQxb3qSPeYou9QibVNQWY6byuLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7769
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8763-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 31709F4FB6
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 03:50:59PM +0900, Koichiro Den wrote:
> On Wed, Feb 04, 2026 at 12:46:36PM -0500, Frank Li wrote:
> > On Wed, Feb 04, 2026 at 11:54:32PM +0900, Koichiro Den wrote:
> > > Some DMA controllers can generate an interrupt by software writing to a
> > > register, without updating the normal interrupt status bits. This can be
> > > used as a doorbell mechanism when the DMA engine is remotely programmed,
> > > or for self-tests.
> > >
> > > Add an optional per-DMA-device API to register/unregister callbacks for
> > > such "selfirq" events. Providers may invoke these callbacks from their
> > > interrupt handler when they detect an emulated interrupt.
> > >
> > > Callbacks are invoked in hardirq context and must not sleep.
> >
> > Is it possible register shared irq handle with the same channel's irq
> > number?
>
> The proposed dmaengine_{register,unregister}_selfirq() APIs are device-wide
> (i.e. not per channel), so I'm not sure which "channel" you refer to here.
> Also, when chip->nr_irqs > 1 on EP, dw-edma distributes channels across
> multiple IRQ vectors, and it's unclear (at least to me) which IRQ vector
> the emulated interrupt ("fake irq") is expected to be delivered on.
>
> That said, technically, yes I agree adding another handler should be
> possible, as dw-edma currently requests its irq(s) with IRQF_SHARED.
> However, for a consumer driver to do request_irq() on its own, I think it
> would need a stable way to obtain the irq number. Today that mapping seems
> platform-specific and hidden behind dw_edma_plat_ops->irq_vector().

next patch, you add API to get resource, irq number should be one type of
resource.

Frank

>
> Would you prefer exposing a helper for obtaining the irq number (or
> exporting the mapping in some form) instead of adding the dmaengine selfirq
> API, or did you have another approach in mind?
>
> Thanks for the review,
> Koichiro
>
> >
> > Frank
> >
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  include/linux/dmaengine.h | 70 +++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 70 insertions(+)
> > >
> > > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > > index 71bc2674567f..9c6194e8bfe1 100644
> > > --- a/include/linux/dmaengine.h
> > > +++ b/include/linux/dmaengine.h
> > > @@ -785,6 +785,17 @@ struct dma_filter {
> > >  	const struct dma_slave_map *map;
> > >  };
> > >
> > > +/**
> > > + * dma_selfirq_fn - callback for emulated/self IRQ events
> > > + * @dev: DMA device invoking the callback
> > > + * @data: opaque pointer provided at registration time
> > > + *
> > > + * Providers may invoke this callback from their interrupt handler when an
> > > + * emulated interrupt ("selfirq") might have occurred. The callback runs in
> > > + * hardirq context and must not sleep.
> > > + */
> > > +typedef void (*dma_selfirq_fn)(struct dma_device *dev, void *data);
> > > +
> > >  /**
> > >   * struct dma_device - info on the entity supplying DMA services
> > >   * @ref: reference is taken and put every time a channel is allocated or freed
> > > @@ -853,6 +864,10 @@ struct dma_filter {
> > >   *	or an error code
> > >   * @device_synchronize: Synchronizes the termination of a transfers to the
> > >   *  current context.
> > > + * @device_register_selfirq: optional callback registration for
> > > + *	emulated/self IRQ events
> > > + * @device_unregister_selfirq: unregister previously registered selfirq
> > > + *	callback
> > >   * @device_tx_status: poll for transaction completion, the optional
> > >   *	txstate parameter can be supplied with a pointer to get a
> > >   *	struct with auxiliary transfer status information, otherwise the call
> > > @@ -951,6 +966,11 @@ struct dma_device {
> > >  	int (*device_terminate_all)(struct dma_chan *chan);
> > >  	void (*device_synchronize)(struct dma_chan *chan);
> > >
> > > +	int (*device_register_selfirq)(struct dma_device *dev,
> > > +				       dma_selfirq_fn fn, void *data);
> > > +	void (*device_unregister_selfirq)(struct dma_device *dev,
> > > +					  dma_selfirq_fn fn, void *data);
> > > +
> > >  	enum dma_status (*device_tx_status)(struct dma_chan *chan,
> > >  					    dma_cookie_t cookie,
> > >  					    struct dma_tx_state *txstate);
> > > @@ -1197,6 +1217,56 @@ static inline void dmaengine_synchronize(struct dma_chan *chan)
> > >  		chan->device->device_synchronize(chan);
> > >  }
> > >
> > > +/**
> > > + * dmaengine_register_selfirq() - Register a callback for emulated/self IRQ
> > > + *                                events
> > > + * @dev: DMA device
> > > + * @fn: callback invoked from the provider's IRQ handler
> > > + * @data: opaque callback data
> > > + *
> > > + * Some DMA controllers can raise an interrupt by software writing to a
> > > + * register without updating normal status bits. Providers may call
> > > + * registered callbacks from their interrupt handler when such events may
> > > + * have occurred.
> > > + * Callbacks are invoked in hardirq context and must not sleep.
> > > + *
> > > + * Return: 0 on success, -EOPNOTSUPP if unsupported, -EINVAL on bad args,
> > > + * or provider-specific -errno.
> > > + */
> > > +static inline int dmaengine_register_selfirq(struct dma_device *dev,
> > > +					     dma_selfirq_fn fn, void *data)
> > > +{
> > > +	if (!dev || !fn)
> > > +		return -EINVAL;
> > > +	if (!dev->device_register_selfirq)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	return dev->device_register_selfirq(dev, fn, data);
> > > +}
> > > +
> > > +/**
> > > + * dmaengine_unregister_selfirq() - Unregister a previously registered
> > > + *                                  selfirq callback
> > > + * @dev: DMA device
> > > + * @fn: callback pointer used at registration time
> > > + * @data: opaque pointer used at registration time
> > > + *
> > > + * Unregister a callback previously registered via
> > > + * dmaengine_register_selfirq(). Providers may synchronize against
> > > + * in-flight callbacks, therefore this function may sleep and must not be
> > > + * called from atomic context.
> > > + */
> > > +static inline void dmaengine_unregister_selfirq(struct dma_device *dev,
> > > +						dma_selfirq_fn fn, void *data)
> > > +{
> > > +	if (!dev || !fn)
> > > +		return;
> > > +	if (!dev->device_unregister_selfirq)
> > > +		return;
> > > +
> > > +	dev->device_unregister_selfirq(dev, fn, data);
> > > +}
> > > +
> > >  /**
> > >   * dmaengine_terminate_sync() - Terminate all active DMA transfers
> > >   * @chan: The channel for which to terminate the transfers
> > > --
> > > 2.51.0
> > >

