Return-Path: <dmaengine+bounces-8853-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHXhGcQHimluFQAAu9opvQ
	(envelope-from <dmaengine+bounces-8853-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 17:13:56 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C1111260B
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 17:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFAA13013A5D
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 16:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9473806D8;
	Mon,  9 Feb 2026 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A4+M+Pg+"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013071.outbound.protection.outlook.com [52.101.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BDF3806B2;
	Mon,  9 Feb 2026 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770653633; cv=fail; b=dfhS//xr64kOyrV8E1y7SUJBg5wWrywnQ0mwawinzR6d0TXkdpwV+f++1o2ZXxD5fpoH0fFWwfE2gy4OMaxWUd4kztQm4U5Sy68cDgZPL93A/JCUpnGUShD4dGit2vi5r8JIZEBUCU9kg2ndL6rbGVuYNh70BosIljs7y6QUo8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770653633; c=relaxed/simple;
	bh=xHCRqET5ELhYlkT12CRlSDku/FSdOuk3eQ2v8BYkDSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nYLbp0ebmUswu7FJ40cZCUx9ZXaukMyGNswfc1zJ89pOWZ9v+BslxIeJ9tm92sOuwNNBWGmTLagTU8JIt56l/SdT6OBQwikcsJgiftzMwY9mgboV0HqVrVPj380zwaMlYAqieDItRjNzg5uI1vtj6nuhGJkw0Acz1KT9GQ7Cwkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A4+M+Pg+; arc=fail smtp.client-ip=52.101.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvV7uouHZrZShwe/LsHPOV/AeCgrR9F/fgbW0za+RSES8UtiIKYCeglULBMIUakmh6bB4wpLTmH24EiE/ZCCIp8jN/RScAkxDTYTZ60t1WIYM4Ns0bPc5FuWp7QVd0YjuH/w+5hCxCxnCQIZsoyoQdCizCMroPjtqtZjjh6NteGsv5IKsED64a5JTM1FJ3qhV2N6ShM4VDXj20tD+tCD4di2rn22yFlxMrdgrajM9hxUHeY6lD1gRoecderF2GJF8VyrXyWONT+vWn08wGHOcpU22F42gwKsSes/VBFYdM2+45A7MQYm0UGiQQbIaI2SDF3lv9on0wCmxXpvjn13Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wD9dN7jr7gbljHzyPNpfjroGONPjCsK9VBhFRtZR/AA=;
 b=Ik02yfRlAlKNZ08tZa650XqLhPDP6Zy/H0DaD5M5xJVfzyug4O2aEYZpt5Y1jYdmMqXC1mawtDFmGIBxTX+/qJEAqIPeEKuCg0geCa26tkV9iU1XgQCchO52v06GtZRVMl6S+Ncl41czI6dpN06omVkh1+14SUDPtU/sS9XQGAr78/8iOeIdLo1FGQWWB7GBQF+cROnZNFqQYCqvsnnI31nCHlZwSeVDGxWddLIqLm+QeYXkZo9u4yg9Gp7cHO0C7HT/LKJ33zR8BMZCT9ajgb5BC9fynGbIES8n+K0dTNKn9PYlxIY9vx26LOhakHyiAOIwXCtcu6TuEwhjKTFmig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wD9dN7jr7gbljHzyPNpfjroGONPjCsK9VBhFRtZR/AA=;
 b=A4+M+Pg+z8HPTM2lqBjhHYQoPKa/OF6gLzTbULFaYRRTLUzT9HewNQ7eCDPZ8qr+KmoQRxUsVDkchxFOBDExjQBmYs0FDuc6Ah5Cm1XkFbdkLaJc0Cepq8yzVmDIhuBEbuQzqBTKseUXKVUkTJeexGYl/+ui8G+VWNJgFAZNCZ9aoWqzXmNhoAtvJjxuUN4Yfhajc6sSoC8d23ZZhchXNRZDMVvLWiJymKxT/GIU9EstfeYS8YdYcv5/5eLtHxLxEWKM0x1pQz2P4DStlDH9XKJ5jgYmISLMnnJ5PSg6paTB4MAkBIZ6CXj8Zfxz7wHlFU3vAgg3yepvYPKvuIL9yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB11532.eurprd04.prod.outlook.com (2603:10a6:102:4e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 16:13:50 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 16:13:50 +0000
Date: Mon, 9 Feb 2026 11:13:40 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, cassel@kernel.org,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, kishon@kernel.org,
	jdmason@kudzu.us, allenbh@gmail.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/8] dmaengine: dw-edma: Cache per-channel IRQ and
 emulation doorbell offset
Message-ID: <aYoHtP5dsEHQEm7c@lizhi-Precision-Tower-5810>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <20260209125316.2132589-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209125316.2132589-3-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:a03:338::26) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB11532:EE_
X-MS-Office365-Filtering-Correlation-Id: 909fa51e-4089-4028-a9ef-08de67f6361d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|7416014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZHfEh2PuNBtqNgnG9A03dzDUHYZyivaKKoUv3T60gebY5kU9OIXG03oWhmd0?=
 =?us-ascii?Q?E5UQnQEU6fEvYmmw6HdZfQr6relGltj/vBOA4I6Lcs3M3VmCqoEslUamSKzn?=
 =?us-ascii?Q?6Nu0TTK2kXTonVFuXSiLbpFag3/14hORjXjbBJzFgI+74pHuByS1UAMHIIZO?=
 =?us-ascii?Q?sWqEvUDulaCirDPVuXPcI7pBHK+WJjWF9pETskoZmIrM8kjWQANNO0vV3mZL?=
 =?us-ascii?Q?imF1mh5bwgPRMd2J9p2X4ySK7PtVsIaM4luPDgidXAhRo3C3o/Egd46lIsh6?=
 =?us-ascii?Q?VqNn4/PlP1pN9a7pCbTi/P8ct5vDO8P2V2q9QoJ7Iq/cLy0e7KKA1DDpfRhz?=
 =?us-ascii?Q?PPPGM73A/GpVK1XGo4yTf7i8fTHgzkgNcWwZ+5TqAsb+Jlxq/2MpIstmDWKb?=
 =?us-ascii?Q?oDcUpanYeVCDwLxNfbwGABi3H2OrSY5W0XXYoFemaYU5eh+yqsaCjyvu+ail?=
 =?us-ascii?Q?v94lufpofuwe1G7qvLX4uyhIcCTs3ysFfYHOvjLZGdP4SPV6mTZAGNU8s1GI?=
 =?us-ascii?Q?Jj3gECNmYqkpbS5yxbwIdkje6KsfWyR9Y6FX00kYQztH3olPxl5RzJhBELp3?=
 =?us-ascii?Q?CmExdrAA/0eE/GiPMKvXYA/3JGCKb0QxK7DZ3nv1Mj8pLbe4ZEmZZ1eTMPj7?=
 =?us-ascii?Q?6wQ9siWECV1X+/Gh+ZRCSb0abDcGZKoo8ia3t8AlYZ0pCj+VNmFM0u1H1xtw?=
 =?us-ascii?Q?dvmC3TKRCQXzaCWe+ycaNnKmaGuPo0B8yFd7bMj/8TWTDi5kA8cfsg8Bi7tZ?=
 =?us-ascii?Q?tHVLeFipDn8zXUgcDbZUUQ6DclgfDhpPhaPBgqIZ09EIpydp2bdWvWMUBlCQ?=
 =?us-ascii?Q?xCix0j5jPnBfgZXBu9hRLe3+g/X1IB0EZQtMjqVFLoVmZ9PcSVCIYGvBC3uO?=
 =?us-ascii?Q?/NUvE4QadA2lh5eG5ZB/erNtoKuzUBGLWDqRgu1srQ0tPF0PkanykE3S3H29?=
 =?us-ascii?Q?UAcbDd5Nf9W1irnCZcUhCoudZEsDWR4ZZdcCrZP/fmpjx/WIuXY0qbgtjASD?=
 =?us-ascii?Q?TVLzvaB3HTmIoNZ68YuQw/ah6ciApgoO9mWO+u8WVOg7Gss1qxeotjzer0/u?=
 =?us-ascii?Q?zbrDum/cbiumyDLzifrwZ9oR/6I6szEX7Y+GlpW8kodk06OuicTY/Ky5yio7?=
 =?us-ascii?Q?q47fBL/z+QVDEuszscaNFCJlq5HSMyGvweGrtq+RWw+qn1QdE73TWIS6m+RA?=
 =?us-ascii?Q?4A/dNU727snV1MfX/khnBsMjV3ey9QLK2nmJbRvKg9Q/vKBhEzbEhHUpq9Ml?=
 =?us-ascii?Q?B0m4tiOx5GPM+5lh9oEJ9jFHcv2QCrMoLocc+D93zla4JqP0S+FxhmfZdN7j?=
 =?us-ascii?Q?v7GhBtlfGWq4DXoanxgFabUnIF5IsEOeKZ5EAhTFTyaoJnsrGqiM7ctSi1/+?=
 =?us-ascii?Q?IXSqSYpIpuzLQQoLc/aMpJeM4zqgOYvlxIeCTV9lyGswzvXDxMAzwQdXKeDq?=
 =?us-ascii?Q?GOyF6VzgNDWkH+sFqkwqo/mQa6Ja8tLUHuvZU0vdPAMCq8CanOYh2wZ1fSGv?=
 =?us-ascii?Q?qqPlMxMWhdkdBx1cpI0CJEJw77n67MXkCcmbIvgfFxZxSMx0Y3bCncYMVJm3?=
 =?us-ascii?Q?VYNA1h9pNRN6XOjqFO17CHdzUBNCvWWaFPX2S8kUwuw1OqIZhqdocI2PZ5f/?=
 =?us-ascii?Q?3nzmlZ8yAhGMmiuwACmrQBE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(7416014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HTYk33ziAUrvuC3X4VK4IiyiFu7wI+JUmYFshsr4HwbTyfQNQZV6tIWSirDL?=
 =?us-ascii?Q?1aCZYwpgZoc4/HvMzYZIZUID8PW/679RqhtoFoJYGxbQRziK2jQBrEWYeQq3?=
 =?us-ascii?Q?K/2SSvCtrnYT0l2UImq2stxbZQBhBJE0UUI5HEtuGXP1dCqewLFIUKhafwUi?=
 =?us-ascii?Q?GGa4OsDWpzMGY5o9eIm+bv2M6l1/ztBJ+DcgqGP3iZxUI52RCbi1n44HbGvC?=
 =?us-ascii?Q?wV4iuprEL2Ki7nrsXNGhWbLF5oQtrrVtgTc6JDAw5/gK1OsvKik96Kz+utCb?=
 =?us-ascii?Q?SCLhoU5r1q2fymUAJUSwLIuUAIh1L4C1lQFSUA657ugzF/CCy2Ay35urVMmL?=
 =?us-ascii?Q?sxPTSDPhN3CEt3w38GVfyiFyPDo4UHBfTje2n3WuheTWl8TwmtykA1wzGcBz?=
 =?us-ascii?Q?7FezRSNYrmlxPA2UBZFqgFCC72QPYliP1A0OgWdf0ciEqaqM4sX0wXrfgVJ3?=
 =?us-ascii?Q?J/4LDRLIs8LLaozeOYoSooaUBR6zrmkg0U2/GEvRj1722gfW3HFmC9OITMfA?=
 =?us-ascii?Q?TRrvfA0gQAkLPIXYuP5VrHPFShfm9XvfzvHtIz1n51r4+0790XecdFr1QQkz?=
 =?us-ascii?Q?B1jwwJX46WaDSsU5QG6e03/+sa7EU9An9kOtgNpkyVIhGATASrukvp4HCOfT?=
 =?us-ascii?Q?avZ/3NS3FuE7NhyKROtIR6JEXCiQJ7KvbKg6tRtsMp+Z5ZULQR6b7jhfY5ZX?=
 =?us-ascii?Q?uZHXuHfcw/RkoDAOmNo/wmucteTEDic079QUM9F+roQFo+QqV5ox7ZVguXxW?=
 =?us-ascii?Q?r5+uaScvF5IkfiVfiCaLC18Rx7HPEj6wCWTpz7b0PjFZ6kvDU2ygtfX6CITp?=
 =?us-ascii?Q?7c1YFARsUQOz+eoq2SRH4qP0xShnFeweINaTX7ev6S/QyE++L/0sCeOuEyB6?=
 =?us-ascii?Q?/OI20aFVLR8OjoxsFhWFrUcLSek2fEs6yE2e839e2W8z8KxwnzkZMWYvTccm?=
 =?us-ascii?Q?0iAd8urMdW6L1wh5bCUBk9TiGubA6oCXHcm1iF1ZiToPLyubiFIUnHpttZL0?=
 =?us-ascii?Q?2TLaUPqh52prX3B4OwxfK0+O0+R00qIr07OkVvpvEItKg9HZxiBt5pv6ky4R?=
 =?us-ascii?Q?+h/pM2jvv41gZtKCQzjjodJsO2dNf3+PRuTO9aXYv5O6bbhSR3d8hNfqNHFh?=
 =?us-ascii?Q?bfY9ns8OZELaAV/KxzjjRUgHzGTGgPoA43gDHfTjGylvzTTU1vmx3ixqdgqS?=
 =?us-ascii?Q?kR4hpJPWY8w8xixR7TJxptyaMz4YjyXDtgSOQL04eDz0heM2bDZZpJOTQFWb?=
 =?us-ascii?Q?DgGWho8p0zhMeAasnoKmYr+AIK4pkC1cP09ooy3VFYdMc77uFhtMRIw+ptSl?=
 =?us-ascii?Q?XozC/G/QD84bR7r+fA7BNK0b0mQJlRzE+S/eTNSjQXUwFLQrt8Jb1idoVUvA?=
 =?us-ascii?Q?jONf1RYZo+Wcm2ewc9LsodbHCinaB1oTvcpUTATOtFzoHMLgPduUAoZRWNaY?=
 =?us-ascii?Q?aU+/QdcWlYbNEaUb1m8xffC33fi23xiDgX12zclWOMFWA8sk0Q/xFAOzaGCn?=
 =?us-ascii?Q?MIF98dU1hrRGoSchINf/D8jv06HOW6BHHuxvbz2Xu2YSanVYeIp6qCHBNqK0?=
 =?us-ascii?Q?RJwOxqyO1qWRFWwr+j4urDpkRojL5EJMFHMxbspM+KG9vI9H1RDNdcDS0odN?=
 =?us-ascii?Q?s8pyLR11xVWJB/DueOoz/MBtkwtJEi2vAMNCU/aMq7lzlWHPq4t3vABYYaUE?=
 =?us-ascii?Q?P+r1O1OHJjIXBAXyTesX1S8FiTy5wuPgtJLZIpFD5ZISI8UG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909fa51e-4089-4028-a9ef-08de67f6361d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 16:13:50.2305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WlY9aZiWfqiX+ImUnWtW+xofCNutKpVLvbnTuhV1AeNWoQWCnv0zHyGqVye8IlxJ2XRHnp4cP8331blZY0J/Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11532
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8853-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,valinux.co.jp:email]
X-Rspamd-Queue-Id: D7C1111260B
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 09:53:10PM +0900, Koichiro Den wrote:
> Some DesignWare PCIe endpoint controllers integrate a DesignWare
> eDMA/HDMA instance. In remote eDMA use cases (e.g. exposing the eDMA
> MMIO window and per-channel linked-list regions to a peer via BARs),
> consumers need a stable way to discover:
>   - the Linux IRQ number associated with a given channel's interrupt
>     vector,
>   - an offset within the eDMA register window that can be used as an
>     interrupt-emulation doorbell for that channel.
>
> Store the requested Linux IRQ number in struct dw_edma_irq at IRQ
> request time and cache per-channel metadata in struct dw_edma_chip
> (ch_info_wr/rd) during channel setup. Add a core callback, .ch_info(),
> to fill core-specific metadata such as the doorbell register offset;
> implement it for the v0 eDMA core (use rd_int_status as a suitable
> doorbell target) and provide a placeholder for HDMA until the correct
> offset is known.
>
> No functional change for normal DMA operation. This only makes the
> metadata available to controller/platform drivers that need to expose or
> consume eDMA-related resources.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c    |  9 +++++++++
>  drivers/dma/dw-edma/dw-edma-core.h    |  9 +++++++++
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 11 +++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.c |  8 ++++++++
>  include/linux/dma/edma.h              | 17 +++++++++++++++++
>  5 files changed, 54 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index fe131abf1ca3..bd5ff4a4431a 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -760,6 +760,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  {
>  	struct dw_edma_chip *chip = dw->chip;
>  	struct device *dev = chip->dev;
> +	struct dw_edma_ch_info *info;
>  	struct dw_edma_chan *chan;
>  	struct dw_edma_irq *irq;
>  	struct dma_device *dma;
> @@ -779,9 +780,11 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  		if (i < dw->wr_ch_cnt) {
>  			chan->id = i;
>  			chan->dir = EDMA_DIR_WRITE;
> +			info = &chip->ch_info_wr[chan->id];
>  		} else {
>  			chan->id = i - dw->wr_ch_cnt;
>  			chan->dir = EDMA_DIR_READ;
> +			info = &chip->ch_info_rd[chan->id];
>  		}
>
>  		chan->configured = false;
> @@ -807,6 +810,10 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>
>  		irq = &dw->irq[pos];
>
> +		/* cache channel-specific info */
> +		dw_edma_core_ch_info(dw, chan, info);
> +		info->irq = irq->irq;
> +
>  		if (chan->dir == EDMA_DIR_WRITE)
>  			irq->wr_mask |= BIT(chan->id);
>  		else
> @@ -910,6 +917,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  		if (irq_get_msi_desc(irq))
>  			get_cached_msi_msg(irq, &dw->irq[0].msi);
>
> +		dw->irq[0].irq = irq;
>  		dw->nr_irqs = 1;
>  	} else {
>  		/* Distribute IRQs equally among all channels */
> @@ -936,6 +944,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>
>  			if (irq_get_msi_desc(irq))
>  				get_cached_msi_msg(irq, &dw->irq[i].msi);
> +			dw->irq[i].irq = irq;
>  		}
>
>  		dw->nr_irqs = i;
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 50b87b63b581..82f8f3b38752 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -93,6 +93,7 @@ struct dw_edma_irq {
>  	u32				wr_mask;
>  	u32				rd_mask;
>  	struct dw_edma			*dw;
> +	int				irq;
>  };
>
>  struct dw_edma {
> @@ -127,6 +128,7 @@ struct dw_edma_core_ops {
>  	void (*ch_config)(struct dw_edma_chan *chan);
>  	void (*debugfs_on)(struct dw_edma *dw);
>  	void (*ack_emulated_irq)(struct dw_edma *dw);
> +	void (*ch_info)(struct dw_edma_chan *chan, struct dw_edma_ch_info *info);
>  };
>
>  struct dw_edma_sg {
> @@ -216,4 +218,11 @@ static inline int dw_edma_core_ack_emulated_irq(struct dw_edma *dw)
>  	return 0;
>  }
>
> +static inline void
> +dw_edma_core_ch_info(struct dw_edma *dw, struct dw_edma_chan *chan,
> +		     struct dw_edma_ch_info *info)
> +{
> +	dw->core->ch_info(chan, info);
> +}
> +
>  #endif /* _DW_EDMA_CORE_H */
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 82b9c063c10f..0b8d4b6a5e26 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -519,6 +519,16 @@ static void dw_edma_v0_core_ack_emulated_irq(struct dw_edma *dw)
>  	SET_BOTH_32(dw, int_clear, 0);
>  }
>
> +static void dw_edma_v0_core_ch_info(struct dw_edma_chan *chan,
> +				    struct dw_edma_ch_info *info)
> +{
> +	/*
> +	 * rd_int_status is chosen arbitrarily, but wr_int_status would be
> +	 * equally suitable.
> +	 */
> +	info->db_offset = offsetof(struct dw_edma_v0_regs, rd_int_status);
> +}
> +
>  static const struct dw_edma_core_ops dw_edma_v0_core = {
>  	.off = dw_edma_v0_core_off,
>  	.ch_count = dw_edma_v0_core_ch_count,
> @@ -528,6 +538,7 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
>  	.ch_config = dw_edma_v0_core_ch_config,
>  	.debugfs_on = dw_edma_v0_core_debugfs_on,
>  	.ack_emulated_irq = dw_edma_v0_core_ack_emulated_irq,
> +	.ch_info = dw_edma_v0_core_ch_info,
>  };
>
>  void dw_edma_v0_core_register(struct dw_edma *dw)
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index e3f8db4fe909..1076b394c45f 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -283,6 +283,13 @@ static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
>  	dw_hdma_v0_debugfs_on(dw);
>  }
>
> +static void dw_hdma_v0_core_ch_info(struct dw_edma_chan *chan,
> +				    struct dw_edma_ch_info *info)
> +{
> +	/* Implement once the correct offset is known. */
> +	info->db_offset = ~0;
> +}
> +
>  static const struct dw_edma_core_ops dw_hdma_v0_core = {
>  	.off = dw_hdma_v0_core_off,
>  	.ch_count = dw_hdma_v0_core_ch_count,
> @@ -291,6 +298,7 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
>  	.start = dw_hdma_v0_core_start,
>  	.ch_config = dw_hdma_v0_core_ch_config,
>  	.debugfs_on = dw_hdma_v0_core_debugfs_on,
> +	.ch_info = dw_hdma_v0_core_ch_info,
>  };
>
>  void dw_hdma_v0_core_register(struct dw_edma *dw)
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 3080747689f6..921250204a08 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -60,6 +60,19 @@ enum dw_edma_chip_flags {
>  	DW_EDMA_CHIP_LOCAL	= BIT(0),
>  };
>
> +/**
> + * struct dw_edma_ch_info - DW eDMA channel metadata
> + * @irq:	Linux IRQ number used by this channel's interrupt vector
> + * @db_offset:	offset within the eDMA register window that can be used as
> + *		an interrupt-emulation doorbell for this channel
> + */
> +struct dw_edma_ch_info {
> +	int			irq;
> +
> +	/* Fields below are filled in by dw_edma_core_ops->ch_info() */
> +	resource_size_t		db_offset;
> +};
> +
>  /**
>   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
>   * @dev:		 struct device of the eDMA controller
> @@ -96,6 +109,10 @@ struct dw_edma_chip {
>  	struct dw_edma_region	dt_region_wr[EDMA_MAX_WR_CH];
>  	struct dw_edma_region	dt_region_rd[EDMA_MAX_RD_CH];
>
> +	/* cached channel info */
> +	struct dw_edma_ch_info	ch_info_wr[EDMA_MAX_WR_CH];
> +	struct dw_edma_ch_info	ch_info_rd[EDMA_MAX_RD_CH];
> +

suppose this info only used in side dw edma driver, so it should be in
dw_edma.

dw_edma_chip is useful to exchange informaiton between EPC/PCI controller
and dma engine when call dw_edma_probe().

Frand

>  	enum dw_edma_map_format	mf;
>
>  	struct dw_edma		*dw;
> --
> 2.51.0
>

