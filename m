Return-Path: <dmaengine+bounces-8573-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILw1AkTXemnm+wEAu9opvQ
	(envelope-from <dmaengine+bounces-8573-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 04:43:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A4DAB7DE
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 04:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B602300EABB
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 03:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAAC35CBBE;
	Thu, 29 Jan 2026 03:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DvKvqqCA"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8AD2BD597;
	Thu, 29 Jan 2026 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769658161; cv=fail; b=DYSKhKWQTZVXp9hLr+xisJtxQtDv+biivuzYGEx/Ed07tCC7yc1yaeC/fJVPK9Wo2atYNvKUiI9ctvHPQqb6IZPU1fERRfqobf1YN5WtGsIqJP7OxufsIof9TSAbuwd5Ispw5LUDZuoiO6QAOMsMPtx1bxmVtwk/Y9wG7ShjH+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769658161; c=relaxed/simple;
	bh=vxi1BcZ7i1XzhF5/68mMaun47MCNqxEy4KoMTXB9Kew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RBcGlPsYUFeViPITa2CxUuRyWdUrcz2a4XLbgS6pi2Wx2mJaE1fWYbNsnfVlIn2WWVxGuN9CVnDb/RmhdaemvkXuCHb0nQWIGa12IjCyATHBOE/gqhSPm9j0/36xGrWJAOXmGBX9uyOAby0pky9UaRjIzmlTBuXIQ2Ylg0kfiZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DvKvqqCA; arc=fail smtp.client-ip=52.101.69.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqZWDnIbWbpn1J1AbnzBEd4jotEdTQWOK3GX1ybwApKX5izOeMom5XPRtBoEi5W9TdySUm543VJklNYBcJ6bu85BaaMfYH9S+llnzFJ0auxASoYo87+CYhBfwwuz6Z5772rWhOA2hcFOH5n2xOXUw7trNkVtDNe46P0HGKDFxwhJ592ZGC/fnx5XZPpwXY3BvG0OL6VBxn5L6g+dz23OEzrRw3cpbHPTfJx7ausMZ1+cbHkzGjIU3KXrQTUgoMDNRt3gcRfL1fccxbYxKY7d63LvvFxRumPNptF9VOyC/zbklL+l6zYBUdhKVIlsz916Tzhkxa/3KjmNhSYNVa5q8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fI8eT25JKmVuYM/2M+3P8wkEHMCzU2v2/RR0lyT6dA=;
 b=plTPAg9Q0MWuzND5+qr+8vYdKlorsNSCY4TPVNsCZh7H9KmP4Q8faifl3FackhekvVF8E+X/JqBHjZGMIAIh2xVogZGujrupiyf1xGl2c/K8NSEM5IpIyKsCDg/OPxBqNlGP4UQi/gnn/atLoOYOfbD6TT33p+ODS45wHu34fXZB2rig6mA6d57RKc/XPpwWLQf9W6Qawqo1O0hxpc6nt5oXVU3VfQXASSD+0Avy7bds+7MTi1cPwVfCkXgxvSiWQZfymisdcrLrYLEE6dAcvuA40B2aA4Jfqs9Cvs/R9EPLqm9Ju1Uxz7pnYSKfjRSgTrWf660h3l4VNh7S+NWfQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fI8eT25JKmVuYM/2M+3P8wkEHMCzU2v2/RR0lyT6dA=;
 b=DvKvqqCAVdJ7M/fsLAJ3cwexpjbT0wdFZciiIDwBtHUF7EyicCvHSF79iq/IGymDv6LL7Ohj74v2YEG5QrnVhp/UK3scH62hJQHNMjgqHBDCON6xzduibaQE3RidGMXG7NsBdZhPdhEMlgPgzvI70BXfN0VtUiiRzprHU3eIt1OYGvkZqQrOM58NSTvviMuPLNBlkESjAZW5vjtZXmyKqz3LZxcFcM/PaZg16XPAuO+7D/oRi6xgMr55STcd0C9zAjPHtPvqS6WSXq09asmyQsglMgo12GRiDOfGANhR/DG5Dqy0QIPirCmeaezokP2x2owRHfLUuJJ+n4CMsDjPew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS4PR04MB9314.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 03:42:36 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Thu, 29 Jan 2026
 03:42:36 +0000
Date: Wed, 28 Jan 2026 22:42:29 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, vkoul@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] PCI: dwc: Add helper to query integrated dw-edma
 linked-list region
Message-ID: <aXrXJbjKiAFXaxOX@lizhi-Precision-Tower-5810>
References: <20260127033420.3460579-1-den@valinux.co.jp>
 <20260127033420.3460579-8-den@valinux.co.jp>
 <aXovtOcilRrkA0Ot@lizhi-Precision-Tower-5810>
 <dpx4s35dqvhp54sloixxsn3qcf3g2k745wieaefdc2svgkbtr6@4vuqgp46czi7>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dpx4s35dqvhp54sloixxsn3qcf3g2k745wieaefdc2svgkbtr6@4vuqgp46czi7>
X-ClientProxiedBy: PH2PEPF00003851.namprd17.prod.outlook.com
 (2603:10b6:518:1::76) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS4PR04MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f1c8d0-d013-4599-c591-08de5ee87155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vktRIo/kQZWmdvNlsiiAImHgnXH6WnTzmoaQpAcAoMU92K19PE503UA8zNzp?=
 =?us-ascii?Q?XVP28lmWjIJLYEvkx6ywvYcWil6Hec/YDh/uVrynuiMoQpjtywICNBsEVMJP?=
 =?us-ascii?Q?sDIz7LU6JTSswVl3DHTblNhVBCQtDZ5nN1i2LuPHaC0jPqRiKzySkpAeeFfm?=
 =?us-ascii?Q?H/pb/eSTuWdFSz71HkCbdmlia8iFoeSS9Wc5bOjy3wCFN9zPhwXjV30lTzoQ?=
 =?us-ascii?Q?9kGzlP5pT/ZekTvVFU2+AsLdgxjX4mYFHxzo3nj1s81Q5i6DLhTY/pfAtKuM?=
 =?us-ascii?Q?RuCgVXiwFA++9wZ6w1xShGPTfufWUBWzC0EEneq0NHQpJWZnkBrbnCVqjgsc?=
 =?us-ascii?Q?YoYt9H2b6EpK78hhTgAFkMSWrUc/eJiOuv9n9/SDU3Y7KNHXGoZSoKupuoQx?=
 =?us-ascii?Q?x3/YI85+o+FzxuqCCPI3xSEJiz3nsOmhsKNIarpmBpfXo/ldrR1ojynjjRXW?=
 =?us-ascii?Q?M4lHL1vhofVltDFMivDYmR/j3o68pYnclfVis/cLpzPuCfxeIHsnaD2AVF5y?=
 =?us-ascii?Q?jsd2GpKMr3NZJWD+/jcb2cL831g00NdCCpiIwUhjrg+ro2Zy2lHEy4Q5krqf?=
 =?us-ascii?Q?CArd7Wd6dDwToM/mKhewFtNSeEHN46my539ciJbBihTkU/j3vWvlT3nNVo71?=
 =?us-ascii?Q?vuJLgvtDkdZw2KEFrX5WcxvWeqHZ7mWTuO2uUej9VdgFiQzV+6DuuIGoYxRC?=
 =?us-ascii?Q?8gkAMUtmRLEEYxiFsr3N3ts96KpNV5S+4vjDT4o4zF1un6nu7Rn/b5PxXtxk?=
 =?us-ascii?Q?0ZZdHRNx3/LS2/8TTxDj58n9p5ZTvUhJOzt8tqLpzIMyxR6pJPmGooeb4t6T?=
 =?us-ascii?Q?8SmMW30LW3E/rK5pGPygbKi5nUkca0E0j2X8CE+B5IEu029tYwEMBF5v5xNx?=
 =?us-ascii?Q?07NVQX17XNc4PG04beN7hPxP2CIOhSOq1CKJgqSoR1aHsz8+IbIZ2x3plwfN?=
 =?us-ascii?Q?3fvPGM1HShWJsEYJi8YvcH2QhqAoQuH1EilB4L+LSu0omU0/Fix6c0l62loa?=
 =?us-ascii?Q?Tdph8W48WvLOLfyzHpyg3hQ/C5stwQ35BdI/9qAsxgxHIT4Gh5qqOo6a9GFl?=
 =?us-ascii?Q?jTsVQ0SgI0plNMRSVeyMpk88e5mMMzF4IbDMiEEtQumiORBWpUkvr2uoMjqA?=
 =?us-ascii?Q?32VcGLxM9Y7/FZ1ipgr49idthwpFxHYxJB5dCSFA4/Yz+QjGzei2gvHTLveC?=
 =?us-ascii?Q?lj/yLU2okJkmSChnwTkJpRlm+FDwBTCjksEjLn8WZx04+9BtI8t1Jz946RgB?=
 =?us-ascii?Q?GgYnJT2zC5ARYbSDFv/pOJmKnCMF0BNW44iRIkxl8B/5zL4VohWDNjmBYfNH?=
 =?us-ascii?Q?DcCGmSQ1Ba0xvsZ6kZtvQzfr8ktrvj3LtUyzGRX0S9YF/BC/mbKHkvaCaoXn?=
 =?us-ascii?Q?jovSozgO0mMqJMdWyD4eutqUS2MQBu42z0QIOMcEWqjMpPaGfo6gjZoYuzSn?=
 =?us-ascii?Q?R7TbQ+mJJVDiXfjPJ76Ak87ImcuHPteQjqfBwQt33pAQM83eDGYFDGEUcj9S?=
 =?us-ascii?Q?2xPJQU5l7WlfllTJQJmP66aT2jpFPh6OnrUp8WNiGalpyaoJp0b9H3Cz+1Pb?=
 =?us-ascii?Q?UEC2yizcjU7tfo/TKlTanuPmAoUoeLyjKlxAwNowQ9kBdtlBnHvvhsRZTrev?=
 =?us-ascii?Q?B0KzVgd25a40j2XGFwdbnsk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cZ418Z7uYqh5aBHaQyjS7RzOg8pNeTaVDIyq8GLZCcIails0vYZ0P9/waa5A?=
 =?us-ascii?Q?cS1ZUvJCHhgxfcdjZqC/mzrcdJwtFBlI0Aoe49VTm5L4NDJWeH3LR1h0SFEm?=
 =?us-ascii?Q?Myy9yfX5S/sUsn/AAZFiHFIzNl6cs8eFnZ8yG0YvzdBmaLzvy5QADVipOpAW?=
 =?us-ascii?Q?uonSJ5HnFeLXHviXUFoWTKq/UwKimI7VMuZpg1MvpHWkkz4GAcJCKd2KJNPy?=
 =?us-ascii?Q?MY9AI0gEPlh6V3X08jOtisLntqv6ZPtuyWA0aE5tUwu1PbUi+k3PKJ0O1EZo?=
 =?us-ascii?Q?52azGKAzoe3wDjmmyf7ltMSJYT9h0AaQ8iMq1StabnzrxV4rro/CeEnbawJS?=
 =?us-ascii?Q?pwyvfhIMbytrqLsHCTKhCNMiQk8XbiAu02l7XLKG6lDIJYG1uBMBiZUF1U2s?=
 =?us-ascii?Q?jVgAqPEImL3fwN4xebD707dnvyXquJ+GqijCsNs8lUS4S2/Rohn6Vuw271rU?=
 =?us-ascii?Q?2LFBbYzcN90MC0nPJwg6Ms5w+b1A/RpwJ58WfSMkDyApvaAKDx2RC4e+4QPY?=
 =?us-ascii?Q?0nY2K+zC30YKASQ5OhyJ0bW/opnhX06CTRtpaMnzInS610y5M5ab6C4vK8Q0?=
 =?us-ascii?Q?S3RpXQkv69UbjHJafybhREkqKu2JfxasmNilufHlKvfKIt4mWSuQd7YdNG19?=
 =?us-ascii?Q?j+gO9BbEVrPsF/FuGWA9mb/neaxUG57Bgkk0cejLk7nhSW6tH6cIe3yV5Qz2?=
 =?us-ascii?Q?Rw5P9AhTmIUE2HYwJC8u/3Y6xEuVfHtGepWuMouOdzHfn4OnZCrqd+aloKlt?=
 =?us-ascii?Q?dTUa3Ei0KX1FaDhL8nUI1j6NKCuFoNuia3stfWBqw2vb8zeabivMATiAv2Ko?=
 =?us-ascii?Q?jf0kjJCVFPWywE49Cj+o5VNQH0MsbBJnGDHgc2RWDKmRlOkPVogaMQb/0ebJ?=
 =?us-ascii?Q?qyzJ6rpDXus1a3gWe8O3a6XMzhPYJ6hGxB9vAIviQkVHzgLMDrVgh0AAUusK?=
 =?us-ascii?Q?gRdlUqCBjAxJRT9fvXBL5pPD1P50meugKx5qxrpdRfIBRF+nK1FYgMGT/dto?=
 =?us-ascii?Q?a7R0VU7FVHnGrXcWo8E96RCgx4QAVra/yeLEwDha6SMcU+KzdbiJf7a+UCXt?=
 =?us-ascii?Q?pUFCNhtGomWyZrAvjPsFHUEviJFUUYTMmP1ck/Hi4fsQuAvhVKkuF5j+LThG?=
 =?us-ascii?Q?lwvsmNJoVg2K0j7csCkSuScSBKVVeGYPmYl67/xY9/+LTSpFqqhRshudXhsR?=
 =?us-ascii?Q?lDiAt+qfPIpkqfzHWKwA4vfhmxO2wQuLv8poK60az++Dv0YLt8ZNRXIFyE2m?=
 =?us-ascii?Q?abKopsL1/rG0ChuFsLBdizXs3gBLg9M4sPr4ONsjwRoey5ltkDqF5sV+R3Nw?=
 =?us-ascii?Q?0qCBaNCvZhTpf4HCtl9ZPPXj0xJkvVHzek3gFpn9YdG16k6L+KHhpt1lZCqa?=
 =?us-ascii?Q?18RWrkM7/gYtJOc6judeVOJCW7qiZfHDsp0LNUlqgn+5TgktXNBdvCpALcCx?=
 =?us-ascii?Q?gNs6nNqbu9ifxM9jgLdRCbZQAECfcyfAGJ9SblZvbF48iuZtezE3iQ5nHIUH?=
 =?us-ascii?Q?Ny84DvyrZRqPzjgWUhjlACCHELB638eu7K20sSwbpb0t5z7E4NTOdzIQTwao?=
 =?us-ascii?Q?iV4y9OJLH9c3IBVTHIEodFoO5u/OwTPHxlQFOCwgHOlvexACAt3z7CMgDI5F?=
 =?us-ascii?Q?pusj07Z6l39AEOisbuEYTO8FS/o5VJAOFw5NYQBlr4vxvWmaF1O+dLH4pnCj?=
 =?us-ascii?Q?HlXMIIzXJiEQA/CjE4SgtMqgKU2ficAxjgIUadXezBtZJVwuuMICnwalYo4z?=
 =?us-ascii?Q?IVLa98AqJw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f1c8d0-d013-4599-c591-08de5ee87155
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 03:42:36.1545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xU1HJ666+RjcJPq9sB6fYQcX6FvpMy4AFw5baryFL+FAZKVVM5ugpMHlf+sy1QXBvKvvevyZVh/SXISQ6NiQnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9314
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8573-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,dw_edma_chan.id:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:email]
X-Rspamd-Queue-Id: 78A4DAB7DE
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 01:25:30AM +0900, Koichiro Den wrote:
> On Wed, Jan 28, 2026 at 10:48:04AM -0500, Frank Li wrote:
> > On Tue, Jan 27, 2026 at 12:34:20PM +0900, Koichiro Den wrote:
> > > Some DesignWare PCIe endpoint controllers integrate a DesignWare eDMA
> > > instance and allocate per-channel linked-list (LL) regions. Remote eDMA
> > > providers may need to expose those LL regions to the host so it can
> > > build descriptors against the remote view.
> > >
> > > Export dwc_pcie_edma_get_ll_region() to allow higher-level code to query
> > > the LL region (base/size) for a given EPC, transfer direction
> > > (DMA_DEV_TO_MEM / DMA_MEM_TO_DEV) and hardware channel identifier. The
> > > helper maps the request to the appropriate read/write LL region
> > > depending on whether the integrated eDMA is the local or the remote
> > > view.
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware.c | 45 ++++++++++++++++++++
> > >  include/linux/pcie-dwc-edma.h                | 33 ++++++++++++++
> > >  2 files changed, 78 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index bbaeecce199a..e8617873e832 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -1369,3 +1369,48 @@ int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> > >  	return 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(dwc_pcie_edma_get_reg_window);
> > > +
> > > +int dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
> > > +				enum dma_transfer_direction dir, int hw_id,
> > > +				struct dw_edma_region *region)
> >
> > These APIs need an user, A simple method is that add one test case in
> > pci-epf-test.
>
> Thanks for the feedback.
>
> I'm unsure whether adding DesignWare-specific coverage to pci-epf-test
> would be acceptable. I'd appreciate your guidance on the preferred
> approach.
>
> One possible direction I had in mind is to keep pci-epf-test.c generic and

Add a EPC/EPF API, so dynatmic check if support DMA region or other feature.

Frank

> add an optional DesignWare-specific extension, selected via Kconfig, to
> exercise these helpers. Likewise on the host side
> (drivers/misc/pci_endpoint_test.c and kselftest pci_endpoint_test.c).
>
> Koichiro
>
> >
> > Frank
> >
> > > +{
> > > +	struct dw_edma_chip *chip;
> > > +	struct dw_pcie_ep *ep;
> > > +	struct dw_pcie *pci;
> > > +	bool dir_read;
> > > +
> > > +	if (!epc || !region)
> > > +		return -EINVAL;
> > > +	if (dir != DMA_DEV_TO_MEM && dir != DMA_MEM_TO_DEV)
> > > +		return -EINVAL;
> > > +	if (hw_id < 0)
> > > +		return -EINVAL;
> > > +
> > > +	ep = epc_get_drvdata(epc);
> > > +	if (!ep)
> > > +		return -ENODEV;
> > > +
> > > +	pci = to_dw_pcie_from_ep(ep);
> > > +	chip = &pci->edma;
> > > +
> > > +	if (!chip->dev)
> > > +		return -ENODEV;
> > > +
> > > +	if (chip->flags & DW_EDMA_CHIP_LOCAL)
> > > +		dir_read = (dir == DMA_DEV_TO_MEM);
> > > +	else
> > > +		dir_read = (dir == DMA_MEM_TO_DEV);
> > > +
> > > +	if (dir_read) {
> > > +		if (hw_id >= chip->ll_rd_cnt)
> > > +			return -EINVAL;
> > > +		*region = chip->ll_region_rd[hw_id];
> > > +	} else {
> > > +		if (hw_id >= chip->ll_wr_cnt)
> > > +			return -EINVAL;
> > > +		*region = chip->ll_region_wr[hw_id];
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(dwc_pcie_edma_get_ll_region);
> > > diff --git a/include/linux/pcie-dwc-edma.h b/include/linux/pcie-dwc-edma.h
> > > index a5b0595603f4..36afb4df1998 100644
> > > --- a/include/linux/pcie-dwc-edma.h
> > > +++ b/include/linux/pcie-dwc-edma.h
> > > @@ -6,6 +6,8 @@
> > >  #ifndef LINUX_PCIE_DWC_EDMA_H
> > >  #define LINUX_PCIE_DWC_EDMA_H
> > >
> > > +#include <linux/dma/edma.h>
> > > +#include <linux/dmaengine.h>
> > >  #include <linux/errno.h>
> > >  #include <linux/kconfig.h>
> > >  #include <linux/pci-epc.h>
> > > @@ -27,6 +29,29 @@
> > >   */
> > >  int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> > >  				 resource_size_t *sz);
> > > +
> > > +/**
> > > + * dwc_pcie_edma_get_ll_region() - get linked-list (LL) region for a HW channel
> > > + * @epc:    EPC device associated with the integrated eDMA instance
> > > + * @dir:    DMA transfer direction (%DMA_DEV_TO_MEM or %DMA_MEM_TO_DEV)
> > > + * @hw_id:  hardware channel identifier (equals to dw_edma_chan.id)
> > > + * @region: pointer to a region descriptor to fill in
> > > + *
> > > + * Some integrated DesignWare eDMA instances allocate per-channel linked-list
> > > + * (LL) regions for descriptor storage. This helper returns the LL region
> > > + * corresponding to @dir and @hw_id.
> > > + *
> > > + * The mapping between @dir and the underlying eDMA read/write LL region
> > > + * depends on whether the integrated eDMA instance represents a local or a
> > > + * remote view.
> > > + *
> > > + * Return: 0 on success, -EINVAL on invalid arguments (including out-of-range
> > > + *         @hw_id), or -ENODEV if the integrated eDMA instance is not present
> > > + *         or not initialized.
> > > + */
> > > +int dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
> > > +				enum dma_transfer_direction dir, int hw_id,
> > > +				struct dw_edma_region *region);
> > >  #else
> > >  static inline int
> > >  dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> > > @@ -34,6 +59,14 @@ dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> > >  {
> > >  	return -ENODEV;
> > >  }
> > > +
> > > +static inline int
> > > +dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
> > > +			    enum dma_transfer_direction dir, int hw_id,
> > > +			    struct dw_edma_region *region)
> > > +{
> > > +	return -ENODEV;
> > > +}
> > >  #endif /* CONFIG_PCIE_DW */
> > >
> > >  #endif /* LINUX_PCIE_DWC_EDMA_H */
> > > --
> > > 2.51.0
> > >

