Return-Path: <dmaengine+bounces-10297-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLUnEZoQAmqIngEAu9opvQ
	(envelope-from <dmaengine+bounces-10297-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 19:23:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B065135B8
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 19:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDD703067701
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B42E42882C;
	Mon, 11 May 2026 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Xl4vxTrT"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011001.outbound.protection.outlook.com [52.101.125.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9105E438FF1;
	Mon, 11 May 2026 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519091; cv=fail; b=kPl0EekZ7NYixjSRcCqQVaiHSqOvFm/2rrQ8XP7PlUVasqnz4FwLkgLoadX15VtEDjIhJwyRKH1pYh7oDo5SmK7V5XpvHo8T4L9UQS4YsUC3eaP+zlbLmRYllaDKjbb3cV4dGqXTyYkOOaDwoePq3clt9y4T0fOjFSEcU0lfd2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519091; c=relaxed/simple;
	bh=6bvDgZXczY/O9HJB3UtERjzpdaX50+ACNBaQTBpRDKc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sbub76KeLOgZnQYpDoaTCe0ZY7XBqKgMuizpZd1H3ecgPOCmA1yy9fvsmxXZ0LvqQhvT0jymKm2iwMBBvQxtVsTJ+B7X1uZ9+8ArPMIzLFOew6wkDDM4nyEj4HBIdrykHYD5MMIDBoFC3SryrokguGkAIUeQybJ/gMLDFGPDi88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Xl4vxTrT; arc=fail smtp.client-ip=52.101.125.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L04MmNoKh/CNsU77jJMsCWE5c/vEC+4TM9Xse6bRO3ciBarPgqPs+iDXKHf94ULvCh9lpNF8Ihn9tiDjZUipSJZTXL4NoytHG4GewtlK/OZ6DNzJzw8iMc+O9J6mkXlKK9oTFFVMvhxEsExu4z4zV+89Ht2YGZegYbhs3kmwrABCISDlPZQJcI6j2PHQ5Q4/9n/5hbv0iiM8aai19S24UO7/YmJJmZKwAm1QTmVtXIibBqz6CcFHWxmUiBfy9oqfL0Cu16Gffgynf88kBGw4JCF5NmOCp+hn/SExBP9KiG+WaiYvqvez31O6x80QHwMdMcfwbiCUUfTnzDljG4TXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+pulaKgnOFfCAFtJf3Xg/wI8BJRvyD+Dv8fxkmiiTU=;
 b=Xka5VxJdEVu93n84C0Rpl1ff5mnGwW4hXC6aXNPijmBElRvWAogyKdcPyNXTb2rpdQQ6Cu0L9eMR9Bk6FhPip9o2mDdoUWTDuSG6b0/9/JXyM11pgyxRDoiKCi+UDR0vVtSj4ZUe639DCTVsrSde3Yy8Q8f5eBWc3nIsWtMMKrQMcgdR4Ff7C0zwtt8RZnIDN8iDGHLP5Fv6DOV4nCHAb6KkAVTyGKmPBUgxPuK2aHKMnoQG+2GBKxHRUC7UwXxtyIpYsY++0IBKSshApimvSSBzbyAS/TbS2mINcDKwStzhp7ImkSn6yk15pntoo8j8W1zBq0PfKx68xMkaVzNzzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+pulaKgnOFfCAFtJf3Xg/wI8BJRvyD+Dv8fxkmiiTU=;
 b=Xl4vxTrTTJ2bUjGUaXSJXg+Q3PNyy3YwAP3tnlseucYpL2SrPS4rzqphFhM5l4AIz3BMuZtyZ3Ap/U2EExaqqj+VwsxIgmKLqbNVxPN0kCT6X4SUKy2+W7wagATHiyOXtVVGAJc5JijeixJawf9LXbF1uhz2mczxb0ErIfMQhRI=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYWPR01MB9805.jpnprd01.prod.outlook.com (2603:1096:400:233::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 17:04:46 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 17:04:46 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Frank Li <Frank.li@nxp.com>
CC: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>, Biju Das <biju.das.jz@bp.renesas.com>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Cosmin-Gabriel
 Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, "john.madieu@gmail.com"
	<john.madieu@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCh v3 2/2] dma: sh: rz-dmac: Add DMA ACK signal routing
 support
Thread-Topic: [PATCh v3 2/2] dma: sh: rz-dmac: Add DMA ACK signal routing
 support
Thread-Index: AQHcwrz7giR0TZZcU0CxiqXIcEVt7LYDHuiAgAYkrZA=
Date: Mon, 11 May 2026 17:04:46 +0000
Message-ID:
 <TY6PR01MB17377AEC612CA33F43C1F4A8EFF382@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260402162212.12016-1-john.madieu.xa@bp.renesas.com>
 <20260402162212.12016-3-john.madieu.xa@bp.renesas.com>
 <afzep7hF8uj-jRhc@lizhi-Precision-Tower-5810>
In-Reply-To: <afzep7hF8uj-jRhc@lizhi-Precision-Tower-5810>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|TYWPR01MB9805:EE_
x-ms-office365-filtering-correlation-id: 89e35288-640b-48e3-f910-08deaf7f673e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|11063799003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 u+abmVKP6Sw1VuuQGxc8dmohCp5i/mNz1O7A4VOwaOA/GhcaRg7Q7cq2CgBsMLLZFg0a7IWpp4+JGbQMcepZaMGiKNkMiea+/RJPheyCxfFBoze1vTfC8B8DDepy7tlNNZAoa4KYe+chcEfX+2RAsHdut1yKYojHnNBZK8CXQnR8NmxTuUGlY8YUj6nk4EedkLoNwhqJUMGXDj5djiwC2x86mpseuDmTsrvvgTaXay+glSG8hVpSVtAW+EauAqA7ga1YlrnoU8FPe52/Pc+d2IaKwYJ8owodA+4/xTjdc5u+fY0hbI1+6yMwTJvX0prSwxJeRPqZk3tI0iyLMAQ3uqCQIHVK+pdZ7GXg7WpK1mm3+wcaAmPTWwyqZXvwdQtCOFkn1wr4H9khGKMOJCtT74nr/d/kwjKFxMxt0MNSKt1B8GYtASjwGkptDf6n6ab+LaFRhFbUaZ4p8Q/5xlIAihVmPS58gp6Rj2/uiDhT4YPcd4AA/pGZJ1s32YSP2/VX6etN0qJf+r4FTR1ETArTqoOCgkK1elNk5Cxa+CNTMmar5MvPfiVK8TCwUK2XfsqK1TvGNWZjlINv+LlmhZBnuk4Jphp3lBy94CnnXbJ7+Dm6rBNkBt5FBdiOkd/bFOVpajVK3WMRZzjJ2hbyMvGNDeB2FJJKdUIK0uSGHbWnyTl2a37v0kk2+UBvRHQnShSrd4GzTJWGqq+Rz++FehSVcMTmmQe68MDeHT9dLFVvUMhKShh5LIbktKEIE3JWOIbs
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(11063799003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/HWfqCuxof861ioA+wCvkNDodjOP1qBq2tVd7s1c9uQoT4Vo6pUjVrH0nfKY?=
 =?us-ascii?Q?1D7O+dYupl7QBe4U0oRvGv5hFkgT55AEPCL9HKD1oImzkSd1LMrPNaHKSEtU?=
 =?us-ascii?Q?9yNHG75f0v5hdgn5ResTxkXdzvoOskXpVJJAD6pzE8MKcraNapqUxfXjms+A?=
 =?us-ascii?Q?WX18ie8n3VCFYClbs+AZ1PXQKxA2bD7fKPf9zfCyKnO9ZS2XB+WycS9Shheh?=
 =?us-ascii?Q?t/7xL6gC0pz+tMiMguhK/IyhLhXlRVDekAX857zNtc++DqsTCan80bPgO77c?=
 =?us-ascii?Q?vlVFAAFzsU/Ubx0wdECoGFinptHYuODeJwIFH6cfzLAqk3115HJuVR2fH2vg?=
 =?us-ascii?Q?3upHu98Utfm8GRABL54/i/301ElGjjl7Tb9JPhezpa+abqdUC6v96abPsj+k?=
 =?us-ascii?Q?PkddvzW07WTVj8U4w8NrbJ4NCasEyd5NATL73fpCFxsRHulIFyoOW0jCcjrx?=
 =?us-ascii?Q?md8+K9sch756KThsrY/+of9C8dn9RLvFdYyRZUnaXrXmzmlmZLdLPZzyKnAM?=
 =?us-ascii?Q?Y15tgepG4oVTn2cG6L/F+/iXJbdmgh5B/kYalL1j/Cb/q0F2CJs2/Dq1crWz?=
 =?us-ascii?Q?3GsVmqgoxsuXtxaW2kRff+ZMkRNBECD4JnAT4NXwU9fjyEbsU79arAHUDk/d?=
 =?us-ascii?Q?n09NhdH1Wjqvf3Nf/4teLZBq1AQkFcCKZNXBcg2uAOkiz8Wp9U49AfPSCV+B?=
 =?us-ascii?Q?KFQk4JGIUavTKYXXxOXNVj75Ki8KYOT7XV66GGg91DUSIjDkoe8RrJgXb8bu?=
 =?us-ascii?Q?fzQQkIDhie7L8ALS93otkzmIPjKpv910/8YsmQjUe3L4+bPQ/3d/W6uo4BOJ?=
 =?us-ascii?Q?wqEDjoo2h3YBUP8lGlpHxxuU1/IOqpTTJ9KEakXX/LMX/pZnu4pFYCUsdNOq?=
 =?us-ascii?Q?1flRHgDLT/9v7VTVUtSutIWXUfHP2Rys3ChlEhluzVtoBAEiTuFp7H8sb8Dl?=
 =?us-ascii?Q?SGzwPui0nzLxYaMLzwXGg0ADqIQBQqQvFfQZvL5ExoF9xOTlVWvmGgbh2K5V?=
 =?us-ascii?Q?Bn1RedZBYMi67m/cxVaqNQS+eNblq9e8btVLmnTADb40/bCL2FP4i/O7wOxN?=
 =?us-ascii?Q?pIX5/hCPsmHNGXv2EhnzkVRD7oaNsefKHF6akRjMiEJigbUl2JBFkaOY0EXG?=
 =?us-ascii?Q?dtNLq0usW7ivMWhza8ORn9MNxr6Enj/cSiwIjR+rZyay9HEiKys8jgZATPU9?=
 =?us-ascii?Q?TvIx701llJSaw6iDPoKBM/B8zYS7ZUi3LTMZzJj32kBdEs9RCz45lrNQkEdM?=
 =?us-ascii?Q?iXQlZOePykRdrGpV30B7pg7GPmesZMZDSLuDvgLK4qc/iDf4wgnZD2aMoIxa?=
 =?us-ascii?Q?ny8mQXAFSFlaa5UHfqyWibe8Ex1iVHcPwLN6CEHxul/+qHcviCnZMg+Y2byx?=
 =?us-ascii?Q?eOOPDL8Xm8kZRvr93jDxHBV89wULb1TkqteM2JDUKheWsao7cHUKLQGXQIuJ?=
 =?us-ascii?Q?LcyMTKV1365bCK+Q26BjGxMA0GUip+8pbwOVXdS1gcRylEG54fsfbvLNDXVz?=
 =?us-ascii?Q?wOt95OeIskbeAmu+yFF3ZRikdLhf3pKvfPNhyO+p3X5P0Nad+XQLo45jF5lL?=
 =?us-ascii?Q?tZJxUduNBZyaWlllaspPd1L9EpBmPjcubHyv4PcqCiip7Bjf3Z1zVYW4VUxh?=
 =?us-ascii?Q?Dzy0WqfUQWwHZt8dpQoyBSRt8AxYVszNBpx6rKsrAIJ2sZgBi11bD3OFeZYn?=
 =?us-ascii?Q?XCp4roI0uSpxn0rcmj7rk4e+i3ll3K7o8ZPE5T/LBGGoy+hjuOCkOPH1+/pr?=
 =?us-ascii?Q?xAUuFXJ3y7iowJilCOlBISbnheAzpMU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e35288-640b-48e3-f910-08deaf7f673e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 17:04:46.0591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GuTEQaBCBNY7ljFMiBBD0UB8RMOJjABbAa8L6It2k4GLQ2Ckswt/o/DU2SEh9CE2KuFjjvlHackuvUu7VIPCHXNiDNNi49fQLgSVprIn4Go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9805
X-Rspamd-Queue-Id: B2B065135B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10297-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,renesas.com,tuxon.dev,bp.renesas.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[TY6PR01MB17377.jpnprd01.prod.outlook.com:mid,renesas.com:email,bp.renesas.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Action: no action

Hi Frank,

thanks for your review.

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Donnerstag, 7. Mai 2026 20:49
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCh v3 2/2] dma: sh: rz-dmac: Add DMA ACK signal routing
> support
>=20
>=20
> On Thu, Apr 02, 2026 at 06:22:12PM +0200, John Madieu wrote:
> > Some peripherals on RZ/G3E SoCs (SSIU, SPDIF, SCU/SRC, DVC, PFC)
> > require explicit ACK signal routing through the ICU for level-based
> > DMA handshaking.
> >
> > Rather than extending the DT binding with an optional second
> > #dma-cells (which would require all DMA consumers to supply two cells
> > even when ACK routing is not needed), derive the ACK signal number
> > directly from the MID/RID request number using the linear mapping
> > defined in RZ/G3E hardware manual Table 4.6-28:
> >
> >   PFC external DMA pins (DREQ0..DREQ4):
> >     req_no 0x000-0x004 -> ACK No. 84-88
> >
> >   SSIU BUSIFs (ssip00..ssip93):
> >     req_no 0x161-0x198 -> ACK No. 28-83
> >
> >   SPDIF (CH0..CH2) + SCU SRC (sr0..sr9) + DVC (cmd0..cmd1):
> >     req_no 0x199-0x1b4 -> ACK No. 0-27
> >
> > ACK routing is programmed when a channel is prepared for transfer and
> > cleared when the channel is released or the transfer times out,
> > following the same pattern as MID/RID request routing.
> >
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > ---
> >
> > Changes:
> >
> > v3: No changes
> >
> > v2:
> >  - Drop DMA ACK second cell from DT specifier
> >  - Derive ACK signal number in-driver from MID/RID using arithmetic
> formulas
> >    per ICU Table 4.6-28 (3 linear peripheral groups)
> >
> >  drivers/dma/sh/rz-dmac.c | 72
> > ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> >
> >  static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan
> > *channel)  {
> >       struct dma_chan *chan =3D &channel->vc.chan; @@ -431,6 +489,7 @@
> > static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan
> *channel)
> >       channel->lmdesc.tail =3D lmdesc;
> >
> >       rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
> > +     rz_dmac_set_dma_ack_no(dmac, channel->index, channel->dmac_ack);
>=20
> I am not familar with your hardware, why ACK folllow req immediately?
> suppose ACK happen after transfer done.

rz_dmac_set_dma_ack_no() does not fire an ACK pulse, it programs a static
routing mux in the ICU (ICU_DMACKSELk) that selects which DMAC channel is
the source of the ACK line for a given peripheral. It is the symmetric
counterpart of ICU_DMAREQSELk programmed by rz_dmac_set_dma_req_no().

Both registers must be configured before any transfer can happen on
the channel: the REQ mux routes the peripheral's request line into
the DMAC, the ACK mux routes the DMAC's acknowledge line back to the
peripheral. Once the routing is in place, the level-based REQ/ACK
handshake itself runs entirely in hardware on every burst, with no
driver involvement per transfer.

Maybe should I reword the commit message to make this distinction
explicit (routing config vs per-transfer signal).

>=20
> If ACK need after req, why not add ack handle in rz_dmac_set_dma_req_no()
> directly.

I would prefer to keep rz_dmac_set_dma_ack_no() as its own helper, to
mirror the existing rz_dmac_set_dma_req_no() path. The surrounding
infrastructure is already structured around per-routing helpers, and
the ACK additions in this patch deliberately follow that pattern:
.icu_register_dma_ack/.default_dma_ack_no.

The two ICU registers also index their fields differently. ICU_DMAkSELy
fields are indexed by DMAC channel and carry the peripheral req_no as
the value, while ICU_DMACKSELk fields are indexed by the peripheral
ack_no and carry the DMAC source channel as the value. Folding ACK
into rz_dmac_set_dma_req_no() would mix those two layouts in one helper
for no behavioral gain.

Regards,
John


>=20
> Frank
>=20
> > --
> > 2.25.1
> >

