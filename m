Return-Path: <dmaengine+bounces-4221-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EEAA2267D
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jan 2025 23:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610EF162448
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jan 2025 22:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB821CDFD5;
	Wed, 29 Jan 2025 22:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V2mrEwU1"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D38199EBB;
	Wed, 29 Jan 2025 22:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738191343; cv=fail; b=Drxis5VzD2TFu80Seo/pPicredYaHmNAERxo2oCvb/sgw8r1QHkAkwtl06t+tzqBAwJKVCAJhAP+NLsETlBuY1Ll0wp5NJ3ibtbnK8aX+xiLVt4AGvpfbVIa67Lz8CYH5mbgdApp2VKQgxyjPAjJUeQ5o08Ml3Yn64R1CxuOgVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738191343; c=relaxed/simple;
	bh=rkLeMa9o+mz+V9grnMLACgEXeknnvsg+qbxRdUDasDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FCnnbQ0nGlOKB2huhi85czJ79KaNIe++8Tr/QMNj/Q0ORdCY521mQA6JhbVScjfmmJqCvDvhPzglKqn35QTiB7nkJhGMRujHOMz2sh8gbpyOotLgwdHn96SZ5G7oRnaFeA9aSIcEIig5Grh1V15TqPvxTpNQfgq3GP3DbnOSwKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V2mrEwU1 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.22.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJmrD9EOY9efb6Yn1Bz+CyPila9k/NSjAO7i1MCNWBto4GSlawW5vS4Jw6eTkheF89u1LrjnuHNkCAzWkuOpXyuDMHkKunXmYp7pYMKFiIuibaQkSYb4MJtMGQbAvnXfB4k+NGR8rPq3jKj9TvFMpYJY+X41Xut7FM+qc3TBs42liVbISVFJRtbxCO+bVBXtBXznR5FcWUXgmg8kfYuQvZYxCsd2DC9Y38YmHeTt7O38IY+hkOnMVH8/C66HVY6e9v15tBLGSuI1U39H9IbRS/mnoGisJir2fy1mKIIRcCQhIfr4IYEzKzx2H5qqnMgeFIGdVMZ7tf0dBHh20M4jlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biHWDTTEfkb8jp01HuWq1UU+N8Otp90ytJuqn77OjfU=;
 b=RLp6YfNpCfOSF0RObpeBaBq3DndaNqDzjHCKlSCH14H3Lm/vzZCBIvjxYDaXpaKGv0qgrmFe0LpoEqt0PQidW5OlR9bkAqZedrmUlYMhIPrF4vjHOheSySeezfAjJl8MQLRCYA6RBQ7VKHO0NgLjW+ZI/UU7GbaYZJYxiXLWSM1YPgzkgqO0jITemmls+Tf8fTdA6LdpzFlWolB1p+bYQsgXLANsT7Lwhef/yPgms9XS2jGi7ZhImSRoX7VO3XakamlUm4uL2ISHsaUTJMO8AGIFM2wSz43CkWqDggmlT5TYgx7PRVoJvoeHSUKCJuz2CkLI/FiBG5/A5GA6MAFGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biHWDTTEfkb8jp01HuWq1UU+N8Otp90ytJuqn77OjfU=;
 b=V2mrEwU19MQ/8CIUkxiHnBdTtBovNxGUdM6MvevmAM5v+nPf7Q5rabmneFMk8fdEzyLtz4V1WHs8HH6eCGtx+pzQhogxGgWHqty/iKa7px1F83eb/6qHJwe24QSi4jq9HLbpu9gFJcSf5Ws6N8SV3eGGokRH+NfdyKXJwKMkviOvD3tRWhxmYiO/2X6hA16YqzpTHZs3Y2TO8w4Cwx+9PQCirt/QzbrOl6iJl/1mw2zYVgcnG+RADlPcuJ16BYxgWW72BK4W8f3fG5bjTr4cCaVWzvwtOxnZE9ET+ty8PhsVxU75jDNXe/RvpFYK/xEhiz9NbsmvaKEOsxCWAv8n/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU6PR04MB11207.eurprd04.prod.outlook.com (2603:10a6:10:5c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 22:55:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 22:55:39 +0000
Date: Wed, 29 Jan 2025 17:55:26 -0500
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Lee Jones <lee@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH 6/9] dt-bindings: pci: Add fsl,mpc83xx-pcie bindings
Message-ID: <Z5qx3jAFE81Ni2cJ@lizhi-Precision-Tower-5810>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-6-50649f51c3dd@posteo.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250126-ppcyaml-v1-6-50649f51c3dd@posteo.net>
X-ClientProxiedBy: SJ0PR05CA0124.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU6PR04MB11207:EE_
X-MS-Office365-Filtering-Correlation-Id: 339fddb7-d33d-4d93-b00f-08dd40b80cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?af61QQBF/mE2wbQde/IryEFEVFJzkLWNBDdnSqA+HCertFjL9ooHZUAR7/?=
 =?iso-8859-1?Q?R0tmlTqsMYR6asv6+MtlWrZt2BV2Q2zre4NjwAo+rCHvy6dOMGireaRQJV?=
 =?iso-8859-1?Q?RTkekukAPYOnFiWk2Dg+p494PgknPlCZitF35Io5ucfzo/lcJVwpBzFQO6?=
 =?iso-8859-1?Q?Y3HFbyvXcNFrcKbTyXCiNpUm47y+cmhLvTXvgTFpNOkKfctcWGBwU/VMVX?=
 =?iso-8859-1?Q?msJCxrubX2SdKlhXSoFvxBAVaR+ms9O6rleRnUP4Vv2zwY6pom5Pp9w7V8?=
 =?iso-8859-1?Q?djKjWTcnYMxxQeMojc5uWXcTvDKsCOR09aZmaPYlUVAvY2ImORd/VG7HGg?=
 =?iso-8859-1?Q?8DoBrcwfEzOrn2Q69qvpMZC/Z1yeNesX7ZV/Cyh5H08EZMvqWWK5WZEGPy?=
 =?iso-8859-1?Q?2Op/yNYE+9AUPmp+9fB1KnzF5mxCTctUrdaZOVysfkKW/g0Qn9b+F+Hcui?=
 =?iso-8859-1?Q?I66FLreu+kdeJlm1fUA1NkmYm3MSOpJoKggP2VQdnDIYiR9MCUROEDCws1?=
 =?iso-8859-1?Q?b0DP7mcLY3wl52KVhGbZ7dankmCc++kR9zvhqkPpN4zIvxEQRl+FRHe4ze?=
 =?iso-8859-1?Q?O3vtG2dpxNBJHDg/kfRJADyPVUqdRsbe+hDpUnZPVW6ciH7Z2Gqr/dnDj1?=
 =?iso-8859-1?Q?9hUjwsSd2x3iAFTuqPYhA50YSswXQiMskiKNGXHL8ThuIrofBgspOJ2vtP?=
 =?iso-8859-1?Q?c9hOC5H9WDwxG6ySsM+G301/+fshZyJQ+9b2vGwa5ZEkbtrEmCDu6l4Z0j?=
 =?iso-8859-1?Q?jqShuHxQylXwRwijbelG8lzPeuzsyPVC5v66JCcp2+W1pZbCdB+2j6MfAX?=
 =?iso-8859-1?Q?4jqQRxvix87nIuQs6O7LckvDyQCfr4uck7Dt9kO0bNuhlUomosCjb70yyu?=
 =?iso-8859-1?Q?bjJFvET9G8HwKyALsorYzabp/S4kghh8jzDDkVu48oDDnPvaNKOlDyuvDP?=
 =?iso-8859-1?Q?aN3TUvi+eG829rh7+ANFMwj0jAwmFfxtuw33RWvRMIhu2QhYZ34HC2hBXF?=
 =?iso-8859-1?Q?HG4/JBMJA19ZmJzaVix5bHb6+HQpW4mCMItQAkjwnY4cDhIzDCbDJwK+xM?=
 =?iso-8859-1?Q?l9a0mKqVW9I1r6UQUj/R06V1hNaXaBLg6IlGkgqnQKwpB/aCERLfn6RCk6?=
 =?iso-8859-1?Q?vw136yPJNqM1Kbusag0Ymj5Atceh1Jb1RYxvb7Qb/xF06iG0KxNkLth2i5?=
 =?iso-8859-1?Q?s7lURb9jKrRezMemQqnJpeCW2ZIYsFKQmNrVJwlYc+UWfHXNJ1psN/xIRk?=
 =?iso-8859-1?Q?ADHCYhmP9Hh0gmMOzmp+aXUBRYrjbFNRvWP2vkXrWq5DH6fBgXzZgmYGom?=
 =?iso-8859-1?Q?V1r3VIdr7Bilw8WBt2+mOO7TMXRInnyVVyDTOcEa2E/zWszHm3Ik5gM8Xr?=
 =?iso-8859-1?Q?7o5bk5qeKl9WIwttQlsjuUUVBr07l6nb1RYS3rCOLB/AbilB96moBucY+n?=
 =?iso-8859-1?Q?/WNt1vZ5jEyQZip8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?/r9eJHUiIsEKR7a6uSXKKQk7zQjQgBVkH3B5bBlHVB0yWEXwtblicuKkv7?=
 =?iso-8859-1?Q?airUtMNyemGkFO2x3mr2S5HOP1Ay2+oO386BH4zs0QUd9tMcwFDoHytmEQ?=
 =?iso-8859-1?Q?Jyn1QdSL4dpc6I/WWEwbAw3fr+ROKHNL1j+bdHSmX8Yqh9rAVa6+xfREab?=
 =?iso-8859-1?Q?5RZmXuWznTjOxrT/U1+drirFHM/fhaAtCmj25l107uWDE2SKnqkbmjooEZ?=
 =?iso-8859-1?Q?HdRe4UyUGouQAE1vggkNKBVucOGUp3Djt5YfiAsmFMvCz2gSO8ZR4CQqTe?=
 =?iso-8859-1?Q?aIzdqN6pZRsvlJxYpD9LKVRab7TwnWMTu/8S6XJjmtdAovp1Eyo3r5XNLG?=
 =?iso-8859-1?Q?131tA7qfv2oyb8pT4rcNxVgsur55kQdq2lNpd9Ass/fk1aEKQKc5/2fL0b?=
 =?iso-8859-1?Q?ucCtdDFJEioFqfOiQ6U7wybYVn6UfD4cgiGb63bqSnpsMj8uv91aKEoWJ5?=
 =?iso-8859-1?Q?fyIoGvYaHtpk38N/Jdc3UqQp+6eYoq7cz/C4yfqzQyqev4h3mZPi3xDU+X?=
 =?iso-8859-1?Q?EWVU+SkbJc68H3XVrL99t8R1Z1z1LRfP5E5ZY9PXa5ThB+dkprovmfcL1Q?=
 =?iso-8859-1?Q?BS1QACk0BigYpKr7BFvi74lq+CESpVHGH09D+7ytRT6b1YF33AzcPR7+qU?=
 =?iso-8859-1?Q?fT2pw9NlUee/bLFu8PZmokT88RcmpIOdMJENOl5iijbQDUEJvjUTJv3RsC?=
 =?iso-8859-1?Q?2ZDrJCrokv9Bnk4IXIbsSVheC8EgTbE1cluAjx/sW0P1A4qZGX/5oGakvj?=
 =?iso-8859-1?Q?B7n6IC62NSHfoxzFE5TmBgBqDP5JK1DgUf3VXRbD+oAVhyjSV3f/Wo2k2V?=
 =?iso-8859-1?Q?GAWT6+pHbm4DIV6Cv7SmanO3nhQ4s/RSPZCBSwqYc6oesilPUdmzlJjdoW?=
 =?iso-8859-1?Q?lFI4DtRGAYZglo//H24h6cmH/UklnlVqCiisZtXf25A5x2f+PO26O21rjf?=
 =?iso-8859-1?Q?knG46YBHGJJ8Jodk3bC6lMHeF19okbVS7cLV2FRsPDpaPAKqLCczRK4BGQ?=
 =?iso-8859-1?Q?H+2wuOFRgBg/4F0BiBeqCDPMesZCTMKavmvMwYjd9aOJyBrKREy2wlSqKc?=
 =?iso-8859-1?Q?HgcdH9IhED0fcKGbZ1kLHIUE6OPC0ERvnGzIybw3DRK3HAB6DeZMzdcw7u?=
 =?iso-8859-1?Q?ae7HkCfqAzbPJvAmcRmwgymD1WlUt+gwzSoNtTCrMqpyyWTw8tXua6sXqD?=
 =?iso-8859-1?Q?E8ZQi9C46kK3cyv73YsARsX6TTwp+16TVmLS3Nws0uUdYruLDrJHheUTw7?=
 =?iso-8859-1?Q?Mbe0T3jGYPdZBfPz27PuXVf47ACkwa6wBgLuKlYwWZ8I+MeJw4bHUJkXxY?=
 =?iso-8859-1?Q?yM/hulmjEkmNbIH/p0e+WIFfbJxTYzkR2sweLtkrOZlD0xftbe7XXrXXg+?=
 =?iso-8859-1?Q?1TEmB4+aUkJ4fmY4vpQEcvG4tcTsOU0fdz72nrVSOPj5uZiBVKWZi/fbkX?=
 =?iso-8859-1?Q?zo9lmoR41RyK0mqB5BxlRu2f35LrhfxfuQbskg9hsZGv33zor4liXgO7kU?=
 =?iso-8859-1?Q?qMAzQxHsDsu/2Cu0TikKnK4ZK1wHxQIs8tUe2lxP1FQt599ZH9rkkW7p+g?=
 =?iso-8859-1?Q?zDgs1XjmmmrLqAmh02wqFYoV9q7+HmLfe8GB6iZvM13w2nChjzxP7H2/t7?=
 =?iso-8859-1?Q?4PGAEN3tLOb5nRcIupkhl7bwLphaUaUnUc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339fddb7-d33d-4d93-b00f-08dd40b80cd3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 22:55:39.1003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fw3+x2WyhgvMVE5tM7JYbycE7lCxyj5MhEtW0+PnBMVTjoHT0p9/uCXpg52Q/das5DBQRWSHWr1PBIpoYKEa6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11207

On Sun, Jan 26, 2025 at 07:59:01PM +0100, J. Neuschäfer wrote:
> Supplement Documentation/devicetree/bindings/pci/fsl,pci.txt with a more
> formal binding in YAML format.
>
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
>  .../devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml   | 83 ++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml b/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..12e86a9c20dfe2362d11f085bd9ae47238c4a37f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/pci/fsl,mpc8xxx-pci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale MPC83xx PCI/PCI-X/PCIe controllers
> +
> +description: |
> +  Binding for the PCI/PCI-X/PCIe host bridges on MPC8xxx SoCs.
> +  See also: Documentation/devicetree/bindings/pci/fsl,pci.txt
> +
> +maintainers:
> +  - J. Neuschäfer <j.neuschaefer@gmx.net>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,mpc8308-pcie
> +              - fsl,mpc8315-pcie
> +              - fsl,mpc8377-pcie
> +              - fsl,mpc8378-pcie
> +          - const: fsl,mpc8314-pcie
> +      - const: fsl,mpc8314-pcie
> +      - items:
> +          - const: fsl,mpc8360-pci
> +          - const: fsl,mpc8349-pci
> +      - const: fsl,mpc8349-pci
> +      - items:
> +          - const: fsl,mpc8540-pcix
> +          - const: fsl,mpc8540-pci
> +      - const: fsl,mpc8540-pci
> +      - items:
> +          - const: fsl,mpc8540-pcix
> +          - const: fsl,mpc8540-pci
> +      - const: fsl,mpc8548-pcie
> +      - const: fsl,mpc8548-pcie
> +      - const: fsl,mpc8641-pcie
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: internal registers
> +      - description: config space access registers
> +
> +  clock-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - reg
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    pci1: pcie@e0009000 {

needn't label here

Frank
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        #interrupt-cells = <1>;
> +        device_type = "pci";
> +        compatible = "fsl,mpc8315-pcie", "fsl,mpc8314-pcie";
> +        reg = <0xe0009000 0x00001000>;
> +        ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
> +                  0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
> +        bus-range = <0 255>;
> +        interrupt-map-mask = <0xf800 0 0 7>;
> +        interrupt-map = <0 0 0 1 &ipic 1 IRQ_TYPE_LEVEL_LOW
> +                         0 0 0 2 &ipic 1 IRQ_TYPE_LEVEL_LOW
> +                         0 0 0 3 &ipic 1 IRQ_TYPE_LEVEL_LOW
> +                         0 0 0 4 &ipic 1 IRQ_TYPE_LEVEL_LOW>;
> +        clock-frequency = <0>;
> +    };
> +
> +...
>
> --
> 2.48.0.rc1.219.gb6b6757d772
>

