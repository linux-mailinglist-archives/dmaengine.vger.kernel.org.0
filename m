Return-Path: <dmaengine+bounces-11152-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hos4Ml8kIWqJ/gAAu9opvQ
	(envelope-from <dmaengine+bounces-11152-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 09:08:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3855763D847
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 09:08:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=e8Q0ID73;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11152-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11152-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A6723028153
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 07:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5F73DD869;
	Thu,  4 Jun 2026 07:08:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020090.outbound.protection.outlook.com [52.101.229.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1833C3DD877;
	Thu,  4 Jun 2026 07:08:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556893; cv=fail; b=bhB9ZZS69WtPmUbRw0anXBry9TcHbFWjIcF4XrwAwpE+ax1goEsKIpIf7Z2r/vJNU58DT0AftDDPm/Su/7ZrEVJ09tdEHSuMjQ3/lKsyUvvuBdzhgNc5SLOQPJVE+iyGQItFYL/32GmPGl82vKGjSWXS1RhkgEfQzj3mJpS2FOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556893; c=relaxed/simple;
	bh=CP/nwzFWQoieuZgJG5Qjr3O+ajkI9E+mYjwVOiZjghU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WfilRKma+wtK4UziXGfGTaCYAebhDHwSsS0JvnsxOK05OCok2AN2GKBzNdaXksd6YD4UJl9taWuJLEoXbKM3NoYgTtdXrhrg33ISYI52GsxRyep9TFnsI4v46cGp1HiHX+M1zgnlSG0EDvWUwcDS3YP9QlG7ZR5DX/6aLGKeauA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=e8Q0ID73; arc=fail smtp.client-ip=52.101.229.90
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T06+UUxBJLsR0PrD7VNXSl9En9uCno54II9C0Ot+Yh5VvPJLpsmKw7L073qI1OiF8deFiBPKWTKh9NHA6NWYIseu+6+XkC4m4kr64+XbYM0TtG1POBhO7Js1Cb5KNqfard/1whDGG/7X9kHrMO/NklJ6i6ORNFlWcYcl66Co9KON7LXJ0AteajeX4OTkHI0ixkXAl4SBV/YD/hYJTPfs1CgM3YtKu10BfBgpL16aSSY2pYNypJDmF/LsRjaAF2uRx+QUtvD1XhzdZYufb/1oj3+4OojcVkmh93S9hub4Z5meew+8TcuOerEdkY3+Uom9A17V4j637mxKuDnR3ypyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oawep1qEMRLGK52fxqx6xeuSnJW6LjD7wtH4/njGwSs=;
 b=i4vI+k7tW4l9wm9Hg/DMaSPZn4Q6uBz4xHfi9rb5h81EauU63Q5ww6+bPUS1yP5aOXYgxJ0G4Pt6FfKan+kWJiwCv5/dpo1mRcGvZwF0n4mesqABx8Ph34SsunvRfBYgoOuLtY516XEbMXQzx1oS6847tWE5CQ6pnoTn2bJx8ohFk5r7C0HBUWGiQdNi607ngNC7k+o1tYVLo+3YBZ03JaGtypxbC5BE6nzoQXO6aXU8S2fGux481rprKRFrQZ0qLZMTFVdisLcDEwIXDe5yZkAM10xSJjn9jMN2goB3xFjz/Y7FB6BmbB7e5BODbMzLKLk7MHaA/iywE6cI8bYliQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oawep1qEMRLGK52fxqx6xeuSnJW6LjD7wtH4/njGwSs=;
 b=e8Q0ID73fOmcPsdOp1Ig1hmHb/TVMdpBXJ6Dwoeo3QzGXB7QStyvB1ZTCtOPBUxuE9YnY68Lzx3jeQu17prfv1S1Ieb1aY2UAueMHP9v/NM4+sa6Crzk5MtvriexBNuC0Z9cBOZmAPR2x6xm9KFTi8s+TZu3JBAW0wM+GaWjom8=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7778.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:34a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 07:08:08 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 07:08:08 +0000
Date: Thu, 4 Jun 2026 16:08:06 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christoph Hellwig <hch@lst.de>, Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH RFT 0/5] dmaengine: dw-edma: support dynamtic add link
 entry during dma engine running
Message-ID: <24a5wo2ncgf7d43mxbv6pacvqkzmiuo4bvuyygfeyoq4lbdt25@kqw4cx7xzrfu>
References: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
X-ClientProxiedBy: TYCP286CA0209.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 42387908-1c79-4b4a-e0e1-08dec20807bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|376014|366016|1800799024|22082099003|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	IQqN66UnYwstyou0I3r9gJDilyFa5J3aioCLooQ+y8P5ne0dA2j/0pwnUnP0FMy+hY36kCBwb/5291vrgjWevq1WQqXlXVWPLyNKj8KSg7RR5vPyFhPspif/7G2axbDAqnEng/m3kOYnHkH2Jk9SYMGg2bn1OqzepR6TW4QhRk0yR68yPpN8ysyl7wJJGlhS7Iu19IQOqO+GY3OxOsOeqWod04xP65OAPvBbuOtjiETJ2ZjYVlmLrvPY4+UPIwdpFiRkwQDle1IaJqKWQCQYLukRUO9U12eWnHuA5IrGVEzghOz5ZsnUemQespGZi2u0FpUbYBAsfKJwdwwurU0QeiZulYDDlulrjlheF+WXNtxDi9vzd/iraYmnunrtgK/X5lHBN5cPXtzsbowUbgLg6xXjnbuIXb9KSjdixSLAGo06cU0hTyMhroAl04ntgizdsOB3q4cWW/JLso3vgAbYkKQpdsyMq1+Wyj4/uOTb0nFXPsrah1JLkM50uNet+3tjE0JtoepEw3EBSdLwWqaJmkIWo+4ZMSOSg+gHnl4aV9Fjtg/7jxLudiyNTKnYlwkzkbX9f+KktCiOGRKldWh2dAuhghuNd/57cFS4vxVZq3eAOqqiCyOt9MDft2K4RnlGacOdeabEbqbQSF9SihAUBUpxg3gTMEQJbYlU6V85z08wNcMIUOIMUXIPop7iv+8cOc8xfKeMfLAcN/aY3Hk0ow==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(376014)(366016)(1800799024)(22082099003)(6133799003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+O2/7qBhpPIA25v+FSZc6k4KjxjbXQi39PbtE7gGjBR68e2BPcZwF0FWuLHS?=
 =?us-ascii?Q?szUGQv+R0yeqsjBIKZHzbr4rwuGqojHdZD5q4qd7OvNq8B6TleAlZis070a6?=
 =?us-ascii?Q?RknUHcTD45PpjP3242p5kZwVCuUEWu9xbtsBnwIyROtXIigPk2DYapHf2wiB?=
 =?us-ascii?Q?+m0Ykq5gS9WYStDw1ynZsXPZdXXlyhz/n9XjORug9Hq/OTRmI9xwikFMZa4q?=
 =?us-ascii?Q?NAKocxaPObBT0ixh/nK9DVMGpj9MPeabfMIs/dy9ByLKA5FXoavKyk+kxbBi?=
 =?us-ascii?Q?5Ft+MBEewnNKNLZv8SADtktEGQo5xyLYkmvPe5UaoJyHKQWgLdDoQzkhOYXp?=
 =?us-ascii?Q?3t1P0KH83yRQ8bObw6m4hjaRK/7aIA1cENZa0uYcgXGk6zfEA3LiDemqQyjP?=
 =?us-ascii?Q?aRWZta4og1Hv6Mya3LxQhNxKnWCmAjRhRwGnAU+1/CdE3GpJVGHFi0uPwjla?=
 =?us-ascii?Q?TXG4BbpDkLNkYVX2pyIpAlByBgdoDDrLx++DEK3zsogOthQtFGUPkCddUTX+?=
 =?us-ascii?Q?O4bxLspUlMvz+lDFPShYKo4UVCCmVjZd+0uq0Z6ZUByMfOpGt8AOHTIt01XN?=
 =?us-ascii?Q?K2nZ3L7iQpUXThwhY7fap4P40qCaZDRHN94MLOIeEpszELqZUG5ADpVn498h?=
 =?us-ascii?Q?TXCJDzlvn/QP2e5CO6BGvvROr1MKeUBZ4tpWzuOm0a4AnyBjfeo+p40h+QZu?=
 =?us-ascii?Q?OOVUJ9WiCU0aIFMsTdnyCcy+vpZM9jK0ypZM4n34KxBqPH6jIVlzTYWFeOa7?=
 =?us-ascii?Q?RXQjY4DUPgOR84K5JZW+Q697ZixCiGmsUk02fuMn0RMlrm4OtcBXC0qDrKdq?=
 =?us-ascii?Q?S+oaogyExPVTdZJHTCNe9lCyFiZFPhQbSvrZ3nauDqMvCJ4C9/v1cdAIyIGJ?=
 =?us-ascii?Q?GD+cUm6kzGQ46W84nj1kBbzSUrj3vgOgKvci0kpppgr7TEKJPBPQ58ll/kuo?=
 =?us-ascii?Q?YsE1DBSmYhhiPpMazlSCFyFCmy6B0CBg4cP+rWpgLo+UiJP4JVyv0kWZoNpF?=
 =?us-ascii?Q?cZoRy09IIcnEt6xZq7ZTcDwohIntOJ7/4Yfw1QnTEHcSYGlAMEYkDeXbgz5/?=
 =?us-ascii?Q?cevE6HzeNTHgyPd20Cj55Trfbb5c+bSeO65BX7xnkozfDsClQDy2eaB+knse?=
 =?us-ascii?Q?O0xDXYpzFAdenZNOT4dpRwCUzS15+JAwlbN4VvuNu755+W02mQpPkdoUvrUm?=
 =?us-ascii?Q?WZ/WDg/SqjwJq4BNjssESFSlqB3bTh6zeXLTURkshtXKs6zqajPj8XJdiwWd?=
 =?us-ascii?Q?VtKPhVRh9E2rkwUoSmff+Sgtwp2LblJJPljsJJwWJ8GPI6pXh9zLdHbkyo3s?=
 =?us-ascii?Q?dlNkvLopMVa9ahCo3k7q4bdwt/BvUion5NWdAK8OPUBh6wCygLKqyXLd0EEs?=
 =?us-ascii?Q?+IPK3AtpSrOPP2QtIvp518lEDLOPmMpsAsNuWFkEGV88l8oJaVnut8P/4cy0?=
 =?us-ascii?Q?7Pbo24AKSJLKfv9YhUhAxok0nMbxywMHh1zz4fNZxI4gWDMOEnUaQb8e4D+q?=
 =?us-ascii?Q?uxweid4oGN4PJNb3HEa61L80nvhb03T0+uBZmgST7IGgfJZVfV7Dou4Saj9c?=
 =?us-ascii?Q?k0csQ2nMm3peYCQTEq+Rr57BV/1BzQfJgALLqS/NUuxfh6PjefW/kwptPl9z?=
 =?us-ascii?Q?Ljwp0uP0rHsSuc3mNKCJ8S8H5A9w1ROdtupG/kQLajDtgWh2UhwOWujsjKGq?=
 =?us-ascii?Q?W3Mpxo7TIWW4t/JWz1TvzUmceJ7B++DEsGlhCCDcCLz51sHy8DhxFhJSD8Z8?=
 =?us-ascii?Q?AEJnij+VecVqwU052w8LpNciOjY1ps562X3Ar6W2S0NfejMaHofq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 42387908-1c79-4b4a-e0e1-08dec20807bf
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 07:08:07.9908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVW3Wbgif9qUInS2E2GDLLmZmyQV5YOHrY06qgMISC5GictcvEJBNrDAFZO8nGuGBiTXtGMaP7OKlbnJJo5CRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7778
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-11152-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@nxp.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:dlemoal@kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kqw4cx7xzrfu:mid,valinux.co.jp:from_mime,valinux.co.jp:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3855763D847

On Fri, Jan 09, 2026 at 03:13:24PM -0500, Frank Li wrote:
> Patch depend on
> https://lore.kernel.org/imx/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com/T/#t
> 
> Only test eDMA, have not tested HDMA.

Hi Frank,

I expect this series may be revisited in the near future, since the first
dependency series reached v7 and looks close to landing.

With the latest versions of the two dependencies:
  - [PATCH v7 0/9] dmaengine: Add new API to combine configuration and descriptor preparation
    https://lore.kernel.org/dmaengine/20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com/
  - [PATCH v2 00/11] dmaengine: dw-edma: flatten desc structions and simple code
    https://lore.kernel.org/dmaengine/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com/

I tested this RFT series with the HDMA engine on a SpacemiT K3.
The test results are below, using the same format as your results:

  Baseline, before applying the three series (v7 + v2 + this RFT)

    Rnd read ,     4KB, QD=1 , 1 job :  IOPS=8567, BW=33.5MiB/s (35.1MB/s)
    Rnd read ,     4KB, QD=32, 1 job :  IOPS=55.5k, BW=217MiB/s (227MB/s)
    Rnd read ,     4KB, QD=32, 4 jobs:  IOPS=83.0k, BW=324MiB/s (340MB/s)
    Rnd read ,   128KB, QD=1 , 1 job :  IOPS=3817, BW=477MiB/s (500MB/s)
    Rnd read ,   128KB, QD=32, 1 job :  IOPS=10.8k, BW=1346MiB/s (1411MB/s)
    Rnd read ,   128KB, QD=32, 4 jobs:  IOPS=11.2k, BW=1403MiB/s (1471MB/s)
    Rnd read ,   512KB, QD=1 , 1 job :  IOPS=1515, BW=758MiB/s (794MB/s)
    Rnd read ,   512KB, QD=32, 1 job :  IOPS=2795, BW=1399MiB/s (1467MB/s)
    Rnd read ,   512KB, QD=32, 4 jobs:  IOPS=2795, BW=1404MiB/s (1472MB/s)
    Rnd write,     4KB, QD=1 , 1 job :  IOPS=9035, BW=35.3MiB/s (37.0MB/s)
    Rnd write,     4KB, QD=32, 1 job :  IOPS=38.3k, BW=149MiB/s (157MB/s)
    Rnd write,     4KB, QD=32, 4 jobs:  IOPS=41.8k, BW=163MiB/s (171MB/s)
    Rnd write,   128KB, QD=1 , 1 job :  IOPS=3969, BW=496MiB/s (520MB/s)
    Rnd write,   128KB, QD=32, 1 job :  IOPS=8260, BW=1033MiB/s (1083MB/s)
    Rnd write,   128KB, QD=32, 4 jobs:  IOPS=8295, BW=1038MiB/s (1089MB/s)
    Seq read ,   128KB, QD=1 , 1 job :  IOPS=4609, BW=576MiB/s (604MB/s)
    Seq read ,   128KB, QD=32, 1 job :  IOPS=10.8k, BW=1345MiB/s (1410MB/s)
    Seq read ,   512KB, QD=1 , 1 job :  IOPS=1524, BW=762MiB/s (799MB/s)
    Seq read ,   512KB, QD=32, 1 job :  IOPS=2799, BW=1401MiB/s (1469MB/s)
    Seq read ,     1MB, QD=32, 1 job :  IOPS=1401, BW=1404MiB/s (1472MB/s)
    Seq write,   128KB, QD=1 , 1 job :  IOPS=3722, BW=465MiB/s (488MB/s)
    Seq write,   128KB, QD=32, 1 job :  IOPS=8246, BW=1031MiB/s (1081MB/s)
    Seq write,   512KB, QD=1 , 1 job :  IOPS=1283, BW=642MiB/s (673MB/s)
    Seq write,   512KB, QD=32, 1 job :  IOPS=2072, BW=1038MiB/s (1088MB/s)
    Seq write,     1MB, QD=32, 1 job :  IOPS=1037, BW=1040MiB/s (1091MB/s)
    Rnd rdwr , 4K..1MB, QD=8 , 4 jobs:  IOPS=1540, BW=768MiB/s (805MB/s)
     IOPS=1549, BW=768MiB/s (805MB/s)

  After your three series (v7 + v2 + this)

    Rnd read ,     4KB, QD=1 , 1 job :  IOPS=7216, BW=28.2MiB/s (29.6MB/s)
    Rnd read ,     4KB, QD=32, 1 job :  IOPS=61.1k, BW=239MiB/s (250MB/s)
    Rnd read ,     4KB, QD=32, 4 jobs:  IOPS=75.3k, BW=294MiB/s (309MB/s)
    Rnd read ,   128KB, QD=1 , 1 job :  IOPS=4711, BW=589MiB/s (618MB/s)
    Rnd read ,   128KB, QD=32, 1 job :  IOPS=10.8k, BW=1354MiB/s (1420MB/s)
    Rnd read ,   128KB, QD=32, 4 jobs:  IOPS=11.2k, BW=1403MiB/s (1471MB/s)
    Rnd read ,   512KB, QD=1 , 1 job :  IOPS=1497, BW=749MiB/s (785MB/s)
    Rnd read ,   512KB, QD=32, 1 job :  IOPS=2802, BW=1403MiB/s (1471MB/s)
    Rnd read ,   512KB, QD=32, 4 jobs:  IOPS=2798, BW=1405MiB/s (1474MB/s)
    Rnd write,     4KB, QD=1 , 1 job :  IOPS=7411, BW=29.0MiB/s (30.4MB/s)
    Rnd write,     4KB, QD=32, 1 job :  IOPS=39.3k, BW=153MiB/s (161MB/s)
    Rnd write,     4KB, QD=32, 4 jobs:  IOPS=42.9k, BW=167MiB/s (176MB/s)
    Rnd write,   128KB, QD=1 , 1 job :  IOPS=3736, BW=467MiB/s (490MB/s)
    Rnd write,   128KB, QD=32, 1 job :  IOPS=8302, BW=1038MiB/s (1089MB/s)
    Rnd write,   128KB, QD=32, 4 jobs:  IOPS=8314, BW=1041MiB/s (1091MB/s)
    Seq read ,   128KB, QD=1 , 1 job :  IOPS=4092, BW=512MiB/s (536MB/s)
    Seq read ,   128KB, QD=32, 1 job :  IOPS=10.8k, BW=1354MiB/s (1420MB/s)
    Seq read ,   512KB, QD=1 , 1 job :  IOPS=1474, BW=737MiB/s (773MB/s)
    Seq read ,   512KB, QD=32, 1 job :  IOPS=2794, BW=1399MiB/s (1467MB/s)
    Seq read ,     1MB, QD=32, 1 job :  IOPS=1401, BW=1404MiB/s (1472MB/s)
    Seq write,   128KB, QD=1 , 1 job :  IOPS=4135, BW=517MiB/s (542MB/s)
    Seq write,   128KB, QD=32, 1 job :  IOPS=8307, BW=1039MiB/s (1089MB/s)
    Seq write,   512KB, QD=1 , 1 job :  IOPS=1259, BW=630MiB/s (660MB/s)
    Seq write,   512KB, QD=32, 1 job :  IOPS=2073, BW=1038MiB/s (1089MB/s)
    Seq write,     1MB, QD=32, 1 job :  IOPS=1034, BW=1038MiB/s (1088MB/s)
    Rnd rdwr , 4K..1MB, QD=8 , 4 jobs:  IOPS=1531, BW=763MiB/s (801MB/s)
     IOPS=1540, BW=765MiB/s (802MB/s)

On this HDMA setup, I did not observe a clear performance difference from
applying the three series alone. Still, I like the overall direction.


P.S.
Separately, as a follow-up experiment, I also prototyped an extra series on top
of your three series that allows us to make use of HDMA watermark interrupts.
With that series, in particular for the high queue-depth cases, the results
improved noticeably on this platform. I haven't posted that series yet though.

  After your three series (v7 + v2 + this) + use of HDMA watermark interrupts

    Rnd read ,     4KB, QD=1 , 1 job :  IOPS=8016, BW=31.3MiB/s (32.8MB/s)
    Rnd read ,     4KB, QD=32, 1 job :  IOPS=63.4k, BW=248MiB/s (260MB/s)
    Rnd read ,     4KB, QD=32, 4 jobs:  IOPS=92.7k, BW=362MiB/s (380MB/s)
    Rnd read ,   128KB, QD=1 , 1 job :  IOPS=3530, BW=441MiB/s (463MB/s)
    Rnd read ,   128KB, QD=32, 1 job :  IOPS=12.0k, BW=1500MiB/s (1573MB/s)
    Rnd read ,   128KB, QD=32, 4 jobs:  IOPS=12.4k, BW=1555MiB/s (1631MB/s)
    Rnd read ,   512KB, QD=1 , 1 job :  IOPS=1541, BW=771MiB/s (808MB/s)
    Rnd read ,   512KB, QD=32, 1 job :  IOPS=3116, BW=1560MiB/s (1636MB/s)
    Rnd read ,   512KB, QD=32, 4 jobs:  IOPS=3099, BW=1556MiB/s (1632MB/s)
    Rnd write,     4KB, QD=1 , 1 job :  IOPS=8748, BW=34.2MiB/s (35.8MB/s)
    Rnd write,     4KB, QD=32, 1 job :  IOPS=57.6k, BW=225MiB/s (236MB/s)
    Rnd write,     4KB, QD=32, 4 jobs:  IOPS=80.3k, BW=314MiB/s (329MB/s)
    Rnd write,   128KB, QD=1 , 1 job :  IOPS=3878, BW=485MiB/s (508MB/s)
    Rnd write,   128KB, QD=32, 1 job :  IOPS=9798, BW=1225MiB/s (1285MB/s)
    Rnd write,   128KB, QD=32, 4 jobs:  IOPS=9970, BW=1248MiB/s (1308MB/s)
    Seq read ,   128KB, QD=1 , 1 job :  IOPS=4516, BW=565MiB/s (592MB/s)
    Seq read ,   128KB, QD=32, 1 job :  IOPS=12.0k, BW=1497MiB/s (1570MB/s)
    Seq read ,   512KB, QD=1 , 1 job :  IOPS=1571, BW=786MiB/s (824MB/s)
    Seq read ,   512KB, QD=32, 1 job :  IOPS=3073, BW=1538MiB/s (1613MB/s)
    Seq read ,     1MB, QD=32, 1 job :  IOPS=1573, BW=1576MiB/s (1653MB/s)
    Seq write,   128KB, QD=1 , 1 job :  IOPS=3977, BW=497MiB/s (521MB/s)
    Seq write,   128KB, QD=32, 1 job :  IOPS=9806, BW=1226MiB/s (1286MB/s)
    Seq write,   512KB, QD=1 , 1 job :  IOPS=1404, BW=702MiB/s (736MB/s)
    Seq write,   512KB, QD=32, 1 job :  IOPS=2496, BW=1250MiB/s (1310MB/s)
    Seq write,     1MB, QD=32, 1 job :  IOPS=1252, BW=1256MiB/s (1317MB/s)
    Rnd rdwr , 4K..1MB, QD=8 , 4 jobs:  IOPS=1682, BW=836MiB/s (877MB/s)
     IOPS=1688, BW=838MiB/s (879MB/s)

Best regards,
Koichiro

> Corn case have not tested, such as pause/resume transfer.
> 
> Before
> 
>   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6780, BW=26.5MiB/s (27.8MB/s)
>   Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
>   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
>   Rnd read,  128KB,  QD=1, 1 job :  IOPS=1188, BW=149MiB/s (156MB/s)
>   Rnd read,  128KB, QD=32, 1 job :  IOPS=1440, BW=180MiB/s (189MB/s)
>   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1282, BW=160MiB/s (168MB/s)
>   Rnd read,  512KB,  QD=1, 1 job :  IOPS=254, BW=127MiB/s (134MB/s)
>   Rnd read,  512KB, QD=32, 1 job :  IOPS=354, BW=177MiB/s (186MB/s)
>   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
>   Rnd write,   4KB,  QD=1, 1 job :  IOPS=6282, BW=24.5MiB/s (25.7MB/s)
>   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.9k, BW=97.5MiB/s (102MB/s)
>   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=27.4k, BW=107MiB/s (112MB/s)
>   Rnd write, 128KB,  QD=1, 1 job :  IOPS=1098, BW=137MiB/s (144MB/s)
>   Rnd write, 128KB, QD=32, 1 job :  IOPS=1195, BW=149MiB/s (157MB/s)
>   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1120, BW=140MiB/s (147MB/s)
>   Seq read,  128KB,  QD=1, 1 job :  IOPS=936, BW=117MiB/s (123MB/s)
>   Seq read,  128KB, QD=32, 1 job :  IOPS=1218, BW=152MiB/s (160MB/s)
>   Seq read,  512KB,  QD=1, 1 job :  IOPS=301, BW=151MiB/s (158MB/s)
>   Seq read,  512KB, QD=32, 1 job :  IOPS=360, BW=180MiB/s (189MB/s)
>   Seq read,    1MB, QD=32, 1 job :  IOPS=193, BW=194MiB/s (203MB/s)
>   Seq write, 128KB,  QD=1, 1 job :  IOPS=796, BW=99.5MiB/s (104MB/s)
>   Seq write, 128KB, QD=32, 1 job :  IOPS=1019, BW=127MiB/s (134MB/s)
>   Seq write, 512KB,  QD=1, 1 job :  IOPS=213, BW=107MiB/s (112MB/s)
>   Seq write, 512KB, QD=32, 1 job :  IOPS=273, BW=137MiB/s (143MB/s)
>   Seq write,   1MB, QD=32, 1 job :  IOPS=168, BW=168MiB/s (177MB/s)
>   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=255, BW=128MiB/s (134MB/s)
>    IOPS=266, BW=135MiB/s (141MB/s)
> 
> After
> 
>   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6148, BW=24.0MiB/s (25.2MB/s)
>   Rnd read,    4KB, QD=32, 1 job :  IOPS=29.4k, BW=115MiB/s (121MB/s)
>   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=38.8k, BW=151MiB/s (159MB/s)
>   Rnd read,  128KB,  QD=1, 1 job :  IOPS=859, BW=107MiB/s (113MB/s)
>   Rnd read,  128KB, QD=32, 1 job :  IOPS=1504, BW=188MiB/s (197MB/s)
>   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1531, BW=191MiB/s (201MB/s)
>   Rnd read,  512KB,  QD=1, 1 job :  IOPS=238, BW=119MiB/s (125MB/s)
>   Rnd read,  512KB, QD=32, 1 job :  IOPS=390, BW=195MiB/s (205MB/s)
>   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=404, BW=202MiB/s (212MB/s)
>   Rnd write,   4KB,  QD=1, 1 job :  IOPS=5801, BW=22.7MiB/s (23.8MB/s)
>   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.6MiB/s (101MB/s)
>   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=32.7k, BW=128MiB/s (134MB/s)
>   Rnd write, 128KB,  QD=1, 1 job :  IOPS=744, BW=93.1MiB/s (97.6MB/s)
>   Rnd write, 128KB, QD=32, 1 job :  IOPS=1278, BW=160MiB/s (168MB/s)
>   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1278, BW=160MiB/s (168MB/s)
>   Seq read,  128KB,  QD=1, 1 job :  IOPS=853, BW=107MiB/s (112MB/s)
>   Seq read,  128KB, QD=32, 1 job :  IOPS=1511, BW=189MiB/s (198MB/s)
>   Seq read,  512KB,  QD=1, 1 job :  IOPS=240, BW=120MiB/s (126MB/s)
>   Seq read,  512KB, QD=32, 1 job :  IOPS=386, BW=193MiB/s (203MB/s)
>   Seq read,    1MB, QD=32, 1 job :  IOPS=200, BW=201MiB/s (211MB/s)
>   Seq write, 128KB,  QD=1, 1 job :  IOPS=749, BW=93.7MiB/s (98.3MB/s)
>   Seq write, 128KB, QD=32, 1 job :  IOPS=1266, BW=158MiB/s (166MB/s)
>   Seq write, 512KB,  QD=1, 1 job :  IOPS=198, BW=99.0MiB/s (104MB/s)
>   Seq write, 512KB, QD=32, 1 job :  IOPS=352, BW=176MiB/s (185MB/s)
>   Seq write,   1MB, QD=32, 1 job :  IOPS=184, BW=184MiB/s (193MB/s)
>   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=287, BW=145MiB/s (152MB/s)
>  IOPS=299, BW=149MiB/s (156MB/s)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Frank Li (5):
>       dmaengine: dw-edma: Add dw_edma_core_ll_cur_idx() to get completed link entry pos
>       dmaengine: dw-edma: Move dw_hdma_set_callback_result() up
>       dmaengine: dw-edma: Make DMA link list work as a circular buffer
>       dmaengine: dw-edma: Dynamitc append new request during dmaengine running
>       dmaengine: dw-edma: Add trace support
> 
>  drivers/dma/dw-edma/Makefile          |   3 +
>  drivers/dma/dw-edma/dw-edma-core.c    | 215 ++++++++++++++++++++++++----------
>  drivers/dma/dw-edma/dw-edma-core.h    |  42 ++++++-
>  drivers/dma/dw-edma/dw-edma-trace.c   |   4 +
>  drivers/dma/dw-edma/dw-edma-trace.h   | 150 ++++++++++++++++++++++++
>  drivers/dma/dw-edma/dw-edma-v0-core.c |  39 +++++-
>  drivers/dma/dw-edma/dw-hdma-v0-core.c |  17 +++
>  7 files changed, 409 insertions(+), 61 deletions(-)
> ---
> base-commit: 020f6d8442f35105660a29d0d236d3f8650c8142
> change-id: 20251212-edma_dymatic-a57843ff0dfe
> 
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
> 

