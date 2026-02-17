Return-Path: <dmaengine+bounces-8936-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO9LGkPHlGnCHgIAu9opvQ
	(envelope-from <dmaengine+bounces-8936-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 20:53:39 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A77E414FC16
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 20:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14435302D53C
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 19:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DE83783C8;
	Tue, 17 Feb 2026 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CRVux/dT"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96CE374738;
	Tue, 17 Feb 2026 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771358016; cv=fail; b=AY170e+D9HK32rxhRuRYRR7YTSITRAswfSACNu6Pn05YfUyJqmJeM/zI8LB6uQnlFKT9C1hsbeXI26eXVOAtwJspKQYrfM5T/pWCbxj8zyKwNzr2czmgP/0+fGYYcMwGTJwBearOPFxn1eo8WOlu7u/CfAulzgicmC0wqZDNtAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771358016; c=relaxed/simple;
	bh=ybIXWnAESo3U4asX8YgrV/sLgvHYXU9GlRHCw/5739k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hUJEkhAjWSN/b+ej+F/fTJAeOwgCz9G32MW6+abyLbq+5Q14UWMaWQoDN6yOwi1F+ChUyC46IDZRJfTNTAlnNShP3q/CVTnGY9Z6S7twecpf3GLgky3U5fw8PZ1pWk1CXU/FO8D39M5MeGIh1ytd1SmL3hWTI+P+FgCR0ZP6WFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CRVux/dT; arc=fail smtp.client-ip=52.101.69.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpBDRCJwEqxCsArY0rekoDdwVbp4YBDk/wjKrziadQhw+YhIdGd7czY13bazFuamR2zKN0m0dE3w18l/UDiDgUlJEpUUW9BFTUNd6oNOed+wqtHhGSReecxgNcOLfwS7dQFPd8L39PdPs1n3iPhQvNreVoAnQDBGRflkdUHvthbjA71X3cUJXxSFlS4vjJFK/0A3SBnBxicKQfuVmpoMgG/0uaCROC0jtXnIizVqW1eDkQVt2pUN3HLGNYOkkKr1pF9J3mBop8eeo6ECqybh8KXI5jS2sofJ5oM6ijTiV6YaBkUTN0hF25rve7YNBKkhbDMEvb4QtvLjs/PjoS620Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aequ2hcRO9KKsmmodJpPlHiElvAgTFEHyr4x8Faiw78=;
 b=ubtj7hDH62U9DQSWbn9darQpXzOmeLYnX9eO4fudTZhQCswnWx3vveAJP4ZOzpDwo307EGiHjPPNDu45HDybKDzqnZQagL5uiUO7PPaV0PHLp2ox+5zXtXJSCTHpT+RrKCIRfM+Feod0/EulVw07VjQhEOlQVgHvU6SiM7rdcYZT5YOZdB2QQ+wG/zAodvBfJt0b9ZdR8s6cFa49mn0ANQD4M9ObI5khmhXw2+Gb5BHmXjrz0NZSTCJOvEirR8Qx0fAmnUa4QUIYsSo5MeaEVaxMSGuKD+FUO4oqTz5AnBJ1xipP6zJSg+ZV5oW/uIg9Xsjiq2OFSuaqY1Eb3m3EGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aequ2hcRO9KKsmmodJpPlHiElvAgTFEHyr4x8Faiw78=;
 b=CRVux/dTjgKZBQQTI+20nWb7BwXxW89KWczIEooqvq6K1kKpu9n3GHqOt4TZIVjInLv/cbCSwEiP+h3hukMbA0MNp5+Ls5YP2x+MnUU0reFJSIg/Tc02hqE//wW2CubmfEiVOd2QYEyZvUMp4LKVpSBT3Bj7t48qw1sQbUKUtboMenG1muxiLLupaTEmebM3dVP6SU8NaJCH+w+ZkDHCSlMB9zkT2oR7nOxSOxU2CuLXI/t/UJGwZYWkCuLguQjzZE1PvMUSAswf+KJGc6s8/V3wbAnIXviNrjX6SBLOHIK/OnjhnZ40HOc38LRzdmYnSs0Tbrz7h0hT81aqbxUulQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI1PR04MB9931.eurprd04.prod.outlook.com (2603:10a6:800:1d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 19:53:31 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 19:53:31 +0000
Date: Tue, 17 Feb 2026 14:53:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	vkoul@kernel.org, Frank.Li@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, p.zabel@pengutronix.de
Subject: Re: [PATCH 7/8] dmaengine: tegra: Add Tegra264 support
Message-ID: <aZTHNHrX368YG2lH@lizhi-Precision-Tower-5810>
References: <20260217173457.18628-1-akhilrajeev@nvidia.com>
 <20260217173457.18628-8-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217173457.18628-8-akhilrajeev@nvidia.com>
X-ClientProxiedBy: PH7PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:510:339::26) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI1PR04MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cff7c36-d066-45c5-4874-08de6e5e3a0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?llhTIXvSdZ4CxQL40OeVPtvcn5aK0kxRPgIBTpP/UElaKnIg1vzKpYjDViQO?=
 =?us-ascii?Q?HQbwjrvu8NyvI1p3Ue4ZKm4I8uZKpu4KEjkFSac4/JF1lsTG0osTwhEn4p0x?=
 =?us-ascii?Q?MYJF2+GhVW9uotxq3dW5zusSZjAaQ0+mljn5PXZbPpWoP0EUe9zc1v97iRmh?=
 =?us-ascii?Q?T2Sege3XLAWwUuqvbsBLAbYmVn3A4td4/iCgboy5gvvuKR1pvZ02NydIcdil?=
 =?us-ascii?Q?IMut/7MTRXfLbzxU9jN3Wv18idFzlysGfNPfTu97bT850oCkc2opmd8vrnXf?=
 =?us-ascii?Q?Ias+86SetlauBDMjS6fUfGoknjUU4j2RWQ5m8oORTAoBkwXJhAHAXU362qjr?=
 =?us-ascii?Q?rluE8s5WqLkjDQjEF/A4eONtaVZSAHTWE/xnHgtzpmuhLg2MnJ7iOnkxn6ad?=
 =?us-ascii?Q?k+Rw/a9wnOODKFgOpqUPp32ej2SruCGPPK9Ln5D8TgRoJwcvkQK4SqLN7rCO?=
 =?us-ascii?Q?5qPPV3M8lVNNqKFDde/gyCkVvOv67Vss0w42g2Ge0goKumwDQ3/vySpkkAC2?=
 =?us-ascii?Q?/ecVawCCnUyE+HsX02TWIJIRnaFUz4CXl8FS/fHGEl6kBtiFIhUKm/CKCGc/?=
 =?us-ascii?Q?5o6048DpQo1h9Wau09EHTH3wyiiL2LMzhw6z0yv+YSMvWkIDw+//lJvZamT5?=
 =?us-ascii?Q?bQBbV+hsewwLEYMKtZicpaeLfbFusLZsNH6HwDCOeZIpjR1O2X4dNu3SCgmX?=
 =?us-ascii?Q?ldTCa4kQ+kjgJLnAv5bgTPINzHsosUlKOm2hBTylvJlH7gBBVP9DdKpoPtK0?=
 =?us-ascii?Q?25wXeAhCZXhYLSKqg4VApR9uz2NM/AyeFipLsRv1YhoKGPybDOyLu1vaQZ5X?=
 =?us-ascii?Q?evxp3vsaiA/5tK49dPbewUY1mGRO5t2XLZutyCPr4oipF7j/QNFp2Ea7J4lh?=
 =?us-ascii?Q?9hwkqigSn4PCDc8T+F1genkO5GledtI05Q2acdJAXYBPqF8cvMUjjwZAZ6YN?=
 =?us-ascii?Q?pTV4DqRBefOhZ8y3zVSH1XQ5ZwrdF9ZhZ/jTKCKDifqFxq4KKBgsKfAt4eqp?=
 =?us-ascii?Q?iJAxYjxexHC5ZdXqnkJCe85qzb0i56EvHNdbvYdh3RrTofCR9xu+YJ9EZHYh?=
 =?us-ascii?Q?EyOmqw5Wt12dIZRE6HM2HAU7l7b+zfmNXiqwew3CNgMfQtyjVXYKQNIoO+SF?=
 =?us-ascii?Q?q8RiHKYGimu8ZYisnkL0ofzIHZVzroYTpsaKY0xTEdzzvUAOKhkfwqmIMIaz?=
 =?us-ascii?Q?eSLSGwRSiW+nFJ2l/i8XHkm6oozgss2zc7n2fmDSHvRt3X4CYZR54hpkw+Ji?=
 =?us-ascii?Q?KtW9A6Shqy7n9OfMljf9h1KaeveofWHfyGJEf71LeiCaoH+DeZLga8RofQLD?=
 =?us-ascii?Q?/eIWqiLhumupuldIRDWsY0U6is9M40+SMfe8E9LoIJkKA67tqoLDOVE5M4mm?=
 =?us-ascii?Q?ueWr/qi/a3yMsN/J4PbqjjDnYp/RGobyhKv7G+eoj2Z1lDv2sCL5AVzvW9qZ?=
 =?us-ascii?Q?2hdta/2+ANYdsQQ42i/ZX3QIoxFIdAveRowlnd/CvFAhs+j9ESCetAmpD27i?=
 =?us-ascii?Q?OlB/UjtVIm2enrY2DLbeoji+eY0Pv+ps7+WuIqZ+G3xCjj7upTVUdQRKUTy1?=
 =?us-ascii?Q?gNajB09nsasV2z9pbImSUX0g6VAbOyGpilfEImzb8y2VCjlsrZH451g2htzB?=
 =?us-ascii?Q?9aljnGAkIr0jpqMGj+P5QnA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/OpTRsBUAH8SiGxm4v0mklQDw3qZSTTD2Ar+58qvU1nEq8ApA/Sah0YPIHKs?=
 =?us-ascii?Q?yUS/xlZqARJXJx7LKb5NQWQOmCLOx6D8VgAveIfkjQHyKPXxBpyI3HL2By4Y?=
 =?us-ascii?Q?6yEqyjayzE91h+MnmoaxYO1lp28UbXh2iKTuWD3rXryq+A5e51DSt6XmjMxC?=
 =?us-ascii?Q?katGYSG1KBroC4WjlhLDdfBcZnaHdQrfI+4nK1S3EMJ7fUojJ3TcumWNyJJ5?=
 =?us-ascii?Q?JrCgBJ2SUXYpbDjcPDMcepghqRifVWeSYZEcIlUSUvGdaCRaMReFOMMppwDt?=
 =?us-ascii?Q?nKxXc7OIDhzJt5b5ELHzMFWCPm8XT5qObLfPovS7Oob/aHRaJcH8BXQp0zhl?=
 =?us-ascii?Q?fIgGx/3AuxHW/JkBk79uJgZA0iSlXYS4ksmOoEa1zAetq2wmKFFarXBy0NBE?=
 =?us-ascii?Q?g9/fnib/qBxTbgOh/qcxdn9sdjfz98rd7H7mSC+xN2DaUB3ZQvOkTrauXnrv?=
 =?us-ascii?Q?o6MS8TUNahnOMxEJrEJmH18BiTqK1jsz9gR62BqqQaUR5mWyg/in89LXtRrQ?=
 =?us-ascii?Q?jXIV9EacqHGwYGeka4TRYIf1NTH+jtvBkC2zihY+26WOTeU/H+ukJkxtwXY+?=
 =?us-ascii?Q?SILIov4Xx6kMMzH0F5n1soNvyGmSzMgN87uZspOLU4IFXGbuLM2wiovBjci8?=
 =?us-ascii?Q?1TDC35iprwDTQQ8Wb4sn3gZ1lclSXN6Hg2OjgWBIGdynWWjO5/LJGOpdEoZn?=
 =?us-ascii?Q?OVkiq7RH7hxTTIDkMdhXE1aIcPowFxWtSXfSMnrUYyvcTQP5sYZ2EaIf1hRk?=
 =?us-ascii?Q?Sgp6ZT7cqU26pc9UyNckMnJX5ssgabWZVWZjthVqjfL/tyVEnVQStAZxc06B?=
 =?us-ascii?Q?m8z8mNVH1/I2vzDQONXUxSbre2lqG5nfVM+1IFdAkdYJ2KutIvZkQ4hbVZ/T?=
 =?us-ascii?Q?aaKBKBiHnb4H5HhOgyJwMq5VUyjDITXN8NGzzQ3/7Zm2gA8Cq96u5imsI8EC?=
 =?us-ascii?Q?AgP8nJN/JhpcoVorF4IqG+gQCyQlgDUlmAN7HZZc4MzhkiqApNPcl8ERgvDk?=
 =?us-ascii?Q?jOpoRJlfthHU9kehHYFFereBmDI8klpVTR9LTdCOgm0taH0060+Ez7D8uWpC?=
 =?us-ascii?Q?7mQQWOuBM9m+irt0L/OmOlKCHisTOnrsGyZBKgdhHeUktBpH5UnRaLJPtBsX?=
 =?us-ascii?Q?4RZQI2dIQMXHxCS0KIDU4pqsoYVEXKdMdbX3b9zf0bVFuZioi/2P9ZapL6Sg?=
 =?us-ascii?Q?ED7WNM7HobmQimMxelilyXJRr2WSH9O7FR9LnQlwXJDft90KXSBe1OynbTW0?=
 =?us-ascii?Q?d52aESEna5QDTilebhEfttYfmPpeKe0+XD6A/JFXN656LMY3D5K6x8arF3gM?=
 =?us-ascii?Q?QT1sllsNmClQf8eD9s7cwbOrLacPBP5YKSolAfGNeHgV4RTBF62ncPVurQPB?=
 =?us-ascii?Q?KqJ4MjhChXIc9xALJMVDMj27Cm9vWQPuaCFAkHw6BpY/7FSysHxd4pfQcBdY?=
 =?us-ascii?Q?IXxgqflZZFYA94Wnzrq4o4/n+yeLPqSk3/hHPyQ82j+eD8VHzlg+dRIY0tDB?=
 =?us-ascii?Q?4Znn+Ken2Z4a/+wca9bWw2bwj4BgGPHiRuY1MiHFo7f680n4K95ir3aena2H?=
 =?us-ascii?Q?WdGcP+iBtlaScj/SO5/5c9BhJj+Y1dpMQjg5MoNBtns0E7Kv+JHtIVNEygR3?=
 =?us-ascii?Q?A8oSLfxS1qZrEvRexVm8csKgI6L4mtsHO0T2HUgHqLNpLQd3Ole4kpgusen/?=
 =?us-ascii?Q?MSuLi3lytOt4uiryLJP/T8LK6M+h+CNb3feb3DUXqZ6Z9wu0mEXukOczX38H?=
 =?us-ascii?Q?P7XwfUq5Hw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cff7c36-d066-45c5-4874-08de6e5e3a0d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 19:53:31.5747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzCDnoOzK2LQYbudUBcLFXO7JXQqO0VhXZjSNEB6YIQdKOVtnMxhouPxJ2Gb0Jwiw/lXcLdqBRh0EbB3y9PiIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9931
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8936-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,nvidia.com,pengutronix.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A77E414FC16
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 11:04:56PM +0530, Akhil R wrote:
> Update compatible and chip data to support GPCDMA in Tegra264.
>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/tegra186-gpc-dma.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index b8ca269fa3ba..11347c9f3215 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -1342,6 +1342,25 @@ static const struct tegra_dma_channel_regs tegra186_reg_offsets = {
>  	.spare = 0x40,
>  };
>
> +static const struct tegra_dma_channel_regs tegra264_reg_offsets = {
> +	.csr = 0x0,
> +	.status = 0x4,
> +	.csre = 0x8,
> +	.src = 0xc,
> +	.dst = 0x10,
> +	.src_high = 0x14,
> +	.dst_high = 0x18,
> +	.mc_seq = 0x1c,
> +	.mmio_seq = 0x20,
> +	.wcount = 0x24,
> +	.wxfer = 0x28,
> +	.wstatus = 0x2c,
> +	.err_status = 0x34,
> +	.fixed_pattern = 0x38,
> +	.tz = 0x3c,
> +	.spare = 0x44,
> +};
> +
>  static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
>  	.nr_channels = 32,
>  	.addr_bits = 40,
> @@ -1372,6 +1391,16 @@ static const struct tegra_dma_chip_data tegra234_dma_chip_data = {
>  	.terminate = tegra_dma_pause_noerr,
>  };
>
> +static const struct tegra_dma_chip_data tegra264_dma_chip_data = {
> +	.nr_channels = 32,
> +	.addr_bits = 48,
> +	.channel_reg_size = SZ_64K,
> +	.max_dma_count = SZ_1G,
> +	.hw_support_pause = true,
> +	.channel_regs = &tegra264_reg_offsets,
> +	.terminate = tegra_dma_pause_noerr,
> +};
> +
>  static const struct of_device_id tegra_dma_of_match[] = {
>  	{
>  		.compatible = "nvidia,tegra186-gpcdma",
> @@ -1382,6 +1411,9 @@ static const struct of_device_id tegra_dma_of_match[] = {
>  	}, {
>  		.compatible = "nvidia,tegra234-gpcdma",
>  		.data = &tegra234_dma_chip_data,
> +	}, {
> +		.compatible = "nvidia,tegra264-gpcdma",
> +		.data = &tegra264_dma_chip_data,
>  	}, {
>  	},
>  };
> --
> 2.50.1
>

