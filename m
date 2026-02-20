Return-Path: <dmaengine+bounces-8997-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHXVFgTEmGl/LwMAu9opvQ
	(envelope-from <dmaengine+bounces-8997-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 21:28:52 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1009816AA57
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 21:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0373530233EF
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 20:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B8D301022;
	Fri, 20 Feb 2026 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M/z8vHuO"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011068.outbound.protection.outlook.com [52.101.65.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EC82FD1C5;
	Fri, 20 Feb 2026 20:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771619325; cv=fail; b=cfYPkzCLOHuP5vMI+HLLyroorlwJ/SGs2CoNbwcXEE8e7T6SCp1kSq0ytaF1pNfE6J2KURPEtudwdAUF/OrNTXgb6Qd/mu1Dd/0fid1gTNVGdZsDvGFbcbWPqB0xqLF0vGuJlETlvkHMT9QPJ6CC18qtiZdBbyaQXDHIhv5zTpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771619325; c=relaxed/simple;
	bh=dnY6eCBRYh2/HgqbQ1eI01wy3WMysxBE6Ce0QuTbIkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ny219JvY3iQ1r6muX2LVZCDovbYIklLzmzqgwYQlJ42HyUzDHvarNKltnzT+HNB/2Uxk5qrPlqTGp+Weo7YHDXYXprLa+kW4aGatFyMe8FJlMDYH5oNZS2GGC6Q4Iy5rS+/CT0FRzlOn6b8x/cKlk/UM1WzqMfDrIqSylV4wCmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M/z8vHuO; arc=fail smtp.client-ip=52.101.65.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYXz/Y1JJHfwh7I4cyY05DrhTyEck4dOY5PWqe2h1bJcGLi4kdQRTnH18j5mkJX/Eh6SwgrZpG/n4h3lcO6vR4OLNaTqFFXsqgeDRgLdL6MmdLaOTVI0x5W6JuZEAqEr/ae6/mnm12r1kYYwEgz1zcDqoChhRBryRm93BahoU6OY1rfLZjtNZmhyeBMPGrTLWsF+VF99VjPtCN+m5spNHtIpeHk0th7KSMD7venGTS8kdW6i/JaQhNTWf2s9glK0cuZ4slDI4yBUfxdoHzY3S5kbb5K9BydiTktIFZLG9V1z6WeIpGooMxtlYur8HINUtyazKCyTqb0x8/cBI2sMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FjPo9rx72ZjNVQxdBwS+aJ7sa33tHErjiWOERYC8sU=;
 b=bYANVI+YkMLd+bvFLlbeAFEGeubZsk6fMU/eyRonYo3EdY+4xLetxpY+7lsCMRxPJ8R6xRaNTecGWmUvfcdjA94IGah7zhE39/G1rJdBKrLKGJuFgR2UIB6xbQsd/dW/d0xgELe9ggr5K1v5iNrdTWFG+2Q563QEsYpX0l6DslqXawJtd6WP9jnLnSnzja8WRHMYgZiW3QulJ1wnMXEO1Tf6tbu7hhlxzWaXsMt/j1Mc/nteW48FrnjxAagvKJ6RZXBe+ki9cgKD+IPmTdWqDThoiP18Qr7uR0sS4akhxMr7L/QyON6uDpg3mabSFQMJ22tvH7qEZWSrJTcR9pn65Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FjPo9rx72ZjNVQxdBwS+aJ7sa33tHErjiWOERYC8sU=;
 b=M/z8vHuOMxRn5dtu7/whegKLBDLrvr2hM3tdtSBVCU7Ei92QAWN6/c1r5PHif1vP/FnTxUrxB6wEmKw1aZDoSTBZlXnjLW+vEEe1/gv9nn2I0uvcXWG6YdKbg9ju2skwk9iZVmnXtEaYY+I453CrHdoSmEK8TY+8SX6NCbUIOFBBWi6z6YC0mfTLq2a5bnO10Ap7jTrwWX5k3F2axCfVKiERR5z8d4hITQPpZ8nhSLCeAdiVFHj7yOxZjqG3E29jrwlxokePyTp7uK9cPomi0rf2/xpi9qs90+aeab8rWOq1FI5xXS/eIYm/n95CzhN4y/TwvDZMHl1ww4cu0nlbhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB6787.eurprd04.prod.outlook.com (2603:10a6:208:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 20:28:41 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 20:28:40 +0000
Date: Fri, 20 Feb 2026 15:28:31 -0500
From: Frank Li <Frank.li@nxp.com>
To: Max Hsu <max.hsu@sifive.com>
Cc: Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Green Wan <green.wan@sifive.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Palmer Debbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	devicetree@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/5] dmaengine: sf-pdma: fix NULL pointer dereference in
 error and done handlers
Message-ID: <aZjD70pK2dXLP9vJ@lizhi-Precision-Tower-5810>
References: <20260221-pdma-v1-0-838d929c2326@sifive.com>
 <20260221-pdma-v1-3-838d929c2326@sifive.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221-pdma-v1-3-838d929c2326@sifive.com>
X-ClientProxiedBy: PH7PR17CA0052.namprd17.prod.outlook.com
 (2603:10b6:510:325::19) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e7ec19-c70a-47f4-f159-08de70bea236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dJ37hdHuRpv4ciMyz9WyfyfMuxAvCt5d7ASmolc9MVEURMfVArIJu0q7izfV?=
 =?us-ascii?Q?OqCch/JiaM9z1CLxS2vDLgKh4lk1xOgfnlD0tQO9r+irQXT9XznfAJ20q9md?=
 =?us-ascii?Q?KUQ3mB+7Gw++mHB5AwBocxupXPY2kE27PqHvSYGPQAGrf70quH4MLh6N1Yk7?=
 =?us-ascii?Q?nZaKXiJu1+YqTIR1EAL0PaLBUsbdXURhoOXWJPL+4P9sGhHCUGEmRgNa110T?=
 =?us-ascii?Q?GH3WFN2AW9DjTdu/e5t/UBXL0gG3H/gBwrTsQ097FiLiQM7K+wCHUKTLh6LU?=
 =?us-ascii?Q?iYYI3uEhVLOvTNdIqhL3RrDKVxZr8rQPEf1DX3qTBhEkYTxbvSRP/1CpGJtv?=
 =?us-ascii?Q?BeCdMSEhEF6i9JGh8jjPCbWzJ4kJ/XHhpDtN38PmaFNDTpgowPezODFURJOc?=
 =?us-ascii?Q?5jc6uPZf44XOeZP5GcBC1bIQqgKXUtc/u8HdBJt9amdrNmJCaQdM4Fn0cjlt?=
 =?us-ascii?Q?BM55VoZjpOoS9nH5qWY6JcbUFAWfDf9mlj8uIGCRv25I9MRLKbhxZHGi7Twf?=
 =?us-ascii?Q?ri1AN+RCm8iMbXOxa0mMJnevU5ob2/IBd+fqDUceIHq79wLnuCXYK9LP1RFt?=
 =?us-ascii?Q?+jTl4izWy0hbudZDQ5uORgpSdOC9jM58IQn58sbjcO4i1lKufAGQfuloHIuv?=
 =?us-ascii?Q?IzJVfmtBDD2DHztjjbcK7JuOs6dv3eF54WlOXqH2ht+++QqTkVcWdhztCoT1?=
 =?us-ascii?Q?U1JDh/8l0TAbPd2O6fDHBlXRJg1sRktN6Up3oMkDMBYXK6n+C6KJm+4yLIlg?=
 =?us-ascii?Q?eb8cEmAKkYWr7rK3h5P39pEPAgrMCUUIz1oQv+0KNWzMjtQDwEh0QEUc8Hbq?=
 =?us-ascii?Q?qhi0Q0bxIPQlzJPoPDBzuzTdAPGFDxgepB/m/DwhwQas0kw1tFnntFXanYQY?=
 =?us-ascii?Q?4kgUiSdgcDdaKEDQL0rLhb9xSEe487+3pjfbdXdgL8C+3aIVaY/vmsWrwohl?=
 =?us-ascii?Q?4y6AYDfdlkjxjDj915OmLlrqNDE7szGhw+W2txE9QHfg8C5bl+T8KmGzAD7C?=
 =?us-ascii?Q?+6CGJRxDtzCjIiLHsAom6ANOaDjp5xMqpCQ/HQdIENDSUOjue1d6/POSqy47?=
 =?us-ascii?Q?oQ1a+Hc3MehASdoa28V2LGLWBJC0po9Rup6cGbYmxYwOpfUqO13wMJqFB7fc?=
 =?us-ascii?Q?XU7zZBp6v5qAbXsp0WZETcf2H+PbYHJI5Dd07Df04uUqwrg4MiL7TVKPhqXd?=
 =?us-ascii?Q?fGZEshg5TVSXdDymHN/7WR78E0vEcAgJSnKM3yCOAmJbO6hiWoXpdeRGCYpb?=
 =?us-ascii?Q?ESlpl0UU1IVmBfNp8bA7zGx1weaY679op7pzdUJQMYdwVU1AWDrrkMNyNenI?=
 =?us-ascii?Q?jeMo+QQ36Crr3u4BJNb66yqChKkOn8xDy+3zwM8eSGJw9IoOkmmF8Xa1P0ag?=
 =?us-ascii?Q?JBGeALNoXWsALmKF354iT+N7vZAcyidkB7s37oOG27+TNare9+5QJJ8LQcNr?=
 =?us-ascii?Q?0jPCkPNMHwqH7WU4KauWzXUt4IQSXdY4DEuYjhBMrTlFVI5ocuXE48HStYbD?=
 =?us-ascii?Q?cHs4kB1HqOwZMjouzymf2HBcVHEPtN+B4oGNYc/lDD6VxMUacyWjx8XyRDu6?=
 =?us-ascii?Q?2hh14r01c2UnfCem/XWs5ElkPAmIx/UjfNbq1BvXlxsbOcWvrdewBEcBJDnR?=
 =?us-ascii?Q?3CqAnLenzBvcl+qJpX9WqqI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+eQuB4B0QR4qDp78VbeSfSimYeRA6RhbyEMKYBQ4edX2j0S3jGnFWkbSiRTl?=
 =?us-ascii?Q?BkKPs4Oauuaxtuk2rHHjHBJYWzCPxRv6cBLSfhmwIllC8HxBXti9ffPq9/hJ?=
 =?us-ascii?Q?5ZixiQv5BX5OemdlfJuZaensZKbaEF9jMgF+ybE3ojXAU0f3WHZvuA/1fFTk?=
 =?us-ascii?Q?fHTawhnR9i5YR96LfoJckhMPcpHEj5A/zXeqgMwdMVvjBMDwBkzg/p1sPmxq?=
 =?us-ascii?Q?IWjZjH5omJOr80vX1EYGLSxqGLXvzVSpYxVv/kMIMwHBQfDAOjuGXsW4gK5P?=
 =?us-ascii?Q?/VvfTqM87dEZOr1gjFT1p+E12wxzlPmu55GZpBaAPN/8ctIqamvkDvknr+qH?=
 =?us-ascii?Q?vKA+PAko2RGuhTSvMroHFvvBmFzDe4A6/0CQFdWaXJ2Oon9B8rzfj85NPdhb?=
 =?us-ascii?Q?CpzKP5jYPDDPRLJpyQdWjaA7+/hPp/VK0MtZy3LNlezuf460RG91UimOH0J2?=
 =?us-ascii?Q?CCdvtgm5MAGvb2IFEjg13L6jQnaHDdfT+Ya+S2hu3HTWygXgc86bIcCatluW?=
 =?us-ascii?Q?oJDUs6kO2GskkuAJcJGeSzGxeD/1qyb0nmYSiWFXYxjm35zf822J1BTlGmoA?=
 =?us-ascii?Q?ycGV/OcDpHFd3b44EVmE2Rxh+mNKXc3R+0pPA1unFsMdWDtDaGpP3afhG8br?=
 =?us-ascii?Q?StGEC313hfYOo5osK9wDquKSyPUY/SWvdhVFPgQQuQjpWJgBiyCykQslrJ5J?=
 =?us-ascii?Q?/dWFqmfR5aY5jopfWSl0IarudB7amvH7jNJvtgGRw5DLLXqOFHlEicLhqvCv?=
 =?us-ascii?Q?D3y9vLxjvHlEm8vMS4pbhnsFBJCcztAkzTr6mgDeNu+4/4ce0HJsFbpAXbjf?=
 =?us-ascii?Q?R4jP0XABzIUHxajtuxU/WUPp22VKiCSkC9vWNiTO8nI2hSRs35atT5yco4rf?=
 =?us-ascii?Q?FyJkxhYjIyaZ5XI33LgKox/zgyj41746RlZpHbAyp+IPH00v+TBRvEVQMzwf?=
 =?us-ascii?Q?xH4Lk7oM1kBNXrf0qBLibwQvBfglUhzAz2oEkDBDfvdOCr1Y/Id4prs8QsFJ?=
 =?us-ascii?Q?xoA+bwjgQSV3JsgJC60bIXRflqW2FIi068NxrKekU19cM582VBpH8ZeMnh/N?=
 =?us-ascii?Q?zC+xIvPxWt1H2pc8j4hMwjt2xpPgiWuYzLtvakmxBk9KXWF6E3iZMi01pNcX?=
 =?us-ascii?Q?g7PAxsbSPZtbjb3K3tkX4XZgNHZNPzTCiP6rcKDlInRy6P6JvI/FzcIlg90Z?=
 =?us-ascii?Q?knTV1HOpAGULaH1XrXRqUN/TARH+rKOzZkTP9LZdo2XBIrb/HCdEIWOuA0lQ?=
 =?us-ascii?Q?/W8nJVIVeOs4QmLDuCRkGX4wo5uVO0+PPK9olCSbwK3EZDZ6T64pHfHSE70v?=
 =?us-ascii?Q?nv8PKe5a3CqISmVcdtUZdPBnHLg0K6NNPk4YqbQ3gH/j5qU8cmN7d1efgOFJ?=
 =?us-ascii?Q?hhEIWgLFwP5T6+oxxbxqwSPfdrvThu5Hbr1x/0BPJszQBZfk6ATrODEFQQNM?=
 =?us-ascii?Q?Wjbbdmm7K3PK3ttNrTaTH1CGXGbcfa0ihy8Us4I/MioGqKRlyVyupDa11VHV?=
 =?us-ascii?Q?PKnbm1ua4oBYuLEuPsasUw7lDXHITMQSuA/K/E9IKQIZvN3jDNMoE9bCFL+a?=
 =?us-ascii?Q?1R4mYad3UrsxqAfTeQpKNz1yXMkK4K9jfd8UzKz9WDGOgdhKVNGH/andIMy+?=
 =?us-ascii?Q?DO1Q/F1ZHUEEPRSK+mi74pamPdVY8eCYLQswH6bemlw4yUYt16nEzT+f5g7z?=
 =?us-ascii?Q?HuvQI1cYSaOKRRoDQzTP17zhRurZITo9In3HdgzuC28v4oSOJgXOCs5mhmk0?=
 =?us-ascii?Q?spMOIGlf+Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e7ec19-c70a-47f4-f159-08de70bea236
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 20:28:40.3066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZILNz6zhkq4iWZzAnIIhMfhO6r4/jUovbIsOL0YNHwhczzXFAbrGoweQKLIzyfyvyG8sXN2hUqI9wyOZw9F3EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6787
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8997-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sifive.com:email,nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1009816AA57
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 03:43:55AM +0800, Max Hsu wrote:
> Fix NULL pointer dereferences in both the error and done tasklets that
> can occur due to race conditions during channel termination or completion.
>
> Both tasklets (sf_pdma_errbh_tasklet and sf_pdma_donebh_tasklet)
> dereference chan->desc without checking if it's NULL. However,
> chan->desc can be NULL in legitimate scenarios:
>
> 1. During sf_pdma_terminate_all(): The function sets chan->desc = NULL
>    while holding vchan.lock, but interrupts for previously submitted
>    transactions could fire after the lock is released, before the
>    hardware is fully quiesced. These interrupts can schedule tasklets
>    that will run with chan->desc = NULL.
>
> 2. During channel cleanup: Similar race condition during
>    sf_pdma_free_chan_resources().
>
> The fix adds NULL checks at the beginning of both tasklets, protected
> by vchan.lock, using the same lock that terminate_all and
> free_chan_resources use when setting chan->desc = NULL. This ensures
> that either:
> - The descriptor is valid and we can safely process it, or
> - The descriptor was already freed and we safely skip processing
>
> Fixes: 6973886ad58e ("dmaengine: sf-pdma: add platform DMA support for HiFive Unleashed A00")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Hsu <max.hsu@sifive.com>
> ---
>  drivers/dma/sf-pdma/sf-pdma.c | 43 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index ac7d3b127a24..70e4afcda52a 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -298,33 +298,56 @@ static void sf_pdma_free_desc(struct virt_dma_desc *vdesc)
>  static void sf_pdma_donebh_tasklet(struct tasklet_struct *t)
>  {
>  	struct sf_pdma_chan *chan = from_tasklet(chan, t, done_tasklet);
> +	struct sf_pdma_desc *desc;
>  	unsigned long flags;
>
> -	spin_lock_irqsave(&chan->lock, flags);
> -	if (chan->xfer_err) {
> -		chan->retries = MAX_RETRY;
> -		chan->status = DMA_COMPLETE;
> -		chan->xfer_err = false;
> +	spin_lock_irqsave(&chan->vchan.lock, flags);
> +	desc = chan->desc;
> +	if (!desc) {
> +		/*
> +		 * The descriptor was already freed (e.g., by terminate_all
> +		 * or completion on another CPU). Nothing to do.
> +		 */
> +		spin_unlock_irqrestore(&chan->vchan.lock, flags);
> +		return;

suggest use scoped_guard(spin_lock_irqsave)(&chan->lock)

Frank
>  	}
> -	spin_unlock_irqrestore(&chan->lock, flags);
>
> -	spin_lock_irqsave(&chan->vchan.lock, flags);
> -	list_del(&chan->desc->vdesc.node);
> -	vchan_cookie_complete(&chan->desc->vdesc);
> +	list_del(&desc->vdesc.node);
> +	vchan_cookie_complete(&desc->vdesc);
>
>  	chan->desc = sf_pdma_get_first_pending_desc(chan);
>  	if (chan->desc)
>  		sf_pdma_xfer_desc(chan);
>
>  	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> +
> +	spin_lock_irqsave(&chan->lock, flags);
> +	if (chan->xfer_err) {
> +		chan->retries = MAX_RETRY;
> +		chan->status = DMA_COMPLETE;
> +		chan->xfer_err = false;
> +	}
> +	spin_unlock_irqrestore(&chan->lock, flags);
>  }
>
>  static void sf_pdma_errbh_tasklet(struct tasklet_struct *t)
>  {
>  	struct sf_pdma_chan *chan = from_tasklet(chan, t, err_tasklet);
> -	struct sf_pdma_desc *desc = chan->desc;
> +	struct sf_pdma_desc *desc;
>  	unsigned long flags;
>
> +	spin_lock_irqsave(&chan->vchan.lock, flags);
> +	desc = chan->desc;
> +	if (!desc) {
> +		/*
> +		 * The descriptor was already freed (e.g., by terminate_all
> +		 * or completion on another CPU). Nothing to do.
> +		 */
> +		spin_unlock_irqrestore(&chan->vchan.lock, flags);
> +		return;
> +	}
> +	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> +
>  	spin_lock_irqsave(&chan->lock, flags);
>  	if (chan->retries <= 0) {
>  		/* fail to recover */
>
> --
> 2.43.0
>

