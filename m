Return-Path: <dmaengine+bounces-10768-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOuTHDfCEGoSdQYAu9opvQ
	(envelope-from <dmaengine+bounces-10768-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 22:53:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AE05BA39A
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 22:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C05BD3008CA8
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 20:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337F537B41E;
	Fri, 22 May 2026 20:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KoCcZcBz"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013036.outbound.protection.outlook.com [40.107.162.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BAF3769E0;
	Fri, 22 May 2026 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779483122; cv=fail; b=fbp2v+AX9FPdSUhnmTYX7LHlt8cJcPYNbNvXgIWadovzUBto8nOXLiYsEz7pKefc2T2/rdCSd0a35YO7RigzJKspZD/xCyu5ojkiPtZ+Uw9aHRdM/p2ovJBtpmUGbSdv1D7pOE8gXek41SoBxaS9wOJMPU2HHj5+itt76ilU/yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779483122; c=relaxed/simple;
	bh=7ugiVd5lMUgM/TcpEP5S6ZcNmDzgrEt4SFgwAiGAsuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BYQ3u26sByyYcBZcgV7qZV41oNG9Z9td+A8Lxhr2H0VnD9jgKM9H0N8FKefcAvPaLALOueIPFzQrarETj0Me/JXPbw/woM8ZAC065PUTAwMmS0Pb1VUAwyPSGrEuR7onta+ol6/9/KJ01NZDD3GO56up3QoJFJX0mfRU45XsfCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KoCcZcBz; arc=fail smtp.client-ip=40.107.162.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFgyOdVANwlU/CMglBCfGrdjthHXWs1HBCWHFAlGf8s28TEwsmg6sTRqxuCHTbGJHoSOWKQWmqrv66Fn7P5vyQes/6v4HdDxuTXKpEGk6VnOc8MnvlVbEPCHmQdId+PfWaTL0X7vJK7tZu6Nv88TcU6m35sd8wy78f6IgruGBaoLOXfy61xoBiKVA6Qoxb6AzZYhdjczxzirm28e+d+HtASA5YJZhmeqd4Ryo8UHv6bx2YwsS1dF6HrmE9X9fOWllHsucW7zOee+hAFqcN6BXeevtKNLDTINtzhGFolAfn9yKCQl2KKRxHPrKI+w4HImxev+J/0/K+s3oC4eXgEXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ks3GaYUQoQnf0MRFt62uUtvf9VVJcq4obsEuDx93KWA=;
 b=fF9t5D6scaUS8zXZELQV+GOwwJLydOSLwc5TBrg2trWHak8Z+A6a1LYggn8YA7azBvJMMos/xgoRidwlAPdzb9xGgCCh4TD2hLg+koSchbxH4Bf/H07vlN6ZIyReAq8HEoZEQy1hbHXsnwCtJF/VmfuBpNnnmdUp9xvPKLvyAGJ4hhJuO2Z41v7MPOFa0gHOYNlj9nO0v5v0bhCYw+78OAI65c0iWhyL2+vah+5uWBoN12Tjp5AcpeYdt4lY0fCKX5YCcITV83NgXI4LR81rE8z2oMilWjqlYkEJV6qC8teoS8dIpblC5zJBwctR8RyaqQQAxL7ugaqwZiig1YLQTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ks3GaYUQoQnf0MRFt62uUtvf9VVJcq4obsEuDx93KWA=;
 b=KoCcZcBzJzeQWQUEnSXdBOIImgPMVBXWdXi22+IwsgcTWChcx56U/vLh5+quwD2KvdxLysM3XezhEhCkhzzJH4C6xx7508j0wXxgYX8UfyREnFlEK2/K27y4BrMKm5iZKY9NVEHUEcLLWc+dJg4dKLQ2vNqg8GAPqDPqELzbPH2HyBIJU1WWCPfl8ElSBo8s/6Z5L/TXKI9LD8CQ5ZmTPmOUoWAeLQAWNvdWY4OqsoxDynQ4maJcLJyQX+bxF1pHuLuQUPxd1YOHQW2kv/BKSvR3PRLuqmgB1jbwrVzojka7hZo/Wxj7BdFivKJH7dmxZkPHdYYeINA9rb/uy/XbDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB11867.eurprd04.prod.outlook.com (2603:10a6:800:31e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 20:51:57 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 20:51:57 +0000
Date: Fri, 22 May 2026 16:51:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] dmaengine: dw-edma-pcie: Add register offset match
 flag
Message-ID: <ahDB5reidqkhpMzr@lizhi-Precision-Tower-5810>
References: <20260521063115.2842238-1-den@valinux.co.jp>
 <20260521063115.2842238-10-den@valinux.co.jp>
 <ag8wETTj4HhAxGYX@lizhi-Precision-Tower-5810>
 <an2rkppyo3hz5g5vvpr2fy75bvarhj7aj75jh4x553yyu34eom@3y7vlucd2tvs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an2rkppyo3hz5g5vvpr2fy75bvarhj7aj75jh4x553yyu34eom@3y7vlucd2tvs>
X-ClientProxiedBy: PH8P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::27) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB11867:EE_
X-MS-Office365-Filtering-Correlation-Id: 977b9d6f-9d6e-4e7f-05f3-08deb843f676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|19092799006|38350700014|18002099003|22082099003|56012099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	mf9pUUgoPgpNCsrSYJHMIMinIIyNPM76czSJhxquDemYIz8YdEZGwnWR8cHLHuJWhDZOnmIen8R45KEY/eznCzSkNIBwiidzVbtK6qZsIdEuhGNQhPyceOO9IsK8NnoLNBn1duPifGAxeGf3SKl4SXePTfEKE4W3wO52PpVrvrYsU+RaqHgFTzZQJ9G8cs8802DuTOOnXZZa9ehDnRuhWEMaFovDgaJYY42bh5LdYaLUz9p6WlEszb6T++7FqXAcIP/yuiX3U8Hr3Nb+BC+RTbwH+pKzzhIX4VXxxhqenGI/R+0WCEDNQiogcrRuUFFqrGXeRQqtj0LuoDcMufo+QkZuf65Au0JzEflPV4+ZdGbBo5N+YfO8zypQedHItS3gbrwe8W5PwFlzwHeZhA8e1hru26mYmcuY24HUhUGh/no3a7v4gjoyo3ZHS8Kk99yrsT/KDnvBo7ZbiGtJa1/Fx/ke01oqSk1G8mfJv/izA92IJi+5Vy+uAL9FMUaIz5k9H3NkdIbK4dQWNe2qR2/YUObvVzYrpkY959CXRm9qpZXsWowJ7j/Ekv/tV5hmAMTUerqcyhs+w1HtvCl1+J0YWJ+96WncyKN8Cr/WlC8CT5mopKD327VDNao9ZPDxKOH85Fmi85EJo1XMOVlW/Y+UtL47EbN7I/IGP0ALxbKc6b9FI5jQI+ehaNZ0DecoUV5xP5UpmYuWlwg6j7jsKMoXPFXtIMgd+SrlgoIajO4sRyR28qUSlRRT+3O78gVeRjyM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(19092799006)(38350700014)(18002099003)(22082099003)(56012099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7t6ogTtNcNtfavyY4urHuZ+Roggbbbfx1suXVYek/D+thLfGYrOHfEFNnKk9?=
 =?us-ascii?Q?q2uqV8EzNIyh5wWNtQfN0Qckaxy7s1TqULgaAKdgs2DY2o5xCWRukQCBuZvq?=
 =?us-ascii?Q?eRDUMSazYkDXxPL2ye37PuzkvUFZTHTZj8QeJ6lynP5g92Fho7IMBlV4XdIN?=
 =?us-ascii?Q?klICT6TuvwkhjmXFICGQMNejeW9VCUNuawjGrDDPe6ieATRLnGdW0IO/ucnv?=
 =?us-ascii?Q?PYf/0lU0TXCBnm7ZI0hanjxvYpsJN8NVFOOQ+LHa7m1pM5jWL/eCXGt7vn+f?=
 =?us-ascii?Q?WbROFUveE3QkX8IBIBUO907lMfaridI2M5qZQr/L4kDT6NgaAf+MRazihOJa?=
 =?us-ascii?Q?BqDWviIx7LcVWoZY2DOmbfxszLuWDmnS8yhJQEsF+ePgW57jOHjiUCVQq7yl?=
 =?us-ascii?Q?as5wq8JiLowkco5RWSzKEl7V6QllsvurL03FR09n8S87qcq7dJ2JNfECx3wh?=
 =?us-ascii?Q?BqJnvEBKOqaXb0Kk34kuoaqfLwYAc1D2aOPGf9TF1GQycCHqST55nRy34Q3E?=
 =?us-ascii?Q?n1MVRquYNyCGea8R6LvDnDXPb/gw/yLvZl2VI/EBXN0ab9UNPiQNz0/CwMki?=
 =?us-ascii?Q?Pyf5a9VTqi6m6hW1Ifa2SaDOeAggo++1mFZhpc1Ar/fXmjMd7mIMHXvzSjI4?=
 =?us-ascii?Q?NfR04b9Pu0JCQVP7my+XKN9pkaUldWlWfQmaCAq8muo5kYNC4FuaxksrXBee?=
 =?us-ascii?Q?HQAqjyQHV2IMU6DE8cKfiTKfigYJrgCoANywpX09buFIk51/STao6W94jDvo?=
 =?us-ascii?Q?6noy1LF2t+Zs30/abUEH1Z7qtr2tsazVgs2T5pvPv05QWi2pg1rtYU/AD0iH?=
 =?us-ascii?Q?Bnzet12CfsU5l5dKxZ/43kvgRzxweU7y7SNI376J/Ip0sqcZweXhiOWwFG/4?=
 =?us-ascii?Q?MKbkw3gASP8nZd/rBdTHAgcPSOd6LSPkpiIP4E4cxtz/SF0oV7nmObtbV0oV?=
 =?us-ascii?Q?teJq+7II45xm9fRIUZca4Scyfz0eVT5UV85uGSnqQsasRTt+A/8KOUCLoWaO?=
 =?us-ascii?Q?3t2S0CB/nKrR8DbUUqZz7DPLXaFNniusXJRjuySa3poaUQBPpl7nwlGwaVWE?=
 =?us-ascii?Q?9P27V11UsA4h9KK/gRXwCLyDv6sg9f7GU6BuBiEPyBgS2JUHifRXE5Wwbgds?=
 =?us-ascii?Q?4oanF7iGzwHe84A0E6r/qi97QiZo3QLKcobd0A0P3uHvLf0QuIYm7qWRY86M?=
 =?us-ascii?Q?QTNyp/2+JvqIR4QSY7pylx4khRtOvpte3o/z3sQCRTKO9k1dHWBQD4LqLMQa?=
 =?us-ascii?Q?N4eOsXHVbnFVVZNYeDcYQWC1kcCmQS0PxKe9KabpH/X+ff3qJnKArpp56FdO?=
 =?us-ascii?Q?2eZ6J8ifOldSmTC53tJYnrc6jiM9ODE+DrjQRzvePE+gHdOj0lGQWQnk7n2v?=
 =?us-ascii?Q?fM5j3w5+b8QISSBfcPFYxtagN2lMai4vVjhF2NbSlWJfEH0bFuhtCbLiIAFg?=
 =?us-ascii?Q?CCskeUn+HSPmIO9fEBfPKIKrOmwQ+urp11oEB3XzcDg5WbV+nYMo3xDJDxsA?=
 =?us-ascii?Q?NUMa0rpWVL3xkAMrmBepH9uuxRq8p77Q9ObwGLQyG+aV90G5cxkenszaXLxj?=
 =?us-ascii?Q?VsdIpZPlvD9OsQorVkfBM1wKhEXdNs/n8min3A11MWN7Tc6bif/70t+IRv8x?=
 =?us-ascii?Q?dPa6FJkt1d2Mn0UZalvvyzV6BZNXMqZqOrCnE8atrWH2bsgqIzP2iBg4nkSX?=
 =?us-ascii?Q?6pK8GhcTL4IHcCVvwmkMGq+p9vtgoOYfP839l9CuIr7aV4WbDMjnVy5Ypi9N?=
 =?us-ascii?Q?KQkLEGlvCA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977b9d6f-9d6e-4e7f-05f3-08deb843f676
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 20:51:57.1662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFGgbzVW9R6aav5QHCBQs8Z7+tna4Lq+38hozvtx+8wLVO98a7ZPY0vus9ab7ErdM/Yys8DMdh4CwgguNPvsWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11867
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10768-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,valinux.co.jp:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 73AE05BA39A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 11:57:10PM +0900, Koichiro Den wrote:
> On Thu, May 21, 2026 at 12:17:21PM -0400, Frank Li wrote:
> > On Thu, May 21, 2026 at 03:31:12PM +0900, Koichiro Den wrote:
> > > Add a match-data flag for devices whose DMA register block starts at an
> > > offset inside the mapped BAR. Existing Synopsys EDDA and AMD/Xilinx MDB
> > > matches keep using the BAR mapping base directly.
> > >
> > > No functional change intended.
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/dma/dw-edma/dw-edma-pcie.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > index 651269708cc5..6b375a58c550 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > @@ -88,6 +88,7 @@ struct dw_edma_pcie_match_data {
> > >
> > >  #define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
> > >  #define DW_EDMA_PCIE_F_RAW_SLAVE_ADDR	BIT(1)
> > > +#define DW_EDMA_PCIE_F_REG_OFFSET	BIT(2)
> > >
> > >  static const struct dw_edma_pcie_data snps_edda_data = {
> > >  	/* eDMA registers location */
> > > @@ -450,6 +451,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > >  	chip->reg_base = pcim_iomap_table(pdev)[dma_data->rg.bar];
> > >  	if (!chip->reg_base)
> > >  		return -ENOMEM;
> > > +	if (match->flags & DW_EDMA_PCIE_F_REG_OFFSET)
> > > +		chip->reg_base += dma_data->rg.off;
> >
> > suppose default rg.off is 0, so needn't flag DW_EDMA_PCIE_F_REG_OFFSET.
>
> As I understand it, for the existing EDDA/MDB paths, rg.off is not applied to
> chip->reg_base. The static data has rg.off = 4K, and VSEC parsing may update it,
> but the driver still uses the BAR mapping base directly as chip->reg_base.
>
> So adding rg.off unconditionally would be a functional change for those existing
> devices. That's why I added the flag. Am I missing something?

Okay!

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Best regards,
> Koichiro
>
> >
> > Frank
> >
> > >
> > >  	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
> > >  		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
> > > --
> > > 2.51.0
> > >

