Return-Path: <dmaengine+bounces-10326-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CHwEQA7AmqYpQEAu9opvQ
	(envelope-from <dmaengine+bounces-10326-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 22:24:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D25515CDD
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 22:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6D61301FF8B
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 20:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5219637DE84;
	Mon, 11 May 2026 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VRyBm6lN"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013023.outbound.protection.outlook.com [40.107.162.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E76E36404B;
	Mon, 11 May 2026 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530871; cv=fail; b=E/L4JSeWy0vcdh0Bj8k9218wgbxBrOVmkXEA00Y5fEJjmCBDYmJN6hcpJYLIVcLz9eJ7pulfvMrg+3vS0poUHLw3IgMr9LVuaA5WCxQvE0g7a0fAOymuasfNwXrdO7bsffQQmPKmeYdrsvltcMh0Y+B3/CLidLly/9W2ggCObC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530871; c=relaxed/simple;
	bh=gr6IBIrD0Xio9pHudXVsFtz3TpsrnvRfMbk6km1Maew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l/AtbHyuyGS+ziAbSWzB/CvUb6jACXt4Pq+UAQwoElyfTi+dpyowVulcVFn8iVYnCC8sDU9OfMBZQltr3O/RMpXGa1O+fDnlHLP8LNdcys9+JKCmVbQH8kBxuGFGQ9dbnDuUsb/FO1Lchf5/rI/2UByAKJA5YClR2H4W7V2IWAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VRyBm6lN; arc=fail smtp.client-ip=40.107.162.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkfglKIO/GgkUhJMsZeR4bF9CxL/oVPBZCw2XfgHJVAPQXAMef5pr0rugEAL0N8FItzp1Xhx/1sO6eiuSQN+Zlpdjb+EBZXDLJaowp+sZNaYtqZ9aCJNLa5EaZEBgWH8aS4kQmJJvBPUpiDMB0QqeTKCzgdo3mm0wN4rFoWbKUjL67vc4YvJmhy3wVq07drKxpPADH8MrQyjlRQvNHAtbTkIMUWn1rqT9uULqXPhjS4iGbNCbIEM8Txp7UBMj4k7TvyBT6O4aUb8l1a+Crnbt2PjRiqAOdjUTezqqGDgdKzCTmScwV31BOm2zzVANnBimmlNYAufH7VhNZGfw31K0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AT9C+PjPv7nWfgrFUAoiD58Zx4lQsG98OOtkUwHBjt8=;
 b=Q4wSdO1clxoxUocBCBRVoNe4EkfJxgYDrKKZ1NfErfTSuyee1RgMVWcjik+fmquU8d8wlMvNa+/F61wMAkArpHSHN2qBpUloQbanPiXSBKmofqhNzEjUmfS7q1NB9qCcE0S4TvLczIUxRToZ37dnOkrDomQ65+WHPXzrWl7vHtey6+IcDM+e0yHUnAGbCfjgHnovS3pk55c4GAynxFGSfYqFoSqy1vxdSI10S/IfOekDlM9z90q532J8AcurwfGU9LfSfQVQWDmOZuaF0Sz7OjJV4FyNow42KHoYK9AR0YgwfzvvxwpBt0pZc7LLBFymZ9JcoDdakvE/1FLL7QsT0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AT9C+PjPv7nWfgrFUAoiD58Zx4lQsG98OOtkUwHBjt8=;
 b=VRyBm6lNQhtcvf40/PLUwLu885xmHTkHR9lPc1Ev52OMWP7c7eGGumskN2oH8jTt3Ob2lBgbMMxuNf4QvLh3DZDGmXgKfNxzjQN7/8ecDUp3M3Hs3rOsiNE3H4k5zMBnCqw4PZeFjnKfr3VNgpg+NpF6aeStGUq7+ylOqdJF6f/NNW4earKZbem5HXJQ5rB6AVJ6/dilIi2RfFNaMb1cS0pKfU5FUFLrKv3iGaiH72/naKAp78rdSBKokLceIFKI/mXcr+W73TDouG3NNUGgvSPEbe9X9SrZnMv6vMHV8F7+nkY44Zg2McuVAojrABF94twcsulypZEcSmSqUyeSdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU6PR04MB11133.eurprd04.prod.outlook.com (2603:10a6:10:5c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 20:21:03 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 20:21:03 +0000
Date: Mon, 11 May 2026 16:20:56 -0400
From: Frank Li <Frank.li@nxp.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"Claudiu.Beznea" <claudiu.beznea@tuxon.dev>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	"john.madieu@gmail.com" <john.madieu@gmail.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCh v3 2/2] dma: sh: rz-dmac: Add DMA ACK signal routing
 support
Message-ID: <agI6KFUOMxZ1Upfm@lizhi-Precision-Tower-5810>
References: <20260402162212.12016-1-john.madieu.xa@bp.renesas.com>
 <20260402162212.12016-3-john.madieu.xa@bp.renesas.com>
 <afzep7hF8uj-jRhc@lizhi-Precision-Tower-5810>
 <TY6PR01MB17377AEC612CA33F43C1F4A8EFF382@TY6PR01MB17377.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY6PR01MB17377AEC612CA33F43C1F4A8EFF382@TY6PR01MB17377.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: SA0PR11CA0185.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::10) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU6PR04MB11133:EE_
X-MS-Office365-Filtering-Correlation-Id: 7945b99b-dc29-4f3e-2b9b-08deaf9ad2ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|7416014|376014|38350700014|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	zbDhW4rNvD4dz3OqK8W/cl0EV0BzQsdp1oJBcuDx24659BCA03GflAaEA+NOR8xPvR2hcyuQ431jt1y8UNzfGyhccTkrI/y0qqunRveJT3tn+M1MjQieoEhIvpFWNu8B/FXp6qlNFf8lX/zlFsPl7hWrKwuVBhSiPth2SSPnRrIMLhpSgygNJDTtvbhgnZkXjukj/xOgcBQ0vz+CA2k30i4gxH4q9+XR4zBQMDUq5TzmpXgTlvLSS70C+2Xcjk2O7ixWR6tYnKQBX3cKciSB2W9oA+p6ptfJ9LXLEIBdCy3B7ftArn+Hjz7CiWZVMcbCFQprk1LOYbBCJoKJu9tMHwjM2G17ma6YKToX6fu/YiUVtdvF3JlzxXflx7gC8IN5mcfxbXOZf696XVsD38dk8EBTDvXZ8u+l578khMrPe5Skv2qGyhoYtJSXM5LkvFBUDBV7Za5WK6AdjUidQ1gwVBqJalQZKhEsPIEXTtqJUgM6i2foGAOyjs43I+qM9XVW+PHXyFJoKjaWlXCQUEWE5/fCczMNB2kMdXpjLj/kjYBcFBafJ9gLdtGLIFw2mIE0J+9I7fX2WwH6SmkyTrnB/eYmgaW0zTdpIivX6oqIWzR0Oq7CN8UlPACo1z7BzHkVIfZgWtfoT6vrkN0Xanh57cozi/2RMahwW5+t4T0TvzjFEA8YTe+YFyQGhKGcBVB98eOq6tYLTG+ET+4EDsKKvgjcMRScA7ClUxt36k2JQCrz6NkCuXDRhI/HjqhCx4Do
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(7416014)(376014)(38350700014)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zfc5WKwYrV1L5OMBVQT0kQwzxaF98kTpYpwjYgyojbMVQLOhtnYe47jPMe3e?=
 =?us-ascii?Q?WFSzqC1YGxBUBjeu5WEeXsa1jqKhfC/9W4xGGvFbnGd35ucSVUNEwxCw7Bvl?=
 =?us-ascii?Q?4tKHfe2sXLRBcYeKI7omDC/Ml1Lx7os5s9tQWog9zE+BJXQusgOrEhFl5yQj?=
 =?us-ascii?Q?c0UrUTwqmdZLvs1Ht3mwx9nX7zodyy9M2g3Cs00Wca4cnQCWM44WfAxnQLA4?=
 =?us-ascii?Q?X6K6qSJgMiyVK7x9iDBDub2JiW3lCvjGMw76blDxL88ENk7gusi49eZsxxqt?=
 =?us-ascii?Q?L2/5ZNnBcK1Nj9HmlnKn2qYyr7oT//G4XS5N1hUpw933o/GZg7PqAOQMcApY?=
 =?us-ascii?Q?J9HFdY0+l1jr0UI/SF9ZNfMtLusfjxF839WbTfQvt3y/xB8UkvVCA2rnsHdU?=
 =?us-ascii?Q?148odVGNrVFNB316ZdJ68pzpmBsmJXeTf7g5Eov7d+sdVybiW2FZH2XT6WKn?=
 =?us-ascii?Q?VOMbKn1G5dHB05ev611pUd/gmscpVWpSCRy3+Pa+ZEZM44RbU8ZuVAoVF8m9?=
 =?us-ascii?Q?P9Kudb6UVq+u0yRx8wTpp4e6pWAYYDquMO3PTuh+urPH3vbG8b7uwbtmRX9r?=
 =?us-ascii?Q?yxymAhPhJMyAWFI1vCLT1pxqlqe7P9AH1UnwJKbJBNQe+3QqO7yQ718c/rSk?=
 =?us-ascii?Q?RkqR/rPDEP9Pcjkae+Fzmf4mQdCPURUEqJVVx5elp3RORnmzEEQG+XvcoBRo?=
 =?us-ascii?Q?kaoVuiffi1i6ERCJRM111J2scNtq6kNzjFUpBpwuSfCFQgoaFVvaU4OcKXpO?=
 =?us-ascii?Q?FigXxWuIiefaT3A5Ebd5H7W5iA6+JaAYlgSW+aHYo3sgMX1oX+e4mkgwR7Qf?=
 =?us-ascii?Q?94Ue9Im90NWvdbd/aZZCq8dpDuC20EUWlNgIGsyWZii/9QEtsu1wB54KyUQv?=
 =?us-ascii?Q?3iDeooCQvb4vTsDeTap4hi/TzpiS3ukFSDtbLPYFkXveqO2oW1wPyLRnu2gB?=
 =?us-ascii?Q?pkFhvPZYUFr9OKAK9aJ/W2PAQtI0TG4q70ONAgHgJmjw9HEZCkE+l+gLZsn3?=
 =?us-ascii?Q?zGBDXVu7I9YcuT2rDDRkJk2UwwB6QX4+Bi7Jl7c12uHZioESlSrV3E2B1rF9?=
 =?us-ascii?Q?FpYEWjqwl3PW0e0ibMXIZ1JSYfsbamEJyD/YxTI4XiK72es33f1sJs66TQQR?=
 =?us-ascii?Q?mfM9hZOkOcwDMdR2u85IxUnTvNaQK7/Hhua4CAKc+N30Ht0Ul8FT8NKrOsxo?=
 =?us-ascii?Q?uAIAPdX1JEvtNxxbFL4gLMHChJZJa2AgE5d+TkZ+DKTCjhEifQynJduyEfAb?=
 =?us-ascii?Q?UziYtVrgoAe4nvg5yrLAxziE50M+1kE6MtnOtOPoJ+cavOVTgFvSRj8VoUNM?=
 =?us-ascii?Q?b0v7w1RmJmOiY44z9Mcj0b0FYWuwAjYD2m+WNGXW1lZy24Ho9taMpCLZuNlM?=
 =?us-ascii?Q?8cq3aI8K75lLMeikYAW0j4lcmC1YayRwmJrdwIPLs51cT6ZG26wOXoatlN9c?=
 =?us-ascii?Q?OInLOArRdNvMp82VMQgNc4tPoucxUGbA2W+py24NYMDEFSbJwsj6nech7OYL?=
 =?us-ascii?Q?fefbwwR/FOlBFnXHjFL7f/4WUW0XvP3xREjwmGc4Z7u0obJZCfvCPGpHleeC?=
 =?us-ascii?Q?NpFN5FMkI2CdLvYXCJUQhFxq8F1rh5PFnsz+np74567wIE3863W+s8Krr1v3?=
 =?us-ascii?Q?i+nOisOc06U1SQaROyip8swvq33jQUDGmY/kTyMAiYfG98RJgN5BsAPQQcTW?=
 =?us-ascii?Q?Qwyy0i8r3s5ukFgFRvsDZnjIl309EsvJJUEfwZVuQqhhRCTS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7945b99b-dc29-4f3e-2b9b-08deaf9ad2ce
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 20:21:03.3109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOe9FJslLFjKBAYFd4HjDqn2lhhla0+RO12ZfW/f/Mo5ZBInE4F+00YQoO4fe1P5JwF5dpft4pMEuq8yWi0WCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11133
X-Rspamd-Queue-Id: F2D25515CDD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10326-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,renesas.com,tuxon.dev,bp.renesas.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 05:04:46PM +0000, John Madieu wrote:
> Hi Frank,
>
> thanks for your review.
>
> > -----Original Message-----
> > From: Frank Li <Frank.li@nxp.com>
> > Sent: Donnerstag, 7. Mai 2026 20:49
> > To: John Madieu <john.madieu.xa@bp.renesas.com>
> > Subject: Re: [PATCh v3 2/2] dma: sh: rz-dmac: Add DMA ACK signal routing
> > support
> >
> >
> > On Thu, Apr 02, 2026 at 06:22:12PM +0200, John Madieu wrote:
> > > Some peripherals on RZ/G3E SoCs (SSIU, SPDIF, SCU/SRC, DVC, PFC)
> > > require explicit ACK signal routing through the ICU for level-based
> > > DMA handshaking.
> > >
> > > Rather than extending the DT binding with an optional second
> > > #dma-cells (which would require all DMA consumers to supply two cells
> > > even when ACK routing is not needed), derive the ACK signal number
> > > directly from the MID/RID request number using the linear mapping
> > > defined in RZ/G3E hardware manual Table 4.6-28:
> > >
> > >   PFC external DMA pins (DREQ0..DREQ4):
> > >     req_no 0x000-0x004 -> ACK No. 84-88
> > >
> > >   SSIU BUSIFs (ssip00..ssip93):
> > >     req_no 0x161-0x198 -> ACK No. 28-83
> > >
> > >   SPDIF (CH0..CH2) + SCU SRC (sr0..sr9) + DVC (cmd0..cmd1):
> > >     req_no 0x199-0x1b4 -> ACK No. 0-27
> > >
> > > ACK routing is programmed when a channel is prepared for transfer and
> > > cleared when the channel is released or the transfer times out,
> > > following the same pattern as MID/RID request routing.
> > >
> > > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > ---
> > >
> > > Changes:
> > >
> > > v3: No changes
> > >
> > > v2:
> > >  - Drop DMA ACK second cell from DT specifier
> > >  - Derive ACK signal number in-driver from MID/RID using arithmetic
> > formulas
> > >    per ICU Table 4.6-28 (3 linear peripheral groups)
> > >
> > >  drivers/dma/sh/rz-dmac.c | 72
> > > ++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 72 insertions(+)
> > >
> > >  static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan
> > > *channel)  {
> > >       struct dma_chan *chan = &channel->vc.chan; @@ -431,6 +489,7 @@
> > > static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan
> > *channel)
> > >       channel->lmdesc.tail = lmdesc;
> > >
> > >       rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
> > > +     rz_dmac_set_dma_ack_no(dmac, channel->index, channel->dmac_ack);
> >
> > I am not familar with your hardware, why ACK folllow req immediately?
> > suppose ACK happen after transfer done.
>
> rz_dmac_set_dma_ack_no() does not fire an ACK pulse, it programs a static
> routing mux in the ICU (ICU_DMACKSELk) that selects which DMAC channel is
> the source of the ACK line for a given peripheral. It is the symmetric
> counterpart of ICU_DMAREQSELk programmed by rz_dmac_set_dma_req_no().
>
> Both registers must be configured before any transfer can happen on
> the channel: the REQ mux routes the peripheral's request line into
> the DMAC, the ACK mux routes the DMAC's acknowledge line back to the
> peripheral. Once the routing is in place, the level-based REQ/ACK
> handshake itself runs entirely in hardware on every burst, with no
> driver involvement per transfer.

Supposed these register should belong to dma-engine, but it was located
into irq, you open a private API to irq chip drivers. Ideally these
register ownership should move to here.

these routing mux should be in allocate channel callback, not in
rz_dmac_prepare_descs_for_slave_sg() or in xlate function.

Frank

>
> Maybe should I reword the commit message to make this distinction
> explicit (routing config vs per-transfer signal).
>
> >
> > If ACK need after req, why not add ack handle in rz_dmac_set_dma_req_no()
> > directly.
>
> I would prefer to keep rz_dmac_set_dma_ack_no() as its own helper, to
> mirror the existing rz_dmac_set_dma_req_no() path. The surrounding
> infrastructure is already structured around per-routing helpers, and
> the ACK additions in this patch deliberately follow that pattern:
> .icu_register_dma_ack/.default_dma_ack_no.
>
> The two ICU registers also index their fields differently. ICU_DMAkSELy
> fields are indexed by DMAC channel and carry the peripheral req_no as
> the value, while ICU_DMACKSELk fields are indexed by the peripheral
> ack_no and carry the DMAC source channel as the value. Folding ACK
> into rz_dmac_set_dma_req_no() would mix those two layouts in one helper
> for no behavioral gain.
>
> Regards,
> John
>
>
> >
> > Frank
> >
> > > --
> > > 2.25.1
> > >

